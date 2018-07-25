$PBExportHeader$w_holiday_de.srw
forward
global type w_holiday_de from window
end type
type dw_days from datawindow within w_holiday_de
end type
type cb_delete from commandbutton within w_holiday_de
end type
type cb_add from commandbutton within w_holiday_de
end type
type cb_close from commandbutton within w_holiday_de
end type
type cb_save from commandbutton within w_holiday_de
end type
end forward

global type w_holiday_de from window
integer width = 1399
integer height = 2296
boolean titlebar = true
string title = "Holidays"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_days dw_days
cb_delete cb_delete
cb_add cb_add
cb_close cb_close
cb_save cb_save
end type
global w_holiday_de w_holiday_de

on w_holiday_de.create
this.dw_days=create dw_days
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_close=create cb_close
this.cb_save=create cb_save
this.Control[]={this.dw_days,&
this.cb_delete,&
this.cb_add,&
this.cb_close,&
this.cb_save}
end on

on w_holiday_de.destroy
destroy(this.dw_days)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.cb_save)
end on

type dw_days from datawindow within w_holiday_de
integer x = 41
integer y = 164
integer width = 1275
integer height = 1888
integer taborder = 20
string title = "none"
string dataobject = "d_holiday_de"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_delete from commandbutton within w_holiday_de
integer x = 494
integer y = 36
integer width = 261
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer i

i = messagebox("Delete","Delete Holiday?",question!,yesno!,2)

if i = 1 then dw_days.deleterow(0)
end event

type cb_add from commandbutton within w_holiday_de
integer x = 215
integer y = 36
integer width = 261
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_days.insertrow(0)
end event

type cb_close from commandbutton within w_holiday_de
integer x = 1056
integer y = 36
integer width = 261
integer height = 84
integer taborder = 10
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

type cb_save from commandbutton within w_holiday_de
integer x = 773
integer y = 36
integer width = 261
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer i
integer ic
integer li_max
date ld_date
string dow

select max(hol_id) into :li_max from sys_holidays;
if isnull(li_max) then li_max = 0
//debugbreak()
ic = dw_days.rowcount()

dw_days.accepttext()

for i = 1 to ic
	if dw_days.getitemstatus(i,0,primary!) = NewModified! or dw_days.getitemstatus(i,0,primary!) = DataModified! then
		 //Start Code Change ----08.29.2011 #V11 maha - modifed max increase only when needed, and removed isnull requirement for setting the today
		if isnull(dw_days.getitemnumber(i,"hol_id")) then
			li_max++
			dw_days.setitem(i,"hol_id",li_max)
		end if
	//	if isnull(dw_days.getitemstring(i,"week_day")) then
			dow = DayName ( date(dw_days.getitemdatetime(i,"hol_date")) )
			dw_days.setitem(i,"week_day",dow)
//		end if
	end if
	
next

dw_days.update()
end event

