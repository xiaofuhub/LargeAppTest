$PBExportHeader$w_launch_page.srw
forward
global type w_launch_page from window
end type
type pb_9 from picturebutton within w_launch_page
end type
type pb_8 from picturebutton within w_launch_page
end type
type pb_7 from picturebutton within w_launch_page
end type
type pb_6 from picturebutton within w_launch_page
end type
type pb_5 from picturebutton within w_launch_page
end type
type pb_4 from picturebutton within w_launch_page
end type
type pb_3 from picturebutton within w_launch_page
end type
type pb_2 from picturebutton within w_launch_page
end type
type pb_1 from picturebutton within w_launch_page
end type
end forward

global type w_launch_page from window
integer width = 4635
integer height = 2904
boolean titlebar = true
string title = "Where would you like to go?"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
end type
global w_launch_page w_launch_page

on w_launch_page.create
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.pb_9,&
this.pb_8,&
this.pb_7,&
this.pb_6,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1}
end on

on w_launch_page.destroy
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
end on

type pb_9 from picturebutton within w_launch_page
integer x = 3054
integer y = 916
integer width = 1381
integer height = 864
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Web Veriifications"
string picturename = "C:\ISGDev\ver12.1\globe-icon.png"
long textcolor = 16711680
end type

type pb_8 from picturebutton within w_launch_page
integer x = 1559
integer y = 916
integer width = 1381
integer height = 864
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Profiles"
string picturename = "C:\ISGDev\ver12.1\doctor1.jpg"
long textcolor = 16711680
end type

type pb_7 from picturebutton within w_launch_page
integer x = 1559
integer y = 1844
integer width = 1381
integer height = 864
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Main Window"
string picturename = "C:\ISGDev\ver12.1\Splash-v12.png"
long textcolor = 16711680
end type

type pb_6 from picturebutton within w_launch_page
integer x = 3054
integer y = 1844
integer width = 1381
integer height = 864
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Applications"
string picturename = "C:\ISGDev\ver12.1\par.png"
long textcolor = 16711680
end type

type pb_5 from picturebutton within w_launch_page
integer x = 59
integer y = 916
integer width = 1381
integer height = 864
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Action Items"
string picturename = "C:\ISGDev\ver12.1\action.bmp"
long textcolor = 16711680
end type

type pb_4 from picturebutton within w_launch_page
integer x = 59
integer y = 1844
integer width = 1381
integer height = 864
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Groups"
string picturename = "C:\ISGDev\ver12.1\grouploc.png"
long textcolor = 16711680
end type

type pb_3 from picturebutton within w_launch_page
integer x = 1559
integer y = 12
integer width = 1381
integer height = 864
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Call Log"
string picturename = "C:\ISGDev\ver12.1\4PHONES.BMP"
long textcolor = 16711680
end type

type pb_2 from picturebutton within w_launch_page
integer x = 3054
integer y = 12
integer width = 1381
integer height = 864
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Contracts"
string picturename = "C:\ISGDev\ver12.1\delete.bmp"
long textcolor = 16711680
end type

type pb_1 from picturebutton within w_launch_page
integer x = 59
integer y = 12
integer width = 1381
integer height = 864
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Provider"
string picturename = "C:\ISGDev\ver12.1\prac.png"
long textcolor = 16711680
end type

