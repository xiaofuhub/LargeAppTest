$PBExportHeader$w_lookup_migration.srw
forward
global type w_lookup_migration from window
end type
type st_1 from statictext within w_lookup_migration
end type
type cb_2 from commandbutton within w_lookup_migration
end type
type cb_1 from commandbutton within w_lookup_migration
end type
type dw_2 from datawindow within w_lookup_migration
end type
type dw_1 from datawindow within w_lookup_migration
end type
end forward

global type w_lookup_migration from window
integer width = 4114
integer height = 2032
boolean titlebar = true
string title = "Lookup Migration"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_lookup_migration w_lookup_migration

on w_lookup_migration.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_lookup_migration.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type st_1 from statictext within w_lookup_migration
integer x = 59
integer y = 16
integer width = 969
integer height = 88
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Not Completed"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_lookup_migration
integer x = 3323
integer y = 24
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Migrate"
end type

type cb_1 from commandbutton within w_lookup_migration
integer x = 3675
integer y = 24
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type dw_2 from datawindow within w_lookup_migration
integer x = 46
integer y = 372
integer width = 3973
integer height = 1496
integer taborder = 20
string title = "none"
string dataobject = "d_address_lookup_4_table"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_lookup_migration
integer x = 46
integer y = 120
integer width = 3973
integer height = 236
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

