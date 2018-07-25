$PBExportHeader$u_cst_dw_design.sru
forward
global type u_cst_dw_design from userobject
end type
type pb_view from picturebutton within u_cst_dw_design
end type
type st_2 from statictext within u_cst_dw_design
end type
type dw_view from datawindow within u_cst_dw_design
end type
type dw_properties_oval from u_dw within u_cst_dw_design
end type
type dw_properties_text from u_dw within u_cst_dw_design
end type
type dw_properties_dw from u_dw within u_cst_dw_design
end type
type uo_select from u_contract_select_screen within u_cst_dw_design
end type
type st_add from statictext within u_cst_dw_design
end type
type st_1 from statictext within u_cst_dw_design
end type
type uo_design from u_cst_dw_design_menu within u_cst_dw_design
end type
type dw_fields_alias from datawindow within u_cst_dw_design
end type
type cb_screen_properties from u_cb within u_cst_dw_design
end type
type st_tab from statictext within u_cst_dw_design
end type
type dw_select_section from u_dw within u_cst_dw_design
end type
type dw_properties from u_dw within u_cst_dw_design
end type
type st_back from statictext within u_cst_dw_design
end type
type uo_band from u_cst_dw_band_painter within u_cst_dw_design
end type
type st_right from statictext within u_cst_dw_design
end type
type r_1 from rectangle within u_cst_dw_design
end type
end forward

global type u_cst_dw_design from userobject
integer width = 4690
integer height = 1968
boolean border = true
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_new_screen_painter ( )
event type integer pfc_cst_select_view ( )
event ue_field_properties ( )
event pfc_cst_sort ( )
event ue_properties ( )
event ue_closecontract ( )
event ue_opencontract ( )
event ue_refreshcontract ( )
event type string ue_setmodify ( string as_modify )
event ue_new ( string as_objtype )
event key pbm_keydown
event type integer ue_arrange ( string as_type )
event type integer ue_modify ( string as_modifytype )
event ue_rbuttondown ( )
event ue_resize pbm_size
event type integer ue_selectmultiobject ( string as_type,  u_cst_dw_band adw_band,  string as_name )
event ue_field_depend ( )
event ue_creategroup ( )
event type long ue_resize_01 ( unsignedlong sizetype,  integer newwidth,  integer newheight )
event ue_deletegroup ( )
event ue_groupproperty ( )
pb_view pb_view
st_2 st_2
dw_view dw_view
dw_properties_oval dw_properties_oval
dw_properties_text dw_properties_text
dw_properties_dw dw_properties_dw
uo_select uo_select
st_add st_add
st_1 st_1
uo_design uo_design
dw_fields_alias dw_fields_alias
cb_screen_properties cb_screen_properties
st_tab st_tab
dw_select_section dw_select_section
dw_properties dw_properties
st_back st_back
uo_band uo_band
st_right st_right
r_1 r_1
end type
global u_cst_dw_design u_cst_dw_design

type variables
w_contract_data_design parent_window_design

DataStore	ids_SearchTemp,ids_SearchDevTemp
DataStore	ids_Criteria,ids_Browse

String	is_UnDoList[50],is_EmptyList[50]
long		il_CurUnDoNo

long		il_CurVisibleNo

Integer ii_screen_id

Integer il_dw_style = 0
Long il_data_view = 1001

Boolean ib_screen_painter = True
Boolean ib_setup_dddw = True
Boolean ib_refresh_screen_list = False
Boolean ib_HasNewModify = false
Boolean ib_AlwaysUpdate = false

String 	is_tab_label_names[]
String 	is_last_tab_label_name
String 	is_last_object[]
String 	is_OriTextName

Boolean ib_resize_width = False
Boolean ib_resize_height = False
Boolean ib_mouse_down
Boolean ib_multi_select = False
Boolean ib_control_down = False
Boolean ib_relocating_fields = False
Boolean ib_set_tab_order = False
Boolean ib_show_invisible = True

m_screen_design_rmb_rpt  im_DesignMenu

Integer ii_obj_select_cnt = 0

Long il_last_object_width[]
Long il_last_object_height[]
Long il_ancor_x
Long il_ancor_y
Long il_data_view_id = 1
Long il_last_object_x[]
Long il_last_object_y[]

long il_x2
long il_select_view
boolean ib_clicked 
string is_button_object[],is_button_visible[]      //Add by Jack 06/12/1007

DataStore ids_screen 			// Add by Evan 07/14/2008
long il_CurrentScreenHandle 	// Add by Evan 09/27/2008

long	il_CurCtxID					//Added by Scofield on 2009-01-13

//add by gavin on 2009/3/4
str_Selectobj_rpt	istr_SelectObj[]
Datawindow idw_original
Boolean ib_show_treeview = True 
Boolean ib_show_datagroup = False
Boolean ib_PreparCopying = False
Boolean ib_PreparVisible = False
boolean ib_cut = false
Boolean ib_disable_activate = false
Boolean ib_RetrieveStatus
String  is_OrgSyntax
String  is_addobjectType
String  is_curselectobj
string  is_CopySyntax[],is_FieldSyntax[],is_Border[]
string  is_CurBand,is_orgband
String  is_sql_syntax
String  is_open_style
long	  il_FirstSelectColor=15793151
long    ii_data_view
// end by gavin on 2009/3/4

boolean ib_IsAddSummary = false // even 10.08.2010
boolean ib_DoSave = false // even 10.11.2010
boolean ib_max = false //(Appeon)Stephen 08.29.2017 - Bug id 5780 - IntelliReport Advanced Screen Design Maximized SaaS 15.3 Build 08092017, 08152017, C/S 08102017

CONSTANT STRING ENTERCHAR = "~r~n"
CONSTANT STRING LISTSEPARATECHAR = ","

String	is_LastSelObjList = LISTSEPARATECHAR
String	is_Compute_Label_Name,is_Compute_Label_Text

datastore ids_field_depend

datastore ids_pic	//jervis 11.23.2009
n_cst_filesrv inv_filesrv  //jervis 11.23.2009
CONSTANT String is_pic_path = 'Bitmap'
private:
boolean ib_header = false
boolean ib_detail = false
boolean ib_summary = false
boolean ib_footer = false

Boolean ib_gb_sendtoback = False //'Send groupbox to back' flag, Added by Appeon long.zhang 05.16.2016 (Bug id 5146 - Some Computed fields not saving in PDF document)
end variables

forward prototypes
public function integer of_show_invisible (boolean ab_show)
public function integer of_setup_painter ()
public function integer of_set_display_only ()
public function integer of_set_tab_order (boolean ab_status)
public function integer of_select_screen (integer currentrow, integer ai_screen_id)
public function integer of_select_view ()
public function integer of_set_parent_window (window aw_win)
public function integer of_retrieve_dw_properties (datawindow adw_detail)
public function integer of_save ()
public function integer of_adjust_width (integer ai_width)
public function integer of_adjust_position (integer ai_position)
public subroutine of_restore_properties (datawindow adw_target)
public function integer of_expression_sheet ()
public function integer of_create_dynamic_dw (integer ai_screen_id)
public function integer of_field_property_sheet ()
public function integer of_dw_property_sheet ()
public function integer of_modifydwproperties (string as_property)
public function integer of_text_property_sheet (string as_object)
public function long of_getcurrentscreenhandle ()
public function integer of_changescreenlable ()
public function integer of_oval_property_sheet (string as_object)
public function integer of_init (window aw_parent, string as_style)
public function integer of_save_report ()
public function integer of_select_report ()
public function integer of_set_datagroup (boolean ab_group)
public function integer wf_addobject (string as_objtype, long al_x, long al_y)
public function boolean of_get_datagroup ()
public function u_cst_dw_band wf_getband (string as_band)
public function long wf_isselected (string as_name)
public function integer wf_makeband (string as_syntax)
public function integer wf_preparecopy (u_cst_dw_band adw_band)
public function integer of_multiselectobjects (keycode key, unsignedlong keyflags)
public function integer wf_copyobject (u_cst_dw_band adw_band)
public function integer of_init (window aw_parent, string as_style, datawindow adw_original, long al_data_view)
public function integer of_set_isshowtree (boolean ad_switch)
public function integer of_sort_sqldata ()
public subroutine of_refreshmarkpos ()
public subroutine of_unselectallobject ()
public subroutine of_moveselectedobject (long al_diff_x, long al_diff_y)
public function long of_getselectedobjectcnts ()
public function string of_getlastselectedobject ()
public subroutine of_getselectedobjectinformation (string as_objname, ref string as_objtype, ref long al_x, ref long al_y, ref long al_width, ref long al_height)
public function boolean of_isselected (string as_objname, ref long al_pos)
public function string of_getselectedobjecttype (string as_objname)
public function string of_getselectedobjecttag (string as_objname)
public function string of_getselectedobjectid (string as_objname)
public function long of_getclipboardobjcnts ()
public subroutine of_getselectedobjectattr (string as_objname, ref string as_bold, ref string as_italic, ref string as_underline, ref string as_align)
public subroutine of_updatelastselobjlist (long al_index, boolean ab_add)
public subroutine of_selectall (boolean ab_allband)
public subroutine of_resizeselectedobject (long al_diff_x, long al_diff_y)
public subroutine of_refresh_object_inforamtion ()
public function string of_get_invisible_field ()
public function integer wf_addinvisiblefield (string as_objtype, long al_x, long al_y)
public function integer wf_pickupfieldsyntax (string as_field_list)
public subroutine of_modify_column_property (string as_property_name, string as_property_value)
public function integer of_select_view (long al_view_id, string as_view_name, long al_screen_id)
public subroutine of_savetoundolist (string as_modify)
public subroutine of_undo ()
public function string of_setmodify (string as_modify)
public function string of_getdwobjsyntax (string as_dwsyntax, string as_objname)
public function integer of_set_depend (ref datastore ads_depend)
public function string of_getscreensyntax (long al_screen_id)
public function long of_setscreensyntax (long al_screen_id, string as_syntax)
public subroutine of_autoupdatesearchscreen (string as_objname)
public subroutine of_download_pic (long al_pic_id, string as_filename)
public subroutine of_upload_pic ()
public subroutine of_delete_pic (string as_name, boolean ab_cut)
public function integer of_picture_property_sheet (string as_object)
public function integer of_set_dw_properties (string as_object_name, integer ai_flag)
public function integer wf_makeband_01 (string as_syntax)
public function integer wf_setbandtext (integer ai_bandindex)
public function integer of_replace (ref string as_syntax, string as_find, string as_replace)
public function integer wf_movecolumnband (ref string as_dwsyntax, string as_object, string as_band, integer ai_ypos)
public subroutine of_getselectedobject_fontsize (string as_objname, ref string as_size)
public function integer of_sendtoback (u_dw adw_band, string as_name, string as_band)
public function integer of_set_gb_sendtoback (boolean ab_switch)
end prototypes

event pfc_cst_new_screen_painter();//Open( w_new_screen_painter )

end event

event type integer pfc_cst_select_view();//Return of_select_view() // Modify by Evan 01/10/2008

//modify by gavin on 2009/2/26
if lower(is_open_style) = 'screen' then
	// Modify by Evan 01/10/2008
   Return of_select_view() 
elseif lower(is_open_style) = 'report' then
	Return of_select_report()
end if
end event

event ue_field_properties();//of_property_sheet() //Delete by Evan 07/24/2008
end event

event pfc_cst_sort();//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-08 By: Andy
string ls_sort
setnull(ls_sort)
uo_band.dw_syntax.of_setsort( true)
uo_band.dw_syntax.inv_sort.of_SetUseDisplay(true)
uo_band.dw_syntax.inv_sort.of_setstyle(uo_band.dw_syntax.inv_sort.APPEONDRAGDROP)
uo_band.dw_syntax.inv_sort.of_setsort(ls_sort)
if is_open_style = 'screen' then
   of_save()
elseif is_open_style = 'report' then
	of_save_report()
else
	//
end if
//---------------------------- APPEON END ----------------------------


end event

event ue_properties();String 	ls_ObjName,ls_Type,ls_Edit_Style,ls_ProValue
long		ll_Cycle,ll_SelObjCnts

String	ls_Visible,ls_label_border
String	ls_Fields_border,ls_Fields_Required,ls_Fields_display_only,ls_fields_vscrollbar
long		ll_label_textcolor,ll_label_textbkcolor,ll_label_justification
long		ll_Fields_justification

Boolean	ib_IsExist
//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
//$Reason:
  /*
     str_FieldProperty	lstr_Property 
  */
 str_FieldProperty_rpt	lstr_Property
//---------End Modfiied ------------------------------------------------------------------

//user security :Screen Painter - Contract Field Properties
if IsValid(w_mdi) then
	if w_mdi.of_security_access(5320) = 0 then Return
end if

if IsValid(m_pfe_cst_contract_data_design) then
	if m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = false then Return
end if

// Open properties window
ll_SelObjCnts = of_GetSelectedObjectCnts()

//BEGIN---Modify by Scofield on 2009-08-18
if ll_SelObjCnts > 1 then
	for ll_Cycle = 1 to ll_SelObjCnts
		ls_ObjName = istr_SelectObj[ll_Cycle].FName
		if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then CONTINUE
		
		ls_Type = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Type")
		if ls_Type <> "column" and ls_Type <> "text" then CONTINUE
		
		ib_IsExist = true
		
		if Not IsNull(lstr_Property.Field_Visible) then
			if ls_Type = "column" then
				ls_ProValue = uo_band.dw_Syntax.Describe(ls_ObjName + ".Visible")
				if lstr_Property.Field_Visible = "" then
					lstr_Property.Field_Visible = ls_ProValue
				elseif lstr_Property.Field_Visible <> ls_ProValue then
					SetNull(lstr_Property.Field_Visible)
				end if
			end if
		end if
		
		if Not IsNull(lstr_Property.Label_Color) then
			if ls_Type = "column" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "_t.Color")
			else
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Color")
			end if
			
			if lstr_Property.Label_Color = "" then
				lstr_Property.Label_Color = ls_ProValue
			elseif lstr_Property.Label_Color <> ls_ProValue then
				SetNull(lstr_Property.Label_Color)
			end if
		end if

		if Not IsNull(lstr_Property.Label_BkColor) then
			if ls_Type = "column" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "_t.Background.Color")
			else
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Background.Color")
			end if
			
			if lstr_Property.Label_BkColor = "" then
				lstr_Property.Label_BkColor = ls_ProValue
			elseif lstr_Property.Label_BkColor <> ls_ProValue then
				SetNull(lstr_Property.Label_BkColor)
			end if
		end if

		if Not IsNull(lstr_Property.Label_Alignment) then
			if ls_Type = "column" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "_t.Alignment")
			else
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Alignment")
			end if
			
			if lstr_Property.Label_Alignment = "" then
				lstr_Property.Label_Alignment = ls_ProValue
			elseif lstr_Property.Label_Alignment <> ls_ProValue then
				SetNull(lstr_Property.Label_Alignment)
			end if
		end if

		if Not IsNull(lstr_Property.Label_Border) then
			if ls_Type = "column" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "_t.Border")
			else
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Border")
			end if
			
			if lstr_Property.Label_Border = "" then
				lstr_Property.Label_Border = ls_ProValue
			elseif lstr_Property.Label_Border <> ls_ProValue then
				SetNull(lstr_Property.Label_Border)
			end if
		end if
		
		if ls_Type <> "column" then CONTINUE
		
		ls_Edit_Style = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Edit.Style")
		
		if Not IsNull(lstr_Property.Field_Required) then
			ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "." + ls_Edit_Style + ".Required")
			
			if lstr_Property.Field_Required = "" then
				lstr_Property.Field_Required = ls_ProValue
			elseif lstr_Property.Field_Required <> ls_ProValue then
				SetNull(lstr_Property.Field_Required)
			end if
		end if
		
		if Not IsNull(lstr_Property.Field_Mask) then
			if ls_Edit_Style = "editmask" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "." + ls_Edit_Style + ".Mask")
				
				if lstr_Property.Field_Mask = "" then
					lstr_Property.Field_Mask = ls_ProValue
				elseif lstr_Property.Field_Mask <> ls_ProValue then
					SetNull(lstr_Property.Field_Mask)
				end if
			else
				SetNull(lstr_Property.Field_Mask)
			end if
		end if

		if Not IsNull(lstr_Property.Field_Alignment) then
			ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Alignment")
			
			if lstr_Property.Field_Alignment = "" then
				lstr_Property.Field_Alignment = ls_ProValue
			elseif lstr_Property.Field_Alignment <> ls_ProValue then
				SetNull(lstr_Property.Field_Alignment)
			end if
		end if

		if Not IsNull(lstr_Property.Field_display_only) then
			if ls_Edit_Style = "edit" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "." + ls_Edit_Style + ".DisplayOnly")
				
				if lstr_Property.Field_display_only = "" then
					lstr_Property.Field_display_only = ls_ProValue
				elseif lstr_Property.Field_display_only <> ls_ProValue then
					SetNull(lstr_Property.Field_display_only)
				end if
			else
				SetNull(lstr_Property.Field_display_only)
			end if
		end if

		if Not IsNull(lstr_Property.Field_Color) then
			ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Color")
			
			if lstr_Property.Field_Color = "" then
				lstr_Property.Field_Color = ls_ProValue
			elseif lstr_Property.Field_Color <> ls_ProValue then
				SetNull(lstr_Property.Field_Color)
			end if
		end if
		
		if Not IsNull(lstr_Property.Field_BKColor) then
			ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Background.Color")
			
			if lstr_Property.Field_BKColor = "" then
				lstr_Property.Field_BKColor = ls_ProValue
			elseif lstr_Property.Field_BKColor <> ls_ProValue then
				SetNull(lstr_Property.Field_BKColor)
			end if
		end if
		
		if Not IsNull(lstr_Property.Field_Border) then
			ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Border")
			
			if lstr_Property.Field_Border = "" then
				lstr_Property.Field_Border = ls_ProValue
			elseif lstr_Property.Field_Border <> ls_ProValue then
				SetNull(lstr_Property.Field_Border)
			end if
		end if

		if Not IsNull(lstr_Property.Field_Word_Wrap) then
			if ls_Edit_Style = "edit" or ls_Edit_Style = "dddw" or ls_Edit_Style = "ddlb" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "." + ls_Edit_Style + ".VScrollBar")
				
				if lstr_Property.Field_Word_Wrap = "" then
					lstr_Property.Field_Word_Wrap = ls_ProValue
				elseif lstr_Property.Field_Word_Wrap <> ls_ProValue then
					SetNull(lstr_Property.Field_Word_Wrap)
				end if
			else
				SetNull(lstr_Property.Field_Word_Wrap)
			end if
		end if
	next
	
	if Not ib_IsExist then Return
	
	if Trim(lstr_Property.Field_Visible) = "" then SetNull(lstr_Property.Field_Visible)
	if Trim(lstr_Property.Label_Color) = "" then SetNull(lstr_Property.Label_Color)
	if Trim(lstr_Property.Label_BkColor) = "" then SetNull(lstr_Property.Label_BkColor)
	if Trim(lstr_Property.Label_Alignment) = "" then SetNull(lstr_Property.Label_Alignment)
	if Trim(lstr_Property.Label_Border) = "" then SetNull(lstr_Property.Label_Border)
	if Trim(lstr_Property.Field_Required) = "" then SetNull(lstr_Property.Field_Required)
	if Trim(lstr_Property.Field_Mask) = "" then SetNull(lstr_Property.Field_Mask)
	if Trim(lstr_Property.Field_Alignment) = "" then SetNull(lstr_Property.Field_Alignment)
	if Trim(lstr_Property.Field_display_only) = "" then SetNull(lstr_Property.Field_display_only)
	if Trim(lstr_Property.Field_Border) = "" then SetNull(lstr_Property.Field_Border)
	if Trim(lstr_Property.Field_Word_Wrap) = "" then SetNull(lstr_Property.Field_Word_Wrap)

	lstr_Property.data_design = This
	
	OpenWithParm(w_intellicred_mul_field_properties,lstr_Property)

//END---Modify by Scofield on 2009-08-18
else
	if ll_SelObjCnts = 0 then
		//Dispaly view properties or screen properties dialog -- jervis 10.15.2009
		//of_dw_property_sheet()
		uo_select.event ue_rightclicked(uo_select.tv_screen.il_currenthandle )
	else
		ls_ObjName = of_GetLastSelectedObject()
		ls_Type = of_GetSelectedObjectType(ls_ObjName)
		choose case ls_Type
			case "text"
				of_text_property_sheet(ls_ObjName)
			case "column", "compute"
				of_field_property_sheet()
			case "ellipse"
				of_oval_property_sheet(ls_ObjName)		//Added by Scofield on 2009-02-25
			case 'bitmap'
				of_picture_property_sheet(ls_objname)  //Add by jervis 11.30.2009
		end choose
	end if
end if

end event

event ue_closecontract();//====================================================================
// Function: ue_closecontract.u_cst_dw_design()
//--------------------------------------------------------------------
// Description: Back the last selected tagpage
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 08.31.2010
//$<reason> V10.5-Advanced Report
/*
long	ll_Row,ll_RowCnt

DataWindow	ldw_Search,ldw_SearDt

il_CurCtxID = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
gw_Contract.of_BackupFocusObject(gw_Contract.Control[])

ldw_Search = gw_contract.tab_contract_details.tabpage_search.dw_search
ldw_SearDt = gw_contract.tab_contract_details.tabpage_search.dw_search_det1

ids_SearchTemp.DataObject = ldw_Search.DataObject
ids_SearchDevTemp.DataObject = ldw_SearDt.DataObject

ldw_Search.RowsCopy(1,ldw_Search.RowCount(),Primary!,ids_SearchTemp,1,Primary!)
ldw_SearDt.RowsCopy(1,ldw_SearDt.RowCount(),Primary!,ids_SearchDevTemp,1,Primary!)

ib_RetrieveStatus = gw_Contract.tab_contract_details.tabpage_search.ib_AutoRetrieve
gw_Contract.tab_contract_details.tabpage_search.ib_AutoRetrieve = false

gw_Contract.TriggerEvent("pfc_close")
*/
//------------------- APPEON END ---------------------

end event

event ue_opencontract();//====================================================================
// Function: ue_opencontract.u_cst_dw_design()
//--------------------------------------------------------------------
// Description: Restore select the last selected tabpage
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 08.31.2010
//$<reason> V10.5-Advanced Report
/*
long	ll_Row,ll_RowCnt

DataWindow	ldw_Search,ldw_SearDt

SetPointer(HourGlass!)
gw_Contract.SetRedraw( false)

ldw_Search = gw_contract.tab_contract_details.tabpage_search.dw_search
ldw_SearDt = gw_contract.tab_contract_details.tabpage_search.dw_search_det1

ldw_Search.Reset()
ids_SearchTemp.RowsCopy(1,ids_SearchTemp.RowCount(),Primary!,ldw_Search,1,Primary!)
ids_SearchDevTemp.RowsCopy(1,ids_SearchDevTemp.RowCount(),Primary!,ldw_SearDt,1,Primary!)

gw_Contract.tab_contract_details.tabpage_search.cbx_1.Checked = ib_RetrieveStatus
gw_Contract.tab_contract_details.tabpage_search.ib_autoretrieve = ib_RetrieveStatus
gw_contract.tab_contract_details.tabpage_search.ib_retrieve = true

ll_RowCnt = ldw_SearDt.RowCount()
ll_Row = ldw_SearDt.Find("ctx_id = " + String(il_CurCtxID),1,ll_RowCnt)
if ll_Row > 0 then
	ldw_SearDt.ScrollToRow(ll_Row)
	ldw_SearDt.SetRow(ll_Row)
	ldw_SearDt.Event RowFocusChanging(ll_Row,ll_Row)
	ldw_SearDt.Event RowFocusChanged(ll_Row)
end if

gw_Contract.of_RestoreFocusObject(gw_Contract.Control[])


SetPointer(Arrow!)
gw_Contract.SetRedraw( true)

il_CurCtxID = 0
*/
//------------------- APPEON END ---------------------
end event

event ue_refreshcontract();//====================================================================
// Function: ue_refreshcontract.u_cst_dw_design()
//--------------------------------------------------------------------
// Description: Refresh the contract folder
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if IsValid(gw_Contract) then
	PowerObject lpo_NullParm
	
	SetPointer(HourGlass!)
	gw_Contract.SetRedraw( false)
	Trigger Event ue_CloseContract()
	
	gf_OpenContractFolder(lpo_NullParm)
	
	Post Event ue_OpenContract()
end if

end event

event type string ue_setmodify(string as_modify);String  ls_Error

//of_SaveToUndoList(as_Modify)

ls_Error = uo_band.dw_Syntax.Modify(as_Modify)

//BEGIN---Modify by Scofield on 2010-02-23
if IsValid(m_pfe_cst_contract_data_design) then
	m_pfe_cst_contract_data_design.m_file.m_save.Enabled = true
end if
//END---Modify by Scofield on 2010-02-23

Return ls_Error

end event

event ue_new(string as_objtype);long		ll_Pos
String	ls_Type

CONSTANT STRING NEWOBJTYPETIP = "Click where you want to add the "

if ib_Set_Tab_Order then Return

st_add.Width = uo_band.Width - 100
st_add.X = uo_band.X
st_add.Y = this.Height - 200//1808
st_add.TextSize = -10

ll_Pos = PosA(as_ObjType," ")
if ll_Pos > 0 then
	as_ObjType = LeftA(as_ObjType,ll_Pos - 1)
	
	ls_Type = uo_Band.dw_Syntax.Describe(as_ObjType + ".Type")
	if Upper(ls_Type) = Upper("Column") then
		st_add.Text = NEWOBJTYPETIP + as_ObjType + " Column"
	elseif Upper(ls_Type) = Upper("Text") then
		st_add.Text = NEWOBJTYPETIP + as_ObjType + " Label"
	elseif Upper(ls_Type) = Upper("Button") then
		st_add.Text = NEWOBJTYPETIP + as_ObjType + " Button"
	elseif upper(ls_type) = Upper("picture") then	//Add by jervis 11.20.2009
		st_add.Text = NEWOBJTYPETIP + as_ObjType + " Picture"
	else
		st_add.Text = NEWOBJTYPETIP + as_ObjType + " object"
	end if
else
	st_add.Text = NEWOBJTYPETIP + as_ObjType + " object"
end if

st_add.Visible = true

is_addobjectType = as_ObjType

end event

event key;//====================================================================
// Event: key()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    keycode         key
// 	value    unsignedlong    keyflags	0:none,1:shift key,2:ctrl key,3:shift&ctrl key
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cnts,ll_UnitX,ll_UnitY,ll_Diff_X,ll_Diff_Y

if KeyFlags >= 2 then
	if KeyFlags = 3 and Key = KeyA! then
		of_SelectAll(false)
	else
		of_MultiSelectObjects(key,keyflags)
	end if
	Return
end if

ll_Cnts = of_GetSelectedObjectCnts()
if ll_Cnts <= 0 then Return

ll_UnitX = PixelsToUnits(1,XPixelsToUnits!) 
ll_UnitY = PixelsToUnits(1,YPixelsToUnits!)

Choose Case key 
	Case KeyLeftArrow!
		ll_Diff_X = -ll_UnitX
	Case KeyRightArrow!
		ll_Diff_X = ll_UnitX
	Case KeyUpArrow!
		ll_Diff_Y = -ll_UnitY
	Case KeyDownArrow!
		ll_Diff_Y = ll_UnitY
	Case else
		Return
End Choose

if keyflags = 0 then
	of_MoveSelectedObject(ll_Diff_X,ll_Diff_Y)
elseif keyflags = 1 then
	of_ResizeSelectedObject(ll_Diff_X,ll_Diff_Y)
end if

of_Refresh_Object_Inforamtion()

end event

event type integer ue_arrange(string as_type);//---------------------------------------------------
//Event:  ue_arrange
//parm :  String   as_type
//return: integer

long   ll_TotalCnts,ll_SelObjCnts,ll_Cycle
long  ll_x,ll_y,ll_Width,ll_Height,ll_temp,ll_Bottom
String  ls_Modify,ls_band
long ll_linex1,ll_linex2,ll_liney1,ll_liney2

str_SelectObj_Rpt   lstr_temp[]

ll_SelObjCnts = of_GetSelectedObjectCnts()
if ll_SelObjCnts <= 0 then Return -1

ll_TotalCnts = Upperbound(istr_SelectObj)
ll_SelObjCnts = 0

for ll_Cycle = 1  to ll_TotalCnts
	if istr_SelectObj[ll_Cycle].FName <> '' THEN
		ll_SelObjCnts++
		lstr_temp[ll_SelObjCnts] = istr_SelectObj[ll_Cycle]
	end if
next

ll_TotalCnts = UpperBound(lstr_temp)
if ll_TotalCnts < 2 then Return -1

CHOOSE CASE lower(as_type)
	CASE 'snap_to_left' 
		IF uo_band.dw_syntax.Describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_x = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".x"))
		else
			ll_x = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".x1"))
		end if
		FOR ll_Cycle = 2 TO ll_TotalCnts
			IF uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll_Cycle].FName + ".x=" + String(ll_x)
			else
				ll_linex1 = long(uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".x1"))
				ll_linex2 = long(uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".x2")) - (ll_linex1 - ll_x)
				
				ls_Modify = lstr_temp[ll_Cycle].FName + ".x1=" + String(ll_x)
				ls_Modify += "~t" + lstr_temp[ll_Cycle].FName + ".x2=" + String(ll_linex2)
			end if
			lstr_temp[ll_Cycle].FBand.Modify(ls_Modify)
			this.Event ue_SetModify(ls_Modify)
		NEXT
	CASE 'snap_to_top'
		IF uo_band.dw_syntax.Describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_y = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".y"))
		else
			ll_y = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".y1"))
		end if
		
		ls_band = uo_band.dw_syntax.Describe(lstr_temp[1].FName+".band")
		FOR ll_Cycle = 2 TO ll_TotalCnts
			if uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".band") <> ls_band then continue 
			IF uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll_Cycle].FName+".y=" + String(ll_y)
			else
				ll_liney1 = long(uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".y1"))
				ll_liney2 = long(uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".y2")) - (ll_liney1 - ll_y)
				ls_Modify = lstr_temp[ll_Cycle].FName+".y1=" + String(ll_y)
				ls_Modify +="~t" + lstr_temp[ll_Cycle].FName+".y2=" + String(ll_liney2)
			end if
			
			lstr_temp[ll_Cycle].FBand.Modify(ls_Modify)
			this.Event ue_SetModify(ls_Modify)
		NEXT
	CASE 'same_height'
		IF uo_band.dw_syntax.Describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_temp = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".height"))
		else
			ll_temp = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".y2")) - long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".y1"))

		end if
		FOR ll_Cycle = 2 TO ll_TotalCnts
			IF uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll_Cycle].FName+".height=" + String(ll_temp)
			else
				ls_Modify = lstr_temp[ll_Cycle].FName+".y2=" + String(long(uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".y1")) + ll_temp)
			end if
			lstr_temp[ll_Cycle].FBand.Modify(ls_Modify)
			this.Event ue_SetModify(ls_Modify)
		NEXT

	CASE 'same_width'
		IF uo_band.dw_syntax.Describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_temp = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".width"))
		else
			ll_temp = long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".x2")) - long(uo_band.dw_syntax.Describe(lstr_temp[1].FName+".x1"))
		end if
		FOR ll_Cycle = 2 TO ll_TotalCnts
			IF uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll_Cycle].FName+".width=" + String(ll_temp)
			else
				ls_Modify = lstr_temp[ll_Cycle].FName+".x2=" + String(long(uo_band.dw_syntax.Describe(lstr_temp[ll_Cycle].FName+".x1")) + ll_temp)
			end if
			lstr_temp[ll_Cycle].FBand.Modify(ls_Modify)
			this.Event ue_SetModify(ls_Modify)
		NEXT
	CASE ELSE
END CHOOSE	

of_RefreshMarkPos()			//Added by Scofield on 2009-04-13

Return 1

end event

event type integer ue_modify(string as_modifytype);//====================================================================
// Event: ue_modify()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_modifytype
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: 2007-11-05
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History: Scofield 2009-04-13
//
//====================================================================

String  	ls_Name,ls_ObjName
long  	ll_TotalCnts,ll_ObjSelCnts,ll_Result,ll_NotDelCnts
long  	ll_Cycle,ll_Index,ll_Cnt,ll_RtnVal = 1

u_cst_dw_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

ls_Name = ldw_band.is_CurObj
ll_TotalCnts = UpperBound(istr_SelectObj[])
ll_ObjSelCnts = of_GetSelectedObjectCnts()

CHOOSE CASE as_ModifyType
	CASE 'delete'
		if ll_ObjSelCnts > 0 then
			ll_Result = MessageBox("Confirm Object Delete","Are you sure you want to delete the selected object?",Question!,YesNo!,2)
			if ll_Result = 1 then
				for ll_Cycle = 1 to ll_TotalCnts
					ldw_band = istr_SelectObj[ll_Cycle].Fband
					ls_Name = istr_SelectObj[ll_Cycle].Fname
					if IsNull(ls_Name) or Trim(ls_Name) = '' THEN CONTINUE
	
					if PosA(lower(ls_Name),"object") > 0 or PosA(lower(ls_Name),"group") > 0 then //Evan 11.22.2010
						of_delete_pic(lower(ls_name),false) //Delete Picture File From Database -- Jervis 11.23.2009
						ldw_band.Modify("destroy " + ls_Name)
						This.Event ue_SetModify("destroy " + ls_Name)
						
						ldw_band.of_AddorDelSingleSelect(ls_Name,false)
									
						//Clear the object in the is_Objects[]
						ll_Cnt = UpperBound(ldw_band.is_Objects)
						for ll_Index = 1 to ll_Cnt
							if ldw_band.is_Objects[ll_Index] = ls_Name then 
								ldw_band.is_Objects[ll_Index] = ""
								exit
							end if
						next
					else
						ll_NotDelCnts++
					end if					
				next
			
				ldw_band.is_CurObj = ""
				
				if ll_NotDelCnts > 0 then
					MessageBox("Clear Error", "You can't delete field or field label objects.  To hide these objects, Set the Visible property in the properties dialog box to No.")
					ll_RtnVal = -1
				end if
			else
				ll_RtnVal = -1
			end if
		end if
	CASE 'copy'
		if ll_ObjSelCnts > 0 THEN
			ib_cut = false
			wf_PrepareCopy(ldw_band)
		else
			ll_RtnVal = -1
		end if
	CASE 'cut'
		if ll_ObjSelCnts > 0 THEN
			ib_cut = true
			ll_Result = wf_PrepareCopy(ldw_band)
			if ll_Result > 0 THEN
				for ll_Cycle = 1 to ll_TotalCnts
					ls_ObjName = istr_SelectObj[ll_Cycle].Fname
					if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
					
					ldw_band = istr_SelectObj[ll_Cycle].Fband
					ldw_band.of_AddorDelSingleSelect(ls_ObjName,false)
					
					//ldw_band.Modify("destroy " + ls_ObjName)
					uo_band.dw_header.Modify("destroy " + ls_ObjName)
					uo_band.dw_headergroup.Modify("destroy " + ls_ObjName)
					uo_band.dw_headergroup2.Modify("destroy " + ls_ObjName)
					uo_band.dw_headergroup3.Modify("destroy " + ls_ObjName)
					uo_band.dw_detail.Modify("destroy " + ls_ObjName)
					uo_band.dw_trailergroup.Modify("destroy " + ls_ObjName)
					uo_band.dw_trailergroup2.Modify("destroy " + ls_ObjName)
					uo_band.dw_trailergroup3.Modify("destroy " + ls_ObjName)
					uo_band.dw_summary.Modify("destroy " + ls_ObjName)
					uo_band.dw_footer.Modify("destroy " + ls_ObjName)
					
					of_delete_pic(lower(ls_name),true) //Delete Picture File From Database -- Jervis 11.23.2009
					is_Border[ll_Cycle] = uo_band.dw_syntax.Describe(ls_ObjName + ".border")
					This.Event ue_SetModify("destroy " + ls_ObjName)
					
					//Clear the object in the is_Objects[]
					ll_Cnt = UpperBound(ldw_band.is_Objects)
					for ll_Index = 1 to ll_Cnt
						if Lower(ldw_band.is_Objects[ll_Index]) = Lower(ls_ObjName) then 
							ldw_band.is_Objects[ll_Index] = ""
							exit
						end if
					next
				next
			end if
		else
			ll_RtnVal = -1
		end if
	CASE 'paste'
		ll_RtnVal = wf_CopyObject(ldw_band)
END CHOOSE

of_Refresh_Object_Inforamtion()

Return ll_RtnVal

end event

event ue_rbuttondown();//====================================================================
// Event: ue_rbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        None
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Andy		Date: 2007-11-05
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History: 
//				Author:	Scofield		Date: 2009-04-14
//
//====================================================================

long	ll_SelObjCnts,ll_ClipObjCnts
u_cst_dw_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)
ll_SelObjCnts = of_GetSelectedObjectCnts()
ll_ClipObjCnts = of_GetClipboardObjCnts()

if ll_SelObjCnts <= 0 then
	im_DesignMenu.m_edit.m_new.Enabled = true
	im_DesignMenu.m_edit.m_delete.Enabled = false
	im_DesignMenu.m_edit.m_cut.Enabled = false
	im_DesignMenu.m_edit.m_copy.Enabled = false
	if is_Open_Style = 'screen' then
		im_DesignMenu.m_edit.m_itemprop.Enabled = true
	else
		im_DesignMenu.m_edit.m_itemprop.Enabled = false
	end if
elseif ll_SelObjCnts = 1 then
	im_DesignMenu.m_edit.m_new.Enabled = true
	im_DesignMenu.m_edit.m_delete.Enabled = true
	im_DesignMenu.m_edit.m_cut.Enabled = true
	im_DesignMenu.m_edit.m_itemprop.Enabled = true	
	if ldw_band.Describe(ldw_band.is_CurObj + ".type") = "column" then
		im_DesignMenu.m_edit.m_copy.Enabled = false
	else
		im_DesignMenu.m_edit.m_copy.Enabled = true
	end if	
else
	im_DesignMenu.m_edit.m_new.Enabled = true
	im_DesignMenu.m_edit.m_delete.Enabled = true
	im_DesignMenu.m_edit.m_cut.Enabled = true	
	im_DesignMenu.m_edit.m_itemprop.Enabled = true
	if ldw_band.Describe(ldw_band.is_CurObj + ".type") = "column" then
		im_DesignMenu.m_edit.m_copy.Enabled = false
	else
		im_DesignMenu.m_edit.m_copy.Enabled = true
	end if
end if

if ib_PreparCopying and ll_ClipObjCnts > 0 then
	im_DesignMenu.m_edit.m_paste.Enabled = true
else
	im_DesignMenu.m_edit.m_paste.Enabled = false
end if

if is_Open_Style = 'screen' then
   im_DesignMenu.m_edit.PopMenu(This.X + This.PointerX() + 10,This.Y + This.PointerY() + 160)
else
   im_DesignMenu.m_edit.PopMenu(This.X + This.PointerX(),This.Y + This.PointerY() )
end if

end event

event ue_resize;//////////////////////////////////////////////////////////////////////
// $<event> ue_resize
// $<arguments>
//			unsignedlong	sizetype
//			integer			newwidth
//			integer			newheight
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.26.2010
//////////////////////////////////////////////////////////////////////

uo_select.x = 26
uo_select.y = 272

if ib_show_treeview then
	uo_select.width = 978//1221
else
	uo_select.width = 0
	uo_design.x = 26
	pb_view.visible = false
	dw_view.visible = false
	r_1.visible = false
	st_2.visible = false
end if       

uo_select.height = this.height - uo_design.height - 10
uo_band.y = uo_select.y
uo_band.height = uo_select.height
uo_band.x = uo_design.x
uo_band.width = this.width - uo_band.x - 20
//---------Begin Modified by (Appeon)Stephen 08.01.2017 for IntelliReport advanced screen design bug id 5739--------
/*
uo_band.dw_ruler.width = 3 * uo_band.width//8   
uo_band.dw_ruler.height = 3 * uo_band.height//10
*/
//if ib_max = false then //(Appeon)Stephen 09.13.2017 / 08.29.2017 - Bug id 5780 - IntelliReport Advanced Screen Design Maximized SaaS 15.3 Build 08092017, 08152017, C/S 08102017
if 8 * uo_band.width > 32760 then
	uo_band.dw_ruler.width = 32760
else
	uo_band.dw_ruler.width = 8 * uo_band.width//8 
end if
if 3 * uo_band.height > 32760 then
	uo_band.dw_ruler.height = 32760
else
	uo_band.dw_ruler.height = 3 * uo_band.height//10
end if
//else
//uo_band.dw_ruler.width = 5 * uo_band.width
//	uo_band.dw_ruler.height = 3 * uo_band.height
//end if
//---------End Modfiied ------------------------------------------------------
uo_band.dw_ruler.x = 0
uo_band.dw_ruler.y = 0

uo_band.of_Resize()

Return 1
end event

event type integer ue_selectmultiobject(string as_type, u_cst_dw_band adw_band, string as_name);/*
long   ll_Count,ll_Color,ll_Seq,ll
str_Selectobj_Rpt  lstr_Empty[]
u_cst_dw_band ldw_Band

CHOOSE CASE  lower(as_type)
	CASE 'mouse' 
		ll_Seq = wf_isselected(as_name)   //hzj
		IF ll_Seq > 0 THEN 
			istr_SelectObj[ll_Seq].fband.of_unselectobj(as_Name)
			istr_SelectObj[ll_seq].FName = ''
		ELSE 
			ll_Count = Upperbound(istr_SelectObj) 
			IF is_CurSelectObj <> '' AND ll_Count = 0 AND  is_CurSelectObj<> as_Name THEN
				ll_Count ++
				ldw_Band = wf_getband(uo_band.dw_Syntax.describe(is_CurSelectObj+".band"))
				istr_SelectObj[ll_Count].fband = ldw_band
				istr_SelectObj[ll_Count].fname = is_CurSelectObj
				ldw_band.of_selectobject(is_CurSelectObj)
			END IF

			ll_Count ++
			istr_SelectObj[ll_Count].fband = adw_band
			istr_SelectObj[ll_Count].fname = as_name
			adw_band.of_selectobject(as_Name)
		END IF
		
	CASE 'clear' 
		of_UnSelectAllObject()		//Added by Scofield on 2009-04-09
END CHOOSE
*/
return 1

end event

event ue_field_depend();//------------------- APPEON BEGIN -------------------
//$<delete> Evan 08.31.2010
//$<reason> V10.5-Advanced Report
/*
//add by jervis 09.24.2009
str_pass lstr_pass

//Messagebox("Temp","Developing...")
//return
//Init field depend list
if this.of_set_depend( ids_field_depend)  > 0 then
	lstr_pass.s_long[1] = il_data_view
	lstr_pass.s_long[2] = ii_screen_id
	lstr_pass.s_ds = ids_field_depend
	OpenWithParm(w_contract_field_depend,lstr_pass)
else
	MessageBox("Infomation","Current screen not exists lookup dddw field")
end if
*/
//------------------- APPEON END ---------------------
end event

event ue_creategroup();//////////////////////////////////////////////////////////////////////
// $<event> ue_creategroup
// $<arguments>
// $<returns> (None)
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.21.2010
//////////////////////////////////////////////////////////////////////

string ls_Band
string ls_Syntax
string ls_Column[]
string ls_GroupColumns
string ls_GroupSyntax
integer li_GroupCount
integer i, li_ColCount
long ll_StartPos1, ll_StartPos2
n_cst_string lnv_string

ls_Syntax = uo_band.dw_syntax.Describe("datawindow.syntax")
if Pos(ls_Syntax, "group(level=1") > 0 then li_GroupCount = 1
if Pos(ls_Syntax, "group(level=2") > 0 then li_GroupCount = 2
if Pos(ls_Syntax, "group(level=3") > 0 then li_GroupCount = 3
if li_GroupCount = 3 then
	MessageBox("Warning", "At most the system can create 3 Groups.", Exclamation!)
	Return
else
	li_GroupCount ++
end if

// Specify group columns
uo_band.dw_syntax.Tag = "0"
OpenWithParm(w_custom_report_group_columns, uo_band.dw_syntax)
ls_GroupColumns = Message.StringParm
if ls_GroupColumns = "Cancel!" then Return

// Build group band syntax
lnv_string.of_ParseToArray(ls_GroupColumns, ',', ls_Column)
li_ColCount = UpperBound(ls_Column)
ls_GroupColumns = ""
for i = 1 to li_ColCount
	if Len(ls_GroupColumns) > 0 then ls_GroupColumns += " "
	ls_GroupColumns += '"' + ls_Column[i] + '"'
next
ls_GroupSyntax = 'group(level=' + String(li_GroupCount) + ' header.height=88 trailer.height=0 by=(' + ls_GroupColumns + '  ) )~r~n'

// Insert new group band syntax to datawindow syntax
ll_StartPos1 = Pos(ls_Syntax, "text(name=")
ll_StartPos2 = Pos(ls_Syntax, "column(name=")
if ll_StartPos2 > ll_StartPos1 then
	ls_Syntax = Replace(ls_Syntax, ll_StartPos1, 0, ls_GroupSyntax)
else
	ls_Syntax = Replace(ls_Syntax, ll_StartPos2, 0, ls_GroupSyntax)
end if

// Move group column to the band
ls_Band = "header." + String(li_GroupCount)
for i = 1 to li_ColCount
	wf_MoveColumnBand(ls_Syntax, ls_Column[i], ls_Band, 10)
next

// Refresh band painter
this.SetRedraw(false)
wf_MakeBand(ls_Syntax)
this.SetRedraw(true)
ib_DoSave = true
end event

event type long ue_resize_01(unsignedlong sizetype, integer newwidth, integer newheight);// adjust userobject size
// Add by gavin on 2009-02-26

//start--modify by gavin on 2009-02-26 
uo_select.x = 26   
uo_select.y = 272

if ib_show_treeview then
	uo_select.width = 978//1221
else
	uo_select.width = 0
	uo_design.x = 26 //Added By Ken.Guo 2009-09-09.
	pb_view.visible = false //Added By Ken.Guo 2009-09-09.
	dw_view.visible = false //Added By Ken.Guo 2009-09-09.
	r_1.visible = false //Added By Ken.Guo 2009-09-09. 
	st_2.visible = false //Added By Ken.Guo 2009-09-09.
end if       
//End--modify by gavin on 2009-02-26 

/*
//start--modify by gavin on 2009-03-04 
if is_open_style = 'screen' then
	uo_band.dw_headergroup.Visible = false
	uo_band.dw_trailergroup.Visible = false
	uo_band.st_headergroup.Visible = false
	uo_band.st_trailergroup.Visible = false
end if
//End--modify by gavin on 2009-03-04
*/

//BEGIN---Modify by Scofield on 2009-09-04
if Not uo_band.dw_headergroup.Visible then uo_band.dw_headergroup.Height = 0
if Not uo_band.dw_trailergroup.Visible then uo_band.dw_trailergroup.Height = 0

if Not uo_band.st_headergroup.Visible then
	uo_band.st_headergroup.Height = 0
else
	uo_band.st_headergroup.Height = uo_band.BANDSEPHEIGHT
end if

if Not uo_band.st_trailergroup.Visible then
	uo_band.st_trailergroup.Height = 0
else
	uo_band.st_trailergroup.Height = uo_band.BANDSEPHEIGHT
end if
//END---Modify by Scofield on 2009-09-04

uo_select.height = this.height - uo_design.height - 10
//END--Modify by Evan 07/14/2008

uo_band.y = uo_select.y
uo_band.height = uo_select.height
//uo_band.x = uo_select.x + uo_select.width + 10
uo_band.x = uo_design.x
uo_band.width = this.width - uo_band.x - 20
//uo_band.width = this.width - uo_band.x - 40
//END--Modify by Evan 07/14/2008

//uo_design.uo_band.dw_ruler.x = 0
//uo_design.uo_band.dw_ruler.y = 4
//$<modify> 05.23.2008 by Andy
uo_band.dw_ruler.width = 3*uo_band.width//8 
uo_band.dw_ruler.height = 3*uo_band.height//10

uo_band.dw_ruler.x = 0
uo_band.dw_ruler.y = 0
uo_band.dw_header.y = uo_band.dw_ruler.Y 
uo_band.dw_Header.width = uo_band.dw_ruler.width						

uo_band.st_header.y = uo_band.dw_header.y + uo_band.dw_header.height + 4
//uo_design.uo_band.st_header.x = uo_design.uo_band.dw_header.x
uo_band.st_header.width = uo_band.dw_header.width

if uo_band.ib_group then
	uo_band.dw_headergroup.y = uo_band.st_header.y + uo_band.st_header.height + 4
	uo_band.dw_headergroup.width = uo_band.dw_header.width 
	uo_band.st_headergroup.y = uo_band.dw_headergroup.y + uo_band.dw_headergroup.height + 4
	uo_band.st_headergroup.width = uo_band.dw_header.width
	
	uo_band.dw_detail.y = uo_band.st_headergroup.y + uo_band.st_headergroup.height + 4
	uo_band.dw_detail.width = uo_band.dw_header.width 
	uo_band.st_detail.y = uo_band.dw_detail.y + uo_band.dw_detail.height + 4
	uo_band.st_detail.width = uo_band.dw_header.width

	uo_band.dw_trailergroup.y = uo_band.st_detail.y + uo_band.st_detail.height + 4
	uo_band.dw_trailergroup.width = uo_band.dw_header.width 
	uo_band.st_trailergroup.y = uo_band.dw_trailergroup.y + uo_band.dw_trailergroup.height + 4
	uo_band.st_trailergroup.width = uo_band.dw_header.width
	
	uo_band.dw_summary.y = uo_band.st_trailergroup.y + uo_band.st_trailergroup.height + 4
	uo_band.dw_summary.width = uo_band.dw_header.width 
	uo_band.st_summary.y = uo_band.dw_summary.y + uo_band.dw_summary.height + 4
	uo_band.st_summary.width = uo_band.dw_header.width
else
	uo_band.dw_detail.y = uo_band.st_header.y + uo_band.st_header.height + 4
	uo_band.dw_detail.width = uo_band.dw_header.width 
	uo_band.st_detail.y = uo_band.dw_detail.y + uo_band.dw_detail.height + 4
	uo_band.st_detail.width = uo_band.dw_header.width
	
	uo_band.dw_summary.y = uo_band.st_detail.y + uo_band.st_detail.height + 4
	uo_band.dw_summary.width = uo_band.dw_header.width 
	uo_band.st_summary.y = uo_band.dw_summary.y + uo_band.dw_summary.height + 4
	uo_band.st_summary.width = uo_band.dw_header.width	
end if

uo_band.dw_footer.y = uo_band.st_summary.y + uo_band.st_summary.height + 4
uo_band.dw_footer.width = uo_band.dw_header.width 
//uo_design.uo_band.dw_footer.x = uo_design.uo_band.dw_header.x
uo_band.st_footer.y = uo_band.dw_footer.y + uo_band.dw_footer.height + 4
//uo_design.uo_band.st_footer.x = uo_design.uo_band.dw_header.x
uo_band.st_footer.width = uo_band.dw_header.width

return 1
end event

event ue_deletegroup();//////////////////////////////////////////////////////////////////////
// $<event> ue_deletegroup
// $<arguments>
// $<returns> (None)
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.27.2010
//////////////////////////////////////////////////////////////////////

string ls_Syntax
string ls_Header, ls_Trailer
long ll_StartPos, ll_EndPos
long ll_HeaderPos, ll_TrailerPos
n_cst_string lnv_string
integer li_Return

if not IsValid(uo_band.ist_spliter) then Return
ls_Syntax = uo_band.dw_syntax.Describe("datawindow.syntax")

// Delete specify group
choose case	uo_band.ist_spliter.ClassName()
	case "st_headergroup"
		ll_StartPos = Pos(ls_Syntax, "group(level=1")
		ll_HeaderPos = Pos(ls_Syntax, "band=header.1")
		ll_TrailerPos = Pos(ls_Syntax, "band=trailer.1")
	case "st_headergroup2"
		ll_StartPos = Pos(ls_Syntax, "group(level=2")
		ll_HeaderPos = Pos(ls_Syntax, "band=header.2")
		ll_TrailerPos = Pos(ls_Syntax, "band=trailer.2")
	case "st_headergroup3"
		ll_StartPos = Pos(ls_Syntax, "group(level=3")
		ll_HeaderPos = Pos(ls_Syntax, "band=header.3")
		ll_TrailerPos = Pos(ls_Syntax, "band=trailer.3")
end choose
if ll_StartPos < 1 then Return
if ll_HeaderPos > 0 or ll_TrailerPos > 0 then
	MessageBox("Prompt", "Please delete or move DWOs out from this group first!")
	Return
end if
li_Return = MessageBox("Delete Group", "Are you sure that you want to delete the selected group?", Question!, YesNo!)
if li_Return = 2 then Return
ll_EndPos = Pos(ls_Syntax, "~r~n", ll_StartPos)
ls_Syntax = Replace(ls_Syntax, ll_StartPos, ll_EndPos - ll_StartPos + 2, "")

// Rebuild group level number
choose case	uo_band.ist_spliter.ClassName()
	case "st_headergroup"
		ll_StartPos = Pos(ls_Syntax, "group(level=2")
		if ll_StartPos > 0 then
			ls_Syntax = Replace(ls_Syntax, ll_StartPos, 13, "group(level=1")
		end if
		ll_StartPos = Pos(ls_Syntax, "group(level=3")
		if ll_StartPos > 0 then
			ls_Syntax = Replace(ls_Syntax, ll_StartPos, 13, "group(level=2")
		end if
	case "st_headergroup2"
		ll_StartPos = Pos(ls_Syntax, "group(level=3")
		if ll_StartPos > 0 then
			ls_Syntax = Replace(ls_Syntax, ll_StartPos, 13, "group(level=2")
		end if
	case "st_headergroup3"
end choose

// Rebuild dwo's band
choose case	uo_band.ist_spliter.ClassName()
	case "st_headergroup"
		ls_Syntax = lnv_string.of_GlobalReplace(ls_Syntax, "band=header.2", "band=header.1")
		ls_Syntax = lnv_string.of_GlobalReplace(ls_Syntax, "band=trailer.2", "band=trailer.1")
		ls_Syntax = lnv_string.of_GlobalReplace(ls_Syntax, "band=header.3", "band=header.2")
		ls_Syntax = lnv_string.of_GlobalReplace(ls_Syntax, "band=trailer.3", "band=trailer.2")
	case "st_headergroup2"
		ls_Syntax = lnv_string.of_GlobalReplace(ls_Syntax, "band=header.3", "band=header.2")
		ls_Syntax = lnv_string.of_GlobalReplace(ls_Syntax, "band=trailer.3", "band=trailer.2")
	case "st_headergroup3"
end choose

// Refresh band painter
this.SetRedraw(false)
wf_MakeBand(ls_Syntax)
this.SetRedraw(true)
ib_DoSave = true
end event

event ue_groupproperty();//////////////////////////////////////////////////////////////////////
// $<event> ue_groupproperty
// $<arguments>
// $<returns> (None)
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.28.2010
//////////////////////////////////////////////////////////////////////

string ls_Syntax

if not IsValid(uo_band.ist_spliter) then Return

choose case	uo_band.ist_spliter.ClassName()
	case "st_headergroup"
		uo_band.dw_syntax.Tag = "1"
	case "st_headergroup2"
		uo_band.dw_syntax.Tag = "2"
	case "st_headergroup3"
		uo_band.dw_syntax.Tag = "3"
end choose
OpenWithParm(w_custom_report_group_properties, uo_band.dw_syntax)

// Refresh band painter
if Message.StringParm = "OK!" then	
	ls_Syntax = uo_band.dw_syntax.Describe("datawindow.syntax")
	this.SetRedraw(false)
	wf_MakeBand(ls_Syntax)
	this.SetRedraw(true)
end if
end event

public function integer of_show_invisible (boolean ab_show);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-08 By: Andy
uo_band.dw_header.of_show_invisible( ab_show )
uo_band.dw_detail.of_show_invisible( ab_show )
uo_band.dw_summary.of_show_invisible( ab_show )
uo_band.dw_footer.of_show_invisible( ab_show )
//---------------------------- APPEON END ----------------------------

RETURN 1
end function

public function integer of_setup_painter ();//idw_detail = dw_detail

ib_setup_dddw = False


 
Integer i
Integer li_col_cnt
Integer li_sys_col_cnt
Integer li_dv_col_cnt
String ls_col_name
String ls_sys_cols
String ls_data_view_cols
String ls_sys_fields_update[]
String ls_dv_fields_update[]
String  ls_sys_key_cols[ ] = {"sys_fields_table_id", "sys_fields_field_id"}
String  ls_dv_key_cols[ ] = {"data_view_fields_data_view_id", "data_view_fields_screen_id", "data_view_fields_field_id"}



dw_properties.of_SetMultiTable(TRUE)

dw_properties.of_SetUpdateable(True)

li_col_cnt = Integer( dw_properties.Object.DataWindow.Column.Count )
FOR i = 1 TO li_col_cnt
	
	dw_properties.SetColumn( i )
	ls_col_name = dw_properties.GetColumnName()
	IF Upper(MidA(ls_col_name, 1, 10 )) = "SYS_FIELDS"  THEN
		li_sys_col_cnt ++
		ls_sys_fields_update[li_sys_col_cnt] = ls_col_name
	ELSEIF Upper(MidA(ls_col_name, 1, 16 )) = "DATA_VIEW_FIELDS" THEN
		li_dv_col_cnt ++
		ls_dv_fields_update[li_dv_col_cnt] = ls_col_name
	END IF
	
END FOR

li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_label_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_label_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_label_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_height"

dw_properties.inv_multitable.of_Register( "sys_fields", ls_sys_key_cols , ls_sys_fields_update, TRUE, 0)
dw_properties.inv_multitable.of_Register( "data_view_fields", ls_dv_key_cols , ls_dv_fields_update, TRUE, 0)


This.Height = This.Height - 204
This.y = 190


Return 0



end function

public function integer of_set_display_only ();//maha created 092204 for setting all fields in a window to read only
integer i
integer ic
integer res
string ls_val,ls_display

res = messagebox("Display Only","This function sets all fields in this screen to display only.~r Click YES to set all fields to display only; click NO to set all fields editable.", question!,yesnocancel!,3)
if res = 3 then 
	return 1
elseif res = 2 then 
	ls_val = "N"
else
	ls_val = "Y"
end if

//add 08/29/2007 by: Andy
if ls_val = "Y" then 
	ls_display = 'Yes'
else
	ls_display = 'No'
end if
//end of add

ic = dw_properties.rowcount()

for i = 1 to ic
	dw_properties.setitem(i,"data_view_fields_display_only",ls_val)
next

Long ll_column_count
Long ll_column
String ls_column_name
String ls_edit_style
String ls_Modify,ls_Band

ll_column_count = long(uo_band.dw_syntax.Describe("DataWindow.Column.Count"))
FOR ll_column = 1 TO ll_column_count
	ls_column_name = uo_band.dw_syntax.Describe("#" + string(ll_column) + ".name")
	ls_edit_style = Lower(uo_band.dw_syntax.Describe(ls_column_name+".Edit.Style"))

	// Display Only
	IF ls_edit_style = "edit" THEN
		//modify 11/15/2007 by: Andy
		ls_Modify = ls_column_name + ".edit.displayonly = '"+ls_display+"'"
		ls_Band = uo_band.dw_syntax.Describe("#" + string(ll_column) + ".Band")
		
		choose case lower(ls_Band)
			case 'header'
				uo_band.dw_header.modify( ls_Modify)
			case 'detail'
				uo_band.dw_detail.modify( ls_Modify)
			case 'summary'
				uo_band.dw_summary.modify( ls_Modify)
			case 'footer'
				uo_band.dw_footer.modify( ls_Modify)
			case 'header.1'
				uo_band.dw_headergroup.modify(ls_modify)
			case 'header.2'
				uo_band.dw_headergroup2.modify(ls_modify)
			case 'header.3'
				uo_band.dw_headergroup3.modify(ls_modify)
			case 'trailer.1'
				uo_band.dw_trailergroup.modify(ls_modify)
			case 'trailer.2'
				uo_band.dw_trailergroup2.modify(ls_modify)
			case 'trailer.3'
				uo_band.dw_trailergroup3.modify(ls_modify)
			case else 
				//do nothing				
		end choose
		
		uo_band.dw_syntax.Modify(ls_Modify)
	END IF
END FOR

return 1
end function

public function integer of_set_tab_order (boolean ab_status);Integer i
Integer li_column_cnt
Integer li_col_width
Integer li_cnt
Long ll_col_x
Long ll_col_y
String ls_bc 
String ls_col_nm
String ls_tab_nm
String ls_tab_x
String ls_tab_y
String ls_tab_order
String ls_names[]
Integer li_col_cnt
String ls_field_nm
Integer li_field_order
long ll_col_height
Integer li_TabSequence
String  ls_Modify //<add> 01.03.2008 by: Andy

ib_set_tab_order = ab_status

IF ab_status THEN
	st_tab.Visible = True
	st_tab.Y = this.Height - 200
	cb_screen_properties.Enabled = False
	//BEGIN---Modify by Evan 07/14/2008
	//dw_select_section.Enabled = False
	uo_select.Enabled = False
	//END---Modify by Evan 07/14/2008
	
	//$<comment> 01.04.2008 by: Andy
	//$<Reason > No use,here hasn't the ability for modify the tab order.
	//uo_design.st_10.text = "Tab Order"
	//uo_design.dw_1.SetItem(1, "label","")
	//end of comment 01.04.2008
	
	//$<Modify> 2007-11-08 By: Andy Reason:uo_band.dw_detail,not dw_detail
	li_column_cnt = Integer(uo_band.dw_detail.Describe("DataWindow.Column.Count"))
	FOR i = 1 TO li_column_cnt
		ls_bc = uo_band.dw_detail.Describe("#" + String( i ) + ".Background.Color")
		ls_col_nm = uo_band.dw_detail.Describe("#" + String( i ) + ".Name")
		ls_tab_nm = "tab_" + ls_col_nm
		ll_col_x = Long( uo_band.dw_detail.Describe("#" + String( i ) + ".x") )
		li_col_width = Long( uo_band.dw_detail.Describe("#" + String( i ) + ".Width") )
		ll_col_height= Long( uo_band.dw_detail.Describe("#" + String( i ) + ".Height") )
		ll_col_y = Long(uo_band.dw_detail.Describe("#" + String( i ) + ".y"))

		//Grid style
		IF il_dw_style = 0 THEN
			ll_col_y = ll_col_y - 60
			ls_tab_x = String( ll_col_x + li_col_width - 100)
		ELSE
			//$<comment> 01.03.2008 by: Andy
			//Reason:After add band feature,it should add above it or the same height,not lower it.
			//ll_col_y = ll_col_y + ll_col_height + 12
			ls_tab_x = String( ll_col_x )
		END IF
		
		//$<add> 01.03.2008 by: Andy Reason:fixed a bug.
		if ll_col_y < 0 then ll_col_y = 0
		//end of add
		ls_tab_y = String(ll_col_y)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 05.18.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		IF ls_bc = "16777215" THEN
		*/
		//$<modify> 01.02.2008 by: Andy
		//if column is selected,then the background color is not 16777215
		//IF ls_bc = "16777215" And uo_band.dw_detail.Describe("#" + String( i ) +  ".visible") = '1' THEN		
		IF uo_band.dw_detail.Describe("#" + String( i ) +  ".visible") = '1' THEN
		//end of modify
		//---------------------------- APPEON END ----------------------------
			ls_tab_order = uo_band.dw_detail.Describe( ls_col_nm + ".TabSequence" )
			//$<modify> 01.03.2008 by: Andy 
			//Reason: if it's grid style,create text failed.
			IF il_dw_style = 0 THEN
				ls_Modify = "create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")" 
			else
				ls_Modify = "create text(band=foreground text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")" 
			end if
			//uo_band.dw_detail.Modify("create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")"  )
			uo_band.dw_detail.Modify( ls_Modify )
			//end of modify 01.03.2008
			
			is_tab_label_names[ i ] = ls_tab_nm
			li_cnt ++

			IF ls_tab_order = "10" THEN
				is_last_tab_label_name = ls_tab_nm
				uo_band.sle_tab.Text = ls_tab_order
				
				uo_band.dw_detail.Event ue_calc_tab_position()
			END IF		
		END IF
	END FOR
ELSE
	uo_band.dw_detail.Modify( MidA( is_last_tab_label_name, 5, 100 ) + ".TabSequence = '" + uo_band.sle_tab.Text + "'" )		
	
	li_column_cnt = UpperBound( is_tab_label_names )
	FOR i = 1 TO li_column_cnt
		uo_band.dw_detail.Modify( "Destroy " + is_tab_label_names[i] )
	END FOR
	is_tab_label_names = ls_names

	uo_band.sle_tab.Text = ""
	uo_band.sle_tab.Visible = False

	st_tab.Visible = False
	cb_screen_properties.Enabled = True
	
	//BEGIN---Modify by Evan 07/14/2008
	//dw_select_section.Enabled = True
	uo_select.Enabled = True
	//END---Modify by Evan 07/14/2008

	// Set field order
	dw_properties.SetFilter( "" )
	dw_properties.Filter()

	li_col_cnt = dw_properties.RowCount()
	FOR i = 1 TO li_col_cnt
		ls_field_nm = dw_properties.GetItemString(i, "sys_fields_field_name" )
		li_field_order =  Integer(uo_band.dw_detail.Describe( ls_field_nm + ".TabSequence" ))
		// Allow set order of field to 0
		//IF li_field_order > 0 THEN
			dw_properties.SetItem(i, "data_view_fields_field_order", li_field_order )	
		//END IF
	END FOR

	dw_properties.SetSort( "data_view_fields_field_order" )
	dw_properties.Sort()
	dw_properties.SetFilter( "data_view_fields_visible='Y'" )
	dw_properties.Filter()
	
	li_col_cnt = dw_properties.RowCount()
	
	li_TabSequence = 0
	FOR i = 1 TO li_col_cnt
		ls_field_nm = dw_properties.GetItemString(i, "sys_fields_field_name" )
		li_field_order = dw_properties.GetItemnumber( i, "data_view_fields_field_order")

		IF li_field_order > 0 THEN
			li_TabSequence++
			dw_properties.SetItem( i, "data_view_fields_field_order", li_TabSequence * 10 )
			//<Modify> 01.03.2008 by: Andy
			ls_Modify = ls_field_nm + ".TabSequence = '" + String(li_TabSequence * 10) + "'"
			uo_band.dw_detail.Modify( ls_Modify )
			this.event ue_setmodify( ls_Modify )      //modify by gavin on 2009/3/4
			//end of modify
		END IF
	END FOR
	
	dw_properties.SetFilter( "" )
	dw_properties.Filter()
END IF

RETURN 0	
end function

public function integer of_select_screen (integer currentrow, integer ai_screen_id);Integer li_col_cnt
Integer i
Integer li_cnt
Integer li_row_cnt
STRING ls_sql

IF ib_refresh_screen_list = True THEN
	Return 1
END IF

//BEGIN---Delete by Evan 07/14/2008
/*
IF currentrow < 1 THEN
	Return 1
END IF
*/
//BEGIN---Delete by Evan 07/14/2008

IF uo_design.st_tab_order.BorderStyle = StyleLowered! THEN
	of_set_tab_order( False )
	uo_design.st_tab_order.TriggerEvent( Clicked! )
END IF

//BEGIN---Delete by Evan 07/14/2008
/*
dw_select_section.SelectRow(0, False)
dw_select_section.SelectRow( currentrow, True)
*/
//BEGIN---Delete by Evan 07/14/2008

//download picture -- jervis 11.24.2009
long ll_i,ll_pic_id
string ls_filename
ids_pic.Retrieve( il_data_view_id,ai_screen_id)
for ll_i = 1 to ids_pic.rowcount( )
	ls_filename = ids_pic.GetItemString( ll_i,"pic_filename")
	ll_pic_id = ids_pic.GetItemNumber( ll_i,"pic_id")
	of_download_pic(ll_pic_id,ls_filename)
next

// Create dw from database
IF of_create_dynamic_dw(ai_screen_id) < 0 THEN // Modify by Evan 07/14/2008, Add pass argument.
	RETURN -1
END IF

IF ib_refresh_screen_list = True THEN
	Return 1
END IF

//$<comment> 2007-11-05 By: Andy
/*
li_row_cnt = dw_properties.RowCount( )
li_col_cnt = Integer( dw_detail.Object.DataWindow.Column.Count )

FOR i = 1 TO li_col_cnt
	dw_detail.SetColumn(i)
	is_object_list[i] = dw_detail.GetColumnName()	
END FOR

FOR i = li_col_cnt+1 TO (li_col_cnt * 2)
	li_cnt++
	is_object_list[i] = is_object_list[li_cnt] + "_t"
END FOR
*/
of_show_invisible( ib_show_invisible )

dw_properties.ResetUpdate( )
uo_design.dw_1.SetText('') //Added By Ken.Guo 2009-09-03.
//$<comment> 2007-11-05 By: Andy
//dw_detail.ResetUpdate( )

Return 1
end function

public function integer of_select_view ();//------------------- APPEON BEGIN -------------------
//$<delete> Evan 09.01.2010
//$<reason> V10.5-Advanced Report

//String 	ls_ViewName,ls_data_view_name
//long		ll_Handle,ll_View_id,ll_screen_id
//
////--------------------------- APPEON BEGIN ---------------------------
////$<Modify> 2007-11-20 By: Andy
////$<Reason> If it's modified,then show a messagebox.
//string   ls_Syntax
//int  li
//
//ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")
//IF ls_Syntax <> is_OrgSyntax THEN                             //Modified by gavin on 2009-03-05
//	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
//	IF li = 1 THEN
//		IF of_save() < 0 THEN
//			return 1
//		END IF
//	ELSEIF li = 3 THEN
//		return 1
//	END IF
//END IF
//is_OrgSyntax = ls_Syntax
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<Modify> 2009-01-13 By: Scofield
////$<Reason> Open Screen painter window.
//
//if IsValid(gw_contract) and il_select_view = 0 then
//	if gw_contract.tab_contract_details.SelectedTab = 1 then
//		ll_View_id = gl_SearchTab_View_id
//	else
//		ll_View_id = gi_contract_view_id
//	end if
//	
//	SELECT data_view_name INTO :ls_ViewName FROM data_view WHERE data_view_id = :ll_View_id ;
//	if IsNull(ls_ViewName) then ls_ViewName = ""
//	
//	Message.StringParm = String(ll_View_id) + "~t" + ls_ViewName
//	
//	if IsValid(parent_window_design) then parent_window_design.il_initview_id = ll_View_id
//elseif w_mdi.of_security_access(5310) = 0 or w_mdi.of_security_access(5400) = 0 then
//	ll_View_id = long(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + Upper(gs_user_id) + "'"))
//	if IsNull(ll_View_id) or ll_View_id = 0 then ll_View_id = 1001
//	
//	SELECT data_view_name INTO :ls_ViewName FROM data_view WHERE data_view_id = :ll_View_id ;
//	if IsNull(ls_ViewName) then ls_ViewName = ""
//	
//	Message.StringParm = String(ll_View_id) + "~t" + ls_ViewName
//else
//	OpenWithParm( w_select_view, "C" ) // P-practitioner view C- Contract view
//end if
////---------------------------- APPEON END ----------------------------
//
//IF Message.StringParm = "Cancel" THEN
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 04.26.2007 By: Jack
//	//$<reason> Fix a defect.
//	il_select_view = il_data_view	
//	il_data_view_id = il_data_view
//	//---------------------------- APPEON END ----------------------------
//	//BEGIN---Delete by Evan 07/14/2008
//	/*
//	IF dw_select_section.Rowcount( ) = 0 THEN
//		dw_select_section.Reset()
//		dw_select_section.of_SetTransObject(SQLCA)
//		dw_select_section.Retrieve( il_data_view )
//		dw_select_section.SelectRow( 1, True )
//	END IF
//	*/
//	//END---Delete by Evan 07/14/2008
//	Return -1
//ELSE
//	/*
//	IF parent_window_design.Event pfc_save() < 0 THEN
//		Return -1
//	END IF
//	*/
//	This.SetRedraw( False )
//
//	Integer li_pos
//	String ls_msg
//	
//	ls_msg = Message.StringParm
//	li_pos = PosA( ls_msg, '~t' )
//	il_data_view_id = Long( LeftA( ls_msg, li_pos - 1 ) )
//	ls_data_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )
//	
//	of_select_view(il_data_view_id,ls_data_view_name,0)
//	dw_view.Setitem(1,'data_view_id',il_data_view_id)
//	/* move to of_select_view(al_view_id,as_view_name,al_screen_id)
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 04.18.2007 By: Jack
//	//$<reason> Fix a defect.
//	il_select_view = il_data_view_id
//	//$<add> 03.17.2008 By: nova
//	//$<reason> Fix a defect.BugN022703
//	il_data_view= il_data_view_id	
//	//---------------------------- APPEON END ----------------------------
//	parent_window_design.Title = "Contract Data Screen Painter ( " + ls_data_view_name + " )"
//	//BEGIN---Modify by Evan 07/14/2008
//	uo_select.Event ue_Retrieve(il_data_view_id)
//	//END---Modify by Evan 07/14/2008
//	
//	//BEGIN---Modify by Scofield on 2009-04-20
//	if IsValid(gw_contract) then
//		ll_screen_id = gw_contract.of_GetCurrentScreenID()
//		if ll_screen_id > 0 then
//			ii_screen_id = ll_screen_id
//			ll_Handle = uo_select.tv_screen.of_FindItemWithData(String(ii_screen_id))
//			if ll_Handle > 0 then uo_select.tv_screen.SelectItem(ll_Handle)
//		end if
//	end if
//	//END---Modify by Scofield on 2009-04-20
//	*/
//	This.SetRedraw(True)
//END IF

//------------------- APPEON END ---------------------

Return 0

end function

public function integer of_set_parent_window (window aw_win);parent_window_design = aw_win

Return 0
end function

public function integer of_retrieve_dw_properties (datawindow adw_detail);Long ll_column_count
Long ll_column
Long ll_row
Long ll_Color
STRING ls_column_name
STRING ls_str
STRING ls_edit_style
STRING ls_edit_codetable
STRING ls_editmask_codetable
STRING ls_column_coltype
STRING ls_column_border
STRING ls_column_ID
String ls_SlideUp,ls_AutoHeight

// Reset datawindow
dw_properties.Reset()

// Through all field
ll_column_count = long(adw_detail.Describe("DataWindow.Column.Count"))
FOR ll_column = 1 TO ll_column_count

	ll_row = dw_properties.Insertrow( 0 )

	ls_column_name = adw_detail.Describe("#" + string(ll_column) + ".name")
	ls_edit_style = Lower(adw_detail.Describe(ls_column_name+".Edit.Style"))
	ls_edit_codetable = Lower(adw_detail.Describe ( ls_column_name + ".Edit.CodeTable" ))
	ls_editmask_codetable = Lower(adw_detail.Describe ( ls_column_name + ".EditMask.CodeTable"))
	ls_column_coltype	= LeftA(adw_detail.Describe(ls_column_name +".COLType"),4)
	
	//<add> 07/04/2007 by: Andy
	dw_properties.Setitem( ll_row, "data_view_fields_screen_id",ii_screen_id)
	//end of add
	
	// Enabled lookup Field
	dw_properties.Setitem( ll_row, "disable_fields_lookup", 0)

	// Table Name

	// Filed Name
	dw_properties.Setitem( ll_row, "sys_fields_field_name", ls_column_name)

	// Filed ID
	ls_str = adw_detail.Describe(ls_column_name + ".ID")
	dw_properties.Setitem( ll_row, "data_view_fields_field_id", Long(ls_str))
		
	// Field Type
	ls_str = adw_detail.Describe(ls_column_name + ".ColType")
	//ls_str = Upper(Left(ls_str,1))
	dw_properties.Setitem( ll_row, "sys_fields_field_type", ls_str)
	
	//Comment by jervis 08.31.2009
	//Move to the properties dw expression of field
	/*
	IF Pos(Lower(ls_str),"date") > 0 THEN
		// Disable lookup Field
		dw_properties.Setitem( ll_row, "disable_fields_lookup", 1)
	END IF
	*/
	
	// Field Len
	
	// Visible
	ls_str = adw_detail.Describe(ls_column_name + ".Visible")
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.28.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	IF ls_str = "1" THEN ls_str = "Y" ELSE ls_str = "N"
	*/	
	IF ls_str = "0" THEN 
		ls_str = "N"		
	ELSEIF ls_str = "1" THEN
		ls_str = "Y" 
	End If
	//---------------------------- APPEON END ----------------------------
	dw_properties.Setitem( ll_row, "data_view_fields_visible", ls_str)

	// Field Label
	ls_str = adw_detail.Describe(ls_column_name + "_t.Text")
	//$<Modify> 2008-01-17 By: nova
	//$<Reason> Fix a defect. 
	if LeftA(ls_str,1) = '"' then ls_str = MidA(ls_str,2)
   if RightA(ls_str,1) = '"' then ls_str = LeftA(ls_str,LenA(ls_str) - 1)
	
	//$<Modify> 2008-01-04 By: Andy
	//$<Reason> Fix a defect. add if statement
	if Not (ls_str = "!" OR ls_str = "?") then
		dw_properties.Setitem( ll_row, "data_view_fields_field_label", ls_str)
	end if
	//end of modify 2008-01-04 
	
	// Field Label Color
	//BEGIN---Add by Evan 07/17/2008
	ll_Color = Long(adw_detail.Describe(ls_column_name + "_t.color"))	
	dw_properties.Setitem(ll_row, "fields_label_textcolor", ll_Color)
	ll_Color = Long(adw_detail.Describe(ls_column_name + "_t.background.color"))
	dw_properties.Setitem(ll_row, "fields_label_textbkcolor", ll_Color)	
	//END---Add by Evan 07/17/2008
	
	// Label Justification
	ls_str = adw_detail.Describe(ls_column_name + "_t.Alignment")
	dw_properties.Setitem( ll_row, "data_view_fields_label_justification", Integer(ls_str))
	
	// Field Order
	ls_str = adw_detail.Describe(ls_column_name + ".TabSequence")
	dw_properties.Setitem( ll_row, "data_view_fields_field_order", Integer(ls_str))
	
	// Required
	ls_str = adw_detail.Describe(ls_column_name + "." + ls_edit_style + ".Required")
	dw_properties.Setitem( ll_row, "data_view_fields_required", LeftA(Upper(ls_str),1))
		
	// Lookup Type	// Only "C" - code lookup
	
	IF ls_edit_style = "dddw" THEN
		ls_str = adw_detail.Describe(ls_column_name + ".dddw.Name")
		IF ls_str = "d_dddw_code_lookup" THEN
			// Lookup Field
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field", "Y")

			// Lookup Table
			ls_str = adw_detail.Describe(ls_column_name + ".tag")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_code", ls_str)

			// Lookup Field Name
			ls_str = adw_detail.Describe(ls_column_name + ".dddw.DisplayColumn")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field_name", ls_str)
			
			// Enabled lookup Field
			dw_properties.Setitem( ll_row, "disable_fields_lookup", 0)
		elseif ls_str = 'd_dddw_users' then
			//Add User dddw -- jervis 12.4.2009
			// Lookup Field
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field", "U")

			// Lookup Table
			ls_str = adw_detail.Describe(ls_column_name + ".tag")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_code", ls_str)

			// Lookup Field Name
			ls_str = adw_detail.Describe(ls_column_name + ".dddw.DisplayColumn")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field_name", ls_str)
			
			// Enabled lookup Field
			//dw_properties.Setitem( ll_row, "disable_fields_lookup", 0)
		elseif ls_str = 'd_dddw_company' then
			//Add Company dddw -- jervis 12.4.2009
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field", "C")

			// Lookup Table
			ls_str = adw_detail.Describe(ls_column_name + ".tag")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_code", ls_str)

			// Lookup Field Name
			ls_str = adw_detail.Describe(ls_column_name + ".dddw.DisplayColumn")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field_name", ls_str)
			
			// Enabled lookup Field
			//dw_properties.Setitem( ll_row, "disable_fields_lookup", 0)
		ELSE
			// Disable lookup Field
			dw_properties.Setitem( ll_row, "disable_fields_lookup", 1)
		END IF
	END IF
	
	// Drop Down Width
	IF ls_edit_style = "dddw" THEN
		ls_str = adw_detail.Describe(ls_column_name + ".dddw.PercentWidth")
		dw_properties.Setitem( ll_row, "sys_fields_drop_down_width", Integer(ls_str))
	END IF
	
	// Field Case
	IF ls_edit_style = "edit" OR ls_edit_style = "dddw" OR ls_edit_style = "ddlb" THEN
		ls_str = adw_detail.Describe(ls_column_name + "." + ls_edit_style + ".Case")
		dw_properties.Setitem( ll_row, "sys_fields_field_case", LeftA(Upper(ls_str),1))
	END IF
	
	// Field Mask
	if ls_edit_style = "edit" then			//Added by Scofield on 2010-04-01
		ls_str = adw_detail.Describe(ls_column_name + ".Edit.Format")
		if ls_str <> "!" and ls_str <> "?" then
			dw_properties.Setitem(ll_row, "sys_fields_field_mask", ls_str)
		end if
	elseif ls_edit_style = "editmask" then
		ls_str = adw_detail.Describe(ls_column_name + ".EditMask.Mask")
		if ls_str <> "!" and ls_str <> "?" then
			dw_properties.Setitem(ll_row, "sys_fields_field_mask", ls_str)
		end if
	end if
	
	// Audit Fld
	// Default Value
	ls_str = adw_detail.Describe(ls_column_name + ".Initial")
	dw_properties.Setitem( ll_row, "sys_fields_default_value", ls_str)

	//BEGIN---Modify by Scofield on 2009-08-27
	ll_Color = Long(adw_detail.Describe(ls_column_name + ".color"))	
	dw_properties.Setitem(ll_row, "fields_textcolor", ll_Color)
	ll_Color = Long(adw_detail.Describe(ls_column_name + ".background.color"))
	dw_properties.Setitem(ll_row, "fields_textbkcolor", ll_Color)	
	//END---Modify by Scofield on 2009-08-27
	
	// Justification
	ls_str = adw_detail.Describe(ls_column_name + ".Alignment")
	dw_properties.Setitem( ll_row, "data_view_fields_justification", Integer(ls_str))

	// Sort Order
	// Display Only
	IF ls_edit_style = "edit" THEN
		ls_str = adw_detail.Describe(ls_column_name + ".edit.displayonly")
	ELSE
		ls_str = "N"
	END IF
	dw_properties.Setitem( ll_row, "data_view_fields_display_only", LeftA(Upper(ls_str),1))
	
	// Data Validation
	
	// Fields label border
	ls_str = adw_detail.Describe(ls_column_name + "_t.Border")
	//$<Modify> 2008-01-04 By: Andy
	//$<Reason> Fix a defect. add if statement
	if Not (ls_str = "!" OR ls_str = "?") then
		dw_properties.Setitem( ll_row, "fields_label_border", ls_str)
	end if
	//end of modify 2008-01-04 
	// Fields border
	ls_column_border = adw_detail.Describe(ls_column_name + ".Border")
	dw_properties.Setitem( ll_row, "fields_border", ls_column_border)

	ls_str = adw_detail.describe(ls_column_name + ".protect")
	dw_properties.Setitem( ll_row, "fields_protect", ls_str)
	
	//Fields vert scroll bar By Jervis 12-10-2008
	IF ls_edit_style = "edit" OR ls_edit_style = "dddw" OR ls_edit_style = "ddlb" THEN
		ls_str = adw_detail.Describe(ls_column_name + "." + ls_edit_style + ".VScrollBar")
		dw_properties.Setitem( ll_row, "fields_vscrollbar", LeftA(Upper(ls_str),1))
	END IF

	//BEGIN---Modify by Scofield on 2010-02-01
	ls_SlideUp = adw_Detail.Describe(ls_Column_name + ".SlideUp")
	dw_Properties.SetItem(ll_Row,"Fields_SlideUp",ls_SlideUp)
	
	ls_AutoHeight = adw_Detail.Describe(ls_Column_name + ".Height.AutoSize")
	dw_Properties.SetItem(ll_Row,"Fields_AutoHeight",ls_AutoHeight)
	//END---Modify by Scofield on 2010-02-01
END FOR

RETURN 1

end function

public function integer of_save ();STRING ls_obj_name
STRING ls_dw_syntax
STRING ls_field_nm 
Integer i,li_col_cnt
Long ll_cr
//Integer li_pos //modified by nova 2008-09-23 
Long li_pos
DateTime ldt_today
Long ll_max_height
Long ll_col_y, ll_col_height
string ls_visible

//<comment> 11/09/2007 by: Andy
//IF ib_relocating_fields THEN
//	Return 0
//END IF

IF ib_set_tab_order THEN
	Return 0
END IF

//BEGIN---Modify by Evan 07/14/2008
//ll_cr = dw_select_section.Getrow()
ids_screen.SetFilter("")
ids_screen.Filter()
ll_cr = ids_screen.Find("screen_id=" + String(ii_screen_id), 1, ids_screen.RowCount())
//BEGIN---Modify by Evan 07/14/2008
IF ll_cr = 0 THEN RETURN -1

//$<modify> 01.12.2008 by Andy
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 28/04/2007 By: Jervis
//$<reason> temporary process property of border for compute
of_restore_properties(uo_band.dw_syntax)
//---------------------------- APPEON END ----------------------------

//$<add> 03.18.2008 by Andy
//Set the same position to b_due_date_g and b_due_date_r
if ii_screen_id = 33 or ii_screen_id = 47 then
	String ls_x,ls_y,ls_width,ls_height,ls_modify
	ls_x = uo_band.dw_syntax.Describe("b_due_date.x")
	ls_y = uo_band.dw_syntax.Describe("b_due_date.y")
	ls_width  = uo_band.dw_syntax.Describe("b_due_date.Width")
	ls_height = uo_band.dw_syntax.Describe("b_due_date.Height")
	ls_modify = "b_due_date_g.x='" + ls_x + "' b_due_date_r.x='" + ls_x + "' b_due_date_g.y='" + ls_y + "' b_due_date_r.y='" + ls_y + "' b_due_date_g.Width='" + ls_width + "' b_due_date_r.Width='" + ls_width + "' b_due_date_g.Height='" + ls_height + "' b_due_date_r.Height='" + ls_height + "' "
	uo_band.dw_syntax.modify( ls_modify )
end if

//Get syntax
ls_dw_syntax = uo_band.dw_syntax.Describe("DataWindow.Syntax")

//$<Modify> 2007-11-20 By: Andy
//$<Reason> Fix a defect.
//parent_window_design.is_OrgSyntax = ls_dw_syntax   //Modified by gavin on 2009-03-05
is_OrgSyntax = ls_dw_syntax

If ii_screen_id <> 2 Then
	IF il_dw_style = 1 THEN
		li_pos = PosA(ls_dw_syntax,"processing=0")
		IF li_pos > 0 THEN
			ls_dw_syntax = LeftA(ls_dw_syntax,li_pos - 1) + "processing=1" + MidA(ls_dw_syntax, li_pos + 12)
		END IF
	END IF		
Else
	li_pos = PosA(ls_dw_syntax,'master_contract_id visible="1"')		//Modified by Scofield on 2010-05-05
	IF li_pos > 0 THEN
		ls_dw_syntax = LeftA(ls_dw_syntax,li_pos + 27) + "1	if( master_contract_id > 0,1,0)" + MidA(ls_dw_syntax, li_pos + 29)
	End If
	
	li_pos = PosA(ls_dw_syntax,'master_cnt visible="1"')				//Modified by Scofield on 2010-05-05
	IF li_pos > 0 THEN
		ls_dw_syntax = LeftA(ls_dw_syntax,li_pos + 19) + "1	if( master_cnt > 0 ,1,0)" + MidA(ls_dw_syntax, li_pos + 21)
	End If
End If

// Save syntax of dw to the database
//ls_dw_syntax = uo_band.dw_syntax.Describe("DataWindow.Syntax")
//end of modify 01.12.2008 by andy

//BEGIN---Modify by Evan 07/14/2008
/*
dw_select_section.setitem(ll_cr,'dw_sql',ls_dw_syntax)

// Update modify date
ldt_today = Datetime( Today(), Now() )
dw_select_section.Setitem (ll_cr, "modify_date", ldt_today)

//$<add> 09.06.2006 By: Liang QingShi
dw_select_section.Setitem (ll_cr, "updated", 1)

//gnv_appeondb.of_autocommit( )
gnv_appeondb.of_startqueue( )
dw_select_section.update( )
if (ii_screen_id = 1 or ii_screen_id = 2) and il_data_view = 1001 then
	update ctx_screen set dw_sql = :ls_dw_syntax,modify_date = :ldt_today where data_view_id <> 1001 and screen_id = :ii_screen_id;
end if
//$<add> 03.26.2008 by Andy
dw_fields_alias.Update( )
commit;
gnv_appeondb.of_commitqueue( )
*/
ids_screen.setitem(ll_cr,'dw_sql',ls_dw_syntax)
ldt_today = Datetime( Today(), Now() )
ids_screen.Setitem (ll_cr, "modify_date", ldt_today)
ids_screen.Setitem (ll_cr, "updated", 1)

gnv_appeondb.of_startqueue( )
ids_screen.update( )

//Commented by Scofield on 2009-03-24
/*
if (ii_screen_id = 1 or ii_screen_id = 2) and il_data_view = 1001 then
	update ctx_screen set dw_sql = :ls_dw_syntax,modify_date = :ldt_today where data_view_id <> 1001 and screen_id = :ii_screen_id;
end if
*/

dw_fields_alias.Update( )
dw_properties_dw.Update()
commit;
gnv_appeondb.of_commitqueue( )
//END---Modify by Evan 07/14/2008

ids_pic.update( )	//APB Bug, Don't use appeon queue--jervis -- 11.30.2009
of_upload_pic()	//Update bitmap - 11.24.2009

dw_properties.ResetUpdate( )
uo_band.dw_syntax.ResetUpdate( )
//$<add> 03.26.2008 by Andy
dw_fields_alias.ResetUpdate( )

of_ChangeScreenLable() //Add by Evan 11/24/2008

//BEGIN---Modify by Scofield on 2010-02-23
if IsValid(m_pfe_cst_contract_data_design) then
	m_pfe_cst_contract_data_design.m_file.m_save.Enabled = false
end if
//END---Modify by Scofield on 2010-02-23

RETURN 1

end function

public function integer of_adjust_width (integer ai_width);//====================================================================
// Function: of_Adjust_Width()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    integer    ai_Width
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History: Scofield 2010-03-23
//
//====================================================================

long		ll_XPos,ll_CurrXPos,ll_ColWidth,ll_StartPos,ll_TabPos
String	ls_Objects,ls_CurrColumn,ls_ColName,ls_Modify

u_cst_dw_band ldw_Band

ldw_Band = wf_GetBand(is_CurBand)
if IsNull(ldw_Band.is_CurObj) or ldw_Band.is_CurObj = '' then Return 0

ls_CurrColumn = ldw_Band.is_CurObj
if RightA(ls_CurrColumn,2) = "_t" then
	ls_CurrColumn = LeftA(ls_CurrColumn,LenA(ls_CurrColumn) - 2)
end if

ll_CurrXPos = long(ldw_Band.Describe(ls_CurrColumn + ".X"))
ll_ColWidth = long(ldw_Band.Describe(ls_CurrColumn + ".Width"))

ll_ColWidth = ll_ColWidth + ai_Width

ls_Modify = ls_CurrColumn +   ".Width='" + String(ll_ColWidth) + "' " + &
				ls_CurrColumn + "_t.Width='" + String(ll_ColWidth) + "' "

ls_Objects = ldw_Band.Describe("Datawindow.Objects") + "~t"

ll_TabPos = PosA(ls_Objects,"~t")
do while ll_TabPos > 0
	ls_ColName = MidA(ls_Objects,ll_StartPos,ll_TabPos - ll_StartPos)

	// Determine if object is the right type and in the right band
	if	ldw_Band.Describe(ls_ColName + ".Visible") = "1" then
		ll_XPos = long(ldw_Band.Describe(ls_ColName + ".X"))
		if ll_XPos > ll_CurrXPos then
			ll_XPos   += ai_Width
			ls_Modify += ls_ColName + ".X='" + String(ll_XPos) + "' "
		end if
	end if

	ll_StartPos = ll_TabPos + 1
	ll_TabPos   =  PosA(ls_Objects,"~t",ll_StartPos)
loop

uo_band.dw_header.Modify(ls_Modify)
uo_band.dw_detail.Modify(ls_Modify)

This.Event ue_SetModify(ls_Modify)

of_RefreshMarkPos()

Return 1

end function

public function integer of_adjust_position (integer ai_position);//====================================================================
// Function: of_Adjust_Position()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    integer    ai_Position
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History: Scofield 2010-03-23
//
//====================================================================

long		ll_XPos,ll_TabPos,ll_ColSpace,ll_StartPos
long		ll_CurrXPos,ll_NextXPos,ll_CurrWidth,ll_NextWidth
String	ls_Objects,ls_Modify,ls_Visible,ls_Band,ls_ObjType
String	ls_CurrColumn,ls_NextColumn,ls_ColName

u_cst_dw_band ldw_Band

ldw_Band = wf_GetBand(is_CurBand)
if IsNull(ldw_Band.is_CurObj) or ldw_Band.is_CurObj = '' then Return 0

ls_CurrColumn = ldw_Band.is_CurObj

if RightA(ls_CurrColumn,2) = "_t" then
	ls_CurrColumn = LeftA(ls_CurrColumn,LenA(ls_CurrColumn) - 2)
end if

ll_CurrXPos = Long(ldw_Band.Describe(ls_CurrColumn + ".X"))

if ai_Position > 0 then
	ll_NextXPos = 100000
	
	ls_Objects = ldw_Band.Describe("Datawindow.Objects") + "~t"

	ll_TabPos = PosA(ls_Objects,"~t")
	do while ll_TabPos > 0
		ls_ColName = MidA(ls_Objects,ll_StartPos,(ll_TabPos - ll_StartPos))
		
		ls_Visible = ldw_Band.Describe(ls_ColName + ".Visible")
		ls_Band    = ldw_Band.Describe(ls_ColName + ".Band")
		ls_ObjType = ldw_Band.Describe(ls_ColName + ".Type")
		
		// Determine if object is the right type and in the right band
		if	ls_Visible = "1" and ls_Band = "detail" and ls_ObjType <> "text" Then
			ll_XPos = long(ldw_Band.Describe(ls_ColName + ".X"))
			if ll_CurrXPos < ll_XPos and ll_XPos < ll_NextXPos then
				ls_NextColumn = ls_ColName
				ll_NextXPos   = ll_XPos
			end if
		end if
	
		ll_StartPos = ll_TabPos + 1
		ll_TabPos   = PosA(ls_Objects,"~t",ll_StartPos)
	loop

	if LenA(ls_NextColumn) > 0 then
		ll_NextWidth = long(ldw_Band.Describe(ls_NextColumn + ".Width"))
		ll_CurrWidth = long(ldw_Band.Describe(ls_CurrColumn + ".Width"))
		ll_ColSpace  = ll_NextXPos - ll_CurrXPos - ll_CurrWidth
		
		ls_Modify = ls_NextColumn +   ".X='" + String(ll_CurrXPos) + "' " + &
						ls_NextColumn + "_t.X='" + String(ll_CurrXPos) + "' " + &
						ls_CurrColumn +   ".X='" + String(ll_CurrXPos  + ll_NextWidth + ll_ColSpace) + "' " + &
						ls_CurrColumn + "_t.X='" + String(ll_CurrXPos  + ll_NextWidth + ll_ColSpace) + "'"
	end if
else
	ll_NextXPos = -100000
	
	ls_Objects = ldw_Band.Describe("Datawindow.Objects") + "~t"
	
	ll_TabPos = PosA(ls_Objects,"~t")
	do while ll_TabPos > 0
		ls_ColName = MidA(ls_Objects,ll_StartPos,(ll_TabPos - ll_StartPos))
		
		ls_Visible = ldw_Band.Describe(ls_ColName + ".Visible")
		ls_Band    = ldw_Band.Describe(ls_ColName + ".Band")
		ls_ObjType = ldw_Band.Describe(ls_ColName + ".Type")
		
		// Determine if object is the right type and in the right band
		if	ls_Visible = "1" and ls_Band = "detail" and ls_ObjType <> "text" Then
			ll_XPos = long(ldw_Band.Describe(ls_ColName + ".X"))
			if ll_NextXPos < ll_XPos and ll_XPos < ll_CurrXPos then
				ls_NextColumn = ls_ColName
				ll_NextXPos   = ll_XPos
			end if
		end if
	
		ll_StartPos = ll_TabPos + 1
		ll_TabPos   =  PosA(ls_Objects,"~t",ll_StartPos)
	loop

	if LenA(ls_NextColumn) > 0 then
		ll_NextWidth = long(ldw_Band.Describe(ls_NextColumn + ".Width"))
		ll_CurrWidth = long(ldw_Band.Describe(ls_CurrColumn + ".Width"))
		ll_ColSpace  = ll_CurrXPos - ll_NextXPos - ll_NextWidth
		
		ls_Modify = ls_CurrColumn +   ".X='" + String(ll_NextXPos) + "' " + &
						ls_CurrColumn + "_t.X='" + String(ll_NextXPos) + "' " + &
						ls_NextColumn +   ".X='" + String(ll_NextXPos  + ll_CurrWidth + ll_ColSpace) + "' " + &
						ls_NextColumn + "_t.X='" + String(ll_NextXPos  + ll_CurrWidth + ll_ColSpace) + "'"
	end if
end if

uo_band.dw_header.Modify(ls_Modify)
uo_band.dw_detail.Modify(ls_Modify)

This.Event ue_SetModify(ls_Modify)

of_RefreshMarkPos()

Return 1

end function

public subroutine of_restore_properties (datawindow adw_target);//Temporary process property of border
long ll_i,ll_count

//comment 11/09/2007 by: Andy
/*
ll_count = UpperBound(is_backup_border)

for ll_i = 1 to ll_count
	adw_target.Modify(is_backup_objects[ll_i] + ".border =" + is_backup_border[ll_i] )
next 
*/
//end of comment

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.12.2007 By: Jack
//$<reason> Fix a defect.

ll_count = UpperBound(is_button_object)
For ll_i = 1 To ll_count
	adw_target.Modify(is_button_object[ll_i] + ".visible =" + is_button_visible[ll_i] )
Next 
//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_expression_sheet ();/**********************************************
Function: of_expression_sheet() returns (none)
describe: open expression dialog box
author  : Andy 06/21/2007
**********************************************/
str_pass  lstr_pass
String    ls_Expression
n_cst_string lnvo_string
u_cst_dw_band ldw_band

//Modified by gavin on 2009-03-04
//ldw_band = parent_window_design.wf_getband( parent_window_design.is_CurBand )
ldw_band = wf_getband( is_CurBand )
if isNull(ldw_band.is_curobj) or ldw_band.is_curobj = '' then return 0

ls_Expression = ldw_Band.describe(ldw_band.is_curobj +".Expression")
if isnull(ls_Expression) then ls_Expression = ''
//<Modify> 08/10/2007 by: Andy Reason:BugV080401
IF Upper( appeongetclienttype() ) = 'PB' THEN
	if LeftA(ls_Expression,1) = '"' and RightA(ls_Expression,1) = '"' then
		ls_Expression = MidA(ls_Expression,2,LenA(ls_Expression) - 2)
	end if
	ls_Expression = lnvo_string.of_globalreplace( ls_Expression, '~~"', '"')
end if
//end if
lstr_pass.s_long[1] = 2	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
//lstr_pass.l_facility_id     = -1//-1:screen/else:export
lstr_pass.s_string          = ls_Expression//expression
lstr_pass.s_string_array[1] = ldw_band.is_curobj//object name
lstr_pass.s_u_dw            = ldw_Band//relative dw
openwithparm(w_report_expression,lstr_pass)

return 0

end function

public function integer of_create_dynamic_dw (integer ai_screen_id);String ls_sql
Long ll_cr
//Integer li_pos//modified by nova 2008-09-23
long li_pos
String ls_error_create
Long ll_dw_sql_len
Long ll_screen_id
Long ll_updated
Long ll_FindRow

//BEGIN---Modify by Evan 07/14/2008
/*
ll_cr = dw_select_section.Getrow()
IF ll_cr = 0 THEN
	//MessageBox("Select View", "You must first select a view before adding sections.")
	Return 0
END IF
il_dw_style = 0
ls_sql = dw_select_section.GetitemString(ll_cr, "dw_sql")

//$<add> 09.06.2006 By: Liang QingShi
long ll_updated
dw_select_section.accepttext()
ll_updated = dw_select_section.getitemnumber(ll_cr,'updated')
IF appeongetclienttype() = 'PB' and ll_updated = 0 THEN
//$<add> 09.06.2006 By: Liang QingShi

	ll_dw_sql_len = dw_select_section.GetItemNumber( ll_cr, "dw_sql_len")
	ll_screen_id = dw_select_section.GetItemNumber( ll_cr, "screen_id")
	IF ll_dw_sql_len > 32765 THEN
		ls_sql = f_get_screen_sql(il_data_view_id, ll_screen_id)
	END IF
END IF
*/

il_dw_style = 0

ls_SQL = of_GetScreenSyntax(ai_screen_id)			//Modified by Scofield on 2009-09-29

//END---Modify by Evan 07/14/2008

IF Isnull(ls_sql) OR LenA(ls_sql) = 0 THEN
	Messagebox("Generate DataWindow", "The DataWindow does not exist in the database!")
	RETURN -1
END IF

// Convert grid style to tabular
li_pos = PosA(ls_sql,"processing=1")
IF li_pos > 0 THEN
	ls_sql = LeftA(ls_sql,li_pos - 1) + "processing=0" + MidA(ls_sql, li_pos + 12)
	il_dw_style = 1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.27.2007 By: Jack 
//$<reason> Fix a defect.
If ii_screen_id = 2 Then
	//$<comment> 01.11.2008 by: Andy
	//Reason:There are many invisible objects,if these range in a row,there is a bug in WEB verion(can not display all invisible objects when Show Invisible button is clicked).
	//il_dw_style = 1
	
	li_pos = PosA(ls_sql,"1	if( master_contract_id > 0,1,0)")
	IF li_pos > 0 THEN
		ls_sql = LeftA(ls_sql,li_pos - 1) + "1" + MidA(ls_sql, li_pos + 33)
	End If
	
	li_pos = PosA(ls_sql,"1	if( master_cnt > 0 ,1,0)")
	IF li_pos > 0 THEN
		ls_sql = LeftA(ls_sql,li_pos - 1) + "1" + MidA(ls_sql, li_pos + 26)
	End If	
End If	

//$<add> 2007-11-02 By: Andy
//parent_window_design.wf_makeband( ls_sql)
this.wf_makeband( ls_sql)  //modify by gavin on 2009/3/4

//---------------------------- APPEON END ----------------------------

// Free form style
IF il_dw_style = 0 THEN
	//$<comment> 2007-11-07 By: Andy
	//idw_detail.Modify( "DataWindow.Detail.Height = 20000" )
	
	uo_design.pb_column.Visible = TRUE
	uo_design.pb_compute.Visible = TRUE
	uo_design.pb_text.Visible = TRUE
	uo_design.r_2.Visible = TRUE
	//uo_design.st_2.Visible = TRUE
	uo_design.st_7.Visible = TRUE
	uo_design.pb_groupbox.Visible = TRUE
	uo_design.pb_oval.Visible = TRUE		//Added by Scofield on 2009-03-20
	//<add> 06/21/2007 by: Andy
	uo_design.pb_picture.Visible = TRUE
	//end of add
	uo_design.st_3.Visible = FALSE
	uo_design.st_4.Visible = FALSE
	uo_design.hsb_1.Visible = FALSE
	uo_design.hsb_2.Visible = FALSE
	
	uo_design.st_show_invisible.Visible = FALSE		//Added by Scofield on 2010-03-23
ELSE
	//$<comment> 2007-11-07 By: Andy
	//idw_detail.Modify( "DataWindow.Detail.Height = 1000" )
	
	uo_design.pb_compute.Visible = FALSE
	uo_design.pb_column.Visible = FALSE
	uo_design.pb_text.Visible = FALSE
	uo_design.r_2.Visible = FALSE
	//uo_design.st_2.Visible = false
	uo_design.st_7.Visible = false
	uo_design.pb_groupbox.Visible = FALSE
	uo_design.pb_oval.Visible = FALSE	//Added by Scofield on 2009-03-20
	//<add> 06/21/2007 by: Andy
	uo_design.pb_picture.Visible = FALSE
	//end of add	
	uo_design.st_3.Visible = TRUE
	uo_design.st_4.Visible = TRUE
	uo_design.hsb_1.Visible = TRUE
	uo_design.hsb_2.Visible = TRUE
	
	uo_design.st_show_invisible.Visible = TRUE		//Added by Scofield on 2010-03-23
	
	//$<modify> 01.11.2008 By: Andy
	uo_band.dw_detail.Modify("DataWindow.Selected.Mouse = No")
END IF

//$<add> 03.25.2008 by Andy
dw_fields_alias.retrieve( 1 , ','+String(ii_screen_id)+',' , il_data_view)
//end of add 03.25.2008

ib_AlwaysUpdate = false		//Added by Scofield on 2009-10-12

RETURN 1

end function

public function integer of_field_property_sheet ();long		ll_SelObjCnts
String	ls_ObjName,ls_Type,ls_Field_id
//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
//$Reason:str_set_properties object of ISG saved as str_set_properties_rpt
  /*
    str_set_properties lstr_item  
  */
 str_set_properties_rpt lstr_item
//---------End Modfiied ------------------------------------------------------------------


ll_SelObjCnts = of_GetSelectedObjectCnts()
if ll_SelObjCnts <> 1 then Return 0

ls_ObjName = of_GetLastSelectedObject()
ls_Type = of_GetSelectedObjectType(ls_ObjName)

if ls_Type = "compute" then
	Return of_expression_sheet()
end if

if RightA(ls_ObjName, 2) = "_t" then
	ls_Field_id = of_GetSelectedObjectTag(ls_ObjName)
else
	if Lower(ls_Type) = "column" then
		ls_Field_id = of_GetSelectedObjectID(ls_ObjName)
	end if
end if

if Trim(ls_Field_id) = "" or IsNull(ls_Field_id) or Not IsNumber(ls_Field_id) then
	Return 0
end if

if ls_Field_id <> '?' then
	dw_properties.SetFilter("data_view_fields_field_id = " + ls_Field_id )
	dw_properties.Filter()
else
	Return 0
end if

if dw_properties.Rowcount() = 0 then Return 0

if Not IsValid(w_intellicred_field_properties) then
   lstr_item.lst_data_design = this
	lstr_item.lst_menu = uo_design
   lstr_item.lst_band_painter = uo_band
	lstr_item.dw_item = dw_properties
	
	OpenWithParm(w_intellicred_field_properties,lstr_item)
end if

Return 0

end function

public function integer of_dw_property_sheet ();//Modify by gavin on 2009/3/5
IF is_open_style = 'report' THEN
	//
ELSE
	Open(w_contract_dw_properties)
	dw_properties_dw.ShareData(w_contract_dw_properties.dw_properties_dw)
END IF

Return 1
end function

public function integer of_modifydwproperties (string as_property);string ls_Modify

// Modify datawindow properties
choose case as_Property
	case "background_color"
		ls_Modify = "datawindow.color=" + String(dw_properties_dw.object.background_color[1])
	case else
		Return 0
end choose

uo_band.dw_syntax.Modify(ls_Modify)

// Refresh datawindow color
uo_band.dw_header.Modify(ls_Modify)
uo_band.dw_detail.Modify(ls_Modify)
uo_band.dw_summary.Modify(ls_Modify)
uo_band.dw_footer.Modify(ls_Modify)

//Add by jervis 09.11.2009
uo_band.dw_headergroup.Modify(ls_Modify)
uo_band.dw_headergroup2.Modify(ls_Modify)
uo_band.dw_headergroup3.Modify(ls_Modify)
uo_band.dw_trailergroup.Modify(ls_Modify)
uo_band.dw_trailergroup2.Modify(ls_Modify)
uo_band.dw_trailergroup3.Modify(ls_Modify)

Return 1

end function

public function integer of_text_property_sheet (string as_object);//Modified by gavin on 2009-02-27
//Open(w_contract_text_properties)
OpenWithParm(w_intellicred_text_properties,this)  //2009-02-27
dw_properties_text.ShareData(w_intellicred_text_properties.dw_properties_text)
dw_properties_text.Event ue_Retrieve(as_Object)
w_intellicred_text_properties.dw_properties_text.SetColumn("text")		//Added by Scofield on 2009-10-12

Return 1

end function

public function long of_getcurrentscreenhandle ();Return il_CurrentScreenHandle
end function

public function integer of_changescreenlable ();//////////////////////////////////////////////////////////////////////
// $<function>  of_changescreenlable
// $<arguments> (None)
// $<returns>   integer
// $<description> Change screen lable of tree item
//////////////////////////////////////////////////////////////////////
// $<add> 11/24/2008 by Evan
//////////////////////////////////////////////////////////////////////

long ll_FindRow
string ls_titlebar_text
TreeViewItem ltiv_item

ll_FindRow = dw_properties_dw.Find("screen_id = " + String(ii_screen_id), 1, dw_properties_dw.RowCount())
if ll_FindRow > 0 then
	ls_titlebar_text = dw_properties_dw.GetItemString(ll_FindRow, "titlebar_text")
	if LenA(ls_titlebar_text) > 0 then
		uo_select.tv_screen.GetItem(il_CurrentScreenHandle, ltiv_item)
		ltiv_item.Label = ls_titlebar_text
		uo_select.tv_screen.SetItem(il_CurrentScreenHandle, ltiv_item)
	end if
end if

Return 1
end function

public function integer of_oval_property_sheet (string as_object);//====================================================================
// Function: of_oval_property_sheet()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_object	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-25
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

////Modified by gavin on 2009-03-04
//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
//$Reason:str_set_properties object of ISG saved as str_set_properties_rpt
  /*
    str_set_properties lstr_item  
  */
 str_set_properties_rpt lstr_item
//---------End Modfiied ------------------------------------------------------------------


lstr_item.lst_data_design = this
lstr_item.lst_menu = uo_design
lstr_item.lst_band_painter = uo_band
lstr_item.dw_item = dw_properties

OpenWithParm(w_intellicred_oval_properties,lstr_item)
dw_properties_oval.ShareData(w_intellicred_oval_properties.dw_properties_oval)
dw_properties_oval.Event ue_Retrieve(as_Object)

Return 1
end function

public function integer of_init (window aw_parent, string as_style);//Add by gavin on 2009-03-04
of_set_parent_window(aw_parent)
is_open_style = as_style
return 1
end function

public function integer of_save_report ();// Add by gavin on 2009-03-04
STRING ls_obj_name
STRING ls_dw_syntax
STRING ls_field_nm 
Integer i,li_col_cnt
Long ll_cr
Long li_pos
DateTime ldt_today
Long ll_max_height
Long ll_col_y, ll_col_height
string ls_visible
long	 ll_count
blob	 lb_syntax

IF ib_set_tab_order THEN
	Return 0
END IF

//$<add> 28/04/2007 By: Jervis
//$<reason> temporary process property of border for compute
of_restore_properties(uo_band.dw_syntax)
//---------------------------- APPEON END ----------------------------

//Get syntax
ls_dw_syntax = uo_band.dw_syntax.Describe("DataWindow.Syntax")
//messagebox("",ii_data_view)
//$<Modify> 2007-11-20 By: Andy
//$<Reason> Fix a defect.
//parent_window_design.is_OrgSyntax = ls_dw_syntax
is_OrgSyntax = ls_dw_syntax        //Modified by gavin on 2009-03-05

ldt_today = Datetime( Today(), Now() )
select count(*) into :ll_count from ctx_report_syntax where view_id=:ii_data_view;
lb_syntax = blob(ls_dw_syntax,EncodingAnsi!) //Encoding – Nova 11.16.2010
gnv_appeondb.of_startqueue( )

if ll_count=0 then
	insert ctx_report_syntax(view_id,dw_sql,modify_date) values(:ii_data_view,:ls_dw_syntax,:ldt_today);
else
	update ctx_report_syntax set dw_sql = :ls_dw_syntax,modify_date=:ldt_today where view_id=:ii_data_view;
end if
updateblob ctx_report_syntax set dw_syntax = :lb_syntax where view_id=:ii_data_view;
commit;
gnv_appeondb.of_commitqueue( )

ids_pic.update( )	//APB Bug, Don't use appeon queue--jervis -- 11.30.2009
of_upload_pic()	//Update bitmap - 11.24.2009

dw_properties.ResetUpdate( )
uo_band.dw_syntax.ResetUpdate( )
//$<add> 03.26.2008 by Andy
dw_fields_alias.ResetUpdate( )

of_ChangeScreenLable() 
ib_DoSave = false // even 10.11.2010

RETURN 1
end function

public function integer of_select_report ();//add function by evan on 09.25.2010
string ls_data_view_name
string ls_orgsyntax
string ls_filename
long ll_i,ll_pic_id

select view_name into :ls_data_view_name from conv_view where view_id = :ii_data_view;
if not (isnull(ls_data_view_name) or trim(ls_data_view_name) = '') then
	parent_window_design.Title = "Advanced Screen Design Painter ( " + ls_data_view_name + " )"
end if

// Download picture
ids_pic.SetFilter("pic_filename<>'!'")
ids_pic.Retrieve( ii_data_view,0)
for ll_i = 1 to ids_pic.rowcount( )
	ls_filename = ids_pic.GetItemString( ll_i,"pic_filename")
	ll_pic_id = ids_pic.GetItemNumber( ll_i,"pic_id")
	of_download_pic(ll_pic_id,ls_filename)
next
ids_pic.SetFilter("")
ids_pic.Filter()

// Make band according to datawindow syntax
of_set_datagroup(True)
ls_orgsyntax = idw_original.describe("datawindow.syntax")
wf_makeband(ls_orgsyntax)

// Show invisible objects
of_show_invisible(ib_show_invisible)

Return 1
end function

public function integer of_set_datagroup (boolean ab_group);//Add by gavin on 2009/3/2
ib_show_datagroup = ab_group
return 1
end function

public function integer wf_addobject (string as_objtype, long al_x, long al_y);//====================================================================
// Function : wf_addobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_objtype	
// 	long  	al_x      	
// 	long  	al_y      	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 6,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String 	ls_NewName,ls_Modify,ls_err,ls_band='',ls_index, ls_objects,ls_LabelText
long 		ll_x,ll_y,ll_row,ll_k,ll_max,ll_Object_No,ll_LabelWidth
String 	ls_ObjName
string ls_filename,ls_path,ls_path_to
integer li_find

u_cst_dw_band   	ldw_band
str_pass 			lstr_pass,lstr_Ret

if Lower(as_objType) <> Lower('text') and Lower(as_objType) <> Lower('groupbox') and &
	Lower(as_objType) <> Lower('compute') and Lower(as_objType) <> Lower('oval') and &
	Lower(as_objType) <> Lower('picture') then
	Return wf_AddInVisibleField(as_objType,al_x,al_y)
end if

st_add.visible = False

ll_x = al_x
ll_y = al_y

CHOOSE CASE UPPER(is_CurBand)
	CASE 'HEADER'
		ls_Band = 'header'
		ldw_band = uo_band.dw_Header		
	CASE 'DETAIL'
		ls_Band = 'detail'
		ldw_band = uo_band.dw_detail		
	CASE 'SUMMARY'
		ls_Band = 'summary'
		ldw_band = uo_band.dw_Summary		
	CASE 'FOOTER'
		ls_Band = 'footer'
		ldw_Band = uo_band.dw_Footer
	CASE 'HEADER.1'
		ls_Band = 'header.1'
		ldw_band = uo_band.dw_Headergroup
	CASE 'HEADER.2'
		ls_Band = 'header.2'
		ldw_band = uo_band.dw_Headergroup2
	CASE 'HEADER.3'
		ls_Band = 'header.3'
		ldw_band = uo_band.dw_Headergroup3
	CASE 'TRAILER.1'
		ls_Band = 'trailer.1'
		ldw_band = uo_band.dw_trailergroup
	CASE 'TRAILER.2'
		ls_Band = 'trailer.2'
		ldw_band = uo_band.dw_trailergroup2
	CASE 'TRAILER.3'
		ls_Band = 'trailer.3'
		ldw_band = uo_band.dw_trailergroup3
	CASE else
		Return -1
END CHOOSE

if ls_Band = '' then Return -1

if is_Compute_Label_Name = "" then
	ll_Object_No = 0
	do
		ll_Object_No++
		ls_NewName = "object" + String(ll_Object_No) + "_" + LeftA(is_AddObjectType,1)
		ls_ObjName = uo_band.dw_syntax.Describe(ls_NewName + ".name")
	loop while ls_ObjName <> "!"
	
	ldw_Band.is_NewObjName = ls_NewName
	
	//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
	//$Reason:The w_InVisibleFieldList object of ISG was saved as w_InVisibleFieldList_rpt
	  /*
		OpenWithParm(w_SpecifyObjectName,ldw_Band)	
	  */
	 OpenWithParm(w_SpecifyObjectName_rpt,ldw_Band)
	//---------End Modfiied ------------------------------------------------------------------

	
	
	ls_NewName = Message.StringParm
	if IsNull(ls_NewName) or Trim(ls_NewName) = "" then
		is_addobjectType = ''
		Return 1
	end if
	ls_LabelText = "text"
	ll_LabelWidth = 150
else
	ls_NewName = is_Compute_Label_Name
	ls_LabelText = is_Compute_Label_Text
	ll_LabelWidth = 520
end if

choose case lower(as_objType)
	case 'text'
		ls_Modify = 'create text(band=' + ls_Band + ' alignment="0" text="' + ls_LabelText + '" border="0" color="0" '&
						+ 'x="' + string(ll_x) + '" y="' + string(ll_y)+'" height="52" width="' + String(ll_LabelWidth) + '" '&
						+ ' name=' + ls_NewName + ' font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
	case 'groupbox'
		ls_Modify = 'create groupbox(band=' + ls_Band + ' text="none" border="5" color="128" x="' + string(ll_x) + '" y="' + string(ll_y) + '" height="390" width="660"  name=' + ls_NewName + '  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
	case 'compute'
		ls_Modify = 'create compute(band=' + ls_Band + ' alignment="0" expression="" border="0" color="0" x="' + string(ll_x) + '" y="' + string(ll_y) + '" height="52" width="520"  name=' + ls_NewName + ' font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
   Case 'oval'
		ls_Modify = 'create ellipse(band=' + String(ls_Band) + ' x="' + String(ll_x) + '" y="' + String(ll_y) + '" height="120" width="137"  name=' + String(ls_NewName) + ' visible="1" brush.hatch="6" brush.color="33554432" pen.style="0" pen.width="5" pen.color="1073741824"  background.mode="2" background.color="33554432" )'
	case 'picture'	//Add picture - jervis 11.20.2009
		//if GetFileOpenName("Select File", ls_path, ls_filename, "jpg","JPEG(*.jpg;*.jpeg),*.jpg;*.jpeg,GIF(*.gif),*.gif,Bitmap(*.bmp),*.bmp") = 1 then
		if GetFileOpenName("Select File", ls_path, ls_filename, "jpg","JPEG(*.jpg;*.jpeg),*.jpg;*.jpeg,GIF(*.gif),*.gif,Bitmap(*.bmp),*.bmp,PNG Files (*.PNG),*.png") = 1 then //alfee 04.01.2017
			//File size less than 200K
			if filelength(ls_path) > 1024 * 200 then 
				MessageBox('Select File',"The file you selected must be less than 200K.")
				return 1
			end if
			
			//Copy file to temp local path
			if is_open_style = 'report' then   //ReportID + Object Name
				ls_filename = "R_"+string(ii_data_view) + "_" + ls_NewName + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + MidA(ls_filename,PosA(ls_filename,"."))
			else	//ViewID + ScreenID + Object Name
				ls_filename = "S_"+string(il_data_view) + "_" + string(ii_screen_id) + "_" + ls_NewName + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + MidA(ls_filename,PosA(ls_filename,"."))
			end if
			ls_path_to = gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" + ls_filename 
			
			
			//Save the pic to db
			//li_find = ids_pic.Find("pic_name = '" + ls_path_to + "'",1,ids_pic.RowCount())
			//if li_find > 0 then
			//else
				if FileCopy(ls_path,ls_path_to) <> 1 then return 1
				ll_row = ids_pic.InsertRow(0)
				if is_open_style = 'screen' then
					ids_pic.SetItem(ll_row,'view_id',il_data_view)
					ids_pic.SetItem(ll_row,'screen_id',ii_screen_id)
				else
					ids_pic.SetItem(ll_row,'view_id',ii_data_view)
					ids_pic.SetItem(ll_row,'screen_id',0)
				end if
				ids_pic.SetItem(ll_row,"pic_type",is_open_style)
				ids_pic.SetItem(ll_row,"pic_band",ls_band)
				ids_pic.SetItem(ll_row,"pic_name",lower(ls_NewName))
				ids_pic.SetItem(ll_row,"pic_filename",ls_filename)
				ids_pic.SetItem(ll_row,"pic_x",ll_x)
				ids_pic.SetItem(ll_row,"pic_y",ll_y)
				ids_pic.SetItem(ll_row,"pic_width",137)
				ids_pic.SetItem(ll_row,"pic_height",120)
				//ids_pic.SetItem(pic_tag	varchar(100)
			//end if
			
			ls_Modify = 'create bitmap(band=' + String(ls_Band) + ' x="' + String(ll_x) + '" y="' + String(ll_y) + '" height="120" width="137"  name=' + String(ls_NewName) + ' visible="1" filename = "' + ls_path_to + '" )'
		else
			return 1
		end if 
end choose

ls_err = ldw_Band.Modify(ls_Modify)
ls_err = this.Event ue_SetModify(ls_Modify)

 //Send group box to back to walk around a bug, Added by Appeon long.zhang 05.16.2016 (Bug id 5146 - Some Computed fields not saving in PDF document)
If lower(as_objType) = 'groupbox' and ib_gb_sendtoback Then 
	//Update ldw_Band and dw_syntax
	of_sendtoback(ldw_Band, ls_NewName, ls_Band)
End If

if ls_err<>'' then 
	MessageBox('',ls_err + '~r~n~r~n'+ls_Modify)
else
	if as_objType = 'compute' then
		if ib_IsAddSummary then //Evan 10.08.2010 (V10.5-Advanced Report)
			lstr_pass.s_string_array[1] = ls_NewName
			lstr_pass.s_u_dw            = ldw_Band
			OpenWithParm(w_custom_report_summary, lstr_pass)
			ib_IsAddSummary = false
		else
			lstr_pass.s_long[1] = 2	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
			//lstr_pass.l_facility_id     = -1//-1:screen/else:export
			lstr_pass.s_string          = ""//expression
			lstr_pass.s_string_array[1] = ls_NewName//object name
			lstr_pass.s_u_dw            = ldw_Band//relative dw		
			OpenWithParm(w_report_expression,lstr_pass)			
		end if
		lstr_Ret = message.Powerobjectparm
		// Canceled		
		if Not IsValid(lstr_Ret) or ISNULL(lstr_Ret) THEN
			ldw_Band.Modify("destroy " + ls_NewName)
			this.event ue_SetModify("destroy " + ls_NewName)
		else
			ldw_Band.is_Objects[UpperBound(ldw_Band.is_Objects) + 1] = ls_NewName
			ldw_Band.is_OrgObj = ldw_Band.is_CurObj
			ldw_band.is_CurObj = ls_NewName
			ldw_Band.is_OrgObj = ldw_Band.is_CurObj
			ldw_Band.of_SetDesign(ls_NewName)			
			if UpperBound(lstr_Ret.s_string_array) > 0 then
				is_Compute_Label_Text = lstr_Ret.s_string_array[1]
			end if
		end if
	else
		ldw_Band.is_Objects[UpperBound(ldw_Band.is_Objects) + 1] = ls_NewName
		ldw_Band.is_OrgObj = ldw_Band.is_CurObj
		ldw_band.is_CurObj = ls_NewName
		ldw_Band.is_OrgObj = ldw_Band.is_CurObj
		ldw_Band.of_SetDesign(ls_NewName)		
	end if
end if

if as_objType = 'compute' and IsValid(lstr_Ret) and is_Compute_Label_Text <> "" then
	st_add.Width = 1970
	st_add.X = uo_band.X + (uo_band.Width - st_add.Width)/2
	st_add.Y = 1500
	st_add.TextSize = -12
	
	st_add.Text = "Click where you want to add the computed field label."
	st_add.visible = true
	is_addobjectType = "text"
	is_Compute_Label_Name = ls_NewName + "_t"
else
	is_addobjectType = ""
	is_Compute_Label_Name = ""
	is_Compute_Label_Text = ""
end if

of_UnSelectAllObject()
ldw_Band.of_AddorDelSingleSelect(ls_NewName,true)
of_Refresh_Object_Inforamtion()

Return 1
end function

public function boolean of_get_datagroup ();//Add by gavin on 2009/3/4
return ib_show_datagroup
end function

public function u_cst_dw_band wf_getband (string as_band);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
u_cst_dw_band  ldw
GraphicObject lobject

CHOOSE CASE upper(as_Band)
	CASE 'HEADER'
		return uo_band.dw_header
	CASE 'DETAIL'
		return uo_band.dw_detail
	CASE 'SUMMARY'
		return uo_band.dw_Summary
	CASE 'FOOTER'
		return uo_band.dw_Footer
	CASE 'HEADER.1'
		return uo_band.dw_headergroup
	CASE 'HEADER.2'
		return uo_band.dw_headergroup2
	CASE 'HEADER.3'
		return uo_band.dw_headergroup3
	CASE 'TRAILER.1'
		return uo_band.dw_trailergroup
	CASE 'TRAILER.2'
		return uo_band.dw_trailergroup2
	CASE 'TRAILER.3'
		return uo_band.dw_trailergroup3
	CASE ELSE		
		return uo_band.dw_Header
END CHOOSE
//--
end function

public function long wf_isselected (string as_name);//--------------------------- APPEON BEGIN ---------------------------

//====================================================================
// Function: wf_isselected()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_name	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long   ll,ll_Count

ll_Count = upperbound(istr_SelectObj)
FOR ll = 1 TO ll_Count
	IF lower(istr_SelectObj[ll].FName) = lower(as_name) THEN
		return ll
	END IF
NEXT

return -1

//---------------------------- APPEON END ----------------------------


end function

public function integer wf_makeband (string as_syntax);//////////////////////////////////////////////////////////////////////
// $<function> wf_makeband
// $<arguments>
//			string	as_syntax
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.25.2010
//////////////////////////////////////////////////////////////////////

string  ls_Syntax, ls_Err

// Get datawindow syntax
ls_Syntax = as_syntax
uo_band.dw_Syntax.Create(ls_Syntax)
uo_band.dw_Syntax.settransobject(SQLCA)
of_retrieve_dw_properties( uo_band.dw_Syntax )
is_OrgSyntax = uo_band.dw_syntax.Describe('Datawindow.Syntax')

// Create group 1 band
if Pos(is_OrgSyntax, "group(level=1") > 0 then
	uo_band.dw_headergroup.visible = true
	uo_band.st_headergroup.visible = true
	uo_band.dw_trailergroup.visible = true
	uo_band.st_trailergroup.visible = true
	//
	uo_band.dw_headergroup.Create(is_OrgSyntax,ls_err)
	uo_band.dw_headergroup.Dynamic Event ue_regenerate()
	uo_band.dw_headergroup.idw_syntax = uo_band.dw_syntax
	//
	uo_band.dw_trailergroup.Create(is_OrgSyntax,ls_err)
	uo_band.dw_trailergroup.Dynamic Event ue_regenerate()
	uo_band.dw_trailergroup.idw_syntax = uo_band.dw_syntax
	//
	uo_band.dw_headergroup.Height = long(uo_band.dw_syntax.describe("datawindow.header.1.height"))
	uo_band.dw_trailergroup.Height = long(uo_band.dw_syntax.describe("datawindow.trailer.1.height"))
	uo_band.st_headergroup.height = uo_band.BANDSEPHEIGHT
	uo_band.st_trailergroup.height = uo_band.BANDSEPHEIGHT
	wf_SetBandText(1)
else
	uo_band.dw_headergroup.visible = false
	uo_band.st_headergroup.visible = false
	uo_band.dw_trailergroup.visible = false
	uo_band.st_trailergroup.visible = false
	//
	uo_band.dw_headergroup.Height = 0
	uo_band.st_headergroup.height = 0
   uo_band.dw_trailergroup.Height = 0	
	uo_band.st_trailergroup.height = 0
end if

// Create group 2 band
if Pos(is_OrgSyntax, "group(level=2") > 0 then
	uo_band.dw_headergroup2.visible = true
	uo_band.st_headergroup2.visible = true
	uo_band.dw_trailergroup2.visible = true
	uo_band.st_trailergroup2.visible = true	
	//
	uo_band.dw_headergroup2.Create(is_OrgSyntax,ls_err)
	uo_band.dw_headergroup2.Dynamic Event ue_regenerate()
	uo_band.dw_headergroup2.idw_syntax = uo_band.dw_syntax
	//
	uo_band.dw_trailergroup2.Create(is_OrgSyntax,ls_err)
	uo_band.dw_trailergroup2.Dynamic Event ue_regenerate()
	uo_band.dw_trailergroup2.idw_syntax = uo_band.dw_syntax
	//
	uo_band.dw_headergroup2.Height = long(uo_band.dw_syntax.describe("datawindow.header.2.height"))
	uo_band.dw_trailergroup2.Height = long(uo_band.dw_syntax.describe("datawindow.trailer.2.height"))
	uo_band.st_headergroup2.height = uo_band.BANDSEPHEIGHT
	uo_band.st_trailergroup2.height = uo_band.BANDSEPHEIGHT
	wf_SetBandText(2)
else
	uo_band.dw_headergroup2.visible = false
	uo_band.st_headergroup2.visible = false
	uo_band.dw_trailergroup2.visible = false
	uo_band.st_trailergroup2.visible = false
	//
	uo_band.dw_headergroup2.Height = 0
	uo_band.st_headergroup2.height = 0
   uo_band.dw_trailergroup2.Height = 0	
	uo_band.st_trailergroup2.height = 0
end if

// Create group 3 band
if Pos(is_OrgSyntax, "group(level=3") > 0 then
	uo_band.dw_headergroup3.visible = true
	uo_band.st_headergroup3.visible = true
	uo_band.dw_trailergroup3.visible = true
	uo_band.st_trailergroup3.visible = true	
	//
	uo_band.dw_headergroup3.Create(is_OrgSyntax,ls_err)
	uo_band.dw_headergroup3.Dynamic Event ue_regenerate()
	uo_band.dw_headergroup3.idw_syntax = uo_band.dw_syntax
	//
	uo_band.dw_trailergroup3.Create(is_OrgSyntax,ls_err)
	uo_band.dw_trailergroup3.Dynamic Event ue_regenerate()
	uo_band.dw_trailergroup3.idw_syntax = uo_band.dw_syntax
	//
	uo_band.dw_headergroup3.Height = long(uo_band.dw_syntax.describe("datawindow.header.3.height"))
	uo_band.dw_trailergroup3.Height = long(uo_band.dw_syntax.describe("datawindow.trailer.3.height"))
	uo_band.st_headergroup3.height = uo_band.BANDSEPHEIGHT
	uo_band.st_trailergroup3.height = uo_band.BANDSEPHEIGHT
	wf_SetBandText(3)
else
	uo_band.dw_headergroup3.visible = false
	uo_band.st_headergroup3.visible = false
	uo_band.dw_trailergroup3.visible = false
	uo_band.st_trailergroup3.visible = false
	//
	uo_band.dw_headergroup3.Height = 0
	uo_band.st_headergroup3.height = 0
   uo_band.dw_trailergroup3.Height = 0	
	uo_band.st_trailergroup3.height = 0
end if

// Create header band
uo_band.dw_Header.Create(is_OrgSyntax,ls_err)
uo_band.dw_header.Dynamic Event ue_regenerate()
uo_band.dw_header.idw_syntax = uo_band.dw_syntax
uo_band.dw_header.Height = long(uo_band.dw_syntax.describe("datawindow.header.height"))

// Create detail band
uo_band.dw_detail.create(is_OrgSyntax,ls_err)
uo_band.dw_detail.DYNAMIC event ue_regenerate()
uo_band.dw_detail.idw_syntax = uo_band.dw_syntax
uo_band.dw_detail.Height = long(uo_band.dw_syntax.describe("datawindow.detail.height"))

// Create summary band
uo_band.dw_Summary.create(is_OrgSyntax,ls_err)
uo_band.dw_Summary.DYNAMIC event ue_regenerate()
uo_band.dw_Summary.idw_syntax = uo_band.dw_syntax
uo_band.dw_Summary.Height = long(uo_band.dw_syntax.describe("datawindow.Summary.height"))

// Create footer band
uo_band.dw_Footer.create(is_OrgSyntax,ls_err)
uo_band.dw_Footer.DYNAMIC event ue_regenerate()
uo_band.dw_footer.idw_syntax = uo_band.dw_syntax
uo_band.dw_Footer.Height = long(uo_band.dw_syntax.describe("datawindow.Footer.height"))

// Set band position Y
uo_band.st_header.y = uo_band.dw_header.y + uo_band.dw_header.height// - 4

uo_band.dw_headergroup.y = uo_band.st_header.y + uo_band.st_header.height
uo_band.st_headergroup.y = uo_band.dw_headergroup.y + uo_band.dw_headergroup.height

uo_band.dw_headergroup2.y = uo_band.st_headergroup.y + uo_band.st_headergroup.height
uo_band.st_headergroup2.y = uo_band.dw_headergroup2.y + uo_band.dw_headergroup2.height

uo_band.dw_headergroup3.y = uo_band.st_headergroup2.y + uo_band.st_headergroup2.height
uo_band.st_headergroup3.y = uo_band.dw_headergroup3.y + uo_band.dw_headergroup3.height

uo_band.dw_detail.y = uo_band.st_header.y + uo_band.st_header.height// - 4
uo_band.st_detail.y = uo_band.dw_detail.y + uo_band.dw_detail.height// - 4

uo_band.dw_trailergroup.y = uo_band.st_detail.y + uo_band.st_detail.height
uo_band.st_trailergroup.y = uo_band.dw_trailergroup.y + uo_band.dw_trailergroup.height

uo_band.dw_summary.y = uo_band.st_detail.y + uo_band.st_detail.height// - 4
uo_band.st_summary.y = uo_band.dw_summary.y + uo_band.dw_summary.height// - 4

uo_band.dw_footer.y = uo_band.st_summary.y + uo_band.st_summary.height// - 4
uo_band.st_footer.y = uo_band.dw_footer.y + uo_band.dw_footer.height// - 4

// Set band bring to top
uo_band.dw_header.bringtotop  = TRUE
uo_band.dw_detail.bringtotop  = TRUE
uo_band.dw_summary.bringtotop  = TRUE
uo_band.dw_footer.bringtotop  = TRUE
uo_band.st_header.bringtotop  = TRUE
uo_band.st_detail.bringtotop  = TRUE
uo_band.st_summary.bringtotop  = TRUE
uo_band.st_footer.bringtotop  = TRUE
uo_band.dw_headergroup.bringtotop  = TRUE
uo_band.dw_trailergroup.bringtotop  = TRUE
uo_band.st_headergroup.bringtotop  = TRUE
uo_band.st_trailergroup.bringtotop  = TRUE
uo_band.dw_headergroup2.bringtotop  = TRUE
uo_band.dw_trailergroup2.bringtotop  = TRUE
uo_band.st_headergroup2.bringtotop  = TRUE
uo_band.st_trailergroup2.bringtotop  = TRUE
uo_band.dw_headergroup3.bringtotop  = TRUE
uo_band.dw_trailergroup3.bringtotop  = TRUE
uo_band.st_headergroup3.bringtotop  = TRUE
uo_band.st_trailergroup3.bringtotop  = TRUE

// Do resize
This.Trigger Event ue_Resize(0,This.Width,This.Height)
of_UnSelectAllObject()
of_Refresh_Object_Inforamtion()

Return 1
end function

public function integer wf_preparecopy (u_cst_dw_band adw_band);//====================================================================
// Function: wf_preparecopy()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    u_cst_dw_band    adw_band
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String   ls_Syntax,ls_ObjName,ls_RowStr,ls_Null[]
long		ll_Cycle,ll_ObjSelCnts,ll_TotalCnts,ll_CopyCnts

is_CopySyntax = ls_Null
ll_ObjSelCnts = of_GetSelectedObjectCnts()
if ll_ObjSelCnts <= 0 then Return -1

ll_TotalCnts = UpperBound(istr_SelectObj)

ib_PreparCopying =  true

for ll_Cycle = 1 to ll_TotalCnts
	ls_ObjName = istr_SelectObj[ll_Cycle].Fname
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
	
	ls_Syntax = istr_SelectObj[ll_Cycle].Fband.Describe("datawindow.syntax")
	ls_RowStr = gf_GetDWOSyntax(ls_Syntax,ls_ObjName)
	if ls_RowStr <> "" then
		ll_CopyCnts++
		is_CopySyntax[ll_CopyCnts] = ls_RowStr
	end if
next

if ll_CopyCnts <= 0 then
	Return -1
else
	Return 1
end if

end function

public function integer of_multiselectobjects (keycode key, unsignedlong keyflags);//====================================================================
// Function: of_MultiSelectObjects()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	keycode     	key     	
// 	value	unsignedlong	keyflags	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	andy		Date: Nov 07,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long   	ll_ObjCnts,ll_SelObjCnts,ll_Cycle,ll_X1,ll_X2,ll_Y1,ll_Y2
long  	ll_ObjX,ll_ObjY,ll_Height,ll_Width
string  	ls_RefObjName,ls_ObjName,ls_Type

u_cst_dw_band  ldw_band

if keyflags <> 2 and keyflags <> 3 then Return -1

ll_SelObjCnts = of_GetSelectedObjectCnts()
if ll_SelObjCnts <= 0 then Return -1

ls_RefObjName = of_GetLastSelectedObject()
if ls_RefObjName = '' then Return -1

ldw_Band = wf_getband(uo_band.dw_Syntax.Describe(ls_RefObjName + ".band"))

Choose CASE key
	Case KeyLeftArrow!,KeyRightArrow!
		ll_X1 = long(ldw_Band.Describe(ls_RefObjName + ".x"))
		ll_Y1 = long(ldw_Band.Describe(ls_RefObjName + ".y")) 
		ll_Y2 = ll_Y1 +  long(ldw_Band.Describe(ls_RefObjName + ".height"))
		ls_Type = ldw_Band.Describe(ls_RefObjName + ".type")
		
		ll_ObjCnts = UpperBound(ldw_Band.is_Objects[])
		for ll_Cycle = 1 to ll_ObjCnts
			ls_ObjName = ldw_Band.is_Objects[ll_Cycle]
			if ls_ObjName = ls_RefObjName then continue
			if keyflags = 3 and ls_Type <> ldw_band.Describe(ls_ObjName + ".type") then continue
			if Key = KeyLeftArrow! and long(ldw_Band.Describe(ls_ObjName + ".x")) > ll_X1 then continue
			if Key = KeyRightArrow! and long(ldw_Band.Describe(ls_ObjName + ".x")) < ll_X1 then continue

			ll_Height = long(ldw_Band.Describe(ls_ObjName + ".height"))
			ll_ObjY = long(ldw_Band.Describe(ls_ObjName + ".y"))

			if ll_ObjY >= ll_Y1 - ll_Height and ll_ObjY <= ll_Y2 then
				ldw_Band.of_AddorDelSingleSelect(ls_ObjName,true)
			end if
		next
		ldw_Band.of_AddorDelSingleSelect(ls_RefObjName,true)		//Set it to the last selected object
	Case KeyUpArrow!,KeyDownArrow!
		ll_X1 = long(ldw_Band.Describe(ls_RefObjName + ".x"))
		ll_Y1 = long(ldw_Band.Describe(ls_RefObjName + ".y")) 
		ll_X2 = ll_X1 +  long(ldw_Band.Describe(ls_RefObjName + ".Width"))
		ls_Type = ldw_Band.Describe(ls_RefObjName + ".type")
		
		ll_ObjCnts = UpperBound(ldw_Band.is_Objects[])
		for ll_Cycle = 1 to ll_ObjCnts
			ls_ObjName = ldw_Band.is_Objects[ll_Cycle]
			if ls_ObjName = ls_RefObjName then continue
			if keyflags = 3 and ls_Type <> ldw_band.Describe(ls_ObjName + ".type") then continue
			if Key = KeyUpArrow! and long(ldw_Band.Describe(ls_ObjName + ".Y")) > ll_Y1 then continue
			if Key = KeyDownArrow! and long(ldw_Band.Describe(ls_ObjName + ".Y")) < ll_Y1 then continue

			ll_Width = long(ldw_Band.Describe(ls_ObjName + ".Width"))
			ll_ObjX = long(ldw_Band.Describe(ls_ObjName + ".X"))

			if ll_ObjX >= ll_X1 - ll_Width and ll_ObjX <= ll_X2 then
				ldw_Band.of_AddorDelSingleSelect(ls_ObjName,true)
			end if
		next
		ldw_Band.of_AddorDelSingleSelect(ls_RefObjName,true)		//Set it to the last selected object
END Choose

of_Refresh_Object_Inforamtion()

Return 1

end function

public function integer wf_copyobject (u_cst_dw_band adw_band);//====================================================================
// Function: wf_copyobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    u_cst_dw_band    adw_band
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	andy		Date: 2007-11-08
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History: 
//				Author: Scofield		Date: 2009-04-13
//
//====================================================================

String  	ls_ObjectSyntax,ls_ObjName,ls_NewName,ls_ObjType,ls_index,ls_Sourband,ls_DestBand
long  	ll_Y1,ll_Y2,ll_OldX,ll_OldY,ll_Diff_X,ll_Diff_Y
long		ll_Cycle,ll_Index,ll_Pos,ll_NextBlank,ll_MinXPos,ll_MinYPos
long	 	ll_TotalCnts,ll_Cnt,ll_Object_No,ll_RightClickXPos,ll_RightClickYPos
long 		ll_row
string ls_filename

CONSTANT STRING XCOORMARK = ' x="'
CONSTANT STRING YCOORMARK = ' y="'

of_UnselectAllObject()

ll_TotalCnts = UpperBound(is_CopySyntax)
if ib_PreparCopying and ll_TotalCnts > 0 then
	for ll_Cycle = 1 to ll_TotalCnts
		ls_ObjectSyntax = is_CopySyntax[ll_Cycle]
		if IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "" then Continue
		
		ll_Pos = PosA(ls_ObjectSyntax,XCOORMARK)
		ll_OldX = long(MidA(ls_ObjectSyntax,ll_Pos + LenA(XCOORMARK),PosA(ls_ObjectSyntax,'"',ll_Pos + LenA(XCOORMARK)) - ll_Pos - LenA(XCOORMARK)))
		
		ll_Pos = PosA(ls_ObjectSyntax,YCOORMARK)
		ll_OldY = long(MidA(ls_ObjectSyntax,ll_Pos + LenA(YCOORMARK),PosA(ls_ObjectSyntax,'"',ll_Pos + LenA(YCOORMARK)) - ll_Pos - LenA(YCOORMARK)))
		
		if ll_Cycle = 1 then
			ll_MinXPos = ll_OldX
			ll_MinYPos = ll_OldY
		else
			if ll_OldX < ll_MinXPos then
				ll_MinXPos = ll_OldX
			end if
			
			if ll_OldY < ll_MinYPos then
				ll_MinYPos = ll_OldY
			end if
		end if
	next
	
	adw_Band.of_GetLastRightClickPos(ll_RightClickXPos,ll_RightClickYPos)
	
	ll_Diff_X = ll_RightClickXPos - ll_MinXPos
	ll_Diff_Y = ll_RightClickYPos - ll_MinYPos
	
	for ll_Cycle = 1 to ll_TotalCnts
		ls_ObjectSyntax = is_CopySyntax[ll_Cycle]
		if IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "" then Continue

		ll_Pos = PosA(ls_ObjectSyntax,"(")
		ls_ObjType = Trim(LeftA(ls_ObjectSyntax,ll_Pos - 1))
		ls_ObjType = MidA(ls_ObjType,1,1)
	
		ll_Pos = PosA(ls_ObjectSyntax,"name=")
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos)
		
		ls_NewName = ""
		
		if ib_cut then
			ls_NewName = MidA(ls_ObjectSyntax,ll_Pos + LenA("name="),ll_NextBlank - (ll_Pos + LenA("name=")))
			if LenA(uo_band.dw_syntax.Describe(ls_NewName + ".Band")) > 1 then ls_NewName = ""
		end if
			
		if ls_NewName = "" then
			ll_Object_No = 0
			do
				ll_Object_No++
				ls_NewName = "object" + String(ll_Object_No) + "_" + ls_ObjType
				ls_ObjName = uo_band.dw_syntax.Describe(ls_NewName + ".name")
			loop while ls_ObjName <> "!"
		end if
		
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA("name="),ll_NextBlank - (ll_Pos + LenA("name=")),ls_NewName)
		end if

		ll_Pos = PosA(ls_ObjectSyntax,"band=")
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos)
		ls_Sourband = MidA(ls_ObjectSyntax,ll_Pos + LenA("band="),ll_NextBlank - (ll_Pos + LenA("band=")))
		
		ls_DestBand = adw_band.is_BandType
		if Lower(ls_DestBand) = Lower("HeaderGroup") then
			ls_DestBand = "header.1"
		elseif Lower(ls_DestBand) = Lower("TrailerGroup") then
			ls_DestBand = "trailer.1"
		end if
		
		if ll_Pos > 0 and ll_NextBlank > 0 and Lower(ls_Sourband) <> Lower(ls_DestBand) then
			ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA("band="),ll_NextBlank - (ll_Pos + LenA("band=")),Lower(ls_DestBand))
		end if
	
		CHOOSE CASE Lower(ls_ObjType)
			CASE 'l'
				ll_Pos = PosA(ls_ObjectSyntax," y1=")
				ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ll_Y1 = long(MidA(ls_ObjectSyntax,ll_Pos + LenA(" y1=") + 1,ll_NextBlank - (ll_Pos + LenA(" y1=") + 1) - 1))
					ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA(" y1=") + 1,ll_NextBlank - (ll_Pos + LenA(" y1=") + 1) - 1,String(ll_Y1 + ll_Diff_Y))
				end if
				
				ll_Pos = PosA(ls_ObjectSyntax," y2=")
				ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ll_Y1 = long(MidA(ls_ObjectSyntax,ll_Pos + LenA(" y2=") + 1,ll_NextBlank - (ll_Pos + LenA(" y2=") + 1) - 1))
					ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA(" y2=") + 1,ll_NextBlank - (ll_Pos + LenA(" y2=") + 1) - 1,String(ll_Y1 + ll_Diff_Y))
				end if
			CASE ELSE
				ll_Pos = PosA(ls_ObjectSyntax," x=")
				ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
				ll_OldX = long(MidA(ls_ObjectSyntax,ll_Pos + LenA(" x=") + 1, ll_NextBlank - (ll_Pos + LenA(" x=") + 1) - 1))
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA(" x=") + 1,ll_NextBlank - (ll_Pos + LenA(" x=") + 1) - 1,String(ll_OldX + ll_Diff_X))
				end if

				ll_Pos = PosA(ls_ObjectSyntax," y=")
				ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
				ll_OldY = long(MidA(ls_ObjectSyntax,ll_Pos + LenA(" y=") + 1,ll_NextBlank - (ll_Pos + LenA(" y=") + 1) - 1))
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA(" y=") + 1,ll_NextBlank - (ll_Pos + LenA(" y=") + 1) - 1,String(ll_OldY + ll_Diff_Y))
				end if
		END CHOOSE
			
		ls_ObjectSyntax = "create " + ls_ObjectSyntax
		adw_band.Modify(ls_ObjectSyntax)

		if adw_band.Describe(ls_NewName + ".type") = "column" then
			ll_Pos = PosA(ls_ObjectSyntax,"border=")
			ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
			if ll_Pos > 0 and ll_NextBlank > 0 then
				ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax, ll_Pos, ll_NextBlank - ll_Pos, 'border="' + is_Border[ll_Cycle] + '"')
			end if				
		end if				
		this.Event ue_SetModify(ls_ObjectSyntax)
		
		adw_Band.is_OrgObj = ls_NewName
		adw_band.is_CurObj = ls_NewName		
		adw_band.of_AddorDelSingleSelect(ls_NewName,true)
		
		if ib_cut then
			ll_Cnt = UpperBound(adw_band.is_Objects)
			for ll_Index = 1 to ll_Cnt
				if adw_band.is_Objects[ll_Index] = ls_NewName then
					Exit
				end if
			next
			if ll_Index > ll_Cnt then
				adw_band.is_Objects[UpperBound(adw_band.is_Objects) + 1] = ls_NewName
				
				//Save the pic to db -- jervis 11.23.2009
				ll_row = ids_pic.InsertRow(0)
				if is_open_style = 'screen' then
					ids_pic.SetItem(ll_row,'view_id',il_data_view)
					ids_pic.SetItem(ll_row,'screen_id',ii_screen_id)
				else
					ids_pic.SetItem(ll_row,'view_id',ii_data_view)
					ids_pic.SetItem(ll_row,'screen_id',0)
				end if
				ids_pic.SetItem(ll_row,"pic_type",is_open_style)
				ids_pic.SetItem(ll_row,"pic_band",lower(ls_DestBand))
				ids_pic.SetItem(ll_row,"pic_name",lower(ls_NewName))
				ls_filename = uo_band.dw_syntax.describe(ls_NewName + ".filename" )
				ids_pic.SetItem(ll_row,"pic_filename",MidA(ls_filename,lastpos(ls_filename,"\") + 1))
			else
				ll_row = ids_pic.Find( "pic_name ='" + lower(ls_newname) + "'", 1,ids_pic.Rowcount())
				if ll_row > 0 then ids_pic.SetItem(ll_row,"pic_band",ls_DestBand)
			end if
		else
			adw_band.is_Objects[UpperBound(adw_band.is_Objects) + 1] = ls_NewName
			
			//Save the pic to db -- jervis 11.23.2009
			//li_find = ids_pic.Find("pic_name = '" + ls_NewName + "'",1,ids_pic.RowCount())
			//if li_find > 0 then
			//else
				ll_row = ids_pic.InsertRow(0)
				if is_open_style = 'screen' then
					ids_pic.SetItem(ll_row,'view_id',il_data_view)
					ids_pic.SetItem(ll_row,'screen_id',ii_screen_id)
				else
					ids_pic.SetItem(ll_row,'view_id',ii_data_view)
					ids_pic.SetItem(ll_row,'screen_id',0)
				end if
				ids_pic.SetItem(ll_row,"pic_type",is_open_style)
				ids_pic.SetItem(ll_row,"pic_band",lower(ls_DestBand))
				ids_pic.SetItem(ll_row,"pic_name",lower(ls_NewName))
				ls_filename = uo_band.dw_syntax.describe(ls_NewName + ".filename" )
				ids_pic.SetItem(ll_row,"pic_filename",MidA(ls_filename,lastpos(ls_filename,"\") + 1))
				/*
				ids_pic.SetItem(ll_row,"pic_filename",ls_filename)
				ids_pic.SetItem(ll_row,"pic_x",ll_x)
				ids_pic.SetItem(ll_row,"pic_y",ll_y)
				ids_pic.SetItem(ll_row,"pic_width",137)
				ids_pic.SetItem(ll_row,"pic_height",120)
				*/
			//end if
			
		end if
	next
else
	Return -1
end if

Return 1

end function

public function integer of_init (window aw_parent, string as_style, datawindow adw_original, long al_data_view);//add by gavin on 2009/2/26
//type: 1.  'screen'
//      2.  'report'
//

of_set_parent_window(aw_parent)
is_open_style = as_style
idw_original = adw_original
ii_data_view = al_data_view

return 1


end function

public function integer of_set_isshowtree (boolean ad_switch);//Processing TreeView y/n show
ib_show_treeview = ad_switch
return 1
end function

public function integer of_sort_sqldata ();//sort sql
long ll_count
integer i
string ls_sql,ls_sqldata,ls_temp

ll_count = UpperBound(is_CopySyntax)
if ll_count > 1 then
	FOR i = 1 to ll_count  
	    ls_sql = lower(is_CopySyntax[i]) 
		 if PosA(ls_sql,'header') > 0  then
			 ib_header = true
		elseif PosA(ls_sql,'detail') > 0 then
			 ib_detail = true
		elseif PosA(ls_sql,'summary') > 0 then
			 ib_summary = true
		else
			 ib_footer = true
		end if
   NEXT
end if
return 1

end function

public subroutine of_refreshmarkpos ();//====================================================================
// Function: of_refreshmarkpos()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_Cnts
String	ls_ObjName

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	ls_ObjName = istr_SelectObj[ll_Cycle].FName
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
	
	istr_SelectObj[ll_Cycle].FBand.of_RefreshMarkPos(ls_ObjName)
next

end subroutine

public subroutine of_unselectallobject ();//====================================================================
// Function: of_unselectallobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName
long		ll_Cycle,ll_Cnts

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	ls_ObjName = istr_SelectObj[ll_Cycle].FName
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
	
	istr_SelectObj[ll_Cycle].FBand.of_AddOrDelSingleSelect(ls_ObjName,false)
next

end subroutine

public subroutine of_moveselectedobject (long al_diff_x, long al_diff_y);//====================================================================
// Function: of_MoveSelectedObject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_Diff_X
// 	value    long    al_Diff_Y
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName
long		ll_Cycle,ll_Cnts,ll_X1,ll_Y1,ll_X2,ll_Y2,ll_MinX1,ll_MinY1

ll_Cnts = UpperBound(istr_SelectObj)
if ll_Cnts <= 0 then Return

for ll_Cycle = 1 to ll_Cnts
	ls_ObjName = istr_SelectObj[ll_Cycle].FName
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
	
	if istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".type") <> 'line' THEN
		ll_X1 = long(istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".X"))
		ll_Y1 = long(istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Y"))
		if ll_X1 < ll_MinX1 or ll_Cycle = 1 then ll_MinX1 = ll_X1
		if ll_Y1 < ll_MinY1 or ll_Cycle = 1 then ll_MinY1 = ll_Y1
	else
		ll_X1 = long(istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".X1"))
		ll_X2 = long(istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".X2"))
		ll_Y1 = long(istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Y1"))
		ll_Y2 = long(istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".Y2"))
		if ll_X1 < ll_MinX1 or ll_Cycle = 1 then ll_MinX1 = ll_X1
		if ll_X2 < ll_MinX1 or ll_Cycle = 1 then ll_MinX1 = ll_X2
		if ll_Y1 < ll_MinY1 or ll_Cycle = 1 then ll_MinY1 = ll_Y1
		if ll_Y2 < ll_MinY1 or ll_Cycle = 1 then ll_MinY1 = ll_Y2
	end if
next

if ll_MinX1 + al_Diff_X <= 0 then al_Diff_X = 0
if ll_MinY1 + al_Diff_Y <= 0 then al_Diff_Y = 0

if al_Diff_X = 0 and al_Diff_Y = 0 then Return

for ll_Cycle = 1 to ll_Cnts
	ls_ObjName = istr_SelectObj[ll_Cycle].FName
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
	
	istr_SelectObj[ll_Cycle].FBand.of_MoveSelectedObject(ls_ObjName,al_Diff_X,al_Diff_Y)
next

of_RefreshMarkPos()

end subroutine

public function long of_getselectedobjectcnts ();//====================================================================
// Function: of_getselectedobjectcnts()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_TotalCnts,ll_ValidCnts

ll_TotalCnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_TotalCnts
	if Not (IsNull(istr_SelectObj[ll_Cycle].FName) or Trim(istr_SelectObj[ll_Cycle].FName) = "") then
		ll_ValidCnts++
	end if
next

Return ll_ValidCnts

end function

public function string of_getlastselectedobject ();//====================================================================
// Function: of_getlastselectedobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName,ls_ObjList
long		ll_Cnts,ll_Pos,ll_Index

ll_Cnts = UpperBound(istr_SelectObj)
if ll_Cnts <= 0 then Return ""

ls_ObjList = is_LastSelObjList
if RightA(ls_ObjList,LenA(LISTSEPARATECHAR)) = LISTSEPARATECHAR then
	ls_ObjList = LeftA(ls_ObjList,LenA(ls_ObjList) - LenA(LISTSEPARATECHAR))
end if

ll_Pos = LastPos(ls_ObjList,LISTSEPARATECHAR)
ll_Index = long(MidA(ls_ObjList,ll_Pos + LenA(LISTSEPARATECHAR)))
if ll_Index > 0 and ll_Index <= ll_Cnts then
	ls_ObjName = istr_SelectObj[ll_Index].FName
end if

Return ls_ObjName

end function

public subroutine of_getselectedobjectinformation (string as_objname, ref string as_objtype, ref long al_x, ref long al_y, ref long al_width, ref long al_height);//====================================================================
// Function: of_GetSelectedObjectInformation()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        string    as_objname
// 	reference    string    as_objtype
// 	reference    long      al_x
// 	reference    long      al_y
// 	reference    long      al_width
// 	reference    long      al_height
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_Cnts

al_X = 0
al_Y = 0
al_Width = 0
al_Height = 0

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = ll_Cnts to 1 Step -1
	if Lower(istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		istr_SelectObj[ll_Cycle].FBand.of_GetObjectInformation(as_ObjName,as_ObjType,al_X,al_Y,al_Width,al_Height)
		Exit
	end if
next

end subroutine

public function boolean of_isselected (string as_objname, ref long al_pos);//====================================================================
// Function: of_isselected()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        string    as_objname
// 	reference    long      al_pos
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Cycle,ll_Cnts

al_Pos = 0

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	if Lower(istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		al_Pos = ll_Cycle
		Return true
	end if
next

Return false

end function

public function string of_getselectedobjecttype (string as_objname);//====================================================================
// Function: of_GetSelectedObjectType()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_Cnts
String	ls_ObjType

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	if Lower(istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		ls_ObjType = istr_SelectObj[ll_Cycle].FBand.of_GetObjectType(as_ObjName)
		Exit
	end if
next

Return ls_ObjType

end function

public function string of_getselectedobjecttag (string as_objname);//====================================================================
// Function: of_GetSelectedObjectTag()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_Cnts
String	ls_ObjTag

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	if Lower(istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		ls_ObjTag = istr_SelectObj[ll_Cycle].FBand.of_GetObjectTag(as_ObjName)
		Exit
	end if
next

Return ls_ObjTag

end function

public function string of_getselectedobjectid (string as_objname);//====================================================================
// Function: of_GetSelectedObjectID()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_Cnts
String	ls_ObjID

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	if Lower(istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		ls_ObjID = istr_SelectObj[ll_Cycle].FBand.of_GetObjectID(as_ObjName)
		Exit
	end if
next

Return ls_ObjID

end function

public function long of_getclipboardobjcnts ();//====================================================================
// Function: of_GetClipboardObjCnts()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Cycle,ll_TotalCnts,ll_ValidCnts

ll_TotalCnts = UpperBound(is_CopySyntax)
for ll_Cycle = 1 to ll_TotalCnts
	if IsNull(is_CopySyntax[ll_Cycle]) or Trim(is_CopySyntax[ll_Cycle]) = "" then Continue
	
	ll_ValidCnts++
next

Return ll_ValidCnts

end function

public subroutine of_getselectedobjectattr (string as_objname, ref string as_bold, ref string as_italic, ref string as_underline, ref string as_align);//====================================================================
// Function: of_GetSelectedObjectAttr()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        string    as_objname
// 	reference    string    as_bold
// 	reference    string    as_italic
// 	reference    string    as_underline
// 	reference    string    as_align
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_Cnts

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	if Lower(istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		istr_SelectObj[ll_Cycle].FBand.of_GetObjectAttr(as_ObjName,as_Bold,as_Italic,as_Underline,as_Align)
		Exit
	end if
next

end subroutine

public subroutine of_updatelastselobjlist (long al_index, boolean ab_add);//====================================================================
// Function: of_UpdateLastSelObjList()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long       al_Index
// 	value    boolean    ab_Add
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-17
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Pos
String	ls_Mark

if IsNull(al_Index) or al_Index <= 0 or al_Index > UpperBound(istr_SelectObj) then Return

ls_Mark = LISTSEPARATECHAR + String(al_Index) + LISTSEPARATECHAR
ll_Pos = PosA(is_LastSelObjList,ls_Mark)
if ll_Pos > 0 then
	is_LastSelObjList = LeftA(is_LastSelObjList,ll_Pos - 1) + LISTSEPARATECHAR + MidA(is_LastSelObjList,ll_Pos + LenA(ls_Mark))
end if

if ab_Add then
	is_LastSelObjList += String(al_Index) + LISTSEPARATECHAR
end if

end subroutine

public subroutine of_selectall (boolean ab_allband);//====================================================================
// Function: of_SelectAll()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    boolean    ab_AllBand
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-20
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName
long		ll_Band,ll_Cycle,ll_ObjCnts

u_cst_dw_band  ldw_band

if ab_AllBand then
	for ll_Band = 1 to 4
		Choose CASE ll_Band
			CASE 1
				ldw_Band = uo_band.dw_Header
			CASE 2
				ldw_Band = uo_band.dw_Detail
			CASE 3
				ldw_Band = uo_band.dw_Summary
			CASE ELSE
				ldw_Band = uo_band.dw_Footer
		End Choose
		
		ll_ObjCnts = UpperBound(ldw_Band.is_Objects[])
		for ll_Cycle = 1 to ll_ObjCnts
			ls_ObjName = ldw_Band.is_Objects[ll_Cycle]
			ldw_Band.of_AddorDelSingleSelect(ls_ObjName,true)
		next
	next
else
	ldw_band = wf_GetBand(is_CurBand)
	if Not IsValid(ldw_band) then Return

	ll_ObjCnts = UpperBound(ldw_Band.is_Objects[])
	for ll_Cycle = 1 to ll_ObjCnts
		ls_ObjName = ldw_Band.is_Objects[ll_Cycle]
		ldw_Band.of_AddorDelSingleSelect(ls_ObjName,true)
	next
end if

end subroutine

public subroutine of_resizeselectedobject (long al_diff_x, long al_diff_y);//====================================================================
// Function: of_ResizeSelectedObject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_Diff_X
// 	value    long    al_Diff_Y
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName
long		ll_Cycle,ll_Cnts

ll_Cnts = UpperBound(istr_SelectObj)
if ll_Cnts <= 0 then Return

for ll_Cycle = 1 to ll_Cnts
	ls_ObjName = istr_SelectObj[ll_Cycle].FName
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
	
	istr_SelectObj[ll_Cycle].FBand.of_ResizeSelectedObject(ls_ObjName,al_Diff_X,al_Diff_Y)
next

of_RefreshMarkPos()

end subroutine

public subroutine of_refresh_object_inforamtion ();//====================================================================
// Function: of_refresh_object_inforamtion()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName,ls_ObjType,as_Bold,as_Italic,as_Underline,as_Align
string as_size
long		ll_X,ll_Y,ll_Width,ll_Height,ll_Pos,ll_SelObjCnts
Boolean	lb_Selected

ll_SelObjCnts = of_GetSelectedObjectCnts()

if ll_SelObjCnts <= 0 then
	uo_design.st_bold.BorderStyle = StyleRaised!
	uo_design.st_italic.BorderStyle = StyleRaised!
	uo_design.st_underline.BorderStyle = StyleRaised!
	uo_design.st_left.BorderStyle = StyleRaised!
	uo_design.st_right.BorderStyle = StyleRaised!
	uo_design.st_center.BorderStyle = StyleRaised!

	uo_design.st_Object_Name.Text = "Nothing Selected"
	uo_design.st_xy.Visible = false
else
	if ll_SelObjCnts >= 1 then
		ls_ObjName = of_GetLastSelectedObject()
		//---------Begin Added by (Appeon)Stephen 05.14.2014 for IntelliReport Modifications 14.2--------
		of_GetSelectedObject_fontsize(ls_ObjName,as_size)
		if as_size <> "" and not isnull(as_size) then
			uo_design.em_font.text = string(abs(long(as_size)))
		end if
		//---------End Added ------------------------------------------------------
		of_GetSelectedObjectAttr(ls_ObjName,as_Bold,as_Italic,as_Underline,as_Align)
		
		if as_Bold <> "400" and as_Bold <> "!" and as_Bold <> "?" then
			uo_design.st_bold.BorderStyle = StyleLowered!
		else
			uo_design.st_bold.BorderStyle = StyleRaised!
		end if
		
		if as_Italic <> "0" and as_Italic <> "!" and as_Italic <> "?" then
			uo_design.st_italic.BorderStyle = StyleLowered!
		else
			uo_design.st_italic.BorderStyle = StyleRaised!
		end if
		
		if as_Underline <> "0" and as_Underline <> "!" and as_Underline <> "?" then
			uo_design.st_underline.BorderStyle = StyleLowered!
		else
			uo_design.st_underline.BorderStyle = StyleRaised!
		end if
		
		if as_Align = "0" then
			uo_design.st_left.BorderStyle = StyleLowered!
			uo_design.st_right.BorderStyle = StyleRaised!
			uo_design.st_center.BorderStyle = StyleRaised!
		elseif as_Align = "1" then
			uo_design.st_left.BorderStyle = StyleRaised!
			uo_design.st_right.BorderStyle = StyleLowered!
			uo_design.st_center.BorderStyle = StyleRaised!
		else
			uo_design.st_left.BorderStyle = StyleRaised!
			uo_design.st_right.BorderStyle = StyleRaised!
			uo_design.st_center.BorderStyle = StyleLowered!
		end if
		
		if ll_SelObjCnts = 1 then 
			of_GetSelectedObjectInformation(ls_ObjName,ls_ObjType,ll_X,ll_Y,ll_Width,ll_Height)
			uo_design.st_Object_Name.Text = ls_ObjName
			uo_design.st_xy.Visible = true
			
			if ls_ObjType = "line" then
				uo_design.st_xy.Text = " X1:" + String(ll_X) + &
											  "  Y1:" + String(ll_Y) + &
											  "  X2:" + String(ll_Width) + &
											  "  Y2:" + String(ll_Height)
			else
				uo_design.st_xy.Text = " X:" + String(ll_X) + &
											  " Y:" + String(ll_Y) + &
											  " Width:" + String(ll_Width) + &
											  " Height:" + String(ll_Height)
			end if
		else
			uo_design.st_Object_Name.Text = "Group Selected"
			uo_design.st_xy.Visible = false
		end if
	end if
end if

end subroutine

public function string of_get_invisible_field ();//====================================================================
// Function: Of_Get_Invisible_Field()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_InVisible_Field_List

ls_InVisible_Field_List += uo_Band.dw_Header.Of_Get_Invisible_Field() + ENTERCHAR
ls_InVisible_Field_List += uo_Band.dw_Detail.Of_Get_Invisible_Field() + ENTERCHAR
ls_InVisible_Field_List += uo_Band.dw_Summary.Of_Get_Invisible_Field() + ENTERCHAR
ls_InVisible_Field_List += uo_Band.dw_Footer.Of_Get_Invisible_Field() + ENTERCHAR

Return ls_InVisible_Field_List

end function

public function integer wf_addinvisiblefield (string as_objtype, long al_x, long al_y);//====================================================================
// Function: wf_AddInVisibleField()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjType
// 	value    long      al_X
// 	value    long      al_Y
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

string 	ls_Border
string  	ls_ObjectSyntax,ls_ObjName,ls_Sourband,ls_DestBand,ls_Type,ls_Column_ID
long		ll_X,ll_Y,ll_TotalCnts,ll_Index,ll_Cnt,ll_Pos,ll_NextBlank

CONSTANT STRING XCOORMARK = ' x="'
CONSTANT STRING YCOORMARK = ' y="'

u_cst_dw_band   	ldw_band

st_Add.Visible = False

of_UnselectAllObject()

ll_X = al_X
ll_Y = al_Y

CHOOSE CASE UPPER(is_CurBand)
	CASE 'HEADER'
		ls_DestBand = 'header'
		ldw_band = uo_Band.dw_Header
	CASE 'DETAIL'
		ls_DestBand = 'detail'
		ldw_band = uo_Band.dw_Detail
	CASE 'SUMMARY'
		ls_DestBand = 'summary'
		ldw_band = uo_Band.dw_Summary
	CASE 'FOOTER'
		ls_DestBand = 'footer'
		ldw_Band = uo_Band.dw_Footer
	CASE 'HEADER.1'
		ls_DestBand = 'header.1'
		ldw_band = uo_Band.dw_HeaderGroup
	CASE 'HEADER.2'
		ls_DestBand = 'header.2'
		ldw_band = uo_Band.dw_HeaderGroup2
	CASE 'HEADER.3'
		ls_DestBand = 'header.3'
		ldw_band = uo_Band.dw_HeaderGroup3
	CASE 'TRAILER.1'
		ls_DestBand = 'trailer.1'
		ldw_band = uo_Band.dw_TrailerGroup
	CASE 'TRAILER.2'
		ls_DestBand = 'trailer.2'
		ldw_band = uo_Band.dw_TrailerGroup2
	CASE 'TRAILER.3'
		ls_DestBand = 'trailer.3'
		ldw_band = uo_Band.dw_TrailerGroup3
	CASE else
		Return -1
END CHOOSE

if ls_DestBand = '' then Return -1

ll_TotalCnts = UpperBound(is_FieldSyntax)
if ib_PreparVisible and ll_TotalCnts > 0 and il_CurVisibleNo <= ll_TotalCnts then
	ls_ObjectSyntax = is_FieldSyntax[il_CurVisibleNo]
	if Not (IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "") then
		ll_Pos = PosA(ls_ObjectSyntax,"name=")
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos)
		ls_ObjName = MidA(ls_ObjectSyntax,ll_Pos + LenA("name="),ll_NextBlank - (ll_Pos + LenA("name=")))
		ls_Border = uo_band.dw_syntax.Describe(ls_ObjName + ".border")
		
		uo_Band.dw_Header.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_HeaderGroup.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_HeaderGroup2.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_HeaderGroup3.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_Detail.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_TrailerGroup.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_TrailerGroup2.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_TrailerGroup3.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_Summary.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_Footer.Modify("Destroy " + ls_ObjName)
		This.Event ue_SetModify("Destroy " + ls_ObjName)
		
		ll_Pos = PosA(ls_ObjectSyntax,"band=")
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos)
		ls_Sourband = MidA(ls_ObjectSyntax,ll_Pos + LenA("band="),ll_NextBlank - (ll_Pos + LenA("band=")))
		
		if ll_Pos > 0 and ll_NextBlank > 0 and Lower(ls_Sourband) <> Lower(ls_DestBand) then
			ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA("band="),ll_NextBlank - (ll_Pos + LenA("band=")),Lower(ls_DestBand))
		end if
	
		ll_Pos = PosA(ls_ObjectSyntax,XCOORMARK)
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA(XCOORMARK),ll_NextBlank - (ll_Pos + LenA(XCOORMARK)) - 1,String(ll_X))
		end if
	
		ll_Pos = PosA(ls_ObjectSyntax,YCOORMARK)
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA(YCOORMARK),ll_NextBlank - (ll_Pos + LenA(YCOORMARK)) - 1,String(ll_Y))
		end if
		
		ll_Pos = PosA(ls_ObjectSyntax," visible=")
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA(" visible=") + 1,ll_NextBlank - (ll_Pos + LenA(" visible=") + 1) - 1,"1")
		end if
		
		ls_ObjectSyntax = "Create " + ls_ObjectSyntax
		ldw_band.Modify(ls_ObjectSyntax)
		
		//------------------- APPEON BEGIN -------------------
		//$<add> Evan 12.03.2010
		//$<reason> Fxied a bug
		ll_Pos = PosA(ls_ObjectSyntax,"border=")
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos + 1)
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax, ll_Pos, ll_NextBlank - ll_Pos, 'border="' + ls_Border + '"')
		end if
		//------------------- APPEON END ---------------------
		This.Event ue_SetModify(ls_ObjectSyntax)
		
		ldw_band.is_OrgObj = ls_ObjName
		ldw_band.is_CurObj = ls_ObjName
		
		ls_Type = ldw_band.Describe(ls_ObjName + ".Type")
		
		if Upper(ls_Type) = Upper("Column") then
			if Not (IsNull(ls_ObjName) or Trim(ls_ObjName) = "") then
				ls_Column_ID = ldw_band.Describe(ls_ObjName + ".ID")
				ldw_band.Modify(ls_ObjName + "_t.Tag = '" + ls_Column_ID + "'")
				ldw_band.Modify(ls_ObjName + ".Protect = 1")
				
				dw_properties.SetFilter("sys_fields_field_name = '" + ls_ObjName + "'")
				dw_properties.Filter()
				
				if dw_properties.RowCount() > 0 then
					dw_properties.SetItem(1,"data_view_fields_visible","Y")
					dw_properties.AcceptText()
				end if
				
				ll_Cnt = dw_Fields_Alias.RowCount( )
				ll_Index = dw_Fields_Alias.Find("c_name='" + ls_ObjName + "'",ll_Index,ll_Cnt)
				
				do while ll_Index > 0
					dw_Fields_Alias.SetItem(ll_Index,"visible",1)
					if ll_Index >= ll_Cnt then Exit
					ll_Index = dw_Fields_Alias.Find("c_name='" + ls_ObjName + "'",ll_Index + 1,ll_Cnt)
				loop
			end if
		end if
		
		ldw_band.of_AddorDelSingleSelect(ls_ObjName,true)
		
		ll_Cnt = UpperBound(ldw_band.is_Objects)
		for ll_Index = 1 to ll_Cnt
			if ldw_band.is_Objects[ll_Index] = ls_ObjName then
				Exit
			end if
		next
		if ll_Index > ll_Cnt then
			ldw_band.is_Objects[UpperBound(ldw_band.is_Objects) + 1] = ls_ObjName
		end if
	end if
	
	il_CurVisibleNo++

	if il_CurVisibleNo <= ll_TotalCnts then
		ls_ObjectSyntax = is_FieldSyntax[il_CurVisibleNo]
		if Not (IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "") then
			ll_Pos = PosA(ls_ObjectSyntax,"name=")
			ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos)
			ls_ObjName = MidA(ls_ObjectSyntax,ll_Pos + LenA("name="),ll_NextBlank - (ll_Pos + LenA("name=")))
			This.Event ue_new(ls_ObjName + " Invisible")
		else
			is_addobjectType = ""
		end if
	else
		is_addobjectType = ""
	end if
end if

of_Refresh_Object_Inforamtion()

Return 1

end function

public function integer wf_pickupfieldsyntax (string as_field_list);//====================================================================
// Function: wf_PickUpFieldSyntax()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Field_List
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String   ls_Syntax,ls_ColName,ls_ObjName,ls_ObjectSyntax,ls_CurLetter,ls_Band
String	ls_RowStr,ls_FieldName,ls_Border,ls_Text,ls_Null[]
String	ls_LabelName
long		ll_Cycle,ll_FieldCnts,ll_FieldSepPos,ll_FieldWidth
long   	ll_RowStart,ll_RowEnd,ll_Pos,ll_BorPos,ll_TxtPos,ll_QuoPos,ll_NextBlank
long		ll_LeftBracketCnts,ll_RightBracketCnts
long		ll_SecleftBraPos,ll_FirRighBraPos

CONSTANT LONG   ONCECNTS = 3
CONSTANT STRING BORDERFLAG = ' border="'
CONSTANT STRING TEXTFLAG = ' text="'

is_FieldSyntax = ls_Null
il_CurVisibleNo = 1

if IsNull(as_Field_List) or Trim(as_Field_List) = "" then Return -1

ls_Syntax = uo_band.dw_Syntax.Describe("Datawindow.Syntax")
ls_Syntax = MidA(ls_Syntax,LastPos(LeftA(ls_Syntax,PosA(ls_Syntax,"band=")),ENTERCHAR) + LenA(ENTERCHAR))

ll_FieldSepPos = PosA(as_Field_List,ENTERCHAR)
do while ll_FieldSepPos > 0
	ls_ColName = LeftA(as_Field_List,ll_FieldSepPos - 1)
	as_Field_List = MidA(as_Field_List,ll_FieldSepPos + LenA(ENTERCHAR))
	ll_FieldSepPos = PosA(as_Field_List,ENTERCHAR)
	if IsNull(ls_ColName) or Trim(ls_ColName) = "" then Continue
	
	ls_Text = ls_ColName		//As the default label name
	
	for ll_Cycle = 1 to ONCECNTS
		if ll_Cycle = 1 then
			ls_ObjName = ls_ColName
		elseif ll_Cycle = 2 then
			ls_ObjName = ls_ColName + "_t"
		elseif ll_Cycle = 3 then
			ls_ObjName = "b_" + ls_ColName
		end if
		
		ll_Pos = PosA(ls_Syntax,"name=" + Lower(ls_ObjName) + " ")
		if ll_Pos > 0 then
			ll_RowStart = LastPos(LeftA(ls_Syntax,ll_Pos),ENTERCHAR) + LenA(ENTERCHAR)
			if ll_RowStart = LenA(ENTERCHAR) then ll_RowStart = 1
			
			ll_RowEnd = ll_RowStart
			
			ll_SecleftBraPos = PosA(ls_Syntax,"(",PosA(ls_Syntax,"(",ll_RowStart) + 1)
			ll_FirRighBraPos = PosA(ls_Syntax,")",ll_RowStart)
			
			if ll_SecleftBraPos > ll_FirRighBraPos then		//Adjust the performance
				ll_RowEnd = ll_FirRighBraPos + 1
			else
				ll_LeftBracketCnts = 0
				ll_RightBracketCnts = 0
				do while ll_LeftBracketCnts = 0 or ll_LeftBracketCnts <> ll_RightBracketCnts
					ls_CurLetter = MidA(ls_Syntax,ll_RowEnd,1)
					if ls_CurLetter = "(" then ll_LeftBracketCnts++
					if ls_CurLetter = ")" then ll_RightBracketCnts++
					ll_RowEnd++
				loop
			end if
	
			ls_RowStr = MidA(ls_Syntax,ll_RowStart,ll_RowEnd - ll_RowStart)
			
			ll_BorPos = PosA(ls_RowStr,BORDERFLAG)
			ll_QuoPos = PosA(ls_RowStr,'" ',ll_BorPos + LenA(BORDERFLAG))
			if ll_BorPos > 0 and ll_QuoPos > 0 then
				if ll_Cycle = 1 then
					ls_Border = "5"
				else
					ls_Border = "0"
				end if
				ls_RowStr = LeftA(ls_RowStr,ll_BorPos + LenA(BORDERFLAG) - 1) + ls_Border + MidA(ls_RowStr,ll_QuoPos)
			end if
			/*
			if ll_Cycle = 2 then
				ll_TxtPos = Pos(ls_RowStr,TEXTFLAG)
				ll_QuoPos = Pos(ls_RowStr,'" ',ll_TxtPos + Len(TEXTFLAG))
				if ll_TxtPos > 0 and ll_QuoPos > 0 then
					ls_RowStr = Left(ls_RowStr,ll_TxtPos + Len(TEXTFLAG) - 1) + ls_Text + Mid(ls_RowStr,ll_QuoPos)
				end if
			end if
			*/
			ll_FieldCnts++
			is_FieldSyntax[ll_FieldCnts] = ls_RowStr
		elseif ll_Cycle = 2 then
			ls_LabelName = ls_ObjName
			ls_FieldName = LeftA(ls_LabelName,LenA(ls_LabelName) - 2)
			ls_Band = uo_band.dw_Syntax.Describe(ls_FieldName + ".Band")
			ll_FieldWidth = long(uo_band.dw_Syntax.Describe(ls_FieldName + ".Width"))
			
			ls_RowStr = 'text(band=' + ls_Band + ' alignment="0" text="' + ls_Text + '" border="0" color="0" '&
							+ 'x="1000" y="1000" height="52" width="' + String(ll_FieldWidth) + '" ' + ' name=' + ls_LabelName &
							+ ' font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" ' &
							+ 'font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
			
			uo_band.dw_Syntax.Modify("create " + ls_RowStr)
			
			ll_FieldCnts++
			is_FieldSyntax[ll_FieldCnts] = ls_RowStr
		end if
	next
loop

if il_CurVisibleNo <= ll_FieldCnts then
	ib_PreparVisible = true
	ls_ObjectSyntax = is_FieldSyntax[il_CurVisibleNo]
	if Not (IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "") then
		ll_Pos = PosA(ls_ObjectSyntax,"name=")
		ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos)
		ls_ObjName = MidA(ls_ObjectSyntax,ll_Pos + LenA("name="),ll_NextBlank - (ll_Pos + LenA("name=")))
		
		This.Event ue_New(ls_ObjName + " Invisible")
	else
		is_addobjectType = ""
	end if
else
	ib_PreparVisible = false
	is_addobjectType = ""
end if

Return 1

end function

public subroutine of_modify_column_property (string as_property_name, string as_property_value);//====================================================================
// Function: of_Modify_Column_Property()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Property_Name
// 	value    string    as_Property_Value
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle1,ll_Cycle2,ll_Cnts
String	ls_ObjName,ls_ColName,ls_Property_Name,ls_Type

ll_Cnts = UpperBound(istr_SelectObj)
if ll_Cnts <= 0 then Return

for ll_Cycle1 = 1 to ll_Cnts
	ls_ObjName = istr_SelectObj[ll_Cycle1].FName
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then CONTINUE
	
	ls_Type = istr_SelectObj[ll_Cycle1].FBand.Describe(ls_ObjName + ".Type")
	if ls_Type <> "column" and ls_Type <> "text" then CONTINUE
	
	if ls_Type = "column" then
		ls_ColName = ls_ObjName
		
		dw_Properties.SetFilter("sys_fields_field_name = '" + ls_ColName + "'")
		dw_Properties.Filter()
		
		if dw_Properties.RowCount() <= 0 then CONTINUE
		
		choose case as_Property_Name
			case "fields_label_textcolor","fields_label_textbkcolor","fields_textcolor","fields_textbkcolor","data_view_fields_label_justification","data_view_fields_justification"
				dw_Properties.SetItem(1,as_Property_Name,long(as_Property_Value))
			case else
				dw_Properties.SetItem(1,as_Property_Name,as_Property_Value)
		end choose
		
		dw_Properties.AcceptText()
		
		istr_SelectObj[ll_Cycle1].FBand.of_Modify_Column_Property(ls_ColName,as_Property_Name)
	else
		if as_Property_Name = "data_view_fields_visible" then
			//ls_Property_Name = "visible"
			CONTINUE
		elseif as_Property_Name = "fields_label_textcolor" then
			ls_Property_Name = "text_color"
		elseif as_Property_Name = "fields_label_textbkcolor" then
			ls_Property_Name = "background_color"
		elseif as_Property_Name = "data_view_fields_label_justification" then
			ls_Property_Name = "alignment"
		elseif as_Property_Name = "fields_label_border" then
			ls_Property_Name = "border"
		else
			CONTINUE
		end if
		
		ls_ColName = LeftA(ls_ObjName,LenA(ls_ObjName) - 2)
		
		for ll_Cycle2 = 1 to ll_Cnts
			if IsNull(istr_SelectObj[ll_Cycle2].FName) or Trim(istr_SelectObj[ll_Cycle2].FName) = "" then CONTINUE
			if istr_SelectObj[ll_Cycle2].FName = ls_ColName then Exit
		next
		
		if ll_Cycle2 <= ll_Cnts then
			if istr_SelectObj[ll_Cycle2].FBand.Describe(ls_ColName + ".Type") = "column" then CONTINUE
		end if
		
		dw_properties_text.Event ue_Retrieve(ls_ObjName)
		
		if dw_properties_text.RowCount() <= 0 then CONTINUE
		
		choose case ls_Property_Name
			case "text_color","background_color"
				dw_properties_text.SetItem(1,ls_Property_Name,long(as_Property_Value))
			case else
				dw_properties_text.SetItem(1,ls_Property_Name,as_Property_Value)
		end choose
		
		dw_properties_text.AcceptText()
	
		istr_SelectObj[ll_Cycle1].FBand.of_ModifyTextProperties(ls_Property_Name)
	end if
next

end subroutine

public function integer of_select_view (long al_view_id, string as_view_name, long al_screen_id);//------------------- APPEON BEGIN -------------------
//$<delete> Evan 09.01.2010
//$<reason> V10.5-Advanced Report
/*
Long ll_Handle,ll_screen_id
il_select_view = al_view_id
il_data_view_id = al_view_id
il_data_view= al_view_id	

parent_window_design.Title = "Contract Data Screen Painter ( " + as_view_name + " )"

uo_select.Event ue_Retrieve(al_view_id)
if IsValid(gw_contract) and al_screen_id = 0 then
	ll_screen_id = gw_contract.of_GetCurrentScreenID()
	if ll_screen_id > 0 then
		ii_screen_id = ll_screen_id
		ll_Handle = uo_select.tv_screen.of_FindItemWithData(String(ii_screen_id))
		if ll_Handle > 0 then uo_select.tv_screen.SelectItem(ll_Handle)
	end if
else
		ii_screen_id = al_screen_id
		ll_Handle = uo_select.tv_screen.of_FindItemWithData(String(ii_screen_id))
		If ll_Handle > 0 then 
			uo_select.tv_screen.SelectItem(ll_Handle)	
		Else
			ii_screen_id = uo_select.of_get_current_id()
		End IF
end if
*/
//------------------- APPEON END ---------------------

REturn 1
end function

public subroutine of_savetoundolist (string as_modify);//====================================================================
// Function: of_SaveToUndoList()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Modify
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Temp,ls_ObjName,ls_ProName,ls_ProValue,ls_Modify,ls_ObjAndPro,ls_Syntax,ls_dwObjSyntax
long		ll_EqualPos,ll_DotPos,ll_SpaPos,ll_TabPos,ll_StartPos,ll_NamePos,ll_Pos

CONSTANT STRING CREATEFLAG  = "create "
CONSTANT STRING DESTROYFLAG = "destroy "
CONSTANT STRING NAMEFLAG    = " name="

if Lower(LeftA(as_Modify,LenA(CREATEFLAG))) = Lower(CREATEFLAG) then
	ll_NamePos = PosA(as_Modify,NAMEFLAG)
	if ll_NamePos > 0 then
		ll_SpaPos = PosA(as_Modify," ",ll_NamePos + LenA(NAMEFLAG))
		if ll_SpaPos > 0 then
			ls_ObjName = MidA(as_Modify,ll_NamePos + LenA(NAMEFLAG),ll_SpaPos - ll_NamePos - LenA(NAMEFLAG))
			ls_Modify = DESTROYFLAG + ls_ObjName
		end if
	end if
elseif Lower(LeftA(as_Modify,LenA(DESTROYFLAG))) = Lower(DESTROYFLAG) then
	ls_Syntax = uo_band.dw_Syntax.Describe("DataWindow.Syntax")
	ll_Pos = PosA(as_Modify,DESTROYFLAG)
	do while ll_Pos > 0
		as_Modify = Trim(MidA(as_Modify,ll_Pos + LenA(DESTROYFLAG)))
		ll_SpaPos = PosA(as_Modify," ")
		if ll_SpaPos > 0 then
			ls_ObjName = LeftA(as_Modify,ll_SpaPos - 1)
			as_Modify = Trim(MidA(as_Modify,ll_SpaPos + 1))
			ll_Pos = PosA(as_Modify,DESTROYFLAG)
		else
			ls_ObjName = as_Modify
			ll_Pos = 0
		end if
		
		ls_dwObjSyntax = of_GetDWObjSyntax(ls_Syntax,ls_ObjName)
		ls_Modify += CREATEFLAG + ls_dwObjSyntax + " "
	loop
else
	ll_EqualPos = PosA(as_Modify,"=")
	do while ll_EqualPos > 0
		ls_Temp = Trim(LeftA(as_Modify,ll_EqualPos - 1))
		
		ll_SpaPos = LastPos(ls_Temp," ")
		ll_TabPos = LastPos(ls_Temp,"~t")
		
		if ll_SpaPos > ll_TabPos then
			ll_StartPos = ll_SpaPos
		else
			ll_StartPos = ll_TabPos
		end if
		
		ls_ObjAndPro = MidA(ls_Temp,ll_StartPos + 1,ll_EqualPos - ll_StartPos - 1)
		
		ls_ProValue = uo_band.dw_Syntax.Describe(ls_ObjAndPro)
		ls_Modify += ls_ObjAndPro + ' = "' + ls_ProValue + '" '
		
		as_Modify = MidA(as_Modify,ll_EqualPos + 1)
		ll_EqualPos = PosA(as_Modify,"=")
	loop
end if

if ls_Modify = "" then Return

il_CurUnDoNo++
if il_CurUnDoNo > 50 then il_CurUnDoNo = 1

is_UnDoList[il_CurUnDoNo] = ls_Modify

end subroutine

public subroutine of_undo ();//====================================================================
// Function: of_Undo()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if is_UnDoList[il_CurUnDoNo] <> "" then
	uo_band.dw_Syntax.Modify(is_UnDoList[il_CurUnDoNo])
	
	uo_band.dw_Header.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_detail.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_Summary.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_Footer.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_Headergroup.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_Headergroup2.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_Headergroup3.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_trailergroup.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_trailergroup2.Modify(is_UnDoList[il_CurUnDoNo])
	uo_band.dw_trailergroup3.Modify(is_UnDoList[il_CurUnDoNo])
	
	is_UnDoList[il_CurUnDoNo] = ""
	of_RefreshMarkPos()
	of_Refresh_Object_Inforamtion()
end if

il_CurUnDoNo --
if il_CurUnDoNo <= 0 then il_CurUnDoNo = 50

end subroutine

public function string of_setmodify (string as_modify);//====================================================================
// Function: of_SetModify()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Modify
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String  ls_Error

ls_Error = uo_band.dw_Syntax.Modify(as_Modify)

Return ls_Error

end function

public function string of_getdwobjsyntax (string as_dwsyntax, string as_objname);//====================================================================
// Function: of_GetDWObjSyntax()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_dwSyntax
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Syntax,ls_CurLetter,ls_RowStr
long		ll_Pos,ll_RowStart,ll_RowEnd
long		ll_SecleftBraPos,ll_FirRighBraPos
long		ll_LeftBracketCnts,ll_RightBracketCnts

ls_Syntax = MidA(as_dwSyntax,LastPos(LeftA(as_dwSyntax,PosA(as_dwSyntax,"band=")),ENTERCHAR) + LenA(ENTERCHAR))

ll_Pos = PosA(ls_Syntax,"name=" + Lower(as_ObjName) + " ")
if ll_Pos > 0 then
	ll_RowStart = LastPos(LeftA(ls_Syntax,ll_Pos),ENTERCHAR) + LenA(ENTERCHAR)
	ll_RowEnd = ll_RowStart
	
	ll_SecleftBraPos = PosA(ls_Syntax,"(",PosA(ls_Syntax,"(",ll_RowStart) + 1)
	ll_FirRighBraPos = PosA(ls_Syntax,")",ll_RowStart)
	
	if ll_SecleftBraPos > ll_FirRighBraPos then		//Adjust the performance
		ll_RowEnd = ll_FirRighBraPos + 1
	else
		ll_LeftBracketCnts = 0
		ll_RightBracketCnts = 0
		do while ll_LeftBracketCnts = 0 or ll_LeftBracketCnts <> ll_RightBracketCnts
			ls_CurLetter = MidA(ls_Syntax,ll_RowEnd,1)
			if ls_CurLetter = "(" then ll_LeftBracketCnts++
			if ls_CurLetter = ")" then ll_RightBracketCnts++
			ll_RowEnd++
		loop
	end if

	ls_RowStr = MidA(ls_Syntax,ll_RowStart,ll_RowEnd - ll_RowStart)
end if

Return ls_RowStr

end function

public function integer of_set_depend (ref datastore ads_depend);//Add by jervis 09.24.2009
//Get lookup dddw field list
//return rowcount
long ll_count,ll_i,ll_row,li_pos
string ls_objects
string ls_dddw_name
string ls_dbname
string ls_table
string ls_name,ls_display_name,ls_lookup_name

ads_depend.Reset()

ll_count = long(uo_band.dw_syntax.Describe("datawindow.column.count"))

for ll_i = 1 to ll_count
	if uo_band.dw_syntax.Describe("#" + string(ll_i) + ".edit.style") = 'dddw' then
		if long(uo_band.dw_syntax.describe("#" + string(ll_i) + ".visible")) = 0 then continue
		//ls_dddw_name = uo_band.dw_syntax.Describe("#" + string(ll_i) + ".dddw.name")
		ls_lookup_name = uo_band.dw_syntax.Describe( "#" + string(ll_i) + ".tag")
		//if ls_dddw_name = 'd_dddw_lookup_code' then
		if ls_lookup_name <> '' then
			ls_name = uo_band.dw_syntax.Describe("#" + string(ll_i) + ".name")
			ls_display_name = uo_band.dw_syntax.Describe( ls_name + "_t.text")
			ls_table = uo_band.dw_syntax.Describe( ls_name + ".dbname")
			li_pos = PosA(ls_table,".")
			ls_dbname = MidA(ls_table,li_pos + 1)
			ls_table = MidA(ls_table,1,li_pos - 1)
			if ls_display_name = '!' or ls_display_name = '?' then ls_display_name = ls_name
			
			if LenA(ls_name) > 1 and LenA(ls_lookup_name) > 1 then
				ll_row = ads_depend.insertrow(0)
				ads_depend.SetItem(ll_row,'field',ls_name)
				ads_depend.SetItem(ll_row,'field_display',ls_display_name)
				ads_depend.SetItem(ll_row,'field_lookup_name',ls_lookup_name)
				ads_depend.SetItem(ll_row,'table_name',ls_table)
				ads_depend.SetItem(ll_row,'dbname',ls_dbname)
				ads_depend.SetItem(ll_row,'screen_id',ii_screen_id)
			end if
		end if
	end if
next

ads_depend.sort()
return ads_depend.RowCount()



end function

public function string of_getscreensyntax (long al_screen_id);//====================================================================
// Function: of_GetScreenSyntax()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_screen_id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FindRow,ll_Updated,ll_SQLLen
String	ls_SQL

ids_Screen.SetFilter("")
ids_Screen.Filter()
ll_FindRow = ids_Screen.Find("screen_id=" + String(al_screen_id), 1, ids_Screen.RowCount())
if ll_FindRow <= 0 then Return ""

ls_SQL = ids_Screen.GetitemString(ll_FindRow, "dw_sql")
ll_Updated = ids_Screen.GetitemNumber(ll_FindRow,'updated')
IF appeongetclienttype() = 'PB' and ll_Updated = 0 THEN
	ll_SQLLen = ids_Screen.GetItemNumber(ll_FindRow, "dw_sql_len")
	IF ll_SQLLen > 32765 THEN
		//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------		
		  /*
			ls_SQL = f_get_screen_sql(il_data_view_id,al_screen_id)	
		  */
		 ls_SQL = f_get_screen_sql(il_data_view_id,al_screen_id,false)
		//---------End Modfiied ------------------------------------------------------------------		
	END IF
END IF

Return ls_SQL

end function

public function long of_setscreensyntax (long al_screen_id, string as_syntax);//====================================================================
// Function: of_SetScreenSyntax()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_screen_id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FindRow

ids_Screen.SetFilter("")
ids_Screen.Filter()
ll_FindRow = ids_Screen.Find("screen_id=" + String(al_screen_id), 1, ids_Screen.RowCount())
if ll_FindRow > 0 then
	ids_Screen.SetItem(ll_FindRow,"dw_sql",as_Syntax)
	ids_Screen.SetItem(ll_FindRow,"modify_date",Datetime(Today(),Now()))
	ids_Screen.Update()
	Return 1
else
	Return -1
end if

end function

public subroutine of_autoupdatesearchscreen (string as_objname);//====================================================================
// Function: of_AutoUpdateSearchScreen()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_CriteriaSyntax,ls_BrowseSyntax,ls_Edit_Style
String	ls_Visible_1,ls_Visible_2,ls_Proper,ls_ProExp
String	ls_ObjType,ls_FieldName,ls_LabelName
long		ll_RtnVal,ll_Cycle,ll_AlwaysUpdate

DataStore	lds_Temp

if ii_screen_id < 3 or ii_screen_id > 10 then Return
if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return

ls_ObjType = uo_band.dw_Syntax.Describe(as_ObjName + ".Type")
if ls_ObjType = "column" then
	ls_FieldName = as_ObjName
	ls_LabelName = ls_FieldName + "_t"
elseif ls_ObjType = "text" then
	ls_FieldName = LeftA(as_ObjName,LenA(as_ObjName) - 2)
	ls_LabelName = as_ObjName
else
	Return
end if

SetPointer(HourGlass!)

ls_CriteriaSyntax = of_GetScreenSyntax(1)
if IsNull(ls_CriteriaSyntax) or Trim(ls_CriteriaSyntax) = "" then Return

ls_BrowseSyntax = of_GetScreenSyntax(2)
if IsNull(ls_BrowseSyntax) or Trim(ls_BrowseSyntax) = "" then Return

ids_Criteria.Create(ls_CriteriaSyntax)
ids_Browse.Create(ls_BrowseSyntax)

if ls_ObjType = "column" then
	ls_Visible_1 = ids_Criteria.Describe(ls_FieldName + ".Visible")
	ls_Visible_2 = ids_Browse.Describe(ls_FieldName + ".Visible")
else
	ls_Visible_1 = ids_Criteria.Describe(ls_LabelName + ".Visible")
	ls_Visible_2 = ids_Browse.Describe(ls_LabelName + ".Visible")
end if

if (ls_Visible_1 = "?" or ls_Visible_1 = "!") and (ls_Visible_2 = "?" or ls_Visible_2 = "!") then Return

if Not ib_AlwaysUpdate and (ls_Visible_1 <> "0" or ls_Visible_2 <> "0") then
	if ib_AlwaysUpdate then ll_AlwaysUpdate = 10 else ll_AlwaysUpdate = 0
	OpenWithParm(w_CascadeUpdateConfirm,String(ll_AlwaysUpdate) + "," + LeftA(ls_ObjType,1))
	ll_RtnVal = Message.DoubleParm
	if ll_RtnVal >= 10 then
		ib_AlwaysUpdate = true
	else
		ib_AlwaysUpdate = false
	end if
	if Mod(ll_RtnVal,2) <> 1 then Return
end if

for ll_Cycle = 1 to 2
	if ll_Cycle = 1 and (ls_Visible_1 = "?" or ls_Visible_1 = "!") then CONTINUE
	if ll_Cycle = 2 and (ls_Visible_2 = "?" or ls_Visible_2 = "!") then CONTINUE
	
	if ll_Cycle = 1 then
		lds_Temp = ids_Criteria
	else
		lds_Temp = ids_Browse
	end if

	ls_Proper = ls_LabelName + ".Text"
	ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
	lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
	
	if ls_ObjType = "column" then
		ls_Proper = ls_FieldName + ".dddw.VscrollBar"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.AutoHScroll"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		if ll_Cycle = 1 then
			ls_Proper = ls_FieldName + ".dddw.UseAsBorder"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		end if
		
		ls_Proper = ls_FieldName + ".dddw.NilIsNull"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.Name"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.DataColumn"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.DisplayColumn"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.PercentWidth"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".tag"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Edit_Style = uo_band.dw_Syntax.Describe(ls_FieldName + ".Edit.Style")
		if ls_Edit_Style = "edit" then
			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".format"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		elseif ls_Edit_Style = "editmask" then
			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".Mask"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			lds_Temp.Modify(ls_Proper + "='" + ls_ProExp + "'")
		end if
	end if
	
	of_SetScreenSyntax(ll_Cycle,lds_Temp.Object.DataWindow.Syntax)
next

ib_HasNewModify = false

SetPointer(Arrow!)

end subroutine

public subroutine of_download_pic (long al_pic_id, string as_filename);string ls_path
blob	lb_file

//Parse path
ls_path = gs_dir_path + gs_DefDirName +"\" + is_pic_path + "\"
gnv_appeondll.of_parsepath(ls_path)

ls_path = ls_path + as_filename
if not fileexists(ls_path) then
	selectblob pic_bitmap into :lb_file from conv_view_pic where pic_id = :al_pic_id;
	AppeonWriteFile(ls_path, lb_file,LenA(lb_file))
end if


end subroutine

public subroutine of_upload_pic ();string ls_path
blob	lb_file
long ll_i,ll_count
long ll_pic_id
string ls_name
string ls_filename
long ll_x,ll_y,ll_width,ll_height



//Parse path
ls_path = gs_dir_path + gs_DefDirName +"\" + is_pic_path + "\"
gnv_appeondll.of_parsepath(ls_path)

//Update 
ll_count = ids_pic.rowcount( )
/*
for ll_i = 1 to ll_count
	ls_name = ids_pic.GetItemString( ll_i,"pic_name")
	ll_x = long(uo_band.dw_syntax.describe( ls_name + ".x") )
	ll_y = long(uo_band.dw_syntax.describe( ls_name + ".y") )
	ll_width = long(uo_band.dw_syntax.describe( ls_name + ".width") )
	ll_height = long(uo_band.dw_syntax.describe( ls_name + ".height") )
	ids_pic.SetItem(ll_i,"pic_x",ll_x)
	ids_pic.SetItem(ll_i,"pic_y",ll_y)
	ids_pic.SetItem(ll_i,"pic_width",ll_width)
	ids_pic.SetItem(ll_i,"pic_height",ll_height)
next
ids_pic.Update( )
*/


for ll_i = 1 to ll_count
	ll_pic_id = ids_pic.GetItemNumber( ll_i,"pic_id")
	ls_filename = ls_path + ids_pic.GetItemString( ll_i,"pic_filename")
	if FileExists(ls_path) then
		inv_filesrv.of_fileread( ls_filename, ref lb_file)
		Updateblob conv_view_pic set pic_bitmap = :lb_file where pic_id = :ll_pic_id;
	end if
next
commit;


end subroutine

public subroutine of_delete_pic (string as_name, boolean ab_cut);//Add by jervis -- 11.23.2009
//Delete Picture from database
long ll_find
string ls_filename
if uo_band.dw_Syntax.Describe( as_name + ".type") = 'bitmap' then
	ll_find = ids_pic.Find("pic_name = '" + as_name + "'",1,ids_pic.Rowcount( ))
	if ll_find > 0 then 
		ids_pic.DeleteRow( ll_find)
		if not ab_cut then
			ls_filename = uo_band.dw_Syntax.Describe( as_name + ".filename")
			filedelete(ls_filename)
		end if
	end if
end if
end subroutine

public function integer of_picture_property_sheet (string as_object);//Add by jervis -- 11.30.2009
string ls_path,ls_filename
string ls_path_to
string ls_find
long ll_row
u_cst_dw_band ldw_band
string ls_Modify

//Modify Michael 11.03.2011 Bug 2769 : Problem with report pulling in added pictures 
//if GetFileOpenName("Select File", ls_path, ls_filename, "bmp","Bitmap(*.bmp),*.bmp,GIF(*.gif),*.gif,JPEG(*.jpeg), *.jpeg") = 1 then
//if GetFileOpenName("Select File", ls_path, ls_filename, "jpg","JPEG(*.jpg;*.jpeg),*.jpg;*.jpeg,GIF(*.gif),*.gif,Bitmap(*.bmp),*.bmp") = 1 then
if GetFileOpenName("Select File", ls_path, ls_filename, "jpg","JPEG(*.jpg;*.jpeg),*.jpg;*.jpeg,GIF(*.gif),*.gif,Bitmap(*.bmp),*.bmp,PNG Files (*.PNG),*.png") = 1 then	//alfee 04.01.2017
	//File size less than 100K
	if filelength(ls_path) > 1024 * 200 then 
		MessageBox('Select File',"The file you selected must be less than 200K.")
		return 0
	end if
	
	//Copy file to temp local path
	if is_open_style = 'report' then   //ReportID + Object Name
		ls_filename = "R_"+string(ii_data_view) + "_" + lower(as_object) + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + MidA(ls_filename,PosA(ls_filename,"."))
		ls_Find = "pic_name = '" + lower(as_object) + "' and view_id = " + string(ii_data_view) + " and screen_id = 0"
	else	//ViewID + ScreenID + Object Name
		ls_filename = "S_"+string(il_data_view) + "_" + string(ii_screen_id) + "_" + lower(as_object) + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + MidA(ls_filename,PosA(ls_filename,"."))
		ls_Find = "pic_name = '" + lower(as_object) + "' and view_id = " + string(il_data_view) + " and screen_id = " + string(ii_screen_id)
	end if
	ls_path_to = gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" + ls_filename
	
	

	if FileCopy(ls_path,ls_path_to) <> 1 then return -1
	ll_row = ids_pic.Find(ls_find,1,ids_pic.Rowcount())
	if ll_row > 0 then
		ids_pic.SetItem(ll_row,"pic_filename",ls_filename)
		ls_Modify = as_object + ".filename ='" + ls_path_to + "'"
		ldw_band = wf_getband(is_curband)
		//Modify filename 
		ldw_band.Modify(ls_Modify)
		this.event ue_SetModify(ls_Modify)
	else
		return -1
	end if
end if
Return 1

end function

public function integer of_set_dw_properties (string as_object_name, integer ai_flag);//BEGIN---Modify by Evan 07/24/2008
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-13 By: Andy

u_cst_dw_band ldw_band

ldw_band = parent_window_design.wf_getband( parent_window_design.is_curband )
ldw_band.of_set_dw_properties( as_object_name )

return 1
//---------------------------- APPEON END ----------------------------
*/
u_cst_dw_band ldw_band

//modify by gavin on 2009/3/4
//ldw_band = parent_window_design.wf_getband(parent_window_design.is_curband)
ldw_band = wf_getband(is_curband)

choose case ai_Flag
	case 1 // Set datawindow properties
		of_ModifyDWProperties(as_object_name)
	case 2 // Set column and compute properties
		ldw_band.of_set_dw_properties(as_object_name)
	case 3 // Set text properties
		ldw_band.of_ModifyTextProperties(as_object_name)
	case 4 // Set oval properties
		ldw_band.of_ModifyOvalProperties(as_object_name)		//Added by Scofield on 2009-02-26
end choose

Return 1
//END---Modify by Evan 07/24/2008

end function

public function integer wf_makeband_01 (string as_syntax);//====================================================================
// Function: wf_makeband()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_syntax	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

string   ls_Syntax,ls_Err
int  		li

ls_Syntax = as_syntax
uo_band.dw_Syntax.Create(ls_Syntax)
uo_band.dw_Syntax.settransobject(SQLCA)

//$<add> 2007-11-07 By: Andy
of_retrieve_dw_properties( uo_band.dw_Syntax )

is_OrgSyntax = uo_band.dw_syntax.Describe('Datawindow.Syntax')

//BEGIN---Modify by Scofield on 2009-09-04
if PosA(is_OrgSyntax,"group(") > 0 then
	uo_band.ib_group = true
	uo_band.dw_headergroup.visible = true
	uo_band.st_headergroup.visible = true
	uo_band.dw_trailergroup.visible = true
	uo_band.st_trailergroup.visible = true
else
	uo_band.ib_group = false
	uo_band.dw_headergroup.visible = false
	uo_band.st_headergroup.visible = false
	uo_band.dw_trailergroup.visible = false
	uo_band.st_trailergroup.visible = false
end if
//END---Modify by Scofield on 2009-09-04

li  = uo_band.dw_Header.create(is_OrgSyntax,ls_err)
uo_band.dw_header.DYNAMIC event ue_regenerate()
uo_band.dw_header.idw_syntax = uo_band.dw_syntax

//modify by gavin on 2009/3/2
//True : show   false : no show
if ib_show_datagroup then 
	li = uo_band.dw_headergroup.create(is_OrgSyntax,ls_err)
	uo_band.dw_headergroup.DYNAMIC event ue_regenerate()
	uo_band.dw_headergroup.idw_syntax = uo_band.dw_syntax
end if

li = uo_band.dw_detail.create(is_OrgSyntax,ls_err)

////$<add> 03.19.2008 by Andy   --modify by gavin 2009-02-26
//if uo_design.ii_screen_id = 33 or uo_design.ii_screen_id = 47 then
//	uo_band.dw_detail.modify( "b_due_date_g.visible='0' b_due_date_r.visible='0'" )
//end if
////end of 03.19.2008

uo_band.dw_detail.DYNAMIC event ue_regenerate()
uo_band.dw_detail.idw_syntax = uo_band.dw_syntax

//modify by gavin on 2009/3/2
//True : show   false : no show
if ib_show_datagroup then
	li = uo_band.dw_trailergroup.create(is_OrgSyntax,ls_err)
	uo_band.dw_trailergroup.DYNAMIC event ue_regenerate()
	uo_band.dw_trailergroup.idw_syntax = uo_band.dw_syntax
end if

li = uo_band.dw_Summary.create(is_OrgSyntax,ls_err)
uo_band.dw_Summary.DYNAMIC event ue_regenerate()
uo_band.dw_Summary.idw_syntax = uo_band.dw_syntax

li = uo_band.dw_Footer.create(is_OrgSyntax,ls_err)
uo_band.dw_Footer.DYNAMIC event ue_regenerate()
uo_band.dw_footer.idw_syntax = uo_band.dw_syntax

uo_band.dw_header.Height = long(uo_band.dw_syntax.describe("datawindow.header.height"))
uo_band.dw_detail.Height = long(uo_band.dw_syntax.describe("datawindow.detail.height"))
uo_band.dw_Summary.Height = long(uo_band.dw_syntax.describe("datawindow.Summary.height"))
uo_band.dw_Footer.Height = long(uo_band.dw_syntax.describe("datawindow.Footer.height"))

//modify by gavin on 2009/3/2
if ib_show_datagroup then
	uo_band.dw_headergroup.Height = long(uo_band.dw_syntax.describe("datawindow.header.1.height"))
   uo_band.dw_trailergroup.Height = long(uo_band.dw_syntax.describe("datawindow.trailer.1.height"))
else
	uo_band.dw_headergroup.Height = 0
   uo_band.dw_trailergroup.Height = 0
	uo_band.st_headergroup.height = 0      // 2009/3/3 by gavin
	uo_band.st_trailergroup.height = 0     // 2009/3/3 by gavin
end if
// end 2009/3/2

uo_band.st_header.y = uo_band.dw_header.y + uo_band.dw_header.height// - 4

//modify by gavin on 2009/3/2
uo_band.dw_headergroup.y = uo_band.st_header.y + uo_band.st_header.height
uo_band.st_headergroup.y = uo_band.dw_headergroup.y + uo_band.dw_headergroup.height
// end 2009/3/2

uo_band.dw_detail.y = uo_band.st_header.y + uo_band.st_header.height// - 4
uo_band.st_detail.y = uo_band.dw_detail.y + uo_band.dw_detail.height// - 4

//modify by gavin on 2009/3/2
uo_band.dw_trailergroup.y = uo_band.st_detail.y + uo_band.st_detail.height
uo_band.st_trailergroup.y = uo_band.dw_trailergroup.y + uo_band.dw_trailergroup.height
// end 2009/3/2

uo_band.dw_summary.y = uo_band.st_detail.y + uo_band.st_detail.height// - 4
uo_band.st_summary.y = uo_band.dw_summary.y + uo_band.dw_summary.height// - 4

uo_band.dw_footer.y = uo_band.st_summary.y + uo_band.st_summary.height// - 4
uo_band.st_footer.y = uo_band.dw_footer.y + uo_band.dw_footer.height// - 4

uo_band.dw_header.bringtotop  = TRUE
uo_band.dw_detail.bringtotop  = TRUE
uo_band.dw_summary.bringtotop  = TRUE
uo_band.dw_footer.bringtotop  = TRUE
uo_band.st_header.bringtotop  = TRUE
uo_band.st_detail.bringtotop  = TRUE
uo_band.st_summary.bringtotop  = TRUE
uo_band.st_footer.bringtotop  = TRUE
uo_band.dw_headergroup.bringtotop  = TRUE
uo_band.dw_trailergroup.bringtotop  = TRUE
uo_band.st_headergroup.bringtotop  = TRUE
uo_band.st_trailergroup.bringtotop  = TRUE

This.Trigger Event ue_Resize(0,This.Width,This.Height)	//Added by Scofield on 2009-09-04

of_UnSelectAllObject()
of_Refresh_Object_Inforamtion()

Return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer wf_setbandtext (integer ai_bandindex);//////////////////////////////////////////////////////////////////////
// $<function> wf_setbandtext
// $<arguments>
//			integer	ai_bandindex
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.27.2010
//////////////////////////////////////////////////////////////////////

string  ls_Text
string  ls_Columns[]
integer i, li_ColCount

li_ColCount = w_custom_report.of_GetGroupColumns(is_OrgSyntax, ai_BandIndex, ls_Columns)
for i = 1 to li_ColCount
	if ls_Text <> "" then ls_Text += ", "
	ls_Text += ls_Columns[i]		
next
ls_Text = "[" + ls_Text + "]"

choose case ai_BandIndex
	case 1
		uo_band.st_headergroup.text  = "1: header group " + ls_Text
		uo_band.st_trailergroup.text = "1: trailer group " + ls_Text
	case 2
		uo_band.st_headergroup2.text  = "2: header group " + ls_Text
		uo_band.st_trailergroup2.text = "2: trailer group " + ls_Text
	case 3
		uo_band.st_headergroup3.text  = "3: header group " + ls_Text
		uo_band.st_trailergroup3.text = "3: trailer group " + ls_Text
end choose

Return 1
end function

public function integer of_replace (ref string as_syntax, string as_find, string as_replace);//////////////////////////////////////////////////////////////////////
// $<function> of_replace
// $<arguments>
//		ref string	as_syntax
//			 string	as_find
//			 string	as_replace
// $<returns> (None)
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.28.2010
//////////////////////////////////////////////////////////////////////

integer li_Len
long ll_StartPos

li_Len = Len(as_Find)

do while true
	ll_StartPos = Pos(as_Syntax, as_Find)
	if ll_StartPos > 0 then
		as_Syntax = Replace(as_Syntax, ll_StartPos, li_Len, as_Replace)
	else
		exit
	end if
loop

Return 1
end function

public function integer wf_movecolumnband (ref string as_dwsyntax, string as_object, string as_band, integer ai_ypos);//////////////////////////////////////////////////////////////////////
// $<function> wf_movecolumnband
// $<arguments>
//			string	as_dwsyntax
//			string	as_object
//			string	as_band
//			integer	ai_ypos
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.30.2010
//////////////////////////////////////////////////////////////////////

string ls_Value
string ls_Column
string ls_DWSyntax
string ls_LeftSyntax
long ll_ObjStartPos
long ll_StartPos, ll_EndPos

// Get start postion of column syntax
ls_Column = "name=" + as_Object + " "
ll_StartPos = Pos(as_DWSyntax, ls_Column)
if ll_StartPos < 1 then Return -1
ll_StartPos += Len(ls_Column)
ll_StartPos = Pos(as_DWSyntax, ls_Column, ll_StartPos)
if ll_StartPos < 1 then Return -1

ls_LeftSyntax = Mid(as_DWSyntax, 1, ll_StartPos)
ll_ObjStartPos = LastPos(ls_LeftSyntax, "~r~n") + 2
ls_Column = Mid(as_DWSyntax, ll_ObjStartPos, 7)
if ls_Column <> "column(" then Return -1

// Modify column band value
ll_StartPos = Pos(as_DWSyntax, "band=", ll_ObjStartPos)
ll_EndPos = Pos(as_DWSyntax, " ", ll_StartPos)
ls_Value = "band=" + as_Band
as_DWSyntax = Replace(as_DWSyntax, ll_StartPos, ll_EndPos - ll_StartPos, ls_Value)

// Modify column y value
ll_StartPos = Pos(as_DWSyntax, "y=", ll_ObjStartPos)
ll_EndPos = Pos(as_DWSyntax, " ", ll_StartPos)
ls_Value = 'y="' + String(ai_yPos) + '"'
as_DWSyntax = Replace(as_DWSyntax, ll_StartPos, ll_EndPos - ll_StartPos, ls_Value)

Return 1
end function

public subroutine of_getselectedobject_fontsize (string as_objname, ref string as_size);//====================================================================
//$<Function>: of_getselectedobjectattr
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.14.2014 (IntelliReport Modifications 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long		ll_Cycle,ll_Cnts

ll_Cnts = UpperBound(istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	if Lower(istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		istr_SelectObj[ll_Cycle].FBand.of_getobject_fontsize(as_ObjName,as_size)
		Exit
	end if
next
end subroutine

public function integer of_sendtoback (u_dw adw_band, string as_name, string as_band);//====================================================================
//$<Function>: of_sendtoback
//$<Arguments>:
// 	value    u_dw      adw_band
// 	value    string    as_name
// 	value    string    as_band
//$<Return>:  integer
//$<Description>: Send to back
//$<Author>: (Appeon) long.zhang 05.16.2016 (Bug id 5146 - Some Computed fields not saving in PDF document)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

adw_band.SetPosition(as_name, as_band, False)

uo_band.dw_Syntax.SetPosition(as_name, as_band, False)

Return 1
end function

public function integer of_set_gb_sendtoback (boolean ab_switch);//====================================================================
//$<Function>: of_set_gb_sendtoback
//$<Arguments>:
// 	value    boolean    ab_switch
//$<Return>:  integer
//$<Description>: Send groupbox to back flag (Used in w_intellicred_report_design)
//$<Author>: (Appeon) long.zhang 05.16.2016 (Bug id 5146 - Some Computed fields not saving in PDF document)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ib_gb_sendtoback = ab_switch
return 1
end function

on u_cst_dw_design.create
this.pb_view=create pb_view
this.st_2=create st_2
this.dw_view=create dw_view
this.dw_properties_oval=create dw_properties_oval
this.dw_properties_text=create dw_properties_text
this.dw_properties_dw=create dw_properties_dw
this.uo_select=create uo_select
this.st_add=create st_add
this.st_1=create st_1
this.uo_design=create uo_design
this.dw_fields_alias=create dw_fields_alias
this.cb_screen_properties=create cb_screen_properties
this.st_tab=create st_tab
this.dw_select_section=create dw_select_section
this.dw_properties=create dw_properties
this.st_back=create st_back
this.uo_band=create uo_band
this.st_right=create st_right
this.r_1=create r_1
this.Control[]={this.pb_view,&
this.st_2,&
this.dw_view,&
this.dw_properties_oval,&
this.dw_properties_text,&
this.dw_properties_dw,&
this.uo_select,&
this.st_add,&
this.st_1,&
this.uo_design,&
this.dw_fields_alias,&
this.cb_screen_properties,&
this.st_tab,&
this.dw_select_section,&
this.dw_properties,&
this.st_back,&
this.uo_band,&
this.st_right,&
this.r_1}
end on

on u_cst_dw_design.destroy
destroy(this.pb_view)
destroy(this.st_2)
destroy(this.dw_view)
destroy(this.dw_properties_oval)
destroy(this.dw_properties_text)
destroy(this.dw_properties_dw)
destroy(this.uo_select)
destroy(this.st_add)
destroy(this.st_1)
destroy(this.uo_design)
destroy(this.dw_fields_alias)
destroy(this.cb_screen_properties)
destroy(this.st_tab)
destroy(this.dw_select_section)
destroy(this.dw_properties)
destroy(this.st_back)
destroy(this.uo_band)
destroy(this.st_right)
destroy(this.r_1)
end on

event constructor;//// add by gavin on 2009-02-26
uo_design.of_set_parentobject(this)
uo_band.of_set_parent(this)
//

if Not IsValid(im_DesignMenu) then
	im_DesignMenu = Create m_Screen_Design_RMB_Rpt
	im_DesignMenu.uf_Set_Parent(This)
end if

if Not IsValid(ids_SearchTemp) then ids_SearchTemp = Create DataStore
if Not IsValid(ids_SearchDevTemp) then ids_SearchDevTemp = Create DataStore
if Not IsValid(ids_Criteria) then ids_Criteria = Create DataStore
if Not IsValid(ids_Browse) then ids_Browse = Create DataStore
if not isvalid(ids_pic) then ids_pic = create datastore	//jervis -- 11.24.2009
ids_pic.Dataobject = "d_conv_view_pic"
ids_pic.SetTransobject( sqlca)

ids_field_depend = create datastore
ids_field_depend.dataobject = 'd_dddw_field_depend'

//BEGIN---Modify by Scofield on 2009-10-23
if w_mdi.of_security_access(5310) = 0 or w_mdi.of_security_access(5400) = 0 then
	dw_view.Modify("data_view_id.Protect = '1' data_view_id.Color = '8421504'")
	pb_view.Enabled = false
else
	dw_view.Modify("data_view_id.Protect = '0' data_view_id.Color = '0'")
	pb_view.Enabled = true
end if
//END---Modify by Scofield on 2009-10-23

inv_filesrv = create n_cst_filesrv
end event

event destructor;if IsValid(im_DesignMenu) then Destroy  im_DesignMenu
if IsValid(ids_SearchTemp) then Destroy ids_SearchTemp
if IsValid(ids_SearchDevTemp) then Destroy ids_SearchDevTemp
if IsValid(ids_Criteria) then Destroy ids_Criteria
if IsValid(ids_Browse) then Destroy ids_Browse
if IsValid(ids_field_depend) then Destroy ids_field_depend
if isvalid(ids_pic) then destroy ids_pic
if isvalid(inv_filesrv) then destroy inv_filesrv
end event

type pb_view from picturebutton within u_cst_dw_design
integer x = 882
integer y = 104
integer width = 87
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
boolean originalsize = true
alignment htextalign = left!
string powertiptext = "View Management"
end type

event clicked;OpenSheet(w_contract_data_views_manager, w_mdi, 4, Original!)
end event

type st_2 from statictext within u_cst_dw_design
integer x = 73
integer y = 16
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select View"
boolean focusrectangle = false
end type

type dw_view from datawindow within u_cst_dw_design
integer x = 46
integer y = 100
integer width = 832
integer height = 88
integer taborder = 20
string title = "none"
string dataobject = "d_select_views_dddw_list_contract2"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild ldwc_view
dw_view.GetChild('data_view_id',ldwc_view)
ldwc_view.SetTransObject(SQLCA)
ldwc_view.Retrieve()
This.InsertRow(0)
This.SetItem(1,'data_view_id',1001)

end event

event itemchanged;string   ls_Syntax
int  li
long ll_view_id
string ls_view_name
If dwo.name = 'data_view_id' Then
	ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")
	IF ls_Syntax <> is_OrgSyntax THEN                             //Modified by gavin on 2009-03-05
		li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
		IF li = 1 THEN
			IF of_save() < 0 THEN
				This.SetItem(1,'data_view_id',il_select_view)
				Return 2
			END IF
		ELSEIF li = 3 THEN
			This.SetItem(1,'data_view_id',il_select_view)
			Return 2
		END IF
	END IF
	is_OrgSyntax = ls_Syntax
	ll_view_id = Long(data)
	Select data_view_name into :ls_view_name From data_view Where data_view_id = :ll_view_id;
	Parent.SetRedraw( False )
	SetPointer(HourGlass!)
	of_select_view(ll_view_id,ls_view_name,ii_screen_id)
	Parent.SetRedraw( True )
End If

end event

type dw_properties_oval from u_dw within u_cst_dw_design
event type long ue_retrieve ( string as_object )
boolean visible = false
integer x = 151
integer y = 1088
integer width = 997
integer height = 616
integer taborder = 70
string dataobject = "d_intellicred_oval_properties"
end type

event type long ue_retrieve(string as_object);//====================================================================
// Event: ue_retrieve
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_object	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-25
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ProExp
long		ll_Cycle,ll_PropCnts,ll_Pos
String	ls_ColProp[],ls_ColName[]

CONSTANT STRING TABCHAR = "~t"

ls_ColProp[UpperBound(ls_ColProp) + 1] = ".visible"
ls_ColName[UpperBound(ls_ColName) + 1] = "visible"

ls_ColProp[UpperBound(ls_ColProp) + 1] = ".Background.Color"
ls_ColName[UpperBound(ls_ColName) + 1] = "background_color"

ls_ColProp[UpperBound(ls_ColProp) + 1] = ".Brush.Color"
ls_ColName[UpperBound(ls_ColName) + 1] = "brush_color"

ls_ColProp[UpperBound(ls_ColProp) + 1] = ".Brush.Hatch"
ls_ColName[UpperBound(ls_ColName) + 1] = "brush_hatch"

ls_ColProp[UpperBound(ls_ColProp) + 1] = ".Pen.Color"
ls_ColName[UpperBound(ls_ColName) + 1] = "pen_color"

ls_ColProp[UpperBound(ls_ColProp) + 1] = ".Pen.Style"
ls_ColName[UpperBound(ls_ColName) + 1] = "pen_style"

ls_ColProp[UpperBound(ls_ColProp) + 1] = ".Pen.Width"
ls_ColName[UpperBound(ls_ColName) + 1] = "pen_width"

This.Reset()
This.InsertRow(0)

This.SetItem(1, "name", as_Object)

ll_PropCnts = UpperBound(ls_ColProp)
for ll_Cycle = 1 to ll_PropCnts
	ls_ProExp = Trim(uo_band.dw_syntax.Describe(as_Object + ls_ColProp[ll_Cycle]))
	if LeftA(ls_ProExp,1) = '"' then
		ls_ProExp = MidA(ls_ProExp,2)
	end if
	if RightA(ls_ProExp,1) = '"' then
		ls_ProExp = LeftA(ls_ProExp,LenA(ls_ProExp) - 1)
	end if
	ll_Pos = PosA(ls_ProExp,TABCHAR)
	if ll_Pos > 0 then ls_ProExp = MidA(ls_ProExp,ll_Pos + 1)
	This.SetItem(1, ls_ColName[ll_Cycle], ls_ProExp)
next

Return 1

end event

type dw_properties_text from u_dw within u_cst_dw_design
event type long ue_retrieve ( string as_object )
boolean visible = false
integer x = 151
integer y = 456
integer width = 997
integer height = 616
integer taborder = 20
string dataobject = "d_contract_text_properties"
end type

event type long ue_retrieve(string as_object);long ll_Color

this.Reset()
this.InsertRow(0)

is_OriTextName = as_Object

this.SetItem(1, "name", as_Object)
this.SetItem(1, "visible", uo_band.dw_syntax.Describe(as_Object + ".visible"))
this.SetItem(1, "text", uo_band.dw_syntax.Describe(as_Object + ".text"))
this.SetItem(1, "alignment", uo_band.dw_syntax.Describe(as_Object + ".alignment"))
this.SetItem(1, "border", uo_band.dw_syntax.Describe(as_Object + ".border"))

ll_Color = Long(uo_band.dw_syntax.Describe(as_Object + ".color"))
this.SetItem(1, "text_color", ll_Color)
ll_Color = Long(uo_band.dw_syntax.Describe(as_Object + ".background.color"))
this.SetItem(1, "background_color", ll_Color)

if IsValid(w_intellicred_text_properties) then
	w_intellicred_text_properties.of_ShowColor()
end if

Return 1

end event

type dw_properties_dw from u_dw within u_cst_dw_design
event type long ue_retrieve ( long al_data_view_id,  long al_screen_id )
event type string ue_getdeftitlebartext ( long al_screen_id )
boolean visible = false
integer x = 151
integer y = 456
integer width = 997
integer height = 616
integer taborder = 20
string dataobject = "d_contract_dw_properties"
end type

event type long ue_retrieve(long al_data_view_id, long al_screen_id);long ll_Color
long ll_RowCount
string ls_titlebar_text

ll_RowCount = this.Retrieve(al_data_view_id, al_screen_id)
if ll_RowCount > 0 then
	ll_Color = Long(uo_band.dw_syntax.Describe("datawindow.color"))
	this.SetItem(1, "background_color", ll_Color)
	ls_titlebar_text = this.object.titlebar_text[1]
	if IsNull(ls_titlebar_text) or LenA(ls_titlebar_text) = 0 then
		ls_titlebar_text = this.Event ue_GetDefTitleBarText(al_screen_id)
		this.object.titlebar_text[1] = ls_titlebar_text
	end if
	this.ResetUpdate()
end if

if IsValid(w_contract_dw_properties) then
	w_contract_dw_properties.of_ShowColor()
end if

Return ll_RowCount
end event

event type string ue_getdeftitlebartext(long al_screen_id);//////////////////////////////////////////////////////////////////////
// $<event>  ue_getdeftitlebartext()
// $<arguments> 
// 		long	al_screen_id
// $<returns>   string
// $<description> Get default title bar text
//////////////////////////////////////////////////////////////////////
// $<add> 11/11/2008 by Evan
//////////////////////////////////////////////////////////////////////

integer li_Pos
string  ls_screen_name
string  ls_titlebar_text

choose case al_screen_id
	case 17
		ls_titlebar_text = "Notes"
	case 18
		ls_titlebar_text = "Parent Organization"
	case 19
		ls_titlebar_text = "Group / Locations"
	case 20
		ls_titlebar_text = "Associated Physicians for Selected Facility"
	case 21
		ls_titlebar_text = "Specialties for Selected Facility"
	case else
		ls_screen_name = this.object.screen_name[1]
		li_Pos = LastPos(ls_screen_name, ">")
		if li_Pos > 0 then
			ls_titlebar_text = RightA(ls_screen_name, LenA(ls_screen_name) - li_Pos)
		end if		
end choose

Return ls_titlebar_text
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

type uo_select from u_contract_select_screen within u_cst_dw_design
event ue_retrieve ( long al_data_view_id )
integer x = 18
integer y = 272
integer width = 978
integer taborder = 20
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_retrieve(long al_data_view_id);long ll_FirstScreenItem

// Create screen view
tv_screen.of_Retrieve(al_data_view_id)
ids_screen = tv_screen.ids_data

// Select first screen item
ll_FirstScreenItem = tv_screen.of_FindFirstScreenItem()
tv_screen.SelectItem(ll_FirstScreenItem)
end event

on uo_select.destroy
call u_contract_select_screen::destroy
end on

event ue_selectionchanged;call super::ue_selectionchanged;TreeViewItem ltvi_item

// Get screen item information
if tv_screen.GetItem(al_NewHandle, ltvi_item) = -1 then Return 0
if ltvi_item.PictureIndex = 1 then Return 0
//of_SetTitle("Select Data Screen (" + ltvi_item.Label + ")")
of_SetTitle("Select Data Screen") //Modified By Ken.Guo 2009-09-09. titlebar width is too short.

il_CurrentScreenHandle = al_NewHandle

// Show datawindow
ii_screen_id = ltvi_item.data
SetPointer(HourGlass!)
of_select_screen(0, ii_screen_id)

is_UnDoList = is_EmptyList

// Reset properties window data
dw_properties_text.Reset()
dw_properties_dw.Event ue_Retrieve(il_data_view_id, ii_screen_id)
SetPointer(Arrow!)

// UI setting
//Commented by Scofield on 2009-03-24
/*
If il_select_view <> 1001 And (ii_screen_id = 1 Or ii_screen_id = 2) Then
	st_1.visible = True
	If ii_screen_id = 1 Then
		st_1.text = 'The Search Criteria screen can only be modified in the Default View.'
	Else
		st_1.text = 'The Search Contract Browse screen can only be modified in the Default View.'
	End If
	If isvalid(m_pfe_cst_contract_data_design) Then
		m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = False
		m_pfe_cst_contract_data_design.m_file.m_save.enabled = False
	End If
	uo_design.of_setobjectenable( false )
Else
*/
	st_1.visible = False
	If isvalid(m_pfe_cst_contract_data_design) Then
		m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = true
		m_pfe_cst_contract_data_design.m_file.m_save.enabled = false
	End If
	uo_design.of_setobjectenable( true)
//End If

Return 0
end event

event ue_selectionchanging;call super::ue_selectionchanging;int  li
string ls_Syntax

dw_properties_dw.AcceptText()
ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")

//Modified by gavin on 2009-03-05
//IF ls_Syntax <> parent_window_design.is_OrgSyntax or dw_properties_dw.ModifiedCount() > 0 THEN
IF ls_Syntax <> is_OrgSyntax or dw_properties_dw.ModifiedCount() > 0 THEN
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		IF of_save() < 0 THEN
			return 1
		END IF
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF

Return 0
end event

event ue_rightclicked;call super::ue_rightclicked;//Add by jervis 09.11.2009
//Right clicks the Tab name then Display the Tab Properties dialog 
//Right clicks the Screen name then Display the Screen Properties dialog 

TreeviewItem	ltvi_item

// Determine if set tab page properties
if this.tv_screen.GetItem(this.tv_screen.il_CurrentHandle,ltvi_item) <> 1 then  return 0

if ltvi_item.PictureIndex <> 1 then
	post of_dw_property_sheet()
else
	this.tv_screen.post of_setview_properties( il_data_view)
end if

return 0
end event

type st_add from statictext within u_cst_dw_design
boolean visible = false
integer x = 2149
integer y = 1808
integer width = 1673
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Click where you want to add the object."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within u_cst_dw_design
boolean visible = false
integer x = 1801
integer y = 1128
integer width = 1687
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "The Search Contract Browse screen can only be modified in the Default View."
boolean focusrectangle = false
end type

type uo_design from u_cst_dw_design_menu within u_cst_dw_design
integer x = 1024
integer width = 3639
integer taborder = 10
end type

on uo_design.destroy
call u_cst_dw_design_menu::destroy
end on

type dw_fields_alias from datawindow within u_cst_dw_design
boolean visible = false
integer x = 1083
integer y = 912
integer width = 686
integer height = 400
integer taborder = 60
string dataobject = "d_view_fields_alias_screen"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//$<add> 03.25.2008 by Andy
this.settransobject( SQLCA )
end event

type cb_screen_properties from u_cb within u_cst_dw_design
boolean visible = false
integer x = 23
integer y = 1712
integer width = 736
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Edit Screen Parameters"
end type

event clicked;Integer li_last_row
TreeViewItem ltvi_item

//BEGIN---Modify by Evan 07/14/2008
//ii_screen_id = dw_select_section.GetItemNumber(dw_select_section.GetRow(), "screen_id") 
if uo_select.tv_screen.of_GetCurrentItem(ltvi_item) = -1 then Return
if ltvi_item.PictureIndex = 1 then Return
ii_screen_id = ltvi_item.Data
//END---Modify by Evan 07/14/2008

Open( w_screen_maint)

IF Message.StringParm = "Cancel" THEN
	Return
END IF

dw_select_section.SetRedraw(False)

ib_refresh_screen_list = True

li_last_row = dw_select_section.GetRow()

dw_select_section.Retrieve( il_data_view_id )
dw_select_section.ScrollToRow( li_last_row)
dw_select_section.SetRow( li_last_row )
dw_select_section.SelectRow( li_last_row, True)

ib_refresh_screen_list = False

dw_select_section.SetRedraw(True)
end event

type st_tab from statictext within u_cst_dw_design
boolean visible = false
integer x = 2327
integer y = 1752
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Click on red tab labels to modify."
boolean focusrectangle = false
end type

type dw_select_section from u_dw within u_cst_dw_design
event pfc_cst_after_error ( )
boolean visible = false
integer x = 14
integer y = 268
integer width = 1234
integer height = 1684
integer taborder = 20
boolean titlebar = true
string title = "Select Data Screen"
string dataobject = "d_contract_data_view_screens_list"
boolean hscrollbar = true
end type

event pfc_cst_after_error();//dw_detail.SetFocus()
end event

event clicked;call super::clicked;//Integer li_row
//
//li_row = This.GetClickedRow()
//
//IF li_row = 0 THEN
//	dw_detail.SetFocus()
//END IF
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow = 0 THEN
	Return
END IF
ii_screen_id = dw_select_section.GetItemNumber(currentrow, "screen_id") 
of_select_screen( currentrow, ii_screen_id )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
//Commented by Scofield on 2009-03-24
/*
If il_select_view <> 1001 And (ii_screen_id = 1 Or ii_screen_id = 2) Then
	st_1.visible = True
	If ii_screen_id = 1 Then
		st_1.text = 'The Search Criteria screen can only be modified in the Default View.'
	Else
		st_1.text = 'The Search Contract Browse screen can only be modified in the Default View.'
	End If
	If isvalid(m_pfe_cst_contract_data_design) Then
		m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = False
		m_pfe_cst_contract_data_design.m_file.m_save.enabled = False
	End If
	uo_design.of_setobjectenable( false)
Else
*/
	st_1.visible = False
	If isvalid(m_pfe_cst_contract_data_design) Then
		m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = True
		m_pfe_cst_contract_data_design.m_file.m_save.enabled = True
	End If
	uo_design.of_setobjectenable( true)
//End If	
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 04.12.2007 By: Jack
//$<reason> Fix a defect.
/*
//dw_detail.vscrollbar = True
If appeongetclienttype() = 'PB' Then
//	If il_dw_style = 1 Then
		dw_detail.setposition(ToTop!)
		dw_detail.vscrollbar = True
		dw_detail.hscrollbar = True
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.11.2007 By: Jack
		//$<reason> fix a defect.
		/*
		dw_detail.x = 1257
		dw_detail.width = 2688
		*/
		dw_detail.x = dw_select_section.x + dw_select_section.width + 20
		dw_detail.width = parent.width - dw_detail.x - 20
		//---------------------------- APPEON END ----------------------------
		hsb_detail.visible = false
		vsb_detail.visible = false
	Else
		dw_detail.setposition(ToBottom!)
		dw_detail.vscrollbar = false
		dw_detail.hscrollbar = false
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.11.2007 By: Jack
		//$<reason> fix a defect.
		/*
		dw_detail.x = 1257
		dw_detail.width = 3930
		*/
		dw_detail.x = dw_select_section.x + dw_select_section.width + 20
		dw_detail.width = parent.width - dw_detail.x -20
		//---------------------------- APPEON END ----------------------------
		hsb_detail.visible = true
		vsb_detail.visible = true
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.11.2007 By: Jack
		//$<reason> Fix a defect.		
		hsb_detail.x = dw_detail.x
		vsb_detail.x = parent.width - 100
		hsb_detail.y = parent.height - 100
		hsb_detail.width = dw_detail.width - 88
		vsb_detail.y = dw_detail.y
		vsb_detail.height = dw_detail.height - 68
		hsb_detail.position = 0
		vsb_detail.position = 0
		//---------------------------- APPEON END ----------------------------
	End If
End If
*/
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;call super::rowfocuschanging;//Integer li_retval
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-19
////$<add> 03.03.2006 By: Cao YongWang
////$<reason> Performance tuning. 
////$<modification> Write script to make sure that when pfc_cst_u_data_entry
////$<modification> is just opened, RowFocusChanging is not executed immediately.
//If ib_just_open Then
//	ib_just_open = False
//	return
//End If
//If currentrow < 1 Then return
////---------------------------- APPEON END ----------------------------
//
//IF ib_screen_painter THEN
//	IF is_designer_type = "S" THEN
//		IF Parent_window_design.Event pfc_Save() < 0 THEN
//			This.PostEvent( "pfc_cst_after_error" )
//			Return 1
//		END IF
//	ELSE
//		IF Parent_window_profile_design.Event pfc_Save() < 0 THEN
//			This.PostEvent( "pfc_cst_after_error" )
//			Return 1
//		END IF		
//	END IF
//ELSE
//	li_retval = Parent_window.Event pfc_Save()
//
//	IF li_retval < 0 THEN
//		This.PostEvent( "pfc_cst_after_error" )
//		Return 1
//	END IF	
//END IF
//

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-20 By: Andy
//$<Reason> If it's modified,then show a messagebox.
string   ls_Syntax
int  li

ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")

//Modified by gavin on 2009-03-05
//IF ls_Syntax <> parent_window_design.is_OrgSyntax THEN
IF ls_Syntax <> is_OrgSyntax THEN
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		IF of_save() < 0 THEN
			return 1
		END IF
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF
//---------------------------- APPEON END ----------------------------
end event

event pfc_deleterow;Return 1
end event

event pfc_addrow;Return 1
end event

event pfc_firstpage;RETURN 0
end event

event pfc_lastpage;RETURN 0
end event

event pfc_nextpage;RETURN 0
end event

event pfc_previouspage;RETURN 0
end event

event constructor;call super::constructor;This.of_SetUpdateable(False)
end event

type dw_properties from u_dw within u_cst_dw_design
boolean visible = false
integer y = 308
integer width = 946
integer height = 1480
integer taborder = 10
string dataobject = "d_intellicred_field_properties"
end type

event constructor;This.of_SetUpdateable(False)
This.of_SetTransObject( SQLCA )
end event

type st_back from statictext within u_cst_dw_design
boolean visible = false
integer x = 5
integer y = 260
integer width = 1253
integer height = 1700
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217750
boolean focusrectangle = false
end type

type uo_band from u_cst_dw_band_painter within u_cst_dw_design
integer x = 1033
integer y = 276
integer width = 3634
integer height = 1668
integer taborder = 20
end type

on uo_band.destroy
call u_cst_dw_band_painter::destroy
end on

type st_right from statictext within u_cst_dw_design
boolean visible = false
integer x = 3867
integer y = 420
integer width = 87
integer height = 1680
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217750
boolean focusrectangle = false
end type

type r_1 from rectangle within u_cst_dw_design
integer linethickness = 4
long fillcolor = 33551856
integer x = 27
integer y = 36
integer width = 969
integer height = 212
end type

