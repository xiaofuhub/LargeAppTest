$PBExportHeader$w_wf_action_type_edit.srw
forward
global type w_wf_action_type_edit from w_response
end type
type cb_2 from u_cb within w_wf_action_type_edit
end type
type cb_1 from u_cb within w_wf_action_type_edit
end type
type dw_1 from u_dw within w_wf_action_type_edit
end type
end forward

global type w_wf_action_type_edit from w_response
integer width = 3223
integer height = 1020
boolean controlmenu = false
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_wf_action_type_edit w_wf_action_type_edit

on w_wf_action_type_edit.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_wf_action_type_edit.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.event pfc_insertrow()
end event

type cb_2 from u_cb within w_wf_action_type_edit
integer x = 2459
integer y = 824
integer taborder = 20
string text = "OK"
end type

type cb_1 from u_cb within w_wf_action_type_edit
integer x = 2834
integer y = 820
integer taborder = 20
string text = "Cancle"
end type

event clicked;call super::clicked;close(parent)
end event

type dw_1 from u_dw within w_wf_action_type_edit
integer x = 32
integer y = 28
integer width = 3150
integer height = 764
integer taborder = 10
string dataobject = "d_wf_action_type_2"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

