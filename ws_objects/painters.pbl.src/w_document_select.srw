$PBExportHeader$w_document_select.srw
forward
global type w_document_select from window
end type
type dw_1 from datawindow within w_document_select
end type
type cb_close from commandbutton within w_document_select
end type
type cb_select from commandbutton within w_document_select
end type
end forward

global type w_document_select from window
integer width = 2510
integer height = 2468
boolean titlebar = true
string title = "Select Letter Template"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_close cb_close
cb_select cb_select
end type
global w_document_select w_document_select

event open;long f
integer a
string s

f = message.doubleparm
debugbreak()
if f = 0 then
	a = 1
else
	select letter_path into :s from facility where facility_id = :f;
	a = integer(s)
end if

dw_1.settransobject( sqlca)
dw_1.retrieve(a)
end event

on w_document_select.create
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_select=create cb_select
this.Control[]={this.dw_1,&
this.cb_close,&
this.cb_select}
end on

on w_document_select.destroy
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_select)
end on

type dw_1 from datawindow within w_document_select
integer width = 2482
integer height = 2232
integer taborder = 10
string title = "none"
string dataobject = "d_document_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event doubleclicked;integer t

t = this.getitemnumber(row,"dct_id")

closewithreturn(parent,t)
end event

type cb_close from commandbutton within w_document_select
integer x = 1161
integer y = 2248
integer width = 343
integer height = 92
integer taborder = 20
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

type cb_select from commandbutton within w_document_select
integer x = 795
integer y = 2248
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;integer t

t = dw_1.getitemnumber(dw_1.getrow() ,"dct_id")

closewithreturn(parent,t)
end event

