$PBExportHeader$u_tabpage_fee_schedule_detail.sru
$PBExportComments$[intellicontract_tab]  Contract Contact Tab Page
forward
global type u_tabpage_fee_schedule_detail from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpage_fee_schedule_detail
end type
end forward

global type u_tabpage_fee_schedule_detail from u_tabpg_contract_master
integer width = 3918
integer height = 1940
long backcolor = 33551856
event pfc_new ( )
event ue_set_screen_properties ( )
dw_1 dw_1
end type
global u_tabpage_fee_schedule_detail u_tabpage_fee_schedule_detail

forward prototypes
public function integer of_retrieve ()
end prototypes

event ue_set_screen_properties();// Set screen properties
dw_1.of_set_properties(dw_1.il_ViewID, dw_1.il_ScreenID, "Y")
end event

public function integer of_retrieve ();








if ib_retrieved = false then
	dw_1.event pfc_retrieve( )
	
	end if

ib_retrieved = true

return success
end function

on u_tabpage_fee_schedule_detail.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpage_fee_schedule_detail.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_selectionchanging;


// override

return 0
end event

event ue_selectionchanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-06 By: Rodger Wu (Contract)
//$<reason> Fix a defect.

Long ll_ctx_id, ll_fee_id

IF dw_1.rowcount() < 1 THEN
	ll_ctx_id = inv_contract_details.of_get_ctx_id( )
	ll_fee_id = inv_contract_details.of_get_fee_id( )
	IF ll_ctx_id > 0 AND ll_fee_id > 0 THEN
		dw_1.retrieve( ll_ctx_id, ll_fee_id )
	END IF
END IF

//---------------------------- APPEON END ----------------------------









// override



return
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpage_fee_schedule_detail
integer x = 59
integer y = 1680
integer height = 108
end type

type dw_1 from u_dw_contract within u_tabpage_fee_schedule_detail
string tag = "User Defined data"
integer y = 4
integer width = 3840
integer height = 1852
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "User Defined data"
boolean ib_rmbmenu = false
string dataobject_original = "d_ctx_schedule_fee_notes"
end type

event pfc_retrieve;call super::pfc_retrieve;




this.retrieve(inv_contract_details.of_get_ctx_id( ),inv_contract_details.of_get_fee_id( ) )

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-09-06 By: Rodger Wu (Contract)
//$<reason> Comment out for fixing a defect.

/* IF THIS.ROWCOUNT() < 1 THEN INSERTROW(0) */

//---------------------------- APPEON END ----------------------------

return success
end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/




///////////////////////////////////////////////////////////////////////////////////////////
// check to see if the priamry key exists in the database 
///////////////////////////////////////////////////////////////////////////////////////////




return success
end event

event pfc_addrow;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-06 By: Rodger Wu (Contract)
//$<reason> Override for fixing a defect.
Return 0;
//---------------------------- APPEON END ----------------------------

end event

