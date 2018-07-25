$PBExportHeader$w_workflow_properties.srw
forward
global type w_workflow_properties from w_response
end type
type cb_verify from commandbutton within w_workflow_properties
end type
type cb_del from u_cb within w_workflow_properties
end type
type cb_add from u_cb within w_workflow_properties
end type
type cb_ok from u_cb within w_workflow_properties
end type
type cb_cancle from u_cb within w_workflow_properties
end type
type dw_parameter from u_dw_workflow within w_workflow_properties
end type
type dw_workflow from u_dw_workflow within w_workflow_properties
end type
type dw_1 from u_dw within w_workflow_properties
end type
end forward

global type w_workflow_properties from w_response
integer x = 214
integer y = 221
integer width = 3200
integer height = 1960
string title = "Work Flow Properties"
boolean controlmenu = false
long backcolor = 33551856
event ue_new ( )
event ue_copy ( )
event ue_properties ( )
event ue_view ( )
cb_verify cb_verify
cb_del cb_del
cb_add cb_add
cb_ok cb_ok
cb_cancle cb_cancle
dw_parameter dw_parameter
dw_workflow dw_workflow
dw_1 dw_1
end type
global w_workflow_properties w_workflow_properties

type variables
str_parm   istr_parm
boolean ib_autocommit
boolean ib_setredraw = false
datastore ids_parm
end variables

forward prototypes
public function integer of_redraw_dataobject (string data)
public function long of_getview_id ()
end prototypes

event ue_new();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_new
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:New Work Flow
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

String ls_module

//Insert a record
dw_workflow.event pfc_insertrow()
dw_parameter.event pfc_insertrow()

//Depending on what trigger type is selected to display different fields
of_redraw_dataobject(dw_workflow.GetItemString(1,"wf_triggered_by"))

//Set the default module value
ls_module = istr_parm.s_module
If not isnull(ls_module) Then
	dw_workflow.setitem(dw_workflow.GetRow() , 'wf_module' , ls_module)
	dw_workflow.event ItemChanged(dw_workflow.GetRow(),dw_workflow.object.wf_module,ls_module)
End If
end event

event ue_copy();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_copy
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:copy Work Flow
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
long ll_i,ll_count

//Retrieve
ll_count = dw_workflow.event pfc_retrieve()

if ll_count > 0 then
	//Set Row Status From NotModified to NewModified
	dw_workflow.SetItemStatus( 1,0,Primary!,NewModified!)
	
	//Clear work flow name field
	dw_workflow.SetItem(1,"wf_ID",-1)
	
	//Depending on what trigger type is selected to display different fields
	of_redraw_dataobject(dw_workflow.GetItemString(1,"wf_triggered_by"))
	
	dw_workflow.event ItemChanged(1,dw_workflow.object.agreement_flag,dw_workflow.GetItemString(1,"agreement_flag"))
end if


ll_count = dw_parameter.event pfc_retrieve()
for ll_i = 1 to ll_count
	dw_parameter.SetItemStatus( ll_i,0,Primary!,NewModified!)
next



end event

event ue_properties();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_properties
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:Modify work flow
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
long ll_count

//Retrieve
ll_count = dw_workflow.event pfc_retrieve()

if ll_count > 0 then
	//Depending on what trigger type is selected to display different fields
	of_redraw_dataobject(dw_workflow.GetItemString(1,"wf_triggered_by"))
end if

dw_parameter.Post event pfc_retrieve()		//Add 'post' by wuzhijun on 2007-09-19

//Can't change the moudle and trigger by field
//dw_workflow.Modify("wf_module.protect = '1' wf_triggered_by.protect = '1'")
dw_workflow.of_set_column_enable("wf_module",false)
dw_workflow.of_set_column_enable("wf_triggered_by",false)
dw_workflow.of_set_column_enable("view_id",false)		//Added by Scofield on 2009-03-12

dw_workflow.event ItemChanged(1,dw_workflow.object.agreement_flag,dw_workflow.GetItemString(1,"agreement_flag"))

end event

public function integer of_redraw_dataobject (string data);//Start Code Change ----12.02.2016 #V153 maha - removed the positiong of the buttons to the bottom.
choose case data
	/*
	case '001'		//Agreement Creation
		dw_parameter.dataobject = "d_wf_trigger_parm_agreement"
		dw_workflow.Modify("agreement_flag.visible ='1' practitioner_falg.visible = '0' comparison_type.visible = '0'")
		dw_parameter.y = dw_workflow.y + long(dw_workflow.Describe("agreement_flag.y")) + 100
		dw_parameter.height = 350
		cb_add.y = dw_parameter.y + 64
		cb_del.y = cb_add.y + cb_add.height + 10
		cb_add.visible = true
		cb_del.visible = true
	*/
	case '008'		//Action Item Parameters
		dw_parameter.dataobject = "d_wf_trigger_parm_status"
		dw_parameter.y = dw_workflow.y + long(dw_workflow.Describe("agreement_flag.y")) + 40
		dw_parameter.height = 470
		cb_add.visible = false
		cb_del.visible = false
		dw_workflow.Modify("agreement_flag.visible ='0' practitioner_falg.visible = '0' comparison_type.visible = '0'")		
		dw_parameter.post event pfc_retrievedddw( "action_type_id")
		dw_parameter.post event pfc_retrievedddw( "action_status_id")
	case '009'		//Practitioner folder data value comparison
		dw_parameter.dataobject = "d_wf_trigger_parm_comparison"
		dw_workflow.Modify("agreement_flag.visible ='0' practitioner_falg.visible = '1' comparison_type.visible = '1'")
		dw_parameter.Modify("screen_id.dddw.name = 'd_wf_dddw_screen_practitioner' screen_id.dddw.DisplayColumn ='screen_name' screen_id.dddw.DataColumn ='screen_id'")
		dw_parameter.Modify("field_label.dddw.name = 'd_wf_dddw_field_practitioner' field_label.dddw.DisplayColumn ='data_view_fields_field_label' field_label.dddw.DataColumn ='data_view_fields_field_label'")
		dw_parameter.y = dw_workflow.y + long(dw_workflow.Describe("comparison_type.y")) + 100
		dw_parameter.height = 300
		//cb_add.y = dw_parameter.y + 64
		//cb_del.y = cb_add.y + cb_add.height + 10
		cb_add.visible = true
		cb_del.visible = true
		dw_parameter.post event pfc_retrievedddw( "screen_id")
		dw_parameter.post event pfc_retrievedddw( "field_label")
	case '100','105'		//Contract data value comparison / Document Manager data value comparison 
		dw_parameter.dataobject = "d_wf_trigger_parm_comparison"		
		dw_workflow.Modify("agreement_flag.visible ='0' practitioner_falg.visible = '0' comparison_type.visible = '0'")				
		dw_parameter.Modify("screen_id.dddw.name = 'd_wf_dddw_screen_intellicontract' screen_id.dddw.DisplayColumn ='screen_name' screen_id.dddw.DataColumn ='screen_id'")
		dw_parameter.Modify("field_label.dddw.name = 'd_wf_dddw_field_intellicontract' field_label.dddw.DisplayColumn ='data_view_fields_field_label' field_label.dddw.DataColumn ='data_view_fields_field_label'")
		dw_parameter.y = dw_workflow.y + long(dw_workflow.Describe("agreement_flag.y")) + 40
		dw_parameter.height = 430
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 17/05/2007 By: Jervis
		//$<reason> 
		/*
		cb_add.visible = false
		cb_del.visible = false
		*/
		cb_add.visible = true
		cb_del.visible = true
		//---------------------------- APPEON END ----------------------------
		
		cb_verify.visible = true //Jervis 09.14.2010

		//<add> 06/20/2007 by: Andy
		Long   ll_Row
		datawindowchild ldwc
		
		if data = '105' then 
			if dw_parameter.Getchild("screen_id",ldwc) = 1 then
				ldwc.settransobject( SQLCA )
				ll_Row = ldwc.insertrow(0)
				ldwc.setitem(ll_Row,"screen_id",-100)
				ldwc.setitem(ll_Row,"screen_name","Document Manager->Document")				
			end if
		else //'100'
			dw_parameter.post event pfc_retrievedddw( "screen_id")
		end if
		//end of add
		//coment 06/20/2007 by: Andy
		//dw_parameter.post event pfc_retrievedddw( "screen_id")		
	case else
		dw_parameter.dataobject = ''
		dw_parameter.visible = false
		dw_workflow.Modify("agreement_flag.visible ='0' practitioner_falg.visible = '0' comparison_type.visible = '0'")
		dw_workflow.Modify("gb_parm.visible = '0' wf_description_t.y = 776 wf_description.y = 844")
		dw_workflow.height = 1100
//		cb_ok.y = 1156
//		cb_cancle.y = cb_ok.y
		cb_add.visible = false
		cb_del.visible = false
		cb_verify.visible = false //Jervis 09.14.2010
		this.height = 1380
		dw_workflow.Modify("gb_1.visible = '0' gb_2.visible = '0'")
		if ib_setredraw then SetRedraw(true) 
		return 1
end choose
dw_workflow.Modify("gb_parm.visible = '1' wf_description_t.y = 1424 wf_description.y = 1492")
dw_workflow.height = 1748
//cb_ok.y = 1804
//cb_cancle.y = cb_ok.y
this.height = 2028

//2007-1-10 By Jervis
if data = "009" or data = "100" or data = "105" then
	dw_parameter.border = true
else
	dw_parameter.border = false
end if
//End--

dw_parameter.visible = true
dw_parameter.of_settransobject( sqlca)
dw_parameter.event pfc_insertrow()

return 1

end function

public function long of_getview_id ();//====================================================================
// Function: of_GetView_ID()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	None	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-03-12
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long ll_CurRow,ll_View_ID

ll_CurRow = dw_WorkFlow.GetRow()
ll_View_ID = dw_WorkFlow.GetItemNumber(ll_CurRow,"view_id")

if IsNull(ll_View_ID) or ll_View_ID = 0 then
	ll_View_ID = long(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
end if

Return ll_View_ID

end function

on w_workflow_properties.create
int iCurrent
call super::create
this.cb_verify=create cb_verify
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_ok=create cb_ok
this.cb_cancle=create cb_cancle
this.dw_parameter=create dw_parameter
this.dw_workflow=create dw_workflow
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_verify
this.Control[iCurrent+2]=this.cb_del
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_cancle
this.Control[iCurrent+6]=this.dw_parameter
this.Control[iCurrent+7]=this.dw_workflow
this.Control[iCurrent+8]=this.dw_1
end on

on w_workflow_properties.destroy
call super::destroy
destroy(this.cb_verify)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_ok)
destroy(this.cb_cancle)
destroy(this.dw_parameter)
destroy(this.dw_workflow)
destroy(this.dw_1)
end on

event open;call super::open;istr_parm = message.Powerobjectparm

//Set the update objects
u_dw ldw_objects[]

ldw_objects[1] = dw_workflow
ldw_objects[2] = dw_parameter

of_SetUpdateObjects(ldw_objects)

choose case istr_parm.s_type
	case 'new'
		this.event ue_new()
	case 'copy'
		this.event ue_copy()
	case 'properties'
		this.event ue_properties()
	case else
		this.event ue_view()
end choose

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-08-29 By: Evan
//$<Reason> Check if copy before modify status.
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-07-11 By: Scofield
//$<Reason> set the dw_parameter's status to NotModified status
dw_workflow.Post SetItemStatus(1,0,Primary!,NotModified!) //alfee 08.23.2007
dw_parameter.Post SetItemStatus(1,0,Primary!,NotModified!)
//---------------------------- APPEON END ----------------------------
*/
if istr_parm.s_type <> "copy" then
	dw_workflow.Post SetItemStatus(1, 0, Primary!, NotModified!)
	dw_parameter.Post SetItemStatus(1, 0, Primary!, NotModified!)	
end if
//---------------------------- APPEON END ----------------------------

//---------Begin Modified by (Appeon)Harry 07.15.2013 for V141 ISG-CLX--------
String ls_module
ls_module = istr_parm.s_module
if isnull(ls_module) or ls_module = "" then ls_module = dw_workflow.getitemstring(dw_workflow.getrow(), 'wf_module')
if ls_module = "01" or ls_module = "02" then
	Long ll_null
	SetNull(ll_null)
	dw_workflow.Modify("view_id.visible='0' view_id_t.visible='0' wf_trigger_onlogin.visible='0' wf_trigger_onsave.visible='0' suppress_alert.visible='0' t_1.visible='0'")
	dw_workflow.setitem( dw_workflow.getrow(), "view_id", ll_null)
//	dw_workflow.setitem( dw_workflow.getrow(), "wf_trigger_onlogin", "N")
//	dw_workflow.setitem( dw_workflow.getrow(), "wf_trigger_onsave", "N")
	dw_workflow.setitem( dw_workflow.getrow(), "suppress_alert", 0)
else
	dw_workflow.Modify("view_id.visible='1' view_id_t.visible='1' wf_trigger_onlogin.visible='1' wf_trigger_onsave.visible='1' suppress_alert.visible='1' t_1.visible='1'")
end if
//---------End Modfiied ------------------------------------------------------

ib_setredraw = true

end event

event pfc_preupdate;call super::pfc_preupdate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_preupdate
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
if ((dw_parameter.visible and dw_parameter.rowcount( ) < 1) or (dw_parameter.visible and dw_parameter.RowCount() > 0 and dw_parameter.GetItemStatus(1,0,Primary!) = New!)) and &
   dw_parameter.of_getupdateable( ) then
	of_MessageBox ("pfc_preupdate_missingvalue", gnv_app.iapp_object.DisplayName, &
				"Please entry the trigger parameters.", information!, Ok!, 1)
	return -1
else
	return 1
end if
end event

event pfc_begintran;call super::pfc_begintran;ib_autocommit = sqlca.autocommit
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

event close;call super::close;gnv_data.of_retrieve("wf_trigger_param_data_comparison")
gnv_data.of_retrieve("wf_trigger_param_action_status")
gnv_data.of_retrieve("wf_workflow")

if isvalid(ids_parm) then destroy ids_parm
end event

type cb_verify from commandbutton within w_workflow_properties
integer x = 2661
integer y = 1156
integer width = 293
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
end type

event clicked;//-------Begin Added by Alfee 01.04.2008--------------------
Integer i
string ls_updatecol[]
string ls_where

IF dw_parameter.AcceptText() = -1 THEN
	MessageBox("Verify Syntax", "The syntax is not valid.")
	RETURN
END IF

//Check new empty lines, on which the FindRequired() won't work
FOR i = 1 to dw_parameter.RowCount() 
	IF dw_parameter.GetItemStatus(i, 0, Primary!) = New! THEN 
		MessageBox("Verify Syntax", "The syntax is not valid.")
		RETURN
	END IF
NEXT

//Check required columns
IF dw_parameter.event pfc_validation( ) = dw_parameter.failure THEN RETURN
//-------End Added -----------------------------------------

if not isvalid(ids_parm) then
	ids_parm = create datastore
	ids_parm.dataobject = dw_parameter.dataobject
end if
dw_parameter.Sharedata(ids_parm)
IF f_ctx_find(1, ids_parm,ls_updatecol,'2',ls_where) = -1 THEN 
	MessageBox("Verify Syntax", "The syntax is not valid.")
ELSE
	MessageBox("Verify Syntax", "The syntax is OK.")
END IF
dw_parameter.sharedataoff( )
end event

type cb_del from u_cb within w_workflow_properties
boolean visible = false
integer x = 2661
integer y = 1340
integer width = 293
integer height = 84
integer taborder = 40
string text = "&Delete"
end type

event clicked;call super::clicked;dw_parameter.event pfc_deleterow()
end event

type cb_add from u_cb within w_workflow_properties
boolean visible = false
integer x = 2661
integer y = 1252
integer width = 293
integer height = 84
integer taborder = 30
string text = "&Add"
end type

event clicked;call super::clicked;dw_parameter.event pfc_addrow()
end event

type cb_ok from u_cb within w_workflow_properties
integer x = 2418
integer y = 8
integer taborder = 50
string text = "&Save"
end type

event clicked;call super::clicked;str_parm  lstr_parm

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.29.2007 By: Evan
//$<reason> Fix a defect.	
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.09.2007 By: Machongmin
//$<reason> Fix a defect.	
long ll_row,ll_wf_id,ll_count
string ls_wf_name
dw_workflow.accepttext()
ll_row = dw_workflow.getrow()

if ll_row > 0 then
	ls_wf_name = dw_workflow.getitemstring(ll_row,"wf_name")
	if dw_workflow.getitemstatus(ll_row,0,primary!) = newModified! then
		select count(wf_id) into :ll_count from wf_workflow where wf_name = :ls_wf_name;
		if ll_count > 0 then
			messagebox("Information","Please enter a different Work Flow Name.")
			return
		end if
	end if
	if dw_workflow.getitemstatus(ll_row,0,primary!) = dataModified! then
		ll_wf_id = dw_workflow.getitemnumber(ll_row,"wf_id")
		select count(wf_id) into :ll_count from wf_workflow where wf_id <> :ll_wf_id and wf_name = :ls_wf_name;
		if ll_count > 0 then
			messagebox("Information","Please enter a different Work Flow Name.")
			return
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------
*/
string ls_old_name
string ls_curr_name,ls_triggered_by
long ll_Row,ll_Count,ll_View_ID

dw_workflow.AcceptText()
ll_Row = dw_workflow.GetRow()
if ll_Row <= 0 then Return
ls_curr_name = dw_workflow.GetItemString(ll_Row, "wf_name")
ls_old_name = dw_workflow.GetItemString(ll_Row, "wf_name", Primary!, true)

if IsNull(ls_curr_name) or Trim(ls_curr_name) = "" then
	MessageBox("Information", "Required value missing for Work Flow Name on row 1.  Please enter a value.")
	dw_workflow.SetColumn("wf_name")
	dw_workflow.SetFocus()
	Return
else
	choose case istr_parm.s_type
		case "new", "copy"
			select count(*) into :ll_count from wf_workflow where wf_name = :ls_curr_name;
			if ll_Count > 0 then
				MessageBox("Information", "Please enter a different Work Flow Name.")
				dw_workflow.SetColumn("wf_name")
				dw_workflow.SetFocus()
				Return
			end if
		case "properties"
			if ls_curr_name <> ls_old_name then
				select count(*) into :ll_count from wf_workflow where wf_name = :ls_curr_name;
				if ll_Count > 0 then
					MessageBox("Information", "Please enter a different Work Flow Name.")
					dw_workflow.SetColumn("wf_name")
					dw_workflow.SetFocus()
					Return
				end if
			end if
	end choose
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-14 By: Scofield
//$<Reason> wf_prompt_message column don't need to input if wf_prompt_falg is 'N'.

String	ls_prompt_falg,ls_Null

ls_prompt_falg = dw_WorkFlow.GetItemString(ll_Row, "wf_prompt_falg")
if ls_prompt_falg = "N" then
	SetNull(ls_Null)
	dw_WorkFlow.Modify("wf_prompt_message.Edit.Required = No")
	dw_WorkFlow.SetItem(ll_Row,"wf_prompt_message",ls_Null)
end if
//---------------------------- APPEON END ----------------------------

if parent.event pfc_save() >= 0 then
	lstr_parm.s_type = 'ok'
	lstr_parm.l_wf_id = dw_workflow.getItemNumber(1,"wf_id")
	lstr_parm.s_module = dw_workflow.GetItemString( 1,"wf_module")
	closewithreturn(parent,lstr_parm)
end if

end event

type cb_cancle from u_cb within w_workflow_properties
integer x = 2798
integer y = 8
integer taborder = 60
string text = "&Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;str_parm  lstr_parm

lstr_parm.s_type = 'cancle'


closewithreturn(parent,lstr_parm)
end event

type dw_parameter from u_dw_workflow within w_workflow_properties
event ue_key pbm_dwnkey
event ue_init_field_dddw ( string as_syntax,  long al_screen_id,  ref datawindowchild adwc_field )
integer x = 119
integer y = 980
integer width = 2514
integer height = 472
integer taborder = 20
string dataobject = "d_wf_trigger_parm_status"
boolean border = false
boolean livescroll = false
end type

event ue_key;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_key
//
//	Arguments:  
//
//	Returns:  
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

//New a Record when trigger by Agreement Creation or Practioner Folder Data Value Comparison
string ls_trigger_by
string ls_col_name


if key = KeyTab! and this.GetRow() = this.RowCount()  then
	ls_trigger_by = dw_workflow.GetItemString(1,"wf_triggered_by")
	//001-Agreement,009-Practioner Folder Data Value Comparison
	if ls_trigger_by = "001" then
		ls_col_name = "doc_categorie"
	elseif ls_trigger_by = '009' then
		ls_col_name = "value"
	else
		return 0
	end if
		
	if this.GetColumnName() = ls_col_name then
		this.event pfc_addrow()
	end if
end if
end event

event ue_init_field_dddw(string as_syntax, long al_screen_id, ref datawindowchild adwc_field);datawindow   ldw[] 
integer li_count,li_i,ll_row  
string ls_dddwname

string ls_name,ls_text,ls_error , ls_coltype , ls_tablename,ls_DbName
string ls_tab_name,ls_dw_name[],ls_dataobject[]

parent.setredraw(false)

//<add> 06/20/2007 by: Andy
String ls_wf_triggered_by
//---------Begin Added by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
String ls_wf_module 
ls_wf_module = dw_workflow.GetItemString(1,"wf_module")
IF ISNULL(ls_wf_module) THEN ls_wf_module = ''
//---------End Added ------------------------------------------------------

ls_wf_triggered_by = dw_workflow.GetItemString(1,"wf_triggered_by")
IF ISNULL(ls_wf_triggered_by) THEN ls_wf_triggered_by = ''


if ls_wf_triggered_by = '105' then
	dw_1.dataobject = 'd_dm_new_sell_document'
	dw_1.settransobject(sqlca)
else			
	ls_tab_name = gnv_data.of_get_table_name( al_screen_id, 'C', 'tab_name')
	
	ldw[1] = dw_1
	
	ls_dw_name[1] 		= gnv_data.of_get_table_name( al_screen_id, 'C', 'dw_name')
	ls_dataobject[1] 	= gnv_data.of_get_table_name( al_screen_id, 'C', 'dataobject')
	
	//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
	if ls_wf_module = '01' or ls_wf_module = '02' then
		f_create_contract_dw(1001,ls_tab_name,ldw,ls_dw_name,ls_dataobject)
	else
		f_create_contract_dw(of_GetView_ID(),ls_tab_name,ldw,ls_dw_name,ls_dataobject)	//Modified by Scofield on 2009-03-12
	end if
	//---------End Modfiied ------------------------------------------------------
end if
//end of add

/* Comment 06/20/2007 by: Andy
ls_tab_name = gnv_data.of_get_table_name( al_screen_id, 'C', 'tab_name')

ldw[1] = dw_1

ls_dw_name[1] 		= gnv_data.of_get_table_name( al_screen_id, 'C', 'dw_name')
ls_dataobject[1] 	= gnv_data.of_get_table_name( al_screen_id, 'C', 'dataobject')

f_create_contract_dw(1001,ls_tab_name,ldw,ls_dw_name,ls_dataobject)
*/

dw_1.visible = false
li_count  = integer(dw_1.Describe("DataWindow.Column.Count"))

If li_count > 0  Then
	//ls_tablename = dw_1.Object.DataWindow.Table.UpdateTable		//Commented by Scofield on 2007-09-18
	
	For li_i = 1 to li_count
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modified> 2007-05-16 By: Wu ZhiJun
		//$<reason> Fix a bug
		ls_name = dw_1.Describe("#"+string(li_i) + ".name")
		
		if long(dw_1.describe(ls_name + ".y")) > long(dw_1.describe("datawindow.detail.height")) then continue
		if long(dw_1.describe(ls_name + ".visible")) = 0 then continue
		
		ls_DbName = dw_1.Describe("#"+string(li_i) + ".dbName")
		if Pos(ls_DbName,".") <= 0 then continue
		
		ls_tablename = Left(ls_DbName,Pos(ls_DbName,".") - 1)
		ls_dbname = Mid( ls_DbName , Pos(ls_DbName,".") + 1 )	//jervis 10.23.2009
		//--------------------------- APPEON END -----------------------------
		
		ll_row = adwc_field.InsertRow(0)
		
		adwc_field.SetItem(ll_row,"data_view_screen_screen_id",al_screen_id)
		
		adwc_field.SetItem(ll_row,"sys_fields_field_name",ls_name)
		adwc_field.SetItem(ll_row,"field_dbname",ls_dbname)	//jervis 10.23.2009
		
		ls_text = dw_1.Describe( ls_name + "_t.text")
		if ls_text = "?" or ls_text = "!" then ls_text = ""
		if ls_text = '' then ls_text = ls_name
		adwc_field.SetItem(ll_row,"data_view_fields_field_label",ls_text)
		
		adwc_field.SetItem(ll_row,"data_view_fields_field_order",ll_row)
		
		ls_coltype = dw_1.Describe("#"+string(li_i) + ".coltype")
		Choose Case Left ( ls_coltype , 5 )
			Case "char(", "char"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'S')	//Change 'C' to 'S' -- jervis 03.12.2009
			Case "date"	,"datet"	,"time", "times"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'D')
			Case "decim","numbe", "doubl", "real","long", "ulong", "int"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'N')
		End Choose
		
		adwc_field.SetItem(ll_row,"table_name",ls_tablename)
		
		//modify 08/28/2007 by: Andy
		//if dw_1.Describe(ls_name+".dddw.name") = "d_dddw_code_lookup" then
		ls_dddwname = dw_1.Describe(ls_name+".dddw.name")		
		if ls_dddwname = "d_dddw_code_lookup" or ls_dddwname = "dddw_dm_category" then
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","C")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_code",dw_1.Describe(ls_name+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","Code")
		//add d_dddw_company_list -- jervis 04.15.2011
		elseif ls_dddwname = 'd_dddw_company' or ls_dddwname = 'd_dddw_company_list'  then	//Company dddw-jervis 12.9.2009
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","P")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_code",dw_1.Describe(ls_name+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","falicity_id")
		elseif ls_dddwname = 'd_dddw_users' then	//users dddw -- jervis 12.9.2009
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","U")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_code",adw_screen.Describe(ls_colname+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","user_id")
		end if
	Next
Else
	of_MessageBox ("ue_init_field_dddw", gnv_app.iapp_object.DisplayName, &
						"The DDDW of Field Data Retrieve failed!", information!, Ok!, 1)
End if

parent.setredraw(true)


end event

event pfc_retrieve;call super::pfc_retrieve;long ll_count

ll_count = Retrieve(istr_parm.l_wf_id)
if ll_count < 1 then
	ll_count = this.event pfc_insertrow()
end if

//Begin - Added By Mark Lee 09/03/12 it is delete the 'Action Items->Action Item Browse' ,'Details->Linked Contracts Tab->Linked Contracts','Details->Group Access Tab->Group Access' option
If this.dataobject = 'd_wf_trigger_parm_comparison' And this.describe("screen_id.dddw.name") ='d_wf_dddw_screen_intellicontract'  Then
	Datawindowchild	ldwc_screen
	this.getchild( 'screen_id', ldwc_screen)
	If	ldwc_screen.rowcount() > 0 then
		ldwc_screen.setfilter( ' screen_id <> 42 and screen_id <> 43 and screen_id <> 50 ')
		ldwc_screen.filter()
	End If
End If 
//End - Added By Mark Lee 09/03/12

return ll_count 
end event

event constructor;call super::constructor;this.of_setreqcolumn( true)
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;datawindowchild ldwc
long ll_count
string ls_trigger_by,ls_module,ls_action_type

ls_trigger_by = dw_workflow.GetItemString( 1,"wf_triggered_by")

if this.GetChild( as_column,ldwc) = 1 then
	ldwc.SetTransObject( sqlca)
	choose case ls_trigger_by
		case '008'	//Action Item Changed
			ls_module = dw_workflow.GetItemString( 1,"wf_module")
			if as_column = "action_type_id" then
				Choose Case ls_module
					Case '01'
						ls_action_type = 'Verification Method'
					Case '02'
						ls_action_type = 'Action Type'
					Case '03','04'
						ls_action_type = 'Contract Action Type'
					//03/28/2007 By Jervis
					/*
					Case '04'
						ls_action_type = 'Agreement Manager Action Type'
					*/
				End Choose
			else
				Choose Case ls_module
					Case '01'
						ls_action_type = 'Credentials Verification Response'
					Case '02'
						ls_action_type = 'Action Status'
					Case '03','04'
						ls_action_type = 'Contract Action Status'
					/*
					Case '04'
						ls_action_type = 'Agreement Manager Action Status'
					*/
				End Choose
			end if
			ll_count = ldwc.Retrieve(ls_action_type)
		case '009'	//Practitioner folder data value comparison			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 01.14.2008 By: Evan
			//$<reason> Fix BugJ122804 about no data displays in the Screen dropdown listbox in Trigger Parameters.
			//ll_count = ldwc.Retrieve(integer(gnv_data.of_getitem('security_users','default_view',"upper(user_id)='" + upper(gs_user_id) + "'")))
			integer li_data_view_id
			li_data_view_id = integer(gnv_data.of_getitem('security_users','default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
			if IsNull(li_data_view_id) or li_data_view_id < 1 then li_data_view_id = 1
			ll_count = ldwc.Retrieve(li_data_view_id)
			//---------------------------- APPEON END ----------------------------
		case '100','105'	//Contract data value comparison
			ll_count = ldwc.Retrieve(of_GetView_ID())		//Modified by Scofield on 2009-03-12
			//Begin - Added By Mark Lee 09/05/12
			If	ldwc.rowcount() > 0 and as_column = 'screen_id' then
				ldwc.setfilter( ' screen_id <> 42 and screen_id <> 43 and screen_id <> 50 ')
				ldwc.filter()
			End If
			//End - Added By Mark Lee 09/05/12

	end choose
		
	if ll_count < 1 then
		ll_count = ldwc.InsertRow(0)
	end if
	
	return ll_count
end if

Return 0				//Added by Scofield on 2009-03-19

end event

event itemfocuschanged;call super::itemfocuschanged;string ls_trigger_by
long ll_screen_id,ll_row
datawindowchild ldwc_field,ldwc_screen
string ls_dwsyntax



if dwo.name = "field_label" then
	ls_trigger_by = dw_workflow.GetItemString(1,'wf_triggered_by')
	ll_screen_id = this.GetItemNumber( row, "screen_id")
	if (ls_trigger_by = '100' or ls_trigger_by = '105' or ls_trigger_by = '009') then
		if this.GetChild( dwo.name,ldwc_field) = 1 then
			if ll_screen_id > 0 then
				ldwc_field.SetFilter( "data_view_screen_screen_id = " + string(ll_screen_id))
				ldwc_field.Filter()
			else
				ldwc_field.SetFilter( "1 = 2")
				ldwc_field.Filter( )
			end if
		end if
		if ldwc_field.Rowcount( ) < 1  and (ls_trigger_by = '100' or ls_trigger_by = '105') then
			//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
			////Init IntelliContract Field Data of Screen
			//if this.GetChild( "screen_id",ldwc_screen) = 1 then
			//	ll_row = ldwc_screen.find( "screen_id = " + string(ll_screen_id), 1,ldwc_screen.RowCount())
			//	if ll_row > 0 then
			//		//Dynamic Create DataStore,Gets all field
			//		ls_dwsyntax = ldwc_screen.GetItemString( ll_row,"dw_sql")
			//		event ue_init_field_dddw(ls_dwsyntax,ll_screen_id,ldwc_field)
			//	end if

			//end if
			event ue_init_field_dddw('',ll_screen_id,ldwc_field)
			//---------End Modfiied ------------------------------------------------------
		end if
	end if
elseif this.GetChild( "field_label", ldwc_field) = 1 then
	if ldwc_field.Describe("datawindow.table.filter") <> "?" then
		ldwc_field.SetFilter("")
		ldwc_field.Filter( )
		this.SetRedraw( true)
	end if
end if

end event

event itemchanged;call super::itemchanged;string ls_null
datawindowchild ldwc
string	ls_triggered
long ll_row
ls_triggered = dw_workflow.getitemstring( dw_workflow.GetRow(), 'wf_triggered_by')
SetNull(ls_null)

Choose Case dwo.name
	Case "screen_id"
		//Clear field_name data
		this.SetItem(row,"field_label",ls_null)
		this.SetItem(row,"field_name",ls_null)
		//Start 01.11.2007 by Jervis
		this.SetItem(row,"lookup_flag",ls_null)
		this.SetItem(row,"lookup_code",ls_null)
		this.SetItem(row,"value",this.GetItemString(row,"value_display"))
		//End
	Case "field_label"
		If this.GetChild( dwo.name,ldwc) = 1 Then
			ll_row = ldwc.GetRow()
			
			this.SetItem(row,"field_name",ldwc.GetItemString(ll_row,"sys_fields_field_name"))
			this.SetItem(row,"field_type",ldwc.GetItemString(ll_row,"sys_fields_field_type"))
			
			//start code 1.11.2007 By jervis
			if ldwc.GetItemString(ll_row,"sys_fields_lookup_type") = 'C' and ldwc.GetItemString(ll_row,"sys_fields_lookup_field") = 'Y' and ldwc.GetItemString(ll_row,"sys_fields_lookup_field_name") = 'Code' then
				this.SetItem(row,"lookup_flag","Y")
				this.SetItem(row,"lookup_code",ldwc.GetItemString(ll_row,"sys_fields_lookup_code"))
				this.SetItem(row,"value",ls_null)
				this.SetItem(row,"value_display",ls_null)
			elseif ldwc.GetItemString(ll_row,"sys_fields_lookup_type") = 'P' then	//Company dddw-jervis 12.9.2009
				this.SetItem(row,"lookup_flag","P")
				this.SetItem(row,"lookup_code",ldwc.GetItemString(ll_row,"sys_fields_lookup_code"))
				this.SetItem(row,"value",ls_null)
				this.SetItem(row,"value_display",ls_null)
			elseif ldwc.GetItemString(ll_row,"sys_fields_lookup_type") = 'U' then	//user dddw - jervis 12.9.2009
				this.SetItem(row,"lookup_flag","U")
				this.SetItem(row,"lookup_code",ls_null)
				this.SetItem(row,"value",ls_null)
				this.SetItem(row,"value_display",ls_null)
			else
				this.SetItem(row,"lookup_flag",ls_null)
				this.SetItem(row,"lookup_code",ls_null)
				this.SetItem(row,"value",this.GetItemString(row,"value_display"))
			end if
			//end code 
			
			If ls_triggered = '100' or ls_triggered = '105' Then
				this.SetItem(row,"table_name",ldwc.GetItemString(ll_row,"table_name"))
			End If
			
		End If
	//01.11.2007 by Jervis
	case "value_display"
		this.SetItem(row,"value",data)
	case "operator"
		if data = "is" then
			this.SetItem(row,"value",'NULL')
			this.SetItem(row,"value_display",'NULL')
		end if
End Choose
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_key_id,ll_i,ll_wf_id
string ls_trigger_by,ls_module
long ll_action_type,ll_action_status,ll_count

ll_wf_id = dw_workflow.GetItemNumber(1,"wf_id")

ls_trigger_by = dw_workFlow.GetItemString( 1,"wf_triggered_by")

//Check data valid when trigger by action item change
if ls_trigger_by = "008" and this.RowCount() > 0 then
	ls_module = dw_workflow.GetItemString(1,"wf_module")
	ll_action_type = this.GetItemNumber(1,"action_type_id")
	ll_action_status = this.GetItemNumber(1,"action_status_id")
	select count(*) into :ll_count
	from wf_trigger_param_action_status t1,wf_workflow t2
	where t1.wf_id = t2.wf_id and t2.wf_module = :ls_module and 
			t1.action_type_id = :ll_action_type and t1.action_status_id = :ll_action_status;
	if ll_count > 0 then
		//of_MessageBox ("pfc_preupdate", gnv_app.iapp_object.DisplayName, &   //Start Code Change ----01.26.2017 #V153 maha - modified message
		of_MessageBox ("pfc_preupdate", "Workflow Trigger duplicated", &
				"The Action Type selected is connected to an existing Workflow under the WF module: IntelliApp.   Please select a different Action Type in the Trigger Parameters field. ", information!, Ok!, 1)
		return -1
	end if
end if

if ls_trigger_by = "009" or ls_trigger_by = "100" or ls_trigger_by = "105" then
	//get key id
	select max(key_id) into :ll_key_id from wf_trigger_param_data_comparison;	
	if isnull(ll_key_id) then ll_key_id = 0
	ll_key_id++
end if
for ll_i = 1 to dw_parameter.rowcount( )
	if dw_parameter.GetItemStatus( ll_i,0,primary!) = NewModified! then
		dw_parameter.setItem(ll_i,"wf_id",ll_wf_id)
		
		//if trigger by Practitioner Folder or Contract data value Comparison
		if ls_trigger_by = "009" or ls_trigger_by = "100" or ls_trigger_by = "105" then
			//Set Field of Key_ID
			dw_parameter.SetItem(ll_i,"Key_id",ll_key_id)
			ll_key_id++
			
			//Set the type
			if ls_trigger_by = "009" then
				dw_parameter.SetItem(ll_i,"type","P")
			else
				dw_parameter.SetItem( ll_i,"type","I")
			end if
		end if
	end if
next
return 1

end event

event pfc_addrow;call super::pfc_addrow;//
String ls_triggered

If not this.GetRow() > 0 Then return 1

ls_triggered = dw_workflow.getitemstring( dw_workflow.GetRow(), 'wf_triggered_by')

Choose Case ls_triggered
	Case '009','100','105'
		This.Setitem(this.GetRow() , 'module' , dw_workflow.getitemstring( dw_workflow.GetRow(), 'wf_module'))
End Choose

Return 1
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;//
String ls_triggered

If not this.GetRow() > 0 Then return 

ls_triggered = dw_workflow.getitemstring( dw_workflow.GetRow(), 'wf_triggered_by')

Choose Case ls_triggered
	Case '009','100','105'
		This.Setitem(this.GetRow() , 'module' , dw_workflow.getitemstring( dw_workflow.GetRow(), 'wf_module'))
End Choose

Return 
end event

event buttonclicked;call super::buttonclicked;string ls_lookup_name
string ls_desc
str_pass lstr_pass
long ll_screen_id
datawindowchild ldwc_field
string ls_dddw_type

if dwo.name = "b_dropdown" then
	ls_dddw_type = this.GetItemString(row,"lookup_flag")
	ls_lookup_name = this.GetItemString(row,"lookup_code")
	if ls_dddw_type = 'Y' then
		OpenWithParm( w_lookup_search_dddw,'C' + "@" + ls_lookup_name)
		if message.stringparm <> "Cancel" then
			this.SetItem(row,"value",string(message.DoubleParm))
			ls_desc = gnv_data.of_GetItem("code_lookup","code","lookup_code = " + string(message.DoubleParm))
			this.SetItem(row,"value_display",ls_desc)
		end if
	elseif ls_dddw_type = 'P' then	//Company dddw-jervis 12.9.2009
		string ls_value
		string ls_operator
		//Select company
		OpenWithParm(w_facility_name_select,"code&" + ls_lookup_name)
		
		ls_Value = Message.StringParm
		if IsNull(ls_Value) or Trim(ls_Value) = "" then Return
		
		ls_operator = this.GetItemString(row, "operator")
		if Lower(ls_operator) <> "in" then
			ls_Value = Left(ls_Value,Pos(ls_Value,",") - 1)
		else
			ls_Value = Left(ls_Value,Len(ls_Value) - 1)
		end if
		
		This.SetItem(row,"value", ls_value)
		ls_desc = gnv_data.of_getItem("ctx_facility","facility_name","facility_id = " + string(ls_value))
		This.SetItem(row,"value_display",ls_desc)
	elseif ls_dddw_type= 'U' then 	//User dddw-jervis 12.9.2009
		//
	end if
		
elseif dwo.name = 'b_expression' then
	ll_screen_id = this.GetItemNumber( row, "screen_id")
	if this.GetChild('field_label',ldwc_field) = 1 then
		ldwc_field.SetFilter( "data_view_screen_screen_id = " + string(ll_screen_id))
		ldwc_field.Filter()
		if ldwc_field.Rowcount( ) < 1 then event ue_init_field_dddw('',ll_screen_id,ldwc_field)
	end if
					
	//Trigger Parm
	lstr_pass.s_long[1] = 4	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call, 4 - Trigger Parm
	
	lstr_pass.s_string          = this.GetItemString(row,'value_display')

	lstr_pass.s_string_array[1] = this.GetItemString( row,'field_name')
	//lstr_pass.s_string_array[2] = this.GetItemString(row, 'field_type')
	lstr_pass.s_u_dw            = this
	OpenWithParm(w_export_expression,lstr_pass)
	lstr_pass = Message.PowerObjectParm
	if isvalid(lstr_pass) then
		if  trim(lstr_pass.s_string) <> "" then
			this.SetItem(row,"value_display",lstr_pass.s_string)
			this.SetItem(row,"Value",lstr_pass.s_string)
		end if
	end if
end if

end event

type dw_workflow from u_dw_workflow within w_workflow_properties
event ue_key pbm_dwnkey
event ue_set_triggerby ( string as_moudle )
integer x = 37
integer y = 124
integer width = 3118
integer height = 1748
integer taborder = 10
string dataobject = "d_wf_workflow_properties"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_key;string ls_name,ls_prompt_flag,ls_trigger_by,ls_comp_type

if key = KeyTab! and this.RowCount() > 0 then
	ls_name = lower(this.GetColumnName())
	ls_prompt_flag = this.GetItemString(1,"wf_prompt_falg") 
	ls_trigger_by = this.GetItemString( 1,"wf_triggered_by")

	
	if (ls_trigger_by = "001" and ls_name = "agreement_flag") or &
		(ls_trigger_by = "009" and ls_name = "comparison_type") or &
		((ls_name = "wf_prompt_message" and ls_prompt_flag = "Y") or (ls_prompt_flag = "N" and ls_name = "wf_prompt_falg")) and (ls_trigger_by <> "001" and ls_trigger_by <> "009") then
		dw_parameter.SetFocus( )
		//dw_parameter.Setrow( 1)
	elseif ls_name = "wf_description" then
		cb_ok.SetFocus()
	end if
		
end if
end event

event ue_set_triggerby(string as_moudle);string ls_trigger_by


//Dynamic Set ddlb of Trigger by
//001-New Sell Side Document,002-New Contract,003-New Practitioner Added,004-Practitioner Expiring Appointment,
//005-Practitioner Reappointment Initiated,006-Practitioner Status Change,007-Practitioner Data Entry Complete,008-Action Item Change
//009-Practitioner Folder Data Value Comparision,100-Contract Folder Data Value Comparison,101-WebView Practitioner Application Completed
//02.27.2007 add:104-New Buy Side Document

choose case as_moudle
	case "01"		//IntelliCred
		ls_trigger_by = 	"Manual	102/New Practitioner Added	003/Practitioner Expiring Appointment	004/" + &
								"Practitioner Reappointment Initiated	005/Practitioner Status Change	006/" + &
								"Practitioner Data Entry Complete	007/Action Item Change	008/" + &
								"Practitioner Folder Data Value Comparison	009/WebView Practitioner Application Completed	101/" +&
								"WebView Practitioner Application Initiated 	103/"
	case "02"		//IntelliApp
		ls_trigger_by = 	"Manual	102/New Practitioner Added	003/Practitioner Data Entry Complete	007/" + &
								"Action Item Change	008/Practitioner Folder Data Value Comparison	009/"
	//Start Change By Jervis 02.27.2007
	case "03"		//03-Contract
		//ls_trigger_by = 	"Manual	102/Contract Sell Side Creation	001/New Contract Buy Side	002/Action Item Change	008/Contract Folder Data Value Comparison	100/"
		ls_trigger_by = 	"Manual	102/New Contract	002/Action Item Change	008/Contract Folder Data Value Comparison	100/Contract Date Alarm	106/"
	case "04"		//,04-Contract Document Manager
		//<Modify> andy 2007.06.04 
		//ls_trigger_by = 	"Manual	102/New Buy Side Document	104/New Sell Side Document	001/Action Item Change	008/"
		ls_trigger_by = 	"Manual	102/New Buy Side Document	104/New Sell Side Document	001/Action Item Change	008/Document Manager Folder Data Value Comparison	105/"
		//end of Modify 
	//End Change	
	case else
		ls_trigger_by = ""
end choose

dw_workflow.Modify("wf_triggered_by.values ='" + ls_trigger_by + "'")
end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  itemchanged
//
//	Arguments:  
//
//	Returns:  
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
string ls_modify,ls_triggered_by
string ls_trigger_arr[]
string ls_null

choose case lower(dwo.name)
	//Depending on what Trigger bype is selected the Parameter Group Box could display 
	//different fields to collect information related to the trigger
	case 'wf_triggered_by'
		SetRedraw(false)
		of_redraw_dataobject(data)
		SetRedraw(true)
	//Begin add by Scofield on 2009-03-12
	case "view_id"
		ls_triggered_by = This.GetItemString(Row,"wf_triggered_by")
		if ls_triggered_by = "100" or ls_triggered_by = "105" then
			dw_parameter.Reset()
			dw_parameter.event pfc_insertrow()
			dw_parameter.Post Event pfc_retrievedddw("screen_id")
		end if
	//End add by Scofield on 2009-03-12
	case 'wf_prompt_falg'
		if data = "Y" then
			this.Modify("wf_prompt_message.Edit.Required = Yes")
		else
			SetNull(ls_null)
			this.Modify("wf_prompt_message.Edit.Required = No")
			//this.SetItem(row,"wf_prompt_message","")
			this.SetItem(row,"wf_prompt_message",ls_null)	//03.17.2008 By Jervis Fixed BugE012302
		end if
	case 'comparison_type'
		if data = "F" then	//Field value comparison
			ls_modify = "field_label.visible = 1 field_id_t.visible = 1 operator.visible = 1 comparative_t.visible = 1 " + &
							"value.visible = 1 value_t.visible = 1 sql_statement.visible = 0 sql_statement_t.visible = 0 " + &
							"datawindow.detail.height = 88 field_label.dddw.Required = yes operator.edit.required = yes value.edit.required = yes sql_statement.edit.required = no " + &
							"value_display.visible = 1" //Add by Evan 01/12/2008
		else						//SQL Statement comparison
			ls_modify = "field_label.visible = 0 field_id_t.visible = 0 operator.visible = 0 " + &
							"comparative_t.visible = 0 value.visible = 0 value_t.visible = 0 sql_statement.visible = 1 " + &
							"sql_statement_t.visible = 1 datawindow.detail.height = 176 " + &
							"field_label.dddw.Required = no operator.edit.required = no value.edit.required = no " + &
							"sql_statement.edit.required = yes " + &
							"value_display.visible = 0" //Add by Evan 01/12/2008
		end if
	
		dw_parameter.Modify(ls_modify )
		dw_parameter.reset( )
		dw_parameter.event pfc_addrow()
	case "wf_module"
		//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
		if data = "01" or data = "02" then
			Long ll_null
			SetNull(ll_null)
			dw_workflow.Modify("view_id.visible='0' view_id_t.visible='0' wf_trigger_onlogin.visible='0' wf_trigger_onsave.visible='0' suppress_alert.visible='0' t_1.visible='0'")
			dw_workflow.setitem( row, "view_id", ll_null)
			dw_workflow.setitem( row, "wf_trigger_onlogin", "N")
			dw_workflow.setitem( row, "wf_trigger_onsave", "N")
			dw_workflow.setitem( row, "suppress_alert", 0)
		else
			dw_workflow.Modify("view_id.visible='1' view_id_t.visible='1' wf_trigger_onlogin.visible='1' wf_trigger_onsave.visible='1' suppress_alert.visible='1' t_1.visible='1'")
		end if
		//---------End Modfiied ------------------------------------------------------

		event ue_set_triggerby(data)
		//Set Default Value 008-Manual
		this.SetItem(row,"wf_triggered_by","102")
		this.event ItemChanged(row,this.object.wf_triggered_by,"102")
	/*	
	case "agreement_flag"
		if data = "Y" then 
			dw_parameter.enabled = false
			dw_parameter.of_SetUpdateable(false)
			cb_add.enabled = false
			cb_del.enabled = false
			dw_parameter.of_set_column_enable( "doc_id",false)
			dw_parameter.of_set_column_enable( "doc_categorie",false)
		else
			dw_parameter.enabled = true
			dw_parameter.of_SetUpdateable(true)
			cb_add.enabled = true
			cb_del.enabled = true
			dw_parameter.of_set_column_enable( "doc_id",true)
			dw_parameter.of_set_column_enable( "doc_categorie",true)
		end if
	*/
end choose

end event

event pfc_retrieve;call super::pfc_retrieve;return Retrieve(istr_parm.l_wf_id)
end event

event constructor;call super::constructor;of_SetReqColumn( true)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.11.2007 By: Jervis
//$<reason> 
string ls_ddlb
int li_product,li_contract_set
li_product = of_get_app_setting('set_9', 'I')
li_contract_set = of_get_app_setting('set_cont', 'I')

choose case li_product
	case 0
		ls_ddlb = "IntelliCred	01/"
		//---------Begin Added by (Appeon)Toney 11.21.2013 for V141 ISG-CLX--------
		//$Reason:Fix history BugT080801  //re-added by alfee 12.18.2013
		if gi_iapp_on = 1 then
			ls_ddlb += "IntelliApp	02/"
		end if		
		//---------End Added ------------------------------------------------------------------
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

this.Modify("wf_module.values = '" + ls_ddlb + "'")	
//---------------------------- APPEON END ----------------------------
end event

event buttonclicked;call super::buttonclicked;String ls_view,ls_status

If dwo.Name = 'b_notes'	And row > 0 Then
	OpenWithParm( w_wf_notes, This.GetItemString( row, "wf_description" ))
	If Message.StringParm = "Cancel" Then
		Return failure
	Else
		This.SetItem( row, "wf_description", Message.StringParm )
	End If
End If

//Added By Ken.Guo 12/19/2012
If dwo.name = 'b_view' and Row > 0 Then
	ls_view = This.GetItemString(row, 'wf_triggered_view')
	OpenWithParm(w_wf_view_select, ls_view)
	If message.Stringparm = 'cancel' Then
		Return failure
	End If
	This.SetItem(row,'wf_triggered_view',Message.StringParm )
End If
If dwo.name = 'b_status' and Row > 0 Then
	ls_status = This.GetItemString(row, 'wf_triggered_ctx_status')
	OpenWithParm(w_wf_ctx_status_select, ls_status)
	If message.Stringparm = 'cancel' Then
		Return failure
	End If
	This.SetItem(row,'wf_triggered_ctx_status',Message.StringParm )
End If

end event

event retrieveend;call super::retrieveend;//Set ddlb values of Trigger by
if rowcount > 0 then
	event ue_set_triggerby(this.GetItemString(1,"wf_module"))
end if
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;//Set ddlb values of Trigger by
if al_row > 0 then
	event ue_set_triggerby(this.GetItemString(1,"wf_module"))
end if

//Set Create Date of Work Flow
dw_workFlow.SetItem(al_row,"wf_create_date",today())

end event

event pfc_preupdate;call super::pfc_preupdate;long ll_i,ll_wf_id,ll_key_id
string ls_trigger_by,ls_trigger_type,ls_comp_type
dwItemStatus ldis_status

if dw_workflow.Rowcount( ) > 0 then
	//Auto Set Field value
	ldis_status = dw_workflow.GetItemStatus( 1,0,primary!)
	
	
	//get Work Flow ID
	select max(wf_id) into :ll_wf_id from wf_workflow;
	if isnull(ll_wf_id) then ll_wf_id = 0
	ll_wf_id++
	
	
	if ldis_status = NewModified! then
		//Set Work Flow ID
		dw_workflow.SetItem(1,"wf_id",ll_wf_id)
		
		//Copy data of Action types and action status
		if istr_parm.s_type = "copy" then
			gnv_appeondb.of_startqueue( )
			insert into wf_action_types(
				wf_id,   
				step_id,   
				step_name,   
				action_type_id,   
				action_desc,   
				step_order,   
				create_flag,   
				due_days,   
				weekend_flag,   
				to_user,   
				dept_chair_flag,   
				by_user,   
				create_user_flag,   
				mail_notify,   
				cc_user,
				send_to_user,
				DisplayLocation)
			SELECT :ll_wf_id,   
				step_id,   
				step_name,   
				action_type_id,   
				action_desc,   
				step_order,   
				create_flag,   
				due_days,   
				weekend_flag,   
				to_user,   
				dept_chair_flag,   
				by_user,   
				create_user_flag,   
				mail_notify,   
				cc_user,
				send_to_user,
				DisplayLocation
			FROM wf_action_types   
			where wf_id = :istr_parm.l_wf_id;
			
			//Add Prompt_flag,Prompt_message,wf_esign -- jervis 01.13.2011
			insert into wf_action_status(
				wf_id,
				step_id,
				status_id,
				status_name,
				action_status_id,
				action_status_desc,
				initial_flag,
				update_header_flag,
				update_status_id,
				to_step,
				trigger_flow,
				create_step,
				mail_notify,
				cc_notify_user,
				mail_reminder,
				cc_reminder_user,
				days_reminder,
				days_every,
				send_count,
				mail_message,
				to_message_user,
				cc_message_user,
				return_days,
				resend_times,
				day_interval,
				popup_flag,
				include_note_flag,
				to_notify_user,
				to_reminder_user,
				letter_id,
				complete_flag,
				process_flag,
				set_step,
				set_status,
				set_wf_id,
				Prompt_flag,
      		Prompt_message,
      		wf_esign) 
			SELECT :ll_wf_id,
				step_id,
				status_id,
				status_name,
				action_status_id,
				action_status_desc,
				initial_flag,
				update_header_flag,
				update_status_id,
				to_step,
				trigger_flow,
				create_step,
				mail_notify,
				cc_notify_user,
				mail_reminder,
				cc_reminder_user,
				days_reminder,
				days_every,
				send_count,
				mail_message,
				to_message_user,
				cc_message_user,
				return_days,
				resend_times,
				day_interval,
				popup_flag,
				include_note_flag,
				to_notify_user,
				to_reminder_user,
				letter_id,
				complete_flag,
				process_flag,
				set_step,
				set_status,set_wf_id,
				Prompt_flag,
      		Prompt_message,
      		wf_esign
			FROM wf_action_status   
			where wf_id = :istr_parm.l_wf_id;
			
			//Copy Advanced Update  -- jervis 10.22.2010
			INSERT INTO wf_advanced_update
           (wf_id
           ,wf_step_id
           ,wf_status_id
           ,view_id
           ,screen_id
           ,table_name
           ,field_name
           ,Field_label
           ,field_type
           ,operator
           ,field_value
           ,field_display_value
           ,lookup_name
           ,Field_flag
           ,field_expression)
     		SELECT :ll_wf_id, 
           wf_step_id, 
           wf_status_id, 
           view_id, 
           screen_id, 
           table_name,
           field_name,
           Field_label,
           field_type,
           operator,
           field_value,
           field_display_value,
           lookup_name,
           Field_flag,
           field_expression
			FROM wf_advanced_update
			WHERE wf_id = :istr_parm.l_wf_id;
			
			INSERT INTO wf_advanced_update_criteria
           (wf_id
           ,wf_step_id
           ,wf_status_id
           ,key_id
           ,view_id
           ,screen_id
           ,field_name
           ,field_label
           ,operator
           ,Value
           ,logical
           ,module
           ,field_type
           ,table_name
           ,value_display
           ,lookup_code
           ,lookup_flag
           ,left_bracket
           ,right_bracket
			  ,field_parent)
     		SELECT :ll_wf_id, 
           t1.wf_step_id, 
           t1.wf_status_id, 
           t2.key_id, 
           t1.view_id, 
           t1.screen_id, 
           t1.field_name, 
           t1.field_label, 
           t1.operator, 
           t1.Value, 
           t1.logical, 
           t1.module, 
           t1.field_type, 
           t1.table_name, 
           t1.value_display,
           t1.lookup_code,
           t1.lookup_flag,
           t1.left_bracket, 
           t1.right_bracket,
			  t1.field_parent
			FROM wf_advanced_update_criteria t1,wf_advanced_update t2
			WHERE t1.wf_id = :istr_parm.l_wf_id and t2.wf_id =:ll_wf_id and
					t1.wf_step_id = t2.wf_step_id and t1.wf_status_id = t2.wf_status_id and 
					t1.screen_id = t2.screen_id and t1.field_parent = t2.field_name ;
			  
			gnv_appeondb.of_commitqueue( )
		end if
	end if
	
	//Set Update Date
	dw_workFlow.SetItem(1,"wf_update_date",today())

		
end if

return SUCCESS
end event

type dw_1 from u_dw within w_workflow_properties
boolean visible = false
integer x = 1070
integer y = 156
integer width = 722
integer height = 16
integer taborder = 50
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

