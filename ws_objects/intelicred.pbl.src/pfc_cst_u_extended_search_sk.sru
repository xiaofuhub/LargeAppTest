$PBExportHeader$pfc_cst_u_extended_search_sk.sru
forward
global type pfc_cst_u_extended_search_sk from pfc_cst_u_extended_search
end type
type st_1 from statictext within pfc_cst_u_extended_search_sk
end type
end forward

global type pfc_cst_u_extended_search_sk from pfc_cst_u_extended_search
integer width = 4082
integer height = 1824
long backcolor = 33551856
st_1 st_1
end type
global pfc_cst_u_extended_search_sk pfc_cst_u_extended_search_sk

forward prototypes
public function integer of_resize (string as_type)
end prototypes

public function integer of_resize (string as_type);return 1 
end function

on pfc_cst_u_extended_search_sk.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on pfc_cst_u_extended_search_sk.destroy
call super::destroy
destroy(this.st_1)
end on

type cb_grid from pfc_cst_u_extended_search`cb_grid within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 4293
integer y = 1076
end type

type cb_adv from pfc_cst_u_extended_search`cb_adv within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 4151
integer y = 1076
end type

type cb_dept_help from pfc_cst_u_extended_search`cb_dept_help within pfc_cst_u_extended_search_sk
integer x = 782
integer y = 1844
end type

type cb_facility_help from pfc_cst_u_extended_search`cb_facility_help within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 4105
integer y = 856
end type

type cb_view_help from pfc_cst_u_extended_search`cb_view_help within pfc_cst_u_extended_search_sk
integer x = 631
integer y = 1880
end type

type cb_loc from pfc_cst_u_extended_search`cb_loc within pfc_cst_u_extended_search_sk
integer x = 4288
integer y = 1076
end type

type pb_lost from pfc_cst_u_extended_search`pb_lost within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3625
integer y = 2940
end type

type dw_prof_suffix from pfc_cst_u_extended_search`dw_prof_suffix within pfc_cst_u_extended_search_sk
integer x = 50
integer y = 340
integer width = 741
end type

type r_new from pfc_cst_u_extended_search`r_new within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 4686
integer y = 1064
end type

type gb_department from pfc_cst_u_extended_search`gb_department within pfc_cst_u_extended_search_sk
integer x = 2994
integer y = 2404
end type

type gb_view from pfc_cst_u_extended_search`gb_view within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 2825
integer y = 2512
long backcolor = 33415655
end type

type dw_department from pfc_cst_u_extended_search`dw_department within pfc_cst_u_extended_search_sk
integer x = 2967
integer y = 2408
end type

type cb_iverify from pfc_cst_u_extended_search`cb_iverify within pfc_cst_u_extended_search_sk
integer x = 3328
integer y = 2512
end type

type ddlb_search_type from pfc_cst_u_extended_search`ddlb_search_type within pfc_cst_u_extended_search_sk
integer x = 50
integer y = 252
integer width = 741
long backcolor = 33551856
end type

type cbx_status from pfc_cst_u_extended_search`cbx_status within pfc_cst_u_extended_search_sk
integer x = 3063
integer y = 2500
end type

type dw_view from pfc_cst_u_extended_search`dw_view within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 2825
integer y = 2548
end type

type cb_select from pfc_cst_u_extended_search`cb_select within pfc_cst_u_extended_search_sk
integer x = 366
integer y = 456
integer width = 320
end type

type cb_search from pfc_cst_u_extended_search`cb_search within pfc_cst_u_extended_search_sk
integer x = 50
integer y = 456
integer width = 320
end type

type dw_dept from pfc_cst_u_extended_search`dw_dept within pfc_cst_u_extended_search_sk
integer x = 50
integer y = 344
integer width = 741
end type

type dw_org_facility_select from pfc_cst_u_extended_search`dw_org_facility_select within pfc_cst_u_extended_search_sk
integer x = 50
integer y = 72
end type

type gb_facility from pfc_cst_u_extended_search`gb_facility within pfc_cst_u_extended_search_sk
integer x = 23
integer y = 24
long backcolor = 33551856
string text = "Select Group"
end type

type cb_new from pfc_cst_u_extended_search`cb_new within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3561
integer y = 2796
integer width = 320
end type

type sle_srch_val from pfc_cst_u_extended_search`sle_srch_val within pfc_cst_u_extended_search_sk
integer x = 50
integer y = 344
integer width = 741
long backcolor = 16777215
end type

type dw_search from pfc_cst_u_extended_search`dw_search within pfc_cst_u_extended_search_sk
integer x = 1093
integer y = 28
integer width = 2949
integer height = 1756
string dataobject = "d_extended_search_sk"
end type

type cbx_valid from pfc_cst_u_extended_search`cbx_valid within pfc_cst_u_extended_search_sk
integer x = 2181
integer y = 2580
end type

type cb_29 from pfc_cst_u_extended_search`cb_29 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 215
integer y = 968
end type

type rb_appr from pfc_cst_u_extended_search`rb_appr within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3616
integer y = 2424
end type

type rb_ver from pfc_cst_u_extended_search`rb_ver within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3433
integer y = 2424
end type

type rb_de from pfc_cst_u_extended_search`rb_de within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3227
integer y = 2424
end type

type cb_27 from pfc_cst_u_extended_search`cb_27 within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3209
integer y = 2812
end type

type cb_26 from pfc_cst_u_extended_search`cb_26 within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 2866
integer y = 2800
end type

type cb_1 from pfc_cst_u_extended_search`cb_1 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 59
integer y = 632
end type

type cb_2 from pfc_cst_u_extended_search`cb_2 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 215
integer y = 632
end type

type cb_3 from pfc_cst_u_extended_search`cb_3 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 370
integer y = 632
end type

type cb_4 from pfc_cst_u_extended_search`cb_4 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 530
integer y = 632
end type

type cb_5 from pfc_cst_u_extended_search`cb_5 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 686
integer y = 632
end type

type cb_6 from pfc_cst_u_extended_search`cb_6 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 855
integer y = 632
end type

type cb_7 from pfc_cst_u_extended_search`cb_7 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 59
integer y = 716
end type

type cb_8 from pfc_cst_u_extended_search`cb_8 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 215
integer y = 716
end type

type cb_9 from pfc_cst_u_extended_search`cb_9 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 370
integer y = 716
end type

type cb_10 from pfc_cst_u_extended_search`cb_10 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 530
integer y = 716
end type

type cb_11 from pfc_cst_u_extended_search`cb_11 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 686
integer y = 716
end type

type cb_12 from pfc_cst_u_extended_search`cb_12 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 855
integer y = 716
end type

type cb_13 from pfc_cst_u_extended_search`cb_13 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 59
integer y = 800
end type

type cb_14 from pfc_cst_u_extended_search`cb_14 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 215
integer y = 800
end type

type cb_15 from pfc_cst_u_extended_search`cb_15 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 370
integer y = 800
end type

type cb_16 from pfc_cst_u_extended_search`cb_16 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 530
integer y = 800
end type

type cb_17 from pfc_cst_u_extended_search`cb_17 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 686
integer y = 800
end type

type cb_18 from pfc_cst_u_extended_search`cb_18 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 855
integer y = 800
end type

type cb_19 from pfc_cst_u_extended_search`cb_19 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 59
integer y = 884
end type

type cb_20 from pfc_cst_u_extended_search`cb_20 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 215
integer y = 884
end type

type cb_21 from pfc_cst_u_extended_search`cb_21 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 370
integer y = 884
end type

type cb_22 from pfc_cst_u_extended_search`cb_22 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 530
integer y = 884
end type

type cb_23 from pfc_cst_u_extended_search`cb_23 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 686
integer y = 884
end type

type cb_24 from pfc_cst_u_extended_search`cb_24 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 855
integer y = 884
end type

type cb_25 from pfc_cst_u_extended_search`cb_25 within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 55
integer y = 968
end type

type cb_clear from pfc_cst_u_extended_search`cb_clear within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3840
integer y = 2424
end type

type gb_letters from pfc_cst_u_extended_search`gb_letters within pfc_cst_u_extended_search_sk
boolean visible = true
integer x = 23
integer y = 576
integer height = 484
long textcolor = 8388608
long backcolor = 33551856
end type

type ddlb_status from pfc_cst_u_extended_search`ddlb_status within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 2912
integer y = 2676
end type

type gb_search from pfc_cst_u_extended_search`gb_search within pfc_cst_u_extended_search_sk
integer x = 78
integer y = 1864
integer height = 248
end type

type rb_aud from pfc_cst_u_extended_search`rb_aud within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3022
integer y = 2424
end type

type dw_tasksxxx from pfc_cst_u_extended_search`dw_tasksxxx within pfc_cst_u_extended_search_sk
end type

type uo_grid from pfc_cst_u_extended_search`uo_grid within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 4128
integer y = 0
end type

type gb_status from pfc_cst_u_extended_search`gb_status within pfc_cst_u_extended_search_sk
boolean visible = false
integer x = 3013
integer y = 2360
end type

type st_hide from pfc_cst_u_extended_search`st_hide within pfc_cst_u_extended_search_sk
end type

type st_dw_search_border from pfc_cst_u_extended_search`st_dw_search_border within pfc_cst_u_extended_search_sk
integer x = 1143
integer y = 2388
end type

type cb_close from pfc_cst_u_extended_search`cb_close within pfc_cst_u_extended_search_sk
integer x = 695
integer y = 456
end type

type st_1 from statictext within pfc_cst_u_extended_search_sk
integer x = 55
integer y = 196
integer width = 402
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Search on:"
boolean focusrectangle = false
end type

type gb_2 from pfc_cst_u_extended_search`gb_letters within pfc_cst_u_extended_search_sk
integer x = 41
integer y = 572
long backcolor = 32891346
end type

