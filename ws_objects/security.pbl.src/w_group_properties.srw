$PBExportHeader$w_group_properties.srw
forward
global type w_group_properties from w_response
end type
type st_2 from statictext within w_group_properties
end type
type mle_des from multilineedit within w_group_properties
end type
type cb_cancel from commandbutton within w_group_properties
end type
type st_1 from statictext within w_group_properties
end type
type sle_name from singlelineedit within w_group_properties
end type
type cb_ok from commandbutton within w_group_properties
end type
end forward

global type w_group_properties from w_response
integer x = 1243
integer y = 676
integer width = 1966
integer height = 416
string title = "Group Properties"
boolean controlmenu = false
long backcolor = 33551856
event ue_syscommand pbm_syscommand
st_2 st_2
mle_des mle_des
cb_cancel cb_cancel
st_1 st_1
sle_name sle_name
cb_ok cb_ok
end type
global w_group_properties w_group_properties

type variables
Long il_group_id

String is_group_name,is_group_des
end variables

event ue_syscommand;//////////////////////////////////////////////////////////////////////
// $<event>ue_syscommand()
// $<arguments>
//		value	unsignedlong	commandtype		
//		value	integer     	xpos       		
//		value	integer     	ypos       		
// $<returns> long
// $<description>If click 'Close' menu, trigger Cancel button.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 19/01/2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_group_properties.create
int iCurrent
call super::create
this.st_2=create st_2
this.mle_des=create mle_des
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.sle_name=create sle_name
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.mle_des
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_name
this.Control[iCurrent+6]=this.cb_ok
end on

on w_group_properties.destroy
call super::destroy
destroy(this.st_2)
destroy(this.mle_des)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.sle_name)
destroy(this.cb_ok)
end on

event open;call super::open;il_group_id = Message.doubleparm

Select group_name,group_des into :is_group_name,:is_group_des from security_groups where id = :il_group_id;

sle_name.text = is_group_name
mle_des.text = is_group_des


end event

type st_2 from statictext within w_group_properties
integer x = 741
integer y = 20
integer width = 512
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Group Description:"
boolean focusrectangle = false
end type

type mle_des from multilineedit within w_group_properties
integer x = 741
integer y = 88
integer width = 1198
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_group_properties
integer x = 1609
integer y = 212
integer width = 315
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type st_1 from statictext within w_group_properties
integer x = 27
integer y = 24
integer width = 398
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Group Name:"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_group_properties
integer x = 27
integer y = 88
integer width = 699
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_group_properties
integer x = 1275
integer y = 212
integer width = 315
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_ok::clicked()
// $<arguments>(None)
// $<returns> long
// $<description> Return Group name
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 19/01/2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_group_name,ls_group_des
If sle_name.text = is_group_name and mle_des.text = is_group_des Then
	cb_cancel.Trigger Event Clicked()
	Return 1
End IF

is_group_name = sle_name.text 
is_group_des = mle_des.text

Update security_groups Set group_name = :is_group_name, group_des = :is_group_des where id = :il_group_id;

CloseWithReturn(Parent, 1)


end event

