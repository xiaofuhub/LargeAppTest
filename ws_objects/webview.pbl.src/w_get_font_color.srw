$PBExportHeader$w_get_font_color.srw
forward
global type w_get_font_color from window
end type
type st_5 from statictext within w_get_font_color
end type
type st_4 from statictext within w_get_font_color
end type
type st_3 from statictext within w_get_font_color
end type
type st_2 from statictext within w_get_font_color
end type
type st_1 from statictext within w_get_font_color
end type
type cb_1 from commandbutton within w_get_font_color
end type
type st_6 from statictext within w_get_font_color
end type
end forward

global type w_get_font_color from window
integer width = 1513
integer height = 676
boolean titlebar = true
string title = "Select text color"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_1 cb_1
st_6 st_6
end type
global w_get_font_color w_get_font_color

on w_get_font_color.create
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.st_6=create st_6
this.Control[]={this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.st_6}
end on

on w_get_font_color.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_6)
end on

type st_5 from statictext within w_get_font_color
integer x = 791
integer y = 200
integer width = 343
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "MAROON"
boolean focusrectangle = false
end type

event clicked;closewithreturn(parent ,"MAROON")
end event

type st_4 from statictext within w_get_font_color
integer x = 791
integer y = 92
integer width = 343
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 65535
long backcolor = 16777215
string text = "YELLOW"
boolean focusrectangle = false
end type

event clicked;closewithreturn(parent ,"YELLOW")
end event

type st_3 from statictext within w_get_font_color
integer x = 105
integer y = 300
integer width = 343
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 32768
long backcolor = 16777215
string text = "GREEN"
boolean focusrectangle = false
end type

event clicked;closewithreturn(parent ,"GREEN")
end event

type st_2 from statictext within w_get_font_color
integer x = 105
integer y = 200
integer width = 343
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "BLUE"
boolean focusrectangle = false
end type

event clicked;closewithreturn(parent ,"BLUE")

end event

type st_1 from statictext within w_get_font_color
integer x = 110
integer y = 92
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 16777215
string text = "RED"
boolean focusrectangle = false
end type

event clicked;closewithreturn(parent ,"RED")
end event

type cb_1 from commandbutton within w_get_font_color
integer x = 489
integer y = 444
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent ,"CANCEL")
end event

type st_6 from statictext within w_get_font_color
integer x = 791
integer y = 300
integer width = 343
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388736
long backcolor = 16777215
string text = "PURPLE"
boolean focusrectangle = false
end type

event clicked;closewithreturn(parent ,"PURPLE")
end event

