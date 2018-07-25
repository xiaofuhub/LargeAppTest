$PBExportHeader$u_rpt_tabpg_contract_search.sru
forward
global type u_rpt_tabpg_contract_search from u_tabpg_contract_search
end type
type cb_all from commandbutton within u_rpt_tabpg_contract_search
end type
end forward

global type u_rpt_tabpg_contract_search from u_tabpg_contract_search
integer width = 3886
integer height = 2028
long backcolor = 33551856
cb_all cb_all
end type
global u_rpt_tabpg_contract_search u_rpt_tabpg_contract_search

forward prototypes
public function integer of_retrieve ()
public subroutine of_expand_allrow ()
end prototypes

public function integer of_retrieve ();/******************************************************************************************************************
**  [PUBLIC]   : of_retrieve()
**==================================================================================================================
**  Purpose   	: function fired when the user succufully changes the tab
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  31 May 2005
**==================================================================================================================
**  Modification Log
**   Changed By  Scofield           Change Date   2008-07-08                                            Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if Not ib_retriev_detail then return 0

SetPointer(Hourglass!)

ib_retriev_detail = False

gnv_app.ib_ref_cache = true
gnv_app.of_setcontraccache( )
gnv_app.of_setcontraccache_code_lookup( FALSE)

ib_retrieve = False

gnv_appeondb.of_startqueue()

ids_search.setfilter('')
ids_search.Retrieve(Upper(gs_user_id ))

//ids_contract_access_pt.Retrieve( gs_user_id ) //commented by Ken.Guo on 2009-02-12
ids_contract_access_category.Retrieve( gs_user_id )

gnv_appeondb.of_commitqueue( )

if ids_search.rowcount( ) > 0 then
	il_contract_array = ids_search.object.ctx_id.current
end if

of_filter()

if dw_search_det1.RowCount() < 1 then 
	of_set_message('no rows')
else
	dw_search_det1.title = 'Contract Browse ' + "(" + string(dw_search_det1.rowcount()) + ")"
end if

SetPointer(Arrow!)

return success

end function

public subroutine of_expand_allrow ();//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2009-01-05 By: Alan
//$<Reason> BugE112701
long		ll_i,ll_count,ll_temp
string	ls_stype
long		ll_cnt
long		ll_ctx_id

dw_search_det1.Setredraw(false)

ll_count = dw_search_det1.rowcount()
for ll_i=1 to ll_count
	ll_ctx_id = dw_search_det1.GetItemNumber(ll_i,'ctx_id')
	ls_stype = dw_search_det1.getitemstring(ll_i,'style')
	ll_cnt = dw_search_det1.getitemnumber(ll_i,'master_cnt')
	if ls_stype = '+' and ll_cnt > 0 then
		//of_display_Row(ll_ctx_id,ll_i)
		of_expand_row(ll_ctx_id,ll_i)	//jervis -7.7.2009
		ll_temp = dw_search_det1.rowcount()
		ll_i = ll_i + ll_temp - ll_count
		ll_count = ll_temp
	end if
next

dw_search_det1.Setredraw( True )
//---------------------------- APPEON END ----------------------------

end subroutine

on u_rpt_tabpg_contract_search.create
int iCurrent
call super::create
this.cb_all=create cb_all
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_all
end on

on u_rpt_tabpg_contract_search.destroy
call super::destroy
destroy(this.cb_all)
end on

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-08 By: Scofield
//$<Reason> Init the dataobject data.

String	ls_Sort
long		ll_Right

This.of_GetParentWindow(iw_parent)

/* //commented by Ken.Guo on 2009-02-12
ids_contract_access_pt = create n_ds
ids_contract_access_pt.dataobject = 'd_contract_access_pt'
ids_contract_access_pt.settransobject(sqlca)
*/

ids_contract_access_category = create n_ds
ids_contract_access_category.dataobject = 'ds_contract_access_category'
ids_contract_access_category.settransobject(sqlca)

ids_search = Create datastore
ids_search.dataobject = 'd_rpt_sp_contract_search'
ids_search.settransobject(sqlca)


ids_search_temp = Create datastore
ids_search_temp.dataobject = 'd_rpt_sp_contract_search'

ls_Sort = dw_search_det1.Describe("DataWindow.Table.Sort")
if Len(ls_Sort) < 2 then ls_Sort = "ctx_id A,product_type A,product_name A"

dw_search_det1.Modify("DataWindow.Table.Sort='" + ls_Sort + "'")
//ids_search_temp.Modify("DataWindow.Table.Sort='" + ls_Sort + "'")

ll_Right = w_mdi.of_security_access(2081)
if ll_Right = 0 then
	dw_search.Object.b_more.Visible = false
	dw_search.Object.b_clear.X = Long(dw_search.Object.owner.X) + Long(dw_search.Object.owner.Width) - Long(dw_search.Object.b_clear.Width)
end if
//---------------------------- APPEON END ----------------------------

If Not isvalid(inv_ctx_tv) Then//ad by gavins 20120209
	inv_ctx_tv = Create n_cst_ctx_tv
End If

dw_search.Modify( "b_more.text='Less >>'")//added by gavins 20130227
dw_search.event ue_moreandless(false)
end event

event ue_set_security;//Override ancestor script;
end event

type st_1 from u_tabpg_contract_search`st_1 within u_rpt_tabpg_contract_search
end type

type cb_2 from u_tabpg_contract_search`cb_2 within u_rpt_tabpg_contract_search
end type

event cb_2::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-08 By: Scofield
//$<Reason> Return all selected ctx_id.

//Override ancestor script;
Long		ll_RowCnt, ll_Cycle, ll_facility_id, ll_found, ll_rows_company
long		ll_master_contract_id,ll_ctx_id,ll_master_cnt,ll_Selected
String	ls_Return, ls_company,ls_Style

DatawindowChild ldwc_company

For ll_Cycle = 1 To dw_search_det1.RowCount()
	ll_ctx_id = dw_search_det1.GetItemNumber(ll_Cycle,'ctx_id')
	ll_master_contract_id = dw_search_det1.GetItemNumber(ll_Cycle,'master_contract_id')
	ll_master_cnt = dw_search_det1.GetItemNumber(ll_Cycle,'master_cnt')
	ls_Style = dw_search_det1.GetItemString(ll_Cycle,'style')
	If ls_Style = '+' and ll_master_contract_id = 0 And ll_master_cnt > 0 Then
		//of_display_row(ll_ctx_id,ll_Cycle)
		of_expand_row(ll_ctx_id,ll_Cycle)	//jervis -7.7.2009
	End If
Next

dw_search_det1.GetChild("app_facility", ldwc_company)
ll_rows_company = ldwc_company.RowCount()

ll_RowCnt = dw_search_det1.RowCount()
For ll_Cycle = 1 to ll_RowCnt
	ll_Selected = dw_search_det1.GetItemNumber(ll_Cycle, "selected")
	if IsNull(ll_Selected) then ll_Selected = 0
	
	if ll_Selected = 0 then continue;

	ll_ctx_id = dw_search_det1.GetItemNumber(ll_Cycle, "ctx_id")
	ll_facility_id = dw_search_det1.GetItemNumber(ll_Cycle, "app_facility")
	ll_found = ldwc_company.Find("facility_id = " + string(ll_facility_id), 1, ll_rows_company)
	if ll_found > 0 then
		ls_company = ldwc_company.GetItemString(ll_found, "facility_name")
	else
		ls_company = string(ll_ctx_id)
	end if

	ls_Return += string(ll_ctx_id) + '~t' + ls_company + '|'
Next

if ls_Return <> '' then ls_Return = Left(ls_Return, Len(ls_Return) - 1)

if IsValid(w_custom_report) then
	w_custom_report.ib_Select = true
end if

CloseWithReturn(iw_parent, ls_Return)
//---------------------------- APPEON END ----------------------------

end event

type cb_1 from u_tabpg_contract_search`cb_1 within u_rpt_tabpg_contract_search
end type

event cb_1::clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.23.2007 By: Jack
//$<reason> Fix a defect.
If Not isvalid(cb_all) Then Return
//---------------------------- APPEON END ----------------------------


if cb_all.text = "&Deselect All" then
	cb_all.text = "Select &All"
end if
end event

type cb_3 from u_tabpg_contract_search`cb_3 within u_rpt_tabpg_contract_search
boolean visible = true
integer x = 2779
end type

event cb_3::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-08 By: Scofield
//$<Reason> Filter and Refresh.

If ib_retriev_detail = false Then
	cb_1.Event Clicked( )
Else
	
	of_filter()
	
	if dw_search_det1.RowCount() < 1 then
		of_set_message('no rows')
	else
		dw_search_det1.title = 'Contract Browse ' + "(" + string(dw_search_det1.rowcount()) + ")"
	end if
End If
//---------------------------- APPEON END ----------------------------

end event

type cb_print from u_tabpg_contract_search`cb_print within u_rpt_tabpg_contract_search
end type

type dw_search from u_tabpg_contract_search`dw_search within u_rpt_tabpg_contract_search
integer height = 496
string dataobject = "d_contract_search"
end type

type dw_search_det1 from u_tabpg_contract_search`dw_search_det1 within u_rpt_tabpg_contract_search
integer y = 528
integer height = 1352
string dataobject = "d_rpt_sp_contract_search"
end type

event dw_search_det1::clicked;//Override ancestor script;
//if IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) then return
//if IsValid (inv_Sort) then inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-08 By: Scofield
//$<Reason> Expand row or collapse row.

String 	ls_ObjName,ls_SortCol
long		ll_ctx_id

if IsNull(xpos) or IsNull(ypos) or IsNull(Row) or IsNull(dwo) then Return

SetPointer(hourglass!)

if Row > 0 then 
	This.SelectRow(0, false)
   This.SelectRow(Row, true)
	
	ll_ctx_id = This.GetItemNumber(Row,'ctx_id')
	
	if dwo.name = 'p_1' then
		//of_display_Row(ll_ctx_id,Row)
		of_expand_row(ll_ctx_id,row)	//06.23.2009 by jervis
	elseif dwo.name = 'p_2' then
		of_collapse_Row(ll_ctx_id, Row)
	End if
END if

ls_ObjName = string(dwo.name) 
if Row = 0 and this.Describe(ls_ObjName+".band") = "header" and this.Describe(ls_ObjName + ".text") <> "!" then 
	ls_SortCol = left(ls_ObjName,len(ls_ObjName) - 2) 
	this.Event ue_set_sort(xpos,ypos,Row,dwo,ls_SortCol)
End if

SetPointer(Arrow!)
//---------------------------- APPEON END ----------------------------

end event

event dw_search_det1::constructor;//Override ancestor script;

//of_settransobject( sqlca)
//of_SetSort(TRUE)
//inv_sort.of_SetColumnHeader(TRUE)
//inv_sort.of_setusedisplay( TRUE )


//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-08 By: Scofield
//$<Reason> Init dw_search_det1.

of_SetTransObject( sqlca)
This.Event ue_Populatedddws( )
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_sort.of_SetUseDisplay(TRUE)
//---------------------------- APPEON END ----------------------------

end event

event dw_search_det1::doubleclicked;//Override ancestor script;
end event

event dw_search_det1::rowfocuschanged;//Override ancestor script;
end event

event dw_search_det1::rowfocuschanging;//Override ancestor script;
end event

event dw_search_det1::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-08 By: Scofield
//$<Reason> Refresh ids_search's data.

String 	ls_ProType,ls_ProName,ls_FindExp,ls_Filter
long		ll_ctx_id,ll_Found

if Row > 0 and dwo.name = 'selected' then
	ll_ctx_id = This.GetItemNumber(Row,'ctx_id')
	ls_ProType = This.GetItemString(Row,'product_type')
	ls_ProName = This.GetItemString(Row,'Product_Name')
	
	ls_FindExp = "ctx_id = " + string(ll_ctx_id)
	
	if IsNull(ls_ProType) then
		ls_FindExp += " and IsNull(product_type)"
	else
		ls_FindExp += " and product_type = '" + ls_ProType + "'"
	end if
	
	if IsNull(ls_ProName) then
		ls_FindExp += " and IsNull(Product_Name)"
	else
		ls_FindExp += " and Product_Name = '" + ls_ProName + "'"
	end if
	
	ls_Filter = ids_search.Describe("DataWindow.Table.Filter")
	if ls_Filter <> '' and ls_Filter <> '?' then
		ids_search.SetFilter('')
		ids_search.Filter()
	end if
	
	ll_Found = ids_search.find(ls_FindExp,1,ids_search.rowcount())
	if ll_Found > 0 then
		ids_search.SetItem(ll_Found,'selected',long(data))
	end if
end if

//---------------------------- APPEON END ----------------------------

end event

type cbx_1 from u_tabpg_contract_search`cbx_1 within u_rpt_tabpg_contract_search
long backcolor = 33551856
end type

type cb_5 from u_tabpg_contract_search`cb_5 within u_rpt_tabpg_contract_search
end type

type cb_4 from u_tabpg_contract_search`cb_4 within u_rpt_tabpg_contract_search
end type

type st_vbar2 from u_tabpg_contract_search`st_vbar2 within u_rpt_tabpg_contract_search
end type

type st_hbar from u_tabpg_contract_search`st_hbar within u_rpt_tabpg_contract_search
end type

type gb_document_view from u_tabpg_contract_search`gb_document_view within u_rpt_tabpg_contract_search
end type

type tv_ctx from u_tabpg_contract_search`tv_ctx within u_rpt_tabpg_contract_search
end type

type gb_to_do_list from u_tabpg_contract_search`gb_to_do_list within u_rpt_tabpg_contract_search
end type

type st_vbar from u_tabpg_contract_search`st_vbar within u_rpt_tabpg_contract_search
end type

type st_hbar2 from u_tabpg_contract_search`st_hbar2 within u_rpt_tabpg_contract_search
end type

type cb_all from commandbutton within u_rpt_tabpg_contract_search
integer x = 9
integer y = 1900
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-08 By: Scofield
//$<Reason> Select all or deselect all.

Long ll_Cycle

SetPointer(HourGlass!)
//Added By Alan on 2009-1-5 BugE112701
of_expand_allrow()

if this.text = "Select &All" then
	if dw_search_det1.rowcount() < 1 then return
	dw_search_det1.SetRedraw(False)
	for ll_Cycle = 1 to dw_search_det1.rowcount()
		dw_search_det1.setitem(ll_Cycle,"selected",1)
		dw_search_det1.Event ItemChanged(ll_Cycle,dw_search_det1.Object.selected,'1')
	next
	dw_search_det1.SetRedraw(True)
	this.text = "&Deselect All"
else
	if dw_search_det1.rowcount() < 1 then return
	dw_search_det1.SetRedraw(False)
	for ll_Cycle = 1 to dw_search_det1.rowcount()
		dw_search_det1.setitem(ll_Cycle,"selected",0)
		dw_search_det1.Event ItemChanged(ll_Cycle,dw_search_det1.Object.selected,'0')
	next
	dw_search_det1.SetRedraw(True)
	this.text = "Select &All"
end if

SetPointer(Arrow!)
//---------------------------- APPEON END ----------------------------

end event

