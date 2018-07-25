$PBExportHeader$u_tabpage_measurments.sru
forward
global type u_tabpage_measurments from u_tabpg
end type
type uo_1 from uo_tab_measurements within u_tabpage_measurments
end type
end forward

global type u_tabpage_measurments from u_tabpg
integer width = 3680
integer height = 1896
string text = "Quality Profile"
string picturename = "Custom076!"
uo_1 uo_1
end type
global u_tabpage_measurments u_tabpage_measurments

on u_tabpage_measurments.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpage_measurments.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from uo_tab_measurements within u_tabpage_measurments
string tag = "Quality Profile"
integer y = 4
integer width = 3762
integer height = 1940
integer taborder = 21
end type

on uo_1.destroy
call uo_tab_measurements::destroy
end on

