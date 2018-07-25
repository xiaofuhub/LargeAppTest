$PBExportHeader$w_delete_location_message.srw
forward
global type w_delete_location_message from window
end type
type cb_3 from commandbutton within w_delete_location_message
end type
type cb_2 from commandbutton within w_delete_location_message
end type
type cb_1 from commandbutton within w_delete_location_message
end type
type mle_1 from multilineedit within w_delete_location_message
end type
end forward

global type w_delete_location_message from window
integer width = 2473
integer height = 852
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
end type
global w_delete_location_message w_delete_location_message

type variables
long il_count
end variables

event open;String ls_mes

il_count = message.doubleparm

if il_count > 0 then  //Start Code Change ----11.02.2012 #V12 maha - message cleanup
	ls_mes = "This Location has " + string(il_count) + " Address record(s) connected to it.  What do you wish to do?"
else
	ls_mes = "There are no Provider Address records connected to this Location.  What do you wish to do?"
	cb_2.text = "Delete the Location"
	cb_1.visible = false
end if
	

mle_1.text = ls_mes
end event

on w_delete_location_message.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.mle_1}
end on

on w_delete_location_message.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
end on

type cb_3 from commandbutton within w_delete_location_message
integer x = 215
integer y = 628
integer width = 2057
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel the Delete. "
end type

event clicked;closewithreturn(parent,2)
end event

type cb_2 from commandbutton within w_delete_location_message
integer x = 215
integer y = 496
integer width = 2057
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete the Location record and keep the Addresses records."
end type

event clicked;closewithreturn(parent,1)
end event

type cb_1 from commandbutton within w_delete_location_message
integer x = 215
integer y = 372
integer width = 2057
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete the Location record AND the connected Address records."
end type

event clicked;closewithreturn(parent,3)
end event

type mle_1 from multilineedit within w_delete_location_message
integer x = 128
integer y = 132
integer width = 2231
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "There are Practitioner Address records connected. what do you want to do?"
boolean border = false
end type

