$PBExportHeader$w_corresp_letter_detail.srw
forward
global type w_corresp_letter_detail from window
end type
type cb_save from commandbutton within w_corresp_letter_detail
end type
type cb_1 from commandbutton within w_corresp_letter_detail
end type
type dw_1 from datawindow within w_corresp_letter_detail
end type
end forward

global type w_corresp_letter_detail from window
integer width = 2523
integer height = 1744
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
cb_1 cb_1
dw_1 dw_1
end type
global w_corresp_letter_detail w_corresp_letter_detail

on w_corresp_letter_detail.create
this.cb_save=create cb_save
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_save,&
this.cb_1,&
this.dw_1}
end on

on w_corresp_letter_detail.destroy
destroy(this.cb_save)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_save from commandbutton within w_corresp_letter_detail
integer x = 1627
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.update()
end event

type cb_1 from commandbutton within w_corresp_letter_detail
integer x = 2007
integer y = 36
integer width = 343
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

type dw_1 from datawindow within w_corresp_letter_detail
integer x = 46
integer y = 160
integer width = 2373
integer height = 1420
integer taborder = 10
string title = "none"
string dataobject = "d_letter_painter"
boolean livescroll = true
end type

