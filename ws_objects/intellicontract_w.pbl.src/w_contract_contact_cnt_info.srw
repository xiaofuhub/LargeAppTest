$PBExportHeader$w_contract_contact_cnt_info.srw
forward
global type w_contract_contact_cnt_info from w_response
end type
type cb_6 from u_cb within w_contract_contact_cnt_info
end type
type cb_5 from u_cb within w_contract_contact_cnt_info
end type
type cb_4 from u_cb within w_contract_contact_cnt_info
end type
type cb_3 from u_cb within w_contract_contact_cnt_info
end type
type cb_2 from u_cb within w_contract_contact_cnt_info
end type
type cb_1 from u_cb within w_contract_contact_cnt_info
end type
type dw_contact_info from u_dw_contract within w_contract_contact_cnt_info
end type
type dw_contact from u_dw_contract within w_contract_contact_cnt_info
end type
type gb_1 from u_gb within w_contract_contact_cnt_info
end type
end forward

global type w_contract_contact_cnt_info from w_response
integer width = 2341
integer height = 1836
string title = "Contact"
long backcolor = 33551856
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_contact_info dw_contact_info
dw_contact dw_contact
gb_1 gb_1
end type
global w_contract_contact_cnt_info w_contract_contact_cnt_info

type variables


long il_group_id 

str_pass istr_pass

end variables

on w_contract_contact_cnt_info.create
int iCurrent
call super::create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_contact_info=create dw_contact_info
this.dw_contact=create dw_contact
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_6
this.Control[iCurrent+2]=this.cb_5
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_contact_info
this.Control[iCurrent+8]=this.dw_contact
this.Control[iCurrent+9]=this.gb_1
end on

on w_contract_contact_cnt_info.destroy
call super::destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_contact_info)
destroy(this.dw_contact)
destroy(this.gb_1)
end on

event pfc_postopen;call super::pfc_postopen;
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
**  Created By	: Michael B. Skinner 03 Aug 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


istr_pass = message.powerobjectparm

il_group_id = istr_pass.s_long[1]


dw_contact.event pfc_retrieve( )
end event

event pfc_endtran;call super::pfc_endtran;

if ai_update_results = failure then 
	messagebox('','ffailure')
end if 

return success
end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: Liang QingShi
//$<reason> Fix a defect.
//$<Modify> 04.30.2007 By: Frank.Gui
//$<reason> Move this from the OK click event to here.

if dw_contact.rowcount() > 0 then
	istr_pass.s_u_dw.setitem(istr_pass.s_u_dw.getrow(),'selected',1)
else
	istr_pass.s_u_dw.setitem(istr_pass.s_u_dw.getrow(),'selected',0)
end if
//---------------------------- APPEON END ----------------------------
return CONTINUE_ACTION
end event

type cb_6 from u_cb within w_contract_contact_cnt_info
integer x = 393
integer y = 1560
integer taborder = 50
string text = "Delete"
end type

event clicked;call super::clicked;dw_contact_info.event pfc_deleterow( )

end event

type cb_5 from u_cb within w_contract_contact_cnt_info
integer x = 1563
integer y = 1608
integer taborder = 40
string text = "&Save"
boolean default = true
end type

event clicked;call super::clicked;parent.event pfc_save()


end event

type cb_4 from u_cb within w_contract_contact_cnt_info
integer x = 14
integer y = 1560
integer taborder = 40
string text = "Add"
end type

event clicked;call super::clicked;if dw_contact.getrow() < 1 then return
dw_contact_info.event pfc_addrow( )


end event

type cb_3 from u_cb within w_contract_contact_cnt_info
integer x = 1952
integer y = 1608
integer taborder = 30
string text = "&Close"
boolean cancel = true
end type

event clicked;call super::clicked;

parent.event pfc_close( )
end event

type cb_2 from u_cb within w_contract_contact_cnt_info
integer x = 393
integer y = 616
integer width = 370
integer taborder = 30
string text = "Delete Contact"
end type

event clicked;call super::clicked;
//dw_contact_info.is_updatesallowed = 'IU'

///dw_contact_info.of_setu

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
dw_contact.event pfc_deleterow( )
*/
//long ll_contact_id
if dw_contact.getrow() <=0 then return
//ll_contact_id = dw_contact.getitemnumber(dw_contact.getrow(),'contact_id')

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Frank.Gui
//$<reason> 
IF MessageBox("Confirm Delete","Are you sure you want to delete current contact and all its details?",question!,yesno!)<> 1 THEN RETURN
//---------------------------- APPEON END ----------------------------

dw_contact.event pfc_deleterow( )

//DELETE FROM ctx_contacts_numbers  
//   WHERE ctx_contacts_numbers.contact_id = :ll_contact_id ;  
//commit;
//---------------------------- APPEON END ----------------------------

//dw_contact_info.is_updatesallowed = 'IUD'
end event

type cb_1 from u_cb within w_contract_contact_cnt_info
integer x = 14
integer y = 616
integer taborder = 20
string text = "Add Contact"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-11 By: Scofield
//$<Reason> Save the added contact to retrieve details.

str_pass lstr_pass
long		ll_RowCnt1,ll_RowCnt2

cb_5.TriggerEvent('Clicked')
ll_RowCnt1 = dw_contact.RowCount()

lstr_pass.s_u_dw = dw_contact
lstr_pass.s_string = 'LOCATIONS'
OpenWithParm ( w_contract_contact, lstr_pass)

ll_RowCnt2 = dw_contact.RowCount()
if ll_RowCnt2 > ll_RowCnt1 then
	cb_5.TriggerEvent('Clicked')
	dw_contact.Trigger Event RowFocusChanged(ll_RowCnt2)
end if

return success
//---------------------------- APPEON END ----------------------------

end event

type dw_contact_info from u_dw_contract within w_contract_contact_cnt_info
string tag = "Contact Methods"
integer y = 728
integer width = 2318
integer height = 820
integer taborder = 20
boolean titlebar = true
string title = "Contact Methods"
string dataobject = "d_contract_location_phone"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
boolean ib_retrieve_drop_downs = true
end type

event constructor;call super::constructor;

this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.16.2006 By: Liang QingShi
//$<reason> Contract module modification.
//$<reason> Fix a defect.
If dw_contact_info.rowcount() <= 0 Then
	ib_retrieve_drop_downs = false
	event ue_populatedddws( )
End If
//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-11 By: Scofield
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

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-11 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm,ls_Via

ls_Via = dw_contact_info.Describe("evaluate('LookUpDisplay(via)'," + String(row) + ")")

if ls_Via <> 'PHONE' and ls_Via <> 'FAX' and ls_Via <> 'CELL' and ls_Via <> 'PAGER' then return

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

type dw_contact from u_dw_contract within w_contract_contact_cnt_info
string tag = "Contacts"
integer width = 2318
integer height = 600
integer taborder = 10
boolean titlebar = true
string title = "Contacts"
string dataobject = "d_cntx_location_contact"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: override ancestor	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  01 July 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
dw_contact.of_SetLinkage(true) // master datawindow
dw_contact_info.of_SetLinkage(true)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_contact_info.inv_linkage.of_SetMaster(dw_contact)
dw_contact_info.inv_linkage.of_Register("contact_id", "contact_id") 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01 
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_contact_info.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 04.30.2007 By: Frank.Gui
//$<reason> This will made the Add action incorrectly
//dw_contact.inv_linkage.of_SetStyle(dw_contact_info.inv_linkage.retrieve) 
//---------------------------- APPEON END ----------------------------

dw_contact_info.inv_linkage.of_SetStyle(dw_contact_info.inv_linkage.retrieve) 

//---------------------------- APPEON END ----------------------------


// update
dw_contact_info.inv_linkage.of_SetUpdateOnRowChange(FALSE)
dw_contact.inv_linkage.of_SetUpdateOnRowChange(TRUE)

// confirm
dw_contact.inv_linkage.of_SetConfirmOnRowChange(FALSE)
dw_contact_info.inv_linkage.of_SetConfirmOnRowChange(FALSE)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete delete style
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//dw_contact.inv_linkage.of_SetDeleteStyle(dw_contact.inv_linkage.DELETE_ROWS)
//dw_contact_info.inv_linkage.of_SetDeleteStyle(dw_contact.inv_linkage. )

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete properties for the datawindows
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_contact.inv_linkage.of_SetConfirmOnDelete ( true )
dw_contact_info.inv_linkage.of_SetConfirmOnDelete ( true )

dw_contact.inv_linkage.of_SetTransObject(SQLCA)




this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )


end event

event pfc_retrieve;call super::pfc_retrieve;

this.retrieve( il_group_id )

return success
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
**  Created By	: Michael B. Skinner 03 Aug 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long ll_i
for ll_i = 1 to rowcount( )
	this.object.loc_id[ll_i] =  il_group_id
	//mskinner 13 april 2006 -- begin
   this.object.ctx_id[ll_i] =  istr_pass.s_long[2]
	this.object.parent_comp_id[ll_i] =  istr_pass.s_long[3]
	//mskinner 13 april 2006 -- end

next


return success
end event

type gb_1 from u_gb within w_contract_contact_cnt_info
integer x = 2441
integer y = 1280
integer width = 347
integer height = 252
integer taborder = 11
end type

