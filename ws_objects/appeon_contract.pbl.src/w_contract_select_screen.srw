$PBExportHeader$w_contract_select_screen.srw
$PBExportComments$//Create by Scofield on 2009/03/15
forward
global type w_contract_select_screen from window
end type
type cb_cancel from commandbutton within w_contract_select_screen
end type
type cb_select from commandbutton within w_contract_select_screen
end type
type tv_tabpage_screen from treeview within w_contract_select_screen
end type
end forward

global type w_contract_select_screen from window
integer width = 1477
integer height = 1724
boolean titlebar = true
string title = "Select Screen"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_select cb_select
tv_tabpage_screen tv_tabpage_screen
end type
global w_contract_select_screen w_contract_select_screen

type variables
str_TabPageScreen	istr_Screen

DataStore	ids_Tabpage_Screen

Boolean		ib_NeedDestroy

CONSTANT STRING SEPCHAR = ","

end variables

forward prototypes
public subroutine of_ResetTree ()
public subroutine of_disprelation (long al_parenthandle, long al_parent_id)
public function string of_getancestor (long al_ts_id)
public function string of_getdescendant (long al_ts_id)
public function long of_selectscreen ()
public subroutine of_refresh (long al_type)
public subroutine of_filter (string as_tabpage[], long al_screen[])
public function boolean of_hasleafnode (long al_ts_id)
public subroutine of_expandall ()
end prototypes

public subroutine of_ResetTree ();//====================================================================
// Function: of_ResetTree()
//--------------------------------------------------------------------
// Description: Delete all the tree node
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Handle

ll_Handle = tv_TabPage_Screen.FindItem(RootTreeItem!,0)
do while ll_Handle > 0
	tv_TabPage_Screen.DeleteItem(ll_Handle)
	ll_Handle = tv_TabPage_Screen.FindItem(RootTreeItem!,0)
loop

end subroutine

public subroutine of_disprelation (long al_parenthandle, long al_parent_id);//====================================================================
// Function: of_disprelation()
//--------------------------------------------------------------------
// Description: Recursion create tree node
//--------------------------------------------------------------------
// Arguments:
// 	long	al_parenthandle	
// 	long	al_parent_id   	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FoundRow,ll_RowCnt,ll_ts_type,ll_SelfHandle,ll_ts_id,ll_Screen_ID
String	ls_LabelText

TreeViewItem	ltvi_Item

ll_RowCnt = ids_Tabpage_Screen.RowCount()

ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_parent_id = " + String(al_Parent_ID),1,ll_RowCnt)
do while ll_FoundRow > 0
	ll_ts_id = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_ts_id")
	ll_ts_type = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_ts_type")
	ll_Screen_ID = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_screen_id")
	ls_LabelText = ids_Tabpage_Screen.GetItemString(ll_FoundRow,"label_text")
	ltvi_Item.Label = ls_LabelText
	
	if ll_ts_type = 0 then
		if of_HasLeafNode(ll_ts_id) or istr_Screen.ab_DispEmpty then
			ltvi_Item.PictureIndex = 1
			ltvi_Item.SelectedPictureIndex = 2
			ltvi_Item.Data = 0
			
			ll_SelfHandle = tv_TabPage_Screen.InsertItemLast(al_ParentHandle,ltvi_Item)
			of_DispRelation(ll_SelfHandle,ll_ts_id)
		end if
	else
		ltvi_Item.PictureIndex = 3
		ltvi_Item.SelectedPictureIndex = 4
		ltvi_Item.Data = ll_Screen_ID
		
		tv_TabPage_Screen.InsertItemLast(al_ParentHandle,ltvi_Item)
	end if
	
	if ll_FoundRow >= ll_RowCnt then Exit
	ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_parent_id = " + String(al_Parent_ID),ll_FoundRow + 1,ll_RowCnt)
loop

end subroutine

public function string of_getancestor (long al_ts_id);//====================================================================
// Function: of_getancestor()
//--------------------------------------------------------------------
// Description: Recursion all the ancestor ts_id
//--------------------------------------------------------------------
// Arguments:
// 	long	al_ts_id	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FoundRow,ll_RowCnt,ll_ts_pid

ll_RowCnt = ids_Tabpage_Screen.RowCount()
ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_ts_id = " + String(al_ts_id),1,ll_RowCnt)
if ll_FoundRow > 0 then
	ll_ts_pid = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_parent_id")
	if ll_ts_pid <> 0 then
		Return String(ll_ts_pid) + SEPCHAR + of_GetAncestor(ll_ts_pid)
	end if
end if

Return ""

end function

public function string of_getdescendant (long al_ts_id);//====================================================================
// Function: of_getdescendant()
//--------------------------------------------------------------------
// Description: Recursion all the descendant ts_id
//--------------------------------------------------------------------
// Arguments:
// 	long	al_ts_id	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FoundRow,ll_RowCnt,ll_ts_desid
String	ls_Descendant

ll_RowCnt = ids_Tabpage_Screen.RowCount()

ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_parent_id = " + String(al_ts_id),1,ll_RowCnt)
do while ll_FoundRow > 0
	ll_ts_desid = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_ts_id")
	ls_Descendant += String(ll_ts_desid) + SEPCHAR + of_GetDescendant(ll_ts_desid)
	if ll_FoundRow >= ll_RowCnt then Exit
	ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_parent_id = " + String(al_ts_id),ll_FoundRow + 1,ll_RowCnt)
loop

Return ls_Descendant

end function

public function long of_selectscreen ();long	ll_CurItemHandle

TreeViewItem	ltvi_Item

ll_CurItemHandle = tv_TabPage_Screen.FindItem (CurrentTreeItem!,0)
if ll_CurItemHandle < 0 then Return -1

tv_TabPage_Screen.GetItem(ll_CurItemHandle,ltvi_Item)

Return ltvi_Item.Data

end function

public subroutine of_refresh (long al_type);//====================================================================
// Function: of_refresh()
//--------------------------------------------------------------------
// Description: Afresh generate the tree node
//--------------------------------------------------------------------
// Arguments:
//			long		al_Type
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

SetPointer(HourGlass!)
tv_TabPage_Screen.SetRedraw(false)

if al_Type = 2 then
	ids_Tabpage_Screen.Reset()
	ids_Tabpage_Screen.SetTransObject(SQLCA)
	ids_Tabpage_Screen.Retrieve(istr_Screen.al_View_ID)
	of_Filter(istr_Screen.as_TabPage,istr_Screen.as_Screen)
end if

of_ResetTree()
of_DispRelation(0,0)
of_ExpandAll()
	
tv_TabPage_Screen.SetRedraw(true)
SetPointer(Arrow!)

end subroutine

public subroutine of_filter (string as_tabpage[], long al_screen[]);//====================================================================
// Function: of_filter()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_tabpage[]	
// 	value	long  	al_screen[] 	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-17
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FoundRow,ll_RowCnt,ll_ts_id,ll_Screen_ID
long		ll_TabPageCycle,ll_ScreenCycle,ll_TabPageCnts,ll_ScreenCnts
String	ls_all_ts_id,ls_Filter,ls_PageName

ll_TabPageCnts = UpperBound(as_TabPage)
ll_ScreenCnts = UpperBound(al_Screen)
ll_RowCnt = ids_Tabpage_Screen.RowCount()

if ll_TabPageCnts <> 0 or ll_ScreenCnts <> 0 then
	for ll_TabPageCycle = 1 to ll_TabPageCnts
		ls_PageName = Trim(as_TabPage[ll_TabPageCycle])
		if IsNull(ls_PageName) or ls_PageName = "" then CONTINUE
		ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_tabpage_name = '" + ls_PageName + "'",1,ll_RowCnt)
		if ll_FoundRow > 0 then
			ll_ts_id = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_ts_id")
			ls_all_ts_id += Trim(of_GetAncestor(ll_ts_id) + of_GetDescendant(ll_ts_id)) + String(ll_ts_id) + SEPCHAR
		end if
	next
	
	for ll_ScreenCycle = 1 to ll_ScreenCnts
		ll_Screen_ID = al_Screen[ll_ScreenCycle]
		if IsNull(ll_Screen_ID) or ll_Screen_ID <= 0 then CONTINUE
		ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_screen_id = " + String(ll_Screen_ID),1,ll_RowCnt)
		if ll_FoundRow > 0 then
			ll_ts_id = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_ts_id")
			ls_all_ts_id += Trim(of_GetAncestor(ll_ts_id)) + String(ll_ts_id) + SEPCHAR
		end if
	next

	if Right(ls_all_ts_id,Len(SEPCHAR)) = SEPCHAR then
		ls_all_ts_id = Trim(Left(ls_all_ts_id,Len(ls_all_ts_id) - Len(SEPCHAR)))
	end if
	
	if ls_all_ts_id = "" then
		ls_Filter = "1 = 2"
	else
		ls_Filter = "ctx_tabpage_screen_ts_id in (" + ls_all_ts_id + ")"
	end if
else
	ls_Filter = ""
end if

ids_Tabpage_Screen.SetFilter(ls_Filter)
ids_Tabpage_Screen.Filter()

end subroutine

public function boolean of_hasleafnode (long al_ts_id);//====================================================================
// Function: of_HasLeafNode()
//--------------------------------------------------------------------
// Description: Check whether the node has leaf Node
//--------------------------------------------------------------------
// Arguments:
// 	long	al_ts_id	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-19
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FoundRow,ll_RowCnt,ll_child_ts_id,ll_child_ts_type
Boolean	ib_HasLeafNode

ll_RowCnt = ids_Tabpage_Screen.RowCount()
ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_parent_id = " + String(al_ts_id),1,ll_RowCnt)
do while ll_FoundRow > 0
	ll_child_ts_type = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_ts_type")
	if ll_child_ts_type = 0 then
		ll_child_ts_id = ids_Tabpage_Screen.GetItemNumber(ll_FoundRow,"ctx_tabpage_screen_ts_id")
		ib_HasLeafNode = of_HasLeafNode(ll_child_ts_id)
		if ib_HasLeafNode then Exit
		if ll_FoundRow >= ll_RowCnt then Exit
		ll_FoundRow = ids_Tabpage_Screen.Find("ctx_tabpage_screen_parent_id = " + String(al_ts_id),ll_FoundRow + 1,ll_RowCnt)
	else
		ib_HasLeafNode = true
		Exit
	end if
loop

Return ib_HasLeafNode

end function

public subroutine of_expandall ();long	ll_Handle,ll_FirstVisible

ll_FirstVisible = tv_tabpage_screen.FindItem(RootTreeItem!,0)
ll_Handle = ll_FirstVisible
do while ll_Handle > 0
	tv_tabpage_screen.ExpandAll(ll_Handle)
	ll_Handle = tv_tabpage_screen.FindItem(NextTreeItem!,ll_Handle)
loop

tv_tabpage_screen.SetFirstVisible(ll_FirstVisible)

end subroutine

on w_contract_select_screen.create
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.tv_tabpage_screen=create tv_tabpage_screen
this.Control[]={this.cb_cancel,&
this.cb_select,&
this.tv_tabpage_screen}
end on

on w_contract_select_screen.destroy
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.tv_tabpage_screen)
end on

event open;String	ls_ColName,ls_NeedCol[]
long		ll_ColCycle,ll_ColCnts

ls_NeedCol[UpperBound(ls_NeedCol) + 1] = "ctx_tabpage_screen_ts_id"
ls_NeedCol[UpperBound(ls_NeedCol) + 1] = "ctx_tabpage_screen_ts_type"
ls_NeedCol[UpperBound(ls_NeedCol) + 1] = "ctx_tabpage_screen_parent_id"
ls_NeedCol[UpperBound(ls_NeedCol) + 1] = "ctx_tabpage_screen_screen_id"
ls_NeedCol[UpperBound(ls_NeedCol) + 1] = "label_text"

istr_Screen = Message.PowerObjectParm
ids_Tabpage_Screen = istr_Screen.ads_TabPageScreen

if IsValid(ids_Tabpage_Screen) then
	ib_NeedDestroy = false
	//Check Parameter
	ls_ColName = SEPCHAR
	ll_ColCnts = Long(ids_Tabpage_Screen.Describe("DataWindow.Column.Count"))
	for ll_ColCycle = 1 to ll_ColCnts
		ls_ColName += ids_Tabpage_Screen.Describe("#" + String(ll_ColCycle) + ".Name") + SEPCHAR
	next
	
	ll_ColCnts = UpperBound(ls_NeedCol)
	for ll_ColCycle = 1 to ll_ColCnts
		if Pos(ls_ColName,SEPCHAR + ls_NeedCol[ll_ColCycle] + SEPCHAR) <= 0 then
			Exit
		end if
	next
	
	if ll_ColCycle > ll_ColCnts then
		of_Refresh(1)		//Display data according to the datastore
	else
		MessageBox("Waring",ls_NeedCol[ll_ColCycle] + " does not exist in datastore, so the Select Screen window cannot be opened.",Exclamation!)
		Close(This)
	end if
else
	if IsNull(istr_Screen.al_View_ID) or istr_Screen.al_View_ID <= 0 then
		MessageBox("Waring","The Parameter format is incorrect, so the Select Screen window cannot be opened.",Exclamation!)
		Close(This)
	else
		ib_NeedDestroy = true
		istr_Screen.ab_DispEmpty = false
		
		ids_Tabpage_Screen = Create DataStore
		ids_Tabpage_Screen.DataObject = "d_tabpage_screen_label"
		of_Refresh(2)		//Display data according to the view id
	end if
end if

end event

event close;if ib_NeedDestroy and IsValid(ids_Tabpage_Screen) then
	Destroy ids_Tabpage_Screen
end if

end event

type cb_cancel from commandbutton within w_contract_select_screen
integer x = 1102
integer y = 1524
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,0)

end event

type cb_select from commandbutton within w_contract_select_screen
integer x = 745
integer y = 1524
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
boolean default = true
end type

event clicked;long	ll_CurScreenID

ll_CurScreenID = of_SelectScreen()
if ll_CurScreenID <= 0 then Return

CloseWithReturn(Parent,ll_CurScreenID)

end event

type tv_tabpage_screen from treeview within w_contract_select_screen
integer x = 18
integer y = 24
integer width = 1431
integer height = 1468
integer taborder = 10
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
string picturename[] = {"Custom039!","Custom050!","DataWindow!","DataWindow5!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event doubleclicked;cb_Select.TriggerEvent(Clicked!)

end event

