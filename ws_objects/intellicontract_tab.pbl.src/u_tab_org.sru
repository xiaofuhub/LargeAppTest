$PBExportHeader$u_tab_org.sru
$PBExportComments$[intellicontract_tab]  Tab for orginzations
forward
global type u_tab_org from u_tab
end type
type tabpage_1 from u_tabpg_org_search within u_tab_org
end type
type tabpage_1 from u_tabpg_org_search within u_tab_org
end type
type tabpage_2 from u_tabpg_org_details within u_tab_org
end type
type tabpage_2 from u_tabpg_org_details within u_tab_org
end type
end forward

global type u_tab_org from u_tab
integer width = 3785
integer height = 1844
long backcolor = 33551856
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global u_tab_org u_tab_org

type variables
long il_org_id
STRING IS_MODE
CONSTANT STRING EDIT = 'EDIT'
CONSTANT STRING NEW = 'NEW'
end variables

forward prototypes
public function integer of_set_mode (string as_mode)
public function integer of_set_org_id (long al_org_id)
public function integer of_retrieve ()
public function integer of_get_org_id ()
public subroutine of_set_retrieve_status ()
end prototypes

public function integer of_set_mode (string as_mode);
IS_MODE = AS_MODE

RETURN SUccess
end function

public function integer of_set_org_id (long al_org_id);
il_org_id = al_org_id
this.tabpage_2.ib_retrieved = false

return success
end function

public function integer of_retrieve ();

this.tabpage_2.enabled = true
this.tabpage_2.of_retrieve( )
return success


end function

public function integer of_get_org_id ();

return il_org_id
end function

public subroutine of_set_retrieve_status ();


//of_set_retrieve


this.tabpage_2.ib_retrieved = false
end subroutine

on u_tab_org.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on u_tab_org.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

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

long ll_selected_row

if newindex = 2 and IS_MODE <> new then

			ll_selected_row = this.tabpage_1.dw_search.getselectedrow( 0)
			
			if ll_selected_row > 0 then 
				of_set_org_id(long(tabpage_1.dw_search.object.org_id[ll_selected_row]))
				tabpage_2.of_retrieve( )
				
			else 
				messagebox(iw_parent.title,'Please select a row.')
				return 1
				
			end if
end if 


if oldindex = 2 then
	if this.tabpage_2.of_validation( ) = failure then return 1
	
end if

this.of_accepttext( true)


end event

type tabpage_1 from u_tabpg_org_search within u_tab_org
integer x = 18
integer y = 100
integer width = 3749
integer height = 1728
long backcolor = 33551856
end type

type tabpage_2 from u_tabpg_org_details within u_tab_org
integer x = 18
integer y = 100
integer width = 3749
integer height = 1728
long backcolor = 33551856
end type

