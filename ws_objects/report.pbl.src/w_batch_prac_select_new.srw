$PBExportHeader$w_batch_prac_select_new.srw
forward
global type w_batch_prac_select_new from window
end type
type uo_1 from pfc_cst_u_prac_batch_search_new within w_batch_prac_select_new
end type
end forward

global type w_batch_prac_select_new from window
integer x = 201
integer y = 112
integer width = 3250
integer height = 2428
boolean titlebar = true
string title = "IntelliBatch"
windowtype windowtype = response!
long backcolor = 33551856
uo_1 uo_1
end type
global w_batch_prac_select_new w_batch_prac_select_new

type variables
string is_openfor
integer ii_close = 0
end variables

on w_batch_prac_select_new.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_batch_prac_select_new.destroy
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
// R = reports 
//     or correspondence
//     or meetings
// E = Export Painter
// P = Custom profile run from reports
// B = Batch list
//G = Group Add address
//messagebox("",ls_open)
uo_1.cbx_primary_only.visible = false
if ls_open = "A" then //app printing
	uo_1.dw_app.visible = true
	//uo_1.st_app.visible = true
	uo_1.cbx_facility.enabled = false
	uo_1.cbx_status.enabled = false
	//uo_1.cb_batchup.enabled = false //removed 051205 maha
	//uo_1.cb_batchedit.enabled = false //removed 051205 maha
	uo_1.cb_batchdelete.enabled = false
	//uo_1.dw_batchlist.enabled = false //removed 051205 maha
elseif ls_open = "E" then
	uo_1.dw_app.enabled = false
	//uo_1.st_app.visible = false
	uo_1.cb_1.text = "Return with Syntax"
//	uo_1.dw_batchlist.enabled = false  //Start Code Change ----12.17.2007 #V8 maha
	uo_1.cb_batchedit.enabled = false
//	uo_1.
elseif ls_open = "B" then
//	uo_1.dw_app.visible = false   //Start Code Change ----07.10.2014 #V14.2 maha - removed
//	uo_1.gb_3.visible = false  //Start Code Change ----03.25.2008 #V8 maha
	uo_1.cb_close.text = "Close"
//Start Code Change ----09.02.2009 #V92 maha	 - added to correct for bug caused by new functionality
elseif ls_open = "G" then //group address add
	uo_1.dw_prac_list.dataobject = "d_prac_id_name"
	uo_1.dw_prac_list.settransobject(sqlca)
	uo_1.dw_app.enabled = false
//End Code Change---09.02.2009
else //"R,P"
	uo_1.dw_app.enabled = false
//	uo_1.st_app.visible = false	
end if

//Start Code Change ----03.01.2010 #V10 maha - added security from batch select buttons
//if w_mdi.of_security_access(2000) = 0 then   //Start Code Change ----05.26.2017 #V154 maha -  moved to the user object
uo_1.of_set_security( 0)
this.height= uo_1.height + 150
//end if
//End Code Change---03.01.2010

end event

event closequery;//if ii_close = 0 then
//	return 1
//else
//	return 0
//end if


end event

type uo_1 from pfc_cst_u_prac_batch_search_new within w_batch_prac_select_new
integer x = 9
integer y = 8
integer taborder = 10
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_prac_batch_search_new::destroy
end on

