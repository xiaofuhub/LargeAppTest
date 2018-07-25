$PBExportHeader$u_tabpg_contract_detail1.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type u_tabpg_contract_detail1 from u_tabpg_contract_master
end type
type dw_occ from u_dw_contract within u_tabpg_contract_detail1
end type
type dw_ccc from u_dw_contract within u_tabpg_contract_detail1
end type
type dw_custom from u_dw_contract within u_tabpg_contract_detail1
end type
type tab_1 from u_tabpg_detail_detail within u_tabpg_contract_detail1
end type
type tab_1 from u_tabpg_detail_detail within u_tabpg_contract_detail1
end type
type dw_products from u_dw_contract within u_tabpg_contract_detail1
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail1
end type
type dw_contract_dates from u_dw_contract within u_tabpg_contract_detail1
end type
type st_vbar from u_st_splitbar within u_tabpg_contract_detail1
end type
type cb_max from commandbutton within u_tabpg_contract_detail1
end type
end forward

global type u_tabpg_contract_detail1 from u_tabpg_contract_master
integer width = 3872
integer height = 2020
boolean vscrollbar = true
string text = "Detail"
event dwnkey pbm_dwnkey
event ue_set_tabpage_properties ( )
event ue_set_screen_properties ( )
event ue_vscroll pbm_vscroll
event ue_set_forbid_validate_message ( boolean ab_value )
dw_occ dw_occ
dw_ccc dw_ccc
dw_custom dw_custom
tab_1 tab_1
dw_products dw_products
dw_1 dw_1
dw_contract_dates dw_contract_dates
st_vbar st_vbar
cb_max cb_max
end type
global u_tabpg_contract_detail1 u_tabpg_contract_detail1

type variables

n_cst_notification  inv_cst_notification
boolean ib_just_saved

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.22.2006 By: Liang QingShi
//$<reason> Contract module modification
string is_version_number
string is_dw = 'Our Company'
long il_contact_id,il_app_facility,il_app_facility_old,il_term_reason
boolean ib_new, ib_forbidvalidate
//---------------------------- APPEON END ----------------------------
Boolean ib_added_code_lookup //Added By Ken.Guo 03/12/2012. 


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.16.2006 By: Jervis
//$<reason> modify for work flow
Protected boolean ib_new_record = false
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.14.2007 By: Jack (Contract)
//$<reason> Fix a defect.
long il_master_contract_id
long il_ctx_id
string is_master_contract_name  //add by Jack 03/21/2007
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2009 By Jervis
//$<reason> Trigger work flow when column be update
integer il_screen_id[]
string is_UpdateCol[]
//---------------------------- APPEON END ----------------------------

Boolean		ibn_sync_category	= False				//Added By Mark Lee 12/07/2012

String		is_Refresh_Alarm  // 1 detail date alarm , //added by gavins 20121227
String 	 is_products_visible, is_contract_dates_visible				//Added By Mark Lee 01/31/2013 

end variables

forward prototypes
public function long of_get_next_seq_number ()
public function integer of_retrieve ()
public function integer of_open_contact (u_dw adw, string as_string)
public function integer of_setdefaultemail (string as_column_name, u_dw adw, string as_data, integer row)
public subroutine of_set_title ()
public subroutine of_create_dw ()
public subroutine of_set_flags ()
public function integer of_set_contract_type (u_dw adw)
public subroutine of_change_screen ()
public subroutine of_change_screen_detail ()
public function integer of_set_default_value (datawindow adw)
public function integer of_send_email (datawindow adw_send)
public function integer of_create_action_item_by_workflow ()
public function integer of_open_contact (u_dw adw, string as_string, boolean ab_detail)
public subroutine of_set_buttons (boolean ab_enabled)
public subroutine of_add_contract_contact (long al_facid)
public subroutine of_refreshtab ()
public subroutine of_statusaudit ()
public subroutine of_deletesearchtabctx (long al_deleted_ctx_id)
public subroutine of_create_custom_dw ()
public subroutine of_adjust_position (boolean abln_flag)
public subroutine of_set_forbid_validate (boolean ab_value)
end prototypes

event dwnkey;

//messageBOX('','')


RETURN 0
end event

event ue_set_tabpage_properties();long ll_FindRow
long ll_data_view_id

if not IsValid(gw_contract) then Return
ll_data_view_id = gw_contract.of_get_view_id()


//Begin - Added By Ken.Guo 11/12/2012.
Long ll_CusRight,ll_NotesRight,ll_AuditRight,ll_ProviderRight
ll_CusRight = w_mdi.of_security_access(2091)				//Custom Data
if ll_CusRight = 0 then
	tab_1.tabpage_custom.Visible = false
else
	tab_1.tabpage_custom.Visible = true
end if

ll_NotesRight = w_mdi.of_security_access(2092)			//Notes
if ll_NotesRight = 0 then
	tab_1.tabpage_notes.Visible = false
else
	tab_1.tabpage_notes.Visible = true
end if

ll_AuditRight = w_mdi.of_security_access(2093)			//Custom Data 2 -- jervis 07.06.2011
if ll_AuditRight = 0 then
	tab_1.tabpage_1.Visible = false
else
	tab_1.tabpage_1.Visible = true
end if

//-------------appeon begin----------------------
	//<$>added:long.zhang 04.17.2014
	//<$>reason:v14.2 Provider-Contract direct linking
	if gs_cust_type = "I" or of_get_app_setting("set_9","I") = 0 then	//Linked Providers data
		ll_ProviderRight = w_mdi.of_security_access(7751)
			if ll_ProviderRight = 0 then
				this.tab_1.tabpage_linkprovider.visible = false
			else
				this.tab_1.tabpage_linkprovider.visible = true
				this.tab_1.tabpage_linkprovider.ii_accessright = ll_ProviderRight
			end if
	else
		this.tab_1.tabpage_linkprovider.visible = false
	end if
	//-------------appeon End------------------------

ll_AuditRight = w_mdi.of_security_access(6951)			//Group Access //Added by Ken.Guo on 2009-02-11
if ll_AuditRight = 0 or gnv_data.of_GetItem( "icred_settings", "group_access", False ) = '0' then
	tab_1.tabpage_group_access.Visible = false
else
	tab_1.tabpage_group_access.Visible = true
	//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	tab_1.tabpage_group_access.ii_accessright = ll_AuditRight//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 
	//---------End Added ------------------------------------------------------
end if
//End - Added By Ken.Guo 11/12/2012.



// [Custom Data] Set tabpage_custom property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_det_custom")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_custom, "Custom081!", "Custom Data", "Custom081!")

// [Notes] Set tabpage_notes property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_det_notes")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_notes, "custom070!", "Notes", "custom070!")

// [Audit Trail] Set tabpage_1 property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_det_audit")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_1, "Custom082!", "Custom Data 2", "Custom082!") //Change to 'custom data 2' -- jervis 05.18.2011

//comment by jervis -- 05.11.2011
//tab_1.tabpage_1.rb_1.backcolor = tab_1.tabpage_1.backcolor
//tab_1.tabpage_1.rb_2.backcolor = tab_1.tabpage_1.backcolor
//tab_1.tabpage_1.rb_3.backcolor = tab_1.tabpage_1.backcolor
//tab_1.tabpage_1.rb_4.backcolor = tab_1.tabpage_1.backcolor
//tab_1.tabpage_1.st_1.backcolor = tab_1.tabpage_1.backcolor

// [Linked Contracts] Set tabpage_2 property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_det_linked")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_2, "Custom085!", "Linked Contracts", "Custom085!")

// [Group Access] Set tabpage_det_group property
//BEGIN---Modify by Scofield on 2009-10-27
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_det_group")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_group_access, "ArrangeIcons!", "Group Access", "ArrangeIcons!")
//END---Modify by Scofield on 2009-10-27


//-------------appeon begin----------------------
//<$>added:long.zhang 04.14.2014
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_linkprovider")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_linkprovider, "ArrangeIcons!", "Linked Providers", "ArrangeIcons!")
//<$>reason:v14.2 Provider-Contract direct linking
//-------------appeon End------------------------


end event

event ue_set_screen_properties();// Set screen properties (show titlebar is default)
dw_1.of_set_properties(dw_1.il_ViewID, dw_1.il_ScreenID, "Y")
dw_products.of_set_properties(dw_products.il_ViewID, dw_products.il_ScreenID, "Y")
dw_contract_dates.of_set_properties(dw_contract_dates.il_ViewID, dw_contract_dates.il_ScreenID, "Y")
dw_ccc.of_set_properties(dw_ccc.il_ViewID, dw_ccc.il_ScreenID, "Y")
dw_occ.of_set_properties(dw_occ.il_ViewID, dw_occ.il_ScreenID, "Y")

// Set screen properties (not show titlebar is default)
tab_1.tabpage_custom.dw_1.of_set_properties(tab_1.tabpage_custom.dw_1.il_ViewID, tab_1.tabpage_custom.dw_1.il_ScreenID, "N")
tab_1.tabpage_notes.dw_1.of_set_properties(tab_1.tabpage_notes.dw_1.il_ViewID, tab_1.tabpage_notes.dw_1.il_ScreenID, "N")
tab_1.tabpage_1.dw_1.of_set_properties(tab_1.tabpage_1.dw_1.il_ViewID, tab_1.tabpage_1.dw_1.il_ScreenID, "N")
tab_1.tabpage_2.dw_1.of_set_properties(tab_1.tabpage_2.dw_1.il_ViewID, tab_1.tabpage_2.dw_1.il_ScreenID, "N")
//Added By Mark Lee 05/15/12
tab_1.tabpage_group_access.dw_1.of_set_properties(tab_1.tabpage_group_access.dw_1.il_ViewID, tab_1.tabpage_group_access.dw_1.il_ScreenID, "N")

//Begin - Added By Mark Lee 01/15/2013		move to of_adjust_position function.
////Set visible property
////Only process dw_products.visible
//string ls_visible
//
//select screen_visible into :ls_visible from ctx_screen
//where data_view_id = :dw_products.il_ViewID and screen_id = :dw_products.il_ScreenID;
//
//if isnull(ls_visible) or ls_visible = '' then ls_visible = 'Y'
//
//if ls_visible = 'N' and dw_products.visible then
//	//dw_detail.blowe
//	dw_products.hide( )
//	dw_1.height = dw_products.y + dw_products.height - dw_1.y
//elseif ls_visible = 'Y' then
//	dw_products.show( )
//	//dw_1.height = dw_1.height - dw_products.height - 20
//	dw_1.height = dw_products.y - dw_1.y - 20
//end if
//Reset orignal size
//if IsValid(this.inv_resize) then
//	this.inv_resize.of_SetOrigSize(dw_1, dw_1.x, dw_1.y, dw_1.width, dw_1.height)
//end if
//End - Added By Mark Lee 01/15/2013

end event

event ue_vscroll;////Added By Mark Lee 01/15/2013
//gnv_debug.of_output( true, 'vscroll:'+string(scrollcode)+':::pos::'+string(scrollpos))
end event

event ue_set_forbid_validate_message(boolean ab_value);post of_set_forbid_validate( ab_value )
end event

public function long of_get_next_seq_number ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_next_seq_number
**==================================================================================================================
**  Purpose   	: retriev the max adds one to it 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**   MSKINNER              17 October 2005                                     Will be using the prac idd for contract
**																										 so that we can integrate sys audit
********************************************************************************************************************/
// start code change --- 11.01.2005 MSKINNER
//Start Change code by Jervis 04.11.2008
//get contract id from ids.ctx_id.
//inv_contract_details.of_set_ctx_id( gnv_app.of_get_id('PRAC_ID'))
inv_contract_details.of_set_ctx_id( gnv_app.of_get_id('CTX_ID'))
//End Change code by jervis 04.11.2008
// end code change --- 11.01.2005 MSKINNER

return inv_contract_details.of_get_ctx_id( )

end function

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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.15.2007 By: Jack (Contract)
//$<reason> Fix a defect.
long ll_ctx_id
ll_ctx_id = inv_contract_details.of_get_ctx_id( )
If ll_ctx_id <> il_ctx_id Then
   ib_retrieved = False
End If
//---------------------------- APPEON END ----------------------------

if not ib_retrieved then 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.13.2006 By: Liang QingShi
	//$<reason>Fix a defect.
	if dw_1.rowcount() > 0 then
	//---------------------------- APPEON END ----------------------------

		if inv_contract_details.of_get_ctx_id( ) > 0 /*<> dw_1.object.ctx_id[1] or isnull(dw_1.object.ctx_id[1]) */ then 
			This.dw_1.RESET( )

			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-01
			//$<add> 01.17.2006 By: LeiWei
			//$<reason> Performance tuning
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.	
			
			This.tab_1.tabpage_1.il_ctx_id = inv_contract_details.of_get_ctx_id( )			
			
			gnv_appeondb.of_startqueue( )
			
		   This.dw_1.event pfc_retrieve( )
			This.dw_ccc.event pfc_retrieve( )
			This.dw_occ.event pfc_retrieve( )
			This.dw_products.event pfc_retrieve( )
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2009-05-25 By: Scofield
			//$<Reason> Don't retrieve audit trail until the tabpage is clicked.

			//This.tab_1.tabpage_1.dw_1.event pfc_retrieve( )
			This.tab_1.ib_NeedRefreshTrail = true
			//---------------------------- APPEON END ----------------------------

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.14.2007 By: Jack (Contract)
			//$<reason> Fix a defect.
			If inv_contract_details.il_count > 0 Then
//				dw_1.modIfy("master_contract_id.protect = 1")						  //Comment by Jack 03/21/2007
//				dw_1.modIfy("master_contract_id.background.color = 67108864")	  //Comment by Jack 03/21/2007
				/*
				dw_1.modIfy("master_contract_name.protect = 1")						  //add by Jack 03/21/2007
				dw_1.modIfy("master_contract_name.background.color = 67108864")  //add by Jack 03/21/2007	
				
				dw_1.modify("b_contract_search.visible = 0")                     // Add by Jack 05/09/2007
				*/
				This.tab_1.tabpage_2.visible = True
				This.tab_1.tabpage_2.il_ctx_id = inv_contract_details.of_get_ctx_id( )			
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2009-05-25 By: Scofield
				//$<Reason> Don't retrieve Linked Contracts until the tabpage is clicked.
	
				//This.tab_1.tabpage_2.dw_1.event pfc_retrieve( )
				This.tab_1.ib_NeedRefreshLink = true
				//---------------------------- APPEON END ----------------------------
			Else
//				dw_1.modIfy("master_contract_id.protect = 0")							//Comment by Jack 03/21/2007
//				dw_1.modIfy("master_contract_id.background.color = 16777215")		//Comment by Jack 03/21/2007

				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 05.22.2007 By: Jack
				//$<reason> Fix a defect.
				/*
				dw_1.modIfy("master_contract_name.protect = 1")
				dw_1.modIfy("master_contract_name.background.color = 16777215")	
				dw_1.modify("b_contract_search.visible = 1")                    
				*/
				
				//Commented By Ken.Guo 2009-12-23. Supported multi-level.
				/*
				if inv_contract_details.of_get_protect_columns( ) then 
					dw_1.modIfy("master_contract_name.protect = 1")
					dw_1.modIfy("master_contract_name.background.color = 67108864")	
					dw_1.modify("b_contract_search.visible = 0")                    
				 else
					dw_1.modIfy("master_contract_name.protect = 0")
					dw_1.modIfy("master_contract_name.background.color = 16777215")	
					dw_1.modify("b_contract_search.visible = 1")                    
				end if 
				*/
				
				//---------------------------- APPEON END ----------------------------


				//This.tab_1.selecttab(1)						//Comment by Scofield on 2008-05-13
				This.tab_1.tabpage_2.visible = False
			End If
			//---------------------------- APPEON END ----------------------------
			This.tab_1.tabpage_group_access.il_ctx_id = inv_contract_details.of_get_ctx_id( )	//Added by Ken.Guo on 2009-02-10
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2009-05-25 By: Scofield
			//$<Reason> Don't retrieve Group Access until the tabpage is clicked.

			//This.tab_1.tabpage_group_access.dw_1.event pfc_retrieve( ) //Added by Ken.Guo on 2009-02-10
			This.tab_1.ib_NeedRefreshAccess = true
			//---------------------------- APPEON END ----------------------------
			this.tab_1.ib_needrefreshprovider = true//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
			This.tab_1.tabpage_linkprovider.il_ctx_id = inv_contract_details.of_get_ctx_id( )//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
			
			gnv_appeondb.of_commitqueue( )
			//---------------------------- APPEON END ----------------------------
		end if
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.13.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	else
			This.tab_1.tabpage_1.il_ctx_id = inv_contract_details.of_get_ctx_id( )			 			
			gnv_appeondb.of_startqueue( )
			
		   This.dw_1.event pfc_retrieve( )
			This.dw_ccc.event pfc_retrieve( )
			This.dw_occ.event pfc_retrieve( )
			This.dw_products.event pfc_retrieve( )
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2009-05-25 By: Scofield
			//$<Reason> Don't retrieve audit trail until the tabpage is clicked.

			//This.tab_1.tabpage_1.dw_1.event pfc_retrieve( )
			This.tab_1.ib_NeedRefreshTrail = true
			//---------------------------- APPEON END ----------------------------
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.14.2007 By: Jack (Contract)
			//$<reason> Fix a defect.
			If inv_contract_details.il_count > 0 Then
				
				/* //Commented By Ken.Guo 2009-12-23. support multi-level
				dw_1.modIfy("master_contract_name.protect = 1") //add by Jack 03/21/2007
				dw_1.modIfy("master_contract_name.background.color = 67108864")	
				dw_1.modify("b_contract_search.visible = 0")                     // Add by Jack 05/09/2007
				*/
				This.tab_1.tabpage_2.visible = True
				This.tab_1.tabpage_2.il_ctx_id = inv_contract_details.of_get_ctx_id( )			
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2009-05-25 By: Scofield
				//$<Reason> Don't retrieve Linked Contracts until the tabpage is clicked.
	
				//This.tab_1.tabpage_2.dw_1.event pfc_retrieve( )
				This.tab_1.ib_NeedRefreshLink = true
				//---------------------------- APPEON END ----------------------------
			Else
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 05.22.2007 By: Jack
				//$<reason> Fix a defect.
				/*
				dw_1.modIfy("master_contract_name.protect = 1")
				dw_1.modIfy("master_contract_name.background.color = 16777215")	
				dw_1.modify("b_contract_search.visible = 1")                    
				*/
				
				/* //Commented By Ken.Guo 2009-12-23. supported multi-level
				if inv_contract_details.of_get_protect_columns( ) then 
					dw_1.modIfy("master_contract_name.protect = 1")
					dw_1.modIfy("master_contract_name.background.color = 67108864")	
					dw_1.modify("b_contract_search.visible = 0")                    
				 else
					dw_1.modIfy("master_contract_name.protect = 0")
					dw_1.modIfy("master_contract_name.background.color = 16777215")	
					dw_1.modify("b_contract_search.visible = 1")                    
				end if 
				*/
				
				//---------------------------- APPEON END ----------------------------
				//This.tab_1.selecttab(1)						//Comment by Scofield on 2008-05-13
				This.tab_1.tabpage_2.visible = False
			End If
			//---------------------------- APPEON END ----------------------------
			This.tab_1.tabpage_group_access.il_ctx_id = inv_contract_details.of_get_ctx_id( )	//Added by Ken.Guo on 2009-02-10
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2009-05-25 By: Scofield
			//$<Reason> Don't retrieve Group Access until the tabpage is clicked.

			//This.tab_1.tabpage_group_access.dw_1.event pfc_retrieve( ) //Added by Ken.Guo on 2009-02-10
			This.tab_1.ib_NeedRefreshAccess = true
			//---------------------------- APPEON END ----------------------------
			this.tab_1.ib_needrefreshprovider = true//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
			This.tab_1.tabpage_linkprovider.il_ctx_id = inv_contract_details.of_get_ctx_id( )//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
			
			gnv_appeondb.of_commitqueue( )
			
   end if
	if dw_1.rowcount() <= 0 then return dw_1.insertrow(0)
	//---------------------------- APPEON END ----------------------------
	
	ib_retrieved = true		
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07.22.2006 By: Liang QingShi
	//$<reason> Contract module modification
	if dw_contract_dates.rowcount() > 0 then
		is_version_number = dw_contract_dates.object.version_number[1]
	end if
	//---------------------------- APPEON END ----------------------------
end if

Post of_set_flags( ) //Modified By Ken.Guo 05/18/2012. Use Post function. need waiting custom screen constructor 

////-------------Begin Added by Alfee 09.26.2007 ----------------------------
////<$Reason>If not active or pending status, disable the date alarm buttons. 
//Long ll_status_active, ll_status_pending
//IF dw_1.rowcount() > 0 THEN
//	ll_status_active = Long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Status' and code = 'ACTIVE'"))
//	ll_status_pending = Long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Status' and code = 'PENDING'"))
//	If dw_1.object.status[1] <> ll_status_pending And dw_1.object.status[1] <> ll_status_active Then
//		of_set_buttons(FALSE) 
//	ELSE
//		of_set_buttons(TRUE) 
//	END IF
//END IF
////------------End Added -----------------------------------------------------

of_RefreshTab()					//Added by Scofield on 2008-05-13

RETURN success

end function

public function integer of_open_contact (u_dw adw, string as_string);return of_open_contact(adw, as_string, false)
end function

public function integer of_setdefaultemail (string as_column_name, u_dw adw, string as_data, integer row);/******************************************************************************************************************
**  [PUBLIC]   : of_setDefaultEmail
**==================================================================================================================
**  Purpose   	: Make sure there is only one default email address
**==================================================================================================================
**  Arguments 	: [string]  as_column_name
**  Arguments 	: [u_dw]    adw
**  Arguments 	: [string]  as_data
**  Arguments 	: [integer] row
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 November 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
choose case as_column_name
	case 'default_email'
		  // do not allow more then on default email address
		  adw.setredraw(false)
		  if as_data = 'Y' then 
		   for ll_i = 1 to adw.rowcount()
				if ll_i = row then continue 
				adw.setItem(ll_i,as_column_name, 'N')
				
			next
		end if 
		adw.setredraw(true)
		
		
		
		
end choose 

return success
end function

public subroutine of_set_title ();/******************************************************************************************************************
**  [PUBLIC]   : of_set_title( )
**==================================================================================================================
**  Purpose   	: set the title on the parent window
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 12 January 2006  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


dw_1.accepttext( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.08.2006 By: Liang QingShi
//$<reason> Contract module modification
/*
dw_1.invo_dwsrv.of_setrequestor( dw_1)
iw_parent.title = 'Contract Logix ' + ' Company: ' + dw_1.invo_dwsrv.of_getitem( 1, 'app_facility') + '        Product: ' + dw_1.invo_dwsrv.of_getitem( 1, 'product_name')
*/

if dw_1.rowcount() <= 0 then return

//dw_1.invo_dwsrv.of_setrequestor( dw_1)	2007.7.12 By Jervis

String ls_id,ls_company
//ls_id = dw_1.invo_dwsrv.of_getitem( 1, 'ctx_id') //2007.7.12 By Jervis
ls_id = dw_1.inv_base.of_getitem( 1, 'ctx_id')
IF LEN(ls_id) > 0 THEN ls_id = '    Contract ID: ' + dw_1.inv_base.of_getitem( 1, 'ctx_id')

//ls_company = dw_1.invo_dwsrv.of_getitem( 1, 'app_facility') 2007.7.12 By Jervis
ls_company = dw_1.inv_base.of_getitem( 1, 'app_facility')

IF LEN(ls_company) > 0 THEN ls_company = '    Company: ' + dw_1.inv_base.of_getitem( 1, 'app_facility')

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2007.08.21 By: Jack
//$<reason>fix a Web defict.
/*
iw_parent.title = 'Contract Logix ' + ls_company + ls_id
*/
//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//iw_parent.title = 'Contract Logix ' + ls_id + ls_company 
iw_parent.title = 'IntelliContract ' + ls_id + ls_company 
//---------End Modfiied ------------------------------------------------------

//---------------------------- APPEON END ----------------------------
//---------------------------- APPEON END ----------------------------


end subroutine

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_detail1of_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>Contract module modification 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.26.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_details'

//ld_dw[1] = dw_custom
ld_dw[1] = dw_1
ld_dw[2] = dw_products
ld_dw[3] = dw_ccc
ld_dw[4] = dw_occ
ld_dw[5] = dw_contract_dates
/*
ld_dw[6] = tab_1.tabpage_custom.dw_1
ld_dw[7] = TAB_1.tabpage_notes.dw_1
ld_dw[8] = TAB_1.tabpage_1.dw_1
ld_dw[9] = TAB_1.tabpage_2.dw_1
ld_dw[10] = TAB_1.tabpage_group_access.dw_1 //Added by Ken.Guo on 2009-02-10
*/

//ls_dw_name[1] = 'dw_1'      //Comment by Jack 05/10/2007
ls_dw_name[1] = 'dw_1'
ls_dw_name[2] = 'dw_products'
ls_dw_name[3] = 'dw_ccc'
ls_dw_name[4] = 'dw_occ'
ls_dw_name[5] = 'dw_contract_dates'
/*
ls_dw_name[6] = 'dw_1'
ls_dw_name[7] = 'dw_1'
ls_dw_name[8] = 'dw_1'
ls_dw_name[9] = 'dw_1'
ls_dw_name[10] = 'dw_1' //Added by Ken.Guo on 2009-02-10
*/

//ls_dataobject[1] = 'd_contract_det_custom'      //Comment by Jack 05/10/2007
ls_dataobject[1] = 'd_contract_det_master'
ls_dataobject[2] = 'd_ctx_products'
ls_dataobject[3] = 'd_contract_det_contact_external'
ls_dataobject[4] = 'd_contract_det_contact_external'
ls_dataobject[5] = 'd_contract_det_master_2'
/*
ls_dataobject[6] = 'd_contract_det_custom'
ls_dataobject[7] = 'd_contract_det_notes'
//ls_dataobject[8] = 'd_view_audit2_ctx'
ls_dataobject[8] = 'd_contract_det_custom_2'  //05.13.2011 by jervis
ls_dataobject[9] = 'd_sp_contract_search'
ls_dataobject[10] = 'd_contract_det_group_access' //Added by Ken.Guo on 2009-02-10
*/

f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_details',true) 
//dw_products.bringtotop = true      //Comment by Jack 05/10/2007
ib_retrieved = false

//Begin - Added By Mark Lee 01/16/2013		move  to the  of_adjust_position function.
////$<add> 10.20.2006 By: Davis	 
////$<reason> Fix a defect.
//IF cb_max.text = "-" THEN
//	cb_max.event clicked( )
//END IF
//End - Added By Mark Lee 01/16/2013

this.event ue_set_screen_properties( )  //Added By Ken.Guo 2010-10-27. 

IF  this.vscrollbar = True  then
	send(handle(this),277,6,0)
	send(handle(this),277,8,0)
	 this.vscrollbar = False
End IF 

//update gnv_user_option copy data
gnv_user_option.of_viewid_copy_retrieve( )

//Begin - Added By Mark Lee 01/31/2013
gnv_appeondb.of_startqueue()
// process dw_products.visible
select screen_visible into :is_products_visible from ctx_screen
where data_view_id = :dw_products.il_ViewID and screen_id = :dw_products.il_ScreenID ;
// dw_contract_dates.visible
select screen_visible into :is_contract_dates_visible from ctx_screen
where data_view_id = :dw_contract_dates.il_ViewID and screen_id = :dw_contract_dates.il_ScreenID ;
gnv_appeondb.of_commitqueue()
if isnull(is_products_visible) or is_products_visible = '' then is_products_visible = 'Y'
if isnull(is_contract_dates_visible) or is_contract_dates_visible = '' then is_contract_dates_visible = 'Y'

of_adjust_position(True)					// set position for all object
//End - Added By Mark Lee 01/31/2013

end subroutine

public subroutine of_set_flags ();long	ll_ctx_id
string ls_datascreen[],ls_customscreen[]

ll_ctx_id = inv_contract_details.of_get_ctx_id()

//Refresh ctx_basic_info alarm flag -- jervis 05.19.2011
ls_datascreen = {'effective_date','expriation_date','review_date','last_revis_date','other_date_1','term_date','other_date_2','version_date', &
				'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10','custom_date11','custom_date12','custom_date13','custom_date14','custom_date15','custom_date16','custom_date17'}//added by gavins 20120401   

ls_customscreen = {'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10','custom_date11','custom_date12','custom_date13','custom_date14','custom_date15'}
inv_contract_details.of_set_alarm_flag( dw_contract_dates, 'ctx_basic_info', ls_datascreen, ll_ctx_id,0,0,0)
inv_contract_details.of_set_alarm_flag( tab_1.tabpage_custom.dw_1, 'ctx_basic_info', ls_customscreen, ll_ctx_id,0,0,0)
inv_contract_details.of_set_alarm_flag( tab_1.tabpage_1.dw_1 , 'ctx_custom', ls_customscreen, ll_ctx_id,0,0,0)


/*
dw_contract_dates.OBJECT.b_effective_date.filename = f_set_flag('ctx_basic_info', 'effective_date', ll_ctx_id)
dw_contract_dates.OBJECT.b_expriation_date.filename = f_set_flag('ctx_basic_info', 'expriation_date', ll_ctx_id)
dw_contract_dates.OBJECT.b_review_date.filename = f_set_flag('ctx_basic_info', 'review_date', ll_ctx_id)
dw_contract_dates.OBJECT.b_last_revis_date.filename = f_set_flag('ctx_basic_info', 'last_revis_date', ll_ctx_id)
dw_contract_dates.OBJECT.b_other_date_1.filename = f_set_flag('ctx_basic_info', 'other_date_1', ll_ctx_id)
dw_contract_dates.OBJECT.b_term_date.filename = f_set_flag('ctx_basic_info', 'term_date', ll_ctx_id)
dw_contract_dates.OBJECT.b_other_date_2.filename = f_set_flag('ctx_basic_info', 'other_date_2', ll_ctx_id)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.14.2006 By: Liang QingShi
//$<reason> Contract module modification
dw_contract_dates.OBJECT.b_version_date.filename = f_set_flag('ctx_basic_info', 'version_date', ll_ctx_id)	

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.24.2007 By: Jack
//$<reason> Add ability to put alarms on all custom date fields.
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date1.filename = f_set_flag('ctx_basic_info', 'custom_date1', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date2.filename = f_set_flag('ctx_basic_info', 'custom_date2', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date3.filename = f_set_flag('ctx_basic_info', 'custom_date3', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date4.filename = f_set_flag('ctx_basic_info', 'custom_date4', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date5.filename = f_set_flag('ctx_basic_info', 'custom_date5', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date6.filename = f_set_flag('ctx_basic_info', 'custom_date6', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date7.filename = f_set_flag('ctx_basic_info', 'custom_date7', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date8.filename = f_set_flag('ctx_basic_info', 'custom_date8', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date9.filename = f_set_flag('ctx_basic_info', 'custom_date9', ll_ctx_id)
tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date10.filename = f_set_flag('ctx_basic_info', 'custom_date10', ll_ctx_id)
//---------------------------- APPEON END ----------------------------

//BEGIN---Modify by Scofield on July-28 2009 Tuesday
Tab_1.tabpage_custom.dw_1.object.b_custom_date11.filename = f_set_flag('ctx_basic_info', 'custom_date11', ll_ctx_id)
Tab_1.tabpage_custom.dw_1.object.b_custom_date12.filename = f_set_flag('ctx_basic_info', 'custom_date12', ll_ctx_id)
Tab_1.tabpage_custom.dw_1.object.b_custom_date13.filename = f_set_flag('ctx_basic_info', 'custom_date13', ll_ctx_id)
Tab_1.tabpage_custom.dw_1.object.b_custom_date14.filename = f_set_flag('ctx_basic_info', 'custom_date14', ll_ctx_id)
Tab_1.tabpage_custom.dw_1.object.b_custom_date15.filename = f_set_flag('ctx_basic_info', 'custom_date15', ll_ctx_id)
//END---Modify by Scofield on July-28 2009 Tuesday
*/

end subroutine

public function integer of_set_contract_type (u_dw adw);

//
//dwItemStatus l_status
//datawindowchild dwc
//
//adw.getchild( 'group_multi_loc_id', dwc)
//dwc.settransobject(sqlca)
//if  dwc.retrieve( adw.object.ctx_id[1]) > 0 then 
//	// set the rec_id
//	adw.object.group_multi_loc_id[1] = dwc.getItemNumber(1,'rec_id')
//	// reset the starus
//	adw.SetItemStatus(1, 0,Primary!, l_status)
//end if
//
return success
end function

public subroutine of_change_screen ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_detail1of_change_screen()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description> Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.22.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
long 		ll_category
integer 	li_view_id

dw_1.accepttext()
ll_category = dw_1.getitemnumber(dw_1.getrow(),'category')

If isvalid(w_contract) and il_ctx_id <> 0 and Not isnull(il_ctx_ID) Then //Modified By Ken.Guo 03/30/2012 Added checking CTX ID 
	li_view_id = w_contract.tab_contract_details.tabpage_search.of_get_ctx_view(ll_category,il_ctx_id)
Else
	li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(ll_category)))
	If isnull(li_view_id) Or li_view_id = 0 Then 
		li_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
	End If
End If

If li_view_id <> gi_contract_view_id Then
	gi_contract_view_id = li_view_id
	
	//Set Tab page properties - jervis 04.06.2011
	if isvalid(gw_contract) then
		gw_contract.of_set_view_id( gi_contract_view_id)
		gw_contract.TriggerEvent("ue_set_tabpage_properties")
	end if
	
	iw_parent.function dynamic wf_tab_visible(gi_contract_view_id) 
	iw_parent.function dynamic wf_set_select('All',false) 
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.11.2007 By: Jack
	//$<reason> Fix a defect.	
//	iw_parent.function dynamic of_select_details_tab()
	If w_contract.tab_contract_details.tabpage_details.visible = False Then 
		If ib_new = False Then
			iw_parent.function dynamic of_select_details_tab()
		End If
		Return
	End If
	//---------------------------- APPEON END ----------------------------
	of_create_dw()
	of_create_custom_dw()  //add by jervis 03.12.2011
	dw_1.ib_retrieve_drop_downs = false
	dw_1.event ue_populatedddws( )
	dw_contract_dates.ib_retrieve_drop_downs = false
	dw_contract_dates.event ue_populatedddws( )
	dw_ccc.ib_retrieve_drop_downs = false
	dw_ccc.event ue_populatedddws( )
	dw_occ.ib_retrieve_drop_downs = false
	dw_occ.event ue_populatedddws( )
	dw_products.ib_retrieve_drop_downs = false
	dw_products.event ue_populatedddws( )
	dw_products.ib_retrieve_drop_downs = false
	dw_products.event ue_populatedddws( )
	
	tab_1.tabpage_notes.dw_1.ib_retrieve_drop_downs = false
	tab_1.tabpage_notes.dw_1.event ue_populatedddws( )
	tab_1.tabpage_custom.dw_1.ib_retrieve_drop_downs = false
	tab_1.tabpage_custom.dw_1.event ue_populatedddws( )
	tab_1.tabpage_1.dw_1.ib_retrieve_drop_downs = false
	tab_1.tabpage_1.dw_1.event ue_populatedddws( )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 03.14.2007 By: Jack (Contract)
	//$<reason> Fix a defect.
	tab_1.tabpage_2.dw_1.ib_retrieve_drop_downs = false
	tab_1.tabpage_2.dw_1.event ue_populatedddws( )
	
	//---------------------------- APPEON END ----------------------------	
	
	dw_1.sharedata(dw_contract_dates)
	dw_1.sharedata( this.tab_1.tabpage_custom.dw_1)
	dw_1.sharedata( this.tab_1.tabpage_notes.dw_1 )
	//Begin - Added By Mark Lee 07/10/12
//	dw_ccc.object.ctx_contract_contacts_owner.Visible  = false
//	dw_ccc.object.ctx_contract_contacts_owner_t.Visible  = false
//	
//	dw_ccc.object.access.Visible  = false
//	dw_ccc.object.access_t.Visible  = false
	dw_ccc.Modify("ctx_contract_contacts_owner.Visible= 0")
	dw_ccc.Modify("ctx_contract_contacts_owner_t.Visible= 0")
	dw_ccc.Modify("access.Visible= 0")
	dw_ccc.Modify("access_t.Visible= 0")
	//End - Added By Mark Lee 07/10/12
	
	If ib_new = false Then
		ib_retrieved = false
		of_retrieve()
	Else
		event ue_new()
	End If
	
	dw_1.SetItem(dw_1.getrow(),'category',ll_category)
	dw_1.Of_Enable_Save()			//Added by Scofield on 2010-04-15
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.11.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	dw_contract_dates.setfocus()
	dw_contract_dates.setcolumn('version_number')
	*/
	dw_1.setfocus()
	dw_1.setcolumn('category')

//---------------------------- APPEON END ----------------------------
	
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-22 By: Liu Hongxin
//$<reason>: Modify by user Requirement.
dw_ccc.Modify("default_email_t.text = 'Default To'")
dw_occ.Modify("default_email_t.text = 'Default From'")
//---------------------------- APPEON END ----------------------------

			
Event ue_set_tabpage_properties() //Added By Ken.Guo 09/27/2011. 
end subroutine

public subroutine of_change_screen_detail ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_detail1of_change_screen_detail()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description> Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.22.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
long		ll_CusRight,ll_NotesRight,ll_AuditRight,ll_TrackRight,ll_ProviderRight

of_create_dw()
of_create_custom_dw() 

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-11-06 By: Scofield
//$<Reason> Add the right to turn on/off the Custom Data, Notes, Audit Trail, Status Track.

ll_CusRight = w_mdi.of_security_access(2091)				//Custom Data
if ll_CusRight = 0 then
	tab_1.tabpage_custom.Visible = false
else
	tab_1.tabpage_custom.Visible = true
end if

ll_NotesRight = w_mdi.of_security_access(2092)			//Notes
if ll_NotesRight = 0 then
	tab_1.tabpage_notes.Visible = false
else
	tab_1.tabpage_notes.Visible = true
end if

ll_AuditRight = w_mdi.of_security_access(2093)			//Custom Data 2 -- jervis 07.06.2011
if ll_AuditRight = 0 then
	tab_1.tabpage_1.Visible = false
else
	tab_1.tabpage_1.Visible = true
end if

ll_TrackRight = w_mdi.of_security_access(2094)			//Status Track, Added by Scofield on 2008-06-03
if ll_TrackRight = 0 then
	dw_1.Modify("b_StatusTrack.Visible = 0")
end if

ll_AuditRight = w_mdi.of_security_access(6951)			//Group Access //Added by Ken.Guo on 2009-02-11
if ll_AuditRight = 0 or gnv_data.of_GetItem( "icred_settings", "group_access", False ) = '0' then
	tab_1.tabpage_group_access.Visible = false
else
	tab_1.tabpage_group_access.Visible = true
	//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	tab_1.tabpage_group_access.ii_accessright = ll_AuditRight//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 
	//---------End Added ------------------------------------------------------
end if
//---------------------------- APPEON END ----------------------------

//-------------appeon begin----------------------
	//<$>added:long.zhang 04.17.2014
	//<$>reason:v14.2 Provider-Contract direct linking
	if gs_cust_type = "I" or of_get_app_setting("set_9","I") = 0 then	//Linked Providers data
		ll_ProviderRight = w_mdi.of_security_access(7751)
			if ll_ProviderRight = 0 then
				this.tab_1.tabpage_linkprovider.visible = false
			else
				this.tab_1.tabpage_linkprovider.visible = true
				this.tab_1.tabpage_linkprovider.ii_accessright = ll_ProviderRight
			end if
	else
		this.tab_1.tabpage_linkprovider.visible = false
	end if
	//-------------appeon End------------------------

dw_1.ib_retrieve_drop_downs = false
dw_1.event ue_populatedddws( )
dw_contract_dates.ib_retrieve_drop_downs = false
dw_contract_dates.event ue_populatedddws( )
dw_ccc.ib_retrieve_drop_downs = false
dw_ccc.event ue_populatedddws( )
dw_occ.ib_retrieve_drop_downs = false
dw_occ.event ue_populatedddws( )
dw_products.ib_retrieve_drop_downs = false
dw_products.event ue_populatedddws( )
tab_1.tabpage_notes.dw_1.ib_retrieve_drop_downs = false
tab_1.tabpage_notes.dw_1.event ue_populatedddws( )
tab_1.tabpage_custom.dw_1.ib_retrieve_drop_downs = false
tab_1.tabpage_custom.dw_1.event ue_populatedddws( )
tab_1.tabpage_1.dw_1.ib_retrieve_drop_downs = false
tab_1.tabpage_1.dw_1.event ue_populatedddws( )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.14.2007 By: Jack (Contract)
//$<reason> Fix a defect.
tab_1.tabpage_2.dw_1.ib_retrieve_drop_downs = false
tab_1.tabpage_2.dw_1.event ue_populatedddws( )

//---------------------------- APPEON END ----------------------------
//Begin - Added By Mark Lee 05/15/12
tab_1.tabpage_group_access.dw_1.ib_retrieve_drop_downs = false
tab_1.tabpage_group_access.dw_1.event ue_populatedddws( )
//End - Added By Mark Lee 05/15/12


dw_1.sharedata(dw_contract_dates)
dw_1.sharedata( this.tab_1.tabpage_custom.dw_1)
dw_1.sharedata( this.tab_1.tabpage_notes.dw_1 )

//Added By Mark Lee 07/04/12
//dw_ccc.object.ctx_contract_contacts_owner.Visible  = false
//dw_ccc.object.ctx_contract_contacts_owner_t.Visible  = false
//
//dw_ccc.object.access.Visible  = false
//dw_ccc.object.access_t.Visible  = false
dw_ccc.Modify("ctx_contract_contacts_owner.Visible= 0")
dw_ccc.Modify("ctx_contract_contacts_owner_t.Visible= 0")
dw_ccc.Modify("access.Visible= 0")
dw_ccc.Modify("access_t.Visible= 0")

If ib_new = false Then
	ib_retrieved = false
	of_retrieve()
Else
	event ue_new()
End If
dw_contract_dates.setfocus()
dw_contract_dates.setcolumn('version_number')

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-22 By: Liu Hongxin
//$<reason>: Modify by user Requirement.
dw_ccc.Modify("default_email_t.text = 'Default To'")
dw_occ.Modify("default_email_t.text = 'Default From'")
//---------------------------- APPEON END ----------------------------

this.event ue_set_screen_properties( )  //Jervis 08.17.2010			////Modified By Mark Lee 01/15/2013 duplicate from of_create_dw()
end subroutine

public function integer of_set_default_value (datawindow adw);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: LeiWei
//$<reason> Fix a defect.
Long ll_column_count
Long ll_column
String ls_column_name
String ls_str

ll_column_count = long(adw.Describe("DataWindow.Column.Count"))
FOR ll_column = 1 TO ll_column_count
	ls_column_name = Lower(adw.Describe("#" + string(ll_column) + ".name"))
	//Modified by Nova on 2008-08-14
	ls_str = adw.Describe(ls_column_name + ".Initial")
	
	IF ls_str = "!" Or ls_str = "?" Or ls_str = "" Or Lower(ls_str) = "null" Or isnull(ls_str) Then
		Continue
	End If
  //Modified by Nova on 2008-08-14
	CHOOSE CASE Lower ( Left ( adw.Describe ( ls_column_name + ".ColType" ) , 5 ) )
		CASE "char(", "char"		//  CHARACTER DATATYPE
			adw.SetItem ( 1, ls_column_name, ls_str ) 
		CASE "date"			//  DATE DATATYPE
			Choose Case lower(ls_str) 
				Case 'today','now' 	//Added By Ken.Guo 2010-10-14.
					adw.SetItem ( 1, ls_column_name, Date(today()))	 //Added By Ken.Guo 2010-10-14.
				Case Else
					adw.SetItem ( 1, ls_column_name, Date (ls_str) ) 
			End Choose			
			
		CASE "datet"		//  DATETIME DATATYPE
			Choose Case lower(ls_str) 
				Case 'today','now'	//Added By Ken.Guo 2010-10-14.
					adw.SetItem ( 1, ls_column_name, today())	 //Added By Ken.Guo 2010-10-14.
				Case Else
					adw.SetItem ( 1, ls_column_name, DateTime (Date (ls_str) ))	
			End Choose
		CASE "decim"		//  DECIMAL DATATYPE
			adw.SetItem ( 1, ls_column_name, Dec(ls_str) )
		CASE "numbe", "doubl"			//  NUMBER DATATYPE	
			adw.SetItem ( 1, ls_column_name, Double(ls_str) ) 
		CASE "long", "ulong"		//  LONG/INTEGER DATATYPE	
			adw.SetItem ( 1, ls_column_name, Long(ls_str)) 
		CASE "time", "times"		//  TIME DATATYPE
			Choose Case lower(ls_str) 
				Case 'today','now' 	//Added By Ken.Guo 2010-10-14.
					adw.SetItem ( 1, ls_column_name, Time(today()))	 //Added By Ken.Guo 2010-10-14.
				Case Else
					adw.SetItem ( 1, ls_column_name, Time ( ls_str ) ) 
			End Choose					
			
	END CHOOSE
NEXT

Return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_send_email (datawindow adw_send);str_ctx_email 	lstr_ctx_email
DataStore		lds_Email
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2009-05-12 By: Ken.Guo
//$<reason> Add Multi-CTXs to send email.
/* 
//Use a standard interface - Alfee 12.15.2008
lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
lstr_ctx_email.doc_from = 'CTX'
*/
Long 		ll_Cycle,ll_RowCnts,ll_ctx_id,ll_SelectedRow
String	ls_SingleEmail,ls_AllEmails
Datawindow ldw_search

If gw_contract.tab_contract_details.Selectedtab = 1 Then
	ldw_search = gw_contract.tab_contract_details.tabpage_search.dw_search_det1
	
	ll_SelectedRow = ldw_search.GetSelectedRow(0)
	do while ll_SelectedRow > 0
		ll_ctx_id = ldw_search.GetItemNumber(ll_SelectedRow,'ctx_id')
		lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list[]) + 1] = ll_ctx_id
		ll_SelectedRow = ldw_search.GetSelectedRow(ll_SelectedRow)
	loop

	If UpperBound(lstr_ctx_email.ctx_id_list[]) > 1 Then
		//Multi CTXs need send email.
		lstr_ctx_email.ctx_id = lstr_ctx_email.ctx_id_list[1]
		lstr_ctx_email.doc_from = 'CTXS'
	Else
		lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_ctx_email.doc_from = 'CTX_SEARCH'
		
		lds_Email = Create DataStore
		lds_Email.DataObject = "d_defaultcontactemail"
		lds_Email.SetTransObject(SQLCA)
		lds_Email.Retrieve(lstr_ctx_email.ctx_id)
	
		ll_RowCnts = lds_Email.RowCount()
		for ll_Cycle = 1 to ll_RowCnts
			ls_SingleEmail = Trim(lds_Email.GetItemString(ll_Cycle,"ctx_contacts_numbers_contact_email"))
			if Not IsNull(ls_SingleEmail) and ls_SingleEmail <> "" then
				if ll_Cycle > 1 then ls_AllEmails += ";"
				ls_AllEmails += ls_SingleEmail
			end if
		next
		Destroy lds_Email
		lstr_ctx_email.EmailTo = ls_AllEmails
	End If
Else
	//Use a standard interface - Alfee 12.15.2008
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
	lstr_ctx_email.doc_from = 'CTX'
End If
//---------------------------- APPEON END ----------------------------

OpenWithParm( w_dm_email_document_send, lstr_ctx_email)

RETURN 1

////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.20.2006 By: Davis
////$<reason> Implement new requirement.
//IF adw_send.Rowcount() = 0 THEN
//	//---------Appeon Begin-by alfee at 04.30.2007 for use new email window---
//	//OpenWithParm( w_get_email_message, inv_contract_details.of_get_ctx_id( ))
//	//OpenWithParm( w_dm_email_document_send, inv_contract_details.of_get_ctx_id( ))
//	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
//	lstr_ctx_email.doc_from = 'CTX'
//	OpenWithParm( w_dm_email_document_send, lstr_ctx_email)
//	//---------Appeon End----------------------------------------
//	RETURN 1
//END IF
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2006-10-11 By: Liu Hongxin
////$<reason> Add eMail functionality, replace u_dw.ue_email().
//Long   ll_find
//string ls_full_name
//String ls_Sendto
//DataWindowChild dwchild
// 
////Get the sent eMail Address Information.
//Datastore lds_Sendto
//lds_Sendto = Create Datastore
//lds_Sendto.DataObject = "d_contract_contact_search"
//lds_Sendto.SetTransObject(Sqlca)
//lds_Sendto.Retrieve()
// 
///*
//li_count = adw_send.RowCount()
//For i = 1 to li_count
// IF adw_send.GetItemString(i, "default_email") = "Y" THEN
//  ls_full_name = adw_send.GetItemString(i, "compute_1")
//  ll_find = lds_Sendto.Find("full_name = '" + ls_full_name + "'", 1, lds_Sendto.RowCount())
//  IF ll_find > 0 THEN
//   IF ls_Sendto = "" THEN
//    ls_Sendto = Trim(lds_Sendto.GetItemString(ll_find, "contact_email"))
//   ELSE
//    ls_Sendto += ";" + Trim(lds_Sendto.GetItemString(ll_find, "contact_email"))
//   END IF
//  END IF
// END IF
//Next
//*/
//ls_full_name = adw_send.GetItemString(adw_send.GetRow(), "compute_1")
//ll_find = lds_Sendto.Find('full_name = "' + ls_full_name + '"', 1, lds_Sendto.RowCount())
//IF ll_find > 0 THEN
// ls_Sendto = Trim(lds_Sendto.GetItemString(ll_find, "contact_email"))
//END IF
//IF IsNull(ls_Sendto) THEN ls_Sendto = ""
//ls_full_name = gs_dbtype
//gs_dbtype = ls_Sendto
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modified> 2007-04-19 By: Wu ZhiJun
////$<reason> Fix a bug
//long	ll_Row
//
//ll_Row = dw_1.GetRow()
//if ll_Row > 0 then
//	gl_Company_id = dw_1.GetItemNumber(ll_Row,'app_facility')
//end if
////--------------------------- APPEON END -----------------------------
//
////---------Appeon Begin-by alfee at 04.30.2007 for use new email window---
////OpenWithParm( w_get_email_message, adw_send)
////OpenWithParm( w_dm_email_document_send, adw_send)
//lstr_ctx_email.ctx_id = adw_send.GetItemNumber(adw_send.GetRow(), "ctx_id")
//lstr_ctx_email.doc_from = 'CTX'
//OpenWithParm( w_dm_email_document_send, lstr_ctx_email)
////---------Appeon End----------------------------------------
// 
//gs_dbtype = ls_full_name
//
////--------------------------- APPEON BEGIN ---------------------------
////$<Add> 08.23.2007 By: Evan
////$<Reason> Need to destroy object.
//if IsValid(lds_Sendto) then Destroy lds_Sendto
////---------------------------- APPEON END ----------------------------
//
//Return 0
////---------------------------- APPEON END ----------------------------

end function

public function integer of_create_action_item_by_workflow ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.16.2006 By: Jervis
//$<reason> Trigger Work flow when new Contract Logix Contract Tracking
long ll_ctx_id,ll_status_id,ll_category
n_cst_workflow_triggers lnv_workflow
str_action_item lstr_action

If not gb_workflow Then return 0
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Jack
//$<reason> Fix a defect.
If dw_1.getrow() < 1 then Return 0
//---------------------------- APPEON END ----------------------------

//Begin - Modified By Ken.Guo 12/21/2012
//ll_status_id  = long(gnv_data.of_getItem("code_lookup","lookup_code","lookup_name ='Contract Status' and code = 'PENDING'" ))
//if ll_status_id = dw_1.GetItemNumber(1,"status") then
Long i
String ls_wf_id
n_ds lds_data_workflow
lds_data_workflow = Create n_ds
lds_data_workflow.dataobject = 'd_g_workflow_data'
lds_data_workflow.settransobject(SQLCA)
ll_status_id = dw_1.GetItemNumber(1,"status")
gnv_data.of_retrieve("wf_workflow") 

//Added By Ken.Guo 12/24/2012
gnv_data.of_get_data_from_cache( 'wf_workflow', "wf_module = '03' and wf_triggered_by = '002' and (IsNull(wf_triggered_ctx_status) or wf_triggered_ctx_status = 'all' or Pos(wf_triggered_ctx_status , '" + String(ll_status_id) + "' ) > 0  ) and " + &
											"  wf_status = 'A' ", lds_data_workflow )
ll_category = dw_1.GetItemNumber(1,"category")
lstr_action.wf_id = long(gnv_data.of_getitem("code_lookup","custom_5","lookup_code =" + string(ll_category)))
If lds_data_workflow.Find('wf_id = ' + String(lstr_action.wf_id), 1, lds_data_workflow.RowCount() ) > 0 Then
	lnv_workflow = create n_cst_workflow_triggers
	lstr_action.ctx_id =  dw_1.GetItemNumber(1,"ctx_id")
	lnv_workflow.of_workflow_create_action_items(lstr_action)
	destroy lnv_workflow
end if
//---------------------------- APPEON END ----------------------------

If isvalid(lds_data_workflow) Then Destroy lds_data_workflow

return 1
end function

public function integer of_open_contact (u_dw adw, string as_string, boolean ab_detail);
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.21.2006 By: LeiWei
//$<reason> Fix a defect.
IF dw_1.Rowcount( ) = 0 THEN RETURN 1
//---------------------------- APPEON END ----------------------------

str_pass 	lstr_pass
String		ls_Company
long ll_contact_id,ll_access

////Add group access - jervis 11.26.2010
//if (as_string = 'EXTERNAL' OR as_string = 'INTERNAL') and adw.GetRow() > 0 then
//	ll_contact_id = adw.GetItemNumber(adw.GetRow(),"contact_id")
//	select 1 into :ll_access	
//	FROM ctx_contacts left join ctx_contact_group_access on (ctx_contacts.contact_id = ctx_contact_group_access.contact_id and ctx_contacts.contact_id = :ll_contact_id) 
//								left join security_group_users on (ctx_contact_group_access.group_id = security_group_users.group_id)
//	WHERE  (((ctx_contact_group_access.Access <> 'N' or ctx_contact_group_access.Access is null) and 
//		 Upper(security_group_users.user_id) = Upper(:gs_user_id)) or security_group_users.user_id is null) ;
//
//
//	if ll_access <> 1 then
//		MessageBox("information","The current user does not have permission to view the contact information.")
//		return 1
//	end if
//end if

lstr_pass.s_u_dw = adw

ls_Company = String(this.dw_1.object.app_facility[1])
if IsNull(ls_Company) then ls_Company = '0'

lstr_pass.s_string_array[1]  = ls_Company// company name id of the contract
lstr_pass.s_string = as_string // as_string 'EXTERNAL'

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Davis
lstr_pass.display_contact_detail = ab_detail
//---------------------------- APPEON END ----------------------------
lstr_pass.ab_newrecord = ib_new //added by gavins 20121029

OpenWithParm ( w_contract_contact, lstr_pass)
If isvalid( gw_contract) and ib_new Then 
	ib_forbidvalidate = True
	gw_contract.wf_setupdateobjects( ) //added by gavins 20121113
	ib_forbidvalidate =false
End If
return 1
end function

public subroutine of_set_buttons (boolean ab_enabled);//--obsolete Alfee 09.27.2007
////Set Date Alarm Buttons - added by alfee 09.26.2007 
//
//String ls_flag = 'grayflag.bmp'
//
////Set enabled property
//dw_contract_dates.OBJECT.b_effective_date.enabled = ab_enabled 
//dw_contract_dates.OBJECT.b_expriation_date.enabled = ab_enabled 
//dw_contract_dates.OBJECT.b_review_date.enabled = ab_enabled 
//dw_contract_dates.OBJECT.b_last_revis_date.enabled = ab_enabled 
//dw_contract_dates.OBJECT.b_other_date_1.enabled = ab_enabled 
//dw_contract_dates.OBJECT.b_term_date.enabled = ab_enabled 
//dw_contract_dates.OBJECT.b_other_date_2.enabled = ab_enabled 
//dw_contract_dates.OBJECT.b_version_date.enabled = ab_enabled 
//
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date1.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date2.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date3.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date4.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date5.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date6.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date7.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date8.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date9.enabled = ab_enabled 
//tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date10.enabled = ab_enabled
//
////Set flags
//IF ab_enabled THEN
//	of_set_flags()
//ELSE
//	dw_contract_dates.OBJECT.b_effective_date.filename = ls_flag 
//	dw_contract_dates.OBJECT.b_expriation_date.filename = ls_flag 
//	dw_contract_dates.OBJECT.b_review_date.filename = ls_flag 
//	dw_contract_dates.OBJECT.b_last_revis_date.filename = ls_flag 
//	dw_contract_dates.OBJECT.b_other_date_1.filename = ls_flag 
//	dw_contract_dates.OBJECT.b_term_date.filename = ls_flag 
//	dw_contract_dates.OBJECT.b_other_date_2.filename = ls_flag 
//	dw_contract_dates.OBJECT.b_version_date.filename = ls_flag 
//
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date1.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date2.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date3.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date4.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date5.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date6.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date7.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date8.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date9.filename = ls_flag 
//	tab_1.tabpage_custom.dw_1.OBJECT.b_custom_date10.filename = ls_flag 
//END IF
//





end subroutine

public subroutine of_add_contract_contact (long al_facid);//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-11-01 By: Scofield
//$<Reason> When select the company then add the corresponding contact

long		ll_ConId,ll_Row,ll_ConType,ll_Find,ll_Cnts
String	ls_LastName,ls_FirstName,ls_MidName,ls_Userd,ls_Phone,ls_EMail, ls_ext

SELECT Count(*) INTO :ll_Cnts FROM CTX_CONTACTS WHERE facility_id = :al_FacId;

if ll_Cnts = 1 then
	SELECT last_name,
			 first_name,
			 middle_name,
			 contact_id,
			 contact_type,
			 user_d
	  INTO :ls_LastName,
			 :ls_FirstName,
			 :ls_MidName,
			 :ll_ConId,
			 :ll_ConType,
			 :ls_Userd
	  FROM ctx_contacts
	 WHERE facility_id = :al_FacId;
else
	SELECT last_name,
			 first_name,
			 middle_name,
			 contact_id,
			 contact_type,
			 user_d
	  INTO :ls_LastName,
			 :ls_FirstName,
			 :ls_MidName,
			 :ll_ConId,
			 :ll_ConType,
			 :ls_Userd
	  FROM ctx_contacts
	 WHERE facility_id = :al_FacId and defaultto = '1';
end if

if Not IsNull(ll_ConId) and ll_ConId > 0 then
	ll_Find = dw_ccc.Find("contact_id= " + String(ll_ConId),1,dw_ccc.RowCount())
	if ll_Find <= 0 then
		SELECT top 1 phone,ext
		  INTO :ls_Phone, :ls_ext
		  FROM ctx_contacts_numbers
		 WHERE contact_id =  :ll_ConId and via = (SELECT top 1 lookup_code FROM code_lookup WHERE lookup_name = 'Contract Contact Via' and code = 'Phone' ) ;

		SELECT top 1 contact_email
		  INTO :ls_EMail
		  FROM ctx_contacts_numbers
		  WHERE contact_id = :ll_ConId and via = (SELECT top 1 lookup_code FROM code_lookup WHERE lookup_name = 'Contract Contact Via' and code = 'Email' ) ;
	
		ll_Row = dw_ccc.insertrow(0)
		
		dw_ccc.SetItem(ll_Row,'last_name',ls_LastName)
		dw_ccc.SetItem(ll_Row,'first_name',ls_FirstName)
		dw_ccc.SetItem(ll_Row,'middle_name',ls_MidName)
		dw_ccc.SetItem(ll_Row,'contact_id',ll_ConId)
		dw_ccc.SetItem(ll_Row,'contact_type',ll_ConType)
		dw_ccc.SetItem(ll_Row,'contact_phone',ls_Phone)
		
		//Added By Ken.Guo 07/18/2012
		If Len(dw_ccc.Describe( 'phone_ext.type')) > 1 Then
			dw_ccc.SetItem(ll_Row,'phone_ext',ls_ext)	
		End If
		
		dw_ccc.SetItem(ll_Row,'user_d',ls_Userd)
		dw_ccc.SetItem(ll_Row,'contact_email',ls_EMail)
		
		
		ll_Find = dw_ccc.Find("default_email= 'Y'",1,dw_ccc.RowCount())
		if ll_Cnts = 1 or ll_Find <= 0 then
			dw_ccc.SetItem(ll_Row,'default_email','Y')
		end if
	else
		dw_ccc.SetItem(ll_Find,'default_email','Y')
	end if
end if
//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine of_refreshtab ();//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-13 By: Scofield
//$<Reason> Select the visible tabpage.

tab_1.Visible = true
cb_Max.Visible = true		 

if tab_1.tabpage_custom.Visible then
	tab_1.SelectTab(1)
//Begin - Added By Mark Lee 12/28/2012
//elseif tab_1.tabpage_notes.Visible then
//	tab_1.SelectTab(2)
//elseif tab_1.tabpage_1.Visible then
//	tab_1.SelectTab(3)
elseif tab_1.tabpage_1.Visible then
	tab_1.SelectTab(2)
elseif tab_1.tabpage_notes.Visible then
	tab_1.SelectTab(3)
//End - Added By Mark Lee 12/28/2012
elseif tab_1.tabpage_2.Visible then
	tab_1.SelectTab(4)
else
	tab_1.Visible = false
	cb_Max.Visible = false		 
end if
//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine of_statusaudit ();//==============================================================================
// Function: of_StatusAudit()
//------------------------------------------------------------------------------
// Description: Audit contract status
// Arguments: None
// Return Value: None
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-05-22
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

long	ll_OriStatus,ll_CurStatus,ll_LastStatus
long	ll_Row,ll_ctx_id,ll_SeqNo

DateTime	ldt_Now

dwitemstatus	ldw_ItemStatus

ll_Row = dw_1.GetRow()
if ll_Row <= 0 or ll_Row > dw_1.RowCount() then Return

ll_ctx_id = dw_1.GetItemNumber(ll_Row,'ctx_id')
ldw_ItemStatus = dw_1.GetItemStatus(ll_Row,0,Primary!)
ll_OriStatus = dw_1.GetItemNumber(ll_Row,'status',Primary!,true)
ll_CurStatus = dw_1.GetItemNumber(ll_Row,'status',Primary!,false)
//if IsNull(ll_CurStatus) or (ll_CurStatus = ll_OriStatus and ldw_ItemStatus <> NewModified!) then Return
if (not isnull(ll_CurStatus)) and (ll_CurStatus <> ll_OriStatus or ldw_ItemStatus = NewModified! ) then
	gf_statusaudit(ll_ctx_id,ll_CurStatus,'status')
end if

//add custom status process - jervis 04.19.2011
ll_OriStatus = dw_1.GetItemNumber(ll_Row,'custom_status1',Primary!,true)
ll_CurStatus = dw_1.GetItemNumber(ll_Row,'custom_status1',Primary!,false)
if (ll_CurStatus <> ll_OriStatus or ldw_ItemStatus = NewModified! ) then
	gf_statusaudit(ll_ctx_id,ll_CurStatus,'custom_status1')
end if

ll_OriStatus = dw_1.GetItemNumber(ll_Row,'custom_status2',Primary!,true)
ll_CurStatus = dw_1.GetItemNumber(ll_Row,'custom_status2',Primary!,false)
if (ll_CurStatus <> ll_OriStatus or ldw_ItemStatus = NewModified! ) then
	gf_statusaudit(ll_ctx_id,ll_CurStatus,'custom_status2')
end if



end subroutine

public subroutine of_deletesearchtabctx (long al_deleted_ctx_id);//====================================================================
// Function: of_DeleteSearchTabCTX()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_deleted_ctx_id
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-05-21
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FoundRow,ll_CurRow

DataWindow	ldw_det1
DataStore	lds_search

ldw_det1 = gw_contract.tab_contract_details.tabpage_search.dw_search_det1
ll_FoundRow = ldw_det1.Find("ctx_id = " + String(al_deleted_ctx_id),1,ldw_det1.RowCount())
if ll_FoundRow > 0 then
	ll_CurRow = ldw_det1.GetRow()
	ldw_det1.DeleteRow(ll_FoundRow)
	/*
	ll_CurRow --
	if ll_CurRow <= 0 then ll_CurRow = 1

	if ldw_det1.RowCount() > 0 then
		ldw_det1.SetRow(ll_CurRow)
		ldw_det1.ScrollToRow(ll_CurRow)
		ldw_det1.Selectrow(ll_CurRow,true)
		if ll_CurRow = 1 then
			ldw_det1.Event RowFocusChanging(ll_CurRow,ll_CurRow)
			ldw_det1.Event RowFocusChanged(ll_CurRow)
		end if
	end if
	*/
end if

lds_search = gw_contract.tab_contract_details.tabpage_search.ids_search
ll_FoundRow = lds_search.Find("ctx_id = " + String(al_deleted_ctx_id),1,lds_search.RowCount())

if ll_FoundRow > 0 then lds_search.DeleteRow(ll_FoundRow)

end subroutine

public subroutine of_create_custom_dw ();//dynamic create custom tab - Add by Jervis 

string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id,ll_i
datawindow ld_dw[]

ls_tab_name = 'tabpage_details'

if tab_1.ib_created_1  then
	ll_i ++
	ld_dw[ll_i] = tab_1.tabpage_custom.dw_1
	ls_dw_name[ll_i] = 'dw_1'
	ls_dataobject[ll_i] = 'd_contract_det_custom'
end if
if tab_1.ib_created_3 then
	ll_i ++
	ld_dw[ll_i] = tab_1.tabpage_notes.dw_1
	ls_dw_name[ll_i] = 'dw_1'
	ls_dataobject[ll_i] = 'd_contract_det_notes'
end if
if tab_1.ib_created_2 then
	ll_i ++
	ld_dw[ll_i] = tab_1.tabpage_1.dw_1
	ls_dw_name[ll_i] = 'dw_1'
	ls_dataobject[ll_i] = 'd_contract_det_custom_2'
end if
if tab_1.ib_created_4 then
	ll_i ++
	ld_dw[ll_i] = tab_1.tabpage_2.dw_1
	ls_dw_name[ll_i] = 'dw_1'
	ls_dataobject[ll_i] = 'd_sp_contract_search'
end if
if tab_1.ib_created_5 then
	ll_i ++
	ld_dw[ll_i] = tab_1.tabpage_group_access.dw_1
	ls_dw_name[ll_i] = 'dw_1'
	ls_dataobject[ll_i] = 'd_contract_det_group_access'
end if

//-------------appeon begin----------------------
//<$>added:long.zhang 04.14.2014
//<$>reason:v14.2 Provider-Contract direct linking
if tab_1.ib_created_6 then
	ll_i ++
	ld_dw[ll_i] = tab_1.tabpage_linkprovider.dw_1
	ls_dw_name[ll_i] = 'dw_1'
	ls_dataobject[ll_i] = 'd_ctx_provider_direct_link'
end if
//-------------appeon End------------------------

if ll_i > 0 then f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		

end subroutine

public subroutine of_adjust_position (boolean abln_flag);//====================================================================
// Function: of_adjust_position
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/11/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//====================================================================
String 			ls_position, ls_tag, ls_left[], ls_right[], ls_err
Boolean 			lbn_left = False
Long				ll_y , ll_x, i , j , ll_position_x, ll_move_x, ll_move_width
Datawindow		ld_dw[], ld_dw_left[], ld_dw_right[], ld_dw_left_end
n_cst_string		ln_cst_string
Integer			li_upperbound,  li_pos
long 				ll_view_id
Boolean 			lbn_invisible_left,  lbn_invisible_right


//set default value
ll_x = 15 
ll_move_x = ll_x
ll_move_width = this.width - ll_x
lbn_left = False
lbn_invisible_left = False
lbn_invisible_right = False
li_pos = 0 
//restore the positon
If st_vbar.y < 0 Then  
	ll_y = st_vbar.y +15
Else
	ll_y = 15 
End If 

ld_dw[1] = dw_1
ld_dw[2] = dw_products
ld_dw[3] = dw_ccc
ld_dw[4] = dw_occ
ld_dw[5] = dw_contract_dates

////update gnv_user_option copy data
//gnv_user_option.of_viewid_copy_retrieve( )
ls_position = gnv_user_option.of_get_viewid_option_value_copy( gi_contract_view_id, "Contract_Detail_Tab_Detail_Tab.x" )
gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
If  isnull(ls_position) or trim(ls_position) = '' then 
	ls_position = gnv_user_option.of_get_viewid_option_value_copy( 1000, "Contract_Detail_Tab_Detail_Tab.x" )
	gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
	ll_position_x =  this.width * Dec(ls_position)
	ll_view_id	= 1000		
Else
	ll_position_x =  this.width * Dec(ls_position)
	ll_view_id	= gi_contract_view_id		
End If

//set default value
st_vbar.x = ll_position_x

If is_products_visible = 'N' and dw_products.visible then
	dw_products.hide( )
End IF 
If is_contract_dates_visible = 'N' and dw_contract_dates.visible then
	dw_contract_dates.hide( )
End IF 

//the num 6 except
For i = 1 to 5
	ls_tag = ld_dw[i].tag 
	ls_tag = ln_cst_string.of_globalreplace(ls_tag,' ','_')
	ls_position = gnv_user_option.of_get_viewid_option_value_copy( ll_view_id, "Contract_Tabpage_Details_"+ls_tag+"_Num" )
	IF isnull(ls_position) or trim(ls_position) = '' Then 
//		Exit
		Return
	Else
		ls_tag = ld_dw[i].tag 
		IF ( is_products_visible = 'N' and ls_tag = 'Products' ) Or ( is_contract_dates_visible = 'N' and ls_tag = 'Contract Dates' ) Then 
			IF  left(ls_position,1) = 'R' Then 
				lbn_invisible_right = True
			Else
				lbn_invisible_left = True
			End If
			Continue
		End IF 					
		IF  left(ls_position,1) = 'R' Then 
			j = Integer(Mid(ls_position,2,len(ls_position)))
			ld_dw_right[j] =  ld_dw[i]
		ElseIf  left(ls_position,1) = 'L'  Then 
			j = Integer(Mid(ls_position,2,len(ls_position)))
			ld_dw_left[j] =  ld_dw[i]
			lbn_left = True
		End IF 
	End If 
Next 

IF isnull(ls_position) or trim(ls_position) = '' Then 
	Return
End IF 

IF lbn_left = True then 
	li_upperbound = Upperbound(ld_dw_left)
	For i = 1 to li_upperbound
		If not Isvalid(ld_dw_left[i]) then 
			Continue
		End IF
		ls_tag = ld_dw_left[i].tag 
		ls_tag = ln_cst_string.of_globalreplace(ls_tag,' ','_')
		ls_position = gnv_user_option.of_get_viewid_option_value_copy( ll_view_id, "Contract_Tabpage_Details_"+ls_tag+".height" )
		gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
		ld_dw_left[i].move( ll_x, ll_y)
		ld_dw_left[i].resize( ll_position_x - ll_x - 10 , Integer(Dec(ls_position) * this.height))
		ll_y = ld_dw_left[i].y +  ld_dw_left[i].height + 20
		 j = i						//  record the end dw of position
	Next
	
	//If there have difference of  100 bound between the end dw's height and this pane height in the left position,
	// we will adjust the same position with this pane height.
	If lbn_invisible_left = False Then	 
		If (ld_dw_left[j].y +  ld_dw_left[j].height  -   this.height <= 100 and ld_dw_left[j].y +  ld_dw_left[j].height  -   this.height > 0  )or &
			(	this.height - ld_dw_left[j].y -  ld_dw_left[j].height <= 100 and this.height - ld_dw_left[j].y -  ld_dw_left[j].height > 0  ) then 
				ld_dw_left[j].height  = this.height - ld_dw_left[j].y 
		End If
	Else
		ld_dw_left[j].height  = this.height - ld_dw_left[j].y 
	End If
	
	// set vscrollbar 
	If this.vscrollbar = False and ll_y - 25 > this.height and this.height > 800  Then 
		this.vscrollbar = True
	End If 
	
	//for right's position
	ll_move_x  = ll_position_x + 10
	ll_move_width = this.width - ll_position_x - 20  
	//restore the positon
	If st_vbar.y < 0 Then  
		ll_y = st_vbar.y + 20
	Else
		ll_y = 15 
	End If 	
Else
	ll_move_x  = ll_x
	ll_move_width = this.width - ll_x 
	st_vbar.x = 0 				//reset
End If 

j = 0 
li_upperbound = Upperbound(ld_dw_right)
For i = 1 to li_upperbound
	If not Isvalid(ld_dw_right[i]) then 
		Continue
	End IF
	ls_tag = ld_dw_right[i].tag 
	ls_tag = ln_cst_string.of_globalreplace(ls_tag,' ','_')
	ls_position = gnv_user_option.of_get_viewid_option_value_copy( ll_view_id, "Contract_Tabpage_Details_"+ls_tag+".height" )
	gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
	ld_dw_right[i].move( ll_move_x , ll_y)
	ld_dw_right[i].resize( ll_move_width , Integer( Dec(ls_position) * this.height))
	ll_y = ld_dw_right[i].y + ld_dw_right[i].height + 20
	 j = i						//  record the end dw of position
Next

//tab 
ls_position = gnv_user_option.of_get_viewid_option_value_copy( ll_view_id, "Contract_Tabpage_Details_Tab_Detail.height" )
gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
tab_1.move(ll_move_x, ll_y)
tab_1.resize( ll_move_width, Integer( Dec(ls_position) * this.height))

If lbn_invisible_right = True and this.height  - tab_1.y  > 0 Then 
	tab_1.height  = this.height  - tab_1.y 
End If 

//If there have difference of  100 bound between the end dw's height and this pane height in the left position,
// we will adjust the same position with this pane height.
If ( (tab_1.y + tab_1.height  -   this.height <= 100 and tab_1.y + tab_1.height  -   this.height > 0  )or &
	(	this.height -tab_1.y -  tab_1.height <= 100 and this.height -tab_1.y -  tab_1.height > 0  )  ) and  this.height  - tab_1.y  > 0 then 
		tab_1.height  = this.height  - tab_1.y 
End If
 
// set vscrollbar 
If this.vscrollbar = False and ll_y + tab_1.height > this.height and this.height > 800   Then 
	this.vscrollbar = True
End If 

IF this.vscrollbar = True then 
	For i = 1 to li_upperbound
		If not Isvalid(ld_dw_right[i]) then 
			Continue
		End IF
		If ld_dw_right[i].x + ld_dw_right[i].width + 86 > this.width then 
			ld_dw_right[i].width =  this.width - ld_dw_right[i].x  - 86
//			ld_dw_right[i].width =  this.width - ld_dw_right[i].x  - 76
		End If 
	Next
	If tab_1.x + tab_1.width + 86 > this.width then 
		tab_1.width =  this.width - tab_1.x - 86
//		tab_1.width =  this.width - tab_1.x - 76
	End If 
End IF 

cb_max.y = tab_1.y
cb_max.x = tab_1.x + tab_1.width - cb_max.width
IF cb_max.text = "-" THEN
	cb_max.text = '+'
End IF 

IF abln_flag = True Then 	
	tab_1.tabpage_custom.dw_1.width = tab_1.tabpage_custom.width - tab_1.tabpage_custom.dw_1.x  
	tab_1.tabpage_custom.dw_1.height = tab_1.tabpage_custom.height  - tab_1.tabpage_custom.dw_1.y  
	tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - tab_1.tabpage_1.dw_1.x 
	tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - tab_1.tabpage_1.dw_1.y  
	tab_1.tabpage_notes.dw_1.width = tab_1.tabpage_notes.width - tab_1.tabpage_notes.dw_1.x
	tab_1.tabpage_notes.dw_1.height = tab_1.tabpage_notes.height  - tab_1.tabpage_notes.dw_1.y
	tab_1.tabpage_2.dw_1.width = tab_1.tabpage_2.width - tab_1.tabpage_2.dw_1.x
	tab_1.tabpage_2.dw_1.height = tab_1.tabpage_2.height  - tab_1.tabpage_2.dw_1.y
	tab_1.tabpage_group_access.dw_1.width = tab_1.tabpage_group_access.width - tab_1.tabpage_group_access.dw_1.x
	tab_1.tabpage_group_access.dw_1.height = tab_1.tabpage_group_access.height  - tab_1.tabpage_group_access.dw_1.y
	
	//Reset orignal size   
	if IsValid(this.inv_resize) then
		this.inv_resize.of_SetOrigSize(dw_1, dw_1.x, dw_1.y, dw_1.width, dw_1.height)
		this.inv_resize.of_SetOrigSize(dw_products, dw_products.x, dw_products.y, dw_products.width, dw_products.height)	
		this.inv_resize.of_SetOrigSize(dw_ccc, dw_ccc.x, dw_ccc.y, dw_ccc.width, dw_ccc.height)
		this.inv_resize.of_SetOrigSize(dw_occ, dw_occ.x, dw_occ.y, dw_occ.width, dw_occ.height)
		this.inv_resize.of_SetOrigSize(dw_contract_dates, dw_contract_dates.x, dw_contract_dates.y, dw_contract_dates.width, dw_contract_dates.height)
		this.inv_resize.of_SetOrigSize(tab_1, tab_1.x, tab_1.y, tab_1.width, tab_1.height)	
	end if
	
	if isvalid(tab_1.inv_resize) then	
		tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_1.dw_1, tab_1.tabpage_1.dw_1.x, tab_1.tabpage_1.dw_1.y, tab_1.tabpage_1.dw_1.width, tab_1.tabpage_1.dw_1.height)
		tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_notes.dw_1, tab_1.tabpage_notes.dw_1.x, tab_1.tabpage_notes.dw_1.y, tab_1.tabpage_notes.dw_1.width, tab_1.tabpage_notes.dw_1.height)
		tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_custom.dw_1, tab_1.tabpage_custom.dw_1.x, tab_1.tabpage_custom.dw_1.y, tab_1.tabpage_custom.dw_1.width, tab_1.tabpage_custom.dw_1.height)
		tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_2.dw_1, tab_1.tabpage_2.dw_1.x, tab_1.tabpage_2.dw_1.y, tab_1.tabpage_2.dw_1.width, tab_1.tabpage_2.dw_1.height)			
		tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_group_access.dw_1, tab_1.tabpage_group_access.dw_1.x, tab_1.tabpage_group_access.dw_1.y, tab_1.tabpage_group_access.dw_1.width, tab_1.tabpage_group_access.dw_1.height)
	end if
End If

end subroutine

public subroutine of_set_forbid_validate (boolean ab_value);ib_forbidvalidate = ab_value
end subroutine

on u_tabpg_contract_detail1.create
int iCurrent
call super::create
this.dw_occ=create dw_occ
this.dw_ccc=create dw_ccc
this.dw_custom=create dw_custom
this.tab_1=create tab_1
this.dw_products=create dw_products
this.dw_1=create dw_1
this.dw_contract_dates=create dw_contract_dates
this.st_vbar=create st_vbar
this.cb_max=create cb_max
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_occ
this.Control[iCurrent+2]=this.dw_ccc
this.Control[iCurrent+3]=this.dw_custom
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.dw_products
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.dw_contract_dates
this.Control[iCurrent+8]=this.st_vbar
this.Control[iCurrent+9]=this.cb_max
end on

on u_tabpg_contract_detail1.destroy
call super::destroy
destroy(this.dw_occ)
destroy(this.dw_ccc)
destroy(this.dw_custom)
destroy(this.tab_1)
destroy(this.dw_products)
destroy(this.dw_1)
destroy(this.dw_contract_dates)
destroy(this.st_vbar)
destroy(this.cb_max)
end on

event constructor;call super::constructor;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 28 July 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long	ll_CusRight,ll_NotesRight,ll_AuditRight,ll_TrackRight,ll_ProviderRight

/////////////////////////////////////////////////////////////
// set the update sequence
/////////////////////////////////////////////////////////////

st_vbar.y = 0 			//Added By Mark Lee 01/29/2013
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.26.2006 By: Liang QingShi
//$<reason> Contract module modification 
of_create_dw()
//---------------------------- APPEON END ----------------------------

powerobject lpo[]
lpo[upperbound(lpo) + 1 ] = dw_1
lpo[upperbound(lpo) + 1 ] = dw_ccc
lpo[upperbound(lpo) + 1 ] = dw_occ
lpo[upperbound(lpo) + 1 ] = dw_contract_dates
lpo[upperbound(lpo) + 1 ] = tab_1.tabpage_1.dw_1   //add custom 2 tabpage -- by jervis 05.11.2011
lpo[upperbound(lpo) + 1 ] = tab_1.tabpage_custom.dw_1
lpo[upperbound(lpo) + 1 ] = TAB_1.tabpage_notes.dw_1
lpo[upperbound(lpo) + 1 ] = dw_products
lpo[upperbound(lpo) + 1 ] = tab_1.tabpage_group_access.dw_1 //Added by Ken.Guo on 2009-02-10
lpo[upperbound(lpo) + 1 ] = tab_1.tabpage_linkprovider.dw_1//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
this.of_setupdateobjects( lpo)


dw_1.sharedata(dw_contract_dates)
dw_1.sharedata( this.tab_1.tabpage_custom.dw_1)
dw_1.sharedata( this.tab_1.tabpage_notes.dw_1 )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-22 By: Liu Hongxin
//$<reason>: Modify by user Requirement.
dw_ccc.Modify("default_email_t.text = 'Default To'")
dw_occ.Modify("default_email_t.text = 'Default From'")
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-13 By: Scofield
//$<Reason> Add the right to turn on/off the Custom Data, Notes, Audit Trail, Status Track.

ll_CusRight = w_mdi.of_security_access(2091)				//Custom Data
if ll_CusRight = 0 then
	tab_1.tabpage_custom.Visible = false
end if

ll_NotesRight = w_mdi.of_security_access(2092)			//Notes
if ll_NotesRight = 0 then
	tab_1.tabpage_notes.Visible = false
end if

//replace to custom 2 tabpage - jervis 05.11.2011
/*
ll_AuditRight = w_mdi.of_security_access(2093)			//Audit Trail
if ll_AuditRight = 0 then
	tab_1.tabpage_1.Visible = false
end if
*/
ll_AuditRight = w_mdi.of_security_access(2093)			//Custom Data 2
if ll_AuditRight = 0 then
	tab_1.tabpage_1.Visible = false
end if

ll_TrackRight = w_mdi.of_security_access(2094)			//Status Track, Added by Scofield on 2008-06-03
if ll_TrackRight = 0 then
	dw_1.Modify("b_StatusTrack.Visible = 0")
end if

ll_AuditRight = w_mdi.of_security_access(6951)			//Group Access //Added by Ken.Guo on 2009-02-11
if ll_AuditRight = 0 or gnv_data.of_GetItem( "icred_settings", "group_access", False ) = '0' then
	tab_1.tabpage_group_access.Visible = false
//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
else
	tab_1.tabpage_group_access.ii_accessright = ll_AuditRight//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 
//---------End Added ------------------------------------------------------
end if
//---------------------------- APPEON END ----------------------------

//-------------appeon begin----------------------
	//<$>added:long.zhang 04.17.2014
	//<$>reason:v14.2 Provider-Contract direct linking
	if gs_cust_type = "I" or of_get_app_setting("set_9","I") = 0 then	//Linked Providers data
		ll_ProviderRight = w_mdi.of_security_access(7751)
			if ll_ProviderRight = 0 then
				this.tab_1.tabpage_linkprovider.visible = false
			else
				this.tab_1.tabpage_linkprovider.visible = true
				this.tab_1.tabpage_linkprovider.ii_accessright = ll_ProviderRight
			end if
	else
		this.tab_1.tabpage_linkprovider.visible = false
	end if
	//-------------appeon End------------------------


this.event ue_set_tabpage_properties( )	//Jervis 08.17.2010
end event

event ue_selectionchanging;

//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ue_selectionchanging
//
//	Returns:			1 = Error encountered, do not allow tabpage to change
//						0 = Allow tabpage to change
//
//	Description:	Validates the datawindows on this tabpage
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

li_rc = this.of_validation( )

If li_rc = failure Then
	Return 1
else 
	Return 0
end if 
end event

event ue_selectionchanged;call super::ue_selectionchanged;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
    mskinner extend ancestor
********************************************************************************************************************/




//CHOOSE CASE inv_contract_details.is_mode
//	CASE inv_contract_details.new
//		this.of_new( )
//	CASE inv_contract_details.edit
//		
//		THIS.of_retrieve()
//
//END CHOOSE
//
end event

event ue_new;

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: LeiWei
This.Setredraw( False )
//---------------------------- APPEON END ----------------------------

dw_1.reset( )
dw_ccc.reset( )
dw_contract_dates.reset( )
dw_custom.reset( )
dw_occ.reset( )
dw_products.reset()
this.tab_1.tabpage_1.dw_1.reset( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.08.2006 By: Liang QingShi
//$<reason> Contract module modification

tab_1.tabpage_custom.dw_1.reset()
tab_1.tabpage_notes.dw_1.reset()

tab_1.tabpage_group_access.dw_1.reset() 
tab_1.tabpage_group_access.il_ctx_id = 0 //Added by Ken 2011-08-26

//-------------appeon begin----------------------
//<$>added:long.zhang 04.24.2014
//<$>reason:v14.2 Provider-Contract direct linking
tab_1.tabpage_linkprovider.dw_1.reset( )
tab_1.tabpage_linkprovider.il_ctx_id = 0
//-------------appeon End------------------------

dw_products.event ue_populatedddws( )
dw_products.event pfc_addrow()
dw_products.SetColumn('product_type')
//---------------------------- APPEON END ----------------------------
dw_1.event ue_populatedddws( )
dw_1.event pfc_insertrow( )		 
//dw_1.insertrow(0 )			//Added By Mark Lee 12/27/2012

//Add custom 2 tabpage -- jervis 05.11.2011
If this.tab_1.ib_created_2 Then //Added By Ken.Guo 05/18/2012
	this.tab_1.tabpage_1.dw_1.event pfc_insertrow()  
	this.tab_1.tabpage_1.dw_1.event ue_populatedddws()
Else
	This.tab_1.ib_NeedRefreshLink = true
	//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
	This.tab_1.ib_NeedRefreshTrail = true		//Added By Mark Lee 03/26/2014	
	//---------End Added ------------------------------------------------------
End If

dw_ccc.event ue_populatedddws( )
dw_occ.event ue_populatedddws( )

iw_parent.FUNCTION DYNAMIC	wf_manage_tabs(false)




//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-05-06 By: Wu ZhiJun
//$<reason> Fix a bug
long			ll_type
//---------Begin Modified by Alfee 09.30.2007-----------------------
If dw_products.GetRow() > 0 THEN ll_type = dw_products.GetItemNumber(dw_products.GetRow(),'product_type')
//ll_type = dw_products.GetItemNumber(dw_products.GetRow(),'product_type')
//---------End Modified ---------------------------------------------
if Not IsNull(ll_type) then
	dw_products.SetItemStatus(dw_products.GetRow(),0,Primary!,NewModified!)
end if
//--------------------------- APPEON END -----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification
if dw_contract_dates.getrow() > 0 then
	dw_contract_dates.setitem(dw_contract_dates.getrow(),'version_number','1.0')
	dw_contract_dates.setitem(dw_contract_dates.getrow(),'version_date',today())
end if
ib_new = true
is_version_number = ''
setnull(il_app_facility_old)
setnull(il_app_facility)
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.21.2006 By: LeiWei
//$<reason> Fix a defect.

//use modify expression - jervis 10.21.2011
dw_contract_dates.Modify("b_effective_date.filename = 'grayflag.bmp'")
dw_contract_dates.Modify(".b_effective_date.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_expriation_date.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_review_date.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_last_revis_date.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_other_date_1.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_term_date.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_other_date_2.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_version_date.filename = 'grayflag.bmp'")
//added by gavins 20120401
dw_contract_dates.Modify("b_custom_date1.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date2.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date3.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date4.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date5.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date6.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date7.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date8.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date9.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date10.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date11.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date12.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date13.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date14.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date15.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date16.filename = 'grayflag.bmp'")
dw_contract_dates.Modify("b_custom_date17.filename = 'grayflag.bmp'")

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: LeiWei
//$<reason> Fix a defect.

This.of_set_default_value( dw_contract_dates )
This.of_set_default_value( this.tab_1.tabpage_custom.dw_1 )
This.of_set_default_value( this.tab_1.tabpage_notes.dw_1 )

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: LeiWei
This.Setredraw( True )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.16.2006 By: Jervis
//$<reason> Set the falg of new record
ib_new_record = true
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.14.2007 By: Jack (Contract)
//$<reason> fix a defect.
dw_1.setitem(dw_1.getrow(),'master_contract_id',0)
dw_1.setitem(dw_1.getrow(),'master_contract_name','')  //add by Jack 03/21/2007
dw_1.SetFocus()
dw_1.SetColumn("category")
il_master_contract_id = 0
is_master_contract_name = ''									 //add by Jack 03/21/2007
il_ctx_id = 0
this.tab_1.tabpage_2.visible = False						 //add by Jack 05/23/2007

//Add by Jack 04/26/2007
inv_contract_details.il_count = 0 

dw_1.modIfy("master_contract_name.protect = 0")
dw_1.modIfy("master_contract_name.background.color = 16777215")

//dw_1.modify("b_contract_search.visible = 1")  //Add by Jack 05/09/2007  modified by gavins 20120524

//Add by Jack 04/30/2007
If isvalid(m_pfe_cst_mdi_menu_contract) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', False)
End If
iw_parent.function dynamic of_set_validation(False) // Add by Jack 05/04/2007

//---------------------------- APPEON END ----------------------------

of_RefreshTab()					//Added by Scofield on 2008-05-13

end event

event ue_set_security;call super::ue_set_security;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Fix a defect.

integer          li_index, li_count 
windowobject     lwo_temp[]
u_dw_contract    lst_temp

lwo_temp[1] = tab_1.tabpage_notes.dw_1
lwo_temp[2] = tab_1.tabpage_custom.dw_1
lwo_temp[3] = tab_1.tabpage_1.dw_1
lwo_temp[4] = tab_1.tabpage_group_access.dw_1 //Added by Ken.Guo on 2009-02-10
lwo_temp[5] = tab_1.tabpage_linkprovider.dw_1//Added by Appeon long.zhang 04.24.2014 (v14.2 Provider-Contract direct linking)

//--------Begin Added by Alfee 09.30.2007---------------
//<$Reason>Add read only control to Contract module
//Get & set read only flag at tab page level
boolean lb_protect 
lb_protect = inv_contract_details.of_get_protect_tabpg()
//--------End Added -------------------------------------

//Set read only flag for each data window in the child tab page
li_count = UpperBound ( lwo_temp[] ) 
FOR li_index = 1 TO li_count 
   lst_temp = lwo_temp[li_index] 
	//--------Begin Modified by Alfee 09.30.2007---------------
	//if inv_contract_details.of_get_protect_columns( ) then 
	if lb_protect then
	//--------End Modified -------------------------------------
		lst_temp.of_disable_columns( ) 
	 else
		lst_temp.of_enable_columns( )
	end if 
NEXT
//---------------------------- APPEON END ----------------------------

//Begin - Added By Ken.Guo 2010-05-31.
//Workaround Sybase PB Bug. Modify column's background color will clear dwc data.
datawindowchild ldwc_1
If dw_1.GetChild('category',ldwc_1) = 1 Then
	If ldwc_1.RowCount() <= 1 and AppeonGetClientType() = 'PB' Then
		dw_1.ib_retrieve_drop_downs = False
		dw_1.event ue_populatedddws( )
	End If
End If
//End - Added By Ken.Guo 2010-05-31.
end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.16.2006 By: Jervis
//$<reason> modify for work flow

//trigger work flow by New Contract Logix contract tracking
if ib_new_record then
	of_create_action_item_by_workflow()
	
	If isvalid( gw_contract ) Then//added by gavins 20130522
//		gnv_app.inv_dwcache.of_refresh( )
		//Begin - Added By Mark Lee 06/07/2013 refresh the ctx_id for new contract id in the dddw.
		gnv_app.inv_dwcache.of_Refresh("d_dddw_ctx_ids" )
		//End - Added By Mark Lee 06/07/2013
		gw_Contract.tab_contract_details.tabpage_search.dw_search.ib_retrieve_drop_downs = false
		gw_Contract.tab_contract_details.tabpage_search.dw_search.Event ue_populatedddws( )		

	End If	

end if

//--------------------------- APPEON BEGIN ---------------------------
//Movo to u_tab_contract_details.pfc_postupdate() -- jervis 09.17.2010
/*
//$<add> 17/05/2007 By: Jervis
//$<reason> Trigger work flow by Contract Logix data value comparision
long ll_screen_id[]
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	
	//Modify By Jervis 01.12.2009
	//move to pfc_updatepre event
	/*
	ll_screen_id[1] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_master'"))
	ll_screen_id[2] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_contract_dates' and dataobject='d_contract_det_master_2'"))
	ll_screen_id[3] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_notes'"))
	ll_screen_id[4] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_custom'"))
	ll_screen_id[5] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_products' and dataobject='d_ctx_products'"))
	ll_screen_id[6] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_occ' and dataobject='d_contract_det_contact_external'"))
	ll_screen_id[7] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_ccc' and dataobject='d_contract_det_contact_external'"))
	lnv_workflow.of_data_value_comparision( ll_screen_id, inv_contract_details.of_get_ctx_id(), 0, '03', 'I')
	*/
	lnv_workflow.of_data_value_comparision(gi_contract_view_id, il_screen_id, is_UpdateCol,inv_contract_details.of_get_ctx_id(), 0, '03', 'I')
	Destroy lnv_workflow
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2009-01-14 By: Scofield
	//$<Reason> Reset ib_retrieved variable to refresh action items
	
	if IsValid(w_contract) then
		if IsValid(w_contract.tab_contract_details) then
			if IsValid(w_contract.tab_contract_details.tabpage_action_items) then
				w_contract.tab_contract_details.tabpage_action_items.ib_retrieved = false
			end if
		end if
	end if
	//---------------------------- APPEON END ----------------------------
End If
//---------------------------- APPEON END ----------------------------
*/
If is_Refresh_Alarm = '1' Then //added by gavins 20121227
	gnv_appeondb.of_startqueue( )
	gnv_data.of_retrieve( "ctx_notification" )
	gnv_data.of_retrieve( "ctx_ai_notification")
	gnv_data.of_retrieve( "ctx_am_ai_notification")
	gnv_appeondb.of_commitqueue( )
	//------End Modified -----------------------------------
	of_set_flags()
	is_Refresh_Alarm = ''
	
End If
If IsValid( tab_1.tabpage_1 ) Then
	If is_Refresh_Alarm <> '1' Then
		tab_1.tabpage_1.ib_update = true
	End If	
End If

//Clear new record falg
ib_new_record = false

//Added By Ken.Guo 2011-06-14.  
If isvalid(m_pfe_cst_mdi_menu_contract) Then
	If w_mdi.of_security_access( 6989 ) = 1 Then //Added By Ken.Guo 04/17/2013
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx,'enabled', True)
	End If
End If 

return NO_ACTION
//---------------------------- APPEON END ----------------------------

end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(inv_cst_notification) then Destroy inv_cst_notification
//---------------------------- APPEON END ----------------------------
end event

event ue_initinstancevar;call super::ue_initinstancevar;ib_just_saved = false
is_version_number = ""
is_dw = 'Our Company'
il_contact_id = 0
il_app_facility = 0
il_app_facility_old = 0
il_term_reason = 0
ib_new = false
ib_new_record = false
il_master_contract_id = 0
il_ctx_id = 0
is_master_contract_name = ""
end event

event pfc_updateprep;call super::pfc_updateprep;//add By Jervis 01.12.2009
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	il_screen_id[1] = 3 // long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_master'"))
	is_UpdateCol[il_screen_id[1]] = lnv_workflow.of_getupdatecol(  dw_1)
	il_screen_id[2] = 5 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_contract_dates' and dataobject='d_contract_det_master_2'"))
	is_UpdateCol[il_screen_id[2]] = lnv_workflow.of_getupdatecol( dw_contract_dates)
	il_screen_id[3] = 9 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_notes'"))
	// 8 -> 9  9 -> 8 modify by gavins 20130218
	is_UpdateCol[il_screen_id[3]] = lnv_workflow.of_getupdatecol(tab_1.tabpage_custom.dw_1  )
	il_screen_id[4] = 8 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_custom'"))
	is_UpdateCol[il_screen_id[4]] = lnv_workflow.of_getupdatecol( tab_1.tabpage_notes.dw_1 )
	il_screen_id[5] = 4 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_products' and dataobject='d_ctx_products'"))
	is_UpdateCol[il_screen_id[5]] = lnv_workflow.of_getupdatecol( dw_products)
	il_screen_id[6] = 7 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_occ' and dataobject='d_contract_det_contact_external'"))
	is_UpdateCol[il_screen_id[6]] = lnv_workflow.of_getupdatecol( dw_occ)
	il_screen_id[7] = 6 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_ccc' and dataobject='d_contract_det_contact_external'"))
	is_UpdateCol[il_screen_id[7]] = lnv_workflow.of_getupdatecol( dw_ccc)
	//Begin - Added By Mark Lee 08/31/12	                 'tab_1.tabpage_1.dw_1'        	'Custom Data 2'                                                                                                        
	il_screen_id[8] = 10 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_contact_external'"))
	is_UpdateCol[il_screen_id[8]] = lnv_workflow.of_getupdatecol( tab_1.tabpage_1.dw_1)
	//End - Added By Mark Lee 08/31/12
	destroy lnv_workflow
end if

return 1
end event

event resize;call super::resize;IF  this.vscrollbar = True  then
//	gnv_debug.of_output( true, 'this.y'+string(this.y)+ "hhhh.vbar=" + string(st_vbar.y))
	send(handle(this),277,6,0)
	send(handle(this),277,8,0)
	st_vbar.y = 0
	of_adjust_position(false)	  //need it 
End IF 

end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail1
integer x = 9
integer y = 2092
integer width = 3643
integer height = 64
end type

type dw_occ from u_dw_contract within u_tabpg_contract_detail1
event ue_mail_appeon ( string as_1,  string as2,  string as3 )
event type integer pfc_contract_detail ( )
event type integer pfc_contract_email ( )
event ue_set_forbid_validate ( boolean ab_value )
string tag = "Our Company Contact Info"
integer x = 1070
integer y = 916
integer width = 2789
integer height = 404
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Our Company Contact Info"
boolean hscrollbar = true
string dataobject_original = "d_contract_det_contact_external"
boolean ib_allow_sort = true
end type

event type integer pfc_contract_detail();/******************************************************************************************************************
**  [PUBLIC]   : pfc_contract_detail
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Create a aduit trail record.
**==================================================================================================================
**  Created By	: Davis 01.04.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if of_check_read_only( ) then return success

of_open_contact( this,'INTERNAL', TRUE )

RETURN SUccess

end event

event type integer pfc_contract_email();//====================================================================
// Event: pfc_contract_email()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_CurRow
String	ls_Email

str_ctx_email lstr_ctx_email

if of_check_read_only( ) then return SUCCESS

lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
lstr_ctx_email.doc_from = 'CTX'

ll_CurRow = This.GetRow()
if ll_CurRow > 0 and ll_CurRow <= This.RowCount() then
	lstr_ctx_email.EmailTo = This.GetItemString(ll_CurRow,"contact_email")
end if

OpenWithParm(w_dm_email_document_send,lstr_ctx_email)

RETURN SUCCESS

end event

event ue_set_forbid_validate(boolean ab_value);post of_set_forbid_validate( ab_value )
end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.24.2006 By: Rodger Wu
//$<reason> Fix a defect.
This.of_getparentwindow( iw_parent )
//---------------------------- APPEON END ----------------------------

this.of_settransobject( sqlca)
of_SetRowSelect(TRUE)
this.of_setrowmanager( true)
this.inv_rowmanager.of_setconfirmondelete( true)
this.inv_rowmanager.of_setrestorerow( true)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: Liang QingShi
//$<reason> Fix a defect.
of_allow_sort()

//---------------------------- APPEON END ----------------------------


end event

event doubleclicked;call super::doubleclicked;/******************************************************************************************************************
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

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.29.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if not f_validstr( string(inv_contract_details.of_get_ctx_id( ))) or inv_contract_details.of_get_ctx_id( ) = 0 then 
	//messagebox(iw_parent.title, 'The current contact has not been saved. Please save it before continuing.')
	//return failure
	ib_just_saved = true 
	iw_parent.event dynamic ue_save()
	
	
end if

SETPOINTER(HOURGLASS!)
// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 

of_open_contact( this,'INTERNAL' )
*/

//This.event pfc_addrow( )
This.event pfc_contract_detail( )

//---------------------------- APPEON END ----------------------------

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ?1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
boolean		lb_frame
boolean		lb_desired
boolean		lb_readonly
boolean		lb_editstyleattrib
integer		li_tabsequence
long			ll_getrow,ll_Right
string		ls_editstyle
string		ls_val
string		ls_protect
string		ls_colname
string		ls_currcolname
string		ls_type
string		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(2090)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = MDI! or lw_frame.windowtype = MDIHelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = Child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = Child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 1
end if

// Create popup menu
lm_dw = create m_dw
lm_dw.of_SetParent (this)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = this.GetRow()

//ls_val = this.Object.DataWindow.ReadOnly
//lb_readonly = lnv_conversion.of_Boolean (ls_val)


lm_dw.m_table.m_insert.visible = FALSE
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', true)

gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', TRUE)
lm_dw.m_table.m_addrow.visible = TRUE
lm_dw.m_table.M_mailaspdf.Visible = FALSE
lm_dw.m_table.M_saveaspdf.Visible = FALSE
lm_dw.m_table.M_cut.Visible = FALSE
lm_dw.m_table.M_copy.Visible = FALSE
lm_dw.m_table.M_paste.Visible = FALSE
lm_dw.m_table.M_Selectall.Visible = FALSE
lm_dw.m_table.m_Dash11.Visible = FALSE					//Added by Scofield on 2008-12-31

//BEGIN---Modify by Scofield on 2009-04-23
lm_dw.m_table.m_email.Visible = TRUE

if This.RowCount() > 0 then
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_email,'Enabled', TRUE)
else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_email,'Enabled', FALSE)
end if
//END---Modify by Scofield on 2009-04-23

IF ll_getrow > 0 THEN
	lm_dw.m_table.m_contractdetail.visible = TRUE
END IF

// Get column properties
ls_currcolname = this.GetColumnName()
if ls_type = "column" then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	if not IsNumber(ls_protect) then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = this.Describe(ls_expression)
	end if
	ls_val = dwo.TabSequence
	if IsNumber (ls_val) then
		li_tabsequence = Integer (ls_val)
	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', false)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', false)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', false)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', false)

// Get the column/editystyle specific editable flag.
if ls_type = "column" and not lb_readonly then
	choose case ls_editstyle
		case "edit"
			ls_val = dwo.Edit.DisplayOnly
		case "editmask"
			ls_val = dwo.EditMask.Readonly
		case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		case else
			ls_val = ""
	end choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	if IsNull(lb_editstyleattrib) then lb_editstyleattrib = false
end if

if ls_type = "column" and not lb_readonly then
	if dwo.BitmapName = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
		
		if Len (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
			// Copy
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', true)

			// Cut
			if li_tabsequence > 0 and ls_protect = "0" then
				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', lb_desired)
			end if
		end if
			
		if li_tabsequence > 0 and ls_protect = "0" then
			// Paste
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-01
			//$<modify> 01.13.2006 By: Ye KaiChun
			//$<reason> The ClipBoard function of DataWindow is currently unsupported. 
			//$<reason> Define a global function named gf_clipboard to replace it.	   	
			
			//if Len (ClipBoard()) > 0 then
			if Len (gf_ClipBoard('',0)) > 0 then
				
			//---------------------------- APPEON END ----------------------------	
				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', lb_desired)
			end if

			// Select All
			if Len (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
				choose case ls_editstyle
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib						
					case else
						lb_desired = true
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', lb_desired)				
			end if
		end if

	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
if IsValid (inv_RowManager) then
	// Undelete capability
	if inv_RowManager.of_IsRestoreRow() then
		lm_dw.m_table.m_restorerow.Visible = true
		if this.DeletedCount() > 0 and not lb_readonly then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', true)
		else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', false)
		end if
	end if
else
	lm_dw.m_table.m_restorerow.Visible = false
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', false)
end if

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = false
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', false)
lm_dw.m_table.m_values.Visible = false
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', false)
lm_dw.m_table.m_dash12.Visible = false

if IsValid (inv_QueryMode) then
	if inv_QueryMode.of_GetEnabled() then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = false
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', false)		

		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = true
		lm_dw.m_table.m_operators.Visible = true
		lm_dw.m_table.m_dash12.Visible = true

		if ls_type = "column" and not lb_readonly then
			if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
				if li_tabsequence > 0 and ls_protect = "0" then				
					lb_desired = false
					choose case ls_editstyle
						case "edit", "editmask"
							lb_desired = not lb_editstyleattrib
						case "ddlb", "dddw"
							lb_desired = lb_editstyleattrib
					end choose
					// Enablement based on column				
					gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', lb_desired)
					gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', lb_desired)
				end if
			end if
		end if
	end if
end if

// DataWindow property entries. (isolate calls to shared variable)
this.event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
this.event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
if IsValid (inv_RowSelect) then inv_RowSelect.event pfc_rbuttonup (xpos, ypos, row, dwo)

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

destroy lm_dw

return 1
end event

event pfc_addrow;/******************************************************************************************************************
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

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Performance tuning
/*
if not f_validstr( string(inv_contract_details.of_get_ctx_id( ))) or inv_contract_details.of_get_ctx_id( ) = 0 then 
	//messagebox(iw_parent.title, 'The current contact has not been saved. Please save it before continuing.')
	//return failure
	ib_just_saved = true 
	iw_parent.event dynamic ue_save()	
end if
*/
//---------------------------- APPEON END ----------------------------

SETPOINTER(HOURGLASS!)
// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 

of_open_contact( this,'INTERNAL' )

RETURN SUccess
end event

event pfc_retrieve;call super::pfc_retrieve;




this.retrieve(inv_contract_details.of_get_ctx_id( )  ,'I')

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

long ll_i, 	ll_ctx_id

accepttext()			//Added By Mark Lee 06/11/2013

for ll_i = 1 to this.rowcount( )
	ll_ctx_id  = this.object.ctx_id[ll_i]			//Added By Mark Lee 06/11/2013
	if not f_validstr(string(ll_ctx_id)) then
		this.object.ic_area[ll_i] = 'I'
		this.object.ctx_id[ll_i] =  DW_1.object.ctx_id[1]
	end if 
next

return success

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;

return PREVENT_ACTION
end event

event ue_keydown;//call super::ue_keydown;



IF  KeyDown(KeyControl!) and KeyDown(65) theN
   of_open_contact( this,'EXTERNAL' )
	RETURN
end if


IF  KeyDown(KeyControl!) and KeyDown(68) then
   event pfc_deleterow( )
	RETURN
end if

// NEW 
IF  KeyDown(KeyControl!) and KeyDown(78) then
	IW_parent.EVENT DYNAMIC UE_NEW()
   RETURN
end if
end event

event itemchanged;call super::itemchanged;long 		ll_i
Long 	li_ConId
String	ls_UserId

choose case dwo.name
	case 'default_email'
		of_setDefaultEmail( dwo.name, this, data, row)
	case 'ctx_contract_contacts_owner'
		if data = 'Y' then 
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 	01-27-2007 By: Allen
			//$<reason> Expression in Protect property move here.
			//$<Modify> 05-23-2007 By: Scofield
			li_ConId = This.GetItemNumber(Row, 'contact_id')
	 	   SELECT "ctx_contacts"."user_d"  
			  INTO :ls_UserId  
			  FROM "ctx_contacts"  
			 WHERE "ctx_contacts"."contact_id" = :li_ConId ;

			if Not f_validstr(ls_UserId) then
				MessageBox(iw_parent.title, "There is no User ID associated with this contact, so this user can't be assigned as an owner or have access rights. "+&
													"~r~n~r~nPlease open the Contact window and assign a User ID for this contact. ")
				This.Post SetItem(row,'ctx_contract_contacts_owner','N')
				Return 2
			end if
			//---------------------------- APPEON END ----------------------------
			for ll_i = 1 to rowcount()
				If ll_i = Row Then Continue //Added By Ken.Guo 07/03/2012
				object.ctx_contract_contacts_owner[ll_i] = 'N'
			next	
			
			//object.ctx_contract_contacts_owner[row] = 'Y' //Commented By Ken.Guo 07/03/2012
		
		end if 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01-27-2007 By: Allen
	//$<reason> 
	case 'access'
//Commented By Ken.Guo 07/03/2012. Need not check.
//		if Not f_validstr( GetItemString(Row, 'user_d')) then
//			MessageBox(iw_parent.title, &
//				"There is no login id associated with this contact, so this user can't be assigned as an owner or have access rights.")
//			Return 2
//		end if
	//---------------------------- APPEON END ----------------------------
end choose 
end event

event pfc_validation;call super::pfc_validation;long		ll_Cycle,ll_RowCnts,ll_RtnVal
boolean	lb_Owner_id,lb_default_email

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.19.2007 By: Jack
//$<reason> Fix a defect.
if IsValid(m_pfe_cst_mdi_menu_contract) then
	if m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = False then
		if ib_new then
			iw_parent.Function Dynamic wf_set_select("tabpage_search",False)
			ib_new = False
		end if
		Return SUCCESS
	end if
else
	if ib_new then	Return SUCCESS	
end if
//---------------------------- APPEON END ----------------------------

if dw_1.RowCount( ) < 1 then Return SUCCESS

if ib_just_saved then Return SUCCESS

////////////////////////////////////////////////////////////////////
// if the contact does not exis as of yet do not warn the user
////////////////////////////////////////////////////////////////////
if Not f_validstr( string(inv_contract_details.of_get_ctx_id( ))) then 
	Return SUCCESS
end if

//BEGIN---Modify by Scofield on 2010-04-23
ll_RowCnts = This.RowCount()
if ll_RowCnts <= 0 then
	ll_RtnVal = MessageBox(iw_parent.Title,"Before you can save you need at least 1 Our Company Contact record.~r~n~r~nWould you like to add now?",Question!,YesNo!)
	if ll_RtnVal <> 1 then
		iw_parent.Function Dynamic Of_Set_Validation(True)
		Return FAILURE
	else
		if Of_Check_Read_Only() then
			iw_parent.Function Dynamic Of_Set_Validation(True)
			Return FAILURE
		end if
		
		Of_Open_Contact(This,"INTERNAL",True)
		
		ll_RowCnts = This.RowCount()
		if ll_RowCnts = 1 then
			if This.GetItemString(ll_RowCnts,"ctx_contract_contacts_owner") <> "Y" Then
				If This.GetItemString(ll_RowCnts,"user_d") = '' or Isnull(This.GetItemString(ll_RowCnts,"user_d"))   then //Added By Ken.Guo 07/03/2012
					Return FAILURE
				Else
					This.SetItem(ll_RowCnts,"ctx_contract_contacts_owner","Y")
				End If
			end if
			
			if This.GetItemString(ll_RowCnts,"default_email") <> "Y" then
				If This.GetItemString(ll_RowCnts,"contact_email") = '' or isnull(This.GetItemString(ll_RowCnts,"contact_email")) Then //Added By Ken.Guo 07/03/2012
					Return FAILURE
				Else
					This.SetItem(ll_RowCnts,"default_email","Y")
				End If
			end if
		else
			iw_parent.Function Dynamic Of_Set_Validation(True)
			Return FAILURE
		end if
	end if
else
	for ll_Cycle = 1 to ll_RowCnts
		if this.GetItemString(ll_Cycle,"ctx_contract_contacts_owner") = "Y" then 
			lb_Owner_id = true
		end if
		
		if this.GetItemString(ll_Cycle,"default_email") = "Y" then
			lb_default_email = true
		end if
	next
	If ib_forbidvalidate  And (Not lb_Owner_id or Not lb_default_email  ) Then
		ib_forbidvalidate = false
		RETURN FAILURE //added by gavins 20130409
	End If
	If ib_forbidvalidate Then Return SUCCESS
	if (Not lb_Owner_id or Not lb_default_email  )  then 
		if Not lb_Owner_id then
			MessageBox(iw_Parent.Title,"Before you can save you need to set one of the Our Company Contacts as the Contract Owner.~r~n~r~nTo set the Contract Owner, highlight one of the Our Company Contact records and select Yes from the Owner drop down.")
		elseif Not lb_default_email then
			MessageBox(iw_Parent.Title,"Before you can save you need one of the Our Company Contacts to be set as the Default From contact.~r~n~r~nTo set the Default From Contact, highlight one of the Our Company Contact records and click on the Default From checkbox.")
		end if
		
		iw_parent.Function Dynamic Of_Set_Validation(True)
		Return FAILURE
	end if
end if
//END---Modify by Scofield on 2010-04-23

//---------------------------- APPEON END ----------------------------

Return SUCCESS

end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.24.2006 By: Liang QingShi
//$<reason> Contract module modification
if this.rowcount() > 0 then
	il_contact_id = this.getitemnumber(this.getrow(),'contact_id')
	is_dw = 'Our Company'
	
	// Added by Davis 01.24.2007
	IF w_mdi.menuname = 'm_pfe_cst_mdi_menu_contract' THEN
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_contactdetail,'Enabled', TRUE)
	END IF
end if
//---------------------------- APPEON END ----------------------------

end event

event ue_mail;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Liu Hongxin
//$<reason> Modify eMail functionality, override ancestor script.
of_send_email(this)
//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 17/05/2007 By: Jervis
//$<reason> Move to u_tabpg_contract_detail1.pfc_postupdate event
/*
//Added for Work Flow trigger. 11.21.2006 Henry
//long	 ll_screen_id  
long	 ll_screen_id[1]	//12.13.2006 By Jervis  
long	 ll_ctx_id

ll_ctx_id = this.getitemnumber( this.GetRow(), "ctx_id")
if not ll_ctx_id > 0 Then RETURN success


ll_screen_id[1] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_occ' and dataobject='d_contract_det_contact_external'"))
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_ctx_id, 0, '03', 'I')
	Destroy lnv_workflow
End If
//End added 11.21.2006
*/
//---------------------------- APPEON END ----------------------------

ib_forbidvalidate = false

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.27.2006 By: Jervis
//$<reason> Fix a defect
RETURN success
//---------------------------- APPEON END ----------------------------
end event

event losefocus;call super::losefocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Davis
//$<reason> Make disabled if no contact selected.
IF w_mdi.menuname = 'm_pfe_cst_mdi_menu_contract' THEN
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_contactdetail,'Enabled', FALSE)
END IF
//---------------------------- APPEON END ----------------------------

end event

event pfc_deleterow;call super::pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.06.2007 By: Jack
//$<reason> Fix a defect.
of_enable_save()
Return 1
//---------------------------- APPEON END ----------------------------

end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item enabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
end if
dw_ccc.Selectrow( 0,false)  //jervis 09.02.2011
end event

event retrieveend;call super::retrieveend;this.Selectrow( 0,false)  //jervis 09.01.2011
end event

type dw_ccc from u_dw_contract within u_tabpg_contract_detail1
event type integer pfc_contract_detail ( )
event type integer pfc_contract_email ( )
string tag = "Contracted Company Contact Info"
integer x = 1070
integer y = 492
integer width = 2789
integer height = 404
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Contracted Company Contact Info"
boolean hscrollbar = true
string dataobject_original = "d_contract_det_contact_external"
boolean ib_allow_sort = true
end type

event type integer pfc_contract_detail();/******************************************************************************************************************
**  [PUBLIC]   : pfc_contract_detail
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Create a aduit trail record.
**==================================================================================================================
**  Created By	: Davis 01.04.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if of_check_read_only( ) then return success

of_open_contact( this,'EXTERNAL', TRUE )

RETURN SUccess

end event

event type integer pfc_contract_email();//====================================================================
// Event: pfc_contract_email()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_CurRow
String	ls_Email

str_ctx_email lstr_ctx_email

if of_check_read_only( ) then return SUCCESS

lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
lstr_ctx_email.doc_from = 'CTX'

ll_CurRow = This.GetRow()
if ll_CurRow > 0 and ll_CurRow <= This.RowCount() then
	lstr_ctx_email.EmailTo = This.GetItemString(ll_CurRow,"contact_email")
end if

OpenWithParm(w_dm_email_document_send,lstr_ctx_email)

RETURN SUCCESS

end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: Lei Wei
//$<reason> Fix a defect.
This.of_getparentwindow( iw_parent )
//---------------------------- APPEON END ----------------------------

this.of_settransobject( sqlca)
of_SetRowSelect(TRUE)
this.of_setrowmanager( true)
this.inv_rowmanager.of_setconfirmondelete( true)
this.inv_rowmanager.of_setrestorerow( true)
//inv_rowmanager.ib_confirmondelete  = true

//Start Code Change ---- 01.25.2007 #V7 maha
String ls_object
ls_object = this.describe("ctx_contract_contacts_owner.name")
If ls_object <>'!' and ls_object <>'?' Then 
	//Added By Mark Lee 07/10/12
//	this.object.ctx_contract_contacts_owner.Visible  = false
	this.Modify("ctx_contract_contacts_owner.Visible= 0")
End If

ls_object = this.describe("ctx_contract_contacts_owner_t.name")
If ls_object <>'!' and ls_object <>'?' Then 
	//Added By Mark Lee 07/10/12
//	this.object.ctx_contract_contacts_owner_t.Visible  = false
	this.Modify("ctx_contract_contacts_owner_t.Visible= 0")
End If

ls_object = this.describe("access.name")
If ls_object <>'!' and ls_object <>'?' Then 
	//Added By Mark Lee 07/10/12
//	this.object.access.Visible  = false
	this.Modify("access.Visible= 0")
End If

ls_object = this.describe("access_t.name")
If ls_object <>'!' and ls_object <>'?' Then 
	//Added By Mark Lee 07/10/12
//	this.object.access_t.Visible  = false
	this.Modify("access_t.Visible= 0")
End If
//End Code Change---01.25.2007
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: Liang QingShi
//$<reason> Fix a defect.
of_allow_sort()

//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;call super::doubleclicked;/******************************************************************************************************************
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


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.29.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if not f_validstr( string(inv_contract_details.of_get_ctx_id( ))) or inv_contract_details.of_get_ctx_id( ) = 0 then 
	messagebox(iw_parent.title, 'The current contact has not been saved. Please save it before continuing.')
	return failure
end if

SETPOINTER(HOURGLASS!)
// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 
of_open_contact( this,'EXTERNAL' )
*/

//This.event pfc_addrow( )
This.event pfc_contract_detail( )
//---------------------------- APPEON END ----------------------------

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ?1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
boolean		lb_frame
boolean		lb_desired
boolean		lb_readonly
boolean		lb_editstyleattrib
integer		li_tabsequence
long			ll_getrow,ll_Right
string		ls_editstyle
string		ls_val
string		ls_protect
string		ls_colname
string		ls_currcolname
string		ls_type
string		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(2090)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = MDI! or lw_frame.windowtype = MDIHelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = Child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = Child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 1
end if

// Create popup menu
lm_dw = create m_dw
lm_dw.of_SetParent (this)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = this.GetRow()

ls_val = this.Object.DataWindow.ReadOnly
lb_readonly = lnv_conversion.of_Boolean (ls_val)


lm_dw.m_table.m_insert.visible = FALSE
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', true)

gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', TRUE)
lm_dw.m_table.m_addrow.visible = TRUE
lm_dw.m_table.M_mailaspdf.Visible = FALSE
lm_dw.m_table.M_saveaspdf.Visible = FALSE
lm_dw.m_table.M_cut.Visible = FALSE
lm_dw.m_table.M_copy.Visible = FALSE
lm_dw.m_table.M_paste.Visible = FALSE
lm_dw.m_table.M_Selectall.Visible = FALSE
lm_dw.m_table.m_Dash11.Visible = FALSE					//Added by Scofield on 2008-12-31

//BEGIN---Modify by Scofield on 2009-04-23
lm_dw.m_table.m_email.Visible = TRUE

if This.RowCount() > 0 then
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_email,'Enabled', TRUE)
else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_email,'Enabled', FALSE)
end if
//END---Modify by Scofield on 2009-04-23

IF ll_getrow > 0 THEN
	lm_dw.m_table.m_contractdetail.visible = TRUE
END IF

// Get column properties
ls_currcolname = this.GetColumnName()
if ls_type = "column" then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	if not IsNumber(ls_protect) then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = this.Describe(ls_expression)
	end if
	ls_val = dwo.TabSequence
	if IsNumber (ls_val) then
		li_tabsequence = Integer (ls_val)
	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', false)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', false)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', false)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', false)

// Get the column/editystyle specific editable flag.
if ls_type = "column" and not lb_readonly then
	choose case ls_editstyle
		case "edit"
			ls_val = dwo.Edit.DisplayOnly
		case "editmask"
			ls_val = dwo.EditMask.Readonly
		case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		case else
			ls_val = ""
	end choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	if IsNull(lb_editstyleattrib) then lb_editstyleattrib = false
end if

if ls_type = "column" and not lb_readonly then
	if dwo.BitmapName = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
		
		if Len (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
			// Copy
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', true)

			// Cut
			if li_tabsequence > 0 and ls_protect = "0" then
				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', lb_desired)
			end if
		end if
			
		if li_tabsequence > 0 and ls_protect = "0" then
			// Paste
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-02
			//$<modify> 03.14.2006 By: LiuHongXin
			//$<reason> The ClipBoard function of DataWindow is currently unsupported. 
			//$<reason> Define a global function named gf_clipboard to replace it.	   	
			/*
			if Len (ClipBoard()) > 0 then
			*/
			if Len (gf_ClipBoard("", 0)) > 0 then
			//---------------------------- APPEON END ----------------------------

				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', lb_desired)
			end if

			// Select All
			if Len (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
				choose case ls_editstyle
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib						
					case else
						lb_desired = true
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', lb_desired)				
			end if
		end if

	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
if IsValid (inv_RowManager) then
	// Undelete capability
	if inv_RowManager.of_IsRestoreRow() then
		lm_dw.m_table.m_restorerow.Visible = true
		if this.DeletedCount() > 0 and not lb_readonly then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', true)
		else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', false)
		end if
	end if
else
	lm_dw.m_table.m_restorerow.Visible = false
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', false)
end if

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = false
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', false)
lm_dw.m_table.m_values.Visible = false
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', false)
lm_dw.m_table.m_dash12.Visible = false

if IsValid (inv_QueryMode) then
	if inv_QueryMode.of_GetEnabled() then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = false
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', false)		

		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = true
		lm_dw.m_table.m_operators.Visible = true
		lm_dw.m_table.m_dash12.Visible = true

		if ls_type = "column" and not lb_readonly then
			if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
				if li_tabsequence > 0 and ls_protect = "0" then				
					lb_desired = false
					choose case ls_editstyle
						case "edit", "editmask"
							lb_desired = not lb_editstyleattrib
						case "ddlb", "dddw"
							lb_desired = lb_editstyleattrib
					end choose
					// Enablement based on column				
					gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', lb_desired)
					gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', lb_desired)
				end if
			end if
		end if
	end if
end if

// DataWindow property entries. (isolate calls to shared variable)
this.event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
this.event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
if IsValid (inv_RowSelect) then inv_RowSelect.event pfc_rbuttonup (xpos, ypos, row, dwo)

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

destroy lm_dw

return 1
end event

event pfc_addrow;/******************************************************************************************************************
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

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.27.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if not f_validstr( string(inv_contract_details.of_get_ctx_id( ))) or inv_contract_details.of_get_ctx_id( ) = 0 then 
	messagebox(iw_parent.title, 'The current contact has not been saved. Please save it before continuing.')
	return failure
end if
*/
//---------------------------- APPEON END ----------------------------


// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 
of_open_contact( this,'EXTERNAL' )


//// mskinner 05 april 2006 -- begin
//if of_check_read_only( ) then return success
//// mskinner 05 april 2006 -- end 
//
//str_pass lstr_pass
//lstr_pass.s_u_dw = this
//lstr_pass.s_string = 'EXTERNAL'
//OpenWithParm ( w_contract_contact, lstr_pass)
//


RETURN SUccess
end event

event pfc_retrieve;call super::pfc_retrieve;


this.retrieve( inv_contract_details.of_get_ctx_id( )  ,'E')

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

long ll_i, ll_ctx_id

this.accepttext()		//Added By Mark Lee 06/11/2013

for ll_i = 1 to this.rowcount( )
	ll_ctx_id = THIS.object.ctx_id[ll_i]		//Added By Mark Lee 06/11/2013
	if not f_validstr(string(ll_ctx_id)) then
		this.object.ic_area[ll_i] = 'E'
		this.object.ctx_id[ll_i] = DW_1.object.ctx_id[1]
	end if 
next

return success

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;

return prevent_action
end event

event ue_keydown;//call super::ue_keydown;




IF  KeyDown(KeyControl!) and KeyDown(65) theN
   of_open_contact( this,'INTERNAL' )
	RETURN
end if


IF  KeyDown(KeyControl!) and KeyDown(68) then
   event pfc_deleterow( )
	RETURN
end if
end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.28.2006 By: LeiWei
//$<reason> Fix a defect. Allow multiple Default To's are selected 
/*
choose case dwo.name
	case 'default_email'
		of_setDefaultEmail( dwo.name, this, data, row)
end choose 
*/
//---------------------------- APPEON END ----------------------------

end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.24.2006 By: Liang QingShi
//$<reason> Contract module modification
if this.rowcount() > 0 then
	il_contact_id = this.getitemnumber(this.getrow(),'contact_id')
	is_dw = 'Contracted Company'
	
	// Added by Davis 01.24.2007
	IF w_mdi.menuname = 'm_pfe_cst_mdi_menu_contract' THEN
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_contactdetail,'Enabled', TRUE)
	END IF

end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_validation;call super::pfc_validation;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: LeiWei
//$<reason> When entering a new contract, require a user to check off
//$<reason> one Our Company Contact as the Default From.

long		ll_Cycle,ll_RowCnts,ll_RtnVal
boolean	lb_default_email
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.19.2007 By: Jack
//$<reason> Fix a defect.
If isvalid(m_pfe_cst_mdi_menu_contract) Then
	If m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = False Then
		If ib_new Then
			iw_parent.function dynamic wf_set_select("tabpage_search",False)
			ib_new = False
		End If
		Return SUCCESS
	End If
else
	If ib_new Then	Return SUCCESS
end if
//---------------------------- APPEON END ----------------------------

if dw_1.RowCount() < 1 then Return SUCCESS

if ib_just_saved THEN Return SUCCESS

if Not f_validstr( string(inv_contract_details.of_get_ctx_id( ))) then 
	Return SUCCESS
end if

ll_RowCnts = This.RowCount()
if ll_RowCnts <= 0 then
	ll_RtnVal = MessageBox(iw_parent.Title,"Before you can save you need at least 1 Contracted Company Contact record.~r~n~r~nWould you like to add now?",Question!,YesNo!)
	if ll_RtnVal <> 1 then
		iw_parent.Function Dynamic Of_Set_Validation(True)
		Return FAILURE
	else
		//BEGIN---Modify by Scofield on 2010-04-16
		if Of_Check_Read_Only() then
			iw_parent.Function Dynamic Of_Set_Validation(True)
			Return FAILURE
		end if
		
		Of_Open_Contact(This,"EXTERNAL",True)
		
		ll_RowCnts = This.RowCount()
		if ll_RowCnts = 1 then
			if This.GetItemString(ll_RowCnts,"default_email") <> "Y" then
				This.SetItem(ll_RowCnts,"default_email","Y")
			end if
		else
			iw_parent.Function Dynamic Of_Set_Validation(True)
			Return FAILURE
		end if
		//END---Modify by Scofield on 2010-04-16
	end if
else
	for ll_Cycle = 1 to ll_RowCnts
		if This.GetItemString(ll_Cycle,"default_email") = "Y" then
			lb_default_email = true
			Exit
		end if
	next
	If ib_forbidvalidate  And Not lb_default_email Then 
		ib_forbidvalidate = false
		RETURN FAILURE //added by gavins 20130409
	End If
	If ib_forbidvalidate Then Return SUCCESS
	if Not lb_default_email  then
		ll_RtnVal = MessageBox(iw_parent.Title,"Before you can save you need one of the Contracted Company Contacts to be set as the Default To contact.~r~n~r~nTo set the Default To Contact, highlight one of the Contracted Company Contact records and click on the Default To checkbox.")
		iw_parent.Function Dynamic Of_Set_Validation(True)
		Return FAILURE
	end if
end if

Return SUCCESS

//---------------------------- APPEON END ----------------------------

end event

event ue_mail;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Liu Hongxin
//$<reason> Modify eMail functionality, override ancestor script.
of_send_email(this)
//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 17/05/2007 By: Jervis
//$<reason> move to u_tabpg_cntract_detail1.pfc_postupdate event
/*
//Added for Work Flow trigger. 11.21.2006 Henry
//long	 ll_screen_id
long	 ll_screen_id[]  //12.13.2006 By Jervis
long	 ll_ctx_id

ll_ctx_id = this.getitemnumber( this.GetRow(), "ctx_id")
if not ll_ctx_id > 0 Then RETURN success

ll_screen_id[1] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_ccc' and dataobject='d_contract_det_contact_external'"))
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_ctx_id, 0, '03', 'I')
	Destroy lnv_workflow
End If
//End added 11.21.2006
*/
//---------------------------- APPEON END ----------------------------

ib_forbidvalidate = false

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.27.2006 By: Jervis
//$<reason> Fix a defect
RETURN success
//---------------------------- APPEON END ----------------------------
end event

event losefocus;call super::losefocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Davis
//$<reason> Make disabled if no contact selected.
IF w_mdi.menuname = 'm_pfe_cst_mdi_menu_contract' THEN
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_contactdetail,'Enabled', FALSE)
END IF
//---------------------------- APPEON END ----------------------------


end event

event pfc_deleterow;call super::pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.06.2007 By: Jack
//$<reason> Fix a defect.
of_enable_save()
Return 1
//---------------------------- APPEON END ----------------------------

end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item enabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
end if
dw_occ.Selectrow( 0,false)  //jervis 09.02.2011
end event

event retrieveend;call super::retrieveend;this.Selectrow( 0,false)  //jervis 09.01.2011
end event

type dw_custom from u_dw_contract within u_tabpg_contract_detail1
string tag = "Custom Data"
boolean visible = false
integer x = 3950
integer y = 704
integer width = 2798
integer height = 580
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Custom Data"
string dataobject = "d_contract_det_custom"
boolean maxbox = true
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
string dataobject_original = "d_contract_det_custom"
end type

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
**  [PUBLIC]   : dw_custom
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_ret
long ll_i

if rowcount() < 1 then return success

//if isnull( dw_1.object.ctx_id[1] ) then
//	inv_contract_details.of_set_ctx_id(of_get_next_seq_number( ))
//   this.setItem(1,'ctx_id',inv_contract_details.of_get_ctx_id( ) )
//	dw_1.object.ctx_id[1] = inv_contract_details.of_get_ctx_id( )
//end if
//

//for ll_i = 1 to this.rowcount()
//		if isnull(this.object.ctx_id[ll_i])    then 
//			object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )
//		end if
//next
//


//ib_isupdateable = false

//THIS.ShareDataoff()

return success








end event

event ue_keydown;//call super::ue_keydown;

// NEW 
IF  KeyDown(KeyControl!) and KeyDown(78) then
	IW_parent.EVENT DYNAMIC UE_NEW()
   RETURN
end if
end event

event pfc_addrow;


// OVERFIDE

RETURN SUCcess
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;



if this.rowcount( ) = 1 then
	return failure
end if 


return success
end event

event pfc_retrieve;call super::pfc_retrieve;
THIS.RETRieve( inv_contract_details.of_get_ctx_id( ) )

RETURN SUCcess
end event

type tab_1 from u_tabpg_detail_detail within u_tabpg_contract_detail1
integer x = 1070
integer y = 1348
integer width = 2789
integer height = 660
integer taborder = 60
boolean bringtotop = true
end type

event selectionchanged;call super::selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.11.2006 By: LeiWei
//$<reason> Fix a defect.

//IF newindex = 2 THEN
//	This.tabpage_custom.dw_1.of_SetDropDownCalendar(TRUE)
//	This.tabpage_custom.dw_1.event ue_populatedddws( )
//END IF

//---------------------------- APPEON END ----------------------------

if newindex = 1 then 
	dw_1.sharedata( tab_1.tabpage_custom.dw_1 )
elseif newindex = 3 then
	dw_1.sharedata( tab_1.tabpage_notes.dw_1 )
	tab_1.tabpage_notes.of_resizedwobject( )		//Added By Mark Lee 04/26/2013
end if
end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item disabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
end if

end event

event resize;call super::resize;//Begin - Added By Mark Lee 01/31/2013	 This is very important for the dw size's adjust in the tabpage.
//tab_1.tabpage_custom.dw_1.width = newwidth - 10
//End - Added By Mark Lee 01/31/2013


end event

type dw_products from u_dw_contract within u_tabpg_contract_detail1
string tag = "Products"
integer x = 9
integer y = 1660
integer width = 1038
integer height = 348
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Products"
string dataobject_original = "d_ctx_products"
boolean ib_allow_sort = true
end type

event pfc_validation;call super::pfc_validation;long ll_i
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.06.2006 By: Liang QingShi
//$<reason> 
/*
for ll_i = 1 to this.rowcount()
	if not f_validstr(string(this.object.product_id[ll_i])) then 
		 messagebox(iw_parent.title , 'The product name is a requied column' )
		return failure
	end if
	
	if not f_validstr(string(this.object.product_type[ll_i] )) then 
		messagebox(iw_parent.title , 'The product type is a requied column')
		return failure
	end if
next
*/
string ls_title

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.19.2007 By: Jack
//$<reason> Fix a defect.
If isvalid(m_pfe_cst_mdi_menu_contract) Then
	If m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = False Then
		If ib_new Then
			iw_parent.function dynamic wf_set_select('tabpage_search',False) 	
			ib_new = False
		End If
		Return success
	End If
Else
	If ib_new Then	Return success	
End If
//---------------------------- APPEON END ----------------------------

if dw_1.rowcount( ) < 1 then return success

if not f_validstr( string(inv_contract_details.of_get_ctx_id( ))) then 
	return success
end if

if isvalid(iw_parent) then
	ls_title = iw_parent.title
else
	ls_title = 'IntelliContract Product: '  //(Appeon)Harry 03.10.2014 - V142 ISG-CLX modify "Contract Logix" to "IntelliContract"
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<Comment> 2008-05-14 By: Scofield
//$<Reason > Can save when no product is input.

//if this.rowcount( ) < 1 then 
//	messagebox(ls_title,'There is no product assigned to this contract. Please add one before continuing.')
//	this.event pfc_addrow()
//	this.setfocus()
//	this.setcolumn('product_type')	
//	iw_parent.function dynamic of_set_validation(True) // Add by Jack 04/19/2007
//	return failure
//end if

//---------------------------- APPEON END ----------------------------

for ll_i = 1 to this.rowcount()
	//Added By Alan on 2009-1-6 BugJ120104
	if this.getitemstatus(ll_i,0, primary!)=new! then continue
	//end
	if not f_validstr(string(this.object.product_id[ll_i])) then 
		 messagebox(ls_title , 'The product name is a required column' )
		this.setfocus()
		this.setcolumn('product_id')	
		iw_parent.function dynamic of_set_validation(True) // Add by Jack 04/19/2007	
		return failure
	end if
	
	if not f_validstr(string(this.object.product_type[ll_i] )) then 
		messagebox(ls_title , 'The product type is a required column')
		this.setfocus()
		this.setcolumn('product_type')	
		iw_parent.function dynamic of_set_validation(True) // Add by Jack 04/19/2007	
		return failure
	end if
next
	
//---------------------------- APPEON END ----------------------------




return success
end event

event pfc_retrieve;call super::pfc_retrieve;


this.retrieve(inv_contract_details.of_get_ctx_id( ))

return success
end event

event pfc_preupdate;call super::pfc_preupdate;

long ll_i 

for ll_i = 1 to this.rowcount()	
	//Added By Alan on 2008-1-6	BugJ120104
	if (this.getitemstatus(ll_i,"product_type", primary!)=new! or this.getitemstatus(ll_i,"product_type", primary!)=notmodified!) and (this.getitemstatus(ll_i,"product_id", primary!)=new! or this.getitemstatus(ll_i,"product_id", primary!)=notmodified!) then
		this.SetItemStatus(ll_i,0,primary!,notmodified!)
		continue
	end if
	if not f_validstr(string(this.object.ctx_id[ll_i]))  then 
		this.object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )
	end if
 
next 


return success
end event

event itemchanged;call super::itemchanged;
long ll_i

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.12.2006 By: LeiWei
//$<reason> Fix a defect.
/*
choose case dwo.name
	case 'product_id'
		for ll_i = 1 to this.rowcount()
			if ll_i <> row then 
			  if string(this.object.product_id[ll_i]) =  data then 
				   messagebox(iw_parent.title, 'This product already exists.' )
				  return 2
			  end if
			end if 			
		next
end choose
*/

String ls_product_id, ls_product_type
choose case dwo.name
	case 'product_id'
		ls_product_id = data
		ls_product_type = string(this.object.product_type[row])
	case 'product_type'
		ls_product_type = data
		ls_product_id = string(this.object.product_id[row])
end choose

choose case dwo.name
	case 'product_id','product_type'
		for ll_i = 1 to this.rowcount()
			if ll_i <> row then 
			  	IF f_validstr(ls_product_id)  AND f_validstr(ls_product_type) AND f_validstr(string(this.object.product_id[ll_i])) AND f_validstr(string(this.object.product_type[ll_i])) THEN
			  		if string(this.object.product_id[ll_i]) =  ls_product_id AND string(this.object.product_type[ll_i]) = ls_product_type then 
				   	messagebox(iw_parent.title, 'This product already exists.' )
				  		return 2
			 	 	end if
				END IF
			end if 			
		next
end choose
//---------------------------- APPEON END ----------------------------



end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.19.2006 By: Davis
//$<reason> Fix a defect.

IF (Lower(String(dwo.name)) = "product_type" OR Lower(String(dwo.name)) = "product_id") AND row > 0 THEN
	IF This.GetcolumnName( ) <> String(dwo.name) THEN
		This.SetColumn( String(dwo.name) )
	END IF
END IF

//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 17/05/2007 By: Jervis
//$<reason> move to u_tabpg_contract_detail1.pfc_postupdate()
/*
//Added for Work Flow trigger. 11.21.2006 Henry
//long	 ll_screen_id
long	 ll_screen_id[]	//12.13.2006 By Jervis
long	 ll_ctx_id

ll_ctx_id = this.getitemnumber( this.GetRow(), "ctx_id")
if not ll_ctx_id > 0 Then RETURN success

ll_screen_id[1] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_products' and dataobject='d_ctx_products'"))
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_ctx_id, 0, '03', 'I')
	Destroy lnv_workflow
End If
//End added 11.21.2006
*/
//---------------------------- APPEON END ----------------------------

iw_parent.Function Dynamic wf_set_select('tabpage_search', false) //Add by Evan 12/11/2008

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.27.2006 By: Jervis
//$<reason> Fix a defect
RETURN success
//---------------------------- APPEON END ----------------------------
end event

event pfc_addrow;if ib_read_only then Return SUCCESS				//Added by Scofield on 2008-05-30

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.23.2007 By: Jack
//$<reason> Fix a defect.
If dw_1.rowcount( ) < 1 Then 
	return 1
Else
	Super::Event pfc_addrow()
End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-05-09 By: Wu ZhiJun
//$<reason> Fix a bug
long	ll_type,ll_Row

ll_Row = dw_products.GetRow()
if ll_Row > 0 and ll_Row <= dw_products.RowCount() then
	ll_type = dw_products.GetItemNumber(ll_Row,'product_type')
	if Not IsNull(ll_type) then
		dw_products.SetItemStatus(ll_Row,0,Primary!,NewModified!)
	end if
	
	dw_products.SetColumn('product_type')
	of_enable_save()
end if

return success

//--------------------------- APPEON END -----------------------------

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(2090)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// Determine if RMB popup menu should occur
If Not ib_RMBmenu Or IsNull (dwo) Then	Return 1

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2005-09-01 By: Liang QingShi
//$<reason> The BitmapName property of the DataWindow column  is unsupported.

//if ls_type = "column" and not lb_readonly then
//	if dwo.BitmapName = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
//		
//		if Len (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
//			// Copy
//			lm_dw.m_table.m_copy.Enabled = true
//
//			// Cut
//			if li_tabsequence > 0 and ls_protect = "0" then
//				lb_desired = false
//				choose case ls_editstyle
//					case "edit", "editmask"
//						lb_desired = not lb_editstyleattrib
//					case "ddlb", "dddw"
//						lb_desired = lb_editstyleattrib
//				end choose
//				lm_dw.m_table.m_cut.Enabled = lb_desired
//			end if
//		end if
//			
//		if li_tabsequence > 0 and ls_protect = "0" then
//			// Paste
//			if Len (ClipBoard()) > 0 then
//				lb_desired = false
//				choose case ls_editstyle
//					case "edit", "editmask"
//						lb_desired = not lb_editstyleattrib
//					case "ddlb", "dddw"
//						lb_desired = lb_editstyleattrib
//				end choose
//				lm_dw.m_table.m_paste.Enabled = lb_desired
//			end if
//
//			// Select All
//			if Len (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
//				choose case ls_editstyle
//					case "ddlb", "dddw"
//						lb_desired = lb_editstyleattrib						
//					case else
//						lb_desired = true
//				end choose
//				lm_dw.m_table.m_selectall.Enabled = lb_desired				
//			end if
//		end if
//
//	end if
//end if

//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<comment> 2005-09-01 By: Liang QingShi
		//$<reason> The BitmapName property of the DataWindow column  is unsupported.
		
		//		If ls_type = "column" And Not lb_readonly Then
		//			If dwo.bitmapname = "no" And ls_editstyle <> "checkbox" And ls_editstyle <> "radiobuttons" Then
		//				If li_tabsequence > 0 And ls_protect = "0" Then
		//					lb_desired = False
		//					Choose Case ls_editstyle
		//						Case "edit", "editmask"
		//							lb_desired = Not lb_editstyleattrib
		//						Case "ddlb", "dddw"
		//							lb_desired = lb_editstyleattrib
		//					End Choose
		//					// Enablement based on column				
		//					lm_dw.m_table.m_values.Enabled = lb_desired
		//					lm_dw.m_table.m_operators.Enabled = lb_desired
		//				End If
		//			End If
		//		End If
		
		//---------------------------- APPEON END ----------------------------
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1


end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item enabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
end if

end event

type dw_1 from u_dw_contract within u_tabpg_contract_detail1
event ue_upd_company_name ( long al_app_facility )
string tag = "Contract Detail"
integer x = 9
integer y = 16
integer width = 1038
integer height = 1624
integer taborder = 10
boolean titlebar = true
string title = "Contract Detail"
string dataobject = "d_contract_det_master"
boolean livescroll = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
string dataobject_original = "d_contract_det_master"
end type

event ue_upd_company_name(long al_app_facility);//====================================================================
//$<Event>: ue_upd_company_name
//$<Arguments>:
// long		al_app_facility
//$<Return>:  (None)
//$<Description>: When the name of a “Company Name” is changed via the “Details” tab,it is not reflected on the “Details” tab unless the user performs a “File > Login As…”
//$<Author>: (Appeon) Harry 10.09.2016
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

DataWindowChild	ldwc_child
Long	ll_find , ll_row
string	ls_facility_name,ls_facility_name_old


if this.GetChild( "app_facility",ldwc_child) = 1 then
	if ldwc_child.rowcount( ) > 0 then 		
		ll_find = ldwc_child.find( "facility_id = " + string(al_app_facility),1, ldwc_child.rowcount( ) )
		if ll_find > 0 then 
			ls_facility_name_old = ldwc_child.getitemstring(ll_find, 'facility_name')
			ls_facility_name = gnv_data.of_GetItem( "ctx_facility", "facility_name", "facility_id = " + string(al_app_facility))
			if ls_facility_name_old <> ls_facility_name then
				ldwc_child.SetItem( ll_find,"facility_name", ls_facility_name)
			end if
		end if 
	end if 
end if
end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.11.2006 By: LeiWei
//$<reason> Performance tuning.
//insertrow(0)
//---------------------------- APPEON END ----------------------------

This.of_SetDropDownCalendar(TRUE)
end event

event doubleclicked;call super::doubleclicked;/******************************************************************************************************************
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


end event

event retrieveend;call super::retrieveend;
if rowcount < 1 then return success

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.23.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.
il_app_facility_old = dw_1.getitemnumber(dw_1.getrow(),'app_facility')
setnull(il_app_facility)
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.14.2007 By: Jack (Contract)
//$<reason> Fix a defect.
il_master_contract_id = dw_1.getitemnumber(dw_1.getrow(),'master_contract_id')
il_ctx_id = dw_1.getitemnumber(dw_1.getrow(),'ctx_id')
is_master_contract_name = dw_1.getitemstring(dw_1.getrow(),'master_contract_name')  //add by Jack 03/21/2007
//---------------------------- APPEON END ----------------------------

long ll_ret
dwItemStatus l_status

l_status = this.GetItemStatus(1, 0, primary!)


//ll_ret = this.ShareData(dw_custom)
//if ll_ret <> 1 then messagebox('','share data FAILED')

if rowcount > 0 then 
    setcolumn('file_location')
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.11.2006 By: LeiWei
//$<reason> Performance tuning
/*
ll_ret = this.sharedata( tab_1.tabpage_custom.dw_1 )
if ll_ret <> 1 then messagebox('','share data FAILED')
datawindow ldw
ldw = tab_1.tabpage_notes.dw_1 
ll_ret = this.sharedata( ldw )
if ll_ret <> 1 then messagebox('','share data FAILED')
*/
//---------------------------- APPEON END ----------------------------

of_set_title( )


//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

//of_set_contract_type( this)
//dwItemStatus l_status
datawindowchild dwc

this.getchild( 'group_multi_loc_id', dwc)
dwc.settransobject(sqlca)
if  dwc.retrieve( this.object.ctx_id[1]) > 0 then 
	// set the rec_id
	this.object.group_multi_loc_id[1] = dwc.getItemNumber(1,'rec_id')
	// reset the starus
	this.SetItemStatus(1, 0,Primary!, l_status)
end if



//////////////////////////////////////////////////////////////////////////////////
// set the contract type
//////////////////////////////////////////////////////////////////////////////////

inv_contract_details.of_set_contact_type(this.getItemNumber(1,'category') ) 


end event

event pfc_retrieve;call super::pfc_retrieve;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

retrieve(inv_contract_details.of_get_ctx_id( ))
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.08.2007 By: Jack
//$<reason> Fix a defect.
string ls_version_number
datetime ldt_version_date
long ll_facility_id,ll_row
string ls_facility_name
datawindowchild ldwc_child
If this.rowcount() < 1 Then Return 0
ls_version_number = dw_1.getitemstring(1,'version_number')
ldt_version_date = dw_1.getitemdatetime(1,'version_date')

If isnull(ls_version_number) or ls_version_number = '' Then
	is_version_number = ls_version_number
	dw_1.setitem(1,'version_number','1.0')
End If
If isnull(ldt_version_date) Then
	dw_1.setitem(1,'version_date',datetime(today()))
End If
//---------------------------- APPEON END ----------------------------

//Add company to dddw -- jervis 12.13.2010
ll_facility_id = this.GetItemNumber( 1, "app_facility")
if dw_1.GetChild( "app_facility", ldwc_child) = 1 then
	if ldwc_child.Find( " facility_id =" + string(ll_facility_id), 1, ldwc_child.rowcount()) = 0 then
		ls_facility_name = gnv_data.of_GetItem( "ctx_facility", "facility_name", "facility_id = " + string(ll_facility_id))
		ll_row = ldwc_child.InsertRow( 1)
		ldwc_child.SetItem( ll_row,"facility_id", ll_facility_id)
		ldwc_child.SetItem( ll_row,"facility_name", ls_facility_name)
	end if
end if

return success
end event

event pfc_validation;call super::pfc_validation;/******************************************************************************************************************
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

long ll_row
long ll_null
setnull(ll_null)

If AncestorReturnValue < 0 Then Return AncestorReturnValue //Added By Ken.Guo 03/20/2013

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.19.2007 By: Jack
//$<reason> Fix a defect.
If isvalid(m_pfe_cst_mdi_menu_contract) Then
	If m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = False Then
		If ib_new Then
			iw_parent.function dynamic wf_set_select('tabpage_search',False) 	
			ib_new = False
		End If
		Return success
	End If
Else
	If ib_new Then	Return success	
End If
//---------------------------- APPEON END ----------------------------

if rowcount() < 1 then return success
if len(inv_contract_details.is_mode) < 1 then return success

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-30 By: Scofield
//$<Reason> Category column and Company name column can't be NULL

long	ll_Cate,ll_ComNo

ll_Row = dw_1.GetRow()
if ll_Row > 0 and ll_Row <= This.RowCount() then
	ll_Cate = dw_1.GetItemNumber(ll_Row,'category')
	ll_ComNo = dw_1.GetItemNumber(ll_Row,'app_facility')
	
	if IsNull(ll_Cate)  and dw_1.describe("category.DDDW.Required") <> 'yes' then //add dw_1.describe("category.DDDW.Required") <> '1' - jervis 09.28.2011
		MessageBox(gnv_app.iapp_object.DisplayName,'Category Field cannot be empty. Please select a value from the dropdown list.',Exclamation!)
		dw_1.SetColumn('category')
		dw_1.SetFocus()
		return failure
	end if
	
	if IsNull(ll_ComNo) and dw_1.describe("app_facility.DDDW.Required") <> 'yes' then
		MessageBox(gnv_app.iapp_object.DisplayName,'Company Name Field cannot be empty. Please select a value from the dropdown list.',Exclamation!)
		dw_1.SetColumn('app_facility')
		dw_1.SetFocus()
		return failure
	end if
end if
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 03/20/2013. check the master_contract_name field
If ll_row > 0 and dw_1.describe("master_contract_name.ddlb.Required") = 'yes'  and dw_1.describe("master_contract_name.visible") = '1'  Then
	If dw_1.GetItemString(1,'master_contract_name') = '' or isnull(dw_1.GetItemString(1,'master_contract_name')) Then
		MessageBox(gnv_app.iapp_object.DisplayName,'Master Contract ID Field cannot be empty. Please select a value from the dropdown list.',Exclamation!)
		dw_1.SetColumn('master_contract_name')
		dw_1.SetFocus()	
		return failure
	End If
End If


if not f_validstr(string(object.status[1])) then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 07.17.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	messagebox('Missing Data', 'The contract status is required.' ) 
	*/
	If appeongetclienttype() = 'WEB' Then	
		messagebox('Missing Data', 'The contract status is required.' ) 
	End If
	//---------------------------- APPEON END ----------------------------
	setcolumn( 'status')
	iw_parent.function dynamic of_set_validation(True) // Add by Jack 04/19/2007	
	return failure
end if


if object.app_facility[1] = -1 then 
	object.app_facility[1] = ll_null
	
end if


RETURN SUCcess
end event

event pfc_preupdate;call super::pfc_preupdate;
///******************************************************************************************************************
//**  [PUBLIC]   : set the primary key
//**==================================================================================================================
//**  Purpose   	: 
//**==================================================================================================================
//**  Arguments 	: [none] 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: Michael B. Skinner  today()
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//********************************************************************************************************************/

long ll_ret
string ls_version_number
datetime ldt_version_date

if rowcount( ) > 0 THEN
	if not f_validstr(string( dw_1.object.ctx_id[1] )) then
		inv_contract_details.of_set_ctx_id(of_get_next_seq_number( ))
		this.setItem(1,'ctx_id',inv_contract_details.of_get_ctx_id( ) )
		tab_1.tabpage_1.il_ctx_id = inv_contract_details.of_get_ctx_id( )		//Add by Jack 06/12/2007	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 06.21.2007 By: Jack
		//$<reason> 		
		If ib_new = True Then
			If isvalid(w_contract) Then
				w_contract.tab_contract_details.tabpage_search.il_ctx_id = inv_contract_details.of_get_ctx_id( )
				//Add by Jack 07.06.2007
				string ls_company,ls_id
				ls_company = this.describe("Evaluate( 'lookupdisplay(app_facility) ', " + string(1) + " )")
				ls_id = string(inv_contract_details.of_get_ctx_id( ))
				w_contract.tab_contract_details.tabpage_search.is_copy_contract = ls_company + ' - ' + ls_id 
			End If
		End If
		//---------------------------- APPEON END ----------------------------

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 06.28.2006 By: Liang QingShi
		//$<reason> Contract module modification 
		this.setItem(1,'notes',tab_1.tabpage_notes.dw_1.getitemstring(1,'notes'))	
		this.setItem(1,'custom_1',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_1'))	
		this.setItem(1,'custom_2',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_2'))	
		this.setItem(1,'custom_3',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_3'))	
		this.setItem(1,'custom_4',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_4'))	
		this.setItem(1,'custom_5',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_5'))	
		this.setItem(1,'custom_6',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_6'))	
		this.setItem(1,'custom_7',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_7'))	
		this.setItem(1,'custom_8',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_8'))	
		this.setItem(1,'custom_9',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_9'))	
		this.setItem(1,'custom_10',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_10'))	
		this.setItem(1,'custom_11',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_11'))	
		this.setItem(1,'custom_12',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_12'))	
		this.setItem(1,'custom_13',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_13'))	
		this.setItem(1,'custom_14',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_14'))	
		this.setItem(1,'custom_15',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_15'))	
		this.setItem(1,'custom_16',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_16'))	
		this.setItem(1,'custom_17',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_17'))	
		this.setItem(1,'custom_18',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_18'))	
		this.setItem(1,'custom_19',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_19'))	
		this.setItem(1,'custom_20',tab_1.tabpage_custom.dw_1.getitemstring(1,'custom_20'))	

		this.setItem(1,'custom_date1',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date1'))	
		this.setItem(1,'custom_date2',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date2'))	
		this.setItem(1,'custom_date3',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date3'))	
		this.setItem(1,'custom_date4',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date4'))	
		this.setItem(1,'custom_date5',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date5'))	
		this.setItem(1,'custom_date6',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date6'))	
		this.setItem(1,'custom_date7',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date7'))	
		this.setItem(1,'custom_date8',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date8'))	
		this.setItem(1,'custom_date9',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date9'))	
		this.setItem(1,'custom_date10',tab_1.tabpage_custom.dw_1.getitemdatetime(1,'custom_date10'))	
	
		this.setItem(1,'custom_n1',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n1'))	
		this.setItem(1,'custom_n2',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n2'))	
		this.setItem(1,'custom_n3',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n3'))	
		this.setItem(1,'custom_n4',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n4'))	
		this.setItem(1,'custom_n5',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n5'))	
		this.setItem(1,'custom_n6',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n6'))	
		this.setItem(1,'custom_n7',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n7'))	
		this.setItem(1,'custom_n8',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n8'))	
		this.setItem(1,'custom_n9',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n9'))	
		this.setItem(1,'custom_n10',tab_1.tabpage_custom.dw_1.getitemnumber(1,'custom_n10'))

		//---------------------------- APPEON END ----------------------------
	end if
	
	//-------------Begin Added by Alfee 09.27.2007 ---------------------------------------
	//<$Reason>If alarms disabled to the current contract status, warning to delete the alarm setting. 
	Long ll_ctx_id, ll_cnt
	String ls_contract_status, ls_alarm_enabled, ls_msg

	IF dw_1.RowCount() > 0 THEN ls_contract_status = String(dw_1.GetItemNumber(1, 'status'))
	IF NOT IsNull(ls_contract_status) THEN ls_alarm_enabled = gnv_data.of_getitem('code_lookup','custom_1',"lookup_name = 'Contract Status' and lookup_code = " + ls_contract_status)
	IF Upper(ls_alarm_enabled) <> 'YES' THEN
		ll_ctx_id = inv_contract_details.of_get_ctx_id( )
		Select Count(*) Into :ll_cnt From ctx_notification Where ctx_id = :ll_ctx_id ;
		If ll_cnt > 0 Then
			ls_msg = "The Contract status has the Alarm Enabled flag set to Off. This will remove the alarms that are currently set for this contract.  " 
			ls_msg += "Continue?"
			If MessageBox("Save Contract", ls_msg, Question!, YesNo!) = 1 Then
				gnv_appeondb.of_startqueue()
				Delete From ctx_notification_users Where ctx_id = :ll_ctx_id ;
				Delete From ctx_alarm_attachment Where ctx_id = :ll_ctx_id ;		//Added by Scofield on 2009-02-24
				Delete From ctx_notification Where ctx_id = :ll_ctx_id ;
				gnv_appeondb.of_commitqueue( )
			Else
				Return failure
			End If
		End If
	END IF
	//-------------End Added -------------------------------------------------------------

	if il_app_facility > 0 then
		dw_1.setitem(dw_1.getrow(),'app_facility',il_app_facility)
	end if
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.04.2007 By: Jack
	//$<reason> Fix a defect.
	ls_version_number = dw_1.getitemstring(1,'version_number')
	ldt_version_date = dw_1.getitemdatetime(1,'version_date')
	
	If isnull(ls_version_number) or ls_version_number = '' Then
		is_version_number = ls_version_number
		dw_1.setitem(1,'version_number','1.0')
	End If
	If isnull(ldt_version_date) Then
		dw_1.setitem(1,'version_date',datetime(today()))
	End If
	//---------------------------- APPEON END ----------------------------
END IF


//IF getitemstatus(1, /*readonly integer c*/, /*dwbuffer b */)
//this.sharedataoff()
//ll_ret = dw_custom.ShareData(this)
//
//
//if ll_ret <> 1 then messagebox('','share data FAILED')


//-------------------Begin Commented by Alfee 09.14.2007---------------
//<Reason$>Remove this default, from John.
/*//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.15.2006 By: Davis
//$<reason> By default set the Review Date field to be 60 days prior to Expiration Date field.
Datetime ldt_review_date, ldt_expriation_date

IF This.Rowcount( ) > 0 THEN
	ldt_expriation_date = This.Getitemdatetime( 1, "expriation_date")
	ldt_review_date = This.Getitemdatetime( 1, "review_date")
		
	IF Isnull(ldt_review_date) THEN
		ldt_review_date = Datetime(RelativeDate(Date(ldt_expriation_date), - 60))
		This.Setitem( 1, "review_date", ldt_review_date)
	END IF
END IF
//---------------------------- APPEON END ----------------------------*/
//--------------------End Commented -------------------------------------

return success



end event

event pfc_postinsertrow;call super::pfc_postinsertrow;
/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//IB_isupdateable = FALSE

//dw_custom.ShareData(this)


long ll_active_status

//////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////
if isnull(this.object.status[1]) then	//04.29.2008 By Jervis
	ll_active_status = inv_contract_details.of_get_active_status_code()
	
	this.object.status[1] = ll_active_status
end if

////Set Date Alarm Buttons --Added by Alfee 09.26.2007
//of_set_buttons(TRUE) 
end event

event buttonclicked;/******************************************************************************************************************
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


string ls_path
string docname, named, path
integer value
string ls_Null
long ll_ctx_id,ll_master_contract_id,ll_category
string ls_master_contract_name,ls_company
str_pass lstr_pass

Long	ll_RowCnts,ll_Cycle, ll_find , ll_row	//Added By mark 03/27/12
DataWindowChild	ldwc_child
string		ls_facility_name, ls_dotdd_coltype

SetNull(ls_Null)

// mskinner 05 april 2006 -- begin
//add "and b_custom_statustrack" -- jervis 04.19.2011
if of_check_read_only( ) and (Lower(dwo.name) <> Lower('b_statustrack') and  Lower(dwo.name) <> Lower('b_custom_status1track') and Lower(dwo.name) <> Lower('b_custom_status2track')  ) then return success //Commented by Ken.Guo on 2009-01-05
//if of_check_read_only( ) then return success //Added by Ken.Guo on 2009-01-05
// mskinner 05 april 2006 -- end 
lstr_pass.s_u_dw  = this

choose case dwo.name
	case 'b_add'
    OpenWithParm(w_app_facility,lstr_pass)
	  event ue_populatedddws( )
	 if message.doubleparm > 0 then 
       this.object.app_facility[1] =    message.doubleparm 
    end if
	 //  event ue_populatedddws( )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.09.2007 By: Jack
	//$<reason> 
   case 'b_contract_search'
		          
		ll_ctx_id = This.getitemnumber(This.getrow(),'ctx_id')
		ll_category = This.getitemnumber(This.getrow(),'category')
		If isnull(ll_ctx_id) Then ll_ctx_id = 0
		If isnull(ll_category) Then ll_category = 0
		ls_company = this.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(1)+" )")
		this.setcolumn('master_contract_name')
		
		OpenWithParm(w_mastert_contract_search,string(ll_ctx_id) + '-' + string(ll_category) + '+' + ls_company)
		ls_master_contract_name = message.stringparm  
		ll_master_contract_id = long(mid(ls_master_contract_name,1,pos(ls_master_contract_name,'-') - 1))  
		If ll_master_contract_id > 0 Then
			OF_ENABLE_SAVE( )
			This.setitem(This.getrow(),'master_contract_id',ll_master_contract_id)
			This.setitem(This.getrow(),'master_contract_name',ls_master_contract_name) 
			il_master_contract_id = ll_master_contract_id      								
			is_master_contract_name = ls_master_contract_name  								
		Else
			This.setitem(This.getrow(),'master_contract_id',il_master_contract_id)			
			This.setitem(This.getrow(),'master_contract_name',is_master_contract_name) 
		End If	
	//---------------------------- APPEON END ----------------------------
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-06-02 By: Scofield
	//$<Reason> Contract Status track maintenance.
	
	Case 'b_statustrack','b_custom_status1track','b_custom_status2track'
		//Modified By Ken.Guo 2010-02-25 . pass ab_readonly parm.
		Str_ctx_info lstr_ctx
		ll_ctx_id = This.GetItemNumber(This.GetRow(),'ctx_id')
		lstr_ctx.ab_readonly = of_check_read_only( )
		lstr_ctx.al_ctx_id = ll_ctx_id
		
		//Add Depent feature for status field - jervis 04.13.2011
		lstr_ctx.al_view_id = this.il_viewid
		lstr_ctx.al_screen_id = this.il_screenid
		lstr_ctx.as_fieldname = mid(dwo.name,3)
		lstr_ctx.as_fieldname = mid(lstr_ctx.as_fieldname,1,len(lstr_ctx.as_fieldname) - 5) //add by jervis 04.19.2011
		lstr_ctx.as_fieldtag = this.Describe( lstr_ctx.as_fieldname + ".tag")
		lstr_ctx.as_fieldlabel = this.Describe( lstr_ctx.as_fieldname + "_t.text") //add by jervis 04.26.2011
		
		//---------Begin Modified by (Appeon)Harry 03.22.2016 for BugH031702--------
		//OpenWithParm(w_contract_status_track,lstr_ctx)
		if ll_ctx_id > 0 then
			OpenWithParm(w_contract_status_track,lstr_ctx)
		else
			messagebox(iw_parent.title, 'The current contact has not been saved. Please save it before continuing.')
			Return
		end if
		//---------End Modfiied ------------------------------------------------------
		
	//---------------------------- APPEON END ----------------------------
	//Begin --	Added By mark 03/27/12 for added funcation of button [...] 
	Case 'b_app_facility_dotdd_company'
	   lstr_pass.s_string = 'Select_Company'
  	   ls_Company =  this.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(1)+" )")
//	   lstr_pass.l_facility_id =Long(this.object.app_facility[1])
	   If IsNull(ls_Company) or trim(ls_Company) = '' Then 
			ls_Company = ''
			lstr_pass.display_contact_detail =false
	   Else
			lstr_pass.display_contact_detail =true
       End if 
	   lstr_pass.s_string_array[1]  = ls_Company// company name id of the contract

	   OpenWithParm ( w_contract_contact, lstr_pass)
	   If message.doubleparm > 0 Then 
			il_app_facility = message.doubleparm
			
			//Added By Ken.Guo 03/31/2012. 
			If il_app_facility_old = il_app_facility Then 
				this.event ue_upd_company_name(il_app_facility_old) //(Appeon)Harry 10.09.2016 - Bug_id#5345
				Return
			End If
			
			//Delete Old Data 
			If isnull(il_app_facility_old) or il_app_facility_old <> il_app_facility Then
				ll_RowCnts = dw_ccc.RowCount()
				For ll_Cycle = ll_RowCnts To 1 Step -1
					dw_ccc.DeleteRow(ll_Cycle)
				Next		
			End If
			
			il_app_facility_old = il_app_facility
			if this.GetChild( "app_facility",ldwc_child) = 1 then
				if ldwc_child.rowcount( ) > 0 then 					
					ll_find = ldwc_child.find( "facility_id = " + string(il_app_facility),1, ldwc_child.rowcount( ) )
					if ll_find <= 0 then 
						ls_facility_name = gnv_data.of_GetItem( "ctx_facility", "facility_name", "facility_id = " + string(il_app_facility))
						ll_row = ldwc_child.InsertRow( 1)
						ldwc_child.SetItem( ll_row,"facility_id", il_app_facility)
						ldwc_child.SetItem( ll_row,"facility_name", ls_facility_name)
					end if 
				end if 
			end if
         	this.setitem(1,"app_facility", il_app_facility)
			of_add_contract_contact(il_app_facility)			
			gl_Company_id = il_app_facility						//Added By Mark Lee 12/19/2012
		Else
			this.event ue_upd_company_name(il_app_facility_old) //(Appeon)Harry 10.09.2016 - Bug_id#5345
			this.setitem(1,"app_facility", il_app_facility_old)
			of_add_contract_contact(il_app_facility_old)			
			gl_Company_id = il_app_facility_old					//Added By Mark Lee 12/19/2012
		End If	
		// End --	Added By mark 03/27/12 for added funcation of button [...] 
	Case Else
		str_pass 		lstr_dotdd_pass
		String 		ls_dotdd_name,	ls_dotdd_column,	ls_dotdd_Company, ls_dotdd_facility_name, ls_dotdd_tmp
		Long			ll_dotdd_facility,	ll_dotdd_find,	ll_dotdd_row
		DataWindowChild		ldwc_dotdd_child
		String			ls_dotdd_col_tag,	ls_dotdd_display_col
		
		lstr_dotdd_pass.s_u_dw = this
		ls_dotdd_name 	= dwo.name
		
		IF Pos(ls_dotdd_name,"_dotdd_company") > 0 And Left(ls_dotdd_name,2) = 'b_'  and trim(ls_dotdd_name) <> "b_app_facility_dotdd_company" Then
			ls_dotdd_column =  mid(ls_dotdd_name,3,Pos(ls_dotdd_name,'_dotdd_company') - 3 )
			
			lstr_dotdd_pass.s_string = 'Dotdd_Company'
			ls_dotdd_Company =  this.describe("Evaluate( 'lookupdisplay("+ls_dotdd_column+") ', "+string(1)+" )")
			ls_dotdd_col_tag	=  this.describe(ls_dotdd_column+".tag")
			If IsNull(ls_dotdd_Company) or trim(ls_dotdd_Company) = '' Then 
				ls_dotdd_Company = ''
				lstr_dotdd_pass.display_contact_detail =false
			Else
				lstr_dotdd_pass.display_contact_detail =true
			End if 
			lstr_dotdd_pass.s_string_array[1]  = ls_dotdd_Company 	// company name id of the contract
			lstr_dotdd_pass.as_search_type	 =	ls_dotdd_col_tag
			OpenWithParm ( w_contract_contact, lstr_dotdd_pass)
			
			If message.doubleparm > 0 Then 
				ll_dotdd_facility = message.doubleparm
				if this.GetChild( ls_dotdd_column,ldwc_dotdd_child) = 1 then
					ls_dotdd_display_col	=	 string(this.Describe(ls_dotdd_column+".dddw.displaycolumn"))
					ls_dotdd_coltype	=	string(this.Describe(ls_dotdd_column+".coltype"))		
					if ldwc_dotdd_child.rowcount( ) > 0 then 					
						ll_dotdd_find = ldwc_dotdd_child.find( "facility_id = " + string(ll_dotdd_facility),1, ldwc_dotdd_child.rowcount( ) )
						if ll_dotdd_find <= 0 then 
							ls_dotdd_facility_name = gnv_data.of_GetItem( "facility",ls_dotdd_display_col, "facility_id = " + string(ll_dotdd_facility),"Dotdd_Company")
							ll_dotdd_row = ldwc_dotdd_child.InsertRow( 1)
							ldwc_dotdd_child.SetItem( ll_dotdd_row,"facility_id", ll_dotdd_facility)
							ldwc_dotdd_child.SetItem( ll_dotdd_row,ls_dotdd_display_col, ls_dotdd_facility_name)
						end if 
					end if 
				end if
				IF Pos(ls_dotdd_coltype,'(') > 0 Then
					ls_dotdd_coltype = left(ls_dotdd_coltype,Pos(ls_dotdd_coltype,'(') - 1)
				End If
				Choose Case ls_dotdd_coltype
					case "char"
							this.setitem(1,ls_dotdd_column, string(ll_dotdd_facility))
					case "decimal","int","long","number","real","ulong"
							this.setitem(1,ls_dotdd_column, Long(ll_dotdd_facility))
				End Choose 
			End If	
		End If 
end choose

end event

event ue_keydown;//call super::ue_keydown;



// NEW 
IF  KeyDown(KeyControl!) and KeyDown(78) then
	IW_parent.EVENT DYNAMIC UE_NEW()
   RETURN
end if
end event

event pfc_deleterow;n_cst_contract lnv_contract
lnv_contract = Create n_cst_contract

//----Begin Modified by Alfee 09.30.2007--------
//<$Reason>Use the same interface at tabpage level
//if dw_1.ib_read_only then return success
if of_check_read_only( ) then 
	If isvalid(lnv_contract) Then Destroy lnv_contract
	return success
End If
//----End Modified------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.31.2007 By: Davis
//$<reason> If "Delete Contract" checked then a user can delete a Entire Contract.
If w_contract.ib_copy = False then
	IF w_mdi.of_security_access( 2078 ) = 0 or gi_user_readonly = 1 THEN
		Messagebox("Delete Contract", "Please make sure you have right to delete the contract.")
		If isvalid(lnv_contract) Then Destroy lnv_contract
		RETURN success
	END IF
End If
//---------------------------- APPEON END ----------------------------

//if messagebox('Delete Contract', 'Are you sure you want to delete this contract?',question!,Yesno!,2) = 1 then
long ll_ctx_id 
if w_contract.ib_copy = True  then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.04.2006 By: Liang QingShi
	//$<reason> Contract module modification
	//$<reason> Fix a defect.
	if this.getrow() > 0 then
		ll_ctx_id = this.getitemnumber(this.getrow(),'ctx_id')
	else
		If isvalid(lnv_contract) Then Destroy lnv_contract
		return success
	end if
	lnv_contract.of_delete_ctx_detail(ll_ctx_id ) //Modified By Ken.Guo 2009-08-27
	/*
	gnv_appeondb.of_startqueue( )		
	if gs_dbtype <> "ASA" then
		DELETE FROM  CTX_LOCATION_CONTACTS WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_LOCATION_SPECIALTY WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_LOCATION_PRACS WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_LOC WHERE ctx_id = :ll_ctx_id;
		
		DELETE FROM  CTX_ELEMENTS WHERE CTX_REQ_PROFILE_HDR_id in (SELECT a.CTX_REQ_PROFILE_HDR_id FROM CTX_REQ_PROFILE_HDR a WHERE a.ctx_id = :ll_ctx_id);
		DELETE FROM  CTX_REQ_PROFILE_HDR WHERE ctx_id = :ll_ctx_id;
		
		DELETE FROM  CTX_FEE_SCHED_DATA WHERE fee_sched_location_id in (SELECT a.fee_sched_location_id FROM CTX_FEE_SCHED_LOCATIONS a where a.fee_sched_id in (SELECT b.fee_sched_id FROM CTX_FEE_SCHED_HDR b WHERE b.ctx_id = :ll_ctx_id));
		DELETE FROM  CTX_FEE_SCHED_LOCATIONS WHERE fee_sched_id in (SELECT a.fee_sched_id FROM CTX_FEE_SCHED_HDR a WHERE a.ctx_id = :ll_ctx_id);
		DELETE FROM  CTX_FEE_SCHED_PRACS WHERE fee_sched_id in (SELECT a.fee_sched_id FROM CTX_FEE_SCHED_HDR a WHERE a.ctx_id = :ll_ctx_id);		
		DELETE FROM  CTX_FEE_SCHED_HDR WHERE ctx_id = :ll_ctx_id;
		
		DELETE FROM  CTX_FILE_LOCATION WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_ORGS_CONTACT WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_AI_NOTIFICATION_USERS WHERE ctx_id = :ll_ctx_id; //Alfee 02.26.2008
		DELETE FROM  ctx_ai_alarm_attachment WHERE ctx_id = :ll_ctx_id; 	//Added by Scofield on 2009-02-24
		DELETE FROM  CTX_AI_NOTIFICATION WHERE ctx_id = :ll_ctx_id; 		//Alfee 02.26.2008
		DELETE FROM  CTX_ACTION_ITEMS WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_IMAGE WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_IMAGES WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_NOTIFICATION_USERS WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  ctx_alarm_attachment WHERE ctx_id = :ll_ctx_id;		//Added by Scofield on 2009-02-24
		DELETE FROM  CTX_NOTIFICATION WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_FEE_SCHED_NM WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  ctx_products WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  CTX_CONTRACT_CONTACTS WHERE ctx_id = :ll_ctx_id;
	end if
	DELETE FROM  ctx_version WHERE ctx_id = :ll_ctx_id;
	DELETE FROM  sys_StatusAudit WHERE ctx_id = :ll_ctx_id;					//Added by Scofield on 2008-05-22
	DELETE FROM  dashboard_gadgets_recent WHERE UPPER(recent_type) = 'CTX' AND data_id = :ll_ctx_id;	//Added by Scofield on 2009-08-07
	commit;
	
	// Delete document data	//Added by Davis 01.29.2007
	DELETE FROM  Ctx_am_doc_audit WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );
	DELETE FROM  CTX_AM_AI_NOTIFICATION_USERS WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id ); //Alfee 02.26.2008
	DELETE FROM  ctx_am_ai_alarm_attachment WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id ); 	//Added by Scofield on 2009-02-24
	DELETE FROM  CTX_AM_AI_NOTIFICATION WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id ); 		//Alfee 02.26.2008
	DELETE FROM  ctx_am_action_item WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );
	DELETE FROM  Ctx_am_document_clause WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );	
	DELETE FROM  Ctx_am_doc_image WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );
	DELETE FROM  Ctx_am_document WHERE ctx_id = :ll_ctx_id;
	Update ctx_basic_info Set master_contract_id = 0 Where master_contract_id = :ll_ctx_id;   //Added By Ken.Guo 2009-05-18.
	gnv_appeondb.of_commitqueue( )
	*/
	dw_products.reset()
	//---------------------------- APPEON END ----------------------------
	Super::EVENT pfc_deleterow( )
	
	//THIS.RESET( )
	dw_ccc.reset()
	dw_occ.reset( )
	tab_1.tabpage_1.dw_1.reset()//Rodger Wu added.
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.30.2007 By: Jack
	//$<reason> Fix a defec.
	iw_parent.function dynamic wf_set_select('tabpage_search',False) 	
	If ib_new Then
		iw_parent.function dynamic of_set_validation(True) 
		ib_new = False
	End If	
	If isvalid(m_pfe_cst_mdi_menu_contract) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', False)
	End If	
	//---------------------------- APPEON END ----------------------------
	
	IW_parent.EVENT DYNAMIC UE_SAVE()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07.06.2007 By: Jack
	//$<reason> Fix a defect.
	If isvalid(m_pfe_cst_mdi_menu_contract) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx,'enabled', False)
	End If 
	//---------------------------- APPEON END ----------------------------
Else
   if messagebox('Delete Contract', 'Are you sure you want to delete this contract?~r~nWARNING! If you proceed, you will delete all data connected to this contract. This operation cannot be undone.',question!,Yesno!,2) = 1 then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 09.04.2006 By: Liang QingShi
		//$<reason> Contract module modification
		//$<reason> Fix a defect.
		if this.getrow() > 0 then
			ll_ctx_id = this.getitemnumber(this.getrow(),'ctx_id')
		else
			If isvalid(lnv_contract) Then Destroy lnv_contract
			return success
		end if
		lnv_contract.of_delete_ctx_detail(ll_ctx_id )
		/*
		gnv_appeondb.of_startqueue( )		
		if gs_dbtype <> "ASA" then
			DELETE FROM  CTX_LOCATION_CONTACTS WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_LOCATION_SPECIALTY WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_LOCATION_PRACS WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_LOC WHERE ctx_id = :ll_ctx_id;
			
			DELETE FROM  CTX_ELEMENTS WHERE CTX_REQ_PROFILE_HDR_id in (SELECT a.CTX_REQ_PROFILE_HDR_id FROM CTX_REQ_PROFILE_HDR a WHERE a.ctx_id = :ll_ctx_id);
			DELETE FROM  CTX_REQ_PROFILE_HDR WHERE ctx_id = :ll_ctx_id;
			
			DELETE FROM  CTX_FEE_SCHED_DATA WHERE fee_sched_location_id in (SELECT a.fee_sched_location_id FROM CTX_FEE_SCHED_LOCATIONS a where a.fee_sched_id in (SELECT b.fee_sched_id FROM CTX_FEE_SCHED_HDR b WHERE b.ctx_id = :ll_ctx_id));
			DELETE FROM  CTX_FEE_SCHED_LOCATIONS WHERE fee_sched_id in (SELECT a.fee_sched_id FROM CTX_FEE_SCHED_HDR a WHERE a.ctx_id = :ll_ctx_id);
			DELETE FROM  CTX_FEE_SCHED_PRACS WHERE fee_sched_id in (SELECT a.fee_sched_id FROM CTX_FEE_SCHED_HDR a WHERE a.ctx_id = :ll_ctx_id);		
			DELETE FROM  CTX_FEE_SCHED_HDR WHERE ctx_id = :ll_ctx_id;
			
			DELETE FROM  CTX_FILE_LOCATION WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_ORGS_CONTACT WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_AI_NOTIFICATION_USERS WHERE ctx_id = :ll_ctx_id; //Alfee 02.26.2008
			DELETE FROM  ctx_ai_alarm_attachment WHERE ctx_id = :ll_ctx_id; 	//Added by Scofield on 2009-02-24
			DELETE FROM  CTX_AI_NOTIFICATION WHERE ctx_id = :ll_ctx_id; 		//Alfee 02.26.2008
			DELETE FROM  CTX_ACTION_ITEMS WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_IMAGE WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_IMAGES WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_NOTIFICATION_USERS WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  ctx_alarm_attachment WHERE ctx_id = :ll_ctx_id;		//Added by Scofield on 2009-02-24
			DELETE FROM  CTX_NOTIFICATION WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_FEE_SCHED_NM WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  ctx_products WHERE ctx_id = :ll_ctx_id;
			DELETE FROM  CTX_CONTRACT_CONTACTS WHERE ctx_id = :ll_ctx_id;
		end if
		DELETE FROM  ctx_version WHERE ctx_id = :ll_ctx_id;
		DELETE FROM  sys_StatusAudit WHERE ctx_id = :ll_ctx_id;			//Added by Scofield on 2008-05-22
		DELETE FROM  dashboard_gadgets_recent WHERE UPPER(recent_type) = 'CTX' AND data_id = :ll_ctx_id;	//Added by Scofield on 2009-08-07
		commit;
		
		// Delete document data	//Added by Davis 01.29.2007
		DELETE FROM  Ctx_am_doc_audit WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );
		DELETE FROM  CTX_AM_AI_NOTIFICATION_USERS WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id ); //Alfee 02.26.2008
		DELETE FROM  ctx_am_ai_alarm_attachment WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id ); 	//Added by Scofield on 2009-02-24
		DELETE FROM  CTX_AM_AI_NOTIFICATION WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id ); 		//Alfee 02.26.2008
		DELETE FROM  ctx_am_action_item WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );
		DELETE FROM  Ctx_am_document_clause WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );	
		DELETE FROM  Ctx_am_doc_image WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :ll_ctx_id );
		DELETE FROM  Ctx_am_document WHERE ctx_id = :ll_ctx_id;
		Update ctx_basic_info Set master_contract_id = 0 Where master_contract_id = :ll_ctx_id;   //Added By Ken.Guo 2009-05-18.
		gnv_appeondb.of_commitqueue( )
		*/
		dw_products.reset()
		//---------------------------- APPEON END ----------------------------
		Super::EVENT pfc_deleterow( )
		
		//Added By mark 04/12/12 fixed bug Failed to find in datawindow when parameter's variable is null in the APB 
		If Not isnull(ll_ctx_id) Then
			of_DeleteSearchTabCTX(ll_ctx_id)			//Added by Scofield on 2010-05-21
		End IF
		
		//THIS.RESET( )
		dw_ccc.reset()
		dw_occ.reset( )
		tab_1.tabpage_1.dw_1.reset()//Rodger Wu added.
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.30.2007 By: Jack
		//$<reason> Fix a defec.
		iw_parent.function dynamic wf_set_select('tabpage_search',False) 	
		If ib_new Then
			iw_parent.function dynamic of_set_validation(True) 
			ib_new = False
		End If	
		If isvalid(m_pfe_cst_mdi_menu_contract) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', False)
		End If	
		//---------------------------- APPEON END ----------------------------
		
		IW_parent.EVENT DYNAMIC UE_SAVE()
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 07.06.2007 By: Jack
		//$<reason> Fix a defect.
		If isvalid(m_pfe_cst_mdi_menu_contract) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx,'enabled', False)
		End If 
		//---------------------------- APPEON END ----------------------------
   end If
end if

If isvalid(lnv_contract) Then Destroy lnv_contract
if IsValid(w_DashBoard) then w_DashBoard.Of_Refres_All_Tabs()				//Added by Scofield on 2009-08-07


Return SUCCESS

end event

event itemchanged;str_pass 	lstr_pass
long			ll_Category,ll_Rtn,ll_Cycle,ll_RowCnts

DWItemStatus	ldwis_ColStatus,ldwis_RowStatus

Of_Enable_Save()

if This.Describe(dwo.name + ".Edit.Style") = "dddw" then			//Added by Scofield on 2008-01-03
	of_AutoDataFill(il_ViewId,il_ScreenId,dwo.name,row,data)
end if

choose case dwo.name 
	case 'app_facility'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.29.2006 By: LeiWei
		//$<reason> Fix a defect.
		//$<reason> The following script moved to ue_post_itemchanged.
		/*
		If data = '-1' then 
			OpenWithParm(w_app_facility,lstr_pass)
			event ue_populatedddws( )
			if message.doubleparm > 0 then 
			  this.object.app_facility[1] =    message.doubleparm 		
			end if
		End If
		*/
		//---------------------------- APPEON END ----------------------------
		
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<  Add > 2007-11-01 By: Scofield
		//$<Reason> Auto add the corresponding contact

		if long(data) > 0 then
			
			//clear the contact from the previous company - jervis 09.05.2011
			/*
			//BEGIN---Modify by Scofield on 2010-02-21
			ldwis_RowStatus = This.GetItemStatus(Row,0,Primary!)
			if ldwis_RowStatus = New! or ldwis_RowStatus = NewModified! then
				ll_RowCnts = dw_ccc.RowCount()
				for ll_Cycle = 1 to ll_RowCnts
					dw_ccc.DeleteRow(0)
				next
			end if
			//END---Modify by Scofield on 2010-02-21
			*/
			ll_RowCnts = dw_ccc.RowCount()
			for ll_Cycle = ll_RowCnts To 1 Step -1
				dw_ccc.DeleteRow(ll_Cycle)
			next
			of_Add_Contract_Contact(long(data))
		end if
		//---------------------------- APPEON END ----------------------------
	case 'status' 
		
//	   if f_validstr(data) then 	
//	      iw_parent.function dynamic wf_manage_tabs(true)
//      else
//			iw_parent.function dynamic wf_manage_tabs(false)
//		end if 
	 
	 //////////////////////////////////////////////////////////////////////////////////
// set the contract type
//////////////////////////////////////////////////////////////////////////////////
	case 'category'
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-11-25 By: Scofield
		//$<Reason> Popup Question dialog if modify the category column the first time
		if Row > 0 and Row <= This.RowCount() then
			ldwis_RowStatus = This.GetItemStatus(Row,0,Primary!)
			ldwis_ColStatus = This.GetItemStatus(Row,'category',Primary!)
			if (ldwis_RowStatus = NotModified! or ldwis_RowStatus = DataModified!) and ldwis_ColStatus = NotModified! then
				//---------Begin Commented by (Appeon)Harry 05.31.2013 for V141 ISG-CLX--------
				//If gnv_data.of_getitem('icred_settings' ,'set_59' , False ) = '1' Then
				//	ll_Rtn = 1 //Added By Ken.Guo 2009-11-18. SE product need not show the message.
				//Else
					ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,'Changing the Category may cause issues with how your data is displayed, Continue?',Question!,YesNo!)
				//End If
				//---------End Commented ------------------------------------------------------
				if ll_Rtn = 2 then
					ll_Category = This.GetItemNumber(Row,'category',Primary!,true)
					This.Post SetItem(Row,'category',ll_Category)
					This.Post SetItemStatus(Row,'category',Primary!,NotModified!)
					Return
				end if
			end if
		end if
		//---------------------------- APPEON END ----------------------------
		
		//-----------------Begin Added by Alfee 09.30.2007--------------------
		//<$Reason>Check contract access right to the current category 
		Long ll_cnt, ll_found
		IF Not IsNull(data) and data <> '-777' THEN
			IF IsValid(gw_contract) THEN 
				//ll_cnt = gw_contract.tab_contract_details.tabpage_search.ids_contract_access_category.RowCount() //01.19.2008
				ll_cnt = gw_contract.tab_contract_details.tabpage_search.ids_contract_access_category.Retrieve(gs_user_id)	
				IF ll_cnt > 0 THEN ll_found = gw_contract.tab_contract_details.tabpage_search.ids_contract_access_category.Find("category = " + data, 1, ll_cnt)
			END IF	
			IF NOT ll_found > 0 THEN
				//Added By mark 04/13/12 
//				MessageBox("Contract Logix","You don't have full access to the new category, hence the change will not be made!")
				MessageBox(gnv_app.iapp_object.DisplayName,"You don't have permission or full access to add records to this category. ~r~nNo data will be saved.")
				RETURN 2 //reject changes and allow focus changed
			END IF
		END IF
		//------------------End Added ----------------------------------------		
		
       inv_contract_details.of_set_contact_type(long(data)) 
			
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 07.25.2006 By: Liang QingShi
		//$<reason> Contract module modification
		string ls_data
		ls_data = data
		If isnull(ls_data) Then ls_data = '0'
		If ls_data <> '-777' Then
			Post of_change_screen() //Added By Ken.Guo 10/19/2011.  Added Post keyword.
			Post of_AutoDataFill(0,il_ScreenId,dwo.name,row,data) //Added By Ken.Guo 05/21/2012. Need Auto Data Fill again after change screen.
		End If
	//---------------------------- APPEON END ----------------------------
	//Begin - Added By Mark Lee 12/07/2012
	If Row > 0   then
		ldwis_RowStatus = This.GetItemStatus(Row,0,Primary!)
		ldwis_ColStatus = This.GetItemStatus(Row,'category',Primary!)
		If ((ldwis_RowStatus = NotModified! or ldwis_RowStatus = DataModified!) and ldwis_ColStatus = NotModified! ) Or ldwis_ColStatus = DataModified! then
			If gnv_data.of_getitem('icred_settings' ,'sync_category' , False ) = '1' Then
				ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,'Do you want the system to synchronize the Document Category with this Category if they are different?',Question!,YesNo!)																	
				If ll_Rtn = 1 Then 
					ibn_sync_category = True
				End If
			End If
		End If
	End If
	//End - Added By Mark Lee 12/07/2012

end choose

of_Set_Title( )

Post Event ue_Post_ItemChanged(row, dwo.name,Data)

end event

event pfc_addrow;// OVERRIDE





RETURN SUCcess
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;if this.rowcount( ) = 1 then
	return failure
end if 

//Add by jervis 11.13.2009
datawindowchild ldwc_child
this.Modify("Category.dddw.name = 'd_dddw_user_access_category'")
this.GetChild( "category",ldwc_child)
ldwc_child.SetTransobject( sqlca)
if ldwc_child.Retrieve( gs_user_id) < 1 then ldwc_child.Insertrow( 0)

//Added By Ken.Guo 03/12/2012. 
//replace the words lookup code with the field label
Long ll_find
String ls_lable
ll_find = ldwc_child.find("lookup_code = -777", 1, ldwc_child.rowcount())
If ll_find > 0 Then 
	ls_lable = This.Describe("category_t.text")
	if ls_lable <> '!' and ls_lable <> '?' then
		ldwc_child.setitem(ll_find,"code","*Add " + ls_lable + "*")
		ldwc_child.setitem(ll_find,"description","*Add " + ls_lable + "*")
	end if
end if


////Add by jervis 12.03.2010
//this.Modify("app_facility.dddw.name = 'dddw_contact_company_new'")
//this.GetChild( "app_facility",ldwc_child)
//ldwc_child.SetTransobject( sqlca)
//if ldwc_child.Retrieve( gs_user_id) < 1 then ldwc_child.Insertrow( 0)


return success
end event

event updateend;call super::updateend;//////////////////////////////////////////////////////////////////////////
// set the contract staus
////////////////////////////////////////////////////////////////////////
if rowsupdated > 0 or rowsinserted > 0 then
		inv_contract_details.is_contract_status =  inv_base.of_getitem( 1, 'status')
      iw_parent.FUNCTION DYNAMIC	wf_manage_tabs(TRUE)
		inv_contract_details.is_mode = inv_contract_details.Edit //Added By Ken.Guo 2008-10-22. Set to Edit Status after saved.
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.22.2008 By: Ken.Guo
//$<reason> Set all tabpages's Retrieved Status to false after inserted and saved.
If rowsinserted > 0 Then
	iw_parent.Function Dynamic wf_reset_retrieved() 
End If
//---------------------------- APPEON END ----------------------------

if rowsdeleted  > 0 then 
  iw_parent.FUNCTION DYNAMIC	wf_manage_tabs(false)
end if 

ib_just_saved = false 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.02.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.
ib_new = false
iw_parent.function dynamic wf_set_select('tabpage_search',False) 	//Add by Jack 06/11/2007

if dw_contract_dates.rowcount() <=0 then return

string ls_version_number,ls_version_number_old
datetime ldt_version_date
long ll_ctx_id,ll_version_id

ls_version_number = dw_contract_dates.object.version_number[1]
ldt_version_date = dw_contract_dates.object.version_date[1]

If isnull(ls_version_number) or ls_version_number = '' Then
	is_version_number = ls_version_number
	dw_contract_dates.object.version_number[1] = '1.0'
	ls_version_number = '1.0'
End If
If isnull(ldt_version_date) Then
	dw_contract_dates.object.version_date[1] = datetime(today())
	ldt_version_date = datetime(today())
End If

ll_ctx_id = dw_contract_dates.object.ctx_id[1]
ls_version_number_old = is_version_number

If isnull(ls_version_number_old) Then ls_version_number_old = ''

If ls_version_number <> ls_version_number_old Then
	datastore lds_version_number
	integer li_rowcount,li_find
	
	lds_version_number = Create datastore
	lds_version_number.dataobject = 'd_version_number'
	lds_version_number.settransobject(sqlca)
	li_rowcount = lds_version_number.retrieve(ll_ctx_id)
	
	If li_rowcount > 0 Then
		li_find = lds_version_number.find("version_number = " + "'" + ls_version_number + "'",1,li_rowcount)
		If li_find <=0 Then
			ll_version_id = li_rowcount + 1
		End If
	Else
		ll_version_id = 1
	End If
	Destroy lds_version_number
	If ll_version_id > 0  Then
		INSERT INTO ctx_version VALUES (:ll_ctx_id,:ll_version_id,:ls_version_number,:ldt_version_date,:gs_user_id,:ls_version_number_old,:ls_version_number);
//			inv_audit.of_audit_fields(tab_contract_details.tabpage_details.uo_1.dw_contract_dates)
	End If
	is_version_number = ls_version_number
End If
ib_retrieved = true
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.19.2006 By: LeiWei
//$<reason> Fix a defect.
of_set_title()
//---------------------------- APPEON END ----------------------------

of_StatusAudit()				//Added by Scofield on 2008-05-22

return success

end event

event clicked;call super::clicked;//choose case dwo.name
//	case 'product_name'
//		open(w_products)
//	end choose
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: LeiWei
//$<reason> The follwing script moved from itemchanged event.
str_pass lstr_pass
String ls_column_name
string ls_facility_name
datawindowchild ldwc_child
long ll_row,ll_RowCnts,ll_Cycle

ls_column_name = GetColumnName()

////----------Begin Added by Alfee 09.26.2007 -------------------------------
////<$Reason>Set Date Alarm buttons according to contract status - new requirement
//String ls_status_active, ls_status_pending
//IF ls_column_name = 'status' THEN
//	ls_status_active = gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Status' and code = 'ACTIVE'")
//	ls_status_pending = gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Status' and code = 'PENDING'")
//	IF data = ls_status_pending or data = ls_status_active THEN
//		of_set_buttons(TRUE)
//	ELSe
//		of_set_buttons(FALSE)
//	END IF
//END IF
////----------End Added ------------------------------------------------------

IF ls_column_name = 'category' and dw_1.getrow() > 0 THEN
	this.event pfc_postinsertrow( row)					//Added By Mark Lee 05/24/2013
End If

IF ls_column_name = "app_facility" THEN
	IF data = "-1" THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.29.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		OpenWithParm(w_app_facility,lstr_pass)
		*/
		lstr_pass.s_string = 'Company'
		OpenWithParm ( w_contract_contact, lstr_pass)
		//---------------------------- APPEON END ----------------------------
	   If message.doubleparm > 0 Then 
			il_app_facility = message.doubleparm
			
			//Delete Old Data //Added By Ken.Guo 02/27/2012. 
			If isnull(il_app_facility_old) or il_app_facility_old <> il_app_facility Then
				ll_RowCnts = dw_ccc.RowCount()
				For ll_Cycle = ll_RowCnts To 1 Step -1
					dw_ccc.DeleteRow(ll_Cycle)
				Next		
			End If
			
			il_app_facility_old = il_app_facility
			//Add company data to dddw  - jervis 12.13.2010
			if this.GetChild( ls_column_name,ldwc_child) = 1 then
				ls_facility_name = gnv_data.of_GetItem( "ctx_facility", "facility_name", "facility_id = " + string(il_app_facility))
				ll_row = ldwc_child.InsertRow( 1)
				ldwc_child.SetItem( ll_row,"facility_id", il_app_facility)
				ldwc_child.SetItem( ll_row,"facility_name", ls_facility_name)
			end if
         	this.setitem(1,"app_facility", il_app_facility)
	
			of_add_contract_contact(il_app_facility)				//Added by Scofield on 2007-11-01
	   Else
         	this.setitem(1,"app_facility", il_app_facility_old)
			of_add_contract_contact(il_app_facility_old)			//Added by Scofield on 2007-11-01
      End If	
	Else
	 	il_app_facility = Long(data)
		il_app_facility_old = il_app_facility
	END IF
END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.12.2007 By: Jack (Contract)
//$<reason> 
long ll_ctx_id,ll_master_contract_id,ll_category
string ls_master_contract_name,ls_company          // add by Jack 03/21/2007
//If ls_column_name = 'master_contract_id' Then    //Comment by Jack 03/21/2007 
If ls_column_name = 'master_contract_name' Then    //add by Jack 03/21/2007
   If data = '1' Then
	   ll_ctx_id = This.getitemnumber(This.getrow(),'ctx_id')
	   ll_category = This.getitemnumber(This.getrow(),'category')
		If isnull(ll_ctx_id) Then ll_ctx_id = 0
		If isnull(ll_category) Then ll_category = 0
		ls_company = this.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(1)+" )")
		
	   OpenWithParm(w_mastert_contract_search,string(ll_ctx_id) + '-' + string(ll_category) + '+' + ls_company)
//	   ll_master_contract_id = message.doubleparm    //Comment by Jack 03/21/2007
	   ls_master_contract_name = message.stringparm  //add by Jack 03/21/2007
		ll_master_contract_id = long(mid(ls_master_contract_name,1,pos(ls_master_contract_name,'-') - 1))  //add by Jack 03/21/2007
	   If ll_master_contract_id > 0 Then
		   This.setitem(This.getrow(),'master_contract_id',ll_master_contract_id)
		   This.setitem(This.getrow(),'master_contract_name',ls_master_contract_name) //add by Jack 03/21/2007
			il_master_contract_id = ll_master_contract_id      								//add by Jack 03/21/2007
			is_master_contract_name = ls_master_contract_name  								//add by Jack 03/21/2007
		Else
		   This.setitem(This.getrow(),'master_contract_id',il_master_contract_id)			
		   This.setitem(This.getrow(),'master_contract_name',is_master_contract_name) //add by Jack 03/21/2007
	   End If
	Else
		il_master_contract_id = 0																		//add by Jack 03/21/2007
		is_master_contract_name = ''																	//add by Jack 03/21/2007
		This.setitem(This.getrow(),'master_contract_id',il_master_contract_id)		   //add by Jack 03/21/2007			
   End If
End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.22.2006 By: Liang QingShi
//$<reason> Contract module modification
if data = '-777' then 
	of_change_screen()	
end if 
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.05.2007 By: Jack
//$<reason> Fix a defect.
if this.GetRow() > 0 then gl_Company_id = This.getitemnumber(this.getrow(), 'app_facility')
//---------------------------- APPEON END ----------------------------

//---------------Begin Added by Alfee 09.30.2007----------------------
//<$reason>Add contract category access control for adding lookup data operation
Long ll_cnt, ll_found, ll_null
SetNull(ll_null)
IF data = '-777' and ls_column_name = 'category' and dw_1.getrow() > 0 THEN
	ll_category = dw_1.GetItemNumber(dw_1.getrow(), 'category')
	IF Not IsNull(ll_category) and ll_category <> -777 THEN
		IF IsValid(gw_contract) THEN 
			//ll_cnt = gw_contract.tab_contract_details.tabpage_search.ids_contract_access_category.RowCount() //Alfee 01.19.2008
			ll_cnt = gw_contract.tab_contract_details.tabpage_search.ids_contract_access_category.Retrieve(gs_user_id)
			IF ll_cnt > 0 THEN ll_found = gw_contract.tab_contract_details.tabpage_search.ids_contract_access_category.Find("category = " + String(ll_category), 1, ll_cnt)
		END IF	
		IF NOT ll_found > 0 THEN
			//Added By mark 04/13/12
//			MessageBox("Contract Logix","You don't have full access to the new category, hence the change will not be made!")
			MessageBox("IntelliContract","You don't have permission or full access to add records to this category. ~r~nNo data will be saved.") //(Appeon)Harry 03.10.2014 - V142 ISG-CLX modify "Contract Logix" to "IntelliContract"
			dw_1.SetItem(dw_1.getrow(), 'category', ll_null)
		END IF
	END IF
END IF
//---------------End Added -------------------------------------------

//Added By Ken.Guo 03/12/2012.  refresh DDDW data on search screen.
//If (data = '-777' and ls_column_name = 'category' ) Then
//	ib_added_code_lookup = True
//End If	
	
If (data = '-1' and ls_column_name = 'app_facility') Then
	ib_added_code_lookup = True
End If

end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.21.2006 By: LeiWei
//$<reason> Fix a defect.
//------Begin Modified by Alfee 02.26.2008 -------------
//<$Reason>for date alarm enhancement
//gnv_data.of_retrieve( "ctx_notification" )
//gnv_appeondb.of_startqueue( )//modified by gavins 20121227
//gnv_data.of_retrieve( "ctx_notification" )
//gnv_data.of_retrieve( "ctx_ai_notification")
//gnv_data.of_retrieve( "ctx_am_ai_notification")
//gnv_appeondb.of_commitqueue( )
////------End Modified -----------------------------------
//of_set_flags()

//Added for Work Flow trigger. 11.21.2006 Henry
//long	 ll_screen_id[]
//long	 ll_ctx_id
integer li_getrow//Rodger Wu added.

li_getrow = this.GetRow()//Rodger Wu added.
if li_getrow < 1 then RETURN success//Rodger Wu added.



//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.13.2006 By: Jervis
//$<reason> Move to u_tabpe_contract_detail1.pfc_postupdate() event
/*
ll_ctx_id = this.getitemnumber( li_getrow, "ctx_id")
if not ll_ctx_id > 0 Then RETURN success
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	
	ll_screen_id[1] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_master'"))
	ll_screen_id[2] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_contract_dates' and dataobject='d_contract_det_master_2'"))
	ll_screen_id[3] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_notes'"))
	ll_screen_id[4] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_custom'"))
	
	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_ctx_id, 0, '03', 'I')
	Destroy lnv_workflow
End If
*/
//---------------------------- APPEON END ----------------------------



RETURN success
//---------------------------- APPEON END ----------------------------

end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item disabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
end if

end event

event pfc_update;call super::pfc_update;is_Refresh_Alarm = '1' //added by gavins 20121227
Return 1
end event

type dw_contract_dates from u_dw_contract within u_tabpg_contract_detail1
event key pbm_dwnkey
string tag = "Contract Dates"
integer x = 1070
integer y = 16
integer width = 2789
integer height = 456
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Contract Dates"
boolean ib_isupdateable = false
string dataobject_original = "d_contract_det_master_2"
end type

event constructor;call super::constructor;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.03.2006 By: Liang QingShi
//$<reason> Contract module modification
dw_contract_dates.event ue_populatedddws( )
this.of_setupdateable( false)
//---------------------------- APPEON END ----------------------------

this.of_SetDropDownCalendar(TRUE)

of_enable_alarm(TRUE)//for alarm message by alfee 09.05.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: LeiWei
//$<reason> Performance tuning.
/*
this.iuo_calendar.of_Register("effective_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("expriation_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("review_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("term_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("last_revis_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("other_date_1", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("other_date_2", this.iuo_calendar.DDLB_WITHARROW	)
*/
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 08.09.2006 By: Liang QingShi
//$<reason> Contract module modification
/*
insertrow(0)
*/
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.11.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> The following script moved to editchanged event.
//inv_cst_notification = create n_cst_notification  
//---------------------------- APPEON END ----------------------------
end event

event dropdown;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: Override the ancestor script. PFC calaender does not work with datawindow with title bar
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 July 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Long  ll_rtn 
Boolean lb_titlebar 


lb_titlebar = TitleBar 
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 03.16.2006 By: LeiWei
//$<reason> Fix a defect.
//If lb_titlebar Then TitleBar = FALSE 
//---------------------------- APPEON END ----------------------------
SetRedraw ( FALSE ) 
ll_rtn = Super::Event dropdown() 
If lb_titlebar Then TitleBar = TRUE 
SetRedraw ( TRUE ) 
Return ll_rtn
end event

event pfc_addrow;

// OVERRIDE
return success
end event

event buttonclicked;call super::buttonclicked;
str_pass lstr_pass 
string ls_statement1
string ls_statement2
string ls_title, ls_ColName
Long	ll_ctx_id


ls_statement1 = 'The field '
ls_statement2 = ' is missing a value. Please enter a date and try again.'
//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//ls_title = 'Missing Infomation'
ls_title = 'Missing Information'  //(Appeon)Harry 10.30.2013 - V141 ISG-CLX  for V14 Testing - Bug # 3720:modify 'Missing Infomation' to 'Missing Information'
//---------End Modfiied ------------------------------------------------------


accepttext()

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 

if not f_validstr(string(this.getItemNumber(1,'ctx_id'))) then
	IF iw_parent.EVENT DYNAMIC UE_SAVE() <> SUCcess THEN RETURN  
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.10.2006 By: Rodger Wu
//$<reason> Fix a defect.

/*
choose case dwo.name
	case 'b_effective_date'
			
		if of_show_missing_msg( 'effective_date', this,'date',1) = success then
		   lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
		   lstr_pass.s_string_array[2] = 'ctx_basic_info'
		   lstr_pass.s_string_array[3] = 'effective_date'
		   lstr_pass.s_string_array[4] =  this.object.effective_date_t.text 
		   openwithparm(w_ctx_alarm, lstr_pass)
		
	end if 
	case	'b_expriation_date'
		
		if of_show_missing_msg( 'expriation_date', this,'date',1) = success then
			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
			lstr_pass.s_string_array[2] = 'ctx_basic_info'
			lstr_pass.s_string_array[3] = 'expriation_date'
			lstr_pass.s_string_array[4] =  this.object.expriation_date_t.text 
			openwithparm(w_ctx_alarm, lstr_pass)
	  end if 
		
   case	'b_review_date'
		if of_show_missing_msg( 'review_date', this,'date',1) = success then
				lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
				lstr_pass.s_string_array[2] = 'ctx_basic_info'
				lstr_pass.s_string_array[3] = 'review_date'
				lstr_pass.s_string_array[4] =  this.object.review_date_t.text 
				openwithparm(w_ctx_alarm, lstr_pass)
	  end if 
   case	'b_other_date_1'
		if of_show_missing_msg( 'other_date_1', this,'date',1) = success then
			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
			lstr_pass.s_string_array[2] = 'ctx_basic_info'
			lstr_pass.s_string_array[3] = 'other_date_1'
			lstr_pass.s_string_array[4] =  this.object.other_date_1_t.text 
			openwithparm(w_ctx_alarm, lstr_pass)
		end if 
		
   case	'b_term_date'
		if of_show_missing_msg( 'term_date', this,'date',1) = success then
			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
			lstr_pass.s_string_array[2] = 'ctx_basic_info'
			lstr_pass.s_string_array[3] = 'term_date'
			lstr_pass.s_string_array[4] =  this.object.term_date_t.text 
			openwithparm(w_ctx_alarm, lstr_pass)
	 end if
	 
   case	'b_other_date_2'
		if of_show_missing_msg( 'other_date_2', this,'date',1) = success then
			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
			lstr_pass.s_string_array[2] = 'ctx_basic_info'
			lstr_pass.s_string_array[3] = 'other_date_2'
			lstr_pass.s_string_array[4] =  this.object.other_date_2_t.text 
			openwithparm(w_ctx_alarm, lstr_pass)
	    end if
	 case	'b_last_revis_date'
	      if of_show_missing_msg( 'last_revis_date', this,'date',1) = success then
				lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
				lstr_pass.s_string_array[2] = 'ctx_basic_info'
				lstr_pass.s_string_array[3] = 'last_revis_date'
				lstr_pass.s_string_array[4] =  this.object.other_date_2_t.text 
				openwithparm(w_ctx_alarm, lstr_pass)
		   end if
	 
	 
end choose
*/

string ls_datatype, ls_dwoname

ls_dwoname = lower( dwo.name )
if left( ls_dwoname , 2 ) = "b_" then
	ls_datatype = This.Describe( Right(ls_dwoname, Len(ls_dwoname) - 2 ) + ".ColType" )
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.26.2007 By: Jack
//$<reason> Fix a defect.
If isnull(string(inv_contract_details.of_get_ctx_id( ))) or string(inv_contract_details.of_get_ctx_id( )) = '' Then Return
//---------------------------- APPEON END ----------------------------

//--------Begin Added by Alfee 09.27.2007-----------------------------
//Return if the alarm disabled to the current contract stauts
String ls_contract_status, ls_alarm_enabled, ls_msg

IF Lower(ls_datatype) = 'datetime' THEN
	IF dw_1.RowCount() > 0 THEN ls_contract_status = String(dw_1.GetItemNumber(1, 'status'))
	IF NOT IsNull(ls_contract_status) THEN ls_alarm_enabled = gnv_data.of_getitem('code_lookup','custom_1',"lookup_name = 'Contract Status' and lookup_code = " + ls_contract_status)
	IF Upper(ls_alarm_enabled) <> 'YES' THEN
		ls_msg = "Alarms can't be set because the Contract Status you have selected has the Alarmed Enabled flag set to No.  "
		ls_msg +="To change this setting go to the System->Lookup Painter and select the Contract Status lookup table and change the Alarms Enabled Flag to Yes." 
		MessageBox("Contract Alarms", ls_msg)
		RETURN
	END IF
	
	//Added By Ken.Guo 2010-01-07.
	If ib_new Then
		Messagebox('Contract Alarms','Please save the contract before you add date alarm.')
		Return 
	End If
	//Added by gavins 20120401
	ls_ColName = Mid(dwo.Name,3)
	This.SetColumn(ls_ColName)
	if Of_Show_Missing_Msg(ls_ColName, This,ls_datatype,1) = SUCCESS then
		ll_ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_pass.s_string_array[1] = String(ll_ctx_id)
		lstr_pass.s_string_array[2] = 'ctx_basic_info'
		lstr_pass.s_string_array[3] = ls_ColName
		lstr_pass.s_string_array[4] = This.Describe(ls_ColName + "_t.Text")
		lstr_pass.s_string_array[5] = '0'
		lstr_pass.s_string_array[6] = '0'
		lstr_pass.s_string_array[7] = '0'
		lstr_pass.s_datetime[1] = this.GetItemDateTime( row, ls_ColName)
		OpenWithParm(w_ctx_alarm, lstr_pass)
		This.SetColumn(ls_ColName)
	end if
END IF

If dwo.Name =	'b_version_number' Then
	ll_ctx_id = dw_1.getitemnumber(dw_1.getrow(),'ctx_id')
	if ll_ctx_id > 0 then
		openwithparm(w_contract_version, ll_ctx_id)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 05.06.2007 By: Jack
		//$<reason> Fix a defect.
		this.setcolumn('version_number')
		//---------------------------- APPEON END ----------------------------
	end if
End If

//--------End Added --------------------------------------------------
//modified by gavins 20120401
//choose case dwo.name
//	case 'b_effective_date'
//			
//		if of_show_missing_msg( 'effective_date', this,ls_datatype,1) = success then
//		   lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//		   lstr_pass.s_string_array[2] = 'ctx_basic_info'
//		   lstr_pass.s_string_array[3] = 'effective_date'
//		   lstr_pass.s_string_array[4] =  this.object.effective_date_t.text 
//			lstr_pass.s_string_array[5] = '0'
//			lstr_pass.s_string_array[6] = '0'
//			lstr_pass.s_string_array[7] = '0'
//			lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "effective_date")
//		
//		   openwithparm(w_ctx_alarm, lstr_pass)
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 05.06.2007 By: Jack
//			//$<reason> Fix a defect.
//			this.setcolumn('effective_date')
//			//---------------------------- APPEON END ----------------------------
//
//	end if 
//	case	'b_expriation_date'
//		
//		if of_show_missing_msg( 'expriation_date', this,ls_datatype,1) = success then
//			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//			lstr_pass.s_string_array[2] = 'ctx_basic_info'
//			lstr_pass.s_string_array[3] = 'expriation_date'
//			lstr_pass.s_string_array[4] =  this.object.expriation_date_t.text 
//			lstr_pass.s_string_array[5] = '0'
//			lstr_pass.s_string_array[6] = '0'
//			lstr_pass.s_string_array[7] = '0'
//			lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "expriation_date")
//			openwithparm(w_ctx_alarm, lstr_pass)
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 05.06.2007 By: Jack
//			//$<reason> Fix a defect.
//			this.setcolumn('expriation_date')
//			//---------------------------- APPEON END ----------------------------
//	  end if 
//		
//   case	'b_review_date'
//		if of_show_missing_msg( 'review_date', this,ls_datatype,1) = success then
//			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//			lstr_pass.s_string_array[2] = 'ctx_basic_info'
//			lstr_pass.s_string_array[3] = 'review_date'
//			lstr_pass.s_string_array[4] =  this.object.review_date_t.text 
//			lstr_pass.s_string_array[5] = '0'
//			lstr_pass.s_string_array[6] = '0'
//			lstr_pass.s_string_array[7] = '0'
//			lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "review_date")
//			openwithparm(w_ctx_alarm, lstr_pass)
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 05.06.2007 By: Jack
//			//$<reason> Fix a defect.
//			this.setcolumn('review_date')
//			//---------------------------- APPEON END ----------------------------
//	  end if 
//   case	'b_other_date_1'
//		if of_show_missing_msg( 'other_date_1', this,ls_datatype,1) = success then
//			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//			lstr_pass.s_string_array[2] = 'ctx_basic_info'
//			lstr_pass.s_string_array[3] = 'other_date_1'
//			lstr_pass.s_string_array[4] =  this.object.other_date_1_t.text 
//			lstr_pass.s_string_array[5] = '0'
//			lstr_pass.s_string_array[6] = '0'
//			lstr_pass.s_string_array[7] = '0'
//			lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "other_date_1")
//			openwithparm(w_ctx_alarm, lstr_pass)
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 05.06.2007 By: Jack
//			//$<reason> Fix a defect.
//			this.setcolumn('other_date_1')
//			//---------------------------- APPEON END ----------------------------
//		end if 
//		
//   case	'b_term_date'
//		if of_show_missing_msg( 'term_date', this,ls_datatype,1) = success then
//			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//			lstr_pass.s_string_array[2] = 'ctx_basic_info'
//			lstr_pass.s_string_array[3] = 'term_date'
//			lstr_pass.s_string_array[4] =  this.object.term_date_t.text 
//			lstr_pass.s_string_array[5] = '0'
//			lstr_pass.s_string_array[6] = '0'
//			lstr_pass.s_string_array[7] = '0'
//			lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "term_date")
//			openwithparm(w_ctx_alarm, lstr_pass)
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 05.06.2007 By: Jack
//			//$<reason> Fix a defect.
//			this.setcolumn('term_date')
//			//---------------------------- APPEON END ----------------------------
//	 end if
//	 
//   case	'b_other_date_2'
//		if of_show_missing_msg( 'other_date_2', this,ls_datatype,1) = success then
//			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//			lstr_pass.s_string_array[2] = 'ctx_basic_info'
//			lstr_pass.s_string_array[3] = 'other_date_2'
//			lstr_pass.s_string_array[4] =  this.object.other_date_2_t.text 
//			lstr_pass.s_string_array[5] = '0'
//			lstr_pass.s_string_array[6] = '0'
//			lstr_pass.s_string_array[7] = '0'
//			lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "other_date_2")
//			openwithparm(w_ctx_alarm, lstr_pass)
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 05.06.2007 By: Jack
//			//$<reason> Fix a defect.
//			this.setcolumn('other_date_2')
//			//---------------------------- APPEON END ----------------------------
//	    end if
//	 case	'b_last_revis_date'
//		if of_show_missing_msg( 'last_revis_date', this,ls_datatype,1) = success then
//			lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//			lstr_pass.s_string_array[2] = 'ctx_basic_info'
//			lstr_pass.s_string_array[3] = 'last_revis_date'
//			//lstr_pass.s_string_array[4] =  this.object.other_date_2_t.text 
//			lstr_pass.s_string_array[4] =  this.object.last_revis_date_t.text //Alfee 06.27.2008
//			lstr_pass.s_string_array[5] = '0'
//			lstr_pass.s_string_array[6] = '0'
//			lstr_pass.s_string_array[7] = '0'
//			lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "last_revis_date")
//			openwithparm(w_ctx_alarm, lstr_pass)
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 05.06.2007 By: Jack
//			//$<reason> Fix a defect.
//			this.setcolumn('last_revis_date')
//			//---------------------------- APPEON END ----------------------------
//		end if
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 07.22.2006 By: Liang QingShi
//	//$<reason> Contract module modification
//				
//	 case	'b_version_number'
//			ll_ctx_id = dw_1.getitemnumber(dw_1.getrow(),'ctx_id')
//			if ll_ctx_id > 0 then
//				openwithparm(w_contract_version, ll_ctx_id)
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<add> 05.06.2007 By: Jack
//				//$<reason> Fix a defect.
//				this.setcolumn('version_number')
//				//---------------------------- APPEON END ----------------------------
//			end if
//	 case	'b_version_date'
//	      if of_show_missing_msg( 'version_date', this,ls_datatype,1) = success then
//				lstr_pass.s_string_array[1] = string(inv_contract_details.of_get_ctx_id( ))
//				lstr_pass.s_string_array[2] = 'ctx_basic_info'
//				lstr_pass.s_string_array[3] = 'version_date'
//				lstr_pass.s_string_array[4] =  this.object.version_date_t.text 
//				lstr_pass.s_string_array[5] = '0'
//				lstr_pass.s_string_array[6] = '0'
//				lstr_pass.s_string_array[7] = '0'
//				lstr_pass.s_datetime[1] = this.GetItemDateTime( row, "version_date")
//				openwithparm(w_ctx_alarm, lstr_pass)
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<add> 05.06.2007 By: Jack
//				//$<reason> Fix a defect.
//				this.setcolumn('version_date')
//				//---------------------------- APPEON END ----------------------------
//		   end if
//	//---------------------------- APPEON END ----------------------------
//	 
//end choose
//---------------------------- APPEON END ----------------------------

iw_parent.function dynamic of_set_validation(True) // Add by Jack 05/04/2007

of_set_flags( )
end event

event editchanged;call super::editchanged;//----------Begin Modified by Alfee 09.06.2007-------------------------------------
//<$Reason>If clear out a date field, then clear out the alarm setting too.
string colname 
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" then
	if len(data) > 0 then return
	event rbuttondown(1, 1, row, dwo)
end if

/*date ld_null
setnull(ld_null)
choose case dwo.name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 07.22.2006 By: Liang QingShi
	//$<reason> Contract module modification 
	/*
	case 'effective_date','expriation_date','review_date','other_date_1','term_date','other_date_2'
	*/
	case 'effective_date','expriation_date','review_date','other_date_1','term_date','other_date_2','version_number','version_date'
	//---------------------------- APPEON END ----------------------------
		if len(data) < 1  then 
			setItem(1, string(dwo.name), ld_null)
			if f_set_flag('ctx_basic_info',dwo.name, inv_contract_details.of_get_ctx_id( ) ) = 'greenflag.bmp' then
				messagebox(iw_parent.title, 'The alarm will be disabled for ' + string(THIS.INV_base.OF_GETcolumndisplayname( string(dwo.name))))
				//--------------------------- APPEON BEGIN ---------------------------
				//$<add> 09.11.2006 By: LeiWei
				//$<reason> Performance tuning.
				//$<modification> The following scripts moved from constructor event.
				IF NOT Isvalid(inv_cst_notification) THEN
					inv_cst_notification = create n_cst_notification  
				END IF
				//---------------------------- APPEON END ----------------------------
				inv_cst_notification.of_disable_alarm('ctx_notification',dwo.name)
			end if
		end if 
	case else 
	//
end choose*/
//----------------End Modified -----------------------------------------------------
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;



if this.rowcount( ) = 1 then
	return failure
end if 


return success
end event

event pfc_retrieve;call super::pfc_retrieve;

THIS.RETRieve( inv_contract_details.of_get_ctx_id( ) )

RETURN SUCcess
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;event ue_populatedddws( )
end event

event pfc_deleterow;// Override

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.14.2006 By: LeiWei
//$<reason> Fix a defect.

RETURN dw_1.event pfc_deleterow()

//---------------------------- APPEON END ----------------------------


end event

event pfc_postupdate;call super::pfc_postupdate;////Added for Work Flow trigger. 11.21.2006 Henry
//long	 ll_screen_id
//long	 ll_ctx_id
//
//ll_ctx_id = this.getitemnumber( this.GetRow(), "ctx_id")
//if not ll_ctx_id > 0 Then RETURN success
//
//ll_screen_id = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_contract_dates' and dataobject='d_contract_det_master_2'"))
//If gb_workflow Then
//	n_cst_workflow_triggers lnv_workflow
//	lnv_workflow = create n_cst_workflow_triggers
//	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_ctx_id, 0, '03', 'I')
//	Destroy lnv_workflow
//End If
////End added 11.21.2006
return 1
end event

event rbuttondown;call super::rbuttondown;
inv_contract_details.of_reset_alarm( this,'ctx_basic_info',dwo) //jervis 07.04.2011
/*
comment by jervis -- 07.04.2011
//Added by Alfee 09.05.2007
//<$Reason>If a user clears a date then the alarm for that date should also be cleared out.
	
long ll_ctxid, ll_row, ll_cnt, ll_found, ll_wf_id
string colname, ls_msg, ls_filename
boolean lb_alarm = TRUE //01.26.2008
boolean lb_refresh_ai = FALSE //12.09.2008
boolean lb_del_wf_ai = FALSE //12.09.2008

DataStore lds_wf_triggered 

colname = dwo.name

if this.Describe("DataWindow.ReadOnly") = "yes" or this.Describe(colname + ".protect") <> "0" or this.Describe(colname + ".TabSequence") = "0" then return

if this.Describe( colname + ".ColType") = "datetime" then
	if Not IsNull(This.GetItemDateTime(getrow(), colname) ) then return

	ll_ctxid = inv_contract_details.of_get_ctx_id( )

	//lb_alarm = (f_set_flag('ctx_basic_info', colname, ll_ctxid) <> 'grayflag.bmp') - commented 01.26.2008

	//ls_msg = "Would you like to set this Date to null?"
	//if lb_alarm then ls_msg += "~r~nIf yes, the alarm setting for this field will also be cleared out." 

	//-------------Begin Added by Alfee on 12.09.2008 ----------------------------
	//Update current action items if modified 	
	IF gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.modifiedcount( ) > 0 OR &
		gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.deletedcount( ) > 0 THEN
		gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.event pfc_update(true, false)
	END IF
	
	//Checking if action items need to be refreshed
	IF gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.rowcount( ) > 0 OR &
		gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.FilteredCount( ) > 0 OR & 
		gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.DeletedCount( ) > 0 THEN
		lb_refresh_ai = TRUE
	END IF	
	
	//Checking if there are any action items from workflow need to be deleted
	lds_wf_triggered = Create DataStore
	lds_wf_triggered.Dataobject = 'd_alm_wf_triggered'
	lds_wf_triggered.SetTransObject(SQLCA)
	ll_cnt = lds_wf_triggered.Retrieve(ll_ctxid)

	ll_found = lds_wf_triggered.Find("Lower(alm_column) = '" + Lower(colname) + "'", 1, ll_cnt)
	IF ll_found > 0 THEN ll_wf_id = lds_wf_triggered.GetItemNumber(ll_found, "wf_id")
	IF ll_wf_id > 0 AND NOT lds_wf_triggered.Find("wf_id = " + String(ll_wf_id) + " AND Lower(alm_column) <> '" + Lower(colname) + "'",1, ll_cnt) > 0 THEN
		lb_del_wf_ai = TRUE
	END IF	
	Destroy lds_wf_triggered
	//--------------End Added ----------------------------------------------------

	//Delete the alarm setting if it's existed.
	if lb_alarm then 
		SetPointer(HourGlass!)
		gnv_appeondb.of_startqueue()
		delete from ctx_notification_users where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;
		delete from ctx_alarm_attachment where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;	//Added by Scofield on 2009-02-24
		delete from ctx_notification where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;
		delete from ctx_action_items where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;  		//alfee 12.09.2008	
		delete from ctx_alm_snooze   where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ; 		//Added By Ken.Guo 2009-09-16.
		IF lb_del_wf_ai THEN 
			delete from ctx_action_items where ctx_id = :ll_ctxid and wf_id = :ll_wf_id ; //alfee 12.09.2008
		END IF
		gnv_appeondb.of_commitqueue()
		if sqlca.sqlcode = 0 then 
			ls_msg = "lower(alm_table) = 'ctx_basic_info' and upper(alm_column) = '" + upper(colname) + "' "
			ls_msg +=" and ctx_id = " + String(ll_ctxid)
			ll_row = gnv_data.ids_ctx_notification.Find(ls_msg, 1, gnv_data.ids_ctx_notification.Rowcount())	
			if ll_row > 0 then gnv_data.ids_ctx_notification.DeleteRow(ll_row)
		end if

		//Refresh action items if needed - alfee 12.09.2008
		IF lb_refresh_ai THEN 
			gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.of_retrieve() 
		END IF
		
		//Reset the flag for the button	
		ls_filename = f_set_flag('ctx_basic_info', colname, ll_ctxid,0,0,0)  //jervis 07.04.2011
 		this.modify("b_"+ colname + ".FileName ='" + ls_filename + "'")
	end if		
end if		

*/

end event

event rbuttonup;//
end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item disabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
end if

end event

event ue_post_itemchanged;call super::ue_post_itemchanged;

//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_ctx_id
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
ll_ctx_id = inv_contract_details.of_get_ctx_id()
If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_basic_info', dwoname,ll_ctx_id, 0,0,0)
	End If
End If


end event

type st_vbar from u_st_splitbar within u_tabpg_contract_detail1
boolean visible = false
integer x = 1051
integer width = 18
integer height = 2020
integer weight = 700
fontcharset fontcharset = ansi!
end type

event constructor;call super::constructor;this.of_SetMinobjectsize( 600)			

end event

type cb_max from commandbutton within u_tabpg_contract_detail1
boolean visible = false
integer x = 3771
integer y = 1348
integer width = 87
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+"
end type

event clicked;Int 					i, j ,li_num,li_cnt, li_upperbound, li_right[], li_tmp
datawindow			ldw_object[], ldw_right[],  ldw_right_order[]
Long 					ll_x, ll_bottom, ll_y,  ll_differ
Boolean				lbn_flag
String 				ls_tag[], ls_tmp[], ls_err
n_cst_string			ln_cst_string

//set default value
li_num = 0 
li_upperbound = 0 
lbn_flag = False
//get the Control objects
li_cnt = UpperBound(Control[])
For i = 1 to li_cnt
	If Control[i].typeof() = datawindow! Then
		If Left(Control[i].Classname(),3) = 'dw_' and Control[i].tag <> 'Custom Data'   Then
			If is_products_visible = 'N' and  Control[i].tag = 'Products' Then 
				Continue
			ENd If 
			If is_contract_dates_visible = 'N' and  Control[i].tag = 'Contract Dates' Then 
				Continue
			ENd If 			
			li_num ++
			ldw_object[li_num] = Control[i]
		End If
	End If
Next

IF li_cnt >  0 and li_num > 0 Then
	//division the right position dws 
	ll_x = st_vbar.x 
	For i = 1 to li_num
		If ldw_object[i].x  > ll_x Then 
			li_upperbound ++
			ldw_right[li_upperbound] = ldw_object[i]
			li_right[li_upperbound] = ldw_object[i].y
		End If
	Next 
	
	IF li_upperbound > 0  Then 
		//set order  for  the right dws
		For i = 1  to li_upperbound
			lbn_flag = False
			For j = li_upperbound  to i + 1 step - 1 
				If li_right[j - 1] > li_right[j] then 
					li_tmp = li_right[j - 1]
					li_right[j - 1] = li_right[j]
					li_right[j] = li_tmp
					lbn_flag = True
				End If
			Next
			If lbn_flag = False Then
				Exit
			End If 
		Next
		
		// clear calssname array				---right
		ls_tag = ls_tmp
		For i = 1 to li_upperbound 
			For j = 1 to li_upperbound 
				If li_right[i] =  ldw_right[j].y  Then 
					// adjust the duplicate Y value
					If i > 1  Then 
						If ln_cst_string.of_isexists(ls_tag, ldw_right[j].tag ) = True then 
							continue
						End If 
					End If 
					ldw_right_order[i] =  ldw_right[j]
					ls_tag[i] = ldw_right[j].tag
					exit
				End If
			Next
		Next
		
		//layout the dw position
		ll_y = 0 
		ll_bottom = tab_1.y + tab_1.height
		li_upperbound = Upperbound(ldw_right_order)		
		IF This.text = '+' THEN
			This.text = '-'
			lbn_flag = True
			ll_y = ldw_right_order[1].y
		Else
			This.text = '+'
			lbn_flag = False		
			ll_y = ldw_right_order[li_upperbound].y + ldw_right_order[li_upperbound].height + 20
		End IF
		
		Parent.Setredraw( False )
		For i = 1 to li_upperbound
			IF lbn_flag = True THEN
				ldw_right_order[i].hide( )
			Else
				ldw_right_order[i].Show( )
			End If
		Next 
		tab_1.y  = ll_y
		tab_1.height = ll_bottom - tab_1.y
		cb_max.y = tab_1.y
		
		tab_1.tabpage_custom.dw_1.y = 15 						//Added By Mark Lee 01/17/2013
		tab_1.tabpage_custom.dw_1.Height = tab_1.tabpage_custom.height - tab_1.tabpage_custom.dw_1.y - 10
		tab_1.tabpage_custom.dw_1.width = tab_1.tabpage_custom.width - tab_1.tabpage_custom.dw_1.x - 10
		tab_1.tabpage_notes.dw_1.accepttext( )
		tab_1.tabpage_notes.dw_1.y = 15 						//Added By Mark Lee 01/17/2013
		tab_1.tabpage_notes.dw_1.width = tab_1.tabpage_notes.width - tab_1.tabpage_notes.dw_1.x - 10			//Added By Mark Lee 03/13/2013
		tab_1.tabpage_notes.dw_1.Height = tab_1.tabpage_notes.height - tab_1.tabpage_notes.dw_1.y - 10
//		tab_1.tabpage_notes.dw_1.Modify( "notes.height = " + String(tab_1.tabpage_notes.dw_1.Height - 30) +&
//		" DataWindow.Detail.Height = " +  String(tab_1.tabpage_notes.dw_1.Height + 30))		
		//Begin - Added By Mark Lee 04/26/2013
		If tab_1.tabpage_notes.dw_1.rowcount( ) > 0 Then 
			tab_1.tabpage_notes.of_resizedwobject( )
		End If
		//End - Added By Mark Lee 04/26/2013

		//Begin - Added By Mark Lee 01/25/2013
		tab_1.tabpage_1.dw_1.y = 15				      		
		tab_1.tabpage_1.dw_1.Height = tab_1.tabpage_1.height - tab_1.tabpage_1.dw_1.y - 10
		tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - tab_1.tabpage_1.dw_1.x - 10
		tab_1.tabpage_2.dw_1.y = 15
		tab_1.tabpage_2.dw_1.width = tab_1.tabpage_2.width - tab_1.tabpage_2.dw_1.x - 10						//Added By Mark Lee 03/13/2013
		tab_1.tabpage_2.dw_1.height = tab_1.tabpage_2.height - tab_1.tabpage_2.dw_1.y - 10
		//tab_1.tabpage_2.dw_1.Modify(	" DataWindow.Detail.Height = " +  String(tab_1.tabpage_2.dw_1.Height + 30))  //Commented by (Appeon)Harry 06.03.2014 - V142 ISG-CLX
		tab_1.tabpage_group_access.dw_1.y = 15
		tab_1.tabpage_group_access.dw_1.width = tab_1.tabpage_group_access.width - tab_1.tabpage_group_access.dw_1.x - 10			//Added By Mark Lee 03/13/2013
		tab_1.tabpage_group_access.dw_1.height = tab_1.tabpage_group_access.height - tab_1.tabpage_group_access.dw_1.y - 10
		//End - Added By Mark Lee 01/25/2013		
		
		Parent.Setredraw( True )
		
//		Reset orignal size
		if IsValid(parent.inv_resize) then
			parent.inv_resize.of_SetOrigSize(tab_1, tab_1.x, tab_1.y, tab_1.width, tab_1.height)
		end if
		if isvalid(tab_1.inv_resize) then	
			tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_1.dw_1, tab_1.tabpage_1.dw_1.x, tab_1.tabpage_1.dw_1.y, tab_1.tabpage_1.dw_1.width, tab_1.tabpage_1.dw_1.height)
			tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_notes.dw_1, tab_1.tabpage_notes.dw_1.x, tab_1.tabpage_notes.dw_1.y, tab_1.tabpage_notes.dw_1.width, tab_1.tabpage_notes.dw_1.height)
			tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_custom.dw_1, tab_1.tabpage_custom.dw_1.x, tab_1.tabpage_custom.dw_1.y, tab_1.tabpage_custom.dw_1.width, tab_1.tabpage_custom.dw_1.height)
			tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_2.dw_1, tab_1.tabpage_2.dw_1.x, tab_1.tabpage_2.dw_1.y, tab_1.tabpage_2.dw_1.width, tab_1.tabpage_2.dw_1.height)			
			tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_group_access.dw_1, tab_1.tabpage_group_access.dw_1.x, tab_1.tabpage_group_access.dw_1.y, tab_1.tabpage_group_access.dw_1.width, tab_1.tabpage_group_access.dw_1.height)
		end if
	End If
End IF

////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.17.2006 By: LeiWei
////$<reason> The tab_1 folder is maximized to the height of the window.
//
//Parent.Setredraw( False )
//
//Long ll_bottom
//ll_bottom = tab_1.y + tab_1.height
//
//IF This.text = '+' THEN
//	This.text = '-'
//	
//	dw_contract_dates.Hide()
//	dw_occ.Hide()
//	dw_ccc.Hide()
//	tab_1.y = dw_contract_dates.y
//ELSE
//	This.text = '+'
//	dw_contract_dates.Show()
//	dw_occ.Show()
//	dw_ccc.Show()
//	tab_1.y = dw_occ.y + dw_occ.height + 20
//END IF
//
//tab_1.height = ll_bottom - tab_1.y
//cb_max.y = tab_1.y
//
//tab_1.tabpage_notes.dw_1.accepttext( )
//tab_1.tabpage_notes.dw_1.Height = tab_1.tabpage_notes.height - tab_1.tabpage_notes.dw_1.y - 10
//tab_1.tabpage_custom.dw_1.Height = tab_1.tabpage_custom.height - tab_1.tabpage_custom.dw_1.y - 10
//tab_1.tabpage_1.dw_1.y = 76
//tab_1.tabpage_1.dw_1.Height = tab_1.tabpage_1.height - tab_1.tabpage_1.dw_1.y - 10
//tab_1.tabpage_notes.dw_1.Modify( "notes.height = " + String(tab_1.tabpage_notes.dw_1.Height - 30) +&
//" DataWindow.Detail.Height = " +  String(tab_1.tabpage_notes.dw_1.Height + 30))
//Parent.Setredraw( True )
//
////1.22.2009 By Jervis
////Reset orignal size
//if IsValid(parent.inv_resize) then
//	parent.inv_resize.of_SetOrigSize(tab_1, tab_1.x, tab_1.y, tab_1.width, tab_1.height)
//end if
//if isvalid(tab_1.inv_resize) then	//Modify By Jervis 02.16.2009
//	tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_1.dw_1, tab_1.tabpage_1.dw_1.x, tab_1.tabpage_1.dw_1.y, tab_1.tabpage_1.dw_1.width, tab_1.tabpage_1.dw_1.height)
//	tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_notes.dw_1, tab_1.tabpage_notes.dw_1.x, tab_1.tabpage_notes.dw_1.y, tab_1.tabpage_notes.dw_1.width, tab_1.tabpage_notes.dw_1.height)
//	tab_1.inv_resize.of_SetOrigSize(tab_1.tabpage_custom.dw_1, tab_1.tabpage_custom.dw_1.x, tab_1.tabpage_custom.dw_1.y, tab_1.tabpage_custom.dw_1.width, tab_1.tabpage_custom.dw_1.height)
//end if
end event

