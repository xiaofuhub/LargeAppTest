$PBExportHeader$u_tabpage_measurments_action_items.sru
forward
global type u_tabpage_measurments_action_items from u_tabpg
end type
type p_1 from picture within u_tabpage_measurments_action_items
end type
type dw_1 from u_dw within u_tabpage_measurments_action_items
end type
end forward

global type u_tabpage_measurments_action_items from u_tabpg
integer width = 3214
integer height = 1436
string text = "Action Items"
string picturename = "Watcom!"
string powertiptext = "Action Items"
event pfc_cst_letter ( )
p_1 p_1
dw_1 dw_1
end type
global u_tabpage_measurments_action_items u_tabpage_measurments_action_items

type variables


protected:

long il_prac_id
long il_qd_pd_hdr_id
end variables

forward prototypes
public subroutine of_set_prac_id (integer al_prac_id)
public subroutine of_set_hdr_id (long al_header_id)
public function long of_get_sequence_number ()
public subroutine of_retrieve_dropdowns (long al_qd_pd_hdr_id)
public function integer of_insert_action_item (string as_notes, long al_action_to)
end prototypes

event pfc_cst_letter();/****************************************************************************************************************
** [PUBLIC] EVENT    U_TABPAGE_MEASURMENTS_ACTION_ITEMS :: pfc_cst_letter
**--------------------------------------------------------------------------------------------------------------
** Description    :  Opens the letter window 
**--------------------------------------------------------------------------------------------------------------
** Notes          :  This code mimics the code in uo_peer_review_alternate::of_letter
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[NONE] 
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
****************************************************************************************************************/
str_pass lstr_pass
lstr_pass.w_parent_window = iw_parent


if il_prac_id = 0 then
	OF_Messagebox( '',  iw_parent.title , 'Please select a practitioner before continuing.', information!, ok!, 1)
	 RETURN 
end if 

if il_qd_pd_hdr_id = 0 or isnull(il_qd_pd_hdr_id) then
	OF_Messagebox( '',  iw_parent.title , 'Please create a Quality Profile before continuing.', information!, ok!, 1)
	RETURN 
end if

Openwithparm( w_letter_generator,lstr_pass )

if isvalid(w_letter_generator) then
	w_letter_generator.of_quality_profile_letter( il_prac_id, il_qd_pd_hdr_id, 1 )
end if 




end event

public subroutine of_set_prac_id (integer al_prac_id);/****************************************************************************************************************
** [PUBLIC]  FUNCTION of_set_prac_id
**--------------------------------------------------------------------------------------------------------------
** Description: SET THE PRAC_ID VARIABLE
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] al_prac_id
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		TUESDAY November 16 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/



il_prac_id = al_prac_id

end subroutine

public subroutine of_set_hdr_id (long al_header_id);/****************************************************************************************************************
** [PUBLIC]  FUNCTION of_set_hdr_id( /*long al_header_id */)
**--------------------------------------------------------------------------------------------------------------
** Description: SET THE PRAC_ID VARIABLE
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] al_prac_id
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		TUESDAY November 16 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/



il_qd_pd_hdr_id = al_header_id

end subroutine

public function long of_get_sequence_number ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]  FUNCTION  : of_get_sequence_number
//==================================================================================================================
//  Purpose   	: GET THE NET SEQUENCE NUMBER FOR INSERTING
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
long ll_count
long ll_return 
SELECT max(pd_peer_review_action_items_id)
into :ll_count
FROM qa_pd_review_action_items;


if isnull(ll_count) then ll_count = 1

return ll_count + 1



end function

public subroutine of_retrieve_dropdowns (long al_qd_pd_hdr_id);/****************************************************************************************************************
** [PUBLIC] fUNCTON   of_retrieve_dropdowns( )
**--------------------------------------------------------------------------------------------------------------
** Description		 :
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	[long] al_qd_pd_hdr_id
**
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	(NONE) 
**--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**4
**
****************************************************************************************************************/
DATAWINDOWCHILD DW_CHILD

IF DW_1.rowcount() < 1 then return 

   THIS.DW_1.getchild('ACTION_STATUS', DW_CHILD)
   DW_CHILD.SETTRANSOBJECT(SQLCA)
   DW_CHILD.Retrieve("Case/Peer Review Action Item Status")
   //action_type
   THIS.DW_1.getchild('action_type', DW_CHILD)
   DW_CHILD.SETTRANSOBJECT(SQLCA)
   
	DW_CHILD.Retrieve("Case/Peer Review Action Item Type")
   ///action_to
	
	
	THIS.DW_1.getchild('action_to', DW_CHILD)
	DW_CHILD.SETTRANSOBJECT(SQLCA)
	//DW_CHILD.RETrieve('action to')
	DW_CHILD.Retrieve("Case/Peer Review Action Item To")
	





end subroutine

public function integer of_insert_action_item (string as_notes, long al_action_to);/****************************************************************************************************************
** [PUBLIC] FUNCTION  u_tabpagr_measurements_action_items :: of_insert_action_item
**--------------------------------------------------------------------------------------------------------------
** Description    : inserts record in action item and updates it
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[string] as_notes
**	                  [long] al_action_to
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/


long ll_row
ll_row = dw_1.insertrow(1)

dw_1.SetItem( ll_row, "pd_peer_review_action_items_id", of_get_sequence_number() )
dw_1.SetItem( ll_row, "pd_qa_hdr_id", il_qd_pd_hdr_id )
dw_1.SetItem( ll_row, "action_type", -10003 )
dw_1.SetItem( ll_row, "action_to", al_action_to )
dw_1.SetItem( ll_row, "action_date", today() )
dw_1.SetItem( ll_row, "action_user", gs_user_id )
//dw_1.SetItem( ll_row, "active_status", al_ActiveStatus )
dw_1.SetItem( ll_row, "date_completed", today() )
dw_1.SetItem( ll_row, "action_status", -10008)
//dw_1.SetItem( ll_row, "id", ade_Id )
//dw_1.SetItem( ll_row, "action_to_name", as_ActionToName )
dw_1.SetItem( ll_row, "notes", as_Notes )
dw_1.SetItem( ll_row, "prac_id", il_prac_id )

dw_1.update()





return success
end function

on u_tabpage_measurments_action_items.create
int iCurrent
call super::create
this.p_1=create p_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.dw_1
end on

on u_tabpage_measurments_action_items.destroy
call super::destroy
destroy(this.p_1)
destroy(this.dw_1)
end on

event ue_reset;call super::ue_reset;


dw_1.reset()
il_prac_id = 0
il_qd_pd_hdr_id  = 0
end event

type p_1 from picture within u_tabpage_measurments_action_items
boolean visible = false
integer x = 14
integer y = 88
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Custom035!"
boolean focusrectangle = false
end type

type dw_1 from u_dw within u_tabpage_measurments_action_items
integer width = 3186
integer height = 1420
integer taborder = 10
string dataobject = "d_pd_case_review_action_items"
end type

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : contructor dw_1::u_tabpage_measurements_brouse
//==================================================================================================================
//  Purpose   	: Set up needed services for the datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]  not used    
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ib_rmbmenu	= true

//THIS.of_SetRowSelect(TRUE)
//THIS.inv_rowselect.of_SetStyle(THIS.inv_rowselect.single )


SETNULL(il_prac_id)
SETNULL(il_qd_pd_hdr_id)

this.setrowfocusindicator( p_1)
end event

event pfc_updateprep;call super::pfc_updateprep;/****************************************************************************************************************
** [PUBLIC] EVENT   PFC_UPDATEPrep( )
**--------------------------------------------------------------------------------------------------------------
** Description	:
**--------------------------------------------------------------------------------------------------------------
** Arguments	:	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Returns		:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author		:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/

LONG LL_ACTION_ID
setnull(LL_ACTION_ID)
long ll_i


IF ISNULL(il_qd_pd_hdr_id) OR ISNULL(il_prac_id) THEN
	RETURN FAILure
END IF


// RETUERN IF THERE ARE NO ROWS 





//if this.ROWCOUNT() <  1 then return FAILURE

// LOOP THROUGHT THE DATAWINDOW AND SET THE NEEDED IDS
FOR ll_i =1 to this.rowcount( )
	if isnull(this.object.pd_peer_review_action_items_id[ll_i]) and isnull(LL_ACTION_ID) then
		// only get the LL_ACTION_ID -once
		LL_ACTION_ID  =  OF_get_sequence_number()
		this.object.pd_peer_review_action_items_id[ll_i] =  LL_ACTION_ID
	end if
	
	if isnull(this.object.pd_peer_review_action_items_id[ll_i]) and not isnull(LL_ACTION_ID) THEN
		 // INCREMENT THE ID
	    LL_ACTION_ID =  LL_ACTION_ID + 1
		 this.object.pd_peer_review_action_items_id[ll_i] = LL_ACTION_ID
	END IF
   
	this.object.pd_qa_hdr_id[ll_i] = il_qd_pd_hdr_id
	this.object.prac_id[ll_i] = il_prac_id

NEXT


RETURN SUCCESS
end event

event pfc_retrieve;call super::pfc_retrieve;/****************************************************************************************************************
** [PUBLIC] EVENT   selectionchanged :: UO_TAB_MEASUREMENTS
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] oldindex
**				   [long] newindex
**
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

if isnull(il_qd_pd_hdr_id) or il_qd_pd_hdr_id = 0 then return success

if this.rowcount( ) < 1 then
	
	THIS.retrieve(il_qd_pd_hdr_id)
	of_retrieve_dropdowns(il_qd_pd_hdr_id)
	

	else 
		// only retrieve if this a new header id
		if il_qd_pd_hdr_id <> this.object.pd_qa_hdr_id[1] then 
				THIS.retrieve(il_qd_pd_hdr_id)
		   	of_retrieve_dropdowns(il_qd_pd_hdr_id )
		end if 
		
end if 







return success
end event

event pfc_addrow;call super::pfc_addrow;





of_retrieve_dropdowns(il_qd_pd_hdr_id)

RETURN 1 
end event

