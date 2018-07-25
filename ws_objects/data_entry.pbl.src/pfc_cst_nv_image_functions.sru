$PBExportHeader$pfc_cst_nv_image_functions.sru
forward
global type pfc_cst_nv_image_functions from nonvisualobject
end type
end forward

global type pfc_cst_nv_image_functions from nonvisualobject
end type
global pfc_cst_nv_image_functions pfc_cst_nv_image_functions

type variables
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
**  Created By	: Michael B. Skinner xx August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

/****************  MOUSE POINTERS ***********************************************************************/
CONSTANT LONG wiMPDefault 		   = 	0 //(Default)	As determined by the value of the AnnotationType property
CONSTANT LONG wiMPArrow	         = 1	//Arrow
CONSTANT LONG wiMPCross	         = 2	//Cross (cross-hair pointer)
CONSTANT LONG wiMPIBeam	         = 3	//I-Beam
CONSTANT LONG wiMPIcon	         = 4	//Arrow
CONSTANT LONG wiMPSize	         = 5	//Size (four-pointed arrow pointing North, South, East, and West)
CONSTANT LONG wiMPSizeNESW	      = 6	//Size NE SW (double arrow pointing NorthEast and SouthWest)
CONSTANT LONG wiMPSizeNS	      = 7	//Size N S (double arrow pointing North and South)
CONSTANT LONG wiMPSizeNWSE	      = 8	//Size NW SE (double arrow pointing NorthWest and SouthEast)
CONSTANT LONG wiMPSizeWE	      = 9	//Size W E (double arrow pointing West and East)
CONSTANT LONG wiMPUpArrow	      = 10	//Up Arrow
CONSTANT LONG wiMPHourGlass	   = 11	//Hourglass (wait)
CONSTANT LONG wiMPNoDrop	      = 12	//No Drop
CONSTANT LONG wiMPArrowHourglass	= 13 //Arrow and Hourglass
CONSTANT LONG wiMPArrowQuestion	= 14 //Arrow and Question mark
CONSTANT LONG wiMPSizeAll	      = 15 //Size All
CONSTANT LONG wiMPFreehandLine	= 16 //Freehand Line
CONSTANT LONG wiMPHollowRect	   = 17 //Hollow Rectangle
CONSTANT LONG wiMPFilledRect	   = 18 //Filled Rectangle
CONSTANT LONG wiMPRubberStamp	   = 19 //Text Stamp
CONSTANT LONG wiMPText	         = 20 //Text
CONSTANT LONG wiMPTextFromFile	= 21 ///Text From File
CONSTANT LONG wiMPTextAttachment = 22 //Attach-a-Note
CONSTANT LONG wiMPHand	         = 23 //Hand
CONSTANT LONG wiMPSelect	      = 24 //	Image Selection
CONSTANT LONG wiMPHyperlink	   = 25 //Hyperlink
CONSTANT LONG wiMPOcrRegion	   = 26 //	OCR Zone 
CONSTANT LONG wiMPInitials	      = 27 //	Initials
CONSTANT LONG wiMPFilledPolygon	= 28 // Filled Polygon
CONSTANT LONG wiMPHollowPolygon	= 29 //Hollow Polygon
CONSTANT LONG wiMPAutoPolygon	   = 30 //Auto Polygon
CONSTANT LONG wiMPCustom	      = 99 //	Custom pointer specified by the MouseIcon property.


/****************  TOOL IDS ***********************************************************************/

CONSTANT LONG  No_Tool 					= 0
CONSTANT LONG  Selection 				= 1 
CONSTANT LONG  Freehand_Line 			= 2
CONSTANT LONG  Highlighter				= 3
CONSTANT LONG  Straight_Line			= 4
CONSTANT LONG  Hollow_Rectangle		= 5
CONSTANT LONG  Filled_Rectangle		= 6
CONSTANT LONG  TexT                 = 7
CONSTANT LONG  Attach_a_Note	      = 8
CONSTANT LONG  Text_From_File			= 9
CONSTANT LONG  Text_Stamp				= 10
CONSTANT LONG  Hyperlink				= 11
CONSTANT LONG  OCR_Zones				= 12
CONSTANT LONG  Initials					= 13
CONSTANT LONG  Hollow_Polygon			= 14
CONSTANT LONG  Filled_Polygon			= 15
CONSTANT LONG  Auto_Polygon			= 16

CONSTANT LONG  wiAutoDetectQ			= 0
/****************  lay out ***********************************************************************/
CONSTANT LONG  wiAutoDetectL	=0 //default)	Auto detect  the layout of the original is used in the output.
CONSTANT LONG  wiSingleNoPictures	=1//	Single column with no pictures
CONSTANT LONG  wiSingleWithPictures=	2//	Single column with pictures
CONSTANT LONG wiMultipleNoPictures	=3	//Multiple columns with no pictures
CONSTANT LONG wiMultipleWithPictures	=4	//Multiple columns with pictures
CONSTANT LONG wiVerticalSingleNoPictures=	5	//Vertical text, single column, no pictures
CONSTANT LONG wiVerticalSingleWithPictures	=6	//Vertical text, single column, with pictures
CONSTANT LONG wiVerticalMultipleNoPictures	=7	//Vertical text, multiple columns, no pictures
CONSTANT LONG wiVerticalMultipleWithPictures	=8	//Vertical text, multiple columns, with pictures

integer ii_scan_format = - 1
end variables

forward prototypes
public function integer of_cleanup_page (olecustomcontrol ao_edit_control, integer ai_page)
public function integer of_setup_scan (olecustomcontrol ao_scan_object, string as_file, integer li_page_option)
public function integer of_straighten_page (olecustomcontrol ao_scan_object)
public function blob of_read_image_file (string as_file_name)
public function integer of_annotationtoolselection (olecustomcontrol ole_edit, string as_annotationtype)
public function integer of_annotationtoolinitialization (olecustomcontrol ole_edit)
public function integer of_rotatepage (long il_index, olecustomcontrol ole_edit, olecustomcontrol ole_thumbnail)
public function integer of_rotate_all_pages (long al_index, olecustomcontrol ole_edit, olecustomcontrol ole_thumbnail)
public function integer of_tool_item (integer al_index, olecustomcontrol ole_edit, olecustomcontrol ole_ocr, olecustomcontrol ole_admin)
public function integer of_editactionitem (olecustomcontrol ole_edit, integer al_index, olecustomcontrol ole_thumbnail, olecustomcontrol ole_admin, olecustomcontrol ole_ocr)
public function integer of_insert_blank_page (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin, integer al_page, string as_gstrinsertappend)
public function integer of_setthumbsize (olecustomcontrol ole_thumbnail)
public function integer of_show_anotations (integer al_index, olecustomcontrol ole_edit)
public function integer of_pagedirection (olecustomcontrol ole_thumbnail, integer al_index, olecustomcontrol ole_edit)
public function integer of_print (olecustomcontrol ole_admin, olecustomcontrol ole_edit, long al_handel, string as_current_image_path, integer al_start_page, integer al_end_page)
public function integer of_print (olecustomcontrol ole_admin, olecustomcontrol ole_edit, long al_handel, string as_current_image_path)
public function integer of_select_scanner (olecustomcontrol aole_scan)
public function integer of_retrieve_image_from_db (long al_rec_id, long al_prac_id, integer ai_facility_id, integer ai_screen_id, long ai_seq_no)
public function integer of_retrieve_image_from_db (long al_rec_id, long al_prac_id, integer ai_facility_id, integer ai_screen_id, long ai_seq_no, boolean ab_msg)
public function integer of_retrieve_image_for_extract (long al_pk_id, string as_ref, string as_screen, string as_dir)
public function integer of_save_image_to_db (long al_rec_id, long al_prac_id, long ai_facility_id, integer ai_screen_id, long ai_seq_no, string as_ext)
public function integer of_get_verif_doc (string as_doc_id, string as_from, long al_log, string as_file)
end prototypes

public function integer of_cleanup_page (olecustomcontrol ao_edit_control, integer ai_page);String	ls_Rtn

messagebox("page", ai_page)
ao_edit_control.Object.Page( ai_page )
ao_edit_control.Object.FitTo( 3 )
ao_edit_control.Object.Display()
//ao_edit_control.Object.AutoCrop()
//ao_edit_control.Object.AutoDeskew()
ao_edit_control.Object.Despeckle( 4 )

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-15 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(ao_edit_control.Object.Image)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if
//---------------------------- APPEON END ----------------------------

ao_edit_control.Object.Save()
	
Return 1
end function

public function integer of_setup_scan (olecustomcontrol ao_scan_object, string as_file, integer li_page_option);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_setup_scan
//==================================================================================================================
//  Purpose   	: start the scanning process
//==================================================================================================================
//  Arguments 	: [olecustomcontrol]  ao_scan_object
//					: [string]            as_file
//					: [integer]            li_page_option
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: ??????????????????????
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
//   MBSKINNER 			 09 MARCH 2005																Added try catch block
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Integer li_file_type
Integer i
integer s20
LONG LL_RETURN
long li_newcount
boolean lb_showsetup

//Start Code Change ---- 06.13.2006 #534 maha //had not come over from ver 4.5
//this function is called from both imaging and app mapping
s20 = of_get_app_setting("set_20","I")
//----------------appeon begin---------------------
//<$>added:long.zhang 06.14.2013
//<$>reason:Ticket # 00042184: IntelliCred scanning from document feeder
if of_get_app_setting("set_80","I") = 1 then
	lb_showsetup = true
else
	lb_showsetup = false
end if
//---------------appeon end-----------------------
//1 = Black and White; 2  = 16 Grey Scale and 4 = 256 Grey Scale 
if gi_scan_format > 0 then //added maha 031105 (4.520) for scan format option from setting set_29 (set in app open event)
	li_file_type = gi_scan_format
else	
	li_file_type = 1  //B&W default
end if
debugbreak()
//Start Code Change ----09.03.2009 #V92 maha - this will allow on the fly format selection from the imaging screen.
if ii_scan_format = -1 then
	//do nothing
else
	li_file_type = ii_scan_format
end if
//End Code Change---09.03.2009
//End Code Change---06.13.2006

// MBSKINNER 9 MARCH 2005 add try catch-- BEGIN
TRY
	// start code change --- 1.1.2005 MSKINNER
	//-------------Appeon Begin -----by Derek at 03.15.2007---------
	f_setupscan(ao_scan_object)
	//-------------Appeon End   ------------------------------------
	if not (ao_scan_object.Object.ScannerAvailable) then 
		messagebox('Scanner Software Problem','There is not a TWAIN compliant scanner installed on this computer. Scanning cannot continue. Contact your System Administrator to have the scanner installed')
		return -1 
	end if 
	
	// loop until a scanner is selected
	if not f_validstr(ao_scan_object.Object.SelectedScanner) then 
			DO UNTIL f_validstr(ao_scan_object.Object.SelectedScanner)
				 ao_scan_object.object.ShowSelectScanner()
			LOOP
   end if 
	
	
	// end code change --- 1.1.2005 MSKINNER

	ao_scan_object.Object.OpenScanner()
	// start code change --- 1.1.2005 MSKINNER
	// set scanner to native mode 
	ao_scan_object.Object.SetScanCapability( 114, 1 )
	// end code change --- 1.1.2005 MSKINNER
	ao_scan_object.Object.SetScanCapability( 100, li_file_type )

	ao_scan_object.Object.SetScanCapability( 101, 300 ) //maha changed from 200 061306
	ao_scan_object.Object.SetScanCapability( 109, 300 )
//End Code Change---06.13.2006
	if s20 = 2 then //maha added 041805 as trap because it fails on some scanners
		open(w_duplex_setting)
		s20 = message.doubleparm
		if s20 = 1 then
			ao_scan_object.Object.SetScanCapability( 110, FALSE ) //maha032205 duplex off (one sided)
		elseif s20 = 2 then
			ao_scan_object.Object.SetScanCapability( 110, true )
		else //0
			//don't send SetScanCapability
		end if
	end if
	ao_scan_object.Object.ScanTo(1)
	ao_scan_object.Object.PageOption( li_page_option )
	ao_scan_object.Object.Image( as_file )
	ao_scan_object.Object.MultiPage( True )
//	ao_scan_object.Object.ShowSetupBeforeScan( False )
	ao_scan_object.Object.ShowSetupBeforeScan( lb_showsetup )//long.zhang 06.14.2013
	ao_scan_object.Object.StartScan
	ao_scan_object.Object.CloseScanner()
	//------------------appeon begin-------------------
	//<$>added:long.zhang 06.14.2013
	//<$>check if the file was successful scanned
	if lb_showsetup then
		if not fileexists(as_file) then
			MessageBox("Scanning","The file "+ as_file + " was not successfully scanned")				
			LL_RETURN = -1
		end if
	end if
	//-----------------appeon end--------------------------
CATCH (RUNTIMEERROR E)
	LL_RETURN = -1
	ao_scan_object.Object.CloseScanner()
END TRY
// MBSKINNER 9 MARCH 2005 -- END


Return LL_RETURN



end function

public function integer of_straighten_page (olecustomcontrol ao_scan_object);ao_scan_object.object.ManualDeSkew()

Return 0
end function

public function blob of_read_image_file (string as_file_name);ulong l_handle
integer li_filenum, li_loops, li_counter 
long ll_filelen, ll_bytes_read, ll_new_pos 
long ll_cnt
blob lb_our_blob, lb_tot_b, blob_temp, total_blob, blank_blob 
String ls_sql
Long		fh
long  li_retval
blob		lb_image


ll_filelen = FileLength( as_file_name ) 
//messagebox("", ll_filelen)
IF ll_filelen = -1 THEN
	MessageBox("Error", "Error with FileLength command.  Return -1." )
	Return lb_image
END IF

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 11.22.2011
//$<reason>SaaS & Web hosted Appeon error ticket 00032858 - Bug 2787
lb_image = Blob(Space(ll_filelen), EncodingAnsi!) 

//Read file to blob
li_retval = AppeonReadFile(as_file_name, lb_image, ll_filelen)
if li_retval < 0 then
	MessageBox("Error", "Error with FileLength command.  Return -2." )
	setnull(lb_image)
	Return lb_image
end if

/*
li_filenum = FileOpen( as_file_name , StreamMode!,READ!,LOCKREAD!)


IF li_filenum <> -1 THEN
	
	//Find out how long the file specified in sle_filename.text is

	//Determine how many FileReads will be necessary to read all of the file ... 
	//You can't read in more than 32K at a time 
	IF ll_filelen > 32765 THEN 
   	 IF Mod(ll_filelen,32765) = 0 THEN 
	        li_loops = ll_filelen/32765 
	    ELSE 
   	     li_loops = (ll_filelen/32765) + 1 
	    END IF 
	ELSE 
   	 li_loops = 1 
	END IF 

	//read the file ... 
	FOR li_counter = 1 to li_loops 
   	 ll_bytes_read = FileRead( li_filenum, blob_temp) 
		 IF ll_bytes_read = -1 THEN
			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return lb_image
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_read 
	    FileSeek(li_filenum, ll_new_pos, FROMBEGINNING!) 

   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_image = total_blob
	
	//messagebox("len", len( lb_image ))

	FileClose(li_filenum) 
	
	//li_retval = FileRead(li_filenum, lb_image)
	//IF li_retval = -1 THEN
	//	MessageBox("File Read Error", "Could not read file" )
	//	Return -1
	//END IF
	//FileClose(li_filenum)

END IF
*/
//------------------- APPEON END -------------------

RETURN lb_image




end function

public function integer of_annotationtoolselection (olecustomcontrol ole_edit, string as_annotationtype);/******************************************************************************************************************
**  [PUBLIC]   : sets the appropriate annotation tool, based on as_annotationtype passed in.  Also checks the appropriate menu items and presses the appropriate
                   toolbar buttons
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 16 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


try 
    /*----------------------------------------------------------
    ' If not a Rubber Stamp, initialize the annotation tools.
    ' (Initialization prior to setting the Rubber Stamp is
    ' handled differently, since the user can cancel out of
    ' the Rubber Stamp dialog box and so not go through with
    ' the Rubber Stamp.  Therefore, initialization prior to
    ' setting the Rubber Stamp is done only after the user
    ' selects OK in the Rubber Stamp dialog.  See below.)
    '----------------------------------------------------------*/
    If as_annotationtype <> "RubberStamp" Then
       of_AnnotationToolInitialization(ole_edit )
    End If
    
    /*----------------------------------------------------------
    ' Then, select the apppropriate tool, check the menu
    ' item(s), and affiliated toolbar button(s).
    '----------------------------------------------------------*/
    CHOOSE Case as_annotationtype
        Case "Drag"
            ole_edit.object.SelectTool(NO_TOOL)
            ole_edit.object.MousePointer = wiMPHand //'Drag hand
            //mnuEditSelectItem(0).Checked = True 'Edit:  Drag
            //tlbToolbar2.Buttons("Drag").Value = tbrPressed
        Case "SelectionRectangle"
            ole_edit.object.SelectTool(NO_TOOL)
            ole_edit.object.MousePointer = wiMPSelect
            ole_edit.object.SelectionRectangle = True
            //mnuEditSelectItem(1).Checked = True 'Edit:  Select Image
            //tlbToolbar2.Buttons("SelectImage").Value = tbrPressed
        Case "SelectAnnoAndZones"
            ole_edit.object.SelectTool(SELECTION)
           // mnuEditSelectItem(2).Checked = True 'Edit:  Select Annotations and Zones
            //mnuToolsItem(1).Checked = True      'Tools:  Select Zones
           // mnuAnnoToolItem(0).Checked = True   'Anno:  Select Annotations
            //tlbToolbar2.Buttons("SelectAnnoAndZones").Value = tbrPressed
            //tlbToolbar3.Buttons("SelectAnnoAndZones").Value = tbrPressed
        Case "OCRTextZone"
            //ole_edit.object.AnnotationOcrType = wiOcrTypeText
            ole_edit.object.SelectTool(OCR_ZONES)
            //mnuToolsItem(2).Checked = True      'Tools:  Draw Text Zone
           // tlbToolbar2.Buttons("OCRTextZone").Value = tbrPressed
        Case "OCRPictureZone"
            ole_edit.object.AnnotationOcrType = 1
            ole_edit.object.SelectTool(OCR_ZONES)
           // mnuToolsItem(3).Checked = True      'Tools:  Draw Picture Zone
           // tlbToolbar2.Buttons("OCRPictureZone").Value = tbrPressed
        Case "FreehandLine"
            ole_edit.object.SelectTool(FREEHAND_LINE)
            //mnuAnnoToolItem(1).Checked = True   'Anno:  Freehand Line
            //tlbToolbar3.Buttons("FreehandLine").Value = tbrPressed
        Case "Highlighter"
            ole_edit.object.SelectTool(HIGHLIGHTER)
            //mnuAnnoToolItem(2).Checked = True   'Anno:  Highlighter
           // tlbToolbar3.Buttons("Highlighter").Value = tbrPressed
        Case "StraightLine"
            ole_edit.object.SelectTool(STRAIGHT_LINE)
            //mnuAnnoToolItem(3).Checked = True   'Anno:  Straight Line
            //tlbToolbar3.Buttons("StraightLine").Value = tbrPressed
        Case "HollowRectangle"
            ole_edit.object.SelectTool(HOLLOW_RECTANGLE)
            //mnuAnnoToolItem(4).Checked = True   'Anno:  Hollow Rectangle
            //tlbToolbar3.Buttons("HollowRectangle").Value = tbrPressed
        Case "FilledRectangle"
            ole_edit.object.SelectTool(FILLED_RECTANGLE)
            //mnuAnnoToolItem(5).Checked = True   'Anno:  Filled Rectangle
            //tlbToolbar3.Buttons("FilledRectangle").Value = tbrPressed
        Case "TypedText"
             ole_edit.object.SelectTool(TexT)
            //mnuAnnoToolItem(6).Checked = True   'Anno:  Typed Text
            //tlbToolbar3.Buttons("TypedText").Value = tbrPressed
        Case "Hyperlink"
            ole_edit.object.SelectTool(HYPERLINK)
            //mnuAnnoToolItem(7).Checked = True   'Anno:  Hyperlink
           // tlbToolbar3.Buttons("Hyperlink").Value = tbrPressed
        Case "AttachANote"
            ole_edit.object.SelectTool(ATTACH_A_NOTE)
           // mnuAnnoToolItem(8).Checked = True   'Anno:  Attach-a-Note
           // tlbToolbar3.Buttons("AttachANote").Value = tbrPressed
        Case "TextFromFile"
            ole_edit.object.SelectTool(TEXT_FROM_FILE)
            //mnuAnnoToolItem(9).Checked = True   'Anno:  Text From File
           // tlbToolbar3.Buttons("TextFromFile").Value = tbrPressed
        Case "RubberStamp"
            ole_edit.object.ShowRubberStampDialog
            If ole_edit.object.MousePointer = wiMPRubberStamp Then
                of_AnnotationToolInitialization(ole_edit)
                //mnuAnnoToolItem(10).Checked = True  'Anno:  Rubber Stamps...
                //tlbToolbar3.Buttons("RubberStamp").Value = tbrPressed
            Else
                //mnuAnnoToolItem(10).Checked = False 'Anno:  Rubber Stamps...
                //tlbToolbar3.Buttons("RubberStamp").Value = tbrUnpressed
               // Exit Sub
            End If
        Case Else
	End CHOOSE
 
catch (RunTimeError tre)
end try
 return 0
end function

public function integer of_annotationtoolinitialization (olecustomcontrol ole_edit);/******************************************************************************************************************
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



/*----------------------------------------------------------
 ' Set SelectionRectangle to False and deselect any
 ' annotations.
 '---------------------------------------------------------- */
  ole_edit.object.SelectionRectangle = False
    If  ole_edit.object.ImageDisplayed = True Then
         ole_edit.object.DrawSelectionRect(0, 0, 0, 0)   // 'Deselects any annotations
    End If

return 0
end function

public function integer of_rotatepage (long il_index, olecustomcontrol ole_edit, olecustomcontrol ole_thumbnail);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: rotates the page
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

    
    /*----------------------------------------------------------
    ' Rotate the page and set the legend for Undo.
    '----------------------------------------------------------*/
    choose  Case il_index
        Case 0 // 'Left
            ole_edit.object.RotateLeft()
           
        Case 1 // 'Right
            ole_edit.object.RotateRight()
           
        Case 2  //'180
            ole_edit.object.Flip()
            
		End choose
    
    /* ----------------------------------------------------------
    ' Regenerate the thumbnails (if shown) to show the rotation.
    '---------------------------------------------------------- */
        ole_thumbnail.object.ClearThumbs()
        ole_thumbnail.object.GenerateThumb(1)
   
    /*----------------------------------------------------------
    ' Allow the user to undo the rotation.
    '---------------------------------------------------------- */
    //Call SetUndoRedo("Undo")    'Undo is now a valid action.


return 0
end function

public function integer of_rotate_all_pages (long al_index, olecustomcontrol ole_edit, olecustomcontrol ole_thumbnail);/******************************************************************************************************************
**  [PUBLIC]   :  Handles Left  Right, and 180 under the Rotate Pages menu item.
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


    /*----------------------------------------------------------
    ' Rotate all of the pages.  Note that the degree parameter
    ' is in 1/10ths of a degree; therefore, 90 degrees is 900.
    '----------------------------------------------------------*/
    choose Case al_Index
        Case 0 // 'Left
            ole_edit.object.RotateAll(2700)
        Case 1 // 'Right
            ole_edit.object.RotateAll(900)
        Case 2 // '180
            ole_edit.object.RotateAll(1800)
		End choose
    
    /*----------------------------------------------------------
    ' Regenerate the thumbnails (if shown) to show the rotation.
    '---------------------------------------------------------- */
  
        ole_thumbnail.object.ClearThumbs()
        ole_thumbnail.object.GenerateThumb(1)

    
	 
	 return 0

end function

public function integer of_tool_item (integer al_index, olecustomcontrol ole_edit, olecustomcontrol ole_ocr, olecustomcontrol ole_admin);/******************************************************************************************************************
**  [PUBLIC]   :  Handles the OCR..., Select Zones, Draw Text Zone, Draw Picture Zone, Show OCR Zones, Remove All OCR Zones, Remove Speckles, Straighten
                  Page..., and Create Contact Sheet... menu items on the Tools
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


Boolean blnNamingOnly
Integer  intPeriodCounter,intSaveOptions 
Long  lngReturnCode 
string strFullPathFileName 
    
 try 
    choose Case al_index
        Case 0  //OCR...
              
						ole_ocr.object.Quality = wiAutoDetectQ
						ole_ocr.object.Layout = wiAutoDetectL
						ole_ocr.object.ProcessingMode = 0       //Process only OCR zones
						ole_ocr.object.RetainPictures = False   //Do not process pictures
						ole_ocr.object.RetainPageLayout = True  //Source layout retained in output layout    
						ole_ocr.object.OutputType = 4
						ole_ocr.object.OutputFile = "c:\ocr.text"
						ole_ocr.object.LaunchApplication = false
						if ole_ocr.object.ShowOcrOptions() = 1 then 
						   ole_ocr.object.StartOcr()
					    end if 
					 					 
            
        Case 1  //Select Zones
            of_AnnotationToolSelection(ole_edit,"SelectAnnoAndZones")
        Case 2  //Draw Text Zone
            of_AnnotationToolSelection(ole_edit,"OCRTextZone")
        Case 3  //Draw Picture Zone
            of_AnnotationToolSelection(ole_edit,"OCRPictureZone")
        Case 4  //Show OCR Zones
              ole_edit.object.OcrZoneVisibility = 3
        Case 5  //Remove All OCR Zones
            ole_edit.object.RemoveAllOCRMarks()
        Case 6  //----Separator Bar
        Case 7  //Remove Speckles
            ole_edit.object.Despeckle() //Note:  Must save image for despeckling to hold
        Case 8  //Straighten Page
            ole_edit.object.ManualDeSkew
        Case 9  //----Separator Bar
        Case 10 //Create Contact Sheet...
//            //--------------------------------------------------
//            // Set the directory to the default set by the user,
//            // the filename to *.tif, the file filter to TIFF,
//            // and then show the Admin File Dialog.
//            //--------------------------------------------------
//            ole_admin.object.InitDir = gstrDefaultDirectory
//            ole_admin.object.Image = "*.tif"
//            ole_admin.object.Filter = "TIFF document (*.tif)|*.tif|"
//            ole_admin.object.Flags = 0
//            ole_admin.object.ShowFileDialog SaveDlg, frmMain.hWnd
//            //--------------------------------------------------
//            // If the user cancels, set the ole_admin.object..Image
//            // name back to what it was and exit the subroutine.
//            //--------------------------------------------------
//            If Err.Number = CANCEL_PRESSED Then     //32755 = Cancel pressed
//                ole_admin.object..Image = mstrFullPathFileName
//                Exit Sub
//            End If
//            //--------------------------------------------------
//            // Make sure the new file has a ".TIF" extension.
//            //--------------------------------------------------
//            intPeriodCounter = InStr(1, ole_admin.object..Image, ".")
//            If intPeriodCounter = 0 Then
//                ole_admin.object..Image = ole_admin.object..Image & ".tif"
//            End If
//            //--------------------------------------------------
//            // Set the save options:  with hyperlinks back to
//            // the original document, and with the annotations
//            // included (if desired).  Create the contact sheet.
//            //--------------------------------------------------
//            intSaveOptions = 1 + 2048
//            If gblnIncludeAnnotations = True Then
//                intSaveOptions = intSaveOptions + 1024
//            End If
//            ImgThumbnail1.SaveAs ole_admin.object..Image, intSaveOptions
//            //--------------------------------------------------
//            // If the user has set the option to open the
//            // contact sheet after creating it, open it;
//            // otherwise, continue to display the current file.
//            //--------------------------------------------------
//            If gblnOpenContactSheet = True Then
//                strFullPathFileName = ole_admin.object..Image
//                ole_edit.object.Image = ole_admin.object..Image
//                ole_admin.object..Image = ole_edit.object.Image //forces refresh of the Admin control properties
//                blnNamingOnly = False
//                Call PerformFileOpen(blnNamingOnly, strFullPathFileName, 1)
//            Else
//                ole_admin.object..Image = mstrFullPathFileName
//            End If
		Case 11  //OCR...
            	   ole_ocr.object.Quality = wiAutoDetectQ
						ole_ocr.object.Layout = wiAutoDetectL
						ole_ocr.object.ProcessingMode = 1       //Process only OCR zones
						ole_ocr.object.RetainPictures = False   //Do not process pictures
						ole_ocr.object.RetainPageLayout = True  //Source layout retained in output layout    
						ole_ocr.object.OutputType = 4
						ole_ocr.object.OutputFile = "c:\ocr.text"
						ole_ocr.object.LaunchApplication = false
						if ole_ocr.object.ShowOcrOptions() = 1 then 
						   ole_ocr.object.StartOcr()
					    end if 
					 					
		End choose
	
catch (runtimeerror rte)

end try
	 
	 
	 return 0
end function

public function integer of_editactionitem (olecustomcontrol ole_edit, integer al_index, olecustomcontrol ole_thumbnail, olecustomcontrol ole_admin, olecustomcontrol ole_ocr);/******************************************************************************************************************
**  [PUBLIC]   : Handles Cut, Copy,Copy As Text, Copy Page, Paste, Clear, Crop, Delete, and Move... Pages on the File menu.
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

Boolean blnAppend ,blnPageAppended ,blnRegenThumbs
Integer intCounter,intIndex
any sngStoredZoom 
Long lngDeletedPageNo,lngNewPageNo,lngPageNo
 
 
 try 
    choose Case al_index
        Case 0  //Cut
            //--------------------------------------------------
            // Cut:  If a Selection Rectangle was drawn or an
            // annotation was selected, cut the image or
            // annotation.  Allow Undo of the cut, disable the
            // Cut and Copy menu items, and enable the Paste
            // menu item.
            //--------------------------------------------------
            
                ole_edit.object.ClipboardCut()
                ole_edit.object.DrawSelectionRect(0, 0, 0, 0)
			
              
 
           
        Case 1  //Copy
            //--------------------------------------------------
            // Copy:  If a Selection Rectangle was drawn or an
            // annotation was selected, copy the image or
            // annotation.  Then enable the Paste menu item.
            //--------------------------------------------------
           
                ole_edit.object.ClipboardCopy()
                
         
        Case 2  //Copy As Text
            //--------------------------------------------------
            // Copy As Text:  If a Selection Rectangle was
            // drawn, then copy the image, OCR from the
            // Clipboard, and store the results on the Clipboard.
            //--------------------------------------------------
          
                ole_edit.object.ClipboardCopy()
                ole_ocr.object.OcrFromClipBoard = True
                ole_ocr.object.OutputType = 4
                ole_ocr.object.LaunchApplication = False
                ole_ocr.object.CopyToClipBoard = True
                ole_ocr.object.StartOcr()
               
      
        Case 3  //Copy Page
          
            sngStoredZoom = ole_edit.object.Zoom            //Store the current zoom factor
            ole_edit.object.FitTo(0, False)                  //Best fit
            ole_edit.object.DrawSelectionRect(0, 0,ole_edit.object.ImageScaleWidth, ole_edit.object.ImageScaleHeight)
            ole_edit.object.ClipboardCopy                   //Copy page to the Clipboard
               
            ole_edit.object.DrawSelectionRect(0, 0, 0, 0)   //Deselect the selection rectangle
            ole_edit.object.Zoom = sngStoredZoom            //Restore the zoom factor
            ole_edit.object.Refresh
        Case 4  //Paste
            //--------------------------------------------------
            // Paste:  If data is on the Clipboard, then paste
            // the data from the Clipboard.  If the current
            // image is too small, the user will be asked what
            // to do.  If he cancels the Paste, exit the
            // subroutine.  Otherwise, continue with the Paste,
            // allow Undo of the Paste, and enable the Clear
            // menu item.
            //--------------------------------------------------
            If ole_edit.object.IsClipboardDataAvailable = True Then
                ole_edit.object.DrawSelectionRect(0, 0, 0, 0)
                ole_edit.object.ClipboardPaste()
              
            End If
        Case 5  //Clear
            //--------------------------------------------------
            // Clear:  If a Selection Rectangle was drawn, then
            // clear the image; if an annotation was selected,
            // delete the selected annotation.  Disable the
            // Cut/Copy menu items, and Allow Undo of the clear.
            // Note that the two are mutually exclusive:  you
            // cannot have a Selection Rectangle drawn and an
            // annotation selected at the same time.
            //--------------------------------------------------
          
//                If mblnSelectionRectDrawn = True Then
//                    ole_edit.object.DeleteImageData
//                    mblnSelectionRectDrawn = False
//                    Call EnableCutCopy(False, "Rect")
//                Else
//                    ole_edit.object.DeleteSelectedAnnotations
//                    mblnAnnotationSelected = False
//                    mblnAnnotationJustDeleted = True
//                    Call EnableCutCopy(False, "Anno")
//                End If
//                mstrLegendSuffix = "Clear"
//                Call SetUndoRedo("Undo")    //Undo is now a valid action.
//            ElseIf mblnFloatingPaste = True Then
//                If mstrLastRectAnno = "Rect" Then
//                    ole_edit.object.DeleteImageData
//                    mblnSelectionRectDrawn = False
//                    Call EnableCutCopy(False, "Rect")
//                Else
//                    ole_edit.object.DeleteSelectedAnnotations
//                    mblnAnnotationSelected = False
//                    mblnAnnotationJustDeleted = True
//                    Call EnableCutCopy(False, "Anno")
//                End If
//                mstrLegendSuffix = "Clear"
//                Call SetUndoRedo("Undo")    //Undo is now a valid action.
           
        Case 6  //Crop
            //--------------------------------------------------
            // Crop:  If a Selection Rectangle was drawn, then
            // Crop the image and disable the Cut/Copy menu
            // items; otherwise, AutoCrop the image.  Then allow
            // Undo of the Crop/AutoCrop.
            //--------------------------------------------------
           
                ole_edit.object.AutoCrop()
           
            //mstrLegendSuffix = "Crop"
           // Call SetUndoRedo("Undo")    //Undo is now a valid action.
        Case 7  //Delete Pages
            //--------------------------------------------------
            // Delete:  Loop through the image pages, deleting
            // those pages which have been selected.
            //--------------------------------------------------
            For intCounter = ole_thumbnail.object.ThumbCount To 1 Step -1
               If ole_thumbnail.object.ThumbSelected(intCounter) = True Then
                    lngDeletedPageNo = intCounter
                    ole_edit.object.ClearDisplay
                    ole_admin.object.DeletePages(lngDeletedPageNo, 1)
                    ole_thumbnail.object.DeleteThumbs(lngDeletedPageNo, 1)
                End If
            Next 
            //--------------------------------------------------
            // Set the new page to display as one less than the
            // last deleted page (unless page 1 was deleted);
            // then enable the page menus and display the image.
            //--------------------------------------------------
            If lngDeletedPageNo > 1 Then
                lngNewPageNo = lngDeletedPageNo - 1
            Else
                lngNewPageNo = 1
            End If
            ole_edit.object.Page = lngNewPageNo
            //gblnInitialDisplayOfThisImage = False
            //blnRegenThumbs = False
           // Call EnablePageMenusAndDisplay(ole_edit.object.Page, blnRegenThumbs)
        Case 8  //Move Pages...
//            //--------------------------------------------------
//            // Move:  Show the MovePage form to find out which
//            // page the selected page(s) should be moved before.
//            // If no page is selected, exit the subroutine.
//            // If an append, copy Page 1 to the end of the file
//            // so you can do inserts before it (and thus append).
//            //--------------------------------------------------
//           
//            If glngMoveBeforePage = 0 Then
//                Exit Sub
//            ElseIf glngMoveBeforePage > ole_edit.object.PageCount Then
//                blnAppend = True
//                ole_admin.object.append(ole_admin.object.Image, 1, 1)
//                ole_thumbnail.object.InsertThumbs(glngMoveBeforePage, 1)
//            Else
//                blnAppend = False
//            End If
//            //--------------------------------------------------
//            // Loop through the image pages, moving those pages
//            // which have been selected.  (Moving is done with
//            // an insert and corresponding delete.)
//            //--------------------------------------------------
//            For lngPageNo = ole_thumbnail.object.ThumbCount To 1 Step -1
//                If ole_thumbnail.object.ThumbSelected(lngPageNo) = True Then
//                    //------------------------------------------
//                    // Insert the page.
//                    //------------------------------------------
//                    ole_admin.object..Insert ole_admin.object..Image, lngPageNo, glngMoveBeforePage, 1
//                    ole_thumbnail.object.InsertThumbs glngMoveBeforePage, 1
//                    //------------------------------------------
//                    // Delete the page.
//                    //------------------------------------------
//                    If lngPageNo > glngMoveBeforePage Then
//                        lngPageNo = lngPageNo + 1
//                    Else
//                        lngPageNo = lngPageNo
//                        glngMoveBeforePage = glngMoveBeforePage - 1
//                    End If
//                    ole_edit.object.ClearDisplay
//                    ole_admin.object..DeletePages lngPageNo, 1
//                    ole_thumbnail.object.DeleteThumbs lngPageNo, 1
//                End If
//            Next lngPageNo
//            //--------------------------------------------------
//            // If an append, delete the extra Page 1 that was
//            // added above.
//            //--------------------------------------------------
//            If blnAppend = True Then
//                ole_edit.object.ClearDisplay
//                ole_admin.object..DeletePages ole_edit.object.PageCount, 1
//                ole_thumbnail.object.DeleteThumbs ole_edit.object.PageCount, 1
//            End If
//            //--------------------------------------------------
//            // Reset the selected page and display the page.
//            //--------------------------------------------------
//            gblnInitialDisplayOfThisImage = False
//            ole_edit.object.Page = glngMoveBeforePage
//            blnRegenThumbs = True
//            Call EnablePageMenusAndDisplay(ole_edit.object.Page, blnRegenThumbs)
End choose

catch (runtimeerror rte)

end try 
        



return 0
end function

public function integer of_insert_blank_page (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin, integer al_page, string as_gstrinsertappend);/******************************************************************************************************************
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
//**************************************************************
// PRIVATE SUB cmdOK_Click:  Display a blank image according
// to the specifications, save it, and display it, and then
// unload the form.
//**************************************************************


Boolean blnNamingOnly,blnRegenThumbs
Long lngCurrentPage,lngCurrentPageCount,mintCompressionInfo
String strWorkfileName, strFullPathWorkfileName,ls_Rtn
any vntWorkingString 
    
  
        
    //----------------------------------------------------------
    // Hide the form and store the page number and page count of
    // the currently displayed file.
    //----------------------------------------------------------
   
    lngCurrentPage = ole_edit.object.Page
    lngCurrentPageCount = ole_edit.object.PageCount
    
    //----------------------------------------------------------
    // Have the Admin control generate a unique file name.
    // Then store the resulting file name and path in
    // strWorkfileName and strFullPathWorkfileName, respectively.
    //----------------------------------------------------------
    strWorkfileName = ole_admin.object.GetUniqueName('c:\', "Img", "Tif")
    strFullPathWorkfileName = 'c:\' + strWorkfileName
      
    //----------------------------------------------------------
    // Display the blank image in the Workfile control and then
    // save it.
    //----------------------------------------------------------
    ole_edit_work.object.DisplayBlankImage (ole_edit.object.ImageWidth, ole_edit.object.ImageHeight, 200, 200, ole_edit.object.pagetype)
        
    mintCompressionInfo = ole_edit.object.CompressionInfo()
	 
	 //--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-15 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(strFullPathWorkfileName)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return -1
	end if
	//---------------------------- APPEON END ----------------------------

    ole_edit_work.object.SaveAs(strFullPathWorkfileName, 1,1, 1, 0,true)
    
    //----------------------------------------------------------
    // Insert or append the new blank page.
    //----------------------------------------------------------
    If as_gstrinsertappend = "Insert" Then
        ole_admin.object.Insert(strFullPathWorkfileName, 1, lngCurrentPage, 1)
    Else
        ole_admin.object.Append(strFullPathWorkfileName, 1, 1)
        lngCurrentPage = lngCurrentPageCount + 1
    End If
    
    //----------------------------------------------------------
    // Delete the workfile.
    //----------------------------------------------------------
    
//    strWorkfileName = Dir(strFullPathWorkfileName)
//    If strWorkfileName <> "" Then
//        DoEvents
//        Kill strFullPathWorkfileName
//    End If
        
    //--------------------------------------------------
    // Reset the thumbnail image so that the page count
    // is updated, and set the page to the newly-created
    // page.
    //--------------------------------------------------
    ole_thumbnail.object.Image = ole_edit.object.Image
    ole_edit.object.Page = lngCurrentPage

//    //--------------------------------------------------
//    // Redisplay the pages and unload the form.
//    //--------------------------------------------------
//    gblnInitialDisplayOfThisImage = False
//    blnRegenThumbs = True
//    Call frmMain.EnablePageMenusAndDisplay(lngCurrentPage, blnRegenThumbs)
//        

	 
	 
	 

return 0
end function

public function integer of_setthumbsize (olecustomcontrol ole_thumbnail);/******************************************************************************************************************
**  [PUBLIC]   : of_setthumbsize
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 17 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long lMinSize, lMaxSize, lVSize, lHSize
Boolean bScroll
Long     iNonScrollThumbCount 
bScroll = True

iNonScrollThumbCount = 2     
ole_thumbnail.object.ScrollDirection = 0   // Horizontal
ole_thumbnail.object.UISetThumbSize()      //'User sets thumb size interactively 

///'Determine min and max control size taking a scrollbar into account

lMinSize = ole_thumbnail.object.GetMinimumSize(iNonScrollThumbCount, bScroll)
lMaxSize = ole_thumbnail.object.GetMaximumSize(iNonScrollThumbCount, bScroll)
lVSize = (lMinSize + lMaxSize) / 2  //Average of the min & max nonscrolling size

ole_thumbnail.Height = lVSize

return 0
end function

public function integer of_show_anotations (integer al_index, olecustomcontrol ole_edit);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 18 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/




choose Case al_index
        Case 1  //Hide annotations.
            ole_edit.object.HideAnnotationGroup() 
        Case 2 //Show annotations.
				ole_edit.object.ShowAnnotationGroup() 
End choose


ole_edit.object.Refresh()

return 0


end function

public function integer of_pagedirection (olecustomcontrol ole_thumbnail, integer al_index, olecustomcontrol ole_edit);/******************************************************************************************************************
**  [PUBLIC]   : of_PageDirection
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [integer]           al_index
**  Arguments 	: [olecustomcontrol]  ole_edit
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 18 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

   Boolean blnRegenThumbs 

   Long   lngFormerPageBuffer,mlngFormerPage 

try 
//  If ole_edit.object.ImageModified = True  Then
//	  ole_edit.object.Save()
//   end if
//
    //----------------------------------------------------------
    // Unless Go Back selected, store the current page number
    // in former page number.  (Go Back handled in the Select
    // Case below).
    //----------------------------------------------------------
    If al_index <> 6 Then   //If not Go Back
        mlngFormerPage = ole_edit.object.Page()
    End If
   	
    //----------------------------------------------------------
    // Set the page numbers and display the image.
    //----------------------------------------------------------
    choose Case al_index
        Case 0  //Previous
				 If mlngFormerPage > 1 Then
                ole_edit.object.Page(mlngFormerPage - 1)
			    end if 
        Case 1  //Next
				if mlngFormerPage < ole_edit.object.PageCount() Then
               ole_edit.object.Page(mlngFormerPage + 1)
			   end if 
        Case 2  //First
            ole_edit.object.Page(1)
        Case 3  //Last
            ole_edit.object.Page(ole_edit.object.PageCount)
       Case 6  //Go Back
            If mlngFormerPage >= 1 And mlngFormerPage <= ole_edit.object.PageCount() Then
                lngFormerPageBuffer = ole_edit.object.Page()
                ole_edit.object.Page = mlngFormerPage
                mlngFormerPage = lngFormerPageBuffer
            End If
		End choose

    //----------------------------------------------------------
    // Deselect all of the thumbnails, select the current page,
    // and then display the thumbnails.
   // ----------------------------------------------------------
   //ole_thumbnail.object.Image =ole_edit.object.Image
   //ole_thumbnail.object.ThumbSelected(ole_edit.object.Page(1))
	
	
	
	
	ole_edit.object.Display()
catch (runtimeerror rte)
end try
 
   return 0
end function

public function integer of_print (olecustomcontrol ole_admin, olecustomcontrol ole_edit, long al_handel, string as_current_image_path, integer al_start_page, integer al_end_page);/******************************************************************************************************************
**  [PUBLIC]   : Open ImgAdmin's Print dialog and call ImgEdit's Print function with the user selected
**==================================================================================================================
**  Purpose   	: Opens the print dialog with a specific print range
**==================================================================================================================
**  Arguments 	: [olecustomcontrol] ole_admin
**             : [olecustomcontrol] ole_edit
**             : [long]             al_handel
**             : [string]           as_current_image_path
**             : [integer]          al_start_page
**             : [integer]          al_end_page
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	Over ridden  !!!!!!!!!!!!!!!!!!!!!!!!
**==================================================================================================================
**  Created By	: Michael B. Skinner 30 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**  mskinner                09 March 2006 									 -- added ole_admin.object.PrintOutputFormat = 3
**                                                                       some customers complain that that intellicred prints diffrent from Imaging
**	                                                                      this may be true. Since the default scale in imaging id "Best Fit" intellicred 
**                                                                       is actual size.
********************************************************************************************************************/

Boolean blnAnnotations
Integer intFormat = 3
integer i
integer li_num
long ll_range

//02.14.2008 By Jervis
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 04.01.2006 By: Rodger Wu
//$<reason> TRY...CATCH...END TRY statement is currently unsupported on the Web.
//$<modification> Add the following script to ensure that when the application is running on the Web,
//$<modification> only the following script will be executed and then return.  When the application is
//$<modification> running in PB, the original TRY ... CATCH ... END statement will be executed.

If appeongetclienttype() = 'WEB' Then
	s_printdlgattrib lstr_print, lstr_return
	Integer li_option = 0
	
	lstr_print.l_frompage = al_start_page
	lstr_print.l_topage = al_end_page
	lstr_print.l_minpage = al_start_page
	lstr_print.l_maxpage = al_end_page
	lstr_print.b_disableselection = True
	
	li_option = ole_admin.object.PrintRangeOption
	choose case li_option
		case 0
			lstr_print.b_allpages = true
		case 1
			lstr_print.b_pagenums = true
		case 2
			lstr_print.b_pagenums = true
			lstr_print.l_frompage = ole_edit.object.page
			lstr_print.l_topage = ole_edit.object.page
	End Choose
	
	OpenWithParm( w_print, lstr_print ) //Call PFC print window;
	lstr_return = Message.PowerObjectParm
	
	If lstr_return.b_disablepagenums Then
		ole_admin.object.PrintNumCopies = lstr_return.l_copies
		ole_admin.object.PrintStartPage = lstr_return.l_frompage
		ole_admin.object.PrintEndPage = lstr_return.l_topage
		
		If lstr_return.b_allpages Then
		 ole_admin.object.PrintRangeOption = 0
		Elseif lstr_return.b_pagenums Then
		 ole_admin.object.PrintRangeOption = 1
		else
		end if
	Else
		Return 0;
	End If

	ll_range = ole_admin.object.PrintRangeOption
	choose case ll_range
		CASE 0 // ALL
			 intFormat = ole_admin.object.PrintOutputFormat
			 blnAnnotations = ole_admin.object.PrintAnnotations
			 ole_edit.object.PrintImage(ole_admin.object.PrintStartPage, ole_admin.object.PrintEndPage, intFormat, blnAnnotations)
		CASE 1 // page range
			 intFormat = ole_admin.object.PrintOutputFormat
			 blnAnnotations = ole_admin.object.PrintAnnotations
			 ole_edit.object.PrintImage(ole_admin.object.PrintStartPage, ole_admin.object.PrintEndPage, intFormat, blnAnnotations)
		CASE 2 // current page
			 intFormat = ole_admin.object.PrintOutputFormat
			 blnAnnotations = ole_admin.object.PrintAnnotations
			 ole_edit.object.PrintImage(ole_edit.object.page, ole_edit.object.page, intFormat, blnAnnotations)
	END CHOOSE
	Return 0
End If
//---------------------------- APPEON END ----------------------------
*/
try 
	//Start Code Change ----04.20.2011 #V11 maha 	- added option for print format
	i = of_get_app_setting("set_53","I")
	if i = 1 then
		intFormat = 1 
	else
		intFormat = 3
	end if
	//messagebox("ofprint",intformat)
	ole_admin.object.PrintOutputFormat = intFormat
    ole_admin.object.PrintNumCopies = 1 
    ole_admin.object.PrintStartPage = al_start_page
    ole_admin.object.PrintEndPage = al_end_page
    ole_admin.object.Flags = 0
    ole_admin.object.ShowPrintDialog(al_handel)  //sets the number of pages and page range
	if appeongetclienttype() = "WEB" then
		if ole_admin.object.StatusCode = -2146795533 then return 0 //Cancel (Bug 2874) - alfee 01.18.2012
	end if	 
	 ll_range = ole_admin.object.PrintRangeOption
  //---------Begin Added by (Appeon)Stephen 07.04.2014 for Bug 4100 : Printing a page 2x from preview in app mapping with print the page 4x --------
	li_num = ole_admin.object.PrintNumCopies
	ole_admin.object.PrintNumCopies = 1
//	ole_admin.object.PrintNumCopies = li_num //Commented by (Appeon)Stephen 09.11.2014
 //---------End Added ------------------------------------------------------

   choose case ll_range
		CASE 0 // ALL
			// intFormat = ole_admin.object.PrintOutputFormat
          blnAnnotations = ole_admin.object.PrintAnnotations
          ole_edit.object.PrintImage(ole_admin.object.PrintStartPage, ole_admin.object.PrintEndPage, intFormat, blnAnnotations)
		CASE 1 // page range
		//	 intFormat = ole_admin.object.PrintOutputFormat
    		 blnAnnotations = ole_admin.object.PrintAnnotations
		    ole_edit.object.PrintImage(ole_admin.object.PrintStartPage, ole_admin.object.PrintEndPage, intFormat, blnAnnotations)
		CASE 2 // current page
		//	 intFormat = ole_admin.object.PrintOutputFormat
    		 blnAnnotations = ole_admin.object.PrintAnnotations
		    ole_edit.object.PrintImage(ole_edit.object.page, ole_edit.object.page, intFormat, blnAnnotations)
	END CHOOSE
	//End Code Change ----04.20.2011
 
  catch (runtimeerror rte )
	 
end try
ole_admin.object.PrintNumCopies = 1  //(Appeon)Stephen 07.04.2014 - Bug 4100 : Printing a page 2x from preview in app mapping with print the page 4x   
	 
return 0
end function

public function integer of_print (olecustomcontrol ole_admin, olecustomcontrol ole_edit, long al_handel, string as_current_image_path);/******************************************************************************************************************
**  [PUBLIC]   : Open ImgAdmin's Print dialog and call ImgEdit's Print function with the user selected
**==================================================================================================================
**  Purpose   	: Opens the print dialog with a specific print range
**==================================================================================================================
**  Arguments 	: [olecustomcontrol] ole_admin
**             : [olecustomcontrol] ole_edit
**             : [long]             al_handel
**             : [string]           as_current_image_path
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	Over ridden  !!!!!!!!!!!!!!!!!!!!!!!!
**==================================================================================================================
**  Created By	: Michael B. Skinner 30 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Boolean blnAnnotations
Integer intFormat
integer i
integer li_num
long ll_range

try 
	//Start Code Change ----04.20.2011 #V11 maha 	- added option for print format
	i = of_get_app_setting("set_53","I")
	if i = 1 then
		intFormat = 1 
	else
		intFormat = 3
	end if
	messagebox("print",intformat)
	ole_admin.object.PrintOutputFormat = intFormat
    ole_admin.object.PrintNumCopies = 1 
    ole_admin.object.Flags = 0
    ole_admin.object.ShowPrintDialog(al_handel)
	 ll_range = ole_admin.object.PrintRangeOption
  //---------Begin Added by (Appeon)Stephen 07.04.2014 for Bug 4100 : Printing a page 2x from preview in app mapping with print the page 4x --------
	li_num = ole_admin.object.PrintNumCopies
	ole_admin.object.PrintNumCopies = 1
	//ole_admin.object.PrintNumCopies = li_num //Commented by (Appeon)Stephen 09.11.2014 
 //---------End Added ------------------------------------------------------
   choose case ll_range
		CASE 0 // ALL
			// intFormat = ole_admin.object.PrintOutputFormat
          	blnAnnotations = ole_admin.object.PrintAnnotations
         	ole_edit.object.PrintImage(ole_admin.object.PrintStartPage, ole_admin.object.PrintEndPage, intFormat, blnAnnotations)
		CASE 1 // page range
			// intFormat = ole_admin.object.PrintOutputFormat
    			blnAnnotations = ole_admin.object.PrintAnnotations
		    ole_edit.object.PrintImage(ole_admin.object.PrintStartPage, ole_admin.object.PrintEndPage, intFormat, blnAnnotations)
		CASE 2 // current page
			// intFormat = ole_admin.object.PrintOutputFormat
    			blnAnnotations = ole_admin.object.PrintAnnotations
		    ole_edit.object.PrintImage(ole_edit.object.page, ole_edit.object.page, intFormat, blnAnnotations)
	END CHOOSE
		//END Code Change ----04.20.2011
 
  catch (runtimeerror rte )
	 
end try
    
ole_admin.object.PrintNumCopies = 1  //(Appeon)Stephen 07.04.2014 - Bug 4100 : Printing a page 2x from preview in app mapping with print the page 4x   
	 
return 0
end function

public function integer of_select_scanner (olecustomcontrol aole_scan);aole_scan.object.ShowSelectScanner()

return 1
end function

public function integer of_retrieve_image_from_db (long al_rec_id, long al_prac_id, integer ai_facility_id, integer ai_screen_id, long ai_seq_no);Long ll_rec_id
Long ll_prac_id
Long li_seq_no
Integer li_start_page
Integer li_num_pages
Integer li_screen_id
Integer li_facility_id
Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob

//Start Code Change ---- 05.17.2006 #460 maha
string ls_file

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.27.2006 By: LeiWei
//$<reason> Performance tuning
/*
ls_file = gs_dir_path + "IntelliCred\temp.tif"
*/
SetPointer(HourGlass!)

String ls_filename
String ls_filedate_local, ls_filedate_server
Datetime ldt_filedate_server
String ls_ext //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

//Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
Select modify_date, image_ext
Into :ldt_filedate_server, :ls_ext
FROM pd_images
WHERE prac_id = :al_prac_id AND
		image_pk = :ai_seq_no 
USING SQLCA;

//Start Code Change ----03.29.2011 #V11 maha - change the file name to reflect the new pk id
ls_filename = String(al_prac_id) + "_" + String(ai_seq_no) + "." + ls_ext //Midified by (APPEON) Harry 11.08.2017 modify ".tif" to ls_ext


//ls_filename = String(al_rec_id) + "_" + String(al_prac_id) + "_" + &
//String(ai_facility_id) + "_" + String(ai_screen_id) + "_" + String(ai_seq_no) + ".tif"
//End Code Change ----03.29.2011
 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.14.2007 By: Jack
//$<reason> Fix a defect.

ls_file = gs_temp_path + "images\"   //Start Code Change ----07.01.2008 #V81 maha - changed back.  the correction added an extra \

//ls_file = gs_dir_path + "\intellicred\Images\"
gnv_appeondll.of_parsepath(ls_file)
ls_file = ls_file + ls_filename

//Commented by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs) 
/*
//Start Code Change ----03.29.2011 #V11 maha - change the file name to reflect the new pk id
Select modify_date
Into :ldt_filedate_server
FROM pd_images
WHERE prac_id = :al_prac_id AND
		image_pk = :ai_seq_no 
USING SQLCA;
//End Code Change ----03.29.2011
*/

ls_filedate_server = String(ldt_filedate_server, 'mm/dd/yyyy hh:mm:ss')
IF Isnull(ls_filedate_server) OR ls_filedate_server="" THEN ls_filedate_server =  String(today(), 'mm/dd/yyyy hh:mm:ss')

// Check file time
IF FileExists(ls_file) THEN
	// Get local file modify date
	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Prac Images", ls_filename, RegString!, ls_filedate_local)

	// Check file modify date
	IF ls_filedate_local = ls_filedate_server THEN RETURN 100
END IF

//---------------------------- APPEON END ----------------------------

//End Code Change---05.17.2006
//ll_rec_id = dw_images.GetItemNumber( li_cr, "pd_images_rec_id" )
//ll_prac_id = dw_images.GetItemNumber( li_cr, "pd_images_prac_id" )	
//li_facility_id = dw_images.GetItemNumber( li_cr, "pd_images_facility_id" )	
//li_screen_id = dw_images.GetItemNumber( li_cr, "pd_images_screen_id" )		
//li_seq_no = dw_images.GetItemNumber( li_cr, "pd_images_seq_no" )	
//debugbreak()

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
SELECTBLOB image_data
INTO :lb_image_data
FROM pd_images
WHERE rec_id = :al_rec_id AND
      prac_id = :al_prac_id AND
		facility_id = :ai_facility_id AND
		seq_no = :ai_seq_no AND
		screen_id = :ai_screen_id
USING SQLCA;
*/

// Open processs window
openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	//Start Code Change ----03.29.2011 #V11 maha - changed from of_get_image_pd_images
	of_get_image_pd_images2( ai_seq_no,  lb_image_data)
ELSE
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 08.24.2007 By: Evan
	//$<Reason> The facility_id argument is not requirement.
	/*
	SELECTBLOB image_data
	INTO :lb_image_data
	FROM pd_images
	WHERE rec_id = :al_rec_id AND
			prac_id = :al_prac_id AND
			facility_id = :ai_facility_id AND
			seq_no = :ai_seq_no AND
			screen_id = :ai_screen_id
	USING SQLCA;
	*/
	//Start Code Change ----03.29.2011 #V11 maha - changed to use image pk
	SELECTBLOB image_data
	INTO :lb_image_data
	FROM pd_images
	WHERE 	image_pk = :ai_seq_no
	USING SQLCA;
	//---------------------------- APPEON END ----------------------------
END IF

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

//---------------------------- APPEON END ----------------------------


IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.12.2006 By: LeiWei
//$<reason> Fix a defect.
IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF
//---------------------------- APPEON END ----------------------------


//Start Code Change ---- 06.08.2007 #V7 maha  replaced code with function
//IF ll_filelen > 32765 THEN 
//  	 IF Mod(ll_filelen,32765) = 0 THEN 
//        li_loops = ll_filelen/32765 
//    ELSE 
//  	     li_loops = (ll_filelen/32765) + 1 
//    END IF 
//ELSE 
//  	 li_loops = 1 
//END IF 


//Start Code Change ---- 05.17.2006 #460 maha

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1
	
//FileDelete( ls_file )
//
//li_filenum =  FileOpen( ls_file, StreamMode!, Write!, LockWrite!, Append!)
////End Code Change---05.17.2006
//
//ll_new_pos = 1
//
//IF li_filenum <> -1 THEN	
//	//read the file ... 
//	FOR li_counter = 1 to li_loops 
//		 blob_temp = BlobMid( lb_image_data, ll_new_pos, 32765 )
//   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
//		 IF ll_bytes_written = -1 THEN
//			MessageBox("Error", "Error with FileRead command.  Return -1." )
//			Return -1
//		 END IF
//	    lb_tot_b = lb_tot_b + blob_temp 
//   	 ll_new_pos = ll_new_pos + ll_bytes_written 
//	    //FileSeek(li_filenum, 0, FROMEND!) 
//   	 if len(lb_tot_b) > 1000000 then 
//	        total_blob = total_blob + lb_tot_b 
//   	     lb_tot_b = blank_blob 
//	    end if 
//	NEXT 
//
//	total_blob = total_blob + lb_tot_b 
//
//	lb_image_data = total_blob
//	
//	FileClose( li_filenum )
//
//ELSE
//	MessageBox( "File Open Error", "Could not open snapshot.jpg for StreamMode!" )
//	Return -	1
//END IF

//End Code Change---06.08.2007

IF Not FileExists( ls_file) THEN  //Start Code Change ---- 05.17.2006 #460 maha
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.14.2007 By: Jack
	//$<reason> Fix a defect.
	
	MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
	//Start Code Change ----07.01.2008 #V81 maha - changed back
	//MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + "\intellicred\Images\" + " is valid." )	
	//---------------------------- APPEON END ----------------------------
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: LeiWei
//$<reason> Set last modify date to registry

gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Prac Images", ls_filename, RegString!, ls_filedate_server)	

//---------------------------- APPEON END ----------------------------

Return 1

end function

public function integer of_retrieve_image_from_db (long al_rec_id, long al_prac_id, integer ai_facility_id, integer ai_screen_id, long ai_seq_no, boolean ab_msg);//====================================================================
//$<Function>: of_retrieve_image_from_db
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: add ab_msg -shield w_appeon_gifofwait
//$<Author>: (Appeon) Stephen 10.22.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_rec_id
Long ll_prac_id
Long li_seq_no
Integer li_start_page
Integer li_num_pages
Integer li_screen_id
Integer li_facility_id
Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob

//Start Code Change ---- 05.17.2006 #460 maha
string ls_file

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.27.2006 By: LeiWei
//$<reason> Performance tuning
/*
ls_file = gs_dir_path + "IntelliCred\temp.tif"
*/
SetPointer(HourGlass!)

String ls_filename
String ls_filedate_local, ls_filedate_server
Datetime ldt_filedate_server
String ls_ext //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

//Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
Select modify_date, image_ext
Into :ldt_filedate_server, :ls_ext
FROM pd_images
WHERE prac_id = :al_prac_id AND
		image_pk = :ai_seq_no 
USING SQLCA;

//Start Code Change ----03.29.2011 #V11 maha - change the file name to reflect the new pk id
ls_filename = String(al_prac_id) + "_" + String(ai_seq_no) +  ls_ext //Midified by (APPEON) Harry 11.08.2017 modify ".tif" to ls_ext

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.14.2007 By: Jack
//$<reason> Fix a defect.

ls_file = gs_temp_path + "images\"   //Start Code Change ----07.01.2008 #V81 maha - changed back.  the correction added an extra \

//ls_file = gs_dir_path + "\intellicred\Images\"
gnv_appeondll.of_parsepath(ls_file)
ls_file = ls_file + ls_filename

//Commented by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
/*
//Start Code Change ----03.29.2011 #V11 maha - change the file name to reflect the new pk id
Select modify_date
Into :ldt_filedate_server
FROM pd_images
WHERE prac_id = :al_prac_id AND
		image_pk = :ai_seq_no 
USING SQLCA;
//End Code Change ----03.29.2011
*/

ls_filedate_server = String(ldt_filedate_server, 'mm/dd/yyyy hh:mm:ss')
IF Isnull(ls_filedate_server) OR ls_filedate_server="" THEN ls_filedate_server =  String(today(), 'mm/dd/yyyy hh:mm:ss')

// Check file time
IF FileExists(ls_file) THEN
	// Get local file modify date
	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Prac Images", ls_filename, RegString!, ls_filedate_local)

	// Check file modify date
	IF ls_filedate_local = ls_filedate_server THEN RETURN 100
END IF

//---------------------------- APPEON END ----------------------------


// Open processs window
if ab_msg then openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	//Start Code Change ----03.29.2011 #V11 maha - changed from of_get_image_pd_images
	of_get_image_pd_images2( ai_seq_no,  lb_image_data)
ELSE
	
	//Start Code Change ----03.29.2011 #V11 maha - changed to use image pk
	SELECTBLOB image_data
	INTO :lb_image_data
	FROM pd_images
	WHERE 	image_pk = :ai_seq_no
	USING SQLCA;
	//---------------------------- APPEON END ----------------------------
END IF

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

//---------------------------- APPEON END ----------------------------


IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.12.2006 By: LeiWei
//$<reason> Fix a defect.
IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF
//---------------------------- APPEON END ----------------------------


//Start Code Change ---- 06.08.2007 #V7 maha  replaced code with function
//IF ll_filelen > 32765 THEN 
//  	 IF Mod(ll_filelen,32765) = 0 THEN 
//        li_loops = ll_filelen/32765 
//    ELSE 
//  	     li_loops = (ll_filelen/32765) + 1 
//    END IF 
//ELSE 
//  	 li_loops = 1 
//END IF 


//Start Code Change ---- 05.17.2006 #460 maha

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1


IF Not FileExists( ls_file) THEN  //Start Code Change ---- 05.17.2006 #460 maha
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.14.2007 By: Jack
	//$<reason> Fix a defect.
	
	MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
	//Start Code Change ----07.01.2008 #V81 maha - changed back
	//MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + "\intellicred\Images\" + " is valid." )	
	//---------------------------- APPEON END ----------------------------
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: LeiWei
//$<reason> Set last modify date to registry

gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Prac Images", ls_filename, RegString!, ls_filedate_server)	

//---------------------------- APPEON END ----------------------------

Return 1

end function

public function integer of_retrieve_image_for_extract (long al_pk_id, string as_ref, string as_screen, string as_dir); //Start Code Change ----03.07.2017 #V153 maha - added
Long ll_rec_id
Long ll_prac_id
Long li_seq_no
Integer li_start_page
Integer li_num_pages
Integer li_screen_id
Integer li_facility_id
Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob
String ls_filename
String ls_filedate_local, ls_filedate_server
Datetime ldt_filedate_server
string ls_file
n_cst_string lnv_string //Added by Appeon long.zhang 05.10.2017

SetPointer(HourGlass!)

debugbreak()
ls_filename = as_screen + "_" + as_ref + ".tif"   //Start Code Change ----04.11.2017 #V153 maha - removed the colon from the file name.

ls_filename = lnv_string.of_replace_invalid_filename(ls_filename) //Replace invalid characters in Filename, Added by Appeon long.zhang 05.10.2017 (V15.3 Bug # 5636 - AppeonWriteFile error when trying to extract documents)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.14.2007 By: Jack
//$<reason> Fix a defect.

ls_file = as_dir + ls_filename  

//ls_file = gs_dir_path + "\intellicred\Images\"
gnv_appeondll.of_parsepath(ls_file)



// Check file time
IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

// Open processs window
openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_get_image_pd_images2( al_pk_id,  lb_image_data)
ELSE
	SELECTBLOB image_data
	INTO :lb_image_data
	FROM pd_images
	WHERE 	image_pk = :al_pk_id
	USING SQLCA;
END IF

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )


IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1


//IF Not FileExists( ls_file) THEN  //Start Code Change ---- 05.17.2006 #460 maha
//	MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
//END IF

Return 1

end function

public function integer of_save_image_to_db (long al_rec_id, long al_prac_id, long ai_facility_id, integer ai_screen_id, long ai_seq_no, string as_ext);ulong l_handle
integer li_filenum, li_loops, li_counter 
long ll_filelen, ll_bytes_read, ll_new_pos 
long ll_cnt
blob lb_our_blob, lb_tot_b, blob_temp, total_blob, blank_blob 
String ls_sql
Long		fh
long  li_retval
blob	lb_the_image

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.27.2006 By: LeiWei
//$<reason> Performance tuning.
/*
ll_filelen = FileLength( gs_dir_path + "IntelliCred\temp.tif" ) 
*/
SetPointer(HourGlass!)

String ls_file
//ls_file = gs_dir_path + "IntelliCred\images\" + String(al_rec_id) + "_" + String(al_prac_id) + "_" +&
//								String(ai_facility_id) + "_" + String(ai_screen_id) + "_" + String(ai_seq_no) + ".tif"
//ls_file = gs_temp_path + "images\" +  String(al_prac_id) + "_"  + String(ai_seq_no) + ".tif"//Start Code Change ----03.29.2011 #V11 maha 
ls_file = gs_temp_path + "images\" +  String(al_prac_id) + "_"  + String(ai_seq_no) + as_ext //Modified by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
								
ll_filelen = FileLength( ls_file ) 
//---------------------------- APPEON END ----------------------------



//messagebox("", ll_filelen)
IF ll_filelen = -1 THEN
	MessageBox("Error", "Error with FileLength command.  Return -1." )
	Return -1
END IF

// Open processs window
openwithparm( w_appeon_gifofwait, "Uploading Image to Database..." )

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 11.22.2011
//$<reason>SaaS & Web hosted Appeon error ticket 00032858 - Bug 2787
lb_the_image = Blob(Space(ll_filelen), EncodingAnsi!) 

//Read file to blob
li_retval = AppeonReadFile(ls_file, lb_the_image, ll_filelen)
if li_retval < 0 then
	MessageBox("Error", "Error with FileLength command.  Return -1." )
	Return -1
end if

/*

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.27.2006 By: LeiWei
//$<reason> Fix a defect.
/*
li_filenum = FileOpen( gs_dir_path + "IntelliCred\temp.tif", StreamMode!,READ!,LOCKREAD!)
*/
li_filenum = FileOpen( ls_file, StreamMode!,READ!,LOCKREAD!)
//---------------------------- APPEON END ----------------------------

IF li_filenum <> -1 THEN
	
	//Find out how long the file specified in sle_filename.text is

	//Determine how many FileReads will be necessary to read all of the file ... 
	//You can't read in more than 32K at a time 
	IF ll_filelen > 32765 THEN 
   	 IF Mod(ll_filelen,32765) = 0 THEN 
	        li_loops = ll_filelen/32765 
	    ELSE 
   	     li_loops = (ll_filelen/32765) + 1 
	    END IF 
	ELSE 
   	 li_loops = 1 
	END IF 

	//read the file ... 
	FOR li_counter = 1 to li_loops 
   	 ll_bytes_read = FileRead( li_filenum, blob_temp) 
		 IF ll_bytes_read = -1 THEN
			// Close process window
			IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_read 
	    FileSeek(li_filenum, ll_new_pos, FROMBEGINNING!) 

   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_the_image = total_blob
	
	FileClose(li_filenum) 

END IF
*/
//--------------------------- APPEON END ---------------------------

//update the image_data field
//UPDATEBLOB pd_images
//SET image_data = :lb_the_image
//WHERE rec_id = :al_rec_id and
//      prac_id = :al_prac_id and
//		facility_id = :ai_facility_id and
//		seq_no = :ai_seq_no and
//		screen_id = :ai_screen_id			
//USING SQLCA;
//Start Code Change ----03.29.2011 #V11 maha
UPDATEBLOB pd_images
SET image_data = :lb_the_image
WHERE 	image_pk = :ai_seq_no 	
USING SQLCA;

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: LeiWei
//$<reason> Set date of today to modify_date column.
//UPDATE  pd_images
//	 SET modify_date = getdate()
//WHERE rec_id = :al_rec_id and
//      prac_id = :al_prac_id and
//		facility_id = :ai_facility_id and
//		seq_no = :ai_seq_no and
//		screen_id = :ai_screen_id			
//USING SQLCA;
//Start Code Change ----03.29.2011 #V11 maha
UPDATE  pd_images
	 SET modify_date = getdate()
WHERE 	image_pk = :ai_seq_no 	
USING SQLCA;

//---------------------------- APPEON END ----------------------------

IF SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA ;
ELSEIF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
ELSEIF SQLCA.SQLNRows = 0 THEN	
	MessageBox( "SQL Error", "No rows effected. Error updating image_data field" )
END IF

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

RETURN 1





Return 1
end function

public function integer of_get_verif_doc (string as_doc_id, string as_from, long al_log, string as_file);//Start Code Change ----11.14.2017 #V154 maha - chris@zip
Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_verif_picture
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob

 if as_from = "Verif" then
	IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
		of_get_image_verif_info(as_doc_id, lb_verif_picture)

	ELSE
		SELECTBLOB verification_picture
		INTO :lb_verif_picture
		FROM verif_info
		WHERE doc_id = :as_doc_id
		USING SQLCA;
	END IF	
	
else  //batch
	IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
		of_get_image_verif_batch(al_log, lb_verif_picture)		
	ELSE
		SELECTBLOB image_data
		INTO :lb_verif_picture
		FROM verif_batch_log_image
		WHERE log_id = :al_log
		USING SQLCA;
	END IF
end if


IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF


ll_filelen = LenA( lb_verif_picture )



IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FileDelete( as_file )

li_filenum =  FileOpen( as_file , StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_verif_picture, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
//		 tab_1.tabpage_verif.st_1.text = "Writing File"
		 IF ll_bytes_written = -1 THEN
			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_written 
	    //FileSeek(li_filenum, 0, FROMEND!) 
   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_verif_picture = total_blob
	
	FileClose( li_filenum )
//   tab_1.tabpage_verif.st_1.text = "File Closed"
ELSE
	MessageBox( "File Open Error", "Could not open the image file:" + as_file + "" )
	Return -	1
END IF



Return 1

end function

on pfc_cst_nv_image_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_nv_image_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

