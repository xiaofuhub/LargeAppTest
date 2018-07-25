$PBExportHeader$w_get_lookup_name.srw
forward
global type w_get_lookup_name from w_response
end type
type st_1 from statictext within w_get_lookup_name
end type
type sle_1 from singlelineedit within w_get_lookup_name
end type
type cb_1 from u_cb within w_get_lookup_name
end type
type gb_1 from groupbox within w_get_lookup_name
end type
type rb_a from radiobutton within w_get_lookup_name
end type
type rb_c from radiobutton within w_get_lookup_name
end type
type cb_2 from commandbutton within w_get_lookup_name
end type
type cb_3 from commandbutton within w_get_lookup_name
end type
end forward

global type w_get_lookup_name from w_response
integer x = 1010
integer y = 676
integer width = 1897
integer height = 532
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
sle_1 sle_1
cb_1 cb_1
gb_1 gb_1
rb_a rb_a
rb_c rb_c
cb_2 cb_2
cb_3 cb_3
end type
global w_get_lookup_name w_get_lookup_name

on w_get_lookup_name.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.gb_1=create gb_1
this.rb_a=create rb_a
this.rb_c=create rb_c
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.rb_a
this.Control[iCurrent+6]=this.rb_c
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_3
end on

on w_get_lookup_name.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.rb_a)
destroy(this.rb_c)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-04-11 By: Wu ZhiJun
//$<reason> Fix a bug
if gb_contract_version then
	rb_c.Checked = true
	rb_a.Enabled = false
end if
//--------------------------- APPEON END -----------------------------

end event

type st_1 from statictext within w_get_lookup_name
integer x = 50
integer y = 28
integer width = 507
integer height = 68
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
string text = "Lookup Name"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_get_lookup_name
integer x = 46
integer y = 100
integer width = 1262
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 35
borderstyle borderstyle = stylelowered!
end type

type cb_1 from u_cb within w_get_lookup_name
integer x = 1518
integer y = 100
integer width = 315
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;String ls_retval

IF trim(sle_1.Text)='' THEN return

if not rb_a.Checked and not rb_c.Checked then //maha 112801
	messagebox("Lookup Type","Please select Address or Code lookup type.")
	return
end if

IF rb_a.Checked THEN
	ls_retval = sle_1.Text + "-" + "A"
ELSE
	ls_retval = sle_1.Text + "-" + "C"	
END IF
CloseWithReturn(Parent, ls_retval )
end event

type gb_1 from groupbox within w_get_lookup_name
integer x = 46
integer y = 224
integer width = 1262
integer height = 192
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 33551856
string text = "Lookup Type"
end type

type rb_a from radiobutton within w_get_lookup_name
integer x = 128
integer y = 304
integer width = 512
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Entity (Address)"
boolean lefttext = true
end type

event clicked;sle_1.Limit = 20
end event

type rb_c from radiobutton within w_get_lookup_name
integer x = 800
integer y = 308
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "List (Code)"
boolean lefttext = true
end type

event clicked;sle_1.Limit = 35
end event

type cb_2 from commandbutton within w_get_lookup_name
integer x = 1518
integer y = 216
integer width = 311
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;messagebox("Lookup Table help"," 1) Enter the name of the table.~n~r2) Select lookup type. ~n~r~n~r Address type is for entity lookups ie. Schools, Hospitals;~n~rCode type is for list items ie. specialties, departments, states. ")
end event

type cb_3 from commandbutton within w_get_lookup_name
integer x = 1513
integer y = 332
integer width = 315
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "Cancel" )
end event

