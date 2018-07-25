$PBExportHeader$w_arrangemode.srw
forward
global type w_arrangemode from w_response
end type
type cb_1 from commandbutton within w_arrangemode
end type
type cb_cancel from commandbutton within w_arrangemode
end type
type cb_ok from commandbutton within w_arrangemode
end type
type rb_duedate from radiobutton within w_arrangemode
end type
type rb_startdate from radiobutton within w_arrangemode
end type
type gb_arrangeby from groupbox within w_arrangemode
end type
end forward

global type w_arrangemode from w_response
integer width = 1216
integer height = 472
string title = "Arrange Mode"
cb_1 cb_1
cb_cancel cb_cancel
cb_ok cb_ok
rb_duedate rb_duedate
rb_startdate rb_startdate
gb_arrangeby gb_arrangeby
end type
global w_arrangemode w_arrangemode

on w_arrangemode.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.rb_duedate=create rb_duedate
this.rb_startdate=create rb_startdate
this.gb_arrangeby=create gb_arrangeby
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.rb_duedate
this.Control[iCurrent+5]=this.rb_startdate
this.Control[iCurrent+6]=this.gb_arrangeby
end on

on w_arrangemode.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.rb_duedate)
destroy(this.rb_startdate)
destroy(this.gb_arrangeby)
end on

event open;call super::open;long	ll_Mode

ll_Mode = long(gnv_data.of_GetItem("icred_settings","CalArrangeMode",false))
if ll_Mode = 0 then
	rb_StartDate.Checked = true
else
	rb_DueDate.Checked = true
end if

if AppeonGetClientType() = "WEB" then This.Resize(This.Width + 18,This.Height + 20)

end event

type cb_1 from commandbutton within w_arrangemode
integer x = 37
integer y = 264
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
boolean default = true
end type

event clicked;MessageBox("Help","This function is used to select the Action Item Date (Start Date or Due Date) that you want to base calendar entries on.")
end event

type cb_cancel from commandbutton within w_arrangemode
integer x = 823
integer y = 264
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"")

end event

type cb_ok from commandbutton within w_arrangemode
integer x = 453
integer y = 264
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;long	ll_RtnVal

if rb_StartDate.Checked then
	ll_RtnVal = 0
else
	ll_RtnVal = 1
end if

UPDATE icred_settings SET CalArrangeMode = :ll_RtnVal;
gnv_data.of_Retrieve("icred_settings")

CloseWithReturn(Parent,"OK")

end event

type rb_duedate from radiobutton within w_arrangemode
integer x = 635
integer y = 104
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Due Date"
end type

type rb_startdate from radiobutton within w_arrangemode
integer x = 137
integer y = 104
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start Date"
end type

type gb_arrangeby from groupbox within w_arrangemode
integer x = 37
integer y = 12
integer width = 1129
integer height = 212
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Arrange By"
end type

