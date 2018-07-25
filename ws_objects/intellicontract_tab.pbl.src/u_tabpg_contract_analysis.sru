$PBExportHeader$u_tabpg_contract_analysis.sru
$PBExportComments$[intellicontract_tab] The contract locations Tab Page
forward
global type u_tabpg_contract_analysis from u_tabpg_contract_master
end type
end forward

global type u_tabpg_contract_analysis from u_tabpg_contract_master
boolean visible = false
boolean enabled = false
long backcolor = 33551856
string text = "Analysis"
string powertiptext = "Analysis"
end type
global u_tabpg_contract_analysis u_tabpg_contract_analysis

forward prototypes
public function integer of_retrieve ()
end prototypes

public function integer of_retrieve ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if not ib_retrieved then
	 
end if

ib_retrieved = true

RETURN SUCcess
end function

on u_tabpg_contract_analysis.create
call super::create
end on

on u_tabpg_contract_analysis.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;//
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_analysis
long backcolor = 33551856
end type

