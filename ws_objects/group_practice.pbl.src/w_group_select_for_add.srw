$PBExportHeader$w_group_select_for_add.srw
forward
global type w_group_select_for_add from w_response
end type
type cb_can from commandbutton within w_group_select_for_add
end type
type cb_ok from commandbutton within w_group_select_for_add
end type
type dw_1 from datawindow within w_group_select_for_add
end type
type st_2 from statictext within w_group_select_for_add
end type
type st_1 from statictext within w_group_select_for_add
end type
end forward

global type w_group_select_for_add from w_response
integer width = 1577
integer height = 648
long backcolor = 33551856
cb_can cb_can
cb_ok cb_ok
dw_1 dw_1
st_2 st_2
st_1 st_1
end type
global w_group_select_for_add w_group_select_for_add

type variables
long il_group
end variables

on w_group_select_for_add.create
int iCurrent
call super::create
this.cb_can=create cb_can
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_can
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
end on

on w_group_select_for_add.destroy
call super::destroy
destroy(this.cb_can)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;call super::open; //Start Code Change ----02.14.2017 #V153 maha - added 
 long ll_loc
 datawindowchild dwchild
 
ll_loc = message.doubleparm
 
dw_1.settransobject(sqlca)
dw_1.getchild( "rec_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(ll_loc)

dw_1.insertrow(1)
 
 
end event

type cb_can from commandbutton within w_group_select_for_add
integer x = 741
integer y = 388
integer width = 402
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

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_ok from commandbutton within w_group_select_for_add
integer x = 315
integer y = 388
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "OK"
end type

event clicked;closewithreturn(parent, il_group)
end event

type dw_1 from datawindow within w_group_select_for_add
integer x = 169
integer y = 228
integer width = 1243
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_group_select"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_group = long(data)

cb_ok.enabled = true
end event

type st_2 from statictext within w_group_select_for_add
integer x = 14
integer y = 96
integer width = 1527
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Please select the desired Group, or Cancel."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_group_select_for_add
integer x = 14
integer y = 20
integer width = 1527
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "There is more than one Group connected to this location."
alignment alignment = center!
boolean focusrectangle = false
end type

