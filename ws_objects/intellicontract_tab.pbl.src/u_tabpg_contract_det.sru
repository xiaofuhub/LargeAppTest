$PBExportHeader$u_tabpg_contract_det.sru
$PBExportComments$[intellicontract_tab]  The details tab Page
forward
global type u_tabpg_contract_det from u_tabpg_contract_master
end type
type uo_1 from u_tabpg_contract_detail1 within u_tabpg_contract_det
end type
end forward

global type u_tabpg_contract_det from u_tabpg_contract_master
integer width = 3977
integer height = 2160
long backcolor = 33551856
string text = "Details"
string powertiptext = "Contract Details"
uo_1 uo_1
end type
global u_tabpg_contract_det u_tabpg_contract_det

type variables

end variables

forward prototypes
public function integer of_retrieve ()
end prototypes

public function integer of_retrieve ();/******************************************************************************************************************
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

//if not ib_retrieved then
//	this.dw_1.event pfc_retrieve( )
//	this.dw_custom.event pfc_retrieve( )
//	this.dw_ccc.event pfc_retrieve( )
//	this.dw_occ.event pfc_retrieve( )
//end if
//
//ib_retrieved = true
if not ib_retrieved then
	this.uo_1.of_retrieve( )
end if



//this.tab_1.tabpage_1.of_retrieve( )
//this.tab_1.tabpage_2.of_retrieve( )



RETURN success
end function

on u_tabpg_contract_det.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_contract_det.destroy
call super::destroy
destroy(this.uo_1)
end on

event ue_reset_ib_retrieve;call super::ue_reset_ib_retrieve;

ib_retrieved = false
end event

event constructor;call super::constructor;



//powerobject lpo[]
//lpo[1] = dw_custom
//lpo[2] = dw_1
//lpo[3] = dw_ccc
//lpo[4] = dw_occ
//this.of_setupdateobjects( lpo)
//

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	//this.inv_resize.of_register( u_tabpg_contract_det,inv_resize.scalerightbottom)
	this.inv_resize.of_register( uo_1,inv_resize.scalerightbottom)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_selectionchanged;call super::ue_selectionchanged;this.uo_1.dw_1.Post setfocus()

end event

event ue_set_security;call super::ue_set_security;//Added by Alfee 09.30.2007
uo_1.event ue_set_security()
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_det
boolean visible = false
integer x = 73
integer y = 2080
integer width = 3474
integer height = 64
long backcolor = 33551856
end type

type uo_1 from u_tabpg_contract_detail1 within u_tabpg_contract_det
event destroy ( )
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call u_tabpg_contract_detail1::destroy
end on

