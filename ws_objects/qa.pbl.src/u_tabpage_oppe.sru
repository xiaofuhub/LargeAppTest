$PBExportHeader$u_tabpage_oppe.sru
forward
global type u_tabpage_oppe from u_tabpg
end type
type uo_oppe from uo_oppe_fppe_evals within u_tabpage_oppe
end type
end forward

global type u_tabpage_oppe from u_tabpg
integer width = 3703
integer height = 1856
long backcolor = 33551856
string text = "OPPE/FPPE"
uo_oppe uo_oppe
end type
global u_tabpage_oppe u_tabpage_oppe

on u_tabpage_oppe.create
int iCurrent
call super::create
this.uo_oppe=create uo_oppe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_oppe
end on

on u_tabpage_oppe.destroy
call super::destroy
destroy(this.uo_oppe)
end on

type uo_oppe from uo_oppe_fppe_evals within u_tabpage_oppe
string tag = "OPPE/FPPE"
integer height = 1828
integer taborder = 90
end type

on uo_oppe.destroy
call uo_oppe_fppe_evals::destroy
end on

