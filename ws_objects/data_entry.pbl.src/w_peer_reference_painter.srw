$PBExportHeader$w_peer_reference_painter.srw
forward
global type w_peer_reference_painter from w_sheet
end type
type uo_peer from uo_peer_reference within w_peer_reference_painter
end type
end forward

global type w_peer_reference_painter from w_sheet
integer width = 3616
integer height = 1852
string title = "Peer Reference List"
uo_peer uo_peer
end type
global w_peer_reference_painter w_peer_reference_painter

on w_peer_reference_painter.create
int iCurrent
call super::create
this.uo_peer=create uo_peer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_peer
end on

on w_peer_reference_painter.destroy
call super::destroy
destroy(this.uo_peer)
end on

event open;call super::open;DataWindow ldw_Null

if AppeonGetClientType() = "WEB" then
	this.Width += 30
	this.Height += 30
end if

this.of_SetResize(true)
inv_resize.of_setorigsize(this.WorkspaceWidth(), this.WorkspaceHeight())
inv_resize.of_setminsize(this.WorkspaceWidth(), this.WorkspaceHeight())
inv_resize.of_Register(uo_peer, inv_resize.SCALE)

uo_peer.of_Init(this, ldw_Null, 1)
end event

event activate;call super::activate;if w_mdi.menuname <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if
end event

event closequery;Return 0 //Add by Evan 07.10.2009(Corrected BugN062902) -- Not extend ancestor script
end event

type uo_peer from uo_peer_reference within w_peer_reference_painter
integer taborder = 20
end type

on uo_peer.destroy
call uo_peer_reference::destroy
end on

