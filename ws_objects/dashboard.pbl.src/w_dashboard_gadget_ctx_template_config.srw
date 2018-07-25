$PBExportHeader$w_dashboard_gadget_ctx_template_config.srw
forward
global type w_dashboard_gadget_ctx_template_config from w_dashboard_gadget_config
end type
type cbx_createby from checkbox within w_dashboard_gadget_ctx_template_config
end type
type cbx_createdate from checkbox within w_dashboard_gadget_ctx_template_config
end type
end forward

global type w_dashboard_gadget_ctx_template_config from w_dashboard_gadget_config
integer height = 648
cbx_createby cbx_createby
cbx_createdate cbx_createdate
end type
global w_dashboard_gadget_ctx_template_config w_dashboard_gadget_ctx_template_config

on w_dashboard_gadget_ctx_template_config.create
int iCurrent
call super::create
this.cbx_createby=create cbx_createby
this.cbx_createdate=create cbx_createdate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_createby
this.Control[iCurrent+2]=this.cbx_createdate
end on

on w_dashboard_gadget_ctx_template_config.destroy
call super::destroy
destroy(this.cbx_createby)
destroy(this.cbx_createdate)
end on

event open;call super::open;String ls_display_createby,ls_display_createdate

ls_display_createby = iuo_gadget.of_get_other_property_value(iuo_gadget.const_display_createby )
ls_display_createdate = iuo_gadget.of_get_other_property_value(iuo_gadget.const_display_createdate )

If ls_display_createby = '1' Then
	cbx_createby.checked = True
Else
	cbx_createby.checked = False
End If

If ls_display_createdate = '1' Then
	cbx_createdate.checked = True
Else
	cbx_createdate.checked = False
End If
end event

type cb_default from w_dashboard_gadget_config`cb_default within w_dashboard_gadget_ctx_template_config
integer y = 432
end type

event cb_default::clicked;call super::clicked;cbx_createby.checked = False
cbx_createdate.checked = False
end event

type st_3 from w_dashboard_gadget_config`st_3 within w_dashboard_gadget_ctx_template_config
end type

type sle_name from w_dashboard_gadget_config`sle_name within w_dashboard_gadget_ctx_template_config
end type

type st_2 from w_dashboard_gadget_config`st_2 within w_dashboard_gadget_ctx_template_config
end type

type st_1 from w_dashboard_gadget_config`st_1 within w_dashboard_gadget_ctx_template_config
end type

type ddlb_rows_number from w_dashboard_gadget_config`ddlb_rows_number within w_dashboard_gadget_ctx_template_config
end type

type cb_cancel from w_dashboard_gadget_config`cb_cancel within w_dashboard_gadget_ctx_template_config
integer y = 432
end type

type cb_ok from w_dashboard_gadget_config`cb_ok within w_dashboard_gadget_ctx_template_config
integer y = 432
end type

event cb_ok::clicked;//Override Ancestor Script
Integer li_ret
Integer li_rows
String ls_property_name[],ls_property_value[]
Boolean lb_changes

If sle_name.text = '' Then
	Messagebox('Title','Please input the title.')
	sle_name.setfocus()
	Return -1
End If

ls_property_name[1] = iuo_gadget.const_title
ls_property_value[1] = sle_name.text

ls_property_name[2] = iuo_gadget.const_display_createby
If cbx_createby.checked Then
	ls_property_value[2] = '1'
Else
	ls_property_value[2] = '0'
End If
ls_property_name[3] = iuo_gadget.const_display_createdate
If cbx_createdate.checked Then
	ls_property_value[3] = '1'
Else
	ls_property_value[3] = '0'
End If

If iuo_gadget.of_save_other_property_value(ls_property_name[],ls_property_value[]) > 0 Then
	iuo_gadget.of_set_other_properties( )
	lb_changes = True
End If

li_rows = Integer(ddlb_rows_number.Text)
If li_rows <= 0 Then li_rows = 1
If iuo_gadget.istr_current_gadget.gadget_rows_number = li_rows and lb_changes = False Then
	//No Changes
	Close(Parent)
	Return 1
Else
	iuo_gadget.istr_current_gadget.gadget_rows_number = li_rows
End If

iuo_gadget.of_update_to_db()
iuo_gadget.of_set_property(iuo_gadget.const_rows_number, li_rows)
iuo_gadget.iuo_tabpge_gadget.of_refresh_ui()

Close(Parent)

Return 1


end event

type cbx_createby from checkbox within w_dashboard_gadget_ctx_template_config
integer x = 55
integer y = 312
integer width = 558
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Display Created By"
end type

type cbx_createdate from checkbox within w_dashboard_gadget_ctx_template_config
integer x = 681
integer y = 312
integer width = 558
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Display Create Date"
end type

