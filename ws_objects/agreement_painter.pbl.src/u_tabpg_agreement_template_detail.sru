$PBExportHeader$u_tabpg_agreement_template_detail.sru
forward
global type u_tabpg_agreement_template_detail from u_tabpg
end type
type cb_properties from commandbutton within u_tabpg_agreement_template_detail
end type
type tv_clause from u_tvs within u_tabpg_agreement_template_detail
end type
type cbx_dynclauserules from checkbox within u_tabpg_agreement_template_detail
end type
type dw_formula from u_dw_ctx_find within u_tabpg_agreement_template_detail
end type
type st_hsplitbar from u_st_splitbar within u_tabpg_agreement_template_detail
end type
type st_vsplitbar from u_st_splitbar within u_tabpg_agreement_template_detail
end type
type dw_clause from u_dw within u_tabpg_agreement_template_detail
end type
type ole_1 from u_email_edit within u_tabpg_agreement_template_detail
end type
type ds_category_unauthorized from n_ds within u_tabpg_agreement_template_detail
end type
type ds_folder_distinct from n_ds within u_tabpg_agreement_template_detail
end type
type ds_folder from n_ds within u_tabpg_agreement_template_detail
end type
type ds_clause from n_ds within u_tabpg_agreement_template_detail
end type
type ds_folder_filtered from n_ds within u_tabpg_agreement_template_detail
end type
end forward

global type u_tabpg_agreement_template_detail from u_tabpg
integer width = 4027
integer height = 1960
string picturename = "ScriptYes!"
boolean ib_isupdateable = false
cb_properties cb_properties
tv_clause tv_clause
cbx_dynclauserules cbx_dynclauserules
dw_formula dw_formula
st_hsplitbar st_hsplitbar
st_vsplitbar st_vsplitbar
dw_clause dw_clause
ole_1 ole_1
ds_category_unauthorized ds_category_unauthorized
ds_folder_distinct ds_folder_distinct
ds_folder ds_folder
ds_clause ds_clause
ds_folder_filtered ds_folder_filtered
end type
global u_tabpg_agreement_template_detail u_tabpg_agreement_template_detail

type variables
w_agreement_template_painter iw_atp

DataStore ids_AttriValue		//Added by Scofield on 2010-01-27

Boolean	ib_GoToDoc = true

CONSTANT STRING ENTERCHAR = "~r~n"

n_cst_clause inv_clause //Added By Ken.Guo 2010-12-16.
end variables

forward prototypes
public function integer of_addclause ()
public function integer of_maponoff (boolean ab_flag)
public subroutine of_refreshclauserules ()
public subroutine of_dispclauserules (boolean ab_flag)
public function string of_getattribvaluelist (long al_clause_id)
public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle)
public function integer of_add_children (long al_handle, integer ai_folder_id)
public function integer of_build_tree ()
public function integer of_find_folder (long al_folder_id)
public function integer of_find_folder ()
public function integer of_filter_clause (string as_filter)
public function string of_generate_filter ()
public subroutine of_initdw ()
public subroutine of_refreshtreeview ()
public function long of_find_clause (long al_parent, long al_clause_id)
public subroutine of_setautolocatdoc (boolean ab_gotodoc)
end prototypes

public function integer of_addclause ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_detailof_addclause()
// $<arguments>(None)
// $<returns> integer
// $<description>Open add clause window
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
open(w_agreement_template_add_clause)

Return 1

end function

public function integer of_maponoff (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_detailof_maponoff()
// $<arguments>
//		boolean	ab_flag		
// $<returns> integer
// $<description>Adjust the size & location after map on or off
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

This.SetRedraw(false)

if ab_flag then 
	ole_1.Width = This.Width - tv_Clause.X - tv_Clause.Width - 38
	ole_1.X = tv_Clause.X + tv_Clause.Width + 20
	ole_1.Height = dw_Formula.Y - ole_1.Y - 20
	
	st_VSPlitbar.X = tv_Clause.X + tv_Clause.Width
	
	dw_Formula.X = Ole_1.X
	dw_Formula.Width = ole_1.Width
	dw_Formula.Height = tv_Clause.Height - dw_Formula.Y
	
	cb_Properties.X = dw_Formula.X + dw_Formula.Width - cb_Properties.Width
	
	//Add vertical splitbar jervis 01.40.2010
	st_VSPlitbar.of_Register(tv_Clause,st_VSPlitbar.LEFT)
	st_VSPlitbar.of_Register(cbx_DynClauseRules,st_VSPlitbar.LEFT)
	
	st_VSPlitbar.of_Register(ole_1,st_VSPlitbar.RIGHT)
	st_VSPlitbar.of_Register(st_HSplitBar,st_VSPlitbar.RIGHT)
	st_VSPlitbar.of_Register(dw_Formula,st_VSPlitbar.RIGHT)
	
	//BEGIN---Modify by Scofield on 2010-01-25
	st_HSplitBar.of_Register(tv_Clause,st_HSplitBar.LEFT)
	st_HSplitBar.of_Register(cbx_DynClauseRules,st_HSplitBar.LEFT)
	st_HSplitBar.of_Register(st_VSPlitbar,st_HSplitBar.LEFT)
	
	st_HSplitBar.of_Register(ole_1,st_HSplitBar.ABOVE)
	st_HSplitBar.of_Register(dw_Formula,st_HSplitBar.BELOW)
	//END---Modify by Scofield on 2010-01-25
	
	if isvalid(m_pfe_cst_agreement_template) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_maponoff,'toolbaritemdown', true)
	end if
else
	ole_1.Width = This.Width - tv_Clause.X - 18
	ole_1.X = tv_Clause.X
	ole_1.Height = This.Height - 140
	
	if isvalid(m_pfe_cst_agreement_template) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_maponoff,'toolbaritemdown', false)
	end if
end if

tv_Clause.Visible = ab_flag
tv_Clause.Enabled = ab_flag
st_VSPlitbar.Visible = ab_flag
st_HSplitBar.Visible = ab_flag
dw_Formula.Visible = ab_flag and cbx_DynClauseRules.Checked
cb_Properties.Visible = ab_flag and cbx_DynClauseRules.Checked
cbx_DynClauseRules.Visible = ab_flag

of_DispClauseRules(dw_Formula.Visible)

This.SetRedraw(true)

Return 1

end function

public subroutine of_refreshclauserules ();//====================================================================
// Function: of_RefreshClauseRules()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-20
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_CurRow,ll_clauseid,ll_template_id

ll_CurRow = dw_Clause.GetRow()

if ll_CurRow <= 0 or ll_CurRow > dw_Clause.RowCount() then Return

ll_clauseid    = dw_Clause.GetItemNumber(ll_CurRow,'ctx_acp_clause_id')
ll_template_id = dw_Clause.GetItemNumber(ll_CurRow,'ctx_acp_template_id')

dw_Formula.Retrieve(ll_template_id,ll_clauseid)

end subroutine

public subroutine of_dispclauserules (boolean ab_flag);//====================================================================
// Function: of_DispClauseRules()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    boolean    ab_flag
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-26
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
	
if ab_Flag then
	ole_1.Height = dw_Formula.Y - ole_1.Y - 20	
else
	ole_1.Height = dw_Formula.Y + dw_Formula.Height - ole_1.Y
end if

st_HSplitBar.Visible = ab_Flag
dw_Formula.Visible = ab_Flag
cb_Properties.Visible = ab_Flag

if IsValid(This.inv_resize) then
	This.inv_resize.of_SetOrigSize(This,This.X,This.Y,This.Width,This.Height)
	This.inv_resize.of_SetOrigSize(ole_1,ole_1.X,ole_1.Y,ole_1.Width,ole_1.Height)
	This.inv_resize.of_SetOrigSize(dw_Formula,dw_Formula.X,dw_Formula.Y,dw_Formula.Width,dw_Formula.Height)
end if

end subroutine

public function string of_getattribvaluelist (long al_clause_id);//====================================================================
// Function: of_GetAttribValueList()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_clause_id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-07
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_CurRow,ll_RowCnts
long		ll_Attribute_id,ll_First_Attr_id
String	ls_Clause_Alias,ls_Value_Code,ll_AttrLine[],ll_AttrList

ids_AttriValue.Retrieve(al_clause_id)

ll_RowCnts = ids_AttriValue.RowCount()
if ll_RowCnts <= 0 then Return ""

ll_CurRow++

ll_First_Attr_id = ids_AttriValue.GetItemNumber(ll_CurRow,"clause_attribute_id")
ls_Clause_Alias  = ids_AttriValue.GetItemString(ll_CurRow,"clause_attribute_alias")
ls_Value_Code    = ids_AttriValue.GetItemString(ll_CurRow,"clause_attribute_value_code")

ll_AttrList = ls_Clause_Alias + " = " + ls_Value_Code

do while ll_CurRow < ll_RowCnts
	ll_CurRow++
	ll_Attribute_id = ids_AttriValue.GetItemNumber(ll_CurRow,"clause_attribute_id")
	
	do while ll_First_Attr_id = ll_Attribute_id
		ls_Value_Code = ids_AttriValue.GetItemString(ll_CurRow,"clause_attribute_value_code")
		ll_AttrList += ", " + ls_Value_Code
		
		ll_CurRow++
		if ll_CurRow > ll_RowCnts then Exit
		ll_Attribute_id = ids_AttriValue.GetItemNumber(ll_CurRow,"clause_attribute_id")
	loop
	
	if ll_CurRow > ll_RowCnts then Exit

	ll_First_Attr_id = ll_Attribute_id
	ls_Clause_Alias  = ids_AttriValue.GetItemString(ll_CurRow,"clause_attribute_alias")
	ls_Value_Code    = ids_AttriValue.GetItemString(ll_CurRow,"clause_attribute_value_code")
	
	ll_AttrList += ENTERCHAR + ls_Clause_Alias + " = " + ls_Value_Code
loop

Return ll_AttrList

end function

public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle);//====================================================================
// Function: of_Create_Clause_Attribute()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_clause_id
// 	value    long    al_clause_handle
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-07
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_AttriList,ls_AttriLine
long		ll_EnterPos

TreeViewItem	ltvi_Item

ls_AttriList = of_GetAttribValueList(al_clause_id)
if IsNull(ls_AttriList) or Trim(ls_AttriList) = "" then Return

ls_AttriList += ENTERCHAR

ll_EnterPos = Pos(ls_AttriList,ENTERCHAR)
do while ll_EnterPos > 0
	ls_AttriLine = Left(ls_AttriList,ll_EnterPos - 1)
	ls_AttriList = Mid(ls_AttriList,ll_EnterPos + Len(ENTERCHAR))
	ll_EnterPos  = Pos(ls_AttriList,ENTERCHAR)
	
	if Not IsNull(ls_AttriLine) and ls_AttriLine <> "" then
		ltvi_Item.Label = ls_AttriLine
		ltvi_Item.data = al_clause_id
		ltvi_Item.PictureIndex = 6
		ltvi_Item.SelectedPictureIndex = 6
		tv_Clause.InsertItemLast(al_clause_handle, ltvi_Item)
	end if
loop

end subroutine

public function integer of_add_children (long al_handle, integer ai_folder_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libProperties -  tv_Clause  inherited  from  u_tvs()
// $<arguments>
//		long	al_handle   		
//		integer	ai_folder_id		
// $<returns> integer
// $<description> add all level of folders and clauses
//////////////////////////////////////////////////////////////////////
// $<add> 11.22.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
integer li_folder_id
long ll_cnt,ll_find,ll_handle,ll_cause_handle
long ll_cnt_clause,ll_find_clause,ll_clause_id,ll_handle_clause
string ls_folder_name,ls_clause_name
treeviewitem l_tvi,l_tvi_clause

//find the first child folder
ll_cnt = ds_folder_filtered.rowcount()
ll_find = ds_folder_filtered.find("parent_folder_id = "+string(ai_folder_id),1,ll_cnt)

if ll_find > 0 then //add child folders
	do while ll_find > 0
		li_folder_id = ds_folder_filtered.getitemnumber(ll_find,"ctx_acp_folder_id")
		ls_folder_name = ds_folder_filtered.getitemstring(ll_find,"folder_name")
		
		l_tvi.label = ls_folder_name
		l_tvi.data = li_folder_id
		l_tvi.pictureindex = 1
		l_tvi.overlaypictureIndex = 1
		l_tvi.selectedpictureindex = 2
		l_tvi.children = true
		
		ll_handle = tv_Clause.insertitemlast(al_handle,l_tvi)
		
		//add all level of folders recursively
		of_add_children(ll_handle,li_folder_id)
		
		//find next item at same level
		if ll_find < ll_cnt then
			ll_find = ds_folder_filtered.find("parent_folder_id = "+string(ai_folder_id),ll_find + 1,ll_cnt)
		else
			ll_find = 0
		end if
	loop
end if

//add clauses
ll_cnt_clause = ds_clause.rowcount()
ll_find_clause = ds_clause.find("ctx_acp_folder_id = "+string(ai_folder_id),1,ll_cnt_clause)
do while ll_find_clause > 0 
	ll_clause_id = ds_clause.getitemnumber(ll_find_clause,"ctx_acp_clause_id")
	ls_clause_name = ds_clause.getitemstring(ll_find_clause,"clause_name")
	
	l_tvi_clause.label = ls_clause_name
	l_tvi_clause.data = ll_clause_id
	l_tvi_clause.pictureindex = 3
	l_tvi_clause.overlaypictureIndex = 3
	l_tvi_clause.selectedpictureindex = 4
	
	ll_cause_handle = tv_Clause.insertitemlast(al_handle,l_tvi_clause)
	
	inv_clause.of_Create_Clause_Attribute(ll_clause_id,ll_cause_handle,tv_clause)	//Modified By Ken.Guo 2010-12-16. For performance
	//of_Create_Clause_Attribute(ll_clause_id,ll_cause_handle)			//Added by Scofield on 2010-01-11
	
	if ll_find_clause < ll_cnt_clause then
		ll_find_clause = ds_clause.find("ctx_acp_folder_id = "+string(ai_folder_id),ll_find_clause + 1,ll_cnt_clause)		
	else
		ll_find_clause = 0
	end if
loop

Return 1

end function

public function integer of_build_tree ();long		ll_Cycle,ll_RowCnts,ll_row
long		ll_Handle, ll_Root
long		ll_folder_id,ll_parent_id
String	ls_folder_name

TreeViewItem	ltvi_Item

//Clear The Treeview
ll_Handle = tv_Clause.FindItem(RootTreeItem!,0)
do while ll_Handle > 0
   tv_Clause.DeleteItem(ll_Handle)
	ll_Handle = tv_Clause.FindItem(RootTreeItem!,0)
loop

if dw_Clause.RowCount() <= 0 then
	dw_Formula.Reset()
	Return 1
end if

gnv_data.of_retrieve( 'clause_attribute' ) //Added By Ken.Guo 2010-12-16.

ltvi_Item.Label = "Clause Library"
ltvi_Item.Data = -1
ltvi_Item.Children = true
ltvi_Item.PictureIndex =1
ltvi_Item.OverlayPictureIndex = 1
ltvi_Item.SelectedPictureIndex = 2

ll_Root = tv_Clause.InsertItemLast(0,ltvi_Item)

tv_Clause.SetRedraw(false)

//Build Clause TreeView
ll_RowCnts = ds_folder_filtered.RowCount()
for ll_Cycle = 1 to ll_RowCnts 
	ll_parent_id = ds_folder_filtered.GetItemNumber(ll_Cycle,"parent_folder_id")
	if IsNull(ll_parent_id) then
		ll_folder_id = ds_folder_filtered.GetItemNumber(ll_Cycle,"ctx_acp_folder_id")
		ls_folder_name = ds_folder_filtered.GetItemstring(ll_Cycle,"folder_name")	
		if IsNull(ls_folder_name) then ls_folder_name = ""
		
		ltvi_Item.Label = ls_folder_name
		ltvi_Item.Data = ll_folder_id
		ltvi_Item.Children = true
		ltvi_Item.PictureIndex =1
		ltvi_Item.OverlayPictureIndex = 1
		ltvi_Item.SelectedPictureIndex = 2

		//Insert First Level TreeViewItem
		ll_Handle = tv_Clause.InsertItemLast(ll_Root,ltvi_Item)
		
		//Add Child Items Recursively
		of_add_Children(ll_Handle,ll_folder_id)
	end if
next

tv_Clause.ExpandItem(ll_Root)
tv_Clause.SortAll(ll_Root,Ascending!)
tv_Clause.SetRedraw(true)

Return 1

end function

public function integer of_find_folder (long al_folder_id);long		ll_Find,ll_RowCnts,ll_Row
long		li_folder_id, li_parent_id,ll_Grade
String	ls_folder_name,ls_filter

//Find The Folder
ll_RowCnts = ds_folder.RowCount()
ll_Find = ds_folder.Find("ctx_acp_folder_id = "+ String(al_folder_id),1,ll_RowCnts)

if ll_Find > 0 then
		//Get Folders From ds_folder
		ls_folder_name = ds_folder.GetItemString(ll_Find,"folder_name")
		ll_Grade = ds_folder.GetItemNumber(ll_Find,"grade")
		li_parent_id = ds_folder.GetItemNumber(ll_Find,"parent_folder_id")
		
		if Not IsNull(li_parent_id) then
			ls_filter = "ctx_acp_folder_id = " +String(al_folder_id) + " and parent_folder_id = " + String(li_parent_id)
		else
			ls_filter = "ctx_acp_folder_id = " +String(al_folder_id) + " and IsNull(parent_folder_id)"
		end if
		
	   //Insert folders into ds_folder_filtered with ignoring duplicated records
		if ds_folder_filtered.Find(ls_filter,1,ds_folder_filtered.RowCount()) < 1 then
			ll_Row = ds_folder_filtered.InsertRow(0)
			ds_folder_filtered.SetItem(ll_Row,"ctx_acp_folder_id",al_folder_id)
			ds_folder_filtered.SetItem(ll_Row,"folder_name",ls_folder_name)
			ds_folder_filtered.SetItem(ll_Row,"grade",ll_Grade)
		   ds_folder_filtered.SetItem(ll_Row,"parent_folder_id",li_parent_id)
		end if
		
	   if Not IsNull(li_parent_id) then 
			//if Not a root folder, Find the parent recursively 			
			of_Find_folder(li_parent_id) 
		end if
end if

Return 1

end function

public function integer of_find_folder ();long		ll_Cycle,ll_RowCnts
long		li_folder_id

ds_folder_filtered.Reset()

ll_RowCnts = ds_folder_distinct.RowCount()
if ll_RowCnts < 1 then Return -1

if ds_folder.RowCount() < 1 then Return -1

for ll_Cycle = 1 to ll_RowCnts
   //Get the distinct folder id from ds_folder_distinct
	li_folder_id = ds_folder_distinct.GetItemNumber(ll_Cycle,"ctx_acp_folder_id")

   //Find and store the folder and parent folders' info
	of_find_folder(li_folder_id)
next	
	
Return 1

end function

public function integer of_filter_clause (string as_filter);long		ll_folder_id_start, ll_folder_id_tmp
long		ll_Cycle,ll_RowCnts,ll_CurRow

//Filter clause datawindow
ds_Clause.SetFilter(as_Filter)
ds_Clause.Filter()

ll_RowCnts = ds_Clause.RowCount()

ds_folder_distinct.Reset()

//get distinct folder ids from ds_Clause into ds_folder_distinct
for ll_Cycle = 1 to ll_RowCnts
	ll_folder_id_start = ds_Clause.GetItemNumber(ll_Cycle,"ctx_acp_folder_id")
	if ll_folder_id_tmp  <> ll_folder_id_start then
		ll_CurRow = ds_folder_distinct.InsertRow(0)
		ds_folder_distinct.SetItem(ll_CurRow,"ctx_acp_folder_id",ll_folder_id_start)
		ll_folder_id_tmp = ll_folder_id_start 
	end if
next

Return 1

end function

public function string of_generate_filter ();long		ll_category,ll_Cycle,ll_RowCnts
String	ls_filter,ls_clause

if IsValid(iw_atp) and iw_atp.il_export_id > 0 then
	ls_filter += "and (export_id = " + String(iw_atp.il_export_id) 
	ls_filter += " or IsNull(export_id) ) "	
end if

ll_RowCnts = ds_category_unauthorized.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	if ll_Cycle = 1 then ls_filter += "and category not in ( "
	
	ls_filter += String(ds_category_unauthorized.GetItemNumber(ll_Cycle,'category'))
	
	if ll_Cycle <> ll_RowCnts then 
		ls_filter +=', '
	else
		ls_filter +=' ) '
	end if
next

ll_RowCnts = dw_Clause.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	if ll_Cycle = 1 then ls_filter += "and ctx_acp_clause_id in ( "
	
	ls_filter += String(dw_Clause.GetItemNumber(ll_Cycle,'ctx_acp_clause_id'))
	
	if ll_Cycle <> ll_RowCnts then 
		ls_filter +=', '
	else
		ls_filter +=' ) '
	end if
next

if left(ls_filter,4) = "and " then
	ls_filter = Right(ls_filter,len(ls_filter) - 4 )
end if

Return ls_filter

end function

public subroutine of_initdw ();gnv_appeondb.of_StartQueue()		//for web performance tuning
//Modify by Jervis - 02.09.2010
//ds_clause.Retrieve(iw_atp.il_clause_approved)
ds_clause.Retrieve()
ds_folder.Retrieve()
ds_category_unauthorized.Retrieve(gs_user_id)
gnv_data.of_retrieve( 'clause_attribute' ) //Added By Ken.Guo 2010-12-16.
inv_clause.of_Retrieve_attribute_value( )//added by gavins 20120723
gnv_appeondb.of_CommitQueue()		//for web performance tuning


end subroutine

public subroutine of_refreshtreeview ();String	ls_Filter

of_Initdw()
		
//Generate Filter String
ls_Filter= of_generate_filter()

//Filter Clauses In ds_Clause
of_filter_clause(ls_Filter)
of_find_folder()
of_build_tree()

end subroutine

public function long of_find_clause (long al_parent, long al_clause_id);//====================================================================
// Function: of_find_clause()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_parent
// 	value    long    al_clause_id
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Handle,ll_Child

TreeViewItem	ltvi_Item

ll_Handle = tv_Clause.FindItem(ChildTreeItem!,al_Parent)
do while ll_Handle > 0
	tv_Clause.GetItem(ll_Handle,ltvi_Item)
	if long(ltvi_Item.Data) = al_clause_id and ltvi_Item.PictureIndex <> 1 then Return ll_Handle
	ll_Child = of_Find_Clause(ll_Handle,al_clause_id)
	if ll_Child > 0 then Return ll_Child
	ll_Handle = tv_Clause.FindItem(NextTreeItem!,ll_Handle)
loop

Return -1

end function

public subroutine of_setautolocatdoc (boolean ab_gotodoc);//====================================================================
// Function: of_SetAutoLocatDoc()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    boolean    ab_GoToDoc
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

ib_GoToDoc = ab_GoToDoc

end subroutine

on u_tabpg_agreement_template_detail.create
int iCurrent
call super::create
this.cb_properties=create cb_properties
this.tv_clause=create tv_clause
this.cbx_dynclauserules=create cbx_dynclauserules
this.dw_formula=create dw_formula
this.st_hsplitbar=create st_hsplitbar
this.st_vsplitbar=create st_vsplitbar
this.dw_clause=create dw_clause
this.ole_1=create ole_1
this.ds_category_unauthorized=create ds_category_unauthorized
this.ds_folder_distinct=create ds_folder_distinct
this.ds_folder=create ds_folder
this.ds_clause=create ds_clause
this.ds_folder_filtered=create ds_folder_filtered
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_properties
this.Control[iCurrent+2]=this.tv_clause
this.Control[iCurrent+3]=this.cbx_dynclauserules
this.Control[iCurrent+4]=this.dw_formula
this.Control[iCurrent+5]=this.st_hsplitbar
this.Control[iCurrent+6]=this.st_vsplitbar
this.Control[iCurrent+7]=this.dw_clause
this.Control[iCurrent+8]=this.ole_1
end on

on u_tabpg_agreement_template_detail.destroy
call super::destroy
destroy(this.cb_properties)
destroy(this.tv_clause)
destroy(this.cbx_dynclauserules)
destroy(this.dw_formula)
destroy(this.st_hsplitbar)
destroy(this.st_vsplitbar)
destroy(this.dw_clause)
destroy(this.ole_1)
destroy(this.ds_category_unauthorized)
destroy(this.ds_folder_distinct)
destroy(this.ds_folder)
destroy(this.ds_clause)
destroy(this.ds_folder_filtered)
end on

event constructor;call super::constructor;iw_atp = iw_parent

inv_resize.of_SetdwZoom(false)

inv_clause = Create n_cst_clause
end event

event resize;call super::resize;//Added By Ken.Guo 2010-09-03.
ole_1.width = newwidth - 10
end event

event destructor;call super::destructor;IF IsValid(inv_clause) THEN Destroy inv_clause 
end event

type cb_properties from commandbutton within u_tabpg_agreement_template_detail
boolean visible = false
integer x = 3653
integer y = 1852
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Properties"
end type

event clicked;long		ll_Clause_ID,ll_ItemHandle,ll_RuleCnt

TreeViewItem ltvi_Item

ll_ItemHandle = tv_Clause.FindItem(CurrentTreeItem!,0)
if tv_Clause.GetItem(ll_ItemHandle,ltvi_Item) = 1 then
	if ltvi_Item.PictureIndex <> 1 then
		ll_Clause_ID = ltvi_Item.data
		if ll_Clause_ID > 0 then
			//Open the add rules window
			OpenWithParm(w_agreement_template_clause_rules,String(iw_atp.il_template_id) + "|" + String(ll_Clause_ID))
			//Refresh the selected clause
			ll_RuleCnt = Message.DoubleParm
			if ll_RuleCnt >= 0 then
				of_RefreshClauseRules()
			end if
		end if		
	end if
end if

end event

type tv_clause from u_tvs within u_tabpg_agreement_template_detail
boolean visible = false
integer x = 14
integer width = 1161
integer height = 1844
integer taborder = 20
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
boolean fullrowselect = true
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","Custom050!","MultiLineEdit!","RetrieveCancel!","sectiongreen.bmp","Properties!"}
string statepicturename[] = {"checkmark.bmp","check.bmp"}
end type

event constructor;call super::constructor;//BEGIN---Modify by Scofield on 2010-01-27
ids_AttriValue = Create DataStore
ids_AttriValue.DataObject = "d_acp_clause_attr_val_list"
ids_AttriValue.SetTransObject(SQLCA)
//END---Modify by Scofield on 2010-01-27

end event

event destructor;call super::destructor;Destroy ids_AttriValue						//Added by Scofield on 2010-01-27

end event

event selectionchanged;call super::selectionchanged;long	ll_Found,ll_clause_id,ll_

TreeViewItem ltvi_Item

if tv_Clause.GetItem(NewHandle,ltvi_Item) = 1 then
	if ltvi_Item.PictureIndex <> 1 then		//clause
		ll_clause_id = ltvi_Item.data
		
		ll_Found = dw_Clause.Find("ctx_acp_clause_id = " + String(ll_clause_id),1,dw_Clause.RowCount())
		if ll_Found > 0 then
			dw_Clause.ScrollToRow(ll_Found)
			dw_Clause.SetRow(ll_Found)
		end if
		of_RefreshClauseRules()
	else
		dw_Formula.Reset()
	end if
end if

end event

event rightclicked;boolean		lb_frame
long			ll_selected
winDow		lw_parent
winDow		lw_frame
winDow		lw_sheet
winDow		lw_childparent
m_tvs_clause lm_view
treeviewitem ltvi_item

// Determine If RMB popup menu should occur
If Not ib_rmbmenu Then
	Return 1
End If

//Begin - Added By Ken.Guo 2010-01-13. Do not show menu when click properties item.
tv_clause.GetItem(handle,ltvi_item)
If ltvi_item.PictureIndex = 5 Then
	Return 1
End If
//End - Added By Ken.Guo 2010-01-13.

// Determine parent winDow for PointerX, PointerY offset
this.of_GetParentWinDow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame winDow If available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.winDowtype = mdi! Or lw_frame.winDowtype = mdihelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWinDow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame winDow is available, use it as the reference point for the
		// popup menu for sheets (winDows opened with OpenSheet function) or child winDows
		If lw_parent.winDowtype = child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu If the parentwinDow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All winDows except for child winDows will use the parent
		// winDow of the control as the reference point for the popmenu
		If lw_parent.winDowtype = child! Then
			lw_childparent = lw_parent.ParentWinDow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
If IsNull(lm_view) Or Not IsValid (lm_view) Then
	lm_view = Create m_tvs_clause
	lm_view.of_SetParent (This)
End If

This.Event clicked(handle)

// Make rightclicked item the current item 
This.SelectItem (handle)

lm_view.m_viewitem.m_Sep_09.visible = False
lm_view.m_viewitem.m_addfolder.visible = False
lm_view.m_viewitem.m_addclause.visible = False
lm_view.m_viewitem.m_copyclause.visible = False
lm_view.m_viewitem.m_properties1.visible = False
lm_view.m_viewitem.m_delete1.visible = False
lm_view.m_viewitem.m_rules.visible = False
lm_view.m_viewitem.m_Sep_10.visible = False
lm_view.m_viewitem.m_export.visible = False

lm_view.m_viewitem.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

If IsValid(lm_view) Then Destroy lm_view

Return 1

end event

type cbx_dynclauserules from checkbox within u_tabpg_agreement_template_detail
boolean visible = false
integer x = 18
integer y = 1864
integer width = 1061
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Dynamic Clause Formula"
boolean checked = true
end type

event clicked;of_DispClauseRules(This.Checked)

end event

type dw_formula from u_dw_ctx_find within u_tabpg_agreement_template_detail
boolean visible = false
integer x = 1198
integer y = 1396
integer width = 2798
integer height = 448
integer taborder = 30
string dataobject = "d_template_clause_rules_display"
end type

event constructor;call super::constructor;This.Post Event ue_init_screen_dddw(gi_contract_view_id)		//Added by Scofield on 2010-01-20

end event

type st_hsplitbar from u_st_splitbar within u_tabpg_agreement_template_detail
boolean visible = false
integer x = 1179
integer y = 1380
integer width = 2821
integer height = 16
end type

type st_vsplitbar from u_st_splitbar within u_tabpg_agreement_template_detail
boolean visible = false
integer x = 1179
integer width = 18
integer height = 1956
end type

type dw_clause from u_dw within u_tabpg_agreement_template_detail
boolean visible = false
integer x = 14
integer width = 1161
integer height = 1844
integer taborder = 10
boolean enabled = false
string dataobject = "d_agreement_template_map"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
end type

event rowfocuschanged;call super::rowfocuschanged;if ib_GoToDoc then
	iw_atp.post event pfc_cst_locate_file() //Rodger wu moved it to Clicked event.
end if

end event

event constructor;call super::constructor;//of_SetRowManager(TRUE) //Rodger Wu commented.
of_SetRowSelect(TRUE)

//Prevent pop menu
this.ib_rmbmenu = false
end event

event getfocus;//
end event

event clicked;call super::clicked;if row > 0 then//Rodger Wu added.
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	iw_atp.post event pfc_cst_locate_file()
end if

end event

type ole_1 from u_email_edit within u_tabpg_agreement_template_detail
integer x = 5
integer width = 4018
integer height = 1956
integer taborder = 30
string binarykey = "u_tabpg_agreement_template_detail.udo"
end type

event constructor;call super::constructor;this.object.menubar(true)
end event

type ds_category_unauthorized from n_ds within u_tabpg_agreement_template_detail descriptor "pb_nvo" = "true" 
string dataobject = "d_dm_category_unauthorized"
boolean ib_isupdateable = false
end type

on ds_category_unauthorized.create
call super::create
end on

on ds_category_unauthorized.destroy
call super::destroy
end on

event constructor;call super::constructor;this.of_SetTransObject(SQLCA)

end event

type ds_folder_distinct from n_ds within u_tabpg_agreement_template_detail descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_flddist"
boolean ib_isupdateable = false
end type

on ds_folder_distinct.create
call super::create
end on

on ds_folder_distinct.destroy
call super::destroy
end on

type ds_folder from n_ds within u_tabpg_agreement_template_detail descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_folder"
boolean ib_isupdateable = false
end type

on ds_folder.create
call super::create
end on

on ds_folder.destroy
call super::destroy
end on

event constructor;call super::constructor;This.of_SetTransObject(SQLCA)

end event

type ds_clause from n_ds within u_tabpg_agreement_template_detail descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_all"
boolean ib_isupdateable = false
end type

on ds_clause.create
call super::create
end on

on ds_clause.destroy
call super::destroy
end on

event constructor;call super::constructor;This.of_SetTransObject(SQLCA)

end event

type ds_folder_filtered from n_ds within u_tabpg_agreement_template_detail descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_fldcls"
boolean ib_isupdateable = false
end type

on ds_folder_filtered.create
call super::create
end on

on ds_folder_filtered.destroy
call super::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Du_tabpg_agreement_template_detail.bin 
2800000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000b582f2d001cf4a2f00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000b582f2d001cf4a2fb582f2d001cf4a2f0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00005ad90000328a00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00005ad90000328a00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Du_tabpg_agreement_template_detail.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
