$PBExportHeader$u_tabpg_contract_fee_schedules.sru
$PBExportComments$[intellicontract_tab] The contract locations Tab Page
forward
global type u_tabpg_contract_fee_schedules from u_tabpg_contract_master
end type
type tab_1 from u_tab_fee_schedule within u_tabpg_contract_fee_schedules
end type
type tab_1 from u_tab_fee_schedule within u_tabpg_contract_fee_schedules
end type
end forward

global type u_tabpg_contract_fee_schedules from u_tabpg_contract_master
integer width = 3982
integer height = 2072
long backcolor = 33551856
string text = "Fee Schedules"
string powertiptext = "Fee Schedules"
event ue_set_tabpage_properties ( )
event ue_set_screen_properties ( )
tab_1 tab_1
end type
global u_tabpg_contract_fee_schedules u_tabpg_contract_fee_schedules

forward prototypes
public function integer of_retrieve ()
public subroutine of_create_dw ()
end prototypes

event ue_set_tabpage_properties();long ll_FindRow
long ll_data_view_id

if not IsValid(gw_contract) then Return
ll_data_view_id = gw_contract.of_get_view_id()

// [Browse] Set tabpage_fee_browse property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_fee_browse")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_fee_browse, "custom065!", "Browse", "custom065!")

// [Notes] Set tabpage_fee_notes property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_fee_notes")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_fee_notes, "custom070!", "Notes", "custom070!")
end event

event ue_set_screen_properties();// Set screen properties
tab_1.tabpage_fee_browse.Event ue_set_screen_properties()
tab_1.tabpage_fee_notes.Event ue_set_screen_properties()
end event

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
	
	 this.tab_1.tabpage_fee_browse .of_retrieve( )
	 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 2006-09-06 By: Rodger Wu (Contract)
	//$<reason> Comment out redundant function call.
	
	/* this.tab_1.tabpage_fee_notes .of_retrieve( ) */
	
	//---------------------------- APPEON END ----------------------------

end if

ib_retrieved = true

RETURN SUCcess
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_fee_schedulesof_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.27.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_fee_schedules'
ld_dw[1] = tab_1.tabpage_fee_browse.dw_main
ld_dw[2] = tab_1.tabpage_fee_browse.dw_locations
ld_dw[3] = tab_1.tabpage_fee_browse.dw_fee_schedule
ld_dw[4] = tab_1.tabpage_fee_browse.dw_codes
ld_dw[5] = tab_1.tabpage_fee_notes.dw_1
ls_dw_name[1] = 'dw_main'
ls_dw_name[2] = 'dw_locations'
ls_dw_name[3] = 'dw_fee_schedule'
ls_dw_name[4] = 'dw_codes'
ls_dw_name[5] = 'dw_1'
ls_dataobject[1] = 'd_ctx_free_sched_hdr'
ls_dataobject[2] = 'd_ctx_schedule_fee_locations'
ls_dataobject[3] = 'd_ctx_schedule_fee_detail'
ls_dataobject[4] = 'd_ctx_schedule_fee_pracs'
ls_dataobject[5] = 'd_ctx_schedule_fee_notes'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_fee_schedules',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010

end subroutine

on u_tabpg_contract_fee_schedules.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpg_contract_fee_schedules.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_selectionchanged;call super::ue_selectionchanged;

this.tab_1.tabpage_fee_browse.dw_main.setfocus( )
end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason>Contract module modification 
of_create_dw()
//---------------------------- APPEON END ----------------------------


this.event ue_set_tabpage_properties( )	//Jervis 08.17.2010

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_set_security;call super::ue_set_security;//Add security control in child tab pages - by Alfee 09.30.2007
integer          li_index, li_count 
boolean lb_protect 
windowobject     lwo_temp[]
u_dw_contract    lst_temp

lwo_temp[1] = tab_1.tabpage_fee_browse.dw_codes
lwo_temp[2] = tab_1.tabpage_fee_browse.dw_fee_schedule
lwo_temp[3] = tab_1.tabpage_fee_browse.dw_locations
lwo_temp[4] = tab_1.tabpage_fee_browse.dw_main
lwo_temp[5] = tab_1.tabpage_fee_notes.dw_1

//Get & set read only flag at tab page level
lb_protect = inv_contract_details.of_get_protect_tabpg()
			
//Set read only flag for each data window in the child tab page
li_count = UpperBound ( lwo_temp[] ) 
FOR li_index = 1 TO li_count 
   lst_temp = lwo_temp[li_index] 
	if lb_protect then
		lst_temp.of_disable_columns( ) 
	 else
		lst_temp.of_enable_columns( )
	end if 
NEXT


end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_fee_schedules
end type

type tab_1 from u_tab_fee_schedule within u_tabpg_contract_fee_schedules
integer width = 3963
integer height = 2008
integer taborder = 10
boolean bringtotop = true
end type

event selectionchanged;call super::selectionchanged;this.tabpage_fee_browse.dw_main.setfocus( )
end event

