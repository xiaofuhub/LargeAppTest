$PBExportHeader$u_tabpg_document_browse.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_document_browse from u_tabpg_dm_data
end type
end forward

global type u_tabpg_document_browse from u_tabpg_dm_data
integer width = 4082
integer height = 1916
event ue_filter ( )
end type
global u_tabpg_document_browse u_tabpg_document_browse

type variables
n_ds ids_ctx_group_user_view,ids_ctx_screens,ids_category_access
string is_category
long il_ctx_id,il_current_screen 
datastore ids_search //Added By Jay Chen 04-03-2014
end variables

forward prototypes
public function long of_get_ctx_view_id (long al_category, long al_ctx_id)
public function integer of_get_access_right (long al_row, ref string as_reason)
public function boolean of_get_protect_tabpg ()
public subroutine of_filter_no_access_data ()
public subroutine of_create_document_dw ()
end prototypes

event ue_filter();String ls_filter
Long ll_ctx_id,ll_doc_category,ll_doc_status,ll_doc_id
String ls_doc_name,ls_doc_ext,ls_create_by,ls_company_name,ls_doc_type

tab_1.tabpage_browse.dw_filter.AcceptText()

ls_filter = "1 = 1 "
ll_ctx_id = tab_1.tabpage_browse.dw_filter.GetItemNumber(1,'ctx_id')
If Not isnull(ll_ctx_id) and ll_ctx_id <> 0 Then
	ls_filter += ' And ctx_id = '  + String(ll_ctx_id)
End If

ll_doc_id =  tab_1.tabpage_browse.dw_filter.GetItemNumber(1,'doc_id')
If Not isnull(ll_doc_id) Then
	ls_filter += ' And doc_id = '  + String(ll_doc_id)
End If

ls_doc_name = tab_1.tabpage_browse.dw_filter.GetItemString(1,'doc_name')
If ls_doc_name <> '' and Not isnull(ls_doc_name) Then
	ls_filter += " And Pos(Upper(doc_name_full),'" + Upper(ls_doc_name)  + "' ,1) > 0"
End If

ls_doc_ext = tab_1.tabpage_browse.dw_filter.GetItemString(1,'doc_ext')
If ls_doc_ext <> '' and Not isnull(ls_doc_ext) Then
	ls_filter += " And Upper(doc_ext) = '" +ls_doc_ext+ "'"
End If

//Added By Ken.Guo 2011-04-02.
ls_doc_type = tab_1.tabpage_browse.dw_filter.GetItemString(1,'doc_type')
If ls_doc_type <> '' and Not isnull(ls_doc_type) Then
	ls_filter += " And Pos(Upper(doc_type),'" + Upper(ls_doc_type)  + "' ,1) > 0"
End If

ll_doc_category = tab_1.tabpage_browse.dw_filter.GetItemNumber(1,'doc_category')
If Not isnull(ll_doc_category) Then
	ls_filter += ' And category = '  + String(ll_doc_category)
End If

ll_doc_status = tab_1.tabpage_browse.dw_filter.GetItemNumber(1,'status')
If Not isnull(ll_doc_status) Then
	ls_filter += ' And status = '  + String(ll_doc_status)
End If

ls_create_by = tab_1.tabpage_browse.dw_filter.GetItemString(1,'createby')
If ls_create_by <> '' and Not isnull(ls_create_by) Then
	ls_filter += " And create_by = '" +ls_create_by+ "'"
End If

ls_company_name = tab_1.tabpage_browse.dw_filter.GetItemString(1,'company_name')
If ls_company_name <> '' and Not isnull(ls_company_name) Then
	//---------Begin Modified by (Appeon)Harry 11.28.2013 for V141  BugL111401 of Reintegration Issues
	//ls_filter += " And Pos(Upper(facility_name),'" + Upper(ls_company_name)  + "' ,1) > 0"
	ls_filter += ' And Pos(Upper(facility_name),"' + Upper(ls_company_name)  + '" ,1) > 0'  
	//---------End Modfiied ------------------------------------------------------
End If

//Added By Ken.Guo 2011-06-27. 
String ls_checkout_by
ls_checkout_by =  tab_1.tabpage_browse.dw_filter.GetItemString(1,'checkout_by')
If ls_checkout_by <> '' and Not isnull(ls_checkout_by) Then
	ls_filter += " And checkout_by = '" +ls_checkout_by+ "'"
End If

//Added By Ken.Guo 2011-06-27. 
String ls_checkout_status
ls_checkout_status =  tab_1.tabpage_browse.dw_filter.GetItemString(1,'checkout_status')
If ls_checkout_status <> '' and Not isnull(ls_checkout_status) Then
	Choose Case ls_checkout_status
		Case '100' //checked out with all
			ls_filter += " And checkout_status in ('1','2','3','5','6') "
		Case '2'
			ls_filter += " And checkout_status in ('2','3') "
		Case '5'
			ls_filter += " And checkout_status in ('5','6') "
		Case Else 
			ls_filter += " And checkout_status = '" +ls_checkout_status+ "' "
	End Choose
End If

//Added By Jay Chen 04-03-2014 Remark: add custom fields
string ls_colname,ls_value,ls_coltype,ls_visible,ls_Edit_Style,ls_data,ls_display
long ll_cnt,ll_row
dec{2} ldc_custom_number
datetime ldt_custom_date
ll_cnt = long(tab_1.tabpage_browse.dw_filter.Describe( "DataWindow.Column.Count" ))
for ll_row = 1 to ll_cnt
	ls_colname = lower(tab_1.tabpage_browse.dw_filter.Describe("#"+string( ll_row ) + ".name"))
	if left(ls_colname,7) <> 'custom_' then continue
	ls_coltype = lower(tab_1.tabpage_browse.dw_filter.Describe("#"+string( ll_row ) + ".coltype" ))
	ls_visible = tab_1.tabpage_browse.dw_filter.Describe(ls_colname + ".Visible")
	ls_Edit_Style = tab_1.tabpage_browse.dw_filter.Describe(ls_colname + ".Edit.Style")
	if ls_visible <> '1' then continue
	choose case left(ls_coltype,4)
		case 'char'
			ls_value = tab_1.tabpage_browse.dw_filter.getitemstring(1,ls_colname)
			if not isnull(ls_value) and ls_value<>''  then 
				if ls_Edit_Style = "dddw" then
					ls_filter += " and "+ls_colname+" = '" + ls_value+"' "
				else
					ls_filter += " and pos(lower("+ls_colname+"), '" + lower(ls_value) + "') > 0 " 
				end if
			end if
			
		case 'deci'
			ldc_custom_number = tab_1.tabpage_browse.dw_filter.getitemdecimal(1,ls_colname)
			if not isnull(ldc_custom_number) then 
				ls_filter += " and "+ls_colname+" = " + string(ldc_custom_number) + " "
			end if
			
		case 'date'
			ldt_custom_date = tab_1.tabpage_browse.dw_filter.getitemdatetime(1,ls_colname)
			if not isnull(ldt_custom_date) then 
				ls_filter += " and string("+ls_colname+",'yyyy/mm/dd') = '" + string(ldt_custom_date,'yyyy/mm/dd') + "' "
			end if
	end choose
next
//end add

tab_1.tabpage_browse.dw_browse.SetFilter(ls_filter)
tab_1.tabpage_browse.dw_browse.Filter()

If tab_1.tabpage_browse.dw_browse.RowCount() = 0 Then
	Tab_1.tabpage_preview.enabled = False
Else
	tab_1.tabpage_browse.dw_browse.SetRow(1)
	tab_1.tabpage_browse.dw_browse.ScrolltoRow(1)
	tab_1.tabpage_browse.dw_browse.SelectRow(0,False)
	tab_1.tabpage_browse.dw_browse.SelectRow(1,True)
	tab_1.tabpage_browse.dw_browse.event rowfocuschanged(1)
End If
end event

public function long of_get_ctx_view_id (long al_category, long al_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_search::of_get_ctx_view()
// $<arguments>
//		value	long	al_category		
//		value	long	al_ctx_id        		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
//Added By Ken.Guo 2010-08-02.
//////////////////////////////////////////////////////////////////////

Long ll_row
Long ll_view_id

//Get From Group Access
ll_row = ids_ctx_group_user_view.Find('ctx_group_access_ctx_id = ' + String(al_ctx_id) + ' And Upper(security_group_users_user_id) = "'+upper(gs_user_id)+'"',1,ids_ctx_group_user_view.RowCount()) 
If ll_Row > 0 Then
	ll_view_id = ids_ctx_group_user_view.GetItemNumber(ll_row,'ctx_group_access_view_id')
	Return ll_view_id
End If

//Get From Category from Code_Lookup	
ll_view_id = Long(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(al_category)))

//Get From Default View
If isnull(ll_view_id) Or ll_view_id = 0 Then
	ll_view_id = Long(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
End If
If isnull(ll_view_id) Or ll_view_id = 0 Then
	ll_view_id = 1001
End If

Return ll_view_id
end function

public function integer of_get_access_right (long al_row, ref string as_reason);//////////////////////////////////////////////////////////////////////
// Function: of_get_access_right()
// Arguments:
// 	value    long   al_row
// 	ref    string    as_reason
//--------------------------------------------------------------------
// Return:  integer
////2: Full Access;    1: Read Only;    0: No Access
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-08-02
//--------------------------------------------------------------------
// Description: Get Right/Access for the Document
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

String ls_access
Long ll_ctx_id,ll_view_id,ll_doc_category,ll_ctx_category
Datawindow ldw_browse

If al_row = 0 Then Return 0

ldw_browse = tab_1.tabpage_browse.dw_browse

ll_ctx_id = ldw_browse.GetItemNumber(al_row,'ctx_id')
ll_doc_category = ldw_browse.GetItemNumber(al_row,'category')
ll_ctx_category = ldw_browse.GetItemNumber(al_row,'ctx_basic_info_category')
ls_access = ldw_browse.GetItemString(al_row,'ctx_access_list_access')
ll_view_id = This.of_get_ctx_view_id(ll_ctx_category,ll_ctx_id)

//Check Document Manager Tab whether visible for current view
if ids_ctx_screens.RowCount() = 0 then ids_ctx_screens.Retrieve(gs_user_id) //Added By Jay Chen 04-04-2014
If ids_ctx_screens.Find('data_view_id = ' + String(ll_view_id) + ' and tab_name = "tabpage_images"',1,ids_ctx_screens.RowCount()) = 0 Then
	as_reason = 'Because the Document Manager Tab is invisible for Contract '+String(ll_ctx_id)+'.'
	Return 0
End If

//Check Documents whether filter
If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '1' Then 
	If	ids_category_access.find( 'lookup_code = '+ String(ll_doc_category),1, ids_category_access.rowcount()) > 0 Then
		as_reason = 'Because the document has been auto filter by right in the Document Manager.'
		Return 0
	End If
End If

//Documents Browse Module whether ReadOnly
If w_mdi.of_security_access(6979) = 1 then 
	Return 1
End If

//Check Contract Main Module whether ReadOnly
If w_mdi.of_security_access(2070) = 1 Then
	Return 1
End If

//Check Document Manager Tab whether ReadOnly
If w_mdi.of_security_access(2150) = 1 Then
	Return 1
End If

//Get Contract Access
Choose Case Upper(ls_access) 
	Case 'F'
		Return 2
	Case 'R'
		Return 1
End Choose

Return 0




end function

public function boolean of_get_protect_tabpg ();String ls_errtext
Integer li_access

If iw_parent.classname() = 'w_contract' Then
	Return inv_contract_details.of_get_protect_tabpg( )
Else
	li_access = This.of_get_access_right( tab_1.tabpage_browse.dw_browse.GetRow() , ls_errtext)
	Choose Case li_access 
		Case 2
			Return False
		Case 1
			Return True
		Case 0
			Return True
	End Choose
End If

end function

public subroutine of_filter_no_access_data ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_document_browseof_filter_no_access_data()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Filter data what the user have no right to view
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-03 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_row_cnt
String ls_err
Datawindow ldw_browse

ldw_browse = tab_1.tabpage_browse.dw_browse
ll_row_cnt = ldw_browse.RowCount() 
If ll_row_cnt = 0 Then Return
SetPointer(HourGlass!)
For i = ll_row_cnt to 1 Step -1
	If This.of_get_access_right( i, ls_err) = 0 Then
		ldw_browse.Rowsdiscard( i, i, Primary!)
	End If
Next

Return 
end subroutine

public subroutine of_create_document_dw ();//====================================================================
// Function: of_create_document_dw
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string ls_tab_name,ls_dw_name[],ls_dataobject[]
datawindow ld_dw[]

ls_tab_name = 'tabpage_images'
ld_dw[1] = tab_1.tabpage_browse.dw_filter
ld_dw[2] = tab_1.tabpage_browse.dw_browse
ls_dw_name[1] = 'dw_filter'
ls_dw_name[2] = 'dw_browse'
ls_dataobject[1] = 'd_doc_br_search'
ls_dataobject[2] = 'd_doc_br_browse'
f_create_contract_dw(gl_SearchTab_document_View,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)

end subroutine

on u_tabpg_document_browse.create
int iCurrent
call super::create
end on

on u_tabpg_document_browse.destroy
call super::destroy
end on

event ue_retrieve;//Override Ancestor Script

//Check Document Manager whether visible for current user
If w_mdi.of_security_access(2150) = 0 Then
	Messagebox('Documents',"You don't have right to view the Document Manager Tab.")
	Return 0
End If

SetPointer(HourGlass!)
tab_1.tabpage_browse.dw_browse.SetFilter("")

tab_1.tabpage_browse.dw_browse.SetRedraw(False)
gnv_appeondb.of_startqueue( )
	tab_1.tabpage_browse.dw_browse.Retrieve(gs_user_id)
	ids_ctx_group_user_view.Retrieve(gs_user_id)
	ids_ctx_screens.Retrieve(gs_user_id)
	ids_category_access.Retrieve(gs_user_id,1)
gnv_appeondb.of_commitqueue( )
This.of_filter_no_access_data( )
//Added By Jay Chen 04-03-2014
ids_search = Create DataStore
ids_search.DataObject = tab_1.tabpage_browse.dw_browse.DataObject
tab_1.tabpage_browse.dw_browse.RowsCopy(1,tab_1.tabpage_browse.dw_browse.RowCount(),Primary!,ids_search,1,Primary!)
//end add
This.event ue_filter( ) //Added By Ken.Guo 2010-10-20.
tab_1.tabpage_browse.dw_browse.SetRedraw(True)
SetPointer(Arrow!)
ib_retrieved = True
Return 1

end event

event constructor;call super::constructor;ids_ctx_group_user_view = create n_ds
ids_ctx_group_user_view.dataobject = 'd_ctx_group_user_view_pt'
ids_ctx_group_user_view.settransobject(sqlca)

ids_ctx_screens = create n_ds
ids_ctx_screens.dataobject = 'd_ctx_screen'
ids_ctx_screens.settransobject(sqlca)

ids_category_access = Create n_ds
ids_category_access.dataobject = 'd_category_no_access'
ids_category_access.settransobject(sqlca)

//Added By Jay Chen 04-03-2014
if iw_parent.classname() = 'w_documents_browse' Then
	tab_1.tabpage_browse.st_vsplitbar.Visible = true
End If

tab_1.tabpage_browse.st_vsplitbar.Y =  tab_1.tabpage_browse.dw_filter.Y  + tab_1.tabpage_browse.dw_filter.Height  + 4
Tab_1.TabPage_Browse.dw_browse.Y = tab_1.tabpage_browse.st_vsplitbar.Y + tab_1.tabpage_browse.st_vsplitbar.height +  4
Tab_1.TabPage_Browse.dw_browse.Height = tab_1.tabpage_browse.Height  - tab_1.tabpage_browse.st_vsplitbar.Y - tab_1.tabpage_browse.st_vsplitbar.Height - 20 
//end add

//add by gavins 20120131
tab_1.tabpage_browse.dw_detail.visible = false
this.of_Registresize( 2 )
end event

event destructor;call super::destructor;If isvalid(ids_ctx_group_user_view) Then Destroy ids_ctx_group_user_view
If isvalid(ids_ctx_screens) Then Destroy ids_ctx_screens
If isvalid(ids_category_access) Then Destroy ids_category_access



end event

event ue_do;//Override Ancestor Script
String ls_errtext

If This.of_get_access_right( tab_1.tabpage_browse.dw_browse.GetRow() ,ls_errtext) = 0 Then
	Messagebox('Documents',"You don't have right to access the document. " + ls_errtext)
	Return 
End If

Super:: Event ue_do(as_action)
end event

event ue_set_security;call super::ue_set_security;If IsValid( m_pfe_cst_mdi_menu_contract_am ) Then 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', false) //add by gavins 20120201
	
End If
end event

event ue_compare;IF Not IsValid(inv_dm_comparison) THEN RETURN -1

inv_dm_comparison.of_start_compare_clauses( iw_parent, tab_1.tabpage_browse.dw_browse, 'dm')

RETURN 1
end event

event ue_show_constructor;call super::ue_show_constructor;//====================================================================
// Event: ue_show_constructor
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long 		ll_Right
String	ls_Error
String 	ls_browse_screen_results_style  				
this.SetRedraw(false)


of_create_document_dw()

tab_1.tabpage_browse.dw_filter.ib_retrieve_drop_downs = false
tab_1.tabpage_browse.dw_filter.Event ue_constructor( )

tab_1.tabpage_browse.dw_browse.ib_retrieve_drop_downs = false
tab_1.tabpage_browse.dw_browse.Event ue_constructor( )

This.Event ue_set_screen_properties()		


this.SetRedraw(true)

If isvalid(inv_resize) Then 
	inv_resize.event pfc_resize(1, this.width, this.height)
End If

end event

type st_1 from u_tabpg_dm_data`st_1 within u_tabpg_document_browse
end type

type tab_1 from u_tabpg_dm_data`tab_1 within u_tabpg_document_browse
integer width = 4055
long backcolor = 33551856
end type

event tab_1::selectionchanging;call super::selectionchanging;String ls_errtext
If newindex = 2 Then
	If of_get_access_right( tab_1.tabpage_browse.dw_browse.GetRow() ,ls_errtext) = 0 Then
		Messagebox('Documents',"You don't have right to access the document. " + ls_errtext)
		Return 1
	End If
End If

Return 0
end event

event tab_1::selectionchanged;call super::selectionchanged;If IsValid( m_pfe_cst_mdi_menu_contract_am ) Then  m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history.toolbaritemvisible = false //add by gavins 20120201
end event

type tabpage_browse from u_tabpg_dm_data`tabpage_browse within tab_1
integer width = 4018
long backcolor = 33551856
end type

type st_vsplitbar from u_tabpg_dm_data`st_vsplitbar within tabpage_browse
end type

type dw_browse from u_tabpg_dm_data`dw_browse within tabpage_browse
event ue_constructor pbm_constructor
integer y = 492
integer width = 4000
integer height = 1256
string dataobject = "d_doc_br_browse"
end type

event dw_browse::ue_constructor;//====================================================================
// Event: ue_constructor
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

This.SetTransObject(SQLCA)
This.of_setrmbmenu(False)

This.event ue_populatedddws( )
This.of_setupdateable( false)

This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)

of_setrowselect( true)
this.inv_rowselect.of_setignorewin95(true)
this.inv_rowselect.of_setstyle( inv_rowselect.extended )

This.Title = "Document Browse"
This.is_title_bar_text = This.Title
end event

event dw_browse::constructor;//Override Ancestor Script
This.SetTransObject(SQLCA)
This.of_setrmbmenu(False)

This.event ue_populatedddws( )
This.of_setupdateable( false)

This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)

of_setrowselect( true)
this.inv_rowselect.of_setignorewin95(true)
this.inv_rowselect.of_setstyle( inv_rowselect.extended )

This.Title = "Document Browse"
This.is_title_bar_text = This.Title
end event

event dw_browse::clicked;//Override Ancestor Script
long ll_Row
Long ll_x1,ll_x2,ll_x3
long ll_pointerx,ll_pointery

ll_pointerx = This.pointerX()
ll_pointery = This.pointerY()

//Sort data by first column's(include 3 flags) 
If dwo.name = 't_status' Then
	Super::EVENT Clicked(xpos,ypos,row,this.object.checkout_status_t)
	Return 1
End If

//forbid resize first column's width
IF ll_pointery < Long(This.Describe("DataWindow.Header.Height")) &
	And ll_pointerx > Long(This.Describe("t_status.x")) + Long(This.Describe("t_status.width")) - 50 &
	And ll_pointerx < Long(This.Describe("t_status.x")) + Long(This.Describe("t_status.width")) + 50 Then
		Return 1
End If

Super::EVENT Clicked(xpos,ypos,row,dwo )

If row = 0 Then Return 

//add by gavins 20120205
If  IsValid(inv_dm_comparison) then //For document comparison functionality - alfee 07.23.2008	
	inv_dm_comparison.of_select_document(row)	
end if

//If  KeyDown(KeyShift!) or  KeyDown(KeyControl!) Then Return 
//
//ll_Row = this.GetSelectedRow(0)
//If ll_row > 0 Then
//	this.SetRow(ll_Row)
//	Parent.Dynamic Event ue_rowfocuschanged(This, ll_row)
//End If
end event

event dw_browse::getfocus;call super::getfocus;il_current_screen = 60
end event

type dw_filter from u_tabpg_dm_data`dw_filter within tabpage_browse
event ue_constructor pbm_constructor
event ue_populatedddws_document ( )
string tag = "Search Criteria"
integer width = 4000
integer height = 476
string title = "Search Criteria"
string dataobject = "d_doc_br_search"
end type

event dw_filter::ue_constructor;//====================================================================
// Event: ue_constructor
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

This.Title = "Search Criteria"
This.is_title_bar_text = This.Title

DataWindowChild ldwc_doc_ext,ldwc_company
This.GetChild('doc_ext',ldwc_doc_ext)
ldwc_doc_ext.SetTransObject(SQLCA)

This.GetChild('company_name',ldwc_company)
ldwc_company.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	ldwc_company.Retrieve()
	ldwc_doc_ext.Retrieve()
gnv_appeondb.of_commitqueue( )

This.of_setrmbmenu(False)

This.InsertRow(0)
This.event ue_populatedddws( )
this.of_setupdateable( false)

datawindowchild ldwc_child
this.GetChild( "doc_category",ldwc_child)
n_cst_right lnv_right
If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '1' Then 
	lnv_right = Create n_cst_right
	lnv_right.of_filter_right( ldwc_child, 'lookup_code', 1)
	Destroy lnv_right
End If




end event

event dw_filter::ue_populatedddws_document();//====================================================================
// Event: ue_populatedddws_document
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if ib_retrieve_drop_downs then return

long ll_column_count,ll_i,ll_Row
string ls_dddw_name
string ls_colname
String ls_coltag
Integer li_value
Integer ll_lookup_code
String ls_DataColumn	
long ll_null
DataWindowChild dwchild, ldwc_doc_category
n_ds lnds_user

LL_COLUMN_COUNT = LONG(This.Describe("DataWindow.Column.Count"))
IF LL_COLUMN_COUNT = 0 THEN RETURN

FOR LL_I = 1 TO LL_COLUMN_COUNT
	IF Describe("#" +STRING(LL_I) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +STRING(LL_I) + ".Name")
		ls_dddw_name = lower(Describe("#" +STRING(LL_I) + ".DDDW.Name"))

		IF ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" THEN
			ls_coltag = Lower(Describe("#" +STRING(LL_I) + ".TAG"))
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
				
			IF li_value <> 1 THEN
				gnv_app.of_setcontraccache_code_lookup( ls_coltag )
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
			END IF
		elseif ls_dddw_name = 'd_dddw_company' or ls_dddw_name = 'd_dddw_company_list' then  // jervis 12.8.2009
			ls_coltag = Lower(Describe("#" +STRING(LL_I) + ".TAG"))
			li_value = 1
		ELSE
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
		END IF

		IF li_value = 1 THEN
			getchild( ls_colname, dwchild)
			if ls_dddw_name = 'd_dddw_company' or ls_dddw_name = 'd_dddw_company_list' then //jervis 12.8.2009
				SetNull(ll_null)
				dwchild.Settransobject( sqlca)
				dwchild.Retrieve( ls_coltag)
				dwchild.InsertRow(1)
				dwchild.SetItem(1,'facility_id',ll_null)
				dwchild.setitem(1,"facility_name",'')
			else
				dwchild.Reset( )
				//------Begin Modified by Alfee 11.15.2007-----------------
				lnds_user.rowscopy( 1, lnds_user.RowCount(), primary!, dwchild, 1, primary!)
				//lnds_user.rowscopy( 1, 1000, primary!, dwchild, 1, primary!)
				//-------End Modified --------------------------------------
			end if
			
			if ls_dddw_name = 'd_dddw_users' then
				dwchild.InsertRow(1)
				dwchild.SetItem(1,'user_id','')
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.27.2007 By: Jack 
			//$<reason> Fix a defect.
			long ll_find
			string ls_displaycolumn
			ls_displaycolumn = This.Describe(ls_colname + ".dddw.displaycolumn")
			ll_find = dwchild.find(ls_displaycolumn + " = '(NONE)'",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.setitem(ll_find,ls_displaycolumn,'')
			End If
			//Add by Jack 07.13.2007
			If ls_colname = 'facility_name' Then
				ll_find = dwchild.find(ls_displaycolumn + " = '* Add Company * '",1,dwchild.rowcount())
				If ll_find > 0 Then
					dwchild.deleterow(ll_find)
				End If
			End If
			//---------------------------- APPEON END ----------------------------
			
			//Added By Ken.Guo 03/12/2012. Do not allow add lookup data for search dw
			ll_find = dwchild.find( "Pos(" + ls_displaycolumn+ ",'*Add ' ) > 0",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.deleterow(ll_find)
			End If
			
			
			ls_DataColumn = This.Describe(ls_colname + ".dddw.DataColumn")
			dwchild.SetFilter( "isnull(" + ls_DataColumn + ") or " + ls_DataColumn + " > 0 " )
			dwchild.Filter( )
		END IF
	END IF
NEXT

//This.GetChild("category",dwchild)
//dwchild.SetTransObject(SQLCA)

//This.GetChild("doc_category",ldwc_doc_category)
//ldwc_doc_category.SetTransObject(SQLCA)

//gnv_appeondb.of_startqueue( )
//	dwchild.Retrieve(gs_user_id)
//	ldwc_doc_category.Retrieve(gs_user_id)
//gnv_appeondb.of_commitqueue( )


ib_retrieve_drop_downs = True

Return



end event

event dw_filter::constructor;//Override Ancestor Script
this.of_setdropdowncalendar( true)
This.Title = "Search Criteria"
This.is_title_bar_text = This.Title

DataWindowChild ldwc_doc_ext,ldwc_company
This.GetChild('doc_ext',ldwc_doc_ext)
ldwc_doc_ext.SetTransObject(SQLCA)

This.GetChild('company_name',ldwc_company)
ldwc_company.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	ldwc_company.Retrieve()
	ldwc_doc_ext.Retrieve()
gnv_appeondb.of_commitqueue( )

This.of_setrmbmenu(False)

This.InsertRow(0)
This.event ue_populatedddws( )
this.of_setupdateable( false)

/*
datawindowchild ldwc_child
this.Modify("doc_category.dddw.name = 'd_dddw_user_access_category' doc_category.DDDW.VScrollbar=Yes")
this.GetChild( "doc_category",ldwc_child)
ldwc_child.SetTransobject( sqlca)
if ldwc_child.Retrieve( gs_user_id) < 1 then ldwc_child.Insertrow( 0)
*/
datawindowchild ldwc_child
this.GetChild( "doc_category",ldwc_child)
n_cst_right lnv_right
If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '1' Then 
	lnv_right = Create n_cst_right
	lnv_right.of_filter_right( ldwc_child, 'lookup_code', 1)
	Destroy lnv_right
End If

//Added By Ken.Guo 2011-04-02.//modified by gavins 20130412
//datawindowchild ldwc_child_type
//this.GetChild( "doc_type",ldwc_child_type)
//If ldwc_child_type.rowcount() >= 2 Then //Delete *Add Lookup Code* row
//	ldwc_child_type.DeleteRow(2)
//End If


end event

event dw_filter::buttonclicked;//Override Ancestor Script
Choose Case dwo.name 
	Case'b_clear' 
		This.Reset()
		This.InsertRow(0)
	Case 'b_filter'
		If ib_retrieved Then
			 //Added By Jay Chen 04-03-2014
			tab_1.tabpage_browse.dw_browse.reset( )
			ids_search.RowsCopy(1,ids_search.RowCount(),Primary!,tab_1.tabpage_browse.dw_browse,1,Primary!)
			Event ue_filter( )
		Else
			Event ue_retrieve( )
		End If
End Choose



end event

event dw_filter::ue_key;call super::ue_key;If Key = KeyEnter! Then
	This.event buttonclicked( 1, 0, This.object.b_filter )
End If
end event

event dw_filter::ue_post_itemchanged;call super::ue_post_itemchanged;//====================================================================
// Event: ue_post_itemchanged
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long      row
// 	value    string    dwoname
// 	value    string    data
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-03-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_view_id,ll_FoundRow,ll_ctx_id,ll_Dynamic

DataStore	lds_SearchDevTemp 

choose case dwoname
		case 'doc_category'
			is_category = DATA
			if is_category = '' then setnull(is_category)  
			If iw_parent.classname() = 'w_documents_browse' Then
				SELECT Dynamic_Search_Tab
				  INTO :ll_Dynamic
				  FROM security_users 
				 WHERE user_id = :gs_user_id;
				ll_view_id = of_get_ctx_view_id(long(is_category),-1) 
				if ll_Dynamic = 1 and ll_view_id <> gl_SearchTab_document_View then
					lds_SearchDevTemp = Create DataStore
					lds_SearchDevTemp.DataObject = tab_1.tabpage_browse.dw_browse.DataObject
					tab_1.tabpage_browse.dw_browse.RowsCopy(1,tab_1.tabpage_browse.dw_browse.RowCount(),Primary!,lds_SearchDevTemp,1,Primary!)
					gl_SearchTab_document_View = ll_view_id
					Trigger Event ue_show_constructor()
					
					This.Reset()
					this.Insertrow( 0)
					this.SetItem( 1, 'doc_category',long( is_category))
					lds_SearchDevTemp.RowsCopy(1,lds_SearchDevTemp.RowCount(),Primary!,tab_1.tabpage_browse.dw_browse,1,Primary!)
					
					tab_1.tabpage_browse.dw_browse.Trigger Event RowFocusChanged(1)
					//Destroy lds_SearchTemp
					Destroy lds_SearchDevTemp
				end if
			End If
		
end choose 
	
end event

event dw_filter::getfocus;call super::getfocus;il_current_screen = 59
end event

type dw_detail from u_tabpg_dm_data`dw_detail within tabpage_browse
boolean visible = false
integer width = 4059
integer height = 608
end type

type tabpage_preview from u_tabpg_dm_data`tabpage_preview within tab_1
integer width = 4018
end type

type ole_doc from u_tabpg_dm_data`ole_doc within tabpage_preview
end type

type uo_2 from u_tabpg_dm_data`uo_2 within tabpage_preview
end type

type gb_map from u_tabpg_dm_data`gb_map within tabpage_preview
end type

type dw_head from u_tabpg_dm_data`dw_head within tabpage_preview
end type

type dw_clause from u_tabpg_dm_data`dw_clause within tabpage_preview
end type

type dw_change from u_tabpg_dm_data`dw_change within tabpage_preview
end type

type cb_approve from u_tabpg_dm_data`cb_approve within tabpage_preview
end type

type cb_original from u_tabpg_dm_data`cb_original within tabpage_preview
end type

type cb_reject from u_tabpg_dm_data`cb_reject within tabpage_preview
end type

type uo_scrollbar from u_tabpg_dm_data`uo_scrollbar within tabpage_preview
end type

type pb_approve from u_tabpg_dm_data`pb_approve within tabpage_preview
end type

type pb_reject from u_tabpg_dm_data`pb_reject within tabpage_preview
end type

type st_docinfo from u_tabpg_dm_data`st_docinfo within u_tabpg_document_browse
end type

