$PBExportHeader$u_tab_action_items_det.sru
forward
global type u_tab_action_items_det from u_tab
end type
type tabpage_browse from u_tabpg_contract_action_items_det_browse within u_tab_action_items_det
end type
type tabpage_browse from u_tabpg_contract_action_items_det_browse within u_tab_action_items_det
end type
type tabpage_detail from u_tabpg_contract_action_items_det_detail within u_tab_action_items_det
end type
type tabpage_detail from u_tabpg_contract_action_items_det_detail within u_tab_action_items_det
end type
end forward

global type u_tab_action_items_det from u_tab
integer width = 3959
integer height = 2004
long backcolor = 33551856
alignment alignment = center!
integer selectedtab = 2
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
global u_tab_action_items_det u_tab_action_items_det

on u_tab_action_items_det.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_browse
this.Control[iCurrent+2]=this.tabpage_detail
end on

on u_tab_action_items_det.destroy
call super::destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

type tabpage_browse from u_tabpg_contract_action_items_det_browse within u_tab_action_items_det
integer x = 18
integer y = 112
integer width = 3922
integer height = 1876
long backcolor = 33551856
string picturename = "custom065!"
long picturemaskcolor = 12632256
end type

type tabpage_detail from u_tabpg_contract_action_items_det_detail within u_tab_action_items_det
integer x = 18
integer y = 112
integer width = 3922
integer height = 1876
long backcolor = 33551856
string picturename = "custom100!"
long picturemaskcolor = 12632256
end type

