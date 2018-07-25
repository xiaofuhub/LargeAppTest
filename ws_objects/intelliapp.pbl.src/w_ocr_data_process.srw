$PBExportHeader$w_ocr_data_process.srw
forward
global type w_ocr_data_process from window
end type
type cb_save from commandbutton within w_ocr_data_process
end type
type st_1 from statictext within w_ocr_data_process
end type
type st_path from statictext within w_ocr_data_process
end type
type uo_ocr from uo_image_ocr within w_ocr_data_process
end type
type uo_app from pfc_cst_u_create_app2 within w_ocr_data_process
end type
type cb_pro from commandbutton within w_ocr_data_process
end type
type cb_next from commandbutton within w_ocr_data_process
end type
type cb_goto from commandbutton within w_ocr_data_process
end type
type sle_page from singlelineedit within w_ocr_data_process
end type
type pb_zoomin from picturebutton within w_ocr_data_process
end type
type pb_zoomout from picturebutton within w_ocr_data_process
end type
type cbx_preview from checkbox within w_ocr_data_process
end type
type sle_cur_page from singlelineedit within w_ocr_data_process
end type
type cb_import from commandbutton within w_ocr_data_process
end type
type cb_ocr from commandbutton within w_ocr_data_process
end type
type cb_file from commandbutton within w_ocr_data_process
end type
type cb_close from commandbutton within w_ocr_data_process
end type
type dw_fields from u_dw within w_ocr_data_process
end type
type gb_1 from groupbox within w_ocr_data_process
end type
end forward

global type w_ocr_data_process from window
integer width = 4503
integer height = 2676
boolean titlebar = true
string title = "OCR Data Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_save cb_save
st_1 st_1
st_path st_path
uo_ocr uo_ocr
uo_app uo_app
cb_pro cb_pro
cb_next cb_next
cb_goto cb_goto
sle_page sle_page
pb_zoomin pb_zoomin
pb_zoomout pb_zoomout
cbx_preview cbx_preview
sle_cur_page sle_cur_page
cb_import cb_import
cb_ocr cb_ocr
cb_file cb_file
cb_close cb_close
dw_fields dw_fields
gb_1 gb_1
end type
global w_ocr_data_process w_ocr_data_process

type variables
long il_data_view_id
long il_screen_id
long il_ocr_id, il_app_id
long il_left_b, il_top_b, il_width_b, il_height_b
integer ii_total_page, il_page_b
integer ii_cur_record, ii_max_record
string is_app_path
boolean ib_resize


end variables

forward prototypes
public function integer of_page_draw ()
public function integer of_create_appfile (long al_app_id, string as_ocr_file, boolean ab_bool)
public function integer resize (integer w, integer h)
public function integer of_re_createocrfile (long al_ocr_id, string as_ocr_file)
public function integer of_set_curr_draw (integer al_row)
end prototypes

public function integer of_page_draw ();//====================================================================
//$<Function>: of_page_draw
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.29.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_page, li_row, li_cur_page
long ll_left, ll_top, ll_width, ll_height
string ls_filter

li_cur_page = long(sle_page.text)
if li_cur_page = 0 or isnull(li_cur_page) then return 0
uo_ocr.ole_image_ocr.of_LoadMultiPage(is_app_path, li_cur_page)	
uo_ocr.ole_image_ocr.of_ClearDrawFillRectangle()

for li_row = 1 to dw_fields.rowcount()
	li_page = dw_fields.getitemnumber(li_row, "page_no")
	if li_page = li_cur_page then
		ll_left = dw_fields.getitemnumber(li_row, "x_pos")
		ll_top = dw_fields.getitemnumber(li_row, "y_pos")
		ll_width = dw_fields.getitemnumber(li_row, "x_width")
		ll_height = dw_fields.getitemnumber(li_row, "y_height")
		if ll_left = 0 or isnull(ll_left) then continue
		uo_ocr.ole_image_ocr.of_drawrectangle(ll_left, ll_top, ll_width, ll_height,5,0, rgb(255,255,0), 255, True)
	end if
next

return 1
end function

public function integer of_create_appfile (long al_app_id, string as_ocr_file, boolean ab_bool);//====================================================================
//$<Function>: of_create_appfile
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.29.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_page, li_page_count, li_parent_facility
string   ls_app_image_name

if ab_bool = false then
	uo_app.of_connections( "IntelliCred", "0" )
	uo_app.ii_prac_id = long(ProfileString(gs_IniFilePathName, "Setup", "default_practitioner", "None"))
	li_parent_facility = long(ProfileString(gs_IniFilePathName, "Setup", "default_parent_facility", "None"))
	uo_app.ii_app_id = il_app_id
	
	gs_app_image_path = gnv_data.of_getitem("ids","intelliapp_app_path",false)
	if uo_app.of_load_app() = -1 then return -1
	ls_app_image_name = uo_app.ole_edit.Object.Image()
	if not fileexists(ls_app_image_name) then return -1
	//---------Begin Commented by (Appeon)Stephen 07.29.2014 for Using image OCR to import data into IntelliCred 14.2--------
	/*
	li_page_count = uo_app.ole_edit.Object.PageCount()
	uo_app.ole_edit.Object.Page(1)
	if uo_app.of_setup( il_app_id, 0, 99, li_parent_facility) = -1 then return -1
	
	for li_page = 1 to uo_app.ole_edit.Object.PageCount()
		uo_app.ole_edit.Object.Page(li_page)
		uo_app.ole_edit.Object.Display()
		uo_app.ole_edit.Object.BurnInAnnotations( 1, 2 )		
		uo_app.ole_edit.Object.save()
	next
	*/
	//---------End Commented ------------------------------------------------------

	ls_app_image_name = uo_app.ole_edit.Object.Image()
else
	//---------Begin Modified by (Appeon)Stephen 10.20.2014 for BugA101301--------
	//ls_app_image_name = as_ocr_file
	ls_app_image_name = gs_temp_path +"ocr_imp\applications\" 
	if not DirectoryExists(ls_app_image_name) then CreateDirectory(ls_app_image_name)
	ls_app_image_name = ls_app_image_name + string(il_ocr_id) +  "_b.tif"
	if FileExists(ls_app_image_name) then FileDelete(ls_app_image_name)
	FileCopy(as_ocr_file, ls_app_image_name)
	if not FileExists(ls_app_image_name) then return -1
	//---------End Added ------------------------------------------------------
	
	//---------Begin Added by (Appeon)Stephen 07.29.2014 for Using image OCR to import data into IntelliCred 14.2--------
	uo_app.ole_edit.Object.Image(ls_app_image_name)
	li_page_count = uo_app.ole_edit.Object.PageCount()
	for li_page = 1 to uo_app.ole_edit.Object.PageCount()
		uo_app.ole_edit.Object.Page(li_page)
		uo_app.ole_edit.Object.Display()
		uo_app.ole_edit.Object.BurnInAnnotations( 1, 2 )		
		uo_app.ole_edit.Object.save()
	next
	//---------End Added ------------------------------------------------------
end if
if not fileexists(ls_app_image_name) then return -1

is_app_path = ls_app_image_name
uo_ocr.ole_image_ocr.of_LoadMultiPage(ls_app_image_name, 1)
sle_cur_page.text = '1'
sle_page.text = '1'
uo_app.ole_edit.Object.Image = ""
uo_app.ole_edit.Object.ClearDisplay()
uo_app.ole_edit.Object.Image(ls_app_image_name)
ii_total_page = uo_app.ole_edit.Object.PageCount()
of_page_draw()
gb_1.text = "Page 1 of " +string(ii_total_page)
return 1
end function

public function integer resize (integer w, integer h);//Start Code Change ----.2014 #V14.2 maha
//uo_ocr.x = dw_fields.


return 1











end function

public function integer of_re_createocrfile (long al_ocr_id, string as_ocr_file);//====================================================================
//$<Function>: of_re_createocrfile
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.29.2014 (Using image OCR to import data into IntelliCred 14.2)
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

dw_fields.setfilter("1=1")
dw_fields.filter()
dw_fields.setsort("field_id A")
dw_fields.sort()

ls_sql = "select "
for li_row = 1 to dw_fields.rowcount()
	ll_field_id = dw_fields.getitemnumber(li_row, "field_id")
	if isnull(ll_field_pro) then ll_field_pro = 0
	if ll_field_id <> ll_field_pro then
		ls_field_name = dw_fields.getitemstring(li_row, "field_name")
		ls_field_alias =  dw_fields.getitemstring(li_row, "field_alias")
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
	li_find = dw_fields.find("record_id ="+string(li_record), 1, dw_fields.rowcount())
	if li_find < 1 then continue
	for li_col = 1 to upperbound(ls_fields_total)
		ls_field_name = ls_fields_total[li_col]
		li_find = dw_fields.find("field_name='"+ls_field_name+"' and record_id ="+string(li_record), 1, dw_fields.rowcount())
		if li_find > 0 then			
			ls_msg = dw_fields.getitemstring(li_find, "key_values")
			lds_ocr_data.setitem(li_row, ls_field_name, ls_msg)
		end if
	next
next

if cbx_preview.checked then
	lstr_pass.s_string = ls_sql
	lstr_pass.s_dw = lds_ocr_data
	lstr_pass.s_string_array = ls_fields_total
	lstr_pass.ab_bool = true
	openwithparm( w_export_previewdata, lstr_pass )
end if

if fileexists(as_ocr_file) then filedelete(as_ocr_file)
lds_ocr_data.saveas(as_ocr_file, text!, true)
messagebox("Save File","The file is saved in:" + as_ocr_file)
if isvalid(lds_ocr_data) then destroy lds_ocr_data
return 1
end function

public function integer of_set_curr_draw (integer al_row);//====================================================================
//$<Function>: of_set_curr_draw
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 10.20.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_page, li_row, li_cur_page
long ll_left, ll_top, ll_width, ll_height
string ls_filter

if al_row < 1 then return 0
li_cur_page = long(sle_page.text)

if il_width_b > 0 and il_page_b = li_cur_page then 
	uo_ocr.ole_image_ocr.of_ClearDrawFillRectangle()
	uo_ocr.ole_image_ocr.of_drawrectangle(il_left_b, il_top_b, il_width_b, il_height_b,5,0, rgb(255,255,0), 255, true)
end if
	
li_page = dw_fields.getitemnumber(al_row, "page_no")
if li_page = li_cur_page then
	ll_left = dw_fields.getitemnumber(al_row, "x_pos")
	ll_top = dw_fields.getitemnumber(al_row, "y_pos")
	ll_width = dw_fields.getitemnumber(al_row, "x_width")
	ll_height = dw_fields.getitemnumber(al_row, "y_height")
	if ll_width > 0 then
		uo_ocr.ole_image_ocr.of_ClearDrawFillRectangle()
		uo_ocr.ole_image_ocr.of_drawrectangle(ll_left, ll_top, ll_width, ll_height,5,0, rgb(255,0,0), 255, true)
	end if	
	
	il_left_b = ll_left
	il_top_b = ll_top
	il_width_b = ll_width
	il_height_b = ll_height
	il_page_b = li_cur_page
end if
	



end function

on w_ocr_data_process.create
this.cb_save=create cb_save
this.st_1=create st_1
this.st_path=create st_path
this.uo_ocr=create uo_ocr
this.uo_app=create uo_app
this.cb_pro=create cb_pro
this.cb_next=create cb_next
this.cb_goto=create cb_goto
this.sle_page=create sle_page
this.pb_zoomin=create pb_zoomin
this.pb_zoomout=create pb_zoomout
this.cbx_preview=create cbx_preview
this.sle_cur_page=create sle_cur_page
this.cb_import=create cb_import
this.cb_ocr=create cb_ocr
this.cb_file=create cb_file
this.cb_close=create cb_close
this.dw_fields=create dw_fields
this.gb_1=create gb_1
this.Control[]={this.cb_save,&
this.st_1,&
this.st_path,&
this.uo_ocr,&
this.uo_app,&
this.cb_pro,&
this.cb_next,&
this.cb_goto,&
this.sle_page,&
this.pb_zoomin,&
this.pb_zoomout,&
this.cbx_preview,&
this.sle_cur_page,&
this.cb_import,&
this.cb_ocr,&
this.cb_file,&
this.cb_close,&
this.dw_fields,&
this.gb_1}
end on

on w_ocr_data_process.destroy
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.st_path)
destroy(this.uo_ocr)
destroy(this.uo_app)
destroy(this.cb_pro)
destroy(this.cb_next)
destroy(this.cb_goto)
destroy(this.sle_page)
destroy(this.pb_zoomin)
destroy(this.pb_zoomout)
destroy(this.cbx_preview)
destroy(this.sle_cur_page)
destroy(this.cb_import)
destroy(this.cb_ocr)
destroy(this.cb_file)
destroy(this.cb_close)
destroy(this.dw_fields)
destroy(this.gb_1)
end on

event open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
str_parm lstr_parm
long ll_row

dw_fields.modify("ocr_field_id.visible='0'")
dw_fields.modify("b_map.visible='0'")

lstr_parm = message.powerobjectparm
il_ocr_id = lstr_parm.l_wf_id
il_app_id = lstr_parm.l_doc_id
dw_fields.retrieve(il_ocr_id)

for ll_row = 1 to dw_fields.rowcount()
	dw_fields.setitem(ll_row, "key_values", "")
next
of_create_appfile(il_app_id, "", false)

//---------Begin Added by (Appeon)Stephen 08.07.2014 for BugH072401--------
IF w_mdi.of_security_access( 6928 ) = 0 THEN
	cb_import.enabled = False
ELSE
	cb_import.enabled = true
end if
//---------End Added ------------------------------------------------------
end event

event resize;//====================================================================
//$<Event>: resize
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.05.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Start Code Change ----07.25.2014 #V14.2 maha
ib_resize = false
uo_ocr.width = newwidth - dw_fields.width - 50
uo_ocr.height = newheight - 230
dw_fields.height = uo_ocr.height 
ib_resize = true
end event

type cb_save from commandbutton within w_ocr_data_process
boolean visible = false
integer x = 347
integer y = 52
integer width = 434
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Re-save Data File"
end type

event clicked;//Start Code Change ----07.25.2014 #V14.2 maha - added
//dw_fields.saveas( st_path.text ,text!,false)

of_re_createocrfile(il_ocr_id, st_path.text) //(Appeon)Stephen 07.29.2014 - Using image OCR to import data into IntelliCred 14.2
end event

type st_1 from statictext within w_ocr_data_process
integer x = 41
integer y = 84
integer width = 247
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "File Path:"
boolean focusrectangle = false
end type

type st_path from statictext within w_ocr_data_process
integer x = 27
integer y = 160
integer width = 1874
integer height = 64
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

type uo_ocr from uo_image_ocr within w_ocr_data_process
event destroy ( )
integer x = 1394
integer y = 244
integer taborder = 140
end type

on uo_ocr.destroy
call uo_image_ocr::destroy
end on

type uo_app from pfc_cst_u_create_app2 within w_ocr_data_process
boolean visible = false
integer x = 1563
integer y = 436
integer width = 1083
integer height = 912
integer taborder = 150
end type

on uo_app.destroy
call pfc_cst_u_create_app2::destroy
end on

type cb_pro from commandbutton within w_ocr_data_process
integer x = 1413
integer y = 52
integer width = 101
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<-"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.29.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_page

li_page = integer(sle_page.text)
if  li_page > 1 then
	li_page = li_page -1
	sle_page.text = string(li_page)
	sle_cur_page.text = string(li_page)
	gb_1.text = "Page "+string(li_page) +" of " +string(ii_total_page)
	of_page_draw()
end if
end event

type cb_next from commandbutton within w_ocr_data_process
integer x = 1522
integer y = 52
integer width = 101
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "->"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.29.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_page

li_page = integer(sle_page.text)
if  li_page < ii_total_page then
	li_page = li_page +1
	sle_page.text = string(li_page)
	sle_cur_page.text = string(li_page)
	gb_1.text = "Page "+string(li_page) +" of " +string(ii_total_page)
	of_page_draw()
end if
end event

type cb_goto from commandbutton within w_ocr_data_process
integer x = 1637
integer y = 52
integer width = 174
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Goto:"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.29.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_page

li_page = integer(sle_page.text)
if  li_page <= ii_total_page and li_page > 0 then	
	sle_cur_page.text = string(li_page)
	gb_1.text = "Page "+string(li_page) +" of " +string(ii_total_page)
	of_page_draw()
end if
end event

type sle_page from singlelineedit within w_ocr_data_process
integer x = 1815
integer y = 60
integer width = 174
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type pb_zoomin from picturebutton within w_ocr_data_process
integer x = 2011
integer y = 52
integer width = 114
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoomin.bmp"
alignment htextalign = left!
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
uo_ocr.ole_image_ocr.of_zoomin()
end event

type pb_zoomout from picturebutton within w_ocr_data_process
integer x = 2126
integer y = 52
integer width = 114
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "zoomout.bmp"
alignment htextalign = left!
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
uo_ocr.ole_image_ocr.of_zoomout()
end event

type cbx_preview from checkbox within w_ocr_data_process
integer x = 3145
integer y = 68
integer width = 297
integer height = 64
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Preview"
end type

type sle_cur_page from singlelineedit within w_ocr_data_process
boolean visible = false
integer x = 969
integer y = 24
integer width = 242
integer height = 92
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "cur_page"
borderstyle borderstyle = stylelowered!
end type

type cb_import from commandbutton within w_ocr_data_process
integer x = 3447
integer y = 52
integer width = 379
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "3 - Import Data "
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.12.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_imp_id, ll_proc_cnt
long ll_prac_id
integer li_Return
string ls_message
str_parm lstr_ocr
n_cst_import_credapp lnv_import

if dw_fields.rowcount() < 1 then return //(Appeon)Stephen 08.07.2014 - BugH072402
if not fileexists(is_app_path) then return -1
select import_id into :ll_imp_id from import_hdr where import_id in(select import_id from ocr_appl where ocr_id = :il_ocr_id) using sqlca;
if not isnull(ll_imp_id) then
	lnv_import = Create n_cst_import_credapp
	lnv_import.of_set_sched_flag(true)	
	li_Return = lnv_import.of_Execute(ll_imp_id, false)
	ls_message = lnv_import.of_get_sched_msg( )
	ll_proc_cnt = lnv_import.of_get_sched_cnt( )	
	if ls_message <> "" and  not isnull(ls_message) then
		messagebox("Error", "Error" + ls_message, Stopsign!)
	else
		//save image file		
		lnv_import.of_ocr_image_insert(is_app_path, ii_total_page)
	end if
	
	Destroy lnv_import
end if


end event

type cb_ocr from commandbutton within w_ocr_data_process
integer x = 2784
integer y = 52
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "2 - OCR Data"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.12.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_imp_id, li_max_imp
string ls_path, ls_ocr_name, ls_import_name
datetime ldt_today
str_parm lstr_ocr
boolean lb_preview

if dw_fields.rowcount() < 1 then return //(Appeon)Stephen 08.07.2014 - BugH072402
ls_path = gs_temp_path +"ocr_imp\"
if not DirectoryExists(ls_path) then CreateDirectory(ls_path)
ls_path = ls_path + "ocr_imp_"+string(il_ocr_id) +".txt"
st_path.text = ls_path  //Start Code Change ----07.25.2014 #V14.2 maha
cb_save.visible = true //Start Code Change ----07.25.2014 #V14.2 maha

if not fileexists(is_app_path) then return -1
if cbx_preview.checked then
	lb_preview = true
else
	lb_preview = false
end if
uo_ocr.ole_image_ocr.of_create_ocr_file(dw_fields, ls_path, is_app_path, il_ocr_id, lb_preview)

dw_fields.setsort("record_id A, ocr_field_id A") //Start Code Change ----07.25.2014 #V14.2 maha
dw_fields.sort()

gnv_appeondb.of_startqueue( )
select ocr_name into :ls_ocr_name from ocr_appl where ocr_id = :il_ocr_id using sqlca;
select import_id into :ll_imp_id from import_hdr where import_id in(select import_id from ocr_appl where ocr_id = :il_ocr_id) using sqlca;
gnv_appeondb.of_commitqueue( )	

ldt_today = datetime(today(), now())
if isnull(ll_imp_id) or ll_imp_id = 0 then 
else
	update import_hdr set imp_file = :ls_path, mod_date = :ldt_today, mod_user = :gs_user_id where import_id = :ll_imp_id using sqlca;
end if

of_page_draw()
return 1
end event

type cb_file from commandbutton within w_ocr_data_process
integer x = 2409
integer y = 52
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "1 - Get File"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_ocr_file

open(w_get_ocrfile)
ls_ocr_file = message.stringparm

if fileexists(ls_ocr_file) then
	of_create_appfile(0, ls_ocr_file, true)
end if
end event

type cb_close from commandbutton within w_ocr_data_process
integer x = 4064
integer y = 52
integer width = 343
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_fields from u_dw within w_ocr_data_process
integer x = 18
integer y = 244
integer width = 1353
integer height = 2312
integer taborder = 130
string dataobject = "d_ocr_appl_fields"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationnever!
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if currentrow < 1 then return
this.setrow(currentrow)
this.selectrow(0, false)
this.selectrow(currentrow, true)
of_set_curr_draw(currentrow)  //(Appeon)Stephen 10.23.2014 - BugA101103
end event

event resize;call super::resize;//Start Code Change ----.2014 #V14.2 maha
if ib_resize then
	uo_ocr.x = dw_fields.x + dw_fields.width + 10
	uo_ocr.width = w_ocr_data_process.width - dw_fields.width - 50
	uo_ocr.height = w_ocr_data_process.height - 230
	uo_ocr.height = dw_fields.height
end if
end event

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 10.23.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if row < 1 then return
this.setrow(row)
this.selectrow(0, false)
this.selectrow(row, true)
end event

type gb_1 from groupbox within w_ocr_data_process
integer x = 1394
integer width = 869
integer height = 160
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Page"
end type

