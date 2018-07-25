$PBExportHeader$w_duplicate_name.srw
forward
global type w_duplicate_name from window
end type
type cb_2 from commandbutton within w_duplicate_name
end type
type cb_1 from commandbutton within w_duplicate_name
end type
type st_2 from statictext within w_duplicate_name
end type
type st_1 from statictext within w_duplicate_name
end type
end forward

global type w_duplicate_name from window
integer x = 1056
integer y = 484
integer width = 1573
integer height = 700
windowtype windowtype = response!
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
end type
global w_duplicate_name w_duplicate_name

type variables
integer ii_res = 0
end variables

on w_duplicate_name.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1}
end on

on w_duplicate_name.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
end on

event closequery;if ii_res = 0 then
	return 1
else
	return 0
end if

end event

type cb_2 from commandbutton within w_duplicate_name
integer x = 1147
integer y = 452
integer width = 315
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Resave"
end type

event clicked;ii_res = 2

closewithreturn(parent,ii_res)
end event

type cb_1 from commandbutton within w_duplicate_name
integer x = 809
integer y = 452
integer width = 315
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Overwrite"
end type

event clicked;ii_res = 1

closewithreturn(parent,ii_res)
end event

type st_2 from statictext within w_duplicate_name
integer x = 91
integer y = 256
integer width = 1371
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Or click Resave and resave the batch with another name."
boolean focusrectangle = false
end type

type st_1 from statictext within w_duplicate_name
integer x = 91
integer y = 44
integer width = 1371
integer height = 184
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "The batch name selected is already used.  If you wish to overwrite the existing batch click Overwrite.  "
boolean focusrectangle = false
end type

