$PBExportHeader$w_select_application.srw
forward
global type w_select_application from window
end type
type st_1 from statictext within w_select_application
end type
type dw_1 from datawindow within w_select_application
end type
type cb_2 from commandbutton within w_select_application
end type
type cb_1 from commandbutton within w_select_application
end type
end forward

global type w_select_application from window
integer x = 837
integer y = 640
integer width = 2062
integer height = 288
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_select_application w_select_application

type variables
long il_app
end variables

on w_select_application.create
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_select_application.destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//maha created 080304

dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_1.insertrow(1)
end event

type st_1 from statictext within w_select_application
integer x = 110
integer y = 20
integer width = 507
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Application"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_select_application
integer x = 78
integer y = 92
integer width = 1339
integer height = 96
integer taborder = 10
string dataobject = "d_select_application_payor"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_app = long(data)
end event

type cb_2 from commandbutton within w_select_application
integer x = 1728
integer y = 100
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,-1)
end event

type cb_1 from commandbutton within w_select_application
integer x = 1472
integer y = 100
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;if il_app < 1 then
	messagebox("Application?","Please select an Application/Payor or cancel.")
	return 1
end if

closewithreturn(parent,il_app)
end event

