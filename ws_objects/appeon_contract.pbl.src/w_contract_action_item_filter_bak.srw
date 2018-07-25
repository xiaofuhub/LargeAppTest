$PBExportHeader$w_contract_action_item_filter_bak.srw
forward
global type w_contract_action_item_filter_bak from window
end type
type cb_2 from commandbutton within w_contract_action_item_filter_bak
end type
type cb_1 from commandbutton within w_contract_action_item_filter_bak
end type
type cb_filter from commandbutton within w_contract_action_item_filter_bak
end type
type dw_filter from u_dw_contract within w_contract_action_item_filter_bak
end type
end forward

global type w_contract_action_item_filter_bak from window
integer x = 27
integer y = 2088
integer width = 2747
integer height = 916
boolean titlebar = true
string title = "Filter"
windowtype windowtype = popup!
long backcolor = 81324524
boolean center = true
event ue_post_open ( )
cb_2 cb_2
cb_1 cb_1
cb_filter cb_filter
dw_filter dw_filter
end type
global w_contract_action_item_filter_bak w_contract_action_item_filter_bak

type variables
Datawindow idw_action_item
end variables

on w_contract_action_item_filter_bak.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_filter=create cb_filter
this.dw_filter=create dw_filter
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_filter,&
this.dw_filter}
end on

on w_contract_action_item_filter_bak.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_filter)
destroy(this.dw_filter)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Implement new requirement for Contract Logix.

IF Isvalid(Message.PowerobjectParm) THEN
	idw_action_item = Message.PowerobjectParm
	
	dw_filter.of_SetDropDownCalendar(TRUE)

ELSE
	CLOSE(THIS)
END IF
	
//---------------------------- APPEON END ----------------------------

end event

event close;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Implement new requirement for Contract Logix.
cb_1.Triggerevent( clicked! )
//---------------------------- APPEON END ----------------------------

end event

type cb_2 from commandbutton within w_contract_action_item_filter_bak
integer x = 2350
integer y = 356
integer width = 352
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Implement new requirement for Contract Logix.
Close( Parent )
//---------------------------- APPEON END ----------------------------


end event

type cb_1 from commandbutton within w_contract_action_item_filter_bak
integer x = 2350
integer y = 76
integer width = 352
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Filter"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Implement new requirement for Contract Logix.

dw_filter.Reset()
dw_filter.InsertRow( 0 )
if Isvalid(idw_action_item) then
	idw_action_item.SetFilter("")
	idw_action_item.Filter()
end if
//---------------------------- APPEON END ----------------------------

end event

type cb_filter from commandbutton within w_contract_action_item_filter_bak
integer x = 2350
integer y = 216
integer width = 352
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Apply Filter"
boolean default = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Implement new requirement for Contract Logix.

Long ll_act_type 
Long ll_act_status 
String ls_act_user
String ls_new_sql
Datetime ldt_act_date,ldt_act_date1
Datetime ldt_due_date,ldt_due_date1

// Initial
dw_filter.AcceptText()
dw_filter.SetColumn( "action_type" )
ls_new_sql = "1=1"

// Get Filter condition
ll_act_type = dw_filter.GetitemNumber(1, "action_type")
ls_act_user = dw_filter.GetitemString(1, "action_user")
ll_act_status = dw_filter.GetitemNumber(1, "action_status")
ldt_act_date = dw_filter.GetitemDatetime(1, "action_date")
ldt_act_date1 = dw_filter.GetitemDatetime(1, "action_date_1")
ldt_due_date = dw_filter.GetitemDatetime(1, "due_date")
ldt_due_date1 = dw_filter.GetitemDatetime(1, "due_date_1")

// Set Filter condition
IF Not IsNull( ll_act_type ) AND ll_act_type > 0 THEN
	ls_new_sql = ls_new_sql + " AND action_type = " + String( ll_act_type )
END IF

IF Not IsNull( ls_act_user ) AND LEN(ls_act_user) > 0 THEN
	ls_new_sql = ls_new_sql + " AND action_user = '" + ls_act_user + "'"
END IF

IF Not IsNull( ll_act_status ) THEN
	ls_new_sql = ls_new_sql + " AND action_status = " + String( ll_act_status )
END IF

IF Not IsNull( ldt_act_date ) THEN
	ls_new_sql = ls_new_sql + " AND action_date >= Date('" + String( Date( ldt_act_date ), "yyyy-mm-dd" ) + "')"
END IF

IF Not IsNull( ldt_act_date1 ) THEN
	ls_new_sql = ls_new_sql + " AND action_date <= Date('" + String( Date( ldt_act_date1 ), "yyyy-mm-dd" ) + "')"
END IF

IF Not IsNull( ldt_due_date ) THEN
	ls_new_sql = ls_new_sql + " AND due_date >= Date('" + String( Date( ldt_due_date ), "yyyy-mm-dd" ) + "')"
END IF

IF Not IsNull( ldt_due_date1 ) THEN
	ls_new_sql = ls_new_sql + " AND due_date <= Date('" + String( Date( ldt_due_date1 ), "yyyy-mm-dd" ) + "')"
END IF

// Filter Action item
idw_action_item.SetFilter(ls_new_sql)
idw_action_item.Filter()

//---------------------------- APPEON END ----------------------------

end event

type dw_filter from u_dw_contract within w_contract_action_item_filter_bak
integer width = 2318
integer height = 352
integer taborder = 10
string dataobject = "d_contract_action_items_filter"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Implement new requirement for Contract Logix.

This.InsertRow( 0 )

//setup filter data window
dw_filter.of_SetUpdateAble( False )

//dw_filter.of_SetRowManager( TRUE )
//dw_filter.of_SetReqColumn(TRUE)
dw_filter.of_SetTransObject(SQLCA)

This.event ue_populatedddws( )

//---------------------------- APPEON END ----------------------------

end event

