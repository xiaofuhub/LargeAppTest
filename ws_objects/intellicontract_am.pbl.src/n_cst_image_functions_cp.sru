$PBExportHeader$n_cst_image_functions_cp.sru
forward
global type n_cst_image_functions_cp from nonvisualobject
end type
end forward

global type n_cst_image_functions_cp from nonvisualobject
end type
global n_cst_image_functions_cp n_cst_image_functions_cp

type variables
Boolean ib_JustScanned
end variables

forward prototypes
public subroutine of_set_scanflag (boolean ab_scanned)
public function integer of_delete_page (olecustomcontrol aole_thumbnail, olecustomcontrol aole_edit, integer ai_page)
public function integer of_insert_page (olecustomcontrol aole_thumbnail, olecustomcontrol aole_edit, integer ai_page, string as_gstrinsertappend, string as_filename)
public function integer of_setup_scan (olecustomcontrol aole_scan, string as_file, integer ai_source)
public function integer of_convert2pdf (string as_image, string as_pdf)
public function integer of_convert2pdf (string as_image)
public function boolean of_is_image2pdf (string as_ext)
public function integer of_pdf2tif (string as_pdf)
public function integer of_tifmerge (string as_tif1, string as_tif2, string as_output_tif)
public function integer of_tifmergemultifiles (string as_tif_list, string as_output_tif)
public function integer of_pdf2tif (string as_pdf, string as_tif, boolean ab_truecolor)
public function integer of_pdf2tif (string as_pdf, string as_tif)
public function integer of_pdf2tif (string as_pdf, string as_tif, string as_format, integer ai_dpi, integer ai_method)
public function integer of_pdf2tifbw (string as_pdf, string as_tif)
public subroutine of_close_image_cp ()
public function integer of_setup_scan (olecustomcontrol aole_scan, string as_file, string as_ext)
public function integer of_setup_scan (olecustomcontrol aole_scan, string as_file)
end prototypes

public subroutine of_set_scanflag (boolean ab_scanned);//Set scanned flag - Alfee 07.28.2008

ib_JustScanned = ab_scanned


end subroutine

public function integer of_delete_page (olecustomcontrol aole_thumbnail, olecustomcontrol aole_edit, integer ai_page);//////////////////////////////////////////////////////////////////// //
// $<function>of_delete_page()
// $<arguments>
//		value	olecustomcontrol	aole_thumbnail      		
//		value	olecustomcontrol	aole_edit           		     		
//		value	integer         	ai_page            		  		
// $<returns> integer - new selected page no
// $<description>Delete current page
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2008 Alfee
//////////////////////////////////////////////////////////////////////
Integer li_pagecnt, li_newpageno
String ls_filename
String ls_Rtn

TRY
	
li_pagecnt = aole_edit.Object.GetTotalPage()
IF ai_page <= 0 OR ai_page > li_pagecnt THEN RETURN -1

//Get file name
ls_filename = aole_edit.object.filename

//Judge wirte right in current folder
ls_Rtn = f_ExaWriteRight(ls_filename)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

//Delete the current page & the thumbnail
IF NOT aole_edit.Object.TIFDeletePage(ls_filename, ai_page) THEN RETURN -1 //a background mode
IF NOT aole_thumbnail.Object.DeleteClipByIndex(ai_page - 1) THEN RETURN -1

Yield()

//Load the new image page & re-select in thumbnail
IF li_pagecnt = 1 THEN 
	li_newpageno = 0
ELSEIF li_pagecnt = ai_page THEN 
	aole_edit.Object.LoadMultiPage(ls_filename, ai_page - 1)
	aole_thumbnail.object.SelectClip(ai_page - 2)	
	li_newpageno = ai_page - 1
ELSEIF li_pagecnt > ai_page THEN
	aole_edit.Object.LoadMultiPage(ls_filename, ai_page)
	aole_thumbnail.object.SelectClip(ai_page - 1)	
	li_newpageno = ai_page 
END IF

CATCH (RUNTIMEERROR E)
	RETURN -1
END TRY

RETURN li_newpageno


end function

public function integer of_insert_page (olecustomcontrol aole_thumbnail, olecustomcontrol aole_edit, integer ai_page, string as_gstrinsertappend, string as_filename);//////////////////////////////////////////////////////////////////// //
// $<function>of_insert_page()
// $<arguments>
//		value	olecustomcontrol	aole_thumbnail      		
//		value	olecustomcontrol	aole_edit           		     		
//		value	integer         	li_page            		
//		value	string          	as_gstrinsertappend		
//		value	string          	as_filename        		
// $<returns> integer -  current page
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2008 Alfee
//////////////////////////////////////////////////////////////////////
Integer li_Sel, li_cnt, i, li_page
Long lngCurrentPage, lngCurrentPageCount
String ls_filename
String ls_Rtn

SetPointer(HourGlass!)

IF NOT FileExists(as_FileName) THEN
	MessageBox('Warning','The specified file ['+as_FileName+'] does not exist.',exclamation!)
	RETURN -1
END IF

TRY

IF Lower(as_gstrinsertappend) = 'append' THEN 
	li_page = aole_edit.Object.GetTotalPage() + 1
ELSE
	IF li_page < 1 OR li_page > aole_edit.Object.GetTotalPage() THEN RETURN -1
END IF

//Get file name
ls_filename = aole_edit.object.filename

//Judge wirte right in current folder
ls_Rtn = f_ExaWriteRight(ls_filename)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

//Append or insert the scanned image file
IF NOT aole_edit.Object.TIFAddPage(ls_filename, li_page, as_filename) THEN RETURN -1 //a background mode

//Load the new image page
aole_edit.Object.LoadMultiPage(ls_filename, li_page)

//Refresh thumbnail
IF Lower(as_gstrinsertappend) = 'append' THEN //Append
	aole_thumbnail.Object.AddClip(as_filename, '')	
ELSE //Insert
	//Clear thumbnail
	li_cnt = aole_thumbnail.Object.ClipCount
	For i = 1 To li_cnt
   	aole_thumbnail.Object.DeleteClipByIndex(0)
	Next
	//Re-load thumbnail
	aole_thumbnail.Object.AddClip(ls_filename, '')
END IF
aole_thumbnail.object.SelectClip(li_page - 1)	

CATCH (RUNTIMEERROR E)
	RETURN -1
END TRY

RETURN li_page


end function

public function integer of_setup_scan (olecustomcontrol aole_scan, string as_file, integer ai_source);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_setup_scan
//  Purpose   	: start the scanning process
//  Arguments 	: [olecustomcontrol]  aole_scan
//					: [string]            as_file
//					: [Integer]				 ai_source	
//  Returns   	: [long]     
//  Created By	: Alfee on 07.28.2008
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Integer li_file_type, li_pixel_type
Integer i, li_rtn, s20
Boolean lb_saved, lb_visible

//Initilize the scanned flag
of_set_scanflag(FALSE)

//Get and Convert the pixel type based on setting
//Image type for Global 360 : 1 = Black and White; 2  = 16 Grey Scale and 4 = 256 Grey Scale - Settings
//( 8 - color 256 palettized; 16 - true color 24-bit RGB; 32 - color 16-bit palettized )
li_file_type = 1  //B&W default
if gi_scan_format > 0 then li_file_type = gi_scan_format //from setting set_29 
CHOOSE CASE li_file_type
	CASE 1
		li_pixel_type = 1 //Black and white Color
	CASE 2, 4
		li_pixel_type = 0	 //Gray Color		
	CASE 8, 16, 24, 32
		li_pixel_type = 2 //True Color
	CASE ELSE
		li_pixel_type = -1 //Default
END CHOOSE

TRY
	//Select the specified twain source
	aole_scan.Object.SelectImageSourceByIndex(ai_source) 

	//Set image pixel type	
	aole_scan.Object.PixelType = li_pixel_type
		
	//Set duplex mode		
	s20 = of_get_app_setting("set_20","I")	
	if s20 = 2 then //maha added 041805 as trap because it fails on some scanners
		open(w_duplex_setting)
		s20 = message.doubleparm
		if s20 = 1 then
			aole_scan.Object.DuplexEnabled = FALSE
		elseif s20 = 2 then
			aole_scan.Object.DuplexEnabled = TRUE
		else //0
			//don't send SetScanCapability
		end if
	end if	
	
	//Set others
	aole_scan.Object.View = 5 //full
	aole_scan.Object.ShowTwainUI = FALSE
	//---------Begin Modified by (Appeon)Harry 06.10.2013 for V141 ISG-CLX--------
	//aole_scan.Object.ClearImageBuffer = True
	aole_scan.Object.ClearImageBuffer = False//True //Modified By Ken.Guo 2009-12-11. For Scanner's ADF feature
	aole_scan.Object.FeederEnabled = True //Added By Ken.Guo 2009-12-11.
	//---------End Modfiied ------------------------------------------------------
	
	//Scan images 
	li_rtn = aole_scan.Object.Scan()
	IF li_rtn = 0 THEN RETURN -1
	
	//Save scanned images
	lb_visible = aole_scan.visible
	IF NOT lb_visible THEN
		aole_scan.visible = TRUE //It's necessary for save operation
		aole_scan.bringtotop = FALSE
	END IF
	
	DO 
		Yield()
	LOOP UNTIL ib_JustScanned //set in endscan() event of scan ocx control
	lb_saved = aole_scan.Object.SaveAllPage2TIF(as_file, TRUE, 1)

	aole_scan.visible = lb_visible
	IF NOT lb_saved THEN RETURN -1

CATCH (RUNTIMEERROR E)
	li_rtn = -1
END TRY

Return li_rtn



end function

public function integer of_convert2pdf (string as_image, string as_pdf);//Convert image to PDF format - alfee 09.27.2008
//RETURN 1 - succeeded; -1 - Failed

Integer li_rtn

IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)
IF NOT IsValid(w_dm_image_cp) THEN RETURN -1

li_rtn = w_dm_image_cp.of_image2pdf(as_image, as_pdf)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.17.2015
//<$>reason:for ALLEGHENY: Uploading PDFs sometimes previews upside down & reversed Issue
//Post Close(w_dm_image_cp)
w_dm_image_cp.of_release_file()
//------------------- APPEON END -------------------

RETURN li_rtn


	
end function

public function integer of_convert2pdf (string as_image);//Convert image to PDF format - alfee 09.27.2008
//RETURN 1 - succeeded; -1 - Failed

RETURN of_convert2pdf(as_image, "")




	
end function

public function boolean of_is_image2pdf (string as_ext);//Check if it's the type of image allowed to convert to PDF - Alfee 11.21.2008

Boolean lb_rtn

CHOOSE CASE Upper(as_ext)
	CASE "BMP", "GIF", "ICO", "JPG", "JPEG", "PCX", "PNG", "PSD", "TIF", "WMF", "WBMP", "TGA", "PGX", "RAS", "PNM"
		lb_rtn = TRUE
	CASE ELSE
		lb_rtn = FALSE
END CHOOSE

RETURN lb_rtn


end function

public function integer of_pdf2tif (string as_pdf);//Convert PDF to TIF format - alfee 04.09.2009
//RETURN 1 - succeeded; -1 - Failed

RETURN of_pdf2tif(as_pdf, "")






	
end function

public function integer of_tifmerge (string as_tif1, string as_tif2, string as_output_tif);//Merge 2 tif files  - alfee 12.06.2011
//RETURN 1 - succeeded; -1 - Failed

Integer li_rtn

IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)
IF NOT IsValid(w_dm_image_cp) THEN RETURN -1

li_rtn = w_dm_image_cp.of_tifmerge(as_tif1, as_tif2, as_output_tif)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.17.2015
//<$>reason:for ALLEGHENY: Uploading PDFs sometimes previews upside down & reversed Issue
//Post Close(w_dm_image_cp)
w_dm_image_cp.of_release_file()
//------------------- APPEON END -------------------

RETURN li_rtn

end function

public function integer of_tifmergemultifiles (string as_tif_list, string as_output_tif);//Merge 2 or more tif files  - alfee 12.06.2011
//RETURN 1 - succeeded; -1 - Failed

Integer li_rtn

IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)
IF NOT IsValid(w_dm_image_cp) THEN RETURN -1

li_rtn = w_dm_image_cp.of_tifmergemultifiles(as_tif_list, as_output_tif)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.17.2015
//<$>reason:for ALLEGHENY: Uploading PDFs sometimes previews upside down & reversed Issue
//Post Close(w_dm_image_cp)
w_dm_image_cp.of_release_file()
//------------------- APPEON END -------------------

RETURN li_rtn

end function

public function integer of_pdf2tif (string as_pdf, string as_tif, boolean ab_truecolor);//Convert PDF to TIF format - alfee 04.09.2009
//RETURN 1 - succeeded; -1 - Failed

Integer li_rtn

IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)
IF NOT IsValid(w_dm_image_cp) THEN RETURN -1

//li_rtn = w_dm_image_cp.of_pdf2tif(as_pdf,as_tif)
li_rtn = w_dm_image_cp.of_pdf2tif(as_pdf,as_tif, ab_truecolor) //Ticket #00039904 - alfee 02.18.2013		

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.17.2015
//<$>reason:for ALLEGHENY: Uploading PDFs sometimes previews upside down & reversed Issue
//Post Close(w_dm_image_cp)
w_dm_image_cp.of_release_file()
//------------------- APPEON END -------------------

RETURN li_rtn


	
end function

public function integer of_pdf2tif (string as_pdf, string as_tif);//Added by alfee 02.18.2013 for Ticket #00039904

RETURN of_pdf2tif(as_pdf, as_tif, true)
end function

public function integer of_pdf2tif (string as_pdf, string as_tif, string as_format, integer ai_dpi, integer ai_method);//====================================================================
//$<Function>: of_pdf2tif
//$<Arguments>:
// 	value    string     as_pdf
// 	value    string     as_tif
// 	value    string     as_format
// 	value    integer    ai_dpi
// 	value    integer    ai_method
//$<Return>:  1 - succeeded; -1 - Failed
//$<Description>: Convert tif to PDF format with format and dpi arguments
//$<Author>: (Appeon) long.zhang 07.28.2015
//--------------------------------------------------------------------
//$<Modify History>:
//add Argument ai_method, by Appeon long.zhang 08.06.2015
//====================================================================

Integer li_rtn

IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)
IF NOT IsValid(w_dm_image_cp) THEN RETURN -1

li_rtn = w_dm_image_cp.of_pdf2tif(as_pdf, as_tif, as_format, ai_dpi, ai_method)//add Argument ai_method, by Appeon long.zhang 08.06.2015

w_dm_image_cp.of_release_file()

RETURN li_rtn


	
end function

public function integer of_pdf2tifbw (string as_pdf, string as_tif);//Start Code Change ----07.07.2016 #V152 maha - added for Black and white conversion re Ronnie Po
Integer li_rtn

IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)
IF NOT IsValid(w_dm_image_cp) THEN RETURN -1

li_rtn = w_dm_image_cp.of_pdf2tifbw(as_pdf, as_tif)

w_dm_image_cp.of_release_file()

RETURN li_rtn
end function

public subroutine of_close_image_cp ();//====================================================================
//$<Function>: of_close_image_cp
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Close w_dm_image_cp when get an error. (It will be open again the next time)
//						For V15.2 Testing Bug #5338: Document import of PDF file is not showing pages.
//$<Author>: (Appeon) long.zhang 09.20.2016 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
If IsValid(w_dm_image_cp) Then Close(w_dm_image_cp)
end subroutine

public function integer of_setup_scan (olecustomcontrol aole_scan, string as_file, string as_ext);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_setup_scan
//  Purpose   	: start the scanning process
//  Arguments 	: [olecustomcontrol]  aole_scan
//					: [string]            as_file
//					: [string]            as_ext //default:TIF
//  Returns   	: [long]     
//  Created By	: Alfee on 07.28.2008
//Modified by (APPEON) Harry 11.23.2017 (V161 Storage of Documents as PDFs)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Integer li_file_type, li_pixel_type
Integer i, li_rtn
Integer s20
Boolean lb_saved, lb_visible

//Initilize the scanned flag
of_set_scanflag(FALSE)

s20 = of_get_app_setting("set_20","I")

//Get and Convert the pixel type based on setting
//1 = Black and White; 2  = 16 Grey Scale and 4 = 256 Grey Scale 
if gi_scan_format > 0 then //scan format option from setting set_29 
	li_file_type = gi_scan_format
else	
	li_file_type = 1  //B&W default
end if
//Image type for Global 360 : 1 - black and white; 2- grayscale 16; 4 - grayscale 256; 8 - color 256 palettized; 16 - true color 24-bit RGB; 32 - color 16-bit palettized
CHOOSE CASE li_file_type
	CASE 1
		li_pixel_type = 1 //Black and white Color
	CASE 2, 4
		li_pixel_type = 0	 //Gray Color		
	CASE 8, 16, 24, 32
		li_pixel_type = 2 //True Color
	CASE ELSE
		li_pixel_type = -1 //Default
END CHOOSE

TRY
	//Select image twain source
	aole_scan.Object.SelectImageSource()

	//Set image pixel type	
	aole_scan.Object.PixelType = li_pixel_type
		
	//Set duplex mode		
	if s20 = 2 then //maha added 041805 as trap because it fails on some scanners
		open(w_duplex_setting)
		s20 = message.doubleparm
		if s20 = 1 then
			aole_scan.Object.DuplexEnabled = FALSE
		elseif s20 = 2 then
			aole_scan.Object.DuplexEnabled = TRUE
		else //0
			//don't send SetScanCapability
		end if
	end if	
	
	//Set others
	aole_scan.Object.View = 5 //full
	aole_scan.Object.ShowTwainUI = FALSE
	//---------Begin Modified by (Appeon)Harry 06.10.2013 for V141 ISG-CLX--------
	//aole_scan.Object.ClearImageBuffer = True
	aole_scan.Object.ClearImageBuffer = False//True //Modified By Ken.Guo 2009-12-11. For Scanner's ADF feature
	aole_scan.Object.FeederEnabled = True //Added By Ken.Guo 2009-12-11.
	//---------End Modfiied ------------------------------------------------------
	
	//Scan images 
	li_rtn = aole_scan.Object.Scan()
	IF li_rtn = 0 THEN RETURN -1
	
	//Save scanned images
	lb_visible = aole_scan.visible
	IF NOT lb_visible THEN
		aole_scan.visible = TRUE //It's necessary for save operation
		aole_scan.bringtotop = FALSE
	END IF
	
	DO 
		Yield()
	LOOP UNTIL ib_JustScanned //set in endscan() event of scan ocx control
	IF as_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.23.2017 (V161 Storage of Documents as PDFs)
		lb_saved = aole_scan.Object.SaveAllPage2PDF(as_file, TRUE, 1)
	ELSEIF as_ext = 'TIF' THEN
		lb_saved = aole_scan.Object.SaveAllPage2TIF(as_file, TRUE, 1)
	END IF

	aole_scan.visible = lb_visible
	IF NOT lb_saved THEN RETURN -1

CATCH (RUNTIMEERROR E)
	li_rtn = -1
END TRY

Return li_rtn



end function

public function integer of_setup_scan (olecustomcontrol aole_scan, string as_file);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_setup_scan
//  Purpose   	: start the scanning process
//  Arguments 	: [olecustomcontrol]  aole_scan
//					: [string]            as_file
//  Returns   	: [long]     
//  Created By	: Alfee on 07.28.2008
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Return of_setup_scan(aole_scan, as_file, 'TIF')  //Modified by (APPEON) Harry 11.23.2017 (V161 Storage of Documents as PDFs)
/*
Integer li_file_type, li_pixel_type
Integer i, li_rtn
Integer s20
Boolean lb_saved, lb_visible

//Initilize the scanned flag
of_set_scanflag(FALSE)

s20 = of_get_app_setting("set_20","I")

//Get and Convert the pixel type based on setting
//1 = Black and White; 2  = 16 Grey Scale and 4 = 256 Grey Scale 
if gi_scan_format > 0 then //scan format option from setting set_29 
	li_file_type = gi_scan_format
else	
	li_file_type = 1  //B&W default
end if
//Image type for Global 360 : 1 - black and white; 2- grayscale 16; 4 - grayscale 256; 8 - color 256 palettized; 16 - true color 24-bit RGB; 32 - color 16-bit palettized
CHOOSE CASE li_file_type
	CASE 1
		li_pixel_type = 1 //Black and white Color
	CASE 2, 4
		li_pixel_type = 0	 //Gray Color		
	CASE 8, 16, 24, 32
		li_pixel_type = 2 //True Color
	CASE ELSE
		li_pixel_type = -1 //Default
END CHOOSE

TRY
	//Select image twain source
	aole_scan.Object.SelectImageSource()

	//Set image pixel type	
	aole_scan.Object.PixelType = li_pixel_type
		
	//Set duplex mode		
	if s20 = 2 then //maha added 041805 as trap because it fails on some scanners
		open(w_duplex_setting)
		s20 = message.doubleparm
		if s20 = 1 then
			aole_scan.Object.DuplexEnabled = FALSE
		elseif s20 = 2 then
			aole_scan.Object.DuplexEnabled = TRUE
		else //0
			//don't send SetScanCapability
		end if
	end if	
	
	//Set others
	aole_scan.Object.View = 5 //full
	aole_scan.Object.ShowTwainUI = FALSE
	//---------Begin Modified by (Appeon)Harry 06.10.2013 for V141 ISG-CLX--------
	//aole_scan.Object.ClearImageBuffer = True
	aole_scan.Object.ClearImageBuffer = False//True //Modified By Ken.Guo 2009-12-11. For Scanner's ADF feature
	aole_scan.Object.FeederEnabled = True //Added By Ken.Guo 2009-12-11.
	//---------End Modfiied ------------------------------------------------------
	
	//Scan images 
	li_rtn = aole_scan.Object.Scan()
	IF li_rtn = 0 THEN RETURN -1
	
	//Save scanned images
	lb_visible = aole_scan.visible
	IF NOT lb_visible THEN
		aole_scan.visible = TRUE //It's necessary for save operation
		aole_scan.bringtotop = FALSE
	END IF
	
	DO 
		Yield()
	LOOP UNTIL ib_JustScanned //set in endscan() event of scan ocx control

	lb_saved = aole_scan.Object.SaveAllPage2TIF(as_file, TRUE, 1)

	aole_scan.visible = lb_visible
	IF NOT lb_saved THEN RETURN -1

CATCH (RUNTIMEERROR E)
	li_rtn = -1
END TRY

Return li_rtn
*/


end function

event constructor;//
end event

on n_cst_image_functions_cp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_image_functions_cp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

