$PBExportHeader$u_rpt_tabpg_contract_cptcode.sru
forward
global type u_rpt_tabpg_contract_cptcode from u_tabpg_cpt_template
end type
end forward

global type u_rpt_tabpg_contract_cptcode from u_tabpg_cpt_template
end type
global u_rpt_tabpg_contract_cptcode u_rpt_tabpg_contract_cptcode

on u_rpt_tabpg_contract_cptcode.create
call super::create
end on

on u_rpt_tabpg_contract_cptcode.destroy
call super::destroy
end on

event ue_prep_selection;//---------Begin Added by (Appeon)Harry 05.06.2016 for BugH040602 Cancel Extend AncestorScript-------
dw_master.object.item_name.protect = 1

cb_delete.visible = false
cb_insert.visible = false
cb_select.visible = true
//----------End Added------
cb_select.x = cb_2.x
cb_4.visible = False
cb_2.visible = False
end event

type st_1 from u_tabpg_cpt_template`st_1 within u_rpt_tabpg_contract_cptcode
end type

type dw_detail from u_tabpg_cpt_template`dw_detail within u_rpt_tabpg_contract_cptcode
end type

event dw_detail::itemchanged;Return;
end event

event dw_detail::constructor;call super::constructor;of_setupdateable( False )
end event

type dw_master from u_tabpg_cpt_template`dw_master within u_rpt_tabpg_contract_cptcode
end type

event dw_master::constructor;call super::constructor;of_setupdateable( False )
end event

type cb_delete from u_tabpg_cpt_template`cb_delete within u_rpt_tabpg_contract_cptcode
end type

type cb_insert from u_tabpg_cpt_template`cb_insert within u_rpt_tabpg_contract_cptcode
end type

type gb_1 from u_tabpg_cpt_template`gb_1 within u_rpt_tabpg_contract_cptcode
end type

type gb_2 from u_tabpg_cpt_template`gb_2 within u_rpt_tabpg_contract_cptcode
end type

type cb_2 from u_tabpg_cpt_template`cb_2 within u_rpt_tabpg_contract_cptcode
end type

type cb_4 from u_tabpg_cpt_template`cb_4 within u_rpt_tabpg_contract_cptcode
end type

type cb_select from u_tabpg_cpt_template`cb_select within u_rpt_tabpg_contract_cptcode
end type

event cb_select::clicked;Long ll_rowcount, ll_loop
String ls_code, ls_return, ls_description
Integer ll_selected

ll_rowcount = dw_detail.rowcount()
For ll_loop = 1 to ll_rowcount
	ll_selected = dw_detail.GetItemNumber( ll_loop, "selected" )
	if isnull( ll_selected ) or ll_selected = 0 then continue;

	ls_code = dw_detail.GetItemString( ll_loop, "cpt_code" )
	ls_description = dw_detail.GetItemString( ll_loop, "code_description" )
	if isnull( ls_description) or Trim( ls_description ) = '' then
		ls_description = ls_code
	end if

	ls_return += ls_code + '~t' + ls_description + '|'
Next

if ls_return <> '' then ls_return = Left( ls_return, Len( ls_return ) - 1 )
CloseWithReturn( iw_parent, ls_return )
end event

type cb_selectall from u_tabpg_cpt_template`cb_selectall within u_rpt_tabpg_contract_cptcode
end type

type cb_sort from u_tabpg_cpt_template`cb_sort within u_rpt_tabpg_contract_cptcode
end type

type cb_filter from u_tabpg_cpt_template`cb_filter within u_rpt_tabpg_contract_cptcode
end type

type cb_copybase from u_tabpg_cpt_template`cb_copybase within u_rpt_tabpg_contract_cptcode
end type

