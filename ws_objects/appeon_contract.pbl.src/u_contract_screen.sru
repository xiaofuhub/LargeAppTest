$PBExportHeader$u_contract_screen.sru
forward
global type u_contract_screen from treeview
end type
end forward

global type u_contract_screen from treeview
integer width = 873
integer height = 712
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!","DataWindow!","DataWindow5!","sectiongreen.bmp"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type
global u_contract_screen u_contract_screen

type variables
long il_CurrentHandle
TreeViewItem itvi_CurrentItem
boolean ib_ShowCustomItemLabel = true

n_ds ids_data, ids_pic
n_ds ids_tabpage_prop
string is_tabpage_prop_sql


String		is_AddOrRemove = ''
end variables

forward prototypes
public function long of_insertfolder (long al_parent, string as_tab_name, string as_label)
public function long of_insertitem (long al_parent, long al_screen_id, string as_label)
public function integer of_deleteall ()
public function integer of_setselectedpicture (long al_handle, boolean ab_flag)
public function integer of_setselectedpicture (string as_tab_name, boolean ab_flag)
public function integer of_resetselectedpicture ()
public function boolean of_ischanged ()
public function integer of_add (string as_tab_name, string as_label, ref u_contract_screen au_available)
public function integer of_getrootitem (long al_handle, ref treeviewitem atvi_item)
public function integer of_getrootitem (ref treeviewitem atvi_item)
public function integer of_add (ref u_contract_screen au_available)
public function long of_getroothandle (long al_handle)
public function integer of_remove (long al_handle, ref u_contract_screen au_available)
public function integer of_remove (ref u_contract_screen au_available)
public function integer of_save (long al_data_view_id, ref u_contract_screen au_available)
public function long of_finditemwithdata (long al_handle, string as_data)
public function long of_finditemwithdata (string as_data)
public function integer of_expandall ()
public function integer of_collapseall (long al_handle)
public function integer of_collapseall ()
public function integer of_getcurrentitem (ref treeviewitem atvi_item)
public function long of_findfirstscreenitem ()
public function integer of_retrieve (long al_data_view_id)
public function string of_gettabpagetext (string as_tabpage_name)
public function string of_getscreentitlebartext (long al_screen_id)
public function integer of_showcustomitemlabel (boolean ib_flag)
public subroutine of_setview_properties (long al_view_id)
public function integer of_add_pic (long al_source_view_id, long al_source_screen_id, long al_target_view_id, long al_target_screen_id)
public function integer of_del_pic (long al_view_id, long al_screen_id)
end prototypes

public function long of_insertfolder (long al_parent, string as_tab_name, string as_label);string ls_Text
TreeViewItem ltvi_Item


// Set folder item peroperties
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 2
ltvi_Item.Data = as_tab_name
ltvi_Item.Children = true

if ib_ShowCustomItemLabel then
	ls_Text = of_GetTabpageText(as_tab_name)
	if Len(ls_Text) > 0 then
		ltvi_Item.Label = ls_Text
	else
		ltvi_Item.Label = as_Label
	end if
else
	ltvi_Item.Label = as_Label
end if

//Begin - Added By Mark Lee 02/05/2013
If as_tab_name = 'tabpage_email' Then 
	ltvi_Item.Children = False
End IF 
//End - Added By Mark Lee 02/05/2013

// Insert screen folder
Return this.InsertItemLast(al_Parent, ltvi_Item)
end function

public function long of_insertitem (long al_parent, long al_screen_id, string as_label);string ls_Text
TreeViewItem ltvi_Item

// Set screen item peroperties
ltvi_Item.PictureIndex = 3
ltvi_Item.SelectedPictureIndex = 4
ltvi_Item.Data = al_screen_id
ltvi_Item.Children = false

if ib_ShowCustomItemLabel then
	ls_Text = of_GetScreenTitlebarText(al_screen_id)
	if Len(ls_Text) > 0 then
		ltvi_Item.Label = ls_Text
	else
		ltvi_Item.Label = as_Label
	end if
else
	ltvi_Item.Label = as_Label
end if

// Insert screen item
Return this.InsertItemLast(al_Parent, ltvi_Item)
end function

public function integer of_deleteall ();long ll_Handle

// Delete all items
do
	ll_Handle = this.FindItem(RootTreeItem!, 0)
	if ll_Handle <> -1 then
		this.DeleteItem(ll_Handle)
	else
		exit
	end if
loop until false

Return 1
end function

public function integer of_setselectedpicture (long al_handle, boolean ab_flag);long ll_FindHandle
TreeViewItem ltvi_Item

// Set picture according to flag
this.GetItem(al_Handle, ltvi_Item)
if ltvi_Item.PictureIndex <> 1 then
	if ab_Flag then
		// Set seletected picture
		ltvi_Item.PictureIndex = 5
		ltvi_Item.SelectedPictureIndex = 5
	else
		// Set not seletected picture
		ltvi_Item.PictureIndex = 3
		ltvi_Item.SelectedPictureIndex = 4
	end if
	this.SetItem(al_Handle, ltvi_Item)
	Return 0
end if

// Recursion call
ll_FindHandle = this.FindItem(ChildTreeItem!, al_Handle)
do while ll_FindHandle <> -1
	of_SetSelectedPicture(ll_FindHandle, ab_Flag)
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
loop

Return 1
end function

public function integer of_setselectedpicture (string as_tab_name, boolean ab_flag);long ll_FindHandle
TreeViewItem ltvi_Item

ll_FindHandle = this.FindItem(RootTreeItem!, 0)

// Set selected picture
do while ll_FindHandle <> -1
	this.GetItem(ll_FindHandle, ltvi_Item)
	if ltvi_Item.Data = as_tab_name then
		of_SetSelectedPicture(ll_FindHandle, ab_Flag)
		Return 1
	else
		ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
	end if
loop

Return -1
end function

public function integer of_resetselectedpicture ();long ll_FindHandle
TreeViewItem ltvi_Item

ll_FindHandle = this.FindItem(RootTreeItem!, 0)

// Reset selected picture
do while ll_FindHandle <> -1	
	of_SetSelectedPicture(ll_FindHandle, false)
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
loop

Return 1
end function

public function boolean of_ischanged ();ids_data.AcceptText()

if ids_data.ModifiedCount() + ids_data.DeletedCount() > 0 then
	Return true	
else
	Return false
end if
end function

public function integer of_add (string as_tab_name, string as_label, ref u_contract_screen au_available);long ll_FindHandle
TreeViewItem ltvi_Item
TreeViewItem ltvi_ItemInfo
boolean lb_Exists = false
long ll_HandleAfter = -1
long ll_RootHandle

// Determine where to be insert
ll_HandleAfter= -1
ll_FindHandle = this.FindItem(RootTreeItem!, 0)
do while ll_FindHandle <> -1
	this.GetItem(ll_FindHandle, ltvi_ItemInfo)
	if as_tab_name > ltvi_ItemInfo.Data then
		ll_HandleAfter = ll_FindHandle
	elseif ltvi_ItemInfo.Data = as_tab_name then
		lb_Exists = true
		exit
	end if
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
loop
if lb_Exists then Return -1

//Added by Alan on 2008-12-29 
ll_RootHandle = au_available.of_GetRootHandle(au_available.il_CurrentHandle)
au_available.DeleteItem(ll_RootHandle)
//end

// Insert screen folder
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 2
ltvi_Item.Data = as_tab_name
ltvi_Item.Label = as_label
ltvi_Item.Children = true
//Begin - Added By Mark Lee 02/05/2013
If as_tab_name = 'tabpage_email' Then 
	ltvi_Item.Children = False
End IF 
//End - Added By Mark Lee 02/05/2013
if ll_HandleAfter = -1 then
	ll_FindHandle = this.InsertItemFirst(0, ltvi_Item)
else
	ll_FindHandle = this.InsertItem(0, ll_HandleAfter, ltvi_Item)
end if

// Insert screen items
au_available.ids_data.SetFilter("tab_name='" + as_tab_name + "'")
au_available.ids_data.Filter()
If au_available.ids_data.RowsCopy(1, au_available.ids_data.RowCount(), Primary!, ids_data, 1, Primary!) <> 1 Then
	MessageBox( 'Screen', 'Failure to Rowscopy!' )
End If

//added by gavins 20120417
is_AddOrRemove = 'add'

au_available.ids_data.SetFilter("")
au_available.ids_data.Filter()
au_available.of_SetSelectedPicture(as_tab_name, true)
this.ExpandAll(ll_FindHandle)
this.SelectItem(ll_FindHandle)
this.Post SetFocus()

Return 1
end function

public function integer of_getrootitem (long al_handle, ref treeviewitem atvi_item);long ll_RootHandle
long ll_FindHandle

// Get root item
ll_RootHandle = al_Handle
ll_FindHandle = al_Handle

do while true
	ll_FindHandle = this.FindItem(ParentTreeItem!, ll_FindHandle)
	if ll_FindHandle <> -1 then
		ll_RootHandle = ll_FindHandle
	else
		exit
	end if
loop

Return this.GetItem(ll_RootHandle, atvi_Item)
end function

public function integer of_getrootitem (ref treeviewitem atvi_item);Return of_GetRootItem(il_CurrentHandle, atvi_Item)
end function

public function integer of_add (ref u_contract_screen au_available);TreeViewItem ltvi_item

au_available.of_GetRootItem(ltvi_item)

Return this.of_Add(ltvi_item.data, ltvi_item.label, au_available)
end function

public function long of_getroothandle (long al_handle);long ll_RootHandle
long ll_FindHandle

// Get root handle
ll_RootHandle = al_Handle
ll_FindHandle = al_Handle

do while true
	ll_FindHandle = this.FindItem(ParentTreeItem!, ll_FindHandle)
	if ll_FindHandle <> -1 then
		ll_RootHandle = ll_FindHandle
	else
		exit
	end if
loop

Return ll_RootHandle
end function

public function integer of_remove (long al_handle, ref u_contract_screen au_available);long ll_Row
long ll_RowCount
long ll_RootHandle
string ls_tab_name,ls_label
TreeViewItem ltvi_Item,ltvi_Item1
long ll_FindHandle,ll_HandleAfter
Treeviewitem ltvi_ItemInfo
Boolean lb_Exists=false


// Set selected picture of available screen view 
ll_RootHandle = of_GetRootHandle(al_Handle)
if this.GetItem(ll_RootHandle, ltvi_Item) = -1 then Return -1
ls_tab_name = ltvi_Item.Data
ls_label = ltvi_Item.label
au_available.of_SetSelectedPicture(ls_tab_name, false)

// Remove screen items
this.DeleteItem(ll_RootHandle)

//Added by Alan on 2008-12-29
// Determine where to be insert
ll_HandleAfter= -1
ll_FindHandle = au_available.FindItem(RootTreeItem!, 0)
do while ll_FindHandle <> -1
	au_available.GetItem(ll_FindHandle, ltvi_ItemInfo)
	if ls_tab_name > ltvi_ItemInfo.Data then
		ll_HandleAfter = ll_FindHandle
	elseif ltvi_ItemInfo.Data = ls_tab_name then
		lb_Exists = true
		exit
	end if
	ll_FindHandle = au_available.FindItem(NextTreeItem!, ll_FindHandle)
loop
if not lb_Exists then
	// Insert screen folder
	ltvi_Item1.PictureIndex = 1
	ltvi_Item1.SelectedPictureIndex = 2
	ltvi_Item1.Data = ls_tab_name
	ltvi_Item1.Label = ls_label
	ltvi_Item1.Children = true
	//Begin - Added By Mark Lee 02/05/2013
	If ls_tab_name = 'tabpage_email' Then 
		ltvi_Item1.Children = False
	End IF 
	//End - Added By Mark Lee 02/05/2013
	if ll_HandleAfter = -1 then
		ll_FindHandle = au_available.InsertItemFirst(0, ltvi_Item1)
	else
		ll_FindHandle = au_available.InsertItem(0, ll_HandleAfter, ltvi_Item1)
	end if
end if
au_available.ExpandAll(ll_FindHandle)
au_available.SelectItem(ll_FindHandle)
//end

ids_data.SetFilter("tab_name='" + ls_tab_name + "'")
ids_data.Filter()
ll_RowCount = ids_data.RowCount()
//for ll_Row = 1 to ll_RowCount
//	ids_data.DeleteRow(1)
//next
ids_data.RowsMove( 1, ll_RowCount, primary!, ids_data, 1, delete! )
ids_data.SetFilter("")
ids_data.Filter()

//added by gavins 20120417
is_AddOrRemove = 'remove'

Return 1
end function

public function integer of_remove (ref u_contract_screen au_available);Return of_Remove(il_CurrentHandle, au_available)
end function

public function integer of_save (long al_data_view_id, ref u_contract_screen au_available);long ll_Row
long ll_dw_sql_len, ll_dw_opsql_len
long ll_screen_id, ll_Source_viewid
string ls_DeleteSQL
string ls_tabpage_name
string ls_Syntax, ls_ScreenStyle, ls_OpSyntax
string	ls_UpdateSyntax[], ls_UpdateOpSyntax[], ls_UpdateScreenStyle[]
Long	ll_UpdateScreenID[], ll_UpdateDataViewID[]

// Return 0 if no data changed
ids_data.SetFilter("")
ids_data.Filter()
if not of_IsChanged() then Return 0

//Added By Mark Lee 04/25/12 For APB Bug
ls_tabpage_name	= ""

// Set data view id and dw syntax
for ll_Row = 1 to ids_data.RowCount()
	// Continue if status of current row is not NewModified
	if ids_data.GetItemStatus(ll_Row, 0 ,Primary!) <> NewModified! then
		Continue
	end if
	
	// Set data view id
	ll_Source_viewid = ids_Data.GetItemNumber( ll_Row, 'data_view_id' )//added by gaivns 20120417 
	
	ids_data.SetItem(ll_Row, "data_view_id", al_data_view_id)
	
	ls_ScreenStyle = ids_data.GetItemString( ll_Row, 'screen_style' )//added by gavins 20120313 grid
	
	ll_screen_id = ids_data.GetItemNumber(ll_Row, "screen_id")
	
	ll_UpdateDataViewID[ll_row] = al_data_view_id
	ll_UpdateScreenID[ll_row] = ll_screen_id
	ls_UpdateSyntax[ll_row] = ""
	ls_UpdateOpSyntax[ ll_row] = ""
	ls_UpdateScreenStyle[ll_row]=ls_ScreenStyle
	/*******************************///added by gavins 20120417
	If is_AddOrRemove = 'add' Then
		this.of_Add_pic(  ll_Source_viewid , ll_screen_id, al_data_view_id , ll_screen_id )
	End If
	/*******************************/
	// Set dw syntax
	ls_Syntax = ""
	if AppeongetClientType() = 'PB' then
		
		If ls_ScreenStyle = 'G' Then
			ll_dw_sql_len = ids_data.GetItemNumber(ll_Row, "grid_sql_len")
			ll_dw_opsql_len = ids_data.GetItemNumber(ll_Row, "grid_opsql_len")
		Else
			ll_dw_sql_len = ids_data.GetItemNumber(ll_Row, "dw_sql_len")
			ll_dw_opsql_len = ids_data.GetItemNumber(ll_Row, "dw_opsql_len")
		End If
		if ll_dw_sql_len > 32766 then
			If ls_ScreenStyle = 'G' Then
				ls_Syntax = f_get_screen_gridsql(1001, ll_screen_id,false)   //add false argu - jervis 10.11.2011
			Else
				ls_Syntax = f_get_screen_sql(1001, ll_screen_id,false)   //add false argu - jervis 10.11.2011
			End If
		Else
			If ls_ScreenStyle = 'G' Then
				ls_Syntax = ids_data.GetItemString( ll_Row, 'grid_sql' )
			Else
				ls_Syntax = ids_data.GetItemString( ll_Row, 'dw_sql' )
			End If
		end if
		If ll_dw_opsql_len > 32766 Then
			If ls_ScreenStyle = 'G' Then
				ls_opSyntax = f_get_screen_gridsql(1001, ll_screen_id, true)   //add false argu - jervis 10.11.2011
			Else
				ls_opSyntax = f_get_screen_sql(1001, ll_screen_id,true)   //add false argu - jervis 10.11.2011
			End If
		Else
			If ls_ScreenStyle = 'G' Then
				ls_opSyntax = ids_data.GetItemString( ll_Row, 'grid_opsql' )
			Else
				ls_opSyntax = ids_data.GetItemString( ll_Row, 'dw_opsql' )
			End If
		End If
		if Len(ls_Syntax) > 0 then
			If ls_ScreenStyle = 'G' Then
				ids_data.SetItem(ll_Row, "grid_sql", ls_Syntax)
			Else
				ids_data.SetItem(ll_Row, "dw_sql", ls_Syntax)
			End If
		end if
		If len( ls_opSyntax ) > 0 Then
			If ls_ScreenStyle = 'G' Then
				ids_data.SetItem(ll_Row, "grid_opsql", ls_opSyntax)
			Else
				ids_data.SetItem(ll_Row, "dw_opsql", ls_opSyntax)
			End If
		End If
		
	Else
		If ls_ScreenStyle = 'G' Then
			ls_Syntax = ids_data.GetItemString( ll_Row, 'grid_sql' )
		Else
			ls_Syntax = ids_data.GetItemString( ll_Row, 'dw_sql' )
		End If
		
		If ls_ScreenStyle = 'G' Then
			ls_opSyntax = ids_data.GetItemString( ll_Row, 'grid_opsql' )
		Else
			ls_opSyntax = ids_data.GetItemString( ll_Row, 'dw_opsql' )
		End If
	end if
	ls_UpdateSyntax[ll_row] = ls_Syntax
	ls_UpdateOpSyntax[ ll_row] = ls_opSyntax
next

// Get tabpage names those were deleted
for ll_Row = 1 to ids_data.DeletedCount()
	if not IsNull(ids_data.object.tab_name.delete[ll_Row]) then
		if ls_tabpage_name <> "" then ls_tabpage_name += ", "
		ls_tabpage_name += "'" + ids_data.object.tab_name.delete[ll_Row] + "'"
		If is_AddOrRemove = 'remove' Then
			this.of_del_pic(  ids_data.object.data_view_id.delete[ll_Row] , ids_data.object.screen_id.delete[ll_row] )
		End If		
	end if
next
is_AddOrRemove = ""
// Save data
if ids_data.Update() = 1 then
	// update text
	for ll_row = 1 to Upperbound( ll_UpdateDataViewID  )
		If ll_UpdateDataViewID[ll_row] = 0 or isnull(ll_UpdateDataViewID[ll_row] ) then continue
		If ll_UpdateScreenID[ll_row] = 0 or isnull(ll_UpdateScreenID[ll_row] ) then continue
		If ls_UpdateScreenStyle[ll_row] = 'G' Then
			Update ctx_screen  set  grid_sql = :ls_UpdateSyntax[ll_row] where data_view_id = :ll_UpdateDataViewID[ll_row] and screen_id = :ll_UpdateScreenID[ll_row] ;  //added by gavins 20120919
			Update ctx_screen  set grid_opsql = :ls_UpdateOpSyntax[ll_row]  where data_view_id = :ll_UpdateDataViewID[ll_row] and screen_id = :ll_UpdateScreenID[ll_row] ;  //added by gavins 20120919
		Else
			Update ctx_screen  set dw_sql = :ls_UpdateSyntax[ll_row]  where data_view_id = :ll_UpdateDataViewID[ll_row] and screen_id = :ll_UpdateScreenID[ll_row] ;  //added by gavins 20120919
			Update ctx_screen  set dw_opsql = :ls_UpdateOpSyntax[ll_row]  where data_view_id = :ll_UpdateDataViewID[ll_row] and screen_id = :ll_UpdateScreenID[ll_row] ;  //added by gavins 20120919
		End If
		If sqlca.sqlcode <> 0 then
			gnv_debug.of_output( true, 'failed to save screen syntax in u_contract_screen ( of_save).' +string( al_data_view_id ) + '-' + string( ll_UpdateScreenID[ll_row] ) + sqlca.sqlerrtext )
		End If
	Next
	
	ls_DeleteSQL = "DELETE FROM ctx_tabpage_properties WHERE data_view_id = " + String(al_data_view_id) + " AND tabpage_name in (" + ls_tabpage_name + ")"
	gnv_appeondb.of_StartQueue()
	EXECUTE IMMEDIATE :ls_DeleteSQL;
	COMMIT;
	gnv_appeondb.of_CommitQueue()
	Return 1
else
	Rollback;
	Return -1
end if
end function

public function long of_finditemwithdata (long al_handle, string as_data);long ll_FindHandle
long ll_ReturnHandle
TreeViewItem ltvi_Item

// Return be find handle
this.GetItem(al_Handle, ltvi_Item)
if String(ltvi_Item.Data) = as_Data then Return al_Handle

// Recursion call
ll_FindHandle = this.FindItem(ChildTreeItem!, al_Handle)
do while ll_FindHandle <> -1
	ll_ReturnHandle = of_FindItemWithData(ll_FindHandle, as_Data)
	if ll_ReturnHandle <> -1 then Return ll_ReturnHandle
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
loop

Return -1
end function

public function long of_finditemwithdata (string as_data);long ll_FindHandle
long ll_ReturnHandle
TreeViewItem ltvi_Item

ll_FindHandle = this.FindItem(RootTreeItem!, 0)

// Recursion call
do while ll_FindHandle <> -1
	ll_ReturnHandle = of_FindItemWithData(ll_FindHandle, as_Data)
	if ll_ReturnHandle <> -1 then Return ll_ReturnHandle
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)	
loop

Return -1
end function

public function integer of_expandall ();long ll_FindHandle

ll_FindHandle = this.FindItem(RootTreeItem!, 0)

// Expand all items
do while ll_FindHandle <> -1
	this.ExpandAll(ll_FindHandle)
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
loop

Return 1
end function

public function integer of_collapseall (long al_handle);long ll_FindHandle

// Collapse item
this.CollapseItem(al_Handle)

// Recursion call
ll_FindHandle = this.FindItem(ChildTreeItem!, al_Handle)
do while ll_FindHandle <> -1
	of_CollapseAll(ll_FindHandle)
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
loop

Return 1
end function

public function integer of_collapseall ();long ll_FindHandle

ll_FindHandle = this.FindItem(RootTreeItem!, 0)

// Collapse all items
do while ll_FindHandle <> -1
	of_CollapseAll(ll_FindHandle)
	ll_FindHandle = this.FindItem(NextTreeItem!, ll_FindHandle)
loop

Return 1
end function

public function integer of_getcurrentitem (ref treeviewitem atvi_item);Return this.GetItem(il_CurrentHandle, atvi_Item)
end function

public function long of_findfirstscreenitem ();long ll_FindHandle
TreeViewItem ltvi_Item

ll_FindHandle = this.FindItem(RootTreeItem!, 0)

// Find first screen item
do while ll_FindHandle <> -1
	this.GetItem(ll_FindHandle, ltvi_Item)
	if ltvi_Item.PictureIndex = 3 then Return ll_FindHandle
	ll_FindHandle = this.FindItem(ChildTreeItem!, ll_FindHandle)
loop

Return -1
end function

public function integer of_retrieve (long al_data_view_id);long ll_Pos
long i, ll_Row
long ll_RowCount
long ll_TabPagCount
string ls_tab_name
string ls_tab_name_arr[]
string ls_tab_lable_arr[]
string ls_SQLSelect
string ls_Text
boolean lb_Exists
long ll_Handle
long ll_FirstHandle
TreeViewItem ltvi_Item

// Retrieve data
ids_data.SetFilter("")
ids_data.Filter()
ls_SQLSelect = is_tabpage_prop_sql + " WHERE data_view_id = " + String(al_data_view_id)
ids_tabpage_prop.SetSQLSelect(ls_SQLSelect)

gnv_appeondb.of_StartQueue()
ids_tabpage_prop.Retrieve()
ids_data.Retrieve(al_data_view_id)
gnv_appeondb.of_CommitQueue()

//
ll_RowCount = ids_data.rowcount()

// Delete all items
this.SetRedraw(false)
of_DeleteAll()

// Get tab page names
for ll_Row = 1 to ll_RowCount	
	lb_Exists = false
	ll_TabPagCount = UpperBound(ls_tab_name_arr[])
	ls_tab_name = ids_data.GetItemString(ll_Row, "tab_name")	
	if ls_tab_name = 'tabpage_qrg' then continue  //delete qrg screen - jervis 05.31.2011
	for i = 1 to ll_TabPagCount
		if ls_tab_name = ls_tab_name_arr[i] then
			lb_Exists = true
			exit
		end if
	next
	if not lb_Exists then
		ll_TabPagCount ++
		ls_tab_name_arr[ll_TabPagCount] = ls_tab_name
		ls_tab_lable_arr[ll_TabPagCount] = ids_data.GetItemString(ll_Row, "screen_name")
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
	ll_Handle = of_InsertFolder(0, ls_tab_name_arr[i], ls_tab_lable_arr[i])
	if i = 1 then ll_FirstHandle = ll_Handle
	// Create all screen items by expand all method
	this.ExpandAll(ll_Handle)	
next
this.SelectItem(ll_FirstHandle)
this.SetRedraw(true)
this.SetFocus()

Return 1
end function

public function string of_gettabpagetext (string as_tabpage_name);long ll_FindRow
string ls_Text

ll_FindRow = ids_tabpage_prop.Find("tabpage_name = '" + as_tabpage_name + "'", 1, ids_tabpage_prop.RowCount())
if ll_FindRow > 0 then
	ls_Text = ids_tabpage_prop.GetItemString(ll_FindRow, "text")
end if

Return ls_Text
end function

public function string of_getscreentitlebartext (long al_screen_id);long ll_FindRow
string ls_Text

ll_FindRow = ids_data.Find("screen_id = " + String(al_screen_id), 1, ids_data.RowCount())
if ll_FindRow > 0 then
	ls_Text = ids_data.GetItemString(ll_FindRow, "titlebar_text")
end if

Return ls_Text
end function

public function integer of_showcustomitemlabel (boolean ib_flag);ib_ShowCustomItemLabel = ib_Flag

Return 1
end function

public subroutine of_setview_properties (long al_view_id);integer li_Pos
string  ls_text
long    ll_text_color
string  ls_icon_visible
string  ls_Message
TreeViewItem ltvi_item


// Determine if set tab page properties
if this.GetItem(this.il_CurrentHandle, ltvi_item) = -1 then
	MessageBox("Tab Properties", "No tab page can be set.")
	Return
end if
if ltvi_item.PictureIndex <> 1 then
	MessageBox("Tab Properties", "Please select a folder item (not a screen item) from Selected Screens.")
	this.SetFocus()
	Return
end if

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//Added By Jay Chen 04-03-2014
if ltvi_item.Label = "Document Browse Window" then
	MessageBox("Tab Properties", "Document Browse Window nonsupport to modify tab properties.")
	this.SetFocus()
	Return
end if
//---------End Added ------------------------------------------------------

// Open tab page properties window
ls_Message = String(al_view_id) + "|" + ltvi_item.Data + "|" + ltvi_item.Label
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
this.SetItem(this.il_CurrentHandle, ltvi_item)
end subroutine

public function integer of_add_pic (long al_source_view_id, long al_source_screen_id, long al_target_view_id, long al_target_screen_id);//
//====================================================================
// Function: of_add_pic
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	al_source_view_id
// 	al_source_screen_id
// 	al_target_view_id
// 	al_target_screen_id
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-04-16
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string			ls_FileName
DataStore	lds_pic
Integer		li_i, li_null

If al_source_screen_id = -9999 Then  //no screen_id
	
	
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
			 select :al_target_view_id,
				 screen_id, 
				 pic_type,
				 pic_band, 
				 pic_name, 
				  substring( pic_filename,1,2 ) + cast( :al_target_view_id as varchar(10))  + '_' + cast( screen_id as varchar(10)) +
				substring( pic_filename, charindex( '_',pic_filename, charindex( '_',pic_filename, 3 ) + 1 ),99)
				  ,pic_bitmap
				  ,pic_x
				  ,pic_y
				  ,pic_width
				  ,pic_height
				  ,pic_tag  
				  from conv_view_pic where view_id = :al_source_view_id and pic_type = 'screen';
Else
	insert into conv_view_pic (  view_id
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
       select :al_target_view_id,
			 :al_target_screen_id, 
			 pic_type,
			 pic_band, 
			 pic_name, 
			  substring( pic_filename,1,2 ) + cast( :al_target_view_id as varchar(10))  + '_' + cast( :al_target_screen_id as varchar(10)) +
		   substring( pic_filename, charindex( '_',pic_filename, charindex( '_',pic_filename, 3 ) + 1 ),99)
		     ,pic_bitmap
			  ,pic_x
			  ,pic_y
			  ,pic_width
			  ,pic_height
			  ,pic_tag  
			  from conv_view_pic where view_id = :al_source_view_id and pic_type = 'screen' and screen_id = :al_source_screen_id;
	
	
End If
				
Return 0
end function

public function integer of_del_pic (long al_view_id, long al_screen_id);//====================================================================
// Function: of_del_pic
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	al_view_id
// 	al_screen_id
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-04-16
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


If al_Screen_id = -9999 Then
	 delete from conv_view_pic where view_id = :al_view_id and pic_type = 'screen' ; //added by gavins 20120416
Else
	
	 delete from conv_view_pic where view_id = :al_view_id and pic_type = 'screen'  and screen_id = :al_screen_id;
	
End If

















Return 0
end function

on u_contract_screen.create
end on

on u_contract_screen.destroy
end on

event destructor;if IsValid(ids_data) then Destroy ids_data
if IsValid(ids_tabpage_prop) then Destroy ids_tabpage_prop

end event

event itempopulate;long ll_Row
long ll_RowCount
long ll_Pos
long ll_Handle
string ls_tab_name
string ls_screen_label[]
long   ll_screen_id[]
TreeViewItem ltvi_Item

// Get current item information
if this.FindItem(ChildTreeItem!, Handle) > 0 then Return
this.GetItem(Handle, ltvi_Item)
ls_tab_name = ltvi_Item.Data

// Insert screen items
choose case ls_tab_name
	case "tabpage_details"
		of_InsertItem(Handle, 3, "Contract Detail")
		of_InsertItem(Handle, 4, "Products")
		of_InsertItem(Handle, 5, "Contract Dates")
		of_InsertItem(Handle, 6, "Contracted Company Contact")
		of_InsertItem(Handle, 7, "Our Company Contact")
		
		// Details->Notes
		ll_Handle = of_InsertFolder(Handle, "tabpage_det_notes", "Notes")
		of_InsertItem(ll_Handle, 8, "Notes")
		// Details->Custom Data
		ll_Handle = of_InsertFolder(Handle, "tabpage_det_custom", "Custom Data")
		of_InsertItem(ll_Handle, 9, "Custom Data")
		/*
		// Details->Audit Trail
		ll_Handle = of_InsertFolder(Handle, "tabpage_det_audit", "Audit Trail")
		of_InsertItem(ll_Handle, 10, "Audit Trail")		
		*/
		//Detail->Custom Data2 
		ll_Handle = of_InsertFolder(Handle, "tabpage_det_audit", "Custom Data 2")
		of_InsertItem(ll_Handle, 10, "Custom Data 2")		
		
		// Details->Linked Contracts
		ll_Handle = of_InsertFolder(Handle, "tabpage_det_linked", "Linked Contracts")
		of_InsertItem(ll_Handle, 43, "Linked Contracts")
		// Details->Group Access //Added by Ken.Guo on 2009-02-10
		ll_Handle = of_InsertFolder(Handle, "tabpage_det_group", "Group Access")
		of_InsertItem(ll_Handle, 50, "Group Access")
		
		//Details->Linked Providers	//Added by Appeon long.zhang 04.15.2014 (v14.2 Provider-Contract direct linking)
		ll_Handle = of_InsertFolder(Handle, "tabpage_det_provider", "Linked Providers")
		//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
		//of_InsertItem(ll_Handle, 58, "Linked Providers")
		of_InsertItem(ll_Handle, 61, "Linked Providers")
		//---------End Modfiied ------------------------------------------------------
		
	case "tabpage_fee_schedules"
		// Fee Schedules->Browse
		ll_Handle = of_InsertFolder(Handle, "tabpage_fee_browse", "Browse")
		of_InsertItem(ll_Handle, 26, "Fee Schedules")
		of_InsertItem(ll_Handle, 27, "Fee Schedule Locations")
		of_InsertItem(ll_Handle, 28, "Fees")
		of_InsertItem(ll_Handle, 29, "Providers")
		// Fee Schedules->Notes
		ll_Handle = of_InsertFolder(Handle, "tabpage_fee_notes", "Notes")
		of_InsertItem(ll_Handle, 30, "User Defined data")
		
	case "tabpage_images"
		// Document Manager->Document
		ll_Handle = of_InsertFolder(Handle, "tabpage_dm_document", "Document")
		of_InsertItem(ll_Handle, 32, "Search Criteria")
		// Document Manager->Document Tab->Document Browse //add by gavins 20120131
		of_InsertItem(ll_Handle, 56, "Document Browse")
		// Document Manager->Document Tab->Document Browse
		of_InsertItem(ll_Handle, 57, "Document History")
		
		// Document Manager->Document Tab->Added Document Properties		//Added by Scofield on 2010-04-20
		of_InsertItem(ll_Handle, 51, "Added Document Properties")
		// Document Manager->Document Tab->Created Document Properties		//Added by Scofield on 2010-04-20
		of_InsertItem(ll_Handle, 52, "Created Document Properties")
		
		
		// Document Manager->Work Flow
		ll_Handle = of_InsertFolder(Handle, "tabpage_dm_workflow", "Work Flow")
		of_InsertItem(ll_Handle, 45, "Search Criteria")
		of_InsertItem(ll_Handle, 46, "Action Item Browse")
		of_InsertItem(ll_Handle, 47, "Action Item Detail")
		
		//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
		//Added By Jay Chen 04-03-2014
		// Document Manager->Document Browse Window
		ll_Handle = of_InsertFolder(Handle, "tabpage_dm_browse_window", "Document Browse Window")
		of_InsertItem(ll_Handle, 59, "Search Criteria")
		of_InsertItem(ll_Handle, 60, "Document Browse")
		//---------End Added ------------------------------------------------------
		
		/*
		// Document Manager->Audit Trail
		ll_Handle = of_InsertFolder(Handle, "tabpage_dm_audit", "Audit Trail")
		of_InsertItem(ll_Handle, 48, "Search Criteria")
		of_InsertItem(ll_Handle, 49, "Document Browse")
		*/

	case "tabpage_qrg"
		//	QRG->Select Data
		ll_Handle = of_InsertFolder(Handle, "tabpage_qrg_select", "Select Data")
		of_InsertItem(ll_Handle, 34, "Report Profiles")
		of_InsertItem(ll_Handle, 35, "Basic Information to Include")
		of_InsertItem(ll_Handle, 36, "Contract Contact Information to Include")
		of_InsertItem(ll_Handle, 37, "Precertifications Requirements")
		of_InsertItem(ll_Handle, 38, "Authorizations Requirements")
		of_InsertItem(ll_Handle, 39, "Fee Schedule Data to Include")
		of_InsertItem(ll_Handle, 40, "Organization Types to Include")
		of_InsertItem(ll_Handle, 41, "Requirements to Include")		
			
	case "tabpage_email"									//Added By Mark Lee 02/05/2013
//		ltvi_Item.ExpandAll(Handle)
//		ltvi_Item.ExpandItem(Handle)
//		ll_Handle = of_InsertFolder(Handle, "tabpage_email", "Email Manager")
//		of_InsertItem(ll_Handle, 58, "Email Manager")

	case else
		////////////////////////////////////////////////
		// tabpage_action_items,  tabpage_contacts,
		// tabpage_fee_sched2,    tabpage_locations,
		// tabpage_orgabizations, tabpage_requirements
		// tabpage_search
		////////////////////////////////////////////////
		
		// Filter corresponding screen data
		ids_data.SetFilter("tab_name='" + ls_tab_name + "'")
		ids_data.Filter()
		ll_RowCount = ids_data.RowCount()
		ll_screen_id[] = ids_data.object.screen_id[1, ll_RowCount]
		ls_screen_label[] = ids_data.object.screen_name[1, ll_RowCount]
		ids_data.SetFilter("")
		ids_data.Filter()
		
		// Insert screen items
		for ll_Row = 1 to ll_RowCount
			// Get screen label
			ll_Pos = Pos(ls_screen_label[ll_Row], "->")
			ls_screen_label[ll_Row] = Right(ls_screen_label[ll_Row], Len(ls_screen_label[ll_Row]) - ll_Pos - 1)
			
			// Insert screen item
			of_InsertItem(Handle, ll_screen_id[ll_Row], ls_screen_label[ll_Row])
		next
end choose
end event

event selectionchanged;il_CurrentHandle = NewHandle
this.GetItem(NewHandle, itvi_CurrentItem)
end event

event constructor;// Create screen items datastore
ids_data = Create n_ds
ids_data.DataObject = "ds_contract_data_view_screens_list"
ids_data.SetTransObject(SQLCA)

// Create tab page properties datastore
ids_tabpage_prop = Create n_ds
ids_tabpage_prop.DataObject = "d_tabpage_properties"
ids_tabpage_prop.SetTransObject(SQLCA)
is_tabpage_prop_sql = ids_tabpage_prop.GetSQLSelect()


ids_pic = Create n_ds
ids_pic.Dataobject = "d_conv_view_pic"
ids_pic.SetTransObject( SQLCA )
end event

