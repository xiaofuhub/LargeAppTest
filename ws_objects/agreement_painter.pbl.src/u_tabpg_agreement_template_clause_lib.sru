$PBExportHeader$u_tabpg_agreement_template_clause_lib.sru
forward
global type u_tabpg_agreement_template_clause_lib from u_tabpg
end type
type cb_compare from commandbutton within u_tabpg_agreement_template_clause_lib
end type
type cb_go from commandbutton within u_tabpg_agreement_template_clause_lib
end type
type cb_collapseall from commandbutton within u_tabpg_agreement_template_clause_lib
end type
type cb_expandall from commandbutton within u_tabpg_agreement_template_clause_lib
end type
type cb_collapseitem from commandbutton within u_tabpg_agreement_template_clause_lib
end type
type cb_expanditem from commandbutton within u_tabpg_agreement_template_clause_lib
end type
type tv_1 from u_tvs within u_tabpg_agreement_template_clause_lib
end type
type dw_filter from u_dw_contract within u_tabpg_agreement_template_clause_lib
end type
type gb_1 from groupbox within u_tabpg_agreement_template_clause_lib
end type
type pb_attrifilter from picturebutton within u_tabpg_agreement_template_clause_lib
end type
type ds_category_unauthorized from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_rely_temp from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_rely_filtered from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_clause_included from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_rely from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_folder_distinct from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_folder_filtered from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_folder from n_ds within u_tabpg_agreement_template_clause_lib
end type
type ds_clause from n_ds within u_tabpg_agreement_template_clause_lib
end type
end forward

global type u_tabpg_agreement_template_clause_lib from u_tabpg
integer width = 1577
integer height = 2676
long backcolor = 33551856
boolean ib_isupdateable = false
event pfc_cst_go ( )
event pfc_cst_expanditem ( )
event pfc_cst_expandall ( )
event pfc_cst_collapseitem ( )
event pfc_cst_collapseall ( )
cb_compare cb_compare
cb_go cb_go
cb_collapseall cb_collapseall
cb_expandall cb_expandall
cb_collapseitem cb_collapseitem
cb_expanditem cb_expanditem
tv_1 tv_1
dw_filter dw_filter
gb_1 gb_1
pb_attrifilter pb_attrifilter
ds_category_unauthorized ds_category_unauthorized
ds_rely_temp ds_rely_temp
ds_rely_filtered ds_rely_filtered
ds_clause_included ds_clause_included
ds_rely ds_rely
ds_folder_distinct ds_folder_distinct
ds_folder_filtered ds_folder_filtered
ds_folder ds_folder
ds_clause ds_clause
end type
global u_tabpg_agreement_template_clause_lib u_tabpg_agreement_template_clause_lib

type variables
w_agreement_template_add_clause iw_atac

n_cst_clause_comparison inv_clause_comparison 	//Added by Alfee 10.18.2007

DataStore ids_AttriValue								//Added by Scofield on 2010-01-11

str_clause_filter	istr_ClauseFilter					//Added by Scofield on 2010-01-14

CONSTANT STRING ENTERCHAR = "~r~n"

n_cst_clause inv_clause //Added By Ken.Guo 2010-12-16.

DataStore ids_clause_tvi_map //Added By Ken.Guo 2010-12-22.
end variables

forward prototypes
public function integer of_filter_clause (string as_filter)
public function integer of_find_folder (integer ai_folder_id)
public function integer of_find_folder ()
public function string of_generate_filter ()
public function integer of_build_tree ()
public function integer of_add_children (long al_handle, integer ai_folder_id)
public function integer of_find_clause (integer ai_folder_id)
public function integer of_find_relied ()
public function boolean of_find_relied (long al_clause_id)
public function integer of_find_rely (long al_clause_id)
public function integer of_locate_clause (long al_clause_id)
public function integer of_locate_clause (long al_clause_id, long al_handle)
public function integer of_set_treeview (long al_clause_id, boolean ab_flag)
public function integer of_set_treeview (long al_clause_id, long al_handle, boolean ab_flag)
public function integer of_compare_clauses ()
public function string of_getattribvaluelist (long al_clause_id)
public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle)
public subroutine of_refreshfilterpicture ()
public function long of_get_handle (long al_clause_id)
end prototypes

event pfc_cst_go();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_gou_tabpg_agreement_template_clause_lib()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Go operation for query of clauses 
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
string ls_filter
integer i
 
SetPointer(HourGlass!) //12.10.2008

//generate filter string
ls_filter= of_generate_filter()

//filter clauses in ds_clause
of_filter_clause(ls_filter)

//find all related folders
of_find_folder()

//build clause tree
of_build_tree()

//Begin - Modified By Ken.Guo 2010-12-22
//set treeview item
/*
for i = 1 to iw_atac.dw_selected.rowcount() 
	//of_set_treeview(iw_atac.dw_selected.object.ctx_acp_clause_id[i],true)
next
*/
Long ll_clause_id,ll_tvi_handle,ll_cnt,ll_cnt2,ll_find
ll_cnt = iw_atac.dw_selected.rowcount() 

For i = 1 To ll_cnt
	ll_clause_id = iw_atac.dw_selected.GetItemNumber(i,'ctx_acp_clause_id')
	ll_tvi_handle = This.of_get_handle( ll_clause_id )
	If ll_tvi_handle > 0 Then
		of_set_treeview(ll_clause_id,ll_tvi_handle,true)
	End If
Next
//End - Modified By Ken.Guo 2010-12-22



end event

event pfc_cst_expanditem();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_expanditemu_tabpg_agreement_template_clause_lib()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Expand the current treeview item
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_tvi

ll_tvi = tv_1.finditem(currenttreeitem!, 0)
tv_1.expanditem(ll_tvi)
end event

event pfc_cst_expandall();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_expandallu_tabpg_agreement_template_clause_lib()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Expand all treeview items
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_tvi

ll_tvi = tv_1.finditem(roottreeitem!, 0)
do while ll_tvi > 0 
	tv_1.expandall(ll_tvi)
	ll_tvi = tv_1.finditem(NextTreeItem!, ll_tvi)
loop
end event

event pfc_cst_collapseitem();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_collapseitemu_tabpg_agreement_template_clause_lib()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Collapse the current treeview item
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_tvi

ll_tvi = tv_1.finditem(currenttreeitem!, 0)
tv_1.collapseitem(ll_tvi)

end event

event pfc_cst_collapseall();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_collapseallu_tabpg_agreement_template_clause_lib()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Collapse all treeview items
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

long ll_tvi

ll_tvi = tv_1.finditem(roottreeitem!, 0)
do while ll_tvi > 0 
	tv_1.collapseitem(ll_tvi)
	ll_tvi = tv_1.finditem(NextTreeItem!, ll_tvi)
loop
end event

public function integer of_filter_clause (string as_filter);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_filter_clause()
// $<arguments>
//		value	string	as_filter		
// $<returns> integer
// $<description>filter clauses according to the search condition
//////////////////////////////////////////////////////////////////////
// $<add> 11.21.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
integer li_folderid, li_folderid_tmp
long ll_cnt,ll_row,i

//filter clause datawindow
ds_clause.setfilter(as_filter)
ds_clause.filter()

ll_cnt = ds_clause.rowcount()
ds_folder_distinct.reset()

//get distinct folder ids from ds_clause into ds_folder_distinct
for i =  1 to ll_cnt
	li_folderid = ds_clause.getitemnumber(i,"ctx_acp_folder_id")
	if li_folderid_tmp  <> li_folderid then
		ll_row = ds_folder_distinct.insertrow(0)
		ds_folder_distinct.setitem(ll_row,"ctx_acp_folder_id",li_folderid)
		li_folderid_tmp = li_folderid 
	end if
next

return 1
end function

public function integer of_find_folder (integer ai_folder_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_find_folder()
// $<arguments>
//		value	integer	ai_folder_id		
// $<returns> integer
// $<description>Get all folders related to clauses recursively
//////////////////////////////////////////////////////////////////////
// $<add> 11.21.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

long ll_find,ll_cnt,ll_row
integer li_folder_id, li_parent_id,li_grade
string ls_folder_name,ls_filter

//find the folder
ll_cnt = ds_folder.rowcount()
ll_find = ds_folder.find("ctx_acp_folder_id = "+ string(ai_folder_id),1,ll_cnt) 

if ll_find > 0 then
		//get folders from ds_folder
		ls_folder_name = ds_folder.getitemstring(ll_find,"folder_name")
		li_grade = ds_folder.getitemnumber(ll_find,"grade")
		li_parent_id = ds_folder.getitemnumber(ll_find,"parent_folder_id")
		if not isnull(li_parent_id) then 
			ls_filter = "ctx_acp_folder_id = " +string(ai_folder_id) + &
						" and parent_folder_id = " + string(li_parent_id)
		else
			ls_filter = "ctx_acp_folder_id = " +string(ai_folder_id) + &
						" and isnull(parent_folder_id)"
		end if
						
	   //insert folders into ds_folder_filtered with ignoring duplicated records
		if ds_folder_filtered.find(ls_filter,1,ds_folder_filtered.rowcount()) < 1 then
			ll_row = ds_folder_filtered.insertrow(0)
			ds_folder_filtered.setitem(ll_row,"ctx_acp_folder_id",ai_folder_id)
			ds_folder_filtered.setitem(ll_row,"folder_name",ls_folder_name)
			ds_folder_filtered.setitem(ll_row,"grade",li_grade)
		   ds_folder_filtered.setitem(ll_row,"parent_folder_id",li_parent_id)
		end if			
	   if not isnull(li_parent_id) then 
			//if not a root folder, find the parent recursively 			
			of_find_folder(li_parent_id) 
		end if
end if

return 1
end function

public function integer of_find_folder ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_find_folder()
// $<arguments>(None)
// $<returns> integer
// $<description>Get all folders and parent folders related to clauses
//////////////////////////////////////////////////////////////////////
// $<add> 11.21.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_cnt,ll_row,ll_find,i,j
integer li_folder_id,li_parent_id,li_grade
string ls_folder_name

ds_folder_filtered.reset()  //by Alfee 05.16.2007

ll_cnt = ds_folder_distinct.rowcount()
if ll_cnt < 1 then return -1
if ds_folder.rowcount() < 1 then return -1

//ds_folder_filtered.reset() //Moved up by Alfee 05.16.2007

for i = 1 to ll_cnt
   //Get the distinct folder id from ds_folder_distinct
	li_folder_id = ds_folder_distinct.getitemnumber(i,"ctx_acp_folder_id")

   //Find and store the folder and parent folders' info
	of_find_folder(li_folder_id)
next	
	
return 1
end function

public function string of_generate_filter ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_lib.of_generate_filter()
// $<arguments>(None)
// $<returns> string
// $<description>Generate the filter string for ds_clause
//////////////////////////////////////////////////////////////////////
// $<add> 11.22.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
string ls_filter,ls_clause
long ll_category, i, ll_cnt

dw_filter.accepttext()
ll_category = dw_filter.getitemnumber(1,"category")
ls_clause = dw_filter.getitemstring(1,"clause_name")

if not isnull(ll_category) then 
	ls_filter += "and category = " + string(ll_category) + " "
end if
if len(trim(ls_clause)) > 0 then 
	ls_filter += "and pos(lower(clause_name), '" + lower(ls_clause) + "') > 0 " 
end if

//----------Begin Added by Alfee 00.03.2007-----------------
//Set filter on export id
IF IsValid(iw_atac) and iw_atac.il_export_id > 0 THEN
	ls_filter += "and (export_id = " + String(iw_atac.il_export_id) 
	ls_filter += " or IsNull(export_id) ) "	
END If
//----------End Added --------------------------------------

//----------Begin Added by Alfee 07.26.2007-----------------
//<$Reason>Generate the filter of unauthorized category
ll_cnt = ds_category_unauthorized.RowCount()
FOR i = 1 to ll_cnt
	IF i = 1 THEN ls_filter += "and category not in ( "
	ls_filter += String(ds_category_unauthorized.GetItemNumber(i, 'category'))
	IF i <> ll_cnt THEN 
		ls_filter +=', '
	ELSE
		ls_filter +=' ) '
	END IF
NEXT	
//----------End Added --------------------------------------

if left(ls_filter,4) = "and " then 
	ls_filter = right(ls_filter, len(ls_filter)-4 )
end if

if istr_ClauseFilter.Clause_Exp <> "" then
	if ls_filter <> "" then ls_filter += " and "
	ls_filter += "ctx_acp_clause_id in " + istr_ClauseFilter.Clause_Exp
end if

Return ls_filter

end function

public function integer of_build_tree ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_build_tree()
// $<arguments>(None)
// $<returns> integer
// $<description>Buile the clause tree
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long i,ll_cnt,ll_row
long ll_handle, ll_root
integer li_folder_id,li_parent_id
string ls_folder_name
treeviewitem litv_item

//ll_cnt = ds_folder_filtered.rowcount()
//if ll_cnt < 1 then return -1

//clear the treeview
ll_handle = tv_1.finditem(roottreeitem!, 0)
do while ll_handle > 0 
   tv_1.deleteitem(ll_handle)
	ll_handle = tv_1.finditem(roottreeitem!, 0)
loop

//--------Begin Modified by Alfee 05.16.2007--------
//<$Reason> Moved from the above 
ll_cnt = ds_folder_filtered.rowcount()
//--------Begin Modified by Alfee 10.18.2007---------
//if ll_cnt < 1 then return -1
if ll_cnt < 1 then 
	if IsValid(inv_clause_comparison) then inv_clause_comparison.of_close_comparison_wizard('template') 
	return -1
end if
//--------End Modified------------------------------
//--------End Modified------------------------------

//--------Begin Added by Alfee 05.18.2007--------------------------------------
//<$Reason> Add a root item to the treeview for a bug on sort function under web 
litv_item.label = 'Clause Library'
litv_item.data = -1
litv_item.children = true
litv_item.pictureindex =1
litv_item.overlaypictureIndex = 1
litv_item.selectedpictureindex = 2
ll_root = tv_1.insertitemlast(0,litv_item)
//--------Begin Modified by Alfee 10.18.2007---------
//if ll_root = -1 then return -1
if ll_root = -1 then 
	if IsValid(inv_clause_comparison) then inv_clause_comparison.of_close_comparison_wizard('template')  
	return -1
end if
//--------End Modified------------------------------

tv_1.setredraw(false)
//--------End Added--------------------------------------------------------------

gnv_data.of_retrieve( 'clause_attribute' ) //Added By Ken.Guo 2010-12-16.

ids_clause_tvi_map.Reset() //Added By Ken.Guo 2010-12-22.

//build clause treeview
for i = 1 to ll_cnt 
	li_parent_id = ds_folder_filtered.getitemnumber(i,"parent_folder_id")
	if isnull(li_parent_id) then //root
		
		//set the treeviewitem
		li_folder_id = ds_folder_filtered.getitemnumber(i,"ctx_acp_folder_id")
		ls_folder_name = ds_folder_filtered.getitemstring(i,"folder_name")	
		if isnull(ls_folder_name) then ls_folder_name = ""
		litv_item.label = ls_folder_name
		litv_item.data = li_folder_id
		litv_item.children = true
		litv_item.pictureindex =1
		litv_item.overlaypictureIndex = 1
		litv_item.selectedpictureindex = 2

		//insert first level treeviewitem
		ll_handle = tv_1.insertitemlast(ll_root,litv_item) //Alfee 05.18.2007
		//ll_handle = tv_1.insertitemlast(0,litv_item)
		
		//add child items recursively
		of_add_children(ll_handle,li_folder_id)
	end if
next

//--------Begin Added by Alfee 05.18.2007----------------
tv_1.expanditem(ll_root)
tv_1.sortall(ll_root, Ascending!)
tv_1.setredraw(true)
//--------End Added--------------------------------------

//Close clause comparison window - by Alfee 10.18.2007
if IsValid(inv_clause_comparison) then inv_clause_comparison.of_close_comparison_wizard('template') 

return 1


end function

public function integer of_add_children (long al_handle, integer ai_folder_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libProperties -  tv_1  inherited  from  u_tvs()
// $<arguments>
//		long	al_handle   		
//		integer	ai_folder_id		
// $<returns> integer
// $<description> add all level of folders and clauses
//////////////////////////////////////////////////////////////////////
// $<add> 11.22.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
integer li_folder_id
long ll_cnt,ll_find,ll_handle,ll_cause_handle,ll_row
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
		
		ll_handle = tv_1.insertitemlast(al_handle,l_tvi)
		
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
		
	ll_cause_handle = tv_1.insertitemlast(al_handle,l_tvi_clause)
	
	//Added By Ken.Guo 2010-12-22.
	ll_row = ids_clause_tvi_map.InsertRow(0)
	ids_clause_tvi_map.SetItem(ll_row,'clause_id',ll_clause_id)
	ids_clause_tvi_map.SetItem(ll_row,'tvi_handle',ll_cause_handle)
	
	
//	inv_clause.of_Create_Clause_Attribute(ll_clause_id,ll_cause_handle,tv_1)	//Modified By Ken.Guo 2010-12-16. For performance //modified by gavins
	//of_Create_Clause_Attribute(ll_clause_id,ll_cause_handle)			//Added by Scofield on 2010-01-11
		
	if ll_find_clause < ll_cnt_clause then
		ll_find_clause = ds_clause.find("ctx_acp_folder_id = "+string(ai_folder_id),ll_find_clause + 1,ll_cnt_clause)		
	else
		ll_find_clause = 0
	end if			
loop

Return 1

end function

public function integer of_find_clause (integer ai_folder_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_lib.of_find_clause()
// $<arguments>
//		value	integer	ai_folder_id		
// $<returns> integer
// $<description>find and store all clauses under the specified folder
//////////////////////////////////////////////////////////////////////
// $<add> 11.23.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_cnt, ll_find
long ll_cnt_clause,ll_find_clause,ll_clause_id,ll_row
integer li_folder_id
string ls_clause_name
datetime ldt_modify_date

ll_cnt = ds_folder_filtered.rowcount()
ll_cnt_clause = ds_clause.rowcount()

//find and store all included clauses under current folder
ll_find_clause = ds_clause.find("ctx_acp_folder_id = " + string(ai_folder_id),1,ll_cnt_clause)
do while ll_find_clause > 0
	ll_clause_id = ds_clause.getitemnumber(ll_find_clause,"ctx_acp_clause_id")
	ls_clause_name = ds_clause.getitemstring(ll_find_clause,"clause_name")
	ldt_modify_date = ds_clause.getitemdatetime(ll_find_clause,"modify_date")
	ll_row = ds_clause_included.insertrow(0)
	ds_clause_included.setitem(ll_row,"ctx_acp_clause_id",ll_clause_id)
	ds_clause_included.setitem(ll_row,"clause_name",ls_clause_name)	
	ds_clause_included.setitem(ll_row,"modify_date",ldt_modify_date)		
	if ll_find_clause < ll_cnt_clause then
		ll_find_clause = ds_clause.find("ctx_acp_folder_id = " + string(ai_folder_id),ll_find_clause + 1,ll_cnt_clause)	
	else
		ll_find_clause = 0
	end if
loop

//find all included folders 
ll_find = ds_folder_filtered.find("parent_folder_id = " + string(ai_folder_id),1,ll_cnt)
do while ll_find > 0
	li_folder_id = ds_folder_filtered.getitemnumber(ll_find,"ctx_acp_folder_id")
	
	//find and store all clauses under the current included folder
	ll_find_clause = ds_clause.find("ctx_acp_folder_id = " + string(li_folder_id),1,ll_cnt_clause)
	do while ll_find_clause > 0
		ll_clause_id = ds_clause.getitemnumber(ll_find_clause,"ctx_acp_clause_id")
		ls_clause_name = ds_clause.getitemstring(ll_find_clause,"clause_name")
		ldt_modify_date = ds_clause.getitemdatetime(ll_find_clause,"modify_date")
		ll_row = ds_clause_included.insertrow(0)
		ds_clause_included.setitem(ll_row,"ctx_acp_clause_id",ll_clause_id)
		ds_clause_included.setitem(ll_row,"clause_name",ls_clause_name)	
		ds_clause_included.setitem(ll_row,"modify_date",ldt_modify_date)		
		if ll_find_clause < ll_cnt_clause then
			ll_find_clause = ds_clause.find("ctx_acp_folder_id = " + string(li_folder_id),ll_find_clause + 1,ll_cnt_clause)	
		else
			ll_find_clause = 0
		end if
	loop

	of_find_clause(li_folder_id) //find child folder recursively
	
	//find next included folder
	if ll_find < ll_cnt then
		ll_find = ds_folder_filtered.find("parent_folder_id = " + string(ai_folder_id),ll_find+1,ll_cnt)		
	else
		ll_find = 0
	end if		
loop

return 1


end function

public function integer of_find_relied ();long ll_cnt, ll_cnt_rely, ll_find, ll_row, i
long ll_clause_id, ll_approval_status
integer li_rtn //indicate approval status of included clauses 

li_rtn = 1
ll_cnt = ds_clause_included.rowcount()
ds_rely_filtered.reset()

//get relied clauses into ds_rely_filtered
for i = 1 to ll_cnt 
	ds_rely_temp.reset() 		
	ll_clause_id = ds_clause_included.object.ctx_acp_clause_id[i]
	
	//find all relied clauses and store it into ds_rely_temp.
	if of_find_relied(ll_clause_id) = true then
		//If all relied claues approved, copy it into ds_rely_filtered
		ds_rely_temp.rowscopy(1,ds_rely_temp.rowcount(), primary!, &
			ds_rely_filtered, ds_rely_filtered.rowcount() + 1, Primary!)
		//set approval mark 1
		ds_clause_included.setitem(i,"approval_mark",1)
	else
		//set approval mark and return value 0  
		ds_clause_included.setitem(i,"approval_mark",0)
		li_rtn = -1
	end if
next

//merge relied clauses into included clauses
ll_cnt_rely = ds_rely_filtered.rowcount()
for i = 1 to ll_cnt_rely
	ll_row = ds_clause_included.insertrow(0)
	ds_clause_included.object.ctx_acp_clause_id[ll_row] = ds_rely_filtered.object.ctx_acp_clause_rely_id[i]
	ds_clause_included.object.clause_name[ll_row] = ds_rely_filtered.object.clause_name[i]
	ds_clause_included.object.modify_date[ll_row] = ds_rely_filtered.object.modify_date[i]	
	ds_clause_included.object.approval_mark[ll_row] = 1		
next

return li_rtn
end function

public function boolean of_find_relied (long al_clause_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_lib.of_find_relied()
// $<arguments>
//		value	long	al_clause_id		
// $<returns> boolean
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.24.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_find,ll_cnt,ll_rely_id

//Get relied clauses into temporary ds.
ll_cnt = ds_rely.rowcount()
ll_find = ds_rely.find("ctx_acp_clause_id = "+string(al_clause_id),1,ll_cnt)

do while ll_find > 0
	//If the relied caluse not approved, stop and return false .
	if ds_rely.getitemnumber(ll_find,"approval_status") <> w_agreement_template_painter.il_clause_approved then 
		return false	
	end if		
	//Insert the clause into ds_rely_temp.
	ds_rely_temp.object.data[ds_rely_temp.insertrow(0)] = ds_rely.object.data[ll_find]

	//Find all the relied clauses recursively, return false if last call return false 
	ll_rely_id = ds_rely.getitemnumber(ll_find,"ctx_acp_clause_rely_id")
	if of_find_relied(ll_rely_id) = false then return false

	//Find next relied clause
	if ll_find < ll_cnt then
		ll_find = ds_rely.find("ctx_acp_clause_id = "+string(al_clause_id),ll_find + 1,ll_cnt)
	else
		ll_find = 0
	end if				
loop

return true
end function

public function integer of_find_rely (long al_clause_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_find_rely()
// $<arguments>
//		value	long	al_clause_id		
// $<returns> integer
// $<description>find clauses which rely on the specified clause
//////////////////////////////////////////////////////////////////////
// $<add> 11.24.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_cnt,ll_row,i,ll_find
long ll_clause_id

ll_cnt = ds_rely.rowcount()
if ll_cnt < 1 then return -1

ll_find = ds_rely.find("ctx_acp_clause_rely_id = "+string(al_clause_id),1,ll_cnt)
do while ll_find > 0 
	//Insert the clause into ds_rely_included.
	ll_row = ds_clause_included.insertrow(0)
	ds_clause_included.object.ctx_acp_clause_id[ll_row] = ds_rely.object.ctx_acp_clause_id[ll_find]
	ds_clause_included.object.clause_name[ll_row] = ds_rely.object.clause_name[ll_find]
	ds_clause_included.object.modify_date[ll_row] = ds_rely.object.modify_date[ll_find]
	
	//Find clauses recursively, 
	ll_clause_id = ds_rely.object.ctx_acp_clause_id[ll_find]
	of_find_rely(ll_clause_id) 
		
	//Find next clause
	if ll_find < ll_cnt then
		ll_find = ds_rely.find("ctx_acp_clause_rely_id = "+string(al_clause_id),ll_find + 1,ll_cnt)
	else
		ll_find = 0
	end if			
loop

return 1

end function

public function integer of_locate_clause (long al_clause_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_locate_clause()
// $<arguments>
//		value	long	al_clause_id		
// $<returns> integer
// $<description>Locate the specified clause in clause tree
//////////////////////////////////////////////////////////////////////
// $<add> 11.24.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
integer li_rtn
long ll_handle
treeviewitem l_tvi

if isnull(al_clause_id) then return -1

//find firstly in current node
ll_handle = tv_1.finditem(CurrentTreeItem!,0)
if ll_handle > 0 then
	tv_1.getitem(ll_handle,l_tvi)
	if l_tvi.PictureIndex <> 1 and l_tvi.data = al_clause_id then
//		l_tvi.OverlayPictureIndex = 5
		return 1
	end if
end if

//find the clause in full tree
tv_1.setredraw(false)
ll_handle = tv_1.finditem(RootTreeItem!,0)  
do while ll_handle > 0 
	//find in child nodes recursively, and stop it while found.
	li_rtn = of_locate_clause(al_clause_id,ll_handle)
	if	li_rtn = 1 then exit 
	ll_handle = tv_1.finditem(NextTreeItem!, ll_handle)
loop
tv_1.setredraw(true)

return li_rtn
end function

public function integer of_locate_clause (long al_clause_id, long al_handle);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_locate_clause()
// $<arguments>
//		value	long	al_clause_id		
//		value	long	al_handle   		
// $<returns> integer
// $<description>locate specified clause in child nodes recursively
//////////////////////////////////////////////////////////////////////
// $<add> 11.24.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_find,li_rtn
treeviewitem l_tvi

//if error, return -1 to stop finding in current level
if tv_1.getitem(al_handle,l_tvi) = -1 then return -1

//check current node, and return 1 if found
if l_tvi.PictureIndex <> 1 and l_tvi.data = al_clause_id then
	tv_1.selectitem(al_handle)
	return 1 
end if

//get first child node
ll_find = tv_1.finditem(ChildTreeItem!,al_handle)

//find in same level
do while ll_find > 0 
	//find in child nodes recursively, and return 1 if found
	if of_locate_clause(al_clause_id,ll_find) = 1 then return 1 
	//find in next node
	ll_find = tv_1.finditem(NextTreeItem!,ll_find)
loop

return -1
end function

public function integer of_set_treeview (long al_clause_id, boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_lib.of_set_treeview()
// $<arguments>
//		value	long	al_clause_id		
//		value	boolean	ab_flag
// $<returns> integer
// $<description>locate and set the overlaypicture property in treeview
//////////////////////////////////////////////////////////////////////
// $<add> 12.11.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

integer li_rtn
long ll_handle
treeviewitem l_tvi

if isnull(al_clause_id) then return -1

//Added By Ken.Guo 2010-12-29.
ll_handle = This.of_get_handle( al_clause_id )
If ll_handle > 0 Then
	Return of_set_treeview(al_clause_id,ll_handle,ab_flag)
End If


//find firstly in current node
ll_handle = tv_1.finditem(CurrentTreeItem!,0)
if ll_handle > 0 then
	tv_1.getitem(ll_handle,l_tvi)
	if (l_tvi.data = al_clause_id) and (l_tvi.PictureIndex = 3 or l_tvi.PictureIndex = 4 or l_tvi.PictureIndex = 5) then
		if ab_flag then
			l_tvi.pictureindex = 5
			l_tvi.selectedpictureindex = 5
			tv_1.setitem(ll_handle,l_tvi)
		else
			l_tvi.pictureindex = 3
			l_tvi.selectedpictureindex = 4		
			tv_1.setitem(ll_handle,l_tvi)
		end if
		return 1
	end if
end if

//find the clause in full tree
tv_1.setredraw(false)
ll_handle = 0
ll_handle = This.of_get_handle(al_clause_id)
If ll_handle > 0 Then
	 of_set_treeview(al_clause_id,ll_handle,ab_flag)
Else
	ll_handle = tv_1.finditem(RootTreeItem!,0)  
	do while ll_handle > 0 
		//find in child nodes recursively, and stop it while found.
		li_rtn = of_set_treeview(al_clause_id,ll_handle,ab_flag)
		if	li_rtn = 1 then exit 
		ll_handle = tv_1.finditem(NextTreeItem!, ll_handle)
	loop
End If
tv_1.setredraw(true)

return li_rtn
end function

public function integer of_set_treeview (long al_clause_id, long al_handle, boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_clause_libof_set_treeview()
// $<arguments>
//		value	long	al_clause_id		
//		value	long	al_handle   		
//		value	boolean ab_flag
// $<returns> integer
// $<description>Locate and set overlaypricture in treeview recusively
//////////////////////////////////////////////////////////////////////
// $<add> 12.11.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

long ll_find,li_rtn
treeviewitem l_tvi

//if error, return -1 to stop finding in current level
if tv_1.getitem(al_handle,l_tvi) = -1 then return -1

//check current node, and return 1 if found
if (l_tvi.data = al_clause_id) and (l_tvi.PictureIndex = 3 or l_tvi.PictureIndex = 4 or l_tvi.PictureIndex = 5) then
	if ab_flag then
		l_tvi.pictureindex = 5
		l_tvi.selectedpictureindex = 5
		tv_1.setitem(al_handle,l_tvi)
	else
		l_tvi.pictureindex = 3
		l_tvi.selectedpictureindex = 4		
		tv_1.SetItem(al_handle,l_tvi)
	end if
	Return 1 
end if

//get first child node
ll_find = tv_1.finditem(ChildTreeItem!,al_handle)

//find in same level
do while ll_find > 0 
	//find in child nodes recursively, and return 1 if found
	if of_set_treeview(al_clause_id,ll_find,ab_flag) = 1 then return 1 
	//find in next node
	ll_find = tv_1.finditem(NextTreeItem!,ll_find)
loop

return -1
end function

public function integer of_compare_clauses ();//Added by Alfee 10.18.2007

IF Not IsValid(inv_clause_comparison) THEN RETURN -1

inv_clause_comparison.of_start_compare_clauses( iw_atac, tv_1, 'template')

RETURN 1
end function

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
		tv_1.InsertItemLast(al_clause_handle, ltvi_Item)
	end if
loop

end subroutine

public subroutine of_refreshfilterpicture ();//====================================================================
// Function: of_RefreshFilterPicture()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-15
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ClauseExp

ls_ClauseExp = istr_ClauseFilter.Clause_Exp

if IsNull(ls_ClauseExp) or Trim(ls_ClauseExp) = "" then
	pb_AttriFilter.PictureName = "Filter_Empty.gif"
else
	pb_AttriFilter.PictureName = "Filter_Exist.gif"
end if

end subroutine

public function long of_get_handle (long al_clause_id);Long ll_find, ll_cnt, ll_clause_id

ll_cnt = ids_clause_tvi_map.RowCount()
ll_find = ids_clause_tvi_map.Find('clause_id = ' + String(al_clause_id),1,ll_cnt) 
If ll_find > 0 Then
	ll_clause_id = ids_clause_tvi_map.GetItemNumber(ll_find,'tvi_handle')
End If

Return ll_clause_id


end function

on u_tabpg_agreement_template_clause_lib.create
int iCurrent
call super::create
this.cb_compare=create cb_compare
this.cb_go=create cb_go
this.cb_collapseall=create cb_collapseall
this.cb_expandall=create cb_expandall
this.cb_collapseitem=create cb_collapseitem
this.cb_expanditem=create cb_expanditem
this.tv_1=create tv_1
this.dw_filter=create dw_filter
this.gb_1=create gb_1
this.pb_attrifilter=create pb_attrifilter
this.ds_category_unauthorized=create ds_category_unauthorized
this.ds_rely_temp=create ds_rely_temp
this.ds_rely_filtered=create ds_rely_filtered
this.ds_clause_included=create ds_clause_included
this.ds_rely=create ds_rely
this.ds_folder_distinct=create ds_folder_distinct
this.ds_folder_filtered=create ds_folder_filtered
this.ds_folder=create ds_folder
this.ds_clause=create ds_clause
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_compare
this.Control[iCurrent+2]=this.cb_go
this.Control[iCurrent+3]=this.cb_collapseall
this.Control[iCurrent+4]=this.cb_expandall
this.Control[iCurrent+5]=this.cb_collapseitem
this.Control[iCurrent+6]=this.cb_expanditem
this.Control[iCurrent+7]=this.tv_1
this.Control[iCurrent+8]=this.dw_filter
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.pb_attrifilter
end on

on u_tabpg_agreement_template_clause_lib.destroy
call super::destroy
destroy(this.cb_compare)
destroy(this.cb_go)
destroy(this.cb_collapseall)
destroy(this.cb_expandall)
destroy(this.cb_collapseitem)
destroy(this.cb_expanditem)
destroy(this.tv_1)
destroy(this.dw_filter)
destroy(this.gb_1)
destroy(this.pb_attrifilter)
destroy(this.ds_category_unauthorized)
destroy(this.ds_rely_temp)
destroy(this.ds_rely_filtered)
destroy(this.ds_clause_included)
destroy(this.ds_rely)
destroy(this.ds_folder_distinct)
destroy(this.ds_folder_filtered)
destroy(this.ds_folder)
destroy(this.ds_clause)
end on

event constructor;call super::constructor;iw_atac = iw_parent

inv_clause_comparison = Create n_cst_clause_comparison //Added by Alfee 10.18.2007
inv_clause = Create n_cst_clause
//BEGIN---Modify by Scofield on 2010-01-11
ids_AttriValue = Create DataStore
ids_AttriValue.DataObject = "d_acp_clause_attr_val_list"
ids_AttriValue.SetTransObject(SQLCA)
//END---Modify by Scofield on 2010-01-11

//Added By Ken.Guo 2010-12-22.
ids_clause_tvi_map = Create DataStore
ids_clause_tvi_map.Dataobject = 'd_clause_tvi_map'
//ids_clause_tvi_map.SetTransobject(SQLCA)
end event

event destructor;call super::destructor;IF IsValid(inv_clause_comparison) THEN Destroy inv_clause_comparison //Added by Alfee 10.18.2007

Destroy ids_AttriValue						//Added by Scofield on 2010-01-11

IF IsValid(inv_clause) THEN Destroy inv_clause 

If isvalid(ids_clause_tvi_map) Then Destroy ids_clause_tvi_map //Added By Ken.Guo 2010-12-22.
end event

type cb_compare from commandbutton within u_tabpg_agreement_template_clause_lib
integer x = 1280
integer y = 2516
integer width = 265
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Co&mpare"
end type

event clicked;//Added by Alfee 10.18.2007
of_compare_clauses()
end event

type cb_go from commandbutton within u_tabpg_agreement_template_clause_lib
integer x = 1385
integer y = 108
integer width = 128
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
end type

event clicked;parent.event pfc_cst_go()
end event

type cb_collapseall from commandbutton within u_tabpg_agreement_template_clause_lib
integer x = 581
integer y = 2516
integer width = 187
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "-  All"
end type

event clicked;parent.event pfc_cst_collapseall()
end event

type cb_expandall from commandbutton within u_tabpg_agreement_template_clause_lib
integer x = 393
integer y = 2516
integer width = 187
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+  ALL"
end type

event clicked;parent.event pfc_cst_expandall()

end event

type cb_collapseitem from commandbutton within u_tabpg_agreement_template_clause_lib
integer x = 206
integer y = 2516
integer width = 187
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "-"
end type

event clicked;parent.event pfc_cst_collapseitem()

end event

type cb_expanditem from commandbutton within u_tabpg_agreement_template_clause_lib
integer x = 18
integer y = 2516
integer width = 187
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+"
end type

event clicked;parent.event pfc_cst_expanditem()


end event

type tv_1 from u_tvs within u_tabpg_agreement_template_clause_lib
integer x = 18
integer y = 292
integer width = 1527
integer height = 2188
integer taborder = 30
string dragicon = "droparrow.ico"
boolean dragauto = true
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
boolean fullrowselect = true
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","Custom050!","MultiLineEdit!","SelectReturn!","sectiongreen.bmp","Properties!"}
string statepicturename[] = {"checkmark.bmp","check.bmp"}
boolean ib_rmbmenu = false
end type

event selectionchanged;call super::selectionchanged;long ll_row

TreeViewItem l_tvi

if tv_1.GetItem(NewHandle,l_tvi) = 1 then
	if l_tvi.PictureIndex = 1 then //folder
		iw_atac.ii_folder_id = l_tvi.data
		setnull(iw_atac.il_clause_id)
	else //clause
		setnull(iw_atac.ii_folder_id)
		iw_atac.il_clause_id = l_tvi.data
	end if
end if

//get modify date for current selected clause
if not isnull(iw_atac.il_clause_id) then
	ll_row = ds_clause.find("ctx_acp_clause_id ="+string(iw_atac.il_clause_id),1,ds_clause.rowcount())
	if ll_row > 0 then 
		iw_atac.idt_modify_date = ds_clause.getitemdatetime(ll_row,"modify_date")
		iw_atac.is_clause_name = ds_clause.getitemstring(ll_row,"clause_name")		
	end if
end if

//call parent window's event to...
iw_atac.event pfc_cst_selection_changed()

this.setfocus()

end event

event doubleclicked;call super::doubleclicked;treeviewitem l_tvi

if tv_1.getitem(handle,l_tvi) = -1 then return -1

if l_tvi.PictureIndex = 1 then //folder
	if l_tvi.expanded	then
		this.collapseitem(handle)
	else
		this.expanditem(handle)
	end if
else //clause
	iw_atac.event pfc_cst_move_right(0)
end if

Return 1

end event

event dragdrop;call super::dragdrop;if classname(source) = "dw_selected" then
	iw_atac.event pfc_cst_move_left()
end if
end event

event clicked;call super::clicked;//For Clause Comparison functionality - Added by Alfee 10.18.2007

Treeviewitem l_tvi
Long ll_clause_id

IF NOT IsValid(inv_clause_comparison) THEN RETURN

IF tv_1.Getitem(handle,l_tvi) = 1 THEN
	IF l_tvi.PictureIndex <> 1 THEN
		ll_clause_id = l_tvi.data 
		inv_clause_comparison.of_select_clause(handle, ll_clause_id)
	END IF
END IF

end event

event itempopulate;call super::itempopulate;//====================================================================
// Event: itempopulate
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	handle
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-07-23
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long	ll_i, ll_Child
Long	ll_cause_handle, ll_Find, ll_clause_id
TreeViewItem    ltrvi_item, ltrvi_child

ll_cause_handle = handle


IF this.GetItem( handle, ltrvi_item ) = 1 Then
	If  ltrvi_item.Children Then
		SetPointer( HourGlass! )
		ll_Child = FindItem( ChildTreeItem!, handle )
		do while ll_Child > 0 
			ll_cause_handle = ll_Child
			ll_Find = ids_clause_tvi_map.Find( "tvi_handle = " + String( ll_cause_handle  ), 1, ids_clause_tvi_map.Rowcount( ) )
			
			If ll_Find > 0 Then 
				ll_clause_id = ids_clause_tvi_map.GetItemNumber(ll_Find,'clause_id')
				inv_clause.of_Create_Clause_Attribute(ll_clause_id,ll_cause_handle,This )	
			End If
			ll_Child = FindItem( NextTreeItem!, ll_cause_handle )
		loop
		SetPointer( arrow! )
	End If
End If
	

end event

type dw_filter from u_dw_contract within u_tabpg_agreement_template_clause_lib
event ue_enter pbm_dwnkey
integer x = 37
integer y = 60
integer width = 1326
integer height = 184
integer taborder = 10
string dataobject = "d_agreement_template_clause_filter"
boolean vscrollbar = false
boolean border = false
boolean ib_rmbmenu = false
end type

event ue_enter;IF key = KeyEnter! THEN //alfee 12.10.2008
	cb_go.event clicked()
END IF

end event

event constructor;call super::constructor;this.of_setupdateable(false)
this.event ue_populatedddws()

this.insertrow(0)
this.setfocus()
end event

event ue_populatedddws;call super::ue_populatedddws;//--------Begin Added by Alfee 03.12.2008-------
Long ll_data
datawindowchild dwc_1 

IF this.GetChild('category', dwc_1) = 1 THEN
	dwc_1.SetTransObject(SQLCA)
	IF dwc_1.RowCount() > 0 THEN 
		ll_data = dwc_1.GetItemNumber(1,"lookup_code") 
		IF IsNull(ll_data) THEN RETURN //an empty line existed
		dwc_1.InsertRow(1)
	END IF
END IF
//--------End Added ----------------------------
end event

type gb_1 from groupbox within u_tabpg_agreement_template_clause_lib
integer x = 18
integer y = 28
integer width = 1527
integer height = 224
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
end type

type pb_attrifilter from picturebutton within u_tabpg_agreement_template_clause_lib
integer x = 795
integer y = 2516
integer width = 453
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Attribute &Filter..."
alignment htextalign = right!
vtextalign vtextalign = top!
boolean map3dcolors = true
end type

event clicked;str_clause_filter	lstr_ClauseFilter

OpenWithParm(w_clause_attribute_filter,istr_ClauseFilter)

lstr_ClauseFilter = Message.PowerObjectParm
if lstr_ClauseFilter.Clause_Exp <> "Cancel" then
	istr_ClauseFilter = lstr_ClauseFilter
	Parent.Event Pfc_Cst_Go()
end if

of_RefreshFilterPicture()

end event

type ds_category_unauthorized from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_dm_category_unauthorized"
end type

event constructor;call super::constructor;this.of_settransobject(sqlca)
end event

on ds_category_unauthorized.create
call super::create
end on

on ds_category_unauthorized.destroy
call super::destroy
end on

type ds_rely_temp from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_rlytmp"
boolean ib_isupdateable = false
end type

on ds_rely_temp.create
call super::create
end on

on ds_rely_temp.destroy
call super::destroy
end on

type ds_rely_filtered from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_rlyflt"
boolean ib_isupdateable = false
end type

on ds_rely_filtered.create
call super::create
end on

on ds_rely_filtered.destroy
call super::destroy
end on

type ds_clause_included from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_included"
boolean ib_isupdateable = false
end type

on ds_clause_included.create
call super::create
end on

on ds_clause_included.destroy
call super::destroy
end on

type ds_rely from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_rely"
boolean ib_isupdateable = false
end type

on ds_rely.create
call super::create
end on

on ds_rely.destroy
call super::destroy
end on

event constructor;call super::constructor;this.of_settransobject(sqlca)
end event

type ds_folder_distinct from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_flddist"
boolean ib_isupdateable = false
end type

on ds_folder_distinct.create
call super::create
end on

on ds_folder_distinct.destroy
call super::destroy
end on

type ds_folder_filtered from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_fldcls"
boolean ib_isupdateable = false
end type

on ds_folder_filtered.create
call super::create
end on

on ds_folder_filtered.destroy
call super::destroy
end on

type ds_folder from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_folder"
boolean ib_isupdateable = false
end type

on ds_folder.create
call super::create
end on

on ds_folder.destroy
call super::destroy
end on

event constructor;call super::constructor;this.of_settransobject(sqlca)
end event

type ds_clause from n_ds within u_tabpg_agreement_template_clause_lib descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_clause_all"
boolean ib_isupdateable = false
end type

on ds_clause.create
call super::create
end on

on ds_clause.destroy
call super::destroy
end on

event constructor;call super::constructor;this.of_settransobject(sqlca)
end event

