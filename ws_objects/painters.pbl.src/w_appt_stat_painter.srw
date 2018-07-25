$PBExportHeader$w_appt_stat_painter.srw
forward
global type w_appt_stat_painter from window
end type
type cb_about from commandbutton within w_appt_stat_painter
end type
type cb_close from commandbutton within w_appt_stat_painter
end type
type cb_1 from commandbutton within w_appt_stat_painter
end type
type dw_1 from datawindow within w_appt_stat_painter
end type
end forward

global type w_appt_stat_painter from window
integer x = 1189
integer y = 556
integer width = 4133
integer height = 1844
boolean titlebar = true
string title = "Appointment Status Labels"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_about cb_about
cb_close cb_close
cb_1 cb_1
dw_1 dw_1
end type
global w_appt_stat_painter w_appt_stat_painter

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

on w_appt_stat_painter.create
this.cb_about=create cb_about
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_about,&
this.cb_close,&
this.cb_1,&
this.dw_1}
end on

on w_appt_stat_painter.destroy
destroy(this.cb_about)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_about from commandbutton within w_appt_stat_painter
integer x = 3561
integer y = 20
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;string ls_mes

ls_mes = "This utility is a painter for some of the Appointment Status detail field labels.  Validation can also be set on those fields."
ls_mes+= "~rFor custom fields 1-3, a lookup table can be connected.  The data stored will be the description from the lookup."

messagebox("About",ls_mes)
end event

type cb_close from commandbutton within w_appt_stat_painter
integer x = 3817
integer y = 20
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_appt_stat_painter
integer x = 3305
integer y = 20
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.update()
end event

type dw_1 from datawindow within w_appt_stat_painter
integer y = 128
integer width = 4119
integer height = 1632
integer taborder = 10
string dataobject = "d_affil_stat_painter"
boolean vscrollbar = true
end type

event itemchanged;//Start Code Change ----10.11.2011 #V12 maha - 
if dwo.name = "lookup_field" then
	if data = "Y" then
		this.setitem(row,"lookup_type", "C")
		this.setitem(row,"lookup_field_name", "description")
	else
		//-------------appeon begin----------------------
		//<$>added:long.zhang 01.13.2014
		//<$>reason: Issue with HP's export
		string ls_null
		setNull(ls_null)
		this.setitem(row,"lookup_type", ls_null)
		this.setitem(row,"lookup_field_name", ls_null)
		this.setitem(row,"lookup_code", ls_null)
		//-------------appeon End------------------------
	end if
end if
//Start Code Change ----10.11.2011 
end event

