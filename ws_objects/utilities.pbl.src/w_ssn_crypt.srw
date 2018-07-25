$PBExportHeader$w_ssn_crypt.srw
forward
global type w_ssn_crypt from window
end type
type rb_d from radiobutton within w_ssn_crypt
end type
type rb_e from radiobutton within w_ssn_crypt
end type
type dw_1 from datawindow within w_ssn_crypt
end type
type cb_3 from commandbutton within w_ssn_crypt
end type
type cb_1 from commandbutton within w_ssn_crypt
end type
type gb_1 from groupbox within w_ssn_crypt
end type
end forward

global type w_ssn_crypt from window
integer width = 2075
integer height = 1152
boolean titlebar = true
string title = "SSN Encryption"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_d rb_d
rb_e rb_e
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
gb_1 gb_1
end type
global w_ssn_crypt w_ssn_crypt

type variables
n_cst_encrypt invo_encrypt 
integer ii_cnt
end variables

on w_ssn_crypt.create
this.rb_d=create rb_d
this.rb_e=create rb_e
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.rb_d,&
this.rb_e,&
this.dw_1,&
this.cb_3,&
this.cb_1,&
this.gb_1}
end on

on w_ssn_crypt.destroy
destroy(this.rb_d)
destroy(this.rb_e)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.gb_1)
end on

type rb_d from radiobutton within w_ssn_crypt
integer x = 1303
integer y = 352
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Decrypt"
end type

type rb_e from radiobutton within w_ssn_crypt
integer x = 1298
integer y = 284
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
string text = "Encrypt"
boolean checked = true
end type

type dw_1 from datawindow within w_ssn_crypt
integer x = 64
integer y = 24
integer width = 1010
integer height = 948
integer taborder = 20
string title = "none"
string dataobject = "d_ssn_crypt_all"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_3 from commandbutton within w_ssn_crypt
integer x = 1591
integer y = 40
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

type cb_1 from commandbutton within w_ssn_crypt
integer x = 1216
integer y = 40
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;//Start Code Change ----05.06.2010 #V10 maha - added for encruption of ssn
//
integer li_len
integer i
integer li_num[]
integer li_null[]
integer li_skip = 0
integer li_temp
long r
long rc
boolean lb_enc
string ls_ssn
string ls_char[]
string ls_null[]
string ls_ret
string ls_num

rc = dw_1.rowcount()


if rb_e.checked then
	lb_enc = true
else
	lb_enc = false
end if

for r = 1 to rc
	//clear the arrays
	li_num = li_null
	ls_char = ls_null
	li_skip = 0
	ls_ret = ''
	
	//ls_ssn = dw_1.getitemstring(r,"ssn")
	ls_ssn = Trim(dw_1.getitemstring(r,"ssn")) //alfee 05.25.2010
	li_len = LenA(ls_ssn)
	
	if isnull(ls_ssn) or li_len < 1 then continue //trap for no value
	
	if lb_enc and not isnumber(ls_ssn) then continue //for encryption skip if not a number
	if not lb_enc and isnumber(MidA(ls_ssn,1,1)) then continue //for decryption skip if a number
	
	for i = 1 to li_len //get each character and trap for improper data
		ls_char[i] = MidA(ls_ssn,i,1)
		if lb_enc then
			if not isnumber(ls_char[i]) then 
				li_skip = 1
				continue //out of this loop
			else //convert to number and increment for security
				li_num[i] = integer(ls_char[i]) + i
			end if
		else //for decrypt no numbers
			if isnumber(ls_char[i]) then 
				li_skip = 1
				continue //out of this loop
			end if
		end if
	next
	
	for i = 1 to upperbound(ls_char)
		if lb_enc then
			ls_ret = ls_ret + of_get_alpha_letter(li_num[i])
		else
			ls_num = of_num_from_char_ssn(ls_char[i])
			li_temp = integer(ls_num)
			li_temp = li_temp - i
			ls_ret = ls_ret + string(li_temp)
		end if
	next
	
	dw_1.setitem(r,"ssn",ls_ret)
next
	
dw_1.update()
end event

type gb_1 from groupbox within w_ssn_crypt
integer x = 1216
integer y = 204
integer width = 462
integer height = 272
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Function"
end type

