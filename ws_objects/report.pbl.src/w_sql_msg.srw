$PBExportHeader$w_sql_msg.srw
forward
global type w_sql_msg from window
end type
type st_1 from statictext within w_sql_msg
end type
type cb_save from commandbutton within w_sql_msg
end type
type st_len from statictext within w_sql_msg
end type
type cb_3 from commandbutton within w_sql_msg
end type
type cb_2 from commandbutton within w_sql_msg
end type
type cb_1 from commandbutton within w_sql_msg
end type
type mle_1 from multilineedit within w_sql_msg
end type
end forward

global type w_sql_msg from window
integer x = 110
integer y = 36
integer width = 3493
integer height = 2340
boolean titlebar = true
string title = "Syntax"
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
st_1 st_1
cb_save cb_save
st_len st_len
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
end type
global w_sql_msg w_sql_msg

event open;string ls_text

ls_text = Message.StringParm

if PosA(ls_text,"@*@") > 0 then
	ls_text = MidA(ls_text,1, LenA(ls_text) -3)
	cb_save.visible = true
end if

mle_1.Text = ls_text
st_len.text = "Length: " + string (LenA(Message.StringParm))

if PosA(Message.StringParm,"IF THIS IS",1) > 0 then
	this.title = 'Invalid Path Information'
end if

//Start Code Change ----08.05.2008 #V85 maha - message from printletter screen.
if PosA(Message.StringParm,"LETTER ERRORS:",1) > 0 then
	this.title = 'Letter Data Errors'
end if
//End Code Change---08.05.2008
end event

on w_sql_msg.create
this.st_1=create st_1
this.cb_save=create cb_save
this.st_len=create st_len
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.Control[]={this.st_1,&
this.cb_save,&
this.st_len,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.mle_1}
end on

on w_sql_msg.destroy
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.st_len)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
end on

type st_1 from statictext within w_sql_msg
integer x = 32
integer y = 2168
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Number of Characters:"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_sql_msg
boolean visible = false
integer x = 549
integer y = 2064
integer width = 453
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;//Start Code Change ----12.16.2009 #V10 maha - change to allow update
string s

s = "@*@" + mle_1.text

closewithreturn(parent,s)

end event

type st_len from statictext within w_sql_msg
integer x = 581
integer y = 2164
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Length"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_sql_msg
boolean visible = false
integer x = 1019
integer y = 2064
integer width = 453
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;long Job

Job = PrintOpen( )
Print(Job, "sql")

mle_1.Print(Job, 1,1)

PrintPage(Job)

PrintClose(Job )
end event

type cb_2 from commandbutton within w_sql_msg
integer x = 27
integer y = 2060
integer width = 507
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Place on Clipboard"
end type

event clicked;clipboard(mle_1.text)
end event

type cb_1 from commandbutton within w_sql_msg
integer x = 1531
integer y = 2068
integer width = 453
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type mle_1 from multilineedit within w_sql_msg
integer width = 3488
integer height = 2024
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
end type

