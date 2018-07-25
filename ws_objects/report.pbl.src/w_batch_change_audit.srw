$PBExportHeader$w_batch_change_audit.srw
forward
global type w_batch_change_audit from window
end type
type dw_select_user from datawindow within w_batch_change_audit
end type
type st_1 from statictext within w_batch_change_audit
end type
type cb_4 from commandbutton within w_batch_change_audit
end type
type dw_data from datawindow within w_batch_change_audit
end type
type cb_1 from commandbutton within w_batch_change_audit
end type
type dw_date_range from u_dw within w_batch_change_audit
end type
type cb_filter from commandbutton within w_batch_change_audit
end type
end forward

global type w_batch_change_audit from window
integer width = 3195
integer height = 1956
boolean titlebar = true
string title = "IntelliBatch update log"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_select_user dw_select_user
st_1 st_1
cb_4 cb_4
dw_data dw_data
cb_1 cb_1
dw_date_range dw_date_range
cb_filter cb_filter
end type
global w_batch_change_audit w_batch_change_audit

type variables
string is_original_sql
end variables

forward prototypes
public subroutine of_filter ()
end prototypes

public subroutine of_filter ();String ls_sql = "Where "
String ls_user
String ls_from_date
String ls_to_date


//messagebox("", is_original_sql )
ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

if ls_user = "AutoUpdate" then ls_user = "Auto Update"

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " user_id = '" + ls_user + "'"
END IF

dw_date_range.AcceptText()


ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	if len( ls_sql) > 8 then ls_sql+= " AND "
	//---------Begin Modified by (Appeon)Stephen 11.19.2013 for BugS103001--------
	//ls_sql = ls_sql + " convert(datetime,  convert( varchar, change_date,102) )  >= " + ls_from_date
	ls_from_date = "'" + ls_from_date + " 00:00:00" +"'"
	ls_sql = ls_sql + "change_date  >= " + ls_from_date
	//---------End Modfiied ------------------------------------------------------	
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	if len( ls_sql) > 8 then ls_sql+= " AND "
	//---------Begin Modified by (Appeon)Stephen 11.19.2013 for BugS103001--------
	//ls_sql = ls_sql + " convert(datetime, convert( varchar, change_date,102) )  <= " + ls_to_date 
	ls_to_date = "'" + ls_to_date + " 23:59:59" + "'" 
	ls_sql = ls_sql + " change_date  <= " + ls_to_date 
	//---------End Modfiied ------------------------------------------------------
	
END IF


if ls_sql = "Where " then ls_sql = ""
ls_sql = is_original_sql + ls_sql

//messagebox("", ls_sql )

dw_data.SetSQLSelect ( ls_sql )
dw_data.SetTransObject( SQLCA )
dw_data.Retrieve()
end subroutine

on w_batch_change_audit.create
this.dw_select_user=create dw_select_user
this.st_1=create st_1
this.cb_4=create cb_4
this.dw_data=create dw_data
this.cb_1=create cb_1
this.dw_date_range=create dw_date_range
this.cb_filter=create cb_filter
this.Control[]={this.dw_select_user,&
this.st_1,&
this.cb_4,&
this.dw_data,&
this.cb_1,&
this.dw_date_range,&
this.cb_filter}
end on

on w_batch_change_audit.destroy
destroy(this.dw_select_user)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.dw_data)
destroy(this.cb_1)
destroy(this.dw_date_range)
destroy(this.cb_filter)
end on

type dw_select_user from datawindow within w_batch_change_audit
integer x = 50
integer y = 68
integer width = 485
integer height = 96
integer taborder = 50
string title = "none"
string dataobject = "d_select_user_for_audit_trail"
boolean border = false
boolean livescroll = true
end type

event constructor;
This.SetTransObject( SQLCA )
This.InsertRow( 0 )

DataWindowChild dwchild

This.GetChild( "user_id", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "user_id", "AutoUpdate" )
This.SetItem( 1, "user_id", "AutoUpdate" )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "user_id", "All" )
This.SetItem( 1, "user_id", "All" )
end event

type st_1 from statictext within w_batch_change_audit
integer x = 82
integer y = 12
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select User"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_batch_change_audit
integer x = 1504
integer y = 56
integer width = 325
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;//Start Code Change ----05.15.2009 #V92 maha - added
datetime ldt_null

setnull(ldt_null)

dw_select_user.setitem(1,"user_id","All")
dw_date_range.setitem(1,"from_date",ldt_null)
dw_date_range.setitem(1,"to_date",ldt_null)


end event

type dw_data from datawindow within w_batch_change_audit
integer x = 69
integer y = 200
integer width = 3008
integer height = 1580
integer taborder = 40
string title = "none"
string dataobject = "d_batch_change_log"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
is_original_sql = this.Object.DataWindow.Table.Select
end event

type cb_1 from commandbutton within w_batch_change_audit
integer x = 2743
integer y = 56
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_date_range from u_dw within w_batch_change_audit
integer x = 526
integer y = 8
integer width = 946
integer height = 144
integer taborder = 10
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event itemchanged;call super::itemchanged;//wf_reset_st_run( )
end event

type cb_filter from commandbutton within w_batch_change_audit
integer x = 1911
integer y = 56
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Filter"
end type

event clicked;of_filter()
end event

