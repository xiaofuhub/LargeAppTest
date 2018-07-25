$PBExportHeader$uo_dm_image_view_cp.sru
forward
global type uo_dm_image_view_cp from u_base
end type
type ole_scan from olecustomcontrol within uo_dm_image_view_cp
end type
type ole_thumbnail from olecustomcontrol within uo_dm_image_view_cp
end type
type ole_edit from olecustomcontrol within uo_dm_image_view_cp
end type
type st_v from u_st_splitbar within uo_dm_image_view_cp
end type
type uo_toolbar from uo_dm_image_toolbar within uo_dm_image_view_cp
end type
type st_doc from statictext within uo_dm_image_view_cp
end type
type st_1 from statictext within uo_dm_image_view_cp
end type
type ole_find from olecustomcontrol within uo_dm_image_view_cp
end type
end forward

global type uo_dm_image_view_cp from u_base
integer width = 3749
integer height = 1752
long backcolor = 33551856
string text = "none"
long picturemaskcolor = 536870912
event type integer ue_load_image ( string as_filename )
event type integer ue_load_image2 ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
event ue_rotatepage ( long al_index )
event ue_rmbmenu ( string as_menutype )
event type integer ue_save ( )
event ue_set_security ( boolean ab_can_modify )
event ue_do ( string as_action )
event ue_print ( )
event type integer ue_scan ( )
event type integer ue_delpage ( )
event ue_properties ( )
event ue_ocr ( )
event ue_ocr_setting ( )
event ue_ocr_view_result ( )
event ue_page_copy ( )
event type integer ue_page_paste ( )
event ue_saveto_pdf ( )
event ue_ocr_find ( string as_find_text )
event ue_ocr_post_find ( string as_find_text )
event type integer ue_pdf_find ( string as_find_text )
ole_scan ole_scan
ole_thumbnail ole_thumbnail
ole_edit ole_edit
st_v st_v
uo_toolbar uo_toolbar
st_doc st_doc
st_1 st_1
ole_find ole_find
end type
global uo_dm_image_view_cp uo_dm_image_view_cp

type variables
PROTECTED:

OLEObject  iole_object

n_cst_dm_utils inv_dm_utils
n_cst_image_functions_cp inv_image_func //Alfee 07.28.2008

Long il_doc_id
Long il_ocx_page
Long il_ocx_width
Long il_ocx_height
Long il_ocx_left
Long il_ocx_top
Long il_drag_from_x
Long il_drag_from_y

Dec  idc_zoom
Dec{1} idc_revision

String is_doc_ext,is_doc_name,is_doc_type
String is_LocalFileName
string is_revision_control
String is_viewstyle = 'thumbpage'
String is_module 

//boolean ib_default_printer = true
Boolean  ib_pallet_vis = FALSE
Boolean  ib_Annotations_visable = TRUE
//boolean  ib_NonOCRZones_visable=true
Boolean  ib_readonly = FALSE //Is current image can be modified? 
Boolean  ib_show_magnifier = FALSE
Boolean  ib_draging = FALSE
Boolean  ib_candrag = FALSE
boolean  ib_initialized=false
//IF just scan to a new page, the imageModified property is still false. Add this instance variable to record it.
Boolean  ib_modified=false
Boolean 	ib_properties_modified = FALSE //Alfee 11.18.2008

//Compression mode for new image OCX - Alfee 11.18.2008
Constant Int CompressionLZW =0      
Constant Int CompressionCCITT3 =1   
Constant Int CompressionCCITT4 =2   
Constant Int CompressionRle=3        
Constant Int CompressionNone=4        

//Added By Ken.Guo 2009-11-05.
String is_ocr_text 
Long il_prior_page,il_prior_text_index
String is_prior_find_text

//Added By Ken.Guo 05/19/2012
Boolean ib_PDF_searchabled  = False, ib_have_got_PDF_Searchabled = False



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
public function integer of_show_blankimage ()
public function integer of_open_localfile (string as_filename)
public function boolean of_ismodified ()
public function integer of_initialize (long al_doc_id, decimal adc_revision, string as_doc_ext)
public function decimal of_get_revision ()
private subroutine of_menu_security_cascade (ref menu am_parent, boolean ab_enabled)
public subroutine of_set_viewstyle ()
public function boolean of_is_multiimage (string as_doc_ext)
public function integer of_print (string as_range)
public function integer of_initialize (long al_doc_id, string as_doc_ext)
public subroutine of_set_module (string as_module)
public function integer of_set_readonly ()
public subroutine of_set_modified (boolean ab_modified)
public function integer of_initialize (string as_doc_name, string as_doc_ext)
public function integer of_set_readonly (boolean ab_readonly)
public subroutine of_set_ocr_result (string as_ocr_value)
public function integer of_find_ocr_page (string as_find_text, long al_find_begin, boolean ab_match_case, ref long al_page_index, ref long al_text_index, ref string as_error_info)
public subroutine of_reset_ocr ()
public subroutine of_get_ocr_result (long al_doc_id, decimal adec_revision)
public subroutine of_reset_ocr_vars ()
public subroutine of_saveaspdf ()
public function boolean of_get_pdf_searchable ()
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

try

li_ret = of_open_localfile(is_LocalFileName)
IF li_ret < 0 THEN 
	return -1
END IF

of_get_ocr_result(al_doc_id,adc_revision) //Added By Ken.Guo 2009-11-05.

catch(throwable th)
	messagebox('Error','Failed to open file due to '+th.text)
end try

ib_initialized = true

return 1


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

CHOOSE CASE al_Index
	CASE 0 // 'Left
       iole_object.Rotate270( )
	CASE 1 // 'Right
       iole_object.Rotate90( )
	CASE 2 // '180
       iole_object.Rotate180( )
END CHOOSE


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
window	lw_parent,lw_current
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

//		//Added By Ken.Guo 2011-04-13.
//		If Upper(is_doc_ext) = 'PDF' Then
//			lm_menu.m_pageproperty.m_saveaspdf.visible = False
//		End If

CHOOSE CASE as_menutype
	CASE 'tools'
		lm_menu.m_pageproperty.m_zoomin.visible = false
		lm_menu.m_pageproperty.m_zoomout.visible = false
		lm_menu.m_pageproperty.m_0.visible = false
		lm_menu.m_pageproperty.m_80.visible = false		
		lm_menu.m_pageproperty.m_fittoheight.visible = false
		lm_menu.m_pageproperty.m_fittowidth.visible = false
		lm_menu.m_pageproperty.m_bestfit.visible = false		
//		lm_menu.m_pageproperty.m_copypage0.visible = false		
//		lm_menu.m_pageproperty.m_paste1.visible = false
		lm_menu.m_pageproperty.m_deletepages.visible = false
//		lm_menu.m_pageproperty.m_gg1.visible = false
		lm_menu.m_pageproperty.m_2.visible = false
		lm_menu.m_pageproperty.m_19.visible = false //alfee 11.18.2008
		lm_menu.m_pageproperty.m_properties1.visible = false

		IF Not ib_readonly THEN //Alfee 07.28.2008
			lm_menu.m_pageproperty.m_scan0.visible = TRUE 
			lm_menu.m_pageproperty.m_line_scan0.visible = TRUE
			lm_menu.m_pageproperty.m_2.visible = TRUE
			lm_menu.m_pageproperty.m_delpage.visible = TRUE
			lm_menu.m_pageproperty.m_19.visible = TRUE //alfee 11.18.2008			
			lm_menu.m_pageproperty.m_properties1.visible = TRUE //alfee 11.18.2008			
		END IF
		lm_menu.m_pageproperty.m_printpage0.visible = TRUE
		lm_menu.m_pageproperty.m_printall.visible = TRUE
		lm_menu.m_pageproperty.m_rotate.visible = TRUE
		lm_menu.m_pageproperty.m_rotateleft.visible = TRUE
		lm_menu.m_pageproperty.m_rotateright.visible = TRUE
		lm_menu.m_pageproperty.m_rotate180.visible = TRUE

		//Added By Ken.Guo 2009-11-04.
		of_GetParentWindow (lw_current)
		If isvalid(lw_current) Then
			If lw_current.classname() <> 'w_contract' Then  
				lm_menu.m_pageproperty.m_ocrc_cp.visible = False
				lm_menu.m_pageproperty.m_20.visible = False
				lm_menu.m_pageproperty.m_19.visible = False
				lm_menu.m_pageproperty.m_saveaspdf.visible = False
			End If
		Else
			lm_menu.m_pageproperty.m_ocrc_cp.visible = False
			lm_menu.m_pageproperty.m_20.visible = False
			lm_menu.m_pageproperty.m_19.visible = False
			lm_menu.m_pageproperty.m_saveaspdf.visible = False			
		End If	
		If (Upper(is_doc_ext) <> 'TIF' and Upper(is_doc_ext) <> 'TIFF' ) or ib_readonly  Then //Only TIF can Insert Page
//			lm_menu.m_pageproperty.m_copypage0.visible = false		
			lm_menu.m_pageproperty.m_paste1.visible = false
//			lm_menu.m_pageproperty.m_gg1.visible = false
			lm_menu.m_pageproperty.m_scan0.visible = false
			lm_menu.m_pageproperty.m_line_scan0.visible = false
			lm_menu.m_pageproperty.m_delpage.visible = false
			lm_menu.m_pageproperty.m_19.visible = false		
			lm_menu.m_pageproperty.m_ocrc_cp.visible = False
			lm_menu.m_pageproperty.m_20.visible = False
		End If

		//Added By Ken.Guo 2011-04-13.
		If w_mdi.of_security_access( 6909 ) = 0 Then //output->saveas
			lm_menu.m_pageproperty.m_copypage0.visible = False
			lm_menu.m_pageproperty.m_deletepages.visible = False
			lm_menu.m_pageproperty.m_delpage.visible = False
			lm_menu.m_pageproperty.m_paste1.visible = False
			lm_menu.m_pageproperty.m_ocrc_cp.visible = False	
			lm_menu.m_pageproperty.m_saveaspdf.visible = False
		End If
		If w_mdi.of_security_access( 6906 ) = 0 Then //output->Print
			lm_menu.m_pageproperty.m_printall.visible = False
			lm_menu.m_pageproperty.m_printpage0.visible = False
		End If
		If Upper(is_doc_ext) = 'PDF' Then 
			lm_menu.m_pageproperty.m_saveaspdf.visible = False	
		End If		
		
		lm_menu.m_pageproperty.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
	CASE 'page'
//		lm_menu.m_pageproperty.m_copypage0.visible = false		
//		lm_menu.m_pageproperty.m_paste1.visible = false
		lm_menu.m_pageproperty.m_deletepages.visible = false
//		lm_menu.m_pageproperty.m_gg1.visible = false
		lm_menu.m_pageproperty.m_2.visible = false
		lm_menu.m_pageproperty.m_19.visible = false //alfee 11.18.2008
		lm_menu.m_pageproperty.m_properties1.visible = false
		IF Not ib_readonly THEN  //alfee 11.18.2008	
			lm_menu.m_pageproperty.m_19.visible = TRUE 
			lm_menu.m_pageproperty.m_properties1.visible = TRUE 
		END IF
		
		//Added By Ken.Guo 2009-11-04.
		of_GetParentWindow (lw_current)
		If isvalid(lw_current) Then
			If lw_current.classname() <> 'w_contract' Then  
				lm_menu.m_pageproperty.m_ocrc_cp.visible = False
				lm_menu.m_pageproperty.m_20.visible = False
				lm_menu.m_pageproperty.m_19.visible = False
				lm_menu.m_pageproperty.m_saveaspdf.visible = False					
			End If
		Else
			lm_menu.m_pageproperty.m_ocrc_cp.visible = False
			lm_menu.m_pageproperty.m_20.visible = False
			lm_menu.m_pageproperty.m_19.visible = False
			lm_menu.m_pageproperty.m_saveaspdf.visible = False				
		End If
		If (Upper(is_doc_ext) <> 'TIF' and Upper(is_doc_ext) <> 'TIFF' ) or ib_readonly  Then //Only TIF can Insert Page
	//		lm_menu.m_pageproperty.m_copypage0.visible = false		
			lm_menu.m_pageproperty.m_paste1.visible = false
	//		lm_menu.m_pageproperty.m_gg1.visible = false
			lm_menu.m_pageproperty.m_scan0.visible = false
			lm_menu.m_pageproperty.m_line_scan0.visible = false
			lm_menu.m_pageproperty.m_delpage.visible = false
			lm_menu.m_pageproperty.m_19.visible = false	
			lm_menu.m_pageproperty.m_ocrc_cp.visible = False
			lm_menu.m_pageproperty.m_20.visible = False
		End If		
		
		//Added By Ken.Guo 2011-04-13.
		If w_mdi.of_security_access( 6909 ) = 0 Then //output->saveas
			lm_menu.m_pageproperty.m_copypage0.visible = False
			lm_menu.m_pageproperty.m_deletepages.visible = False
			lm_menu.m_pageproperty.m_delpage.visible = False
			lm_menu.m_pageproperty.m_paste1.visible = False
			lm_menu.m_pageproperty.m_ocrc_cp.visible = False
			lm_menu.m_pageproperty.m_saveaspdf.visible = False			
		End If
		If w_mdi.of_security_access( 6906 ) = 0 Then //output->Print
			lm_menu.m_pageproperty.m_printall.visible = False
			lm_menu.m_pageproperty.m_printpage0.visible = False
		End If
		If Upper(is_doc_ext) = 'PDF' Then 
			lm_menu.m_pageproperty.m_saveaspdf.visible = False	
		End If
		
		
		lm_menu.m_pageproperty.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)		
END CHOOSE

destroy lm_menu



end event

event type integer ue_save();//////////////////////////////////////////////////////////////////////
// $<event>ue_save()
// $<arguments>(None)
// $<returns> integer
// $<description>for document manager only
//////////////////////////////////////////////////////////////////////
// $<add>by Alfee on 07.28.2008
//////////////////////////////////////////////////////////////////////
int  li_ret, li_file
string ls_filename_ori
boolean lb_newVersion=false
datetime ldt_modify_date 
integer li_version_increment
str_add_audit lstr_add_audit
n_cst_filesrvwin32 lnv_filesvr 
Long ll_ocr_len
decimal ldec_max_revision  //Added By Ken.Guo 2009-05-15

//Verify before save operation
IF Lower(is_doc_ext) <> 'tif' THEN RETURN 0 //for new image OCX only
IF ib_readonly THEN
	messagebox('Save Image','The current image can not be modified. Please verify if you have entire access rights or it is a history version.',exclamation!)
	return 0
END IF
IF not of_ismodified( ) THEN
	Messagebox('Save Image','The current image has not been modified.',exclamation!)
	return 0
END IF	

li_version_increment = of_get_app_setting("set_57","I")	//Jervis 02.19.2009

//IF is_revision_control<>'1' THEN
IF Lower(is_module) = 'dm'	and is_revision_control<>'1' THEN //Alfee 11.18.2008
	li_ret = Messagebox("Save Image", "Do you want to start version control?", Question!, YesNo!, 1)
	IF li_ret = 1 THEN
		lb_newVersion = true
	ELSE
		lb_newVersion = false
	END IF
END IF

SetPointer(HourGlass!)
ldt_modify_date = DateTime(Today(), Now())

Try
	IF is_revision_control = '1' or lb_newVersion THEN
		
		//Start code by jervis 02.19.2009
		//Version nunber increment control
		//0-	Turn off versioning control
		//1-	Increment version Number each time document is Update(Default)
		//2-	Increment Version Number on Check in /Out only
		Select Max(Revision) Into :ldec_max_revision From Ctx_am_doc_image	Where Doc_id = :il_doc_id;   //Added By Ken.Guo 2009-05-15. Get newest revision.
		gnv_appeondb.of_startqueue( )	
		if li_version_increment = 1 then
		//End code by jervis 02.19.2009
		
			//Get new revison no and file name
			ls_filename_ori = is_Localfilename
			//idc_revision = inv_dm_utils.of_newversion( idc_revision )
			idc_revision = inv_dm_utils.of_newversion( ldec_max_revision )   //Modified By Ken.Guo 2009-05-15
			is_Localfilename = inv_dm_utils.of_generate_tempname( il_doc_id, idc_revision,is_doc_ext)
			
			//save as a new revision document
			IF FileCopy(ls_filename_ori, is_Localfilename, TRUE) <> 1 THEN
				Destroy lnv_filesvr
				MessageBox("File Copy",'Copy file of "' + ls_filename_ori + '" failed!')
				RETURN -1
			END If
			/* The performance is bad and may make the scanned image distorted 
			IF ole_edit.object.Save(Mid(is_Localfilename,1, Len(is_Localfilename) - 4), is_doc_ext) = 0 THEN
				Messagebox('Error','Failed to save current image file!', exclamation!)
				Return -1
			END If */
							
			
			// Insert new record of image to the DB
			Insert Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date)
			Values( :il_doc_id, :idc_revision, :is_doc_ext, :ldt_modify_date );	
			
			//Open the new revision file
			//Refresh the image display if properties changed - Alfee 11.18.2008
			IF ib_properties_modified THEN
				ib_properties_modified = FALSE
				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
				OpenwithParm(w_appeon_gifofwait, "Re-opening the document...")
				SetRedraw(FALSE)
				of_open_localfile( is_Localfilename)			
				SetRedraw(TRUE)
			ELSE
				SetRedraw(FALSE)
				//of_open_localfile( is_Localfilename)
				iole_object.filename = is_Localfilename
				iole_object.LoadMultiPage(is_Localfilename, 1)
				//Select the first clip
				IF ole_thumbnail.Object.ClipCount > 0 THEN
					ole_thumbnail.object.UnSelectAllClip()
					ole_thumbnail.Object.SelectClip(0) 
					ole_thumbnail.Object.VScroll(6) //Scroll to top 
				END IF
				SetRedraw(TRUE)
			END IF		
			st_doc.text = "Document:"+is_doc_name+'('+string(idc_revision,'##0.0')+')'
		end if
		
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
			
		
		is_revision_control = '1'
	end if
		
	IF (is_revision_control <> '1' and not lb_newVersion) or li_version_increment <> 1 THEN	//Jervis 02.19.2009
		//ole_edit.object.Save() - The new OCX needn't save after a scan or delete page operation
		Update Ctx_am_doc_image
		Set 	modify_date=:ldt_modify_date
		Where doc_id = :il_doc_id;
		Commit;
		
		//Refresh the image display if properties changed - Alfee 11.18.2008
		IF ib_properties_modified THEN
			ib_properties_modified = FALSE
			IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
			OpenwithParm(w_appeon_gifofwait, "Re-opening the document...")
			SetRedraw(FALSE)
			of_open_localfile( is_Localfilename)
			SetRedraw(TRUE)
		END IF
	END IF

	//upload file to db	
	li_ret = inv_dm_utils.of_upload_file( il_doc_id, idc_revision, is_Localfilename)
	
	//Add audit trail
	lstr_add_audit.doc_id = il_doc_id
	lstr_add_audit.revision = idc_revision
	lstr_add_audit.doc_ext = is_doc_ext
	lstr_add_audit.action = "Modified"
	li_ret = inv_dm_utils.of_add_audit_trail( lstr_add_audit )
	
	//Update the latest update date of the current file in Registry
	//Added By Ken.Guo 2009-11-09. Must reselect to get the date.
	Select Modify_date,datalength(pdftext) into :ldt_modify_date, :ll_ocr_len From ctx_am_doc_image Where doc_id = :il_doc_id and revision = :idc_revision;
	
	inv_dm_utils.of_updateregistry(il_doc_id, idc_revision, is_doc_ext, ldt_modify_date)	

	If ll_ocr_len > 0 then
		of_get_ocr_result(il_doc_id,idc_revision)
		uo_toolbar.of_set_ocr_button(1)
	Else
		uo_toolbar.of_set_ocr_button(0)
	End If


	//Restore the modified flag
	IF li_ret > 0 THEN of_set_modified(false) 

	SetPointer(Arrow!)
	return li_ret
	
CATCH(Throwable th)
	IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)	
	messagebox('Save','Failed to save current image due to '+th.text)
	return -1
END TRY

return 1
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
		CASE 'Page Print','All Print'
			of_print(as_action)
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
		CASE 'Delete Page'
			Event ue_delpage()
		CASE 'Page Properties' //Alfee 11.18.2008
			Event ue_properties()
		CASE 'Page Copy' //Added By Ken.Guo 2009-11-04.
			Event ue_page_copy()
		CASE 'Page Paste' //Added By Ken.Guo 2009-11-04.
			Event ue_page_paste()
		Case 'Save As PDF' //Added By Ken.Guo 2009-11-04.
			Event ue_saveto_pdf()
		CASE ELSE
			MessageBox('uo_dm_image_view.ue_do','Unregistered action code:'+as_action)
	END CHOOSE
Catch(throwable th)
END TRY

end event

event ue_print();//Alfee 05.19.2008

this.event ue_do("All Print")
end event

event type integer ue_scan();//////////////////////////////////////////////////////////////////////
// $<event>ue_scan()
// $<arguments>
//		None		
// $<returns> integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2008 by Alfee 
//////////////////////////////////////////////////////////////////////
Integer li_rtn
String ls_ScanFileName
Boolean lb_saved
DateTime ldt_modify_date

//Get scan file name
ls_ScanFileName = inv_dm_utils.of_generate_tempname( il_doc_id, idc_revision, 'scan'+string(now(),'hhmmssfff')+'.tif')

SetPointer(HourGlass!)

//Setup and Scan images
OpenWithParm(w_ctx_doc_scan_cp, 'background')
ls_ScanFileName = Message.StringParm
IF IsNull(ls_ScanFileName) OR Len(ls_ScanFileName) < 1 THEN RETURN -1
//IF inv_image_func.of_setup_scan( ole_scan, ls_ScanFileName) = -1 THEN RETURN -1

//Insert the images to TIF document
li_rtn = inv_image_func.of_insert_page( ole_thumbnail, ole_edit, il_ocx_page, 'append', ls_ScanFileName)

SetPointer(Arrow!)

//Set the Page info if scan succeeded
IF li_rtn > 0 THEN 
	il_ocx_page = li_rtn
	of_set_scroll()
	ole_thumbnail.object.VScroll(7) //Scroll to botton. //Added By Ken.Guo 2009-11-05.
	of_set_modified(TRUE)
END If

//Reset the registered latest update date of the current file
IF li_rtn > 0 THEN inv_dm_utils.of_updateregistry(is_module, il_doc_id, idc_revision, is_doc_ext, ldt_modify_date)

RETURN li_rtn

end event

event type integer ue_delpage();//////////////////////////////////////////////////////////////////////
// $<event>ue_delpage()
// $<arguments>
//		None		
// $<returns> integer
// $<description>Delete current page
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2008 by Alfee
//////////////////////////////////////////////////////////////////////
Integer li_rtn
DateTime ldt_modify_date

IF il_ocx_page > 0 and il_ocx_page <= iole_object.GetTotalPage() THEN
	IF iole_object.GetTotalPage() = 1 THEN //Alfee 09.19.2008
		MessageBox("Delete Page","Cannot delete the current page as it's the only page left in the document.")	
		RETURN -1		
	END IF
	
	IF messagebox('Delete Page','Are you sure you want to delete the current page?',question!,yesno!, 2 ) = 1 THEN
		//Delete current page
		li_rtn = inv_image_func.of_delete_page(ole_thumbnail, ole_edit, il_ocx_page) 
		IF li_rtn = -1 THEN
			MessageBox("Delete Page","Delete current page failed!")	
			RETURN -1
		END IF

		//Set the Page info
		IF li_rtn >= 0 THEN 
			il_ocx_page = li_rtn
			of_set_scroll()
			of_set_modified(TRUE)
		END If	

		//Reset the registered latest update date of the current file
		IF li_rtn > 0 THEN inv_dm_utils.of_updateregistry(is_module, il_doc_id, idc_revision, is_doc_ext, ldt_modify_date)
		
		RETURN 1		
	END IF
END IF

RETURN 0


end event

event ue_properties();//Open image properties window - Alfee 11.18.2008
Integer li_rtn 
String ls_docname, ls_docname_tmp
DateTime ldt_modify_date
str_img_prop lstr_img, lstr_img_ori

//Get current compression mode
lstr_img.image_compression = Integer(iole_object.TIFCompression) + 1

//Get current resolution settings
lstr_img.image_resolution_x = Integer(iole_object.Xdpi)
lstr_img.image_resolution_y = Integer(iole_object.Ydpi)
IF lstr_img.image_resolution_x = lstr_img.image_resolution_y THEN
	CHOOSE CASE lstr_img.image_resolution_x
		CASE	100
			lstr_img.image_resolution = 1 //100 x 100
		CASE	200
			lstr_img.image_resolution = 2 //200 x 200
		CASE	300
			lstr_img.image_resolution = 3 //300 x 300
		CASE ELSE
			lstr_img.image_resolution = 4 //custom
	END CHOOSE	
ELSE
	lstr_img.image_resolution = 4
END IF

//Get current size settings
lstr_img.image_size = 4 //custom
lstr_img.image_height = iole_object.FileHeight
lstr_img.image_width = iole_object.FileWidth
lstr_img.image_size_units = 3 //pixels

lstr_img_ori = lstr_img 

//Open the properties window
OpenwithParm(w_dm_image_properties, lstr_img)

//Set properties to new values if changed(Note: the width & height properties are read only)
IF Message.StringParm <> 'cancel' AND Not IsNull(Message.PowerObjectParm) THEN
	IF MessageBox("Save","The image has been modified. Do you want to save changes?", Question!, OKCancel!) <> 1 THEN RETURN

	SetPointer(HourGlass!)
	lstr_img = Message.PowerObjectParm

	//Set the properties
	OpenwithParm(w_appeon_gifofwait, "Saving the document...")
	ls_docname = Left(iole_object.filename, LastPos(iole_object.filename, '.') - 1)	
	ls_docname_tmp = ls_docname + "_tmp"
	IF FileExists(ls_docname_tmp + ".tif") THEN FileDelete(ls_docname_tmp + ".tif")
	iole_object.TIFCompression = 1 //force to a compression mode
	//IF lstr_img.image_compression <> lstr_img_ori.image_compression THEN iole_object.TIFCompression = lstr_img.image_compression - 1
	IF lstr_img.image_resolution_x <> lstr_img_ori.image_resolution_x THEN iole_object.Xdpi = lstr_img.image_resolution_x
	IF lstr_img.image_resolution_y <> lstr_img_ori.image_resolution_y THEN iole_object.Ydpi = lstr_img.image_resolution_y

	//Save to local file
	IF lstr_img.image_height <> lstr_img_ori.image_height OR lstr_img.image_width <> lstr_img_ori.image_width THEN	
		li_rtn = iole_object.SaveBySize(ls_docname_tmp, 'tif', lstr_img.image_width, lstr_img.image_height)
	ELSE
		li_rtn = iole_object.Save(ls_docname_tmp, 'tif')
	END IF
	IF li_rtn <> 1 THEN 
		IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
		MessageBox("Save-1","Failed to save current image!")
		RETURN
	END IF
	IF FileCopy(ls_docname_tmp + ".tif", ls_docname + ".tif", TRUE) <> 1 THEN
		IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
		MessageBox("Save-2","Failed to save current image!")
		RETURN
	END IF
	FileDelete(ls_docname_tmp + ".tif")

	//Set modified flag	
	of_set_modified(TRUE)
	ib_properties_modified = TRUE
	
	//Update image into DB
	This.event ue_save()
	ib_properties_modified = FALSE
	
	IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)	
END IF

end event

event ue_ocr();Return
end event

event ue_ocr_setting();Return
end event

event ue_ocr_view_result;Return
end event

event ue_page_copy();If Not ole_edit.object.Copy2Clipboard() Then
	Messagebox('Copy','Failed to copy this page.')
End If
Return
end event

event type integer ue_page_paste();Integer li_rtn
String ls_PasteFileName
Boolean lb_saved
DateTime ldt_modify_date


SetPointer(HourGlass!)

If isvalid(w_dm_image_cp) Then
	Close(w_dm_image_cp)
End If

Open(w_dm_image_cp)
If w_dm_image_cp.of_get_from_clip(ls_PasteFileName) < 0 Then 
	Return -1
End If 
If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)

li_rtn = inv_image_func.of_insert_page( ole_thumbnail, ole_edit, il_ocx_page, 'append', ls_PasteFileName)

SetPointer(Arrow!)

//Set the Page info if scan succeeded
IF li_rtn > 0 THEN 
	il_ocx_page = li_rtn
	of_set_scroll()
	ole_thumbnail.object.VScroll(7) //Scroll to botton. //Added By Ken.Guo 2009-11-05.
	of_set_modified(TRUE)
END If

//Reset the registered latest update date of the current file
IF li_rtn > 0 THEN inv_dm_utils.of_updateregistry(is_module, il_doc_id, idc_revision, is_doc_ext, ldt_modify_date)

RETURN 1
end event

event ue_ocr_find(string as_find_text);Integer li_find
Long ll_page_index, ll_text_index
String ls_error
Integer li_ret 


If of_get_pdf_searchable() Then
	//For Searchable PDF, Highlight Text in the PDF //Added By Ken.Guo 05/19/2012
	Event ue_pdf_find(as_find_text)
Else
	//For Image PDF, Using OCR Result
	If of_ismodified() Then
		MessageBox("Save Document","The document has been modified, please save it first.") 
		Return 
	End If
	
	If len(as_find_text) < 2 Then
		Messagebox('Find','There must be at least two query characters. Single character cannot be found.')
		Return 
	End If
	
	If is_prior_find_text <> as_find_text Then
		il_prior_page = 0
		il_prior_text_index = 0
	End If
	
	If il_prior_text_index = 0 Then
		li_ret = This.of_find_ocr_page(as_find_text, il_prior_text_index , false, ll_page_index,ll_text_index, ls_error) 
	Else
		li_ret = This.of_find_ocr_page(as_find_text, il_prior_text_index + Len(as_find_text), false, ll_page_index,ll_text_index, ls_error) 
	End If
		
	If li_ret > 0 Then
		Do While ll_page_index = il_prior_page
			li_ret = This.of_find_ocr_page(as_find_text, ll_text_index + Len(as_find_text), false, ll_page_index,ll_text_index, ls_error) 
			If li_ret < 0 Then Exit
		Loop
		If li_ret > 0 Then
			IF of_is_multiimage(is_doc_ext) THEN
				il_ocx_page = ll_page_index
				iole_object.LoadMultiPage(iole_object.filename, il_ocx_page)
				ole_thumbnail.object.UnSelectAllClip()
				ole_thumbnail.object.SelectClip(il_ocx_page - 1)
				of_set_scroll()			
			END IF		
			il_prior_page = ll_page_index
			il_prior_text_index = ll_text_index
			is_prior_find_text = as_find_text	
			uo_toolbar.of_set_found_result(il_prior_page)
		Else
			Messagebox('Find','It has finished searching through OCR.')
			il_prior_page = 0
			il_prior_text_index = 0
		End If
	Else
		If il_prior_page = 0 Then
			If li_ret < -100 Then
				uo_toolbar.of_set_found_result(-1)
			Else
				uo_toolbar.of_set_found_result(-2)
			End If		
			Messagebox('Find',ls_error)
		Else
			Messagebox('Find','It has finished searching through OCR.')
			il_prior_page = 0
			il_prior_text_index = 0	
		End If
	End If
End If
SetPointer(Arrow!)

end event

event ue_ocr_post_find(string as_find_text);of_reset_ocr_vars()
uo_toolbar.of_set_find_text(as_find_text)
Post Event ue_ocr_find(as_find_text)

end event

event type integer ue_pdf_find(string as_find_text);//====================================================================
// Event: ue_pdf_find
//--------------------------------------------------------------------
// Description:  Find and highlight select Text in the PDF
//--------------------------------------------------------------------
// Arguments:
//                as_find_text
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 05/19/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_pageno,li_find_ret, i, ll_page_cnt, ll_view
String ls_filename
Boolean lb_found

If Upper(is_doc_ext) <> 'PDF' Then 
	Return -1
End If

If of_ismodified() Then
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return -1
End If

If len(as_find_text) < 2 Then
	Messagebox('Find','There must be at least two query characters. Single character cannot be found.')
	Return -1
End If

ll_pageno = ole_thumbnail.Object.GetCurSel()
ll_page_cnt = ole_thumbnail.Object.ClipCount

//Find in the Current Page
ole_edit.SetRedraw(False)
ll_view = ole_edit.object.view
lb_found = ole_edit.object.PDFFindTextFillRect(as_find_text, False, 0, 255, 128) 
ole_edit.object.view = ll_view
ole_edit.SetRedraw(True)
If lb_found Then
	uo_toolbar.of_set_find_status('Found in Page ' + String(ll_pageno + 1) )
	Return 1
End If

ll_pageno = ole_thumbnail.Object.GetCurSel()
ll_page_cnt = ole_thumbnail.Object.ClipCount
If ll_pageno < 0 Then 
	Return -1
End If
ll_pageno++  //The index start at zero. get current page no.

//Find in Next Pages
SetPointer(HourGlass!)
For i = ll_pageno + 1 To ll_page_cnt
	uo_toolbar.of_set_find_status('('+String(i) + '/' + String(ll_page_cnt) +') Finding in PDF...')
	ole_find.object.LoadMultiPage(ole_edit.object.filename, i)
	lb_found = ole_find.object.PDFFindTextFillRect(as_find_text, False, 0, 255, 128) 
	
	//If found in the find ole control then scroll to same page on the edit ole control
	If lb_found Then 
		//ole_edit.object.LoadMultiPage(ole_edit.object.filename, i)
		ole_thumbnail.Object.UnSelectAllClip()
		ole_thumbnail.Object.SelectClip( i - 1)
		ole_thumbnail.event click(i - 1, '', i )
		ole_edit.SetRedraw(False)
		ll_view = ole_edit.object.view
		ole_edit.object.PDFFindTextFillRect(as_find_text, False, 0, 255, 128) 
		uo_toolbar.of_set_find_status('Found in Page ' + String(i))
		ole_edit.object.view = ll_view
		ole_edit.SetRedraw(True)	
		Return 1
	End If
Next

uo_toolbar.of_set_find_status('Not Found')

Return 0



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
integer li
ole_edit.setredraw( False)

uo_toolbar.of_set_status('Loading Page...')

//For page scroll
CHOOSE CASE lower(as_direction)
	CASE 'first'
		il_ocx_page = 1
		iole_object.LoadMultiPage(is_LocalFileName, il_ocx_page)
	CASE 'prior'
		IF il_ocx_page > 1 THEN 
			il_ocx_page --
			IF il_ocx_page > iole_object.GetTotalPage( ) THEN il_ocx_page = iole_object.GetTotalPage( )
			iole_object.LoadMultiPage(is_LocalFileName, il_ocx_page)
		END IF
	CASE 'next'
		IF il_ocx_page < iole_object.GetTotalPage( ) THEN 
			il_ocx_page ++
			iole_object.LoadMultiPage(is_LocalFileName, il_ocx_page)
		END IF
	CASE 'last'
		il_ocx_page = iole_object.GetTotalPage( )
		IF il_ocx_page > 0 THEN iole_object.LoadMultiPage(is_LocalFileName, il_ocx_page)		
	CASE 'refresh'
		il_ocx_page = 1
	CASE ELSE //Number
		IF isnumber(as_direction) THEN
			IF Integer(as_direction) > 0 and Integer(as_direction) <= iole_object.GetTotalPage( ) THEN
				il_ocx_page = Integer(as_direction) 				
				iole_object.LoadMultiPage(is_LocalFileName, il_ocx_page)
			END IF			
		END IF
END CHOOSE

//Added By Ken.Guo 2009-11-12.
If iole_object.view = 8 Then
	of_set_zoom(String(iole_object.viewsize) + '%')
End If
of_set_zoomtext(String(Integer((iole_object.GetScaleX)* 100)))
iole_object.SetScrollBarPos(0,0) 

ole_edit.setredraw( true)

//Select thumbnail for multi page file
IF of_is_multiimage(is_doc_ext) THEN
	IF il_ocx_page > 0 and il_ocx_page <= ole_thumbnail.object.ClipCount THEN
		//ole_thumbnail.setredraw( FALSE)
		ole_thumbnail.object.UnSelectAllClip()
		ole_thumbnail.object.SelectClip(il_ocx_page - 1)
		//ole_thumbnail.object.VScroll(6)  //-Scroll to top.
		//FOR li =1 to il_ocx_page - 2
		//	  ole_thumbnail.object.VScroll(1)  
		//NEXT	
		//ole_thumbnail.setredraw( TRUE)		
	END IF
END IF

//Set scroll toolbars
of_set_scroll( )
uo_toolbar.of_set_status('')

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

//for single page
IF NOT of_is_multiimage(is_doc_ext) THEN
	uo_toolbar.em_page.text= ''
	uo_toolbar.cb_first.enabled = false
	uo_toolbar.cb_prior.enabled = false
	uo_toolbar.cb_next.enabled = false
	uo_toolbar.cb_last.enabled = false
	uo_toolbar.st_pages.text = 'Page 1 of 1'
	RETURN 
END IF

//for multi page
IF iole_object.GetTotalPage() < 2 THEN
	uo_toolbar.em_page.text=string(iole_object.GetTotalPage())
	uo_toolbar.cb_first.enabled = false
	uo_toolbar.cb_prior.enabled = false
	uo_toolbar.cb_next.enabled = false
	uo_toolbar.cb_last.enabled = false
ELSEIF il_ocx_page=1 THEN
	uo_toolbar.em_page.text=string(il_ocx_page)
	uo_toolbar.cb_first.enabled = false
	uo_toolbar.cb_prior.enabled = false
	uo_toolbar.cb_next.enabled = true
	uo_toolbar.cb_last.enabled = true
ELSEIF il_ocx_page<iole_object.GetTotalPage() THEN
	uo_toolbar.em_page.text=string(il_ocx_page)
	uo_toolbar.cb_first.enabled = true
	uo_toolbar.cb_prior.enabled = true
	uo_toolbar.cb_next.enabled = true
	uo_toolbar.cb_last.enabled = true
ELSE
	uo_toolbar.em_page.text=string(il_ocx_page)
	uo_toolbar.cb_first.enabled = true
	uo_toolbar.cb_prior.enabled = true
	uo_toolbar.cb_next.enabled = false
	uo_toolbar.cb_last.enabled = false
END IF

uo_toolbar.st_pages.text = 'Page '+string(il_ocx_page)+" of "+string(iole_object.GetTotalPage())


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

Long ll_viewsize

IF ai_percent = -1 THEN
	//ll_viewsize = iole_object.ViewSize //not supported
	of_set_zoomtext(String(Integer((iole_object.GetScaleX)* 100)))
ELSE
	If ai_percent < 25 then ai_percent = 25
	If ai_percent > 800 then ai_percent = 800
	iole_object.View = 8 //user define view mode
	iole_object.ViewSize = ai_percent	
	of_set_zoomtext(string(ai_percent))	
END IF

//ll_viewsize = iole_object.ViewSize
//idc_zoom = ll_viewsize
//
//uo_toolbar.pb_zoomout.enabled = idc_zoom > 25
//uo_toolbar.pb_zoomin.enabled = idc_zoom < 800
	
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
IF IsNumber(as_text) and Right(as_text,1)<>'%' THEN
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
dec{2} ldc_zoom
string  ls_percent

ls_percent = lower(trim(as_action))
CHOOSE CASE ls_percent
	CASE '+'
		//of_set_zoom(idc_zoom + 10)
		iole_object.ZoomIn()
		of_set_zoom(-1) //Alfee 09.19.2008
	CASE '-'
		//of_set_zoom(idc_zoom - 10)
		iole_object.ZoomOut()
		of_set_zoom(-1) //Alfee 09.19.2008
	CASE'best fit'
		iole_object.view = 9
		of_set_zoom(-1)
	CASE 'fit to width'
		iole_object.view = 10
		of_set_zoom(-1)
	CASE 'fit to height'
		iole_object.view = 11
		of_set_zoom(-1)
	CASE ELSE  //%
		IF right(ls_percent,1)='%' THEN
			ls_percent = left(ls_percent,len(ls_percent) - 1)
		END IF
		IF not isnumber(ls_percent) THEN
			of_set_zoomtext( string(idc_zoom))
			return
		END IF
		ldc_zoom = dec(ls_percent)
		IF ldc_zoom < 25 OR ldc_zoom> 800 THEN
			 of_set_zoomtext( string(idc_zoom))
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
Long i, li_cnt

TRY

	IF NOT FileExists(as_filename) THEN RETURN -1
	
	IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) //for a refresh problem
	SetPointer(HourGlass!)
	
	//Clear the last image
	li_cnt = ole_thumbnail.Object.ClipCount
   For i = 1 To li_cnt
	   ole_thumbnail.Object.DeleteClipByIndex(0)
	Next
 
 	//Display the new image
	ole_thumbnail.Object.AddClip(as_filename, '')

	//Select the first clip
	IF ole_thumbnail.Object.ClipCount > 0 THEN
		ole_thumbnail.object.UnSelectAllClip()
		ole_thumbnail.Object.SelectClip(0) //
		ole_thumbnail.Object.VScroll(6) //Scroll to top 
	END IF
	
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
		//ole_thumbnail.object.refresh()
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
Long i, li_cnt

TRY

	iole_object.filename = ''

	li_cnt = ole_thumbnail.Object.ClipCount
   For i = 1 To li_cnt
	   ole_thumbnail.Object.DeleteClipByIndex(0)
	Next
	
Catch(throwable th)
END TRY

RETURN 1


end function

public function integer of_open_localfile (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_open_localfile()
// $<arguments>(None)
// $<returns> integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
ib_initialized = FALSE //for document library painter- Alfee 05.19.2008 
ib_modified = false

IF NOT FileExists(as_FileName) THEN
	of_show_blankimage( )
	RETURN -1
END IF

//Close the current file 
iole_object.filename = ''

//Open the new file
IF of_is_multiimage(is_doc_ext) THEN
	iole_object.filename = as_filename	//Alfee 11.18.2008
	iole_object.LoadMultiPage(as_filename, 1)
	of_bind_all(as_FileName) //Bind other controls
ELSE
	iole_object.filename = as_filename		
END IF

//Assign to current file name - for document library painter
is_LocalFileName = as_filename

iole_object.SetScrollBarPos(0,0) 

//Set default status
iole_object.HighQuality = TRUE //Alfee 10.16.2008
iole_object.MouseTrackMode=3 
iole_object.view = 10 //Fit to width
of_set_zoom(-1)  //Set zoom info
of_scroll('refresh') //Set scroll toobars 
of_set_viewstyle( ) //Set view style and toolbars	
of_reset_ocr() //Added By Ken.Guo 2009-11-05.
Post SetPointer(Arrow!) //for a likely bug

//Added By Ken.Guo 2009-11-09.
If Upper(is_doc_ext) <> 'TIF' and Upper(is_doc_ext) <> 'TIFF' Then 
	uo_toolbar.of_set_paste_enable(False)
Else
//	uo_toolbar.of_set_paste_enable(True)
End If

//Added By Ken.Guo 2011-04-13.
If Upper(is_doc_ext) = 'PDF' Then
	uo_toolbar.of_set_pdf_enable(False)
Else
//	uo_toolbar.of_set_pdf_enable(True)
End If
If w_mdi.of_security_access( 6909 ) = 0 Then //output->saveas
	uo_toolbar.of_set_saveas_enable(False)
Else
//	uo_toolbar.of_set_saveas_enable(true)	
End If
If Upper(is_doc_ext) <> 'TIF' and Upper(is_doc_ext) <> 'TIFF' Then 
	uo_toolbar.of_set_paste_enable(False)
End If
If Upper(is_doc_ext) = 'PDF' Then
	uo_toolbar.of_set_pdf_enable(False)
End If
	
ib_initialized = TRUE //for document library painter- Alfee 05.19.2008 

uo_toolbar.Post setfocus( ) //Added By Ken.Guo 02/08/2012. 

This.Post of_set_readonly() 

ib_have_got_PDF_Searchabled = False //Added By Ken.Guo 05/19/2012

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

return ib_modified
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
	gnv_app.of_modify_menu_attr( am_parent.item[li],'enabled', ab_enabled)
	//of_menu_security_cascade( am_parent.item[li],ab_enabled)
	
NEXT
end subroutine

public subroutine of_set_viewstyle ();//Set view style and toolbars - Alfee 05.19.2008

IF of_is_multiimage(is_doc_ext) THEN
	uo_toolbar.p_view_page.Enabled = TRUE
	uo_toolbar.p_view_thumb.Enabled = TRUE
	uo_toolbar.p_view_thumbpage.Enabled = TRUE		
	of_set_viewstyle('thumbpage')
ELSE
	uo_toolbar.p_view_page.Enabled = TRUE
	uo_toolbar.p_view_thumb.Enabled = FALSE
	uo_toolbar.p_view_thumbpage.Enabled = FALSE			
	of_set_viewstyle('page')
END IF



end subroutine

public function boolean of_is_multiimage (string as_doc_ext);//Determine whether it is a multipage image - Alfee 05.19.2008

CHOOSE CASE Lower(as_doc_ext)
	CASE 'tif','tiff', 'pdf'
		RETURN TRUE
	CASE ELSE
		RETURN FALSE
END CHOOSE
	
RETURN FALSE
end function

public function integer of_print (string as_range);//Alfee 05.19.2008

IF of_is_multiimage(is_doc_ext) THEN 
	iole_object.PrintStartPage = -1
	iole_object.PrintEndPage = -1

	IF Lower(as_range) = 'page print' AND il_ocx_page > 0 and il_ocx_page <= iole_object.GetTotalPage() THEN
		iole_object.PrintStartPage = il_ocx_page
		iole_object.PrintEndPage = il_ocx_page
	END IF
END IF

SetPointer(HourGlass!)
iole_object.PrintImage(True)

ChangeDirectory(gs_current_path) //Alfee 09.19.2008

RETURN 1
end function

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

public subroutine of_set_module (string as_module);//Set module called from

is_module = as_module
end subroutine

public function integer of_set_readonly ();//Get and set readonly flag   - Alfee 05.19.2008

CHOOSE CASE Lower(is_module)
	CASE 'document library painter'
		IF IsValid(m_ctx_doc_painter) THEN ib_readonly = NOT m_ctx_doc_painter.m_file.m_save.enabled
	CASE 'audit' //call from document manager audit
		ib_readonly = TRUE
	CASE 'email' //call fromm email document browser
		ib_readonly = TRUE
END CHOOSE

RETURN 1
end function

public subroutine of_set_modified (boolean ab_modified);ib_modified = ab_modified
end subroutine

public function integer of_initialize (string as_doc_name, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>of_initialize()
// $<arguments>
//		value	string  	as_doc_name   		
//		value	string 	as_doc_ext  		
// $<returns> integer
// $<description>for call in other modules
//////////////////////////////////////////////////////////////////////
// $<add> 09.17.2008 by Alfee
//////////////////////////////////////////////////////////////////////

Long ll_pos
String ls_ext

is_doc_name = as_doc_name
is_doc_ext = as_doc_ext

ll_pos = LastPos(is_doc_name, ".") 
IF ll_pos > 0 THEN ls_ext = Mid(is_doc_name, ll_pos + 1)
IF Lower(Trim(ls_ext)) = lower(as_doc_ext) THEN
	is_doc_name = Left(is_doc_name, ll_pos - 1)
END IF

st_doc.text = 'Document: '+is_doc_name + "." + Lower(is_doc_ext)

RETURN 1
end function

public function integer of_set_readonly (boolean ab_readonly);//Alfee 09.17.2008

ib_readonly = ab_readonly

RETURN 1
end function

public subroutine of_set_ocr_result (string as_ocr_value);of_reset_ocr_vars()
is_ocr_text = as_ocr_value

If Trim(as_ocr_value) = '' or isnull(as_ocr_value) then
	uo_toolbar.of_set_ocr_button(0)
Else
	uo_toolbar.of_set_ocr_button(1)
End If
end subroutine

public function integer of_find_ocr_page (string as_find_text, long al_find_begin, boolean ab_match_case, ref long al_page_index, ref long al_text_index, ref string as_error_info);Integer li_page_num
Long ll_text_pos 
Long ll_page_bpos 
Long ll_page_epos 
String ls_page_index 
String ls_page_btag 
String ls_page_etag 

ls_page_btag = '<<<<<< P A G E '
ls_page_etag = ' >>>>>>'

al_page_index = 0
al_text_index = 0

If is_ocr_text = '' or isnull(is_ocr_text) Then 
	as_error_info = "This document has not been OCR'd. Please execute the OCR first."
	Return -1
End If

If al_find_begin = 0 Then al_find_begin = 1

If ab_match_case Then
	ll_text_pos = Pos(is_ocr_text,as_find_text,al_find_begin) 
Else
	ll_text_pos = Pos(Upper(is_ocr_text),Upper(as_find_text),al_find_begin) 
End If

If ll_text_pos = 0 Then
	as_error_info = 'The search item was not found.'
	Return -2
End If

ll_page_bpos = Pos(is_ocr_text,ls_page_btag, ll_text_pos) 

If ll_page_bpos = 0 Then
	as_error_info = 'The text has been found in the image document. But it can not locate the specific page. You can execute OCR again with Engine 2 to locate the specific page.'
	Return -101
End If 

ll_page_epos = Pos(is_ocr_text,ls_page_etag,ll_page_bpos) 

If ll_page_epos = 0  Then
	as_error_info = 'The text has been found in the image document. But it can not locate the specific page. You can execute OCR again with Engine 2 to locate the specific page.'
	Return -102
End If 

ls_page_index = Mid(is_ocr_text,ll_page_bpos + Len(ls_page_btag),ll_page_epos - (ll_page_bpos + Len(ls_page_btag)) )

If IsNumber(ls_page_index) Then
	 al_text_index = ll_text_pos
	 al_page_index = Long(ls_page_index) 
	 Return 1
Else
	al_text_index = 0
	al_page_index = 0
	as_error_info = 'The text has been found in the image document. But it can not locate the specific page. You can execute OCR again with Engine 2 to locate the specific page.'
	Return -103
End If


Return 1
end function

public subroutine of_reset_ocr ();is_ocr_text  = ''
of_reset_ocr_vars()
end subroutine

public subroutine of_get_ocr_result (long al_doc_id, decimal adec_revision);String ls_ocr_text
string ls_data
Integer li_ret
n_cst_image_cp_ocr lnv_ocr
lnv_ocr = Create n_cst_image_cp_ocr
li_ret = lnv_ocr.of_get_ocr_result(al_doc_id, adec_revision, ls_ocr_text, 'dm')
This.of_set_ocr_result(ls_ocr_text)
Destroy lnv_ocr


	


end subroutine

public subroutine of_reset_ocr_vars ();il_prior_page = 0
il_prior_text_index = 0
is_prior_find_text = ''
uo_toolbar.of_set_found_result(0)
end subroutine

public subroutine of_saveaspdf ();String ls_pdf_file,ls_pdf_path, ls_pdf_name
String ls_Null
Setnull(ls_null)

If of_ismodified() Then
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return 
End If

gf_load_dir_path()
If GetFileSaveName("Save As",  ls_pdf_path, ls_pdf_file, "PDF", "PDF Files (*.PDF),*.PDF" ) = 1 Then
	If FileExists(ls_pdf_path) Then
		If Messagebox('Save As','The file already exists. Do you want to replace the existing file.', Question!, YesNo!) = 2 Then 
			gf_save_dir_path(ls_pdf_path)
			Return
		End If
	End If
	
	If Right(Upper(ls_pdf_path),4) = '.PDF' Then
		ls_pdf_name = Mid(ls_pdf_path,1, LastPos(ls_pdf_path,'.') - 1)
	Else
		ls_pdf_name = ls_pdf_path
	End If
	
	SetPointer(HourGlass!)
	//Modified By Ken.Guo 2009-11-19. Do not use save() function to convert to PDF.
	If	inv_image_func.of_convert2pdf(ole_edit.object.filename , ls_pdf_name + '.pdf' )	<> 1 Then
	//If ole_edit.object.save(ls_pdf_name, 'pdf') <> 1 Then
		gf_save_dir_path(ls_pdf_path)
		SetPointer(Arrow!)
		Messagebox('Save As','Failed to save as PDF file, please call support.')
		Return 
	End If
End If
gf_save_dir_path(ls_pdf_path)
SetPointer(Arrow!)
//ShellExecuteA ( Handle( This ), "open", ls_pdf_name + '.pdf' , ls_Null, ls_Null, 4)


end subroutine

public function boolean of_get_pdf_searchable ();// Function: of_get_pdf_searchable
//--------------------------------------------------------------------
// Description: Got the PDF file Type, True: Searchable PDF, False: Image PDF
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 05/19/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_path_file, ls_ocr_text
n_cst_pdf2text lnv_cst_pdf2text

ls_path_file = ole_edit.object.filename
If Not FileExists(ls_path_file) Then
	Return False
End If

If Upper(is_doc_ext) <> 'PDF' Then
	Return False
End If

If ib_have_got_PDF_Searchabled Then
	Return ib_PDF_searchabled
End If

//uo_toolbar.of_set_find_status('Prepare to find...')
lnv_cst_pdf2text.of_pdf2text(ls_path_file, ls_ocr_text)
ib_have_got_PDF_Searchabled = True
If Len(ls_ocr_text) > 0 Then
	ib_PDF_searchabled = True
Else
	ib_PDF_searchabled = False
End If

Return ib_PDF_searchabled
end function

on uo_dm_image_view_cp.create
int iCurrent
call super::create
this.ole_scan=create ole_scan
this.ole_thumbnail=create ole_thumbnail
this.ole_edit=create ole_edit
this.st_v=create st_v
this.uo_toolbar=create uo_toolbar
this.st_doc=create st_doc
this.st_1=create st_1
this.ole_find=create ole_find
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_scan
this.Control[iCurrent+2]=this.ole_thumbnail
this.Control[iCurrent+3]=this.ole_edit
this.Control[iCurrent+4]=this.st_v
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.st_doc
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.ole_find
end on

on uo_dm_image_view_cp.destroy
call super::destroy
destroy(this.ole_scan)
destroy(this.ole_thumbnail)
destroy(this.ole_edit)
destroy(this.st_v)
destroy(this.uo_toolbar)
destroy(this.st_doc)
destroy(this.st_1)
destroy(this.ole_find)
end on

event constructor;call super::constructor;Window lw_parent
of_setresize( true)
inv_resize.of_register( st_1,inv_resize.scaleright)
inv_resize.of_register( uo_toolbar,inv_resize.fixedright)

inv_image_func = create n_cst_image_functions_cp //Alfee 07.28.2008

If gi_imageocx = 2 Then gnv_reg_ocx.of_check_ocx( 4, '', True) //Added by Ken.Guo on 2008-11-07

//Added By Ken.Guo 2009-11-06.
of_GetParentWindow (lw_parent)
If Not isvalid(lw_parent) Then
	uo_toolbar.of_set_find_enable(false)
Else
	If lw_parent.classname( ) <> 'w_contract' Then
		uo_toolbar.of_set_find_enable(false)
	End If
End If

end event

event resize;ole_edit.height = newheight - ole_edit.y

IF ole_edit.visible and ole_thumbnail.visible THEN
	ole_edit.width = newwidth - ole_edit.x 
	ole_thumbnail.width = st_v.x
ELSE 
	ole_edit.width = newwidth - ole_edit.x
	ole_thumbnail.width = ole_edit.width
END IF

ole_thumbnail.height = ole_edit.height
st_v.height = ole_edit.height

st_doc.visible = False
uo_toolbar.x = ole_thumbnail.x + 30
st_1.width = this.width - 16
uo_toolbar.width = This.width - 50


end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(inv_image_func) then Destroy inv_image_func
//---------------------------- APPEON END ----------------------------
end event

type ole_scan from olecustomcontrol within uo_dm_image_view_cp
event click ( )
event dblclick ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event endscan ( )
event ocrrecognized ( boolean bsuccess )
event directscanedpage ( string strfilename )
event scanningerror ( )
event endallscan ( )
event directscanedallpage ( )
boolean visible = false
integer x = 2647
integer y = 728
integer width = 914
integer height = 800
integer taborder = 170
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_dm_image_view_cp.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event endscan();IF IsValid(inv_image_func) THEN inv_image_func.of_set_scanflag(TRUE)
end event

event constructor;This.object.licensekey = '9970'
end event

type ole_thumbnail from olecustomcontrol within uo_dm_image_view_cp
event ondropfiles ( integer ifilecount )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event thumbnailvscroll ( long isbcode,  long isbpos )
event thumbnailhscroll ( long isbcode,  long isbpos )
event click ( integer iclipindex,  string strfilepath,  integer ipageno )
event dblclick ( integer iclipindex,  string strfilepath,  integer ipageno )
event rightclick ( integer iclipindex,  string strfilepath,  integer ipageno )
event thumbnailclick ( integer iclipindex,  string strfilepath,  integer ipageno )
event rightpress ( integer iclipindex,  string strfilepath,  integer ipageno )
event leftpress ( integer iclipindex,  string strfilepath,  integer ipageno )
event dragedclip ( )
integer y = 132
integer width = 800
integer height = 1620
integer taborder = 130
boolean focusrectangle = false
string binarykey = "uo_dm_image_view_cp.udo"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click(integer iclipindex, string strfilepath, integer ipageno);String ls_filename

IF iclipindex < 0 or isnull(iclipindex) THEN return

uo_toolbar.of_set_status('Loading Page...')
ole_edit.setredraw( false)
//Load the selected page 
ls_filename = iole_object.filename
iole_object.LoadMultiPage(ls_filename, iclipindex + 1)
//iole_object.LoadMultiPage(strfilepath, iclipindex + 1) //the strfilepath is not right after a new image inserted

//Added By Ken.Guo 2009-11-10.
If iole_object.view = 8 Then
	of_set_zoom(String(iole_object.viewsize) + '%')
End If
if iole_object.view = 10 then //(Appeon)Stephen 09.14.2017 - Documents importing blank spaces - testing results
	iole_object.view = 10 //Fit to width
	of_set_zoom(-1)  //Set zoom info
else	
	of_set_zoomtext(String(Integer((iole_object.GetScaleX)* 100)))
end if

//Set the scroll toolbars
il_ocx_page = iclipindex + 1
of_set_scroll()
uo_toolbar.of_set_status('')

ole_edit.setredraw( true)

uo_toolbar.Post setfocus( )
end event

event dblclick(integer iclipindex, string strfilepath, integer ipageno);IF iclipindex < 1 or isnull(iclipindex) THEN return
IF is_viewstyle = 'thumb' THEN
	of_set_viewstyle( 'page')
END IF
end event

event constructor;This.object.licensekey = '12500'
This.object.EnableDragFile = False
This.object.EnableMultiSelect = False
This.object.DisplayMode = 0 //0 - Fast Speed, poor Quality        clip size 80x 80 quality
end event

type ole_edit from olecustomcontrol within uo_dm_image_view_cp
event click ( )
event dblclick ( )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event selectionrectdrawn ( long ileft,  long itop,  long iwidth,  long iheight )
event ocrrecognized ( boolean bsuccess )
event dicomplaying ( integer iframeindex )
event ocrpdfa ( integer iprogress )
event loadimagefromurlcompleted ( )
event ocrpdfatextfile ( integer iprogress )
integer x = 814
integer y = 132
integer width = 2926
integer height = 1620
integer taborder = 110
boolean focusrectangle = false
string binarykey = "uo_dm_image_view_cp.udo"
integer binaryindex = 2
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event mouseup(integer button, integer shift, long ocx_x, long ocx_y);ib_draging = FALSE
	
PARENT.EVENT ue_rmbmenu('page')
end event

event keydown(integer keycode, integer shift);//Alfee 10.17.2008

CHOOSE CASE keycode
	CASE 33 //KeyPageUp!
		of_scroll( 'prior')
		
	CASE 34 //KeyPageDown!
		of_scroll( 'next')				
		
END CHOOSE

end event

event constructor;This.object.licensekey = '12820'
This.object.PDFUseAdvancedViewer = true //(Appeon)Stephen 09.05.2017 - Image Viewer CP Upgrade 
iole_object = ole_edit.object
end event

event destructor;IF IsValid(iole_object) THEN Destroy iole_object
end event

type st_v from u_st_splitbar within uo_dm_image_view_cp
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

type uo_toolbar from uo_dm_image_toolbar within uo_dm_image_view_cp
event ue_keydown pbm_keydown
integer x = 18
integer y = 4
integer width = 3858
integer height = 96
integer taborder = 80
end type

event ue_keydown;//Added By Ken.Guo 02/08/2012. 
CHOOSE CASE key
	CASE KeyPageUp!
		of_scroll( 'prior')
		
	CASE KeyPageDown!
		of_scroll( 'next')				
		
END CHOOSE

end event

on uo_toolbar.destroy
call uo_dm_image_toolbar::destroy
end on

event ue_set_viewstyle;call super::ue_set_viewstyle;of_set_viewstyle(as_viewstyle)
end event

event ue_scroll;call super::ue_scroll;of_scroll( as_scrolltype)
end event

event ue_zoom;call super::ue_zoom;of_set_zoom(as_action)

//TRY
//	CHOOSE CASE Lower(as_action)
//		CASE '+'
//			IF  idc_zoom <= 64990 THEN
//				of_set_zoom( Dec(iole_object.zoom+10))
//			END IF
//		CASE '-'
//			IF  idc_zoom >= 15  THEN
//				of_set_zoom( idc_zoom - 10)
//			ELSE
//				of_set_zoom( 5)
//			END IF
//		CASE 'selection'
//			parent.event ue_do('Zoom to Selection')
//			
//		//	CASE 'best fit'
//		//	CASE 'fit to height'
//		//	CASE 'fit to width'
//		CASE ELSE
//			of_set_zoom( as_action)
//			
//	END CHOOSE
//Catch(throwable th)
//END TRY

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

IF NOT of_is_multiimage(is_doc_ext) THEN RETURN

//for multi page file only
li_page = integer(em_page.text)
IF li_page <= iole_object.GetTotalPage() and li_page >0 THEN
	of_scroll( string(li_page))
ELSE
	post of_set_pagetext(string(iole_object.GetTotalPage()))
END IF
	
end event

event ue_set_mousetype;call super::ue_set_mousetype;//inv_image_func.of_annotationtoolselection(ole_edit,as_mousetype )
IF as_mousetype = 'Drag' THEN
	//iole_object.ActionState = miASTATE_PAN 
	p_drag.picturename = 'image_drag_down.bmp'
	p_select.picturename = 'image_arrow.bmp'
	ib_candrag = true
	iole_object.MouseTrackMode=4 
ELSE
	//inv_image_func.of_annotationtoolselection(ole_edit,'SelectionRectangle' )//SelectAnnoAndZones
	//ole_edit.Object.ActionState = miASTATE_NONE 
	p_drag.picturename = 'image_drag.bmp'
	p_select.picturename = 'image_arrow_down.bmp'
	ib_candrag = false
	iole_object.MouseTrackMode=3  
END IF
end event

event ue_show_toolmenu;call super::ue_show_toolmenu;parent.event ue_rmbmenu('tools')
end event

event ue_copy_page;call super::ue_copy_page;Parent.event ue_page_copy( )
end event

event ue_paste;call super::ue_paste;Parent.event ue_page_paste( )
end event

event ue_saveas_pdf;call super::ue_saveas_pdf;Parent.event ue_saveto_pdf( )
end event

event ue_ocr_find;call super::ue_ocr_find;Parent.event ue_ocr_find(as_find_text)
end event

event ue_ocr;call super::ue_ocr;Parent.Event ue_ocr_setting()
If Message.doubleparm = 1 Then
	Parent.event ue_ocr()
End If
end event

type st_doc from statictext within uo_dm_image_view_cp
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

type st_1 from statictext within uo_dm_image_view_cp
integer width = 3739
integer height = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type ole_find from olecustomcontrol within uo_dm_image_view_cp
event click ( )
event dblclick ( )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event selectionrectdrawn ( long ileft,  long itop,  long iwidth,  long iheight )
event ocrrecognized ( boolean bsuccess )
event dicomplaying ( integer iframeindex )
event ocrpdfa ( integer iprogress )
event loadimagefromurlcompleted ( )
event ocrpdfatextfile ( integer iprogress )
boolean visible = false
integer x = 1682
integer y = 120
integer width = 914
integer height = 800
integer taborder = 120
boolean focusrectangle = false
string binarykey = "uo_dm_image_view_cp.udo"
integer binaryindex = 3
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event constructor;This.object.licensekey = '12820'
This.object.PDFUseAdvancedViewer = true //(Appeon)Stephen 09.05.2017 - Image Viewer CP Upgrade 
iole_object = ole_edit.object
end event

event destructor;IF IsValid(iole_object) THEN Destroy iole_object
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
09uo_dm_image_view_cp.bin 
2200000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000003000000000000000000000000000000000000000000000000000000007185650001d32d1f00000003000001c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000440000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000002000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004831a607c4f8e77ca05987fb3fa63ac74000000007185650001d32d1f7185650001d32d1f00000000000000000000000000000001fffffffe000000030000000400000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f004300790070006900720068006700200074006300280020002900300032003500300056002000730069006f00630020006d006f00530074006600610077006500720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe00020106831a607c4f8e77ca05987fb3fa63ac7400000001fb8f0821101b01640008ed8413c72e2b00000030000000a40000000500000100000000300000010100000038000001020000004000000103000000480000000000000050000000030001000000000003000014ac00000003000014ac00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000014ac000014ac0000000000000064000000000000000064040000006f6d655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000060000002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000003000000000000000000000000000000000000000000000000000000007185650001d32d1f00000003000001c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004dc11c60e45674a306905feb92c5e3570000000007185650001d32d1f7185650001d32d1f000000000000000000000000fffffffe000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0065004400650076006f006c00650070002000720069006c006500630073006e003a0065006d00690067006100740065007500680063006d00390070003900390000fffe00020106dc11c60e45674a306905feb92c5e357000000001fb8f0821101b01640008ed8413c72e2b00000030000000a400000005000001000000003000000101000000380000010200000040000001030000004800000000000000500000000300010000000000030000121600000003000029dc00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001216000029dc000000000000010172410500006c6169aa0000000000bfbf00000000ff008080f000ffff6400f0f0080064000000000000000000040101006f6d6544000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000004d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000
280000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000071858c1001d32d1f00000003000001800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004e589da784fc5ad4c479eb9b69e6710b10000000071858c1001d32d1f71858c1001d32d1f000000000000000000000000fffffffe000000020000000300000004fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0065004400650076006f006c00650070002000720069006c006500630073006e003a0065003600350033003700000000000000000000000000000000000000000000fffe00020106e589da784fc5ad4c479eb9b69e6710b100000001fb8f0821101b01640008ed8413c72e2b00000030000000a400000005000001000000003000000101000000380000010200000040000001030000004800000000000000500000000300010000000000030000422500000003000029dc00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000004225000029dc00000000000001010000000000000000000000006564040000646f6d0000000000000000000001006000600050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000003e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000071858c1001d32d1f00000003000001800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004e589da784fc5ad4c479eb9b69e6710b10000000071858c1001d32d1f71858c1001d32d1f000000000000000000000000fffffffe000000020000000300000004fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0065004400650076006f006c00650070002000720069006c006500630073006e003a0065003600350033003700000000000000000000000000000000000000000000fffe00020106e589da784fc5ad4c479eb9b69e6710b100000001fb8f0821101b01640008ed8413c72e2b00000030000000a40000000500000100000000300000010100000038000001020000004000000103000000480000000000000050000000030001000000000003000014ac00000003000014ac00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000014ac000014ac00000000000001010000000000000000000000006564040000646f6d0000000000000000000001006000600050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000003e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
27000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19uo_dm_image_view_cp.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
