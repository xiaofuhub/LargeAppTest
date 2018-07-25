$PBExportHeader$u_tabpg.sru
$PBExportComments$Extension TabPage class
forward
global type u_tabpg from pfc_u_tabpg
end type
end forward

global type u_tabpg from pfc_u_tabpg
integer width = 1975
integer height = 1220
event ue_set_resize ( )
event ue_reset ( )
end type
global u_tabpg u_tabpg

type variables
window iw_parent
tab i_parent_tab
end variables

forward prototypes
public function integer of_show_missing_msg (string as_column_name, u_dw adw, string as_field_type, long al_row)
end prototypes

event ue_set_resize();iw_parent.dynamic of_setresize(true)
iw_parent.dynamic of_Register (this )


end event

event ue_reset();// RESET ALL OF THE DATAWINDOW TO CLEAR OUT OLD DATA


DATAWINDOW ldw
long ll_i

FOR ll_i =  1 to upperbound(this.control)
	IF this.Control[ll_i].TypeOf() = datawindow! THEN
		ldw =  this.Control[ll_i]
		ldw.reset( )
   END IF
next
end event

public function integer of_show_missing_msg (string as_column_name, u_dw adw, string as_field_type, long al_row);/******************************************************************************************************************
**  [PUBLIC]   : of_show_missing_msg
**==================================================================================================================
**  Purpose   	: Display a missing data message
**==================================================================================================================
**  Arguments 	: [string]  AS_COLUMN_NAME
					  [u_dw]    ADW
					  [string]  as_field_type
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 12 October 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_statement1
string ls_statement2
string ls_title

ls_statement1 = 'The field '
ls_statement2 = ' is missing a value. Please enter one and try again.'
ls_title       = 'Missing Information'   //(Appeon)Harry 10.30.2013 - V141 ISG-CLX  for V14 Testing - Bug # 3720:modify 'Missing Infomation' to 'Missing Information'



choose case lower(as_field_type)
	case 'date'
		if not f_validstr(string(ADw.getitemDate(al_row, as_column_name))) then 
			messagebox(ls_title, ls_statement1 +  ADW.INV_base.OF_GETcolumndisplayname(AS_COLUMN_NAME ) + ls_statement2)
			ADW.setcolumn( AS_COLUMN_NAME)
			return failure
		end if 
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07.10.2006 By: Rodger Wu
	//$<reason> fix a defect.
	case 'datetime'
		if not f_validstr(string(ADw.getitemDatetime(al_row, as_column_name))) then 
			messagebox(ls_title, ls_statement1 +  ADW.INV_base.OF_GETcolumndisplayname(AS_COLUMN_NAME ) + ls_statement2)
			ADW.setcolumn( AS_COLUMN_NAME)
			return failure
		end if 		
	//---------------------------- APPEON END ----------------------------

	CASE 'number'
		if not f_validstr(string(ADw.getitemnumber(al_row, as_column_name))) then 
			messagebox(ls_title, ls_statement1 +  ADW.INV_base.OF_GETcolumndisplayname(AS_COLUMN_NAME ) + ls_statement2)
			ADW.setcolumn( AS_COLUMN_NAME)
			return failure
		end if
		
end choose
	

RETURN SUCcess
		
end function

on u_tabpg.create
call super::create
end on

on u_tabpg.destroy
call super::destroy
end on

event constructor;call super::constructor;

this.of_getparentwindow( iw_parent)

// store a referance to the parent tab
// start code change --- 11.21.2005 MSKINNER
i_parent_tab = this.GetParent( )
// end code change --- 11.21.2005 MSKINNER

// Turn on the Resize Service
this.of_SetResize (TRUE)
long ll_i
FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (CONTrol[LL_I]  , inv_resize.scale	 )
NEXT


end event

