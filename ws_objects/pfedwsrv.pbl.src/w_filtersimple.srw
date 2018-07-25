$PBExportHeader$w_filtersimple.srw
$PBExportComments$*BSR* Extension Simple-Style Filter dialog window
forward
global type w_filtersimple from pfc_w_filtersimple
end type
end forward

global type w_filtersimple from pfc_w_filtersimple
integer x = 214
integer y = 221
end type
global w_filtersimple w_filtersimple

forward prototypes
public subroutine of_getvalues (string as_column)
end prototypes

public subroutine of_getvalues (string as_column);/*------------------------------------------------------------------------------
 Object:	w_filtersimple
 Function:			of_Getvalues
 Parameters:      string as_column - The column to get values for
 Returns:         (None)

 Copyright © 1999 BSR - Philip Salgannik
 Date Created: 10/27/99

 Description:		Overrides PFC implementation. Obtains a list of distinct values for the specified
					  	column from the datawindow which is being filtered.

--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments


------------------------------------------------------------------------------*/


string			ls_values[]
long 			li_i, li_num_values , li_newrow, li_rc




If is_prevchildcolumn = as_column Then
	// There is no need to get the values.
	Return 
End If

// Store the last column for which the values were gotten.
is_prevchildcolumn = as_column

SetPointer ( HourGlass! )

// Clear all of the values.
li_rc = idwc_values.Reset()


li_num_values = inv_filterattrib.idw_dw.RowCount()
FOR li_i = 1 to li_num_values
	 ls_values[li_i] = inv_filterattrib.idw_dw.inv_filter.of_GetItem(li_i, as_column)
NEXT

li_num_values = inv_filterattrib.idw_dw.FilteredCount()

IF li_num_values > 0 THEN
	li_newrow = UpperBound(ls_values)
	FOR li_i = 1 to li_num_values
	 ls_values[li_newrow + li_i] = inv_filterattrib.idw_dw.inv_filter.of_GetItem(li_i, as_column, Filter!, FALSE)
	NEXT
END IF

// Populate the DropDownDatawidow column with the column values.
li_num_values = UpperBound ( ls_values ) 
FOR li_i = 1 to li_num_values
	// Insert new row.
	li_newrow = idwc_values.InsertRow ( 0 ) 
	
	// Populate the values for the new row.	
	idwc_values.SetItem ( li_newrow, "value", ls_values[li_i] )	
NEXT

// Make the values distinct in the DropDownDatawidow
li_num_values = idwc_values.RowCount()

IF li_num_values > 0 THEN
	idwc_values.Sort()
	idwc_values.SetFilter("value <> value[-1] or GetRow () = 1")
	idwc_values.Filter()	
	li_newrow = idwc_values.FilteredCount()
	IF li_newrow > 0 THEN
		idwc_values.RowsDiscard(1, li_newrow, Filter!)
	END IF
	idwc_values.SetFilter("")
	idwc_values.Filter()	
	idwc_values.Sort()
END IF


	
	
	



end subroutine

on w_filtersimple.create
call super::create
end on

on w_filtersimple.destroy
call super::destroy
end on

event pfc_postopen;call super::pfc_postopen;/*------------------------------------------------------------------------------
 Object:	w_filtersimple
 Event   :			pfc_Postopen
 Parameters:      
 Returns:         (None)

 Copyright © 2000 STX  - Philip Salgannik
 Date Created: Monday, September 25, 2000

 Description:		Let's sort the dddw with column names

--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments


------------------------------------------------------------------------------*/
IF IsValid(idwc_cols) THEN
	idwc_cols.Sort()
END IF
end event

type cb_delete from pfc_w_filtersimple`cb_delete within w_filtersimple
end type

type cb_cancel from pfc_w_filtersimple`cb_cancel within w_filtersimple
integer x = 2066
end type

type dw_filter from pfc_w_filtersimple`dw_filter within w_filtersimple
end type

event dw_filter::itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-17 By: Scofield
//$<Reason> Don't set the first row but set the current row.

//if This.GetColumnName() = 'colname' then
//	this.setitem(1,"colvalue",'')
//end if

if dwo.Name = 'colname' then	
	this.SetItem(Row,"colvalue",'')
end if
//---------------------------- APPEON END ----------------------------

end event

type mle_originalfilter from pfc_w_filtersimple`mle_originalfilter within w_filtersimple
end type

type gb_originalfilter from pfc_w_filtersimple`gb_originalfilter within w_filtersimple
end type

type cb_add from pfc_w_filtersimple`cb_add within w_filtersimple
end type

type gb_newfilter from pfc_w_filtersimple`gb_newfilter within w_filtersimple
end type

type cb_ok from pfc_w_filtersimple`cb_ok within w_filtersimple
integer x = 1673
end type

type cb_dlghelp from pfc_w_filtersimple`cb_dlghelp within w_filtersimple
end type

