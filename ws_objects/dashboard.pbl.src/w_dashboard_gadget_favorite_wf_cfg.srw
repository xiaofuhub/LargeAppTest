$PBExportHeader$w_dashboard_gadget_favorite_wf_cfg.srw
forward
global type w_dashboard_gadget_favorite_wf_cfg from w_dashboard_gadget_favorite_config_base
end type
end forward

global type w_dashboard_gadget_favorite_wf_cfg from w_dashboard_gadget_favorite_config_base
end type
global w_dashboard_gadget_favorite_wf_cfg w_dashboard_gadget_favorite_wf_cfg

forward prototypes
public subroutine of_apply_right ()
end prototypes

public subroutine of_apply_right ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_gadget_favorite_wf_cfg::of_apply_right()
// $<arguments>(None)
// $<returns> (none)
// $<description> 
// $<description> Apply the right .
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-12 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_cnt ,i
String ls_filter
String ls_module[]

iuo_gadget.Dynamic of_get_right()
iuo_gadget.Dynamic of_get_modules(ls_module[])
li_cnt = UpperBound(ls_module[])
If li_cnt = 0 Then Return 

For i = 1 To li_cnt
	ls_filter +=  "wf_module = '" + ls_module[i] + "' Or "
Next

ls_filter = Mid(ls_filter,1,Len(ls_filter) - 4 )

dw_data.SetFilter(ls_filter)
dw_data.Filter()
end subroutine

event open;call super::open;of_register('wf_id')
end event

on w_dashboard_gadget_favorite_wf_cfg.create
call super::create
end on

on w_dashboard_gadget_favorite_wf_cfg.destroy
call super::destroy
end on

type cb_default from w_dashboard_gadget_favorite_config_base`cb_default within w_dashboard_gadget_favorite_wf_cfg
end type

type st_3 from w_dashboard_gadget_favorite_config_base`st_3 within w_dashboard_gadget_favorite_wf_cfg
end type

type sle_name from w_dashboard_gadget_favorite_config_base`sle_name within w_dashboard_gadget_favorite_wf_cfg
end type

type st_2 from w_dashboard_gadget_favorite_config_base`st_2 within w_dashboard_gadget_favorite_wf_cfg
end type

type st_1 from w_dashboard_gadget_favorite_config_base`st_1 within w_dashboard_gadget_favorite_wf_cfg
end type

type ddlb_rows_number from w_dashboard_gadget_favorite_config_base`ddlb_rows_number within w_dashboard_gadget_favorite_wf_cfg
end type

type cb_cancel from w_dashboard_gadget_favorite_config_base`cb_cancel within w_dashboard_gadget_favorite_wf_cfg
end type

type cb_ok from w_dashboard_gadget_favorite_config_base`cb_ok within w_dashboard_gadget_favorite_wf_cfg
end type

type dw_data from w_dashboard_gadget_favorite_config_base`dw_data within w_dashboard_gadget_favorite_wf_cfg
string dataobject = "d_dashb_gadget_favorite_workflow_select"
end type

event dw_data::ue_retrieve;call super::ue_retrieve;Post of_apply_right()
end event

type gb_1 from w_dashboard_gadget_favorite_config_base`gb_1 within w_dashboard_gadget_favorite_wf_cfg
string facename = "Segoe UI"
long textcolor = 8388608
end type

