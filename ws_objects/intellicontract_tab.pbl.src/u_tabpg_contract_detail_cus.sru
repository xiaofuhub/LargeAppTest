$PBExportHeader$u_tabpg_contract_detail_cus.sru
$PBExportComments$[intellicontract_tab] The custom data screen
forward
global type u_tabpg_contract_detail_cus from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail_cus
end type
end forward

global type u_tabpg_contract_detail_cus from u_tabpg_contract_master
integer width = 2789
integer height = 596
long backcolor = 33551856
dw_1 dw_1
end type
global u_tabpg_contract_detail_cus u_tabpg_contract_detail_cus

on u_tabpg_contract_detail_cus.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_contract_detail_cus.destroy
call super::destroy
destroy(this.dw_1)
end on

event pfc_validation;call super::pfc_validation;If isvalid(iw_parent) Then
	Return 1
End If
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail_cus
end type

type dw_1 from u_dw_contract within u_tabpg_contract_detail_cus
string tag = "Custom Data"
integer y = 8
integer width = 2747
integer height = 520
integer taborder = 10
boolean bringtotop = true
string title = "Custom Data"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
string dataobject_original = "d_contract_det_custom"
end type

event pfc_deleterow;//Override

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.14.2006 By: LeiWei
//$<reason> Fix a defect.

return success

//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;////Added for Work Flow trigger. 11.21.2006 Henry
//long	 ll_screen_id
//long	 ll_ctx_id
//
//ll_ctx_id = this.getitemnumber( this.GetRow(), "ctx_id")
//if not ll_ctx_id > 0 Then RETURN success
//
//ll_screen_id = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_custom'"))
//If gb_workflow Then
//	n_cst_workflow_triggers lnv_workflow
//	lnv_workflow = create n_cst_workflow_triggers
//	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_ctx_id, 0, '03', 'I')
//	Destroy lnv_workflow
//End If
////End added 11.21.2006
RETURN success
end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.24.2007 By: Jack 
//$<reason> Add ability to put alarms on all custom date fields.
string ls_datatype, ls_dwoname,ls_ColName
str_pass lstr_pass 
long ll_ctx_id

if of_check_read_only( ) then return success  //Add by Jack 08.30.2007


//Added By Ken.Guo 2010-01-07.
accepttext()
if not f_validstr(string(this.getItemNumber(1,'ctx_id'))) then
	IF iw_parent.EVENT DYNAMIC UE_SAVE() <> SUCcess THEN RETURN  
end if 

//This.accepttext()
ll_ctx_id = This.getitemnumber(This.getrow(),'ctx_id')
ls_dwoname = lower( dwo.name )

if left( ls_dwoname , 2 ) = "b_" then
	ls_datatype = This.Describe( Right(ls_dwoname, Len(ls_dwoname) - 2 ) + ".ColType" )
end if

//--------Begin Added by Alfee 09.27.2007-----------------------------
//Return if the alarm disabled to the current contract stauts
String ls_contract_status, ls_alarm_enabled, ls_msg

IF Lower(ls_datatype) = 'datetime' and IsValid(gw_contract) THEN
	IF gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.RowCount() > 0 THEN 
		ls_contract_status = String(gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.GetItemNumber(1, 'status'))
	END IF
	IF NOT IsNull(ls_contract_status) THEN ls_alarm_enabled = gnv_data.of_getitem('code_lookup','custom_1',"lookup_name = 'Contract Status' and lookup_code = " + ls_contract_status)
	IF Upper(ls_alarm_enabled) <> 'YES' THEN
		ls_msg = "Alarms can't be set because the Contract Status you have selected has the Alarmed Enabled flag set to No.  "
		ls_msg +="To change this setting go to the System->Lookup Painter and select the Contract Status lookup table and change the Alarms Enabled Flag to Yes." 
		MessageBox("Contract Alarms", ls_msg)
		RETURN
	END IF
	
	//Add by jervis - 07.05.2011
	ls_ColName = Mid(dwo.Name,3)
	This.SetColumn(ls_ColName)
	if Of_Show_Missing_Msg(ls_ColName, This,ls_datatype,1) = SUCCESS then
		lstr_pass.s_string_array[1] = String(ll_ctx_id)
		lstr_pass.s_string_array[2] = 'ctx_basic_info'
		lstr_pass.s_string_array[3] = ls_ColName
		lstr_pass.s_string_array[4] = This.Describe(ls_ColName + "_t.Text")
		lstr_pass.s_string_array[5] = '0'
		lstr_pass.s_string_array[6] = '0'
		lstr_pass.s_string_array[7] = '0'
		lstr_pass.s_datetime[1] = this.GetItemDateTime( row, ls_ColName)
		OpenWithParm(w_ctx_alarm, lstr_pass)
		This.SetColumn(ls_ColName)
	end if
		
	
END IF
//--------End Added --------------------------------------------------

SetPointer(HourGlass!)
//use modify expresstion - jervis 10.21.2011
dw_1.Modify( "b_custom_date1.filename='" +  f_set_flag('ctx_basic_info', 'custom_date1', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date2.filename='" +  f_set_flag('ctx_basic_info', 'custom_date2', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date3.filename='" + f_set_flag('ctx_basic_info', 'custom_date3', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date4.filename='" +  f_set_flag('ctx_basic_info', 'custom_date4', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date5.filename='" +  f_set_flag('ctx_basic_info', 'custom_date5', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date6.filename='" +  f_set_flag('ctx_basic_info', 'custom_date6', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date7.filename='" + f_set_flag('ctx_basic_info', 'custom_date7', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date8.filename='" +  f_set_flag('ctx_basic_info', 'custom_date8', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date9.filename='" + f_set_flag('ctx_basic_info', 'custom_date9', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date10.filename='" +  f_set_flag('ctx_basic_info', 'custom_date10', ll_ctx_id,0,0,0) + "'")
dw_1.Modify( "b_custom_date11.filename='" +   f_set_flag('ctx_basic_info', 'custom_date11', ll_ctx_id,0,0,0)+ "'")
dw_1.Modify( "b_custom_date12.filename='" +   f_set_flag('ctx_basic_info', 'custom_date12', ll_ctx_id,0,0,0)+ "'")
dw_1.Modify( "b_custom_date13.filename='" +   f_set_flag('ctx_basic_info', 'custom_date13', ll_ctx_id,0,0,0)+ "'")
dw_1.Modify( "b_custom_date14.filename='" +   f_set_flag('ctx_basic_info', 'custom_date14', ll_ctx_id,0,0,0)+ "'")
dw_1.Modify( "b_custom_date15.filename='" +   f_set_flag('ctx_basic_info', 'custom_date15', ll_ctx_id,0,0,0)+ "'")

iw_parent.Function Dynamic Of_Set_Validation(True) // Add by Jack 05/04/2007
SetPointer(Arrow!)
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.02.2007 By: Jack 
//$<reason> Fix a defect.
dw_1.of_SetDropDownCalendar(TRUE)
dw_1.event ue_populatedddws( )
//---------------------------- APPEON END ----------------------------

of_enable_alarm(TRUE)//for alarm message by alfee 09.05.2007

end event

event pfc_addrow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.23.2007 By: Jack
//$<reason> Fix a defect.
Return 1
//---------------------------- APPEON END ----------------------------

end event

event rbuttondown;call super::rbuttondown;inv_contract_details.of_reset_alarm( this,'ctx_basic_info',dwo) //jervis 07.04.2011

/*

//Added by Alfee 09.05.2007
//<$Reason>If a user clears a date then the alarm for that date should also be cleared out.
	
long ll_ctxid, ll_row
string colname, ls_msg, ls_filename
boolean lb_alarm = TRUE //01.26.2008
BOOLEAN lb_refresh_ai = FALSE	

colname = dwo.name

if this.Describe("DataWindow.ReadOnly") = "yes" or this.Describe(colname + ".protect") <> "0" or this.Describe(colname + ".TabSequence") = "0" then return

if this.Describe( colname + ".ColType") = "datetime" then
	if Not IsNull(This.GetItemDateTime(getrow(), colname) ) then return

	//ll_ctxid = inv_contract_details.of_get_ctx_id( )
	ll_ctxid = this.getitemnumber( this.GetRow(), "ctx_id")
	//lb_alarm = (f_set_flag('ctx_basic_info', colname, ll_ctxid) <> 'grayflag.bmp') - commented 01.26.2008
	//ls_msg = "Would you like to set this Date to null?"
	//if lb_alarm then ls_msg += "~r~nIf yes, the alarm setting for this field will also be cleared out." 

	//Delete the alarm setting if it's existed.
	if lb_alarm then 
		SetPointer(HourGlass!)
		gnv_appeondb.of_startqueue()
		delete from ctx_notification_users where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;
		delete from ctx_alarm_attachment where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;		//Added by Scofield on 2009-02-24
		delete from ctx_notification where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;
		delete from ctx_action_items where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ;  		//Added By Ken.Guo 2009-09-16. //alfee 12.09.2008	
		delete from ctx_alm_snooze   where ctx_id = :ll_ctxid and alm_table = 'ctx_basic_info' and alm_column = :colname ; 		//Added By Ken.Guo 2009-09-16.
		gnv_appeondb.of_commitqueue()
		if sqlca.sqlcode = 0 then 
			ls_msg = "lower(alm_table) = 'ctx_basic_info' and upper(alm_column) = '" + upper(colname) + "' "
			ls_msg +=" and ctx_id = " + String(ll_ctxid)
			ll_row = gnv_data.ids_ctx_notification.Find(ls_msg, 1, gnv_data.ids_ctx_notification.Rowcount())	
			if ll_row > 0 then gnv_data.ids_ctx_notification.DeleteRow(ll_row)
		end if

		//Checking if action items need to be refreshed
		IF gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.rowcount( ) > 0 OR &
			gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.FilteredCount( ) > 0 OR &
			gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.DeletedCount( ) > 0 THEN
			lb_refresh_ai = TRUE
		END IF	

		//Added By Ken.Guo 2009-09-16. //Refresh action items if needed - alfee 12.09.2008 
		IF lb_refresh_ai THEN 
			gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.of_retrieve() 
		END IF

		//Reset the flag for the button	
		ls_filename = f_set_flag('ctx_basic_info', colname, ll_ctxid)
		this.modify("b_"+ colname + ".FileName ='" + ls_filename + "'")
	end if		
end if		
*/


end event

event editchanged;call super::editchanged;// Added by Alfee 09.06.2007
//<$Reason>If clear out a date field, then clear out the alarm setting too.
string colname 
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" then
	if len(data) > 0 then return
	event rbuttondown(1, 1, row, dwo)
end if
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

event ue_post_itemchanged;call super::ue_post_itemchanged;
//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_ctx_id
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
ll_ctx_id = getitemnumber( this.GetRow(), "ctx_id")
If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_basic_info', dwoname,ll_ctx_id, 0,0,0)
	End If
End If

end event

