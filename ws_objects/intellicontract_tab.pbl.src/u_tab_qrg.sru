$PBExportHeader$u_tab_qrg.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tab_qrg from u_tab
end type
type tabpage_selection from u_tabpg_qrg_selection within u_tab_qrg
end type
type tabpage_selection from u_tabpg_qrg_selection within u_tab_qrg
end type
type tabpage_build from u_tabpg_qrg_build within u_tab_qrg
end type
type tabpage_build from u_tabpg_qrg_build within u_tab_qrg
end type
type tabpage_preview from u_tabpg_qrg_preview within u_tab_qrg
end type
type tabpage_preview from u_tabpg_qrg_preview within u_tab_qrg
end type
end forward

global type u_tab_qrg from u_tab
integer width = 4448
integer height = 1996
long backcolor = 33551856
alignment alignment = center!
boolean ib_alwaysvalidate = true
tabpage_selection tabpage_selection
tabpage_build tabpage_build
tabpage_preview tabpage_preview
end type
global u_tab_qrg u_tab_qrg

type variables
 n_cst_cxt_reports inv_ctx_reports

long	il_curindex
end variables

forward prototypes
public function integer of_reset_retrived_status ()
public function u_tabpg of_gettabpage (integer ai_index)
public function integer of_retrieve ()
end prototypes

public function integer of_reset_retrived_status ();/**==================================================================================================================
**  Purpose   	: of_reset_retrived_status
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 July 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


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

public function integer of_retrieve ();


//this.tabpage_selection.


RETURN 0
end function

on u_tab_qrg.create
this.tabpage_selection=create tabpage_selection
this.tabpage_build=create tabpage_build
this.tabpage_preview=create tabpage_preview
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_selection
this.Control[iCurrent+2]=this.tabpage_build
this.Control[iCurrent+3]=this.tabpage_preview
end on

on u_tab_qrg.destroy
call super::destroy
destroy(this.tabpage_selection)
destroy(this.tabpage_build)
destroy(this.tabpage_preview)
end on

event selectionchanged;call super::selectionchanged;


if newindex > 1 then
    tabpage_selection.dw_basic_info.sharedata( inv_ctx_reports.ids_basic_info )
	 this.tabpage_preview.of_set_details(inv_ctx_reports )
end if 

inv_ctx_reports = THIS.tabpage_selection.inv_ctx_reports
tabpage_preview.inv_ctx_reports =tabpage_selection.inv_ctx_reports


if newindex = 3 then
	THIS.TABpage_preview.OF_Retrieve( )
END IF 


//Added By Alan on 2009-1-7 BugN101002
if IsValid(m_pfe_cst_mdi_menu_contract) then
	if NewIndex = 3 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', False)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
	end if
end if

il_curindex = newindex
end event

event selectionchanging;call super::selectionchanging;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 28 July 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long li_rc 

u_tabpg_contract_master	lu_tabpg


if iw_parent.function dynamic wf_get_save_status() = false then
		If oldindex > 0 Then
			// get the current tab page index
    	   lu_tabpg = of_GetTabPage (oldindex)
			li_rc = lu_tabpg.Event ue_selectionchanging()
		End If
end if
Return li_rc

end event

event constructor;call super::constructor;   inv_ctx_reports =  create n_cst_cxt_reports 
	
	
	
	
	this.tabpage_preview.of_set_details(inv_ctx_reports )
	
   tabpage_selection.inv_ctx_reports = 	inv_ctx_reports
end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(inv_ctx_reports) then Destroy inv_ctx_reports
//---------------------------- APPEON END ----------------------------
end event

type tabpage_selection from u_tabpg_qrg_selection within u_tab_qrg
integer x = 18
integer y = 112
integer width = 4411
integer height = 1868
string text = "Select Data"
string picturename = "selecttable!"
long picturemaskcolor = 12632256
string powertiptext = "QRG Select Data"
boolean ib_retrieved = false
end type

type tabpage_build from u_tabpg_qrg_build within u_tab_qrg
integer x = 18
integer y = 112
integer width = 4411
integer height = 1868
string text = "Build"
string powertiptext = "QRG Build"
end type

type tabpage_preview from u_tabpg_qrg_preview within u_tab_qrg
integer x = 18
integer y = 112
integer width = 4411
integer height = 1868
string text = "Preview"
string picturename = "custom090!"
long picturemaskcolor = 12632256
string powertiptext = "QRG Preview"
end type

