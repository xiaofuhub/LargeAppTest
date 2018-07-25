$PBExportHeader$w_cancel_button.srw
$PBExportComments$Cancel Button for w_cancel_retrieval
forward
global type w_cancel_button from w_response
end type
type st_4 from statictext within w_cancel_button
end type
type st_3 from statictext within w_cancel_button
end type
type st_2 from statictext within w_cancel_button
end type
type p_1 from picture within w_cancel_button
end type
type cb_1 from commandbutton within w_cancel_button
end type
type st_count from statictext within w_cancel_button
end type
type st_1 from statictext within w_cancel_button
end type
end forward

global type w_cancel_button from w_response
integer x = 585
integer y = 268
integer width = 1600
integer height = 400
string title = "Hit Cancel Button to Stop Retrieval"
windowtype windowtype = popup!
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
st_4 st_4
st_3 st_3
st_2 st_2
p_1 p_1
cb_1 cb_1
st_count st_count
st_1 st_1
end type
global w_cancel_button w_cancel_button

type variables
powerobject i_po
end variables

on w_cancel_button.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.p_1=create p_1
this.cb_1=create cb_1
this.st_count=create st_count
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_count
this.Control[iCurrent+7]=this.st_1
end on

on w_cancel_button.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.cb_1)
destroy(this.st_count)
destroy(this.st_1)
end on

event open;call super::open;

i_po = Message.PowerObjectParm





end event

event activate;call super::activate;this.of_SetBase(TRUE)
this.inv_base.of_Center()
end event

type st_4 from statictext within w_cancel_button
integer x = 1138
integer y = 44
integer width = 430
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_cancel_button
integer x = 443
integer y = 112
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 74481808
string text = "Percent Done:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_cancel_button
integer x = 837
integer y = 112
integer width = 357
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 74481808
string text = "0"
boolean focusrectangle = false
end type

type p_1 from picture within w_cancel_button
integer x = 18
integer y = 20
integer width = 215
integer height = 184
string picturename = "pbdrcogs.gif"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_cancel_button
integer x = 713
integer y = 196
integer width = 297
integer height = 108
integer taborder = 1
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel "
boolean cancel = true
boolean default = true
end type

event clicked;//Clicked script for cb_cancel


//This will cause the script in the user defined event 
//"cancel_request" to be executed.

i_po.TriggerEvent("cancel_requested")



end event

type st_count from statictext within w_cancel_button
integer x = 832
integer y = 44
integer width = 293
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "0"
end type

type st_1 from statictext within w_cancel_button
integer x = 393
integer y = 44
integer width = 393
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 74481808
string text = "Rows Retrieved:"
alignment alignment = right!
end type

