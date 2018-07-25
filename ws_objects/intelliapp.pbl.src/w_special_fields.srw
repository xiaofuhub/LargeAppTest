$PBExportHeader$w_special_fields.srw
forward
global type w_special_fields from w_popup
end type
type rb_small from radiobutton within w_special_fields
end type
type rb_medium from radiobutton within w_special_fields
end type
type rb_large from radiobutton within w_special_fields
end type
type cbx_bold from checkbox within w_special_fields
end type
type gb_1 from groupbox within w_special_fields
end type
type cb_apply from commandbutton within w_special_fields
end type
type cb_close from commandbutton within w_special_fields
end type
type lb_fields from listbox within w_special_fields
end type
end forward

global type w_special_fields from w_popup
integer x = 1120
integer y = 452
integer width = 667
integer height = 1340
string title = "Special Fields"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
rb_small rb_small
rb_medium rb_medium
rb_large rb_large
cbx_bold cbx_bold
gb_1 gb_1
cb_apply cb_apply
cb_close cb_close
lb_fields lb_fields
end type
global w_special_fields w_special_fields

type variables
olecustomcontrol io_image_edit

String is_object_name
end variables

on w_special_fields.create
int iCurrent
call super::create
this.rb_small=create rb_small
this.rb_medium=create rb_medium
this.rb_large=create rb_large
this.cbx_bold=create cbx_bold
this.gb_1=create gb_1
this.cb_apply=create cb_apply
this.cb_close=create cb_close
this.lb_fields=create lb_fields
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_small
this.Control[iCurrent+2]=this.rb_medium
this.Control[iCurrent+3]=this.rb_large
this.Control[iCurrent+4]=this.cbx_bold
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_apply
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.lb_fields
end on

on w_special_fields.destroy
call super::destroy
destroy(this.rb_small)
destroy(this.rb_medium)
destroy(this.rb_large)
destroy(this.cbx_bold)
destroy(this.gb_1)
destroy(this.cb_apply)
destroy(this.cb_close)
destroy(this.lb_fields)
end on

event open;call super::open;is_object_name = "Label-" + String( today() ) + String( Now())
end event

type rb_small from radiobutton within w_special_fields
integer x = 50
integer y = 880
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

type rb_medium from radiobutton within w_special_fields
integer x = 302
integer y = 880
integer width = 270
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

type rb_large from radiobutton within w_special_fields
integer x = 50
integer y = 988
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

type cbx_bold from checkbox within w_special_fields
integer x = 315
integer y = 984
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

type gb_1 from groupbox within w_special_fields
integer x = 9
integer y = 816
integer width = 640
integer height = 272
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Font"
end type

type cb_apply from commandbutton within w_special_fields
integer x = 78
integer y = 1112
integer width = 247
integer height = 84
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

event clicked;Integer li_font_type
Integer li_app_id
Integer li_field_id
Integer li_page
Integer li_bold
String ls_type

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

//Start Code Change ----06.21.2016 #V152 maha - added trap
ls_type =  lb_fields.SelectedItem() 

//messagebox("",ls_type)

if ls_type = "" then
	messagebox("Special Fields","Please select a Field or click Cancel")
	return
end if
//End Code Change ----06.21.2016

w_train_app.of_add_objects( Upper(ls_type ), li_font_type, li_bold )

Close( Parent )
end event

type cb_close from commandbutton within w_special_fields
integer x = 338
integer y = 1112
integer width = 247
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
boolean cancel = true
end type

event clicked;close(parent)
end event

type lb_fields from listbox within w_special_fields
integer x = 9
integer width = 645
integer height = 796
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
string item[] = {"Todays Date","Current Time","Future Date","Signature","User ID","User Name","User Email","User Street","User Street2","User City","User State","User Zip","User Phone","User Fax"}
borderstyle borderstyle = stylelowered!
end type

