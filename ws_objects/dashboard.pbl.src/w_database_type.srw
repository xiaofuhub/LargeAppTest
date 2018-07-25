$PBExportHeader$w_database_type.srw
forward
global type w_database_type from window
end type
type rb_2 from radiobutton within w_database_type
end type
type rb_1 from radiobutton within w_database_type
end type
end forward

global type w_database_type from window
integer width = 1179
integer height = 612
boolean titlebar = true
string title = "Select Database Connection"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
rb_2 rb_2
rb_1 rb_1
end type
global w_database_type w_database_type

on w_database_type.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.Control[]={this.rb_2,&
this.rb_1}
end on

on w_database_type.destroy
destroy(this.rb_2)
destroy(this.rb_1)
end on

type rb_2 from radiobutton within w_database_type
integer x = 242
integer y = 296
integer width = 635
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "MS SQL Server"
end type

event clicked;closewithreturn(parent, "SQL")
end event

type rb_1 from radiobutton within w_database_type
integer x = 242
integer y = 120
integer width = 594
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sybase ASA"
end type

event clicked;closewithreturn(parent, "ASA")
end event

