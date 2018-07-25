$PBExportHeader$w_photo_data_pick_color.srw
forward
global type w_photo_data_pick_color from window
end type
type cb_caqn from commandbutton within w_photo_data_pick_color
end type
type cb_ok from commandbutton within w_photo_data_pick_color
end type
type rb_black from radiobutton within w_photo_data_pick_color
end type
type rb_o from radiobutton within w_photo_data_pick_color
end type
type rb_b from radiobutton within w_photo_data_pick_color
end type
type rb_pur from radiobutton within w_photo_data_pick_color
end type
type rb_g from radiobutton within w_photo_data_pick_color
end type
type rb_l from radiobutton within w_photo_data_pick_color
end type
type rb_p from radiobutton within w_photo_data_pick_color
end type
type rb_red from radiobutton within w_photo_data_pick_color
end type
type gb_1 from groupbox within w_photo_data_pick_color
end type
end forward

global type w_photo_data_pick_color from window
integer width = 571
integer height = 1312
boolean titlebar = true
string title = "Pick color"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_caqn cb_caqn
cb_ok cb_ok
rb_black rb_black
rb_o rb_o
rb_b rb_b
rb_pur rb_pur
rb_g rb_g
rb_l rb_l
rb_p rb_p
rb_red rb_red
gb_1 gb_1
end type
global w_photo_data_pick_color w_photo_data_pick_color

type variables
string is_color
long il_rgb = 999999999
end variables

event open; //Start Code Change ----05.10.2017 #V154 maha
il_rgb = message.doubleparm

choose case il_rgb
	case 255
		rb_red.checked = true
	case 128
		rb_o.checked = true
	case 16711680
		rb_b.checked = true
	case 8388608
		rb_pur.checked = true
	case 32768
		rb_g.checked = true
	case  44800
		rb_l.checked = true
	case 16711935
		rb_p.checked = true
	case 0
		rb_black.checked = true
end choose

	
end event

on w_photo_data_pick_color.create
this.cb_caqn=create cb_caqn
this.cb_ok=create cb_ok
this.rb_black=create rb_black
this.rb_o=create rb_o
this.rb_b=create rb_b
this.rb_pur=create rb_pur
this.rb_g=create rb_g
this.rb_l=create rb_l
this.rb_p=create rb_p
this.rb_red=create rb_red
this.gb_1=create gb_1
this.Control[]={this.cb_caqn,&
this.cb_ok,&
this.rb_black,&
this.rb_o,&
this.rb_b,&
this.rb_pur,&
this.rb_g,&
this.rb_l,&
this.rb_p,&
this.rb_red,&
this.gb_1}
end on

on w_photo_data_pick_color.destroy
destroy(this.cb_caqn)
destroy(this.cb_ok)
destroy(this.rb_black)
destroy(this.rb_o)
destroy(this.rb_b)
destroy(this.rb_pur)
destroy(this.rb_g)
destroy(this.rb_l)
destroy(this.rb_p)
destroy(this.rb_red)
destroy(this.gb_1)
end on

type cb_caqn from commandbutton within w_photo_data_pick_color
integer x = 82
integer y = 1076
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,-1)
end event

type cb_ok from commandbutton within w_photo_data_pick_color
integer x = 82
integer y = 952
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ok"
end type

event clicked;if il_rgb = 999999999 then
	closewithreturn(parent,-1)
else
	closewithreturn(parent , il_rgb)
end if
end event

type rb_black from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 724
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32764915
string text = "Black"
end type

event clicked;il_rgb = 0
end event

type rb_o from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 248
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32764915
string text = "Orange"
end type

event clicked;il_rgb = rgb(255,128,0)
end event

event constructor;this.textcolor = rgb(255,128,0)
end event

type rb_b from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 328
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 32764915
string text = "Blue"
end type

event clicked;il_rgb = 16711680
end event

type rb_pur from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 408
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388736
long backcolor = 32764915
string text = "Purple"
end type

event clicked;il_rgb = rgb(128,0,255)
end event

event constructor;this.textcolor = rgb(128,0,255)
end event

type rb_g from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 488
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 65535
long backcolor = 32764915
string text = "Gold"
end type

event clicked;il_rgb = 	1028070	//rgb(228,214,31)
end event

event constructor;this.textcolor = rgb(230,175,15)
end event

type rb_l from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 568
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 32768
long backcolor = 32764915
string text = "Green"
end type

event clicked;il_rgb = 44800
end event

type rb_p from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 648
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711935
long backcolor = 32764915
string text = "Pink"
end type

event clicked;il_rgb = 16711935
end event

type rb_red from radiobutton within w_photo_data_pick_color
integer x = 160
integer y = 168
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 32764915
string text = "Red"
end type

event clicked;il_rgb = 255
end event

type gb_1 from groupbox within w_photo_data_pick_color
integer x = 55
integer y = 80
integer width = 430
integer height = 784
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32764915
string text = "0"
end type

