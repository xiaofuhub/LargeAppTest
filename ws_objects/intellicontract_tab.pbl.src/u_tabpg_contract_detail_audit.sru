$PBExportHeader$u_tabpg_contract_detail_audit.sru
$PBExportComments$[intellicontract_tab] The contract detail notes page
forward
global type u_tabpg_contract_detail_audit from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail_audit
end type
end forward

global type u_tabpg_contract_detail_audit from u_tabpg_contract_master
integer width = 2757
integer height = 564
long backcolor = 33551856
string text = "Audit Trail"
dw_1 dw_1
end type
global u_tabpg_contract_detail_audit u_tabpg_contract_detail_audit

type variables
long il_ctx_id

Boolean		ib_Update //added by gavins 20121227
end variables

forward prototypes
public subroutine of_create_dw_ag ()
end prototypes

public subroutine of_create_dw_ag ();//////////////////////////////////////////////////////////////////////
// Function: of_create_dw_ag
// Arguments:
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	 Ken.Guo 03/07/2012.
//--------------------------------------------------------------------
// Description: //dynamic create dw.  Copy from u_tabpg_detail_detail.tabpage_1.constructor()
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id,ll_i
datawindow ld_dw[]

ls_tab_name = 'tabpage_details'

ld_dw[1] = dw_1
ls_dw_name[1] = 'dw_1'
ls_dataobject[1] = 'd_contract_det_custom_2'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		

dw_1.ib_retrieve_drop_downs = false
dw_1.event ue_populatedddws( )
dw_1.SetTransObject(SQLCA)


end subroutine

on u_tabpg_contract_detail_audit.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_contract_detail_audit.destroy
call super::destroy
destroy(this.dw_1)
end on

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail_audit
end type

type dw_1 from u_dw_contract within u_tabpg_contract_detail_audit
string tag = "Audit Trail"
integer x = 5
integer y = 8
integer width = 2743
integer height = 548
integer taborder = 10
boolean bringtotop = true
string title = "Audit Trail"
boolean hscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
string dataobject_original = "d_view_audit2_ctx"
boolean ib_use_row_selection = true
boolean ib_allow_filter = true
boolean ib_allow_sort = true
end type

event pfc_retrieve;call super::pfc_retrieve;long ll_count

ll_count = Retrieve(il_ctx_id)
if ll_count < 1 then

	//Modified By Ken.Guo 03/07/2012.  Workaround APB's Bug.
	//this.event pfc_insertrow( )
	Parent.of_create_dw_ag() 
	ll_count = Retrieve(il_ctx_id)
	If ll_count < 1 Then
		this.event pfc_insertrow( )
	End If
	parent.event ue_set_security( )  //(Appeon)Harry 02.26.2014 - for Bug # 3909: Read-Only access to a contract does not restrict access to Custom Data 2
end if

//Refresh ctx_basic_info alarm flag -- //Added By Ken.Guo 05/18/2012
string ls_datascreen[],ls_customscreen[]
ls_customscreen = {'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10','custom_date11','custom_date12','custom_date13','custom_date14','custom_date15'}
inv_contract_details.of_set_alarm_flag( dw_1 , 'ctx_custom', ls_customscreen, il_ctx_id,0,0,0)

return ll_count

end event

event pfc_prermbmenuproperty;call super::pfc_prermbmenuproperty;

am_dw.m_table.m_cut.Visible = false
am_dw.m_table.m_copy.Visible = false
am_dw.m_table.m_paste.Visible = false
am_dw.m_table.m_dash11.Visible = false
am_dw.m_table.m_insert.Visible = false
am_dw.m_table.m_addrow.Visible = false

am_dw.m_table.m_delete.Visible = false
am_dw.m_table.m_selectall.Visible = false
am_dw.m_table.m_restorerow.Visible = false


end event

event pfc_addrow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.23.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.
//
return success
//---------------------------- APPEON END ----------------------------

end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.23.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.
//
return success
//---------------------------- APPEON END ----------------------------

end event

event rbuttonup;//
end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item disabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
end if

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;if this.rowcount( ) = 1 then
	return failure
end if 
return success
end event

event constructor;call super::constructor;This.of_setupdateable( True)
this.of_Setdropdowncalendar( true)
this.of_setrowselect( false)
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;if al_row > 0 then
	OF_ENABLE_SAVE()
	This.SetItem(al_row, 'ctx_id',il_ctx_id )
end if
end event

event buttonclicked;call super::buttonclicked;//Add ability to put alarms on all custom date fields -- jervis 05.18.2011
if of_check_read_only( ) then return success 
inv_contract_details.of_set_alarm( this,'ctx_custom', dwo)

end event

event pfc_preupdate;call super::pfc_preupdate;//Set ctx_id   -- jervis 05.24.2011
long ll_i,ll_count

ll_count = this.Rowcount( )
for ll_i = 1 to ll_count
	if this.GetItemStatus( ll_i,0,Primary!) = NewModified! then
		this.SetItem( ll_i,"ctx_id", il_ctx_id)
	end if
next
return success

end event

event rbuttondown;call super::rbuttondown;inv_contract_details.of_reset_alarm( this,'ctx_custom',dwo) //jervis 07.04.2011
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_ctx_id
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_custom', dwoname,il_ctx_id, 0,0,0)
	End If
End If

end event

event pfc_postupdate;call super::pfc_postupdate;string ls_datascreen[],ls_customscreen[]

gnv_appeondb.of_startqueue( )
If ib_Update Then gnv_data.of_retrieve( "ctx_notification" )
gnv_appeondb.of_commitqueue( )
//------End Modified -----------------------------------



ls_customscreen = {'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10','custom_date11','custom_date12','custom_date13','custom_date14','custom_date15'}
inv_contract_details.of_set_alarm_flag( dw_1 , 'ctx_custom', ls_customscreen, il_ctx_id,0,0,0)


ib_Update = false
Return 1
end event

event resize;call super::resize;dw_1.y = 15				//Added By Mark Lee 01/31/2013
end event

