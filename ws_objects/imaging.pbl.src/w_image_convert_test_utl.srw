$PBExportHeader$w_image_convert_test_utl.srw
forward
global type w_image_convert_test_utl from window
end type
type rb_2 from radiobutton within w_image_convert_test_utl
end type
type rb_1 from radiobutton within w_image_convert_test_utl
end type
type cb_3 from commandbutton within w_image_convert_test_utl
end type
type uo_1 from uo_dm_image_view within w_image_convert_test_utl
end type
type sle_save from singlelineedit within w_image_convert_test_utl
end type
type cb_2 from commandbutton within w_image_convert_test_utl
end type
type cb_convert from commandbutton within w_image_convert_test_utl
end type
type cb_1 from commandbutton within w_image_convert_test_utl
end type
type st_name from statictext within w_image_convert_test_utl
end type
type st_2 from statictext within w_image_convert_test_utl
end type
type st_1 from statictext within w_image_convert_test_utl
end type
type ddlb_dpi from dropdownlistbox within w_image_convert_test_utl
end type
type ddlb_format from dropdownlistbox within w_image_convert_test_utl
end type
end forward

global type w_image_convert_test_utl from window
integer width = 3858
integer height = 2088
boolean titlebar = true
string title = "TIF to PDF Testing"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_2 rb_2
rb_1 rb_1
cb_3 cb_3
uo_1 uo_1
sle_save sle_save
cb_2 cb_2
cb_convert cb_convert
cb_1 cb_1
st_name st_name
st_2 st_2
st_1 st_1
ddlb_dpi ddlb_dpi
ddlb_format ddlb_format
end type
global w_image_convert_test_utl w_image_convert_test_utl

type variables
Boolean ib_ocr_finished
String is_ocr_text 
string is_file_name
string is_savefile

n_cst_filesrvwin32 inv_filesrv
n_cst_image_functions_cp  inv_image_func

end variables

forward prototypes
public function integer of_convert (string as_tif, string as_pdf, string as_format, integer ai_dpi)
end prototypes

public function integer of_convert (string as_tif, string as_pdf, string as_format, integer ai_dpi);Integer li_rtn
//
////Convert to TIF format
//SetPointer(Hourglass!)
//TRY
//
//li_rtn = ole_edit.Object.LoadMultiPage(as_pdf,true) //load pdf file
//
//IF li_rtn = 1 THEN 
//	//-------Begin Modified by Alfee 05.06.2010-----------------------
//	integer li_x, li_y, li_pdf_x, li_pdf_y, li_w, li_h
//	li_x = ole_edit.Object.Xdpi 
//	li_y = ole_edit.Object.Ydpi 
//	li_pdf_x = ole_edit.Object.PDFRenderDPIX	
//	li_pdf_y = ole_edit.Object.PDFRenderDPIY	
//	li_w = ole_edit.Object.FileWidth
//	li_h = ole_edit.Object.FileHeight
//	li_w = li_w * li_x / li_pdf_x
//	li_h = li_h * li_y / li_pdf_y
//	
//	IF as_format = "GS" THEN 
//		li_rtn = ole_edit.Object.ConvertTo8bppGrayScale() //Ticket #00039904 - alfee 02.18.2013	
//	elseif as_format = "TC" THEN 
//		ole_edit.Object.ConvertTo24bpp()//Added by Appeon long.zhang 12.15.2014(Mirrored Document Issue) 
//	else
//		
//	end if
//	
//	//sleep(0.5)
//
//	li_rtn = ole_edit.Object.SaveBySize(as_tif, "TIF", li_w, li_h) //save to tif file
//	//Yield()//Added by Appeon long.zhang 2.4.2015(Mirrored Document Issue) 
//	
//	//li_rtn = ole_edit.Object.Save(as_tif, "TIF") //save to tif file
//	//-------End Modified -------------------------------------------
//END IF
//
//CATCH (Throwable th1)
//	SetPointer(Arrow!)
//	RETURN -1
//END TRY
//
//SetPointer(Arrow!)
//	
RETURN li_rtn
end function

on w_image_convert_test_utl.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_3=create cb_3
this.uo_1=create uo_1
this.sle_save=create sle_save
this.cb_2=create cb_2
this.cb_convert=create cb_convert
this.cb_1=create cb_1
this.st_name=create st_name
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_dpi=create ddlb_dpi
this.ddlb_format=create ddlb_format
this.Control[]={this.rb_2,&
this.rb_1,&
this.cb_3,&
this.uo_1,&
this.sle_save,&
this.cb_2,&
this.cb_convert,&
this.cb_1,&
this.st_name,&
this.st_2,&
this.st_1,&
this.ddlb_dpi,&
this.ddlb_format}
end on

on w_image_convert_test_utl.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_3)
destroy(this.uo_1)
destroy(this.sle_save)
destroy(this.cb_2)
destroy(this.cb_convert)
destroy(this.cb_1)
destroy(this.st_name)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_dpi)
destroy(this.ddlb_format)
end on

event close;If isvalid(inv_filesrv) Then Destroy inv_filesrv

If isvalid(inv_image_func) Then Destroy inv_image_func

end event

event open;inv_filesrv = Create n_cst_filesrvwin32 
gw_popup[UpperBound(gw_popup[]) + 1] = This //Added by Appeon long.zhang 03.17.2015 (Uploading PDFs sometimes previews upside down & reversed)

String docname, named
Integer Value
Long li_return

inv_image_func = Create n_cst_image_functions_cp 

//Value = GetFileOpenName("Select File", &
//	+ docname, named, "TIF", & 
//	"Image Files (*.tif;*.bmp;*.jpg;*.pdf),*.tif;*.bmp;*.jpg;*.pdf," &	
//	+ "TIFF Files (*.tif),*.tif," &
//	+ "Bitmap Files (*.bmp),*.bmp," &
//	+ "JPG Files (*.jpg),*.jpg," &
//	+ "PDF Files (*.pdf),*.pdf")   

//IF Upper(RightA(Trim(docname),4)) = '.PDF' THEN
//	IF gnv_reg_ocx.of_check_ocx(4,'',True) = '' THEN //check ImageViewer2.OCX 
//		
//		inv_image_func = Create n_cst_image_functions_cp 
//		//get tif filename
//		is_file_name = LeftA(docname, LastPos(docname,".") - 1)
//		//is_file_name =  gs_dir_path + "IntelliCred\"+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\") -1)+'.tif'
//		is_file_name = gs_temp_path +RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\"))+'.tif' //long.zhang 10.21.2013  Bug # 3701
//		//pdf2tif
//		li_return = inv_image_func.of_pdf2tif( docname, is_file_name)
//		//destroy
//		Destroy inv_image_func
//		IF li_return <> 0 THEN
//			docname = is_file_name
//		ELSE
////			of_restore_path() //Alfee 05.11.2009	
//			RETURN -1
//		END IF
//	ELSE
//		RETURN -1
//	END IF 
//	
//END IF









end event

type rb_2 from radiobutton within w_image_convert_test_utl
integer x = 3081
integer y = 16
integer width = 672
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Solution 2 (zoom clearer)"
end type

event clicked;ddlb_dpi.text = '300'
ddlb_format.text ='True Color'
end event

type rb_1 from radiobutton within w_image_convert_test_utl
integer x = 2359
integer y = 16
integer width = 704
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Solution 1 (preview clearer)"
boolean checked = true
end type

type cb_3 from commandbutton within w_image_convert_test_utl
boolean visible = false
integer x = 3488
integer y = 96
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Convertorg"
end type

event clicked;string ls_file
string ls_format
String ls_PicName, ls_ext
integer li_return
integer li_dpi

//inv_image_func = Create n_cst_image_functions_cp 
//get tif filename
//is_file_name = LeftA(docname, LastPos(docname,".") - 1)
//is_file_name =  gs_dir_path + "IntelliCred\"+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\") -1)+'.tif'\\
//debugbreak()
ls_file = sle_save.text

if is_file_name = "" then 
	messagebox("File","select file to convert")
	return
end if

if len( ls_file) < 3 then ls_file = gs_dir_path

choose case ddlb_format.text
	case "True Color"
		ls_file+= "test convert TC"
		ls_format = "TC"
	case "GrayScale"
		ls_file+= "test convert GS"
		ls_format = "GS"
	case "Black and White"
		ls_file+= "test convert BW"
		ls_format = "BW"	
	case else
		messagebox("Format","Please select Format")
end choose

if ddlb_dpi.text = "" then
	li_dpi = 100
else
	li_dpi = integer(ddlb_dpi.text)
end if

ls_file = ls_file + string(li_dpi)   //Start Code Change ----07.28.2015 #V15 maha

//messagebox("Format",ls_format)
//ls_file+= ".tif"

//li_return = of_convert(  ls_file, is_file_name, ls_format, li_dpi)
li_return = inv_image_func.of_pdf2tif(is_file_name, ls_file ) //Modified by Appeon long.zhang 07.28.2015

//messagebox("Result",li_return)

//Destroy inv_image_func
IF li_return < 0 THEN
	messagebox("Error","File Convert failed")
else		
	//Get file names and file type
	ls_PicName = ls_file
	ls_ext = 'tif'
	
	//Display the image file
	TRY
		uo_1.of_initialize(ls_PicName, ls_ext) 
		uo_1.event ue_load_image(ls_PicName +'.' + ls_ext)
		uo_1.of_set_readonly(true)
	CATCH (Throwable th1)
		messagebox('','1')
	END TRY
end if
end event

type uo_1 from uo_dm_image_view within w_image_convert_test_utl
event destroy ( )
integer x = 27
integer y = 228
integer width = 3767
integer height = 1728
integer taborder = 80
end type

on uo_1.destroy
call uo_dm_image_view::destroy
end on

type sle_save from singlelineedit within w_image_convert_test_utl
integer x = 407
integer y = 108
integer width = 974
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "C:\intellicred\"
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_image_convert_test_utl
integer x = 32
integer y = 108
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save To"
end type

event clicked;string ls_path 

ls_path = f_browseforfolder('Please select a folder where you will be storing tif image files.' ,handle(parent))

if f_validstr(ls_path)  then 
	sle_save.text = ls_path  +"\"
end if

end event

type cb_convert from commandbutton within w_image_convert_test_utl
integer x = 3003
integer y = 104
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Convert"
end type

event clicked;string ls_file
string ls_format
String ls_PicName, ls_ext
integer li_return
integer li_dpi
Int li_method
decimal li_len

//inv_image_func = Create n_cst_image_functions_cp 
//get tif filename
//is_file_name = LeftA(docname, LastPos(docname,".") - 1)
//is_file_name =  gs_dir_path + "IntelliCred\"+RightA(is_file_name,LenA(is_file_name) - LastPos(docname,"\") -1)+'.tif'\\
//debugbreak()
ls_file = sle_save.text

if is_file_name = "" then 
	messagebox("File","select file to convert")
	return
end if

if len( ls_file) < 3 then ls_file = gs_dir_path

choose case ddlb_format.text
	case "True Color"
		ls_file+= "test convert TC"
		ls_format = "TC"
	case "GrayScale"
		ls_file+= "test convert GS"
		ls_format = "GS"
	case "Black and White"
		ls_file+= "test convert BW"
		ls_format = "BW"	
	case else
		messagebox("Format","Please select Format")
end choose

if ddlb_dpi.text = "" then
	li_dpi = 100
else
	li_dpi = integer(ddlb_dpi.text)
end if

ls_file = ls_file + string(li_dpi)   //Start Code Change ----07.28.2015 #V15 maha

//messagebox("Format",ls_format)
//ls_file+= ".tif"

//li_return = of_convert(  ls_file, is_file_name, ls_format, li_dpi)

If rb_1.checked Then 
	li_method = 1
Else
	li_method = 2
End If

li_return = inv_image_func.of_pdf2tif(is_file_name, ls_file, ls_format, li_dpi, li_method ) //add li_method by Appeon long.zhang 08.06.2015
this.setfocus()
//messagebox("Result",li_return)

//Destroy inv_image_func
IF li_return < 0 THEN
	messagebox("Error","File Convert failed")
else		
	//Get file names and file type
	ls_PicName = ls_file
	ls_ext = 'tif'
	
	//Display the image file
	TRY
		uo_1.of_initialize(ls_PicName, ls_ext) 
		uo_1.event ue_load_image(ls_PicName +'.' + ls_ext)
		uo_1.of_set_readonly(true)
	CATCH (Throwable th1)
		messagebox('','1')
	END TRY
end if

//li_len = filelength(ls_file)
////li_len = li_len/1000
//messagebox("File Size",li_len)
end event

type cb_1 from commandbutton within w_image_convert_test_utl
integer x = 32
integer y = 8
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get File"
boolean default = true
end type

event clicked;String docname, named
Integer Value

Value = GetFileOpenName("Select File", &
	+ docname, named, "PDF", & 
	"Image Files (*.pdf),*.pdf," &	
	+ "PDF Files (*.pdf),*.pdf")   
	
st_name.text = docname
is_file_name = docname

end event

type st_name from statictext within w_image_convert_test_utl
integer x = 411
integer y = 20
integer width = 1938
integer height = 72
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

type st_2 from statictext within w_image_convert_test_utl
integer x = 1472
integer y = 116
integer width = 178
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Format:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_image_convert_test_utl
integer x = 2226
integer y = 116
integer width = 178
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "DPI:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_dpi from dropdownlistbox within w_image_convert_test_utl
integer x = 2414
integer y = 108
integer width = 411
integer height = 384
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"100","150","200","250","300","400"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = '200'
end event

type ddlb_format from dropdownlistbox within w_image_convert_test_utl
integer x = 1682
integer y = 108
integer width = 494
integer height = 324
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Black and White","GrayScale","True Color"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = 'True Color'
end event

