$PBExportHeader$w_calendarview.srw
forward
global type w_calendarview from w_main
end type
type uo_calendar from u_day_week_month within w_calendarview
end type
end forward

global type w_calendarview from w_main
integer x = 215
integer y = 220
integer width = 3666
integer height = 2748
string title = "Calendar View"
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
uo_calendar uo_calendar
end type
global w_calendarview w_calendarview

forward prototypes
public subroutine of_regresize ()
end prototypes

public subroutine of_regresize ();This.of_SetResize(true)

This.inv_Resize.of_SetOrigSize(This.Width,This.Height)
This.inv_Resize.of_SetMinSize(800,600)

This.inv_Resize.of_Register(uo_Calendar,This.inv_Resize.SCALERIGHTBOTTOM)

end subroutine

on w_calendarview.create
int iCurrent
call super::create
this.uo_calendar=create uo_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_calendar
end on

on w_calendarview.destroy
call super::destroy
destroy(this.uo_calendar)
end on

event open;call super::open;This.BackColor = uo_Calendar.BackColor

uo_Calendar.Move(0,0)

if AppeonGetClientType() = "WEB" then
	uo_Calendar.Resize(This.Width + 22,This.Height + 26)
else
	uo_Calendar.Resize(This.Width,This.Height)
end if

of_RegResize()

uo_Calendar.uo_Condition_Setting.rb_AllRecords.Checked = true
uo_Calendar.uo_Condition_Setting.rb_AllRecords.TriggerEvent(Clicked!)

end event

event activate;call super::activate;//Hide contract folder toolbar - jervis 12.21.2010
If w_mdi.MenuName <> "m_pfe_cst_mdi_menu" Then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
End If


if isvalid(m_pfe_cst_mdi_menu) then
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//m_pfe_cst_mdi_menu.m_file.m_contractglobalsearch.ToolBaritemVisible = False
	//m_pfe_cst_mdi_menu.m_file.m_calendar.ToolBaritemVisible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_file.m_contractglobalsearch,'ToolBaritemVisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_file.m_calendar,'ToolBaritemVisible', False)
	//---------End Modfiied ------------------------------------------------------
end if
end event

event close;call super::close;//--------------------------- APPEON BEGIN ---------------------------
//$<add> jervis 12.03.2010
//$<reason> when this windows close, restore to mdi menu.
window lw_activesheet
lw_activesheet = w_mdi.GetNextSheet(This)
If Not isvalid(lw_activesheet) Then
	//If no any sheet window.
	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then
		w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	End If
	w_mdi.of_menu_security( w_mdi.MenuName )
End If

  
end event

type uo_calendar from u_day_week_month within w_calendarview
integer taborder = 20
end type

on uo_calendar.destroy
call u_day_week_month::destroy
end on

