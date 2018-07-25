$PBExportHeader$w_rpt_contract_cptcode.srw
forward
global type w_rpt_contract_cptcode from w_response
end type
type uo_code from u_rpt_tabpg_contract_cptcode within w_rpt_contract_cptcode
end type
end forward

global type w_rpt_contract_cptcode from w_response
integer width = 4091
integer height = 2036
string title = "Select CPT Code(s)"
uo_code uo_code
end type
global w_rpt_contract_cptcode w_rpt_contract_cptcode

on w_rpt_contract_cptcode.create
int iCurrent
call super::create
this.uo_code=create uo_code
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_code
end on

on w_rpt_contract_cptcode.destroy
call super::destroy
destroy(this.uo_code)
end on

event open;call super::open;ib_disableclosequery = True
uo_code.Trigger Event ue_prep_selection()
end event

type uo_code from u_rpt_tabpg_contract_cptcode within w_rpt_contract_cptcode
integer taborder = 30
end type

on uo_code.destroy
call u_rpt_tabpg_contract_cptcode::destroy
end on

