$PBExportHeader$w_privilege_adjustments.srw
forward
global type w_privilege_adjustments from w_main
end type
type gb_1 from groupbox within w_privilege_adjustments
end type
type cb_close from commandbutton within w_privilege_adjustments
end type
type cb_expand from commandbutton within w_privilege_adjustments
end type
type tab_1 from tab within w_privilege_adjustments
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
type cb_add_clin from commandbutton within tabpage_comp
end type
type cb_delete_clin from commandbutton within tabpage_comp
end type
type dw_core from u_dw within tabpage_comp
end type
type cb_add_core from commandbutton within tabpage_comp
end type
type cb_delete_core from commandbutton within tabpage_comp
end type
type cb_add_procd from commandbutton within tabpage_comp
end type
type cb_delete_procd from commandbutton within tabpage_comp
end type
type dw_copy from datawindow within tabpage_comp
end type
type cb_copy_proc from commandbutton within tabpage_comp
end type
type tabpage_comp from userobject within tab_1
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
dw_clin dw_clin
dw_procd dw_procd
cb_add_clin cb_add_clin
cb_delete_clin cb_delete_clin
dw_core dw_core
cb_add_core cb_add_core
cb_delete_core cb_delete_core
cb_add_procd cb_add_procd
cb_delete_procd cb_delete_procd
dw_copy dw_copy
cb_copy_proc cb_copy_proc
end type
type tabpage_req from userobject within tab_1
end type
type gb_7 from groupbox within tabpage_req
end type
type gb_5 from groupbox within tabpage_req
end type
type dw_clin_req from u_dw within tabpage_req
end type
type dw_clin_req2 from u_dw within tabpage_req
end type
type dw_clin_req3 from u_dw within tabpage_req
end type
type cb_reqcopy from commandbutton within tabpage_req
end type
type dw_copy1 from datawindow within tabpage_req
end type
type dw_copy3 from datawindow within tabpage_req
end type
type dw_copy2 from datawindow within tabpage_req
end type
type cb_copyclin from commandbutton within tabpage_req
end type
type dw_clin_select from datawindow within tabpage_req
end type
type tabpage_req from userobject within tab_1
gb_7 gb_7
gb_5 gb_5
dw_clin_req dw_clin_req
dw_clin_req2 dw_clin_req2
dw_clin_req3 dw_clin_req3
cb_reqcopy cb_reqcopy
dw_copy1 dw_copy1
dw_copy3 dw_copy3
dw_copy2 dw_copy2
cb_copyclin cb_copyclin
dw_clin_select dw_clin_select
end type
type tabpage_acknow from userobject within tab_1
end type
type dw_acknow from u_dw within tabpage_acknow
end type
type st_1 from statictext within tabpage_acknow
end type
type tabpage_acknow from userobject within tab_1
dw_acknow dw_acknow
st_1 st_1
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
type tabpage_report from userobject within tab_1
dw_print dw_print
gb_9 gb_9
gb_6 gb_6
cb_preview cb_preview
cb_print cb_print
ddlb_report ddlb_report
dw_clin_select_preview dw_clin_select_preview
end type
type tab_1 from tab within w_privilege_adjustments
tabpage_comp tabpage_comp
tabpage_req tabpage_req
tabpage_acknow tabpage_acknow
tabpage_report tabpage_report
end type
type dw_facility from datawindow within w_privilege_adjustments
end type
type cb_save from commandbutton within w_privilege_adjustments
end type
type cb_view from commandbutton within w_privilege_adjustments
end type
type cb_print_clin from commandbutton within w_privilege_adjustments
end type
type cb_1 from commandbutton within w_privilege_adjustments
end type
end forward

global type w_privilege_adjustments from w_main
integer x = 9
integer y = 4
integer width = 3621
integer height = 2292
string title = "Privilege Painter"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
gb_1 gb_1
cb_close cb_close
cb_expand cb_expand
tab_1 tab_1
dw_facility dw_facility
cb_save cb_save
cb_view cb_view
cb_print_clin cb_print_clin
cb_1 cb_1
end type
global w_privilege_adjustments w_privilege_adjustments

type variables
integer il_clicked_column
integer il_width
integer il_height
integer il_x
integer il_y

long il_facility
long il_clin_area_preview
end variables

on w_privilege_adjustments.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_close=create cb_close
this.cb_expand=create cb_expand
this.tab_1=create tab_1
this.dw_facility=create dw_facility
this.cb_save=create cb_save
this.cb_view=create cb_view
this.cb_print_clin=create cb_print_clin
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_expand
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.dw_facility
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_view
this.Control[iCurrent+8]=this.cb_print_clin
this.Control[iCurrent+9]=this.cb_1
end on

on w_privilege_adjustments.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_close)
destroy(this.cb_expand)
destroy(this.tab_1)
destroy(this.dw_facility)
destroy(this.cb_save)
destroy(this.cb_view)
destroy(this.cb_print_clin)
destroy(this.cb_1)
end on

event open;call super::open;
tab_1.tabpage_comp.cb_add_clin.enabled = false
tab_1.tabpage_comp.cb_add_core.enabled = false
tab_1.tabpage_comp.cb_add_procd.enabled = false
tab_1.tabpage_comp.cb_delete_clin.enabled =false
tab_1.tabpage_comp.cb_delete_core.enabled = false
tab_1.tabpage_comp.cb_delete_procd.enabled = false
tab_1.tabpage_comp.cb_copy_proc.enabled = false

cb_expand.visible = false


tab_1.tabpage_comp.enabled = false
tab_1.tabpage_acknow.enabled = false
tab_1.tabpage_report.enabled = false
tab_1.tabpage_req.enabled = false




end event

type gb_1 from groupbox within w_privilege_adjustments
integer x = 9
integer y = 12
integer width = 1019
integer height = 172
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Template"
end type

type cb_close from commandbutton within w_privilege_adjustments
integer x = 3278
integer y = 68
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
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_expand from commandbutton within w_privilege_adjustments
boolean visible = false
integer x = 832
integer y = 2200
integer width = 247
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Expand"
end type

event clicked;
string ls_col

if tab_1.tabpage_req.dw_clin_req2.getrow() < 1 then
	return
end if
//change button face
if this.text = "Normal" then
	this.text = "Expand"	
	return
end if

if this.text = "Expand" then
	this.text = "Normal"

	

if il_clicked_column = 2 then
//*store current settings
il_width = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.width) 
il_height = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.height)
il_x = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.x)
il_y = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.y)
//*increase column size
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.width = 4000
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.height = 2000
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.x = 18
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.y = 84
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.bringtofront = true
//*if tab1.tabpage_req.dw_clin_req has focus then
ls_col = tab_1.tabpage_req.dw_clin_req.getcolumnname()
//messagebox("",il_width)
//messagebox("",il_height)
//messagebox("",il_x )
//messagebox("",il_y)
end if
//tab_1.tabpage_req.dw_clin_req.object.ls_col.width = 540
//tab_1.tabpage_req.dw_clin_req.object.getcolumnname().height = 1884
//tab_1.tabpage_req.dw_clin_req.object.getcolumnname().x = 14
//tab_1.tabpage_req.dw_clin_req.object.getcolumnname().y = 164
	//dw_control.GetColumn ( )
	//dw_control.Object.objectname.Width
	//dw_control.GetColumnName ( )
	
	
end if	
	return
	
	

	
	
end event

type tab_1 from tab within w_privilege_adjustments
event create ( )
event destroy ( )
integer y = 208
integer width = 3675
integer height = 1972
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
alignment alignment = right!
integer selectedtab = 1
tabpage_comp tabpage_comp
tabpage_req tabpage_req
tabpage_acknow tabpage_acknow
tabpage_report tabpage_report
end type

on tab_1.create
this.tabpage_comp=create tabpage_comp
this.tabpage_req=create tabpage_req
this.tabpage_acknow=create tabpage_acknow
this.tabpage_report=create tabpage_report
this.Control[]={this.tabpage_comp,&
this.tabpage_req,&
this.tabpage_acknow,&
this.tabpage_report}
end on

on tab_1.destroy
destroy(this.tabpage_comp)
destroy(this.tabpage_req)
destroy(this.tabpage_acknow)
destroy(this.tabpage_report)
end on

event selectionchanged;long ll_facility_id
	
	
cb_save.triggerevent(clicked!)
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
integer width = 3639
integer height = 1856
long backcolor = 32891346
string text = "Clinical Area/Departments"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
dw_clin dw_clin
dw_procd dw_procd
cb_add_clin cb_add_clin
cb_delete_clin cb_delete_clin
dw_core dw_core
cb_add_core cb_add_core
cb_delete_core cb_delete_core
cb_add_procd cb_add_procd
cb_delete_procd cb_delete_procd
dw_copy dw_copy
cb_copy_proc cb_copy_proc
end type

on tabpage_comp.create
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_clin=create dw_clin
this.dw_procd=create dw_procd
this.cb_add_clin=create cb_add_clin
this.cb_delete_clin=create cb_delete_clin
this.dw_core=create dw_core
this.cb_add_core=create cb_add_core
this.cb_delete_core=create cb_delete_core
this.cb_add_procd=create cb_add_procd
this.cb_delete_procd=create cb_delete_procd
this.dw_copy=create dw_copy
this.cb_copy_proc=create cb_copy_proc
this.Control[]={this.gb_4,&
this.gb_2,&
this.gb_3,&
this.dw_clin,&
this.dw_procd,&
this.cb_add_clin,&
this.cb_delete_clin,&
this.dw_core,&
this.cb_add_core,&
this.cb_delete_core,&
this.cb_add_procd,&
this.cb_delete_procd,&
this.dw_copy,&
this.cb_copy_proc}
end on

on tabpage_comp.destroy
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_clin)
destroy(this.dw_procd)
destroy(this.cb_add_clin)
destroy(this.cb_delete_clin)
destroy(this.dw_core)
destroy(this.cb_add_core)
destroy(this.cb_delete_core)
destroy(this.cb_add_procd)
destroy(this.cb_delete_procd)
destroy(this.dw_copy)
destroy(this.cb_copy_proc)
end on

type gb_4 from groupbox within tabpage_comp
integer x = 9
integer y = 764
integer width = 3506
integer height = 980
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Procedures and Designations"
end type

type gb_2 from groupbox within tabpage_comp
integer width = 1888
integer height = 636
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Clinical Areas/Departments"
end type

type gb_3 from groupbox within tabpage_comp
integer x = 1911
integer y = 12
integer width = 1664
integer height = 636
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Privilege Section"
end type

type dw_clin from u_dw within tabpage_comp
integer x = 27
integer y = 60
integer width = 1833
integer height = 560
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_priv_clinical_area_ids_adj"
end type

event constructor;This.SetRowFocusIndicator( Hand! )
end event

event losefocus;cb_save.triggerevent(clicked!)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_clin_id
long ll_core_id
real ls_norow

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add a variable to record the current row number dw_core.
//$<modification> The row number will be used by the script in PT-02.
Long ll_currentrow
ll_currentrow = dw_core.getrow()
//---------------------------- APPEON END ----------------------------

//if no current row disable buttons and retrieve no rows
if dw_clin.getrow() < 1 then
	ls_norow  = .5
	dw_core.settransobject(sqlca)
dw_core.retrieve(ls_norow)

cb_add_core.enabled = false
cb_delete_core.enabled = false


else
ll_clin_id = dw_clin.GetItemNumber ( dw_clin.getrow(), 1 )

dw_core.settransobject(sqlca)
dw_core.retrieve (ll_clin_id)

cb_add_core.enabled = true
cb_delete_core.enabled = true
end if


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 02.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Copy the script from PT-03 since RowFocusChanged event should
//$<modification> be triggered after Retrieve.
//$<modification> 2)Add the condition to make sure that the RowFocusChanged event
//$<modification> will always be triggered after Retrieve.
//$<modification> Refer to PT-01/03 for more information.
/*
dw_core.triggerevent(rowfocuschanged!)
*/
IF ll_currentrow = 1 THEN
	dw_core.triggerevent(rowfocuschanged!)
END IF
//---------------------------- APPEON END ----------------------------

//
end event

event getfocus;Return 0
end event

type dw_procd from u_dw within tabpage_comp
integer x = 41
integer y = 820
integer width = 3424
integer height = 904
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_priv_core_procd_adj"
end type

event constructor;This.SetRowFocusIndicator( Hand! )
end event

event losefocus;cb_save.triggerevent(clicked!)
end event

type cb_add_clin from commandbutton within tabpage_comp
integer x = 32
integer y = 656
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
string text = "Add"
end type

event clicked;Integer li_clin_id
Integer li_facility_id
long ll_row

cb_save.triggerevent(clicked!)

if dw_facility.getrow() < 1 then
	messagebox("Error", "Before you can add a Clinical Area, you must first select a Facility.")
	return
end if

//dw_clin.Reset()
ll_row = tab_1.tabpage_comp.dw_clin.InsertRow(0)
tab_1.tabpage_comp.dw_clin.scrolltoRow(ll_row)
SELECT Max( priv_clinical_area.clinical_area_id )
INTO :li_clin_id  
FROM priv_clinical_area;
//messagebox("clin number",li_clin_id)
IF IsNull(li_clin_id) THEN
	li_clin_id = 0 
END IF

li_clin_id ++
//messagebox("clin number",li_clin_id)
//li_facility_id = dw_facility.getitemnumber(dw_facility.getrow(),"facility_id")
//messagebox("facil number",il_facility)
tab_1.tabpage_comp.dw_clin.SetItem(ll_row, "clinical_area_id", li_clin_id )
tab_1.tabpage_comp.dw_clin.SetItem(ll_row, "facility_id", il_facility )

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.20.2014
//<$>reason:BugL093002 of IntelliCredApp V14.2 History Issues.doc
tab_1.tabpage_comp.dw_clin.SetItem(ll_row, "priv_clinical_area_clinical_area_code", '' )
tab_1.tabpage_comp.dw_clin.SetItem(ll_row, "priv_clinical_area_clinical_area_descrip", '' )
//------------------- APPEON END -------------------

dw_clin.SetFocus()
tab_1.tabpage_comp.dw_clin.Setcolumn("priv_clinical_area_clinical_area_code")

end event

type cb_delete_clin from commandbutton within tabpage_comp
integer x = 302
integer y = 656
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;Integer li_ans
integer li_error

if dw_core.rowcount() > 0 then
	Messagebox("Foreign key violation","Unable to delete Clinical Area.  Delete Procedures and Sections first.")
	return
end if
li_ans = MessageBox("Delete", "Are you sure you want to delete row?", Question!, YesNo!, 2)

IF li_ans = 1 THEN
		li_error = dw_clin.DeleteRow( 0 )
//		if li_error = -1 then
//			
//			return
//		end if
		dw_clin.Update()
		commit using sqlca;
	
END IF

end event

type dw_core from u_dw within tabpage_comp
integer x = 1934
integer y = 68
integer height = 560
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_priv_core_adj"
end type

event constructor;This.SetRowFocusIndicator( Hand! )
end event

event itemfocuschanged;call super::itemfocuschanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<comment> 02.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to PT-02 since it should be triggered after
//$<modification> Retrieve. 
/*
dw_core.triggerevent(rowfocuschanged!)
*/
//---------------------------- APPEON END ----------------------------

end event

event losefocus;cb_save.triggerevent(clicked!)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_clin_id
long ll_core_id
real ls_norow

//if no current row disable buttons and retrieve no rows
if dw_core.getrow() < 1 then
	ls_norow  = .5
	dw_procd.settransobject(sqlca)
dw_procd.retrieve(ls_norow)

cb_add_procd.enabled = false
cb_delete_procd.enabled = false

else
ll_core_id = dw_core.GetItemNumber ( dw_core.getrow(), "priv_core_id" )

dw_procd.settransobject(sqlca)
dw_procd.retrieve(ll_core_id)

cb_add_procd.enabled = true
cb_delete_procd.enabled = true

end if

end event

event getfocus;Return 0
end event

type cb_add_core from commandbutton within tabpage_comp
integer x = 1975
integer y = 656
integer width = 247
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Long li_clin_id
Integer li_core_id
long ll_row

if dw_clin.getrow() < 1 then
	messagebox("Error", "Before you can add you must first have selected a Facility, and a Clinical Area.")
	return
end if

cb_save.triggerevent(clicked!)
//dw_core.Reset()
ll_row = dw_core.InsertRow(0)
dw_core.scrolltorow(ll_row)
SELECT Max( priv_core.priv_core_id )
INTO :li_core_id  
FROM priv_core;
//messagebox("number",li_core_id)
IF IsNull(li_core_id) THEN
	li_core_id = 0 
END IF


li_core_id ++


li_clin_id = dw_clin.getitemnumber(dw_clin.getrow(),"clinical_area_id")
//messagebox("number",li_clin_id)
dw_core.SetItem(ll_row, "clinical_area_id", li_clin_id )
dw_core.SetItem(ll_row, "priv_core_id", li_core_id )

dw_core.SetFocus()

end event

type cb_delete_core from commandbutton within tabpage_comp
integer x = 2245
integer y = 656
integer width = 247
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;Integer li_ans
integer li_error

if dw_procd.rowcount() > 0 then
	Messagebox("Foreign key violation","Unable to delete Privilege Section.  Delete Procedures first.")
	return
end if

li_ans = MessageBox("Delete", "Are you sure you want to delete row?", Question!, YesNo!, 2)

IF li_ans = 1 THEN
		li_error = dw_core.DeleteRow( 0 )
//		if li_error = -1 then
//			Messagebox("Database Error","Unable to delete Core area.  Delete procedures first.")
//			return
//		end if
		dw_core.Update()
		commit using sqlca;
	
END IF

end event

type cb_add_procd from commandbutton within tabpage_comp
integer x = 37
integer y = 1764
integer width = 247
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Integer li_procd_id
Integer li_core_id
long ll_row

if dw_core.getrow() < 1 then
	messagebox("Error", "Before you can add you must first have selected a Facility, a Clinical Area, and a Priviledge section")
	return
end if

cb_save.triggerevent(clicked!)
//dw_procd.Reset()
ll_row = dw_procd.InsertRow(0)
dw_procd.scrolltorow(ll_row)

SELECT Max( priv_core_procd.procd_id )
INTO :li_procd_id  
FROM priv_core_procd;
//messagebox("number",li_procd_id)
IF IsNull(li_procd_id) THEN
	li_procd_id = 0 
END IF

li_procd_id ++

li_core_id = dw_core.getitemnumber(dw_core.getrow(),"priv_core_id")
//messagebox("number",li_core_id)
dw_procd.SetItem(ll_row, "priv_core_id", li_core_id )
dw_procd.SetItem(ll_row, "procd_id", li_procd_id )

dw_procd.SetFocus()
dw_procd.setcolumn (4)


end event

type cb_delete_procd from commandbutton within tabpage_comp
integer x = 320
integer y = 1764
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
string text = "Delete"
end type

event clicked;Integer li_ans
integer cnt
long procid

li_ans = MessageBox("Delete", "Are you sure you want to delete this Procedure?", Question!, YesNo!, 2)

IF li_ans = 1 THEN
	procid = dw_procd.getitemnumber(dw_procd.getrow(),"procd_id")
	select count(rec_id) into :cnt from pd_priv_list where procd_id = :procid;
	if cnt > 0 then //check for practitioner records
		li_ans = messagebox("Delete",string(cnt) + " practitioners' record(s) are connected to this procedure.~r Do you wish to delete these records?" ,Question!,yesno!,2)
		if li_ans  = 1 then
			delete from pd_priv_list where procd_id = procid;
			dw_procd.DeleteRow( 0 )
			dw_procd.Update()
			commit using sqlca;
		end if
	end if
	
END IF
end event

type dw_copy from datawindow within tabpage_comp
integer x = 965
integer y = 668
integer width = 114
integer height = 56
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_priv_core_procd_copy"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_copy_proc from commandbutton within tabpage_comp
integer x = 923
integer y = 668
integer width = 672
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Clinical Area Pivileges"
end type

event clicked;//messagebox("Under Construction","This function not yet completed")
//this code will copy all privileges in 1 clinical area to a selected facility

integer li_newrow
integer li_clinid
integer li_coreid
integer li_procdid
integer li_corerow
integer li_procdrow
integer li_corecount
integer li_procdcount
integer li_facilid
integer li_coreoldid
integer li_error
string ls_clincode
string ls_corename
string ls_clinname
string ls_procdname
string ls_procddesc

open(w_select_facility)

li_facilid = message.doubleparm
if li_facilid = 0 then return
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 03.28.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
ls_clincode = dw_clin.getitemstring(dw_clin.getrow(),"priv_clinical_area_clinical_area_code")
ls_clinname = dw_clin.getitemstring(dw_clin.getrow(),"priv_clinical_area_clinical_area_descrip")
select max(clinical_area_id)
into: li_clinid
from priv_clinical_area;
li_clinid++
li_newrow = dw_clin.insertrow(0)
dw_clin.setitem(li_newrow,"facility_id",li_facilid)
dw_clin.setitem(li_newrow,"clinical_area_id",li_clinid)
dw_clin.setitem(li_newrow,"priv_clinical_area_clinical_area_code",ls_clincode)
dw_clin.setitem(li_newrow,"priv_clinical_area_clinical_area_descrip",ls_clinname)
li_error = dw_clin.update()
if li_error = -1 then return
//	messagebox("Database Error","Selected Facility already has ~n~r Privileges for this Clinical Area.)

li_corecount = dw_core.rowcount()
	select max(priv_core_id)
		into :li_coreid
		from priv_core;
	select max(procd_id)
		into :li_procdid
		from priv_core_procd;
for li_corerow = 1 to li_corecount
	ls_corename = dw_core.getitemstring(li_corerow,"priv_core_description")
	li_coreoldid = dw_core.getitemnumber(li_corerow,"priv_core_id")
//	select max(priv_core_id)
//	into :li_coreid
//	from priv_core;
	li_coreid++
	li_newrow = dw_core.insertrow(0)
	dw_core.setitem(li_newrow,"priv_core_id",li_coreid)
	dw_core.setitem(li_newrow,"clinical_area_id",li_clinid)
	dw_core.setitem(li_newrow,"priv_core_description",ls_corename)
	dw_core.update()
	
	dw_copy.settransobject(sqlca)
	dw_copy.retrieve(li_coreoldid)
	//messagebox("li_coreid",li_coreid)
	li_procdcount = dw_copy.rowcount()
	//messagebox("li_procdcount",li_procdcount)
	for li_procdrow = 1 to li_procdcount
		ls_procddesc = dw_copy.getitemstring(li_procdrow,"core_procd_description")
		ls_procdname = dw_copy.getitemstring(li_procdrow,"priv_core_procd_procd_name")
//		select max(procd_id)
//		into :li_procdid
//		from priv_core_procd;
		li_procdid++
		li_newrow = dw_procd.insertrow(0)
		dw_procd.setitem(li_newrow,"procd_id",li_procdid)
		dw_procd.setitem(li_newrow,"priv_core_id",li_coreid)
		dw_procd.setitem(li_newrow,"core_procd_description",ls_procddesc)
		dw_procd.setitem(li_newrow,"priv_core_procd_procd_name",ls_procdname)		
		dw_procd.update()
	next
next

tab_1.tabpage_comp.dw_clin.settransobject(sqlca)
tab_1.tabpage_comp.dw_clin.retrieve(il_facility)

tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)
*/
Long ll_clinical_area_id[]
Long li_clincount
Long li_clinrow
Long li_clinoldid
String as_from

DatasTOre lds_clin_copy,lds_core_copy,lds_procd_copy
ll_clinical_area_id[1] = tab_1.tabpage_comp.dw_clin.getitemnumber(tab_1.tabpage_comp.dw_clin.getrow(),1)

lds_clin_copy = Create datasTOre
lds_clin_copy.dataobject = 'd_priv_clinical_area_copy_FORpt'
lds_clin_copy.settransobject( sqlca )

lds_core_copy = Create datasTOre
lds_core_copy.dataobject = 'd_priv_core_copy_FORpt'
lds_core_copy.settransobject( sqlca )

lds_procd_copy = Create datasTOre
lds_procd_copy.dataobject = 'd_priv_core_procd_copy_FORpt'
lds_procd_copy.settransobject( sqlca )

gnv_appeondb.of_startqueue( )
	lds_clin_copy.Retrieve( ll_clinical_area_id )
	lds_core_copy.Retrieve( ll_clinical_area_id )
	lds_procd_copy.Retrieve( ll_clinical_area_id )

	SELECT max(clinical_area_id) INTO :li_clinid FROM priv_clinical_area;
	SELECT max(priv_core_id) INTO :li_coreid FROM priv_core;
	SELECT max(procd_id)	INTO :li_procdid	FROM priv_core_procd;
gnv_appeondb.of_commitqueue( )

li_clincount = lds_clin_copy.rowcount( )
FOR li_clinrow = 1 TO li_clincount
	li_clinoldid = lds_clin_copy.getitemnumber(li_clinrow,"clinical_area_id")
	
	li_clinid++
	lds_clin_copy.setitem(li_clinrow,"facility_id",li_facilid)
	lds_clin_copy.setitem(li_clinrow,"clinical_area_id",li_clinid)
	lds_clin_copy.SetItemStatus(li_clinrow, 0, Primary!, NewModIFied!)

	lds_core_copy.SetFilter("clinical_area_id = " + String(li_clinoldid))
	lds_core_copy.Filter()
	li_corecount = lds_core_copy.rowcount()
	FOR li_corerow = 1 TO li_corecount
		li_coreoldid = lds_core_copy.getitemnumber(li_corerow,"priv_core_id")
		
		li_coreid++
		lds_core_copy.setitem(li_corerow,"priv_core_id",li_coreid)
		lds_core_copy.setitem(li_corerow,"clinical_area_id",li_clinid)
		lds_core_copy.SetItemStatus(li_corerow, 0, Primary!, NewModIFied!)
		
		lds_procd_copy.SetFilter("priv_core_id = " + String(li_coreoldid))
		lds_procd_copy.Filter()
		li_procdcount = lds_procd_copy.rowcount()
		FOR li_procdrow = 1 TO li_procdcount
			li_procdid++
			lds_procd_copy.setitem(li_procdrow,"procd_id",li_procdid)
			lds_procd_copy.setitem(li_procdrow,"priv_core_id",li_coreid)
			lds_procd_copy.SetItemStatus(li_procdrow, 0, Primary!, NewModIFied!)
		NEXT
	NEXT
NEXT

gnv_appeondb.of_update( lds_clin_copy, lds_core_copy, lds_procd_copy)

IF il_facility = li_facilid THEN
	li_clinrow = tab_1.tabpage_comp.dw_clin.Getrow()
	tab_1.tabpage_comp.dw_clin.settransobject(sqlca)
	tab_1.tabpage_comp.dw_clin.retrieve(il_facility)
	IF li_clinrow = 1 THEN
		tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)
	END IF
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_clin_copy) then Destroy lds_clin_copy
if IsValid(lds_core_copy) then Destroy lds_core_copy
if IsValid(lds_procd_copy) then Destroy lds_procd_copy
//---------------------------- APPEON END ----------------------------

RETURN 1
//---------------------------- APPEON END ----------------------------
end event

type tabpage_req from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3639
integer height = 1856
long backcolor = 79741120
string text = "Requirements"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_7 gb_7
gb_5 gb_5
dw_clin_req dw_clin_req
dw_clin_req2 dw_clin_req2
dw_clin_req3 dw_clin_req3
cb_reqcopy cb_reqcopy
dw_copy1 dw_copy1
dw_copy3 dw_copy3
dw_copy2 dw_copy2
cb_copyclin cb_copyclin
dw_clin_select dw_clin_select
end type

on tabpage_req.create
this.gb_7=create gb_7
this.gb_5=create gb_5
this.dw_clin_req=create dw_clin_req
this.dw_clin_req2=create dw_clin_req2
this.dw_clin_req3=create dw_clin_req3
this.cb_reqcopy=create cb_reqcopy
this.dw_copy1=create dw_copy1
this.dw_copy3=create dw_copy3
this.dw_copy2=create dw_copy2
this.cb_copyclin=create cb_copyclin
this.dw_clin_select=create dw_clin_select
this.Control[]={this.gb_7,&
this.gb_5,&
this.dw_clin_req,&
this.dw_clin_req2,&
this.dw_clin_req3,&
this.cb_reqcopy,&
this.dw_copy1,&
this.dw_copy3,&
this.dw_copy2,&
this.cb_copyclin,&
this.dw_clin_select}
end on

on tabpage_req.destroy
destroy(this.gb_7)
destroy(this.gb_5)
destroy(this.dw_clin_req)
destroy(this.dw_clin_req2)
destroy(this.dw_clin_req3)
destroy(this.cb_reqcopy)
destroy(this.dw_copy1)
destroy(this.dw_copy3)
destroy(this.dw_copy2)
destroy(this.cb_copyclin)
destroy(this.dw_clin_select)
end on

type gb_7 from groupbox within tabpage_req
integer x = 9
integer y = 4
integer width = 1047
integer height = 172
integer taborder = 20
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

type gb_5 from groupbox within tabpage_req
integer y = 188
integer width = 3483
integer height = 1688
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 79741120
string text = "Privilege Requirements"
end type

type dw_clin_req from u_dw within tabpage_req
integer x = 46
integer y = 252
integer width = 3424
integer height = 724
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_clin_req"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;il_clicked_column = this.getclickedcolumn() 
//messagebox("col no",il_clicked_column)
end event

event losefocus;cb_save.triggerevent(clicked!)

end event

event getfocus;Return 0
end event

type dw_clin_req2 from u_dw within tabpage_req
integer x = 46
integer y = 940
integer width = 3406
integer height = 476
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_clin_req2"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;il_clicked_column = this.getclickedcolumn() + 10
//messagebox("col no",il_clicked_column)
end event

event losefocus;cb_save.triggerevent(clicked!)
end event

event getfocus;call super::getfocus;Return 0
end event

type dw_clin_req3 from u_dw within tabpage_req
integer x = 50
integer y = 1404
integer width = 3406
integer height = 460
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_clin_req3"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;il_clicked_column = this.getclickedcolumn() + 20
//messagebox("col no",il_clicked_column)
end event

event losefocus;cb_save.triggerevent(clicked!)
end event

event getfocus;call super::getfocus;Return 0
end event

type cb_reqcopy from commandbutton within tabpage_req
integer x = 1979
integer y = 64
integer width = 727
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Copy Req. to another Facility"
end type

event clicked;string ls_clin
integer li_clin
integer li_clin_new
integer li_facil
string li_priv_qual
string li_req_pre_exp
string li_spec_pro
string li_obs
string li_re_req
string li_c1
string li_c2
integer m1


li_clin = integer(dw_clin_select.getitemstring(1,"clinical_area_description"))
select clinical_area_description
into :ls_clin
from priv_clinical_area
where clinical_area_id = :li_clin; 
li_facil = dw_clin_req.getitemnumber(1,"facility_id")
//messagebox("ls_clin",ls_clin)

li_priv_qual = dw_clin_req.getitemstring(1,"priv_qualifications")
li_req_pre_exp = dw_clin_req.getitemstring(1,"req_pre_exp")
li_spec_pro = dw_clin_req.getitemstring(1,"spec_procd")
li_obs = dw_clin_req2.getitemstring(1,"priv_clinical_area2_observations")
li_re_req = dw_clin_req2.getitemstring(1,"priv_clinical_area2_reappoint_req")
li_c1 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom1")
li_c2 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom2")

open(w_select_facility)

li_facil = message.doubleparm
//messagebox("li_facil",li_facil)
if li_facil = 0 then return

select clinical_area_id
into :li_clin_new
from priv_clinical_area
where clinical_area_description = :ls_clin and facility_id = :li_facil;
//messagebox("li_clin_new",li_clin_new)
if li_clin = li_clin_new then
	Messagebox("Selection Error","You have selected the same Facility to copy to. ~r~n Please select a different Facility.")
return 
end if
if li_clin_new = 0 then
	messagebox("Selection Error","The Facility you have selected does not have the Clinical Area " + ls_clin + " to copy into. ~r~n It must be added to the Facility from the Clinical Area tab before you can copy Requirements.")
return
end if
dw_copy1.settransobject(sqlca)
dw_copy1.retrieve(li_clin_new)
dw_copy2.settransobject(sqlca)
dw_copy2.retrieve(li_clin_new)
dw_copy3.settransobject(sqlca)
dw_copy3.retrieve(li_clin_new)


dw_copy1.setitem(1,"priv_qualifications",li_priv_qual)
dw_copy1.setitem(1,"req_pre_exp",li_req_pre_exp)
dw_copy1.setitem(1,"spec_procd",li_spec_pro)
dw_copy2.setitem(1,"priv_clinical_area2_observations",li_obs)
//messagebox("li_re_req",li_re_req)
dw_copy2.setitem(1,"priv_clinical_area2_reappoint_req",li_re_req)
dw_copy3.setitem(1,"priv_clinical_area_3_custom1",li_c1)
dw_copy3.setitem(1,"priv_clinical_area_3_custom2",li_c2)

messagebox("Copy Complete","Click Save to save changes.")


end event

type dw_copy1 from datawindow within tabpage_req
integer x = 1298
integer y = 80
integer width = 110
integer height = 56
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_priv_clin_req"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_copy3 from datawindow within tabpage_req
integer x = 1573
integer y = 72
integer width = 64
integer height = 64
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_priv_clin_req3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_copy2 from datawindow within tabpage_req
integer x = 1454
integer y = 68
integer width = 101
integer height = 76
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_priv_clin_req2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_copyclin from commandbutton within tabpage_req
integer x = 1102
integer y = 64
integer width = 850
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Copy Req. to another Clinical Area"
end type

event clicked;integer li_clin
integer li_clin_new
integer li_facil
string li_priv_qual
string li_req_pre_exp
string li_spec_pro
string li_obs
string li_re_req
string li_c1
string li_c2
integer m1

li_clin = integer(dw_clin_select.getitemstring(1,"clinical_area_description"))
li_facil = dw_clin_req.getitemnumber(1,"facility_id")
//messagebox("li_facil",li_facil)
li_priv_qual = dw_clin_req.getitemstring(1,"priv_qualifications")
li_req_pre_exp = dw_clin_req.getitemstring(1,"req_pre_exp")
li_spec_pro = dw_clin_req.getitemstring(1,"spec_procd")
li_obs = dw_clin_req2.getitemstring(1,"priv_clinical_area2_observations")
li_re_req = dw_clin_req2.getitemstring(1,"priv_clinical_area2_reappoint_req")
li_c1 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom1")
li_c2 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom2")

openwithparm(w_select_clincopy,li_facil)

li_clin_new = message.doubleparm

if li_clin_new = 0 then return
if li_clin = li_clin_new then
	Messagebox("Selection Error","You have selected the same Clinical Area to copy to. ~r~n Please select a different Clinical Area.")
return
end if
dw_copy1.settransobject(sqlca)
dw_copy1.retrieve(li_clin_new)
dw_copy2.settransobject(sqlca)
dw_copy2.retrieve(li_clin_new)
dw_copy3.settransobject(sqlca)
dw_copy3.retrieve(li_clin_new)



//dw_copy1.setitem(1,"clinical_area_id",li_clin_new)
//dw_copy1.setitem(1,"facility_id",li_facil)
dw_copy1.setitem(1,"priv_qualifications",li_priv_qual)
dw_copy1.setitem(1,"req_pre_exp",li_req_pre_exp)
dw_copy1.setitem(1,"spec_procd",li_spec_pro)
dw_copy2.setitem(1,"priv_clinical_area2_observations",li_obs)
//messagebox("li_re_req",li_re_req)
dw_copy2.setitem(1,"priv_clinical_area2_reappoint_req",li_re_req)
dw_copy3.setitem(1,"priv_clinical_area_3_custom1",li_c1)
dw_copy3.setitem(1,"priv_clinical_area_3_custom2",li_c2)

m1 = messagebox("Copy Complete","Click Save to save changes.")


end event

type dw_clin_select from datawindow within tabpage_req
integer x = 23
integer y = 60
integer width = 1001
integer height = 104
integer taborder = 120
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

event itemchanged;long ll_clin_id
Integer ll_facility_id
long ll_row

tab_1.tabpage_req.dw_clin_select.accepttext()
ll_clin_id = integer(data)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 02.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

//messagebox("clin number",ll_clin_id)
tab_1.tabpage_req.dw_clin_req.settransobject(sqlca)
tab_1.tabpage_req.dw_clin_req.retrieve(ll_clin_id)

//*set 2nd part of data window
tab_1.tabpage_req.dw_clin_req2.settransobject(sqlca)
tab_1.tabpage_req.dw_clin_req2.retrieve(ll_clin_id)

//*set 3rd part of data window
tab_1.tabpage_req.dw_clin_req3.settransobject(sqlca)
tab_1.tabpage_req.dw_clin_req3.retrieve(ll_clin_id)

//\/moved to facility select itemchanged 12-11-00 maha 
tab_1.tabpage_acknow.dw_acknow.settransobject(sqlca)
tab_1.tabpage_acknow.dw_acknow.retrieve(il_facility)//ll_clin_id,

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 02.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

if tab_1.tabpage_req.dw_clin_req2.getrow() < 1 then
	ll_row = tab_1.tabpage_req.dw_clin_req2.InsertRow(0)
	tab_1.tabpage_req.dw_clin_req2.scrolltoRow(ll_row)

	tab_1.tabpage_req.dw_clin_req2.SetItem(ll_row, "priv_clinical_area2_clinical_area_id", ll_clin_id )
end if

if tab_1.tabpage_req.dw_clin_req3.getrow() < 1 then
	ll_row = tab_1.tabpage_req.dw_clin_req3.InsertRow(0)
	tab_1.tabpage_req.dw_clin_req3.scrolltoRow(ll_row)
	
	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_clinical_area_id", ll_clin_id )
	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom1_label", "Custom field 1 label" )
	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom2_label", "Custom field 2 label" )
end if
//\maha
//\/added 12-11-00 maha 
cb_copyclin.enabled = true
cb_reqcopy.enabled  = true
//\maha


end event

type tabpage_acknow from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 3639
integer height = 1856
long backcolor = 79741120
string text = "Acknowledgement"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_acknow dw_acknow
st_1 st_1
end type

on tabpage_acknow.create
this.dw_acknow=create dw_acknow
this.st_1=create st_1
this.Control[]={this.dw_acknow,&
this.st_1}
end on

on tabpage_acknow.destroy
destroy(this.dw_acknow)
destroy(this.st_1)
end on

type dw_acknow from u_dw within tabpage_acknow
integer x = 41
integer y = 264
integer width = 3488
integer height = 1856
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_acknowledgement"
end type

type st_1 from statictext within tabpage_acknow
integer x = 23
integer y = 68
integer width = 3419
integer height = 88
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "This Acknowledgement is Facility based and should be generic enough for all Clinical areas."
boolean focusrectangle = false
end type

type tabpage_report from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3639
integer height = 1856
long backcolor = 32891346
string text = "Preview Forms"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
gb_9 gb_9
gb_6 gb_6
cb_preview cb_preview
cb_print cb_print
ddlb_report ddlb_report
dw_clin_select_preview dw_clin_select_preview
end type

on tabpage_report.create
this.dw_print=create dw_print
this.gb_9=create gb_9
this.gb_6=create gb_6
this.cb_preview=create cb_preview
this.cb_print=create cb_print
this.ddlb_report=create ddlb_report
this.dw_clin_select_preview=create dw_clin_select_preview
this.Control[]={this.dw_print,&
this.gb_9,&
this.gb_6,&
this.cb_preview,&
this.cb_print,&
this.ddlb_report,&
this.dw_clin_select_preview}
end on

on tabpage_report.destroy
destroy(this.dw_print)
destroy(this.gb_9)
destroy(this.gb_6)
destroy(this.cb_preview)
destroy(this.cb_print)
destroy(this.ddlb_report)
destroy(this.dw_clin_select_preview)
end on

type dw_print from u_dw within tabpage_report
integer x = 23
integer y = 220
integer width = 3506
integer height = 1612
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_form_priv_acknowledgement_col"
boolean hscrollbar = true
end type

type gb_9 from groupbox within tabpage_report
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
long backcolor = 32891346
string text = "Select Preview"
end type

type gb_6 from groupbox within tabpage_report
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
long backcolor = 32891346
string text = "Select Clinical Area"
end type

type cb_preview from commandbutton within tabpage_report
integer x = 2455
integer y = 52
integer width = 247
integer height = 108
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

elseif ddlb_report.text = "Privileges Requested w/ headers" then
	//tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h"
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h_new" //modify by stephen 04.03.2013 -Issues with Privileging -bug 3447
	
elseif ddlb_report.text = "Privileges Requested w/ descp." then
	//tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d"
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_new" //modify by stephen 04.03.2013 -Issues with Privileging -bug 3447
	
elseif ddlb_report.text = "Privilege Recommendations" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_acknowledgement_col"

elseif ddlb_report.text = "Complete Privilege Application w/ headers" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_h"
	
elseif ddlb_report.text = "Complete Privilege Application w/ descp." then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_d"
	
	
else
	messagebox("Report Selection", "Please select a report or form to view.")
	return
end if

	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )

//tab_1.tabpage_report.dw_print.printpreview()


end event

type cb_print from commandbutton within tabpage_report
integer x = 2720
integer y = 52
integer width = 247
integer height = 108
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
integer x = 32
integer y = 60
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

type dw_facility from datawindow within w_privilege_adjustments
integer x = 37
integer y = 64
integer width = 969
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ddlb_priv_template"
boolean border = false
boolean livescroll = true
end type

event itemchanged;

il_facility = integer(data)
//messagebox("facility", il_facility)
tab_1.tabpage_comp.dw_clin.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add a variable to record the current row number dw_clin.
//$<modification> The row number will be used by the script in PT-08.
long ll_currentrow
ll_currentrow = tab_1.tabpage_comp.dw_clin.getrow( )
//---------------------------- APPEON END ----------------------------
tab_1.tabpage_comp.dw_clin.retrieve(il_facility)

tab_1.tabpage_comp.cb_add_clin.enabled = true
tab_1.tabpage_comp.cb_delete_clin.enabled = true
tab_1.tabpage_comp.cb_copy_proc.enabled = true

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 02.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Copy the script from PT-09 since RowFocusChanged event should
//$<modification> be triggered after Retrieve.
//$<modification> 2)Add the condition to make sure that the RowFocusChanged event
//$<modification> will always be triggered after Retrieve.
//$<modification> Refer to PT-07/09 for more information.
/*
tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)
*/
IF ll_currentrow = 1 THEN
	tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)
END IF
//---------------------------- APPEON END ----------------------------

//retrieve clin area select drop downs
tab_1.tabpage_req.dw_clin_select.settransobject(sqlca)
DataWindowChild dwchild
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<comment> 02.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to PT-08 since it should be triggered after
//$<modification> Retrieve.

//tab_1.tabpage_req.dw_clin_select.retrieve()
//---------------------------- APPEON END ----------------------------
tab_1.tabpage_req.dw_clin_select.insertrow(1)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

tab_1.tabpage_req.dw_clin_select.GetChild( "clinical_area_description", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(il_facility)

tab_1.tabpage_report.dw_clin_select_preview.settransobject(sqlca)
DataWindowChild dwchild1
tab_1.tabpage_report.dw_clin_select_preview.retrieve()

tab_1.tabpage_report.dw_clin_select_preview.GetChild( "clinical_area_description", dwchild1 )
dwchild1.settransobject(sqlca)
dwchild1.retrieve(il_facility)
//\/moved here 12-11-00 maha
tab_1.tabpage_acknow.dw_acknow.settransobject(sqlca)
tab_1.tabpage_acknow.dw_acknow.retrieve(il_facility)
//\maha

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------


tab_1.tabpage_report.dw_clin_select_preview.insertrow(1)

//\/maha  The following code protects against the retrieval message box when there are no rows.
integer rc1
rc1 = dwchild.rowcount()
//messagebox("rowcount", rc1)
if rc1 = 0 then
	dwchild.insertrow(1)
end if
//\maha

tab_1.tabpage_req.dw_clin_req.reset()
tab_1.tabpage_req.dw_clin_req2.reset()
tab_1.tabpage_req.dw_clin_req3.reset()
//tab_1.tabpage_acknow.dw_acknow.reset()

tab_1.tabpage_comp.enabled = true
tab_1.tabpage_acknow.enabled = true
tab_1.tabpage_report.enabled = true
tab_1.tabpage_req.enabled = true
end event

event constructor;dw_facility.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<comment> 02.28.2006 By: LiuHongXin
//$<reason> Performance tuning.
//$<modification> Comment out the following script, since dw_facility.InsertRow(1) has 
//$<modification> the same functionality.
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

type cb_save from commandbutton within w_privilege_adjustments
integer x = 2985
integer y = 68
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;
Parent.Event pfc_save( )

end event

type cb_view from commandbutton within w_privilege_adjustments
boolean visible = false
integer x = 2409
integer y = 56
integer width = 247
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Preview"
end type

event clicked;//long ll_fac_id
//long ll_clin_id
//
//ll_fac_id = il_facility
//ll_clin_id = tab_1.tabpage_report.dw_clin_select_preview.GetItemNumber ( tab_1.tabpage_report.dw_clin_select_preview.getrow(), "clinical_area_id" )
////	messagebox("clin",ll_clin_id)
////		messagebox("ll_fac_id",ll_fac_id)
//if  tab_1.tabpage_report.dw_clin_select_preview.getrow() < 1 then
//	messagebox("No data", "You have no data to view or print.  Please select a Clinical Area")
//	return
//end if
//
//if ddlb_report.text = "Clinical Area Privilege List" then
//	if tab_1.tabpage_req.dw_clin_req.getrow() < 1 then
//		messagebox("error", "Please select a Clinical Area from the Requirements tabpage.")
//		return
//	end if
//	tab_1.tabpage_report.dw_print.dataobject  = "d_rpt_priv_by_clin_area_by_facil"
////	tab_1.tabpage_report.dw_print.settransobject(sqlca)
////	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id, ll_clin_id )
//
//elseif ddlb_report.text = "Privilege Requirements" then
//	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_clin_req"
////	tab_1.tabpage_report.dw_print.settransobject(sqlca)
////	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id, ll_clin_id )
//
//elseif ddlb_report.text = "Privileges Requested" then
//		if tab_1.tabpage_req.dw_clin_req.getrow() < 1 then
//		messagebox("error", "Please select a Clinical Area from the Requirements tabpage.")
//		return
//		end if
//	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area"
////	tab_1.tabpage_report.dw_print.settransobject(sqlca)
////	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
//	
//elseif ddlb_report.text = "Privilege Recommendations" then
//	if tab_1.tabpage_req.dw_clin_req.getrow() < 1 then
//		messagebox("error", "Please select a Clinical Area from the Requirements tabpage.")
//		return
//	end if
//	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_acknowledgement_col"
////	tab_1.tabpage_report.dw_print.settransobject(sqlca)
////	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
//	
//elseif ddlb_report.text = "Complete Privilege Application" then
//	if tab_1.tabpage_req.dw_clin_req.getrow() < 1 then
//		messagebox("error", "Please select a Clinical Area from the Requirements tabpage.")
//		return
//	end if
//	tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master"
////	tab_1.tabpage_report.dw_print.settransobject(sqlca)
////	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )	
//	
//else
//	messagebox("Report Selection", "Please select a report or form to view.")
//	return
//end if
//
//	tab_1.tabpage_report.dw_print.settransobject(sqlca)
//	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
//
////tab_1.tabpage_report.dw_print.printpreview()
//
//
end event

type cb_print_clin from commandbutton within w_privilege_adjustments
boolean visible = false
integer x = 2277
integer y = 68
integer width = 247
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Print"
end type

event clicked;cb_view.triggerevent(clicked!)


tab_1.tabpage_report.dw_print.print()










end event

type cb_1 from commandbutton within w_privilege_adjustments
boolean visible = false
integer x = 2693
integer y = 68
integer width = 247
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;messagebox("Privilege help","This utility is used for adjusting privileges.")
end event

