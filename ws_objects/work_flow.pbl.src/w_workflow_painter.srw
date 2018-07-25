$PBExportHeader$w_workflow_painter.srw
forward
global type w_workflow_painter from w_response
end type
type tab_1 from tab within w_workflow_painter
end type
type tabpage_setup from userobject within tab_1
end type
type dw_setup from u_dw within tabpage_setup
end type
type tabpage_setup from userobject within tab_1
dw_setup dw_setup
end type
type tabpage_ai_trigger from userobject within tab_1
end type
type dw_ai_trigger from u_dw within tabpage_ai_trigger
end type
type cb_222 from commandbutton within tabpage_ai_trigger
end type
type cb_444 from commandbutton within tabpage_ai_trigger
end type
type tabpage_ai_trigger from userobject within tab_1
dw_ai_trigger dw_ai_trigger
cb_222 cb_222
cb_444 cb_444
end type
type tabpage_create_ai from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_create_ai
end type
type cb_1 from commandbutton within tabpage_create_ai
end type
type dw_create_ai from u_dw within tabpage_create_ai
end type
type cbx_1 from checkbox within tabpage_create_ai
end type
type tabpage_create_ai from userobject within tab_1
cb_2 cb_2
cb_1 cb_1
dw_create_ai dw_create_ai
cbx_1 cbx_1
end type
type tabpage_modify_ai from userobject within tab_1
end type
type cb_4 from commandbutton within tabpage_modify_ai
end type
type cb_3 from commandbutton within tabpage_modify_ai
end type
type dw_modify_ai_from from u_dw within tabpage_modify_ai
end type
type dw_modify_ai_to from u_dw within tabpage_modify_ai
end type
type st_2 from statictext within tabpage_modify_ai
end type
type cb_9 from commandbutton within tabpage_modify_ai
end type
type cb_11 from commandbutton within tabpage_modify_ai
end type
type tabpage_modify_ai from userobject within tab_1
cb_4 cb_4
cb_3 cb_3
dw_modify_ai_from dw_modify_ai_from
dw_modify_ai_to dw_modify_ai_to
st_2 st_2
cb_9 cb_9
cb_11 cb_11
end type
type tabpage_eval_query from userobject within tab_1
end type
type cb_7 from commandbutton within tabpage_eval_query
end type
type cb_6 from commandbutton within tabpage_eval_query
end type
type cb_5 from commandbutton within tabpage_eval_query
end type
type rte_1 from richtextedit within tabpage_eval_query
end type
type ddlb_3 from dropdownlistbox within tabpage_eval_query
end type
type sle_6 from singlelineedit within tabpage_eval_query
end type
type sle_5 from singlelineedit within tabpage_eval_query
end type
type sle_4 from singlelineedit within tabpage_eval_query
end type
type sle_3 from singlelineedit within tabpage_eval_query
end type
type st_8 from statictext within tabpage_eval_query
end type
type st_7 from statictext within tabpage_eval_query
end type
type st_6 from statictext within tabpage_eval_query
end type
type tabpage_eval_query from userobject within tab_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
rte_1 rte_1
ddlb_3 ddlb_3
sle_6 sle_6
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
st_8 st_8
st_7 st_7
st_6 st_6
end type
type tabpage_mod_query from userobject within tab_1
end type
type cb_3231 from commandbutton within tabpage_mod_query
end type
type cb_12121 from commandbutton within tabpage_mod_query
end type
type cb_2121 from commandbutton within tabpage_mod_query
end type
type st_1111 from statictext within tabpage_mod_query
end type
type rte_33 from richtextedit within tabpage_mod_query
end type
type ddlb_11 from dropdownlistbox within tabpage_mod_query
end type
type st_22 from statictext within tabpage_mod_query
end type
type tabpage_mod_query from userobject within tab_1
cb_3231 cb_3231
cb_12121 cb_12121
cb_2121 cb_2121
st_1111 st_1111
rte_33 rte_33
ddlb_11 ddlb_11
st_22 st_22
end type
type tabpage_scheduled_event from userobject within tab_1
end type
type tabpage_scheduled_event from userobject within tab_1
end type
type tab_1 from tab within w_workflow_painter
tabpage_setup tabpage_setup
tabpage_ai_trigger tabpage_ai_trigger
tabpage_create_ai tabpage_create_ai
tabpage_modify_ai tabpage_modify_ai
tabpage_eval_query tabpage_eval_query
tabpage_mod_query tabpage_mod_query
tabpage_scheduled_event tabpage_scheduled_event
end type
type cb_8 from commandbutton within w_workflow_painter
end type
type cb_10 from commandbutton within w_workflow_painter
end type
type dw_wf_list from u_dw within w_workflow_painter
end type
type st_1 from statictext within w_workflow_painter
end type
type cb_close from commandbutton within w_workflow_painter
end type
end forward

global type w_workflow_painter from w_response
integer x = 174
integer y = 112
integer width = 3109
integer height = 1992
string title = "Work Flow Painter"
long backcolor = 33551856
tab_1 tab_1
cb_8 cb_8
cb_10 cb_10
dw_wf_list dw_wf_list
st_1 st_1
cb_close cb_close
end type
global w_workflow_painter w_workflow_painter

type variables
u_dw idw_current_focus
Long il_rec_id

end variables

on w_workflow_painter.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_8=create cb_8
this.cb_10=create cb_10
this.dw_wf_list=create dw_wf_list
this.st_1=create st_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_8
this.Control[iCurrent+3]=this.cb_10
this.Control[iCurrent+4]=this.dw_wf_list
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_close
end on

on w_workflow_painter.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_8)
destroy(this.cb_10)
destroy(this.dw_wf_list)
destroy(this.st_1)
destroy(this.cb_close)
end on

type tab_1 from tab within w_workflow_painter
integer x = 32
integer y = 220
integer width = 3017
integer height = 1656
integer taborder = 10
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
tabpage_setup tabpage_setup
tabpage_ai_trigger tabpage_ai_trigger
tabpage_create_ai tabpage_create_ai
tabpage_modify_ai tabpage_modify_ai
tabpage_eval_query tabpage_eval_query
tabpage_mod_query tabpage_mod_query
tabpage_scheduled_event tabpage_scheduled_event
end type

on tab_1.create
this.tabpage_setup=create tabpage_setup
this.tabpage_ai_trigger=create tabpage_ai_trigger
this.tabpage_create_ai=create tabpage_create_ai
this.tabpage_modify_ai=create tabpage_modify_ai
this.tabpage_eval_query=create tabpage_eval_query
this.tabpage_mod_query=create tabpage_mod_query
this.tabpage_scheduled_event=create tabpage_scheduled_event
this.Control[]={this.tabpage_setup,&
this.tabpage_ai_trigger,&
this.tabpage_create_ai,&
this.tabpage_modify_ai,&
this.tabpage_eval_query,&
this.tabpage_mod_query,&
this.tabpage_scheduled_event}
end on

on tab_1.destroy
destroy(this.tabpage_setup)
destroy(this.tabpage_ai_trigger)
destroy(this.tabpage_create_ai)
destroy(this.tabpage_modify_ai)
destroy(this.tabpage_eval_query)
destroy(this.tabpage_mod_query)
destroy(this.tabpage_scheduled_event)
end on

type tabpage_setup from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2981
integer height = 1540
long backcolor = 33551856
string text = "Setup"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_setup dw_setup
end type

on tabpage_setup.create
this.dw_setup=create dw_setup
this.Control[]={this.dw_setup}
end on

on tabpage_setup.destroy
destroy(this.dw_setup)
end on

type dw_setup from u_dw within tabpage_setup
integer x = 14
integer y = 16
integer width = 2939
integer height = 1088
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wf_header"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "wf_to_do" THEN
	CHOOSE CASE data
		CASE "Create NEW action Item(s)"
			tab_1.tabpage_create_ai.Visible = True				
			tab_1.tabpage_modify_ai.Visible = False
		CASE "MODIFY existing action item(s)"
			tab_1.tabpage_modify_ai.Visible = True		
			tab_1.tabpage_create_ai.Visible = False		
		CASE "Create  NEW action item(s) and MODIFY existing action item(s)"
			tab_1.tabpage_modify_ai.Visible = True
			tab_1.tabpage_create_ai.Visible = True		
	END CHOOSE
ELSEIF This.GetColumnName() = "wf_trigger" THEN
	CHOOSE CASE data
		CASE "Modification to an existing Application Status Action Item"
			tab_1.tabpage_ai_trigger.Visible = True
	END CHOOSE
END IF
end event

event constructor;call super::constructor;This.of_SetTRansObject( SQLCA )
end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i


li_rc = This.RowCount( )

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "rec_id", il_rec_id ) 
	END IF
END FOR

Return 1
end event

event retrieveend;call super::retrieveend;	CHOOSE CASE This.GetItemString( 1, "wf_to_do" )
		CASE "Create NEW action Item(s)"
			tab_1.tabpage_create_ai.Visible = True				
			tab_1.tabpage_modify_ai.Visible = False
		CASE "MODIFY existing action item(s)"
			tab_1.tabpage_modify_ai.Visible = True		
			tab_1.tabpage_create_ai.Visible = False		
		CASE "Create  NEW action item(s) and MODIFY existing action item(s)"
			tab_1.tabpage_modify_ai.Visible = True
			tab_1.tabpage_create_ai.Visible = True		
	END CHOOSE
	
	
	CHOOSE CASE This.GetItemString( 1, "wf_trigger" )
		CASE "Modification to an existing Application Status Action Item"
			tab_1.tabpage_ai_trigger.Visible = True
	END CHOOSE

end event

type tabpage_ai_trigger from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 2981
integer height = 1540
long backcolor = 33551856
string text = "Work Flow Trigger"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_ai_trigger dw_ai_trigger
cb_222 cb_222
cb_444 cb_444
end type

on tabpage_ai_trigger.create
this.dw_ai_trigger=create dw_ai_trigger
this.cb_222=create cb_222
this.cb_444=create cb_444
this.Control[]={this.dw_ai_trigger,&
this.cb_222,&
this.cb_444}
end on

on tabpage_ai_trigger.destroy
destroy(this.dw_ai_trigger)
destroy(this.cb_222)
destroy(this.cb_444)
end on

type dw_ai_trigger from u_dw within tabpage_ai_trigger
integer x = 27
integer y = 68
integer width = 2912
integer height = 320
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_wf_net_dev_action_items"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;DataWindowChild dwchild

This.of_SetTransObject( sqlca )
This.InsertRow( 0 )

of_SetRowManager( TRUE )
of_SetReqColumn(TRUE)
of_SetTransObject(SQLCA)


This.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

This.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

This.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")

This.GetChild( "app_id", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "app_hdr_app_id", 0 )
dwchild.SetItem( 1, "app_hdr_application_name", "<<Match On App_ID>>" )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(This.iuo_calendar.DDLB)


end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Long ll_rec_id

li_rc = This.RowCount( )

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "rec_id", il_rec_id ) 
		ll_rec_id = gnv_app.Of_Get_Id( "record_id" )
		This.SetItem( i, "prac_id", ll_rec_id ) 		
		This.SetItem( i, "wf_type", "Trigger"  ) 				
	END IF
END FOR

Return 1
end event

type cb_222 from commandbutton within tabpage_ai_trigger
integer x = 18
integer y = 1388
integer width = 247
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Integer li_nr

li_nr = dw_ai_trigger.InsertRow( 0 )

dw_ai_trigger.SetRow( li_nr )
end event

type cb_444 from commandbutton within tabpage_ai_trigger
integer x = 306
integer y = 1388
integer width = 247
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type tabpage_create_ai from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2981
integer height = 1540
long backcolor = 33551856
string text = "Create Action Item"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_2 cb_2
cb_1 cb_1
dw_create_ai dw_create_ai
cbx_1 cbx_1
end type

on tabpage_create_ai.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_create_ai=create dw_create_ai
this.cbx_1=create cbx_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_create_ai,&
this.cbx_1}
end on

on tabpage_create_ai.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_create_ai)
destroy(this.cbx_1)
end on

type cb_2 from commandbutton within tabpage_create_ai
integer x = 302
integer y = 1448
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_1 from commandbutton within tabpage_create_ai
integer x = 18
integer y = 1448
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Integer li_nr

li_nr = dw_create_ai.InsertRow( 0 )

dw_create_ai.SetRow( li_nr )
end event

type dw_create_ai from u_dw within tabpage_create_ai
integer x = 27
integer y = 116
integer width = 2921
integer height = 1312
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_wf_net_dev_action_items"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;DataWindowChild dwchild

This.of_SetTransObject( sqlca )
This.InsertRow( 0 )

of_SetRowManager( TRUE )
of_SetReqColumn(TRUE)
of_SetTransObject(SQLCA)


This.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

This.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

This.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")

This.GetChild( "app_id", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1 , "app_hdr_app_id", 0 )
dwchild.SetItem( 1 , "app_hdr_application_name", "<<Popup List of Apps when created.>>" )


This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(This.iuo_calendar.DDLB)


end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Long ll_rec_id

li_rc = This.RowCount( )

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "rec_id", il_rec_id ) 
		ll_rec_id = gnv_app.Of_Get_Id( "record_id" )
		This.SetItem( i, "prac_id", ll_rec_id ) 		
		This.SetItem( i, "wf_type", "Create" ) 				
	END IF
END FOR

Return 1
end event

type cbx_1 from checkbox within tabpage_create_ai
integer x = 27
integer y = 24
integer width = 1394
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select link to application when action items are created"
boolean checked = true
end type

type tabpage_modify_ai from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2981
integer height = 1540
long backcolor = 33551856
string text = "Modify Action Items"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_4 cb_4
cb_3 cb_3
dw_modify_ai_from dw_modify_ai_from
dw_modify_ai_to dw_modify_ai_to
st_2 st_2
cb_9 cb_9
cb_11 cb_11
end type

on tabpage_modify_ai.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_modify_ai_from=create dw_modify_ai_from
this.dw_modify_ai_to=create dw_modify_ai_to
this.st_2=create st_2
this.cb_9=create cb_9
this.cb_11=create cb_11
this.Control[]={this.cb_4,&
this.cb_3,&
this.dw_modify_ai_from,&
this.dw_modify_ai_to,&
this.st_2,&
this.cb_9,&
this.cb_11}
end on

on tabpage_modify_ai.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_modify_ai_from)
destroy(this.dw_modify_ai_to)
destroy(this.st_2)
destroy(this.cb_9)
destroy(this.cb_11)
end on

type cb_4 from commandbutton within tabpage_modify_ai
integer x = 297
integer y = 984
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_3 from commandbutton within tabpage_modify_ai
integer x = 32
integer y = 984
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Integer li_nr

IF idw_current_focus = dw_modify_ai_from THEN
	li_nr = dw_modify_ai_from.InsertRow( 0 )
	dw_modify_ai_from.SetRow( li_nr )
	dw_modify_ai_from.SetFocus( )
ELSE
	li_nr = dw_modify_ai_to.InsertRow( 0 )
	dw_modify_ai_to.SetRow( li_nr )
	dw_modify_ai_to.SetFocus( )
END IF
end event

type dw_modify_ai_from from u_dw within tabpage_modify_ai
integer x = 32
integer y = 52
integer width = 2903
integer height = 456
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Modify Action Items Like This"
string dataobject = "d_wf_net_dev_action_items"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;DataWindowChild dwchild

This.of_SetTransObject( sqlca )
This.InsertRow( 0 )

of_SetRowManager( TRUE )
of_SetReqColumn(TRUE)
of_SetTransObject(SQLCA)


This.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

This.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

This.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")


This.GetChild( "app_id", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "app_hdr_app_id", 0 )
dwchild.SetItem( 1, "app_hdr_application_name", "<<Match On App_ID>>" )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(This.iuo_calendar.DDLB)


end event

event getfocus;call super::getfocus;idw_current_focus = This
end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Long ll_rec_id

li_rc = This.RowCount( )

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "rec_id", il_rec_id ) 
		ll_rec_id = gnv_app.Of_Get_Id( "record_id" )
		This.SetItem( i, "prac_id", ll_rec_id ) 		
		This.SetItem( i, "wf_type", "Mod_From" ) 				
	END IF
END FOR

Return 1
end event

type dw_modify_ai_to from u_dw within tabpage_modify_ai
integer x = 32
integer y = 544
integer width = 2912
integer height = 420
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "And Change Them to Look Like This"
string dataobject = "d_wf_net_dev_action_items"
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;idw_current_focus = This
end event

event constructor;call super::constructor;DataWindowChild dwchild

This.of_SetTransObject( sqlca )
This.InsertRow( 0 )

of_SetRowManager( TRUE )
of_SetReqColumn(TRUE)
of_SetTransObject(SQLCA)


This.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

This.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

This.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")

This.GetChild( "app_id", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "app_hdr_app_id", 0 )
dwchild.SetItem( 1, "app_hdr_application_name", "<<Match On App_ID>>" )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(This.iuo_calendar.DDLB)


end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Long ll_rec_id

li_rc = This.RowCount( )

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "rec_id", il_rec_id ) 
		ll_rec_id = gnv_app.Of_Get_Id( "record_id" )
		This.SetItem( i, "prac_id", ll_rec_id ) 		
		This.SetItem( i, "wf_type", "Mod_To" ) 				
	END IF
END FOR

Return 1
end event

type st_2 from statictext within tabpage_modify_ai
integer x = 1184
integer y = 992
integer width = 1010
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Record 1 of 2"
boolean focusrectangle = false
end type

type cb_9 from commandbutton within tabpage_modify_ai
integer x = 622
integer y = 984
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<"
end type

type cb_11 from commandbutton within tabpage_modify_ai
integer x = 891
integer y = 984
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">"
end type

type tabpage_eval_query from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 2981
integer height = 1540
long backcolor = 33551856
string text = "Evaluation Query"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
rte_1 rte_1
ddlb_3 ddlb_3
sle_6 sle_6
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
st_8 st_8
st_7 st_7
st_6 st_6
end type

on tabpage_eval_query.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.rte_1=create rte_1
this.ddlb_3=create ddlb_3
this.sle_6=create sle_6
this.sle_5=create sle_5
this.sle_4=create sle_4
this.sle_3=create sle_3
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.rte_1,&
this.ddlb_3,&
this.sle_6,&
this.sle_5,&
this.sle_4,&
this.sle_3,&
this.st_8,&
this.st_7,&
this.st_6}
end on

on tabpage_eval_query.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.rte_1)
destroy(this.ddlb_3)
destroy(this.sle_6)
destroy(this.sle_5)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
end on

type cb_7 from commandbutton within tabpage_eval_query
integer x = 581
integer y = 644
integer width = 251
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_6 from commandbutton within tabpage_eval_query
integer x = 306
integer y = 644
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_5 from commandbutton within tabpage_eval_query
integer x = 37
integer y = 644
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test SQL"
end type

type rte_1 from richtextedit within tabpage_eval_query
integer x = 37
integer y = 208
integer width = 1509
integer height = 416
integer taborder = 30
borderstyle borderstyle = stylelowered!
end type

type ddlb_3 from dropdownlistbox within tabpage_eval_query
integer x = 626
integer y = 36
integer width = 910
integer height = 228
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Prac_id","Facility_id","App_id","Lookup_code"}
borderstyle borderstyle = stylelowered!
end type

type sle_6 from singlelineedit within tabpage_eval_query
integer x = 1586
integer y = 528
integer width = 1289
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_5 from singlelineedit within tabpage_eval_query
integer x = 1586
integer y = 420
integer width = 1289
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_4 from singlelineedit within tabpage_eval_query
integer x = 1586
integer y = 312
integer width = 1289
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within tabpage_eval_query
integer x = 1586
integer y = 204
integer width = 1289
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within tabpage_eval_query
integer x = 1586
integer y = 136
integer width = 379
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Value Range"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_eval_query
integer x = 37
integer y = 36
integer width = 603
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Retrieval Argument Data:"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_eval_query
integer x = 32
integer y = 140
integer width = 421
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Statement"
boolean focusrectangle = false
end type

type tabpage_mod_query from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 2981
integer height = 1540
long backcolor = 33551856
string text = "Modification Query"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_3231 cb_3231
cb_12121 cb_12121
cb_2121 cb_2121
st_1111 st_1111
rte_33 rte_33
ddlb_11 ddlb_11
st_22 st_22
end type

on tabpage_mod_query.create
this.cb_3231=create cb_3231
this.cb_12121=create cb_12121
this.cb_2121=create cb_2121
this.st_1111=create st_1111
this.rte_33=create rte_33
this.ddlb_11=create ddlb_11
this.st_22=create st_22
this.Control[]={this.cb_3231,&
this.cb_12121,&
this.cb_2121,&
this.st_1111,&
this.rte_33,&
this.ddlb_11,&
this.st_22}
end on

on tabpage_mod_query.destroy
destroy(this.cb_3231)
destroy(this.cb_12121)
destroy(this.cb_2121)
destroy(this.st_1111)
destroy(this.rte_33)
destroy(this.ddlb_11)
destroy(this.st_22)
end on

type cb_3231 from commandbutton within tabpage_mod_query
integer x = 581
integer y = 636
integer width = 251
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_12121 from commandbutton within tabpage_mod_query
integer x = 306
integer y = 636
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_2121 from commandbutton within tabpage_mod_query
integer x = 37
integer y = 636
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test SQL"
end type

type st_1111 from statictext within tabpage_mod_query
integer x = 32
integer y = 140
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Statement"
boolean focusrectangle = false
end type

type rte_33 from richtextedit within tabpage_mod_query
integer x = 37
integer y = 208
integer width = 1509
integer height = 412
integer taborder = 40
borderstyle borderstyle = stylelowered!
end type

type ddlb_11 from dropdownlistbox within tabpage_mod_query
integer x = 626
integer y = 36
integer width = 910
integer height = 228
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Prac_id","Facility_id","App_id","Lookup_code"}
borderstyle borderstyle = stylelowered!
end type

type st_22 from statictext within tabpage_mod_query
integer x = 37
integer y = 36
integer width = 617
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Retrieval Argument Data:"
boolean focusrectangle = false
end type

type tabpage_scheduled_event from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 2981
integer height = 1540
long backcolor = 33551856
string text = "Scheduled Event"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type cb_8 from commandbutton within w_workflow_painter
integer x = 1906
integer y = 80
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

event clicked;w_workflow_painter.Event pfc_save( )

DataWindowChild dwchild
dw_wf_list.GetChild( "rec_id", dwchild )
dwchild.SetTransObject( sqlca )
dwchild.Retrieve( )
end event

type cb_10 from commandbutton within w_workflow_painter
integer x = 1641
integer y = 80
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
string text = "Add"
end type

event clicked;
dw_wf_list.Reset( )
dw_wf_list.InsertRow( 0 )

il_rec_id = gnv_app.of_get_id( "record_id" )

tab_1.tabpage_setup.dw_setup.Reset( )
tab_1.tabpage_setup.dw_setup.InsertRow( 0 )

tab_1.tabpage_create_ai.dw_create_ai.Reset( )
tab_1.tabpage_create_ai.dw_create_ai.InsertRow( 0 )

tab_1.tabpage_modify_ai.dw_modify_ai_from.Reset( )
tab_1.tabpage_modify_ai.dw_modify_ai_from.InsertRow( 0 )

tab_1.tabpage_modify_ai.dw_modify_ai_to.Reset( )
tab_1.tabpage_modify_ai.dw_modify_ai_to.InsertRow( 0 )

tab_1.tabpage_ai_trigger.dw_ai_trigger.Reset( )
tab_1.tabpage_ai_trigger.dw_ai_trigger.InsertRow( 0 )
end event

type dw_wf_list from u_dw within w_workflow_painter
integer x = 32
integer y = 76
integer width = 1573
integer height = 92
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_work_flow_list"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Of_SetTransObject( SQLCA )
This.InsertRow( 0 )
This.of_setUpdateAble( False )
end event

event itemchanged;call super::itemchanged;il_rec_id =  Long(data)

IF Not IsNull( il_rec_id ) THEN
	tab_1.tabpage_setup.dw_setup.Reset( )
	tab_1.tabpage_create_ai.dw_create_ai.Reset()
	tab_1.tabpage_ai_trigger.dw_ai_trigger.Reset()
	tab_1.tabpage_modify_ai.dw_modify_ai_from.Reset()
	tab_1.tabpage_modify_ai.dw_modify_ai_to.Reset()
	
	tab_1.tabpage_setup.dw_setup.Retrieve( il_rec_id )
	tab_1.tabpage_create_ai.dw_create_ai.Retrieve( il_rec_id, "Create" )
	tab_1.tabpage_ai_trigger.dw_ai_trigger.Retrieve( il_rec_id, "Trigger" )
	tab_1.tabpage_modify_ai.dw_modify_ai_from.Retrieve( il_rec_id, "Mod_From" )
	tab_1.tabpage_modify_ai.dw_modify_ai_to.Retrieve( il_rec_id, "Mod_To" )		
END IF
end event

type st_1 from statictext within w_workflow_painter
integer x = 41
integer y = 20
integer width = 448
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Work Flow"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_workflow_painter
integer x = 2171
integer y = 80
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

