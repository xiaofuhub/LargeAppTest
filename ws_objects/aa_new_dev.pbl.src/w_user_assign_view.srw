$PBExportHeader$w_user_assign_view.srw
forward
global type w_user_assign_view from w_popup
end type
type cb_close from commandbutton within w_user_assign_view
end type
type uo_user from uo_user_assignments within w_user_assign_view
end type
end forward

global type w_user_assign_view from w_popup
integer width = 4229
integer height = 2544
long backcolor = 33551856
cb_close cb_close
uo_user uo_user
end type
global w_user_assign_view w_user_assign_view

on w_user_assign_view.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.uo_user=create uo_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.uo_user
end on

on w_user_assign_view.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.uo_user)
end on

event resize;call super::resize;uo_user.resize(newwidth, newheight)
end event

event open;call super::open;uo_user.of_retrieve_data( )
end event

type cb_close from commandbutton within w_user_assign_view
integer x = 3813
integer y = 68
integer width = 334
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type uo_user from uo_user_assignments within w_user_assign_view
integer taborder = 20
end type

on uo_user.destroy
call uo_user_assignments::destroy
end on

