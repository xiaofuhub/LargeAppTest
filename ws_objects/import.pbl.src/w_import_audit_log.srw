$PBExportHeader$w_import_audit_log.srw
forward
global type w_import_audit_log from pfc_w_response
end type
type cb_1 from commandbutton within w_import_audit_log
end type
type dw_imp_err from u_dw within w_import_audit_log
end type
type dw_imp_table from u_dw within w_import_audit_log
end type
type dw_imp_proc from u_dw within w_import_audit_log
end type
end forward

global type w_import_audit_log from pfc_w_response
integer width = 4037
integer height = 2268
string title = "Import Audit Log"
long backcolor = 33551856
cb_1 cb_1
dw_imp_err dw_imp_err
dw_imp_table dw_imp_table
dw_imp_proc dw_imp_proc
end type
global w_import_audit_log w_import_audit_log

type variables
long il_import_id
end variables

on w_import_audit_log.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_imp_err=create dw_imp_err
this.dw_imp_table=create dw_imp_table
this.dw_imp_proc=create dw_imp_proc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_imp_err
this.Control[iCurrent+3]=this.dw_imp_table
this.Control[iCurrent+4]=this.dw_imp_proc
end on

on w_import_audit_log.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_imp_err)
destroy(this.dw_imp_table)
destroy(this.dw_imp_proc)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<Event> open
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2013 by Stephen
//////////////////////////////////////////////////////////////////////

str_size lstr_str
long   ll_import_id, ll_process

lstr_str = Message.powerobjectParm
ll_import_id = lstr_str.x
ll_process = lstr_str.y

dw_imp_proc.setredraw(false)
dw_imp_proc.retrieve(ll_import_id)
dw_imp_proc.setfilter("process_id = "+string(ll_process))
dw_imp_proc.filter()
dw_imp_proc.setredraw(true)

if dw_imp_proc.rowcount() > 0 then
	dw_imp_proc.event rowfocuschanged(1)
end if
end event

type cb_1 from commandbutton within w_import_audit_log
integer x = 3648
integer y = 12
integer width = 343
integer height = 92
integer taborder = 10
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

type dw_imp_err from u_dw within w_import_audit_log
integer y = 1292
integer width = 4014
integer height = 876
integer taborder = 30
boolean titlebar = true
string title = "Import Process Error Details"
string dataobject = "d_import_process_errors"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//inherit
this.Modify("DataWindow.ReadOnly = 'yes'")
end event

event doubleclicked;call super::doubleclicked;string ls_err_value

if row > 0 and dwo.name = "err_value" then
	ls_err_value = this.object.err_value[row]
	if LenA(ls_err_value) > 0 then
		OpenWithParm(w_import_loglist, "LOG#" + ls_err_value)
	end if
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

type dw_imp_table from u_dw within w_import_audit_log
integer y = 748
integer width = 4014
integer height = 540
integer taborder = 20
boolean titlebar = true
string title = "Import Table Details"
string dataobject = "d_import_process_audit_tables"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//inherit
this.Modify("DataWindow.ReadOnly = 'yes'")
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
long ll_process_tables_id

this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

if CurrentRow > 0 then
	ll_process_tables_id = this.object.process_tables_id[CurrentRow]
	if dw_imp_err.Retrieve(ll_process_tables_id) > 0 then
		dw_imp_err.SelectRow(0, false)
		dw_imp_err.SelectRow(1, true)
	end if
else
	dw_imp_err.Reset()
end if
end event

type dw_imp_proc from u_dw within w_import_audit_log
integer y = 116
integer width = 4014
integer height = 628
integer taborder = 10
boolean titlebar = true
string title = "Import Process"
string dataobject = "d_import_process"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//inherit
this.Modify("DataWindow.ReadOnly = 'yes'")
end event

event doubleclicked;call super::doubleclicked;string ls_err_value

if row > 0 and dwo.name = "err_value" then
	ls_err_value = this.object.err_value[row]
	if LenA(ls_err_value) > 0 then
		OpenWithParm(w_import_loglist, "LOG#" + ls_err_value)
	end if
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//inhert
long ll_process_id

this.SelectRow(0, false)

if CurrentRow > 0 then
	this.SelectRow(CurrentRow, true)
	ll_process_id = this.object.process_id[CurrentRow]
	dw_imp_table.Retrieve(ll_process_id)
	if dw_imp_table.RowCount() > 0 then
		dw_imp_table.Event RowFocusChanged(1)
	else
		dw_imp_err.Reset()
	end if
else
	dw_imp_table.Reset()
	dw_imp_err.Reset()
end if
end event

event clicked;call super::clicked;event rowfocuschanged(row)
end event

