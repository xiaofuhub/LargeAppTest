$PBExportHeader$w_select_letter.srw
forward
global type w_select_letter from window
end type
type st_2 from statictext within w_select_letter
end type
type st_1 from statictext within w_select_letter
end type
type cb_2 from commandbutton within w_select_letter
end type
type cb_1 from commandbutton within w_select_letter
end type
type dw_1 from datawindow within w_select_letter
end type
end forward

global type w_select_letter from window
integer x = 1038
integer y = 952
integer width = 1641
integer height = 604
windowtype windowtype = response!
long backcolor = 33551856
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_select_letter w_select_letter

type variables
string is_name
end variables

on w_select_letter.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_select_letter.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 08.28.2006 By: LeiWei
//$<reason> Fix a defect.
//dw_1.retrieve()
//---------------------------- APPEON END ----------------------------

dw_1.insertrow(1)
end event

type st_2 from statictext within w_select_letter
integer x = 64
integer y = 28
integer width = 1481
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Letter Name"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_select_letter
integer x = 64
integer y = 212
integer width = 1481
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "The Letter is not selected for this action. Please select."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_select_letter
integer x = 777
integer y = 428
integer width = 261
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_1 from commandbutton within w_select_letter
integer x = 498
integer y = 428
integer width = 261
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;closewithreturn(parent,is_name)
end event

type dw_1 from datawindow within w_select_letter
integer x = 210
integer y = 308
integer width = 1225
integer height = 88
integer taborder = 10
string dataobject = "d_letter_selection"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_name = data

//messagebox("",is_name)
end event

