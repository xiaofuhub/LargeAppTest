$PBExportHeader$w_lic_update.srw
forward
global type w_lic_update from window
end type
type st_done from statictext within w_lic_update
end type
type st_3 from statictext within w_lic_update
end type
type st_2 from statictext within w_lic_update
end type
type sle_2 from singlelineedit within w_lic_update
end type
type cb_2 from commandbutton within w_lic_update
end type
type sle_1 from singlelineedit within w_lic_update
end type
type st_1 from statictext within w_lic_update
end type
type cb_1 from commandbutton within w_lic_update
end type
end forward

global type w_lic_update from window
integer x = 1189
integer y = 556
integer width = 1161
integer height = 904
boolean titlebar = true
string title = "License Update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
st_done st_done
st_3 st_3
st_2 st_2
sle_2 sle_2
cb_2 cb_2
sle_1 sle_1
st_1 st_1
cb_1 cb_1
end type
global w_lic_update w_lic_update

event timer;//setpointer(arrow!)
st_done.visible = true
beep(1)
//messagebox("Done","Update Complete")
timer(0,this)
end event

on w_lic_update.create
this.st_done=create st_done
this.st_3=create st_3
this.st_2=create st_2
this.sle_2=create sle_2
this.cb_2=create cb_2
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.st_done,&
this.st_3,&
this.st_2,&
this.sle_2,&
this.cb_2,&
this.sle_1,&
this.st_1,&
this.cb_1}
end on

on w_lic_update.destroy
destroy(this.st_done)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_1)
end on

type st_done from statictext within w_lic_update
boolean visible = false
integer x = 155
integer y = 636
integer width = 864
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "License Update Completed."
boolean focusrectangle = false
end type

type st_3 from statictext within w_lic_update
integer x = 78
integer y = 500
integer width = 288
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Passcode:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_lic_update
integer x = 69
integer y = 400
integer width = 677
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Total number of licenses:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_lic_update
integer x = 759
integer y = 380
integer width = 261
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_lic_update
integer x = 795
integer y = 28
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type sle_1 from singlelineedit within w_lic_update
integer x = 375
integer y = 484
integer width = 645
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_lic_update
integer x = 87
integer y = 168
integer width = 1010
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Enter Passcode and total number of licenses, then click run."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_lic_update
integer x = 535
integer y = 28
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;string s
n_cst_datetime lnv

//lnv = create n_cst_datetime

s = upper(sle_1.text)

if LenA(sle_2.text) < 1 then
	messagebox("Code","Please enter Total number of licenses")
	return
end if
if LenA(s) < 1 then
	messagebox("Code","Please enter code")
	return
end if

if s <> "ISG99872" then
		messagebox("Code","Invalid Code")
		return
else
	setpointer(hourglass!)
	//timer(2,parent)
	lnv.of_wait( 3)
	st_done.visible = true
	beep(1)
end if


end event

