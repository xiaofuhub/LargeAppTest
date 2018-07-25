$PBExportHeader$w_npdb_error.srw
forward
global type w_npdb_error from window
end type
type cb_save from commandbutton within w_npdb_error
end type
type st_len from statictext within w_npdb_error
end type
type cb_3 from commandbutton within w_npdb_error
end type
type cb_2 from commandbutton within w_npdb_error
end type
type cb_1 from commandbutton within w_npdb_error
end type
type mle_1 from multilineedit within w_npdb_error
end type
end forward

global type w_npdb_error from window
integer x = 110
integer y = 36
integer width = 3493
integer height = 1668
boolean titlebar = true
string title = "Error Message from NPDB"
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_save cb_save
st_len st_len
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
end type
global w_npdb_error w_npdb_error

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

on w_npdb_error.create
this.cb_save=create cb_save
this.st_len=create st_len
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.Control[]={this.cb_save,&
this.st_len,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.mle_1}
end on

on w_npdb_error.destroy
destroy(this.cb_save)
destroy(this.st_len)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
end on

type cb_save from commandbutton within w_npdb_error
boolean visible = false
integer x = 960
integer y = 2156
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

type st_len from statictext within w_npdb_error
boolean visible = false
integer x = 55
integer y = 2172
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Length"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_npdb_error
boolean visible = false
integer x = 901
integer y = 1740
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

type cb_2 from commandbutton within w_npdb_error
integer x = 41
integer y = 1472
integer width = 453
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

type cb_1 from commandbutton within w_npdb_error
integer x = 1413
integer y = 1480
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

type mle_1 from multilineedit within w_npdb_error
integer x = 46
integer y = 24
integer width = 3374
integer height = 1440
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

