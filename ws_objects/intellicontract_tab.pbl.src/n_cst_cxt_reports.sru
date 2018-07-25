$PBExportHeader$n_cst_cxt_reports.sru
$PBExportComments$[intellicontract_tab] Maintains logic for QRG Reports
forward
global type n_cst_cxt_reports from nonvisualobject
end type
end forward

global type n_cst_cxt_reports from nonvisualobject
end type
global n_cst_cxt_reports n_cst_cxt_reports

type variables
/*********************************************************************************************************/
/*********************     REPORT VARS       *************************************************************/
/***********  Theses vars determine if the item on the report is to be displayed *************************/

// basic info
boolean ib_show_Company_Address
boolean ib_show_Product_Type
boolean ib_show_Contract_Type
boolean ib_show_Effective_Date
boolean ib_show_Notification_Days
boolean ib_show_Review_Date
boolean ib_show_Notes
boolean ib_show_Custom_1
boolean ib_show_Custom_2
boolean ib_show_Custom_3
boolean ib_show_Custom_4
boolean ib_show_Custom_5
boolean ib_show_Custom_6
boolean ib_show_Custom_7
boolean ib_show_Custom_8
boolean ib_show_Custom_9
boolean ib_show_Custom_10
// contact info
boolean ib_show_basic_Address
boolean ib_show_basic_Phone
boolean ib_show_basic_Fax
boolean ib_show_basic_Notes
long    li_font


n_ds ids_basic_info
n_ds ids_contact_info
//n_cst_dssrv invo_dwsrv	2007.7.112 By Jervis
u_dw ids_requestor

datawindowchild child_basic_info

protected: 

long il_profile_id
long il_profile_det_id
string is_sys_fields_sql_orig
string is_ctx_auth_sql_orig
string is_ctx_precet_req
string is_ctx_org_type_sql_orig
string is_ctx_prfl_req_questions
string is_profile_codes_sql_orig

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.22.2006 By: Rodger Wu
//$<reason> Define this to store contract id.
Long il_ctx_id
//---------------------------- APPEON END ----------------------------
end variables

forward prototypes
public function integer of_set_rpt_display ()
public function integer of_set_profile_id (long al_profile_id)
public function integer of_start (u_dw adw)
public function integer of_set_report_header ()
private function boolean of_set_bool_value (n_ds adw, long al_row)
private function integer of_set_cover_sheet ()
public function integer of_set_orginal_sql (u_dw adw, string as_original_sql)
private function integer of_set_section_header ()
private function integer of_set_requestor (u_dw adw)
public function integer of_set_pofile_det_id (long al_profile_det_id)
public function integer of_show_cover_sheet (boolean ab_bool)
public function string of_get_orginal_sql (u_dw adw)
public function long of_get_profile_det_id ()
public function long of_get_profile_id ()
public function integer of_modify_basic_info ()
private function integer of_modify_contact_info ()
private function integer of_add_bitmap ()
public function integer of_set_original_sql (u_dw adw)
public function integer of_modify_dw (u_dw adw, long profile_id)
public subroutine of_set_ctx_id (long al_ctx_id)
public function string of_getsqlsyntax (long al_viewid, string as_tabname, string as_scrname)
end prototypes

public function integer of_set_rpt_display ();/******************************************************************************************************************
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
ll_max_rowcount = ids_basic_info.rowcount( )

for ll_i = 1 to ll_max_rowcount
		choose case ids_basic_info.getitemstring(ll_i,'text')
				CASE  'Company Address'
					    ib_show_company_address	= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Product Type'
					   ib_show_product_type 		= of_set_bool_value(ids_basic_info,ll_i)
				CASE  'Contract Type' 
						ib_show_contract_type 		= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Effective Date'
						ib_show_effective_date  	= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Notification Days'
					   ib_show_notification_days 	= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Review Date'
						ib_show_review_date    		= of_set_bool_value(ids_basic_info,ll_i)
				CASE  'Notes'
						ib_show_notes          		= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 1'
						ib_show_custom_1       		= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 2'
						ib_show_custom_2       		= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 3'
						ib_show_custom_3       		= of_set_bool_value(ids_basic_info,ll_i)
				CASE  'Custom 4'
						ib_show_custom_4       		= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 5'
						ib_show_custom_5     		= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 6'
						ib_show_custom_6 				= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 7'
						ib_show_custom_7 				= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 8' 
						ib_show_custom_8  			= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 9'
					   ib_show_custom_9 				= of_set_bool_value(ids_basic_info,ll_i)
            CASE  'Custom 10'
					   ib_show_custom_10 			= of_set_bool_value(ids_basic_info,ll_i)
		end choose
next





return 0
end function

public function integer of_set_profile_id (long al_profile_id);if IsNull(al_profile_id) then 
	SELECT Max(ctx_rpt_prfl_id) INTO :il_profile_id FROM ctx_report_profile_hdr;
	if IsNull(il_profile_id) then il_profile_id = 0 
	il_profile_id =  il_profile_id + 1
else
	il_profile_id = al_profile_id
end if

return 0

end function

public function integer of_start (u_dw adw);
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
**  Created By	: Michael B. Skinner 15 February 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

// set the requestor datawindow
of_set_requestor(adw)
// set the datawindow child

ids_requestor.getchild( 'dw_basic_info', child_basic_info)

of_modify_basic_info()

of_modify_contact_info()

of_set_cover_sheet()

of_set_report_header()

of_set_section_header( )


return 0
end function

public function integer of_set_report_header ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.22.2006 By: Rodger Wu
//$<reason> In composite datawindow Appeon does not support assigning data 
//$<reason> from datawindow in Detail band to object in Header band.
n_ds lds_basic_info

if Upper( appeongetclienttype() ) = "WEB" then
	lds_basic_info = CREATE n_ds
	lds_basic_info.dataobject = "d_rpt_basic_info"
	lds_basic_info.SetTransObject( SQLCA )
	lds_basic_info.Retrieve( il_ctx_id )
	
	if lds_basic_info.rowcount() > 0 then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 08.17.2006 By: Liang QingShi
		//$<reason> Contract module modification 
		/*
		ids_requestor.object.effective_date.text =  string(lds_basic_info.getItemdate(1,'effective_date'))
		ids_requestor.object.expriation_date.text =  string(lds_basic_info.getItemdate(1,'expriation_date'))
		*/
		ids_requestor.object.effective_date.text =  string(lds_basic_info.getItemdatetime(1,'effective_date'))
		ids_requestor.object.expriation_date.text =  string(lds_basic_info.getItemdatetime(1,'expriation_date'))

		//---------------------------- APPEON END ----------------------------
		ids_requestor.object.product_type.text =  string(lds_basic_info.describe ( "evaluate ( 'LookupDisplay ( product_type )', "  + string ( 1 ) + " )" ))
		ids_requestor.object.product_name.text =  string(lds_basic_info.describe ( "evaluate ( 'LookupDisplay ( product_name )', "  + string ( 1 ) + " )" ))
		ids_requestor.object.category.text =  string(lds_basic_info.describe ( "evaluate ( 'LookupDisplay ( category )', "  + string (1 ) + " )" ))
		ids_requestor.object.app_facility.text =  string(lds_basic_info.describe ( "evaluate ( 'LookupDisplay ( app_facility )', "  + string (1 ) + " )" ))
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 08.17.2006 By: Liang QingShi
		//$<reason> Contract module modification 
		/*
		ids_requestor.object.other_date_1.text =  string(lds_basic_info.getItemdate(1,'other_date_1'))
		ids_requestor.object.other_date_2.text =  string(lds_basic_info.getItemdate(1,'custom_date2'))
		*/
		ids_requestor.object.other_date_1.text =  string(lds_basic_info.getItemdatetime(1,'other_date_1'))
		ids_requestor.object.other_date_2.text =  string(lds_basic_info.getItemdatetime(1,'custom_date2'))
		//---------------------------- APPEON END ----------------------------
	end If
	
	return 0
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.17.2006 By: Liang QingShi
//$<reason> Contract module modification
/*
ids_requestor.object.effective_date.text =  string(child_basic_info.getItemdate(1,'effective_date'))
ids_requestor.object.expriation_date.text =  string(child_basic_info.getItemdate(1,'expriation_date'))
*/
ids_requestor.object.effective_date.text =  string(child_basic_info.getItemdatetime(1,'effective_date'))
ids_requestor.object.expriation_date.text =  string(child_basic_info.getItemdatetime(1,'expriation_date'))

//---------------------------- APPEON END ----------------------------
ids_requestor.object.product_type.text =  string(child_basic_info.describe ( "evaluate ( 'LookupDisplay ( product_type )', "  + string ( 1 ) + " )" ))
ids_requestor.object.product_name.text =  string(child_basic_info.describe ( "evaluate ( 'LookupDisplay ( product_name )', "  + string ( 1 ) + " )" ))
ids_requestor.object.category.text =  string(child_basic_info.describe ( "evaluate ( 'LookupDisplay ( category )', "  + string (1 ) + " )" ))
ids_requestor.object.app_facility.text =  string(child_basic_info.describe ( "evaluate ( 'LookupDisplay ( app_facility )', "  + string (1 ) + " )" ))
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.17.2006 By: Liang QingShi
//$<reason> Contract module modification
/*
ids_requestor.object.other_date_1.text =  string(child_basic_info.getItemdate(1,'other_date_1'))
ids_requestor.object.other_date_2.text =  string(child_basic_info.getItemdate(1,'custom_date2'))
*/
ids_requestor.object.other_date_1.text =  string(child_basic_info.getItemdatetime(1,'other_date_1'))
ids_requestor.object.other_date_2.text =  string(child_basic_info.getItemdatetime(1,'custom_date2'))

//---------------------------- APPEON END ----------------------------

return 0
end function

private function boolean of_set_bool_value (n_ds adw, long al_row);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner     25 July 2005         ©  IntellisoftGroup Inc 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

adw.accepttext()


return  ( adw.object.selected[al_row] = 1)
end function

private function integer of_set_cover_sheet ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 15 February 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
datawindowChild child_rpt_cover
//datawindowChild child_basic_info


ids_requestor.getchild( 'dw_rpt_cover', child_rpt_cover)
//adw.getchild( 'dw_basic_info', child_basic_info)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.17.2006 By: Liang QingShi
//$<reason> Contract module modification
/*
child_rpt_cover.setItem(1,'effective_date',string(child_basic_info.getItemdate(1,'effective_date')))
child_rpt_cover.setItem(1,'expriation_date',string(child_basic_info.getItemdate(1,'expriation_date')))
*/
child_rpt_cover.setItem(1,'effective_date',string(child_basic_info.getItemdatetime(1,'effective_date')))
child_rpt_cover.setItem(1,'expriation_date',string(child_basic_info.getItemdatetime(1,'expriation_date')))

//---------------------------- APPEON END ----------------------------
child_rpt_cover.setItem(1,'product_type',child_basic_info.describe ( "evaluate ( 'LookupDisplay ( product_type )', "  + string ( 1 ) + " )" ))
child_rpt_cover.setItem(1,'product_name',child_basic_info.describe ( "evaluate ( 'LookupDisplay ( product_name )', "  + string ( 1 ) + " )" ))
child_rpt_cover.setItem(1,'category',child_basic_info.describe ( "evaluate ( 'LookupDisplay ( category )', "  + string (1 ) + " )" ))
child_rpt_cover.setItem(1,'app_facility',child_basic_info.describe ( "evaluate ( 'LookupDisplay ( app_facility )', "  + string (1 ) + " )" ))
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.17.2006 By: Liang QingShi
//$<reason> Contract module modification
/*
child_rpt_cover.setItem(1,'other_date_1',string(child_basic_info.getItemdate(1,'other_date_1')))
child_rpt_cover.setItem(1,'custom_date2',string(child_basic_info.getItemdate(1,'custom_date2')))
*/
child_rpt_cover.setItem(1,'other_date_1',string(child_basic_info.getItemdatetime(1,'other_date_1')))
child_rpt_cover.setItem(1,'custom_date2',string(child_basic_info.getItemdatetime(1,'custom_date2')))

//---------------------------- APPEON END ----------------------------



return 0
end function

public function integer of_set_orginal_sql (u_dw adw, string as_original_sql);

adw.Modify("DataWindow.Table.Select='" +as_original_sql +"'")

return 0 
end function

private function integer of_set_section_header ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 15 Febuary 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

ids_requestor.Object.dw_rpt_contacts.Object.t_1.Height   =  ids_requestor.Object.dw_basic_info.Object.t_1.Height
ids_requestor.Object.dw_rpt_contacts.Object.t_1.Width    =  ids_requestor.Object.dw_basic_info.Object.t_1.Width
ids_requestor.Object.dw_rpt_contacts.Object.t_1.x        =  ids_requestor.Object.dw_basic_info.Object.t_1.x
ids_requestor.Object.dw_rpt_contacts.Object.t_1.y        =  ids_requestor.Object.dw_basic_info.Object.t_1.y
// sub report
ids_requestor.Object.dw_rpt_contacts.Object.dw_1.x       =  ids_requestor.Object.dw_basic_info.Object.t_1.x
ids_requestor.Object.dw_rpt_contacts.Object.dw_1.Width   =  ids_requestor.Object.dw_basic_info.Object.t_1.Width


return 0
end function

private function integer of_set_requestor (u_dw adw);

ids_requestor = adw


return 0 
end function

public function integer of_set_pofile_det_id (long al_profile_det_id);

il_profile_det_id = al_profile_det_id
return 0 
end function

public function integer of_show_cover_sheet (boolean ab_bool);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 15 Febuary 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if ab_bool then 
   of_add_bitmap  () 
else
   ids_requestor.Object.page_no_cover.Visible = true
	ids_requestor.Object.dw_rpt_cover.Visible = false
   ids_requestor.Modify("DataWindow.Header.Height='"+string(464)+"'")
end if

return 0
end function

public function string of_get_orginal_sql (u_dw adw);/******************************************************************************************************************
**  [PUBLIC]   : of_get_orginal_sql( /*u_dw adw */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 07 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


choose case adw.dataobject
	case 'd_qrg_sys_fields'
		  return is_sys_fields_sql_orig
	case 'd_profile_codes'
		  return is_profile_codes_sql_orig 
	case else 
		//

end choose 



return ''


end function

public function long of_get_profile_det_id ();

return il_profile_det_id
end function

public function long of_get_profile_id ();

return il_profile_id
end function

public function integer of_modify_basic_info ();/*******************************************************************************************************************
**  [PUBLIC]   : of_modify_basic_info( /*datawindowchild adw_child */)
**==================================================================================================================
**  Purpose   	: Functions set then modification properties for the report
**==================================================================================================================
**  Arguments 	: [datawindowchild]  adw_child - the child datawindow of the report
**               [u_dw]             adw_dw  the datawindow that has the selections
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By Scofield       Change Date: 2008-08-05       Reason: Custom label
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String 	ls_Field_Name,ls_ConDetailSQL,ls_ConProduSQL,ls_ConDateSQL,ls_ConCustomSQL,ls_DispText
String	ls_dddwName,ls_Tag,ls_DispCol,ls_DataCol
Long 		ll_Cycle,ll_Selected,ll_ViewId,ll_Rtn

DataStore	lds_ConDetail,lds_ConDate,lds_ConCustom,lds_Products
DataWindowChild	ldwc_Child

lds_ConDetail = Create DataStore
lds_Products = Create DataStore
lds_ConDate = Create DataStore
lds_ConCustom = Create DataStore

if IsValid(w_contract) then
	//ll_ViewId = w_contract.tab_contract_details.tabpage_qrg.tab_1.tabpage_selection.dw_basic_info.il_ViewId
	ll_ViewId = gi_contract_view_id //06.16.2011 by jervis
	
	ls_ConDetailSQL = of_GetSQLSyntax(ll_ViewId,"tabpage_details","Details->Contract Detail")
	lds_ConDetail.Create(ls_ConDetailSQL)
	
	ls_ConProduSQL = of_GetSQLSyntax(ll_ViewId,"tabpage_details","Details->Products")
	lds_Products.Create(ls_ConProduSQL)
	
	ls_ConDateSQL = of_GetSQLSyntax(ll_ViewId,"tabpage_details","Details->Contract Dates")
	lds_ConDate.Create(ls_ConDateSQL)
	
	ls_ConCustomSQL = of_GetSQLSyntax(ll_ViewId,"tabpage_details","Details->Custom Data Tab->Custom Data")
	lds_ConCustom.Create(ls_ConCustomSQL)
end if

for ll_Cycle = 1 to ids_basic_info.rowcount( )
	ls_Field_Name = ids_basic_info.GetItemString(ll_Cycle,'field_name')
	ll_Selected = ids_basic_info.GetItemNumber(ll_Cycle,'selected')
	child_basic_info.Modify(ls_Field_Name + ".Visible = " + String(ll_Selected))
	child_basic_info.Modify(ls_Field_Name + '_t' + ".Visible = " + String(ll_Selected))
	
	//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
	//<$>added :long.zhang 10.12.2012
	//<$>reason:Modify product name property this shoud be same with product tye
	if ls_Field_Name = "product_type" then
		child_basic_info.Modify("product_name.Visible = " + String(ll_Selected))
		child_basic_info.Modify("product_name_t.Visible = " + String(ll_Selected))
	end if
	//---------End Modfiied ------------------------------------------------------

	if ll_Selected <> 0 and IsValid(w_contract) then
		Choose Case ls_Field_Name
			Case 'ctx_id','category','status','contract_type','file_location','dvision','app_facility','master_contract_name','total_processing_time'
				ls_DispText = lds_ConDetail.Describe(ls_Field_Name + '_t' + ".Text")
			Case 'product_type'
				ls_DispText = lds_Products.Describe(ls_Field_Name + '_t' + ".Text")
				
				//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
				//<$>added:long.zhang 10.12.2012
				//<$>reason:get product type code
				ls_dddwName = lds_Products.Describe(ls_Field_Name + ".DDDW.Name")
				if LenA(ls_dddwName) > 1 then
					ls_Tag = lds_Products.Describe(ls_Field_Name + ".Tag")
					ls_DataCol = lds_Products.Describe(ls_Field_Name + ".DDDW.DataColumn")
					ls_DispCol = lds_Products.Describe(ls_Field_Name + ".DDDW.DisplayColumn")		
					
					child_basic_info.Modify(ls_Field_Name + ".DDDW.Name = '" + ls_dddwName + "'")
					child_basic_info.Modify(ls_Field_Name + ".DDDW.DataColumn = '" + ls_DataCol + "'")
					child_basic_info.Modify(ls_Field_Name + ".DDDW.DisplayColumn = '" + ls_DispCol + "'")
					
					ll_Rtn = child_basic_info.GetChild(ls_Field_Name,ldwc_Child)
					if ll_Rtn = 1 then
						ldwc_Child.SetTransObject(SQLCA)
						ldwc_Child.Retrieve(ls_Tag)
					end if
				end if
				//---------End Modfiied ------------------------------------------------------

			Case 'product_name'
				ls_DispText = lds_Products.Describe("product_id_t" + ".Text")
			Case 'effective_date','expriation_date','review_date','review_by','term_date','term_reason','last_revis_date','other_date_1','other_date_2','version_number','version_date'
				ls_DispText = lds_ConDate.Describe(ls_Field_Name + '_t' + ".Text")
			Case 'custom_1','custom_2','custom_3','custom_4','custom_5','custom_6','custom_7','custom_8','custom_9','custom_10','custom_11','custom_12','custom_13','custom_14','custom_15','custom_16','custom_17','custom_18','custom_19','custom_20','custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10','custom_n1','custom_n2','custom_n3','custom_n4','custom_n5','custom_n6','custom_n7','custom_n8','custom_n9','custom_n10'
				ll_Selected = long(lds_ConCustom.Describe(ls_Field_Name + ".Visible"))
				if ll_Selected = 0 then
					child_basic_info.Modify(ls_Field_Name + ".Visible = " + String(ll_Selected))
					child_basic_info.Modify(ls_Field_Name + '_t' + ".Visible = " + String(ll_Selected))
					CONTINUE
				end if
				
				ls_DispText = lds_ConCustom.Describe(ls_Field_Name + '_t' + ".Text")
				
				ls_dddwName = lds_ConCustom.Describe(ls_Field_Name + ".DDDW.Name")
				if Len(ls_dddwName) > 1 then
					ls_Tag = lds_ConCustom.Describe(ls_Field_Name + ".Tag")
					ls_DataCol = lds_ConCustom.Describe(ls_Field_Name + ".DDDW.DataColumn")
					ls_DispCol = lds_ConCustom.Describe(ls_Field_Name + ".DDDW.DisplayColumn")		
					
					child_basic_info.Modify(ls_Field_Name + ".DDDW.Name = '" + ls_dddwName + "'")
					child_basic_info.Modify(ls_Field_Name + ".DDDW.DataColumn = '" + ls_DataCol + "'")
					child_basic_info.Modify(ls_Field_Name + ".DDDW.DisplayColumn = '" + ls_DispCol + "'")
					
					ll_Rtn = child_basic_info.GetChild(ls_Field_Name,ldwc_Child)
					if ll_Rtn = 1 then
						ldwc_Child.SetTransObject(SQLCA)
						ldwc_Child.Retrieve(ls_Tag)
					end if
				end if
			Case else
				CONTINUE
		End Choose
		
		if Not (IsNull(ls_DispText) or Trim(ls_DispText) = "" or Trim(ls_DispText) = "!") then
			child_basic_info.Modify(ls_Field_Name + '_t' + ".Text = '" + ls_DispText + "'")
			
			if ls_Field_Name = 'app_facility' or ls_Field_Name = 'category'  &
				or ls_Field_Name = 'product_type' or ls_Field_Name = 'product_name' &
				or ls_Field_Name = 'effective_date' or ls_Field_Name = 'expriation_date' &
				or ls_Field_Name = 'other_date_1' or ls_Field_Name = 'other_date_2' then
				
				ids_requestor.Modify(ls_Field_Name + '_t' + ".Text = '" + ls_DispText + "'")
			end if
		end if
	end if
next

Destroy lds_ConDetail
Destroy lds_Products
Destroy lds_ConDate
Destroy lds_ConCustom

Return 0

end function

private function integer of_modify_contact_info ();/******************************************************************************************************************
**  [PUBLIC]   : of_modify_contact_info( /*datawindowchild adw_child */)
**==================================================================================================================
**  Purpose   	: Functions set then modification properties for the report
**==================================================================================================================
**  Arguments 	: [datawindowchild]  adw_child - the child datawindow of the report
**               [u_dw]             ids_requestor_dw  the datawindow that has the selections
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

long 		ll_colcount,ll_i,ll_ViewId
long 		ll_current_col
String 	ls_col_name,ls_Field_Name,ls_ContactSQL,ls_DispText
long 		ll_Selected_Value

DataStore	lds_Contact

lds_Contact = Create DataStore

if IsValid(w_contract) then
	//ll_ViewId = w_contract.tab_contract_details.tabpage_qrg.tab_1.tabpage_selection.dw_basic_info.il_ViewId
	ll_viewId = gi_contract_view_id //06.16.2011 by jervis
	ls_ContactSQL = of_GetSQLSyntax(ll_ViewId,"tabpage_details","Details->Our Company Contact")
	lds_Contact.Create(ls_ContactSQL)
end if

for ll_i = 1 to ids_contact_info.RowCount( )
	ls_Field_Name = ids_contact_info.GetItemString(ll_i,'field_name')
	ll_Selected_Value = ids_contact_info.GetItemNumber(ll_i,'selected')
	choose case ls_Field_Name
		   case 'id' 
				 	ids_requestor.Object.dw_rpt_contacts.Object.id.Visible = string(ll_Selected_Value)
			  	  	ids_requestor.Object.dw_rpt_contacts.Object.id_t.Visible = string(ll_Selected_Value) 
         case 'association' 
				 	ids_requestor.Object.dw_rpt_contacts.Object.association.Visible = string(ll_Selected_Value)
			  		ids_requestor.Object.dw_rpt_contacts.Object.association_t.Visible = string(ll_Selected_Value) 
         case 'last_name'
			  		ids_requestor.Object.dw_rpt_contacts.Object.last_name.Visible = string(ll_Selected_Value)
			  		ids_requestor.Object.dw_rpt_contacts.Object.last_name_t.Visible = string(ll_Selected_Value)   
         case 'first_name'
				 	ids_requestor.Object.dw_rpt_contacts.Object.first_name.Visible = string(ll_Selected_Value)
			  		ids_requestor.Object.dw_rpt_contacts.Object.first_name_t.Visible = string(ll_Selected_Value) 
         case 'middle_name'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.middle_name.Visible = string(ll_Selected_Value)
			  		ids_requestor.Object.dw_rpt_contacts.Object.middle_name_t.Visible = string(ll_Selected_Value) 
         case 'ic_area'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.ic_area.Visible = string(ll_Selected_Value)
			  		ids_requestor.Object.dw_rpt_contacts.Object.ic_area_t.Visible = string(ll_Selected_Value) 
         case 'ctx_contacts_contact_type'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.type.Visible = string(ll_Selected_Value)
			  		ids_requestor.Object.dw_rpt_contacts.Object.type_t.Visible = string(ll_Selected_Value)
					
					ls_DispText = lds_Contact.Describe("contact_type_t" + ".Text")					//Added by Scofield on 2008-08-05
					ids_requestor.Object.dw_rpt_contacts.Object.type_t.Text = ls_DispText		//Added by Scofield on 2008-08-05
         case 'contact_title'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.title.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.title_t.Visible = string(ll_Selected_Value) 
         case 'ctx_contacts_contact_department'   
					ids_requestor.Object.dw_rpt_contacts.Object.department.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.department_t.Visible = string(ll_Selected_Value)
         case 'ctx_contacts_street_1'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.street_1.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.street_1_t.Visible = string(ll_Selected_Value)
         case 'ctx_contacts_street_2'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.street_2.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.street_2_t.Visible = string(ll_Selected_Value)
         case 'ctx_contacts_street_3'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.street_3.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.street_3_t.Visible = string(ll_Selected_Value)
         case 'ctx_contacts_city'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.city.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.city_t.Visible = string(ll_Selected_Value)
         case 'ctx_contacts_state'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.state.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.state_t.Visible = string(ll_Selected_Value)
         case 'ctx_contacts_zip'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.zip.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.zip_t.Visible = string(ll_Selected_Value)
         case 'custom_1'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_1.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_1_t.Visible = string(ll_Selected_Value)
         case 'custom_2'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.last_name.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.last_name_t.Visible = string(ll_Selected_Value)
         case 'custom_3'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_3.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_3_t.Visible = string(ll_Selected_Value)
         case 'custom_4'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_4.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_4_t.Visible = string(ll_Selected_Value)
         case 'custom_5'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_5.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_5_t.Visible = string(ll_Selected_Value)
         case 'custom_6'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_6.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_6_t.Visible = string(ll_Selected_Value)
         case 'custom_7'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_7.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_7_t.Visible = string(ll_Selected_Value)
         case 'custom_8'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_8.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_8_t.Visible = string(ll_Selected_Value)
         case 'custom_9'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_9.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_9_t.Visible = string(ll_Selected_Value)
         case 'custom_10'   
				 	ids_requestor.Object.dw_rpt_contacts.Object.custom_10.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.custom_10_t.Visible = string(ll_Selected_Value)
         case 'local' 
				  	ids_requestor.Object.dw_rpt_contacts.Object.local.Visible = string(ll_Selected_Value)
			   	ids_requestor.Object.dw_rpt_contacts.Object.local_t.Visible = string(ll_Selected_Value)
	  		//-----Begin Added by Alfee on 04.18.2008-----------------------------------------------
	  	   case 'contact_email'
					if ll_Selected_Value = 0 then
						ids_requestor.Object.dw_rpt_contacts.Object.dw_1.object.contact_email.Visible = string(ll_Selected_Value)
					end if
		   case 'via' 
					if ll_Selected_Value = 0 then
			   		ids_requestor.Object.dw_rpt_contacts.Object.dw_1.object.via.Visible = string(ll_Selected_Value)
					end if
	   	case 'ext'
					if ll_Selected_Value = 0 then
						ids_requestor.Object.dw_rpt_contacts.Object.dw_1.object.ext.Visible = string(ll_Selected_Value)
						ids_requestor.Object.dw_rpt_contacts.Object.dw_1.object.t_1.Visible = string(ll_Selected_Value)					
					end if
		   case 'phone'
					if ll_Selected_Value = 0 then
						ids_requestor.Object.dw_rpt_contacts.Object.dw_1.object.phone.Visible = string(ll_Selected_Value)					
					end if
	  		//-----End Added ------------------------------------------------------------------------	  
	end choose 
next

Destroy lds_Contact

return 0

end function

private function integer of_add_bitmap ();/******************************************************************************************************************
**  [PUBLIC]   : of_add_bitmap
**==================================================================================================================
**  Purpose   	: set the bitmap on the report
**==================================================================================================================
**  Arguments 	: [u_dw]  event datawindow
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

blob  b
long  job
long  ll_height,ll_width
string ls_file 
long ll_magnificatin_factor 

ll_magnificatin_factor = 3

ls_file = "C:\company_logo.bmp"


//////////////////////////////////////////////////////////////////////////////////////////////
// read in the bitmap (jpg does no seem to work )
//////////////////////////////////////////////////////////////////////////////////////////////

job = FileOpen(ls_file, StreamMode!, Read! )
FileRead( job, b )
fileclose(job)

//////////////////////////////////////////////////////////////////////////////////////////////
// calculate the width and height of the bitmap
//////////////////////////////////////////////////////////////////////////////////////////////

ll_width  = Long( Integer( BlobMid( b, 19, 2 ) ), Integer( BlobMid( b, 21, 2) ) )
ll_height = Long( Integer( BlobMid( b, 23, 2 ) ), Integer( BlobMid( b, 25, 2) ) )

//////////////////////////////////////////////////////////////////////////////////////////////
// set the bit map and it properties
//////////////////////////////////////////////////////////////////////////////////////////////

child_basic_info.Modify( "p_1.filename= '" + ls_file + "'" ) 
child_basic_info.modify("p_1.width = " + string(ll_width * ll_magnificatin_factor))
child_basic_info.modify("p_1.height = " + string(ll_height* ll_magnificatin_factor))

//////////////////////////////////////////////////////////////////////////////////////////////
// pull the header up - make the report cover visable
//////////////////////////////////////////////////////////////////////////////////////////////

ids_requestor.Object.dw_rpt_cover.Visible = true
ids_requestor.Modify("DataWindow.Header.Height='"+string(0)+"'")

//////////////////////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////////////////////

ids_requestor.Object.page_no_cover.Visible = false
//adw.Object.page_with_cover.Visible = true


return 0
end function

public function integer of_set_original_sql (u_dw adw);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 07 event December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

choose case adw.dataobject
	case 'd_qrg_sys_fields'
		  is_sys_fields_sql_orig    = adw.Describe("DataWindow.Table.Select")
	case 'd_profile_codes'
		  is_profile_codes_sql_orig      = adw.Describe("DataWindow.Table.Select")
	case else 
		
end choose 





return 0
end function

public function integer of_modify_dw (u_dw adw, long profile_id);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
n_cst_sql inv_cst_sql
n_cst_sqlattrib astr_sql[]
n_cst_string lnv_string
string ls_search_string
string error_create
string ls_criteria
string ls_filter
string ls_string
LONG ll_null
LONG ll_found_row
LONG LL_ACTION_TYPE
setnull(ll_null)

of_set_orginal_sql(adw,of_get_orginal_sql(adw))

if profile_id > 0 then
		
		
		inv_cst_sql.OF_parse( adw.Describe("DataWindow.Table.Select"), astr_sql)
		
		choose case adw.dataobject
			case 'd_qrg_sys_fields' , 'd_profile_codes'
				  astr_sql[1].s_where = astr_sql[1].s_where + " AND ctx_report_profile_det.ctx_rpt_prfl_det_id = " + string(profile_id) + " AND ctx_report_profile_det.ctx_rpt_prfl_id = " + string(profile_id)
			case else
		end choose 
		
		//ls_string = inv_cst_sql.of_Assemble(astr_sql)
		
		//messagebox('',adw.Modify("DataWindow.Table.Select=" + of_get_orginal_sql(adw) + astr_sql[1].s_where ))
     // messagebox(string(adw.SetSQLSelect(ls_string)), ls_string )
end if 


adw.event pfc_retrieve()

return 0

end function

public subroutine of_set_ctx_id (long al_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_cxt_reports.of_set_ctx_id()
// $<arguments>
//		value	long	al_ctx_id		Contract ID
// $<returns> (none)
// $<description> Store contract ID into instance variable.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.22.2006 by Rodger Wu
//////////////////////////////////////////////////////////////////////

il_ctx_id = al_ctx_id;
end subroutine

public function string of_getsqlsyntax (long al_viewid, string as_tabname, string as_scrname);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------
// Function: of_GetSQLSyntax()
//------------------------------------------------------------------------------
// Description: Get the SQL Syntax from database
// Arguments:
//		1 -- View ID
//		2 -- Tab Name
//		3 -- Screen Name
// Return Value: 
//		0 -- SQL Syntax
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-08-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String		ls_SQL,ls_Temp, ls_Screen_style
long		ll_DataLen,ll_Cycle,ll_Count,ll_Start

long		READ_ONE_LENGTH = 8000

//modified by gavins 20120313 grid
SELECT ( case when screen_style = 'G' Then DataLength(grid_sql) else DataLength(dw_sql) end ), screen_style 
  INTO :ll_DataLen, :ls_Screen_style
  FROM ctx_screen 
 WHERE data_view_id = :al_ViewID and tab_name = :as_TabName and screen_name = :as_ScrName;

//------Begin Modified by Alfee 04.23.2010 ------------  //(Appeon)Harry 06.07.2013 - V141 ISG-CLX
//<$Reason>Inapplicable for a Text field
//if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
if AppeonGetClientType() = 'PB' and ll_DataLen > READ_ONE_LENGTH then
//-------End Modified ---------------------------------
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		If ls_Screen_style = 'G' Then
			SELECT SubString(grid_sql,:ll_Start,:READ_ONE_LENGTH)
			  INTO :ls_Temp
			  FROM ctx_screen
			 WHERE data_view_id = :al_ViewID and tab_name = :as_TabName and screen_name = :as_ScrName;
		Else
			SELECT SubString(dw_sql,:ll_Start,:READ_ONE_LENGTH)
			  INTO :ls_Temp
			  FROM ctx_screen
			 WHERE data_view_id = :al_ViewID and tab_name = :as_TabName and screen_name = :as_ScrName;
		End If
		
		ls_SQL += ls_Temp
	next
else
	SELECT ( case when screen_style = 'G' then grid_sql else dw_sql end )
	  INTO :ls_SQL
	  FROM ctx_screen
	 WHERE data_view_id = :al_ViewID and tab_name = :as_TabName and screen_name = :as_ScrName;
end if

Return ls_SQL

end function

on n_cst_cxt_reports.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_cxt_reports.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
ids_basic_info =  create n_ds
ids_basic_info.dataobject = 'd_qrg_sys_fields'

ids_contact_info =  create n_ds
ids_contact_info.dataobject = 'd_qrg_sys_fields'






//	invo_dwsrv =  create n_cst_dssrv	2007.7.12 By Jervis
end event

