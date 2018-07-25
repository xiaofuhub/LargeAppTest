$PBExportHeader$w_filterextended.srw
forward
global type w_filterextended from pfc_w_filterextended
end type
end forward

global type w_filterextended from pfc_w_filterextended
integer width = 2089
integer height = 1628
end type
global w_filterextended w_filterextended

forward prototypes
public function integer of_get_values (string as_column)
end prototypes

public function integer of_get_values (string as_column);/*------------------------------------------------------------------------------
 Object:	w_filtersimple
 Function:			of_Getvalues
 Parameters:      string as_column - The column to get values for
 Returns:         (None)

 Description:		Overrides PFC implementation. Obtains a list of distinct values for the specified
					  	column from the datawindow which is being filtered.

--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments


------------------------------------------------------------------------------*/

long ll_found
string			ls_values[]
long 			li_i, li_num_values , li_newrow, li_rc


SetPointer ( HourGlass! )


LONG     LL_K
BOOLEAN LB_FOUND
li_num_values = inv_filterattrib.idw_dw.RowCount()
FOR li_i = 1 to li_num_values
	// CHECK FOR DUPS
	STRING LS_ITEM
	LS_ITEM = string(inv_filterattrib.idw_dw.inv_filter.of_GetItem(li_i, as_column))
	
	FOR LL_K = 1 TO UPPERBOUND(ls_values)
		IF LS_ITEM = ls_values[LL_K] THEN
			LB_FOUND = TRUE
		END IF
	NEXT
	
	IF NOT LB_FOUND THEN
		IF NOT ISNULL(LS_ITEM) OR LenA(TRIM(LS_ITEM)) > 1 THEN
			  ls_values[li_i] = string(inv_filterattrib.idw_dw.inv_filter.of_GetItem(li_i, as_column))
		END IF
   END IF
	LB_FOUND = FALSE
	
NEXT

// Populate the DropDownDatawidow column with the column values.
li_num_values = UpperBound ( ls_values ) 
tab_1.tabpg_values.dw_values.SETREDRaw( FALSE)
//$<add> 01.12.2008 by Andy 
//Reason:Fixed BugG122802 
tab_1.tabpg_values.dw_values.Reset( )
//end of add 01.12.2008 by Andy
FOR li_i = 1 to li_num_values
   
	IF ISNULL(ls_values[li_i]) OR LenA(ls_values[li_i])  < 1 THEN
	//
    ELSE
		 li_newrow =tab_1.tabpg_values.dw_values.InsertRow ( 0 )
	  tab_1.tabpg_values.dw_values.setitem( li_newrow, 'value', ls_values[li_i])
    END IF
Next


tab_1.tabpg_values.dw_values.Sort()
tab_1.tabpg_values.dw_values.SETREDRaw( TRUE)





Return 1
	
	



end function

on w_filterextended.create
call super::create
end on

on w_filterextended.destroy
call super::destroy
end on

type cb_ok from pfc_w_filterextended`cb_ok within w_filterextended
integer x = 1280
end type

type cb_cancel from pfc_w_filterextended`cb_cancel within w_filterextended
integer x = 1669
end type

type cb_verify from pfc_w_filterextended`cb_verify within w_filterextended
end type

type mle_filter from pfc_w_filterextended`mle_filter within w_filterextended
end type

type gb_2 from pfc_w_filterextended`gb_2 within w_filterextended
end type

type gb_1 from pfc_w_filterextended`gb_1 within w_filterextended
end type

type tab_1 from pfc_w_filterextended`tab_1 within w_filterextended
fontcharset fontcharset = ansi!
end type

event tab_1::selectionchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  selectionchanged
//
//	Description:
//	Populate values DW for current column
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Radiobutton and checkbox edit styles should only display data values
//	5.0.03	Do not display dropdown arrows, spin controls
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant string	WHITE = "16777215"
boolean	lb_radiobuttons
integer	li_selectedrow
long		ll_pos
long		ll_temp
long		ll_editstyle
long		ll_start
long		ll_end
long		ll_height
long		ll_column
string		ls_col
string		ls_presentation
string		ls_syntax
string		ls_errbuffer
string		ls_dbname
string		ls_table
string		ls_sql
string		ls_editstyle
string		ls_replacesyntax
n_cst_string	lnv_string

// Check for values tabpage
if newindex <> 4 then
	return
end if	

// Check for valid trans object before values can be populated
if not IsValid (inv_filterattrib.idw_dw.itr_object) or IsNull (inv_filterattrib.idw_dw.itr_object) then
	return
end if
if not inv_filterattrib.idw_dw.itr_object.of_IsConnected() then
	return
end if

// Populate values based on current column
li_selectedrow = this.tabpg_columns.dw_columns.GetSelectedRow (0)
if li_selectedrow > 0 then
	parent.of_get_values( this.tabpg_columns.dw_columns.object.columnname[li_selectedrow])
end if
//	ls_col = this.tabpg_columns.dw_columns.object.columnname[li_selectedrow]
//	if ls_col <> is_currentcolumn then
//		// Table and column
//		ls_dbname = this.tabpg_columns.dw_columns.object.db_name[li_selectedrow]
//		ll_pos = Pos (ls_dbname, ".")
//		ls_table = Left (ls_dbname, ll_pos - 1)
//		if ls_table = "" or ls_dbname = "" then
//			this.tabpg_values.dw_values.dataobject = ""
//			is_currentcolumn = ""
//			return
//		end if
//
//		// SQL
//		ls_sql = "select distinct " + ls_dbname + " from " + '' +ls_table
//
//		// Default presentation
//		ls_presentation = "DataWindow (color=" + WHITE + ") " + &
//			"Column (background.mode=1 border=0 color=0 edit.displayonly='yes' edit.focusrectangle='no' " + &
//			"font.face='MS Sans Serif' font.height='-8' font.weight=400 font.family=2 font.pitch=2 font.charset=0) " + &
//			"Text (alignment=0 border=0 color=0 background.mode=1 " + &
//			"font.face='MS Sans Serif' font.height='-8' font.weight=400 font.family=2 font.pitch=2 font.charset=0) " + &
//			"Style (Header_Bottom_Margin=0 Header_Top_Margin=0 Report='yes')"
//
//		// Build syntax from sql and create DW
//		ls_syntax = inv_filterattrib.idw_dw.itr_object.SyntaxFromSQL (ls_sql, ls_presentation, ls_errbuffer)
//
//		// Do not allow checkbox and radiobuttons edit styles (replace with edit editstyle)
//		ls_replacesyntax = " edit.limit=0 edit.autoselect=no edit.autohscroll=yes edit.autovscroll=no edit.focusrectangle=no "
//		ll_editstyle = Pos (ls_syntax, "checkbox.on=")
//		if ll_editstyle = 0 then
//			ll_editstyle = Pos (ls_syntax, "radiobuttons.columns=")
//			lb_radiobuttons = true
//		end if
//		if ll_editstyle > 0 then
//			ll_temp = Pos (ls_syntax, "width=")
//			if ll_temp > 0 then
//				// For radiobuttons - first modify the height of the column
//				if lb_radiobuttons then
//					ll_height = lnv_string.of_LastPos (ls_syntax, "height", ll_temp)
//					if ll_height > 0 then
//						ls_syntax = Left (ls_syntax, ll_height - 1) + ' height="61" ' + Mid (ls_syntax, ll_temp)
//						// Now modify the detail height
//						ll_height = Pos (ls_syntax, "detail(height=")
//						ll_column = Pos (ls_syntax, "column", ll_height)
//						if ll_height > 0 and ll_column > 0 then
//							ls_syntax = Left (ls_syntax, ll_height - 1) + ' detail(height=75) ' + Mid (ls_syntax, ll_column)
//						end if
//						ll_temp = Pos (ls_syntax, "width=")
//					end if
//				end if
//
//				// Now change radiobutton & checkbox edit styles to edit edit styles
//				ll_temp = Pos (ls_syntax, " ", ll_temp)
//				if ll_temp > 0 then
//					ll_start = ll_temp - 1
//					ll_temp = Pos (ls_syntax, "alignment=", ll_start)
//					if ll_temp > 0 then
//						ll_end = ll_temp - 1
//						ls_syntax = Left (ls_syntax, ll_start) + ls_replacesyntax + Mid (ls_syntax, ll_end)
//					end if
//				end if
//			end if
//		end if
//		
//		if Len (ls_syntax) > 0 then
//			if this.tabpg_values.dw_values.Create (ls_syntax, ls_errbuffer) = 1 then
//				
//				ls_editstyle = this.tabpg_values.dw_values.Describe ("#1.edit.style")
//
//				// DDDW & DDLB edit styles should not always display arrow for dropdown
//				if ls_editstyle = "dddw" or ls_editstyle = "ddlb" then
//					this.tabpg_values.dw_values.Modify ("#1." + ls_editstyle + ".UseAsBorder=no")
//				end if
//				
//				// Editmasks should not show spin control
//				if ls_editstyle = "editmask" then
//					this.tabpg_values.dw_values.Modify ("#1.editmask.spin=no")
//				end if
//				
//				this.tabpg_values.dw_values.SetSort ("#1 A")
//				this.tabpg_values.dw_values.Modify ("#1.protect=1")
//				this.tabpg_values.dw_values.SetTransObject (inv_filterattrib.idw_dw.itr_object)
//				this.tabpg_values.dw_values.Retrieve()
//				is_currentcolumn = ls_col
//			end if
//		else
//			this.tabpg_values.dw_values.dataobject = ""
//			is_currentcolumn = ""
//		end if
//	end if
//else
//	this.tabpg_values.dw_values.dataobject = ""
//	is_currentcolumn = ""
//end if
//
end event

type tabpg_functions from pfc_w_filterextended`tabpg_functions within tab_1
end type

type dw_functioncategory from pfc_w_filterextended`dw_functioncategory within tabpg_functions
end type

type dw_function from pfc_w_filterextended`dw_function within tabpg_functions
end type

type gb_3 from pfc_w_filterextended`gb_3 within tabpg_functions
end type

type st_help from pfc_w_filterextended`st_help within tabpg_functions
end type

type st_syntax from pfc_w_filterextended`st_syntax within tabpg_functions
end type

type tabpg_columns from pfc_w_filterextended`tabpg_columns within tab_1
end type

type dw_columns from pfc_w_filterextended`dw_columns within tabpg_columns
end type

type tabpg_operators from pfc_w_filterextended`tabpg_operators within tab_1
end type

type lb_1 from pfc_w_filterextended`lb_1 within tabpg_operators
end type

type tabpg_values from pfc_w_filterextended`tabpg_values within tab_1
end type

type dw_values from pfc_w_filterextended`dw_values within tabpg_values
string dataobject = "d_pfe_filter_ext"
end type

type cb_dlghelp from pfc_w_filterextended`cb_dlghelp within w_filterextended
integer x = 805
integer y = 1600
boolean enabled = false
end type

