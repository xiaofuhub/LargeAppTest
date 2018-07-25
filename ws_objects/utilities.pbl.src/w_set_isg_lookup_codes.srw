$PBExportHeader$w_set_isg_lookup_codes.srw
forward
global type w_set_isg_lookup_codes from window
end type
type cb_1 from commandbutton within w_set_isg_lookup_codes
end type
type dw_1 from datawindow within w_set_isg_lookup_codes
end type
end forward

global type w_set_isg_lookup_codes from window
integer width = 4160
integer height = 1924
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_set_isg_lookup_codes w_set_isg_lookup_codes

on w_set_isg_lookup_codes.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_set_isg_lookup_codes.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_set_isg_lookup_codes
integer x = 3506
integer y = 1656
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;long r

for r = 1 to dw_1.rowcount()
	dw_1.setitem(r,"isg_code", r)
next

dw_1.update()
end event

type dw_1 from datawindow within w_set_isg_lookup_codes
integer x = 50
integer y = 36
integer width = 3995
integer height = 1596
integer taborder = 10
string title = "none"
string dataobject = "d_addr_lookup_code_for_isg_id"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

