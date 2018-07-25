$PBExportHeader$u_tabpg_contract_multi_header.sru
$PBExportComments$[intellicontract_tab] The non medical fee schedule tab
forward
global type u_tabpg_contract_multi_header from u_tabpg_contract_master
end type
type dw_header from u_dw_contract within u_tabpg_contract_multi_header
end type
end forward

global type u_tabpg_contract_multi_header from u_tabpg_contract_master
integer width = 3922
integer height = 2032
string text = "Header"
string powertiptext = "Custom multi header"
dw_header dw_header
end type
global u_tabpg_contract_multi_header u_tabpg_contract_multi_header

type variables
long il_max_id

integer il_screen_id[]
string is_UpdateCol[]

end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_set_flag (u_dw adw_alm)
end prototypes

public function integer of_retrieve ();if not ib_retrieved then 
	dw_header.event pfc_retrieve( )
	ib_retrieved = true
end if
return success
end function

public subroutine of_set_flag (u_dw adw_alm);//modified by gaivns 20121217

//long	ll_ctx_id, ll_count, ll_i, ll_hdr_id
//string ls_datascreen[],ls_customscreen[]
//
//ll_ctx_id = inv_contract_details.of_get_ctx_id()
//
////Refresh ctx_basic_info alarm flag -- jervis 05.19.2011
//ls_customscreen = {'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10'}
//
//ll_count = adw_alm.rowcount()
//FOR ll_i = 1 to ll_count
//	ll_hdr_id = adw_alm.GetItemNumber( ll_i,'hdr_id')
//	inv_contract_details.of_set_alarm_flag( adw_alm, 'ctx_custom_multi_hdr', ls_customscreen, ll_ctx_id,0,ll_hdr_id,0)
//NEXT


long	ll_ctx_id
string ls_customscreen[]
long ll_i,ll_count,ll_hdr_id
long ll_k,ll_colcount

ll_ctx_id = inv_contract_details.of_get_ctx_id( )
ll_count = adw_alm.rowcount()



//Refresh ctx_custom_mulit_hdr alarm flag -- jervis 07.07.2011
ls_customscreen = {'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10'}

ll_colcount = UpperBound(ls_customscreen)
FOR ll_i = 1 to ll_count
	ll_hdr_id = adw_alm.GetItemNumber( ll_i,'hdr_id')
	for ll_k = 1 to ll_colCount
		adw_alm.SetItem( ll_i, ls_customscreen[ll_k] + "_flag", f_set_ai_flag('ctx_custom_multi_hdr', ls_customscreen[ll_k],ll_ctx_id,0, ll_hdr_id ,0))
	next
	adw_alm.SetItemStatus(ll_i, 0, Primary!, NotModified!)	
NEXT
adw_alm.Post setredraw(true) //for PB refresh bug - 03.11.2008


end subroutine

on u_tabpg_contract_multi_header.create
int iCurrent
call super::create
this.dw_header=create dw_header
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_header
end on

on u_tabpg_contract_multi_header.destroy
call super::destroy
destroy(this.dw_header)
end on

event pfc_updateprep;call super::pfc_updateprep;//add By Jervis 09.17.2010
//If gb_workflow Then
//	n_cst_workflow_triggers lnv_workflow
//	lnv_workflow = create n_cst_workflow_triggers
//	il_screen_id[1] = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_fee_sched2' and dw_name='dw_header' and dataobject='d_contract_fee_sched_nm'"))
//	is_UpdateCol[il_screen_id[1]] = lnv_workflow.of_getupdatecol(dw_header )
//	destroy lnv_workflow
//end if

return 1
end event

event ue_selectionchanged;call super::ue_selectionchanged;dw_header.Setfocus( )
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_multi_header
integer x = 0
integer y = 1912
integer height = 80
end type

type dw_header from u_dw_contract within u_tabpg_contract_multi_header
string tag = "Header"
integer width = 3858
integer height = 1904
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Header"
boolean hscrollbar = true
boolean livescroll = false
string dataobject_original = "d_contract_fee_sched_nm"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(TRUE)

of_enable_alarm(TRUE)
end event

event pfc_preupdate;call super::pfc_preupdate;

/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 21 April 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long ll_i
long ll_rowcount
ll_rowcount = rowcount()


for ll_i = 1 to ll_rowcount
	if this.GetItemStatus( ll_i,0,primary!) = NewModified! then
		setitem(ll_i,'ctx_id', inv_contract_details.of_get_ctx_id( )  )
		setitem(ll_i,'hdr_id', gnv_app.of_get_id('multi_ID'))
	end if 
next
return success
end event

event pfc_retrieve;call super::pfc_retrieve;long	ll_ctx_id


ll_ctx_id = inv_contract_details.of_get_ctx_id( )
this.retrieve( ll_ctx_id)

of_set_flag(this)

return success
end event

event retrieveend;call super::retrieveend;if rowcount < 1 then 
	event pfc_addrow( )
END IF

end event

event pfc_deleterow;
Integer	li_Rtn
long ll_hdr_id,ll_ctx_id

if this.ib_read_only then return NO_ACTION //Added by Alfee 09.30.2007

if This.RowCount() <= 0 then return success

li_Rtn = MessageBox('Delete confirm','Are you sure you want to delete this record?',Question!,YesNo!,2)

if li_Rtn <> 1 then return success

ll_hdr_id = this.GetItemNumber( this.GetRow(),"hdr_id")
ll_ctx_id = inv_contract_details.Of_get_ctx_id( )
delete ctx_custom_multi_detail where ctx_id = :ll_ctx_id and hdr_id = :ll_hdr_id;
//Added By Mark Lee 06/14/2013 record to the log of delete in the table sys_audit for the contract multi header.
this.rowscopy(  this.GetRow(), this.GetRow(), Primary!, this,1, Delete!)
Super::Event updateend(0,0,this.GetRow())

Super::Event pfc_deleteRow()
this.Update( )

return success


end event

event getfocus;call super::getfocus;if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', True)
	
	if This.RowCount() > 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', true)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', false)
	end if
	
	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.visible = True
	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', True)	
end if

end event

event buttonclicked;call super::buttonclicked;//Add ability to put alarms on all custom date fields -- jervis 06.27.2011
if of_check_read_only( ) then return success 
this.SetRow( row)
inv_contract_details.of_set_alarm( this,'ctx_custom_multi_hdr', dwo)


of_set_flag( this  )//added by gavins 20121217
end event

event rbuttondown;call super::rbuttondown;inv_contract_details.of_reset_alarm( this,'ctx_custom_multi_hdr',dwo) //jervis 07.07.2011
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_ctx_id,ll_level_id1
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
ll_ctx_id = inv_contract_details.of_get_ctx_id()
ll_level_id1 = getitemnumber(getrow(),'hdr_id')

If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_custom_multi_hdr', dwoname,ll_ctx_id, 0,ll_level_id1,0)
	End If
End If

end event

