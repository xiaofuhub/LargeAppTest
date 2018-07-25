$PBExportHeader$w_data_flow_sql.srw
forward
global type w_data_flow_sql from window
end type
type mle_1 from multilineedit within w_data_flow_sql
end type
end forward

global type w_data_flow_sql from window
integer width = 3259
integer height = 1424
boolean titlebar = true
string title = "View Syntax"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_1 mle_1
end type
global w_data_flow_sql w_data_flow_sql

on w_data_flow_sql.create
this.mle_1=create mle_1
this.Control[]={this.mle_1}
end on

on w_data_flow_sql.destroy
destroy(this.mle_1)
end on

event open;
mle_1.text = message.stringparm


end event

type mle_1 from multilineedit within w_data_flow_sql
integer width = 3255
integer height = 1348
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

