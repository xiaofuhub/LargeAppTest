$PBExportHeader$w_base_browse_detail.srw
forward
global type w_base_browse_detail from window
end type
type dw_detail from u_dw within w_base_browse_detail
end type
type dw_browse from u_dw within w_base_browse_detail
end type
type cb_add from commandbutton within w_base_browse_detail
end type
type cb_delete from commandbutton within w_base_browse_detail
end type
type cb_save from commandbutton within w_base_browse_detail
end type
type cb_close from commandbutton within w_base_browse_detail
end type
end forward

global type w_base_browse_detail from window
integer width = 3131
integer height = 1728
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_detail dw_detail
dw_browse dw_browse
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
end type
global w_base_browse_detail w_base_browse_detail

on w_base_browse_detail.create
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.Control[]={this.dw_detail,&
this.dw_browse,&
this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.cb_close}
end on

on w_base_browse_detail.destroy
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
end on

type dw_detail from u_dw within w_base_browse_detail
integer x = 50
integer y = 972
integer width = 3003
integer height = 592
integer taborder = 50
end type

type dw_browse from u_dw within w_base_browse_detail
integer x = 46
integer y = 196
integer width = 3003
integer height = 744
integer taborder = 50
boolean hscrollbar = true
end type

type cb_add from commandbutton within w_base_browse_detail
integer x = 1586
integer y = 52
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

type cb_delete from commandbutton within w_base_browse_detail
integer x = 1957
integer y = 52
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

type cb_save from commandbutton within w_base_browse_detail
integer x = 2322
integer y = 52
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

type cb_close from commandbutton within w_base_browse_detail
integer x = 2683
integer y = 52
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

