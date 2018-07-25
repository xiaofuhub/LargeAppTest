$PBExportHeader$u_imageview_ocr.sru
forward
global type u_imageview_ocr from olecustomcontrol
end type
end forward

global type u_imageview_ocr from olecustomcontrol
integer width = 1125
integer height = 824
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "u_imageview_ocr.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
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
end type
global u_imageview_ocr u_imageview_ocr

forward prototypes
public subroutine of_cleardrawfillrectangle ()
public subroutine of_drawrectangle (long al_left, long al_top, long al_width, long al_height, integer ai_penwidth, integer ai_dashstyle, long al_color, integer ai_full, boolean ab_anis)
public subroutine of_drawfillrectangle (long al_left, long al_top, long al_width, long al_height, long al_color, integer ai_full, boolean ab_anis)
public function integer of_loadmultipage (string as_path, integer ai_page)
public function string of_ocr_data (long al_left, long al_top, long al_width, long al_height)
public subroutine of_setsize (integer ai_size)
public subroutine of_zoomin ()
public subroutine of_zoomout ()
public function integer of_create_ocr_file (ref datawindow adw_fields, string as_ocr_file, string as_image_file, long al_ocr_id, boolean ab_preview)
end prototypes

public subroutine of_cleardrawfillrectangle ();//====================================================================
//$<Function>: of_ClearDrawFillRectangle
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.09.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.object.ClearSelectionRect()
this.object.ClearDrawRectangle()
this.object.ClearDrawFillRectangle()
this.object.ClearDrawPie()
end subroutine

public subroutine of_drawrectangle (long al_left, long al_top, long al_width, long al_height, integer ai_penwidth, integer ai_dashstyle, long al_color, integer ai_full, boolean ab_anis);//====================================================================
//$<Function>: of_DrawRectangle
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 10.23.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
of_ClearDrawFillRectangle()  
this.object.DrawRectangle(al_left,al_top, al_width, al_height, ai_PenWidth, ai_DashStyle, al_color, ai_full, ab_anis)
end subroutine

public subroutine of_drawfillrectangle (long al_left, long al_top, long al_width, long al_height, long al_color, integer ai_full, boolean ab_anis);//====================================================================
//$<Function>: of_DrawFillRectangle
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.06.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
of_ClearDrawFillRectangle()  //(Appeon)Stephen 07.30.2014 - OCR functionality test
this.object.DrawFillRectangle(al_left,al_top, al_width, al_height, al_color, ai_full, ab_anis)
end subroutine

public function integer of_loadmultipage (string as_path, integer ai_page);//====================================================================
//$<Function>: of_LoadMultiPage
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.06.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.setredraw(false)
if this.object.LoadMultiPage(as_path, ai_page) = 0 then return -1
this.object.MouseTrackMode = 1
this.object.view=10  
this.setredraw(true)
end function

public function string of_ocr_data (long al_left, long al_top, long al_width, long al_height);//====================================================================
//$<Function>: of_ocr_data
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.06.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_msg

this.object.ocrsetrect(al_left, al_top, al_width, al_height)
this.object.OCRScanTextAsync(False)
this.object.OCRStartScan(0, "dictfiles")
ls_msg = this.object.OCRGetRecognizedText( )
this.object.OCRStopScan() 

if ls_msg = "~~" then ls_msg = ""  //(Appeon)Stephen 10.17.2014 -BugA101106
return ls_msg
end function

public subroutine of_setsize (integer ai_size);//====================================================================
//$<Function>: of_setsize
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.09.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.object.viewsize = ai_size
end subroutine

public subroutine of_zoomin ();//====================================================================
//$<Function>: of_zoomin
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  none
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.object.ZoomIn()
end subroutine

public subroutine of_zoomout ();//====================================================================
//$<Function>: of_zoomout
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.object.ZoomOut()
end subroutine

public function integer of_create_ocr_file (ref datawindow adw_fields, string as_ocr_file, string as_image_file, long al_ocr_id, boolean ab_preview);//====================================================================
//$<Function>: of_create_ocr_file
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.10.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_msg, ls_field_alias
string ls_field_name, ls_sql
string ls_syntax, ls_error
string ls_fields_total[], ls_alias_total[]
long ll_left, ll_top, ll_width, ll_height
long ll_field_id, ll_field_pro
integer li_row, li_record, li_page, li_page_pro
integer li_col, li_record_max
integer li_find
datastore lds_ocr_data
str_pass lstr_pass

of_ClearDrawFillRectangle()
adw_fields.setfilter("1=1")
adw_fields.filter()
adw_fields.setsort("field_id A")
adw_fields.sort()

ls_sql = "select "
for li_row = 1 to adw_fields.rowcount()
	ll_field_id = adw_fields.getitemnumber(li_row, "field_id")
	if isnull(ll_field_pro) then ll_field_pro = 0
	if ll_field_id <> ll_field_pro then
		ls_field_name = adw_fields.getitemstring(li_row, "field_name")
		ls_field_alias =  adw_fields.getitemstring(li_row, "field_alias")
		ls_fields_total[upperbound(ls_fields_total) +1] = ls_field_name
		ls_alias_total[upperbound(ls_alias_total)+1] = ls_field_alias
		ll_field_pro = ll_field_id
		ls_field_name = "field_2 as " + ls_field_name
		ls_sql = ls_sql + ls_field_name +", "
	end if
next
ls_sql = left(ls_sql, len(ls_sql) - 2)
ls_sql = ls_sql + " from import_table_gen"
lds_ocr_data = create datastore

//Dynamic create ocr datastore
ls_Syntax = SQLCA.SyntaxFromSQL(ls_sql, "Style(Type=Grid)", ls_Error)
IF LenA(ls_Error) > 0 THEN
		MessageBox("Error",ls_Error,StopSign!)
		RETURN -1
END IF
lds_ocr_data.Create(ls_Syntax, ls_Error)
IF LenA(ls_Error) > 0 THEN
	RETURN -1
END IF

for li_row = 1 to upperbound(ls_fields_total)
	lds_ocr_data.modify( ls_fields_total[li_row] +"_t.text = '"+ ls_alias_total[li_row]+"'")
next

select max(record_id) into :li_record_max from ocr_appl_fields where ocr_id = :al_ocr_id;
for li_record = 1 to li_record_max
	li_row = lds_ocr_data.insertrow(0)
	li_find = adw_fields.find("record_id ="+string(li_record), 1, adw_fields.rowcount())
	if li_find < 1 then continue
	for li_col = 1 to upperbound(ls_fields_total)
		ls_field_name = ls_fields_total[li_col]
		li_find = adw_fields.find("field_name='"+ls_field_name+"' and record_id ="+string(li_record), 1, adw_fields.rowcount())
		if li_find > 0 then
			ll_left = adw_fields.getitemnumber(li_find, "x_pos")
			ll_top = adw_fields.getitemnumber(li_find, "y_pos")
			ll_width = adw_fields.getitemnumber(li_find, "x_width")
			ll_height = adw_fields.getitemnumber(li_find, "y_height")
			li_page = adw_fields.getitemnumber(li_find, "page_no")
			if isnull(ll_left) or ll_left = 0 then continue
			if isnull(li_page_pro) or li_page <> li_page_pro then
				of_loadmultipage(as_image_file, li_page)
				li_page_pro = li_page
			end if
			ls_msg = of_ocr_data(ll_left, ll_top, ll_width, ll_height)
			adw_fields.setitem(li_find, "key_values", ls_msg)
			lds_ocr_data.setitem(li_row, ls_field_name, ls_msg)
		end if
	next
next

if ab_preview = true then
	lstr_pass.s_string = ls_sql
	lstr_pass.s_dw = lds_ocr_data
	lstr_pass.s_string_array = ls_fields_total
	lstr_pass.ab_bool = true
	openwithparm( w_export_previewdata, lstr_pass )
end if

if fileexists(as_ocr_file) then filedelete(as_ocr_file)
lds_ocr_data.saveas(as_ocr_file, text!, true)
messagebox("Save File","The OCR test result is saved in the file '" + as_ocr_file +"'.")
if isvalid(lds_ocr_data) then 
	destroy lds_ocr_data
end if
return 1
end function

on u_imageview_ocr.create
end on

on u_imageview_ocr.destroy
end on

event constructor;This.object.licensekey = '12820'
This.object.PDFUseAdvancedViewer = true //(Appeon)Stephen 09.05.2017 - Image Viewer CP Upgrade
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Cu_imageview_ocr.bin 
2E00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000c9f2bdc001d326d300000003000001800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004e589da784fc5ad4c479eb9b69e6710b100000000c9f2bdc001d326d3c9f2bdc001d326d3000000000000000000000000fffffffe000000020000000300000004fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0065004400650076006f006c00650070002000720069006c006500630073006e003a0065003600350033003700000000000000000000000000000000000000000000fffe00020106e589da784fc5ad4c479eb9b69e6710b100000001fb8f0821101b01640008ed8413c72e2b00000030000000a400000005000001000000003000000101000000380000010200000040000001030000004800000000000000500000000300010000000000030000196d000000030000154a00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000196d0000154a00000000000001010000000000000000000000006564040000646f6d0000000000000000000001006000600050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000003e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Cu_imageview_ocr.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
