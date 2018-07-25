$PBExportHeader$w_group_name_add.srw
forward
global type w_group_name_add from w_response
end type
type st_2 from statictext within w_group_name_add
end type
type mle_des from multilineedit within w_group_name_add
end type
type cb_cancel from commandbutton within w_group_name_add
end type
type st_1 from statictext within w_group_name_add
end type
type sle_name from singlelineedit within w_group_name_add
end type
type cb_ok from commandbutton within w_group_name_add
end type
end forward

global type w_group_name_add from w_response
integer x = 1243
integer y = 676
integer width = 2007
integer height = 440
string title = "User Group Add"
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
global w_group_name_add w_group_name_add

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

on w_group_name_add.create
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

on w_group_name_add.destroy
call super::destroy
destroy(this.st_2)
destroy(this.mle_des)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.sle_name)
destroy(this.cb_ok)
end on

type st_2 from statictext within w_group_name_add
integer x = 736
integer y = 32
integer width = 462
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

type mle_des from multilineedit within w_group_name_add
integer x = 736
integer y = 92
integer width = 1207
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

type cb_cancel from commandbutton within w_group_name_add
integer x = 1605
integer y = 236
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

type st_1 from statictext within w_group_name_add
integer x = 23
integer y = 32
integer width = 343
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

type sle_name from singlelineedit within w_group_name_add
integer x = 23
integer y = 92
integer width = 695
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

type cb_ok from commandbutton within w_group_name_add
integer x = 1271
integer y = 236
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

Long ll_group_id
String ls_group_name,ls_group_des

ls_group_name = sle_name.text
ls_group_des = mle_des.text
If ls_group_name = '' Then
	Messagebox('Group Name','Please input the Group name.')
	Return 1
End If

Select id into :ll_group_id from security_groups where group_name = :ls_group_name;
If ll_group_id > 0 Then
	Messagebox('Group Name','The Group "' + ls_group_name +'" already exists, please input another name.')
	Return 1 
End If

Insert Into security_groups(group_name,group_des) Values(:ls_group_name,:ls_group_des) ;
Select id into :ll_group_id from security_groups where group_name = :ls_group_name;
If ll_group_id < 0 Then
	Messagebox('Add Group','Failed to add group, please call support.')
	Return -1
End If
CloseWithReturn(Parent, ll_group_id)


end event

