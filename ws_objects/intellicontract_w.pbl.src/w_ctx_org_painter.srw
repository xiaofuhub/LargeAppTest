$PBExportHeader$w_ctx_org_painter.srw
$PBExportComments$[intellicontract_w]Contract Organization Painter
forward
global type w_ctx_org_painter from w_response
end type
type tab_1 from u_tab_org within w_ctx_org_painter
end type
type tab_1 from u_tab_org within w_ctx_org_painter
end type
end forward

global type w_ctx_org_painter from w_response
integer width = 3890
integer height = 1984
string title = "IntelliContract Organizations"
long backcolor = 33551856
event type long ue_save ( )
event ue_new ( )
tab_1 tab_1
end type
global w_ctx_org_painter w_ctx_org_painter

type variables
str_pass istr_pass 




end variables

forward prototypes
public subroutine of_add_orgs (long al_org_id, string org_name, decimal al_status, decimal al_org_type, string as_street_1, string as_street_2, string as_street_3, string as_city, decimal as_state, string as_zip)
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


li_rc =  of_updatechecks()

choose case li_rc
	case -1 
		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "AcceptText error - Please contact Intelisoft Support", exclamation!, ok!, 1)
		return failure
	case -2
		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "UpdatesPending error - Please contact Intelisoft Support", exclamation!, ok!, 1)
		return failure
	case -3
		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Validation error - Please contact Intelisoft Support", exclamation!, ok!, 1)
		return failure
		
end choose 


if li_rc > 0 then 
			li_rc = of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case li_rc
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			If This.Event pfc_save() >= 1 Then
			else 
				return failure
			End If
		Case 2
			// do nothing reset the datawindows			
		Case 3
			// CANCEL -  Prevent the window from closing
			return success
	End Choose

else
	this.tab_1.tabpage_2.ib_retrieved = false
end if

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

this.tab_1.tabpage_2.event ue_new( )


end event

public subroutine of_add_orgs (long al_org_id, string org_name, decimal al_status, decimal al_org_type, string as_street_1, string as_street_2, string as_street_3, string as_city, decimal as_state, string as_zip);/******************************************************************************************************************
**  [PUBLIC]   : OF_ADD_orgs( /*long al_org_id*/, /*string org_name*/, /*long al_status*/, /*long al_org_type*/, /*string as_street_1*/, /*string as_street_2*/, /*string as_street_3*/, /*string as_city*/, /*string as_state*/, /*string as_zip */)
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
long ll_row

// make sure the contact does no already exsit
//istr_pass.s_u_dw.reset()

IF istr_pass.S_string = 'ORG' THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 03.29.2006 By: LiuHongXin
	//$<reason> Fix a defect.
	if IsNull(al_org_id) then return
	//---------------------------- APPEON END ----------------------------
	
	if istr_pass.s_u_dw.dataobject <> "d_org_search2" then Return //Add by Evan 12/10/2008
	
	if istr_pass.s_u_dw.Find( "ORG_id = " + string(  al_org_id ), 1, istr_pass.s_u_dw.rowcount()) < 1 then
		ll_row = istr_pass.s_u_dw.insertrow(0)
		istr_pass.s_u_dw.object.ctx_orgs_contact_org_id[ll_row] = al_org_id
		istr_pass.s_u_dw.object.org_name[ll_row] = org_name
		istr_pass.s_u_dw.object.ctx_id[ll_row] = long(istr_pass.S_long[1])
		istr_pass.s_u_dw.groupcalc( )
	end if
ELSE
END IF
end subroutine

on w_ctx_org_painter.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ctx_org_painter.destroy
call super::destroy
destroy(this.tab_1)
end on

event pfc_postupdate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  
//	pfc_postupdate
//
//	Arguments:  none
//
//	Returns:  integer 
//	 1 = success
//	-1 = fail
//
//	Description:
//	Perform Post Update process. 
//	i.e. Reset the datawindow update flags on a successful save.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Redirected to the Logical Unit of Work Service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
powerobject lpo[]

lpo = this.control

// Make sure there is something to take action on.
If UpperBound(lpo) = 0 Then Return NO_ACTION

// Let Logical Unit of Work Service perform the functionality (create if necessary).
If IsNull(inv_luw) Or Not IsValid (inv_luw) Then of_SetLogicalUnitofWork(True)
If IsValid(inv_luw) THen
	if inv_luw.of_PostUpdate(lpo) = success then
		this.tab_1.tabpage_2.ib_retrieved = false
		return success
	end if
End If

Return -1
end event

event pfc_preopen;call super::pfc_preopen;
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
**------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

istr_pass = message.powerobjectparm 

this.tab_1.tabpage_2.enabled = false
//w_contract.title =
end event

type tab_1 from u_tab_org within w_ctx_org_painter
integer x = 55
integer y = 52
integer width = 3758
integer height = 1780
integer taborder = 10
end type

