$PBExportHeader$w_contract_data_views_manager.srw
forward
global type w_contract_data_views_manager from w_sheet
end type
type cb_renameview from u_cb within w_contract_data_views_manager
end type
type cb_tabprop from u_cb within w_contract_data_views_manager
end type
type cb_8 from commandbutton within w_contract_data_views_manager
end type
type cb_7 from commandbutton within w_contract_data_views_manager
end type
type cb_6 from commandbutton within w_contract_data_views_manager
end type
type cb_5 from commandbutton within w_contract_data_views_manager
end type
type cb_4 from commandbutton within w_contract_data_views_manager
end type
type cb_3 from commandbutton within w_contract_data_views_manager
end type
type cb_2 from commandbutton within w_contract_data_views_manager
end type
type cb_1 from commandbutton within w_contract_data_views_manager
end type
type tv_selected from u_contract_screen within w_contract_data_views_manager
end type
type tv_available from u_contract_screen within w_contract_data_views_manager
end type
type cb_copyscreen from u_cb within w_contract_data_views_manager
end type
type cb_add from u_cb within w_contract_data_views_manager
end type
type cb_createview from u_cb within w_contract_data_views_manager
end type
type cb_copyview from u_cb within w_contract_data_views_manager
end type
type cb_save from u_cb within w_contract_data_views_manager
end type
type cb_close from u_cb within w_contract_data_views_manager
end type
type cb_remove from u_cb within w_contract_data_views_manager
end type
type cb_deleteview from u_cb within w_contract_data_views_manager
end type
type dw_view from u_dw within w_contract_data_views_manager
end type
type gb_view from groupbox within w_contract_data_views_manager
end type
type gb_available from groupbox within w_contract_data_views_manager
end type
type gb_selected from groupbox within w_contract_data_views_manager
end type
end forward

global type w_contract_data_views_manager from w_sheet
integer width = 3986
integer height = 2228
string title = "Contract View Painter"
windowstate windowstate = maximized!
long backcolor = 33551856
cb_renameview cb_renameview
cb_tabprop cb_tabprop
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
tv_selected tv_selected
tv_available tv_available
cb_copyscreen cb_copyscreen
cb_add cb_add
cb_createview cb_createview
cb_copyview cb_copyview
cb_save cb_save
cb_close cb_close
cb_remove cb_remove
cb_deleteview cb_deleteview
dw_view dw_view
gb_view gb_view
gb_available gb_available
gb_selected gb_selected
end type
global w_contract_data_views_manager w_contract_data_views_manager

type variables
long il_data_view_id = 1001
boolean ib_New = false
boolean ib_Alias = false
boolean ib_Selected
end variables

forward prototypes
public function integer of_retrieveselectedscreen (long al_view_id)
public function integer of_getviewname (ref string as_data_view_name)
public function long of_getnewviewid ()
public function integer of_createview (long al_data_view_id, string as_data_view_name)
public subroutine of_filter_source ()
end prototypes

public function integer of_retrieveselectedscreen (long al_view_id);long ll_Row
long ll_RowCount
string ls_tab_name

// Create selected screens view with view id
tv_selected.of_Retrieve(al_view_id)
tv_selected.ids_data.SetFilter("")
tv_selected.ids_data.Filter()

// Set selected picture of item for available screen view
tv_available.SetRedraw(false)
tv_available.of_ResetSelectedPicture()
for ll_Row = 1 to tv_selected.ids_data.RowCount()
	ls_tab_name = tv_selected.ids_data.object.tab_name[ll_Row]
	tv_available.of_SetSelectedPicture(ls_tab_name, true)
next
tv_available.SetRedraw(true)

// Reset instance variables
ib_New = false
ib_Alias = false

Return 1
end function

public function integer of_getviewname (ref string as_data_view_name);// Get view name
OpenWithParm(w_get_view_name, "C")
as_data_view_name = Message.StringParm

if lower(as_data_view_name) = "cancel" then
	Return -1
else
	Return 1
end if
end function

public function long of_getnewviewid ();long ll_data_view_id

SELECT max(data_view_id) INTO :ll_data_view_id FROM data_view;
if IsNull(ll_data_view_id) then ll_data_view_id = 0
ll_data_view_id ++

Return ll_data_view_id
end function

public function integer of_createview (long al_data_view_id, string as_data_view_name);// Insert a data view record
INSERT INTO data_view(data_view_id, data_view_name, type, type_c)
       VALUES(:al_data_view_id, :as_data_view_name, 'S', 'C');
		 
if SQLCA.SQLCode = 0 then	
	Return 1
else
	Return -1
end if
end function

public subroutine of_filter_source ();//
string	ls_filter=""
long	ll_i,ll_find,ll_count1,ll_count2
long	ll_screenid
long	i,ll_Row,ll_RowCount,ll_pos
boolean lb_Exists
long ll_TabPagCount
string ls_tab_name
string ls_tab_name_arr[]
string ls_tab_lable_arr[]
long ll_Handle
long ll_FirstHandle

ll_count1=tv_available.ids_data.rowcount()
ll_count2=tv_selected.ids_data.rowcount()

for ll_i=1 to ll_count1
	ll_screenid=tv_available.ids_data.getitemnumber(ll_i,"screen_id")
	ll_find=tv_selected.ids_data.find("screen_id="+string(ll_screenid),1,ll_count2)
	if ll_find>0 then
		if ls_filter="" then
			ls_filter="screen_id <> "+string(ll_screenid)
		else
			ls_filter=ls_filter+" and screen_id <> "+string(ll_screenid)
		end if
	end if
next

tv_available.ids_data.setfilter(ls_filter)
tv_available.ids_data.filter()
ll_RowCount = tv_available.ids_data.rowcount()

// Delete all items
tv_available.SetRedraw(false)
tv_available.of_DeleteAll()

// Get tab page names
for ll_Row = 1 to ll_RowCount	
	lb_Exists = false
	ll_TabPagCount = UpperBound(ls_tab_name_arr[])
	ls_tab_name = tv_available.ids_data.GetItemString(ll_Row, "tab_name")	
	if ls_tab_name = 'tabpage_qrg' then continue //Remove qrg tab - jervis 06.01.2011
	for i = 1 to ll_TabPagCount
		if ls_tab_name = ls_tab_name_arr[i] then
			lb_Exists = true
			exit
		end if
	next
	if not lb_Exists then
		ll_TabPagCount ++
		ls_tab_name_arr[ll_TabPagCount] = ls_tab_name
		ls_tab_lable_arr[ll_TabPagCount] = tv_available.ids_data.GetItemString(ll_Row, "screen_name")
		ll_Pos = Pos(ls_tab_lable_arr[ll_TabPagCount], "->")
		ls_tab_lable_arr[ll_TabPagCount] = Left(ls_tab_lable_arr[ll_TabPagCount], ll_Pos - 1)
		if Trim(ls_tab_lable_arr[ll_TabPagCount]) = "" then
			ls_tab_lable_arr[ll_TabPagCount] = ls_tab_name
		end if
	end if
next

// Create screen tree view
for i = 1 to ll_TabPagCount	
	// Insert folder item
	ll_Handle = tv_available.of_InsertFolder(0, ls_tab_name_arr[i], ls_tab_lable_arr[i])
	if i = 1 then ll_FirstHandle = ll_Handle
	
	// Create all screen items by expand all method
	tv_available.ExpandAll(ll_Handle)	
next
tv_available.SelectItem(ll_FirstHandle)
tv_available.SetRedraw(true)
//
tv_available.ids_data.setfilter("")
tv_available.ids_data.filter()


end subroutine

on w_contract_data_views_manager.create
int iCurrent
call super::create
this.cb_renameview=create cb_renameview
this.cb_tabprop=create cb_tabprop
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.tv_selected=create tv_selected
this.tv_available=create tv_available
this.cb_copyscreen=create cb_copyscreen
this.cb_add=create cb_add
this.cb_createview=create cb_createview
this.cb_copyview=create cb_copyview
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_remove=create cb_remove
this.cb_deleteview=create cb_deleteview
this.dw_view=create dw_view
this.gb_view=create gb_view
this.gb_available=create gb_available
this.gb_selected=create gb_selected
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_renameview
this.Control[iCurrent+2]=this.cb_tabprop
this.Control[iCurrent+3]=this.cb_8
this.Control[iCurrent+4]=this.cb_7
this.Control[iCurrent+5]=this.cb_6
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.tv_selected
this.Control[iCurrent+12]=this.tv_available
this.Control[iCurrent+13]=this.cb_copyscreen
this.Control[iCurrent+14]=this.cb_add
this.Control[iCurrent+15]=this.cb_createview
this.Control[iCurrent+16]=this.cb_copyview
this.Control[iCurrent+17]=this.cb_save
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.cb_remove
this.Control[iCurrent+20]=this.cb_deleteview
this.Control[iCurrent+21]=this.dw_view
this.Control[iCurrent+22]=this.gb_view
this.Control[iCurrent+23]=this.gb_available
this.Control[iCurrent+24]=this.gb_selected
end on

on w_contract_data_views_manager.destroy
call super::destroy
destroy(this.cb_renameview)
destroy(this.cb_tabprop)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.tv_selected)
destroy(this.tv_available)
destroy(this.cb_copyscreen)
destroy(this.cb_add)
destroy(this.cb_createview)
destroy(this.cb_copyview)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_remove)
destroy(this.cb_deleteview)
destroy(this.dw_view)
destroy(this.gb_view)
destroy(this.gb_available)
destroy(this.gb_selected)
end on

event open;call super::open;// Create both available and selected screen view

long ll_view_id = 1001

tv_available.of_Retrieve(1001)

//Added By Ken.Guo 2009-09-09.
If isvalid(w_contract_data_design) Then
	ll_view_id = w_contract_data_design.uo_design.il_data_view
End If

dw_view.Event ue_SetItem(ll_view_id)
end event

event closequery;call super::closequery;//Inhert
if tv_selected.of_IsChanged() then
	if MessageBox("Save", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if	
end if
end event

event pfc_preopen;call super::pfc_preopen;//Inherit
this.of_SetResize(true)
inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
inv_resize.of_SetMinSize(this.WorkSpaceWidth(),this.WorkSpaceHeight())

inv_resize.of_Register(gb_view, inv_resize.SCALERIGHT)
inv_resize.of_Register(gb_available, 0 ,0, 50, 100)
inv_resize.of_Register(tv_available, 0 ,0, 50, 100)
inv_resize.of_Register(gb_selected, 50 ,0, 50, 100)
inv_resize.of_Register(tv_selected, 50 ,0, 50, 100)
inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHT)

inv_resize.of_Register(cb_add, 50, 50, 0, 0)
inv_resize.of_Register(cb_remove, 50, 50, 0, 0)

inv_resize.of_Register(cb_1, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_2, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_3, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_4, inv_resize.FIXEDBOTTOM)

inv_resize.of_Register(cb_5, 50, 100, 0, 0)
inv_resize.of_Register(cb_6, 50, 100, 0, 0)
inv_resize.of_Register(cb_7, 50, 100, 0, 0)
inv_resize.of_Register(cb_8, 50, 100, 0, 0)
end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-05-20 By: Ken.Guo
//$<reason> Use default menu
long ll_handle
If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then 
	ll_handle = handle(w_mdi)
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu )
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	w_mdi.of_menu_security( w_mdi.MenuName )
	gnv_appeondll.of_settoolbarpos(ll_handle)
End If
//---------------------------- APPEON END ----------------------------
end event

type cb_renameview from u_cb within w_contract_data_views_manager
integer x = 1701
integer y = 84
integer width = 375
integer height = 84
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Re&name View"
end type

event clicked;call super::clicked;//====================================================================
// Event: clicked
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/27/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string 		ls_data_view_name
Long			ll_ret = 0

// Return if data have been changed
if tv_selected.of_IsChanged() then
	MessageBox("Save", "You must save data before copying a view.", Exclamation!)
	Return
end if

// Determine if delete selected view
IF il_data_view_id = 1001 THEN
	MessageBox("Rename View", "The default system view can't be Rename.", Exclamation!)
	Return
END IF

// Create screen view
if of_GetViewName(ls_data_view_name) = -1 then Return

Update data_view
Set data_view_name = :ls_data_view_name
Where data_view_id = :il_data_view_id
Using Sqlca;

IF SQLCA.SQLcode = 0 Then
	Commit Using sqlca;
Else
	Rollback Using Sqlca;
End IF 

// Refresh select view dddw
dw_view.Event ue_dddwrefresh(il_data_view_id)
end event

type cb_tabprop from u_cb within w_contract_data_views_manager
integer x = 2779
integer y = 84
integer width = 389
integer height = 84
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Tab Properties"
end type

event clicked;call super::clicked;integer li_Pos
string  ls_text
long    ll_text_color
string  ls_icon_visible
string  ls_Message
TreeViewItem ltvi_item

// Return if data have been changed
if tv_selected.of_IsChanged() then
	MessageBox("Save", "You must save data before setting tab properties.", Exclamation!)
	Return
end if

//Modify by jervis 09.11.2009
//Move to u_contract_screen.of_setview_properties() 
tv_selected.of_setview_properties( il_data_view_id)
/*
// Determine if set tab page properties
if tv_selected.GetItem(tv_selected.il_CurrentHandle, ltvi_item) = -1 then
	MessageBox("Tab Properties", "No tab page can be set.")
	Return
end if
if ltvi_item.PictureIndex <> 1 then
	MessageBox("Tab Properties", "Please select a folder item (not a screen item) from Selected Screens.")
	tv_selected.SetFocus()
	Return
end if

// Open tab page properties window
ls_Message = String(il_data_view_id) + "|" + ltvi_item.Data + "|" + ltvi_item.Label
OpenWithParm(w_contract_tabprop_edit, ls_Message)

// Refresh folder item
ls_Message = Message.StringParm
if ls_Message = "cancel!" then Return
li_Pos = Pos(ls_Message, "|")
ls_text = Left(ls_Message, li_Pos - 1)
ls_Message = Right(ls_Message, Len(ls_Message) - li_Pos)
li_Pos = Pos(ls_Message, "|")
ll_text_color = Long(Left(ls_Message, li_Pos - 1))
ls_icon_visible = Right(ls_Message, Len(ls_Message) - li_Pos)

ltvi_item.Label = ls_text
tv_selected.SetItem(tv_selected.il_CurrentHandle, ltvi_item)
*/
end event

type cb_8 from commandbutton within w_contract_data_views_manager
integer x = 2656
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "- All"
end type

event clicked;tv_selected.of_CollapseAll()
end event

type cb_7 from commandbutton within w_contract_data_views_manager
integer x = 2496
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+ All"
end type

event clicked;tv_selected.of_ExpandAll()
end event

type cb_6 from commandbutton within w_contract_data_views_manager
integer x = 2336
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "-"
end type

event clicked;tv_selected.CollapseItem(tv_selected.il_CurrentHandle)
end event

type cb_5 from commandbutton within w_contract_data_views_manager
integer x = 2176
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+"
end type

event clicked;tv_selected.ExpandItem(tv_selected.il_CurrentHandle)
end event

type cb_4 from commandbutton within w_contract_data_views_manager
integer x = 512
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "- All"
end type

event clicked;tv_available.of_CollapseAll()
end event

type cb_3 from commandbutton within w_contract_data_views_manager
integer x = 352
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+ All"
end type

event clicked;tv_available.of_ExpandAll()
end event

type cb_2 from commandbutton within w_contract_data_views_manager
integer x = 192
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "-"
end type

event clicked;tv_available.CollapseItem(tv_available.il_CurrentHandle)
end event

type cb_1 from commandbutton within w_contract_data_views_manager
integer x = 32
integer y = 1996
integer width = 165
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+"
end type

event clicked;tv_available.ExpandItem(tv_available.il_CurrentHandle)
end event

type tv_selected from u_contract_screen within w_contract_data_views_manager
integer x = 2181
integer y = 268
integer width = 1719
integer height = 1724
integer taborder = 200
string dragicon = "droparrow.ico"
boolean dragauto = true
borderstyle borderstyle = stylebox!
boolean disabledragdrop = false
end type

event doubleclicked;call super::doubleclicked;cb_remove.post Event Clicked()
end event

event dragdrop;call super::dragdrop;if source.ClassName() = "tv_available" then
	cb_add.Event Clicked()
end if
end event

type tv_available from u_contract_screen within w_contract_data_views_manager
integer x = 37
integer y = 268
integer width = 1719
integer height = 1724
integer taborder = 190
string dragicon = "droparrow.ico"
boolean dragauto = true
borderstyle borderstyle = stylebox!
boolean disabledragdrop = false
end type

event doubleclicked;call super::doubleclicked;cb_add.post Event Clicked()
end event

event dragdrop;call super::dragdrop;if source.ClassName() = "tv_selected" then
	cb_remove.Event Clicked()
end if
end event

event constructor;call super::constructor;// Inhert
of_ShowCustomItemLabel(false)
end event

type cb_copyscreen from u_cb within w_contract_data_views_manager
integer x = 2427
integer y = 84
integer height = 84
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Co&py Screen"
end type

event clicked;call super::clicked;long ll_Return
long ll_screen_id
long ll_old_view_id
long ll_new_view_id
long ll_FindHandle
string ls_tab_name
string ls_folder_name
datetime ldt_modify_date
TreeViewItem ltvi_item

// Return if data have been changed
if tv_selected.of_IsChanged() then
	MessageBox("Save", "You must save data before copy a screen.", Exclamation!)
	Return
end if

// Determine if copy screen
if tv_selected.GetItem(tv_selected.il_CurrentHandle, ltvi_item) = -1 then
	MessageBox("Copy Screen", "No screen can be copy.")
	Return
end if
if ltvi_item.PictureIndex = 1 then
	MessageBox("Copy Screen", "Please select a screen item (not a folder item) from Selected Screens.")
	tv_selected.SetFocus()
	Return
end if

// Open window and get data view id
OpenWithParm(w_contract_copyscreen, ltvi_item.Label)
if Message.StringParm = "cancel!" then Return
ll_new_view_id = Long(Message.StringParm)
ll_old_view_id = il_data_view_id

// Get screen item information
ll_screen_id = ltvi_item.Data
tv_selected.of_GetRootItem(ltvi_item)
ls_tab_name = ltvi_item.Data
ls_folder_name = ltvi_item.Label

// Switch to selected view
tv_selected.SetRedraw(false)
dw_view.Event ue_SetItem(ll_new_view_id)

// Insert screens of specify tab page into Selected Screens if its not exists
if tv_selected.of_Add(ls_tab_name, ls_folder_name, tv_available) = 1 then
	ib_Alias = true
	ll_Return = cb_save.Event Clicked()
	if ll_Return = -1 then
		tv_selected.SetRedraw(true)
		MessageBox("Copy Screen", "Failed to copy screen.", StopSign!)
		Return
	end if
end if

// Update specify screen dw syntax with selected screen dw syntax
// Update specify screen dw syntax with selected screen dw syntax
// Add screen_visible field in ctx_screen - jervis 09.19.2010
ldt_modify_date = DateTime(Today(), Now())
gnv_appeondb.of_startqueue()
delete ctx_screen_field_ex where data_view_id = :ll_new_view_id and screen_id = :ll_screen_id;
delete ctx_screen_field_depend where view_id = :ll_new_view_id and base_screen_id = :ll_screen_id;
delete ctx_screen_datafill where data_view_id = :ll_new_view_id and screen_id = :ll_screen_id;
DELETE ctx_screen WHERE data_view_id = :ll_new_view_id and screen_id = :ll_screen_id;

//added by gavins 20120417
delete  from conv_view_pic where view_id = :ll_new_view_id and pic_type = 'screen' and screen_id = :ll_screen_id;

//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
//added by gavins 20130418
insert into conv_view_pic ( view_id
      ,Screen_id
      ,pic_type
      ,pic_band
      ,pic_name
      ,pic_filename
      ,pic_bitmap
      ,pic_x
      ,pic_y
      ,pic_width
      ,pic_height
      ,pic_tag )
       select :ll_new_view_id,
			 screen_id, 
			 pic_type,
			 pic_band, 
			 pic_name, 
			  substring( pic_filename,1,2 ) + cast( :ll_new_view_id as varchar(10))  + '_' + cast( screen_id as varchar(10)) +
		   substring( pic_filename, charindex( '_',pic_filename, charindex( '_',pic_filename, 3 ) + 1 ),len(pic_filename) - charindex( '_',pic_filename, charindex( '_',pic_filename, 3 ) ) - 5 )+ convert(varchar(10),DATEPART( ms,getdate())) + right(pic_filename,4 )
		     ,pic_bitmap
			  ,pic_x
			  ,pic_y
			  ,pic_width
			  ,pic_height
			  ,pic_tag  
			  from conv_view_pic where view_id = :ll_old_view_id and screen_id = :ll_screen_id and pic_type = 'screen';
//---------End Added ------------------------------------------------------

INSERT INTO ctx_screen(data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date,force_update,titlebar_visible,titlebar_text,boarder_style,screen_visible, screen_style, grid_sql, grid_dataobject, grid_modify)
	SELECT :ll_new_view_id,:ll_screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,:ldt_modify_date,force_update,titlebar_visible,titlebar_text,boarder_style,screen_visible, screen_style, grid_sql, grid_dataobject, grid_modify 
	FROM ctx_screen
	WHERE data_view_id = :ll_old_view_id and screen_id = :ll_screen_id;
	
//Update the Data Fill settings  - jervis 09.19.2010
insert into ctx_screen_datafill
SELECT :ll_new_view_id, :ll_screen_id,   
       field_name,   
        field_name_fill,   
        field_name_map,   
        :gs_user_id,   
        :ldt_modify_date,   
        relative_days  
    FROM ctx_screen_datafill  
   WHERE ( ctx_screen_datafill.data_view_id = :ll_old_view_id ) AND  
         ( ctx_screen_datafill.screen_id = :ll_screen_id );   
//Insert field Depent -- jervis 03.08.2011
insert into ctx_screen_field_depend (view_id
      ,base_field
      ,depend_field
      ,base_screen_id
      ,depend_screen_id
      ,base_field_dispaly
      ,depend_field_dispaly
      ,base_screen_type
      ,base_table
      ,depend_table)
select :ll_new_view_id, base_field
      ,depend_field
      ,:ll_screen_id   
      ,depend_screen_id
      ,base_field_dispaly
      ,depend_field_dispaly
      ,base_screen_type
      ,base_table
      ,depend_table 
from ctx_screen_field_depend where view_id = :ll_old_view_id and base_screen_id =:ll_screen_id ;

/*isnert field extend property*/
insert into dbo.ctx_screen_field_ex (data_view_id
      ,screen_id
      ,field_name
      ,field_add)
select :ll_new_view_id,screen_id
      ,field_name
      ,field_add 
from ctx_screen_field_ex where data_view_id = :ll_old_view_id and screen_id = :ll_screen_id;

//insert field extend property -- jervis 03.08.2011


COMMIT;
gnv_appeondb.of_commitqueue()

// Update field alias
n_cst_update_view_fields_alias lnvo_update
lnvo_update = create n_cst_update_view_fields_alias
lnvo_update.of_update_view_fields_alias(1, il_data_view_id)
destroy lnvo_update

// Locate specify screen item
dw_view.Event ue_SetItem(ll_new_view_id)
ll_FindHandle = tv_selected.of_FindItemWithData(String(ll_screen_id))
tv_selected.SelectItem(ll_FindHandle)
tv_selected.SetFocus()
tv_selected.SetRedraw(true)
end event

type cb_add from u_cb within w_contract_data_views_manager
integer x = 1787
integer y = 1032
integer height = 84
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Add ->"
end type

event clicked;call super::clicked;
long ll_tvi

ll_tvi = tv_available.FindItem(CurrentTreeItem!, 0)  //added by gavins 20120315 grid

If ll_tvi <= 0 Then Return

// Insert selected screens into Selected Screens
tv_selected.of_Add(tv_available)
ib_Alias = true

end event

type cb_createview from u_cb within w_contract_data_views_manager
integer x = 997
integer y = 84
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Create View"
end type

event clicked;call super::clicked;long 		ll_data_view_id
string 	ls_data_view_name

// Return if data have been changed
if tv_selected.of_IsChanged() then
	MessageBox("Save", "You must save data before creating a view.", Exclamation!)
	Return -1
end if

// Create screen view
if of_GetViewName(ls_data_view_name) = -1 then Return
ll_data_view_id = of_GetNewViewID()
if of_CreateView(ll_data_view_id, ls_data_view_name) = -1 then
	MessageBox("Create View", "Failed to create a view.", StopSign!)
	Return
end if

// Refresh select view dddw
dw_view.Event ue_DDDWInsert(ll_data_view_id, ls_data_view_name)

// Screen view must be include Search page
tv_available.SelectItem(tv_available.of_FindItemWithData("tabpage_search"))
tv_selected.of_Add("tabpage_search", "Search", tv_available)
tv_available.SelectItem(tv_available.FindItem(RootTreeItem!,0))

// Reset instance variables
ib_New = true
ib_Alias = true

// Save screen data
cb_save.Event Clicked()
end event

type cb_copyview from u_cb within w_contract_data_views_manager
integer x = 2075
integer y = 84
integer height = 84
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "C&opy View"
end type

event clicked;call super::clicked;long ll_new_view_id
string ls_data_view_name
datetime ldt_modify_date

// Return if data have been changed
if tv_selected.of_IsChanged() then
	MessageBox("Save", "You must save data before copying a view.", Exclamation!)
	Return
end if

// Create screen view
if of_GetViewName(ls_data_view_name) = -1 then Return
ll_new_view_id = of_GetNewViewID()
ldt_modify_date = DateTime(Today(), Now())

gnv_appeondb.of_startqueue()
INSERT INTO data_view(data_view_id, data_view_name, type, type_c)
       VALUES(:ll_new_view_id, :ls_data_view_name, 'S', 'C');

//Added By Ken.Guo 2009-07-10. update window backcolor.
Update data_view Set win_backcolor = (Select win_backcolor from data_view where data_view_id = :il_data_view_id)
Where data_view_id = :ll_new_view_id;
		 
INSERT INTO ctx_tabpage_properties(data_view_id,tabpage_name,text,text_color,icon_visible,icon_update_date,backcolor,tab_backcolor,tab_icon)
	SELECT :ll_new_view_id,tabpage_name,text,text_color,icon_visible,icon_update_date,backcolor,tab_backcolor,tab_icon
	FROM ctx_tabpage_properties
	WHERE data_view_id = :il_data_view_id;

INSERT INTO ctx_screen(data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date,force_update,titlebar_visible,titlebar_text,boarder_style,screen_visible , screen_style, grid_sql, grid_dataobject, grid_modify)
	SELECT :ll_new_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date,force_update,titlebar_visible,titlebar_text,boarder_style,screen_visible , screen_style, grid_sql, grid_dataobject, grid_modify 
	FROM ctx_screen
	WHERE data_view_id = :il_data_view_id;
COMMIT;

//Update the Data Fill settings  - jervis 05.13.2011

insert into ctx_screen_datafill
SELECT :ll_new_view_id, screen_id,   
       field_name,   
        field_name_fill,   
        field_name_map,   
        :gs_user_id,   
        :ldt_modify_date,   
        relative_days  
    FROM ctx_screen_datafill  
   WHERE ( ctx_screen_datafill.data_view_id = :il_data_view_id );
	
//Insert field Depent -- jervis 05.13.2011
insert into ctx_screen_field_depend (view_id
      ,base_field
      ,depend_field
      ,base_screen_id
      ,depend_screen_id
      ,base_field_dispaly
      ,depend_field_dispaly
      ,base_screen_type
      ,base_table
      ,depend_table)
select :ll_new_view_id, base_field
      ,depend_field
      ,base_screen_id   
      ,depend_screen_id
      ,base_field_dispaly
      ,depend_field_dispaly
      ,base_screen_type
      ,base_table
      ,depend_table 
from ctx_screen_field_depend where view_id = :il_data_view_id;

//isnert field extend property --jervis 05.13.2011
insert into dbo.ctx_screen_field_ex (data_view_id
      ,screen_id
      ,field_name
      ,field_add)
select :ll_new_view_id,screen_id
      ,field_name
      ,field_add 
from ctx_screen_field_ex where data_view_id = :il_data_view_id ;

//insert screen pic added by gavins 20120416
insert into conv_view_pic ( view_id
      ,Screen_id
      ,pic_type
      ,pic_band
      ,pic_name
      ,pic_filename
      ,pic_bitmap
      ,pic_x
      ,pic_y
      ,pic_width
      ,pic_height
      ,pic_tag )
       select :ll_new_view_id,
			 screen_id, 
			 pic_type,
			 pic_band, 
			 pic_name, 
			  substring( pic_filename,1,2 ) + cast( :ll_new_view_id as varchar(10))  + '_' + cast( screen_id as varchar(10)) +
		   substring( pic_filename, charindex( '_',pic_filename, charindex( '_',pic_filename, 3 ) + 1 ),99)
		     ,pic_bitmap
			  ,pic_x
			  ,pic_y
			  ,pic_width
			  ,pic_height
			  ,pic_tag  
			  from conv_view_pic where view_id = :il_data_view_id and pic_type = 'screen';
			  
//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
//Added By Jay Chen 02-13-2014 Remark:insert tabpage details layout property
insert into security_viewid_options (view_id ,option_name ,option_value ,last_update ,user_id)
select :ll_new_view_id,
      	option_name,
      	option_value,
		:ldt_modify_date, 
		:gs_user_id
from security_viewid_options 
where view_id = :il_data_view_id ;
//---------End Added ------------------------------------------------------			  

COMMIT;
gnv_appeondb.of_commitqueue()

// Update field alias -- jervis 05.13.2011
n_cst_update_view_fields_alias lnvo_update
lnvo_update = create n_cst_update_view_fields_alias
lnvo_update.of_update_view_fields_alias(1, ll_new_view_id)
destroy lnvo_update


//Added By Ken.Guo 2009-07-10. Refresh data view cache
gnv_data.of_retrieve('data_view')

// Refresh select view dddw
dw_view.Event ue_DDDWInsert(ll_new_view_id, ls_data_view_name)
end event

type cb_save from u_cb within w_contract_data_views_manager
integer x = 3168
integer y = 84
integer height = 84
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;call super::clicked;integer li_rec_id
integer i, li_user_cnt
integer li_access_rights
integer li_Return
string  ls_user_id
string  ls_version
n_ds    lds_users

// Save screen data
li_Return = tv_selected.of_Save(il_data_view_id, tv_available)
if li_Return = -1 then
	MessageBox("Save", "Failed to save.", StopSign!)
	Return -1
elseif li_Return = 0 then
	Return 0
end if

// Delete correlative records from ctx_screen_datafill table
gnv_appeondb.of_startqueue()
delete from ctx_screen_datafill
where data_view_id = :il_data_view_id and
      screen_id not in (select screen_id from ctx_screen where data_view_id = :il_data_view_id);
commit;
gnv_appeondb.of_commitqueue()

// Update field alias
if ib_Alias then
	n_cst_update_view_fields_alias lnvo_update	
	lnvo_update = create n_cst_update_view_fields_alias
	lnvo_update.of_update_view_fields_alias(1, il_data_view_id)
	destroy lnvo_update
end if

// check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
IF appeongetclienttype() = 'PB' THEN
	IF NOT FileExists(gs_IniFilePathName) THEN
		MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
		Return -1
	END IF
END IF
IF ls_version = "None" THEN
	MessageBox("Error", "Version number not setup.")
	RETURN -1
END IF
IF MidA( ls_version, 6, 1) = "7" THEN
	li_access_rights = 0
ELSE
	li_access_rights = 1
END IF

IF ib_new And Not gb_contract_version THEN
	lds_users = CREATE n_ds
	lds_users.DataObject = "d_list_of_users"
	lds_users.SetTransObject( SQLCA )
	li_user_cnt = lds_users.Retrieve( )
	IF li_user_cnt > 0 THEN
		li_rec_id = gnv_app.of_get_id( "user_view_id", li_user_cnt) - 1
	END IF

	gnv_appeondb.of_startqueue( )
	FOR i = 1 TO li_user_cnt
		li_rec_id ++
		ls_user_id = lds_users.GetItemString( i, "user_id" )		
		INSERT INTO security_user_views(user_view_id, user_id, view_id, access_rights)
		       VALUES (:li_rec_id, :ls_user_id, :il_data_view_id, :li_access_rights);
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "Insert Error", SQLCA.SQLERRTEXT )
			Destroy lds_users
			Return -1
		END IF
	END FOR
	COMMIT;
	gnv_appeondb.of_commitqueue( )
	Destroy lds_users
END IF

// Reset instance variables
ib_New = false
ib_Alias = false

Return 1
end event

type cb_close from u_cb within w_contract_data_views_manager
integer x = 3520
integer y = 84
integer height = 84
integer taborder = 180
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Clos&e"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_remove from u_cb within w_contract_data_views_manager
integer x = 1787
integer y = 1204
integer height = 84
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "<- &Remove"
end type

event clicked;call super::clicked;long ll_Exists
string ls_tab_name
TreeViewItem ltvi_item

// Get tab page name
if tv_selected.of_GetRootItem(ltvi_item) = -1 then Return
ls_tab_name = ltvi_item.data

// Determine if can be remove the selected screens
if il_data_view_id = 1001 then
	MessageBox("Remove", "Screens cannot be removed from the default system view.", Exclamation!)
	Return
end if

if Lower(ls_tab_name) = "tabpage_search" then
	MessageBox("Remove", "You can't delete Search screen from the screen list.", Exclamation!)
	Return
end if

if Lower(ls_tab_name) = "tabpage_details" then
	MessageBox("Remove", "You can't delete Details screen from the screen list.", Exclamation!)
	Return
end if

SELECT 1 INTO :ll_Exists
FROM ctx_acp_template_clause_rules
WHERE data_view_id = :il_data_view_id AND
      screen_id in (select screen_id from ctx_screen where data_view_id = :il_data_view_id and tab_name = :ls_tab_name);
if ll_Exists = 1 then
	MessageBox("Remove", "The screens have been used in clause rules and can't be deleted.", Exclamation!)
	Return
end if

//add by jervis 07.11.2011
if MessageBox("Remove","All screen painting will be lost and cannot be restored. ~r~n~r~nAre you sure you want to continue?",Question!,YesNo!,2) = 2 then
	return
end if


// Remove the selected screens
tv_selected.of_Remove(tv_available)
end event

type cb_deleteview from u_cb within w_contract_data_views_manager
integer x = 1349
integer y = 84
integer height = 84
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete View"
end type

event clicked;call super::clicked;integer li_ret1
integer li_ret2
integer li_ret3

// Determine if delete selected view
IF il_data_view_id = 1001 THEN
	MessageBox("Delete View", "The default system view can't be deleted.", Exclamation!)
	Return
END IF

gnv_appeondb.of_startqueue()
SELECT 1 INTO :li_ret1 FROM code_lookup WHERE lookup_name = 'contract category' AND ic_n = :il_data_view_id;
SELECT 1 INTO :li_ret2 FROM security_users WHERE contract_default_view = :il_data_view_id;
SELECT 1 INTO :li_ret3 FROM ctx_acp_template_clause_rules WHERE data_view_id = :il_data_view_id;
gnv_appeondb.of_commitqueue()

IF li_ret1 = 1 THEN
	MessageBox("Delete View", "The view already used in contract category.", Exclamation!)
	Return
END IF
IF li_ret2 = 1 THEN
	MessageBox("Delete View", "The view has already been set to default view in user painter.", Exclamation!)
	Return
END IF
IF li_ret3 = 1 THEN
	MessageBox("Delete View", "The view already used in clause rules.", Exclamation!)
	Return
END IF
li_ret3 = MessageBox("Delete View", "Are you sure you want to delete the selected view?", Question!, YesNo!, 2)
IF li_ret3 = 2 THEN Return

// Delete selected view and correlative records
gnv_appeondb.of_startqueue()
delete from ctx_screen_field_depend where view_id = :il_data_view_id;  //add by jervis 03.07.2011
delete from ctx_tabpage_properties where data_view_id = :il_data_view_id;
delete from ctx_screen_datafill where data_view_id = :il_data_view_id;
delete from ctx_screen where data_view_id = :il_data_view_id;
delete from security_user_views where view_id = :il_data_view_id;
delete from data_view where data_view_id = :il_data_view_id;
delete from view_fields_alias where data_view_id = :il_data_view_id;
 delete from conv_view_pic where view_id = :il_data_view_id and pic_type = 'screen' ; //added by gavins 20120416
 //---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
delete from ctx_screen_field_ex where data_view_id = :il_data_view_id ; 	//Added By Mark Lee 10/18/2013 delete field extend property 
delete from security_viewid_options where view_id = :il_data_view_id; //Added By Jay Chen 02-13-2014
//---------End Added ------------------------------------------------------
commit using sqlca;
gnv_appeondb.of_commitqueue()

// Refresh select view dw
dw_view.Event ue_DDDWDelete(il_data_view_id)
end event

type dw_view from u_dw within w_contract_data_views_manager
event ue_dddwinsert ( long al_data_view_id,  string as_data_view_name )
event ue_setitem ( long al_data_view_id )
event ue_dddwdelete ( long al_data_view_id )
event ue_dddwrefresh ( long al_data_view_id )
integer x = 41
integer y = 80
integer width = 955
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list_contract"
boolean vscrollbar = false
boolean border = false
end type

event ue_dddwinsert(long al_data_view_id, string as_data_view_name);long ll_InsertRow
DataWindowChild ldwc_child

this.GetChild("data_view_id", ldwc_child)

ll_InsertRow = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_InsertRow, "data_view_id", al_data_view_id)
ldwc_child.SetItem(ll_InsertRow, "data_view_name", as_data_view_name)

this.Event ue_SetItem(al_data_view_id)
end event

event ue_setitem(long al_data_view_id);this.SetItem(1, "data_view_id", al_data_view_id)
this.Event ItemChanged(1, this.object.data_view_id, String(al_data_view_id))
end event

event ue_dddwdelete(long al_data_view_id);long ll_FindRow
DataWindowChild ldwc_child

this.GetChild("data_view_id", ldwc_child)

ll_FindRow = ldwc_child.Find("data_view_id=" + String(al_data_view_id), 1, ldwc_child.RowCount())
ldwc_child.DeleteRow(ll_FindRow)

this.Event ue_SetItem(1001)
end event

event ue_dddwrefresh(long al_data_view_id);//====================================================================
// Event: ue_dddwrefresh
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_data_view_id
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/27/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

DataWindowChild ldwc_child

this.GetChild("data_view_id", ldwc_child)
ldwc_child.SetTransObject( Sqlca)
ldwc_child.Retrieve( )

this.Event ue_SetItem(al_data_view_id)
end event

event constructor;// Retrieve views
this.of_SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
this.InsertRow(0)
end event

event itemchanged;call super::itemchanged;il_data_view_id = Long(data)
of_RetrieveSelectedScreen(il_data_view_id)
//Added by Alan on 2008-12-30
of_filter_source()
end event

type gb_view from groupbox within w_contract_data_views_manager
integer x = 23
integer y = 12
integer width = 3881
integer height = 192
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select View"
end type

type gb_available from groupbox within w_contract_data_views_manager
integer x = 23
integer y = 220
integer width = 1742
integer height = 1876
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Available Screens"
end type

type gb_selected from groupbox within w_contract_data_views_manager
integer x = 2167
integer y = 220
integer width = 1742
integer height = 1876
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Selected Screens "
end type

