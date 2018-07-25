$PBExportHeader$w_detail_information.srw
forward
global type w_detail_information from window
end type
type mle_details from multilineedit within w_detail_information
end type
end forward

global type w_detail_information from window
integer width = 1856
integer height = 560
boolean titlebar = true
string title = "Details"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_details mle_details
end type
global w_detail_information w_detail_information

on w_detail_information.create
this.mle_details=create mle_details
this.Control[]={this.mle_details}
end on

on w_detail_information.destroy
destroy(this.mle_details)
end on

event open;String ls_details
ls_details = Message.stringparm
mle_details.text = ls_details

end event

type mle_details from multilineedit within w_detail_information
integer width = 1842
integer height = 484
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

