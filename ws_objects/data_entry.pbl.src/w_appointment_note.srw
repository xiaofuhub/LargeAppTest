$PBExportHeader$w_appointment_note.srw
forward
global type w_appointment_note from window
end type
type cb_add from commandbutton within w_appointment_note
end type
type cb_2 from commandbutton within w_appointment_note
end type
type cb_1 from commandbutton within w_appointment_note
end type
type dw_1 from datawindow within w_appointment_note
end type
end forward

global type w_appointment_note from window
integer x = 315
integer y = 836
integer width = 3058
integer height = 1124
boolean titlebar = true
string title = "Appointment Note"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_add cb_add
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_appointment_note w_appointment_note

on w_appointment_note.create
this.cb_add=create cb_add
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_add,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_appointment_note.destroy
destroy(this.cb_add)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long ll_rec
integer r

ll_rec = message.doubleparm

dw_1.settransobject(sqlca)
r = dw_1.retrieve(ll_rec)

if r = 0 then
	messagebox("Error","You must save the Appointment record before entering a note.")
	close(this)
end if

if w_mdi.of_security_access( 7360 ) =0 then
	dw_1.enabled = false
	cb_add.visible = true
end if
end event

type cb_add from commandbutton within w_appointment_note
boolean visible = false
integer x = 2112
integer y = 904
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add note"
end type

event clicked;string ls_note
string ls_add

openwithparm(w_ai_notes,"")

ls_note = dw_1.getitemstring(1,"appt_note")
ls_add = message.stringparm

if ls_note = "Cancel" then
	return
else
	if len(ls_note) = 0 then 
		ls_note =  ls_add
	else
		ls_note = ls_note  + "~r~n" + ls_add
	end if
end if

 dw_1.setitem(1,"appt_note", ls_note)
end event

type cb_2 from commandbutton within w_appointment_note
integer x = 2757
integer y = 904
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_appointment_note
integer x = 2482
integer y = 904
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;dw_1.update()

close(parent)
end event

type dw_1 from datawindow within w_appointment_note
integer x = 23
integer y = 16
integer width = 2999
integer height = 844
integer taborder = 10
string dataobject = "d_appointment_note"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

