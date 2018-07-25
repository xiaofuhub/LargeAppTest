$PBExportHeader$n_ds.sru
$PBExportComments$Extension Datastore class
forward
global type n_ds from pfc_n_ds
end type
end forward

global type n_ds from pfc_n_ds
event ue_populate_ddws ( )
end type
global n_ds n_ds

type variables
n_cst_dssrv inv_cst_dssrv
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
Boolean		lbn_ignore_idle = True  //Added By Mark Lee 08/07/12
//---------End Added ------------------------------------------------------------------

end variables

forward prototypes
public function string of_getitem (string as_column, readonly long al_row)
public function string of_get_column_name (string as_column)
public function integer of_print (boolean ab_canceldialog, boolean ab_showprintdialog)
public subroutine of_set_idle_flag (boolean abn_idle_flag)
end prototypes

event ue_populate_ddws();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 05 Dovember 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


loNG LL_COLUMN_COUNT , LL_I
string ls_dddw_name
string ls_colname

DataWindowChild dwchild
n_ds lnds_user
//lnds_user  = create N_DS //Commected By Ken.Guo 2008-01-18, Ref object, Need not Create.

LL_COLUMN_COUNT = LONG(Object.DataWindow.Column.Count)

FOR LL_I = 1 TO LL_COLUMN_COUNT
	if Describe("#" +STRING(LL_I) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +STRING(LL_I) + ".Name")
		ls_dddw_name = Describe("#" +STRING(LL_I) + ".DDDW.Name")
		getchild( ls_colname, dwchild)	
		if gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user) <> 1 THEN 
			 RETURN 
		END IF 
	
		lnds_user.ShareData ( dwchild )

	
	end if 
NEXT

end event

public function string of_getitem (string as_column, readonly long al_row);/******************************************************************************************************************
**  [PUBLIC]   : of_getItem(/*string as_column*/, /*long al_row */)
**==================================================================================================================
**  Purpose   	: Since we are using dynamin datawindows and datastores we cannot be sure of the exact name of column.
**               This function was created to replace existing code that did a check based on the login type (master etc). 
**               This function will find the coulmn in the datastore/window that best fits it and set the value. This function may be 
**               slower. 
**==================================================================================================================
**  Arguments  : [string] AS_COULMN   The name of the column
**   	         : [long]   al_row      The row of which the data is to be set 
**==================================================================================================================
**  Returns   	: [long]     0 = Success, -1 Failure
**              
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

LONG   ll_column_count
LONG   LL_I
STRING ls_column_name

////////////////////////////////////////////////////////////////////////////////////////////////////////
// check for nulls
////////////////////////////////////////////////////////////////////////////////////////////////////////

if not f_validstr(as_column) or not f_validstr(string(al_row))  then 
	return ''
end if 

inv_cst_dssrv.of_setrequestor(this)

ll_column_count = long(this.Describe("DataWindow.Column.Count"))
FOR LL_i = 1 to ll_column_count
	// get the column name
	ls_column_name = this.Describe("#" + string(ll_i)+ ".Name")
	//if pos(ls_column_name,as_column) > 0 then 
	if ls_column_name = as_column then 
		RETURN inv_cst_dssrv.of_getItem(al_row,ls_column_name)
	end if 
next

RETURN ''
end function

public function string of_get_column_name (string as_column);/******************************************************************************************************************
**  [PUBLIC]   : of_get_column_name(/*string as_column*/, /*long al_row */)
**==================================================================================================================
**  Purpose   	: Since we are using dynamin datawindows and datastores we cannot be sure of the exact name of column.
**               This function was created to replace existing code that did a check based on the login type (master etc). 
**               This function will find the coulmn in the datastore/window that best fits it and set the value. 
**==================================================================================================================
**  Arguments  : [string] AS_COULMN   The name of the column
*
**==================================================================================================================
**  Returns   	: [long]     0 = Success, -1 Failure
**              
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date    Reason
**		maha							031306			trap for returning empty string
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

LONG   ll_column_count
//maha no longer used after 5.133 

LONG   LL_I
STRING ls_column_name
string ls_return

////////////////////////////////////////////////////////////////////////////////////////////////////////
// check for nulls
////////////////////////////////////////////////////////////////////////////////////////////////////////
//Start Code Change ---- 03.13.2006 #368 maha
if not f_validstr(as_column)   then 
	ls_return  = "*"
 
else
	inv_cst_dssrv.of_setrequestor(this)
	
	ll_column_count = long(this.Describe("DataWindow.Column.Count"))
	FOR LL_i = 1 to ll_column_count
		// get the column name
		ls_column_name = this.Describe("#" + string(ll_i)+ ".Name")
      long ll_pos
		ll_pos = PosA(ls_column_name,as_column) 
		string ls_mid_string
		if ll_pos > 0 then
			ls_mid_string = MidA(ls_column_name,ll_pos)
			if ls_mid_string = as_column then 
				ls_RETURN  = ls_column_name
			end if 
			
		end if 
	next

end if

if ls_return = '*' then
	//messagebox("of_get_column_name called from of_create_dynamic_ds","Column " + as_column + " not a valid string per f_validstr")
	ls_return = as_column
elseif ls_return = '' then
	//messagebox("of_get_column_name called from of_create_dynamic_ds","Column " + as_column + " not found in datastore object list.")
	ls_return = as_column
end if

RETURN ls_return
//End Code Change---03.03.2006
end function

public function integer of_print (boolean ab_canceldialog, boolean ab_showprintdialog);/******************************************************************************************************************
**  [PUBLIC]   : of_print
**==================================================================================================================
**  Purpose   	: To workaound the Print function with 2 arguments in a Web application (Ticket # 00033410）
**==================================================================================================================
**  Arguments : Boolean ab_canceldialog, ab_showprintdialog
**==================================================================================================================
**  Returns   	: Integer
**==================================================================================================================
**  Notes     	: The CancelDialog argument specified in the Print function will be ignored for a datastore, and no Cancel dialog will be displayed on the Web to cancel printing. 
					  The ShowPrintDialog argument specified in the Print function is unsupported and will cause the Print function failed in a Web application.
**==================================================================================================================
**  Created By	: Alfee 01.05.2012  © Appeon, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
Integer li_rtn

IF appeongetclienttype() = "PB" THEN		//PB version
	li_rtn = This.Print(ab_canceldialog, ab_showprintdialog)
ELSE												//Web version
	IF ab_showprintdialog THEN
		IF PrintSetup () <> 1 THEN RETURN -1
	END IF
	li_rtn = This.Print (ab_canceldialog)		
END IF

RETURN li_rtn

end function

public subroutine of_set_idle_flag (boolean abn_idle_flag);//====================================================================
// Function: of_set_idle_flag
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                abn_idle_flag
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 08/07/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//====================================================================
If abn_idle_flag = True Then
	lbn_ignore_idle = True 
Else
	lbn_ignore_idle = False
End If
end subroutine

on n_ds.create
call super::create
end on

on n_ds.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_cst_dssrv =  CREATE n_cst_dssrv
end event

event dberror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  dberror
//
//	Description:
//	Display messagebox that a database error has occurred.
// If appropriate delay displaying the database error until the appropriate
// Rollback has been performed.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

w_master	lw_parent
boolean 	lb_pfcsaveprocess=False
string	ls_message
string	ls_msgparm[1]
string	ls_sqlspyheading
string	ls_sqlspymessage
powerobject lpo_updaterequestor
n_cst_dberrorattrib lnv_dberrorattrib

// Construct the error message.
ls_message = "A database error has occurred.~r~n~r~n~r~n" + &
	"Database error code:  " + String (sqldbcode) + "~r~n~r~n" + &
	"Database error message:~r~n" + sqlerrtext

// Set the error attributes.
lnv_dberrorattrib.il_sqldbcode = sqldbcode
lnv_dberrorattrib.is_sqlerrtext = sqlerrtext
lnv_dberrorattrib.is_sqlsyntax = sqlsyntax
lnv_dberrorattrib.idwb_buffer = buffer
lnv_dberrorattrib.il_row = row
lnv_dberrorattrib.is_errormsg = ls_message
lnv_dberrorattrib.ipo_inerror = this

//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2011-01-21.
String ls_logtext
ls_logtext =This.ClassName() + ', Dataobject is ' + This.Dataobject + '.' + '~r~n' +  ls_message 
gnv_debug.of_output(True, ls_logtext )
//---------End Added ------------------------------------------------------------------


//If available trigger the SQLSpy service.
If IsValid(gnv_app.inv_debug) Then
	If IsValid(gnv_app.inv_debug.inv_sqlspy) Then

		//Create the heading and message for the SQLSpy.
		ls_sqlspyheading = 'DBError - ' + this.ClassName() + '(' + string(row) + ')'
		ls_sqlspymessage = "Database error code:  " + String (sqldbcode) + "~r~n" + &
			"Database error message:  " + sqlerrtext
		
		//Send the information to the service for processing.
		gnv_app.inv_debug.inv_sqlspy.of_sqlSyntax  &
			(ls_sqlspyheading, '/*** ' + ls_sqlspymessage + ' ***/')
	End If
End If


// Determine if Transaction Management is being performed by another object.
If IsValid(ipo_updaterequestor) Then
	lpo_updaterequestor = ipo_updaterequestor
Else
	// Determine if the window is in the save process. 
	This.of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) Then
		If lw_parent.TriggerEvent ("pfc_descendant") = 1 Then	
			If lw_parent.of_GetSaveStatus() Then
				lpo_updaterequestor = lw_parent
			End If
		End If
	End If
End If

If IsValid(lpo_updaterequestor) Then
	// Suppress the error message (let the UpdateRequestor display it).
	// MetaClass check, Dynamic Function Call.
	lpo_updaterequestor.Dynamic Function of_SetDBErrorMsg(lnv_dberrorattrib)
Else
	// Display the message immediately.
	If IsValid(gnv_app.inv_error) Then
		ls_msgparm[1] = ls_message
		
//		gnv_app.inv_error.of_Message ('pfc_dwdberror', ls_msgparm, &
//					gnv_app.iapp_object.DisplayName)
	Else
		
//		of_Messagebox ("pfc_dberror", gnv_app.iapp_object.DisplayName, &
//			ls_message, StopSign!, Ok!, 1)
	End If
End If

f_system_error_handler (ls_message)

return 1


end event

event retrieveend;call super::retrieveend;event ue_populate_ddws( )

//Start Code Change ---- 02.15.2006 #284 maha
//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
  /*
    of_idle_value(1)  
  */
If lbn_ignore_idle = True Then 
	of_idle_value(1)
End If
//---------End Modfiied ------------------------------------------------------------------

	
//End Code Change---02.15.2006

end event

event retrievestart;call super::retrievestart;//Start Code Change ---- 02.15.2006 #285 maha
//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
  /*
     of_idle_value(0) 
  */
If lbn_ignore_idle = True Then 
	of_idle_value(0)
End If
//---------End Modfiied ------------------------------------------------------------------
	
//End Code Change---02.15.2006
end event

event destructor;call super::destructor;if isvalid(inv_cst_dssrv) then destroy inv_cst_dssrv  //08.21.2007 By Jervis
end event

