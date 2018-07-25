$PBExportHeader$w_bidq_import_log.srw
forward
global type w_bidq_import_log from w_main
end type
type cb_refresh from commandbutton within w_bidq_import_log
end type
type st_licensekey from statictext within w_bidq_import_log
end type
type cb_ok from commandbutton within w_bidq_import_log
end type
type tab_1 from tab within w_bidq_import_log
end type
type tabpage_1 from userobject within tab_1
end type
type dw_filter from u_dw within tabpage_1
end type
type dw_import_log from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_filter dw_filter
dw_import_log dw_import_log
end type
type tabpage_2 from userobject within tab_1
end type
type dw_attach_log_filter from u_dw within tabpage_2
end type
type dw_attach_log from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_attach_log_filter dw_attach_log_filter
dw_attach_log dw_attach_log
end type
type tab_1 from tab within w_bidq_import_log
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_saveas from commandbutton within w_bidq_import_log
end type
end forward

global type w_bidq_import_log from w_main
string tag = "Batch Import Document Log"
integer width = 2880
integer height = 2016
string title = "Batch Import Document Log"
boolean maxbox = false
long backcolor = 33551856
boolean center = true
boolean ib_isupdateable = false
cb_refresh cb_refresh
st_licensekey st_licensekey
cb_ok cb_ok
tab_1 tab_1
cb_saveas cb_saveas
end type
global w_bidq_import_log w_bidq_import_log

type variables
String is_sql_org ,is_sql_attach
end variables

on w_bidq_import_log.create
int iCurrent
call super::create
this.cb_refresh=create cb_refresh
this.st_licensekey=create st_licensekey
this.cb_ok=create cb_ok
this.tab_1=create tab_1
this.cb_saveas=create cb_saveas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_refresh
this.Control[iCurrent+2]=this.st_licensekey
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.cb_saveas
end on

on w_bidq_import_log.destroy
call super::destroy
destroy(this.cb_refresh)
destroy(this.st_licensekey)
destroy(this.cb_ok)
destroy(this.tab_1)
destroy(this.cb_saveas)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>w_user_tracking::open()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-06-01 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//st_licensekey.text = 'License Key: ' + String(gnv_session.is_license_key,'@@@ @@@@ @@@@@@@ @@@@@@@@')

//Added By Mark Lee 05/07/12
this.of_setresize( true)							
this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_1.dw_import_log,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_2.dw_attach_log,inv_resize.scalerightbottom)
this.inv_resize.of_register( cb_ok,inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_register( cb_saveas,inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_register( cb_refresh,inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_register( st_licensekey,inv_resize.FIXEDBOTTOM)

this.inv_resize.of_SetMinSize( 800, 600 )




end event

type cb_refresh from commandbutton within w_bidq_import_log
integer x = 1778
integer y = 1804
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;If tab_1.selectedtab = 1 Then
	tab_1.tabpage_1.dw_import_log.event pfc_retrieve( )
ElseIf tab_1.selectedtab = 2 Then
	tab_1.tabpage_2.dw_attach_log.event pfc_retrieve( )
End If
end event

type st_licensekey from statictext within w_bidq_import_log
integer x = 9
integer y = 1800
integer width = 1138
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_bidq_import_log
integer x = 2491
integer y = 1804
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

type tab_1 from tab within w_bidq_import_log
integer x = 5
integer width = 2839
integer height = 1792
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
boolean focusonbuttondown = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2802
integer height = 1676
long backcolor = 33551856
string text = "Import Log"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_filter dw_filter
dw_import_log dw_import_log
end type

on tabpage_1.create
this.dw_filter=create dw_filter
this.dw_import_log=create dw_import_log
this.Control[]={this.dw_filter,&
this.dw_import_log}
end on

on tabpage_1.destroy
destroy(this.dw_filter)
destroy(this.dw_import_log)
end on

type dw_filter from u_dw within tabpage_1
integer y = 12
integer width = 2802
integer height = 216
integer taborder = 11
string dataobject = "d_bidq_import_log_filter"
end type

event constructor;call super::constructor;DatawindowChild ldwc_users,ldwc_bidq_id
datetime		ldt_currentdate
long			ll_ctx_bidq

This.of_setdropdowncalendar(True)
This.of_setupdateable(False)

This.Insertrow(0)
If This.Getchild('user_id',ldwc_users) = 1 Then
	ldwc_users.SetTransObject(SQLCA)
End If

If This.Getchild('bidq_id',ldwc_bidq_id) = 1 Then
	ldwc_bidq_id.SetTransObject(SQLCA)
End If

gnv_appeondb.of_startqueue( )
	ldwc_users.Retrieve()
	ldwc_bidq_id.Retrieve()
gnv_appeondb.of_commitqueue( )

This.SetItem(1,'user_id',gs_user_id)

ldt_currentdate = datetime(date(now()),time(now()))
This.SetItem(1,'date_start',ldt_currentdate)
This.SetItem(1,'date_end',ldt_currentdate)
This.SetItem(1,'pass_fail','Failure')

If isvalid(w_bidq_import_document) then 
	If w_bidq_import_document.dw_bidq.rowcount() > 0 then 
		ll_ctx_bidq = w_bidq_import_document.dw_bidq.GetItemNumber(w_bidq_import_document.dw_bidq.getrow(),'bidq_id')
		This.SetItem(1,'bidq_id',ll_ctx_bidq)
	End if 
End if 


end event

event buttonclicked;call super::buttonclicked;Choose Case dwo.name 
Case 'b_filter' 
	dw_import_log.Event pfc_retrieve()
Case 'b_clear'
	This.Reset()
	This.InsertRow(0)
End Choose
end event

type dw_import_log from u_dw within tabpage_1
integer y = 228
integer width = 2802
integer height = 1460
integer taborder = 11
string dataobject = "dw_bidq_import_log"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)
//This.of_setrowmanager(True)
This.of_setrowselect(True)
This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)
//This.inv_sort.of_SetColumnnameSource(This.inv_sort.HEADER)
// 03/12/12 Added By mark 
This.Modify("Datawindow.readonly = Yes")

This.SetTransObject(SQLCA)

is_sql_org = This.GetSQLSelect()

This.Post Event pfc_Retrieve()

end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////
// $<event>pfc_retrievedw_log_tracking()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Retrieve data by filter condition.
// 03/09/12 Added By mark 
String 	ls_user_id, ls_pass_faild
Datetime ldt_start,ldt_end
String 	ls_sql
long		ll_ctx_bidq

SetPointer(HourGlass!)

dw_filter.AcceptText()

ls_sql = is_sql_org 

ls_user_id = dw_filter.GetItemString(1,'user_id')
ldt_start = dw_filter.GetItemDateTime(1,'date_start')
ldt_end = dw_filter.GetItemDateTime(1,'date_end')
ls_pass_faild = dw_filter.GetItemString(1,'pass_fail')
ll_ctx_bidq	= dw_filter.GetItemNumber(1,'bidq_id')

If Not isnull(ls_user_id)  and ls_user_id <> '' Then
	ls_sql += " And user_id = '" + ls_user_id + "'"
End If

If Not isnull(ls_pass_faild)  and ls_pass_faild <> '' Then
	ls_sql += " And pass_fail = '" + ls_pass_faild + "'"
End If

If Not isnull(ll_ctx_bidq)  and ll_ctx_bidq > 0  Then
	ls_sql += " And ctx_bidq = " + string(ll_ctx_bidq) + " "
End If

If Not isnull(ldt_start) Then
	ls_sql += " And log_date >= Convert(Datetime,'"  + String(ldt_start,'yyyy-mm-dd') + " 00:00:00')"
End If

If Not isnull(ldt_end) Then
	ls_sql += " And log_date <= Convert(Datetime,'"  + String(ldt_end,'yyyy-mm-dd') + " 23:59:59')"
End If

ls_sql += ' ORDER BY log_date DESC   '

This.SetSQLselect(ls_sql)
This.SetTransobject(SQLCA)
This.Retrieve()

SetPointer(Arrow!)


Return 1


end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2802
integer height = 1676
long backcolor = 33551856
string text = "Attach Log"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_attach_log_filter dw_attach_log_filter
dw_attach_log dw_attach_log
end type

on tabpage_2.create
this.dw_attach_log_filter=create dw_attach_log_filter
this.dw_attach_log=create dw_attach_log
this.Control[]={this.dw_attach_log_filter,&
this.dw_attach_log}
end on

on tabpage_2.destroy
destroy(this.dw_attach_log_filter)
destroy(this.dw_attach_log)
end on

type dw_attach_log_filter from u_dw within tabpage_2
integer y = 12
integer width = 2802
integer height = 216
integer taborder = 10
string dataobject = "d_bidq_attach_log_filter"
end type

event buttonclicked;call super::buttonclicked;Choose Case dwo.name 
Case 'b_filter' 
	dw_attach_log.Event pfc_retrieve()
Case 'b_clear'
	This.Reset()
	This.InsertRow(0)
End Choose
end event

event constructor;call super::constructor;DatawindowChild ldwc_users,ldwc_bidq_id, ldwc_ctx_id
datetime		ldt_currentdate
long			ll_ctx_bidq, ll_ctx_id

This.of_setdropdowncalendar(True)
This.of_setupdateable(False)

This.Insertrow(0)
If This.Getchild('user_id',ldwc_users) = 1 Then
	ldwc_users.SetTransObject(SQLCA)
End If

If This.Getchild('bidq_id',ldwc_bidq_id) = 1 Then
	ldwc_bidq_id.SetTransObject(SQLCA)
End If

If This.Getchild('ctx_id',ldwc_ctx_id) = 1 Then
	ldwc_ctx_id.SetTransObject(SQLCA)
End If

gnv_appeondb.of_startqueue( )
	ldwc_users.Retrieve()
	ldwc_bidq_id.Retrieve()
	ldwc_ctx_id.Retrieve()
gnv_appeondb.of_commitqueue( )

This.SetItem(1,'user_id',gs_user_id)

ldt_currentdate = datetime(date(now()),time(now()))
This.SetItem(1,'date_start',ldt_currentdate)
This.SetItem(1,'date_end',ldt_currentdate)
This.SetItem(1,'pass_fail','Failure')

If isvalid(w_bidq_import_document) then 
	If w_bidq_import_document.dw_bidq.rowcount() > 0 then 
		ll_ctx_bidq = w_bidq_import_document.dw_bidq.GetItemNumber(w_bidq_import_document.dw_bidq.getrow(),'bidq_id')
		This.SetItem(1,'bidq_id',ll_ctx_bidq)
	End if 
	If	w_bidq_import_document.uo_search.dw_search_det1.rowcount() > 0 then
		ll_ctx_id = w_bidq_import_document.uo_search.dw_search_det1.object.ctx_id[w_bidq_import_document.uo_search.dw_search_det1.getrow()]
		This.SetItem(1,'ctx_id',ll_ctx_id)
	End If
End if 
end event

type dw_attach_log from u_dw within tabpage_2
integer y = 228
integer width = 2802
integer height = 1460
integer taborder = 10
string dataobject = "dw_bidq_attach_log"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)
//This.of_setrowmanager(True)
This.of_setrowselect(True)
This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)
//This.inv_sort.of_SetColumnnameSource(This.inv_sort.HEADER)

This.SetTransObject(SQLCA)

is_sql_attach = This.GetSQLSelect()

This.Post Event pfc_Retrieve()



end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////
// $<event>pfc_retrievedw_log_tracking()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Retrieve data by filter condition.
// 03/09/12 Added By mark 
String 	ls_user_id, ls_pass_faild
Datetime ldt_start,ldt_end
String 	ls_sql
long		ll_ctx_bidq, ll_ctx_id

SetPointer(HourGlass!)

dw_attach_log_filter.AcceptText()

ls_sql = is_sql_attach 

ls_user_id = dw_attach_log_filter.GetItemString(1,'user_id')
ldt_start = dw_attach_log_filter.GetItemDateTime(1,'date_start')
ldt_end = dw_attach_log_filter.GetItemDateTime(1,'date_end')
ls_pass_faild = dw_attach_log_filter.GetItemString(1,'pass_fail')
ll_ctx_bidq	= dw_attach_log_filter.GetItemNumber(1,'bidq_id')
ll_ctx_id		= dw_attach_log_filter.GetItemNumber(1,'ctx_id')

If Not isnull(ls_user_id)  and ls_user_id <> '' Then
	ls_sql += " And user_id = '" + ls_user_id + "'"
End If

If Not isnull(ls_pass_faild)  and ls_pass_faild <> '' Then
	ls_sql += " And pass_fail = '" + ls_pass_faild + "'"
End If

If Not isnull(ll_ctx_bidq)  and ll_ctx_bidq > 0  Then
	ls_sql += " And ctx_bidq = " + string(ll_ctx_bidq) + " "
End If

If Not isnull(ll_ctx_id)  and ll_ctx_id > 0  Then
	ls_sql += " And ctx_id = " + string(ll_ctx_id) + " "
End If

If Not isnull(ldt_start) Then
	ls_sql += " And log_date >= Convert(Datetime,'"  + String(ldt_start,'yyyy-mm-dd') + " 00:00:00')"
End If

If Not isnull(ldt_end) Then
	ls_sql += " And log_date <= Convert(Datetime,'"  + String(ldt_end,'yyyy-mm-dd') + " 23:59:59')"
End If

ls_sql += ' ORDER BY log_date DESC   '

This.SetSQLselect(ls_sql)
This.SetTransobject(SQLCA)
This.Retrieve()

SetPointer(Arrow!)


Return 1


end event

type cb_saveas from commandbutton within w_bidq_import_log
integer x = 2135
integer y = 1804
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export..."
end type

event clicked;//tab_1.tabpage_browse.dynamic Event ue_export()

//Modified By Ken.Guo 2011-05-24. workaround PB's bug
m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
if tab_1.selectedtab = 1 then 
	NewMenu.of_setparent(tab_1.tabpage_1.dw_import_log)
else
	NewMenu.of_setparent(tab_1.tabpage_2.dw_attach_log)
end if 

NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.visible = False
NewMenu.m_options.PopMenu(Parent.pointerx(),Parent.pointerY())
end event

