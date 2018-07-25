$PBExportHeader$u_base.sru
$PBExportComments$Extension Visual Ancestor class
forward
global type u_base from pfc_u_base
end type
end forward

global type u_base from pfc_u_base
end type
global u_base u_base

type prototypes
SUBROUTINE GetClientRect (ULONG hClntWnd, REF STR_CLIENT_RECT lpRect) LIBRARY "USER32.DLL" alias for "GetClientRect;Ansi" 
end prototypes

type variables
// mskinner 28 feb 2006 -- begin
n_ToolTip 	inv_ToolTip
string 		is_ColName
integer 		ii_dwID
// mskinner 28 feb 2006 -- end

Long il_width,il_height //Added by Ken.Guo on 2008-12-03

end variables

on u_base.create
call super::create
end on

on u_base.destroy
call super::destroy
end on

event resize;call super::resize;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : u_base::resize (ancestor to all base user objects)
//==================================================================================================================
//  Purpose   	: Allow all datawindows to zoom when resizing
//==================================================================================================================
//  Arguments 	:  [unsignedlong] sise type
//                [integer]       newwidth
//						[integer]      newheight
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael B Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
window lw_parent

this.of_getparentwindow(lw_parent)
if isvalid(inv_resize) then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 12.03.2008 By: Ken.Guo
	//$<reason> Workaround APB's Bug.
	If This.width = il_width and This.height = il_height Then
		Return 1
	End If
	il_width = This.width  
	il_height = This.height
	//---------------------------- APPEON END ----------------------------
   this.inv_resize.of_resize( this.control[],handle(lw_parent)  )
end if



end event

event constructor;call super::constructor;

inv_tooltip.of_uo_settip(THIS)
end event

