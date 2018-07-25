$PBExportHeader$u_tabpg_contract_multi.sru
$PBExportComments$[intellicontract_tab] The non medical fee schedule tab
forward
global type u_tabpg_contract_multi from u_tabpg_contract_master
end type
type tab_multi from u_tab_contract_multi within u_tabpg_contract_multi
end type
type tab_multi from u_tab_contract_multi within u_tabpg_contract_multi
end type
end forward

global type u_tabpg_contract_multi from u_tabpg_contract_master
integer width = 3922
integer height = 2032
string text = "Custom Multi"
string powertiptext = "Custom Multi"
event ue_set_screen_properties ( )
tab_multi tab_multi
end type
global u_tabpg_contract_multi u_tabpg_contract_multi

type variables
integer il_screen_id[]
string is_UpdateCol[]

end variables

forward prototypes
public subroutine of_create_dw ()
public function integer of_retrieve ()
public subroutine ue_locate_data (long al_hdr_id, long al_detail_id, string as_focus_column)
public subroutine ue_locate_data (long al_hdr_id, string as_focus_column)
public subroutine of_tabpage_setfocus ()
public subroutine of_locate_data (long al_hdr_id, long al_detail_id, string as_focus_column)
end prototypes

event ue_set_screen_properties();//// Set screen properties
//
//tab_1.tabpage_browse.Event ue_set_screen_properties()
//tab_1.tabpage_detail.Event ue_set_screen_properties()
//
//// Set tabpage properties
//tab_1.tabpage_browse.backcolor = this.backcolor
//tab_1.tabpage_browse.tabbackcolor = this.backcolor
//tab_1.tabpage_detail.backcolor = this.backcolor
//tab_1.tabpage_detail.tabbackcolor = this.backcolor

//Set Screen properties
this.tab_multi.tabpage_header.dw_header.of_set_properties( this.tab_multi.tabpage_header.dw_header.il_viewid , this.tab_multi.tabpage_header.dw_header.il_screenid , 'Y')
this.tab_multi.tabpage_detail.dw_browse.of_set_properties( this.tab_multi.tabpage_detail.dw_browse.il_viewid , this.tab_multi.tabpage_detail.dw_browse.il_screenid , 'Y')
this.tab_multi.tabpage_detail.dw_detail.of_set_properties( this.tab_multi.tabpage_detail.dw_detail.il_viewid , this.tab_multi.tabpage_detail.dw_detail.il_screenid , 'Y')

this.tab_multi.tabpage_header.backcolor = this.backcolor
this.tab_multi.tabpage_header.tabbackcolor = this.tabbackcolor
this.tab_multi.tabpage_detail.backcolor = this.backcolor
this.tab_multi.tabpage_detail.tabbackcolor = this.tabbackcolor



end event

public subroutine of_create_dw ();//Add by Jervis 05.30.2011
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_multi'
ld_dw[1] = this.tab_multi.tabpage_header.dw_header
ld_dw[2] = this.tab_multi.tabpage_detail.dw_browse
ld_dw[3] = this.tab_multi.tabpage_detail.dw_detail

ls_dw_name[1] = 'dw_header'
ls_dw_name[2] = 'dw_browse'
ls_dw_name[3] = 'dw_detail'

ls_dataobject[1] = 'd_contract_multi_header'
ls_dataobject[2] = 'd_contract_multi_browse'
ls_dataobject[3] = 'd_contract_multi_detail'

f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_multi',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010
end subroutine

public function integer of_retrieve ();//Add by jervis 06.01.2011
if not ib_retrieved then
	this.tab_multi.tabpage_header.of_retrieve( )
	this.tab_multi.tabpage_header.dw_header.Sharedata( this.tab_multi.tabpage_detail.dw_browse)
	 this.tab_multi.tabpage_detail.dw_browse.Event ue_populatedddws( )//added by gavins 20130221
end if

ib_retrieved = true

RETURN SUCcess
end function

public subroutine ue_locate_data (long al_hdr_id, long al_detail_id, string as_focus_column);//====================================================================
// Function: ue_locate_data
//--------------------------------------------------------------------
// Description: Locate Detail Data
//--------------------------------------------------------------------
// Arguments:
//                al_hdr_id
//                al_detail_id
//                as_focus_column
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 05/30/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


u_dw_contract ldw_data
Long ll_findrow

If al_hdr_id > 0 Then
	tab_multi.selecttab(2)
	ldw_data = tab_multi.tabpage_detail.dw_browse
	ll_findrow = ldw_data.Find('hdr_id = ' + String(al_hdr_id),1,ldw_data.RowCount())
	If ll_findrow > 0 Then
		ldw_data.Post SetFocus()
		ldw_data.ScrollToRow(ll_findrow)
		ldw_data.SetRow(ll_findrow)
		ldw_data = tab_multi.tabpage_detail.dw_detail
		If al_detail_id > 0 Then
			ll_findrow = ldw_data.Find('detail_id = ' + String(al_detail_id),1,ldw_data.RowCount())
			If ll_findrow > 0 Then
				ldw_data.Post SetFocus()
				ldw_data.ScrollToRow(ll_findrow)
				ldw_data.SetRow(ll_findrow)							
				If Len(ldw_data.describe(as_focus_column + '.type')) > 1 Then
					ldw_data.SetColumn(as_focus_column)
				End If
			End If
		End If
	End If
End If			
end subroutine

public subroutine ue_locate_data (long al_hdr_id, string as_focus_column);//====================================================================
// Function: ue_locate_data
//--------------------------------------------------------------------
// Description: Locate Header Data
//--------------------------------------------------------------------
// Arguments:
//                al_hdr_id
//                as_focus_column
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 06/19/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


u_dw_contract ldw_data
Long ll_findrow

If al_hdr_id > 0 Then
	tab_multi.selecttab(2)
	ldw_data = tab_multi.tabpage_detail.dw_browse
	ll_findrow = ldw_data.Find('hdr_id = ' + String(al_hdr_id),1,ldw_data.RowCount())
	If ll_findrow > 0 Then
		ldw_data.Post SetFocus()
		ldw_data.ScrollToRow(ll_findrow)
		ldw_data.SetRow(ll_findrow)
		If Len(ldw_data.describe(as_focus_column + '.type')) > 1 Then
			ldw_data.SetColumn(as_focus_column)
		End If		
	End If
End If			
end subroutine

public subroutine of_tabpage_setfocus ();//====================================================================
// Function:of_tabpage_setfocus
//--------------------------------------------------------------------
// Description: Make the current tabpage focus
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:        Harry           Date: 12/20/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//for BugH112902
if tab_multi.selectedtab = 1 then 
	tab_multi.tabpage_header.dw_header.Post SetFocus()
else
	tab_multi.tabpage_detail.dw_browse.Post SetFocus()
end if

end subroutine

public subroutine of_locate_data (long al_hdr_id, long al_detail_id, string as_focus_column);//====================================================================
// Function: of_locate_data
//--------------------------------------------------------------------
// Description: Locate Header/Detail Data
//--------------------------------------------------------------------
// Arguments:
//                al_hdr_id
//                al_detail_id
//                as_focus_column
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 05/30/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.23.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================


u_dw_contract ldw_data
Long ll_findrow

If al_hdr_id > 0 Then
	If al_detail_id > 0 Then
		tab_multi.selecttab(2)
		ldw_data = tab_multi.tabpage_detail.dw_browse
		ll_findrow = ldw_data.Find('hdr_id = ' + String(al_hdr_id),1,ldw_data.RowCount())
		If ll_findrow > 0 Then
			ldw_data.Post SetFocus()
			ldw_data.ScrollToRow(ll_findrow)
			ldw_data.SetRow(ll_findrow)
			ldw_data = tab_multi.tabpage_detail.dw_detail
			If al_detail_id > 0 Then
				ll_findrow = ldw_data.Find('detail_id = ' + String(al_detail_id),1,ldw_data.RowCount())
				If ll_findrow > 0 Then
					ldw_data.Post SetFocus()
					ldw_data.ScrollToRow(ll_findrow)
					ldw_data.SetRow(ll_findrow)							
					If Len(ldw_data.describe(as_focus_column + '.type')) > 1 Then
						ldw_data.SetColumn(as_focus_column)
					End If
				End If
			End If
		End If
	Else
		tab_multi.selecttab(1)
		ldw_data = tab_multi.tabpage_header.dw_header
		ll_findrow = ldw_data.Find('hdr_id = ' + String(al_hdr_id),1,ldw_data.RowCount())
		If ll_findrow > 0 Then
			ldw_data.Post SetFocus()
			ldw_data.ScrollToRow(ll_findrow)
			ldw_data.SetRow(ll_findrow)
			If Len(ldw_data.describe(as_focus_column + '.type')) > 1 Then
				ldw_data.SetColumn(as_focus_column)
			End If		
		End If	
	End IF
End If			
end subroutine

on u_tabpg_contract_multi.create
int iCurrent
call super::create
this.tab_multi=create tab_multi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_multi
end on

on u_tabpg_contract_multi.destroy
call super::destroy
destroy(this.tab_multi)
end on

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification 
of_create_dw()
//---------------------------- APPEON END ----------------------------

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( tab_multi,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_set_security;call super::ue_set_security;//Read Only control in child tab pages - added by Alfee 09.30.2007

integer          li_index, li_count 
boolean 			  lb_protect 
windowobject     lwo_temp[]
u_dw_contract    lst_temp

lwo_temp[1] = this.tab_multi.tabpage_header.dw_header
lwo_temp[2] = this.tab_multi.tabpage_detail.dw_browse
lwo_temp[3] = this.tab_multi.tabpage_detail.dw_detail

//Get & set read only flag at tab page level
lb_protect = inv_contract_details.of_get_protect_tabpg()

//Set read only flag for each data window in the child tab page
li_count = UpperBound ( lwo_temp[] ) 
FOR li_index = 1 TO li_count 
   lst_temp = lwo_temp[li_index] 
	if lb_protect then
		lst_temp.of_disable_columns( ) 
	 else
		lst_temp.of_enable_columns( )
	end if 
NEXT



end event

event pfc_postupdate;call super::pfc_postupdate;//add By Jervis 09.17.2010
//If gb_workflow Then
//	n_cst_workflow_triggers lnv_workflow
//	lnv_workflow = create n_cst_workflow_triggers
//	il_screen_id[1] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_action_items' and dw_name='dw_1' and dataobject='d_cntx_action_items'"))
//	is_UpdateCol[il_screen_id[1]] = lnv_workflow.of_getupdatecol( tab_1.tabpage_detail.dw_1 )
//	destroy lnv_workflow
//end if





return 1
end event

event ue_reset_ib_retrieve;call super::ue_reset_ib_retrieve;//Added By Ken.Guo 11/12/2012. fixed bug.
//Reason: If you create a new ctx with custom multi-tab and save the record.  Then create another CTX, the custom multi data is automatically copied over
tab_multi.tabpage_header.event ue_reset_ib_retrieve( )
tab_multi.tabpage_detail.event ue_reset_ib_retrieve( )
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_multi
integer x = 0
integer y = 1912
integer height = 80
end type

type tab_multi from u_tab_contract_multi within u_tabpg_contract_multi
integer x = 5
integer width = 3918
integer height = 2028
integer taborder = 11
boolean bringtotop = true
end type

