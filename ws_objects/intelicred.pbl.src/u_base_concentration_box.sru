$PBExportHeader$u_base_concentration_box.sru
$PBExportComments$Concentration box user object ancestor
forward
global type u_base_concentration_box from userobject
end type
type cb_clear_all from u_cb within u_base_concentration_box
end type
type cb_clear from u_cb within u_base_concentration_box
end type
type cb_add_all from u_cb within u_base_concentration_box
end type
type cb_add from u_cb within u_base_concentration_box
end type
type dw_selected from u_dw within u_base_concentration_box
end type
type dw_available from u_dw within u_base_concentration_box
end type
end forward

global type u_base_concentration_box from userobject
integer width = 2510
integer height = 1000
long backcolor = 33551856
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
cb_clear_all cb_clear_all
cb_clear cb_clear
cb_add_all cb_add_all
cb_add cb_add
dw_selected dw_selected
dw_available dw_available
end type
global u_base_concentration_box u_base_concentration_box

forward prototypes
public subroutine of_copy_rows (datawindow adw_from, datawindow adw_to)
public function integer of_update ()
public function integer of_discard_dups (string as_available_columns[], string as_selected_columns[])
public function string of_build_expression (string as_column, string as_operator, string as_value)
end prototypes

public subroutine of_copy_rows (datawindow adw_from, datawindow adw_to);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_copy_rows
//
//	Access:  		public
//
//	Arguments:		
//
//	adw_from			The data window that contains the selected rows
//						that need to be moved to the other datawindow
//
//	adw_to			The data window that should be updated with the
//						selected rows from the From datawindow.
//
//	Returns:  		none
//						
//
//	Description:  	This function is used to add, add all, remove,
//						and remove all rows in the concentration boxes.
//						The user specifies which dw is the from datawindow
//						and which dw is the to datawindow.
//
//						Step 1 is to determine the rows in adw_from that
//						have been selected.
//						Step 2 is to copy those selected rows from adw_from
//						to adw_to.
//						Step 3 is to remove those selected rows from adw_from.
//						Step 4 is to unhighlight and sort adw_to.
//
//////////////////////////////////////////////////////////////////////////////

long ll_row , ll_selected_rows[] , ll_count , ll_index 

SetPointer(HourGlass!)

ll_count = 0 
ll_row = 0 

DO WHILE TRUE 
	ll_row = adw_from.GetSelectedRow ( ll_row ) 
	IF ll_row < 1 THEN EXIT 
	ll_count ++ 
	ll_selected_rows[ll_count] = ll_row 
LOOP 

IF ll_count < 1 THEN RETURN // Nothing to add. 

adw_to.SelectRow ( 0 , FALSE ) 

FOR ll_index = 1 TO ll_count 
	ll_row = ll_selected_rows[ll_index] 
	adw_from.RowsCopy(ll_row, ll_row, Primary!, &
			adw_to, 1000, Primary!)
	// Rmn and JGS - Adding event to the dw_controls that can be used
	// to set any key values on an add.  For example, if the selected dw
	// has a key field that is passed from the calling window, the key field
	// in the selected dw control can be populated here.
	//adw_to.triggerevent("ue_add_row")
	//adw_to.event dynamic trigger ue_add_row(ll_row)
NEXT 

FOR ll_index = ll_count TO 1 STEP -1 
	ll_row = ll_selected_rows[ll_index] 
	adw_from.RowsMove(ll_row, ll_row, Primary!, &
			adw_from, 1, Delete!)
NEXT 
 
adw_to.Sort()

adw_to.SelectRow ( 0 , FALSE ) 

end subroutine

public function integer of_update ();//************************************************************
// Object: u_base_concentration_box
// Method: of_update
// Date  : 11/97
//
// Arg   :
// Return: integer
//
// Desc  :	Determine if each datawindow is updateable, then
//				call pfc_update
//
//************************************************************
// Copyright © 1996 HMIS, Inc..  All Rights Reserved.
// Any distribution of the HMIS Software source code by other
// than HMIS is prohibited.
//************************************************************
// Modifications:
// Date            Author         Comments
//------------------------------------------------------------
// 11/97		       L. Snickers    Original version
// 04/98				 J. Smith       Change to reset update flags
//                 WTG
//************************************************************

int li_return

IF dw_selected.of_IsUpdateable() THEN
	li_return = dw_selected.Trigger Event pfc_update(TRUE,TRUE)
	IF li_return = 1 THEN
		COMMIT using SQLCA;
	ELSE
		ROLLBACK using SQLCA;
		return li_return
	END IF
END IF

IF dw_available.of_IsUpdateable() THEN
	li_return = dw_available.Trigger Event pfc_update(TRUE, TRUE)
	IF li_return = 1 THEN
		COMMIT using SQLCA;
	ELSE
		ROLLBACK using SQLCA;
		return li_return
	END IF
END IF
	
return li_return
end function

public function integer of_discard_dups (string as_available_columns[], string as_selected_columns[]);//************************************************************
// Object: u_base_concentration_box
// Method: of_discard_dups
// Date  : 12/23/97
//
// Arg   :	as_available_columns[]	-	Contains all of list of unique/key columns 
//													in the available datawindow
//				as_selected_columns[]	-	Contains all of list of unique/key columns 
//													in the selected datawindow
// Return: integer
//
// Desc  :	The purpose of this function is to discard the rows from the available
//				datawindow that have already been selected.  For example, if the available list
//				is 'A','B','C' and the selected list is 'B', we only want to show the user
//				the 'A' and 'C' in the selected list.  
//				THis function should be called when the concentration box information is 
//				originally retrieved.  The code that you need to put in your decendent is
//				something like the following:
//
//					string	ls_avail_cols[], ls_selected_cols[]
//					ls_avail_cols[1] = 'fund_item_id'
//					ls_selected_cols[1] = 'product_fund_fun_item_id'
//					of_discard_dups(ls_avail_cols, ls_selected_cols)
//
//				This function is expecting two parameters.
//				as_available_columns[] is a string array and needs to include the key columns
//				form the available datawindow - key columns are those columns that make the
//				row unique.
//				as_selected_columns[] is a string array and needs to include the key columns
//				form the selected datawindow - key columns are those columns that make the
//				row unique.
//
//				The two parameters need to contain at least one entry and both have the same
//				number of entries.
//				Two arrays are being used to handle the case where the column names in the
//				two different datawindows do not match.  
//
//************************************************************
// Copyright © 1996 HMIS, Inc..  All Rights Reserved.
// Any distribution of the HMIS Software source code by other
// than HMIS is prohibited.
//************************************************************
// Modifications:
// Date            Author         Comments
//------------------------------------------------------------
// 12/23/97      Rene Nordin    Original version
//************************************************************

long		ll_row_ctr, ll_col_ctr, ll_find_row
long		ll_max_available_cols, ll_max_selected_cols
string	ls_find, ls_value, ls_temp_find

SetPointer(HourGlass!)

// get the number of columns in each array
ll_max_available_cols = Upperbound(as_available_columns)
ll_max_selected_cols = Upperbound(as_selected_columns)

// If the number of columns are not the same then display message
IF ll_max_available_cols <> ll_max_selected_cols THEN
	MessageBox('HMIS','Discard Dups - please enter the same number of columns for available and selected')
	return -1
END IF

// If one of the arrays has 0 columns, display message
IF ll_max_available_cols = 0 THEN
	MessageBox('HMIS','Discard Dups - please enter the key columns for available and selected')
	return -1
END IF

// loop thru all the rows in the selected window, get the values and find the corresponding
//	row in the available datawindow and discard it.  
For ll_row_ctr = 1 to dw_selected.RowCount()
	ls_Find = ''
	
	// loop thru the number of columns in the available array (remember, same number of
	//	columns exists in the selected array
	For ll_col_ctr = 1 to Upperbound(as_available_columns)
		
		// get the value of the column in the selected datawindow for the current row and column
		ls_value = string( dw_selected.inv_rowselect.of_GetItemAny(ll_row_ctr, as_selected_columns[ll_col_ctr]) )
		
		// build the find expression using the value found in the selected datawindow and
		// the column name in the available datawindow.  
		
		ls_temp_find = of_build_expression(as_available_columns[ll_col_ctr],'=',ls_value)
		
		// If there was a problem building the expression, a ! is returned.  If the ls_find
		//	variable already has find criteria, add this find to the criteria.
		IF ls_temp_find <> '!' THEN
			IF LenA(Trim(ls_find)) > 0 THEN 
				ls_find = ls_find + ' and ' + ls_temp_find
			Else
				ls_find = ls_temp_find
			END IF
		Else
			MessageBox('HMIS','Discard Dups - Could not build the find expression for column - ' + as_available_columns[ll_col_ctr])
		END IF
	Next
	
	// If ls_find contains criteria, then do a find.  If row is found, discard it from
	// the available window.
	IF ls_find <> '' THEN
		ll_find_row = dw_available.Find(ls_find,1,dw_available.RowCount())
		IF ll_find_row > 0 THEN
			// AKS Instead of discarding rows, the rows will be moved to delete buffer,
			// so that they can be used again, instead of re-retrieving, in case the driving
			// column can be changed
//			dw_available.RowsDiscard(ll_find_row,ll_find_row,Primary!)
			dw_available.RowsMove(ll_find_row,ll_find_row,Primary!, dw_available, 1, Delete!)
		END IF
	END IF
next

return 1



end function

public function string of_build_expression (string as_column, string as_operator, string as_value);//************************************************************
// Object: u_base_concentration_box
// Method: of_build_expression
// Date  : 12/23/97
//
// Arg   :	as_column	- 	Name of the column 
//				as_operator	-	Type of operator ('=')
//				as_value		-	The value to search for
// Return: string
//
// Desc  :	This code was stolen from the pfc_n_cst_dwsrv of_build_expression.  Could
//				not use that code directly because we are dealing with two different datawindows
//				and the column names are not always the same.  So stole the base code and 
//				modified it for our use.
//
//************************************************************
// Copyright © 1996 HMIS, Inc..  All Rights Reserved.
// Any distribution of the HMIS Software source code by other
// than HMIS is prohibited.
//************************************************************
// Modifications:
// Date            Author         Comments
//------------------------------------------------------------
// 12/23/97      Rene Nordin    Original version
//******************************************************


string		ls_coltype, ls_expression

SetPointer(HourGlass!)


// Get the column type.
ls_coltype = dw_available.Describe(as_column +'.ColType')
If ls_coltype='!' or ls_coltype='?' Then Return '!'

If IsNull(as_value) Then
	//-- Build NULL value expressions. --
	ls_expression = 'IsNull('+as_column+')'

Else
	//-- Build NonNull value expressions. --

	// Start building the Find expression.
	ls_expression = as_column + ' ' + as_operator + ' '

	// Wrap the value with datatype conversion functions, so that
	// the value is valid in Find expressions.
	//	Note: a number value does not need any special handling.
	Choose Case Lower ( LeftA (ls_coltype, 5 ) )
		
		// CHARACTER DATATYPE		
		Case "char("	
			ls_expression += "'" + as_value + "'"
	
		// DATE DATATYPE	
		Case "date"					
			ls_expression += "Date('" + as_value  + "')" 

		// DATETIME DATATYPE
		Case "datet"				
			ls_expression += "DateTime('" + as_value + "')" 

		// TIME DATATYPE
		Case "time", "times"		
			ls_expression += "Time('" + as_value + "')" 
	
		// Number
		Case 	Else
			ls_expression += as_value

	End Choose
End If

Return ls_expression
end function

on u_base_concentration_box.create
this.cb_clear_all=create cb_clear_all
this.cb_clear=create cb_clear
this.cb_add_all=create cb_add_all
this.cb_add=create cb_add
this.dw_selected=create dw_selected
this.dw_available=create dw_available
this.Control[]={this.cb_clear_all,&
this.cb_clear,&
this.cb_add_all,&
this.cb_add,&
this.dw_selected,&
this.dw_available}
end on

on u_base_concentration_box.destroy
destroy(this.cb_clear_all)
destroy(this.cb_clear)
destroy(this.cb_add_all)
destroy(this.cb_add)
destroy(this.dw_selected)
destroy(this.dw_available)
end on

event constructor;SetPointer(HourGlass!)

dw_available.of_SetBase(TRUE)
dw_selected.of_SetBase(TRUE)


// assume that the available datawindow is not updateable.  If needed, this can be
// overrided in the constructor script of the ancestor
dw_available.of_setupdateable(FALSE)

// Turn on single-row selection service on the criteria datawindow
dw_available.of_SetRowSelect(TRUE)
//dw_available.inv_rowselect.of_SetStyle(1)
//Use this when multi-row selection is desired
dw_available.inv_rowselect.of_SetStyle(2)

// Turn on single-row selection service on the selected datawindow
dw_selected.of_SetRowSelect(TRUE)
//dw_selected.inv_rowselect.of_SetStyle(1)
//Use this when multi-row selection is desired
dw_selected.inv_rowselect.of_SetStyle(2)

dw_selected.of_SetTransObject(SQLCA)
dw_available.of_SetTransObject(SQLCA)

IF dw_selected.Event pfc_Retrieve() = -1 THEN
	SQLCA.of_rollback()
//Error handling and messaging
	RETURN
ELSE
	SQLCA.of_commit()
END IF

IF dw_available.Event pfc_Retrieve() = -1 THEN
	SQLCA.of_rollback()
//Error handling and messaging
	RETURN
ELSE
	SQLCA.of_commit()
END IF

IF dw_available.RowCount() > 0 THEN dw_available.inv_rowselect.of_RowSelect(1)
IF dw_selected.RowCount() > 0 THEN dw_selected.inv_rowselect.of_RowSelect(1)

end event

type cb_clear_all from u_cb within u_base_concentration_box
integer x = 1083
integer y = 596
integer taborder = 60
string text = "<<- Clea&r All"
end type

event clicked;call super::clicked;dw_selected.SelectRow(0,TRUE)
of_copy_rows(dw_selected, dw_available)
end event

type cb_clear from u_cb within u_base_concentration_box
integer x = 1083
integer y = 488
integer taborder = 50
string text = "<- &Clear"
end type

event clicked;call super::clicked;of_copy_rows(dw_selected, dw_available)
end event

type cb_add_all from u_cb within u_base_concentration_box
integer x = 1083
integer y = 356
integer taborder = 40
string text = "A&dd All ->>"
end type

event clicked;call super::clicked;dw_available.SelectRow(0,TRUE)
of_copy_rows(dw_available, dw_selected)
end event

type cb_add from u_cb within u_base_concentration_box
integer x = 1083
integer y = 248
integer taborder = 30
string text = "&Add ->"
end type

event clicked;call super::clicked;of_copy_rows(dw_available, dw_selected)
end event

type dw_selected from u_dw within u_base_concentration_box
event ue_add_row ( integer ll_row )
integer x = 1463
integer y = 32
integer width = 1006
integer height = 932
integer taborder = 20
borderstyle borderstyle = stylebox!
end type

event ue_add_row;// Rmn and JGS - Adding event to the dw_controls that can be used
// to set any key values on an add.  For example, if the selected dw
// has a key field that is passed from the calling window, the key field
// in the selected dw control can be populated here.

end event

event constructor;call super::constructor;ib_rmbmenu= False

of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

end event

event doubleclicked;cb_clear.Event Clicked()
end event

type dw_available from u_dw within u_base_concentration_box
event ue_add_row ( )
integer x = 37
integer y = 32
integer width = 1006
integer height = 932
integer taborder = 10
borderstyle borderstyle = stylebox!
end type

event ue_add_row;// Rmn and JGS - Adding event to the dw_controls that can be used
// to set any key values on an add.  For example, if the selected dw
// has a key field that is passed from the calling window, the key field
// in the selected dw control can be populated here.
end event

event constructor;call super::constructor;// rmn 2-2-98

ib_rmbmenu= False

of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

end event

event doubleclicked;cb_add.Event Clicked()
end event

