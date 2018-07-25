$PBExportHeader$w_recruit_pos_delete_mes.srw
forward
global type w_recruit_pos_delete_mes from window
end type
type cb_2 from commandbutton within w_recruit_pos_delete_mes
end type
type cb_1 from commandbutton within w_recruit_pos_delete_mes
end type
type st_count from statictext within w_recruit_pos_delete_mes
end type
end forward

global type w_recruit_pos_delete_mes from window
integer width = 1691
integer height = 704
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_count st_count
end type
global w_recruit_pos_delete_mes w_recruit_pos_delete_mes

type variables
long il_pos
end variables

event open;long cnt
string s

cnt = message.doubleparm

if cnt = 1 then
	s =  "There is " + string(cnt) + " Candidate "
else
	s =  "There are " + string(cnt) + " Candidates "
end if

s+= "connected to this Position.  What do you want to do?"

st_count.text = s
end event

on w_recruit_pos_delete_mes.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_count=create st_count
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_count}
end on

on w_recruit_pos_delete_mes.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_count)
end on

type cb_2 from commandbutton within w_recruit_pos_delete_mes
integer x = 119
integer y = 480
integer width = 1454
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel the Delete"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_1 from commandbutton within w_recruit_pos_delete_mes
integer x = 119
integer y = 340
integer width = 1454
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear the Position value from the Candidate records"
end type

event clicked;closewithreturn(parent,"Clear")
end event

type st_count from statictext within w_recruit_pos_delete_mes
integer x = 87
integer y = 96
integer width = 1509
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "There are XXX Candidiates connected to this Position.  What do you want to do?"
boolean focusrectangle = false
end type

