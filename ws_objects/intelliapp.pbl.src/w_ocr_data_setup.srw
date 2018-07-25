$PBExportHeader$w_ocr_data_setup.srw
forward
global type w_ocr_data_setup from window
end type
type uo_ocr from uo_image_ocr within w_ocr_data_setup
end type
type pb_zoomout from picturebutton within w_ocr_data_setup
end type
type pb_zoomin from picturebutton within w_ocr_data_setup
end type
type dw_properties from u_dw within w_ocr_data_setup
end type
type cb_2 from commandbutton within w_ocr_data_setup
end type
type cb_imp from commandbutton within w_ocr_data_setup
end type
type sle_cur_page from singlelineedit within w_ocr_data_setup
end type
type sle_page from singlelineedit within w_ocr_data_setup
end type
type cb_goto from commandbutton within w_ocr_data_setup
end type
type cb_next from commandbutton within w_ocr_data_setup
end type
type cb_pro from commandbutton within w_ocr_data_setup
end type
type cb_save from commandbutton within w_ocr_data_setup
end type
type cb_close from commandbutton within w_ocr_data_setup
end type
type ole_admin from olecustomcontrol within w_ocr_data_setup
end type
type cb_view from commandbutton within w_ocr_data_setup
end type
type dw_detail from u_dw within w_ocr_data_setup
end type
type dw_screen from u_dw within w_ocr_data_setup
end type
type dw_fields from datawindow within w_ocr_data_setup
end type
type dw_tables from datawindow within w_ocr_data_setup
end type
type gb_2 from groupbox within w_ocr_data_setup
end type
type gb_1 from groupbox within w_ocr_data_setup
end type
type uo_app from pfc_cst_u_create_app2 within w_ocr_data_setup
end type
end forward

global type w_ocr_data_setup from window
integer width = 4663
integer height = 2724
boolean titlebar = true
string title = "OCR Application Setup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
uo_ocr uo_ocr
pb_zoomout pb_zoomout
pb_zoomin pb_zoomin
dw_properties dw_properties
cb_2 cb_2
cb_imp cb_imp
sle_cur_page sle_cur_page
sle_page sle_page
cb_goto cb_goto
cb_next cb_next
cb_pro cb_pro
cb_save cb_save
cb_close cb_close
ole_admin ole_admin
cb_view cb_view
dw_detail dw_detail
dw_screen dw_screen
dw_fields dw_fields
dw_tables dw_tables
gb_2 gb_2
gb_1 gb_1
uo_app uo_app
end type
global w_ocr_data_setup w_ocr_data_setup

type variables
long il_data_view_id
long il_screen_id
long il_table_id
long il_ocr_id, il_app_id
long il_left, il_top, il_width, il_height
long il_left_b, il_top_b, il_width_b, il_height_b
integer ii_total_page, il_page_b
integer ii_cur_record, ii_max_record
string is_app_path
string is_drag_field_name
string is_filter
boolean ib_ocr_modify = false

pfc_cst_nv_data_entry_functions inv_data_entry
end variables

forward prototypes
public function integer of_create_dynamic_dw (integer ai_screen_id)
public function integer of_init (integer adw_dataview_id)
public function integer of_create_appfile (long al_app_id)
public function integer of_add_field ()
public function integer of_page_draw ()
public function integer of_set_curr_draw (integer al_row)
end prototypes

event ue_postopen();//====================================================================
//$<Event>: ue_postopen
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.07.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
dw_screen.setitem(1, "screen_id",1)
dw_screen.event itemchanged(1, dw_screen.object, '1')
end event

public function integer of_create_dynamic_dw (integer ai_screen_id);//====================================================================
//$<Function>: of_create_dynamic_dw
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_cnt
pfc_cst_nv_data_entry_functions lnv_data_entry

lnv_data_entry = create pfc_cst_nv_data_entry_functions
lnv_data_entry.ib_report = false
lnv_data_entry.of_setup_cache()
lnv_data_entry.of_refresh_cache()
lnv_data_entry.of_create_dynamic_dw(0, il_data_view_id, ai_screen_id, dw_detail, dw_detail, false, 0 , true)

if isvalid(lnv_data_entry) then destroy lnv_data_entry

for li_cnt = 1 to integer(dw_detail.object.datawindow.column.count)
	dw_detail.modify("#" +string(li_cnt)+".tabsequence=0")
next
return 1
end function

public function integer of_init (integer adw_dataview_id);//====================================================================
//$<Function>: of_init
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.29.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
datawindowchild dwchild

dw_screen.reset()
dw_screen.insertrow(1)
dw_screen.getchild( "screen_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(adw_dataview_id)

return 1
end function

public function integer of_create_appfile (long al_app_id);//====================================================================
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

uo_app.of_connections( "IntelliCred", "0" )
uo_app.ii_prac_id = long(ProfileString(gs_IniFilePathName, "Setup", "default_practitioner", "None"))
li_parent_facility = long(ProfileString(gs_IniFilePathName, "Setup", "default_parent_facility", "None"))
uo_app.ii_app_id = il_app_id

gs_app_image_path = gnv_data.of_getitem("ids","intelliapp_app_path",false)
if uo_app.of_load_app() = -1 then return -1
ls_app_image_name = uo_app.ole_edit.Object.Image()
if not fileexists(ls_app_image_name) then return -1
//uo_app.ole_edit.Object.HideAnnotationGroup()
li_page_count = uo_app.ole_edit.Object.PageCount()
uo_app.ole_edit.Object.Page(1)
if uo_app.of_setup( il_app_id, 0, 99, li_parent_facility) = -1 then return -1

for li_page = 1 to uo_app.ole_edit.Object.PageCount()
	uo_app.ole_edit.Object.Page(li_page)
	uo_app.ole_edit.Object.Display()
	uo_app.ole_edit.Object.BurnInAnnotations( 1, 2 )		
	uo_app.ole_edit.Object.save()
next
		
ls_app_image_name = uo_app.ole_edit.Object.Image()
is_app_path = ls_app_image_name
uo_ocr.ole_image_ocr.of_LoadMultiPage(ls_app_image_name, 1)
sle_cur_page.text = '1'
sle_page.text = '1'
ii_total_page = uo_app.ole_edit.Object.PageCount()
of_page_draw()
gb_1.text = "Page 1 of " +string(ii_total_page)
return 1
end function

public function integer of_add_field ();//====================================================================
//$<Function>: of_add_field
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.03.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_row, ll_find, ll_field_len, ll_findrow
Long ll_field_id, ll_table_id, ll_ocr_filed
integer li_page, li_record_id
integer li_ret
String ls_sys_fields_alias , ls_find
String ls_field_name, ls_screen_name
boolean lb_new_record

ls_find = "sys_fields_table_id = " + String(il_table_id) + " AND upper(sys_fields_field_name) = '" + Upper(is_drag_field_name) + "'"
ll_find = dw_properties.Find(ls_find, 1, dw_properties.RowCount()) 

IF IsNull(ll_find) OR ll_find < 1 THEN RETURN -1

ll_table_id = dw_properties.GetItemNumber(ll_find,"sys_fields_table_id")
ll_field_id = dw_properties.GetItemNumber(ll_find,"sys_fields_field_id")
ls_field_name = dw_properties.GetItemstring(ll_find,"sys_fields_field_name")
ls_sys_fields_alias = dw_properties.GetItemString(ll_find,"sys_fields_field_name_allias")
if isnull(ii_cur_record) or ii_cur_record = 0 then ii_cur_record = 1

gnv_appeondb.of_startqueue( )
select screen_name into :ls_screen_name from data_view_screen where data_view_id = 1 and table_id =:ll_table_id;
select max(record_id) into :li_record_id from ocr_appl_fields where ocr_id = :il_ocr_id;
select max(Ocr_field_id) into :ll_ocr_filed from ocr_appl_fields using sqlca;
select count(1) into :ll_findrow from ocr_appl_fields where field_id = :ll_field_id and ocr_id = :il_ocr_id and record_id = :ii_cur_record using sqlca;
gnv_appeondb.of_commitqueue( )

if isnull(li_record_id) or li_record_id = 0 then li_record_id = 1
if ii_max_record < li_record_id or isnull(ii_max_record) then ii_max_record = li_record_id

lb_new_record = false
if ll_findrow >0 then
	li_ret = messagebox("Prompt", "This field already exists. Do you want to add a new record?", Question!, OKCancel!, 1)
	if li_ret = 2 then return -1
	ii_max_record++
	li_record_id = ii_max_record
	lb_new_record = true
else
	li_record_id = ii_cur_record
end if

ll_findrow = dw_tables.find("ocr_appl_fields_screen_id = " + string(il_screen_id) +" and ocr_appl_fields_record_id = " +string(li_record_id) ,1,dw_tables.rowcount())
if ll_findrow < 1  or lb_new_record = true then
	ll_row = dw_tables.insertrow(0)
	dw_tables.setitem(ll_row, "data_view_screen_screen_name", ls_screen_name)
	dw_tables.setitem(ll_row, "ocr_appl_fields_record_id", li_record_id)
	dw_tables.setitem(ll_row, "ocr_appl_fields_table_id", ll_table_id)
	dw_tables.setitem(ll_row, "ocr_appl_fields_screen_id", il_screen_id)  //(Appeon)Stephen 08.07.2014 - BugH072104
	dw_tables.setrow(ll_row)
	dw_tables.selectrow(0, false)	
	dw_tables.selectrow(ll_row, true)	
end if

li_page = integer(sle_cur_page.text)
ll_row = dw_fields.InsertRow(0)
dw_fields.ScrollToRow(ll_row) 
dw_fields.SetItem(ll_row, "ocr_id", il_ocr_id )
dw_fields.SetItem(ll_row, "table_id", ll_table_id)
dw_fields.SetItem(ll_row, "screen_id", il_screen_id)  //(Appeon)Stephen 08.07.2014 - BugH072104
dw_fields.SetItem(ll_row, "field_id", ll_field_id)
dw_fields.SetItem(ll_row, "field_name", ls_field_name)
dw_fields.SetItem(ll_row, "field_alias", ls_sys_fields_alias)
dw_fields.SetItem(ll_row, "record_id", li_record_id)
dw_fields.SetItem(ll_row, "page_no", li_page)

//---------Begin Added by (Appeon)Stephen 08.20.2014 for BugH081503--------
if isnull(ll_ocr_filed) then ll_ocr_filed = 0
ll_ocr_filed = ll_ocr_filed + 1
dw_fields.SetItem(ll_row, "ocr_field_id", ll_ocr_filed)
dw_fields.accepttext()
if dw_fields.update() <> 1 then
	rollback using sqlca;
	return -1
else
	commit using sqlca;
end if
//---------End Added ------------------------------------------------------

ib_ocr_modify = true

RETURN  1
end function

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
dw_fields.setredraw(false)
dw_fields.setfilter("")
dw_fields.filter()
for li_row = 1 to dw_fields.rowcount()
	li_page = dw_fields.getitemnumber(li_row, "page_no")
	if li_page = li_cur_page then
		ll_left = dw_fields.getitemnumber(li_row, "x_pos")
		ll_top = dw_fields.getitemnumber(li_row, "y_pos")
		ll_width = dw_fields.getitemnumber(li_row, "x_width")
		ll_height = dw_fields.getitemnumber(li_row, "y_height")
		if ll_width = 0 or isnull(ll_width) then continue
		uo_ocr.ole_image_ocr.of_drawrectangle(ll_left, ll_top, ll_width, ll_height,5,0, rgb(255,255,0), 255, True)
	end if
next

if not(isnull(is_filter) or is_filter = "") then
	dw_fields.setfilter(is_filter)
	dw_fields.filter()
end if
dw_fields.setredraw(true)
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

on w_ocr_data_setup.create
this.uo_ocr=create uo_ocr
this.pb_zoomout=create pb_zoomout
this.pb_zoomin=create pb_zoomin
this.dw_properties=create dw_properties
this.cb_2=create cb_2
this.cb_imp=create cb_imp
this.sle_cur_page=create sle_cur_page
this.sle_page=create sle_page
this.cb_goto=create cb_goto
this.cb_next=create cb_next
this.cb_pro=create cb_pro
this.cb_save=create cb_save
this.cb_close=create cb_close
this.ole_admin=create ole_admin
this.cb_view=create cb_view
this.dw_detail=create dw_detail
this.dw_screen=create dw_screen
this.dw_fields=create dw_fields
this.dw_tables=create dw_tables
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_app=create uo_app
this.Control[]={this.uo_ocr,&
this.pb_zoomout,&
this.pb_zoomin,&
this.dw_properties,&
this.cb_2,&
this.cb_imp,&
this.sle_cur_page,&
this.sle_page,&
this.cb_goto,&
this.cb_next,&
this.cb_pro,&
this.cb_save,&
this.cb_close,&
this.ole_admin,&
this.cb_view,&
this.dw_detail,&
this.dw_screen,&
this.dw_fields,&
this.dw_tables,&
this.gb_2,&
this.gb_1,&
this.uo_app}
end on

on w_ocr_data_setup.destroy
destroy(this.uo_ocr)
destroy(this.pb_zoomout)
destroy(this.pb_zoomin)
destroy(this.dw_properties)
destroy(this.cb_2)
destroy(this.cb_imp)
destroy(this.sle_cur_page)
destroy(this.sle_page)
destroy(this.cb_goto)
destroy(this.cb_next)
destroy(this.cb_pro)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.ole_admin)
destroy(this.cb_view)
destroy(this.dw_detail)
destroy(this.dw_screen)
destroy(this.dw_fields)
destroy(this.dw_tables)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_app)
end on

event open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
str_parm lstr_parm
datawindowchild dwchild

dw_screen.settransobject(sqlca)
dw_screen.insertrow(1)
dw_screen.getchild( "screen_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(1)
dwchild.insertrow(1)

il_data_view_id = integer(gnv_data.of_getitem('security_users','default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
if isnull(il_data_view_id) or il_data_view_id = 0 then il_data_view_id = 1 //(Appeon)Stephen 07.30.2014 - OCR functionalit test for Mike

lstr_parm = message.powerobjectparm
il_ocr_id = lstr_parm.l_wf_id
il_app_id = lstr_parm.l_doc_id

gnv_appeondb.of_startqueue( )
dw_tables.retrieve(il_ocr_id)
dw_fields.retrieve(il_ocr_id)
gnv_appeondb.of_CommitQueue( )

dw_detail.of_SetDropDownCalendar( true )
of_create_appfile(il_app_id)

//---------Begin Added by (Appeon)Stephen 08.07.2014 for BugH072401--------
IF w_mdi.of_security_access( 6928 ) = 0 THEN
	cb_imp.enabled = False
ELSE
	cb_imp.enabled = true
end if
//---------End Added ------------------------------------------------------

dw_fields.modify("key_values.tabsequence='0'")
postevent("ue_postopen")  //(Appeon)Stephen 08.07.2014 - BugL071404
end event

event close;destroy inv_data_entry 
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
uo_ocr.width = newwidth - dw_detail.width - 50
uo_ocr.height = newheight - 230
dw_fields.height = uo_ocr.height - dw_detail.height - dw_tables.height - 15 
uo_ocr.ole_image_ocr.width = uo_ocr.width
uo_ocr.ole_image_ocr.height = uo_ocr.height
end event

event closequery;//====================================================================
//$<Event>: closequery
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.10.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_ret

if dw_fields.modifiedcount() > 0 then
	li_ret = messagebox("Prompt", "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	if li_ret = 1 then
		if cb_save.triggerevent(clicked!) = 1 then return 0
	end if
	if li_ret = 2 then return 0
	return 1
end if

return 0
end event

type uo_ocr from uo_image_ocr within w_ocr_data_setup
event destroy ( )
integer x = 2478
integer y = 176
integer width = 1595
integer height = 1116
integer taborder = 180
end type

on uo_ocr.destroy
call uo_image_ocr::destroy
end on

type pb_zoomout from picturebutton within w_ocr_data_setup
integer x = 3237
integer y = 52
integer width = 114
integer height = 96
integer taborder = 130
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

type pb_zoomin from picturebutton within w_ocr_data_setup
integer x = 3122
integer y = 52
integer width = 114
integer height = 96
integer taborder = 110
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

type dw_properties from u_dw within w_ocr_data_setup
boolean visible = false
integer x = 1673
integer y = 16
integer width = 457
integer height = 164
integer taborder = 40
string dataobject = "d_sys_field_properties"
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

type cb_2 from commandbutton within w_ocr_data_setup
integer x = 1769
integer y = 52
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OCR &Test"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.10.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_path

//---------Begin Commented by (Appeon)Stephen 10.17.2014 for BugA101006--------
/*
if dw_fields.modifiedcount() > 0 then
	messagebox("Prompt", "You have unsaved changes. Please save your changes first!")
	return
end if
*/
//---------End Commented ------------------------------------------------------

if dw_tables.rowcount() < 1 then	return //(Appeon)Stephen 08.07.2014 - BugH072402

ls_path = gs_temp_path +"ocr_imp\"
if not DirectoryExists(ls_path) then CreateDirectory(ls_path)
ls_path = ls_path + "ocr_imp_"+string(il_ocr_id) +".txt"

if not fileexists(is_app_path) then return -1
dw_fields.setredraw(false)  //(Appeon)Stephen 10.20.2014 - BugA101105
uo_ocr.ole_image_ocr.of_create_ocr_file(dw_fields, ls_path, is_app_path, il_ocr_id, true)
of_page_draw()
dw_fields.setredraw(true)   //(Appeon)Stephen 10.20.2014 - BugA101105


end event

type cb_imp from commandbutton within w_ocr_data_setup
integer x = 2121
integer y = 52
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Import Setup"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.10.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_imp_id, li_max_imp
integer li_ret
string ls_path, ls_ocr_name, ls_import_name
datetime ldt_today
str_parm lstr_ocr

//---------Begin Commented by (Appeon)Stephen 10.17.2014 for BugA101003--------
/*if ib_ocr_modify = true then
	messagebox("Prompt", "You have unsaved changes. Please save your changes first!")
	return -1
end if
*/
//---------End Commented ------------------------------------------------------
gnv_appeondb.of_startqueue( )
select ocr_name into :ls_ocr_name from ocr_appl where ocr_id = :il_ocr_id using sqlca;
select max(import_id) into :li_max_imp from import_hdr using sqlca;
select import_id into :ll_imp_id from import_hdr where import_id in(select import_id from ocr_appl where ocr_id = :il_ocr_id) using sqlca;
gnv_appeondb.of_commitqueue( )	

ls_path = gs_temp_path +"ocr_imp\"
if not DirectoryExists(ls_path) then CreateDirectory(ls_path)
ls_path = ls_path + "ocr_imp_"+string(il_ocr_id) +".txt"
		
if  not FileExists(ls_path) then //(Appeon)Stephen 10.17.2014 - BugA101003
	li_ret = messagebox("Prompt", "The OCR test file is not created. Do you want to generate an OCR test file as the import file?",question!, yesno!, 1)
	if li_ret = 1 then
		if not fileexists(is_app_path) then return -1
		if dw_tables.rowcount() < 1 then	return //(Appeon)Stephen 08.07.2014 - BugH072402		

		uo_ocr.ole_image_ocr.of_create_ocr_file(dw_fields, ls_path, is_app_path, il_ocr_id, false)
		of_page_draw()
	end if
end if

ldt_today = datetime(today(), now())
if isnull(ll_imp_id) or ll_imp_id = 0 then  //new import
	li_ret = messagebox("Prompt", "Do you want to create corresponding import information for the current record?",question!, yesno!, 1)
	if li_ret = 1 then
		 ls_import_name = "ocr_imp_" + ls_ocr_name
		insert into import_hdr(import_name, imp_file, imp_format, ignore_header_row, flat_multi, isoft_module, create_date, mod_user, add_protocol, err_notify, err_process, err_file,
												  update_verifications, field_audit, sort_order)
					values(:ls_import_name, :ls_path, '1', 1, 1, 1, :ldt_today, :gs_user_id, 1, 1, 1, 1, 
							1, 1, 2) using sqlca;
		 select import_id into :ll_imp_id from import_hdr where import_name = :ls_import_name and imp_file = :ls_path and import_id > :li_max_imp using sqlca;
		 if not isnull(ll_imp_id) then
			update ocr_appl set import_id = :ll_imp_id where ocr_id = :il_ocr_id using sqlca;
		end if
	end if
else
//	update import_hdr set imp_file = :ls_path, mod_date = :ldt_today, mod_user = :gs_user_id where import_id = :ll_imp_id using sqlca; //Commented by (Appeon)Stephen 10.17.2014 - BugA101003
end if

ib_ocr_modify = false
if not isnull(ll_imp_id) then
	lstr_ocr.s_type = "ocr_image"
	lstr_ocr.l_view_id = ll_imp_id
	OpenSheetwithparm(w_import_painter, lstr_ocr, w_mdi, 4, Original!)
end if

return 1
end event

type sle_cur_page from singlelineedit within w_ocr_data_setup
boolean visible = false
integer x = 2313
integer y = 44
integer width = 242
integer height = 92
integer taborder = 210
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

type sle_page from singlelineedit within w_ocr_data_setup
integer x = 2926
integer y = 60
integer width = 174
integer height = 80
integer taborder = 100
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

type cb_goto from commandbutton within w_ocr_data_setup
integer x = 2747
integer y = 52
integer width = 174
integer height = 92
integer taborder = 90
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

type cb_next from commandbutton within w_ocr_data_setup
integer x = 2633
integer y = 52
integer width = 101
integer height = 92
integer taborder = 80
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

type cb_pro from commandbutton within w_ocr_data_setup
integer x = 2523
integer y = 52
integer width = 101
integer height = 92
integer taborder = 70
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

type cb_save from commandbutton within w_ocr_data_setup
integer x = 3835
integer y = 52
integer width = 343
integer height = 92
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.09.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_ocr_filed
long ll_row
integer li_ret
dwitemstatus lds_new

if isnull(il_ocr_id) then return -1
dw_fields.setfilter("")
dw_fields.filter()
select max(Ocr_field_id) into :ll_ocr_filed from ocr_appl_fields using sqlca;
if isnull(ll_ocr_filed) then ll_ocr_filed = 0
for ll_row = 1 to dw_fields.rowcount()
	lds_new = dw_fields.getitemstatus(ll_row, 0, primary!)
	if lds_new = new! or lds_new = newmodified! then
		ll_ocr_filed +=1
		dw_fields.setitem(ll_row, "ocr_field_id", ll_ocr_filed)
	end if
next

dw_fields.accepttext()
if dw_fields.update() <> 1 then
	rollback using sqlca;
	return -1
else
	commit using sqlca;
end if

if not(isnull(is_filter) or is_filter = "") then
	dw_fields.setfilter(is_filter)
	dw_fields.filter()
end if

//---------Begin Commented by (Appeon)Stephen 10.17.2014 for BugA101003--------
/*
if ib_ocr_modify = true and cb_imp.enabled = true then
	ib_ocr_modify = false
	if dw_tables.rowcount() < 1 then	return //(Appeon)Stephen 08.07.2014 - BugH072402

	li_ret = messagebox("Prompt", "Do you want to update the associated import settings?", exclamation!, YesNo!, 1)	
	if li_ret = 1 then
		if cb_imp.triggerevent(clicked!) <> 1 then return -1		
	end if
end if
*/
//---------End Commented ------------------------------------------------------

ib_ocr_modify = false

return 1
end event

type cb_close from commandbutton within w_ocr_data_setup
integer x = 4183
integer y = 52
integer width = 343
integer height = 92
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type ole_admin from olecustomcontrol within w_ocr_data_setup
event filepropertiesclose ( )
boolean visible = false
integer x = 2565
integer y = 172
integer width = 187
integer height = 112
integer taborder = 190
borderstyle borderstyle = stylelowered!
string binarykey = "w_ocr_data_setup.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_view from commandbutton within w_ocr_data_setup
integer x = 1033
integer y = 52
integer width = 361
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Change &View"
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

Integer li_pos
String ls_msg
String ls_data_view_name

Openwithparm( w_select_view, il_data_view_id )  //(Appeon)Stephen 08.20.2014 - BugH072103
IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	ls_msg = Message.StringParm
	li_pos = PosA( ls_msg, '~t' )
	il_data_view_id = Long( LeftA( ls_msg, li_pos - 1 ) ) 
	ls_data_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )
END IF

of_init(il_data_view_id)


end event

type dw_detail from u_dw within w_ocr_data_setup
integer x = 23
integer y = 176
integer width = 2446
integer height = 1512
integer taborder = 170
string dragicon = "droparrow.ico"
boolean hscrollbar = true
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
This.of_SetRowManager( TRUE )
This.of_SetReqColumn(false)
This.of_SetUpdateAble( False )
end event

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.03.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if dwo.type = "column" then
	is_drag_field_name = dwo.name
	this.Drag(Begin!)	
else
	is_drag_field_name = ""
end if
end event

event doubleclicked;call super::doubleclicked;//====================================================================
//$<Event>: doubleclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.10.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if dwo.type = "column" then
	is_drag_field_name = dwo.name	
	of_add_field()
else
	is_drag_field_name = ""
end if
end event

type dw_screen from u_dw within w_ocr_data_setup
integer x = 37
integer y = 48
integer width = 946
integer height = 92
integer taborder = 10
string dataobject = "d_qk_export_screen"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long li_col_cnt,i
int li_mes
string ls_screen_name
datawindowchild dwchild

this.getchild( "screen_id", dwchild )
dwchild.selectrow(0, false)
dwchild.selectrow(row, false)

parent.setredraw( false)
il_screen_id = long(data)
//---------Begin Modified by (Appeon)Stephen 2014-11-11 for testing bug #4289 OCR drag-drop issue--------
//il_table_id = dwchild.getitemnumber(dwchild.getrow(), "table_id")
if il_screen_id = 1 then
	il_table_id = 25
else
	il_table_id = dwchild.getitemnumber(dwchild.getrow(), "table_id")
end if
//---------End Modfiied ------------------------------------------------------

of_create_dynamic_dw(il_screen_id)
dw_properties.Retrieve(il_data_view_id,il_screen_id)
parent.setredraw( true)

end event

type dw_fields from datawindow within w_ocr_data_setup
integer x = 23
integer y = 2068
integer width = 2446
integer height = 504
integer taborder = 220
string title = "none"
string dataobject = "d_ocr_appl_fields"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event dragdrop;//====================================================================
//$<Event>: dragdrop
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.03.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
of_add_field()
end event

event rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.05.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if currentrow < 1 then return
this.setrow(currentrow)
this.selectrow(0, false)
this.selectrow(currentrow, true)
of_set_curr_draw(currentrow)  //(Appeon)Stephen 10.23.2014 - BugA101103
end event

event buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.09.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_ocr_text
integer li_page, li_cur_page
long ll_left, ll_top, ll_width, ll_height

if row < 1 then return
il_left     = uo_ocr.il_left
il_top     = uo_ocr.il_top
il_width  = uo_ocr.il_width
il_height =  uo_ocr.il_height
if isnull(il_width) or il_width = 0 then return

if dwo.name = "b_map" then
	li_page = integer(sle_cur_page.text)	
	//---------Begin Added by (Appeon)Stephen 10.21.2014 for BugA101104--------
	this.accepttext()
	li_cur_page = this.getitemnumber(row, "page_no")
	ll_left = this.getitemnumber(row, "x_pos")
	ll_top = this.getitemnumber(row, "y_pos")
	ll_width = this.getitemnumber(row, "x_width")
	ll_height = this.getitemnumber(row, "y_height")
	if li_cur_page <> li_page or ll_left <> il_left or ll_top <> il_top or il_width <> ll_width or ll_height <> il_height or isnull(ll_width) or ll_width = 0 then 
	//---------End Added ------------------------------------------------------
		this.setitem(row, "page_no", li_page)
		this.setitem(row, "x_pos", il_left)
		this.setitem(row, "y_pos", il_top)
		this.setitem(row, "x_width", il_width)
		this.setitem(row, "y_height", il_height)
		ls_ocr_text = uo_ocr.ole_image_ocr.of_ocr_data(il_left, il_top, il_width, il_height)
		this.setitem(row, "key_values", ls_ocr_text)
		uo_ocr.ole_image_ocr.of_ClearDrawFillRectangle()	
		uo_ocr.ole_image_ocr.of_drawrectangle(il_left, il_top, il_width, il_height,5,0, rgb(255,255,0), 255, True)
		ib_ocr_modify = true
	end if
end if
end event

event doubleclicked;//====================================================================
//$<Event>: doubleclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.10.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_screen_id, ll_record_id
integer li_find, li_row

if row < 1 then return
if MessageBox("Prompt","Are you sure you want to delete the record?",Question!,YesNo!) = 1  then
	ll_screen_id = this.getitemnumber(row, "screen_id")
	ll_record_id = this.getitemnumber(row, "record_id")	
	deleterow(row)
	li_find = this.find("screen_id = " +string(ll_screen_id) +" and record_id = " +string(ll_record_id), 1, this.rowcount())
	if li_find < 1 then
		li_find = dw_tables.find("ocr_appl_fields_record_id = " +string(ll_record_id) +" and ocr_appl_fields_screen_id = " + string(ll_screen_id), 1, dw_tables.rowcount())
		if li_find > 0 then
			dw_tables.deleterow(li_find)
			li_row = dw_tables.getrow()
			if li_row > 0 then  //(Appeon)Stephen 08.20.2014 - BugH081504
				dw_tables.event rowfocuschanged(li_row)
			end if
		end if
	end if
	ib_ocr_modify = true
end if

//---------Begin Added by (Appeon)Stephen 10.23.2014 for BugA101103--------
li_row = this.getrow()
if li_row > 0 and li_row = row then
	this.event rowfocuschanged(li_row)
end if
//---------End Added ------------------------------------------------------

end event

type dw_tables from datawindow within w_ocr_data_setup
integer x = 23
integer y = 1704
integer width = 2446
integer height = 356
integer taborder = 200
string title = "none"
string dataobject = "d_ocr_record_id"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.05.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_table_id, ll_screen_id

if currentrow < 1 then return
ii_cur_record = this.getitemnumber(currentrow, "ocr_appl_fields_record_id")
ll_table_id = this.getitemnumber(currentrow, "ocr_appl_fields_table_id") 
ll_screen_id = this.getitemnumber(currentrow, "ocr_appl_fields_screen_id") 
if isnull(ii_cur_record) then return
this.selectrow(0, false)
this.selectrow(currentrow, true)
is_filter = "record_id = "+string(ii_cur_record) + " and screen_id =" + string(ll_screen_id)
dw_fields.setfilter(is_filter)
dw_fields.filter()

//---------Begin Added by (Appeon)Stephen 10.17.2014 for BugA101102--------
if dw_fields.rowcount() > 0 then
	dw_fields.selectrow(0, false)
	dw_fields.selectrow(1, true)
	dw_fields.event rowfocuschanged(1)
end if
//---------End Added ------------------------------------------------------
end event

type gb_2 from groupbox within w_ocr_data_setup
integer x = 23
integer width = 1006
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Screen"
end type

type gb_1 from groupbox within w_ocr_data_setup
integer x = 2478
integer width = 891
integer height = 160
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16774640
string text = "Page"
end type

type uo_app from pfc_cst_u_create_app2 within w_ocr_data_setup
boolean visible = false
integer x = 1851
integer width = 754
integer height = 196
integer taborder = 140
end type

on uo_app.destroy
call pfc_cst_u_create_app2::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Aw_ocr_data_setup.bin 
2A00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005871d01001d10c1700000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000005871d01001d10c175871d01001d10c17000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
29ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020206009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000043d00000003000002e50000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000043d000002e5000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Aw_ocr_data_setup.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
