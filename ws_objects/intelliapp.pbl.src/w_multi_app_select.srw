$PBExportHeader$w_multi_app_select.srw
forward
global type w_multi_app_select from w_popup
end type
type uo_1 from pfc_cst_u_multi_app_select within w_multi_app_select
end type
end forward

global type w_multi_app_select from w_popup
integer x = 14
integer y = 240
integer width = 4489
integer height = 1952
string title = "Select Applications"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
uo_1 uo_1
end type
global w_multi_app_select w_multi_app_select

type variables


end variables

on w_multi_app_select.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_multi_app_select.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;uo_1.iw_win2 = This
uo_1.il_prac_id = message.doubleparm

if gs_cust_type = "I" then
	uo_1.cb_dept.visible = false
end if
//uo_1.dw_select.object.modify("at_t.visible = false")
uo_1.dw_select.modify("datawindow.apptmnt_type.visible='false'")
uo_1.dw_select.modify("datawindow.apptmnt_type.color=255")
//uo_1.dw_select.object.apptmnt_type.visible = false
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

//Start Code Change ----06.13.2016 #V152 maha
CHOOSE CASE gi_intelliapp_type
	CASE 0, 3 //hide the address cbox if 1 or 2 level
		uo_1.cbx_addr.visible = false
		uo_1.cbx_addr.checked = false
END CHOOSE
//End Code Change ----06.13.2016
end event

event closequery;return 0
end event

type uo_1 from pfc_cst_u_multi_app_select within w_multi_app_select
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call pfc_cst_u_multi_app_select::destroy
end on

