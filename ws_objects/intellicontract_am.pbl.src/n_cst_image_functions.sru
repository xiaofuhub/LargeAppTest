$PBExportHeader$n_cst_image_functions.sru
$PBExportComments$Come from pfc_cst_nv_image_functions.(Frank.Gui)
forward
global type n_cst_image_functions from nonvisualobject
end type
end forward

global type n_cst_image_functions from nonvisualobject
end type
global n_cst_image_functions n_cst_image_functions

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



n_cst_dm_utils  inv_dm_utils

end variables

forward prototypes
public function integer of_cleanup_page (olecustomcontrol ao_edit_control, integer ai_page)
public function integer of_setup_scan (olecustomcontrol ao_scan_object, string as_file, integer li_page_option)
public function integer of_straighten_page (olecustomcontrol ao_scan_object)
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
public function integer of_insert_page (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin, integer al_page, string as_gstrinsertappend, string as_filename)
public function integer of_append_blank_thumbpage (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin)
public function integer of_delete_pages (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin)
end prototypes

public function integer of_cleanup_page (olecustomcontrol ao_edit_control, integer ai_page);String	ls_Rtn

//messagebox("page", ai_page)
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
if Len(ls_Rtn) > 0 then
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

//Start Code Change ---- 06.13.2006 #534 maha //had not come over from ver 4.5
//this function is called from both imaging and app mapping
s20 = of_get_app_setting("set_20","I")

//1 = Black and White; 2  = 16 Grey Scale and 4 = 256 Grey Scale 
if gi_scan_format > 0 then //added maha 031105 (4.520) for scan format option from setting set_29 (set in app open event)
	li_file_type = gi_scan_format
else	
	li_file_type = 1  //B&W default
end if
//End Code Change---06.13.2006

// MBSKINNER 9 MARCH 2005 add try catch-- BEGIN
TRY
	// start code change --- 1.1.2005 MSKINNER
	//-------------Appeon Begin -----by Derek at 03.15.2007---------
	//f_setupscan(ao_scan_object)
	IF f_setupscan(ao_scan_object) = 9233 THEN RETURN -1 //Cancel - Alfee 04.24.2008
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
	ao_scan_object.Object.SetScanCapability( 114, 1 )//
	// end code change --- 1.1.2005 MSKINNER
	ao_scan_object.Object.SetScanCapability( 100, li_file_type )

//	ao_scan_object.Object.SetScanCapability( 101, 300 ) //maha changed from 200 061306
//	ao_scan_object.Object.SetScanCapability( 109, 300 )
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
	ao_scan_object.Object.ShowSetupBeforeScan( False )
	ao_scan_object.Object.StartScan()
	ao_scan_object.Object.CloseScanner()
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


TRY
	/*----------------------------------------------------------
	    ' If not a Rubber Stamp, initialize the annotation tools.
	    ' (Initialization prior to setting the Rubber Stamp is
	    ' handled differently, since the user can cancel out of
	    ' the Rubber Stamp dialog box and so not go through with
	    ' the Rubber Stamp.  Therefore, initialization prior to
	    ' setting the Rubber Stamp is done only after the user
	    ' selects OK in the Rubber Stamp dialog.  See below.)
	'----------------------------------------------------------*/
	IF as_annotationtype <> "RubberStamp" THEN
		of_AnnotationToolInitialization(ole_edit )
	END IF
	
	/*----------------------------------------------------------
	    ' Then, select the apppropriate tool, check the menu
	    ' item(s), and affiliated toolbar button(s).
	'----------------------------------------------------------*/
	CHOOSE CASE as_annotationtype
		CASE "Drag"
			ole_edit.Object.SelectTool(NO_TOOL)
			ole_edit.Object.MousePointer = wiMPHand //'Drag hand
			//mnuEditSelectItem(0).Checked = True 'Edit:  Drag
			//tlbToolbar2.Buttons("Drag").Value = tbrPressed
		CASE "SelectionRectangle"
			ole_edit.Object.SelectTool(NO_TOOL)
			ole_edit.Object.MousePointer = wiMPArrow//wiMPSelect
			ole_edit.Object.SelectionRectangle = TRUE

			//mnuEditSelectItem(1).Checked = True 'Edit:  Select Image
			//tlbToolbar2.Buttons("SelectImage").Value = tbrPressed
		CASE "SelectAnnoAndZones"
			ole_edit.Object.SelectTool(SELECTION)
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 01.18.2007 By: Frank.Gui
			//$<reason> 
			ole_edit.Object.SelectionRectangle = TRUE
			ole_edit.Object.SingleSelectionMode =TRUE
			//---------------------------- APPEON END ----------------------------

			// mnuEditSelectItem(2).Checked = True 'Edit:  Select Annotations and Zones
			//mnuToolsItem(1).Checked = True      'Tools:  Select Zones
			// mnuAnnoToolItem(0).Checked = True   'Anno:  Select Annotations
			//tlbToolbar2.Buttons("SelectAnnoAndZones").Value = tbrPressed
			//tlbToolbar3.Buttons("SelectAnnoAndZones").Value = tbrPressed
		CASE "OCRTextZone"
			//ole_edit.object.AnnotationOcrType = wiOcrTypeText
			ole_edit.Object.SelectTool(OCR_ZONES)
			//mnuToolsItem(2).Checked = True      'Tools:  Draw Text Zone
			// tlbToolbar2.Buttons("OCRTextZone").Value = tbrPressed
		CASE "OCRPictureZone"
			ole_edit.Object.AnnotationOcrType = 1
			ole_edit.Object.SelectTool(OCR_ZONES)
			// mnuToolsItem(3).Checked = True      'Tools:  Draw Picture Zone
			// tlbToolbar2.Buttons("OCRPictureZone").Value = tbrPressed
		CASE "FreehandLine"
			ole_edit.Object.SelectTool(FREEHAND_LINE)
			//mnuAnnoToolItem(1).Checked = True   'Anno:  Freehand Line
			//tlbToolbar3.Buttons("FreehandLine").Value = tbrPressed
		CASE "Highlighter"
			ole_edit.Object.SelectTool(HIGHLIGHTER)
			//mnuAnnoToolItem(2).Checked = True   'Anno:  Highlighter
			// tlbToolbar3.Buttons("Highlighter").Value = tbrPressed
		CASE "StraightLine"
			ole_edit.Object.SelectTool(STRAIGHT_LINE)
			//mnuAnnoToolItem(3).Checked = True   'Anno:  Straight Line
			//tlbToolbar3.Buttons("StraightLine").Value = tbrPressed
		CASE "HollowRectangle"
			ole_edit.Object.SelectTool(HOLLOW_RECTANGLE)
			//mnuAnnoToolItem(4).Checked = True   'Anno:  Hollow Rectangle
			//tlbToolbar3.Buttons("HollowRectangle").Value = tbrPressed
		CASE "FilledRectangle"
			ole_edit.Object.SelectTool(FILLED_RECTANGLE)
			//mnuAnnoToolItem(5).Checked = True   'Anno:  Filled Rectangle
			//tlbToolbar3.Buttons("FilledRectangle").Value = tbrPressed
		CASE "TypedText"
			ole_edit.Object.SelectTool(Text)
			//mnuAnnoToolItem(6).Checked = True   'Anno:  Typed Text
			//tlbToolbar3.Buttons("TypedText").Value = tbrPressed
		CASE "Hyperlink"
			ole_edit.Object.SelectTool(HYPERLINK)
			//mnuAnnoToolItem(7).Checked = True   'Anno:  Hyperlink
			// tlbToolbar3.Buttons("Hyperlink").Value = tbrPressed
		CASE "AttachANote"
			ole_edit.Object.SelectTool(ATTACH_A_NOTE)
			// mnuAnnoToolItem(8).Checked = True   'Anno:  Attach-a-Note
			// tlbToolbar3.Buttons("AttachANote").Value = tbrPressed
		CASE "TextFromFile"
			ole_edit.Object.SelectTool(TEXT_FROM_FILE)
			//mnuAnnoToolItem(9).Checked = True   'Anno:  Text From File
			// tlbToolbar3.Buttons("TextFromFile").Value = tbrPressed
		CASE "RubberStamp"
			ole_edit.Object.ShowRubberStampDialog()
			IF ole_edit.Object.MousePointer = wiMPRubberStamp THEN
				of_AnnotationToolInitialization(ole_edit)
				//mnuAnnoToolItem(10).Checked = True  'Anno:  Rubber Stamps...
				//tlbToolbar3.Buttons("RubberStamp").Value = tbrPressed
			ELSE
				//mnuAnnoToolItem(10).Checked = False 'Anno:  Rubber Stamps...
				//tlbToolbar3.Buttons("RubberStamp").Value = tbrUnpressed
				// Exit Sub
			END IF
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 01.17.2007 By: Frank.Gui
			//$<reason> 
		CASE 'Initials'
			ole_edit.Object.SelectTool(INITIALS)
		CASE 'HollowPolygon'
			ole_edit.Object.SelectTool(HOLLOW_POLYGON)
		CASE 'FilledPolygon'
			ole_edit.Object.SelectTool(FILLED_POLYGON)
		CASE 'AutoPolygon'
			ole_edit.Object.SelectTool(AUTO_POLYGON)
			//---------------------------- APPEON END ----------------------------
			
		CASE ELSE
	END CHOOSE
	
Catch (RunTimeError tre)
END TRY
RETURN 0

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
String strFullPathFileName

TRY
	CHOOSE CASE al_index
		CASE 0 //OCR...
			
			ole_ocr.Object.Quality = wiAutoDetectQ
			ole_ocr.Object.Layout = wiAutoDetectL
			ole_ocr.Object.ProcessingMode = 1 //Process only OCR zones
			ole_ocr.Object.RetainPictures = FALSE //Do not process pictures
			ole_ocr.Object.RetainPageLayout = TRUE //Source layout retained in output layout    
			ole_ocr.Object.OutputType = 4 //0 - Microsoft Word for Windows(versions 6 and 7) and RTF
			//ole_ocr.Object.OutputFile = "c:\ocr.text"
			ole_ocr.Object.LaunchApplication = TRUE
			IF ole_ocr.Object.ShowOcrOptions() = 1 THEN //ShowOcrOptions
				ole_ocr.Object.StartOcr()
			END IF
			
			
		CASE 1 //Select Zones
			of_AnnotationToolSelection(ole_edit,"SelectAnnoAndZones")
		CASE 2 //Draw Text Zone
			of_AnnotationToolSelection(ole_edit,"OCRTextZone")
		CASE 3 //Draw Picture Zone
			of_AnnotationToolSelection(ole_edit,"OCRPictureZone")
		CASE 4 //Show OCR Zones
			ole_edit.Object.OcrZoneVisibility = 3
		CASE 5 //Remove All OCR Zones
			ole_edit.Object.RemoveAllOCRMarks()
		CASE 6 //----Separator Bar
		CASE 7 //Remove Speckles
			ole_edit.Object.Despeckle() //Note:  Must save image for despeckling to hold
		CASE 8 //Straighten Page
			ole_edit.Object.ManualDeSkew
		CASE 9 //----Separator Bar
		CASE 10 //Create Contact Sheet...
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
		CASE 11 //OCR...
			ole_ocr.Object.Quality = wiAutoDetectQ
			ole_ocr.Object.Layout = wiAutoDetectL
			ole_ocr.Object.ProcessingMode = 1 //1-	Automatic processing of all specified pages
			ole_ocr.Object.RetainPictures = TRUE //Do not process pictures
			ole_ocr.Object.RetainPageLayout = TRUE //Source layout retained in output layout    
			ole_ocr.Object.OutputType = 0
			//			ole_ocr.Object.OutputFile = "c:\ocr.text" //Remove it so that a dialog will display automatically.
			ole_ocr.Object.LaunchApplication = TRUE
			IF ole_ocr.Object.ShowOcr() = 1 THEN
				//--------------------------- APPEON BEGIN ---------------------------
				//$<add> 2009-04-22 By: Ken.Guo
				//$<reason> If user select 'Current Page'--'0', need specify page number.
				If ole_ocr.Object.Pages = '0' Then 
					ole_ocr.Object.Pages = String(ole_edit.object.Page)
				End If
				//---------------------------- APPEON END ----------------------------
				ole_ocr.Object.StartOcr()
			END IF
			
	END CHOOSE
	
Catch (runtimeerror rte)
	
END TRY


RETURN 0


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
				IF ole_edit.object.GetSelectedAnnotationNumPoints() >0 THEN
					ole_edit.object.DeleteSelectedAnnotations()
				ELSE
           		ole_edit.object.DeleteImageData()
				END IF
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
      						
				/*	Moved to of_delete_pages() - Commented by Alfee on 09.19.2008 
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
			  */
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


Long 		lngCurrentPage,lngCurrentPageCount,mintCompressionInfo
String  	strFullPathWorkfileName,ls_Rtn


//----------------------------------------------------------
// Hide the form and store the page number and page count of
// the currently displayed file.
//----------------------------------------------------------

lngCurrentPage = ole_edit.Object.Page
lngCurrentPageCount = ole_edit.Object.PageCount

//----------------------------------------------------------
// Have the Admin control generate a unique file name.
// Then store the resulting file name and path in
// strWorkfileName and strFullPathWorkfileName, respectively.
//----------------------------------------------------------

strFullPathWorkfileName = inv_dm_utils.of_generate_tempname( 0, 0, 'temp'+string(now(),'hhmmssfff')+'.tif')

//----------------------------------------------------------
// Display the blank image in the Workfile control and then
// save it.
//----------------------------------------------------------
ole_edit_work.Object.DisplayBlankImage (ole_edit.Object.ImageWidth, ole_edit.Object.ImageHeight, 200, 200, ole_edit.Object.pagetype)

mintCompressionInfo = ole_edit.Object.CompressionInfo()

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-14 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(strFullPathWorkfileName)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

//---------------------------- APPEON END ----------------------------

ole_edit_work.Object.SaveAs(strFullPathWorkfileName, 1,1, 1, 0,TRUE)

//----------------------------------------------------------
// Insert or append the new blank page.
//----------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07/09/2007 By: Ken.Guo
//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
	Messagebox('Image','The current image file must be in "TIF" format.')
	Return -1			
End If
//---------------------------- APPEON END ----------------------------

ls_Rtn = f_ExaWriteRight(strFullPathWorkfileName)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

IF as_gstrinsertappend = "Insert" THEN
	ole_admin.Object.Insert(strFullPathWorkfileName, 1, lngCurrentPage, 1)
ELSE
	ole_admin.Object.Append(strFullPathWorkfileName, 1, 1)
	lngCurrentPage = lngCurrentPageCount + 1
END IF

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
ole_thumbnail.Object.Image = ole_edit.Object.Image
ole_edit.Object.Page = lngCurrentPage

// //--------------------------------------------------
//    // Redisplay the pages and unload the form.
//    //--------------------------------------------------
//    gblnInitialDisplayOfThisImage = False
//    blnRegenThumbs = True
//    Call frmMain.EnablePageMenusAndDisplay(lngCurrentPage, blnRegenThumbs)
//        





RETURN 0

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
//ole_thumbnail.object.ScrollDirection = 0   // Horizontal
ole_thumbnail.object.UISetThumbSize()      //'User sets thumb size interactively 

///'Determine min and max control size taking a scrollbar into account

lMinSize = ole_thumbnail.object.GetMinimumSize(iNonScrollThumbCount, bScroll)
lMaxSize = ole_thumbnail.object.GetMaximumSize(iNonScrollThumbCount, bScroll)
lVSize = (lMinSize + lMaxSize) / 2  //Average of the min & max nonscrolling size

//ole_thumbnail.Height = lVSize

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
Integer intFormat
long ll_range

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

try 
	 ole_admin.object.PrintOutputFormat = 3
    ole_admin.object.PrintNumCopies = 1 
    ole_admin.object.PrintStartPage = al_start_page
    ole_admin.object.PrintEndPage = al_end_page
    ole_admin.object.Flags = 0
    ole_admin.object.ShowPrintDialog(al_handel)
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
		
 
  catch (runtimeerror rte )
	 
end try
    
	 
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
long ll_range

try 
    ole_admin.object.PrintNumCopies = 1 
    ole_admin.object.Flags = 0
    ole_admin.object.ShowPrintDialog(al_handel)
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
		
 
  catch (runtimeerror rte )
	 
end try
    
	 
return 0
end function

public function integer of_insert_page (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin, integer al_page, string as_gstrinsertappend, string as_filename);//////////////////////////////////////////////////////////////////// //
// $<function>of_insert_page()
// $<arguments>
//		value	olecustomcontrol	ole_thumbnail      		
//		value	olecustomcontrol	ole_edit           		
//		value	olecustomcontrol	ole_edit_work      		
//		value	olecustomcontrol	ole_admin          		
//		value	integer         	al_page            		
//		value	string          	as_gstrinsertappend		
//		value	string          	as_filename        		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

Long lngCurrentPage,lngCurrentPageCount
String	ls_Rtn

IF NOT FileExists(as_FileName) THEN
	MessageBox('Warning','The specified file ['+as_FileName+'] does not exist.',exclamation!)
	RETURN -1
END IF
//----------------------------------------------------------
// Hide the form and store the page number and page count of
// the currently displayed file.
//----------------------------------------------------------

lngCurrentPage = ole_edit.Object.Page
lngCurrentPageCount = ole_edit.Object.PageCount

//----------------------------------------------------------
// Insert or append the new blank page.
//----------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07/09/2007 By: Ken.Guo
//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
	Messagebox('Image','The current image file must be in "TIF" format.')
	Return -1			
End If
//---------------------------- APPEON END ----------------------------

ls_Rtn = f_ExaWriteRight(as_FileName)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

IF as_gstrinsertappend = "Insert" THEN
	ole_admin.Object.Insert(as_FileName, 1, lngCurrentPage, 1)
ELSE
	ole_admin.Object.Append(as_FileName, 1, 1)
	lngCurrentPage = lngCurrentPageCount + 1
END IF

ole_thumbnail.Object.Image = ole_edit.Object.Image
ole_edit.Object.Page = lngCurrentPage


RETURN 1


end function

public function integer of_append_blank_thumbpage (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin);//Alfee 09.19.2008

String strFullPathWorkfileName, ls_rtn

//Get a temporary file name
strFullPathWorkfileName = inv_dm_utils.of_generate_tempname( 0, 0, 'temp'+string(now(),'hhmmssfff')+'.tif')

ls_Rtn = f_ExaWriteRight(strFullPathWorkfileName)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

TRY

//Generate a blank tif file
ole_edit_work.Object.DisplayBlankImage (ole_edit.Object.ImageWidth, ole_edit.Object.ImageHeight, 200, 200, ole_edit.Object.pagetype)
ole_edit_work.Object.SaveAs(strFullPathWorkfileName, 1,1, 1, 0,TRUE)

//Append the blank tif file
ole_admin.Object.Append(strFullPathWorkfileName, 1, 1)

//Refresh the thumbnail
ole_thumbnail.Object.Image = ole_thumbnail.Object.Image

CATCH (runtimeerror rte)
	RETURN -1
END TRY

RETURN 1

end function

public function integer of_delete_pages (olecustomcontrol ole_thumbnail, olecustomcontrol ole_edit, olecustomcontrol ole_edit_work, olecustomcontrol ole_admin);//Delete selected pages - Alfee 09.19.2008

Integer intCounter
Long lngDeletedPageNo, lngNewPageNo
 
TRY
   
	//Delete all selected pages
	For intCounter = ole_thumbnail.object.ThumbCount To 1 Step -1
   	If ole_thumbnail.object.ThumbSelected(intCounter) = True Then
		  //Append a blank page before the last page deleted 	
		  IF ole_thumbnail.object.ThumbCount = 1 THEN
				of_append_blank_thumbpage(ole_thumbnail, ole_edit, ole_edit_work, ole_admin)
		  END IF
		  lngDeletedPageNo = intCounter
		  ole_edit.object.ClearDisplay
		  ole_admin.object.DeletePages(lngDeletedPageNo, 1)
		  ole_thumbnail.object.DeleteThumbs(lngDeletedPageNo, 1)
		End If
   Next 

	//Set the new page and display the image
	If lngDeletedPageNo > 1 Then
		 lngNewPageNo = lngDeletedPageNo - 1
	Else
		 lngNewPageNo = 1
	End If
	ole_edit.object.Page = lngNewPageNo

CATCH (runtimeerror rte)
	RETURN -1
END TRY
       
return 0
end function

on n_cst_image_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_image_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

