$PBExportHeader$u_cst_gadget_calendar_meetings.sru
forward
global type u_cst_gadget_calendar_meetings from u_cst_gadget
end type
type uo_calendar from u_meeting_calendar within u_cst_gadget_calendar_meetings
end type
end forward

global type u_cst_gadget_calendar_meetings from u_cst_gadget
string tag = "u_gadget_5.Calendar&Meetings"
integer width = 1317
integer height = 772
uo_calendar uo_calendar
end type
global u_cst_gadget_calendar_meetings u_cst_gadget_calendar_meetings

forward prototypes
public subroutine of_set_bg_color (long al_color_value)
end prototypes

public subroutine of_set_bg_color (long al_color_value);uo_calendar.of_setuobkcolor(al_color_value)
//uo_calendar.of_setdwbkcolor(al_color_value )
end subroutine

on u_cst_gadget_calendar_meetings.create
int iCurrent
call super::create
this.uo_calendar=create uo_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_calendar
end on

on u_cst_gadget_calendar_meetings.destroy
call super::destroy
destroy(this.uo_calendar)
end on

event ue_resize_ini;call super::ue_resize_ini;//If This.width <> uo_calendar.width Then
//	uo_calendar.width = This.width 
//	uo_calendar.Event ue_resize()
//End If

If uo_calendar.x <> (This.width - uo_calendar.width)/2 Then
	uo_calendar.x = (This.width - uo_calendar.width)/2		
End If
end event

event ue_do;call super::ue_do;uo_calendar.Event ue_ini()
Return 1
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_calendar_meetings
boolean visible = false
integer x = 517
integer y = 796
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_calendar_meetings
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_calendar_meetings
integer x = 626
integer y = 796
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_calendar_meetings
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_calendar_meetings
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_calendar_meetings
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_calendar_meetings
end type

type uo_calendar from u_meeting_calendar within u_cst_gadget_calendar_meetings
integer y = 84
integer taborder = 30
boolean bringtotop = true
end type

on uo_calendar.destroy
call u_meeting_calendar::destroy
end on

