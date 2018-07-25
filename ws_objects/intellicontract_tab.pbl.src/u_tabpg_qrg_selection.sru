$PBExportHeader$u_tabpg_qrg_selection.sru
$PBExportComments$[intellicontract_tab]  Org details tabpage
forward
global type u_tabpg_qrg_selection from u_tabpg_contract_master
end type
type dw_profile from u_dw_contract within u_tabpg_qrg_selection
end type
type dw_contact_info from u_dw_contract within u_tabpg_qrg_selection
end type
type dw_2 from u_dw_contract within u_tabpg_qrg_selection
end type
type dw_requirements from u_dw_contract within u_tabpg_qrg_selection
end type
type dw_auth from u_dw_contract within u_tabpg_qrg_selection
end type
type dw_precert from u_dw_contract within u_tabpg_qrg_selection
end type
type dw_basic_info from u_dw_contract within u_tabpg_qrg_selection
end type
type dw_1 from u_dw_contract within u_tabpg_qrg_selection
end type
type cb_2 from commandbutton within u_tabpg_qrg_selection
end type
type cb_3 from commandbutton within u_tabpg_qrg_selection
end type
end forward

global type u_tabpg_qrg_selection from u_tabpg_contract_master
integer width = 3995
integer height = 2152
boolean ib_retrieved = true
event ue_set_screen_properties ( )
dw_profile dw_profile
dw_contact_info dw_contact_info
dw_2 dw_2
dw_requirements dw_requirements
dw_auth dw_auth
dw_precert dw_precert
dw_basic_info dw_basic_info
dw_1 dw_1
cb_2 cb_2
cb_3 cb_3
end type
global u_tabpg_qrg_selection u_tabpg_qrg_selection

type variables
n_cst_cxt_reports inv_ctx_reports
datawindowchild dwchild

end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_set_rpt_display ()
public function boolean of_set_bool_value (u_dw adw, long al_row)
public function integer of_init_data ()
public function integer of_set_selected (u_dw adw)
public function integer of_set_dw_codes (u_dw adw)
public function integer of_remove_dups (u_dw adw)
public function integer of_remove_dups2 (u_dw adw)
public function integer of_preupdate (u_dw adw)
public function integer of_manage_menu (boolean as_bool)
public function integer of_pop_menu ()
public function integer of_modify_basic_info ()
public subroutine of_enable_save ()
end prototypes

event ue_set_screen_properties();// Set screen properties
dw_profile.of_set_properties(dw_profile.il_ViewID, dw_profile.il_ScreenID, "Y")
dw_basic_info.of_set_properties(dw_basic_info.il_ViewID, dw_basic_info.il_ScreenID, "Y")
dw_contact_info.of_set_properties(dw_contact_info.il_ViewID, dw_contact_info.il_ScreenID, "Y")
dw_precert.of_set_properties(dw_precert.il_ViewID, dw_precert.il_ScreenID, "Y")
dw_requirements.of_set_properties(dw_requirements.il_ViewID, dw_requirements.il_ScreenID, "Y")
dw_2.of_set_properties(dw_2.il_ViewID, dw_2.il_ScreenID, "Y")
dw_auth.of_set_properties(dw_auth.il_ViewID, dw_auth.il_ScreenID, "Y")
dw_1.of_set_properties(dw_1.il_ViewID, dw_1.il_ScreenID, "Y")
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
**  Created By	: Michael B. Skinner  23 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if not ib_retrieved then
   dw_profile.event pfc_retrieve()
	 
end if

ib_retrieved = true
 
 
 
 return success






end function

public subroutine of_set_rpt_display ();/******************************************************************************************************************
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

long ll_i
long ll_max_rowcount

return 


ll_max_rowcount = dw_basic_info.rowcount( )

for ll_i = 1 to ll_max_rowcount
		choose case dw_basic_info.getitemstring(ll_i,'text')
				CASE  'Company Address'
					    inv_ctx_reports.ib_show_company_address	= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Product Type'
					   inv_ctx_reports.ib_show_product_type 		= of_set_bool_value(dw_basic_info,ll_i)
			   CASE  'Contract Type' 
						inv_ctx_reports.ib_show_contract_type 		= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Effective Date'
						inv_ctx_reports.ib_show_effective_date  	= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Notification Days'
					   inv_ctx_reports.ib_show_notification_days 	= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Review Date'
						inv_ctx_reports.ib_show_review_date    		= of_set_bool_value(dw_basic_info,ll_i)
				CASE  'Notes'
						inv_ctx_reports.ib_show_notes          		= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 1'
						inv_ctx_reports.ib_show_custom_1       		= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 2'
						inv_ctx_reports.ib_show_custom_2       		= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 3'
						inv_ctx_reports.ib_show_custom_3       		= of_set_bool_value(dw_basic_info,ll_i)
				CASE  'Custom 4'
						inv_ctx_reports.ib_show_custom_4       		= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 5'
						inv_ctx_reports.ib_show_custom_5     		= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 6'
						inv_ctx_reports.ib_show_custom_6 				= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 7'
						inv_ctx_reports.ib_show_custom_7 				= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 8' 
						inv_ctx_reports.ib_show_custom_8  			= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 9'
					   inv_ctx_reports.ib_show_custom_9 				= of_set_bool_value(dw_basic_info,ll_i)
            CASE  'Custom 10'
					   inv_ctx_reports.ib_show_custom_10 			= of_set_bool_value(dw_basic_info,ll_i)
		end choose

next

end subroutine

public function boolean of_set_bool_value (u_dw adw, long al_row);/******************************************************************************************************************
**  [PUBLIC]   : of_set_bool_value
**==================================================================================================================
**  Purpose   	: sets the boolen value base on the checked value
**==================================================================================================================
**  Arguments 	: 
**==================================================================================================================
**  Returns   	: [boolean]   true if the expression evaluates to true else false
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner     25 July 2005         ?  IntellisoftGroup Inc 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
adw.accepttext()


return  not ( adw.object.selected[al_row] = 1)
end function

public function integer of_init_data ();

long ll_row

long ll_setting


ll_setting = 1




ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Company Address'

ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Product Type'

ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Contract Type'

ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Effective Date'

ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Notification Days'

ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Review Date'

ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Notes'

ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 1'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 2'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 3'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 4'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 5'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 6'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 7'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 8'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 8'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 9'
ll_row = dw_basic_info.insertrow(0)
dw_basic_info.object.selected[ll_row] = ll_setting
dw_basic_info.object.text[ll_row] = 'Custom 10'


return success
end function

public function integer of_set_selected (u_dw adw);/******************************************************************************************************************
**  [PUBLIC]   : of_set_selected( /*u_dw adw */)
**==================================================================================================================
**  Purpose   	: Sets the "selected" colum
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 07 December 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long ll_i

for ll_i = 1 to ADW.rowcount()
	
	  choose case ADW.object.c_selected[ll_i]
		case 0 
			ADW.object.selected[ll_i]  = 0
		case 1
			ADW.object.selected[ll_i]  = 1
		case else 
			ADW.object.selected[ll_i]  = 0
	end choose
		ADW.SetItemStatus(ll_i, 0, Primary!, notmodified!)	
 next




RETURN 0
end function

public function integer of_set_dw_codes (u_dw adw);

long ll_i
long ll_null
setnull(ll_null)
for ll_i = 1 to adw.rowcount()
	// the record does not exsist
	if adw.getitemnumber(ll_i, 'selected') =  1  and not f_validstr(string(adw.getItemNumber(ll_i, 'ctx_rpt_prfl_id' )))then 
		adw.setItem(ll_i,'ctx_rpt_prfl_id', inv_ctx_reports.of_get_profile_id( ) )
		adw.setItem(ll_i,'profile_det_field_id', long(adw.object.sys_fields_field_id[ll_i]) )
		adw.setItemstatus( ll_i,0, primary!, NewModified!)
	end if
	
	//----------------------Begin Modified by Alfee on 06.02.2008 -----------------------------------------------------
	//<$Reason>For an existed record, the primary key should not be a Null value.
	//if adw.getitemnumber(ll_i, 'selected') = 0 and f_validstr(string(adw.getItemNumber(ll_i, 'ctx_rpt_prfl_id' ))) then 
	if adw.getitemnumber(ll_i, 'selected') = 0 and f_validstr(string(adw.getItemNumber(ll_i, 'ctx_rpt_prfl_id' ))) &
		and f_validstr(string(adw.getItemNumber(ll_i, 'ctx_rpt_prfl_det_id' ))) THEN 
	//----------------------End Modified ------------------------------------------------------------------------------		
		adw.setItem(ll_i,'profile_det_field_id', ll_null )
		adw.setItemstatus( ll_i,0, primary!, datamodified!)
	end if
	
next
	


return 0
end function

public function integer of_remove_dups (u_dw adw);/******************************************************************************************************************
**  [PUBLIC]   : of_remove_dups( /*u_dw adw */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



setredraw(false)
long ll_i,ll_j,ll_rowCount
ll_rowCount = adw.rowCount() 


adw.setsort('sys_fields_field_name_allias as , selected ds')
adw.sort()





FOR ll_i = ll_rowCount TO 2 STEP -1 
        //Compare a row to previous row 
        IF adw.getitemNumber(ll_i, "sys_fields_field_id") =  adw.getitemNumber(ll_i  - 1, "sys_fields_field_id") then
           adw.rowsDiscard (ll_i, ll_i, Primary!) 
        END IF 
NEXT

ll_rowCount = adw.rowCount() 
FOR ll_i = ll_rowCount TO 2 STEP -1 
        //Compare a row to previous row 
        IF not f_validstr(string(adw.object.sys_fields_field_name_allias[ll_i])) then 
           adw.rowsDiscard (ll_i, ll_i, Primary!) 
        END IF 
NEXT


for ll_i = 1 to ll_rowCount
	//adw.object.selected[ll_i] = 0
next 

for ll_i = 1 to ll_rowCount
//	adw.object.selected[ll_i] = 1
   //ADW.SetItemStatus(ll_i, 0, Primary!, Newmodified!)
next 
adw.setsort('sys_fields_field_id')
adw.sort()

adw.accepttext()
setredraw(true)

return success
end function

public function integer of_remove_dups2 (u_dw adw);long ll_i,ll_j
long ll_rowcount
ll_rowCount = adw.rowCount() 

adw.setsort('text A , selected D')

adw.sort()
FOR ll_i = ll_rowCount TO 2 STEP -1 
        //Compare a row to previous row 
        IF adw.getitemsTRING(ll_i, "text") =  adw.getitemsTRING(ll_i  - 1, "text") then
           adw.rowsDiscard (ll_i, ll_i, Primary!) 
        END IF 
NEXT
adw.setsort('text')
adw.sort()


return 0
end function

public function integer of_preupdate (u_dw adw);

long ll_i
long ll_null
setnull(ll_null)
for ll_i = 1 to adw.rowcount()
	// the record does not exsist
	if adw.getitemnumber(ll_i, 'selected') =  1  and not f_validstr(string(adw.getItemNumber(ll_i, 'ctx_rpt_prfl_id' )))then 
		adw.setItem(ll_i,'ctx_rpt_prfl_id', inv_ctx_reports.of_get_profile_id( ) )
		adw.setItem(ll_i,'ctx_report_profile_det_lookup_code', long(adw.object.lookup_code[ll_i]) )
		adw.setItemstatus( ll_i,0, primary!, NewModified!)
	end if
	
	
	if adw.getitemnumber(ll_i, 'selected') = 0 and f_validstr(string(adw.getItemNumber(ll_i, 'ctx_rpt_prfl_id' ))) then 
		adw.setItem(ll_i,'ctx_report_profile_det_lookup_code', ll_null )
		adw.setItemstatus( ll_i,0, primary!, datamodified!)
	end if
	
next


return 0
end function

public function integer of_manage_menu (boolean as_bool);

if isvalid(m_pfe_cst_contract_profile)  then 
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_profile.m_edit.m_insert,'enabled', as_bool)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_profile.m_edit.m_delete1,'enabled', as_bool)
end if
return 0
end function

public function integer of_pop_menu ();//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-03-11 By: Scofield
//$<Reason> Don't create menu because it exist

//m_pfe_cst_mdi_menu_contract NewMenu

//NewMenu = CREATE m_pfe_cst_mdi_menu_contract
//NewMenu.m_other.PopMenu(w_mdi.PointerX(), w_mdi.PointerY())

m_pfe_cst_contract_profile.m_other.PopMenu(w_mdi.PointerX(), w_mdi.PointerY())
gnv_app.of_modify_menu_attr( m_pfe_cst_contract_profile.m_file.m_save,'enabled', true)

RETURN 0
//---------------------------- APPEON END ----------------------------

end function

public function integer of_modify_basic_info ();//====================================================================
// Event: of_modify_basic_info()
//--------------------------------------------------------------------
// Description: Refresh the basic info datawindow's field alias
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-21
//====================================================================

String 	ls_ConDetailSQL,ls_ConProduSQL,ls_ConDateSQL,ls_ConCustomSQL
String	ls_Field_Name,ls_FieldAlias,ls_FieldLabel,ls_Visible
Long 		ll_Cycle

DataStore		lds_ConDetail,lds_ConDate,lds_ConCustom,lds_Products
DWItemStatus	ldw_ItemStatus

lds_ConDetail = Create DataStore
lds_Products = Create DataStore
lds_ConDate = Create DataStore
lds_ConCustom = Create DataStore

ls_ConDetailSQL = inv_ctx_Reports.of_GetSQLSyntax(gi_contract_view_id,"tabpage_details","Details->Contract Detail")
lds_ConDetail.Create(ls_ConDetailSQL)

ls_ConProduSQL = inv_ctx_Reports.of_GetSQLSyntax(gi_contract_view_id,"tabpage_details","Details->Products")
lds_Products.Create(ls_ConProduSQL)

ls_ConDateSQL = inv_ctx_Reports.of_GetSQLSyntax(gi_contract_view_id,"tabpage_details","Details->Contract Dates")
lds_ConDate.Create(ls_ConDateSQL)

ls_ConCustomSQL = inv_ctx_Reports.of_GetSQLSyntax(gi_contract_view_id,"tabpage_details","Details->Custom Data Tab->Custom Data")
lds_ConCustom.Create(ls_ConCustomSQL)

for ll_Cycle = 1 to dw_basic_info.RowCount()
	ls_Field_Name = dw_basic_info.GetItemString(ll_Cycle,'field_name')
	ls_FieldAlias = dw_basic_info.GetItemString(ll_Cycle,'sys_fields_field_name_allias')
	ldw_ItemStatus = dw_basic_info.GetItemStatus(ll_Cycle,'sys_fields_field_name_allias',Primary!)
	
	ls_Visible = '0'
	
	Choose Case ls_Field_Name
		Case 'ctx_id','category','status','contract_type','file_location','dvision','app_facility','master_contract_name','total_processing_time'
			ls_FieldLabel = lds_ConDetail.Describe(ls_Field_Name + "_t.Text")
			ls_Visible = lds_ConDetail.Describe(ls_Field_Name + ".Visible")
		Case 'product_type'
			ls_FieldLabel = lds_Products.Describe(ls_Field_Name + "_t.Text")
			ls_Visible = lds_Products.Describe(ls_Field_Name + ".Visible")
		Case 'product_name'
			ls_FieldLabel = lds_Products.Describe("product_id_t.Text")
			ls_Visible = lds_Products.Describe(ls_Field_Name + ".Visible")
		Case 'effective_date','expriation_date','review_date','review_by','term_date','term_reason','last_revis_date','other_date_1','other_date_2','version_number','version_date'
			ls_FieldLabel = lds_ConDate.Describe(ls_Field_Name + "_t.Text")
			ls_Visible = lds_ConDate.Describe(ls_Field_Name + ".Visible")
		Case 'custom_1','custom_2','custom_3','custom_4','custom_5','custom_6','custom_7','custom_8','custom_9','custom_10','custom_11','custom_12','custom_13','custom_14','custom_15','custom_16','custom_17','custom_18','custom_19','custom_20','custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10','custom_n1','custom_n2','custom_n3','custom_n4','custom_n5','custom_n6','custom_n7','custom_n8','custom_n9','custom_n10'
			ls_FieldLabel = lds_ConCustom.Describe(ls_Field_Name + "_t.Text")
			ls_Visible = lds_ConCustom.Describe(ls_Field_Name + ".Visible")
		Case else
			//Discard this row
	End Choose
	
	if ls_Visible <> '1' then
		dw_basic_info.RowsDiscard(ll_Cycle,ll_Cycle,Primary!)
		ll_Cycle --
		CONTINUE
	end if
	
	if Not (IsNull(ls_FieldLabel) or Trim(ls_FieldLabel) = "" or ls_FieldLabel = "!" or ls_FieldLabel = ls_FieldAlias) then
		dw_basic_info.SetItem(ll_Cycle,'sys_fields_field_name_allias',ls_FieldLabel)
		dw_basic_info.SetItemStatus(ll_Cycle,'sys_fields_field_name_allias',Primary!,ldw_ItemStatus)
	end if
next

Destroy lds_ConDetail
Destroy lds_Products
Destroy lds_ConDate
Destroy lds_ConCustom

Return 0

end function

public subroutine of_enable_save ();//add by jervis 09.27.2011
if isvalid(m_pfe_cst_contract_profile) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_contract_profile.m_file.m_save,'enabled', true)
end if
end subroutine

on u_tabpg_qrg_selection.create
int iCurrent
call super::create
this.dw_profile=create dw_profile
this.dw_contact_info=create dw_contact_info
this.dw_2=create dw_2
this.dw_requirements=create dw_requirements
this.dw_auth=create dw_auth
this.dw_precert=create dw_precert
this.dw_basic_info=create dw_basic_info
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_profile
this.Control[iCurrent+2]=this.dw_contact_info
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_requirements
this.Control[iCurrent+5]=this.dw_auth
this.Control[iCurrent+6]=this.dw_precert
this.Control[iCurrent+7]=this.dw_basic_info
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.cb_3
end on

on u_tabpg_qrg_selection.destroy
call super::destroy
destroy(this.dw_profile)
destroy(this.dw_contact_info)
destroy(this.dw_2)
destroy(this.dw_requirements)
destroy(this.dw_auth)
destroy(this.dw_precert)
destroy(this.dw_basic_info)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event ue_selectionchanging;call super::ue_selectionchanging;

dw_basic_info.setfocus()

return success
end event

event constructor;call super::constructor;inv_ctx_reports =  create n_cst_cxt_reports 


/////////////////////////////////////////////////////////////
// set the update sequence
/////////////////////////////////////////////////////////////

powerobject lpo[]
lpo[1] = dw_profile
lpo[2] = dw_basic_info
lpo[3] = dw_requirements
lpo[4] = dw_contact_info
lpo[5] = dw_precert
lpo[6] = dw_1
lpo[7] = dw_2
lpo[8] = dw_auth


//lpo[5] = dw_2
//lpo[5] = dw_precert
//lpo[5] = dw_auth
//lpo[5] = dw_1

this.of_setupdateobjects( lpo)


//dw_profile.of_SetLinkage(TRUE)
//dw_basic_info.of_SetLinkage(TRUE)
//dw_basic_info.inv_linkage.of_SetMaster(dw_profile)
//dw_basic_info.inv_linkage.of_Register("ctx_rpt_prfl_id", "ctx_rpt_prfl_id")
//dw_basic_info.inv_linkage.of_SetStyle(dw_basic_info.inv_linkage.RETRIEVE)
//dw_profile.inv_linkage.of_SetTransObject(SQLCA)
//
//
//
//IF dw_profile.of_Retrieve() = -1 THEN
//   MessageBox("Error", "Retrieval error")
//ELSE
//  dw_profile.SetFocus()
//
//END IF
//



//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.18.2006 By: LeiWei
//$<reason> Fix a defect.
dw_profile.Post SetFocus()
//---------------------------- APPEON END ----------------------------

end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(inv_ctx_reports) then Destroy inv_ctx_reports
//---------------------------- APPEON END ----------------------------
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_qrg_selection
integer x = 27
integer y = 2032
integer width = 3803
integer height = 68
end type

type dw_profile from u_dw_contract within u_tabpg_qrg_selection
string tag = "Report Profiles"
integer x = 73
integer y = 48
integer width = 2894
integer height = 336
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Report Profiles"
string dataobject = "d_report_hdr"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
string dataobject_original = "d_report_hdr"
end type

event pfc_retrieve;call super::pfc_retrieve;


this.retrieve( )


return success
end event

event retrieveend;call super::retrieveend;



///////////////////////////////////////////////////////////////////
// clears out un-needed stuff from the ctx_report_profile_det table
// This is because of the way I am updating
///////////////////////////////////////////////////////////////////
  DELETE FROM ctx_report_profile_det
   WHERE ( ctx_report_profile_det.lookup_code is  null ) AND  
         ( ctx_report_profile_det.field_id is null )   
           ;







end event

event itemchanged;call super::itemchanged;
//
//long ll_countrol_cnt
//long ll_i
//u_dw ldw
//ll_countrol_cnt = upperbound(parent.control)
//
//choose case dwo.name 
//	case 'al_profile_id'
//		parent.inv_ctx_reports.of_set_profile_id( long(data))
//		
//		FOR ll_i = 1 to ll_countrol_cnt
//				  IF parent.Control[ll_i].TypeOf( ) = datawindow!  THEN 
//						parent.inv_ctx_reports.of_modify_dw(parent.Control[ll_i])
//				  END IF 
//		NEXT
//
//end choose
parent.of_enable_save() //jervis 09.27.2011





end event

event pfc_preupdate;



long ll_i
long ll_max_profile_id
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.04.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
for ll_i = 1 to this.rowcount()
	if isnull(this.object.ctx_rpt_prfl_id[ll_i]) then 
		
		select max(ctx_rpt_prfl_id)
		into :ll_max_profile_id
		from ctx_report_profile_hdr;
		
		if isnull(ll_max_profile_id) then 
			ll_max_profile_id = 1 
		else 
			ll_max_profile_id =  ll_max_profile_id + 1
		end if 
		
		this.object.ctx_rpt_prfl_id[ll_i] = ll_max_profile_id
		parent.inv_ctx_reports.of_set_profile_id(ll_max_profile_id)
				
	end if
next
*/

for ll_i = 1 to this.rowcount()
	if isnull(this.object.ctx_rpt_prfl_id[ll_i]) then 
		
		IF ll_max_profile_id = 0 THEN
			select max(ctx_rpt_prfl_id)
			into :ll_max_profile_id
			from ctx_report_profile_hdr;
			
			if isnull(ll_max_profile_id) then 
				ll_max_profile_id = 0 
			end if 
		END IF

		ll_max_profile_id =  ll_max_profile_id + 1
		
		this.object.ctx_rpt_prfl_id[ll_i] = ll_max_profile_id
		parent.inv_ctx_reports.of_set_profile_id(ll_max_profile_id)
				
	end if
next

//---------------------------- APPEON END ----------------------------

return success
end event

event pfc_validation;call super::pfc_validation;long ll_i

This.AcceptText()		//Added by Scofield on 2008-12-31

for ll_i = 1 to this.RowCount()	
	if Not f_ValidStr(this.Object.ctx_rpt_prfl_comment[ll_i]) then
		MessageBox('Validation', 'Please give the profile a name.')
		SetRow(ll_i)
		Return Failure
	end if
next

Return success

end event

event updateend;//override


end event

event rowfocuschanged;call super::rowfocuschanged;



if currentrow >  0 then 
	
 inv_ctx_reports.of_set_profile_id(this.object.ctx_rpt_prfl_id[currentrow])
 parent.cb_2.event clicked( )
end if


end event

event pfc_addrow;
long ll_countrol_cnt
long ll_i,ll_s
u_dw ldw

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.04.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
If of_check_read_only( ) Then Return failure  //Add by Jack 07.13.2007

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-09-18 By: Scofield
//$<Reason> Save the changes before rowfocuschanged.

String	ls_Comment
long		ll_Row

This.AcceptText()
ll_Row = This.GetRow()
if ll_Row > 0 and ll_Row <= This.RowCount() then
	ls_Comment = This.GetItemString(ll_Row,"ctx_rpt_prfl_comment")
	if IsNull(ls_Comment) or Trim(ls_Comment) = "" then
		MessageBox("Validation","Please give the profile a name.")
		Return Success
	end if
end if

//---------------------------- APPEON END ----------------------------

iw_parent.event dynamic ue_save()

if not ib_read_only  then 
	super :: event pfc_addrow( )
end if 

//---------------------------- APPEON END ----------------------------

ll_countrol_cnt = upperbound(parent.control)

//Modify("DataWindow.Table.Select='<string containing the SQL select source of the DW>'")

parent.setredraw(false)
long ll_null
setnull(ll_null)
inv_ctx_reports.of_set_profile_id(ll_null)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

FOR ll_i = 1 to ll_countrol_cnt
        IF parent.Control[ll_i].TypeOf( ) = datawindow!  THEN
			ldw = parent.Control[ll_i]
			
			if ldw.dataobject <> 'd_report_hdr' then
				ldw.event pfc_retrieve( )
				
			     //parent.inv_ctx_reports.of_modify_dw(parent.Control[ll_i], parent.dw_profile.object.ctx_rpt_prfl_id[parent.dw_profile.getrow()] )
		end if 
        END IF 
NEXT

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

FOR ll_i = 1 to ll_countrol_cnt
        IF parent.Control[ll_i].TypeOf( ) = datawindow!  THEN
			ldw = parent.Control[ll_i]
			
			if ldw.dataobject <> 'd_report_hdr' then
				for ll_s = 1 to ldw.rowcount()
					ldw.object.selected[ll_s] = 1
				next
			end if 
        END IF 
NEXT


parent.setredraw(true)

return success
end event

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
//this.of_setrowselect( true)
//this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )
this.SetRowFocusIndicator(Hand!)
//this.retrieve( )

this.ib_rmbmenu = false



end event

event clicked;call super::clicked;of_manage_menu(true)
end event

event pfc_deleterow;long	ll_Row

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.13.2006 By: Liang QingShi
//$<reason> Fix a defect.
If of_check_read_only( ) Then Return failure  //Add by Jack 07.13.2007

ll_Row = this.GetRow()
if ll_Row <= 0 or ll_Row > This.RowCount() then Return success			//Added by Scofield on 2008-09-28

if messagebox('Delete Report Profiles', 'Are you sure you want to delete this Report Profiles?',question!,Yesno!,2) = 1 then
	long ll_ctx_rpt_prfl_id
	ll_ctx_rpt_prfl_id = this.getitemnumber(ll_Row,'ctx_rpt_prfl_id')
	
	gnv_appeondb.of_startqueue( )
	delete from CTX_REPORT_PROFILE_DET where ctx_rpt_prfl_id = :ll_ctx_rpt_prfl_id;
	delete from ctx_report_profile_hdr where ctx_rpt_prfl_id = :ll_ctx_rpt_prfl_id;
	commit;
	gnv_appeondb.of_commitqueue( )		

	dw_1.reset()
	dw_auth.reset()
	dw_precert.reset()
	dw_contact_info.reset()
	dw_2.reset()
	dw_basic_info.reset()
	dw_requirements.reset()
	this.reset()
	this.retrieve()
end if
return success
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;call super::rowfocuschanging;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-09-18 By: Scofield
//$<Reason> Save the changes before rowfocuschanged.

String	ls_Comment

if CurrentRow <= 0 or CurrentRow > This.RowCount() then Return 0
if NewRow <= 0 or NewRow > This.RowCount() then Return 0

ls_Comment = This.GetItemString(CurrentRow,"ctx_rpt_prfl_comment")

if IsNull(ls_Comment) or Trim(ls_Comment) = "" then
	MessageBox("Validation","Please give the profile a name.")
	Return 1
end if

iw_parent.event dynamic pfc_save()
	
Return 0

//---------------------------- APPEON END ----------------------------

end event

type dw_contact_info from u_dw_contract within u_tabpg_qrg_selection
string tag = "Contract Contact Information to Include"
integer x = 1449
integer y = 532
integer width = 1097
integer height = 744
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Contract Contact Information to Include"
string dataobject = "d_qrg_sys_fields"
boolean border = false
borderstyle borderstyle = stylebox!
string dataobject_original = "d_qrg_sys_fields"
end type

event pfc_retrieve;call super::pfc_retrieve;
string ls_ret[]


ls_ret[1] ='Contract/Contacts/Contact Details'
ls_ret[2] ='Contract/Contacts/Contact Information'
ls_ret[3] ='Contract/Contacts/Notes'



long ll_null
setnull(ll_null)
this.reset()
retrieve(ls_ret,inv_ctx_reports.of_get_profile_id( ),ll_null)


//if this.sharedata( inv_ctx_reports.ids_basic_info) <> 1 then messagebox('Share data Failed','The data share in dw_basic_info:: pfc_retrive failed.')


return success

end event

event retrieveend;call super::retrieveend;
if  f_validstr(string(inv_ctx_reports.of_get_profile_id( ) )) then 
     OF_SET_SELECTED(THIS)
	  else 

end if 

of_remove_dups( this)

if this.sharedata( inv_ctx_reports.ids_contact_info) <> 1 then messagebox('Share data Failed','The data share in dw_basic_info:: pfc_retrive failed.')

end event

event pfc_preupdate;

of_set_dw_codes(this)
return success
end event

event updateend;//
end event

event getfocus;of_manage_menu(false)
end event

event rbuttonup;//m_pfe_cst_mdi_menu_contract

OF_POP_MENU( )

end event

event itemchanged;call super::itemchanged;parent.of_enable_save() //jervis 09.27.2011
end event

type dw_2 from u_dw_contract within u_tabpg_qrg_selection
string tag = "Organization Types to Include"
integer x = 2816
integer y = 532
integer width = 1097
integer height = 744
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Organization Types to Include"
string dataobject = "d_profile_codes"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbfocuschange = false
string dataobject_original = "d_profile_codes"
end type

event constructor;call super::constructor;

inv_ctx_reports.of_set_original_sql( this)
end event

event retrieveend;call super::retrieveend;

if  f_validstr(string(inv_ctx_reports.of_get_profile_id( ) )) then 
     OF_SET_SELECTED(THIS)
	  else 
end if 


of_remove_dups2(this)

end event

event pfc_retrieve;call super::pfc_retrieve;
string ls_ret[]
ls_ret[1] = 'Contract Organization Type'


this.retrieve( inv_ctx_reports.of_get_profile_id( ) , ls_ret[1])


return success

end event

event pfc_preupdate;
of_preupdate(this)

return success
end event

event getfocus;of_manage_menu(false)
end event

event rbuttonup;OF_POP_MENU( )

end event

event itemchanged;call super::itemchanged;parent.of_enable_save() //jervis 09.27.2011
end event

type dw_requirements from u_dw_contract within u_tabpg_qrg_selection
string tag = "Requirements to Include"
boolean visible = false
integer x = 119
integer y = 1148
integer width = 1097
integer height = 700
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Requirements to Include"
string dataobject = "d_contract_profile_req_questions"
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
string dataobject_original = "d_contract_profile_req_questions"
end type

event pfc_retrieve;call super::pfc_retrieve;
//this.retrieve( inv_contract_details.of_get_req_profile_id() )

//This.Retrieve(Inv_Contract_Details.of_get_req_profile_id(),Inv_Contract_Details.of_get_ctx_id())

Return SUCCESS

end event

event retrieveend;call super::retrieveend;
//of_set_selected(this)
end event

event constructor;call super::constructor;

inv_ctx_reports.of_set_original_sql( this)
end event

event getfocus;of_manage_menu(false)
end event

event rbuttonup;//m_pfe_cst_mdi_menu_contract

of_pop_menu( )

end event

type dw_auth from u_dw_contract within u_tabpg_qrg_selection
string tag = "Authorizations Requirements"
integer x = 1449
integer y = 1328
integer width = 1097
integer height = 744
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Authorizations Requirements"
string dataobject = "d_profile_codes"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbfocuschange = false
string dataobject_original = "d_profile_codes"
end type

event constructor;call super::constructor;inv_ctx_reports.of_set_original_sql( this)


end event

event retrieveend;call super::retrieveend;

if  f_validstr(string(inv_ctx_reports.of_get_profile_id( ) )) then 
     OF_SET_SELECTED(THIS)
	  else 
end if 


of_remove_dups2(this)

end event

event pfc_retrieve;call super::pfc_retrieve;


this.retrieve( inv_ctx_reports.of_get_profile_id( ) , 'Contract Authorization Requirements')

return success
end event

event pfc_preupdate;
of_preupdate(this)

return success
end event

event getfocus;of_manage_menu(false)
end event

event rbuttonup;OF_POP_MENU( )
end event

event itemchanged;call super::itemchanged;parent.of_enable_save() //jervis 09.27.2011
end event

type dw_precert from u_dw_contract within u_tabpg_qrg_selection
string tag = "Precertifications Requirements"
integer x = 73
integer y = 1328
integer width = 1097
integer height = 744
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Precertifications Requirements"
string dataobject = "d_profile_codes"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbfocuschange = false
string dataobject_original = "d_profile_codes"
end type

event constructor;call super::constructor;inv_ctx_reports.of_set_original_sql( this)


end event

event pfc_retrieve;call super::pfc_retrieve;
long ll_null

setnull(ll_null)

this.retrieve( inv_ctx_reports.of_get_profile_id( ) , 'Contract Precert. Requirements')

return success
end event

event retrieveend;call super::retrieveend;if  f_validstr(string(inv_ctx_reports.of_get_profile_id( ) )) then 
     OF_SET_SELECTED(THIS)
	  else 
end if 


of_remove_dups2(this)

end event

event pfc_preupdate;
of_preupdate(this)

return success
end event

event updateend;//
end event

event getfocus;of_manage_menu(false)
end event

event rbuttonup;OF_POP_MENU( )

end event

event itemchanged;call super::itemchanged;parent.of_enable_save() //jervis 09.27.2011
end event

type dw_basic_info from u_dw_contract within u_tabpg_qrg_selection
string tag = "Basic Information to Include"
integer x = 73
integer y = 532
integer width = 1097
integer height = 744
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Basic Information to Include"
string dataobject = "d_qrg_sys_fields"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbfocuschange = false
string dataobject_original = "d_qrg_sys_fields"
end type

event constructor;call super::constructor;//if not isvalid(gnv_app.inv_debug) then
//	gnv_app.of_setdebug(true)
//end if
//
//
//
//if isvalid(gnv_app.inv_debug) then
//			gnv_app.inv_debug.of_SetSQLSpy(TRUE)
//			gnv_app.inv_debug.inv_sqlspy.of_opensqlspy( true)
//			gnv_app.inv_debug.of_SetAlwaysOnTop(true)
//end if
//
//
//
























//datastore ids_rpt_basic_info
//
//ids_rpt_basic_info = create datastore 
////ids_rpt_basic_info.dataobject = 'd_rpt_basic_info'
//
//long ll_row, ll_coulm_count,ll_currentrow
//
////ll_coulm_count = long(ids_rpt_basic_info.Object.DataWindow.Column.Count)
////For ll_row =  1 to ll_coulm_count
////	 ll_currentrow = this.insertrow(0)
////     //messagebox('',	 string(describe( '#' +string(ll_row) + ".name")))
////	 this.object.text[ll_currentrow] = INV_base.OF_GETcolumndisplayname(string(ids_rpt_basic_info.describe( '#' +string(ll_row) + ".name")))
////	 
////	
////	
////	
////next
//string ll_sel,ERRORS
//       ll_sel =  "SELECT dba.ctx_basic_info.ctx_id, dba.ctx_basic_info.custom_9, dba.ctx_basic_info.custom_10,  dba.ctx_basic_info.group_multi_loc_id,   dba.ctx_basic_info.revision_reason,dba.ctx_basic_info.group_id,  dba.ctx_basic_info.custom_date1,     dba.ctx_basic_info.custom_date2,dba.ctx_basic_info.custom_date3,dba.ctx_basic_info.custom_date4,dba.ctx_basic_info.custom_date5,  dba.ctx_basic_info.inserted_by_user, dba.ctx_basic_info.inserted_at_date_time, dba.ctx_basic_info.updated_by_user, dba.ctx_basic_info.updated_at_date_time FROM dba.ctx_basic_info "  
//
//ids_rpt_basic_info.Create( SQLCA.SyntaxFromSQL(ll_sel, "", ERRORS), ERRORS)
//
//ll_coulm_count = long(ids_rpt_basic_info.Object.DataWindow.Column.Count)
//For ll_row =  1 to ll_coulm_count
//	 ll_currentrow = this.insertrow(0)
//     //messagebox('',	 string(describe( '#' +string(ll_row) + ".name")))
//	 this.object.text[ll_currentrow] = INV_base.OF_GETcolumndisplayname(string(ids_rpt_basic_info.describe( '#' +string(ll_row) + ".name")))
//	 
//	
//	
//	
//next
//

//of_init_data( )


//inv_ctx_reports.of_set_original_sql(this)




end event

event pfc_retrieve;call super::pfc_retrieve;String	ls_Ret[]
long 		ll_Null

This.SetRedraw(false)

this.Reset()

SetNull(ll_Null)
ls_Ret[1] = 'Contract/Detail/Contract Detail' 

This.Retrieve(ls_Ret,inv_ctx_reports.of_get_profile_id())

of_Modify_Basic_Info()			//Added by Scofield on 2008-11-21

This.SetRedraw(true)

Return Success

end event

event retrieveend;call super::retrieveend;if  f_validstr(string(inv_ctx_reports.of_get_profile_id( ) )) then 
     OF_SET_SELECTED(THIS)

	
end if 

of_remove_dups( this)


if this.sharedata( inv_ctx_reports.ids_basic_info) <> 1 then messagebox('Share data Failed','The data share in dw_basic_info:: pfc_retrive failed.')

end event

event pfc_preupdate;


of_set_dw_codes(this)


return success
end event

event updateend;// overried
end event

event losefocus;//
end event

event getfocus;//

of_manage_menu(false)
end event

event rbuttonup;//m_pfe_cst_mdi_menu_contract
OF_POP_MENU()



end event

event itemchanged;call super::itemchanged;parent.of_enable_save() //jervis 09.27.2011
end event

type dw_1 from u_dw_contract within u_tabpg_qrg_selection
string tag = "Fee Schedule Data to Include"
integer x = 2816
integer y = 1328
integer width = 1097
integer height = 744
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Fee Schedule Data to Include"
string dataobject = "d_qrg_sys_fields"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbfocuschange = false
string dataobject_original = "d_qrg_sys_fields"
end type

event pfc_retrieve;call super::pfc_retrieve;string ls_ret[]

long ll_null
setnull(ll_null)
this.reset()


ls_ret[1] ='Contract/Browse/Fee Schedules'
ls_ret[2] ='Contract/Browse/Fee Schedule Locations'
ls_ret[3] ='Contract/Browse/Fees'



retrieve(ls_ret,inv_ctx_reports.of_get_profile_id( ),ll_null)


//if this.sharedata( inv_ctx_reports.ids_basic_info) <> 1 then messagebox('Share data Failed','The data share in dw_basic_info:: pfc_retrive failed.')



return success

end event

event constructor;call super::constructor;
inv_ctx_reports.of_set_original_sql( this)

end event

event retrieveend;call super::retrieveend;

if  f_validstr(string(inv_ctx_reports.of_get_profile_id( ) )) then 
     OF_SET_SELECTED(THIS)

	
end if 


of_remove_dups( this)
if this.sharedata( inv_ctx_reports.ids_basic_info) <> 1 then messagebox('Share data Failed','The data share in dw_basic_info:: pfc_retrive failed.')

end event

event pfc_preupdate;


of_set_dw_codes(this)
return success
end event

event updateend;//
end event

event getfocus;of_manage_menu(false)
end event

event rbuttonup;OF_POP_MENU( )
end event

event itemchanged;call super::itemchanged;parent.of_enable_save() //jervis 09.27.2011
end event

type cb_2 from commandbutton within u_tabpg_qrg_selection
boolean visible = false
integer x = 3493
integer y = 232
integer width = 343
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "p"
end type

event clicked;
iw_parent.setredraw( false)

long ll_countrol_cnt
long ll_i
u_dw ldw
ll_countrol_cnt = upperbound(parent.control)

//Modify("DataWindow.Table.Select='<string containing the SQL select source of the DW>'")

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 04.26.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
FOR ll_i = 1 to ll_countrol_cnt
        IF parent.Control[ll_i].TypeOf( ) = datawindow!  THEN
			ldw = parent.Control[ll_i]
			//messagebox('',ldw.Describe("DataWindow.Table.Select"))
			if ldw.dataobject <> 'd_report_hdr' then
			     parent.inv_ctx_reports.of_modify_dw(parent.Control[ll_i], parent.dw_profile.object.ctx_rpt_prfl_id[parent.dw_profile.getrow()] )
		end if 
        END IF 
NEXT
*/
Parent.Setredraw(False)
gnv_appeondb.of_startqueue( )

FOR ll_i = 1 to ll_countrol_cnt
	IF parent.Control[ll_i].TypeOf( ) = datawindow!  THEN
		ldw = parent.Control[ll_i]
			if ldw.dataobject <> 'd_report_hdr' then
				ldw.event pfc_retrieve()
			end if 
   END IF 
NEXT

gnv_appeondb.of_commitqueue( )
Parent.Setredraw(True)
//---------------------------- APPEON END ----------------------------

iw_parent.setredraw(true)

end event

type cb_3 from commandbutton within u_tabpg_qrg_selection
boolean visible = false
integer x = 3461
integer y = 84
integer width = 343
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;//long ll_Rows
//
//ll_Rows = dw_Employee.ModifiedCount()

long ll_countrol_cnt
long ll_i,ll_j

u_dw ldw
dwItemStatus l_status
ll_countrol_cnt = upperbound(parent.control)


FOR ll_i = 1 to ll_countrol_cnt
        IF parent.Control[ll_i].TypeOf( ) = datawindow!  THEN
			ldw = parent.Control[ll_i]
			for ll_j = 1 to ldw.rowcount()
			 	l_status = ldw.GetItemStatus(ll_j,0,primary!)
				 if l_status = datamodified! then
					 exit
			     end if 
			 next
		  END IF
		if l_status = datamodified! then
			exit
		end if 
NEXT

if l_status = datamodified! then
			 messagebox('Save Changes', 'The profile has changed do you want to save changes?')
end if

end event

