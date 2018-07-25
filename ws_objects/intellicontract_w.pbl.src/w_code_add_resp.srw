$PBExportHeader$w_code_add_resp.srw
$PBExportComments$[intellicontract_w] Used to add lookup codes
forward
global type w_code_add_resp from w_response
end type
type cb_3 from u_cb within w_code_add_resp
end type
type cb_2 from u_cb within w_code_add_resp
end type
type dw_1 from u_dw within w_code_add_resp
end type
type gb_1 from u_gb within w_code_add_resp
end type
end forward

global type w_code_add_resp from w_response
integer width = 2254
integer height = 1276
long backcolor = 33551856
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_code_add_resp w_code_add_resp

type variables
string is_lookup_name
str_pass istr_pass 
end variables

forward prototypes
public function integer of_add_code (integer al_row)
end prototypes

public function integer of_add_code (integer al_row);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if AL_row > 0 then
	istr_pass.s_u_dw.object.field_value[istr_pass.s_u_dw.getrow()] = DW_1.object.code[AL_row]
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.18.2006 By: Rodger Wu Bryan
	//$<reason> Bug fixing
	//$<reason> It is more effective to call close function in Clicked event of button.
	/*	event pfc_close( ) */
	cb_3.Post Event clicked()
	//---------------------------- APPEON END ----------------------------
end if

return success
end function

on w_code_add_resp.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_code_add_resp.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

istr_pass = message.powerobjectparm



if not isvalid(message.powerobjectparm) then
    messagebox(This.title,'bad message.powerobjectparm')
	return 
end if

if not isvalid(istr_pass) then
    messagebox(This.title,'badstructure')
	return 
end if


is_lookup_name = istr_pass.s_string


if f_validstr(is_lookup_name) then
   dw_1.event pfc_retrieve( )
else 
	messagebox(This.title,'Lookup not passed to the window')
	event pfc_close( )
end if
end event

type cb_3 from u_cb within w_code_add_resp
integer x = 1879
integer y = 1076
integer taborder = 30
string text = "&Cancel"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_2 from u_cb within w_code_add_resp
integer x = 1477
integer y = 1076
integer taborder = 30
string text = "&OK"
end type

event clicked;call super::clicked;

OF_add_code( DW_1.GETROW() )


end event

type dw_1 from u_dw within w_code_add_resp
integer x = 37
integer y = 64
integer width = 2158
integer height = 960
integer taborder = 10
string dataobject = "d_code_add_resp"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event pfc_retrieve;call super::pfc_retrieve;
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


retrieve(is_lookup_name)
gb_1.text  =  'Lookup Codes for ' + is_lookup_name
return success
end event

event doubleclicked;call super::doubleclicked;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

OF_add_code(ROW )



end event

type gb_1 from u_gb within w_code_add_resp
integer width = 2231
integer height = 1056
integer taborder = 10
long backcolor = 33551856
string text = "Lookup Codes"
end type

