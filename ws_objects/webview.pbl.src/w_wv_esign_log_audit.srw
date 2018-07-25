$PBExportHeader$w_wv_esign_log_audit.srw
forward
global type w_wv_esign_log_audit from w_main
end type
type cb_8 from uo_cb_output within w_wv_esign_log_audit
end type
type cb_search from commandbutton within w_wv_esign_log_audit
end type
type cb_close from commandbutton within w_wv_esign_log_audit
end type
type cb_2 from commandbutton within w_wv_esign_log_audit
end type
type dw_date_range from u_dw within w_wv_esign_log_audit
end type
type dw_1 from u_dw within w_wv_esign_log_audit
end type
end forward

global type w_wv_esign_log_audit from w_main
integer width = 4096
integer height = 2344
long backcolor = 33551856
cb_8 cb_8
cb_search cb_search
cb_close cb_close
cb_2 cb_2
dw_date_range dw_date_range
dw_1 dw_1
end type
global w_wv_esign_log_audit w_wv_esign_log_audit

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

event open;call super::open;//Start Code Change ----11.18.2016 #V153 maha - recreated screen
dw_1.settransobject(sqlca)
end event

event resize;call super::resize;//---------Begin Added by (Appeon)Stephen 12.29.2015 for BugS122202--------
dw_1.width = newwidth - 20
dw_1.height = newheight - 156 - 10
//---------End Added ------------------------------------------------------
end event

on w_wv_esign_log_audit.create
int iCurrent
call super::create
this.cb_8=create cb_8
this.cb_search=create cb_search
this.cb_close=create cb_close
this.cb_2=create cb_2
this.dw_date_range=create dw_date_range
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_8
this.Control[iCurrent+2]=this.cb_search
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_date_range
this.Control[iCurrent+6]=this.dw_1
end on

on w_wv_esign_log_audit.destroy
call super::destroy
destroy(this.cb_8)
destroy(this.cb_search)
destroy(this.cb_close)
destroy(this.cb_2)
destroy(this.dw_date_range)
destroy(this.dw_1)
end on

type cb_8 from uo_cb_output within w_wv_esign_log_audit
integer x = 3072
integer y = 28
integer width = 416
integer height = 84
integer taborder = 30
end type

event clicked;

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
//NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
gnv_app.of_popmenu(this,NewMenu.m_options)//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
//this calls events in u_dw
//the save as pdf calls ...
end event

event constructor;call super::constructor;idw = dw_1
end event

type cb_search from commandbutton within w_wv_esign_log_audit
integer x = 1623
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
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

type cb_close from commandbutton within w_wv_esign_log_audit
integer x = 3671
integer y = 24
integer width = 343
integer height = 92
integer taborder = 10
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

type cb_2 from commandbutton within w_wv_esign_log_audit
boolean visible = false
integer x = 2167
integer y = 92
integer width = 197
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select Providers"
end type

type dw_date_range from u_dw within w_wv_esign_log_audit
integer x = 46
integer y = 24
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

type dw_1 from u_dw within w_wv_esign_log_audit
integer x = 14
integer y = 156
integer width = 4032
integer height = 2076
integer taborder = 10
string dataobject = "d_esign_log_audit"
boolean hscrollbar = true
end type

