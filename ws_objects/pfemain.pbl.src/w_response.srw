$PBExportHeader$w_response.srw
$PBExportComments$Extension Response Window class
forward
global type w_response from pfc_w_response
end type
end forward

global type w_response from pfc_w_response
boolean center = true
end type
global w_response w_response

type variables
Boolean ib_move_by_mouse = True
end variables

on w_response.create
call super::create
end on

on w_response.destroy
call super::destroy
end on

event open;call super::open;IF appeongetclienttype () = 'WEB' THEN
	gw_response[UpperBound(gw_response) + 1] = This  //alfee 12.01.2014 for bug 4326  
END IF
end event

event mousedown;call super::mousedown;//====================================================================
//$<Event>: mousedown
//$<Arguments>:
// 	value    unsignedlong    flags
// 	value    integer         xpos
// 	value    integer         ypos
//$<Return>:  long
//$<Description>: Allow user to move window by mouse when no Title Bar in Response Window.
//$<Author>: (Appeon) long.zhang 12.27.2016
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
If (Not This.TitleBar) and ib_move_by_mouse Then
	CONSTANT Long WM_SYSCOMMAND = 274
	CONSTANT Long SC_MOVE = 61456
	CONSTANT Long HTCAPTION = 2
	
	Send(Handle(This), WM_SYSCOMMAND,SC_MOVE + HTCAPTION,0)
End If
end event

