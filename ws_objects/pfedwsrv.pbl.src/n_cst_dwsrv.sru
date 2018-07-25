$PBExportHeader$n_cst_dwsrv.sru
$PBExportComments$Extension Base DataWindow service
forward
global type n_cst_dwsrv from pfc_n_cst_dwsrv
end type
end forward

global type n_cst_dwsrv from pfc_n_cst_dwsrv
end type
global n_cst_dwsrv n_cst_dwsrv

forward prototypes
public function string of_getitem (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value, boolean ab_format)
public function string of_getitem (long al_row, string as_column, boolean ab_format)
end prototypes

public function string of_getitem (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value, boolean ab_format);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_GetItem (FORMAT 5) 
//	Arguments:   	al_row			: The row reference
//   					as_column    	: The column name reference
//   					adw_buffer   	: The dw buffer from which to get the column's data value.
//   					ab_orig_value	: When True, returns the original values that were 
//							  				  retrieved from the database.
//						ab_format		: When True, returns the formatted values
//	Returns:  		String - The string value of the item
//	Description:	When ab_format = True,Returns the formatted (including formats, editmasks and display values) 
//						text of any column on a datawindow, regardless of the column's datatype. 
//                When ab_format = False,Returns the unformatted value.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
// 					5.0.04 Fixed where decimal value was being converted into a long.
// 					6.0.01 Fixed computed field and LookUpDisplay values.
//						7.0	Removed test on computed columns.  They can be treated
//								as normal columns.
//						7.0	When looking for original value, don't format display values
//						7.0	If Format contains expression, use the default value for
//								the format.
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
string 	ls_col_format, ls_col_mask, ls_string_format, ls_string, ls_savestring
string	ls_coltype, ls_editstyle
string	ls_computeexp, ls_evaluateexp
string	edit_codetable, editmask_codetable
boolean 	lb_editmask_used=False
long 		ll_pos
n_cst_string	lnv_string

ls_col_format = idw_Requestor.Describe ( as_column + ".format" )
ls_col_mask   = idw_Requestor.Describe ( as_column + ".editmask.mask") 

IF ls_col_mask = "!" or ls_col_mask = "?" THEN
	ls_string_format = ls_col_format
ELSE 
	ls_string_format = ls_col_mask
	lb_editmask_used = TRUE
END IF 
 
IF ls_string_format = "!" or ls_string_format = "?" THEN 
	ls_string_format = ""
ELSE
	ll_pos = PosA ( ls_string_format, "~t" ) 
	If ll_pos > 0 Then
		If LeftA ( ls_string_format, 1 ) = "~"" Then
			ls_string_format = MidA ( ls_string_format, 2, ll_pos - 2 ) 
		Else
			ls_string_format = LeftA ( ls_string_format, ll_pos - 1 ) 
		End If
	END IF
END IF  

/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and format the returned value */
ls_coltype = Lower(idw_Requestor.Describe ( as_column + ".ColType" ))
CHOOSE CASE LeftA ( ls_coltype , 5 )

		CASE "char(", "char"				//  CHARACTER DATATYPE
			IF lb_editmask_used = TRUE THEN 
				/*  Need to replace 'EditMask' characters with 'Format' characters */
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "^", "@" ) //Lowercase
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "!", "@")	//Uppercase
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "#", "@" ) //Number
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "a", "@" ) //Aplhanumeric
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "x", "@" ) //Any Character
			END IF 
			ls_string = idw_Requestor.GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if ab_format then
				ls_string = String ( ls_string, ls_string_format ) 
			end if
	
		CASE "date"					//  DATE DATATYPE
			date ld_date
			ld_date = idw_Requestor.GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if LenA (ls_string_format) > 0 and ab_format then
				ls_string = String ( ld_date, ls_string_format ) 
			else
				ls_string = String (ld_date)
			end if

		CASE "datet"				//  DATETIME DATATYPE
			datetime ldtm_datetime
			ldtm_datetime = idw_Requestor.GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if LenA (ls_string_format) > 0 and ab_format then
				ls_string = String ( ldtm_datetime, ls_string_format ) 
			else
				ls_string = String (ldtm_datetime)
			end if

		CASE "decim"				//  DECIMAL DATATYPE
			decimal ldec_decimal
			ldec_decimal = idw_Requestor.GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if LenA (ls_string_format) > 0 and ab_format then
				ls_string = String ( ldec_decimal, ls_string_format ) 
			else
				ls_string = String (ldec_decimal)
			end if	
	
		CASE "numbe", "doubl", "real"		//  DOUBLE DATATYPE	
			double ldbl_double
			ldbl_double = idw_Requestor.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if LenA (ls_string_format) > 0 and ab_format then
				ls_string = String ( ldbl_double, ls_string_format ) 
			else
				ls_string = String (ldbl_double)
			end if
	
		CASE "long", "ulong", "int"				//  LONG DATATYPE	
			long ll_long
			ll_long = idw_Requestor.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if LenA (ls_string_format) > 0 and ab_format then
				ls_string = String ( ll_long, ls_string_format ) 
			else
				ls_string = String (ll_long)
			end if
	
		CASE "time", "times"		//  TIME DATATYPE
			time ltm_time
			ltm_time = idw_Requestor.GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if LenA (ls_string_format) > 0 and ab_format then
				ls_string = String ( ltm_time, ls_string_format ) 
			else
				ls_string = String (ltm_time)
			end if

END CHOOSE

/*  Can only provide the display value if we are looking for the current value */
IF Not ab_orig_value and ab_format Then
	// -- Look Up Display values. --
	IF adw_buffer = Primary! THEN
		ls_editstyle = Lower(idw_requestor.Describe(as_column+".Edit.Style"))
		edit_codetable = Lower(idw_Requestor.Describe ( as_column + ".Edit.CodeTable" ))
		editmask_codetable = Lower(idw_Requestor.Describe ( as_column + ".EditMask.CodeTable"))
		If ls_editstyle='dddw' or ls_editstyle='ddlb' Or ls_editstyle='radiobuttons' or &
			edit_codetable = "yes" OR editmask_codetable = "yes" Then
			ls_evaluateexp = "Evaluate('LookUpDisplay(" + as_column + ")', " + String(al_row) + ")"
			ls_string = idw_Requestor.Describe (ls_evaluateexp) 
		ELSEIF ls_editstyle = 'checkbox' THEN
			ls_evaluateexp = "Evaluate('LookUpDisplay(" + as_column + ")', " + String(al_row) + ")"
			ls_string = ls_string + "~t" + idw_Requestor.Describe (ls_evaluateexp) 
		END IF
	END IF
END IF

Return ls_string
end function

public function string of_getitem (long al_row, string as_column, boolean ab_format);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItem (FORMAT 5) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   as_column    	: The column name reference
//   ab_format       : When True, returns the formatted values
//
//	Returns:  String
//	  The formatted string value of the item
//
//	Description:  Returns the formatted (including formats, editmasks and display
//					  values) text of any column on a datawindow, regardless of the 
//					  column's datatype.  
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return of_GetItem ( al_row, as_column, Primary!, FALSE ,ab_format)
end function

on n_cst_dwsrv.create
call super::create
end on

on n_cst_dwsrv.destroy
call super::destroy
end on

