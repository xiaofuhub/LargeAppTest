$PBExportHeader$u_tabpg_detail_detail_bak.sru
$PBExportComments$[intellicontract_tab] The contract locations Tab Page
forward
global type u_tabpg_detail_detail_bak from u_tab
end type
type tabpage_notes from u_tabpg_contract_detail_notes within u_tabpg_detail_detail_bak
end type
type tabpage_notes from u_tabpg_contract_detail_notes within u_tabpg_detail_detail_bak
end type
type tabpage_custom from u_tabpg_contract_detail_cus within u_tabpg_detail_detail_bak
end type
type tabpage_custom from u_tabpg_contract_detail_cus within u_tabpg_detail_detail_bak
end type
type tabpage_1 from u_tabpg_contract_detail_audit within u_tabpg_detail_detail_bak
end type
type tabpage_1 from u_tabpg_contract_detail_audit within u_tabpg_detail_detail_bak
end type
type tabpage_2 from u_tabpg_contract_detail_linked_contracts within u_tabpg_detail_detail_bak
end type
type tabpage_2 from u_tabpg_contract_detail_linked_contracts within u_tabpg_detail_detail_bak
end type
end forward

global type u_tabpg_detail_detail_bak from u_tab
integer width = 2770
integer height = 700
tabpage_notes tabpage_notes
tabpage_custom tabpage_custom
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global u_tabpg_detail_detail_bak u_tabpg_detail_detail_bak

on u_tabpg_detail_detail_bak.create
this.tabpage_notes=create tabpage_notes
this.tabpage_custom=create tabpage_custom
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_notes
this.Control[iCurrent+2]=this.tabpage_custom
this.Control[iCurrent+3]=this.tabpage_1
this.Control[iCurrent+4]=this.tabpage_2
end on

on u_tabpg_detail_detail_bak.destroy
call super::destroy
destroy(this.tabpage_notes)
destroy(this.tabpage_custom)
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_notes from u_tabpg_contract_detail_notes within u_tabpg_detail_detail_bak
integer x = 18
integer y = 100
integer width = 2734
integer height = 584
string text = "Notes"
end type

type tabpage_custom from u_tabpg_contract_detail_cus within u_tabpg_detail_detail_bak
integer x = 18
integer y = 100
integer width = 2734
integer height = 584
string text = "Custom Data"
end type

type tabpage_1 from u_tabpg_contract_detail_audit within u_tabpg_detail_detail_bak
integer x = 18
integer y = 100
integer width = 2734
integer height = 584
end type

type tabpage_2 from u_tabpg_contract_detail_linked_contracts within u_tabpg_detail_detail_bak
integer x = 18
integer y = 100
integer width = 2734
integer height = 584
string text = "Linked Contracts"
end type

