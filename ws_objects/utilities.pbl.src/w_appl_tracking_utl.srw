$PBExportHeader$w_appl_tracking_utl.srw
forward
global type w_appl_tracking_utl from window
end type
type dw_1 from u_dw within w_appl_tracking_utl
end type
type cb_export from commandbutton within w_appl_tracking_utl
end type
type cb_print from commandbutton within w_appl_tracking_utl
end type
type cb_sort from commandbutton within w_appl_tracking_utl
end type
type cb_filter from commandbutton within w_appl_tracking_utl
end type
type cb_close from commandbutton within w_appl_tracking_utl
end type
end forward

global type w_appl_tracking_utl from window
integer width = 3237
integer height = 2124
boolean titlebar = true
string title = "Application Modifications"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_export cb_export
cb_print cb_print
cb_sort cb_sort
cb_filter cb_filter
cb_close cb_close
end type
global w_appl_tracking_utl w_appl_tracking_utl

on w_appl_tracking_utl.create
this.dw_1=create dw_1
this.cb_export=create cb_export
this.cb_print=create cb_print
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_close=create cb_close
this.Control[]={this.dw_1,&
this.cb_export,&
this.cb_print,&
this.cb_sort,&
this.cb_filter,&
this.cb_close}
end on

on w_appl_tracking_utl.destroy
destroy(this.dw_1)
destroy(this.cb_export)
destroy(this.cb_print)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_close)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from u_dw within w_appl_tracking_utl
integer x = 55
integer y = 148
integer width = 3150
integer height = 1868
integer taborder = 20
string dataobject = "d_app_hdr_audit"
borderstyle borderstyle = stylebox!
end type

type cb_export from commandbutton within w_appl_tracking_utl
integer x = 1367
integer y = 32
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_1)//.saveas() Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path)//restore currentdirectory-Added by Nova 04.29.2008
end event

type cb_print from commandbutton within w_appl_tracking_utl
integer x = 1723
integer y = 32
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_1.print()
end event

type cb_sort from commandbutton within w_appl_tracking_utl
integer x = 2085
integer y = 32
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type cb_filter from commandbutton within w_appl_tracking_utl
integer x = 2441
integer y = 32
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.Setfilter(null_str)

dw_1.filter( )
end event

type cb_close from commandbutton within w_appl_tracking_utl
integer x = 2798
integer y = 32
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close (Parent)
end event

