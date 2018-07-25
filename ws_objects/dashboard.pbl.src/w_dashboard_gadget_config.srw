$PBExportHeader$w_dashboard_gadget_config.srw
forward
global type w_dashboard_gadget_config from w_response
end type
type cb_default from commandbutton within w_dashboard_gadget_config
end type
type st_3 from statictext within w_dashboard_gadget_config
end type
type sle_name from singlelineedit within w_dashboard_gadget_config
end type
type st_2 from statictext within w_dashboard_gadget_config
end type
type st_1 from statictext within w_dashboard_gadget_config
end type
type ddlb_rows_number from dropdownlistbox within w_dashboard_gadget_config
end type
type cb_cancel from commandbutton within w_dashboard_gadget_config
end type
type cb_ok from commandbutton within w_dashboard_gadget_config
end type
end forward

global type w_dashboard_gadget_config from w_response
integer width = 1390
integer height = 584
string title = "Dashboard Gadget Settings"
long backcolor = 33551856
event ue_syscommand pbm_syscommand
cb_default cb_default
st_3 st_3
sle_name sle_name
st_2 st_2
st_1 st_1
ddlb_rows_number ddlb_rows_number
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_dashboard_gadget_config w_dashboard_gadget_config

type variables
str_gadget istr_gadget
u_cst_gadget iuo_gadget


end variables

forward prototypes
public subroutine of_set_items_enabled (boolean ab_value)
public subroutine of_set_items_visible (boolean ab_value)
end prototypes

event ue_syscommand;//////////////////////////////////////////////////////////////////////
// $<event>ue_syscommandw_dashboard_config()
// $<arguments>
//		value	unsignedlong	commandtype		
//		value	integer     	xpos       		
//		value	integer     	ypos       		
// $<returns> long
// $<description> If click 'Close' button on title bar, 
// $<description> Need trigger clickced event for 'Cancel' button.
//////////////////////////////////////////////////////////////////////
// $<add> 26/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

public subroutine of_set_items_enabled (boolean ab_value);st_1.enabled = ab_value
ddlb_rows_number.enabled = ab_value
st_2.enabled = ab_value
end subroutine

public subroutine of_set_items_visible (boolean ab_value);st_1.visible = ab_value
ddlb_rows_number.visible = ab_value
st_2.visible = ab_value
end subroutine

on w_dashboard_gadget_config.create
int iCurrent
call super::create
this.cb_default=create cb_default
this.st_3=create st_3
this.sle_name=create sle_name
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_rows_number=create ddlb_rows_number
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_default
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.sle_name
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.ddlb_rows_number
this.Control[iCurrent+7]=this.cb_cancel
this.Control[iCurrent+8]=this.cb_ok
end on

on w_dashboard_gadget_config.destroy
call super::destroy
destroy(this.cb_default)
destroy(this.st_3)
destroy(this.sle_name)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_rows_number)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event pfc_preopen;call super::pfc_preopen;//istr_gadget = Message.powerobjectparm

iuo_gadget = Message.powerobjectparm
istr_gadget = iuo_gadget.istr_current_gadget

If istr_gadget.gadget_rows_number = 0 Then
	of_set_items_enabled(False)
End If
end event

event open;call super::open;This.Title = istr_gadget.gadget_title + ' Settings'
If istr_gadget.gadget_rows_number = 0 Then
	ddlb_rows_number.Text = '1'
Else
	ddlb_rows_number.Text = String(istr_gadget.gadget_rows_number)
End IF

sle_name.text = istr_gadget.gadget_title
end event

type cb_default from commandbutton within w_dashboard_gadget_config
integer x = 297
integer y = 368
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Default"
boolean cancel = true
end type

event clicked;String ls_name

Select gadget_title Into :ls_name From dashboard_gadgets where gadget_id = :istr_gadget.gadget_id;

If ls_name <> '' and not isnull(ls_name) Then
	sle_name.text = ls_name
End IF

If ddlb_rows_number.enabled and ddlb_rows_number.visible Then
	ddlb_rows_number.text = '5'
End IF
end event

type st_3 from statictext within w_dashboard_gadget_config
integer x = 41
integer y = 72
integer width = 119
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Title"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_dashboard_gadget_config
integer x = 174
integer y = 52
integer width = 1175
integer height = 92
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

type st_2 from statictext within w_dashboard_gadget_config
integer x = 425
integer y = 188
integer width = 453
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Items in a page."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_dashboard_gadget_config
integer x = 32
integer y = 184
integer width = 142
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Show"
boolean focusrectangle = false
end type

type ddlb_rows_number from dropdownlistbox within w_dashboard_gadget_config
integer x = 183
integer y = 180
integer width = 233
integer height = 888
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 11
string item[] = {"1","2","3","4","5","6","7","8","9","10"}
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_dashboard_gadget_config
integer x = 997
integer y = 368
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;ClosewithReturn(Parent, istr_gadget)
end event

type cb_ok from commandbutton within w_dashboard_gadget_config
integer x = 649
integer y = 368
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Integer li_rows

If sle_name.text = '' Then
	Messagebox('Title','Please input the title.')
	sle_name.setfocus()
	Return -1
End If

If ddlb_rows_number.visible and ddlb_rows_number.enabled Then
	li_rows = Integer(ddlb_rows_number.Text)
	If li_rows <= 0 Then li_rows = 1
	istr_gadget.gadget_rows_number = li_rows
End If

If iuo_gadget.of_save_other_property_value(iuo_gadget.const_title , sle_name.text) > 0 Then
	iuo_gadget.of_set_other_properties( )
End If

ClosewithReturn(Parent, istr_gadget)
end event

