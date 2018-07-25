$PBExportHeader$w_wv_esign_log_audit_org.srw
forward
global type w_wv_esign_log_audit_org from window
end type
type dw_date_range from u_dw within w_wv_esign_log_audit_org
end type
type cb_2 from commandbutton within w_wv_esign_log_audit_org
end type
type dw_1 from datawindow within w_wv_esign_log_audit_org
end type
type cb_close from commandbutton within w_wv_esign_log_audit_org
end type
type cb_search from commandbutton within w_wv_esign_log_audit_org
end type
end forward

global type w_wv_esign_log_audit_org from window
integer width = 4160
integer height = 2400
boolean titlebar = true
string title = "WebView Esign Log"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_date_range dw_date_range
cb_2 cb_2
dw_1 dw_1
cb_close cb_close
cb_search cb_search
end type
global w_wv_esign_log_audit_org w_wv_esign_log_audit_org

forward prototypes
public function string of_get_dates ()
end prototypes

public function string of_get_dates ();date ld_from
date ld_to
datetime ldt_from
datetime ldt_to
string ls_datefield
string ls_filter

dw_date_range.accepttext()
ld_from  = dw_date_range.getitemdate(1,"from_date")
ld_to  = dw_date_range.getitemdate(1,"to_date")

if isnull(ld_from ) and isnull(ld_to) then
	return ""
end if

ls_datefield = "user_date"

if not isnull( ld_from) then
	ls_filter = " "  + ls_datefield + " >= '" + string(ld_from, "yyyy/mm/dd") + " 00:00:00'"
end if

if not isnull(ld_from ) and not isnull(ld_to) then
	ls_filter = ls_filter + " and "
end if

if not isnull( ld_to) then
	ls_filter =  ls_filter + " "  + ls_datefield + " <= '" + string(ld_to, "yyyy/mm/dd") + " 23:59:59'"
end if

//messagebox("",ls_filter)

return ls_filter
end function

on w_wv_esign_log_audit_org.create
this.dw_date_range=create dw_date_range
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_search=create cb_search
this.Control[]={this.dw_date_range,&
this.cb_2,&
this.dw_1,&
this.cb_close,&
this.cb_search}
end on

on w_wv_esign_log_audit_org.destroy
destroy(this.dw_date_range)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_search)
end on

event open;dw_1.settransobject(sqlca)
end event

event resize;//---------Begin Added by (Appeon)Stephen 12.29.2015 for BugS122202--------
dw_1.width = newwidth - 180
dw_1.height = newheight - 250
//---------End Added ------------------------------------------------------
end event

type dw_date_range from u_dw within w_wv_esign_log_audit_org
integer x = 73
integer y = 60
integer width = 1527
integer height = 100
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_date_range_get_blue"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.insertrow(1)
this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
this.of_setupdateable( false)
end event

type cb_2 from commandbutton within w_wv_esign_log_audit_org
boolean visible = false
integer x = 3173
integer y = 80
integer width = 398
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select Providers"
end type

type dw_1 from datawindow within w_wv_esign_log_audit_org
integer x = 64
integer y = 200
integer width = 3931
integer height = 2024
integer taborder = 30
string title = "none"
string dataobject = "d_esign_log_audit"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_close from commandbutton within w_wv_esign_log_audit_org
integer x = 3666
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_search from commandbutton within w_wv_esign_log_audit_org
integer x = 1650
integer y = 52
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
end type

event clicked;string ls_sql
string ls_sql_org
string ls_where
string ls_dates


dw_1.SetTransObject( SQLCA )
ls_sql_org = dw_1.GetSQLSelect()
ls_sql = ls_sql_org

//ls_where = of_set_where( )

//date range
ls_dates = of_get_dates()
if len(ls_dates) > 1 then
	ls_where= ls_where + " and " +  ls_dates 
end if

if ls_where = "0" then return

ls_sql = ls_sql + ls_where
dw_1.SetSQlSelect( ls_sql )
dw_1.SetTransObject( SQLCA )
dw_1.Retrieve( )
 
dw_1.SetSQlSelect( ls_sql_org ) 

end event

