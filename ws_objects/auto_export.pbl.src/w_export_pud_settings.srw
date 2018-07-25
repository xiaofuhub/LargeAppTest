$PBExportHeader$w_export_pud_settings.srw
forward
global type w_export_pud_settings from window
end type
type cb_1 from commandbutton within w_export_pud_settings
end type
type cb_ok from commandbutton within w_export_pud_settings
end type
type st_2 from statictext within w_export_pud_settings
end type
type st_1 from statictext within w_export_pud_settings
end type
type dw_2 from datawindow within w_export_pud_settings
end type
type dw_1 from datawindow within w_export_pud_settings
end type
end forward

global type w_export_pud_settings from window
integer width = 1394
integer height = 2476
boolean titlebar = true
string title = "Criteria Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_ok cb_ok
st_2 st_2
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type
global w_export_pud_settings w_export_pud_settings

on w_export_pud_settings.create
this.cb_1=create cb_1
this.cb_ok=create cb_ok
this.st_2=create st_2
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_ok,&
this.st_2,&
this.st_1,&
this.dw_2,&
this.dw_1}
end on

on w_export_pud_settings.destroy
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_export_pud_settings
integer x = 850
integer y = 2216
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,'Cancel')
end event

type cb_ok from commandbutton within w_export_pud_settings
integer x = 480
integer y = 2212
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;//build sql criteria
string ls_sql

ls_sql = "select prac_id, action_type = 'A' from sys_audit, pd_affil_stat "
ls_sql+= "where sys_audit.prac_id =  pd_affil_stat.prac_id and "
ls_sql+= "table_id = 25 and audit_type in ('I')~r "
ls_sql+= "union~r~r "
ls_sql+= "select prac_id, action_type = 'C' from sys_audit, pd_affil_stat "
ls_sql+= "where sys_audit.prac_id =  pd_affil_stat.prac_id and "
ls_sql+= " table_id = in (25,20,22) and audit_type in ('E','X') "

Closewithreturn(parent, ls_sql)


//Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status in (1,4) and sys_audit.table_id < 1000;
end event

type st_2 from statictext within w_export_pud_settings
integer x = 110
integer y = 356
integer width = 489
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Audit Screens"
boolean focusrectangle = false
end type

type st_1 from statictext within w_export_pud_settings
integer x = 96
integer y = 80
integer width = 425
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Date Range"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_export_pud_settings
integer x = 91
integer y = 164
integer width = 1143
integer height = 144
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_export_pud_settings
integer x = 91
integer y = 424
integer width = 1143
integer height = 1732
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

