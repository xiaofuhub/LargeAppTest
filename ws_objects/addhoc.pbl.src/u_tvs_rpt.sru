$PBExportHeader$u_tvs_rpt.sru
forward
global type u_tvs_rpt from treeview
end type
end forward

global type u_tvs_rpt from treeview
integer width = 411
integer height = 324
string dragicon = "droparrow.ico"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","EditDataGrid!","PlaceColumn5!","Custom050!","Custom038!","sectiongreen.bmp"}
long picturemaskcolor = 536870912
string statepicturename[] = {""}
long statepicturemaskcolor = 536870912
event type long pfc_populate ( long al_parent )
event type long pfc_retrieve ( long al_parent,  any aa_argues[20] )
event type long pfc_addall ( long al_parent )
end type
global u_tvs_rpt u_tvs_rpt

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-06 By: Andy
n_cst_tvsrvattrib	inv_attrib[]

long	il_DragSource
//---------------------------- APPEON END ----------------------------


end variables

forward prototypes
public function integer of_reset ()
public function integer of_getnextlevel (long al_parent)
public function integer of_register (integer ai_level, string as_datacolumn, string as_labelcolumn, string as_retrieveargs, string as_dwobjectname, n_tr atr_obj, string as_filtercols)
public function integer of_getparentwindow (ref window aw_parent)
public function long of_populate (long al_parent, any aa_argues[20])
public function integer of_getargs (long al_parent, integer ai_level, ref any aa_arg[20])
public function long of_retrieve (long al_parent, any aa_argues[20])
public function integer of_reset (integer al_parent)
public function long of_finditem (any aa_l1, any aa_l2, any aa_l3)
end prototypes

event type long pfc_populate(long al_parent);//====================================================================
// Function: pfc_populate.u_tv_rpt()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	long	al_parent	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer li_level
any     la_args[20]

// check arguments
IF (al_parent < 0) or IsNull(al_parent) then Return -1

li_level = of_getnextlevel(al_parent)
of_getargs(al_parent, li_level, la_args)
// add the treeview data
Return this.of_populate(al_parent,la_args) 
end event

event type long pfc_retrieve(long al_parent, any aa_argues[20]);//====================================================================
// Function: pfc_retrieve.u_tvs_rpt()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long	al_parent	
// 	reference	n_ds	ads_data 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Return of_retrieve(al_parent, aa_argues)

 
end event

event type long pfc_addall(long al_parent);//====================================================================
// Function: pfc_addall.u_tvs_rpt()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	long	al_parent 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//				Andy		Date: Dec 10,2007
//====================================================================
long		ll_count=0
Long		ll_rowcount, ll_row,ll_i,ll_Cnt
TreeViewItem ltvi_item
Integer  li_nextlevel,li_Index
String   ls_ColType[]
String   ls_Col[],ls_value
any      la_val[]

// check the arguments
If (al_parent < 0) or isnull(al_parent) then Return -1

li_nextlevel = of_GetNextLevel(al_parent)
if li_nextlevel < 1 then Return -1

// Determine level 
li_Index = UpperBound(inv_attrib)
If li_nextlevel > li_Index Then
	Return -1
Else
	li_Index = li_nextlevel
End If

ls_Col[1] = inv_attrib[li_Index].is_Datacolumn
ls_Col[2]= inv_attrib[li_Index].is_labelcolumn
ls_ColType[1] =  inv_attrib[li_Index].ids_obj.describe(ls_Col[1] + ".ColType") 
ls_ColType[2] =  inv_attrib[li_Index].ids_obj.describe(ls_Col[2] + ".ColType")
//$<add> 02.20.2008 by Andy
if LenA(inv_attrib[li_Index].is_FilterCols) > 0 then
	ls_Col[3]    = inv_attrib[li_Index].is_FilterCols
	ls_ColType[3]=  inv_attrib[li_Index].ids_obj.describe(ls_Col[3] + ".ColType")
end if
//end of add 02.20.2008
ll_Cnt = UpperBound(ls_ColType)

// loop through the data and add the items
ll_rowcount = inv_attrib[li_Index].ids_obj.RowCount()

FOR ll_row = 1 to ll_rowcount
	FOR ll_i= 1 TO ll_Cnt
		ls_value = inv_attrib[li_Index].ids_obj.inv_base.of_getitem(ll_row,ls_Col[ll_i])
		
		Choose Case LeftA(ls_ColType[ll_i], 7)
			Case "integer", "long","double", "number"
				la_val[ll_i] = Long(ls_value)
			Case "decimal"
				la_val[ll_i] = dec(ls_value)				
			Case "date"
				la_val[ll_i] = date(ls_value)
			Case "time"
				la_val[ll_i] = time(ls_value)
			Case "datetim"
				la_val[ll_i] = datetime(ls_value)
			Case Else
				la_val[ll_i] = ls_value
		End Choose
	next
	
	ltvi_item.data  = la_val[1]
	ltvi_item.label = la_val[2]
	if li_Index = UpperBound(inv_attrib) then 
		ltvi_item.Children = False
	else
		ltvi_item.Children = True
	end if
	
	//$<modify> 02.20.2008 by Andy
	if ll_Cnt > 2 then
		if la_val[3] = '1' then
			ltvi_item.pictureindex = 6
			ltvi_item.Selectedpictureindex = 6
		else
			ltvi_item.pictureindex = li_Index
			ltvi_item.Selectedpictureindex = 5//li_Index
		end if
	else
		ltvi_item.pictureindex = li_Index
		ltvi_item.Selectedpictureindex = 5//li_Index
	end if	
	if li_Index = 1 then 
		ltvi_item.Selectedpictureindex = 4
//	else
//		ltvi_item.Selectedpictureindex = 5//li_Index
	end if
	//end of modify 02.20.2008

	this.InsertItemLast ( al_parent, ltvi_item )
	ll_count++
Next

return ll_count
end event

public function integer of_reset ();//====================================================================
// Event: .of_reset()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 06,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long 		ll_rootitem

//Delete all items from a TreeView control 
//when there are several items at the first level
DO UNTIL this.FindItem(RootTreeItem!, 0) = -1
	// Find the root of current level
	ll_rootitem = this.FindItem(RootTreeItem!, 0)
	//this.collapseItem(ll_rootitem)
	this.DeleteItem(ll_rootitem)
LOOP

Return 1
end function

public function integer of_getnextlevel (long al_parent);//====================================================================
// Event: u_tv_rpt.of_getnextlevel()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	long	al_parent	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer			li_level
treeviewitem	ltvi_item

// check the arguments
If (al_parent < 0) or IsNull(al_parent) Then Return -1

// determine the datastore level the parent will populate
If al_parent <> 0 Then
	If this.GetItem(al_parent, ltvi_item) <> 1 Then Return -1
	li_level = ltvi_item.level + 1
Else
	li_level = 1
End If

Return li_level
end function

public function integer of_register (integer ai_level, string as_datacolumn, string as_labelcolumn, string as_retrieveargs, string as_dwobjectname, n_tr atr_obj, string as_filtercols);//====================================================================
// Event: u_tv_rpt.of_register()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	ai_level       	
// 	value	string 	as_datacolumn  	
// 	value	string 	as_labelcolumn 	
// 	value	string 	as_retrieveargs	
// 	value	string 	as_dwobjectname	
// 	value	n_tr   	atr_obj        	
// 	value	string 	as_filtercols  	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer	li_NumDS, li_Cnt, li_rc
String	ls_rc, ls_columncount, ls_sqlerr
window	lw_parentwindow
n_ds		lds_test
String   ls_Band

// Check arguments
if IsNull (ai_level) or ai_level <= 0 or &
	LenA (as_datacolumn) = 0 or IsNull (as_datacolumn) or &
	LenA (as_labelcolumn) = 0 or IsNull (as_labelcolumn) or &
	LenA (as_DWobjectname) = 0 or IsNull (as_DWobjectname) then
	return -1
end if

li_NumDS = UpperBound(inv_attrib)

// Create a DataStore to use as the data source
If li_NumDS < ai_Level Then
	inv_attrib[ai_Level].ids_obj = Create n_ds
	inv_attrib[ai_Level].ids_obj.DataObject = as_DWobjectname
End If

// Set values in the structure array
inv_attrib[ai_Level].is_Dataobject = as_DWobjectname
inv_attrib[ai_Level].is_DataColumn = as_DataColumn
inv_attrib[ai_Level].is_LabelColumn = as_LabelColumn
inv_attrib[ai_Level].is_RetrieveArgs = as_RetrieveArgs
inv_attrib[ai_Level].is_FilterCols = as_filtercols
inv_attrib[ai_Level].itr_obj = atr_obj

// Set parameters for the DataStore
inv_attrib[ai_Level].ids_obj.of_SetBase(true)

// datastore needs parent window reference to perform updates
this.of_Getparentwindow(lw_parentwindow)
inv_attrib[ai_Level].ids_obj.of_SetParentWindow(lw_parentwindow)

// make sure transaction object is valid
If IsValid(atr_obj) Then
	If inv_attrib[ai_Level].ids_obj.of_SetTransObject(atr_obj) <> 1 Then 
		inv_attrib[ai_Level].is_Dataobject = ""
		Destroy inv_attrib[ai_Level].ids_obj
		Return -1
	End If
End If

Return 1

end function

public function integer of_getparentwindow (ref window aw_parent);//====================================================================
// Event: u_tv_rpt.of_getparentwindow()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	window	aw_parent	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
powerobject	lpo_parent

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) Or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

public function long of_populate (long al_parent, any aa_argues[20]);//====================================================================
// Event: u_tvs_rpt.of_populate()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	long	al_parent    	
// 	value	any 	aa_argues[20]	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

// check arguments
IF (al_parent < 0) or IsNull(al_parent) then Return -1

Setpointer(hourglass!)

// retrieve the data into the services datastore
IF this.event pfc_retrieve(al_parent, aa_argues) < 0 Then Return -1

// add the treeview data
Return this.event pfc_AddAll(al_parent) 

end function

public function integer of_getargs (long al_parent, integer ai_level, ref any aa_arg[20]);//====================================================================
// Event: u_tvs_rpt.of_getargs()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long   	al_parent 	
// 	value    	integer	ai_level  	
// 	reference	any    	aa_arg[20]	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//				Andy		Date: Dec 10,2007
//				Andy		Date: Dec 11,2007
//====================================================================
window lw_parent

this.of_getparentwindow( lw_parent)
IF IsValid(lw_parent) then 
	Return lw_parent.dynamic of_getargs( this, al_parent, ai_level, aa_arg)
end if

end function

public function long of_retrieve (long al_parent, any aa_argues[20]);//====================================================================
// Event: u_tvs_rpt.of_retrieve()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long	al_parent  	
// 	value    	any 	aa_args[20]	  	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer li_nextlevel,li_Index
Long    ll_rows

// Check Arguments
If (al_parent < 0) Or IsNull(al_parent) THEN RETURN -1

li_nextlevel = of_GetNextLevel(al_parent)
IF li_nextlevel < 1 THEN RETURN -1

// Determine level 
li_Index = UpperBound(inv_attrib)
IF li_nextlevel > li_Index THEN
	RETURN -1
ELSE
	li_Index = li_nextlevel
END IF

//Retrieve data
ll_rows = inv_attrib[li_Index].ids_obj.Retrieve(aa_argues[1], aa_argues[2], &
	aa_argues[3], aa_argues[4], aa_argues[5], aa_argues[6], aa_argues[7], &
	aa_argues[8], aa_argues[9], aa_argues[10], aa_argues[11], aa_argues[12], &
	aa_argues[13], aa_argues[14], aa_argues[15], aa_argues[16], aa_argues[17], &
	aa_argues[18], aa_argues[19], aa_argues[20])


//--------Begin Added by Nova 01.15.2009------------------------
//---------Begin Modified by (Appeon)Toney 11.19.2013 for V141 ISG-CLX--------
//$Reason:Fix history BugT102401,1-IntelliContract,2-IntelliCred/App,3-Other in d_view_module_all
  /*
	If (gb_contract_module = False)  And (li_nextlevel = 1) THEN
		String ls_temp = 'IntelliContract'
		inv_attrib[li_Index].ids_obj.SetFilter("name <>'"+ ls_temp +" '") //name
		inv_attrib[li_Index].ids_obj.Filter()
	END IF      
  */
 string ls_filter
 IF li_nextlevel = 1 THEN
	CHOOSE CASE True
		CASE gb_contract_version
			ls_filter = "Module <> 2"
		CASE Not gb_contract_module
			ls_filter = "Module <> 1"
		CASE ELSE
			ls_filter = ""
	END CHOOSE
	inv_attrib[li_Index].ids_obj.SetFilter(ls_filter)
	inv_attrib[li_Index].ids_obj.Filter()
 END IF
//---------End Modfiied ------------------------------------------------------------------

//--------End Added --------------------------------------------
RETURN ll_rows

end function

public function integer of_reset (integer al_parent);//====================================================================
// Event: .of_reset()
//--------------------------------------------------------------------
// Description:
//    Delete all child items from the parent item
//--------------------------------------------------------------------
// Arguments:
// 	value integer al_parent
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 12,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long 		ll_child
TreeViewItem ltvi_item

//delete child items
DO WHILE (1=1)
	ll_child = this.FindItem(ChildTreeItem!, al_parent)
	IF ll_child < 1  then exit
	
	this.DeleteItem(ll_child)	
LOOP

//set children = true
if this.GetItem(al_parent,ltvi_item) = 1 then
	ltvi_item.children = True
	this.setitem(al_parent,ltvi_item)
end if

Return 1
end function

public function long of_finditem (any aa_l1, any aa_l2, any aa_l3);//====================================================================
// Event: u_tvs_rpt.of_finditem()
//--------------------------------------------------------------------
// Description:FindItem
//--------------------------------------------------------------------
// Arguments:
// 	value	any	aa_l1	
// 	value	any	aa_l2	
// 	value	any	aa_l3	
//--------------------------------------------------------------------
// Returns:  (long) 
//--------------------------------------------------------------------
// Author:	Andy		Date: Feb 20,2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//				Andy    Date: 03.25.2008
//====================================================================
Long 		ll_Cnt
Long     ll_l1,ll_l2,ll_l3
TreeViewItem ltvi_item

//find level 1
ll_l1 = this.FindItem(RootTreeItem!, 0)
DO WHILE (1=1)
	IF ll_l1 < 1  then exit
	
	if this.GetItem(ll_l1,ltvi_item) = 1 then	
		if ltvi_item.data = aa_l1 then exit
	end if
	
	ll_l1 = this.FindItem(NextTreeItem!, ll_l1)
LOOP		

if ll_l1 <= 0 then
	return 0
end if

//find level 2
ll_l2 = this.FindItem(ChildTreeItem!, ll_l1)
DO WHILE (1=1)	
	IF ll_l2 < 1  then exit
	
	if this.GetItem(ll_l2,ltvi_item) = 1 then	
		if ltvi_item.data = aa_l2 then exit				
	end if
	
	ll_l2 = this.FindItem(NextTreeItem!, ll_l2)
LOOP		

if ll_l2 <= 0 then
	return 0
end if

ll_Cnt = UPPERBOUND(this.inv_attrib)
if ll_Cnt < 3 then
	return ll_l2
end if

//find level 3
ll_l3 = this.FindItem(ChildTreeItem!, ll_l2)
DO WHILE (1=1)
	IF ll_l3 < 1  then exit
	
	if this.GetItem(ll_l3,ltvi_item) = 1 then	
		if ltvi_item.data = aa_l3 then exit				
	end if
	
	ll_l3 = this.FindItem(NextTreeItem!, ll_l3)
LOOP

if ll_l3 > 0 then 
	return ll_l3
end if

return 0

end function

on u_tvs_rpt.create
end on

on u_tvs_rpt.destroy
end on

event itemexpanding;//====================================================================
// Function: itemexpanding.u_tv_rpt()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	long	handle	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 07,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer			li_rc,li_level
TreeViewItem	ltvi_This
any            la_args

If this.FindItem(ChildTreeItem!, handle) = -1 Then
	// No children, so populate
	if this.GetItem(handle, ltvi_This) = 1 then
		li_rc = this.event pfc_Populate(handle)
		If li_rc < 1 Then
			// nothing populated, so we have no children on this item
			ltvi_This.Children = False
			this.SetItem(handle, ltvi_This)
		End if
	End if
End If
end event

event begindrag;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-11 By: Andy
TreeViewItem ltvi_item
Long ll_Cnt

if this.GetItem( handle, ltvi_item) = 1 then
	ll_Cnt = UpperBound(inv_attrib)
	if ltvi_item.Level = ll_Cnt then
		il_DragSource = handle
		this.drag( Begin! )		
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

event dragdrop;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-11 By: Andy
Long       ll_Row
datawindow ldw_item
window     lw_parent

if source.typeof() = datawindow! then
	of_getparentwindow(lw_parent)
	/*
	ldw_item = source
	ll_Row = ldw_item.GetRow()
	ldw_item.DeleteRow( ll_Row )
	*/
	if isValid(lw_parent) then 
		//lw_parent.dynamic of_save()
		lw_parent.dynamic of_delete_row()
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

event doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.15.2008 By: Andy
window lw_parent

this.of_getparentwindow( lw_parent)
IF IsValid(lw_parent) then 
	lw_parent.dynamic of_tv_doubleclicked( handle )
end if
//---------------------------- APPEON END ----------------------------

end event

