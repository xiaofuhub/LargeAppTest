$PBExportHeader$w_profile_model_response.srw
forward
global type w_profile_model_response from window
end type
type cb_3 from commandbutton within w_profile_model_response
end type
type st_4 from statictext within w_profile_model_response
end type
type cb_2 from commandbutton within w_profile_model_response
end type
type cb_1 from commandbutton within w_profile_model_response
end type
type st_3 from statictext within w_profile_model_response
end type
type st_2 from statictext within w_profile_model_response
end type
type st_1 from statictext within w_profile_model_response
end type
end forward

global type w_profile_model_response from window
integer width = 2578
integer height = 796
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
st_4 st_4
cb_2 cb_2
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_profile_model_response w_profile_model_response

on w_profile_model_response.create
this.cb_3=create cb_3
this.st_4=create st_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_3,&
this.st_4,&
this.cb_2,&
this.cb_1,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_profile_model_response.destroy
destroy(this.cb_3)
destroy(this.st_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_3 from commandbutton within w_profile_model_response
integer x = 1879
integer y = 560
integer width = 393
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,-1)
end event

type st_4 from statictext within w_profile_model_response
integer x = 78
integer y = 568
integer width = 2322
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "If you wish the screen to remain in the Default format click ~'Cancel~'"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_profile_model_response
integer x = 1879
integer y = 400
integer width = 393
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Redesign"
end type

event clicked;closewithreturn(parent,1)
end event

type cb_1 from commandbutton within w_profile_model_response
integer x = 1879
integer y = 252
integer width = 393
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Previous"
end type

event clicked;closewithreturn(parent,2)
end event

type st_3 from statictext within w_profile_model_response
integer x = 78
integer y = 256
integer width = 2327
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "If you wish to use the previous setting click ~'Previous~'."
boolean focusrectangle = false
end type

type st_2 from statictext within w_profile_model_response
integer x = 78
integer y = 412
integer width = 2322
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "If you wish to redesign the screen click ~'Redesign~'"
boolean focusrectangle = false
end type

type st_1 from statictext within w_profile_model_response
integer x = 142
integer y = 80
integer width = 1929
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "This profile screen was previously set to the screen model."
alignment alignment = center!
boolean focusrectangle = false
end type

