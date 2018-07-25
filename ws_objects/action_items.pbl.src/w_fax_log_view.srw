$PBExportHeader$w_fax_log_view.srw
forward
global type w_fax_log_view from pfc_w_response
end type
type cb_close from commandbutton within w_fax_log_view
end type
type cb_del from commandbutton within w_fax_log_view
end type
type cb_sele from commandbutton within w_fax_log_view
end type
type cb_reset from commandbutton within w_fax_log_view
end type
type dw_date_range from u_dw within w_fax_log_view
end type
type cb_log from commandbutton within w_fax_log_view
end type
type rb_all from radiobutton within w_fax_log_view
end type
type rb_fail from radiobutton within w_fax_log_view
end type
type rb_pend from radiobutton within w_fax_log_view
end type
type rb_sent from radiobutton within w_fax_log_view
end type
type cb_find from commandbutton within w_fax_log_view
end type
type dw_2 from datawindow within w_fax_log_view
end type
type dw_1 from datawindow within w_fax_log_view
end type
type gb_1 from groupbox within w_fax_log_view
end type
type gb_2 from groupbox within w_fax_log_view
end type
end forward

global type w_fax_log_view from pfc_w_response
integer width = 4251
integer height = 2496
string title = "Fax Log"
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_del cb_del
cb_sele cb_sele
cb_reset cb_reset
dw_date_range dw_date_range
cb_log cb_log
rb_all rb_all
rb_fail rb_fail
rb_pend rb_pend
rb_sent rb_sent
cb_find cb_find
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_fax_log_view w_fax_log_view

type variables
string is_status = 'all'
boolean ib_log = false
end variables

forward prototypes
public function integer of_status_filter ()
public function integer of_get_msfax_log ()
end prototypes

public function integer of_status_filter ();//////////////////////////////////////////////////////////////////////
// $<Event> rowfocuschanged
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_from_date, ls_to_date
string ls_filter

if dw_date_range.accepttext() = -1 then return -1
ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ls_filter = ''
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_from_date = ls_from_date + " 00:00:00"
	ls_filter =  "sub_time >="+ls_from_date
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_filter = ls_filter +" and sub_time <= "+ls_to_date
	end if
	
elseif  ls_to_date <>'' and not isnull(ls_to_date) then
	ls_to_date = ls_to_date + " 23:59:59"
	ls_filter = " sub_time <= "+ ls_to_date
else
	ls_filter = '1 = 1 '
end if

dw_2.setredraw(false)
dw_2.setfilter("1=1")
dw_2.filter()
if is_status = 'all'  or isnull(is_status) then	
else
	ls_filter = ls_filter +" and status = '"+is_status+"' "
end if
dw_2.setfilter(ls_filter)
dw_2.filter()
dw_2.setredraw(true)

return 1
end function

public function integer of_get_msfax_log ();//////////////////////////////////////////////////////////////////////
// $<Function> of_get_msfax_log
// $<arguments>
// $<returns> integer
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_cnt, li_ret, li_col
n_cst_msfax nvo_msfax
str_msfax_log lstr_log
string ls_doc_id

nvo_msfax = Create n_cst_msfax

dw_1.setredraw(false)
dw_1.retrieve()
dw_2.setredraw(false)
li_ret = nvo_msfax.of_get_log(lstr_log)
if li_ret < 1 then 
	ib_log = false
	dw_2.setredraw(true)
	dw_1.setredraw(true)
	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait) //add by stephen 05.02.2012 -add the w_appeon_gifofwait window during retrieve the log data
	return li_ret
end if

for li_cnt = 1 to upperbound(lstr_log.job_id)
	li_col = dw_2.insertrow(0)
	dw_2.setitem(li_col, 'job_id', lstr_log.job_id[li_cnt])
	dw_2.setitem(li_col, 'subject', lstr_log.subject[li_cnt])
	dw_2.setitem(li_col, 'rec_name', lstr_log.rec_name[li_cnt])
	dw_2.setitem(li_col, 'sub_time',  lstr_log.sub_time[li_cnt])
	dw_2.setitem(li_col, 'rec_num', lstr_log.rec_num[li_cnt])
	dw_2.setitem(li_col, 'status', lstr_log.status[li_cnt])
	dw_2.setitem(li_col, 'doc_name', lstr_log.doc_name[li_cnt])
next

ib_log = true
for li_cnt = dw_2.rowcount() to 1 step -1
	ls_doc_id = dw_2.getitemstring(li_cnt , 'doc_name')	
	setnull(li_col)
	li_col = dw_1.find("doc_id = '"+ls_doc_id+"'",1, dw_1.rowcount())
	if li_col < 1 or isnull(li_col) then
		dw_2.deleterow(li_cnt)
	end if
next

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait) //add by stephen 05.02.2012 -add the w_appeon_gifofwait window during retrieve the log data

dw_2.setsort("sub_time desc")
dw_2.sort()

dw_1.setredraw(true)
dw_2.setredraw(true)
if dw_2.rowcount() > 1 then
	dw_2.selectrow(0, false)
	dw_2.selectrow(1, true)
end if

return 1
end function

on w_fax_log_view.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_del=create cb_del
this.cb_sele=create cb_sele
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.cb_log=create cb_log
this.rb_all=create rb_all
this.rb_fail=create rb_fail
this.rb_pend=create rb_pend
this.rb_sent=create rb_sent
this.cb_find=create cb_find
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_del
this.Control[iCurrent+3]=this.cb_sele
this.Control[iCurrent+4]=this.cb_reset
this.Control[iCurrent+5]=this.dw_date_range
this.Control[iCurrent+6]=this.cb_log
this.Control[iCurrent+7]=this.rb_all
this.Control[iCurrent+8]=this.rb_fail
this.Control[iCurrent+9]=this.rb_pend
this.Control[iCurrent+10]=this.rb_sent
this.Control[iCurrent+11]=this.cb_find
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
end on

on w_fax_log_view.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_del)
destroy(this.cb_sele)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.cb_log)
destroy(this.rb_all)
destroy(this.rb_fail)
destroy(this.rb_pend)
destroy(this.rb_sent)
destroy(this.cb_find)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<Event> open
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.18.2011 by Stephen
//////////////////////////////////////////////////////////////////////

IF  w_mdi.of_security_access(7220)  = 0 THEN
	cb_del.enabled = false
	cb_sele.enabled = false
	cb_del.visible = false
	cb_sele.visible = false
end if
end event

type cb_close from commandbutton within w_fax_log_view
integer x = 3863
integer y = 56
integer width = 325
integer height = 92
integer taborder = 60
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

type cb_del from commandbutton within w_fax_log_view
integer x = 379
integer y = 200
integer width = 421
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Selected"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>Delete Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.18.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long   ll_cnt, ll_find
string ls_docid, ls_sel
boolean lb_msg

if dw_1.rowcount() < 1 then return

dw_1.setredraw(false)
dw_2.setredraw(false)
lb_msg = false

dw_1.selectrow(0, false)
for ll_cnt = dw_1.rowcount() to 1 step -1
	ls_sel = dw_1.getitemstring(ll_cnt , 'sel' )
	if ls_sel = '1' then
		
		if lb_msg = false then
			if MessageBox("Delete Row", "Are you sure you want to delete the selected rows?", Question!, YesNo!, 2 ) = 2 then
				dw_1.setredraw(true)
				dw_2.setredraw(true)
				return
			end if
			lb_msg = true
		end if
		

		ll_find = 0
		ls_docid = dw_1.getitemstring(ll_cnt , 'doc_id')
		ll_find = dw_2.find("doc_name = '"+ls_docid+"'" , 1, dw_2.rowcount() )
		if ll_find > 0 then dw_2.deleterow(ll_find)
		dw_1.deleterow(ll_cnt)
	end if
next

if dw_1.update() = 1 then
	commit using sqlca;
else
	rollback using sqlca;
end if

dw_1.setredraw(true)
dw_2.setredraw(true)
end event

type cb_sele from commandbutton within w_fax_log_view
integer x = 23
integer y = 200
integer width = 320
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.18.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_cnt

if dw_1.rowcount() < 1 then return

if this.text = '&Select All' then
	for ll_cnt = 1 to dw_1.rowcount()
		dw_1.setitem(ll_cnt, 'sel', '1')
	next
	this.text = 'De&select All'
else
	for ll_cnt = 1 to dw_1.rowcount()
		dw_1.setitem(ll_cnt, 'sel', '0')
	next
	this.text = '&Select All'
end if
end event

type cb_reset from commandbutton within w_fax_log_view
integer x = 1230
integer y = 60
integer width = 247
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.15.2011 by Stephen
//////////////////////////////////////////////////////////////////////

if isnull(dw_date_range.GetItemDate( 1, "from_date" )) and dw_1.rowcount() < 1 then return

dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
rb_all.checked = true

dw_2.setfilter("1 =1")
dw_2.filter()
is_status = 'all'
dw_1.Retrieve()



end event

type dw_date_range from u_dw within w_fax_log_view
integer x = 46
integer y = 68
integer width = 1175
integer height = 80
integer taborder = 10
string dataobject = "d_faxlog_date_range"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
this.of_setupdateable(false)
end event

type cb_log from commandbutton within w_fax_log_view
integer x = 3429
integer y = 56
integer width = 402
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_cnt, li_ret, li_col
n_cst_msfax nvo_msfax
str_msfax_log lstr_log
string ls_doc_id, ls_status, ls_jobid

dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
rb_all.checked = true

ib_log = false
nvo_msfax = Create n_cst_msfax
dw_1.setredraw(false)
dw_1.retrieve()

li_ret = nvo_msfax.of_get_log(lstr_log)
if li_ret < 1 then
	dw_1.setredraw(true)
	IF IsValid(w_appeon_gifofwait) THEN close(w_appeon_gifofwait) //add by stephen 05.02.2012 -add the w_appeon_gifofwait window during retrieve the log data
	return li_ret
end if

rb_all.checked = true
dw_2.setredraw(false)
dw_2.reset()

for li_cnt = 1 to upperbound(lstr_log.job_id)
	li_col = dw_2.insertrow(0)
	dw_2.setitem(li_col, 'job_id', lstr_log.job_id[li_cnt])
	dw_2.setitem(li_col, 'subject', lstr_log.subject[li_cnt])
	dw_2.setitem(li_col, 'rec_name', lstr_log.rec_name[li_cnt])
	dw_2.setitem(li_col, 'sub_time', lstr_log.sub_time[li_cnt])
	dw_2.setitem(li_col, 'rec_num', lstr_log.rec_num[li_cnt])
	dw_2.setitem(li_col, 'status', lstr_log.status[li_cnt])
	dw_2.setitem(li_col, 'doc_name', lstr_log.doc_name[li_cnt])
	
next
ib_log = true

for li_cnt = dw_2.rowcount() to 1 step -1
		
	ls_doc_id = dw_2.getitemstring(li_cnt , 'doc_name')	
	setnull(li_col)
	li_col = dw_1.find("doc_id = '"+ls_doc_id+"'",1, dw_1.rowcount())
	if li_col < 1 or isnull(li_col) then
		dw_2.deleterow(li_cnt)
	else
		ls_status =  dw_1.getitemstring(li_col , 'fax_status')	
		if ls_status <>'Sent' or isnull(ls_status) then
			ls_status =  dw_2.getitemstring(li_cnt , 'status')	
			ls_jobid = dw_2.getitemstring(li_cnt , 'job_id')	
			dw_1.setitem(li_col, 'fax_status', ls_status)
			dw_1.setitem(li_col, 'job_id', ls_jobid)
		end if
	end if
next

IF IsValid(w_appeon_gifofwait) THEN close(w_appeon_gifofwait) //add by stephen 05.02.2012 -add the w_appeon_gifofwait window during retrieve the log data

If dw_1.update( ) = 1  THen
	commit using sqlca;
else
	rollback using sqlca;
	dw_2.setredraw(true)
	dw_1.setredraw(true)
	return -1
end if
dw_2.setsort("sub_time desc")
dw_2.sort()

dw_2.setredraw(true)
dw_1.setredraw(true)
if dw_2.rowcount() > 1 then
	dw_2.selectrow(0, false)
	dw_2.selectrow(1, true)
end if

end event

type rb_all from radiobutton within w_fax_log_view
integer x = 1655
integer y = 84
integer width = 174
integer height = 64
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

is_status = 'all'

of_status_filter()
end event

type rb_fail from radiobutton within w_fax_log_view
integer x = 2661
integer y = 80
integer width = 261
integer height = 64
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Failed"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

is_status = 'Failed'

of_status_filter()
end event

type rb_pend from radiobutton within w_fax_log_view
integer x = 2267
integer y = 80
integer width = 279
integer height = 64
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Pending"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

is_status = 'Pending'

of_status_filter()
end event

type rb_sent from radiobutton within w_fax_log_view
integer x = 1934
integer y = 80
integer width = 247
integer height = 64
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sent"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

is_status = 'Sent'

of_status_filter()
end event

type cb_find from commandbutton within w_fax_log_view
integer x = 2990
integer y = 56
integer width = 389
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Get Log Data"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_from_date, ls_to_date
string ls_sql , ls_old_sql, ls_filter
datetime ldt_from, ldt_to

if dw_date_range.accepttext() =-1 then return
ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ls_old_sql = dw_1.getsqlselect()
ls_sql = ls_old_sql
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_from_date = ls_from_date + " 00:00:00"
	ls_sql = ls_sql + " where sent_time >= '" + ls_from_date +"'"
	
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_sql = ls_sql + " and  sent_time <= '" + ls_to_date	+"'"
	end if
else
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_sql = ls_sql + " where  sent_time <= '" + ls_to_date	+"'"
	end if
end if

dw_1.setredraw(false)
if ib_log = false then
	of_get_msfax_log()
end if

dw_1.SetSQLSelect ( ls_sql )
dw_1.SetTransObject( SQLCA )
dw_1.Retrieve()

dw_1.Modify('DataWindow.Table.Select="'+ls_old_sql + '"')
dw_1.SetTransObject( SQLCA )

dw_2.setredraw(false)
dw_2.setfilter("1=1")
dw_2.filter()
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_filter = "sub_time >="+ls_from_date
	
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_filter = ls_filter + " and sub_time <="+ls_to_date
	end if
elseif  ls_to_date <>'' and not isnull(ls_to_date) then
	ls_filter =  "sub_time <="+ls_to_date
else
	ls_filter = "1 = 1 "
end if

if is_status = 'all'  or isnull(is_status) then
	//nothing
else
	ls_filter = ls_filter +" and status = '"+is_status+"' "
end if
dw_2.setfilter(ls_filter)
dw_2.filter()
dw_2.setredraw(true)
dw_1.setredraw(true)







end event

type dw_2 from datawindow within w_fax_log_view
integer x = 2121
integer y = 296
integer width = 2071
integer height = 2044
integer taborder = 30
boolean titlebar = true
string title = "MS Fax Fax Log"
string dataobject = "d_msfax_log"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string  ls_doc_id
long    ll_find

if row < 1 then return
this.selectrow(0,false)
this.selectrow(row, true)

ls_doc_id = this.getitemstring(row, "doc_name")

ll_find = dw_1.find("doc_id = '"+ls_doc_id+"'" , 1, dw_1.rowcount())
if ll_find > 0 then
	dw_1.scrolltorow(ll_find)
	dw_1.selectrow(0, false)
	dw_1.selectrow(ll_find, true)
end if
end event

type dw_1 from datawindow within w_fax_log_view
integer x = 23
integer y = 296
integer width = 2071
integer height = 2044
integer taborder = 20
boolean titlebar = true
string title = "IntelliSoft Fax Log"
string dataobject = "d_fax_log"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>Creation of Fax log records  (V12.1 Fax log)
//////////////////////////////////////////////////////////////////////
// $<add> 11.18.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string  ls_doc_id, ls_status
long    ll_find

if row < 1 then return
this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)

if ib_log = false then return
ls_doc_id = this.getitemstring(row, "doc_id")
ls_status =  this.getitemstring(row, "fax_status")

ll_find = dw_2.find("doc_name = '"+ls_doc_id+"'" , 1, dw_2.rowcount())
if ll_find > 0 then
	dw_2.scrolltorow(ll_find)
	dw_2.selectrow(0, false)
	dw_2.selectrow(ll_find, true)
else
	dw_2.selectrow(0, false)
	if ls_status = 'Sent' then
		messagebox("Prompt", "This Fax has been sent out and its relevant log has been deleted.")
	else
		messagebox("Prompt", "The log of this Fax wasn’t found, please check if it has been cleared off.")
	end if
end if
end event

type gb_1 from groupbox within w_fax_log_view
integer x = 18
integer y = 12
integer width = 1522
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range"
end type

type gb_2 from groupbox within w_fax_log_view
integer x = 1559
integer y = 12
integer width = 1385
integer height = 160
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status Filter"
end type

