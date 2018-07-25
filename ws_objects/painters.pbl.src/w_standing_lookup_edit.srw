$PBExportHeader$w_standing_lookup_edit.srw
forward
global type w_standing_lookup_edit from window
end type
type dw_1 from datawindow within w_standing_lookup_edit
end type
type cb_close from commandbutton within w_standing_lookup_edit
end type
type cb_save from commandbutton within w_standing_lookup_edit
end type
end forward

global type w_standing_lookup_edit from window
integer width = 2656
integer height = 1292
boolean titlebar = true
string title = "Standing Lookup Edit"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_close cb_close
cb_save cb_save
end type
global w_standing_lookup_edit w_standing_lookup_edit

on w_standing_lookup_edit.create
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.Control[]={this.dw_1,&
this.cb_close,&
this.cb_save}
end on

on w_standing_lookup_edit.destroy
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_save)
end on

type dw_1 from datawindow within w_standing_lookup_edit
integer x = 5
integer y = 136
integer width = 2606
integer height = 1032
integer taborder = 30
string title = "none"
string dataobject = "d_standing_edit"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_close from commandbutton within w_standing_lookup_edit
integer x = 2226
integer y = 36
integer width = 366
integer height = 84
integer taborder = 20
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

type cb_save from commandbutton within w_standing_lookup_edit
integer x = 1829
integer y = 36
integer width = 366
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;dw_1.update()
end event

