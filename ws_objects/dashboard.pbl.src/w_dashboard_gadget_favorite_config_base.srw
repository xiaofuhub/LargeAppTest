$PBExportHeader$w_dashboard_gadget_favorite_config_base.srw
forward
global type w_dashboard_gadget_favorite_config_base from w_dashboard_gadget_config
end type
type dw_data from datawindow within w_dashboard_gadget_favorite_config_base
end type
type gb_1 from groupbox within w_dashboard_gadget_favorite_config_base
end type
end forward

global type w_dashboard_gadget_favorite_config_base from w_dashboard_gadget_config
integer width = 2030
integer height = 1412
event type integer ue_ok ( )
event type integer ue_cancel ( )
dw_data dw_data
gb_1 gb_1
end type
global w_dashboard_gadget_favorite_config_base w_dashboard_gadget_favorite_config_base

type variables
String is_col_name
end variables

forward prototypes
public subroutine of_register (string as_col_name)
end prototypes

event type integer ue_ok();Integer i,li_cnt,li_ret
Integer li_selected_org,li_selected_new
Long ll_data_id

//If no changes
If dw_data.Modifiedcount( ) = 0 Then Return 1

li_cnt = dw_data.RowCount()
If li_cnt = 0 Then Return 1

For i = 1 to li_cnt
	li_selected_org = dw_data.GetItemNumber(i,'selected',Primary!,True)
	li_selected_new = dw_data.GetItemNumber(i,'selected',Primary!,False)
	If li_selected_org = li_selected_new Then Continue
	ll_data_id = dw_data.GetItemNumber(i,is_col_name)
	If li_selected_new = 1 Then
		iuo_gadget.Dynamic Event ue_add(ll_data_id)
	Else
		iuo_gadget.Dynamic Event ue_delete(ll_data_id)		
	End If
Next

li_ret = iuo_gadget.Dynamic Event ue_save()
iuo_gadget.iuo_tabpge_gadget.Event ue_retrieve_same_gadget(iuo_gadget.classname())
iuo_gadget.iuo_tabpge_gadget.of_refresh_ui()

Return li_ret
end event

event type integer ue_cancel();//
Return 1

end event

public subroutine of_register (string as_col_name);is_col_name = as_col_name
end subroutine

on w_dashboard_gadget_favorite_config_base.create
int iCurrent
call super::create
this.dw_data=create dw_data
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
this.Control[iCurrent+2]=this.gb_1
end on

on w_dashboard_gadget_favorite_config_base.destroy
call super::destroy
destroy(this.dw_data)
destroy(this.gb_1)
end on

event open;call super::open;////Override Ancestor Script
//iuo_gadget = Message.powerobjectparm
//This.Title = iuo_gadget.istr_current_gadget.gadget_title + ' Settings'
//ddlb_rows_number.Text = String(iuo_gadget.istr_current_gadget.gadget_rows_number)
//
//
end event

event pfc_preopen;call super::pfc_preopen;//Override Ancestor Script

end event

type cb_default from w_dashboard_gadget_config`cb_default within w_dashboard_gadget_favorite_config_base
integer x = 46
integer y = 1200
integer taborder = 50
end type

type st_3 from w_dashboard_gadget_config`st_3 within w_dashboard_gadget_favorite_config_base
integer x = 23
integer y = 44
integer height = 52
alignment alignment = right!
end type

type sle_name from w_dashboard_gadget_config`sle_name within w_dashboard_gadget_favorite_config_base
integer x = 151
integer y = 24
integer width = 983
end type

type st_2 from w_dashboard_gadget_config`st_2 within w_dashboard_gadget_favorite_config_base
integer x = 1595
integer y = 44
end type

type st_1 from w_dashboard_gadget_config`st_1 within w_dashboard_gadget_favorite_config_base
integer x = 1216
integer y = 44
integer height = 52
end type

type ddlb_rows_number from w_dashboard_gadget_config`ddlb_rows_number within w_dashboard_gadget_favorite_config_base
integer x = 1362
integer y = 28
end type

type cb_cancel from w_dashboard_gadget_config`cb_cancel within w_dashboard_gadget_favorite_config_base
integer x = 1646
integer y = 1200
integer taborder = 70
end type

event cb_cancel::clicked;//Override Ancestor Script
Trigger Event ue_cancel()
Close(Parent)
end event

type cb_ok from w_dashboard_gadget_config`cb_ok within w_dashboard_gadget_favorite_config_base
integer x = 1298
integer y = 1200
integer taborder = 60
end type

event cb_ok::clicked;//Override Ancestor Script
Integer li_ret
Integer li_rows

If sle_name.text = '' Then
	Messagebox('Title','Please input the title.')
	sle_name.setfocus()
	Return -1
End If

li_ret =  Trigger Event ue_ok() 
If li_ret < 0 Then Return 1

If iuo_gadget.of_save_other_property_value(iuo_gadget.const_title , sle_name.text) > 0 Then
	iuo_gadget.of_set_other_properties( )
End If

li_rows = Integer(ddlb_rows_number.Text)
If li_rows <= 0 Then li_rows = 1
If iuo_gadget.istr_current_gadget.gadget_rows_number = li_rows Then
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

type dw_data from datawindow within w_dashboard_gadget_favorite_config_base
event ue_retrieve ( )
integer x = 64
integer y = 220
integer width = 1897
integer height = 904
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_retrieve();This.Retrieve(gs_user_id)
end event

event constructor;This.SetTransObject(SQLCA)
Trigger Event ue_retrieve()
end event

type gb_1 from groupbox within w_dashboard_gadget_favorite_config_base
integer x = 32
integer y = 152
integer width = 1961
integer height = 1004
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Selection Letters"
end type

