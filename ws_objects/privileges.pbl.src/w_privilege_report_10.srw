$PBExportHeader$w_privilege_report_10.srw
forward
global type w_privilege_report_10 from w_main
end type
type p_1 from picture within w_privilege_report_10
end type
type cb_close from commandbutton within w_privilege_report_10
end type
type tab_1 from tab within w_privilege_report_10
end type
type tabpage_comp from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_comp
end type
type gb_2 from groupbox within tabpage_comp
end type
type gb_3 from groupbox within tabpage_comp
end type
type dw_clin from u_dw within tabpage_comp
end type
type dw_procd from u_dw within tabpage_comp
end type
type dw_core from u_dw within tabpage_comp
end type
type dw_tv from datawindow within tabpage_comp
end type
type tabpage_comp from userobject within tab_1
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
dw_clin dw_clin
dw_procd dw_procd
dw_core dw_core
dw_tv dw_tv
end type
type tabpage_report from userobject within tab_1
end type
type dw_print from u_dw within tabpage_report
end type
type gb_9 from groupbox within tabpage_report
end type
type gb_6 from groupbox within tabpage_report
end type
type cb_preview from commandbutton within tabpage_report
end type
type cb_print from commandbutton within tabpage_report
end type
type ddlb_report from dropdownlistbox within tabpage_report
end type
type dw_clin_select_preview from datawindow within tabpage_report
end type
type cb_2 from commandbutton within tabpage_report
end type
type tabpage_report from userobject within tab_1
dw_print dw_print
gb_9 gb_9
gb_6 gb_6
cb_preview cb_preview
cb_print cb_print
ddlb_report ddlb_report
dw_clin_select_preview dw_clin_select_preview
cb_2 cb_2
end type
type tab_1 from tab within w_privilege_report_10
tabpage_comp tabpage_comp
tabpage_report tabpage_report
end type
type dw_facility from datawindow within w_privilege_report_10
end type
type cb_run_report from commandbutton within w_privilege_report_10
end type
type cb_printreport from commandbutton within w_privilege_report_10
end type
type dw_stat from datawindow within w_privilege_report_10
end type
type st_2 from statictext within w_privilege_report_10
end type
type st_f from statictext within w_privilege_report_10
end type
end forward

global type w_privilege_report_10 from w_main
integer x = 9
integer y = 4
integer width = 3630
integer height = 2468
string title = "Privilege Report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
p_1 p_1
cb_close cb_close
tab_1 tab_1
dw_facility dw_facility
cb_run_report cb_run_report
cb_printreport cb_printreport
dw_stat dw_stat
st_2 st_2
st_f st_f
end type
global w_privilege_report_10 w_privilege_report_10

type variables
integer il_clicked_column
integer il_width
integer il_height
integer il_x
integer il_y

long il_facility
long il_clin_area_preview
long il_priv_id
end variables

on w_privilege_report_10.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_close=create cb_close
this.tab_1=create tab_1
this.dw_facility=create dw_facility
this.cb_run_report=create cb_run_report
this.cb_printreport=create cb_printreport
this.dw_stat=create dw_stat
this.st_2=create st_2
this.st_f=create st_f
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.dw_facility
this.Control[iCurrent+5]=this.cb_run_report
this.Control[iCurrent+6]=this.cb_printreport
this.Control[iCurrent+7]=this.dw_stat
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_f
end on

on w_privilege_report_10.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.tab_1)
destroy(this.dw_facility)
destroy(this.cb_run_report)
destroy(this.cb_printreport)
destroy(this.dw_stat)
destroy(this.st_2)
destroy(this.st_f)
end on

event closequery;//nothing
end event

type p_1 from picture within w_privilege_report_10
boolean visible = false
integer x = 2569
integer y = 28
integer width = 82
integer height = 64
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_privilege_report_10
integer x = 3255
integer y = 68
integer width = 297
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_privilege_report_10
event create ( )
event destroy ( )
integer x = 9
integer y = 192
integer width = 3616
integer height = 2200
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_comp tabpage_comp
tabpage_report tabpage_report
end type

on tab_1.create
this.tabpage_comp=create tabpage_comp
this.tabpage_report=create tabpage_report
this.Control[]={this.tabpage_comp,&
this.tabpage_report}
end on

on tab_1.destroy
destroy(this.tabpage_comp)
destroy(this.tabpage_report)
end on

event selectionchanged;long ll_facility_id
	
	
//cb_save.triggerevent(clicked!)
//IF oldindex = 1 THEN
//tab_1.tabpage_req.dw_clin_select.reset()
//ll_facility_id = dw_facility.getitemnumber(dw_facility.getrow(),"facility_id")
//tab_1.tabpage_req.dw_clin_select.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_select.retrieve(ll_facility_id)
//end if
//
if newindex = 2 then
	//cb_expand.visible = true
end if
if oldindex = 2 then
	//cb_expand.visible = false
end if

end event

type tabpage_comp from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3579
integer height = 2084
long backcolor = 33551856
string text = "Clinical Area/Departments"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
dw_clin dw_clin
dw_procd dw_procd
dw_core dw_core
dw_tv dw_tv
end type

on tabpage_comp.create
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_clin=create dw_clin
this.dw_procd=create dw_procd
this.dw_core=create dw_core
this.dw_tv=create dw_tv
this.Control[]={this.gb_4,&
this.gb_2,&
this.gb_3,&
this.dw_clin,&
this.dw_procd,&
this.dw_core,&
this.dw_tv}
end on

on tabpage_comp.destroy
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_clin)
destroy(this.dw_procd)
destroy(this.dw_core)
destroy(this.dw_tv)
end on

type gb_4 from groupbox within tabpage_comp
integer x = 1499
integer width = 2080
integer height = 2036
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Procedures and Designations"
end type

type gb_2 from groupbox within tabpage_comp
integer width = 1472
integer height = 1076
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Clinical Areas/Departments"
end type

type gb_3 from groupbox within tabpage_comp
integer y = 1112
integer width = 1477
integer height = 924
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Privilege Section"
end type

type dw_clin from u_dw within tabpage_comp
integer x = 23
integer y = 60
integer width = 1435
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_priv_clinical_area_rpt"
borderstyle borderstyle = stylebox!
end type

event constructor;This.SetRowFocusIndicator( p_1 )
end event

event losefocus;//cb_save.triggerevent(clicked!)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_clin_id
long ll_core_id
real ls_norow

//if no current row disable buttons and retrieve no rows
if dw_clin.getrow() < 1 then
	return

else
ll_clin_id = dw_clin.GetItemNumber ( dw_clin.getrow(), 1 )

dw_core.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 02.10.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Comment out the following script since Retrieve will be also triggered
//$<modification> by Reset().
/*
dw_core.retrieve (ll_clin_id)
dw_core.triggerevent(rowfocuschanged!)
*/
dw_core.reset()
dw_core.retrieve (ll_clin_id)
//---------------------------- APPEON END ----------------------------
end if


end event

event getfocus;Return 0
end event

event pfc_preupdate;call super::pfc_preupdate;//set id
integer i
integer chk = 0
long ll_clin_id
 

if this.getitemnumber(this.rowcount(),"clinical_area_id") = 0 then

	SELECT Max( priv_clinical_area.clinical_area_id )
	INTO :ll_clin_id  
	FROM priv_clinical_area;
	//messagebox("clin number",li_clin_id)
	IF IsNull(ll_clin_id) THEN
		ll_clin_id = 0 
	END IF
	ll_clin_id ++
	
	this.setitem(this.rowcount(),"clinical_area_id",ll_clin_id)
	
end if

return 1
end event

type dw_procd from u_dw within tabpage_comp
integer x = 1513
integer y = 60
integer width = 2053
integer height = 1960
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_priv_core_procd_rpt"
borderstyle borderstyle = stylebox!
end type

event constructor;This.SetRowFocusIndicator( p_1 )
end event

event losefocus;//cb_save.triggerevent(clicked!)
end event

event pfc_preupdate;call super::pfc_preupdate;integer i
integer chk = 0
long ll_procd_id
 

if this.getitemnumber(this.rowcount(),"procd_id") = 0 then

	SELECT Max( priv_core_procd.procd_id )
	INTO :ll_procd_id  
	FROM priv_core_procd;
	//messagebox("number",li_procd_id)
	IF IsNull(ll_procd_id) THEN
		ll_procd_id = 0 
	END IF
	
	ll_procd_id ++
	
	this.setitem(this.rowcount(),"procd_id",ll_procd_id)
	
end if



return 1
end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() > 0 then //maha app100305
	il_priv_id = this.getitemnumber(currentrow,"procd_id")
else
	il_priv_id = 0
end if
end event

event retrieveend;call super::retrieveend;if this.rowcount() > 0 then
	il_priv_id = this.getitemnumber(1,"procd_id")
end if
end event

event doubleclicked;call super::doubleclicked;cb_run_report.triggerevent(clicked!)
end event

type dw_core from u_dw within tabpage_comp
integer x = 27
integer y = 1168
integer width = 1431
integer height = 852
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_priv_core_rpt"
boolean hscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.SetRowFocusIndicator( p_1 )
end event

event itemfocuschanged;call super::itemfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<comment> 02.10.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Comment out the following script since RowFocusChanged
//$<modification> event has already been triggered in PT-01.
/*
dw_core.triggerevent(rowfocuschanged!)
*/
//---------------------------- APPEON END ----------------------------

end event

event losefocus;//cb_save.triggerevent(clicked!)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_clin_id
long ll_core_id
real ls_norow
//if no current row disable buttons and retrieve no rows
if dw_core.getrow() < 1 then //maha app100305
	return
else
	ll_core_id = dw_core.GetItemNumber ( dw_core.getrow(), "priv_core_id" )
	
	dw_procd.settransobject(sqlca)
	dw_procd.retrieve(ll_core_id)
end if

end event

event getfocus;Return 0
end event

event pfc_preupdate;call super::pfc_preupdate;integer i
integer chk = 0
long ll_core_id
 

if this.getitemnumber(this.rowcount(),"priv_core_id") = 0 then

	SELECT Max( priv_core.priv_core_id )
	INTO :ll_core_id  
	FROM priv_core;
	//messagebox("number",li_core_id)
	IF IsNull(ll_core_id) THEN
		ll_core_id = 0 
	END IF
	ll_core_id ++
	
	this.setitem(this.rowcount(),"priv_core_id",ll_core_id)
	
end if



return 1
end event

type dw_tv from datawindow within tabpage_comp
boolean visible = false
integer x = 14
integer y = 28
integer width = 192
integer height = 128
integer taborder = 21
string title = "none"
string dataobject = "d_priv_report_tv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event doubleclicked;if this.getrow() > 0 then //maha app100305
	il_priv_id = this.getitemnumber(this.getrow(),"procd_id")
else
	il_priv_id = 0
end if

cb_run_report.triggerevent(clicked!)
end event

type tabpage_report from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3579
integer height = 2084
long backcolor = 33551856
string text = "Report"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
gb_9 gb_9
gb_6 gb_6
cb_preview cb_preview
cb_print cb_print
ddlb_report ddlb_report
dw_clin_select_preview dw_clin_select_preview
cb_2 cb_2
end type

on tabpage_report.create
this.dw_print=create dw_print
this.gb_9=create gb_9
this.gb_6=create gb_6
this.cb_preview=create cb_preview
this.cb_print=create cb_print
this.ddlb_report=create ddlb_report
this.dw_clin_select_preview=create dw_clin_select_preview
this.cb_2=create cb_2
this.Control[]={this.dw_print,&
this.gb_9,&
this.gb_6,&
this.cb_preview,&
this.cb_print,&
this.ddlb_report,&
this.dw_clin_select_preview,&
this.cb_2}
end on

on tabpage_report.destroy
destroy(this.dw_print)
destroy(this.gb_9)
destroy(this.gb_6)
destroy(this.cb_preview)
destroy(this.cb_print)
destroy(this.ddlb_report)
destroy(this.dw_clin_select_preview)
destroy(this.cb_2)
end on

type dw_print from u_dw within tabpage_report
integer width = 3593
integer height = 2084
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rpt_pracs_granted_for_priv"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

type gb_9 from groupbox within tabpage_report
boolean visible = false
integer x = 1115
integer y = 8
integer width = 1193
integer height = 176
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Select Preview"
end type

type gb_6 from groupbox within tabpage_report
boolean visible = false
integer x = 9
integer y = 8
integer width = 1051
integer height = 172
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Select Clinical Area"
end type

type cb_preview from commandbutton within tabpage_report
boolean visible = false
integer x = 2455
integer y = 60
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Pre&view"
end type

event clicked;long ll_fac_id
long ll_clin_id
long ll_clin[]

ll_fac_id = il_facility
ll_clin_id = il_clin_area_preview
//	messagebox("ll_clin_id",ll_clin_id)

if  isnull(ll_clin_id) or ll_clin_id < 1 then
	messagebox("No data", "Please select a Clinical Area")
	return
end if

if ddlb_report.text = "Clinical Area Privilege List" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_rpt_priv_by_clin_area_by_facil"
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id, ll_clin_id )
	
elseif ddlb_report.text = "Privilege Requirements" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_clin_req"
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
elseif ddlb_report.text = "Privileges Requested w/ headers" then
	//tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h" 
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h_new" //modify by stephen 04.03.2013 -Issues with Privileging -bug 3447
	ll_clin[1] = il_clin_area_preview
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
elseif ddlb_report.text = "Privileges Requested w/ descp." then
	//tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d"
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_new" //modify by stephen 04.03.2013 -Issues with Privileging -bug 3447
	ll_clin[1] = il_clin_area_preview
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id)
elseif ddlb_report.text = "Privilege Recommendations" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_acknowledgement_col"
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
elseif ddlb_report.text = "Complete Privilege Application w/ headers" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_h"
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
elseif ddlb_report.text = "Complete Privilege Application w/ descp." then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_d"
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
	
else
	messagebox("Report Selection", "Please select a report or form to view.")
	return
end if

//	tab_1.tabpage_report.dw_print.settransobject(sqlca)
//	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )

//tab_1.tabpage_report.dw_print.printpreview()


end event

type cb_print from commandbutton within tabpage_report
boolean visible = false
integer x = 3278
integer y = 16
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;if  isnull(il_clin_area_preview) or il_clin_area_preview < 1 then
	messagebox("No data", "Please select a Clinical Area")
	return
end if

cb_preview.triggerevent(clicked!)


tab_1.tabpage_report.dw_print.print()
end event

type ddlb_report from dropdownlistbox within tabpage_report
boolean visible = false
integer x = 1161
integer y = 72
integer width = 1106
integer height = 404
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Clinical Area Privilege List","Privilege Requirements","Privileges Requested w/ headers","Privilege Recommendations","Complete Privilege Application w/ headers","Complete Privilege Application w/ descp.","Privileges Requested w/ descp."}
borderstyle borderstyle = stylelowered!
end type

type dw_clin_select_preview from datawindow within tabpage_report
boolean visible = false
integer x = 32
integer y = 68
integer width = 1001
integer height = 104
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_dddw_clin_area"
boolean border = false
boolean livescroll = true
end type

event constructor;//dw_clin_select.settransobject(sqlca)
////dw_clin_sel.retrieve(il_facil)
//dw_clin_select.InsertRow( 0 )
//
//
//DataWindowChild dwchild
//
//This.GetChild( "clinical_area_description", dwchild )
//
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("il_facil")
//dwchild.InsertRow( 1 )
//dwchild.SetItem( 1, "clinical_area_description", "" )
//dwchild.SetItem( 1, "clinical_area_id", 0 )



//DataWindowChild dwchild


//This.of_SetTransObject(SQLCA)

//This.GetChild( "review_results", dwchild )

//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("approval code")
end event

event itemchanged;


tab_1.tabpage_report.dw_clin_select_preview.accepttext()
il_clin_area_preview = integer(data)








end event

type cb_2 from commandbutton within tabpage_report
boolean visible = false
integer x = 2971
integer y = 60
integer width = 247
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;if  isnull(il_clin_area_preview) or il_clin_area_preview < 1 then
	messagebox("No data", "Please select a Clinical Area")
	return
end if

cb_preview.triggerevent(clicked!)


gnv_dw.of_SaveAs(tab_1.tabpage_report.dw_print)//.saveas() Modify by Evan 05.11.2010
end event

type dw_facility from datawindow within w_privilege_report_10
integer x = 27
integer y = 60
integer width = 955
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dddw_priv_facility"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long i
DataWindowChild dwchild

il_facility = integer(data)
//messagebox("facility", il_facility)
tab_1.tabpage_comp.dw_clin.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 02.10.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Add the following script to make sure that RowFocusChanged will 
//$<modification> always be triggered.
tab_1.tabpage_comp.dw_clin.reset()
tab_1.tabpage_comp.dw_core.reset()
tab_1.tabpage_comp.dw_procd.reset()
//---------------------------- APPEON END ----------------------------

 i = tab_1.tabpage_comp.dw_clin.retrieve(il_facility)
// tab_1.tabpage_comp.dw_tv.retrieve(il_facility)
//tab_1.tabpage_comp.cb_add_clin.enabled = true
//tab_1.tabpage_comp.cb_delete_clin.enabled = true
//tab_1.tabpage_comp.cb_copy_proc.enabled = true
//
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<comment> 02.10.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Comment out the following script dw_clin.Retrieve has already triggered
//$<modification> the RowFocusChanged event.
/*
tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)
*/
//---------------------------- APPEON END ----------------------------
//retrieve clin area select drop downs
if i > 0 then //if added maha 020403 to avoid retrieval request when no clin areas exist for facility

	tab_1.tabpage_report.dw_clin_select_preview.settransobject(sqlca)
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<add> 02.08.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_report.dw_clin_select_preview.retrieve()

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-06
	//$<comment> 02.08.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> Move the following script to PT-07, since InsertRow should be
	//$<modification> executed after the Appeon labels.
	/*
	tab_1.tabpage_report.dw_clin_select_preview.insertrow(1)
	*/
	//---------------------------- APPEON END ----------------------------

	tab_1.tabpage_report.dw_clin_select_preview.GetChild( "clinical_area_description", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve(il_facility)

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-07
	//$<add> 02.08.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> 1)Copy the script from PT-06.
	//$<modification> 2)Add an Appeon Commit Queue Label to reduce client-server interactions. 
	gnv_appeondb.of_commitqueue( )

	tab_1.tabpage_report.dw_clin_select_preview.insertrow(1)

	//---------------------------- APPEON END ----------------------------

else
	
	tab_1.tabpage_report.dw_clin_select_preview.reset()
end if




//\/maha  The following code protects against the retrieval message box when there are no rows.
integer rc1
rc1 = dwchild.rowcount()
//messagebox("rowcount", rc1)
if rc1 = 0 then
	dwchild.insertrow(1)
end if
//\maha

tab_1.tabpage_comp.enabled = true

tab_1.tabpage_report.enabled = true

end event

event constructor;dw_facility.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-07-06 By: Liu Hongxin
//$<reason> Clause Overlap with dwchild.retrieve()
/*
dw_facility.retrieve()
*/
//---------------------------- APPEON END ----------------------------
dw_facility.InsertRow( 1 )

DataWindowChild dwchild

This.GetChild( "facility_name", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
end event

type cb_run_report from commandbutton within w_privilege_report_10
integer x = 2661
integer y = 68
integer width = 329
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;integer i
integer cnt
long ll_stats[]

if il_priv_id < 1 then return

for i = 1 to dw_stat.rowcount()
	if dw_stat.getitemnumber(i,"selected") = 1 then
		cnt++
		ll_stats[cnt] = dw_stat.getitemnumber(i,"lookup_code")
	end if
next
debugbreak()
if cnt = 0 then
	messagebox("Status?","No status selected")
	return
end if

tab_1.tabpage_report.dw_print.settransobject(sqlca)
cnt = tab_1.tabpage_report.dw_print.retrieve(il_priv_id,ll_stats,il_facility)

if cnt = 0 then
	tab_1.tabpage_report.dw_print.insertrow(1)
	tab_1.tabpage_report.dw_print.setitem(1,"v_full_name_full_name", "No Practitoners found.")
	tab_1.tabpage_report.dw_print.setitem(1,"procd_id",il_priv_id)
end if



tab_1.selecttab(2)

end event

type cb_printreport from commandbutton within w_privilege_report_10
integer x = 2999
integer y = 68
integer width = 247
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;tab_1.tabpage_report.dw_print.print()
end event

type dw_stat from datawindow within w_privilege_report_10
integer x = 1801
integer y = 12
integer width = 681
integer height = 244
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_priv_status_select"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;integer i
integer ic

this.settransobject(sqlca)
ic = this.retrieve()

for i = 1 to ic
	if upper(this.getitemstring(i,"custom_1")) = "G" then
		this.setitem(i,"selected",1)
	end if
next
end event

type st_2 from statictext within w_privilege_report_10
integer x = 1312
integer y = 16
integer width = 466
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Status(es)"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_f from statictext within w_privilege_report_10
integer x = 41
integer y = 12
integer width = 562
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Facility"
boolean focusrectangle = false
end type

