$PBExportHeader$uo_oppe_fppe_evals_appt.sru
forward
global type uo_oppe_fppe_evals_appt from uo_oppe_fppe_evals
end type
end forward

global type uo_oppe_fppe_evals_appt from uo_oppe_fppe_evals
integer width = 3447
integer height = 1788
end type
global uo_oppe_fppe_evals_appt uo_oppe_fppe_evals_appt

forward prototypes
public function integer of_set_bg_color (long al_color)
end prototypes

public function integer of_set_bg_color (long al_color);this.backcolor = al_color
this.tab_1.backcolor = al_color
this.tab_1.tabpage_1.backcolor  = al_color
this.tab_1.tabpage_2.backcolor  = al_color
this.tab_1.tabpage_actions.backcolor  = al_color

return 1
end function

on uo_oppe_fppe_evals_appt.create
call super::create
end on

on uo_oppe_fppe_evals_appt.destroy
call super::destroy
end on

type cb_email from uo_oppe_fppe_evals`cb_email within uo_oppe_fppe_evals_appt
integer x = 2382
integer y = 12
end type

type cb_letter from uo_oppe_fppe_evals`cb_letter within uo_oppe_fppe_evals_appt
integer x = 2030
integer y = 12
end type

type cb_add_flag from uo_oppe_fppe_evals`cb_add_flag within uo_oppe_fppe_evals_appt
integer x = 1070
integer y = 12
integer width = 485
end type

type p_1 from uo_oppe_fppe_evals`p_1 within uo_oppe_fppe_evals_appt
end type

type cb_view from uo_oppe_fppe_evals`cb_view within uo_oppe_fppe_evals_appt
end type

type cb_save from uo_oppe_fppe_evals`cb_save within uo_oppe_fppe_evals_appt
integer x = 14
integer y = 12
end type

type cb_close from uo_oppe_fppe_evals`cb_close within uo_oppe_fppe_evals_appt
integer x = 3031
integer y = 12
end type

type cb_delete from uo_oppe_fppe_evals`cb_delete within uo_oppe_fppe_evals_appt
integer x = 718
integer y = 12
end type

type cb_add from uo_oppe_fppe_evals`cb_add within uo_oppe_fppe_evals_appt
integer x = 366
integer y = 12
end type

type rb_oppe from uo_oppe_fppe_evals`rb_oppe within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 489
integer y = 1872
integer height = 84
end type

type rb_fppe from uo_oppe_fppe_evals`rb_fppe within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 754
integer y = 1892
end type

type rb_all_stat from uo_oppe_fppe_evals`rb_all_stat within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 270
integer y = 1848
end type

type rb_cur from uo_oppe_fppe_evals`rb_cur within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 462
integer y = 1788
integer height = 124
end type

type rb_his from uo_oppe_fppe_evals`rb_his within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 777
integer y = 1852
end type

type rb_all_type from uo_oppe_fppe_evals`rb_all_type within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 283
integer y = 1900
end type

type tab_1 from uo_oppe_fppe_evals`tab_1 within uo_oppe_fppe_evals_appt
integer x = 14
integer y = 112
integer width = 3383
end type

type tabpage_1 from uo_oppe_fppe_evals`tabpage_1 within tab_1
integer width = 3346
end type

type dw_detail from uo_oppe_fppe_evals`dw_detail within tabpage_1
integer x = 0
integer y = 596
integer width = 3337
integer height = 904
string dataobject = "d_oppe_fppe_prac_detail_appt"
end type

type dw_detailxx from uo_oppe_fppe_evals`dw_detailxx within tabpage_1
end type

type dw_browse from uo_oppe_fppe_evals`dw_browse within tabpage_1
integer x = 0
integer width = 3337
integer height = 576
boolean titlebar = false
string dataobject = "d_oppe_fppe_prac_browse_appt"
boolean border = true
end type

type tabpage_2 from uo_oppe_fppe_evals`tabpage_2 within tab_1
integer width = 3346
end type

type dw_docs from uo_oppe_fppe_evals`dw_docs within tabpage_2
integer x = 0
integer y = 4
integer width = 3346
integer height = 1500
boolean titlebar = false
boolean hscrollbar = true
boolean border = true
borderstyle borderstyle = stylebox!
end type

type tabpage_actions from uo_oppe_fppe_evals`tabpage_actions within tab_1
integer width = 3346
end type

type dw_act_browse from uo_oppe_fppe_evals`dw_act_browse within tabpage_actions
integer y = 0
integer width = 3337
end type

type dw_actions from uo_oppe_fppe_evals`dw_actions within tabpage_actions
integer y = 1112
integer width = 3346
integer height = 404
end type

type cb_update from uo_oppe_fppe_evals`cb_update within uo_oppe_fppe_evals_appt
integer x = 1559
integer y = 12
end type

type gb_1 from uo_oppe_fppe_evals`gb_1 within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 224
integer y = 1832
integer height = 152
end type

type gb_2 from uo_oppe_fppe_evals`gb_2 within uo_oppe_fppe_evals_appt
boolean visible = false
integer x = 238
integer y = 1788
integer height = 152
end type

