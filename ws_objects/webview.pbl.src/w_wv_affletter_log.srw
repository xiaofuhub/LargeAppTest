$PBExportHeader$w_wv_affletter_log.srw
forward
global type w_wv_affletter_log from w_response
end type
type cb_output from uo_cb_output within w_wv_affletter_log
end type
type cb_1 from commandbutton within w_wv_affletter_log
end type
type dw_dates from u_dw within w_wv_affletter_log
end type
type cb_close from commandbutton within w_wv_affletter_log
end type
type dw_1 from u_dw within w_wv_affletter_log
end type
end forward

global type w_wv_affletter_log from w_response
integer width = 4768
integer height = 2064
string title = "WV Affiliation Letter Log"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_output cb_output
cb_1 cb_1
dw_dates dw_dates
cb_close cb_close
dw_1 dw_1
end type
global w_wv_affletter_log w_wv_affletter_log

on w_wv_affletter_log.create
int iCurrent
call super::create
this.cb_output=create cb_output
this.cb_1=create cb_1
this.dw_dates=create dw_dates
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_output
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_dates
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_1
end on

on w_wv_affletter_log.destroy
call super::destroy
destroy(this.cb_output)
destroy(this.cb_1)
destroy(this.dw_dates)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type cb_output from uo_cb_output within w_wv_affletter_log
integer x = 3941
integer y = 24
integer width = 416
integer height = 84
integer taborder = 20
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

type cb_1 from commandbutton within w_wv_affletter_log
integer x = 1394
integer y = 12
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Filter"
end type

event clicked;string ls_from
string ls_to
string ls_where
integer li_final
string ls_field
string ls_sql
string ls_org


dw_dates.accepttext()
ls_from = string(dw_dates.getitemdate(1,"from_date"),"yyyy-mm-dd")
//messagebox("ls_from", ls_from)
ls_to = string(dw_dates.getitemdate(1,"to_date"),"yyyy-mm-dd")
//messagebox("ls_to", ls_to)

if  len(ls_from) > 0 then
	ls_where = " and ( audit_date >= '" + ls_from + " 00:00:00')"
end if

if  len(ls_to) > 0 then
	ls_where+= " and (audit_date <= '" + ls_to + " 23:59:59')"
end if

if len(ls_where) > 0 then
	ls_sql = dw_1.getsqlselect()
	ls_org = ls_sql
	ls_sql+= ls_where
	dw_1.setsqlselect(ls_sql)
	dw_1.settransobject(sqlca)
	dw_1.retrieve() 
	dw_1.setsqlselect(ls_org)
else
	dw_1.retrieve()
end if
end event

type dw_dates from u_dw within w_wv_affletter_log
integer x = 50
integer y = 12
integer width = 1271
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_date_range_gets"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event clicked;string ls_coltype
//debugbreak()
//If isvalid(iuo_Calendar) Then
//	ls_coltype = this.Describe(dwo.name+".ColType")	
//	If ls_coltype = 'date' or ls_coltype = 'datetime' Then
//		iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
//	End If
//End If

//iuo_Calendar.of_Register("from_date", iuo_Calendar.DDLB_WITHARROW)
//iuo_Calendar.of_Register("to_date", iuo_Calendar.DDLB_WITHARROW)
end event

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type cb_close from commandbutton within w_wv_affletter_log
integer x = 4393
integer y = 20
integer width = 347
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

event clicked;close(parent)
end event

type dw_1 from u_dw within w_wv_affletter_log
integer y = 124
integer width = 4750
integer height = 1852
integer taborder = 10
string dataobject = "d_wv_affletter_log_w_user"
end type

event constructor;call super::constructor;this.of_settransobject(sqlca)
this.of_setupdateable( false)
end event

