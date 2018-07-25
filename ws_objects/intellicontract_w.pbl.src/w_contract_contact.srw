$PBExportHeader$w_contract_contact.srw
$PBExportComments$[intellicontract_w] Contact Maintence window
forward
global type w_contract_contact from w_response
end type
type cb_import from commandbutton within w_contract_contact
end type
type cb_moveto from commandbutton within w_contract_contact
end type
type cb_close from commandbutton within w_contract_contact
end type
type cb_delete from commandbutton within w_contract_contact
end type
type cb_add from commandbutton within w_contract_contact
end type
type cb_save from commandbutton within w_contract_contact
end type
type cb_select from commandbutton within w_contract_contact
end type
type tab_1 from u_tab_cntx within w_contract_contact
end type
type tab_1 from u_tab_cntx within w_contract_contact
end type
end forward

global type w_contract_contact from w_response
integer width = 3991
integer height = 2180
string title = "Contract Contact"
long backcolor = 33551856
event type long ue_save ( )
event ue_new ( )
event ue_select_details_tab ( )
event ue_refurbish ( )
event ue_open ( )
cb_import cb_import
cb_moveto cb_moveto
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
cb_save cb_save
cb_select cb_select
tab_1 tab_1
end type
global w_contract_contact w_contract_contact

type variables

str_pass istr_pass
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.29.2007 By: Jack
//$<reason> 
string is_company
//---------------------------- APPEON END ----------------------------
Boolean		lbn_datamodify = false			//Added By Mark Lee 06/14/12
end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_add_contacts_email (string as_mail)
public function integer of_add_contacts (str_contact astr_contact)
public function integer of_add_email_contact (str_contact astr_contact)
end prototypes

event type long ue_save();/******************************************************************************************************************
**  [PUBLIC]   : ue_save
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long li_rc


//li_rc =  of_updatechecks()

//choose case li_rc
//	case -1 
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "AcceptText error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return failure
//	case -2
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "UpdatesPending error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return failure
//	case -3
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Validation error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return failure
//		
//end choose 


If This.Event pfc_save() >= 1 Then
	       return success
			 
			else 
				return failure
			End If

//if li_rc > 0 then 
//			li_rc = 1 //of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
//	Choose Case li_rc
//		Case 1
//			// YES - Update
//			// If the update fails, prevent the window from closing
//			If This.Event pfc_save() >= 1 Then
//			else 
//				return failure
//			End If
//		Case 2
//			// do nothing reset the datawindows			
//		Case 3
//			// CANCEL -  Prevent the window from closing
//			return success
//	End Choose
//else 
//	return failure
//
//end if

return success
end event

event ue_new();
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
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


this.tab_1.tabpage_details.enabled = true


this.tab_1.tabpage_details.event ue_new( )
IF Istr_pass.s_string = 'INTERNAL' THEN 
	THIS.TAB_1.TABpage_details.dw_master.OBJECT.contact_type2[1] = 'A'
ELSE 
	THIS.TAB_1.TABpage_details.dw_master.OBJECT.contact_type2[1] = 'B'
	
END IF 
// new do do not fire save 
THIS.TAB_1.TABpage_details.dw_master.setitemstatus(1,0,primary!,notmodified!)


end event

event ue_select_details_tab();this.tab_1.tabpage_details.enabled = true
this.tab_1.selecttab( 'tabpage_details')

end event

event ue_refurbish();//////////////////////////////////////////////////////////////////////
// $<event>ue_refurbishw_contract_contact()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>Fix a defect.
//////////////////////////////////////////////////////////////////////
// $<add> 01.09.2007 by Jack 
//////////////////////////////////////////////////////////////////////
If this.tab_1.tabpage_contact_search.rb_1.checked = True then
	this.tab_1.tabpage_contact_search.rb_1.triggerevent(clicked!)
End If
If this.tab_1.tabpage_contact_search.rb_2.checked = True then
	this.tab_1.tabpage_contact_search.rb_2.triggerevent(clicked!)
End If
If this.tab_1.tabpage_contact_search.rb_3.checked = True then
	this.tab_1.tabpage_contact_search.rb_3.triggerevent(clicked!)
End If
If this.tab_1.tabpage_contact_search.rb_4.checked = True then
	this.tab_1.tabpage_contact_search.rb_4.triggerevent(clicked!)
End If

end event

event ue_open();//====================================================================
// Event: ue_open
//--------------------------------------------------------------------
// Description: for access of right
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	mark		Date: 03/22/12 
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
integer	 li_rtn
string 	ls_err

li_rtn = 	w_mdi.of_security_access( 6930 )  
If li_rtn = 0 Then 
	Messagebox("Prompt","You don’t have the permission to access this module ! " , Information!,OK!)
	close(this)
Elseif li_rtn = 1  Then 
	cb_import.enabled = False
	cb_moveto.enabled = False
	cb_add.enabled = False
	cb_delete.enabled = False
	cb_save.enabled = False
	
	tab_1.tabpage_details.dw_facility_detail.of_disable_columns()
	tab_1.tabpage_details.dw_contact_master.of_disable_columns()
	tab_1.tabpage_details.dw_master.of_disable_columns()
	tab_1.tabpage_details.dw_1.of_disable_columns()
	tab_1.tabpage_custom.dw_2.of_disable_columns()
	tab_1.tabpage_access.dw_access.of_disable_columns( )
	tab_1.tabpage_access.cb_setdefault.enabled = False
	tab_1.tabpage_access.cb_add.enabled = False
	tab_1.tabpage_access.cb_delete.enabled = False
	tab_1.tabpage_details.dw_facility_detail.of_setupdateable( False) 
	tab_1.tabpage_details.dw_contact_master.of_setupdateable( False) 
	tab_1.tabpage_details.dw_master.of_setupdateable( False) 
	tab_1.tabpage_details.dw_1.of_setupdateable( False) 
//	tab_1.tabpage_custom.dw_2.of_setupdateable( False) 
	tab_1.tabpage_access.dw_access.of_setupdateable( False) 
Elseif li_rtn = 2 Then
	cb_import.enabled = True
	cb_moveto.enabled = True
	cb_add.enabled = True
	cb_delete.enabled = True
	cb_save.enabled = True
	tab_1.tabpage_details.dw_facility_detail.of_enable_columns()
	tab_1.tabpage_details.dw_contact_master.of_enable_columns()
	tab_1.tabpage_details.dw_master.of_enable_columns()
	tab_1.tabpage_details.dw_1.of_enable_columns()
	tab_1.tabpage_custom.dw_2.of_enable_columns()
	tab_1.tabpage_access.dw_access.of_enable_columns( )
	tab_1.tabpage_access.cb_setdefault.enabled = True
	tab_1.tabpage_access.cb_add.enabled = True
	tab_1.tabpage_access.cb_delete.enabled = True	
	tab_1.tabpage_details.dw_facility_detail.of_setupdateable( True) 
	tab_1.tabpage_details.dw_contact_master.of_setupdateable( True) 
	tab_1.tabpage_details.dw_master.of_setupdateable( True) 
	tab_1.tabpage_details.dw_1.of_setupdateable( True) 
//	tab_1.tabpage_custom.dw_2.of_setupdateable( true) 
	tab_1.tabpage_access.dw_access.of_setupdateable( True) 
End if 

end event

public function integer of_retrieve ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-0827 By: Wu ZhiJun
//$<reason> Retrieve company information

//THIS.TAB_1.TABpage_details.DW_master.RESET()
//THIS.TAB_1.TABpage_details.DW_master.event pfc_retrieve( )

this.tab_1.Tabpage_details.dw_facility_detail.Reset()
this.tab_1.Tabpage_details.dw_contact_master.Reset()
this.tab_1.Tabpage_details.dw_master.Reset()
this.tab_1.Tabpage_details.dw_1.Reset()
this.tab_1.Tabpage_details.dw_facility_detail.event pfc_retrieve( )

//--------------------------- APPEON END -----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.15.2006 By: Rodger Wu
//$<reason> Fix a defect.
//$<reason> The following script is moved here from u_tabpg_cntct_details.dw_master.retrieveend().
//THIS.TAB_1.TABpage_details.DW_1.event pfc_retrieve( )
//---------------------------- APPEON END ----------------------------

RETURN SUccess
end function

public subroutine of_add_contacts_email (string as_mail);CloseWithReturn(this, as_mail)
end subroutine

public function integer of_add_contacts (str_contact astr_contact);/******************************************************************************************************************
**  [PUBLIC]   : of_add_contacts( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
**   Ken.Guo				11/01/2012				Use structure pass the value
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_row,ll_i
long ll_found
// make sure the contact does no already exsit

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Davis
//$<reason> Fix a defect.
IF NOT Isvalid(istr_pass.s_u_dw) THEN RETURN 0
//---------------------------- APPEON END ----------------------------

IF istr_pass.S_string <> 'CONTACT' THEN
	ll_found = istr_pass.s_u_dw.Find( "contact_id = " + string( astr_contact.al_contact_id ), 1, istr_pass.s_u_dw.rowcount())
	if ll_found < 1 then
		ll_row = istr_pass.s_u_dw.insertrow(0)
		istr_pass.s_u_dw.object.last_name[ll_row] = astr_contact.as_last_name
		istr_pass.s_u_dw.object.first_name[ll_row] = astr_contact.as_first_name
		istr_pass.s_u_dw.object.middle_name[ll_row] = astr_contact.as_middle_name
		istr_pass.s_u_dw.object.contact_id[ll_row] = astr_contact.al_contact_id
		istr_pass.s_u_dw.object.contact_type[ll_row] = astr_contact.al_contact_type
		If istr_pass.s_u_dw.Describe("association.type") = 'column' Then //Added By Ken.Guo 2010-12-15. Added If statements
			istr_pass.s_u_dw.object.association[ll_row] = String(astr_contact.al_contact_type)
		End If
		If istr_pass.s_u_dw.Describe("contact_phone.type") = 'column' Then
			istr_pass.s_u_dw.object.contact_phone[ll_row] = astr_contact.as_phone_number
		End If
		If istr_pass.s_u_dw.Describe("user_d.type") = 'column' Then	
			istr_pass.s_u_dw.object.user_d[ll_row] = astr_contact.as_user_id
		end if

		//Added By Ken.Guo 11/01/2012
		If istr_pass.s_u_dw.Describe("contact_title.type") = 'column' Then	
			istr_pass.s_u_dw.object.contact_title[ll_row] = astr_contact.as_contact_title
		end if
		If istr_pass.s_u_dw.Describe("contact_department.type") = 'column' Then	
			istr_pass.s_u_dw.object.contact_department[ll_row] = astr_contact.al_contact_department
		end if
		
	end if
else 
	n_ds lds
	lds = CREATE n_ds
	lds.DataObject = 'd_contract_det_contact_contact_notes'
	lds.of_SetTransobject( sqlca)
	
	long ll_found_row
	ll_found_row = istr_pass.s_u_dw.rowcount()
	ll_found_row = istr_pass.s_u_dw.Find( "contact_id = " + string( astr_contact.al_contact_id ), 1, istr_pass.s_u_dw.rowcount()) 
	
	if ll_found_row  < 1 then
		ll_row = istr_pass.s_u_dw.insertrow( 0)
		istr_pass.s_u_dw.object.contact_id[ll_row] = astr_contact.al_contact_id
		ll_row = LDS.insertrow(0)
		lds.object.ctx_id[ll_row] = istr_pass.s_long[1] 
		lds.object.contact_id[ll_row] = astr_contact.al_contact_id
		lds.object.ic_area[ll_row] = 'C'
		lds.update()
   end if
	
	destroy LDS
	
end if 

return success

end function

public function integer of_add_email_contact (str_contact astr_contact);/******************************************************************************************************************
**  [PUBLIC]   : of_add_contacts( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_row,ll_i
long ll_found
// make sure the contact does no already exsit

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Davis
//$<reason> Fix a defect.
IF NOT Isvalid(istr_pass.s_u_dw) THEN RETURN 0
//---------------------------- APPEON END ----------------------------

//Added By mark 03/29/12
If istr_pass.S_string = 'Company' Or istr_pass.S_string = 'Select_Company'  Or istr_pass.S_string = 'Dotdd_Company' THEN
	RETURN 0
End If

IF istr_pass.S_string <> 'CONTACT' THEN
	ll_found = istr_pass.s_u_dw.Find( "contact_id = " + string( astr_contact.al_contact_id ), 1, istr_pass.s_u_dw.rowcount())
	if ll_found < 1 then
		ll_row = istr_pass.s_u_dw.insertrow(0)
		istr_pass.s_u_dw.object.last_name[ll_row] = astr_contact.as_last_name
		istr_pass.s_u_dw.object.first_name[ll_row] = astr_contact.as_first_name
		istr_pass.s_u_dw.object.middle_name[ll_row] = astr_contact.as_middle_name
		istr_pass.s_u_dw.object.contact_id[ll_row] = astr_contact.al_contact_id
		istr_pass.s_u_dw.object.contact_type[ll_row] = astr_contact.al_contact_type

		If istr_pass.s_u_dw.Describe("association.type") = 'column' Then //Added By Ken.Guo 2010-12-15. Added If statements
			istr_pass.s_u_dw.object.association[ll_row] = String(astr_contact.al_contact_type)
		End If
		If istr_pass.s_u_dw.Describe("contact_phone.type") = 'column' Then
			istr_pass.s_u_dw.object.contact_phone[ll_row] = astr_contact.as_phone_number
		End If
		If istr_pass.s_u_dw.Describe("user_d.type") = 'column' Then	
			istr_pass.s_u_dw.object.user_d[ll_row] = astr_contact.as_user_id
		end if
		If istr_pass.s_u_dw.Describe("contact_email.type") = 'column' Then	
			istr_pass.s_u_dw.object.contact_email[ll_row] = astr_contact.as_email
		End If

		//Added By Ken.Guo 11/01/2012
		If istr_pass.s_u_dw.Describe("contact_title.type") = 'column' Then	
			istr_pass.s_u_dw.object.contact_title[ll_row] = astr_contact.as_contact_title
		end if
		If istr_pass.s_u_dw.Describe("contact_department.type") = 'column' Then	
			istr_pass.s_u_dw.object.contact_department[ll_row] = astr_contact.al_contact_department
		end if
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<  Add > 2007-11-01 By: Scofield
		//$<Reason> Set the default value
		long		ll_Find
		String	ls_DefauTo,ls_UserId
		
		if istr_pass.s_u_dw.ClassName() = 'dw_ccc' then
			ll_Find = istr_pass.s_u_dw.Find("default_email = 'Y'",1,istr_pass.s_u_dw.rowcount())
			if ll_Find <= 0 then
				Select defaultto
				  into :ls_DefauTo
				  from ctx_contacts
				 where contact_id = :astr_contact.al_contact_id ;
				if ls_DefauTo = '1' then
					istr_pass.s_u_dw.object.default_email[ll_row] = 'Y'
				end if
			end if
		elseif istr_pass.s_u_dw.ClassName() = 'dw_occ' then
			Select user_d
			  into :ls_UserId
			  from ctx_contacts
			 where contact_id = :astr_contact.al_contact_id ;
			if ls_UserId = gs_user_id then
				ll_Find = istr_pass.s_u_dw.Find("default_email = 'Y'",1,istr_pass.s_u_dw.rowcount())
				if ll_Find <= 0 then
					istr_pass.s_u_dw.object.default_email[ll_row] = 'Y'
				end if
				ll_Find = istr_pass.s_u_dw.Find("ctx_contract_contacts_owner = 'Y'",1,istr_pass.s_u_dw.rowcount())
				if ll_Find <= 0 then
					istr_pass.s_u_dw.object.ctx_contract_contacts_owner[ll_row] = 'Y'
				end if
			end if
		end if
		//---------------------------- APPEON END ----------------------------
	end if
else 
	n_ds lds
	lds = CREATE n_ds
	lds.DataObject = 'd_contract_det_contact_contact_notes'
	lds.of_SetTransobject( sqlca)
	
	long ll_found_row
	ll_found_row = istr_pass.s_u_dw.rowcount()
	ll_found_row = istr_pass.s_u_dw.Find( "contact_id = " + string( astr_contact.al_contact_id ), 1, istr_pass.s_u_dw.rowcount()) 
	
	if ll_found_row  < 1 then
		ll_row = istr_pass.s_u_dw.insertrow( 0)
		istr_pass.s_u_dw.object.contact_id[ll_row] = astr_contact.al_contact_id
		ll_row = LDS.insertrow(0)
		lds.object.ctx_id[ll_row] = istr_pass.s_long[1] 
		lds.object.contact_id[ll_row] = astr_contact.al_contact_id
		lds.object.ic_area[ll_row] = 'C'
		lds.update()
   end if
	
	destroy LDS
	
end if 

return success

end function

on w_contract_contact.create
int iCurrent
call super::create
this.cb_import=create cb_import
this.cb_moveto=create cb_moveto
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_select=create cb_select
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_import
this.Control[iCurrent+2]=this.cb_moveto
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_select
this.Control[iCurrent+8]=this.tab_1
end on

on w_contract_contact.destroy
call super::destroy
destroy(this.cb_import)
destroy(this.cb_moveto)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_select)
destroy(this.tab_1)
end on

event pfc_preopen;call super::pfc_preopen;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
**------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
String	ls_search_type
long 		ll_Row,ll_PreCurRow,ll_Found,ll_Count,ll_ComCount,ll_facility_id
Boolean	lb_ContactFocus

istr_pass = Message.PowerObjectParm

SELECT Count(*) INTO :ll_Count FROM app_facility ;

is_company = istr_pass.s_string
This.tab_1.TabPage_contact_search.is_company = is_company
if is_company = 'Company' Then
	if ll_Count <= 100 then
		tab_1.TabPage_contact_search.rb_5.Checked = true
		tab_1.TabPage_contact_search.rb_5.Event Clicked()
		tab_1.TabPage_contact_search.rb_4.Checked = true
		tab_1.TabPage_contact_search.rb_4.Event Clicked()
	end if
	This.Post Event ue_select_details_tab()
	tab_1.TabPage_details.dw_facility_detail.Post Event GetFocus()
	cb_add.Post Event Clicked()
	Return
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.29.2007 By: Jack
//$<reason> Fix a defect.

//Modified By mark 03/27/12
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.20.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if upperbound(istr_pass.s_string_array ) > 0 THEN 
  This.tab_1.TabPage_details.ll_app_facility = long(istr_pass.s_string_array[1] )
end if
*/
if NOT IsNull(istr_pass) THEN
	if upperbound(istr_pass.s_string_array ) > 0 THEN 
	  This.tab_1.TabPage_details.ll_app_facility = long(istr_pass.s_string_array[1] )
	end if
end if
//---------------------------- APPEON end ----------------------------

long ll_contact_id
//Added By mark 03/28/12  is_company='Select_Company' 
//if isvalid(istr_pass.s_u_dw) then 
if isvalid(istr_pass.s_u_dw) and  is_company <> 'Select_Company'  and  is_company <> 'Dotdd_Company' then 
	if (istr_pass.s_u_dw.RowCount()) > 0 then
		ll_PreCurRow = istr_pass.s_u_dw.getrow()
		ll_contact_id = istr_pass.s_u_dw.object.contact_id[ll_PreCurRow]
		This.tab_1.TabPage_contact_search.ll_current_contact = ll_contact_id
   end if 
end if

choose case istr_pass.s_string
	case 'INTERNAL'
		if ll_contact_id > 0 then //Jervis 01.21.2011
			SELECT app_facility.contact_type2 INTO :ls_search_type FROM app_facility,ctx_contacts 
			WHERE app_facility.facility_id = ctx_contacts.facility_id  and ctx_contacts.contact_id = :ll_contact_id;
		else
			ls_search_type = 'A'
		end if
		
		//if istr_pass.s_u_dw.RowCount()< 1 then 
		
			istr_pass.s_u_dw.setredraw(FALSE)
			ll_Row = istr_pass.s_u_dw.insertrow(0)
			istr_pass.s_u_dw.SetRow(ll_Row)
			//istr_pass.s_u_dw.object.contact_type2[ll_Row] = 'A'
			istr_pass.s_u_dw.object.contact_type2[ll_Row] = ls_search_type //jervis 01.21.2011
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<comment> 04.10.2007 By: WuZhiJun 
			//$<reason> Fix a defect.
			tab_1.TabPage_contact_search.rb_6.Checked = true  
			tab_1.TabPage_contact_search.rb_6.Event Clicked() 
			//---------------------------- APPEON end ----------------------------
			
			This.TAB_1.TabPage_contact_search.ib_trigger_clicked = true
			This.TAB_1.TabPage_contact_search.of_select_rb(istr_pass.s_u_dw)
			istr_pass.s_u_dw.deleterow(ll_Row)
			
			
			//BEGIN---Modify by Scofield on 2010-04-16
			if istr_pass.Display_Contact_Detail and istr_pass.s_u_dw.RowCount() < 1 then
				Tab_1.Post SelectTab(2)
				lb_ContactFocus = true
			end if
			//END---Modify by Scofield on 2010-04-16
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 05.11.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			istr_pass.s_u_dw.SetRow(ll_PreCurRow)
			*/
			istr_pass.s_u_dw.SelectRow(0, False)
			istr_pass.s_u_dw.SetRow(ll_PreCurRow)
			istr_pass.s_u_dw.SelectRow(ll_PreCurRow, True)
			
			//---------------------------- APPEON end ----------------------------			
			istr_pass.s_u_dw.setredraw(TRUE)
	CASE 'EXTERNAL'
		if ll_contact_id > 0 then //Jervis 01.21.2011
			SELECT app_facility.contact_type2 INTO :ls_search_type FROM app_facility,ctx_contacts 
			WHERE app_facility.facility_id = ctx_contacts.facility_id  and ctx_contacts.contact_id = :ll_contact_id;
		else
			ls_search_type = 'B'
			ll_facility_id = long(istr_pass.s_string_array[1])
			if Not IsNull(ll_facility_id) then
				tab_1.TabPage_contact_search.il_facility_id = ll_facility_id
				SELECT contact_type2 INTO :ls_search_type FROM app_facility WHERE facility_id = :ll_facility_id ;
			end if
		end if
		
		if istr_pass.display_contact_detail = False Or (istr_pass.display_contact_detail = True And istr_pass.s_u_dw.RowCount() < 1) Then
			tab_1.TabPage_contact_search.rb_5.Checked = true
			tab_1.TabPage_contact_search.rb_5.Event Clicked()
		Else	
			tab_1.TabPage_contact_search.rb_6.Checked = true
			tab_1.TabPage_contact_search.rb_6.Event Clicked()
		end if
		
		istr_pass.s_u_dw.setredraw(FALSE)
		ll_Row = istr_pass.s_u_dw.insertrow(0)
		istr_pass.s_u_dw.SetRow(ll_Row)
		istr_pass.s_u_dw.object.contact_type2[ll_Row] = ls_search_type
		
		This.TAB_1.TabPage_contact_search.ib_trigger_clicked = true
		This.TAB_1.TabPage_contact_search.of_select_rb(istr_pass.s_u_dw)
		
		istr_pass.s_u_dw.deleterow(ll_Row)
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 05.05.2007 By: Jack
		//$<reason> Fix a defect.
		if istr_pass.display_contact_detail = False Or (istr_pass.display_contact_detail = True And istr_pass.s_u_dw.RowCount() < 1) Then
			if tab_1.TabPage_contact_search.dw_facility_search.RowCount() > 0 Then
				ll_Found = tab_1.TabPage_contact_search.dw_facility_search.find("facility_id = " + istr_pass.s_string_array[1],1,tab_1.TabPage_contact_search.dw_facility_search.RowCount())
				if ll_Found > 0 Then
					tab_1.TabPage_contact_search.dw_facility_search.SelectRow(0, False)
					tab_1.TabPage_contact_search.dw_facility_search.ScrollToRow(ll_Found)
					tab_1.TabPage_contact_search.dw_facility_search.SelectRow(ll_Found,True)
					
					//BEGIN---Modify by Scofield on 2010-04-16
					if istr_pass.Display_Contact_Detail then
						Tab_1.Post SelectTab(2)
						lb_ContactFocus = true
					end if
					//END---Modify by Scofield on 2010-04-16
				end if
			end if
		Else //Added By Alan on 2009-1-13
			//tab_1.TabPage_contact_search.dw_search.setfilter("facility_id = " + istr_pass.s_string_array[1])
			//tab_1.TabPage_contact_search.dw_search.filter()
			//tab_1.TabPage_contact_search.dw_search.setfilter("")
		end if
		//---------------------------- APPEON end ----------------------------
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 05.11.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		istr_pass.s_u_dw.SetRow(ll_PreCurRow)
		*/
		istr_pass.s_u_dw.SelectRow(0, False)
		istr_pass.s_u_dw.SetRow(ll_PreCurRow)
		istr_pass.s_u_dw.SelectRow(ll_PreCurRow, True)
		
		//---------------------------- APPEON end ----------------------------			
		istr_pass.s_u_dw.setredraw(TRUE)
		
		tab_1.TabPage_contact_search.il_facility_id = 0

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.30.2006 By: Jack 
	//$<reason> Add a new icon to Menu Bar named Contacts.
	CASE 'All LOCATIONS'
		ls_search_type = 'All'
		cb_select.Visible = false			//Added by Scofield on 2007-12-18
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 10.30.2006 By: WuZhiJun 
		//$<reason> if the count is greater than one hundred then don't retrieve
		if ll_Count <= 100 then
			This.Tab_1.TabPage_contact_search.ib_trigger_clicked = true
		else
			This.Tab_1.TabPage_contact_search.ib_trigger_clicked = false
		end if
		//---------------------------- APPEON end ----------------------------
		//This.TAB_1.TabPage_contact_search.ib_trigger_clicked = true
		This.TAB_1.TabPage_contact_search.of_select_rb(istr_pass.s_u_dw)
	//---------------------------- APPEON end ----------------------------
	CASE 'Select_Contact'
		ls_search_type = 'All'

		This.Tab_1.TabPage_contact_search.ib_trigger_clicked = false
		This.TAB_1.TabPage_contact_search.of_select_rb(istr_pass.s_u_dw)
		
		tab_1.tabpage_contact_search.rb_6.Checked = true
		tab_1.tabpage_contact_search.gb_1.Text = "First Letter of Last Name Search"
		tab_1.tabpage_contact_search.gb_3.Text = "Contact Category Search"
		tab_1.tabpage_contact_search.of_AdjustdwPos(1)
	//Begin	-->Added By mark 03/28/12	 for New Company button[...]
	Case 'Select_Company' , 'Dotdd_Company'
		ls_search_type = istr_pass.as_search_type
		If  isnull(ls_search_type) Or trim(ls_search_type) = "" Then
			ls_search_type = "All"
		End If
		
		ll_facility_id = istr_pass.l_facility_id
		if Not IsNull(ll_facility_id) then
			tab_1.TabPage_contact_search.il_facility_id = ll_facility_id
		end if
		tab_1.TabPage_contact_search.rb_5.Checked = true
		tab_1.TabPage_contact_search.rb_5.Event Clicked()
		choose case ls_search_type
			case 'B'
				tab_1.TabPage_contact_search.rb_3.Checked = true
				tab_1.TabPage_contact_search.rb_3.Event Clicked()
			case 'A'
				tab_1.TabPage_contact_search.rb_1.Checked = true
				tab_1.TabPage_contact_search.rb_1.Event Clicked()
			case 'O'
				tab_1.TabPage_contact_search.rb_2.Checked = true
				tab_1.TabPage_contact_search.rb_2.Event Clicked()
			case else
				tab_1.TabPage_contact_search.rb_4.Checked = true
				tab_1.TabPage_contact_search.rb_4.Event Clicked()
		end choose

		If 	istr_pass.display_contact_detail =true Then 
			tab_1.TabPage_contact_search.sle_search.text = string(istr_pass.s_string_array[1])
			tab_1.TabPage_contact_search.cb_search.event clicked( )
			tab_1.TabPage_contact_search.sle_search.text = ""
			This.Post Event ue_select_details_tab()
			tab_1.TabPage_details.dw_facility_detail.Post Event GetFocus()
		Else
			this.tab_1.selecttab( 'tabpage_contact_search')
			tab_1.TabPage_contact_search.sle_search.Post SetFocus()
			return
		End If		
	//End	-->Added By mark 03/28/12				
	CASE 'EMail_Send'
		//BEGIN---Modify by Scofield on 2009-05-20
		ll_facility_id = gl_Company_id
		
		if Not IsNull(ll_facility_id) then
			tab_1.TabPage_contact_search.il_facility_id = ll_facility_id
			SELECT contact_type2 INTO :ls_search_type FROM app_facility WHERE facility_id = :ll_facility_id;
		end if
		
		tab_1.TabPage_contact_search.rb_5.Checked = true
		tab_1.TabPage_contact_search.rb_5.Event Clicked()
		
		choose case ls_search_type
			case 'B'
				tab_1.TabPage_contact_search.rb_3.Checked = true
			case 'A'
				tab_1.TabPage_contact_search.rb_1.Checked = true
			case 'O'
				tab_1.TabPage_contact_search.rb_2.Checked = true
			case else
				tab_1.TabPage_contact_search.rb_4.Checked = true
		end choose
		//END---Modify by Scofield on 2009-05-20
	CASE 'Select_New_Contact' //added by gavins 20121228
		ls_search_type = 'All'

		This.Tab_1.TabPage_contact_search.ib_trigger_clicked = false
		This.TAB_1.TabPage_contact_search.of_select_rb(istr_pass.s_u_dw)
		
		tab_1.tabpage_contact_search.rb_6.Checked = true
		tab_1.tabpage_contact_search.gb_1.Text = "First Letter of Last Name Search"
		tab_1.tabpage_contact_search.gb_3.Text = "Contact Category Search"
		tab_1.tabpage_contact_search.of_AdjustdwPos(1)	
		if ll_Count <= 100 then
			This.Tab_1.TabPage_contact_search.ib_trigger_clicked = true
		else
			This.Tab_1.TabPage_contact_search.ib_trigger_clicked = false
		end if
	CASE ELSE 
		ls_search_type = 'O'
		istr_pass.s_u_dw.setredraw(FALSE)
		ll_Row = istr_pass.s_u_dw.insertrow(0)
		istr_pass.s_u_dw.SetRow(ll_Row)
		istr_pass.s_u_dw.object.contact_type2[ll_Row] = 'O'
		//Start By Jervis 04.24.2008
		//trigger save when execute "istr_pass.s_u_dw.SetRow(ll_Row)"
		istr_pass.s_u_dw.SetItemStatus(ll_Row,0,Primary!,New!)
		istr_pass.s_u_dw.SetItemStatus(ll_Row,0,Primary!,NotModified!)
		//end By Jervis 04.24.2008
		
		This.TAB_1.TabPage_contact_search.ib_trigger_clicked = true
		This.TAB_1.TabPage_contact_search.of_select_rb(istr_pass.s_u_dw)
		if ll_Row > 1 Then
			istr_pass.s_u_dw.deleterow(ll_Row)
			istr_pass.s_u_dw.SelectRow(0, False)
			istr_pass.s_u_dw.SetRow(ll_PreCurRow)
			istr_pass.s_u_dw.SelectRow(ll_PreCurRow, True)
		Else
			istr_pass.s_u_dw.reset()
		end if
		istr_pass.s_u_dw.setredraw(TRUE)
END CHOOSE   

//$<add> 04.17.2008 By: nova
//$<reason>fix bug BugN041101(WEB P3 )
if IsNull(ll_contact_id) then ll_contact_id = 0

ll_Found =  This.tab_1.TabPage_contact_search.dw_search.Find("contact_id = " + string(ll_contact_id )  , 1, This.tab_1.TabPage_contact_search.dw_search.RowCount())

if ll_Found > 0 then
	This.tab_1.TabPage_contact_search.dw_search.scrolltorow(ll_Found)
	This.tab_1.TabPage_contact_search.dw_search.SelectRow(0, FALSE)
   This.tab_1.TabPage_contact_search.dw_search.SelectRow(ll_Found, TRUE)

	if istr_pass.display_contact_detail THEN
		This.Hide() //Added By Ken.Guo 2009-06-02. For no flashing
		This.tab_1.TabPage_contact_search.cb_4.PostEvent(Clicked!)
		This.Post Show()//Added By Ken.Guo 2009-06-02.
	end if
end if

if isvalid(istr_pass.s_u_dw) then
	if istr_pass.s_u_dw.dataobject  <> 'd_contract_det_contact_external'  then 
		 This.tab_1.TabPage_details.ib_show_button = false
	end if 
end if

If ll_Found = 0 or Not istr_pass.display_contact_detail and Tab_1.SelectedTab = 1 Then //Added By Ken.Guo 2009-06-02. add if statement.
	tab_1.TabPage_contact_search.sle_search.Post SetFocus()
End If

if lb_ContactFocus then Tab_1.tabpage_details.dw_master.Post SetFocus()			//Added by Scofield on 2010-04-16

end event

event pfc_endtran;call super::pfc_endtran;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.03.2007 By: Jack 
//$<reason> Fix a defect.

IF AI_update_results = SUCcess THEN 
	string ls_dw[]
	long ll_i
	
	ls_dw[upperbound(ls_dw) + 1 ] = 'dddw_contact_company'     
	ls_dw[upperbound(ls_dw) + 1 ] = 'dddw_contact_facility'     
	
	FOR ll_i = 1 TO upperbound(ls_dw)
		gnv_app.inv_dwcache.of_unRegister(ls_dw[ll_i])
		gnv_app.inv_dwcache.of_Register(ls_dw[ll_i], ls_dw[ll_i], SQLCA, true)
	NEXT

END IF 

return success
//---------------------------- APPEON END ----------------------------

end event

event open;call super::open;integer i

i = of_get_app_setting("set_12","I")

if i = 1 then
	cb_import.visible = true
else
	cb_import.visible = false
end if

//Added By mark 03/22/12 for right of control
This.Post Event ue_open()

Timer(0.1)

end event

event timer;call super::timer;if tab_1.SelectedTab = 2 then
	tab_1.tabpage_details.dw_1.BringToTop = true
end if

end event

event close;call super::close;gnv_data.of_retrieve( "ctx_facility")	//Jervis 12.10.2009
Timer(0)

end event

type cb_import from commandbutton within w_contract_contact
boolean visible = false
integer x = 2235
integer y = 12
integer width = 238
integer height = 84
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import"
end type

event clicked;/////Start Code Change ---- 9.13.2007 #V7 maha intellisoft function for importing from contact database
//Start Code Change ---- 10.17.2007 #V7 maha  function modified to allow mulitple record import, and correct some import bugs based on field length.
datastore ds_import
datastore ds_facility
transaction TR_cont
long ll_Email
long ll_Phone
long ll_Fax
long ll_Main
long ll_title
long ll_cont
long ll_fac
long ll_contact
long ll_id
long c
long f
long ff
long cnt
long f_cnt = 0
integer i
integer nr
integer p1
integer p2
integer chk
long w
integer ip
string ls_log
string ls_pass
string ls_presentation_str
string ls_dwsyntax_str 
string ls_first
string ls_last
string ERRORS
string ls_sql
string ls_file = "C:\intellicontact\cust_export.txt"
string ls_email
string ls_phone
string ls_fax
string ls_phone_temp //maha12.13.07
string ls_conn
string ls_title
string ls_company
string ls_contact_name,ls_Message

//messagebox("","Currently in redevelopment")
//return 

tab_1.selecttab( 2)

if not fileexists(ls_file) then
	messagebox("Contact import", ls_file + " does not exist.  You must export first from IntelliContact.")
	return
end if
//TR_cont = CREATE transaction;
//
//TR_cont.DBMS="ODBC"
////TR_cont.DbParm="ConnectString='DSN=IntelliContact'"
//TR_cont.DbParm="ConnectString='DSN=IntelliContact"
////TR_cont.DbParm="ConnectString='DSN=intellicontact;UID=dba;PWD=sql',DisableBind=1,PBUseProcOwner='Yes',RPCReBind=1,MsgTerse='Yes', " + & 
////																		"DelimitIdentifier='No',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT ',"+ & 
////																		"PBTrimCharColumns='Yes',PBMaxBlobSize = '2147483647' ,PBMaxTextSize = '2147483647'"
//
//CONNECT USING TR_cont;
//	//messagebox(string (i),string(SQLCA.SQLCODE))
//if TR_cont.SQLCODE = 0  THEN
//	messagebox("Unable to connect to Intellicontact database",TR_cont.sqlerrtext)
//	return
//end if
//
//open(w_get_contact_id)
//
//ll_contact = message.doubleparm
//
//if ll_contact = -1 then return
//
//ls_sql = "SELECT contacts.company,   contacts.street_1,            contacts.street_2,            contacts.city,            contacts.state,            contacts.zip,            contact_person.contact_name,            contact_person.contact_phone,            contact_person.contact_email,         contact_person.extention      FROM contact_person,            contacts     WHERE ( contacts.customer_id = contact_person.customer_id ) andcontact_person.contact_type = 'Main' and           ( contacts.customer_id = " + string(ll_contact) + " ) ;"
//
//
//ls_presentation_str = "style(type=grid)"		
//
//ls_dwsyntax_str = TR_cont.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
//IF Len(ERRORS) > 0 THEN
//	MessageBox("Caution on export field " + ls_sql, &
//	"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
////	MessageBox("ls_select_table",ls_select_table)
//	RETURN 
//END IF

ds_import = CREATE n_ds
ds_import.dataobject = "d_intellisoft_contact_import"
//ds_import.settransobject( TR_cont)
ds_import.settransobject( sqlca)

ds_facility = CREATE n_ds
//ds_facility.dataobject = "d_facility_master"
ds_facility.dataobject = "d_facility_master_import" //jervis 12.01.2010
ds_facility.settransobject( sqlca)
ds_facility.retrieve()

w = ds_import.importfile(ls_file)

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-17 By: Scofield
//$<Reason> if export failed then popup error dialog.

Choose Case w
	Case -1
		ls_Message = "No rows or startrow value supplied is greater than the number of rows in the file."
	Case -2
		ls_Message = "Empty file or input data does not match number of columns or required column type."
	Case -3
		ls_Message = "Invalid argument."
	Case -4
		ls_Message = "Invalid input."
	Case -5
		ls_Message = "Could not open the file."
	Case -6
		ls_Message = "Could not close the file."
	Case -7
		ls_Message = "Error reading the text."
	Case -8
		ls_Message = "Unsupported file name suffix (must be *.txt, *.csv, *.dbf or *.xml)."
	Case -10
		ls_Message = "Unsupported dBase file format (not version 2 or 3)."
	Case -11
		ls_Message = "XML Parsing Error; XML parser libraries not found or XML not well formed."
	Case -12
		ls_Message = "XML Template does not exist or does not match the DataWindow."
	Case else
		ls_Message = ""
End Choose

if Len(ls_Message) > 0 then
	MessageBox("Contact import", "Import of file failed.  I hate it when that happens.  Contact Development.~r~n~r~n" + ls_Message)
	DESTROY ds_import
	DESTROY ds_facility
	Return
end if

//if w = -1 then
//	messagebox("Contact import", "Import of file failed.  I hate it when that happens.  Contact Development")
//	destroy ds_import
//	return
//end if

//---------------------------- APPEON END ----------------------------

w = ds_import.rowcount()
//ds_import.getitemstring(1,"contacts_company")
//ds_import.getitemstring(1,"contacts_street_1")
//
//
//
//ds_import.getitemstring(1,"contacts_street_1")
//ds_import.getitemstring(1,"contacts_city")
//ds_import.getitemstring(1,"contacts_state")
//ds_import.getitemstring(1,"contacts_zip")
//ds_import.getitemstring(1,"contact_person_contact_name")
//ds_import.getitemstring(1,"contact_person_contact_phone")
//ds_import.getitemstring(1,"contact_person_contact_email")
//ds_import.getitemstring(1,"contact_person_contact_extension")
//
For c = 1 to w

	//trap for existing
	ll_id = ds_import.getitemnumber(c,"facility_id")
	ls_company = ds_import.getitemstring(c,"facility_name")

	f = ds_facility.find( "contact = '" + string(ll_id) + "'", 1, ds_facility.rowcount())
	if f = 0 then
		ff = ds_facility.find( "facility_name = '" + string(ll_id) + "'",1, ds_facility.rowcount())
		if ff = 0 then	
			tab_1.tabpage_details.dw_facility_detail.reset( )
			tab_1.tabpage_details.dw_master.reset()
			tab_1.tabpage_details.dw_1.reset()
			tab_1.tabpage_details.dw_contact_master.reset()
			
			tab_1.tabpage_details.dw_facility_detail.insertrow(1)
//add facility			
			select max(facility_id) into :ll_fac from app_facility;
			ll_fac++
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"facility_id",ll_fac)
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"facility_name",ls_company )
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"street",ds_import.getitemstring(c,"street"))
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"street_2",ds_import.getitemstring(c,"street_2"))
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"city",ds_import.getitemstring(c,"city"))
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"state",ds_import.getitemstring(c,"state"))
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"zip",ds_import.getitemstring(c,"zip"))
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"contact_type2","B")
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"contact",string(ll_id))
			tab_1.tabpage_details.dw_facility_detail.setitem(1,"corp_office_flag",0)
			
			//debugbreak()
			p1 = tab_1.tabpage_details.dw_facility_detail.update()
			cnt++
			if p1 < 1 then 
				messagebox("Company","Update failed")
				return
			end if
			tab_1.il_facility_id = ll_fac
			//commit using sqlca;
//add contact		
//	debugbreak()
			// contact info
			tab_1.tabpage_details.dw_master.insertrow(1)
			 ip = pos(ds_import.getitemstring(c,"contact")," ",1)
			 ls_contact_name = ds_import.getitemstring(c,"contact")
			ls_first = mid( ls_contact_name,1 ,ip -1 )
			ls_last = mid( ls_contact_name,ip + 1)
			if len(ls_last) < 1 then ls_last = ls_first
			tab_1.tabpage_details.dw_master.setitem(1,"first_name",ls_first)
			tab_1.tabpage_details.dw_master.setitem(1,"last_name",ls_last)
			ls_title = ds_import.getitemstring(1,"contact_title")
			//debugbreak()
			ll_title = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Position Title' and upper(description) = upper('" + ls_title + "')"))	
			
			if ll_title > 0 then
				//ok
			else
				ll_title = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Position Title' and upper(code) = upper('" + ls_title + "')"))	
			end if
			
			if ll_title > 0 then
				tab_1.tabpage_details.dw_master.setitem(1,"contact_title",string(ll_title))
			else
				//tab_1.tabpage_details.dw_master.setitem(1,"contact_title","not found" )
				//write function to add to lookup table
				ll_title = gnv_app.of_Get_Id("LOOKUP" )
				string wger
				wger = mid(upper(ls_title),1,15)
				//wger = "insert into code_lookup (lookup_code,lookup_name,code, description) values (" + string(ll_title) + ",'Contract Position Title'," + "'wger'" + ",'" + ls_title + "');"
				//messagebox("", wger)
				gnv_appeondb.of_startqueue( )
				
				insert into code_lookup (lookup_code,lookup_name,code, description) values (:ll_title,'Contract Position Title', :wger,:ls_title);
			//	if sqlca.sqlcode < 1 then
			//		messagebox("Lookup Error", sqlca.sqlerrtext )
			//	end if
				gnv_appeondb.of_commitqueue( )
				tab_1.tabpage_details.dw_master.setitem(1,"contact_title",string(ll_title))
			end if
			
			ll_Main = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact Type' and code = 'MAIN'"))	
			
			if ll_main > 0 then
				tab_1.tabpage_details.dw_master.setitem(1,"contact_type",ll_Main)
			end if
			
			select max(contact_id) into :ll_cont from ctx_contacts;
			ll_cont++
			tab_1.tabpage_details.dw_master.setitem(1,"contact_id",ll_cont)
			tab_1.tabpage_details.dw_master.setitem(1,"facility_id",ll_fac)
			
			tab_1.tabpage_details.dw_master.update()
				if p1 < 1 then 
				messagebox("Contact","Update failed")
				return
			end if
//add phone data
			//tab_1.tabpage_details.dw
			ll_Phone = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact VIA' and code = 'PHONE'"))
			ll_Email = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact VIA' and code = 'EMAIL'"))
			ll_Fax = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact VIA' and code = 'FAX'"))	
			//Start Code Change ----12.13.2008 #V8 maha
			//format phone 
			ls_phone = ds_import.getitemstring(c,"phone")
			ls_phone_temp = of_strip_char("",ls_phone,"@NUM@") //strip to numbers
			if len(ls_phone_temp) = 10 then //if proper length, format
				ls_phone = of_format_string(ls_phone_temp,"PHONE","STANDARD")
			end if
			//format fax
			ls_fax = ds_import.getitemstring(c,"fax")
			ls_phone_temp = of_strip_char("",ls_fax,"@NUM@")
			if len(ls_phone_temp) = 10 then
				ls_fax = of_format_string(ls_phone_temp,"PHONE","STANDARD")
			end if
			//End Code Change---12.13.2007
			ls_email = ds_import.getitemstring(c,"email_address")
			
			debugbreak()
			if len(ls_phone ) > 0 then
				nr = tab_1.tabpage_details.dw_1.insertrow(0)
				tab_1.tabpage_details.dw_1.setitem(nr,"phone",ls_phone)
				tab_1.tabpage_details.dw_1.setitem(nr,"ext",ds_import.getitemstring(c,"ext"))
				tab_1.tabpage_details.dw_1.setitem(nr,"via",ll_Phone)
				tab_1.tabpage_details.dw_1.setitem(nr,"contact_id",ll_cont)
				tab_1.tabpage_details.dw_1.setitem(nr,"record_id",nr)
			end if
			
			if len(ls_email ) > 0 then
				nr = tab_1.tabpage_details.dw_1.insertrow(0)
				tab_1.tabpage_details.dw_1.setitem(nr,"via",ll_Email)
				tab_1.tabpage_details.dw_1.setitem(nr,"contact_email",ls_email )
				tab_1.tabpage_details.dw_1.setitem(nr,"contact_id",ll_cont)
				tab_1.tabpage_details.dw_1.setitem(nr,"record_id",nr)
			end if
			
			if len(ls_fax ) > 0 then
				nr = tab_1.tabpage_details.dw_1.insertrow(0)
				tab_1.tabpage_details.dw_1.setitem(nr,"via",ll_Fax)
				tab_1.tabpage_details.dw_1.setitem(nr,"phone",ls_fax)
				tab_1.tabpage_details.dw_1.setitem(nr,"contact_id",ll_cont)
				tab_1.tabpage_details.dw_1.setitem(nr,"record_id",nr)
			end if
			
			chk = tab_1.tabpage_details.dw_1.update()
			if chk <> 1 then
				messagebox("","Unable up update contact types")
				return
			end if
		elseif ff > 0 then
			f_cnt++
			//if tab_1.tabpage_contact_search.dw_facility_search.rowcount() + 0 then		
//			tab_1.il_facility_id = tab_1.tabpage_details.dw_facility_detail.getitemnumber(ff,"facility_id")
//			tab_1.tabpage_details.dw_facility_detail.setitem(1,"contact",string(ll_id))
//			//debugbreak()
//			p1 = tab_1.tabpage_details.dw_facility_detail.update()
		end if //name find
	elseif f > 0 then
		f_cnt++
//		tab_1.il_facility_id = tab_1.tabpage_details.dw_facility_detail.getitemnumber(f,"facility_id")
	end if // id find = 0
next
//tab_1.il_facility_id = tab_1.tabpage_details.dw_facility_detail.retrieve()

messagebox("Import", string (cnt) + " records were imported.  " + string (f_cnt) + " records were found existing.")
	////
destroy ds_import
//filedelete(ls_file)

end event

type cb_moveto from commandbutton within w_contract_contact
integer x = 2720
integer y = 12
integer width = 261
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "MoveTo..."
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-07-31 By: Scofield
//$<Reason> Add the function of move some contacts to another company.

long		ll_ContactId[],ll_Count,ll_Null
long		ll_Cycle,ll_RowCount,ll_CurRow
integer	li_Status
long		ll_CompanyId
Boolean	lb_SuccessFlag

if tab_1.SelectedTab = 1 then
	ll_RowCount = tab_1.tabpage_contact_search.dw_search.RowCount()
	for ll_Cycle = 1 to ll_RowCount
		li_Status = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'selected')
		if li_Status = 1 then
			ll_Count++
			ll_ContactId[ll_Count] = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'Contact_Id')
		end if
	next
	if ll_Count = 0 then
		MessageBox('Warning','Please select a contact.',Exclamation!)
		return
	end if
elseif tab_1.SelectedTab = 2 then
	ll_RowCount = tab_1.tabpage_details.dw_contact_master.RowCount()
	if ll_RowCount < 1 then
		MessageBox('Warning','Please select a contact.',Exclamation!)
		return
	else
		ll_CurRow = tab_1.tabpage_details.dw_contact_master.GetRow()
		ll_ContactId[1] = tab_1.tabpage_details.dw_contact_master.GetItemNumber(ll_CurRow,'Contact_Id')
	end if
elseif tab_1.SelectedTab = 3 then
	ll_RowCount = tab_1.tabpage_custom.dw_2.RowCount()
	if ll_RowCount < 1 then
		MessageBox('Warning','Please select a contact.',Exclamation!)
		return
	else
		ll_CurRow = tab_1.tabpage_custom.dw_2.GetRow()
		ll_ContactId[1] = tab_1.tabpage_custom.dw_2.GetItemNumber(ll_CurRow,'Contact_Id')
	end if
	if IsNull(ll_ContactId[1]) then
		MessageBox('Warning','Please save the data first.')
		return
	end if
end if

OpenWithParm(w_MoveTo,-1)

ll_CompanyId = Message.DoubleParm

if IsNull(ll_CompanyId) or ll_CompanyId <= 0 then return

ll_Count = UpperBound(ll_ContactId)
lb_SuccessFlag = true

gnv_appeondb.of_startqueue()

for ll_Cycle = 1 to ll_Count
	UPDATE ctx_contacts
		SET facility_id = :ll_CompanyId
	 WHERE ctx_contacts.contact_id = :ll_ContactId[ll_Cycle] ;
	 
	if SQLCA.SQLCode = 0 then
		COMMIT USING SQLCA;
	else
		MessageBox('Error',SQLCA.SQLErrText,StopSign!)
		ROLLBACK USING SQLCA;
		lb_SuccessFlag = false
	end if
next

gnv_appeondb.of_commitqueue( )

//Update the interface
if tab_1.SelectedTab = 2 or tab_1.SelectedTab = 3 then
	tab_1.Tabpage_details.dw_facility_detail.event pfc_retrieve( )
end if

if tab_1.tabpage_contact_search.rb_5.Checked = true then
	ll_CurRow = tab_1.tabpage_contact_search.dw_facility_search.GetRow()
	tab_1.tabpage_contact_search.dw_facility_search.Trigger Event RowFocusChanged(ll_CurRow)
end if

if lb_SuccessFlag then
	MessageBox('Congratulation','Update successful!')
end if

//---------------------------- APPEON END ----------------------------
end event

type cb_close from commandbutton within w_contract_contact
integer x = 3712
integer y = 12
integer width = 238
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;String	ls_Name
long		ll_Row

ll_Row = tab_1.Tabpage_details.dw_facility_detail.GetRow()
if ll_Row > 0 then
	ls_Name = tab_1.Tabpage_details.dw_facility_detail.GetItemString(ll_Row,'facility_name')
	
	if IsNull(ls_Name) then
		ib_disableclosequery = true
	end if
end if

Close(Parent)

end event

type cb_delete from commandbutton within w_contract_contact
integer x = 3227
integer y = 12
integer width = 238
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;Integer	li_CurrDw
Long 		ll_contact_id,ll_facility_id,ll_Cycle,ll_Find
Long 		ll_rnt,ll_Row,ll_Count
Long		ll_ctx_id //Added By Ken.Guo 2009-10-09.
Boolean	lb_IsTab_1 = false
String ls_template_name

/////////////////////////////////////////////////////////////
if tab_1.SelectedTab = 1 then
	if tab_1.tabpage_contact_search.rb_5.Checked and tab_1.tabpage_contact_search.ib_IsCompany then
		ll_Row = tab_1.tabpage_contact_search.dw_facility_search.GetRow()
		if ll_Row > 0 then
			ll_facility_id = tab_1.tabpage_contact_search.dw_facility_search.GetitemNumber(ll_Row, "facility_id")
		else
			return
		end if
		li_CurrDw = 1
	else
		ll_Row = tab_1.tabpage_contact_search.dw_search.GetRow()
		if ll_Row > 0 then
			ll_contact_id = tab_1.tabpage_contact_search.dw_search.GetitemNumber(ll_Row, "contact_id")
		else
			return
		end if
		li_CurrDw = 2
	end if
	lb_IsTab_1 = true
else
	li_CurrDw = tab_1.Tabpage_details.FUNCTION DYNAMIC of_GetCurrentDw()
	if li_CurrDw = 1 then
		ll_Row = tab_1.Tabpage_details.dw_facility_detail.GetRow()
		if ll_Row > 0 then
			ll_facility_id = tab_1.Tabpage_details.dw_facility_detail.GetitemNumber(ll_Row, "facility_id")
			if Not f_validstr(String(ll_facility_id)) then
				tab_1.Tabpage_details.dw_facility_detail.Reset()
				return
			end if
		else
			return
		end if
	elseif li_CurrDw = 2 then
		ll_Row = tab_1.Tabpage_details.dw_master.GetRow()
		if ll_Row > 0 then
			ll_contact_id = tab_1.Tabpage_details.dw_master.GetitemNumber(ll_Row, "contact_id")
			if Not f_validstr(String(ll_contact_id)) then
				tab_1.Tabpage_details.dw_master.Reset()
				tab_1.Tabpage_details.dw_1.Reset()
				tab_1.Tabpage_details.dw_facility_detail.event pfc_retrieve( )
				return
			end if
		else
			return
		end if
	end if
end if
/////////////////////////////////////////////////////////////

//li_CurrDw = tab_1.Tabpage_details.FUNCTION DYNAMIC of_GetCurrentDw()

if li_CurrDw = 1 then
	if MessageBox('Confirm Delete','Are you sure you want to delete the company? ',Question!,YesNo!,2) <> 1 then return

	if ll_Row > 0 then
		Setnull(ll_ctx_id)
		gnv_appeondb.of_startqueue( )
			SELECT COUNT(*)
			  INTO :ll_rnt
			  FROM ctx_contacts
			 WHERE facility_id = :ll_facility_id;
		
			Select top 1 ctx_id Into :ll_ctx_id From ctx_basic_info where app_facility = :ll_facility_id  ;
		gnv_appeondb.of_commitqueue( )
		
		if ll_rnt > 0 then
			Messagebox("Delete Company", "Can't delete the Company. The Company is referenced by some contact. ")
			Return
		END IF
		
		If ll_ctx_id < 0 Then //using by CTX template
			Select template_name into :ls_template_name from ctx_templates_info Where ctx_id = :ll_ctx_id;
			Messagebox("Delete contact", "Can't delete the contact. The contact person is referenced by the contract template '" + String(ls_template_name) + "'.")
			Return 
		End If
		
		If ll_ctx_id > 0 Then
			Messagebox("Delete contact", "Can't delete the contact. The contact person is referenced by the contract #" + String(ll_ctx_id) + ".")
			Return	
		End If
					
		gnv_appeondb.of_startqueue( )
		Delete FROM app_facility WHERE facility_id = :ll_facility_id;
		delete from app_facility_group_access where facility_id = :ll_facility_id;	//delete group access - jervis 12.02.2010
		Commit;
		gnv_appeondb.of_commitqueue( )

		tab_1.Tabpage_details.dw_facility_detail.Reset()
		tab_1.Tabpage_details.dw_contact_master.Reset()
		tab_1.Tabpage_details.dw_master.Reset()
		tab_1.Tabpage_details.dw_1.Reset()
		
		if lb_IsTab_1 then
			tab_1.tabpage_contact_search.dw_facility_search.DeleteRow(ll_Row)
			ll_Count = tab_1.tabpage_contact_search.dw_facility_search.RowCount()
			if ll_Row <= ll_Count then
				tab_1.tabpage_contact_search.dw_facility_search.SetRow(ll_Row)
				tab_1.tabpage_contact_search.dw_facility_search.Event RowFocusChanged(ll_Row)
			elseif ll_Count > 0 then
				tab_1.tabpage_contact_search.dw_facility_search.SetRow(ll_Count)
				tab_1.tabpage_contact_search.dw_facility_search.Event RowFocusChanged(ll_Count)
			end if
		else
			Parent.event dynamic ue_refurbish()
		end if
	end if

elseif li_CurrDw = 2 then
	if MessageBox('Confirm Delete','Are you sure you want to delete the contact? ',Question!,YesNo!,2) <> 1 then return
	if ll_Row > 0 then
		/* 
		SELECT COUNT(*) 
		  INTO :ll_rnt
		  FROM ctx_contract_contacts
		 WHERE contact_id = :ll_contact_id;
		 */
		Setnull( ll_ctx_id )
		Select Top 1 ctx_id Into :ll_ctx_id From ctx_contract_contacts Where contact_id = :ll_contact_id;

		If ll_ctx_id < 0 Then	//using by CTX Template
			Select template_name into :ls_template_name from ctx_templates_info Where ctx_id = :ll_ctx_id;
			Messagebox("Delete contact", "Can't delete the contact. The contact person is referenced by the contract template '" + String(ls_template_name) + "'.")
			Return 
		End If
		
		if ll_ctx_id > 0 Then
//			Messagebox("Delete contact", "Can't delete the contact. The contact person is referenced by the contract " + String(ll_ctx_id) + ".")
			If Messagebox("Delete contact", "Can't delete the contact. The contact person is referenced by the contract #" + String(ll_ctx_id) + ".~r~rDo you want to open the Contract Contact Batch Update window?", question!, yesno! ) = 1  Then
				If isvalid( gw_contract ) Then
					openwithparm( w_contract_contact_batchreplace, string( ll_contact_id ), gw_contract )
					close( parent )
					return
				ElseIf Isvalid( w_mdi ) Then
					openwithparm( w_contract_contact_batchreplace, string( ll_contact_id ), w_mdi )
					close( parent )
					return
				End If
			End If
			Return			
		END IF
		
		gnv_appeondb.of_startqueue( )
		Delete FROM ctx_contacts_numbers WHERE contact_id = :ll_contact_id;
		Delete FROM ctx_contacts WHERE contact_id = :ll_contact_id;
		Commit;
		gnv_appeondb.of_commitqueue( )
		
		if lb_IsTab_1 then
			tab_1.tabpage_contact_search.dw_search.DeleteRow(ll_Row)
		else
			//////////////////////////Refresh tabpage_contact_search//////////////////////
			tab_1.Tabpage_details.dw_facility_detail.Event pfc_Retrieve()
	
			ll_facility_id = tab_1.of_Get_facility_id()
			Parent.event dynamic ue_refurbish()
			
			if tab_1.tabpage_contact_search.dw_facility_search.Visible then
				ll_Count = tab_1.tabpage_contact_search.dw_facility_search.RowCount()
				for ll_Cycle = 1 to ll_Count
					ll_Find = tab_1.tabpage_contact_search.dw_facility_search.Find("facility_id=" + String(ll_facility_id),1,ll_Count)
					if ll_Find > 0 then
						tab_1.tabpage_contact_search.dw_facility_search.Event RowFocusChanged(ll_Find)
						exit
					end if
				next
			end if
			//////////////////////////////////////////////////////////////////////////////
		end if
	end if
elseif li_CurrDw = 3 then
	ll_Row = tab_1.Tabpage_details.dw_1.GetRow()
	if ll_Row > 0 then
		if MessageBox('Confirm Delete','Are you sure you want to delete the via? ',Question!,YesNo!,2) <> 1 then return
		tab_1.Tabpage_details.dw_1.deleterow(ll_Row)
		cb_save.Event Clicked()
	end if
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.03.2007 By: Jack 
//$<reason> Fix a defect.
parent.event pfc_endtran(1)
//---------------------------- APPEON END ----------------------------

end event

type cb_add from commandbutton within w_contract_contact
integer x = 2985
integer y = 12
integer width = 238
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Integer	li_CurrDw
long		ll_Row,ll_RtnVal
long 		ll_Phone,ll_Email
String	ls_FirstName,ls_LastName
long ll_country	
long		ll_facility_id,ll_CurrRow,ll_contact_id
long		ll_Companyid,ll_Contactid,ll_Count,ll_Cycle,ll_Find
dwobject	ldw_Ojb

//long		li_MaxFac_id
Boolean	lb_SelectDetail = false
Boolean	lb_RefreshFlag = false

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-04-19 By: Wu ZhiJun
//$<reason> Fix a bug
Integer		li_msg
Integer		li_rc
String		ls_ComName
Powerobject lpo_updatearray[]

SetPointer(HourGlass!)
tab_1.Tabpage_details.dw_facility_detail.AcceptText()
ll_Row = tab_1.Tabpage_details.dw_facility_detail.GetRow()
if ll_Row > 0 then
	ls_ComName = tab_1.Tabpage_details.dw_facility_detail.GetItemString(ll_Row,'facility_name')
	if IsNull(ls_ComName) or Trim(ls_ComName) = '' then
		if tab_1.SelectedTab = 1 then
			tab_1.Tabpage_details.dw_facility_detail.Reset()
		else
			MessageBox(gnv_app.iapp_object.DisplayName,'Organization Name is a required column.')
			if tab_1.SelectedTab = 3 then
				Parent.event dynamic ue_select_details_tab()
			end if
			tab_1.Tabpage_details.dw_facility_detail.SetColumn('facility_name')
			tab_1.Tabpage_details.dw_facility_detail.SetFocus()
			return
		end if
	end if
end if
SetPointer(HourGlass!)
tab_1.Tabpage_details.dw_master.AcceptText()
ll_Row = tab_1.Tabpage_details.dw_master.GetRow()
if ll_Row > 0 then
	tab_1.Tabpage_details.dw_master.AcceptText()
	ls_FirstName = tab_1.Tabpage_details.dw_master.GetItemString(ll_Row,'first_name')
	if IsNull(ls_FirstName) or Trim(ls_FirstName) = '' then
		if tab_1.SelectedTab = 1 then
			tab_1.Tabpage_details.dw_master.Reset()
		else
			MessageBox(gnv_app.iapp_object.DisplayName,'First Name is required.')
			if tab_1.SelectedTab = 3 then
				Parent.event dynamic ue_select_details_tab()
			end if
			tab_1.Tabpage_details.dw_master.SetColumn('first_name')
			tab_1.Tabpage_details.dw_master.SetFocus()
			return
		end if
	end if
end if
SetPointer(HourGlass!)
ll_Row = tab_1.Tabpage_details.dw_master.GetRow()
if ll_Row > 0 then
	ls_LastName = tab_1.Tabpage_details.dw_master.GetItemString(ll_Row,'last_name')
	if IsNull(ls_LastName) or Trim(ls_LastName) = '' then
		if tab_1.SelectedTab = 1 then
			tab_1.Tabpage_details.dw_master.Reset()
		else
			MessageBox(gnv_app.iapp_object.DisplayName,'Last Name is required.')
			if tab_1.SelectedTab = 3 then
				Parent.event dynamic ue_select_details_tab()
			end if
			tab_1.Tabpage_details.dw_master.SetColumn('last_name')
			tab_1.Tabpage_details.dw_master.SetFocus()
			return
		end if
	end if
end if

//Start code by jervis 02.11.2009
//Auto save when add new company or contact
/*
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = Parent.Control
End If

li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc < 0 Then
	return
ElseIf li_rc > 0 Then
	li_msg = MessageBox (gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case li_msg
		Case 1
			if Parent.Event pfc_save() < 0 then
				return
			else
				lb_RefreshFlag = true
			end if
		Case 2
			lb_RefreshFlag = true
		Case 3
			return
	End Choose
End If
*/

ll_RtnVal = Parent.Event pfc_Save()
if ll_RtnVal < 0 then Return

if ll_RtnVal > 0 then lb_RefreshFlag = true
//End code by jervis 02.11.2009
//--------------------------- APPEON END -----------------------------

Parent.Setredraw( false)
SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////
if tab_1.SelectedTab = 1 then
	if tab_1.tabpage_contact_search.ib_IsCompany then
		li_CurrDw = 1
	else
		li_CurrDw = 2
	end if
	
	if li_CurrDw = 2 then
		if tab_1.tabpage_contact_search.dw_facility_search.RowCount() > 0 then
			ll_CurrRow = tab_1.tabpage_contact_search.dw_facility_search.GetRow()
			tab_1.tabpage_contact_search.dw_facility_search.Event DoubleClicked(10,10,ll_CurrRow,ldw_Ojb)
		elseif tab_1.tabpage_contact_search.dw_search.RowCount() > 0 then
			ll_CurrRow = tab_1.tabpage_contact_search.dw_search.GetRow()
			tab_1.tabpage_contact_search.dw_search.Event DoubleClicked(10,10,ll_CurrRow,ldw_Ojb)
		else
//			SELECT Max(facility_id)
//			  INTO :li_MaxFac_id
//			  FROM app_facility;
			
//			if IsNull(li_MaxFac_id) then
//				li_CurrDw = 1
//			else
//				tab_1.FUNCTION DYNAMIC of_set_facility_id(li_MaxFac_id)
//			end if
			
			li_CurrDw = 1
			Parent.event dynamic ue_select_details_tab()
		end if
	else
		Parent.event dynamic ue_select_details_tab()
	end if
else
	if tab_1.SelectedTab = 3 then
		Parent.event dynamic ue_select_details_tab()
	end if
	lb_SelectDetail = true
	li_CurrDw = tab_1.Tabpage_details.FUNCTION DYNAMIC of_GetCurrentDw()
end if
/////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
if lb_RefreshFlag then
	tab_1.Tabpage_details.dw_facility_detail.Event pfc_Retrieve()
	ll_Companyid = tab_1.of_Get_facility_id()
	ll_Contactid = tab_1.of_Get_contact_id()
	Parent.event dynamic ue_refurbish()
	
	ll_Count = tab_1.tabpage_contact_search.dw_facility_search.RowCount()
	for ll_Cycle = 1 to ll_Count
		ll_Find = tab_1.tabpage_contact_search.dw_facility_search.Find("facility_id=" + String(ll_Companyid),1,ll_Count)
		if ll_Find > 0 then
			tab_1.tabpage_contact_search.dw_facility_search.ScrollToRow(ll_Find)
			tab_1.tabpage_contact_search.dw_facility_search.Event RowFocusChanged(ll_Find)
			exit
		end if
	next
	
	ll_Count = tab_1.tabpage_contact_search.dw_search.RowCount()
	for ll_Cycle = 1 to ll_Count
		ll_Find = tab_1.tabpage_contact_search.dw_search.Find("contact_id=" + String(ll_Contactid),1,ll_Count)
		if ll_Find > 0 then
			tab_1.tabpage_contact_search.dw_search.ScrollToRow(ll_Find)
			tab_1.tabpage_contact_search.dw_search.Event RowFocusChanged(ll_Find)
			exit
		end if
	next
end if
parent.Setredraw( true)
SetPointer(HourGlass!)
if li_CurrDw = 1 then
	tab_1.Tabpage_details.dw_facility_detail.Reset()
	ll_Row = tab_1.Tabpage_details.dw_facility_detail.Event pfc_InsertRow()
	tab_1.Tabpage_details.dw_facility_detail.SetRow(ll_Row)
	if is_company = "Company" then
		tab_1.Tabpage_details.dw_facility_detail.SetItem(ll_Row,'contact_type2','B')
	else
		if tab_1.tabpage_contact_search.rb_1.Checked then
			tab_1.Tabpage_details.dw_facility_detail.SetItem(ll_Row,'contact_type2','A')
		elseif tab_1.tabpage_contact_search.rb_3.Checked then
			tab_1.Tabpage_details.dw_facility_detail.SetItem(ll_Row,'contact_type2','B')
		elseif tab_1.tabpage_contact_search.rb_2.Checked then
			tab_1.Tabpage_details.dw_facility_detail.SetItem(ll_Row,'contact_type2','O')
		elseif tab_1.tabpage_contact_search.rb_4.Checked then
			tab_1.Tabpage_details.dw_facility_detail.SetItem(ll_Row,'contact_type2','B')
		end if
	end if
	
	//In the Contact window default the Country field to USA-jervis 09.10.2009
	ll_country = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Country' and code = 'US'"))
	tab_1.Tabpage_details.dw_facility_detail.SetItem(ll_Row,'country',ll_country)
	tab_1.Tabpage_details.dw_facility_detail.SetItemStatus(ll_Row,0,Primary!,NotModified!)

	tab_1.Tabpage_details.dw_facility_detail.SetItem(ll_Row,'corp_office_flag',0)
	tab_1.Tabpage_details.dw_facility_detail.SetItemStatus(ll_Row,0,Primary!,NotModified!)
	
	tab_1.Tabpage_details.dw_contact_master.Reset()
	tab_1.Tabpage_details.dw_Master.Reset()
	tab_1.Tabpage_details.dw_1.Reset()
	
	tab_1.Tabpage_details.dw_facility_detail.SetFocus()
	tab_1.Tabpage_details.dw_facility_detail.SetColumn('facility_name')
	
	//Cancel readonly setting -- jervis 12.02.2010
	tab_1.tabpage_details.dw_facility_detail.Modify("datawindow.readonly = No")
	tab_1.Tabpage_details.dw_master.Modify("datawindow.readonly = No")
	tab_1.Tabpage_details.dw_1.Modify("datawindow.readonly = No")
	tab_1.is_access = 'F' //jervis 12.03.2010
	tab_1.tabpage_access.enabled = false 
	
elseif li_CurrDw = 2 then
	if lb_SelectDetail then
		ll_Row = tab_1.Tabpage_details.dw_facility_detail.GetRow()
		if ll_Row > 0 then
			ll_facility_id = tab_1.Tabpage_details.dw_facility_detail.GetItemNumber(ll_Row,'facility_id')
			if Not f_validstr(String(ll_facility_id)) then
				//Save the company information
				tab_1.Tabpage_details.dw_facility_detail.AcceptText()
				Parent.Event Pfc_save()
				tab_1.Tabpage_details.dw_facility_detail.Event pfc_Retrieve()
				Parent.event dynamic ue_refurbish()
			end if
		else
			MessageBox(gnv_app.iapp_object.DisplayName,'You need to Select or Add a Company before you can Add Contact information.')
			return
		end if
	end if
	
	//Add group access -- jervis 12.02.2010
	if tab_1.is_access <> 'F' then 
		MessageBox("Add","You do not have permission to add contacts.")
		return
	end if
	tab_1.Tabpage_details.dw_master.reset( )
	tab_1.Tabpage_details.dw_1.reset( )
	
	ll_Row = tab_1.Tabpage_details.dw_master.Event pfc_InsertRow()
	tab_1.Tabpage_details.dw_master.SetRow(ll_Row)
	
	tab_1.Tabpage_details.dw_1.event pfc_insertrow( )
	tab_1.Tabpage_details.dw_1.event pfc_insertrow( )
	
	ll_Phone = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact VIA' and code = 'PHONE'"))
	ll_Email = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact VIA' and code = 'EMAIL'"))
	
	tab_1.Tabpage_details.dw_1.SetItem(1,'via',ll_Phone)  //Set to PHONE
	tab_1.Tabpage_details.dw_1.SetItem(2,'via',ll_Email)  //Set to EMAIL
	tab_1.Tabpage_details.dw_1.SetRow(1)
	tab_1.Tabpage_details.dw_1.SetColumn('phone')
	
	tab_1.Tabpage_details.dw_1.SetItemStatus(1,0,Primary!,NotModified!)
	tab_1.Tabpage_details.dw_1.SetItemStatus(2,0,Primary!,NotModified!)
	
	tab_1.Tabpage_details.dw_master.SetFocus()
	tab_1.Tabpage_details.dw_master.SetColumn('first_name')
elseif li_CurrDw = 3 then
	ll_Row = tab_1.Tabpage_details.dw_Master.GetRow()
	if ll_Row <= 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,'You need to Select or Add a contact before you can Add Via information.')
		return
	end if
	//Readonly - jervis 11.25.2010
	if tab_1.is_access <> 'F' then
		MessageBox("Add","You do not have permission to add contacts.")
		return 
	end if
	tab_1.Tabpage_details.dw_1.Event pfc_AddRow( )
end if

SetPointer(Arrow!)

end event

type cb_save from commandbutton within w_contract_contact
integer x = 3470
integer y = 12
integer width = 238
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer	li_Rtn
String	ls_ComName,ls_FirstName,ls_LastName
long		ll_Row
long		ll_Companyid,ll_Contactid,ll_Cycle,ll_Count,ll_Find

tab_1.Tabpage_details.dw_facility_detail.AcceptText()
tab_1.Tabpage_details.dw_contact_master.AcceptText()
tab_1.Tabpage_details.dw_master.AcceptText()
tab_1.Tabpage_details.dw_1.AcceptText()

ll_Row = tab_1.Tabpage_details.dw_facility_detail.GetRow()
if ll_Row > 0 then
	ls_ComName = tab_1.Tabpage_details.dw_facility_detail.GetItemString(ll_Row,'facility_name')
	
	//Begin - Added By Mark Lee 06/14/12
	dwitemstatus	l_status
	l_status = tab_1.Tabpage_details.dw_facility_detail.GetItemStatus(ll_Row,'facility_name',Primary!)
	If l_status = DataModified! Then
		lbn_datamodify  = True
	End If
	//End - Added By Mark Lee 06/14/12

	if IsNull(ls_ComName) or Trim(ls_ComName) = '' then
		if tab_1.SelectedTab = 1 then
			tab_1.Tabpage_details.dw_facility_detail.Reset()
		else
			MessageBox(gnv_app.iapp_object.DisplayName,'Company Name can not be NULL.')
			if tab_1.SelectedTab = 3 then
				Parent.event dynamic ue_select_details_tab()
			end if
			tab_1.Tabpage_details.dw_facility_detail.SetColumn('facility_name')
			tab_1.Tabpage_details.dw_facility_detail.SetFocus()
		end if
		return
	end if
end if

ll_Row = tab_1.Tabpage_details.dw_master.GetRow()
if ll_Row > 0 then
	ls_FirstName = tab_1.Tabpage_details.dw_master.GetItemString(ll_Row,'first_name')
	if IsNull(ls_FirstName) or Trim(ls_FirstName) = '' then
		if tab_1.SelectedTab = 1 then
			tab_1.Tabpage_details.dw_master.Reset()
			tab_1.Tabpage_details.dw_1.Reset()
		else
			MessageBox(gnv_app.iapp_object.DisplayName,'First Name can not be NULL.')
			if tab_1.SelectedTab = 3 then
				Parent.event dynamic ue_select_details_tab()
			end if
			tab_1.Tabpage_details.dw_master.SetColumn('first_name')
			tab_1.Tabpage_details.dw_master.SetFocus()
		end if
		return
	end if
end if

ll_Row = tab_1.Tabpage_details.dw_master.GetRow()
if ll_Row > 0 then	
	ls_LastName = tab_1.Tabpage_details.dw_master.GetItemString(ll_Row,'last_name')
	if IsNull(ls_LastName) or Trim(ls_LastName) = '' then
		if tab_1.SelectedTab = 1 then
			tab_1.Tabpage_details.dw_master.Reset()
			tab_1.Tabpage_details.dw_1.Reset()
		else
			MessageBox(gnv_app.iapp_object.DisplayName,'Last Name can not be NULL.')
			if tab_1.SelectedTab = 3 then
				Parent.event dynamic ue_select_details_tab()
			end if
			tab_1.Tabpage_details.dw_master.SetColumn('last_name')
			tab_1.Tabpage_details.dw_master.SetFocus()
		end if
		return
	end if
end if

li_Rtn = Parent.Event Pfc_save()

if li_Rtn <= 0 then return

if tab_1.Selectedtab = 2 or tab_1.Selectedtab = 3 and tab_1.Tabpage_details.ib_IsValid then
	tab_1.Tabpage_details.dw_facility_detail.Event pfc_Retrieve()
	
	ll_Companyid = tab_1.of_Get_facility_id()
	ll_Contactid = tab_1.of_Get_contact_id()
	Parent.event dynamic ue_refurbish()
	
	ll_Count = tab_1.tabpage_contact_search.dw_facility_search.RowCount()
	//for ll_Cycle = 1 to ll_Count //Commented By Ken.Guo 11/20/2012. Replaced with 'If ll_Count > 0 Then'
	If ll_Count > 0 Then
		ll_Find = tab_1.tabpage_contact_search.dw_facility_search.Find("facility_id=" + String(ll_Companyid),1,ll_Count)
		if ll_Find > 0 then
			tab_1.tabpage_contact_search.dw_facility_search.ScrollToRow(ll_Find)
			tab_1.tabpage_contact_search.dw_facility_search.Event RowFocusChanged(ll_Find)
			//exit
		end if
	//next
	End If
	
	ll_Count = tab_1.tabpage_contact_search.dw_search.RowCount()
	//for ll_Cycle = 1 to ll_Count //Commented By Ken.Guo 11/20/2012. Replaced with 'If ll_Count > 0 Then'
	If ll_Count > 0 Then
		ll_Find = tab_1.tabpage_contact_search.dw_search.Find("contact_id=" + String(ll_Contactid),1,ll_Count)
		if ll_Find > 0 then
			tab_1.tabpage_contact_search.dw_search.ScrollToRow(ll_Find)
			tab_1.tabpage_contact_search.dw_search.Event RowFocusChanged(ll_Find)
			//exit
		end if
	//next
	End If
end if

//Refresh contract contact data - jervis 07.31.2010
if istr_pass.s_string = "EXTERNAL" or istr_pass.s_string = "INTERNAL" and isvalid(istr_pass.s_u_dw) then
	istr_pass.s_u_dw.SetRedraw( false)
	istr_pass.s_u_dw.event pfc_update(true,true) //jervis 03.03.2011
	istr_pass.s_u_dw.event pfc_retrieve()
	istr_pass.s_u_dw.SetRedraw( true)
end if
end event

type cb_select from commandbutton within w_contract_contact
integer x = 2478
integer y = 12
integer width = 238
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;long 		ll_company_id,ll_contact_id,ll_Temp
long		ll_Row,ll_Cycle,ll_Count,ll_Selected,ll_SelRow
String	ls_Name
Boolean	lb_IsSelected
str_contact	lstr_contact
//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-04-18 By: Wu ZhiJun
//$<reason> Fix a bug
Integer		li_msg
Integer		li_rc
Powerobject lpo_updatearray[]

u_tabpg_contract_detail1   lu_tab_detail1

dwItemStatus l_status	//Added By mark 03/29/12
String 		ls_CompanyName
Boolean		lb_refresh = False

If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = Parent.Control		
End If

li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc < 0 Then
	li_msg = MessageBox (gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and "  + &
					"must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", &
					exclamation!, YesNo!, 2)
	If li_msg = 1 Then
		ib_disableclosequery = true
		Close(Parent)
	End If
	return
//Start code by jervis 02.11.2009
//Auto save when select and return
end if
/*
ElseIf li_rc > 0 Then
	li_msg = MessageBox (gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes and select the record?", exclamation!, YesNoCancel!, 1)
	Choose Case li_msg
		Case 1
			Parent.Event pfc_save()
		Case 2
			ib_disableclosequery = true
			Close(Parent)
			return
		Case 3
			return
	End Choose
End If
*/
// for refresh dddw company_name  column
//Begin - Added By Mark Lee 06/14/12
If is_company = 'Select_Company'  Or  is_company = 'Dotdd_Company' Then
		ll_Row = tab_1.tabpage_contact_search.dw_facility_search.getrow()
		if ll_Row > 0 then
			l_status = tab_1.Tabpage_details.dw_facility_detail.GetItemStatus(ll_Row,'facility_name',Primary!)
			If l_status = DataModified! Or lbn_datamodify = true Then
				lb_refresh  = True
			End If
		End if 
End if 
//End - Added By Mark Lee 06/14/12
if Parent.Event pfc_save() < 0 then return
//End code By Jervis 02.11.2009
//--------------------------- APPEON END -----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.29.2007 By: WuZhiJun
//$<reason> Fix a defect.
If is_company = 'Company' Then
	ll_Row = tab_1.tabpage_contact_search.dw_facility_search.getrow()
	if tab_1.selectedtab = 1 and ll_Row > 0 then
		ll_company_id = tab_1.tabpage_contact_search.dw_facility_search.getitemnumber(ll_Row,'facility_id')
		
		ll_Row = tab_1.Tabpage_details.dw_facility_detail.GetRow()
		if ll_Row > 0 then
			ls_Name = tab_1.Tabpage_details.dw_facility_detail.GetItemString(ll_Row,'facility_name')
			if IsNull(ls_Name) then
				ib_disableclosequery = true
			end if
		end if
	else
		ll_company_id = tab_1.Function Dynamic of_Get_facility_id()
	end if
	//Added By mark 03/29/12  // for refresh dddw company_name  column
	If  lb_refresh  = True Then
		// use parent event for update dddw column values
		istr_pass.s_u_dw.Function Dynamic of_set_ib_retrieved_dddw(False)
		istr_pass.s_u_dw.dynamic ue_populatedddws()
	End If 
		
	closewithreturn(Parent,ll_company_id)
//Begin -->Added By mark 03/29/12 
ElseIf is_company = 'Select_Company' or is_company = 'Dotdd_Company' Then
		ll_Row = tab_1.tabpage_contact_search.dw_facility_search.getrow()
		if ll_Row > 0 then
			ll_company_id = tab_1.tabpage_contact_search.dw_facility_search.getitemnumber(ll_Row,'facility_id')
			
			ll_Row = tab_1.Tabpage_details.dw_facility_detail.GetRow()
			if ll_Row > 0 then
				ls_Name = tab_1.Tabpage_details.dw_facility_detail.GetItemString(ll_Row,'facility_name')
				if IsNull(ls_Name) then
					ib_disableclosequery = true
				end if
			end if
		Else
			ll_company_id = tab_1.Function Dynamic of_Get_facility_id()
		end if
		If  lb_refresh  = True Then
			// use parent event for update dddw column values
			istr_pass.s_u_dw.Function Dynamic of_set_ib_retrieved_dddw(False)
			istr_pass.s_u_dw.event dynamic ue_populatedddws()
		End If 
		closewithreturn(Parent,ll_company_id)	
//End -->Added By mark 03/29/12 
Elseif is_company = 'Select_New_Contact' Then //added by gavins 20121228
	if tab_1.selectedtab = 2 then
		ll_Row = tab_1.Tabpage_details.dw_Master.GetRow()
		if ll_Row > 0 then
			ll_contact_id = tab_1.Tabpage_details.dw_Master.GetItemNumber(ll_Row,'contact_id')
			lstr_contact.as_last_name =   tab_1.Tabpage_details.dw_Master.object.last_name[ll_Row]
			lstr_contact.as_first_name =  tab_1.Tabpage_details.dw_Master.object.first_name[ll_Row]
			lstr_contact.as_middle_name =  tab_1.Tabpage_details.dw_Master.object.middle_name[ll_Row]
			lstr_contact.al_contact_id =   tab_1.Tabpage_details.dw_Master.object.contact_id[ll_Row] 
			lstr_contact.al_contact_type =  tab_1.Tabpage_details.dw_Master.object.contact_type[ll_Row] 
			lstr_contact.as_user_id =   tab_1.Tabpage_details.dw_Master.object.user_d[ll_Row] 
			lstr_contact.as_phone_number =  tab_1.Tabpage_details.dw_Master.object.contact_phone[ll_Row]
			lstr_contact.as_contact_title =  tab_1.Tabpage_details.dw_Master.object.contact_title[ll_Row] 
			lstr_contact.al_contact_department =   tab_1.Tabpage_details.dw_Master.object.contact_department[ll_Row] 
			lstr_contact.as_email =   tab_1.Tabpage_details.dw_Master.object.contact_email[ll_Row] 
			if f_validstr(String(ll_contact_id)) then
				tab_1.tabpage_contact_search.rb_6.Checked = true
				tab_1.tabpage_contact_search.rb_6.Event Clicked()
				tab_1.tabpage_contact_search.rb_4.Checked = true
				tab_1.tabpage_contact_search.rb_4.Event Clicked()
				ll_Count = tab_1.tabpage_contact_search.dw_search.RowCount()
				for ll_Cycle = 1 to ll_Count
					ll_Temp = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'contact_id')
					if ll_Temp = ll_contact_id then
						tab_1.tabpage_contact_search.dw_search.SetItem(ll_Cycle,'selected',1)
						tab_1.tabpage_contact_search.dw_search.AcceptText()
						exit
					end if
				next
			else
				li_msg = MessageBox(gnv_app.iapp_object.DisplayName,'You had open a new record,Without saving changes?~r~n~r~nClick yes to close the window and do not save data.~r~nClick No to entry data.',Exclamation!,YesNo!)
				if li_msg = 1 then
					Close(Parent)
				end if
				return
			end if
		end if
	elseif tab_1.selectedtab = 1 then
		ll_Count = tab_1.tabpage_contact_search.dw_search.RowCount()
		If ll_Count = 0 Then Return
		For ll_Cycle = 1 To ll_Count
			ll_Selected = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'selected')
			if ll_Selected = 1 then li_rc ++
		Next
		If li_rc > 1 Then
			MessageBox( gnv_app.iapp_object.DisplayName, 'You can only select one contact.' )//?
			Return
		End If
		for ll_Cycle = 1 to ll_Count
			ll_Selected = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'selected')
			if ll_Selected = 1 then
				ll_contact_id = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'contact_id')
				lstr_contact.as_last_name =  tab_1.tabpage_contact_search.dw_search.object.last_name[ll_Cycle]
				lstr_contact.as_first_name =  tab_1.tabpage_contact_search.dw_search.object.first_name[ll_Cycle]
				lstr_contact.as_middle_name =  tab_1.tabpage_contact_search.dw_search.object.middle_name[ll_Cycle]
				lstr_contact.al_contact_id =  tab_1.tabpage_contact_search.dw_search.object.contact_id[ll_Cycle] 
				lstr_contact.al_contact_type =  tab_1.tabpage_contact_search.dw_search.object.contact_type[ll_Cycle] 
				lstr_contact.as_user_id =  tab_1.tabpage_contact_search.dw_search.object.user_d[ll_Cycle] 
				lstr_contact.as_phone_number =  tab_1.tabpage_contact_search.dw_search.object.contact_phone[ll_Cycle]
				lstr_contact.as_contact_title =  tab_1.tabpage_contact_search.dw_search.object.contact_title[ll_Cycle] 
				lstr_contact.al_contact_department =  tab_1.tabpage_contact_search.dw_search.object.contact_department[ll_Cycle] 
				lstr_contact.as_email =  tab_1.tabpage_contact_search.dw_search.object.contact_email[ll_Cycle] 
				
				lb_IsSelected = true
				exit
			end if
			if tab_1.tabpage_contact_search.dw_search.IsSelected(ll_Cycle) then
				ll_SelRow = ll_Cycle
			end if
		next
	
		If  Not lb_IsSelected  And ll_SelRow = 0 Then Return
		if Not lb_IsSelected then
			tab_1.tabpage_contact_search.dw_search.SetItem(ll_SelRow,'selected',1)
			ll_contact_id = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_SelRow,'contact_id')
			lstr_contact.as_last_name =  tab_1.tabpage_contact_search.dw_search.object.last_name[ll_SelRow]
			lstr_contact.as_first_name =  tab_1.tabpage_contact_search.dw_search.object.first_name[ll_SelRow]
			lstr_contact.as_middle_name =  tab_1.tabpage_contact_search.dw_search.object.middle_name[ll_SelRow]
			lstr_contact.al_contact_id =  tab_1.tabpage_contact_search.dw_search.object.contact_id[ll_SelRow] 
			lstr_contact.al_contact_type =  tab_1.tabpage_contact_search.dw_search.object.contact_type[ll_SelRow] 
			lstr_contact.as_user_id =  tab_1.tabpage_contact_search.dw_search.object.user_d[ll_SelRow] 
			lstr_contact.as_phone_number =  tab_1.tabpage_contact_search.dw_search.object.contact_phone[ll_SelRow]
			lstr_contact.as_contact_title =  tab_1.tabpage_contact_search.dw_search.object.contact_title[ll_SelRow] 
			lstr_contact.al_contact_department =  tab_1.tabpage_contact_search.dw_search.object.contact_department[ll_SelRow] 
			lstr_contact.as_email =  tab_1.tabpage_contact_search.dw_search.object.contact_email[ll_SelRow] 
		end if
	end if
	If  isvalid(istr_pass.s_u_dw) then
		ll_row =  istr_pass.s_u_dw.GetRow( )
		istr_pass.s_u_dw.SetItem( ll_row, 'contact_id',ll_contact_id )

         if   f_validstr(lstr_contact.as_middle_name) = false   Then
			istr_pass.s_u_dw.SetItem( ll_row, 'tartget',   lstr_contact.as_last_name + ','  + lstr_contact.as_first_name  )
		Else
			istr_pass.s_u_dw.SetItem( ll_row, 'tartget',   lstr_contact.as_last_name + ','  + lstr_contact.as_first_name +   ', '+ lstr_contact.as_middle_name   ) 
		End If
	
		istr_pass.s_u_dw.object.last_name[ll_row] = lstr_contact.as_last_name
		istr_pass.s_u_dw.object.first_name[ll_row] = lstr_contact.as_first_name
		istr_pass.s_u_dw.object.middle_name[ll_row] = lstr_contact.as_middle_name

		istr_pass.s_u_dw.object.contact_type[ll_row] = lstr_contact.al_contact_type
		istr_pass.s_u_dw.object.association[ll_row] = String(lstr_contact.al_contact_type)
		istr_pass.s_u_dw.object.contact_phone[ll_row] = lstr_contact.as_phone_number
		istr_pass.s_u_dw.object.user_d[ll_row] = lstr_contact.as_user_id
		istr_pass.s_u_dw.object.contact_title[ll_row] = lstr_contact.as_contact_title
		istr_pass.s_u_dw.object.contact_department[ll_row] = lstr_contact.al_contact_department
		istr_pass.s_u_dw.object.contact_email[ll_row] = lstr_contact.as_email
	End If
	Close( parent )
	
	//end
else
	if tab_1.selectedtab = 2 then
		ll_Row = tab_1.Tabpage_details.dw_Master.GetRow()
		if ll_Row > 0 then
			ll_contact_id = tab_1.Tabpage_details.dw_Master.GetItemNumber(ll_Row,'contact_id')
			if f_validstr(String(ll_contact_id)) then
				tab_1.tabpage_contact_search.rb_6.Checked = true
				tab_1.tabpage_contact_search.rb_6.Event Clicked()
				tab_1.tabpage_contact_search.rb_4.Checked = true
				tab_1.tabpage_contact_search.rb_4.Event Clicked()
				ll_Count = tab_1.tabpage_contact_search.dw_search.RowCount()
				for ll_Cycle = 1 to ll_Count
					ll_Temp = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'contact_id')
					if ll_Temp = ll_contact_id then
						tab_1.tabpage_contact_search.dw_search.SetItem(ll_Cycle,'selected',1)
						tab_1.tabpage_contact_search.dw_search.AcceptText()
						exit
					end if
				next
			else
				li_msg = MessageBox(gnv_app.iapp_object.DisplayName,'You had open a new record,Without saving changes?~r~n~r~nClick yes to close the window and do not save data.~r~nClick No to entry data.',Exclamation!,YesNo!)
				if li_msg = 1 then
					Close(Parent)
				end if
				return
			end if
		end if
	elseif tab_1.selectedtab = 1 then
		ll_Count = tab_1.tabpage_contact_search.dw_search.RowCount()
		for ll_Cycle = 1 to ll_Count
			ll_Selected = tab_1.tabpage_contact_search.dw_search.GetItemNumber(ll_Cycle,'selected')
			if ll_Selected = 1 then
				lb_IsSelected = true
				exit
			end if
			if tab_1.tabpage_contact_search.dw_search.IsSelected(ll_Cycle) then
				ll_SelRow = ll_Cycle
			end if
		next
		
		if Not lb_IsSelected then
			tab_1.tabpage_contact_search.dw_search.SetItem(ll_SelRow,'selected',1)
		end if
	end if
	
	//Refresh contract contact data - jervis 03.03.2011
	if istr_pass.s_string = "EXTERNAL" or istr_pass.s_string = "INTERNAL" and isvalid(istr_pass.s_u_dw) then
		istr_pass.s_u_dw.SetRedraw( false)
		If Not istr_pass.ab_newrecord Then //added by gavins 20121029   new record is not ctx_id
		
			lu_tab_detail1 =  istr_pass.s_u_dw.GetParent( )//added by gavins 20130409 for forbid validate message
			If IsValid( lu_tab_detail1 ) Then 
				lu_tab_detail1.ib_forbidvalidate = True
			end if
			if istr_pass.s_u_dw.event pfc_update(true,true) = 1 then		//Add by jervis 05.24.2011
				istr_pass.s_u_dw.event pfc_retrieve()
			end if
			If IsValid( lu_tab_detail1 ) Then 
				lu_tab_detail1.Post Event ue_set_forbid_validate_message( false )
			end if
		End If
		istr_pass.s_u_dw.SetRedraw( true)
	end if
	
	
	tab_1.tabpage_contact_search.cb_select.Event Clicked()
End If
//---------------------------- APPEON END ----------------------------

end event

type tab_1 from u_tab_cntx within w_contract_contact
integer x = 23
integer y = 36
integer width = 3931
integer height = 2056
integer taborder = 11
end type

