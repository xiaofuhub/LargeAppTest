$PBExportHeader$u_cst_gadget_recent_ctx.sru
forward
global type u_cst_gadget_recent_ctx from u_cst_gadget
end type
end forward

global type u_cst_gadget_recent_ctx from u_cst_gadget
string tag = "u_gadget_8.Recent Contract"
event ue_refresh_data ( )
end type
global u_cst_gadget_recent_ctx u_cst_gadget_recent_ctx

event ue_refresh_data();//
end event

on u_cst_gadget_recent_ctx.create
call super::create
end on

on u_cst_gadget_recent_ctx.destroy
call super::destroy
end on

event ue_run;call super::ue_run;Long ll_data_id
str_dashboard str_para

If al_row <= 0 Then Return 1

ll_data_id = dw_content.GetItemNumber(al_row,'data_id')
str_para.data_id = ll_data_id

//BEGIN---Modify by Evan 10/29/2008
/*
IF IsValid(w_contract)  THEN
	w_contract.of_dashboard(str_para.data_id)
ELSE
	OpenSheetWithParm(w_contract,str_para,w_mdi,4,Original! )
END IF
*/
if IsValid(gw_contract) then	
	gw_contract.of_Dashboard(str_para.data_id)
else
	gf_OpenContractFolder(str_para)
end if
//END---Modify by Evan 10/29/2008

Return 1
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_recent_ctx
string dataobject = "d_dashb_gadget_recent_ctx"
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_recent_ctx
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_recent_ctx
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_recent_ctx
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_recent_ctx
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_recent_ctx
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_recent_ctx
end type

