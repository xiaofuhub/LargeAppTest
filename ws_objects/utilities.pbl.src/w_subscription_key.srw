$PBExportHeader$w_subscription_key.srw
forward
global type w_subscription_key from window
end type
type cb_1 from commandbutton within w_subscription_key
end type
type cb_3 from commandbutton within w_subscription_key
end type
type cb_2 from commandbutton within w_subscription_key
end type
type st_3 from statictext within w_subscription_key
end type
type sle_key from singlelineedit within w_subscription_key
end type
type cb_compute from commandbutton within w_subscription_key
end type
type st_2 from statictext within w_subscription_key
end type
type st_1 from statictext within w_subscription_key
end type
type sle_years from singlelineedit within w_subscription_key
end type
type em_date from editmask within w_subscription_key
end type
end forward

global type w_subscription_key from window
integer width = 1175
integer height = 844
boolean titlebar = true
string title = "Subscription utility"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_3 cb_3
cb_2 cb_2
st_3 st_3
sle_key sle_key
cb_compute cb_compute
st_2 st_2
st_1 st_1
sle_years sle_years
em_date em_date
end type
global w_subscription_key w_subscription_key

on w_subscription_key.create
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_3=create st_3
this.sle_key=create sle_key
this.cb_compute=create cb_compute
this.st_2=create st_2
this.st_1=create st_1
this.sle_years=create sle_years
this.em_date=create em_date
this.Control[]={this.cb_1,&
this.cb_3,&
this.cb_2,&
this.st_3,&
this.sle_key,&
this.cb_compute,&
this.st_2,&
this.st_1,&
this.sle_years,&
this.em_date}
end on

on w_subscription_key.destroy
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.sle_key)
destroy(this.cb_compute)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_years)
destroy(this.em_date)
end on

type cb_1 from commandbutton within w_subscription_key
integer x = 745
integer y = 112
integer width = 398
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Sub in db"
end type

event clicked;update ids set pp_s = 0, pp_end = null;
commit using sqlca;

end event

type cb_3 from commandbutton within w_subscription_key
integer x = 754
integer y = 16
integer width = 375
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)

end event

type cb_2 from commandbutton within w_subscription_key
integer x = 384
integer y = 112
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Validate"
end type

event clicked;string s,k
string c[]
integer d[]
integer i, s1, s2, i_year


//debugbreak()
//s = em_date.text
k = sle_key.text

s = of_validate_sub_key(k,"Test")

if len(s) > 1 then
	messagebox("Validation ","Valid Key~r~r" + s )
end if

end event

type st_3 from statictext within w_subscription_key
integer x = 183
integer y = 464
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
string text = "Key"
boolean focusrectangle = false
end type

type sle_key from singlelineedit within w_subscription_key
integer x = 174
integer y = 540
integer width = 731
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_compute from commandbutton within w_subscription_key
integer x = 32
integer y = 112
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Compute"
end type

event clicked;string s,k
string c[]
integer d[]
integer i, z, q, s1, s2, i_year


s = em_date.text

for i = 1 to 10
	c[i] = mid(s,i,1)
	d[i] = integer(c[i])
next

i_year = integer(sle_years.text)
z = 8 - i_year
q = 2 + i_year

s1 = d[10] + d[9] + d[8] + d[7] + z + d[2] + d[1] + q + d[5] + d[4] - 1
s1 = mod(s1,10) 
s2 = q + d[5] + d[4] + s1
s2 = mod(s2,10)

//YYzYYMMqDDcc

k = c[10] + c[9] + string(z) + c[8] + c[7] + c[2] + c[1] + string(q) + c[5] + c[4] + string(s1) + string(s2)


sle_key.text = k


end event

type st_2 from statictext within w_subscription_key
integer x = 585
integer y = 244
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
string text = "Years"
boolean focusrectangle = false
end type

type st_1 from statictext within w_subscription_key
integer x = 155
integer y = 248
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
string text = "End Date"
boolean focusrectangle = false
end type

type sle_years from singlelineedit within w_subscription_key
integer x = 585
integer y = 328
integer width = 178
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type em_date from editmask within w_subscription_key
integer x = 155
integer y = 328
integer width = 352
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
end type

