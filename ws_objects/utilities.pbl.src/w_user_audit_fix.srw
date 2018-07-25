$PBExportHeader$w_user_audit_fix.srw
forward
global type w_user_audit_fix from window
end type
type cb_close from commandbutton within w_user_audit_fix
end type
type cb_keys from commandbutton within w_user_audit_fix
end type
type cb_run from commandbutton within w_user_audit_fix
end type
type dw_audit from datawindow within w_user_audit_fix
end type
type dw_check from datawindow within w_user_audit_fix
end type
end forward

global type w_user_audit_fix from window
integer width = 2039
integer height = 2168
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_keys cb_keys
cb_run cb_run
dw_audit dw_audit
dw_check dw_check
end type
global w_user_audit_fix w_user_audit_fix

on w_user_audit_fix.create
this.cb_close=create cb_close
this.cb_keys=create cb_keys
this.cb_run=create cb_run
this.dw_audit=create dw_audit
this.dw_check=create dw_check
this.Control[]={this.cb_close,&
this.cb_keys,&
this.cb_run,&
this.dw_audit,&
this.dw_check}
end on

on w_user_audit_fix.destroy
destroy(this.cb_close)
destroy(this.cb_keys)
destroy(this.cb_run)
destroy(this.dw_audit)
destroy(this.dw_check)
end on

type cb_close from commandbutton within w_user_audit_fix
integer x = 795
integer y = 68
integer width = 343
integer height = 92
integer taborder = 40
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

type cb_keys from commandbutton within w_user_audit_fix
integer x = 389
integer y = 68
integer width = 384
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Set Primary Key"
end type

event clicked;string ls_sql

ls_sql = "alter table sys_audit_user modify rec_id decimal(16,0) not null;"
EXECUTE Immediate :ls_sql Using Sqlca;
ls_sql = "alter table sys_audit_user add primary key(rec_id);"
EXECUTE Immediate :ls_sql Using Sqlca;

end event

type cb_run from commandbutton within w_user_audit_fix
integer x = 27
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;
long l
long lc
long ll_recids[]
long ll_audit_id

lc = dw_check.retrieve()

if lc = 0 then
	messagebox("Check","There are no duplicate records to correct.")
	return 1
else
	for l = 1 to lc
		ll_recids[l] = dw_check.getitemnumber(l,"rec_id")
	next
end if

lc = dw_audit.retrieve(ll_recids[])
select max(rec_id) into :ll_audit_id from sys_audit_user;

messagebox("","Break")

for l = 1 to lc
	ll_audit_id++
	dw_audit.setitem(l,"rec_id",ll_audit_id)
next

dw_audit.update()

cb_keys.enabled = true






end event

type dw_audit from datawindow within w_user_audit_fix
integer x = 160
integer y = 712
integer width = 1751
integer height = 1224
integer taborder = 20
string title = "none"
string dataobject = "d_user_audit_record_fix"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_check from datawindow within w_user_audit_fix
integer x = 155
integer y = 260
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_user_audit_dupe_utl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

