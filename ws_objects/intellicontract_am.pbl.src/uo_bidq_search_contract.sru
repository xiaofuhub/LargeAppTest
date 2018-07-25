$PBExportHeader$uo_bidq_search_contract.sru
forward
global type uo_bidq_search_contract from u_tabpg_contract_search
end type
end forward

global type uo_bidq_search_contract from u_tabpg_contract_search
integer width = 3835
integer height = 912
long backcolor = 33551856
event ue_dragdrop ( )
end type
global uo_bidq_search_contract uo_bidq_search_contract

type variables
boolean ib_AttachAll = false
end variables

forward prototypes
public function integer of_setinitsize ()
public subroutine of_create_dw ()
public function integer of_refresh ()
public function integer of_search ()
public function integer of_retrieve ()
public function integer of_clearcriteria ()
public subroutine of_select_row (long al_row)
end prototypes

public function integer of_setinitsize ();dw_search.Move(9, 4)
dw_search.Resize(3803, 396)
dw_search_det1.Move(9, 412)
dw_search_det1.Resize(3803, 484)

Return 1
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_searchof_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description> Contract module modification 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.05.2008 by Evan
//////////////////////////////////////////////////////////////////////
string ls_tab_name,ls_dw_name[],ls_dataobject[]
datawindow ld_dw[]

ls_tab_name = 'tabpage_search'
ld_dw[1] = dw_search
ld_dw[2] = dw_search_det1
ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
f_create_contract_dw(1001, ls_tab_name, ld_dw,ls_dw_name,ls_dataobject)
//f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)
//iw_parent.function dynamic wf_set_select('tabpage_search',true) 
end subroutine

public function integer of_refresh ();cb_1.Event Clicked()

Return dw_search_det1.RowCount()
end function

public function integer of_search ();if dw_search_det1.RowCount() + dw_search_det1.FilteredCount() = 0 then
	if of_Refresh() > 0 then cb_3.Event Clicked()
else
	cb_3.Event Clicked()
end if

Return 1
end function

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

//ids_contract_access_pt.Retrieve( gs_user_id ) //Added by Ken.Guo on 2009-02-12
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

public function integer of_clearcriteria ();dw_search.Event ButtonClicked(1, 0, dw_search.object.b_clear)

Return 1
end function

public subroutine of_select_row (long al_row);//////////////////////////////////////////////////////////////////////
// $<function>uo_bidq_search_contractof_select_row()
// $<arguments>
//		value	long	al_row		
// $<returns> integer
// $<description>
// $<description> Highlight Row(s)
//////////////////////////////////////////////////////////////////////
// $<add> 01.05.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If ib_AttachAll Then
	dw_search_det1.SelectRow(0, true)		
Else
	dw_search_det1.SelectRow(0, false)
	dw_search_det1.SelectRow(al_row, true)		
	dw_search_det1.Scrolltorow(al_row)
End If

end subroutine

on uo_bidq_search_contract.create
call super::create
end on

on uo_bidq_search_contract.destroy
call super::destroy
end on

event constructor;call super::constructor;//Inherit
//Begin - Added By Mark Lee 12/17/2012
//dw_search.Modify("b_more.visible = '0'")
//dw_search.Modify("b_clear.visible = '0'")
//dw_search.Modify("b_search.visible = '0'")
dw_search.Modify("b_more.visible = '0' b_clear.visible = '0' b_search.visible = '0'")
dw_search.Modify(" b_quick_filter1.visible = '0' b_quick_filter2.visible = '0' b_quick_filter3.visible = '0' ")
//End - Added By Mark Lee 12/17/2012

end event

type st_1 from u_tabpg_contract_search`st_1 within uo_bidq_search_contract
end type

type cb_2 from u_tabpg_contract_search`cb_2 within uo_bidq_search_contract
integer x = 2907
integer y = 1032
end type

type cb_1 from u_tabpg_contract_search`cb_1 within uo_bidq_search_contract
integer x = 3278
integer y = 1032
end type

type cb_3 from u_tabpg_contract_search`cb_3 within uo_bidq_search_contract
boolean visible = true
integer x = 2537
integer y = 1032
boolean default = false
end type

type cb_print from u_tabpg_contract_search`cb_print within uo_bidq_search_contract
end type

type dw_search from u_tabpg_contract_search`dw_search within uo_bidq_search_contract
integer width = 3803
integer height = 396
boolean titlebar = false
end type

event dw_search::dragdrop;call super::dragdrop;if source.ClassName() = "dw_document" then
	Parent.TriggerEvent("ue_dragdrop")
end if
end event

event dw_search::itemchanged;//Override - jervis 04.24.2009
end event

type dw_search_det1 from u_tabpg_contract_search`dw_search_det1 within uo_bidq_search_contract
integer y = 412
integer width = 3803
integer height = 484
boolean titlebar = false
end type

event dw_search_det1::rowfocuschanged;//Override ancestor script;
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.05.2009 By: Ken.Guo
//$<reason> HighLight Row(s)
/*
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
*/
of_select_row(CurrentRow)
//---------------------------- APPEON END ----------------------------

end event

event dw_search_det1::rowfocuschanging;//Override ancestor script;
end event

event dw_search_det1::doubleclicked;//Override ancestor script;
end event

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
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.05.2009 By: Ken.Guo
	//$<reason> Highlight row(s)
	/*
	This.SelectRow(0, false)
   This.SelectRow(Row, true)
	*/
	of_select_row(row)
	//---------------------------- APPEON END ----------------------------	
	ll_ctx_id = This.GetItemNumber(Row,'ctx_id')
	
	if dwo.name = 'p_1' then
		//of_display_Row(ll_ctx_id,Row)
		of_expand_row(ll_ctx_id,row)	//jervis -7.7.2009
	ElseIf dwo.name = 'p_2' Then
		of_collapse_row(ll_ctx_id, row)
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

event dw_search_det1::dragdrop;call super::dragdrop;if source.ClassName() = "dw_document" then
	Parent.TriggerEvent("ue_dragdrop")
end if
end event

event dw_search_det1::dragwithin;call super::dragwithin;if source.ClassName() = "dw_document" and Row > 0 and not ib_AttachAll then
	this.ScrollToRow(Row)
	if not IsSelected(Row) then
		this.SelectRow(0, false)
		this.SelectRow(Row, true)
	end if
end if
end event

type cbx_1 from u_tabpg_contract_search`cbx_1 within uo_bidq_search_contract
end type

type cb_5 from u_tabpg_contract_search`cb_5 within uo_bidq_search_contract
end type

type cb_4 from u_tabpg_contract_search`cb_4 within uo_bidq_search_contract
end type

type st_vbar2 from u_tabpg_contract_search`st_vbar2 within uo_bidq_search_contract
end type

type st_hbar from u_tabpg_contract_search`st_hbar within uo_bidq_search_contract
end type

type gb_document_view from u_tabpg_contract_search`gb_document_view within uo_bidq_search_contract
end type

type tv_ctx from u_tabpg_contract_search`tv_ctx within uo_bidq_search_contract
end type

type gb_to_do_list from u_tabpg_contract_search`gb_to_do_list within uo_bidq_search_contract
end type

type st_vbar from u_tabpg_contract_search`st_vbar within uo_bidq_search_contract
end type

type st_hbar2 from u_tabpg_contract_search`st_hbar2 within uo_bidq_search_contract
end type

