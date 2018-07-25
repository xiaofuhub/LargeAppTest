$PBExportHeader$uo_statusbar.sru
forward
global type uo_statusbar from u_dw
end type
end forward

global type uo_statusbar from u_dw
integer width = 2528
integer height = 100
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
boolean ib_showtipshelp = false
end type
global uo_statusbar uo_statusbar

on uo_statusbar.create
call super::create
end on

on uo_statusbar.destroy
call super::destroy
end on

