$PBExportHeader$w_dashboard_tab_name.srw
forward
global type w_dashboard_tab_name from w_response
end type
type cb_cancel from commandbutton within w_dashboard_tab_name
end type
type st_1 from statictext within w_dashboard_tab_name
end type
type sle_name from singlelineedit within w_dashboard_tab_name
end type
type cb_ok from commandbutton within w_dashboard_tab_name
end type
end forward

global type w_dashboard_tab_name from w_response
integer x = 1243
integer y = 676
integer width = 1970
integer height = 328
string title = "Add Dashboard Tab"
boolean controlmenu = false
long backcolor = 33551856
event ue_syscommand pbm_syscommand
cb_cancel cb_cancel
st_1 st_1
sle_name sle_name
cb_ok cb_ok
end type
global w_dashboard_tab_name w_dashboard_tab_name

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
// $<add> 23/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_dashboard_tab_name.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.sle_name=create sle_name
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_name
this.Control[iCurrent+4]=this.cb_ok
end on

on w_dashboard_tab_name.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.sle_name)
destroy(this.cb_ok)
end on

type cb_cancel from commandbutton within w_dashboard_tab_name
integer x = 1595
integer y = 96
integer width = 315
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, '')
end event

type st_1 from statictext within w_dashboard_tab_name
integer x = 110
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
string text = "Tab Name"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_dashboard_tab_name
integer x = 110
integer y = 96
integer width = 1097
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

type cb_ok from commandbutton within w_dashboard_tab_name
integer x = 1243
integer y = 96
integer width = 315
integer height = 84
integer taborder = 20
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
// $<description> Return tab name
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 23/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If sle_name.text = '' Then
	Messagebox('Tab Name','Please input the tab name.')
	Return
End If
CloseWithReturn(Parent, sle_name.Text)
end event

