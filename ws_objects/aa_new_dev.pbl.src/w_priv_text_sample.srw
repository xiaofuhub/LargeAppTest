$PBExportHeader$w_priv_text_sample.srw
forward
global type w_priv_text_sample from window
end type
type dw_1 from datawindow within w_priv_text_sample
end type
type cb_2 from commandbutton within w_priv_text_sample
end type
type cb_1 from commandbutton within w_priv_text_sample
end type
end forward

global type w_priv_text_sample from window
integer width = 2505
integer height = 1424
boolean titlebar = true
string title = "Acknowledgement"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_priv_text_sample w_priv_text_sample

on w_priv_text_sample.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_priv_text_sample.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_priv_text_sample
integer x = 32
integer y = 32
integer width = 2377
integer height = 1040
integer taborder = 10
string title = "none"
string dataobject = "d_priv_ack_text"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_priv_text_sample
integer x = 1111
integer y = 1136
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

type cb_1 from commandbutton within w_priv_text_sample
integer x = 750
integer y = 1136
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Accept"
end type

