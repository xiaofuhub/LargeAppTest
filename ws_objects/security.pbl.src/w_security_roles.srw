$PBExportHeader$w_security_roles.srw
forward
global type w_security_roles from w_response
end type
type uo_1 from pfc_cst_u_security_roles_painter within w_security_roles
end type
end forward

global type w_security_roles from w_response
integer width = 3122
integer height = 1748
string title = "Security Roles"
long backcolor = 33551856
uo_1 uo_1
end type
global w_security_roles w_security_roles

on w_security_roles.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_security_roles.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from pfc_cst_u_security_roles_painter within w_security_roles
integer y = 40
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call pfc_cst_u_security_roles_painter::destroy
end on

