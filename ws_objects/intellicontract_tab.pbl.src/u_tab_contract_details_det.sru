$PBExportHeader$u_tab_contract_details_det.sru
$PBExportComments$[intellicontract_tab]  Tab  for the contract module
forward
global type u_tab_contract_details_det from u_tab
end type
type tabpage_1 from u_tabpg_contract_detail1 within u_tab_contract_details_det
end type
type tabpage_1 from u_tabpg_contract_detail1 within u_tab_contract_details_det
end type
type tabpage_2 from u_tabpg_contract_detail2 within u_tab_contract_details_det
end type
type tabpage_2 from u_tabpg_contract_detail2 within u_tab_contract_details_det
end type
end forward

global type u_tab_contract_details_det from u_tab
integer width = 3255
integer height = 1924
long backcolor = 33551856
alignment alignment = center!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global u_tab_contract_details_det u_tab_contract_details_det

forward prototypes
public function integer of_reset_retrived_status ()
public function u_tabpg of_gettabpage (integer ai_index)
end prototypes

public function integer of_reset_retrived_status ();
u_tabpg_contract_master	ltpg_contract

integer i

FOR i= 1 TO  upperbound(this.Control)
    ltpg_contract = this.Control[i]
	 ltpg_contract.event ue_reset_ib_retrieve( )
NEXT



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

on u_tab_contract_details_det.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on u_tab_contract_details_det.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event constructor;call super::constructor;

of_getparentwindow(iw_parent)
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

event selectionchanging;call super::selectionchanging;


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

type tabpage_1 from u_tabpg_contract_detail1 within u_tab_contract_details_det
integer x = 18
integer y = 100
integer width = 3218
integer height = 1808
long backcolor = 33551856
end type

type tabpage_2 from u_tabpg_contract_detail2 within u_tab_contract_details_det
integer x = 18
integer y = 100
integer width = 3218
integer height = 1808
end type

