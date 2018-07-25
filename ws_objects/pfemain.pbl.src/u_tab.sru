$PBExportHeader$u_tab.sru
$PBExportComments$Extension Tab class
forward
global type u_tab from pfc_u_tab
end type
end forward

global type u_tab from pfc_u_tab
boolean fixedwidth = true
boolean powertips = true
boolean showpicture = true
boolean boldselectedtext = true
event ue_set_resize ( )
end type
global u_tab u_tab

type variables
window iw_parent
end variables

forward prototypes
public function integer of_select_tab (u_tabpg auo_tabpage)
end prototypes

event ue_set_resize();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.22.2006 By: LeiWei
//$<reason> Performance tuning. The following scripts reduce performance much in web application. 
//$<reason> So comment out the resize function in web application. 
If appeongetclienttype() = 'WEB' Then Return
//---------------------------- APPEON END ----------------------------

iw_parent.dynamic of_setresize(true)
iw_parent.dynamic of_Register (this)
end event

public function integer of_select_tab (u_tabpg auo_tabpage);/*-------------------------------------------------------------------------- 
---- 
 Object: u_tab_defaults 
 Function:   of_Validation_failure 
 Parameters:      userobject auo_tabpage 
 Returns:         (None) 


 Copyright ¿ 2000  - Philip Salgannik 
 Date Created: 05/22/00 


 Description: 


---------------------------------------------------------------------------- 
---- 
 Modifications: 
 Date            Author              Comments 


---------------------------------------------------------------------------- 
--*/ 


IF Control[SelectedTab] <> auo_tabpage THEN SelectTab(auo_tabpage)

return 0
end function

event constructor;call super::constructor;

this.of_getparentwindow(iw_parent)

this.of_setresize( true)
end event

event selectionchanging;call super::selectionchanging;

//this.of_getparentwindow( lw_parent_window)
//iw_parent.dynamic of_accepttext( true)
//
//if iw_parent.function dynamic of_validation( ) <> 1 then 
//	return  1
//end if
end event

