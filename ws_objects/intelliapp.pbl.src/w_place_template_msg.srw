$PBExportHeader$w_place_template_msg.srw
forward
global type w_place_template_msg from w_popup
end type
type st_msg from statictext within w_place_template_msg
end type
type st_fld from statictext within w_place_template_msg
end type
type cb_skip from commandbutton within w_place_template_msg
end type
type ddlb_font from dropdownlistbox within w_place_template_msg
end type
type st_font from statictext within w_place_template_msg
end type
type st_rec from statictext within w_place_template_msg
end type
type em_rec from editmask within w_place_template_msg
end type
type cbx_all from checkbox within w_place_template_msg
end type
type st_click from statictext within w_place_template_msg
end type
type st_template from statictext within w_place_template_msg
end type
type cb_skip_temp from commandbutton within w_place_template_msg
end type
type cb_yes from commandbutton within w_place_template_msg
end type
type cb_no from commandbutton within w_place_template_msg
end type
type cb_pause from commandbutton within w_place_template_msg
end type
end forward

global type w_place_template_msg from w_popup
integer x = 18
integer y = 332
integer width = 3602
integer height = 272
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
st_msg st_msg
st_fld st_fld
cb_skip cb_skip
ddlb_font ddlb_font
st_font st_font
st_rec st_rec
em_rec em_rec
cbx_all cbx_all
st_click st_click
st_template st_template
cb_skip_temp cb_skip_temp
cb_yes cb_yes
cb_no cb_no
cb_pause cb_pause
end type
global w_place_template_msg w_place_template_msg

type variables
Boolean ib_new_rec_quest
Boolean ib_additional_rec = False
Boolean ib_wait_for_click = False
end variables

on w_place_template_msg.create
int iCurrent
call super::create
this.st_msg=create st_msg
this.st_fld=create st_fld
this.cb_skip=create cb_skip
this.ddlb_font=create ddlb_font
this.st_font=create st_font
this.st_rec=create st_rec
this.em_rec=create em_rec
this.cbx_all=create cbx_all
this.st_click=create st_click
this.st_template=create st_template
this.cb_skip_temp=create cb_skip_temp
this.cb_yes=create cb_yes
this.cb_no=create cb_no
this.cb_pause=create cb_pause
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_msg
this.Control[iCurrent+2]=this.st_fld
this.Control[iCurrent+3]=this.cb_skip
this.Control[iCurrent+4]=this.ddlb_font
this.Control[iCurrent+5]=this.st_font
this.Control[iCurrent+6]=this.st_rec
this.Control[iCurrent+7]=this.em_rec
this.Control[iCurrent+8]=this.cbx_all
this.Control[iCurrent+9]=this.st_click
this.Control[iCurrent+10]=this.st_template
this.Control[iCurrent+11]=this.cb_skip_temp
this.Control[iCurrent+12]=this.cb_yes
this.Control[iCurrent+13]=this.cb_no
this.Control[iCurrent+14]=this.cb_pause
end on

on w_place_template_msg.destroy
call super::destroy
destroy(this.st_msg)
destroy(this.st_fld)
destroy(this.cb_skip)
destroy(this.ddlb_font)
destroy(this.st_font)
destroy(this.st_rec)
destroy(this.em_rec)
destroy(this.cbx_all)
destroy(this.st_click)
destroy(this.st_template)
destroy(this.cb_skip_temp)
destroy(this.cb_yes)
destroy(this.cb_no)
destroy(this.cb_pause)
end on

event close;call super::close;if isvalid(w_templates_v9) then
	w_templates_v9.visible = true
end if

end event

type st_msg from statictext within w_place_template_msg
integer x = 32
integer y = 24
integer width = 1029
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_fld from statictext within w_place_template_msg
integer x = 398
integer y = 112
integer width = 2080
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "dddd"
boolean focusrectangle = false
end type

type cb_skip from commandbutton within w_place_template_msg
integer x = 5
integer y = 8
integer width = 357
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Skip Template"
end type

event clicked;
w_train_app.ib_skip_temp = True
w_train_app.ib_click_position = False
w_templates_v9.of_place_template1()
end event

type ddlb_font from dropdownlistbox within w_place_template_msg
integer x = 2514
integer y = 20
integer width = 270
integer height = 288
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Small","Medium","Large"}
borderstyle borderstyle = stylelowered!
end type

type st_font from statictext within w_place_template_msg
integer x = 2382
integer y = 28
integer width = 128
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Font:"
boolean focusrectangle = false
end type

type st_rec from statictext within w_place_template_msg
integer x = 2821
integer y = 32
integer width = 187
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Rec #:"
boolean focusrectangle = false
end type

type em_rec from editmask within w_place_template_msg
integer x = 2976
integer y = 20
integer width = 169
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean spin = true
double increment = 1
string minmax = "1~~9"
end type

type cbx_all from checkbox within w_place_template_msg
integer x = 3195
integer y = 24
integer width = 347
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Apply to All"
boolean lefttext = true
end type

type st_click from statictext within w_place_template_msg
integer x = 393
integer y = 196
integer width = 1221
integer height = 56
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
string text = "Click on the image to place the field"
boolean focusrectangle = false
end type

type st_template from statictext within w_place_template_msg
integer x = 398
integer y = 16
integer width = 1861
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Placing Template 1 of 6 - Address"
boolean focusrectangle = false
end type

type cb_skip_temp from commandbutton within w_place_template_msg
integer x = 5
integer y = 92
integer width = 357
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Skip Field"
end type

event clicked;
w_train_app.ib_skip = True
w_train_app.ib_click_position = False
w_templates_v9.of_place_template1()
end event

type cb_yes from commandbutton within w_place_template_msg
boolean visible = false
integer x = 2505
integer y = 120
integer width = 357
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Yes"
end type

event clicked;ib_additional_rec = True
ib_wait_for_click  = False

w_templates_v9.of_place_template2()
end event

type cb_no from commandbutton within w_place_template_msg
boolean visible = false
integer x = 2880
integer y = 120
integer width = 357
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "No"
end type

event clicked;ib_additional_rec = False
ib_wait_for_click = False

w_templates_v9.of_place_template2()
end event

type cb_pause from commandbutton within w_place_template_msg
integer x = 5
integer y = 176
integer width = 357
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Pause"
end type

event clicked;
IF This.Text = "Pause" THEN
	w_train_app.ib_pause_temp  = True
	This.Text = "Resume"
ELSE
	w_train_app.ib_pause_temp  = False
	This.Text = "Pause"	
END IF
end event

