$PBExportHeader$w_workflow_painter_app.srw
forward
global type w_workflow_painter_app from w_sheet
end type
type cb_2 from commandbutton within w_workflow_painter_app
end type
type tv_results from u_tvs within w_workflow_painter_app
end type
type cb_1 from commandbutton within w_workflow_painter_app
end type
type cb_add_status from u_cb within w_workflow_painter_app
end type
type cb_delete_status from u_cb within w_workflow_painter_app
end type
type cb_close from u_cb within w_workflow_painter_app
end type
type cb_save from u_cb within w_workflow_painter_app
end type
type cb_report from u_cb within w_workflow_painter_app
end type
type cb_properties from u_cb within w_workflow_painter_app
end type
type cb_delete from u_cb within w_workflow_painter_app
end type
type cb_copy from u_cb within w_workflow_painter_app
end type
type cb_new from u_cb within w_workflow_painter_app
end type
type dw_search from u_dw within w_workflow_painter_app
end type
type gb_1 from groupbox within w_workflow_painter_app
end type
type gb_2 from groupbox within w_workflow_painter_app
end type
type tab_1 from tab within w_workflow_painter_app
end type
type tabpage_types from userobject within tab_1
end type
type dw_action_type_detail from u_dw_workflow within tabpage_types
end type
type tabpage_types from userobject within tab_1
dw_action_type_detail dw_action_type_detail
end type
type tabpage_status from userobject within tab_1
end type
type dw_action_status_detail from u_dw_workflow within tabpage_status
end type
type tabpage_status from userobject within tab_1
dw_action_status_detail dw_action_status_detail
end type
type tab_1 from tab within w_workflow_painter_app
tabpage_types tabpage_types
tabpage_status tabpage_status
end type
end forward

global type w_workflow_painter_app from w_sheet
integer width = 4539
integer height = 2332
string title = "Work Flow Manager Painter"
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 33551856
event ue_new ( )
event ue_copy ( )
event ue_delete ( )
event ue_properties ( )
event ue_report ( )
event type integer ue_updatecheck ( integer ai_type )
cb_2 cb_2
tv_results tv_results
cb_1 cb_1
cb_add_status cb_add_status
cb_delete_status cb_delete_status
cb_close cb_close
cb_save cb_save
cb_report cb_report
cb_properties cb_properties
cb_delete cb_delete
cb_copy cb_copy
cb_new cb_new
dw_search dw_search
gb_1 gb_1
gb_2 gb_2
tab_1 tab_1
end type
global w_workflow_painter_app w_workflow_painter_app

type variables
long  	il_wf_id , il_step_id
long 		il_view_id	//jervis 03.12.2009
boolean 	ib_autocommit
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.19.2007 By: Machongmin
//$<reason> Fix a defect.
long il_parent
//---------------------------- APPEON END ----------------------------
long il_h_parent_p  //01/16/2008 By Jervis

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 05.30.2007 By: Scofield
//$<reason> to save the last CC value
String	is_ToUser,is_ByUser,is_SendToUser,is_ccUser,is_To_Notify,is_cc_notify,is_To_reminder,is_cc_reminder,is_To_message,is_cc_message
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< ADD  > 2007-12-12 By: Scofield
//$<Reason> Add contract variable.
CONSTANT STRING CONTRACT_CONTACT_TYPE = "**Contact Type**"
CONSTANT STRING TYPE_LIST = "** Typed List **"
CONSTANT STRING CONTACT_TYPE_LOOKUP_NAME = "Contract Contact Type"
//---------------------------- APPEON END ----------------------------
str_dashboard str_para//Added by Nova on 2008-08-13
Boolean ib_auto_locate
end variables

forward prototypes
public function integer of_double_check_steps (integer ai_step)
public subroutine of_retrive_action_details (integer al_currentrow)
public function boolean of_double_check_status (integer ai_currentrow, string as_column)
public subroutine of_refresh_email_dddw (datawindow adw_detail, string as_column)
public subroutine of_refresh_steps_status_dddw (long al_wokflow_id, string as_type, integer al_step_id)
public function integer of_fill_tree ()
public function integer of_find_tvitem (integer al_parent_data, integer al_son_data)
public function integer of_lookup_search_dddw (datawindow adw_1, string as_colname, string as_cancelvalue, string as_lookupname)
public subroutine of_checkemail (long al_contacttype, boolean ab_send)
public function string of_get_module (long ai_wf_id)
public subroutine of_dashboard (long ai_wf_id)
public function integer of_resize ()
end prototypes

event ue_new();str_parm  lstr_parm
DataWindowChild ldwc_child
long ll_ins
String	ls_module

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.09.2007 By: Machongmin
//$<reason> Fix a defect.
tab_1.tabpage_types.dw_action_type_detail.accepttext()
tab_1.tabpage_status.dw_action_status_detail.accepttext()
//Verify the data has been modified
if tab_1.tabpage_types.dw_action_type_detail.modifiedcount() > 0 then
	MessageBox("Save", "You need to first save the action types record before inserting new record." )
	return 
end if

if tab_1.tabpage_status.dw_action_status_detail.modifiedcount() > 0 then
	MessageBox("Save", "You need to first save the action status record before inserting new record." )
	return 
end if
//---------------------------- APPEON END ----------------------------


If dw_search.getrow() >0 Then
	ls_module = dw_search.getitemstring(dw_search.getrow() , 'wf_module')
	If not isnull(ls_module) Then lstr_parm.s_module = ls_module
End If

lstr_parm.s_type = "new"
openwithparm(w_workflow_properties,lstr_parm)

lstr_parm = Message.Powerobjectparm
//Added by Alan on 2008-12-09
if not isvalid(lstr_parm) then return
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.30.2007 By: Machongmin
//$<reason> Fix a defect.	
/*
if lstr_parm.s_type = "ok" and dw_search.Rowcount() > 0 and lstr_parm.s_module = dw_search.GetItemString(1,"wf_module") then
	//dw_search.SetItem(1,"wf_module",lstr_parm.s_module)
//	dw_search.GetChild("wf_id" , ldwc_child)
//	ldwc_child.Settransobject(SQLCA)
//	ldwc_child.retrieve( lstr_parm.s_module)
//	ll_ins = ldwc_child.insertrow( 1 )
	//ldwc_child.setitem(ll_ins , 'wf_id' , -9999)
	dw_search.Event ItemChanged(1,dw_search.Object.wf_module,dw_search.GetItemString(1,"wf_module"))
end if
*/
if lstr_parm.s_type = "ok" and dw_search.Rowcount() > 0 then
	dw_search.SetItem(1,"wf_module",lstr_parm.s_module)
	dw_search.GetChild("wf_id" , ldwc_child)
	ldwc_child.Settransobject(SQLCA)
	ldwc_child.retrieve( lstr_parm.s_module)
	dw_search.Event ItemChanged(1,dw_search.Object.wf_module,dw_search.GetItemString(1,"wf_module"))
	dw_search.setitem(1,"wf_id",lstr_parm.l_wf_id)
	dw_search.Event ItemChanged(1,dw_search.Object.wf_id,string(lstr_parm.l_wf_id))
end if
//---------------------------- APPEON END ----------------------------
end event

event ue_copy();str_parm  lstr_parm
datawindowchild ldwc_child
long ll_ins

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.09.2007 By: Machongmin
//$<reason> Fix a defect.
tab_1.tabpage_types.dw_action_type_detail.accepttext()
tab_1.tabpage_status.dw_action_status_detail.accepttext()
//Verify the data has been modified
if tab_1.tabpage_types.dw_action_type_detail.modifiedcount() > 0 then
	MessageBox("Save", "You need to first save the action types record before inserting new record." )
	return 
end if

if tab_1.tabpage_status.dw_action_status_detail.modifiedcount() > 0 then
	MessageBox("Save", "You need to first save the action status record before inserting new record." )
	return 
end if
//---------------------------- APPEON END ----------------------------


lstr_parm.l_wf_id = dw_search.GetItemNumber( 1,"wf_id")
if isnull(lstr_parm.l_wf_id) then lstr_parm.l_wf_id = 0

if not lstr_parm.l_wf_id > 0 then
	Messagebox("Message" , "You should select a Work Flow first.")
	return
end if

lstr_parm.s_type = "copy"

lstr_parm.s_module = dw_search.GetItemString( 1,"wf_module")
openwithparm(w_workflow_properties,lstr_parm)
lstr_parm = message.powerobjectparm
//Added by Alan on 2008-12-09
if not isvalid(lstr_parm) then return
if lstr_parm.s_type = "ok" and dw_search.Rowcount() > 0 and lstr_parm.s_module = dw_search.GetItemString(1,"wf_module") then
	//dw_search.SetItem(1,"wf_module",lstr_parm.s_module)
//	dw_search.GetChild("wf_id" , ldwc_child)
//	ldwc_child.Settransobject(SQLCA)
//	ldwc_child.retrieve( lstr_parm.s_module)
//	ll_ins = ldwc_child.insertrow( 1 )
	//ldwc_child.setitem(ll_ins , 'wf_id' , -9999)
	dw_search.Event ItemChanged(1,dw_search.Object.wf_module,dw_search.GetItemString(1,"wf_module"))
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 2007-08-21 By: Evan
	//$<Reason> Refresh records.
	/*
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.09.2007 By: Machongmin
	//$<reason> Fix a defect.	
	long ll_wf_id
	ll_wf_id = dw_search.GetItemnumber(1,"wf_id")
	if isnull(ll_wf_id) or ll_wf_id = 0 then
		dw_search.Event ItemChanged(1,dw_search.Object.wf_id,"")
	end if
	//---------------------------- APPEON END ----------------------------
	*/
	dw_search.SetItem(1, "wf_id", lstr_parm.l_wf_id)
	dw_search.Event ItemChanged(1, dw_search.Object.wf_id, String(lstr_parm.l_wf_id))
	//---------------------------- APPEON END ----------------------------
end if
  

end event

event ue_delete();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_delete
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:Delete a Work Flow record
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
if isnull(il_wf_id) then il_wf_id = 0 
If Not il_wf_id > 0 Then
	MessageBox("Delete Work Flow" , "You should select a Work Flow first.")
	Return
End If

//If is_wf_status <> "A" Then
if gnv_data.of_getitem( "wf_workflow", "wf_status","wf_id = " + string(il_wf_id)) <> "A" then
	MessageBox("Delete Work Flow" , "You can't delete the Work Flow when the status of Work Flow is not 'Active'.")
	Return
End If

//----------Begin Added by Alfee 03.18.2008----------------
Long ll_cnt1, ll_cnt2, ll_cnt3,ll_Row
String ls_msg
//Check in the tables depending on work flow tables
gnv_appeondb.of_startqueue( )
Select count(*) into :ll_cnt1 From ctx_acp_template where wf_id = :il_wf_id ;
Select count(*) into :ll_cnt2 From ctx_acp_document where wf_id = :il_wf_id ;
Select count(*) into :ll_cnt3 From ctx_am_action_item where wf_id = :il_wf_id ;
gnv_appeondb.of_commitqueue( )

IF ll_cnt1 > 0 THEN
	ls_msg = "This work flow has been used in agreement template painter and cannot be deleted!"  
ELSEIF ll_cnt2 > 0 THEN 
	ls_msg = "This work flow has been used in document library painter and cannot be deleted!"  	
ELSEIF ll_cnt3 > 0 THEN
	ls_msg = "This work flow has been used in action item of document manager and cannot be deleted!" 	
END IF
IF len(Trim(ls_msg)) > 0 THEN 
	MessageBox("Delete Work Flow", ls_msg)
	RETURN 
END IF
//----------End Added -------------------------------------

If MessageBox("Delete Work Flow" , "Are you sure to delete this Work Flow?", question!,yesno!) = 1 Then
	ll_Row = tab_1.tabpage_types.dw_action_type_detail.GetRow()
	tab_1.tabpage_types.dw_action_type_detail.SetItemStatus(ll_Row,0,Primary!,NotModified!)			//Added by Scofield on 2009-01-05
	
	ll_Row = tab_1.tabpage_status.dw_action_status_detail.GetRow()
	tab_1.tabpage_status.dw_action_status_detail.SetItemStatus(ll_Row,0,Primary!,NotModified!)		//Added by Scofield on 2009-01-05
	
	//Delete the details for the current
	
	gnv_appeondb.of_startqueue( )
	//Delete the advanced update - jervis 10.25.2010
	delete wf_advanced_update_criteria where wf_id = :il_wf_id;
	delete wf_advanced_update where wf_id = :il_wf_id;
	
	
	//Delete the action status of action type
	Delete wf_action_status Where wf_id = :il_wf_id;
	
	//Delete the action type of work flow
	Delete wf_action_types Where wf_id = :il_wf_id;
	
	//Delete trigger parameters
	Delete wf_trigger_param_action_status Where wf_id = :il_wf_id;
	Delete wf_trigger_param_agreement_creation Where wf_id = :il_wf_id;
	Delete wf_trigger_param_data_comparison Where wf_id = :il_wf_id;
	
	//Delete the work flow favorite
	DELETE FROM dashboard_gadgets_favorite WHERE UPPER(favorite_type) = 'WF' AND data_id = :il_wf_id;	//Added by Scofield on 2009-08-07
	
	//delete the work flow
	Delete wf_workflow Where wf_id = :il_wf_id;
	
	Commit;
	gnv_appeondb.of_commitqueue( )
	
	
	dw_search.Event ItemChanged(1,dw_search.Object.wf_module,dw_search.GetItemString(1,"wf_module"))
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.09.2007 By: Machongmin
	//$<reason> Fix a defect.	
	long ll_wf_id
	ll_wf_id = dw_search.GetItemnumber(1,"wf_id")
	if isnull(ll_wf_id) or ll_wf_id = 0 then
		dw_search.Event ItemChanged(1,dw_search.Object.wf_id,"")
	end if
	//---------------------------- APPEON END ----------------------------
End If

if IsValid(w_DashBoard) then w_DashBoard.Of_Refres_All_Tabs()				//Added by Scofield on 2009-08-07

end event

event ue_properties();str_parm  lstr_parm
datawindowchild ldwc_child
long ll_ins

lstr_parm.l_wf_id = dw_search.GetItemNumber( 1,"wf_id")
if isnull(lstr_parm.l_wf_id) then lstr_parm.l_wf_id = 0

if not lstr_parm.l_wf_id > 0 then
	Messagebox("Message" , "You should select a Work Flow first.")
	return
end if


lstr_parm.s_type = "properties"
//.l_wf_id = dw_search.GetItemNumber( 1,"wf_id")
openwithparm(w_workflow_properties,lstr_parm)

lstr_parm = message.Powerobjectparm
//Added by Alan on 2008-12-09
if not isvalid(lstr_parm) then return
if lstr_parm.s_type = "ok" and lstr_parm.s_module = dw_search.GetItemString(1,"wf_module") then
	dw_search.GetChild("wf_id" , ldwc_child)
	ldwc_child.Settransobject(SQLCA)
	ldwc_child.retrieve( lstr_parm.s_module)
	ll_ins = ldwc_child.insertrow( 1 )
	//ldwc_child.setitem(ll_ins , 'wf_id' , -9999)
end if
end event

event ue_report();IF (IsNull(il_wf_id) or not il_wf_id > 0) THEN 
	Messagebox("Message" , "You should select a Work Flow first.")
	RETURN
end if
IF dw_search.RowCount() < 1 THEN RETURN

String ls_Module
ls_Module = dw_search.GetItemString(1, "wf_module")
OpenWithParm(w_work_flow_report, String(il_wf_id) + ls_Module)
end event

event type integer ue_updatecheck(integer ai_type);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_updatecheck
//
//	Arguments:  none
// ai_type:check type 
//				1-Work Flow changed 
//				2-Action Type of Work Flow Changed for current row
//				3-all changed
//	Returns:  none
//
//	Description:Check and save
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

integer li_msg,li_count

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007.08.20 By: Frank.Gui
//$<reason> 
IF tab_1.tabpage_types.dw_action_type_detail.accepttext( ) < 1 THEN return 1
IF tab_1.tabpage_status.dw_action_status_detail.accepttext( ) < 1 THEN return 1
//---------------------------- APPEON END ----------------------------


//Save data when row focus changed
choose case ai_type
	case 1		//action status changed
		li_count = tab_1.tabpage_status.dw_action_status_detail.modifiedcount( )
	case 2		//action type changed of current row
		DWItemStatus ldw_status
		ldw_status = tab_1.tabpage_types.dw_action_type_detail.GetItemStatus( tab_1.tabpage_types.dw_action_type_detail.Getrow(),0,primary!)
		if ldw_status = NewModified! or ldw_status = DataModified! then
			li_count = tab_1.tabpage_status.dw_action_status_detail.modifiedcount( ) + 1
		else
			li_count =tab_1.tabpage_status.dw_action_status_detail.modifiedcount( )
		end if
	case 3
		li_count =  tab_1.tabpage_types.dw_action_type_detail.modifiedcount() + tab_1.tabpage_status.dw_action_status_detail.modifiedcount( )
end choose
	
if li_count > 0 then
	li_msg = of_MessageBox ("ue_updatecheck", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 08/21/2007 By: Ken.Guo
			//$<reason> 
			//If this.Event pfc_save() >= 0 Then
			If cb_save.Event clicked() >= 0 Then
			//---------------------------- APPEON END ----------------------------
			// Successful update
				Return 0
			else
				return 1
			End If
		Case 2
			// NO - without saving changes
			Return 0
		Case 3
			// CANCEL -  Prevent
			return 1
	end choose
end if
return 0
	
end event

public function integer of_double_check_steps (integer ai_step);
return 1
end function

public subroutine of_retrive_action_details (integer al_currentrow);datawindowchild ldwc_child
long 	ll_wf_id , ll_step_id
string	ls_action_type
String	ls_module
//Retrieve the action type details
If not al_currentrow > 0 Then return

tab_1.tabpage_status.dw_action_status_detail.reset( )

ll_wf_id = tab_1.tabpage_types.dw_action_type_detail.GetItemnumber(al_currentrow , 'wf_id')
ll_step_id = tab_1.tabpage_types.dw_action_type_detail.GetItemnumber(al_currentrow , 'step_id')
if isnull(ll_step_id) Then ll_step_id = 0 

//If the Action Types record is new then no action type details in it
If not ll_wf_id >0 or not ll_step_id > 0 Then return

//Make retrieve calls contained into queue label
//gnv_appeondb.of_startqueue()

tab_1.tabpage_status.dw_action_status_detail.retrieve( ll_wf_id , ll_step_id)

//
//of_refresh_steps_status_dddw(ll_wf_id , '2' , ll_step_id)

//dw_action_status_detail.GetChild('action_status_id' , ldwc_child)
//ldwc_child.settransobject(SQLCA)
//ls_module = dw_search.GetItemString(1 , 'wf_module')
//Choose Case ls_module
//	Case '01'
//		ls_action_type = 'Credentials Verification Response'
//	Case '02'
//		ls_action_type = 'Action Status'
//	Case '03'
//		ls_action_type = 'Contract Action Status'
//	Case '04'
//		ls_action_type = 'Agreement Manager Action Status'
//End Choose
//ldwc_child.retrieve(ls_action_type)
//
//dw_action_status_detail.GetChild('trigger_flow' , ldwc_child)
//ldwc_child.settransobject(SQLCA)
//ldwc_child.retrieve(ls_module)
//
//dw_action_status_detail.GetChild('mail_notify' , ldwc_child)
//ldwc_child.settransobject(SQLCA)
//ldwc_child.retrieve(ls_module)
//
//dw_action_status_detail.GetChild('mail_reminder' , ldwc_child)
//ldwc_child.settransobject(SQLCA)
//ldwc_child.retrieve(ls_module)
//
//dw_action_status_detail.GetChild('mail_message' , ldwc_child)
//ldwc_child.settransobject(SQLCA)
//ldwc_child.retrieve(ls_module)
//
//gnv_appeondb.of_commitqueue()

end subroutine

public function boolean of_double_check_status (integer ai_currentrow, string as_column);long	i 
long	ll_cnt

//Make sure there is one item is seted as the initial status
For i = 1 to tab_1.tabpage_status.dw_action_status_detail.RowCount()
	if i = ai_currentrow Then continue
	If tab_1.tabpage_status.dw_action_status_detail.GetItemString(i , as_column) = 'Y' Then ll_cnt++
Next

If ll_cnt > 0 Then
	return true
Else
	return false
End if
end function

public subroutine of_refresh_email_dddw (datawindow adw_detail, string as_column);
Long ll_Email_ID
String ls_email_name, ls_Module, ls_email
DataWindowChild ldwc_email

ls_module = dw_search.getitemstring(dw_search.getrow() , 'wf_module')

OpenWithParm(w_email_painter, 'Y'+ls_module)

ll_Email_ID = Message.DoubleParm

////--------------------------- APPEON BEGIN ---------------------------
////$<Add> 11.27.2006 By: Jervis
////$<reason> 
////If ll_Email_ID = 0 Then return 
//If ll_Email_ID = 0 Then 
//	ll_Email_ID = adw_detail.GetItemNumber(adw_detail.getrow(),as_column,primary!,true)
//	if ll_Email_ID = -1 then SetNull(ll_Email_ID)
//	adw_detail.setitem(adw_detail.getrow() , as_column , ll_Email_ID)
//else
////---------------------------- APPEON END ----------------------------
//	adw_detail.getchild(as_column ,  ldwc_email)
//	ldwc_email.settransobject(sqlca)
//	
//	ldwc_email.retrieve(ls_module)
//	ldwc_email.InsertRow(1)
//	ldwc_email.InsertRow(1)
//	ldwc_email.SetItem(1,"email_name","(NONE)")
//	
//	ldwc_email.SetItem(2,"email_name","*Add Email*")
//	ldwc_email.SetItem(2,"email_id", -1)
//	
//	adw_detail.setitem(adw_detail.getrow() , as_column , ll_Email_ID)
//end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-04-20 By: Wu ZhiJun
//$<reason> Fix a bug

If ll_Email_ID = 0 Then
	ll_Email_ID = adw_detail.GetItemNumber(adw_detail.getrow(),as_column,primary!,true)
	if ll_Email_ID = -1 then SetNull(ll_Email_ID)
end if

adw_detail.getchild(as_column ,  ldwc_email)
ldwc_email.settransobject(sqlca)

ldwc_email.retrieve(ls_module)
ldwc_email.InsertRow(1)
ldwc_email.InsertRow(1)

ldwc_email.SetItem(2,"email_name","*Add Email*")
ldwc_email.SetItem(2,"email_id", -1)

adw_detail.setitem(adw_detail.getrow() , as_column , ll_Email_ID)

//--------------------------- APPEON END -----------------------------

//adw_detail.accepttext()

end subroutine

public subroutine of_refresh_steps_status_dddw (long al_wokflow_id, string as_type, integer al_step_id);DatawindowChild ldwc_child

If not al_wokflow_id > 0 Then return 


Choose Case as_type
	Case '1'
		tab_1.tabpage_status.dw_action_status_detail.getchild('set_status' , ldwc_child)
		ldwc_child.settransobject(SQLCA)
		ldwc_child.reset( )
		
		tab_1.tabpage_status.dw_action_status_detail.getchild('set_step' , ldwc_child)
		ldwc_child.settransobject(SQLCA)
		ldwc_child.retrieve( al_wokflow_id)
		
		ldwc_child.insertrow(1)
		//ldwc_child.setitem(1 , 'step_name' , '(NONE)')
	Case '2'
		tab_1.tabpage_status.dw_action_status_detail.getchild('set_status' , ldwc_child)
		ldwc_child.settransobject(SQLCA)
		ldwc_child.retrieve( al_wokflow_id , al_step_id)
		
		ldwc_child.insertrow(1)
		//ldwc_child.setitem(1 , 'status_name' , '(NONE)')
	Case '3'
		tab_1.tabpage_status.dw_action_status_detail.getchild('set_step' , ldwc_child)
		ldwc_child.settransobject(SQLCA)
		ldwc_child.retrieve( al_wokflow_id)
		
		ldwc_child.insertrow(1)
		//ldwc_child.setitem(1 , 'step_name' , '(NONE)')
		
		tab_1.tabpage_status.dw_action_status_detail.getchild('set_status' , ldwc_child)
		ldwc_child.settransobject(SQLCA)
		ldwc_child.retrieve( al_wokflow_id , al_step_id)
		
		ldwc_child.insertrow(1)
		//ldwc_child.setitem(1 , 'status_name' , '(NONE)')
End Choose
		

end subroutine

public function integer of_fill_tree ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.15.2007 By: machongmin
//$<reason> To retrieve to do list item.

LONG ll_row,ll_rowcnt
STRING ls_tdl_module
STRING ls_tdl_name
STRING ls_verbiage
LONG ll_tdl_id, ll_tdl_id_previous
LONG ll_tdli_id
LONG ll_lev0,ll_lev1, ll_lev2
TREEVIEWITEM ltv_item
STRING LS_Allow_Drill_Down
STRING ls_value
Integer li_pos
STRING ls_filter
INTEGER i
long ll_1
string ls_1,ls_2

SetPointer( HourGlass! )

tv_results.SetRedraw( False )

// Delete all items in the TreeView.
DO UNTIL tv_results.FindItem(RootTreeItem!, 0) = -1
    tv_results.DeleteItem( 0 )
LOOP

// level 1
ltv_item.level = 1
ltv_item.label = "Work Flow Steps"
ltv_item.data = 0
ltv_item.Expanded	= True
ltv_item.Children = false
ltv_item.Bold = TRUE
ll_lev0 = tv_results.InsertItemLast(0, ltv_item)

datastore lds_status
lds_status = create datastore
//lds_status.dataobject = dw_action_status_list.dataobject
lds_status.dataobject = tab_1.tabpage_status.dw_action_status_detail.dataobject //01-16-2008  
lds_status.settransobject(sqlca)

//dw_action_type.setsort("step_order A")
//dw_action_type.sort()
tab_1.tabpage_types.dw_action_type_detail.setsort("step_order A")
tab_1.tabpage_types.dw_action_type_detail.sort()

//FOR ll_row = 1 TO dw_action_type.Rowcount()
FOR ll_row = 1 TO tab_1.tabpage_types.dw_action_type_detail.Rowcount()
	ll_tdl_id = tab_1.tabpage_types.dw_action_type_detail.GetitemNumber( ll_row, "step_id" )
	ls_tdl_name = tab_1.tabpage_types.dw_action_type_detail.GetitemString( ll_row, "step_name" )
	if isnull(ls_tdl_name) then ls_tdl_name = ""
	ls_1 = string(tab_1.tabpage_types.dw_action_type_detail.GetitemNumber( ll_row, "step_order"))
	if isnull(ls_1 ) then ls_1 = ""
	ls_1 = left(trim(ls_1) + '    ',4)
	ls_2 = left(trim(ls_1) + '    ',4) + ls_tdl_name
	
	// level 2
	IF ll_tdl_id_previous <> ll_tdl_id THEN
		ll_tdl_id_previous = ll_tdl_id
		ltv_item.level = 2
		ltv_item.label = ls_2
		ltv_item.data = ll_tdl_id
		ltv_item.Expanded	= False
		ltv_item.Children = false
		ltv_item.Bold = TRUE
		
		ll_lev1 = tv_results.InsertItemLast(ll_lev0, ltv_item)
		
	END IF
	
	//level 3
	lds_status.retrieve(il_wf_id,ll_tdl_id)
	
	for i = 1 to lds_status.rowcount()
		ll_1 = lds_status.GetitemNumber( i, "status_id" )
		ls_1 = lds_status.Getitemstring( i, "status_name")
		if isnull(ls_1) then ls_1 = ""
		
		ltv_item.level = 3
		ltv_item.label = ls_1
		ltv_item.data = ll_1
		ltv_item.Expanded	= FALSE
		ltv_item.Bold = FALSE
		
		ll_lev2 = tv_results.InsertItemLast(ll_lev1, ltv_item)
	next
	lds_status.reset()
NEXT
if isvalid(lds_status) then
	destroy lds_status
end if
tv_results.ExpandAll(ll_lev0)	//Add By Jervis 03/15/2007
tv_results.SetRedraw( True )

SetPointer( Arrow! )

Return 1

//---------------------------- APPEON END ----------------------------
end function

public function integer of_find_tvitem (integer al_parent_data, integer al_son_data);//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.15.2007 By: Machongmin
//$<reason> Fix a defect.

long ll_h

treeviewitem ltvi_temp

ll_h = tv_results.finditem( RootTreeItem!,0)
	
if ll_h < 0 then return 0

ll_h = tv_results.finditem( ChildTreeItem!, ll_h)

do while ll_h > 0 
	tv_results.getitem(ll_h, ltvi_temp)
	if ltvi_temp.data = al_parent_data then
		if al_son_data > 0 then
			ll_h = tv_results.finditem( ChildTreeItem!, ll_h)
			do while ll_h > 0 
				tv_results.getitem(ll_h, ltvi_temp)
				if ltvi_temp.data = al_son_data then
					return ll_h
				end if
				ll_h = tv_results.finditem( NextTreeItem!,ll_h)
			loop
		else
			return ll_h
		end if
	else
		ll_h = tv_results.finditem( NextTreeItem!,ll_h)
	end if
loop

return 0
//---------------------------- APPEON END ----------------------------
end function

public function integer of_lookup_search_dddw (datawindow adw_1, string as_colname, string as_cancelvalue, string as_lookupname);long		ll_Row
String	ls_Module,ls_DoubleParm

ls_Module = dw_search.GetItemString(dw_search.GetRow() , 'wf_module')
ll_Row = adw_1.GetRow()

OpenWithParm(w_lookup_search_dddw,'C' + '@' + as_LookupName)

if Message.StringParm = "Cancel" then
	adw_1.Post SetItem(ll_Row,as_colname,as_CancelValue)
else
	adw_1.Dynamic Event ue_Refresh_dddw(false,ls_module)
	
	ls_DoubleParm = String(Message.DoubleParm)
	
	Choose Case as_ColName
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-04-08 By: Scofield
		//$<Reason> Save to_user and by_user column value

		Case 'to_user'
			is_ToUser = ls_DoubleParm
		Case 'by_user'
			is_ByUser = ls_DoubleParm
		//---------------------------- APPEON END ----------------------------
		Case 'send_to_user'
			is_SendToUser = ls_DoubleParm
		Case 'cc_user'
			is_ccUser = ls_DoubleParm
		Case 'to_notify_user'
			is_To_Notify = ls_DoubleParm
		Case 'cc_notify_user'
			is_cc_notify = ls_DoubleParm
		Case 'to_reminder_user'
			is_To_reminder = ls_DoubleParm
		Case 'cc_reminder_user'
			is_cc_reminder = ls_DoubleParm
		Case 'to_message_user'
			is_To_message = ls_DoubleParm
		Case 'cc_message_user'
			is_cc_message = ls_DoubleParm
	End Choose
	
	adw_1.Post SetItem(ll_Row,as_ColName,ls_DoubleParm)
	adw_1.Post AcceptText()
end if

return 1

end function

public subroutine of_checkemail (long al_contacttype, boolean ab_send);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-08 By: Scofield
//$<Reason> if there is no a valid email propely,popup a information dialog.

long		ll_Cnt
String	ls_ContactType

ls_ContactType = String(al_ContactType)

if ab_Send then
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	/*
	SELECT Count(*)
	  INTO :ll_Cnt
	  FROM ctx_contract_contacts,ctx_contacts,em_smtp_accounts
	 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
			 ctx_contacts.user_d = em_smtp_accounts.user_id AND
			 ctx_contract_contacts.ic_area = 'I' AND
			 ctx_contract_contacts.association = :ls_ContactType AND
			 em_smtp_accounts.Is_Default = 'Y' AND
			 em_smtp_accounts.Email is not null AND
			 RTrim(LTrim(em_smtp_accounts.Email)) <> '' AND
			 em_smtp_accounts.server is not null AND
			 RTrim(LTrim(em_smtp_accounts.server)) <> '' AND
			 em_smtp_accounts.account is not null AND
			 RTrim(LTrim(em_smtp_accounts.account)) <> '' ;
	*/
	SELECT Count(*)
	  INTO :ll_Cnt
	  FROM ctx_contract_contacts,ctx_contacts,em_smtp_accounts
	 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
			 ctx_contacts.user_d = em_smtp_accounts.user_id AND
			 ctx_contract_contacts.ic_area = 'I' AND
			 ( :ls_ContactType in ( ctx_contract_contacts.association    ,       ctx_contract_contacts.association2 ,
			  ctx_contract_contacts.association3,  ctx_contract_contacts.association4,
			 ctx_contract_contacts.association5,  ctx_contract_contacts.association6, 
			 ctx_contract_contacts.association7,  ctx_contract_contacts.association8,
			  ctx_contract_contacts.association9,  ctx_contract_contacts.association10               )  )  AND 
			 em_smtp_accounts.Is_Default = 'Y' AND
			 em_smtp_accounts.Email is not null AND
			 RTrim(LTrim(em_smtp_accounts.Email)) <> '' AND
			 em_smtp_accounts.server is not null AND
			 RTrim(LTrim(em_smtp_accounts.server)) <> '' AND
			 em_smtp_accounts.account is not null AND
			 RTrim(LTrim(em_smtp_accounts.account)) <> '' ;
	//---------End Modfiied ------------------------------------------------------
else
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	/*
	SELECT Count(*)
	  INTO :ll_Cnt
	  FROM ctx_contract_contacts,ctx_contacts,em_smtp_accounts
	 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
			 ctx_contacts.user_d = em_smtp_accounts.user_id AND
			 ctx_contract_contacts.ic_area = 'I' AND
			 ctx_contract_contacts.association = :ls_ContactType AND
			 em_smtp_accounts.Is_Default = 'Y' AND
			 em_smtp_accounts.Email is not null AND
			 RTrim(LTrim(em_smtp_accounts.Email)) <> '' ;
	*/
	SELECT Count(*)
	  INTO :ll_Cnt
	  FROM ctx_contract_contacts,ctx_contacts,em_smtp_accounts
	 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
			 ctx_contacts.user_d = em_smtp_accounts.user_id AND
			 ctx_contract_contacts.ic_area = 'I' AND
			  ( :ls_ContactType in ( ctx_contract_contacts.association    ,       ctx_contract_contacts.association2 ,
			  ctx_contract_contacts.association3,  ctx_contract_contacts.association4,
			 ctx_contract_contacts.association5,  ctx_contract_contacts.association6, 
			 ctx_contract_contacts.association7,  ctx_contract_contacts.association8,
			  ctx_contract_contacts.association9,  ctx_contract_contacts.association10               )  )  AND 
			 em_smtp_accounts.Is_Default = 'Y' AND
			 em_smtp_accounts.Email is not null AND
			 RTrim(LTrim(em_smtp_accounts.Email)) <> '' ;
end if

if ll_Cnt <= 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,"There are several Our Company contacts (that correspond to this Contact Type) that do not have an email address configured properly. Emails will not be sent successfully if you don't configure the email address correctly.")
end if
//---------------------------- APPEON END ----------------------------

end subroutine

public function string of_get_module (long ai_wf_id);  string ls_wf_module
  SELECT wf_workflow.wf_module  
    into   :ls_wf_module  
    FROM wf_workflow  
   WHERE wf_workflow.wf_id =:ai_wf_id;
	return ls_wf_module
end function

public subroutine of_dashboard (long ai_wf_id);this.dw_search.SetItem(1,"wf_module",string(of_get_module(ai_wf_id)))
this.dw_search.event ItemChanged(1,dw_search.object.wf_module,string(of_get_module(ai_wf_id)))
this.dw_search.SetItem(1,'wf_id',ai_wf_id)
this.dw_search.event ItemChanged(1,dw_search.object.wf_id,string(ai_wf_id))
If This.WindowState = Minimized! Then This.windowstate = maximized!
end subroutine

public function integer of_resize ();//Start Code Change ----08.19.2016 #V15 maha - added
long wid
long hig
long twig
long ll_topline = 204

//debugbreak()
hig = this.WorkSpaceHeight ( )
wid = this.WorkSpaceWidth( )

tab_1.y = ll_topline
gb_2.y = ll_topline

tab_1.height = hig - ll_topline - 20
gb_2.height = hig - ll_topline - 20

tv_results.y = ll_topline + 60
tv_results.height = gb_2.height - 80 

tab_1.tabpage_types.dw_action_type_detail.height = tab_1.tabpage_types.height - 12
tab_1.tabpage_status.dw_action_status_detail.height = tab_1.tabpage_status.height - 12

twig = wid/9

gb_2.width = twig * 2
tv_results.width = gb_2.width - 32
tab_1.x = gb_2.width + 24 
tab_1.width = twig * 7 - 20

tab_1.tabpage_types.dw_action_type_detail.width = tab_1.tabpage_types.width - 12
tab_1.tabpage_status.dw_action_status_detail.width = tab_1.tabpage_status.width - 12


return 1
end function

on w_workflow_painter_app.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.tv_results=create tv_results
this.cb_1=create cb_1
this.cb_add_status=create cb_add_status
this.cb_delete_status=create cb_delete_status
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_report=create cb_report
this.cb_properties=create cb_properties
this.cb_delete=create cb_delete
this.cb_copy=create cb_copy
this.cb_new=create cb_new
this.dw_search=create dw_search
this.gb_1=create gb_1
this.gb_2=create gb_2
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.tv_results
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_add_status
this.Control[iCurrent+5]=this.cb_delete_status
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_report
this.Control[iCurrent+9]=this.cb_properties
this.Control[iCurrent+10]=this.cb_delete
this.Control[iCurrent+11]=this.cb_copy
this.Control[iCurrent+12]=this.cb_new
this.Control[iCurrent+13]=this.dw_search
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.tab_1
end on

on w_workflow_painter_app.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.tv_results)
destroy(this.cb_1)
destroy(this.cb_add_status)
destroy(this.cb_delete_status)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_report)
destroy(this.cb_properties)
destroy(this.cb_delete)
destroy(this.cb_copy)
destroy(this.cb_new)
destroy(this.dw_search)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.tab_1)
end on

event pfc_begintran;call super::pfc_begintran;
ib_autocommit = sqlca.autocommit
sqlca.autocommit = false
return 1
end event

event pfc_endtran;call super::pfc_endtran;if ai_update_results < 1 then
	rollback;
else
	commit;
end if
sqlca.autocommit = ib_autocommit
return 1
end event

event pfc_preopen;call super::pfc_preopen;string ls_scale
long 	  ll_i

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )
ls_scale = this.inv_resize.scale

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ----08.19.2016 #V152 maha - removed below
//FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
//   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
//NEXT
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_types.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_types.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_status.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_status.CONTrol[LL_I]  , ls_scale )
//next


end event

event open;call super::open;//Added by Ken.Guo 2008-09-27
If Isvalid(message.powerobjectparm) Then
	If message.powerobjectparm.classname() = 'str_dashboard' Then
		str_para=message.powerobjectparm
		ib_auto_locate = True
	End If
End If

end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.23.2007 By: Jack
//$<reason> Fix a defect.
long ll_handle
If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then 
	ll_handle = handle(w_mdi)
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu )
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	w_mdi.of_menu_security( w_mdi.MenuName )
	gnv_appeondll.of_settoolbarpos(ll_handle)
End If
//---------------------------- APPEON END ----------------------------

end event

event closequery;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
// 6.0.01 Make sure the window is not minimized and behind other windows.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", &
					gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and "  + &
					"must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			//If This.Event pfc_save() >= 1 Then
			If cb_save.Event Clicked() > 0 Then	
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE
end event

event pfc_postupdate;call super::pfc_postupdate;//Added for work flow. 6/11/2006 Henry
gnv_appeondb.of_startqueue( )
gnv_data.of_retrieve('wf_workflow')	
gnv_data.of_retrieve('wf_action_types')	
gnv_data.of_retrieve('wf_action_status')	
gnv_appeondb.of_commitqueue( )
//End added for work flow.

return 1
end event

event pfc_postopen;call super::pfc_postopen; //Added by Nova on 2008-08-13
 if ib_auto_locate then of_dashboard(str_para.data_id)
end event

event resize;of_resize()
end event

type cb_2 from commandbutton within w_workflow_painter_app
integer x = 2935
integer y = 196
integer width = 315
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.09.2007 By: Machongmin
//$<reason> Fix a defect.	
str_parm  lstr_parm

lstr_parm.l_wf_id = dw_search.GetItemNumber( 1,"wf_id")
if isnull(lstr_parm.l_wf_id) then lstr_parm.l_wf_id = 0

if not lstr_parm.l_wf_id > 0 then
	Messagebox("Message" , "You should select a Work Flow first.")
	return
end if
//---------------------------- APPEON END ----------------------------
choose case tab_1.selectedtab
	case 1
		tv_results.event ue_newtypes( )
	case 2
		tv_results.event ue_newstatus( )
end choose
end event

type tv_results from u_tvs within w_workflow_painter_app
event type long ue_newtypes ( )
event type long ue_newstatus ( )
integer x = 37
integer y = 256
integer width = 969
integer height = 1936
integer taborder = 30
boolean linesatroot = true
boolean hideselection = false
end type

event type long ue_newtypes();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Machongmin
//$<reason> Fix a defect.


treeviewitem ltv_item
long ll_lev2

If tab_1.SelectedTab	<> 1 Then tab_1.selecttab( 1 )

if parent.cb_add_status.event clicked() = -1 then
	return 0
end if

ltv_item.level = 2
ltv_item.label = "**New Types**"
ltv_item.data = 0
ltv_item.Expanded	= FALSE
ltv_item.Bold = FALSE

ll_lev2 = tv_results.InsertItemLast(1, ltv_item)

this.selectitem(ll_lev2)
this.setfocus( )

return 0
//---------------------------- APPEON END ----------------------------

end event

event type long ue_newstatus();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Machongmin
//$<reason> Fix a defect.

treeviewitem ltv_item,ltv_parent
long ll_lev2,ll_row,ll_parent,ll_h

//Get the parent treeviewitem's data and then select the item
parent.tab_1.tabpage_types.dw_action_type_detail.accepttext()
ll_row = parent.tab_1.tabpage_types.dw_action_type_detail.getrow()
if ll_row > 0 then
	ll_parent = parent.tab_1.tabpage_types.dw_action_type_detail.object.step_id[ll_row]
end if
ll_h = parent.of_find_tvitem(ll_parent,0)	

if ll_h > 0 then
	if tv_results.selectitem(ll_h) = -1 then	return 0
end if

ll_lev2 = this.finditem( CurrentTreeItem!,0)
if ll_lev2 <= 0 then return 0

//insert new record in the datawindow
If tab_1.SelectedTab	<> 2 Then tab_1.selecttab( 2 )
if parent.cb_add_status.event clicked() = -1 then
	return 0
end if

if this.SelectItem(ll_lev2) <> 1 then return 0

// insert new treeviewitem
ltv_item.level = 3
ltv_item.label = "**New Status**"
ltv_item.data = 0
ltv_item.Expanded	= FALSE
ltv_item.Bold = FALSE
ll_lev2 = tv_results.InsertItemLast(ll_lev2, ltv_item)

this.selectitem(ll_lev2)
this.setfocus( )
return 0
//---------------------------- APPEON END ----------------------------
end event

event selectionchanged;call super::selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.13.2007 By: Machongmin
//$<reason> Fix a defect.


treeviewitem ltvi_selected,ltvi_parent
long ll_id,ll_level,ll_row,ll_parent,ll_h_parent	//,ll_h_parent_p

string ls_name
if newhandle <= 0 then return 

this.getitem( newhandle, ltvi_selected)

ll_id = ltvi_selected.data

ll_level = ltvi_selected.level

choose case ll_level
	case 2
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-04-15 By: Scofield
		//$<Reason> Refresh current parent handle.

		ll_h_parent = this.finditem(CurrentTreeItem!, newhandle)
		if ll_h_parent <> il_h_parent_p then
			il_h_parent_p = ll_h_parent
		end if
		//---------------------------- APPEON END ----------------------------

		ll_row = tab_1.tabpage_types.dw_action_type_detail.find("step_id = " + string(ll_id),1,tab_1.tabpage_types.dw_action_type_detail.rowcount())
		if ll_row > 0 then
			tab_1.tabpage_types.dw_action_type_detail.scrolltorow(ll_row)
			//dw_action_type.selectrow(ll_row,true)
		end if

		//dw_action_status_list.retrieve(il_wf_id,ll_id)
		tab_1.tabpage_status.dw_action_status_detail.retrieve(il_wf_id,ll_id)
		If tab_1.SelectedTab	<> 1 Then tab_1.selecttab( 1 )
	case 3
		ll_h_parent = this.finditem(ParentTreeItem!, newhandle)
		if ll_h_parent <> il_h_parent_p then
			il_h_parent_p = ll_h_parent
			this.getitem( ll_h_parent, ltvi_parent)
			ll_parent = ltvi_parent.data
			ll_row = tab_1.tabpage_types.dw_action_type_detail.find("step_id = " + string(ll_parent),1,tab_1.tabpage_types.dw_action_type_detail.rowcount())
			if ll_row > 0 then
				tab_1.tabpage_types.dw_action_type_detail.scrolltorow(ll_row)
			end if
		end if

		//ll_row = dw_action_status_list.find("status_id = " + string(ll_id),1,dw_action_status_list.rowcount())
		ll_row = tab_1.tabpage_status.dw_action_status_detail.find("status_id = " + string(ll_id),1,tab_1.tabpage_status.dw_action_status_detail.rowcount())
		if ll_row > 0 then
			//dw_action_status_list.scrolltorow(ll_row)
			//dw_action_status_list.selectrow(ll_row,true)
			tab_1.tabpage_status.dw_action_status_detail.scrolltorow(ll_row)
			//tab_1.tabpage_status.dw_action_status_detail.selectrow(ll_row,true)
		end if
		If tab_1.SelectedTab	<> 2 Then tab_1.selecttab( 2 )
end choose

//---------------------------- APPEON END ----------------------------
end event

event selectionchanging;call super::selectionchanging;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.19.2007 By: Machongmin
//$<reason> Fix a defect.

treeviewitem ltvi_new,ltvi_old
long ll_ret,ll_levelnew,ll_levelold
long ll_h_parentnew,ll_h_parentold
long ll_row

ll_ret = this.getitem(newhandle,ltvi_new) 
if ll_ret <> 1 then return 0

ll_ret = this.getitem(oldhandle,ltvi_old) 
if ll_ret <> 1 then return 0
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Machongmin
//$<reason> Fix a defect.
if (ltvi_new.label = "**New Status**" or ltvi_new.label = "**New Types**") then return 0
//---------------------------- APPEON END ----------------------------

ll_levelnew = ltvi_new.level
ll_levelold = ltvi_old.level

tab_1.tabpage_types.dw_action_type_detail.accepttext()
tab_1.tabpage_status.dw_action_status_detail.accepttext()

ll_row = tab_1.tabpage_types.dw_action_type_detail.getrow()
if ll_row > 0 then
	if tab_1.tabpage_types.dw_action_type_detail.getitemstatus(ll_row,0,Primary!) = new! or	tab_1.tabpage_types.dw_action_type_detail.getitemstatus(ll_row,0,Primary!) = newmodified! then
		MessageBox("Save", "You need to first save the action types record before selecting other item." )
		return 1
	end if
end if

ll_row = tab_1.tabpage_status.dw_action_status_detail.getrow()
if ll_row > 0 then
	if tab_1.tabpage_status.dw_action_status_detail.getitemstatus(ll_row,0,Primary!) = new! or	tab_1.tabpage_status.dw_action_status_detail.getitemstatus(ll_row,0,Primary!) = newmodified! then
		MessageBox("Save", "You need to first save the action status record before selecting other item." )
		return 1
	end if
end if


choose case ll_levelnew
	case 1,2
		//Verify the data has been modified
		if tab_1.tabpage_types.dw_action_type_detail.modifiedcount() > 0 then
			MessageBox("Save", "You need to first save the action types record before selecting other item." )
			return 1
		end if
		
		if tab_1.tabpage_status.dw_action_status_detail.modifiedcount() > 0 then
			MessageBox("Save", "You need to first save the action status record before selecting other item." )
			return 1
		end if
	case 3
		choose case ll_levelold
			case 1,2 
				//Verify the data has been modified
				if tab_1.tabpage_types.dw_action_type_detail.modifiedcount() > 0 then
					MessageBox("Save", "You need to first save the action types record before selecting other item." )
					return 1
				end if
				if tab_1.tabpage_status.dw_action_status_detail.modifiedcount() > 0 then
					MessageBox("Save", "You need to first save the action status record before selecting other item." )
					return 1
				end if
			case 3
				ll_h_parentnew = this.finditem(ParentTreeItem!, newhandle)
				ll_h_parentold = this.finditem(ParentTreeItem!, oldhandle)
				if ll_h_parentnew = ll_h_parentold then
					
					return 0
				else
					//Verify the data has been modified
					if tab_1.tabpage_types.dw_action_type_detail.modifiedcount() > 0 then
						MessageBox("Save", "You need to first save the action types record before selecting other item." )
						return 1
					end if
					
					if tab_1.tabpage_status.dw_action_status_detail.modifiedcount() > 0 then
						MessageBox("Save", "You need to first save the action status record before selecting other item." )
						return 1
					end if
					
				end if
		end choose	
end choose

//---------------------------- APPEON END ----------------------------		
	


end event

event rightclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.19.2007 By: Machongmin
//$<reason> Fix a defect.
boolean		lb_frame
long			ll_selected
window		lw_parent
window		lw_frame
window		lw_sheet
window		lw_childparent
m_tv_workflow			lm_view
treeviewitem lvi_item

// Determine if RMB popup menu should occur
if not ib_rmbmenu then
	return 1
end if

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 1
end if

// Create popup menu
if IsNull(lm_view) Or not IsValid (lm_view) then
	lm_view = create m_tv_workflow
	lm_view.of_SetParent (this)
end if

/*  Make rightclicked item the current item  */
this.SelectItem ( handle )

// we have clicked on an item
If handle > 0 Then
	
	this.getitem(handle,lvi_item)
	if isvalid(lvi_item) then
		choose case lvi_item.level
			case 1
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			/*
				lm_view.m_viewitem.m_types.enabled = True
				lm_view.m_viewitem.m_status.enabled = false
				lm_view.m_viewitem.m_delete.enabled = false
			case 2
				if lvi_item.data > 0 then
					lm_view.m_viewitem.m_status.enabled = true
				else
					lm_view.m_viewitem.m_status.enabled = false
				end if
				lm_view.m_viewitem.m_types.enabled = false
			case 3
				lm_view.m_viewitem.m_status.enabled = false
				lm_view.m_viewitem.m_types.enabled = false
			*/	
				gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_types,'enabled', True)
				gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_status,'enabled', false)
				gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_delete,'enabled', false)
			case 2
				if lvi_item.data > 0 then
					gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_status,'enabled', true)
				else
					gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_status,'enabled', false)
				end if
				gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_types,'enabled', false)
			case 3
				gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_status,'enabled', false)
				gnv_app.of_modify_menu_attr( lm_view.m_viewitem.m_types,'enabled', false)
			//---------End Modfiied ------------------------------------------------------
			case else 
				If IsValid(lm_view) Then Destroy lm_view
				return 0
		end choose
	end if
	
	lm_view.m_viewitem.m_delete.visible = True
	If this.editlabels Then
		lm_view.m_viewitem.m_rename.visible = True
	Else
		lm_view.m_viewitem.m_rename.visible = False
	End IF
Else
	// We are not on an item
	lm_view.m_viewitem.m_delete.visible = False
	lm_view.m_viewitem.m_rename.visible = False
End IF
	
this.event pfc_prermbmenu (lm_view)

lm_view.m_viewitem.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

If IsValid(lm_view) Then Destroy lm_view

return 1

//---------------------------- APPEON END ----------------------------
end event

event pfc_deleteitem;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.19.2007 By: Machongmin
//$<reason> Fix a defect.
parent.cb_delete_status.event clicked()
return 1
//---------------------------- APPEON END ----------------------------
end event

type cb_1 from commandbutton within w_workflow_painter_app
boolean visible = false
integer x = 1051
integer y = 1996
integer width = 169
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "SQL"
end type

event clicked;n_cst_workflow_sql lnv_sql

lnv_sql.of_update_version_7( )


end event

type cb_add_status from u_cb within w_workflow_painter_app
boolean visible = false
integer x = 3127
integer y = 1996
integer width = 315
integer taborder = 30
string text = "New"
end type

event clicked;call super::clicked;long		ll_CurRow,ll_Rtn
String	ls_Data

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.19.2007 By: Machongmin
//$<reason> Fix a defect.
tab_1.tabpage_types.dw_action_type_detail.accepttext()
tab_1.tabpage_status.dw_action_status_detail.accepttext()
//Verify the data has been modified
if tab_1.tabpage_types.dw_action_type_detail.modifiedcount() > 0 or tab_1.tabpage_status.dw_action_status_detail.modifiedcount() > 0 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2007-07-12 By: Scofield
	//$<Reason> when data is modified then ask the use if to save
	
	//MessageBox("Save", "You need to first save the action types record before inserting new record." )
	//return -1
	
	ll_CurRow = dw_search.GetRow()
	ls_Data = String(dw_search.GetItemNumber(ll_CurRow,'wf_id'))
	
	ll_Rtn = dw_search.Trigger Event Itemchanged(ll_CurRow,dw_search.Object.wf_id,ls_Data)
	if ll_Rtn = 1 then return -1
	//---------------------------- APPEON END ----------------------------
end if

//if tab_1.tabpage_status.dw_action_status_detail.modifiedcount() > 0 then
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 04.09.2007 By: Machongmin
//	//$<reason> Fix a defect.
//	/*
//	tab_1.selecttab(2)
//	*/
//	//---------------------------- APPEON END ----------------------------
//	MessageBox("Save", "You need to first save the action status record before inserting new record." )
//	return -1
//end if
////---------------------------- APPEON END ----------------------------

If tab_1.SelectedTab = 1 Then
	tab_1.tabpage_types.dw_action_type_detail.trigger event pfc_insertrow()
Else
	tab_1.tabpage_status.dw_action_status_detail.trigger event pfc_insertrow()
End if
end event

type cb_delete_status from u_cb within w_workflow_painter_app
integer x = 3250
integer y = 196
integer width = 315
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Machongmin
//$<reason> Fix a defect.
//
/*
If tab_1.SelectedTab = 1 Then
	If tab_1.tabpage_types.dw_action_type_detail.event pfc_deleterow() = 1 then
		cb_save.event Clicked()
	End if
Else
	If tab_1.tabpage_status.dw_action_status_detail.event pfc_deleterow() = 1 then
		cb_save.event clicked()
	End if
End if
*/

long ll_h,ll_ret
treeviewitem ltvi_temp

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.09.2007 By: Machongmin
//$<reason> Fix a defect.	
str_parm  lstr_parm

lstr_parm.l_wf_id = dw_search.GetItemNumber( 1,"wf_id")
if isnull(lstr_parm.l_wf_id) then lstr_parm.l_wf_id = 0

if not lstr_parm.l_wf_id > 0 then
	Messagebox("Message" , "You should select a Work Flow first.")
	return
end if
//---------------------------- APPEON END ----------------------------

If tab_1.SelectedTab = 1 Then
	If tab_1.tabpage_types.dw_action_type_detail.event pfc_deleterow() = 1 then
		if cb_save.event Clicked() < 0 then
			ll_h = tv_results.finditem( currenttreeitem!, 0)
			if ll_h <= 0 then return 0
			ll_ret = tv_results.getitem( ll_h, ltvi_temp)
			if ll_h <= 0 then return 0
			if ltvi_temp.label = "**New Types**" then
				tv_results.deleteitem(ll_h)
			end if
		end if
	End if
Else
	If tab_1.tabpage_status.dw_action_status_detail.event pfc_deleterow() = 1 then
		if cb_save.event Clicked() < 0 then
			ll_h = tv_results.finditem( currenttreeitem!, 0)
			if ll_h <= 0 then return 0
			ll_ret = tv_results.getitem( ll_h, ltvi_temp)
			if ll_h <= 0 then return 0
			if ltvi_temp.label = "**New Status**" then
				tv_results.deleteitem(ll_h)
			end if
		end if	
	End if
End if


//---------------------------- APPEON END ----------------------------
end event

type cb_close from u_cb within w_workflow_painter_app
integer x = 4087
integer y = 56
integer width = 315
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;call super::clicked;parent.event pfc_close()
end event

type cb_save from u_cb within w_workflow_painter_app
integer x = 3566
integer y = 196
integer width = 315
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.14.2007 By: Machongmin
//$<reason> Fix a defect.
/*
parent.event pfc_save()
*/

long ll_parent,ll_son
long ll_row
long ll_h

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.09.2007 By: Machongmin
//$<reason> Fix a defect.	
str_parm  lstr_parm

lstr_parm.l_wf_id = dw_search.GetItemNumber( 1,"wf_id")
if isnull(lstr_parm.l_wf_id) then lstr_parm.l_wf_id = 0

if not lstr_parm.l_wf_id > 0 then
	Messagebox("Message" , "You should select a Work Flow first.")
	return -1
end if
//---------------------------- APPEON END ----------------------------

if tab_1.tabpage_types.dw_action_type_detail.AcceptText() = -1 then Return -1		//Added by Scofield on 2009-01-05

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08/21/2007 By: Ken.Guo
//$<reason> BugA081406: Order of the step must is not same.
Long ll_wf_id,ll_data,ll_data_history,ll_step_id
Long ll_exsit,i,l,ll_step_order[]
long  ll_due
Boolean lb_duplicate_step_id = false
Datawindow ldw_action_type_detail
If parent.tab_1.selectedtab = 1 Then
	ldw_action_type_detail = parent.tab_1.tabpage_types.dw_action_type_detail
	ldw_action_type_detail.accepttext()
	//---------Begin Added by (Appeon)Stephen 12.20.2013 for Bug 3796 : Error Adding Workflow in IntelliCred--------
	ll_row = ldw_action_type_detail.getrow()
	if ll_row > 0 then
		ll_due = ldw_action_type_detail.getitemnumber(ll_row, "due_days")
		if isnull(ll_due) then
			ldw_action_type_detail.setitem(ll_row, "due_days", 0)
		end if
	end if
	ldw_action_type_detail.accepttext()
	//---------End Added ------------------------------------------------------
	
	//Commented it, Because it need call DB, Instead of search all data in DW
	//ll_step_id = ldw_action_type_detail.GetItemnumber(ldw_action_type_detail.GetRow(),'step_id')
	//ll_wf_id = ldw_action_type_detail.GetItemnumber(ldw_action_type_detail.GetRow(),'wf_id')
	//ll_data =  ldw_action_type_detail.GetItemnumber(ldw_action_type_detail.GetRow(),'step_order')
	////Search Duplicate Step order.
	//	If isnull(ll_step_id) Then
	//		Select 1 into :ll_exsit from wf_action_types where wf_id = :ll_wf_id and step_order = :ll_data;
	//	Else
	//		Select 1 into :ll_exsit from wf_action_types where wf_id = :ll_wf_id and step_order = :ll_data and step_id <> :ll_step_id;
	//	End If
	//	If sqlca.sqlcode = 0 Then  //Have duplicate order of the step
	
	//Search Duplicate Step order
	For i = 1 to ldw_action_type_detail.rowcount()
		ll_step_order[i] = ldw_action_type_detail.GetItemnumber(i,'step_order')
		If i = 1 Then Continue
		For l = 1 to i - 1
			If ll_step_order[i] = ll_step_order[l] Then
				lb_duplicate_step_id = True
				Continue
			End If
		Next
	Next
	If lb_duplicate_step_id Then
		Messagebox('Information','Duplicate order of the step.')
		ldw_action_type_detail.SetFocus()
		ldw_action_type_detail.SetColumn('step_order')
		Return -1
	End If
End If
//---------------------------- APPEON END ----------------------------



if parent.event pfc_save() > 0 then
	parent.tab_1.tabpage_status.dw_action_status_detail.accepttext( )
	parent.tab_1.tabpage_types.dw_action_type_detail.accepttext()
	ll_row = parent.tab_1.tabpage_types.dw_action_type_detail.getrow()
	if ll_row > 0 then
		ll_parent = parent.tab_1.tabpage_types.dw_action_type_detail.object.step_id[ll_row]
	end if
	ll_row = parent.tab_1.tabpage_status.dw_action_status_detail.getrow()
	if ll_row > 0 then
		ll_son = parent.tab_1.tabpage_status.dw_action_status_detail.object.status_id[ll_row]
	end if
	
	if	tab_1.selectedtab = 1 then
		ll_son = 0
	end if
	
	parent.of_fill_tree()
	ll_h = parent.of_find_tvitem(ll_parent,ll_son)	
	if ll_h > 0 then
		tv_results.selectitem(ll_h)
	end if
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Machongmin
//$<reason> Fix a defect.
else
	return -1
//---------------------------- APPEON END ----------------------------	
end if

return 1
//---------------------------- APPEON END ----------------------------
end event

type cb_report from u_cb within w_workflow_painter_app
integer x = 3771
integer y = 56
integer width = 315
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Report"
end type

event clicked;call super::clicked;parent.event ue_report()
end event

type cb_properties from u_cb within w_workflow_painter_app
integer x = 3456
integer y = 56
integer width = 315
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Properties"
end type

event clicked;call super::clicked;parent.event ue_properties()
end event

type cb_delete from u_cb within w_workflow_painter_app
integer x = 3141
integer y = 56
integer width = 315
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;call super::clicked;parent.event ue_delete()
end event

type cb_copy from u_cb within w_workflow_painter_app
integer x = 2825
integer y = 56
integer width = 315
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Copy"
end type

event clicked;call super::clicked;parent.event ue_copy()
end event

type cb_new from u_cb within w_workflow_painter_app
integer x = 2510
integer y = 56
integer width = 315
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "New"
end type

event clicked;call super::clicked;parent.event ue_new()
end event

type dw_search from u_dw within w_workflow_painter_app
integer x = 55
integer y = 52
integer width = 2455
integer height = 100
integer taborder = 10
string dataobject = "d_wf_workflow_search"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_set_dataobject
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
//Filter the Work Flow list base on the selected Modules
String ls_module,ls_modify
String ls_filter
long	 ll_workflow_id , ll_wf_id , ll_ins,ll_find, ll_Rtn
string ls_action_type
DataWindowChild ldwc_child

choose case dwo.name
	case 'wf_module'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2007.08.20 By: Frank.Gui
		//$<reason> 
		if parent.event ue_updatecheck(3) > 0 then 
			this.post setitem(row,'wf_module',this.getitemstring(row,'wf_module'))
			return 1
		END IF
		
		//---------------------------- APPEON END ----------------------------

		//Set Update Agreement Header Status flag
		//04-Contract Agreement 
		if data = "04" then
			tab_1.tabpage_status.dw_action_status_detail.of_set_column_enable("update_header_flag",true)
			tab_1.tabpage_status.dw_action_status_detail.of_set_column_enable("update_status_id",true)
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.13.2007 By: Machongmin
			//$<reason> Fix a defect. "0~tif(  update_header_flag = 'N', 1, 0 )" 
			tab_1.tabpage_status.dw_action_status_detail.object.update_status_id.protect = "0~tif(  update_header_flag = 'N', 1, 0 )" 
			//---------------------------- APPEON END ----------------------------
		else
			tab_1.tabpage_status.dw_action_status_detail.of_set_column_enable("update_header_flag",false)
			tab_1.tabpage_status.dw_action_status_detail.of_set_column_enable("update_status_id",false)
		end if
		
		This.GetChild("wf_id" , ldwc_child)
		ldwc_child.Settransobject(SQLCA)
		ldwc_child.reset( )
		
		ldwc_child.retrieve( data)
		ll_ins = ldwc_child.insertrow( 1 )
		//ldwc_child.setitem(ll_ins , 'wf_id' , -9999)
		
		//
		tab_1.tabpage_status.dw_action_status_detail.GetChild("set_wf_id" , ldwc_child)
		ldwc_child.Settransobject(SQLCA)
		ldwc_child.reset( )
		
		ldwc_child.retrieve( data)
		ll_ins = ldwc_child.insertrow( 1 )
		//
				
		//this.setitem(row , 'wf_id' , -9999)
		setnull(il_wf_id)
		setnull(il_view_id)	//jervis 03.12.2009
		this.SetItem(row,'wf_id',il_wf_id)
		
		tab_1.tabpage_types.dw_action_type_detail.reset( )
		tab_1.tabpage_status.dw_action_status_detail.reset( )
		
		//refresh dddw data for dddw.autoretrieve = no
		tab_1.tabpage_types.dw_action_type_detail.event ue_refresh_dddw(false,data)
		tab_1.tabpage_status.dw_action_status_detail.event ue_refresh_dddw(false,data)
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2007.08.20 By: Frank.Gui
		//$<reason> 
		IF data='03' OR data='04' THEN
			tab_1.tabpage_types.dw_action_type_detail.modify("dept_chair_flag_t.visible='0' dept_chair_flag.visible='0'")
			//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
			tab_1.tabpage_types.dw_action_type_detail.modify("gb_5.visible='1' displaylocation.visible='1'")
			tab_1.tabpage_status.dw_action_status_detail.modify("prompt_flag.visible='1' wf_esign.visible='1' t_11.visible='1' prompt_message.visible='1' b_advance.visible='1'")
			//---------End Modfiied ------------------------------------------------------
		ELSE
			tab_1.tabpage_types.dw_action_type_detail.modify("dept_chair_flag_t.visible='1' dept_chair_flag.visible='1'")
			//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
			long ll_null
			setnull(ll_null)
			tab_1.tabpage_types.dw_action_type_detail.modify("gb_5.visible='0' displaylocation.visible='0'")
			tab_1.tabpage_types.dw_action_type_detail.setitem( row, "displaylocation", ll_null)
			tab_1.tabpage_status.dw_action_status_detail.modify("prompt_flag.visible='0' wf_esign.visible='0' t_11.visible='0' prompt_message.visible='0' b_advance.visible='0'")
			tab_1.tabpage_status.dw_action_status_detail.setitem( row, "prompt_flag", "N")
			tab_1.tabpage_status.dw_action_status_detail.setitem( row, "wf_esign", "N")
			tab_1.tabpage_status.dw_action_status_detail.setitem( row, "prompt_message", "")
			//---------End Modfiied ------------------------------------------------------
		END IF
		
		//---------------------------- APPEON END ----------------------------

	case 'wf_id'
		if parent.event ue_updatecheck(3) > 0 then 
			this.post setitem(row,'wf_id',this.getitemnumber(row,'wf_id'))
			return 1
		END IF
		ll_workflow_id = long(data)
		if isnull(ll_workflow_id) then ll_workflow_id = 0
		il_wf_id = ll_workflow_id
		
		
		//Get current Status of Work Flow
		if this.GetChild( "wf_id",ldwc_child) = 1 then
			//is_wf_status = ldwc_child.GetItemString( ldwc_child.GetRow(),"wf_status")
			
			//Get View ID--jervis 03.12.2009
			ll_find = ldwc_child.Find("wf_id =" + string(il_wf_id),1,ldwc_child.rowcount())
			if ll_find > 0 then
				il_view_id = ldwc_child.GetItemNumber(ll_find,'view_id')
			end if
		end if
		if isnull(il_wf_id) then il_wf_id = 0
		
		//BEGIN---Modify by Scofield on 2009-08-28
		if IsNull(il_view_id) then il_view_id = 1001
		
		ll_Rtn = tab_1.tabpage_types.dw_action_type_detail.GetChild("DisplayLocation",ldwc_Child)
		if ll_Rtn > 0 then
			ls_Module = This.GetItemString(1,"wf_module")
			
			ldwc_Child.SetTransObject(SQLCA)
			ldwc_Child.Retrieve(il_view_id)
			
			if ls_Module = '03' then
				ldwc_Child.SetFilter("ctx_tabpage_screen_tabpage_pid = 0")
			elseif ls_Module = '04' then
				ldwc_Child.SetFilter("ctx_tabpage_screen_tabpage_id = 50")
			end if
			
			ldwc_Child.Filter()
			
			ldwc_Child.InsertRow(1)
		end if
		//END---Modify by Scofield on 2009-08-28

		tab_1.tabpage_status.dw_action_status_detail.reset( )
		tab_1.tabpage_types.dw_action_type_detail.retrieve(ll_workflow_id)
		
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007.08.20 By: Frank.Gui
//$<reason> Not only wf_id but also wf_module changed, the tree data should be rebuilt.
//$<reason> Simply move the End Choose from the end to here
End Choose
//---------------------------- APPEON END ----------------------------

		//of_refresh_steps_status_dddw(ll_workflow_id , '1' , 0)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.14.2007 By: Machongmin
		//$<reason> Fix a defect.
		long ll_h
		treeviewitem ltvi_temp
		parent.of_fill_tree()
		ll_h = tv_results.finditem( RootTreeItem!,0)
		if ll_h < 0 then return 0
		ll_h = tv_results.finditem( ChildTreeItem!, ll_h)
		if ll_h > 0 then
			tv_results.selectitem(ll_h)
		end if
		//---------------------------- APPEON END ----------------------------
		
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2007.08.20 By: Frank.Gui
//$<reason> Move End Choose to above.
//End Choose
//---------------------------- APPEON END ----------------------------


end event

event constructor;call super::constructor;this.of_SetUpdateable( false)
This.InsertRow(0)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.11.2007 By: Jervis
//$<reason> 
integer li_product
integer li_contract_set
integer li_apps
string ls_ddlb
li_product = of_get_app_setting('set_9', 'I')
li_contract_set = of_get_app_setting('set_cont', 'I')
li_apps = of_get_app_setting('set_iapps', 'I') //Start Code Change ----04.30.2012 #V12 maha - corrected field name

choose case li_product
	case 0
		ls_ddlb = "IntelliCred	01/"
		if li_apps = 1 then
			ls_ddlb += "IntelliApp	02/"
		end if
		if li_contract_set = 1 then
			ls_ddlb += "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
		end if
		this.SetItem(1,"wf_module","01")
		this.event ItemChanged(1,this.object.wf_module,"01")
	case 1
		ls_ddlb = "IntelliApp	02/"
		if li_contract_set = 1 then
			ls_ddlb += "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
		end if
		this.SetItem(1,"wf_module","02")
		this.event ItemChanged(1,this.object.wf_module,"02")
	case 2	//IntelliCred SE
		ls_ddlb = "IntelliCred	01/"
		this.SetItem(1,"wf_module","01")
		this.event ItemChanged(1,this.object.wf_module,"01")
	case 3
		ls_ddlb = "IntelliCred	01/IntelliApp	02/"
		if li_contract_set = 1 then
			ls_ddlb += "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
		end if
		this.SetItem(1,"wf_module","01")
		this.event ItemChanged(1,this.object.wf_module,"01")
	case 4 //IntelliContract
		ls_ddlb = "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
		this.SetItem(1,"wf_module","03")
		this.event ItemChanged(1,this.object.wf_module,"03")
end choose
//messagebox("",ls_ddlb)
this.Modify("wf_module.values = '" + ls_ddlb + "'")	

//---------------------------- APPEON END ----------------------------

end event

event itemerror;call super::itemerror;Return 1		//Added by Scofield on 2009-01-05: Don't display the validation information dialog
end event

type gb_1 from groupbox within w_workflow_painter_app
integer x = 14
integer width = 4466
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Work Flows"
end type

type gb_2 from groupbox within w_workflow_painter_app
integer x = 18
integer y = 200
integer width = 1001
integer height = 2008
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Action Type (Work Flow Steps)"
end type

type tab_1 from tab within w_workflow_painter_app
event create ( )
event destroy ( )
integer x = 1024
integer y = 204
integer width = 3470
integer height = 2000
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
alignment alignment = center!
integer selectedtab = 1
tabpage_types tabpage_types
tabpage_status tabpage_status
end type

on tab_1.create
this.tabpage_types=create tabpage_types
this.tabpage_status=create tabpage_status
this.Control[]={this.tabpage_types,&
this.tabpage_status}
end on

on tab_1.destroy
destroy(this.tabpage_types)
destroy(this.tabpage_status)
end on

event selectionchanging;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Machongmin
//$<reason> Fix a defect.
long ll_row
tab_1.tabpage_types.dw_action_type_detail.accepttext()
tab_1.tabpage_status.dw_action_status_detail.accepttext()

ll_row = tab_1.tabpage_types.dw_action_type_detail.getrow()
if ll_row > 0 then
	if tab_1.tabpage_types.dw_action_type_detail.getitemstatus(ll_row,0,Primary!) = new! or	tab_1.tabpage_types.dw_action_type_detail.getitemstatus(ll_row,0,Primary!) = newmodified! then
		MessageBox("Save", "You need to first save the action types record before selecting other item." )
		return 1
	end if
end if

ll_row = tab_1.tabpage_status.dw_action_status_detail.getrow()
if ll_row > 0 then
	if tab_1.tabpage_status.dw_action_status_detail.getitemstatus(ll_row,0,Primary!) = new! or	tab_1.tabpage_status.dw_action_status_detail.getitemstatus(ll_row,0,Primary!) = newmodified! then
		MessageBox("Save", "You need to first save the action status record before selecting other item." )
		return 1
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

type tabpage_types from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3433
integer height = 1884
long backcolor = 33551856
string text = "Action Types"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_action_type_detail dw_action_type_detail
end type

on tabpage_types.create
this.dw_action_type_detail=create dw_action_type_detail
this.Control[]={this.dw_action_type_detail}
end on

on tabpage_types.destroy
destroy(this.dw_action_type_detail)
end on

type dw_action_type_detail from u_dw_workflow within tabpage_types
event ue_refresh_dddw ( boolean ab_autoretrieve,  string as_module )
event ue_key pbm_dwnkey
event key pbm_dwnkey
integer y = 8
integer width = 3424
integer height = 1876
integer taborder = 30
string dataobject = "d_wf_action_type_2"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_refresh_dddw(boolean ab_autoretrieve, string as_module);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_refresh_dddw
//
//	Arguments:  ab_autoretrieve :true or false
//
//	Returns:  none
//
//	Description:
// refresh dddw data
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

datawindowchild ldwc_obj
string ls_colname,ls_action_type,ls_autoretrieve
long ll_i,ll_column_count


ll_column_count = long(This.Describe("DataWindow.Column.Count"))
IF ll_column_count = 0 THEN RETURN

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-12-11 By: Scofield
//$<Reason> Get Contract Contact Type data

String	ls_SQL,ls_Rtn,ls_Error,ls_Code
long		ll_Row,ll_Cycle,ll_Count,ll_LUpCode

DataStore	lds_ConType

if as_module = '03' or as_module = '04' then
	ls_SQL = "select lookup_code,code from code_lookup where lookup_name = 'Contract Contact Type';"
	ls_Rtn = SQLCA.SyntaxFromSQL(ls_SQL,"",ls_Error)
	
	lds_ConType = Create DataStore
	
	lds_ConType.Create(ls_Rtn,ls_Error)
	lds_ConType.SetTransObject(SQLCA)
	ll_Count = lds_ConType.Retrieve()
end if
//---------------------------- APPEON END ----------------------------

FOR ll_i = 1 TO ll_column_count
	IF Describe("#" +STRING(LL_I) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +STRING(LL_I) + ".Name")
		ls_autoretrieve = Describe("#" + string(ll_I) + ".dddw.autoretrieve")
		this.GetChild( ls_colname,ldwc_obj)
		ldwc_obj.SetTransObject(Sqlca)
		If ab_autoretrieve and ls_autoretrieve = "yes" then
			/* 
			ldwc_obj.Retrieve()
			
			Choose case ls_colname
				Case "to_user"
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"user_name","(NONE)")
					//ldwc_obj.SetItem(2,"user_id","Priority User") //27-11-2006 By Jervis
					ldwc_obj.SetItem(1,"user_id","$$Priority User$$")  
					ldwc_obj.SetItem(1,"user_name","Priority User")
					ldwc_obj.InsertRow(1)
					if as_module = "03" or as_module = "04" then
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Owner")
						ldwc_obj.InsertRow(1)
					end if
					
				
				case "send_to_user","cc_user"
					if (as_module = "01" or as_module = "02") then		//2006-11-16 by Jervis
						ldwc_obj.SetItem(1,"user_id","$$Practitioner$$")
						ldwc_obj.SetItem(1,"user_name","Practitioner")
						ldwc_obj.InsertRow(1)
						ldwc_obj.SetItem(1,"user_id","$$Assigned To User$$")
						ldwc_obj.SetItem(1,"user_name","Assigned To User")
						ldwc_obj.InsertRow(1)
					end if
					ldwc_obj.SetItem(1,"user_name","(NONE)")
				
				Case "by_user"
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"user_name","(NONE)")
					
					ldwc_obj.SetItem(1,"user_id","System")
					//ldwc_obj.SetItem(2,"user_id","$$System$$")  //27-11-2006 By Jervis
					ldwc_obj.SetItem(1,"user_name","System")
					ldwc_obj.InsertRow(1)
					if as_module = "03" or as_module = "04" then
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Owner")
						ldwc_obj.InsertRow(1)
					end if
			End Choose
			*/
		ElseIf not ab_autoretrieve then
			choose case ls_colname
				case "action_type_id"
					Choose Case as_module
						Case '01'
							ls_action_type = 'Verification Method'
						Case '02'
							ls_action_type = 'Action Type'
						//Start Changed 17.01.2007 By Jervis
						Case '03',"04"
							ls_action_type = 'Contract Action Type'
						/*
						Case '04'
							ls_action_type = 'Document Manager Action Type'
						*/
						//End
					End Choose
					
					ldwc_obj.Retrieve(ls_action_type)
					ldwc_obj.InsertRow(1)
					//Add *add lookups* 
					ldwc_obj.SetItem(1,"lookup_code",-777)
					ldwc_obj.SetItem(1,"code","*Add lookup code*")
					ldwc_obj.SetItem(1,"description","Add lookup code")
				case "mail_notify"
					ldwc_obj.retrieve(as_module)
					ldwc_obj.InsertRow(1)
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"email_name","(NONE)")
					
					ldwc_obj.SetItem(2,"email_name","*Add Email*")
					ldwc_obj.SetItem(2,"email_id", -1)
					
				case "send_to_user","cc_user"
					ldwc_obj.Retrieve()
					ldwc_obj.InsertRow(1)
					
					ldwc_obj.SetItem(1,"user_id","$$All Our Contacts$$")	//Added by Scofield on 2009-03-09
					ldwc_obj.SetItem(1,"user_name","All Our Contacts")		//Added by Scofield on 2009-03-09
					ldwc_obj.InsertRow(1)											//Added by Scofield on 2009-03-09

					ldwc_obj.SetItem(1,"user_id","$$Default To$$")			//Added by Scofield on 2009-01-09
					ldwc_obj.SetItem(1,"user_name","Default To")				//Added by Scofield on 2009-01-09
					ldwc_obj.InsertRow(1)											//Added by Scofield on 2009-01-09

					if (as_module = "01" or as_module = "02") then		//2006-11-16 by Jervis
						ldwc_obj.SetItem(1,"user_id","$$Practitioner$$")
						ldwc_obj.SetItem(1,"user_name","Practitioner")
						ldwc_obj.InsertRow(1)
						/*
						ldwc_obj.SetItem(1,"user_id","$$Assigned To User$$")
						ldwc_obj.SetItem(1,"user_name","Assigned To User")
						ldwc_obj.InsertRow(1)
						*/
					end if
					//ldwc_obj.SetItem(1,"user_name","(NONE)")
					if as_module = "03" or as_module = "04" Then //03.29.2007 By Jervis
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Contract Owner")
						ldwc_obj.InsertRow(1)
					end if
					
					//--------------------------- APPEON BEGIN ---------------------------
					//$<Add> 03.06.2007 By: Jervis
					//$<reason> Add Assigned to and Assigned By
					ldwc_obj.SetItem(1,"user_id","$$Assigned To User$$")
					ldwc_obj.SetItem(1,"user_name","Assigned To User")
					ldwc_obj.InsertRow(1)
					ldwc_obj.SetItem(1,"user_id","$$Assigned By User$$")
					ldwc_obj.SetItem(1,"user_name","Assigned By User")
					ldwc_obj.InsertRow(1)
					//---------------------------- APPEON END ----------------------------
					
					//--------------------------- APPEON BEGIN ---------------------------
					//$<Add> 05.30.2007 By: Scofield
					//$<reason> Add TYPE_LIST column
					if ls_colname = "cc_user" then
						ldwc_obj.SetItem(1,"user_id",TYPE_LIST)
						ldwc_obj.SetItem(1,"user_name",TYPE_LIST)
						ldwc_obj.InsertRow(1)
					end if
					//---------------------------- APPEON END ----------------------------
				Case "to_user"
					ldwc_obj.retrieve()
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"user_name","(NONE)")
					//ldwc_obj.SetItem(2,"user_id","Priority User") //27-11-2006 By Jervis
					if as_module = "01" then
						ldwc_obj.SetItem(1,"user_id","$$Priority User$$")  
						ldwc_obj.SetItem(1,"user_name","Priority User")
						ldwc_obj.InsertRow(1)
					End If
					
					if as_module = "03"  or as_module = "04" then //03.29.2007 By Jervis
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Contract Owner")
						ldwc_obj.InsertRow(1)
					end if
					//--------------------------- APPEON BEGIN ---------------------------
					//$<modify> 03.13.2007 By: Machongmin
					//$<reason> Fix a defect.
					if as_module = "04" Then
						ldwc_obj.SetItem(1,"user_id","$$Document Created By$$")
						ldwc_obj.SetItem(1,"user_name","Document Created By")
						ldwc_obj.insertrow(1)
					end if
					//---------------------------- APPEON END ----------------------------

					//--------------------------- APPEON BEGIN ---------------------------
					//$<Add> 03.06.2007 By: Jervis
					//$<reason> Add Login in User
					ldwc_obj.SetItem(1,"user_id","$$Logged In User$$")
					ldwc_obj.SetItem(1,"user_name","Logged In User")
					ldwc_obj.InsertRow(1)
					//---------------------------- APPEON END ----------------------------
				Case "by_user"
					ldwc_obj.retrieve()
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"user_name","(NONE)")
					
					ldwc_obj.SetItem(1,"user_id","System")
					//ldwc_obj.SetItem(2,"user_id","$$System$$")  //27-11-2006 By Jervis
					ldwc_obj.SetItem(1,"user_name","System")
					ldwc_obj.InsertRow(1)
					if as_module = "03" or as_module = "04" Then //03.29.2007 By Jervis
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Contract Owner")
						ldwc_obj.InsertRow(1)
					end if
					
					//--------------------------- APPEON BEGIN ---------------------------
					//$<modify> 03.13.2007 By: Machongmin
					//$<reason> Fix a defect.
					if as_module = "04" Then
						ldwc_obj.SetItem(1,"user_id","$$Document Created By$$")
						ldwc_obj.SetItem(1,"user_name","Document Created By")
						ldwc_obj.insertrow(1)
					end if
					//---------------------------- APPEON END ----------------------------
				
					//--------------------------- APPEON BEGIN ---------------------------
					//$<Add> 03.06.2007 By: Jervis
					//$<reason> 
					ldwc_obj.SetItem(1,"user_id","$$Logged In User$$")
					ldwc_obj.SetItem(1,"user_name","Logged In User")
					ldwc_obj.InsertRow(1)
					//---------------------------- APPEON END ----------------------------
			End choose
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2007-12-11 By: Scofield
			//$<Reason> Set Contract Contact Type data.
			if as_module = "03" or as_module = "04" then
				Choose Case ls_colname
					Case 'to_user','by_user','send_to_user','cc_user'
						ll_Row = ldwc_obj.InsertRow(0)
						ldwc_obj.SetItem(ll_Row,"user_id",CONTRACT_CONTACT_TYPE)
						ldwc_obj.SetItem(ll_Row,"user_name",CONTRACT_CONTACT_TYPE)
						for ll_Cycle = 1 to ll_Count
							ll_LUpCode = lds_ConType.GetItemNumber(ll_Cycle,'lookup_code')
							ls_Code = lds_ConType.GetItemString(ll_Cycle,'code')
							ll_Row = ldwc_obj.InsertRow(0)
							ldwc_obj.SetItem(ll_Row,"user_id",String(ll_LUpCode))
							ldwc_obj.SetItem(ll_Row,"user_name",ls_Code)
						next
				End Choose
			end if
			//---------------------------- APPEON END ----------------------------
		End if
	End if
Next

end event

event key;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.04.2007 By: Machongmin
//$<reason> Fix a defect.	
if key = keyuparrow! or key = keydownarrow! or key = keypageup! or key = keypagedown! then
	return 1
end if
//---------------------------- APPEON END ----------------------------
end event

event constructor;call super::constructor;//of_setreqcolumn(true)

//Retrieve dddw data for dddw.autoretrieve = yes
//gnv_appeondb.of_startqueue( )
//event ue_refresh_dddw(true,"")
//gnv_appeondb.of_commitqueue()

end event

event itemchanged;call super::itemchanged;string	ls_desc,ls_ToUser,ls_ByUser,ls_SendToUser,ls_ccUser
String	ls_nulldata,ls_Addressee,ls_module
long		ll_data
long 		ll_wf_id,ll_order

Choose Case dwo.name
	Case 'cc_user'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modify> 2008-04-08 By: Scofield
		//$<Reason> Check the contact type if has a email.

		if Not IsNull(is_ccUser) then ls_ccUser = is_ccUser
		if data = TYPE_LIST then
			if IsNull(is_ccUser) then is_ccUser = ''
			OpenWithParm(w_addressee,'(CC)'+is_ccUser)
			ls_Addressee = Message.stringparm
			if ls_Addressee = "Cancel" then
				This.Post SetItem(Row,'cc_user',is_ccUser)
			else
				is_ccUser = ls_Addressee
				This.Post SetItem(Row,'cc_user',ls_Addressee)
			end if
		elseif data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'cc_user',is_ccUser,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_ccUser = data
		end if
		if IsNumber(is_ccUser) and ls_ccUser <> is_ccUser then Post of_CheckEmail(long(is_ccUser),false)
		//---------------------------- APPEON END ----------------------------
	Case 'send_to_user'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modify> 2008-04-08 By: Scofield
		//$<Reason> Check the contact type if has a email.

		if Not IsNull(is_SendToUser) then ls_SendToUser = is_SendToUser
		if data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'send_to_user',is_SendToUser,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_SendToUser = data
		end if
		if IsNumber(is_SendToUser) and ls_SendToUser <> is_SendToUser then Post of_CheckEmail(long(is_SendToUser),false)
		//---------------------------- APPEON END ----------------------------
	Case 'action_type_id'
		//Get the description from code lookup as the default when selecting a Action Type
		ls_desc = gnv_data.of_getitem( 'code_lookup', 'description', "lookup_code=" + data)
		This.SetItem(row , 'action_desc' , ls_desc)
		
		//12.12.2006 By Jervis.
		ls_desc = gnv_data.of_getitem( 'code_lookup', 'code', "lookup_code=" + data)
		this.SetItem(row,'step_name',ls_desc)
		//End By Jervis
		
	Case 'step_order'
		If integer(data) = 0 Then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 08/22/2007 By: Ken.Guo
			//$<reason> Fixed BugA081407. If input to 0 and save it ,the create_flag do not set to 'Y'
			//This.Post SetItem( row, 'create_flag', 'Y')				
			//this.Modify("create_flag.protect = 1")	//Ken: Commented it and Instead of DW Expression		
			This.SetItem( row, 'create_flag', 'Y')			
			//---------------------------- APPEON END ----------------------------
		elseif integer(data) < 0 then
			MessageBox("Message","The values must be more than or equal to 0.")
			return 1
		else
			//this.Modify("create_flag.protect = 0") //Ken: Commented it and Instead of DW Expression
			//of_double_check_steps()
		End If
	Case 'dept_chair_flag' 
		//Make sure only one item selected between Assigned To and Department Chairperson
		If data = 'Y' Then this.setitem( row, 'to_user', ls_nulldata)
	Case 'to_user' 
		//Make sure only one item selected between Assigned To and Department Chairperson
		If len(data)  > 0 Then this.setitem( row, 'dept_chair_flag', 'N')
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-04-08 By: Scofield
		//$<Reason> Add contact type process.
		
		if Not IsNull(is_ToUser) then ls_ToUser = is_ToUser
		if data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'to_user',is_ToUser,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_ToUser = data
		end if
		if IsNumber(is_ToUser) and ls_ToUser <> is_ToUser then Post of_CheckEmail(long(is_ToUser),false)
		//---------------------------- APPEON END ----------------------------
	Case 'create_user_flag'
		//Make sure only one item selected between Assigned by and signed user
		If data = 'Y' Then this.setitem( row, 'by_user', ls_nulldata)
	Case 'by_user' 
		//Make sure only one item selected between Assigned by and signed user
		If len(data)  > 0 Then this.setitem( row, 'create_user_flag', 'N')
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-04-08 By: Scofield
		//$<Reason> Add contact type process.
		
		if Not IsNull(is_ByUser) then ls_ByUser = is_ByUser
		if data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'by_user',is_ByUser,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_ByUser = data
		end if
		if IsNumber(is_ByUser) and ls_ByUser <> is_ByUser then Post of_CheckEmail(long(is_ByUser),true)
		//---------------------------- APPEON END ----------------------------
	Case "mail_notify"
		ll_data = long(data)
		//If ll_data = -1 Then post of_refresh_email_dddw(this , dwo.name)
		
	   //--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.06.2007 By: Machongmin
		//$<reason> Fix a defect.
		/*
		If ll_data = -1 Then post of_refresh_email_dddw(this , dwo.name)
		*/
		If ll_data = -1 Then 
			post of_refresh_email_dddw(this , dwo.name)
			
			//Refresh the records in the other two datawindowchilds
			datawindowchild ldwc_1,ldwc_2,ldwc_3,ldwc_4
			this.getchild("mail_notify",ldwc_4)
			if isvalid(tab_1.tabpage_status.dw_action_status_detail) then 
				tab_1.tabpage_status.dw_action_status_detail.getchild("mail_notify",ldwc_1)
				tab_1.tabpage_status.dw_action_status_detail.getchild("mail_reminder",ldwc_2)
				tab_1.tabpage_status.dw_action_status_detail.getchild("mail_message",ldwc_3)
			end if
			ldwc_4.sharedata(ldwc_1)
			ldwc_4.sharedata(ldwc_2)
			ldwc_4.sharedata(ldwc_3)
		end if
		//---------------------------- APPEON END ----------------------------
End Choose
end event

event pfc_insertrow;
//////////////////////////////////////////////////////////////////////////////
//	Event:			pfc_insertrow
//	Arguments:		None
//	Returns:			long - number of the new row that was inserted
//	 					0 = No row was added.
//						-1 = error
//	Description:		Inserts a new row into the DataWindow before the current row
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
// 						6.0		Enhanced with Pre Insert funcitonality.
// 						7.0		Enhanced with Post Insert funcitonality.
// 						7.0		Linkage service should not fire events when querymode is enabled
//////////////////////////////////////////////////////////////////////////////
//	Copyright ?1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
long		ll_currow , ll_row
long		ll_rc
boolean	lb_disablelinkage
String	ls_Module

// Allow for pre functionality.
if this.Event pfc_preinsertrow() <= PREVENT_ACTION then return NO_ACTION

ll_currow = This.insertrow(0)

// Allow for post functionality.
this.Post Event pfc_postinsertrow(ll_rc)

If not ll_currow > 0 Then return 0

//dw_action_type.scrolltorow(ll_currow)
dw_action_type_detail.scrolltorow(ll_currow)
dw_action_type_detail.setfocus()
//dw_action_type_detail.setcolumn("action_type_id")

This.SetItem(ll_currow , 'wf_id' , il_wf_id)
//This.SetItem(ll_currow , 'create_flag' , 'N')		//Commented by Scofield on 2008-03-12
This.SetItem(ll_currow , 'weekend_flag' , 'N')
This.SetItem(ll_currow , 'dept_chair_flag' , 'N')
This.SetItem(ll_currow , 'create_user_flag' , 'N')

//BEGIN---Modify by Scofield on 2009-08-28
ls_Module = dw_Search.GetItemString(dw_Search.GetRow(),'wf_module')
if ls_Module = '03' then
	This.SetItem(ll_CurRow,'DisplayLocation',4)
elseif ls_Module = '04' then
	This.SetItem(ll_CurRow,'DisplayLocation',50)
end if
//END---Modify by Scofield on 2009-08-28

Return ll_currow

end event

event pfc_preinsertrow;long ll_wf_id

//Save data when row focus changed
if w_workflow_painter_app.event ue_updatecheck(1) > 0 then return 0

ll_wf_id = dw_search.GetItemNumber(1 , 'wf_id')

If isnull(ll_wf_id) Then ll_wf_id = 0

If not ll_wf_id > 0 Then
	Messagebox("Message" , "You should select a Work Flow first.")
	dw_search.Setfocus( )
	dw_search.setcolumn('wf_id')
	return 0
Else
	return 1
End If
end event

event pfc_predeleterow;call super::pfc_predeleterow;
integer i
if this.RowCount() < 1 then return 1

If This.getitemnumber( This.GetRow(),'step_id') > 0  Then
	If Messagebox("Delete Action Types" , "Are you sure to delete this Action Type?", question!,yesno!) = 1 Then
		//Delete the details for the current
		For i = tab_1.tabpage_status.dw_action_status_detail.RowCount() to 1 step -1
			tab_1.tabpage_status.dw_action_status_detail.Deleterow( i )
		Next
		return 1
	Else
		return 0
	End if
	
End If

Return 1
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_step_id
long ll_rowcount , i , ll_steps
long ll_newrows[]
dwItemstatus l_status
string ls_column

If not this.Getrow() > 0 Then return 1



ll_rowcount = This.Rowcount( )

//
For i = 1 To ll_rowCount
	l_status = This.Getitemstatus(i , 0 , primary!)
	if l_status = newmodified! Then 
		ll_newrows[upperbound(ll_newrows) + 1] = i
		ll_steps ++
	End if
	
	//data check
	if l_status = DataModified! or l_status = newmodified! then
		if isnull(this.GetItemNumber(i,"action_type_id")) then
			ls_column = "Action Type"
		elseif isnull(this.GetItemString(i,"step_name")) then
			ls_column = "Step Name"
		elseif isnull(this.GetItemNumber(i,"step_order")) then
			ls_column = "Order of the step"
		end if
	end if
	if len(ls_column) > 0 then
		of_MessageBox ("pfc_preupdate", gnv_app.iapp_object.DisplayName, &
				"Required value missing for " + ls_column + " on row " + string(i) +".  Please enter a value.", information!, Ok!, 1)
		return -1
	end if
Next

//Get id's for all new action types
If ll_steps > 0 Then	ll_step_id = gnv_app.of_get_id( 'WORKFLOW', ll_steps)


//Set id for all new Action Types
For i = 1 to upperbound(ll_newrows)
	this.SetItem(ll_newrows[i] , 'step_id' , ll_step_id)
	ll_step_id++
Next

return 1
end event

event rowfocuschanged;call super::rowfocuschanged;//Retrieve the details for the current Action Type
of_retrive_action_details(currentrow)

////Select Current Row
//dw_action_type.Selectrow(0,false)
//dw_action_type.Selectrow( currentrow,true)
//
//
//If currentrow > 0 and currentrow <> dw_action_type.GetRow() Then dw_action_type.setrow(currentrow)

if CurrentRow > 0 and currentrow <= This.RowCount() then
	is_ccUser = This.GetItemString(currentrow,'cc_user')
	is_SendToUser = This.GetItemString(currentrow,'send_to_user')
end if

end event

event rowfocuschanging;call super::rowfocuschanging;//Accept text
this.Accepttext( )


//Save data when row focus changed
if w_workflow_painter_app.event ue_updatecheck(1) > 0 then return 1
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;string ls_module
String ls_description
DataWindowChild ldwc_child
long ll_find

If ib_refdddw Then
	ls_module = dw_search.GetItemString(dw_search.GetRow() , 'wf_module')	
	this.event ue_refresh_dddw(false , ls_module)
	This.setitem(this.getrow() , this.getcolumnname() , long(ia_data))
	
	//Set the added description of code lookup item
	If this.getcolumnname() = "action_type_id" Then
		This.GetChild("action_type_id" , ldwc_child)
		ll_find = ldwc_child.find( "lookup_code=" + string(ia_data), 1, ldwc_child.rowcount())
		If ll_find > 0 Then
			This.setitem(this.getrow() , "action_desc" , ldwc_child.GetItemString(ll_find , 'description'))
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2007-07-12 By: Scofield
			//$<Reason> Set the step_name column value
			This.setitem(this.getrow() , "step_name" , ldwc_child.GetItemString(ll_find , 'code'))
			//---------------------------- APPEON END ----------------------------
		end if
	End If
	
	ib_refdddw = false
	ia_data = ia_datanull
End If
end event

event other;call super::other;if message.number = 522 then return 1
end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08/22/2007 By: Ken.Guo
//$<reason> Fixed BugA081407, If 'order step' change to 1 from 0 ,then click the checkbox, it failed to change checkbox's status. 

if This.GetColumnName() = "step_order" then Return	//Added by Scofield on 2009-01-05

AcceptText()
//---------------------------- APPEON END ----------------------------


end event

event itemerror;call super::itemerror;Return 1		//Added by Scofield on 2009-01-05: Don't display the validation information dialog
end event

event resize;of_resize()
end event

type tabpage_status from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3433
integer height = 1884
long backcolor = 33551856
string text = "Action Status"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_action_status_detail dw_action_status_detail
end type

on tabpage_status.create
this.dw_action_status_detail=create dw_action_status_detail
this.Control[]={this.dw_action_status_detail}
end on

on tabpage_status.destroy
destroy(this.dw_action_status_detail)
end on

type dw_action_status_detail from u_dw_workflow within tabpage_status
event ue_refresh_dddw ( boolean ab_autoretrieve,  string as_module )
event key pbm_dwnkey
integer y = 8
integer width = 3424
integer height = 1876
integer taborder = 11
string dataobject = "d_wf_action_status"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_refresh_dddw(boolean ab_autoretrieve, string as_module);
//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_refresh_dddw
//
//	Arguments:  ab_autoretrieve :true or false
//
//	Returns:  none
//
//	Description:
// refresh dddw data
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
datawindowchild ldwc_obj
string ls_colname,ls_action_type,ls_autoretrieve
long ll_i,ll_column_count
String ls_module[]//<add> andy 2007.06.04

ll_column_count = long(This.Describe("DataWindow.Column.Count"))
IF ll_column_count = 0 THEN RETURN

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-12-11 By: Scofield
//$<Reason> Get Contract Contact Type data

String	ls_SQL,ls_Rtn,ls_Error,ls_Code
long		ll_Row,ll_Cycle,ll_Count,ll_LUpCode

DataStore	lds_ConType

if as_module = '03' or as_module = '04' then
	ls_SQL = "select lookup_code,code from code_lookup where lookup_name = 'Contract Contact Type';"
	ls_Rtn = SQLCA.SyntaxFromSQL(ls_SQL,"",ls_Error)
	
	lds_ConType = Create DataStore
	
	lds_ConType.Create(ls_Rtn,ls_Error)
	lds_ConType.SetTransObject(SQLCA)
	ll_Count = lds_ConType.Retrieve()
end if
//---------------------------- APPEON END ----------------------------

FOR ll_i = 1 TO ll_column_count
	IF Describe("#" +STRING(LL_I) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +STRING(LL_I) + ".Name")
		ls_autoretrieve = Describe("#" + string(ll_I) + ".dddw.autoretrieve")
		this.GetChild( ls_colname,ldwc_obj)
		ldwc_obj.SetTransObject(Sqlca)
		
		If ab_autoretrieve and ls_autoretrieve = "yes" then
			//Choose case ls_colname
				//case "cc_notify_user","to_message_user","cc_message_user" //11-27-2006 by jervis
				/*
				case "to_message_user","cc_message_user"
					ldwc_obj.Retrieve()
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"user_name","(NONE)")
					if as_module = "03" or as_module = "04" then
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Owner")
						ldwc_obj.InsertRow(1)
					end if
				
				case "to_reminder_user","cc_reminder_user"
					if (as_module = "01" or as_module = "02") then		//2006-11-16 by Jervis
						ldwc_obj.SetItem(1,"user_id","$$Practitioner$$")
						ldwc_obj.SetItem(1,"user_name","Practitioner")
						ldwc_obj.InsertRow(1)
						ldwc_obj.SetItem(1,"user_id","$$Assigned To User$$")
						ldwc_obj.SetItem(1,"user_name","Assigned To User")
						ldwc_obj.InsertRow(1)
					end if
					ldwc_obj.SetItem(1,"user_name","(NONE)")
				*/
			//End Choose
		Elseif not ab_autoretrieve then
			Choose case ls_colname
				Case "action_status_id"
					Choose Case as_module
						Case '01'
							ls_action_type = 'Credentials Verification Response'
						Case '02'
							ls_action_type = 'Action Status'
						//Start Change By Jervis At 17.01.2007
						Case '03','04'
							ls_action_type = 'Contract Action Status'
						/*
						Case '04'
							ls_action_type = 'Document Manager Action Status'
						*/
						//End Change
					End Choose
					
					ldwc_obj.Retrieve(ls_action_type)
					ldwc_obj.InsertRow(1)
					//Add *add lookups* 
					ldwc_obj.SetItem(1,"lookup_code",-777)
					ldwc_obj.SetItem(1,"code","*Add lookup code*")
					ldwc_obj.SetItem(1,"description","Add lookup code")
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem( 1,"code","(NONE)")
					ldwc_obj.SetItem( 1,"description","Set As NULL")
				case "trigger_flow"
					//<Modify> andy 2007.06.04
					ls_module[1] = as_module
					if as_module = '04' then ls_module[2] = '03'
					
					//ldwc_obj.retrieve(as_module)
					ldwc_obj.retrieve(ls_module)
					//end of Modify
					
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"wf_name","(NONE)")
				case "mail_notify","mail_reminder","mail_message"
					ldwc_obj.retrieve(as_module)
					ldwc_obj.InsertRow(1)
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"email_name","(NONE)")
					
					ldwc_obj.SetItem(2,"email_name","*Add Email*")
					ldwc_obj.SetItem(2,"email_id", -1)
					
				case "update_status_id"
					ldwc_obj.Retrieve("Contract Document Status")
					//ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem( 1,"code","(NONE)")
					//ldwc_obj.SetItem( 1,"description","Set As NULL")

					//--------------------------- APPEON BEGIN ---------------------------
					//$<modify> 03.13.2007 By: Machongmin
					//$<reason> Fix a defect.
					ldwc_obj.InsertRow(1)
					//---------------------------- APPEON END ----------------------------

				case "letter_id"
					if as_module = "01" or as_module = "02" then
						ldwc_obj.retrieve(1)	//Practitioner Letter
					else
						ldwc_obj.retrieve(4)	//Contract letter
					end if
					ldwc_obj.InsertRow(1)
					//ldwc_obj.SetItem(1,"letter_name","(NONE)")
				case "to_reminder_user","cc_reminder_user" , "to_notify_user","cc_notify_user"  //Add cc_notity_user By Jervis at 11-27-2006 
					ldwc_obj.retrieve()
					ldwc_obj.insertrow(1)
					
					ldwc_obj.SetItem(1,"user_id","$$All Our Contacts$$")	//Added by Scofield on 2009-03-09
					ldwc_obj.SetItem(1,"user_name","All Our Contacts")		//Added by Scofield on 2009-03-09
					ldwc_obj.InsertRow(1)											//Added by Scofield on 2009-03-09
					
					ldwc_obj.SetItem(1,"user_id","$$Default To$$")			//Added by Scofield on 2009-01-09
					ldwc_obj.SetItem(1,"user_name","Default To")				//Added by Scofield on 2009-01-09
					ldwc_obj.InsertRow(1)											//Added by Scofield on 2009-01-09

					if (as_module = "01" or as_module = "02") then		//2006-11-16 by Jervis
						ldwc_obj.SetItem(1,"user_id","$$Practitioner$$")
						ldwc_obj.SetItem(1,"user_name","Practitioner")
						ldwc_obj.insertrow(1)
					end if
					
					//ldwc_obj.SetItem(1,"user_name","(NONE)")
					if as_module = "03" or as_module = "04" Then //03.29.2007 By Jervis
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Contract Owner")
						ldwc_obj.InsertRow(1)
					end if
					
					//Start Change By Jervis 03.06.2007
					ldwc_obj.SetItem(1,"user_id","$$Assigned To User$$")
					ldwc_obj.SetItem(1,"user_name","Assigned To User")
					ldwc_obj.InsertRow(1)
					
					ldwc_obj.SetItem(1,"user_id","$$Assigned By User$$")
					ldwc_obj.SetItem(1,"user_name","Assigned By User")
					ldwc_obj.InsertRow(1)
					//End Change 
						
					//--------------------------- APPEON BEGIN ---------------------------
					//$<Add> 2007-05-31 By: Wu ZhiJun
					//$<reason> Make the use can cc to a few users
					if ls_colname = "cc_reminder_user" or ls_colname = "cc_notify_user" then
						ldwc_obj.SetItem(1,"user_id",TYPE_LIST)
						ldwc_obj.SetItem(1,"user_name",TYPE_LIST)
						ldwc_obj.InsertRow(1)
					end if
					//--------------------------- APPEON END -----------------------------
				case "to_message_user","cc_message_user"
					ldwc_obj.Retrieve()
					ldwc_obj.InsertRow(1)
					
					ldwc_obj.SetItem(1,"user_id","$$All Our Contacts$$")		//Added by Scofield on 2009-03-09
					ldwc_obj.SetItem(1,"user_name","All Our Contacts")			//Added by Scofield on 2009-03-09
					ldwc_obj.InsertRow(1)												//Added by Scofield on 2009-03-09
					
					ldwc_obj.SetItem(1,"user_id","$$Default To$$")				//Added by Scofield on 2009-01-09
					ldwc_obj.SetItem(1,"user_name","Default To")					//Added by Scofield on 2009-01-09
					ldwc_obj.InsertRow(1)												//Added by Scofield on 2009-01-09

					if as_module = "03" or as_module = "04" Then //03.29.2007 By Jervis
						ldwc_obj.SetItem(1,"user_id","$$Owner$$")
						ldwc_obj.SetItem(1,"user_name","Contract Owner")
						ldwc_obj.InsertRow(1)
					end if
					
					//Start Change By Jervis 03.06.2007
					ldwc_obj.SetItem(1,"user_id","$$Assigned To User$$")
					ldwc_obj.SetItem(1,"user_name","Assigned To User")
										
					ldwc_obj.InsertRow(1)
					ldwc_obj.SetItem(1,"user_id","$$Assigned By User$$")
					ldwc_obj.SetItem(1,"user_name","Assigned By User")
					ldwc_obj.InsertRow(1)
					//End Change
					
					//--------------------------- APPEON BEGIN ---------------------------
					//$<Add> 2007-05-31 By: Wu ZhiJun
					//$<reason> Make the use can cc to a few users
					if ls_colname = "cc_message_user" then
						ldwc_obj.SetItem(1,"user_id",TYPE_LIST)
						ldwc_obj.SetItem(1,"user_name",TYPE_LIST)
						ldwc_obj.InsertRow(1)
					end if
					//--------------------------- APPEON END -----------------------------
			End choose
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2007-12-11 By: Scofield
			//$<Reason> Set Contract Contact Type data.
			if as_module = "03" or as_module = "04" then
				Choose Case ls_colname
					Case 'to_notify_user','cc_notify_user','to_reminder_user','cc_reminder_user','to_message_user','cc_message_user'
						ll_Row = ldwc_obj.InsertRow(0)
						ldwc_obj.SetItem(ll_Row,"user_id",CONTRACT_CONTACT_TYPE)
						ldwc_obj.SetItem(ll_Row,"user_name",CONTRACT_CONTACT_TYPE)
						for ll_Cycle = 1 to ll_Count
							ll_LUpCode = lds_ConType.GetItemNumber(ll_Cycle,'lookup_code')
							ls_Code = lds_ConType.GetItemString(ll_Cycle,'code')
							ll_Row = ldwc_obj.InsertRow(0)
							ldwc_obj.SetItem(ll_Row,"user_id",String(ll_LUpCode))
							ldwc_obj.SetItem(ll_Row,"user_name",ls_Code)
						next
				End Choose
			end if
			//---------------------------- APPEON END ----------------------------
		End if
	End if
Next

Destroy lds_ConType

end event

event key;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.04.2007 By: Machongmin
//$<reason> Fix a defect.	
if key = keyuparrow! or key = keydownarrow! or key = keypageup! or key = keypagedown! then
	return 1
end if
//---------------------------- APPEON END ----------------------------
end event

event constructor;call super::constructor;//of_setreqcolumn(true)
//gnv_appeondb.of_startqueue( )
//event ue_refresh_dddw(true,"")
//gnv_appeondb.of_commitqueue( )
end event

event itemchanged;call super::itemchanged;String	ls_desc,ls_Address
String	ls_nulldata
long 		ll_data , ll_null , ll_wf_id
String	ls_To_Notify,ls_cc_notify,ls_To_reminder,ls_cc_reminder,ls_To_message,ls_cc_message

SetNull(ll_null)

Choose Case dwo.name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 2007-05-31 By: Wu ZhiJun
	//$<reason> Make the EMail can CC to a few user
	Case 'to_notify_user'
		if Not IsNull(is_To_Notify) then ls_To_Notify = is_To_Notify
		if data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'to_notify_user',is_To_Notify,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_To_Notify = data
		end if
		
		if IsNumber(is_To_Notify) and ls_To_Notify <> is_To_Notify then Post of_CheckEmail(long(is_To_Notify),false)
	Case "cc_notify_user"
		if Not IsNull(is_cc_notify) then ls_cc_notify = is_cc_notify
		if data = TYPE_LIST then
			if IsNull(is_cc_notify) then is_cc_notify = ''
			OpenWithParm(w_addressee,'(CC)'+is_cc_notify)
			ls_Address = Message.stringparm
			if ls_Address <> "Cancel" then
				is_cc_notify = ls_Address
			end if
			This.Post SetItem(Row,'cc_notify_user',is_cc_notify)
		elseif data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'cc_notify_user',is_cc_notify,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_cc_notify = data
		end if
		if IsNumber(is_cc_notify) and ls_cc_notify <> is_cc_notify then Post of_CheckEmail(long(is_cc_notify),false)
	Case 'to_reminder_user'
		if Not IsNull(is_To_reminder) then ls_To_reminder = is_To_reminder
		if data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'to_reminder_user',is_To_reminder,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_To_reminder = data
		end if
		if IsNumber(is_To_reminder) and ls_To_reminder <> is_To_reminder then Post of_CheckEmail(long(is_To_reminder),false)
	Case "cc_reminder_user"
		if Not IsNull(is_cc_reminder) then ls_cc_reminder = is_cc_reminder
		if data = TYPE_LIST then
			if IsNull(is_cc_reminder) then is_cc_reminder = ''
			OpenWithParm(w_addressee,'(CC)'+is_cc_reminder)
			ls_Address = Message.stringparm
			if ls_Address <> "Cancel" then
				is_cc_reminder = ls_Address
			end if
			This.Post SetItem(Row,'cc_reminder_user',is_cc_reminder)
		elseif data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'cc_reminder_user',is_cc_reminder,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_cc_reminder = data
		end if
		if IsNumber(is_cc_reminder) and ls_cc_reminder <> is_cc_reminder then Post of_CheckEmail(long(is_cc_reminder),false)
	Case 'to_message_user'
		if Not IsNull(is_To_message) then ls_To_message = is_To_message
		if data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'to_message_user',is_To_message,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_To_message = data
		end if
		if IsNumber(is_To_message) and ls_To_message <> is_To_message then Post of_CheckEmail(long(is_To_message),false)
	Case "cc_message_user"
		if Not IsNull(is_cc_message) then ls_cc_message = is_cc_message
		if data = TYPE_LIST then
			if IsNull(is_cc_message) then is_cc_message = ''
			OpenWithParm(w_addressee,'(CC)'+is_cc_message)
			ls_Address = Message.stringparm
			if ls_Address <> "Cancel" then
				is_cc_message = ls_Address
			end if
			This.Post SetItem(Row,'cc_message_user',is_cc_message)
		elseif data = CONTRACT_CONTACT_TYPE then
			of_Lookup_Search_dddw(This,'cc_message_user',is_cc_message,CONTACT_TYPE_LOOKUP_NAME)
		else
			is_cc_message = data
		end if
		if IsNumber(is_cc_message) and ls_cc_message <> is_cc_message then Post of_CheckEmail(long(is_cc_message),false)
	//--------------------------- APPEON END -----------------------------
	Case 'action_status_id'
		//Get the description from code lookup as the default when selecting a Action Type
		ls_desc = gnv_data.of_getitem( 'code_lookup', 'description', "lookup_code=" + data)
		This.SetItem(row , 'action_status_desc' , ls_desc)
		
		//12.12.2006 By Jervis
		ls_desc = gnv_data.of_getitem( 'code_lookup', 'code', "lookup_code=" + data)
		This.SetItem(row,'status_name',ls_desc)
	Case 'initial_flag'
		If data = 'Y' Then 
			If of_double_check_status(row , 'initial_flag') Then
				Messagebox("Message" , "There is another action status set as the initial status.")
				return 2
			End If
			This.SetItem(row , 'complete_flag' , 'N')
		End If
		
	Case 'complete_flag'
		If data = 'Y' Then 
//			If of_double_check_status(row , 'complete_flag') Then
//				Messagebox("Message" , "There is another action status is seted as the complete status.")
//				return 2
//			End If
			This.SetItem(row , 'initial_flag' , 'N')
		End If
		
	case "to_step"
		ll_data = long(data)
		If (ll_data < -5 and ll_data <> -100) or ll_data = -2 then
			MessageBox("Message","The values must be more than 0.")
			return 1
		end if
	case "create_step"
		ll_data = long(data)
		If (ll_data < 0 and (ll_data <> -4 and ll_data <> -100)) then
			MessageBox("Message","The values must be more than 0.")
			return 1
		end if
	
	Case 'resend_times'
		ll_data = long(data)
		//start-----Add By Jervis 28-11-2006
		if ll_data < 0 then		
			MessageBox("Message","The values must be more than 0.")
			return 1
		end if
		//End-----------------------
		If ll_data > 0 Then This.SetItem(row , 'return_days', 0 )
	Case 'return_days'
		ll_data = long(data)
		//start-----Add By Jervis 28-11-2006
		if ll_data < 0 then
			MessageBox("Message","The values must be more than 0.")
			return 1
		end if
		//End-----------------------
		If ll_data > 0 Then This.SetItem(row , 'resend_times', 0 )
		
	Case "mail_notify","mail_reminder","mail_message"
		ll_data = long(data)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.06.2007 By: Machongmin
		//$<reason> Fix a defect.
		/*
		If ll_data = -1 Then post of_refresh_email_dddw(this , dwo.name)
		*/
		If ll_data = -1 Then 
			post of_refresh_email_dddw(this , dwo.name)
			
			//Refresh the records in the other two datawindowchilds
			datawindowchild ldwc_1,ldwc_2,ldwc_3,ldwc_4
			this.getchild("mail_notify",ldwc_1)
			this.getchild("mail_reminder",ldwc_2)
			this.getchild("mail_message",ldwc_3)
			if isvalid(tab_1.tabpage_types.dw_action_type_detail) then 
				tab_1.tabpage_types.dw_action_type_detail.getchild("mail_notify",ldwc_4)
			end if
			choose case dwo.name
				case "mail_notify"
					ldwc_1.sharedata(ldwc_2)
					ldwc_1.sharedata(ldwc_3)
					ldwc_1.sharedata(ldwc_4)
				case "mail_reminder"
					ldwc_2.sharedata(ldwc_1)
					ldwc_2.sharedata(ldwc_3)
					ldwc_2.sharedata(ldwc_4)
				case "mail_message"
					ldwc_3.sharedata(ldwc_1)
					ldwc_3.sharedata(ldwc_2)
					ldwc_3.sharedata(ldwc_4)
			end choose
		end if
		//---------------------------- APPEON END ----------------------------

	//start-----Add By Jervis 28-11-2006
	case "days_reminder","days_every","send_count","day_interval"
		ll_data = long(data)
		//---------Begin Added by (Appeon)Harry 02.18.2014 for Bug  #3925--------
		if dwo.name = "days_every" then
			if ll_data <= 0 then
				MessageBox("Message","The values must be more than 0.")
				return 1
			end if
		end if
		//---------End Added ------------------------------------------------------
		if ll_data < 0 then
			MessageBox("Message","The values must be more than 0.")
			return 1
		end if
	//End-----------------------------------
	
	//start code changes -- 12.5.2006 Henry
	Case  "set_wf_id"
		ll_data = long(data)
		If ll_data > 0 Then
			of_refresh_steps_status_dddw(ll_data , '1' , 0)
			This.SetItem(row , 'set_step', ll_null )
			This.SetItem(row , 'set_status', ll_null )
		Else
			This.SetItem(row , 'set_step', ll_null )
			This.SetItem(row , 'set_status', ll_null )
		End If
		
	Case  "set_step"
		ll_data = long(data)
		ll_wf_id = this.getitemnumber(row , 'set_wf_id')
		If ll_data > 0 Then
			of_refresh_steps_status_dddw(ll_wf_id , '2' , ll_data)
			This.SetItem(row , 'set_status', ll_null )
		Else
			This.SetItem(row , 'set_status', ll_null )
		End If
		
	Case "letter_id"
		ll_data = long(data)
		If ll_data > 0 then
			This.SetItem(row , 'process_flag', 1 )
		Else
			This.SetItem(row , 'process_flag', -1 )
		End If
	//End code changes -- 12.5.2006

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.13.2007 By: Machongmin
	//$<reason> Fix a defect.

	case "update_header_flag" 
		double ll_temp
		setnull(ll_temp)
		if trim(data) = "N" then
			this.setitem(row,"update_status_id",ll_temp)
		end if			
	//---------------------------- APPEON END ----------------------------

	case "trigger_flow" //Alfee 03.28.2008
		IF Long(data) = il_wf_id THEN
			MessageBox("Message", "The work flow can't trigger itself.")
			RETURN 1
		END IF
	case "prompt_flag"	// Jervis 04.24.2009
		if data = "N" then
			this.SetItem(row,"prompt_message","")
			this.SetItem( row, "wf_esign",'N')
		end if
End Choose
end event

event pfc_insertrow;
//////////////////////////////////////////////////////////////////////////////
//	Event:			pfc_insertrow
//	Arguments:		None
//	Returns:			long - number of the new row that was inserted
//	 					0 = No row was added.
//						-1 = error
//	Description:		Inserts a new row into the DataWindow before the current row
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
// 						6.0		Enhanced with Pre Insert funcitonality.
// 						7.0		Enhanced with Post Insert funcitonality.
// 						7.0		Linkage service should not fire events when querymode is enabled
//////////////////////////////////////////////////////////////////////////////
//	Copyright ?1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
long	ll_currow , ll_row
long	ll_rc
long	ll_step_id
boolean lb_disablelinkage


// Allow for pre functionality.
if this.Event pfc_preinsertrow() <= PREVENT_ACTION then return NO_ACTION

ll_currow = This.insertrow( 0)

// Allow for post functionality.
this.Post Event pfc_postinsertrow(ll_rc)


If not ll_currow > 0 Then return 0
ll_step_id = tab_1.tabpage_types.dw_action_type_detail.GetItemnumber(tab_1.tabpage_types.dw_action_type_detail.GetRow() , 'step_id')


//dw_action_status_list.scrolltorow(ll_currow)
dw_action_status_detail.scrolltorow(ll_currow)
dw_action_status_detail.setfocus()
//dw_action_status_detail.setcolumn("action_status_id")

This.SetItem(ll_currow , 'wf_id' , il_wf_id)
This.SetItem(ll_currow , 'step_id' , ll_step_id)

This.SetItem(ll_currow , 'initial_flag' , 'N')
This.SetItem(ll_currow , 'complete_flag' , 'N')
This.SetItem(ll_currow , 'update_header_flag' , 'N')
This.SetItem(ll_currow , 'popup_flag' , 'N')
This.SetItem(ll_currow , 'include_note_flag' , 'N')
This.SetItem(ll_currow , 'process_flag' , -1)


return ll_currow


end event

event pfc_preinsertrow;call super::pfc_preinsertrow;dwItemStatus l_status

//If no Action Type added, then can not add Action Type details.
If not tab_1.tabpage_types.dw_action_type_detail.GetRow( ) > 0 Then 
	Messagebox("Work Flow Manager Message", "You should add an Action Type first.")
	return 0
End If

//If the current Action Type is new, then need to update the Action Types first begin you add some Action Type details.
l_status = tab_1.tabpage_types.dw_action_type_detail.GetItemStatus( tab_1.tabpage_types.dw_action_type_detail.GetRow(), 0, Primary!)
If l_status = newmodified! Then
	Messagebox("Work Flow Manager Message","The current Action Type is new, Please save it first before you add some details for it!")
	Return 0
End if

return 1
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_status_id
long ll_rowcount , i , ll_steps , ll_initial
long ll_newrows[]
string ls_column

dwItemstatus l_status

If not this.Getrow() > 0 Then return 1

//Make sure there is one status is seted as the initial status.
For i = 1 to This.RowCount()
	If this.GetItemstring(i , 'initial_flag') = 'Y' Then ll_initial++
Next
If not ll_initial > 0 Then
	Messagebox("Message" , "You have not set one status as the initial status, Please set it.")
	Return -1
elseif ll_initial > 1 then
	Messagebox("Message" , "Only one status can be set as the initial status in one Action Type, Please reset it.")
	Return -1
End If

//ll_initial = 0
//For i = 1 to This.RowCount()
//	If this.GetItemstring(i , 'complete_flag') = 'Y' Then ll_initial++
//Next
//If not ll_initial > 0 Then
//	Messagebox("Message" , "You have not set one status as the complete status, Suggest to set it.")
//End If

//Set up the id column where update the data
ll_status_id = this.GetItemnumber(this.Getrow() , 'status_id')
If isnull(ll_status_id) Then ll_status_id = 0
ll_rowcount = This.Rowcount( )

//How many new items is added
For i = 1 To ll_rowCount
	l_status = This.Getitemstatus(i , 0 , primary!)
	if l_status = newmodified! Then 
		ll_newrows[upperbound(ll_newrows) + 1] = i
		ll_steps ++
	End if
	
	//data check
	if l_status = DataModified! or l_status = newmodified! then
		/*
		if isnull(this.GetItemNumber(i,"action_status_id")) then
			ls_column = "Action Status"
		elseif isnull(this.GetItemString(i,"status_name")) then
			ls_column = "Status Name"
		end if
		*/
		if isnull(this.GetItemString(i,"status_name")) then
			ls_column = "Status Name"
		end if
	end if
	if len(ls_column) > 0 then
		of_MessageBox ("pfc_preupdate", gnv_app.iapp_object.DisplayName, &
				"Required value missing for " + ls_column + " on row " + string(i) +".  Please enter a value.", information!, Ok!, 1)
		return -1
	end if
Next

//Get id's for all new action types
If ll_steps > 0 Then	ll_status_id = gnv_app.of_get_id( 'WORKFLOW', ll_steps)

//Set id for all new Action Types
For i = 1 to upperbound(ll_newrows)
	this.SetItem(ll_newrows[i] , 'status_id' , ll_status_id)
	ll_status_id++
Next

return 1
end event

event rowfocuschanged;call super::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007.08.20 By: Frank.Gui
//$<reason> To avoid potential error.
IF currentrow < 1 or isnull(currentrow) then return
//---------------------------- APPEON END ----------------------------

//Select Current Row
//dw_action_status_list.Selectrow(0,false)
//dw_action_status_list.Selectrow( currentrow,true)
//
//
//If currentrow > 0 and currentrow <> dw_action_status_list.GetRow() Then dw_action_status_list.setrow(currentrow)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.27.2006 By: Jervis
//$<reason>Fix a defect 
long ll_wf_id,ll_step_id
ll_wf_id = this.GetItemNumber(currentrow,"set_wf_id")
ll_step_id = this.GetItemNumber(currentrow,"set_step")
if ll_wf_id > 0 then
	of_refresh_steps_status_dddw(ll_wf_id , '1' , 0)
	if ll_step_id > 0 then
		of_refresh_steps_status_dddw(ll_wf_id , '2' , ll_step_id)
	end if
end if

//---------------------------- APPEON END ----------------------------

if CurrentRow > 0 and currentrow <= This.RowCount() then
	is_To_Notify = This.GetItemString(currentrow,'to_notify_user')
	is_cc_notify = This.GetItemString(currentrow,'cc_notify_user')
	is_To_reminder = This.GetItemString(currentrow,'to_reminder_user')
	is_cc_reminder = This.GetItemString(currentrow,'cc_reminder_user')
	is_To_message = This.GetItemString(currentrow,'to_message_user')
	is_cc_message = This.GetItemString(currentrow,'cc_message_user')
end if

end event

event rowfocuschanging;call super::rowfocuschanging;this.Accepttext( )
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;string ls_module
datawindowchild ldwc_child
long	 ll_find

If ib_refdddw Then
	ls_module = dw_search.GetItemString(dw_search.GetRow() , 'wf_module')	
	this.event ue_refresh_dddw(false , ls_module)
	This.SetItem(this.GetRow() , this.getcolumnname() , long(ia_data))
	
	//Set the added description of code lookup item
	If this.getcolumnname() = "action_status_id" Then
		This.GetChild("action_status_id" , ldwc_child)
		ll_find = ldwc_child.find( "lookup_code=" + string(ia_data), 1, ldwc_child.rowcount())
		If ll_find > 0 Then
			This.SetItem(this.GetRow(), "status_name", ldwc_child.GetItemString(ll_find, 'Code'))		//Added by Scofield on 2008-12-31
			This.SetItem(this.GetRow(), "action_status_desc", ldwc_child.GetItemString(ll_find, 'description'))
		end if
	End If
	
	ib_refdddw = false
	ia_data = ia_datanull
End If

end event

event other;call super::other;if message.number = 522 then return 1
end event

event pfc_predeleterow;call super::pfc_predeleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.19.2007 By: Machongmin
//$<reason> Fix a defect.
long ll_row
string ls_flag

ll_row = this.getrow()
if ll_row <= 0 then return -1
if this.getitemstatus(ll_row,0,primary!) <> new! and this.getitemstatus(ll_row,0,primary!) <> newmodified! then
	If Messagebox("Delete Action Status" , "Are you sure to delete this Action Status?", question!,yesno!) = 2 Then return -1
end if

if ll_row > 0 and this.rowcount() > 1 then
	ls_flag = trim(this.object.initial_flag[ll_row])
	if ls_flag = "Y" then
		messagebox("Infomation","Please set the Initial Status to the other Action Status record first.")
		return -1
	end if
end if
return 1	
//---------------------------- APPEON END ----------------------------
end event

event itemerror;call super::itemerror;Return 1		//Added by Scofield on 2009-01-05: Don't display the validation information dialog
end event

event buttonclicked;call super::buttonclicked;str_parm lstr_parm


if row > 0 then
	if this.getitemstatus(row,0,Primary!) = new! or	this.getitemstatus(row,0,Primary!) = newmodified! then
		MessageBox("Save", "You need to first save the action status record." )
		return 
	end if
end if

if il_wf_id > 0 and dwo.name = "b_advance" then
	lstr_parm.l_wf_id = il_wf_id
	if isnull(il_view_id) then il_view_id = 1001
	lstr_parm.l_view_id = il_view_id
	lstr_parm.l_step_id = this.GetItemNumber( row,"step_id")
	lstr_parm.l_status_id = this.GetItemNumber( row,"status_id")
	
	//Open Advanced Update Data window
	OpenWithParm(w_wf_advance_update,lstr_parm)
end if

end event

