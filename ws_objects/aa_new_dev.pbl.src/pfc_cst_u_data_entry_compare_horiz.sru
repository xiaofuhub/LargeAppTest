$PBExportHeader$pfc_cst_u_data_entry_compare_horiz.sru
forward
global type pfc_cst_u_data_entry_compare_horiz from pfc_cst_u_data_entry
end type
end forward

global type pfc_cst_u_data_entry_compare_horiz from pfc_cst_u_data_entry
integer width = 4599
integer height = 1448
long backcolor = 32891346
end type
global pfc_cst_u_data_entry_compare_horiz pfc_cst_u_data_entry_compare_horiz

on pfc_cst_u_data_entry_compare_horiz.create
call super::create
end on

on pfc_cst_u_data_entry_compare_horiz.destroy
call super::destroy
end on

type st_select from pfc_cst_u_data_entry`st_select within pfc_cst_u_data_entry_compare_horiz
boolean visible = true
integer x = 18
integer y = 8
integer width = 791
long backcolor = 32891346
string text = "Select Data Screen"
end type

type dw_addresses from pfc_cst_u_data_entry`dw_addresses within pfc_cst_u_data_entry_compare_horiz
integer x = 2962
integer y = 2748
end type

type st_recs from pfc_cst_u_data_entry`st_recs within pfc_cst_u_data_entry_compare_horiz
integer x = 3195
integer y = 1472
end type

type dw_ver_data from pfc_cst_u_data_entry`dw_ver_data within pfc_cst_u_data_entry_compare_horiz
integer x = 2203
integer y = 1808
integer width = 466
integer height = 148
end type

type dw_select_section from pfc_cst_u_data_entry`dw_select_section within pfc_cst_u_data_entry_compare_horiz
integer x = 5
integer y = 80
integer width = 1266
integer height = 88
boolean titlebar = false
string dataobject = "d_data_screens_list_comp"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type r_1 from pfc_cst_u_data_entry`r_1 within pfc_cst_u_data_entry_compare_horiz
integer x = 3095
integer y = 2880
integer width = 119
integer height = 76
end type

type dw_link_list from pfc_cst_u_data_entry`dw_link_list within pfc_cst_u_data_entry_compare_horiz
integer x = 2030
integer y = 2292
integer width = 1687
end type

type dw_detail from pfc_cst_u_data_entry`dw_detail within pfc_cst_u_data_entry_compare_horiz
integer x = 1477
integer y = 44
integer width = 3063
integer height = 1340
end type

type dw_browse from pfc_cst_u_data_entry`dw_browse within pfc_cst_u_data_entry_compare_horiz
integer x = 14
integer y = 188
integer width = 1431
integer height = 1196
end type

type tab_view from pfc_cst_u_data_entry`tab_view within pfc_cst_u_data_entry_compare_horiz
integer x = 2354
integer y = 1640
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

