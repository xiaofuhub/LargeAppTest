$PBExportHeader$w_text_log.srw
forward
global type w_text_log from w_popup
end type
type cb_reset from commandbutton within w_text_log
end type
type st_7 from statictext within w_text_log
end type
type dw_date_range from u_dw within w_text_log
end type
type dw_select_user from u_dw within w_text_log
end type
type cb_filter from commandbutton within w_text_log
end type
type cb_sort from commandbutton within w_text_log
end type
type cb_run from commandbutton within w_text_log
end type
type cb_1 from commandbutton within w_text_log
end type
type dw_audit from u_dw within w_text_log
end type
type gb_filters from groupbox within w_text_log
end type
end forward

global type w_text_log from w_popup
integer x = 214
integer y = 221
integer width = 3794
integer height = 1812
string title = "Text Logs"
long backcolor = 33551856
boolean center = true
cb_reset cb_reset
st_7 st_7
dw_date_range dw_date_range
dw_select_user dw_select_user
cb_filter cb_filter
cb_sort cb_sort
cb_run cb_run
cb_1 cb_1
dw_audit dw_audit
gb_filters gb_filters
end type
global w_text_log w_text_log

type variables
string is_original_sql
end variables

on w_text_log.create
int iCurrent
call super::create
this.cb_reset=create cb_reset
this.st_7=create st_7
this.dw_date_range=create dw_date_range
this.dw_select_user=create dw_select_user
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.cb_run=create cb_run
this.cb_1=create cb_1
this.dw_audit=create dw_audit
this.gb_filters=create gb_filters
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reset
this.Control[iCurrent+2]=this.st_7
this.Control[iCurrent+3]=this.dw_date_range
this.Control[iCurrent+4]=this.dw_select_user
this.Control[iCurrent+5]=this.cb_filter
this.Control[iCurrent+6]=this.cb_sort
this.Control[iCurrent+7]=this.cb_run
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.dw_audit
this.Control[iCurrent+10]=this.gb_filters
end on

on w_text_log.destroy
call super::destroy
destroy(this.cb_reset)
destroy(this.st_7)
destroy(this.dw_date_range)
destroy(this.dw_select_user)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.cb_run)
destroy(this.cb_1)
destroy(this.dw_audit)
destroy(this.gb_filters)
end on

event resize;call super::resize;//(Appeon)Stephen 07.05.2017 - BugS063001

dw_audit.width = newwidth - 20
dw_audit.height = newheight - 250
end event

type cb_reset from commandbutton within w_text_log
integer x = 1550
integer y = 108
integer width = 325
integer height = 80
integer taborder = 50
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

type st_7 from statictext within w_text_log
integer x = 82
integer y = 60
integer width = 430
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Sent by User"
boolean focusrectangle = false
end type

type dw_date_range from u_dw within w_text_log
integer x = 562
integer y = 52
integer width = 946
integer height = 144
integer taborder = 80
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event editchanged;call super::editchanged;//---------Begin Added by (Appeon)Harry 11.24.2014 for BugH101101--------
DateTime ldt_null
If IsNull(data) or data = "" Then
	SetNull(ldt_null)
	Choose Case dwo.name
		Case 'from_date'
			this.setitem(1, 'from_date', ldt_null)
		Case 'to_date'
			this.setitem(1, 'to_date', ldt_null)
	End Choose
End If
//---------End Added ------------------------------------------------------


end event

type dw_select_user from u_dw within w_text_log
integer x = 78
integer y = 112
integer width = 462
integer height = 84
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_select_user_for_audit_trail"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

DataWindowChild dwchild

This.GetChild( "user_id", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "user_id", "All" )

This.SetItem( 1, "user_id", "All" )
end event

type cb_filter from commandbutton within w_text_log
integer x = 2638
integer y = 108
integer width = 274
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;
//---------Begin Modified by (Appeon)Stephen 07.05.2017 for BugS063001--------
/*
string null_str

SetNull(null_str)

dw_audit.SetFilter(null_str)

dw_audit.Filter()

string null_str
*/
if dw_audit.DataObject = "" then return

String    ls_exclude[ ]

ls_exclude[1] = "compute_2"
ls_exclude[2] = "compute_1"

dw_audit.inv_filter.of_SetExclude(ls_exclude)
dw_audit.inv_filter.of_SetStyle (dw_audit.inv_filter.EXTENDED)
dw_audit.Event pfc_FilterDlg()
dw_audit.Sort()
dw_audit.groupcalc()

dw_audit.SetFocus()
//---------End Modfiied ------------------------------------------------------

end event

type cb_sort from commandbutton within w_text_log
integer x = 2359
integer y = 108
integer width = 274
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;//---------Begin Added by (Appeon)Stephen 07.05.2017 for BugS063001--------
/*
string null_str

SetNull(null_str)

dw_audit.Setsort(null_str)

dw_audit.Sort()
*/
dw_audit.inv_sort.of_setstyle(dw_audit.inv_sort.dragdrop  )
dw_audit.Event pfc_SortDlg()

dw_audit.SetFocus()
//---------End Added ------------------------------------------------------

end event

type cb_run from commandbutton within w_text_log
integer x = 1915
integer y = 108
integer width = 306
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Filter"
end type

event clicked;String ls_sql
String ls_user
String ls_from_date
String ls_to_date
integer r

is_original_sql = dw_audit.GetSQLSelect ( )



ls_user =  dw_select_user.GetItemString( 1, "user_id" )
//ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " AND sys_text_log.sent_by = '" + ls_user + "'"
END IF


dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		 //--------------------------- APPEON BEGIN ---------------------------
		 //$<modify> 2005-11-15 By: Zhang Lingping
		 //$<reason>  The database function date is unsupported in SQL Server. 
		 //$<reason>  It need be replace with dabase function "convert".
		 
		 //ls_sql = ls_sql + " AND Date(sys_audit.date_time_modified)  >= " + ls_from_date +&
		 //					" AND Date(sys_audit.date_time_modified)  <= " + ls_to_date 
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, sys_text_log.sent_time,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_text_log.sent_time,102) )  <= " + ls_to_date 
		 //---------------------------- APPEON END ----------------------------
	END IF
END IF

ls_sql = is_original_sql + ls_sql


r = dw_audit.SetSQLSelect ( ls_sql )
if r < 0 then openwithparm(w_sql_msg, ls_sql)

dw_audit.SetTransObject( SQLCA )
r = dw_audit.Retrieve()
if r < 0 then openwithparm(w_sql_msg, ls_sql)

dw_audit.SetSQLSelect ( is_original_sql )


return 0
end event

type cb_1 from commandbutton within w_text_log
integer x = 3351
integer y = 108
integer width = 343
integer height = 80
integer taborder = 20
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

type dw_audit from u_dw within w_text_log
integer x = 5
integer y = 224
integer width = 3717
integer height = 1472
integer taborder = 10
string dataobject = "d_texting_log"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//(Appeon)Stephen 07.05.2017 - BugS063001
This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(2)
This.inv_Filter.of_SetColumnDisplayNameStyle( 2 )

This.inv_sort.of_SetColumnHeader(True)

end event

type gb_filters from groupbox within w_text_log
integer x = 18
integer y = 16
integer width = 1883
integer height = 196
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters:"
end type

