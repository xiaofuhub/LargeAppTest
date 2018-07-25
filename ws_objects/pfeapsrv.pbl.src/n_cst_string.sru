$PBExportHeader$n_cst_string.sru
$PBExportComments$Extension String service
forward
global type n_cst_string from pfc_n_cst_string
end type
end forward

global type n_cst_string from pfc_n_cst_string
end type

type prototypes
//---------Begin Added by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//Added By Mark Lee 08/30/2013
Function Long GetNumberFormat(Long Locale, Long dwFlags, String lpValue, long lpFormat, ref String lpNumberStr, Long cchNumber) Library "kernel32" Alias For "GetNumberFormatA;Ansi"
//---------End Added ------------------------------------------------------
end prototypes

type variables
constant 	uLong 		WM_GETFONT =  49						//Added By Mark Lee 05/15/2013    //(Appeon)Harry 01.21.2014 - V142 ISG-CLX
end variables

forward prototypes
public function boolean of_isexists (string as_arrary[], string as_value)
public function boolean of_check_name (string as_data, integer ai_check_type, boolean ab_showmessage)
public function boolean of_isexists (long al_arrary[], long al_value)
public function long of_arraytostring (long al_source[], string as_delimiter, ref string as_ref_string)
public subroutine of_delete_duplicate (ref string aa_data[])
public subroutine of_delete_duplicate (ref long aa_data[])
public function string of_do_fulltext (string as_searchtext)
public function string of_get_file_name (string as_fullname, string as_delimiter)
public function string of_replace_invalid_format (string as_source, string as_replace)
public function boolean of_exec_sql (string as_sql, ref string as_output)
public function integer of_execute_sql (string as_sql_statments[], string as_title, string as_text, boolean abn_popup_flag)
public subroutine of_convert_numeric_for_language (ref string as_numeric)
public function long of_gettextheight (string as_font, long al_fontsize)
public function string of_replace_invalid_filename (string as_filename)
end prototypes

public function boolean of_isexists (string as_arrary[], string as_value);//====================================================================
//$<Function>: of_isexists
//$<Arguments>:
// 	value    string    as_arrary[]
// 	value    string    as_value
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long i
For i = 1 To UpperBound(as_arrary[])
	If as_value = as_arrary[i] Then Return True
Next

Return False
end function

public function boolean of_check_name (string as_data, integer ai_check_type, boolean ab_showmessage);//====================================================================
//$<Function>: of_check_name
//$<Arguments>:
// 	value    string     as_data
// 	value    integer    ai_check_type
// 	value    boolean    ab_showmessage
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Check single quotes

Choose Case ai_check_type 
	Case 0
		If Pos(as_data, "'") > 0 or Pos(as_data, '"') > 0 or Pos(as_data, "~~") > 0 Then 
			If ab_showmessage Then
				Messagebox('Check',  + 'Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character string.')
			End If
			Return False
		End If
	Case Else
End Choose

Return true

end function

public function boolean of_isexists (long al_arrary[], long al_value);//====================================================================
//$<Function>: of_isexists
//$<Arguments>:
// 	value    long    al_arrary[]
// 	value    long    al_value
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long i
For i = 1 To UpperBound(al_arrary[])
	If al_value = al_arrary[i] Then Return True
Next

Return False
end function

public function long of_arraytostring (long al_source[], string as_delimiter, ref string as_ref_string);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ArrayToString
//
//	Access:  		public
//
//	Arguments:
//	al_source[]		The array of long to be moved into a single string.
//	as_Delimiter	The delimeter string.
//	as_ref_string	The string to be filled with the array of strings,
//						passed by reference.
//
//	Returns:  		long
//						1 for a successful transfer.
//						-1 if a problem was found.
//
//	Description:  	Create a single string from an array of longs separated by
//						the passed delimeter.
//						Note: Function will not include on the single string any 
//								array entries which match an empty string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////////////

long		ll_Count, ll_ArrayUpBound

//Get the array size
ll_ArrayUpBound = UpperBound(al_source[])

//Check parameters
IF IsNull(as_delimiter) or (Not ll_ArrayUpBound>0) Then
	Return -1
End If

//Reset the Reference string
as_ref_string = ''


For ll_Count = 1 to ll_ArrayUpBound
	// Do not include any entries that match an empty string 
	If al_source[ll_Count] <> 0 Then
		If Len(as_ref_string) = 0 Then
			//Initialize string
			as_ref_string = string(al_source[ll_Count])
		else
			//Concatenate to string
			as_ref_string = as_ref_string + as_delimiter + string(al_source[ll_Count])
		End If
	End If
Next 

return 1


end function

public subroutine of_delete_duplicate (ref string aa_data[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_stringof_delete_duplicate()
// $<arguments>
//		reference	any	aa_data[]		
// $<returns> (none)
// $<description>
// $<description> Delete the duplicate value in an array.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-10-26 by Ken.Guo
//$<Modify History>:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

string la_temp[],la_value
Long i,j


For i = 1 To UpperBound(aa_data[])
	If i = 1 Then la_temp[1] = aa_data[1]
	For j = 1 To UpperBound(la_temp[])
		If aa_data[i] = la_temp[j] Then Exit
	Next
	If j > UpperBound(la_temp[]) Then
		la_temp[UpperBound(la_temp[]) + 1] = aa_data[i]
	End If
Next

aa_data[] = la_temp[]




end subroutine

public subroutine of_delete_duplicate (ref long aa_data[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_string.of_delete_duplicate()
// $<arguments>
//		reference	any	aa_data[]		
// $<returns> (none)
// $<description>
// $<description> Delete the duplicate value in an array.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-10-26 by Ken.Guo
//$<Modify History>:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

Long la_temp[],la_value
Long i,j


For i = 1 To UpperBound(aa_data[])
	If i = 1 Then la_temp[1] = aa_data[1]
	For j = 1 To UpperBound(la_temp[])
		If aa_data[i] = la_temp[j] Then Exit
	Next
	If j > UpperBound(la_temp[]) Then
		la_temp[UpperBound(la_temp[]) + 1] = aa_data[i]
	End If
Next

aa_data[] = la_temp[]


end subroutine

public function string of_do_fulltext (string as_searchtext);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_stringof_do_fulltext()
// $<arguments>
//		value	string	as_searchtext		
// $<returns> string
// $<description>
// $<description> Replace the search text for full text
//////////////////////////////////////////////////////////////////////
// $<add> 2010-05-13 by Ken.Guo
//$<Modify History>:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

Long    ll_Pos,ll_start = 1,ll_pos2
String  ls_Temp
boolean lb_flag = false

as_searchtext = of_GlobalReplace(as_searchtext, " and ", " ")
as_searchtext = of_GlobalReplace(as_searchtext, " or ", " ")
as_searchtext = of_GlobalReplace(as_searchtext, "'", "''")			

DO WHILE POS(as_searchtext,"  ") > 0
	as_searchtext = of_GlobalReplace(as_searchtext, "  ", " ")
LOOP

as_searchtext = as_searchtext + " "
DO WHILE (1=1)
	ll_Pos = Pos(as_searchtext," ",ll_start)
	if ll_Pos < 1 then exit
	
	ls_Temp = Mid(as_searchtext,ll_start,ll_Pos - ll_start)
	if Len(ls_Temp) < 2 then 
		lb_flag = true; exit
	end if
	
	ll_pos2 = Pos(ls_Temp,"*")

	if ll_pos2 > 0 or Pos(ls_Temp,",") > 0 then 

		as_searchtext = Replace ( as_searchtext, ll_start, Len(ls_Temp), '"' + ls_Temp + '"' )
		ll_start = ll_Pos + 3
	else
		ll_start = ll_Pos + 1
	end if
	
LOOP

if lb_flag then
	MessageBox("Information","Each searched word must contain at least two characters.")
	return ''
end if
as_searchtext = Left(as_searchtext,len(as_searchtext) - 1)

as_searchtext = of_GlobalReplace(as_searchtext, " ", " and ")

Return as_searchtext
end function

public function string of_get_file_name (string as_fullname, string as_delimiter);//////////////////////////////////////////////////////////////////////
// Function: of_get_file_name()
// Arguments:
// 	value    string    as_fullname
// 	value    string    as_delimiter
//--------------------------------------------------------------------
// Return:  string
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-11-15
//--------------------------------------------------------------------
// Description: Full Name(Include File Path) --> File Name(Not Include File Path)
//--------------------------------------------------------------------
//$<Modify History>:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

String ls_fullname[],ls_filename
Long ll_cnt,i

This.of_parsetoarray( as_fullname, as_delimiter, ls_fullname[])

For i = 1 To UpperBound(ls_fullname[])
	ls_filename += Mid(ls_fullname[i], lastpos(ls_fullname[i],'\') + 1 ) + '; '
Next

ls_filename = Mid(ls_filename, 1, Len(ls_filename) - 2)

Return ls_filename


end function

public function string of_replace_invalid_format (string as_source, string as_replace);//====================================================================
// Function: of_replace_invalid_format
//--------------------------------------------------------------------
// Description:replace invalid format string and number
//--------------------------------------------------------------------
// Arguments:
//                as_source
//                as_replace
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/19/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//====================================================================
String		ls_return = "" , ls_tmp, ls_new = "", ls_replace
Long		ll_len, i , ll_position

If Isnull(as_replace)  then 
	ls_replace	=	""
Else
	ls_replace 	= as_replace 
End If 
ls_return = trim(as_source)
ll_len = Len(ls_return)
If ll_len > 0 Then 
	For i  = 1 to ll_len Step 1
		ls_tmp = Mid(ls_return,i,1)
		Choose Case	AscA(ls_tmp) 
			Case 48 to 57 
				// 0,1,...,9
				ls_new = ls_new + ls_tmp
			Case 65 to 90 
				//A,B,...,Z
				ls_new = ls_new + ls_tmp
			Case 97 to 122
				//a,b,...,z
				ls_new = ls_new + ls_tmp		
			Case 32
				//space do not need add
			Case Else
				ls_new = ls_new + ls_replace
		End Choose
	Next 
End If 

return ls_new

end function

public function boolean of_exec_sql (string as_sql, ref string as_output);//====================================================================
// Function: of_exec_sql
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_sql
//                as_output
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 02/22/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================
Boolean			lbn_return

Declare lsp_exec_sql Procedure For sp_exec_sql
	@arg = :as_sql, @outputs = :as_output OUTPUT ;
Execute lsp_exec_sql;
Fetch lsp_exec_sql Into :as_output ;
Close lsp_exec_sql;

 If SQLCA.SQLCode = 0 Then
	COMMIT;
	lbn_return = True
Else 
	lbn_return = False
	ROLLBACK;
	gnv_debug.of_output( True, " sp_exec_sql:arg ="+as_sql+" errortext:"+as_output)
End If

Return lbn_return
end function

public function integer of_execute_sql (string as_sql_statments[], string as_title, string as_text, boolean abn_popup_flag);//====================================================================
// Function: of_execute_sql
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_sql_statments[]
//                as_title
//                as_text
//                abn_popup_flag
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/16/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================
long 				ll_i
Integer 			li_return

li_return = 0 
IF UPPERBOUND(as_sql_statments) > 0 THEN 
	If AppeonGetClientType() = 'WEB' then
	   as_sql_statments[upperbound(as_sql_statments) + 1] = "commit;"
	End IF
	IF abn_popup_flag Then 
		If Not isvalid( w_infodisp ) then 
			open(w_infodisp)
		End If
		w_infodisp.title = as_title
		w_infodisp.Center = TRUE
		w_infodisp.st_complete.visible = false
		w_infodisp.st_3.visible = false
		w_infodisp.st_information.visible = false
		w_infodisp.st_1.text =as_text
		w_infodisp.wf_set_min_max(1,upperbound(as_sql_statments))
	End If 	
	
	gnv_appeondb.of_startqueue( )
	li_return = 1
	FOR ll_i = 1 TO upperbound(as_sql_statments)
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(as_sql_statments)) +' Please stand by!'
			 EXECUTE IMMEDIATE :as_sql_statments[ll_i] using sqlca;
			 IF len(sqlca.sqlerrtext) > 0 THEN
				gnv_debug.of_output( True,  " error isql: " +  string(as_sql_statments[ll_i]) +  "~r~n"+  "sqlca.sqlerrtext: " + string(sqlca.sqlerrtext))
				li_return = -1
				Rollback;
			 Else
				Commit;					
			END IF
			IF abn_popup_flag Then 
				If isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
			End IF
	NEXT		
	gnv_appeondb.of_commitqueue( )
	IF abn_popup_flag Then 
		w_infodisp.st_1.text = 'Commiting modifications Please stand by!'
		close(w_infodisp)	    
	End If 
END IF

return li_return
end function

public subroutine of_convert_numeric_for_language (ref string as_numeric);//====================================================================
// Function: of_convert_numeric_for_language
//--------------------------------------------------------------------
// Description: deal with if use a numeric from the string, we need replace point to quote in the Europe language(Netherlands).
//--------------------------------------------------------------------
// Arguments:
//                as_numeric
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 05/09/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================
string 		ls_result, ls_tmp
Boolean		lbn_europe
long 			ll_rtn,	ll_fmt


If isnull(as_numeric) or trim(as_numeric) = '' Then 
	Return 
End If 

//Commented By Mark Lee 08/29/2013
//If dec("0.1") = Dec("1") Then
//	lbn_europe = True
//Else 
//	lbn_europe = False
//End If
//
//IF lbn_europe = True	 Then
//	IF pos(as_numeric,'.') > 0 Then 
//		as_numeric = this.of_globalreplace( as_numeric, '.', ',')
//	End IF 
//Else
//	IF pos(as_numeric,',') > 0 Then 
//		as_numeric = this.of_globalreplace( as_numeric, ',', '.')
//	End IF 	
//End If 
//Added By Mark Lee 08/30/2013
ls_tmp = as_numeric
if pos(ls_tmp,",") > 0 then 
	ls_tmp =  this.of_globalreplace( ls_tmp, ',', '.')
end if

ll_rtn = GetNumberFormat(0, 0, ls_tmp, ll_fmt, ls_result,len(ls_tmp) + 20 )
if ll_rtn > 0 then
	as_numeric = ls_result 
end if

end subroutine

public function long of_gettextheight (string as_font, long al_fontsize);//====================================================================
// Function: of_gettextheight
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_font
//                al_fontsize
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 05/15/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================
ULong 					lul_Handle, lul_hDC, lul_hFont
str_size_compute 		lstr_size
Integer 					li_return
Boolean					lbn_return
Long						ll_height

w_appeon_gifofwait lw_appeon_gifofwait
Open(lw_appeon_gifofwait)
lw_appeon_gifofwait.hide( )
lw_appeon_gifofwait.st_1.underline = False
lw_appeon_gifofwait.st_1.italic = False
lw_appeon_gifofwait.st_1.weight = 400
IF Abs(al_fontsize) > 0 Then 
	lw_appeon_gifofwait.st_1.textsize = 0 - Abs(al_fontsize)			//Added By Mark Lee 06/10/2013  the size is stored as a negative number
End IF 
IF Len(Trim(as_font)) > 0 and not isnull(as_font) Then 
		lw_appeon_gifofwait.st_1.facename = as_font
End If
	
lw_appeon_gifofwait.st_1.text = "we"

lul_Handle = Handle(lw_appeon_gifofwait.st_1)
lul_hDC = GetDC(lul_Handle)
// get handle to the font used by statictext
lul_hFont = Send(lul_Handle, WM_GETFONT, 0, 0)
// Select it into the device context
SelectObject(lul_hDC, lul_hFont)

lbn_return = GetTextExtentPoint32(lul_hDC, "we", LenA("we"), lstr_Size)
ReleaseDC(lul_Handle, lul_hDC)

//st_2.width = PixelsToUnits(lstr_Size.cx , XPixelsToUnits!)
//st_2.height = PixelsToUnits(	lstr_Size.cy , YPixelsToUnits!)
 ll_height = PixelsToUnits(lstr_Size.cy , YPixelsToUnits!)

Close(lw_appeon_gifofwait)
RETURN ll_height

end function

public function string of_replace_invalid_filename (string as_filename);//====================================================================
//$<Function>: of_replace_invalid_filename
//$<Arguments>:
// 	value    string    as_source
//$<Return>:  string
//$<Description>: check and replace special characters in filename. ( \ / : * ? " < > | )
//$<Author>: (Appeon) long.zhang 05.10.2017 (V15..3 Bug # 5636 - AppeonWriteFile error when trying to extract documents)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Constant String REPLACE_TO = '_'

String		ls_return = "" , ls_tmp, ls_new = "", ls_replace
Long		ll_len, i , ll_position

ls_replace 	= REPLACE_TO 

ls_return = trim(as_filename)
ll_len = Len(ls_return)
If ll_len > 0 Then 
	For i  = 1 to ll_len Step 1
		ls_tmp = MidA(ls_return,i,1)
		If PosA('\/:*?"<>|', ls_tmp) = 0 Then
			ls_new = ls_new + ls_tmp
		Else
			ls_new = ls_new + ls_replace
		End If
	Next 
End If 

return ls_new

end function

on n_cst_string.create
call super::create
end on

on n_cst_string.destroy
call super::destroy
end on

