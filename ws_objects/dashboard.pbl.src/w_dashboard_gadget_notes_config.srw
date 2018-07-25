$PBExportHeader$w_dashboard_gadget_notes_config.srw
forward
global type w_dashboard_gadget_notes_config from w_dashboard_gadget_config
end type
type st_31 from statictext within w_dashboard_gadget_notes_config
end type
type st_color from statictext within w_dashboard_gadget_notes_config
end type
end forward

global type w_dashboard_gadget_notes_config from w_dashboard_gadget_config
integer width = 1198
integer height = 668
st_31 st_31
st_color st_color
end type
global w_dashboard_gadget_notes_config w_dashboard_gadget_notes_config

type variables

end variables

on w_dashboard_gadget_notes_config.create
int iCurrent
call super::create
this.st_31=create st_31
this.st_color=create st_color
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_31
this.Control[iCurrent+2]=this.st_color
end on

on w_dashboard_gadget_notes_config.destroy
call super::destroy
destroy(this.st_31)
destroy(this.st_color)
end on

event open;call super::open;
st_color.backcolor  = istr_gadget.al_temp1
end event

type cb_default from w_dashboard_gadget_config`cb_default within w_dashboard_gadget_notes_config
integer x = 91
integer y = 452
end type

event cb_default::clicked;call super::clicked;st_color.backcolor = gl_custom_colors[16] 
end event

type st_3 from w_dashboard_gadget_config`st_3 within w_dashboard_gadget_notes_config
end type

type sle_name from w_dashboard_gadget_config`sle_name within w_dashboard_gadget_notes_config
integer width = 955
end type

type st_2 from w_dashboard_gadget_config`st_2 within w_dashboard_gadget_notes_config
end type

type st_1 from w_dashboard_gadget_config`st_1 within w_dashboard_gadget_notes_config
end type

type ddlb_rows_number from w_dashboard_gadget_config`ddlb_rows_number within w_dashboard_gadget_notes_config
integer x = 178
end type

type cb_cancel from w_dashboard_gadget_config`cb_cancel within w_dashboard_gadget_notes_config
integer x = 791
integer y = 452
end type

type cb_ok from w_dashboard_gadget_config`cb_ok within w_dashboard_gadget_notes_config
integer x = 443
integer y = 452
end type

event cb_ok::clicked;//Override Ancestor Script
Integer li_rows

If sle_name.text = '' Then
	Messagebox('Title','Please input the title.')
	sle_name.setfocus()
	Return -1
End If

If ddlb_rows_number.visible and ddlb_rows_number.enabled Then
	li_rows = Integer(ddlb_rows_number.Text)
	If li_rows <= 0 Then li_rows = 1
	istr_gadget.gadget_rows_number = li_rows
End IF

istr_gadget.al_temp1 = st_color.backcolor

If iuo_gadget.of_save_other_property_value(iuo_gadget.const_title , sle_name.text) > 0 Then
	iuo_gadget.of_set_other_properties( )
End If

ClosewithReturn(Parent, istr_gadget)
end event

type st_31 from statictext within w_dashboard_gadget_notes_config
integer x = 41
integer y = 304
integer width = 599
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Notes background color:"
boolean focusrectangle = false
end type

type st_color from statictext within w_dashboard_gadget_notes_config
integer x = 645
integer y = 292
integer width = 101
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

event clicked;Long ll_color
Long ll_default_color[]
gl_custom_colors[16] = RGB(255,255,128)
ll_color = st_color.backcolor
ChooseColor(ll_color,gl_custom_colors[])
st_color.backcolor = ll_color
end event

