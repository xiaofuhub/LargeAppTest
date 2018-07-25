$PBExportHeader$w_modify_comm_status.srw
forward
global type w_modify_comm_status from window
end type
type st_2 from statictext within w_modify_comm_status
end type
type st_1 from statictext within w_modify_comm_status
end type
type cb_2 from commandbutton within w_modify_comm_status
end type
type cb_1 from commandbutton within w_modify_comm_status
end type
type rb_3 from radiobutton within w_modify_comm_status
end type
type rb_2 from radiobutton within w_modify_comm_status
end type
type rb_1 from radiobutton within w_modify_comm_status
end type
type gb_1 from groupbox within w_modify_comm_status
end type
end forward

global type w_modify_comm_status from window
integer width = 2007
integer height = 1008
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_modify_comm_status w_modify_comm_status

on w_modify_comm_status.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.gb_1}
end on

on w_modify_comm_status.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

type st_2 from statictext within w_modify_comm_status
integer x = 101
integer y = 20
integer width = 1856
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Changing a committee to Inactive means that as new appointment are added, the inactive committees will not appear in the practitioner folder.  Remaining provider committee records cannot be sent to committee."
boolean focusrectangle = false
end type

type st_1 from statictext within w_modify_comm_status
integer x = 87
integer y = 248
integer width = 1856
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "One or more Provider records are connected to this committee record."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_modify_comm_status
integer x = 1015
integer y = 844
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.22.2011 by Stephen
//////////////////////////////////////////////////////////////////////

closewithreturn(parent, '0')
end event

type cb_1 from commandbutton within w_modify_comm_status
integer x = 645
integer y = 844
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.22.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_ret

ls_ret = '0'
if rb_1.checked then ls_ret = '1'
if rb_2.checked then ls_ret = '2'
if rb_3.checked then ls_ret = '3'

closewithreturn(parent, ls_ret)
end event

type rb_3 from radiobutton within w_modify_comm_status
integer x = 119
integer y = 660
integer width = 1815
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Delete Active/Pending committee records with no Sent or Approved dates"
end type

type rb_2 from radiobutton within w_modify_comm_status
integer x = 119
integer y = 540
integer width = 1810
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Delete All committee records connected to Active/Pending Appointments"
end type

type rb_1 from radiobutton within w_modify_comm_status
integer x = 119
integer y = 424
integer width = 1696
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Leave all existing Provider records"
boolean checked = true
end type

type gb_1 from groupbox within w_modify_comm_status
integer x = 55
integer y = 336
integer width = 1883
integer height = 448
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Update"
end type

