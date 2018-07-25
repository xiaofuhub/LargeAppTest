$PBExportHeader$pfc_cst_u_de_display.sru
forward
global type pfc_cst_u_de_display from pfc_cst_u_data_entry
end type
end forward

global type pfc_cst_u_de_display from pfc_cst_u_data_entry
integer width = 1065
integer height = 2416
end type
global pfc_cst_u_de_display pfc_cst_u_de_display

on pfc_cst_u_de_display.create
int iCurrent
call super::create
end on

on pfc_cst_u_de_display.destroy
call super::destroy
end on

type cb_decheck from pfc_cst_u_data_entry`cb_decheck within pfc_cst_u_de_display
integer x = 3685
integer y = 396
end type

type st_dw_select_section_border from pfc_cst_u_data_entry`st_dw_select_section_border within pfc_cst_u_de_display
integer x = 2683
integer y = 84
integer height = 84
end type

type cb_view_relation from pfc_cst_u_data_entry`cb_view_relation within pfc_cst_u_de_display
end type

type st_select from pfc_cst_u_data_entry`st_select within pfc_cst_u_de_display
end type

type dw_addresses from pfc_cst_u_data_entry`dw_addresses within pfc_cst_u_de_display
integer x = 3685
integer y = 1840
end type

type st_recs from pfc_cst_u_data_entry`st_recs within pfc_cst_u_de_display
end type

type dw_ver_data from pfc_cst_u_data_entry`dw_ver_data within pfc_cst_u_de_display
integer x = 1970
integer y = 1220
end type

type dw_select_section from pfc_cst_u_data_entry`dw_select_section within pfc_cst_u_de_display
integer x = 14
integer width = 1029
integer height = 432
end type

type dw_loc_defaults from pfc_cst_u_data_entry`dw_loc_defaults within pfc_cst_u_de_display
end type

type r_1 from pfc_cst_u_data_entry`r_1 within pfc_cst_u_de_display
integer x = 3040
integer y = 220
end type

type dw_link_list from pfc_cst_u_data_entry`dw_link_list within pfc_cst_u_de_display
integer x = 2994
integer y = 1464
end type

type dw_detail from pfc_cst_u_data_entry`dw_detail within pfc_cst_u_de_display
integer x = 14
integer y = 904
integer width = 1029
integer height = 1488
end type

type dw_browse from pfc_cst_u_data_entry`dw_browse within pfc_cst_u_de_display
integer x = 14
integer y = 456
integer width = 1029
integer height = 444
end type

type tab_view from pfc_cst_u_data_entry`tab_view within pfc_cst_u_de_display
integer x = 2949
integer y = 0
end type

type tabpage_browse from pfc_cst_u_data_entry`tabpage_browse within tab_view
end type

type tabpage_details from pfc_cst_u_data_entry`tabpage_details within tab_view
end type

type tabpage_image from pfc_cst_u_data_entry`tabpage_image within tab_view
end type

type dw_detail_2 from pfc_cst_u_data_entry`dw_detail_2 within tabpage_image
end type

type tabpage_linked_data from pfc_cst_u_data_entry`tabpage_linked_data within tab_view
end type

type uo_linked_data from pfc_cst_u_data_entry`uo_linked_data within tabpage_linked_data
end type

