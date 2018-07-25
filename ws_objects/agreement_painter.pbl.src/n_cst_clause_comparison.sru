$PBExportHeader$n_cst_clause_comparison.sru
forward
global type n_cst_clause_comparison from nonvisualobject
end type
end forward

global type n_cst_clause_comparison from nonvisualobject
end type
global n_cst_clause_comparison n_cst_clause_comparison

type variables
String is_call_from 
String is_step
Long il_source_clause, il_source_handle
String is_source_clausename
Long il_handle_all[],il_handle_empty[] //Added By Ken.Guo 2009-05-07
DataStore ids_target_clauses

Window iw_parent
Treeview itv_clause

//Added By Ken.Guo 2010-01-20.
Datawindow idw_browse 
Decimal{1} idec_source_revision

end variables

forward prototypes
public function integer of_start_compare_clauses (window aw_parent, treeview atv_clause, string as_call_from)
public function integer of_select_clause (long al_handle, long al_clause)
public subroutine of_close_comparison (string as_call_from)
public subroutine of_close_comparison_wizard (string as_call_from)
public function integer of_ini_info ()
public function integer of_refresh_info ()
public subroutine of_clear_flag ()
public function integer of_select_clause (long al_row)
public subroutine of_clear_dw_flag ()
public function integer of_start_compare_clauses (window aw_parent, datawindow adw_browse, string as_call_from)
public function string of_get_flag (long al_clause_id, decimal adec_revision)
end prototypes

public function integer of_start_compare_clauses (window aw_parent, treeview atv_clause, string as_call_from);String ls_call_from

//Return if the comparison window is opened before 
IF IsValid(w_clause_comparison_wizard) THEN 
	ls_call_from = w_clause_comparison_wizard.of_get_call_from()
END IF
IF Len(Trim(ls_call_from)) > 0 THEN
	//If already opened in other module before, then prompt the message.
	IF ls_call_from <> as_call_from THEN MessageBox("Clause Comparison","The Clause Comparison window has been opened in other module, please close it first.")
	RETURN 0
END IF

//Initilize the variables
iw_parent = aw_parent
itv_clause = atv_clause
is_call_from = as_call_from
is_step = 'source' 

//Open compare wizard window
OpenwithParm(w_clause_comparison_wizard, This, aw_parent)

//CHOOSE CASE Lower(as_call_from)
//	CASE 'clause'
//		
//		
//	CASE 'template'
//	CASE 'document'
//END CHOOSE

RETURN 1
end function

public function integer of_select_clause (long al_handle, long al_clause);//*****Select the source or target clause(s) to compare *****//

//Return if not under clause comparison mode
IF IsNull(is_step) OR Len(Trim(is_step)) < 1 THEN RETURN 0
IF Not IsValid(itv_clause) OR al_handle < 1 THEN RETURN -1
IF Lower(is_step) <> 'source' AND Lower(is_step) <> 'target' THEN RETURN 0

Long ll_found, ll_row
TreeviewItem l_tvi, l_tvi_last

itv_clause.GetItem(al_handle,l_tvi)

//IF l_tvi.Children = TRUE THEN RETURN 0 //Only for clause section	
//Modified By Ken.Guo 2010-01-21
If l_tvi.selectedpictureindex <> 3 and l_tvi.selectedpictureindex <> 4 and l_tvi.selectedpictureindex <> 5 Then 
	Return 0 
End If

il_handle_all[UpperBound(il_handle_all) + 1] = al_handle //Added By Ken.Guo 2009-05-07

//Select source clause.
IF Lower(is_step) = 'source' THEN
	//Select a new source clause
	IF l_tvi.Statepictureindex <> 1 THEN 
		//Clear state picture for last source clause
		IF il_source_handle > 0 and il_source_handle <> al_handle THEN
			IF itv_clause.GetItem(il_source_handle, l_tvi_last) = 1 THEN
				l_tvi_last.StatePictureindex = 0
				itv_clause.Setitem(il_source_handle,l_tvi_last)
			END IF
		END IF
		//Reset the datastore to target clauses if it's a target clause
		IF l_tvi.Statepictureindex = 2 THEN
			ll_found = ids_target_clauses.Find('ctx_acp_clause_id = ' + String(al_clause), 1, ids_target_clauses.RowCount())
			IF ll_found > 0 THEN ids_target_clauses.DeleteRow(ll_found)
		END IF
		//Assign the state picture
		l_tvi.Statepictureindex = 1
		itv_clause.Setitem(al_handle,l_tvi)
		il_source_handle = al_handle
		il_source_clause = al_clause	
		is_source_clausename = l_tvi.label
	//Unselect the source clause
	ELSE	
		//Clear the state picture
		l_tvi.StatePictureindex = 0
		itv_clause.Setitem(al_handle,l_tvi)
		il_source_handle = -1
		il_source_clause = -1	
		is_source_clausename = ""
	END IF
END IF

//Select target clause
IF Lower(is_step) = 'target' THEN
	//Return if it's already a source clause 
	IF l_tvi.Statepictureindex = 1 THEN RETURN 0
	//Select a new target clause
	IF l_tvi.Statepictureindex <> 2 THEN 
		//Assign the state picture
		l_tvi.Statepictureindex = 2
		itv_clause.Setitem(al_handle,l_tvi)
		//Set datastore to target clauses
		ll_found = ids_target_clauses.Find('ctx_acp_clause_id = ' + String(al_clause), 1, ids_target_clauses.RowCount()) 
		IF ll_found < 1 THEN 
			ll_row = ids_target_clauses.InsertRow(0)
			ids_target_clauses.SetItem(ll_row, 'ctx_acp_clause_id', al_clause)
			ids_target_clauses.SetItem(ll_row, 'clause_name', l_tvi.label)
		END IF
	//Unselect the target clause
	ELSE	
		//Clear the state picture
		l_tvi.StatePictureindex = 0
		itv_clause.Setitem(al_handle,l_tvi)
		//Clear datastore to target clauses
		ll_found = ids_target_clauses.Find('ctx_acp_clause_id = ' + String(al_clause), 1, ids_target_clauses.RowCount())
		IF ll_found > 0 THEN ids_target_clauses.DeleteRow(ll_found)		
	END IF
END IF

RETURN 1
end function

public subroutine of_close_comparison (string as_call_from);//Close comparison window - called in parent window closed event
IF IsValid(w_clause_comparison_wizard) THEN
	IF w_clause_comparison_wizard.of_get_call_from() = as_call_from THEN
		Close(w_clause_comparison_wizard)
	END IF
END IF

end subroutine

public subroutine of_close_comparison_wizard (string as_call_from);//Called after treeview refreshed

//Refresh the comparison info
of_refresh_info() 	

//Close comparison wizard window while the step isn't 'compare'
IF is_step <> 'compare' AND IsValid(w_clause_comparison_wizard) THEN
	IF w_clause_comparison_wizard.of_get_call_from() = as_call_from THEN
		Close(w_clause_comparison_wizard)
	END IF
END IF



end subroutine

public function integer of_ini_info ();//initilize the comparison info.

is_step = ''
il_source_clause = -1
il_source_handle = -1
is_source_clausename = ""

idec_source_revision = 0 //Added By Ken.Guo 2010-01-20.
ids_target_clauses.Reset()

RETURN 1


end function

public function integer of_refresh_info ();//refresh the comparison info after clause treeview refreshed.

il_source_clause = -1
il_source_handle = -1
is_source_clausename = ""

idec_source_revision = 0 //Added By Ken.Guo 2010-01-20.
ids_target_clauses.Reset()

RETURN 1


end function

public subroutine of_clear_flag ();//////////////////////////////////////////////////////////////////////
// Function: of_clear_flag()
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2009-05-07
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////


Integer i,li_ret
TreeviewItem l_tvi, l_tvi_last
For i = 1 To UpperBound(il_handle_all[])
	li_ret = itv_clause.GetItem(il_handle_all[i],l_tvi)
	If li_ret = 1 Then
		//IF l_tvi.Children = TRUE THEN Continue //Commented By Ken.Guo 2010-01-21
		l_tvi.StatePictureindex = 0
		itv_clause.Setitem(il_handle_all[i],l_tvi)
	End If
Next
il_handle_all[] = il_handle_empty[]

/*
//Clear out the compare flags in browse datawindow
Long ll_cnt, ll_found

IF NOT IsValid(idw_browse) THEN RETURN

ll_cnt = idw_browse.RowCount()
DO
	ll_found = idw_browse.Find("compare_status = '1'", 1, ll_cnt)
	IF ll_found > 0 THEN idw_browse.SetItem(ll_found, "compare_status", '')
LOOP While ll_found > 0

DO
	ll_found = idw_browse.Find("compare_status = '2'", 1, ll_cnt)
	IF ll_found > 0 THEN idw_browse.SetItem(ll_found, "compare_status", '')	
LOOP While ll_found > 0

RETURN
*/
end subroutine

public function integer of_select_clause (long al_row);//*****Select the source or target clause(s) to compare *****//

//Return if not under clause comparison mode

IF IsNull(is_step) OR Len(Trim(is_step)) < 1 THEN RETURN 0
If al_row <= 0 Then Return 0
IF Lower(is_step) <> 'source' AND Lower(is_step) <> 'target' THEN RETURN 0

Long ll_found, ll_row
Long ll_clause_id
Decimal ldec_revision
String ls_clause_name

ll_clause_id = idw_browse.GetItemNumber(al_row, 'ctx_acp_clause_id')
If idw_browse.getitemnumber(al_row,'level') = 2 Then
	ldec_revision = idw_browse.getitemdecimal(al_row,'audit_version')
Else
	ldec_revision = idw_browse.getitemdecimal(al_row,'revision')
End If
ls_clause_name = idw_browse.GetItemString(al_row,'clause_name')

//Select source clause.
IF Lower(is_step) = 'source' THEN
	
	//if click the old source then clear it
	If idw_browse.getitemstring(al_row , 'compare_status') = '1' Then
		idw_browse.SetItem(al_row,'compare_status','')
		il_source_clause = -1
		idec_source_revision = 0
		Return 1
	End If

	//clear old source if exists. 
	This.of_clear_dw_flag()
	
	//Set New source
	idw_browse.SetItem(al_row,'compare_status','1')
	il_source_clause = ll_clause_id
	idec_source_revision = ldec_revision
	is_source_clausename = ls_clause_name
End If	

//Select target clause
IF Lower(is_step) = 'target' THEN
	
	//If click source row, then return
	If idw_browse.getitemstring(al_row , 'compare_status') = '1' Then
		Return 0
	End If
	
	If il_source_clause = ll_clause_id and idec_source_revision = ldec_revision Then 
		Return 0
	End If
	
	If idw_browse.getitemstring(al_row , 'compare_status') <> '2' Then
		//select the target row
		ll_found = ids_target_clauses.Find('ctx_acp_clause_id = ' + String(ll_clause_id) + ' And revision = ' + String(ldec_revision), 1, ids_target_clauses.RowCount())
		If ll_found < 1 Then 
			idw_browse.setitem(al_row , 'compare_status','2')
			ll_row = ids_target_clauses.InsertRow(0)
			ids_target_clauses.SetItem(ll_row, 'ctx_acp_clause_id', ll_clause_id)
			ids_target_clauses.SetItem(ll_row, 'revision', ldec_revision)
			ids_target_clauses.SetItem(ll_row, 'clause_name',ls_clause_name)			
		Else
			//if exists, then return
			//'Please select a clause with a different revision!'
			IF IsValid(w_clause_comparison_wizard) THEN
				Beep(1)
				w_clause_comparison_wizard.st_alert.text = "Please select a clause with a different revision!"	
			END IF			
			Return 0
		End If		
	Else
		//unselect the target row
		idw_browse.setitem(al_row , 'compare_status','')
		ll_found = ids_target_clauses.Find('ctx_acp_clause_id = ' + String(ll_clause_id) + ' And revision = ' + String(ldec_revision), 1, ids_target_clauses.RowCount())
		If ll_found > 0 Then 
			ids_target_clauses.DeleteRow(ll_found)
		End If		
	End If
	IF IsValid(w_clause_comparison_wizard) THEN w_clause_comparison_wizard.st_alert.text = ""
End If

Return 1
end function

public subroutine of_clear_dw_flag ();//Clear out the compare flags in browse datawindow
Long ll_cnt, ll_found,i
String ls_value1[],ls_value2[]

IF NOT IsValid(idw_browse) THEN RETURN

ll_cnt = idw_browse.RowCount()
If ll_cnt > 0 Then
	For i = 1 to ll_cnt
		ls_value1[i] = ''
	Next
	idw_browse.object.compare_status[1,ll_cnt] = ls_value1[]
End If

ll_cnt = idw_browse.FilteredCount()
If ll_cnt > 0 Then
	For i = 1 to ll_cnt
		ls_value2[i] = ''
	Next
	idw_browse.object.compare_status.filter[1,ll_cnt] = ls_value2[]
End If



RETURN

end subroutine

public function integer of_start_compare_clauses (window aw_parent, datawindow adw_browse, string as_call_from);String ls_call_from

//Return if the comparison window is opened before 
IF IsValid(w_clause_comparison_wizard) THEN 
	ls_call_from = w_clause_comparison_wizard.of_get_call_from()
END IF
IF Len(Trim(ls_call_from)) > 0 THEN
	//If already opened in other module before, then prompt the message.
	IF ls_call_from <> as_call_from THEN MessageBox("Clause Comparison","The Clause Comparison window has been opened in other module, please close it first.")
	RETURN 0
END IF

//Initilize the variables
iw_parent = aw_parent
idw_browse = adw_browse
is_call_from = as_call_from
is_step = 'source' 

//Open compare wizard window
OpenwithParm(w_clause_comparison_wizard, This, aw_parent)


RETURN 1

return 1

end function

public function string of_get_flag (long al_clause_id, decimal adec_revision);//Get comparison flag based on clause id & rev id after a collapse & expand operation in browse datawindow
Long  ll_cnt
String ls_find

IF IsNull(al_clause_id) OR al_clause_id < 1 THEN RETURN ""
IF IsNull(adec_revision) OR adec_revision < 0 THEN RETURN ""
IF NOT IsValid(idw_browse) THEN RETURN ""

//for a duplicate document record
ll_cnt = idw_browse.RowCount()
ls_find = "ctx_acp_clause_id = " + String(al_clause_id) +" And (compare_status = '1' or compare_status = '2')" + &
		    " And ((Level = 1 And revision = " + String(adec_revision) + ") OR (Level = 2 AND audit_version = " + String(adec_revision) + "))"
IF idw_browse.Find(ls_find, 1, ll_cnt) > 0 THEN RETURN ""

//for a source document
IF al_clause_id = il_source_clause AND adec_revision = idec_source_revision THEN RETURN '1'

//For a target document
ll_cnt = ids_target_clauses.RowCount()
IF ll_cnt < 1 THEN RETURN ""
IF ids_target_clauses.Find("ctx_acp_clause_id = " + String(al_clause_id) + " And revision = " + String(adec_revision), 1, ll_cnt) > 0 THEN
	RETURN "2"
END IF

RETURN ''
end function

on n_cst_clause_comparison.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_clause_comparison.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_target_clauses = Create DataStore
ids_target_clauses.DataObject = 'd_clause_comparison'

ids_target_clauses.SetTransObject(SQLCA)
end event

event destructor;Destroy ids_target_clauses
end event

