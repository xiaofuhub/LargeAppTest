$PBExportHeader$u_tabpg_org_details.sru
$PBExportComments$[intellicontract_tab]  Org details tabpage
forward
global type u_tabpg_org_details from u_tabpg_contract_master
end type
type dw_org_contacts from u_dw_contract within u_tabpg_org_details
end type
type cb_delete from u_cb within u_tabpg_org_details
end type
type cb_insert from u_cb within u_tabpg_org_details
end type
type dw_org from u_dw_contract within u_tabpg_org_details
end type
type cb_1 from u_cb within u_tabpg_org_details
end type
type cb_2 from u_cb within u_tabpg_org_details
end type
type cb_3 from u_cb within u_tabpg_org_details
end type
end forward

global type u_tabpg_org_details from u_tabpg_contract_master
integer width = 3648
integer height = 1620
string text = "Details"
dw_org_contacts dw_org_contacts
cb_delete cb_delete
cb_insert cb_insert
dw_org dw_org
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global u_tabpg_org_details u_tabpg_org_details

type variables
tab a_parent_tab
long il_org_id
end variables

forward prototypes
public function integer of_set_org_id (long al_org_id)
public function integer of_retrieve ()
end prototypes

public function integer of_set_org_id (long al_org_id);
il_org_id = al_org_id
return success
end function

public function integer of_retrieve ();



if not ib_retrieved then
		dw_org.event pfc_retrieve( )
		dw_org_contacts.event pfc_retrieve( )
		dw_org.setcolumn( 'org_name')
end if 

ib_retrieved = true



return success
end function

on u_tabpg_org_details.create
int iCurrent
call super::create
this.dw_org_contacts=create dw_org_contacts
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.dw_org=create dw_org
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_org_contacts
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_insert
this.Control[iCurrent+4]=this.dw_org
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
end on

on u_tabpg_org_details.destroy
call super::destroy
destroy(this.dw_org_contacts)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.dw_org)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event constructor;call super::constructor;a_parent_tab = GetParent()
end event

event ue_new;

this.enabled = true

dw_org_contacts.reset()
dw_org_contacts.event pfc_insertrow( )

dw_org.reset()
dw_org.event pfc_insertrow( )
dw_org.setfocus( )
dw_org.setcolumn( 'org_name')

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.18.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.

dw_org.event ue_populatedddws( )
dw_org_contacts.event ue_populatedddws( )
//---------------------------- APPEON END ----------------------------

end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_org_details
integer x = 0
integer y = 1816
integer width = 3657
integer height = 64
end type

type dw_org_contacts from u_dw_contract within u_tabpg_org_details
string tag = "Contacts"
integer x = 46
integer y = 1088
integer width = 3122
integer height = 484
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Contacts"
string dataobject = "d_org_contacts"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 29 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

powerobject apo_objects[]

this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

apo_objects[1]  = dw_org
apo_objects[2]  = dw_org_contacts
of_setupdateobjects(apo_objects)
end event

event pfc_preupdate;call super::pfc_preupdate;


long ll_i


for ll_i = 1 to this.rowcount( )

  if isnull(this.object.org_id[ll_i]) then
	this.object.org_id[ll_i] = dw_org.object.org_id[1]
  end if 

next

return success
end event

event pfc_retrieve;call super::pfc_retrieve;

if dw_org.rowcount() < 1 then return success

RETURN RETrieve(dw_org.object.org_id[1])
end event

event clicked;call super::clicked;//event ue_populatedddws( )
end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-15 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

type cb_delete from u_cb within u_tabpg_org_details
event ue_new ( )
integer x = 3218
integer y = 1200
integer taborder = 11
boolean bringtotop = true
string text = "&Delete"
end type

event clicked;call super::clicked;
long ll_selected_row
ll_selected_row = parent.dw_org_contacts.getselectedrow(0)

if ll_selected_row < 1 then 
	//messagebox(iw_parent.title, 'Please select a row.' )
else 
	if messagebox(iw_parent.title, 'Are you sure you want to delete this row?',stopsign!,yesno!,1) = 1 then
    dw_org_contacts.deleterow(ll_selected_row)
	 //update()
   end if
end if 

end event

type cb_insert from u_cb within u_tabpg_org_details
integer x = 3218
integer y = 1088
integer taborder = 11
boolean bringtotop = true
string text = "&Insert"
end type

event clicked;call super::clicked;

PARENT.DW_org_contacts.event pfc_insertrow( )
end event

type dw_org from u_dw_contract within u_tabpg_org_details
string tag = "Organization "
integer x = 41
integer y = 44
integer width = 3127
integer height = 996
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Organization "
string dataobject = "d_org"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_rmbmenu = false
end type

event pfc_preupdate;call super::pfc_preupdate;



long ll_max
if isnull(this.object.org_id[1]) then
	select max(org_id) 
	into :il_org_id
	from ctx_orgs;
	
	if isnull(il_org_id) then
		il_org_id = 1 
	else 
		il_org_id = 1 + il_org_id
	end if 
	
	this.object.org_id[1] = il_org_id
	
	
end if 

return success

end event

event pfc_retrieve;call super::pfc_retrieve;
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
**  Created By	: Michael B. Skinner 29 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if a_parent_tab.classname( ) = 'tab_1' then
		retrieve( a_parent_tab.function dynamic of_get_org_id( ))
	else 
		retrieve( il_org_id )
end if

RETURN success
end event

event pfc_validation;call super::pfc_validation;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_string ,ls_headertext



if not f_validstr(string(object.org_name[1]) ) then
	 ls_headertext = left(describe ('org_name' + "_t.text"), len(describe ('org_name' + "_t.text")) -1)
	 messagebox(iw_parent.title, 'The ' + ls_headertext + ' is a reqired field.' )
	return failure
end if


if not f_validstr(string(object.org_type[1]) ) then
	 ls_headertext = left(describe ('org_type' + "_t.text"), len(describe ('org_type' + "_t.text")) -1)
	messagebox(iw_parent.title, 'The ' + ls_headertext + ' is a reqired field.' )
	return failure
end if




return success
end event

event doubleclicked;call super::doubleclicked;//Added By Mark Lee 04/26/12 for add a judge
dwItemStatus	 ldis_status

ldis_status = this.GetItemStatus(row, 0,Primary!)
If ldis_status <> New!	Then
	
	cb_2.event clicked( )
	
End If

end event

event clicked;call super::clicked;//event ue_populatedddws( )
end event

type cb_1 from u_cb within u_tabpg_org_details
integer x = 3223
integer y = 44
integer taborder = 21
boolean bringtotop = true
string text = "S&ave"
end type

event clicked;call super::clicked;setpointer(hourglass!)

iw_parent.event dynamic pfc_save()


setpointer(arrow!)

end event

type cb_2 from u_cb within u_tabpg_org_details
integer x = 3223
integer y = 160
integer taborder = 31
boolean bringtotop = true
string text = "&Save/Select"
end type

event clicked;call super::clicked;
setpointer(hourglass!)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.11.2007 By: Jack
//$<reason> Fix a defect.
/*
if iw_parent.event dynamic pfc_save() > 0 then 
*/
long ll_org_id //Add by Jack 05/22/2007
if iw_parent.event dynamic pfc_save() >= 0 then 
//---------------------------- APPEON END ----------------------------
	iw_parent.function dynamic OF_ADD_orgs(dw_org.object.org_id[1] ,&
																		dw_org.object.org_name[1] ,&
																		dw_org.object.status[1]  ,&
																		dw_org.object.org_type[1]  ,&
																		dw_org.object.street_1[1]  ,&
																		dw_org.object.street_2[1]  ,&
																		dw_org.object.street_3[1]  ,& 
																		dw_org.object.city[1]      ,&
																		dw_org.object.state[1]     ,&
																		dw_org.object.zip[1] 		)					

	ll_org_id = dw_org.object.org_id[1] //Add by Jack 05/22/2007
//Added By Mark Lee 04/26/12
Else
	MessageBox(iw_parent.title,"Failed to save the data.~r~nPlease close this window and try again.",StopSign!, OK! )
	Return
end if					 

setpointer(arrow!)
														 								 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.22.2007 By: Jack
//$<reason> Fxi a defect.
/*
close(iw_parent)
*/
closewithreturn(iw_parent,ll_org_id)
//---------------------------- APPEON END ----------------------------

end event

type cb_3 from u_cb within u_tabpg_org_details
integer x = 3223
integer y = 284
integer taborder = 41
boolean bringtotop = true
string text = "&Close"
end type

event clicked;call super::clicked;

close(iw_parent)
end event

