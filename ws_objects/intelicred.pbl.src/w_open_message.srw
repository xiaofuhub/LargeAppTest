$PBExportHeader$w_open_message.srw
forward
global type w_open_message from window
end type
type st_2 from statictext within w_open_message
end type
type hpb_1 from hprogressbar within w_open_message
end type
type st_1 from statictext within w_open_message
end type
end forward

global type w_open_message from window
integer width = 1801
integer height = 412
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
hpb_1 hpb_1
st_1 st_1
end type
global w_open_message w_open_message

on w_open_message.create
this.st_2=create st_2
this.hpb_1=create hpb_1
this.st_1=create st_1
this.Control[]={this.st_2,&
this.hpb_1,&
this.st_1}
end on

on w_open_message.destroy
destroy(this.st_2)
destroy(this.hpb_1)
destroy(this.st_1)
end on

event open;string s

s = message.stringparm

st_1.text = s

//hpb_1.minposition = 0
//hpb_1.maxposition = 100
//hpb_1.position = 0


timer( 1)
end event

event timer;hpb_1.stepit( )
end event

type st_2 from statictext within w_open_message
integer y = 520
integer width = 1769
integer height = 104
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_open_message
integer x = 146
integer y = 236
integer width = 1472
integer height = 64
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

event constructor;this.setrange(0,100)
this.setstep = 10
end event

type st_1 from statictext within w_open_message
integer x = 9
integer y = 88
integer width = 1769
integer height = 104
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Getting Data Caches"
alignment alignment = center!
boolean focusrectangle = false
end type

