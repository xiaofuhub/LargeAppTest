$PBExportHeader$w_scan_format.srw
forward
global type w_scan_format from window
end type
type ddlb_1 from dropdownlistbox within w_scan_format
end type
type cb_2 from commandbutton within w_scan_format
end type
type cb_1 from commandbutton within w_scan_format
end type
end forward

global type w_scan_format from window
integer x = 1056
integer y = 484
integer width = 1243
integer height = 312
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 33551856
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
end type
global w_scan_format w_scan_format

type variables
integer ii_type = 0
end variables

on w_scan_format.create
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.ddlb_1,&
this.cb_2,&
this.cb_1}
end on

on w_scan_format.destroy
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type ddlb_1 from dropdownlistbox within w_scan_format
integer x = 32
integer y = 60
integer width = 553
integer height = 304
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Black & White","Grey Scale"}
end type

event selectionchanged;if index = 1 then
	ii_type = 1
elseif index = 2 then
	ii_type = 2
end if
end event

type cb_2 from commandbutton within w_scan_format
integer x = 891
integer y = 56
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

type cb_1 from commandbutton within w_scan_format
integer x = 622
integer y = 56
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

event clicked;if ii_type = 0 then ii_type = -1
closewithreturn(parent,ii_type)
end event

