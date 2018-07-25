$PBExportHeader$w_autorun_impsql.srw
forward
global type w_autorun_impsql from w_response
end type
type cb_run from commandbutton within w_autorun_impsql
end type
type cb_close from commandbutton within w_autorun_impsql
end type
type cb_delete from commandbutton within w_autorun_impsql
end type
type cb_add from commandbutton within w_autorun_impsql
end type
type cb_save from commandbutton within w_autorun_impsql
end type
type dw_detail from u_dw within w_autorun_impsql
end type
type dw_browse from u_dw within w_autorun_impsql
end type
end forward

global type w_autorun_impsql from w_response
integer x = 214
integer y = 221
integer width = 2729
integer height = 1700
string title = "Pre/Post Sql Scripts"
long backcolor = 33551856
cb_run cb_run
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
cb_save cb_save
dw_detail dw_detail
dw_browse dw_browse
end type
global w_autorun_impsql w_autorun_impsql

type variables
long il_imp_id
boolean ib_new
end variables

on w_autorun_impsql.create
int iCurrent
call super::create
this.cb_run=create cb_run
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_save=create cb_save
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_run
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.dw_browse
end on

on w_autorun_impsql.destroy
call super::destroy
destroy(this.cb_run)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.01.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

il_imp_id = message.DoubleParm	
dw_browse.retrieve(il_imp_id)
dw_detail.retrieve(il_imp_id)

end event

type cb_run from commandbutton within w_autorun_impsql
integer x = 1042
integer y = 28
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.07.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_row
string ls_sql
dwitemstatus lds_status
 
li_row = dw_detail.getrow()
if li_row < 1 then return

dw_detail.accepttext()
lds_status = dw_detail.getitemstatus(li_row, 0, primary!)
if lds_status <> notmodified! then
	messagebox("Prompt", "There are unsaved data. Please save the data first.")	
	return
end if
ls_sql = dw_detail.getitemstring(li_row, "sql_to_run")

execute immediate :ls_sql using sqlca;
If SQLCA.sqlcode <> 0 Then
	Messagebox('Error', SQLCA.sqlerrtext )
	Rollback using sqlca;
	return
End If
end event

type cb_close from commandbutton within w_autorun_impsql
integer x = 2322
integer y = 28
integer width = 343
integer height = 92
integer taborder = 40
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

type cb_delete from commandbutton within w_autorun_impsql
integer x = 699
integer y = 28
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.07.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_row, li_ans

li_row = dw_browse.getrow()
if li_row < 1 then return

li_ans = MessageBox("Delete Row", "Are you sure you want to delete the selected row?", Question!, YesNo!, 1 )

IF li_ans = 2 THEN
	Return
END IF

dw_browse.deleterow(li_row)
dw_browse.update()
li_row = dw_browse.getrow()
if li_row > 0 then
	dw_browse.event rowfocuschanged(li_row)
else
	dw_detail.reset()
end if
end event

type cb_add from commandbutton within w_autorun_impsql
integer x = 357
integer y = 28
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add "
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.01.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_row

dw_detail.reset()
li_row = dw_detail.insertrow(0)
 
dw_detail.setitem(li_row, "import_id", il_imp_id)
ib_new = true


end event

type cb_save from commandbutton within w_autorun_impsql
integer x = 14
integer y = 28
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.01.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_ips_id
integer li_row
string ls_sql

li_row = dw_detail.getrow()
if li_row < 1 then return

dw_detail.accepttext()
if dw_detail.modifiedcount() < 1 then return
	
if ib_new then
	select max(Ips_id )
		into :ll_ips_id
	  from Import_post_SQL using sqlca;
	 
	if isnull(ll_ips_id) then ll_ips_id = 0
	ll_ips_id = ll_ips_id +1
	
	dw_detail.setitem(li_row, "ips_id", ll_ips_id)
else //(Appeon)Stephen 10.17.2015 - V15.1-BugL091403
	ll_ips_id = dw_detail.getitemnumber(li_row, "ips_id")
end if
ls_sql = dw_detail.getitemstring(li_row, "sql_to_run")

if isnull(trim(ls_sql)) then
	messagebox("Prompt","The field 'sql_to_run' cannot be empty.")
	return
end if	

dw_detail.update()
commit using sqlca;
dw_browse.setredraw(false)
dw_browse.retrieve(il_imp_id)
dw_detail.retrieve(il_imp_id)
li_row = dw_browse.find("ips_id = " +string(ll_ips_id), 1, dw_browse.rowcount())
if li_row > 0 then
	dw_browse.selectrow(0, false)
	dw_browse.selectrow(li_row, true)
	dw_browse.ScrollToRow(li_row)
	dw_browse.setrow(li_row)
	dw_detail.setfilter("ips_id = " +string(ll_ips_id))
	dw_detail.filter()
end if
dw_browse.setredraw(true)
ib_new = false



end event

type dw_detail from u_dw within w_autorun_impsql
integer x = 9
integer y = 760
integer width = 2665
integer height = 828
integer taborder = 20
string dataobject = "d_auto_possql_d"
end type

type dw_browse from u_dw within w_autorun_impsql
integer x = 9
integer y = 180
integer width = 2665
integer height = 560
integer taborder = 10
string dataobject = "d_auto_possql_h"
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.07.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if row < 1 then return
event rowfocuschanged(row)
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.07.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_ips_id

if currentrow < 1 then return
this.selectrow(0, false)
this.selectrow(currentrow, true)
ll_ips_id = this.getitemnumber(currentrow, "ips_id")
dw_detail.setfilter("ips_id = " +string(ll_ips_id))
dw_detail.filter()
end event

