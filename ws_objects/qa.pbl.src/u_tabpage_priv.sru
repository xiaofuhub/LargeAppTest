$PBExportHeader$u_tabpage_priv.sru
forward
global type u_tabpage_priv from u_tabpg
end type
type uo_priv from pfc_cst_qa_priv within u_tabpage_priv
end type
end forward

global type u_tabpage_priv from u_tabpg
integer width = 3365
integer height = 1804
long backcolor = 33551856
string text = "Privileges"
uo_priv uo_priv
end type
global u_tabpage_priv u_tabpage_priv

on u_tabpage_priv.create
int iCurrent
call super::create
this.uo_priv=create uo_priv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_priv
end on

on u_tabpage_priv.destroy
call super::destroy
destroy(this.uo_priv)
end on

type uo_priv from pfc_cst_qa_priv within u_tabpage_priv
string tag = "Privileges"
integer height = 1796
integer taborder = 20
end type

on uo_priv.destroy
call pfc_cst_qa_priv::destroy
end on

