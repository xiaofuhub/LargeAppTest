$PBExportHeader$w_get_multi_app_template.srw
forward
global type w_get_multi_app_template from w_response
end type
type dw_1 from u_dw within w_get_multi_app_template
end type
type cb_apply from commandbutton within w_get_multi_app_template
end type
type cb_close from commandbutton within w_get_multi_app_template
end type
type dw_staff_cat from u_dw within w_get_multi_app_template
end type
type gb_1 from groupbox within w_get_multi_app_template
end type
type gb_3 from groupbox within w_get_multi_app_template
end type
type dw_departments from u_dw within w_get_multi_app_template
end type
type gb_2 from groupbox within w_get_multi_app_template
end type
end forward

global type w_get_multi_app_template from w_response
integer x = 393
integer y = 512
integer width = 2789
integer height = 1312
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
dw_1 dw_1
cb_apply cb_apply
cb_close cb_close
dw_staff_cat dw_staff_cat
gb_1 gb_1
gb_3 gb_3
dw_departments dw_departments
gb_2 gb_2
end type
global w_get_multi_app_template w_get_multi_app_template

on w_get_multi_app_template.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_apply=create cb_apply
this.cb_close=create cb_close
this.dw_staff_cat=create dw_staff_cat
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_departments=create dw_departments
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_apply
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_staff_cat
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.dw_departments
this.Control[iCurrent+8]=this.gb_2
end on

on w_get_multi_app_template.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_apply)
destroy(this.cb_close)
destroy(this.dw_staff_cat)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_departments)
destroy(this.gb_2)
end on

type dw_1 from u_dw within w_get_multi_app_template
integer x = 87
integer y = 144
integer width = 1280
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_multi_app"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetUpdateable( False )
end event

type cb_apply from commandbutton within w_get_multi_app_template
integer x = 2418
integer y = 72
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
string text = "&OK"
boolean default = true
end type

event clicked;gs_multi_app lstr_multi_app

IF  dw_1.GetText() = "" or IsNull(  dw_1.GetText() ) THEN
	MessageBox("Invalid Name", "You must select a template before continuing.")
	Return
END IF

lstr_multi_app.i_multi_app_id = Integer( dw_1.GetText() )


dw_staff_cat.AcceptText()
dw_departments.accepttext( )	//added by long.zhang 02.01.2012

IF dw_staff_cat.GetItemStatus( 1, 0, Primary! ) = NewModified! THEN
	lstr_multi_app.l_staff_category = dw_staff_cat.GetItemNumber( 1, "staff_category" )
	lstr_multi_app.dt_from_date = dw_staff_cat.GetItemDateTime( 1, "from_date" )
	lstr_multi_app.dt_to_date = dw_staff_cat.GetItemDateTime ( 1, "to_date" )
	lstr_multi_app.l_request = dw_staff_cat.getitemnumber( 1,"requested")	//added by long.zhang 02.01.2012	
END IF

IF dw_departments.GetItemStatus( 1, 0, Primary! ) = NewModified! THEN
	lstr_multi_app.l_department = dw_departments.GetItemNumber( 1, "department" )
	lstr_multi_app.l_section = dw_departments.GetItemNumber( 1, "section" )
	lstr_multi_app.i_primary = dw_departments.GetItemNumber( 1, "primary_dept" )//maha 182802
	//------------------Appeon Begin--------------------
	//$<add> long.zhang 02.01.2012
	//$<Reason> Fixed Bug 2899
	lstr_multi_app.dep_from_date = dw_departments.getitemdatetime( 1,"from_date")
	lstr_multi_app.dep_to_date = dw_departments.getitemdatetime( 1,"to_date")
	lstr_multi_app.l_division = dw_departments.getitemnumber( 1,"rank")
	//------------------Appeon End----------------------
END IF

CloseWithReturn( Parent, lstr_multi_app )
end event

type cb_close from commandbutton within w_get_multi_app_template
integer x = 2418
integer y = 168
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
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type dw_staff_cat from u_dw within w_get_multi_app_template
integer x = 78
integer y = 432
integer width = 2523
integer height = 200
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_pd_affil_staff_cat"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;DataWindowChild dwchild
Long nulllong

SetNull( nulllong )
This.of_SetRowManager( TRUE )
This.of_SetReqColumn(TRUE)
This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
This.of_SetTransObject(SQLCA)

This.GetChild( "staff_category", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.13.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
dwchild.Retrieve("staff category")
*/
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" +upper('staff category') +  "'" , dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

This.InsertRow( 0 )

This.of_SetUpdateable( False )
end event

event itemchanged;call super::itemchanged;//Start Code Change ----12.12.2007 #V8 maha
IF This.GetColumnName() = "to_date" THEN 
	if isnull(this.getitemdatetime(this.getrow(),"to_date")) then //if the to_date is completed set to inactive else set to active
		this.setitem(this.getrow(),"requested",1)
	else
		this.setitem(this.getrow(),"requested",0)
	end if
END IF

IF This.GetColumnName() = "from_date" THEN 
	if not(isnull(this.getitemdatetime(this.getrow(),"from_date"))) then // if the from_date is completed then set to active if the to_date is null 
		if isnull(this.getitemdatetime(this.getrow(),"to_date")) then
			this.setitem(this.getrow(),"requested",1)
		end if
	end if
END IF
//End Code Change---12.12.2007
end event

type gb_1 from groupbox within w_get_multi_app_template
integer x = 23
integer y = 40
integer width = 1426
integer height = 272
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Multi App Template"
end type

type gb_3 from groupbox within w_get_multi_app_template
integer x = 23
integer y = 376
integer width = 2633
integer height = 272
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Staff Category"
end type

type dw_departments from u_dw within w_get_multi_app_template
integer x = 73
integer y = 760
integer width = 2514
integer height = 360
integer taborder = 20
string dataobject = "d_pd_affil_departments"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;DataWindowChild dwchild

This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )
This.of_SetDropDownCalendar( TRUE )
This.GetChild( "department", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("department")

This.GetChild( "rank", dwchild ) //maha 09-27-02
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 02.13.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
dwchild.Retrieve("division")
*/
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" +upper('division') +  "'" , dwchild)
//---------------------------- APPEON END ----------------------------

This.GetChild( "section", dwchild )
dwchild.SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 02.13.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
dwchild.Retrieve("section")
*/
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" +upper('section') +  "'" , dwchild)
//---------------------------- APPEON END ----------------------------


This.of_SetUpdateable( False )



end event

event pfc_postinsertrow;call super::pfc_postinsertrow;this.setitem(1,"primary_dept",1)
end event

event itemchanged;call super::itemchanged;//Start Code Change ----12.12.2007 #V8 maha
IF This.GetColumnName() = "department" THEN
	if isnull(This.getItemnumber( row, "primary_dept")) then//\/maha 080102
		if this.rowcount() = 1 then
			This.SetItem( row, "primary_dept",1)
		else
			This.SetItem( row, "primary_dept",0)
		end if
	end if	
END IF
//End Code Change---12.12.2007
end event

type gb_2 from groupbox within w_get_multi_app_template
integer x = 23
integer y = 700
integer width = 2638
integer height = 448
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Departments"
end type

