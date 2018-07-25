$PBExportHeader$w_validation_setup.srw
forward
global type w_validation_setup from window
end type
type cb_2 from commandbutton within w_validation_setup
end type
type cb_1 from commandbutton within w_validation_setup
end type
type dw_detail from datawindow within w_validation_setup
end type
type dw_browse from datawindow within w_validation_setup
end type
type cb_close from commandbutton within w_validation_setup
end type
type cb_save from commandbutton within w_validation_setup
end type
end forward

global type w_validation_setup from window
integer width = 2802
integer height = 2900
boolean titlebar = true
string title = "Validation Rule Setup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_detail dw_detail
dw_browse dw_browse
cb_close cb_close
cb_save cb_save
end type
global w_validation_setup w_validation_setup

on w_validation_setup.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.cb_close=create cb_close
this.cb_save=create cb_save
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_detail,&
this.dw_browse,&
this.cb_close,&
this.cb_save}
end on

on w_validation_setup.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.cb_close)
destroy(this.cb_save)
end on

event open;dw_browse.retrieve()

dw_browse.sharedata( dw_detail)
end event

type cb_2 from commandbutton within w_validation_setup
integer x = 50
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_1 from commandbutton within w_validation_setup
integer x = 425
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
string text = "Delete"
end type

type dw_detail from datawindow within w_validation_setup
integer x = 55
integer y = 1256
integer width = 2674
integer height = 1424
integer taborder = 40
string title = "none"
string dataobject = "d_validation_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_browse from datawindow within w_validation_setup
integer x = 59
integer y = 144
integer width = 2670
integer height = 1088
integer taborder = 30
string title = "none"
string dataobject = "d_validation_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
end event

event rowfocuschanged;
this.selectrow(0,false)
this.selectrow(currentrow,true)

dw_detail.scrolltorow( currentrow)


end event

type cb_close from commandbutton within w_validation_setup
integer x = 2382
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
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_validation_setup
integer x = 786
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
string text = "Save"
end type

