$PBExportHeader$pfc_cst_u_data_entry_compare.sru
forward
global type pfc_cst_u_data_entry_compare from pfc_cst_u_data_entry
end type
end forward

global type pfc_cst_u_data_entry_compare from pfc_cst_u_data_entry
integer width = 1335
integer height = 2812
long backcolor = 32891346
end type
global pfc_cst_u_data_entry_compare pfc_cst_u_data_entry_compare

on pfc_cst_u_data_entry_compare.create
call super::create
end on

on pfc_cst_u_data_entry_compare.destroy
call super::destroy
end on

type st_select from pfc_cst_u_data_entry`st_select within pfc_cst_u_data_entry_compare
integer x = 5
integer width = 791
long backcolor = 32891346
string text = "Select Data Screen"
end type

type dw_addresses from pfc_cst_u_data_entry`dw_addresses within pfc_cst_u_data_entry_compare
integer x = 2569
integer y = 1300
end type

type st_recs from pfc_cst_u_data_entry`st_recs within pfc_cst_u_data_entry_compare
end type

type dw_ver_data from pfc_cst_u_data_entry`dw_ver_data within pfc_cst_u_data_entry_compare
integer x = 1810
integer y = 360
integer width = 466
integer height = 148
end type

type dw_select_section from pfc_cst_u_data_entry`dw_select_section within pfc_cst_u_data_entry_compare
integer x = 41
integer y = 80
integer width = 1225
integer height = 224
boolean titlebar = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type r_1 from pfc_cst_u_data_entry`r_1 within pfc_cst_u_data_entry_compare
integer x = 2702
integer y = 1432
integer width = 119
integer height = 76
end type

type dw_link_list from pfc_cst_u_data_entry`dw_link_list within pfc_cst_u_data_entry_compare
integer x = 1637
integer y = 844
integer width = 1687
end type

type dw_detail from pfc_cst_u_data_entry`dw_detail within pfc_cst_u_data_entry_compare
integer x = 41
integer y = 800
integer width = 1234
integer height = 1992
end type

type dw_browse from pfc_cst_u_data_entry`dw_browse within pfc_cst_u_data_entry_compare
integer x = 37
integer y = 324
integer width = 1234
integer height = 468
end type

type tab_view from pfc_cst_u_data_entry`tab_view within pfc_cst_u_data_entry_compare
integer x = 1961
integer y = 192
integer width = 1486
integer height = 624
end type

type tabpage_browse from pfc_cst_u_data_entry`tabpage_browse within tab_view
integer width = 1449
integer height = 496
end type

type tabpage_details from pfc_cst_u_data_entry`tabpage_details within tab_view
integer width = 1449
integer height = 496
end type

type tabpage_image from pfc_cst_u_data_entry`tabpage_image within tab_view
integer width = 1449
integer height = 496
end type

type dw_detail_2 from pfc_cst_u_data_entry`dw_detail_2 within tabpage_image
integer x = 0
integer y = 92
end type

