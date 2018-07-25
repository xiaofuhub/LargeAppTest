$PBExportHeader$w_statusbar.srw
$PBExportComments$Extension Statusbar window
forward
global type w_statusbar from pfc_w_statusbar
end type
end forward

global type w_statusbar from pfc_w_statusbar
integer width = 1760
integer height = 96
end type
global w_statusbar w_statusbar

on w_statusbar.create
call super::create
end on

on w_statusbar.destroy
call super::destroy
end on

event open;call super::open;//---------Begin Added by (Appeon)Toney 06.05.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 07/12/2012. to workaround APB bug. when refresh IE, the popup window do not close.
gw_popup[UpperBound(gw_popup[]) + 1] = This
//---------End Added ------------------------------------------------------------------

end event

type dw_statusbar from pfc_w_statusbar`dw_statusbar within w_statusbar
end type

