$PBExportHeader$w_dashboard_gadget_todolist_config.srw
forward
global type w_dashboard_gadget_todolist_config from w_dashboard_gadget_config
end type
type ddlb_height from dropdownlistbox within w_dashboard_gadget_todolist_config
end type
type st_height from statictext within w_dashboard_gadget_todolist_config
end type
end forward

global type w_dashboard_gadget_todolist_config from w_dashboard_gadget_config
integer width = 1454
integer height = 576
ddlb_height ddlb_height
st_height st_height
end type
global w_dashboard_gadget_todolist_config w_dashboard_gadget_todolist_config

on w_dashboard_gadget_todolist_config.create
int iCurrent
call super::create
this.ddlb_height=create ddlb_height
this.st_height=create st_height
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_height
this.Control[iCurrent+2]=this.st_height
end on

on w_dashboard_gadget_todolist_config.destroy
call super::destroy
destroy(this.ddlb_height)
destroy(this.st_height)
end on

event pfc_postopen;call super::pfc_postopen;Choose Case iuo_gadget.istr_current_gadget.adec_height_ier
	Case 1
		ddlb_height.SelectItem(1)
	Case 1.2
		ddlb_height.SelectItem(2)
	Case 1.5
		ddlb_height.SelectItem(3)
	Case 1.8
		ddlb_height.SelectItem(4)		
	Case 2
		ddlb_height.SelectItem(5)
	Case Else
		ddlb_height.SelectItem(1)
End Choose
end event

type cb_default from w_dashboard_gadget_config`cb_default within w_dashboard_gadget_todolist_config
end type

event cb_default::clicked;call super::clicked;ddlb_height.text = 'Single'
end event

type st_3 from w_dashboard_gadget_config`st_3 within w_dashboard_gadget_todolist_config
end type

type sle_name from w_dashboard_gadget_config`sle_name within w_dashboard_gadget_todolist_config
end type

type st_2 from w_dashboard_gadget_config`st_2 within w_dashboard_gadget_todolist_config
boolean visible = false
integer x = 1047
integer y = 204
end type

type st_1 from w_dashboard_gadget_config`st_1 within w_dashboard_gadget_todolist_config
boolean visible = false
integer x = 654
integer y = 200
end type

type ddlb_rows_number from w_dashboard_gadget_config`ddlb_rows_number within w_dashboard_gadget_todolist_config
boolean visible = false
integer x = 805
integer y = 196
end type

type cb_cancel from w_dashboard_gadget_config`cb_cancel within w_dashboard_gadget_todolist_config
end type

type cb_ok from w_dashboard_gadget_config`cb_ok within w_dashboard_gadget_todolist_config
end type

event cb_ok::clicked;Integer li_isgraph,li_graph_type
Decimal ldec_height_ier
Long ll_row
Long ll_report_id
String ls_user_filter
Long ll_tdl_id
n_ds nds_reports

Integer li_rows
If sle_name.text = '' Then
	Messagebox('Title','Please input the title.')
	sle_name.setfocus()
	Return -1
End If

Choose Case Upper(ddlb_height.Text) 
	Case Upper('Single')
		ldec_height_ier = 1
	Case Upper('1.2 Height')
		ldec_height_ier = 1.2
	Case Upper('1.5 Height')
		ldec_height_ier = 1.5
	Case Upper('1.8 Height')
		ldec_height_ier = 1.8		
	Case Upper('Double')
		ldec_height_ier = 2
	Case	Else
		ldec_height_ier = 1			
End Choose


//Save Height IER
If ldec_height_ier <> iuo_gadget.istr_current_gadget.adec_height_ier Then
	iuo_gadget.istr_current_gadget.adec_height_ier = ldec_height_ier
	If iuo_gadget.of_update_to_db() > 0 Then
		If iuo_gadget.istr_current_gadget.gadget_maximize = 1 Then
			iuo_gadget.Event ue_max()		
			iuo_gadget.iuo_tabpge_gadget.of_refresh_ui()
		End If
	End If
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

type ddlb_height from dropdownlistbox within w_dashboard_gadget_todolist_config
integer x = 229
integer y = 192
integer width = 411
integer height = 504
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Single","1.2 Height","1.5 Height","1.8 Height","Double"}
borderstyle borderstyle = stylelowered!
end type

type st_height from statictext within w_dashboard_gadget_todolist_config
integer x = 46
integer y = 192
integer width = 178
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Height:"
boolean focusrectangle = false
end type

