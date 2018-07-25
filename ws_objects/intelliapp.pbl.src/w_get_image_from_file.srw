$PBExportHeader$w_get_image_from_file.srw
forward
global type w_get_image_from_file from window
end type
type ole_edit_pdf from u_image_edit_cp1 within w_get_image_from_file
end type
type cb_all from commandbutton within w_get_image_from_file
end type
type ole_edit from olecustomcontrol within w_get_image_from_file
end type
type ole_admin from olecustomcontrol within w_get_image_from_file
end type
type st_1 from statictext within w_get_image_from_file
end type
type st_filename from statictext within w_get_image_from_file
end type
type cb_2 from commandbutton within w_get_image_from_file
end type
type cb_1 from commandbutton within w_get_image_from_file
end type
type ole_thumb from olecustomcontrol within w_get_image_from_file
end type
type ole_thumb_pdf from u_thumb_edit_cp1 within w_get_image_from_file
end type
end forward

global type w_get_image_from_file from window
integer x = 27
integer y = 64
integer width = 3602
integer height = 2568
boolean titlebar = true
string title = "Select Image File"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
ole_edit_pdf ole_edit_pdf
cb_all cb_all
ole_edit ole_edit
ole_admin ole_admin
st_1 st_1
st_filename st_filename
cb_2 cb_2
cb_1 cb_1
ole_thumb ole_thumb
ole_thumb_pdf ole_thumb_pdf
end type
global w_get_image_from_file w_get_image_from_file

type variables
String is_image_file_name
string is_app_path

String is_ext = 'TIF' //Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
end variables

forward prototypes
public subroutine of_set_visible_pdf (boolean ab_visible)
public subroutine of_thumb_click (long al_pageno)
end prototypes

public subroutine of_set_visible_pdf (boolean ab_visible);//Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
ole_edit.visible =  not ab_visible
ole_thumb.visible = not ab_visible
ole_edit_pdf.visible = ab_visible
ole_thumb_pdf.visible = ab_visible

end subroutine

public subroutine of_thumb_click (long al_pageno);//Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
ole_edit_pdf.ole_edit.Object.LoadMultiPage( ole_edit_pdf.ole_edit.Object.filename, al_pageno)
end subroutine

event open;String docname, named
String ls_file_name
String ls_format//Added by Appeon long.zhang 11.09.2016 
Integer Value
Integer li_return
Int li_format //Added by Appeon long.zhang 11.09.2016 
n_cst_image_functions_cp  lnv_image_func
Boolean lb_from_application = False
Boolean lb_rtn
Int li_count

is_app_path = Message.StringParm

//Application Mapping-Append Pages do not use format selection, Added by Appeon long.zhang 11.09.2016 (for Bug ID #5397 for Case # 00067601: IS issue 110716)
if posA(is_app_path,"*") > 0 then //From document
	is_app_path=MidA(is_app_path,2)
	lb_from_application = False
Else //From Application Mapping
	lb_from_application = True
End If
		
//--------------------------APPEON BEGIN--------------------------
//<$>Modified by long.zhang 04.06.2012
//<$>Reason:add pdf file type

//Value = GetFileOpenName("Select File", &
//	+ docname, named, "TIF", &
//	+ "Tif Files (*.Tif),*.Tif," &
//	+ "Bmp Files (*.Bmp),*.Bmp," &
//	+ "jpg Files (*.jpg),*.jpg") //maha app080905 additional image type

Value = GetFileOpenName("Select File", &
	+ docname, named, "TIF", &
	+ "Tif Files (*.Tif),*.Tif," &
	+ "Bmp Files (*.Bmp),*.Bmp," &
	+ "jpg Files (*.jpg),*.jpg," &
	+ "PDF Files (*.pdf),*.pdf") //maha app080905 additional image type
	
IF lb_from_application THEN	//Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)

	IF Upper(RightA(Trim(docname),4)) = '.PDF' THEN	//Copied From w_get_image.open()
		IF gnv_reg_ocx.of_check_ocx(4,'',True) = '' THEN
				lnv_image_func = Create n_cst_image_functions_cp 
				is_image_file_name = LeftA(docname, LastPos(docname,".") - 1)
				is_image_file_name =  gs_temp_path +RightA(is_image_file_name,LenA(is_image_file_name) - LastPos(docname,"\") -1)+'.tif'
				
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 11.09.2016
				//<$>reason:format selection, Copy the same logic from w_get_image, for Bug ID #5397 for Case # 00067601: IS issue 110716  
				//li_return = lnv_image_func.of_pdf2tif( docname, is_image_file_name)
				li_format = of_get_app_setting("set_86", "I")
				
				if li_format < 3 or lb_from_application then //choose  
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
		
				openwithparm( w_appeon_gifofwait, "Converting PDF to TIF..." )
				choose case ls_format
					case "BW"
						li_return =  lnv_image_func.of_pdf2tifbw(docname, is_image_file_name ) 
					case "TC"
						li_return =  lnv_image_func.of_pdf2tif(docname, is_image_file_name )
				end choose
				if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	
				Destroy lnv_image_func
				IF li_return <> 0 THEN
					docname = is_image_file_name
				ELSE
					MessageBox("Prompt","Convert pdf file to tif file failed")
					ChangeDirectory(gs_current_path)
					CloseWithReturn( This, "Cancel" )
					RETURN -1
				END IF
				//------------------- APPEON END -------------------
		ELSE
			CloseWithReturn( This, "Cancel" )
			RETURN -1
		END IF //maha app080905 additional image type
	
	END IF
	is_ext = 'TIF'  //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)

ELSE //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)

	IF Upper(RightA(Trim(docname),4)) = '.TIF' THEN
		is_ext = 'TIF'
		of_set_visible_pdf(false)
	ELSEIF Upper(RightA(Trim(docname),4)) = '.PDF'  THEN
		is_ext = 'PDF'
		of_set_visible_pdf(true)
		is_image_file_name =  gs_temp_path + RightA(docname,LenA(docname) - LastPos(docname,"\"))
		FileCopy(docname, is_image_file_name, True)
		docname = is_image_file_name
	ELSE
		IF gnv_reg_ocx.of_check_ocx(4,'',True) = '' THEN 
			
			IF Not IsValid(lnv_image_func) then lnv_image_func = Create n_cst_image_functions_cp 
			
			is_image_file_name = LeftA(docname, LastPos(docname,".") - 1)
			is_image_file_name =  gs_temp_path+RightA(is_image_file_name,LenA(is_image_file_name) - LastPos(docname,"\"))+'.pdf'	
			
			li_return = lnv_image_func.of_convert2pdf( docname, is_image_file_name)
			
			Destroy lnv_image_func
			IF li_return <> 0 THEN
				docname = is_image_file_name
				is_ext = 'PDF' 
				of_set_visible_pdf(true)
			ELSE
				ChangeDirectory(gs_current_path)
				CloseWithReturn( This, "Cancel" )
				RETURN -1
			END IF
		END IF
	END IF
END IF
	
//---------------------------APPEON END---------------------------
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF IsValid(w_append_pages) THEN w_append_pages.rb_fromfile.Checked = True

IF Value < 1 THEN
	CloseWithReturn( This, "Cancel" )
	RETURN -1
END IF

st_filename.Text = docname

IF is_ext <> 'TIF' THEN  //Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
	ole_thumb_pdf.of_set_parent(this) //Added by (APPEON) Harry 11.27.2017 (V161 Storage of Documents as PDFs)
	
	//Modified by (APPEON) Harry 12.11.2017 (V161 Storage of Documents as PDFs)
	//ole_thumb_pdf.ole_edit.Object.AddClip ( docname , '')
	yield()
	ole_thumb_pdf.ole_edit.Object.LoadMultiPage=True
	lb_rtn = ole_thumb_pdf.ole_edit.Object.AddClip ( docname , '')
	do while not lb_rtn 
		yield()
		//ole_thumb_pdf.ole_edit.Object.AddClip ( '' , '')
		lb_rtn = ole_thumb_pdf.ole_edit.Object.AddClip ( docname , '')
		if li_count > 5 then Exit
		li_count ++
	loop
	ole_thumb_pdf.ole_edit.Object.UnSelectAllClip()
	ole_thumb_pdf.ole_edit.Object.SelectClip(0)
	
	ole_edit_pdf.ole_edit.object.filename = docname
	ole_edit_pdf.ole_edit.object.LoadMultiPage(docname, 1)
	//ole_thumb_pdf.Event click(1, docname, 1)
	ole_edit_pdf.ole_edit.object.View=8
ELSE
	ole_thumb.Object.Image( docname )
	
	ole_thumb.Object.ThumbSelected(1, True)
	
	//--------------APPEON BEGIN--------------
	//<$>added long.zhang 04.06.2012
	//<Reason>: preview image
	ole_edit.Object.Image( docname )
	ole_edit.Object.Page(1)
	ole_edit.Object.FitTo(3)
	ole_edit.object.display()
	//---------------APPEON END-----------------
END IF


end event

on w_get_image_from_file.create
this.ole_edit_pdf=create ole_edit_pdf
this.cb_all=create cb_all
this.ole_edit=create ole_edit
this.ole_admin=create ole_admin
this.st_1=create st_1
this.st_filename=create st_filename
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ole_thumb=create ole_thumb
this.ole_thumb_pdf=create ole_thumb_pdf
this.Control[]={this.ole_edit_pdf,&
this.cb_all,&
this.ole_edit,&
this.ole_admin,&
this.st_1,&
this.st_filename,&
this.cb_2,&
this.cb_1,&
this.ole_thumb,&
this.ole_thumb_pdf}
end on

on w_get_image_from_file.destroy
destroy(this.ole_edit_pdf)
destroy(this.cb_all)
destroy(this.ole_edit)
destroy(this.ole_admin)
destroy(this.st_1)
destroy(this.st_filename)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ole_thumb)
destroy(this.ole_thumb_pdf)
end on

event close;if FIleExists(is_image_file_name) then FileDelete(is_image_file_name)	//added by long.zhang 04.06.2012
end event

type ole_edit_pdf from u_image_edit_cp1 within w_get_image_from_file
boolean visible = false
integer x = 37
integer y = 1164
integer width = 3520
integer height = 1216
integer taborder = 50
end type

on ole_edit_pdf.destroy
call u_image_edit_cp1::destroy
end on

type cb_all from commandbutton within w_get_image_from_file
integer x = 2647
integer y = 1020
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
	if is_ext = 'PDF' then //Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
		ole_thumb_pdf.ole_edit.object.SelectAllClip()
	else
		ole_thumb.object.SelectAllThumbs
	end if	
	this.text = "Deselect All"
else
	if is_ext = 'PDF' then //Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
		ole_thumb_pdf.ole_edit.object.UnSelectAllClip()
	else
		ole_thumb.object.DeSelectAllThumbs
	end if	
	this.text = "Select All"
end if


end event

type ole_edit from olecustomcontrol within w_get_image_from_file
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
integer x = 37
integer y = 1164
integer width = 3520
integer height = 1216
integer taborder = 40
borderstyle borderstyle = stylelowered!
long backcolor = 32891346
boolean focusrectangle = false
string binarykey = "w_get_image_from_file.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within w_get_image_from_file
event filepropertiesclose ( )
integer x = 2437
integer y = 1004
integer width = 155
integer height = 136
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_get_image_from_file.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type st_1 from statictext within w_get_image_from_file
integer x = 23
integer y = 16
integer width = 3040
integer height = 52
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

type st_filename from statictext within w_get_image_from_file
integer x = 23
integer y = 1024
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
string text = "none"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_get_image_from_file
integer x = 2994
integer y = 1020
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
Integer j
Integer li_PageType, li_CompressionType, li_CompressionInfo
Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
Integer li_screen_id
Long ll_seq_no
Integer li_num_pages
String ls_image_file_name,ls_Rtn
Blob lb_the_image
Integer li_delpage_cnt //Added by (APPEON) Harry 11.28.2017
Integer li_delpage[] //Added by (APPEON) Harry 11.28.2017
Int k  //Added by (APPEON) Harry 11.28.2017

SetPointer(Hourglass!)  //Added by (APPEON) Harry 11.28.2017 

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
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
	
	FOR i = 1 To li_thumb_count
		IF ole_thumb.Object.ThumbSelected( i ) = True THEN
			li_page_cnt++
			li_page[ li_page_cnt ] = i
		END IF
	END FOR
END IF

IF li_page_cnt = 0 THEN
	MessageBox("Nothing Selected", "You must select at least one page from the image file.  To select a page click on the thumbnail image, To select multiple pages hold down the Control key and click on each thumbnail image you want to select." )
	RETURN
END IF

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
	FileDelete( is_app_path + "temp.pdf" )
	
	ls_image_file_name = is_app_path + "temp.pdf"
ELSE
	FileDelete( is_app_path + "temp.tif" )
	
	ls_image_file_name = is_app_path + "temp.tif"
	ole_admin.Object.Image( ls_image_file_name )
	IF ole_admin.Object.PageCount() > 0 And ole_admin.Object.FileType <> 1 THEN
		MessageBox('Image','The first image file must be in "TIF" format.')
		RETURN -1
	END IF
END IF

ls_Rtn = f_ExaWriteRight(st_filename.Text)
IF LenA(ls_Rtn) > 0 THEN
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	RETURN -1
END IF

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 07.22.2015
//<$>reason:Save As fixed tif Image (TIFF, RGB24, 	LZW, Compressed LTR, false), for Allegheny - uploading tif file causes it to turn blank when previewing case 00056018

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
ELSE
	j = ole_admin.object.PageCount()
END IF

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.28.2017 for Storage of Documents as PDFs
	For i = li_delpage_cnt to 1 step -1
		ole_edit_pdf.ole_edit.Object.PDFEditDeletePage(ole_edit_pdf.ole_edit.Object.FileName, li_delpage[ i ])		
	End for

	IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  
	w_dm_image_cp.Dynamic of_saveas( ole_edit_pdf.ole_edit.Object.FileName, ls_image_file_name, 'pdf')
	Close(w_dm_image_cp)  	
ELSE

	For i=1 to li_page_cnt
		ole_edit.object.page = li_page[i]
		ole_edit.object.display()
		
		//Add new page to ls_image_file_name
		j++
		li_PageType = ole_edit.object.PageType
		li_CompressionType =  ole_edit.object.CompressionType
		li_CompressionInfo =  ole_edit.object.CompressionInfo
	
		ole_edit.object.SavePage(ls_image_file_name,1,li_PageType,li_CompressionType,li_CompressionInfo,false,j) 				
	End for
END IF
//FOR i = 1 To li_page_cnt
//	ole_admin.Object.Append( st_filename.Text, li_page[i] , 1 )
//END FOR
//------------------- APPEON END -------------------

IF IsValid(w_append_pages) THEN
	w_append_pages.il_page_count = li_page_cnt
END IF

//Close( Parent)
CloseWithReturn( Parent, is_ext ) //Modified by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)


	
	

end event

type cb_1 from commandbutton within w_get_image_from_file
integer x = 3291
integer y = 1020
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

event clicked;CloseWithReturn( Parent, "Cancel" )
//Close( Parent )//maha 052504
end event

type ole_thumb from olecustomcontrol within w_get_image_from_file
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
integer x = 37
integer y = 96
integer width = 3520
integer height = 904
integer taborder = 10
borderstyle borderstyle = stylelowered!
string binarykey = "w_get_image_from_file.win"
integer binaryindex = 2
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click(long thumbnumber);//----------------appeon begin---------------------
//<$>added:long.zhang 04.06.2012
//<$>Reason:preview image
IF thumbnumber < 1 or isnull(thumbnumber) THEN return

ole_edit.Object.Page( thumbnumber)
ole_edit.object.Display()	
//----------------appeon end-----------------------
end event

event doubleclicked;cb_2.event clicked()
end event

type ole_thumb_pdf from u_thumb_edit_cp1 within w_get_image_from_file
boolean visible = false
integer x = 37
integer y = 96
integer width = 3520
integer height = 904
integer taborder = 20
boolean bringtotop = true
end type

on ole_thumb_pdf.destroy
call u_thumb_edit_cp1::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_get_image_from_file.bin 
2A00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000dd7c2f1001d3725b00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000dd7c2f1001d3725bdd7c2f1001d3725b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc00000003000200050000000300004f950000000300001f6b000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff000000020000b634000000020000b634000000030015b684000000030015b6840000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500004f9500001f6b0000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000ee000100b6d400001000b6d4100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000dd7c2f1001d3725b00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000dd7c2f1001d3725bdd7c2f1001d3725b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000003840000038400000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Efffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000dd7c7d3001d3725b00000003000002000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000016100000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003e1a6b8a0101c360302046eac029c002400000000dd7c2f1001d3725bdd7c7d3001d3725b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000600000046000000000000000100000002000000030000000400000005fffffffe00000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106e1a6b8a0101c360302046eac029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000001310000000900000100000000500000010100000058000001020000006000000103000000680000010400000070000001050000007800000106000000800000010700000088000000000000009000000003000200020000000300004f95000000030000175c00000003000000610000000300c0c0c0000000020000000100000003000000780000000b0000ffff0000000900000000000000010001030000000c0074735f00706b636f73706f720001050000000c00726f620073726564656c79740001040000000a00636162006c6f636b0700726f0b00000161000000736f747563656c6501060074000c000068740000
2068626d75686769650101007400090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f697300000000000000000000000000000000000000000000000000000000000000000002000200004f950000175c0000006100c0c0c0c00100018000c0c00100808000005500000078000000000000010000ff0001010000000000000000ff00000000000001000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_get_image_from_file.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
