$PBExportHeader$u_tab_fee_schedule.sru
$PBExportComments$[intellicontract_tab]  Contract Contact Tab Page
forward
global type u_tab_fee_schedule from u_tab
end type
type tabpage_fee_browse from u_tabpage_fee_schedule_main within u_tab_fee_schedule
end type
type tabpage_fee_browse from u_tabpage_fee_schedule_main within u_tab_fee_schedule
end type
type tabpage_fee_notes from u_tabpage_fee_schedule_detail within u_tab_fee_schedule
end type
type tabpage_fee_notes from u_tabpage_fee_schedule_detail within u_tab_fee_schedule
end type
end forward

global type u_tab_fee_schedule from u_tab
string tag = "Browse"
integer width = 3918
integer height = 1988
long backcolor = 33551856
alignment alignment = center!
tabpage_fee_browse tabpage_fee_browse
tabpage_fee_notes tabpage_fee_notes
end type
global u_tab_fee_schedule u_tab_fee_schedule

type variables
long il_contact_id
STRING IS_MODE
CONSTANT STRING EDIT = 'EDIT'
CONSTANT STRING NEW = 'NEW'
end variables

forward prototypes
public function integer of_reset_retrived_status ()
public function u_tabpg of_gettabpage (integer ai_index)
end prototypes

public function integer of_reset_retrived_status ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: of_reset_retrived_status
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


u_tabpg_contract_master	ltpg_contract

integer i

THIS.TABpage_fee_browse.event ue_reset_ib_retrieve( )
THIS.tabpage_fee_notes.event ue_reset_ib_retrieve( )




return success


return success
end function

public function u_tabpg of_gettabpage (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
// Function:		of_GetTabPage
// 
// Arguments:		ai_index = index of the tabpage in the control array
//
//	Returns:  		u_tabpage
//						the specified tab page
//
// Description:	Return the specified tab page based upon the index, ai_index.
//
// Logs:
//
// DATE      WHO            WHAT
// --------  ------------   ---------------
//	          mskinner
//////////////////////////////////////////////////////////////////////////////

Return this.Control[ai_index]
end function

event selectionchanging;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long li_rc 

u_tabpg_contract_master	lu_tabpg

//if newindex = 1 and oldindex = 2 then return -1

if iw_parent.function dynamic wf_get_save_status() = false then
		If oldindex > 0 Then
			// get the current tab page index
			lu_tabpg = of_GetTabPage (oldindex)
			li_rc = lu_tabpg.Event ue_selectionchanging()
		End If
end if
Return li_rc

end event

on u_tab_fee_schedule.create
this.tabpage_fee_browse=create tabpage_fee_browse
this.tabpage_fee_notes=create tabpage_fee_notes
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_fee_browse
this.Control[iCurrent+2]=this.tabpage_fee_notes
end on

on u_tab_fee_schedule.destroy
call super::destroy
destroy(this.tabpage_fee_browse)
destroy(this.tabpage_fee_notes)
end on

event constructor;call super::constructor;
tabpage_fee_browse.dw_main.of_SetLinkage(true)
tabpage_fee_browse.dw_codes.of_SetLinkage(true)
tabpage_fee_browse.dw_locations.of_SetLinkage(true)
tabpage_fee_browse.dw_fee_schedule.of_SetLinkage(true)
tabpage_fee_notes.dw_1.of_SetLinkage(true)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tabpage_fee_browse.dw_codes.inv_linkage.of_SetMaster(tabpage_fee_browse.dw_main)
tabpage_fee_browse.dw_codes.inv_linkage.of_Register("fee_sched_id", "fee_sched_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//tabpage_fee_browse.dw_codes.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 
n_cst_dwsrv_linkage lnv_cst_dwsrv_linkage
lnv_cst_dwsrv_linkage = Create n_cst_dwsrv_linkage
tabpage_fee_browse.dw_codes.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve) 
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tabpage_fee_browse.dw_locations.inv_linkage.of_SetMaster(tabpage_fee_browse.dw_main )
tabpage_fee_browse.dw_locations.inv_linkage.of_Register("fee_sched_id", "fee_sched_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//tabpage_fee_browse.dw_locations.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
tabpage_fee_browse.dw_locations.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_SetMaster(tabpage_fee_browse.dw_locations )
tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_Register("fee_sched_location_id", "fee_sched_location_id")
//--------------------------- APPEON BEGIN ---------------------------
///$<ID> UM-03
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tabpage_fee_notes.dw_1.inv_linkage.of_SetMaster(tabpage_fee_browse.dw_main )
tabpage_fee_notes.dw_1.inv_linkage.of_Register("ctx_id", "ctx_id")
tabpage_fee_notes.dw_1.inv_linkage.of_Register("fee_sched_id", "fee_sched_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-04
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//tabpage_fee_notes.dw_1.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
tabpage_fee_notes.dw_1.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
Destroy lnv_cst_dwsrv_linkage
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// set the update properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tabpage_fee_browse.dw_main.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//tabpage_1.dw_main.inv_linkage.of_SetConfirmOnRowChange(TRUE)

tabpage_fee_browse.dw_codes.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//tabpage_1.dw_codes.inv_linkage.of_SetConfirmOnRowChange(TRUE)

tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//tabpage_1.dw_fee_schedule.inv_linkage.of_SetConfirmOnRowChange(TRUE)


tabpage_fee_browse.dw_locations.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//tabpage_1.dw_locations.inv_linkage.of_SetConfirmOnRowChange(TRUE)


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the delete delete style
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tabpage_fee_browse.dw_main.inv_linkage.of_SetDeleteStyle(tabpage_fee_browse.dw_main.inv_linkage.DELETE_ROWS)
tabpage_fee_browse.dw_codes.inv_linkage.of_SetDeleteStyle(tabpage_fee_browse.dw_main.inv_linkage.bottomup  )
tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_SetDeleteStyle(tabpage_fee_browse.dw_main.inv_linkage.bottomup  )
tabpage_fee_browse.dw_locations.inv_linkage.of_SetDeleteStyle(tabpage_fee_browse.dw_main.inv_linkage.bottomup  )

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// set the delete properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tabpage_fee_browse.dw_main.inv_linkage.of_SetConfirmOnDelete ( true )
//tabpage_fee_browse.dw_codes.inv_linkage.of_SetConfirmOnDelete ( true )			//Commented by Scofield on 2008-03-11
//tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_SetConfirmOnDelete ( true )	//Commented by Scofield on 2008-03-11
tabpage_fee_browse.dw_locations.inv_linkage.of_SetConfirmOnDelete ( true )

tabpage_fee_browse.dw_main.inv_linkage.of_SetDeleteStyle ( 0 )
tabpage_fee_browse.dw_codes.inv_linkage.of_SetDeleteStyle ( 1 )
tabpage_fee_browse.dw_fee_schedule.inv_linkage.of_SetDeleteStyle ( 1 )
tabpage_fee_browse.dw_locations.inv_linkage.of_SetDeleteStyle (0 )

tabpage_fee_browse.dw_main.inv_linkage.of_SetTransObject(SQLCA)
end event

event selectionchanged;call super::selectionchanged;//////////////////////////////////////////////////////////////////////////////
//
// Event:			selectionchanged
// 
//	Arguments:		oldindex = tabpage losing focus
//						newindex = tabpage gaining focus
//
//	Returns:			Integer
//						1 = Do not allow tab to change
//						0 = Allow tab to change
//
// Description:	Trigger ue_selectionchanged event on u_tabpg. Process Return Code
//
// Logs:
//
// DATE      WHO            WHAT
// --------  ------------   ---------------
//	
//////////////////////////////////////////////////////////////////////////////

u_tabpg_contract_master	lu_tabpg
//
//if oldindex = -1 then Return success
////if newindex = 1 and oldindex = 2  then Return success
//

if iw_parent.function dynamic wf_get_save_status() = false then
	If newindex > 0 Then
		lu_tabpg = of_GetTabPage (newindex)
		lu_tabpg.Event ue_selectionchanged ()
	End If
end if
Return success

end event

type tabpage_fee_browse from u_tabpage_fee_schedule_main within u_tab_fee_schedule
integer x = 18
integer y = 112
integer height = 1860
string text = "Browse"
string picturename = "custom065!"
long picturemaskcolor = 12632256
string powertiptext = "Browse"
end type

type tabpage_fee_notes from u_tabpage_fee_schedule_detail within u_tab_fee_schedule
integer x = 18
integer y = 112
integer width = 3881
integer height = 1860
string text = "Notes"
string picturename = "custom070!"
long picturemaskcolor = 12632256
string powertiptext = "Notes"
end type

