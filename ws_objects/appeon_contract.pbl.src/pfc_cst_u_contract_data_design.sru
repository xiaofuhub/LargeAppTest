$PBExportHeader$pfc_cst_u_contract_data_design.sru
forward
global type pfc_cst_u_contract_data_design from userobject
end type
type dw_opsyntax from u_dw within pfc_cst_u_contract_data_design
end type
type pb_view from picturebutton within pfc_cst_u_contract_data_design
end type
type st_2 from statictext within pfc_cst_u_contract_data_design
end type
type dw_view from datawindow within pfc_cst_u_contract_data_design
end type
type dw_properties_oval from u_dw within pfc_cst_u_contract_data_design
end type
type dw_properties_text from u_dw within pfc_cst_u_contract_data_design
end type
type dw_properties_dw from u_dw within pfc_cst_u_contract_data_design
end type
type uo_select from u_contract_select_screen within pfc_cst_u_contract_data_design
end type
type st_add from statictext within pfc_cst_u_contract_data_design
end type
type st_1 from statictext within pfc_cst_u_contract_data_design
end type
type uo_design from uo_contract_design_menu within pfc_cst_u_contract_data_design
end type
type dw_fields_alias from datawindow within pfc_cst_u_contract_data_design
end type
type cb_screen_properties from u_cb within pfc_cst_u_contract_data_design
end type
type st_tab from statictext within pfc_cst_u_contract_data_design
end type
type dw_select_section from u_dw within pfc_cst_u_contract_data_design
end type
type dw_properties from u_dw within pfc_cst_u_contract_data_design
end type
type st_back from statictext within pfc_cst_u_contract_data_design
end type
type uo_band from pfc_cst_u_band_painter within pfc_cst_u_contract_data_design
end type
type st_right from statictext within pfc_cst_u_contract_data_design
end type
type r_1 from rectangle within pfc_cst_u_contract_data_design
end type
type p_originalsize from uo_image_tool within pfc_cst_u_contract_data_design
end type
end forward

global type pfc_cst_u_contract_data_design from userobject
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
event type integer ue_selectmultiobject ( string as_type,  pfc_cst_u_band adw_band,  string as_name )
event ue_field_depend ( )
event ue_addfield ( )
event ue_addgridfield ( )
event ue_restore ( )
event ue_closedocument ( )
event ue_opendocument ( )
event ue_refreshdocument ( )
dw_opsyntax dw_opsyntax
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
p_originalsize p_originalsize
end type
global pfc_cst_u_contract_data_design pfc_cst_u_contract_data_design

type variables
w_contract_data_design parent_window_design

DataStore	ids_SearchTemp,ids_SearchDevTemp
DataStore	ids_Criteria,ids_Browse,ids_detail
//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
DataStore	ids_document_SearchTemp,ids_document_SearchDevTemp //Added By Jay Chen 04-03-2014
Integer ii_document_RetrieveStatus //Added By Jay Chen 04-03-2014
boolean ib_screen_document = false //Added By Jay Chen 04-03-2014
long il_CurDocID //Added By Jay Chen 04-03-2014
//---------End Added ------------------------------------------------------

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

Boolean ib_resize_Leftwidth = False//added by gavins 20120425
Boolean ib_resize_Upheight = False
Boolean ib_resize_Cross = False

Boolean ib_resize_width = False
Boolean ib_resize_height = False
Boolean ib_mouse_down
Boolean ib_multi_select = False
Boolean ib_control_down = False
Boolean ib_relocating_fields = False
Boolean ib_set_tab_order = False
Boolean ib_show_invisible = True

m_screen_design_rmb  im_DesignMenu

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
str_Selectobj	istr_SelectObj[]
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
string  is_CopySyntax[],is_FieldSyntax[]
string  is_CurBand,is_orgband
String  is_sql_syntax
String  is_open_style
long	  il_FirstSelectColor=15793151
long    ii_data_view
String	 is_Fields[]
String	 is_ChangedScreenStyle="", is_OriginalScreenStyle, is_LastSaveScreenStyle
boolean	ib_GridModify
// end by gavin on 2009/3/4

//Add by jervis 07.21.2010
boolean ib_calc1_changed = false
boolean ib_calc2_changed = false
boolean ib_calc3_changed = false

CONSTANT STRING ENTERCHAR = "~r~n"
CONSTANT STRING LISTSEPARATECHAR = ","

String	is_LastSelObjList = LISTSEPARATECHAR
String	is_Compute_Label_Name,is_Compute_Label_Text

datastore ids_field_depend

datastore ids_pic, ids_picdelete	//jervis 11.23.2009
n_cst_filesrv inv_filesrv  //jervis 11.23.2009
CONSTANT String is_pic_path = 'Bitmap'

datastore ids_field_ex		//jervis 01.26.2011
private:
boolean ib_header = false
boolean ib_detail = false
boolean ib_summary = false
boolean ib_footer = false

Long il_preview_screen_id

String		is_CutObjects[]//gavins 20120410
DataStore	ids_Properties

n_screen_pictrue		invo_Pictrue[], invo_Null[] //added by gavins 20131218
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
public function pfc_cst_u_band wf_getband (string as_band)
public function long wf_isselected (string as_name)
public function integer wf_makeband (string as_syntax)
public function integer wf_preparecopy (pfc_cst_u_band adw_band)
public function integer of_multiselectobjects (keycode key, unsignedlong keyflags)
public function integer wf_copyobject (pfc_cst_u_band adw_band)
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
public subroutine of_autoupdatedetailscreen (string as_objname)
public function integer wf_addinvisiblefield_bak (string as_objtype, long al_x, long al_y)
public function integer wf_addinvisiblefield (string as_objtype, long al_x, long al_y)
public function integer wf_addinvisibleobject (pfc_cst_u_band adw_band, string as_objname, string as_objsyntax, string as_destband, long al_x, long al_y)
public function integer of_get_opsyntax (string as_orgsyntax, string as_opeclist, ref string as_opsyntax, ref string as_lookuplist)
public function string of_getscreensyntax (long al_screen_id, boolean ab_grid)
public function integer of_create_dynamic_dw_bak (integer ai_screen_id, boolean ab_use_defaultdwo)
public function integer of_create_dynamic_dw (integer ai_screen_id, boolean ab_use_defaultdwo)
public function integer of_showhidegridcolumn (string as_title[], string as_column[], long al_x, long al_y, string as_show)
public function integer of_checkmodified ()
public subroutine of_resetupdated (string as_style)
public subroutine of_autoupdatesearchscreen (string as_objname, string as_tobject)
public subroutine of_moveobject ()
public function integer wf_addcompute (string as_objtype, long al_x, long al_y)
public subroutine wf_moveobject (string as_orientation, string as_object[], long al_x)
public subroutine of_deleteobject ()
public subroutine of_setobjectposition (str_selectobj as_objects[], boolean ab_frontorback)
public function integer of_line_property_sheet (string as_object)
public function integer of_bitmap_properties_sheet (string as_object)
public function integer of_picture_properties_sheet (string as_object, string as_path, string as_filename)
public function integer of_compute_properties_sheet (string as_object)
public function integer of_groupbox_properties_sheet (string as_object)
public function string of_get_screendataobject ()
public subroutine of_synchronization_toolbar (string as_name)
public function string of_align_object (datastore ads_grid)
public subroutine of_synchronization_text (string as_text)
public subroutine of_autoupdatedocumentscreen (string as_objname)
public subroutine of_deletepicfile ()
public subroutine of_delete_screen_pictrue (string as_oname)
public subroutine of_set_screen_pictrue (string as_filekey, string as_oname, string as_filepath, string as_copyname)
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

str_FieldProperty	lstr_Property

//user security :Screen Painter - Contract Field Properties
if IsValid(w_mdi) then
	if w_mdi.of_security_access(5320) = 0 then 
		//Added By Ken.Guo 2011-05-12. for RMB Properties of Screen Paitner
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//Messagebox('Properties','You do not have sufficient authority to access the Field Properties. ~r~n~r~nIf you do need this function, please contact your ContractLogix administrator to give you the required authority through the Roles Painter',Exclamation!)		
		Messagebox('Properties','You do not have sufficient authority to access the Field Properties. ~r~n~r~nIf you do need this function, please contact your IntelliSoft administrator to give you the required authority through the Roles Painter',Exclamation!)		
		//---------End Modfiied ------------------------------------------------------
		Return
	End If
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
		
		if Not IsNull(lstr_Property.Label_font_face ) then//added by gavins 201212014
			if ls_Type = "column" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "_t.font.face")
			else
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".font.face")
			end if
			
			if lstr_Property.Label_font_face = "" then
				lstr_Property.Label_font_face = ls_ProValue
			elseif lstr_Property.Label_font_face <> ls_ProValue then
				SetNull(lstr_Property.Label_font_face)
			end if
		end if
		
		if Not IsNull(lstr_Property.Label_font_height ) then//added by gavins 201212014
			if ls_Type = "column" then
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + "_t.font.height")
			else
				ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".font.height")
			end if
			if ls_ProValue = '?' then ls_ProValue = '8'
			ls_ProValue = string(Abs(long(ls_ProValue)))
			if lstr_Property.Label_font_height = "" then
				lstr_Property.Label_font_height = ls_ProValue
			elseif lstr_Property.Label_font_height <> ls_ProValue then
				SetNull(lstr_Property.Label_font_height)
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
		if Not IsNull(lstr_Property.field_font_face ) then//added by gavins 201212014
			ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".font.face")
				
			if lstr_Property.field_font_face = "" then
				lstr_Property.field_font_face = ls_ProValue
			elseif lstr_Property.field_font_face <> ls_ProValue then
				SetNull(lstr_Property.field_font_face)
			end if
		end if
		
		if Not IsNull(lstr_Property.field_font_height ) then//added by gavins 201212014
			ls_ProValue = istr_SelectObj[ll_Cycle].FBand.Describe(ls_ObjName + ".font.height")
	
			if ls_ProValue = '?' then ls_ProValue = '8'
			ls_ProValue = string(Abs(long(ls_ProValue)))
			if lstr_Property.field_font_height = "" then
				lstr_Property.field_font_height = ls_ProValue
			elseif lstr_Property.field_font_height <> ls_ProValue then
				SetNull(lstr_Property.field_font_height)
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
	
	OpenWithParm(w_contract_mul_field_properties,lstr_Property)

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
			case "ellipse", "rectangle"
				of_oval_property_sheet(ls_ObjName)		//Added by Scofield on 2009-02-25
			case 'bitmap'
				of_bitmap_properties_sheet( ls_ObjName )
//				of_picture_property_sheet(ls_objname)  //Add by jervis 11.30.2009
			Case 'line'
				of_line_property_sheet(ls_objname)
			case 'groupbox'
				of_groupbox_properties_sheet( ls_objname )
		end choose
	end if
end if

end event

event ue_closecontract();//====================================================================
// Function: ue_closecontract.pfc_cst_u_contract_data_design()
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

long	ll_Row,ll_RowCnt

DataWindow	ldw_Search,ldw_SearDt

il_CurCtxID = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
gw_Contract.of_BackupFocusObject(gw_Contract.Control[])

ldw_Search = gw_contract.tab_contract_details.tabpage_search.dw_search
ldw_SearDt = gw_contract.tab_contract_details.tabpage_search.dw_search_det1

//ids_SearchTemp.DataObject = ldw_Search.DataObject
//ids_SearchDevTemp.DataObject = ldw_SearDt.DataObject
//modified by gavins 20120423
ids_SearchTemp.create( ldw_Search.describe( "datawindow.syntax" )  )
ids_SearchDevTemp.create( ldw_SearDt.describe( "datawindow.syntax" )  )

ldw_Search.RowsCopy(1,ldw_Search.RowCount(),Primary!,ids_SearchTemp,1,Primary!)
ldw_SearDt.RowsCopy(1,ldw_SearDt.RowCount(),Primary!,ids_SearchDevTemp,1,Primary!)

ib_RetrieveStatus = gw_Contract.tab_contract_details.tabpage_search.ib_AutoRetrieve
gw_Contract.tab_contract_details.tabpage_search.ib_AutoRetrieve = false

gw_Contract.TriggerEvent("pfc_close")

end event

event ue_opencontract();//====================================================================
// Function: ue_opencontract.pfc_cst_u_contract_data_design()
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

//Set Tab Enable - jervis 09.26.2010
IF ll_RowCnt < 1 THEN 
	gw_contract.Dynamic Function wf_set_tab_enabled(False)
Else
	gw_contract.Dynamic Function wf_set_tab_enabled(True)
end if


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

end event

event ue_refreshcontract();//====================================================================
// Function: ue_refreshcontract.pfc_cst_u_contract_data_design()
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
	gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'Enabled', true)
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
//st_add.Y = 1808
st_add.Y = uo_band.y + uo_band.height - 100 //1808 jervis 09.26.2010
st_add.TextSize = -10

ll_Pos = Pos(as_ObjType," ")
if ll_Pos > 0 then
	as_ObjType = Left(as_ObjType,ll_Pos - 1)
	
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
// Author:	Scofield		Date: 2009-04-27
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
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

//Add snap to grid feature - jervis 04.28.2010
//ll_UnitX = PixelsToUnits(1,XPixelsToUnits!) 
//ll_UnitY = PixelsToUnits(1,YPixelsToUnits!)
ll_UnitX = PixelsToUnits(gi_snaptogrid_x,XPixelsToUnits!) 
ll_UnitY = PixelsToUnits(gi_snaptogrid_y,YPixelsToUnits!)

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

str_SelectObj   lstr_temp[]

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

String  	ls_Name,ls_ObjName , ls_Null[], ls_Objects[]
long  	ll_TotalCnts,ll_ObjSelCnts,ll_Result,ll_NotDelCnts
long  	ll_Cycle,ll_Index,ll_Cnt,ll_RtnVal = 1

pfc_cst_u_band   ldw_band

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
	
					if Pos(lower(ls_Name),"object") > 0 then
						of_delete_pic(lower(ls_name),false) //Delete Picture File From Database -- Jervis 11.23.2009
					
						/************************************/ //added by gavins 20120405
						If ldw_band.Describe( ls_Name + ".type" ) = 'compute'  Then
							If il_dw_style = 1 And ldw_Band.Describe( ls_Name + ".band" ) = 'detail' Then
								this.of_showhidegridcolumn( {ls_Name + "_t"} ,{ ls_Name} , 0, 0, '' )
							End If
							ldw_band.Modify("destroy " + ls_Name+"_t")
							uo_Band.dw_Header.Modify( "destroy " + ls_Name+"_t")
							uo_Band.dw_Header.Modify( "destroy " + ls_Name )
							This.Event ue_SetModify( "destroy " + ls_Name+"_t")
						ElseIf ldw_band.Describe( ls_Name + ".type" ) = 'text' Then
							If il_dw_style = 1 and ldw_Band.Describe(  Left( ls_Name, len( ls_Name ) - 2  ) + ".band" ) = 'detail' Then
								this.of_showhidegridcolumn( {ls_Name  } ,{  Left( ls_Name, len( ls_Name ) - 2  ) } , 0, 0, '' )
							End If
							uo_Band.dw_detail.Modify("destroy " + Left( ls_Name, len( ls_Name ) - 2  ) )  
							uo_Band.dw_detail.Modify("destroy " + ls_Name)
							uo_Band.dw_Header.Modify( "destroy " + ls_Name )
							uo_Band.dw_Header.Modify( "destroy " + Left( ls_Name, len( ls_Name ) - 2  ) )
							This.Event ue_SetModify("destroy " + Left( ls_Name, len( ls_Name ) - 2  ) )
						End If
						/************************************/		
						ldw_band.Modify("destroy " + ls_Name)
						This.Event ue_SetModify("destroy " + ls_Name)
						
						ldw_band.of_AddorDelSingleSelect(ls_Name,false)
									
						//Clear the object in the is_Objects[]   Or  ldw_band.is_Objects[ll_Index] = Left( ls_Name, len( ls_Name ) - 2  )  
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
				For ll_Cycle = 1 To UpperBound( is_CutObjects )
					ls_ObjName =is_CutObjects[ll_cycle]
					uo_band.dw_header.Modify( ls_ObjName  + ".visible='1'")
					uo_band.dw_headergroup.Modify(  ls_ObjName + ".visible='1'")
					uo_band.dw_detail.Modify(  ls_ObjName + ".visible='1'")
					uo_band.dw_trailergroup.Modify(  ls_ObjName + ".visible='1'")
					uo_band.dw_summary.Modify(  ls_ObjName + ".visible='1'")
					uo_band.dw_footer.Modify( ls_ObjName + ".visible='1'")
					This.Event ue_SetModify( ls_ObjName + ".visible='1'") 
				Next
				is_CutObjects = ls_Null
				for ll_Cycle = 1 to ll_TotalCnts
					ls_ObjName = istr_SelectObj[ll_Cycle].Fname
					if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
					
					is_CutObjects[ll_Cycle] = ls_ObjName //added by gavins 20120410
					
					ldw_band = istr_SelectObj[ll_Cycle].Fband
					ldw_band.of_AddorDelSingleSelect(ls_ObjName,false)
					
					//ldw_band.Modify("destroy " + ls_ObjName)
					/* //modified by gavins 20120410
					uo_band.dw_header.Modify("destroy " + ls_ObjName)
					uo_band.dw_headergroup.Modify("destroy " + ls_ObjName)
					uo_band.dw_detail.Modify("destroy " + ls_ObjName)
					uo_band.dw_trailergroup.Modify("destroy " + ls_ObjName)
					uo_band.dw_summary.Modify("destroy " + ls_ObjName)
					uo_band.dw_footer.Modify("destroy " + ls_ObjName)*/  
					
					uo_band.dw_header.Modify( ls_ObjName  + ".visible='0'")
					uo_band.dw_headergroup.Modify(  ls_ObjName + ".visible='0'")
					uo_band.dw_detail.Modify(  ls_ObjName + ".visible='0'")
					uo_band.dw_trailergroup.Modify(  ls_ObjName + ".visible='0'")
					uo_band.dw_summary.Modify(  ls_ObjName + ".visible='0'")
					uo_band.dw_footer.Modify( ls_ObjName + ".visible='0'")
					
//					of_delete_pic(lower(ls_name),true) //Delete Picture File From Database -- Jervis 11.23.2009
//					This.Event ue_SetModify("destroy " + ls_ObjName)
					This.Event ue_SetModify( ls_ObjName + ".visible='0'") 
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
		//added by gavins 20120410
		If ib_cut Then this.of_deleteobject( )
		
		ll_RtnVal = wf_CopyObject(ldw_band)
	CASE 'sendtoback'//added by gavins 20120418
		If ll_ObjSelCnts > 0 Then
			of_SetObjectPosition( istr_SelectObj, false )
		End If		
	CASE 'bringtofront'
		If ll_ObjSelCnts > 0 Then
			of_SetObjectPosition( istr_SelectObj, true )
		End If				
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
//modified by gavins 20120514
//if il_dw_style = 0 then
//	im_DesignMenu.m_edit.m_new.m_field.Visible = true
//else
//	im_DesignMenu.m_edit.m_new.m_field.Visible = false
//end if

ll_SelObjCnts = of_GetSelectedObjectCnts()
ll_ClipObjCnts = of_GetClipboardObjCnts()

if ll_SelObjCnts <= 0 then
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_new,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_delete,'Enabled', false)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_cut,'Enabled', false)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_copy,'Enabled', false)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_front,'Enabled', false)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_bottom,'Enabled', false)	
	if is_Open_Style = 'screen' then
		gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_itemprop,'Enabled', true)
	else
		gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_itemprop,'Enabled', false)
	end if
elseif ll_SelObjCnts = 1 then
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_new,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_delete,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_cut,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_copy,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_itemprop,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_front,'Enabled', gb_EnableSetPosition)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_bottom,'Enabled', gb_EnableSetPosition)	
else
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_new,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_delete,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_cut,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_copy,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_itemprop,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_front,'Enabled', gb_EnableSetPosition)
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_bottom,'Enabled', gb_EnableSetPosition)	
end if

if ib_PreparCopying and ll_ClipObjCnts > 0 then
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_paste,'Enabled', true)
else
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_paste,'Enabled', false)
end if

//Added By Ken.Guo 2011-05-12. for RMB Properties of Screen Paitner
If w_mdi.of_security_access(5320) = 0 Then
	gnv_app.of_modify_menu_attr( im_DesignMenu.m_edit.m_itemprop,'Enabled', False)
End If

if is_Open_Style = 'screen' then
//   im_DesignMenu.m_edit.PopMenu(This.X + This.PointerX() + 10,This.Y + This.PointerY() + 160)//modified by gavins 20130408
	im_DesignMenu.m_edit.PopMenu( w_mdi.PointerX() + 10,This.Y + This.PointerY() + 160  )
else
   im_DesignMenu.m_edit.PopMenu(This.X + This.PointerX(),This.Y + This.PointerY() )
end if

end event

event ue_resize;// adjust userobject size
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

event type integer ue_selectmultiobject(string as_type, pfc_cst_u_band adw_band, string as_name);/*
long   ll_Count,ll_Color,ll_Seq,ll
str_Selectobj  lstr_Empty[]
pfc_cst_u_band ldw_Band

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

event ue_field_depend();//add by jervis 09.24.2009
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




end event

event ue_addfield();//BEGIN---Modify by Scofield on 2010-03-29

String	ls_Select_Field_List

OpenWithParm(w_InVisibleFieldList,This)

ls_Select_Field_List = Message.StringParm
if ls_Select_Field_List <> "" then
	This.wf_PickUpFieldSyntax(ls_Select_Field_List)
end if

//END---Modify by Scofield on 2010-03-29

end event

event ue_addgridfield();//added by gavins 20120306 grid
String	ls_Select_Field_List

OpenWithParm(w_InVisibleFieldList,This)

ls_Select_Field_List = Message.StringParm
if ls_Select_Field_List <> "" then
	This.wf_PickUpFieldSyntax(ls_Select_Field_List)
end if
end event

event ue_restore();//
String						ls_SQL, ls_ver, ls_ReVer, ls_OVer1,ls_OVer2
Long						ll_ViewID, ll_ScreenID
Long						ll_FindRow, li_pos, ll_FindRow2
String						ls_DataObject, ls_ScreenStyle, ls_Temp, ls_Syntax
	
	
n_cst_update_screen	lno_screen		

lno_screen = Create n_cst_update_screen
	
ls_Ver = 	lno_screen.is_screen_version

//il_data_view_id
/**************************************/ //added by gavins 20120306 grid
ll_FindRow = dw_properties_dw.Find("screen_id=" + String(ii_screen_id), 1, dw_properties_dw.RowCount())
If ll_FindRow > 0 Then
	ls_ScreenStyle = dw_properties_dw.GetItemString( ll_FindRow, 'screen_style' )

Else
	MessageBox( 'Screen' , 'no find Screen!' )
	Return
End If

	
OpenWithParm( w_contract_screen_history, String(il_data_view_id ) + "#" + string( ii_screen_id ) + '*' + ls_ScreenStyle )

ls_Temp = Message.StringParm
ls_ReVer = Left( ls_Temp, Pos( ls_Temp, '##' )  - 1)
ls_SQL = Mid( ls_Temp, Pos( ls_Temp, '##' ) + 2 )
If IsNull( ls_SQL ) Or Trim( ls_SQL ) = '' Then Return

SetPointer( HourGlass! )
If ls_ReVer = 'G' Then
	ls_DataObject = dw_properties_dw.GetItemString( ll_FindRow, 'grid_dataobject' )
Else
	ls_DataObject = dw_properties_dw.GetItemString( ll_FindRow, 'dataobject' )
End If
ls_OVer1 = string( dw_properties_dw.object.screen_style[ll_findrow] )
dw_properties_dw.SetItem( ll_findrow, 'screen_style' , ls_ReVer )

ll_FindRow2 = ids_Screen.Find("screen_id=" + String(ii_screen_id), 1, ids_Screen.RowCount())
If ll_FindRow2 > 0 Then
	ls_OVer2 = string( ids_Screen.object.screen_style[ll_Findrow2] )
	ids_Screen.SetItem( ll_Findrow2, 'screen_style', ls_Rever )
End If


//If ls_Ver <> ls_ReVer Then
If 	lno_screen.of_appeon2_changes( il_data_view_id, ii_screen_id, ls_SQL, ls_DataObject, ids_Screen ) < 0 Then	//upgrade
	dw_properties_dw.SetItem( ll_findrow, 'screen_style' , ls_OVer1 )
	ids_Screen.SetItem( ll_Findrow2, 'screen_style', ls_OVer2 )
	Return
End If
SetPointer( HourGlass! )
//End If

If IsValid( lno_screen ) Then Destroy lno_screen

il_dw_style = 0
// Convert grid style to tabular
li_pos = Pos(ls_sql,"processing=1")
IF li_pos > 0 THEN
	ls_sql = Left(ls_sql,li_pos - 1) + "processing=0" + Mid(ls_sql, li_pos + 12)
	il_dw_style = 1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.27.2007 By: Jack 
//$<reason> Fix a defect.
If ii_screen_id = 2 Then
	//$<comment> 01.11.2008 by: Andy
	//Reason:There are many invisible objects,if these range in a row,there is a bug in WEB verion(can not display all invisible objects when Show Invisible button is clicked).
	//il_dw_style = 1
	
	li_pos = Pos(ls_sql,"1	if( master_contract_id > 0,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 33)
	End If
	
	li_pos = Pos(ls_sql,"1	if( master_cnt > 0 ,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 26)
	End If	
End If	
ls_Syntax = is_OrgSyntax  // the target is save    
SetPointer( HourGlass! )
wf_makeband( ls_SQL )
uo_design.pb_show.hide( )
uo_design.pb_show.borderstyle = styleRaised!
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
	uo_design.pb_line.Visible = TRUE
	uo_design.pb_rectangle.Visible = True
	//end of add
	uo_design.st_3.Visible = FALSE
	uo_design.st_4.Visible = FALSE
	uo_design.hsb_1.Visible = FALSE
	uo_design.hsb_2.Visible = FALSE
	
	uo_design.pb_gridcolumn.Visible = FALSE
	uo_design.pb_gridtext.Visible = FALSE
	uo_design.pb_gridoval.Visible = FALSE
	uo_design.pb_gridcompute.Visible = FALSE
	uo_design.pb_gridpicture.Visible = FALSE

	uo_design.pb_gridline.Visible = FALSE
	uo_design.pb_gridrectangle.Visible = FALSE
	
	uo_design.st_show_invisible.Visible = FALSE		//Added by Scofield on 2010-03-23
	uo_design.pb_show.x = 2505
ELSE
	//$<comment> 2007-11-07 By: Andy
	//idw_detail.Modify( "DataWindow.Detail.Height = 1000" )
	
	uo_design.pb_compute.Visible = FALSE
	uo_design.pb_column.Visible = FALSE
	uo_design.pb_text.Visible = FALSE
	uo_design.r_2.Visible = TRUE
	//uo_design.st_2.Visible = false
	uo_design.st_7.Visible = TRUE
	uo_design.pb_groupbox.Visible = TRUE
	uo_design.pb_oval.Visible = FALSE	//Added by Scofield on 2009-03-20
	//<add> 06/21/2007 by: Andy
	uo_design.pb_picture.Visible = FALSE
	uo_design.pb_line.Visible = False	
	uo_design.pb_rectangle.Visible = False
	//end of add	
	uo_design.st_3.Visible = TRUE
	uo_design.st_4.Visible = TRUE
	uo_design.hsb_1.Visible = TRUE
	uo_design.hsb_2.Visible = TRUE
	
	uo_design.st_show_invisible.Visible = FALSE		//Added by Scofield on 2010-03-23  //modified by gavins 20120308 grid
	
	uo_design.pb_gridcolumn.Visible = TRUE //added by gavins 20120306 grid
	uo_design.pb_gridtext.Visible = TRUE
	uo_design.pb_gridoval.Visible = TRUE
	uo_design.pb_gridcompute.Visible = TRUE
	uo_design.pb_gridpicture.Visible = TRUE

	uo_design.pb_gridline.visible = TRUE
	uo_design.pb_gridrectangle.Visible = TRUE
	
	//$<modify> 01.11.2008 By: Andy
	uo_band.dw_detail.Modify("DataWindow.Selected.Mouse = No")
	uo_design.pb_show.x =3650
END IF

//$<add> 03.25.2008 by Andy
dw_fields_alias.retrieve( 1 , ','+String(ii_screen_id)+',' , il_data_view)
//end of add 03.25.2008

ib_AlwaysUpdate = false		//Added by Scofield on 2009-10-12


is_OrgSyntax = ls_Syntax
If ls_SQL <> is_OrgSyntax Then Event ue_SetModify( ""  )

SetPointer( Arrow! )

end event

event ue_closedocument();//====================================================================
// Event: ue_closedocument
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//// (Appeon)Harry 05.06.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

long	ll_Row,ll_RowCnt

DataWindow	ldw_Search,ldw_SearDt

ldw_Search = w_documents_browse.uo_1.tab_1.tabpage_browse.dw_filter
ldw_SearDt = w_documents_browse.uo_1.tab_1.tabpage_browse.dw_browse

ll_row = ldw_SearDt.getrow()
if ll_row > 0 then il_CurDocID = ldw_SearDt.getitemnumber(ll_row,"doc_id")

ids_document_SearchTemp.create( ldw_Search.describe( "datawindow.syntax" )  )
ids_document_SearchDevTemp.create( ldw_SearDt.describe( "datawindow.syntax" )  )

ldw_Search.RowsCopy(1,ldw_Search.RowCount(),Primary!,ids_document_SearchTemp,1,Primary!)
ldw_SearDt.RowsCopy(1,ldw_SearDt.RowCount(),Primary!,ids_document_SearchDevTemp,1,Primary!)

ii_document_RetrieveStatus = w_documents_browse.ii_retrieve

w_documents_browse.TriggerEvent("pfc_close")

end event

event ue_opendocument();//====================================================================
// Event: ue_opendocument
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//// (Appeon)Harry 05.06.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

long	ll_Row,ll_RowCnt

DataWindow	ldw_Search,ldw_SearDt

SetPointer(HourGlass!)

w_documents_browse.SetRedraw( false)

ldw_Search = w_documents_browse.uo_1.tab_1.tabpage_browse.dw_filter
ldw_SearDt = w_documents_browse.uo_1.tab_1.tabpage_browse.dw_browse

ldw_Search.Reset()
ids_document_SearchTemp.RowsCopy(1,ids_document_SearchTemp.RowCount(),Primary!,ldw_Search,1,Primary!)
ids_document_SearchDevTemp.RowsCopy(1,ids_document_SearchDevTemp.RowCount(),Primary!,ldw_SearDt,1,Primary!)

w_documents_browse.ii_retrieve = ii_document_RetrieveStatus
If ii_document_RetrieveStatus = 1 Then
	w_documents_browse.cbx_retrieve.checked = True
End If

ll_RowCnt = ldw_SearDt.RowCount()
ll_Row = ldw_SearDt.Find("doc_id = " + String(il_CurDocID),1,ll_RowCnt)
if ll_Row > 0 then
	ldw_SearDt.ScrollToRow(ll_Row)
	ldw_SearDt.SetRow(ll_Row)
	ldw_SearDt.Event RowFocusChanged(ll_Row)
end if

//ldw_SearDt.Trigger Event RowFocusChanged(1)

SetPointer(Arrow!)
w_documents_browse.SetRedraw( true)



end event

event ue_refreshdocument();//====================================================================
// Event: ue_refreshdocument
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//// (Appeon)Harry 05.06.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

if IsValid(w_documents_browse) then

	w_documents_browse.SetRedraw( false)
	Trigger Event ue_Closedocument()
	
	SetPointer(HourGlass!)
	OpenSheet(w_documents_browse, w_mdi, 0, original!)
	w_documents_browse.il_winview_just_open = il_data_view_id
	w_documents_browse.TriggerEvent("pfc_preopen")
	w_documents_browse.PostEvent("pfc_postopen")
	w_mdi.SetRedraw(true)
	w_documents_browse.TriggerEvent("open")
	SetPointer(Arrow!)
	
	Trigger Event ue_Opendocument()
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
	IF Upper(Mid(ls_col_name, 1, 10 )) = "SYS_FIELDS"  THEN
		li_sys_col_cnt ++
		ls_sys_fields_update[li_sys_col_cnt] = ls_col_name
	ELSEIF Upper(Mid(ls_col_name, 1, 16 )) = "DATA_VIEW_FIELDS" THEN
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
			case 'headergroup'                                //modify by gavin on 2009/3/4
				uo_band.dw_headergroup.modify( ls_modify)
			case 'trailergroup'                               //modify by gavin on 2009/3/4
				uo_band.dw_trailergroup.modify( ls_modify)
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
				ls_Modify = "create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")" 
			else
				ls_Modify = "create text(band=foreground text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")" 
			end if
			//uo_band.dw_detail.Modify("create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")"  )
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
	uo_band.dw_detail.Modify( Mid( is_last_tab_label_name, 5, 100 ) + ".TabSequence = '" + uo_band.sle_tab.Text + "'" )		
	
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
		//---------Begin Added by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		elseif 	li_field_order = 0 then	//added by long.zhang 09.02.2013 support to modify tab order to 0
			ls_Modify = ls_field_nm + ".TabSequence = '0'"
			uo_band.dw_detail.Modify( ls_Modify )
			this.event ue_setmodify( ls_Modify )
		//---------End Added ------------------------------------------------------
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

	//Added By Ken.Guo 02/16/2012. 
	Messagebox('Screen','The system will create this screen by using the Default View 1001.')
	If of_create_dynamic_dw(ai_screen_id, True) < 0 Then
		Return -1
	End If
	
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
//of_show_invisible( ib_show_invisible )



dw_properties.ResetUpdate( )
uo_design.dw_1.SetText('') //Added By Ken.Guo 2009-09-03.
//$<comment> 2007-11-05 By: Andy
//dw_detail.ResetUpdate( )

Return 1
end function

public function integer of_select_view ();String 	ls_ViewName,ls_data_view_name
long		ll_Handle,ll_View_id,ll_screen_id

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-20 By: Andy
//$<Reason> If it's modified,then show a messagebox.
string   ls_Syntax
int  li

ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")
IF ls_Syntax <> is_OrgSyntax THEN                             //Modified by gavin on 2009-03-05
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		IF of_save() < 0 THEN
			return 1
		END IF
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF
is_OrgSyntax = ls_Syntax
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-01-13 By: Scofield
//$<Reason> Open Screen painter window.

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//Added By Jay Chen 04-03-2014
string ls_status_progress
boolean lb_document_window = false
If isvalid(w_mdi.inv_statusbar) then
	ls_status_progress=w_mdi.inv_statusbar.of_describe( 'Process','Process.Expression' )
end if
if pos(ls_status_progress,'Documents Browse') > 0 then 
	lb_document_window = true
	ib_screen_document = true
end if

//Added By Jay Chen 04-03-2014
if lb_document_window then  //document browse window
	if IsValid(w_documents_browse) then 
		ll_View_id = gl_SearchTab_document_View
		SELECT data_view_name INTO :ls_ViewName FROM data_view WHERE data_view_id = :ll_View_id ;
		if IsNull(ls_ViewName) then ls_ViewName = ""
		Message.StringParm = String(ll_View_id) + "~t" + ls_ViewName
	end if
else //contract window
//---------End Added ------------------------------------------------------
	if IsValid(gw_contract) and il_select_view = 0 then
		if gw_contract.tab_contract_details.SelectedTab = 1 then
			ll_View_id = gl_SearchTab_View_id
		else
			ll_View_id = gi_contract_view_id
		end if
		
		SELECT data_view_name INTO :ls_ViewName FROM data_view WHERE data_view_id = :ll_View_id ;
		if IsNull(ls_ViewName) then ls_ViewName = ""
		
		Message.StringParm = String(ll_View_id) + "~t" + ls_ViewName
		
		if IsValid(parent_window_design) then parent_window_design.il_initview_id = ll_View_id
	elseif w_mdi.of_security_access(5310) = 0 or w_mdi.of_security_access(5400) = 0 then
		ll_View_id = long(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + Upper(gs_user_id) + "'"))
		if IsNull(ll_View_id) or ll_View_id = 0 then ll_View_id = 1001
		
		SELECT data_view_name INTO :ls_ViewName FROM data_view WHERE data_view_id = :ll_View_id ;
		if IsNull(ls_ViewName) then ls_ViewName = ""
		
		Message.StringParm = String(ll_View_id) + "~t" + ls_ViewName
	else
		OpenWithParm( w_select_view, "C" ) // P-practitioner view C- Contract view
	end if
	//---------------------------- APPEON END ----------------------------
end if

IF Message.StringParm = "Cancel" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.26.2007 By: Jack
	//$<reason> Fix a defect.
	il_select_view = il_data_view	
	il_data_view_id = il_data_view
	//---------------------------- APPEON END ----------------------------
	//BEGIN---Delete by Evan 07/14/2008
	/*
	IF dw_select_section.Rowcount( ) = 0 THEN
		dw_select_section.Reset()
		dw_select_section.of_SetTransObject(SQLCA)
		dw_select_section.Retrieve( il_data_view )
		dw_select_section.SelectRow( 1, True )
	END IF
	*/
	//END---Delete by Evan 07/14/2008
	Return -1
ELSE
	/*
	IF parent_window_design.Event pfc_save() < 0 THEN
		Return -1
	END IF
	*/
	This.SetRedraw( False )

	Integer li_pos
	String ls_msg
	
	ls_msg = Message.StringParm
	li_pos = Pos( ls_msg, '~t' )
	il_data_view_id = Long( Left( ls_msg, li_pos - 1 ) )
	ls_data_view_name = Right( ls_msg, Len( ls_msg ) - li_pos )
	//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
	//of_select_view(il_data_view_id,ls_data_view_name,0)
	//Added By Jay Chen 04-03-2014
	if lb_document_window then
		if IsValid(w_documents_browse) then
			if w_documents_browse.il_current_properties_view <> 0 and w_documents_browse.il_current_properties_screen <> 0 then //Added By Jay Chen 04-04-2014
				of_select_view(w_documents_browse.il_current_properties_view,ls_data_view_name,w_documents_browse.il_current_properties_screen)
				w_documents_browse.il_current_properties_screen = 0
			else
				of_select_view(il_data_view_id,ls_data_view_name,w_documents_browse.uo_1.il_current_screen)
			end if
		end if
	else
		of_select_view(il_data_view_id,ls_data_view_name,0)
	end if
	//---------End Modfiied ------------------------------------------------------
	
	dw_view.Setitem(1,'data_view_id',il_data_view_id)
	//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
	//Added By Jay Chen 04-04-2014
	if IsValid(w_documents_browse) then
		if w_documents_browse.il_current_properties_view <> 0 then 
			il_select_view = gl_SearchTab_document_View
			il_data_view_id = gl_SearchTab_document_View
			il_data_view= gl_SearchTab_document_View
			w_documents_browse.il_current_properties_view = 0
		end if
	end if
	//---------End Added ------------------------------------------------------
	
	/* move to of_select_view(al_view_id,as_view_name,al_screen_id)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	il_select_view = il_data_view_id
	//$<add> 03.17.2008 By: nova
	//$<reason> Fix a defect.BugN022703
	il_data_view= il_data_view_id	
	//---------------------------- APPEON END ----------------------------
	parent_window_design.Title = "Contract Data Screen Painter ( " + ls_data_view_name + " )"
	//BEGIN---Modify by Evan 07/14/2008
	uo_select.Event ue_Retrieve(il_data_view_id)
	//END---Modify by Evan 07/14/2008
	
	//BEGIN---Modify by Scofield on 2009-04-20
	if IsValid(gw_contract) then
		ll_screen_id = gw_contract.of_GetCurrentScreenID()
		if ll_screen_id > 0 then
			ii_screen_id = ll_screen_id
			ll_Handle = uo_select.tv_screen.of_FindItemWithData(String(ii_screen_id))
			if ll_Handle > 0 then uo_select.tv_screen.SelectItem(ll_Handle)
		end if
	end if
	//END---Modify by Scofield on 2009-04-20
	*/
	This.SetRedraw(True)
END IF

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
STRING ls_str, ls_VisibleExpress
STRING ls_edit_style
STRING ls_edit_codetable
STRING ls_editmask_codetable
STRING ls_column_coltype
STRING ls_column_border
STRING ls_column_ID
String ls_SlideUp,ls_AutoHeight
long ll_row_count,ll_find
String		ls_objects, ls_Color, ls_Expression
// Reset datawindow
dw_properties.Reset()

//Add "Add on Fly " properties in field - jervis 01.26.2011
if not isvalid(ids_field_ex) then 
	ids_field_ex = create datastore
	ids_field_ex.dataobject = "d_contract_field_properties_ex"
	ids_field_ex.SetTransObject(sqlca)
end if
ll_row_count = ids_field_ex.Retrieve(il_data_view_id, ii_screen_id)

// Through all field
ll_column_count = long(adw_detail.Describe("DataWindow.Column.Count"))
FOR ll_column = 1 TO ll_column_count

	ll_row = dw_properties.Insertrow( 0 )

	ls_column_name = adw_detail.Describe("#" + string(ll_column) + ".name")
	ls_edit_style = Lower(adw_detail.Describe(ls_column_name+".Edit.Style"))
	ls_edit_codetable = Lower(adw_detail.Describe ( ls_column_name + ".Edit.CodeTable" ))
	ls_editmask_codetable = Lower(adw_detail.Describe ( ls_column_name + ".EditMask.CodeTable"))
	ls_column_coltype	= left(adw_detail.Describe(ls_column_name +".COLType"),4)
	
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
		
	/*****************************************///modified by gavins 20120503
	If Pos( ls_str, '~t' ) > 0  Then
		ls_VisibleExpress =  ls_Str
		ls_str = "1"
	Else
		ls_VisibleExpress = ""
	End If
	IF ls_str = "0" THEN 
		ls_str = "N"		
	ELSEIF ls_str = "1" or ls_str = "-1" THEN  //APB Bug, return -1 if dynamic create datawindow - jervis 05.11.2011
			ls_str = "Y" 
	End If
	//---------------------------- APPEON END ----------------------------
	dw_properties.Setitem( ll_row, "data_view_fields_visible", ls_str)
	dw_properties.Setitem( ll_row, "fields_visibleexpress", ls_VisibleExpress)
	/*****************************************/
	
	// Field Label
	ls_str = adw_detail.Describe(ls_column_name + "_t.Text")
	//$<Modify> 2008-01-17 By: nova
	//$<Reason> Fix a defect. 
	if left(ls_str,1) = '"' then ls_str = Mid(ls_str,2)
   if Right(ls_str,1) = '"' then ls_str = Left(ls_str,len(ls_str) - 1)
	
	//$<Modify> 2008-01-04 By: Andy
	//$<Reason> Fix a defect. add if statement
	if Not (ls_str = "!" OR ls_str = "?") then
		dw_properties.Setitem( ll_row, "data_view_fields_field_label", ls_str)
	end if
	//end of modify 2008-01-04 
	
	// Field Label Color
	//BEGIN---Add by Evan 07/17/2008
	ls_Color = adw_detail.Describe(ls_column_name + "_t.color")	
	ls_Expression = ""
	If Pos( ls_Color, '~t' ) > 0 Then 
		ls_Expression = Mid( ls_color, Pos( ls_color, '~t' ) + 1 )
		ls_Expression = Left( ls_Expression, Len( ls_Expression ) - 1 )
		ls_Color = Mid( ls_Color, 2, Pos( ls_Color, '~t' ) - 2 )
	End If
	ll_Color = Long( ls_Color )	
	dw_properties.Setitem(ll_row, "fields_label_textcolor", ll_Color)
	dw_properties.Setitem(ll_row, "label_fontcolorexpress", ls_Expression )
	
	
	ls_Color = adw_detail.Describe(ls_column_name + "_t.background.color")	
	ls_Expression = ""
	If Pos( ls_Color, '~t' ) > 0 Then 
		ls_Expression = Mid( ls_color, Pos( ls_color, '~t' ) + 1 )
		ls_Expression = Left( ls_Expression, Len( ls_Expression ) - 1 )
		ls_Color = Mid( ls_Color, 2, Pos( ls_Color, '~t' ) - 2 )
	End If
	ll_Color = Long( ls_Color )	

	dw_properties.Setitem(ll_row, "label_backgroundcolorexpress", ls_Expression )
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
	dw_properties.Setitem( ll_row, "data_view_fields_required", Left(Upper(ls_str),1))
		
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
		
		//Add 'd_dddw_company_list' and  'dddw_contact_company_new' -- jervis 04.15.2011
		elseif (ls_str = 'd_dddw_company' or ls_str = 'd_dddw_company_list' or ls_str = 'dddw_contact_company_new') then 
			//Add Company dddw -- jervis 12.4.2009
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field", "C")

			// Lookup Table
			ls_str = adw_detail.Describe(ls_column_name + ".tag")
			if ls_str = '?' then ls_str = 'All' //jervis 04.15.2011
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
		dw_properties.Setitem( ll_row, "sys_fields_field_case", Left(Upper(ls_str),1))
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
	elseif ls_edit_style = 'checkbox' then	//Add checkbox style - add by jervis 07.18.2011
		dw_properties.Setitem( ll_row, "sys_fields_lookup_field", "B")
		//checkbox text
		ls_str = adw_detail.Describe(ls_column_name + ".checkbox.text")
		if ls_str <> "!" and ls_str <> "?" then
			dw_properties.Setitem(ll_row, "fields_cbx_text", ls_str)
		end if
		
		//checkbox 3d
		ls_str = adw_detail.Describe(ls_column_name + ".checkbox.3d")
		if ls_str <> "!" and ls_str <> "?" then
			dw_properties.Setitem(ll_row, "fields_3dlock", ls_str)
		end if
		
		//checkbox on value
		ls_str = adw_detail.Describe(ls_column_name + ".checkbox.on")
		if ls_str <> "!" and ls_str <> "?" then
			dw_properties.Setitem(ll_row, "fields_cbx_on", ls_str)
		end if
		
		//checkbox off value
		ls_str = adw_detail.Describe(ls_column_name + ".checkbox.off")
		if ls_str <> "!" and ls_str <> "?" then
			dw_properties.Setitem(ll_row, "fields_cbx_off", ls_str)
		end if
		
		//checkbox other value
		ls_str = adw_detail.Describe(ls_column_name + ".checkbox.other")
		if ls_str <> "!" and ls_str <> "?" then
			dw_properties.Setitem(ll_row, "fields_cbx_other", ls_str)
		end if
	end if
	
	// Audit Fld
	// Default Value
	ls_str = adw_detail.Describe(ls_column_name + ".Initial")
	dw_properties.Setitem( ll_row, "sys_fields_default_value", ls_str)
	
	//BEGIN---Modify by Scofield on 2009-08-27
	ls_Color = adw_detail.Describe(ls_column_name + ".color")	
	ls_Expression = ""
	If Pos( ls_Color, '~t' ) > 0 Then 
		ls_Expression = Mid( ls_color, Pos( ls_color, '~t' ) + 1 )
		ls_Expression = Left( ls_Expression, Len( ls_Expression ) - 1 )
		ls_Color = Mid( ls_Color, 2, Pos( ls_Color, '~t' ) - 2 )
	End If
	ll_Color = Long( ls_Color )	
	dw_properties.Setitem(ll_row, "fields_textcolor", ll_Color)
	dw_properties.Setitem(ll_row, "fields_fontcolorexpress", ls_Expression )
	
	
	ls_Color = adw_detail.Describe(ls_column_name + ".background.color")	
	ls_Expression = ""
	If Pos( ls_Color, '~t' ) > 0 Then 
		ls_Expression = Mid( ls_color, Pos( ls_color, '~t' ) + 1 )
		ls_Expression = Left( ls_Expression, Len( ls_Expression ) - 1 )
		ls_Color = Mid( ls_Color, 2, Pos( ls_Color, '~t' ) - 2 )
	End If
	ll_Color = Long( ls_Color )	

	dw_properties.Setitem(ll_row, "fields_backgroundcolorexpress", ls_Expression )
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
	dw_properties.Setitem( ll_row, "data_view_fields_display_only", Left(Upper(ls_str),1))
	
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
		dw_properties.Setitem( ll_row, "fields_vscrollbar", Left(Upper(ls_str),1))
	END IF
	
	//BEGIN---Modify by Scofield on 2010-02-01
	ls_SlideUp = adw_Detail.Describe(ls_Column_name + ".SlideUp")
	dw_Properties.SetItem(ll_Row,"Fields_SlideUp",ls_SlideUp)
	
	ls_AutoHeight = adw_Detail.Describe(ls_Column_name + ".Height.AutoSize")
	dw_Properties.SetItem(ll_Row,"Fields_AutoHeight",ls_AutoHeight)
	//END---Modify by Scofield on 2010-02-01
	
	
	//Add Font Properties -- jervis 09.01.2011
	string	ls_fonts_face,ls_fonts_size,ls_fonts_bold,ls_fonts_italic,ls_fonts_underline,ls_fonts_strikeout
	ls_fonts_face = adw_Detail.Describe(ls_Column_name + ".font.face")
	dw_Properties.SetItem(ll_Row,"font_face",ls_fonts_face)
	
	ls_fonts_size = adw_Detail.Describe(ls_Column_name + ".font.height")
	if ls_fonts_size = '?' then ls_fonts_size = '-8'
	ls_fonts_size = string(Abs(long(ls_fonts_size)))
	dw_Properties.SetItem(ll_Row,"font_height",long(ls_fonts_size))
	
	ls_fonts_bold = adw_Detail.Describe(ls_Column_name + ".font.weight")
	dw_Properties.SetItem(ll_Row,"font_weight",ls_fonts_bold)
	
	ls_fonts_italic = adw_Detail.Describe(ls_Column_name + ".font.italic")
	if ls_fonts_italic = '?' then ls_fonts_italic = '0'
	dw_Properties.SetItem(ll_Row,"font_italic",ls_fonts_italic)
	
	ls_fonts_underline = adw_Detail.Describe(ls_Column_name + ".font.underline")
	if ls_fonts_underline = '?' then ls_fonts_underline = '0'
	dw_Properties.SetItem(ll_Row,"font_underline",ls_fonts_underline)
	
	ls_fonts_strikeout = adw_Detail.Describe(ls_Column_name + ".font.strikethrough")
	if ls_fonts_strikeout = '?' then ls_fonts_strikeout = '0'
	dw_Properties.SetItem(ll_Row,"font_strikethrough",ls_fonts_strikeout)
	
	//Add "Add on Fly " properties in field - jervis 01.26.2011
	if ll_row_count > 0 then
		ll_find = ids_field_ex.find( "field_name = '" + ls_column_name + "'",1, ll_row_count)
		if ll_find > 0 then
			dw_Properties.SetItem(ll_Row,"fields_add_lookup",ids_field_ex.GetItemString(ll_find,'field_Add'))
		end if
	end if
	
	//Added By mark 03/31/12 init 'b_'+column+'_dotdd_company'	property in filed 
	ls_column_name = adw_detail.Describe("#" + string(ll_column) + ".name")
	ls_objects = adw_detail.Describe("Datawindow.Objects")
	If Pos(ls_objects, 'b_'+ls_column_name+'_dotdd_company') > 0 then
		If string(adw_detail.Describe('b_'+ls_column_name+'_dotdd_company.visible') ) = '1' Then
			dw_Properties.SetItem(ll_Row,"fields_add_dotdd_company",'Y')	
		Else
			dw_Properties.SetItem(ll_Row,"fields_add_dotdd_company",'N')				
		End If
	Else
		dw_Properties.SetItem(ll_Row,"fields_add_dotdd_company",'N')
	End If 
	
	/***********************************************************///added by gavins 20120428
	ls_fonts_face = adw_Detail.Describe(ls_Column_name + "_t.font.face")
	dw_Properties.SetItem(ll_Row,"label_font_face",ls_fonts_face)
	
	ls_fonts_size = adw_Detail.Describe(ls_Column_name + "_t.font.height")
	if ls_fonts_size = '?' then ls_fonts_size = '-8'
	ls_fonts_size = string(Abs(long(ls_fonts_size)))
	dw_Properties.SetItem(ll_Row,"label_font_height",long(ls_fonts_size))
	
	ls_fonts_bold = adw_Detail.Describe(ls_Column_name + "_t.font.weight")
	dw_Properties.SetItem(ll_Row,"label_font_weight",ls_fonts_bold)
	
	ls_fonts_italic = adw_Detail.Describe(ls_Column_name + "_t.font.italic")
	if ls_fonts_italic = '?' then ls_fonts_italic = '0'
	dw_Properties.SetItem(ll_Row,"label_font_italic",ls_fonts_italic)
	
	ls_fonts_underline = adw_Detail.Describe(ls_Column_name + "_t.font.underline")
	if ls_fonts_underline = '?' then ls_fonts_underline = '0'
	dw_Properties.SetItem(ll_Row,"label_font_underline",ls_fonts_underline)
	
	ls_fonts_strikeout = adw_Detail.Describe(ls_Column_name + "_t.font.strikethrough")
	if ls_fonts_strikeout = '?' then ls_fonts_strikeout = '0'
	dw_Properties.SetItem(ll_Row,"label_font_strikethrough",ls_fonts_strikeout)
	
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
Long ll_max_height, ll_DataViewID
Long ll_col_y, ll_col_height
string ls_visible
string ls_dw_opsyntax
string ls_spcelist
string ls_lookuplist, ls_Err
DataStore		lds_Test


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
ll_DataViewID = ids_screen.GetItemNumber( ll_cr, 'data_view_id' )
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


If ii_screen_id <> 2 Then
	IF il_dw_style = 1 THEN
		li_pos = Pos(ls_dw_syntax,"processing=0")
		IF li_pos > 0 THEN
			ls_dw_syntax = Left(ls_dw_syntax,li_pos - 1) + "processing=1" + Mid(ls_dw_syntax, li_pos + 12)
		END IF
	END IF		
Else
	/******************************************///added by gavins 20120309 grid
	If il_dw_style = 1 Then
		li_pos = Pos(ls_dw_syntax,"processing=0")
		IF li_pos > 0 THEN
			ls_dw_syntax = Left(ls_dw_syntax,li_pos - 1) + "processing=1" + Mid(ls_dw_syntax, li_pos + 12)
		END IF
	End if
	/******************************************/
	li_pos = Pos(ls_dw_syntax,'master_contract_id visible="1"')		//Modified by Scofield on 2010-05-05
	IF li_pos > 0 THEN
		ls_dw_syntax = Left(ls_dw_syntax,li_pos + 27) + "1	if( master_contract_id > 0,1,0)" + Mid(ls_dw_syntax, li_pos + 29)
	End If
	
	li_pos = Pos(ls_dw_syntax,'master_cnt visible="1"')				//Modified by Scofield on 2010-05-05
	IF li_pos > 0 THEN
		ls_dw_syntax = Left(ls_dw_syntax,li_pos + 19) + "1	if( master_cnt > 0 ,1,0)" + Mid(ls_dw_syntax, li_pos + 21)
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

lds_Test = Create DataStore

lds_Test.Create( ls_dw_syntax , ls_Err )
If Len( ls_Err ) > 0 Then
	gnv_debug.of_output( true, 'dataviewid='+string( il_data_view_id ) + ',screenid=' + string( ii_screen_id ) + ',error=' +  ls_Err + '~r~n syntax=' + ls_dw_syntax ) //added by gavin 20120919
	MessageBox( 'Save', 'Failed to save ! ' + ls_Err )
	Return -1
End If

IF il_dw_style = 1 THEN //added by gavins 20120605
	of_UnselectAllObject()
    ls_dw_syntax = of_align_object( lds_Test )
//    u.of_AddorDelSingleSelect(of_GetLastSelectedObject( ),true)
End If

//Add op syntax - jervis 10.11.2011
ls_spcelist = ids_screen.GetItemString( ll_cr,"fix_field")
if of_get_opsyntax(ls_dw_syntax,ls_spcelist,ls_dw_opsyntax,ls_lookuplist) < 0 then ls_dw_opsyntax = ls_dw_syntax

If Len( ls_dw_syntax ) < 10 Then
	gnv_debug.of_output( true, 'dataviewid='+string( il_data_view_id ) + ',screenid=' + string( ii_screen_id ) + ',error=' +  ls_Err + '~r~n syntax=' + ls_dw_syntax ) //added by gavin 20120919
	Return -1
End If
If Len( ls_dw_opsyntax ) < 10 Then
	gnv_debug.of_output( true, 'dataviewid='+string( il_data_view_id ) + ',screenid=' + string( ii_screen_id ) + ',error=' +  ls_Err + '~r~n syntax=' + ls_dw_opsyntax ) //added by gavin 20120919
	Return -1
End If
lds_Test.Create( ls_dw_opsyntax , ls_Err )
If Len( ls_Err ) > 0 Then
	gnv_debug.of_output( true, 'dataviewid='+string( il_data_view_id ) + ',screenid=' + string( ii_screen_id ) + ',error=' +  ls_Err + '~r~n syntax=' + ls_dw_opsyntax ) //added by gavin 20120919
	MessageBox( 'Save', 'Failed to save ! ' + ls_Err )
	Return -1
End If
/*******************************///added by gavins 20120309 grid
If dw_properties_dw.GetItemString( dw_properties_dw.getrow( ), 'screen_style' ) = 'G' Then
	ids_screen.SetItem(ll_cr,'grid_opsql',ls_dw_opsyntax)
	ids_screen.setitem(ll_cr,'grid_sql',ls_dw_syntax)	
	Update ctx_screen  set grid_opsql = :ls_dw_opsyntax, grid_sql = :ls_dw_syntax where data_view_id = :ll_dataviewid and screen_id = :ii_screen_id;  //added by gavins 20120919
Else
	ids_screen.SetItem(ll_cr,'dw_opsql',ls_dw_opsyntax)
	ids_screen.setitem(ll_cr,'dw_sql',ls_dw_syntax)
	Update ctx_screen  set dw_opsql = :ls_dw_opsyntax, dw_sql = :ls_dw_syntax where data_view_id = :ll_dataviewid and screen_id = :ii_screen_id;  //added by gavins 20120919
End If
If ib_GridModify Then 
	dw_properties_dw.SetItem( dw_properties_dw.getrow( ), 'grid_modify', 'N' )
	ib_GridModify = False
End If
/*******************************/
//ids_screen.SetItem(ll_cr,'dw_opsql',ls_dw_opsyntax)
ids_screen.SetItem(ll_cr,'lookup_list',ls_lookuplist)

 
//ids_screen.setitem(ll_cr,'dw_sql',ls_dw_syntax)
ldt_today = Datetime( Today(), Now() )
ids_screen.Setitem (ll_cr, "modify_date", ldt_today)
ids_screen.Setitem (ll_cr, "updated", 1)

gnv_appeondb.of_startqueue( )
If ids_screen.update( ) <> 1 Then
	MessageBox( 'Tips', 'Failed to save screen!' )//added by gavins 20120919
	rollback;
	return -1
End If

//Commented by Scofield on 2009-03-24
/*
if (ii_screen_id = 1 or ii_screen_id = 2) and il_data_view = 1001 then
	update ctx_screen set dw_sql = :ls_dw_syntax,modify_date = :ldt_today where data_view_id <> 1001 and screen_id = :ii_screen_id;
end if
*/

dw_fields_alias.Update( )
dw_properties_dw.Update()

ids_field_ex.update( ) // Add by jervis 01.26.2011
commit;
gnv_appeondb.of_commitqueue( )
//END---Modify by Evan 07/14/2008

ids_picdelete.Reset( )
ids_pic.update( )	//APB Bug, Don't use appeon queue--jervis -- 11.30.2009
of_upload_pic()	//Update bitmap - 11.24.2009

is_LastSaveScreenStyle =  dw_properties_dw.GetItemString( dw_properties_dw.getrow( ), 'screen_style' )//added by gavins 20120422


//parent_window_design.is_OrgSyntax = ls_dw_syntax   //Modified by gavin on 2009-03-05
is_OrgSyntax = ls_dw_syntax

//synchronization fee schedule calc fields to custom data screen - jervis 07.21.2010
if ii_screen_id = 31 and (ib_calc1_changed or ib_calc2_changed or ib_calc3_changed )then
	n_cst_update_screen lnv_update_screen
	datastore	lds_fee
	string ls_calcs[]
	lnv_update_screen = create n_cst_update_screen
	lds_fee = create datastore
	
	if ib_calc1_changed then ls_calcs[Upperbound(ls_calcs) + 1]  = "calc_field_1"
	if ib_calc2_changed then ls_calcs[Upperbound(ls_calcs) + 1]  = "calc_field_2"
	if ib_calc3_changed then ls_calcs[Upperbound(ls_calcs) + 1]  = "calc_field_3"
	
	lds_fee.Create( ls_dw_syntax)
	lds_fee.SetTransObject( sqlca)
	If Not isvalid(w_infodisp) Then Open(w_infodisp) //Added By Ken.Guo 06/13/2012
	lnv_update_screen.of_update_fee_calc(il_data_view,0,lds_fee,ls_calcs)
	If isvalid(w_infodisp) Then Close(w_infodisp) //Added By Ken.Guo 06/13/2012
	if isvalid(lnv_update_screen) then destroy lnv_update_screen
	if isvalid(lds_fee) then destroy lds_fee
end if


dw_properties.ResetUpdate( )
uo_band.dw_syntax.ResetUpdate( )
//$<add> 03.26.2008 by Andy
dw_fields_alias.ResetUpdate( )

of_ChangeScreenLable() //Add by Evan 11/24/2008

//BEGIN---Modify by Scofield on 2010-02-23
if IsValid(m_pfe_cst_contract_data_design) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'Enabled', false)
end if
//END---Modify by Scofield on 2010-02-23

//begin backup screen   that is  current screen  added by gavins 20120314 grid
//---------Begin Modified by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//n_cst_update_data        lno_backup

//lno_backup = create n_cst_update_data
n_cst_update_data_clx        lno_backup
lno_backup = create n_cst_update_data_clx
//---------End Modfiied ------------------------------------------------------

lno_backup.of_backup_screen(  il_data_view , ii_screen_id )

If IsValid( lno_backup ) Then Destroy ( lno_backup )



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
// Author:	Andy		Date: 2007-11-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History: Scofield 2010-03-23
//
//====================================================================

long		ll_XPos,ll_CurrXPos,ll_ColWidth,ll_StartPos,ll_TabPos, ll_XPOS2
String	ls_Objects,ls_CurrColumn,ls_ColName,ls_Modify

pfc_cst_u_band ldw_Band

ldw_Band = wf_GetBand(is_CurBand)
if IsNull(ldw_Band.is_CurObj) or ldw_Band.is_CurObj = '' then Return 0

ls_CurrColumn = ldw_Band.is_CurObj
if Right(ls_CurrColumn,2) = "_t" then
	ls_CurrColumn = Left(ls_CurrColumn,Len(ls_CurrColumn) - 2)
end if

ll_CurrXPos = long(ldw_Band.Describe(ls_CurrColumn + ".X"))
ll_ColWidth = long(ldw_Band.Describe(ls_CurrColumn + ".Width"))

ll_ColWidth = ll_ColWidth + ai_Width

ls_Modify = ls_CurrColumn +   ".Width='" + String(ll_ColWidth) + "' " + &
				ls_CurrColumn + "_t.Width='" + String(ll_ColWidth) + "' "

ls_Objects = ldw_Band.Describe("Datawindow.Objects") + "~t"

ll_TabPos = Pos(ls_Objects,"~t")
do while ll_TabPos > 0
	ls_ColName = Mid(ls_Objects,ll_StartPos,ll_TabPos - ll_StartPos)

	// Determine if object is the right type and in the right band
	if	ldw_Band.Describe(ls_ColName + ".Visible") = "1" then
		ll_XPos = long(ldw_Band.Describe(ls_ColName + ".X"))
		ll_XPOS2 = 1
		If ldw_band <> uo_band.dw_detail Then 	ll_XPOS2 =  Long( uo_band.dw_detail.Describe( ls_ColName + ".X" ) )
		if ll_XPos > ll_CurrXPos and ll_XPOS2 > 0  then
			ll_XPos   += ai_Width
			ls_Modify += ls_ColName + ".X='" + String(ll_XPos) + "' "
		end if
	end if

	ll_StartPos = ll_TabPos + 1
	ll_TabPos   =  Pos(ls_Objects,"~t",ll_StartPos)
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
// Author:	Andy	Date: 2007-11-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History: Scofield 2010-03-23
//
//====================================================================

long		ll_XPos,ll_TabPos,ll_ColSpace,ll_StartPos
long		ll_CurrXPos,ll_NextXPos,ll_CurrWidth,ll_NextWidth
String	ls_Objects,ls_Modify,ls_Visible,ls_Band,ls_ObjType
String	ls_CurrColumn,ls_NextColumn,ls_ColName

pfc_cst_u_band ldw_Band

ldw_Band = wf_GetBand(is_CurBand)
if IsNull(ldw_Band.is_CurObj) or ldw_Band.is_CurObj = '' then Return 0

ls_CurrColumn = ldw_Band.is_CurObj

if Right(ls_CurrColumn,2) = "_t" then
	ls_CurrColumn = Left(ls_CurrColumn,Len(ls_CurrColumn) - 2)
end if

ll_CurrXPos = Long(ldw_Band.Describe(ls_CurrColumn + ".X"))

if ai_Position > 0 then
	ll_NextXPos = 100000
	
	ls_Objects = ldw_Band.Describe("Datawindow.Objects") + "~t"

	ll_TabPos = Pos(ls_Objects,"~t")
	do while ll_TabPos > 0
		ls_ColName = Mid(ls_Objects,ll_StartPos,(ll_TabPos - ll_StartPos))
		
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
		ll_TabPos   = Pos(ls_Objects,"~t",ll_StartPos)
	loop

	if Len(ls_NextColumn) > 0 then
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
	
	ll_TabPos = Pos(ls_Objects,"~t")
	do while ll_TabPos > 0
		ls_ColName = Mid(ls_Objects,ll_StartPos,(ll_TabPos - ll_StartPos))
		
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
		ll_TabPos   =  Pos(ls_Objects,"~t",ll_StartPos)
	loop

	if Len(ls_NextColumn) > 0 then
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
//long ll_i,ll_count

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

//ll_count = UpperBound(is_button_object)
//For ll_i = 1 To ll_count
//	adw_target.Modify(is_button_object[ll_i] + ".visible =" + is_button_visible[ll_i] )
//Next 
//---------------------------- APPEON END ----------------------------
long ll_i,ll_count
String ls_object_visible //Added By Ken.Guo 03/08/2012. 

ll_count = UpperBound(is_button_object)
For ll_i = 1 To ll_count
	 //Modified By Ken.Guo 03/08/2012
	 //adw_target.Modify(is_button_object[ll_i] + ".visible =" + is_button_visible[ll_i] )
	 ls_object_visible = is_button_visible[ll_i]
	 If Left( ls_object_visible,1 ) = '"' Or   Left( ls_object_visible,1 ) = "'" Then  ls_object_visible =  Mid(  ls_object_visible, 2 )
	  If Right( ls_object_visible,1 ) = '"' Or   Right(ls_object_visible,1 ) = "'" Then  ls_object_visible =  Left( ls_object_visible, Len( ls_object_visible ) - 1  )
	 ls_object_visible = gnv_string.of_globalreplace( ls_object_visible, '"', '~~"') 
	 adw_target.Modify(is_button_object[ll_i] + '.visible ="' + ls_object_visible + '"' )
Next 

end subroutine

public function integer of_expression_sheet ();/**********************************************
Function: of_expression_sheet() returns (none)
describe: open expression dialog box
author  : Andy 06/21/2007
**********************************************/
str_pass  lstr_pass
String    ls_Expression
n_cst_string lnvo_string
pfc_cst_u_band ldw_band

//Modified by gavin on 2009-03-04
//ldw_band = parent_window_design.wf_getband( parent_window_design.is_CurBand )
ldw_band = wf_getband( is_CurBand )
if isNull(ldw_band.is_curobj) or ldw_band.is_curobj = '' then return 0

ls_Expression = ldw_Band.describe(ldw_band.is_curobj +".Expression")
if isnull(ls_Expression) then ls_Expression = ''
//<Modify> 08/10/2007 by: Andy Reason:BugV080401
IF Upper( appeongetclienttype() ) = 'PB' THEN
	if Left(ls_Expression,1) = '"' and Right(ls_Expression,1) = '"' then
		ls_Expression = Mid(ls_Expression,2,Len(ls_Expression) - 2)
	end if
	ls_Expression = lnvo_string.of_globalreplace( ls_Expression, '~~"', '"')
end if
//end if
lstr_pass.s_long[1] = 2	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
//lstr_pass.l_facility_id     = -1//-1:screen/else:export
lstr_pass.s_string          = ls_Expression//expression
lstr_pass.s_string_array[1] = ldw_band.is_curobj//object name
lstr_pass.s_u_dw            = ldw_Band//relative dw
openwithparm(w_export_expression,lstr_pass)

//Modified the Fee Schedule screen and calc_field_1 or calc_field_2 or calc_field_2 field
lstr_pass = message.Powerobjectparm
if isvalid(lstr_pass) then
	if ii_screen_id = 31 and ls_Expression <> lstr_pass.s_string then
		if ldw_band.is_curobj = "calc_field_1" then ib_calc1_changed = true
		if ldw_band.is_curobj = "calc_field_2" then ib_calc2_changed = true
		if ldw_band.is_curobj = "calc_field_3" then ib_calc3_changed = true
	end if
end if

return 0

end function

public function integer of_create_dynamic_dw (integer ai_screen_id);
Return of_create_dynamic_dw(ai_screen_id,false)

//String ls_sql
//Long ll_cr
////Integer li_pos//modified by nova 2008-09-23
//long li_pos
//String ls_error_create
//Long ll_dw_sql_len
//Long ll_screen_id
//Long ll_updated
//Long ll_FindRow
//
////BEGIN---Modify by Evan 07/14/2008
///*
//ll_cr = dw_select_section.Getrow()
//IF ll_cr = 0 THEN
//	//MessageBox("Select View", "You must first select a view before adding sections.")
//	Return 0
//END IF
//il_dw_style = 0
//ls_sql = dw_select_section.GetitemString(ll_cr, "dw_sql")
//
////$<add> 09.06.2006 By: Liang QingShi
//long ll_updated
//dw_select_section.accepttext()
//ll_updated = dw_select_section.getitemnumber(ll_cr,'updated')
//IF appeongetclienttype() = 'PB' and ll_updated = 0 THEN
////$<add> 09.06.2006 By: Liang QingShi
//
//	ll_dw_sql_len = dw_select_section.GetItemNumber( ll_cr, "dw_sql_len")
//	ll_screen_id = dw_select_section.GetItemNumber( ll_cr, "screen_id")
//	IF ll_dw_sql_len > 32765 THEN
//		ls_sql = f_get_screen_sql(il_data_view_id, ll_screen_id)
//	END IF
//END IF
//*/
//
//il_dw_style = 0
//
//ls_SQL = of_GetScreenSyntax(ai_screen_id)			//Modified by Scofield on 2009-09-29
//
////END---Modify by Evan 07/14/2008
//
//IF Isnull(ls_sql) OR LEN(ls_sql) = 0 THEN
//	Messagebox("Generate DataWindow", "The DataWindow does not exist in the database!")
//	RETURN -1
//END IF
//
//// Convert grid style to tabular
//li_pos = Pos(ls_sql,"processing=1")
//IF li_pos > 0 THEN
//	ls_sql = Left(ls_sql,li_pos - 1) + "processing=0" + Mid(ls_sql, li_pos + 12)
//	il_dw_style = 1
//END IF
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 03.27.2007 By: Jack 
////$<reason> Fix a defect.
//If ii_screen_id = 2 Then
//	//$<comment> 01.11.2008 by: Andy
//	//Reason:There are many invisible objects,if these range in a row,there is a bug in WEB verion(can not display all invisible objects when Show Invisible button is clicked).
//	//il_dw_style = 1
//	
//	li_pos = Pos(ls_sql,"1	if( master_contract_id > 0,1,0)")
//	IF li_pos > 0 THEN
//		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 33)
//	End If
//	
//	li_pos = Pos(ls_sql,"1	if( master_cnt > 0 ,1,0)")
//	IF li_pos > 0 THEN
//		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 26)
//	End If	
//End If	
//
////$<add> 2007-11-02 By: Andy
////parent_window_design.wf_makeband( ls_sql)
//If this.wf_makeband( ls_sql) < 0 Then  //modify by gavin on 2009/3/4
//	Return -1
//End If
////---------------------------- APPEON END ----------------------------
//
//// Free form style
//IF il_dw_style = 0 THEN
//	//$<comment> 2007-11-07 By: Andy
//	//idw_detail.Modify( "DataWindow.Detail.Height = 20000" )
//	
//	uo_design.pb_column.Visible = TRUE
//	uo_design.pb_compute.Visible = TRUE
//	uo_design.pb_text.Visible = TRUE
//	uo_design.r_2.Visible = TRUE
//	//uo_design.st_2.Visible = TRUE
//	uo_design.st_7.Visible = TRUE
//	uo_design.pb_groupbox.Visible = TRUE
//	uo_design.pb_oval.Visible = TRUE		//Added by Scofield on 2009-03-20
//	//<add> 06/21/2007 by: Andy
//	uo_design.pb_picture.Visible = TRUE
//	//end of add
//	uo_design.st_3.Visible = FALSE
//	uo_design.st_4.Visible = FALSE
//	uo_design.hsb_1.Visible = FALSE
//	uo_design.hsb_2.Visible = FALSE
//	
//	uo_design.st_show_invisible.Visible = FALSE		//Added by Scofield on 2010-03-23
//ELSE
//	//$<comment> 2007-11-07 By: Andy
//	//idw_detail.Modify( "DataWindow.Detail.Height = 1000" )
//	
//	uo_design.pb_compute.Visible = FALSE
//	uo_design.pb_column.Visible = FALSE
//	uo_design.pb_text.Visible = FALSE
//	uo_design.r_2.Visible = FALSE
//	//uo_design.st_2.Visible = false
//	uo_design.st_7.Visible = false
//	uo_design.pb_groupbox.Visible = FALSE
//	uo_design.pb_oval.Visible = FALSE	//Added by Scofield on 2009-03-20
//	//<add> 06/21/2007 by: Andy
//	uo_design.pb_picture.Visible = FALSE
//	//end of add	
//	uo_design.st_3.Visible = TRUE
//	uo_design.st_4.Visible = TRUE
//	uo_design.hsb_1.Visible = TRUE
//	uo_design.hsb_2.Visible = TRUE
//	
//	uo_design.st_show_invisible.Visible = TRUE		//Added by Scofield on 2010-03-23
//	
//	//$<modify> 01.11.2008 By: Andy
//	uo_band.dw_detail.Modify("DataWindow.Selected.Mouse = No")
//END IF
//
////$<add> 03.25.2008 by Andy
//dw_fields_alias.retrieve( 1 , ','+String(ii_screen_id)+',' , il_data_view)
////end of add 03.25.2008
//
//ib_AlwaysUpdate = false		//Added by Scofield on 2009-10-12
//
//RETURN 1
//
end function

public function integer of_field_property_sheet ();long		ll_SelObjCnts
String	ls_ObjName,ls_Type,ls_Field_id

str_set_properties lstr_item

ll_SelObjCnts = of_GetSelectedObjectCnts()
if ll_SelObjCnts <> 1 then Return 0

ls_ObjName = of_GetLastSelectedObject()
ls_Type = of_GetSelectedObjectType(ls_ObjName)

if ls_Type = "compute" then
//	Return of_expression_sheet()//modified by gavins 20120504
	Return of_compute_properties_sheet( ls_ObjName  )
end if

if Right(ls_ObjName, 2) = "_t" then
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

if Not IsValid(w_contract_field_properties) then
   lstr_item.lst_data_design = this
	lstr_item.lst_menu = uo_design
   lstr_item.lst_band_painter = uo_band
	lstr_item.dw_item = dw_properties
	
	pfc_cst_u_band   ldw_band

	ldw_band = wf_GetBand(is_CurBand)
	
	lstr_item.lst_band = ldw_band
	OpenWithParm(w_contract_field_properties,lstr_item)	
end if

Return 0

end function

public function integer of_dw_property_sheet ();//Modify by gavin on 2009/3/5
IF is_open_style = 'report' THEN
	//
ELSE
	 If dw_properties_dw.Modifiedcount() = 0 Then  dw_properties_dw.Event ue_Retrieve(il_data_view_id, ii_screen_id)
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
uo_band.dw_trailergroup.Modify(ls_Modify)


//Jervis 11.19.2010
if IsValid(m_pfe_cst_contract_data_design) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'Enabled', true)
end if



Return 1

end function

public function integer of_text_property_sheet (string as_object);//Modified by gavin on 2009-02-27
//Open(w_contract_text_properties)

//modified by gavins 20120503
str_set_properties lstr_item


lstr_item.lst_data_design = this
lstr_item.lst_menu = uo_design
lstr_item.lst_band_painter = uo_band
lstr_item.dw_item = dw_properties

pfc_cst_u_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

lstr_item.lst_band = ldw_band

OpenWithParm(w_contract_text_properties, lstr_item)  //2009-02-27
dw_properties_text.ShareData(w_contract_text_properties.dw_properties_text)
dw_properties_text.ShareData(w_contract_text_properties.tab_1.tabpage_general.dw_1 )
dw_properties_text.ShareData(w_contract_text_properties.tab_1.tabpage_font.dw_2 )
dw_properties_text.Event ue_Retrieve(as_Object)
w_contract_text_properties.dw_properties_text.SetColumn("text")		//Added by Scofield on 2009-10-12

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
	if Len(ls_titlebar_text) > 0 then
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
//str_set_properties lstr_item
//
//lstr_item.lst_data_design = this
//lstr_item.lst_menu = uo_design
//lstr_item.lst_band_painter = uo_band
//lstr_item.dw_item = dw_properties
//
//OpenWithParm(w_contract_oval_properties,lstr_item)
//dw_properties_oval.ShareData(w_contract_oval_properties.dw_properties_oval)
//dw_properties_oval.Event ue_Retrieve(as_Object)

//modified by gavins 20120504
str_set_properties lstr_item

lstr_item.lst_data_design = this
lstr_item.lst_menu = uo_design
lstr_item.lst_band_painter = uo_band
lstr_item.lst_code = as_Object

pfc_cst_u_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

lstr_item.lst_band = ldw_band

OpenWithParm(w_contract_other_properties,lstr_item)

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

//$<Modify> 2007-11-20 By: Andy
//$<Reason> Fix a defect.
//parent_window_design.is_OrgSyntax = ls_dw_syntax
is_OrgSyntax = ls_dw_syntax        //Modified by gavin on 2009-03-05

ldt_today = Datetime( Today(), Now() )
select count(*) into :ll_count from ctx_report_syntax where view_id=:ii_data_view;
lb_syntax = blob(ls_dw_syntax)
gnv_appeondb.of_startqueue( )

if ll_count=0 then
	insert ctx_report_syntax(view_id,dw_sql,modify_date) values(:ii_data_view,:ls_dw_syntax,:ldt_today);
else
	update ctx_report_syntax set dw_sql = :ls_dw_syntax,modify_date=:ldt_today where view_id=:ii_data_view;
end if
updateblob ctx_report_syntax set dw_syntax = :lb_syntax where view_id=:ii_data_view;
commit;
gnv_appeondb.of_commitqueue( )

ids_picdelete.Reset( )
ids_pic.update( )	//APB Bug, Don't use appeon queue--jervis -- 11.30.2009
of_upload_pic()	//Update bitmap - 11.24.2009

dw_properties.ResetUpdate( )
uo_band.dw_syntax.ResetUpdate( )
//$<add> 03.26.2008 by Andy
dw_fields_alias.ResetUpdate( )

of_ChangeScreenLable() 

RETURN 1
end function

public function integer of_select_report ();//add function by gavin on 2009-03-04
string  ls_data_view_name
string  ls_orgsyntax

select view_name into :ls_data_view_name 
  from conv_view 
 where view_id = :ii_data_view;
if not (isnull(ls_data_view_name) or trim(ls_data_view_name) = '') then
//  parent_window_design.Title = "Contract Data Screen Painter ( " + ls_data_view_name + " )"
  parent_window_design.Title = "Report Writer Painter ( " + ls_data_view_name + " )"
end if

if IsValid(idw_original) then
   ls_orgsyntax = idw_original.describe("datawindow.syntax")
end if

//modify by gavin on 2009/3/4
of_set_datagroup(True)

//modify by gavin on 2009/3/4
if IsValid(idw_original) then
	if pos(idw_original.describe("datawindow.syntax"),"group(")>0 then
		uo_band.ib_group=true
	else
		uo_band.dw_headergroup.visible = false
		uo_band.st_headergroup.visible=false
		uo_band.dw_trailergroup.visible = false
		uo_band.st_trailergroup.visible=false
	end if
end if

//Download picture -- jervis 11.24.2009
long ll_i,ll_pic_id
string ls_filename
ids_pic.Retrieve( ii_data_view,0)
for ll_i = 1 to ids_pic.rowcount( )
	ls_filename = ids_pic.GetItemString( ll_i,"pic_filename")
	ll_pic_id = ids_pic.GetItemNumber( ll_i,"pic_id")
	//download picture
	of_download_pic(ll_pic_id,ls_filename)
next

wf_makeband(ls_orgsyntax)

//modify by gavin on 2009/3/4
of_show_invisible( ib_show_invisible )
return 1
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
long 		ll_x,ll_y,ll_row,ll_k,ll_max,ll_Object_No,ll_LabelWidth, ll_width, ll_height
String 	ls_ObjName
string ls_filename,ls_path,ls_path_to
integer li_find

pfc_cst_u_band 			  	ldw_band
str_pass 							lstr_pass,lstr_Ret

if Lower(as_objType) <> Lower('text') and Lower(as_objType) <> Lower('groupbox') and &
	Lower(as_objType) <> Lower('compute') and Lower(as_objType) <> Lower('oval') and &
	Lower(as_objType) <> Lower('picture') and lower( as_objType ) <> lower( 'line' ) and lower( as_objType ) <> lower( 'rectangle' ) then
	Return wf_AddInVisibleField(as_objType,al_x,al_y)
end if
/************************************/
If Lower(as_objType) = Lower('compute')  And UPPER(is_CurBand) = 'DETAIL'  And il_dw_style = 1 Then
	Return wf_AddCompute( as_objType,al_x,al_y)
End If
/************************************/
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
	CASE 'HEADERGROUP','HEADER.1'
		ls_Band = 'header.1'
		ldw_band = uo_band.dw_Headergroup				
	CASE 'TRAILERGROUP','TRAILER.1'
		ls_Band = 'trailer.1'
		ldw_band = uo_band.dw_trailergroup		
	CASE else
		Return -1
END CHOOSE

if ls_Band = '' then Return -1

if is_Compute_Label_Name = "" then
	ll_Object_No = 0
	do
		ll_Object_No++
		ls_NewName = "object" + String(ll_Object_No) + "_" + Left(is_AddObjectType,1)
		ls_ObjName = uo_band.dw_syntax.Describe(ls_NewName + ".name")
	loop while ls_ObjName <> "!"
	
	ldw_Band.is_NewObjName = ls_NewName
	
	OpenWithParm(w_SpecifyObjectName,ldw_Band)
	
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
	case 'rectangle' 
		ls_modify = 'create  rectangle(band=' + ls_band + ' x="' + string( ll_x ) + '" y="'+ string( ll_y ) + '" height="120" width="137"  name='+ ls_NewName + ' visible="1" brush.hatch="6" brush.color="33554432" pen.style="0" pen.width="5" pen.color="1073741824"  background.mode="2" background.color="33554432" )'
	case 'line'
		ls_Modify = 'create line(band=' + ls_Band +' x1="' + string( ll_x ) + '" y1="'+ string( ll_y ) + '" x2="' + string( ll_x + 137 ) + '" y2="' + string( ll_y ) + &
						'"  name=' + ls_NewName + ' visible="1" pen.style="0" pen.width="5" pen.color="33554432"  background.mode="2" background.color="1073741824" )'
	case 'text'
		ls_Modify = 'create text(band=' + ls_Band + ' alignment="0" text="' + ls_LabelText + '" border="0" color="0" '&
						+ 'x="' + string(ll_x) + '" y="' + string(ll_y)+'" height="52" width="' + String(ll_LabelWidth) + '" '&
						+ ' name=' + ls_NewName + ' font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
	case 'groupbox'
		ls_Modify = 'create groupbox(band=' + ls_Band + ' text="none" border="5" color="128" x="' + string(ll_x) + '" y="' + string(ll_y) + '" height="390" width="660"  name=' + ls_NewName + '  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
	case 'compute'
		ls_Modify = 'create compute(band=' + ls_Band + ' alignment="0" expression="" border="5" color="0" x="' + string(ll_x) + '" y="' + string(ll_y) + '" height="52" width="520"  name=' + ls_NewName + ' font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
   Case 'oval'
		ls_Modify = 'create ellipse(band=' + String(ls_Band) + ' x="' + String(ll_x) + '" y="' + String(ll_y) + '" height="120" width="137"  name=' + String(ls_NewName) + ' visible="1" brush.hatch="6" brush.color="33554432" pen.style="0" pen.width="5" pen.color="1073741824"  background.mode="2" background.color="33554432" )'
	case 'picture'	//Add picture - jervis 11.20.2009
		gf_load_dir_path() //Jervis 12.09.2010
		if GetFileOpenName("Select File", ls_path, ls_filename, "jpg","JPEG(*.jpg;*.jpeg),*.jpg;*.jpeg,GIF(*.gif),*.gif,Bitmap(*.bmp),*.bmp") = 1 then
			gf_save_dir_path(ls_filename) //Jervis 12.09.2010
			//File size less than 200K
			if filelength(ls_path) > 1024 * 200 then 
				MessageBox('Select File',"The file you selected must be less than 200K.")
				return 1
			end if
			
			//Copy file to temp local path
			if is_open_style = 'report' then   //ReportID + Object Name
				ls_filename = "R_"+string(ii_data_view) + "_" + ls_NewName + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + mid(ls_filename,pos(ls_filename,"."))
			else	//ViewID + ScreenID + Object Name
				ls_filename = "S_"+string(il_data_view) + "_" + string(ii_screen_id) + "_" + ls_NewName + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + mid(ls_filename,pos(ls_filename,"."))
			end if
			ls_path_to = gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" + ls_filename 
			
			gnv_appeondll.of_parsepath(ls_path_to) //Jervis 12.09.2010
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
				
				//added by gavins 20120418
				p_originalsize.of_getimageoriginalsize( ls_path_to,ll_width , ll_height   )

				If ll_width = 0 Or IsNull( ll_width ) Then ll_width = 137
				If ll_height = 0 Or IsNull( ll_height )  Then ll_height = 120
				
				ids_pic.SetItem(ll_row,"pic_width",ll_width)
				ids_pic.SetItem(ll_row,"pic_height",ll_height)
				//ids_pic.SetItem(pic_tag	varchar(100)
			//end if
			of_Set_Screen_Pictrue( ls_filename, ls_NewName, ls_path_to, "" )//added by gavins 20131218
			
			ls_Modify = 'create bitmap(band=' + String(ls_Band) + ' x="' + String(ll_x) + '" y="' + String(ll_y) + '" height="' + String(ll_height) + '" width="' + String(ll_width) + '"  name=' + String(ls_NewName) + ' visible="1" filename = "' + ls_path_to + '" )'
		else
			gf_save_dir_path(ls_filename) //Jervis 12.09.2010
			return 1
		end if 
end choose

ls_err = ldw_Band.Modify(ls_Modify)
ls_err = this.Event ue_SetModify(ls_Modify)

if ls_err<>'' then 
	MessageBox('',ls_err + '~r~n~r~n'+ls_Modify)
else
	if as_objType = 'compute' then
		lstr_pass.s_long[1] = 2	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
		//lstr_pass.l_facility_id     = -1//-1:screen/else:export
		lstr_pass.s_string          = ""//expression
		lstr_pass.s_string_array[1] = ls_NewName//object name
		lstr_pass.s_u_dw            = ldw_Band//relative dw
		
		OpenWithParm(w_export_expression,lstr_pass)
		
		lstr_Ret = message.Powerobjectparm
		//canceled
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

public function pfc_cst_u_band wf_getband (string as_band);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
pfc_cst_u_band  ldw
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
	CASE 'HEADERGROUP','HEADER.1'
		return uo_band.dw_headergroup		
	CASE 'TRAILERGROUP','TRAILER.1'
		return uo_band.dw_trailergroup		
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

public function integer wf_makeband (string as_syntax);//====================================================================
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
string 	ls_filename,ls_path,ls_picname

ls_Syntax = as_syntax
uo_band.dw_Syntax.Create(ls_Syntax,ls_Err)

//Added By Ken.Guo 02/16/2012. 
If ls_Err <> '' Then
	gnv_debug.of_output( true, 'failed to create dw in (wf_makeband).' + 'error=' + ls_Err + ',syntax=' + ls_Syntax )//added by gavins 20120919
	Messagebox('Datawindow Error','Failed to dynamic create datawindow. ' + ls_err)
	Return -1
End If

//Restore path of picture object to download  path -- jervis 12.09.2010
For li = 1 to ids_pic.Rowcount( )
	ls_filename = ids_pic.GetItemString( li,"pic_filename")
	ls_picname = ids_pic.GetItemString( li,"pic_name")
	if ls_filename = '!' or ls_filename = '' or ls_filename = '?' or isnull(ls_filename) then continue
	ls_path = gs_dir_path + gs_DefDirName +"\" + is_pic_path + "\" + ls_filename
	If Not FileExists( ls_Path ) Or FileLength( ls_Path ) = 0 Then
		uo_band.dw_Syntax.Modify( ls_picname + ".filename = 'stop.bmp'") //added by gavins 20131014
	Else
		uo_band.dw_Syntax.Modify( ls_picname + ".filename = '" + ls_path + "'")
	End If
next

uo_band.dw_Syntax.settransobject(SQLCA)

//$<add> 2007-11-07 By: Andy
of_retrieve_dw_properties( uo_band.dw_Syntax )

is_OrgSyntax = uo_band.dw_syntax.Describe('Datawindow.Syntax')

//BEGIN---Modify by Scofield on 2009-09-04
if Pos(is_OrgSyntax,"group(") > 0 then
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

public function integer wf_preparecopy (pfc_cst_u_band adw_band);//====================================================================
// Function: wf_preparecopy()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    pfc_cst_u_band    adw_band
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

String   ls_Syntax,ls_ObjName,ls_RowStr,ls_Null[], ls_Type
long		ll_Cycle,ll_ObjSelCnts,ll_TotalCnts,ll_CopyCnts

is_CopySyntax = ls_Null
ll_ObjSelCnts = of_GetSelectedObjectCnts()
if ll_ObjSelCnts <= 0 then Return -1

ll_TotalCnts = UpperBound(istr_SelectObj)

ib_PreparCopying =  true

ids_properties.Reset( )

for ll_Cycle = 1 to ll_TotalCnts
	ls_ObjName = istr_SelectObj[ll_Cycle].Fname
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue
	
//	ls_Type = uo_band.dw_Syntax.Describe(ls_ObjName + ".type" )
//	If ls_Type = 'column' or ls_Type = 'compute' Then
		ls_Syntax = istr_SelectObj[ll_Cycle].Fband.Describe("datawindow.syntax")
//	Else
//		ls_Syntax = uo_band.dw_Syntax.Describe("datawindow.syntax")
//	End If
	ls_RowStr = gf_GetDWOSyntax(ls_Syntax,ls_ObjName)

	//added by gavins 20120419
	ids_properties.insertRow( 0  )
	ids_properties.setItem( ids_properties.Rowcount( ) , 'sys_fields_field_name', ls_ObjName )
	ids_properties.setItem( ids_properties.Rowcount( ) , 'fields_border', uo_band.dw_Syntax.Describe( ls_ObjName + ".border" ) )
	ids_properties.setItem( ids_properties.Rowcount( ) , 'data_view_fields_visible', uo_band.dw_Syntax.Describe( ls_ObjName + ".visible" ) )
	
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

pfc_cst_u_band  ldw_band

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

public function integer wf_copyobject (pfc_cst_u_band adw_band);//====================================================================
// Function: wf_copyobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    pfc_cst_u_band    adw_band
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
long  	ll_Y1,ll_Y2,ll_OldX,ll_OldY,ll_Diff_X,ll_Diff_Y, ll_x, ll_y
long		ll_Cycle,ll_Index,ll_Pos,ll_NextBlank,ll_MinXPos,ll_MinYPos
long	 	ll_TotalCnts,ll_Cnt,ll_Object_No,ll_RightClickXPos,ll_RightClickYPos
long 	ll_row, ll_Find, ll_dvid
string ls_filename, ls_Protect, ls_oldName, ls_border, ls_Visible, ls_originalFileName, ls_newfilename
long	ll_i, ll_pic_id

CONSTANT STRING XCOORMARK = ' x="'
CONSTANT STRING YCOORMARK = ' y="'

of_UnselectAllObject()

ll_TotalCnts = UpperBound(is_CopySyntax)
if ib_PreparCopying and ll_TotalCnts > 0 then
	for ll_Cycle = 1 to ll_TotalCnts
		ls_ObjectSyntax = is_CopySyntax[ll_Cycle]
		if IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "" then Continue
		
		ll_Pos = Pos(ls_ObjectSyntax,XCOORMARK)
		ll_OldX = long(Mid(ls_ObjectSyntax,ll_Pos + Len(XCOORMARK),Pos(ls_ObjectSyntax,'"',ll_Pos + Len(XCOORMARK)) - ll_Pos - Len(XCOORMARK)))
		
		ll_Pos = Pos(ls_ObjectSyntax,YCOORMARK)
		ll_OldY = long(Mid(ls_ObjectSyntax,ll_Pos + Len(YCOORMARK),Pos(ls_ObjectSyntax,'"',ll_Pos + Len(YCOORMARK)) - ll_Pos - Len(YCOORMARK)))
		
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

		ll_Pos = Pos(ls_ObjectSyntax,"(")
		ls_ObjType = Trim(Left(ls_ObjectSyntax,ll_Pos - 1))
		If lower(ls_ObjType) = 'bitmap' Then ls_ObjType = 'p' //added by gavins 20131014
		ls_ObjType = Mid(ls_ObjType,1,1)
	
		ll_Pos = Pos(ls_ObjectSyntax,"name=")
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
		
		ls_NewName = ""
		
		if ib_cut then
			ls_NewName = Mid(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
			if Len(uo_band.dw_syntax.Describe(ls_NewName + ".Band")) > 1 then ls_NewName = ""
		end if
		//added by gavins 20120419
		ls_OldName =  Mid(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
		
		if ls_NewName = "" then
			ll_Object_No = 0
			do
				ll_Object_No++
				ls_NewName = "object" + String(ll_Object_No) + "_" + ls_ObjType
				ls_ObjName = uo_band.dw_syntax.Describe(ls_NewName + ".name")
			loop while ls_ObjName <> "!"
		end if
		
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")),ls_NewName)
		end if

		ll_Pos = Pos(ls_ObjectSyntax,"band=")
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
		ls_Sourband = Mid(ls_ObjectSyntax,ll_Pos + Len("band="),ll_NextBlank - (ll_Pos + Len("band=")))
		
		ls_DestBand = adw_band.is_BandType
		if Lower(ls_DestBand) = Lower("HeaderGroup") then
			ls_DestBand = "header.1"
		elseif Lower(ls_DestBand) = Lower("TrailerGroup") then
			ls_DestBand = "trailer.1"
		end if
		
		if ll_Pos > 0 and ll_NextBlank > 0 and Lower(ls_Sourband) <> Lower(ls_DestBand) then
			ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len("band="),ll_NextBlank - (ll_Pos + Len("band=")),Lower(ls_DestBand))
		end if
	
		CHOOSE CASE Lower(ls_ObjType)
			CASE 'l'
				ll_Pos = Pos(ls_ObjectSyntax," y1=")
				ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos + 1)
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ll_Y1 = long(Mid(ls_ObjectSyntax,ll_Pos + Len(" y1=") + 1,ll_NextBlank - (ll_Pos + Len(" y1=") + 1) - 1))
					ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len(" y1=") + 1,ll_NextBlank - (ll_Pos + Len(" y1=") + 1) - 1,String(ll_Y1 + ll_Diff_Y))
				end if
				
				ll_Pos = Pos(ls_ObjectSyntax," y2=")
				ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos + 1)
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ll_Y1 = long(Mid(ls_ObjectSyntax,ll_Pos + Len(" y2=") + 1,ll_NextBlank - (ll_Pos + Len(" y2=") + 1) - 1))
					ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len(" y2=") + 1,ll_NextBlank - (ll_Pos + Len(" y2=") + 1) - 1,String(ll_Y1 + ll_Diff_Y))
				end if
			CASE ELSE
				ll_Pos = Pos(ls_ObjectSyntax," x=")
				ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos + 1)
				ll_OldX = long(Mid(ls_ObjectSyntax,ll_Pos + Len(" x=") + 1, ll_NextBlank - (ll_Pos + Len(" x=") + 1) - 1))
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len(" x=") + 1,ll_NextBlank - (ll_Pos + Len(" x=") + 1) - 1,String(ll_OldX + ll_Diff_X))
				end if

				ll_Pos = Pos(ls_ObjectSyntax," y=")
				ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos + 1)
				ll_OldY = long(Mid(ls_ObjectSyntax,ll_Pos + Len(" y=") + 1,ll_NextBlank - (ll_Pos + Len(" y=") + 1) - 1))
				if ll_Pos > 0 and ll_NextBlank > 0 then
					ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len(" y=") + 1,ll_NextBlank - (ll_Pos + Len(" y=") + 1) - 1,String(ll_OldY + ll_Diff_Y))
				end if
		END CHOOSE

		ls_ObjectSyntax = "create " + ls_ObjectSyntax
		adw_band.Modify(ls_ObjectSyntax)
		this.Event ue_SetModify(ls_ObjectSyntax)

		/****************************///added by gavins 20120419 
		dw_properties.SetFilter( "sys_fields_field_name = '" + ls_NewName + "' or sys_fields_field_name = '" + ls_oldname + "'" )
		dw_properties.Filter(  )
		If dw_properties.Rowcount( ) > 0 Then 
			ls_Protect = dw_properties.GetItemString( dw_properties.RowCount( ), 'fields_protect' )
			ls_Border = dw_properties.GetItemString( dw_properties.RowCount( ), 'fields_border' )
			this.Event ue_SetModify( ls_NewName + ".protect=" + ls_Protect + " " + ls_NewName + ".border=" + ls_Border )
		End If
		ll_Find = ids_properties.Find(  "sys_fields_field_name = '" + ls_NewName + "' Or sys_fields_field_name = '" + ls_OldName + "'" , 1, ids_Properties.RowCount( ) )
		If ll_Find > 0 Then
			ls_Border = ids_properties.GetItemString( ll_Find, 'fields_border' )
			ls_Visible = ids_properties.GetItemString( ll_Find, 'data_view_fields_visible' )
			
			If ls_Border <> '!' And ls_Border <> '?' And ls_Border <> '' Then 
				this.Event ue_SetModify( ls_NewName + ".border=" + ls_Border )
			End If
	
			If ls_Visible <> '!' And ls_Visible <> '?' And ls_Visible <> '' Then 
				this.Event ue_SetModify( ls_NewName + ".visible=" + ls_Visible )
			End If
		End If
		/****************************/		
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
				/****************************************************///added by gavins 20120419
				ll_find = ids_pic.Find("pic_name = '" + ls_oldname+ "'",1,ids_pic.RowCount())
				If ll_Find > 0 Then
					
//					if is_open_style = 'screen' then
//						ids_pic.SetItem(ll_Find,'view_id',il_data_view)
//						ids_pic.SetItem(ll_Find,'screen_id',ii_screen_id)
//					Else
//						ids_pic.SetItem(ll_Find,'view_id',ii_data_view)
//						ids_pic.SetItem(ll_Find,'screen_id',0)
//					End If
					ids_pic.SetItem(ll_Find,"pic_type",is_open_style)
					ids_pic.SetItem(ll_Find,"pic_band",lower(ls_DestBand))
					ids_pic.SetItem(ll_Find,"pic_name",lower(ls_NewName))
				/****************************************************/		
					//Save the pic to db -- jervis 11.23.2009
//					ll_row = ids_pic.InsertRow(0)
//					if is_open_style = 'screen' then
//						ids_pic.SetItem(ll_row,'view_id',il_data_view)
//						ids_pic.SetItem(ll_row,'screen_id',ii_screen_id)
//					else
//						ids_pic.SetItem(ll_row,'view_id',ii_data_view)
//						ids_pic.SetItem(ll_row,'screen_id',0)
//					end if
//					ids_pic.SetItem(ll_row,"pic_type",is_open_style)
//					ids_pic.SetItem(ll_row,"pic_band",lower(ls_DestBand))
//					ids_pic.SetItem(ll_row,"pic_name",lower(ls_NewName))
					ls_filename = uo_band.dw_syntax.describe(ls_NewName + ".filename" )
//					ids_pic.SetItem(ll_row,"pic_filename",mid(ls_filename,lastpos(ls_filename,"\") + 1))
					ids_pic.SetItem(ll_Find,"pic_filename",mid(ls_filename,lastpos(ls_filename,"\") + 1))
					of_Set_Screen_Pictrue( mid(ls_filename,lastpos(ls_filename,"\") + 1), ls_NewName, ls_filename , ls_oldname )//added by gavins 20131218
			
				End If
			else
				ll_row = ids_pic.Find( "pic_name ='" + lower(ls_newname) + "'", 1,ids_pic.Rowcount())
				if ll_row > 0 then ids_pic.SetItem(ll_row,"pic_band",ls_DestBand)
			end if

		else
			adw_band.is_Objects[UpperBound(adw_band.is_Objects) + 1] = ls_NewName
			/****************************************************///added by gavins 20120419
			ll_find = ids_pic.Find("pic_name = '" + ls_NewName+ "'",1,ids_pic.RowCount())
			If ll_Find <= 0 and lower( ls_ObjType ) = 'p' Then
			
			
			//Save the pic to db -- jervis 11.23.2009
			//li_find = ids_pic.Find("pic_name = '" + ls_NewName + "'",1,ids_pic.RowCount())
			//if li_find > 0 then
			//else
			
				ll_row = ids_pic.InsertRow(0)
				if is_open_style = 'screen' then
					ids_pic.SetItem(ll_row,'view_id',il_data_view)
					ids_pic.SetItem(ll_row,'screen_id',ii_screen_id)
					ll_dvid =  il_data_view
				else
					ids_pic.SetItem(ll_row,'view_id',ii_data_view)
					ids_pic.SetItem(ll_row,'screen_id',0)
					ll_dvid =  ii_data_view
				end if
				ids_pic.SetItem(ll_row,"pic_type",is_open_style)
				ids_pic.SetItem(ll_row,"pic_band",lower(ls_DestBand))
				ids_pic.SetItem(ll_row,"pic_name",lower(ls_NewName))
				
				ls_filename = uo_band.dw_syntax.describe(ls_NewName + ".filename" )
				ls_filename = mid(ls_filename,lastpos(ls_filename,"\") + 1)
				ls_newfilename =   mid( ls_filename,1,2 ) + string( ll_dvid )  + '_' + string(ii_screen_id)  +'_' + &
		       ls_NewName    + '_'  + string( rand( 10000))+ string( second( now( )) )+ right(ls_filename,4 )

				ids_pic.SetItem(ll_row,"pic_filename",ls_newfilename )
			
//				ids_pic.SetItem(ll_row,"pic_filename",ls_filename)
				ids_pic.SetItem(ll_row,"pic_x",long( uo_band.dw_syntax.describe(ls_NewName + ".x" )))
				ids_pic.SetItem(ll_row,"pic_y",long( uo_band.dw_syntax.describe(ls_NewName + ".y" )))
				ids_pic.SetItem(ll_row,"pic_width",137)
				ids_pic.SetItem(ll_row,"pic_height",120)
				
				ls_originalFileName = uo_band.dw_syntax.describe(ls_OldName + ".filename" )//added by gavins 20131019
				
				If FileExists( ls_originalFileName ) Then
					FileCopy( ls_originalFileName, gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" +ls_newfilename )
					adw_band.Modify( ls_NewName + ".filename='" + gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" +ls_newfilename + "'" )
					this.Event ue_SetModify( ls_NewName + ".filename='" + gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" +ls_newfilename + "'" )
				Else
					for ll_i = 1 to ids_pic.rowcount( )//added by gavins 20131218
						ls_filename = ids_pic.GetItemString( ll_i,"pic_filename")
						ll_pic_id = ids_pic.GetItemNumber( ll_i,"pic_id")
						If ls_filename = mid(ls_originalFileName,lastpos(ls_originalFileName,"\") + 1)  then 	of_download_pic(ll_pic_id,ls_filename)
					next
					FileCopy( ls_originalFileName, gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" +ls_newfilename )
					gnv_debug.of_output( true, 'Copy file:' + ls_originalFilename + " to " + ls_filename + ", original file is not found." )
				End If
				
			//end if
			
			ll_x = long( uo_band.dw_syntax.describe(ls_NewName + ".x" ))
			ll_y = long( uo_band.dw_syntax.describe(ls_NewName + ".y" ))
			of_Set_Screen_Pictrue( ls_newfilename, ls_NewName, ls_originalFileName, ls_OldName )//added by gavins 20131218
//			insert into conv_view_pic ( view_id
//				,Screen_id
//				,pic_type
//				,pic_band
//				,pic_name
//				,pic_filename
//				,pic_bitmap
//				,pic_x
//				,pic_y
//				,pic_width
//				,pic_height
//				,pic_tag )
//				 select :ll_dvid,
//					 :ii_screen_id, 
//					 pic_type,
//					 pic_band, 
//					 :ls_NewName, 
//					:ls_newfilename
//					  ,pic_bitmap
//					  ,:ll_x
//					  ,:ll_y
//					  ,pic_width
//					  ,pic_height
//					  ,pic_tag  
//					  from conv_view_pic where view_id = :ll_dvid and screen_id = :ii_screen_id and pic_type = :is_open_style and pic_name =:ls_OldName;
			else
				ids_pic.SetItem(ll_Find,"pic_type",is_open_style)
				ids_pic.SetItem(ll_Find,"pic_band",lower(ls_DestBand))
				ids_pic.SetItem(ll_Find,"pic_name",lower(ls_NewName))
				ls_filename = uo_band.dw_syntax.describe(ls_NewName + ".filename" )
				ids_pic.SetItem(ll_Find,"pic_filename",mid(ls_filename,lastpos(ls_filename,"\") + 1))
				of_Set_Screen_Pictrue( mid(ls_filename,lastpos(ls_filename,"\") + 1), ls_NewName, ls_filename ,"")//added by gavins 20131218
			End If
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
		 if pos(ls_sql,'header') > 0  then
			 ib_header = true
		elseif pos(ls_sql,'detail') > 0 then
			 ib_detail = true
		elseif pos(ls_sql,'summary') > 0 then
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
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
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
if Right(ls_ObjList,Len(LISTSEPARATECHAR)) = LISTSEPARATECHAR then
	ls_ObjList = Left(ls_ObjList,Len(ls_ObjList) - Len(LISTSEPARATECHAR))
end if

ll_Pos = LastPos(ls_ObjList,LISTSEPARATECHAR)
ll_Index = long(Mid(ls_ObjList,ll_Pos + Len(LISTSEPARATECHAR)))
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
ll_Pos = Pos(is_LastSelObjList,ls_Mark)
if ll_Pos > 0 then
	is_LastSelObjList = Left(is_LastSelObjList,ll_Pos - 1) + LISTSEPARATECHAR + Mid(is_LastSelObjList,ll_Pos + Len(ls_Mark))
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

pfc_cst_u_band  ldw_band

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
// Author:	Scofield		Date: 2009-04-27
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
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
long		ll_X,ll_Y,ll_Width,ll_Height,ll_Pos,ll_SelObjCnts
Boolean	lb_Selected

ll_SelObjCnts = of_GetSelectedObjectCnts()

if ll_SelObjCnts <= 0 then
	uo_design.p_Bold.of_SetNormalStatus()
	uo_design.p_Italic.of_SetNormalStatus()
	uo_design.p_Underline.of_SetNormalStatus()
	uo_design.p_Left.of_SetNormalStatus()
	uo_design.p_Right.of_SetNormalStatus()
	uo_design.p_Center.of_SetNormalStatus()
	
	uo_design.st_Object_Name.Text = "Nothing Selected"
	uo_design.st_xy.Visible = false
else
	if ll_SelObjCnts >= 1 then
		ls_ObjName = of_GetLastSelectedObject()
		of_GetSelectedObjectAttr(ls_ObjName,as_Bold,as_Italic,as_Underline,as_Align)
		
		if as_Bold <> "400" and as_Bold <> "!" and as_Bold <> "?" then
			uo_design.p_Bold.of_SetDownStatus()
		else
			uo_design.p_Bold.of_SetNormalStatus()
		end if
		
		if as_Italic <> "0" and as_Italic <> "!" and as_Italic <> "?" then
			uo_design.p_Italic.of_SetDownStatus()
		else
			uo_design.p_Italic.of_SetNormalStatus()
		end if
		
		if as_Underline <> "0" and as_Underline <> "!" and as_Underline <> "?" then
			uo_design.p_UnderLine.of_SetDownStatus()
		else
			uo_design.p_UnderLine.of_SetNormalStatus()
		end if
		
		if as_Align = "0" then
			uo_design.p_Left.of_SetDownStatus()
			uo_design.p_Right.of_SetNormalStatus()
			uo_design.p_Center.of_SetNormalStatus()
		elseif as_Align = "1" then
			uo_design.p_Left.of_SetNormalStatus()
			uo_design.p_Right.of_SetDownStatus()
			uo_design.p_Center.of_SetNormalStatus()
		else
			uo_design.p_Left.of_SetNormalStatus()
			uo_design.p_Right.of_SetNormalStatus()
			uo_design.p_Center.of_SetDownStatus()
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
// Author:	Scofield		Date: August-04 2009 Tuesday
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
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
// Author:	Scofield		Date: August-05 2009 Wednesday
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
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
string ls_dwSyntax
datastore lds_temp

CONSTANT LONG   ONCECNTS = 7  //jervis 07.12.2011  modified by gavins 20120524  previous value is 6
CONSTANT STRING BORDERFLAG = ' border="'
CONSTANT STRING TEXTFLAG = ' text="'

is_FieldSyntax = ls_Null
is_Fields = ls_Null
il_CurVisibleNo = 1

if IsNull(as_Field_List) or Trim(as_Field_List) = "" then Return -1

ls_Syntax = uo_band.dw_Syntax.Describe("Datawindow.Syntax")
ls_Syntax = Mid(ls_Syntax,LastPos(Left(ls_Syntax,Pos(ls_Syntax,"band=")),ENTERCHAR) + Len(ENTERCHAR))

//if any of the shared fields are used and visible in another dw then warn user when they try and select so they at least know - jervis 07.14.2011
if ii_screen_id = 3  then
	ls_dwSyntax = this.of_getscreensyntax( 9)
elseif ii_screen_id = 9  then
	ls_dwSyntax = this.of_getscreensyntax( 3)
end if
lds_temp = create datastore
lds_temp.Create(ls_dwSyntax)

ll_FieldSepPos = Pos(as_Field_List,ENTERCHAR)
do while ll_FieldSepPos > 0
	ls_ColName = Left(as_Field_List,ll_FieldSepPos - 1)
	as_Field_List = Mid(as_Field_List,ll_FieldSepPos + Len(ENTERCHAR))
	ll_FieldSepPos = Pos(as_Field_List,ENTERCHAR)
	if IsNull(ls_ColName) or Trim(ls_ColName) = "" then Continue
	if lds_temp.Describe( ls_ColName + ".name") = ls_ColName then
		if lds_temp.Describe( ls_ColName + ".visible") = '1' then
			if MessageBox('Information',"The field " + ls_colName + " is already being used in the another screen for this view. If you use in this screen data could be overwritten or cause confusion. Continue?",Question!,YesNo!,2) = 2 then 
				continue
			end if
		end if

	end if
		
	ls_Text = ls_ColName		//As the default label name
	
	for ll_Cycle = 1 to ONCECNTS
		if ll_Cycle = 1 then
			ls_ObjName = ls_ColName
		elseif ll_Cycle = 2 then
			ls_ObjName = ls_ColName + "_t"
		elseif ll_Cycle = 3 then
			ls_ObjName = "b_" + ls_ColName
		elseif ll_Cycle = 4 then  //add contract status track - jervis 04.19.2011
			ls_ObjName = "b_" + ls_ColName + "track"
		elseif ll_Cycle = 5 then //add date alarm button for multi record - jervis 07.12.2011
			ls_ObjName = "b_" + ls_ColName + '_r'
		elseif ll_Cycle = 6 then //add date alarm button for multi record - jervis 07.12.2011
			ls_ObjName = "b_" + ls_ColName + '_g'	
		elseif ll_Cycle = 7 And ls_colname = 'master_contract_name' then
			ls_ObjName ="b_contract_search"
		end if
		
		ll_Pos = Pos(ls_Syntax,"name=" + Lower(ls_ObjName) + " ")
		if ll_Pos > 0 then
			ll_RowStart = LastPos(Left(ls_Syntax,ll_Pos),ENTERCHAR) + Len(ENTERCHAR)
			if ll_RowStart = Len(ENTERCHAR) then ll_RowStart = 1
			
			ll_RowEnd = ll_RowStart
			
			ll_SecleftBraPos = Pos(ls_Syntax,"(",Pos(ls_Syntax,"(",ll_RowStart) + 1)
			ll_FirRighBraPos = Pos(ls_Syntax,")",ll_RowStart)
			
			if ll_SecleftBraPos > ll_FirRighBraPos then		//Adjust the performance
				ll_RowEnd = ll_FirRighBraPos + 1
			else
				ll_LeftBracketCnts = 0
				ll_RightBracketCnts = 0
				do while ll_LeftBracketCnts = 0 or ll_LeftBracketCnts <> ll_RightBracketCnts
					ls_CurLetter = Mid(ls_Syntax,ll_RowEnd,1)
					if ls_CurLetter = "(" then ll_LeftBracketCnts++
					if ls_CurLetter = ")" then ll_RightBracketCnts++
					ll_RowEnd++
				loop
			end if
	
			ls_RowStr = Mid(ls_Syntax,ll_RowStart,ll_RowEnd - ll_RowStart)
			
			ll_BorPos = Pos(ls_RowStr,BORDERFLAG)
			ll_QuoPos = Pos(ls_RowStr,'" ',ll_BorPos + Len(BORDERFLAG))
			if ll_BorPos > 0 and ll_QuoPos > 0 then
				if ll_Cycle = 1 then
					ls_Border = "5"
				else
					ls_Border = "0"
				end if
				ls_RowStr = Left(ls_RowStr,ll_BorPos + Len(BORDERFLAG) - 1) + ls_Border + Mid(ls_RowStr,ll_QuoPos)
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
			is_Fields[ll_FieldCnts] =  Lower(ls_ObjName)  //added by gavins 20120307 grid
		//elseif ll_Cycle = 2 then	
		elseif ll_Cycle = 2 and uo_band.dw_Syntax.Describe(ls_ColName + ".type") <> "compute" then  //Add compute - jervis 09.20.2010
			ls_LabelName = ls_ObjName
			ls_FieldName = Left(ls_LabelName,Len(ls_LabelName) - 2)
			ls_Band = uo_band.dw_Syntax.Describe(ls_FieldName + ".Band")
			ll_FieldWidth = long(uo_band.dw_Syntax.Describe(ls_FieldName + ".Width"))
			
			ls_RowStr = 'text(band=' + ls_Band + ' alignment="0" visible="1" text="' + ls_Text + '" border="0" color="0" '&
							+ 'x="1000" y="1000" height="52" width="' + String(ll_FieldWidth) + '" ' + ' name=' + ls_LabelName &
							+ ' font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" ' &
							+ 'font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
			
			uo_band.dw_Syntax.Modify("create " + ls_RowStr)
			
			ll_FieldCnts++
			is_FieldSyntax[ll_FieldCnts] = ls_RowStr
			is_Fields[ll_FieldCnts] = ls_LabelName //added by gavins 20120307 grid
		end if
	next
loop

destroy lds_temp
if il_CurVisibleNo <= ll_FieldCnts then
	ib_PreparVisible = true
	ls_ObjectSyntax = is_FieldSyntax[il_CurVisibleNo]
	if Not (IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "") then
		ll_Pos = Pos(ls_ObjectSyntax,"name=")
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
		ls_ObjName = Mid(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
		
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
// Author:	Scofield		Date: 2009-08-19
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
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
		
		If as_Property_Name = 'fields_font_face' Then  //added by gavins 20121214
			as_Property_Name = 'font_face'
		ElseIf as_Property_Name = 'fields_font_height' Then
			as_Property_Name = 'font_height'
		End If
		choose case as_Property_Name
			case "fields_label_textcolor","fields_label_textbkcolor","fields_textcolor","fields_textbkcolor","data_view_fields_label_justification","data_view_fields_justification", "label_font_height", "font_height"
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
		elseif as_Property_Name = "label_font_face" then
			ls_Property_Name = "font_face"
		elseif as_Property_Name = "label_font_height" then
			ls_Property_Name = "font_height"	
		else
			CONTINUE
		end if
		
		ls_ColName = Left(ls_ObjName,Len(ls_ObjName) - 2)
		
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
			case "text_color","background_color", "font_height"
				dw_properties_text.SetItem(1,ls_Property_Name,long(as_Property_Value))
			case else
				dw_properties_text.SetItem(1,ls_Property_Name,as_Property_Value)
		end choose
		
		dw_properties_text.AcceptText()
	
		istr_SelectObj[ll_Cycle1].FBand.of_ModifyTextProperties(ls_Property_Name)
	end if
next

end subroutine

public function integer of_select_view (long al_view_id, string as_view_name, long al_screen_id);Long ll_Handle,ll_screen_id
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
// Author:	Scofield		Date: 2009-09-15
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Temp,ls_ObjName,ls_ProName,ls_ProValue,ls_Modify,ls_ObjAndPro,ls_Syntax,ls_dwObjSyntax
long		ll_EqualPos,ll_DotPos,ll_SpaPos,ll_TabPos,ll_StartPos,ll_NamePos,ll_Pos

CONSTANT STRING CREATEFLAG  = "create "
CONSTANT STRING DESTROYFLAG = "destroy "
CONSTANT STRING NAMEFLAG    = " name="

if Lower(Left(as_Modify,Len(CREATEFLAG))) = Lower(CREATEFLAG) then
	ll_NamePos = Pos(as_Modify,NAMEFLAG)
	if ll_NamePos > 0 then
		ll_SpaPos = Pos(as_Modify," ",ll_NamePos + Len(NAMEFLAG))
		if ll_SpaPos > 0 then
			ls_ObjName = Mid(as_Modify,ll_NamePos + Len(NAMEFLAG),ll_SpaPos - ll_NamePos - Len(NAMEFLAG))
			ls_Modify = DESTROYFLAG + ls_ObjName
		end if
	end if
elseif Lower(Left(as_Modify,Len(DESTROYFLAG))) = Lower(DESTROYFLAG) then
	ls_Syntax = uo_band.dw_Syntax.Describe("DataWindow.Syntax")
	ll_Pos = Pos(as_Modify,DESTROYFLAG)
	do while ll_Pos > 0
		as_Modify = Trim(Mid(as_Modify,ll_Pos + Len(DESTROYFLAG)))
		ll_SpaPos = Pos(as_Modify," ")
		if ll_SpaPos > 0 then
			ls_ObjName = Left(as_Modify,ll_SpaPos - 1)
			as_Modify = Trim(Mid(as_Modify,ll_SpaPos + 1))
			ll_Pos = Pos(as_Modify,DESTROYFLAG)
		else
			ls_ObjName = as_Modify
			ll_Pos = 0
		end if
		
//		ls_dwObjSyntax = of_GetDWObjSyntax(ls_Syntax,ls_ObjName )//modified by gavins 20120919
		ls_dwObjSyntax = gf_getdwosyntax( ls_Syntax, ls_ObjName )

		ls_Modify += CREATEFLAG + ls_dwObjSyntax + " "
	loop
else
	ll_EqualPos = Pos(as_Modify,"=")
	do while ll_EqualPos > 0
		ls_Temp = Trim(Left(as_Modify,ll_EqualPos - 1))
		
		ll_SpaPos = LastPos(ls_Temp," ")
		ll_TabPos = LastPos(ls_Temp,"~t")
		
		if ll_SpaPos > ll_TabPos then
			ll_StartPos = ll_SpaPos
		else
			ll_StartPos = ll_TabPos
		end if
		
		ls_ObjAndPro = Mid(ls_Temp,ll_StartPos + 1,ll_EqualPos - ll_StartPos - 1)
		
		ls_ProValue = uo_band.dw_Syntax.Describe(ls_ObjAndPro)
		ls_Modify += ls_ObjAndPro + ' = "' + ls_ProValue + '" '
		
		as_Modify = Mid(as_Modify,ll_EqualPos + 1)
		ll_EqualPos = Pos(as_Modify,"=")
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
// Author:	Scofield		Date: 2009-09-15
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
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
	uo_band.dw_trailergroup.Modify(is_UnDoList[il_CurUnDoNo])
	
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
// Author:	Scofield		Date: 2009-09-17
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
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
// Author:	Scofield		Date: 2009-09-17
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Syntax,ls_CurLetter,ls_RowStr
long		ll_Pos,ll_RowStart,ll_RowEnd
long		ll_SecleftBraPos,ll_FirRighBraPos
long		ll_LeftBracketCnts,ll_RightBracketCnts

ls_Syntax = Mid(as_dwSyntax,LastPos(Left(as_dwSyntax,Pos(as_dwSyntax,"band=")),ENTERCHAR) + Len(ENTERCHAR))

ll_Pos = Pos(ls_Syntax,"name=" + Lower(as_ObjName) + " ")
if ll_Pos > 0 then
	ll_RowStart = LastPos(Left(ls_Syntax,ll_Pos),ENTERCHAR) + Len(ENTERCHAR)
	ll_RowEnd = ll_RowStart
	
	ll_SecleftBraPos = Pos(ls_Syntax,"(",Pos(ls_Syntax,"(",ll_RowStart) + 1)
	ll_FirRighBraPos = Pos(ls_Syntax,")",ll_RowStart)
	
	if ll_SecleftBraPos > ll_FirRighBraPos then		//Adjust the performance
		ll_RowEnd = ll_FirRighBraPos + 1
	else
		ll_LeftBracketCnts = 0
		ll_RightBracketCnts = 0
		do while ll_LeftBracketCnts = 0 or ll_LeftBracketCnts <> ll_RightBracketCnts
			ls_CurLetter = Mid(ls_Syntax,ll_RowEnd,1)
			if ls_CurLetter = "(" then ll_LeftBracketCnts++
			if ls_CurLetter = ")" then ll_RightBracketCnts++
			ll_RowEnd++
		loop
	end if

	ls_RowStr = Mid(ls_Syntax,ll_RowStart,ll_RowEnd - ll_RowStart)
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
			li_pos = pos(ls_table,".")
			ls_dbname = Mid(ls_table,li_pos + 1)
			ls_table = mid(ls_table,1,li_pos - 1)
			if ls_display_name = '!' or ls_display_name = '?' then ls_display_name = ls_name
			
			if len(ls_name) > 1 and len(ls_lookup_name) > 1 then
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
// Author:	Scofield		Date: 2009-09-29
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Return of_getscreensyntax( al_screen_id, false ) //modified by gavins 20120306 grid

//long		ll_FindRow,ll_Updated,ll_SQLLen
//String	ls_SQL
//
//ids_Screen.SetFilter("")
//ids_Screen.Filter()
//ll_FindRow = ids_Screen.Find("screen_id=" + String(al_screen_id), 1, ids_Screen.RowCount())
//if ll_FindRow <= 0 then Return ""
//
//ls_SQL = ids_Screen.GetitemString(ll_FindRow, "dw_sql")
//ll_Updated = ids_Screen.GetitemNumber(ll_FindRow,'updated')
//IF appeongetclienttype() = 'PB' and ll_Updated = 0 THEN
//	ll_SQLLen = ids_Screen.GetItemNumber(ll_FindRow, "dw_sql_len")
//	IF ll_SQLLen > 32765 THEN
//		ls_SQL = f_get_screen_sql(il_data_view_id,al_screen_id,false)  //add false argu - jervis 10.11.2011
//	END IF
//END IF
//
//Return ls_SQL

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
// Author:	Scofield		Date: 2009-09-29
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FindRow, ll_dataviewid
DateTime	ldt_Now
dataStore	lds_Test
string			ls_Err
//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
string ls_dw_syntax,ls_dw_opsyntax,ls_lookuplist,ls_null //Added By Jay Chen 03-10-2014

//Added By Jay Chen 03-10-2014
setnull(ls_null)
ls_dw_syntax = as_syntax
//end add
//---------End Added ------------------------------------------------------

ids_Screen.SetFilter("")
ids_Screen.Filter()
ll_FindRow = ids_Screen.Find("screen_id=" + String(al_screen_id), 1, ids_Screen.RowCount())
if ll_FindRow > 0 then
	ll_dataviewid = ids_Screen.GetItemNumber( ll_FindRow, 'data_view_id' )
	
	lds_Test = create DataStore
	lds_Test.Create( as_syntax, ls_Err )
	If Len( ls_Err ) > 0 Then
		gnv_debug.of_output( true, 'Failed to auto update!' + 'error=' + ls_Err + ',syntax=' + as_syntax )//added by gavins 20120919
		MessageBox( 'Tips', 'Failed to auto update property!' )
		Return -1		
	End If	
	
	//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
	//Added By Jay Chen 03-10-2014
	if of_get_opsyntax(ls_dw_syntax,ls_null,ls_dw_opsyntax,ls_lookuplist) < 0 then ls_dw_opsyntax = ls_dw_syntax
	lds_Test.Create( ls_dw_opsyntax , ls_Err )
	If Len( ls_Err ) > 0 Then
		gnv_debug.of_output( true, 'Failed to auto update!' + 'error=' + ls_Err + ',syntax=' + ls_dw_opsyntax )
		MessageBox( 'Tips', 'Failed to auto update property!' )
		Return -1		
	End If
	//---------End Added ------------------------------------------------------

	If ids_Screen.GetItemString( ll_FindRow, 'screen_style' ) = 'G' Then //added by gavins 20120309 grid
		ids_Screen.SetItem(ll_FindRow,"grid_sql",as_Syntax)
		//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		//Update ctx_screen  set  grid_sql = :as_Syntax where data_view_id = :ll_dataviewid and screen_id = :al_screen_id;  //added by gavins 20120919
		//Modified By Jay Chen 03-10-2014 Remark: add update opsql
		Update ctx_screen  set  grid_sql = :as_Syntax, grid_opsql = :ls_dw_opsyntax where data_view_id = :ll_dataviewid and screen_id = :al_screen_id;  //added by gavins 20120919
		//---------End Modfiied ------------------------------------------------------
	Else
		ids_Screen.SetItem(ll_FindRow,"dw_sql",as_Syntax)
		//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		//Update ctx_screen  set  dw_sql = :as_Syntax where data_view_id = :ll_dataviewid and screen_id = :al_screen_id;  //added by gavins 20120919
		Update ctx_screen  set  dw_sql = :as_Syntax, dw_opsql = :ls_dw_opsyntax where data_view_id = :ll_dataviewid and screen_id = :al_screen_id;  //added by gavins 20120919
		//---------End Modfiied ------------------------------------------------------
	End If
	
	If sqlca.sqlcode <> 0 Then
		MessageBox( 'Tips', 'Failed to save for auto updating!' )
		Return -1
	End If
	ldt_Now = Datetime(Today(),Now())
	
	ids_Screen.SetItem(ll_FindRow,"modify_date",ldt_Now )
	
	Update ctx_screen  set modify_date = :ldt_Now where data_view_id = :ll_dataviewid and screen_id = :al_screen_id;  //added by gavins 20120919
//	If ids_Screen.Update() <> 1 Then  //modified by gavins 20120919
//		MessageBox( 'Tips', 'Failed to save for auto updating!' )
//		Return -1
//	End If
	Return 1
else
	Return -1
end if

end function

public subroutine of_autoupdatesearchscreen (string as_objname);of_autoupdatesearchscreen( as_objname, '' )//modified by gavins 20120329
end subroutine

public subroutine of_download_pic (long al_pic_id, string as_filename);string ls_path
blob	lb_file,lb_temp
long 	ll_datalen,ll_start
long	ll_ReadCnts,ll_ReadCycle

if as_filename = '!' or trim(as_filename) = '' or isnull( as_filename ) then return 	//jervis 12.09.2010 //modified by gavins 20120525
//Parse path
ls_path = gs_dir_path + gs_DefDirName +"\" + is_pic_path + "\"
gnv_appeondll.of_parsepath(ls_path)

ls_path = ls_path + as_filename
if not fileexists(ls_path) then
	select datalength(pic_bitmap) into :ll_datalen from conv_view_pic where pic_id = :al_pic_id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_datalen > 8000 then
		ll_ReadCnts = Ceiling(ll_datalen/8000)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_Start = (ll_ReadCycle - 1) * 8000 + 1
			SELECTBLOB SubString(pic_bitmap,:ll_Start,8000) INTO :lb_Temp	from conv_view_pic where pic_id = :al_pic_id;
			lb_file += lb_Temp
		next
	else
		selectblob pic_bitmap into :lb_file from conv_view_pic where pic_id = :al_pic_id;
	end if
	If len( lb_File ) = 0 Then Return
	AppeonWriteFile(ls_path, lb_file,len(lb_file))
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
	ls_name = 	ids_pic.GetItemString( ll_i,"pic_name")		//added by gavins 20131218												
	
	for ll_x = 1 To Upperbound( invo_Pictrue )
		If lower(invo_Pictrue[ll_x].is_objectname ) = lower(ls_name) Then
			lb_file = invo_Pictrue[ll_x].ibl_image
		End If
	Next
	
	if FileExists(ls_path) and  ids_pic.GetItemString( ll_i,"pic_filename") <> '!' then  //jervis 12.09.2010
		if len( lb_file ) <= 2 or isnull( lb_file ) then inv_filesrv.of_fileread( ls_filename, ref lb_file)
		if len( lb_file )  > 2 then//modified by gavins 20131218
			Updateblob conv_view_pic set pic_bitmap = :lb_file where pic_id = :ll_pic_id;
		End if
	end if
	setnull( lb_file )
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

public function integer of_picture_property_sheet (string as_object);//modified by gavins 20120502

Return of_Picture_properties_sheet ( as_object, "", "" )





////Add by jervis -- 11.30.2009
//string ls_path,ls_filename
//string ls_path_to
//string ls_find
//long ll_row, ll_width, ll_height
//pfc_cst_u_band ldw_band
//string ls_Modify
//gf_load_dir_path() //Jervis 12.09.2010
//if GetFileOpenName("Select File", ls_path, ls_filename, "jpg","JPEG(*.jpg;*.jpeg),*.jpg;*.jpeg,Bitmap(*.bmp),*.bmp,GIF(*.gif),*.gif") = 1 then	//Add jpeg - jervis 12.09.2010
//	gf_save_dir_path(ls_filename) //Jervis 12.09.2010
//	//File size less than 100K
//	if filelength(ls_path) > 1024 * 200 then 
//		MessageBox('Select File',"The file you selected must be less than 200K.")
//		return 0
//	end if
//	
//	//Copy file to temp local path
//	if is_open_style = 'report' then   //ReportID + Object Name
//		ls_filename = "R_"+string(ii_data_view) + "_" + lower(as_object) + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + mid(ls_filename,pos(ls_filename,"."))
//		ls_Find = "pic_name = '" + lower(as_object) + "' and view_id = " + string(ii_data_view) + " and screen_id = 0"
//	else	//ViewID + ScreenID + Object Name
//		ls_filename = "S_"+string(il_data_view) + "_" + string(ii_screen_id) + "_" + lower(as_object) + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + mid(ls_filename,pos(ls_filename,"."))
//		ls_Find = "pic_name = '" + lower(as_object) + "' and view_id = " + string(il_data_view) + " and screen_id = " + string(ii_screen_id)
//	end if
//	ls_path_to = gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" + ls_filename 
//	
//	gnv_appeondll.of_parsepath(ls_path_to) //Jervis 12.09.2010
//
//	if FileCopy(ls_path,ls_path_to) <> 1 then return -1
//	ll_row = ids_pic.Find(ls_find,1,ids_pic.Rowcount())
//	if ll_row > 0 then
//		ids_pic.SetItem(ll_row,"pic_filename",ls_filename)
//		ls_Modify = as_object + ".filename ='" + ls_path_to + "'"
//		ldw_band = wf_getband(is_curband)
//		
//		//added by gavins 20120418
//		p_originalsize.of_getimageoriginalsize( ls_path_to,ll_width , ll_height   )
//		ls_Modify +=  " " + as_object + ".width = " + string( ll_width ) + " " + as_object + ".height = " + string( ll_height ) 
//		//Modify filename 
//		ldw_band.Modify(ls_Modify)
//		this.event ue_SetModify(ls_Modify)
//		ldw_Band.of_AddorDelSingleSelect(as_object,false)
//		ldw_Band.of_AddorDelSingleSelect(as_object,true)
//	else
//		return -1
//	end if
//else
//	gf_save_dir_path(ls_filename) //Jervis 12.09.2010
//end if
//Return 1
//
end function

public function integer of_set_dw_properties (string as_object_name, integer ai_flag);//BEGIN---Modify by Evan 07/24/2008
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-13 By: Andy

pfc_cst_u_band ldw_band

ldw_band = parent_window_design.wf_getband( parent_window_design.is_curband )
ldw_band.of_set_dw_properties( as_object_name )

return 1
//---------------------------- APPEON END ----------------------------
*/
pfc_cst_u_band ldw_band

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

public subroutine of_autoupdatedetailscreen (string as_objname);//====================================================================
// Function: of_autoupdatedetailscreen()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-29
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_DetailSyntax,ls_Edit_Style,ls_Visible
String	ls_Proper,ls_ProExp
String	ls_ObjType,ls_FieldName,ls_LabelName, ls_Err
long		ll_RtnVal

if (ii_screen_id <> 5 and ii_screen_id <> 9) then Return
if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return

ls_ObjType = uo_band.dw_Syntax.Describe(as_ObjName + ".Type")
if ls_ObjType = "column" then
	ls_FieldName = as_ObjName
	ls_LabelName = ls_FieldName + "_t"
elseif ls_ObjType = "text" then
	ls_FieldName = Left(as_ObjName,Len(as_ObjName) - 2)
	ls_LabelName = as_ObjName
else
	Return
end if

SetPointer(HourGlass!)

ls_DetailSyntax = of_GetScreenSyntax(3)
if IsNull(ls_DetailSyntax) or Trim(ls_DetailSyntax) = "" then Return


ids_detail.Create(ls_DetailSyntax, ls_Err )
If Len( ls_Err ) > 0 Then
	Messagebox("Auto Update DataWindow", "The Syntax is error !" + ls_Err )
	Return
End If

if ls_ObjType = "column" then
	ls_Visible = ids_detail.Describe(ls_FieldName + ".Visible")
else
	ls_Visible = ids_detail.Describe(ls_LabelName + ".Visible")
end if

if (ls_Visible = "?" or ls_Visible = "!") then Return



	

ls_Proper = ls_LabelName + ".Text"
ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")

if ls_ObjType = "column" then
	/*******************************************************///modified by gavins 2010518
	ls_Edit_Style = uo_band.dw_Syntax.Describe(ls_FieldName + ".Edit.Style")
	if ls_Edit_Style = "edit" then
		ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".format"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
	elseif ls_Edit_Style = "editmask" then
		ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".Mask"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
	elseif ls_Edit_Style = "dddw" then
	
	
		ls_Proper = ls_FieldName + ".dddw.VscrollBar"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = '' Then ls_ProExp = "no"
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.AutoHScroll"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "no"
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
	
		//ls_Proper = ls_FieldName + ".dddw.UseAsBorder"
		//ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		//ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		
		ls_Proper = ls_FieldName + ".dddw.NilIsNull"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "no"
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.Name"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "none"
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.DataColumn"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''   Then ls_ProExp = "none"
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.DisplayColumn"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "none"
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".dddw.PercentWidth"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "0"
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
		ls_Proper = ls_FieldName + ".tag"
		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		If ls_ProExp = '?' or ls_ProExp  = '!' Then ls_ProExp = ""
		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
		
	//	ls_Edit_Style = uo_band.dw_Syntax.Describe(ls_FieldName + ".Edit.Style")
	//	if ls_Edit_Style = "edit" then
	//		ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".format"
	//		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
	//		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
	//	elseif ls_Edit_Style = "editmask" then
	//		ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".Mask"
	//		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
	//		ids_detail.Modify(ls_Proper + "='" + ls_ProExp + "'")
	//	end if
	end if
end if

of_SetScreenSyntax(3,ids_detail.Object.DataWindow.Syntax)


ib_HasNewModify = false

SetPointer(Arrow!)

end subroutine

public function integer wf_addinvisiblefield_bak (string as_objtype, long al_x, long al_y);//====================================================================
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
// Author:	Scofield		Date: August-04 2009 Tuesday
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String  	ls_ObjectSyntax,ls_ObjName,ls_Sourband,ls_DestBand,ls_Type,ls_Column_ID
long		ll_X,ll_Y,ll_TotalCnts,ll_Index,ll_Cnt,ll_Pos,ll_NextBlank
long ll_find

CONSTANT STRING XCOORMARK = ' x="'
CONSTANT STRING YCOORMARK = ' y="'

pfc_cst_u_band   	ldw_band

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
	CASE 'HEADERGROUP','HEADER.1'
		ls_DestBand = 'header.1'
		ldw_band = uo_Band.dw_HeaderGroup
	CASE 'TRAILERGROUP','TRAILER.1'
		ls_DestBand = 'trailer.1'
		ldw_band = uo_Band.dw_TrailerGroup
	CASE else
		Return -1
END CHOOSE

if ls_DestBand = '' then Return -1

ll_TotalCnts = UpperBound(is_FieldSyntax)
if ib_PreparVisible and ll_TotalCnts > 0 and il_CurVisibleNo <= ll_TotalCnts then
	ls_ObjectSyntax = is_FieldSyntax[il_CurVisibleNo]
	if Not (IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "") then
		ll_Pos = Pos(ls_ObjectSyntax,"name=")
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
		ls_ObjName = Mid(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
		
		uo_Band.dw_Header.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_HeaderGroup.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_Detail.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_TrailerGroup.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_Summary.Modify("Destroy " + ls_ObjName)
		uo_Band.dw_Footer.Modify("Destroy " + ls_ObjName)
		This.Event ue_SetModify("Destroy " + ls_ObjName)
		
		ll_Pos = Pos(ls_ObjectSyntax,"band=")
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
		ls_Sourband = Mid(ls_ObjectSyntax,ll_Pos + Len("band="),ll_NextBlank - (ll_Pos + Len("band=")))
		
		if ll_Pos > 0 and ll_NextBlank > 0 and Lower(ls_Sourband) <> Lower(ls_DestBand) then
			ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len("band="),ll_NextBlank - (ll_Pos + Len("band=")),Lower(ls_DestBand))
		end if
	
		ll_Pos = Pos(ls_ObjectSyntax,XCOORMARK)
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos + 1)
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len(XCOORMARK),ll_NextBlank - (ll_Pos + Len(XCOORMARK)) - 1,String(ll_X))
		end if
	
		ll_Pos = Pos(ls_ObjectSyntax,YCOORMARK)
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos + 1)
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len(YCOORMARK),ll_NextBlank - (ll_Pos + Len(YCOORMARK)) - 1,String(ll_Y))
		end if
		
		ll_Pos = Pos(ls_ObjectSyntax," visible=")
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos + 1)
		if ll_Pos > 0 and ll_NextBlank > 0 then
			ls_ObjectSyntax = Replace(ls_ObjectSyntax,ll_Pos + Len(" visible=") + 1,ll_NextBlank - (ll_Pos + Len(" visible=") + 1) - 1,"1")
		end if
		
		ls_ObjectSyntax = "Create " + ls_ObjectSyntax
		ldw_band.Modify(ls_ObjectSyntax)
		This.Event ue_SetModify(ls_ObjectSyntax)
		
		ldw_band.is_OrgObj = ls_ObjName
		ldw_band.is_CurObj = ls_ObjName
		
		ls_Type = ldw_band.Describe(ls_ObjName + ".Type")
		
		//Change the color of text from grey to black - jervis 01.30.2011
		if ls_type = 'text' then
			if ldw_band.describe(ls_ObjName + ".color") = '8421504' then
				ldw_band.Modify(ls_objName + ".color = '0'")
				This.Event ue_SetModify(ls_objName + ".color = '0'")
				ll_find = this.dw_properties.Find("sys_fields_field_name ='" + ls_objName + "'",1,this.dw_properties.rowcount())
				if ll_find > 0 then this.dw_properties.SetItem( ll_find, "fields_label_textcolor",0)
			end if
		end if
		
		if ls_type = 'column' then
			if ldw_band.describe(ls_ObjName + ".color") = '8421504' and ldw_band.describe(ls_ObjName + ".background.color") = '12632256' then
				ldw_band.Modify(ls_objName + ".color = '0' " + ls_objName + ".background.color = '16777215'")
				This.Event ue_SetModify(ls_objName + ".color = '0' " + ls_objName + ".background.color = '16777215'")
				ll_find = this.dw_properties.Find("sys_fields_field_name ='" + ls_objName + "'",1,this.dw_properties.rowcount())
				if ll_find > 0 then 
					this.dw_properties.SetItem( ll_find, "fields_textcolor",0)
					this.dw_properties.SetItem( ll_find, "fields_textbkcolor",16777215)
				end if
			end if
		end if
		
		
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
			ll_Pos = Pos(ls_ObjectSyntax,"name=")
			ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
			ls_ObjName = Mid(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
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
// Author:	Jervis		Date: 07.13.2011
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String  	ls_ObjectSyntax,ls_ObjName,ls_Sourband,ls_DestBand,ls_Type,ls_Column_ID
long		ll_X,ll_Y,ll_TotalCnts,ll_Index,ll_Cnt,ll_Pos,ll_NextBlank
long 	ll_width,ll_height
long ll_find
long ll_i, ll_Cycle
string ls_NextObjName,ls_NextObjSyntax
CONSTANT STRING XCOORMARK = ' x="'
CONSTANT STRING YCOORMARK = ' y="'

pfc_cst_u_band   	ldw_band

st_Add.Visible = False

of_UnselectAllObject()

ll_X = al_X
ll_Y = al_Y
ll_Cycle = 5

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
	CASE 'HEADERGROUP','HEADER.1'
		ls_DestBand = 'header.1'
		ldw_band = uo_Band.dw_HeaderGroup
	CASE 'TRAILERGROUP','TRAILER.1'
		ls_DestBand = 'trailer.1'
		ldw_band = uo_Band.dw_TrailerGroup
	CASE else
		Return -1
END CHOOSE

if ls_DestBand = '' then Return -1

ll_TotalCnts = UpperBound(is_FieldSyntax)
if ib_PreparVisible and ll_TotalCnts > 0 and il_CurVisibleNo <= ll_TotalCnts then
	ls_ObjectSyntax = is_FieldSyntax[il_CurVisibleNo]
	if ll_Cycle > ll_TotalCnts - il_CurVisibleNo then ll_Cycle = ll_TotalCnts - il_CurVisibleNo
	if Not (IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "") then
		ll_Pos = Pos(ls_ObjectSyntax,"name=")
		ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
		ls_ObjName = Mid(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
		ls_Type = ldw_band.Describe(ls_ObjName + ".Type")
		
		wf_addinvisibleObject(ldw_band,ls_ObjName,ls_ObjectSyntax,ls_DestBand,ll_x,ll_y)
		if ls_Type = 'column' then
			
			for ll_i = 1 to ll_Cycle
				ls_NextObjName = ""
				ls_NextObjSyntax = is_FieldSyntax[il_CurVisibleNo]
				if Not (IsNull(ls_NextObjSyntax) or Trim(ls_NextObjSyntax) = "") then
					ll_Pos = Pos(ls_NextObjSyntax,"name=")
					ll_NextBlank = Pos(ls_NextObjSyntax," ",ll_Pos)
					ls_NextObjName = Mid(ls_NextObjSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
				end if 
				if ls_NextObjName = ls_ObjName + '_t' then 
					ll_height = long(ldw_band.Describe(ls_NextObjName + ".height"))
					if ll_height = 0 then ll_height = 52  //object is not exists - jervis 10.13.2011, defaule value is 52
					ll_y = al_y - ll_height - 20 //modified by gavins 20120314 grid
					ll_x = al_x
					if ll_y < 0 then ll_y = 0
					wf_addinvisibleObject(ldw_band,ls_NextObjName,ls_NextObjSyntax,ls_DestBand,ll_x,ll_y)
				end if
				if ls_NextObjName = 'b_' + ls_ObjName  or ls_NextObjName = 'b_' + ls_ObjName + '_r' or ls_NextObjName = 'b_' + ls_ObjName + '_g'  or ls_NextObjName = 'b_' + ls_ObjName  + 'track' then
					ll_x = al_x + long(ldw_band.Describe(ls_ObjName + ".width"))
					ll_y = al_y
					wf_addinvisibleObject(ldw_band,ls_NextObjName,ls_NextObjSyntax,ls_DestBand,ll_x,ll_y  ) 
				end if
				if  ls_NextObjName = 'b_contract_search' then //added by gavins 20120524
					ll_x = al_x + long(ldw_band.Describe( ls_ObjName + ".width"))
					ll_y = al_y
					wf_addinvisibleObject(ldw_band,ls_NextObjName,ls_NextObjSyntax,ls_DestBand,ll_x,ll_y  ) 
				end if
			next
			
			ldw_band.Modify(ls_ObjName + ".Protect = 1") //Added By Ken.Guo 02/13/2012. Forbid focus in the design mode.
		end if
		
	end if

	if il_CurVisibleNo <= ll_TotalCnts then
		ls_ObjectSyntax = is_FieldSyntax[il_CurVisibleNo]
		if Not (IsNull(ls_ObjectSyntax) or Trim(ls_ObjectSyntax) = "") then
			ll_Pos = Pos(ls_ObjectSyntax,"name=")
			ll_NextBlank = Pos(ls_ObjectSyntax," ",ll_Pos)
			ls_ObjName = Mid(ls_ObjectSyntax,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
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

public function integer wf_addinvisibleobject (pfc_cst_u_band adw_band, string as_objname, string as_objsyntax, string as_destband, long al_x, long al_y);//====================================================================
// Function: wf_AddInVisibleObject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName

//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Jervis		Date:07.13.2011
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long ll_pos,ll_nextblank
string ls_type
long ll_cnt,ll_index,ll_find
string ls_SourBand
string ls_Column_ID
CONSTANT STRING XCOORMARK = ' x="'
CONSTANT STRING YCOORMARK = ' y="'


		
uo_Band.dw_Header.Modify("Destroy " + as_ObjName)
uo_Band.dw_HeaderGroup.Modify("Destroy " + as_ObjName)
uo_Band.dw_Detail.Modify("Destroy " + as_ObjName)
uo_Band.dw_TrailerGroup.Modify("Destroy " + as_ObjName)
uo_Band.dw_Summary.Modify("Destroy " + as_ObjName)
uo_Band.dw_Footer.Modify("Destroy " + as_ObjName)
This.Event ue_SetModify("Destroy " + as_ObjName)

ll_Pos = Pos(as_ObjSyntax,"band=")
ll_NextBlank = Pos(as_ObjSyntax," ",ll_Pos)
ls_Sourband = Mid(as_ObjSyntax,ll_Pos + Len("band="),ll_NextBlank - (ll_Pos + Len("band=")))

if ll_Pos > 0 and ll_NextBlank > 0 and Lower(ls_Sourband) <> Lower(as_DestBand) then
	as_ObjSyntax = Replace(as_ObjSyntax,ll_Pos + Len("band="),ll_NextBlank - (ll_Pos + Len("band=")),Lower(as_DestBand))
end if

ll_Pos = Pos(as_ObjSyntax,XCOORMARK)
ll_NextBlank = Pos(as_ObjSyntax," ",ll_Pos + 1)
if ll_Pos > 0 and ll_NextBlank > 0 then
	as_ObjSyntax = Replace(as_ObjSyntax,ll_Pos + Len(XCOORMARK),ll_NextBlank - (ll_Pos + Len(XCOORMARK)) - 1,String(al_X))
end if

ll_Pos = Pos(as_ObjSyntax,YCOORMARK)
ll_NextBlank = Pos(as_ObjSyntax," ",ll_Pos + 1)
if ll_Pos > 0 and ll_NextBlank > 0 then
	as_ObjSyntax = Replace(as_ObjSyntax,ll_Pos + Len(YCOORMARK),ll_NextBlank - (ll_Pos + Len(YCOORMARK)) - 1,String(al_Y))
end if

ll_Pos = Pos(as_ObjSyntax," visible=")
/**********************************************///added by gavins 20120423
If Pos( as_ObjSyntax,' visible="1~t') > 0 Or Pos( as_ObjSyntax,' visible="0~t') > 0 Then
	ll_NextBlank = Pos( as_ObjSyntax,')"', ll_Pos + 1 ) + 2
Else
/**********************************************/
	ll_NextBlank = Pos(as_ObjSyntax," ",ll_Pos + 1)
End If

if ll_Pos > 0 and ll_NextBlank > 0 then
	as_ObjSyntax = Replace(as_ObjSyntax,ll_Pos + Len(" visible=") + 1,ll_NextBlank - (ll_Pos + Len(" visible=") + 1) - 1,"1")
end if

as_ObjSyntax = "Create " + as_ObjSyntax

//Begin - Modified By Ken.Guo 01/20/2014. Workaround APB Crash Bug. cannot using tabsequence during create column.
//adw_band.Modify(as_ObjSyntax)
String ls_syntax_new, ls_taborder,ls_ret
Long ll_pos_tab, ll_pos_space, ll_taborder
Boolean lb_modified
ll_pos_tab = Pos(as_ObjSyntax,'tabsequence=')
If ll_pos_tab > 0 Then
	ll_pos_space = Pos(as_ObjSyntax,' ', ll_pos_tab )
	If ll_pos_space > 0 Then
		ls_taborder =  Mid(as_ObjSyntax, ll_pos_tab + 12, ll_pos_space - ll_pos_tab - 12 )
		If isnumber(ls_taborder) Then
			ll_taborder = Long(ls_taborder)
			as_ObjSyntax = Replace(as_ObjSyntax,ll_pos_tab, ll_pos_space - ll_pos_tab,'')
			lb_modified = True
		End If
	End If
End IF
ls_ret = adw_band.Modify(as_ObjSyntax)
If lb_modified Then
	ls_ret = adw_band.Modify( as_objname + '.tabsequence=' + String(ll_taborder) )
End If
//End - Modified By Ken.Guo 01/20/2014.

This.Event ue_SetModify(as_ObjSyntax)

If adw_band.Describe( as_ObjName + ".width" ) = '0' Then
	adw_band.Modify(as_ObjName + ".width=500")
	This.Event ue_SetModify(as_ObjName + ".width=500")
End If

adw_band.is_OrgObj = as_ObjName
adw_band.is_CurObj = as_ObjName

ls_Type = adw_band.Describe(as_ObjName + ".Type")

//Change the color of text from grey to black - jervis 01.30.2011
if ls_type = 'text' then
	if adw_band.describe(as_ObjName + ".color") = '8421504' then
		adw_band.Modify(as_ObjName + ".color = '0'")
		This.Event ue_SetModify(as_ObjName + ".color = '0'")
		ll_find = this.dw_properties.Find("sys_fields_field_name ='" + as_ObjName + "'",1,this.dw_properties.rowcount())
		if ll_find > 0 then this.dw_properties.SetItem( ll_find, "fields_label_textcolor",0)
	end if
end if

if ls_type = 'column' then
	if adw_band.describe(as_ObjName + ".color") = '8421504' and adw_band.describe(as_ObjName + ".background.color") = '12632256' then
		adw_band.Modify(as_ObjName + ".color = '0' " + as_ObjName + ".background.color = '16777215'")
		This.Event ue_SetModify(as_ObjName + ".color = '0' " + as_ObjName + ".background.color = '16777215'")
		ll_find = this.dw_properties.Find("sys_fields_field_name ='" + as_ObjName + "'",1,this.dw_properties.rowcount())
		if ll_find > 0 then 
			this.dw_properties.SetItem( ll_find, "fields_textcolor",0)
			this.dw_properties.SetItem( ll_find, "fields_textbkcolor",16777215)
		end if
	end if
end if


if Upper(ls_Type) = Upper("Column") then
	if Not (IsNull(as_ObjName) or Trim(as_ObjName) = "") then
		ls_Column_ID = adw_band.Describe(as_ObjName + ".ID")
		adw_band.Modify(as_ObjName + "_t.Tag = '" + ls_Column_ID + "'")
		//adw_band.Modify(as_ObjName + ".Protect = 1")
		
		dw_properties.SetFilter("sys_fields_field_name = '" + as_ObjName + "'")
		dw_properties.Filter()
		
		if dw_properties.RowCount() > 0 then
			dw_properties.SetItem(1,"data_view_fields_visible","Y")
			dw_properties.AcceptText()
		end if
		
		ll_Cnt = dw_Fields_Alias.RowCount( )
		ll_Index = dw_Fields_Alias.Find("c_name='" + as_ObjName + "'",ll_Index,ll_Cnt)
		
		do while ll_Index > 0
			dw_Fields_Alias.SetItem(ll_Index,"visible",1)
			if ll_Index >= ll_Cnt then Exit
			ll_Index = dw_Fields_Alias.Find("c_name='" + as_ObjName + "'",ll_Index + 1,ll_Cnt)
		loop
	end if
end if

adw_band.of_AddorDelSingleSelect(as_ObjName,true)

ll_Cnt = UpperBound(adw_band.is_Objects)
for ll_Index = 1 to ll_Cnt
	if adw_band.is_Objects[ll_Index] = as_ObjName then
		Exit
	end if
next
if ll_Index > ll_Cnt then
	adw_band.is_Objects[UpperBound(adw_band.is_Objects) + 1] = as_ObjName
end if

il_CurVisibleNo++

return 1
end function

public function integer of_get_opsyntax (string as_orgsyntax, string as_opeclist, ref string as_opsyntax, ref string as_lookuplist);//Get Optimization Syntax - jervis 09.30.2011
//returns 1 if it succeeds and -1 if an error occurs
return gf_get_opsyntax(as_orgsyntax,as_opeclist,as_opsyntax,as_lookuplist)
/*
long ll_i, ll_count
integer li_rtn
string	ls_objlist[]
string ls_modify
string ls_protect
string ls_band
long ll_detail_height,ll_header_height
long ll_y,ll_y1,ll_y2
string ls_type
string ls_dddw_name
string ls_coltag

n_ds  lds_opsyntax

lds_opsyntax = create n_ds

lds_opsyntax.of_setbase( true)

li_rtn = lds_opsyntax.Create( as_orgsyntax)
if li_rtn < 0 then 
	destroy lds_opsyntax
	return li_rtn
end if

li_rtn = lds_opsyntax.inv_base.of_getobjects( ls_objlist)
if li_rtn < 0 then 
	destroy lds_opsyntax
	return 	li_rtn
end if

ll_detail_height = long(lds_opsyntax.Describe( "datawindow.Detail.Height"))
ll_header_height = long(lds_opsyntax.describe( "datawindow.header.height"))

ll_count = Upperbound(ls_objlist)
as_opeclist += ","

for ll_i = 1 to ll_count
	ls_type = lds_opsyntax.Describe(ls_objlist[ll_i] +  ".type")
	if ls_type = '?' or ls_type = '!' then continue
	
	
	if ls_type = 'column' then
		//Get lookup dddw list 
		if  lds_opsyntax.Describe(ls_objlist[ll_i] +  ".edit.style") = 'dddw' then
			ls_dddw_name = lds_opsyntax.describe( ls_objlist[ll_i] +  ".dddw.name")
			if ls_dddw_name = 'd_dddw_code_lookup' then
				ls_coltag =  Lower(lds_opsyntax.Describe(ls_objlist[ll_i] + ".TAG"))
				if gnv_app.inv_dwcache.of_isregistered(ls_coltag) <> 1 then as_lookuplist += ls_coltag + "," 
			end if
		end if
	end if
	if ls_type = 'column' or ls_type = 'compute' then
		//Can't delete the special objects - jervis 10.17.2011
		if pos(as_opeclist,ls_objlist[ll_i] + "," ) > 0 then continue
	end if
	
	//delete objects when visible = 0 and exists column object
	if lds_opsyntax.Describe(ls_objlist[ll_i] + ".visible") = '0' and isnumber(lds_opsyntax.Describe(ls_objlist[ll_i] + ".x")) then
		//if ls_type = 'column' then
		//	ls_modify += " destroy column " + ls_objlist[ll_i]
		//else
			ls_modify += " destroy " + ls_objlist[ll_i]
		//end if
		continue
	end if
		
	ls_band = lds_opsyntax.describe( ls_objlist[ll_i] +  ".band")
	if ls_band = '?' or ls_band = '!' then continue
	
	choose case ls_type
		case  'column' 
			//delete objects when object.y > band.height
			ll_y = long(lds_opsyntax.Describe(ls_objlist[ll_i] + ".y"))
			if ls_band = 'detail' then
				if ll_y > ll_detail_height then 
					ls_modify += " destroy  " + ls_objlist[ll_i]
					continue
				end if
			elseif ls_band = 'header' then
				if ll_y > ll_header_height then
					ls_modify += " destroy  " + ls_objlist[ll_i]
					continue
				end if
			end if
		case 'line'
			if ls_band = 'detail' then
				ll_y1 = long(lds_opsyntax.Describe(ls_objlist[ll_i] + ".y1"))
				ll_y2 = long(lds_opsyntax.Describe(ls_objlist[ll_i] + ".y2"))
				if ll_y1 > ll_detail_height and ll_y2 > ll_detail_height then
					ls_modify += " destroy " + ls_objlist[ll_i]
					continue
				end if
			end if

		case 'other'
			ll_y = long(lds_opsyntax.Describe(ls_objlist[ll_i] + ".y"))
			if ls_band = 'detail' then
				if ll_y > ll_detail_height then 
					ls_modify += " destroy " + ls_objlist[ll_i]
					continue
				end if
			end if
	end choose
next
lds_opsyntax.modify( ls_modify)
as_opsyntax = lds_opsyntax.describe( "datawindow.syntax")
destroy lds_opsyntax
return 1
*/

end function

public function string of_getscreensyntax (long al_screen_id, boolean ab_grid);//====================================================================
// Function: of_GetScreenSyntax()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_screen_id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-29
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
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

If ab_grid Then //grid
	ls_SQL = ids_Screen.GetitemString(ll_FindRow, "grid_sql")
	ll_Updated = ids_Screen.GetitemNumber(ll_FindRow,'updated')
	IF appeongetclienttype() = 'PB' and ll_Updated = 0 THEN
		ll_SQLLen = ids_Screen.GetItemNumber(ll_FindRow, "grid_sql_len")
		IF ll_SQLLen > 32765 THEN
			ls_SQL = f_get_screen_gridsql(il_data_view_id,al_screen_id,false)  //add false argu - jervis 10.11.2011
		END IF
	END IF
Else
	ls_SQL = ids_Screen.GetitemString(ll_FindRow, "dw_sql")
	ll_Updated = ids_Screen.GetitemNumber(ll_FindRow,'updated')
	IF appeongetclienttype() = 'PB' and ll_Updated = 0 THEN
		ll_SQLLen = ids_Screen.GetItemNumber(ll_FindRow, "dw_sql_len")
		IF ll_SQLLen > 32765 THEN
			ls_SQL = f_get_screen_sql(il_data_view_id,al_screen_id,false)  //add false argu - jervis 10.11.2011
		END IF
	END IF
End If
Return ls_SQL


end function

public function integer of_create_dynamic_dw_bak (integer ai_screen_id, boolean ab_use_defaultdwo);String ls_sql
Long ll_cr
//Integer li_pos//modified by nova 2008-09-23
long li_pos
String ls_error_create
Long ll_dw_sql_len
Long ll_screen_id
Long ll_updated
Long ll_FindRow
String ls_default_dataobject
n_ds lds_screen_temp

//BEGIN---Modify by Evan 07/14/2008
/*
ll_cr = dw_select_section.Getrow()
IF ll_cr = 0 THEN
	MessageBox("Select View", "You must first select a view before adding sections.")
	Return 0
END IF
il_dw_style = 0
ls_sql = dw_select_section.GetitemString(ll_cr, "dw_sql")

$<add> 09.06.2006 By: Liang QingShi
long ll_updated
dw_select_section.accepttext()
ll_updated = dw_select_section.getitemnumber(ll_cr,'updated')
IF appeongetclienttype() = 'PB' and ll_updated = 0 THEN
$<add> 09.06.2006 By: Liang QingShi

	ll_dw_sql_len = dw_select_section.GetItemNumber( ll_cr, "dw_sql_len")
	ll_screen_id = dw_select_section.GetItemNumber( ll_cr, "screen_id")
	IF ll_dw_sql_len > 32765 THEN
		ls_sql = f_get_screen_sql(il_data_view_id, ll_screen_id)
	END IF
END IF
*/

il_dw_style = 0

If ab_use_defaultdwo Then
	//Added By Ken.Guo 02/16/2012.  Get Default Dataobject Syntax
	ll_FindRow = ids_Screen.Find("screen_id=" + String(ai_screen_id), 1, ids_Screen.RowCount())
	If ll_FindRow <= 0 Then 
		Messagebox('Error','Failed to find the default dataobject for screen ' + string(ai_screen_id) + '.')
		Return -2
	End If
	ls_default_dataobject = ids_Screen.GetItemString(ll_FindRow,'dataobject')
	lds_screen_temp = Create n_ds
	lds_screen_temp.DataObject = ls_default_dataobject
	ls_SQL = lds_screen_temp.Describe('DataWindow.Syntax')
	Destroy lds_screen_temp
	If Len(ls_SQL) < 10 Then Return -3
Else
	ls_SQL = of_GetScreenSyntax(ai_screen_id)			//Modified by Scofield on 2009-09-29
End If

//END---Modify by Evan 07/14/2008

IF Isnull(ls_sql) OR LEN(ls_sql) = 0 THEN
	Messagebox("Generate DataWindow", "The DataWindow does not exist in the database!")
	RETURN -1
END IF

// Convert grid style to tabular
li_pos = Pos(ls_sql,"processing=1")
IF li_pos > 0 THEN
	ls_sql = Left(ls_sql,li_pos - 1) + "processing=0" + Mid(ls_sql, li_pos + 12)
	il_dw_style = 1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.27.2007 By: Jack 
//$<reason> Fix a defect.
If ii_screen_id = 2 Then
	//$<comment> 01.11.2008 by: Andy
	//Reason:There are many invisible objects,if these range in a row,there is a bug in WEB verion(can not display all invisible objects when Show Invisible button is clicked).
	//il_dw_style = 1
	
	li_pos = Pos(ls_sql,"1	if( master_contract_id > 0,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 33)
	End If
	
	li_pos = Pos(ls_sql,"1	if( master_cnt > 0 ,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 26)
	End If	
End If	

//$<add> 2007-11-02 By: Andy
//parent_window_design.wf_makeband( ls_sql)
If this.wf_makeband( ls_sql) < 0 Then  //modify by gavin on 2009/3/4
	Return -1
End If
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

public function integer of_create_dynamic_dw (integer ai_screen_id, boolean ab_use_defaultdwo);String ls_sql, ls_SQL2
Long ll_cr
//Integer li_pos//modified by nova 2008-09-23
long li_pos
String ls_error_create
Long ll_dw_sql_len
Long ll_screen_id
Long ll_updated
Long ll_FindRow
String ls_default_dataobject,ls_Null[]
n_ds lds_screen_temp
Boolean	lb_Grid, lb_GridModify

/***********************/
is_CopySyntax = ls_Null
is_AddObjectType = ""
//added by gavins 20120410
/***********************/

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
/**************************************/ //added by gavins 20120306 grid
ll_FindRow = dw_properties_dw.Find("screen_id=" + String(ai_screen_id), 1, dw_properties_dw.RowCount())
If ll_FindRow > 0 Then
	If dw_properties_dw.GetItemString( ll_FindRow, 'screen_style' ) = 'G' Then
		lb_Grid = True
	Else
		lb_Grid = False
	End If
End If
/**************************************/
If ab_use_defaultdwo Then
	//Added By Ken.Guo 02/16/2012.  Get Default Dataobject Syntax
	ll_FindRow = ids_Screen.Find("screen_id=" + String(ai_screen_id), 1, ids_Screen.RowCount())
	If ll_FindRow <= 0 Then 
		Messagebox('Error','Failed to find the default dataobject for screen ' + string(ai_screen_id) + '.')
		Return -2
	End If
	If lb_Grid Then //added by gavins 20120306 grid
		ls_default_dataobject = ids_Screen.GetItemString(ll_FindRow,'grid_dataobject')
	Else
		ls_default_dataobject = ids_Screen.GetItemString(ll_FindRow,'dataobject')
	End If
	lds_screen_temp = Create n_ds
	lds_screen_temp.DataObject = ls_default_dataobject
	ls_SQL = lds_screen_temp.Describe('DataWindow.Syntax')
	Destroy lds_screen_temp
	If Len(ls_SQL) < 10 Then Return -3
Else
	If lb_Grid Then
		ls_SQL = of_GetScreenSyntax(ai_screen_id, True )	//added by gavins 20120306 grid
	Else
		ls_SQL = of_GetScreenSyntax(ai_screen_id)			//Modified by Scofield on 2009-09-29
	End If
End If

//END---Modify by Evan 07/14/2008

IF Isnull(ls_sql) OR LEN(ls_sql) = 0 THEN
	Messagebox("Generate DataWindow", "The DataWindow does not exist in the database!")
	RETURN -1
END IF
//modified by gavins 20120329
li_pos = Pos(ls_sql,"processing=1")
IF li_pos > 0 THEN
	ls_sql = Left(ls_sql,li_pos - 1) + "processing=0" + Mid(ls_sql, li_pos + 12)
	il_dw_style = 1
END IF

/********************************************///add by gavins 20120309 grid
ll_FindRow = dw_properties_dw.Find("screen_id=" + String(ai_screen_id), 1, dw_properties_dw.RowCount())
If ll_FindRow > 0 Then
	If dw_properties_dw.GetItemString( ll_FindRow, 'grid_modify' ) = 'Y' and  Len( is_ChangedScreenStyle ) > 0  and is_OriginalScreenStyle <> is_ChangedScreenStyle  Then
		n_cst_update_screen  update_screen
		
		update_screen = create n_cst_update_screen
		
		ls_sql2 = of_GetScreenSyntax(ai_screen_id)//freefrom
		If Len( ls_sql2 ) > 0 Then
			If lb_Grid Then
				update_screen.of_Modifydatawindow( ls_sql2 ,ls_SQL, 'grid' )// freeform to grid
			Else
				update_screen.of_Modifydatawindow( ls_sql2 ,ls_SQL, 'freeform' )//grid to freeform 
			End If
			ib_GridModify = True	
			lb_GridModify = True
		End If
	End If
End If
is_ChangedScreenStyle = ""
/********************************************/

// Convert grid style to tabular
//li_pos = Pos(ls_sql,"processing=1")
//IF li_pos > 0 THEN
//	ls_sql = Left(ls_sql,li_pos - 1) + "processing=0" + Mid(ls_sql, li_pos + 12)
//	il_dw_style = 1
//END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.27.2007 By: Jack 
//$<reason> Fix a defect.
If ii_screen_id = 2 Then
	//$<comment> 01.11.2008 by: Andy
	//Reason:There are many invisible objects,if these range in a row,there is a bug in WEB verion(can not display all invisible objects when Show Invisible button is clicked).
	//il_dw_style = 1
	
	li_pos = Pos(ls_sql,"1	if( master_contract_id > 0,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 33)
	End If
	
	li_pos = Pos(ls_sql,"1	if( master_cnt > 0 ,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 26)
	End If	
End If	

//$<add> 2007-11-02 By: Andy
//parent_window_design.wf_makeband( ls_sql)
If this.wf_makeband( ls_sql) < 0 Then  //modify by gavin on 2009/3/4
	Return -1
End If
//---------------------------- APPEON END ----------------------------

If lb_GridModify  Then  //And  appeongetclienttype() <> 'PB' And il_dw_style = 1
	of_moveobject(  )// move invisible
	lb_GridModify = False
End If
uo_design.pb_show.hide( )
uo_design.pb_show.borderstyle = styleRaised!
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
	uo_design.pb_line.Visible = TRUE
	uo_design.pb_rectangle.Visible = True
	//end of add
	uo_design.st_3.Visible = FALSE
	uo_design.st_4.Visible = FALSE
	uo_design.hsb_1.Visible = FALSE
	uo_design.hsb_2.Visible = FALSE
	
	uo_design.pb_gridcolumn.Visible = FALSE
	uo_design.pb_gridtext.Visible = FALSE
	uo_design.pb_gridoval.Visible = FALSE
	uo_design.pb_gridcompute.Visible = FALSE
	uo_design.pb_gridpicture.Visible = FALSE

	uo_design.pb_gridline.Visible = FALSE
	uo_design.pb_gridrectangle.Visible = FALSE
	
	uo_design.st_show_invisible.Visible = FALSE		//Added by Scofield on 2010-03-23
	uo_design.pb_show.x = 2505
ELSE
	//$<comment> 2007-11-07 By: Andy
	//idw_detail.Modify( "DataWindow.Detail.Height = 1000" )
	
	uo_design.pb_compute.Visible = FALSE
	uo_design.pb_column.Visible = FALSE
	uo_design.pb_text.Visible = FALSE
	uo_design.r_2.Visible = TRUE
	//uo_design.st_2.Visible = false
	uo_design.st_7.Visible = TRUE
	uo_design.pb_groupbox.Visible = TRUE
	uo_design.pb_oval.Visible = FALSE	//Added by Scofield on 2009-03-20
	//<add> 06/21/2007 by: Andy
	uo_design.pb_picture.Visible = FALSE
	uo_design.pb_line.Visible = False	
	uo_design.pb_rectangle.Visible = False
	//end of add	
	uo_design.st_3.Visible = TRUE
	uo_design.st_4.Visible = TRUE
	uo_design.hsb_1.Visible = TRUE
	uo_design.hsb_2.Visible = TRUE
	
	uo_design.st_show_invisible.Visible = FALSE		//Added by Scofield on 2010-03-23  //modified by gavins 20120308 grid
	
	uo_design.pb_gridcolumn.Visible = TRUE //added by gavins 20120306 grid
	uo_design.pb_gridtext.Visible = TRUE
	uo_design.pb_gridoval.Visible = TRUE
	uo_design.pb_gridcompute.Visible = TRUE
	uo_design.pb_gridpicture.Visible = TRUE

	uo_design.pb_gridline.visible = TRUE
	uo_design.pb_gridrectangle.Visible = TRUE
	
	//$<modify> 01.11.2008 By: Andy
	uo_band.dw_detail.Modify("DataWindow.Selected.Mouse = No")
	uo_design.pb_show.x =3650
END IF

//$<add> 03.25.2008 by Andy
dw_fields_alias.retrieve( 1 , ','+String(ii_screen_id)+',' , il_data_view)
//end of add 03.25.2008

ib_AlwaysUpdate = false		//Added by Scofield on 2009-10-12

RETURN 1

end function

public function integer of_showhidegridcolumn (string as_title[], string as_column[], long al_x, long al_y, string as_show);//add column in grid
Long					ll_X, ll_Y, ll_Cycle, ll_MinX, ll_MinY, ll_TempX, ll_TempY, ll_Width, ll_Width2
String					ls_DestBand, ls_Objects[], ls_Temp, ls_MinObject, ls_Modify, ls_Modify2, ls_MinObject2
Integer				li_i, li_k

String					ls_Column[], ls_Titles[], ls_Objects2[], ls_Type
Long					ll_MaxX, ll_MaxWidth, ll_X2

pfc_cst_u_band   	ldw_band, ldw_Header

st_Add.Visible = False

ll_Miny = 4

ldw_band = uo_Band.dw_Detail

SetPointer( HourGlass! )
//if ls_DestBand = '' then Return -1
//1.get click point near column
ldw_Header =  uo_Band.dw_Header

ldw_band.of_GetObjects( ls_Objects )
ldw_Header.of_GetObjects( ls_Objects2 )

If as_show = 'show' Then
	If UpperBound( as_column) > 0 Then
		is_Fields = as_column
		al_X = 9999999
	End If
	If  UpperBound( is_Fields )= 0 Then Return -1
	ls_MinObject = ''
	ll_Width = 0
	ll_Minx = 0
	//check fields visible
	ls_Temp = ''
	For li_i = 1 To Upperbound( is_Fields ) 
		
		If  ( ldw_band.Describe( is_Fields[li_i] + ".visible" ) = '1' Or IsNull( is_Fields[li_i] ) ) And   ldw_band.Describe( is_Fields[li_i] + ".type" ) <> 'compute' Then
			is_Fields[li_i]  = ''
		End If
	Next	
	
	//min x
	For li_i = 1 To UpperBound( ls_Objects )
		ls_Type = ldw_band.Describe( ls_Objects[li_i] + ".type" )
		If ldw_band.Describe( ls_Objects[li_i] + ".visible" ) = '1' and (ls_Type = 'column' Or ls_Type = 'compute' )Then
			ll_TempX = Long( ldw_band.Describe( ls_Objects[ li_i ] + ".X" ) )
			If ll_TempX < al_X And ll_TempX > ll_Minx Then
				ll_Minx = ll_TempX
				ls_MinObject = ls_Objects[ li_i ] 
			End If	
		End If
	Next
	
	If Len( ls_MinObject ) > 0 Then
		ll_Width = Long( ldw_band.Describe( ls_MinObject + ".width" ) ) + 4
		ll_Miny =  Long( ldw_band.Describe( ls_MinObject + ".Y" ) )
	End If
	
	//is_Fields
	ll_Width2 = 0 
	ls_Modify = ""
	For li_i = 1 To UpperBound( is_Fields )
		If is_Fields[li_i]  = '' Then Continue
		If ldw_band.Describe( is_Fields[li_i] +".type" ) = 'column' Or ldw_band.Describe( is_Fields[li_i] +".type" ) = 'compute' Then
			ll_Width2 += Long( ldw_band.Describe( is_Fields[li_i] + ".width" ) ) + 4
		End If			
		ls_Modify += is_Fields[li_i] + ".visible='1'~t"
	Next
	ldw_band.Modify( ls_Modify  )
	ldw_Header.Modify( ls_Modify  )
	this.Event ue_SetModify(ls_Modify)
	
	//move behind column
	ls_Modify = ""
	For li_i = 1 To  UpperBound( ls_Objects )
		If ldw_band.Describe( ls_Objects[li_i] + ".visible" ) <> '!' and Long( ldw_band.describe( ls_Objects[li_i] + ".x" ) ) > ll_MinX  Then
			ls_Modify +=  ls_Objects[li_i] + ".x=" + string( Long( ldw_band.describe( ls_Objects[li_i] + ".x" ) ) + ll_Width2 + 4  ) + "~t"
		End If
	Next
	
	ldw_band.Modify( ls_Modify  )
	ldw_Header.Modify( ls_Modify  )
	uo_Band.dw_footer.Modify( ls_modify )
	uo_Band.dw_summary.Modify( ls_modify )
	this.Event ue_SetModify(ls_Modify)
	
	//move   columns behind added column
	ls_Modify = ""
	For li_i = 1 To  UpperBound( is_Fields )
		If is_Fields[li_i]  = '' Then Continue
		ls_Type = ldw_Band.Describe(  is_Fields[li_i] + ".type" ) 
		If ls_Type = 'column' Or ls_Type = 'compute' Then
			ll_width2 =  Long( ldw_Band.Describe( is_fields[li_i] + ".width" ) ) + 4
			ll_x2 = long( ldw_band.describe(is_Fields[li_i]+ ".x" ) )
			For li_k = 1 To  UpperBound( ls_Objects )
				If  Long( ldw_band.describe( ls_Objects[li_k] + ".x" ) ) >  ll_x2 Then
					ls_Modify += ls_Objects[li_k] + ".x=" + string( long( ldw_band.describe( ls_Objects[li_k] + ".x" ) ) - ll_width2  ) + "~t"
				End If
			Next
			ldw_band.Modify( ls_Modify )
			ldw_Header.Modify( ls_Modify )
			uo_Band.dw_footer.Modify( ls_modify )
			uo_Band.dw_summary.Modify( ls_modify )
			this.Event ue_SetModify(ls_Modify)
		End If
	Next
	
	//move added column
	ls_Modify = ""
	ls_Modify2= ""
	ll_X = ll_MinX + ll_Width
	For li_i = 1 To  UpperBound( is_Fields )
		If is_Fields[li_i]  = '' Then Continue	
		ls_Type = ldw_Band.Describe(  is_Fields[li_i] + ".type" ) 
		If ls_Type = 'column' Or ls_Type = 'compute' Then
			ls_Modify += is_Fields[li_i] + ".X=" + String( ll_X ) + "~t " +  is_Fields[li_i] + ".Y=" + String ( ll_MinY )  + "~t"
			If ldw_Band.Describe( is_Fields[li_i] + "_t.X") <> "!" Then
				ls_Modify2 +=  is_Fields[li_i] + "_t.X=" + String( ll_X ) + "~t " + is_Fields[li_i] + "_t.visible='1'~t" 
			End If
			ll_X =  ll_X + Long( ldw_Band.Describe( is_fields[li_i] + ".width" ) ) + 8
		End If
	Next
	ldw_band.Modify( ls_Modify + ls_Modify2 )
	ldw_Header.Modify( ls_Modify + ls_Modify2 )
	this.Event ue_SetModify(ls_Modify + ls_Modify2)
	For li_i = 1 To  UpperBound( is_Fields )
		If is_Fields[li_i]  = '' Then Continue		
		ls_Type = ldw_Band.Describe(  is_Fields[li_i] + ".type" ) 
		If  ls_Type = 'column' Or ls_Type = 'compute' Then
			ldw_band.of_AddOrDelSingleSelect(is_Fields[li_i],false)
			ldw_band.of_AddorDelSingleSelect(is_Fields[li_i],true)
			ldw_Header.of_AddOrDelSingleSelect(is_Fields[li_i]+ "_t",false)
			ldw_Header.of_AddorDelSingleSelect(is_Fields[li_i]+"_t",true)
		ElseIf ls_Type = 'text' Then
			ldw_Header.of_AddOrDelSingleSelect(is_Fields[li_i],false)
			ldw_Header.of_AddorDelSingleSelect(is_Fields[li_i],true)
		End If
	Next
	//properties
	For li_i = 1 To  UpperBound( is_Fields )
		If is_Fields[li_i]  = '' Then Continue		
		ls_Type = ldw_Band.Describe(  is_Fields[li_i] + ".type" ) 
		If ls_Type = 'column'  or ls_Type = 'text' Or ls_Type = 'compute' Then 
			dw_Properties.SetFilter("sys_fields_field_name = '" +  is_Fields[li_i]  + "'")
			dw_Properties.Filter()
			
			if dw_Properties.RowCount() <= 0 then CONTINUE
			
			dw_Properties.SetItem(1,'data_view_fields_visible','Y' )
		End If
	Next
	
	dw_Properties.AcceptText()

//	of_UnselectAllObject()
Else//hide

	ls_Titles = as_title
	ls_Column = as_column

	For li_k = 1 To UpperBound( ls_Column )
		ll_MinX = Long( ldw_band.Describe( ls_Column[li_k]	+ ".X" ) )	
		ll_Width = Long( ldw_band.Describe( ls_Column[li_k] + ".width" ) )
		//max  x 
		ls_MinObject = ''
		ll_MaxX = 0
		ll_X2 = 0
			For li_i = 1 To UpperBound( ls_Objects )
				ls_Type = ldw_Band.Describe(  ls_Objects[li_i] + ".type" ) 
				If ( ls_Type = 'column' Or  ls_Type = 'compute'  )and ldw_Band.Describe(  ls_Objects[li_i] + ".band" ) = 'detail'   Then
					ll_TempX = Long( ldw_band.Describe( ls_Objects[ li_i ] + ".X" ) )
					If ll_TempX > ll_MaxX Then
						ll_MaxX = ll_TempX
						ls_MinObject = ls_Objects[ li_i ] 
					End If	
					If ll_TempX < ll_MinX  And ll_TempX > ll_X2 Then
						ll_X2 = ll_TempX
						ls_MinObject2 = ls_Objects[ li_i ] 
					End If
				End If
			Next
	
		If Len( ls_MinObject2 ) > 0 Then
			ll_Width2 =  Long( ldw_band.Describe( ls_MinObject2 + ".width" ) ) 
			ll_Width = ll_MinX + ll_Width - ll_X2 - ll_Width2 
		End If
		If Len( ls_MinObject ) > 0 Then
			ll_MaxWidth = Long( ldw_band.Describe( ls_MinObject + ".width" ) ) 
		End If
		//move behind column
		ls_Modify = ""
		ls_Modify2 = ""
		For li_i = 1 To  UpperBound( ls_Objects )
			If  Long( ldw_band.describe( ls_Objects[li_i] + ".x" ) ) > ll_MinX Then
				ls_Modify +=  ls_Objects[li_i] + ".x=" + string( Long( ldw_band.describe( ls_Objects[li_i] + ".x" ) ) - ll_Width   ) + "~t"
			End If
		Next
		
		ldw_band.Modify( ls_Modify  )
		//move title
		ldw_Header.Modify( ls_Modify  )
		uo_Band.dw_footer.Modify( ls_modify )
		uo_Band.dw_summary.Modify( ls_modify )
		this.Event ue_SetModify(ls_Modify)
		
		//move column to last column
		ls_Modify = ls_Column[li_k] + ".x=" + string(  Long( ldw_band.Describe( ls_MinObject + ".x" ) ) + ll_MaxWidth ) + "~t" + &
			ls_column[li_k] + ".visible='0'~t" + ls_Column[li_k] + "_t.x=" + string(  Long( ldw_band.Describe( ls_MinObject + ".x" ) ) + ll_MaxWidth ) + "~t" +&
			ls_column[li_k] + "_t.visible='0'"
		ldw_band.Modify( ls_Modify )
		ldw_Header.Modify( ls_Modify )
		
		this.Event ue_SetModify(ls_Modify)	
	Next
	
//	For li_k = 1 To UpperBound( ls_Titles  )
//		ldw_Header.Modify( ls_Titles[li_k] + ".visible='0'" )
//	Next
	

End If

of_Refresh_Object_Inforamtion()

Return 1

end function

public function integer of_checkmodified ();String			ls_Syntax
Integer		li

ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")

IF ls_Syntax <> is_OrgSyntax  THEN
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
end function

public subroutine of_resetupdated (string as_style);//reset  ids_screen  screen_style 
Long		ll_FindRow	, ll_FindRow2


ll_FindRow = ids_Screen.Find("screen_id=" + String(ii_screen_id), 1, ids_Screen.RowCount())
If ll_FindRow > 0 Then
	If ids_Screen.getItemNumber(ll_FindRow,'updated') = 1 Then ids_Screen.SetItem(ll_FindRow,'updated', 0 )
	
	If Len( as_style ) > 0 Then 
		ids_Screen.SetItem(ll_FindRow,'screen_style', as_style )
		ll_FindRow2 = dw_properties_dw.Find("screen_id=" + String(ii_screen_id), 1, dw_properties_dw.RowCount())
		If ll_FindRow2 > 0 Then dw_properties_dw.SetItem(ll_FindRow2,'screen_style', as_style )
	Else
		ids_Screen.SetItem(ll_FindRow,'screen_style', is_LastSaveScreenStyle ) //keep ids_Screen 's screen style  to Last state
	End If
		
		
	is_ChangedScreenStyle = as_style
End If
end subroutine

public subroutine of_autoupdatesearchscreen (string as_objname, string as_tobject);//====================================================================
// Function: of_AutoUpdateSearchScreen()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-29
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//Modified by gavins 20120328
//====================================================================

String	ls_CriteriaSyntax,ls_BrowseSyntax,ls_Edit_Style
String	ls_Visible_1,ls_Visible_2,ls_Proper,ls_ProExp
String	ls_ObjType,ls_FieldName,ls_LabelName
long		ll_RtnVal,ll_Cycle,ll_AlwaysUpdate
String		ls_Tcol, ls_Tlab, ls_TProper, ls_Err

DataStore	lds_Temp

if  Not( ( ii_screen_id >=3 and ii_screen_id <= 10) or ii_screen_id = 31 )  then Return
if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return

ls_ObjType = uo_band.dw_Syntax.Describe(as_ObjName + ".Type")
if ls_ObjType = "column" then
	ls_FieldName = as_ObjName
	ls_LabelName = ls_FieldName + "_t"
	ls_TCol = as_tobject
	ls_Tlab = ls_TCol + "_t"
elseif ls_ObjType = "text" then
	ls_FieldName = Left(as_ObjName,Len(as_ObjName) - 2)
	ls_LabelName = as_ObjName
	ls_TCol = Left(as_tobject,Len(as_tobject) - 2)
	ls_Tlab = as_tobject
else
	Return
end if

SetPointer(HourGlass!)


ls_CriteriaSyntax = of_GetScreenSyntax(1)
if IsNull(ls_CriteriaSyntax) or Trim(ls_CriteriaSyntax) = "" then Return
ids_Criteria.Create(ls_CriteriaSyntax, ls_Err )
If Len( ls_Err ) > 0 Then
	Messagebox("Auto Update DataWindow", "The Syntax is error !" + ls_Err )
	Return
End If
ls_BrowseSyntax = of_GetScreenSyntax(2)
if IsNull(ls_BrowseSyntax) or Trim(ls_BrowseSyntax) = "" then Return
ids_Browse.Create(ls_BrowseSyntax, ls_Err )
If Len( ls_Err ) > 0 Then
	Messagebox("Auto Update DataWindow", "The Syntax is error !" + ls_Err )
	Return
End If

If IsNull( as_tobject ) Or Trim( as_tobject ) = '' Then 
	ls_TCol = ls_FieldName //added by gavins 20120329    source object and target object is different
	ls_Tlab = ls_LabelName
End If


if ls_ObjType = "column" then
	ls_Visible_1 = ids_Criteria.Describe(ls_TCol + ".Visible")
	ls_Visible_2 = ids_Browse.Describe(ls_TCol + ".Visible")
else
	ls_Visible_1 = ids_Criteria.Describe(ls_Tlab + ".Visible")
	ls_Visible_2 = ids_Browse.Describe(ls_Tlab + ".Visible")
end if

if (ls_Visible_1 = "?" or ls_Visible_1 = "!") and (ls_Visible_2 = "?" or ls_Visible_2 = "!") then Return

if Not ib_AlwaysUpdate  then //and (ls_Visible_1 = "1" or ls_Visible_2 = "1")  modified by gavins 20120611
	if ib_AlwaysUpdate then ll_AlwaysUpdate = 10 else ll_AlwaysUpdate = 0
	OpenWithParm(w_CascadeUpdateConfirm,String(ll_AlwaysUpdate) + "," + Left(ls_ObjType,1))
	ll_RtnVal = Message.DoubleParm
	if ll_RtnVal >= 10 then
		ib_AlwaysUpdate = true
	else
		ib_AlwaysUpdate = false
	end if
	if Mod(ll_RtnVal,2) <> 1 then Return
Else
	//Return //Commented by (Appeon)Harry 03.19.2014 - V142 ISG-CLX
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
	ls_TProper = ls_Tlab + ".Text" 
	ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
	
	lds_Temp.Modify( ls_TProper + "='" + ls_ProExp + "'")
	
	if ls_ObjType = "column" then
		/****************************************************///modified by gavins20120518 
		ls_Edit_Style = uo_band.dw_Syntax.Describe(ls_FieldName + ".Edit.Style")
		if ls_Edit_Style = "edit" then
			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".format"
			ls_TProper = ls_TCol + "." + ls_Edit_Style + ".format"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
		elseif ls_Edit_Style = "editmask" then
			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".Mask"
			ls_TProper = ls_TCol + "." + ls_Edit_Style +".Mask"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
		elseif ls_Edit_style = "dddw" Then
		
		
			ls_Proper = ls_FieldName + ".dddw.VscrollBar"
			ls_TProper = ls_TCol + ".dddw.VscrollBar"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "no"
			lds_Temp.Modify( ls_TProper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.AutoHScroll"
			ls_TProper = ls_TCol + ".dddw.AutoHScroll"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "no"
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			
			if ll_Cycle = 1 then
				ls_Proper = ls_FieldName + ".dddw.UseAsBorder"
				ls_TProper = ls_TCol + ".dddw.UseAsBorder"
				ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
				If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "no"
				lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			end if
			
			ls_Proper = ls_FieldName + ".dddw.NilIsNull"
			ls_TProper = ls_TCol + ".dddw.NilIsNull"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "no"
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.Name"
			ls_TProper = ls_TCol + ".dddw.Name"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "none"
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.DataColumn"
			ls_TProper = ls_TCol + ".dddw.DataColumn"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "none"
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.DisplayColumn"
			ls_TProper = ls_TCol + ".dddw.DisplayColumn"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "none"
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.PercentWidth"
			ls_TProper = ls_TCol +".dddw.PercentWidth"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "0"
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".tag"
			ls_TProper = ls_TCol +".tag"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!'   Then ls_ProExp = ""
			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
			
	//		ls_Edit_Style = uo_band.dw_Syntax.Describe(ls_FieldName + ".Edit.Style")
	//		if ls_Edit_Style = "edit" then
	//			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".format"
	//			ls_TProper = ls_TCol + "." + ls_Edit_Style + ".format"
	//			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
	//			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
	//		elseif ls_Edit_Style = "editmask" then
	//			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".Mask"
	//			ls_TProper = ls_TCol + "." + ls_Edit_Style +".Mask"
	//			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
	//			lds_Temp.Modify(ls_TProper + "='" + ls_ProExp + "'")
	//		end if
		end if
	end if
	
	of_SetScreenSyntax(ll_Cycle,lds_Temp.Object.DataWindow.Syntax)
next

ib_HasNewModify = false

SetPointer(Arrow!)

end subroutine

public subroutine of_moveobject ();//move invisible 
//====================================================================
// Function: of_moveobject
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-04-05
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long					ll_X, ll_Y, ll_Cycle, ll_MinX, ll_MinY, ll_TempX, ll_TempY, ll_Width, ll_Width2
String					ls_DestBand, ls_Objects[], ls_Temp, ls_MinObject, ls_Modify, ls_Modify2
Integer				li_i, li_k

String					ls_Column[], ls_Titles[], ls_Objects2[], ls_Type, ls_X, ls_Band, ls_Value
Long					ll_MaxX, ll_MaxWidth, ll_X2, ll_row

pfc_cst_u_band   	ldw_band, ldw_Header

DataStore			lds_Object

ll_Miny = 4

ldw_band = uo_Band.dw_Detail

SetPointer( HourGlass! )

ldw_Header =  uo_Band.dw_Header

ldw_band.of_GetObjects( ls_Objects )
ldw_Header.of_GetObjects( ls_Objects2 )

lds_Object = Create DataStore
lds_Object.DataObject = 'd_screen_design_object_atrributes'


ll_MaxX = 0
For li_i = 1 To Upperbound( ls_Objects  )
	ls_X = ldw_Band.Describe( ls_Objects[li_i] + ".x" )
	If ls_X = '!' Or ls_X = '?' Or Trim( ls_X ) = '' Or Not isNumber( ls_X )  Then Continue
	
	ll_Row = lds_Object.InsertRow( 0 )
	lds_Object.SetItem( ll_Row, 'obj_name', ls_Objects[li_i] )
	lds_Object.SetItem( ll_Row, 'obj_pro', 	'x' )
	lds_Object.SetItem( ll_Row, 'obj_value', ls_X )
	lds_Object.SetItem( ll_Row, 'obj_visible',  ldw_Band.Describe( ls_Objects[li_i] + ".visible" ) )
	lds_Object.SetItem( ll_Row, 'obj_type',  ldw_Band.Describe( ls_Objects[li_i] + ".type" ) )
	lds_Object.SetItem( ll_Row, 'obj_band',  ldw_Band.Describe( ls_Objects[li_i] + ".band" ) )
	lds_Object.SetItem( ll_Row, 'obj_width',  ldw_Band.Describe( ls_Objects[li_i] + ".width" ) )
Next
//sort
lds_Object.SetSort( "obj_band  , obj_visible desc,Long(obj_value), obj_type" )
lds_Object.Sort( )


ll_TempX = 4
ls_Modify = ""
ls_Modify2 =""
For li_i = 1 To lds_Object.RowCount( )
	ls_Type = lds_Object.GetItemString( li_i, 'obj_type' )
	ls_Band = lds_Object.GetItemString( li_i, 'obj_band' )
	
	ll_X = Long( lds_Object.GetItemString( li_i, 'obj_value' ) )
	ll_Width = Long( lds_Object.GetItemString( li_i, 'obj_width' ) )
	
	If ls_Type = 'compute' Or ls_Type = 'column' Then
		ls_Temp =  lds_Object.object.obj_name[li_i]
		ls_Modify = ls_Modify + " " + ls_Temp + ".x=" + String( ll_tempx )
		ls_Value = ldw_Band.Describe( ls_Temp + "_t.x" )
		If ls_Value <> '!' And ls_Value <> '?' And ls_Value<> '' Then
			ls_Modify2 = ls_Modify2 + " " +  ls_Temp + "_t.x=" + String( ll_tempx )
		End If
		ll_TempX = ll_TempX + ll_width + 8
	End If
	
Next

ldw_Band.Modify ( ls_Modify )
ldw_Header.Modify ( ls_Modify )
this.Event ue_SetModify(ls_Modify)
ldw_Band.Modify ( ls_Modify2 )
ldw_Header.Modify ( ls_Modify2 ) 
this.Event ue_SetModify(ls_Modify2)

end subroutine

public function integer wf_addcompute (string as_objtype, long al_x, long al_y);//====================================================================
// Function: wf_addcompute
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_objtype
// 	al_x
// 	al_y
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-04-05
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String 		ls_NewName,ls_Modify,ls_err,ls_band='',ls_index, ls_objects,ls_LabelText
long 			ll_x,ll_y,ll_row,ll_k,ll_max,ll_Object_No,ll_LabelWidth
String 		ls_ObjName
string			ls_filename,ls_path,ls_path_to, ls_ModifyText, ls_Field[]
integer	 	li_find


pfc_cst_u_band   	ldw_band
str_pass 			lstr_pass,lstr_Ret

if	Lower(as_objType) <> Lower('compute')  And  UPPER(is_CurBand) <> 'DETAIL' Then
	RETURN -1
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
	CASE 'HEADERGROUP','HEADER.1'
		ls_Band = 'header.1'
		ldw_band = uo_band.dw_Headergroup				
	CASE 'TRAILERGROUP','TRAILER.1'
		ls_Band = 'trailer.1'
		ldw_band = uo_band.dw_trailergroup		
	CASE else
		Return -1
END CHOOSE

if ls_Band = '' then Return -1

if is_Compute_Label_Name = "" then
	ll_Object_No = 0
	do
		ll_Object_No++
		ls_NewName = "object" + String(ll_Object_No) + "_" + Left(is_AddObjectType,1)
		ls_ObjName = uo_band.dw_syntax.Describe(ls_NewName + ".name")
	loop while ls_ObjName <> "!"
	
	ldw_Band.is_NewObjName = ls_NewName
	
	OpenWithParm(w_SpecifyObjectName,ldw_Band)
	
	ls_NewName = Message.StringParm
	if IsNull(ls_NewName) or Trim(ls_NewName) = "" then
		is_addobjectType = ''
		Return 1
	end if
	ls_LabelText = "text"
	ll_LabelWidth = 520
else
	ls_NewName = is_Compute_Label_Name
	ls_LabelText = is_Compute_Label_Text
	ll_LabelWidth = 520
end if


ls_ModifyText = 'create text(band=' + "header" + ' visible="0" alignment="0" text="' + ls_NewName + "_t" + '" border="6" color="0" '&
				+ 'x="' + string(999999) + '" y="' + string(4)+'" height="52" width="' + String(ll_LabelWidth) + '" '&
				+ ' name=' + ls_NewName + "_t" + ' font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_Modify = 'create compute(band=' + "detail" + ' visible="1" alignment="0" expression="" border="5" color="0" x="' + string(999999) + '" y="' + string(ll_y) + '" height="64" width="520"  name=' + ls_NewName + ' font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

			
uo_band.dw_Header.Modify( ls_ModifyText +' ' + ls_Modify) 

ls_err = ldw_Band.Modify(ls_Modify + ' ' + ls_ModifyText )
ls_err = this.Event ue_SetModify(ls_Modify + ' ' + ls_ModifyText )

if ls_err<>'' then 
	MessageBox('',ls_err + '~r~n~r~n'+ls_Modify)
else
	if as_objType = 'compute' then
		lstr_pass.s_long[1] = 2	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
		//lstr_pass.l_facility_id     = -1//-1:screen/else:export
		lstr_pass.s_string          = ""//expression
		lstr_pass.s_string_array[1] = ls_NewName//object name
		lstr_pass.s_u_dw            = ldw_Band//relative dw
		
		OpenWithParm(w_export_expression,lstr_pass)
		
		lstr_Ret = message.Powerobjectparm
		//canceled
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
//Move  x , y
is_Fields = {ls_NewName}
of_showhidegridcolumn(ls_Field , ls_Field, al_x, al_y, 'show'  )
is_Fields = ls_Field


//if as_objType = 'compute' and IsValid(lstr_Ret) and is_Compute_Label_Text <> "" then
//	st_add.Width = 1970
//	st_add.X = uo_band.X + (uo_band.Width - st_add.Width)/2
//	st_add.Y = 1500
//	st_add.TextSize = -12
	
//	st_add.Text = "Click where you want to add the computed field label."
//	st_add.visible = true
//	is_addobjectType = "text"
//	is_Compute_Label_Name = ls_NewName + "_t"
//else
	is_addobjectType = ""
	is_Compute_Label_Name = ""
	is_Compute_Label_Text = ""
//end if

of_UnSelectAllObject()
ldw_Band.of_AddorDelSingleSelect(ls_NewName,true)
of_Refresh_Object_Inforamtion()

Return 1

end function

public subroutine wf_moveobject (string as_orientation, string as_object[], long al_x);//move object
Long					ll_X, ll_Y, ll_Cycle, ll_MinX, ll_MinY, ll_TempX, ll_TempY, ll_Width, ll_Width2
String					ls_DestBand, ls_Objects[], ls_Temp, ls_MinObject, ls_Modify, ls_Modify2
Integer				li_i, li_k

String					ls_Column[], ls_Titles[], ls_Objects2[], ls_Type, ls_X, ls_Band, ls_Value
Long					ll_MaxX, ll_MaxWidth, ll_X2, ll_row, ll_ObjectX, ll_Count, ll_Find
Long					ll_PreObjectPosition, ll_NextObjectX, ll_Find2, ll_Find3, ll_Temp2

pfc_cst_u_band   	ldw_band, ldw_Header
DataStore			lds_Object

ll_Miny = 4

ldw_band = uo_Band.dw_Detail

ldw_Header =  uo_Band.dw_Header

ldw_band.of_GetObjects( ls_Objects )
ldw_Header.of_GetObjects( ls_Objects2 )

lds_Object = Create DataStore
lds_Object.DataObject = 'd_screen_design_object_atrributes'

of_unselectallobject( )

ll_MaxX = 0
For li_i = 1 To Upperbound( ls_Objects  )
	ls_X = ldw_Band.Describe( ls_Objects[li_i] + ".x" )
	If ls_X = '!' Or ls_X = '?' Or Trim( ls_X ) = '' Or Not isNumber( ls_X )  Then Continue
	
	ll_Row = lds_Object.InsertRow( 0 )
	lds_Object.SetItem( ll_Row, 'obj_name', ls_Objects[li_i] )
	lds_Object.SetItem( ll_Row, 'obj_pro', 	'x' )
	lds_Object.SetItem( ll_Row, 'obj_value', ls_X )
	lds_Object.SetItem( ll_Row, 'obj_visible',  ldw_Band.Describe( ls_Objects[li_i] + ".visible" ) )
	lds_Object.SetItem( ll_Row, 'obj_type',  ldw_Band.Describe( ls_Objects[li_i] + ".type" ) )
	lds_Object.SetItem( ll_Row, 'obj_band',  ldw_Band.Describe( ls_Objects[li_i] + ".band" ) )
	lds_Object.SetItem( ll_Row, 'obj_width',  ldw_Band.Describe( ls_Objects[li_i] + ".width" ) )
Next
//sort
lds_Object.SetSort( "obj_band  , obj_visible desc,Long(obj_value), obj_type" )
lds_Object.Sort( )

ll_Temp2 = 0
ll_TempX = 4
ls_Modify = ""
ls_Modify2 =""

ll_Count = UpperBound( as_Object )
//special column move 
If ll_Count > 0 Then
	SetPointer(  HourGlass!  )
	For li_k =1 To ll_Count
		ll_TempX = 4
		ls_Modify = ""
		ls_Modify2 =""
		ll_Find = lds_Object.Find( "obj_name='" + as_Object[ li_k ]  + "'" ,1, lds_Object.RowCount( ) )
		If ll_Find <= 0 Then
			Continue
		Else
			ll_ObjectX = Long( lds_Object.GetItemString( ll_Find, 'obj_value' ) )
			If ll_Find - 1 > 0 Then
				ll_PreObjectPosition = Long( lds_Object.GetItemString( ll_Find - 1, 'obj_value' ) ) +  Long( lds_Object.GetItemString( ll_Find - 1, 'obj_width' ) )
			End If
			If ll_Find + 1 <= lds_Object.RowCount( ) Then
				ll_NextObjectX = 	 Long( lds_Object.GetItemString( ll_Find + 1, 'obj_value' ) ) 		
			End If
			ll_MaxWidth =  Long( lds_Object.GetItemString( ll_Find, 'obj_width' ) )
			ll_Find3 = ll_Find + 1
		End If
		//
		If as_orientation = 'forward' Then
			ll_TempX =  ll_PreObjectPosition
			ll_MaxWidth = -ll_MaxWidth
		ElseIf as_orientation = 'backward' Then
			If lds_Object.GetItemString( ll_Find, 'obj_type' ) <> 'column' And   lds_Object.GetItemString( ll_Find, 'obj_type' ) <>  'compute' Then Continue
			ll_Find2 = lds_Object.Find( "obj_type in ( 'column', 'compute' ) and obj_visible = '1' and Long( obj_value ) > " + string( al_x ) , 1, lds_Object.RowCount( ) )
			If ll_Find2 > 0 Then
				If ll_Find2 - 1 > 0 Then
					ll_PreObjectPosition = Long( lds_Object.GetItemString( ll_Find2 - 1, 'obj_value' ) ) +  Long( lds_Object.GetItemString( ll_Find2 - 1, 'obj_width' ) )
				End If	
				ll_TempX = ll_PreObjectPosition
			Else
				lds_Object.SetSort( "obj_band  , obj_visible desc,Long(obj_value) desc, obj_type" )
				lds_Object.Sort( )
				ll_Find2 = lds_Object.Find( "obj_type in ( 'column', 'compute' ) and obj_visible = '1'  "  , 1, lds_Object.RowCount( ) )
				If ll_Find2 > 0 Then ll_TempX = 	 Long( lds_Object.GetItemString( ll_Find2, 'obj_value' ) )	+	 Long( lds_Object.GetItemString( ll_Find2, 'obj_width' ) )		 
				lds_Object.SetSort( "obj_band  , obj_visible desc,Long(obj_value), obj_type" )
				lds_Object.Sort( )
			End If
			
			If ll_Temp2 > 0 Then ll_TempX = ll_Temp2 
			
			ls_Modify = ls_Modify + " " + as_Object[ li_k ] + ".x=" + String( ll_tempx + 4 ) + "  " + as_Object[ li_k ]  + ".visible='1' " + as_Object[ li_k ] + ".y=" + String( ll_Miny ) + " "
			lds_Object.SetItem( ll_Find, 'obj_value' , String( ll_tempx + 4 ) )
			lds_Object.SetItem( ll_Find, 'obj_visible' , '1' )
			lds_Object.SetItem( ll_Find, 'selected' , '1' )
			
			ls_Value = ldw_Band.Describe( as_Object[ li_k ] + "_t.x" )
			If ls_Value <> '!' And ls_Value <> '?' And ls_Value<> '' Then
				ll_Find2 = lds_Object.Find( "obj_name='" + as_Object[ li_k ]  + "_t'" ,1, lds_Object.RowCount( ) )
				If ll_Find2 > 0 Then
					lds_Object.SetItem( ll_Find2, 'obj_value' , String( ll_tempx + 4 ) )
					lds_Object.SetItem( ll_Find2, 'obj_visible' , '1' )
				End If
				ls_Modify2 = ls_Modify2 + " " +  as_Object[ li_k ] + "_t.x=" + String( ll_tempx + 4 ) + "  " + as_Object[ li_k ]  + "_t.visible='1' " + as_Object[ li_k ] + "_t.y=" + String( ll_Miny ) + " "
			End If
			ll_TempX = ll_TempX +  Long( lds_Object.GetItemString( ll_Find, 'obj_width' ) ) + 8
			
			ll_ObjectX = al_X
			If ll_Temp2 > 0 Then ll_ObjectX = ll_Temp2 
			ll_Temp2 = ll_TempX
			ll_Find3 = 1
	
		End If
		//
		lds_Object.Sort( )
		For li_i = ll_Find3 To lds_Object.RowCount( )
		
			ls_Type = lds_Object.GetItemString( li_i, 'obj_type' )
			ls_Band = lds_Object.GetItemString( li_i, 'obj_band' )
			
			ll_X = Long( lds_Object.GetItemString( li_i, 'obj_value' ) )
			ll_Width = Long( lds_Object.GetItemString( li_i, 'obj_width' ) )
			
			If ll_X > ll_ObjectX Then
				If ls_Type = 'compute' Or ls_Type = 'column' Then
					ls_Temp =  lds_Object.object.obj_name[li_i]
					If as_orientation = 'backward' And   lds_Object.object.selected[li_i]  = '1' Then Continue
					lds_Object.SetItem( li_i , 'obj_value' , String( ll_tempx + 4 ) )
					
					ls_Modify = ls_Modify + " " + ls_Temp + ".x=" + String( ll_tempx )
					ls_Value = ldw_Band.Describe( ls_Temp + "_t.x" )
					If ls_Value <> '!' And ls_Value <> '?' And ls_Value<> '' Then
						ls_Modify2 = ls_Modify2 + " " +  ls_Temp + "_t.x=" + String( ll_tempx )
					End If
					ll_TempX = ll_TempX + ll_width + 8
				Else
					ls_Temp =  lds_Object.object.obj_name[li_i]
					ls_Modify = ls_Modify + " " + ls_Temp + ".x=" + String( ll_X + ll_MaxWidth )
				End If
			End If
		Next
		//
		ldw_Band.Modify ( ls_Modify )
		ldw_Header.Modify ( ls_Modify )
		this.Event ue_SetModify(ls_Modify)
		ldw_Band.Modify ( ls_Modify2 )
		ldw_Header.Modify ( ls_Modify2 ) 
		this.Event ue_SetModify(ls_Modify2)
					
	Next	//objects
	
	For li_k =1 To ll_Count
		ll_Find = lds_Object.Find( "obj_name='" + as_Object[ li_k ]  + "'" ,1, lds_Object.RowCount( ) )
		If ll_Find <= 0 Then Continue
		ls_Type = lds_Object.GetItemString( ll_Find, 'obj_type' )
		If  ls_Type = 'column' Or ls_Type = 'compute' Then
			ldw_band.of_AddOrDelSingleSelect( as_Object[ li_k ],false)
			ldw_band.of_AddorDelSingleSelect(  as_Object[ li_k ],true)
			ldw_Header.of_AddOrDelSingleSelect( as_Object[ li_k ] + "_t",false)
			ldw_Header.of_AddorDelSingleSelect(   as_Object[ li_k ] +"_t",true)
//		ElseIf ls_Type = 'text' Then
//			ldw_Header.of_AddOrDelSingleSelect(  as_Object[ li_k ] ,false)
//			ldw_Header.of_AddorDelSingleSelect(  as_Object[ li_k ] ,true)
		End If

		//properties
		If ls_Type = 'column'  or ls_Type = 'text' Or ls_Type = 'compute' Then 
			dw_Properties.SetFilter("sys_fields_field_name = '" + as_Object[ li_k ]  + "'")
			dw_Properties.Filter()
			
			if dw_Properties.RowCount() > 0 Then	dw_Properties.SetItem(1,'data_view_fields_visible','Y' )
		End If
	Next	
	dw_Properties.AcceptText()
	st_Add.Visible = False
	
Else// all move 
	For li_i = 1 To lds_Object.RowCount( )
		ls_Type = lds_Object.GetItemString( li_i, 'obj_type' )
		ls_Band = lds_Object.GetItemString( li_i, 'obj_band' )
		
		ll_X = Long( lds_Object.GetItemString( li_i, 'obj_value' ) )
		ll_Width = Long( lds_Object.GetItemString( li_i, 'obj_width' ) )
		
		If ls_Type = 'compute' Or ls_Type = 'column' Then
			ls_Temp =  lds_Object.object.obj_name[li_i]
			ls_Modify = ls_Modify + " " + ls_Temp + ".x=" + String( ll_tempx )
			ls_Value = ldw_Band.Describe( ls_Temp + "_t.x" )
			If ls_Value <> '!' And ls_Value <> '?' And ls_Value<> '' Then
				ls_Modify2 = ls_Modify2 + " " +  ls_Temp + "_t.x=" + String( ll_tempx )
			End If
			ll_TempX = ll_TempX + ll_width + 8
		End If
		
	Next
	
	ldw_Band.Modify ( ls_Modify )
	ldw_Header.Modify ( ls_Modify )
	this.Event ue_SetModify(ls_Modify)
	ldw_Band.Modify ( ls_Modify2 )
	ldw_Header.Modify ( ls_Modify2 ) 
	this.Event ue_SetModify(ls_Modify2)
End If


of_Refresh_Object_Inforamtion()

Return 





end subroutine

public subroutine of_deleteobject ();String  	ls_Name,ls_ObjName, ls_Temp, ls_Null[]
long  	ll_TotalCnts,ll_ObjSelCnts,ll_Result,ll_NotDelCnts
long  	ll_Cycle,ll_Index,ll_Cnt,ll_RtnVal = 1, ll_Pos, ll_NextBlank

pfc_cst_u_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

ls_Name = ldw_band.is_CurObj
ll_TotalCnts = UpperBound(is_CopySyntax[])


for ll_Cycle = 1 to ll_TotalCnts
	ls_Temp = is_CopySyntax[ll_Cycle]
	
	ll_Pos = Pos(ls_Temp,"name=")
	ll_NextBlank = Pos(ls_Temp," ",ll_Pos)
		
	ls_ObjName = ""
		
	ls_ObjName = Mid(ls_Temp,ll_Pos + Len("name="),ll_NextBlank - (ll_Pos + Len("name=")))
	
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Continue

	uo_band.dw_header.Modify("destroy " + ls_ObjName)
	uo_band.dw_headergroup.Modify("destroy " + ls_ObjName)
	uo_band.dw_detail.Modify("destroy " + ls_ObjName)
	uo_band.dw_trailergroup.Modify("destroy " + ls_ObjName)
	uo_band.dw_summary.Modify("destroy " + ls_ObjName)
	uo_band.dw_footer.Modify("destroy " + ls_ObjName)
	
//	of_delete_pic(lower(ls_name),true) //Delete Picture File From Database -- Jervis 11.23.2009
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

is_CutObjects = ls_Null















end subroutine

public subroutine of_setobjectposition (str_selectobj as_objects[], boolean ab_frontorback);//====================================================================
// Function: of_setobjectposition
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	adw_band
// 	as_objects[]
// 	ab_frontorback
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-04-18
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer				li_i
Boolean				lb_save
pfc_cst_u_band		adw_band

If UpperBound( as_objects ) = 0 Then Return 

For li_i = 1 To UpperBound( as_Objects )
	If Len( as_Objects[ li_i ].Fname ) > 0 Then
		istr_SelectObj[li_i].Fband.SetPosition(  as_Objects[ li_i ].Fname, "", ab_frontorback )		
		uo_band.dw_Syntax.SetPosition(  as_Objects[ li_i ].Fname, "", ab_frontorback )	
		lb_save = true
	End If	
Next

if IsValid(m_pfe_cst_contract_data_design) And lb_save then
	gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'Enabled', true)
end if











end subroutine

public function integer of_line_property_sheet (string as_object);//====================================================================
// Function: of_oval_property_sheet()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_object	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 20120427
//--------------------------------------------------------------------
//	Copyright (c) 1999-2012 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

////Modified by gavins on 20120427
str_set_properties lstr_item

lstr_item.lst_data_design = this
lstr_item.lst_menu = uo_design
lstr_item.lst_band_painter = uo_band
lstr_item.lst_code = as_Object

pfc_cst_u_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

lstr_item.lst_band = ldw_band

OpenWithParm(w_contract_other_properties,lstr_item)


Return 1
end function

public function integer of_bitmap_properties_sheet (string as_object);//====================================================================
// Function: of_oval_property_sheet()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_object	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 20120427
//--------------------------------------------------------------------
//	Copyright (c) 1999-2012 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

////Modified by gavins on 20120427
str_set_properties lstr_item

lstr_item.lst_data_design = this
lstr_item.lst_menu = uo_design
lstr_item.lst_band_painter = uo_band
lstr_item.lst_code = as_Object

pfc_cst_u_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

lstr_item.lst_band = ldw_band

OpenWithParm(w_contract_other_properties,lstr_item)


Return 1
end function

public function integer of_picture_properties_sheet (string as_object, string as_path, string as_filename);//Add by jervis -- 11.30.2009
string ls_path,ls_filename,ls_band
string ls_path_to
string ls_find
long ll_row, ll_width, ll_height, ll_x, ll_y
pfc_cst_u_band ldw_band
string ls_Modify
gf_load_dir_path() //Jervis 12.09.2010
Boolean			lb_File

If Len( as_filename ) > 0 Then//added by gavins 20120502
	ls_FileName = as_FileName
	ls_Path = as_path
	lb_File = True
Else
	if GetFileOpenName("Select File", ls_path, ls_filename, "jpg","JPEG(*.jpg;*.jpeg),*.jpg;*.jpeg,Bitmap(*.bmp),*.bmp,GIF(*.gif),*.gif") = 1 then
		lb_File = True
	Else
		lb_File = False
	End If
End If

If lb_File Then
	//Add jpeg - jervis 12.09.2010
	gf_save_dir_path(ls_filename) //Jervis 12.09.2010
	//File size less than 100K
	if filelength(ls_path) > 1024 * 200 then 
		MessageBox('Select File',"The file you selected must be less than 200K.")
		return 0
	end if
	
	//Copy file to temp local path
	if is_open_style = 'report' then   //ReportID + Object Name
		ls_filename = "R_"+string(ii_data_view) + "_" + lower(as_object) + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + mid(ls_filename,pos(ls_filename,"."))
		ls_Find = "pic_name = '" + lower(as_object) + "' and view_id = " + string(ii_data_view) + " and screen_id = 0"
	else	//ViewID + ScreenID + Object Name
		ls_filename = "S_"+string(il_data_view) + "_" + string(ii_screen_id) + "_" + lower(as_object) + "_" + string(Hour(Now())) + string(Minute(now())) + string(Second(now())) + mid(ls_filename,pos(ls_filename,"."))
		ls_Find = "pic_name = '" + lower(as_object) + "' and view_id = " + string(il_data_view) + " and screen_id = " + string(ii_screen_id)
	end if
	ls_path_to = gs_dir_path + gs_DefDirName + "\" + is_pic_path + "\" + ls_filename 
	
	gnv_appeondll.of_parsepath(ls_path_to) //Jervis 12.09.2010

	if FileCopy(ls_path,ls_path_to) <> 1 then return -1
	ll_row = ids_pic.Find(ls_find,1,ids_pic.Rowcount())
	if ll_row > 0 then
		ids_pic.SetItem(ll_row,"pic_filename",ls_filename)
		ls_Modify = as_object + ".filename ='" + ls_path_to + "'"
		ldw_band = wf_getband(is_curband)
		
		of_Set_Screen_Pictrue( ls_filename, as_object, ls_path_to ,"" ) //added by gavins 20131218
		
		//added by gavins 20120418
		p_originalsize.of_getimageoriginalsize( ls_path_to,ll_width , ll_height   )
		ls_Modify +=  " " + as_object + ".width = " + string( ll_width ) + " " + as_object + ".height = " + string( ll_height ) 
		//Modify filename 
		ldw_band.Modify(ls_Modify)
		this.event ue_SetModify(ls_Modify)
		ldw_Band.of_AddorDelSingleSelect(as_object,false)
		ldw_Band.of_AddorDelSingleSelect(as_object,true)
	else//added by gavins 20140107  
		CHOOSE CASE UPPER(is_CurBand)
			CASE 'HEADER'
				ls_Band = 'header'
			CASE 'DETAIL'
				ls_Band = 'detail'
			CASE 'SUMMARY'
				ls_Band = 'summary'
			CASE 'FOOTER'
				ls_Band = 'footer'
			CASE 'HEADERGROUP','HEADER.1'
				ls_Band = 'header.1'
			CASE 'TRAILERGROUP','TRAILER.1'
				ls_Band = 'trailer.1'
		END CHOOSE
		ldw_band = wf_getband(is_curband)
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
		ids_pic.SetItem(ll_row,"pic_name",lower(as_object))
		ids_pic.SetItem(ll_row,"pic_filename",ls_filename)
		ll_x =long( ldw_band.describe( as_object + ".x" ) )
		ll_y =long( ldw_band.describe( as_object + ".y" ) )
		ids_pic.SetItem(ll_row,"pic_x",ll_x)
		ids_pic.SetItem(ll_row,"pic_y",ll_y)
		
		//added by gavins 20120418
		p_originalsize.of_getimageoriginalsize( ls_path_to,ll_width , ll_height   )

		If ll_width = 0 Or IsNull( ll_width ) Then ll_width = 137
		If ll_height = 0 Or IsNull( ll_height )  Then ll_height = 120
		
		ids_pic.SetItem(ll_row,"pic_width",ll_width)
		ids_pic.SetItem(ll_row,"pic_height",ll_height)

		of_Set_Screen_Pictrue( ls_filename, as_object, ls_path_to, "" )//added by gavins 20131218
		ls_Modify = as_object + ".filename ='" + ls_path_to + "'"
		ls_Modify +=  " " + as_object + ".width = " + string( ll_width ) + " " + as_object + ".height = " + string( ll_height ) 
		ldw_band.Modify(ls_Modify)
		this.event ue_SetModify(ls_Modify)
		ldw_Band.of_AddorDelSingleSelect(as_object,false)
		ldw_Band.of_AddorDelSingleSelect(as_object,true)

	end if
else
	gf_save_dir_path(ls_filename) //Jervis 12.09.2010
end if
Return 1

end function

public function integer of_compute_properties_sheet (string as_object);//====================================================================
// Function: of_oval_property_sheet()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_object	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 20120427
//--------------------------------------------------------------------
//	Copyright (c) 1999-2012 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

////Modified by gavins on 20120427
str_set_properties lstr_item

lstr_item.lst_data_design = this
lstr_item.lst_menu = uo_design
lstr_item.lst_band_painter = uo_band
lstr_item.lst_code = as_Object

pfc_cst_u_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

lstr_item.lst_band = ldw_band

OpenWithParm(w_contract_compute_properties,lstr_item)


Return 1
end function

public function integer of_groupbox_properties_sheet (string as_object);////--------------------------------------------------------------------
// Arguments:
// 	value	string	as_object	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 20120427
//--------------------------------------------------------------------
//	Copyright (c) 1999-2012 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

////Modified by gavins on 20120427
str_set_properties lstr_item

lstr_item.lst_data_design = this
lstr_item.lst_menu = uo_design
lstr_item.lst_band_painter = uo_band
lstr_item.lst_code = as_Object

pfc_cst_u_band   ldw_band

ldw_band = wf_GetBand(is_CurBand)

lstr_item.lst_band = ldw_band

OpenWithParm(w_contract_groupbox_properties,lstr_item)



Return 1
end function

public function string of_get_screendataobject ();//
String				ls_DataObject =''
Long				ll_FindRow
Boolean			lb_Grid



ll_FindRow = dw_properties_dw.Find("screen_id=" + String(ii_screen_id), 1, dw_properties_dw.RowCount())
If ll_FindRow > 0 Then
	If dw_properties_dw.GetItemString( ll_FindRow, 'screen_style' ) = 'G' Then
		lb_Grid = True
	Else
		lb_Grid = False
	End If
End If
/**************************************/
If Not IsValid( ids_Screen ) Then
	ids_Screen = Create DataStore
	ids_Screen.dataobject = 'ds_contract_data_view_screens_list'  //modified by gavins 20120919
	ids_Screen.retrieve( il_data_view, ii_screen_id )
End If

ll_FindRow = ids_Screen.Find("screen_id=" + String(ii_screen_id), 1, ids_Screen.RowCount())
If ll_FindRow <= 0 Then 
	Return ''
End If
If lb_Grid Then //added by gavins 20120306 grid
	ls_DataObject = ids_Screen.GetItemString(ll_FindRow,'grid_dataobject')
Else
	ls_DataObject = ids_Screen.GetItemString(ll_FindRow,'dataobject')
End If


Return ls_DataObject
end function

public subroutine of_synchronization_toolbar (string as_name);//toolbar   status


uo_design.of_synchronization_toolbar( as_name )
end subroutine

public function string of_align_object (datastore ads_grid);//
//====================================================================
// Function: of_align_object
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ads_grid
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-06-05
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
n_cst_update_screen       ln_screen



ln_screen = create n_cst_update_screen

ln_screen.of_align_object(  uo_band.dw_header, uo_band.dw_detail, "In grid screen the x value, width value and visible property of a column and its title are forced to be the same." )

ln_screen.of_align_object(  ads_grid, "" )

Destroy( ln_screen )

Return ads_grid.Describe( "datawindow.syntax" )
end function

public subroutine of_synchronization_text (string as_text);//of_synchronization_text

uo_design.of_synchronization_text( as_text )
end subroutine

public subroutine of_autoupdatedocumentscreen (string as_objname);//====================================================================
// Function: of_autoupdatedetailscreen()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-29
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_DetailSyntax,ls_Edit_Style,ls_Visible
String	ls_Proper,ls_ProExp
String	ls_ObjType,ls_FieldName,ls_LabelName, ls_Err
long		ll_RtnVal, ll_AlwaysUpdate
Integer	li_i, li_ID[]
DataStore	lds_Screen

//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//if (ii_screen_id <> 51 and ii_screen_id <> 52 and ii_Screen_id <> 56 ) then Return
if (ii_screen_id <> 51 and ii_screen_id <> 52 ) then Return //Modified By Jay Chen 03-10-2014
//---------End Modfiied ------------------------------------------------------
if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return

ls_ObjType = uo_band.dw_Syntax.Describe(as_ObjName + ".Type")
if ls_ObjType = "column" then
	ls_FieldName = as_ObjName
	ls_LabelName = ls_FieldName + "_t"
elseif ls_ObjType = "text" then
	ls_FieldName = Left(as_ObjName,Len(as_ObjName) - 2)
	ls_LabelName = as_ObjName
else
	Return
end if

// EXCLUDE
if lower(ls_FieldName) = 'doc_from_name' then return

if Not ib_AlwaysUpdate  then //and (ls_Visible_1 = "1" or ls_Visible_2 = "1")  modified by gavins 20120611
	if ib_AlwaysUpdate then ll_AlwaysUpdate = 10 else ll_AlwaysUpdate = 0
	OpenWithParm(w_CascadeUpdateConfirm,String(ll_AlwaysUpdate) + "," + Left(ls_ObjType,1))
	ll_RtnVal = Message.DoubleParm
	if ll_RtnVal >= 10 then
		ib_AlwaysUpdate = true
	else
		ib_AlwaysUpdate = false
	end if
	if Mod(ll_RtnVal,2) <> 1 then Return
Else
	//Return //Modified By Jay Chen 03-10-2014 //(Appeon)Harry 03.19.2014 - V142 ISG-CLX
end if


SetPointer(HourGlass!)

choose Case ii_screen_id //Modified By Jay Chen 03-07-2014 Remark: add synchronize screen Search Criteria and unsynchronize when modify screen Document Browse
	case 51
		//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		//li_ID = { 52, 56 }
		//li_ID = { 52, 56,32 }
		li_ID = { 52, 56,32,59,60 }//(Appeon)Harry 05.06.2014 - V142 ISG-CLX
		//---------End Modfiied ------------------------------------------------------
	case 52
		//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		//li_ID = { 51, 56 }
		//li_ID = { 51, 56,32 }
		li_ID = { 51, 56,32,59,60 }//(Appeon)Harry 05.06.2014 - V142 ISG-CLX
		//---------End Modfiied ------------------------------------------------------
	case 56
		//li_ID = { 51, 52 }  //(Appeon)Harry 03.19.2014 - V142 ISG-CLX
end Choose

lds_Screen = Create DataStore
//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
/*
For li_i = 1 To 2
	
	ls_DetailSyntax = of_GetScreenSyntax(li_ID[li_i], is_LastSaveScreenStyle='F' )
*/
For li_i = 1 To 5  //(Appeon)Harry 05.06.2014 - V142 ISG-CLX modify 3 to 5
	//Modified By Jay Chen 03-07-2014
	if li_ID[li_i] = 56 or li_ID[li_i] = 60 then //(Appeon)Harry 05.06.2014 - V142 ISG-CLX add or li_ID[li_i] = 60 
		ls_DetailSyntax = of_GetScreenSyntax(li_ID[li_i], True)
	else
		ls_DetailSyntax = of_GetScreenSyntax(li_ID[li_i], False)
	end if
//---------End Modfiied ------------------------------------------------------
	if IsNull(ls_DetailSyntax) or Trim(ls_DetailSyntax) = "" then continue
	
	lds_Screen.dataobject = ''
	lds_Screen.Create(ls_DetailSyntax, ls_Err )
	If Len( ls_Err ) > 0 Then
		Messagebox("Auto Update DataWindow", "The Syntax is error !" + ls_Err )
		Return
	End If
	
	if ls_ObjType = "column" then
		ls_Visible = lds_Screen.Describe(ls_FieldName + ".Visible")
	else
		ls_Visible = lds_Screen.Describe(ls_LabelName + ".Visible")
	end if
	
	if (ls_Visible = "?" or ls_Visible = "!") then Return
	
	
	ls_Proper = ls_LabelName + ".Text"
	ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
	lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
	
	if ls_ObjType = "column" then
		//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		//Added By Jay Chen 03-10-2014
		if li_ID[li_i] = 32 or li_ID[li_i] = 51 or li_ID[li_i] = 52 or li_ID[li_i] = 59 then //(Appeon)Harry 05.06.2014 - V142 ISG-CLX add or li_ID[li_i] = 59 
			ls_Proper = ls_FieldName + ".tabsequence"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "0"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
		end if
		//---------End Added ------------------------------------------------------
		/*******************************************************///modified by gavins 2010518
		ls_Edit_Style = uo_band.dw_Syntax.Describe(ls_FieldName + ".Edit.Style")
		if ls_Edit_Style = "edit" then
			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".format"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
			If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = '' Then ls_ProExp = "" //Added By Jay Chen 03-07-2014
			//---------End Added ------------------------------------------------------
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
		elseif ls_Edit_Style = "editmask" then
			ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".Mask"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
		elseif ls_Edit_Style = "dddw" then
		
		
			ls_Proper = ls_FieldName + ".dddw.VscrollBar"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = '' Then ls_ProExp = "no"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.AutoHScroll"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "no"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
			//Added By Jay Chen 03-10-2014
			if li_ID[li_i] <> 56 and li_ID[li_i] <> 60 then //(Appeon)Harry 05.06.2014 - V142 ISG-CLX add and li_ID[li_i] <> 60 
				ls_Proper = ls_FieldName + ".dddw.UseAsBorder"
				ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
				If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "no"
				lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			end if
			//---------End Added ------------------------------------------------------
			
			//ls_Proper = ls_FieldName + ".dddw.UseAsBorder"
			//ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			//lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			
			ls_Proper = ls_FieldName + ".dddw.NilIsNull"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "no"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.Name"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''  Then ls_ProExp = "none"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.DataColumn"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' or trim( ls_Proper) = ''   Then ls_ProExp = "none"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.DisplayColumn"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "none"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".dddw.PercentWidth"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!'  or trim( ls_Proper) = ''  Then ls_ProExp = "0"
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
			ls_Proper = ls_FieldName + ".tag"
			ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
			If ls_ProExp = '?' or ls_ProExp  = '!' Then ls_ProExp = ""
			lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
			
		//	ls_Edit_Style = uo_band.dw_Syntax.Describe(ls_FieldName + ".Edit.Style")
		//	if ls_Edit_Style = "edit" then
		//		ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".format"
		//		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		//		lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
		//	elseif ls_Edit_Style = "editmask" then
		//		ls_Proper = ls_FieldName + "." + ls_Edit_Style + ".Mask"
		//		ls_ProExp = uo_band.dw_Syntax.Describe(ls_Proper)
		//		lds_Screen.Modify(ls_Proper + "='" + ls_ProExp + "'")
		//	end if
		end if
	end if
	
	of_SetScreenSyntax(li_ID[li_i],lds_Screen.Object.DataWindow.Syntax)
Next

ib_HasNewModify = false

SetPointer(Arrow!)

end subroutine

public subroutine of_deletepicfile ();long ll_view_id, ll_screen_id, ll_i
string ls_picname, ls_open_style, ls_filename


for ll_i = 1 to ids_picdelete.rowcount( )
	ll_view_id = ids_picdelete.getitemnumber( ll_i, 'view_id' )
	ll_screen_id = ids_picdelete.getitemnumber( ll_i, 'screen_id' )
	ls_filename =  ids_picdelete.getitemstring( ll_i, 'pic_filename' )
	ls_open_style = ids_picdelete.getitemstring( ll_i, 'pic_type' )
	ls_picname = ids_picdelete.getitemstring( ll_i, 'pic_name' )
							
	delete from conv_view_pic  where view_id = :ll_view_id and screen_id = :ll_screen_id  and pic_filename = :ls_filename and pic_type = :ls_open_style and pic_name =:ls_picname;
Next

ids_picdelete.reset( )
end subroutine

public subroutine of_delete_screen_pictrue (string as_oname);Integer				li_i
Boolean				lb_Exits

//added by gavins 20131218



For li_i = 1 To UpperBound( invo_Pictrue )
	If invo_Pictrue[li_i].is_objectname = as_oname Then
		setnull( invo_Pictrue[li_i] )
	End If
Next
 
end subroutine

public subroutine of_set_screen_pictrue (string as_filekey, string as_oname, string as_filepath, string as_copyname);//add pictrue object  added by gavins 20131218

Integer				li_i
Boolean				lb_Exits
Blob					lbl_Image
Long					ll_Handle


If FileExists( as_filepath ) Then
	ll_Handle = FileOpen( as_filepath , StreamMode!) 
	FileReadEx( ll_Handle, lbl_Image )
	FileClose( ll_Handle )
Else
	If Len( as_copyname ) > 0 Then
		For li_i = 1 To UpperBound( invo_Pictrue )
			If lower(invo_Pictrue[li_i].is_objectname) = lower(as_copyname) Then
				lbl_Image = invo_Pictrue[li_i].ibl_Image
			End If			
		Next
	Else
		MessageBox( 'Screen', 'Failure to get the picture content.' )
	End If
End If


For li_i = 1 To UpperBound( invo_Pictrue )
	If lower(invo_Pictrue[li_i].is_objectname) = lower(as_oname) Then
		 invo_Pictrue[li_i].is_filekey = as_filekey
		 invo_Pictrue[li_i].ibl_image = lbl_image
		 lb_Exits = True
	End If
	
Next

If Not lb_Exits Then
	invo_Pictrue[UpperBound( invo_Pictrue ) + 1 ] = create n_screen_pictrue
	invo_Pictrue[UpperBound( invo_Pictrue )   ].is_objectname = as_oname
	invo_Pictrue[UpperBound( invo_Pictrue )   ].is_filekey = as_filekey
	invo_Pictrue[UpperBound( invo_Pictrue )   ].ibl_image = lbl_image
End If
end subroutine

on pfc_cst_u_contract_data_design.create
this.dw_opsyntax=create dw_opsyntax
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
this.p_originalsize=create p_originalsize
this.Control[]={this.dw_opsyntax,&
this.pb_view,&
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
this.r_1,&
this.p_originalsize}
end on

on pfc_cst_u_contract_data_design.destroy
destroy(this.dw_opsyntax)
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
destroy(this.p_originalsize)
end on

event constructor;//// add by gavin on 2009-02-26
uo_design.of_set_parentobject(this)
uo_band.of_set_parent(this)
//

if Not IsValid(im_DesignMenu) then
	im_DesignMenu = Create m_Screen_Design_RMB
	im_DesignMenu.uf_Set_Parent(This)
end if

if Not IsValid(ids_SearchTemp) then ids_SearchTemp = Create DataStore
if Not IsValid(ids_SearchDevTemp) then ids_SearchDevTemp = Create DataStore
if Not IsValid(ids_Criteria) then ids_Criteria = Create DataStore
if Not IsValid(ids_Browse) then ids_Browse = Create DataStore
if not isvalid(ids_pic) then ids_pic = create datastore	//jervis -- 11.24.2009
if not isvalid(ids_detail) then ids_detail = create datastore //jervis -- 10.21.2010
if not isvalid(ids_picdelete) then ids_picdelete = create datastore

ids_pic.Dataobject = "d_conv_view_pic"
ids_pic.SetTransobject( sqlca)

ids_picdelete.Dataobject = "d_conv_view_pic" //added by gavins 20131014
ids_picdelete.SetTransobject( sqlca)


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

ids_Properties = Create datastore
ids_Properties.DataObject = 'd_contract_field_properties' 

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//Added By Jay Chen 04-03-2014
if Not IsValid(ids_document_SearchTemp) then ids_document_SearchTemp = Create DataStore
if Not IsValid(ids_document_SearchDevTemp) then ids_document_SearchDevTemp = Create DataStore
//---------End Added ------------------------------------------------------
end event

event destructor;if IsValid(im_DesignMenu) then Destroy  im_DesignMenu
if IsValid(ids_SearchTemp) then Destroy ids_SearchTemp
if IsValid(ids_SearchDevTemp) then Destroy ids_SearchDevTemp
if IsValid(ids_Criteria) then Destroy ids_Criteria
if IsValid(ids_Browse) then Destroy ids_Browse
if IsValid(ids_field_depend) then Destroy ids_field_depend
if isvalid(ids_pic) then destroy ids_pic
if isvalid(inv_filesrv) then destroy inv_filesrv
if isvalid(ids_detail) then destroy ids_detail
if isvalid(ids_field_ex) then destroy ids_field_ex  //jervis 01.26.2011

if isvalid(w_contract_field_properties) then Close(w_contract_field_properties)
If IsValid( w_contract_other_properties ) Then  Close(w_contract_other_properties)
If IsValid( w_contract_compute_properties ) Then  Close(w_contract_compute_properties)
If IsValid( w_contract_text_properties ) Then  Close(w_contract_text_properties)
If IsValid( w_contract_groupbox_properties ) Then  Close(w_contract_groupbox_properties)
If IsValid( w_contract_mul_field_properties ) Then  Close(w_contract_mul_field_properties)


end event

type dw_opsyntax from u_dw within pfc_cst_u_contract_data_design
boolean visible = false
integer x = 3602
integer y = 404
integer width = 306
integer height = 232
integer taborder = 30
end type

type pb_view from picturebutton within pfc_cst_u_contract_data_design
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

type st_2 from statictext within pfc_cst_u_contract_data_design
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

type dw_view from datawindow within pfc_cst_u_contract_data_design
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
		else
			dw_properties_dw.ResetUpdate( )
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

type dw_properties_oval from u_dw within pfc_cst_u_contract_data_design
event type long ue_retrieve ( string as_object )
boolean visible = false
integer x = 151
integer y = 1088
integer width = 997
integer height = 616
integer taborder = 70
string dataobject = "d_contract_oval_properties"
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
	if Left(ls_ProExp,1) = '"' then
		ls_ProExp = Mid(ls_ProExp,2)
	end if
	if Right(ls_ProExp,1) = '"' then
		ls_ProExp = Left(ls_ProExp,Len(ls_ProExp) - 1)
	end if
	ll_Pos = Pos(ls_ProExp,TABCHAR)
	if ll_Pos > 0 then ls_ProExp = Mid(ls_ProExp,ll_Pos + 1)
	This.SetItem(1, ls_ColName[ll_Cycle], ls_ProExp)
next

Return 1

end event

type dw_properties_text from u_dw within pfc_cst_u_contract_data_design
event type long ue_retrieve ( string as_object )
boolean visible = false
integer x = 151
integer y = 456
integer width = 997
integer height = 616
integer taborder = 20
string dataobject = "d_contract_text_properties"
end type

event type long ue_retrieve(string as_object);long 		ll_Color
String		ls_Visible, ls_VisibleExpress, ls_Color, ls_Expression, ls_SlideUp

this.Reset()
this.InsertRow(0)

is_OriTextName = as_Object

this.SetItem(1, "name", as_Object)

ls_Visible =  uo_band.dw_syntax.Describe(as_Object + ".visible") //added by gavins 20120503
If ls_Visible = '-1' Then ls_Visible = '1'
If Pos( ls_Visible, '~t' ) > 0   Then
	ls_VisibleExpress =  ls_Visible
	ls_Visible = "1"
Else
	ls_VisibleExpress = ""
End If

this.SetItem(1, "visible", ls_Visible )
this.SetItem(1, "visibleexpress", ls_VisibleExpress )

this.SetItem(1, "text", uo_band.dw_syntax.Describe(as_Object + ".text"))
this.SetItem(1, "alignment", uo_band.dw_syntax.Describe(as_Object + ".alignment"))
this.SetItem(1, "border", uo_band.dw_syntax.Describe(as_Object + ".border"))

//ll_Color = Long(uo_band.dw_syntax.Describe(as_Object + ".color"))
//this.SetItem(1, "text_color", ll_Color)
//ll_Color = Long(uo_band.dw_syntax.Describe(as_Object + ".background.color"))
//this.SetItem(1, "background_color", ll_Color)

ls_Color = uo_band.dw_syntax.Describe(as_Object + ".color")	
ls_Expression = ""
If Pos( ls_Color, '~t' ) > 0 Then 
	ls_Expression = Mid( ls_color, Pos( ls_color, '~t' ) + 1 )
	ls_Expression = Left( ls_Expression, Len( ls_Expression ) - 1 )
	ls_Color = Mid( ls_Color, 2, Pos( ls_Color, '~t' ) - 2 )
End If
ll_Color = Long( ls_Color )	
this.Setitem(1, "text_color", ll_Color)
this.Setitem(1, "fontcolorexpress", ls_Expression )


ls_Color = uo_band.dw_syntax.Describe(as_Object + ".background.color")	
ls_Expression = ""
If Pos( ls_Color, '~t' ) > 0 Then 
	ls_Expression = Mid( ls_color, Pos( ls_color, '~t' ) + 1 )
	ls_Expression = Left( ls_Expression, Len( ls_Expression ) - 1 )
	ls_Color = Mid( ls_Color, 2, Pos( ls_Color, '~t' ) - 2 )
End If
ll_Color = Long( ls_Color )	

this.Setitem(1, "backgroundcolorexpress", ls_Expression )
this.Setitem(1, "background_color", ll_Color)	



//Add font.properties  - jervis 09.06.2011
string	ls_fonts_face,ls_fonts_size,ls_fonts_bold,ls_fonts_italic,ls_fonts_underline,ls_fonts_strikeout
ls_fonts_face = uo_band.dw_syntax.Describe(as_Object + ".font.face")
this.SetItem(1,"font_face",ls_fonts_face)

ls_fonts_size = uo_band.dw_syntax.Describe(as_Object + ".font.height")
if ls_fonts_size = '?' then ls_fonts_size = '-8'
ls_fonts_size = string(Abs(long(ls_fonts_size)))
this.SetItem(1,"font_height",long(ls_fonts_size))

ls_fonts_bold = uo_band.dw_syntax.Describe(as_Object + ".font.weight")
this.SetItem(1,"font_weight",ls_fonts_bold)

ls_fonts_italic = uo_band.dw_syntax.Describe(as_Object + ".font.italic")
if ls_fonts_italic = '?' then ls_fonts_italic = '0'
this.SetItem(1,"font_italic",ls_fonts_italic)

ls_fonts_underline = uo_band.dw_syntax.Describe(as_Object + ".font.underline")
if ls_fonts_underline = '?' then ls_fonts_underline = '0'
this.SetItem(1,"font_underline",ls_fonts_underline)

ls_fonts_strikeout = uo_band.dw_syntax.Describe(as_Object + ".font.strikethrough")
if ls_fonts_strikeout = '?' then ls_fonts_strikeout = '0'
this.SetItem(1,"font_strikethrough",ls_fonts_strikeout)

	
ls_SlideUp = uo_band.dw_syntax.Describe(as_Object + ".slideup")
if ls_SlideUp = '?' then ls_SlideUp = 'no'
this.SetItem(1,"slideup",ls_SlideUp)	

if IsValid(w_contract_text_properties) then
	w_contract_text_properties.of_ShowColor()
end if

Return 1

end event

type dw_properties_dw from u_dw within pfc_cst_u_contract_data_design
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
	if IsNull(ls_titlebar_text) or Len(ls_titlebar_text) = 0 then
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
			ls_titlebar_text = Right(ls_screen_name, Len(ls_screen_name) - li_Pos)
		end if		
end choose

Return ls_titlebar_text
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

type uo_select from u_contract_select_screen within pfc_cst_u_contract_data_design
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

dw_properties_dw.Event ue_Retrieve(il_data_view_id, ii_screen_id)

//
If dw_properties_dw.GetRow( ) > 0 Then 
	is_OriginalScreenStyle = dw_properties_dw.GetItemString( dw_properties_dw.GetRow( ), 'screen_style' )
	is_LastSaveScreenStyle = is_OriginalScreenStyle
End If

SetPointer(HourGlass!)
If of_select_screen(0, ii_screen_id) < 0 Then
	//Added By Ken.Guo 02/16/2012.  restore vars
	if tv_screen.GetItem(al_oldhandle, ltvi_item) = -1 then Return 0
	tv_screen.selectitem(al_oldhandle)	
	of_SetTitle("Select Data Screen") 	
	il_CurrentScreenHandle = al_oldhandle
	ii_screen_id = ltvi_item.data	
	dw_properties_dw.Event ue_Retrieve(il_data_view_id, ii_screen_id)
End If

//added by gavins 20131218
invo_Pictrue = invo_Null

is_UnDoList = is_EmptyList

// Reset properties window data
dw_properties_text.Reset()
//dw_properties_dw.Event ue_Retrieve(il_data_view_id, ii_screen_id)
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
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_view.m_fieldproperties,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'enabled', False)
	End If
	uo_design.of_setobjectenable( false )
Else
*/
	st_1.visible = False
	If isvalid(m_pfe_cst_contract_data_design) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_view.m_fieldproperties,'enabled', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'enabled', false)
	End If
	uo_design.of_setobjectenable( true)
//End If

st_add.visible = false //jervis 09.26.2010

//Added by gavins 20120502
if isvalid(w_contract_field_properties) then Close(w_contract_field_properties)
If IsValid( w_contract_other_properties ) Then  Close(w_contract_other_properties)
If IsValid( w_contract_compute_properties ) Then  Close(w_contract_compute_properties)
If IsValid( w_contract_text_properties ) Then  Close(w_contract_text_properties)
If IsValid( w_contract_groupbox_properties ) Then  Close(w_contract_groupbox_properties)
If IsValid( w_contract_mul_field_properties ) Then  Close(w_contract_mul_field_properties)




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
	ELSE
		of_ResetUpdated( "")
	END IF
END IF

of_deletepicfile( )//added by gavins 20131014

Send(Handle(uo_band), 277, 6, 0)
Send(Handle(uo_band), 276, 6, 0)
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

type st_add from statictext within pfc_cst_u_contract_data_design
boolean visible = false
integer x = 2149
integer y = 1808
integer width = 1673
integer height = 80
integer textsize = -10
integer weight = 700
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

type st_1 from statictext within pfc_cst_u_contract_data_design
boolean visible = false
integer x = 1801
integer y = 1128
integer width = 1883
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

type uo_design from uo_contract_design_menu within pfc_cst_u_contract_data_design
integer x = 1024
integer width = 3639
integer taborder = 10
end type

on uo_design.destroy
call uo_contract_design_menu::destroy
end on

event constructor;call super::constructor;this.width = 4500
end event

type dw_fields_alias from datawindow within pfc_cst_u_contract_data_design
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

type cb_screen_properties from u_cb within pfc_cst_u_contract_data_design
boolean visible = false
integer x = 23
integer y = 1712
integer width = 736
integer height = 80
integer taborder = 30
boolean bringtotop = true
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

type st_tab from statictext within pfc_cst_u_contract_data_design
boolean visible = false
integer x = 2327
integer y = 1752
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
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

type dw_select_section from u_dw within pfc_cst_u_contract_data_design
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
borderstyle borderstyle = stylebox!
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
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_view.m_fieldproperties,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'enabled', False)
	End If
	uo_design.of_setobjectenable( false)
Else
*/
	st_1.visible = False
	If isvalid(m_pfe_cst_contract_data_design) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_view.m_fieldproperties,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'enabled', True)
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

type dw_properties from u_dw within pfc_cst_u_contract_data_design
boolean visible = false
integer y = 308
integer width = 946
integer height = 1480
integer taborder = 10
string dataobject = "d_contract_field_properties"
end type

event constructor;This.of_SetUpdateable(False)
This.of_SetTransObject( SQLCA )
end event

type st_back from statictext within pfc_cst_u_contract_data_design
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

type uo_band from pfc_cst_u_band_painter within pfc_cst_u_contract_data_design
integer x = 1033
integer y = 276
integer width = 3634
integer height = 1668
integer taborder = 20
end type

on uo_band.destroy
call pfc_cst_u_band_painter::destroy
end on

type st_right from statictext within pfc_cst_u_contract_data_design
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

type r_1 from rectangle within pfc_cst_u_contract_data_design
integer linethickness = 4
long fillcolor = 33551856
integer x = 27
integer y = 36
integer width = 969
integer height = 212
end type

type p_originalsize from uo_image_tool within pfc_cst_u_contract_data_design
integer x = 265
integer y = 824
end type

