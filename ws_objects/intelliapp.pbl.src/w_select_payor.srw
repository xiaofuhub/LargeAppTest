$PBExportHeader$w_select_payor.srw
forward
global type w_select_payor from w_popup
end type
type uo_1 from pfc_cst_u_multi_app_select within w_select_payor
end type
end forward

global type w_select_payor from w_popup
integer x = 14
integer y = 240
integer width = 4411
integer height = 2700
string title = "Select Applications"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
uo_1 uo_1
end type
global w_select_payor w_select_payor

type variables


end variables

on w_select_payor.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_select_payor.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;

//CHOOSE CASE gi_intelliapp_type
//		//SINGLE GROUP
//	CASE 0
//		uo_1.dw_app_data.Modify( "parent_facility_t.text = 'Payor/Hospital'" )		
//		//MULTI SITE GROUP
//	CASE 1
//		uo_1.dw_app_data.Modify( "parent_facility_t.text = 'Group'" )		
//		//BILLING COMPANY
//	CASE 2
//		uo_1.dw_app_data.Modify( "parent_facility_t.text = 'Client'" )		
//END CHOOSE
//
//
end event

type uo_1 from pfc_cst_u_multi_app_select within w_select_payor
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call pfc_cst_u_multi_app_select::destroy
end on

