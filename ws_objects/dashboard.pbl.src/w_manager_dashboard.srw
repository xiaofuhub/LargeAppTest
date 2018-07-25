$PBExportHeader$w_manager_dashboard.srw
forward
global type w_manager_dashboard from w_response
end type
type cb_close from commandbutton within w_manager_dashboard
end type
type uo_1 from u_cst_manager_dashboard within w_manager_dashboard
end type
end forward

global type w_manager_dashboard from w_response
integer width = 4910
integer height = 2448
boolean minbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_close cb_close
uo_1 uo_1
end type
global w_manager_dashboard w_manager_dashboard

on w_manager_dashboard.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.uo_1
end on

on w_manager_dashboard.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.uo_1)
end on

event resize;call super::resize;long ll_width
long ll_height


ll_width = this.workspacewidth( ) - 260
ll_height =  this.workspaceheight( ) - 260


uo_1.width = this.width
uo_1.height = this.height

uo_1.of_set_resize( )

end event

type cb_close from commandbutton within w_manager_dashboard
integer x = 4608
integer y = 52
integer width = 250
integer height = 92
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

type uo_1 from u_cst_manager_dashboard within w_manager_dashboard
integer taborder = 40
end type

on uo_1.destroy
call u_cst_manager_dashboard::destroy
end on

