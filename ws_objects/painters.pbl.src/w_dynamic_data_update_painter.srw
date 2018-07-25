$PBExportHeader$w_dynamic_data_update_painter.srw
forward
global type w_dynamic_data_update_painter from window
end type
type dw_1 from datawindow within w_dynamic_data_update_painter
end type
type cb_add from commandbutton within w_dynamic_data_update_painter
end type
type cb_delete from commandbutton within w_dynamic_data_update_painter
end type
type cb_opy from commandbutton within w_dynamic_data_update_painter
end type
type cb_save from commandbutton within w_dynamic_data_update_painter
end type
type dw_browse from datawindow within w_dynamic_data_update_painter
end type
type cb_close from commandbutton within w_dynamic_data_update_painter
end type
end forward

global type w_dynamic_data_update_painter from window
integer width = 3214
integer height = 2192
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_add cb_add
cb_delete cb_delete
cb_opy cb_opy
cb_save cb_save
dw_browse dw_browse
cb_close cb_close
end type
global w_dynamic_data_update_painter w_dynamic_data_update_painter

on w_dynamic_data_update_painter.create
this.dw_1=create dw_1
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_opy=create cb_opy
this.cb_save=create cb_save
this.dw_browse=create dw_browse
this.cb_close=create cb_close
this.Control[]={this.dw_1,&
this.cb_add,&
this.cb_delete,&
this.cb_opy,&
this.cb_save,&
this.dw_browse,&
this.cb_close}
end on

on w_dynamic_data_update_painter.destroy
destroy(this.dw_1)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_opy)
destroy(this.cb_save)
destroy(this.dw_browse)
destroy(this.cb_close)
end on

type dw_1 from datawindow within w_dynamic_data_update_painter
integer y = 1464
integer width = 3163
integer height = 584
integer taborder = 30
string title = "none"
string dataobject = "d_dynamic_update_detail"
boolean livescroll = true
end type

type cb_add from commandbutton within w_dynamic_data_update_painter
integer x = 1673
integer y = 36
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_delete from commandbutton within w_dynamic_data_update_painter
integer x = 1966
integer y = 36
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_opy from commandbutton within w_dynamic_data_update_painter
integer x = 2258
integer y = 36
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy"
end type

type cb_save from commandbutton within w_dynamic_data_update_painter
integer x = 2551
integer y = 36
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type dw_browse from datawindow within w_dynamic_data_update_painter
integer y = 152
integer width = 3163
integer height = 1308
integer taborder = 20
string title = "none"
string dataobject = "d_dynamic_update_browse"
boolean livescroll = true
end type

type cb_close from commandbutton within w_dynamic_data_update_painter
integer x = 2843
integer y = 36
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

