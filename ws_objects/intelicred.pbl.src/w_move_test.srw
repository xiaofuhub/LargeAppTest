$PBExportHeader$w_move_test.srw
forward
global type w_move_test from window
end type
type st_1 from statictext within w_move_test
end type
end forward

global type w_move_test from window
integer width = 2519
integer height = 1516
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
end type
global w_move_test w_move_test

event timer;of_move_window(this, this.x, this.y, gs_dir_y , gs_dir_x)
end event

on w_move_test.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_move_test.destroy
destroy(this.st_1)
end on

event open;Timer ( 1  )
end event

type st_1 from statictext within w_move_test
integer x = 521
integer y = 564
integer width = 1248
integer height = 192
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 29935871
string text = "This window is moving"
alignment alignment = center!
boolean focusrectangle = false
end type

