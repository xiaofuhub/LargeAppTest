$PBExportHeader$w_role_treeview.srw
forward
global type w_role_treeview from w_popup
end type
type uo_1 from pfc_cst_u_security_roles_v16 within w_role_treeview
end type
end forward

global type w_role_treeview from w_popup
integer width = 1760
integer height = 2208
long backcolor = 33551856
boolean center = true
uo_1 uo_1
end type
global w_role_treeview w_role_treeview

type variables
integer ii_role
end variables

on w_role_treeview.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_role_treeview.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from pfc_cst_u_security_roles_v16 within w_role_treeview
integer taborder = 10
end type

on uo_1.destroy
call pfc_cst_u_security_roles_v16::destroy
end on

