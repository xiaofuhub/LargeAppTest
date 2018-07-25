$PBExportHeader$u_tab_agreement_clause_reference.sru
$PBExportComments$Create by Jack 03/05/2007
forward
global type u_tab_agreement_clause_reference from u_tab
end type
type tabpage_browse from userobject within u_tab_agreement_clause_reference
end type
type dw_filter from u_dw_contract within tabpage_browse
end type
type dw_browse from u_dw_contract within tabpage_browse
end type
type tv_clause from u_tvs within tabpage_browse
end type
type cb_clear from commandbutton within tabpage_browse
end type
type cb_go from commandbutton within tabpage_browse
end type
type gb_1 from groupbox within tabpage_browse
end type
type tabpage_browse from userobject within u_tab_agreement_clause_reference
dw_filter dw_filter
dw_browse dw_browse
tv_clause tv_clause
cb_clear cb_clear
cb_go cb_go
gb_1 gb_1
end type
type tabpage_clause from u_tabpg_agreement_template_detail within u_tab_agreement_clause_reference
end type
type tabpage_clause from u_tabpg_agreement_template_detail within u_tab_agreement_clause_reference
end type
end forward

global type u_tab_agreement_clause_reference from u_tab
integer width = 4069
integer height = 2120
long backcolor = 33551856
boolean ib_isupdateable = false
tabpage_browse tabpage_browse
tabpage_clause tabpage_clause
event ue_setfocus_ole ( )
end type
global u_tab_agreement_clause_reference u_tab_agreement_clause_reference

type variables
//w_clause_painter iw_clause_painter
w_clause_reference iw_clause_painter

long il_handle,il_handle1,il_ctx_acp_folder_id,il_ctx_acp_clause_id,il_parent_folder_id,il_category
long il_first = 1,il_old_clause_id
long il_folder[]
string is_type,is_types,is_clause_name
string is_data = '',is_data_delete,is_filter,is_old_sql
string is_click
str_folder istr_folder
datastore ids_template_clause
datastore ids_folder
datastore ids_clause
datastore ids_clause_rely
datastore ids_next_handle
datastore ids_search_clause_text
datawindowchild idw_child

boolean ib_fulltextsearch  //added by alfee at 03.07.2007

end variables

forward prototypes
public subroutine of_create_clause_tree ()
public subroutine of_create_clause_child_tree (long al_handle, long al_folder_id)
public function integer of_create_word_file (long al_clause_id, ref string as_file_name)
public function integer of_deleterow ()
public function long of_gethandle (string as_data, long al_handle)
public function long of_delete (long al_handle)
public function long of_delete_child (long al_handle)
public function integer of_get_folder (long al_handle)
public function integer of_get_child_folder (long al_handle)
public subroutine of_close ()
public subroutine of_add_folder ()
public subroutine of_add_clause ()
public subroutine of_properties ()
public subroutine of_set_word_view_size ()
public function integer of_open_word_file ()
public subroutine of_rely ()
public function integer of_save ()
public function integer of_update_template (long al_template_id, string as_lastupdate)
public function integer of_update_category (long al_folder_id, decimal adc_category)
end prototypes

event ue_setfocus_ole();////--------------------------- APPEON BEGIN ---------------------------
////$<add> 21-03-2007 By: Ken.Guo
////$<reason> Fix Issue: Need set focus to Word Document when add a clause.
////Must POST this event.
//tabpage_clause.ole_1.object.ActiveDocument.ActiveWindow.SetFocus()
////---------------------------- APPEON END ----------------------------
//
//
end event

public subroutine of_create_clause_tree ();TreeViewItem ltvi_Item
TreeViewItem ltvi_node1,ltvi_node2,ltvi_node3
datastore lds_folder_parent

long ll_row,ll_rowcount,ll_clause_rowcount
Long ll_Root,ll_lev1,ll_lev2
long i,j,k
String ls_folder_name,ls_clause_name,ls_parent_filter,ls_approved_by,ls_date_approved,ls_new_sql
string ls_filter0 = '',ls_filter1,ls_search_text = " ctx_acp_clause_id In ("
long ll_ctx_acp_folder_id,ll_category,ll_ctx_acp_clause_id,ll_approval_status
setpointer(HourGlass!)
ls_new_sql = is_old_sql + " where 1 = 1 "

lds_folder_parent = Create datastore
lds_folder_parent.dataobject = 'd_folder_parent'
lds_folder_parent.settransobject(sqlca)

tabpage_browse.dw_filter.accepttext()
ll_row = tabpage_browse.dw_filter.getrow()
If ll_row > 0 Then
	ll_category = tabpage_browse.dw_filter.getitemnumber(ll_row,'category')
	ls_clause_name = tabpage_browse.dw_filter.getitemstring(ll_row,'clause_name')
	ls_folder_name = tabpage_browse.dw_filter.getitemstring(ll_row,'folder_name')
	ls_approved_by = tabpage_browse.dw_filter.getitemstring(ll_row,'approved_by')
	ls_date_approved = string(tabpage_browse.dw_filter.getitemdatetime(ll_row,'date_approved'),'mm/dd/yyyy')
	ll_approval_status = tabpage_browse.dw_filter.getitemnumber(ll_row,'approval_status')
Else
	ll_category = 0
End If
If isnull(ls_clause_name) Then ls_clause_name = ''
If isnull(ls_folder_name) Then ls_folder_name = ''
If isnull(ls_approved_by) Then ls_approved_by = ''
If isnull(ls_date_approved) Then ls_date_approved = ''
If isnull(ll_approval_status) Then ll_approval_status = 0
ib_fulltextsearch = false //added by alfee at 03.07.2007

//gnv_appeondb.of_startqueue( )
//lds_folder_parent.retrieve()
//ids_folder.retrieve()
//ids_clause.retrieve()
//ids_template_clause.retrieve()
//ids_clause_rely.retrieve()
//If gs_dbtype = "SQL" And gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' And ls_clause_name <> '' Then
//	ls_clause_name = '"' + ls_clause_name + '"'
//	ids_search_clause_text.retrieve(ls_clause_name)
//End If
//tabpage_browse.dw_browse.retrieve()
//gnv_appeondb.of_commitqueue( )

If isnull(ll_category) Then ll_category = 0
If ll_category > 0 Then
	ls_filter0 = "category = " + string(ll_category)
	ls_parent_filter = ls_filter0
	ls_new_sql = ls_new_sql + " And " + ls_filter0
Else
	ls_parent_filter = ''
End If

If ls_folder_name <> '' Then
	If ls_parent_filter <> '' Then
		ls_parent_filter = ls_parent_filter + " And upper(folder_name) like " + "'%" + upper(ls_folder_name) + "%'"
	Else
		ls_parent_filter = "upper(folder_name) like " + "'%" + upper(ls_folder_name) + "%'"
	End If
	ls_new_sql = ls_new_sql + " And ctx_acp_folder_id in ( Select b.ctx_acp_folder_id from ctx_acp_folder b Where upper(b.folder_name) like " + "'%" + upper(ls_folder_name) + "%')"	
End If	

If trim(ls_clause_name) <> '' Then
	If gs_dbtype = "SQL" And gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' And ls_clause_name <> '' Then
		ib_fulltextsearch = true 		//Full Text Search; added by alfee at 03.07.2007
		ls_clause_name = '"' + ls_clause_name + '"'
		ids_search_clause_text.retrieve(ls_clause_name)		
	End If

	If ls_filter0 <> '' Then
		If gs_dbtype = "ASA" Then
			ls_filter0 = ls_filter0 + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
			ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
		Else
			If gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' Then
				If ids_search_clause_text.rowcount() > 0 Then
					For k = 1 To ids_search_clause_text.rowcount()
						ll_ctx_acp_clause_id = ids_search_clause_text.getitemnumber(k,'ctx_acp_clause_id')				
						ls_search_text = ls_search_text + string(ll_ctx_acp_clause_id) + ","
					Next
					ls_search_text = mid(ls_search_text,1,len(ls_search_text) - 1) + ")"
				Else
					ls_search_text = ls_search_text + "0)"
				End If					
				ls_filter0 = ls_filter0 + " And " + ls_search_text
				ls_new_sql = ls_new_sql + " And " + ls_search_text
			Else
				ls_filter0 = ls_filter0 + " And upper(clause_name like) " + "'%" + upper(ls_clause_name) + "%'"			
				ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
		End If
		End If
	Else
		If gs_dbtype = "ASA" Then
			ls_filter0 = "upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
			ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
		Else
			If gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' Then
				If ids_search_clause_text.rowcount() > 0 Then
					For k = 1 To ids_search_clause_text.rowcount()
						ll_ctx_acp_clause_id = ids_search_clause_text.getitemnumber(k,'ctx_acp_clause_id')				
						ls_search_text = ls_search_text + string(ll_ctx_acp_clause_id) + ","
					Next
					ls_search_text = mid(ls_search_text,1,len(ls_search_text) - 1) + ")"
				Else
					ls_search_text = ls_search_text + "0)"
				End If
				ls_filter0 = ls_search_text
				ls_new_sql = ls_new_sql + " And " + ls_search_text
			Else
				ls_filter0 = "upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"			
				ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
			End If
		End If
	End If		
End If
If ls_approved_by <> '' Then
	If ls_filter0 <> '' Then
		ls_filter0 = ls_filter0 + " And approved_by = '" + ls_approved_by + "'"
	Else
		ls_filter0 = "approved_by = '" + ls_approved_by + "'"
	End If
	ls_new_sql = ls_new_sql + " And approved_by = '" + ls_approved_by + "'"
End If
If ls_date_approved <> '' Then
	If ls_filter0 <> '' Then
		ls_filter0 = ls_filter0 + " And string(date_approved,'mm/dd/yyyy') = '" + ls_date_approved + "'"
	Else
		ls_filter0 = "string(date_approved,'mm/dd/yyyy') = '" + ls_date_approved + "'"
	End If
	ls_new_sql = ls_new_sql + " And convert(char,date_approved,101) = '" + ls_date_approved + "'"
End If
If ll_approval_status <> 0 Then
	If ls_filter0 <> '' Then
		ls_filter0 = ls_filter0 + " And approval_status = " + string(ll_approval_status)
	Else
		ls_filter0 = "approval_status = " + string(ll_approval_status)
	End If
	ls_new_sql = ls_new_sql + " And approval_status = " + string(ll_approval_status)
End If

is_filter = ls_filter0
tabpage_browse.dw_browse.reset()
tabpage_browse.dw_browse.setfilter('')
tabpage_browse.dw_browse.filter()
tabpage_browse.dw_browse.setsqlselect(ls_new_sql)
tabpage_browse.dw_browse.settransobject(sqlca)

gnv_appeondb.of_startqueue( )
lds_folder_parent.retrieve()
ids_folder.retrieve()
ids_clause.retrieve()
ids_template_clause.retrieve()
ids_clause_rely.retrieve()
tabpage_browse.dw_browse.retrieve()
gnv_appeondb.of_commitqueue( )


ll_Root = tabpage_browse.tv_clause.finditem(Roottreeitem!,0)
If ll_Root > 0 Then
	tabpage_browse.tv_clause.DeleteItem(ll_Root)
End If

ltvi_Item.Label = 'Clause Library'
ltvi_Item.Data = 0
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 2
ll_Root = tabpage_browse.tv_clause.InsertItemLast (0, ltvi_Item)

lds_folder_parent.setfilter(ls_parent_filter)
lds_folder_parent.filter()
ll_rowcount = lds_folder_parent.rowcount()

For i = 1 To ll_rowcount
	ll_ctx_acp_folder_id = lds_folder_parent.getitemnumber(i,'ctx_acp_folder_id')
	ls_folder_name = lds_folder_parent.getitemstring(i,'folder_name')
	ll_category = lds_folder_parent.getitemnumber(i,'category')
	
	ltvi_Item.Label = ls_folder_name
	ltvi_Item.data = string(ll_ctx_acp_folder_id) + '-' + 'F' + '+' + string(ll_category)
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ll_lev1 = tabpage_browse.tv_clause.InsertItemLast(ll_Root, ltvi_Item)
		
	//clause
	If ls_filter0 <> '' Then
		ls_filter1 = "ctx_acp_folder_id = " + string(ll_ctx_acp_folder_id) + " And " + ls_filter0
	Else
		ls_filter1 = "ctx_acp_folder_id = " + string(ll_ctx_acp_folder_id)
	End If
	ids_clause.setfilter(ls_filter1)
	ids_clause.filter()
	ll_clause_rowcount = ids_clause.rowcount()
	For j = 1 To ll_clause_rowcount
		ll_ctx_acp_clause_id = ids_clause.getitemnumber(j,'ctx_acp_clause_id')
		ls_clause_name = ids_clause.getitemstring(j,'clause_name')
		
		ltvi_Item.Label = ls_clause_name
		ltvi_Item.data = string(ll_ctx_acp_clause_id) + '-' + 'C'
		ltvi_Item.PictureIndex = 4
		ltvi_Item.SelectedPictureIndex = 3
		ll_lev2 = tabpage_browse.tv_clause.InsertItemLast(ll_lev1, ltvi_Item)
	Next
	
	of_create_clause_child_tree(ll_lev1,ll_ctx_acp_folder_id)
		
Next

tabpage_browse.tv_clause.ExpAndItem (ll_Root)
tabpage_browse.tv_clause.selectitem(ll_Root)	

Destroy lds_folder_parent

//ll_lev0 = this.FindItem(RootTreeItem!, 0)
//this.ExpandAll(ll_lev0)
//this.ExpandItem(1) 

end subroutine

public subroutine of_create_clause_child_tree (long al_handle, long al_folder_id);string ls_filter
long i,j,ll_rowcount,ll_clause_rowcount,ll_find,ll_handle,ll_handle_clause
long ll_ctx_acp_folder_id,ll_category,ll_ctx_acp_clause_id
string ls_find
string ls_folder_name,ls_clause_name
TreeViewItem ltvi_Item

ls_find = "parent_folder_id = " + string(al_folder_id)
ll_rowcount = ids_folder.rowcount()

ll_find = ids_folder.find(ls_find,1,ll_rowcount)
Do While ll_find > 0
	ll_ctx_acp_folder_id = ids_folder.getitemnumber(ll_find,'ctx_acp_folder_id')
	ll_category = ids_folder.getitemnumber(ll_find,'category')
	ls_folder_name = ids_folder.getitemstring(ll_find,'folder_name')
	ltvi_Item.Label = ls_folder_name
	ltvi_Item.data = string(ll_ctx_acp_folder_id) + '-' + 'F' + '+' + string(ll_category)
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ll_handle = tabpage_browse.tv_clause.InsertItemLast(al_handle, ltvi_Item)

	//clause
	If is_filter <> '' Then
		ls_filter = "ctx_acp_folder_id = " + string(ll_ctx_acp_folder_id) + " And " + is_filter
	Else
		ls_filter = "ctx_acp_folder_id = " + string(ll_ctx_acp_folder_id)
	End If		
	ids_clause.setfilter(ls_filter)
	ids_clause.filter()
	ll_clause_rowcount = ids_clause.rowcount()
	For j = 1 To ll_clause_rowcount
		ll_ctx_acp_clause_id = ids_clause.getitemnumber(j,'ctx_acp_clause_id')
		ls_clause_name = ids_clause.getitemstring(j,'clause_name')
		
		ltvi_Item.Label = ls_clause_name
		ltvi_Item.data = string(ll_ctx_acp_clause_id) + '-' + 'C'
		ltvi_Item.PictureIndex = 4
		ltvi_Item.SelectedPictureIndex = 3
		ll_handle_clause = tabpage_browse.tv_clause.InsertItemLast(ll_handle, ltvi_Item)
	Next	
	
	If ll_find < ll_rowcount Then
		ll_find = ids_folder.find(ls_find,ll_find + 1,ll_rowcount)	
	Else
		ll_find = 0
	End If
	of_create_clause_child_tree(ll_handle,ll_ctx_acp_folder_id)
Loop

end subroutine

public function integer of_create_word_file (long al_clause_id, ref string as_file_name);//Begin - Modified By Ken.Guo 2010-01-18

Integer li_ret
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause
li_ret = lnv_clause.of_download_file(al_clause_id,as_file_name)
Destroy lnv_clause
Return li_ret
/*
string ls_file_name
boolean lb_select
string ls_lastupdate,ls_updatedate
long	 ll_getupdate

Long ll_data_length
Integer li_counter
Integer li_loops
Blob lb_data
Blob lb_all_data
Long ll_start

Long ll_BlobLen,ll_CurrentPos
Integer li_Writes,li_FileNum,li_Cnt
blob lblb_Data

setpointer(HourGlass!)

tabpage_browse.dw_browse.accepttext()
If tabpage_browse.dw_browse.getrow() > 0 Then
	//---------Begin Modified by Alfee 05.10.2007---------------
	//ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'))
	ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'), "mm/dd/yyyy hh:mm:ss" )	
	//---------End Modified -------------------------------------
End If
gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\")

ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + ".doc"
If is_types = 'Add' Then
	lb_all_data = blob('')
	li_FileNum = FileOpen(ls_file_name , StreamMode! ,Write!,Shared!, Replace!)
	If li_FileNum = -1 Then Return 0
	If FileWrite(li_FileNum, lb_all_data) = -1 Then
		Return 0
	End If
	FileClose(li_FileNum)	
ElseIf is_types = 'Update' Then
	If Not fileexists(ls_file_name) Then
		lb_select = True
	Else		
		ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_"+string(al_clause_id), regstring!, ls_lastupdate)	
		If ll_getupdate <> 1 Then
			lb_select = True
		Else
			If ls_updatedate <> ls_lastupdate Then 
				lb_select = True
			End If		
		End If	
	End If
	
	If lb_select = True Then
		lb_select = False	
		If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then		
			SELECTBLOB image_file INTO :lb_all_data
			  FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;
		Else			
			SELECT Datalength(image_file) INTO :ll_data_length
			  FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;
			
			If isnull(ll_data_length) Then ll_data_length = 0
			
			If ll_data_length > 8000 Then 
				If Mod(ll_data_length,8000) = 0 Then
					li_loops = ll_data_length/8000 
				Else
					li_loops = (ll_data_length/8000) + 1 
				End If 
			ElseIf ll_data_length > 0 Then 
				li_loops = 1 
			End If 
			
			For li_counter = 1 To li_loops				
				ll_start = (li_counter - 1) * 8000 + 1
				SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
				  FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;			
				lb_all_data += lb_data
			Next 
		End If
		If isnull(lb_all_data) Then lb_all_data = blob('')
			
		li_FileNum = FileOpen(ls_file_name , StreamMode! ,Write!,Shared!, Replace!)
		If li_FileNum = -1 Then Return 0
			
		ll_BlobLen = Len(lb_all_data)
		If ll_BlobLen > 32765 Then
			If Mod(ll_BlobLen, 32765) = 0 Then
				li_Writes = ll_BlobLen / 32765
			Else
				li_Writes = (ll_BlobLen / 32765) + 1
			End If
		 Else
			li_Writes = 1
		End If
		
		ll_CurrentPos = 1
		
		For li_Cnt = 1 To li_Writes
			lblb_Data = BlobMid(lb_all_data, ll_CurrentPos, 32765)
			ll_CurrentPos += 32765
			If FileWrite(li_FileNum, lblb_Data) = -1 Then
				Return 0
			End If
		Next
		
		FileClose(li_FileNum)
		gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(al_clause_id), regstring!, ls_updatedate)	
	End If			
End if
as_file_name = ls_file_name

Return 1

*/
//End - Modified By Ken.Guo 2010-01-18
end function

public function integer of_deleterow ();//long ll_mes
//
//If is_type = 'F' Then
//   ll_mes = messagebox('Delete Folder', 'Are you sure you want to delete this folder?',Question!,YesNo!,2)
//   If ll_mes = 2 Then Return 0
//ElseIf is_type = 'C' Then
//   ll_mes = messagebox('Delete Clause', 'Are you sure you want to delete this clause?',Question!,YesNo!,2)
//   If ll_mes = 2 Then Return 0
//Else
//	Return 0
//End If
//
//string ls_clause_rely_filter,ls_find
//long ll_template_clause_rowcount,ll_clause_rely_rowcount
//long i,ll_find,ll_Handle
//long ll_ctx_acp_clause_id,ll_ctx_acp_folder_id
//
//ids_folder.setfilter('')
//ids_folder.filter()
//ids_clause.setfilter('')
//ids_clause.filter()
//ids_template_clause.setfilter('')
//ids_template_clause.filter()
//ids_clause_rely.setfilter('')
//ids_clause_rely.filter()
//
//ll_template_clause_rowcount = ids_template_clause.rowcount()
//If isnull(il_handle1) Then il_handle1 = 0
//
//If is_type = 'F' Then
//	ids_next_handle.reset()
//	il_first = 1
//	If of_delete_child(il_handle) = 0 Then Return 0
//	
//	ls_find = "ctx_acp_folder_id = " + string(il_ctx_acp_folder_id)
//	ll_find = ids_folder.find(ls_find,1,ids_folder.rowcount())
//	If ll_find > 0 Then
//		ids_folder.deleterow(ll_find)
//	End If	
//ElseIf is_type = 'C' Then
//	If il_handle1 <> 0 Then
//		If of_delete(il_handle) = 0 Then Return 0	
//	Else
//		ls_find = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
//		ll_find = ids_template_clause.find(ls_find,1,ids_template_clause.rowcount())
//		If ll_find > 0 Then
//			messagebox('Delete Clause','The clause is used in Agreement Template, Cannot delete the clause!')
//			Return 0
//		End If
//		ls_clause_rely_filter = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
//		ids_clause_rely.setfilter(ls_clause_rely_filter)
//		ids_clause_rely.filter()
//		ll_clause_rely_rowcount = ids_clause_rely.rowcount()
//		For i = ll_clause_rely_rowcount To 1 Step -1
//			ids_clause_rely.deleterow(i)
//		Next
//		
//		ls_clause_rely_filter = "ctx_acp_clause_rely_id = " + string(il_ctx_acp_clause_id)
//		ids_clause_rely.setfilter(ls_clause_rely_filter)
//		ids_clause_rely.filter()
//		ll_clause_rely_rowcount = ids_clause_rely.rowcount()
//		For i = ll_clause_rely_rowcount To 1 Step -1
//			ids_clause_rely.deleterow(i)
//		Next
//		
//		ls_find = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
//		ll_find = ids_clause.find(ls_find,1,ids_clause.rowcount())
//		If ll_find > 0 Then
//			ids_clause.deleterow(ll_find)
//		End If
//		
//		tabpage_browse.dw_browse.deleterow(0)
//	End If
//End If
//
//gnv_appeondb.of_startqueue( )
//ids_clause_rely.Update()
//ids_clause.Update()
//ids_folder.Update()
//tabpage_browse.dw_browse.Update()
//gnv_appeondb.of_commitqueue( )
//
//If il_handle <> 0 Or il_handle1 <> 0 Then
//
//	of_Create_clause_tree()
//	ll_Handle = of_getHandle(is_data_delete,1)
//	If ll_Handle > 0 Then
//		tabpage_browse.tv_clause.Event clicked(ll_Handle)
//		tabpage_browse.tv_clause.selectitem(ll_Handle)	
//	Else
//		If isvalid(m_pfe_cst_clause_painter) Then
//			m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//			m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
//			m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False
//			m_pfe_cst_clause_painter.m_view.m_rules.enabled = False
//		End If
//	End If
//End If

Return 1
	
end function

public function long of_gethandle (string as_data, long al_handle);TreeViewItem ltvi_node
long ll_tvi
long ll_handle,ll_handle_1

ll_handle = al_handle
ll_handle_1 = al_handle
Do While ll_handle > 0
	ll_handle = tabpage_browse.tv_clause.FindItem(ChildTreeItem!, ll_handle)
	If ll_handle > 0 Then
		tabpage_browse.tv_clause.GetItem(ll_handle, ltvi_node)
		
		If string(ltvi_node.data) = as_Data Then
			ll_tvi = ll_handle
			exit
		End If
		
		ll_tvi = of_gethandle(as_data,ll_handle)
		If ll_tvi > 0 Then
			Return ll_tvi
		End If
   End If
	
   ll_handle = tabpage_browse.tv_clause.FindItem(NextTreeItem!, ll_handle_1)
	ll_handle_1 = ll_handle
	
	If ll_handle > 0 Then
		tabpage_browse.tv_clause.GetItem(ll_handle, ltvi_node)		
		If string(ltvi_node.data) = as_Data Then
			ll_tvi = ll_handle
			exit
		End If
	End If
Loop
Return ll_tvi




end function

public function long of_delete (long al_handle);TreeViewItem ltvi_node
long ll_tvi,ll_pos,ll_id,ll_find
string ls_data,ls_type,ls_find,ls_clause_rely_filter
long i,ll_clause_rely_rowcount

tabpage_browse.tv_clause.GetItem(al_handle, ltvi_node)
ls_data = string(ltvi_node.data)

ll_pos = pos(ls_data,'-')
ll_id = long(mid(ls_data,1,ll_pos - 1))
ls_type = mid(ls_data,ll_pos + 1,1)

If ls_type = 'F' Then
	ls_find = "ctx_acp_folder_id = " + string(ll_id)
	ll_find = ids_folder.find(ls_find,1,ids_folder.rowcount())
	If ll_find > 0 Then
		ids_folder.deleterow(ll_find)
	End If		
ElseIf ls_type = 'C' Then			
	ls_find = "ctx_acp_clause_id = " + string(ll_id)
	ll_find = ids_template_clause.find(ls_find,1,ids_template_clause.rowcount())
	If ll_find > 0 Then
		If is_type = 'C' Then
			//messagebox('Delete Clause','The clause is used in Agreement Template, Cannot delete the clause!')
 			messagebox('Delete Clause','Cannot delete the clause, because the clause is used in Agreement Template!')
		Else	
			//messagebox('Delete Folder','Some clauses is used in Agreement Template, Cannot delete the folder!')
 			messagebox('Delete Folder','Cannot delete the Folder, because some clauses are used in Agreement Template!')
		End If
		Return 0
	End If
		
	ls_clause_rely_filter = "ctx_acp_clause_id = " + string(ll_id)
	ids_clause_rely.setfilter(ls_clause_rely_filter)
	ids_clause_rely.filter()
	ll_clause_rely_rowcount = ids_clause_rely.rowcount()
	For i = ll_clause_rely_rowcount To 1 Step -1
		ids_clause_rely.deleterow(i)
	Next
	
	ls_clause_rely_filter = "ctx_acp_clause_rely_id = " + string(ll_id)
	ids_clause_rely.setfilter(ls_clause_rely_filter)
	ids_clause_rely.filter()
	ll_clause_rely_rowcount = ids_clause_rely.rowcount()
	For i = ll_clause_rely_rowcount To 1 Step -1
		ids_clause_rely.deleterow(i)
	Next
	
	ls_find = "ctx_acp_clause_id = " + string(ll_id)
	ll_find = ids_clause.find(ls_find,1,ids_clause.rowcount())
	If ll_find > 0 Then
		ids_clause.deleterow(ll_find)
	End If
End If
Return 1

end function

public function long of_delete_child (long al_handle);TreeViewItem ltvi_node
long ll_handle,ll_handle_1,ll_handle_2
long ll_row,ll_find

ll_handle = al_handle
ll_handle_1 = al_handle

Do While ll_handle > 0
	ll_handle = tabpage_browse.tv_clause.FindItem(ChildTreeItem!,ll_handle)
	If il_first = 1 Then
		ll_handle_1 = ll_handle
		il_first++
	End If
	
	If ll_handle > 0 Then		
   	ll_handle_2 = tabpage_browse.tv_clause.FindItem(NextTreeItem!,ll_handle_1)
		If ll_handle_2 > 0 Then
			ll_row = ids_next_handle.rowcount()
			If ll_row > 0 Then
				ll_find = ids_next_handle.find("handle = " +string(ll_handle_1),1,ll_row)
			Else
				ll_find = 0
			End If
			If ll_find < 1 Then
				ll_row = ids_next_handle.insertrow(0)
				ids_next_handle.setitem(ll_row,'handle',ll_handle_1)
				ids_next_handle.setitem(ll_row,'row_no',ids_next_handle.rowcount())
			End If
			ll_handle_2 = 0
		End If
		
		If of_delete(ll_handle) = 0 Then Return 0				
		If of_delete_child(ll_handle)	= 0 Then Return 0	
   End If
	
   ll_handle = tabpage_browse.tv_clause.FindItem(NextTreeItem!,ll_handle_1)
	
	If ll_handle > 0 Then
		If of_delete(ll_handle) = 0 Then Return 0		
	Else
		ll_row = ids_next_handle.rowcount()
		If ll_row > 0 Then
			ll_handle_1 = ids_next_handle.getitemnumber(ll_row,'handle')			
	   	ll_handle = tabpage_browse.tv_clause.FindItem(NextTreeItem!,ll_handle_1)
			ids_next_handle.deleterow(ll_row)
			If ll_handle > 0 Then
				If of_delete(ll_handle) = 0 Then Return 0
			End If
		End If
	End If
	ll_handle_1 = ll_handle
Loop
il_first = 1
Return 1


end function

public function integer of_get_folder (long al_handle);TreeViewItem ltvi_node
long ll_tvi,ll_pos,ll_id,ll_find
string ls_data,ls_type,ls_find,ls_clause_rely_filter
long i,ll_clause_rely_rowcount

tabpage_browse.tv_clause.GetItem(al_handle, ltvi_node)
ls_data = string(ltvi_node.data)

ll_pos = pos(ls_data,'-')
ll_id = long(mid(ls_data,1,ll_pos - 1))
ls_type = mid(ls_data,ll_pos + 1,1)

If ls_type = 'F' Then
	il_folder[upperbound(il_folder) + 1] = ll_id
End If
		
Return 1

end function

public function integer of_get_child_folder (long al_handle);TreeViewItem ltvi_node
long ll_handle,ll_handle_1,ll_handle_2
long ll_row,ll_find

ll_handle = al_handle
ll_handle_1 = al_handle

Do While ll_handle > 0
	ll_handle = tabpage_browse.tv_clause.FindItem(ChildTreeItem!,ll_handle)
	If il_first = 1 Then
		ll_handle_1 = ll_handle
		il_first++
	End If
	
	If ll_handle > 0 Then		
   	ll_handle_2 = tabpage_browse.tv_clause.FindItem(NextTreeItem!,ll_handle_1)
		If ll_handle_2 > 0 Then
			ll_row = ids_next_handle.rowcount()
			If ll_row > 0 Then
				ll_find = ids_next_handle.find("handle = " +string(ll_handle_1),1,ll_row)
			Else
				ll_find = 0
			End If
			If ll_find < 1 Then
				ll_row = ids_next_handle.insertrow(0)
				ids_next_handle.setitem(ll_row,'handle',ll_handle_1)
				ids_next_handle.setitem(ll_row,'row_no',ids_next_handle.rowcount())
			End If
			ll_handle_2 = 0
		End If
		
		of_get_folder(ll_handle)				
		of_get_child_folder(ll_handle)		
   End If
	
   ll_handle = tabpage_browse.tv_clause.FindItem(NextTreeItem!,ll_handle_1)
	
	If ll_handle > 0 Then
		of_get_folder(ll_handle)	
	Else
		ll_row = ids_next_handle.rowcount()
		If ll_row > 0 Then
			ll_handle_1 = ids_next_handle.getitemnumber(ll_row,'handle')			
	   	ll_handle = tabpage_browse.tv_clause.FindItem(NextTreeItem!,ll_handle_1)
			ids_next_handle.deleterow(ll_row)
			If ll_handle > 0 Then
				of_get_folder(ll_handle)
			End If
		End If
	End If
	ll_handle_1 = ll_handle
Loop
il_first = 1
Return 1


end function

public subroutine of_close ();Try 
//	tabpage_clause.ole_1.object.Close()
Catch (RunTimeError rte)
	messagebox('Error', 'The Office Viewer Active X Control has failed.')
End Try
Destroy ids_template_clause
Destroy ids_clause
Destroy ids_folder
Destroy ids_clause_rely
Destroy ids_next_handle
Destroy ids_search_clause_text

end subroutine

public subroutine of_add_folder ();If il_category = 0 Then
	il_category = tabpage_browse.dw_filter.getitemnumber(tabpage_browse.dw_filter.getrow(),'category')
	If isnull(il_category) Then il_category = 0
End If

istr_folder.as_type = 'Add'
istr_folder.al_folder_id = il_ctx_acp_folder_id
istr_folder.al_category = il_category
openwithparm(w_add_folder,istr_folder)

end subroutine

public subroutine of_add_clause ();If il_ctx_acp_folder_id > 0 Then
	istr_folder.as_type = 'Add'
	istr_folder.al_folder_id = il_ctx_acp_folder_id
	istr_folder.al_category = il_category
	openwithparm(w_add_clause,istr_folder)

	is_types = 'Add'
End If

end subroutine

public subroutine of_properties ();integer li_position
long ll_ctx_acp_folder_id,ll_category,ll_Handle,ll_find,ll_ctx_acp_clause_id
long ll_folder[]
string ls_data

If is_type = 'F' Then
	If il_ctx_acp_folder_id = 0 Then Return
	ids_folder.setfilter('')
	ids_folder.filter()
	ids_clause.setfilter('')
	ids_clause.filter()
	ids_template_clause.setfilter('')
	ids_template_clause.filter()
	ids_clause_rely.setfilter('')
	ids_clause_rely.filter()
	ids_next_handle.reset()
	
	il_folder = ll_folder
	of_get_child_folder(il_handle)
	il_folder[upperbound(il_folder) + 1] = il_ctx_acp_folder_id
	
	istr_folder.as_type = 'Update'
	istr_folder.al_folder_id = il_ctx_acp_folder_id
	istr_folder.al_category = il_category
	istr_folder.al_folder = il_folder
	openwithparm(w_add_folder,istr_folder)
ElseIf is_type = 'C' Then
	If il_ctx_acp_clause_id = 0 Then Return
	istr_folder.as_type = 'Update'
	istr_folder.al_category = il_category	
	istr_folder.al_clause_id = il_ctx_acp_clause_id
	openwithparm(w_add_clause,istr_folder)
End If

If is_type = 'F' Or is_type = 'C' Then
	ll_ctx_acp_clause_id = il_ctx_acp_clause_id
	If is_type = 'F' Then
		ls_data = string(il_ctx_acp_folder_id) + '-' + 'F' + '+' + string(il_category)
		tabpage_browse.dw_browse.setfilter("ctx_acp_folder_id = " + string(il_ctx_acp_folder_id))
		tabpage_browse.dw_browse.filter()
	Else
		If is_click = 'dw' Then
			If tabpage_browse.dw_browse.rowcount() = 1 Then
				If il_ctx_acp_clause_id <> 0 Then
					ls_data = string(il_ctx_acp_clause_id) + '-' + 'C'
					tabpage_browse.dw_browse.setfilter("ctx_acp_clause_id = " + string(il_ctx_acp_clause_id))
					tabpage_browse.dw_browse.filter()
				End If
			Else
				il_ctx_acp_folder_id = tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'ctx_acp_folder_id')
				ls_data = string(il_ctx_acp_folder_id) + '-' + 'F' + '+' + string(il_category)
				tabpage_browse.dw_browse.setfilter("ctx_acp_folder_id = " + string(il_ctx_acp_folder_id))
				tabpage_browse.dw_browse.filter()
			End If
		Else
			ls_data = string(il_ctx_acp_clause_id) + '-' + 'C'
			tabpage_browse.dw_browse.setfilter("ctx_acp_clause_id = " + string(il_ctx_acp_clause_id))
			tabpage_browse.dw_browse.filter()			
		End If			
	End If	
	gnv_appeondb.of_startqueue( )
	ids_folder.retrieve()
	ids_clause.retrieve()
	tabpage_browse.dw_browse.retrieve()
	gnv_appeondb.of_commitqueue( )
	
	ll_find = tabpage_browse.dw_browse.find("ctx_acp_clause_id = " + string(ll_ctx_acp_clause_id),1,tabpage_browse.dw_browse.rowcount())
	If ll_find > 0 Then
		tabpage_browse.dw_browse.scrolltorow(ll_find)
		tabpage_browse.dw_browse.selectrow(0,false)
		tabpage_browse.dw_browse.selectrow(ll_find,true)
	End If
	
	ll_Handle = w_clause_painter.tab_1.of_getHandle(ls_data,1)
	w_clause_painter.tab_1.tabpage_browse.tv_clause.selectitem(ll_Handle)	

End If

end subroutine

public subroutine of_set_word_view_size ();//oleobject lole_size
//
//If tabpage_clause.ole_1.object.DocType > 0 Then
//	lole_size = Create oleobject
//	lole_size = tabpage_clause.ole_1.object.activedocument
//	lole_size.ActiveWindow.ActivePane.View.Zoom.Percentage = 100
//	Destroy lole_size
//End If
//
// 
//
//
end subroutine

public function integer of_open_word_file ();//string ls_file_name
//long ll_new_clause_id
//If tabpage_browse.dw_browse.rowcount() > 0 Then
//	ll_new_clause_id = tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'ctx_acp_clause_id')
//	If ll_new_clause_id <> il_old_clause_id Then
//		il_ctx_acp_clause_id = ll_new_clause_id
//		il_old_clause_id = ll_new_clause_id
//	   If is_types = '' Then is_types = 'Update'
//	Else
//		Return 1
//	End If
//Else
//	Return 0
//End If
//If of_create_word_file(il_ctx_acp_clause_id,ls_file_name) = 1 Then
//	openwithparm( w_appeon_gifofwait, "Opening selected document..." )
//	Try 
//		tabpage_clause.ole_1.object.OpenLocalFile(ls_file_name , false)
//		of_set_word_view_size()
//		tabpage_clause.ole_1.setfocus()
//	Catch (RunTimeError rter)
//		messagebox('Error', 'The Office Viewer Active X Control has failed.')
//		If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//		Return 0
//	End Try
//	If isvalid(m_pfe_cst_clause_painter) Then
//		m_pfe_cst_clause_painter.m_view.m_rules.enabled = True
//	End If
//	If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//Else
//	Return 0
//End If		

Return 1

end function

public subroutine of_rely ();If isnull(il_ctx_acp_clause_id) Or il_ctx_acp_clause_id = 0 Then Return 

istr_folder.as_type = 'Update'
istr_folder.al_folder_id = il_ctx_acp_clause_id
istr_folder.al_category = il_category	
openwithparm(w_clause_rely,istr_folder)
ids_clause_rely.retrieve()


end subroutine

public function integer of_save ();//long ll_Handle,ll_num,ll_mes
//string ls_data,ls_clause_name,ls_updatedate,ls_file_name,ls_file_name1
//datetime ldt_updatedate
//integer li_FileNum, loops, i
//boolean lb_save = True
//long  ll_flen,ll_ctx_acp_clause_id,ll_ctx_acp_folder_id,ll_category,ll_approval_status
//blob b, tot_b
//treeviewitem ltvi_item
//OLEobject  obj
//
//obj = Create oleobject
//Try 
//	obj = tabpage_clause.ole_1.object.ActiveDocument
//Catch (RunTimeError rte)
//	messagebox('Error', 'The Office Viewer Active X Control has failed.')
//End Try
//
//ldt_updatedate = datetime(today())
//ls_updatedate = string(ldt_updatedate)
//
//ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(il_ctx_acp_clause_id) + ".doc"
//ls_file_name1 = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(il_ctx_acp_clause_id) + "_1.doc"
//If obj.saved = False Then
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 2007-02-26 By: Rodger Wu
//	//$<reason> New requirement
//	//$<reason> Trim spaces or line feed at the beginning or end of clauses.
//	tabpage_clause.ole_1.setredraw( False )
//	iw_clause_painter.of_ltrimword()
//	iw_clause_painter.of_rtrimword()
//	tabpage_clause.ole_1.setredraw( True )
//	//---------------------------- APPEON END ----------------------------
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> By Alfee at 03.06.2007
//	//$<reason> New requirement, check symbols for auto numbering function
//	openwithparm(w_appeon_gifofwait, "Checking auto numbering in the file..." )
//	tabpage_clause.ole_1.setredraw( False )
//	If iw_clause_painter.of_check_numbering() < 0 Then
//		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//		messagebox("Alert","This file hasn't be saved!",Exclamation!)		
//		tabpage_clause.ole_1.setredraw( True )
//		Destroy obj
//		return -1
//	end if			
//	tabpage_clause.ole_1.setredraw( True )
//	//---------------------------- APPEON END ----------------------------
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> By Alfee at 03.09.2007
//	//$<Reason>New requirement, make sure the document won't have revisions
//	Long ll_clause_approved
//	ll_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Approval Status' and code = 'Approved'"))
//	If tabpage_browse.dw_browse.GetItemNumber(tabpage_browse.dw_browse.GetRow(),"approval_status") = ll_clause_approved Then
//		If obj.Revisions.Count > 0 Then
//			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//			MessageBox("Alert","The approved file can't include any revisons and not saved!",Exclamation!)
//			tabpage_clause.ole_1.setredraw( True )
//			Destroy obj
//			Return -1
//		End If
//	End If
//	//---------------------------- APPEON END ----------------------------
//	openwithparm(w_appeon_gifofwait, "Saving clause to DB..." )
//	lb_save = False
//	Try 
//		tabpage_clause.ole_1.object.saveToLocal(ls_file_name , True)
//	Catch (RunTimeError rter)
//		messagebox('Error', 'The Office Viewer Active X Control has failed.')
//		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//	End Try
//	
//	FileCopy (ls_file_name,ls_file_name1,False)	
//	li_FileNum = FileOpen(ls_file_name1,StreamMode!,read!,LockWrite!)
//	ll_flen = FileLength(ls_file_name1)
//	
//	If ll_flen > 32765 Then
//		If Mod(ll_flen, 32765) = 0 Then
//			loops = ll_flen/32765
//		Else
//			loops = (ll_flen/32765) + 1
//		End If
//	Else
//		loops = 1
//	End If
//	
//	For i = 1 To loops
//		FileRead(li_FileNum,b)
//		tot_b = tot_b + b
//	Next
//	FileClose(li_FileNum)
//	FileDelete(ls_file_name1)
//	
//	gnv_appeondb.of_startqueue( )	
//	UPDATEBLOB ctx_acp_clause SET image_file = :tot_b WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id;
//	UPDATE ctx_acp_clause SET modify_date = :ldt_updatedate WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id;
//	gnv_appeondb.of_commitqueue( )
//  
//	gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(il_ctx_acp_clause_id), regstring!, ls_updatedate)	
//	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//End If
//
//If is_types = 'Update' Then
//	If lb_save = False Then
//		ids_template_clause.setfilter('')
//		ids_template_clause.filter()
//		ll_num = ids_template_clause.find("ctx_acp_clause_id = " + string(il_ctx_acp_clause_id),1,ids_template_clause.rowcount())
//		If ll_num > 0 Then
//			ll_mes = messagebox('Updating existing templates','Are you sure to update existing templates with changes?',question!,YesNo!)
//			If ll_mes = 1 Then
//				openwithparm(w_clause_template,il_ctx_acp_clause_id)
//			End If
//		End If
//		lb_save = True
//	End If
//End If
//Destroy obj
////If isvalid(m_pfe_cst_clause_painter) Then
////	m_pfe_cst_clause_painter.m_file.m_save.enabled = False
////End If
//is_types = 'Update'
Return 1
end function

public function integer of_update_template (long al_template_id, string as_lastupdate);//oleobject lole_app,lole_template,lole_clause
//string ls_clause_name,ls_template_name,ls_updatedate,ls_lastupdate,ls_bookmark
//boolean lb_select = False
//long i,ll_getupdate,ll_data_length,ll_start,ll_BlobLen,ll_CurrentPos,ll_bytes,ll_len_old
//long ll_start_ori,ll_len_ori,ll_len_new
//blob lb_all_data,lb_data,lblb_Data
//integer li_loops,li_counter,li_FileNum,li_Writes,li_Cnt
//
//setpointer(HourGlass!)
//this.setredraw(false)
//
//
//ls_clause_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(il_ctx_acp_clause_id) + ".doc"
//ls_template_name = gs_dir_path + gs_DefDirName + "\Agreement\template_" + string(al_template_id) + ".doc"
//ls_updatedate = as_lastupdate
//
//If Not fileexists(ls_template_name) Then
//	lb_select = True
//Else
//	ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "template_"+string(al_template_id), regstring!, ls_lastupdate)
//	If ll_getupdate <> 1 Then
//		lb_select = True
//	Else
//		If ls_updatedate <> ls_lastupdate Then 
//			lb_select = True
//		End If		
//	End If	
//End If
//
//If lb_select = True Then				
//	lb_select = False				
//	If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then		
//		SELECTBLOB image_file INTO :lb_all_data
//		  FROM ctx_acp_template WHERE ctx_acp_template_id = :al_template_id;
//	Else
//		SELECT Datalength(image_file)	INTO :ll_data_length
//		  FROM ctx_acp_template WHERE ctx_acp_template_id = :al_template_id;
//		
//		If isnull(ll_data_length) Then ll_data_length = 0
//		
//		If ll_data_length > 8000 Then 
//			If Mod(ll_data_length,8000) = 0 Then
//				li_loops = ll_data_length/8000 
//			Else
//				li_loops = (ll_data_length/8000) + 1 
//			End If 
//		ElseIf ll_data_length > 0 Then 
//			li_loops = 1 
//		End If 
//		
//		lb_all_data = blob('')
//		lb_data = blob('')
//		For li_counter = 1 To li_loops				
//			ll_start = (li_counter - 1) * 8000 + 1
//			SELECTBLOB substring(image_file,:ll_start,8000)	INTO :lb_data
//		     FROM ctx_acp_template WHERE ctx_acp_template_id = :al_template_id;
//			lb_all_data += lb_data
//		Next 
//	End If
//	If isnull(lb_all_data) Then 
//		lb_all_data = blob('')
//	End If
//	
//	li_FileNum = FileOpen(ls_template_name , StreamMode! ,Write!,Shared!, Replace!)
//	If li_FileNum = -1 Then Return -1
//		
//	ll_BlobLen = Len(lb_all_data)
//	If ll_BlobLen > 32765 Then
//		 If Mod(ll_BlobLen, 32765) = 0 Then
//			 li_Writes = ll_BlobLen / 32765
//		 Else
//			 li_Writes = (ll_BlobLen / 32765) + 1
//		 End If
//	 Else
//		 li_Writes = 1
//	End If
//	
//	ll_CurrentPos = 1
//	
//	For li_Cnt = 1 To li_Writes
//		 lblb_Data = BlobMid(lb_all_data, ll_CurrentPos, 32765)
//		 ll_CurrentPos += 32765
//		 ll_bytes = FileWrite(li_FileNum, lblb_Data)
//		 If ll_bytes = -1 Then
//			 Return -1
//		 End If
//	Next			
//	FileClose(li_FileNum)								
//End if
//
//tabpage_clause.ole_1.object.OpenLocalFile(ls_template_name,False)
//
//lole_template = create oleobject
//lole_template = tabpage_clause.ole_1.object.ActiveDocument
//lole_template.bookmarks.DefaultSorting = 1
//
//ls_bookmark = "clause_" + string(il_ctx_acp_clause_id)
//
//lole_app = create oleobject
//If lole_app.Connecttonewobject("word.application") <> 0 Then
//	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
//	This.setredraw(True)	
//	Return -1
//End If 
//
//lole_app.visible = False
//lole_app.Application.Documents.Open(ls_clause_name)
//lole_clause = lole_app.activedocument
//
//lole_clause.content.Select()
//lole_clause.activewindow.selection.copy()
//
//If lole_template.bookmarks.Exists(ls_bookmark) Then
//	For i = 1 to lole_template.bookmarks.count		
//		If lole_template.content.bookmarks.item(i).name = ls_bookmark Then
//			ll_start_ori = lole_template.content.bookmarks.item[i].start
//			ll_len_ori = lole_template.content.bookmarks.item[i].end - ll_start_ori
//			ll_len_old = lole_template.content.end
//			
//			lole_template.bookmarks.item(ls_bookmark).select()
//			lole_template.content.bookmarks.item[i].select()
//			lole_template.activewindow.selection.paste()			
//			lole_template.activewindow.selection.insertbreak(6)	
//			
//			ll_len_new = lole_template.content.end
//			ll_len_new = ll_len_ori + (ll_len_new - ll_len_old)
//			
//			lole_template.activewindow.selection.expand()			
//			lole_template.bookmarks.add(ls_bookmark,lole_template.range(ll_start_ori, ll_start_ori + ll_len_new))
//			lole_template.content.bookmarks.item[i].start = lole_template.content.bookmarks.item[i].start + ll_len_new
//			Exit
//		End If
//   Next
//End If
//
//lole_app.ActiveDocument.Close(0)
//lole_app.Quit(0)
//lole_app.DisconnectObject( )
//Destroy lole_template
//Destroy lole_clause
//Destroy lole_app
//
//tabpage_clause.ole_1.object.saveToLocal(ls_template_name,True)
//tabpage_clause.ole_1.object.OpenLocalFile(ls_clause_name,False)
//
//This.setredraw(True)	
//
return 1
end function

public function integer of_update_category (long al_folder_id, decimal adc_category);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_update_category
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version by Jervis
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
long ll_folder_count,ll_i
long ll_clause_count,ll_j
long ll_folder[],ll_reset[]
string ls_filter_folder,ls_filter_clause

//Update the category value for sub folder
ids_folder.SetFilter( "parent_folder_id = " + String(al_folder_id))
ids_folder.Filter()
ids_clause.SetFilter( "ctx_acp_folder_id = " + string(al_folder_id))
ids_clause.Filter()

ll_folder_count = ids_folder.RowCount()
ll_clause_count = ids_clause.RowCount()
for ll_j = 1 to ll_clause_count
	ids_clause.SetItem( ll_j,"category",adc_category)
next

do while ll_folder_count > 0
	//ll_folder = ids_folder.object.ctx_acp_folder_id[]
	ll_folder = ll_reset
	ls_filter_folder = ''
	ls_filter_clause = ''
	for ll_i = 1 to ll_folder_count
		ll_folder[ll_i] = ids_folder.GetItemNumber(ll_i,"ctx_acp_folder_id")
		ids_folder.SetItem(ll_i,"category",adc_category)
		ls_filter_folder += " or parent_folder_id = " + string(ll_folder[ll_i])
		ls_filter_clause += " or ctx_acp_folder_id = " + string(ll_folder[ll_i])
	next
	ls_filter_folder = mid(ls_filter_folder,4)
	ls_filter_clause = mid(ls_filter_clause,4)
	ids_folder.SetFilter(ls_filter_folder)
	ids_folder.Filter()
	ids_clause.SetFilter(ls_filter_clause)
	ids_clause.Filter()
	
	ll_folder_count = ids_folder.RowCount()
	ll_clause_count = ids_clause.RowCount()
	for ll_j = 1 to ll_clause_count
		ids_clause.SetItem( ll_j,"category",adc_category)
	next
LOOP

ids_folder.SetFilter("")
ids_folder.Filter()
ids_clause.SetFilter("")
ids_clause.Filter()

gnv_appeondb.of_startqueue( )
ids_folder.update( )
ids_clause.update( )
commit;
gnv_appeondb.of_commitqueue( )


return 1
end function

on u_tab_agreement_clause_reference.create
this.tabpage_browse=create tabpage_browse
this.tabpage_clause=create tabpage_clause
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_browse
this.Control[iCurrent+2]=this.tabpage_clause
end on

on u_tab_agreement_clause_reference.destroy
call super::destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_clause)
end on

event constructor;call super::constructor;iw_clause_painter = iw_parent
this.of_SetResize (TRUE)
long ll_i
FOR ll_i =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (CONTrol[LL_I]  , inv_resize.scale	 )
NEXT

FOR ll_i =  1 TO UPPERBOUND(tabpage_browse.control)
   this.inv_resize.of_Register (tabpage_browse.control[ll_i]  , inv_resize.scale	 )
NEXT
end event

event selectionchanged;call super::selectionchanged;//If newindex = 1 Then
//	If isvalid(m_pfe_cst_clause_painter) Then
//		If m_pfe_cst_clause_painter.m_file.m_save.enabled = True Then
//			iw_clause_painter.event pfc_save()
//		End If
//		m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_clausereference.enabled = False	
//		m_pfe_cst_clause_painter.m_file.m_autonum.enabled = False	
//		m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum0.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum1.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum2.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum3.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum4.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum5.enabled = False		
//		
//		//-------------Appeon Begin -----by Derek at 03.13.2007---------
//		m_pfe_cst_clause_painter.m_file.m_select.enabled = True
//		m_pfe_cst_clause_painter.m_file.m_expandall.enabled = True
//		m_pfe_cst_clause_painter.m_file.m_collapseall.enabled = True
//		m_pfe_cst_clause_painter.m_file.m_addclause.enabled = True
//		m_pfe_cst_clause_painter.m_edit.m_insert.enabled = True
//		//-------------Appeon End   ------------------------------------
//
//	End If
//End If
//
//If newindex = 2 Then
//	If of_open_word_file() = 1 Then
//		If isvalid(m_pfe_cst_clause_painter) Then
//			m_pfe_cst_clause_painter.m_file.m_save.enabled = True
//			m_pfe_cst_clause_painter.m_file.m_autonum.enabled = True	
//			m_pfe_cst_clause_painter.m_file.m_clausereference.enabled = True				
//			m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum0.enabled = True
//			m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum1.enabled = True
//			m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum2.enabled = True
//			m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum3.enabled = True
//			m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum4.enabled = True
//			m_pfe_cst_clause_painter.m_file.m_autonum.m_autonum5.enabled = True
//			
//			//-------------Appeon Begin -----by Derek at 03.13.2007---------
//			m_pfe_cst_clause_painter.m_file.m_select.enabled = False
//			m_pfe_cst_clause_painter.m_file.m_expandall.enabled = False
//			m_pfe_cst_clause_painter.m_file.m_collapseall.enabled = False
//			m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
//			m_pfe_cst_clause_painter.m_edit.m_insert.enabled = False
//			//-------------Appeon End   ------------------------------------
//		End If
//	End If
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 21-03-2007 By: Ken.Guo
//	//$<reason> Fix Issue: Need set focus to Word Document when add a clause.
//	//Must POST ue_setfocus_ole event.
//	post event ue_setfocus_ole( )	
//	//---------------------------- APPEON END ----------------------------
//	
//End If
//
end event

type tabpage_browse from userobject within u_tab_agreement_clause_reference
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4032
integer height = 2004
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_filter dw_filter
dw_browse dw_browse
tv_clause tv_clause
cb_clear cb_clear
cb_go cb_go
gb_1 gb_1
end type

on tabpage_browse.create
this.dw_filter=create dw_filter
this.dw_browse=create dw_browse
this.tv_clause=create tv_clause
this.cb_clear=create cb_clear
this.cb_go=create cb_go
this.gb_1=create gb_1
this.Control[]={this.dw_filter,&
this.dw_browse,&
this.tv_clause,&
this.cb_clear,&
this.cb_go,&
this.gb_1}
end on

on tabpage_browse.destroy
destroy(this.dw_filter)
destroy(this.dw_browse)
destroy(this.tv_clause)
destroy(this.cb_clear)
destroy(this.cb_go)
destroy(this.gb_1)
end on

type dw_filter from u_dw_contract within tabpage_browse
event pfc_go ( )
boolean visible = false
integer x = 443
integer y = 112
integer width = 3328
integer height = 160
integer taborder = 21
string dataobject = "d_contract_management_clauses_filter"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event pfc_go();//Parent.Event pfc_cst_go()

end event

event constructor;call super::constructor;datawindowchild child

This.of_setupdateable(False)
This.Event ue_populatedddws()
this.of_setdropdowncalendar(true)

This.getchild('approved_by',child)
child.settransobject(sqlca)
child.retrieve()
child.insertrow(1)

This.insertrow(0)

This.setfocus()

If gs_dbtype = "SQL" And gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' Then
	dw_filter.object.clause_name_t.text = 'Full Text Search'
Else
	dw_filter.object.clause_name_t.text = 'Clause Name'
End If


end event

event itemchanged;call super::itemchanged;if lower(dwo.name) = "category" then
	this.accepttext()
	cb_go.event clicked()
end if

end event

event rbuttonup;//m_dw_clause lm_dw
//
//lm_dw = Create m_dw_clause
//lm_dw.of_SetParent (This)
//
//lm_dw.m_table.m_addrow.visible = False
//lm_dw.m_table.m_delete.visible = False
//lm_dw.m_table.m_save.visible = False
//lm_dw.m_table.m_rules.visible = False		
//lm_dw.m_table.m_properties.visible = False
//lm_dw.m_table.m_go.visible = True
//lm_dw.m_table.m_clear.visible = True
//lm_dw.m_table.PopMenu ( w_mdi.PointerX(), w_mdi.PointerY() ) 
//
//Destroy lm_dw

Return 1

end event

event pfc_clear;//parent.event pfc_clear()
return 1

end event

type dw_browse from u_dw_contract within tabpage_browse
event pfc_save ( )
event pfc_rules ( )
integer x = 1422
integer y = 16
integer width = 2610
integer height = 1980
integer taborder = 41
string dataobject = "d_clauses_painter_browse"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_allow_filter = true
boolean ib_allow_sort = true
end type

event pfc_rules();iw_clause_painter.Event pfc_cst_rules()

end event

event constructor;call super::constructor;datawindowchild child
long ll_find

This.Event ue_populatedddws()
This.getchild('ctx_acp_folder_id',idw_child)
idw_child.settransobject(sqlca)

This.getchild('category',child)
child.settransobject(sqlca)
child.retrieve()
child.insertrow(1)
child.setitem(1,'lookup_code',-777)
child.setitem(1,'code','*Add lookup Code*')

This.getchild('approval_status',child)
ll_find = child.find("code = '(NONE)'",1,child.rowcount())
If ll_find > 0 Then
	child.deleterow(ll_find)
End If
is_old_sql = This.getsqlselect()

end event

event doubleclicked;call super::doubleclicked;If This.GetRow() > 0 Then
//If This.rowcount() > 0 Then
//	If of_open_word_file() = 1 Then
//		selecttab(2)
//	End If
	If Not IsNull(iw_clause_painter) Then
		iw_clause_painter.cb_ok.Event clicked()
	End If
End If

end event

event editchanged;//If isvalid(m_pfe_cst_clause_painter) Then
//	m_pfe_cst_clause_painter.m_file.m_save.enabled = True
//End If
//
end event

event getfocus;//
end event

event itemchanged;call super::itemchanged;//long ll_approval_status,ll_approval_status1,ll_category,ll_row,ll_ctx_acp_folder_id
//string ls_category_name
//
//dw_properties.accepttext()
//If isvalid(m_pfe_cst_clause_painter) Then
//	m_pfe_cst_clause_painter.m_file.m_save.enabled = True
//End If
//If dwo.name = 'category' Then
//	ll_category = This.getitemnumber(This.getrow(),'category')
//	If ll_category = -777 Then Return
//	ls_category_name = This.Describe("Evaluate('LookupDisplay(category)'," + string(row) + ")")	
//	ll_row = idw_child.retrieve(ll_category)
//	If ll_category <> il_category Then
//		setnull(ll_ctx_acp_folder_id)
//		This.setitem(This.getrow(),'ctx_acp_folder_id',ll_ctx_acp_folder_id)
//		il_category = ll_category
//	End If
//	If ll_row < 1 then
//		messagebox('Error','There is no folder with the category ' + ls_category_name + '.  Please add a folder first.')
//		Return
//	End If
//End If
//If dwo.name = 'approval_status' Then
//	ll_approval_status = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Approval Status' and code = 'Approved'"))
//	ll_approval_status1 = dw_properties.getitemnumber(dw_properties.getrow(),'approval_status')
//	If ll_approval_status1 = ll_approval_status Then
//		dw_properties.setitem(dw_properties.getrow(),'date_approved',today())
//		dw_properties.setitem(dw_properties.getrow(),'approved_by',gs_user_id)	
//	End If
//End If
//
end event

event losefocus;//
end event

event rbuttonup;//m_dw_clause lm_dw
//
//lm_dw = Create m_dw_clause
//lm_dw.of_SetParent (This)
//This.accepttext()
//
//lm_dw.m_table.m_addrow.visible = True
//If This.rowcount() < 1 Then
//	lm_dw.m_table.m_delete.visible = False
//	lm_dw.m_table.m_save.visible = False
//	lm_dw.m_table.m_rules.visible = False
//	lm_dw.m_table.m_properties.visible = False
//Else
//	is_type = 'C' 
//	is_click = 'dw'
//	il_handle = 0
//	il_handle1 = 0
//	il_category	= This.getitemnumber(This.getrow(),'category')
//	il_ctx_acp_folder_id = This.getitemnumber(This.getrow(),'ctx_acp_folder_id')
//	il_ctx_acp_clause_id = This.getitemnumber(This.getrow(),'ctx_acp_clause_id')
//	If isvalid(m_pfe_cst_clause_painter) Then
//		m_pfe_cst_clause_painter.m_file.m_addclause.enabled = True
//		m_pfe_cst_clause_painter.m_view.m_rules.enabled = True
//		m_pfe_cst_clause_painter.m_file.m_properties.enabled = True
//		m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = True
//	End If
//	lm_dw.m_table.m_delete.visible = True
//	lm_dw.m_table.m_save.visible = False
//	lm_dw.m_table.m_rules.visible = True
//	lm_dw.m_table.m_properties.visible = True
//End If
//lm_dw.m_table.PopMenu (w_mdi.PointerX(),w_mdi.PointerY()) 
//
//Destroy lm_dw
//
Return 1

end event

event pfc_deleterow;iw_clause_painter.Event pfc_deleterow()
Return 1

end event

event pfc_addrow;iw_clause_painter.Event pfc_cst_add_clause()
Return 1

end event

event pfc_properties;iw_clause_painter.event pfc_cst_properties()

end event

event clicked;call super::clicked;If This.getrow() > 0 then
	This.SelectRow(0, FALSE)
   This.SelectRow(This.getrow(), TRUE)
	is_type = 'C' 
	is_click = 'dw'
	il_handle = 0
	il_handle1 = 0
	il_category	= This.getitemnumber(This.getrow(),'category')
	il_ctx_acp_folder_id = This.getitemnumber(This.getrow(),'ctx_acp_folder_id')
	il_ctx_acp_clause_id = This.getitemnumber(This.getrow(),'ctx_acp_clause_id')
//	If isvalid(m_pfe_cst_clause_painter) Then
//		m_pfe_cst_clause_painter.m_file.m_addclause.enabled = True
//		m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = True
//		m_pfe_cst_clause_painter.m_file.m_properties.enabled = True
//		m_pfe_cst_clause_painter.m_view.m_rules.enabled = True	
//	End If
End If

end event

event rowfocuschanged;call super::rowfocuschanged;If This.rowcount() > 0 then
	If is_type = 'C' Then
		This.SelectRow(0, FALSE)
		This.SelectRow(currentrow, TRUE)
	End If
	If This.getrow() > 0 Then
		il_category	= This.getitemnumber(This.getrow(),'category')
		il_ctx_acp_folder_id = This.getitemnumber(This.getrow(),'ctx_acp_folder_id')
		il_ctx_acp_clause_id = This.getitemnumber(This.getrow(),'ctx_acp_clause_id')
	End If
End If

end event

type tv_clause from u_tvs within tabpage_browse
event pfc_addfolder ( )
event pfc_addclause ( )
event pfc_rules ( )
integer x = 18
integer y = 16
integer width = 1399
integer height = 1980
integer taborder = 41
fontcharset fontcharset = ansi!
borderstyle borderstyle = stylebox!
boolean linesatroot = true
boolean hideselection = false
boolean fullrowselect = true
string picturename[] = {"custom039!","Custom050!","CheckDiff!","CheckDiff!"}
end type

event pfc_addfolder();//iw_clause_painter.Event pfc_addrow()
of_add_folder()


end event

event pfc_addclause();//iw_clause_painter.Event pfc_cst_add_clause()
of_add_clause()


end event

event pfc_rules();//iw_clause_painter.Event pfc_cst_rules()
of_rely()



end event

event clicked;call super::clicked;integer li_position,li_msg
long ll_ctx_acp_folder_id,ll_handle,ll_category,ll_parent_category,ll_ctx_acp_clause_id
string ls_type,ls_type1,ls_data,ls_file_name
treeviewitem tvi_click
dw_browse.SelectRow(0, FALSE)

This.getitem(handle,tvi_click)
ls_data = string(tvi_click.data)
This.SelectItem (handle)
If isnull(ls_data) Or ls_data = '0' Or ls_data = '' Then 
	il_ctx_acp_folder_id = 0
	il_ctx_acp_clause_id = 0
	il_category = 0
	il_parent_folder_id = 0
	il_handle = 0
	il_handle1 = 0
	is_type = ''
	is_types = ''
	dw_browse.setfilter('')
	dw_browse.filter()
//	If isvalid(m_pfe_cst_clause_painter) Then
//		m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
//		m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_properties.enabled = False
//		m_pfe_cst_clause_painter.m_view.m_rules.enabled = False	
//	End If
	Return
End If
is_click = 'tv'
If isvalid(m_pfe_cst_clause_painter) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', True)			//Added by Scofield on 2010-05-19
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', True)
	//-------Begin Added by Alfee 09.20.2007--------
	If w_mdi.of_security_access(6800) < 2 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', False)		//Added by Scofield on 2010-05-19
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
	End If
	//-------End Added------------------------------
End If

li_position = pos(ls_data,'-')
ll_ctx_acp_folder_id = long(mid(ls_data,1,li_position - 1))
ls_type = mid(ls_data,li_position + 1,1)
is_type = ls_type

li_position = pos(ls_data,'+')
ll_category = long(mid(ls_data,li_position + 1))

il_handle = handle
is_data_delete = ''
ll_handle = This.finditem(NextTreeItem!,handle)
If ll_handle > 0 Then
	This.getitem(ll_handle,tvi_click)
	ls_data = string(tvi_click.data)
	is_data_delete = ls_data
	li_position = pos(ls_data,'-')
	ls_type1 = mid(ls_data,li_position + 1,1)
		
	If ls_type = 'C' Then
		If ls_type1 = 'F' Then
			ll_handle = This.finditem(PreviousTreeItem!,handle)
			If ll_handle > 0 Then
				This.getitem(ll_handle,tvi_click)
				ls_data = string(tvi_click.data)
				is_data_delete = ls_data				
			End If
		End If
	End If
Else
	ll_handle = This.finditem(PreviousTreeItem!,handle)
	If ll_handle > 0 Then
		This.getitem(ll_handle,tvi_click)
		ls_data = string(tvi_click.data)		
		is_data_delete = ls_data		
	End If
End If

il_parent_folder_id = 0
ll_handle = This.finditem(ParentTreeItem!,handle)	
If ll_handle > 0 Then
	This.getitem(ll_handle,tvi_click)
	ls_data = string(tvi_click.data)
	If is_data_delete = '' Then is_data_delete = ls_data
	
	li_position = pos(ls_data,'-')
	il_parent_folder_id = long(mid(ls_data,1,li_position - 1))	
	li_position = pos(ls_data,'+')
	ll_parent_category = long(mid(ls_data,li_position + 1))	
End If

If ls_type = 'F' Then
	dw_browse.setfilter("ctx_acp_folder_id = " + string(ll_ctx_acp_folder_id))
	dw_browse.filter()
	il_ctx_acp_folder_id = ll_ctx_acp_folder_id
	il_category = ll_category
	il_handle1 = 0

	il_ctx_acp_clause_id = 0
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
	End If
ElseIf ls_type = 'C' Then
	dw_browse.setfilter("ctx_acp_clause_id = " + string(ll_ctx_acp_folder_id))
	dw_browse.filter()
	
	is_types = 'Update'
	If dw_browse.rowcount() > 0 Then
		is_clause_name = dw_browse.getitemstring(dw_browse.getrow(),'clause_name')
		If isvalid(m_pfe_cst_clause_painter) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
		End If
	End If
	ll_ctx_acp_clause_id = 	ll_ctx_acp_folder_id		
	il_ctx_acp_folder_id = il_parent_folder_id
	il_category = ll_parent_category
	il_ctx_acp_clause_id = ll_ctx_acp_clause_id
	il_handle1 = il_handle	
End If


end event

event constructor;call super::constructor;ids_folder = Create datastore
ids_folder.dataobject = 'd_folder_all'
ids_folder.settransobject(sqlca)

ids_clause = Create datastore
ids_clause.dataobject = 'd_clauses_all'
ids_clause.settransobject(sqlca)

ids_template_clause = Create datastore
ids_template_clause.dataobject = 'd_clause_template_all'
ids_template_clause.settransobject(sqlca)

ids_clause_rely = Create datastore
ids_clause_rely.dataobject = 'd_clause_rely'
ids_clause_rely.settransobject(sqlca)

ids_next_handle = Create datastore
ids_next_handle.dataobject = 'd_next_handle'
ids_next_handle.settransobject(sqlca)

ids_search_clause_text = Create datastore
ids_search_clause_text.dataobject = 'd_search_clause_text'
ids_search_clause_text.settransobject(sqlca)

of_create_clause_tree()

end event

event rightclicked;//boolean		lb_frame
//long			ll_selected
//winDow		lw_parent
//winDow		lw_frame
//winDow		lw_sheet
//winDow		lw_childparent
//m_tvs_clause lm_view
//treeviewitem lvi_item
//
//// Determine If RMB popup menu should occur
//If Not ib_rmbmenu Then
//	Return 1
//End If
//
//// Determine parent winDow for PointerX, PointerY offset
//this.of_GetParentWinDow (lw_parent)
//If IsValid (lw_parent) Then
//	// Get the MDI frame winDow If available
//	lw_frame = lw_parent
//	Do While IsValid (lw_frame)
//		If lw_frame.winDowtype = mdi! Or lw_frame.winDowtype = mdihelp! Then
//			lb_frame = True
//			Exit
//		Else
//			lw_frame = lw_frame.ParentWinDow()
//		End If
//	Loop
//	
//	If lb_frame Then
//		// If MDI frame winDow is available, use it as the reference point for the
//		// popup menu for sheets (winDows opened with OpenSheet function) or child winDows
//		If lw_parent.winDowtype = child! Then
//			lw_parent = lw_frame
//		Else
//			lw_sheet = lw_frame.GetFirstSheet()
//			If IsValid (lw_sheet) Then
//				Do
//					// Use frame reference for popup menu If the parentwinDow is a sheet
//					If lw_sheet = lw_parent Then
//						lw_parent = lw_frame
//						Exit
//					End If
//					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
//				Loop until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
//			End If
//		End If
//	Else
//		// SDI application.  All winDows except for child winDows will use the parent
//		// winDow of the control as the reference point for the popmenu
//		If lw_parent.winDowtype = child! Then
//			lw_childparent = lw_parent.ParentWinDow()
//			If IsValid (lw_childparent) Then
//				lw_parent = lw_childparent
//			End If
//		End If
//	End If
//Else
//	Return 1
//End If
//
//// Create popup menu
//If IsNull(lm_view) Or Not IsValid (lm_view) Then
//	lm_view = Create m_tvs_clause
//	lm_view.of_SetParent (This)
//End If
//
This.Event clicked(handle)
//
//// Make rightclicked item the current item 
//This.SelectItem ( handle )
//
//// we have clicked on an item
//If handle > 0 Then
//	lm_view.m_viewitem.m_addclause.visible = True
//	lm_view.m_viewitem.m_delete1.visible = True
//	lm_view.m_viewitem.m_rules.visible = True
//	lm_view.m_viewitem.m_properties1.visible = True	
//Else
//	// We are Not on an item
//	lm_view.m_viewitem.m_addclause.visible = False
//	lm_view.m_viewitem.m_delete1.visible = False
//	lm_view.m_viewitem.m_rules.visible = False
//	lm_view.m_viewitem.m_properties1.visible = False	
//End If
//If il_ctx_acp_folder_id = 0 Then
//	lm_view.m_viewitem.m_addclause.enabled = False
//	lm_view.m_viewitem.m_delete1.enabled = False
//	lm_view.m_viewitem.m_rules.enabled = False
//	lm_view.m_viewitem.m_properties1.enabled = False	
//Else	
//	If is_type = 'C' Then
//		lm_view.m_viewitem.m_rules.enabled = True
//	Else
//		lm_view.m_viewitem.m_rules.enabled = False
//	End If	
//End If	
//lm_view.m_viewitem.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
//
//If IsValid(lm_view) Then Destroy lm_view
//
Return 1
end event

event pfc_deleteitem;//iw_clause_painter.Event pfc_deleterow()
of_deleterow()
Return 1
end event

event pfc_properties;call super::pfc_properties;//iw_clause_painter.event pfc_cst_properties()
of_properties()
Return 1
end event

event doubleclicked;call super::doubleclicked;If is_type = 'C' Then
	If tabpage_browse.dw_browse.rowcount() > 0 Then
//		If of_open_word_file() = 1 Then
//			selecttab(2)
//		End If
		If Not IsNull(iw_clause_painter) Then
			iw_clause_painter.cb_ok.Event clicked()
		End If
	End If
End If
end event

event selectionchanged;call super::selectionchanged;integer li_position,li_msg
long ll_ctx_acp_folder_id,ll_handle,ll_category,ll_parent_category,ll_ctx_acp_clause_id
string ls_type,ls_type1,ls_data,ls_file_name
treeviewitem tvi_click
dw_browse.SelectRow(0, FALSE)

This.getitem(newhandle,tvi_click)
ls_data = string(tvi_click.data)
This.SelectItem (newhandle)
If isnull(ls_data) Or ls_data = '0' Or ls_data = '' Then 
	il_ctx_acp_folder_id = 0
	il_ctx_acp_clause_id = 0
	il_category = 0
	il_parent_folder_id = 0
	il_handle = 0
	il_handle1 = 0
	is_type = ''
	is_types = ''
	dw_browse.setfilter('')
	dw_browse.filter()
//	If isvalid(m_pfe_cst_clause_painter) Then
//		m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
//		m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//		m_pfe_cst_clause_painter.m_file.m_properties.enabled = False
//		m_pfe_cst_clause_painter.m_view.m_rules.enabled = False	
//	End If
	Return
End If
is_click = 'tv'
If isvalid(m_pfe_cst_clause_painter) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', True)				//Added by Scofield on 2010-05-19
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', True)
	//-------Begin Added by Alfee 09.20.2007--------
	If w_mdi.of_security_access(6800) < 2 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', False)			//Added by Scofield on 2010-05-19
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
	End If
	//-------End Added------------------------------
End If

li_position = pos(ls_data,'-')
ll_ctx_acp_folder_id = long(mid(ls_data,1,li_position - 1))
ls_type = mid(ls_data,li_position + 1,1)
is_type = ls_type

li_position = pos(ls_data,'+')
ll_category = long(mid(ls_data,li_position + 1))

il_handle = newhandle
is_data_delete = ''
ll_handle = This.finditem(NextTreeItem!,newhandle)
If ll_handle > 0 Then
	This.getitem(ll_handle,tvi_click)
	ls_data = string(tvi_click.data)
	is_data_delete = ls_data
	li_position = pos(ls_data,'-')
	ls_type1 = mid(ls_data,li_position + 1,1)
		
	If ls_type = 'C' Then
		If ls_type1 = 'F' Then
			ll_handle = This.finditem(PreviousTreeItem!,newhandle)
			If ll_handle > 0 Then
				This.getitem(ll_handle,tvi_click)
				ls_data = string(tvi_click.data)
				is_data_delete = ls_data				
			End If
		End If
	End If
Else
	ll_handle = This.finditem(PreviousTreeItem!,newhandle)
	If ll_handle > 0 Then
		This.getitem(ll_handle,tvi_click)
		ls_data = string(tvi_click.data)		
		is_data_delete = ls_data		
	End If
End If

il_parent_folder_id = 0
ll_handle = This.finditem(ParentTreeItem!,newhandle)	
If ll_handle > 0 Then
	This.getitem(ll_handle,tvi_click)
	ls_data = string(tvi_click.data)
	If is_data_delete = '' Then is_data_delete = ls_data
	
	li_position = pos(ls_data,'-')
	il_parent_folder_id = long(mid(ls_data,1,li_position - 1))	
	li_position = pos(ls_data,'+')
	ll_parent_category = long(mid(ls_data,li_position + 1))	
End If

If ls_type = 'F' Then
	dw_browse.setfilter("ctx_acp_folder_id = " + string(ll_ctx_acp_folder_id))
	dw_browse.filter()
	il_ctx_acp_folder_id = ll_ctx_acp_folder_id
	il_category = ll_category
	il_handle1 = 0

	il_ctx_acp_clause_id = 0
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
	End If
ElseIf ls_type = 'C' Then
	dw_browse.setfilter("ctx_acp_clause_id = " + string(ll_ctx_acp_folder_id))
	dw_browse.filter()
	
	is_types = 'Update'
	If dw_browse.rowcount() > 0 Then
		is_clause_name = dw_browse.getitemstring(dw_browse.getrow(),'clause_name')
		If isvalid(m_pfe_cst_clause_painter) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
		End If
	End If
	ll_ctx_acp_clause_id = 	ll_ctx_acp_folder_id		
	il_ctx_acp_folder_id = il_parent_folder_id
	il_category = ll_parent_category
	il_ctx_acp_clause_id = ll_ctx_acp_clause_id
	il_handle1 = il_handle	
End If


end event

type cb_clear from commandbutton within tabpage_browse
boolean visible = false
integer x = 3694
integer y = 104
integer width = 293
integer height = 92
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Clear"
end type

event clicked;tabpage_browse.dw_filter.reset()
dw_filter.insertrow(0)
il_ctx_acp_folder_id = 0
il_ctx_acp_clause_id = 0
il_category = 0
il_parent_folder_id = 0
il_handle = 0
il_handle1 = 0
is_type = ''
is_types = ''

//If isvalid(m_pfe_cst_clause_painter) Then
//	m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
//	m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False
//	m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//	m_pfe_cst_clause_painter.m_file.m_properties.enabled = False
//	m_pfe_cst_clause_painter.m_view.m_rules.enabled = False	
//End If
of_create_clause_tree()



end event

type cb_go from commandbutton within tabpage_browse
boolean visible = false
integer x = 3397
integer y = 104
integer width = 293
integer height = 92
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
end type

event clicked;il_ctx_acp_folder_id = 0
il_ctx_acp_clause_id = 0
il_category = 0
il_parent_folder_id = 0
il_handle = 0
il_handle1 = 0
is_type = ''
is_types = ''
long ll_tvi //by alfee at 03.07.2007

of_create_clause_tree()

//added by alfee at 03.07.2007 for full text search
If ib_fulltextsearch Then 
	ll_tvi = tv_clause.FindItem(RootTreeItem! , 0)
	tv_clause.expandall(ll_tvi) 
End If

//If isvalid(m_pfe_cst_clause_painter) Then
//	m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
//	m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False
//	m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//	m_pfe_cst_clause_painter.m_file.m_properties.enabled = False
//	m_pfe_cst_clause_painter.m_view.m_rules.enabled = False	
//End If

end event

type gb_1 from groupbox within tabpage_browse
boolean visible = false
integer width = 4032
integer height = 232
integer taborder = 11
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Search Criteria"
end type

type tabpage_clause from u_tabpg_agreement_template_detail within u_tab_agreement_clause_reference
boolean visible = false
integer x = 18
integer y = 100
integer width = 4032
integer height = 2004
boolean enabled = false
long backcolor = 33551856
string text = "Clause"
string picturename = ""
end type

