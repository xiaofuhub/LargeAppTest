$PBExportHeader$w_prac_data_2.srw
forward
global type w_prac_data_2 from w_prac_data_1
end type
type st_1 from statictext within w_prac_data_2
end type
end forward

global type w_prac_data_2 from w_prac_data_1
st_1 st_1
end type
global w_prac_data_2 w_prac_data_2

on w_prac_data_2.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_prac_data_2.destroy
call super::destroy
destroy(this.st_1)
end on

type dw_red_flag_count from w_prac_data_1`dw_red_flag_count within w_prac_data_2
end type

type cb_close from w_prac_data_1`cb_close within w_prac_data_2
end type

type cb_notes from w_prac_data_1`cb_notes within w_prac_data_2
end type

type cb_add from w_prac_data_1`cb_add within w_prac_data_2
end type

type p_prac_photo from w_prac_data_1`p_prac_photo within w_prac_data_2
end type

type cb_1 from w_prac_data_1`cb_1 within w_prac_data_2
end type

type cb_save from w_prac_data_1`cb_save within w_prac_data_2
end type

type cb_addcb from w_prac_data_1`cb_addcb within w_prac_data_2
end type

type cb_print from w_prac_data_1`cb_print within w_prac_data_2
end type

type cb_next from w_prac_data_1`cb_next within w_prac_data_2
end type

type cb_prior from w_prac_data_1`cb_prior within w_prac_data_2
end type

type cb_b3 from w_prac_data_1`cb_b3 within w_prac_data_2
end type

type cb_b4 from w_prac_data_1`cb_b4 within w_prac_data_2
end type

type cb_b5 from w_prac_data_1`cb_b5 within w_prac_data_2
end type

type cb_b6 from w_prac_data_1`cb_b6 within w_prac_data_2
end type

type cb_b7 from w_prac_data_1`cb_b7 within w_prac_data_2
end type

type cb_delete from w_prac_data_1`cb_delete within w_prac_data_2
end type

type uo_app_stat from w_prac_data_1`uo_app_stat within w_prac_data_2
end type

type dw_standing from w_prac_data_1`dw_standing within w_prac_data_2
end type

type tab_1 from w_prac_data_1`tab_1 within w_prac_data_2
end type

type tabpage_search from w_prac_data_1`tabpage_search within tab_1
end type

type uo_search from w_prac_data_1`uo_search within tabpage_search
end type

type tabpage_detail from w_prac_data_1`tabpage_detail within tab_1
end type

type oval_2 from w_prac_data_1`oval_2 within tabpage_detail
end type

type uo_data_entry from w_prac_data_1`uo_data_entry within tabpage_detail
end type

type p_face from w_prac_data_1`p_face within tabpage_detail
end type

type tabpage_app_audit from w_prac_data_1`tabpage_app_audit within tab_1
end type

type uo_app_audit from w_prac_data_1`uo_app_audit within tabpage_app_audit
end type

type tabpage_apptmnt_status from w_prac_data_1`tabpage_apptmnt_status within tab_1
end type

type uo_affill_status from w_prac_data_1`uo_affill_status within tabpage_apptmnt_status
end type

type tabpage_verif from w_prac_data_1`tabpage_verif within tab_1
end type

type uo_verif_summary from w_prac_data_1`uo_verif_summary within tabpage_verif
end type

type tabpage_profile from w_prac_data_1`tabpage_profile within tab_1
end type

type uo_profile from w_prac_data_1`uo_profile within tabpage_profile
end type

type tabpage_image from w_prac_data_1`tabpage_image within tab_1
end type

type uo_image from w_prac_data_1`uo_image within tabpage_image
end type

type tabpage_privileges from w_prac_data_1`tabpage_privileges within tab_1
end type

type uo_priv from w_prac_data_1`uo_priv within tabpage_privileges
end type

type tabpage_net from w_prac_data_1`tabpage_net within tab_1
end type

type uo_net from w_prac_data_1`uo_net within tabpage_net
end type

type tabpage_meetings from w_prac_data_1`tabpage_meetings within tab_1
end type

type uo_meetings from w_prac_data_1`uo_meetings within tabpage_meetings
end type

type tabpage_contract from w_prac_data_1`tabpage_contract within tab_1
end type

type uo_contracts from w_prac_data_1`uo_contracts within tabpage_contract
end type

type dw_tab_buttons from w_prac_data_1`dw_tab_buttons within w_prac_data_2
end type

type st_tabname from w_prac_data_1`st_tabname within w_prac_data_2
end type

type dw_p_data from w_prac_data_1`dw_p_data within w_prac_data_2
end type

type st_buttons from w_prac_data_1`st_buttons within w_prac_data_2
end type

type st_1 from statictext within w_prac_data_2
boolean visible = false
integer x = 247
integer y = 164
integer width = 2958
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Direct inherit from prac_data_1 for additional prac folders.  Do not modify this object"
boolean focusrectangle = false
end type

