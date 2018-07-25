$PBExportHeader$u_tab_agreement_clause_painter.sru
$PBExportComments$Create by Jack 03/05/2007
forward
global type u_tab_agreement_clause_painter from u_tab
end type
type tabpage_browse from userobject within u_tab_agreement_clause_painter
end type
type dw_clause_full_analysis from u_dw_contract within tabpage_browse
end type
type pb_attrifilter from picturebutton within tabpage_browse
end type
type st_1 from u_st_splitbar within tabpage_browse
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
type st_tip from statictext within tabpage_browse
end type
type tabpage_browse from userobject within u_tab_agreement_clause_painter
dw_clause_full_analysis dw_clause_full_analysis
pb_attrifilter pb_attrifilter
st_1 st_1
dw_filter dw_filter
dw_browse dw_browse
tv_clause tv_clause
cb_clear cb_clear
cb_go cb_go
gb_1 gb_1
st_tip st_tip
end type
type tabpage_clause from u_tabpg_agreement_template_detail within u_tab_agreement_clause_painter
end type
type tabpage_clause from u_tabpg_agreement_template_detail within u_tab_agreement_clause_painter
end type
end forward

global type u_tab_agreement_clause_painter from u_tab
integer width = 4032
integer height = 2096
long backcolor = 33551856
tabpage_browse tabpage_browse
tabpage_clause tabpage_clause
event ue_setfocus_ole ( )
event ue_locate_clause ( long al_clause_id )
event ue_auto_retrieve ( )
end type
global u_tab_agreement_clause_painter u_tab_agreement_clause_painter

type variables
w_clause_painter iw_clause_painter
n_cst_word_utility inv_word_utility //Alfee 09.22.2008

long il_handle,il_handle1,il_ctx_acp_folder_id,il_ctx_acp_clause_id,il_parent_folder_id,il_category
long il_first = 1,il_old_clause_id
long il_folder[]
string is_type,is_clause_name
String is_types = 'Update'
string is_data = '',is_data_delete,is_filter,is_old_sql
string is_click
str_folder istr_folder
datastore ids_template_clause
datastore ids_folder
datastore ids_clause
datastore ids_clause_rely
datastore ids_next_handle
datastore ids_search_clause_text
datastore ids_ctx_am_document_clause  // Add by Jack 04/04/2007
DataStore ids_AttriValue					//Added by Scofield on 2010-01-07
datawindowchild idw_child

boolean ib_fulltextsearch  //added by alfee at 03.07.2007
n_cst_clause_comparison inv_clause_comparison //Added by Alfee 10.18.2007

str_clause_filter	istr_ClauseFilter

Constant Long wdDoNotSaveChanges = 0 
Constant Long wdPromptToSaveChanges = -2 
Constant Long wdSaveChanges = -1 

//----Begin Added by alfee at 05.29.2007 -------------
// WdBreakType
Constant long wdSectionBreakNextPage = 2 
Constant long wdSectionBreakContinuous = 3 //01.18.2008
// WdCollapseDirection
Constant long wdCollapseEnd = 0
Constant long wdCollapseStart = 1
//----End Added --------------------------------------

string is_TreeItemType //added by evan at 10.23.2007

Constant long wdFormatDocument = 0 //Alfee 10.31.2007

CONSTANT STRING ENTERCHAR = "~r~n"

CONSTANT LONG	ATTRIBUTECNTS = 6

Boolean ib_showed = False	//Added by Ken.Guo on 2008-11-06

//Added By Ken.Guo 2009-12-30.
n_cst_clause inv_clause
decimal{1} idec_revision,idec_old_revision
n_cst_dm_utils inv_dm_utils
n_cst_ovole_utils  inv_ole_utils_doc
DataStore ids_clause_info
DatawindowChild idwc_folder
Boolean	ib_autoretrieve			//Added By Mark Lee 07/18/12
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
public function integer of_update_category (long al_folder_id, decimal adc_category)
public subroutine of_set_menu (integer ai_tabpage)
public function integer of_open_wordfile_background ()
public function integer of_fileclear (long al_clauseid)
public function integer of_compare_clauses ()
public subroutine of_copy ()
public function integer of_open_word_file (string as_importfile)
public function integer of_create_word_file (long al_clause_id, ref string as_file_name, string as_importfile)
public function string of_getattribvaluelist (long al_clause_id)
public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle)
public function integer of_collapse_row (long al_clause_id, long al_row)
public subroutine of_collapse_all ()
public subroutine of_checkin ()
public subroutine of_refresh_clause (long al_clause_id)
public subroutine of_checkout ()
public function boolean of_ismodified ()
public function integer of_create_word_file (long al_clause_id, decimal adec_revision, ref string as_file_name, string as_importfile)
public function integer of_save (boolean ab_rev_ctrl)
public subroutine of_saveas ()
public subroutine of_print ()
public subroutine of_email ()
public function integer of_check_name (string as_clause_name)
public subroutine of_refreshfilterpicture ()
public subroutine of_refreshclauseattribute (string as_filter)
public subroutine of_refreshtreeviewnodeattribute (long al_clause_id)
public function long of_findclausenode (long al_parenthandle, long al_clause_id)
public subroutine of_refreshfieldlabel ()
public function integer of_update_document (integer ai_ctx_id[], integer ai_export_id[], long al_doc_id[], decimal adec_revision[], str_doc_info astr_docinfo[])
public subroutine of_export_single ()
public subroutine of_export (string as_flag)
public function integer of_check_track_viewing ()
public function string of_fulltext_search (string as_searchtext, string as_find_results)
public subroutine of_get_auto_retrieve ()
public function integer of_set_auto_retrieve (boolean abln_menu_retrieve)
public function integer of_batchupdatedoc ()
public function integer of_update_template (long al_template_id[], datetime adt_lastupdate[], integer ai_type, long al_clause_id[])
public function boolean of_checkmultiselect ()
end prototypes

event ue_setfocus_ole();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 21-03-2007 By: Ken.Guo
//$<reason> Fix Issue: Need set focus to Word Document when add a clause.
//Must POST this event.
IF tabpage_clause.ole_1.object.DocType = 0 THEN RETURN //added by alfee 05.21.2007
tabpage_clause.ole_1.object.ActiveDocument.ActiveWindow.SetFocus()
//---------------------------- APPEON END ----------------------------


end event

event ue_locate_clause(long al_clause_id);Long ll_find
ll_find = tabpage_browse.dw_browse.Find('ctx_acp_clause_id = ' + String(al_clause_id),1,tabpage_browse.dw_browse.RowCount())
If ll_Find > 0 Then
	tabpage_browse.dw_browse.SetRow(ll_find)
	tabpage_browse.dw_browse.ScrolltoRow(ll_find)
	tabpage_browse.dw_browse.SelectRow(0,False)
	tabpage_browse.dw_browse.SelectRow(ll_find,True)
End If

end event

event ue_auto_retrieve();//====================================================================
// Event: ue_auto_retrieve
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/18/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Boolean lb_auto

If isvalid(m_pfe_cst_clause_painter) Then
	If this.ib_autoretrieve Then
		lb_auto = False
	Else
		lb_auto = True
	End IF 
//	lb_auto = m_pfe_cst_clause_painter.m_file.m_autoretrieve.toolbaritemdown
	If this.of_set_auto_retrieve(lb_auto) > 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_autoretrieve,'toolbaritemdown', lb_auto)
	End If	
Else
	Return 
End If

end event

public subroutine of_create_clause_tree ();TreeViewItem ltvi_Item
TreeViewItem ltvi_node1,ltvi_node2,ltvi_node3
datastore lds_folder_parent

long 		ll_row,ll_rowcount,ll_clause_rowcount
Long 		ll_Root,ll_lev1,ll_lev2
long 		i,j,k
String 	ls_folder_name,ls_clause_name,ls_parent_filter,ls_approved_by,ls_date_approved,ls_new_sql
string 	ls_filter0 = '',ls_filter1,ls_search_text = " ctx_acp_clause_id In ("
long 		ll_ctx_acp_folder_id,ll_category,ll_ctx_acp_clause_id,ll_approval_status
Integer li_fulltext
string 	ls_fulltext, ls_find_results			//Added By Mark Lee 07/13/12

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
	//Begin - Added By Mark Lee 07/13/12
	ls_fulltext	=	 tabpage_browse.dw_filter.getitemstring(ll_row,'textsearch')
	ls_find_results	=	 tabpage_browse.dw_filter.getitemstring(ll_row,'textsearch_dddw')
	//End - Added By Mark Lee 07/13/12
Else
	ll_category = 0
End If
If isnull(ls_clause_name) Then ls_clause_name = ''
If isnull(ls_folder_name) Then ls_folder_name = ''
If isnull(ls_approved_by) Then ls_approved_by = ''
If isnull(ls_date_approved) Then ls_date_approved = ''
If isnull(ll_approval_status) Then ll_approval_status = 0
If isnull(ls_fulltext) Then ls_fulltext = ''	//Added By Mark Lee 07/16/12
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

//BEGIN---Modify by Scofield on 2010-01-29
if istr_ClauseFilter.Clause_Exp <> "" then
	if ls_new_sql <> "" then ls_new_sql += " and "
	ls_new_sql += " ctx_acp_clause_id in " + istr_ClauseFilter.Clause_Exp
	
	if ls_filter0 <> "" then ls_filter0 += " and "
	ls_filter0 += " ctx_acp_clause_id in " + istr_ClauseFilter.Clause_Exp
end if
//END---Modify by Scofield on 2010-01-29

//Added By Mark Lee 07/16/12 
//If trim(ls_clause_name) <> '' Then
If trim(ls_fulltext) <> '' Then
	//Added By Mark Lee 07/16/12
//	If gs_dbtype = "SQL" And gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' And ls_clause_name <> '' Then
	If gs_dbtype = "SQL" And gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' And ls_fulltext <> '' Then
		//Begin - Added By Mark Lee 07/16/12
		//Added By Ken.Guo 2011-01-14. Check the FT first.
//		Select  (
//		COLUMNPROPERTY (OBJECT_ID('ctx_acp_clause'),'clause_name','IsFulltextIndexed' ) 
//		+ 
//		COLUMNPROPERTY (OBJECT_ID('ctx_acp_clause'),'description','IsFulltextIndexed' ) 
//		+ 
//		COLUMNPROPERTY (OBJECT_ID('ctx_acp_clause'),'information_message','IsFulltextIndexed' ) 
//		+ 
//		COLUMNPROPERTY (OBJECT_ID('ctx_acp_clause_image'),'image_file','IsFulltextIndexed' ) 
//		) 
//		Into :li_fulltext From ids;		
		Select  (
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_clause'),'description','IsFulltextIndexed' ) 
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_clause'),'information_message','IsFulltextIndexed' ) 
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_clause_image'),'image_file','IsFulltextIndexed' ) 
		) 
		Into :li_fulltext From ids;	
		//End - Added By Mark Lee 07/16/12
		
		If isnull(li_fulltext) Then li_fulltext = 0
//		If li_fulltext <> 4 Then
		If li_fulltext <> 3 Then
			If Messagebox('Clause Filter',"The Full-Text Catalog hasn't been created for the clauses yet. Do you want to create it now?", Question!,YesNo!) = 1 Then
				IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice
				//---------Begin Modified by (Appeon)Eugene 06.29.2013 for V141 ISG-CLX--------				
				  /*
					n_cst_update_sql lnv_sql
					lnv_sql = Create n_cst_update_sql						
				  */
				n_cst_update_sql_clx lnv_sql
				lnv_sql = Create n_cst_update_sql_clx									 
				//---------End Modfiied ------------------------------------------------------------------
				lnv_sql.of_release_fulltext( )			
				Destroy lnv_sql
			End If
		End If
		
		ib_fulltextsearch = true 		//Full Text Search; added by alfee at 03.07.2007
		//Begin - Added By Mark Lee 07/13/12
//		ls_clause_name = '"' + ls_clause_name + '"'
//		ids_search_clause_text.retrieve(ls_clause_name)		
		ls_fulltext = of_fulltext_search( ls_fulltext, ls_find_results)
		ids_search_clause_text.retrieve(ls_fulltext)		
		//End - Added By Mark Lee 07/13/12
		
	End If

	If ls_filter0 <> '' Then
		//Added By Mark Lee 07/18/12  don't support ASA database
//		If gs_dbtype = "ASA" Then
//			ls_filter0 = ls_filter0 + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
//			ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
//		Else
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
				//Begin - Added By Mark Lee 07/18/12	moved it
//			Else
//				ls_filter0 = ls_filter0 + " And upper(clause_name like) " + "'%" + upper(ls_clause_name) + "%'"			
//				ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
				//End - Added By Mark Lee 07/18/12
			End If
//		End If
	Else
		//Added By Mark Lee 07/18/12  don't support ASA database
//		If gs_dbtype = "ASA" Then
//			ls_filter0 = "upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
//			ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
//		Else
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
				//Begin - Added By Mark Lee 07/18/12 moved it
//			Else
//				ls_filter0 = "upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"			
//				ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
				//End - Added By Mark Lee 07/18/12
			End If
//		End If
	End If		
End If

//Begin - Added By Mark Lee 07/18/12
If ls_clause_name <> '' Then
	if ls_filter0 <> "" then ls_filter0 += " and "
	ls_filter0 = "upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"			
	ls_new_sql = ls_new_sql + " And upper(clause_name) like " + "'%" + upper(ls_clause_name) + "%'"
End If
//End - Added By Mark Lee 07/18/12

If ls_approved_by <> '' Then //modified by alfee 08.30.2007
	If ls_filter0 <> '' Then 
		//ls_filter0 = ls_filter0 + " And approved_by = '" + ls_approved_by + "'"
		ls_filter0 = ls_filter0 + " And Upper(approved_by) = '" + Upper(ls_approved_by) + "'"		
	Else
		//ls_filter0 = "approved_by = '" + ls_approved_by + "'"
		ls_filter0 = "Upper(approved_by) = '" + Upper(ls_approved_by) + "'"		
	End If
	//ls_new_sql = ls_new_sql + " And approved_by = '" + ls_approved_by + "'"
	ls_new_sql = ls_new_sql + " And Upper(approved_by) = '" + Upper(ls_approved_by) + "'"
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

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-05-08 By: Wu ZhiJun
//$<reason> Fix a bug
tabpage_browse.dw_browse.SetSort("clause_name A")
tabpage_browse.dw_browse.Sort()
//--------------------------- APPEON END -----------------------------

gnv_appeondb.of_startqueue( )
lds_folder_parent.retrieve()
ids_folder.retrieve()
ids_clause.retrieve()
ids_template_clause.retrieve()
ids_clause_rely.retrieve()
tabpage_browse.dw_browse.retrieve()
ids_ctx_am_document_clause.retrieve()
gnv_data.of_retrieve( 'clause_attribute' ) //Added By Ken.Guo 2010-12-16.
inv_clause.of_retrieve_attribute_value( ) //added by gavins 20120723
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
	
	If isnull(ll_category) Then ll_category = 0
	If isnull(ll_ctx_acp_folder_id) Then ll_ctx_acp_folder_id = 0
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
		ltvi_Item.PictureIndex = 3
		ltvi_Item.SelectedPictureIndex = 4
		ll_lev2 = tabpage_browse.tv_clause.InsertItemLast(ll_lev1, ltvi_Item)
		
//		of_Create_Clause_Attribute(ll_ctx_acp_clause_id,ll_lev2)			//Added by Scofield on 2010-01-07  //modified by gavins 20120723
	Next
	of_create_clause_child_tree(ll_lev1,ll_ctx_acp_folder_id)
Next

tabpage_browse.tv_clause.ExpAndItem (ll_Root)
tabpage_browse.tv_clause.selectitem(ll_Root)	

Destroy lds_folder_parent

//Close clause comparison window - by Alfee 10.18.2007
if IsValid(inv_clause_comparison) then inv_clause_comparison.of_close_comparison_wizard('clause') 

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
	If isnull(ll_ctx_acp_folder_id) Then ll_ctx_acp_folder_id = 0
	If isnull(ll_category) Then ll_category = 0
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
		ltvi_Item.PictureIndex = 3
		ltvi_Item.SelectedPictureIndex = 4
		ll_handle_clause = tabpage_browse.tv_clause.InsertItemLast(ll_handle, ltvi_Item)
		
//		of_Create_Clause_Attribute(ll_ctx_acp_clause_id,ll_handle_clause)		//Added by Scofield on 2010-01-07 //modified by gavins 20120723
	Next
	
	If ll_find < ll_rowcount Then
		ll_find = ids_folder.find(ls_find,ll_find + 1,ll_rowcount)	
	Else
		ll_find = 0
	End If
	of_create_clause_child_tree(ll_handle,ll_ctx_acp_folder_id)
Loop

end subroutine

public function integer of_create_word_file (long al_clause_id, ref string as_file_name);//Overloaded Function by jervis 12.24.2009
return of_create_word_file(al_clause_id,as_file_name,"")

/*
Integer li_counter
Integer li_loops
Integer li_Writes,li_FileNum,li_Cnt
Long ll_start
Long ll_BlobLen,ll_CurrentPos
Long ll_getupdate
Long ll_data_length
String ls_file_name
String ls_lastupdate,ls_updatedate
Boolean lb_select
Blob lb_data
Blob lb_all_data
Blob lblb_Data

setpointer(HourGlass!)

tabpage_browse.dw_browse.accepttext()
If tabpage_browse.dw_browse.getrow() > 0 Then
	ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'), "mm/dd/yyyy hh:mm:ss" )	//Alfee 05.10.2007
	//ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'))	
End If
gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\")
ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + ".doc"

If is_types = 'Add' Then	
	inv_word_utility.of_new_word_document(tabpage_clause.ole_1, ls_file_name) //Alfee 09.22.2008
	/*	
	//---------Begin Modified by Alfee 09.06.2007----------------------------
	//<$Reason> Use a word format instead of text
	/*lb_all_data = blob('')
	li_FileNum = FileOpen(ls_file_name , StreamMode! ,Write!,Shared!, Replace!)
	If li_FileNum = -1 Then Return 0
	If FileWrite(li_FileNum, lb_all_data) = -1 Then
		Return 0
	End If
	FileClose(li_FileNum)*/
	tabpage_clause.ole_1.object.CreateNew("Word.Document")
	//----------Begin Modified by Alfee 10.31.2007------------------
	//<$Reason>to support Word 2007, save as word 2003 format, it's 
	//<$Reason>necessary that close and re-open the the document
	If FileExists(ls_file_name) Then FileDelete(ls_file_name)
	tabpage_clause.ole_1.object.ActiveDocument.SaveAs(ls_file_name, wdFormatDocument)
	tabpage_clause.ole_1.object.Close()
	//tabpage_clause.ole_1.object.SavetoLocal(ls_file_name, true)
	//----------End Modified ----------------------------------------
	//----------End Modified -------------------------------------------------
	*/
ElseIf is_types = 'Update' Then
	//Get if the document existed and updated
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
	
	//Gen the document if not existed or updated
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

		//--------Begin Added by Alfee 09.06.2007-----------------------
		//<$Reason>Use a word format instead of text
		If Len(lb_all_data) < 1 Then			
			inv_word_utility.of_new_word_document(tabpage_clause.ole_1, ls_file_name) //Alfee 09.22.2008			
			/*
			tabpage_clause.ole_1.object.CreateNew("Word.Document")
			//----------Begin Modified by Alfee 10.31.2007------------------
			//<$Reason>to support Word 2007, save as word 2003 format, it's 
			//<$Reason>necessary that close and re-open the the document
			If FileExists(ls_file_name) Then FileDelete(ls_file_name)
			tabpage_clause.ole_1.object.ActiveDocument.SaveAs(ls_file_name, wdFormatDocument)
			tabpage_clause.ole_1.object.Close()
			//tabpage_clause.ole_1.object.SavetoLocal(ls_file_name, true)
			//----------End Modified ----------------------------------------	
			*/			
			as_file_name = ls_file_name
			Return 1
		End If
		//---------End Added ------------------------------------------
		
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

end function

public function integer of_deleterow ();long ll_mes

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 0
End If

If is_type = 'F' Then
   ll_mes = messagebox('Delete Folder', 'Are you sure you want to delete this folder?',Question!,YesNo!,2)
   If ll_mes = 2 Then Return 0
ElseIf is_type = 'C' Then
   ll_mes = messagebox('Delete Clause', 'Are you sure you want to delete this clause?',Question!,YesNo!,2)
   If ll_mes = 2 Then Return 0
Else
	Return 0
End If

string ls_clause_rely_filter,ls_find,ls_data
long ll_template_clause_rowcount,ll_clause_rely_rowcount
long i,ll_find,ll_Handle
long ll_ctx_acp_clause_id,ll_ctx_acp_folder_id

//----------Begin Added by Alfee 08.22.2007-----------------
gnv_appeondb.of_startqueue( )
ids_template_clause.Retrieve()	
ids_ctx_am_document_clause.retrieve()
gnv_appeondb.of_commitqueue( )
//----------End Added --------------------

ids_folder.setfilter('')
ids_folder.filter()
ids_clause.setfilter('')
ids_clause.filter()
ids_template_clause.setfilter('')
ids_template_clause.filter()
ids_clause_rely.setfilter('')
ids_clause_rely.filter()
ids_ctx_am_document_clause.setfilter('')
ids_ctx_am_document_clause.filter()

ll_template_clause_rowcount = ids_template_clause.rowcount()
If isnull(il_handle1) Then il_handle1 = 0
ll_ctx_acp_folder_id = il_ctx_acp_folder_id
ls_data = is_data
If is_type = 'F' Then
	ids_next_handle.reset()
	il_first = 1
	If of_delete_child(il_handle) = 0 Then Return 0
	
	ls_find = "ctx_acp_folder_id = " + string(il_ctx_acp_folder_id)
	ll_find = ids_folder.find(ls_find,1,ids_folder.rowcount())
	If ll_find > 0 Then
		ids_folder.deleterow(ll_find)
	End If	
ElseIf is_type = 'C' Then
	If il_handle1 <> 0 Then
		If of_delete(il_handle) = 0 Then Return 0	
	Else
		ls_find = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
		ll_find = ids_template_clause.find(ls_find,1,ids_template_clause.rowcount())
		If ll_find > 0 Then
			//messagebox('Delete Clause','The clause is used in Agreement Template, Cannot delete the clause!')
 			messagebox('Delete Clause','Cannot delete the clause, because the clause is used in Agreement Template!')
			Return 0
		End If
		ls_find = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
		ll_find = ids_ctx_am_document_clause.find(ls_find,1,ids_ctx_am_document_clause.rowcount())
		If ll_find > 0 Then
			//messagebox('Delete Clause','The clause is used in Agreement Document, Cannot delete the clause!')
 			messagebox('Delete Clause','Cannot delete the clause, because the clause is used in Agreement Template!')
			Return 0
		End If
		ls_clause_rely_filter = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
		ids_clause_rely.setfilter(ls_clause_rely_filter)
		ids_clause_rely.filter()
		ll_clause_rely_rowcount = ids_clause_rely.rowcount()
		For i = ll_clause_rely_rowcount To 1 Step -1
			ids_clause_rely.deleterow(i)
		Next
		
		ls_clause_rely_filter = "ctx_acp_clause_rely_id = " + string(il_ctx_acp_clause_id)
		ids_clause_rely.setfilter(ls_clause_rely_filter)
		ids_clause_rely.filter()
		ll_clause_rely_rowcount = ids_clause_rely.rowcount()
		For i = ll_clause_rely_rowcount To 1 Step -1
			ids_clause_rely.deleterow(i)
		Next
		
		ls_find = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
		ll_find = ids_clause.find(ls_find,1,ids_clause.rowcount())
		If ll_find > 0 Then
			ids_clause.deleterow(ll_find)
		End If
		
		//Begin - Added By Ken.Guo 2010-02-03.
		gnv_appeondb.of_startqueue( )
		DELETE FROM ctx_acp_clause_attr_value WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id;
		DELETE FROM ctx_acp_clause_attribute WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id; 
		DELETE FROM ctx_acp_clause_audit WHERE clause_id = :il_ctx_acp_clause_id; 
		DELETE FROM ctx_acp_clause_image WHERE clause_id = :il_ctx_acp_clause_id; 		
		gnv_appeondb.of_commitqueue( )
		//End - Added By Ken.Guo 2010-02-03.	
		
		tabpage_browse.dw_browse.deleterow(0)
	End If
End If

gnv_appeondb.of_startqueue( )
ids_clause_rely.Update()
ids_clause.Update()
ids_folder.Update()
//tabpage_browse.dw_browse.Update() //Commented By Ken.Guo 2010-01-11
gnv_appeondb.of_commitqueue( )

If il_handle <> 0 Or il_handle1 <> 0 Then
	of_create_clause_tree()
	ll_Handle = of_getHandle(is_data_delete,1)
	If ll_Handle > 0 Then
		tabpage_browse.tv_clause.Event clicked(ll_Handle)
		tabpage_browse.tv_clause.selectitem(ll_Handle)	
	Else
		If isvalid(m_pfe_cst_clause_painter) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
		End If
	End If
Else
	If is_click = 'dw' Then
		ll_Handle = of_getHandle(ls_data,1)
		tabpage_browse.tv_clause.deleteitem(ll_Handle)	
		is_data_delete = string(ll_ctx_acp_folder_id) + '-' + 'F' + '+' + string(il_category)
		ll_Handle = of_getHandle(is_data_delete,1)
		If ll_Handle > 0 Then
			tabpage_browse.tv_clause.Event clicked(ll_Handle)
			tabpage_browse.tv_clause.selectitem(ll_Handle)	
		Else
			If isvalid(m_pfe_cst_clause_painter) Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
			End If
		End If		
	End If
End If

//----Begin added by Alfee 05.21.2007----------------------------
IF w_clause_painter.tab_1.SelectedTab = 2 THEN 
	tabpage_clause.ole_1.object.Close()		
	w_clause_painter.tab_1.SelectTab(1)
END IF
//added by alfee at 08.24.2007	
tabpage_browse.dw_browse.setredraw(false)
if tabpage_browse.dw_browse.RowCount() > 0 then
	tabpage_browse.dw_browse.SelectRow(0, false) 
	tabpage_browse.dw_browse.ScrollTorow( 1)
	tabpage_browse.dw_browse.SelectRow(1, True) 
end if
tabpage_browse.dw_browse.setredraw(true)
//----End added----------------------------------------------------	

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
	ls_find = "ctx_acp_clause_id = " + string(ll_id)
	ll_find = ids_ctx_am_document_clause.find(ls_find,1,ids_ctx_am_document_clause.rowcount())
	If ll_find > 0 Then
		If is_type = 'C' Then
			//messagebox('Delete Clause','The clause is used in Agreement Document, Cannot delete the clause!')
 			messagebox('Delete Clause','Cannot delete the clause, because the clause is used in Agreement Template!')
		Else	
			//messagebox('Delete Folder','Some clauses is used in Agreement Document, Cannot delete the folder!')
 			messagebox('Delete Folder','Cannot delete the Folder, because some clauses are used in Agreement Template!')
		End If
		Return 0
	End If
	
	gnv_appeondb.of_startqueue( )
		DELETE FROM ctx_acp_clause_attr_value WHERE ctx_acp_clause_id = :ll_id;
		DELETE FROM ctx_acp_clause_attribute WHERE ctx_acp_clause_id = :ll_id; 
		DELETE FROM ctx_acp_clause_audit WHERE clause_id = :ll_id; 
		DELETE FROM ctx_acp_clause_image WHERE clause_id = :ll_id; 
	gnv_appeondb.of_commitqueue( )
	
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
	
//	ls_find = "ctx_acp_clause_id = " + string(il_ctx_acp_clause_id)
//	ll_find = tabpage_browse.dw_browse.find(ls_find,1,tabpage_browse.dw_browse.rowcount())
//	If ll_find > 0 then
//		tabpage_browse.dw_browse.deleterow(0)
//	End If
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
	tabpage_clause.ole_1.object.Close()
Catch (RunTimeError rte)
	messagebox('Error', 'The Office Viewer Active X Control has failed.')
End Try

//Close clause comparison window - Added by Alfee 10.18.2007
IF IsValid(inv_clause_comparison) THEN
	inv_clause_comparison.of_close_comparison('clause')
END IF

Destroy ids_template_clause
Destroy ids_clause
Destroy ids_folder
Destroy ids_clause_rely
Destroy ids_next_handle
Destroy ids_search_clause_text
Destroy ids_ctx_am_document_clause
Destroy ids_AttriValue						//Added by Scofield on 2010-01-07

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
	is_types = 'Add'
	openwithparm(w_add_clause,istr_folder)
End If

end subroutine

public subroutine of_properties ();integer li_position,li_return
long ll_ctx_acp_folder_id,ll_category,ll_Handle,ll_find,ll_ctx_acp_clause_id
long ll_folder[]
string ls_data
String ls_type 

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 
End If

ls_type = is_type //Added By Ken.Guo 2010-01-29.
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
	li_return = message.doubleparm	
ElseIf is_type = 'C' Then
	If il_ctx_acp_clause_id = 0 Then Return
	istr_folder.as_type = 'Update'
	istr_folder.al_category = il_category	
	istr_folder.al_clause_id = il_ctx_acp_clause_id
	openwithparm(w_add_clause,istr_folder)
	li_return = message.doubleparm
	
	of_RefreshClauseAttribute("ctx_acp_clause_id = " + String(il_ctx_acp_clause_id))		//Added by Scofield on 2010-01-19
	of_RefreshTreeViewNodeAttribute(il_ctx_acp_clause_id)											//Added by Scofield on 2010-01-19
End If

If li_return = 0 Then Return //Added by Alfee 05.24.2007

If is_type = 'F' Or is_type = 'C' Then
	ll_ctx_acp_clause_id = il_ctx_acp_clause_id 
	//ll_ctx_acp_clause_id = istr_folder.al_clause_id
	
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
	If li_return = 1 Then
		gnv_appeondb.of_startqueue( )
		ids_folder.retrieve()
		ids_clause.retrieve()
		tabpage_browse.dw_browse.retrieve()
		gnv_appeondb.of_commitqueue( )
	End If
	/*
	ll_find = tabpage_browse.dw_browse.find("ctx_acp_clause_id = " + string(ll_ctx_acp_clause_id),1,tabpage_browse.dw_browse.rowcount())
	If ll_find > 0 Then
		tabpage_browse.dw_browse.scrolltorow(ll_find)
		tabpage_browse.dw_browse.selectrow(0,false)
		tabpage_browse.dw_browse.selectrow(ll_find,true)
	End If
	*/
	This.event Post ue_locate_clause(ll_ctx_acp_clause_id)
	
	ll_Handle = w_clause_painter.tab_1.of_getHandle(ls_data,1)
	w_clause_painter.tab_1.tabpage_browse.tv_clause.selectitem(ll_Handle)	
	
	//Added By Ken.Guo 2010-01-29.
 	is_type = ls_type
	w_clause_painter.tab_1.Post of_set_menu(w_clause_painter.tab_1.Selectedtab)
End If

end subroutine

public subroutine of_set_word_view_size ();oleobject lole_size

If tabpage_clause.ole_1.object.DocType > 0 Then
	lole_size = Create oleobject
	lole_size = tabpage_clause.ole_1.object.activedocument
	lole_size.ActiveWindow.ActivePane.View.Zoom.Percentage = 100
	//--------Added by alfee 04.16.2007-for numbering----
	lole_size.ActiveWindow.View.ShowFieldCodes = False
	//--------End Added ---------------------------------
	Destroy lole_size
End If

 


end subroutine

public function integer of_open_word_file ();//Overloaded Function by jervis 12.24.2009
return of_open_word_file("")
/*
string ls_file_name
long ll_new_clause_id
If tabpage_browse.dw_browse.rowcount() > 0 Then
	ll_new_clause_id = tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'ctx_acp_clause_id')
	If ll_new_clause_id <> il_old_clause_id Then
		il_ctx_acp_clause_id = ll_new_clause_id
		il_old_clause_id = ll_new_clause_id
	   If is_types = '' Then is_types = 'Update'
	Else
		Return 1
	End If
Else
	//-------Begin Added by Alfee 08.22.2007---------
	tabpage_clause.ole_1.object.Close() //05.05.2007
	il_ctx_acp_clause_id = -1
	il_old_clause_id = -1
	Return 0
	//-------End Added ------------------------------
End If
If of_create_word_file(il_ctx_acp_clause_id,ls_file_name) = 1 Then
	openwithparm( w_appeon_gifofwait, "Opening selected document..." )
	Try 
		tabpage_clause.ole_1.object.OpenLocalFile(ls_file_name , false)
		of_set_word_view_size()
		tabpage_clause.ole_1.setfocus()
	Catch (RunTimeError rter)
		If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		tabpage_clause.ole_1.object.close() //Alfee 09.23.2008
		messagebox('Error', 'The Office Viewer Active X Control has failed.' )
		Return 0
	End Try
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
	End If
	If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
Else
	Return 0
End If		

Return 1
*/
end function

public subroutine of_rely ();If isnull(il_ctx_acp_clause_id) Or il_ctx_acp_clause_id = 0 Then Return 

istr_folder.as_type = 'Update'
istr_folder.al_folder_id = il_ctx_acp_clause_id
istr_folder.al_category = il_category	
openwithparm(w_clause_rely,istr_folder)
ids_clause_rely.retrieve()


end subroutine

public function integer of_save ();//Modified By Ken.Guo 2010-01-11
Return of_save(False)

/*
integer li_FileNum, loops, i
long ll_Handle,ll_num,ll_mes, ll_cnt
long  ll_flen,ll_ctx_acp_clause_id,ll_ctx_acp_folder_id,ll_category,ll_approval_status
string ls_data,ls_clause_name,ls_updatedate,ls_file_name,ls_file_name1
datetime ldt_updatedate
boolean lb_save = True
blob b, tot_b

treeviewitem ltvi_item
OLEobject  obj

obj = Create oleobject
Try 
	IF tabpage_clause.ole_1.object.DocType = 0 THEN RETURN 0 //added by alfee 05.21.2007
	obj = tabpage_clause.ole_1.object.ActiveDocument
Catch (RunTimeError rte)
	messagebox('Error', 'The Office Viewer Active X Control has failed.')
	Destroy obj //added by alfee 04.27.2007
End Try

//--------Begin Modified by Alfee 05.10.2007----------------------
//ldt_updatedate = datetime(today())
//ls_updatedate = string(ldt_updatedate)
ldt_updatedate = DateTime(today(), now()) 
ls_updatedate = string(ldt_updatedate, "mm/dd/yyyy hh:mm:ss")
//--------End Modified---------------------------------------------

ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(il_ctx_acp_clause_id) + ".doc"
ls_file_name1 = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(il_ctx_acp_clause_id) + "_1.doc"
If obj.saved = False Then
	
	//Unprotect the document if necessary - Alfee 03.10.2008
	n_cst_word_utility lnv_word
	lnv_word = Create n_cst_word_utility
	lnv_word.of_unprotect_doc(obj) 
	Destroy lnv_word
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007-02-26 By: Rodger Wu
	//$<reason> New requirement
	//$<reason> Trim spaces or line feed at the beginning or end of clauses.
	tabpage_clause.ole_1.setredraw( False )
	iw_clause_painter.of_ltrimword()
	iw_clause_painter.of_rtrimword()
	tabpage_clause.ole_1.setredraw( True )
	//---------------------------- APPEON END ----------------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> By Alfee at 05.30.2007
	//$<reason> Check user defined bookmarks, which shouldn't be conflicted with the system defined. 
	ll_cnt = obj.bookmarks.count
	For i = 1 to ll_cnt
		//if Lower(Left(obj.content.bookmarks.Item[i].Name, 7)) = 'clause_'  Then Jervis 06.08.2009
		if Lower(Left(obj.bookmarks.Item[i].Name, 7)) = 'clause_'  Then
			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)			
			tabpage_clause.ole_1.setredraw( True )
			Destroy obj
			messagebox("Alert","Clause file cannot contain bookmark(s) named with the prefix 'clause_'. Please modify the bookmark name",Exclamation!)					
			return -1
		end if			
	Next
	//---------------------------- APPEON END ----------------------------
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> By Alfee at 03.09.2007
	//$<Reason>New requirement, make sure the document won't have revisions
	Long ll_clause_approved
	ll_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Approval Status' and code = 'Approved'"))
	If tabpage_browse.dw_browse.GetItemNumber(tabpage_browse.dw_browse.GetRow(),"approval_status") = ll_clause_approved Then
		If obj.Revisions.Count > 0 Then
			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
			//MessageBox("Alert","The approved file can't include any revisons and not saved! Please approve or reject the changes with the reviewing menu items first.",Exclamation!)
 			MessageBox("Alert","The approved file can't include any revisons that are not saved! Please approve or reject the changes with the reviewing menu items first.",Exclamation!)
			tabpage_clause.ole_1.setredraw( True )
			Destroy obj
			Return -1
		End If
	End If
	//---------------------------- APPEON END ----------------------------
	openwithparm(w_appeon_gifofwait, "Saving clause to DB..." )
	lb_save = False
	Try 
		tabpage_clause.ole_1.object.saveToLocal(ls_file_name , True)
	Catch (RunTimeError rter)
		messagebox('Error', 'The Office Viewer Active X Control has failed.')
		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		Destroy obj //added by alfee 04.27.2007
	End Try
	
	FileCopy (ls_file_name,ls_file_name1,False)	
	li_FileNum = FileOpen(ls_file_name1,StreamMode!,read!,LockWrite!)
	ll_flen = FileLength(ls_file_name1)
	
	If ll_flen > 32765 Then
		If Mod(ll_flen, 32765) = 0 Then
			loops = ll_flen/32765
		Else
			loops = (ll_flen/32765) + 1
		End If
	Else
		loops = 1
	End If
	
	For i = 1 To loops
		FileRead(li_FileNum,b)
		tot_b = tot_b + b
	Next
	FileClose(li_FileNum)
	FileDelete(ls_file_name1)
	
	UPDATEBLOB ctx_acp_clause SET image_file = :tot_b WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id;
	gnv_appeondb.of_startqueue( )	//
	UPDATE ctx_acp_clause SET modify_date = :ldt_updatedate WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id;
	ids_template_clause.Retrieve()	//Alfee 08.22.2007	
	gnv_appeondb.of_commitqueue( )
  
	gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(il_ctx_acp_clause_id), regstring!, ls_updatedate)	
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End If

inv_word_utility.of_update_reqmnt_field(tabpage_clause.ole_1.object, il_ctx_acp_clause_id,'C') //Added By Ken.Guo 2009-07-13.

If is_types = 'Update' Then
	If lb_save = False Then
		ids_template_clause.setfilter('')
		ids_template_clause.filter()
		ll_num = ids_template_clause.find("ctx_acp_clause_id = " + string(il_ctx_acp_clause_id),1,ids_template_clause.rowcount())
		If ll_num > 0 Then
			ll_mes = messagebox('Updating existing templates','Would you like to update all the Templates that refer to this clause?',question!,YesNo!)
			If ll_mes = 1 Then
				openwithparm(w_clause_template,il_ctx_acp_clause_id)
			End If
		End If
		lb_save = True
	End If
End If
Destroy obj
//If isvalid(m_pfe_cst_clause_painter) Then
//	m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//End If
is_types = 'Update'
Return 1
*/
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

public subroutine of_set_menu (integer ai_tabpage);//////////////////////////////////////////////////////////////////////
// $<function>u_tab_agreement_clause_painterof_set_menu()
// $<arguments>
//		value	integer	ai_tabpage		
// $<returns> integer
// $<description>Cut&Paste script from this.selectionchanged event.
// $<description>Because w_clause_painter window will call it.
//////////////////////////////////////////////////////////////////////
// $<add> 23/04/2007 by Ken.Guo
// $<Modify> 2010-01-13 by Ken.Guo. Re-write the script.for clause version control.
//////////////////////////////////////////////////////////////////////
//m_pfe_cst_clause_painter lm_pfe_cst_clause_painter

If Not isvalid(m_pfe_cst_clause_painter) Then Return 

gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325
gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325


gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options,'enabled', True)
gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0,'enabled', True)

//For tabpage1 and tabpage2
If w_mdi.of_security_access(6963) = 0 Then //Save As
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0.m_saveas,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0.m_saveas,'enabled', True)
End If
If w_mdi.of_security_access(6964) = 0 Then //Check In
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkin,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkin,'enabled', True)
	m_pfe_cst_clause_painter.m_file.m_check.m_checkin.visible = True	
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkin,'toolbaritemvisible', True)			
End If
If w_mdi.of_security_access(6965) = 0 Then //Check Out
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_revision,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'enabled', True)
	m_pfe_cst_clause_painter.m_file.m_check.m_checkout.visible = True	
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'toolbaritemvisible', True)			
End If
If w_mdi.of_security_access(6969) = 0 Then //Properties
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', True)
End If
If w_mdi.of_security_access(6970) = 0 Then //Rules
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
End If
If w_mdi.of_security_access(6971) = 0 Then //Email
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0.m_email,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0.m_email,'enabled', True)
End If
If w_mdi.of_security_access(6972) = 0 Then //Print
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0.m_print0,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0.m_print0,'enabled', True)
End If

If w_mdi.of_security_access(6977) = 0 Then //Version Settings
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_versionsettings,'enabled', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_versionsettings,'enabled', True)
End If

//Set Right Toolbar ICO
If w_mdi.of_security_access(540) = 0 Then
	//---------Begin Modified by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
	//gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_system.m_painters.m_rolepainter,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_system.m_painters.m_security.m_rolepainter,'enabled', False)
	//---------End Modfiied ------------------------------------------------------
Else
	//---------Begin Modified by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
	//gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_system.m_painters.m_rolepainter,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_system.m_painters.m_security.m_rolepainter,'enabled', True)
	//---------End Modfiied ------------------------------------------------------
End If


If ai_tabpage = 1 Then
	//Hide tabpage2's toolbars
	m_pfe_cst_clause_painter.m_file.m_save.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'toolbaritemvisible', False)
	m_pfe_cst_clause_painter.m_file.m_options.m_autonum0.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_autonum0,'toolbaritemvisible', False)
	m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield,'toolbaritemvisible', False)
	m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt,'toolbaritemvisible', False)
	m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata,'toolbaritemvisible', False)
	
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_select,'enabled', True)
	m_pfe_cst_clause_painter.m_file.m_select.visible = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_select,'toolbaritemvisible', True)
	
	//Begin - Added By Mark Lee 07/18/12
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_autoretrieve,'enabled', True)
//	m_pfe_cst_clause_painter.m_file.m_autoretrieve.visible = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_autoretrieve,'toolbaritemvisible', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_autoretrieve,'toolbaritemdown', ib_autoretrieve)
	//End - Added By Mark Lee 07/18/12
	
	//Show toolbar with rights.
	If w_mdi.of_security_access(6958) = 0 Then //Add Clause
		m_pfe_cst_clause_painter.m_file.m_addclause.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_addclause.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'toolbaritemvisible', True)
	End If	
	
	//BEGIN---Modify by Scofield on 2010-05-19
	long	ll_PRight,ll_CRight
	
	ll_PRight = w_mdi.of_security_access(6800)
	ll_CRight = w_mdi.of_security_access(6959)
	
	if ll_PRight < 1 or ll_CRight < 1 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', False)
		m_pfe_cst_clause_painter.m_file.m_addfolder.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'toolbaritemvisible', False)
	else
		if ll_PRight = 1 then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', False)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', True)
		end if
		m_pfe_cst_clause_painter.m_file.m_addfolder.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'toolbaritemvisible', True)
	end if
	//END---Modify by Scofield on 2010-05-19
	
	If w_mdi.of_security_access(6960) = 0 Then //Copy Clause
		m_pfe_cst_clause_painter.m_file.m_copyclause.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_copyclause.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'toolbaritemvisible', True)
	End If
	If w_mdi.of_security_access(6961) = 0 Then //Delete
		m_pfe_cst_clause_painter.m_edit.m_delete1.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', True)
		m_pfe_cst_clause_painter.m_edit.m_delete1.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'toolbaritemvisible', True)
	End If	
	If w_mdi.of_security_access(6975) = 0 Then //Compare
		m_pfe_cst_clause_painter.m_file.m_options.m_compare0.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_compare0,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_options.m_compare0.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_compare0,'toolbaritemvisible', True)
	End If
	If w_mdi.of_security_access(6976) = 0 Then //Analysis
		m_pfe_cst_clause_painter.m_file.m_options.m_analysis0.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_analysis0,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_analysis0,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_options.m_analysis0.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_analysis0,'toolbaritemvisible', True)
	End If	
	
	//Added By Ken.Guo 07/30/2012
	If w_mdi.of_security_access(6981) = 0 Then //Batch Update
		m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc,'toolbaritemvisible', True)
	End If			
	
	
ElseIf ai_tabpage = 2 Then
	//Hide Tabpage1's toolbar
	m_pfe_cst_clause_painter.m_file.m_addclause.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'toolbaritemvisible', False)
	//BEGIN---Modify by Scofield on 2010-05-19
	m_pfe_cst_clause_painter.m_file.m_addfolder.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'toolbaritemvisible', False)
	//END---Modify by Scofield on 2010-05-19
	m_pfe_cst_clause_painter.m_file.m_copyclause.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'toolbaritemvisible', False)	
	m_pfe_cst_clause_painter.m_edit.m_delete1.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'toolbaritemvisible', False)	
	m_pfe_cst_clause_painter.m_file.m_select.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_select,'toolbaritemvisible', False)
	m_pfe_cst_clause_painter.m_file.m_options.m_compare0.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_compare0,'toolbaritemvisible', False)
	m_pfe_cst_clause_painter.m_file.m_options.m_analysis0.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_analysis0,'toolbaritemvisible', False)	
	
	//Begin - Added By Mark Lee 07/18/12
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_autoretrieve,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_autoretrieve,'toolbaritemvisible', False)
	//End - Added By Mark Lee 07/18/12
	
	//Added By Ken.Guo 07/30/2012
	m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc.visible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc,'toolbaritemvisible', False)

	
	//Show Toolbar with rights
	If w_mdi.of_security_access(6962) = 0 Then //Save
		m_pfe_cst_clause_painter.m_file.m_save.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_save.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'toolbaritemvisible', True)
	End If	
	If w_mdi.of_security_access(6966) = 0 Then //Insert Field
		m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield,'toolbaritemvisible', True)
	End If		
	If w_mdi.of_security_access(6967) = 0 Then //Insert Reqmnt
		m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt,'toolbaritemvisible', True)
	End If		
	If w_mdi.of_security_access(6968) = 0 Then //Merge Data
		m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata,'toolbaritemvisible', True)
	End If
	If w_mdi.of_security_access(6973) = 0 Then //Auto Num
		m_pfe_cst_clause_painter.m_file.m_options.m_autonum0.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_autonum0,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_autonum0,'enabled', True)
		m_pfe_cst_clause_painter.m_file.m_options.m_autonum0.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_autonum0,'toolbaritemvisible', True)
	End If	

End If

//Set Menu for history document and checked out document 
Long ll_row 
String ls_checkout_status
ll_row = tabpage_browse.dw_browse.getrow()
IF ll_row > 0 Then
	//For check out/in record
	If tabpage_browse.dw_browse.GetItemString(ll_row,'checkout_status') = '0' Then
		m_pfe_cst_clause_painter.m_file.m_check.m_checkin.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkin,'toolbaritemvisible', False)
	Else
		m_pfe_cst_clause_painter.m_file.m_check.m_checkout.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'toolbaritemvisible', False)		
	End If

	//Revision ICO replace checkout ICO
	If tabpage_browse.dw_browse.GetItemString(ll_row,'revision_control') = '0' Then
		m_pfe_cst_clause_painter.m_file.m_check.m_checkout.visible = False	
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'toolbaritemvisible', False)	
		m_pfe_cst_clause_painter.m_file.m_check.m_revision.visible = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_revision,'toolbaritemvisible', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_revision,'enabled', m_pfe_cst_clause_painter.m_file.m_check.m_checkout.enabled)
	Else
		m_pfe_cst_clause_painter.m_file.m_check.m_revision.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_revision,'toolbaritemvisible', False)		
	End If
	
	//History record. or checked out record
	If tabpage_browse.dw_browse.GetItemNumber(ll_row,'level') = 2 or tabpage_browse.dw_browse.GetItemString(ll_row,'checkout_status') <> '0' Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield,'enabled', False)	
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt,'enabled', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_insert,'enabled', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_autonum0,'enabled', False)		
		If tabpage_browse.dw_browse.GetItemNumber(ll_row,'level') = 2 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkin,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_revision,'enabled', False)			
			m_pfe_cst_clause_painter.m_file.m_check.m_checkin.visible = False
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkin,'toolbaritemvisible', False)
			m_pfe_cst_clause_painter.m_file.m_check.m_checkout.visible = False
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'toolbaritemvisible', False)	
			m_pfe_cst_clause_painter.m_file.m_check.m_revision.visible = False
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_revision,'toolbaritemvisible', False)				
		End If
	End If
End If


//If Main Access is Read Only or No Access or not data in dw_browse. Must on last run.
If w_mdi.of_security_access(6800) < 2 or tabpage_browse.dw_browse.getrow() < 1 Then 
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertfield,'enabled', False)	
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_insertreqmnt,'enabled', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_mailmerge.m_mergedata,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
		if w_mdi.of_security_access(6800) < 2  then	//Allow to delete folder when not data in dw_browse
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
		end if
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_insert,'enabled', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkin,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_checkout,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_check.m_revision,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_autonum0,'enabled', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options.m_versionsettings,'enabled', False)
		If tabpage_browse.dw_browse.getrow() < 1 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_options,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_output0,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
			If  w_mdi.of_security_access(6800) = 2 and  w_mdi.of_security_access(6958) = 1 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'ToolbarItemVisible', True)
				m_pfe_cst_clause_painter.m_file.m_addclause.Visible = True
			End If
			
		End If
End If

Return



end subroutine

public function integer of_open_wordfile_background ();string ls_file_name
long ll_new_clause_id
If tabpage_browse.dw_browse.rowcount() > 0 Then
	ll_new_clause_id = tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'ctx_acp_clause_id')
	If ll_new_clause_id <> il_old_clause_id Then
		il_ctx_acp_clause_id = ll_new_clause_id
		il_old_clause_id = ll_new_clause_id
	   If is_types = '' Then is_types = 'Update'
	Else
		Return 1
	End If
Else
	Return 0
End If
If of_create_word_file(il_ctx_acp_clause_id,ls_file_name) = 1 Then
	//openwithparm( w_appeon_gifofwait, "Opening selected document..." )
	Try 
		tabpage_clause.ole_1.object.OpenLocalFile(ls_file_name , false)
		gnv_word_utility.of_modify_word_property( tabpage_clause.ole_1.object.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		of_set_word_view_size()
		//tabpage_clause.ole_1.setfocus()
	Catch (RunTimeError rter)
		If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		tabpage_clause.ole_1.object.close() //Alfee 09.23.2008
		messagebox('Error', 'The Office Viewer Active X Control has failed.')
		//Return 0
		Return -1
	End Try
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
	End If
	If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
Else
	Return 0
End If		

Return 1

end function

public function integer of_fileclear (long al_clauseid);//////////////////////////////////////////////////////////////////////
// $<function>of_fileclear()
// $<arguments>
//		long	al_clauseid		
// $<returns> integer
// $<description>delete file and clear the registry
//////////////////////////////////////////////////////////////////////
// $<add> 05.21.2007 by Alfee
//////////////////////////////////////////////////////////////////////
string ls_filename
Decimal{1} ldev_revision

if isnull(al_clauseid) then return -1

ldev_revision = inv_clause.of_get_revision(al_clauseid)
ls_filename = inv_clause.of_generate_name(al_clauseid)
//ls_filename=gs_dir_path + gs_DefDirName + "\Agreement\clause_"+ string(al_clauseid) + ".doc"

//delete the local file
if fileexists(ls_filename) then
	filedelete(ls_filename)
end if
//Modified By Mark Lee 04/18/12
//Clear registry of this file
//gnv_appeondll.of_registrydelete("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(al_clauseid) + '.' + String(ldev_revision))
gnv_appeondll.of_registrydelete("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", 'clause_' + string(al_clauseid) + '.' + String(ldev_revision))

return 1
end function

public function integer of_compare_clauses ();//Added by Alfee 10.18.2007

IF Not IsValid(inv_clause_comparison) THEN RETURN -1
tabpage_browse.st_tip.visible = True
inv_clause_comparison.of_start_compare_clauses( iw_clause_painter, tabpage_browse.dw_browse, 'clause')
 
RETURN 1
end function

public subroutine of_copy ();//Add by jervis 10.10.2009 -- Copy Clause

Integer li_position,li_return
Long ll_ctx_acp_folder_id,ll_category,ll_Handle,ll_find,ll_ctx_acp_clause_id
Long ll_folder[]
String ls_data

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 
End If


If is_type = 'C' Then
	If il_ctx_acp_clause_id = 0 Then Return
	istr_folder.as_type = 'Copy'
	istr_folder.al_category = il_category
	istr_folder.al_clause_id = il_ctx_acp_clause_id
	istr_folder.adec_revision = idec_revision //Added By Ken.Guo 2010-01-11.
	OpenWithParm(w_add_clause,istr_folder)
	li_return = Message.DoubleParm
	
	of_RefreshClauseAttribute("ctx_acp_clause_id = " + String(il_ctx_acp_clause_id))		//Added by Scofield on 2010-01-19
	of_RefreshTreeViewNodeAttribute(il_ctx_acp_clause_id)											//Added by Scofield on 2010-01-19
End If

If li_return = 0 Then Return //Added by Alfee 05.24.2007

If is_type = 'C' Then
	ll_ctx_acp_clause_id = il_ctx_acp_clause_id
	If is_click = 'dw' Then
		If tabpage_browse.dw_browse.RowCount() = 1 Then
			If il_ctx_acp_clause_id <> 0 Then
				ls_data = String(il_ctx_acp_clause_id) + '-' + 'C'
				tabpage_browse.dw_browse.SetFilter("ctx_acp_clause_id = " + String(il_ctx_acp_clause_id))
				tabpage_browse.dw_browse.Filter()
			End If
		Else
			il_ctx_acp_folder_id = tabpage_browse.dw_browse.GetItemNumber(tabpage_browse.dw_browse.GetRow(),'ctx_acp_folder_id')
			ls_data = String(il_ctx_acp_folder_id) + '-' + 'F' + '+' + String(il_category)
			tabpage_browse.dw_browse.SetFilter("ctx_acp_folder_id = " + String(il_ctx_acp_folder_id))
			tabpage_browse.dw_browse.Filter()
		End If
	Else
		ls_data = String(il_ctx_acp_clause_id) + '-' + 'C'
		tabpage_browse.dw_browse.SetFilter("ctx_acp_clause_id = " + String(il_ctx_acp_clause_id))
		tabpage_browse.dw_browse.Filter()
	End If
	
	If li_return = 1 Then
		gnv_appeondb.of_startqueue( )
		ids_folder.Retrieve()
		ids_clause.Retrieve()
		tabpage_browse.dw_browse.Retrieve()
		gnv_appeondb.of_commitqueue( )
	End If
	ll_find = tabpage_browse.dw_browse.Find("ctx_acp_clause_id = " + String(ll_ctx_acp_clause_id),1,tabpage_browse.dw_browse.RowCount())
	If ll_find > 0 Then
		tabpage_browse.dw_browse.ScrollToRow(ll_find)
		tabpage_browse.dw_browse.SelectRow(0,False)
		tabpage_browse.dw_browse.SelectRow(ll_find,True)
	End If
	
	ll_Handle = w_clause_painter.tab_1.of_getHandle(ls_data,1)
	w_clause_painter.tab_1.tabpage_browse.tv_clause.SelectItem(ll_Handle)
End If


end subroutine

public function integer of_open_word_file (string as_importfile);string ls_file_name
long ll_new_clause_id
decimal{1} ldec_revision //Added By Ken.Guo 2009-12-30.

If tabpage_browse.dw_browse.rowcount() > 0 Then
	ll_new_clause_id = tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'ctx_acp_clause_id')
	//Begin Modified By Ken.Guo 2009-12-30.	
	/*
	If ll_new_clause_id <> il_old_clause_id Then
		il_ctx_acp_clause_id = ll_new_clause_id
		il_old_clause_id = ll_new_clause_id
	   If is_types = '' Then is_types = 'Update'
	Else
		Return 1
	End If
	*/
	//ldec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision') //Modified By Ken.Guo 2010-01-04
	If tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 Then
		ldec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'audit_version')
	Else
		ldec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision')
	End If
	If ll_new_clause_id <> il_old_clause_id or ldec_revision <> idec_old_revision Then
		il_ctx_acp_clause_id = ll_new_clause_id
		il_old_clause_id = ll_new_clause_id
		idec_revision = ldec_revision// tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision')
		idec_old_revision = ldec_revision
		If is_types = '' Then is_types = 'Update'
	Else
		Return 1
	End If
	//End Modified By Ken.Guo 2009-12-30.
Else
	//-------Begin Added by Alfee 08.22.2007---------
	tabpage_clause.ole_1.object.Close() //05.05.2007
	il_ctx_acp_clause_id = -1
	il_old_clause_id = -1
	Return 0
	//-------End Added ------------------------------
End If
//Modify by jervis 12.24.2009
//Add Import or Paste Clause function
//If of_create_word_file(il_ctx_acp_clause_id,ls_file_name) = 1 Then
If of_create_word_file(il_ctx_acp_clause_id,ldec_revision,ls_file_name,as_importfile) = 1 Then
	openwithparm( w_appeon_gifofwait, "Opening selected document..." )
	Try 
		tabpage_clause.ole_1.object.OpenLocalFile(ls_file_name , false)
		gnv_word_utility.of_modify_word_property( tabpage_clause.ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		of_set_word_view_size()
		tabpage_clause.ole_1.setfocus()
	Catch (RunTimeError rter)
		If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		tabpage_clause.ole_1.object.close() //Alfee 09.23.2008
		messagebox('Error', 'The Office Viewer Active X Control has failed.' )
		Return 0
	End Try
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
	End If
	
	If Isvalid( w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
			
	//Added By Ken.Guo 2009-12-30.
	If is_types = 'Update' Then
		str_add_audit lstr_add_audit
		lstr_add_audit.doc_id = il_ctx_acp_clause_id
		lstr_add_audit.revision = ldec_revision
		lstr_add_audit.action = 'Viewed'
		lstr_add_audit.notes = ''
		//Begin - Added By Mark Lee 07/11/12
//		inv_clause.of_add_audit_trail(lstr_add_audit)		
		If of_check_track_viewing() = 1 Then
			inv_clause.of_add_audit_trail(lstr_add_audit)		
		End If
		//End - Added By Mark Lee 07/11/12
	End If
Else
	Return 0
End If		

Return 1

end function

public function integer of_create_word_file (long al_clause_id, ref string as_file_name, string as_importfile);//Modified By Ken.Guo 2010-01-11. Overload this function.
Decimal ldec_revision
Select revision into :ldec_revision from ctx_acp_clause 
Where ctx_acp_clause_id = :al_clause_id;

Return of_create_word_file(al_clause_id,ldec_revision,as_file_name,as_importfile)

/*
Integer li_counter
Integer li_loops
Integer li_Writes,li_FileNum,li_Cnt
Long ll_start
Long ll_BlobLen,ll_CurrentPos
Long ll_getupdate
Long ll_data_length
String ls_file_name
String ls_lastupdate,ls_updatedate
Boolean lb_select
Blob lb_data
Blob lb_all_data
Blob lblb_Data

setpointer(HourGlass!)

tabpage_browse.dw_browse.accepttext()
If tabpage_browse.dw_browse.getrow() > 0 Then
	ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'), "mm/dd/yyyy hh:mm:ss" )	//Alfee 05.10.2007
	//ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'))	
End If
gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\")
ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + ".doc"

If is_types = 'Add' Then	
	if as_ImportFile <> "" then
		//Use Import Clause file - Jervis 12.24.2009
		FileCopy(as_ImportFile,ls_file_name,true)
	else
		inv_word_utility.of_new_word_document(tabpage_clause.ole_1, ls_file_name) //Alfee 09.22.2008
	end if
	/*	
	//---------Begin Modified by Alfee 09.06.2007----------------------------
	//<$Reason> Use a word format instead of text
	/*lb_all_data = blob('')
	li_FileNum = FileOpen(ls_file_name , StreamMode! ,Write!,Shared!, Replace!)
	If li_FileNum = -1 Then Return 0
	If FileWrite(li_FileNum, lb_all_data) = -1 Then
		Return 0
	End If
	FileClose(li_FileNum)*/
	tabpage_clause.ole_1.object.CreateNew("Word.Document")
	//----------Begin Modified by Alfee 10.31.2007------------------
	//<$Reason>to support Word 2007, save as word 2003 format, it's 
	//<$Reason>necessary that close and re-open the the document
	If FileExists(ls_file_name) Then FileDelete(ls_file_name)
	tabpage_clause.ole_1.object.ActiveDocument.SaveAs(ls_file_name, wdFormatDocument)
	tabpage_clause.ole_1.object.Close()
	//tabpage_clause.ole_1.object.SavetoLocal(ls_file_name, true)
	//----------End Modified ----------------------------------------
	//----------End Modified -------------------------------------------------
	*/
ElseIf is_types = 'Update' Then
	//Get if the document existed and updated
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
	
	//Gen the document if not existed or updated
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

		//--------Begin Added by Alfee 09.06.2007-----------------------
		//<$Reason>Use a word format instead of text
		If Len(lb_all_data) < 1 Then			
			inv_word_utility.of_new_word_document(tabpage_clause.ole_1, ls_file_name) //Alfee 09.22.2008			
			/*
			tabpage_clause.ole_1.object.CreateNew("Word.Document")
			//----------Begin Modified by Alfee 10.31.2007------------------
			//<$Reason>to support Word 2007, save as word 2003 format, it's 
			//<$Reason>necessary that close and re-open the the document
			If FileExists(ls_file_name) Then FileDelete(ls_file_name)
			tabpage_clause.ole_1.object.ActiveDocument.SaveAs(ls_file_name, wdFormatDocument)
			tabpage_clause.ole_1.object.Close()
			//tabpage_clause.ole_1.object.SavetoLocal(ls_file_name, true)
			//----------End Modified ----------------------------------------	
			*/			
			as_file_name = ls_file_name
			Return 1
		End If
		//---------End Added ------------------------------------------
		
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

//Modified By Ken.Guo 2010-12-16
inv_clause.of_create_clause_attribute(al_clause_id, al_clause_handle, tabpage_browse.tv_clause, '-P')
Return 

/*
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
		ltvi_Item.data = String(al_clause_id) + '-' + 'P'
		ltvi_Item.PictureIndex = 6
		ltvi_Item.SelectedPictureIndex = 6
		tabpage_browse.tv_clause.InsertItemLast(al_clause_handle, ltvi_Item)
	end if
loop
*/

end subroutine

public function integer of_collapse_row (long al_clause_id, long al_row);Long Li_find

tabpage_browse.dw_browse.Setredraw( False )

//Delete Rows
li_Find = tabpage_browse.dw_browse.find("ctx_acp_clause_id ="+string(al_clause_id)+" and level=2",1,tabpage_browse.dw_browse.rowcount())
do while li_Find > 0 
	tabpage_browse.dw_browse.deleterow( li_find)
	li_Find = tabpage_browse.dw_browse.find("ctx_acp_clause_id="+string(al_clause_id)+" and level=2",1,tabpage_browse.dw_browse.rowcount())
loop

tabpage_browse.dw_browse.setitem( al_row,'style','+')
//tabpage_browse.dw_browse.setitem( al_row,'audit_count',1)

tabpage_browse.dw_browse.Setredraw( True )

Return 1

end function

public subroutine of_collapse_all ();Long i,ll_cnt
long ll_clause_id
String ls_filter

ll_cnt = tabpage_browse.dw_browse.rowcount( )
If ll_cnt <= 0 Then Return

If tabpage_browse.dw_browse.Find('level = 2',1,tabpage_browse.dw_browse.rowcount()) = 0 Then
	Return
End If

ls_filter = tabpage_browse.dw_browse.object.datawindow.Table.Filter

tabpage_browse.dw_browse.SetFilter('level = 1')
tabpage_browse.dw_browse.Filter()

tabpage_browse.dw_browse.Rowsdiscard( 1,tabpage_browse.dw_browse.FilteredCount(), Filter!)

If len(ls_filter) > 1 Then
	tabpage_browse.dw_browse.SetFilter(ls_filter)
	tabpage_browse.dw_browse.Filter()
End If

For i = 1 To tabpage_browse.dw_browse.RowCount() 
	tabpage_browse.dw_browse.SetItem(i,'Style','+')
	If tabpage_browse.dw_browse.GetItemNumber(i,'ctx_acp_clause_id') = il_ctx_acp_clause_id Then
		tabpage_browse.dw_browse.SetRow(i)
		tabpage_browse.dw_browse.Scrolltorow(i)
		tabpage_browse.dw_browse.selectrow(0,False)
		tabpage_browse.dw_browse.selectrow(i,True)
	End If
Next
	

end subroutine

public subroutine of_checkin ();str_add_doc	lstr_add_doc
IF tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 THEN
		MessageBox("Check In","Can't check in a history revision.")
		RETURN
END IF		
IF tabpage_browse.dw_browse.object.checkout_status[tabpage_browse.dw_browse.getrow()] <> "0" THEN //Modified by Ken.Guo on 2009-03-27
	lstr_add_doc.revision_control = tabpage_browse.dw_browse.object.revision_control[tabpage_browse.dw_browse.getrow()] = "1"
	lstr_add_doc.doc_id = this.il_ctx_acp_clause_id
	lstr_add_doc.revision = this.idec_revision
	lstr_add_doc.doc_ext = 'doc'
	lstr_add_doc.filename = tabpage_browse.dw_browse.object.clause_name[tabpage_browse.dw_browse.getrow()]
	lstr_add_doc.new = FALSE
	lstr_add_doc.checkout_status =  tabpage_browse.dw_browse.object.checkout_status[tabpage_browse.dw_browse.getrow()] //Added by Ken.Guo on 2009-04-10
	lstr_add_doc.doc_from = 'clause'
	lstr_add_doc.operation = "checkin"	//jervis 12.21.2010
	OpenWithParm( w_dm_checkin_document, lstr_add_doc )

	IF Message.Doubleparm = 1 THEN
		of_refresh_clause(il_ctx_acp_clause_id)
		of_collapse_row(il_ctx_acp_clause_id,tabpage_browse.dw_browse.getrow() )
		of_set_menu(this.selectedtab)
	END IF
ELSE
	MessageBox("Check Out","Please Check Out the document first.")
END IF
	
end subroutine

public subroutine of_refresh_clause (long al_clause_id);Long ll_row 
Datawindow ldw_browse
ldw_browse = tabpage_browse.dw_browse
ll_row = tabpage_browse.dw_browse.GetRow()
If ids_clause_info.Retrieve(al_clause_id) <= 0 Then Return

ldw_browse.SetItem(ll_row,'revision',ids_clause_info.GetItemDecimal(1,'revision'))
ldw_browse.SetItem(ll_row,'revision_control',ids_clause_info.GetItemString(1,'revision_control'))
ldw_browse.SetItem(ll_row,'checkout_by',ids_clause_info.GetItemString(1,'checkout_by'))
ldw_browse.SetItem(ll_row,'checkout_date',ids_clause_info.GetItemDatetime(1,'checkout_date'))
ldw_browse.SetItem(ll_row,'checkout_status',ids_clause_info.GetItemString(1,'checkout_status'))
ldw_browse.SetItem(ll_row,'audit_count',ids_clause_info.GetItemNumber(1,'audit_count'))


end subroutine

public subroutine of_checkout ();//Check out document - Added by Alfee 12.14.2007
//<$Reason>Avoiding to call a response window in another response window
Integer li_rtn //03.28.2008
String ls_notes
str_add_doc lstr_add_doc
str_checkout lstr_checkout
str_ctx_email lstr_dm_email
str_add_audit lstr_add_audit
n_cst_dm_utils lnv_dm_utils
String ls_action_name //Added by Ken.Guo on 2009-03-26
String ls_checkout_status = '1' //Added by Ken.Guo on 2009-03-27

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 
End If

//-------------Begin Added by Alfee 03.13.2008---------------------------------
IF tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 THEN
	MessageBox("Check Out","Can't check out a history revision.")
	RETURN
END IF		
//-------------End Added ------------------------------------------------------

//Can't Check out a document whose Revision Control isn't started
IF tabpage_browse.dw_browse.object.revision_control[tabpage_browse.dw_browse.getrow()] <> "1" THEN
	MessageBox("Check Out","Please start Revision Control for the document first.")
	RETURN
END IF

////Do nothing on a document which has been currently Checked out 
IF tabpage_browse.dw_browse.object.checkout_status[tabpage_browse.dw_browse.getrow()] <> "0" THEN
	MessageBox("Check Out","The document is already checked out.")
	RETURN
END IF	

//Check if the document modified
IF of_ismodified() THEN
	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	IF li_rtn = 1 THEN 
		This.of_save()
	ELSEIF li_rtn = 3 THEN
		RETURN
	END IF
END IF		

lstr_add_doc.revision_control = tabpage_browse.dw_browse.object.revision_control[tabpage_browse.dw_browse.getrow()] = "1"
lstr_add_doc.doc_id = this.il_ctx_acp_clause_id
lstr_add_doc.revision = this.idec_revision
lstr_add_doc.doc_ext ='doc'
lstr_add_doc.filename =	tabpage_browse.dw_browse.object.clause_name[tabpage_browse.dw_browse.getrow()]
lstr_add_doc.doc_from = 'Clause' 

//Open the checkout type selection window and return if cancelled
OpenWithParm( w_dm_checkout_document, lstr_add_doc )
IF NOT Isvalid(Message.PowerobjectParm) THEN RETURN
			
lstr_checkout = Message.PowerobjectParm
ls_notes = lstr_checkout.checkout_notes

//Open the saveas or email window according to the above selection 
CHOOSE CASE lstr_checkout.checkout_type
	CASE "1"		// Only check out
		//this option is never selectable
	CASE "2"		// Check out with save as
		ls_action_name = 'Check Out & Save As' //Added by Ken.Guo on 2009-03-26
		openwithparm(w_dm_saveto_document, lstr_add_doc)
		IF Message.Doubleparm <> 1 THEN 	RETURN
	CASE "3"		// Check out With Email as attachment
		ls_action_name = 'Check Out & Email-Attachment' //Added by Ken.Guo on 2009-03-26
		lstr_dm_email.doc_id = lstr_add_doc.doc_id
		lstr_dm_email.revision = lstr_add_doc.revision
		lstr_dm_email.doc_ext = lstr_add_doc.doc_ext
		lstr_dm_email.filename = lstr_add_doc.filename
		lstr_dm_email.doc_from = 'Clause'
		lstr_dm_email.action_type = 'CheckOut'
		lstr_dm_email.ctx_id = lstr_add_doc.ctx_id
		lstr_dm_email.is_weblink = '0' //Added by Ken.Guo on 2009-03-26
		openwithparm(w_dm_email_document_send, lstr_dm_email)
		IF Message.Doubleparm <> 1 THEN 	RETURN	
END CHOOSE

//Update Checkout fields and add an audit trail record
Update ctx_acp_clause Set checkout_by = :gs_user_id, checkout_date = getdate(), checkout_status = :ls_checkout_status Where ctx_acp_clause_id = :lstr_add_doc.doc_id;
IF SQLCA.SQLCODE = 0 THEN
	///////////////////////////////////////////////////////////////////////
	//// Trigger off audit trail
	///////////////////////////////////////////////////////////////////////
	lstr_add_audit.doc_id = lstr_add_doc.doc_id
	lstr_add_audit.revision = lstr_add_doc.revision
	lstr_add_audit.doc_ext = lstr_add_doc.doc_ext
	lstr_add_audit.action = ls_action_name  //Replace the "Check Out". //Added by Ken.Guo on 2009-03-26
	lstr_add_audit.notes = ls_notes	
	inv_clause.of_add_audit_trail( lstr_add_audit )
ELSE
	MESSAGEBOX("Check Out", sqlca.sqlerrtext)
	SetPointer(Arrow!)	
	RETURN
END IF

//Refresh the browse window	
tabpage_browse.dw_browse.SetItem(tabpage_browse.dw_browse.GetRow(),'checkout_by',gs_user_id)
tabpage_browse.dw_browse.SetItem(tabpage_browse.dw_browse.GetRow(),'checkout_date',today())
tabpage_browse.dw_browse.SetItem(tabpage_browse.dw_browse.GetRow(),'checkout_status',ls_checkout_status )
tabpage_browse.dw_browse.SetItem(tabpage_browse.dw_browse.GetRow(),'audit_count',1)
tabpage_browse.dw_browse.SetItemStatus( tabpage_browse.dw_browse.GetRow(), 0, Primary!, Notmodified!)
of_collapse_row(il_ctx_acp_clause_id, tabpage_browse.dw_browse.GetRow())
of_set_menu(this.selectedtab)

SetPointer(Arrow!)  //for refresh problem on new image ocx - Alfee 05.19.2008


Return

end subroutine

public function boolean of_ismodified ();If idec_revision = idec_old_revision and il_ctx_acp_clause_id = il_old_clause_id and il_ctx_acp_clause_id <> 0 Then
	Return Not tabpage_clause.ole_1.object.ActiveDocument.saved
End If
Return False
end function

public function integer of_create_word_file (long al_clause_id, decimal adec_revision, ref string as_file_name, string as_importfile);Integer li_counter
Integer li_loops
Integer li_Writes,li_FileNum,li_Cnt
Long ll_start
Long ll_BlobLen,ll_CurrentPos
Long ll_getupdate
Long ll_data_length
String ls_file_name
String ls_lastupdate,ls_updatedate
Boolean lb_select
Blob lb_data
Blob lb_all_data
Blob lblb_Data

setpointer(HourGlass!)

//Commented By Ken.Guo 2010-01-11
/*
tabpage_browse.dw_browse.accepttext()
If tabpage_browse.dw_browse.getrow() > 0 Then
	ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'), "mm/dd/yyyy hh:mm:ss" )	//Alfee 05.10.2007
	//ls_updatedate = string(tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'))	
End If
*/

gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\")
//ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + ".doc"
ls_file_name = inv_clause.of_generate_name(al_clause_id, adec_revision )

If is_types = 'Add' Then	
	if as_ImportFile <> "" then
		//Use Import Clause file - Jervis 12.24.2009
		FileCopy(as_ImportFile,ls_file_name,true)
	else
		inv_word_utility.of_new_word_document(tabpage_clause.ole_1, ls_file_name) //Alfee 09.22.2008
	end if
ElseIf is_types = 'Update' Then
	//Modified By Ken.Guo 2010-01-11. 
	If inv_clause.of_download_file( al_clause_id, adec_revision, ls_file_name) < 0 Then
		Messagebox('Clause','Failed to download the clause file, please call support.')
		Return -1
	End If	
End if

as_file_name = ls_file_name

Return 1
end function

public function integer of_save (boolean ab_rev_ctrl);integer li_FileNum, loops, i
long ll_Handle,ll_num,ll_mes, ll_cnt
long ll_flen,ll_ctx_acp_clause_id,ll_ctx_acp_folder_id
Long ll_category,ll_approval_status
string ls_data,ls_clause_name,ls_updatedate,ls_file_name,ls_file_name1
datetime ldt_updatedate,ldt_null
boolean lb_save = True,		lb_flag = False
blob b, tot_b
str_add_audit lstr_add_audit
str_clause lstr_clause

treeviewitem ltvi_item
OLEobject  obj

setnull(ldt_null) 

obj = Create oleobject
Try 
	IF not ab_rev_ctrl and tabpage_clause.ole_1.object.DocType = 0 THEN RETURN 0 //added by alfee 05.21.2007
	obj = tabpage_clause.ole_1.object.ActiveDocument
Catch (RunTimeError rte)
	messagebox('Error', 'The Office Viewer Active X Control has failed.')
	Destroy obj //added by alfee 04.27.2007
End Try

Boolean lb_revision_control,lb_checkout_status
Integer li_version_increment,li_ret
long ll_row ,ll_level
Decimal ldec_max_revision,ldec_new_revision
str_doc_info	lstr_docinfo

ll_row = tabpage_browse.dw_browse.GetRow()
lb_revision_control = (tabpage_browse.dw_browse.GetItemString(ll_row, "revision_control") = "1")
li_version_increment = of_get_app_setting("set_57",'I')
ll_level = tabpage_browse.dw_browse.GetItemNumber(ll_row, "level")
lb_checkout_status = (tabpage_browse.dw_browse.GetItemString(ll_row, "checkout_status") <> "0") 

// Check rights
IF ll_level = 2 THEN
	MessageBox("Save Clause", "Can't save a history revision.")
	RETURN 0
END IF

IF lb_checkout_status THEN
	MessageBox("Save Clause", "Can't save a checked-out clause.")
	RETURN 0
END IF

If ab_rev_ctrl and  lb_revision_control Then
	Messagebox('Revision Clause','This clause has already begun a revision.')	
	Return 0
End If

IF lb_revision_control AND NOT of_ismodified( ) THEN
	MessageBox("Save Clause", "The clause is not modified.")
	RETURN 0
End If

IF ab_rev_ctrl THEN lb_revision_control = ab_rev_ctrl //press revison toolbar

IF NOT lb_revision_control THEN
	li_ret = MessageBox("Save Doucment", "Do you want to start version control?", Question!, YesNo!, 1)
	IF li_ret = 1 THEN
		lb_revision_control = TRUE
	ELSE
		IF NOT of_ismodified( ) THEN 
			MessageBox("Save clause", "The clause is not modified.") //added by alfee at 04.13.2007
			RETURN 0
		END IF
	END IF
END IF

IF ab_rev_ctrl THEN
	Openwithparm(w_appeon_gifofwait, "Generating the new revision clause...")			
Else
	Openwithparm(w_appeon_gifofwait, "Saving the clause...")
END IF

Select Max(Revision) Into :ldec_max_revision From ctx_acp_clause_image	Where clause_id = :il_ctx_acp_clause_id;   
If Isnull(ldec_max_revision) Then ldec_max_revision = 0 //Added By Ken.Guo 2010-01-11.

IF (lb_revision_control and li_version_increment = 1) or ab_rev_ctrl THEN // Jervis 06.10.2009
	ldec_new_revision = inv_dm_utils.of_newversion( ldec_max_revision )   //Modified By Ken.Guo 2009-05-15
ELSE
	ldec_new_revision = ldec_max_revision 
END IF

//--------Begin Modified by Alfee 05.10.2007----------------------
//ldt_updatedate = datetime(today())
////ls_updatedate = string(ldt_updatedate)
//ldt_updatedate = DateTime(today(), now()) 
//ls_updatedate = string(ldt_updatedate, "mm/dd/yyyy hh:mm:ss")
////--------End Modified---------------------------------------------
//


n_cst_word_utility lnv_word
if not ab_rev_ctrl then //Added By Ken.Guo 2010-01-04. Only for save button.

	//Unprotect the document if necessary - Alfee 03.10.2008
	lnv_word = Create n_cst_word_utility
	lnv_word.of_unprotect_doc(obj) 
	Destroy lnv_word
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007-02-26 By: Rodger Wu
	//$<reason> New requirement
	//$<reason> Trim spaces or line feed at the beginning or end of clauses.
	tabpage_clause.ole_1.setredraw( False )
	iw_clause_painter.of_ltrimword()
	iw_clause_painter.of_rtrimword()
	tabpage_clause.ole_1.setredraw( True )
	//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> By Alfee at 05.30.2007
	//$<reason> Check user defined bookmarks, which shouldn't be conflicted with the system defined. 
	ll_cnt = obj.bookmarks.count
	//Begin - Added By Mark Lee 07/31/12
	lb_flag = False				
//	For i = 1 to ll_cnt
//		//if Lower(Left(obj.content.bookmarks.Item[i].Name, 7)) = 'clause_'  Then Jervis 06.08.2009
//		if Lower(Left(obj.bookmarks.Item[i].Name, 7)) = 'clause_'  Then
//			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)			
//			tabpage_clause.ole_1.setredraw( True )
//			Destroy obj
//			messagebox("Alert","Clause file cannot contain bookmark(s) named with the prefix 'clause_'. Please modify the bookmark name",Exclamation!)					
//			return -1
//		end if			
//	Next
	IF ll_cnt > 0 Then
		For i = ll_cnt to 1 step -1
			If Lower(Left(obj.bookmarks.Item[i].Name, 7)) = 'clause_'  Then
				If lb_flag = False Then 
					messagebox("Alert","The clause file you add contains bookmark name(s) prefixed with 'clause_'.~r~n The system will automatically delete these bookmarks.",Exclamation!)
					lb_flag = True
				End If 
				obj.bookmarks.Item[i].Delete()
			End if
		Next 
	End IF
	//End - Added By Mark Lee 07/31/12
	//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> By Alfee at 03.09.2007
	//$<Reason>New requirement, make sure the document won't have revisions
	Long ll_clause_approved
	ll_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Approved'"))
	If tabpage_browse.dw_browse.GetItemNumber(tabpage_browse.dw_browse.GetRow(),"approval_status") = ll_clause_approved Then
		If obj.Revisions.Count > 0 Then
			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
			//MessageBox("Alert","The approved file can't include any revisons and not saved! Please approve or reject the changes with the reviewing menu items first.",Exclamation!)
			MessageBox("Alert","The approved file can't include any revisons that are not saved! Please approve or reject the changes with the reviewing menu items first.",Exclamation!)
			tabpage_clause.ole_1.setredraw( True )
			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
			Destroy obj
			Return -1
		End If
	End If
	//---------------------------- APPEON END ----------------------------
End If

IF lb_revision_control THEN
	If li_version_increment = 1 or ab_rev_ctrl then
		If ab_rev_ctrl Then //Revision operation
			Insert ctx_acp_clause_image(clause_id,revision,modify_date,image_file,doc_type)
				Select :il_ctx_acp_clause_id,:ldec_new_revision,getdate(),image_file,'doc'
				From ctx_acp_clause_image where clause_id = :il_ctx_acp_clause_id and revision =:idec_revision;
				If sqlca.sqlcode <> 0 Then
					If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
					messagebox('Save -1','Failed to save clause, please call support.~r~n' + sqlca.sqlerrtext )
					Return -1
				End If
			Select modify_date Into :ldt_updatedate from ctx_acp_clause_image where clause_id = :il_ctx_acp_clause_id and revision =:idec_revision;	
		Else //save operation
			Insert ctx_acp_clause_image(clause_id,revision,doc_type)	
			Values ( :il_ctx_acp_clause_id,:ldec_new_revision,'doc');
			If sqlca.sqlcode <> 0 Then
				If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
				messagebox('Save -2','Failed to save clause, please call support.~r~n' + sqlca.sqlerrtext )
				Return -1
			End If			
		End If
	Else
		
	End If
	
	//Set main record revision value.
	Update ctx_acp_clause
		Set revision = :ldec_new_revision,
		revision_control = '1',
		checkout_by = '',
		checkout_date = NULL,
		checkout_status = '0'
		Where ctx_acp_clause_id = :il_ctx_acp_clause_id;	
	If sqlca.sqlcode <> 0 Then
		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		messagebox('Save -3','Failed to save clause, please call support.~r~n' + sqlca.sqlerrtext )
		Return -1
	End If
	
	tabpage_browse.dw_browse.SetItem(ll_row,'revision',ldec_new_revision)
	tabpage_browse.dw_browse.SetItem(ll_row,'revision_control','1')
	tabpage_browse.dw_browse.SetItem(ll_row,'checkout_by','')
	tabpage_browse.dw_browse.SetItem(ll_row,'checkout_date',ldt_null)
	tabpage_browse.dw_browse.SetItem(ll_row,'checkout_status','0')
	This.of_collapse_row( il_ctx_acp_clause_id , ll_row)
	
	//Refresh version number data alter saved.
	if il_old_clause_id > 0 and il_old_clause_id = il_ctx_acp_clause_id and ldec_new_revision <> idec_revision then 
		lstr_docinfo.ver_num = ldec_new_revision
		inv_ole_utils_doc.of_refresh_docinfo( tabpage_clause.ole_1.object.ActiveDocument , lstr_docinfo,true)
		
		//Refresh doc info-jervis 02.26.2009
//		st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,"Doc_name") + " - Version: " + string(ldec_new_revision)
	end if	
	
End If

If Not ab_rev_ctrl Then //Save operation
	//ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(il_ctx_acp_clause_id) + '.' + String(ldec_new_revision) + ".doc"
	ls_file_name = inv_clause.of_generate_name( il_ctx_acp_clause_id, ldec_new_revision)
	ls_file_name1 = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(il_ctx_acp_clause_id) + '.' + String(ldec_new_revision) + "_1.doc"

	openwithparm(w_appeon_gifofwait, "Saving clause to DB..." )
	lb_save = False
	Try 
		tabpage_clause.ole_1.object.saveToLocal(ls_file_name , True)
	Catch (RunTimeError rter)
		messagebox('Error', 'The Office Viewer Active X Control has failed.')
		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		Destroy obj //added by alfee 04.27.2007
	End Try
	
	FileCopy (ls_file_name,ls_file_name1,True)	
	
	li_ret = inv_clause.of_upload_file(il_ctx_acp_clause_id , ldec_new_revision, ls_file_name1,ldt_updatedate)
	If li_ret < 0 Then
		If isvalid(obj) Then Destroy obj
		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		Return -1
	End If
	
	FileDelete(ls_file_name1)
	inv_word_utility.of_update_reqmnt_field(tabpage_clause.ole_1.object, il_ctx_acp_clause_id,'C') //Added By Ken.Guo 2009-07-13.
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End If

//Added By Ken.Guo 2010-01-04.
If il_ctx_acp_clause_id = il_old_clause_id Then  
	idec_revision = ldec_new_revision
	idec_old_revision = ldec_new_revision
End If
tabpage_browse.dw_browse.SetItem(ll_row,'modify_date',ldt_updatedate )
//tabpage_browse.dw_browse.SetItemstatus(ll_row,0,primary!,Notmodified!)
//tabpage_browse.dw_browse.resetupdate( )

lstr_add_audit.doc_id = il_ctx_acp_clause_id
lstr_add_audit.revision = ldec_new_revision
lstr_add_audit.doc_ext = 'doc'

If is_types = 'Update' Then
	If lb_save = False Then
		
		//Update Template and Document when Clause changed.--Modify by Jervis 01.30.2010
		lstr_clause.al_clause_id = il_ctx_acp_clause_id
		lstr_clause.as_clause_name = tabpage_browse.dw_browse.GetItemString(ll_row, "clause_name")
		lstr_clause.as_clause_file = ls_file_name
		inv_clause.of_update_Document(lstr_clause,1)	//1-Clause Update, 2-Caluse Status Update
		/*
		//Update Template
		ids_template_clause.Retrieve()	
		ids_template_clause.setfilter('')
		ids_template_clause.filter()
		ll_num = ids_template_clause.find("ctx_acp_clause_id = " + string(il_ctx_acp_clause_id),1,ids_template_clause.rowcount())
		If ll_num > 0 Then
			ll_mes = messagebox('Updating existing templates','Would you like to update all the Templates that refer to this clause?',question!,YesNo!)
			If ll_mes = 1 Then
				openwithparm(w_clause_template,il_ctx_acp_clause_id)
			End If
		End If
		
		//Update Document 
		ll_num = 0
		SELECT count(1) Into :ll_num
		FROM 	ctx_basic_info ,
			ctx_am_document,
			ctx_am_document_clause  
		WHERE ( ctx_am_document.doc_id = ctx_am_document_clause.doc_id ) and  
		( ctx_am_document.revision = ctx_am_document_clause.revision ) and  
		( ctx_basic_info.ctx_id = ctx_am_document.ctx_id ) and  
		( ( ctx_am_document_clause.ctx_acp_clause_id = :il_ctx_acp_clause_id ) ) ;		
		
		If ll_num > 0 Then
			ll_mes = messagebox('Updating existing documents','Would you like to update all the Documents that refer to this clause?',question!,YesNo!)
			If ll_mes = 1 Then
				lstr_clause.al_clause_id = il_ctx_acp_clause_id
				lstr_clause.as_clause_name = tabpage_browse.dw_browse.GetItemString(ll_row, "clause_name")
				lstr_clause.as_clause_file = ls_file_name
				openwithparm(w_clause_document,lstr_clause)
			End If
		End If
		*/
		
		lb_save = True
	End If
	If ab_rev_ctrl Then
		lstr_add_audit.action = 'Start Revision'
	Else
		lstr_add_audit.action = 'Modified'
	End If
Else
	lstr_add_audit.action = 'New - Existing'
End If

inv_clause.of_add_audit_trail( lstr_add_audit)
If isvalid(obj) Then Destroy obj
//If isvalid(m_pfe_cst_clause_painter) Then
//	m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//End If


If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
is_types = 'Update'
Return 1
end function

public subroutine of_saveas ();//////////////////////////////////////////////////////////////////////
// Function: of_saveas()
// Arguments:
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-12
//--------------------------------------------------------------------
// Description: Save As the clause.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Integer li_rtn
str_add_doc lstr_add_doc
str_add_audit lstr_add_audit

//Check if the document modified
IF of_ismodified() THEN
	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	IF li_rtn = 1 THEN 
		This.of_save()
	ELSEIF li_rtn = 3 THEN
		RETURN
	END IF
END IF		

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 
End If

//Save it
lstr_add_doc.revision_control = tabpage_browse.dw_browse.object.revision_control[tabpage_browse.dw_browse.getrow()] = "1"
lstr_add_doc.doc_id = this.il_ctx_acp_clause_id
lstr_add_doc.revision = this.idec_revision
lstr_add_doc.doc_ext ='doc'
lstr_add_doc.filename =	tabpage_browse.dw_browse.object.clause_name[tabpage_browse.dw_browse.getrow()]
lstr_add_doc.doc_from = 'Clause' 
lstr_add_doc.notes = 'Save As' 
openwithparm(w_dm_saveto_document, lstr_add_doc)


IF Message.Doubleparm <> 1 THEN 	RETURN	

//Add Audit
lstr_add_audit.doc_id = lstr_add_doc.doc_id
lstr_add_audit.revision = lstr_add_doc.revision
lstr_add_audit.doc_ext = lstr_add_doc.doc_ext
lstr_add_audit.action = 'OutPut - Save As' 
lstr_add_audit.notes = ''
inv_clause.of_add_audit_trail( lstr_add_audit )


end subroutine

public subroutine of_print ();


If This.selectedtab  = 1 Then
	If MessageBox("Print", "Are you sure you want to print browse data?", Question!, YesNo!) = 2 then Return
	SetPointer(HourGlass!)
	tabpage_browse.dw_browse.print(false)
	SetPointer(Arrow!)	
Else
	If tabpage_clause.ole_1.object.DocType = 0 Then Return
	inv_ole_utils_doc.of_print( )
	try
		tabpage_clause.ole_1.object.PrintOut(True) 
	catch(Throwable th)
		Messagebox('Warning','Failed to print the document due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
		Return
	end try
	str_add_audit lstr_add_audit
	lstr_add_audit.doc_id = il_ctx_acp_clause_id
	lstr_add_audit.revision = idec_revision
	lstr_add_audit.doc_ext = 'doc'
	lstr_add_audit.action = "OutPut - Print"
	inv_clause.of_add_audit_trail( lstr_add_audit )	
End If


end subroutine

public subroutine of_email ();
Integer li_rtn
str_ctx_email lstr_ctx_email
string ls_flag


//Check if the document modified
IF (il_ctx_acp_clause_id = il_old_clause_id) and &
	(idec_revision = idec_old_revision) and of_ismodified() THEN
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return
END IF		

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 
End If

//Display Message - jervis 07.16.2009
ls_flag = ProfileString(gs_IniFilePathName, "setup", "dispaly-message", "0")
if ls_flag = "0" then
	OpenWithParm(w_custom_help,ls_flag)
	if Upper(Message.StringParm) = "CANCEL" then return
end if
		
//Set document info.
lstr_ctx_email.doc_from = 'Clause'
lstr_ctx_email.ctx_id = 0
lstr_ctx_email.doc_id = il_ctx_acp_clause_id
lstr_ctx_email.revision = idec_revision
lstr_ctx_email.doc_ext = 'doc'
If tabpage_browse.dw_browse.getrow() > 0 Then
	lstr_ctx_email.filename = tabpage_browse.dw_browse.object.clause_name[tabpage_browse.dw_browse.getrow()]					
End If

//Open email window 
OpenWithParm(w_dm_email_document_send, lstr_ctx_email)
IF Message.Doubleparm <> 1 THEN 	RETURN	

//Add Audit record.
str_add_audit lstr_add_audit
lstr_add_audit.doc_id = il_ctx_acp_clause_id
lstr_add_audit.revision = idec_revision
lstr_add_audit.doc_ext = 'doc'
lstr_add_audit.action = 'OutPut - Email'
inv_clause.of_add_audit_trail( lstr_add_audit )

end subroutine

public function integer of_check_name (string as_clause_name);Integer i
String ls_unsupport_char[] = {'|','*','?','<',':','>'}

For i = 1 To UpperBound(ls_unsupport_char[])
	If Pos(as_clause_name,ls_unsupport_char[i],1) > 0 Then
		Messagebox('Verification',"There is unsupported character '"+ls_unsupport_char[i]+"' included in the clause name '"+as_clause_name+"', please modify the clause name.")
		Return -1
	End If
Next
Return 1


end function

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
	Tabpage_Browse.pb_AttriFilter.PictureName = "Filter_Empty.gif"
else
	Tabpage_Browse.pb_AttriFilter.PictureName = "Filter_Exist.gif"
end if

end subroutine

public subroutine of_refreshclauseattribute (string as_filter);//====================================================================
// Function: of_RefreshClauseAttribute()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Filter
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-19
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_CurRow,ll_RowCnts,ll_Found
long		ll_First_Attr_id,ll_Attribute_id,ll_FirstClauseid,ll_Clause_id
String	ls_Clause_Alias,ls_Value_Code,ll_AttrList,ls_ClauseAttName,ls_AttrColName,ls_AttrColAlias

DataStore	lds_ClauseAttr

if as_Filter <> "" then
	ll_Found = Tabpage_Browse.dw_Browse.Find(as_Filter,1,Tabpage_Browse.dw_Browse.RowCount())
	do while ll_Found > 0
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,"attribute_1_value","")
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,"attribute_2_value","")
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,"attribute_3_value","")
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,"attribute_4_value","")
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,"attribute_5_value","")
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,"attribute_6_value","")
		
		if ll_Found >= Tabpage_Browse.dw_Browse.RowCount() then Exit
		ll_Found = Tabpage_Browse.dw_Browse.Find(as_Filter,ll_Found + 1,Tabpage_Browse.dw_Browse.RowCount())
	loop
end if

lds_ClauseAttr = Create DataStore

lds_ClauseAttr.DataObject = "d_all_clause_attribute_value_list"
lds_ClauseAttr.SetTransObject(SQLCA)
lds_ClauseAttr.Retrieve()

lds_ClauseAttr.SetFilter(as_Filter)
lds_ClauseAttr.Filter()

ll_RowCnts = lds_ClauseAttr.RowCount()

do while ll_CurRow < ll_RowCnts
	ll_CurRow++

	ll_FirstClauseid = lds_ClauseAttr.GetItemNumber(ll_CurRow,"ctx_acp_clause_id")
	ll_First_Attr_id = lds_ClauseAttr.GetItemNumber(ll_CurRow,"ctx_clause_attribute_id")
	ls_ClauseAttName = lds_ClauseAttr.GetItemString(ll_CurRow,"ctx_acp_clause_attribute_name")
	ls_Clause_Alias  = lds_ClauseAttr.GetItemString(ll_CurRow,"ctx_acp_clause_attribute_alias")
	ls_Value_Code    = lds_ClauseAttr.GetItemString(ll_CurRow,"ctx_acp_clause_attribute_value_name")
	
	ll_AttrList = ls_Value_Code

	ll_CurRow++
	
	if ll_CurRow <= ll_RowCnts then
		ll_Clause_id    = lds_ClauseAttr.GetItemNumber(ll_CurRow,"ctx_acp_clause_id")
		ll_Attribute_id = lds_ClauseAttr.GetItemNumber(ll_CurRow,"ctx_clause_attribute_id")
		
		do while ll_FirstClauseid = ll_Clause_id and ll_First_Attr_id = ll_Attribute_id
			ls_Value_Code = lds_ClauseAttr.GetItemString(ll_CurRow,"ctx_acp_clause_attribute_value_name")
			ll_AttrList += ", " + ls_Value_Code
			
			ll_CurRow++
			if ll_CurRow > ll_RowCnts then Exit
			
			ll_Clause_id     = lds_ClauseAttr.GetItemNumber(ll_CurRow,"ctx_acp_clause_id")
			ll_Attribute_id  = lds_ClauseAttr.GetItemNumber(ll_CurRow,"ctx_clause_attribute_id")
		loop
		
		//ll_CurRow --
		ll_CurRow = ll_CurRow - 1 
	end if
	
	Choose Case ls_ClauseAttName
		Case 'Attribute 1'
			ls_AttrColName  = "attribute_1_value"
			ls_AttrColAlias = "attribute_1_label"
		Case 'Attribute 2'
			ls_AttrColName  = "attribute_2_value"
			ls_AttrColAlias = "attribute_2_label"
		Case 'Attribute 3'
			ls_AttrColName  = "attribute_3_value"
			ls_AttrColAlias = "attribute_3_label"
		Case 'Attribute 4'
			ls_AttrColName  = "attribute_4_value"
			ls_AttrColAlias = "attribute_4_label"
		Case 'Attribute 5'
			ls_AttrColName  = "attribute_5_value"
			ls_AttrColAlias = "attribute_5_label"
		Case 'Attribute 6'
			ls_AttrColName  = "attribute_6_value"
			ls_AttrColAlias = "attribute_6_label"
	End Choose
	
	ll_Found = Tabpage_Browse.dw_Browse.Find("ctx_acp_clause_id = " + String(ll_FirstClauseid),1,Tabpage_Browse.dw_Browse.RowCount())
	if ll_Found > 0 then
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,ls_AttrColName,ll_AttrList)
		Tabpage_Browse.dw_Browse.SetItem(ll_Found,ls_AttrColAlias,ls_Clause_Alias)
	end if
loop

Destroy lds_ClauseAttr

of_RefreshFieldLabel()

end subroutine

public subroutine of_refreshtreeviewnodeattribute (long al_clause_id);//====================================================================
// Function: of_RefreshTreeViewNodeAttribute()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_clause_id
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-19
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Handle,ll_Child

SetPointer(HourGlass!)
Tabpage_Browse.tv_Clause.SetRedraw(false)

ll_Handle = of_FindClauseNode(0,al_clause_id)
if ll_Handle > 0 then
	ll_Child = Tabpage_Browse.tv_Clause.FindItem(ChildTreeItem!,ll_Handle)
	do while ll_Child > 0
		Tabpage_Browse.tv_Clause.DeleteItem(ll_Child)
		ll_Child = Tabpage_Browse.tv_Clause.FindItem(ChildTreeItem!,ll_Handle)
	loop
	of_Create_Clause_Attribute(al_clause_id,ll_Handle)	
end if

Tabpage_Browse.tv_Clause.SetRedraw(true)
SetPointer(Arrow!)

end subroutine

public function long of_findclausenode (long al_parenthandle, long al_clause_id);//====================================================================
// Function: of_FindClauseNode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_clause_id
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-19
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Handle,ll_ChildHandle

TreeViewItem	ltvi_Item

ll_Handle = Tabpage_Browse.tv_Clause.FindItem(ChildTreeItem!,al_ParentHandle)
do while ll_Handle > 0
	Tabpage_Browse.tv_Clause.GetItem(ll_Handle,ltvi_Item)
	if String(ltvi_Item.data) = String(al_clause_id) + '-C' then Return ll_Handle
	ll_ChildHandle = of_FindClauseNode(ll_Handle,al_clause_id)
	if ll_ChildHandle > 0 then Return ll_ChildHandle
	ll_Handle = Tabpage_Browse.tv_Clause.FindItem(NextTreeItem!,ll_Handle)
loop

Return -1

end function

public subroutine of_refreshfieldlabel ();//====================================================================
// Function: of_RefreshFieldLabel()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-19
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_CurRow,ll_RowCnts,ll_Cycle
String	ls_Clause_Alias

ll_CurRow  = Tabpage_Browse.dw_Browse.GetRow()
ll_RowCnts = Tabpage_Browse.dw_Browse.RowCount()

if ll_CurRow <= 0 or ll_CurRow > ll_RowCnts then Return

for ll_Cycle = 1 to ATTRIBUTECNTS
	//ls_Clause_Alias = Tabpage_Browse.dw_Browse.GetItemString(ll_CurRow,"attribute_" + String(ll_Cycle) + "_label")
	//if IsNull(ls_Clause_Alias) or Trim(ls_Clause_Alias) = "" then
		ls_Clause_Alias = gnv_data.of_GetItem("code_lookup","description","lookup_name = 'Clause Attributes' and code = 'Attribute " + String(ll_Cycle) + "'")
	//end if
	Tabpage_Browse.dw_Browse.Modify("attribute_" + String(ll_Cycle) + "_value_t.Text = '" + ls_Clause_Alias + "'")
next

end subroutine

public function integer of_update_document (integer ai_ctx_id[], integer ai_export_id[], long al_doc_id[], decimal adec_revision[], str_doc_info astr_docinfo[]);/*
Long i,j,ll_cnt
String ls_doc_filename[] ,ls_merge_file_temp
String ls_bookmark
Long ll_start_ori,ll_len_ori,ll_pagebreak,ll_end_new


//Download all documents
ll_cnt = UpperBound(al_doc_id[])
For i = 1 To ll_cnt
	ls_doc_filename[i] = inv_dm_utils.of_download_file(al_doc_id[i],adec_revision[i] )
	If ls_doc_filename[i] = '' Then Return -1
Next

//Replace Clause
//Open a Word Application
OLEObject lole_word,lole_document
lole_word = Create OLEObject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	Destroy lole_word
	RETURN -1
END IF
lole_word.Visible = False
lole_document = Create OLEObject

ls_bookmark = "clause_" + string(il_ctx_acp_clause_id)
Select page_break into :ll_pagebreak From ctx_acp_clause Where ctx_acp_clause_id = :il_ctx_acp_clause_id;


//Replace clause in each document file
TRY 
	lole_word.Application.NormalTemplate.Saved = TRUE 
	IF IsValid(w_appeon_gifofwait) THEN	w_appeon_gifofwait.st_1.Text = "Updating document files..."		
	FOR j = 1 TO ll_cnt 
		IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()		
		lole_document = lole_word.Application.Documents.Open(ls_doc_filename[j])
		
		IF lole_word.Application.Documents.Count < 1 THEN 			
			MessageBox("Warning","Open the document file of " + ls_doc_filename[j] +" failed!", exclamation!)			
			EXIT
		END IF
		//If Not lole_document.bookmarks.Exists(ls_bookmark) Then Continue jervis 06.08.2009
		If Not lole_document.content.bookmarks.Exists(ls_bookmark) Then Continue

		ll_start_ori = lole_document.content.bookmarks.item(ls_bookmark).start
		ll_len_ori = lole_document.content.bookmarks.item(ls_bookmark).end - ll_start_ori
				
		lole_document.content.bookmarks.item(ls_bookmark).select()
		lole_document.activewindow.selection.collapse(wdCollapseStart)

		//for the case of adding content before an existed table
		IF lole_document.activewindow.selection.tables.count > 0 THEN 
			lole_document.activewindow.selection.InsertBreak(wdSectionBreakContinuous)	
			lole_document.activewindow.selection.Start = ll_start_ori
			lole_document.activewindow.selection.End = lole_document.content.bookmarks.item(ls_bookmark).End
			lole_document.activewindow.selection.collapse(wdCollapseStart)			
		END IF			
			
		If ll_pagebreak = 1 Then lole_document.activewindow.selection.insertbreak(wdSectionBreakNextPage)	//added by alfee at 05.29.2007
		lole_document.activewindow.selection.InsertFile(ls_doc_filename[j])
		lole_document.activewindow.selection.InsertParagraphAfter()
		lole_document.activewindow.selection.Expand()

		ll_end_new = lole_document.content.bookmarks.item(ls_bookmark).end
		lole_document.range(ll_end_new - ll_len_ori, ll_end_new).Delete()
	
		//Update Clause Text Color and Word comment 
		inv_word_utility.of_update_clausecolor( lole_document, il_ctx_acp_clause_id)
		inv_word_utility.of_update_wordcomment( lole_document, il_ctx_acp_clause_id)
		
		lole_document.Close(wdSaveChanges)

		//Merge document
		ls_merge_file_temp = 'c:\1.doc'
		FileCopy(ls_doc_filename[j],ls_merge_file_temp,True)
		inv_ole_utils_doc.of_mergedata(ai_export_id[j], ai_ctx_id[j],ls_merge_file_temp, ls_doc_filename[j], False, astr_docinfo[j])
		
		//automunber
		inv_ole_utils_doc.of_autonumbering(ls_doc_filename[j])
		
		//Update document file into DB
		//
		
	NEXT

	//Quit Word application
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_document
	Destroy lole_word

Catch( Throwable th)
	f_word_destroy(lole_word, "") //Alfee 01.17.2008
	Destroy lole_document
	MessageBox("Warning","Update template file(s) failed! " + th.text, exclamation!)	
	Return -1 
End Try








//update comment and color
*/
Return 1
end function

public subroutine of_export_single ();Decimal{1} ldec_revision
String ls_null,ls_text,ls_file,ls_error,ls_folder_name
str_clause_export lstr_clause_export
Setnull(ls_null)
long r,c, ll_row_cnt,ll_col_cnt,ll_clause_id,ll_folder_id,ll_handle
TreeviewItem ltvi_folder
w_appeon_gifofwait lw_appeon_gifofwait

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 
End If

If tabpage_browse.dw_browse.RowCount() = 0 Then
	Messagebox('Export','There is no clause.')	
	Return 
End If

Open(w_clause_export_single)
If Not isvalid (Message.powerobjectparm) Then Return 
If Message.powerobjectparm.classname( ) <> "str_clause_export" Then Return

lstr_clause_export = Message.powerobjectparm

ll_row_cnt = tabpage_browse.dw_browse.rowcount()
ll_col_cnt = UpperBound(lstr_clause_export.col_name)

IF Not IsValid(lw_appeon_gifofwait) THEN 
	Open(lw_appeon_gifofwait)
	lw_appeon_gifofwait.st_1.Text = "Exporting the clause(s)..."
	lw_appeon_gifofwait.hpb_1.MaxPosition = 100
	lw_appeon_gifofwait.hpb_1.Position = 3
	Timer(0,lw_appeon_gifofwait)
End If

Open(w_email_edit)
w_email_edit.ole_word.of_open('')
If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.hpb_1.Position = 5

oleobject lole_range,lole_table,lole_cell,lole_selection

//Insert Folder Name
ll_handle = tabpage_browse.tv_clause.FindItem(CurrentTreeItem!,0) 
If ll_handle > 0 Then
	tabpage_browse.tv_clause.GetItem(ll_handle,ltvi_folder)
	ls_folder_name = ltvi_folder.label
Else
	ls_folder_name = ''
End If
lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
lole_selection.Font.Bold = True
lole_selection.Font.Size = 16
lole_selection.ParagraphFormat.Alignment = 1// wdAlignParagraphCenter
lole_selection.TypeText(ls_folder_name + '~r~n~r~n')
w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection.Start = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection.End

lole_selection.Font.Bold = False
lole_selection.Font.Size = 10
lole_selection.ParagraphFormat.Alignment = 0//  wdAlignParagraphLeft 
If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.hpb_1.Position = 10

//Insert Table
lole_range = w_email_edit.ole_word.object.ActiveDocument.Range(w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection.Start,w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection.End)
lole_table = w_email_edit.ole_word.object.ActiveDocument.Tables.Add(lole_range,ll_row_cnt + 1,ll_col_cnt)
lole_table.Borders.Enable = True

//Set Columns Width
For c = 1 to ll_col_cnt
	lole_table.Columns.item(c).PreferredWidthType = 2 //wdPreferredWidthPercent
	If lstr_clause_export.col_width[c] = -1 Then
		lole_table.Columns.item(c).PreferredWidth = lstr_clause_export.al_ave_width
	Else
		lole_table.Columns.item(c).PreferredWidth = lstr_clause_export.col_width[c]
	End If
	lole_table.Columns.item(c).cells.VerticalAlignment = 0 // wdCellAlignVerticalTop
Next
If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.hpb_1.Position = 15

//Set Header 
For c = 1 To ll_col_cnt
	lole_cell = lole_table.cell(1,c)
	lole_cell.select()
	lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
	lole_selection.TypeText(lstr_clause_export.col_label[c])
Next
lole_table.rows.item(1).select()
lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
lole_selection.Font.Bold = True
lole_selection.ParagraphFormat.Alignment = 1//  wdAlignParagraphCenter
lole_selection.Cells.VerticalAlignment = 1//wdCellAlignVerticalCenter
If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.hpb_1.Position = 20

//Set Cell Value
For r = 1 To ll_row_cnt
	For c = 1 to ll_col_cnt
		lole_cell = lole_table.cell(r+1,c)
		lole_cell.select()
		lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
		Choose Case Lower(lstr_clause_export.col_type[c])
			Case 'char'
				ls_text = tabpage_browse.dw_browse.GetItemString(r,lstr_clause_export.col_name[c])
			Case 'number'
				ls_text = String(tabpage_browse.dw_browse.GetItemNumber(r,lstr_clause_export.col_name[c]))
			Case 'datetime','date'
				ls_text = String(tabpage_browse.dw_browse.GetItemDatetime(r,lstr_clause_export.col_name[c]),'mm/dd/yyyy')
			Case 'dddw'
				ls_text = tabpage_browse.dw_browse.Describe("Evaluate('LookupDisplay("+lstr_clause_export.col_name[c]+")',"+string(r)+")")
		End Choose
		If Lower(lstr_clause_export.col_type[c]) = 'image' Then
			ll_clause_id = tabpage_browse.dw_browse.GetItemNumber(r,'ctx_acp_clause_id')
			ldec_revision = tabpage_browse.dw_browse.GetItemDecimal(r,'revision')
			If inv_clause.of_download_file(ll_clause_id,ldec_revision,ls_file) > 0 Then
				lole_selection.InsertFile(ls_file)
			Else
				ls_error += 'Failed to download clause ' + String(ll_clause_id) + '.~r~n'
				Continue
			End If
		Else
			If Not isnull(ls_text) and ls_text <> '' Then
				lole_selection.TypeText(ls_text)
			End If
		End If
	Next
	If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.hpb_1.Position = 20 + r/ll_row_cnt * 70
Next

w_email_edit.ole_word.object.SaveToLocal(lstr_clause_export.as_export_file ,True)
w_email_edit.ole_word.of_close()
If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.hpb_1.Position = 100
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)

If lstr_clause_export.ab_openfile Then
	ShellExecuteA ( Handle( This ), ls_Null, lstr_clause_export.as_export_file , ls_Null, ls_Null, 4)
Else
	Messagebox('Export','Export Completed.')
End If



end subroutine

public subroutine of_export (string as_flag);////Add by jervis 11.9.2009 -- Export Clause
str_folder lstr_pass

//Added By Ken.Guo 08/06/2012
If This.of_checkmultiselect( ) Then
	Messagebox('Clause','You have highlighted multiple clauses. Please only select one clause.')
	Return 
End If


lstr_pass.as_type = is_type
lstr_pass.al_folder_id = il_ctx_acp_folder_id
lstr_pass.al_clause_id = il_ctx_acp_clause_id
lstr_pass.al_handle = il_handle
lstr_pass.atv_clause = tabpage_browse.tv_clause

//Added By Ken.Guo 2010-11-10.
lstr_pass.adw_clause = tabpage_browse.dw_browse
lstr_pass.as_flag = as_flag //'tv': Export TreeView Data, 'dw': Export dw data

OpenWithParm(W_Clause_export,lstr_pass)



end subroutine

public function integer of_check_track_viewing ();//====================================================================
// Function: of_check_track_viewing
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/11/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long				ll_track_viewing = 0 

Select track_viewing
Into 	:ll_track_viewing
From icred_settings 
Using Sqlca;

If isnull(ll_track_viewing) or ll_track_viewing = 0 Then 
	return 0
Else
	return 1
End If 


end function

public function string of_fulltext_search (string as_searchtext, string as_find_results);//====================================================================
// Function: of_fulltext_search
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_searchtext
//                as_find_results
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/13/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long ll_resultsnum,ll_ret
String ls_criteria_results
String ls_checked
string ls_contract_array
Integer i
n_cst_string  lnv_string
Long    ll_Pos,ll_start = 1,ll_pos2
String  ls_Temp, ls_searchtext
boolean lb_flag = false

SetPointer( HourGlass! )

ls_searchtext = as_searchtext
If tabpage_browse.dw_filter.getrow( ) <=0 then 
	Return ''
End If 

If isnull(as_find_results) Or trim(as_find_results ) = '' Then 
	tabpage_browse.dw_filter.setItem(tabpage_browse.dw_filter.getRow(),'textsearch_dddw','AND')
	ls_criteria_results = 'AND'
Else
	ls_criteria_results = as_find_results
End If 

if len(ls_searchtext) <= 1 then
	MessageBox("Information","There must be at least two query characters.~r~nSingle character cannot be searched.")
	return ''
end if

// ignore double quotation marks.
If Pos(ls_searchtext,'"') > 0 Then
	Messagebox('Search','The double quotation mark (") is not supported, the system will ignore it.')
	ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, '"', '') 
End If

//Added By Mark Lee 07/13/12	single quotation replace double quotation
// Correct search text error
ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, "'", "''")	

//Added By Mark Lee 07/13/12	double blanks replace single blank
DO WHILE POS(ls_searchtext,"  ") > 0
	ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, "  ", " ")
LOOP

//Added By Mark Lee 07/13/12	use specialty character add double quotation
ls_searchtext = ls_searchtext + " "
DO WHILE (1=1)
	ll_Pos = Pos(ls_searchtext," ",ll_start)
	if ll_Pos < 1 then exit
	
	ls_Temp = Mid(ls_searchtext,ll_start,ll_Pos - ll_start)
	if Len(ls_Temp) < 2 then 
		lb_flag = true; exit
	end if
	
	ll_pos2 = Pos(ls_Temp,"*")
	if ll_pos2 > 0 or Pos(ls_Temp,",") > 0 then 
		ls_searchtext = Replace ( ls_searchtext, ll_start, Len(ls_Temp), '"' + ls_Temp + '"' )
		ll_start = ll_Pos + 3
	else
		ll_start = ll_Pos + 1
	end if
	
LOOP

if lb_flag then
//	MessageBox("Information","Each searched word must contain at least two characters.")
//	return ""
end if
ls_searchtext = Left(ls_searchtext,len(ls_searchtext) - 1)

// Search Criteria - Word Match
Choose Case ls_criteria_results
	Case 'AND'	//	With all of the words
		// Use ' and ' instead of ALL ' '.
		ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, ' ', '" AND "')
	Case 'EXACT'	//	With the Exact Phrase	
		ls_searchtext = ls_searchtext 
	Case 'OR'	//	With at least of the words
		ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, ' ', '" OR "')
End Choose

ls_searchtext = '"' + ls_searchtext + '"'

//Begin - Added By Mark Lee 07/12/12 specialty charactor bug
If Pos(ls_searchtext,'""') > 0 Then
	ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, '""', '"')			
End If
//End - Added By Mark Lee 07/12/12

SetPointer( HourGlass! )

return ls_searchtext
end function

public subroutine of_get_auto_retrieve ();//====================================================================
// Function: of_get_auto_retrieve
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/18/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 	ls_retrieve


ls_retrieve	=	gnv_user_option.of_get_option_value( gs_user_id, "library_painter_auto_retrieve" )
If upper(ls_retrieve) = 'TRUE' Then
	ib_autoretrieve		= TRUE
Else
	ib_autoretrieve		= False
End IF

end subroutine

public function integer of_set_auto_retrieve (boolean abln_menu_retrieve);//====================================================================
// Function: of_set_auto_retrieve
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                abln_menu_retrieve
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/18/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 	ls_retrieve
Integer	li_return 

if abln_menu_retrieve then
	ib_autoretrieve = true
	ls_retrieve = 'true'
else
	ib_autoretrieve = false
	ls_retrieve = 'false'
end if

//gnv_user_option. of_get_option_value( gs_user_id, "library_painter_auto_retrieve" )
gnv_user_option.of_Set_option_value(gs_user_id, "library_painter_auto_retrieve",string(ls_retrieve) )
li_return	=	gnv_user_option.Of_Save ( )

return li_return
end function

public function integer of_batchupdatedoc ();//====================================================================
// Function: of_batchupdatedoc
//--------------------------------------------------------------------
// Description: Update Template and Document by multi Clauses.
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 07/29/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_selected_row
str_clause lstr_clause
Boolean lb_selected_child


ll_selected_row = tabpage_browse.dw_browse.getselectedrow(0)
Do While ll_selected_row > 0
	If tabpage_browse.dw_browse.getitemnumber(ll_selected_row,'level') = 2 Then
		lb_selected_child = True
		If ll_selected_row = tabpage_browse.dw_browse.RowCount() Then Exit
		ll_selected_row = tabpage_browse.dw_browse.getselectedrow( ll_selected_row )		
		Continue
	End If
	lstr_clause.al_clause_id_arr[UpperBound(lstr_clause.al_clause_id_arr[]) + 1] = tabpage_browse.dw_browse.GetItemNumber(ll_selected_row, 'ctx_acp_clause_id')
	If ll_selected_row = tabpage_browse.dw_browse.RowCount() Then Exit
	ll_selected_row = tabpage_browse.dw_browse.getselectedrow( ll_selected_row )
Loop 

If lb_selected_child Then
	Messagebox('Clause','You have selected some history clause record(s). The batch update will automatically ignore the history record(s).')
End If

If UpperBound(lstr_clause.al_clause_id_arr[]) = 0 Then
	Messagebox('Clause','Please select at least one clause.')
	Return 1
End If

//lstr_clause.al_clause_id_arr[] = lstr_clause.al_clause_id_arr[]
If inv_clause.of_update_Document(lstr_clause,1)  = 0 Then	//2nd argument:  1-Clause Update, 2-Caluse Status Update
	Messagebox('Clause','The selected clause(s) are not referenced in any of the templates or documents. There is no need for batch update. ')
End If

Return 1
end function

public function integer of_update_template (long al_template_id[], datetime adt_lastupdate[], integer ai_type, long al_clause_id[]);//////////////////////////////////////////////////////////////////////////////
//	Function:  of_update_template()
//	Arguments: long al_templateid[]; datetime adt_lastupdate[]
//					integer ai_type: 1-Clause Update,2-Clause Status Updatae //Add by jervis 01.30.2010
//					al_clause_id[] //Added By Ken.Guo 07/29/2012 Updated by multi clauses
//	Returns:  integer
//	Description: Update templates by the specified clause file
//////////////////////////////////////////////////////////////////////
// $<add> 05.10.2007 by Alfee (Contract Logix Clause Library Painter)
//Modified By Ken.Guo 07/29/2012. Support update by multi Clauses. 
//////////////////////////////////////////////////////////////////////
Long ll_cnt, i, j, ll_start_ori, ll_len_ori, ll_pagebreak, ll_end_new,ll_AppendParagraph,ll_ret
//Long ll_len_old, ll_len_new //commented by alfee 05.29.2007
String ls_bookmark, ls_clausename, ls_template_name[]
String ls_lastupdate
Boolean lb_select = FALSE
n_cst_word_utility lnv_word
Long k
Decimal{2} ldec_revision

OLEObject lole_word, lole_template

setpointer(HourGlass!)

ll_cnt = UpperBound(al_template_id)
IF ll_cnt < 1 THEN RETURN 0

lnv_word = Create n_cst_word_utility

//Added By Ken.Guo 07/29/2012
If UpperBound(al_clause_id[]) = 0 Then
	al_clause_id[1] = il_ctx_acp_clause_id
End If

//Get template files
IF IsValid(w_appeon_gifofwait) THEN	w_appeon_gifofwait.st_1.Text = "Getting template files..."
FOR i = 1 TO ll_cnt 
	IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
	//---------Begin Modified by (Appeon)Eugene 07.01.2013 for V141 ISG-CLX--------
	  /*
		ls_template_name[i] = gs_dir_path + gs_DefDirName + "\Agreement\template_" + string(al_template_id[i]) + ".doc"	
	  */
	ls_template_name[i] = gs_temp_path + "Agreement\template_" + string(al_template_id[i]) + ".doc"
	//---------End Modfiied ------------------------------------------------------------------	
	IF lnv_word.of_get_template_file(al_template_id[i], adt_lastupdate[i]) = -1 THEN
		Destroy lnv_word
		RETURN -1
	END IF
NEXT

//Open a Word Application
lole_word = Create OLEObject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	Destroy lnv_word
	Destroy lole_word
	RETURN -1
END IF
lole_word.Visible = False
lole_template = Create OLEObject

//Replace clause in each template file
TRY 
	lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
	IF IsValid(w_appeon_gifofwait) THEN	w_appeon_gifofwait.st_1.Text = "Updating template files..."		
	FOR j = 1 TO ll_cnt 
		IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()		
		lole_template = lole_word.Application.Documents.Open(ls_template_name[j])
		gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.		
		gnv_shell.of_delete_recent( ls_template_name[j], true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		IF lole_word.Application.Documents.Count < 1 THEN 			
			MessageBox("Warning","Open the template file of " + ls_template_name[j] +" failed!", exclamation!)			
			EXIT
		END IF
		//Updated by Each Clause.
		For k = 1 To UpperBound(al_clause_id[])
			ldec_revision = inv_clause.of_get_revision( al_clause_id[k] )

			ls_clausename = inv_clause.of_generate_name( al_clause_id[k], ldec_revision) //Modified By Ken.Guo 2010-01-11
			If Not FileExists(ls_clausename) Then
				inv_clause.of_download_file( al_clause_id[k], ldec_revision, ls_clausename)
			End If
			If Not FileExists(ls_clausename) Then
				Messagebox('Update Template','Failed to download the clause file, please try again.')
				Return -1
			End If
			ls_bookmark = "clause_" + string(al_clause_id[k])
			Select page_break,append_paragraph into :ll_pagebreak,:ll_AppendParagraph From ctx_acp_clause Where ctx_acp_clause_id = :al_clause_id[k];


			//If Not lole_template.bookmarks.Exists(ls_bookmark) Then Continue jervis 06.08.2009
			If Not lole_template.content.bookmarks.Exists(ls_bookmark) Then Continue
			
			IF IsValid(w_appeon_gifofwait) THEN	w_appeon_gifofwait.st_1.Text = "Updating template files with clause #"+String(al_clause_id[k])+"..."
			
			if ai_type = 1 then //For Clause Update - jevis 01.30.2010
				//-------Begin Moidified by Alfee 05.29.2007------------------------------
				ll_start_ori = lole_template.content.bookmarks.item(ls_bookmark).start
				ll_len_ori = lole_template.content.bookmarks.item(ls_bookmark).end - ll_start_ori
						
				lole_template.content.bookmarks.item(ls_bookmark).select()
				lole_template.activewindow.selection.collapse(wdCollapseStart)
				//--------Begin Added by Alfee 01.18.2008-----------------------------
				//<$Reason>for the case of adding content before an existed table
				IF lole_template.activewindow.selection.tables.count > 0 THEN 
					lole_template.activewindow.selection.InsertBreak(wdSectionBreakContinuous)	
					lole_template.activewindow.selection.Start = ll_start_ori
					lole_template.activewindow.selection.End = lole_template.content.bookmarks.item(ls_bookmark).End
					lole_template.activewindow.selection.collapse(wdCollapseStart)			
				END IF			
				//--------End Added --------------------------------------------------				
				If ll_pagebreak = 1 Then 
					lole_template.activewindow.selection.insertbreak(wdSectionBreakNextPage)	//added by alfee at 05.29.2007
				End If
				If ll_AppendParagraph = 1 Then 
					lole_template.activewindow.selection.TypeParagraph() 
					//lole_template.activewindow.selection.InsertParagraphAfter()
				End If
				lole_template.activewindow.selection.InsertFile(ls_clausename)
				lole_template.activewindow.selection.Expand()
		
				ll_end_new = lole_template.content.bookmarks.item(ls_bookmark).end
				lole_template.range(ll_end_new - ll_len_ori, ll_end_new).Delete()
			end if
			
	
			//---------End Modified ----------------------------------------------		
			
//			//Update Clause Text Color and Word comment  - jervis 01.40.2010
//			lnv_word.of_update_clausecolor( lole_template, al_clause_id[k])
//			if ai_type = 1 then //For Clause Update - jevis 01.30.2010
//				lnv_word.of_update_wordcomment( lole_template, al_clause_id[k])
//			end if
		Next
		
		//Modified By Ken.Guo 07/30/2012
		lnv_word.of_update_clausecolor( lole_template, al_clause_id[])
		if ai_type = 1 then //For Clause Update - jevis 01.30.2010
			lnv_word.of_update_wordcomment( lole_template, al_clause_id[])
		end if
		
		lole_template.Close(wdSaveChanges)

		//Update tempate file into DB
		ll_ret = lnv_word.of_put_template_file(al_template_id[j], DateTime(Today(), Now()),adt_lastupdate[j]) 
		If ll_ret < 0 Then
			//MessageBox("Warning","Update template file(s) failed!", exclamation!)
			//Quit Word application
			lole_word.Quit(0)
			lole_word.DisconnectObject( )
			Destroy lole_template
			Destroy lole_word
			Destroy lnv_word				
			Return ll_ret
		END IF		
	NEXT

	//Quit Word application
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_template
	Destroy lole_word
	Destroy lnv_word	

Catch( Throwable th)
	f_word_destroy(lole_word, "") //Alfee 01.17.2008
	Destroy lole_template
	//Destroy lole_word //Alfee 01.17.2008
	Destroy lnv_word	
	//MessageBox("Warning","Update template file(s) failed! " + th.text, exclamation!)	
	Return -1 
End Try

Return 1
end function

public function boolean of_checkmultiselect ();//====================================================================
// Function: of_checkmultiselect
//--------------------------------------------------------------------
// Description: Check user whether selected multi clauses.
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 08/06/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_cnt, i, ll_row

ll_cnt = tabpage_browse.dw_browse.RowCount()

ll_row = tabpage_browse.dw_browse.GetSelectedrow(0)
If ll_row > 0 and ll_row <> ll_cnt Then
	ll_row = tabpage_browse.dw_browse.GetSelectedrow(ll_row)
	If ll_row > 0 Then 
		Return True
	End If
End If

Return False
end function

on u_tab_agreement_clause_painter.create
this.tabpage_browse=create tabpage_browse
this.tabpage_clause=create tabpage_clause
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_browse
this.Control[iCurrent+2]=this.tabpage_clause
end on

on u_tab_agreement_clause_painter.destroy
call super::destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_clause)
end on

event constructor;call super::constructor;long 		ll_i
String	ls_ObjName

iw_clause_painter = iw_parent
this.of_SetResize (TRUE)

FOR ll_i =  1 TO UPPERBOUND(this.Control)
   this.inv_resize.of_Register (Control[ll_i] , inv_resize.scale)
NEXT

FOR ll_i = 1 TO UPPERBOUND(tabpage_browse.Control)
	ls_ObjName = tabpage_browse.Control[ll_i].ClassName()
	if ls_ObjName = "pb_attrifilter" or ls_ObjName = "cb_go" or ls_ObjName = "cb_clear" then
		this.inv_resize.of_Register (tabpage_browse.Control[ll_i], inv_resize.FIXEDRIGHT  )
	elseif ls_ObjName = "dw_filter" then
		this.inv_resize.of_Register (tabpage_browse.Control[ll_i], inv_resize.scaleright  )
	else
		this.inv_resize.of_Register (tabpage_browse.Control[ll_i], inv_resize.scale)
	end if
NEXT

inv_clause_comparison = Create n_cst_clause_comparison //Added by Alfee 10.18.2007
inv_word_utility = Create n_cst_word_utility //Alfee 09.22.2008

//Added By Ken.Guo 2009-12-30.
inv_clause = Create n_cst_clause 
inv_ole_utils_doc = Create n_cst_ovole_utils  
inv_ole_utils_doc.of_initial(tabpage_clause.ole_1)

ids_clause_info = Create DataStore
ids_clause_info.DataObject = 'd_clauses_info'
ids_clause_info.SettransObject(SQLCA)

of_RefreshFilterPicture()				//Added by Scofield on 2010-01-15

of_get_auto_retrieve()				//Added By Mark Lee 07/18/12

end event

event selectionchanged;call super::selectionchanged;
If newindex = 1 Then
	If isvalid(m_pfe_cst_clause_painter) Then
		If m_pfe_cst_clause_painter.m_file.m_save.enabled = True Then
			//iw_clause_painter.event pfc_save() //Commented By Ken.Guo 2010-01-11
		End If
		of_set_menu(newindex)
		tabpage_browse.dw_browse.setfocus()
	End If
End If

If newindex = 2 Then
	If Not ib_showed Then
		gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06
		ib_showed = True
	End If
	If of_open_word_file() = 1 Then
		is_type = 'C' //Added By Ken.Guo 2010-01-29.
		If isvalid(m_pfe_cst_clause_painter) Then
			of_set_menu(newindex)	
		End If
	End If
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 21-03-2007 By: Ken.Guo
	//$<reason> Fix Issue: Need set focus to Word Document when add a clause.
	//Must POST ue_setfocus_ole event.
	post event ue_setfocus_ole( )	
	//---------------------------- APPEON END ----------------------------
	
End If

end event

event destructor;call super::destructor;Destroy inv_clause_comparison //Added by Alfee 10.18.2007
Destroy inv_word_utility //Alfee 09.22.2008

If isvalid(inv_clause) Then Destroy inv_clause
If isvalid(inv_ole_utils_doc) Then Destroy inv_ole_utils_doc
If isvalid(ids_clause_info) Then Destroy ids_clause_info
end event

type tabpage_browse from userobject within u_tab_agreement_clause_painter
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3995
integer height = 1968
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Browse!"
long picturemaskcolor = 536870912
dw_clause_full_analysis dw_clause_full_analysis
pb_attrifilter pb_attrifilter
st_1 st_1
dw_filter dw_filter
dw_browse dw_browse
tv_clause tv_clause
cb_clear cb_clear
cb_go cb_go
gb_1 gb_1
st_tip st_tip
end type

on tabpage_browse.create
this.dw_clause_full_analysis=create dw_clause_full_analysis
this.pb_attrifilter=create pb_attrifilter
this.st_1=create st_1
this.dw_filter=create dw_filter
this.dw_browse=create dw_browse
this.tv_clause=create tv_clause
this.cb_clear=create cb_clear
this.cb_go=create cb_go
this.gb_1=create gb_1
this.st_tip=create st_tip
this.Control[]={this.dw_clause_full_analysis,&
this.pb_attrifilter,&
this.st_1,&
this.dw_filter,&
this.dw_browse,&
this.tv_clause,&
this.cb_clear,&
this.cb_go,&
this.gb_1,&
this.st_tip}
end on

on tabpage_browse.destroy
destroy(this.dw_clause_full_analysis)
destroy(this.pb_attrifilter)
destroy(this.st_1)
destroy(this.dw_filter)
destroy(this.dw_browse)
destroy(this.tv_clause)
destroy(this.cb_clear)
destroy(this.cb_go)
destroy(this.gb_1)
destroy(this.st_tip)
end on

type dw_clause_full_analysis from u_dw_contract within tabpage_browse
boolean visible = false
integer x = 3447
integer y = 16
integer width = 224
integer height = 80
integer taborder = 31
string dataobject = "d_clauses_painter_browse_new"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_allow_save = false
end type

event constructor;call super::constructor;This.of_setupdateable(False)
end event

type pb_attrifilter from picturebutton within tabpage_browse
integer x = 3909
integer y = 108
integer width = 498
integer height = 88
integer taborder = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Attribute &Filter..."
alignment htextalign = right!
vtextalign vtextalign = vcenter!
boolean map3dcolors = true
end type

event clicked;String	ls_ClauseExp

str_clause_filter	lstr_ClauseFilter

OpenWithParm(w_clause_attribute_filter,istr_ClauseFilter)

lstr_ClauseFilter = Message.PowerObjectParm
if lstr_ClauseFilter.Clause_Exp <> "Cancel" then
	istr_ClauseFilter = lstr_ClauseFilter
	ls_ClauseExp = istr_ClauseFilter.Clause_Exp
	
	if ls_ClauseExp <> "" then
		dw_Browse.SetFilter("ctx_acp_clause_id in " + ls_ClauseExp)
	else
		dw_Browse.SetFilter("")
	end if
	
	dw_Browse.Filter()
	
	of_create_clause_tree()
end if

of_RefreshFilterPicture()

end event

type st_1 from u_st_splitbar within tabpage_browse
integer x = 1134
integer y = 248
integer width = 18
integer height = 1704
end type

event constructor;call super::constructor;//Add by jervis 09.10.09
this.of_register( tv_clause, this.left )
this.of_register( dw_browse, this.right )

end event

type dw_filter from u_dw_contract within tabpage_browse
event pfc_go ( )
integer x = 14
integer y = 56
integer width = 3319
integer height = 160
integer taborder = 21
string dataobject = "d_contract_management_clauses_filter"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event pfc_go();//Parent.Event pfc_cst_go()

end event

event constructor;call super::constructor;datawindowchild child


This.Event ue_populatedddws()
this.of_setdropdowncalendar(true)

This.of_setupdateable(False)

This.getchild('approved_by',child)
child.settransobject(sqlca)

This.GetChild('folder_name',idwc_folder)
idwc_folder.settransobject(sqlca)

gnv_appeondb.of_startqueue( )
child.retrieve()
idwc_folder.retrieve()
gnv_appeondb.of_commitqueue( )

idwc_folder.insertrow(1)
child.insertrow(1)

This.insertrow(0)

This.setfocus()
//Begin - Added By Mark Lee 07/13/12
//If gs_dbtype = "SQL" And gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' Then
//	dw_filter.object.clause_name_t.text = 'Full Text Search'
//Else
//	dw_filter.object.clause_name_t.text = 'Clause Name'
//End If
//End - Added By Mark Lee 07/13/12

//Added By Mark Lee 07/16/12
tabpage_browse.dw_filter.setItem(tabpage_browse.dw_filter.getRow(),'textsearch_dddw','AND')
end event

event itemchanged;call super::itemchanged;//Commented By Ken.Guo 2010-12-20
//if lower(dwo.name) = "category" then
//	this.accepttext()
//	//---------Begin Modified by Alfee 01.08.2007---------
//	//<$Reason>Triggered in ue_postitemchanged() if -777
//	IF data <> '-777' THEN
//		cb_go.event clicked()
//	END If
//	//cb_go.event clicked()
//	//---------End Modified ------------------------------
//end if
//
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

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added by Alfee 01.08.2008
IF data = '-777' THEN 
	cb_go.Post Event Clicked()
END IF

end event

event resize;call super::resize;//long	ll_ButtonY
//
//ll_ButtonY = This.Y + long(This.Describe("Category.Y")) - 15
//
//cb_Go.Y          = ll_ButtonY
//cb_Clear.Y       = ll_ButtonY
//pb_AttriFilter.Y = ll_ButtonY
//
end event

type dw_browse from u_dw_contract within tabpage_browse
event pfc_save ( )
event pfc_rules ( )
event ue_hide_tip ( )
event ue_resize ( )
integer x = 1147
integer y = 248
integer width = 3310
integer height = 1704
integer taborder = 41
string dataobject = "d_clauses_painter_browse_new"
boolean hscrollbar = true
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
boolean ib_use_row_selection = true
boolean ib_allow_filter = true
boolean ib_allow_sort = true
end type

event pfc_rules();iw_clause_painter.Event pfc_cst_rules()

end event

event ue_hide_tip();st_tip.visible = False
end event

event ue_resize();st_tip.height = 52
st_tip.width = 1417
st_tip.x = this.x + Long(This.Describe( 'category.x')) + 30
st_tip.y = this.y - 32
end event

event constructor;call super::constructor;datawindowchild child
long ll_find

This.Event ue_populatedddws()
This.getchild('ctx_acp_folder_id',idw_child)
idw_child.settransobject(sqlca)

/* //Commented By Ken.Guo 2010-01-05
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
*/
This.of_setupdateable(False) //Added By Ken.Guo 2010-01-05.
is_old_sql = This.getsqlselect()

//Added By Ken.Guo 07/29/2012
this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.extended )


end event

event doubleclicked;call super::doubleclicked;If This.rowcount() > 0 Then
	If of_open_word_file() = 1 Then
		selecttab(2)
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

event rbuttonup;m_dw_clause lm_dw


lm_dw = Create m_dw_clause
lm_dw.of_SetParent (This)
This.accepttext()

of_set_menu(1) //Added By Ken.Guo 2010-01-13.


lm_dw.m_table.m_addrow.visible = True
If This.rowcount() < 1 Then
	lm_dw.m_table.m_copy.visible = False //Copy Clause
	lm_dw.m_table.m_delete.visible = False
	lm_dw.m_table.m_save.visible = False
	lm_dw.m_table.m_rules.visible = False
	lm_dw.m_table.m_properties.visible = False
Else
	//Added By Ken.Guo 2010-01-12.Only Parent level can show popup menu.
	If This.getrow() > 0 Then
		If tabpage_browse.dw_browse.GetItemNumber(This.getrow(), "level") = 2 Then
			Return 
		End If
	End If
	
	is_type = 'C' 
	is_click = 'dw'
	il_handle = 0
	il_handle1 = 0
	il_category	= This.getitemnumber(This.getrow(),'category')
	il_ctx_acp_folder_id = This.getitemnumber(This.getrow(),'ctx_acp_folder_id')
	il_ctx_acp_clause_id = This.getitemnumber(This.getrow(),'ctx_acp_clause_id')
	//--------Begin Added by Alfee 01.07.2008-----------------------------------
	//<$Reason>If the 1st record right clicked which is initially selected, the below
	//<$Reason>statement called in rowfocuschanged() event will not be called...
	is_data = string(il_ctx_acp_clause_id) + '-' + 'C'
	//--------End Added --------------------------------------------------------

//Commented By Ken.Guo 2010-01-13
//	If isvalid(m_pfe_cst_clause_painter) Then
//		m_pfe_cst_clause_painter.m_file.m_addclause.enabled = True
//		m_pfe_cst_clause_painter.m_view.m_rules.enabled = True
//		m_pfe_cst_clause_painter.m_file.m_properties.enabled = True
//		m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = True
//	End If
//	lm_dw.m_table.m_delete.visible = False
//	lm_dw.m_table.m_save.visible = False
//	lm_dw.m_table.m_rules.visible = True
//	lm_dw.m_table.m_properties.visible = True	

	//Added By Ken.Guo 2010-01-13.
	If m_pfe_cst_clause_painter.m_file.m_addclause.enabled and m_pfe_cst_clause_painter.m_file.m_addclause.toolbaritemvisible Then
		lm_dw.m_table.m_addrow.visible = True
	Else
		lm_dw.m_table.m_addrow.visible = False
	End If
	
	If m_pfe_cst_clause_painter.m_file.m_copyclause.enabled and m_pfe_cst_clause_painter.m_file.m_copyclause.toolbaritemvisible Then
		lm_dw.m_table.m_copy.visible = True
	Else
		lm_dw.m_table.m_copy.visible = False
	End If	

	If m_pfe_cst_clause_painter.m_edit.m_delete1.enabled and m_pfe_cst_clause_painter.m_edit.m_delete1.toolbaritemvisible Then
		lm_dw.m_table.m_delete.visible = True
	Else
		lm_dw.m_table.m_delete.visible = False
	End If
	
	
	If m_pfe_cst_clause_painter.m_file.m_output0.m_email.enabled and m_pfe_cst_clause_painter.m_file.m_output0.m_email.toolbaritemvisible Then
		lm_dw.m_table.m_mailaspdf.visible = True
	Else
		lm_dw.m_table.m_mailaspdf.visible = False
	End If	
	
	If m_pfe_cst_clause_painter.m_file.m_output0.m_saveas.enabled and m_pfe_cst_clause_painter.m_file.m_output0.m_saveas.toolbaritemvisible Then
		lm_dw.m_table.m_saveaspdf.visible = True
	Else
		lm_dw.m_table.m_saveaspdf.visible = False
	End If	

	If m_pfe_cst_clause_painter.m_file.m_check.m_checkin.enabled and m_pfe_cst_clause_painter.m_file.m_check.m_checkin.toolbaritemvisible Then
		lm_dw.m_table.m_checkinout.visible = True
		lm_dw.m_table.m_checkinout.text = m_pfe_cst_clause_painter.m_file.m_check.m_checkin.toolbaritemtext
	End If
	If m_pfe_cst_clause_painter.m_file.m_check.m_checkout.enabled and m_pfe_cst_clause_painter.m_file.m_check.m_checkout.toolbaritemvisible Then
		lm_dw.m_table.m_checkinout.visible = True
		lm_dw.m_table.m_checkinout.text = m_pfe_cst_clause_painter.m_file.m_check.m_checkout.toolbaritemtext
	End If

	If m_pfe_cst_clause_painter.m_view.m_rules.enabled and m_pfe_cst_clause_painter.m_view.m_rules.toolbaritemvisible Then
		lm_dw.m_table.m_rules.visible = True
	Else
		lm_dw.m_table.m_rules.visible = False
	End If
	
	If m_pfe_cst_clause_painter.m_file.m_properties.enabled and m_pfe_cst_clause_painter.m_file.m_properties.toolbaritemvisible Then
		lm_dw.m_table.m_properties0.visible = True
	Else
		lm_dw.m_table.m_properties0.visible = False
	End If

	//Added By Ken.Guo 07/30/2012
	If m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc.enabled and m_pfe_cst_clause_painter.m_file.m_options.m_batchupdatedoc.toolbaritemvisible Then
		lm_dw.m_table.m_batchupdate.visible = True
	Else
		lm_dw.m_table.m_batchupdate.visible = False
	End If

End If


lm_dw.iw_parent = iw_parent //Added By Ken.Guo 2010-01-18.
lm_dw.m_table.PopMenu (w_mdi.PointerX(),w_mdi.PointerY()) 

Destroy lm_dw

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

event clicked;call super::clicked;
//Added By Ken.Guo 2010-01-08.
//Override Ancestor Script. 
If dwo.type = 'text' Then
	of_collapse_all()
	IF Pos( dwo.name,'_t' ) <= 0 Then 
		Super::EVENT clicked(xpos,ypos,row,dwo)		//Added By Mark Lee 04/19/2013 this is trigger the sort event again.
	End IF 
End If

//-----Begin Modified by Alfee om 03.11.2008-----
//<Reason>in case of clicking on the column header 
If row > 0 Then
//If This.getrow() > 0 then
//-----End Modified -----------------------------
//	This.SelectRow(0, FALSE)
//   This.SelectRow(This.getrow(), TRUE)
	is_type = 'C' 
	is_click = 'dw'
	il_handle = 0
	il_handle1 = 0
	il_category	= This.getitemnumber(This.getrow(),'category')
	il_ctx_acp_folder_id = This.getitemnumber(This.getrow(),'ctx_acp_folder_id')
	il_ctx_acp_clause_id = This.getitemnumber(This.getrow(),'ctx_acp_clause_id')
	is_data = string(il_ctx_acp_clause_id) + '-' + 'C'

End If


//Added By Ken.Guo 2010-01-11.
Long ll_clause_id
Long li_rows,li_new,li
String ls_flag

if row < 1 then return
ll_clause_id = this.getitemnumber(row,'ctx_acp_clause_id')
if dwo.name='p_1' then
	SetPointer(HourGlass!) 
	This.Setredraw( false )

	n_ds  ds_audit
	
	ds_audit = create n_ds 
	ds_audit.dataobject = 'd_clauses_audit_all'
	ds_audit.settransobject( sqlca)
	li_rows = ds_audit.retrieve( ll_clause_id)
	li_new = row+1
	for li = 1 to li_rows
		li_new = this.insertrow(li_new)
		this.setitem(li_new,'row',li_new)
		this.setitem(li_new,'ctx_acp_clause_id',ll_clause_id)
		this.setitem(li_new,'level',2)		
		this.setitem(li_new,'clause_name',this.getitemstring(row,'clause_name'))
		this.setitem(li_new,'revision',this.getitemdecimal(row,'revision'))
		this.setitem(li_new,'audit_version',ds_audit.getitemdecimal(li,'revision'))
		this.setitem(li_new,'audit_status',ds_audit.getitemstring(li,'actions'))
		this.setitem(li_new,'audit_date',ds_audit.getitemdatetime(li,'action_date'))
		this.setitem(li_new,'audit_user',ds_audit.getitemstring(li,'action_by'))
		this.setitem(li_new,'audit_note',ds_audit.getitemstring(li,'notes'))
		this.setitem(li_new,'category',il_category)
		this.setitem(li_new,'ctx_acp_folder_id',il_ctx_acp_folder_id)

		//Restore the comparison flag
		If isvalid(inv_clause_comparison) and isvalid(w_clause_comparison_wizard) Then
			ls_flag = inv_clause_comparison.of_get_flag( ll_clause_id, ds_audit.getitemdecimal(li,'revision'))
			this.setitem(li_new,'compare_status',ls_flag)			
		End If
		li_new = li_new+1
	next
	this.setitem(row,'style','-')
	destroy ds_audit

	This.Setredraw( true )
elseif dwo.name='p_2' then
	of_collapse_row(ll_clause_id, row)
elseif IsValid(inv_clause_comparison) then 
	inv_clause_comparison.of_select_clause(row)	 //Added By Ken.Guo 2010-01-30.
end if

end event

event rowfocuschanged;call super::rowfocuschanged;If This.rowcount() > 0 then
	If is_type = 'C' Then
//		This.SelectRow(0, FALSE)
//		This.SelectRow(currentrow, TRUE)
	End If
	If currentrow > 0 Then
		il_category	= This.getitemnumber(This.getrow(),'category')
		il_ctx_acp_folder_id = This.getitemnumber(This.getrow(),'ctx_acp_folder_id')
		il_ctx_acp_clause_id = This.getitemnumber(This.getrow(),'ctx_acp_clause_id')
		
		inv_clause.Post of_check_name(This.GetItemString(This.getrow(),'clause_name')) //Added By Ken.Guo 2010-01-13.
		
		//Added By Ken.Guo 2009-12-31.
		If tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 Then
			idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'audit_version')
		Else
			idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision')
		End If
		
		is_data = string(il_ctx_acp_clause_id) + '-' + 'C'
		
		//Begin - Modified By Ken.Guo 2010-01-13
		/* 
		//Add by jervis 12.28.2009
		If isvalid(m_pfe_cst_clause_painter) Then		
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', True)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', True)		
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', True)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)	
			If w_mdi.of_security_access(6800) < 2 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
			End If
		end if	
		*/
		of_set_menu(1)
		//End - Modified By Ken.Guo 2010-01-13
	End If
End If

iw_clause_painter.of_changetitle() 	//added by alfee 08.24.2007

//of_RefreshFieldLabel()					//Added by Scofield on 2010-01-19

end event

event retrieveend;call super::retrieveend;of_RefreshClauseAttribute("")

end event

event resize;call super::resize;Dynamic Post Event ue_resize()
end event

type tv_clause from u_tvs within tabpage_browse
event pfc_addfolder ( )
event pfc_addclause ( )
event pfc_rules ( )
event pfc_copyclause ( )
event pfc_export ( )
event pfc_export_single ( )
integer y = 248
integer width = 1134
integer height = 1704
integer taborder = 41
fontcharset fontcharset = ansi!
long backcolor = 33551856
boolean linesatroot = true
boolean hideselection = false
boolean fullrowselect = true
string picturename[] = {"custom039!","Custom050!","CheckDiff!","Next!","sectiongreen.bmp","Properties!"}
string statepicturename[] = {"CheckMark.bmp","Check.bmp"}
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

event pfc_copyclause();//iw_clause_painter.Event pfc_cst_add_clause()
of_Copy()


end event

event pfc_export();//Add by jervis 11.10.2009
//Export clause to doc file
of_export('tv')
end event

event pfc_export_single();of_export_single()


end event

event clicked;call super::clicked;integer li_position,li_msg
long ll_ctx_acp_folder_id,ll_handle,ll_category,ll_parent_category,ll_ctx_acp_clause_id
string ls_type,ls_type1,ls_data,ls_file_name
treeviewitem tvi_click
dw_browse.SelectRow(0, FALSE)

of_collapse_all() //Added By Ken.Guo 2010-01-12.
This.getitem(handle,tvi_click)
ls_data = string(tvi_click.data)
This.SelectItem (handle)
If isnull(ls_data) Or ls_data = '0' Or ls_data = '' Then 
	il_ctx_acp_folder_id = 0
	il_ctx_acp_clause_id = 0
	il_category = 0
	il_parent_folder_id = 0
	//il_handle = 0
	il_handle = handle	//jervis 11.10.2009
	il_handle1 = 0
	is_type = ''
	is_types = ''
	dw_browse.setfilter('')
	dw_browse.filter()
	
	/*
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'enabled', False) //jervis 10.10.2009
	End If
	*/
	
	//Added By Ken.Guo 2010-01-04.
	If dw_browse.getrow() > 0 Then
		il_category	= dw_browse.getitemnumber(dw_browse.getrow(),'category')
		il_ctx_acp_folder_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_folder_id')
		il_ctx_acp_clause_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_clause_id')
		If tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 Then
			idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'audit_version')
		Else
			idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision')
		End If
	End If
	
	Return
End If
is_click = 'tv'

/*
If isvalid(m_pfe_cst_clause_painter) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', True)
End If
*/

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
	/*
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'enabled', False) //jervis 10.10.2009
	End If
	*/
ElseIf ls_type = 'C' Then
	dw_browse.setfilter("ctx_acp_clause_id = " + string(ll_ctx_acp_folder_id))
	dw_browse.filter()
	
	is_types = 'Update'
	If dw_browse.rowcount() > 0 Then
		is_clause_name = dw_browse.getitemstring(dw_browse.getrow(),'clause_name')
		/*
		If isvalid(m_pfe_cst_clause_painter) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_copyclause,'enabled', true) //jervis 10.10.2009
		End If
		*/
	End If
	ll_ctx_acp_clause_id = 	ll_ctx_acp_folder_id		
	il_ctx_acp_folder_id = il_parent_folder_id
	il_category = ll_parent_category
	il_ctx_acp_clause_id = ll_ctx_acp_clause_id
	il_handle1 = il_handle	
End If

/*
//-------Begin Added by Alfee 09.20.2007--------
If isvalid(m_pfe_cst_clause_painter) and w_mdi.of_security_access(6800) < 2 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
End If
//-------End Added------------------------------
*/

//-------Begin Added by Alfee 10.18.2007--------
//For clause comparison functionality
If IsValid(inv_clause_comparison) Then 
	If ls_type = 'C' Then //Add this condition by Ken.Guo 2009-01-05
		inv_clause_comparison.of_select_clause(handle,il_ctx_acp_clause_id)
	End If
End If
//-------End Added------------------------------

//Added By Ken.Guo 2010-01-04.
If dw_browse.getrow() > 0 Then
	il_category	= dw_browse.getitemnumber(dw_browse.getrow(),'category')
	il_ctx_acp_folder_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_folder_id')
	il_ctx_acp_clause_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_clause_id')
	If tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 Then
		idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'audit_version')
	Else
		idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision')
	End If
End If	

of_set_menu(1)
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

ids_ctx_am_document_clause = Create datastore
ids_ctx_am_document_clause.dataobject = 'd_ctx_am_document_clause'
ids_ctx_am_document_clause.settransobject(sqlca)

//BEGIN---Modify by Scofield on 2010-01-07
ids_AttriValue = Create DataStore
ids_AttriValue.DataObject = "d_acp_clause_attr_val_list"
ids_AttriValue.SetTransObject(SQLCA)
//END---Modify by Scofield on 2010-01-07

//Begin - Added By Mark Lee 07/18/12
//of_create_clause_tree()
If ib_autoretrieve Then
	of_create_clause_tree()
End If 
//End - Added By Mark Lee 07/18/12


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
If ltvi_item.PictureIndex = 6 Then
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
This.SelectItem ( handle )

// we have clicked on an item
If handle > 0 Then
	lm_view.m_viewitem.m_addclause.visible = True
	lm_view.m_viewitem.m_delete1.visible = True
	lm_view.m_viewitem.m_rules.visible = True
	lm_view.m_viewitem.m_copyclause.visible = True //jervis 10.10.2009
	lm_view.m_viewitem.m_properties1.visible = True	
Else
	// We are Not on an item
	lm_view.m_viewitem.m_addclause.visible = False
	lm_view.m_viewitem.m_delete1.visible = False
	lm_view.m_viewitem.m_rules.visible = False
	lm_view.m_viewitem.m_properties1.visible = False	
	lm_view.m_viewitem.m_copyclause.visible = false //jervis 10.10.2009
End If
If il_ctx_acp_folder_id = 0 Then
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_delete1,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_rules,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_copyclause,'enabled', false) //jervis 10.10.2009
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_properties1,'enabled', False)	
Else	
	If is_type = 'C' Then
		gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_rules,'enabled', True)
		gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_copyclause,'enabled', true) //jervis 10.10.2009
	Else
		gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_rules,'enabled', False)
		gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_copyclause,'enabled', false) //jervis 10.10.2009
	End If	
End If	

//Begin - Modified By Ken.Guo 2010-01-18
/*
//-------Begin Added by Alfee 09.20.2007--------
If w_mdi.of_security_access(6800) < 2 Then
		gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_addfolder,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_delete1,'enabled', False)
End If
//-------End Added------------------------------
*/
//Add Folder
If w_mdi.of_security_access(6800) < 2 or w_mdi.of_security_access(6959) = 0 Then  //Main module or Add Folder sub module.
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_addfolder,'enabled', False)	
End If

Choose Case ltvi_item.PictureIndex
	Case 1 //For Folder Item
		gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_rules,'enabled', False)
		gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_copyclause,'enabled', false)
		
		//Add Clause
		If m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False or m_pfe_cst_clause_painter.m_file.m_addclause.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_addclause,'enabled', False)
		End If	

		//Delete
		If m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False or m_pfe_cst_clause_painter.m_edit.m_delete1.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_delete1,'enabled', False)
		End If		
		
		//Properties
		If m_pfe_cst_clause_painter.m_file.m_properties.enabled = False or m_pfe_cst_clause_painter.m_file.m_properties.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_properties1,'enabled', False)	
		End If

	Case 4 //For Clause Item
		//Copy Clause
		If m_pfe_cst_clause_painter.m_file.m_copyclause.enabled = False or m_pfe_cst_clause_painter.m_file.m_copyclause.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_copyclause,'enabled', false)
		End If			
		
		//Add Clause
		If m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False or m_pfe_cst_clause_painter.m_file.m_addclause.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_addclause,'enabled', False)
		End If	

		//Delete
		If m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False or m_pfe_cst_clause_painter.m_edit.m_delete1.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_delete1,'enabled', False)
		End If		
		
		//Rules
		If m_pfe_cst_clause_painter.m_view.m_rules.enabled = False or m_pfe_cst_clause_painter.m_view.m_rules.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_rules,'enabled', False)
		End If
		
		//Properties
		If m_pfe_cst_clause_painter.m_file.m_properties.enabled = False or m_pfe_cst_clause_painter.m_file.m_properties.toolbaritemvisible = False Then
			gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_properties1,'enabled', False)	
		End If		
		
End Choose
//End - Modified By Ken.Guo 2010-01-18

If dw_browse.RowCount() = 0 Then
	gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_exportclausetosamefile,'enabled', False)
End If

lm_view.m_viewitem.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

If IsValid(lm_view) Then Destroy lm_view

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
		If of_open_word_file() = 1 Then
			selecttab(2)
		End If
	End If
End If
end event

event selectionchanged;call super::selectionchanged;integer li_position,li_msg
long ll_ctx_acp_folder_id,ll_handle,ll_category,ll_parent_category,ll_ctx_acp_clause_id
string ls_type,ls_type1,ls_data,ls_file_name
treeviewitem tvi_click
dw_browse.SelectRow(0, FALSE)

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 10.22.2007 By: Evan
//$<Reason> Add clause usage.
long ll_Zero[]
if dw_browse.RowCount() > 0 then
	ll_Zero[dw_browse.RowCount()] = 0
	//Added By Mark Lee 03/14/2013 comment by new function .
//	dw_browse.object.temp_usage[1,dw_browse.RowCount()] = ll_Zero[]
//	dw_browse.object.dm_usage[1,dw_browse.RowCount()] = ll_Zero[]
	dw_browse.ResetUpdate()
end if
is_TreeItemType = "ROOT"
//---------------------------- APPEON END ----------------------------

of_collapse_all() //Added By Ken.Guo 2010-01-12.

This.getitem(newhandle,tvi_click)
ls_data = string(tvi_click.data)
is_data = ls_data
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
	
	/*
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)	
	End If
	*/
	
	//added by alfee 08.24.2007
	dw_browse.setredraw(false)
	if dw_browse.RowCount() > 0 then
		dw_browse.SelectRow(0, false) 
		dw_browse.SetRow(1)
		dw_browse.ScrollTorow( 1)
		dw_browse.SelectRow(1, True) 
	end if
	dw_browse.setredraw(true)	
	iw_clause_painter.of_changetitle() 	
	
	//Added By Ken.Guo 2010-01-04.
	If dw_browse.getrow() > 0 Then
		il_category	= dw_browse.getitemnumber(dw_browse.getrow(),'category')
		il_ctx_acp_folder_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_folder_id')
		il_ctx_acp_clause_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_clause_id')
		If tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 Then
			idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'audit_version')
		Else
			idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision')
		End If
	End If
	
	Return
End If

is_click = 'tv'
/*
If isvalid(m_pfe_cst_clause_painter) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', True)
End If
*/

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
	/*
	If isvalid(m_pfe_cst_clause_painter) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
	End If
	*/
	is_TreeItemType = "FOLDER"//added by evan at 10.23.2007
ElseIf ls_type = 'C' Then
	dw_browse.setfilter("ctx_acp_clause_id = " + string(ll_ctx_acp_folder_id))
	dw_browse.filter()
	
	is_types = 'Update'
	If dw_browse.rowcount() > 0 Then
		is_clause_name = dw_browse.getitemstring(dw_browse.getrow(),'clause_name')
		/*
		If isvalid(m_pfe_cst_clause_painter) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', True)
		End If
		*/
	End If
	ll_ctx_acp_clause_id = 	ll_ctx_acp_folder_id		
	il_ctx_acp_folder_id = il_parent_folder_id
	il_category = ll_parent_category
	il_ctx_acp_clause_id = ll_ctx_acp_clause_id
	il_handle1 = il_handle
	is_TreeItemType = "CLAUSE"//added by evan at 10.23.2007
End If

/*
//-------Begin Added by Alfee 09.20.2007--------
If isvalid(m_pfe_cst_clause_painter) and w_mdi.of_security_access(6800) < 2 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
End If
//-------End Added------------------------------
*/

//added by alfee at 05.21.2007	
dw_browse.setredraw(false)
if dw_browse.RowCount() > 0 then
	dw_browse.SelectRow(0, false) 
	dw_browse.ScrollTorow( 1)
	dw_browse.SelectRow(1, True) 
end if
dw_browse.setredraw(true)

iw_clause_painter.of_changetitle() //added by alfee 08.24.2007

//Added By Ken.Guo 2010-01-04.
If dw_browse.getrow() > 0 Then
	il_category	= dw_browse.getitemnumber(dw_browse.getrow(),'category')
	il_ctx_acp_folder_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_folder_id')
	il_ctx_acp_clause_id = dw_browse.getitemnumber(dw_browse.getrow(),'ctx_acp_clause_id')
	If tabpage_browse.dw_browse.getitemnumber(tabpage_browse.dw_browse.getrow(),'level') = 2 Then
		idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'audit_version')
	Else
		idec_revision = tabpage_browse.dw_browse.getitemdecimal(tabpage_browse.dw_browse.getrow(),'revision')
	End If
End If

of_set_menu(1)
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
String				ls_Data

ll_cause_handle = handle


IF this.GetItem( handle, ltrvi_item ) = 1 Then
	ls_Data =  string( ltrvi_item.data)
	If  ltrvi_item.Children And Right( ls_Data, 2 ) <> '-C' and Right( ls_Data , 2 ) <> '-P'  Then
		SetPointer( hourglass! )
		ll_Child = FindItem( ChildTreeItem!, handle )
		do while ll_Child > 0 
			ll_cause_handle = ll_Child
			If  GetItem( ll_Child, ltrvi_child  ) = 1 Then
				ls_Data = ltrvi_child.data
			
				If IsNumber( Left( ls_Data, len( ls_Data ) -2 ) ) Then 
					ll_clause_id =  Long( Left( ls_Data, len( ls_Data ) -2 ) )
					of_Create_Clause_Attribute(ll_clause_id,ll_cause_handle )	
				End If
			End If
			ll_Child = FindItem( NextTreeItem!, ll_cause_handle )
		loop
		SetPointer( arrow! )
	End If
End If
	

end event

type cb_clear from commandbutton within tabpage_browse
integer x = 3630
integer y = 108
integer width = 274
integer height = 88
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

//Commented By Ken.Guo 2010-12-20
	//il_ctx_acp_folder_id = 0
	//il_ctx_acp_clause_id = 0
	//il_category = 0
	//il_parent_folder_id = 0
	//il_handle = 0
	//il_handle1 = 0
	//is_type = ''
	//is_types = ''
	//
	////Begin - Modified By Ken.Guo 2010-01-13
	///*
	//If isvalid(m_pfe_cst_clause_painter) Then
	//	m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
	//	m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False
	//	m_pfe_cst_clause_painter.m_file.m_save.enabled = False
	//	m_pfe_cst_clause_painter.m_file.m_properties.enabled = False
	//	m_pfe_cst_clause_painter.m_view.m_rules.enabled = False	
	//End If
	//*/
	//of_set_menu(1)
	////End - Modified By Ken.Guo 2010-01-13
	//of_create_clause_tree()
	//

//Added By Mark Lee 07/16/12
tabpage_browse.dw_filter.setItem(tabpage_browse.dw_filter.getRow(),'textsearch_dddw','AND')
end event

type cb_go from commandbutton within tabpage_browse
integer x = 3355
integer y = 108
integer width = 274
integer height = 88
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
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
	ll_tvi = tv_clause.FindItem(RootTreeItem!,0)
	tv_clause.expandall(ll_tvi) 
End If
//Begin - Modified By Ken.Guo 2010-01-13
/*
If isvalid(m_pfe_cst_clause_painter) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)	
End If
*/
of_set_menu(1)
//End - Modified By Ken.Guo 2010-01-13

end event

type gb_1 from groupbox within tabpage_browse
integer width = 4457
integer height = 232
integer taborder = 11
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter Criteria"
end type

type st_tip from statictext within tabpage_browse
boolean visible = false
integer x = 1449
integer y = 200
integer width = 1550
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Select the documents to compare from the browse area below. "
boolean focusrectangle = false
end type

type tabpage_clause from u_tabpg_agreement_template_detail within u_tab_agreement_clause_painter
integer x = 18
integer y = 112
integer width = 3995
integer height = 1968
string text = "Clause"
string picturename = "DosEdit5!"
end type

