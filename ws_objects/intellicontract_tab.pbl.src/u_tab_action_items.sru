$PBExportHeader$u_tab_action_items.sru
$PBExportComments$[intellicontract_tab]  The action Items Tab on the action items window
forward
global type u_tab_action_items from u_tab
end type
type tabpage_1 from u_tabpage_ctx_ai_graph within u_tab_action_items
end type
type tabpage_1 from u_tabpage_ctx_ai_graph within u_tab_action_items
end type
type tabpage_2 from u_tabpage_ctx_ai_details within u_tab_action_items
end type
type tabpage_2 from u_tabpage_ctx_ai_details within u_tab_action_items
end type
end forward

global type u_tab_action_items from u_tab
string tag = "Contract Action Items"
integer width = 3845
integer height = 1904
long backcolor = 33551856
alignment alignment = center!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global u_tab_action_items u_tab_action_items

type variables

boolean ib_retrieved
end variables

forward prototypes
public function integer of_retrive ()
public function integer of_retrieve_data (string as_series, string as_category)
public function integer of_select_tab_details ()
public function integer of_retrieve_graph (boolean ab_reset)
end prototypes

public function integer of_retrive ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 11 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if not f_validstr(this.tabpage_1.dw_1.dataobject) then
	this.tabpage_1.event ue_constructor( )
   this.tabpage_2.event ue_constructor( )
end if


of_retrieve_graph(false)



return success

end function

public function integer of_retrieve_data (string as_series, string as_category);


this.tabpage_2.function dynamic of_retrieve_data(as_series,as_category)


return 0
end function

public function integer of_select_tab_details ();this.tabpage_2.enabled = true
this.selecttab( 'tabpage_2')


return 0

end function

public function integer of_retrieve_graph (boolean ab_reset);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [boolean] ab_reset - Indicates weather ot not we want to re -retrieve the datawindow
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 21 november 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if ab_reset  then ib_retrieved = false 

if not ib_retrieved  then 
	this.tabpage_1.dw_1.event pfc_retrieve( )
end if 


ib_retrieved = true




return success
end function

on u_tab_action_items.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on u_tab_action_items.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event other;call super::other;
if w_mdi.menuname = 'm_pfe_cst_action_items' then 

	if this.tabpage_2.dw_details.rowcount() > 0 then
		 gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', true)
	else
		 gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', false)
	end if 

end if 


return 0
end event

type tabpage_1 from u_tabpage_ctx_ai_graph within u_tab_action_items
integer x = 18
integer y = 100
integer width = 3808
integer height = 1788
long backcolor = 33551856
end type

type tabpage_2 from u_tabpage_ctx_ai_details within u_tab_action_items
integer x = 18
integer y = 100
integer width = 3808
integer height = 1788
end type

