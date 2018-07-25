$PBExportHeader$u_tabpg_email_audit_detail.sru
forward
global type u_tabpg_email_audit_detail from u_tabpg
end type
type dw_1 from u_dw within u_tabpg_email_audit_detail
end type
end forward

global type u_tabpg_email_audit_detail from u_tabpg
integer width = 3945
integer height = 2344
long backcolor = 33551856
dw_1 dw_1
end type
global u_tabpg_email_audit_detail u_tabpg_email_audit_detail

on u_tabpg_email_audit_detail.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_email_audit_detail.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within u_tabpg_email_audit_detail
integer x = 9
integer y = 12
integer width = 3895
integer height = 2304
integer taborder = 10
string title = "none"
string dataobject = "d_email_audit"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)
end event

