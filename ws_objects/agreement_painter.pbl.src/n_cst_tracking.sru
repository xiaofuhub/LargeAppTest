$PBExportHeader$n_cst_tracking.sru
forward
global type n_cst_tracking from nonvisualobject
end type
end forward

global type n_cst_tracking from nonvisualobject autoinstantiate
end type

type variables
Public:
Constant	String template_library_painter   	= 'Template Library Painter'
Constant String document_management		= 'Document Management'

DataStore ids_sys_tracking_log

end variables

forward prototypes
public function integer of_tracking_doc_delete (string as_modules)
public function integer of_tracking_doc_add (string as_modules, string as_value1, string as_value2, string as_value3, string as_notes)
public function integer of_find_recorde (string as_modules, string as_value1, string as_value2, string as_value3, ref str_sys_tracking_log_arr astr_sys_tracking_log_arr_s)
public subroutine of_init_datastore ()
public subroutine of_tracking_doc (string as_modules, string as_value1, string as_value2, string as_value3, string as_notes, string as_operation, boolean abln_deleteallflag)
end prototypes

public function integer of_tracking_doc_delete (string as_modules);//====================================================================
// Function: of_tracking_doc_delete
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_modules
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/19/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Delete From sys_tracking_log
Where session_id = :gs_session_id And modules = :as_modules
Using Sqlca;

If Sqlca.Sqlcode < 0 Then 
	MessageBox("SQL Error", sqlca.SQLErrText )
	Rollback;
	Return 0
Else
	Commit;
	Return 1
End If 
end function

public function integer of_tracking_doc_add (string as_modules, string as_value1, string as_value2, string as_value3, string as_notes);//====================================================================
// Function: of_tracking_doc_add
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_modules
//                as_value1
//                as_value2
//                as_value3
//                as_notes
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/20/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 	ll_insertrow

if (isnull(gs_session_id) or gs_session_id = "") and upper(gs_user_id) = "MASTER" then return 1 //(Appeon)Harry 03.31.2014 - V142 ISG-CLX

ll_insertrow	=	ids_sys_tracking_log.insertrow(0)

ids_sys_tracking_log.SetItem( ll_insertrow, 'sys_tracking_log_session_id', gs_session_id)
ids_sys_tracking_log.SetItem( ll_insertrow, 'sys_tracking_log_modules', as_modules)
ids_sys_tracking_log.SetItem( ll_insertrow, 'sys_tracking_log_value1', as_value1)
ids_sys_tracking_log.SetItem( ll_insertrow, 'sys_tracking_log_value2', as_value2)
ids_sys_tracking_log.SetItem( ll_insertrow, 'sys_tracking_log_value3', as_value3)
ids_sys_tracking_log.SetItem( ll_insertrow, 'sys_tracking_log_notes', as_notes)
ids_sys_tracking_log.SetItem( ll_insertrow, 'sys_tracking_log_open_datetime',  DateTime( Today(), Now() ))

If ids_sys_tracking_log.update() = 1 Then
	Commit;
	Return 1
Else
	Rollback;
	MessageBox("SQL Error", sqlca.SQLErrText )
	Return -1 
End IF

end function

public function integer of_find_recorde (string as_modules, string as_value1, string as_value2, string as_value3, ref str_sys_tracking_log_arr astr_sys_tracking_log_arr_s);//====================================================================
// Function: of_find_recorde
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_modules
//                as_value1
//                as_value2
//                as_value3
//                astr_sys_tracking_log_arr_s
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/20/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 		ll_find, ll_row, ll_rowcount,  j
String 	ls_finder

If Not isvalid(ids_sys_tracking_log) Then
	of_init_datastore()
End IF 
		
If ids_sys_tracking_log.rowcount( ) > 0 Then
	ids_sys_tracking_log.reset( )
End If
ll_rowcount = ids_sys_tracking_log.retrieve( )
ll_row = 1 
j = 0 

If ll_rowcount > 0 Then
	ls_finder = " sys_tracking_log_modules ='"+as_modules+"' "
	If Not isnull(as_value1) and trim(as_value1) <> ''  Then
		ls_finder += " and sys_tracking_log_value1 ='"+as_value1+"' "
	End If
	If Not isnull(as_value2) and trim(as_value2) <> ''  Then
		ls_finder += " and sys_tracking_log_value2 ='"+as_value2+"' "
	End If
	If Not isnull(as_value3) and trim(as_value3) <> ''  Then
		ls_finder += " and sys_tracking_log_value3 ='"+as_value3+"' "
	End If
	DO
		ll_find = ids_sys_tracking_log.find(ls_finder, ll_row, ll_rowcount)
		If ll_find > 0 then 
			If ll_row > ll_rowcount Then 
				Exit
			End If 
			ll_row = ll_find + 1
			j++
			astr_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[j].as_session_id	=ids_sys_tracking_log.GetItemString(ll_find,"sys_tracking_log_session_id")
			astr_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[j].as_modules	=ids_sys_tracking_log.GetItemString(ll_find,"sys_tracking_log_modules")
			astr_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[j].as_value1		=ids_sys_tracking_log.GetItemString(ll_find,"sys_tracking_log_value1")
			astr_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[j].as_value2		=ids_sys_tracking_log.GetItemString(ll_find,"sys_tracking_log_value2")
			astr_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[j].as_value3		=ids_sys_tracking_log.GetItemString(ll_find,"sys_tracking_log_value3")
			astr_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[j].as_user			=ids_sys_tracking_log.GetItemString(ll_find,"session_info_user_id")
		End If 
	LOOP WHILE ll_find > 0
	If j > 0 Then 
		Return 1
	Else
		Return 0
	End If
Else
	Return 0
End If


end function

public subroutine of_init_datastore ();//====================================================================
// Function: of_init_datastore
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/20/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

ids_sys_tracking_log = Create DataStore
ids_sys_tracking_log.dataobject = "d_sys_tracking_log"
ids_sys_tracking_log.SetTransObject(SQLCA)
end subroutine

public subroutine of_tracking_doc (string as_modules, string as_value1, string as_value2, string as_value3, string as_notes, string as_operation, boolean abln_deleteallflag);//====================================================================
// Function: of_tracking_doc
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_modules
//                as_value1
//                as_value2
//                as_value3
//                as_notes
//                as_operation
//                abln_deleteallflag
//--------------------------------------------------------------------
// Returns:  none
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/19/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 		ll_find, ll_rowcnt
string 	ls_finder, ls_delete

If isnull(as_modules) or trim(as_modules) = '' Then 
	Return
End If 

If ( isnull(as_value1) or trim(as_value1) = '' ) And  ( isnull(as_value2) or trim(as_value2) = '' ) And  ( isnull(as_value3) or trim(as_value3) = '' ) Then 
	Return
End If 

If abln_deleteallflag Then 
	of_tracking_doc_delete(as_modules)
End If 

Choose Case as_operation
	Case 'add_doc_tracking'
		If Not isvalid(ids_sys_tracking_log) Then
			of_init_datastore()
		End IF 
		
		ids_sys_tracking_log.reset( )
		ll_rowcnt = ids_sys_tracking_log.retrieve( )	
		If ll_rowcnt > 0 Then
			ls_finder = " sys_tracking_log_session_id ='"+gs_session_id+"' and sys_tracking_log_modules ='"+as_modules+"' "
			If Not isnull(as_value1) and trim(as_value1) <> ''  Then
				ls_finder += " and sys_tracking_log_value1 ='"+as_value1+"' "
			End If
			If Not isnull(as_value2) and trim(as_value2) <> ''  Then
				ls_finder += " and sys_tracking_log_value2 ='"+as_value2+"' "
			End If
			If Not isnull(as_value3) and trim(as_value3) <> ''  Then
				ls_finder += " and sys_tracking_log_value3 ='"+as_value3+"' "
			End If
			
			ll_find = ids_sys_tracking_log.find(ls_finder, 1, ll_rowcnt)
			If ll_find > 0 Then 
				ids_sys_tracking_log.SetItem( ll_find, 'sys_tracking_log_open_datetime',  DateTime( Today(), Now() ))
				If ids_sys_tracking_log.update() = 1 Then
					Commit;
					Return 
				Else
					Rollback;
					MessageBox("SQL Error", sqlca.SQLErrText )
					Return 
				End IF
			Else
				of_tracking_doc_add(as_modules,as_value1,as_value2,as_value3,as_notes)					
			End If 
		Else
			of_tracking_doc_add(as_modules,as_value1,as_value2,as_value3,as_notes)
		End If
			
	Case 'delete_doc_tracking'
		If abln_deleteallflag = False Then
			ls_delete = " Delete From sys_tracking_log 	Where session_id ='"+gs_session_id+"' And modules ='"+as_modules+"' "
			If Not isnull(as_value1) and trim(as_value1) <> ''  Then
				ls_delete += " and value1 ='"+as_value1+"' "
			End If
			If Not isnull(as_value2) and trim(as_value2) <> ''  Then
				ls_delete += " and value2 ='"+as_value2+"' "
			End If
			If Not isnull(as_value3) and trim(as_value3) <> ''  Then
				ls_delete += " and value3 ='"+as_value3+"' "
			End If
			
			EXECUTE IMMEDIATE :ls_delete USING Sqlca ;
			
			If Sqlca.Sqlcode < 0 Then 
				MessageBox("SQL Error", sqlca.SQLErrText )
				Rollback;
				Return 
			Else
				Commit;
				Return 
			End If 
		End If 
End Choose 
end subroutine

event constructor;//ids_sys_tracking_log = Create DataStore
//ids_sys_tracking_log.dataobject = "d_sys_tracking_log"
//ids_sys_tracking_log.SetTransObject(SQLCA)
end event

on n_cst_tracking.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_tracking.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;IF isvalid(ids_sys_tracking_log) then
	Destroy ids_sys_tracking_log
End If
end event

