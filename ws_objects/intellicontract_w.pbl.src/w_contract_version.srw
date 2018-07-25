$PBExportHeader$w_contract_version.srw
forward
global type w_contract_version from w_response
end type
type dw_1 from u_dw within w_contract_version
end type
end forward

global type w_contract_version from w_response
integer width = 1655
integer height = 1112
string title = "Contract Version"
long backcolor = 33551856
dw_1 dw_1
end type
global w_contract_version w_contract_version

on w_contract_version.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_contract_version.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;long ll_ctx_id
ll_ctx_id = message.doubleparm
dw_1.settransobject(sqlca)
dw_1.retrieve(ll_ctx_id)

end event

type dw_1 from u_dw within w_contract_version
integer x = 9
integer y = 12
integer taborder = 10
string dataobject = "d_contract_version"
end type

