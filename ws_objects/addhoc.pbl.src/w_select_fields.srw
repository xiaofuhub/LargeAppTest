$PBExportHeader$w_select_fields.srw
forward
global type w_select_fields from window
end type
type cb_cancel from commandbutton within w_select_fields
end type
type cb_ok from commandbutton within w_select_fields
end type
type dw_select_fields from datawindow within w_select_fields
end type
end forward

global type w_select_fields from window
integer width = 1403
integer height = 440
boolean titlebar = true
string title = "Select Fields"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
dw_select_fields dw_select_fields
end type
global w_select_fields w_select_fields

on w_select_fields.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_select_fields=create dw_select_fields
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_select_fields}
end on

on w_select_fields.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_select_fields)
end on

type cb_cancel from commandbutton within w_select_fields
integer x = 1083
integer y = 136
integer width = 274
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;CloseWithReturn(Parent,"cancel")

end event

type cb_ok from commandbutton within w_select_fields
integer x = 1083
integer y = 24
integer width = 274
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
end type

event clicked;Long i
FOR i = 1 To dw_select_fields.RowCount()
	IF dw_select_fields.Object.Selected[i] = '1' THEN
		w_custom_report_selection.uo_1.is_c_alias = dw_select_fields.Object.c_alias[i]
		w_custom_report_selection.uo_1.is_c_name = dw_select_fields.Object.c_name[i]
		w_custom_report_selection.uo_1.uf_add()
	END IF
NEXT
CloseWithReturn(Parent,"ok")


end event

type dw_select_fields from datawindow within w_select_fields
integer x = 37
integer y = 28
integer width = 1010
integer height = 288
integer taborder = 10
string title = "none"
string dataobject = "d_view_name_by"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Long ll_rowcount
This.SetTransObject(sqlca)
IF IsValid(w_custom_report_selection) THEN
	ll_rowcount = This.Retrieve(w_custom_report_selection.uo_1.is_v_name,w_custom_report_selection.uo_1.is_c_name,w_custom_report.il_data_view_id)
	IF ll_rowcount = 0 THEN
		CloseWithReturn(Parent,"zero")
	ELSEIF ll_rowcount = 1 THEN
		dw_select_fields.Object.Selected[1] = '1'
		cb_ok.Event Clicked( )
	END IF
END IF

end event

