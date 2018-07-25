$PBExportHeader$w_fppe_plan.srw
forward
global type w_fppe_plan from w_master
end type
type cb_close from commandbutton within w_fppe_plan
end type
type uo_plan from uo_fppe_plan_setup within w_fppe_plan
end type
end forward

global type w_fppe_plan from w_master
integer width = 4699
integer height = 2724
string title = "FPPE Plan Templates"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
cb_close cb_close
uo_plan uo_plan
end type
global w_fppe_plan w_fppe_plan

on w_fppe_plan.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.uo_plan=create uo_plan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.uo_plan
end on

on w_fppe_plan.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.uo_plan)
end on

event open;call super::open;//Start Code Change ----11.22.2011 #V12 maha - created
uo_plan.of_get_browse( )
	





end event

event closequery;return 0
end event

type cb_close from commandbutton within w_fppe_plan
integer x = 4302
integer y = 48
integer width = 343
integer height = 92
integer taborder = 80
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

type uo_plan from uo_fppe_plan_setup within w_fppe_plan
integer y = 12
integer height = 2608
integer taborder = 70
end type

on uo_plan.destroy
call uo_fppe_plan_setup::destroy
end on

