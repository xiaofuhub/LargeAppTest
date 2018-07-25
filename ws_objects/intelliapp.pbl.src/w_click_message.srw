$PBExportHeader$w_click_message.srw
forward
global type w_click_message from w_popup
end type
type st_1 from statictext within w_click_message
end type
end forward

global type w_click_message from w_popup
integer x = 590
integer y = 224
integer width = 2446
integer height = 144
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 33551856
st_1 st_1
end type
global w_click_message w_click_message

on w_click_message.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_click_message.destroy
call super::destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_click_message
integer x = 41
integer y = 36
integer width = 2117
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = " Click the position on the image where you want to place copy of fields."
boolean focusrectangle = false
end type

