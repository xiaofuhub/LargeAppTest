$PBExportHeader$w_mastert_contract_search.srw
$PBExportComments$Create by Jack 03/13/2007
forward
global type w_mastert_contract_search from w_response
end type
type uo_search from u_tabpg_master_contract_search within w_mastert_contract_search
end type
end forward

global type w_mastert_contract_search from w_response
integer width = 3886
integer height = 2108
long backcolor = 33551856
uo_search uo_search
end type
global w_mastert_contract_search w_mastert_contract_search

type variables
n_cst_contract inv_contract_codes 
end variables

on w_mastert_contract_search.create
int iCurrent
call super::create
this.uo_search=create uo_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_search
end on

on w_mastert_contract_search.destroy
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
//this.uo_search.CB_1.event clicked( ) //Modified By Alan on 2009-1-16

//inv_contract_codes.of_del_ctx_directory( )
end event

event close;call super::close;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
//if IsValid(inv_contract_codes) then Destroy inv_contract_codes
//---------------------------- APPEON END ----------------------------
end event

event open;call super::open;uo_search.cb_3.visible = true 			//12/26.2008 By Jervis
uo_search.cb_print.visible = false		//Added by Scofield on 2009-05-18

end event

type uo_search from u_tabpg_master_contract_search within w_mastert_contract_search
integer taborder = 20
end type

on uo_search.destroy
call u_tabpg_master_contract_search::destroy
end on

