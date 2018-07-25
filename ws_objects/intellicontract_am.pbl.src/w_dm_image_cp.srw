$PBExportHeader$w_dm_image_cp.srw
forward
global type w_dm_image_cp from window
end type
type ole_edit from olecustomcontrol within w_dm_image_cp
end type
end forward

global type w_dm_image_cp from window
boolean visible = false
integer width = 974
integer height = 904
boolean titlebar = true
string title = "TIF to PDF"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ole_edit ole_edit
end type
global w_dm_image_cp w_dm_image_cp

type variables
Boolean ib_ocr_finished
String is_ocr_text

n_cst_filesrvwin32 inv_filesrv
end variables

forward prototypes
public function integer of_image2pdf (string as_image, string as_pdf)
public function boolean of_is_image2pdf (string as_ext)
public function integer of_saveas_tif (ref string as_filename)
public function integer of_get_from_clip (ref string as_filename)
public function string of_get_last_ocr_text ()
public function boolean of_ocr_is_finished ()
public subroutine of_reset_ocr ()
public function integer of_tifmergemultifiles (string as_tif_list, string as_output_tif)
public function integer of_tifmerge (string as_tif1, string as_tif2, string as_output_tif)
public function integer of_pdf2tif (string as_pdf, string as_tif, boolean ab_truecolor)
public function integer of_pdf2tif (string as_pdf, string as_tif)
public subroutine of_release_file ()
public function integer of_pdf2tif (string as_pdf, string as_tif, string as_format, integer ai_dpi, integer ai_method)
public function integer of_pdf2tif (string as_pdf, string as_tif, string as_format, integer ai_dpi)
public function integer of_pdf2tifbw (string as_file_from, string as_file_to)
public function integer of_change_path (ref string as_filename)
public function string of_save_partpages_pdf (string as_filename, long al_start_page, long al_pagecnt)
public function integer of_insert_page_pdf (string as_org_filename, string as_ins_filename, long al_ins_page, long al_start_page, long al_pagecnt)
public function string of_delete_page_pdf (string as_filename, long al_start_page, long al_pagecnt)
public function integer of_pdfeditmerge (string as_file1, string as_file2)
public function integer of_printimage (string as_filename, long al_start, long al_end, integer ai_view, boolean ab_dialog)
public function integer of_saveas (string as_filename, string as_saveas, string as_ext)
public function integer of_savebysize (string as_from, string as_to, string as_ext)
public function integer of_gettotalpage (string as_filename)
end prototypes

public function integer of_image2pdf (string as_image, string as_pdf);//////////////////////////////////////////////////////////////////////
// $<function>of_image2pdf
// $<arguments>String as_image, as_pdf
// $<returns> integer 1- success; -1 - Failed
// $<description>Convert a document from TIF to PDF format
//////////////////////////////////////////////////////////////////////
// $<add> 09.26.2008
//////////////////////////////////////////////////////////////////////
Integer li_rtn
Long ll_pos
String ls_ext, ls_name, ls_rtn

IF IsNull(as_image) OR Not FileExists(as_image) THEN RETURN -1

//Check if the file is allowed to convert
ll_pos = LastPos(as_image,".")
IF ll_pos > 0 THEN ls_ext = Mid(as_image, ll_pos + 1)
IF NOT of_is_image2pdf(ls_ext) THEN 
         // 03/08/12 Added By mark 
//      MessageBox(as_image,"This document is unsupported to convert to a PDF format.", Exclamation!)
         if gb_recordlog = false then
                   MessageBox(as_image,"This document is unsupported to convert to a PDF format.", Exclamation!)
         else
                   gs_errmsg = "This document is unsupported to convert to a PDF format."
         end if
         RETURN -1
END IF

//Get the name of PDF document
IF IsNull(as_pdf) OR Len(Trim(as_pdf)) < 1 THEN 
         as_pdf = Left(as_image, ll_pos -1) + ".pdf"
END IF

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_pdf)
if Len(ls_Rtn) > 0 then
         // 03/08/12 Added By mark 
//      MessageBox(as_pdf,ls_Rtn, Exclamation!)
         if gb_recordlog = false then
                   MessageBox(as_pdf,ls_Rtn, Exclamation!)
         else
                   gs_errmsg = ls_Rtn
         end if
         Return -1
end if

//Convert to PDF format
SetPointer(Hourglass!)

TRY
li_rtn = ole_edit.object.Image2PDF(as_image, as_pdf)
CATCH (Throwable th1)
         SetPointer(Arrow!)
         RETURN -1
END TRY

SetPointer(Arrow!)
         
RETURN li_rtn

end function

public function boolean of_is_image2pdf (string as_ext);//Check if it's the type of image allowed to convert to PDF

Boolean lb_rtn

CHOOSE CASE Upper(as_ext)
	CASE "BMP", "GIF", "ICO", "JPG", "JPEG", "PCX", "PNG", "PSD", "TIF", "WMF", "WBMP", "TGA", "PGX", "RAS", "PNM"
		lb_rtn = TRUE
	CASE ELSE
		lb_rtn = FALSE
END CHOOSE

RETURN lb_rtn


end function

public function integer of_saveas_tif (ref string as_filename);return 1
end function

public function integer of_get_from_clip (ref string as_filename);Integer li_ret

//gs_app_image_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)
//as_filename = gs_app_image_path +  '\clipboard'

gs_app_image_path = gs_dir_path + gs_DefDirName + "\Agreement\Image"
as_filename = gs_app_image_path +  '\clipboard'
gnv_appeondll.of_parsepath(gs_app_image_path)

ole_edit.object.filename = ''
ole_edit.object.LoadMultiPage('',0)

If Not ole_edit.object.PasteFromClipboard() Then
	Messagebox('Paste','Please copy a page first.')
	Return -1
End If

If FileExists ( as_filename ) Then
	If FileDelete(as_filename) Then
		Messagebox('Paste','Failed to delete the temporory file "' +as_filename+ '".')
		Return -2
	End If
End If

If ole_edit.object.Save(as_filename,'TIF') <> 1 Then
	Messagebox('Paste','Failed to generate the temporory file, please call support.')
	Return -3
End If

If Not FileExists ( as_filename + '.tif' ) Then 
	Messagebox('Paste','Failed to paste, please call support.')
	Return -4
End If

as_filename = as_filename + '.tif'
Return 1
	
end function

public function string of_get_last_ocr_text ();Return is_ocr_text
end function

public function boolean of_ocr_is_finished ();Return ib_ocr_finished
end function

public subroutine of_reset_ocr ();ib_ocr_finished = False
is_ocr_text = ''
end subroutine

public function integer of_tifmergemultifiles (string as_tif_list, string as_output_tif);// (Appeon)Harry 06.10.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////
// $<function>of_tifmergemultifiles
// $<arguments>String as_tif_list, as_output_tif
//$<return>  1 - Successful
//$<return> -1 - The list of source TIFF files string is empty.
//$<return> -2 - The string of the destination TIFF File is empty.
//$<return> -3 - The list of source file have non TIFF file.
//$<return> -4 - Some File does not existing in the list of source file.
// $<description>Merge tif files
//////////////////////////////////////////////////////////////////////
// $<add> alfee 12.06.2011
//////////////////////////////////////////////////////////////////////
Integer li_rtn
Long ll_pos
String ls_ext, ls_name, ls_rtn

IF IsNull(as_tif_list) OR  Len(Trim(as_tif_list)) < 1 THEN RETURN -1
IF IsNull(as_output_tif) OR Len(Trim(as_output_tif)) < 1 THEN RETURN -1

//Check the output file and write right on the folder
ll_pos = LastPos(as_output_tif,".")
IF ll_pos > 0 THEN ls_ext = MidA(as_output_tif, ll_pos + 1, 3)
IF Upper(ls_ext) <> 'TIF' THEN RETURN -1

ls_Rtn = f_ExaWriteRight(as_output_tif)
IF LenA(ls_Rtn) > 0 THEN RETURN -1

//Begin merging
SetPointer(Hourglass!)

TRY
li_rtn = ole_edit.object.TIFMergeMultiFiles (as_tif_list, as_output_tif)
CATCH (Throwable th1)
	SetPointer(Arrow!)
	RETURN -1
END TRY

SetPointer(Arrow!)
	
RETURN li_rtn

end function

public function integer of_tifmerge (string as_tif1, string as_tif2, string as_output_tif);// (Appeon)Harry 06.10.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////
// $<function>of_tifmerge
// $<arguments>String as_tif1, as_tif2, as_output_tif
// $<returns> integer 1- success; -1 - Failed
// $<description>Merge tif files
//////////////////////////////////////////////////////////////////////
// $<add> alfee 12.06.2011
//////////////////////////////////////////////////////////////////////
Long ll_pos
String ls_ext, ls_name, ls_rtn
Boolean lb_rtn

IF IsNull(as_tif1) OR  Len(Trim(as_tif1)) < 1 THEN RETURN -1
IF IsNull(as_tif2) OR  Len(Trim(as_tif2)) < 1 THEN RETURN -1
IF NOT FileExists(as_tif1) OR NOT FileExists(as_tif2) THEN RETURN -1
IF IsNull(as_output_tif) OR Len(Trim(as_output_tif)) < 1 THEN RETURN -1

//Check the source files
ll_pos = LastPos(as_tif1,".")
IF ll_pos > 0 THEN ls_ext = MidA(as_tif1, ll_pos + 1, 3)
IF Upper(ls_ext) <> 'TIF' THEN RETURN -1

ll_pos = LastPos(as_tif2,".")
IF ll_pos > 0 THEN ls_ext = MidA(as_tif2, ll_pos + 1, 3)
IF Upper(ls_ext) <> 'TIF' THEN RETURN -1

//Check the output file and write right on the folder
ll_pos = LastPos(as_output_tif,".")
IF ll_pos > 0 THEN ls_ext = MidA(as_output_tif, ll_pos + 1, 3)
IF Upper(ls_ext) <> 'TIF' THEN RETURN -1

ls_Rtn = f_ExaWriteRight(as_output_tif)
IF LenA(ls_Rtn) > 0 THEN RETURN -1

//Begin merging
SetPointer(Hourglass!)

TRY
lb_rtn = ole_edit.object.TIFMerge(as_tif1, as_tif2, as_output_tif)
CATCH (Throwable th1)
	SetPointer(Arrow!)
	RETURN -1
END TRY

SetPointer(Arrow!)

IF NOT lb_rtn THEN 
	RETURN -1
END IF	
	
RETURN 1	


end function

public function integer of_pdf2tif (string as_pdf, string as_tif, boolean ab_truecolor);// (Appeon)Harry 06.10.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////
// $<function>of_pdf2tif
// $<arguments>String as_pdf, as_tif
// $<returns> integer 1- success; -1 - Failed
// $<description>Convert a document from PDF to TIF format
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 04.09.2009
//$<modfiy>Add the argument 'ab_truecolor ' - alfee 02.18.2013
//////////////////////////////////////////////////////////////////////
Integer li_rtn
Long ll_pos
String ls_ext, ls_name, ls_rtn

IF IsNull(as_pdf) OR Not FileExists(as_pdf) THEN RETURN -1

//Check if it is a PDF document
ll_pos = LastPos(as_pdf,".")
IF ll_pos > 0 THEN ls_ext = MidA(as_pdf, ll_pos + 1)
IF Upper(ls_ext) <> 'PDF' THEN RETURN -1

//Get the name of TIF document
IF IsNull(as_tif) OR LenA(Trim(as_tif)) < 1 THEN 
	as_tif = LeftA(as_pdf, ll_pos -1) 
ELSEIF Upper(RightA(Trim(as_tif),4)) = '.TIF' THEN
	as_tif = LeftA(as_tif, LastPos(as_tif,".") - 1)
ELSE
	// Nothing
END IF

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_tif + '.tif')
if LenA(ls_Rtn) > 0 then
	MessageBox(as_tif,ls_Rtn, Exclamation!)
	Return -1
end if

//Convert to TIF format
SetPointer(Hourglass!)
TRY


li_rtn = ole_edit.Object.LoadMultiPage(as_pdf,1) //load pdf file
//Added by harry 10.26.2017 V15.3 Bug # 5855 - Can't delete PDF from desktop after uploading into program - file in use error
IF ole_edit.Object.GetTotalPage() = 1 THEN
	IF of_change_path(as_pdf) = 1 THEN  ole_edit.Object.LoadMultiPage(as_pdf,1) 
END IF
IF li_rtn = 1 THEN 
	//-------Begin Modified by Alfee 05.06.2010-----------------------
	integer li_x, li_y, li_pdf_x, li_pdf_y, li_w, li_h
	li_x = ole_edit.Object.Xdpi 
	li_y = ole_edit.Object.Ydpi 
	//---------Begin Modified by (Appeon)Stephen 11.22.2017 for Bug ID #5890 for Case #00074090 - Documents not printing the right size--------
	/*
	li_pdf_x = ole_edit.Object.PDFRenderDPIX	
	li_pdf_y = ole_edit.Object.PDFRenderDPIY	
	*/
	li_pdf_x = 106
	li_pdf_y = 106
	//---------End Modfiied ------------------------------------------------------
	li_w = ole_edit.Object.FileWidth
	li_h = ole_edit.Object.FileHeight
		li_w = li_w * li_x / li_pdf_x
		li_h = li_h * li_y / li_pdf_y
		IF NOT ab_truecolor THEN li_rtn = ole_edit.Object.ConvertTo8bppGrayScale() //Ticket #00039904 - alfee 02.18.2013		


		IF ab_truecolor THEN ole_edit.Object.ConvertTo24bpp()//Added by Appeon long.zhang 12.15.2014(Mirrored Document Issue) 	
		//sleep(0.5)

		li_rtn = ole_edit.Object.SaveBySize(as_tif, "TIF", li_w, li_h) //save to tif file
	//Yield()//Added by Appeon long.zhang 2.4.2015(Mirrored Document Issue) 
	
	//li_rtn = ole_edit.Object.Save(as_tif, "TIF") //save to tif file
	//-------End Modified -------------------------------------------
END IF

CATCH (Throwable th1)
	SetPointer(Arrow!)
	RETURN -1
END TRY

SetPointer(Arrow!)
	
RETURN li_rtn

end function

public function integer of_pdf2tif (string as_pdf, string as_tif);// (Appeon)Harry 06.10.2013 - V141 ISG-CLX
//Added by Alfee 02.18.2013

Return of_pdf2tif(as_pdf, as_tif, true)
end function

public subroutine of_release_file ();//Release file //Added by Appeon long.zhang 03.17.2015 (Uploading PDFs sometimes previews upside down & reversed)
ole_edit.object.filename = ''
ole_edit.object.LoadMultiPage('',0)
end subroutine

public function integer of_pdf2tif (string as_pdf, string as_tif, string as_format, integer ai_dpi, integer ai_method);//====================================================================
//$<Function>: of_pdf2tif
//$<Arguments>:
// 	value    string     as_pdf
// 	value    string     as_tif
// 	value    string     as_format
// 	value    integer    ai_dpi
// 	value    integer    ai_method 1:only with high pdf dpi /2:try to save a large size tif, then zoom out it to a high dip tif.
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer li_rtn, li_zoom
integer li_x, li_y, li_pdf_x, li_pdf_y, li_w, li_h
Int li_PDFRenderDPIX_old, li_PDFRenderDPIY_old, li_Xdpi_old, li_Ydpi_old

//Convert to TIF format
SetPointer(Hourglass!)
TRY
	//Remeber the old
	li_PDFRenderDPIX_old =  ole_edit.Object.PDFRenderDPIX
	li_PDFRenderDPIY_old =  ole_edit.Object.PDFRenderDPIY
	li_Xdpi_old = ole_edit.Object.Xdpi
	li_Ydpi_old = ole_edit.Object.Ydpi
	
	//Take effect when loading PDF
	ole_edit.Object.PDFRenderDPIX = ai_dpi
	ole_edit.Object.PDFRenderDPIY = ai_dpi
	
	//Take effect when saving TIF, use the same dpi with PDF
	ole_edit.Object.Xdpi = ai_dpi
	ole_edit.Object.Ydpi= ai_dpi

	li_rtn = ole_edit.Object.LoadMultiPage(as_pdf,true) //load pdf file
	IF li_rtn = 1 THEN 
		
 		//Convert format
		Choose Case as_format
			Case 	"GS" // GrayScale, Convert current image to 8 bit gray-scaled palette color image.
				ole_edit.Object.ConvertTo8bppGrayScale()
			Case  "TC" //True Color 24, Convert current image to 24 bit RGB color image.
				ole_edit.Object.ConvertTo24bpp()
			Case 'BW' //Black and White, Convert current image to 1 bit Black and White (Bitonal) image
				ole_edit.Object.ConvertTo1bpp()
				
			/*Other Formats
			
			//Convert current image to 4 bit palette color image.
			ConvertTo4bpp()
			 
			//Convert current image to 8 bit palette color image.
			ConvertTo8bpp()
			 
			//Convert current image to 16 bit RGB 555 color image.
			ConvertTo16bppRGB555()
			 
			//Convert current image to 16 bit RGB 565 color image.
			ConvertTo16bppRGB565()
			 
			// Convert current image to 32 bit RGB color image.
			ConvertTo32bpp    
			 
			//Convert current image to 32 bit ARGB color image.
			ConvertTo32bppARGB()
			*/
		End Choose
		
		If ai_method = 1 Then
			//save to tif file by size, by Appeon long.zhang 07.29.2015
			li_w = (ole_edit.Object.FileWidth) * (96/ai_dpi)
			li_h = (ole_edit.Object.FileHeight) * (96/ai_dpi)
			li_rtn = ole_edit.Object.SaveBySize(as_tif, "TIF", li_w, li_h) 
		ElseIf  ai_method = 2 Then
			li_rtn = ole_edit.Object.Save(as_tif, "TIF") //save to tif file	(a very large file)
		End If
	END IF
	
	//Restore dpi setting
	ole_edit.Object.PDFRenderDPIX = li_PDFRenderDPIX_old
	ole_edit.Object.PDFRenderDPIY = li_PDFRenderDPIY_old
	ole_edit.Object.Xdpi = li_Xdpi_old
	ole_edit.Object.Ydpi= li_Ydpi_old
	
CATCH (Throwable th1)
	SetPointer(Arrow!)
	RETURN -1
END TRY

of_release_file()
SetPointer(Arrow!)

//Change DPI and size to normal, Added by Appeon long.zhang 07.30.2015 
If ai_method = 2 Then
	IF Not IsValid(w_dm_imaging) THEN Open(w_dm_imaging)
	IF NOT IsValid(w_dm_imaging) THEN RETURN -1
	
	li_zoom = Integer(96 * 100/ai_dpi)
	w_dm_imaging.of_tif2tif(as_tif, as_tif, li_zoom, ai_dpi )
	Close(w_dm_imaging)
End If
	
RETURN li_rtn
end function

public function integer of_pdf2tif (string as_pdf, string as_tif, string as_format, integer ai_dpi);//====================================================================
//$<Function>: of_pdf2tif
//$<Arguments>:
// 	value    string     as_pdf
// 	value    string     as_tif
// 	value    string     as_format
// 	value    integer    ai_dpi
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//try to save a large size tif, then zoom out it to a high dip tif
Return of_pdf2tif(as_pdf, as_tif, as_format, ai_dpi, 1)

end function

public function integer of_pdf2tifbw (string as_file_from, string as_file_to);//Start Code Change ----07.07.2016 #V152 maha - added from Ronnie Po modified

string ls_read_path, ls_write_path, ls_filename
integer li_dpi, li_ret, li_olddpi, li_oldTIFCompression
pointer old_ptr
Long ll_pos

//Check if it is a PDF document, Added by Appeon long.zhang 11.09.2016 (Bug ID #5397 for Case # 00067601: IS issue 110716)
ll_pos = LastPos(as_file_from,".")
IF ll_pos > 0 THEN 
	If Upper(MidA(as_file_from, ll_pos + 1)) <> 'PDF' THEN RETURN -1
End If

ls_read_path =  as_file_from
IF NOT FileExists(ls_read_path) THEN
	messageBox("", "Invalid source file.")
	return -1
END IF

//Get the name of TIF document, Added by Appeon long.zhang 11.09.2016 (Bug ID #5397 for Case # 00067601: IS issue 110716)
IF IsNull(as_file_to) OR LenA(Trim(as_file_to)) < 1 THEN 
	as_file_to = LeftA(as_file_from, ll_pos -1) 
ELSEIF Upper(RightA(Trim(as_file_to),4)) = '.TIF' THEN
	as_file_to = LeftA(as_file_to, LastPos(as_file_to,".") - 1)
ELSE
	// Nothing
END IF

//Remember old setting, Added by Appeon long.zhang 09.19.2016
li_olddpi = ole_edit.Object.PDFRenderDPIX
li_oldTIFCompression = ole_edit.Object.TIFCompression
//---------Begin Modified by (Appeon)Stephen 09.06.2017 for  Image Viewer CP Upgrade --------
//li_dpi = 400
li_dpi = 100
//---------End Modfiied ------------------------------------------------------

ole_edit.Object.PDFRenderDPIX = li_dpi
ole_edit.Object.PDFRenderDPIY = li_dpi

// The "save" dpi
//---------Begin Modified by (Appeon)Stephen 11.22.2017 for Bug ID #5890 for Case #00074090 - Documents not printing the right size--------
//ole_edit.Object.Xdpi =  li_dpi
//ole_edit.Object.Ydpi=  li_dpi
ole_edit.Object.Xdpi = 106
ole_edit.Object.Ydpi= 106
//---------End Modfiied ------------------------------------------------------

old_ptr = setPointer(hourglass!)
li_ret = ole_edit.Object.LoadMultiPage(ls_read_path,1)
//Added by harry 10.26.2017 V15.3 Bug # 5855 - Can't delete PDF from desktop after uploading into program - file in use error
IF ole_edit.Object.GetTotalPage() = 1 THEN
	IF of_change_path(ls_read_path) = 1 THEN  ole_edit.Object.LoadMultiPage(ls_read_path,1)  
END IF
setPointer(old_ptr)

IF li_ret = 0 THEN
	messageBox("", "Unable to load multi-page document.")
	return -1
END IF


//CASE "BW"
ole_edit.Object.ConvertTo4bpp()
ole_edit.Object.TIFCompression = 2  //TIFCompressionCCITT4
//	CASE "GS"
//		ole_1.Object.ConvertTo8bppGrayScale()
//		ole_1.Object.TIFCompression = TIFCompressionLZW
//	CASE "TC"
//		ole_1.Object.ConvertTo8bpp()
//		ole_1.Object.TIFCompression = TIFCompressionLZW
//END CHOOSE

/* Save to scratch directory and preview */
ls_filename = as_file_to
li_ret = ole_edit.Object.Save(ls_filename, "TIF")

/* Release image from ActiveX */
ole_edit.object.filename = ""
ole_edit.object.LoadMultiPage("",0)

//Restore dpi, TIFCompression and format Added by Appeon long.zhang 09.19.2016
ole_edit.Object.PDFRenderDPIX = li_olddpi
ole_edit.Object.PDFRenderDPIY = li_olddpi
ole_edit.Object.Xdpi = li_olddpi
ole_edit.Object.Ydpi= li_olddpi
ole_edit.Object.TIFCompression = li_oldTIFCompression
ole_edit.Object.ConvertTo24bpp()

return 1

end function

public function integer of_change_path (ref string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_change_path
// $<arguments>String as_filename
// $<returns> integer 1- success; -1 - Failed
// $<description>Copy PDF file into temp directory.
//////////////////////////////////////////////////////////////////////
// $<add>(APPEON) Harry for V15.3 Bug # 5855 - Can't delete PDF from desktop after uploading into program - file in use error
//////////////////////////////////////////////////////////////////////

String ls_new_path
ls_new_path = gs_temp_path + "images"
If Not DirectoryExists ( ls_new_path ) Then
	CreateDirectory ( ls_new_path )
End If

ls_new_path = ls_new_path + "\" + RightA(as_filename,LenA(as_filename) - LastPos(as_filename,"\"))

If FileCopy (as_filename, ls_new_path, True) = 1 Then 
	as_filename = ls_new_path
Else
	Return -1
End If

Return 1
end function

public function string of_save_partpages_pdf (string as_filename, long al_start_page, long al_pagecnt);//////////////////////////////////////////////////////////////////////
// $<function>of_save_partpages_pdf
// $<arguments>
//		String as_filename
//		Long al_start_page
// $<returns> string ls_new_path
// $<description>Save part of consecutive pages
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////

Long ll_totalpage
String ls_new_path
String ls_Rtn
Long i

IF IsNull(as_filename) OR Not FileExists(as_filename) THEN RETURN ''


//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_filename)
if Len(ls_Rtn) > 0 then
         if gb_recordlog = false then
                   MessageBox(as_filename,ls_Rtn, Exclamation!)
         else
                   gs_errmsg = ls_Rtn
         end if
         Return ''
end if


ole_edit.object.LoadMultiPage(as_filename, 1)
ll_totalpage = ole_edit.object.gettotalpage()

if al_start_page = 1 and al_pagecnt = ll_totalpage then
	ls_new_path = as_filename
else
	ls_new_path = left(as_filename, lastpos(as_filename,'.') - 1) + '_template.pdf'
	filecopy(as_filename, ls_new_path)
	
	For i =  ll_totalpage - 1 to 0 STEP -1
		if i >= al_start_page - 1  and i <= al_start_page + al_pagecnt - 2 then continue
		ole_edit.object.PDFEditDeletePage (ls_new_path, i)
	Next
end if


return ls_new_path
end function

public function integer of_insert_page_pdf (string as_org_filename, string as_ins_filename, long al_ins_page, long al_start_page, long al_pagecnt);//////////////////////////////////////////////////////////////////////
// $<function>of_insert_page_pdf
// $<arguments>
//		String as_org_filename
//		String as_ins_filename
//		Long al_ins_page
//		Long al_start_page
//		Long al_pagecnt
// $<returns> integer 1- success; -1 - Failed
// $<description>Insert the file at the specified location
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
String  ls_ins_path_temp
Long ll_countpage
String ls_Rtn

//IF IsNull(as_org_filename) OR Not FileExists(as_org_filename) THEN RETURN -1
IF IsNull(as_ins_filename) OR Not FileExists(as_ins_filename) THEN RETURN -1

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_org_filename)
if Len(ls_Rtn) > 0 then
         if gb_recordlog = false then
                   MessageBox(as_org_filename,ls_Rtn, Exclamation!)
         else
                   gs_errmsg = ls_Rtn
         end if
         Return -1
end if

IF FileExists(as_org_filename) THEN
	ole_edit.object.LoadMultiPage(as_org_filename, 1)
	ll_countpage = ole_edit.object.gettotalpage()
	
	if ll_countpage < al_ins_page or al_ins_page <= 0 then al_ins_page = ll_countpage
END IF

ls_ins_path_temp = of_save_partpages_pdf(as_ins_filename, al_start_page, al_pagecnt)
if ls_ins_path_temp = '' or  Not FileExists(ls_ins_path_temp)  then return -1

SetPointer(Hourglass!)

TRY
	IF Not FileExists(as_org_filename) THEN
		FileCopy(ls_ins_path_temp, as_org_filename, false)
	ELSE
		ole_edit.object.PDFEditAddPage (as_org_filename, al_ins_page, ls_ins_path_temp, as_org_filename)
	END IF
CATCH (Throwable th1)
    SetPointer(Arrow!)
    RETURN -1
END TRY

SetPointer(Arrow!)


if ls_ins_path_temp <> as_ins_filename and fileexists(ls_ins_path_temp) then filedelete(ls_ins_path_temp)

return 1
end function

public function string of_delete_page_pdf (string as_filename, long al_start_page, long al_pagecnt);//////////////////////////////////////////////////////////////////////
// $<function>of_delete_page_pdf
// $<arguments>
//		String as_filename
//		Long al_start_page
//		Long al_pagecnt
// $<returns> string ls_new_path
// $<description>Delete part of consecutive pages
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
Long ll_totalpage
String ls_new_path
String ls_Rtn
long ll_end_page
Long i

IF IsNull(as_filename) OR Not FileExists(as_filename) THEN RETURN ''

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_filename)
if Len(ls_Rtn) > 0 then
         if gb_recordlog = false then
                   MessageBox(as_filename,ls_Rtn, Exclamation!)
         else
                   gs_errmsg = ls_Rtn
         end if
         Return ''
end if

ole_edit.object.LoadMultiPage(as_filename, 1)
ll_totalpage = ole_edit.object.gettotalpage()

if al_start_page <= 0 then al_start_page = 1

if al_start_page > ll_totalpage then return as_filename
	
if al_start_page + al_pagecnt - 1 > ll_totalpage then
	ll_end_page = ll_totalpage - 1
else
	ll_end_page = al_start_page + al_pagecnt - 2
end if

//if al_start_page = 1 and al_pagecnt = ll_totalpage then
//	ls_new_path = as_filename
//else
	For i =  ll_end_page to al_start_page - 1 STEP -1
		ole_edit.object.PDFEditDeletePage (as_filename, i)
	Next
	ls_new_path = as_filename
//end if

return ls_new_path
end function

public function integer of_pdfeditmerge (string as_file1, string as_file2);//////////////////////////////////////////////////////////////////////
// $<function>of_pdfeditmerge
// $<arguments>
//		String as_file1
//		String as_file2
// $<returns> integer 1- success; -1 - Failed
// $<description>merge two file
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
String ls_Rtn
Int li_rtn
IF IsNull(as_file2) OR Not FileExists(as_file2) THEN RETURN -1


//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_file1)
if Len(ls_Rtn) > 0 then
         if gb_recordlog = false then
                   MessageBox(as_file1,ls_Rtn, Exclamation!)
         else
                   gs_errmsg = ls_Rtn
         end if
         Return -1
end if

//merge file
SetPointer(Hourglass!)
IF Not FileExists(as_file1) THEN
	li_rtn = FileCopy(as_file2, as_file1)
ELSE
	TRY
		li_rtn = ole_edit.object.PDFEditMerge (as_file1, as_file2, as_file1)
	CATCH (Throwable th1)
		SetPointer(Arrow!)
		RETURN -1
	END TRY
END IF

SetPointer(Arrow!)

Return li_rtn
end function

public function integer of_printimage (string as_filename, long al_start, long al_end, integer ai_view, boolean ab_dialog);//////////////////////////////////////////////////////////////////////
// $<function>of_printimage
// $<arguments>
//		String as_filename
//		Long al_start
//		Long al_end
//		Int ai_view
// $<returns> integer 1- success; -1 - Failed
// $<description>Print  the current image to user define printer 
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
Long ll_totalpage

IF IsNull(as_filename) OR Not FileExists(as_filename) THEN RETURN -1

ole_edit.object.LoadMultiPage(as_filename, 1)
ll_totalpage = ole_edit.object.gettotalpage()

IF al_end > ll_totalpage THEN al_end = ll_totalpage

SetPointer(HourGlass!)
ole_edit.Object.view = ai_view
ole_edit.Object.PrintStartPage= al_start
ole_edit.Object.PrintEndPage = al_end
ole_edit.Object.PrintImage(ab_dialog)
SetPointer(Arrow!)

RETURN 1
end function

public function integer of_saveas (string as_filename, string as_saveas, string as_ext);//////////////////////////////////////////////////////////////////////
// $<function>of_saveas
// $<arguments>
//		String as_filename
//		String as_saveas
//		String as_ext
// $<returns> (NONE)
// $<description>saveas
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.17.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
Long ll_totalpage
String ls_new_path
String ls_Rtn
String ls_saveas
Int li_ret
Long i

IF IsNull(as_filename) OR Not FileExists(as_filename) THEN RETURN -1

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_saveas)
if Len(ls_Rtn) > 0 then
         if gb_recordlog = false then
                   MessageBox(as_saveas,ls_Rtn, Exclamation!)
         else
                   gs_errmsg = ls_Rtn
         end if
         Return -1
end if

ole_edit.object.filename = as_filename
ole_edit.object.LoadMultiPage(as_filename, 1)

ls_saveas = Left(as_saveas, LastPos(as_saveas, '.') - 1)

SetPointer(Hourglass!)

TRY
	li_ret = ole_edit.object.Save (ls_saveas, as_ext)
CATCH (Throwable th1)
	SetPointer(Arrow!)
	RETURN -1
END TRY

SetPointer(Arrow!)

Return li_ret
end function

public function integer of_savebysize (string as_from, string as_to, string as_ext);//////////////////////////////////////////////////////////////////////
// $<function>of_savebysize
// $<arguments>String as_from,as_to, as_ext
// $<returns> integer 1- success; -1 - Failed
// $<description>Save the current image to other image format and resize the image to specific resolution.
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.23.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
Integer li_rtn
Long ll_pos
String ls_ext, ls_name, ls_rtn

IF IsNull(as_from) OR Not FileExists(as_from) THEN RETURN -1

//Check if it is a PDF document
ll_pos = LastPos(as_from,".")
IF ll_pos > 0 THEN ls_ext = MidA(as_from, ll_pos + 1)
IF Upper(ls_ext) <> 'PDF' THEN RETURN -1

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_to)
if LenA(ls_Rtn) > 0 then
	MessageBox(as_to,ls_Rtn, Exclamation!)
	Return -1
end if

//Get the name 
as_to = LeftA(as_to, LastPos(as_to,".") - 1)



//Resize and Convert to as_ext format
SetPointer(Hourglass!)
TRY


li_rtn = ole_edit.Object.LoadMultiPage(as_from,1) //load pdf file
//Added by harry 10.26.2017 V15.3 Bug # 5855 - Can't delete PDF from desktop after uploading into program - file in use error
IF ole_edit.Object.GetTotalPage() = 1 THEN
	IF of_change_path(as_from) = 1 THEN  ole_edit.Object.LoadMultiPage(as_from,1) 
END IF
IF li_rtn = 1 THEN 
	//-------Begin Modified by Alfee 05.06.2010-----------------------
	integer li_x, li_y, li_pdf_x, li_pdf_y, li_w, li_h
	li_x = ole_edit.Object.Xdpi 
	li_y = ole_edit.Object.Ydpi 
	//---------Begin Modified by (Appeon)Stephen 11.22.2017 for Bug ID #5890 for Case #00074090 - Documents not printing the right size--------
	/*
	li_pdf_x = ole_edit.Object.PDFRenderDPIX	
	li_pdf_y = ole_edit.Object.PDFRenderDPIY	
	*/
	li_pdf_x = 106
	li_pdf_y = 106
	//---------End Modfiied ------------------------------------------------------
	li_w = ole_edit.Object.FileWidth
	li_h = ole_edit.Object.FileHeight
		li_w = li_w * li_x / li_pdf_x
		li_h = li_h * li_y / li_pdf_y
	
		li_rtn = ole_edit.Object.SaveBySize(as_to, as_ext, li_w, li_h) //save to as_ext file

	
END IF

CATCH (Throwable th1)
	SetPointer(Arrow!)
	RETURN -1
END TRY

SetPointer(Arrow!)
	
RETURN li_rtn

end function

public function integer of_gettotalpage (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_gettotalpage
// $<arguments>
//		String as_filename
// $<returns> pagecount
// $<description>Get total pages
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
Long ll_countpage


IF IsNull(as_filename) OR Not FileExists(as_filename) THEN RETURN 0

ole_edit.object.Filename = ''
ole_edit.object.LoadMultiPage(as_filename, 1)

TRY
	ll_countpage = ole_edit.object.GetTotalPage ()
CATCH (Throwable th1)
	RETURN -1
END TRY
	
RETURN ll_countpage




end function

on w_dm_image_cp.create
this.ole_edit=create ole_edit
this.Control[]={this.ole_edit}
end on

on w_dm_image_cp.destroy
destroy(this.ole_edit)
end on

event close;//Release file
ole_edit.object.filename = ''
ole_edit.object.LoadMultiPage('',0)

If isvalid(inv_filesrv) Then Destroy inv_filesrv

end event

event open;inv_filesrv = Create n_cst_filesrvwin32 
gw_popup[UpperBound(gw_popup[]) + 1] = This //Added by Appeon long.zhang 03.17.2015 (Uploading PDFs sometimes previews upside down & reversed)
end event

type ole_edit from olecustomcontrol within w_dm_image_cp
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
integer x = 5
integer width = 914
integer height = 800
integer taborder = 70
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_dm_image_cp.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event ocrrecognized(boolean bsuccess);
Blob lb_data
String ls_path,ls_filename 

ib_ocr_finished = True
If bsuccess Then
	
	is_ocr_text = ole_edit.object.OCRGetRecognizedText( ) 
	
	/*
	//Workaround OCR plugin 6.0 bug for vista and windows 7
	ls_path = gs_dir_path + gs_DefDirName + '\OCR\'
	gnv_appeondll.of_parsepath( ls_path )
	ls_filename = ls_path + String(today(),'yyyymmdd') + String(Now(),'hhmmss') + '.txt'
	If FileExists(ls_filename) Then 
		If Not FileDelete(ls_filename) Then
			is_ocr_text = ''
			Messagebox('OCR','Failed to delete the OCR temp file ' + ls_filename + ', please call support.')
			Return
		End If
	End If
	ole_edit.object.OCRSaveRecognizedText(ls_filename)
	inv_filesrv.of_fileread(ls_filename, lb_data)
	is_ocr_text = String(lb_data)
	FileDelete(ls_filename)
	*/
Else
	is_ocr_text = ''
End If

end event

event constructor;This.object.licensekey = '12820'
This.object.PDFUseAdvancedViewer = true //(Appeon)Stephen 09.05.2017 - Image Viewer CP Upgrade 
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
02w_dm_image_cp.bin 
2200000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000366dd5c001d36eff00000003000001800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004e589da784fc5ad4c479eb9b69e6710b100000000366dd5c001d36eff366dd5c001d36eff000000000000000000000000fffffffe000000020000000300000004fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0065004400650076006f006c00650070002000720069006c006500630073006e003a0065003600350033003700000000000000000000000000000000000000000000fffe00020106e589da784fc5ad4c479eb9b69e6710b100000001fb8f0821101b01640008ed8413c72e2b00000030000000a40000000500000100000000300000010100000038000001020000004000000103000000480000000000000050000000030001000000000003000014ac00000003000014ac00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000014ac000014ac00000000000001010000000000000000000000006564040000646f6d0000000000000000000001006000600050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000003e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
12w_dm_image_cp.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
