$PBExportHeader$w_facility_setup.srw
forward
global type w_facility_setup from w_response
end type
type uo_facility from pfc_cst_u_facility_setup within w_facility_setup
end type
end forward

global type w_facility_setup from w_response
integer x = 14
integer y = 144
integer width = 4430
integer height = 2172
string title = "Facility Setup"
long backcolor = 33551856
uo_facility uo_facility
end type
global w_facility_setup w_facility_setup

type variables
string is_openfrom = ""  //maha 04.02.2014
end variables

on w_facility_setup.create
int iCurrent
call super::create
this.uo_facility=create uo_facility
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_facility
end on

on w_facility_setup.destroy
call super::destroy
destroy(this.uo_facility)
end on

event open;call super::open;uo_facility.of_set_parent_window( This )
//$<add> 07.07.2008 by Andy
uo_facility.of_setlabel( )
//end add 07.07.2008
uo_facility.of_retrieve_detail()

//Start Code Change ----04.02.2014 #V14.2 maha - opened from entity setup
long ll_fac
long f

if mid(message.stringparm,1,1) = "E" then
	ll_fac = long(mid(message.stringparm,2))
	f = uo_facility.tab_facilty.tabpage_browse.dw_browse.find("facility_id = " + string(ll_fac), 1 , uo_facility.tab_facilty.tabpage_browse.dw_browse.rowcount())
	if f > 0 then 
		uo_facility.tab_facilty.tabpage_browse.dw_browse.setrow(f)
		uo_facility.tab_facilty.tabpage_browse.dw_browse.scrolltorow(f)
		uo_facility.tab_facilty.tabpage_browse.dw_browse.selectrow(0,False)
		uo_facility.tab_facilty.tabpage_browse.dw_browse.selectrow(f,true)
		uo_facility.il_facility_id = ll_fac
		uo_facility.tab_facilty.selecttab(2)
	end if
end if
//Start Code Change ----04.02.2014


	


end event

event pfc_postupdate;call super::pfc_postupdate;//integer facid
//
//facid = uo_facility.dw_detail.getitemnumber(1,"facility_id")
////set verif rules for duplicate letters maha 041801
//if uo_facility.dw_detail.getitemnumber(1,"dupeset") = 1 then
//	Update facility_ver_rules
//	set ver_ltr_doc = 1
//	where facility_id = :facid and screen_id in (7,10);
//else 
//	Update facility_ver_rules
//	set ver_ltr_doc = 0
//	where facility_id = :facid and screen_id in (7,10);
//end if
// 
// 
// 
// 
// 
 return 1
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
			If uo_facility.cb_save.Event clicked() <> -1 Then
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

type uo_facility from pfc_cst_u_facility_setup within w_facility_setup
integer width = 4416
integer height = 2080
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_facility.destroy
call pfc_cst_u_facility_setup::destroy
end on

