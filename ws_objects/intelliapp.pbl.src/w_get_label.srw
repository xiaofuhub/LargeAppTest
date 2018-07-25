$PBExportHeader$w_get_label.srw
forward
global type w_get_label from w_popup
end type
type st_1 from statictext within w_get_label
end type
type rb_small from radiobutton within w_get_label
end type
type rb_medium from radiobutton within w_get_label
end type
type rb_large from radiobutton within w_get_label
end type
type cbx_bold from checkbox within w_get_label
end type
type gb_1 from groupbox within w_get_label
end type
type cb_apply from commandbutton within w_get_label
end type
type cb_close from commandbutton within w_get_label
end type
type em_label from editmask within w_get_label
end type
end forward

global type w_get_label from w_popup
integer x = 1120
integer y = 452
integer width = 1787
integer height = 472
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 33551856
st_1 st_1
rb_small rb_small
rb_medium rb_medium
rb_large rb_large
cbx_bold cbx_bold
gb_1 gb_1
cb_apply cb_apply
cb_close cb_close
em_label em_label
end type
global w_get_label w_get_label

type variables
olecustomcontrol io_image_edit

String is_object_name
String is_open_from //alfee 06.29.2010
end variables

on w_get_label.create
int iCurrent
call super::create
this.st_1=create st_1
this.rb_small=create rb_small
this.rb_medium=create rb_medium
this.rb_large=create rb_large
this.cbx_bold=create cbx_bold
this.gb_1=create gb_1
this.cb_apply=create cb_apply
this.cb_close=create cb_close
this.em_label=create em_label
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.rb_small
this.Control[iCurrent+3]=this.rb_medium
this.Control[iCurrent+4]=this.rb_large
this.Control[iCurrent+5]=this.cbx_bold
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cb_apply
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.em_label
end on

on w_get_label.destroy
call super::destroy
destroy(this.st_1)
destroy(this.rb_small)
destroy(this.rb_medium)
destroy(this.rb_large)
destroy(this.cbx_bold)
destroy(this.gb_1)
destroy(this.cb_apply)
destroy(this.cb_close)
destroy(this.em_label)
end on

event open;call super::open;
is_open_from = Message.StringParm //alfee 06.29.2010

is_object_name = "Label-" + String( today() ) + String( Now())
end event

type st_1 from statictext within w_get_label
integer x = 27
integer y = 20
integer width = 320
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
string text = "Type Label:"
boolean focusrectangle = false
end type

type rb_small from radiobutton within w_get_label
integer x = 64
integer y = 248
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Small"
end type

type rb_medium from radiobutton within w_get_label
integer x = 320
integer y = 248
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Medium"
boolean checked = true
end type

type rb_large from radiobutton within w_get_label
integer x = 626
integer y = 248
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Large"
end type

type cbx_bold from checkbox within w_get_label
integer x = 1120
integer y = 248
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Bold"
end type

type gb_1 from groupbox within w_get_label
integer x = 32
integer y = 184
integer width = 1376
integer height = 172
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Font Size"
end type

type cb_apply from commandbutton within w_get_label
integer x = 1454
integer y = 80
integer width = 247
integer height = 88
integer taborder = 30
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

event clicked;string s
Integer li_font_type
Integer li_app_id
Integer li_field_id
Integer li_page
Integer li_bold
String ls_type

s = em_label.Text

if s = "" then //maha 060702
	Close( Parent )
	return
end if

if PosA(s,";") > 0 then //maha 031505
	messagebox("Invalid Character","The semicolon (;) cannot be used in label objects.")
	return
end if

IF rb_small.Checked THEN
	li_font_type = 1
ELSEIF rb_medium.Checked THEN
	li_font_type = 2
ELSE
	li_font_type = 3
END IF

IF cbx_bold.Checked THEN
	li_bold = 1
ELSE
	li_bold = 0
END IF

CHOOSE CASE Lower(is_open_from)
	CASE 'train setup' 
		IF IsValid(w_train_app) THEN
			w_train_app.of_add_objects( "LABEL-" + em_label.Text, li_font_type, li_bold )
		END IF
	CASE 'train preview'
		IF IsValid(w_train_app) THEN
			w_train_app.of_preview_add_objects( "LABEL-" + em_label.Text, li_font_type, li_bold )
		END IF
	CASE "preview"
		IF IsValid(w_preview_app) THEN 
			w_preview_app.uo_1.of_create_text("LABEL-" + em_label.Text, li_font_type, li_bold )
		elseif IsValid(w_preview_app_popup)  then     //Start Code Change ----07.18.2016 #V152 maha
			w_preview_app_popup.uo_1.of_create_text("LABEL-" + em_label.Text, li_font_type, li_bold )
		end if
END CHOOSE

Close( Parent )
end event

type cb_close from commandbutton within w_get_label
integer x = 1454
integer y = 212
integer width = 247
integer height = 88
integer taborder = 40
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

event clicked;//w_train_app.tab_1.tabpage_design.p_label.BorderStyle = StyleRaised!
Close( Parent )
end event

type em_label from editmask within w_get_label
integer x = 32
integer y = 84
integer width = 1376
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string minmax = "~~240"
end type

