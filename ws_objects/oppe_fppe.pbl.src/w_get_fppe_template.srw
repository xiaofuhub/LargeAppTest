$PBExportHeader$w_get_fppe_template.srw
forward
global type w_get_fppe_template from w_popup
end type
type st_1 from statictext within w_get_fppe_template
end type
type dw_1 from datawindow within w_get_fppe_template
end type
type cb_apply from commandbutton within w_get_fppe_template
end type
type cb_close from commandbutton within w_get_fppe_template
end type
end forward

global type w_get_fppe_template from w_popup
integer x = 1120
integer y = 452
integer width = 1787
integer height = 412
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
dw_1 dw_1
cb_apply cb_apply
cb_close cb_close
end type
global w_get_fppe_template w_get_fppe_template

type variables
long il_temp = 0
end variables

on w_get_fppe_template.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_apply=create cb_apply
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_apply
this.Control[iCurrent+4]=this.cb_close
end on

on w_get_fppe_template.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_apply)
destroy(this.cb_close)
end on

event pfc_close;call super::pfc_close;//return 0
end event

event closequery;return 0
end event

type st_1 from statictext within w_get_fppe_template
integer x = 91
integer y = 36
integer width = 498
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Plan Template"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_get_fppe_template
integer x = 78
integer y = 112
integer width = 1271
integer height = 104
integer taborder = 30
string title = "none"
string dataobject = "d_fppe_template"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_temp = long(data)
end event

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

type cb_apply from commandbutton within w_get_fppe_template
integer x = 1440
integer y = 104
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;

CloseWithReturn( parent, il_temp )
end event

type cb_close from commandbutton within w_get_fppe_template
integer x = 1440
integer y = 208
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, 0 )
end event

