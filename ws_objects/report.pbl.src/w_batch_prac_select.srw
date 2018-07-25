$PBExportHeader$w_batch_prac_select.srw
forward
global type w_batch_prac_select from window
end type
type uo_1 from pfc_cst_u_prac_batch_search_new within w_batch_prac_select
end type
end forward

global type w_batch_prac_select from window
integer x = 219
integer y = 288
integer width = 3255
integer height = 2428
boolean titlebar = true
string title = "Practitioner Batch Search"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32891346
uo_1 uo_1
end type
global w_batch_prac_select w_batch_prac_select

type variables
string is_openfor
end variables

on w_batch_prac_select.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_batch_prac_select.destroy
destroy(this.uo_1)
end on

event open;integer li_fac_pos
string ls_fac
string ls_open

is_openfor = message.stringparm
//messagebox("is_openfor",is_openfor)
li_fac_pos = PosA(is_openfor,"*",1)
//check to see if facility is being passed  
if li_fac_pos > 0 then
	if isnumber(MidA(is_openfor,li_fac_pos + 1)) then
		uo_1.il_facility_id = integer(MidA(is_openfor,li_fac_pos + 1))
		uo_1.cbx_facility.enabled = false
		uo_1.cbx_status.enabled = false
		select facility_name into :ls_fac from facility where facility_id = :uo_1.il_facility_id;
		uo_1.st_facility.text = ls_fac
		uo_1.ib_facility = true
	end if
else
	uo_1.ib_facility = false
end if

uo_1.dw_batchlist.settransobject(sqlca)
uo_1.dw_batchlist.retrieve()
uo_1.dw_batchlist.insertrow(1)

ls_open = MidA(is_openfor,1,1)
uo_1.is_openedfor = ls_open
// A = intelliapp printing
// R = reports or correspondence
// E = Export Painter
// P = Custom profile run from reports
// B = Batch list
//messagebox("",ls_open)
if ls_open = "A" then
	uo_1.dw_app.visible = true
	//uo_1.st_app.visible = true
	uo_1.cbx_facility.enabled = false
	uo_1.cbx_status.enabled = false
elseif ls_open = "E" then
	//uo_1.dw_app.visible = false
	//uo_1.st_app.visible = false
	//---------Begin Modified by (Appeon)Eugene 06.29.2013 for V141 ISG-CLX--------
	//$Reason:This window object may have abandoned and unused，it is a redundant object, may be removed in the future
	  /*
		uo_1.cb_return.text = "Return with Syntax"	
	  */
	 uo_1.cb_1.text = "Return with Syntax"
	//---------End Modfiied ------------------------------------------------------------------	
	uo_1.dw_batchlist.enabled = false
	uo_1.cb_batchedit.enabled = false
//	uo_1.
//elseif ls_open = "P" then
	//uo_1.dw_app.visible = false
	//uo_1.st_app.visible = false
else //"R,P,B"
//	uo_1.dw_app.visible = false
//	uo_1.st_app.visible = false	
end if



end event

type uo_1 from pfc_cst_u_prac_batch_search_new within w_batch_prac_select
integer taborder = 10
end type

on uo_1.destroy
call pfc_cst_u_prac_batch_search_new::destroy
end on

