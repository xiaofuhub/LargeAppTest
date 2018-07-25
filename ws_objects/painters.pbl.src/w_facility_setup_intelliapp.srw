$PBExportHeader$w_facility_setup_intelliapp.srw
forward
global type w_facility_setup_intelliapp from w_response
end type
type uo_facility from pfc_cst_u_facility_setup_intelliapp within w_facility_setup_intelliapp
end type
end forward

global type w_facility_setup_intelliapp from w_response
integer x = 37
integer y = 172
integer width = 4219
integer height = 2044
string title = "Payor/Hospital Setup"
long backcolor = 33551856
uo_facility uo_facility
end type
global w_facility_setup_intelliapp w_facility_setup_intelliapp

type variables

end variables

on w_facility_setup_intelliapp.create
int iCurrent
call super::create
this.uo_facility=create uo_facility
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_facility
end on

on w_facility_setup_intelliapp.destroy
call super::destroy
destroy(this.uo_facility)
end on

event open;call super::open;uo_facility.of_set_parent_window( This )
uo_facility.of_retrieve_detail()
end event

event pfc_postupdate;call super::pfc_postupdate;//integer facid
//
//facid = uo_facility.dw_detail.getitemnumber(1,"facility_id")
////set verif rules for duplicate letters maha 041801
//if uo_facility.dw_detail.getitemnumber(1,"dupeset") = 1 then
//	Update facility_ver_rules
//	set ver_ltr_doc = 1
//	where facility_id = :facid and screen_id in (7,10);
//else 
//	Update facility_ver_rules
//	set ver_ltr_doc = 0
//	where facility_id = :facid and screen_id in (7,10);
//end if
// 
// 
// 
// 
// 
 return 1
end event

type uo_facility from pfc_cst_u_facility_setup_intelliapp within w_facility_setup_intelliapp
integer y = 8
integer width = 4192
integer height = 1948
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_facility.destroy
call pfc_cst_u_facility_setup_intelliapp::destroy
end on

