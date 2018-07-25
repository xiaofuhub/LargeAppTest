$PBExportHeader$w_utl_encrypt.srw
forward
global type w_utl_encrypt from window
end type
type sle_result from singlelineedit within w_utl_encrypt
end type
type rb_m3 from radiobutton within w_utl_encrypt
end type
type st_5 from statictext within w_utl_encrypt
end type
type st_4 from statictext within w_utl_encrypt
end type
type sle_salt from singlelineedit within w_utl_encrypt
end type
type rb_m2 from radiobutton within w_utl_encrypt
end type
type rb_m1 from radiobutton within w_utl_encrypt
end type
type cb_3 from commandbutton within w_utl_encrypt
end type
type st_3 from statictext within w_utl_encrypt
end type
type st_2 from statictext within w_utl_encrypt
end type
type rb_n from radiobutton within w_utl_encrypt
end type
type rb_c from radiobutton within w_utl_encrypt
end type
type st_1 from statictext within w_utl_encrypt
end type
type sle_3 from singlelineedit within w_utl_encrypt
end type
type sle_1 from singlelineedit within w_utl_encrypt
end type
type rb_d from radiobutton within w_utl_encrypt
end type
type rb_i from radiobutton within w_utl_encrypt
end type
type cb_2 from commandbutton within w_utl_encrypt
end type
type sle_enc from singlelineedit within w_utl_encrypt
end type
type cb_1 from commandbutton within w_utl_encrypt
end type
type gb_1 from groupbox within w_utl_encrypt
end type
type gb_3 from groupbox within w_utl_encrypt
end type
type gb_2 from groupbox within w_utl_encrypt
end type
type gb_4 from groupbox within w_utl_encrypt
end type
type ln_1 from line within w_utl_encrypt
end type
end forward

global type w_utl_encrypt from window
integer width = 2075
integer height = 1416
boolean titlebar = true
string title = "Encryption Testing"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
sle_result sle_result
rb_m3 rb_m3
st_5 st_5
st_4 st_4
sle_salt sle_salt
rb_m2 rb_m2
rb_m1 rb_m1
cb_3 cb_3
st_3 st_3
st_2 st_2
rb_n rb_n
rb_c rb_c
st_1 st_1
sle_3 sle_3
sle_1 sle_1
rb_d rb_d
rb_i rb_i
cb_2 cb_2
sle_enc sle_enc
cb_1 cb_1
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
gb_4 gb_4
ln_1 ln_1
end type
global w_utl_encrypt w_utl_encrypt

type variables
n_cst_encrypt invo_encrypt 
integer ii_cnt
end variables

on w_utl_encrypt.create
this.sle_result=create sle_result
this.rb_m3=create rb_m3
this.st_5=create st_5
this.st_4=create st_4
this.sle_salt=create sle_salt
this.rb_m2=create rb_m2
this.rb_m1=create rb_m1
this.cb_3=create cb_3
this.st_3=create st_3
this.st_2=create st_2
this.rb_n=create rb_n
this.rb_c=create rb_c
this.st_1=create st_1
this.sle_3=create sle_3
this.sle_1=create sle_1
this.rb_d=create rb_d
this.rb_i=create rb_i
this.cb_2=create cb_2
this.sle_enc=create sle_enc
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_4=create gb_4
this.ln_1=create ln_1
this.Control[]={this.sle_result,&
this.rb_m3,&
this.st_5,&
this.st_4,&
this.sle_salt,&
this.rb_m2,&
this.rb_m1,&
this.cb_3,&
this.st_3,&
this.st_2,&
this.rb_n,&
this.rb_c,&
this.st_1,&
this.sle_3,&
this.sle_1,&
this.rb_d,&
this.rb_i,&
this.cb_2,&
this.sle_enc,&
this.cb_1,&
this.gb_1,&
this.gb_3,&
this.gb_2,&
this.gb_4,&
this.ln_1}
end on

on w_utl_encrypt.destroy
destroy(this.sle_result)
destroy(this.rb_m3)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_salt)
destroy(this.rb_m2)
destroy(this.rb_m1)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.rb_n)
destroy(this.rb_c)
destroy(this.st_1)
destroy(this.sle_3)
destroy(this.sle_1)
destroy(this.rb_d)
destroy(this.rb_i)
destroy(this.cb_2)
destroy(this.sle_enc)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.ln_1)
end on

type sle_result from singlelineedit within w_utl_encrypt
integer x = 59
integer y = 252
integer width = 1893
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type rb_m3 from radiobutton within w_utl_encrypt
integer x = 818
integer y = 408
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
string text = "Method 3"
end type

type st_5 from statictext within w_utl_encrypt
integer x = 1600
integer y = 80
integer width = 297
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Salt "
boolean focusrectangle = false
end type

type st_4 from statictext within w_utl_encrypt
integer x = 78
integer y = 80
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Value"
boolean focusrectangle = false
end type

type sle_salt from singlelineedit within w_utl_encrypt
integer x = 1531
integer y = 148
integer width = 411
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "A2b3C5d6E8"
borderstyle borderstyle = stylelowered!
end type

type rb_m2 from radiobutton within w_utl_encrypt
integer x = 471
integer y = 408
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
string text = "Method 2"
boolean checked = true
end type

type rb_m1 from radiobutton within w_utl_encrypt
integer x = 96
integer y = 412
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
string text = "Method 1"
end type

type cb_3 from commandbutton within w_utl_encrypt
integer x = 1632
integer y = 380
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(parent)
end event

type st_3 from statictext within w_utl_encrypt
integer x = 498
integer y = 744
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Number"
boolean focusrectangle = false
end type

type st_2 from statictext within w_utl_encrypt
integer x = 101
integer y = 740
integer width = 343
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Character"
boolean focusrectangle = false
end type

type rb_n from radiobutton within w_utl_encrypt
integer x = 992
integer y = 864
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Number"
boolean checked = true
end type

type rb_c from radiobutton within w_utl_encrypt
integer x = 992
integer y = 804
integer width = 320
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Character"
end type

type st_1 from statictext within w_utl_encrypt
integer x = 814
integer y = 972
integer width = 343
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_utl_encrypt
integer x = 101
integer y = 800
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_utl_encrypt
integer x = 494
integer y = 800
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type rb_d from radiobutton within w_utl_encrypt
integer x = 1472
integer y = 808
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
string text = "Decrement"
end type

type rb_i from radiobutton within w_utl_encrypt
integer x = 1472
integer y = 868
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
string text = "Increment"
end type

type cb_2 from commandbutton within w_utl_encrypt
integer x = 809
integer y = 1080
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
end type

event clicked;string s
integer i

if rb_n.checked then
	if rb_i.checked then
		ii_cnt++
	elseif rb_d.checked then
		ii_cnt = ii_cnt - 1
	else
		ii_cnt = integer(sle_1.text)
	end if
	s = CharA(ii_cnt)
	this.text = string(ii_cnt)
else
	i = AscA(sle_3.text)
	s = string(i)
	this.text = MidA(sle_3.text,1,1)
end if

st_1.text = s

end event

type sle_enc from singlelineedit within w_utl_encrypt
integer x = 59
integer y = 144
integer width = 1083
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "123456ABc"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_utl_encrypt
integer x = 1257
integer y = 380
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Encrypt"
end type

event clicked;string ls_salt


choose case  this.text
	case 'Encrypt' 
		//this.text = 'Decrypt'
			if rb_m1.checked then
			   sle_result.text = invo_encrypt.of_encrypt(sle_enc.text )
			elseif rb_m2.checked then
				ls_salt = sle_salt.text
				sle_result.text = invo_encrypt.of_encrypt2(sle_enc.text, ls_salt)
			else
				ls_salt = sle_salt.text
				sle_result.text = invo_encrypt.of_encrypt3(sle_enc.text, ls_salt)
			end if
	case 'Decrypt'
		this.text = 'Encrypt'
		if rb_m1.checked then
			sle_enc.text  = invo_encrypt.of_decrypt( sle_enc.text)
		else
			ls_salt = sle_salt.text
			sle_enc.text  = invo_encrypt.of_decrypt2( sle_enc.text , ls_salt)
		end if
end choose
end event

type gb_1 from groupbox within w_utl_encrypt
integer x = 1422
integer y = 756
integer width = 471
integer height = 188
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Number"
end type

type gb_3 from groupbox within w_utl_encrypt
integer x = 914
integer y = 756
integer width = 480
integer height = 188
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Test"
end type

type gb_2 from groupbox within w_utl_encrypt
integer x = 59
integer y = 664
integer width = 1920
integer height = 592
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "AACII testing"
end type

type gb_4 from groupbox within w_utl_encrypt
integer x = 46
integer y = 356
integer width = 1161
integer height = 136
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Encryption"
end type

type ln_1 from line within w_utl_encrypt
integer linethickness = 4
integer beginx = 32
integer beginy = 616
integer endx = 2025
integer endy = 616
end type

