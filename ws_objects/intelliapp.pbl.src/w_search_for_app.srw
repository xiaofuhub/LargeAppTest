$PBExportHeader$w_search_for_app.srw
forward
global type w_search_for_app from window
end type
type st_2 from statictext within w_search_for_app
end type
type cb_1 from commandbutton within w_search_for_app
end type
type st_1 from statictext within w_search_for_app
end type
type cb_select from commandbutton within w_search_for_app
end type
type dw_1 from datawindow within w_search_for_app
end type
type sle_1 from singlelineedit within w_search_for_app
end type
type cb_find from commandbutton within w_search_for_app
end type
end forward

global type w_search_for_app from window
integer width = 2222
integer height = 1288
boolean titlebar = true
string title = "Search for App"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
cb_1 cb_1
st_1 st_1
cb_select cb_select
dw_1 dw_1
sle_1 sle_1
cb_find cb_find
end type
global w_search_for_app w_search_for_app

on w_search_for_app.create
this.st_2=create st_2
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_select=create cb_select
this.dw_1=create dw_1
this.sle_1=create sle_1
this.cb_find=create cb_find
this.Control[]={this.st_2,&
this.cb_1,&
this.st_1,&
this.cb_select,&
this.dw_1,&
this.sle_1,&
this.cb_find}
end on

on w_search_for_app.destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_select)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.cb_find)
end on

type st_2 from statictext within w_search_for_app
boolean visible = false
integer y = 1076
integer width = 1298
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "No Applications found for the value searched."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_search_for_app
integer x = 1847
integer y = 1072
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type st_1 from statictext within w_search_for_app
integer x = 174
integer width = 1024
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Enter name or part of name of Application"
boolean focusrectangle = false
end type

type cb_select from commandbutton within w_search_for_app
integer x = 1463
integer y = 1072
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;integer i
long appid

i = dw_1.getrow()

if i > 0 then
	appid = dw_1.getitemnumber(i,"app_id")
	closewithreturn(parent,appid)
end if
end event

type dw_1 from datawindow within w_search_for_app
integer y = 196
integer width = 2199
integer height = 868
integer taborder = 20
string title = "none"
string dataobject = "d_app_search"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;integer i

i = this.getclickedrow()

if 1 > 0 then 
	this.setrow(i)
	this.selectrow(0,false)
	this.selectrow(i,true)
end if


end event

event doubleclicked;cb_select.triggerevent(clicked!)
end event

type sle_1 from singlelineedit within w_search_for_app
integer x = 174
integer y = 72
integer width = 1385
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_find from commandbutton within w_search_for_app
integer x = 1627
integer y = 76
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;string ls_find
integer r


ls_find = sle_1.text

if LenA(ls_find) = 0 then
	messagebox("Search","Please Enter search value")
	return
else
	ls_find = "%" + ls_find + "%"
	r = dw_1.retrieve(ls_find)
	if r < 1 then
		st_2.visible = true
	else
		st_2.visible = false
	end if
end if
end event

