$PBExportHeader$w_rpt_contract_search.srw
forward
global type w_rpt_contract_search from w_response
end type
type uo_search from u_rpt_tabpg_contract_search within w_rpt_contract_search
end type
end forward

global type w_rpt_contract_search from w_response
integer width = 3886
integer height = 2104
uo_search uo_search
end type
global w_rpt_contract_search w_rpt_contract_search

type variables
n_cst_contract inv_contract_codes 
end variables

on w_rpt_contract_search.create
int iCurrent
call super::create
this.uo_search=create uo_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_search
end on

on w_rpt_contract_search.destroy
call super::destroy
destroy(this.uo_search)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx August 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
ib_disableclosequery = True

inv_contract_codes = CREATE n_cst_contract
This.uo_search.of_set_contract_details(inv_contract_codes)

if IsValid(w_custom_report) then
	if w_custom_report.ib_AutoRetrieve then
		This.uo_search.CB_1.Event clicked()
	end if
else
	This.uo_search.CB_1.Event clicked()
end if

end event

event close;call super::close;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
//if IsValid(inv_contract_codes) then Destroy inv_contract_codes 
//---------------------------- APPEON END ----------------------------
end event

type uo_search from u_rpt_tabpg_contract_search within w_rpt_contract_search
string tag = ""
integer taborder = 20
end type

on uo_search.destroy
call u_rpt_tabpg_contract_search::destroy
end on

