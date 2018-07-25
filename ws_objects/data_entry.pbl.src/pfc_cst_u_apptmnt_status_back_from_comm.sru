$PBExportHeader$pfc_cst_u_apptmnt_status_back_from_comm.sru
forward
global type pfc_cst_u_apptmnt_status_back_from_comm from pfc_cst_u_apptmnt_status
end type
end forward

global type pfc_cst_u_apptmnt_status_back_from_comm from pfc_cst_u_apptmnt_status
integer width = 3611
integer height = 2080
long backcolor = 33551856
end type
global pfc_cst_u_apptmnt_status_back_from_comm pfc_cst_u_apptmnt_status_back_from_comm

on pfc_cst_u_apptmnt_status_back_from_comm.create
call super::create
end on

on pfc_cst_u_apptmnt_status_back_from_comm.destroy
call super::destroy
end on

event constructor;call super::constructor;If Upper(appeongetclienttype()) = "WEB" Then
	if tab_view.tabpage_browse.visible = false then
		if tab_view.selectedtab = 1 then
			tab_view.selectedtab = 2
		end if
	end if		
End If
end event

type st_recs from pfc_cst_u_apptmnt_status`st_recs within pfc_cst_u_apptmnt_status_back_from_comm
integer x = 2226
integer y = 32
long backcolor = 33551856
end type

type dw_orgs_facilities from pfc_cst_u_apptmnt_status`dw_orgs_facilities within pfc_cst_u_apptmnt_status_back_from_comm
boolean visible = false
integer x = 722
integer y = 300
integer width = 905
integer height = 1628
end type

type tab_view from pfc_cst_u_apptmnt_status`tab_view within pfc_cst_u_apptmnt_status_back_from_comm
integer x = 9
integer height = 2016
long backcolor = 33551856
end type

type tabpage_browse from pfc_cst_u_apptmnt_status`tabpage_browse within tab_view
boolean visible = false
integer height = 1900
long backcolor = 33551856
end type

type dw_browse from pfc_cst_u_apptmnt_status`dw_browse within tabpage_browse
integer height = 1880
end type

type tabpage_detail_1 from pfc_cst_u_apptmnt_status`tabpage_detail_1 within tab_view
integer height = 1900
long backcolor = 33551856
end type

type dw_apptmnt_status from pfc_cst_u_apptmnt_status`dw_apptmnt_status within tabpage_detail_1
integer height = 1440
boolean bringtotop = true
end type

type gb_comm from pfc_cst_u_apptmnt_status`gb_comm within tabpage_detail_1
integer y = 1452
integer height = 384
end type

type dw_comm_review from pfc_cst_u_apptmnt_status`dw_comm_review within tabpage_detail_1
integer x = 64
integer y = 1544
integer height = 268
end type

type tabpage_detail_2 from pfc_cst_u_apptmnt_status`tabpage_detail_2 within tab_view
integer height = 1900
end type

type dw_leave from pfc_cst_u_apptmnt_status`dw_leave within tabpage_detail_2
end type

type gb_lea from pfc_cst_u_apptmnt_status`gb_lea within tabpage_detail_2
end type

type gb_dep from pfc_cst_u_apptmnt_status`gb_dep within tabpage_detail_2
end type

type gb_cat from pfc_cst_u_apptmnt_status`gb_cat within tabpage_detail_2
end type

type dw_staff_cat from pfc_cst_u_apptmnt_status`dw_staff_cat within tabpage_detail_2
end type

type dw_departments from pfc_cst_u_apptmnt_status`dw_departments within tabpage_detail_2
end type

type tabpage_quest from pfc_cst_u_apptmnt_status`tabpage_quest within tab_view
integer height = 1900
end type

type dw_quest from pfc_cst_u_apptmnt_status`dw_quest within tabpage_quest
end type

type tabpage_ofe from pfc_cst_u_apptmnt_status`tabpage_ofe within tab_view
boolean visible = false
integer height = 1900
long backcolor = 33551856
end type

type uo_ofe from pfc_cst_u_apptmnt_status`uo_ofe within tabpage_ofe
integer x = 5
integer y = 8
end type

type p_1 from pfc_cst_u_apptmnt_status`p_1 within pfc_cst_u_apptmnt_status_back_from_comm
end type

type dw_facility_add from pfc_cst_u_apptmnt_status`dw_facility_add within pfc_cst_u_apptmnt_status_back_from_comm
end type

