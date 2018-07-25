$PBExportHeader$w_contract_print.srw
forward
global type w_contract_print from w_response
end type
type st_2 from statictext within w_contract_print
end type
type cb_2 from u_cb within w_contract_print
end type
type cb_1 from u_cb within w_contract_print
end type
type st_1 from statictext within w_contract_print
end type
type rb_4 from u_rb within w_contract_print
end type
type rb_3 from u_rb within w_contract_print
end type
type rb_2 from u_rb within w_contract_print
end type
type rb_1 from u_rb within w_contract_print
end type
type gb_1 from u_gb within w_contract_print
end type
end forward

global type w_contract_print from w_response
integer width = 1413
integer height = 536
long backcolor = 33551856
st_2 st_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_contract_print w_contract_print

type variables


uo_req_image io_req_image 

long il_scan_method
end variables

on w_contract_print.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_contract_print.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

event pfc_postopen;call super::pfc_postopen;




io_req_image = message.powerobjectparm


il_scan_method = 2



end event

type st_2 from statictext within w_contract_print
integer x = 123
integer y = 192
integer width = 1230
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Overwrite all pages in an image file (Set the current Image to History)"
boolean focusrectangle = false
end type

type cb_2 from u_cb within w_contract_print
string tag = "2~t"
integer x = 663
integer y = 344
integer taborder = 30
string text = "&Scan"
end type

event clicked;call super::clicked;

io_req_image.event dynamic ue_scan(il_scan_method )
close(parent)
end event

type cb_1 from u_cb within w_contract_print
integer x = 1033
integer y = 344
integer taborder = 20
string text = "&Cancel"
end type

event clicked;call super::clicked;


close(parent)
end event

type st_1 from statictext within w_contract_print
boolean visible = false
integer x = 69
integer y = 720
integer width = 1262
integer height = 128
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 80263581
string text = "Inserts a page in the existing image file, before the current image page, as specified in the Page property. "
boolean focusrectangle = false
end type

type rb_4 from u_rb within w_contract_print
string tag = "6"
integer x = 27
integer y = 180
integer width = 128
integer height = 104
long backcolor = 33551856
string text = ""
end type

event clicked;call super::clicked;
il_scan_method =  long(this.tag)
end event

type rb_3 from u_rb within w_contract_print
string tag = "4"
boolean visible = false
integer x = 82
integer y = 756
integer width = 1303
integer height = 68
string text = "Overwrite an image file on an existing image page."
end type

event clicked;call super::clicked;
il_scan_method =  long(this.tag)
end event

type rb_2 from u_rb within w_contract_print
string tag = "3"
integer x = 69
integer y = 708
integer width = 110
integer height = 92
string text = ""
end type

event clicked;call super::clicked;
il_scan_method =  long(this.tag)
end event

type rb_1 from u_rb within w_contract_print
string tag = "2"
integer x = 32
integer y = 100
integer width = 1202
integer height = 68
long backcolor = 33551856
string text = "Append Page(s)  to an existing image file"
boolean checked = true
end type

event clicked;call super::clicked;

il_scan_method =  long(this.tag)
end event

type gb_1 from u_gb within w_contract_print
integer width = 1394
integer height = 332
integer taborder = 10
long backcolor = 33551856
string text = "Scan Options"
end type

