$PBExportHeader$w_convert_format.srw
forward
global type w_convert_format from w_response
end type
type st_notes from statictext within w_convert_format
end type
type cb_1 from commandbutton within w_convert_format
end type
type rb_tc from radiobutton within w_convert_format
end type
type rb_bw from radiobutton within w_convert_format
end type
type gb_1 from groupbox within w_convert_format
end type
end forward

global type w_convert_format from w_response
integer width = 1970
integer height = 632
string title = "Convert File Format"
boolean controlmenu = false
long backcolor = 33551856
st_notes st_notes
cb_1 cb_1
rb_tc rb_tc
rb_bw rb_bw
gb_1 gb_1
end type
global w_convert_format w_convert_format

type variables
string is_format = "BW"
end variables

on w_convert_format.create
int iCurrent
call super::create
this.st_notes=create st_notes
this.cb_1=create cb_1
this.rb_tc=create rb_tc
this.rb_bw=create rb_bw
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_notes
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.rb_tc
this.Control[iCurrent+4]=this.rb_bw
this.Control[iCurrent+5]=this.gb_1
end on

on w_convert_format.destroy
call super::destroy
destroy(this.st_notes)
destroy(this.cb_1)
destroy(this.rb_tc)
destroy(this.rb_bw)
destroy(this.gb_1)
end on

event open;call super::open;//Start Code Change ----11.08.2016 #V153 maha
integer r

r = message.doubleparm

if r = 2 then  //default to TC
	rb_tc.checked = true
	rb_tc.triggerevent(clicked!)
end if
	
end event

type st_notes from statictext within w_convert_format
integer x = 82
integer y = 196
integer width = 1842
integer height = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Will produce a file that in Black and White at 400 x 400 DPI.  The file will be smaller and clearer.  It will take longer to convert initially but later performance will be improved."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_convert_format
integer x = 736
integer y = 420
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;closewithreturn(parent, is_format)
end event

type rb_tc from radiobutton within w_convert_format
integer x = 1166
integer y = 112
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "True Color"
end type

event clicked;is_format = "TC"

st_notes.text = "Will produce a file that in True Color at 96 x 96 DPI.  The file will be much larger and may lose some clarity.  This is original conversion format."   
end event

type rb_bw from radiobutton within w_convert_format
integer x = 320
integer y = 112
integer width = 466
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Black and White"
boolean checked = true
end type

event clicked;is_format = "BW"

st_notes.text = "Will produce a file that in Black and White at 100 x 100 DPI.  The file will be smaller and clearer.  It will take longer to convert initially but later performance will be improved."
end event

type gb_1 from groupbox within w_convert_format
integer x = 27
integer y = 16
integer width = 1906
integer height = 380
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Conversion Format"
end type

