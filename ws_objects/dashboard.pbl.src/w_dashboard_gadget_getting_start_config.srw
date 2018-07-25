$PBExportHeader$w_dashboard_gadget_getting_start_config.srw
forward
global type w_dashboard_gadget_getting_start_config from w_dashboard_gadget_config
end type
type dw_1 from u_dw within w_dashboard_gadget_getting_start_config
end type
type st_4 from statictext within w_dashboard_gadget_getting_start_config
end type
type ddlb_col from dropdownlistbox within w_dashboard_gadget_getting_start_config
end type
end forward

global type w_dashboard_gadget_getting_start_config from w_dashboard_gadget_config
integer width = 1358
integer height = 1660
dw_1 dw_1
st_4 st_4
ddlb_col ddlb_col
end type
global w_dashboard_gadget_getting_start_config w_dashboard_gadget_getting_start_config

type variables
boolean ib_mouse_ldown

end variables

on w_dashboard_gadget_getting_start_config.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_4=create st_4
this.ddlb_col=create ddlb_col
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.ddlb_col
end on

on w_dashboard_gadget_getting_start_config.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.ddlb_col)
end on

event open;call super::open;Integer i,ll_find
string ls_sort,ls_sort_arr[]
n_cst_string lnv_string

ddlb_col.text = String(iuo_gadget.Dynamic of_get_columns())
ls_sort = gnv_data.of_getitem('dashboard_gadgets_getting_started','sort_result',False)
lnv_string.of_parsetoarray( ls_sort, ',', ls_sort_arr[])

For i = 1 To UpperBound(ls_sort_arr[])
	ll_find = dw_1.find('id = ' + String(ls_sort_arr[i]),1,dw_1.Rowcount())
	If ll_find > 0 Then	
		dw_1.SetItem(ll_find,'sort_order',i)
	End If
Next
dw_1.SetSort('sort_order Asc')
dw_1.Sort()
dw_1.Scrolltorow(1)
dw_1.SetRow(1)
dw_1.Selectrow( 0,False)
dw_1.Selectrow(1,True)
end event

type cb_default from w_dashboard_gadget_config`cb_default within w_dashboard_gadget_getting_start_config
integer x = 265
integer y = 1456
end type

event cb_default::clicked;call super::clicked;ddlb_col.text = '2'

dw_1.SetSort('Default_Order Asc')
dw_1.Sort()
end event

type st_3 from w_dashboard_gadget_config`st_3 within w_dashboard_gadget_getting_start_config
end type

type sle_name from w_dashboard_gadget_config`sle_name within w_dashboard_gadget_getting_start_config
integer width = 1129
end type

type st_2 from w_dashboard_gadget_config`st_2 within w_dashboard_gadget_getting_start_config
string text = "items in a row."
end type

type st_1 from w_dashboard_gadget_config`st_1 within w_dashboard_gadget_getting_start_config
end type

type ddlb_rows_number from w_dashboard_gadget_config`ddlb_rows_number within w_dashboard_gadget_getting_start_config
boolean visible = false
end type

type cb_cancel from w_dashboard_gadget_config`cb_cancel within w_dashboard_gadget_getting_start_config
integer x = 965
integer y = 1456
end type

type cb_ok from w_dashboard_gadget_config`cb_ok within w_dashboard_gadget_getting_start_config
integer x = 617
integer y = 1456
end type

event cb_ok::clicked;//Override Ancestor Script
Integer li_ret,i
Integer li_rows
String ls_property_name[],ls_property_value[],ls_sort
Boolean lb_changes

If sle_name.text = '' Then
	Messagebox('Title','Please input the title.')
	sle_name.setfocus()
	Return -1
End If

ls_property_name[1] = iuo_gadget.const_title
ls_property_value[1] = sle_name.text

If iuo_gadget.of_save_other_property_value(ls_property_name[],ls_property_value[]) > 0 Then
	iuo_gadget.of_set_other_properties( )
	lb_changes = True
End If

iuo_gadget.of_update_to_db()
iuo_gadget.iuo_tabpge_gadget.of_refresh_ui()

//--------------2.26.2016 RP modified for just-in-time cache-------------------------
gnv_data.of_retrieveIfNecessary("dashboard_getting_started", FALSE)
//------------------------------------------------------------------------------------------

If gnv_data.ids_dashboard_getting_started.RowCount() = 0 Then
	gnv_data.ids_dashboard_getting_started.InsertRow(0)
	gnv_data.ids_dashboard_getting_started.SetItem(1,'user_id',gs_user_id)
End If

For i = 1 To dw_1.rowcount()
	ls_sort += String(dw_1.GetItemNumber(i,'id')) + ','
Next
ls_sort = mid(ls_sort,1,len(ls_sort) - 1)

gnv_data.ids_dashboard_getting_started.SetItem(1,'display_columns',Integer(ddlb_col.text))
gnv_data.ids_dashboard_getting_started.SetItem(1,'sort_result',ls_sort)
If gnv_data.ids_dashboard_getting_started.update() <> 1 Then
	gnv_data.ids_dashboard_getting_started.Retrieve(gs_user_id)
End If

iuo_gadget.Dynamic of_set_columns(Integer(ddlb_col.text))
iuo_gadget.Dynamic Event ue_refresh()

Close(Parent)

Return 1

end event

type dw_1 from u_dw within w_dashboard_gadget_getting_start_config
integer x = 37
integer y = 400
integer width = 1266
integer height = 1020
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dashb_gadget_getting_started_config"
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.SetTransObject(SQLCA)
This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single )
This.Retrieve()
end event

event clicked;call super::clicked;this.DragIcon = "row.ico"
end event

event lbuttondown;call super::lbuttondown;ib_mouse_ldown = true
end event

event lbuttonup;call super::lbuttonup;ib_mouse_ldown = false
end event

event dragdrop;call super::dragdrop;//of_drop_clause_list(dw_selected.getrow() ,row)
long ll_id
long ll_row

If This <> source Then Return 
If This.GetRow() = row Then Return

ll_id = This.GetItemnumber(Getrow(),'id')
If This.PointerY( ) > 940 Then
	ll_row = This.RowCount() + 1
Else
	If row = 0 Then Return
	ll_row = Row
End If
This.Rowsmove( This.GetRow(), This.GetRow(), Primary!, This, ll_row, Primary!)
ll_row = This.Find('id = ' + String(ll_id),1,This.RowCount())
If ll_Row > 0 Then
	This.Scrolltorow(ll_Row)
	This.SetRow(ll_Row)
	This.Selectrow( 0,False)
	This.Selectrow(ll_Row,True)
End If
end event

event mousemove;call super::mousemove;if ib_mouse_ldown and this.RowCount() > 0 then
	this.Drag (begin!)
end if
end event

type st_4 from statictext within w_dashboard_gadget_getting_start_config
integer x = 37
integer y = 316
integer width = 1275
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Drag to Sort: Only the first 10 items can be displayed."
boolean focusrectangle = false
end type

type ddlb_col from dropdownlistbox within w_dashboard_gadget_getting_start_config
integer x = 210
integer y = 180
integer width = 197
integer height = 324
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "2"
string item[] = {"2","3","4"}
borderstyle borderstyle = stylelowered!
end type

