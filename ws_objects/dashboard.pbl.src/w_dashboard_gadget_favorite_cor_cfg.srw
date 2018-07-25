$PBExportHeader$w_dashboard_gadget_favorite_cor_cfg.srw
forward
global type w_dashboard_gadget_favorite_cor_cfg from w_dashboard_gadget_favorite_config_base
end type
end forward

global type w_dashboard_gadget_favorite_cor_cfg from w_dashboard_gadget_favorite_config_base
end type
global w_dashboard_gadget_favorite_cor_cfg w_dashboard_gadget_favorite_cor_cfg

on w_dashboard_gadget_favorite_cor_cfg.create
call super::create
end on

on w_dashboard_gadget_favorite_cor_cfg.destroy
call super::destroy
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>openw_dashboard_gadget_favorite_cor_config()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-11 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Register column name
of_register('sys_letters_letter_id')
end event

type cb_default from w_dashboard_gadget_favorite_config_base`cb_default within w_dashboard_gadget_favorite_cor_cfg
end type

type st_3 from w_dashboard_gadget_favorite_config_base`st_3 within w_dashboard_gadget_favorite_cor_cfg
end type

type sle_name from w_dashboard_gadget_favorite_config_base`sle_name within w_dashboard_gadget_favorite_cor_cfg
end type

type st_2 from w_dashboard_gadget_favorite_config_base`st_2 within w_dashboard_gadget_favorite_cor_cfg
end type

type st_1 from w_dashboard_gadget_favorite_config_base`st_1 within w_dashboard_gadget_favorite_cor_cfg
end type

type ddlb_rows_number from w_dashboard_gadget_favorite_config_base`ddlb_rows_number within w_dashboard_gadget_favorite_cor_cfg
end type

type cb_cancel from w_dashboard_gadget_favorite_config_base`cb_cancel within w_dashboard_gadget_favorite_cor_cfg
end type

type cb_ok from w_dashboard_gadget_favorite_config_base`cb_ok within w_dashboard_gadget_favorite_cor_cfg
end type

type dw_data from w_dashboard_gadget_favorite_config_base`dw_data within w_dashboard_gadget_favorite_cor_cfg
string dataobject = "d_dashb_gadget_favorite_cor_select"
end type

type gb_1 from w_dashboard_gadget_favorite_config_base`gb_1 within w_dashboard_gadget_favorite_cor_cfg
string facename = "Segoe UI"
long textcolor = 8388608
end type

