$PBExportHeader$w_get_image.srw
forward
global type w_get_image from window
end type
type ole_thumb_pdf from u_thumb_edit_cp1 within w_get_image
end type
type cb_all from commandbutton within w_get_image
end type
type st_1 from statictext within w_get_image
end type
type st_filename from statictext within w_get_image
end type
type cb_2 from commandbutton within w_get_image
end type
type cb_1 from commandbutton within w_get_image
end type
type ole_edit from olecustomcontrol within w_get_image
end type
type ole_thumb from olecustomcontrol within w_get_image
end type
type ole_edit_pdf from u_image_edit_cp1 within w_get_image
end type
end forward

global type w_get_image from window
integer x = 27
integer y = 64
integer width = 3602
integer height = 2880
boolean titlebar = true
string title = "Select Image File"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
ole_thumb_pdf ole_thumb_pdf
cb_all cb_all
st_1 st_1
st_filename st_filename
cb_2 cb_2
cb_1 cb_1
ole_edit ole_edit
ole_thumb ole_thumb
ole_edit_pdf ole_edit_pdf
end type
global w_get_image w_get_image

type variables
pfc_cst_u_imaging uo_image_object
String is_image_file_name
String is_file_name

String is_ext = 'tif' //Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
end variables

forward prototypes
public function integer of_change_path ()
public function integer of_restore_path ()
public function integer of_user_date_stamp ()
public subroutine of_set_visible_pdf (boolean ab_visible)
public subroutine of_thumb_click (long al_pageno)
public function integer of_user_date_stamp (string as_filename, boolean ab_save)
end prototypes

public function integer of_change_path ();//Change to file path accessed last time - alfee 05.11.2009
 //Start Code Change ----08.08.2012 #V12 maha - rewrote to get path stored in ini file
string ls_dir

IF Not IsValid(uo_image_object) THEN RETURN -1

ls_dir = ProfileString(gs_IniFilePathName, "Paths", "Image_Files", uo_image_object.is_last_file_path )

IF DirectoryExists(ls_dir) then
	if GetCurrentDirectory() <> ls_dir THEN
		ChangeDirectory(ls_dir)	
	end if
END IF

RETURN 1
 //End Code Change ----08.08.2012 


//IF Not IsValid(uo_image_object) THEN RETURN -1
//
//IF DirectoryExists(uo_image_object.is_last_file_path) AND &
//	GetCurrentDirectory() <> uo_image_object.is_last_file_path THEN
//	ChangeDirectory(uo_image_object.is_last_file_path)	
//END IF
//
//RETURN 1
end function

public function integer of_restore_path ();//Set variable of is_last_file_path and restore current path - alfee 05.11.2009

IF IsValid(uo_image_object) THEN 
	uo_image_object.is_last_file_path = GetCurrentDirectory()
	SetProfileString(gs_IniFilePathName, "Paths", "Image_Files",uo_image_object.is_last_file_path)  //Start Code Change ----08.08.2012 #V12 maha
END IF

ChangeDirectory(gs_current_path)

RETURN 1
end function

public function integer of_user_date_stamp ();//Start Code Change ----01.16.2014 #V14 maha
string ls_group
string ls_stamp
IF is_ext = 'PDF' THEN Return 0 //Added by (APPEON) Harry 11.30.2017 (V161 Storage of Documents as PDFs)
ls_group = string(time(now()))
ls_stamp = string(date(today())) + " " + string(time(now())) + " - " + gs_user_id 


try
//IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
//	int FontID
//	ole_edit_pdf.ole_edit.object.LoadMultiPage(gs_temp_path + "temp.pdf", 1)  //Added by (APPEON) Harry 11.29.2017 (V161 Storage of Documents as PDFs)
//	ole_edit_pdf.ole_edit.object.PDFOutputPDFA = true
//	ole_edit_pdf.ole_edit.object.PDFInitAnnotation()
//	FontID = ole_edit_pdf.ole_edit.object.PDFAddFont("Arial", False, False)
//	ole_edit_pdf.ole_edit.object.PDFEmbedFont(FontID)
//	ole_edit_pdf.ole_edit.object.PDFSetTextColor (0, 0, 0)
//	ole_edit_pdf.ole_edit.object.PDFDrawText (0, 1, 10, ls_stamp, FontID, 9, 0)
//	ole_edit_pdf.ole_edit.object.save (gs_temp_path + "temp", "pdf") //Added by (APPEON) Harry 11.29.2017 (V161 Storage of Documents as PDFs)
//
//ELSE
	ole_edit.Object.Image(  gs_temp_path + "temp.tif" )
	ole_edit.Object.SetCurrentAnnotationGroup( ls_group )
	ole_edit.Object.Page( 1 )
	ole_edit.Object.Display()
	
	ole_edit.Object.AnnotationStampText( ls_stamp )		
	ole_edit.Object.Annotationtype(8)	
	ole_edit.object.Draw(1, 1, 10,10)
	ole_edit.Object.BurnInAnnotations( 1, 2 )
	ole_edit.Object.save()
//END IF

catch (runtimeerror a)
	
end try


Return 1
end function

public subroutine of_set_visible_pdf (boolean ab_visible);//Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
ole_edit.visible =  not ab_visible
ole_thumb.visible = not ab_visible
ole_edit_pdf.visible = ab_visible
ole_thumb_pdf.visible = ab_visible

end subroutine

public subroutine of_thumb_click (long al_pageno);//Added by (APPEON) Harry 11.27.2017 (V161 Storage of Documents as PDFs)
ole_edit_pdf.ole_edit.Object.LoadMultiPage( ole_edit_pdf.ole_edit.Object.filename, al_pageno)


end subroutine

public function integer of_user_date_stamp (string as_filename, boolean ab_save);//Added by (APPEON) Harry 11.30.2017 (V161 Storage of Documents as PDFs)
string ls_group
string ls_stamp
integer li_x, li_y, li_pdf_x, li_pdf_y, li_w, li_h

IF  is_ext <> 'PDF' THEN Return 0

ls_group = string(time(now()))
ls_stamp = string(date(today())) + " " + string(time(now())) + " - " + gs_user_id 


try

	int FontID
	ole_edit_pdf.ole_edit.object.LoadMultiPage(as_filename, 1) 
	ole_edit_pdf.ole_edit.object.PDFOutputPDFA = true
	ole_edit_pdf.ole_edit.object.PDFInitAnnotation()
	FontID = ole_edit_pdf.ole_edit.object.PDFAddFont("Arial", False, False)
	ole_edit_pdf.ole_edit.object.PDFEmbedFont(FontID)
	ole_edit_pdf.ole_edit.object.PDFSetTextColor (0, 0, 0)
	ole_edit_pdf.ole_edit.object.PDFDrawText (0, 1, 10, ls_stamp, FontID, 10, 0)
	//IF ab_save THEN ole_edit_pdf.ole_edit.object.save (gs_temp_path + "temp", "pdf") 
	//Modified by (APPEON) Harry 12.07.2017 for BugS120101
	IF ab_save THEN
		li_x = ole_edit_pdf.ole_edit.object.Xdpi 
		li_y = ole_edit_pdf.ole_edit.object.Ydpi 
		li_pdf_x = 106
		li_pdf_y = 106
		li_w = ole_edit_pdf.ole_edit.object.FileWidth
		li_h = ole_edit_pdf.ole_edit.object.FileHeight
		li_w = li_w * li_x / li_pdf_x
		li_h = li_h * li_y / li_pdf_y
		
		ole_edit_pdf.ole_edit.object.SaveBySize(gs_temp_path + "temp", "pdf", li_w, li_h) //save
	END IF

catch (runtimeerror a)
	
end try


Return 1
end function

event open;String docname, named
string ls_format //maha 07.22.2016
Integer Value
integer li_format  //maha 11.08.2016
Long li_return
n_cst_image_functions_cp  inv_image_func
Boolean lb_rtn
Int li_count

	
//--------Begin Added by Alfee 05.11.2009-----------------------
IF IsValid( w_prac_data_intelliapp ) THEN
	uo_image_object = w_prac_data_intelliapp.tab_1.tabpage_image.uo_image
ELSEIF IsValid(w_prac_data_1) THEN
	uo_image_object = w_prac_data_1.tab_1.tabpage_image.uo_image
ELSEIF IsValid(w_prac_data_sk) THEN //SK Practitioner Folder - alfee 09.07.2010
	uo_image_object = w_prac_data_sk.tab_1.tabpage_image.uo_image
END IF

of_change_path() //Change current path to the last accessed
//--------End Added --------------------------------------------

//--------Begin Commented by  Nova 05.19.2009------------------------
//Value = GetFileOpenName("Select File", &
//	+ docname, named, "TIF", &
//	+ "Tif Files (*.Tif),*.Tif," &
//	+ "Bmp Files (*.Bmp),*.Bmp," &
//	+ "jpg Files (*.jpg),*.jpg" )
//--------End Commented --------------------------------------------
//"Graph Files (*.bmp;*.gif;*.jpg;*.png),*.bmp;*.gif;*.jpg;*.png,Bitmap Files (*.bmp),*

//Modified by (APPEON) Harry 12.15.2017 (V161 Storage of Documents as PDFs)
docname = message.StringParm
IF isnull(docname) or docname = '' or Not FileExists(docname) THEN  
	Value = GetFileOpenName("Select File", &
		+ docname, named, "TIF", & 
		"Image Files (*.tif;*.bmp;*.jpg;*.pdf),*.tif;*.bmp;*.jpg;*.pdf," &	
		+ "TIFF Files (*.tif),*.tif," &
		+ "Bitmap Files (*.bmp),*.bmp," &
		+ "JPG Files (*.jpg),*.jpg," &
		+ "PDF Files (*.pdf),*.pdf")    //Added by Nova 03.31.2009
ELSE
	IF FileExists(docname) THEN Value = 1
END IF
	
//Modified by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
/*
//--------Begin Added by Nova 05.19.2009------------------------
IF Upper(RightA(Trim(docname),4)) = '.PDF' THEN
	IF gnv_reg_ocx.of_check_ocx(4,'',True) = '' THEN //check ImageViewer2.OCX 
		inv_image_func = Create n_cst_image_functions_cp 
		//get tif filename
		is_file_name = LeftA(docname, LastPos(docname,".") - 1)

	//Start Code Change ----07.26.2016 #V152 maha - format selection
		//is_file_name =  gs_dir_path + "IntelliCred\"+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\") -1)+'.tif'
		//is_file_name = gs_temp_path +RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\"))+'.tif' //long.zhang 10.21.2013  Bug # 3701

		//pdf2tif
		//Start Code Change ----11.08.2016 #V153 maha - added default setting
		li_format = of_get_app_setting("set_86", "I")
		
		if li_format < 3 then //choose
			openwithparm(w_convert_format, li_format )
			ls_format = message.stringparm
		else
			choose case li_format
				case 3 
					ls_format = "TC"
				case 4
					ls_format = "BW"
				case else
					ls_format = "BW"
			end choose
		end if
		//End Code Change ----11.08.2016
		
		openwithparm( w_appeon_gifofwait, "Converting PDF to TIF..." )
		choose case ls_format
			case "BW"
				is_file_name = gs_temp_path +RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\"))
				li_return =  inv_image_func.of_pdf2tifbw(docname, is_file_name ) 
				is_file_name+= ".tif"
			case "TC"
				is_file_name = gs_temp_path +RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\"))+'.tif'
				li_return = inv_image_func.of_pdf2tif( docname, is_file_name) //restored for exception by alfee 03.20.2013
		end choose
		if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	
		//li_return = inv_image_func.of_pdf2tif( docname, is_file_name)
	// End Code Change ----07.26.2016
		//destroy
		Destroy inv_image_func
		IF li_return <> 0 THEN
			docname = is_file_name
			
			//Check tif. If not exists, close Image CP Window. Added by Appeon long.zhang 09.20.2016 ( For V15.2 Testing Bug #5338: Document import of PDF file is not showing pages)
			If Not FileExists(docname) Then
				of_restore_path() 

				inv_image_func.of_close_image_cp( )
				
				Messagebox('Convert PDF','Convert PDF to TIF failed.~r~nPlease try again.')
				CloseWithReturn( This, "Cancel" )
				RETURN -1
			End If
			
		ELSE
			of_restore_path() //Alfee 05.11.2009	
			RETURN -1
		END IF
	ELSE
		RETURN -1
	END IF //maha app080905 additional image type
	
//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.01.2011
//$<reason> additional scan image type
ELSEIF Upper(RightA(Trim(docname),4)) <> '.TIF' THEN
	IF gnv_reg_ocx.of_check_ocx(4,'',True) = '' THEN 
		
		inv_image_func = Create n_cst_image_functions_cp 
		
		is_file_name = LeftA(docname, LastPos(docname,".") - 1)
	//	is_file_name =  gs_dir_path + "IntelliCred\"+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\") -1)+'.pdf'
		is_file_name =  gs_temp_path+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\"))+'.pdf'	//long.zhang 10.21.2013  Bug # 3701
		
		li_return = inv_image_func.of_convert2pdf( docname, is_file_name)
		
		IF li_return <> 0 THEN
			docname = is_file_name
		ELSE
			of_restore_path() 
			RETURN -1
		END IF
		
		is_file_name = LeftA(docname, LastPos(docname,".") - 1)
		//is_file_name =  gs_dir_path + "IntelliCred\"+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\") -1)+'.tif'
		is_file_name =  gs_temp_path +RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\"))+'.tif'	//long.zhang 10.21.2013  Bug # 3701
		li_return = inv_image_func.of_pdf2tif( docname, is_file_name)
		
		Destroy inv_image_func
		IF li_return <> 0 THEN
			docname = is_file_name
		ELSE
			of_restore_path() 
			RETURN -1
		END IF
		
		Destroy inv_image_func
		IF li_return <> 0 THEN
			docname = is_file_name
		ELSE
			of_restore_path() 
			RETURN -1
		END IF
	ELSE
		RETURN -1
	END IF
//------------------- APPEON END ---------------------
END IF
//--------End Added --------------------------------------------
*/


IF Upper(RightA(Trim(docname),4)) = '.TIF' THEN
	is_ext = 'TIF'
	//of_set_visible_pdf(false)  //Commented by (APPEON) Harry 12.07.2017  for BugS120103
ELSEIF Upper(RightA(Trim(docname),4)) = '.PDF'  THEN
	is_ext = 'PDF'
	of_set_visible_pdf(true)
	is_file_name =  gs_temp_path + RightA(docname,LenA(docname) - LastPos(docname,"\"))
	FileCopy(docname, is_file_name, True)
	docname = is_file_name
ELSE
	IF gnv_reg_ocx.of_check_ocx(4,'',True) = '' THEN 
		
		inv_image_func = Create n_cst_image_functions_cp 
		
		is_file_name = LeftA(docname, LastPos(docname,".") - 1)
		is_file_name =  gs_temp_path+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\"))+'.pdf'	
		
		li_return = inv_image_func.of_convert2pdf( docname, is_file_name)
		
		Destroy inv_image_func
		IF li_return <> 0 THEN
			docname = is_file_name
			is_ext = 'PDF' 
			of_set_visible_pdf(true)
		ELSE
			of_restore_path() 
			RETURN -1
		END IF
	END IF
END IF
//--------End Modified --------------------------------------------



//ChangeDirectory(gs_current_path) //Evan 12/11/2008
of_restore_path() //Restore the current path - Alfee 05.11.2009

IF Value < 1 THEN
	CloseWithReturn( This, "Cancel" )
	RETURN -1
END IF
			
st_filename.Text =  docname

IF is_ext <> 'TIF' THEN  //Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
	ole_thumb_pdf.of_set_parent(this) //Added by (APPEON) Harry 11.27.2017 (V161 Storage of Documents as PDFs)
	
	//Modified by (APPEON) Harry 12.15.2017 (V161 Storage of Documents as PDFs)
	//ole_thumb_pdf.ole_edit.Object.AddClip ( docname , '')
	yield()
	ole_thumb_pdf.ole_edit.Object.LoadMultiPage=True
	lb_rtn = ole_thumb_pdf.ole_edit.Object.AddClip ( docname , '')
	IF Not lb_rtn THEN
		CloseWithReturn(This, "*retry*" +  docname)
	END IF
	
	ole_thumb_pdf.ole_edit.Object.UnSelectAllClip()
	ole_thumb_pdf.ole_edit.Object.SelectClip(0)
	
	ole_edit_pdf.ole_edit.object.filename = docname
	ole_edit_pdf.ole_edit.object.LoadMultiPage(docname, 1)
	//ole_thumb_pdf.Event click(1, docname, 1)
	ole_edit_pdf.ole_edit.object.View=8
ELSE
	ole_thumb.Object.Image( docname )
	ole_thumb.Object.ThumbSelected(1, True)
	
	ole_edit.Object.Image( docname )
	ole_edit.Object.Page(1)
	ole_edit.Object.FitTo(3)
	ole_edit.object.display()
END IF







end event

on w_get_image.create
this.ole_thumb_pdf=create ole_thumb_pdf
this.cb_all=create cb_all
this.st_1=create st_1
this.st_filename=create st_filename
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ole_edit=create ole_edit
this.ole_thumb=create ole_thumb
this.ole_edit_pdf=create ole_edit_pdf
this.Control[]={this.ole_thumb_pdf,&
this.cb_all,&
this.st_1,&
this.st_filename,&
this.cb_2,&
this.cb_1,&
this.ole_edit,&
this.ole_thumb,&
this.ole_edit_pdf}
end on

on w_get_image.destroy
destroy(this.ole_thumb_pdf)
destroy(this.cb_all)
destroy(this.st_1)
destroy(this.st_filename)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ole_edit)
destroy(this.ole_thumb)
destroy(this.ole_edit_pdf)
end on

event close;FileDelete(is_file_name)//Added by Nova 04.01.2009
end event

type ole_thumb_pdf from u_thumb_edit_cp1 within w_get_image
event destroy ( )
boolean visible = false
integer x = 9
integer y = 88
integer width = 3589
integer height = 1204
integer taborder = 50
end type

on ole_thumb_pdf.destroy
call u_thumb_edit_cp1::destroy
end on

type cb_all from commandbutton within w_get_image
integer x = 2656
integer y = 1304
integer width = 320
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;//Start Code Change ----08.26.2016 #V152 maha
if this.text = "Select All" then
	if is_ext = 'PDF' then //Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
		ole_thumb_pdf.ole_edit.object.SelectAllClip()
	else
		ole_thumb.object.SelectAllThumbs
	end if
	this.text = "Deselect All"
else
	if is_ext = 'PDF' then //Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
		ole_thumb_pdf.ole_edit.object.UnSelectAllClip()
	else
		ole_thumb.object.DeSelectAllThumbs
	end if
	this.text = "Select All"
end if

end event

type st_1 from statictext within w_get_image
integer x = 23
integer y = 16
integer width = 3227
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Note: Multiple pages may be selected, but they must be in sequential order from the first selected.  Use Control/Click to select multiple."
boolean focusrectangle = false
end type

type st_filename from statictext within w_get_image
integer x = 14
integer y = 1312
integer width = 2313
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_get_image
integer x = 2994
integer y = 1304
integer width = 265
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Integer li_start_page
Integer li_cr
Integer li_thumb_count
Integer i
Integer li_page_cnt
Integer li_page[]
Int li_PageType, li_CompressionType, li_CompressionInfo
Int j
Long ll_rec_id,ll_image_id
Long ll_prac_id
Integer li_facility_id
Integer li_screen_id
Long ll_seq_no
Integer li_num_pages
String ls_image_file_name,ls_Rtn
Blob lb_the_image
dwitemstatus ldws_status
Integer li_delpage_cnt //Added by (APPEON) Harry 11.06.2017
Integer li_delpage[] //Added by (APPEON) Harry 11.06.2017
String ls_org_ext  //Added by (APPEON) Harry 11.06.2017
Int k  //Added by (APPEON) Harry 11.06.2017

SetPointer(Hourglass!)  //Added by (APPEON) Harry 

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
	li_thumb_count = ole_thumb_pdf.ole_edit.Object.ClipCount()
	FOR i = 0 TO li_thumb_count - 1
		IF ole_thumb_pdf.ole_edit.Object.GetSelect( i ) = False THEN
			li_delpage_cnt++
			li_delpage[ li_delpage_cnt ] = i
		END IF
	END FOR
	li_page_cnt = li_thumb_count - li_delpage_cnt
ELSE
	li_thumb_count = ole_thumb.Object.ThumbCount()
	
	FOR i = 1 TO li_thumb_count
		IF ole_thumb.Object.ThumbSelected( i ) = True THEN
			li_page_cnt++
			li_page[ li_page_cnt ] = i
		END IF
	END FOR
END IF

IF li_page_cnt = 0 THEN
	MessageBox("Nothing Selected", "You must select at least one page from the image file.  To select a page click on the thumbnail image, To select multiple pages hold down the Control key and click on each thumbnail image you want to select." )
	Return
END IF

//Start Code Change ----03.05.2013 #V12 maha
uo_image_object = gw_prac_data.tab_1.tabpage_image.uo_image
//messagebox("",uo_image_object.is_image_file_name)
//IF IsValid( w_prac_data_intelliapp ) THEN
//	uo_image_object = w_prac_data_intelliapp.tab_1.tabpage_image.uo_image
//ELSEIF IsValid(w_prac_data_sk) THEN //SK Practitioner Folder - alfee 09.07.2010
//	uo_image_object = w_prac_data_sk.tab_1.tabpage_image.uo_image	
//ELSE
//	uo_image_object = w_prac_data_1.tab_1.tabpage_image.uo_image
//END IF
//End Code Change ----03.05.2013 
	
//if storage is at the database level then do this
IF uo_image_object.ii_image_storage_type = 1 THEN
	IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.07.2017 for Storage of Documents as PDFs
		FileDelete( gs_temp_path + "temp.pdf" )
		uo_image_object.tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename=""
		//set the image file name to temp.tif
		ls_image_file_name = gs_temp_path + "temp.pdf"
		uo_image_object.is_image_file_name = ls_image_file_name
	Else
		FileDelete( gs_temp_path + "temp.tif" )
		uo_image_object.tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) 
		//set the image file name to temp.tif
		ls_image_file_name = gs_temp_path + "temp.tif"
		uo_image_object.is_image_file_name = ls_image_file_name
	END IF	
ELSE	
	ls_image_file_name = uo_image_object.is_image_file_name
END IF

//Added by (APPEON) Harry 11.07.2017 for Storage of Documents as PDFs
IF Len(ls_image_file_name ) <= 0 THEN
	ls_org_ext = is_ext
ELSE
	ls_org_ext =  Upper(RightA(Trim(ls_image_file_name),3)) 
END IF

IF ls_org_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.07.2017 for Storage of Documents as PDFs
	//uo_image_object.tab_view.tabpage_setup.ole_admin1_pdf.object.LoadMultiPage(ls_image_file_name, 1)
ELSE
	//messagebox("", ls_image_file_name )
	uo_image_object.tab_view.tabpage_setup.ole_admin1.object.Image( ls_image_file_name )
END IF

//Start Code Change ---- 06.13.2007 #V7 maha
IF uo_image_object.ii_image_storage_type = 1 THEN //in db
	li_start_page = 1
else // as files
	IF ls_org_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.07.2017 for Storage of Documents as PDFs
		//li_start_page = uo_image_object.tab_view.tabpage_setup.ole_admin1_pdf.object.GetTotalPage()
		IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  
		li_start_page = w_dm_image_cp.Dynamic of_gettotalpage( ls_image_file_name)
		Close(w_dm_image_cp)  
	ELSE
		li_start_page = uo_image_object.tab_view.tabpage_setup.ole_admin1.object.PageCount( )
	END IF
	li_start_page++
end if
//End Code Change---06.13.2007
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07/09/2007 By: Ken.Guo
//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
//If uo_image_object.tab_view.tabpage_setup.ole_admin1.object.pagecount() > 0 and uo_image_object.tab_view.tabpage_setup.ole_admin1.object.FileType <> 1 Then
If  ls_org_ext = 'TIF' and uo_image_object.tab_view.tabpage_setup.ole_admin1.object.pagecount() > 0 and uo_image_object.tab_view.tabpage_setup.ole_admin1.object.FileType <> 1 Then    //Modified by (APPEON) Harry 11.07.2017 for Storage of Documents as PDFs
	Messagebox('Image','The first image file must be in "TIF" format.')
	Return -1			
End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-15 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(st_filename.Text)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if
//---------------------------- APPEON END ----------------------------


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 07.22.2015
//<$>reason:Save As fixed tif Image (TIFF, RGB24, 	LZW, Compressed LTR, false), for Allegheny - uploading tif file causes it to turn blank when previewing case 00056018
IF ls_org_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.07.2017 for Storage of Documents as PDFs
	//j = uo_image_object.tab_view.tabpage_setup.ole_admin1_pdf.object.GetTotalPage()
ELSE
	j = uo_image_object.tab_view.tabpage_setup.ole_admin1.object.PageCount( )
END IF

IF ls_org_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.07.2017 for Storage of Documents as PDFs
	For i = li_delpage_cnt to 1 step -1
		ole_edit_pdf.ole_edit.Object.PDFEditDeletePage(ole_edit_pdf.ole_edit.Object.FileName, li_delpage[ i ])		
		if mod(i, 50) = 0 then sleep(1000)
	End for
	//FileCopy ( ole_edit_pdf.Object.FileName, ls_image_file_name , true)
	 
	if uo_image_object.ii_image_storage_type = 1 and of_get_app_setting("set_77","I") =  1  then   //Added by (APPEON) Harry 11.30.2017 (V161 Storage of Documents as PDFs)
		of_user_date_stamp(ole_edit_pdf.ole_edit.Object.FileName, True )  
	else
		IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
		//w_dm_image_cp.Dynamic of_saveas( ole_edit_pdf.ole_edit.Object.FileName, ls_image_file_name, 'pdf')
		w_dm_image_cp.Dynamic of_savebysize( ole_edit_pdf.ole_edit.Object.FileName, ls_image_file_name, 'pdf') //Modified by (APPEON) Harry 12.07.2017 for BugS120101
		Close(w_dm_image_cp)  
	end if
ELSE
	For i=1 to li_page_cnt
		ole_edit.object.page = li_page[i]
		ole_edit.object.display()
		if mod(i, 50) = 0 then sleep(1000)  //(Appeon)Stephen 09.22.2017 - saving items to the documents tab in the primary database
		
		//Add new page to ls_image_file_name
		j++
		li_PageType = ole_edit.object.PageType
		li_CompressionType =  ole_edit.object.CompressionType
		li_CompressionInfo =  ole_edit.object.CompressionInfo
	
		ole_edit.object.SavePage(ls_image_file_name,1,li_PageType,li_CompressionType,li_CompressionInfo,false,j) 				
	End for
END IF

//---------Begin Added by (Appeon)Stephen 09.22.2017 for saving items to the documents tab in the primary database--------
if li_page_cnt > 100 then
	sleep(2000)
else
	sleep(1000)
end if
//---------End Added ------------------------------------------------------

////--------Modified by Nova 05.26.2009------------------------
////uo_image_object.tab_view.tabpage_setup.ole_admin1.object.Append( st_filename.Text, li_page[1] , li_page_cnt )			 
//For i=1 to li_page_cnt
//	uo_image_object.tab_view.tabpage_setup.ole_admin1.object.Append( st_filename.Text, li_page[i] , 1 )				
//End for
////--------End Added --------------------------------------------
//------------------- APPEON END -------------------


li_cr = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetRow( )

uo_image_object.tab_view.tabpage_setup.dw_image_data.SetItem( li_cr, "tif_start_page", li_start_page )
uo_image_object.tab_view.tabpage_setup.dw_image_data.SetItem( li_cr, "num_pages", li_page_cnt )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
uo_image_object.tab_view.tabpage_setup.dw_image_data.SetItem( li_cr, "de_queue", 1 )

uo_image_object.tab_view.tabpage_setup.dw_image_data.SetItem( li_cr, "image_ext", is_ext ) //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)

//---------------------------- APPEON END ----------------------------

//uo_image_object.iw_parent_window.Event pfc_Save()//Start Code Change ---- 04.11.2007 #V7 maha removed because it caused an error


uo_image_object.tab_view.tabpage_setup.dw_image_data.accepttext()
//---------Begin Added by (Appeon)Stephen 11.04.2016 for V15.3-Image Auditing in IntelliCred--------
ldws_status = uo_image_object.tab_view.tabpage_setup.dw_image_data.getitemstatus(li_cr, 0, primary!)
if ldws_status <> newmodified! then
	uo_image_object.inv_dw.of_field_audit(uo_image_object.tab_view.tabpage_setup.dw_image_data) 
end if
//---------End Added ------------------------------------------------------

IF uo_image_object.ii_image_storage_type = 1 THEN
	     uo_image_object.tab_view.tabpage_setup.dw_image_data.Update( )
		ll_image_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "image_pk" ) // add michael 01.30.2011  modify by stephen 03.12.2011 image_id to image_pk
	     
	     ll_rec_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "rec_id" )
		ll_prac_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "prac_id" )	
		li_facility_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "facility_id" )	
		li_screen_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "screen_id" )		
		ll_seq_no = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "seq_no" )	
	
		//Start Code Change ----01.17.2014 #V14 maha	
		if  of_get_app_setting("set_77","I") =  1  then 
			of_user_date_stamp( )  //Start Code Change ----01.16.2014 #V14 maha
		end if
		//End Code Change ----01.17.2014
		
		//FileDelete( gs_dir_path + "IntelliCred\split.tif" )
		//tab_view.tabpage_browse.ole_admin.object.Image( gs_dir_path + "IntelliCred\split.tif" )

		//li_start_page = dw_image_data.GetItemNumber( i, "tif_start_page" ) 
		//li_num_pages =  dw_image_data.GetItemNumber( i, "num_pages" ) 
	
		//tab_view.tabpage_browse.ole_admin.object.Append( gs_dir_path + "IntelliCred\temp.tif", li_start_page, li_num_pages  )
	
		//---------Begin Modified by (Appeon)Stephen 09.22.2017 for saving items to the documents tab in the primary database--------
		//lb_the_image = uo_image_object.inv_image_functions.of_read_image_file( gs_temp_path + "temp.tif" )
		lb_the_image = uo_image_object.inv_image_functions.of_read_image_file( ls_image_file_name )
		//---------End Modfiied ------------------------------------------------------
	//Start Code Change ---- 02.08.2007 #V7 maha added de queue update to statement
	
	//------------------- APPEON BEGIN -------------------
    //$<change> Michael 01.30.2011
    //$<reason> V11.2-ImagingFacility

//		UPDATEBLOB pd_images
//		SET image_data = :lb_the_image
//		WHERE rec_id = :ll_rec_id and
//	   	   prac_id = :ll_prac_id and
//				facility_id = :li_facility_id and
//				seq_no = :ll_seq_no and
//				screen_id = :li_screen_id			
//		USING SQLCA;

	
  	    //Start Code Change --- michael 01-30-2011  V11.2 ImagingFacility
		UPDATEBLOB pd_images
		SET image_data = :lb_the_image
		WHERE image_pk = :ll_image_id   // modify by stephen 03.12.2011 image_id to image_pk
		USING SQLCA;
	    //End Code Change ---- michael 01-30-2011 
     //------------------- APPEON END ---------------------

		IF SQLCA.SQLNRows > 0 THEN
			COMMIT USING SQLCA ;
		ELSEIF SQLCA.SQLCODE = -1 THEN
			MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		ELSEIF SQLCA.SQLNRows = 0 THEN	
			MessageBox( "SQL Error", "No rows effected." )
		END IF
ELSE ///store as files //Start Code Change ---- 05.17.2007 #V7 maha   fix bug
	uo_image_object.tab_view.tabpage_setup.dw_image_data.Update( )
END IF

//---------Begin Added by (Appeon)Stephen 11.04.2016 for V15.3-Image Auditing in IntelliCred--------
if ldws_status = newmodified! then
	ll_image_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "image_pk" ) 
	ll_prac_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "prac_id" )	
	li_facility_id = uo_image_object.tab_view.tabpage_setup.dw_image_data.GetItemNumber( li_cr , "facility_id" )
	uo_image_object.inv_dw.of_sqlfield_audit(ll_prac_id, ll_image_id, li_facility_id, 95, '1000', string(ll_image_id) +"-"+string(ll_prac_id), '', 'I')
end if
//---------End Added ------------------------------------------------------


uo_image_object.tab_view.tabpage_browse.dw_browse.Retrieve( uo_image_object.il_prac_id, gs_user_id ) //Start Code Change ----03.11.2013 #V12 maha  - added user argument
//Start Code Change ----04.04.2012 #V12 maha - changed reset to rowsdiscard
//uo_image_object.tab_view.tabpage_setup.dw_image_data.reset()
uo_image_object.tab_view.tabpage_setup.dw_image_data.rowsdiscard( li_cr, li_cr, primary!)
//End Code Change ----04.04.2012
uo_image_object.tab_view.tabpage_setup.dw_image_list.SetFocus()
SetPointer(Arrow!)  //Added by (APPEON) Harry 
Close( Parent )
end event

type cb_1 from commandbutton within w_get_image
integer x = 3291
integer y = 1304
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;//CloseWithReturn( Parent, "Cancel" )
Close( Parent )//maha 052504
end event

type ole_edit from olecustomcontrol within w_get_image
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
integer x = 5
integer y = 1424
integer width = 3589
integer height = 1372
integer taborder = 40
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
long backcolor = 32891346
boolean focusrectangle = false
string binarykey = "w_get_image.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_thumb from olecustomcontrol within w_get_image
event click ( long thumbnumber )
event dblclick ( long thumbnumber )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event thumbdrop ( long insertbefore,  long dropcount,  integer shift )
event thumbdrag ( long dragcount,  integer shift )
event ocx_error ( integer number,  ref string description,  long scode,  string source,  string helpfile,  long helpcontext,  ref boolean canceldisplay )
event keydown ( ref integer keycode,  integer shift )
event keyup ( ref integer keycode,  integer shift )
event readystatechange ( long readystate )
integer x = 9
integer y = 88
integer width = 3589
integer height = 1204
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
long backcolor = 32891346
string binarykey = "w_get_image.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click(long thumbnumber);IF thumbnumber < 1 or isnull(thumbnumber) THEN return

ole_edit.Object.Page( thumbnumber)
ole_edit.object.Display()	


end event

event doubleclicked;cb_2.event clicked()
end event

type ole_edit_pdf from u_image_edit_cp1 within w_get_image
event destroy ( )
boolean visible = false
integer x = 5
integer y = 1424
integer width = 3589
integer height = 1372
integer taborder = 80
end type

on ole_edit_pdf.destroy
call u_image_edit_cp1::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_get_image.bin 
2900000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000054d6cb001d3755000000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000054d6cb001d37550054d6cb001d37550000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000051220000000300002373000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff000000020000b39c000000020000b39c000000030039b3ec000000030039b3ec0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500005122000023730000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000ee000100b43c00001000b43c100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000054d6cb001d3755000000003000002000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000016100000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003e1a6b8a0101c360302046eac029c002400000000054d6cb001d37550054d6cb001d37550000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000600000046000000000000000100000002000000030000000400000005fffffffe00000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106e1a6b8a0101c360302046eac029c002400000001fb8f0821101b01640008ed8413c72e2b000000300000013100000009000001000000005000000101000000580000010200000060000001030000006800000104000000700000010500000078000001060000008000000107000000880000000000000090000000030002000200000003000051220000000300001f1c00000003000000610000000300c0c0c0000000020000000100000003000000780000000b0000ffff0000000900000000000000010001030000000c0074735f00706b636f73706f720001050000000c00726f620073726564656c79740001040000000a00636162006c6f636b0700726f0b00000161000000736f747563656c6501060074000c00006874000068626d75686769650101007400090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f69730000000000000000000000000000000000000000000000000000000000000000000200020000512200001f1c0000006100c0c0c0c00100018000c0c00100808000005500000078000000000000010000ff0001010000000000000000ff00000000000001000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_get_image.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
