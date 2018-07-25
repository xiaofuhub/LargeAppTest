$PBExportHeader$w_batch_prac_select_dyn.srw
forward
global type w_batch_prac_select_dyn from Window
end type
type uo_1 from pfc_cst_u_prac_batch_search_dyn within w_batch_prac_select_dyn
end type
end forward

global type w_batch_prac_select_dyn from Window
int X=219
int Y=288
int Width=3319
int Height=2040
boolean TitleBar=true
string Title="Practitioner Batch Search"
long BackColor=80269524
boolean ControlMenu=true
WindowType WindowType=response!
uo_1 uo_1
end type
global w_batch_prac_select_dyn w_batch_prac_select_dyn

type variables
string is_openfor
end variables

on w_batch_prac_select_dyn.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_batch_prac_select_dyn.destroy
destroy(this.uo_1)
end on

event open;integer li_fac_pos
string ls_fac
string ls_open
datawindowchild dwchild

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

uo_1.dw_filter_list.settransobject(sqlca)
uo_1.dw_filter_list.retrieve()
uo_1.dw_filter_list.insertrow(1)





ls_open = MidA(is_openfor,1,1)
uo_1.is_openedfor = ls_open
// A = intelliapp printing
// R = reports or correspondence
// E = Export Painter
// P = Custom profile run from reports
//messagebox("",ls_open)
if ls_open = "A" then
	uo_1.dw_app.visible = true
	uo_1.st_app.visible = true
	uo_1.cbx_facility.enabled = false
	uo_1.cbx_status.enabled = false
elseif ls_open = "E" then
	uo_1.dw_app.visible = false
	uo_1.st_app.visible = false
	uo_1.cb_return.text = "Return with Syntax"
elseif ls_open = "P" then
	uo_1.dw_app.visible = false
	uo_1.st_app.visible = false
else //"R"
	uo_1.dw_app.visible = false
	uo_1.st_app.visible = false	
end if



end event

type uo_1 from pfc_cst_u_prac_batch_search_dyn within w_batch_prac_select_dyn
int X=55
int Y=40
int TabOrder=10
end type

on uo_1.destroy
call pfc_cst_u_prac_batch_search_dyn::destroy
end on

