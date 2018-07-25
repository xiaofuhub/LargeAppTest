$PBExportHeader$n_cst_dwsrv_linkage.sru
$PBExportComments$Extension DataWindow Linkage service
forward
global type n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
end type
end forward

global type n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
end type
global n_cst_dwsrv_linkage n_cst_dwsrv_linkage

forward prototypes
protected function integer of_retrievedetails (long al_row)
end prototypes

protected function integer of_retrievedetails (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RetrieveDetails
//
//	Access:   		protected
//
//	Arguments:
//   al_row:		The current row of the master datawindow
//
//	Returns:   		Integer
// 					1 if it succeeds and -1 if an error occurs.
//
//	Description:  Retrieves detail datawindows based on current row
//					  values in the detail's master.
//
//	  *Note:	This function is not typically called by the developer.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Corrected code to look at master datawindow when checking for row
//				status of new! or newmodified!.
// 5.0.03 Handle comparisons between any variables casted to different datatypes.
// 6.0.01 Capture the return code of the PowerScript retrieve into a long type.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Integer	li_numlinks
Integer	li_i
Integer	li_rc
Long		ll_rc
Any		la_args[20]
Any		la_detail
Boolean	lb_performretrieve=False

// Operation is not valid for the root datawindow.
If Of_IsRoot() Then Return FAILURE

// Verify that master has started linkage service.
If IsNull(idw_master.inv_Linkage) Or &
	Not IsValid(idw_master.inv_Linkage) Then Return FAILURE

// Verify the row.
If IsNull(al_row) or al_row<=0 Then Return FAILURE

// No need to attempt a Retrieve if this is a new row.
If idw_master.GetItemStatus (al_row, 0, Primary!) = New! &
	or idw_master.GetItemStatus (al_row, 0, Primary!) = NewModified! Then
	// If the requestor's or row is new, then reset the rows.
	idw_Requestor.inv_Linkage.of_Reset()
	Return 1
End If

// Create array that contains the Retrieve arguments.
li_numlinks = UpperBound ( inv_linkargs.is_mastercolarg )
For li_i = 1 to li_numlinks
	// Get the data value from the master.
	la_args[li_i] = idw_master.inv_Linkage.of_GetItemAny( &
										al_row, inv_linkargs.is_mastercolarg[li_i])

	// Determine if the data is already in sync; if not set lb_performretrieve=True.
	If Not lb_performretrieve Then
		If idw_requestor.RowCount()=0 Then 
			lb_performretrieve = True
		ElseIf idw_requestor.ModifiedCount() > 0 or idw_requestor.DeletedCount() > 0 Then
			lb_performretrieve = True
		Else
			la_detail = idw_requestor.inv_Linkage.of_GetItemAny( &
									1, inv_linkargs.is_detailcolarg[li_i] ) 
								
			// Handle comparisons between any variables casted to different datatypes.								
			If IsNull(la_args[li_i]) or IsNull(la_detail) Then
				lb_performretrieve = True			
			ElseIf la_args[li_i] <> la_detail Then 
				lb_performretrieve = True
			End If
		End If 
	End If
Next 

// Prevents re-retrieve if data is already in sync.
// start code change --- 11.22.2005 MSKINNER
// sometimes the retieve is "in sync" when it is not - just retrieve the data always
If Not lb_performretrieve Then 
//	Return 1
End If
// start code change --- 11.22.2005 MSKINNER
// This is a generic retrieve that will handle up thru 20 arguments.
ll_rc = idw_Requestor.Retrieve ( &
				la_args[1],  la_args[2],  la_args[3],  la_args[4],  la_args[5], &
				la_args[6],  la_args[7],  la_args[8],  la_args[9],  la_args[10], &
				la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], &
				la_args[16], la_args[17], la_args[18], la_args[19], la_args[20] ) 

If ll_rc >= 0 Then 
	// Notify of rows changed.
	idw_Requestor.Event pfc_rowchanged ( ) 
	If ll_rc >0 Then li_rc = 1 Else li_rc = 0
Else
	li_rc = ll_rc
End If

Return li_rc
end function

on n_cst_dwsrv_linkage.create
call super::create
end on

on n_cst_dwsrv_linkage.destroy
call super::destroy
end on

