$PBExportHeader$u_tabpg_contract_search.sru
$PBExportComments$[intellicontract_tab] The search tab
forward
global type u_tabpg_contract_search from u_tabpg_contract_master
end type
type cb_2 from u_cb within u_tabpg_contract_search
end type
type cb_1 from u_cb within u_tabpg_contract_search
end type
type cb_3 from u_cb within u_tabpg_contract_search
end type
type cb_print from u_cb within u_tabpg_contract_search
end type
type dw_search from u_dw_contract within u_tabpg_contract_search
end type
type dw_search_det1 from u_dw_contract within u_tabpg_contract_search
end type
type cbx_1 from checkbox within u_tabpg_contract_search
end type
type cb_5 from commandbutton within u_tabpg_contract_search
end type
type cb_4 from commandbutton within u_tabpg_contract_search
end type
type st_vbar2 from u_st_splitbar within u_tabpg_contract_search
end type
type st_hbar from u_st_splitbar within u_tabpg_contract_search
end type
type gb_document_view from groupbox within u_tabpg_contract_search
end type
type tv_ctx from u_tv within u_tabpg_contract_search
end type
type gb_to_do_list from groupbox within u_tabpg_contract_search
end type
type st_vbar from u_st_splitbar within u_tabpg_contract_search
end type
type st_hbar2 from u_st_splitbar within u_tabpg_contract_search
end type
end forward

global type u_tabpg_contract_search from u_tabpg_contract_master
string tag = "test"
integer width = 3877
integer height = 2016
string text = "Search"
event ue_search ( )
event ue_show_constructor ( )
event ue_set_screen_properties ( )
event ue_locate_treeview ( long al_ctx_id )
event ue_locate_dw_search ( long al_ctx_id )
event ue_tv_settings ( )
event ue_tv_expandall ( )
event ue_tv_collapseall ( )
event ue_tv_expandgroup ( )
event ue_tv_related_ctx ( long al_ctx_id )
event ue_powerfilter ( )
event ue_search_filter ( string as_filter,  boolean abn_search_button )
event ue_select_all ( )
event ue_set_as_default ( string as_set_as_default )
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
cb_print cb_print
dw_search dw_search
dw_search_det1 dw_search_det1
cbx_1 cbx_1
cb_5 cb_5
cb_4 cb_4
st_vbar2 st_vbar2
st_hbar st_hbar
gb_document_view gb_document_view
tv_ctx tv_ctx
gb_to_do_list gb_to_do_list
st_vbar st_vbar
st_hbar2 st_hbar2
end type
global u_tabpg_contract_search u_tabpg_contract_search

type prototypes

Public Function Long Beep (Long dwFreq, Long dwDuration) Library "kernel32"
end prototypes

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.10.2007 By: Jack 
//$<reason> Fix a defect.
long il_ctx_id
boolean ib_retrieve
boolean ib_readonly_current = FALSE//for current contract, Alfee 09.30.2007
datastore ids_search
datastore ids_search_temp	//Add by jervis 06.23.2009
n_ds ids_ctx_group_user_view  //Added by Ken.Guo on 2009-02-12

//Add by Jack 03/23/2007
boolean ib_resize = False   
int ii_resiz = 0

boolean ib_accend = False  //Add by Jack 05/09/2007
string is_copy_contract    //Add by Jack 05/30/2007
string is_output1 //Add by Jack 07/18/2007
//---------------------------- APPEON END ----------------------------

constant string GB1_TITLE = 'Search Results'
string is_dw_search_sql
long il_max_ctx_id
boolean ib_retriev_detail
string is_filter_string

string is_contracted_entity
string is_app_facility
string is_effective_date
string is_expriation_date
string is_category
string is_product_type
string is_ctx_id
string is_group_id
string is_status
string is_group_multi_loc_id
string is_user_id
string is_product_name
///string is_owvproduct_name

n_cst_sql inv_sql
n_cst_sqlattrib lnv_sqlattrib[ ]
n_cst_string inv_string
//n_ds  ids_contract_access  11-22-2007 By Jervis

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.19.2006 By: LeiWei

string is_effective_date2
string is_expriation_date2
//datastore ids_contract_access_pt //commented by Ken.Guo on 2009-02-12
//---------------------------- APPEON END ----------------------------
datastore ids_contract_access_category //Added by Alfee 09.30.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.06.2006 By: Davis
long  il_contract_array[]	// Record contract array that the user has access to
//---------------------------- APPEON END ----------------------------

Boolean	ib_PostOpen

//<add> 11/23/2007 by: Andy
Boolean	ib_FistTime = true

//<add> 12.19.2008 By Jervis
long il_pre_width,il_pre_height

//<add> 1.14.2009 By Alan 
Boolean ib_autoretrieve
Boolean ib_retrieved_ctx = False //Added By Ken.Guo 2009-06-03.
Boolean ib_force_retrieve = True //Added By Ken.Guo 2009-06-03.

//Added By Ken.Guo 2009-10-28.
datastore ids_ctx_tv_map,ids_group_tv_map
datastore ids_search_temp_child
datastore ids_dddw_columns
long il_child_ctx_start,il_cnt,il_root
long il_sub_row_start
String is_sort_column
Boolean ib_tree_view
Boolean ib_group_view
Boolean ib_FilterValue

n_cst_ctx_tv inv_ctx_tv
Long il_tv_ctx_current_handle

long il_sub_ctx_count

Integer ii_style
Integer ii_hidebrowse = 0

Integer ii_max_col_len[]

String is_tv_col_name[] = {'ctx_id','owner','facility_name','category_name','contract_type_name','status_name','dvision_name'	}

DataStore ids_search_related_ctx

Long il_tv_ctx_id //current ctx id in treeview //Added By Ken.Guo 12/10/2011. 

Boolean ib_Trigger_RowChangeEvent = True //Added By Ken.Guo 03/31/2012. 

n_cst_PowerFilter iu_PowerFilter //Added By Ken.Guo 10/30/2012. Support PowerFilter
Datastore						ids_templates_list			//Added By Mark Lee 11/16/2012
String 		is_position_setting				//Added By Mark Lee 11/29/2012		//Position Setting		// 1 : Document Preview left ; 					0 : Document Preview right;			
																																// 1 : Contract Parent Child Tree right; 		0 : Contract Parent Child Tree Left;
Integer 		ii_border	    = 18				//Added By Mark Lee 04/12/2013  it don't effect the real size.																											
String 		is_position_setting_other																																	
DataStore						ids_search_filter			//Added By Mark Lee 12/21/2012			
String 		is_hbar2 = ''

String			is_RightMenuType='' //Added by gavins 20130408
Boolean		ib_RowChangedSetRedraw //added by gavins 20130415
end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_validation ()
public subroutine of_create_dw ()
public subroutine of_reset_filter ()
public subroutine of_build_filter ()
public function integer of_collapse_row (long al_ctx_id, long al_row)
public function integer of_filter ()
public function boolean of_get_access (long al_ctx_id)
public subroutine of_build_filter_bak ()
public subroutine of_refresh_ctx_view ()
public function long of_get_ctx_view (long al_category, long al_ctx_id)
public function long of_retrieve_ctx ()
public subroutine of_copy_row_old ()
public subroutine of_copy_row ()
public subroutine of_display_row_old (long al_ctx_id, long al_row)
public subroutine of_display_row (long al_ctx_id, ref long al_row)
public subroutine of_expand_row (long al_ctx_id, long al_row)
public subroutine of_dsretrieve_dddw (ref datastore ads_search, boolean ab_autoretrieve)
public function integer of_gen_treeview_child (long al_ctx_id, long al_parent_handle)
public function integer of_gen_treeview ()
public function integer of_copy_row_tv ()
public subroutine of_set_parent_top (ref datastore ads_source)
public subroutine of_set_style ()
public function string of_getitem (datastore ads_datasource, string as_col, long al_row)
public function string of_replace_sort (string as_sort)
public subroutine of_tv_set_group_sum ()
public function integer of_gen_treeview_other ()
public function integer of_gen_treeview_child (long al_ctx_id, long al_parent_handle, string as_type)
public subroutine of_tv_group_sum_update (long al_handle, long al_add_count)
public subroutine of_set_style (integer ai_style)
public subroutine of_tv_get_max_len (datastore ads_datasource)
public function string of_getitem (datastore ads_datasource, string as_col, long al_row, boolean ab_use_mask)
public function integer of_set_auto_refresh (boolean ab_auto)
public function integer of_get_related_child_ctx (long al_ctx_id)
public subroutine of_refresh_tv (datastore ads_data)
public subroutine of_get_related_ctx (long al_ctx_id, string as_type)
public function long of_get_related_parent_ctx (long al_ctx_id)
public function string of_build_doc_filter (long al_doc_id, string as_doc_name, string as_doc_content, long al_doc_category, long al_doc_status)
public function string of_build_contact_filter (string as_sql, string as_name, string as_email, string as_association, string as_custom1, double adb_customn1, string as_class, string as_contact)
public function long of_move_ctx_to_browsedw (long al_ctx_id)
public function string of_build_contact_filter (datastore ads_value, string as_sql)
public subroutine of_powerfilter (string as_value)
public subroutine of_set_styles (boolean abn_retrieve)
public subroutine of_create_templates_list ()
public subroutine of_create_menu_item ()
public subroutine of_register_object (string as_type)
public subroutine of_refresh_menu_status ()
public subroutine of_create_downarraw ()
public subroutine of_popmenu (string as_filter)
public subroutine of_refresh_filtername ()
public subroutine of_set_default_bar_position ()
public function integer of_tv_set_font ()
end prototypes

event ue_search();

of_retrieve( )
end event

event ue_show_constructor();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_constructor()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Execute constructor event when shows window
//////////////////////////////////////////////////////////////////////
// $<add> 11/04/2008 by Scofield
//////////////////////////////////////////////////////////////////////

long 		ll_Right
String	ls_Error
String 	ls_browse_screen_results_style  				//Added By Mark Lee 10/26/12
this.SetRedraw(false)

//Auto Refresh Toolbar Item - jervis 10.28.2010
if isvalid(m_pfe_cst_mdi_menu_contract) then
	If ib_autoretrieve Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh,'toolbaritemdown', True)
		m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.tag = 'auto'
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh,'toolbaritemdown', False)
		m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.tag = 'non-auto'
	End If
end if

if IsValid(gds_contract_screen) then
	if IsNull(gi_contract_view_id) or gi_contract_view_id = 0 then gi_contract_view_id = 1001
	
	gds_contract_screen.SetTransObject(SQLCA)
	gds_contract_screen.Retrieve(gi_contract_view_id)
end if

of_create_dw()

ll_Right = w_mdi.of_security_access(2081)
if ll_Right = 0 then
	dw_Search.Object.b_more.Visible = false
	//dw_Search.Object.b_clear.X = Long(dw_Search.Object.owner.X) + Long(dw_Search.Object.owner.Width) - Long(dw_Search.Object.b_clear.Width)
	dw_Search.Object.b_clear.x = dw_Search.Object.b_search.x
	dw_Search.Object.b_search.x = dw_Search.Object.b_more.x
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-03-23 By: Ken.Guo
//$<reason> Add the right to the Print button.
//ll_Right = w_mdi.of_security_access(6952)
//If ll_Right = 1 Then
//	cb_print.visible = True
//Else
//	cb_print.visible = False
//End If
//---------------------------- APPEON END ----------------------------

if Not ib_autoretrieve then //(Appeon)Harry 02.13.2014 - for Bug # 3867
	dw_Search.ib_Retrieve_Drop_Downs = false
	dw_Search.Event ue_PopulateDDDWs()
end if
dw_Search.InsertRow(0)

//ls_Error = dw_Search.Modify("b_more.text='<< Less'")
ls_Error = dw_Search.Modify("b_more.text='more >>'") //Jervis 08.24.2010
if ls_Error = "" then
	ib_FistTime = true
	//12.8.2008 By Jervis use post,exec this when  contract event of dw_Search was complated
	//dw_Search.Event ue_MoreAndLess()
	dw_Search.post Event ue_MoreAndLess(true)	//change false to true - jervis 08.24.2010
end if

dw_Search_Det1.ib_Retrieve_Drop_Downs = false
dw_Search_Det1.Event ue_PopulateDDDWs()

This.Event ue_set_screen_properties()		//Added by Scofield on 2008-12-22

//Begin - Added By Mark Lee 10/26/12
ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )
If isnull(ls_browse_screen_results_style ) or trim(ls_browse_screen_results_style ) = '' Then 
//	//Added By Ken.Guo 2009-12-29.			//Added By Mark Lee 11/08/2012
//	If Not isvalid(inv_ctx_tv) Then
//		inv_ctx_tv = Create n_cst_ctx_tv
//		inv_ctx_tv.event ue_retrieve( )		
//		of_set_style() 
//	Else
		of_set_style() 
//	End If
Else
	of_set_styles(False)
End If
//End - Added By Mark Lee 10/26/12

this.SetRedraw(true)

If isvalid(inv_resize) Then //Added By Ken.Guo 09/10/2012. added isvalid() function
	inv_resize.event pfc_resize(1, this.width, this.height)
End If

end event

event ue_set_screen_properties();// Set screen properties (show titlebar is default)
dw_search.of_set_properties(dw_search.il_ViewID, dw_search.il_ScreenID, "Y")
dw_search_det1.of_set_properties(dw_search_det1.il_ViewID, dw_search_det1.il_ScreenID, "Y")
dw_search_det1.title = 'Contract Browse ' + "(" + string(dw_search_det1.rowcount()) + ")"



end event

event ue_locate_treeview(long al_ctx_id);//////////////////////////////////////////////////////////////////////
// $<event>ue_locate_treeviewu_tabpg_contract_search()
// $<arguments>
//		long	al_ctx_id		
// $<returns> (None)
// $<description>
// $<description> Locate treeview item from dw_browse
//////////////////////////////////////////////////////////////////////
// $<add> 2009-10-28 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_handle ,ll_find_row,ll_handle_current
//treeviewitem ltvi_1

If ib_Trigger_RowChangeEvent = False Then Return

If ib_tree_view Then
	ll_find_row = ids_ctx_tv_map.Find('ctx_id = ' + String(al_ctx_id),1,ids_ctx_tv_map.rowcount() )
	If ll_find_row > 0 Then
		ll_handle = ids_ctx_tv_map.GetItemNumber(ll_find_row,'tv_handle')
	End If
	If ll_handle > 0 Then
		ll_handle_current = tv_ctx.FindItem(CurrentTreeItem!, 1)
		If ll_handle_current = ll_handle Then Return
//		tv_ctx.getitem(ll_handle,ltvi_1)
		tv_ctx.SelectItem ( ll_handle )
		il_tv_ctx_current_handle = ll_handle
	End If
End If


end event

event ue_locate_dw_search(long al_ctx_id);Long ll_row

If ib_Trigger_RowChangeEvent = False Then Return

//Added By Ken.Guo 12/10/2011. 
If dw_search_det1.GetRow() = 0 Then Return
If dw_search_det1.GetItemNumber(dw_search_det1.GetRow(),'ctx_id') = al_ctx_id Then Return

ll_row = dw_search_det1.Find('ctx_id = ' + String(al_ctx_id), 1, dw_search_det1.rowcount()) 
If ll_row > 0 and dw_search_det1.GetRow() <> ll_row Then
	dw_search_det1.ScrolltoRow(ll_row)
	dw_search_det1.SetRow(ll_row)
End If


end event

event ue_tv_settings();String 	ls_browse_screen_results_style 				//Added By Mark Lee 10/26/12

OpenWithParm(w_ctx_tv_settings,inv_ctx_tv)

If Message.DoubleParm = 1 Then
	SetPointer(HourGlass!)
	tv_ctx.SetRedraw(False)
	inv_ctx_tv.of_refresh_var( )

   //of_refresh_tv(ids_search)
	This.of_copy_row_tv( )
	
	If inv_ctx_tv.ii_hidebrowse <> this.ii_hidebrowse Then
		//Begin - Added By Mark Lee 10/26/12
//		This.of_set_style()
		ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )
		If isnull(ls_browse_screen_results_style ) or trim(ls_browse_screen_results_style ) = '' Then 
			This.of_set_style()
		Else
			This.of_set_styles(False)
		End If
		//End - Added By Mark Lee 10/26/12
	End If
	IF dw_search_det1.GetRow() > 0 Then 			//Added By Mark Lee 11/29/2012
//		This.Post event ue_locate_treeview(dw_search_det1.GetItemNumber(dw_search_det1.GetRow(),'ctx_id'))
	 	event ue_locate_treeview(dw_search_det1.GetItemNumber(dw_search_det1.GetRow(),'ctx_id'))		//Added By Mark Lee 12/28/2012
	End if 
	//Added By Ken.Guo 04/09/2013
	If tv_ctx.visible Then
		This.of_tv_set_font( )
	End If
	tv_ctx.SetRedraw(True)
	dw_search_det1.event losefocus( )  //Added By Ken.Guo 04/29/2013. to set dw title
	SetPointer(Arrow!)
End If
end event

event ue_tv_expandall();tv_ctx.SetRedraw(False)
tv_ctx.expandall(1)
//This.Post event ue_locate_treeview(dw_search_det1.GetItemNumber(dw_search_det1.GetRow(),'ctx_id'))
event ue_locate_treeview(dw_search_det1.GetItemNumber(dw_search_det1.GetRow(),'ctx_id'))					//Added By Mark Lee 12/28/2012
tv_ctx.SetRedraw(True)
end event

event ue_tv_collapseall();tv_ctx.SetRedraw(False)
tv_ctx.collapseitem(1)
tv_ctx.SetRedraw(True)
end event

event ue_tv_expandgroup();Long i
tv_ctx.SetRedraw(False)
tv_ctx.expandall(1)
For i = 1 to ids_group_tv_map.Rowcount()
	tv_ctx.CollapseItem(ids_group_tv_map.GetItemNumber(i,'tv_handle') )
Next
tv_ctx.SetRedraw(True)
Return
end event

event ue_tv_related_ctx(long al_ctx_id);If al_ctx_id <= 0 Then Return
This.of_get_related_ctx( al_ctx_id, 'all')
end event

event ue_powerfilter();//Added By Ken.Guo 10/30/2012. Support PowerFilter.
//Set the	reversed value
String ls_powerfilter
ls_powerfilter =  gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_PowerFilter" ) 
If ls_powerfilter = '1' Then
	ls_powerfilter = '0'		
	This.of_powerfilter( '0' )
Else
	ls_powerfilter = '1'
	This.of_powerfilter( '1' )
End If
gnv_user_option.of_Set_option_value( gs_user_id, "Contract_Search_Tab_PowerFilter" ,ls_powerfilter ) 

end event

event ue_search_filter(string as_filter, boolean abn_search_button);//====================================================================
// Event: ue_search_filter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_filter
//                abn_search_button
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/03/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
datastore 	lds_search_filter
Long			ll_rowcnt, i , ll_row
String 		ls_ColName,ls_ColType,ls_Value

If isnull(as_filter) or trim(as_filter) = '' or Integer(as_filter) = 0 Then
	Return 
End If

lds_search_filter = create Datastore
lds_search_filter.dataobject = 'd_contract_search_filter'
lds_search_filter.settransobject( sqlca)
lds_search_filter.retrieve(gs_user_id,as_filter)

ll_rowcnt = lds_search_filter.rowcount( )

IF ll_rowcnt > 0 Then 
	dw_search.reset( )
	ll_row		=	dw_search.insertrow( 0)
	For i = 1 to ll_rowcnt
		ls_ColName = lds_search_filter.GetItemString(i,'column_name')
		ls_ColType = lds_search_filter.GetItemString(i,'col_type')
		ls_Value = lds_search_filter.GetItemString(i,'data_values')		
		
		Choose Case Lower(Left ( ls_ColType , 3 ))
			CASE 'int','num'
				dw_search.setitem( ll_row, ls_ColName, Integer(ls_Value))
			Case	'lon','ulo'
				dw_search.setitem( ll_row, ls_ColName, Long(ls_Value))
			Case 'dou'
				dw_search.setitem( ll_row, ls_ColName, Double(ls_Value))
			Case 'rea'
				dw_search.setitem( ll_row, ls_ColName, real(ls_Value))
			Case 'dec', 'mon'
				dw_search.setitem( ll_row, ls_ColName, Dec(ls_Value))
			//---------Begin Modified by (Appeon)Harry 03.20.2014 for V142 ISG-CLX--------
			/*
			CASE 'date'	
				dw_search.setitem( ll_row, ls_ColName, date(ls_Value))
			CASE 'datetime'
				dw_search.setitem( ll_row, ls_ColName, datetime(ls_Value))
			*/
			Case 'dat'
				if Lower(Left ( ls_ColType , 8 )) = 'datetime' then
					dw_search.setitem( ll_row, ls_ColName, datetime(ls_Value))
				else
					dw_search.setitem( ll_row, ls_ColName, date(ls_Value))
				end if
			//---------End Modfiied ------------------------
			CASE 'var','cha'				
				dw_search.setitem( ll_row, ls_ColName, ls_Value)
			Case Else
				//
		End Choose 
		//Added By Mark Lee 12/05/2012
		dw_search.Post event ue_post_itemchanged( ll_row, ls_ColName, ls_Value) 

	Next 
	If abn_search_button = True Then 
		dw_search.dynamic Trigger Event buttonclicked(ll_row,0,dw_search.object.b_search)
	End If
Else
	Return
End If


Destroy lds_search_filter
end event

event ue_select_all();//====================================================================
// Event: ue_select_all
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/05/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 		i ,		ll_rowcount


ll_rowcount = dw_search_det1.rowcount( ) 
If ll_rowcount > 0 then 
	For i = 1 to ll_rowcount 
		dw_search_det1.selectrow( i, true)
	Next 	
End If
end event

event ue_set_as_default(string as_set_as_default);//====================================================================
// Event: ue_set_as_default
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_set_as_default
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/03/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String ls_name,	ls_contract_search_filter_set_as_default

If Isnull(as_set_as_default) or Trim(as_set_as_default) = '' Then 
	Return
End If 

gnv_user_option.of_Set_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default",as_set_as_default )
gnv_user_option.of_save( )

this.of_Refresh_FilterName()


end event

public function integer of_retrieve ();/******************************************************************************************************************
**  [PUBLIC]   : of_retrieve()
**==================================================================================================================
**  Purpose   	: function fired when the user succufully changes the tab
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  31 May 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_ctx_id
long la_any
STRING LS_FILTER
long ll_count,ll_current_contract
long ll_null
long ll_found
long ll_ret 
SetPointer(Hourglass!)
if not ib_retriev_detail then return 0
if not ib_autoretrieve then return 0
ib_retriev_detail = False //Add by Jack 05/11/2007
//setredraw(false)

//Commented by Ken.Guo 2011-05-13. Forbit auto save.
iw_parent.function dynamic wf_reset_retrieved()
inv_contract_details.is_mode = inv_contract_details.edit
/*
la_any = iw_parent.event dynamic ue_save()
if la_any = failure then return success
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.05.2006 By: LeiWei
//$<reason> Performance tuning
/*
dw_search_det1.event pfc_retrieve( )
*/
//Start code change---11.29.2006 Henry. to refresh the contract cache data before retrieve data.
if not gb_use_opmode  then
	gnv_app.ib_ref_cache = true
	gnv_app.of_setcontraccache( )
	gnv_app.of_setcontraccache_code_lookup( FALSE)
end if
//TODO-refresh cache data from code_lookup
//End code change---11.29.2006

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.30.2007 By: Jack 
//$<reason> Fix a defect.
ib_retrieve = False
//---------------------------- APPEON END ----------------------------

ids_search.setfilter('')


//ll_ret = ids_search.Retrieve(Upper(gs_user_id )) //Jump out of APB queue,Maybe APB Bug Ken.Guo 2009-02-12 //Commented By Ken.Guo 2009-06-03
ll_ret = of_retrieve_ctx() //Added By Ken.Guo 2009-06-03. use function to retrieve

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2009 By: Ken.Guo
//$<reason> Catch SP error infomation
If ll_ret < 0 or SQLCA.sqlcode < 0 Then
	Messagebox('SP Error '+String(SQLCA.sqlcode),'Failed to retrieve the contracts data, please call support.~r~n'+SQLCA.sqlerrtext)
	Return -1
End If
//---------------------------- APPEON END ----------------------------

// The following script moved from of_build_filter().
//	ids_contract_access.retrieve(UPPER(gs_user_id ))   11-22-2007 By Jervis

// The following script moved from w_contract.pfc_postopen().
w_contract lw_tmp
If iw_parent.classname() = 'w_contract' Then //Added By Ken.Guo 2009-06-17. Add if condition.
	lw_tmp = iw_parent
	IF Isvalid(lw_tmp) THEN
		IF lw_tmp.ib_win_just_open THEN
			//Begin - Added By Mark Lee 11/09/2012		bug
			IF isvalid(lw_tmp.inv_contract_codes) Then
				lw_tmp.inv_contract_codes.of_del_ctx_directory( )
			End If
			//End - Added By Mark Lee 11/09/2012
		END IF
	END IF
End If

gnv_appeondb.of_startqueue() //Added by Ken.Guo on 2009-02-09

// Perofrmanct tuning for of_get_access
//---------Begin Modified by Alfee 09.30.2007--------
//ids_contract_access_pt.Retrieve( )
//ids_contract_access_pt.Retrieve( gs_user_id ) //commented by Ken.Guo on 2009-02-12
ids_ctx_group_user_view.Retrieve(gs_user_id) //Added by Ken.Guo on 2009-02-12
ids_contract_access_category.Retrieve( gs_user_id )
//---------End Modified -----------------------------

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//Start Change By Jervis 01032008
//Fixed BugG122901
if ids_search.rowcount( ) > 0 then
	il_contract_array = ids_search.object.ctx_id.current	// 11-22-2007 By Jervis :Record contract array that the user has access to 
	if isValid(w_contract_globalsearch) then	w_contract_globalsearch.of_set_contractarray(il_contract_array[])	//long.zhang 04.19.2013  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
end if
//End Change By Jervis 01032008


//Start Change Code By Jervis 08.23.2007
//Move to of_filter 
of_filter()

return success
end function

public function integer of_validation ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: force the user to select  a contract before continuning 
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



if  dw_search_det1.GetSelectedRow ( 0 ) = 0 and  inv_contract_details.is_mode = "EDIT" then 
	//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
	/*
	//Messagebox('Contract', 'Please select a contact.')
	st_1.text = "Please select a contract."
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 12.14.2006 By: Davis
//$<reason> Comment out beep.
//	Beep (5000, 100)
//---------------------------- APPEON END ----------------------------
	return failure
	*/
	if inv_contract_details.of_get_ctx_id( ) <> 0 and isvalid(w_contract_globalsearch) then
	else
		//Messagebox('Contract', 'Please select a contact.')
		st_1.text = "Please select a contract."
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 12.14.2006 By: Davis
	//$<reason> Comment out beep.
	//	Beep (5000, 100)
	//---------------------------- APPEON END ----------------------------
		return failure
	end if
	//---------End Modfiied ------------------------------------------------------
end if 

return success
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_searchof_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description> Contract module modification 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.26.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name,ls_dw_name[],ls_dataobject[]
datawindow ld_dw[]

ls_tab_name = 'tabpage_search'
ld_dw[1] = dw_search
ld_dw[2] = dw_search_det1
ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
f_create_contract_dw(gl_SearchTab_View_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)

//Added By Mark Lee 12/20/2012
of_create_downarraw()

//Added By Ken.Guo 10/30/2012. Support PowerFilter
If isvalid(iu_PowerFilter) Then
	iu_PowerFilter.of_setoriginalfilter( )
	iu_PowerFilter.of_SetDW(dw_search_det1)
	iu_PowerFilter.event ue_clicked()
End If

If iw_parent.classname() = 'w_contract' Then
	iw_parent.function dynamic wf_set_select('tabpage_search',true) 
End If

tv_ctx.backcolor = Long(dw_search_det1.describe("Datawindow.color"))

//Added By Mark Lee 10/29/12
If Isvalid(w_todolist_contract) Then
	w_todolist_contract.uo_todolist.of_set_bg_color(Long(dw_search_det1.describe("Datawindow.color"))) //Modified By Ken.Guo 04/10/2013
	w_todolist_contract.backcolor = 	Long(dw_search_det1.describe("Datawindow.color"))
//	w_todolist_contract.uo_todolist.backcolor =  Long(dw_search_det1.describe("Datawindow.color"))
//	w_todolist_contract.uo_todolist.dw_facility.modify("Datawindow.color =" +dw_search_det1.describe("Datawindow.color") )
	w_todolist_contract.of_reset()
End If 	

If Isvalid(w_tabpg_contract_doc_mgr) Then
	w_tabpg_contract_doc_mgr.of_set_bg_color(Long(dw_search_det1.describe("Datawindow.color"))) //Modified By Ken.Guo 04/10/2013
//	w_tabpg_contract_doc_mgr.backcolor =  Long(dw_search_det1.describe("Datawindow.color"))
//	w_tabpg_contract_doc_mgr.cbx_auto.backcolor =  Long(dw_search_det1.describe("Datawindow.color"))
	w_tabpg_contract_doc_mgr.of_reset()	
End If 	
 
ids_search_temp.Create(dw_search_det1.Describe("DataWindow.Syntax"))
ids_search_temp.Settransobject( sqlca)
of_dsretrieve_dddw(ids_search_temp,true)
//ids_search_temp.SetTransObject(SQLCA)
//END---Modify by Scofield on 2009-06-24

//Added By Ken.Guo 2009-10-28.
ids_search_temp_child.Create(dw_search_det1.Describe("DataWindow.Syntax"))
ids_search_temp_child.Settransobject( sqlca)
of_dsretrieve_dddw(ids_search_temp_child,true)

this.event ue_set_screen_properties( )  //Jervis 08.17.2010

of_refresh_filtername()					//Added By Mark Lee 11/07/2012 its modify filter button text values.

end subroutine

public subroutine of_reset_filter ();

setNull(is_group_multi_loc_id)
setNull(is_group_multi_loc_id)
setNull(is_effective_date)
setNull(is_expriation_date)
setNull(is_category)
setNull(is_product_type)
setNull(is_ctx_id)
setNull(is_group_id)
setNull(is_status)
setNull(is_filter_string)
setNull(is_USER_ID)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.19.2006 By: LeiWei
//$<reason> Fix a defect.

setNull(is_effective_date2)
setNull(is_expriation_date2)

//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine of_build_filter ();//<Modify> 11/26/2007 by: Andy
Long   ll_Num,ll_Cnt
String ls_ColType,ls_ColName,ls_Value
String	ls_MaxTime = "23:59:59"
String ls_document_name,ls_document_content
Long ll_document_id,ll_doc_category, ll_doc_status
string ls_dddwname
DataStore			lds_Filter
Double				ldb_occi_custom_n1, ldb_ccci_custom_n1
String					ls_Contact, ls_ccci_name, ls_ccci_association, ls_ccci_contact_email
String					ls_ccci_custom_1, ls_occi_name, ls_occi_association
String					ls_occi_contact_email, ls_occi_custom_1
Long					ll_ctx_id[], i
String					ls_SQL, ls_Visible
n_ds					lds_Value


if dw_search.RowCount() < 1 then return
is_filter_string = ''							
dw_search.accepttext()

ll_Cnt = Long(dw_search.describe("DataWindow.Column.Count"))


lds_value  = create  n_ds
lds_value.dataobject = 'd_contract_search_criteria_ext'

FOR ll_Num = 1 to ll_Cnt
	//if dw_search.getitemstatus( 1, ll_Num, Primary!) <> DataModified! then continue	-- Comment by Jervis 04.28.2009 Fixed BugJ042802
	ls_ColType =  dw_search.describe("#" + string(ll_Num) + ".ColType")
	ls_ColName =  dw_search.describe("#" + string(ll_Num) + ".Name")
	ls_Visible = dw_search.describe("#" + string(ll_Num) + ".visible")
	ls_Value = dw_search.inv_base.of_getitem(1,ls_ColName,false)
	
	If ls_Visible <> '1' Then Continue//added by gavins 20120619
	Choose Case Lower(Left ( ls_ColType , 3 ))
		CASE 'int','lon','dec','num','dou','rea','ulo', 'mon'
			choose case lower(ls_ColName)
				case 'group_multi_loc_id'
					if f_validstr(ls_Value) then
						if len(is_filter_string) > 1 then 
							 is_filter_string = is_filter_string +' AND contracted_entity = ' + ls_Value
						else 
							 is_filter_string = ' contracted_entity = ' + ls_Value
						end if
					end if
				case 'app_facility'
					ls_Value = trim(dw_search.getitemstring(dw_search.getrow(),'facility_name'))
					If ls_Value = '(NONE)' Then 
						setnull(ls_Value)
					End If
					if f_validstr(ls_Value) THEN 
						//Start Change Code By Jervis 08.24.2007
						ls_Value = inv_string.of_globalreplace( ls_Value, '"','~~"')
						ls_Value = inv_string.of_globalreplace( ls_Value, "'","~~'")
						//End change code 08.24.2007					
					
						if len(is_filter_string) > 1 then 
							//Modify by Jack 05/11/2007
							is_filter_string = is_filter_string + " AND (upper(facility_name) like '%" + upper(ls_Value) + "%')" //08.24.2007 Only use single quotes
						else 
							is_filter_string = " (upper(facility_name) like '%" + upper(ls_Value) + "%')"
						end if 
					end if
				case 'category'
					if f_validstr(ls_Value) THEN 
						if len(is_filter_string) > 1 then 
							 is_filter_string = is_filter_string +' AND category = ' + ls_Value
						else 
							 is_filter_string = ' category = ' + ls_Value
						end if 
					end if
					
				case 'product_type'
					ls_Value = dw_search.Describe("Evaluate('LookupDisplay(product_type)'," + "1" + ")")
					if ls_Value = '(NONE)' then setnull(ls_Value)
					if f_validstr(ls_Value) THEN 
						//Start Change Code By Jervis 08.24.2007
						ls_Value = inv_string.of_globalreplace( ls_Value, '"','~~"')
						ls_Value = inv_string.of_globalreplace( ls_Value, "'","~~'")
						//End change code 08.24.2007
						if len(is_filter_string) > 1 then 
							 is_filter_string = is_filter_string +' AND product_type = ' + "'" + ls_Value + "'"
						else 
							 is_filter_string = ' product_type = ' + "'" + ls_Value + "'"
						end if 
					end if
					
				case 'ctx_id'
					if f_validstr(ls_Value) THEN 
							if len(is_filter_string) > 1 then 
								 is_filter_string = is_filter_string +' AND ctx_id = ' + ls_Value
							else 
								 is_filter_string = ' ctx_id = ' + ls_Value
							end if 
					end if
					
				case 'group_id'
					if f_validstr(ls_Value) THEN 
						if len(is_filter_string) > 1 then 
							 is_filter_string = is_filter_string +' AND group_id = ' + ls_Value
						else 
							 is_filter_string = ' group_id = ' + ls_Value
							end if 
					end if 

				case 'status'
					if f_validstr(ls_Value) THEN 
						if len(is_filter_string) > 1 then 
							 is_filter_string = is_filter_string +' AND status = ' + ls_Value
						else 
							 is_filter_string = ' status = ' + ls_Value
						end if 
					end if
				//Added By Ken.Guo 2010-06-08.					
				case 'document_id'	
					ll_document_id= Long(ls_value)
					
				//Added By Ken.Guo 2010-07-26.	
				case 'document_category'
					ll_doc_category= Long(ls_value)
				case 'document_status'		
					ll_doc_status= Long(ls_value)
				//Added By Ken.Guo 2010-11-03.	
				case 'unread_email'
					if f_validstr(ls_Value) THEN 
						if len(is_filter_string) > 1 then 
							If ls_Value = '1' Then
								is_filter_string = is_filter_string +' AND unread_email_cnt > 0 '
							ElseIf ls_value = '0' Then
								is_filter_string = is_filter_string +' AND unread_email_cnt = 0 '
							End If
						else 
							If ls_Value = '1' Then
								is_filter_string = ' unread_email_cnt > 0 '
							ElseIf ls_value = '0' Then
								is_filter_string = ' unread_email_cnt = 0 '
							End If
						end if 
					end if	
				case 'occi_custom_n1'	
					ldb_occi_custom_n1 = double( ls_value )
				case 'ccci_custom_n1'
					ldb_ccci_custom_n1 = double( ls_value )
				case 'feesched_category', 'feesched_service_item', 'feesched_item_status', 'feesched_custom_int1','feesched_custom_int2','feesched_billing_cycle'
					lds_value.insertrow( 0 )
					lds_value.SetItem( lds_value.RowCount( ), 'field', ls_ColName )
					lds_value.SetItem( lds_value.RowCount( ), 'types', ls_ColType )
					lds_value.SetItem( lds_value.RowCount( ), 'value', ls_value )					
				case 'feesched_fee', 'feesched_custom_fee1','feesched_custom_fee2','feesched_custom_fee3'
					lds_value.insertrow( 0 )
					lds_value.SetItem( lds_value.RowCount( ), 'field', ls_ColName )
					lds_value.SetItem( lds_value.RowCount( ), 'types', ls_ColType )
					lds_value.SetItem( lds_value.RowCount( ), 'value', ls_value )	
				case  'feesched_custom_n1',  'feesched_custom_n2',  'feesched_custom_n3',  'feesched_custom_n4',  'feesched_custom_n5'
					lds_value.insertrow( 0 )
					lds_value.SetItem( lds_value.RowCount( ), 'field', ls_ColName )
					lds_value.SetItem( lds_value.RowCount( ), 'types', ls_ColType )
					lds_value.SetItem( lds_value.RowCount( ), 'value', ls_value )	
				case else
					if Not f_validstr(ls_Value) THEN Continue
					if len(is_filter_string) > 1 then 
						 is_filter_string = is_filter_string +' AND ' + ls_ColName + ' = ' + ls_Value
					else 
						 is_filter_string = ls_ColName + ' = ' + ls_Value
					end if
					
			end choose
			
		CASE 'dat'
			choose case lower(ls_ColName)
				case 'effective_date'
					IF f_validstr(ls_Value) THEN
						IF len(is_filter_string) > 1 THEN
							 is_filter_string = is_filter_string +' AND effective_date >= ' + "DateTime('" + ls_Value + "')" 
						ELSE
							 is_filter_string = ' effective_date >= ' + "DateTime('" + ls_Value + "')" 
						END IF
					END IF
					
				case 'effective_date2'		
					IF f_validstr(ls_Value) THEN
						if Pos(ls_Value," ") > 0 then
							ls_Value = Left(ls_Value,Pos(ls_Value," ")) + ls_MaxTime
						end if
						IF len(is_filter_string) > 1 THEN
							 is_filter_string = is_filter_string +' AND effective_date <= ' + "DateTime('" + ls_Value + "')" 
						ELSE 
							 is_filter_string = ' effective_date <= ' + "DateTime('" + ls_Value + "')" 
						END IF
					END IF
					
				case 'expriation_date'	
					IF f_validstr(ls_Value) THEN 
						IF len(is_filter_string) > 1 THEN 
							 is_filter_string = is_filter_string +' AND expriation_date >=' + "DateTime('" + ls_Value + "')" 
						ELSE 
							 is_filter_string = ' expriation_date >= ' + "DateTime('" + ls_Value + "')" 
						END IF
					END IF 
				
				case 'expriation_date2'
					IF f_validstr(ls_Value) THEN 
						if Pos(ls_Value," ") > 0 then
							ls_Value = Left(ls_Value,Pos(ls_Value," ")) + ls_MaxTime
						end if
						IF len(is_filter_string) > 1 THEN 
							 is_filter_string = is_filter_string +' AND expriation_date <=' + "DateTime('" + ls_Value + "')" 
						ELSE 
							 is_filter_string = ' expriation_date <= ' + "DateTime('" + ls_Value + "')" 
						END IF
					END IF
				
				case 'term_date','last_revis_date','review_date','version_date'
					IF f_validstr(ls_Value) THEN 
						IF len(is_filter_string) > 1 THEN 
							 is_filter_string = is_filter_string +' AND ' + ls_ColName + ' >=' + "DateTime('" + ls_Value + "')" 
						ELSE 
							 is_filter_string = ls_ColName + ' >= ' + "DateTime('" + ls_Value + "')" 
						END IF
					END IF 
					
				case 'term_date_2','last_revis_date_2','review_date_2','version_date_2'
					ls_ColName = left(ls_ColName,len(ls_ColName) - 2)
					IF f_validstr(ls_Value) THEN 
						if Pos(ls_Value," ") > 0 then
							ls_Value = Left(ls_Value,Pos(ls_Value," ")) + ls_MaxTime
						end if
						IF len(is_filter_string) > 1 THEN 
							 is_filter_string = is_filter_string +' AND ' + ls_ColName + ' <=' + "DateTime('" + ls_Value + "')" 
						ELSE 
							 is_filter_string = ls_ColName + ' <= ' + "DateTime('" + ls_Value + "')" 
						END IF
					END IF	
				case 'feesched_custom_date1', 'feesched_custom_date2','feesched_custom_date3','feesched_custom_date4', 'feesched_custom_date5', 'feesched_start_date', 'feesched_end_date'
					lds_value.insertrow( 0 )
					lds_value.SetItem( lds_value.RowCount( ), 'field', ls_ColName )
					lds_value.SetItem( lds_value.RowCount( ), 'types', ls_ColType )
					lds_value.SetItem( lds_value.RowCount( ), 'value', ls_value )	
				case else
					if Not f_validstr(ls_Value) THEN Continue
					if len(is_filter_string) > 1 then 
						 is_filter_string = is_filter_string +" AND " + ls_ColName + " = " + "DateTime('" + ls_Value + "')"
					else 
						 is_filter_string = ls_ColName + " = " + "DateTime('" + ls_Value + "')"
					end if
					
			end choose
			
		CASE 'var','cha'	
			
			choose case lower(ls_ColName)
				case 'facility_name'
					ls_Value = trim(dw_search.getitemstring(dw_search.getrow(),'facility_name'))
					If ls_Value = '(NONE)' Then 
						setnull(ls_Value)
					End If
					if f_validstr(ls_Value) THEN 
						//Start Change Code By Jervis 08.24.2007
						ls_Value = inv_string.of_globalreplace( ls_Value, '"','~~"')
						ls_Value = inv_string.of_globalreplace( ls_Value, "'","~~'")
						//End change code 08.24.2007					
					
						if len(is_filter_string) > 1 then 
							//Modify by Jack 05/11/2007
							is_filter_string = is_filter_string + " AND (upper(facility_name) like '%" + upper(ls_Value) + "%')" //08.24.2007 Only use single quotes
						else 
							is_filter_string = " (upper(facility_name) like '%" + upper(ls_Value) + "%')"
						end if 
					end if
					
				case 'product_name'
					ls_Value = dw_search.Describe("Evaluate('LookupDisplay(product_name)'," + "1" + ")")
					if ls_Value = '(NONE)' then setnull(ls_Value)
					
					if f_validstr(ls_Value) THEN 
						//Start Change Code By Jervis 08.24.2007
						ls_Value = inv_string.of_globalreplace( ls_Value, '"','~~"')
						ls_Value = inv_string.of_globalreplace( ls_Value, "'","~~'")
						//End change code 08.24.2007
						
						//Replace '=' to  'Like' - Modify by jervis 01.22.2010
						if len(is_filter_string) > 1 then 
							 is_filter_string = is_filter_string +" AND (Upper(product_name) like '%" + Upper(ls_Value) + "%')"
						else 
							 is_filter_string = " (Upper(product_name) like '%" + Upper(ls_Value) + "%')"
						end if 
					end if
					
				case 'owner'
					if ls_Value = '(None)' then 
						setnull(ls_Value) 
					else 
						ls_Value = UPPER(ls_Value)
					end if
					
					IF f_validstr(ls_Value) THEN
						//Start Change Code By Jervis 08.24.2007
						ls_Value = inv_string.of_globalreplace( ls_Value, '"','~~"')
						ls_Value = inv_string.of_globalreplace( ls_Value, "'","~~'")
						//End change code 08.24.2007
						
						IF len(is_filter_string) > 1 THEN
							 is_filter_string = is_filter_string + " AND upper(trim(owner)) = '" + upper(ls_Value) + "'" 
						ELSE
							 is_filter_string = " upper(trim(owner)) = '" + upper(ls_Value) + "'" 
						END IF
					END IF
					
				case 'document_name'	 //Added By Ken.Guo 2010-06-08.
					ls_document_name = ls_value
					
				case 'document_content' //Added By Ken.Guo 2010-06-11.
					ls_document_content = ls_value
				
				case 'app_facility_contact_id'
					ls_contact = ls_Value	
				case 'ccci_name'
					ls_ccci_name = ls_value
				case 'ccci_association'
					ls_ccci_association = ls_value
				case 'ccci_contact_email'
					ls_ccci_contact_email = ls_value
				case 'ccci_custom_1'
					ls_ccci_custom_1 = ls_value
				case 'occi_name'
					ls_occi_name = ls_value
				case 'occi_association'
					ls_occi_association = ls_value
				case 'occi_contact_email'
					ls_occi_contact_email = ls_value
				case 'occi_custom_1'
					ls_occi_custom_1 = ls_value	
				case 'feesched_description', 'feesched_custom_text1', 'feesched_custom_text2', 'feesched_custom_text3'
					lds_value.insertrow( 0 )
					lds_value.SetItem( lds_value.RowCount( ), 'field', ls_ColName )
					lds_value.SetItem( lds_value.RowCount( ), 'types', ls_ColType )
					lds_value.SetItem( lds_value.RowCount( ), 'value', ls_value )	
				case 'feesched_custom_text4', 'feesched_custom_text5', 'feesched_custom_text6', 'feesched_custom_text7','feesched_custom_text8', 'feesched_notes'
					lds_value.insertrow( 0 )
					lds_value.SetItem( lds_value.RowCount( ), 'field', ls_ColName )
					lds_value.SetItem( lds_value.RowCount( ), 'types', ls_ColType )
					lds_value.SetItem( lds_value.RowCount( ), 'value', ls_value )	
				case else
					if Not f_validstr(ls_Value) THEN Continue
					ls_Value = inv_string.of_globalreplace( ls_Value, '"','~~"')
					ls_Value = inv_string.of_globalreplace( ls_Value, "'","~~'")
					
					//Replace '=' to  'Like' - Modify by jervis 01.22.2010
					if dw_search.describe("#" + string(ll_Num) + ".edit.style") = 'dddw' then
						ls_dddwname = dw_search.describe("#" + string(ll_Num) + ".dddw.name") 
						if ls_dddwname  = 'd_dddw_lookup_code' or ls_dddwname = 'd_dddw_company' or ls_dddwname = 'd_dddw_company_list' then //Add by jervis -- 05.13.2011
							if len(is_filter_string) > 1 then 
								 is_filter_string = is_filter_string +" AND (Upper(" + ls_ColName + ") = '" + Upper(ls_Value) + "')"
							else 
								 is_filter_string = " (Upper(" + ls_ColName +  ") = '" + Upper(ls_Value) + "')"
							end if
						else
							if len(is_filter_string) > 1 then 
								 is_filter_string = is_filter_string +" AND (Upper(" + ls_ColName + ") Like '%" + Upper(ls_Value) + "%')"
							else 
								 is_filter_string = " (Upper(" + ls_ColName +  ") Like '%" + Upper(ls_Value) + "%')"
							end if
						end if
					else
							if len(is_filter_string) > 1 then 
								 is_filter_string = is_filter_string +" AND (Upper(" + ls_ColName + ") Like '%" + Upper(ls_Value) + "%')"
							else 
								 is_filter_string = " (Upper(" + ls_ColName +  ") Like '%" + Upper(ls_Value) + "%')"
							end if
					end if
					
			end choose
	End Choose	

NEXT 	

//Added By Ken.Guo 2010-06-08.//modified by gavins 201203026
String ls_doc_filter

lds_Filter = Create DataStore
lds_Filter.DataObject = 'd_doc_search'
ib_FilterValue = False
ls_doc_filter = ""
ls_SQL = ''
ls_SQL = of_build_doc_filter(ll_document_id,ls_document_name,ls_document_content,ll_doc_category, ll_doc_status)
ls_SQL = of_build_contact_filter( ls_SQL, ls_ccci_name, ls_ccci_contact_email, ls_ccci_association, ls_ccci_custom_1, ldb_ccci_custom_n1, 'E' , '' ) 
ls_SQL = of_build_contact_filter( ls_SQL, ls_occi_name, ls_occi_contact_email, ls_occi_association, ls_occi_custom_1, ldb_occi_custom_n1, 'I' , '' ) 
SetNull( ldb_occi_custom_n1 )
ls_SQL = of_build_contact_filter( ls_SQL, '', '', '', '', ldb_occi_custom_n1, '' , ls_contact ) 

ls_SQL = of_build_contact_filter( lds_value, ls_SQL )

//lds_Filter.SetSQLSelect( ls_SQL )
lds_Filter.Modify( "datawindow.table.select=" + '"' + ls_sql + '"' )
lds_Filter.SetTransObject(SQLCA)
If ib_FilterValue Then lds_Filter.Retrieve()

If lds_Filter.RowCount() > 0 Then
	ll_ctx_id[] = lds_Filter.object.ctx_id[1,lds_Filter.RowCount()]
End If

For i = 1 To UpperBound(ll_ctx_id[])
	ls_doc_filter += String(ll_ctx_id[i]) + ', '
Next

If ls_doc_filter <> '' Then 
	ls_doc_filter = '( ' + Mid(ls_doc_filter,1,len(ls_doc_filter) - 2) + ' )'
ElseIf ib_FilterValue And ls_doc_filter = '' Then
	ls_doc_filter = '(-999999)'
End If

If isvalid(lds_Filter) Then Destroy lds_Filter


If ls_doc_filter <> '' Then
	If is_filter_string = '' Then
		is_filter_string = 'ctx_id in ' + ls_doc_filter
	Else
		is_filter_string += ' And ctx_id in ' + ls_doc_filter
	End If
End If

//Added By Ken.Guo 10/30/2012. Support PowerFilter
If isvalid(iu_PowerFilter) Then
	iu_PowerFilter.of_setoriginalfilter( )
End If

If IsValid( lds_value ) Then destroy( lds_value )
end subroutine

public function integer of_collapse_row (long al_ctx_id, long al_row);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_searchof_collapse_row()
// $<arguments>
//		value	long	al_ctx_id		
//		value	long	al_row   		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.21.2007 by Jack 
//////////////////////////////////////////////////////////////////////
Long Li_find_start,Li_find_end

dw_search_det1.Setredraw( False )

//Delete Rows
Li_find_start = dw_search_det1.find("master_contract_id = " + string(al_ctx_id),al_row + 1,dw_search_det1.rowcount())
if Li_find_start > 0 then
	li_find_end = dw_search_det1.find("master_contract_id <> " + string(al_ctx_id),Li_find_start + 1,dw_search_det1.rowcount())
	if li_find_end = 0 then 
		li_find_end = dw_search_det1.Rowcount( ) + 1
	end if


	//Delete sub-contracts
	dw_search_det1.RowsMove(Li_find_start,li_find_end - 1, Primary!, ids_search_temp, 1, Primary!) //<add> 07.05.2007 By: Jack
	dw_search_det1.setitem( al_row,'style','+')
end if


/*
li_Find = dw_search_det1.find("ctx_id = " + string(al_ctx_id),1,dw_search_det1.rowcount())
do while li_find > 0 
	dw_search_det1.setitem( li_find,'style','+')
	li_Find ++
	If li_find <= dw_search_det1.rowcount() then
		li_Find = dw_search_det1.find("ctx_id = " + string(al_ctx_id),li_find,dw_search_det1.rowcount())
	Else
		li_find = 0
	End If
loop
*/
dw_search_det1.Setredraw( True )

Return 1

end function

public function integer of_filter ();String	ls_Sort

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.05.2007 By: Jack
//$<reason> Performance tuning
SetPointer(Hourglass!)  //Add by Jack 08.30.2007

//This.SetRedraw(False)						//Comment By Mark Lee 12/17/2012
tv_ctx.SetRedraw( False)
dw_search_det1.SetRedraw( False)


of_build_filter( )

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-12-14 By: Scofield
//$<Reason> Set Sort condition.

ls_Sort = dw_search_det1.Describe("DataWindow.Table.Sort")
//ids_search.Modify("DataWindow.Table.Sort='" + ls_Sort + "'")
//---------------------------- APPEON END ----------------------------


ib_Trigger_RowChangeEvent = False
If ib_tree_view Then
	of_copy_row_tv()
Else
	of_copy_row()
End If
ib_Trigger_RowChangeEvent = True

//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////
// set the contracted entity
/////////////////////////////////////////////
dw_search_det1.title = 'Contract Browse ' + "(" + string(dw_search_det1.rowcount()) + ")"

IF dw_search_det1.ROWCOUNT() < 1 THEN 
//	setredraw(true)						//Comment By Mark Lee 12/17/2012
	of_set_message('no rows')
	If iw_parent.classname() = 'w_contract' Then
		iw_parent.Dynamic Function wf_set_tab_enabled(False)
	End If
	dw_search_det1.SetRedraw( True)
	tv_ctx.SetRedraw( True)
//	This.SetRedraw(True)				//Comment By Mark Lee 12/17/2012
	RETURN  SUCcess
Else
	If iw_parent.classname() = 'w_contract' Then
		iw_parent.Dynamic Function wf_set_tab_enabled(True)
	End If
end if


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.24.2006 By: Davis
//$<reason> Fix a defect.
IF dw_search_det1.getselectedrow(0) > 0 THEN
	INV_contract_details.of_set_ctx_id( dw_search_det1.OBJECT.CTX_ID[dw_search_det1.getselectedrow(0)])
END IF
//---------------------------- APPEON END ----------------------------

long ll_find 
ib_retrieve = True

// Add by Jack 03/23/2007
ib_resize = False   
// Add by Jack 07/05/2007
If il_ctx_id = 0 Then il_ctx_id = dw_search_det1.getitemnumber(1,'ctx_id')

ll_find = dw_search_det1.find("ctx_id = " + string(il_ctx_id),1,dw_search_det1.rowcount())
If ll_find > 0 Then
	If ll_find = dw_search_det1.GetRow() Then
		dw_search_det1.scrolltorow(ll_find)
		dw_search_det1.event rowfocuschanged(1)
	Else
		dw_search_det1.scrolltorow(ll_find) //it will trigger rowfocuschanged event
	End If
 Else
	dw_search_det1.event rowfocuschanged(1)
End If
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 10/30/2012. Support PowerFilter
If isvalid(iu_PowerFilter) Then
	iu_PowerFilter.of_reset( ) 
	iu_PowerFilter.of_Reset_OriginalFilter( )//added by gavins 20130424
End If

dw_search_det1.SetRedraw( True)
tv_ctx.SetRedraw( True)
//This.SetRedraw(True)						//Comment By Mark Lee 12/17/2012

RETURN  SUCcess

end function

public function boolean of_get_access (long al_ctx_id);///******************************************************************************************************************
//**  [PUBLIC]   : of_get_access
//**==================================================================================================================
//**  Purpose   	: returns the access of a user
//**==================================================================================================================
//**  Arguments 	: [none] 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: Michael B. Skinner 27 Febuary 2006 ? Intellisoftgroup, Inc
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//********************************************************************************************************************/
//string ls_access
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-18
////$<modify> 09.22.2006 By: LeiWei
////$<reason> Performance tuning
////$<reason> Reduce client-server interactions to improve runtime performance.
////$<modification> Write script to retrieve data from a cache instead of from the database.
///*
//SELECT ctx_contract_contacts.access
//into   :ls_access
//FROM   ctx_contacts,   
//       ctx_contract_contacts
//WHERE  (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  
//       (( ctx_contract_contacts.ctx_id = :al_ctx_id ) AND  
//       ( ctx_contacts.user_d = :as_user_id ) );
//*/
//
//Long ll_row
//
////---------Begin Modified by Alfee 09.30.2007--------------------------------
////<$Reason>Add read only control for right in role painter & Modify the origianl
///*ll_row = ids_contract_access_pt.find( "ctx_id = " + String(al_ctx_id) + &
//						" AND upper(user_d) = '" + upper(as_user_id) + "'", 1, ids_contract_access_pt.Rowcount() )
//IF ll_row > 0 THEN
//	ls_access = ids_contract_access_pt.GetitemString(ll_row, "access")
//END IF
//return ls_access */
//ll_row = ids_contract_access_pt.Find( "ctx_id = " + String(al_ctx_id), 1, ids_contract_access_pt.Rowcount())
//IF ll_row > 0 THEN 
//	ls_access = ids_contract_access_pt.GetitemString(ll_row, "access")
//END IF						
//
//IF ls_access = 'F' THEN //'R' - Readonly; 'F' - Full Access(No Acces has been fillted in ds)
//	RETURN FALSE
//ELSE
//	RETURN TRUE 
//END IF
////---------End Modified -----------------------------------------------------	
////---------------------------- APPEON END ----------------------------
//
//
//

//Commented All Script by Ken.Guo on 2009-02-12
//Destroy this function. Direct get access from search DW.
Return True
end function

public subroutine of_build_filter_bak ();
//string ls_temp[]
//string ls_output
//long ll_i

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.14.2007 By: Jack (Contract)
//$<reason> Fix a defect.
/*
is_filter_string = ''
*/
//is_filter_string = 'master_contract_id = 0'  //Comment by Jack 03/21/2007

//Comment by Jack 07.05.2007
is_filter_string = ''								  //add by Jack 03/21/2007

//---------------------------- APPEON END ----------------------------

if isnull(is_effective_date ) then
	is_effective_date = ''
end if 

if isnull(is_expriation_date ) then
	is_expriation_date = ''
end if 


 //////////////////////////////////////////////////////////
 //
 //////////////////////////////////////////////////////////
 
if f_validstr(is_group_multi_loc_id) THEN 
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string +' AND contracted_entity = ' + is_group_multi_loc_id
	else 
		 is_filter_string = ' contracted_entity = ' + is_group_multi_loc_id
	end if 
end if 



//////////////////////////////////////////////////////////////////////////////////////////////////////////
// if both dates are present then do a range
//////////////////////////////////////////////////////////////////////////////////////////////////////////
/// effective_date >= DateTime('7/1/2006') and expriation_date <= DateTime('7/29/2006')     AND ctx_id in (2626,2627,2629,2630,2631,2626,2627)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if f_validstr(is_effective_date) and f_validstr(is_expriation_date) then 
	
 	   if len(is_filter_string) > 1 then 
			 is_filter_string = is_filter_string +' AND effective_date >= ' + "DateTime('" + is_effective_date + "')" 
		else 
		    is_filter_string = ' effective_date >= ' + "DateTime('" + is_effective_date + "')"  
		end if 
		
		is_filter_string = is_filter_string + ' and expriation_date <= ' + "DateTime('" + is_expriation_date + "')" 
			
else

	//////////////////////////////////////////////////////////
	//
	//////////////////////////////////////////////////////////
		
	if f_validstr(is_effective_date) THEN
		if len(is_filter_string) > 1 then 
			 is_filter_string = is_filter_string +' AND effective_date >= ' + "DateTime('" + is_effective_date + "')" 
		else 
		 is_filter_string = ' effective_date >= ' + "DateTime('" + is_effective_date + "')" 
		end if 
	 
  else
	//////////////////////////////////////////////////////////
	//
	//////////////////////////////////////////////////////////	
	
	if f_validstr(is_expriation_date) THEN 
		if len(is_filter_string) > 1 then 
			 is_filter_string = is_filter_string +' AND expriation_date =' + "DateTime('" + is_expriation_date + "')" 
		else 
			  is_filter_string = ' expriation_date >= ' + "DateTime('" + is_expriation_date + "')" 
		end if 
	end if 
    
end if 
	 
end if
*/

IF f_validstr(is_effective_date) THEN
	IF len(is_filter_string) > 1 THEN
		 is_filter_string = is_filter_string +' AND effective_date >= ' + "DateTime('" + is_effective_date + "')" 
	ELSE
		 is_filter_string = ' effective_date >= ' + "DateTime('" + is_effective_date + "')" 
	END IF
END IF

IF f_validstr(is_effective_date2) THEN
	IF len(is_filter_string) > 1 THEN
		 is_filter_string = is_filter_string +' AND effective_date <= ' + "DateTime('" + is_effective_date2 + "')" 
	ELSE 
		 is_filter_string = ' effective_date <= ' + "DateTime('" + is_effective_date2 + "')" 
	END IF
END IF

IF f_validstr(is_expriation_date) THEN 
	IF len(is_filter_string) > 1 THEN 
		 is_filter_string = is_filter_string +' AND expriation_date >=' + "DateTime('" + is_expriation_date + "')" 
	ELSE 
		 is_filter_string = ' expriation_date >= ' + "DateTime('" + is_expriation_date + "')" 
	END IF
END IF 

IF f_validstr(is_expriation_date2) THEN 
	IF len(is_filter_string) > 1 THEN 
		 is_filter_string = is_filter_string +' AND expriation_date <=' + "DateTime('" + is_expriation_date2 + "')" 
	ELSE 
		 is_filter_string = ' expriation_date <= ' + "DateTime('" + is_expriation_date2 + "')" 
	END IF
END IF 

//---------------------------- APPEON END ----------------------------


//////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////
if f_validstr(is_category) THEN 
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string +' AND category = ' + is_category
	else 
		 is_filter_string = ' category = ' + is_category
	end if 
end if 	  

//////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////

			
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.07.2006 By: Liang QingShi
//$<reason> Contract module modification 
/*
if f_validstr(is_product_type) THEN 
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string +' AND product_type = ' + is_product_type
	else 
		 is_filter_string = ' product_type = ' + is_product_type
	end if 
end if 	
*/
is_product_type = dw_search.Describe("Evaluate('LookupDisplay(product_type)'," + "1" + ")")
if is_product_type = '(NONE)' then setnull(is_product_type)
if f_validstr(is_product_type) THEN 
	//Start Change Code By Jervis 08.24.2007
	is_product_type = inv_string.of_globalreplace( is_product_type, '"','~~"')
	is_product_type = inv_string.of_globalreplace( is_product_type, "'","~~'")
	//End change code 08.24.2007
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string +' AND product_type = ' + "'" + is_product_type + "'"
	else 
		 is_filter_string = ' product_type = ' + "'" + is_product_type + "'"
	end if 
end if 	

//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////
 //
 //////////////////////////////////////////////////////////	
if f_validstr(is_ctx_id) THEN 
	   if len(is_filter_string) > 1 then 
		    is_filter_string = is_filter_string +' AND ctx_id = ' + is_ctx_id
		else 
			 is_filter_string = ' ctx_id = ' + is_ctx_id
		end if 
end if 	
			 
//////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////
if f_validstr(is_group_id) THEN 
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string +' AND group_id = ' + is_group_id
	else 
		 is_filter_string = ' group_id = ' + is_group_id
		end if 
end if 		 

//////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////
if f_validstr(is_status) THEN 
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string +' AND status = ' + is_status
	else 
		 is_filter_string = ' status = ' + is_status
	end if 
end if 	

//////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.07.2006 By: Liang QingShi
//$<reason> Contract module modification 

is_product_name = dw_search.Describe("Evaluate('LookupDisplay(product_name)'," + "1" + ")")
if is_product_name = '(NONE)' then setnull(is_product_name)
//---------------------------- APPEON END ----------------------------

if f_validstr(is_product_name) THEN 
	//Start Change Code By Jervis 08.24.2007
	is_product_name = inv_string.of_globalreplace( is_product_name, '"','~~"')
	is_product_name = inv_string.of_globalreplace( is_product_name, "'","~~'")
	//End change code 08.24.2007
	
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string +" AND product_name = '" + is_product_name + "'"
	else 
		 is_filter_string = " product_name = '" + is_product_name + "'"
	end if 
end if 	

//////////////////////////////////////////////////////////
// owner
//////////////////////////////////////////////////////////

// let the current user see all of the contracts then user as acces to
// ir read only/full


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.05.2006 By: LeiWei
//$<reason> Peroformance tuning.
//$<modification> The following script moved to of_retrieve().
/*
ids_contract_access.retrieve(is_user_id)
*/
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11.06.2006 By: Davis
//$<reason> Fix a defect.
/*
for ll_i = 1 to ids_contract_access.rowcount( )
	 ls_temp[upperbound(ls_temp) + 1] = string(ids_contract_access.getitemNumber(ll_i,'ctx_id'))
next
*/

//int i
//string ls_ctx_id
//boolean b_found
//
//FOR ll_i = 1 TO ids_contract_access.rowcount( )
//	ls_ctx_id = string(ids_contract_access.getitemNumber(ll_i,'ctx_id')) 
//	b_found = FALSE
//	
//	FOR i = 1 TO upperbound(ls_temp)
//		IF ls_ctx_id = ls_temp[i] THEN
//			b_found = TRUE
//			EXIT
//		END IF
//	NEXT
//
//	IF NOT b_found THEN ls_temp[upperbound(ls_temp) + 1] = ls_ctx_id
//NEXT
//---------------------------- APPEON END ----------------------------

//inv_string.of_arraytostring( ls_temp, ',', false, ls_output)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.06.2006 By: Davis
//$<reason> Record contract array that the user has access to.
//is_contract_array = ls_output
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if f_validstr(is_user_id) THEN 
   if len(is_filter_string) > 1 then 
	    is_filter_string = is_filter_string + " AND ctx_id in (" +ls_output +")" 
	else 
		 is_filter_string = " ctx_id in ("+ ls_output + ")"
	end if 
else 

end if
*/

// Check access with logged user
//IF NOT f_validstr(ls_output) THEN ls_output = "0"

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.19.2007 By: Jack
/*
IF len(is_filter_string) > 1 THEN
	 is_filter_string = is_filter_string + " AND ctx_id in (" +ls_output +")" 
ELSE
	 is_filter_string = " ctx_id in ("+ ls_output + ")"
END IF
*/
//is_output = ls_output
//---------------------------- APPEON END ----------------------------

// Select owner
IF f_validstr(is_user_id) THEN
	//Start Change Code By Jervis 08.24.2007
	is_user_id = inv_string.of_globalreplace( is_user_id, '"','~~"')
	is_user_id = inv_string.of_globalreplace( is_user_id, "'","~~'")
	//End change code 08.24.2007
	
	IF len(is_filter_string) > 1 THEN
		 is_filter_string = is_filter_string + " AND upper(trim(owner)) = '" + upper(is_user_id) + "'" 
	ELSE
		 is_filter_string = " upper(trim(owner)) = '" + upper(is_user_id) + "'" 
	END IF
END IF

//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Jack (Export)
//$<reason> Fix a defect.
/*
if f_validstr(is_app_facility) THEN 
	   if len(is_filter_string) > 1 then 
		    is_filter_string = is_filter_string +' AND app_facility = ' + is_app_facility
		else 
			 is_filter_string = ' app_facility = ' + is_app_facility
		end if 
end if 
*/
dw_search.accepttext()
//is_app_facility = dw_search.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(dw_search.getrow())+" )")

//Add by Jack 07.13.2007
//is_app_facility = dw_search.describe("Evaluate( 'lookupdisplay(facility_name) ', "+string(dw_search.getrow())+" )")
If dw_search.rowcount() > 0 Then
	is_app_facility = trim(dw_search.getitemstring(dw_search.getrow(),'facility_name'))
End If
If is_app_facility = '(NONE)' Then 
	setnull(is_app_facility)
End If
if f_validstr(is_app_facility) THEN 
	//Start Change Code By Jervis 08.24.2007
	is_app_facility = inv_string.of_globalreplace( is_app_facility, '"','~~"')
	is_app_facility = inv_string.of_globalreplace( is_app_facility, "'","~~'")
	//End change code 08.24.2007


	if len(is_filter_string) > 1 then 
		//Modify by Jack 05/11/2007
		is_filter_string = is_filter_string + " AND (upper(facility_name) like '%" + upper(is_app_facility) + "%')" //08.24.2007 Only use single quotes
		//is_filter_string = is_filter_string + ' AND upper(trim(facility_name)) like "%' + upper(is_app_facility) + '%"'
	else 
		is_filter_string = " (upper(facility_name) like '%" + upper(is_app_facility) + "%')"
		//is_filter_string = ' upper(trim(facility_name)) like "%' + upper(is_app_facility) + '%"'
	end if 
end if 
//---------------------------- APPEON END ----------------------------



end subroutine

public subroutine of_refresh_ctx_view ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_search::of_refresh_ctx_view()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.12.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

ids_ctx_group_user_view.Retrieve(gs_user_id)
end subroutine

public function long of_get_ctx_view (long al_category, long al_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_search::of_get_ctx_view()
// $<arguments>
//		value	long	al_category		
//		value	long	al_ctx_id        		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.12.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_row
Long li_view_id

//Get From Group Access
ll_row = ids_ctx_group_user_view.Find('ctx_group_access_ctx_id = ' + String(al_ctx_id) + ' And Upper(security_group_users_user_id) = "'+upper(gs_user_id)+'"',1,ids_ctx_group_user_view.RowCount()) 
If ll_Row > 0 Then
	li_view_id = ids_ctx_group_user_view.GetItemNumber(ll_row,'ctx_group_access_view_id')
	Return li_view_id
End If

//Get From Category from Code_Lookup	
li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(al_category)))

//Get From Default View
If isnull(li_view_id) Or li_view_id = 0 Then
	li_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
End If
If isnull(li_view_id) Or li_view_id = 0 Then
	li_view_id = 1001
End If

Return li_view_id
end function

public function long of_retrieve_ctx ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_search::of_retrieve_ctx()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> If it retrieved ctx, maybe need not retrieve again.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-06-03 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_ret

If ib_force_retrieve or (Not ib_retrieved_ctx) Then
	if gb_IsDocMode then
		ids_search.DataObject = "d_user_ctx_search"
		ids_search.SetTransObject(SQLCA)
		ll_ret = ids_search.Retrieve(Upper(gs_user_id),gl_MoveToCtxID)
	else
		ll_ret = ids_search.Retrieve(Upper(gs_user_id))
	end if
	ib_retrieved_ctx = True
	Return ll_ret
Else
	ids_search.SetFilter('')
	ids_search.Filter()
	Return ids_search.RowCount()
End If

end function

public subroutine of_copy_row_old ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_searchof_copy_row()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.19.2007 by Jack
//////////////////////////////////////////////////////////////////////
string 	ls_filter_string
long 		ll_i,ll_ctx_id,ll_master_contract_id,ll_master_cnt

If len(is_filter_string) > 1 Then
	//Modified By Alan on 2009-2-2
	ls_filter_string = "(master_contract_id = 0 or isnull(master_contract_id)) AND " + is_filter_string
//	ls_filter_string = "master_contract_id = 0 AND " + is_filter_string
	ids_search.setfilter(ls_filter_string)
	ids_search.filter()
	
	If ids_search.rowcount() > 0 Then
		dw_search_det1.reset()
		ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)
		
		is_output1 = ''
		For ll_i = 1 To dw_search_det1.rowcount()
			ll_ctx_id = dw_search_det1.getitemnumber(ll_i,'ctx_id')		
			ll_master_contract_id = dw_search_det1.getitemnumber(ll_i,'master_contract_id')
			if isnull(ll_master_contract_id) then ll_master_contract_id=0
			ll_master_cnt = dw_search_det1.getitemnumber(ll_i,'master_cnt')
			If (ll_master_contract_id = 0 or isnull(ll_master_contract_id)) And ll_master_cnt > 0 Then
				of_display_row(ll_ctx_id,ll_i)	
			End If
		Next
		If is_output1 <> '' Then
			ls_filter_string = "master_contract_id <> 0 AND ctx_id not in (" +is_output1 + ") and " + is_filter_string
		Else
			ls_filter_string = "master_contract_id <> 0 AND " + is_filter_string
		End If
		ids_search.setfilter(ls_filter_string)
		ids_search.filter()
		ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)		
	Else
		ls_filter_string = is_filter_string
		ids_search.setfilter(ls_filter_string)
		ids_search.filter()
		dw_search_det1.reset()
		ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)	
   End If
Else
	//Modified By Alan on 2009-2-2
	ls_filter_string = "master_contract_id = 0 or isnull(master_contract_id)"
	//ls_filter_string = "master_contract_id = 0"
	ids_search.setfilter(ls_filter_string)
	ids_search.filter()
	
	dw_search_det1.reset()
	ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)
	
	is_output1 = ''
	For ll_i = 1 To dw_search_det1.rowcount()
		ll_ctx_id = dw_search_det1.getitemnumber(ll_i,'ctx_id')
		ll_master_contract_id = dw_search_det1.getitemnumber(ll_i,'master_contract_id')
		if isnull(ll_master_contract_id) then ll_master_contract_id=0
		ll_master_cnt = dw_search_det1.getitemnumber(ll_i,'master_cnt')
		If (ll_master_contract_id = 0 or isnull(ll_master_contract_id) ) And ll_master_cnt > 0 Then
			of_display_row(ll_ctx_id,ll_i)
		End If
	Next
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.11.2009 By: Ken.Guo
	//$<reason> Show sub contract although master contract be filter.  
	If is_output1 <> '' Then
		ls_filter_string = "master_contract_id > 0 AND ctx_id not in (" +is_output1 + ") " 
	Else
		ls_filter_string = "master_contract_id > 0 " 
	End If
	ids_search.setfilter(ls_filter_string)
	ids_search.filter()
	ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)			
	//---------------------------- APPEON END ----------------------------	
End If

end subroutine

public subroutine of_copy_row ();//Rewrite of_copy_row - jervis 06.23.2009
//performance optimize

string 	ls_filter
long 		ll_i,ll_ctx_id,ll_master_contract_id,ll_master_cnt
long ll_find
long ll_ctx_parent[]
long ll_count_parent[]
long ll_count
long ll_cur_row
string ls_sort_s,ls_sort_t

SetPointer(HourGlass!)

ids_search_temp.Reset( )


//Set Filter
ls_filter = upper(ids_search.Describe( "datawindow.table.filter"))
if ls_filter = "?" then ls_filter = ""
if is_filter_string <> ls_filter then
	ids_search.setfilter(is_filter_string)
	ids_search.filter()
end if

If inv_ctx_tv.is_tv_type = 'row' Then //only show the browse dw data or relate data in the tv for current row
	//Added By Ken.Guo 12/10/2011. 
	dw_search_det1.reset()
	ids_search.RowsCopy(1,ids_search.rowcount(), Primary!, dw_search_det1, 1, Primary!)
	ls_sort_s = dw_search_det1.Describe( "datawindow.table.sort")	
	if ls_sort_s <> "" and ls_sort_s <> "?" then 
		dw_search_det1.Setsort(  of_replace_sort(ls_sort_s )) 
		dw_search_det1.sort()
	End If
Else //show all data in the tv
	//copy to temp datastore
	ids_search.rowscopy( 1,ids_search.Rowcount(),primary!,ids_search_temp,1,primary!)
	
	//Set Sort 
	ls_sort_s = dw_search_det1.Describe( "datawindow.table.sort")
	if ls_sort_s <> "" and ls_sort_s <> "?" then //Default by master_contract_id A,ctx_id A when retrieved return
		ls_sort_t = ids_search_temp.Describe( "datawindow.table.sort")
		if ls_sort_s <> ls_sort_t or pos(ls_sort_t,"master_contract_id")=0 then //jervis 07.25.2009
			ids_search_temp.Setsort(  "master_contract_id A," + of_replace_sort(ls_sort_s )) //Modified By Ken.Guo 2009-12-21. added of_replace_sort()
			ids_search_temp.sort()
		end if
	elseif  is_filter_string <> ls_filter then
		//resort by  master_contract_id A,ctx_id A sort - 06.17.2009 by jervis
		ids_search_temp.Setsort(  "master_contract_id A,ctx_id A")
		ids_search_temp.sort()
	end if
	
	
	//Copy Parent Contract
	ll_find = ids_search_temp.find( "master_contract_id <> 0", 1,ids_search_temp.RowCount())
	dw_search_det1.reset()
	if ll_find > 0 then
		ids_search_temp.RowsMove(1,ll_find - 1, Primary!, dw_search_det1, 1, Primary!)
	end if
	
	//Copy Sub-Contract
	ll_count = dw_search_det1.rowcount()
	if ll_count > 0 then
		ll_ctx_parent = dw_search_det1.object.ctx_id.primary
		
		ll_cur_row = 1
		for ll_i = 1 to ll_count
			of_display_row(ll_ctx_parent[ll_i],ll_cur_row)	
		Next
	end if
	
	//Added By Ken.Guo 2009-12-03. Sort other data.
	If ls_sort_s <> "" and ls_sort_s <> "?" Then
		ids_search_temp.SetSort( of_replace_sort ( ls_sort_s) ) //Modified By Ken.Guo 2009-12-21. added of_replace_sort()
		ids_search_temp.Sort()
	End If
	
	//Copy other Contract
	ids_search_temp.RowsMove(1,ids_search_temp.RowCount(), Primary!, dw_search_det1, dw_search_det1.RowCount() + 1, Primary!)	
End If

SetPointer(Arrow!)
end subroutine

public subroutine of_display_row_old (long al_ctx_id, long al_row);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_searchof_display_row()
// $<arguments>
//		value	long	al_ctx_id		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.30.2007 by Jack 
//////////////////////////////////////////////////////////////////////
long li,li_rows,li_new
string ls_filter
string ls_sort_column
long ll_ctx_id

//dw_search_det1.Setredraw( False ) 08.20.2008 By Jervis

If isnull(is_filter_string) or is_filter_string = '' Then
	ls_filter = "master_contract_id = " + string(al_ctx_id)
Else
	ls_filter = " master_contract_id = " + string(al_ctx_id)  + " and " + is_filter_string
End if	

ids_search.setfilter(ls_filter)
ids_search.filter()

li_rows = ids_search.rowcount()
li_new = al_row + 1

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.05.2007 By: Jack
//$<reason> Performance tuning
/*
For li = 1 To li_rows
	li_new = dw_search_det1.insertrow(li_new)
	dw_search_det1.setitem(li_new,'owner','      ' + trim(ids_search.getitemstring(li,'owner')))  //Add by Jack 05/22/2007
	dw_search_det1.setitem(li_new,'ctx_id',ids_search.getitemnumber(li,'ctx_id'))
	dw_search_det1.setitem(li_new,'master_contract_id',ids_search.getitemnumber(li,'master_contract_id'))
	dw_search_det1.setitem(li_new,'status',ids_search.getitemnumber(li,'status'))
	dw_search_det1.setitem(li_New,'app_facility',ids_search.getitemnumber(li,'app_facility'))
	dw_search_det1.setitem(li_new,'product_name',ids_search.getitemstring(li,'product_name'))
	dw_search_det1.setitem(li_new,'contracted_entity',ids_search.getitemnumber(li,'contracted_entity'))
	dw_search_det1.setitem(li_new,'product_type',ids_search.getitemstring(li,'product_type'))
	dw_search_det1.setitem(li_new,'category',ids_search.getitemnumber(li,'category'))
	dw_search_det1.setitem(li_new,'effective_date',ids_search.getitemdatetime(li,'effective_date'))
	dw_search_det1.setitem(li_new,'expriation_date',ids_search.getitemdatetime(li,'expriation_date'))
	li_new = li_new+1
Next
*/

For li = 1 To li_rows
	ids_search.SetItem(li,'owner','      ' + trim(ids_search.getitemstring(li,'owner')))
	
	ll_ctx_id = ids_search.getitemnumber(li,'ctx_id')
	If is_output1 = '' Then
		is_output1 = string(ll_ctx_id)
	Else
		is_output1 = is_output1 + ',' + string(ll_ctx_id)
	End If
Next

ids_search.RowsCopy(1,li_rows, Primary!, dw_search_det1, li_new, Primary!) //<add> 07.05.2007 By: Jack

//---------------------------- APPEON END ----------------------------

dw_search_det1.setitem(al_row,'style','-')

//dw_search_det1.Setredraw( True )

end subroutine

public subroutine of_display_row (long al_ctx_id, ref long al_row);//Rewrite of_display_row - Jervis 06.23.2009
//performance optimize

long li,li_rows,li_new
string ls_filter
string ls_sort_column
long ll_ctx_id
long ll_start_row,ll_end_row
long ll_count

SetPointer(HourGlass!)

//Find sub-contracts
ll_start_row = ids_search_temp.find( "master_contract_id = " + string(al_ctx_id), 1, ids_search_temp.Rowcount())
if ll_start_row > 0 then
	ll_end_row = ids_search_temp.find( "master_contract_id <> " + string(al_ctx_id), ll_start_row, ids_search_temp.Rowcount())
	if ll_end_row = 0 then 
		ll_end_row = ids_search_temp.Rowcount( ) + 1
	end if
	ll_count = ll_end_row - ll_start_row
	
	//Set retraction
	For li = ll_start_row To ll_end_row - 1
		ids_search_temp.SetItem(li,'owner','      ' + trim(ids_search_temp.getitemstring(li,'owner')))
	next
	

	//Move sub-contracts
	ids_search_temp.RowsMove(ll_start_row,ll_end_row - 1, Primary!, dw_search_det1, al_row + 1, Primary!) //<add> 07.05.2007 By: Jack
	
	//Set retraction flag
	dw_search_det1.setitem(al_row,'style','-')
	
	al_row = al_row + ll_count + 1
else
	al_row = al_row + 1
end if




end subroutine

public subroutine of_expand_row (long al_ctx_id, long al_row);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_searchof_display_row()
// $<arguments>
//		value	long	al_ctx_id		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.30.2007 by Jack 
//////////////////////////////////////////////////////////////////////
long li,li_rows,li_new
string ls_filter
string ls_sort_column
long ll_ctx_id

If isnull(is_filter_string) or is_filter_string = '' Then
	ls_filter = "master_contract_id = " + string(al_ctx_id)
Else
	ls_filter = " master_contract_id = " + string(al_ctx_id)  + " and " + is_filter_string
End if	

ids_search_temp.setfilter(ls_filter)
ids_search_temp.filter()

li_rows = ids_search_temp.rowcount()
li_new = al_row + 1

/*
For li = 1 To li_rows
	ids_search_temp.SetItem(li,'owner','      ' + trim(ids_search_temp.getitemstring(li,'owner')))
Next
*/
ids_search_temp.Rowsmove(1,li_rows, Primary!, dw_search_det1, li_new, Primary!) //<add> 07.05.2007 By: Jack

//---------------------------- APPEON END ----------------------------

dw_search_det1.setitem(al_row,'style','-')



end subroutine

public subroutine of_dsretrieve_dddw (ref datastore ads_search, boolean ab_autoretrieve);LONG LL_COLUMN_COUNT , LL_I
string ls_dddw_name
string ls_colname
String ls_coltag
Integer li_value
Integer ll_lookup_code

DataWindowChild dwchild
n_ds lnds_user

LL_COLUMN_COUNT = LONG(ads_search.Describe("DataWindow.Column.Count"))
IF LL_COLUMN_COUNT = 0 THEN RETURN

FOR LL_I = 1 TO LL_COLUMN_COUNT
	IF ads_search.Describe("#" +STRING(LL_I) + ".Edit.Style") = 'dddw' then
		ls_colname = ads_search.Describe("#" +STRING(LL_I) + ".Name")
		ls_dddw_name = lower(ads_search.Describe("#" +STRING(LL_I) + ".DDDW.Name"))

		IF ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" THEN
			ls_coltag = Lower(ads_search.Describe("#" +STRING(LL_I) + ".TAG"))
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
				
			IF li_value <> 1 THEN
				gnv_app.of_setcontraccache_code_lookup( ls_coltag )
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
			END IF
		elseif ls_dddw_name = 'd_dddw_company' or ls_dddw_name = 'd_dddw_company_list'  then	//jervis 12.8.2009
			ls_coltag = Lower(ads_search.Describe("#" +STRING(LL_I) + ".TAG"))
			li_value = 1
		ELSE
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
		END IF

		IF li_value = 1 THEN
			ads_search.getchild( ls_colname, dwchild)
			if ls_dddw_name = 'd_dddw_company' or ls_dddw_name = 'd_dddw_company_list' then	//jervis 12.8.2009
				dwchild.SetTransObject( sqlca)
				dwchild.Retrieve( ls_coltag)
			else
				lnds_user.ShareData ( dwchild )	
			end if
		END IF
	END IF
NEXT



end subroutine

public function integer of_gen_treeview_child (long al_ctx_id, long al_parent_handle);of_gen_treeview_child(al_ctx_id,al_parent_handle,'')

/*
Long ll_cnt,ll_ctx_id,ll_cpu,ll_find,ll_handle,ll_master_cnt,k
String ls_label
long ll_row

treeviewitem litv_root

Do While 1 = 1
	ll_cnt = ids_search_temp_child.RowCount()
	If ll_cnt = 0 Then Exit
	ll_find = ids_search_temp_child.Find('master_contract_id = ' + String(al_ctx_id) ,1 , ll_cnt)
	If ll_find > 0 Then
		//ids_search_temp_child.Describe("evaluate('lookupdisplay(status)',"+String(ll_find)+")") + ' - ' + &
		ls_label = ''
		ll_ctx_id = ids_search_temp_child.GetItemNumber(ll_find, 'ctx_id')
		For k = 1 To UpperBound(inv_ctx_tv.is_display_columns[] )
			//ls_label +=  ids_search_temp_child.Describe("evaluate('lookupdisplay(" + inv_ctx_tv.is_display_columns[k] + ")',"+String(ll_find)+")") + ' - ' 
			ls_label += of_getitem(ids_search_temp_child,inv_ctx_tv.is_display_columns[k],ll_find)
		Next
		If ls_label = '' or isnull(ls_label) Then
			ls_label = ids_search_temp_child.GetItemString(ll_find,'facility_name')
			If isnull(ls_label) Then ls_label = '' 
			ls_label = string(ll_ctx_id) + '-' + ls_label
		Else
			ls_label = Mid(ls_label,1,Len(ls_label) - 3) 	
		End If	

		il_cnt++
		litv_root.label = string(ll_ctx_id) + '-' + ls_label
		litv_root.data = ll_ctx_id
		litv_root.children = false
		litv_root.pictureindex =2
		litv_root.selectedpictureindex = 3
		ll_handle = tv_ctx.insertitemlast(al_parent_handle,litv_root)
		
		ll_row = ids_ctx_tv_map.InsertRow(0)
		ids_ctx_tv_map.SetItem(ll_row,'ctx_id',ll_ctx_id)
		ids_ctx_tv_map.SetItem(ll_row,'tv_handle',ll_handle)		
		
		ll_master_cnt = ids_search_temp_child.GetItemNumber(ll_find,'master_cnt')
		ids_search_temp_child.deleterow(ll_find)
		If ll_master_cnt > 0 Then 
			of_gen_treeview_child(ll_ctx_id,ll_handle)
		End If
	Else
		Exit
	End If
Loop
*/
return 1
end function

public function integer of_gen_treeview ();Long i,k,ll_cnt,ll_ctx_id,ll_cpu,ll_find,ll_handle,ll_master_cnt
String ls_label,ls_category_name,ls_category_name_pre
long ll_category_id,ll_category_id_pre
long ll_handle_category
long ll_row
String 	ls_to_do_list

//tv_ctx.SetRedraw(False)
tv_ctx.deleteitem(1)
il_cnt = 0
tv_ctx.bringtotop = True
tv_ctx.y = dw_search_det1.y
//Begin - Added By Mark Lee 12/24/2012
//tv_ctx.height = dw_search_det1.height
ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )	
If not Isnull(ls_to_do_list) and ls_to_do_list = '1'  and st_hbar2.visible = True Then 
	tv_ctx.height = st_hbar2.y - tv_ctx.y
Else
	tv_ctx.height = dw_search_det1.height
End If
//End - Added By Mark Lee 12/24/2012


treeviewitem litv_root,litv_child

tv_ctx.PictureHeight = 32

litv_root.label = '' //Set Label value in of_refresh_tv()
//If inv_ctx_tv.is_tv_type = 'row' Then 
//	litv_root.label = 'Related Contracts  (right click to show settings)'
//Else
//	litv_root.label = 'ALL (right click to show settings)'
//End If
litv_root.data = -1
litv_root.children = true
litv_root.pictureindex =1
litv_root.selectedpictureindex = 1
il_root = tv_ctx.insertitemlast(0,litv_root)
ll_handle_category = il_root

ll_cnt = ids_search_temp.rowcount()


ids_ctx_tv_map.Reset()
ids_group_tv_map.Reset()

ib_group_view = False

//For i = 1 To il_child_ctx_start - 1
For i = 1 To ll_cnt
		If inv_ctx_tv.ii_use_group = 1 Then
			ls_category_name = of_getitem(ids_search_temp,inv_ctx_tv.is_group_by,i,false)
		Else
			ls_category_name = '!'
		End If
		
		If (ls_category_name <> ls_category_name_pre or i = 1) and ls_category_name <> '!' and ls_category_name <> '?' Then
			ib_group_view = True
			ls_category_name_pre = ls_category_name
			litv_child.label =  ls_category_name
			litv_child.data = 0
			litv_child.children = false
			litv_child.pictureindex =5
			litv_child.selectedpictureindex = 6
			ll_handle_category = tv_ctx.insertitemlast(il_root,litv_child)		
			
			ids_group_tv_map.SetItem(ids_group_tv_map.Rowcount(),'sub_ctx_count',il_sub_ctx_count)
			
			ll_row = ids_group_tv_map.InsertRow(0)
			ids_group_tv_map.SetItem(ll_row,'group_name',litv_child.label)
			ids_group_tv_map.SetItem(ll_row,'tv_handle',ll_handle_category)
			il_sub_ctx_count = 0
		End If
		
		ls_label = ''
		ll_ctx_id = ids_search_temp.GetItemNumber(i, 'ctx_id')
		For k = 1 To UpperBound(inv_ctx_tv.is_display_columns[] )
			ls_label += of_getitem(ids_search_temp, inv_ctx_tv.is_display_columns[k] , i) //+ '	' 
		Next
		If ls_label = '' or isnull(ls_label) Then
			ls_label = ids_search_temp.GetItemString(i,'facility_name')
			If isnull(ls_label) Then ls_label = '' 
			ls_label = string(ll_ctx_id) + '-' + ls_label
		Else
			ls_label = Mid(ls_label,1,Len(ls_label) - 3) 	
		End If
		
		il_cnt++
		litv_child.label = ls_label
		litv_child.data = ll_ctx_id
		litv_child.children = false
		litv_child.pictureindex =2
		litv_child.selectedpictureindex = 3
		ll_handle = tv_ctx.insertitemlast(ll_handle_category,litv_child)
		il_sub_ctx_count++
		
		ll_row = ids_ctx_tv_map.InsertRow(0)
		ids_ctx_tv_map.SetItem(ll_row,'ctx_id',ll_ctx_id)
		ids_ctx_tv_map.SetItem(ll_row,'tv_handle',ll_handle)
		
		//ids_search_temp.SetItem(i,'flag',-1)	
		ll_master_cnt = ids_search_temp.GetItemNumber(i,'master_cnt')
		If ll_master_cnt > 0 Then 
			//Add children recursion.  
			of_gen_treeview_child(ll_ctx_id,ll_handle)
		End If	
		
		If i = ll_cnt and inv_ctx_tv.ii_use_group = 1 Then
			ids_group_tv_map.SetItem(ids_group_tv_map.Rowcount(),'sub_ctx_count',il_sub_ctx_count)
		End If
Next
//tv_ctx.SetRedraw(True)
Return 1	

end function

public function integer of_copy_row_tv ();//Rewrite of_copy_row - jervis 06.23.2009
//performance optimize

string 	ls_filter
long 		ll_i,ll_ctx_id,ll_master_contract_id,ll_master_cnt
long ll_find
long ll_ctx_parent[]
long ll_count_parent[]
long ll_count
long ll_cur_row
string ls_sort_s,ls_sort_t

SetPointer(HourGlass!)



dw_search_det1.Reset()
tv_ctx.deleteitem(1)

//Set Filter
ls_filter = upper(ids_search.Describe( "datawindow.table.filter"))
if ls_filter = "?" then ls_filter = ""
if is_filter_string <> ls_filter then
	ids_search.setfilter(is_filter_string)
	ids_search.filter()
end if

//copy to temp datastore
//gnv_debug.of_output('ids_search.sort() start:' + ls_sort_s)
ls_sort_s = dw_search_det1.Describe( "datawindow.table.sort")
ids_search.Setsort( of_replace_sort( ls_sort_s) ) //Modified By Ken.Guo 2009-12-21. added of_replace_sort()
ids_search.sort()
//gnv_debug.of_output('ids_search.sort() end:' + ls_sort_s)

ids_search.rowscopy( 1,ids_search.Rowcount(),primary!,dw_search_det1,1,primary!)

//Added By Ken.Guo 12/10/2011. 
ids_ctx_tv_map.Reset()

//Added By Ken.Guo 04/29/2013. Support PowerFilter
If isvalid(iu_PowerFilter) Then
	iu_PowerFilter.of_reset( ) 
	iu_PowerFilter.of_Reset_OriginalFilter( )//added by gavins 20130424
End If

//Added By Ken.Guo 12/10/2011. 
If inv_ctx_tv.is_tv_type = 'row' Then 
	If dw_search_det1.GetRow() > 0 Then
		ll_ctx_id = dw_search_det1.GetItemNumber(dw_search_det1.GetRow(), 'ctx_id')
		This.of_get_related_ctx( ll_ctx_id, 'row')	
	End If
Else
	of_refresh_tv(ids_search)
End If



return 1
end function

public subroutine of_set_parent_top (ref datastore ads_source);Long ll_cnt,i,j,ll_master_ctx_id,ll_find,ll_ctx_id
DataStore lds_temp

ll_cnt = ads_source.rowcount()
If ll_cnt = 0 then Return

lds_temp = Create DataStore
lds_temp.dataobject = ads_source.dataobject

ads_source.RowsMove(1,ads_source.rowcount(),Primary!,lds_temp,1,Primary!)

For i = 1 To ll_cnt
	ll_ctx_id = lds_temp.GetItemNumber(i,'ctx_id')
	ll_master_ctx_id = lds_temp.GetItemNumber(i,'master_contract_id')
	lds_temp.RowsCopy(i,i,Primary!,ads_source,1,Primary!)
	j = 1
	Do While 1 = 1 
		ll_find = ads_source.Find('ctx_id = ' + String(ll_master_ctx_id),j,ads_source.rowcount())
		If ll_find <= 0 Then Exit
		ll_master_ctx_id = ads_source.GetItemNumber(ll_find,'master_contract_id')
		If ll_master_ctx_id = ll_ctx_id Then Exit //forbid ctx_id =  master_ctx_id or data infinite loops
		ads_source.RowsMove(ll_find,ll_find,Primary!,ads_source,1,Primary!) //Move to top
		J++
	Loop
	
Next


Destroy lds_temp
Return 

end subroutine

public subroutine of_set_style ();If ii_style = 0 or ii_style = 1 Then
	If isvalid(w_searchpage_calendar) Then
		Close(w_searchpage_calendar)
	End If
End If

//Added By Mark Lee 11/08/2012
If Not isvalid(inv_ctx_tv) Then
	inv_ctx_tv = Create n_cst_ctx_tv
	inv_ctx_tv.event ue_retrieve( )		
End If	

//Set Treeview style
If ii_style = 1 Then
	
	st_vbar.width = ii_border
	
	ib_tree_view = True
	tv_ctx.visible = True
	st_vbar.visible = True	
	//Begin - Added By Mark Lee 11/08/2012
//	If Not isvalid(inv_ctx_tv) Then
//		inv_ctx_tv = Create n_cst_ctx_tv
//		inv_ctx_tv.event ue_retrieve( )		
//	End If	
	//End - Added By Mark Lee 11/08/2012
	
	Choose Case inv_ctx_tv.ii_hidebrowse
		Case 0
			tv_ctx.visible = True
			st_vbar.visible = True	
			dw_search_det1.visible = True
			//tv_ctx.width = st_vbar.x - tv_ctx.x - 5
			//dw_search_det1.x = st_vbar.x + st_vbar.width + 5
			//If dw_search_det1.width <> (dw_search.width - dw_search_det1.x ) Then
			//	dw_search_det1.width = dw_search.width - dw_search_det1.x 
			//End If				

			tv_ctx.x = st_vbar.x + st_vbar.width + 5
			tv_ctx.width = dw_search.x + dw_search.width - tv_ctx.x
			dw_search_det1.x = dw_search.x
			dw_search_det1.width = dw_search.width - tv_ctx.width - st_vbar.width - 10

						//st_vbar.x = tv_ctx.x + tv_ctx.width + 5
			
		Case 1
			dw_search_det1.visible = False
			st_vbar.visible = False
			tv_ctx.x = dw_search.x
			tv_ctx.width = dw_search.width
			dw_search_det1.x = dw_search.x
			If dw_search_det1.width <> dw_search.width Then
				dw_search_det1.width = dw_search.width
			End If				
	End Choose
	ii_hidebrowse = inv_ctx_tv.ii_hidebrowse
Else
	ib_tree_view = False
	tv_ctx.visible = False
	st_vbar.visible = False	
	dw_search_det1.x = dw_search.x
	If dw_search_det1.width <> dw_search.width Then
		dw_search_det1.width = dw_search.width
	End If	
End If

//Set UI
Choose Case ii_style
	Case 0 //Default
		dw_search_det1.visible = True
	Case 1 //Treeview
		//
	Case 2 //Calu
		dw_search_det1.visible = False
End Choose

//Added By Ken.Guo 04/09/2013
If tv_ctx.visible Then
	This.of_tv_set_font( )
End If

end subroutine

public function string of_getitem (datastore ads_datasource, string as_col, long al_row);Return of_getitem(ads_datasource,as_col,al_row,True)
/*
Long ll_find,i
String ls_data
Integer ll_index

//ii_max_col_len[1] = ads_datasource.GetItemNumber(ll_cnt,'compute_ctx_id_len')
//ii_max_col_len[2] = ads_datasource.GetItemNumber(ll_cnt,'compute_owner_len')
//ii_max_col_len[3] = ads_datasource.GetItemNumber(ll_cnt,'compute_facility_name_len')
//ii_max_col_len[4] = ads_datasource.GetItemNumber(ll_cnt,'compute_category_name_len')
//ii_max_col_len[5] = ads_datasource.GetItemNumber(ll_cnt,'compute_contract_type_name_len')
//ii_max_col_len[6] = ads_datasource.GetItemNumber(ll_cnt,'compute_status_name_len')
//ii_max_col_len[7] = ads_datasource.GetItemNumber(ll_cnt,'compute_dvision_name_len')

For i = 1 To UpperBound(is_tv_col_name[])
	If Lower(as_col) = is_tv_col_name[i] Then Exit
Next

//If not found
If i > UpperBound(is_tv_col_name[]) Then Return ''  	


Choose Case Lower(as_col)
	Case is_tv_col_name[1] //'ctx_id'
		ls_data = String(ads_datasource.GetItemNumber(al_row,as_col))
	Case Else //'owner','facility_name','category_name','contract_type_name','status_name','dvision_name'
		ls_data = ads_datasource.GetItemString(al_row,as_col)
End Choose


If ii_max_col_len[i] < 6 Then ii_max_col_len[i] = 6

If inv_ctx_tv.ii_col_max_width <> 0 And inv_ctx_tv.ii_col_max_width < ii_max_col_len[i] Then
	ii_max_col_len[i] = inv_ctx_tv.ii_col_max_width
End If

If isnull(ls_data) Then ls_data = '(None)'

If Len(ls_data) <= ii_max_col_len[i] Then
	ls_data += Space(ii_max_col_len[i] - Len(ls_data)) 
Else
	ls_data = Left(ls_data, ii_max_col_len[i] - 4 ) + ' ...'
End If

ls_data += "    "

Return ls_data
*/
end function

public function string of_replace_sort (string as_sort);//LookUpDisplay(status) A
Integer li_pos,i
String ls_replace_syntax[],ls_replace_syntax_web[],ls_value[]

// 'ctx_id','category','contract_type','status','dvision','owner','facility_name'
ls_replace_syntax[1] = "lookupdisplay(status)"
ls_replace_syntax[2] = "lookupdisplay(category)"
ls_replace_syntax[3] = "lookupdisplay(contract_type)"
ls_replace_syntax[4] = "lookupdisplay(dvision)"
ls_replace_syntax[5] = "lookupdisplay(app_facility)"

ls_replace_syntax_web[1] = "lookupdisplay ( status )"
ls_replace_syntax_web[2] = "lookupdisplay ( category )"
ls_replace_syntax_web[3] = "lookupdisplay ( contract_type )"
ls_replace_syntax_web[4] = "lookupdisplay ( dvision )"
ls_replace_syntax_web[5] = "lookupdisplay ( app_facility )"

ls_value[1] = "status_name"
ls_value[2] = "category_name"
ls_value[3] = "contract_type_name"
ls_value[4] = "dvision_name"
ls_value[5] = "facility_name"

as_sort = Lower(as_sort)

For i = 1 To UpperBound(ls_replace_syntax_web[])
	li_pos = Pos(as_sort, ls_replace_syntax_web[i] ) 
	If li_pos > 0 Then
		as_sort = Replace(as_sort,li_pos,len(ls_replace_syntax_web[i]),ls_value[i])
	End If
Next

For i = 1 To UpperBound(ls_replace_syntax[])
	li_pos = Pos(as_sort, ls_replace_syntax[i] ) 
	If li_pos > 0 Then
		as_sort = Replace(as_sort,li_pos,len(ls_replace_syntax[i]),ls_value[i])
	End If
Next	

Return as_sort

end function

public subroutine of_tv_set_group_sum ();Long i
Long ll_cnt,ll_handle
TreeViewItem ltvi_group
For i = 1 To ids_group_tv_map.RowCount()
	ll_handle = ids_group_tv_map.GetItemNumber(i,'tv_handle')
	ll_cnt = ids_group_tv_map.GetItemNumber(i,'sub_ctx_count')
	tv_ctx.GetItem(ll_handle,ltvi_group)
	ltvi_group.label = ltvi_group.label + '(' + String(ll_cnt) + ')'
	tv_ctx.SetItem(ll_handle,ltvi_group)
Next

Return 
end subroutine

public function integer of_gen_treeview_other ();Long i,k,ll_cnt,ll_ctx_id,ll_cpu,ll_find,ll_handle,ll_row
Long ll_handle_parent
String ls_label
treeviewitem litv_root,litv_child
String ls_group_name

of_set_parent_top(ids_search_temp_child)

ll_cnt = ids_search_temp_child.RowCount()

	
Do while ll_cnt > 0	
			il_sub_ctx_count = 0
			ls_label = ''
			ll_ctx_id = ids_search_temp_child.GetItemNumber(1, 'ctx_id')
			For k = 1 To UpperBound(inv_ctx_tv.is_display_columns[] )
				ls_label += of_getitem(ids_search_temp_child,inv_ctx_tv.is_display_columns[k],1) //+ '	'
			Next
			If ls_label = '' or isnull(ls_label) Then
				ls_label = ids_search_temp_child.GetItemString(1,'facility_name')
				If isnull(ls_label) Then ls_label = '' 
				ls_label = string(ll_ctx_id) + '-' + ls_label
			Else
				ls_label = Mid(ls_label,1,Len(ls_label) - 3) 	
			End If				
			
			il_cnt++
			litv_root.label = ls_label
			litv_root.data = ll_ctx_id
			litv_root.children = false
			litv_root.pictureindex =4
			litv_root.selectedpictureindex = 3
			
			If ib_group_view Then
				//ls_group_name = ids_search_temp_child.Describe("evaluate('lookupdisplay("+is_sort_column+")',"+String(1)+")")
				ls_group_name = of_getitem(ids_search_temp_child, inv_ctx_tv.is_group_by, 1 ,false)
				If ls_group_name <> '!' and ls_group_name <> '?' Then
					ll_find = ids_group_tv_map.Find('group_name = "' + ls_group_name + '"',1, ids_group_tv_map.rowcount())
					If ll_find > 0 Then
						//Use exists Group							
						ll_handle_parent = ids_group_tv_map.GetItemNumber(ll_find,'tv_handle')
					Else
						//Insert new Group
						litv_child.label =  ls_group_name
						litv_child.data = 0
						litv_child.children = false
						litv_child.pictureindex =5
						litv_child.selectedpictureindex = 6
						ll_handle_parent = tv_ctx.insertitemlast(il_root,litv_child)		
						ll_row = ids_group_tv_map.InsertRow(0)
						ids_group_tv_map.SetItem(ll_row,'group_name',litv_child.label)
						ids_group_tv_map.SetItem(ll_row,'tv_handle',ll_handle_parent)
					End If
				Else
					//Parent handle is Root
					ll_handle_parent = il_root
				End If				
				ll_handle = tv_ctx.insertitemlast(ll_handle_parent,litv_root)
				il_sub_ctx_count++
			Else
				ll_handle = tv_ctx.insertitemlast(il_root,litv_root)
			End If
			ll_row = ids_ctx_tv_map.InsertRow(0)
			ids_ctx_tv_map.SetItem(ll_row,'ctx_id',ll_ctx_id)
			ids_ctx_tv_map.SetItem(ll_row,'tv_handle',ll_handle)	

			//Generate Child 
			ids_search_temp_child.DeleteRow(1)
			of_gen_treeview_child(ll_ctx_id,ll_handle,'other')
			If ib_group_view Then
				of_tv_group_sum_update(ll_handle_parent,il_sub_ctx_count)
			End If
			ll_cnt = ids_search_temp_child.RowCount()
Loop	


//	Next 
//End If

Return 1
end function

public function integer of_gen_treeview_child (long al_ctx_id, long al_parent_handle, string as_type);Long ll_cnt,ll_ctx_id,ll_cpu,ll_find,ll_handle,ll_master_cnt,k
String ls_label
long ll_row

treeviewitem litv_root

Do While 1 = 1
	ll_cnt = ids_search_temp_child.RowCount()
	If ll_cnt = 0 Then Exit
	ll_find = ids_search_temp_child.Find('master_contract_id = ' + String(al_ctx_id) ,1 , ll_cnt)
	If ll_find > 0 Then
		//ids_search_temp_child.Describe("evaluate('lookupdisplay(status)',"+String(ll_find)+")") + ' - ' + &
		ls_label = ''
		ll_ctx_id = ids_search_temp_child.GetItemNumber(ll_find, 'ctx_id')
		For k = 1 To UpperBound(inv_ctx_tv.is_display_columns[] )
			//ls_label +=  ids_search_temp_child.Describe("evaluate('lookupdisplay(" + inv_ctx_tv.is_display_columns[k] + ")',"+String(ll_find)+")") + ' - ' 
			ls_label += of_getitem(ids_search_temp_child,inv_ctx_tv.is_display_columns[k],ll_find) //+ '	'
		Next
		If ls_label = '' or isnull(ls_label) Then
			ls_label = ids_search_temp_child.GetItemString(ll_find,'facility_name')
			If isnull(ls_label) Then ls_label = '' 
			ls_label = string(ll_ctx_id) + '-' + ls_label
		Else
			ls_label = Mid(ls_label,1,Len(ls_label) - 3) 	
		End If	

		il_cnt++
		litv_root.label = ls_label
		litv_root.data = ll_ctx_id
		litv_root.children = false
		If as_type <> '' Then
			litv_root.pictureindex = 4
		Else
			litv_root.pictureindex = 2
		End If
		litv_root.selectedpictureindex = 3
		ll_handle = tv_ctx.insertitemlast(al_parent_handle,litv_root)
		il_sub_ctx_count++
		
		ll_row = ids_ctx_tv_map.InsertRow(0)
		ids_ctx_tv_map.SetItem(ll_row,'ctx_id',ll_ctx_id)
		ids_ctx_tv_map.SetItem(ll_row,'tv_handle',ll_handle)		
		
		ll_master_cnt = ids_search_temp_child.GetItemNumber(ll_find,'master_cnt')
		ids_search_temp_child.deleterow(ll_find)
		If ll_master_cnt > 0 Then 
			of_gen_treeview_child(ll_ctx_id,ll_handle)
		End If
	Else
		Exit
	End If
Loop

return 1
Return 1

end function

public subroutine of_tv_group_sum_update (long al_handle, long al_add_count);Long ll_find
Long ll_value

ll_find = ids_group_tv_map.Find('tv_handle = ' + string(al_handle),1,ids_group_tv_map.rowcount())
If ll_find > 0 Then
	ll_value = ids_group_tv_map.GetItemNumber(ll_find,'sub_ctx_count')
	If Isnull(ll_value) Then ll_value = 0
	ids_group_tv_map.SetItem(ll_find,'sub_ctx_count',ll_value + al_add_count )
End If

end subroutine

public subroutine of_set_style (integer ai_style);If ii_style = ai_style Then
	If ai_style = 1 Then //Treeview
		If inv_ctx_tv.ii_hidebrowse <> ii_hidebrowse Then
			of_set_style()
			Return
		End If
	Else
		Return
	End If
End If

//If ii_style = ai_style Then Return
ii_style = ai_style
of_set_style()
//
//Retrieve Data
If isvalid(ids_search) and ib_retrieve Then
	Choose Case ii_style
		Case 0,1 //Default, TreeView
			this.of_filter()
		Case 2 //Calu
	End Choose
End If
end subroutine

public subroutine of_tv_get_max_len (datastore ads_datasource);Long ll_cnt,i
ll_cnt = ads_datasource.rowcount()
If ll_cnt  <= 0 Then Return

For i = 1 To UpperBound(is_tv_col_name[])
	ii_max_col_len[i] = ads_datasource.GetItemNumber(ll_cnt,'compute_'+is_tv_col_name[i]+'_len')
Next

/*
ii_max_col_len[1] = ads_datasource.GetItemNumber(ll_cnt,'compute_ctx_id_len')
ii_max_col_len[2] = ads_datasource.GetItemNumber(ll_cnt,'compute_owner_len')
ii_max_col_len[3] = ads_datasource.GetItemNumber(ll_cnt,'compute_facility_name_len')
ii_max_col_len[4] = ads_datasource.GetItemNumber(ll_cnt,'compute_category_name_len')
ii_max_col_len[5] = ads_datasource.GetItemNumber(ll_cnt,'compute_contract_type_name_len')
ii_max_col_len[6] = ads_datasource.GetItemNumber(ll_cnt,'compute_status_name_len')
ii_max_col_len[7] = ads_datasource.GetItemNumber(ll_cnt,'compute_dvision_name_len')
*/

end subroutine

public function string of_getitem (datastore ads_datasource, string as_col, long al_row, boolean ab_use_mask);Long ll_find,i
String ls_data
Integer ll_index

//ii_max_col_len[1] = ads_datasource.GetItemNumber(ll_cnt,'compute_ctx_id_len')
//ii_max_col_len[2] = ads_datasource.GetItemNumber(ll_cnt,'compute_owner_len')
//ii_max_col_len[3] = ads_datasource.GetItemNumber(ll_cnt,'compute_facility_name_len')
//ii_max_col_len[4] = ads_datasource.GetItemNumber(ll_cnt,'compute_category_name_len')
//ii_max_col_len[5] = ads_datasource.GetItemNumber(ll_cnt,'compute_contract_type_name_len')
//ii_max_col_len[6] = ads_datasource.GetItemNumber(ll_cnt,'compute_status_name_len')
//ii_max_col_len[7] = ads_datasource.GetItemNumber(ll_cnt,'compute_dvision_name_len')

For i = 1 To UpperBound(is_tv_col_name[])
	If Lower(as_col) = is_tv_col_name[i] Then Exit
Next

//If not found
If i > UpperBound(is_tv_col_name[]) Then Return ''  	


Choose Case Lower(as_col)
	Case is_tv_col_name[1] //'ctx_id'
		ls_data = String(ads_datasource.GetItemNumber(al_row,as_col))
	Case Else //'owner','facility_name','category_name','contract_type_name','status_name','dvision_name'
		ls_data = ads_datasource.GetItemString(al_row,as_col)
End Choose


If ii_max_col_len[i] < 6 Then ii_max_col_len[i] = 6

If inv_ctx_tv.ii_col_max_width <> 0 And inv_ctx_tv.ii_col_max_width < ii_max_col_len[i] Then
	ii_max_col_len[i] = inv_ctx_tv.ii_col_max_width
End If

If isnull(ls_data) Then ls_data = '(None)'

If Not ab_use_mask Then Return ls_data

If Len(ls_data) <= ii_max_col_len[i] Then
	ls_data += Space(ii_max_col_len[i] - Len(ls_data)) 
Else
	ls_data = Left(ls_data, ii_max_col_len[i] - 4 ) + ' ...'
End If

ls_data += "    "

Return ls_data
end function

public function integer of_set_auto_refresh (boolean ab_auto);
int	li_autoret

if ab_auto then
	li_autoret = 1
	ib_autoretrieve = true
else
	li_autoret = 0
	ib_autoretrieve = false
end if
update security_users set set_autoret = :li_autoret where user_id = :gs_user_id;




Return 1
end function

public function integer of_get_related_child_ctx (long al_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_search.of_get_related_child_ctx()
// $<arguments>
//		value	long	al_ctx_id		
// $<returns> integer
// $<description>
// $<description> Get all child CTXs.
//////////////////////////////////////////////////////////////////////
// $<add> 2011-01-31 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_find_row
Long ll_ctx_id 

ll_find_row = ids_search.Find('master_contract_id = ' + String(al_ctx_id),1,ids_search.Rowcount())
Do While ll_find_row > 0 
	ll_ctx_id = ids_search.GetItemNumber(ll_find_row,'ctx_id')
	If ids_search_related_ctx.Find('ctx_id = ' + String(ll_ctx_id),1,ids_search_related_ctx.Rowcount()) = 0 Then //Added If statement By Ken.Guo 2011-03-11. Prevent infinite loop.
		ids_search.Rowscopy( ll_find_row, ll_find_row, Primary!, ids_search_related_ctx, 1, Primary!)
		of_get_related_child_ctx(ll_ctx_id)
	End If
	If ll_find_row =  ids_search.Rowcount() Then
		Exit
	End If
	ll_find_row = ids_search.Find('master_contract_id = ' + String(al_ctx_id),ll_find_row + 1,ids_search.Rowcount())
Loop

Return 1
end function

public subroutine of_refresh_tv (datastore ads_data);ids_search_temp.Reset( )
ids_search_temp_child.Reset( )
tv_ctx.deleteitem(1)

//ids_search.rowscopy( 1,ids_search.Rowcount(),primary!,ids_search_temp,1,primary!)
ads_data.rowscopy( 1,ads_data.Rowcount(),primary!,ids_search_temp,1,primary!)

//gnv_debug.of_output('rowscopy two ds')

of_tv_get_max_len(ids_search)

//Set Sort 
If inv_ctx_tv.is_sort_syntax <> '' Then
	ids_search_temp.SetSort(inv_ctx_tv.is_sort_syntax)
	ids_search_temp.Sort()
End If

ids_search_temp.SetFilter("master_contract_id = 0 or isnull(master_contract_id) ")
ids_search_temp.Filter()
ids_search_temp.RowsCopy(1,ids_search_temp.FilteredCount(),Filter!,ids_search_temp_child,1,Primary! )

//Workaround PB's Bug, need sort again
If inv_ctx_tv.is_sort_syntax <> '' Then
	ids_search_temp_child.SetSort(inv_ctx_tv.is_sort_syntax)
	ids_search_temp_child.Sort()
End If

//gnv_debug.of_output('child ctx cnt:' + String(ids_search_temp_child.rowcount()))
//gnv_debug.of_output('of_gen_treeview s')
of_gen_treeview()
//gnv_debug.of_output('of_gen_treeview e')
of_gen_treeview_other()
//gnv_debug.of_output('of_add_other_ctx e')

If inv_ctx_tv.ii_displaycount = 1 Then
	of_tv_set_group_sum()
End If

tv_ctx.expandall(il_root)

treeviewitem ltvi_root
tv_ctx.GetItem(1,ltvi_root)

If inv_ctx_tv.is_tv_type = 'row' Then 
	ltvi_root.label = 'Related Contracts ('+String(il_cnt)+')  - Right click to show settings'
Else
	ltvi_root.label = 'ALL ('+String(il_cnt)+') - Right click to show settings'
End If

tv_ctx.SetItem( 1, ltvi_root)
return

end subroutine

public subroutine of_get_related_ctx (long al_ctx_id, string as_type);//as_type, all: refresh browse dw and show all related CTX
//			  row: Only refresh the treeview with current ctx in browse dw.	

String ls_sort_s
Long ll_parent_ctx_id

//Added By Ken.Guo 12/10/2011. 
//If il_tv_ctx_id = al_ctx_id Then 
If ids_ctx_tv_map.Find('ctx_id = ' + String(al_ctx_id),1,ids_ctx_tv_map.rowcount() ) > 0 Then
	This.event ue_locate_treeview(al_ctx_id)	
	Return
End If

ids_search_related_ctx.reset()

If as_type = 'all' or inv_ctx_tv.ii_show_data = 1  Then
	ids_search.SetFilter('')
	ids_search.Filter()
End If

ll_parent_ctx_id = This.of_get_related_parent_ctx( al_ctx_id )

//Modified By Ken.Guo 12/10/2011
This.of_get_related_child_ctx( ll_parent_ctx_id )
//This.of_get_related_child_ctx( al_ctx_id )


ls_sort_s = dw_search_det1.Describe( "datawindow.table.sort")
ids_search_related_ctx.Setsort( of_replace_sort( ls_sort_s) ) 
ids_search_related_ctx.sort()

If as_type = 'all' Then
	dw_search_det1.Reset()
	ids_search_related_ctx.rowscopy( 1,ids_search_related_ctx.Rowcount(),primary!,dw_search_det1,1,primary!)
End If

This.of_refresh_tv(ids_search_related_ctx)

//This.Post event ue_locate_treeview(al_ctx_id)
event ue_locate_treeview(al_ctx_id)					//Added By Mark Lee 12/28/2012
	
end subroutine

public function long of_get_related_parent_ctx (long al_ctx_id);//////////////////////////////////////////////////////////////////////
// Function: of_get_related_parent_ctx()
// Arguments:
// 	value    long    al_ctx_id
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2011-01-31
//--------------------------------------------------------------------
// Description: Get All Parent CTX
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_find_row, ll_related_ctxlist[]
Long ll_parent_ctx_id ,ll_current_ctx_id,ll_parent_row

ll_find_row = ids_search.Find('ctx_id = ' + String(al_ctx_id),1,ids_search.Rowcount())
If ll_find_row <= 0 Then Return 0

//Copy itself
//ids_search.Rowscopy( ll_find_row, ll_find_row, Primary!, ids_search_related_ctx, 1, Primary!)
ll_parent_row = ll_find_row
ll_current_ctx_id = al_ctx_id

//Copy All Parent
ll_parent_ctx_id = ids_search.GetItemNumber(ll_find_row,'master_contract_id')
ll_find_row = ids_search.Find('ctx_id = ' + String(ll_parent_ctx_id),1,ids_search.Rowcount())

ll_related_ctxlist[UpperBound(ll_related_ctxlist[]) + 1] = al_ctx_id
Do While ll_find_row > 0 
	
	//Added By Ken.Guo 2011-03-11. Prevent infinite loop.
	ll_current_ctx_id = ids_search.GetItemNumber(ll_find_row,'ctx_id')
	
	//Added By Ken.Guo 12/12/2011. 
	If inv_string.of_isexists(ll_related_ctxlist[], ll_current_ctx_id) Then 
		Exit
	Else
		ll_related_ctxlist[UpperBound(ll_related_ctxlist[]) + 1] = ll_current_ctx_id
	End If
	
	//Added By Ken.Guo 12/10/2011. 
	ll_parent_row = ll_find_row
	
	If ids_search_related_ctx.Find('ctx_id = ' + String(ll_current_ctx_id),1,ids_search_related_ctx.Rowcount()) > 0 Then Exit 
	
//	ids_search.Rowscopy( ll_find_row, ll_find_row, Primary!, ids_search_related_ctx, 1, Primary!)
	ll_parent_ctx_id = ids_search.GetItemNumber(ll_find_row,'master_contract_id')	
	If ll_parent_ctx_id = 0 or isnull(ll_parent_ctx_id) Then Exit 
	ll_find_row = ids_search.Find('ctx_id = ' + String(ll_parent_ctx_id), 1 ,ids_search.Rowcount())
Loop
	
//Added By Ken.Guo 12/10/2011. 
ids_search.Rowscopy( ll_parent_row, ll_parent_row, Primary!, ids_search_related_ctx, 1, Primary!)
If ll_current_ctx_id <> 0  And Not isnull(ll_current_ctx_id) Then
	Return ll_current_ctx_id
Else
	Return al_ctx_id
End If

	
//Return 1
end function

public function string of_build_doc_filter (long al_doc_id, string as_doc_name, string as_doc_content, long al_doc_category, long al_doc_status);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_searchof_build_doc_filter()
// $<arguments>
//		value	long  	al_doc_id  		
//		value	string	as_doc_name		
//		value	string	as_doc_content		
// $<returns> string
// $<description>
// $<description> Get filter condition by document name or document id
//////////////////////////////////////////////////////////////////////
// $<add> 2010-06-08 by Ken.Guo
//modified by gavins 20120326
//////////////////////////////////////////////////////////////////////
String ls_ctx_id_list
Long ll_ctx_id[] ,i, li_fulltext
String ls_sql, ls_where
n_cst_string lnv_string
Integer		li_Pos

//n_ds lds_doc
//lds_doc = Create n_ds
//lds_doc.Dataobject = 'd_doc_search'
//lds_doc.SetTransObject(SQLCA)
//ls_sql = lower( lds_doc.GetSqlselect( ) )

ls_Sql = ""


//li_Pos = Pos( ls_Sql, 'union' )//added by gavins 20120326

If Not isnull(al_doc_id) and al_doc_id <> 0 Then
	ls_where += ' And ctx_am_document.doc_id = '	 + String(al_doc_id)
End If

If Not isnull(as_doc_name) and Trim(as_doc_name) <> '' Then
	ls_where += " And ctx_am_document.doc_name Like '%"	 + Trim(as_doc_name) + "%'"
End If

If Not isnull(as_doc_content) and Trim(as_doc_content) <> '' Then
	
	Select  (COLUMNPROPERTY (OBJECT_ID('ctx_am_doc_image'),'image_file','IsFulltextIndexed' ) ) Into :li_fulltext From ids;
	If li_fulltext = 0 Then
		If Messagebox('Search',"The Full-Text Catalog hasn't been created for the documents yet. Do you want to create it now? ", Question!,YesNo!) = 1 Then
			IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice
			//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
			//n_cst_update_sql lnv_sql
			//lnv_sql = Create n_cst_update_sql
			n_cst_update_sql_clx lnv_sql
			lnv_sql = Create n_cst_update_sql_clx
			//---------End Modfiied ------------------------------------------------------
			lnv_sql.of_release_fulltext( )			
			Destroy lnv_sql
		Else
//			Return '(-999999)'
			Return ""
		End If
	End If
	
	as_doc_content = lnv_string.of_do_fulltext(Trim(as_doc_content))
	If as_doc_content = '' Then
		Messagebox('Search','Please check the search text for the Document Content field.')
		dw_search.Post Setcolumn('document_content')
	Else
		ls_where += " And (contains(ctx_am_doc_image.image_file ,'" + as_doc_content + "') or contains(ctx_am_doc_image.pdftext, '" +  as_doc_content + "'))" 
	End If
End If

If Not isnull(al_doc_category) and  al_doc_category <> 0 Then
	ls_where += ' And ctx_am_document.category = '	 + String(al_doc_category)
End If

If Not isnull(al_doc_status) and  al_doc_status <> 0 Then
	ls_where += ' And ctx_am_document.status = '	 + String(al_doc_status)
End If


If Len( ls_where ) > 0 Then
	ls_SQL = 'select tableA.ctx_id from ( ' +  "SELECT DISTINCT ctx_am_document.ctx_id  " +  &
	" FROM ctx_am_document LEFT OUTER JOIN ctx_am_doc_image  " + &
	"ON (ctx_am_document.doc_id = ctx_am_doc_image.doc_id and ctx_am_document.Revision = ctx_am_doc_image.Revision)  " + &
	" where 1=1 " + ls_where  + " )tableA"
	ib_FilterValue = True
End If

Return ls_SQL 

//If li_Pos> 0 And Len( ls_where  ) > 0 Then
//	ls_sql =  Left( ls_sql, li_Pos - 1 ) + '  where 1=1 ' + ls_where + ' ' + Mid( ls_sql, li_Pos )
//	ib_FilterValue = True
//ElseIf li_Pos > 0 And Len(ls_where ) = 0 Then
//	ls_sql =  Left( ls_sql, li_Pos - 1 ) + '  where 1<>1 '  + Mid( ls_sql, li_Pos )	
//End If
//lds_doc.SetSqlSelect( ls_sql )

//Return lds_doc


//If ls_where = '' Then Return ''
//
//ls_where = ' Where 1 = 1 ' + ls_where
//
////Retrieve CTX data by document name or/and document id
//lds_doc.SetSQLSelect( ls_sql + ls_where)
//lds_doc.SetTransObject(SQLCA)
//lds_doc.Retrieve()

//If lds_doc.RowCount() > 0 Then
//	ll_ctx_id[] = lds_doc.object.ctx_id[1,lds_doc.RowCount()]
//End If
//
//For i = 1 To UpperBound(ll_ctx_id[])
//	ls_ctx_id_list += String(ll_ctx_id[i]) + ','
//Next
//
//If ls_ctx_id_list <> '' Then 
//	ls_ctx_id_list = '(' + Mid(ls_ctx_id_list,1,len(ls_ctx_id_list) - 1) + ')'
//Else
//	ls_ctx_id_list = '(-999999)'
//End If
//
//If isvalid(lds_doc) Then Destroy lds_doc
//Return ls_ctx_id_list


end function

public function string of_build_contact_filter (string as_sql, string as_name, string as_email, string as_association, string as_custom1, double adb_customn1, string as_class, string as_contact);//====================================================================
// Function: of_build_contact_filter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ads_filter
// 	as_name
// 	as_email
// 	as_association
// 	as_custom1
// 	adb_customn1
// 	as_class
// 	as_contact
//--------------------------------------------------------------------
// Returns:  datastore
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-03-27
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String			ls_Sql, ls_where = ""
Integer		li_Pos, li_Pos2


If Not isnull(as_Name) and as_Name <> '' Then
	ls_where += " And  charindex( '" + trim(as_Name) + "', name )>0"
End If

If Not isnull(as_email ) and Trim(as_email) <> '' Then
	ls_where += " And contact_email Like '%"	 + Trim(as_email) + "%'"
End If

If Not isnull(as_Association) and  as_Association <> '' Then
	ls_where += " And  association = '"	 + as_Association  + "'"
End If

If Not isnull(as_custom1 ) and  as_custom1 <> '' Then
	ls_where += " And  custom_1 = '"	 +  as_custom1 + "'"
End If

If Not isnull(adb_customn1 ) and  adb_customn1 <> 0 Then
	ls_where += ' And custom_n1 = '	 + String(adb_customn1)
End If

If  Len( ls_where ) > 0 Then
	ls_sql = "select distinct ctx_id from ( " + &
				"select ctx_contract_contacts.ctx_id,"+ &
				"ctx_contract_contacts.association,   "+ &
				"'name' = ctx_contacts.last_name + ','  + ctx_contacts.first_name + ', '+ isnull(ctx_contacts.middle_name,'')  , "+ &
				"ctx_contract_contacts.custom_n1, "+ &
				"ctx_contract_contacts.custom_1, "+ &
				"'contact_email' = email.contact_email, " + &
				"ctx_contract_contacts.ic_area " + &
				"FROM  ctx_contract_contacts inner join ctx_contacts "+ &
				"on ctx_contract_contacts.contact_id = ctx_contacts.contact_id "+ &
				"  inner join app_facility on ctx_contacts.facility_id = app_facility.facility_id "+ &
				"  left join ( select max(A.contact_email)contact_email , a.contact_id "+ &
				"from ctx_contacts_numbers A  "+ &
				"where  a.via = (select top 1 lookup_code from code_lookup where "+ &
				"        lookup_name = 'Contract Contact Via' and code = 'Email' ) "+ &
				"        group by a.contact_id   ) email "+ &
				" on  ctx_contract_contacts.contact_id  = email.contact_id     ) others"	
	If as_Class = 'E' Then
		ls_SQL = 'select tableB.ctx_id from ( ' + ls_SQL + " where (1=1 " + ls_where + "  and ic_area = '" + as_class + "') )tableB "
		If Len( as_sql ) > 0 Then
			If Pos( as_sql, ')tableA' ) > 0 Then
				ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableB on tableA.ctx_id=tableB.ctx_id"
			End If
		End If
	Else
		ls_SQL = 'select tableC.ctx_id from ( ' + ls_SQL + " where (1=1 " + ls_where + "  and ic_area = '" + as_class + "') )tableC "
		If Len( as_sql ) > 0 Then
			If Pos( as_sql, ')tableB' ) > 0 Then
				ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableC on tableB.ctx_id=tableC.ctx_id"
			ElseIf Pos( as_sql, ')tableA' ) > 0 Then
				ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableC on tableA.ctx_id=tableC.ctx_id"
			End If
		End If		
	End If
	ib_FilterValue = True
End If

ls_where = ""
If Not isnull(as_contact ) and  as_contact <> '' Then
	ls_where += " And  app_facility.contact like '%"	 +  as_contact + "%'"
End If

If Len( ls_where ) > 0  Then
	ls_sql = " select distinct ctx_id  from ctx_basic_info " + &
			"	inner join app_facility on ctx_basic_info.app_facility = app_facility.facility_id "
	ls_Sql = ls_Sql +  " where 1=1 " + ls_where
	If Len( as_sql ) > 0 Then
		If Pos( as_sql, ')tableC' ) > 0 Then
			ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableD on tableC.ctx_id=tableD.ctx_id"
		ElseIf Pos( as_sql, ')tableB' ) > 0 Then
			ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableD on tableB.ctx_id=tableD.ctx_id"
		ElseIf Pos( as_sql, ')tableA' ) > 0 Then
			ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableD on tableA.ctx_id=tableD.ctx_id"
		End If
	End If
	ib_FilterValue = True
End If
If IsNull( ls_sql ) Or Trim( ls_sql ) = '' Then ls_sql = as_sql
Return ls_sql	
end function

public function long of_move_ctx_to_browsedw (long al_ctx_id);//====================================================================
// Function: of_move_ctx_to_browsedw
//--------------------------------------------------------------------
// Description: Copy Contract to Browse Screen
//--------------------------------------------------------------------
// Arguments:
//                al_ctx_id
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 04/28/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_Find


ll_Find = dw_search_det1.Find('ctx_id = ' + String(al_ctx_id), 1, dw_search_det1.RowCount()) 
If ll_Find > 0 Then 
	Return ll_Find
End If

ll_Find = ids_search.Find('ctx_id = ' + String(al_ctx_id), 1, ids_search.RowCount()) 
If ll_Find <= 0 Then 
	Return 0
End If

If ids_search.RowsCopy( ll_Find,ll_Find,Primary!,dw_search_det1,dw_search_det1.RowCount() + 1,Primary!) = 1 Then
	dw_search_det1.Title = 'Contract Browse (' + string(dw_search_det1.RowCount()) + ')'
	Return dw_search_det1.RowCount()
Else
	Return -1
End If

end function

public function string of_build_contact_filter (datastore ads_value, string as_sql);//====================================================================
// Function: of_build_contact_filter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ads_value
// 	as_sql
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-06-06
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String			ls_Sql, ls_where = ""
Integer		li_Pos, li_Pos2
Long			ll_Num
String			ls_ColType, ls_ColName, ls_Value
double		ldb_value
Datetime		ldt_value

ls_where = ""
For ll_Num = 1 to ads_value.RowCount( )
	ls_ColType =  ads_value.GetItemString( ll_Num, 'types' )
	ls_ColName =  ads_value.GetItemString( ll_Num, 'field' )
	
	ls_Value =  ads_value.GetItemString( ll_Num, 'value' )
	
	Choose Case Lower(Left ( ls_ColType , 3 ))
		CASE 'int','lon','dec','num','dou','rea','ulo', 'mon'
			ldb_value = double( ls_value )
			If Not isnull(ldb_value ) and  ldb_value <> 0 Then
				ls_where += ' And ' + Mid(ls_ColName, 10) + ' = '	 + String(ldb_value)
			End If
		Case 'dat'
			If Not (isnull(ls_Value )  Or ls_Value = '' ) Then
				ls_where += ' And ' + Mid(ls_ColName, 10) + " = '"	 + String(ls_Value) + "'"
			End If
		CASE 'var','cha'	//text maybe use patindex 
			If Not isnull(ls_Value ) and  ls_Value <> '' Then
				ls_where += ' And ' + Mid(ls_ColName, 10) + " like '%"	 +  ls_Value + "%'"
			End If
	End Choose	
Next

If Len( ls_where ) > 0  Then
	ls_sql = " select distinct ctx_id   FROM ctx_fee_sched_nm "
	ls_Sql = ls_Sql +  " where 1=1 " + ls_where
	If Len( as_sql ) > 0 Then
		If Pos( as_sql, ')tableD' ) > 0 Then
			ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableE on tableD.ctx_id=tableE.ctx_id"		
		ElseIf Pos( as_sql, ')tableC' ) > 0 Then
			ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableE on tableC.ctx_id=tableE.ctx_id"
		ElseIf Pos( as_sql, ')tableB' ) > 0 Then
			ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableE on tableB.ctx_id=tableE.ctx_id"
		ElseIf Pos( as_sql, ')tableA' ) > 0 Then
			ls_SQL =  as_sql + " inner join ( " + ls_sql + " )tableE on tableA.ctx_id=tableE.ctx_id"
		End If
	End If
	ib_FilterValue = True
End If
If IsNull( ls_sql ) Or Trim( ls_sql ) = '' Then ls_sql = as_sql
Return ls_sql	
end function

public subroutine of_powerfilter (string as_value);//Added By Ken.Guo 10/30/2012. Support PowerFilter
String ls_originalfilter

If isvalid(iu_PowerFilter) Then
	If as_value = '1' Then
		iu_PowerFilter.checked = True
	Else
		iu_PowerFilter.checked = False
	End If
//	iu_PowerFilter.checked = Not iu_PowerFilter.checked
	iu_PowerFilter.of_SetDW(dw_search_det1)
	iu_PowerFilter.event ue_clicked()
	
	If Not iu_PowerFilter.checked Then
			//Copy from dw_search.buttonclicked() event. because APB do not support pass dwo object as an argument in the event.
			//dw_search.event buttonclicked(1, 0, dw_search.object.b_search)
			ib_force_retrieve = False
			cb_3.event clicked()
			ib_force_retrieve = True
			if IsValid(w_SearchPage_Calendar) then w_SearchPage_Calendar.of_RefreshCondition()
			if IsValid(w_todolist_contract) then w_todolist_contract.of_RefreshData()							//Added By Mark Lee 12/25/2012						
			if IsValid(w_tabpg_contract_doc_mgr) then w_tabpg_contract_doc_mgr.of_RefreshData()
	End If
	//Need save the value to DB here.
End If


end subroutine

public subroutine of_set_styles (boolean abn_retrieve);//====================================================================
// Function: of_set_styles
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/25/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 	ls_browse_screen_results_style,	ls_search_criteria, ls_display_contract_parent_child_tree, ls_display_document_preview
String 	ls_powerfilter,	ls_pos, ls_to_do_list
long 		ll_height, ll_width

//Added By Mark Lee 11/29/2012
is_position_setting = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting" )

is_position_setting_other  = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting_ToDoList" )

// somewhere usefull
If Not isvalid(inv_ctx_tv) Then
	inv_ctx_tv = Create n_cst_ctx_tv
	inv_ctx_tv.event ue_retrieve( )		
End If	

//Added By Mark Lee 11/28/2012				
//ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_hbar.y" )
//If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
//	st_hbar.y =  Dec(ls_pos)  *  this.height
//End If

//Begin - Added By Mark Lee 04/08/2013 move it
//ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_vbar2.x")
//If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
//	st_vbar2.x =  Dec(ls_pos)  *  this.width
//End If
//
//ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_vbar.x")
//If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
//	st_vbar.x =  Dec(ls_pos)  *  this.width
//End If
//	
//ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_hbar2.y" )
//is_hbar2 = ls_pos
//If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
//	st_hbar2.y =  Dec(ls_pos)  *  this.height
//Else
//	st_hbar2.y = dw_search_det1.y + integer(dw_search_det1.height / 2) + 10
//End If
//End - Added By Mark Lee 04/08/2013

//Contract Parent Child Tree	
ls_display_contract_parent_child_tree = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree" ) 

//Display Document Preview
ls_display_document_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview" )

//The To Do List
ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )	
			
//reset size
If ((not isnull(ls_display_contract_parent_child_tree) and ls_display_contract_parent_child_tree = '1' ) Or (not isnull(ls_to_do_list) and ls_to_do_list = '1' ))&
	and not isnull(ls_display_document_preview) and ls_display_document_preview = '1' &
	and st_vbar.x <= st_vbar2.x + 600 THen
	st_vbar2.x  = Integer( this.width / 3)
	st_vbar.x  = Integer( this.width * 2 / 3 )
End If 
			
//set default style
dw_search_det1.width =	dw_search.width 	
dw_search_det1.x =  dw_search.x		
st_vbar.visible = False
st_vbar2.visible = False
ib_tree_view = False
tv_ctx.visible = False
st_hbar2.visible = False
st_hbar.height = ii_border
st_hbar2.height = ii_border
st_vbar.width = ii_border
st_vbar2.width = ii_border

//Begin - Added By Mark Lee 12/17/2012 	For Batch Import Document  Queue Window (w_bidq_import_document)
If not isvalid(iw_parent) Then 
	of_GetParentWindow(iw_parent)
End If

If iw_parent.classname( ) <> 'w_contract'  then 
	st_hbar.visible 		= False
	Return 
End If
//End - Added By Mark Lee 12/17/2012

If w_Mdi.of_security_access(6978) = 0 Then
	//return
	If dw_search_det1.visible = True and dw_search.visible = True and ib_tree_view = False and not isvalid(w_searchpage_calendar)  and not isvalid(w_tabpg_contract_doc_mgr) then 
		Return 
	End If

	//set default style
	dw_search_det1.visible = True
	dw_search.visible = True

	//Calendar
	If isvalid(w_searchpage_calendar) Then
		Close(w_searchpage_calendar)
	End If
	//Document Preview
	If isvalid(w_tabpg_contract_doc_mgr) Then
		Close(w_tabpg_contract_doc_mgr)
	End If	
Else
	
	// if this value is null , we will use the old function(of_set_style()). so it is don't adjudge this case.
	ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )
	If w_Mdi.of_security_access(6957) = 0 and ls_browse_screen_results_style = '0' Then 
		ls_browse_screen_results_style = '1' 
	End If
	
	If ls_browse_screen_results_style = '1' then 
			If isvalid(w_SearchPage_Calendar) Then 
				Close(w_SearchPage_Calendar)
			End IF
			dw_search_det1.visible = True
			
			//search criteria 
			ls_search_criteria = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_Criteria" )
			If  isnull(ls_search_criteria) or ls_search_criteria = '1' Then 
				ls_search_criteria = '1'
				dw_search.visible = True
				st_hbar.visible 		= True
				dw_search_det1.y	= st_hbar.y + st_hbar.height 
				dw_search_det1.height = this.height - dw_search_det1.y			//Added By Mark Lee 02/04/2013
			Else
				dw_search.visible = False
				st_hbar.visible	    = False
				ll_height	=	dw_search_det1.y + dw_search_det1.height
				dw_search_det1.y	= dw_search.y
				dw_search_det1.height = ll_height  - dw_search.y
				dw_search_det1.height = this.height - dw_search_det1.y			//Added By Mark Lee 02/04/2013
			End If
				
			//Contract Parent Child Tree
//			ls_display_contract_parent_child_tree = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree" ) 
			If ls_display_contract_parent_child_tree = '1' Then				
				ib_tree_view = True
				tv_ctx.visible = True
				tv_ctx.y = dw_search_det1.y
				
				If not isnull(ls_to_do_list) and ls_to_do_list = '1' then 
//					tv_ctx.height = dw_search_det1.y - st_hbar2.y - 10			//Added By Mark Lee 04/08/2013
					tv_ctx.height = dw_search_det1.y - st_hbar2.y 
				Else
					tv_ctx.height = dw_search_det1.height			
				End If
				
				Choose Case inv_ctx_tv.ii_hidebrowse
					Case 0			//display contract brower Dw
						dw_search_det1.visible = True
//						tv_ctx.x = st_vbar.x + st_vbar.width + 5															//Added By Mark Lee 11/28/2012
						If isnull(is_position_setting) or trim(is_position_setting) = '' or is_position_setting = '1' Then 			//right
							st_vbar.visible = True	
//							tv_ctx.x = st_vbar.x + st_vbar.width 		//Added By Mark Lee 04/12/2013 bug
							If tv_ctx.x <= st_vbar.x + st_vbar.width or  tv_ctx.x > st_vbar.x + st_vbar.width + ii_border  then
								tv_ctx.x = st_vbar.x + st_vbar.width
							End If
							tv_ctx.width = dw_search.x + dw_search.width - tv_ctx.x 
							dw_search_det1.x = dw_search.x
							dw_search_det1.width = st_vbar.x  -	 dw_search.x  
						Else
							st_vbar2.visible = True	
							tv_ctx.x = dw_search.x
//							tv_ctx.width	= st_vbar2.x - dw_search.x 	- 10		//Added By Mark Lee 04/07/2013
							tv_ctx.width	= st_vbar2.x - dw_search.x 	
							dw_search_det1.x = st_vbar2.x + st_vbar2.width		
							dw_search_det1.width = dw_search.x + dw_search.width - dw_search_det1.x 
						End If
					Case 1	
						//hide Document Preview
						If isvalid(w_tabpg_contract_doc_mgr) Then
							Close(w_tabpg_contract_doc_mgr)
						End If	
						
						//hide the To Do List window
						If isvalid(w_todolist_contract) Then
							Close(w_todolist_contract)
						End If	
						
						dw_search_det1.visible = False
						tv_ctx.x = dw_search.x
						tv_ctx.width = dw_search.width		
				End Choose
				ii_hidebrowse = inv_ctx_tv.ii_hidebrowse
			End If 
			
			//display  The To Do List Window
//			ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )	
			If 	not isnull(ls_to_do_list) and ls_to_do_list = '1' Then 				
				If dw_search_det1.visible = False  Then				
					If isvalid(w_todolist_contract) Then
						Close(w_todolist_contract)
					End If	
				Else
					If is_position_setting_other = '1' Then 
						st_vbar2.visible = True
					Else
						st_vbar.visible = True
					End IF
					
					If ls_display_contract_parent_child_tree = '1' and is_position_setting = '1' and is_position_setting_other = '0' Then		
						st_hbar2.visible = True
					ElseIf ls_display_contract_parent_child_tree = '1' and is_position_setting = '0' and is_position_setting_other = '1' Then		
						st_hbar2.visible = True						
					End If
					
					If not isvalid(w_todolist_contract) Then
						If isvalid(gw_contract) Then 
							Open(w_todolist_contract,gw_contract)
						Else
							Open(w_todolist_contract,w_contract)
						End If
						If isvalid(w_todolist_contract) Then
							w_todolist_contract.Resizable = False
							
							//Added By Ken.Guo 04/10/2013. fixed bug. it display incorrect bk color when user changed the style.
							w_todolist_contract.uo_todolist.of_set_bg_color(Long(dw_search_det1.describe("Datawindow.color"))) 
							w_todolist_contract.backcolor = 	Long(dw_search_det1.describe("Datawindow.color"))							
						End If
					Else
						w_todolist_contract.show()
						// It is a adjust of the position for the window w_todolist_contract
						w_todolist_contract.of_adjustsize()
					End If
				End If
			Else
				If isvalid(w_todolist_contract) Then
					Close(w_todolist_contract)
				End If	
			End If
			
//			//Display Document Preview
//			ls_display_document_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview" )
			If ls_display_document_preview = '1' Then 
				If dw_search_det1.visible = False  Then
					//Document Preview
					If isvalid(w_tabpg_contract_doc_mgr) Then
						Close(w_tabpg_contract_doc_mgr)
					End If	
				Else
					If isnull(is_position_setting) or trim(is_position_setting) = '' or is_position_setting = '1' Then 
						st_vbar2.visible = True	
					Else
						st_vbar.visible = True
					End If
					
					If not isvalid(w_tabpg_contract_doc_mgr) Then
						If isvalid(gw_contract) Then 
							Open(w_tabpg_contract_doc_mgr,gw_contract)
						Else
							Open(w_tabpg_contract_doc_mgr,w_contract)
						End If
						If isvalid(w_tabpg_contract_doc_mgr) Then
							w_tabpg_contract_doc_mgr.Resizable = False	
						End If
					Else
						w_tabpg_contract_doc_mgr.show()
						// It is a adjust of the position for the window w_tabpg_contract_doc_mgr.
						w_tabpg_contract_doc_mgr.of_adjustsize()
					End If
				End If 
			Else
				//hide Document Preview
				If isvalid(w_tabpg_contract_doc_mgr) Then
					Close(w_tabpg_contract_doc_mgr)
				End If	
			End If
			
	Else
		dw_search_det1.visible = False

		//Document Preview
		If isvalid(w_tabpg_contract_doc_mgr) Then
			Close(w_tabpg_contract_doc_mgr)
		End If	
	
		//hide the To Do List window
		If isvalid(w_todolist_contract) Then
			Close(w_todolist_contract)
		End If	
		
		If IsValid(w_SearchPage_Calendar) then
			//Close(w_SearchPage_Calendar) 
		Else
			If isvalid(gw_contract) Then 
				Open(w_SearchPage_Calendar,gw_contract)
			Else
				Open(w_SearchPage_Calendar, w_contract)
			End If
			If isvalid(w_SearchPage_Calendar) Then
				w_SearchPage_Calendar.Resizable = False	
			End If
		End if
	End if

End If

//register  the object 
of_register_object('all')

//Added By Ken.Guo 04/09/2013
If tv_ctx.visible Then
	This.of_tv_set_font( )
End If

//Retrieve Data
If abn_retrieve = True Then
	If isvalid(ids_search) and ib_retrieve Then
		IF  ls_browse_screen_results_style = '1'  Then
				this.of_filter()
		End If
	End If
End If
//Added By Ken.Guo 11/01/2012 Set PowerFilter 
If dw_search_det1.visible Then
	ls_powerfilter =  gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_PowerFilter" ) 
	If isvalid(iu_PowerFilter) Then
		If	(iu_PowerFilter.Checked and ls_powerfilter = '1') or &
			(Not iu_PowerFilter.Checked and ls_powerfilter = '0')	Then
			//do nothing it if equal
		Else
			This.of_powerfilter(ls_powerfilter)
		End If
	End If
End If


end subroutine

public subroutine of_create_templates_list ();//====================================================================
// Function: of_create_templates_list
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/16/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

If not IsValid(ids_templates_list) Then 
	ids_templates_list = Create Datastore
	ids_templates_list.dataobject = 'd_use_templates_list'
	ids_templates_list.settransobject( sqlca)
	ids_templates_list.retrieve( )
	
Else
	//refresh	
	ids_templates_list.reset( )
	ids_templates_list.retrieve( )
End If
end subroutine

public subroutine of_create_menu_item ();//====================================================================
// Function: of_create_menu_item
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/21/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 			ll_rowcount, i , ll_id, ll_tmp, ll_bound, ll_difference, j , k 
String 		ls_tempaltes_name, ls_item[]
menu 		lm_create[], lm_delete[]
Long 			ll_find,ll_find_item, ll_cnt
Boolean		lbn_template

If IsValid(m_pfe_cst_mdi_menu_contract) Then 

	of_create_templates_list()
	lbn_template = m_pfe_cst_mdi_menu_contract.m_contract0.m_contract_templates.enabled
	ll_rowcount  = ids_templates_list.rowcount()
	ll_bound =  upperbound(m_pfe_cst_mdi_menu_contract.m_contract0.item[])
	If ll_rowcount > 0  Then 
		If ll_bound >= 9 Then
			For i = 9 to ll_bound step 1 
				m_pfe_cst_mdi_menu_contract.m_contract0.item[i].visible = False
			Next
		End If
		
		//create the item
		For i = 1 to ll_rowcount
			lm_create[i] = Create  m_menu_create_item_child
			ls_tempaltes_name = ids_templates_list.GetItemString(i,'template_name')		
			If Isnull(ls_tempaltes_name) Then 
				ls_tempaltes_name = ''
			End If 
			ll_id 		= ids_templates_list.GetItemNumber(i,'id')		
			ll_tmp = ll_bound + i 
			lm_create[i].text = ls_tempaltes_name
			lm_create[i].tag = string(ll_id)
			lm_create[i].visible = True
			m_pfe_cst_mdi_menu_contract.m_contract0.item[ll_tmp]= lm_create[i]
//			m_pfe_cst_mdi_menu_contract.m_contract0.item[ll_tmp].text = ls_tempaltes_name
			m_pfe_cst_mdi_menu_contract.m_contract0.item[ll_tmp].tag = string(ll_id)
			m_pfe_cst_mdi_menu_contract.m_contract0.item[ll_tmp].visible =True
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.item[ll_tmp],'enabled', lbn_template)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.item[ll_tmp],'toolbaritemOrder', ll_tmp)				
		Next 		
				
		m_pfe_cst_mdi_menu_contract.m_contract0.hide()
		m_pfe_cst_mdi_menu_contract.m_contract0.show()
	Else
		//clear the delete module item
		If ll_bound >= 9 then 
			For i = 9 to ll_bound step 1 
				m_pfe_cst_mdi_menu_contract.m_contract0.item[i].visible = False
			Next
//			m_pfe_cst_mdi_menu_contract.m_contract0.hide()
//			m_pfe_cst_mdi_menu_contract.m_contract0.show()
		End If
			m_pfe_cst_mdi_menu_contract.m_contract0.hide()				//Added By Mark Lee 12/17/2012
			m_pfe_cst_mdi_menu_contract.m_contract0.show()
	End If
End If

end subroutine

public subroutine of_register_object (string as_type);//====================================================================
// Function: of_register_object
//--------------------------------------------------------------------
// Description:
////-- Define the "Register" type. --
//constant integer LEFT=1
//constant integer RIGHT=2
//constant integer ABOVE=3
//constant integer BELOW=4
//--------------------------------------------------------------------
// Arguments:
//                as_type
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/28/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 	ls_display_contract_parent_child_tree,	ls_display_document_preview,	ls_to_do_list

If isnull(as_type) or trim(as_type) = '' Then 
	Return 
End If

//Contract Parent Child Tree	
ls_display_contract_parent_child_tree = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree" ) 
//Display Document Preview
ls_display_document_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview" )
//The To Do List
ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )


Choose Case as_type
	Case 'all'
		If isvalid(inv_resize) Then 
			this.inv_resize.of_unregister(dw_search_det1)
			this.inv_resize.of_unregister( gb_document_view)
			this.inv_resize.of_unregister( tv_ctx)
			this.inv_resize.of_unregister( gb_to_do_list)					
			this.inv_resize.of_unregister( st_hbar2)						
			
			st_hbar.of_register( dw_search, 3)
			st_hbar.of_register( dw_search_det1, 4)
//			st_hbar.of_register( st_hbar2, 4)								
			
			st_vbar.of_Register(dw_search_det1, 1)
			st_vbar2.of_Register(dw_search_det1, 2)
			
			If  isnull(is_position_setting) Or trim(is_position_setting) = '' or  is_position_setting = '1'   Then 
				If not isnull(ls_display_document_preview) and ls_display_document_preview = '1' then
					st_vbar2.of_Register(gb_document_view, 1)					
				End If				
				If not isnull(ls_display_contract_parent_child_tree) and ls_display_contract_parent_child_tree = '1' then
					st_vbar.of_Register(tv_ctx, 2)	
					st_hbar.of_register( tv_ctx, 4)							
				End If
			Else
				If not isnull(ls_display_document_preview) and ls_display_document_preview = '1' then
					st_vbar.of_Register(gb_document_view, 2)
				End If
				If not isnull(ls_display_contract_parent_child_tree) and ls_display_contract_parent_child_tree = '1' then
					st_vbar2.of_Register(tv_ctx, 1)
					st_hbar.of_register( tv_ctx, 4)							
				End If
			End If
			
			If is_position_setting_other	= '1' and not isnull(ls_to_do_list) and ls_to_do_list = '1' Then
				st_vbar2.of_Register(gb_to_do_list, 1)
				If st_hbar2.visible = True then 
					st_vbar2.of_Register(st_hbar2, 1)		
				End IF
			ElseIf is_position_setting_other	= '0' and not isnull(ls_to_do_list) and ls_to_do_list = '1' Then
				st_vbar.of_Register(gb_to_do_list, 2)
				If st_hbar2.visible = True then  
					st_vbar.of_Register(st_hbar2, 2)						
				End If
			End If

			If st_hbar2.visible = True Then
				st_hbar2.of_Register(tv_ctx, 3)
				st_hbar2.of_Register(gb_to_do_list, 4)
				this.inv_resize.of_Register( st_hbar2, inv_resize.scale)		
			End If
			this.inv_resize.of_Register( gb_to_do_list, inv_resize.scale)				

			this.inv_resize.of_Register(dw_search_det1, inv_resize.scale)
			this.inv_resize.of_Register( gb_document_view, inv_resize.scale)
			this.inv_resize.of_Register( tv_ctx, inv_resize.scale)
		End If
		
	Case Else
	
End Choose
end subroutine

public subroutine of_refresh_menu_status ();//====================================================================
// Function: of_refresh_menu_status
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/18/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
IF isvalid(m_pfe_cst_mdi_menu_contract) Then 
	If m_pfe_cst_mdi_menu_contract.m_contract0.visible = True and dw_search_det1.GetSelectedRow(0) > 0  Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_sub_contract_record,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record,'enabled', True)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_sub_contract_record,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record,'enabled', False)
	End If
End If
end subroutine

public subroutine of_create_downarraw ();//====================================================================
// Function: of_create_downarraw
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/20/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
integer i 
String 	ls_visible, ls_name, ls_modify, ls_err
Long 	ll_x, ll_y, ll_width, ll_height

ls_modify =''
For i = 1 to 3
	
	ls_name = 'b_quick_filter'+string(i)
	ls_visible = dw_search.describe( ls_name+".visible")
	ll_x = Long(dw_search.describe( ls_name+".x"))
	ll_y = long(dw_search.describe( ls_name+".y"))
	ll_width = long(dw_search.describe( ls_name+".width"))		 
	ll_height = long(dw_search.describe( ls_name+".height"))		 
	
	ll_x = ll_x + ll_width - 4
//	ll_y = ll_y + ll_height
	ls_modify += &
	 " create button(band=detail text='▼' enabled=yes action='0' border='0' color='0' " + &
	" x='" +string(ll_x)+ "' " +  &
	" y='" +string(ll_y)+ "' "  +  &
	" height='" +string(ll_height)+ "' width='" +string(80)+ "' "  +  &
	" vtextalign='0' htextalign='0' "+ &
	" name=" + "b_downarraw" + string(ls_name) +&
	" visible='"+ ls_visible + "'"  + &
	" font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' " + &
	" background.mode='2' background.color='67108864' " +  &
	" )"
//	" background.transparency='0' background.gradient.color='8421504' " + &
//	" background.gradient.transparency='0' background.gradient.angle='0' background.brushmode='0' background.gradient.repetition.mode='0' "+  &
//	" background.gradient.repetition.count='0' background.gradient.repetition.length='100' background.gradient.focus='0' background.gradient.scale='100' " +&
//	" background.gradient.spread='100'  " + &	
//	" tooltip.backcolor='134217752' tooltip.delay.initial='0' tooltip.delay.visible='32000' tooltip.enabled='0' " + &
//	" tooltip.hasclosebutton='0' tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )

Next

ls_err = dw_search.modify(ls_modify)
//	ls_err =  dw_search.modify( " Destroy  b_save_filter ")
end subroutine

public subroutine of_popmenu (string as_filter);String 	ls_contract_search_filter_set_as_default
m_contract_search_filter lm_filter
window 		lw_win

setnull(lw_win)

lm_filter = Create m_contract_search_filter
lm_filter.iw_Parent = lw_win		//Added By Mark Lee 12/20/2012

lm_filter.m_ViewFilter.Tag   = as_filter
lm_filter.m_AssignFilter.Tag = as_filter
lm_filter.m_RenameFilter.Tag = as_filter
lm_filter.m_set_as_default.tag = as_filter

ls_contract_search_filter_set_as_default = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default" )
If not isnull(ls_contract_search_filter_set_as_default) and Trim(ls_contract_search_filter_set_as_default) <> '' Then 
	IF ls_contract_search_filter_set_as_default = as_filter  Then 
		gnv_app.of_modify_menu_attr( lm_filter.m_set_as_default,'checked', True) 
	Else
		gnv_app.of_modify_menu_attr( lm_filter.m_set_as_default,'checked', False)
	End IF
Else
	gnv_app.of_modify_menu_attr( lm_filter.m_set_as_default,'checked', False)
End If

lm_filter.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())

Destroy lm_filter
end subroutine

public subroutine of_refresh_filtername ();//====================================================================
// Function: of_refresh_filtername
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/03/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 	ls_name,		ls_contract_search_filter_set_as_default
n_cst_string		ln_cst_string

ls_contract_search_filter_set_as_default = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default" )
If isvalid(dw_search.object.b_quick_filter1) Then 
	ls_name =  gnv_user_option.of_Get_option_value( gs_user_id,"Contract_Seacrh_FilterName_1" )
	ls_name =	ln_cst_string.of_GlobalReplace(ls_name,'(D)','')
	If  isnull(ls_name) OR trim(ls_name) = '' Then 
		//ls_name = "Quick Filter1"
		ls_name = "Quick Filter 1"//(Appeon)Harry 09.03.2014 - for Testing v14.2 UI Issues
	End If
	If not isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '1' Then 
		dw_search.modify("b_quick_filter1.text = '"+ls_name+"(D)' ")
	Else
		dw_search.modify("b_quick_filter1.text = '"+ls_name+"' ")
	End If
End If

If isvalid(dw_search.object.b_quick_filter2) Then 
	ls_name =  gnv_user_option.of_Get_option_value( gs_user_id,"Contract_Seacrh_FilterName_2" )
	ls_name =	ln_cst_string.of_GlobalReplace(ls_name,'(D)','')
	If  isnull(ls_name) OR trim(ls_name) = '' Then 
		//ls_name = "Quick Filter2"
		ls_name = "Quick Filter 2"//(Appeon)Harry 09.03.2014 - for Testing v14.2 UI Issues
	End If

	If not isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '2' Then 
		dw_search.modify("b_quick_filter2.text = '"+ls_name+"(D)' ")
	Else
		dw_search.modify("b_quick_filter2.text = '"+ls_name+"' ")
	End If
End If

If isvalid(dw_search.object.b_quick_filter3) Then 
	ls_name =  gnv_user_option.of_Get_option_value( gs_user_id,"Contract_Seacrh_FilterName_3" )
	ls_name =	ln_cst_string.of_GlobalReplace(ls_name,'(D)','')	
	If  isnull(ls_name) OR trim(ls_name) = '' Then 
		//ls_name = "Quick Filter3"
		ls_name = "Quick Filter 3" //(Appeon)Harry 09.03.2014 - for Testing v14.2 UI Issues
	End If	
	If not isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '3' Then 
		dw_search.modify("b_quick_filter3.text = '"+ls_name+"(D)' ")
	Else
		dw_search.modify("b_quick_filter3.text = '"+ls_name+"' ")
	End If	
End If

end subroutine

public subroutine of_set_default_bar_position ();String 	ls_pos


ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_vbar2.x")
gnv_string.of_convert_numeric_for_language( ls_pos)					//Added By Mark Lee 05/09/2013
If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
	st_vbar2.x =  Dec(ls_pos)  *  this.width
End If

ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_vbar.x")
gnv_string.of_convert_numeric_for_language( ls_pos)					//Added By Mark Lee 05/09/2013
If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
	st_vbar.x =  Dec(ls_pos)  *  this.width
End If
	
ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_hbar2.y" )
gnv_string.of_convert_numeric_for_language( ls_pos)					//Added By Mark Lee 05/09/2013
is_hbar2 = ls_pos
If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
	st_hbar2.y =  Dec(ls_pos)  *  this.height
Else
	st_hbar2.y = dw_search_det1.y + integer(dw_search_det1.height / 2) + 10
End If
end subroutine

public function integer of_tv_set_font ();//Added By Ken.Guo 04/09/2013. Support Font
If Not isvalid(inv_ctx_tv) Then Return -1

tv_ctx.facename = inv_ctx_tv.is_font
tv_ctx.textsize  = 0 - inv_ctx_tv.il_font_size   // it shoule be negative.
tv_ctx.textcolor  = inv_ctx_tv.il_font_text_color
If inv_ctx_tv.il_font_italy = 1 Then
	tv_ctx.italic  = True
Else
	tv_ctx.italic  = False
End If
If inv_ctx_tv.il_font_underline = 1 Then
	tv_ctx.underline  = True
Else
	tv_ctx.underline  = False
End If
If inv_ctx_tv.il_font_bold = 1 Then
	tv_ctx.weight  = 700
Else
	tv_ctx.weight  = 400
End If

Return 1
end function

on u_tabpg_contract_search.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_print=create cb_print
this.dw_search=create dw_search
this.dw_search_det1=create dw_search_det1
this.cbx_1=create cbx_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.st_vbar2=create st_vbar2
this.st_hbar=create st_hbar
this.gb_document_view=create gb_document_view
this.tv_ctx=create tv_ctx
this.gb_to_do_list=create gb_to_do_list
this.st_vbar=create st_vbar
this.st_hbar2=create st_hbar2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.dw_search
this.Control[iCurrent+6]=this.dw_search_det1
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.cb_5
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.st_vbar2
this.Control[iCurrent+11]=this.st_hbar
this.Control[iCurrent+12]=this.gb_document_view
this.Control[iCurrent+13]=this.tv_ctx
this.Control[iCurrent+14]=this.gb_to_do_list
this.Control[iCurrent+15]=this.st_vbar
this.Control[iCurrent+16]=this.st_hbar2
end on

on u_tabpg_contract_search.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_print)
destroy(this.dw_search)
destroy(this.dw_search_det1)
destroy(this.cbx_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.st_vbar2)
destroy(this.st_hbar)
destroy(this.gb_document_view)
destroy(this.tv_ctx)
destroy(this.gb_to_do_list)
destroy(this.st_vbar)
destroy(this.st_hbar2)
end on

event constructor;call super::constructor;long	ll_Right
String 	ls_browse_screen_results_style	//Added By Mark Lee 10/26/12

gl_SearchTab_View_id = long(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + Upper(gs_user_id) + "'"))
if IsNull(gl_SearchTab_View_id) or gl_SearchTab_View_id = 0 then gl_SearchTab_View_id = 1001

//BEGIN---Modify by Scofield on 2009-06-24
if Not IsValid(ids_search) then
	ids_search = Create DataStore
	ids_search.DataObject = 'd_sp_contract_search'
	ids_search.SetTransObject( sqlca)
end if

if Not IsValid(ids_search_temp) then
	ids_search_temp = Create DataStore
	ids_search_temp.DataObject = 'd_sp_contract_search'
end if
//END---Modify by Scofield on 2009-06-24

if Not IsValid(ids_search_temp_child) then
	ids_search_temp_child = Create DataStore
	ids_search_temp_child.DataObject = 'd_sp_contract_search'
end if

//Added By Ken.Guo 2011-01-31.
if Not IsValid(ids_search_related_ctx) then
	ids_search_related_ctx = Create DataStore
	ids_search_related_ctx.DataObject = 'd_sp_contract_search'
end if

if Not IsValid(ids_dddw_columns) then
	ids_dddw_columns = Create DataStore
	ids_dddw_columns.DataObject = 'd_dddw_displayname_ctx'
end if

if not gb_use_opmode or iw_parent.classname() <> 'w_contract'  then of_create_dw() // jervis 10.11.2011
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 02.12.2009 By: Ken.Guo
//$<reason> Retrieve view data for user for ctx.
ids_ctx_group_user_view = create n_ds
ids_ctx_group_user_view.dataobject = 'd_ctx_group_user_view_pt'
ids_ctx_group_user_view.settransobject(sqlca)
//---------------------------- APPEON END ----------------------------

//----------Begin Added by Alfee 09.30.2007 --------------------------
ids_contract_access_category = create n_ds
ids_contract_access_category.dataobject = 'ds_contract_access_category'
ids_contract_access_category.settransobject(sqlca)
//----------End Added ------------------------------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-13 By: Scofield
//$<Reason> Add the right to turn off the more button.
ll_Right = w_mdi.of_security_access(2081)
if ll_Right = 0 then
	dw_search.Object.b_more.Visible = false
	//dw_search.Object.b_clear.X = Long(dw_search.Object.owner.X) + Long(dw_search.Object.owner.Width) - Long(dw_search.Object.b_clear.Width)
	dw_Search.Object.b_clear.x = dw_Search.Object.b_search.x
	dw_Search.Object.b_search.x = dw_Search.Object.b_more.x
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//Added By Alan on 2009-1-14
int	li_autoret

if AppeonGetClientType() = 'WEB' and gl_MoveToCtxID > 0 and gs_MoveToTabNo <> "" then
	ib_autoretrieve = true
else
	select isnull(set_autoret,1) into :li_autoret from security_users where user_id = :gs_user_id;
	if li_autoret = 1 then
		ib_autoretrieve = true
		cbx_1.checked = true
	else
		ib_autoretrieve = false
		cbx_1.checked = false
	end if
end if
//---------------------------- APPEON END ----------------------------


//Added By Ken.Guo 2009-10-28.
If Not Isvalid(ids_ctx_tv_map) Then
	ids_ctx_tv_map = Create Datastore
	ids_ctx_tv_map.dataobject = 'd_ctx_tv_map'
End If

If Not isvalid(ids_group_tv_map) Then
	ids_group_tv_map = Create Datastore
	ids_group_tv_map.dataobject = 'd_group_tv_map'
End If

//Begin - Added By Mark Lee 10/26/12
of_set_default_bar_position()					//Added By Mark Lee 04/08/2013

ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )
If isnull(ls_browse_screen_results_style ) or trim(ls_browse_screen_results_style ) = '' Then 
//	//Added By Ken.Guo 2009-12-29.		//Added By Mark Lee 11/08/2012
//	If Not isvalid(inv_ctx_tv) Then
//		inv_ctx_tv = Create n_cst_ctx_tv
//		inv_ctx_tv.event ue_retrieve( )		
//		of_set_style() 
//	Else
		of_set_style() 
//	End If
Else
	of_set_styles(False) 
End If
//End - Added By Mark Lee 10/26/12


end event

event ue_set_security;// Override
// For fix a defect.


end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(ids_search) then Destroy ids_search
//---------------------------- APPEON END ----------------------------
if isvalid(ids_search_temp) then destroy ids_search_temp

//------------------Begin Added by Alfee 09.30.2007-------------------
//IF IsValid(ids_contract_access) THEN Destroy ids_contract_access   11-22-2007 By Jervis
//IF IsValid(ids_contract_access_pt) THEN Destroy ids_contract_access_pt //commented by Ken.Guo on 2009-02-12
IF IsValid(ids_contract_access_category) THEN Destroy ids_contract_access_category
//-------------------End Added ---------------------------------------

//Added By Ken.Guo 2009-10-28.
If isvalid(ids_ctx_tv_map) Then Destroy ids_ctx_tv_map
if isvalid(ids_search_temp_child) then destroy ids_search_temp_child

if isvalid(ids_search_related_ctx) then destroy ids_search_related_ctx //Added By Ken.Guo 2011-01-31.

If isvalid(inv_ctx_tv) Then Destroy inv_ctx_tv

if IsValid(ids_dddw_columns) then Destroy ids_dddw_columns

If IsValid(ids_templates_list) Then 
	Destroy ids_templates_list			//Added By Mark Lee 11/16/2012
End If	
end event

event ue_initinstancevar;call super::ue_initinstancevar;long ll_Null[]

il_ctx_id = 0
ib_retrieve = false
ib_readonly_current = false
ib_resize = false
ii_resiz = 0
ib_accend = false
is_copy_contract = ""
is_output1 = ""
is_dw_search_sql = ""
il_max_ctx_id = 0
ib_retriev_detail = true
is_filter_string = ""
is_contracted_entity = ""
is_app_facility = ""
is_effective_date = ""
is_expriation_date = ""
is_category = ""
is_product_type = ""
is_ctx_id = ""
is_group_id = ""
is_status = ""
is_group_multi_loc_id = ""
is_user_id = ""
is_product_name = ""
is_effective_date2 = ""
is_expriation_date2 = ""
il_contract_array[] = ll_Null[]
ib_PostOpen = false
ib_FistTime = true

gi_contract_view_id = 0		//Jervis 04.28.2009:Fixed BugJ042803 Reset Value


end event

event resize;call super::resize;string 	ls_browse_screen_results_style
//Add By Jervis 12.19.2008
if isvalid(inv_resize) then
	//$<reason> Workaround APB's Bug.
	If This.width = il_pre_width and This.height = il_pre_height Then
		Return 1
	End If
	il_pre_width = This.width  
	il_pre_height = This.height
	//---------------------------- APPEON END ----------------------------
   dw_search.event ue_moreandless(true)
end if

//Added By Mark Lee 11/14/2012		This is do not need it.
////Begin - Added By Mark Lee 10/26/12
////of_set_style() //Added By Ken.Guo 2009-12-03. Fixed browse dw's position.
//ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )
//If isnull(ls_browse_screen_results_style ) or trim(ls_browse_screen_results_style ) = '' Then 
//	of_set_style() 
//Else
//	of_set_styles(False) 
//End If
////End - Added By Mark Lee 10/26/12
//
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_search
boolean visible = false
integer x = 713
integer y = 1912
integer width = 0
integer height = 0
end type

type cb_2 from u_cb within u_tabpg_contract_search
integer x = 3141
integer y = 1900
integer height = 96
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;call super::clicked;/******************************************************************************************************************
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
IF dw_search_det1.rowcount() < 1 THEN RETURN
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.22.2006 By: Liang QingShi
//$<reason>  Contract module modification 
iw_parent.function dynamic of_select_details_tab_retrieved(false)
//---------------------------- APPEON END ----------------------------

INV_contract_details.of_set_ctx_id(dw_search_det1.OBJECT.CTX_ID[dw_search_det1.getrow() ])

iw_parent.function dynamic of_select_details_tab()

end event

type cb_1 from u_cb within u_tabpg_contract_search
integer x = 3506
integer y = 1900
integer height = 96
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;call super::clicked;//Added By Alan on 2009-1-14
boolean lb_tempautoret

lb_tempautoret = ib_autoretrieve
//parent.setredraw(false)						//Comment By Mark Lee 12/17/2012
dw_search_det1.ib_retrieve_drop_downs = false
parent.ib_retriev_detail = true
//Added By Alan on 2009-1-14
ib_autoretrieve = true
parent.of_retrieve( )
//Added By Alan on 2009-1-14
ib_autoretrieve = lb_tempautoret
parent.ib_retriev_detail = false
dw_search_det1.Event ue_refreshdddw( 'dddw_contact_company' )//added by gavins 20121129
dw_search_det1.event ue_populatedddws( )
//parent.setredraw(True)				//Comment By Mark Lee 12/17/2012

//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//<$>added:long.zhang 07.19.2013
//<$>reason:Several Issues to Report
	dw_search.ib_retrieve_drop_downs = false
	dw_search.event ue_populatedddws( )
//---------End Added ------------------------------------------------------

if ib_PostOpen then
	ib_PostOpen  = false
	return
end if

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-17 By: Scofield
//$<Reason> If there is no row and isn't called by post_open event,then give use a message.
if dw_search_det1.RowCount() < 1 then
	iw_parent.title = 'IntelliContract' //(Appeon)Harry 03.10.2014 - V142 ISG-CLX modify 'Contract Logix' to  'IntelliContract' 
	gnv_status_info.of_display( 'Ready', '1'  )//added by gavins 20130410
	MessageBox(gnv_app.iapp_object.DisplayName,'No search result. Could be because:~r~n1) None of the contracts in the system meet your search criteria.~r~n2) The company you selected has no contracts associated with then.~r~n3) You do not have access to some contracts based on your contract category security settings. ~r~nPlease see administrator.')
end if
//---------------------------- APPEON END ----------------------------

end event

type cb_3 from u_cb within u_tabpg_contract_search
boolean visible = false
integer x = 2775
integer y = 1900
integer height = 96
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "S&earch"
boolean default = true
end type

event clicked;call super::clicked;//Modified By Alan on 2009-1-14
//if ib_autoretrieve or ib_retriev_detail = false then
if ib_retrieved_ctx or ib_retriev_detail = false then
	
	of_filter()	//08.23.2007 By Jervis
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2007-08-17 By: Scofield
	//$<Reason> If there is no row and isn't called by post_open event,then give use a message.
	if dw_search_det1.RowCount() < 1 then
		iw_parent.title = 'IntelliContract' //(Appeon)Harry 03.10.2014 - V142 ISG-CLX modify 'Contract Logix' to  'IntelliContract' 
		gnv_status_info.of_display( 'Ready', '1'  )//added by gavins 20130410
		MessageBox(gnv_app.iapp_object.DisplayName,'No search result. Could be because:~r~n1) None of the contracts in the system meet your search criteria.~r~n2) You do not have access to some contracts based on your contract category security settings. ~r~nPlease see administrator.')
	end if
	//---------------------------- APPEON END ----------------------------
else
	cb_1.event clicked()
end if


end event

type cb_print from u_cb within u_tabpg_contract_search
integer x = 2775
integer y = 1900
integer height = 96
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Report..."
end type

event clicked;call super::clicked;OpenWithParm(w_columns_select,dw_search_det1)

end event

event constructor;call super::constructor;If Parent.iw_parent.classname() <> 'w_contract' Then
	This.visible = False
End If
end event

type dw_search from u_dw_contract within u_tabpg_contract_search
event type long ue_getdetailheight ( )
event ue_moreandless ( boolean ab_resize )
event ue_key pbm_dwnkey
event ue_refresh_some_dddw ( )
event ue_renamefilter ( long al_number )
event ue_set_as_default ( string as_set_as_default )
event ue_viewfilter ( long al_number )
event ue_assignfilter ( integer al_number )
event ue_get_filter ( )
string tag = "Search Criteria"
integer x = 9
integer y = 16
integer width = 3854
integer height = 460
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Search Criteria"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
string dataobject_original = "d_contract_search"
end type

event type long ue_getdetailheight();//--------------------------- APPEON BEGIN ---------------------------

// Function: ue_getdetailheight()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 26,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long ll_y,ll_max,ll_dw_Detail_Height
long ll_Cnt
string ls_object[]
long ll_height
integer i

inv_string.of_parsetoarray( this.describe("datawindow.objects"), "~t", ls_object)
ll_Cnt = upperbound(ls_object)

FOR i = 1 TO ll_Cnt
	If this.Describe(ls_object[i] + ".visible") = '1' Then
		if this.Describe(ls_object[i] + ".type") = 'line' then
			ll_y = long(this.Describe(ls_object[i] + ".y2"))
			ll_height = 0
		else
			ll_y = long(this.Describe(ls_object[i] + ".y"))
			ll_height = long(this.Describe(ls_object[i] + ".height"))
		end if
		
		If ll_y + ll_height > ll_max Then ll_max = ll_y + ll_height
	End If
Next

ll_dw_Detail_Height = ll_max + 16

return ll_dw_Detail_Height
//---------------------------- APPEON END ----------------------------
end event

event ue_moreandless(boolean ab_resize);//---------------------------- APPEON BEGIN ----------------------------
// Function: ue_moreandless()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ab_resize:true-call by resize event 	
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 26,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_text,ls_NewText
Long ll_height,ll_headerHeight,ll_DetailHeight
Long ll_SummaryHeight,ll_FooterHeight,ll_y,ll_bottonHeight
Long ll_OldHeight,ll_diff
long ll_toolbarheight
dec{2} ldec_Zoom
string 		ls_search_criteria				//Added By Mark Lee 11/27/2012
String ls_pos									//Added By Mark Lee 11/28/2012

//---------Begin Added by (Appeon)Harry 04.11.2014 for V142 ISG-CLX--------
Long ll_todolist_height, ll_tv_ctx_height, ll_total_height
//---------End Added ------------------------------------------------------

ll_OldHeight    = this.Height
ldec_Zoom         = Long(this.describe("DataWindow.Zoom"))
ll_headerHeight =  Long(this.describe("DataWindow.header.Height"))
//ll_DetailHeight =  Long(this.describe("DataWindow.Detail.Height"))
ll_SummaryHeight=  Long(this.describe("DataWindow.Summary.Height"))
ll_FooterHeight =  Long(this.describe("DataWindow.Footer.Height"))

if this.titlebar then
	ll_toolbarheight = 180
else
	ll_toolbarheight = 40
end if

ls_text = lower(this.describe( "b_more.text" ))
if isnull(ls_text) or ls_text = '?' or ls_text = '!' then RETURN

//Start Code By Jervis 12.19.2008
if ab_resize then
	if ls_text = 'more >>' then 
		ll_y = Long(this.describe("b_more.y"))
		ll_bottonHeight = Long(this.describe("b_more.Height"))
		ll_DetailHeight = ll_y + ll_bottonHeight// + 16
		ls_NewText = 'More >>'
	else
		ll_DetailHeight = event ue_getdetailheight()
		ls_NewText = '<< Less'
	end if
else
//End Code By Jervis 12.19.2008
	if ls_text = 'more >>' then 
		ll_DetailHeight = event ue_getdetailheight()
		ls_NewText = '<< Less'
	else
		ll_y = Long(this.describe("b_more.y"))
		ll_bottonHeight = Long(this.describe("b_more.Height"))
		ll_DetailHeight = ll_y + ll_bottonHeight// + 16
		ls_NewText = 'More >>'
	end if
end if

ll_height = (ll_headerHeight + ll_DetailHeight + ll_SummaryHeight + ll_FooterHeight) * ldec_Zoom / 100  + ll_toolbarheight

ll_diff   = ll_height - ll_OldHeight

//this.setredraw(False)
dw_search.Modify( "DataWindow.Detail.Height = " + String(ll_DetailHeight) + " b_more.text='" + ls_NewText + "'")

//Begin - Added By Mark Lee 11/28/2012		//Commented By Mark Lee 12/17/2012
//dw_search.height = ll_height
//ls_pos = gnv_user_option.of_Get_option_value(gs_user_id, "Contract_Search_Tab_st_hbar.y" )
//If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
//	dw_search.height  =  Dec(ls_pos)  *  	parent.height - dw_search.y
//	st_hbar.y 			= 	Dec(ls_pos)  *  	parent.height 
//	st_hbar.height	 	=  18						//resize
//Else
	dw_search.height = ll_height
	st_hbar.height	    =  ii_border						//resize
	st_hbar.y = dw_search.y + ll_height
//End If
//End - Added By Mark Lee 11/28/2012

//dw_search_det1.y = dw_search_det1.y + ll_diff //Commented By Ken.Guo 2009-05-20
//dw_search_det1.y = dw_search.y + dw_search.height + 18 + 10 //Added By Ken.Guo 2009-05-20.		//Commend By Mark Lee 11/27/2012
//dw_search_det1.height = dw_search_det1.height - ll_diff  //Commented By Ken.Guo 2009-05-19

If parent.iw_parent.classname( ) = 'w_contract' Then
	cb_1.visible = False
	cb_2.visible = False
	cb_print.visible = False
		
	//the search criteria display or not 
	ls_search_criteria = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_Criteria" )			//Added By Mark Lee 11/27/2012
	If  isnull(ls_search_criteria) or trim(ls_search_criteria) = '' or ls_search_criteria = '1' Then 		//Added By Mark Lee 11/27/2012
		dw_search_det1.y = dw_search.y + dw_search.height + ii_border					//Added By Mark Lee 11/27/2012
		dw_search_det1.height = Parent.height - dw_search.y - dw_search.height - 30   //Added By Ken.Guo 2010-06-24.
	Else
		dw_search_det1.height = Parent.height - 30
	End if
	
	//Begin - Added By Mark Lee 03/27/2013		
	If st_hbar2.visible = True Then
		//---------Begin Modified by (Appeon)Harry 04.11.2014 for V142 ISG-CLX--------
		/*
		If not isnull(is_hbar2) and trim(is_hbar2)  <> '' and  IsNumber(is_hbar2) Then 
			st_hbar2.y =  Dec(is_hbar2)  *  Parent.height
		Else
			st_hbar2.y = dw_search_det1.y + integer(dw_search_det1.height / 2) + 10
		End If
		tv_ctx.height = st_hbar2.y - dw_search_det1.y		
		*/
		ll_todolist_height = w_todolist_contract.height
		ll_tv_ctx_height = tv_ctx.height
		ll_total_height = ll_todolist_height + ll_tv_ctx_height 
		tv_ctx.height = tv_ctx.height - ll_diff * (ll_tv_ctx_height / ll_total_height) 
		//if tv_ctx.height < 300 then tv_ctx.height = 300
		st_hbar2.y = dw_search_det1.y + tv_ctx.height + 10
		//---------End Modfiied ------------------------------------------------------	 
	End If
	//End - Added By Mark Lee 03/27/2013
Else
	dw_search_det1.y = dw_search.y + dw_search.height + ii_border				//Added By Mark Lee 11/27/2012
	dw_search_det1.height = cb_3.y - dw_search.y - dw_search.height - 50   //Added By Ken.Guo 2009-05-19.	
End If
dw_search.Bringtotop = True

//
// Reset orignal size
if IsValid(parent.inv_resize) then
	parent.inv_resize.of_SetOrigSize(this, this.x, this.y, this.width, this.height)
	parent.inv_resize.of_SetOrigSize(dw_search_det1,  dw_search_det1.x, dw_search_det1.y, dw_search_det1.width, dw_search_det1.height)
end if
//---------------------------- APPEON END ----------------------------

if IsValid(w_SearchPage_Calendar) then w_SearchPage_Calendar.of_AdjustSize()			//Added by Scofield on 2009-12-02
if IsValid(w_todolist_contract) then w_todolist_contract.of_AdjustSize()							//Added By Mark Lee 12/25/2012
if IsValid(w_tabpg_contract_doc_mgr) then w_tabpg_contract_doc_mgr.of_AdjustSize()		//Added By Mark Lee 10/26/12

//Added By Ken.Guo 10/30/2012. Support PowerFilter
If isvalid(iu_PowerFilter) Then
	iu_PowerFilter.event ue_positionbuttons() 
End If

//this.setredraw(True) //added by gavins 20121224
end event

event ue_key;if Key = KeyEnter! and keyflags = 0 and iw_parent.classname() = 'w_contract' then
	cb_3.event clicked()
end if
return 0
end event

event ue_refresh_some_dddw();//////////////////////////////////////////////////////////////////////
// Event: ue_refresh_some_dddw
// Arguments:
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	 Ken.Guo 03/12/2012.
//--------------------------------------------------------------------
// Description: Refresh Category and Company DDDW 
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Long li_value, ll_find
String ls_dddwname
n_ds lds_datacache
datawindowchild dwchild

ls_dddwname = 'dddw_contact_company_search'
this.getchild('facility_name',dwchild)
gnv_app.inv_dwcache.of_refresh(ls_dddwname)	
li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddwname,lds_datacache)	
If li_value > 0 Then
	dwchild.Reset()
	lds_datacache.rowscopy( 1, lds_datacache.RowCount(), primary!, dwchild, 1, primary!)
	ll_find = dwchild.find( "facility_id = -1",1,dwchild.rowcount())
	If ll_find > 0 Then
		dwchild.deleterow(ll_find)
	End If
End If


end event

event ue_renamefilter(long al_number);//====================================================================
// Event: ue_renamefilter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_number
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/07/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_OldName,ls_NewName,ls_TransName, ls_contract_search_filter_set_as_default

If al_number <=0 or al_number > 3 then 
	Return
End If

ls_OldName = this.describe( "b_quick_filter"+String(al_number)+".text")

OpenWithParm(w_Rename,ls_OldName)

ls_NewName = Message.StringParm

ls_TransName = inv_String.of_GlobalReplace(ls_NewName,"~~","~~~~")
ls_TransName = inv_String.of_GlobalReplace(ls_NewName,"~'","~~'")

ls_contract_search_filter_set_as_default = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default" )

if ls_NewName <> "" then
	If Right(ls_NewName,3) =  '(D)' Then 
		ls_NewName = Left(ls_NewName,len(ls_NewName) - 3 )
	End If

	gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Seacrh_FilterName_"+string(al_number),ls_NewName )
	gnv_user_option.of_save( )
	
	Parent.of_Refresh_FilterName()

end if

end event

event ue_set_as_default(string as_set_as_default);//====================================================================
// Function: of_set_as_default_button_text
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/03/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
If Isnull(as_set_as_default) or Trim(as_set_as_default) = '' Then 
	Return
End If

gnv_user_option.of_Set_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default",as_set_as_default )
gnv_user_option.of_save( )

parent.of_refresh_filtername()

end event

event ue_viewfilter(long al_number);
OpenWithParm (w_contract_search_filter,al_number)

end event

event ue_assignfilter(integer al_number);//====================================================================
// Event: ue_assignfilter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_number
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/07/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 				ll_RtnVal, ll_count, i
String 			ls_sort, ls_text, ls_new
Boolean			lbn_flag
Datetime			ldt_lastupdate


lbn_flag = False

event ue_get_filter()
ids_search_filter.accepttext()
ll_count =	ids_search_filter.rowcount()

ls_text = this.describe( "b_quick_filter"+string(al_number)+".text")

If  ll_count  > 0 Then 
	ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Are you sure you want to assign the current filter to Quick Filter '" + ls_text+ "'?",Question!,YesNo!,1)
	If ll_RtnVal = 1 Then 
		For i = 1 to ll_count
			ls_sort = ids_search_filter.getitemstring( i, 'sort')
			If (isnull(ls_sort) or trim(ls_sort) = '') then 
				lbn_flag = true
				ids_search_filter.setitem( i, 'sort', String(al_number))
			End If
		Next
		If lbn_flag = True Then 
			ls_sort = String(al_number)
			gnv_appeondb.of_startqueue( )
			//clear data
			Delete From ctx_search_user_filter
			Where users_id = :gs_user_id and sort = :ls_sort ;
			//update data
			ids_search_filter.update( )
			gnv_appeondb.of_commitqueue( )
//		Else
//			If ls_sort <> string(al_number) Then
//				ldt_lastupdate = datetime(today())
//				ls_new = string(al_number)
//	
//				Insert into ctx_search_user_filter (column_name,users_id,sort,col_type,lengths,last_update,data_values,col_text,col_display)
//				Select column_name,users_id,:ls_new,col_type,lengths,:ldt_lastupdate,data_values,col_text,col_display
//				From ctx_search_user_filter
//				Where users_id = :gs_user_id and sort = :ls_sort ;
//				
//////				This.Dynamic Trigger Event ue_viewfilter(al_number)
//			End if
		End If
	Else
		Return 
	End If
Else
	// reset dw value
	ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"There are no filter criteria.~r~n~r~nDo you want to reset the current filter?",Question!,YesNo!,1)
	If ll_RtnVal = 1 Then 
		ls_new = string(al_number)
		//clear data
		Delete From ctx_search_user_filter
		Where users_id = :gs_user_id and sort = :ls_new ;
	End If	
End If

Destroy ids_search_filter
end event

event ue_get_filter();//====================================================================
// Event: ue_get_filter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/21/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long   				ll_Num,ll_Cnt
String 				ls_ColType,ls_ColName,ls_Value
String					ls_Visible, ls_col_text, ls_col_display
Long					ll_row

If not isvalid(ids_search_filter) then 
	ids_search_filter = Create DataStore
	ids_search_filter.dataobject = 'd_contract_search_filter'
	ids_search_filter.settransobject(sqlca)
End If

If dw_search.rowcount() >= 1 Then
	dw_search.accepttext()

	ll_Cnt = Long(dw_search.describe("DataWindow.Column.Count"))
	ids_search_filter.reset( )
	FOR ll_Num = 1 to ll_Cnt
		ls_ColType =  dw_search.describe("#" + string(ll_Num) + ".ColType")
		ls_ColName =  dw_search.describe("#" + string(ll_Num) + ".Name")
		ls_Visible = dw_search.describe("#" + string(ll_Num) + ".visible")
		ls_Value = dw_search.inv_base.of_getitem(1,ls_ColName,false)
	
		If ls_Visible <> '1' Then 
			Continue
		End If

		If Not f_validstr(ls_Value) THEN 
			Continue
		End If
		
		ll_row = ids_search_filter.insertrow(0)
		ls_col_text = dw_search.describe(string(ls_ColName) + "_t.text")
		IF isnull(ls_col_text) or trim(ls_col_text) = '' or ls_col_text = '?' or ls_col_text = '!' Then
			ls_col_text = ls_ColName
		End If				
		ids_search_filter.setItem( ll_row,"col_text", ls_col_text)							
		
		If dw_search.describe("#" + string(ll_Num) + ".edit.style") = 'dddw' then
			ls_col_display = dw_search.Describe("Evaluate('LookupDisplay("+string(ls_ColName)+")'," + "1" + ")")
			ids_search_filter.setItem( ll_row,"col_display", ls_col_display)				//ls_col_display			
		Else
			ids_search_filter.setItem( ll_row,"col_display", ls_Value)			
		End If
		
		ids_search_filter.setItem( ll_row,"column_name", ls_ColName)
		ids_search_filter.setItem( ll_row,"users_id", gs_user_id)
		ids_search_filter.setItem( ll_row,"col_type", ls_ColType)					
		ids_search_filter.setItem( ll_row,"last_update", datetime(today()))	
		
		Choose Case Lower(Left ( ls_ColType , 3 ))
			CASE 'int','lon','dec','num','dou','rea','ulo', 'mon'
				ids_search_filter.setItem( ll_row,"data_values", ls_Value)								
			CASE 'dat'	
				ids_search_filter.setItem( ll_row,"data_values",datetime(ls_Value))							
			CASE 'var','cha'							
				ids_search_filter.setItem( ll_row,"data_values",ls_Value)		
		End Choose	
		
	NEXT 	
End If


end event

event constructor;call super::constructor;
ib_allow_save = False //for of_enable_save() added by Alfee 09.30.2007

this.of_SetDropDownCalendar(TRUE)

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: LeiWei
//$<reason> Performance tuning.
/*
this.iuo_calendar.of_Register("effective_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("expriation_date", this.iuo_calendar.DDLB_WITHARROW	)
*/
//---------------------------- APPEON END ----------------------------

ib_retrieve_drop_downs = false
event ue_populatedddws( )

insertrow(0)
datawindowchild dwc
GetChild('owner', dwc)
dwc.settransobject( sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.14.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Performance tuning
/*
dwc.retrieve( )
*/
//ib_retrieve_drop_downs = false
//event ue_populatedddws( )
//---------------------------- APPEON END ----------------------------

of_reset_filter( )

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.05.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
long ll_row
ll_row = dwc.insertrow(1)
dwc.setitem(ll_row,'user_id', '(NONE)')
*/
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.22.2006 By: LeiWei
//$<reason> Fix a defect.
//$<reason> The Owner search parameter should have the None value in it and NOT the logged in user id
/*
THIS.SETITEM(1,'OWNER',gs_user_id)
is_user_id = UPPER(gs_user_id )
*/
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//<add> 11/26/2007 by: Andy
String ls_Err
of_setbase( true )
inv_base.of_setrequestor(this)


//12.8.2008 By Jervis
/*
this.describe( "b_more.text" )
ls_Err = this.modify("b_more.text='<< Less'")
if ls_Err = "" then 
	Event ue_moreandless()
end if
*/
//---------------------------- APPEON END ----------------------------

end event

event retrieveend;call super::retrieveend;/******************************************************************************************************************
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
 
//long ll_i
//
//
//for ll_i = 1 to rowcount 
//	if il_max_ctx_id <1 then 
//		if object.ctx_id > il_max_ctx_id  then
//		 il_max_ctx_id = object.ctx_id
//		end if
//	end if
//next
//

end event

event pfc_insertrow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.12.2006 By: LeiWei
//$<reason> Fix a defect.

IF inv_contract_details.is_mode = inv_contract_details.new THEN
	Return 0
Else
	CALL super::pfc_insertrow
END IF

//---------------------------- APPEON END ----------------------------

end event

event clicked;// override

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning
string ls_coltype
If isvalid(iuo_Calendar) Then
	ls_coltype = this.Describe(dwo.name+".ColType")	
	If ls_coltype = 'date' or ls_coltype = 'datetime' Then
		iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
	End If
End If
//---------------------------- APPEON END ----------------------------
of_clicklink( dwo, row ) //added by gavins 20120612



end event

event retrievestart;//override
end event

event itemchanged;This.Post event ue_post_itemchanged( row, dwo.name, data)  //Commented By Ken.Guo 10/19/2011. use Post keyword to workaround IE Crash Bug.


//long	ll_view_id,ll_FoundRow,ll_ctx_id,ll_Dynamic
//
//DataStore	lds_SearchDevTemp //,lds_SearchTemp
//
//choose case dwo.name
//		case 'group_multi_loc_id'
//			 is_group_multi_loc_id = DATA
//		case 'app_facility'
//			is_app_facility = DATA 
//		case 'effective_date'
//			is_effective_date = DATA
//		case 'expriation_date'
//			 is_expriation_date = DATA
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 09.19.2006 By: LeiWei
//		//$<reason> Fix a defect.
//		case 'effective_date2'
//			is_effective_date2 = DATA
//		case 'expriation_date2'
//			 is_expriation_date2 = DATA
//		//---------------------------- APPEON END ----------------------------
//		case 'category'
//			is_category = DATA
//			if is_category = '' then setnull(is_category)  //APB Bug, Null valut to "" string
//
//			If iw_parent.classname() = 'w_contract' Then
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$< Add  > 2009-03-24 By: Scofield
//				//$<Reason> Refresh the datawindow's appearance.
//				
//				SELECT Dynamic_Search_Tab
//				  INTO :ll_Dynamic
//				  FROM security_users 
//				 WHERE user_id = :gs_user_id;
//				
//				ll_view_id = of_get_ctx_view(long(is_category),il_ctx_id)
//				if ll_Dynamic = 1 and ll_view_id <> gl_SearchTab_View_id then
//					//lds_SearchTemp = Create DataStore jervis 09.21.2011
//					//lds_SearchTemp.DataObject = This.DataObject
//					
//					lds_SearchDevTemp = Create DataStore
//					lds_SearchDevTemp.DataObject = dw_search_det1.DataObject
//					
//					//This.RowsCopy(1,This.RowCount(),Primary!,lds_SearchTemp,1,Primary!)
//					dw_search_det1.RowsCopy(1,dw_search_det1.RowCount(),Primary!,lds_SearchDevTemp,1,Primary!)
//					
//					ll_ctx_id = il_ctx_id
//					gl_SearchTab_View_id = ll_view_id
//					Parent.Trigger Event ue_show_constructor()
//					
//					This.Reset()
//					this.Insertrow( 0)
//					this.SetItem( 1, 'category',long( is_category))
//					//lds_SearchTemp.RowsCopy(1,lds_SearchTemp.RowCount(),Primary!,this,1,Primary!)
//					lds_SearchDevTemp.RowsCopy(1,lds_SearchDevTemp.RowCount(),Primary!,dw_search_det1,1,Primary!)
//					
//					ll_FoundRow = dw_search_det1.Find("ctx_id = " + String(ll_ctx_id),1,dw_search_det1.RowCount())
//					if ll_FoundRow > 0 then
//						dw_search_det1.Trigger Event RowFocusChanged(ll_FoundRow)
//					elseif dw_search_det1.RowCount() > 0 then
//						dw_search_det1.Trigger Event RowFocusChanged(1)
//					end if
//					
//					//Destroy lds_SearchTemp
//					Destroy lds_SearchDevTemp
//					
//					dwo = This.Object.Category
//					
//					dw_search_det1.Title = 'Contract Browse(' + string(dw_search_det1.RowCount()) + ')' //Added By Ken.Guo 2011-03-18.
//					
//					
//				end if
//				//---------------------------- APPEON END ----------------------------
//			End If
//		case 'product_type'
//			is_product_type = DATA
//		case 'ctx_id'
//			is_ctx_id = DATA
//		case 'group_id'
//			is_group_id = DATA
//		case 'status'
//			is_status = DATA
//		case 'product_name'
//			is_product_name = data
//		case 'owner'
//			if data = '(None)' then 
//				setnull(is_user_id)
//			else
//			is_user_id = UPPER(DATA)
//		end if
//end choose 
//
//of_AutoDataFill(il_ViewId,il_ScreenId,dwo.name,row,data)			//Added By Scofield on 2008-01-08
//
end event

event buttonclicked;call super::buttonclicked;Long				ll_count
DateTime la
SetNull(la)
//messagebox('546','23132')

Choose Case dwo.Name
	Case 'b_eff_date_clear'
		This.Object.effective_date[row] = la
		is_effective_date = ''
	Case 'b_exp_date_clear'
		This.Object.expriation_date[row] = la
		is_expriation_date = ''
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2007-11-26 By: Andy
	Case 'b_more'
		Event ue_moreandless(false)
		//$<add> 01.09.2008 by: Andy
	Case 'b_clear'
		This.Reset()
		This.InsertRow(0)
		//---------------------------- APPEON END ----------------------------
	Case 'b_search' //Added By Ken.Guo 10/30/2012. if you modified below script, you should do same changes for ue_powerfilter() event
		ib_force_retrieve = False
		cb_3.event clicked()
		ib_force_retrieve = True
		
		if IsValid(w_SearchPage_Calendar) then w_SearchPage_Calendar.of_RefreshCondition()
		//Added By Mark Lee 12/25/2012
		if IsValid(w_todolist_contract) then w_todolist_contract.of_RefreshData()
		if IsValid(w_tabpg_contract_doc_mgr) then w_tabpg_contract_doc_mgr.of_RefreshData()
		
		of_refresh_menu_status()			//Added By Mark Lee 12/18/2012
	Case 'b_quick_filter1'		//Added By Mark Lee 11/06/2012
		Select count(1)
		Into :ll_count
	    FROM ctx_search_user_filter   
		Where users_id = :gs_user_id	
			and sort = '1' ;
 		If isnull(ll_count) or ll_count <= 0 Then
//			Messagebox(gnv_app.iapp_object.DisplayName,'Please set the filter condition!')
			This.Reset()
			This.InsertRow(0)
			dw_search_det1.reset( )
//			of_refresh_menu_status()			//Added By Mark Lee 12/18/2012			//Added By Mark Lee 05/13/2013
			If tv_ctx.visible = True Then 
				tv_ctx.deleteitem(1) 
			End If
			If isvalid(w_todolist_contract) Then 
				w_todolist_contract.of_reset()
			End If
			If isvalid(w_tabpg_contract_doc_mgr) Then 
				w_tabpg_contract_doc_mgr.of_reset()
			End If
			dw_search.dynamic Trigger Event buttonclicked(row,0,dw_search.object.b_search)		//Added By Mark Lee 05/13/2013
		Else
			parent.event ue_search_filter( '1',True)
		End If
	Case 'b_quick_filter2'		//Added By Mark Lee 11/06/2012	
		Select count(1)
		Into :ll_count
	    FROM ctx_search_user_filter   
		Where users_id = :gs_user_id	
			and sort = '2' ;
 		If isnull(ll_count) or ll_count <= 0 Then
//			Messagebox(gnv_app.iapp_object.DisplayName,'Please set the filter condition!')
			This.Reset()
			This.InsertRow(0)
			dw_search_det1.reset( )
//			of_refresh_menu_status()			//Added By Mark Lee 12/18/2012			//Added By Mark Lee 05/13/2013
			If tv_ctx.visible = True Then 
				tv_ctx.deleteitem(1) 
			End If	
			If isvalid(w_todolist_contract) Then 
				w_todolist_contract.of_reset()
			End If			
			If isvalid(w_tabpg_contract_doc_mgr) Then 
				w_tabpg_contract_doc_mgr.of_reset()
			End If
			dw_search.dynamic Trigger Event buttonclicked(row,0,dw_search.object.b_search)		//Added By Mark Lee 05/13/2013
		Else
			parent.event ue_search_filter( '2',True)
		End If			
	Case 'b_quick_filter3'		//Added By Mark Lee 11/06/2012	
		Select count(1)
		Into :ll_count
	    FROM ctx_search_user_filter   
		Where users_id = :gs_user_id	
			and sort = '3' ;
 		If isnull(ll_count) or ll_count <= 0 Then
//			Messagebox(gnv_app.iapp_object.DisplayName,'Please set the filter condition!')
			This.Reset()
			This.InsertRow(0)
			dw_search_det1.reset( )
//			of_refresh_menu_status()			//Added By Mark Lee 12/18/2012			//Added By Mark Lee 05/13/2013
			If tv_ctx.visible = True Then 
				tv_ctx.deleteitem(1) 
			End If		
			If isvalid(w_todolist_contract) Then 
				w_todolist_contract.of_reset()
			End If			
			If isvalid(w_tabpg_contract_doc_mgr) Then 
				w_tabpg_contract_doc_mgr.of_reset()
			End If			
			dw_search.dynamic Trigger Event buttonclicked(row,0,dw_search.object.b_search)		//Added By Mark Lee 05/13/2013
		Else
			parent.event ue_search_filter( '3',True)
		End If			
	Case 'b_downarrawb_quick_filter1'
		of_popmenu('1')
	Case 'b_downarrawb_quick_filter2'
		of_popmenu('2')		
	Case 'b_downarrawb_quick_filter3'				
		of_popmenu('3')		
End Choose



end event

event rbuttondown;call super::rbuttondown;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.19.2006 By: LeiWei
//$<reason> Fix a defect.
IF row < 1 THEN RETURN

IF Isnull(this.object.effective_date[row]) THEN
	is_effective_date = ''
END IF

IF Isnull(this.object.expriation_date[row]) THEN
	is_expriation_date = ''
END IF

IF Isnull(this.object.effective_date2[row]) THEN
	is_effective_date2 = ''
END IF

IF Isnull(this.object.expriation_date2[row]) THEN
	is_expriation_date2 = ''
END IF

//---------------------------- APPEON END ----------------------------

end event

event ue_populatedddws;
// Override super event

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.07.2006 By: Davis
//$<reason> Remove the ADD feature from these dddw in the search screen.

if ib_retrieve_drop_downs then return

long ll_column_count,ll_i,ll_Row
string ls_dddw_name
string ls_colname
String ls_coltag
Integer li_value
Integer ll_lookup_code
String ls_DataColumn	
long ll_null
DataWindowChild dwchild, ldwc_doc_category
n_ds lnds_user

LL_COLUMN_COUNT = LONG(This.Describe("DataWindow.Column.Count"))
IF LL_COLUMN_COUNT = 0 THEN RETURN

FOR LL_I = 1 TO LL_COLUMN_COUNT
	IF Describe("#" +STRING(LL_I) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +STRING(LL_I) + ".Name")
		ls_dddw_name = lower(Describe("#" +STRING(LL_I) + ".DDDW.Name"))

		IF ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" THEN
			ls_coltag = Lower(Describe("#" +STRING(LL_I) + ".TAG"))
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
				
			IF li_value <> 1 THEN
				gnv_app.of_setcontraccache_code_lookup( ls_coltag )
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
			END IF
		elseif ls_dddw_name = 'd_dddw_company' or ls_dddw_name = 'd_dddw_company_list' then  // jervis 12.8.2009
			ls_coltag = Lower(Describe("#" +STRING(LL_I) + ".TAG"))
			li_value = 1
		ELSE
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
		END IF

		IF li_value = 1 THEN
			getchild( ls_colname, dwchild)
			if ls_dddw_name = 'd_dddw_company' or ls_dddw_name = 'd_dddw_company_list' then //jervis 12.8.2009
				SetNull(ll_null)
				dwchild.Settransobject( sqlca)
				dwchild.Retrieve( ls_coltag)
				dwchild.InsertRow(1)
				dwchild.SetItem(1,'facility_id',ll_null)
				dwchild.setitem(1,"facility_name",'')
			else
				dwchild.Reset( )
				//------Begin Modified by Alfee 11.15.2007-----------------
				lnds_user.rowscopy( 1, lnds_user.RowCount(), primary!, dwchild, 1, primary!)
				//lnds_user.rowscopy( 1, 1000, primary!, dwchild, 1, primary!)
				//-------End Modified --------------------------------------
			end if
			
			if ls_dddw_name = 'd_dddw_users' then
				dwchild.InsertRow(1)
				dwchild.SetItem(1,'user_id','')
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.27.2007 By: Jack 
			//$<reason> Fix a defect.
			long ll_find
			string ls_displaycolumn
			ls_displaycolumn = This.Describe(ls_colname + ".dddw.displaycolumn")
			ll_find = dwchild.find(ls_displaycolumn + " = '(NONE)'",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.setitem(ll_find,ls_displaycolumn,'')
			End If
			//Add by Jack 07.13.2007
			If ls_colname = 'facility_name' Then
				ll_find = dwchild.find(ls_displaycolumn + " = '* Add Company * '",1,dwchild.rowcount())
				If ll_find > 0 Then
					dwchild.deleterow(ll_find)
				End If
			End If
			//---------------------------- APPEON END ----------------------------
			
			//Added By Ken.Guo 03/12/2012. Do not allow add lookup data for search dw
			ll_find = dwchild.find( "Pos(" + ls_displaycolumn+ ",'*Add ' ) > 0",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.deleterow(ll_find)
			End If
			
			
			ls_DataColumn = This.Describe(ls_colname + ".dddw.DataColumn")
			dwchild.SetFilter( "isnull(" + ls_DataColumn + ") or " + ls_DataColumn + " > 0 " )
			dwchild.Filter( )
		END IF
	END IF
NEXT

This.GetChild("category",dwchild)
dwchild.SetTransObject(SQLCA)

This.GetChild("document_category",ldwc_doc_category)
ldwc_doc_category.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	dwchild.Retrieve(gs_user_id)
	ldwc_doc_category.Retrieve(gs_user_id)
gnv_appeondb.of_commitqueue( )

//Added By Ken.Guo 03/12/2012. Do not allow add lookup data for search dw
ls_displaycolumn = This.Describe("category.dddw.displaycolumn") //(Appeon)Harry 11.24.2014 - for BugH101301
ll_find = dwchild.find( "Pos(" + ls_displaycolumn+ ",'*Add ' ) > 0",1,dwchild.rowcount())
If ll_find > 0 Then
	dwchild.deleterow(ll_find)
End If

ll_Row = dwchild.InsertRow(1)
dwchild.SetItem(ll_Row,'description','No value selected')

ll_Row = ldwc_doc_category.InsertRow(1)
ldwc_doc_category.SetItem(ll_Row,'description','No value selected')


ib_retrieve_drop_downs = True

Return

//---------------------------- APPEON END ----------------------------

end event

event pfc_deleterow;//Override
return dw_search_det1.event pfc_deleterow()

end event

event ue_reset_calendar_flag;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.06.2006 By: LeiWei
//$<reason> Fix a defect.
//$<modification> Set variables of iuo_calendar to NULL when this datawindow is re-created.

If isvalid(iuo_Calendar) Then
	iuo_Calendar.of_reset_flag( )
End If

ib_enable_columns = TRUE
ib_read_only = FALSE

//$<add> 09.18.2006 By: LeiWei
//$<reason> The X button should be disabled on all datawindow title bars.
This.Controlmenu = False

//---------------------------- APPEON END ----------------------------

//Reset prezoom when re-create dw
il_prezoom = 0


post of_resize()		//Add Post - Jervis 09.08.2010


end event

event ue_post_itemchanged;call super::ue_post_itemchanged;long	ll_view_id,ll_FoundRow,ll_ctx_id,ll_Dynamic

DataStore	lds_SearchDevTemp //,lds_SearchTemp

choose case dwoname
		case 'group_multi_loc_id'
			 is_group_multi_loc_id = DATA
		case 'app_facility'
			is_app_facility = DATA 
		case 'effective_date'
			is_effective_date = DATA
		case 'expriation_date'
			 is_expriation_date = DATA
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 09.19.2006 By: LeiWei
		//$<reason> Fix a defect.
		case 'effective_date2'
			is_effective_date2 = DATA
		case 'expriation_date2'
			 is_expriation_date2 = DATA
		//---------------------------- APPEON END ----------------------------
		case 'category'
			is_category = DATA
			if is_category = '' then setnull(is_category)  //APB Bug, Null valut to "" string
			IF Not Isvalid(iw_parent) THEN 							//Added By Mark Lee 01/14/2013 fixed bug
				of_getparentwindow(iw_parent)	
			End If
			If iw_parent.classname() = 'w_contract' Then
				//--------------------------- APPEON BEGIN ---------------------------
				//$< Add  > 2009-03-24 By: Scofield
				//$<Reason> Refresh the datawindow's appearance.
				
				SELECT Dynamic_Search_Tab
				  INTO :ll_Dynamic
				  FROM security_users 
				 WHERE user_id = :gs_user_id;
				
				ll_view_id = of_get_ctx_view(long(is_category),-1) //Modified By Ken.Guo 04/19/2012. get the view of category.
				if ll_Dynamic = 1 and ll_view_id <> gl_SearchTab_View_id then
					//lds_SearchTemp = Create DataStore jervis 09.21.2011
					//lds_SearchTemp.DataObject = This.DataObject
					
					lds_SearchDevTemp = Create DataStore
					lds_SearchDevTemp.DataObject = dw_search_det1.DataObject
					
					//This.RowsCopy(1,This.RowCount(),Primary!,lds_SearchTemp,1,Primary!)
					dw_search_det1.RowsCopy(1,dw_search_det1.RowCount(),Primary!,lds_SearchDevTemp,1,Primary!)
					
					ll_ctx_id = il_ctx_id
					gl_SearchTab_View_id = ll_view_id
					Parent.Trigger Event ue_show_constructor()
					
					This.Reset()
					this.Insertrow( 0)
					this.SetItem( 1, 'category',long( is_category))
					//lds_SearchTemp.RowsCopy(1,lds_SearchTemp.RowCount(),Primary!,this,1,Primary!)
					lds_SearchDevTemp.RowsCopy(1,lds_SearchDevTemp.RowCount(),Primary!,dw_search_det1,1,Primary!)
					
					ll_FoundRow = dw_search_det1.Find("ctx_id = " + String(ll_ctx_id),1,dw_search_det1.RowCount())
					if ll_FoundRow > 0 then
						dw_search_det1.Trigger Event RowFocusChanged(ll_FoundRow)
					elseif dw_search_det1.RowCount() > 0 then
						dw_search_det1.Trigger Event RowFocusChanged(1)
					end if
					
					//Destroy lds_SearchTemp
					Destroy lds_SearchDevTemp
					
					//dwo = This.Object.Category
					
					dw_search_det1.Title = 'Contract Browse (' + string(dw_search_det1.RowCount()) + ')' //Added By Ken.Guo 2011-03-18.
					
					
				end if
				//---------------------------- APPEON END ----------------------------
			End If
		case 'product_type'
			is_product_type = DATA
		case 'ctx_id'
			is_ctx_id = DATA
		case 'group_id'
			is_group_id = DATA
		case 'status'
			is_status = DATA
		case 'product_name'
			is_product_name = data
		case 'owner'
			if data = '(None)' then 
				setnull(is_user_id)
			else
			is_user_id = UPPER(DATA)
		end if
end choose 

of_AutoDataFill(il_ViewId,il_ScreenId,dwoname,row,data)			//Added By Scofield on 2008-01-08

end event

type dw_search_det1 from u_dw_contract within u_tabpg_contract_search
event ue_set_sort_old ( integer xpos,  integer ypos,  long row,  dwobject dwo,  string as_sort_column )
event ue_set_sort ( integer xpos,  integer ypos,  long row,  dwobject dwo,  string as_sort_column )
event ue_sort_build_by_click ( integer ai_xpos,  integer ai_ypos,  long al_row,  ref dwobject adwo_obj )
event ue_leftbuttonup pbm_dwnlbuttonup
event ue_create_menu_item ( m_search_screen_browse am_menu )
event ue_refreshdddw ( string as_dddwname )
string tag = "Contract Browse"
integer x = 9
integer y = 504
integer width = 3854
integer height = 1376
integer taborder = 20
boolean titlebar = true
string title = "Contract Browse"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
string dataobject_original = "d_sp_contract_search"
boolean ib_allow_filter = true
boolean ib_allow_sort = true
end type

event ue_set_sort_old(integer xpos, integer ypos, long row, dwobject dwo, string as_sort_column);//////////////////////////////////////////////////////////////////////
// $<event>ue_set_sortdw_search_det1()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Jack
//////////////////////////////////////////////////////////////////////
long ll_i,ll_ctx_id
long ll_master_contract_id,ll_master_cnt
string ls_sort_column
dw_search_det1.setredraw(false)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.05.2007 By: Jack
//$<reason> Performance tuning
/*
For ll_i = dw_search_det1.rowcount() To 1 step -1					
	ll_ctx_id = dw_search_det1.getitemnumber(ll_i,'ctx_id')		
	of_collapse_row(ll_ctx_id,ll_i)										
	If ll_i > dw_search_det1.rowcount() Then ll_i = dw_search_det1.rowcount()	
Next
 
ls_sort_column = as_sort_column
If ls_sort_column <> is_sort_column Then 
	is_sort_column = ls_sort_column 
	If ib_accend = False And ls_sort_column = 'ctx_id' Then
		dw_search_det1.setsort(ls_sort_column + " D")
		ib_accend = True
	Else
		dw_search_det1.setsort(ls_sort_column + " A")
		ib_accend = False
	End If
	dw_search_det1.sort()
Else
	ib_accend = not ib_accend
	If ib_accend Then 
		dw_search_det1.setsort(ls_sort_column + " D") 
	Else
		dw_search_det1.setsort(ls_sort_column + " A")
	End if
	dw_search_det1.sort()
End If	
*/

//ids_search.SETFILTER('master_contract_id = 0 and ' + is_filter_string)
//ids_search.FILTER()
////Add by Jack 07.13.2007
//If ids_search.rowcount() < 1 Then
//	ids_search.SETFILTER(is_filter_string)
//	ids_search.FILTER()
//End If
////End add
//dw_search_det1.reset()
//ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)

String ls_filter_string

IF len(is_filter_string) > 1 THEN
	For ll_i = dw_search_det1.rowcount() To 1 step -1					
		ll_ctx_id = dw_search_det1.getitemnumber(ll_i,'ctx_id')		
		ll_master_contract_id = dw_search_det1.getitemnumber(ll_i,'master_contract_id')
		ll_master_cnt = dw_search_det1.getitemnumber(ll_i,'master_cnt')
		If (ll_master_contract_id = 0 or isnull(ll_master_contract_id)) And ll_master_cnt > 0 Then
			of_collapse_row(ll_ctx_id,ll_i)
		End If
		If ll_i > dw_search_det1.rowcount() Then ll_i = dw_search_det1.rowcount()	
	Next
ELSE
	ls_filter_string = "master_contract_id = 0 or isnull(master_contract_id)" //Added By Ken.Guo 2009-05-18.add isnull() statement. 
	ids_search.setfilter(ls_filter_string)
	ids_search.filter()
	
	dw_search_det1.reset()
	ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)	
END IF
		
this.of_setsort( true)
If IsValid (inv_Sort) Then 
	inv_Sort.of_setcolumnheader(True)
	inv_Sort.of_setusedisplay(True)
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
End If

ids_search.SetSort(this.inv_sort.of_getsort())		//Added by Scofield on 2007-12-14

//---------------------------- APPEON END ----------------------------

For ll_i = 1 To dw_search_det1.rowcount()
	ll_ctx_id = dw_search_det1.getitemnumber(ll_i,'ctx_id')		
	ll_master_contract_id = dw_search_det1.getitemnumber(ll_i,'master_contract_id')
	ll_master_cnt = dw_search_det1.getitemnumber(ll_i,'master_cnt')
	If (ll_master_contract_id = 0 or isnull(ll_master_contract_id)) And ll_master_cnt > 0 Then
		of_display_row(ll_ctx_id,ll_i)	
	End If
Next

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.18.2009 By: Ken.Guo
//$<reason> Show sub contract although master contract be filter.  
IF len(is_filter_string) = 0 THEN
	If is_output1 <> '' Then
		ls_filter_string = "master_contract_id > 0 AND ctx_id not in (" +is_output1 + ") " 
	Else
		ls_filter_string = "master_contract_id > 0 " 
	End If
	ids_search.setfilter(ls_filter_string)
	ids_search.filter()
	ids_search.RowsCopy(1,ids_search.RowCount(), Primary!, dw_search_det1, 1, Primary!)	
End If
//---------------------------- APPEON END ----------------------------	
dw_search_det1.title = 'Contract Browse ' + "(" + string(dw_search_det1.rowcount()) + ")"

dw_search_det1.event rowfocuschanged(1)
dw_search_det1.setredraw(true)

end event

event ue_set_sort(integer xpos, integer ypos, long row, dwobject dwo, string as_sort_column);//rewrite by jervis 06.03.2009
//Performance Optimize

long ll_i,ll_ctx_id,ll_findrow
long ll_master_contract_id,ll_master_cnt
string ls_sort_column
String ls_sort_syntax
dw_search_det1.setredraw(false)

this.of_setsort( true)
If IsValid (inv_Sort) Then 
	inv_Sort.of_setcolumnheader(True)
	inv_Sort.of_setusedisplay(True)
	inv_Sort.of_build_click_sort_syntax( xpos, ypos, row, dwo )
End If

//Added by Ken.Guo 2011-08-09
If GetRow() > 0 Then ll_ctx_id = This.GetItemNumber(GetRow(),'ctx_id')

//this.SetSort(this.inv_sort.of_getsort())		//Added by Scofield on 2007-12-14
this.SetSort(of_replace_sort(this.inv_sort.of_getsort())) //Modified By Ken.Guo 2009-12-21
This.sort()

//Commented By Ken.Guo 12/15/2011
//IF Not ib_tree_view Then
//	parent.of_copy_row( )
//End IF

//Modified by Ken.Guo 2011-08-09
//dw_search_det1.event rowfocuschanged(1)
ll_findrow = This.Find('ctx_id = ' + String(ll_ctx_id),1, This.RowCount())
If ll_findrow > 0 Then
	dw_search_det1.SetRow(ll_findrow)
	dw_search_det1.ScrollToRow(ll_findrow)
	dw_search_det1.event rowfocuschanged(ll_findrow)
Else
	If Rowcount( ) > 0 Then dw_search_det1.event rowfocuschanged(1)
End If

dw_search_det1.setredraw(true)

end event

event ue_leftbuttonup;//Added By Ken.Guo 10/30/2012. Support PowerFilter
If isvalid(iu_PowerFilter) Then
	iu_PowerFilter.event post ue_buttonclicked( dwo.type, dwo.name )
End If

end event

event ue_create_menu_item(m_search_screen_browse am_menu);//====================================================================
// Event: ue_create_menu_item
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/16/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 			ll_rowcount, i , ll_id, ll_tmp 
String 		ls_tempaltes_name
menu 		lm_create[]

IF  IsValid(am_menu)=  True Then
	Parent.of_create_templates_list()
	
	ll_rowcount  = ids_templates_list.rowcount()
	If ll_rowcount > 0  Then 
		For i = 1 to ll_rowcount
			lm_create[i] = Create  m_menu_create_item_child
			ls_tempaltes_name = ids_templates_list.GetItemString(i,'template_name')		
			ll_id 		= ids_templates_list.GetItemNumber(i,'id')		
			ll_tmp = i + 2 
			am_menu.m_usetemplate.item[ll_tmp]= lm_create[i]
			am_menu.m_usetemplate.item[ll_tmp].text = ls_tempaltes_name
			am_menu.m_usetemplate.item[ll_tmp].tag = string(ll_id)
			am_menu.m_usetemplate.item[ll_tmp].visible =True
		Next 
		
		am_menu.m_usetemplate.hide()
		am_menu.m_usetemplate.show()
		am_menu.hide()
		am_menu.show()
	End If
End If



end event

event ue_refreshdddw(string as_dddwname);//====================================================================
// Event: ue_refreshdddw
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_dddwname
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-11-29
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long			ll_Count
Integer		li_value
n_ds			lnds_user

If as_DDDWName = 'dddw_contact_company' Then
	select count(1) into:ll_Count from app_facility;
	li_value = gnv_app.inv_dwcache.of_GetRegistered (as_DDDWName,lnds_user)
	
	If lnds_user.RowCount( ) <>  ll_Count + 2 Then
		
		gnv_app.inv_dwcache.of_Refresh(as_DDDWName )
		
	End If	
End If
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
IF ROW < 1 THEN RETURN
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.22.2006 By: Liang QingShi
//$<reason>  Contract module modification 
iw_parent.function dynamic of_select_details_tab_retrieved(false)
//---------------------------- APPEON END ----------------------------

//Commented by Ken.Guo 2011-05-13. Forbit auto save.
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.11.2006 By: LeiWei
//$<reason> Performance tuning.
IF appeongetclienttype() = 'PB' THEN
	iw_parent.event dynamic ue_save()
END IF
//---------------------------- APPEON END ----------------------------
*/


iw_parent.function dynamic wf_manage_tabs(true)

//INV_contract_details.of_set_ctx_id(THIS.OBJECT.CTX_ID[ROW])

iw_parent.function dynamic of_select_details_tab()


end event

event clicked;/******************************************************************************************************************
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

Boolean lb_readonly_current = False //Added by Ken.Guo on 2009-02-12

ib_RowChangedSetRedraw =  true //added by gavins 20130415

tv_ctx.SetRedraw(False)
if IsValid (inv_RowSelect) then inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )

of_clicklink( dwo, row )//added by gavins 20120612

IF row > 0 THEN 

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.12.2009 By: Ken.Guo
	//$<reason> Get Readonly or Full Access
	If This.GetItemString(row,'access') = 'F' Then
			lb_readonly_current = False
		Else
			lb_readonly_current = True
	End If
	//---------------------------- APPEON END ----------------------------	
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.09.2007 By: Jack 
	//$<reason> Fix a defect.
	
	long ll_category
	integer li_view_id
	//setpointer(hourglass!)
	ll_category = this.object.category[row]
	inv_contract_details.il_category = this.object.category[row]
	il_ctx_id = this.object.ctx_id[row]
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.12.2009 By: Ken.Guo
	//$<reason> Get view by function
	/*
	li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(ll_category)))
	
	If isnull(li_view_id) Or li_view_id = 0 Then
		li_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
	End If
	If isnull(li_view_id) Or li_view_id = 0 Then
		li_view_id = 1001
	End If
	*/
	li_view_id = of_get_ctx_view(ll_category,il_ctx_id)
	//---------------------------- APPEON END ----------------------------
	
	If li_view_id <> gi_contract_view_id Or lb_readonly_current <> ib_readonly_current Then //Added readonly condition Ken.Guo 02/12/2009 
		gi_contract_view_id = li_view_id
		If isvalid(iw_parent) Then
			If iw_parent.classname() = 'w_contract' Then //Added By Ken.Guo 2009-06-17. Added 'If' condition.
				iw_parent.function dynamic wf_tab_visible(li_view_id)
				iw_parent.function dynamic wf_set_select('All',false) 
			End If
		End if
	End If
	//---------------------------- APPEON END ----------------------------

	INV_contract_details.of_set_ctx_id( THIS.OBJECT.CTX_ID[row])
  // INV_contract_details.il_ctx_id = 

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 03.14.2007 By: Jack (Contract)
	//$<reason> Fix a defect.
	long  ll_ctx_id
	int  li,li_new,li_rows,li_Find
	
	ll_ctx_id = This.getitemnumber(row,'ctx_id')
	
	If dwo.name = 'p_1' Then
		//of_display_row(ll_ctx_id,row)       // Add by Jack 03/30/2007
		of_expand_row(ll_ctx_id,row)	//jervis -6.23.2009
	ElseIf dwo.name = 'p_2' Then
		of_collapse_row(ll_ctx_id, row)
	End If
	
	//Add By Jervis 01.22.2009
	//Force trigger RowFocusChanging/Changed event
	this.SetRow( row)
	
	//Add by Jack 03/23/2007
	ib_resize = False   
	ii_resiz = 1
	
	//---------------------------- APPEON END ----------------------------

END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.09.2007 By: Jack
//$<reason> Fix a defect.
string ls_objectname,ls_sort_column
ls_objectname = string(dwo.name) 
If row = 0 and this.describe(ls_objectname+".band") = "header" and this.describe(ls_objectname + ".text") <> "!" Then 
	ls_sort_column = left(ls_objectname,len(ls_objectname) - 2)
	is_sort_column = ls_sort_column
	this.event ue_set_sort(xpos,ypos,row,dwo,ls_sort_column)
End If
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 2009-12-21.
If row > 0 Then
//	Parent.Post Event ue_locate_treeview(This.GetItemNumber(This.GetRow(),'ctx_id'))
	Parent.Event ue_locate_treeview(This.GetItemNumber(This.GetRow(),'ctx_id'))				//Added By Mark Lee 12/28/2012
End If
tv_ctx.SetRedraw(True)
end event

event rowfocuschanging;call super::rowfocuschanging;long la_any

If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 11/14/2011.  must add in current object. 

if not isvalid(iw_parent) then return

//Commented by Ken.Guo 2011-05-13. Forbit auto save.
/*
la_any = iw_parent.event dynamic ue_save()
if la_any = failure then return success
*/

// reset the retived flag to false
iw_parent.function dynamic wf_reset_retrieved()
inv_contract_details.is_mode = inv_contract_details.edit

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11/05/2007 By: Jervis
//$<reason> 
//if currentrow >  0 then
//if this.rowcount() > 0 and currentrow > 0 then                                  
if this.rowcount() > 0 and currentrow > 0 and currentrow <= this.rowcount() then    //Modify by Jack 06/11/2007
	inv_contract_details.of_set_old_ctx_id(this.GetItemNumber(currentrow,"ctx_id"))
else
	inv_contract_details.of_set_old_ctx_id(0)
end if
//---------------------------- APPEON END ----------------------------


end event

event rowfocuschanged;call super::rowfocuschanged;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                     Reason/Change
** ------------------------------------------------------------------------------------------------------------------
**   MSKINNER              13 March 2006  					   Added code to set exp date, contract status						        
********************************************************************************************************************/

Boolean lb_readonly_current = False //Added by Ken.Guo on 2009-02-12

If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 11/14/2011. 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.23.2007 By: Jack (Export)
//$<reason> Fix a defect.
long ll_find
If	ib_resize Then 
	ll_find = dw_search_det1.find("ctx_id = " + string(il_ctx_id),1,dw_search_det1.rowcount())
	If ll_find > 0 Then
		This.SelectRow(0, False)
		This.scroll(ll_find)
		This.SelectRow(ll_find, True)
		ib_resize = False
		Return     
	End If
End If
ib_resize = False
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Davis
//$<reason> Fix a defect.
IF Rowcount() = 0 THEN RETURN
//---------------------------- APPEON END ----------------------------

if currentrow < 1 or isnull(currentrow) then
		return success
end if 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Jack (Document Manager)
//$<reason> Fix a defect.
If Not ib_retrieve Then Return success

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.14.2006 By: Liang QingShi
//$<reason> Contract module modification 
/*
dw_search_det1.describe("Evaluate( 'lookupdisplay(ctx_basic_info_app_facility) ', "+string(CurrentRow)+" )")
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.14.2007 By: Jack (Contract)
//$<reason> Fix a defect.
If dw_search_det1.getrow() < 1 Then Return
If dw_search_det1.getrow() > dw_search_det1.rowcount() Then Return
inv_contract_details.il_count = this.object.master_cnt[currentrow]
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 02.12.2009 By: Ken.Guo
//$<reason> Get Readonly or Full Access
If This.GetItemString(currentrow,'access') = 'F' Then
		lb_readonly_current = False
	Else
		lb_readonly_current = True
End If
//---------------------------- APPEON END ----------------------------

//BEGIN---Add by Evan 07/15/2008
long ll_category, li_view_id
ll_category = this.object.category[currentRow]
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 02.12.2009 By: Ken.Guo
//$<reason> Get view by function
/*li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(ll_category)))*/
il_ctx_id = this.object.CTX_ID[currentrow] 
li_view_id = of_get_ctx_view(ll_category,il_ctx_id)

If ib_RowChangedSetRedraw then gw_contract.setredraw( false ) //added by gavins 20121109		//Comment By Mark Lee 12/17/2012
//---------------------------- APPEON END ----------------------------
gw_contract.of_set_view_id(li_view_id)
gw_contract.TriggerEvent("ue_set_tabpage_properties")
//END---Add by Evan 07/15/2008

//BEGIN---Add by Evan 12/12/2008
If li_view_id <> gi_contract_view_id or lb_readonly_current <> ib_readonly_current Then  //Added readonly condition Ken.Guo 02/12/2009 
	gi_contract_view_id = li_view_id
	If isvalid(iw_parent) Then			
		iw_parent.function dynamic wf_tab_visible(li_view_id)
		iw_parent.function dynamic wf_set_select('All',false)
	End if
End If
//END---Add by Evan 12/12/2008
if ib_RowChangedSetRedraw then gw_contract.setredraw( true ) //added by gavins 20121109			//Comment By Mark Lee 12/17/2012
ib_RowChangedSetRedraw = false //added by gavins 20130415

// Added by Davis 01.09.2007
String ls_id,ls_company
ls_id = String(This.getitemnumber( currentrow, 'ctx_id'))
ls_company = this.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(CurrentRow)+" )")

is_copy_contract = ls_company + ' - ' + ls_id   //Add by Jack 05/30/2007

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.05.2007 By: Jack
//$<reason> Fix a defect.
gl_Company_id = This.getitemnumber( currentrow, 'app_facility')
//---------------------------- APPEON END ----------------------------

IF f_validstr(ls_id) THEN ls_id = '    Contract ID: ' + ls_id

IF f_validstr(ls_company) THEN ls_company = '    Company: ' + ls_company

IF Not Isvalid(iw_parent) THEN of_getparentwindow(iw_parent)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2007.08.21 By: Jack
//$<reason> Fix a Web defict.
/*
iw_parent.title = 'Contract Logix ' + ls_company + ls_id
*/
iw_parent.title = 'IntelliContract ' + ls_id + ls_company //(Appeon)Harry 03.10.2014 - V142 ISG-CLX modify 'Contract Logix ' to 'IntelliContract '
gnv_status_info.of_display( Trim ( ls_id + ls_company  ), '1'  )//added by gavins 20130410
//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////////
// set the contract type
//////////////////////////////////////////////////////////////////////////////////

// Added by Davis 01.11.2007
inv_contract_details.of_set_contact_type(this.getItemNumber(CurrentRow,'category') ) 


//---------------------------- APPEON END ----------------------------

//inv_contract_details.of_set_ctx_id( setnull( currentrow))
il_ctx_id = this.object.CTX_ID[currentrow]  //08.23.2007 By Jervis
inv_contract_details.of_set_ctx_id(this.object.CTX_ID[currentrow])
inv_contract_details.idt_contract_exp_date =  datetime(this.object.expriation_date[currentrow] )
inv_contract_details.idt_contract_eff_date =  datetime(this.object.effective_date[currentrow] )	//01.23.2008 By Jervis
inv_contract_details.is_contract_status = upper( this.inv_base.of_getitem(currentrow, 'status'))

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.09.2007 By: Jack
//$<reason> Fix a defect.
inv_contract_details.il_category = this.object.category[currentrow]

//---------------------------- APPEON END ----------------------------

///////////////////////////////////////////////////////////////////////
//// set security
///////////////////////////////////////////////////////////////////////

of_set_message('')
//-------Begin Modified by Alfee 09.30.2007---------------------------------
//<$Reason>The original logic of of_get_access() has been modified
//Get and set readonly property for the current contract
If RowCount( ) > 0 Then	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.12.2009 By: Ken.Guo
	//$<reason> 
	/*ib_readonly_current = of_get_access(this.object.CTX_ID[currentrow]) */
	ib_readonly_current = lb_readonly_current
	//---------------------------- APPEON END ----------------------------
	inv_contract_details.of_set_tab_change( true)
	
	//enable profile report - jervis 09.26.2011
	if currentrow > 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_reports.m_profilerpt,'enabled', true)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_reports.m_profilerpt,'enabled', false)
	end if
else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_reports.m_profilerpt,'enabled', false)
End If

If inv_ctx_tv.is_tv_type = 'row' Then
	//Added By Ken.Guo 12/10/2011. 
	of_get_related_ctx( il_ctx_id, 'row')
Else
	Event ue_locate_treeview(il_ctx_id)
End If

//Begin - Added By Mark Lee 10/31/2012
If isvalid(w_todolist_contract) Then
	w_todolist_contract.of_refreshdata()
End If			
If isvalid(w_tabpg_contract_doc_mgr) Then
	w_tabpg_contract_doc_mgr.of_refreshdata()
End If
//End - Added By Mark Lee 10/31/2012

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;

return prevent_action
end event

event constructor;call super::constructor;///f_create_ctx_database()
this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.extended )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.30.2007 By: Jack 
//$<reason> Fix a defect.
/*
of_SetSort(TRUE)
*/
of_SetSort(False)
this.event ue_populatedddws( )  //Add by Jack 07.10.2007
//---------------------------- APPEON END ----------------------------


//Add type down capability feature -- jervis 06.25.2010
this.ib_typedown = true
this.is_typedown_name = 'app_facility'

//Added By Ken.Guo 10/30/2012. Support PowerFilter
If Not isvalid(iu_PowerFilter) Then
	iu_PowerFilter = create n_cst_PowerFilter
End If
iu_PowerFilter.of_setdw(this)
iu_PowerFilter.of_SetParentWindow( w_contract )

If gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_PowerFilter" ) = '0' Then
	iu_PowerFilter.checked = False 
Else
	iu_PowerFilter.checked = True 
End If

end event

event pfc_retrieve;call super::pfc_retrieve;setfilter('')

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.11.2006 By: LeiWei
//$<reason> Fix a defect.
/*
filter( )
this.retrieve( )
*/

this.retrieve( )

//---------------------------- APPEON END ----------------------------

return success
end event

event getfocus;long ll_RowCnts

ll_RowCnts = This.RowCount()
//Added By Mark Lee 03/22/2013
//This.Title = '>>>>>>>>>> Contract Browse (' + string(ll_RowCnts) + ') <<<<<<<<<<< '
This.Title = gs_left_title_sign + 'Contract Browse (' + string(ll_RowCnts) + ')' + gs_right_title_sign

//BEGIN---Modify by Scofield on 2009-04-20
if IsValid(iw_Parent) then
	if iw_Parent.ClassName() = 'w_contract' and IsValid(w_contract) then 
		w_contract.of_SetCurrentScreenID(il_ScreenId)
	end if
	iw_parent.dynamic event pfc_ControlGotFocus (this)  //(Appeon)Harry 09.01.2014 - for BugH062404 in V14.2 Issues of Integration.doc
end if
//END---Modify by Scofield on 2009-04-20

end event

event losefocus;call super::losefocus;long ll_rowcount
ll_rowcount = this.rowcount()

this.title = 'Contract Browse (' + string(ll_rowcount) + ')'


end event

event rbuttondown;call super::rbuttondown;//====================================================================
// Event: rbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-05-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_SelCnts,ll_SelectedRow

m_search_screen_browse	lm_Menu

if Not IsValid(iw_parent) then Return
if iw_parent.ClassName() <> "w_contract" then Return

lm_Menu = Create m_search_screen_browse

lm_Menu.il_ctx_id = il_ctx_id

ll_SelectedRow = This.GetSelectedRow(0)
do while ll_SelectedRow > 0
	ll_SelCnts++
	ll_SelectedRow = This.GetSelectedRow(ll_SelectedRow)
loop

if ll_SelCnts >= 2 then 
	lm_Menu.ib_MulCTX = true
	gnv_app.of_modify_menu_attr( lm_Menu.m_importemailitem,'enabled', False)
End If

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( lm_Menu.m_new,'Enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_newctx.Enabled)
	lm_Menu.m_new.Visible = m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_newctx.ToolbarItemVisible
		
	gnv_app.of_modify_menu_attr( lm_Menu.m_copy,'Enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx.Enabled)
	lm_Menu.m_copy.Visible = m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx.ToolbarItemVisible
	
	//Added By Mark Lee 05/31/12
	gnv_app.of_modify_menu_attr( lm_Menu.m_usetemplate,'Enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_usetemplate.Enabled)
	lm_Menu.m_usetemplate.Visible = m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_usetemplate.ToolbarItemVisible
				
	gnv_app.of_modify_menu_attr( lm_Menu.m_email,'Enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.Enabled)
	lm_Menu.m_email.Visible = m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.ToolbarItemVisible
	
	//Begin - Added By Mark Lee 05/17/12 email subject is 'Search Browse right click' .
	gnv_app.of_modify_menu_attr( lm_Menu.m_select	,'enabled', m_pfe_cst_mdi_menu_contract.m_file.m_select.enabled)
	lm_Menu.m_select.visible	=	m_pfe_cst_mdi_menu_contract.m_file.m_select.visible
	
	If lm_Menu.m_select.visible Then
		lm_Menu.m_sep_0.Visible = True
	Else
		lm_Menu.m_sep_0.Visible = False
	End IF
	
	//Begin - Added By Mark Lee 11/15/2012
	gnv_app.of_modify_menu_attr( lm_Menu.m_new.m_new_blank_contract_record,'enabled', lm_Menu.m_new.Enabled) 
	lm_Menu.m_new.m_new_blank_contract_record.Visible = lm_Menu.m_new.Visible 	
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_copy.m_copy_contract_record,'Enabled', lm_Menu.m_copy.Enabled)
	lm_Menu.m_copy.m_copy_contract_record.Visible = lm_Menu.m_copy.Enabled
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_usetemplate.m_contract_templates,'Enabled', lm_Menu.m_usetemplate.Enabled) 
	lm_Menu.m_usetemplate.m_contract_templates.Visible =  lm_Menu.m_usetemplate.Visible
	gnv_app.of_modify_menu_attr( lm_Menu.m_usetemplate.m_template_item,'Enabled', lm_Menu.m_usetemplate.Enabled) 
	lm_Menu.m_usetemplate.m_template_item.Visible =  lm_Menu.m_usetemplate.Visible
	
	lm_Menu.m_copy.m_copy_create_sub_contract_record.Visible = lm_Menu.m_copy.Visible
	lm_Menu.m_new.m_new_blank_sub_contract_record.Visible = lm_Menu.m_new.Visible 	
	If  This.GetSelectedRow(0) > 0 Then 
		gnv_app.of_modify_menu_attr( lm_Menu.m_new.m_new_blank_sub_contract_record,'enabled', lm_Menu.m_new.Enabled) 
		gnv_app.of_modify_menu_attr( lm_Menu.m_copy.m_copy_create_sub_contract_record,'enabled', lm_Menu.m_copy.Enabled)
	Else
		gnv_app.of_modify_menu_attr( lm_Menu.m_new.m_new_blank_sub_contract_record,'enabled', False)
		gnv_app.of_modify_menu_attr( lm_Menu.m_copy.m_copy_create_sub_contract_record,'enabled', False)
	End If
//	this.event ue_create_menu_item(lm_Menu)
	//End - Added By Mark Lee 11/15/2012

	
	gnv_app.of_modify_menu_attr( lm_Menu.m_adddoc,'enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.enabled)
	lm_Menu.m_adddoc.visible = 	m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.visible
	gnv_app.of_modify_menu_attr( lm_Menu.m_createdoc,'enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.visible)//Commented by (Appeon)Harry 10.10.2015 - for Bud_id#4773
	gnv_app.of_modify_menu_attr( lm_Menu.m_createdoc,'enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.enabled) //(Appeon)Harry 10.10.2015 - for Bud_id#4773
	lm_Menu.m_createdoc.visible	=	m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.visible
	
	If lm_Menu.m_adddoc.visible And lm_Menu.m_createdoc.visible Then
		lm_Menu.m_sep_2.visible = True
	Else
		lm_Menu.m_sep_2.visible = False
	End If
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_delete1,'enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.enabled)
	lm_Menu.m_delete1.visible = 	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible
	//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	//gnv_app.of_modify_menu_attr( lm_Menu.m_contractdatascreenpainter,'enabled', m_pfe_cst_mdi_menu_contract.m_system.m_painters.m_contractdatascreenpainter.enabled)
	//lm_Menu.m_contractdatascreenpainter.visible = m_pfe_cst_mdi_menu_contract.m_system.m_painters.m_contractdatascreenpainter.visible
	gnv_app.of_modify_menu_attr( lm_Menu.m_contractdatascreenpainter,'enabled', m_pfe_cst_mdi_menu_contract.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.enabled)//(Appeon)Harry 06.27.2013 - V141 ISG-CLX
	lm_Menu.m_contractdatascreenpainter.visible = m_pfe_cst_mdi_menu_contract.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.visible  //(Appeon)Harry 06.27.2013 - V141 ISG-CLX
	//---------End Modfiied ------------------------------------------------------
	//Begin - Added By Mark Lee 10/26/12
//	lm_Menu.m_display.m_disp_default.enabled	= m_pfe_cst_mdi_menu_contract.m_file.m_display.m_disp_default.enabled
//	lm_Menu.m_display.m_disp_default.visible		= m_pfe_cst_mdi_menu_contract.m_file.m_display.m_disp_default.visible
//	lm_Menu.m_display.m_disp_treeview.enabled	= m_pfe_cst_mdi_menu_contract.m_file.m_display.m_disp_treeview.enabled
//	lm_Menu.m_display.m_disp_treeview.visible	= m_pfe_cst_mdi_menu_contract.m_file.m_display.m_disp_treeview.visible
//	lm_Menu.m_display.m_disp_calendar.enabled	= m_pfe_cst_mdi_menu_contract.m_file.m_display.m_disp_calendar.enabled
//	lm_Menu.m_display.m_disp_calendar.visible	= m_pfe_cst_mdi_menu_contract.m_file.m_display.m_disp_calendar.visible
//	
//	If lm_Menu.m_display.m_disp_default.visible And lm_Menu.m_display.m_disp_treeview.visible And lm_Menu.m_display.m_disp_calendar.visible Then
//		lm_Menu.m_display.visible = True
//	Else
//		lm_Menu.m_display.visible = False
//	End If 
	lm_Menu.m_display.visible = m_pfe_cst_mdi_menu_contract.m_file.m_display.visible
	gnv_app.of_modify_menu_attr( lm_Menu.m_display,'enabled', m_pfe_cst_mdi_menu_contract.m_file.m_display.enabled)
	//End - Added By Mark Lee 10/26/12
	
	lm_Menu.m_refresh.enabled 	= m_pfe_cst_mdi_menu_contract.m_file.m_refresh.enabled
	lm_Menu.m_refresh.visible 		= m_pfe_cst_mdi_menu_contract.m_file.m_refresh.visible 
	lm_Menu.m_output0.m_report.enabled 	= m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.enabled
	lm_Menu.m_output0.m_report.visible 	= m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.visible
	
	If lm_Menu.m_output0.m_report.visible Then
		lm_Menu.m_output0.visible = True
	Else
		lm_Menu.m_output0.visible = False		
	End IF
	lm_Menu.m_autorefresh.enabled 	=	 m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.enabled 
	lm_Menu.m_autorefresh.visible 	= 	m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.visible
	IF lm_Menu.m_autorefresh.visible Then
		gnv_app.of_modify_menu_attr( lm_Menu.m_autorefresh,'checked', m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemdown)
	End IF
	//End - Added By Mark Lee 05/17/12

	
	//If more than one contract record is selected and user right clicks change
	//the label of Email to Default to Batch Email to Default - jervis 05.24.2010
	if ll_SelCnts > 1 then lm_Menu.m_email.text = "Batch Email to Default"

	if This.RowCount() <= 0 or il_ctx_id <= 0 then
		gnv_app.of_modify_menu_attr( lm_Menu.m_copy,'Enabled', false)
		gnv_app.of_modify_menu_attr( lm_Menu.m_email,'Enabled', false)
	end if
end if

//Added By Ken.Guo 10/30/2012
If isvalid(iu_PowerFilter) Then
	gnv_app.of_modify_menu_attr( lm_Menu.m_powerfilter,'Checked', iu_PowerFilter.Checked)
End If

//---------Begin Added by (Appeon)Harry 11.03.2015 for Bug_id#4822--------
if w_mdi.of_security_access( 6984 ) = 0 then
	lm_Menu.m_importemailitem.visible = false
else
	lm_Menu.m_importemailitem.visible = True
end if
//---------End Added ------------------------------------------------------

this.event ue_create_menu_item(lm_Menu)						//Added By Mark Lee 11/21/2012

	
Choose Case is_RightMenuType//added by gavins 20130408
	Case 'm_newctx'
		is_RightMenuType = ''
		lm_Menu.m_new.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())
	Case 'm_copyctx'
		is_RightMenuType = ''
		lm_Menu.m_copy.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())
	Case 'm_usetemplate'
		is_RightMenuType = ''
		lm_Menu.m_usetemplate.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())
	Case Else
		lm_Menu.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())
End Choose

Destroy lm_Menu

end event

event pfc_deleterow;n_cst_contract lnv_contract
long 	ll_row
long	ll_FoundRow

lnv_contract = Create n_cst_contract

if of_check_read_only( ) then 
	If isvalid(lnv_contract) Then Destroy lnv_contract
	return success
End If


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


long ll_ctx_id 

Long ll_record_id //Added By Ken.Guo 03/06/2013

//Move to top
if this.getrow() > 0 then
	ll_ctx_id = this.getitemnumber(this.getrow(),'ctx_id')
	If This.Describe( 'record_id.type') = 'column' Then
		ll_record_id = this.getitemnumber(this.getrow(),'record_id') //Added By Ken.Guo 03/06/2013
	End If
else
	If isvalid(lnv_contract) Then Destroy lnv_contract
	return success
end if
	
if messagebox('Delete Contract', 'Are you sure you want to delete this contract (ID = '+String(ll_ctx_id)+')?~r~n~r~nWARNING! If you proceed, you will delete all data connected to this contract. This operation cannot be undone.',Exclamation!,Yesno!,2) = 1 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.04.2006 By: Liang QingShi
	//$<reason> Contract module modification
	//$<reason> Fix a defect.
	lnv_contract.of_delete_ctx_detail(ll_ctx_id )
	Delete From ctx_basic_info where ctx_id = :ll_ctx_id;

	//Added By Ken.Guo 03/06/2013
	If isvalid(gw_contract)  Then
		If isnull(ll_record_id) Then ll_record_id = 0
		gw_contract.inv_audit.of_audit_fields( ll_ctx_id, 1003, 1001, ll_record_id, '', 'DELETED', 'D')
	End If
	
	//BEGIN---Modify by Scofield on 2010-05-21
	ll_FoundRow = ids_search.Find("ctx_id = " + String(ll_ctx_id),1,ids_search.RowCount())
	if ll_FoundRow > 0 then
		ids_search.DeleteRow(ll_FoundRow)
	end if
	//END---Modify by Scofield on 2010-05-21

	//---------------------------- APPEON END ----------------------------
	
	ll_row = this.GetRow( )
	//Begin - Modified By Ken.Guo 2011-01-29. for multi-delete error.
	//Super::EVENT pfc_deleterow( )
	This.DeleteRow(ll_row)
	//End - Modified By Ken.Guo 2011-01-29
	This.Title = 'Contract Browse (' + string(This.RowCount()) + ')'		//Added by Scofield on 2010-05-21
	
	ll_row --
	if ll_row <= 0 then
		ll_row = 1
	end if
	if this.RowCount() > 0 then
		this.SetRow (ll_row)
		this.ScrollToRow (ll_row)
		this.Selectrow( ll_row,true)
		this.SetFocus()
		if ll_row = 1 then 
			this.event RowFocusChanging(ll_row,ll_row)
			this.event RowFocusChanged(ll_row)
		end if
	end if
		
	
	//iw_parent.function dynamic wf_set_select('tabpage_search',False) 	
	//IW_parent.EVENT DYNAMIC UE_SAVE()
end If


If isvalid(lnv_contract) Then Destroy lnv_contract
if IsValid(w_DashBoard) then w_DashBoard.Of_Refres_All_Tabs()				//Added by Scofield on 2009-08-07


Return SUCCESS

end event

event resize;call super::resize;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.23.2007 By: Jack 
//$<reason> Fix a defect.
If Not isvalid(iw_parent) Then Return

If ii_resiz = 1 Then
	ii_resiz = 0
	ib_resize = True 
Else
	ii_resiz = 0
	ib_resize = False 
End If	
//---------------------------- APPEON END ----------------------------


tv_ctx.y = dw_search_det1.y			
If st_hbar2.visible = False Then
	tv_ctx.height = dw_search_det1.height		 
End If
st_vbar.height = dw_search_det1.height
st_vbar.y = dw_search_det1.y

st_hbar.x = dw_search.x
st_hbar.width = dw_search.width
st_vbar2.height = dw_search_det1.height
st_vbar2.y = dw_search_det1.y

st_hbar2.height		 = ii_border 
st_hbar.height	 	 = ii_border						//resize
st_vbar.width 		 = ii_border
st_vbar2.width  	 = ii_border 

end event

event ue_reset_calendar_flag;call super::ue_reset_calendar_flag;//Added By Ken.Guo 05/18/2012. Should Use Post event to resize the Screen.
il_prezoom = 0
post of_resize()
end event

event ue_afterpowerfilter;call super::ue_afterpowerfilter;//Added By Mark Lee 03/22/2013
//This.Title = '>>>>>>>>>> Contract Browse (' + string(dw_search_det1.rowcount()) + ') <<<<<<<<<<< '
This.Title = gs_left_title_sign +  'Contract Browse (' + string(dw_search_det1.rowcount()) + ')' + gs_right_title_sign
end event

type cbx_1 from checkbox within u_tabpg_contract_search
boolean visible = false
integer x = 46
integer y = 1904
integer width = 613
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Auto Refresh Data"
end type

event clicked;Parent.of_set_auto_refresh( This.Checked)

/*

//--------------------------- APPEON BEGIN ---------------------------
//Added By Alan on 2009-1-14
int	li_autoret

if checked then
	li_autoret = 1
	ib_autoretrieve = true
else
	li_autoret = 0
	ib_autoretrieve = false
end if
update security_users set set_autoret = :li_autoret where user_id = :gs_user_id;
//---------------------------- APPEON END ----------------------------

*/
end event

type cb_5 from commandbutton within u_tabpg_contract_search
boolean visible = false
integer y = 160
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "browse"
end type

event clicked;ClipBoard(dw_search_det1.describe("datawindow.syntax") )
end event

type cb_4 from commandbutton within u_tabpg_contract_search
boolean visible = false
integer y = 264
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "search"
end type

event clicked;ClipBoard(dw_search.describe("datawindow.syntax") )
end event

type st_vbar2 from u_st_splitbar within u_tabpg_contract_search
boolean visible = false
integer x = 1129
integer y = 500
integer width = 18
integer height = 1376
end type

event constructor;call super::constructor;String ls_position,ls_display_contract_parent_child_tree,	ls_to_do_list, ls_display_document_preview

//Display Document Preview
ls_display_document_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview" )
//Contract Parent Child Tree	
ls_display_contract_parent_child_tree = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree" ) 
//The To Do List
ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )	

this.of_Register(dw_search_det1, RIGHT)

If  isnull(is_position_setting) Or trim(is_position_setting) = '' Or  is_position_setting = '1' Then 
	If not isnull(ls_display_document_preview) and ls_display_document_preview = '1' Then 
		this.of_Register(gb_document_view, left)	
	End If
Else
	If not isnull(ls_display_contract_parent_child_tree) and ls_display_contract_parent_child_tree = '1' Then 
		this.of_Register(tv_ctx, left)
	End If
End If

If not isnull(ls_to_do_list) and ls_to_do_list = '1' and not isnull(is_position_setting_other) and is_position_setting_other = '1' Then 
	this.of_Register(gb_to_do_list, left)	
	
	If st_hbar2.visible = True Then 
		this.of_Register(st_hbar2, left)	
	End If
End If

this.of_SetMinobjectsize( 600)				


end event

event lbuttonup;call super::lbuttonup;string ls_display_contract_parent_child_tree,	ls_to_do_list

IF not isnull(is_position_setting_other) and is_position_setting_other = '1' and isvalid(w_todolist_contract)  then 
	w_todolist_contract.of_AdjustSize()
End If

If isvalid(w_tabpg_contract_doc_mgr) Then
	w_tabpg_contract_doc_mgr.of_AdjustSize()
End If

gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_st_vbar2.x",string(this.x  / parent.width ) )

of_register_object('all')		
end event

type st_hbar from u_st_splitbar within u_tabpg_contract_search
integer x = 9
integer y = 480
integer width = 3854
string pointer = "SizeNS!"
end type

event constructor;call super::constructor;String 	ls_ypos

this.of_Register(dw_search, ABOVE)
this.of_Register(dw_search_det1, BELOW)

this.of_SetMinobjectsize( 300)

end event

event lbuttonup;call super::lbuttonup;If isvalid(w_searchpage_calendar) Then
	w_searchpage_calendar.of_AdjustSize()
End If

IF  isvalid(w_todolist_contract)  then 
	w_todolist_contract.of_AdjustSize()
End If

If isvalid(w_tabpg_contract_doc_mgr) Then
	w_tabpg_contract_doc_mgr.of_AdjustSize()
End If

end event

type gb_document_view from groupbox within u_tabpg_contract_search
boolean visible = false
integer x = 37
integer y = 532
integer width = 1047
integer height = 1124
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
end type

type tv_ctx from u_tv within u_tabpg_contract_search
boolean visible = false
integer x = 2793
integer y = 512
integer width = 1038
integer height = 632
integer taborder = 11
integer textsize = -9
integer weight = 700
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
boolean hideselection = false
string picturename[] = {"global.bmp","contract.bmp","Next!","contract_other.bmp","Custom039!","Custom050!"}
end type

event selectionchanged;call super::selectionchanged;Long ll_ctx_id
TreeviewItem ltvi_ctx

tv_ctx.GetItem(newhandle, ltvi_ctx)

ll_ctx_id = Long(ltvi_ctx.data)
Event ue_locate_dw_search(ll_ctx_id)
end event

event doubleclicked;call super::doubleclicked;TreeviewItem ltvi_1
Long ll_ctx_id,ll_find

If handle > 0 Then
	If tv_ctx.GetItem(handle,ltvi_1) = 1 Then
		If ltvi_1.pictureindex <> 2 and ltvi_1.pictureindex <> 3 and ltvi_1.pictureindex <> 4 Then Return  //Group Label
		
		ll_ctx_id = Long(ltvi_1.data)
		ll_find = dw_search_det1.Find('ctx_id = ' + String(ll_ctx_id),1,dw_search_det1.Rowcount())
		If ll_find <= 0 Then

			
			//Modified By Ken.Guo 04/28/2012. Show Browse DW filtered Contract by TreeView.
			//Messagebox('ContractLogix','This contract '+String(ll_ctx_id)+' is not displayed in the Browse screen. Please change your filter criteria to display it first.')
			//Return			
			Messagebox('IntelliSoft','This contract '+String(ll_ctx_id)+' is not currently displayed in the Browse screen, it may be filtered out. ~r~nThe system will display this contract in the Browse screen.' )
			ll_find = Parent.of_move_ctx_to_browsedw( ll_ctx_id )
			If ll_find > 0 Then
				This.event selectionchanged( handle, handle)
			Else
				Messagebox('IntelliSoft','Failed to display this contract. Please change your filter criteria to display it first.')
				Return ll_find
			End If
		End If
		dw_search_det1.post event doubleclicked(0,0,ll_find,dw_search_det1.object )
	End If

End If
end event

event rightclicked;call super::rightclicked;m_contract_tv lm_tv
TreeviewItem tvi_ctx

If handle > 0 Then
	tv_ctx.GetItem(handle,tvi_ctx)
	If tvi_ctx.selectedpictureindex = 3 Then
		tv_ctx.SelectItem(handle)	
	End If
End If

lm_tv = Create m_contract_tv

lm_tv.iuo_parent = Parent
lm_tv.il_ctx_id = il_ctx_id
lm_tv.ib_MulCTX = false

If Parent.inv_ctx_tv.ii_use_group <> 1 Then
	gnv_app.of_modify_menu_attr( lm_tv.m_collapsegroup,'enabled', False)
End If

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( lm_tv.m_new,'Enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_newctx.Enabled)
	lm_tv.m_new.Visible = m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_newctx.ToolbarItemVisible
		
	gnv_app.of_modify_menu_attr( lm_tv.m_copy,'Enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx.Enabled)
	lm_tv.m_copy.Visible = m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_tv.m_email,'Enabled', m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.Enabled)
	lm_tv.m_email.Visible = m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.ToolbarItemVisible
	
	if dw_search_det1.RowCount() <= 0 or il_ctx_id <= 0 then
		gnv_app.of_modify_menu_attr( lm_tv.m_copy,'Enabled', false)
		gnv_app.of_modify_menu_attr( lm_tv.m_email,'Enabled', false)
		gnv_app.of_modify_menu_attr( lm_tv.m_displayallrelatedrecords,'enabled', false)
	end if
end if

If Not lm_tv.m_new.Visible and  Not lm_tv.m_copy.Visible and Not lm_tv.m_email.Visible Then
		lm_tv.m_line1.visible = false
End If

//Added By Ken.Guo 12/12/2011. 
If inv_ctx_tv.is_tv_type = 'row' Then 
	lm_tv.m_displayallrelatedrecords.visible = False
End If

If handle > 0 Then
	If tvi_ctx.selectedpictureindex = 1 or  tvi_ctx.selectedpictureindex = 5 or  tvi_ctx.selectedpictureindex = 6 Then
		gnv_app.of_modify_menu_attr( lm_tv.m_copy,'Enabled', false)
		gnv_app.of_modify_menu_attr( lm_tv.m_email,'Enabled', false)		
		gnv_app.of_modify_menu_attr( lm_tv.m_displayallrelatedrecords,'enabled', false)
	Else
		If dw_search_det1.Find('ctx_id = ' + String(tvi_ctx.data),1,dw_search_det1.Rowcount()) <= 0 Then
			gnv_app.of_modify_menu_attr( lm_tv.m_copy,'Enabled', false)
			gnv_app.of_modify_menu_attr( lm_tv.m_email,'Enabled', false)		
		End If
	End If
End If


PopMenu(lm_tv,w_mdi.PointerX() ,w_mdi.PointerY())
end event

type gb_to_do_list from groupbox within u_tabpg_contract_search
boolean visible = false
integer x = 2793
integer y = 1188
integer width = 1029
integer height = 588
integer taborder = 21
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_vbar from u_st_splitbar within u_tabpg_contract_search
boolean visible = false
integer x = 2766
integer y = 500
integer width = 18
integer height = 1376
integer weight = 700
fontcharset fontcharset = ansi!
long bordercolor = 255
end type

event constructor;call super::constructor;String 		ls_display_contract_parent_child_tree,	ls_to_do_list, 	ls_display_document_preview

//Contract Parent Child Tree	
ls_display_contract_parent_child_tree = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree" ) 

//Display Document Preview
ls_display_document_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview" )

//The To Do List
ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )

this.of_Register(dw_search_det1, LEFT)

If  isnull(is_position_setting) Or trim(is_position_setting) = '' Or  is_position_setting = '1' Then 
	If Not isnull(ls_display_contract_parent_child_tree) and ls_display_contract_parent_child_tree = '1' Then 
		this.of_Register(tv_ctx, RIGHT)
	End If
Else
	If Not isnull(ls_display_document_preview) and ls_display_document_preview = '1' Then 
		this.of_Register(gb_document_view, RIGHT)
	End If
End If

If Not isnull(ls_to_do_list) and ls_to_do_list = '1' and  Not isnull(is_position_setting_other) and is_position_setting_other = '0'  Then 
	this.of_Register(gb_to_do_list, RIGHT)
	
	If st_hbar2.visible = True Then 
		this.of_Register(st_hbar2, RIGHT)
	End If 
End If

this.of_SetMinobjectsize( 600)			

end event

event lbuttonup;call super::lbuttonup;
IF not isnull(is_position_setting_other) and is_position_setting_other = '0' and isvalid(w_todolist_contract)  then 
	w_todolist_contract.of_AdjustSize()
End If
	
If not isnull(is_position_setting) and is_position_setting = '0'  and isvalid(w_tabpg_contract_doc_mgr) Then 
	w_tabpg_contract_doc_mgr.of_AdjustSize()
End If 

gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_st_vbar.x",string(this.x  / parent.width ) )

of_register_object('all')			
end event

type st_hbar2 from u_st_splitbar within u_tabpg_contract_search
boolean visible = false
integer x = 2779
integer y = 1160
integer width = 1061
string pointer = "SizeNS!"
end type

event constructor;call super::constructor;String 	ls_ypos

this.of_Register(tv_ctx, ABOVE)
this.of_Register(gb_to_do_list, BELOW)


this.of_SetMinobjectsize( 300)

end event

event lbuttonup;call super::lbuttonup;
If isvalid(w_todolist_contract) Then
	w_todolist_contract.of_AdjustSize()
End If

is_hbar2 = string(this.y  / parent.height ) 				//Added By Mark Lee 03/27/2013
gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_st_hbar2.y",string(this.y  / parent.height ) )
end event

