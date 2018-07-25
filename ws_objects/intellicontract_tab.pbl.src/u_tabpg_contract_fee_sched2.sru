$PBExportHeader$u_tabpg_contract_fee_sched2.sru
$PBExportComments$[intellicontract_tab] The non medical fee schedule tab
forward
global type u_tabpg_contract_fee_sched2 from u_tabpg_contract_master
end type
type dw_fee_nm from u_dw_contract within u_tabpg_contract_fee_sched2
end type
end forward

global type u_tabpg_contract_fee_sched2 from u_tabpg_contract_master
integer width = 4137
integer height = 2036
long backcolor = 33551856
string text = "Fee Schedules"
string powertiptext = "Non Health care fee schedule"
event ue_set_screen_properties ( )
event pfc_cst_duplicate ( )
dw_fee_nm dw_fee_nm
end type
global u_tabpg_contract_fee_sched2 u_tabpg_contract_fee_sched2

type variables
long il_max_id

integer il_screen_id[]
string is_UpdateCol[]

end variables

forward prototypes
public function integer of_get_max_id ()
public function integer of_retrieve ()
public subroutine of_create_dw ()
public subroutine of_set_flag (u_dw adw_alm)
public subroutine of_goto_row (long al_fee_nm_id, string as_column)
public subroutine of_post_goto_row (long al_fee_nm_id, string as_column)
end prototypes

event ue_set_screen_properties();// Set screen properties
dw_fee_nm.of_set_properties(dw_fee_nm.il_ViewID, dw_fee_nm.il_ScreenID, "Y")
end event

event pfc_cst_duplicate();//Add by jer vis 12.17.2010

dw_fee_nm.event pfc_cst_duplicate()
end event

public function integer of_get_max_id ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_max_id
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 21 April 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



long ll_ctx_id




ll_ctx_id =  inv_contract_details.of_get_ctx_id( )

if il_max_id = 0 then 
		SELECT max(fee_sched_nm_id)
		INTO  :il_max_id
		FROM ctx_fee_sched_nm  
		WHERE ctx_id = :ll_ctx_id;
end if 


if ll_ctx_id =  0 or isnull(il_max_id) then 
	il_max_id = 1
else
	il_max_id = il_max_id + 1
end if


return il_max_id

end function

public function integer of_retrieve ();



if not ib_retrieved then 
	dw_fee_nm.event pfc_retrieve( )
	ib_retrieved = true
end if



return success
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_fee_sched2of_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>Contract module modification 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.27.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_fee_sched2'
ld_dw[1] = dw_fee_nm
ls_dw_name[1] = 'dw_fee_nm'
ls_dataobject[1] = 'd_contract_fee_sched_nm'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_fee_sched2',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010
end subroutine

public subroutine of_set_flag (u_dw adw_alm);
long	ll_ctx_id
string ls_customscreen[]
long ll_i,ll_count,ll_level_id1
long ll_k,ll_colcount

ll_ctx_id = inv_contract_details.of_get_ctx_id( )
ll_count = adw_alm.rowcount()



//Refresh ctx_fee_sched_nm  alarm flag -- jervis 08.03.2011
ls_customscreen = {'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5'}

ll_colcount = UpperBound(ls_customscreen)
FOR ll_i = 1 to ll_count
	ll_level_id1 = adw_alm.GetItemNumber( ll_i,'fee_sched_nm_id')
	for ll_k = 1 to ll_colCount
		adw_alm.SetItem( ll_i, ls_customscreen[ll_k] + "_flag", f_set_ai_flag('ctx_fee_sched_nm', ls_customscreen[ll_k],ll_ctx_id,0, ll_level_id1 ,0))
	next
	adw_alm.SetItemStatus(ll_i, 0, Primary!, NotModified!)	
NEXT
adw_alm.Post setredraw(true) //for PB refresh bug - 03.11.2008 



end subroutine

public subroutine of_goto_row (long al_fee_nm_id, string as_column);//====================================================================
// Function: of_goto_row
//--------------------------------------------------------------------
// Description:  Go to target row and column
//--------------------------------------------------------------------
// Arguments:
//                al_fee_nm_id
//                as_column
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/04/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.23.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

Long ll_find

ll_find = dw_fee_nm.Find('fee_sched_nm_id = ' + String (al_fee_nm_id), 1, dw_fee_nm.RowCount() )
If ll_find > 0 Then
	dw_fee_nm.ScrolltoRow(ll_find)
	dw_fee_nm.SetRow(ll_find)
	dw_fee_nm.SetColumn(as_column)
	dw_fee_nm.SetFocus()
End If
end subroutine

public subroutine of_post_goto_row (long al_fee_nm_id, string as_column);// (Appeon)Harry 01.23.2014 - V142 ISG-CLX Copy from CLX12.0
This.Post of_goto_row( al_fee_nm_id, as_column)
end subroutine

on u_tabpg_contract_fee_sched2.create
int iCurrent
call super::create
this.dw_fee_nm=create dw_fee_nm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fee_nm
end on

on u_tabpg_contract_fee_sched2.destroy
call super::destroy
destroy(this.dw_fee_nm)
end on

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification 
of_create_dw()
//---------------------------- APPEON END ----------------------------

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( dw_fee_nm,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_initinstancevar;call super::ue_initinstancevar;il_max_id = 0
end event

event pfc_updateprep;call super::pfc_updateprep;//add By Jervis 09.17.2010
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	il_screen_id[1] = 31 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_fee_sched2' and dw_name='dw_fee_nm' and dataobject='d_contract_fee_sched_nm'"))
	is_UpdateCol[il_screen_id[1]] = lnv_workflow.of_getupdatecol(dw_fee_nm )
	destroy lnv_workflow
end if

return 1
end event

event pfc_postupdate;call super::pfc_postupdate;gnv_data.of_retrieve( "ctx_all_notification") //jervis 07.07.2011
of_set_flag( dw_fee_nm )  //added by gavins 20121226
return 1
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_fee_sched2
integer x = 0
integer y = 1912
integer height = 80
end type

type dw_fee_nm from u_dw_contract within u_tabpg_contract_fee_sched2
event pfc_cst_duplicate ( )
string tag = "Fee Schedule (Non Healthcare)"
integer x = 9
integer y = 16
integer width = 3849
integer height = 1992
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Fee Schedule (Non Healthcare)"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
string dataobject_original = "d_contract_fee_sched_nm"
end type

event pfc_cst_duplicate();//Duplicate Fee Record - jervis 12.16.2010
long ll_row

if of_check_read_only() then return 
ll_row = dw_fee_nm.GetRow()
if ll_row > 0 then
	OpenWithParm(w_copy_fee_nm,dw_fee_nm)
end if
end event

event constructor;call super::constructor;

this.of_SetDropDownCalendar(TRUE)
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: LeiWei
//$<reason> Performance tuning.
/*
this.iuo_calendar.of_Register("start_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("end_date", this.iuo_calendar.DDLB_WITHARROW	)
*/
//---------------------------- APPEON END ----------------------------

SetRowFocusIndicator(Hand!)

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
**  Created By	: Michael B. Skinner 21 April 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long ll_i
long ll_rowcount
ll_rowcount = rowcount()


for ll_i = 1 to ll_rowcount
		if not f_validstr(string(this.getItemNumber(ll_i,'ctx_id')) )	 THEN
			setitem(ll_i,'ctx_id', inv_contract_details.of_get_ctx_id( )  )
			setitem(ll_i,'fee_sched_nm_id', of_get_max_id() )
			 	
		end if 
	
next


return success
end event

event updateend;call super::updateend;il_max_id = 0 
decimal ldec_calc_1
decimal ldec_calc_2
decimal ldec_calc_3
long ll_ctxid

//Update the fee sched fields in the Custom tab-jervis 07.19.2010
if this.RowCount( ) > 0  then
	ll_ctxid = inv_contract_details.of_get_ctx_id( ) 
	ldec_calc_1 = this.getitemdecimal( 1, "calc_field_1")
	ldec_calc_2 = this.getitemdecimal( 1, "calc_field_2")
	ldec_calc_3 = this.getitemdecimal( 1, "calc_field_3")
	gnv_appeondb.of_startqueue( )
	Update ctx_basic_info set fee_sched_calc_field_1 = :ldec_calc_1 where ctx_id = :ll_ctxid;
	Update ctx_basic_info set fee_sched_calc_field_2 = :ldec_calc_2 where ctx_id = :ll_ctxid;
	Update ctx_basic_info set fee_sched_calc_field_3 = :ldec_calc_3 where ctx_id = :ll_ctxid;
	commit;
	gnv_appeondb.of_commitqueue( )
	
end if
end event

event pfc_retrieve;call super::pfc_retrieve;

this.retrieve(inv_contract_details.of_get_ctx_id( ) )
of_set_flag(this)   //jervis 08.06.2011
return success
end event

event retrieveend;call super::retrieveend;
if rowcount < 1 then 
	event pfc_addrow( )
END IF

end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.08.2006 By: Liang QingShi
//$<reason> Fix a defect.

Integer	li_Rtn

if this.ib_read_only then return NO_ACTION //Added by Alfee 09.30.2007

if This.RowCount() <= 0 then return success

li_Rtn = MessageBox('Delete confirm','Are you sure you want to delete this record?',Question!,YesNo!,2)

if li_Rtn <> 1 then return success

Super::Event pfc_deleteRow()

OF_ENABLE_SAVE( )
return success
//---------------------------- APPEON END ----------------------------

end event

event rbuttondown;call super::rbuttondown;inv_contract_details.of_reset_alarm( this,'ctx_fee_sched_nm',dwo) //jervis 8.03.2011
end event

event buttonclicked;call super::buttonclicked;//Add ability to put alarms on all custom date fields -- jervis 08.03.2011
if of_check_read_only( ) then return success 
this.SetRow( row)
inv_contract_details.of_set_alarm( this,'ctx_fee_sched_nm', dwo)



end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_ctx_id,ll_level_id1
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
ll_ctx_id = inv_contract_details.of_get_ctx_id()
ll_level_id1 = GetItemNumber(getrow(),'fee_sched_nm_id')

If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_fee_sched_nm', dwoname,ll_ctx_id, 0,ll_level_id1,0)
	End If
End If


end event

