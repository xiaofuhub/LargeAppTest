$PBExportHeader$w_special_field_export.srw
forward
global type w_special_field_export from window
end type
type rb_s2 from radiobutton within w_special_field_export
end type
type rb_z from radiobutton within w_special_field_export
end type
type rb_state from radiobutton within w_special_field_export
end type
type rb_p from radiobutton within w_special_field_export
end type
type rb_f from radiobutton within w_special_field_export
end type
type rb_e from radiobutton within w_special_field_export
end type
type rb_c from radiobutton within w_special_field_export
end type
type cb_cancel from commandbutton within w_special_field_export
end type
type cb_1 from commandbutton within w_special_field_export
end type
type rb_s1 from radiobutton within w_special_field_export
end type
type rb_ui from radiobutton within w_special_field_export
end type
type rb_un from radiobutton within w_special_field_export
end type
type rb_t from radiobutton within w_special_field_export
end type
type gb_1 from groupbox within w_special_field_export
end type
end forward

global type w_special_field_export from window
integer width = 741
integer height = 1344
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_s2 rb_s2
rb_z rb_z
rb_state rb_state
rb_p rb_p
rb_f rb_f
rb_e rb_e
rb_c rb_c
cb_cancel cb_cancel
cb_1 cb_1
rb_s1 rb_s1
rb_ui rb_ui
rb_un rb_un
rb_t rb_t
gb_1 gb_1
end type
global w_special_field_export w_special_field_export

on w_special_field_export.create
this.rb_s2=create rb_s2
this.rb_z=create rb_z
this.rb_state=create rb_state
this.rb_p=create rb_p
this.rb_f=create rb_f
this.rb_e=create rb_e
this.rb_c=create rb_c
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.rb_s1=create rb_s1
this.rb_ui=create rb_ui
this.rb_un=create rb_un
this.rb_t=create rb_t
this.gb_1=create gb_1
this.Control[]={this.rb_s2,&
this.rb_z,&
this.rb_state,&
this.rb_p,&
this.rb_f,&
this.rb_e,&
this.rb_c,&
this.cb_cancel,&
this.cb_1,&
this.rb_s1,&
this.rb_ui,&
this.rb_un,&
this.rb_t,&
this.gb_1}
end on

on w_special_field_export.destroy
destroy(this.rb_s2)
destroy(this.rb_z)
destroy(this.rb_state)
destroy(this.rb_p)
destroy(this.rb_f)
destroy(this.rb_e)
destroy(this.rb_c)
destroy(this.cb_cancel)
destroy(this.cb_1)
destroy(this.rb_s1)
destroy(this.rb_ui)
destroy(this.rb_un)
destroy(this.rb_t)
destroy(this.gb_1)
end on

type rb_s2 from radiobutton within w_special_field_export
integer x = 174
integer y = 448
integer width = 379
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "User Street 2"
end type

type rb_z from radiobutton within w_special_field_export
integer x = 174
integer y = 676
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
string text = "User Zip"
end type

type rb_state from radiobutton within w_special_field_export
integer x = 174
integer y = 600
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
string text = "User State"
end type

type rb_p from radiobutton within w_special_field_export
integer x = 174
integer y = 904
integer width = 352
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "User Phone"
end type

type rb_f from radiobutton within w_special_field_export
integer x = 174
integer y = 828
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
string text = "User Fax"
end type

type rb_e from radiobutton within w_special_field_export
integer x = 174
integer y = 752
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
string text = "User Email"
end type

type rb_c from radiobutton within w_special_field_export
integer x = 174
integer y = 524
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
string text = "User City"
end type

type cb_cancel from commandbutton within w_special_field_export
integer x = 183
integer y = 1184
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;//Start Code Change ----11.03.2016 #V153 maha

closewithreturn(parent, "X")
end event

type cb_1 from commandbutton within w_special_field_export
integer x = 183
integer y = 1080
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;//Start Code Change ----01.26.2012 #V12 maha - added
string res

if rb_t.checked then
	res = "T"
elseif rb_ui.checked then
	res = "UI"
elseif rb_un.checked then
	res = "UN"
elseif rb_s1.checked then
	res = "US1"
elseif rb_s2.checked then
	res = "US2"
elseif rb_c.checked then
	res = "UC"
elseif rb_state.checked then
	res = "UST"
elseif rb_z.checked then
	res = "UZ"
elseif rb_e.checked then
	res = "UE"
elseif rb_p.checked then
	res = "UP"
elseif rb_f.checked then
	res = "UF"
else //cancel
	res = "X"
end if

closewithreturn(parent,res)
end event

type rb_s1 from radiobutton within w_special_field_export
integer x = 174
integer y = 372
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
string text = "User Street"
end type

type rb_ui from radiobutton within w_special_field_export
integer x = 174
integer y = 220
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
string text = "User Id"
end type

type rb_un from radiobutton within w_special_field_export
integer x = 174
integer y = 296
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
string text = "User name"
end type

type rb_t from radiobutton within w_special_field_export
integer x = 174
integer y = 144
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
string text = "Todays date"
end type

type gb_1 from groupbox within w_special_field_export
integer x = 64
integer y = 56
integer width = 581
integer height = 964
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Choose Field"
end type

