$PBExportHeader$u_tabpg_master_contract_search.sru
$PBExportComments$Create by Jack 03/13/2007
forward
global type u_tabpg_master_contract_search from u_tabpg_contract_search
end type
type cb_all from commandbutton within u_tabpg_master_contract_search
end type
end forward

global type u_tabpg_master_contract_search from u_tabpg_contract_search
cb_all cb_all
end type
global u_tabpg_master_contract_search u_tabpg_master_contract_search

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.15.2007 By: Jack (Contract)
//$<reason> 
long il_category
//---------------------------- APPEON END ----------------------------
Boolean ib_retrieve_all //Added By Ken.Guo 2009-06-19.
end variables

forward prototypes
public function integer of_retrieve ()
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
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_ctx_id
long la_any
STRING LS_FILTER
long ll_i,ll_current_contract
long ll_null
long ll_found

if not ib_retriev_detail then return 0
ib_retriev_detail = false
setredraw(false)
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 08.14.2006 By: Liang QingShi
//$<reason> Contract module modification 
//$<reason> Performance tuning
/*
ids_contract_access.retrieve( )
*/
//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// save current changes as needed
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

gnv_appeondb.of_startqueue()

dw_search_det1.setfilter('')
//dw_search_det1.retrieve( ) 11-22-2007 By Jervis
dw_search_det1.retrieve(UPPER(gs_user_id )) 

// The following script moved from of_build_filter().
//ids_contract_access.retrieve(UPPER(gs_user_id )) 11-22-2007 By Jervis

// Perofrmanct tuning for of_get_access
gnv_data.of_retrieve( "contract_search" )

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////
// set the contracted entity
/////////////////////////////////////////////
IF dw_search_det1.ROWCOUNT() < 1 THEN 
	setredraw(true)
	of_set_message('no rows')
	RETURN  SUCcess
end if

//Start Code By Jervis 11-22-2007 
/*
of_build_filter( )


if len(is_filter_string) > 0 then
	is_filter_string =is_filter_string +  ' and master_contract_id = 0'
else
	is_filter_string = 'master_contract_id = 0'
end if
If il_ctx_id > 0 Then
	is_filter_string = is_filter_string + " AND ctx_id <> " + string(il_ctx_id)
End If	


dw_search_det1.SETFILTER(is_filter_string)
dw_search_det1.FILTER()

dw_search_det1.title = 'Contract Browse ' + "(" + string(dw_search_det1.rowcount()) + ")"
*/
cb_3.event clicked()
//End Code By Jervis 11-22-2007 

setredraw(true)

return success
end function

on u_tabpg_master_contract_search.create
int iCurrent
call super::create
this.cb_all=create cb_all
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_all
end on

on u_tabpg_master_contract_search.destroy
call super::destroy
destroy(this.cb_all)
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>constructoru_tabpg_master_contract_search()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.15.2007 by Jack (Contract)
//////////////////////////////////////////////////////////////////////
string ls_parm,ls_company
long ll_right

this.of_getparentwindow( iw_parent)


//Added By Ken.Guo 2011-07-08.  Dynamic create dw ui as search tab
Long ll_viewid 
string ls_tab_name,ls_dw_name[],ls_dataobject[]
datawindow ld_dw[]
ls_tab_name = 'tabpage_search'
ld_dw[1] = dw_search
ld_dw[2] = dw_search_det1
ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
If gl_SearchTab_View_id = 0 Then 
                ll_viewid = 1001
Else
                ll_viewid = gl_SearchTab_View_id
End If
f_create_contract_dw(ll_viewid,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)
this.event ue_set_screen_properties( )
dw_search.Modify( "b_more.text='Less >>'")
dw_search.event ue_moreandless(false)



/*
ids_contract_access = create n_ds
ids_contract_access.dataobject = 'ds_contract_access'
ids_contract_access.settransobject(sqlca)
*/

ls_parm = message.stringparm
If ls_parm = 'ALL' Then ib_retrieve_all = True //Added By Ken.Guo 2009-06-19.

il_ctx_id = long(mid(ls_parm,1,pos(ls_parm,'-') - 1))
ls_parm = mid(ls_parm,pos(ls_parm,'-') + 1,len(ls_parm))

il_category = long(mid(ls_parm,1,pos(ls_parm,'+') -1))

ls_company = mid(ls_parm,pos(ls_parm,'+') + 1,len(ls_parm))

//iw_parent.title = ls_company + ' - Select Master Contract' //Modified By Ken.Guo 2009-06-19
If ib_retrieve_all Then
	iw_parent.title = 'Select Contract'
Else
	iw_parent.title = ls_company + ' - Select Master Contract'
End If



//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-13 By: Scofield
//$<Reason> Add the right to turn off the more button.

ll_Right = w_mdi.of_security_access(2081)
if ll_Right = 0 then
	dw_search.Object.b_more.Visible = false
	//dw_search.Object.b_clear.X = Long(dw_search.Object.owner.X) + Long(dw_search.Object.owner.Width) - Long(dw_search.Object.b_clear.Width)
	dw_Search.Object.b_clear.x = dw_Search.Object.b_search.x
	dw_Search.Object.b_search.x = dw_Search.Object.b_more.x
end if
//---------------------------- APPEON END ----------------------------

end event

event ue_set_security;//Override ancestor script;
end event

type st_1 from u_tabpg_contract_search`st_1 within u_tabpg_master_contract_search
end type

type cb_2 from u_tabpg_contract_search`cb_2 within u_tabpg_master_contract_search
end type

event cb_2::clicked;//Override ancestor script;

Long ll_rowcount, ll_loop, ll_ctx, ll_facility_id, ll_found, ll_rows_company
Integer li_selected
String ls_return, ls_company
DatawindowChild ldwc_company
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.13.2007 By: Jack (Contract)
//$<reason> 
/*
dw_search_det1.GetChild( "app_facility", ldwc_company )
ll_rows_company = ldwc_company.Rowcount()

ll_rowcount = dw_search_det1.rowcount()
For ll_loop = 1 to ll_rowcount
	li_selected = dw_search_det1.GetItemNumber( ll_loop, "selected" )
	if isnull( li_selected ) then li_selected = 0
	
	if li_selected = 0 then continue;

	ll_ctx = dw_search_det1.GetItemNumber( ll_loop, "ctx_id" )
	ll_facility_id = dw_search_det1.GetItemNumber( ll_loop, "app_facility" )
	ll_found = ldwc_company.Find( "facility_id = " + string(ll_facility_id), 1, ll_rows_company )
	if ll_found > 0 then
		ls_company = ldwc_company.GetItemString( ll_found, "facility_name" )
	else
		ls_company = string( ll_ctx )
	end if

	ls_return += string( ll_ctx ) + '~t' + ls_company + '|'
Next

if ls_return <> '' then ls_return = Left( ls_return, Len( ls_return ) - 2 )
CloseWithReturn( iw_parent, ls_return )
*/
long ll_ctx_id,ll_row
ll_row = dw_search_det1.getrow()
If ll_row < 1 Then Return
If ll_row > 0 Then
	ll_ctx_id = dw_search_det1.GetItemNumber( ll_row, "ctx_id" )
	If isnull(ll_ctx_id) Then ll_ctx_id = 0      //add by Jack 03/21/2007
	ls_company = dw_search_det1.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_row)+" )") //add by Jack 03/21/2007
End If
//CloseWithReturn(iw_parent,ll_ctx_id)  //Comment by Jack 03/21/2007
CloseWithReturn(iw_parent,string(ll_ctx_id) + '-' + ls_company)  //add by Jack 03/21/2007
//---------------------------- APPEON END ----------------------------

end event

type cb_1 from u_tabpg_contract_search`cb_1 within u_tabpg_master_contract_search
end type

event cb_1::clicked;dw_search_det1.ib_retrieve_drop_downs = false
parent.ib_retriev_detail = true
parent.of_retrieve( )
parent.ib_retriev_detail = false
dw_search_det1.event ue_populatedddws( )

if ib_PostOpen then
	ib_PostOpen  = false
	return
end if

end event

type cb_3 from u_tabpg_contract_search`cb_3 within u_tabpg_master_contract_search
end type

event cb_3::clicked;//Modified By Alan on 2009-1-16
if ib_retriev_detail = true then
	cb_1.triggerevent("clicked")
else
	of_build_filter( )
	
	//Start Code By Jervis 11-22-2007 
	If ib_retrieve_all Then//Added By Ken.Guo 2009-06-19.
		//Added By Ken.Guo 2009-06-19.
	Else
//Commented By Ken.Guo 2009-12-23. Support Treeview mode, so support multi-level
//		if len(is_filter_string) > 0 then
//			is_filter_string =is_filter_string +  ' and (master_contract_id = 0 or isnull(master_contract_id) )'
//		else
//			is_filter_string = '(master_contract_id = 0 or isnull(master_contract_id) ) '
//		end if
		If il_ctx_id > 0 Then
			If len(is_filter_string) = 0 Then
				is_filter_string = "ctx_id <> " + string(il_ctx_id)
			Else
				is_filter_string = is_filter_string + " AND ctx_id <> " + string(il_ctx_id)
			End If
		End If	
	End If
	
	dw_search_det1.SETFILTER(is_filter_string)
	dw_search_det1.FILTER()
	
	dw_search_det1.title = 'Contract Browse ' + "(" + string(dw_search_det1.rowcount()) + ")"

	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2007-08-17 By: Scofield
	//$<Reason> If there is no row and isn't called by post_open event,then give use a message.
	if dw_search_det1.RowCount() < 1 then
		iw_parent.title = 'IntelliContract'
		MessageBox(gnv_app.iapp_object.DisplayName,'No search result. Could be because:~r~n1) None of the contracts in the system meet your search criteria.~r~n2) The company you selected has no contracts associated with then.~r~n3) You do not have access to some contracts based on your contract category security settings. ~r~nPlease see administrator.')
	end if
	//---------------------------- APPEON END ----------------------------
end if



end event

type cb_print from u_tabpg_contract_search`cb_print within u_tabpg_master_contract_search
end type

type dw_search from u_tabpg_contract_search`dw_search within u_tabpg_master_contract_search
integer height = 500
string dataobject = "d_contract_search"
end type

event dw_search::constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.22.2007 By: Jack (Export)
//$<reason> Fix a defect.
If dw_search.getrow() > 0 Then
	If il_category = 0 Then setnull(il_category)
//	dw_search.setitem(dw_search.getrow(),'category',il_category)  //Modified By Alan on 2009-1-16
	is_category = string(il_category)
	this.modify("b_quick_filter1.visible='0' b_quick_filter2.visible='0' b_quick_filter3.visible='0'") //(Appeon)Harry 09.11.2014 - for  V14.2 Testing / Bug# 4213
End If
//---------------------------- APPEON END ----------------------------

end event

type dw_search_det1 from u_tabpg_contract_search`dw_search_det1 within u_tabpg_master_contract_search
integer y = 532
integer height = 1340
string dataobject = "d_sp_contract_search"
end type

event dw_search_det1::clicked;//Override ancestor script;
if IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) then return
if IsValid (inv_Sort) then inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.21.2007 By: Jack (Export)
//$<reason>Fix a defect.
If row < 1 Then Return
This.SetRow(row) //Added By Ken.Guo 07/26/2012
This.SelectRow(0, FALSE)
This.SelectRow(row, TRUE)
//---------------------------- APPEON END ----------------------------

end event

event dw_search_det1::constructor;//Override ancestor script;

of_settransobject( sqlca)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_sort.of_setusedisplay( TRUE )

//Added By Alan on 2009-1-16
ib_retriev_detail = true
end event

event dw_search_det1::doubleclicked;//Override ancestor script;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.14.2007 By: Jack (Contract)
//$<reason> 
cb_2.triggerevent(clicked!)
//---------------------------- APPEON END ----------------------------

end event

event dw_search_det1::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.13.2007 By: Jack (Contract)
//$<reason> 
IF Rowcount() = 0 THEN RETURN

if currentrow < 1 or isnull(currentrow) then
	return success
end if 
This.SelectRow(0, FALSE)
This.SelectRow(currentrow, TRUE)
//---------------------------- APPEON END ----------------------------

end event

event dw_search_det1::rowfocuschanging;//Override ancestor script;
end event

type cbx_1 from u_tabpg_contract_search`cbx_1 within u_tabpg_master_contract_search
end type

type cb_5 from u_tabpg_contract_search`cb_5 within u_tabpg_master_contract_search
end type

type cb_4 from u_tabpg_contract_search`cb_4 within u_tabpg_master_contract_search
end type

type st_vbar2 from u_tabpg_contract_search`st_vbar2 within u_tabpg_master_contract_search
end type

type st_hbar from u_tabpg_contract_search`st_hbar within u_tabpg_master_contract_search
end type

type gb_document_view from u_tabpg_contract_search`gb_document_view within u_tabpg_master_contract_search
end type

type tv_ctx from u_tabpg_contract_search`tv_ctx within u_tabpg_master_contract_search
end type

type gb_to_do_list from u_tabpg_contract_search`gb_to_do_list within u_tabpg_master_contract_search
end type

type st_vbar from u_tabpg_contract_search`st_vbar within u_tabpg_master_contract_search
end type

type st_hbar2 from u_tabpg_contract_search`st_hbar2 within u_tabpg_master_contract_search
end type

type cb_all from commandbutton within u_tabpg_master_contract_search
boolean visible = false
integer x = 64
integer y = 1912
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

event clicked;Long i

if this.text = "Select &All" then
	if dw_search_det1.rowcount() < 1 then return
	dw_search_det1.SetRedraw(False)
	for i = 1 to dw_search_det1.rowcount()
		dw_search_det1.setitem(i,"selected",1)
	next
	dw_search_det1.SetRedraw(True)
	this.text = "&Deselect All"
else
	if dw_search_det1.rowcount() < 1 then return
	dw_search_det1.SetRedraw(False)
	for i = 1 to dw_search_det1.rowcount()
		dw_search_det1.setitem(i,"selected",0)
	next
	dw_search_det1.SetRedraw(True)
	this.text = "Select &All"
end if
end event

