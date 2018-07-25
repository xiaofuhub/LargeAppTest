$PBExportHeader$w_repair_screen_picture.srw
forward
global type w_repair_screen_picture from window
end type
type st_2 from statictext within w_repair_screen_picture
end type
type st_1 from statictext within w_repair_screen_picture
end type
type cb_1 from commandbutton within w_repair_screen_picture
end type
end forward

global type w_repair_screen_picture from window
integer width = 1481
integer height = 1032
boolean titlebar = true
string title = "Repair screen picture issue."
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
cb_1 cb_1
end type
global w_repair_screen_picture w_repair_screen_picture

on w_repair_screen_picture.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_1}
end on

on w_repair_screen_picture.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

type st_2 from statictext within w_repair_screen_picture
integer x = 32
integer y = 228
integer width = 1413
integer height = 300
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Solution: 1. new version after 14.2 has this issue fixed.                2. execute the following repair button which will place a red X image in the picture objects with this issue for screens in all views. The user can select new image for objects that display this image to fix the issue."
boolean focusrectangle = false
end type

type st_1 from statictext within w_repair_screen_picture
integer x = 32
integer y = 16
integer width = 1422
integer height = 184
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Cause: Picture files are not saved in the database when copying picture objects in the Screen Painter, which causes the picture objects to fail to display the pictures."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_repair_screen_picture
integer x = 105
integer y = 644
integer width = 1248
integer height = 228
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Repair"
end type

event clicked;//added by gavins 20131014
n_cst_update_screen   ln_cst_update_screen


ln_cst_update_screen = Create n_cst_update_screen

ln_cst_update_screen.of_Repair_picture( )
end event

