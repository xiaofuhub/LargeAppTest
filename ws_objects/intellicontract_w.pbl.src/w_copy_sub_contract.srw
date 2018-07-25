$PBExportHeader$w_copy_sub_contract.srw
$PBExportComments$Create by Jack 05/30/2007
forward
global type w_copy_sub_contract from w_response
end type
type cbx_18 from checkbox within w_copy_sub_contract
end type
type cb_default from commandbutton within w_copy_sub_contract
end type
type cbx_15 from checkbox within w_copy_sub_contract
end type
type cbx_16 from checkbox within w_copy_sub_contract
end type
type cbx_17 from checkbox within w_copy_sub_contract
end type
type cb_2 from commandbutton within w_copy_sub_contract
end type
type cb_cancel from commandbutton within w_copy_sub_contract
end type
type cb_ok from commandbutton within w_copy_sub_contract
end type
type cbx_13 from checkbox within w_copy_sub_contract
end type
type cbx_12 from checkbox within w_copy_sub_contract
end type
type cbx_11 from checkbox within w_copy_sub_contract
end type
type cbx_10 from checkbox within w_copy_sub_contract
end type
type cbx_9 from checkbox within w_copy_sub_contract
end type
type cbx_8 from checkbox within w_copy_sub_contract
end type
type cbx_7 from checkbox within w_copy_sub_contract
end type
type cbx_6 from checkbox within w_copy_sub_contract
end type
type cbx_5 from checkbox within w_copy_sub_contract
end type
type cbx_4 from checkbox within w_copy_sub_contract
end type
type cbx_3 from checkbox within w_copy_sub_contract
end type
type cbx_2 from checkbox within w_copy_sub_contract
end type
type cbx_1 from checkbox within w_copy_sub_contract
end type
type st_1 from statictext within w_copy_sub_contract
end type
type gb_1 from groupbox within w_copy_sub_contract
end type
type cbx_14 from checkbox within w_copy_sub_contract
end type
type gb_2 from groupbox within w_copy_sub_contract
end type
end forward

global type w_copy_sub_contract from w_response
integer width = 2222
integer height = 1324
string title = "Copy & Create Sub Contract "
long backcolor = 33551856
cbx_18 cbx_18
cb_default cb_default
cbx_15 cbx_15
cbx_16 cbx_16
cbx_17 cbx_17
cb_2 cb_2
cb_cancel cb_cancel
cb_ok cb_ok
cbx_13 cbx_13
cbx_12 cbx_12
cbx_11 cbx_11
cbx_10 cbx_10
cbx_9 cbx_9
cbx_8 cbx_8
cbx_7 cbx_7
cbx_6 cbx_6
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
st_1 st_1
gb_1 gb_1
cbx_14 cbx_14
gb_2 gb_2
end type
global w_copy_sub_contract w_copy_sub_contract

type variables
long il_ctx_id
str_copy_sub_contract		istr_copy_sub_contract				//Added By Mark Lee 11/16/2012
end variables

forward prototypes
public subroutine of_copy_document_manager (long al_ctx_id_source, long al_ctx_id_destin)
public subroutine of_load_default ()
end prototypes

public subroutine of_copy_document_manager (long al_ctx_id_source, long al_ctx_id_destin);//====================================================================
// Function: of_Copy_Document_Manager()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_ctx_id_source
// 	value    long    al_ctx_id_destin
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-06-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle_01,ll_RowCnt_01,ll_Cycle_02,ll_RowCnt_02,ll_Cycle_03,ll_RowCnt_03
long		ll_doc_id_old,ll_doc_id_new,ll_doc_status,ll_Rtn
String	ls_RevControl

Decimal	ld_Revision

DataStore	lds_ctx_am_document_Source
DataStore	lds_ctx_am_doc_image_Source
DataStore	lds_ctx_am_document_clause_Source

DataStore	lds_ctx_am_document_Destin
DataStore	lds_ctx_am_doc_image_Destin
DataStore	lds_ctx_am_document_clause_Destin

/*
DataStore	lds_ctx_am_action_item_Source
DataStore	lds_ctx_am_doc_audit_Source
DataStore	lds_ctx_am_ai_notification_Source
DataStore	lds_ctx_am_ai_notification_users_Source
DataStore	lds_ctx_am_ai_alarm_attachment_Source
DataStore	lds_ctx_am_image_weblink_Source

DataStore	lds_ctx_am_action_item_Destin
DataStore	lds_ctx_am_doc_audit_Destin
DataStore	lds_ctx_am_ai_notification_Destin
DataStore	lds_ctx_am_ai_notification_users_Destin
DataStore	lds_ctx_am_ai_alarm_attachment_Destin
DataStore	lds_ctx_am_image_weblink_Destin

d_ctx_am_document_copy
d_ctx_am_doc_image_copy
d_ctx_am_action_item_copy
d_ctx_am_doc_audit_copy
d_ctx_am_document_clause_copy
d_ctx_am_ai_notification_copy
d_ctx_am_ai_notification_users_copy
d_ctx_am_ai_alarm_attachment_copy
d_ctx_am_image_weblink_copy
*/

///////////////////////////////////////////////////////////////////////////////
lds_ctx_am_document_Source = Create DataStore
lds_ctx_am_document_Source.DataObject = "d_ctx_am_document_copy"
lds_ctx_am_document_Source.SetTransObject(SQLCA)

lds_ctx_am_document_Destin = Create DataStore
lds_ctx_am_document_Destin.DataObject = "d_ctx_am_document_copy"
lds_ctx_am_document_Destin.SetTransObject(SQLCA)
///////////////////////////////////////////////////////////////////////////////
lds_ctx_am_doc_image_Source = Create DataStore
lds_ctx_am_doc_image_Source.DataObject = "d_ctx_am_doc_image_copy"
lds_ctx_am_doc_image_Source.SetTransObject(SQLCA)

lds_ctx_am_doc_image_Destin = Create DataStore
lds_ctx_am_doc_image_Destin.DataObject = "d_ctx_am_doc_image_copy"
lds_ctx_am_doc_image_Destin.SetTransObject(SQLCA)
///////////////////////////////////////////////////////////////////////////////
lds_ctx_am_document_clause_Source = Create DataStore
lds_ctx_am_document_clause_Source.DataObject = "d_ctx_am_document_clause_copy"
lds_ctx_am_document_clause_Source.SetTransObject(SQLCA)

lds_ctx_am_document_clause_Destin = Create DataStore
lds_ctx_am_document_clause_Destin.DataObject = "d_ctx_am_document_clause_copy"
lds_ctx_am_document_clause_Destin.SetTransObject(SQLCA)
///////////////////////////////////////////////////////////////////////////////

ll_doc_status = long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Document Status') and upper(code) = upper('New')"))

lds_ctx_am_document_Source.Retrieve(al_ctx_id_source)
lds_ctx_am_document_Destin.Reset()
ll_RowCnt_01 = lds_ctx_am_document_Source.RowCount()

for ll_Cycle_01 = 1 to ll_RowCnt_01
	lds_ctx_am_document_Source.RowsCopy(ll_Cycle_01,ll_Cycle_01,Primary!,lds_ctx_am_document_Destin,ll_Cycle_01,Primary!)
	
	ll_doc_id_new = gnv_app.of_get_id("doc_id")
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"doc_id",ll_doc_id_new)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"ctx_id",al_ctx_id_destin)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"create_by",gs_user_id)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"create_date",Today())
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"status",ll_doc_status)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"status_by",gs_user_id)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"status_date",Today())
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"checkout_status","0")
	lds_ctx_am_document_Destin.SetItemStatus(ll_Cycle_01,0,Primary!,NewModified!)
	
	ll_Rtn = lds_ctx_am_document_Destin.Update()
	if ll_Rtn = 1 then
		COMMIT USING SQLCA;
	else
		ROLLBACK USING SQLCA;
		CONTINUE
	end if
	
	ll_doc_id_old = lds_ctx_am_document_Source.GetItemNumber(ll_Cycle_01,"doc_id")
	lds_ctx_am_doc_image_Source.Retrieve(ll_doc_id_old)
	lds_ctx_am_doc_image_Destin.Reset()
	
	if lds_ctx_am_doc_image_Source.RowCount() <= 0 then CONTINUE
	ll_RowCnt_02 = 1		//Only copy the original revision
	for ll_Cycle_02 = 1 to ll_RowCnt_02
		ld_Revision = lds_ctx_am_doc_image_Source.GetItemDecimal(ll_Cycle_02,"Revision")
		
		if ld_Revision = 0.0 then
			ls_RevControl = "0"
		else
			ls_RevControl = "1"
		end if
		
		lds_ctx_am_doc_image_Source.RowsCopy(ll_Cycle_02,ll_Cycle_02,Primary!,lds_ctx_am_doc_image_Destin,ll_Cycle_02,Primary!)
		
		lds_ctx_am_doc_image_Destin.SetItem(ll_Cycle_02,"doc_id",ll_doc_id_new)
		lds_ctx_am_doc_image_Destin.SetItem(ll_Cycle_02,"modify_date",Today())
		lds_ctx_am_doc_image_Destin.SetItemStatus(ll_Cycle_02,0,Primary!,NewModified!)
		
		ll_Rtn = lds_ctx_am_doc_image_Destin.Update()
		if ll_Rtn = 1 then
			COMMIT USING SQLCA;
		else
			ROLLBACK USING SQLCA;
			CONTINUE
		end if
		
		UPDATE ctx_am_doc_image
			SET image_file = (SELECT image_file FROM ctx_am_doc_image WHERE doc_id = :ll_doc_id_old AND revision = :ld_Revision)
		 WHERE doc_id = :ll_doc_id_new AND revision = :ld_Revision;
		 
		UPDATE ctx_am_document
		   SET Revision = :ld_Revision,
				 Revision_control = :ls_RevControl,
				 checkout_by = null,
				 checkout_date = null
		 WHERE doc_id = :ll_doc_id_new;
		 
		COMMIT USING SQLCA;
		
		lds_ctx_am_document_clause_Source.Retrieve(ll_doc_id_old,ld_Revision)
		lds_ctx_am_document_clause_Destin.Reset()
		
		ll_RowCnt_03 = lds_ctx_am_document_clause_Source.RowCount()
		lds_ctx_am_document_clause_Source.RowsCopy(1,ll_RowCnt_03,Primary!,lds_ctx_am_document_clause_Destin,1,Primary!)
		for ll_Cycle_03 = 1 to ll_RowCnt_03
			lds_ctx_am_document_clause_Destin.SetItem(ll_Cycle_03,"doc_id",ll_doc_id_new)
			lds_ctx_am_document_clause_Destin.SetItemStatus(ll_Cycle_03,0,Primary!,NewModified!)
		next
		ll_Rtn = lds_ctx_am_document_clause_Destin.Update()
		if ll_Rtn = 1 then
			COMMIT USING SQLCA;
		else
			ROLLBACK USING SQLCA;
			CONTINUE
		end if
	next
next

end subroutine

public subroutine of_load_default ();//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
String ls_default_copy_contract
String ls_value[]
n_cst_string lnv_string
Long i,j
CheckBox luo_checkbox
PowerObject luo_PowerObject

Select default_copy_contract into :ls_default_copy_contract from icred_settings;

If ls_default_copy_contract = '' or isnull(ls_default_copy_contract) Then 
	Return
End If

lnv_string.of_parsetoarray( ls_default_copy_contract, ',', ls_value[])

For i = 1 To UpperBound(ls_value[])
	If ls_value[i] <> '1' Then 
		Continue
	End If
	For j = 1 to UpperBound(This.Control[])
		luo_PowerObject = This.Control[j]
		If luo_PowerObject.classname( ) = 'cbx_' + String(i) Then
			If luo_PowerObject.TypeOf() = CheckBox! Then
				luo_checkbox = luo_PowerObject
				If ls_value[i] = '1' Then
					luo_checkbox.Checked = True
					Exit
				End If
			End If
		End If
	Next
Next



end subroutine

on w_copy_sub_contract.create
int iCurrent
call super::create
this.cbx_18=create cbx_18
this.cb_default=create cb_default
this.cbx_15=create cbx_15
this.cbx_16=create cbx_16
this.cbx_17=create cbx_17
this.cb_2=create cb_2
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_13=create cbx_13
this.cbx_12=create cbx_12
this.cbx_11=create cbx_11
this.cbx_10=create cbx_10
this.cbx_9=create cbx_9
this.cbx_8=create cbx_8
this.cbx_7=create cbx_7
this.cbx_6=create cbx_6
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.gb_1=create gb_1
this.cbx_14=create cbx_14
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_18
this.Control[iCurrent+2]=this.cb_default
this.Control[iCurrent+3]=this.cbx_15
this.Control[iCurrent+4]=this.cbx_16
this.Control[iCurrent+5]=this.cbx_17
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_cancel
this.Control[iCurrent+8]=this.cb_ok
this.Control[iCurrent+9]=this.cbx_13
this.Control[iCurrent+10]=this.cbx_12
this.Control[iCurrent+11]=this.cbx_11
this.Control[iCurrent+12]=this.cbx_10
this.Control[iCurrent+13]=this.cbx_9
this.Control[iCurrent+14]=this.cbx_8
this.Control[iCurrent+15]=this.cbx_7
this.Control[iCurrent+16]=this.cbx_6
this.Control[iCurrent+17]=this.cbx_5
this.Control[iCurrent+18]=this.cbx_4
this.Control[iCurrent+19]=this.cbx_3
this.Control[iCurrent+20]=this.cbx_2
this.Control[iCurrent+21]=this.cbx_1
this.Control[iCurrent+22]=this.st_1
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.cbx_14
this.Control[iCurrent+25]=this.gb_2
end on

on w_copy_sub_contract.destroy
call super::destroy
destroy(this.cbx_18)
destroy(this.cb_default)
destroy(this.cbx_15)
destroy(this.cbx_16)
destroy(this.cbx_17)
destroy(this.cb_2)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_13)
destroy(this.cbx_12)
destroy(this.cbx_11)
destroy(this.cbx_10)
destroy(this.cbx_9)
destroy(this.cbx_8)
destroy(this.cbx_7)
destroy(this.cbx_6)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.cbx_14)
destroy(this.gb_2)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>openw_copy_contract()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2007 by Jack
//////////////////////////////////////////////////////////////////////

//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
//Warning: Please do NOT modify the checkbox's name. n_cst_workflow_triggers.of_parse_default_copy_ctx() function used it.) 
//Warning: Please do NOT modify the checkbox's name. of_load_default() function used it.) 
//Warning: Please do NOT modify the checkbox's name. cb_default::click() event used it.) 

long ll_parm
//il_ctx_id = message.doubleparm
istr_copy_sub_contract = message.powerobjectparm
il_ctx_id 		= istr_copy_sub_contract.al_ctx_id

//---------Begin Added by (Appeon)Harry 05.24.2014 for V142 ISG-CLX--------
if gb_contract_version then
	cbx_18.visible = False
	gb_1.Height = gb_1.Height - 60
else
	cbx_18.visible = True
end if
//---------End Added ------------------------------------------------------

//Begin - Added By Mark Lee 11/19/2012
If not isnull( istr_copy_sub_contract.as_type) and istr_copy_sub_contract.as_type = 'Copy_&_Create_Sub_Contract_Record' Then 
	st_1.text = "Please select the data you want to include for copying and creating the sub contract for contract ( " + string(il_ctx_id) + " )."
	cbx_1.enabled = True
	cbx_1.checked = True
Else
	st_1.text = "Please select the data you want included when copying the ( " + string(il_ctx_id) + " ) contract?"
End if
//End - Added By Mark Lee 11/19/2012

//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
of_load_default()

//Modified By Ken.Guo 2009-08-25
//Details Tab
IF w_mdi.of_security_access(2091) < 1 Then cbx_3.enabled = False //Custom data
IF w_mdi.of_security_access(2092) < 1 Then cbx_4.enabled = False //Notes
IF w_mdi.of_security_access(6951) < 1 Then cbx_17.enabled = False //Group Access

//Main Tab
IF w_mdi.of_security_access(2100) < 1 THEN cbx_8.enabled = False  //Requirements
IF w_mdi.of_security_access(2110) < 1 THEN cbx_9.enabled = False  //Contacts
IF w_mdi.of_security_access(2120) < 1 THEN cbx_10.enabled = False  //Locations
IF w_mdi.of_security_access(2130) < 1 THEN cbx_11.enabled = False	//Organizations
IF w_mdi.of_security_access(2150) < 1 THEN cbx_14.enabled = False //Document Manager
IF w_mdi.of_security_access(2160) < 1 THEN cbx_13.enabled = False	//Action Items
IF (w_mdi.of_security_access(2220) < 1) and (w_mdi.of_security_access(2140) < 1) THEN cbx_12.enabled = False	//Fee Schedules & Fees Non-Medical	 	 


//Add custom data2 and multi -- jervis 06.09.2011
IF w_mdi.of_security_access(2093) < 1 THEN cbx_15.enabled = False	//custom data2
IF w_mdi.of_security_access(2170) < 1 THEN cbx_16.enabled = False	//custom multi data
IF w_mdi.of_security_access(7751) < 1 THEN cbx_18.enabled = False	//(Appeon)Harry 05.24.2014 - V142 ISG-CLX

//Begin - Added By Mark Lee 05/11/12 add trim() function 
//View Access - Add by jervis 11.04.2009
if isvalid(gw_contract) then
	cbx_1.text = trim(gw_contract.tab_contract_details.tabpage_details.text)
	if gw_contract.tab_contract_details.tabpage_action_items.visible = false then 
		cbx_13.enabled = false
	else
		cbx_13.text =trim(gw_contract.tab_contract_details.tabpage_action_items.text)
	end if
	//if gw_contract.tab_contract_details.tabpage_analysis
	if gw_contract.tab_contract_details.tabpage_contacts.visible = false then 
		cbx_9.enabled = False  //Contacts
	else
		cbx_9.text = trim(gw_contract.tab_contract_details.tabpage_contacts.text)
	end if
	if (gw_contract.tab_contract_details.tabpage_fee_sched2.visible = false and gw_contract.tab_contract_details.tabpage_fee_schedules.visible = false) then 
		cbx_12.enabled = False
	elseif gw_contract.tab_contract_details.tabpage_fee_schedules.visible then
		cbx_12.text = trim(gw_contract.tab_contract_details.tabpage_fee_schedules.text)
	else
		cbx_12.text = trim(gw_contract.tab_contract_details.tabpage_fee_sched2.text)
	end if
	if gw_contract.tab_contract_details.tabpage_images.visible = false then 
		cbx_14.enabled = False //Document Manager
	else
		cbx_14.text = trim(gw_contract.tab_contract_details.tabpage_images.text)
	end if
	if gw_contract.tab_contract_details.tabpage_locations.visible = false then 
		cbx_10.enabled = False  //Locations
	else
		cbx_10.text = trim(gw_contract.tab_contract_details.tabpage_locations.text)
	end if
	if gw_contract.tab_contract_details.tabpage_orgabizations.visible = false then 
		cbx_11.enabled = False	//Organizations
	else
		cbx_11.text = trim(gw_contract.tab_contract_details.tabpage_orgabizations.text)
	end if
	if gw_contract.tab_contract_details.tabpage_requirements.visible = false then 
		cbx_8.enabled = False  //Requirements
	else
		cbx_8.text =trim(gw_contract.tab_contract_details.tabpage_requirements.text)
	end if
	
	
	//add custom data2 and multi -- jervis 06.09.2011
	if gw_contract.tab_contract_details.tabpage_multi.visible = false then
		cbx_16.enabled = False  //custom multi
	else
		cbx_16.text = trim(gw_contract.tab_contract_details.tabpage_multi.text)
	end if
	
	if gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.visible = false then
		cbx_15.enabled = False  //custom data 2
	else
		cbx_15.text = trim(gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.text)
	end if
	
	//End - Added By Mark Lee 05/11/12	
	
end if

end event

type cbx_18 from checkbox within w_copy_sub_contract
integer x = 46
integer y = 556
integer width = 517
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Linked Providers"
end type

type cb_default from commandbutton within w_copy_sub_contract
integer x = 384
integer y = 1108
integer width = 384
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set &As Default"
end type

event clicked;//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
String ls_value[],ls_default_copy_contract
n_cst_string lnv_string
Long i,j,ll_pos, ll_index
CheckBox luo_checkbox
PowerObject luo_PowerObject

For j = 1 to UpperBound(Parent.Control[])
	luo_PowerObject = Parent.Control[j]
	ll_pos = Pos( luo_PowerObject.classname( ) , 'cbx_' )
	If ll_pos > 0  and luo_PowerObject.typeof() = CheckBox! Then
		If isnumber( Mid( luo_PowerObject.classname( ), 5 )  ) Then
			ll_index = Long( Mid( luo_PowerObject.classname( ), 5 ))
			luo_checkbox = luo_PowerObject
			If luo_checkbox.checked Then
				ls_value[ll_index] = '1'
			Else
				ls_value[ll_index] = '0'
			End If
		End if
	End If
Next

For i = 1 To Upperbound(ls_value[])
	If ls_value[i] = '' Then
		ls_value[i] = '0'
	End If
Next

lnv_string.of_arraytostring(ls_value[], ',',ls_default_copy_contract )

Update icred_settings set default_copy_contract = :ls_default_copy_contract ;

If SQLCA.sqlcode = 0 Then
	Messagebox('Copy Contract','Default settings was set successfully.')
Else
	Messagebox('Error','Failed to set default settings.' + sqlca.sqlerrtext )
End If



end event

type cbx_15 from checkbox within w_copy_sub_contract
integer x = 46
integer y = 364
integer width = 603
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom Data 2"
end type

type cbx_16 from checkbox within w_copy_sub_contract
integer x = 681
integer y = 928
integer width = 603
integer height = 64
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom Multi Data"
end type

type cbx_17 from checkbox within w_copy_sub_contract
integer x = 46
integer y = 460
integer width = 603
integer height = 64
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Group Access"
end type

type cb_2 from commandbutton within w_copy_sub_contract
integer x = 14
integer y = 1108
integer width = 352
integer height = 92
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_2()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2007 by Jack
//////////////////////////////////////////////////////////////////////
If this.text = '&Select All' Then
	If cbx_1.enabled = True Then cbx_1.checked = True
	If cbx_2.enabled = True Then cbx_2.checked = True
	If cbx_3.enabled = True Then cbx_3.checked = True
	If cbx_4.enabled = True Then cbx_4.checked = True
	If cbx_5.enabled = True Then cbx_5.checked = True
	If cbx_6.enabled = True Then cbx_6.checked = True
	If cbx_7.enabled = True Then cbx_7.checked = True
	If cbx_17.enabled = True Then cbx_17.checked = True
	
	If cbx_8.enabled = True Then cbx_8.checked = True
	If cbx_9.enabled = True Then cbx_9.checked = True
	If cbx_10.enabled = True Then cbx_10.checked = True
	If cbx_11.enabled = True Then cbx_11.checked = True
	If cbx_12.enabled = True Then cbx_12.checked = True
	If cbx_13.enabled = True Then cbx_13.checked = True
	If cbx_14.enabled = True Then cbx_14.checked = True
	If cbx_15.enabled = True Then cbx_15.checked = True //add ctx_15,16 - jervis 06.09.2011
	If cbx_16.enabled = True Then cbx_16.checked = True
	if cbx_18.enabled = True then cbx_18.checked = True//Added by Appeon long.zhang 05.24.2014 (v14.2 Provider-Contract direct linking)
	this.text = '&Deselect All'
Else
	//Added By Mark Lee 11/19/2012
	If not isnull(istr_copy_sub_contract.as_type) and istr_copy_sub_contract.as_type = 'Copy_&_Create_Sub_Contract_Record' Then 
		//
	Else
		cbx_1.checked = False
	End If
	cbx_2.checked = False
	cbx_3.checked = False
	cbx_4.checked = False
	cbx_5.checked = False
	cbx_6.checked = False
	cbx_7.checked = False
	cbx_8.checked = False
	cbx_9.checked = False
	cbx_10.checked = False
	cbx_11.checked = False
	cbx_12.checked = False
	cbx_13.checked = False
	cbx_14.checked = False
	cbx_15.checked = False
	cbx_16.checked = False
	cbx_17.checked = False
	cbx_18.checked = False //Added by Appeon long.zhang 05.24.2014 (v14.2 Provider-Contract direct linking)
	this.text = '&Select All'
End If	

end event

type cb_cancel from commandbutton within w_copy_sub_contract
integer x = 1838
integer y = 1108
integer width = 343
integer height = 92
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_cancel()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2007 by Jack
//////////////////////////////////////////////////////////////////////
closewithreturn(parent,0)

end event

type cb_ok from commandbutton within w_copy_sub_contract
integer x = 1486
integer y = 1108
integer width = 343
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_ok()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
//Added By Ken.Guo 2009-08-24.
//////////////////////////////////////////////////////////////////////


Long ll_ctx_id
str_copy_ctx lstr_copy_ctx
n_cst_copy_ctx lnv_copy_ctx
long ll_category

//Added 'and cbx_1.enabled ' By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
lnv_copy_ctx = Create n_cst_copy_ctx
lstr_copy_ctx.sl_ctx_id = il_ctx_id
If cbx_1.checked and cbx_1.enabled Then
	lstr_copy_ctx.sb_contract_detail = 1
Else
	lstr_copy_ctx.sb_contract_detail = 0
End If

If cbx_2.checked and cbx_2.enabled  Then
	lstr_copy_ctx.sb_contract_dates = 1
Else
	lstr_copy_ctx.sb_contract_dates = 0
End If

If cbx_3.checked and cbx_3.enabled  Then
	lstr_copy_ctx.sb_custom_data = 1
Else
	lstr_copy_ctx.sb_custom_data = 0
End If
If cbx_4.checked and cbx_4.enabled  Then
	lstr_copy_ctx.sb_notes = 1
Else
	lstr_copy_ctx.sb_notes = 0
End If
If  cbx_17.checked  and cbx_17.enabled Then
	lstr_copy_ctx.sb_group_access = 1
Else
	lstr_copy_ctx.sb_group_access = 0
End If

If cbx_5.checked and cbx_5.enabled  Then
	lstr_copy_ctx.sb_contracted_contacts = 1
Else
	lstr_copy_ctx.sb_contracted_contacts = 0
End If
If cbx_6.checked  and cbx_6.enabled Then
	lstr_copy_ctx.sb_our_contacts = 1
Else
	lstr_copy_ctx.sb_our_contacts = 0
End IF
If cbx_7.checked  and cbx_7.enabled Then
	lstr_copy_ctx.sb_products = 1
Else
	lstr_copy_ctx.sb_products = 0
End If
If cbx_8.checked  and cbx_8.enabled  Then
	lstr_copy_ctx.sb_requirements = 1
Else
	lstr_copy_ctx.sb_requirements = 0
End If
If cbx_9.checked and cbx_9.enabled  Then
	lstr_copy_ctx.sb_other_contacts = 1
Else
	lstr_copy_ctx.sb_other_contacts = 0
End If
IF cbx_10.checked  and cbx_10.enabled Then
	lstr_copy_ctx.sb_locations = 1
Else
	lstr_copy_ctx.sb_locations = 0
End If
If cbx_11.checked  and cbx_11.enabled Then
	lstr_copy_ctx.sb_organizations = 1
Else
	lstr_copy_ctx.sb_organizations = 0
End If
IF cbx_12.checked  and cbx_12.enabled Then
	lstr_copy_ctx.sb_fee_schedule = 1
Else
	lstr_copy_ctx.sb_fee_schedule = 0
End If
If cbx_13.checked  and cbx_13.enabled Then
	lstr_copy_ctx.sb_action_items = 1
Else
	lstr_copy_ctx.sb_action_items = 0
End IF
IF cbx_14.checked  and cbx_14.enabled Then
	lstr_copy_ctx.sb_document_manager = 1
Else
	lstr_copy_ctx.sb_document_manager = 0
End IF

//add custom data2 and multi -- jervis 06.09.2011
If cbx_15.checked  and cbx_15.enabled Then
	lstr_copy_ctx.sb_custom_data2 = 1
Else
	lstr_copy_ctx.sb_custom_data2 = 0
End IF
IF cbx_16.checked and cbx_16.enabled  Then
	lstr_copy_ctx.sb_custom_multi = 1
Else
	lstr_copy_ctx.sb_custom_multi = 0
End IF
//-------------appeon begin----------------------
//<$>added:long.zhang 05.15.2014
//<$>reason:v14.2 Provider-Contract direct linking
if cbx_18.enabled and cbx_18.checked then
	lstr_copy_ctx.sb_link_privider = 1
else
	lstr_copy_ctx.sb_link_privider = 0
end if
//-------------appeon End------------------------

lstr_copy_ctx.si_is_template = 0
//Trigger work flow for copy contract - jervis 04.20.2010
Select Category into :ll_category from ctx_basic_info where ctx_id = :il_ctx_id;
//get workflow id
lstr_copy_ctx.sl_workflow = long(gnv_data.of_getitem("code_lookup","custom_5","lookup_code =" + string(ll_category)))

//Added By Mark Lee 11/16/2012
If istr_copy_sub_contract.as_type = 'Copy_&_Create_Sub_Contract_Record' and cbx_1.checked and cbx_1.enabled Then 
	lstr_copy_ctx.as_master_contract_name = istr_copy_sub_contract.as_master_contract_name
End If

ll_ctx_id = lnv_copy_ctx.of_copy_ctx_data( lstr_copy_ctx)
If isvalid(lnv_copy_ctx) then destroy lnv_copy_ctx

Closewithreturn(Parent,ll_ctx_id)

/*
long ll_ctx_id,ll_record_id,ll_element_id,ll_parent_comp_id,ll_loc_id,ll_org_id,ll_fee_sched_id,ll_fee_sched_id1
long ll_fee_sched_location_id,ll_fee_sched_location_id1,ll_fee_sched_data_id,ll_loc_id1
long ll_row,i,j,k,ll_cnt
boolean lb_copy

openwithparm( w_appeon_gifofwait, "Copying the selected contract..." )			

datastore lds_detail
datastore lds_ctx_basic_info
datastore lds_company_contacts
datastore lds_ctx_contract_contacts
datastore lds_products
datastore lds_ctx_products
datastore lds_requirements
datastore lds_ctx_req_profile_hdr
datastore lds_profile_detail
datastore lds_ctx_elements
datastore lds_other_contacts
datastore lds_parent_organization
datastore lds_ctx_loc
datastore lds_group_locations
datastore lds_selected_facility
datastore lds_ctx_location_pracs
datastore lds_specialties
datastore lds_ctx_location_specialty
datastore lds_organization_list
datastore lds_ctx_orgs_contact
datastore lds_ctx_org_contact
datastore lds_fee_schedules
datastore lds_ctx_fee_sched_hdr
datastore lds_providers
datastore lds_ctx_fee_sched_pracs
datastore lds_fee_schedule_locations
datastore lds_ctx_fee_sched_locations
datastore lds_fees
datastore lds_ctx_fee_sched_data
datastore lds_fee_schedules2
datastore lds_ctx_fee_sched_nm
datastore lds_action_items
datastore lds_ctx_action_items
datastore lds_ctx_group_access

lds_detail = Create datastore
lds_detail.dataobject = 'd_contract_det_master'
lds_detail.settransobject(sqlca)

lds_ctx_basic_info = Create datastore
lds_ctx_basic_info.dataobject = 'd_ctx_basic_info'
lds_ctx_basic_info.settransobject(sqlca)

lds_company_contacts = Create datastore
lds_company_contacts.dataobject = 'd_contract_det_contact_external'
lds_company_contacts.settransobject(sqlca)

lds_ctx_contract_contacts = Create datastore
lds_ctx_contract_contacts.dataobject = 'd_ctx_contract_contacts'
lds_ctx_contract_contacts.settransobject(sqlca)

lds_products = Create datastore
lds_products.dataobject = 'd_ctx_products'
lds_products.settransobject(sqlca)

lds_ctx_products = Create datastore
lds_ctx_products.dataobject = 'd_ctx_products_copy'
lds_ctx_products.settransobject(sqlca)

lds_requirements = Create datastore
lds_requirements.dataobject = 'd_profile_header'
lds_requirements.settransobject(sqlca)

lds_ctx_req_profile_hdr = Create datastore
lds_ctx_req_profile_hdr.dataobject = 'd_ctx_req_profile_hdr_copy'
lds_ctx_req_profile_hdr.settransobject(sqlca)

lds_profile_detail = Create datastore
lds_profile_detail.dataobject = 'd_contract_profile_req_existing'
lds_profile_detail.settransobject(sqlca)

lds_ctx_elements = Create datastore
lds_ctx_elements.dataobject = 'd_ctx_elements_copy'
lds_ctx_elements.settransobject(sqlca)

lds_other_contacts = Create datastore
lds_other_contacts.dataobject = 'd_contract_det_contact_contact_copy'
lds_other_contacts.settransobject(sqlca)

lds_parent_organization = Create datastore
lds_parent_organization.dataobject = 'd_contract_multi_group_browse'
lds_parent_organization.settransobject(sqlca)

lds_ctx_loc = Create datastore
lds_ctx_loc.dataobject = 'd_ctx_loc_copy'
lds_ctx_loc.settransobject(sqlca)

lds_group_locations = Create datastore
lds_group_locations.dataobject = 'd_contract_group_linked_locations_copy'
lds_group_locations.settransobject(sqlca)

lds_selected_facility = Create datastore
lds_selected_facility.dataobject = 'd_contract_group_practitioners_existing1'
lds_selected_facility.settransobject(sqlca)

lds_ctx_location_pracs = Create datastore
lds_ctx_location_pracs.dataobject = 'd_ctx_location_pracs_copy'
lds_ctx_location_pracs.settransobject(sqlca)

lds_specialties = Create datastore
lds_specialties.dataobject = 'd_cntx_location_spec_copy'
lds_specialties.settransobject(sqlca)

lds_ctx_location_specialty = Create datastore
lds_ctx_location_specialty.dataobject = 'd_ctx_location_specialty_copy'
lds_ctx_location_specialty.settransobject(sqlca)

lds_organization_list = Create datastore
lds_organization_list.dataobject = 'd_org_search2_copy'
lds_organization_list.settransobject(sqlca)

lds_ctx_orgs_contact = Create datastore
lds_ctx_orgs_contact.dataobject = 'd_ctx_orgs_contact_copy'
lds_ctx_orgs_contact.settransobject(sqlca)

lds_ctx_org_contact = Create datastore
lds_ctx_org_contact.dataobject = 'd_ctx_org_contact_copy'
lds_ctx_org_contact.settransobject(sqlca)

lds_fee_schedules = Create datastore
lds_fee_schedules.dataobject = 'd_ctx_free_sched_hdr_copy'
lds_fee_schedules.settransobject(sqlca)

lds_ctx_fee_sched_hdr = Create datastore
lds_ctx_fee_sched_hdr.dataobject = 'd_ctx_fee_sched_hdr_copy'
lds_ctx_fee_sched_hdr.settransobject(sqlca)

lds_providers = Create datastore
lds_providers.dataobject = 'd_ctx_schedule_fee_pracs_copy'
lds_providers.settransobject(sqlca)

lds_ctx_fee_sched_pracs = Create datastore
lds_ctx_fee_sched_pracs.dataobject = 'd_ctx_fee_sched_pracs_copy'
lds_ctx_fee_sched_pracs.settransobject(sqlca)

lds_fee_schedule_locations = Create datastore 
lds_fee_schedule_locations.dataobject = 'd_ctx_schedule_fee_locations_copy'
lds_fee_schedule_locations.settransobject(sqlca)

lds_ctx_fee_sched_locations = Create datastore
lds_ctx_fee_sched_locations.dataobject = 'd_ctx_fee_sched_locations_copy'
lds_ctx_fee_sched_locations.settransobject(sqlca)

lds_fees = Create datastore
lds_fees.dataobject = 'd_ctx_schedule_fee_detail_copy1'
lds_fees.settransobject(sqlca)

lds_ctx_fee_sched_data = Create datastore
lds_ctx_fee_sched_data.dataobject = 'd_ctx_schedule_fee_detail_copy'
lds_ctx_fee_sched_data.settransobject(sqlca)

lds_fee_schedules2 = Create datastore
lds_fee_schedules2.dataobject = 'd_contract_fee_sched_nm'
lds_fee_schedules2.settransobject(sqlca)

lds_ctx_fee_sched_nm = Create datastore
lds_ctx_fee_sched_nm.dataobject = 'd_ctx_fee_sched_nm_copy'
lds_ctx_fee_sched_nm.settransobject(sqlca)

lds_action_items = Create datastore
lds_action_items.dataobject = 'd_cntx_action_items'
lds_action_items.settransobject(sqlca)

lds_ctx_action_items = Create datastore
lds_ctx_action_items.dataobject = 'd_ctx_action_items_copy'
lds_ctx_action_items.settransobject(sqlca)

//Added By Ken.Guo 2009-05-20.
lds_ctx_group_access = Create datastore
lds_ctx_group_access.dataobject = 'd_contract_det_group_access'
lds_ctx_group_access.settransobject(sqlca)

lds_detail.retrieve(il_ctx_id)
If lds_detail.rowcount() < 1 Then Return

ll_row = lds_ctx_basic_info.insertrow(0)
//Strat code change by jervis 04.11.2008
//ll_ctx_id = gnv_app.of_get_id('PRAC_ID')
ll_ctx_id = gnv_app.of_get_id('CTX_ID')
//End code change by jervis 04.11.2008

ll_record_id = gnv_app.of_get_id('RECORD_ID')
lds_ctx_basic_info.setitem(ll_row,'ctx_id',ll_ctx_id)
lds_ctx_basic_info.setitem(ll_row,'record_id',ll_record_id)
//add by Jack 07.06.2007
lds_ctx_basic_info.setitem(ll_row,'master_contract_id',0)
lds_ctx_basic_info.setitem(ll_row,'master_contract_name','')  

lb_copy = False
If cbx_1.checked = True Then
	//Contract Detail
	lds_ctx_basic_info.setitem(ll_row,'status',lds_detail.getitemnumber(1,'status'))
	lds_ctx_basic_info.setitem(ll_row,'category',lds_detail.getitemnumber(1,'category'))
	lds_ctx_basic_info.setitem(ll_row,'app_facility',lds_detail.getitemnumber(1,'app_facility'))
	lds_ctx_basic_info.setitem(ll_row,'contract_type',lds_detail.getitemnumber(1,'contract_type'))
	lds_ctx_basic_info.setitem(ll_row,'dvision',lds_detail.getitemnumber(1,'dvision'))
	lds_ctx_basic_info.setitem(ll_row,'file_location',lds_detail.getitemstring(1,'file_location'))
	lds_ctx_basic_info.setitem(ll_row,'master_contract_id',lds_detail.getitemnumber(1,'master_contract_id'))
	lds_ctx_basic_info.setitem(ll_row,'master_contract_name',lds_detail.getitemstring(1,'master_contract_name'))	
	lb_copy = True
End If
If cbx_2.checked = True Then
	//Contract Dates
	lds_ctx_basic_info.setitem(ll_row,'effective_date',lds_detail.getitemdatetime(1,'effective_date'))
	lds_ctx_basic_info.setitem(ll_row,'review_date',lds_detail.getitemdatetime(1,'review_date'))
	lds_ctx_basic_info.setitem(ll_row,'term_reason',lds_detail.getitemnumber(1,'term_reason'))
	lds_ctx_basic_info.setitem(ll_row,'version_number',lds_detail.getitemstring(1,'version_number'))
	lds_ctx_basic_info.setitem(ll_row,'version_date',lds_detail.getitemdatetime(1,'version_date'))
	lds_ctx_basic_info.setitem(ll_row,'expriation_date',lds_detail.getitemdatetime(1,'expriation_date'))
	lds_ctx_basic_info.setitem(ll_row,'review_by',lds_detail.getitemstring(1,'review_by'))
	lds_ctx_basic_info.setitem(ll_row,'last_revis_date',lds_detail.getitemdatetime(1,'last_revis_date'))	
	lds_ctx_basic_info.setitem(ll_row,'term_date',lds_detail.getitemdatetime(1,'term_date'))	
	lds_ctx_basic_info.setitem(ll_row,'other_date_1',lds_detail.getitemdatetime(1,'other_date_1'))	
	lb_copy = True
End If
If cbx_3.checked = True Then
	//Custom Data
	lds_ctx_basic_info.setitem(ll_row,'custom_1',lds_detail.getitemstring(1,'custom_1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_2',lds_detail.getitemstring(1,'custom_2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_3',lds_detail.getitemstring(1,'custom_3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_4',lds_detail.getitemstring(1,'custom_4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_5',lds_detail.getitemstring(1,'custom_5'))
	lds_ctx_basic_info.setitem(ll_row,'custom_6',lds_detail.getitemstring(1,'custom_6'))
	lds_ctx_basic_info.setitem(ll_row,'custom_7',lds_detail.getitemstring(1,'custom_7'))
	lds_ctx_basic_info.setitem(ll_row,'custom_8',lds_detail.getitemstring(1,'custom_8'))
	lds_ctx_basic_info.setitem(ll_row,'custom_9',lds_detail.getitemstring(1,'custom_9'))
	lds_ctx_basic_info.setitem(ll_row,'custom_10',lds_detail.getitemstring(1,'custom_10'))
	lds_ctx_basic_info.setitem(ll_row,'custom_11',lds_detail.getitemstring(1,'custom_11'))
	lds_ctx_basic_info.setitem(ll_row,'custom_12',lds_detail.getitemstring(1,'custom_12'))
	lds_ctx_basic_info.setitem(ll_row,'custom_13',lds_detail.getitemstring(1,'custom_13'))
	lds_ctx_basic_info.setitem(ll_row,'custom_14',lds_detail.getitemstring(1,'custom_14'))
	lds_ctx_basic_info.setitem(ll_row,'custom_15',lds_detail.getitemstring(1,'custom_15'))
	lds_ctx_basic_info.setitem(ll_row,'custom_16',lds_detail.getitemstring(1,'custom_16'))
	lds_ctx_basic_info.setitem(ll_row,'custom_17',lds_detail.getitemstring(1,'custom_17'))
	lds_ctx_basic_info.setitem(ll_row,'custom_18',lds_detail.getitemstring(1,'custom_18'))
	lds_ctx_basic_info.setitem(ll_row,'custom_19',lds_detail.getitemstring(1,'custom_19'))
	lds_ctx_basic_info.setitem(ll_row,'custom_20',lds_detail.getitemstring(1,'custom_20'))	
	lds_ctx_basic_info.setitem(ll_row,'custom_date1',lds_detail.getitemdatetime(1,'custom_date1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date2',lds_detail.getitemdatetime(1,'custom_date2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date3',lds_detail.getitemdatetime(1,'custom_date3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date4',lds_detail.getitemdatetime(1,'custom_date4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date5',lds_detail.getitemdatetime(1,'custom_date5'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date6',lds_detail.getitemdatetime(1,'custom_date6'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date7',lds_detail.getitemdatetime(1,'custom_date7'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date8',lds_detail.getitemdatetime(1,'custom_date8'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date9',lds_detail.getitemdatetime(1,'custom_date9'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date10',lds_detail.getitemdatetime(1,'custom_date10'))	
	lds_ctx_basic_info.setitem(ll_row,'custom_n1',lds_detail.getitemnumber(1,'custom_n1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n2',lds_detail.getitemnumber(1,'custom_n2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n3',lds_detail.getitemnumber(1,'custom_n3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n4',lds_detail.getitemnumber(1,'custom_n4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n5',lds_detail.getitemnumber(1,'custom_n5'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n6',lds_detail.getitemnumber(1,'custom_n6'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n7',lds_detail.getitemnumber(1,'custom_n7'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n8',lds_detail.getitemnumber(1,'custom_n8'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n9',lds_detail.getitemnumber(1,'custom_n9'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n10',lds_detail.getitemnumber(1,'custom_n10'))	
	lb_copy = True
End If
If cbx_4.checked = True Then
	//Notes
	lds_ctx_basic_info.setitem(ll_row,'notes',lds_detail.getitemstring(1,'notes'))		
	lb_copy = True
End If
If cbx_5.checked = True Then
	//Contracted Company Contacts
	lds_company_contacts.retrieve(il_ctx_id,'E')
	For i = 1 To lds_company_contacts.rowcount()		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_contract_contacts.insertrow(0)
		lds_ctx_contract_contacts.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_contract_contacts.setitem(ll_row,'contact_id',lds_company_contacts.getitemnumber(i,'contact_id'))
		lds_ctx_contract_contacts.setitem(ll_row,'ic_area',lds_company_contacts.getitemstring(i,'ic_area'))
		lds_ctx_contract_contacts.setitem(ll_row,'association',lds_company_contacts.getitemstring(i,'association'))
		lds_ctx_contract_contacts.setitem(ll_row,'default_email',lds_company_contacts.getitemstring(i,'default_email'))
		lds_ctx_contract_contacts.setitem(ll_row,'owner',lds_company_contacts.getitemstring(i,'ctx_contract_contacts_owner'))
		lds_ctx_contract_contacts.setitem(ll_row,'access',lds_company_contacts.getitemstring(i,'access'))		
		lds_ctx_contract_contacts.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_contract_contacts.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True
	Next
End If
If cbx_6.checked = True Then
	//Our Company Contacts  
	lds_company_contacts.retrieve(il_ctx_id,'I')
	For i = 1 To lds_company_contacts.rowcount()		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_contract_contacts.insertrow(0)
		lds_ctx_contract_contacts.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_contract_contacts.setitem(ll_row,'contact_id',lds_company_contacts.getitemnumber(i,'contact_id'))
		lds_ctx_contract_contacts.setitem(ll_row,'ic_area',lds_company_contacts.getitemstring(i,'ic_area'))
		lds_ctx_contract_contacts.setitem(ll_row,'association',lds_company_contacts.getitemstring(i,'association'))
		lds_ctx_contract_contacts.setitem(ll_row,'default_email',lds_company_contacts.getitemstring(i,'default_email'))
		lds_ctx_contract_contacts.setitem(ll_row,'owner',lds_company_contacts.getitemstring(i,'ctx_contract_contacts_owner'))
		lds_ctx_contract_contacts.setitem(ll_row,'access',lds_company_contacts.getitemstring(i,'access'))		
		lds_ctx_contract_contacts.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_contract_contacts.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True
	Next
End If
If cbx_7.checked = True Then
	//Products
	lds_products.retrieve(il_ctx_id)
	For i = 1 To lds_products.rowcount()
		ll_record_id = gnv_app.of_get_id('RECORD_ID')		
		ll_row = lds_ctx_products.insertrow(0)
		lds_ctx_products.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_products.setitem(ll_row,'product_id',lds_products.getitemnumber(i,'product_id'))
		lds_ctx_products.setitem(ll_row,'product_type',lds_products.getitemnumber(i,'product_type'))
		lds_ctx_products.setitem(ll_row,'record_id',ll_record_id)		
		lds_ctx_products.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_products.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_products.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_products.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True		
	Next
End If
If cbx_8.checked = True Then
	//Requirements
	lds_requirements.retrieve(il_ctx_id)
	If lds_requirements.rowcount() > 0 Then		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		
		ll_row = lds_ctx_req_profile_hdr.insertrow(0)
		lds_ctx_req_profile_hdr.setitem(ll_row,'ctx_req_profile_hdr_id',ll_ctx_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'ctx_req_profile_id',lds_requirements.getitemnumber(1,'ctx_req_profile_id')) // jervis 03.18.2009 hdr_ctx_req_profile_id to ctx_req_profile_id
		lds_ctx_req_profile_hdr.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_req_profile_hdr.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'updated_at_date_time',today())
		
		gnv_appeondb.of_startqueue( )
		lds_profile_detail.retrieve(il_ctx_id)
		select max(ctx_elements_id) into :ll_element_id from ctx_elements;
		gnv_appeondb.of_commitqueue( )
 
		If isnull(ll_element_id) Or ll_element_id = 0 Then
			ll_element_id = 1
		Else
			ll_element_id = ll_element_id + 1
		End If

		For i = 1 To lds_profile_detail.rowcount()			
			ll_record_id = gnv_app.of_get_id('RECORD_ID')			
			ll_row = lds_ctx_elements.insertrow(0)
			lds_ctx_elements.setitem(ll_row,'ctx_elements_id',ll_element_id)
			lds_ctx_elements.setitem(ll_row,'ctx_req_profile_hdr_id',ll_ctx_id)
			lds_ctx_elements.setitem(ll_row,'ctx_req_tmplt_element_id',lds_profile_detail.getitemnumber(i,'ctx_req_tmplt_element_id'))
			lds_ctx_elements.setitem(ll_row,'char_value',lds_profile_detail.getitemstring(i,'char_value'))
			lds_ctx_elements.setitem(ll_row,'integer_value',lds_profile_detail.getitemnumber(i,'integer_value'))
			lds_ctx_elements.setitem(ll_row,'money_value',lds_profile_detail.getitemnumber(i,'money_value'))		//jervis 09.20.2009
			lds_ctx_elements.setitem(ll_row,'date_value',lds_profile_detail.getitemdatetime(i,'date_value'))
			lds_ctx_elements.setitem(ll_row,'field_value',lds_profile_detail.getitemstring(i,'field_value'))
			lds_ctx_elements.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_elements.setitem(ll_row,'clause',lds_profile_detail.getitemstring(i,'clause'))			
			lds_ctx_elements.setitem(ll_row,'inserted_by_user',gs_user_id)
			lds_ctx_elements.setitem(ll_row,'inserted_at_date_time',today())
			lds_ctx_elements.setitem(ll_row,'updated_by_user',gs_user_id)
			lds_ctx_elements.setitem(ll_row,'updated_at_date_time',today())
			ll_element_id++
		Next		
		lb_copy = True				
	End If
End If
If cbx_9.checked = True Then
	//Other Contacts
	lds_other_contacts.retrieve(il_ctx_id)
	For i = 1 To lds_other_contacts.rowcount()		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_contract_contacts.insertrow(0)
		lds_ctx_contract_contacts.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_contract_contacts.setitem(ll_row,'contact_id',lds_other_contacts.getitemnumber(i,'contact_id'))
		lds_ctx_contract_contacts.setitem(ll_row,'ic_area',lds_other_contacts.getitemstring(i,'ic_area'))
		lds_ctx_contract_contacts.setitem(ll_row,'association',lds_other_contacts.getitemstring(i,'association'))
		lds_ctx_contract_contacts.setitem(ll_row,'default_email','N')		
		lds_ctx_contract_contacts.setitem(ll_row,'notes',lds_other_contacts.getitemstring(i,'notes'))
		lds_ctx_contract_contacts.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_contract_contacts.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True		
	Next
End If
If cbx_10.checked = True Then
	//Locations
	gnv_appeondb.of_startqueue( )
	lds_parent_organization.retrieve(il_ctx_id)
	lds_group_locations.retrieve(il_ctx_id)
	lds_selected_facility.retrieve(il_ctx_id)
	lds_specialties.retrieve(il_ctx_id)
	gnv_appeondb.of_commitqueue( )
	
	For i = 1 To lds_parent_organization.rowcount()
		ll_parent_comp_id = lds_parent_organization.getitemnumber(i,'parent_comp_id')
		ll_loc_id = lds_parent_organization.getitemnumber(i,'ctx_loc_loc_id')
		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_loc.insertrow(0)
		lds_ctx_loc.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_loc.setitem(ll_row,'parent_comp_id',ll_parent_comp_id)
		lds_ctx_loc.setitem(ll_row,'loc_id',ll_loc_id)
		lds_ctx_loc.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_loc.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_loc.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_loc.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_loc.setitem(ll_row,'updated_at_date_time',today())
		
		lds_group_locations.setfilter("parent_comp_id = " + string(ll_parent_comp_id))
		lds_group_locations.filter()
		For j = 1 To lds_group_locations.rowcount()
			ll_loc_id = lds_group_locations.getitemnumber(j,'loc_id')
			ll_parent_comp_id = lds_parent_organization.getitemnumber(i,'parent_comp_id')

			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ll_row = lds_ctx_loc.insertrow(0)
			lds_ctx_loc.setitem(ll_row,'ctx_id',ll_ctx_id)
			lds_ctx_loc.setitem(ll_row,'parent_comp_id',ll_parent_comp_id)
			lds_ctx_loc.setitem(ll_row,'loc_id',ll_loc_id)			
			lds_ctx_loc.setitem(ll_row,'group_number',lds_group_locations.getitemstring(j,'group_number'))
			lds_ctx_loc.setitem(ll_row,"local",lds_group_locations.getitemstring(j,"local"))
			lds_ctx_loc.setitem(ll_row,'custom_1',lds_group_locations.getitemstring(j,'custom_1'))
			lds_ctx_loc.setitem(ll_row,'custom_2',lds_group_locations.getitemstring(j,'custom_2'))			
			lds_ctx_loc.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_loc.setitem(ll_row,'inserted_by_user',gs_user_id)
			lds_ctx_loc.setitem(ll_row,'inserted_at_date_time',today())
			lds_ctx_loc.setitem(ll_row,'updated_by_user',gs_user_id)
			lds_ctx_loc.setitem(ll_row,'updated_at_date_time',today())
			
			lds_selected_facility.setfilter("loc_id = " + string(ll_loc_id) + " and parent_comp_id = " + string(ll_parent_comp_id))
			lds_selected_facility.filter()
			For k = 1 To lds_selected_facility.rowcount()				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_location_pracs.insertrow(0)
				lds_ctx_location_pracs.setitem(ll_row,'ctx_id',ll_ctx_id)
				lds_ctx_location_pracs.setitem(ll_row,'record_id',ll_record_id)			
				lds_ctx_location_pracs.setitem(ll_row,'loc_id',lds_selected_facility.getitemnumber(k,'loc_id'))			
				lds_ctx_location_pracs.setitem(ll_row,'parent_comp_id', lds_selected_facility.getitemnumber(k,'parent_comp_id'))
				lds_ctx_location_pracs.setitem(ll_row,'gp_rec_id',lds_selected_facility.getitemnumber(k,'pracs_gp_rec_id'))			
				lds_ctx_location_pracs.setitem(ll_row,'prac_id',lds_selected_facility.getitemnumber(k,'prac_id'))			
				lds_ctx_location_pracs.setitem(ll_row,'status',lds_selected_facility.getitemnumber(k,'ctx_location_pracs_status'))			
				lds_ctx_location_pracs.setitem(ll_row,'start_date',lds_selected_facility.getitemdatetime(k,'start_date'))			
				lds_ctx_location_pracs.setitem(ll_row,'end_date',lds_selected_facility.getitemdatetime(k,'end_date'))			
			Next
				
			lds_specialties.setfilter("loc_id = " + string(ll_loc_id))
			lds_specialties.filter()
			For k = 1 To lds_specialties.rowcount()				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_location_specialty.insertrow(0)
				lds_ctx_location_specialty.setitem(ll_row,'ctx_id',ll_ctx_id)
				lds_ctx_location_specialty.setitem(ll_row,'record_id',ll_record_id)							
				lds_ctx_location_specialty.setitem(ll_row,'parent_comp_id',lds_specialties.getitemnumber(k,'parent_comp_id'))
				lds_ctx_location_specialty.setitem(ll_row,'loc_id',lds_specialties.getitemnumber(k,'loc_id'))			
				lds_ctx_location_specialty.setitem(ll_row,'prac_specialty',lds_specialties.getitemnumber(k,'prac_specialty'))			
			Next
		Next
		lb_copy = True				
	Next
End If
If cbx_11.checked = True Then
	//Organizations
	lds_organization_list.retrieve(il_ctx_id)
	
	For i = 1 To lds_organization_list.rowcount()		
		ll_org_id = lds_organization_list.getitemnumber(i,'ctx_orgs_contact_org_id')
		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_orgs_contact.insertrow(0)
		lds_ctx_orgs_contact.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_orgs_contact.setitem(ll_row,'org_id',ll_org_id)
		lds_ctx_orgs_contact.setitem(ll_row,'area',lds_organization_list.getitemstring(i,'ctx_orgs_contact_area'))
		lds_ctx_orgs_contact.setitem(ll_row,'notes',lds_organization_list.getitemstring(i,'notes'))
		lds_ctx_orgs_contact.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_orgs_contact.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_orgs_contact.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_orgs_contact.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_orgs_contact.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True			
	Next
End If
If cbx_12.checked = True Then
	//Fee Schedule
	If w_contract.tab_contract_details.tabpage_fee_schedules.visible = True Then
		
		gnv_appeondb.of_startqueue( )
		lds_fee_schedules.retrieve(il_ctx_id)
		lds_providers.retrieve()
		lds_fee_schedule_locations.retrieve()
		lds_fees.retrieve()		
		select max(fee_sched_id) + 1 into :ll_fee_sched_id from ctx_fee_sched_hdr;		
		select max(fee_sched_location_id)  + 1 into :ll_fee_sched_location_id from ctx_fee_sched_locations;				
		select max(fee_sched_data_id) + 1 into :ll_fee_sched_data_id from CTX_FEE_SCHED_DATA;		
		gnv_appeondb.of_commitqueue( )
		
		If isnull(ll_fee_sched_id) Then  ll_fee_sched_id = 1
		If isnull(ll_fee_sched_location_id) Then ll_fee_sched_location_id = 1
		If isnull(ll_fee_sched_data_id) Then ll_fee_sched_data_id = 1				
		
		For i = 1 To lds_fee_schedules.rowcount()
			ll_fee_sched_id1 = lds_fee_schedules.getitemnumber(i,'fee_sched_id')
			
			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ll_row = lds_ctx_fee_sched_hdr.insertrow(0)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'fee_sched_id',ll_fee_sched_id)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'ctx_id',ll_ctx_id)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'sched_type',lds_fee_schedules.getitemnumber(i,'sched_type'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'carve_out_type',lds_fee_schedules.getitemnumber(i,'carve_out_type'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'custom_1',lds_fee_schedules.getitemstring(i,'custom_1'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'custom_2',lds_fee_schedules.getitemstring(i,'custom_2'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'notes',lds_fee_schedules.getitemstring(i,'notes'))
			
			lds_providers.setfilter("fee_sched_id = " + string(ll_fee_sched_id1))
			lds_providers.filter()
			For j = 1 To lds_providers.rowcount()				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_fee_sched_pracs.insertrow(0)
				lds_ctx_fee_sched_pracs.setitem(ll_row,'fee_sched_id',ll_fee_sched_id)
				lds_ctx_fee_sched_pracs.setitem(ll_row,'record_id',ll_record_id)								
				lds_ctx_fee_sched_pracs.setitem(ll_row,'practitioner_id',lds_providers.getitemnumber(j,'practitioner_id'))
			Next
			
			lds_fee_schedule_locations.setfilter("fee_sched_id = " + string(ll_fee_sched_id1))
			lds_fee_schedule_locations.filter()
			For j = 1 To lds_fee_schedule_locations.rowcount()
				ll_fee_sched_location_id1 = lds_fee_schedule_locations.getitemnumber(j,'fee_sched_location_id')
				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_fee_sched_locations.insertrow(0)
				lds_ctx_fee_sched_locations.setitem(ll_row,'fee_sched_location_id',ll_fee_sched_location_id)
				lds_ctx_fee_sched_locations.setitem(ll_row,'fee_sched_id',ll_fee_sched_id)
				lds_ctx_fee_sched_locations.setitem(ll_row,'record_id',ll_record_id)
				lds_ctx_fee_sched_locations.setitem(ll_row,'location',lds_fee_schedule_locations.getitemstring(j,'location'))
				lds_ctx_fee_sched_locations.setitem(ll_row,'rate',lds_fee_schedule_locations.getitemnumber(j,'rate'))
				lds_ctx_fee_sched_locations.setitem(ll_row,'fee_bonus',lds_fee_schedule_locations.getitemnumber(j,'fee_bonus'))
				
				lds_fees.setfilter("fee_sched_location_id = " + string(ll_fee_sched_location_id1))
				lds_fees.filter()
				For k = 1 To lds_fees.rowcount()														
					ll_record_id = gnv_app.of_get_id('RECORD_ID')
					ll_row = lds_ctx_fee_sched_data.insertrow(0)
					lds_ctx_fee_sched_data.setitem(ll_row,'fee_sched_data_id',ll_fee_sched_data_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'fee_sched_location_id',ll_fee_sched_location_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'record_id',ll_record_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'cpt_code',lds_fees.getitemstring(k,'cpt_code'))
					lds_ctx_fee_sched_data.setitem(ll_row,'fee',lds_fees.getitemnumber(k,'fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'office_fee',lds_fees.getitemnumber(k,'office_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'facility_fee',lds_fees.getitemnumber(k,'facility_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'custom_fee',lds_fees.getitemnumber(k,'custom_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'precert',lds_fees.getitemnumber(k,'precert'))
					lds_ctx_fee_sched_data.setitem(ll_row,'preauth',lds_fees.getitemnumber(k,'preauth'))
					lds_ctx_fee_sched_data.setitem(ll_row,'effective_date',lds_fees.getitemdatetime(k,'effective_date'))
					lds_ctx_fee_sched_data.setitem(ll_row,'expiration_date',lds_fees.getitemdatetime(k,'expiration_date'))
					lds_ctx_fee_sched_data.setitem(ll_row,'status',lds_fees.getitemnumber(k,'status'))
					lds_ctx_fee_sched_data.setitem(ll_row,'drg_code',lds_fees.getitemstring(k,'drg_code'))
					lds_ctx_fee_sched_data.setitem(ll_row,'rev_code',lds_fees.getitemstring(k,'rev_code'))
					lds_ctx_fee_sched_data.setitem(ll_row,'claim_type',lds_fees.getitemnumber(k,'claim_type'))
					lds_ctx_fee_sched_data.setitem(ll_row,'flat_fee',lds_fees.getitemnumber(k,'flat_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'cpt_code_set',lds_fees.getitemnumber(k,'cpt_code_set'))
					lds_ctx_fee_sched_data.setitem(ll_row,'reimburse_type',lds_fees.getitemnumber(k,'reimburse_type'))
					lds_ctx_fee_sched_data.setitem(ll_row,'disc_start_perc',lds_fees.getitemnumber(k,'disc_start_perc'))
					lds_ctx_fee_sched_data.setitem(ll_row,'end_day',lds_fees.getitemnumber(k,'end_day'))
					lds_ctx_fee_sched_data.setitem(ll_row,'carve_out_day',lds_fees.getitemnumber(k,'carve_out_day'))
					lds_ctx_fee_sched_data.setitem(ll_row,'sl_threshold',lds_fees.getitemnumber(k,'sl_threshold'))
					lds_ctx_fee_sched_data.setitem(ll_row,'sl_reimburse_type',lds_fees.getitemnumber(k,'sl_reimburse_type'))
					lds_ctx_fee_sched_data.setitem(ll_row,'sl_rate',lds_fees.getitemnumber(k,'sl_rate'))
					lds_ctx_fee_sched_data.setitem(ll_row,'custom_1',lds_fees.getitemstring(k,'custom_1'))
					lds_ctx_fee_sched_data.setitem(ll_row,'custom_2',lds_fees.getitemstring(k,'custom_2'))
					lds_ctx_fee_sched_data.setitem(ll_row,'inserted_by_user',gs_user_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'inserted_at_date_time',today())					
					ll_fee_sched_data_id++
				Next									
				ll_fee_sched_location_id++
			Next			
			ll_fee_sched_id++
			lb_copy = True
		Next
	End If
	If w_contract.tab_contract_details.tabpage_fee_sched2.visible = True Then
		lds_fee_schedules2.retrieve(il_ctx_id)
		For i = 1 To lds_fee_schedules2.rowcount()			
			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ll_row = lds_ctx_fee_sched_nm.insertrow(0)
			
			lds_ctx_fee_sched_nm.setitem(ll_row,'ctx_id',ll_ctx_id)
			lds_ctx_fee_sched_nm.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_fee_sched_nm.setitem(ll_row,'fee_sched_nm_id',lds_fee_schedules2.getitemnumber(i,'fee_sched_nm_id'))
			
			lds_ctx_fee_sched_nm.setitem(ll_row,'billing_cycle',lds_fee_schedules2.getitemnumber(i,'billing_cycle'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'category',lds_fee_schedules2.getitemnumber(i,'category'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'service_item',lds_fee_schedules2.getitemnumber(i,'service_item'))			
			lds_ctx_fee_sched_nm.setitem(ll_row,'description',lds_fee_schedules2.getitemstring(i,'description'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'fee',lds_fee_schedules2.getitemnumber(i,'fee'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'item_status',lds_fee_schedules2.getitemnumber(i,'item_status'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'start_date',lds_fee_schedules2.getitemdatetime(i,'start_date'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'end_date',lds_fee_schedules2.getitemdatetime(i,'end_date'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_fee1',lds_fee_schedules2.getitemnumber(i,'custom_fee1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_int1',lds_fee_schedules2.getitemnumber(i,'custom_int1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text1',lds_fee_schedules2.getitemstring(i,'custom_text1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text2',lds_fee_schedules2.getitemstring(i,'custom_text2'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text3',lds_fee_schedules2.getitemstring(i,'custom_text3'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text4',lds_fee_schedules2.getitemstring(i,'custom_text4'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text5',lds_fee_schedules2.getitemstring(i,'custom_text5'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text6',lds_fee_schedules2.getitemstring(i,'custom_text6'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n1',lds_fee_schedules2.getitemnumber(i,'custom_n1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n2',lds_fee_schedules2.getitemnumber(i,'custom_n2'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n3',lds_fee_schedules2.getitemnumber(i,'custom_n3'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n4',lds_fee_schedules2.getitemnumber(i,'custom_n4'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n5',lds_fee_schedules2.getitemnumber(i,'custom_n5'))
			
			lds_ctx_fee_sched_nm.setitem(ll_row,'notes',lds_fee_schedules2.getitemstring(i,'notes'))					
			lb_copy = True
		Next			
	End If
End If
If cbx_13.checked = True Then
	//Action Items
	lds_action_items.retrieve(il_ctx_id)
	For i = 1 To lds_action_items.rowcount()
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_action_items.insertrow(0)		
		lds_ctx_action_items.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_action_items.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_action_items.setitem(ll_row,'ctx_action_item_id',lds_action_items.getitemnumber(i,'ctx_action_item_id'))
		lds_ctx_action_items.setitem(ll_row,'action_type',lds_action_items.getitemnumber(i,'action_type'))
		lds_ctx_action_items.setitem(ll_row,'due_date',lds_action_items.getitemdatetime(i,'due_date'))
		lds_ctx_action_items.setitem(ll_row,'action_user',lds_action_items.getitemstring(i,'action_user'))
		lds_ctx_action_items.setitem(ll_row,'action_date',lds_action_items.getitemdatetime(i,'action_date'))
		lds_ctx_action_items.setitem(ll_row,'action_status',lds_action_items.getitemnumber(i,'action_status'))
		lds_ctx_action_items.setitem(ll_row,'wf_assigned_by',lds_action_items.getitemstring(i,'wf_assigned_by'))
		lds_ctx_action_items.setitem(ll_row,'inserted_at_date_time',lds_action_items.getitemdatetime(i,'inserted_at_date_time'))
		lds_ctx_action_items.setitem(ll_row,'no_attempts',lds_action_items.getitemnumber(i,'no_attempts'))
		lds_ctx_action_items.setitem(ll_row,'first_attempt',lds_action_items.getitemdatetime(i,'first_attempt'))
		lds_ctx_action_items.setitem(ll_row,'last_attempt',lds_action_items.getitemdatetime(i,'last_attempt'))
		lds_ctx_action_items.setitem(ll_row,'notes',lds_action_items.getitemstring(i,'notes'))
		lds_ctx_action_items.setitem(ll_row,'wf_step',lds_action_items.getitemnumber(i,'wf_step'))
		lds_ctx_action_items.setitem(ll_row,'wf_id',lds_action_items.getitemnumber(i,'wf_id'))
		lds_ctx_action_items.setitem(ll_row,'letter_flag',lds_action_items.getitemstring(i,'letter_flag'))
		lds_ctx_action_items.setitem(ll_row,'letter_to',lds_action_items.getitemnumber(i,'letter_to'))
		lds_ctx_action_items.setitem(ll_row,'letter_from',lds_action_items.getitemnumber(i,'letter_from'))
		lds_ctx_action_items.setitem(ll_row,'letter_id',lds_action_items.getitemnumber(i,'letter_id'))
		lds_ctx_action_items.setitem(ll_row,'wf_action_type_id',lds_action_items.getitemnumber(i,'wf_action_type_id'))
		lds_ctx_action_items.setitem(ll_row,'wf_complete_flag',lds_action_items.getitemstring(i,'wf_complete_flag'))
		lds_ctx_action_items.setitem(ll_row,'print_flag',lds_action_items.getitemnumber(i,'print_flag'))
		lds_ctx_action_items.setitem(ll_row,'assigned_to',lds_action_items.getitemnumber(i,'assigned_to'))
		
		//Added By Ken.Guo 2009-07-23.
		lds_ctx_action_items.setitem(ll_row,'custom_n1',lds_action_items.getitemnumber(i,'custom_n1'))
		lds_ctx_action_items.setitem(ll_row,'custom_n2',lds_action_items.getitemnumber(i,'custom_n2'))
		lds_ctx_action_items.setitem(ll_row,'custom_n3',lds_action_items.getitemnumber(i,'custom_n3'))
		lds_ctx_action_items.setitem(ll_row,'custom_n4',lds_action_items.getitemnumber(i,'custom_n4'))
		lds_ctx_action_items.setitem(ll_row,'custom_n5',lds_action_items.getitemnumber(i,'custom_n5'))
		lds_ctx_action_items.setitem(ll_row,'custom_1',lds_action_items.getitemstring(i,'custom_1'))
		lds_ctx_action_items.setitem(ll_row,'custom_2',lds_action_items.getitemstring(i,'custom_2'))
		lds_ctx_action_items.setitem(ll_row,'custom_3',lds_action_items.getitemstring(i,'custom_3'))
		lds_ctx_action_items.setitem(ll_row,'custom_4',lds_action_items.getitemstring(i,'custom_4'))
		
		lb_copy = True				
	Next	
End If

//Added By Ken.Guo 2009-05-20.
If cbx_group_access.checked = true Then
	ll_cnt = lds_ctx_group_access.Retrieve(il_ctx_id)
	For i = 1 To ll_cnt
		ll_row = lds_ctx_group_access.InsertRow(0)
		lds_ctx_group_access.SetItem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_group_access.SetItem(ll_row,'group_id',lds_ctx_group_access.GetItemNumber(i,'group_id'))
		lds_ctx_group_access.SetItem(ll_row,'access',lds_ctx_group_access.GetItemString(i,'access'))
		lds_ctx_group_access.SetItem(ll_row,'view_id',lds_ctx_group_access.GetItemNumber(i,'view_id'))
		lb_copy = True
	Next
End If

If lb_copy = False Then 
	Destroy lds_detail
	Destroy lds_ctx_basic_info
	Destroy lds_company_contacts
	Destroy lds_ctx_contract_contacts
	Destroy lds_products
	Destroy lds_ctx_products
	Destroy lds_requirements
	Destroy lds_ctx_req_profile_hdr
	Destroy lds_profile_detail
	Destroy lds_ctx_elements
	Destroy lds_other_contacts
	Destroy lds_parent_organization
	Destroy lds_ctx_loc
	Destroy lds_group_locations
	Destroy lds_selected_facility
	Destroy lds_ctx_location_pracs
	Destroy lds_specialties
	Destroy lds_ctx_location_specialty
	Destroy lds_organization_list
	Destroy lds_ctx_orgs_contact
	Destroy lds_ctx_org_contact
	Destroy lds_fee_schedules
	Destroy lds_ctx_fee_sched_hdr
	Destroy lds_providers
	Destroy lds_ctx_fee_sched_pracs
	Destroy lds_fee_schedule_locations
	Destroy lds_ctx_fee_sched_locations
	Destroy lds_fees
	Destroy lds_ctx_fee_sched_data
	Destroy lds_fee_schedules2
	Destroy lds_ctx_fee_sched_nm
	Destroy lds_action_items
	Destroy lds_ctx_action_items
	Destroy lds_ctx_group_access
	If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)
	messagebox('Copy Contract Failed','The selected items have no data at all.')
	Return
End If
gnv_appeondb.of_startqueue( )
lds_ctx_basic_info.update()
lds_ctx_contract_contacts.update()
lds_ctx_products.update()
lds_ctx_req_profile_hdr.update()
lds_ctx_elements.update()
lds_ctx_contract_contacts.update()
lds_ctx_loc.update()
lds_ctx_location_pracs.update()
lds_ctx_location_specialty.update()
lds_ctx_orgs_contact.update()
lds_ctx_org_contact.update()
lds_ctx_fee_sched_hdr.update()
lds_ctx_fee_sched_pracs.update()
lds_ctx_fee_sched_locations.update()
lds_ctx_fee_sched_data.update()
lds_ctx_fee_sched_nm.update()
lds_ctx_action_items.update()
lds_ctx_group_access.update()
gnv_appeondb.of_commitqueue( )

If cbx_14.checked = True Then
	//Document Manager
	of_Copy_Document_Manager(il_ctx_id,ll_ctx_id)
End If

Destroy lds_detail
Destroy lds_ctx_basic_info
Destroy lds_company_contacts
Destroy lds_ctx_contract_contacts
Destroy lds_products
Destroy lds_ctx_products
Destroy lds_requirements
Destroy lds_ctx_req_profile_hdr
Destroy lds_profile_detail
Destroy lds_ctx_elements
Destroy lds_other_contacts
Destroy lds_parent_organization
Destroy lds_ctx_loc
Destroy lds_group_locations
Destroy lds_selected_facility
Destroy lds_ctx_location_pracs
Destroy lds_specialties
Destroy lds_ctx_location_specialty
Destroy lds_organization_list
Destroy lds_ctx_orgs_contact
Destroy lds_ctx_org_contact
Destroy lds_fee_schedules
Destroy lds_ctx_fee_sched_hdr
Destroy lds_providers
Destroy lds_ctx_fee_sched_pracs
Destroy lds_fee_schedule_locations
Destroy lds_ctx_fee_sched_locations
Destroy lds_fees
Destroy lds_ctx_fee_sched_data
Destroy lds_fee_schedules2
Destroy lds_ctx_fee_sched_nm
Destroy lds_action_items
Destroy lds_ctx_action_items
Destroy lds_ctx_group_access
If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)
closewithreturn(w_copy_contract,ll_ctx_id)
*/


end event

type cbx_13 from checkbox within w_copy_sub_contract
integer x = 46
integer y = 928
integer width = 603
integer height = 64
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Action Items"
end type

type cbx_12 from checkbox within w_copy_sub_contract
integer x = 681
integer y = 832
integer width = 603
integer height = 64
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Fee Schedule"
end type

type cbx_11 from checkbox within w_copy_sub_contract
integer x = 46
integer y = 832
integer width = 603
integer height = 64
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Organizations"
end type

type cbx_10 from checkbox within w_copy_sub_contract
integer x = 1385
integer y = 736
integer width = 777
integer height = 64
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Locations"
end type

type cbx_9 from checkbox within w_copy_sub_contract
integer x = 681
integer y = 736
integer width = 603
integer height = 64
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Other Contacts"
end type

type cbx_8 from checkbox within w_copy_sub_contract
integer x = 46
integer y = 736
integer width = 603
integer height = 64
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Requirements"
end type

type cbx_7 from checkbox within w_copy_sub_contract
integer x = 681
integer y = 460
integer width = 603
integer height = 64
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Products"
end type

type cbx_6 from checkbox within w_copy_sub_contract
integer x = 1385
integer y = 460
integer width = 777
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Our Company Contacts  "
end type

type cbx_5 from checkbox within w_copy_sub_contract
integer x = 1385
integer y = 364
integer width = 795
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contracted Company Contacts"
end type

type cbx_4 from checkbox within w_copy_sub_contract
integer x = 681
integer y = 364
integer width = 603
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Notes"
end type

type cbx_3 from checkbox within w_copy_sub_contract
integer x = 1385
integer y = 268
integer width = 777
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom Data"
end type

type cbx_2 from checkbox within w_copy_sub_contract
integer x = 681
integer y = 268
integer width = 603
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contract Dates"
end type

type cbx_1 from checkbox within w_copy_sub_contract
integer x = 46
integer y = 268
integer width = 603
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contract Detail"
end type

event clicked;//Added By Mark Lee 11/19/2012
If not isnull(istr_copy_sub_contract.as_type) and istr_copy_sub_contract.as_type = 'Copy_&_Create_Sub_Contract_Record' Then 
	If this.checked = False Then
		this.checked = True 
		Messagebox(gnv_app.iapp_object.DisplayName,"You can not uncheck this box when you copy and create a sub contract record.")
	End If
End If
end event

type st_1 from statictext within w_copy_sub_contract
integer x = 32
integer y = 40
integer width = 2162
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_copy_sub_contract
integer x = 14
integer y = 196
integer width = 2181
integer height = 448
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Detail Tab"
end type

type cbx_14 from checkbox within w_copy_sub_contract
integer x = 1385
integer y = 832
integer width = 777
integer height = 64
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Document Manager"
end type

type gb_2 from groupbox within w_copy_sub_contract
integer x = 14
integer y = 652
integer width = 2181
integer height = 392
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Other Tabs"
end type

