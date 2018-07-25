$PBExportHeader$w_existing_work_gap.srw
forward
global type w_existing_work_gap from window
end type
type cb_1 from commandbutton within w_existing_work_gap
end type
type dw_1 from datawindow within w_existing_work_gap
end type
end forward

global type w_existing_work_gap from window
integer width = 2149
integer height = 956
boolean titlebar = true
string title = "Existing Work Gap"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_existing_work_gap w_existing_work_gap

event open;

dw_1.settransobject(sqlca)
dw_1.retrieve(message.doubleparm )

dw_1.object.selected.visible = false
dw_1.object.t_selected.visible = false
end event

on w_existing_work_gap.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_existing_work_gap.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_existing_work_gap
integer x = 846
integer y = 704
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_existing_work_gap
integer x = 32
integer y = 48
integer width = 2043
integer height = 596
integer taborder = 10
string title = "none"
string dataobject = "d_work_gap_cal_data"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

