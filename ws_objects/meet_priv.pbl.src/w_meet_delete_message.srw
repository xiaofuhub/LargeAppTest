$PBExportHeader$w_meet_delete_message.srw
forward
global type w_meet_delete_message from window
end type
type st_1 from statictext within w_meet_delete_message
end type
type cb_3 from commandbutton within w_meet_delete_message
end type
type cb_2 from commandbutton within w_meet_delete_message
end type
type cb_1 from commandbutton within w_meet_delete_message
end type
end forward

global type w_meet_delete_message from window
integer width = 1733
integer height = 896
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_meet_delete_message w_meet_delete_message

on w_meet_delete_message.create
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_meet_delete_message.destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//Start Code Change ----07.20.2012 #V12 maha - Created so that an option for deleting the connected meetings could be included.
end event

type st_1 from statictext within w_meet_delete_message
integer x = 146
integer y = 124
integer width = 1422
integer height = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Are you sure you wand to delete the meeting setup?"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_meet_delete_message
integer x = 690
integer y = 672
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_2 from commandbutton within w_meet_delete_message
integer x = 370
integer y = 492
integer width = 978
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Setup AND Connected Meetings"
end type

event clicked;integer res

res = messagebox("Delete","Are you sure you wish to delete the batch setup as well as all the connected meetings?",question!,yesno!,2)

if res = 1 then
	closewithreturn(parent,2)
end if
end event

type cb_1 from commandbutton within w_meet_delete_message
integer x = 370
integer y = 364
integer width = 978
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Setup ONLY"
end type

event clicked;closewithreturn(parent,1)
end event

