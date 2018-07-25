$PBExportHeader$appeondatastore.sru
forward
global type appeondatastore from datastore
end type
end forward

global type appeondatastore from datastore
event resetflag pbm_dwnretrieveend
end type
global appeondatastore appeondatastore

type prototypes
Function int ConvertDWAP_J(ref blob as_data, ref str_a str_obj, ref long al_address, ref long al_len, boolean ab_blob, boolean ab_withdddw) library "EonAXNVO.dll" alias for "ConvertDWAP_J;Ansi"
Function int ConvertDWCP_J(ref str_b astr_obj, ref long al_address, ref long al_len, boolean ab_blob) library "EonAXNVO.dll" alias for "ConvertDWCP_J;Ansi"

Function int ConvertDWAJ_P(readonly string as_State, readonly blob ab_State, ref long al_address, ref long al_len, ref string strCol, ref string ls_Type, boolean ab_FullState, boolean ab_blob) library "EonAXNVO.dll" alias for "ConvertDWAJ_P;Ansi"
Function int ConvertDWCJ_P(readonly string as_State, readonly blob ab_State, ref long al_address, ref long al_len, boolean ab_Blob) library "EonAXNVO.dll" alias for "ConvertDWCJ_P;Ansi"

Function int FreeMemoryEX(ref blob ab_state, ref string as_state, long al_address, long al_len, boolean ab_blob) library "EonAXNVO.dll" alias for "FreeMemoryEX;Ansi"

Function long ConvertImageW_G(string as_file) library "EonAXNVO.dll" alias for "ConvertImageW_G;Ansi"

Function long GetLastErrorCode() library "EonAXNVO.dll"
Function long GetErrorMessage(long al_errcode,ref string as_errtext) library "EonAXNVO.dll" alias for "GetErrorMessage;Ansi"

Function long GetLastError() library "kernel32.dll"


end prototypes

type variables
private:
//Row Flag
datastore	ids_RowFlag

str_RowSet	istr_RowSet[]

//original dataobject
string	is_OriDataObject

//number of RowSet
integer	ii_SetCount = 0

//appeon services
appeonservice	inv_appeon

CONSTANT integer I_PIC_PER_ROW = 20 
//Buffer Flag
CONSTANT String S_PRIMARY = 'primary!'
CONSTANT String S_FILTER = 'filter!'
CONSTANT String S_DELETE = 'delete!'


end variables

forward prototypes
public function integer setfullstate (readonly string changes)
public function long getfullstate (ref string changes)
public function long getchanges (ref string changes)
public function integer setchanges (readonly string changes)
public function integer reset ()
private function integer of_initrowflag ()
private function integer of_getrowset (ref string as_rowset)
private function string of_gettype ()
private function integer of_modifystatus (long al_row, integer ai_column, dwbuffer adw_buffer, dwitemstatus adw_old_status, dwitemstatus adw_new_status)
private function integer of_getmatchtype (ref string as_match, boolean ab_flag)
private function integer of_savevalidation (ref string as_validation[])
public function long getrowfromrowid (long r)
public function long getrowidfromrow (long r)
private function integer of_setrowflag (string as_rowflag)
private function integer of_initrowset (integer ai_count, boolean ab_flag)
private function boolean of_isresetflag (boolean ab_flag)
private function integer of_getstatusinfo (ref str_rowinfo astr_rowinfo[], ref str_rowflag astr_rowflag[], dwbuffer adw_buffer, ref string as_state)
private function integer of_getrowflag (ref string as_rowflag)
public function long getfullstate (ref blob changes)
public function long getchanges (ref blob changes)
public function integer setchanges (readonly blob changes)
public function integer setfullstate (readonly blob changes)
public function long getrowfromrowid (long row, readonly string buffer)
public function long getrowidfromrow (long row, readonly string buffer)
private function integer of_setstatusinfo (long al_row, readonly str_rowstate astr_rowstate)
private function integer of_setstatusinfo (readonly dwbuffer adw_buffer, readonly string as_status)
private function integer of_setstatusinfo (readonly dwbuffer adw_buffer, readonly string as_state, readonly string as_data, readonly string as_rowflag, integer ai_rowsetlists[])
private function integer of_setdatainfo (readonly string as_column, readonly string as_data)
private function integer of_loadvalidation (readonly string as_validation[])
private function integer of_getstatusinfo (readonly dwbuffer adw_buffer, boolean ab_changes, ref string as_state, ref string as_data, ref string as_rowflag)
private function integer of_getrowsetlists (readonly string as_rowset, integer ai_setcount, ref integer ai_lists[])
private function integer of_getrowinfo (readonly dwbuffer adw_buffer, boolean ab_changes, ref str_rowinfo astr_rowinfo[], ref str_rowflag astr_rowflag[])
private function long of_getrowfrommapid (long al_mapid, readonly dwbuffer adw_buffer)
private function integer of_getrowflag (readonly dwbuffer adw_buffer, ref string as_rowflag)
private function long of_getmapidfromrow (long al_row, readonly dwbuffer adw_buffer)
private function string of_getitemstring (long al_row, integer ai_column, readonly dwbuffer adw_buffer, boolean ab_orig_value)
private function integer of_getdatainfo (readonly string as_column, readonly dwbuffer adw_buffer, ref string as_data)
private function integer of_getdatainfo (readonly dwbuffer adw_buffer, ref string as_data)
private function long of_findoriginalrow (long al_mapid, long al_oriid, integer ai_rowset, ref dwbuffer adw_buffer)
private function blob of_dddwblob (integer ai_dddwid[], ref string as_dddwname[], boolean ab_flag)
public function long appeongetfullstateex (ref blob changes)
public function long appeongetfullstateex (ref string changes)
public function integer appeonsetfullstateex (readonly blob changes)
public function integer appeonsetfullstateex (readonly string changes)
private function long of_getfullstate (ref string as_changes, ref blob ab_changes, boolean ab_blob, boolean ab_withdddw)
private function long of_getchanges (ref string as_changes, ref blob ab_changes, boolean ab_blob)
private subroutine of_savedddwdata (ref string arrdddwdata[])
private function integer of_setfullstate (readonly string as_changes, readonly blob ab_changes, boolean ab_blob, boolean ab_withdddw)
private function integer of_setchanges (readonly string as_changes, readonly blob ab_changes, boolean ab_blob)
private function long of_importstring (readonly powerobject adw, string as_data)
private function blob of_createblob ()
private function integer of_main_analysis (ref integer ai_dddwid[], ref string as_dddwname[])
end prototypes

event resetflag;////////////////////////////////////////////////////////////////////////////////
//	Function :  ResetFlag
//
//	Access:  Public
//
//	Arguments:		
//	long	rowcount
//
//	Returns:  
//		
//
//	Description:  
// 	Reset Flag Info,the event cannot be revert
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

//Reset Flag info
of_IsResetFlag(false)


end event

public function integer setfullstate (readonly string changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::setfullstate()
//------------------------------------------------------------------------------
// Description: 
//				Applies the contents of a DataWindow string retrieved by GetFullState to a DataWindow or DataStore. 
//				This method is used primarily in distributed applications.
//	
// Arguments: 
//		readonly	string	changes		
//	
// Returns:  integer
//				Returns -1 if an error occurs and one of the following values if it succeeds:
//
//				1  DataWindow objects match; old data and state overwritten
//				2  DataWindow objects do not match; old object, data, and state replaced
//				3  No DataWindow object associated with DataWindow control or DataStore;	
//				the DataWindow object associated with the string is used. 
//				The value of the DataObject property 	remains an  empty string
//				Null  If any argument's value is NULL in PowerBuilder the method returns
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

INTEGER	li_Ret
BLOB		lb_Changes

li_Ret = Of_SetFullState(changes, lb_Changes, FALSE, TRUE)

Return li_Ret
end function

public function long getfullstate (ref string changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getfullstate()
//------------------------------------------------------------------------------
// Description: 
// 			Retrieves the complete state of a DataWindow or DataStore as 
//				a blob. This method is used primarily in distributed 
//				applications.
//	
// Arguments: 
//		ref	string	changes		
//	
// Returns:  long
//				Returns the number of rows in the DataWindow string 
//				if it succeeds. Returns the number of rows in the 
//				DataWindow string if it succeeds -1 if an error occurs. 
//				GetFullState will return -1 if the DataWindow control 
//				or DataStore does not have a DataWindow object associated  
//				with it. If any argument value is NULL, the method returns 
//				NULL.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long 		ll_Ret
Blob lb_changes

ll_Ret = of_GetFullState(changes, lb_changes, FALSE, TRUE)

RETURN ll_Ret

end function

public function long getchanges (ref string changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getchanges()
//------------------------------------------------------------------------------
// Description: 
// 			Retrieves changes made to a DataWindow or DataStore as a string.
//				This method is used primarily in distributed applications.
//
// Arguments: 
//		ref	string	changes	
//
// Returns:  long
//				Returns the number of rows in the DataWindow change blob if it succeeds and one of the following values if it fails:
//				-1  An internal error occurred
//				-2  There is a conflict between the state of the DataWindow change blob and the state of the DataWindow from which the cookie was created; an attempt to use this blob in a SetChanges call against the DataWindow will fail
//				-3  There is a conflict between the state of the DataWindow change blob and the state of the DataWindow from which the cookie was created; but partial changes from the change blob can be applied
//				If any argument is NULL, in PowerBuilder the method returns NULL
//
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_Ret
Blob lb_Changes

ll_Ret = Of_GetChanges(changes, lb_Changes, FALSE)

RETURN ll_Ret


end function

public function integer setchanges (readonly string changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::setchanges()
//------------------------------------------------------------------------------
// Description: 
//				Applies changes captured with GetChanges to a DataWindow or DataStore. 
//				This method is used primarily in distributed applications.
//
// Arguments: 
//		readonly	string	changes		
//	
// Returns:  integer
//				Returns one of the following values:
//				1  All changes were applied
//				2  A partial update was successful; conflicting changes were discarded
//				-1  Method failed
//				-2  There is a conflict between the state of the DataWindow changestring and the state of the DataWindow
//				-3  Column specifications do not match
//
//				If any argument's value is NULL, in PowerBuilder the method returns NULL
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

INTEGER	li_Ret
BLOB		lb_Changes

li_Ret = Of_SetChanges(changes, lb_changes, FALSE)

Return li_Ret
end function

public function integer reset ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::reset()
//------------------------------------------------------------------------------
// Description: 
// 			Reset Flag Info,cannot be overridden
//	
// Arguments:(None)
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

//Reset Flag info
of_IsResetFlag(FALSE)

//call supper
RETURN SUPER::Reset()








end function

private function integer of_initrowflag ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_initrowflag()
//------------------------------------------------------------------------------
// Description: Initializes the row identifier information.  If it is initial state, 
//						sets the row identifier information for all rows.  If it is not initial 
//						state, sets the row identifier information for those that have not been 
//						set. 
//
// Arguments:(None)
//	
// Returns:  integer - 1 if success and -1 if an error occurs. 
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//	 1.0   Initial version
//==============================================================================

BOOLEAN 	bInit = TRUE
LONG 		arrRowID[], nMapID[]
LONG 		nRowFlagCount, nCount, i, j
LONG 		nMaxRowID, nMaxMapID, nDecID, nRowID

// Create ids_RowFlag
IF NOT IsValid(ids_RowFlag) THEN
	ids_RowFlag = CREATE DataStore
	ids_RowFlag.dataobject = "d_rowflag"
END IF

nRowFlagCount = ids_RowFlag.RowCount()

IF nRowFlagCount > 0 THEN		// Not Init 
	// get max rowid
	nMaxRowID = ids_RowFlag.GetItemNumber(nRowFlagCount, "rowid")
	
	// get max mapid
	nMaxMapID = ids_RowFlag.GetItemNumber(nRowFlagCount, "maxmapid")
	
	// get nDecID = Max(MapID) - Max(RowID)	
	nDecID = nMaxMapID - nMaxRowID

	// set init flag
	bInit = FALSE
END IF

// set the row identifier information for all rows
IF bInit THEN
	// primary!
	nCount = THIS.RowCount()
	FOR i = 1 TO nCount
		j++
		arrRowID[j] = SUPER::GetRowIDFromRow(i, primary!)
	NEXT
	
	// filter!
	nCount = THIS.FilteredCount()
	FOR i = 1 TO nCount
		j++
		arrRowID[j] = SUPER::GetRowIDFromRow(i, filter!)
	NEXT
	
	// delete!
	nCount = THIS.DeletedCount()
	FOR i = 1 TO nCount
		j++
		arrRowID[j] = SUPER::GetRowIDFromRow(i, delete!)
	NEXT
	
// set the row identifier information for the rows 
// that do not have identifier information set. 
ELSE
	// primary
	nCount = THIS.RowCount()
	FOR i = 1 TO nCount
		nRowID = SUPER::GetRowIDFromRow(i, primary!)
		// set the row identifier
		IF nRowID > nMaxRowID THEN
			j++
			arrRowID[j] = nRowID
			nMapID[j] = nRowID + nDecID
		END IF
	NEXT
	
	// filter
	nCount = THIS.FilteredCount()
	FOR i = 1 TO nCount
		nRowID = SUPER::GetRowIDFromRow(i, filter!)
		// set the row identifier
		IF nRowID > nMaxRowID THEN
			j++
			arrRowID[j] = nRowID
			nMapID[j] = nRowID + nDecID
		END IF
	NEXT
	
	// delete
	nCount = THIS.DeletedCount()
	FOR i = 1 TO nCount
		nRowID = SUPER::GetRowIDFromRow(i, delete!)
		// set the row identifier
		IF nRowID > nMaxRowID THEN
			j++
			arrRowID[j] = nRowID
			nMapID[j] = nRowID + nDecID
		END IF
	NEXT
END IF

IF j > 0 THEN
	ids_RowFlag.object.RowID[nRowFlagCount + 1, nRowFlagCount + j] = arrRowID[]
	IF bInit THEN
		ids_RowFlag.Object.MapID[nRowFlagCount + 1, nRowFlagCount + j] = arrRowID[]
	ELSE
		ids_RowFlag.Object.MapID[nRowFlagCount + 1,nRowFlagCount + j] = nMapID[]
	END IF
END IF

// sort RowID By ASC
ids_RowFlag.SetSort("RowID A")
ids_RowFlag.Sort()

return 1
end function

private function integer of_getrowset (ref string as_rowset);/****************************************************************************************
*
*	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
*
* =======================================================================================
*
*	<access>			: Private
*	<function> 		: of_GetRowSet
*	<description>	: Gets the string of RowSet info.
*	<arguments>		: 
*						[string] - Required. ref string as_RowSet.
*	<return>			:
*						[integer] - Returns 1 if success and -1 if error.
*
****************************************************************************************/

LONG 	i, nCount

as_RowSet = ""
nCount = UpperBound(istr_RowSet)

IF nCount = 0 THEN Return -1

FOR i = 1 TO nCount
	as_RowSet += string(istr_RowSet[i].l_SetID)+"~t"+ &
					 string(istr_RowSet[i].l_SetTS)+"~t"+ &
					 string(istr_RowSet[i].l_SetOriTs)+"~r~n"
NEXT

Return 1

end function

private function string of_gettype ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_gettype()
//------------------------------------------------------------------------------
// Description: get the type of DataWindow.
// 
//	
// Arguments:(None)
//	
// Returns:  string - return the type if if success and '' if error occurs.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

STRING strType

strType = THIS.Describe("datawindow.processing")
IF strType = "" OR strType = "?" OR strType = "!" THEN 
	Return ""
END IF

CHOOSE CASE strType
	CASE '0' to '3'
		IF Lower(THIS.Describe("datawindow.nested")) = "yes" THEN
			strType = '42'
		ELSE
			strType = '41'
		END IF
	CASE '4', '5'
		strType = '42'
	CASE ELSE
		strType = '43'
END CHOOSE

Return strType
end function

private function integer of_modifystatus (long al_row, integer ai_column, dwbuffer adw_buffer, dwitemstatus adw_old_status, dwitemstatus adw_new_status);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_ModifyStatus
//
//	Access:  Private
//
//	Arguments:		
//	long	al_row
//	integer ai_column
//	DWBuffer	adw_buffer
//	DWitemStatus	adw_old_status
//	DWItemStatus	adw_new_status
//
//	Returns: integer 
//		Returns 1 if it succeeds and -1 if an error occurs
//
//	Description:  
// Changes the modification status of a row or a column within a row
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

if adw_old_status = adw_new_status then return 0

choose case adw_old_status
	case NotModified!
		return this.SetItemStatus(al_row,ai_column,adw_buffer,adw_new_status)
	case New!
	case NewModified!
		choose case adw_new_status
			case NotModified!
				if this.SetItemStatus(al_row,ai_column,adw_buffer,DataModified!) = 1 then
					return this.SetItemStatus(al_row,ai_column,adw_buffer,adw_new_status)
				else
					return -1
				end if
			case DataModified!
				return this.SetItemStatus(al_row,ai_column,adw_buffer,adw_new_status)
			case New!
				return this.SetItemStatus(al_row,ai_column,adw_buffer,NotModified!)
		end choose
	case DataModified!
		choose case adw_new_status
			case NewModified!,NotModified!
				return this.SetItemStatus(al_row,ai_column,adw_buffer,adw_new_status)
			case New!
		end choose
	
end choose
return 1
end function

private function integer of_getmatchtype (ref string as_match, boolean ab_flag);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetMatchType
//
//	Access:  private
//
//	Arguments:		
//		ref string as_match
//		boolean Ab_Flag: 	Boolean variable. If the argument is true, the definition of the 
//								Column data type does not contain length definition; if it is false, 
//								the data type definition contains length definition. 
//	Returns:  
//		1 if success and -1 if error
//
//	Description:  
//		Gets string of Column data type of the current DataObject
//		separates the string with spaces.
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

LONG nColCount, i, nPos
STRING strMatch, strColType

//IF THIS.dataobject = "" THEN Return -1

nColCount = Long(THIS.Describe("datawindow.column.count"))

as_match = ''

// get the data type definition of every column by a loop
FOR i = 1 TO nColCount
	strColType = THIS.Describe("#" + String(i) + ".coltype")
	IF strColType = '!' OR strColType = '?' THEN Return -1
	
	// the definition of the	Column data type does not 
	// contain length definition.
	IF ab_flag THEN
		nPos = PosA(strColType, '(')
		IF nPos > 0 THEN
			strColType = LeftA(strColType, nPos -1)
		END IF
	END IF
	
	IF as_match = "" THEN
		as_match = strColType
	ELSE
		as_match += " " + strColType
	END IF
NEXT

Return 1
end function

private function integer of_savevalidation (ref string as_validation[]);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_SaveValidation
//
//	Access:  Private
//
//	Arguments:		
//	ref string as_validation[]
//
//	Returns:  
//		Returns 1 if it succeeds and -1 if an error occurs. 
//
//	Description:  
// 	Gets properties of validation into array
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
long ll_ColCount,ll_i
string ls_validation

ll_ColCount = long(this.Describe("DataWindow.column.count"))
if ll_colCount = 0 then return -1

for ll_i = 1 to ll_ColCount
	as_validation[ll_i] = ''
	ls_validation = this.Describe("#"+string(ll_i)+".Validation")
	if ls_validation = '!'  then return -1
	if ls_validation <> '?' then
		as_validation[ll_i] = ls_validation
		this.Modify("#"+string(ll_i)+".validation = ''")
	end if
next
return 1
end function

public function long getrowfromrowid (long r);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getrowfromrowid()
//------------------------------------------------------------------------------
// Description: 
//				Gets the row number of a row in a DataWindow control or DataStore 
//				object from the unique row identifier associated with that row.
//	
// Arguments: 
//		long	r		
//	
// Returns:  long
//				Returns the row number in buffer. Returns 0 if the row number is not in the current buffer and -1 if an error occurs. 
//				If any argument value is NULL, in PowerBuilder the method returns NULL
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN GetRowFromRowID(r,S_PRIMARY)
end function

public function long getrowidfromrow (long r);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getrowidfromrow()
//------------------------------------------------------------------------------
// Description: 
//				Gets the unique row identifier of a row in a DataWindow control or DataStore object 
//				from the row number associated with that row.
//	
// Arguments: 
//		long	r		
//	
// Returns:  long
//				Returns the row identifier in buffer. 
//				Returns 0 if the row identifier is not in the current buffer.
//				Returns -1 if an error occurs. 
//				If any argument value is NULL, in PowerBuilder the method returns NULL
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN GetRowIDFromRow(r,S_PRIMARY)

end function

private function integer of_setrowflag (string as_rowflag);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetRowFlag
//
//	Access:  private
//
//	Arguments:		
//	ref string as_RowFlag 
//
//	Returns:  integer
//	Returns 1 if success and -1 if error
//
//	Description:  
// Set the Row Flag info
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

LONG  		nRowID, nMapId
LONG			i, nRow, nCount, nStart

DATASTORE	ds_obj


IF as_rowFlag = '' THEN Return 1

ds_obj = CREATE DataStore
ds_obj.DataObject = 'd_rowflag'

// import row flag info
IF ds_obj.ImportString(as_RowFlag, 1, default!, 1, default!, 2) < 0 THEN

	DESTROY ds_obj
	Return -1
	
END IF

// set RowSetIndex
nStart = ids_RowFlag.RowCount()
nCount = ds_obj.RowCount()

FOR i = 1 TO nCount
	
	nRow = ids_RowFlag.InsertRow(0)
	
	// get RowID
	nRowID = SUPER::GetRowIDFromRow(i + nStart)
	nMapId = ds_obj.GetItemNumber(i, 'mapid')
	
	// set Row Flag info
	ids_RowFlag.SetItem(nRow, 'rowid', nRowid)
	ids_RowFlag.SetItem(nRow, 'mapid', nMapId)
	ids_RowFlag.SetItem(nRow, 'oriid', nMapId)
	ids_RowFlag.SetItem(nRow, 'rowsetindex', 1)
	
NEXT

// destroy datastore
DESTROY ds_obj

Return 1

end function

private function integer of_initrowset (integer ai_count, boolean ab_flag);/****************************************************************************************
*
*	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
*
* =======================================================================================
*
*	<access>			: Private
*	<function> 		: of_InitRowSet
*	<description>	: init rowset.
*	<arguments>		: 
*						[integer] - Required. ref string changes.
*						[boolean] - Required. true - set newSetID;
*													 false - keep setID.
*	<return>			:
*						[integer] - 1 if success adn -1 if an error occurs. 
*
****************************************************************************************/

STR_ROWSET	stru_rowset[]

// Init SetCount
ii_SetCount = ai_Count

// Initializes the random number generator
Randomize(999)

// Init RowSet
IF UpperBound(istr_RowSet) > 0  THEN
	IF ab_flag THEN
		// Sets new SetID
		istr_RowSet[1].l_SetID = Long(String(Now(), "mmssfff") + String(Rand(999), "000"))
	END IF
	// keep 1th 
	stru_rowset[1].l_SetID = istr_rowSet[1].l_SetID
	stru_rowset[1].l_SetTS = istr_rowSet[1].l_SetTS
	stru_rowset[1].l_SetOriTS = istr_rowSet[1].l_SetOriTS
	istr_RowSet = stru_rowset
ELSE
	// Sets new SetID
	istr_RowSet[1].l_SetID = Long(String(Now(), "mmssfff") + String(Rand(999), "000"))
END IF

Return 1
end function

private function boolean of_isresetflag (boolean ab_flag);/****************************************************************************************
*
*	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
*
* =======================================================================================
*
*	<access>			: Private
*	<function> 		: of_ResetFlag
*	<description>	: reset row flag
*	<arguments>		: 
*						[boolean] - Required. set new setID if true and keep setID if false.
*	<return>			:
*						[integer] - return true if success otherwise false.
*
****************************************************************************************/

//if this.DataObject = '' then return false

// reset istr_RowSet
of_InitRowSet(0, ab_flag)

// reset ids_RowFlag
IF IsValid(ids_RowFlag) THEN
	ids_RowFlag.Reset()
ELSE
	ids_RowFlag = CREATE DataStore
	ids_RowFlag.dataobject = "d_rowflag"
END IF

// set original dataobject
is_OriDataObject = THIS.dataobject

Return TRUE
end function

private function integer of_getstatusinfo (ref str_rowinfo astr_rowinfo[], ref str_rowflag astr_rowflag[], dwbuffer adw_buffer, ref string as_state);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetStatusInfo
//
//	Access:  Private
//
//	Arguments:		
//		ref str_rowInfo	astr_RowInfo[]
//		ref str_RowFlag	astr_RowFlag[]
//		dwbuffer	adw_buffer
//		ref string as_state
//	Returns:  
//		Returns 1 if succeeds and -1 if an error occurs and 0 if no info.
//	Description:  
// 	Gets status information in specified buffer. 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
DWItemStatus ldwi_status
long ll_i,ll_j,ll_Count,ll_RowCount
long ll_Row,ll_MapID,ll_ColCount
str_RowState	lstr_RowState[]
DataStore	lds_RowState
string ls_FilePath,ls_FileName


//Gets numbers of row
ll_RowCount = UpperBound(astr_RowInfo)

//Gets numbers of column
ll_ColCount = long(this.Describe("DataWindow.column.count"))
for ll_i = 1 to ll_RowCount
	//Delete buffer
	if adw_buffer = delete! then
		if this.GetItemStatus(astr_RowInfo[ll_i].l_RowNo,0,delete!) = NotModified! then continue
	end if
	
	ll_Row = astr_RowInfo[ll_i].l_RowNo
	ll_MapID = astr_RowFlag[astr_RowInfo[ll_i].l_PosID].l_MapID
	//Gets Row Status
	ll_Count++
	lstr_RowState[ll_Count].l_MapID = ll_MapID
	lstr_RowState[ll_Count].l_Column = 0
	lstr_RowState[ll_Count].s_state = inv_appeon.of_StatusToCode(this.GetItemStatus(ll_Row,0,adw_buffer))
	//Gets Column status info
	for ll_j = 1 to ll_ColCount
		ldwi_status = this.GetItemStatus(ll_Row,ll_j,adw_buffer)
		if ldwi_status = NotModified! then continue
		
		//Column status info
		ll_Count++
		lstr_RowState[ll_Count].l_MapID = ll_MapID
		lstr_RowState[ll_Count].l_Column = ll_j
		lstr_RowState[ll_Count].s_State = inv_appeon.of_StatusToCode(ldwi_status)
		lstr_RowState[ll_Count].s_OriData = of_GetItemString(ll_Row,ll_j,adw_buffer,true)
	next
	
next

//Create DataStore
if ll_Count = 0 then return 0

lds_RowState = create DataStore
lds_RowState.DataObject = 'd_rowstate'
lds_RowState.object.data.primary = lstr_rowstate[]

//Get File path
if inv_appeon.of_GetFilePath(ls_FilePath,ls_FileName,'txt',This.dataobject+"_status",false) < 0 then goto label_error

//Save Data Info to Text File
if lds_RowState.SaveAs(ls_filepath,Text!,false)	<> 1 then goto label_error

//Destroy DataStore
Destroy lds_RowState

//Reads the content of the TXT file into a string; deletes the TXT file.
if inv_appeon.of_FileRead(ls_filepath,as_State) < 0 then goto label_error
FileDelete(ls_filepath)

//Success return 1
return 1

//Error
label_error:
	if isvalid(lds_RowState) then destroy lds_RowState
	return -1
end function

private function integer of_getrowflag (ref string as_rowflag);/****************************************************************************************
*
*	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
*
* =======================================================================================
*
*	<access>			: Private
*	<function> 		: of_GetRowFlag
*	<description>	: Gets RowFlag information in the specified buffer, called by 
*						  GetFullState function.
*	<arguments>		: 
*						[string] - Required. ref string as_RowFlag.
*	<return>			:
*						[integer] - Returns 1 if success and -1 if error
*
****************************************************************************************/

STRING strFileName, strFilePath

// get File path
IF inv_appeon.of_GetFilePath(strFilePath, &
	 strFileName, "txt", THIS.dataobject + "_flag", FALSE) < 0 THEN
	Return -1 //goto label_error
END IF

// save Data Info to Text File
IF ids_RowFlag.SaveAs(strFilePath, Text!, FALSE) <> 1 THEN
	Return -1 //goto label_error
END IF

// read the content of the TXT file into a string; deletes the TXT file.
IF inv_appeon.of_FileRead(strFilePath, as_RowFlag) < 0 THEN
	Return -1
END IF

FileDelete(strFilePath)
	
return 1


end function

public function long getfullstate (ref blob changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getfullstate()
//------------------------------------------------------------------------------
// Description: 
// 			Retrieves the complete state of a DataWindow or DataStore as 
//				a blob. This method is used primarily in distributed 
//				applications.
//	
// Arguments: 
//		ref	blob	changes		
//	
// Returns:  long
//				Returns the number of rows in the DataWindow string 
//				if it succeeds. Returns the number of rows in the 
//				DataWindow string if it succeeds -1 if an error occurs. 
//				GetFullState will return -1 if the DataWindow control 
//				or DataStore does not have a DataWindow object associated  
//				with it. If any argument value is NULL, the method returns 
//				NULL.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long 		ll_Ret
String 	ls_changes

ll_Ret = of_GetFullState(ls_changes, changes, TRUE, TRUE)

RETURN ll_Ret

end function

public function long getchanges (ref blob changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getchanges()
//------------------------------------------------------------------------------
// Description: 
// 			Retrieves changes made to a DataWindow or DataStore as a string.
//				This method is used primarily in distributed applications.
//
// Arguments: 
//		ref	blob	changes
//	
// Returns:  long
//				Returns the number of rows in the DataWindow change blob if it succeeds and one of the following values if it fails:
//				-1  An internal error occurred
//				-2  There is a conflict between the state of the DataWindow change blob and the state of the DataWindow from which the cookie was created; an attempt to use this blob in a SetChanges call against the DataWindow will fail
//				-3  There is a conflict between the state of the DataWindow change blob and the state of the DataWindow from which the cookie was created; but partial changes from the change blob can be applied
//				If any argument is NULL, in PowerBuilder the method returns NULL
//
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_Ret
String ls_Changes

ll_Ret = Of_GetChanges(ls_Changes, changes, TRUE)

RETURN ll_Ret

end function

public function integer setchanges (readonly blob changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::setchanges()
//------------------------------------------------------------------------------
// Description: 
//				Applies changes captured with GetChanges to a DataWindow or DataStore. 
//				This method is used primarily in distributed applications.
//
// Arguments: 
//		readonly	blob	changes		
//	
// Returns:  integer
//				Returns one of the following values:
//				1  All changes were applied
//				2  A partial update was successful; conflicting changes were discarded
//				-1  Method failed
//				-2  There is a conflict between the state of the DataWindow changestring and the state of the DataWindow
//				-3  Column specifications do not match
//
//				If any argument's value is NULL, in PowerBuilder the method returns NULL
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

INTEGER	li_Ret
STRING	ls_Changes

li_Ret = Of_SetChanges(ls_changes, changes, TRUE)

Return li_Ret
end function

public function integer setfullstate (readonly blob changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::setfullstate()
//------------------------------------------------------------------------------
// Description: 
//				Applies the contents of a DataWindow string retrieved by GetFullState to a DataWindow or DataStore. 
//				This method is used primarily in distributed applications.
//	
// Arguments: 
//		readonly	blob	changes		
//	
// Returns:  integer
//				Returns -1 if an error occurs and one of the following values if it succeeds:
//
//				1  DataWindow objects match; old data and state overwritten
//				2  DataWindow objects do not match; old object, data, and state replaced
//				3  No DataWindow object associated with DataWindow control or DataStore;	
//				the DataWindow object associated with the string is used. 
//				The value of the DataObject property 	remains an  empty string
//				Null  If any argument's value is NULL in PowerBuilder the method returns
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

INTEGER	li_Ret
String	ls_Changes

li_Ret = Of_SetFullState(ls_Changes, changes, TRUE, TRUE)

Return li_Ret

end function

public function long getrowfromrowid (long row, readonly string buffer);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getrowfromrowid()
//------------------------------------------------------------------------------
// Description: 
//				Gets the row number of a row in a DataWindow control or DataStore 
//				object from the unique row identifier associated with that row.
//	
// Arguments: 
//		        	long    	row   		
//		readonly	string	buffer		
//	
// Returns:  long
//				Returns the row number in buffer. Returns 0 if the row number is not in the current buffer and -1 if an error occurs. 
//				If any argument value is NULL, in PowerBuilder the method returns NULL
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

DWBuffer ldw_buffer

CHOOSE CASE Lower(buffer)
	CASE S_PRIMARY
		ldw_buffer = primary!
	CASE S_FILTER
		ldw_buffer = Filter!
	CASE S_DELETE
		ldw_buffer = DELETE!
END CHOOSE
RETURN of_GetRowFromMapID(row,ldw_buffer)




end function

public function long getrowidfromrow (long row, readonly string buffer);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::getrowidfromrow()
//------------------------------------------------------------------------------
// Description: 
//				Gets the unique row identifier of a row in a DataWindow control or DataStore object 
//				from the row number associated with that row.
//	
// Arguments: 
//		        	long    	row   		
//		readonly	string	buffer		
//	
// Returns:  long
//				Returns the row identifier in buffer. 
//				Returns 0 if the row identifier is not in the current buffer.
//				Returns -1 if an error occurs. 
//				If any argument value is NULL, in PowerBuilder the method returns NULL
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

DWBuffer	ldw_buffer

CHOOSE CASE Lower(buffer)
	CASE S_PRIMARY
		ldw_buffer = primary!
	CASE S_FILTER
		ldw_buffer = Filter!
	CASE S_DELETE
		ldw_buffer = DELETE!
END CHOOSE

RETURN of_GetMapIDFromRow(row,ldw_buffer)

end function

private function integer of_setstatusinfo (long al_row, readonly str_rowstate astr_rowstate);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_SetStatusInfo
//
//	Access:  private
//
//	Arguments:		
//		long	al_row
//		str_Rowstate	astr_rowstate
//
//	Returns:  
//		Returns 1 if it success and -1 if error occurs
//
//	Description:  
//		Sets status and original value information of the specified row 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
long ll_Column
string	ls_Status,ls_ColType
dwItemStatus ldwi_OldStatus,ldwi_NewStatus
any la_OriData,la_CurData

//Gets number of column
if isnull(astr_RowState.s_state) then return -1

//Gets New Status and Old Status
ldwi_NewStatus = inv_appeon.of_StatusFromCode(astr_RowState.s_state)
//ldwi_OldStatus = this.GetItemStatus(al_row,astr_RowState.l_column,primary!)
	
//Changes Status of row with ldwi_OldStatus to ldwi_NewStatus
of_ModifyStatus(al_row,astr_RowState.l_column,primary!,NotModified!,ldwi_NewStatus)
	
//Set original value info
if astr_RowState.l_column <> 0 then
	ls_ColType = this.Describe("#"+string(astr_RowState.l_column)+".coltype")
	if ls_ColType = '!' then return -1
	
	//Set Original Data Value
	if ldwi_NewStatus = DataModified! then
		//Gets Original data value
		la_OriData = inv_appeon.of_GetValueAny(ls_ColType,astr_RowState.s_OriData)
	
		la_CurData = this.Object.Data.primary.Current[al_row,astr_RowState.l_column]
		this.Object.data.primary.original[al_row,astr_RowState.l_column] = la_OriData
		this.Object.data.primary.Current[al_row,astr_RowState.l_column] = la_CurData
	end if
end if

return 1

end function

private function integer of_setstatusinfo (readonly dwbuffer adw_buffer, readonly string as_status);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_SetStatusInfo(SetFullState)
//
//	Access:  private
//
//	Arguments:	
//	dwbuffer	adw_buffer
//	string	as_status

//
//	Returns:  integer
//	Returns 1 if it succeeds and -1 if an error occurs and 0 if no data
//
//	Description:  
// Gets the states and datas of changed
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.01  2003-09-19
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
DataStore lds_RowState,lds_RowFlag
long ll_count,ll_FlagCount,ll_i,ll_j,ll_k,ll_row[],ll_MapID[]
str_rowstate	lstr_RowState[]
str_rowflag		lstr_RowFlag[]
boolean lb_flag

if as_status = '' then return 0

//Create DataStore
lds_RowState = create DataStore
lds_RowState.DataObject = 'd_rowstate'

//Import status info
if lds_RowState.ImportString(as_status) < 0 then goto error_label

//Sort lds_RowState by mapid and column
if lds_RowState.SetSort("fmapid,fcolumn A") < 0 then goto error_label
if lds_RowState.Sort() < 0 then goto error_label

//Sets lds_RowState into lstr_RowState 
lstr_RowState[] = lds_RowState.object.data.primary[]

//Filter lds_RowState and Destroy lds_RowState
if lds_RowState.SetFilter("fcolumn = 0") < 0 then goto error_label
if lds_rowState.Filter() < 0 then goto error_label
ll_MapID[] = lds_RowState.object.fmapid.primary[]
destroy lds_RowState

//Gets RowFlag info and sort by mapid
lds_RowFlag = create datastore
lds_RowFlag.DataObject = 'd_rowflag'
lds_RowFlag.object.data.primary = ids_RowFlag.object.data.primary
lds_RowFlag.SetSort("mapid A")
lds_RowFlag.Sort()
lstr_RowFlag[] = lds_RowFlag.object.data.primary[]
ll_FlagCount = lds_RowFlag.RowCount()
destroy lds_RowFlag

//Find the number of row from mapid 
ll_count = upperbound(ll_mapid)
ll_k = 1
for ll_i = 1 to ll_count
	lb_flag = false
	for ll_j = ll_k to ll_FlagCount
		if ll_MapID[ll_i] = lstr_RowFlag[ll_j].l_MapID then
			ll_k = ll_j + 1
			lb_Flag = true
			exit
		end if
	next
	if not lb_Flag then return -1
	
	//Gets the number of row from mapid
	ll_Row[ll_MapID[ll_i]] = Super::GetRowFromRowID(lstr_RowFlag[ll_j].l_RowID)
next

//Set Status info
ll_Count = UpperBound(lstr_RowState[])
for ll_i = 1 to ll_count
	//Set status and original value info
	if of_SetStatusInfo(ll_Row[lstr_RowState[ll_i].l_mapid],lstr_RowState[ll_i]) < 0 then return -1
next

//Forces immediate garbage collection.
GarbageCollect()

//return
return 1

error_label:
if isvalid(lds_RowState) then destroy lds_RowState
if isvalid(lds_RowFlag) then destroy lds_RowFlag
return -1
end function

private function integer of_setstatusinfo (readonly dwbuffer adw_buffer, readonly string as_state, readonly string as_data, readonly string as_rowflag, integer ai_rowsetlists[]);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_SetStatusInfo
//	Access:  Private
//	Arguments:		
//	string	as_column
//	dwbuffer	adw_buffer
//	boolean	ab_changes
//	string	as_state
//	string	as_data
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs and 0 if no data
//	Description:  
// 	Sets the data information, status information and identifier information 
//		for target object.
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//	Revision History
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//	Copyright ? 2001 - 2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////

BOOLEAN bFlag
INTEGER nRowSet

LONG nCount, nUpper, nStatusCount
LONG nSMapID, nSOriID, nSRowSetIndex, nDecID, nRowID
LONG i, j, nRow, nNewRow, nFindRow, nMaxMapID, nColCount

str_RowFlag	 lstr_SRowFlag[]
str_RowInfo  lstr_SRowInfo[]
str_RowState lstr_SRowState[]

DWBuffer		 ldw_SourceBuffer
DWItemStatus ldwi_OldStatus
DataStore	 lds_data, lds_status, lds_SRowFlag, lds_SRowInfo

// no data
IF as_data = "" THEN Return 0

// import source datawindow state into to lds_status
lds_status = CREATE DataStore
lds_status.DataObject = "d_rowstate"

// manage source datawindow status data
IF as_state <> "" THEN
	
	IF lds_status.ImportString(as_state) < 0 THEN GOTO error

	nStatusCount = lds_Status.RowCount()
	lds_status.SetSort("fmapid, fcolumn A")
	lds_status.Sort()
	lstr_SRowState[] = lds_status.object.data.primary[]
	
	DESTROY lds_Status

END IF

// import Data info to lds_Data
lds_data = CREATE DataStore

// import source datawindow data
IF lds_data.CREATE(THIS.Describe("DataWindow.syntax")) < 1 THEN GOTO error
IF Of_ImportString(lds_data, as_data) < 0 THEN GOTO error
nCount = lds_data.RowCount()

// import source datawindow rowflag info to lds_SRowFlag
lds_SRowFlag = CREATE DataStore
lds_SRowFlag.DataObject = 'd_rowflag'

IF lds_SRowFlag.ImportString(as_rowflag, 1, default!, 1, default!, 2) < 0 THEN GOTO error
lstr_SRowFlag[] = lds_SRowFlag.object.data.primary[]

// get source datawindow rowinfo
lds_SRowInfo = CREATE DataStore
lds_SRowInfo.DataObject = 'd_rowInfo'
lds_SRowInfo.object.sortid.primary = lds_SRowFlag.object.mapid.primary

FOR i = 1 TO nCount
	lds_SRowInfo.SetItem(i, 'rowno', i)
NEXT

lds_SRowInfo.SetSort("Sortid A")
lds_SRowInfo.Sort()
lstr_SRowInfo = lds_SRowInfo.object.data.primary[]

// destroy lds_srowflag
DESTROY lds_SRowFlag

// find status position of row
nFindRow = 1
FOR i = 1 TO nCount
	bFlag = FALSE
	FOR j = nFindRow TO nStatusCount
		IF lstr_SRowInfo[i].l_SortID = lstr_SRowState[j].l_MapID THEN
			nFindRow = j + 1
			bFlag = TRUE
			EXIT
		END IF
	NEXT
	
	IF bFlag THEN
		// sets RowFlag position
		lds_SRowInfo.SetItem(i, 'PosID', j)
	END IF
NEXT

// Sort RowInfo and destroy lds_SRowInfo
lds_SRowInfo.SetSort("RowNo A")
lds_SRowInfo.Sort()
lstr_SRowInfo[] = lds_SRowInfo.object.data.primary[]
DESTROY lds_SRowInfo

// Gets max(MapID) - max(RowId) 
nUpper = ids_RowFlag.RowCount()
IF nUpper > 0 THEN
	// Gets max mapid
	nMaxMapID = ids_RowFlag.GetItemNumber(nUpper, 'MaxMapID')
	IF nMaxMapID <= 0 THEN GOTO error
	// Get max(MapID) - max(RowId)
	nDecID = nMaxMapID - ids_RowFlag.GetItemNumber(nUpper, 'RowID')
END IF

// Set all row data, status, rowflag 
FOR i = 1 TO nCount
	nSMapID = lstr_SRowFlag[i].l_Mapid
	nSOriID = lstr_SRowFlag[i].l_Oriid
	nSRowSetIndex = lstr_SRowFlag[i].l_RowSetIndex
	nRowSet = ai_rowsetlists[nSRowSetIndex + 1] - 1
	
	// Find match row
	nRow = of_FindOriginalRow(nSMapID, nSOriID, nRowSet, ldw_SourceBuffer)
	IF nRow < 0 THEN
		// cannot find match row
		nNewRow = THIS.RowCount() + 1
		lds_Data.RowsCopy(i, i, primary!, THIS, nNewRow, primary!)
		
		// Reset status to NotModified
		IF of_ModifyStatus(nNewRow, 0, primary!, NewModified!, NotModified!) < 0 THEN
			GOTO error
		END IF
		
		IF lstr_SRowInfo[i].l_PosID <> 0 THEN
			nFindRow = lstr_SRowInfo[i].l_PosID
			DO 
				IF of_SetStatusInfo(nNewRow, lstr_SRowState[nFindRow]) < 0 THEN
					GOTO error
				END IF
				
				nFindRow++
				IF nFindRow > nStatusCount THEN EXIT
			LOOP WHILE lstr_SRowState[nFindRow].l_MapID = nSMapID
		END IF

		// sets rowflag info
		nRow = ids_RowFlag.InsertRow(0)
		nRowID = SUPER::GetRowIDFromRow(nNewRow)
		ids_RowFlag.SetItem(nRow, 'rowid', nRowID)
		ids_RowFlag.SetItem(nRow, 'mapid', nRowID + nDecID)
		ids_RowFlag.SetItem(nRow, 'oriid', nSMapID)
		ids_RowFlag.SetItem(nRow, 'RowSetIndex', nRowSet)
		
		// move to corresponding buffer
		CHOOSE CASE adw_buffer
			CASE Filter!
				THIS.RowsMove(nNewRow, nNewRow, primary!, THIS, THIS.FilteredCount()+ 1, adw_buffer)
			CASE Delete!
				THIS.RowsMove(nNewRow, nNewRow, primary!, THIS, THIS.DeletedCount() + 1, adw_buffer)
		END CHOOSE
	ELSE
		// find match row
		IF adw_buffer <> ldw_SourceBuffer THEN
			// different buffer, move to corresponding buffer
			CHOOSE CASE adw_buffer
				CASE primary!
					THIS.RowsMove(nRow, nRow, ldw_SourceBuffer, THIS, THIS.RowCount() + 1, adw_buffer)
				CASE filter!
					THIS.RowsMove(nRow, nRow, ldw_SourceBuffer, THIS, THIS.FilteredCount() + 1, adw_buffer)
				CASE delete!
					THIS.RowsMove(nRow, nRow, ldw_SourceBuffer, THIS, THIS.DeletedCount() + 1, adw_buffer)
			END CHOOSE
		
		// same buffer, modify
		ELSE
			// if adw_buffer is not equal to primary!, move record to primary buffer
			IF adw_buffer <> primary! THEN
				nNewRow = THIS.RowCount() + 1
				THIS.RowsMove(nRow, nRow, adw_buffer, THIS, nNewRow, primary!)
			ELSE
				nNewRow = nRow
			END IF
			
			// Gets type of all column 
			nColCount = INTEGER(THIS.Describe("DataWindow.column.count"))
			// Sets current data
			FOR j = 1 TO nColCount
				THIS.object.data.primary.CURRENT[nNewRow, j] = lds_data.object.data[i, j]
			NEXT
			
			// Reset Status to NotModified
			ldwi_OldStatus = THIS.GetItemStatus(nNewRow, 0, primary!)
			IF of_ModifyStatus(nNewRow, 0, primary!, ldwi_OldStatus, NotModified!) < 0 THEN 
				GOTO error
			END IF
			
			IF lstr_SRowInfo[i].l_PosID <> 0 THEN
				nFindRow = lstr_SRowInfo[i].l_PosID
				DO 
					IF of_SetStatusInfo(nNewRow, lstr_SRowState[nFindRow]) < 0 THEN
						GOTO error
					END IF
					nFindRow++
					
					IF nFindRow > nStatusCount THEN EXIT
				LOOP WHILE lstr_SRowState[nFindRow].l_MapID = nSMapID
			END IF
		
			// move record to adw_buffer when adw_buffer is not equal to primary!
			IF adw_buffer <> primary! THEN
				THIS.RowsMove(nNewRow, nNewRow, primary!, THIS, nRow, adw_buffer)
			END IF
		END IF
	END IF
NEXT
// Forces immediate garbage collection.
GarbageCollect()

DESTROY lds_data

Return 1

error:
if isvalid(lds_data) then destroy lds_data
if isvalid(lds_status) then destroy lds_status
if isvalid(lds_SRowFlag) then destroy lds_SRowFlag
if isvalid(lds_SRowInfo) then destroy lds_SRowFlag
return -1
end function

private function integer of_setdatainfo (readonly string as_column, readonly string as_data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_setdatainfo()
//------------------------------------------------------------------------------
// Description: 
// 			If as_columns = '', imports the data to the current DataObject.  Otherwise, 
//				imports the data to the corresponding DDDW object.
//	
// Arguments: 
//		readonly	string	as_column		
//		readonly	string	as_data  		
//	
// Returns:  integer - Returns the number of rows if it success and -1 if error occurs
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

DATAWINDOWCHILD	dwChild
Long nCount

IF as_data = "" THEN RETURN 0

IF as_column = "" THEN
	nCount = Of_ImportString(THIS, as_data)
	IF nCount < 0 THEN RETURN -1
ELSE
	// Get dddw
	IF THIS.GetChild(as_column,dwChild) <> 1 THEN
		RETURN -1
	END IF
	
	dwChild.Reset()
	
	nCount = Of_ImportString(dwChild, as_data)
	IF nCount < 0 THEN RETURN -1
	
	// Clears the update flags
	dwChild.ResetUpdate()
END IF

RETURN nCount

end function

private function integer of_loadvalidation (readonly string as_validation[]);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_LoadValidation
//
//	Access:  Private
//
//	Arguments:		
//	ref string as_validation[]
//
//	Returns:  
//		Returns 1 if it succeeds and -1 if an error occurs. 
//
//	Description:  
// 	Sets properties of validation 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

Long ll_ColCount,ll_i
String ls_validation, ls_quotation

ll_ColCount = UpperBound(as_validation)
IF ll_ColCount = 0 THEN RETURN -1

FOR ll_i = 1 TO ll_ColCount
	IF as_validation[ll_i] <> '' THEN
		ls_quotation = "'"
		IF (PosA(as_validation[ll_i], "'") > 0) THEN
			ls_quotation = "~""			
		END IF
					
		IF THIS.Modify("#"+String(ll_i)+".Validation ="+ls_quotation+as_validation[ll_i]+ls_quotation+"") <> '' THEN
			RETURN -1
		END IF
		
	END IF
NEXT
RETURN 1

end function

private function integer of_getstatusinfo (readonly dwbuffer adw_buffer, boolean ab_changes, ref string as_state, ref string as_data, ref string as_rowflag);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetStatusInfo
//
//	Access:  Private
//
//	Arguments:		
//	dwbuffer	adw_buffer
//	boolean	ab_changes:false if GetFullState call and true if GetChanges Call
//	ref string	as_state
//	ref string	as_data
//	ref string	as_RowFlag
//
//	Returns:  integer
//		Returns number of rows in the as_data string if it succeeds and ab_changes equal to true.
//		Returns 1 if it succeeds and ab_changes equal to false.
//		returns -1 if an error occurs and 0 if no data
//
//	Description:  
// 	If ab_changes = false, gets only the status information of the rows modified 
//		in the specified buffer.  Otherwise, gets the status information, 
//		data information and RowFlag information of the rows modified in the specified buffer.  
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
long ll_RowCount,ll_i
DataStore	lds_DataInfo
String ls_FilePath,ls_FileName
str_RowFlag lstr_RowFlag[]
str_rowinfo	lstr_rowinfo[]

//Gets Row Info
ll_RowCount = of_GetRowInfo(adw_buffer,ab_changes,lstr_RowInfo,lstr_rowFlag) 
if ll_RowCount <= 0 then return ll_RowCount
	
//gets status information.
if of_GetStatusInfo(lstr_RowInfo,lstr_Rowflag,adw_buffer,as_state) < 0 then return -1

	
//If ab_changes = true, gets data information and RowFlag information.
if ab_changes and ll_RowCount > 0 then
	//Gets RowFlag info for changes row
	for ll_i = 1 to ll_RowCount
		as_RowFlag +=	string(lstr_RowFlag[lstr_RowInfo[ll_i].l_PosID].l_MapID)+"~t"+ &
						string(lstr_RowFlag[lstr_RowInfo[ll_i].l_PosID].l_OriID)+"~t"+ &
						string(lstr_RowFlag[lstr_RowInfo[ll_i].l_PosID].l_RowSetIndex)+'~r~n'
	next
	
	//Gets Data Info for changes row
	if of_GetDataInfo(adw_buffer,as_data) < 0 then return -1
end if

//Returns number of rows in the as_data string if it succeeds and ab_changes equal to true
if ab_changes then
	return ll_RowCount
else
	return 1
end if
end function

private function integer of_getrowsetlists (readonly string as_rowset, integer ai_setcount, ref integer ai_lists[]);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetRowSetLists
//
//	Access:  Private
//
//	Arguments:		
//	str_a	astr_obj
//	ref integer ai_lists[]
//
//	Returns:  
//		Returns -2 if the number of data sets is above 2 and returns 0 
//		if matching data information is found. 
//
//	Description:  
// 	Compares source object RowSet information and target object information RowSet
//		and gets the information in the source object RowSet that corresponds to 
//		the target object RowSet information
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

long ll_i,ll_RowSet,ll_j
str_RowSet	lstr_SRowSet[]
string ls_syntax
DataStore	lds_obj
boolean lb_flag 

//Gets source rowset into lstr_SRowSet[]
ls_syntax = 'release 8;table(column=(type=long updatewhereclause=yes name=setid dbname="SetID" )' + &
				'column=(type=long updatewhereclause=yes name=setts dbname="SetTS" )'+ &
				'column=(type=long updatewhereclause=yes name=setorits dbname="SetOriTS" ) )'
lds_obj = create datastore
if lds_obj.Create(ls_syntax) < 1 then return -1
if lds_obj.ImportString(as_RowSet) < 0 then return -1
lstr_SRowSet = lds_obj.Object.data
destroy lds_obj

//Init RowSet info
if UpperBound(istr_RowSet) = 0 then
	of_InitRowSet(0,true)
end if
	
ll_RowSet = 0
for ll_i = 1 to ai_SetCount + 1
	lb_flag = false
	for ll_j = 1 to ii_SetCount + 1
		
		//The source object SetId is not equal to the target object SetID.
		if lstr_SRowSet[ll_i].l_SetID <> istr_RowSet[ll_j].l_SetID then
			continue
		end if
		
		if ll_i = 1 then
			ll_RowSet = ll_j
		end if
		//The source object SetId is equal to the target object SetID.
		lb_flag = true
		ai_lists[ll_i] = ll_j
		exit
	next 
	
	if ll_i = 1 and ll_RowSet = 0 then
		//not exists setid of source equal to setid of target
		//new rowset and SetID is equal to lstr_SRowSet[1]
		istr_RowSet[ii_SetCount+2].l_SetID = lstr_SRowSet[1].l_SetID
		ll_RowSet = ii_SetCount + 2
		ii_SetCount++
	end if
	
	if lb_flag then	//exists setid of source equal to setid of target
		continue
	else
		//SetID is equal to lstr_SRowSet[1]
		ai_lists[ll_i] = ll_RowSet
	end if
next
return 0


end function

private function integer of_getrowinfo (readonly dwbuffer adw_buffer, boolean ab_changes, ref str_rowinfo astr_rowinfo[], ref str_rowflag astr_rowflag[]);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetRowInfo
//
//	Access:  Private
//
//	Arguments:		
//	dwbuffer	adw_buffer
//	boolean	ab_changes:false if GetFullState call and true if GetChanges Call
//	ref str_RowInfo	astr_RowInfo[]
//	ref str_RowFlag	astr_RowFlag[]
//
//	Returns:  integer
//		Returns number of changes rows if it succeeds and returns -1 if an error occurs and 0 if no data
//
//	Description:  
// 	Gets the RowFlag position of changes rows
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////

DataStore	lds_RowInfo
long ll_RowCount,ll_Find,ll_i,ll_j,ll_upper,ll_start
long ll_RowNo[],ll_SortID[]
boolean lb_Flag

//Create row info
lds_RowInfo = create datastore
lds_RowInfo.DataObject = 'd_rowinfo'

//Get RowID of changes row
choose case adw_buffer
	case primary!
		ll_RowCount = this.Rowcount()
		ll_find = this.find("isRowModified() or isRowNew()",1,ll_RowCount)
		DO While ll_find > 0
			ll_i++
			ll_RowNo[ll_i] = ll_Find
			ll_SortID[ll_i] = super::GetRowIDFromRow(ll_find,adw_buffer)
			//next row
			ll_find++
			if ll_find > ll_RowCount then exit
			ll_find = this.find("isRowModified() or isRowNew()",ll_find,ll_RowCount)
		loop
	case filter!
		ll_RowCount = this.FilteredCount()
		for ll_find = 1 to ll_RowCount
			if this.GetItemStatus(ll_find,0,adw_buffer) <> NotModified! then
				ll_i++
				ll_RowNo[ll_i] = ll_Find
				ll_SortID[ll_i] = super::GetRowIDFromRow(ll_find,adw_buffer)
			end if
		next
	case delete!
		ll_RowCount = this.DeletedCount()
		for ll_find = 1 to ll_RowCount
			ll_i++
			ll_RowNo[ll_i] = ll_Find
			ll_SortID[ll_i] = super::GetRowIDFromRow(ll_find,adw_buffer)
		next
end choose

//Gets RowInfo
if ll_i > 0 then
	lds_RowInfo.object.rowno.primary = ll_RowNo[]
	lds_RowInfo.object.SortID.primary = ll_SortID[]
end if
		
//all rows
ll_RowCount = lds_RowInfo.RowCount()
ll_Upper = ids_RowFlag.RowCount()
if ll_RowCount = 0 then 
	destroy lds_RowInfo
	return 0
end if
if ll_Upper = 0 then goto label_error

//Sort lds_RowInfo by RowID
lds_RowInfo.SetSort("SortID A")
lds_RowInfo.Sort()

//Gets astr_rowinfo and astr_RowFlag
astr_rowinfo[] = lds_RowInfo.object.data.primary[]
astr_RowFlag[] = ids_RowFlag.object.data.primary[]


//Find the RowFlag position of current row 
ll_start = 1
for ll_i = 1 to ll_RowCount
	lb_flag = false
	for ll_j = ll_start to ll_upper
		if astr_rowinfo[ll_i].l_SortID = astr_RowFlag[ll_j].l_RowID then
			ll_start = ll_j + 1
			lb_Flag = true
			exit
		end if
	next
	//no find 
	if not lb_flag then goto label_error
	
	//sets the RowFlag
	astr_rowinfo[ll_i].l_PosID = ll_j
next	

//Sort by RowNo
if ab_changes then
	lds_RowInfo.object.data.primary = astr_rowinfo[]
	lds_RowInfo.SetSort("RowNo A")
	lds_RowInfo.Sort()
	astr_rowinfo = lds_RowInfo.object.data.primary
end if

//Destroy lds_RowInfo
destroy lds_RowInfo

return ll_RowCount

label_error:
	if isvalid(lds_rowinfo) then destroy lds_rowinfo
	return -1
end function

private function long of_getrowfrommapid (long al_mapid, readonly dwbuffer adw_buffer);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetRowFromMapID
//
//	Access:  Private
//
//	Arguments:		
//	long	al_row
//	dwbuffer	adw_buffer
//
//	Returns:  
//		Returns the row identifier in buffer. Returns 0 if the row identifier is 
//		not in the current buffer and -1 if an error occurs. 
//		If any argument value is NULL, in PowerBuilder the method returns NULL
//	Description:  
// 	Gets the unique row identifier of a row in a DataWindow control or DataStore 
//		object from the row number associated with that row.
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
long ll_RowID
long ll_row,ll_count


//if argument value is null,return null
if isnull(al_mapid) or isnull(adw_buffer) then
	SetNull(ll_row)
	return ll_row
end if

//gets RowID from MapID
if isvalid(ids_RowFlag) then
	ll_count = ids_RowFlag.RowCount()
	ll_row = ids_RowFlag.Find("MapID ="+string(al_mapid),1,ll_count)
	if ll_row > 0 then
		ll_RowID = ids_RowFlag.GetItemNumber(ll_row,'rowid')
	else
		ll_RowId = al_MapID
	end if
else
	ll_RowId = al_MapID
end if

//call super,gets row from rowid
return  super::GetRowFromRowID(ll_RowID,adw_buffer)


end function

private function integer of_getrowflag (readonly dwbuffer adw_buffer, ref string as_rowflag);/****************************************************************************************
*
*	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
*
* =======================================================================================
*
*	<access>			: Private
*	<function> 		: of_GetRowFlag
*	<description>	: Gets RowFlag information in the specified buffer, called by 
*						  GetFullState function.
*	<arguments>		: 
*						[dwbuffer] - Required. datawindow buffer;
*						[string] - Required. ref string as_RowFlag.
*	<return>			:
*						[integer] - Returns 1 if success and -1 if error
*
****************************************************************************************/

BOOLEAN bFlag
STRING strFileName, strFilePath
LONG 	i, j, nCount, nStart, nUpper
LONG  arrSortID[], arrTempID[], arrRowID[]

STR_FLAG str_rowflag[]
DATASTORE ds_RowInfo, ds_RowFlag

//Gets the number of rows
CHOOSE CASE adw_buffer
	CASE primary!
		nCount = THIS.RowCount()
	CASE filter!
		nCount = THIS.FilteredCount()
	CASE delete!
		nCount = THIS.DeletedCount()
END CHOOSE

//Gets the number or rows identIFier
nUpper = ids_RowFlag.RowCount()

IF nCount = 0 THEN Return 1
IF nUpper = 0 THEN Return -1

ds_RowInfo = CREATE DataStore
ds_RowInfo.DataObject = "d_RowInfo"

//Gets the RowInfo information of each row by a loop
FOR i = 1 TO nCount
	arrTempID[i] = i
	arrSortID[i] = SUPER::GetRowIDFromRow(i, adw_buffer)
NEXT

ds_RowInfo.object.rowno.primary = arrTempID[]
ds_RowInfo.object.sortid.primary = arrSortID[]

//Sort ds_RowInfo by A
ds_RowInfo.SetSort("SortID A")
ds_RowInfo.Sort()
arrSortID[] = ds_RowInfo.object.sortid.primary
arrRowID[] = ids_RowFlag.object.rowid.primary


//Find RowFlag position
nStart = 1
FOR i = 1 TO nCount
	bFlag = FALSE
	FOR j = nStart TO nUpper
		//exit loop IF find
		IF arrSortID[i] = arrRowID[j] THEN
			nStart = j + 1
			bFlag = TRUE
			EXIT
		END IF
	NEXT
	//no find
	IF not bFlag THEN GOTO label_error
	
	//sets RowFlag position
	ds_RowInfo.SetItem(i, "PosID", j)
NEXT

//Sort ds_RowInfo by RowNo 
ds_RowInfo.SetSort("RowNo A")
ds_RowInfo.Sort()
arrTempID[] = ds_RowInfo.object.PosID.primary
DESTROY ds_RowInfo

//Create ds_RowFlag
ds_RowFlag = CREATE DataStore
ds_RowFlag.DataObject = 'd_flag'

//Gets row flag
ds_RowFlag.object.data[1,1,nUpper,3] = ids_rowFlag.object.data[1,2,nUpper,4]
FOR i = 1 TO nCount
	str_rowflag[i] = ds_RowFlag.object.data[arrTempID[i]]
NEXT

ds_RowFlag.Reset()
ds_RowFlag.object.data.primary = str_rowflag[]

//Get File path
IF inv_appeon.of_GetFilePath(strFilePath, &
	 strFileName, "txt", THIS.dataobject + "_flag", FALSE) < 0 THEN 
	GOTO label_error
END IF

//Save Data Info to Text File
IF ds_RowFlag.SaveAs(strFilePath, Text!, FALSE)	<> 1 THEN 
	GOTO label_error
END IF
DESTROY ds_RowFlag

//Reads the content of the TXT file into a string; deletes the TXT file.
IF inv_appeon.of_FileRead(strFilePath,as_RowFlag) < 0 THEN 
	Return -1
END IF

FileDelete(strFilePath)
	
Return 1

//error
label_error:
IF isvalid(ds_RowFlag) THEN DESTROY ds_RowFlag
IF isvalid(ds_RowInfo) THEN DESTROY ds_RowInfo

Return -1


end function

private function long of_getmapidfromrow (long al_row, readonly dwbuffer adw_buffer);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetMapIDFromrow
//
//	Access:  Private
//
//	Arguments:		
//	long	al_row
//	dwbuffer	adw_buffer
//	boolean	ab_InitFlag
//
//	Returns:  
//		Returns the row identifier in buffer. Returns 0 if the row identifier is 
//		not in the current buffer and -1 if an error occurs. 
//		If any argument value is NULL, in PowerBuilder the method returns NULL
//	Description:  
// 	Gets the unique row identifier of a row in a DataWindow control or DataStore 
//		object from the row number associated with that row.
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
long ll_RowID,ll_Row

//call super,gets rowid from row
ll_RowID = super::GetRowIDFromRow(al_row,adw_buffer)

if ll_RowID <= 0 then return ll_RowID
if isnull(ll_rowId) then return ll_RowId


//gets mapid from rowid
if isvalid(ids_RowFlag) then
	ll_row = ids_RowFlag.Find("rowid ="+string(ll_RowID),1,ids_RowFlag.RowCount())
	if ll_row > 0 then
		return ids_RowFlag.GetItemNumber(ll_row,'MapID')
	end if
end if
return ll_RowID

end function

private function string of_getitemstring (long al_row, integer ai_column, readonly dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//	Private Function:  of_GetItemString  
//	Arguments:   	al_row			   : The row reference
//   					ai_column    		: The column name reference
//   					adw_buffer   		: The dw buffer from which to get the column's data value.
//   					ab_orig_value		: When True, returns the original values that were 
//							  					  retrieved from the database.
//	Returns:			String - The column value cast to an string datatype
//	Description:	Returns a column's value cast to an string datatype
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
any 		la_value


/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and cast the returned value */
CHOOSE CASE Lower ( LeftA ( this.Describe ("#"+string(ai_column) + ".ColType" ) , 5 ) )

		CASE "char(", "char"		//  CHARACTER DATATYPE
			la_value = this.GetItemString ( al_row, ai_column, adw_buffer, ab_orig_value ) 
	
		CASE "date"					//  DATE DATATYPE
			la_value = this.GetItemDate ( al_row, ai_column, adw_buffer, ab_orig_value ) 

		CASE "datet"				//  DATETIME DATATYPE
			la_value = this.GetItemDateTime ( al_row, ai_column, adw_buffer, ab_orig_value ) 

		CASE "decim"				//  DECIMAL DATATYPE
			la_value = this.GetItemDecimal ( al_row, ai_column, adw_buffer, ab_orig_value ) 
	
		CASE "numbe", "long", "ulong", "real", "int"				//  NUMBER DATATYPE	
			la_value = this.GetItemNumber ( al_row, ai_column, adw_buffer, ab_orig_value ) 
	
		CASE "time", "times"		//  TIME DATATYPE
			la_value = this.GetItemTime ( al_row, ai_column, adw_buffer, ab_orig_value ) 

		CASE ELSE 	
			SetNull ( la_value ) 

END CHOOSE

Return string(la_value)
end function

private function integer of_getdatainfo (readonly string as_column, readonly dwbuffer adw_buffer, ref string as_data);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetDataInfo
//
//	Access:  Private
//
//	Arguments:		
//	string	as_column
//	dwbuffer	adw_buffer
//	string	as_data 
//
//	Returns:  string
//	Returns 1 if it succeeds, or -1 if it fails, or 0 if no data is returned.  
//
//	Description:  
// Gets all data information of the current DataObject; called by GetFullState function.
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
DataWindowChild ldwc_obj
String	ls_DataObject
String ls_DataInfo,ls_CurRead
String ls_FilePath,ls_FileName
Long 	ll_FileLen,ll_Result,ll_FileNum
Long 	ll_i
Integer li_loops
DataStore	lds_obj

as_data = ''

//Gets the path where TXT file is stored . 
IF inv_appeon.of_GetFilePath(ls_FilePath,ls_FileName,'txt',THIS.DataObject,FALSE) < 0 THEN RETURN -1

//Current dataobject
IF as_column = '' THEN
	CHOOSE CASE adw_buffer
		CASE primary!
			IF THIS.RowCount() = 0 THEN RETURN 0
			
			//saves the current DataObject primary buffer data as a TXT file
			IF THIS.SaveAs(ls_FilePath,Text!	,FALSE)	 <> 1 THEN RETURN -1
			
		CASE Filter!
			IF THIS.FilteredCount() = 0 THEN RETURN 0
			
			//Creates DataStore instance lds_obj; assigns data of the current DataObject in filter buffer 
			//to lds_obj and saves as a TXT file.  
			lds_obj = CREATE DataStore
			lds_obj.DataObject = THIS.DataObject
			lds_obj.Object.Data = THIS.Object.Data.Filter
			
			//saves the current DataObject primary buffer data as a TXT file
			IF lds_obj.SaveAs(ls_FilePath,Text!	,FALSE)	 <> 1 THEN
				DESTROY lds_obj
				RETURN -1
			END IF
			DESTROY lds_obj
		CASE DELETE!
			IF THIS.DeletedCount() = 0 THEN RETURN 0
			
			lds_obj = CREATE DataStore
			lds_obj.DataObject = THIS.DataObject
			lds_obj.Object.Data = THIS.Object.Data.DELETE
			
			//saves the current DataObject primary buffer data as a TXT file
			IF lds_obj.SaveAs(ls_FilePath,Text!	,FALSE)	 <> 1 THEN
				DESTROY lds_obj
				RETURN -1
			END IF
			DESTROY lds_obj
	END CHOOSE
	
	//For dddw
ELSE
	ls_DataObject = THIS.DESCRIBE(as_column+".DDDW.Name")
	
	//Gets dddw Object
	IF THIS.GetChild(as_column,ldwc_obj) <> 1 THEN RETURN -1
	
	CHOOSE CASE adw_buffer
		CASE primary!
			IF ldwc_obj.RowCount() = 0 THEN RETURN 0
			
			//save as text file
			IF ldwc_obj.SaveAs(ls_FilePath,Text!	,FALSE)	 <> 1 THEN RETURN -1
		CASE Filter!
			IF ldwc_obj.FilteredCount() = 0 THEN RETURN 0
			
			lds_obj = CREATE DataStore
			lds_obj.DataObject = ls_DataObject
			ldwc_obj.RowsCopy ( 1,ldwc_obj.FilteredCount(),Filter!,lds_obj,1,primary!)
			
			IF lds_obj.SaveAs(ls_FilePath,Text!	,FALSE)	 <> 1 THEN
				DESTROY lds_obj
				RETURN -1
			END IF
			DESTROY lds_obj
		CASE DELETE!
			IF ldwc_obj.DeletedCount() = 0 THEN RETURN 0
			
			lds_obj = CREATE DataStore
			lds_obj.DataObject = ls_DataObject
			ldwc_obj.RowsCopy ( 1,ldwc_obj.FilteredCount(),DELETE!,lds_obj,1,primary!)
			
			IF lds_obj.SaveAs(ls_FilePath,Text!	,FALSE)	 <> 1 THEN
				DESTROY lds_obj
				RETURN -1
			END IF
			DESTROY lds_obj
	END CHOOSE
END IF


// Reads the content of the TXT file into a string; deletes the TXT file
IF inv_appeon.of_FileRead(ls_FilePath,as_data) < 0 THEN RETURN -1

FileDelete(ls_FilePath)
RETURN 1


end function

private function integer of_getdatainfo (readonly dwbuffer adw_buffer, ref string as_data);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetDataInfo(format2)
//
//	Access:  Private
//
//	Arguments:		
//	dwbuffer	adw_buffer
//	string	as_data 
//
//	Returns:  string
//	Returns 1 if it succeeds, or -1 if it fails, or 0 if no data is returned.  
//
//	Description:  
// Gets changes data information of the current DataObject; called by of_GetChangesInfo function.
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
DataStore	lds_DataInfo
blob	lb_Changes
string ls_FilePath,ls_FileName

//create lds_datainfo
lds_DataInfo = Create DataStore


Choose case adw_buffer
	case primary!,Filter!
		//Gets the Data
		//if this.GetFullState(lb_Changes) < 0 then goto label_error
		if SUPER::GetFullState(lb_Changes) < 0 then goto label_error
		if lds_DataInfo.SetFullState(lb_Changes) < 0 then goto label_error
		if adw_buffer = primary! then
			lds_DataInfo.RowsDiscard(1,lds_DataInfo.FilteredCount(),Filter!)
		else
			lds_DataInfo.RowsDiscard(1,lds_DataInfo.RowCount(),primary!)
			lds_DataInfo.RowsMove(1,lds_DataInfo.FilteredCount(),Filter!,lds_DataInfo,1,primary!)
		end if
		
		//Filter changes data
		lds_DataInfo.SetFilter("isRowModified() or isRowNew()")
		lds_DataInfo.Filter()
	case delete!
		//Gets all data of delete buffer
		lds_DataInfo.DataObject = this.DataObject
		lds_DataInfo.object.data.primary = this.object.data.delete
end choose
	
//Get File path
if inv_appeon.of_GetFilePath(ls_FilePath,ls_FileName,'txt',This.dataobject+"_data",false) < 0 then goto label_error

//Save Data Info to Text File
if lds_DataInfo.SaveAs(ls_filepath,Text!,false)	<> 1 then goto label_error

//Destroy datastore
Destroy lds_DataInfo
	
//Reads the content of the TXT file into a string; deletes the TXT file.
if inv_appeon.of_FileRead(ls_filepath,as_Data) < 0 then goto label_error
FileDelete(ls_filepath)

//success return 1
return 1

//error
label_error:
	if isvalid(lds_DataInfo) then destroy lds_DataInfo
	return -1
end function

private function long of_findoriginalrow (long al_mapid, long al_oriid, integer ai_rowset, ref dwbuffer adw_buffer);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_FindOriginalRow
//
//	Access:  Private
//
//	Arguments:		
//		long	al_MapID
//		long	al_OriID
//		integer	ai_RowSet
//		ref dwbuffer	adw_buffer
//
//	Returns:  
//		Returns the number of rows if succeeds and -1 if error occurs
//
//	Description:  
// 	According to the arguments passed in, looks up the matching line in the target object.  
//		If the line is found, returns the row number, otherwise, returns -1.
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
long ll_i,ll_j,ll_row,ll_rowID,ll_count

ll_count = ids_RowFlag.RowCount()

//When the ai_RowSet of the source object is 0:  searches whether there exists a matching 
//line by checking whether the source object OriID equals to the target object MapID.
if ai_RowSet  = 0 then
	//Gets RowID of the matching line.
	ll_row = ids_RowFlag.Find("MapID ="+string(al_OriID),1,ll_count)
	if ll_row = 0 then return -1
	
//When the ai_RowSet of the source object data is not 0:  searches whether there exits a matching 
//line by checking whether the source object MapID equals to the target object OriID and 
//the ai_RowSet of the source object equals to the target object RowSetIndex
else
	//Gets RowID of the matching line.
	ll_row = ids_RowFlag.Find("OriID ="+string(al_MapID)+" and RowSetIndex ="+string(ai_RowSet),1,ll_count)
	if ll_row = 0 then return -1
end if


//According to RowID information, gets the row number.
ll_RowID = ids_rowFlag.GetItemNumber(ll_row,'rowid')

//Find primary buffer
ll_Row = super::GetRowFromRowID(ll_RowID,primary!)
if ll_row > 0 then
	adw_buffer = primary!
	return ll_row
end if

//Find filter buffer
ll_Row = super::GetRowFromRowID(ll_RowID,filter!)
if ll_row > 0 then
	adw_buffer = filter!
	return ll_row
end if

//Find delete buffer
ll_Row = super::GetRowFromRowID(ll_RowID,delete!)
if ll_row > 0 then
	adw_buffer = delete!
	return ll_row
end if

//Returns -1 if no matching line is found. 
return -1
end function

private function blob of_dddwblob (integer ai_dddwid[], ref string as_dddwname[], boolean ab_flag);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_dddwblob()
//------------------------------------------------------------------------------
// Description: 
// 			The first part of the blob object, encapsulate the child DataWindow.
//	
// Arguments: 
//		value   	integer	ai_dddwid[]  		
//		readonly	string 	as_dddwname[]		
//		value   	boolean	ab_flag      		
//	
// Returns:  blob
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

BLOB	blobData
BLOB{2} blobInt
BLOB{4} blobLong
STRING strDddw, strColName
INTEGER i, j, nDddwLen, nColCount

// get the child DataWindow's name
IF ab_flag THEN
	nColCount = Long(THIS.object.datawindow.column.count)
	FOR i = 1 TO nColCount
		IF THIS.Describe("#" + String(i) + '.Edit.Style') = 'dddw' THEN
			j++
			ai_dddwID[j] 	= Integer(THIS.Describe(("#" + String(i) + ".ID")))
			as_dddwName[j]	= THIS.Describe("#" + String(i) + ".name")
		END IF
		//strColName = THIS.Describe("#" + String(i) + '.name')
	NEXT
END IF

// store the number of child DataWindows
blobEdit(blobLong, 1, Long(UpperBound(ai_DddwID)))
blobData += blobLong

FOR i = 1 TO UpperBound(ai_DddwID)
	
	blobEdit(blobInt, 1, ai_DddwID[i])
	blobData += blobInt
	
	// Column name 
	nDddwLen = LenA(as_DddwName[i])
	blobEdit(blobInt, 1, nDddwLen) //lenght
	blobData += blobInt
	
	blobData += Blob(as_DddwName[i],EncodingAnsi!) //Encoding – Nova 11.16.2010name
	
	// the child DataWindow's name
	strDddw = THIS.Describe(as_DddwName[i] + ".dddw.name")
	
	nDddwLen = LenA(strDddw)
	blobEdit(blobInt, 1, nDddwLen) //lenght
	blobData += blobInt
	
	blobData += Blob(strDddw,EncodingAnsi!) //Encoding – Nova 11.16.2010//name

NEXT

blobEdit(blobLong, 1, Long(LenA(blobData)))
blobData = blobLong + blobData

Return blobData
end function

public function long appeongetfullstateex (ref blob changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: AppeonDatastore::appeongetfullstateex()
//------------------------------------------------------------------------------
// Description: GetFullSate without dddw info
// 
//	
// Arguments: 
//		value	blob	changes		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

LONG 		ll_Ret
STRING 	ls_changes

ll_Ret = of_GetFullState(ls_changes, changes, TRUE, FALSE)

return ll_Ret
end function

public function long appeongetfullstateex (ref string changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: AppeonDatastore::appeongetfullstateex()
//------------------------------------------------------------------------------
// Description: GetFullSate without dddw info
// 
//	
// Arguments: 
//		value	string	changes		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long 		ll_Ret
Blob lb_changes

ll_Ret = of_GetFullState(changes, lb_changes, FALSE, FALSE)

RETURN ll_Ret
end function

public function integer appeonsetfullstateex (readonly blob changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: AppeonDatastore::AppeonSetfullstateEx()
//------------------------------------------------------------------------------
// Description: SetFullSate without dddw info
// 
//	
// Arguments: 
//		value	blob	changes		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

INTEGER	li_Ret
String	ls_Changes

li_Ret = Of_SetFullState(ls_Changes, changes, TRUE, FALSE)

Return li_Ret
end function

public function integer appeonsetfullstateex (readonly string changes);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: AppeonDatastore::AppeonSetfullstateEx()
//------------------------------------------------------------------------------
// Description:  SetFullSate without dddw info
// 
//	
// Arguments: 
//		value	string	changes		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

INTEGER	li_Ret
BLOB		lb_Changes

li_Ret = Of_SetFullState(changes, lb_changes, FALSE, FALSE)

Return li_Ret
end function

private function long of_getfullstate (ref string as_changes, ref blob ab_changes, boolean ab_blob, boolean ab_withdddw);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_getfullstate()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//			string 	as_changes		
//			blob   	ab_changes		
//			boolean	ab_blob		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//	 		1.0   Initial version
//==============================================================================

Blob 		lb_data
Long 		i, ll_Ret, ll_Address, ll_Changes
String 	ls_type, ls_FilePath, ls_FileName

STR_A		lstru_info_a
STR_B		lstru_info_b

// Argument is null
IF IsNull(as_changes) OR IsNull(ab_changes) THEN
	SetNull(ll_Ret)
	RETURN ll_Ret
END IF

// dataobject not is null
IF THIS.DESCRIBE("datawindow.type") = "" THEN
	RETURN -1
END IF

// get DataWindow Object type
ls_type = of_GetType(THIS)
IF ls_type = "" THEN RETURN -1

// get DataWindow Object info
CHOOSE CASE ls_type
	CASE '41','42'
		// if the property value of the current dataobject 
		// is not is_OriDataObject, resets the identifier 
		// to initial status.
		IF THIS.DataObject <> is_OriDataObject THEN
			of_IsResetFlag(TRUE)
		END IF
		
		// Initiates RowFlag information.
		IF of_InitRowFlag() < 0 THEN RETURN -1
		
		// get SetCount
		lstru_info_a.l_SetCount = ii_SetCount
		
		// get RowSet information of the current object.
		IF of_GetRowSet(lstru_info_a.s_RowSet) < 0 THEN RETURN -1
		
		lstru_info_a.s_dataobject = THIS.DataObject
		
		// get PB Syntax
		lstru_info_a.s_pbsyntax = THIS.DESCRIBE("datawindow.syntax")
		
		// Get FullState
		IF ls_type = '42' THEN 
			SUPER::GetFullState(lstru_info_a.s_fullstate)
			lstru_info_a.s_type = "B"
		ELSE
			lstru_info_a.s_type = "F"
		END IF
		
		// get RowFlag information of the current object, 
		// the order of which is the same with that of data 
		// information. 
		IF of_GetRowFlag(lstru_info_a.s_pflag) < 0 THEN RETURN -1
		
		// get information of the current object
		lb_data = of_createblob()
		
		// convert the obtained information into specific 
		// XML string and returns this string.
		IF ConvertDWAP_J(REF lb_data, REF lstru_info_a, REF ll_Address, REF ll_Changes, ab_blob, ab_withdddw) <> 1 THEN RETURN -1
		IF ab_blob THEN
			ab_changes = Blob(Space(ll_Changes),EncodingAnsi!) //Encoding – Nova 11.16.2010
		ELSE
			as_changes = Space(ll_Changes)
		END IF
		
		// release memory
		IF FreeMemoryEX(REF ab_changes, REF as_changes, ll_Address, ll_Changes, ab_blob) <> 1 THEN RETURN -1
		
		// get Result valus
		ll_Ret = THIS.RowCount()
		
	CASE '43'
		lstru_info_b.s_dataobject = THIS.DataObject
		lstru_info_b.s_type = 'C'
		
		// get blob string
		ll_Ret = SUPER::GetFullState(lstru_info_b.s_fullstate)
		
		// get SQL
		lstru_info_b.s_sql = THIS.DESCRIBE("datawindow.table.select")
		
		// get filter
		lstru_info_b.s_filter = THIS.DESCRIBE("datawindow.table.filter")
		IF lstru_info_b.s_filter = "?" THEN
			lstru_info_b.s_filter = ""
		END IF
		lstru_info_b.s_pbsyntax = THIS.DESCRIBE("datawindow.syntax")
		
		// get sort
		lstru_info_b.s_sort = THIS.DESCRIBE("datawindow.table.sort")
		
		IF lstru_info_b.s_sort = "?" THEN
			lstru_info_b.s_sort = ""
		END IF
		
		// for DataObject of C type, gets the number of data graphs, 
		// each of which has 20 records.
		i = Mod(THIS.RowCount(), I_PIC_PER_ROW)
		IF i = 0 THEN
			lstru_info_b.i_count = THIS.RowCount() / I_PIC_PER_ROW
		ELSE
			lstru_info_b.i_count = THIS.RowCount() / I_PIC_PER_ROW + 1
		END IF
		
		// for calls to EAServer components, gets the data information 
		// of the current object and convert it into graph.
		IF inv_appeon.of_GetFilePath(ls_FilePath, &
			ls_FileName, 'wmf', lstru_info_b.s_dataobject, FALSE) > 0 THEN
			
			//==============================================================
			//fixed bugid 14734 2004-07-20
			//--------------------------------------------------------------
			datastore lds_temp
			lds_temp = CREATE datastore
			Blob lb_syntax
			FOR i = 1 TO lstru_info_b.i_count
				SUPER::GetFullState(lb_syntax)
				lds_temp.SetFullState(lb_syntax)
				
				lds_temp.SetFilter("getrow() >="+String((i - 1)*20+1) + " and getrow() <= "+String(i*20))
				lds_temp.Filter()
				lds_temp.SaveAs(ls_FilePath +"_"+String(i)+".wmf",WMF!,FALSE)
				//Changes WMF file into GIF file.
				IF ConvertImageW_G(ls_FilePath+"_"+String(i)+".wmf") = 0 THEN
					RETURN -1
				END IF
				
			NEXT
			DESTROY lds_temp
			//==============================================================				
			lstru_info_b.s_url = "/imagefile/" + ls_FileName + "_1.gif"
		END IF
		
		// converts the obtained information into specific XML string 
		// and returns this string.
		IF (1 <> ConvertDWCP_J(REF lstru_info_b, REF ll_Address, REF ll_Changes, ab_blob)) THEN RETURN -1
		
		IF ab_blob THEN
			ab_changes = Blob(Space(ll_Changes),EncodingAnsi!) //Encoding – Nova 11.16.2010
		ELSE
			as_changes = Space(ll_Changes)
		END IF
		
		// release memory
		IF FreeMemoryEX(REF ab_changes, REF as_changes, ll_Address, ll_Changes, ab_blob) <> 1 THEN RETURN -1
END CHOOSE

as_changes = Trim(as_changes)
IF LenA(ab_changes) = 0 AND LenA(as_changes) = 0 THEN ll_Ret = -1

RETURN ll_Ret


end function

private function long of_getchanges (ref string as_changes, ref blob ab_changes, boolean ab_blob);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_getchanges()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//			string 	as_changes		
//			blob   	ab_changes		
//			boolean	ab_blob		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//	 		1.0   Initial version
//==============================================================================

String 	ls_Type
Long 		i, ll_Ret, ll_Address, ll_Changes

Blob		lblob_Data
BLob{2}	lblob_Integer
Blob{4}	lblob_Long

Integer 	arrDddwID[]
String	arrDddwName[]
STR_A		lstru_info_a

// Argument is null
IF IsNull(as_changes) OR IsNull(ab_changes) THEN
	SetNull(ll_Ret)
	RETURN ll_Ret
END IF

// Gets the property value of DataObject.  If the 
// property value is NULL, the method returns -1.
IF THIS.DESCRIBE("DataWindow.type") = "" THEN
	RETURN -1
END IF

lstru_info_a.s_DataObject = THIS.DataObject

// Gets the type of the current DataObject
ls_Type = of_GetType(THIS)

IF ls_Type <> '41' THEN RETURN -1

// getchanges
lstru_info_a.s_type = "C"

// Sets identifiers to initial status.
IF THIS.DataObject <> is_OriDataObject THEN
	of_IsResetFlag(TRUE)
END IF

// Initiates row flag information.
of_InitRowFlag()

// Gets match type
IF of_GetMatchType(lstru_info_a.s_matchtype, TRUE) < 0 THEN
	RETURN -1
END IF

// Gets SetCount
lstru_info_a.l_SetCount = ii_SetCount

// Gets RowSet Info
IF of_GetRowSet(lstru_info_a.s_RowSet) < 0 THEN
	RETURN -1
END IF

// Gets ids_rowflag
IF of_GetRowFlag(lstru_info_a.s_pflag) < 0 THEN
	RETURN -1
END IF

// Gets information of the current object
ll_Ret = SUPER::GetChanges(lblob_Data)
IF ll_Ret  < 0 THEN RETURN ll_Ret

BlobEdit(lblob_Integer, 1, Integer(9))
BlobEdit(lblob_Long, 1, Long(LenA(lblob_Data)))

// Gets information of Dddw
lblob_Data = lblob_Integer + of_DddwBlob(arrDddwID, arrDddwName, TRUE) + lblob_Long + lblob_Data

// Converts the obtained information into specific XML string 
IF 1 <> ConvertDWAP_J(REF lblob_Data, REF lstru_info_a, REF ll_Address, REF ll_Changes, ab_blob, TRUE) THEN RETURN -1

IF ab_blob THEN
	ab_changes = Blob(Space(ll_Changes),EncodingAnsi!) //Encoding – Nova 11.16.2010
ELSE
	as_changes = Space(ll_Changes)
END IF

// release memory
IF FreeMemoryEX(REF ab_changes, REF as_changes, ll_Address, ll_Changes, ab_blob) <> 1 THEN RETURN -1

as_changes = Trim(as_changes)
IF LenA(ab_changes) = 0 AND LenA(as_changes) = 0 THEN ll_Ret = -1

// Returns the number of rows in the DataWindow change string
RETURN ll_Ret


end function

private subroutine of_savedddwdata (ref string arrdddwdata[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: AppeonDatastore::of_savedddwdata()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		reference	string	arrdddwdata[]		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer i, li_ColCount
String ls_ColName, ls_data
li_ColCount = Integer(THIS.DESCRIBE("datawindow.column.count"))
FOR i = 1 TO li_ColCount
	IF THIS.DESCRIBE("#" + String(i) + ".edit.style") = 'dddw' THEN
		ls_data = ""
		ls_ColName = THIS.DESCRIBE("#" + String(i) + ".name")
		
		of_getdatainfo(ls_ColName, Primary!, ls_data)
		arrdddwdata[i] = ls_data
	END IF
END FOR
end subroutine

private function integer of_setfullstate (readonly string as_changes, readonly blob ab_changes, boolean ab_blob, boolean ab_withdddw);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_setfullstate()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//			string 	as_changes		
//			blob   	ab_changes		
//			boolean	ab_blob		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//	 		1.0   Initial version
//==============================================================================

Integer 	li_Ret
Integer 	li_ColCount, arrRowSet[], arrDddwID[]
String 	ls_Type, ls_ColName, ls_MatchType, ls_Processing
String 	ls_Result, arrValidation[], arrDddwData[], arrDddwName[]
Long 		ll_PrimaryCount, ll_FilterCount, ll_DeleteCount, i, ll_Result
Long 		ll_Address
Boolean 	lb_FullState = TRUE
Blob		lb_Result

STR_B					stru_info_b
STR_A					stru_info_a, stru_empty
DATAWINDOWCHILD 	dwChild

// Argument is null
IF IsNull(as_changes) OR IsNull(ab_changes) THEN
	SetNull(li_Ret)
	RETURN li_Ret
END IF

IF ab_blob THEN
	ls_Type = CharA(BlobMid(ab_changes, 1, 1))
ELSE
	ls_Type = MidA(as_changes, 1, 2)
END IF

IF ls_Type = "" THEN RETURN -1

// Prevent flickering.  Improve performance.
// This.SetReDraw ( FALSE )
CHOOSE CASE Upper(ls_Type)
	CASE '41', 'A'
		// Reset Flag
		of_IsResetFlag(FALSE)
		
		// Call dll, convert XML to PB string
		IF 1 <> ConvertDWAJ_P(REF as_changes, REF ab_changes, REF ll_Address, REF ll_Result, REF ls_ColName, REF ls_MatchType, lb_FullState, ab_blob) THEN
			RETURN -1
		END IF
		ls_Result = Space(ll_Result)
		
		// release memory
		IF FreeMemoryEX(REF lb_Result, REF ls_Result, ll_Address, ll_Result, FALSE) <> 1 THEN RETURN -1
		
		IF inv_appeon.of_GetPbChanges(ls_Result, stru_info_a) < 0 THEN
			RETURN -1
		END IF
		
		ls_Processing = THIS.DESCRIBE("datawindow.processing")
		
		// Save dddw info
		IF THIS.DataObject = "" OR THIS.DataObject <> stru_info_a.s_dataobject THEN
			THIS.DataObject = stru_info_a.s_dataobject
			ab_withdddw = TRUE
		ELSEIF NOT ab_withdddw THEN
			Of_SaveDddwData(arrDddwData);
		END IF
		
		// Create DataWindow Object
		IF THIS.CREATE(stru_info_a.s_pbsyntax) <> 1 THEN RETURN -1
		
		// Get Result value
		IF ls_Processing = "?" OR ls_Processing = "" THEN
			li_Ret = 3
		ELSEIF ls_Processing = THIS.DESCRIBE("datawindow.processing") THEN
			li_Ret = 1
		ELSE
			li_Ret = 2
		END IF
		
		is_OriDataObject = stru_info_a.s_dataobject
		
		// Get RowSet Lists Info
		IF of_GetRowSetLists(stru_info_a.s_rowset, &
			stru_info_a.l_SetCount, arrRowSet[]) < 0 THEN
			RETURN -1
		END IF
		
		// Clear and Save column properties of validation
		IF of_SaveValidation(arrValidation) < 0 THEN RETURN -1
		
		// import data info
		ll_PrimaryCount =  of_SetDataInfo('', stru_info_a.s_pdata)
		IF ll_PrimaryCount < 0 THEN RETURN -1
		ll_FilterCount = of_SetDataInfo('', stru_info_a.s_fdata) + ll_PrimaryCount
		IF ll_FilterCount < 0 THEN RETURN -1
		ll_DeleteCount = of_SetDataInfo('', stru_info_a.s_ddata) + ll_FilterCount
		IF ll_DeleteCount < 0 THEN RETURN -1
		THIS.ResetUpdate()
		
		// Import Row Flag info
		IF of_SetRowFlag(stru_info_a.s_pflag) < 0 THEN RETURN -1
		IF of_SetRowFlag(stru_info_a.s_fflag) < 0 THEN RETURN -1
		IF of_SetRowFlag(stru_info_a.s_dflag) < 0 THEN RETURN -1
		
		// import state info and original data info
		IF of_SetStatusInfo(primary!, stru_info_a.s_pstate) < 0 THEN RETURN -1
		IF of_SetStatusInfo(Filter!, stru_info_a.s_fstate) < 0 THEN RETURN -1
		IF of_SetStatusInfo(DELETE!, stru_info_a.s_dstate) < 0 THEN RETURN -1
		
		// Movie to correspond buffer
		IF ll_DeleteCount > ll_FilterCount THEN
			// movie to delete
			THIS.RowsMove(ll_FilterCount + 1, ll_DeleteCount, primary!, THIS, 1, DELETE!)
		END IF
		
		IF ll_FilterCount > ll_PrimaryCount THEN
			// movie to filter
			THIS.RowsMove(ll_PrimaryCount + 1, ll_FilterCount, primary!, THIS, 1, Filter!)
		END IF
		
		// Load column properties of validation
		IF of_LoadValidation(arrValidation) < 0 THEN RETURN -1
		
		// import dddw data info
		of_main_analysis(arrDddwID[], arrDddwName[])
		FOR i = 1 TO UpperBound(arrDddwName)				
			ls_ColName = arrDddwName[i]
			
			IF THIS.GetChild(ls_ColName, dwChild) <> 1 THEN CONTINUE
			
			// import dddw data ,only primary buffer
			IF NOT ab_withdddw THEN
				IF of_SetDataInfo(ls_ColName, arrDddwData[i]) < 0 THEN
					RETURN -1
				END IF
				CONTINUE
			END IF
			
			// Call Dll,convert XML to PB,only support A Type
			IF 1 <> ConvertDWAJ_P(REF as_changes, REF ab_changes, REF ll_Address, REF ll_Result, REF ls_ColName, REF ls_MatchType, lb_FullState, ab_blob) THEN
				RETURN -1
			END IF
			
			ls_Result = Space(ll_Result)
			
			// release memory
			IF FreeMemoryEX(REF lb_Result, REF ls_Result, ll_Address, ll_Result, FALSE) <> 1 THEN RETURN -1
			
			stru_info_a = stru_empty
			IF inv_appeon.of_GetPbChanges(ls_Result, stru_info_a) < 0 THEN
				RETURN -1
			END IF
			
			// import dddw data ,only primary buffer
			IF of_SetDataInfo(ls_ColName, stru_info_a.s_pdata) < 0 THEN
				RETURN -1
			END IF
		NEXT
	CASE '42','B','43','C'
		IF 1 <> ConvertDWCJ_P(REF as_changes, REF ab_changes, REF ll_Address, REF ll_Result, ab_blob) THEN
			RETURN -1
		END IF
		
		ls_Result = Space(ll_Result)
		
		// release memory
		IF FreeMemoryEX(REF lb_Result, REF ls_Result, ll_Address, ll_Result, FALSE) <> 1 THEN RETURN -1
		
		IF inv_appeon.of_GetPbChanges(ls_Result, stru_info_b, ls_Type) < 0 THEN
			RETURN -1
		END IF
		
		ls_Processing = THIS.DESCRIBE("datawindow.processing")
	
		THIS.DataObject = stru_info_b.s_dataobject
		
		// Get Result value
		IF ls_Processing = "?" OR ls_Processing = "" THEN
			li_Ret = 3
		ELSEIF ls_Processing = THIS.DESCRIBE("datawindow.processing") THEN
			li_Ret = 1
		ELSE
			li_Ret = 2
		END IF
		
		IF SUPER::SetFullState(stru_info_b.s_fullstate) < 0 THEN RETURN -1
		
	CASE ELSE
		li_Ret = -1
END CHOOSE

// Prevent flickering.  Improve performance.
// This.SetReDraw ( true ) 

// Specifies whether PowerBuilder moves the control to the top of the front-to-back order
//this.BringToTop = true

RETURN li_Ret

end function

private function integer of_setchanges (readonly string as_changes, readonly blob ab_changes, boolean ab_blob);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_setchanges()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//			string 	as_changes		
//			blob   	ab_changes		
//			boolean	ab_blob		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//	 		1.0   Initial version
//==============================================================================

Blob lb_Result
String ls_Result
Long ll_Address, ll_result
Integer li_Pos, li_Ret, arrRowSetList[]
String ls_Type, ls_MatchType, ls_Empty, arrValidation[]
Boolean lb_FullState = FALSE
STR_A	lstru_info_a

// Argument is null
IF IsNull(as_changes) OR IsNull(ab_changes) THEN
	SetNull(li_Ret)
	RETURN li_Ret
END IF

IF THIS.DESCRIBE("datawindow.type") = "" THEN
	RETURN -1
END IF

// Get type
IF ab_blob THEN
	ls_Type = CharA(BlobMid(ab_changes, 1, 1))
ELSE
	ls_Type = MidA(as_changes, 1, 2)
END IF

IF ls_Type <> '41' AND ls_Type <> 'A' THEN RETURN -1

// Reset Flag
IF THIS.DataObject <> is_OriDataObject THEN
	of_IsResetFlag(TRUE)
END IF

// convert BLOB to STRING
IF of_GetMatchType(ls_MatchType, FALSE) < 0 THEN RETURN -1

IF 1 <> ConvertDWAJ_P(REF as_changes, REF ab_changes, REF ll_Address, REF ll_result, REF ls_Empty, REF ls_MatchType, lb_FullState, ab_blob) THEN
	RETURN -1
END IF

ls_Result = Space(ll_result)

// release memory
IF FreeMemoryEX(REF lb_Result, REF ls_Result, ll_Address, ll_result, FALSE) <> 1 OR ls_Result = "" THEN
	IF GetLastErrorCode() = -1 THEN
		RETURN -3
	ELSE
		RETURN -1
	END IF
END IF

IF inv_appeon.of_GetPbChanges(ls_Result, lstru_info_a) < 0 THEN
	RETURN -1
END IF

// match type
IF of_GetMatchType(ls_MatchType, TRUE) < 0 THEN RETURN -1
IF lstru_info_a.s_matchtype <> ls_MatchType THEN
	RETURN -3
END IF

// Init Row Flag info
of_InitRowFlag()

// Get RowSet Lists Info
li_Ret = of_GetRowSetLists(lstru_info_a.s_rowset, lstru_info_a.l_SetCount, arrRowSetList[])
IF li_Ret < 0 THEN RETURN li_Ret

// Clear and Save column properties of validation
IF of_SaveValidation(arrValidation) < 0 THEN RETURN -1

// import data info,row flag info and state info etc.
IF of_SetStatusInfo(primary!, lstru_info_a.s_pstate, &
	lstru_info_a.s_pdata, lstru_info_a.s_pflag, arrRowSetList) < 0 THEN
	RETURN -1
END IF

IF of_SetStatusInfo(Filter!, lstru_info_a.s_fstate, &
	lstru_info_a.s_fdata, lstru_info_a.s_fflag, arrRowSetList) < 0 THEN
	RETURN -1
END IF

IF of_SetStatusInfo(DELETE!, lstru_info_a.s_dstate, &
	lstru_info_a.s_ddata, lstru_info_a.s_dflag, arrRowSetList) < 0 THEN
	RETURN -1
END IF

// Load column properties of validation
IF of_LoadValidation(arrValidation) < 0 THEN RETURN -1

// if exists sort or filter expression
IF THIS.DESCRIBE("DataWindow.Table.Filter") <> '?' THEN THIS.Filter()
IF THIS.DESCRIBE("DataWindow.Table.Sort") <> '?' THEN	THIS.Sort()

RETURN 1
end function

private function long of_importstring (readonly powerobject adw, string as_data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_importstring()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly	powerobject	adw    		
//		value   	string     	as_data			
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String ls_IniVal[]
Long i, nColCount, nCountRet
nColCount = Long(adw.DYNAMIC DESCRIBE("DataWindow.Column.Count"))
FOR i = 1 TO nColCount
	ls_IniVal[i] = adw.DYNAMIC DESCRIBE("#"+String(i) + ".initial")
	IF ls_IniVal[i] <> "null" THEN
		adw.DYNAMIC Modify("#" + String(i) + ".initial = 'null'")
	END IF
NEXT

nCountRet = adw.DYNAMIC ImportString(as_data)

FOR i = 1 TO nColCount
	IF ls_IniVal[i] <> "null" THEN
		adw.DYNAMIC Modify("#" + String(i) + ".initial = '" + ls_IniVal[i] + "'")
	END IF
NEXT

RETURN nCountRet

end function

private function blob of_createblob ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_createblob()
//------------------------------------------------------------------------------
// Description: 
// 			Encapsulates the blob type objects.
//	
// Arguments:(None)
//	
// Returns:  blob
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer	arrDddwID[]
String	arrDddwName[]

//Blob 		bPrimary, bFilter // store data of computed fields (primary and filter) in the detail band
Blob 		bData
Blob{2}  bInteger
Blob{4}  bLong
Blob	bPBState

BlobEdit(bInteger, 1, Integer(9))
bData += bInteger;

// get the information about the DataWindow
of_main_analysis(arrDddwID[], arrDddwName[])

// first part, information about the child DataWindow
bData += of_DddwBlob(arrDddwID, arrDddwName, FALSE)

// second part, information about getfullstate()
SUPER::GetFullState(bPBState)//THIS.getFullState(bPBState)

BlobEdit(bLong, 1, Long(LenA(bPBState)))
bData += bLong + bPBState

RETURN bData

end function

private function integer of_main_analysis (ref integer ai_dddwid[], ref string as_dddwname[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondatastore::of_main_analysis()
//------------------------------------------------------------------------------
// Description: 
// 			Analyzes the main DataWindow object, and gets information about the 
//				computed fields.
//	
// Arguments: 
//		ref	integer	ai_dddwid[]  		 - Required.
//		ref	string 	as_dddwname[]		 - Required.
//	
// Returns:  integer
//				Returns -1 if an error occurs.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long		i, ll_Dddw
String 	ls_Name, ls_Objects, arrObject[]

// get all the objects in the DataWindow
ls_Objects = THIS.DESCRIBE('datawindow.objects')
inv_appeon.of_decomposetoarray(ls_Objects, '~t', arrObject)

FOR i = 1 TO UpperBound(arrObject)	
	// the child datawindow's ID
	IF THIS.DESCRIBE(arrObject[i] + '.Edit.Style') = 'dddw' THEN
		ll_Dddw++
		ls_Name 	 = THIS.DESCRIBE(arrObject[i] + ".name")
		
		ai_dddwID[ll_Dddw] 	 = Integer(THIS.DESCRIBE(ls_Name + ".ID"))
		as_dddwName[ll_Dddw] = ls_Name
	END IF
	
NEXT

RETURN 1
end function

on appeondatastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeondatastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

