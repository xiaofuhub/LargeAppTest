$PBExportHeader$w_peer_reference_select.srw
forward
global type w_peer_reference_select from window
end type
type uo_peer from uo_peer_reference within w_peer_reference_select
end type
end forward

global type w_peer_reference_select from window
integer x = 553
integer y = 388
integer width = 3589
integer height = 1828
boolean titlebar = true
string title = "Select Peer Record"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
boolean center = true
uo_peer uo_peer
end type
global w_peer_reference_select w_peer_reference_select

type variables

end variables

on w_peer_reference_select.create
this.uo_peer=create uo_peer
this.Control[]={this.uo_peer}
end on

on w_peer_reference_select.destroy
destroy(this.uo_peer)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

DataWindow ldw_peer

ldw_peer = Message.PowerObjectParm
uo_peer.of_Init(this, ldw_peer, 2)

if AppeonGetClientType() = "WEB" then
	this.Width += 20
	this.Height += 20
end if
end event

type uo_peer from uo_peer_reference within w_peer_reference_select
integer taborder = 80
end type

on uo_peer.destroy
call uo_peer_reference::destroy
end on

