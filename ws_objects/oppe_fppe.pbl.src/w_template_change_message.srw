$PBExportHeader$w_template_change_message.srw
forward
global type w_template_change_message from window
end type
type st_2 from statictext within w_template_change_message
end type
type cb_3 from commandbutton within w_template_change_message
end type
type cb_2 from commandbutton within w_template_change_message
end type
type cb_1 from commandbutton within w_template_change_message
end type
type st_1 from statictext within w_template_change_message
end type
end forward

global type w_template_change_message from window
integer width = 2578
integer height = 948
boolean titlebar = true
string title = "Changing Process Template"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_template_change_message w_template_change_message

type variables
string is_return = "O"
end variables

event open;//Start Code Change ----06.30.2011 #V11 maha - created for change of templates
end event

event closequery;integer res

res = messagebox("","Are you sure?",question!,yesno!, 2)

if res = 2 then
	return 1
else
	return 0
end if
end event

on w_template_change_message.create
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.st_2,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_template_change_message.destroy
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

type st_2 from statictext within w_template_change_message
integer x = 59
integer y = 252
integer width = 2455
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Do you wish to:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_template_change_message
integer x = 562
integer y = 640
integer width = 1445
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel - Keep the original Process Template"
end type

event clicked;is_return = "O"

closewithreturn(parent,is_return)
end event

type cb_2 from commandbutton within w_template_change_message
integer x = 562
integer y = 504
integer width = 1445
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Keep the Existing Completed Actions for Reference"
end type

event clicked;is_return = "K"

closewithreturn(parent,is_return)
end event

type cb_1 from commandbutton within w_template_change_message
integer x = 562
integer y = 364
integer width = 1445
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete all of the existing Actions"
end type

event clicked;is_return = "D"

closewithreturn(parent,is_return)
end event

type st_1 from statictext within w_template_change_message
integer x = 59
integer y = 88
integer width = 2455
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "You are changing the Process Template, and there are existing actions from the prior Template connected to this record. "
alignment alignment = center!
boolean focusrectangle = false
end type

