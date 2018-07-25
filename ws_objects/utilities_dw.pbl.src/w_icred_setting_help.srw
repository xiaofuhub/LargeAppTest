$PBExportHeader$w_icred_setting_help.srw
forward
global type w_icred_setting_help from window
end type
type cb_save from commandbutton within w_icred_setting_help
end type
type cb_close from commandbutton within w_icred_setting_help
end type
type dw_detail from datawindow within w_icred_setting_help
end type
type dw_browse from datawindow within w_icred_setting_help
end type
end forward

global type w_icred_setting_help from window
integer width = 4562
integer height = 2872
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_save cb_save
cb_close cb_close
dw_detail dw_detail
dw_browse dw_browse
end type
global w_icred_setting_help w_icred_setting_help

on w_icred_setting_help.create
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.Control[]={this.cb_save,&
this.cb_close,&
this.dw_detail,&
this.dw_browse}
end on

on w_icred_setting_help.destroy
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event open;dw_browse.settransobject(sqlca)
dw_detail.settransobject(sqlca)

dw_browse.retrieve()
end event

type cb_save from commandbutton within w_icred_setting_help
integer x = 119
integer y = 44
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_detail.update()
end event

type cb_close from commandbutton within w_icred_setting_help
integer x = 4032
integer y = 44
integer width = 402
integer height = 92
integer taborder = 10
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

type dw_detail from datawindow within w_icred_setting_help
integer x = 23
integer y = 1532
integer width = 4480
integer height = 1220
integer taborder = 20
string title = "none"
string dataobject = "d_icred_set_help_detail"
boolean livescroll = true
end type

type dw_browse from datawindow within w_icred_setting_help
integer x = 23
integer y = 172
integer width = 4480
integer height = 1308
integer taborder = 10
string title = "none"
string dataobject = "d_icred_set_help_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r


r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;STRING ls_set


if currentrow < 1 then return
this.selectrow(0,false)
this.selectrow(currentrow,true)

ls_set = this.getitemstring(currentrow, "setting_name")

dw_detail.retrieve(ls_set)
end event

