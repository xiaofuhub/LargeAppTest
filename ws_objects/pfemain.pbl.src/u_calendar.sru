$PBExportHeader$u_calendar.sru
$PBExportComments$Extension Calendar class
forward
global type u_calendar from pfc_u_calendar
end type
end forward

global type u_calendar from pfc_u_calendar
end type
global u_calendar u_calendar

on u_calendar.create
call super::create
end on

on u_calendar.destroy
call super::destroy
end on

type dw_cal from pfc_u_calendar`dw_cal within u_calendar
end type

event dw_cal::getfocus;call super::getfocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
this.border = True
//---------------------------- APPEON END ----------------------------

end event

