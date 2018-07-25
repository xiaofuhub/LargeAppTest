$PBExportHeader$u_tabpg_contract_images.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type u_tabpg_contract_images from u_tabpg_contract_master
end type
type tab_1 from u_tab_supporting_images_det within u_tabpg_contract_images
end type
type tab_1 from u_tab_supporting_images_det within u_tabpg_contract_images
end type
end forward

global type u_tabpg_contract_images from u_tabpg_contract_master
integer width = 4233
integer height = 2080
long backcolor = 33551856
string text = "Supporting Documents"
string powertiptext = "Supporting Documents"
tab_1 tab_1
end type
global u_tabpg_contract_images u_tabpg_contract_images

type variables
string is_old_menu 
end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_create_dw ()
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
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//string ls_menu
//ls_menu = 'm_req'
//
//if w_mdi.menuname <> 'm_req' then 
//	w_mdi.changemenu(m_req) 
//end if
if not ib_retrieved then
	this.tab_1.tabpage_browse.of_retrieve( )
	//this.tab_details.tabpage_image.tab_1.tabpage_browse.of_retrieve( )
	//this.tab_details.tabpage_docs.tab_1.tabpage_1.of_retrieve( )

 end if

ib_retrieved = true

RETURN SUCcess
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_imagesof_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.27.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_images'
ld_dw[1] = tab_1.tabpage_browse.dw_1
ls_dw_name[1] = 'dw_1'
ls_dataobject[1] = 'd_cntx_images'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_images',true) 

end subroutine

on u_tabpg_contract_images.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpg_contract_images.destroy
call super::destroy
destroy(this.tab_1)
end on

event dragdrop;call super::dragdrop;//
end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification
of_create_dw()
//---------------------------- APPEON END ----------------------------

end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_images
integer x = 251
integer y = 1920
long backcolor = 33551856
end type

type tab_1 from u_tab_supporting_images_det within u_tabpg_contract_images
integer height = 1988
integer taborder = 11
boolean bringtotop = true
alignment alignment = center!
end type

