$PBExportHeader$w_user_import.srw
forward
global type w_user_import from window
end type
type st_2 from statictext within w_user_import
end type
type st_1 from statictext within w_user_import
end type
type uo_1 from pfc_cst_user_import within w_user_import
end type
end forward

global type w_user_import from window
integer width = 3241
integer height = 2296
boolean titlebar = true
string title = "User Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
uo_1 uo_1
end type
global w_user_import w_user_import

on w_user_import.create
this.st_2=create st_2
this.st_1=create st_1
this.uo_1=create uo_1
this.Control[]={this.st_2,&
this.st_1,&
this.uo_1}
end on

on w_user_import.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_1)
end on

event open;//uo_1.of_set_parent_window( This )
end event

type st_2 from statictext within w_user_import
integer x = 73
integer y = 112
integer width = 2853
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "B) Provider Data Field: will use the data in the selected field to create User Ids for all practitioners. "
boolean focusrectangle = false
end type

type st_1 from statictext within w_user_import
integer x = 73
integer y = 40
integer width = 2775
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Import method: A) File: delimited text file with no header row.  The first column must be the user name. "
boolean focusrectangle = false
end type

type uo_1 from pfc_cst_user_import within w_user_import
integer x = 14
integer y = 260
integer taborder = 160
end type

on uo_1.destroy
call pfc_cst_user_import::destroy
end on

