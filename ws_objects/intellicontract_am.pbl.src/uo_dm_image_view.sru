$PBExportHeader$uo_dm_image_view.sru
forward
global type uo_dm_image_view from u_base
end type
type ole_scan from olecustomcontrol within uo_dm_image_view
end type
type ole_ocr from olecustomcontrol within uo_dm_image_view
end type
type ole_admin from olecustomcontrol within uo_dm_image_view
end type
type st_v from u_st_splitbar within uo_dm_image_view
end type
type uo_toolbar from uo_dm_image_toolbar_ic within uo_dm_image_view
end type
type st_doc from statictext within uo_dm_image_view
end type
type st_1 from statictext within uo_dm_image_view
end type
type ole_thumbnail from olecustomcontrol within uo_dm_image_view
end type
type ole_edit from olecustomcontrol within uo_dm_image_view
end type
type ole_edit_work from olecustomcontrol within uo_dm_image_view
end type
end forward

global type uo_dm_image_view from u_base
integer width = 3749
integer height = 1764
long backcolor = 33551856
string text = "none"
long picturemaskcolor = 536870912
event type integer ue_load_image ( string as_filename )
event type integer ue_load_image2 ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
event ue_annotationtoolselection ( string as_annotationtype )
event ue_burninannotations ( )
event ue_del_thumbs ( )
event ue_delete_image_page ( )
event ue_draw_text_zone ( )
event ue_image_copy ( )
event ue_image_cut ( )
event ue_image_paste ( )
event ue_ocr ( )
event ue_ocr_all ( )
event ue_redo ( )
event ue_remove_all_ocr_zones ( )
event ue_rotate_all_pages ( integer al_index )
event ue_rotatepage ( long al_index )
event ue_setthumbsize ( )
event ue_show_anotations ( integer al_index )
event ue_showannotationtoolpalette ( )
event ue_straighten_page ( )
event ue_undo ( )
event ue_show_ocr_zones ( )
event ue_showattribsdialog ( )
event ue_rmbmenu ( string as_menutype )
event type integer ue_save ( )
event ue_delete_image_object ( )
event ue_do ( string as_action )
event ue_scan ( )
event ue_draw_picture_zone ( )
event ue_set_security ( boolean ab_can_modify )
event ue_print ( )
ole_scan ole_scan
ole_ocr ole_ocr
ole_admin ole_admin
st_v st_v
uo_toolbar uo_toolbar
st_doc st_doc
st_1 st_1
ole_thumbnail ole_thumbnail
ole_edit ole_edit
ole_edit_work ole_edit_work
end type
global uo_dm_image_view uo_dm_image_view

type variables
PROTECTED:

OLEObject  iole_object

n_cst_dm_utils inv_dm_utils
n_cst_image_functions inv_image_func

Long il_doc_id
Long il_ocx_page
Long il_ocx_width
Long il_ocx_height
Long il_ocx_left
Long il_ocx_top
Long il_drag_from_x
Long il_drag_from_y

Dec{1} idc_revision
Dec  idc_zoom

String is_doc_ext, is_doc_name, is_doc_type
String is_LocalFileName
string is_revision_control
String is_viewstyle = 'thumbpage'
String is_from_module //included in module of - Alfee 05.19.2008

//boolean ib_default_printer = true
Boolean  ib_pallet_vis = FALSE
Boolean  ib_Annotations_visable = TRUE
//boolean  ib_NonOCRZones_visable=true
Boolean  ib_readonly = FALSE //Is current image can be modified? 
Boolean  ib_show_magnifier = FALSE
Boolean  ib_draging = FALSE
Boolean  ib_candrag = FALSE
Boolean  ib_initialized=false
//IF just scan to a new page, the imageModified property is still false. Add this instance variable to record it.
Boolean  ib_JustScaned=false

end variables

forward prototypes
public subroutine of_scroll (string as_direction)
public subroutine of_set_scroll ()
public subroutine of_set_pagetext (string as_text)
public subroutine of_set_zoom (integer ai_percent)
public subroutine of_set_zoomtext (string as_text)
public subroutine of_set_zoom (string as_action)
public function integer of_bind_all (string as_filename)
public subroutine of_set_viewstyle (string as_style)
public function boolean of_is_annotation_selected ()
public function integer of_goto_thumbpage ()
public function integer of_show_blankimage ()
public function integer of_open_localfile (string as_filename)
public function boolean of_ismodified ()
public function integer of_initialize (long al_doc_id, decimal adc_revision, string as_doc_ext)
public function decimal of_get_revision ()
private subroutine of_menu_security_cascade (ref menu am_parent, boolean ab_enabled)
public function integer of_initialize (long al_doc_id, string as_doc_ext)
public function integer of_set_module (string as_module)
public function integer of_set_readonly ()
public subroutine of_reset_registry ()
public function integer of_set_readonly (boolean ab_readonly)
public function integer of_initialize (string as_doc_name, string as_doc_ext)
end prototypes

event type integer ue_load_image(string as_filename);//////////////////////////////////////////////////////////////////////
// $<event>ue_load_image()
// $<arguments>
//		string	as_filename		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
int  li_ret

f_showwait("Opening the selected image...")

ib_initialized = false
li_ret = of_open_localfile(as_FileName)
IF li_ret < 0 THEN 
	return -1
END IF

ib_initialized = true

return 1

end event

event type integer ue_load_image2(long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<event>ue_load_image2()
// $<arguments>
//		long   	al_doc_id   		
//		decimal	adc_revision		
//		string 	as_doc_ext  		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

int  li_ret

f_showwait("Opening the selected image...")

ib_initialized = false

of_initialize( al_doc_id, adc_revision, as_doc_ext )

is_LocalFileName = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
IF NOT FileExists(is_LocalFileName) THEN
	of_show_blankimage( )
	return -1
END IF
try
li_ret = of_open_localfile(is_LocalFileName)
IF li_ret < 0 THEN 
	return -1
END IF
catch(throwable th)
	messagebox('Error','Failed to open file due to '+th.text)
end try

ib_initialized = true

return 1


end event

event ue_annotationtoolselection(string as_annotationtype);//////////////////////////////////////////////////////////////////////
// $<event>ue_annotationtoolselection()
// $<arguments>
//		string	as_annotationtype		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


//inv_image_func.of_annotationtoolselection( )
//inv_image_func.of_annotationtoolselection(ole_edit,as_annotationtype )
uo_toolbar.event ue_set_mousetype(as_annotationtype)
end event

event ue_burninannotations();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if messagebox('Make Annotations Permanent','Are you sure you want to make annotations permanent?',question!,yesno!,2)= 1 then 
   //inv_image_func.of_BurnInAnnotations(ole_edit,0,0)
	ole_edit.object.BurnInAnnotations(1, 2)
end if
end event

event ue_del_thumbs();
//we_del_thumbs
//openwithparm(w_contract_delete_thums,this)
end event

event ue_delete_image_page();/******************************************************************************************************************
**  [PUBLIC]   : Delete the selected thumbnails
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 10 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if messagebox('Delete Pages','Are you sure you want to delete the selected page(s)?',question!,yesno!,2 ) = 1 then
	inv_image_func.of_delete_pages( ole_thumbnail, ole_edit, ole_edit_work, ole_admin ) //Alfee 09.19.2008
	//inv_image_func.of_editactionitem(  ole_edit, 7, ole_thumbnail,  ole_admin,ole_ocr )
	of_scroll('prior')		

	//Reset registered datetime of the document - Alfee 07.28.2008 
	of_reset_registry()	
end if 

end event

event ue_draw_text_zone();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 11 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



//inv_image_func.of_tool_item(4, ole_edit, ole_ocr, ole_admin)
inv_image_func.of_tool_item(2, ole_edit, ole_ocr, ole_admin)
end event

event ue_image_copy();//////////////////////////////////////////////////////////////////////
// $<event>ue_image_copy()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


inv_image_func.of_editactionitem(ole_edit, 1, ole_thumbnail, ole_admin,ole_ocr)
end event

event ue_image_cut();//////////////////////////////////////////////////////////////////////
// $<event>ue_image_cut()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////



inv_image_func.of_editactionitem(ole_edit, 0, ole_thumbnail, ole_admin,ole_ocr)
end event

event ue_image_paste();//////////////////////////////////////////////////////////////////////
// $<event>ue_image_paste()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////



inv_image_func.of_editactionitem(ole_edit, 4, ole_thumbnail, ole_admin,ole_ocr)
end event

event ue_ocr();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 15 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



//if ll_current_row < 1 then 
//	messagebox('No data', 'No requirement selected. Please select a requirement' )
//	return 
//end if 

try 
	
inv_image_func.of_tool_item(0, ole_edit, ole_ocr, ole_admin)

catch (runtimeerror rte)
end try 

end event

event ue_ocr_all();
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
**  Created By	: Michael B. Skinner 15 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/





//if ll_current_row < 1 then 
//	messagebox('No data', 'No requirement selected. Please select a requirement' )
//	return 
//end if 
//
try
inv_image_func.of_tool_item(11, ole_edit, ole_ocr, ole_admin)

catch (runtimeerror rte)
end try 

end event

event ue_redo();//////////////////////////////////////////////////////////////////////
// $<event>ue_redo()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////



try
	ole_edit.object.Redo()
catch (runtimeerror rte)
end try 

end event

event ue_remove_all_ocr_zones();/******************************************************************************************************************
**  [PUBLIC]   : ue_Remove_All_OCR_Zones
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 11 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



try 
if messagebox('Remove All Ocr Zones', 'Are you sure you want to remove all OCR zones?',question!,YesNo!,2) = 1 then
  inv_image_func.of_tool_item(5, ole_edit, ole_ocr, ole_admin)
end if 

catch (runtimeerror rte)
end try 

end event

event ue_rotate_all_pages(integer al_index);//////////////////////////////////////////////////////////////////////
// $<event>ue_rotate_all_pages()
// $<arguments>
//		integer	al_index		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

try 
	inv_image_func.of_rotate_all_pages(al_index,ole_edit, ole_thumbnail)

catch (runtimeerror rte)
end try 

end event

event ue_rotatepage(long al_index);//////////////////////////////////////////////////////////////////////
// $<event>ue_rotatepage()
// $<arguments>
//		long	al_index		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

ole_thumbnail.Visible = true
inv_image_func.of_RotatePage( al_index, ole_edit, ole_thumbnail)
end event

event ue_setthumbsize();//////////////////////////////////////////////////////////////////////
// $<event>ue_setthumbsize()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


  inv_image_func.of_setthumbsize(ole_thumbnail )
end event

event ue_show_anotations(integer al_index);//////////////////////////////////////////////////////////////////////
// $<event>ue_show_anotations()
// $<arguments>
//		integer	al_index		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


 inv_image_func.of_show_anotations( al_index,ole_edit)
 IF al_index = 1 THEN//Hide
 	ib_Annotations_visable = false
 ELSE
	//Hide all Annotations
	ib_Annotations_visable=true
 END IF
 
end event

event ue_showannotationtoolpalette();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 09 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


try
//	if il_pallet_vis then 
//	  ole_edit.object.HideAnnotationToolPalette()
//   end if
	ole_edit.object.ShowAnnotationToolPalette()
	ib_pallet_vis = true
catch (runtimeerror rte)
//	il_pallet_vis = false
//	event ue_showannotationtoolpalette( )
end try
end event

event ue_straighten_page();//////////////////////////////////////////////////////////////////////
// $<event>ue_straighten_page()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


inv_image_func.of_straighten_page(ole_edit)
end event

event ue_undo();//////////////////////////////////////////////////////////////////////
// $<event>ue_undo()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


try
	ole_edit.object.Undo()
catch (runtimeerror ret)
end try
end event

event ue_show_ocr_zones();//////////////////////////////////////////////////////////////////////
// $<event>ue_show_ocr_zones()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


try 
  inv_image_func.of_tool_item(4, ole_edit, ole_ocr, ole_admin)

catch (runtimeerror rte)
end try 

end event

event ue_showattribsdialog();//////////////////////////////////////////////////////////////////////
// $<event>ue_showattribsdialog()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
iole_object.ShowAttribsDialog(0)


end event

event ue_rmbmenu(string as_menutype);//////////////////////////////////////////////////////////////////////
// $<event>ue_rmbmenu()
// $<arguments>
//		string	as_menutype		: Indicate the kind menu will be displayed.
// $<returns> (None)
// $<description>Poppup the right mouse button menu.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.26.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

IF not ib_initialized THEN return

m_dm_image_tool    lm_menu
boolean	lb_frame
window	lw_parent
window	lw_frame
window	lw_sheet
window	lw_childparent



// Determine parent window for PointerX, PointerY offset
of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = child! then
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
		if lw_parent.windowtype = child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 
end if

// Create popup menu
lm_menu = create m_dm_image_tool
lm_menu.of_setparent( this)
//IF ib_pallet_vis THEN
//	lm_menu.m_image.m_Annotations.m_showannotationtoolpalette.text='Hide Annotation Tool Palette'
//ELSE
//	lm_menu.m_image.m_Annotations.m_showannotationtoolpalette.text='Show Annotation Tool Palette'
//END IF
int li

CHOOSE CASE as_menutype
	CASE 'tools'
		IF ib_Annotations_visable THEN
			lm_menu.m_image.m_Annotations.m_5.text = 'Hide all Annotations'
		ELSE
			lm_menu.m_image.m_Annotations.m_5.text = 'Show all Annotations'
		END IF
		//messagebox('',ib_readonly)
		IF ib_readonly THEN
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_4,'enabled', false)//Select Annotations
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_6,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_7,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_8,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_showannotationtoolpalette,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_9,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_10,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_11,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_12,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_13,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_14,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_15,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_16,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_17,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_18,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_initials,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_1,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_24,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_48,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_Annotations.m_50,'enabled', false)
		
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_scan,'enabled', false)
			//of_menu_security_cascade( lm_menu.m_image.m_page, false)//APB does not support
			gnv_app.of_modify_menu_attr( lm_menu.m_image.m_page,'enabled', false)
		END IF
		
		lm_menu.m_image.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
		
	CASE 'selection'
		IF ib_readonly THEN
			gnv_app.of_modify_menu_attr( lm_menu.m_SelectionProperty.m_cut1,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_SelectionProperty.m_clear0,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_SelectionProperty.m_paste0,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_SelectionProperty.m_crop,'enabled', false)
		END IF
		lm_menu.m_selectionproperty.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
	CASE 'annotation'
		IF of_is_annotation_selected() THEN
			gnv_app.of_modify_menu_attr( lm_menu.m_annotationproperty.m_cut0,'enabled', not ib_readonly)
			gnv_app.of_modify_menu_attr( lm_menu.m_annotationproperty.m_clear,'enabled', not ib_readonly)
			//lm_menu.m_annotationproperty.m_linkto.enabled = not ib_readonly
			//lm_menu.m_annotationproperty.m_properties.enabled = not ib_readonly
		END IF
		lm_menu.m_annotationproperty.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
	CASE 'thumbnail'
		IF ib_readonly THEN
			gnv_app.of_modify_menu_attr( lm_menu.m_thumbproperty.m_insertblankpage,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_thumbproperty.m_appendblankpage,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_thumbproperty.m_deletepage,'enabled', false)
		END IF
		lm_menu.m_thumbproperty.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
	CASE 'page'
		IF ib_readonly THEN
			gnv_app.of_modify_menu_attr( lm_menu.m_pageproperty.m_paste1,'enabled', false)
			gnv_app.of_modify_menu_attr( lm_menu.m_pageproperty.m_deletepages,'enabled', false)
		END IF
		lm_menu.m_pageproperty.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
END CHOOSE

destroy lm_menu



end event

event type integer ue_save();//////////////////////////////////////////////////////////////////////
// $<event>ue_save()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
int  li_ret
boolean lb_newVersion=false
datetime ldt_modify_date 
str_add_audit lstr_add_audit
String	ls_Rtn

IF ib_readonly THEN
	messagebox('Save Image','The current image can not be modified. Please verify if you have entire access rights or it is a history version.',exclamation!)
	return 0
END IF
IF is_revision_control<>'1' THEN
	li_ret = Messagebox("Save Image", "Do you want to start version control?", Question!, YesNo!, 1)
	IF li_ret = 1 THEN
		lb_newVersion = true
	ELSE
		lb_newVersion = false
	END IF
END IF
IF not lb_newVersion THEN
	IF not of_ismodified( ) THEN
		messagebox('Save Image','The current image has not been modified.',exclamation!)
		return 0
	END IF
END IF

ldt_modify_date = DateTime(Today(), Now())

ib_JustScaned = false//Restore it to false

Try
	IF is_revision_control = '1' or lb_newVersion THEN
		
		idc_revision = inv_dm_utils.of_newversion( idc_revision )
		is_Localfilename = inv_dm_utils.of_generate_tempname( il_doc_id, idc_revision,is_doc_ext)
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-14 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(is_Localfilename)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			Return -1
		end if

		//---------------------------- APPEON END ----------------------------
		try
			ole_edit.object.SaveAs(is_Localfilename,1,1,1,0,false )
		catch(throwable th1)
			messagebox('Error','Failed to save current image due to '+th1.text,exclamation!)
			return -1
		end try
		
		gnv_appeondb.of_startqueue( )
	
		// Insert new record of image to the DB
		Insert Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date)
		Values( :il_doc_id, :idc_revision, :is_doc_ext, :ldt_modify_date );
			
		// Set check out status to record
		Update Ctx_am_document
		Set 	revision = :idc_revision,
				revision_control = '1',
				checkout_by = '', 
				checkout_date = null, 
				checkout_status = '0'
		Where doc_id = :il_doc_id;

		Commit;
		
		gnv_appeondb.of_commitqueue( )
		
	
		of_open_localfile( is_Localfilename)
		st_doc.text = "Document:"+is_doc_name+'('+string(idc_revision,'##0.0')+')'
		is_revision_control = '1'
	ELSE
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-15 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			Return -1
		end if
		//---------------------------- APPEON END ----------------------------
		ole_edit.object.Save()
		
		Update Ctx_am_doc_image
		Set 	modify_date=:ldt_modify_date
		Where doc_id = :il_doc_id;

		Commit;
	END IF

	li_ret = inv_dm_utils.of_upload_file( il_doc_id, idc_revision, is_Localfilename)
	
	lstr_add_audit.doc_id = il_doc_id
	lstr_add_audit.revision = idc_revision
	lstr_add_audit.doc_ext = is_doc_ext
	lstr_add_audit.action = "Modified"
	li_ret = inv_dm_utils.of_add_audit_trail( lstr_add_audit )
	
	//Save the latest update date of the current file in Registry
	inv_dm_utils.of_updateregistry(il_doc_id, idc_revision, is_doc_ext, ldt_modify_date)	

	return li_ret
CATCH(Throwable th)
	messagebox('Save','Failed to save current image due to '+th.text)
	return -1
END TRY

return 1
end event

event ue_delete_image_object();//////////////////////////////////////////////////////////////////////
// $<event>ue_delete_image_object()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
 inv_image_func.of_editactionitem(  ole_edit, 5, ole_thumbnail,  ole_admin,ole_ocr )

end event

event ue_do(string as_action);//////////////////////////////////////////////////////////////////////
// $<event>ue_do()
// $<arguments>
//		string	as_action		Which Action to do
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
TRY
	CHOOSE CASE as_action
		CASE 'Annotation Cut','Selection Cut'
			THIS.EVENT ue_image_cut( )
		CASE 'Annotation Copy','Selection Copy'
			THIS.EVENT ue_image_copy( )
		CASE 'Annotation Clear','Selection Clear'
			THIS.EVENT ue_delete_image_object( )
		CASE 'Annotation Link To'
			IF of_is_annotation_selected( ) THEN
				ole_edit.Object.ShowAttribsDialog(99)
			END IF
		CASE 'Annotation Properties'
			IF of_is_annotation_selected( ) THEN
				ole_edit.Object.ShowAttribsDialog()
			END IF
		CASE 'Thumbnail Insert Blank Page'
			inv_image_func.of_insert_blank_page( ole_thumbnail, ole_edit, ole_edit_work,ole_admin, iole_object.page,'Insert')
			of_scroll('refresh')
			of_reset_registry() //Reset registered datetime of the document - Alfee 07.28.2008 
		CASE 'Thumbnail Append Blank Page'
			inv_image_func.of_insert_blank_page( ole_thumbnail, ole_edit, ole_edit_work,ole_admin, iole_object.page,'Append')
			of_scroll('last')
			of_reset_registry() //Reset registered datetime of the document - Alfee 07.28.2008 			
		CASE 'Thumbnail Show Page'
			of_goto_thumbpage( )
		CASE 'Thumbnail Copy Page','Page Copy'
			inv_image_func.of_editactionitem(ole_edit, 3, ole_thumbnail, ole_admin,ole_ocr)
		CASE 'Thumbnail Delete Page'
			THIS.EVENT ue_delete_image_page( )
			of_reset_registry() //Reset registered datetime of the document - Alfee 07.28.2008 
//		CASE 'Thumbnail Print Page'//Reduplicate
//			ole_admin.object.ShowPrintDialog()
//		CASE 'Thumbnail Properties'//Reduplicate
//			iole_object.ShowPageProperties(NOT ib_edit_right)
		CASE 'Thumbnail Refresh'
			ole_thumbnail.object.refresh()
		CASE 'Thumbnail Size'
			inv_image_func.of_setthumbsize( ole_thumbnail)
		CASE 'Selection Copy As Text'
			inv_image_func.of_editactionitem(ole_edit, 2, ole_thumbnail, ole_admin,ole_ocr)
		CASE 'Selection Paste','Page Paste'
			THIS.EVENT ue_image_paste()
		CASE 'Selection Crop'
			//inv_image_func.of_editactionitem(ole_edit, 6, ole_thumbnail, ole_admin,ole_ocr)
			IF il_ocx_height> 0 and il_ocx_width >0 THEN
				iole_object.crop(il_ocx_left,il_ocx_top,il_ocx_width,il_ocx_height)
			END IF
		CASE 'Zoom to Selection'
			iole_object.ZoomToSelection()
			of_set_zoom( -1)
//		CASE 'Page Copy'//Reduplicate
//			inv_image_func.of_editactionitem(ole_edit, 3, ole_thumbnail, ole_admin,ole_ocr)
//		CASE 'Page Paste'//Reduplicate
//			this.event ue_image_paste()
		CASE 'Page Clear'
			THIS.EVENT ue_delete_image_page( )
		CASE 'Page Print','Thumbnail Print Page'
			//--------Begin Modified by  Nova 06.28.2010------------------------
			//ole_admin.object.ShowPrintDialog()
			IF AppeonGetClientType() = 'PB' THEN
				TRY
					ole_admin.Object.ShowPrintDialog()
				Catch (RuntimeError re )
					//MessageBox("RuntimeError",re.Text)
					RETURN
				END TRY
				ole_edit.Object.PrintImage(ole_admin.Object.PrintStartPage,ole_admin.Object.PrintEndPage,ole_admin.Object.PrintOutputFormat)
			ELSEIF AppeonGetClientType() = 'WEB' THEN
				ole_edit.Object.PrintImage(ole_admin.Object.PrintStartPage,ole_admin.Object.PrintEndPage,ole_admin.Object.PrintOutputFormat)
			END IF
			//--------End Modified --------------------------------------------
			ChangeDirectory(gs_current_path) //Alfee 09.19.2008
		CASE 'Page Zoom In'
			uo_toolbar.EVENT ue_zoom('+')
		CASE 'Page Zoom Out'
			uo_toolbar.EVENT ue_zoom('-')
		CASE 'Page Fit To Height'
			of_set_zoom( 'Fit to Height')
		CASE 'Page Fit To Width'
			of_set_zoom( 'Fit to Width')
		CASE 'Page Best Fit'
			of_set_zoom( 'Best Fit')
		CASE 'Page Properties', 'Thumbnail Properties'
			iole_object.ShowPageProperties(ib_readonly)
		CASE ELSE
			MessageBox('uo_dm_image_view.ue_do','Unregistered action code:'+as_action)
	END CHOOSE
Catch(throwable th)
END TRY

end event

event ue_scan();//////////////////////////////////////////////////////////////////////
// $<event>ue_scan()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
String ls_ScanFileName

ls_ScanFileName = inv_dm_utils.of_generate_tempname( il_doc_id, idc_revision, 'scan'+string(now(),'hhmmssfff')+'.tif')
ole_scan.object.DestImageControl = 'ole_edit_work'
ole_edit_work.object.imagecontrol = 'ole_edit_work'
IF idc_zoom> 0 THEN
	ole_edit_work.object.zoom = idc_zoom
	ole_scan.object.zoom = idc_zoom
END IF

//inv_image_func.of_setup_scan( ole_scan, ls_ScanFileName,1)
IF inv_image_func.of_setup_scan( ole_scan, ls_ScanFileName,1) = -1 THEN RETURN //Alfee 04.24.2008
inv_image_func.of_insert_page( ole_thumbnail,ole_edit, ole_edit_work, ole_admin,iole_object.page,'append', ls_ScanFileName)
//iole_object.imagemodified = true//ImageModified is ReadOnly
ib_JustScaned = true

of_scroll('last')

//Reset registered datetime of the document - Alfee 07.28.2008 
of_reset_registry()


end event

event ue_draw_picture_zone();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 11 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



inv_image_func.of_tool_item(3, ole_edit, ole_ocr, ole_admin)
end event

event ue_set_security(boolean ab_can_modify);//////////////////////////////////////////////////////////////////////
// $<event>ue_set_security()
// $<arguments>
//		value	boolean	ab_can_modify		
// $<returns> 
// $<description>In this  event, set user security for current image.
// $<description>You can only set the instance variable ib_readonly here.
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
ib_readonly = not ab_can_modify
end event

event ue_print();//////////////////////////////////////////////////////////////////////
// $<event>ue_print()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.31.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
//ole_admin.object.ShowPrintDialog()
this.event ue_do("Page Print")
end event

public subroutine of_scroll (string as_direction);//////////////////////////////////////////////////////////////////////
// $<function>of_scroll()
// $<arguments>
//		string	as_direction		
// $<returns> (none)
// $<description>Scroll to other page.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
integer li, li_OldPage, li_scroll

//IF iole_object.imagemodified THEN
IF iole_object.imagemodified AND NOT ib_readonly THEN	//Alfee 04.28.2008
	li = messagebox('Saving','The current page has been modified. Do you want to save changes before navigating to another page?',question!,yesnocancel!,1)
	IF li=1 THEN
		//-------Begin Modified by Alfee on 05.19.2008--------
		IF is_from_module = 'DLP' AND IsValid(w_sheet_ctx_doc_painter) THEN //Called from document library painter
			w_sheet_ctx_doc_painter.event pfc_save()	
		ELSEIF this.event ue_save() < 1 THEN 
			RETURN
		END IF
		//IF this.event ue_save() < 1 THEN return
		//--------End Modfied ---------------------------------
	ELSEIF li  = 3 THEN 
		return
	END IF
END IF
li_OldPage = iole_object.page
CHOOSE CASE lower(as_direction)
	CASE 'first'
		iole_object.page=1
	CASE 'prior'
		IF iole_object.page > 1 THEN
			iole_object.page = iole_object.page - 1
		END IF
	CASE 'next'
		IF iole_object.page < iole_object.pagecount THEN
			iole_object.page = iole_object.page+1
		END IF
	CASE 'last'
		iole_object.page = iole_object.pagecount
	CASE ELSE//Refresh or Number
		IF isnumber(as_direction) THEN
			iole_object.page = integer(as_Direction)
		END IF
END CHOOSE

iole_object.Display()
IF idc_zoom > 0 THEN
	iole_object.zoom = idc_zoom
END IF

FOR li=1 to ole_thumbnail.object.ThumbCount 
	ole_thumbnail.object.ThumbSelected(li,li=iole_object.page)
NEXT

//Scroll thumbnail view
IF abs(iole_object.page - li_OldPage)=1 THEN
	li_scroll = 1
ELSE
	li_scroll = 0
END IF
FOR li = 1 to abs(iole_object.page - li_OldPage)
	IF li_OldPage > iole_object.page THEN
		ole_thumbnail.object.ScrollThumbs(1, li_scroll)
	ELSE
		ole_thumbnail.object.ScrollThumbs(0, li_scroll)
	END IF
NEXT


of_set_scroll( )
end subroutine

public subroutine of_set_scroll ();//////////////////////////////////////////////////////////////////////
// $<function>of_set_scroll()
// $<arguments>(None)
// $<returns> (none)
// $<description>Set scroll button enabled property accroding to current page number and total apge count.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

IF iole_object.pagecount < 2 THEN
	uo_toolbar.em_page.text=string(iole_object.pagecount)
	uo_toolbar.cb_first.enabled = false
	uo_toolbar.cb_prior.enabled = false
	uo_toolbar.cb_next.enabled = false
	uo_toolbar.cb_last.enabled = false
ELSEIF iole_object.page=1 THEN
	uo_toolbar.em_page.text=string(iole_object.page)
	uo_toolbar.cb_first.enabled = false
	uo_toolbar.cb_prior.enabled = false
	uo_toolbar.cb_next.enabled = true
	uo_toolbar.cb_last.enabled = true
ELSEIF iole_object.page<iole_object.pagecount THEN
	uo_toolbar.em_page.text=string(iole_object.page)
	uo_toolbar.cb_first.enabled = true
	uo_toolbar.cb_prior.enabled = true
	uo_toolbar.cb_next.enabled = true
	uo_toolbar.cb_last.enabled = true
ELSE
	uo_toolbar.em_page.text=string(iole_object.page)
	uo_toolbar.cb_first.enabled = true
	uo_toolbar.cb_prior.enabled = true
	uo_toolbar.cb_next.enabled = false
	uo_toolbar.cb_last.enabled = false
END IF

uo_toolbar.st_pages.text = 'Page '+string(iole_object.page)+" of "+string(iole_object.pagecount)
end subroutine

public subroutine of_set_pagetext (string as_text);//////////////////////////////////////////////////////////////////////
// $<function>of_set_pagetext()
// $<arguments>
//		string	as_text		
// $<returns> (none)
// $<description>Set em_page text. It will be invoked using POST keyword.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
uo_toolbar.em_page.text = as_text
end subroutine

public subroutine of_set_zoom (integer ai_percent);//////////////////////////////////////////////////////////////////////
// $<function>of_set_zoom()
// $<arguments>
//		integer	ai_percent		
// $<returns> (none)
// $<description>Set zoom percent
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
IF ai_percent=-1 THEN
	dec{2} ldc_percent
	ldc_percent=iole_object.zoom
	uo_toolbar.ddlb_zoom.text = string(ldc_percent)+'%'
ELSE
	uo_toolbar.ddlb_zoom.text = string(ai_percent)+'%'
	iole_object.zoom = ai_percent
	iole_object.refresh()
END IF
idc_zoom = iole_object.zoom

uo_toolbar.pb_zoomout.enabled = idc_zoom > 5
uo_toolbar.pb_zoomin.enabled = idc_zoom < 6500
	
end subroutine

public subroutine of_set_zoomtext (string as_text);//////////////////////////////////////////////////////////////////////
// $<function>of_set_zoomtext()
// $<arguments>
//		string	as_text		
// $<returns> (none)
// $<description>When user input an invalid percent, it will restore the old zoom percent.
// $<description>This function must be invoked using POST keyword.
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
IF RightA(as_text,1)<>'%' THEN
	as_text+='%'
END IF
uo_toolbar.ddlb_zoom.text = as_text

end subroutine

public subroutine of_set_zoom (string as_action);//////////////////////////////////////////////////////////////////////
// $<function>of_set_zoom()
// $<arguments>
//		string	as_action
// $<returns> (none)
// $<description>Set zoom percent
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
string  ls_percent

ls_percent = lower(trim(as_action))
CHOOSE CASE ls_percent
	CASE'best fit'
		iole_object.fitto(0,true)
		post of_set_zoom(-1)
	CASE 'fit to width'
		iole_object.fitto(1,true)
		post of_set_zoom(-1)
	CASE 'fit to height'
		iole_object.fitto(2,true)
		post of_set_zoom(-1)
	CASE ELSE
		IF RightA(ls_percent,1)='%' THEN
			ls_percent = LeftA(ls_percent,LenA(ls_percent) - 1)
		END IF
		IF not isnumber(ls_percent) THEN
			post of_set_zoomtext( string(idc_zoom))
			return
		END IF
		dec{2} ldc_zoom
		
		ldc_zoom = dec(ls_percent)
		IF ldc_zoom < 5 OR ldc_zoom> 6500 THEN
			post of_set_zoomtext( string(idc_zoom))
			messagebox('Imaging','Please enter a zoom factor between 5% and 6500%.')
			return
		END IF
		
		of_set_zoom(ldc_zoom)
END CHOOSE
end subroutine

public function integer of_bind_all (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_bind_all()
// $<arguments>
//		string	as_filename		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

TRY
	ole_admin.Object.image = as_FileName
	//ole_ocr.Object.image = as_FileName //commented by Alfee 07.25.2007
	ole_thumbnail.Object.image = as_FileName
	
	ole_thumbnail.Object.GenerateThumb(1)
	IF ole_thumbnail.Object.ThumbCount > 0 THEN
		ole_thumbnail.Object.ThumbSelected(1,TRUE)
	END IF
	ole_thumbnail.Object.AutoSelect = TRUE
	
	//-----Begin Added by Alfee 07.25.2007-------------------------------------
	//<$Reason>Only .tif format is supported by OCR, it will throw an exception
	//<$Reason>while other formats used. But even so, keep it here, this can help
	//<$Reason>prevent the OCR function from exception thrown for other formats.
	ole_ocr.Object.image = as_FileName 
	//-----End Added ------------------------------
Catch(throwable th)
END TRY


RETURN 1



end function

public subroutine of_set_viewstyle (string as_style);//////////////////////////////////////////////////////////////////////
// $<function>of_set_viewstyle()
// $<arguments>
//		string	as_style		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
CHOOSE CASE lower(as_style)
	CASE 'page'
		ole_edit.x = 0
		ole_edit.width = this.width 
		ole_thumbnail.hide()
		ole_edit.show()
		st_v.hide()
		uo_toolbar.p_view_page.picturename = 'view_page_down.bmp'
		uo_toolbar.p_view_thumb.picturename = 'view_thumb.bmp'
		uo_toolbar.p_view_thumbpage.picturename = 'view_thumbpage.bmp'
	CASE 'thumb'
		ole_thumbnail.width = this.width 
		ole_thumbnail.height = ole_edit.height
		ole_thumbnail.show()
		ole_thumbnail.bringtotop = true
		ole_edit.hide()
		st_v.hide()
		uo_toolbar.p_view_page.picturename = 'view_page.bmp'
		uo_toolbar.p_view_thumb.picturename = 'view_thumb_down.bmp'
		uo_toolbar.p_view_thumbpage.picturename = 'view_thumbpage.bmp'

		
		ole_thumbnail.object.refresh()
	CASE 'thumbpage'
		ole_thumbnail.width = st_v.x 
		ole_thumbnail.height = ole_edit.height
		ole_edit.x = st_v.x + 18
		ole_edit.width = this.width - ole_edit.x 
		ole_thumbnail.show()
		st_v.show()
		ole_thumbnail.bringtotop = true
		ole_edit.show()
		uo_toolbar.p_view_page.picturename = 'view_page.bmp'
		uo_toolbar.p_view_thumb.picturename = 'view_thumb.bmp'
		uo_toolbar.p_view_thumbpage.picturename = 'view_thumbpage_down.bmp'
	CASE ELSE
		//Not support
END CHOOSE

is_viewstyle = as_style

end subroutine

public function boolean of_is_annotation_selected ();//////////////////////////////////////////////////////////////////////
// $<function>of_is_annotation_selected()
// $<returns> boolean   : 	true 	: 	If one or more annotation(s) is(are) selected
//									false	:	No any annotation is selected
// $<description>Determine if there is any annotation selected.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.18.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

try
	return iole_object.GetSelectedAnnotationNumPoints () > 0
catch(throwable th)
return false
end try
end function

public function integer of_goto_thumbpage ();//////////////////////////////////////////////////////////////////////
// $<function>of_goto_thumbpage()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
int  li


for li=1 to ole_thumbnail.object.thumbcount
	IF ole_thumbnail.object.ThumbSelected(li) THEN
		of_scroll( string(li))
		of_set_viewstyle( 'page')
	END IF
next

return 1
end function

public function integer of_show_blankimage ();//////////////////////////////////////////////////////////////////// //
// $<function>of_show_blankimage()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

TRY
	iole_object.cleardisplay()
	ole_thumbnail.Object.ClearThumbs ()
	
	of_set_viewstyle( 'page')
Catch(throwable th)
END TRY

RETURN 1


end function

public function integer of_open_localfile (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_open_localfile()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
ib_initialized = FALSE //for document library painter- Alfee 05.19.2008 

ib_JustScaned = false

IF NOT FileExists(as_FileName) THEN
	of_show_blankimage( )
	RETURN -1
END IF

iole_object.Image(as_FileName)
iole_object.UndoLevels=1//New added on 2007/01/31
iole_object.page(1)
iole_object.Display()
iole_object.FitTo(1)
iole_object.DisplayScaleAlgorithm = 4

IF iole_object.pagecount < 1 THEN
	of_show_blankimage( )
ELSE
	iole_object.page = 1
END IF
of_scroll('refresh')
of_set_zoom(-1)
ib_show_magnifier = FALSE

inv_image_func.of_annotationtoolselection( ole_edit, 'SelectAnnoAndZones')

//Assign to current file name - for document library painter Alfee 05.19.2008
is_LocalFileName = as_filename

of_bind_all(as_FileName)

//----Beign Added by Alfee 05.19.2008 -------
//for document library painter
ib_initialized =TRUE 
This.Post of_set_readonly() 
//-----End Added -----------------------------

RETURN 1

end function

public function boolean of_ismodified ();//////////////////////////////////////////////////////////////////////
// $<function>of_ismodified()
// $<arguments>
//		value	integer		
// $<returns> boolean
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return iole_object.imagemodified or ib_JustScaned
end function

public function integer of_initialize (long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>of_initialize()
// $<arguments>
//		value	long   	al_doc_id   		
//		value	decimal	adc_revision		
//		value	string 	as_doc_ext  		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

dec{1}  ldc_document_revision

il_doc_id = al_doc_id
idc_revision = adc_revision
is_doc_ext = as_doc_ext

  SELECT doc_name ,revision,doc_type,revision_control
    INTO :is_doc_name  ,:ldc_document_revision,:is_doc_type,:is_revision_control
    FROM ctx_am_document  
   WHERE ( ctx_am_document.doc_id = :al_doc_id )  ;

st_doc.text = 'Document: '+is_doc_name+'('+string(adc_revision,'##0.0')+')'
//is_LocalFileName = inv_dm_utils.of_generate_tempname( al_doc_id, adc_revision, as_doc_ext)

//-------Begin Modified by Alfee on 04.16.2008----------
IF IsValid(m_pfe_cst_mdi_menu_contract_am) THEN
	ib_readonly = Not m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.enabled 
END IF
//ib_readonly = ldc_document_revision<>idc_revision
//-------End Modified ----------------------------------


return 1
end function

public function decimal of_get_revision ();//////////////////////////////////////////////////////////////////////
// $<function>of_get_revision()
// $<returns> decimal	: The revision of current image.
// $<description>Return the revision of current image.
// $<description>This function may be called back by u_tabpag_dm_data.
//////////////////////////////////////////////////////////////////////
// $<add> 01.26.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return idc_revision
end function

private subroutine of_menu_security_cascade (ref menu am_parent, boolean ab_enabled);//////////////////////////////////////////////////////////////////////
// $<function>of_menu_security_cascade()
// $<arguments>
//		value	menu   	am_parent 		:The menu to be operated.
//		value	boolean	ab_enabled		:True to enable, false to disable
// $<description>Set the menu item and all its child items' enabled property
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

IF not isvalid(am_parent) then return
int  li

//am_parent.enabled = ab_enabled
FOR li = 1 to upperbound(am_parent.item[])
	//am_parent.item[li].enabled = ab_enabled
	gnv_app.of_modify_menu_attr( am_parent.item[li],'enabled', ab_enabled)
	//of_menu_security_cascade( am_parent.item[li],ab_enabled)
	
NEXT
end subroutine

public function integer of_initialize (long al_doc_id, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>of_initialize()
// $<arguments>
//		value	long   	al_doc_id   		
//		value	string 	as_doc_ext  		
// $<returns> integer
// $<description>for document library painter
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.19.2008 by Alfee
//////////////////////////////////////////////////////////////////////

il_doc_id = al_doc_id
is_doc_ext = as_doc_ext

SELECT document_name INTO :is_doc_name FROM ctx_acp_document WHERE ctx_acp_document_id = :al_doc_id ;

st_doc.text = 'Document: '+is_doc_name + "." + Lower(is_doc_ext)

return 1
end function

public function integer of_set_module (string as_module);//Included in module of ... - Alfee 05.19.2008
is_from_module = as_module

RETURN 1
end function

public function integer of_set_readonly ();//Get and set readonly flag   - Alfee 05.19.2008

CHOOSE CASE Upper(is_from_module)
	CASE 'DLP' //call from document library painter
		IF IsValid(m_ctx_doc_painter) THEN ib_readonly = NOT m_ctx_doc_painter.m_file.m_save.enabled
	CASE 'AUDIT' //call from document manager audit
		ib_readonly = TRUE
	CASE 'EMAIL' //call fromm email document browser
		ib_readonly = TRUE
END CHOOSE

RETURN 1
end function

public subroutine of_reset_registry ();//Reset the registered datetime of the document- Added by Alfee on 07.28.2008

String ls_module
Datetime ldt_modify_date

CHOOSE CASE Upper(is_from_module)
	CASE 'DLP'
		ls_module = 'document library painter'	
	CASE 'DM'
		ls_module = 'document manager'			
END CHOOSE
inv_dm_utils.of_updateregistry(ls_module, il_doc_id, idc_revision, is_doc_ext, ldt_modify_date)

end subroutine

public function integer of_set_readonly (boolean ab_readonly);//Alfee 08.28.2008

ib_readonly = ab_readonly

RETURN 1
end function

public function integer of_initialize (string as_doc_name, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>of_initialize()
// $<arguments>
//		value	string  	as_doc_name   		
//		value	string 	as_doc_ext  		
// $<returns> integer
// $<description>for call in other modules
//////////////////////////////////////////////////////////////////////
// $<add> by Alfee 07.14.2009 
//////////////////////////////////////////////////////////////////////

Long ll_pos
String ls_ext

is_doc_name = as_doc_name
is_doc_ext = as_doc_ext

ll_pos = LastPos(is_doc_name, ".") 
IF ll_pos > 0 THEN ls_ext = MidA(is_doc_name, ll_pos + 1)
IF Lower(Trim(ls_ext)) = lower(as_doc_ext) THEN
	is_doc_name = LeftA(is_doc_name, ll_pos - 1)
END IF

st_doc.text = 'Document: '+is_doc_name + "." + Lower(is_doc_ext)

RETURN 1
end function

on uo_dm_image_view.create
int iCurrent
call super::create
this.ole_scan=create ole_scan
this.ole_ocr=create ole_ocr
this.ole_admin=create ole_admin
this.st_v=create st_v
this.uo_toolbar=create uo_toolbar
this.st_doc=create st_doc
this.st_1=create st_1
this.ole_thumbnail=create ole_thumbnail
this.ole_edit=create ole_edit
this.ole_edit_work=create ole_edit_work
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_scan
this.Control[iCurrent+2]=this.ole_ocr
this.Control[iCurrent+3]=this.ole_admin
this.Control[iCurrent+4]=this.st_v
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.st_doc
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.ole_thumbnail
this.Control[iCurrent+9]=this.ole_edit
this.Control[iCurrent+10]=this.ole_edit_work
end on

on uo_dm_image_view.destroy
call super::destroy
destroy(this.ole_scan)
destroy(this.ole_ocr)
destroy(this.ole_admin)
destroy(this.st_v)
destroy(this.uo_toolbar)
destroy(this.st_doc)
destroy(this.st_1)
destroy(this.ole_thumbnail)
destroy(this.ole_edit)
destroy(this.ole_edit_work)
end on

event constructor;call super::constructor;
of_setresize( true)
inv_resize.of_register( st_1,inv_resize.scaleright)
inv_resize.of_register( uo_toolbar,inv_resize.fixedright)

inv_image_func = create n_cst_image_functions

If gi_imageocx = 1 Then gnv_reg_ocx.of_check_ocx( 3, '', True) //Added by Ken.Guo on 2008-11-07

end event

event resize;call super::resize;ole_edit.height = newheight - ole_edit.y

IF ole_edit.visible and ole_thumbnail.visible THEN
	ole_edit.width = newwidth - ole_edit.x 
	ole_thumbnail.width = st_v.x
ELSE 
	ole_edit.width = newwidth - ole_edit.x
	ole_thumbnail.width = ole_edit.width
END IF

ole_thumbnail.height = ole_edit.height
st_v.height = ole_edit.height

end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(inv_image_func) then Destroy inv_image_func
//---------------------------- APPEON END ----------------------------
end event

type ole_scan from olecustomcontrol within uo_dm_image_view
event scanstarted ( )
event scandone ( )
event pagedone ( long pagenumber )
event scanuidone ( )
event filenamerequest ( long pagenumber )
integer x = 1024
integer y = 196
integer width = 1317
integer height = 768
integer taborder = 50
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_dm_image_view.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_ocr from olecustomcontrol within uo_dm_image_view
event ocrcomplete ( integer status )
event ocrprogress ( integer percentage )
event readystatechange ( long readystate )
integer x = 1175
integer y = 196
integer width = 155
integer height = 136
integer taborder = 100
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_dm_image_view.udo"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within uo_dm_image_view
event filepropertiesclose ( )
integer x = 850
integer y = 192
integer width = 155
integer height = 136
integer taborder = 90
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_dm_image_view.udo"
integer binaryindex = 2
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type st_v from u_st_splitbar within uo_dm_image_view
integer x = 791
integer y = 128
integer width = 18
integer height = 1612
integer ii_barwidth = 18
integer ii_minobjectsize = 10
end type

event constructor;call super::constructor;
st_v.of_register(ole_thumbnail,st_v.left)
st_v.of_register(ole_edit,st_v.right)
st_v.of_setminobjectsize( 300)
end event

type uo_toolbar from uo_dm_image_toolbar_ic within uo_dm_image_view
integer x = 910
integer y = 16
integer width = 2821
integer height = 96
integer taborder = 80
end type

on uo_toolbar.destroy
call uo_dm_image_toolbar_ic::destroy
end on

event ue_set_viewstyle;call super::ue_set_viewstyle;of_set_viewstyle(as_viewstyle)
end event

event ue_scroll;call super::ue_scroll;of_scroll( as_scrolltype)
end event

event ue_zoom;call super::ue_zoom;TRY
	CHOOSE CASE Lower(as_action)
		CASE '+'
			IF  idc_zoom <= 64990 THEN
				of_set_zoom( Dec(iole_object.zoom+10))
			END IF
		CASE '-'
			IF  idc_zoom >= 15  THEN
				of_set_zoom( idc_zoom - 10)
			ELSE
				of_set_zoom( 5)
			END IF
		CASE 'selection'
			parent.event ue_do('Zoom to Selection')
			
		//	CASE 'best fit'
		//	CASE 'fit to height'
		//	CASE 'fit to width'
		CASE ELSE
			of_set_zoom( as_action)
			
	END CHOOSE
Catch(throwable th)
END TRY

end event

event ue_show_magnifier;call super::ue_show_magnifier;ib_show_magnifier = not ib_show_magnifier
iole_object.ShowMagnifier(ib_show_magnifier)

IF ib_show_magnifier THEN
	p_magnifier.picturename = 'zoom_magnifier_down.bmp'
ELSE
	p_magnifier.picturename = 'zoom_magnifier.bmp'
END IF

ole_edit.setfocus( )
end event

event ue_page_modified;call super::ue_page_modified;
integer li_page

li_page = integer(em_page.text)
IF li_page <= iole_object.pagecount and li_page>0 THEN
	of_scroll( string(li_page))
ELSE
	post of_set_pagetext(string(iole_object.page))
END IF
	
end event

event ue_set_mousetype;call super::ue_set_mousetype;
//inv_image_func.of_annotationtoolselection( )
inv_image_func.of_annotationtoolselection(ole_edit,as_mousetype )
IF as_mousetype = 'Drag' THEN
	p_drag.picturename = 'image_drag_down.bmp'
	p_select.picturename = 'image_arrow.bmp'
	ib_candrag = true
ELSE
	//inv_image_func.of_annotationtoolselection(ole_edit,'SelectionRectangle' )//SelectAnnoAndZones
	p_drag.picturename = 'image_drag.bmp'
	p_select.picturename = 'image_arrow_down.bmp'
	ib_candrag = false
END IF
end event

event ue_show_toolmenu;call super::ue_show_toolmenu;parent.event ue_rmbmenu('tools')
end event

type st_doc from statictext within uo_dm_image_view
integer x = 18
integer y = 36
integer width = 1778
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_1 from statictext within uo_dm_image_view
integer width = 3739
integer height = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ole_thumbnail from olecustomcontrol within uo_dm_image_view
event click ( long thumbnumber )
event dblclick ( long thumbnumber )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event thumbdrop ( long insertbefore,  long dropcount,  integer shift )
event thumbdrag ( long dragcount,  integer shift )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event readystatechange ( long readystate )
integer y = 128
integer width = 800
integer height = 1620
integer taborder = 90
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_dm_image_view.udo"
integer binaryindex = 3
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click(long thumbnumber);IF thumbnumber < 1 or isnull(thumbnumber) THEN return

iole_object.page = thumbnumber

of_scroll( 'refresh')
//IF not ole_edit.visible THEN
//	of_set_viewstyle( 'page')
//END IF
 
end event

event dblclick(long thumbnumber);IF thumbnumber < 1 or isnull(thumbnumber) THEN return
IF is_viewstyle = 'thumb' THEN

	//iole_object.page = thumbnumber
	
	//of_scroll( 'refresh')
	of_set_viewstyle( 'page')
END IF

end event

event mouseup(integer button, integer shift, long ocx_x, long ocx_y, long thumbnumber);IF button <> 2 THEN return

parent.event ue_rmbmenu('thumbnail')
end event

type ole_edit from olecustomcontrol within uo_dm_image_view
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 805
integer y = 128
integer width = 2926
integer height = 1600
integer taborder = 90
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_dm_image_view.udo"
integer binaryindex = 4
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event keydown(integer keycode, integer shift);//mle_1.text+=string(KeyCode)+','+string(shift)+'~r~n'

CHOOSE CASE keycode
	CASE 46 //delete
		IF ib_readonly THEN RETURN
		PARENT.EVENT ue_delete_image_object()
	CASE 67 //c
		IF shift = 2 THEN //Ctrl+C = Copy
			PARENT.EVENT ue_image_copy()
		END IF
	CASE 88 //X
		IF ib_readonly THEN RETURN
		IF shift = 2 THEN //Ctrl+X = Cut
			PARENT.EVENT ue_image_cut()
		END IF
	CASE 86 //V
		IF ib_readonly THEN RETURN
		IF shift = 2 THEN //Ctrl+V = Paste
			PARENT.EVENT ue_image_paste()
		END IF
	CASE 90 //z
		IF ib_readonly THEN RETURN
		IF shift = 2 THEN //Ctrl+Z = undo
			PARENT.EVENT ue_undo()
		END IF
	CASE 33 //KeyPageUp!
		of_scroll( 'prior')
		
	CASE 34 //KeyPageDown!
		of_scroll( 'next')	
END CHOOSE



end event

event mousedown(integer button, integer shift, long ocx_x, long ocx_y);IF button=1 and ib_candrag THEN
	ib_draging=true
	il_drag_from_x = ocx_x
	il_drag_from_y = ocx_y
END IF
end event

event mousemove(integer button, integer shift, long ocx_x, long ocx_y);//object.ScrollImage (Direction,ScrollAmount)
//
//Arguments
//
//Parameter	Data Type	Setting
//Direction	Integer (enumerated)	The direction in which to scroll the image: 
//					0  Down
//					1  Up
//					2  Right
//					3  Left
//ScrollAmount	Long	The number of pixels to scroll the image

IF ib_draging THEN
	IF ocx_x < il_drag_from_x THEN
		iole_object.ScrollImage(2,il_drag_from_x - ocx_x)
	ELSE
		iole_object.ScrollImage(3,ocx_x - il_drag_from_x)
	END IF
	IF ocx_y < il_drag_from_y THEN
		iole_object.ScrollImage(0,il_drag_from_y - ocx_y)
	ELSE
		iole_object.ScrollImage(1,ocx_y - il_drag_from_y)
	END IF
	il_drag_from_x = ocx_x
	il_drag_from_y = ocx_y
END IF
end event

event mouseup(integer button, integer shift, long ocx_x, long ocx_y);ib_draging = FALSE
IF button = 1 THEN
	
ELSEIF button = 2 THEN
	Boolean lb_annotation_selected
	Boolean lb_selection
	
	lb_annotation_selected = of_is_annotation_selected( )
	lb_selection = il_ocx_height > 0 AND il_ocx_width > 0
	
	IF lb_selection THEN
		PARENT.EVENT ue_rmbmenu('selection')
	ELSEIF lb_annotation_selected THEN
		PARENT.EVENT ue_rmbmenu('annotation')
	ELSE
		PARENT.EVENT ue_rmbmenu('page')
	END IF
END IF

end event

event markend(long left, long top, long ocx_width, long ocx_height, integer marktype, string groupname);IF marktype=13 THEN//OCR Zone
	uo_toolbar.event ue_set_mousetype('SelectAnnoAndZones')
END IF
end event

event selectionrectdrawn(long left, long top, long ocx_width, long ocx_height);//messagebox('selectionrectdrawn','Left:'+string(left)+'   top:'+string(top)+'   width:'+string(ocx_width)+'   height:'+string(ocx_height))

il_ocx_top = top
il_ocx_left = left
il_ocx_width = ocx_width
il_ocx_height = ocx_height

uo_toolbar.event ue_selection_enabled( il_ocx_width> 0 and il_ocx_height> 0)
end event

event constructor;iole_object = ole_edit.object



end event

type ole_edit_work from olecustomcontrol within uo_dm_image_view
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 942
integer y = 416
integer width = 1317
integer height = 768
integer taborder = 60
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_dm_image_view.udo"
integer binaryindex = 5
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
07uo_dm_image_view.bin 
2400000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000045a4f76001d1313200000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000013d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff0000000384926ca0101c2941600e6f817f4b11130000000045a4f76001d1313245a4f76001d13132000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000005000000480000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe0002020684926ca0101c2941600e6f817f4b111300000001fb8f0821101b01640008ed8413c72e2b000000300000010d00000007000001000000004000000101000000480000010200000050000001030000005800000104000000600000010500000074000000000000008800000003000100000000000300001dc400000003000013d800000003000000000000001e0000000945676d4934746964000000000000001e0000000b53206f4e6e6e61630000726500000007000000000000000100010500000010006c657300657463656163736472656e6e0001030000000c0074735f00706b636f73706f72000104000000110073656400616d69746f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f6973000000000001000000001dc4000013d800000000676d490874696445000100340001000000007fff00000001000100000003000100000008000000000142c800206f4e0a6e6163530072656e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000045a4f76001d1313200000003000001400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038fc248e311cfd4d920002787a7dca5af0000000045a4f76001d1313245a4f76001d13132000000000000000000000000006f00430074006e006e006500730074
2300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000040000003c00000000000000010000000200000003fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202068fc248e311cfd4d920002787a7dca5af00000001fb8f0821101b01640008ed8413c72e2b00000030000000a4000000050000010000000030000001010000003800000102000000400000010300000048000000000000005000000003000000000000000300000384000000030000038400000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000384000003840000000000010000000000000101000000000000000000000000000000000000000000c80000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000045a4f76001d1313200000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c00240000000045a4f76001d1313245a4f76001d13132000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020206009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000003840000038400000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Cfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000045a4f76001d1313200000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000013e00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003e1a6b8a0101c360302046eac029c00240000000045a4f76001d1313245a4f76001d13132000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000005000000460000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020206e1a6b8a0101c360302046eac029c002400000001fb8f0821101b01640008ed8413c72e2b000000300000010e00000008000001000000004800000101000000500000010200000058000001030000006000000104000000680000010500000070000001060000007800000000000000800000000300020002000000030000121600000003000029dc00000003000000610000000300c0c0c0000000020000000100000003000000780000000800000000000000010001030000000c0074735f00706b636f73706f720001050000000c00726f620073726564656c79740001040000000a00
22636162006c6f636b0600726f0c00000174000000626d75686769656801007468090000015f000000657478650078746e00000102000000097478655f79746e65000100000000090065765f006f6973720000006e0002000200001216000029dc0000006100c0c0c0c00100018000c0c00100808000005500000078000000000000010000ff0001010000000000000000ff000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000045a51e7001d1313200000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c0000000045a51e7001d1313245a51e7001d13132000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
29ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000042250000000300002957000000030000006000000002000000010000001e0000000945676d493474696400000000000000032ffffffe0000000b0000ffff000000020000bd94000000020000bd94000000030018bde4000000030018bde40000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500004225000029570000006000010001000000006d490800696445670001347400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100be2800001000be28100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000045a51e7001d1313200000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c0000000045a51e7001d1313245a51e7001d13132000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc00000003000200050000000300001dc400000003000013d8000000030000006000000002000000010000001e0000000945676d493574696400000000000000032ffffffe0000000b0000ffff000000020000bd94000000020000bd94000000030018bde4000000030018bde40000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f
296e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500001dc4000013d80000006000010001000000006d490800696445670001357400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100be2800001000be2810000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17uo_dm_image_view.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
