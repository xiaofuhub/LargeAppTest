$PBExportHeader$uo_dm_image_toolbar.sru
$PBExportComments$Toolbar buttons for uo_dm_image_view
forward
global type uo_dm_image_toolbar from userobject
end type
type st_status from statictext within uo_dm_image_toolbar
end type
type pb_ocr from picturebutton within uo_dm_image_toolbar
end type
type st_find from statictext within uo_dm_image_toolbar
end type
type cb_find from commandbutton within uo_dm_image_toolbar
end type
type sle_find from singlelineedit within uo_dm_image_toolbar
end type
type pb_paste from picturebutton within uo_dm_image_toolbar
end type
type pb_copy from picturebutton within uo_dm_image_toolbar
end type
type pb_pdf from picturebutton within uo_dm_image_toolbar
end type
type cb_last from commandbutton within uo_dm_image_toolbar
end type
type cb_next from commandbutton within uo_dm_image_toolbar
end type
type em_page from editmask within uo_dm_image_toolbar
end type
type cb_prior from commandbutton within uo_dm_image_toolbar
end type
type cb_first from commandbutton within uo_dm_image_toolbar
end type
type st_pages from statictext within uo_dm_image_toolbar
end type
type ddlb_zoom from dropdownlistbox within uo_dm_image_toolbar
end type
type pb_fitheight from picturebutton within uo_dm_image_toolbar
end type
type pb_fitwidth from picturebutton within uo_dm_image_toolbar
end type
type pb_bestfit from picturebutton within uo_dm_image_toolbar
end type
type pb_zoomselection from picturebutton within uo_dm_image_toolbar
end type
type p_magnifier from picture within uo_dm_image_toolbar
end type
type pb_zoomout from picturebutton within uo_dm_image_toolbar
end type
type pb_zoomin from picturebutton within uo_dm_image_toolbar
end type
type pb_imagetools from picturebutton within uo_dm_image_toolbar
end type
type p_select from picture within uo_dm_image_toolbar
end type
type p_drag from picture within uo_dm_image_toolbar
end type
type p_view_thumbpage from picture within uo_dm_image_toolbar
end type
type p_view_thumb from picture within uo_dm_image_toolbar
end type
type p_view_page from picture within uo_dm_image_toolbar
end type
end forward

global type uo_dm_image_toolbar from userobject
integer width = 5275
integer height = 124
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_set_viewstyle ( string as_viewstyle )
event ue_zoom ( string as_action )
event ue_show_magnifier ( )
event ue_show_toolmenu ( )
event ue_set_mousetype ( string as_mousetype )
event ue_scroll ( string as_scrolltype )
event ue_page_modified ( )
event ue_selection_enabled ( boolean ab_enabled )
event ue_saveas_pdf ( )
event ue_copy_page ( )
event ue_paste ( )
event ue_ocr_find ( string as_find_text )
event ue_ocr ( )
st_status st_status
pb_ocr pb_ocr
st_find st_find
cb_find cb_find
sle_find sle_find
pb_paste pb_paste
pb_copy pb_copy
pb_pdf pb_pdf
cb_last cb_last
cb_next cb_next
em_page em_page
cb_prior cb_prior
cb_first cb_first
st_pages st_pages
ddlb_zoom ddlb_zoom
pb_fitheight pb_fitheight
pb_fitwidth pb_fitwidth
pb_bestfit pb_bestfit
pb_zoomselection pb_zoomselection
p_magnifier p_magnifier
pb_zoomout pb_zoomout
pb_zoomin pb_zoomin
pb_imagetools pb_imagetools
p_select p_select
p_drag p_drag
p_view_thumbpage p_view_thumbpage
p_view_thumb p_view_thumb
p_view_page p_view_page
end type
global uo_dm_image_toolbar uo_dm_image_toolbar

type variables

end variables

forward prototypes
public subroutine of_set_found_result (integer ai_page)
public subroutine of_set_find_text (string as_text)
public subroutine of_set_find_enable (boolean ab_value)
public subroutine of_set_readonly_toolbar (boolean ab_value)
public subroutine of_set_ocr_button (integer ai_value)
public subroutine of_set_pdf_enable (boolean ab_value)
public subroutine of_set_saveas_enable (boolean ab_value)
public subroutine of_set_status (string as_text)
public subroutine of_set_paste_enable (boolean ab_value)
public subroutine of_set_find_status (string as_value)
end prototypes

event ue_selection_enabled(boolean ab_enabled);pb_zoomselection.enabled = ab_enabled

IF ab_enabled THEN
	pb_zoomselection.picturename = 'zoom_select.bmp'
ELSE
	pb_zoomselection.picturename = 'zoom_select_disable.bmp'
END IF
end event

event ue_ocr();Return
end event

public subroutine of_set_found_result (integer ai_page);If ai_page = 0 Then
	st_find.text = ''
	sle_find.text = ''
ElseIf ai_page = -1 Then
	st_find.text = 'Found'
ElseIf ai_page = -2 Then
	st_find.text = 'Not Found'
Else
	st_find.text = 'Found in Page ' + String(ai_page) 
End If
end subroutine

public subroutine of_set_find_text (string as_text);sle_find.text = as_text
end subroutine

public subroutine of_set_find_enable (boolean ab_value);sle_find.visible = ab_value
cb_find.visible = ab_value
st_find.visible = ab_value
pb_ocr.visible = ab_value
pb_pdf.visible = ab_value


end subroutine

public subroutine of_set_readonly_toolbar (boolean ab_value);pb_paste.Visible = Not ab_value
pb_ocr.Visible = Not ab_value
pb_pdf.Visible = Not ab_value

If Not ab_value Then
	pb_copy.visible = True
End If
end subroutine

public subroutine of_set_ocr_button (integer ai_value);Choose Case ai_value
	Case 0
		pb_ocr.picturename = 'ocr_empty.bmp'		
	Case 1
		pb_ocr.picturename = 'ocr.bmp'
End Choose

end subroutine

public subroutine of_set_pdf_enable (boolean ab_value);pb_pdf.visible = ab_value
end subroutine

public subroutine of_set_saveas_enable (boolean ab_value);pb_ocr.visible = ab_value
pb_copy.visible = ab_value

end subroutine

public subroutine of_set_status (string as_text);st_status.text = as_text

end subroutine

public subroutine of_set_paste_enable (boolean ab_value);pb_paste.visible = ab_value
end subroutine

public subroutine of_set_find_status (string as_value);st_find.text = as_value
end subroutine

on uo_dm_image_toolbar.create
this.st_status=create st_status
this.pb_ocr=create pb_ocr
this.st_find=create st_find
this.cb_find=create cb_find
this.sle_find=create sle_find
this.pb_paste=create pb_paste
this.pb_copy=create pb_copy
this.pb_pdf=create pb_pdf
this.cb_last=create cb_last
this.cb_next=create cb_next
this.em_page=create em_page
this.cb_prior=create cb_prior
this.cb_first=create cb_first
this.st_pages=create st_pages
this.ddlb_zoom=create ddlb_zoom
this.pb_fitheight=create pb_fitheight
this.pb_fitwidth=create pb_fitwidth
this.pb_bestfit=create pb_bestfit
this.pb_zoomselection=create pb_zoomselection
this.p_magnifier=create p_magnifier
this.pb_zoomout=create pb_zoomout
this.pb_zoomin=create pb_zoomin
this.pb_imagetools=create pb_imagetools
this.p_select=create p_select
this.p_drag=create p_drag
this.p_view_thumbpage=create p_view_thumbpage
this.p_view_thumb=create p_view_thumb
this.p_view_page=create p_view_page
this.Control[]={this.st_status,&
this.pb_ocr,&
this.st_find,&
this.cb_find,&
this.sle_find,&
this.pb_paste,&
this.pb_copy,&
this.pb_pdf,&
this.cb_last,&
this.cb_next,&
this.em_page,&
this.cb_prior,&
this.cb_first,&
this.st_pages,&
this.ddlb_zoom,&
this.pb_fitheight,&
this.pb_fitwidth,&
this.pb_bestfit,&
this.pb_zoomselection,&
this.p_magnifier,&
this.pb_zoomout,&
this.pb_zoomin,&
this.pb_imagetools,&
this.p_select,&
this.p_drag,&
this.p_view_thumbpage,&
this.p_view_thumb,&
this.p_view_page}
end on

on uo_dm_image_toolbar.destroy
destroy(this.st_status)
destroy(this.pb_ocr)
destroy(this.st_find)
destroy(this.cb_find)
destroy(this.sle_find)
destroy(this.pb_paste)
destroy(this.pb_copy)
destroy(this.pb_pdf)
destroy(this.cb_last)
destroy(this.cb_next)
destroy(this.em_page)
destroy(this.cb_prior)
destroy(this.cb_first)
destroy(this.st_pages)
destroy(this.ddlb_zoom)
destroy(this.pb_fitheight)
destroy(this.pb_fitwidth)
destroy(this.pb_bestfit)
destroy(this.pb_zoomselection)
destroy(this.p_magnifier)
destroy(this.pb_zoomout)
destroy(this.pb_zoomin)
destroy(this.pb_imagetools)
destroy(this.p_select)
destroy(this.p_drag)
destroy(this.p_view_thumbpage)
destroy(this.p_view_thumb)
destroy(this.p_view_page)
end on

event constructor;//Set toolbars for different image OCXs - Alfee 05.19.2008
Integer li_width 

IF gi_imageocx = 2 THEN //New image OCX
	pb_zoomselection.Visible = FALSE
	p_magnifier.Visible = FALSE	
	
	li_width	= pb_zoomselection.width
	pb_bestfit.x = pb_bestfit.x - li_width * 2
	pb_fitwidth.x = pb_fitwidth.x - li_width * 2
	pb_fitheight.x = pb_fitheight.x - li_width * 2
	ddlb_zoom.x = ddlb_zoom.x  - li_width * 2
END IF
sle_find.setfocus()
end event

type st_status from statictext within uo_dm_image_toolbar
integer x = 4622
integer y = 24
integer width = 1102
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type pb_ocr from picturebutton within uo_dm_image_toolbar
string tag = "OCR the Document"
integer x = 2107
integer y = 4
integer width = 110
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "ocr_empty.bmp"
alignment htextalign = left!
string powertiptext = "OCR the Document"
end type

event clicked;Parent.Setfocus()
If This.PictureName = 'ocr.bmp' Then
	If Messagebox('OCR',"This document has been OCR'd, do you want to re-OCR?",Question!,YesNo!)  = 2 Then Return 
End If
Parent.event ue_ocr()
end event

type st_find from statictext within uo_dm_image_toolbar
integer x = 1390
integer y = 24
integer width = 718
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_find from commandbutton within uo_dm_image_toolbar
integer x = 1198
integer y = 4
integer width = 183
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;If sle_find.text = '' Then Return
Parent.event ue_ocr_find(sle_find.text)
sle_find.Post SetFocus()
end event

type sle_find from singlelineedit within uo_dm_image_toolbar
event ue_change pbm_enchange
event ue_keydown pbm_keydown
integer x = 777
integer y = 4
integer width = 421
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_change;st_find.text = ''
end event

event ue_keydown;If Key = KeyEnter! Then
	cb_find.event clicked( )
End If
end event

type pb_paste from picturebutton within uo_dm_image_toolbar
string tag = "Paste"
integer x = 2437
integer y = 4
integer width = 110
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "paste.bmp"
alignment htextalign = left!
string powertiptext = "Paste"
end type

event clicked;Parent.Setfocus()
parent.event ue_paste()
end event

type pb_copy from picturebutton within uo_dm_image_toolbar
string tag = "Copy Page"
integer x = 2322
integer y = 4
integer width = 110
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "copy.bmp"
alignment htextalign = left!
string powertiptext = "Copy Page"
end type

event clicked;Parent.Setfocus()
parent.event ue_copy_page()
end event

type pb_pdf from picturebutton within uo_dm_image_toolbar
string tag = "Save/Convert to PDF"
integer x = 2213
integer y = 4
integer width = 110
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "pdf.bmp"
alignment htextalign = left!
string powertiptext = "Save/Convert to PDF"
end type

event clicked;Parent.Setfocus()
Parent.event ue_saveas_pdf()
end event

type cb_last from commandbutton within uo_dm_image_toolbar
integer x = 4498
integer y = 4
integer width = 101
integer height = 88
integer taborder = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">|"
end type

event clicked;Parent.Setfocus()
parent.event ue_scroll ( 'last')
end event

type cb_next from commandbutton within uo_dm_image_toolbar
integer x = 4402
integer y = 4
integer width = 101
integer height = 88
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">"
end type

event clicked;Parent.Setfocus()
parent.event ue_scroll( 'next')
end event

type em_page from editmask within uo_dm_image_toolbar
integer x = 4251
integer y = 8
integer width = 137
integer height = 80
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

event modified;//
//integer li_page
//
//li_page = integer(this.text)
//IF li_page <= iuo_parent.ii_page_count and li_page>0 THEN
//	iuo_parent.dynamic function of_scroll( string(li_page))
//ELSE
//	iuo_parent.post dynamic function  of_set_pagetext(string(iuo_parent.ii_page))
//END IF
//	

parent.event ue_page_modified()
end event

type cb_prior from commandbutton within uo_dm_image_toolbar
integer x = 4137
integer y = 4
integer width = 101
integer height = 88
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<"
end type

event clicked;Parent.Setfocus()
parent.event ue_scroll( 'prior')
end event

type cb_first from commandbutton within uo_dm_image_toolbar
string tag = "first"
integer x = 4041
integer y = 4
integer width = 101
integer height = 88
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "|<"
end type

event clicked;Parent.Setfocus()
parent.event ue_scroll( 'first')
end event

type st_pages from statictext within uo_dm_image_toolbar
integer x = 3456
integer y = 24
integer width = 535
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Page 0 of 2"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_zoom from dropdownlistbox within uo_dm_image_toolbar
integer x = 3328
integer y = 4
integer width = 311
integer height = 804
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "100%"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"25%","50%","75%","100%","150%","200%","400%","800%"}
borderstyle borderstyle = stylelowered!
end type

event modified;this.event selectionchanged(-1)
end event

event selectionchanged;parent.event ue_zoom( this.text)
end event

type pb_fitheight from picturebutton within uo_dm_image_toolbar
string tag = "Fit to Height"
integer x = 3209
integer y = 4
integer width = 110
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoom_height.bmp"
alignment htextalign = left!
string powertiptext = "Fit to Height"
end type

event clicked;Parent.Setfocus()
parent.event ue_zoom( this.tag)
end event

type pb_fitwidth from picturebutton within uo_dm_image_toolbar
string tag = "Fit to Width"
integer x = 3099
integer y = 4
integer width = 110
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoom_width.bmp"
alignment htextalign = left!
string powertiptext = "Fit to Width"
end type

event clicked;Parent.Setfocus()
parent.event ue_zoom( this.tag)
end event

type pb_bestfit from picturebutton within uo_dm_image_toolbar
string tag = "Best Fit"
integer x = 2990
integer y = 4
integer width = 110
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoom_bestfit.bmp"
string disabledname = "zoomout_disabled.bmp"
alignment htextalign = left!
string powertiptext = "Best Fit"
end type

event clicked;Parent.Setfocus()
parent.event ue_zoom( this.tag)
end event

type pb_zoomselection from picturebutton within uo_dm_image_toolbar
integer x = 2880
integer y = 4
integer width = 110
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoom_select.bmp"
string disabledname = "zoom_select_disable.bmp"
alignment htextalign = left!
string powertiptext = "Zoom to Selection"
end type

event clicked;Parent.Setfocus()
parent.event ue_zoom('selection')
end event

type p_magnifier from picture within uo_dm_image_toolbar
integer x = 2770
integer y = 4
integer width = 110
integer height = 92
integer taborder = 80
string picturename = "zoom_magnifier.bmp"
boolean focusrectangle = false
string powertiptext = "Magnifier"
end type

event clicked;Parent.Setfocus()
parent.event ue_show_magnifier()
end event

type pb_zoomout from picturebutton within uo_dm_image_toolbar
integer x = 2661
integer y = 4
integer width = 110
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoomout.bmp"
string disabledname = "zoomout_disabled.bmp"
alignment htextalign = left!
string powertiptext = "Zoom Out"
end type

event clicked;Parent.Setfocus()
parent.event ue_zoom('-')
end event

type pb_zoomin from picturebutton within uo_dm_image_toolbar
integer x = 2551
integer y = 4
integer width = 110
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoomin.bmp"
string disabledname = "zoomin_disabled.bmp"
alignment htextalign = left!
string powertiptext = "Zoom In"
end type

event clicked;Parent.Setfocus()
parent.event ue_zoom('+')
end event

type pb_imagetools from picturebutton within uo_dm_image_toolbar
integer x = 581
integer y = 4
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Menu!"
string disabledname = "zoomin_disabled.bmp"
alignment htextalign = left!
string powertiptext = "Image Tools"
end type

event clicked;Parent.Setfocus()
parent.event ue_show_toolmenu()
end event

type p_select from picture within uo_dm_image_toolbar
string tag = "SelectAnnoAndZones"
integer x = 466
integer y = 4
integer width = 110
integer height = 92
string picturename = "image_arrow_down.bmp"
boolean focusrectangle = false
string powertiptext = "Select"
end type

event clicked;
parent.event ue_set_mousetype(this.tag)
end event

type p_drag from picture within uo_dm_image_toolbar
string tag = "Drag"
integer x = 352
integer y = 4
integer width = 110
integer height = 92
string picturename = "image_drag.bmp"
boolean focusrectangle = false
string powertiptext = "Drag"
end type

event clicked;
parent.event ue_set_mousetype(this.tag)
end event

type p_view_thumbpage from picture within uo_dm_image_toolbar
string tag = "thumbpage"
integer x = 238
integer y = 4
integer width = 110
integer height = 92
string picturename = "view_thumbpage_down.bmp"
boolean focusrectangle = false
string powertiptext = "Page and Thumbnails View"
end type

event clicked;parent.event ue_set_viewstyle(this.tag)
end event

type p_view_thumb from picture within uo_dm_image_toolbar
string tag = "thumb"
integer x = 123
integer y = 4
integer width = 110
integer height = 92
string picturename = "view_thumb.bmp"
boolean focusrectangle = false
string powertiptext = "Thumbnail View"
end type

event clicked;parent.event ue_set_viewstyle(this.tag)
end event

type p_view_page from picture within uo_dm_image_toolbar
string tag = "page"
integer x = 9
integer y = 4
integer width = 110
integer height = 92
string picturename = "view_page.bmp"
boolean focusrectangle = false
string powertiptext = "One Page View"
end type

event clicked;parent.event ue_set_viewstyle(this.tag)
end event

