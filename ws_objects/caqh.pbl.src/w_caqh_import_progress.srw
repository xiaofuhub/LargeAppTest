$PBExportHeader$w_caqh_import_progress.srw
forward
global type w_caqh_import_progress from window
end type
type st_record from statictext within w_caqh_import_progress
end type
type st_message from statictext within w_caqh_import_progress
end type
type r_1 from rectangle within w_caqh_import_progress
end type
type r_progress from rectangle within w_caqh_import_progress
end type
end forward

global type w_caqh_import_progress from window
integer width = 2295
integer height = 548
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_record st_record
st_message st_message
r_1 r_1
r_progress r_progress
end type
global w_caqh_import_progress w_caqh_import_progress

on w_caqh_import_progress.create
this.st_record=create st_record
this.st_message=create st_message
this.r_1=create r_1
this.r_progress=create r_progress
this.Control[]={this.st_record,&
this.st_message,&
this.r_1,&
this.r_progress}
end on

on w_caqh_import_progress.destroy
destroy(this.st_record)
destroy(this.st_message)
destroy(this.r_1)
destroy(this.r_progress)
end on

type st_record from statictext within w_caqh_import_progress
integer x = 1289
integer y = 24
integer width = 887
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type st_message from statictext within w_caqh_import_progress
integer x = 64
integer y = 96
integer width = 2089
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_caqh_import_progress
integer linethickness = 8
long fillcolor = 16777215
integer x = 119
integer y = 300
integer width = 2053
integer height = 80
end type

type r_progress from rectangle within w_caqh_import_progress
integer linethickness = 4
long fillcolor = 16711680
integer x = 119
integer y = 312
integer width = 46
integer height = 56
end type

