$PBExportHeader$u_dw_workflow.sru
$PBExportComments$[intellicontract_tab]  Contract specific functity
forward
global type u_dw_workflow from u_dw
end type
end forward

global type u_dw_workflow from u_dw
integer width = 2094
integer height = 1160
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = true
event ue_keydown ( )
event ue_post_itemchanged ( string data )
end type
global u_dw_workflow u_dw_workflow

type prototypes
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
SUBROUTINE GetClientRect (ULONG hClntWnd, REF STR_CLIENT_RECT lpRect) LIBRARY "USER32.DLL" alias for "GetClientRect;Ansi" 
end prototypes

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.07.2006 By: LeiWei
//$<reason> Add a variable to recored enable columns
Protected Boolean ib_enable_columns = TRUE

// Add a variable to recored original dataobject name
Protected String DataObject_original
//---------------------------- APPEON END ----------------------------

blob   b_text_blob
BOOLEAN ib_retrieve_drop_downs /* FLAG - DETERMINS IF THE DROP DOWNS SHOULD BE RETRIEVE */
BOOLEAN ib_use_row_selection /* row selection service*/
BOOLEAN IB_allow_filter
BOOLEAN IB_allow_sort
BOOLEAN ib_read_only
BOOLEAN ib_filter_only
string is_lookup_search_column_table

CONSTANT STRING NEW_LINE = '~r~n'	
n_cst_string       lnv_string
// start code change --- 10.31.2005
constant string word_2003_path = 'C:\Program Files\Microsoft Office\OFFICE11\WINWORD.EXE'
// end   code change --- 10.31.2005

string is_title_bar_text
Boolean ib_refdddw
any	  ia_data , ia_datanull

end variables

forward prototypes
public function integer of_lookup_search_dddw (string as_lookup_search_column_table)
public function string of_set_column_enable (string as_column, boolean ab_flag)
end prototypes

event ue_post_itemchanged(string data);
/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 27 March  2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String ls_column_name
integer res	
datawindowchild dwchild



if data = '-777' then 
	
	ls_column_name =GetColumnName()
   res = This.GetChild( ls_column_name, dwchild )
   if res > 0 then
		IF dwchild.RowCount() > 2 THEN 
				is_lookup_search_column_table = dwchild.GetItemString( dwchild.rowcount(), "lookup_name" )
		END IF
   end if
	If of_lookup_search_dddw(is_lookup_search_column_table ) = 0 Then ib_refdddw  =true
   
end if 
end event

public function integer of_lookup_search_dddw (string as_lookup_search_column_table);/******************************************************************************************************************
**  [PUBLIC]   : of_lookup_search_dddw( /*string as_type */)
**==================================================================================================================
**  Purpose   	: Set the vales from the search window or back to the original value
**==================================================================================================================
**  Arguments 	: [string] as_type - not used
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: ??
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**  MSkinner 						 19 December 2005                           I was getin a GPF on line 24 of the original code
**  mskinner 						 23 March    2006                           Modoified code so that -777 or -888 will not be saved
********************************************************************************************************************/


DataWindowChild dwchild
any l_any
long li_row_cnt
long ll_val
long ll_find
String ls_column_nm
String ls_retval
String ls_search_type
String ls_value
any ll_null
setnull(ll_null)

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
/*
n_cst_dwsrv lnv_dwsrv
lnv_dwsrv = create n_cst_dwsrv
lnv_dwsrv.of_setrequestor( this)

ls_column_nm = GetColumnName()

ls_retval = Describe( ls_column_nm + ".DDDW.DisplayColumn" )

getchild( ls_column_nm, dwchild)

OpenWithParm( w_lookup_search_dddw,'C' + "@" + as_lookup_search_column_table )

IF Message.StringParm = "Cancel" THEN
	
	ls_value = lnv_dwsrv.of_getitem( GetRow(), ls_column_nm , primary!,true)
	if string(ls_value) = "-777" OR string(ls_value) = "-888" then
		setnull(ls_value)
	end if
	if not f_validstr(ls_value) then setnull(ls_value)
	lnv_dwsrv.of_setitem( GetRow(), ls_column_nm, ls_value)
   
	RETURN -1
else
	l_any = Message.DoubleParm
	ia_data = l_any
	lnv_dwsrv.post of_setitem( GetRow(), ls_column_nm, string(l_any))
	accepttext()
end if
*/
inv_base.of_SetRequestor(this)
ls_column_nm = GetColumnName()
ls_retval = Describe( ls_column_nm + ".DDDW.DisplayColumn" )
getchild( ls_column_nm, dwchild)
OpenWithParm( w_lookup_search_dddw,'C' + "@" + as_lookup_search_column_table )

IF Message.StringParm = "Cancel" THEN	
	ls_value = inv_base.of_getitem( GetRow(), ls_column_nm , primary!,true)
	if string(ls_value) = "-777" OR string(ls_value) = "-888" then
		setnull(ls_value)
	end if
	if not f_validstr(ls_value) then setnull(ls_value)
	inv_base.of_setitem( GetRow(), ls_column_nm, ls_value)
   
	RETURN -1
else
	l_any = Message.DoubleParm
	ia_data = l_any
	inv_base.post of_setitem( GetRow(), ls_column_nm, string(l_any))
	accepttext()
end if
//---------------------------- APPEON END ----------------------------

setpointer(hourglass!)
setcapture( handle(getapplication()))

setcolumn(ls_column_nm)
releasecapture( )
setpointer(arrow!)


Return 0

end function

public function string of_set_column_enable (string as_column, boolean ab_flag);string ls_modify,ls_style
n_cst_color lnv_color

ls_style =  this.Describe(as_column+".edit.style")
if ab_flag then
	if ls_style = "checkbox" or ls_style = "radiobutton" then
		ls_modify = as_column + ".protect = 0 "
		//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
		if ls_Style = "checkbox" then
			ls_Modify += as_Column + ".CheckBox.3D = 'Yes'"
		end if
		//---------End Modfiied ------------------------------------------------------
	else
		ls_modify = as_column + ".protect = 0 " + as_column + ".Background.Mode = '0' " + as_column + ".color =" + string(lnv_color.WINDOW_TEXT) +" "+ as_column + ".Background.Color =" + string(lnv_color.WINDOW_BACKGROUND)
	end if
else
	if ls_style = "checkbox" or ls_style = "radiobutton" then
		ls_modify = as_column + ".protect = 1 "
		//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
		if ls_Style = "checkbox" then
			ls_Modify += as_Column + ".CheckBox.3D = 'No'"
		end if
		//---------End Modfiied ------------------------------------------------------
	else
		ls_modify = as_column + ".protect = 1 " + as_column + ".Background.Mode = '1' " + as_column + ".color =" + string(lnv_color.DARK_GRAY)
	end if
end if
return this.modify(ls_modify)
end function

on u_dw_workflow.create
call super::create
end on

on u_dw_workflow.destroy
call super::destroy
end on

event itemchanged;call super::itemchanged;post event ue_post_itemchanged( data)
end event

