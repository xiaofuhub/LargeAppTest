$PBExportHeader$u_tabpg_br_browse.sru
forward
global type u_tabpg_br_browse from u_tabpg_contract_master
end type
type dw_browse from u_dw_contract within u_tabpg_br_browse
end type
type dw_search from u_dw_contract within u_tabpg_br_browse
end type
end forward

global type u_tabpg_br_browse from u_tabpg_contract_master
integer width = 3666
integer height = 1620
long backcolor = 33551856
string text = "none"
long picturemaskcolor = 536870912
event ue_filter ( )
event ue_retrieve ( )
event ue_set_preview ( boolean ab_value )
event type integer ue_preview ( long al_doc_id,  decimal adec_revision,  string as_doc_ext )
event ue_set_doc_info ( string as_doc_name )
dw_browse dw_browse
dw_search dw_search
end type
global u_tabpg_br_browse u_tabpg_br_browse

type variables

end variables

event ue_filter();String ls_filter
Long ll_ctx_id,ll_doc_category,ll_doc_status
String ls_doc_name,ls_doc_ext,ls_create_by,ls_company_name

dw_search.AcceptText()

ls_filter = "1 = 1 "
ll_ctx_id = dw_search.GetItemNumber(1,'ctx_id')
If Not isnull(ll_ctx_id) Then
	ls_filter += ' And ctx_id = '  + String(ll_ctx_id)
End If

ls_doc_name = dw_search.GetItemString(1,'doc_name')
If ls_doc_name <> '' and Not isnull(ls_doc_name) Then
	ls_filter += " And Pos(Upper(compute_doc_name),'" + Upper(ls_doc_name)  + "' ,1) > 0"
End If

ls_doc_ext = dw_search.GetItemString(1,'doc_type')
If ls_doc_ext <> '' and Not isnull(ls_doc_ext) Then
	ls_filter += " And Upper(ctx_am_document_doc_ext) = '" +ls_doc_ext+ "'"
End If

ll_doc_category = dw_search.GetItemNumber(1,'doc_category')
If Not isnull(ll_doc_category) Then
	ls_filter += ' And category = '  + String(ll_doc_category)
End If

ll_doc_status = dw_search.GetItemNumber(1,'status')
If Not isnull(ll_doc_status) Then
	ls_filter += ' And status = '  + String(ll_doc_status)
End If

ls_create_by = dw_search.GetItemString(1,'createby')
If ls_create_by <> '' and Not isnull(ls_create_by) Then
	ls_filter += " And create_by = '" +ls_create_by+ "'"
End If

ls_company_name = dw_search.GetItemString(1,'company_name')
If ls_company_name <> '' and Not isnull(ls_company_name) Then
	ls_filter += " And Pos(Upper(facility_name),'" + Upper(ls_company_name)  + "' ,1) > 0"
End If

dw_browse.SetFilter(ls_filter)
dw_browse.Filter()
end event

event ue_retrieve();dw_browse.SetRedraw(False)
dw_browse.Retrieve(gs_user_id)

n_cst_right lnv_right
If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '1' Then 
	lnv_right = Create n_cst_right
	lnv_right.of_filter_right( dw_browse, 'category', 1)
	Destroy lnv_right
End If

Event ue_filter()
ib_retrieved = True
dw_browse.SetRedraw(True)
end event

event ue_set_preview(boolean ab_value);return
end event

event type integer ue_preview(long al_doc_id, decimal adec_revision, string as_doc_ext);return 1
end event

event ue_set_doc_info(string as_doc_name);return 
end event

on u_tabpg_br_browse.create
int iCurrent
call super::create
this.dw_browse=create dw_browse
this.dw_search=create dw_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_browse
this.Control[iCurrent+2]=this.dw_search
end on

on u_tabpg_br_browse.destroy
call super::destroy
destroy(this.dw_browse)
destroy(this.dw_search)
end on

event constructor;call super::constructor;this.of_setresize( true)

this.inv_resize.of_register( dw_search,inv_resize.scale)
this.inv_resize.of_register( dw_browse,inv_resize.scale)

This.inv_resize.of_setorigsize(This.width, This.height)
This.inv_resize.of_setminsize(500, 500)


end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_br_browse
boolean visible = false
integer y = 9312
end type

type dw_browse from u_dw_contract within u_tabpg_br_browse
integer x = 5
integer y = 356
integer width = 3648
integer height = 1256
integer taborder = 10
boolean titlebar = true
string title = "Browse"
string dataobject = "d_doc_br_browse"
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
This.of_setrmbmenu(False)

This.event ue_populatedddws( )
This.of_setupdateable( false)

This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)

This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single )


end event

event rowfocuschanged;call super::rowfocuschanged;String ls_doc_ext
IF Getrow() = 0 THEN RETURN
IF Rowcount() = 0 THEN RETURN

Event ue_set_preview(True)
If currentrow >0 Then
	Parent.Event ue_set_doc_info(This.getitemstring(currentrow,'compute_doc_name'))
	ls_doc_ext = Lower(This.getitemstring(currentrow,'ctx_am_document_doc_ext'))
	CHOOSE CASE Lower(ls_doc_ext)
		CASE 'bmp','tif','tiff','jpg','gif','pdf'//'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
			If Lower(ls_doc_ext) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then //Added By Ken.Guo 2011-05-06. for Open PDF Mode
				Event ue_set_preview(False)
			End If
		CASE 'doc','xls','xlsx'
		CASE ELSE
			Event ue_set_preview(False)
			Return
	END CHOOSE
End If

end event

event doubleclicked;call super::doubleclicked;Long ll_doc_id
Decimal ldec_revision
String ls_doc_ext

If row > 0 Then 
	ll_doc_id = dw_browse.GetItemNumber(row,'ctx_am_document_doc_id')
	ldec_revision = dw_browse.GetItemDecimal(row,'ctx_am_document_revision')
	ls_doc_ext = dw_browse.GetItemString(row,"ctx_am_document_doc_ext")
	Parent.event ue_preview(ll_doc_id,ldec_revision,ls_doc_ext )
End If


end event

event rbuttonup;call super::rbuttonup;Integer i
String ls_doc_ext

m_document_manager_browse lm_popup
lm_popup = Create m_document_manager_browse
If dw_browse.GetRow() > 0 Then
	For i = 1 To UpperBound(lm_popup.Item[])
		lm_popup.Item[i].visible = False
	Next
	
	ls_doc_ext = Lower(This.getitemstring(This.GetRow(),'ctx_am_document_doc_ext'))
	CHOOSE CASE Lower(ls_doc_ext)
		CASE 'bmp','tif','tiff','jpg','gif', 'doc','xls','xlsx','pdf'
			If Lower(ls_doc_ext) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then Return //Added By Ken.Guo 2011-05-06. for Open PDF Mode
			lm_popup.m_openinnewwindow.visible = True
			lm_popup.iw_parent = iw_parent
			lm_popup.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())
	End Choose	
End If 

end event

type dw_search from u_dw_contract within u_tabpg_br_browse
integer x = 5
integer y = 4
integer width = 3648
integer height = 340
integer taborder = 10
boolean titlebar = true
string title = "Search"
string dataobject = "d_doc_br_search"
boolean vscrollbar = false
end type

event constructor;call super::constructor;DataWindowChild ldwc_doc_ext,ldwc_company
This.GetChild('doc_type',ldwc_doc_ext)
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

end event

event buttonclicked;call super::buttonclicked;Choose Case dwo.name 
	Case'b_clear' 
		This.Reset()
		This.InsertRow(0)
	Case 'b_filter'
		If ib_retrieved Then
			Parent.event ue_filter( )
		Else
			Parent.event ue_retrieve( )
		End If
End Choose



end event

