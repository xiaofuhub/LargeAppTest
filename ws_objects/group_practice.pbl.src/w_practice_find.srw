$PBExportHeader$w_practice_find.srw
forward
global type w_practice_find from window
end type
type rb_pho from radiobutton within w_practice_find
end type
type rb_addr from radiobutton within w_practice_find
end type
type cb_3 from commandbutton within w_practice_find
end type
type cb_2 from commandbutton within w_practice_find
end type
type dw_1 from datawindow within w_practice_find
end type
type cb_1 from commandbutton within w_practice_find
end type
type sle_1 from singlelineedit within w_practice_find
end type
end forward

global type w_practice_find from window
integer x = 887
integer y = 524
integer width = 2226
integer height = 1432
boolean titlebar = true
string title = "Find  Practitioner Address Record"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
rb_pho rb_pho
rb_addr rb_addr
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
end type
global w_practice_find w_practice_find

type variables
long il_addr_id
end variables

on w_practice_find.create
this.rb_pho=create rb_pho
this.rb_addr=create rb_addr
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.Control[]={this.rb_pho,&
this.rb_addr,&
this.cb_3,&
this.cb_2,&
this.dw_1,&
this.cb_1,&
this.sle_1}
end on

on w_practice_find.destroy
destroy(this.rb_pho)
destroy(this.rb_addr)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
end on

type rb_pho from radiobutton within w_practice_find
integer x = 1134
integer y = 60
integer width = 471
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Search by Phone"
end type

type rb_addr from radiobutton within w_practice_find
integer x = 251
integer y = 60
integer width = 869
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Search by Address (Street 1 or 2)"
boolean checked = true
end type

type cb_3 from commandbutton within w_practice_find
integer x = 1925
integer y = 1132
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_2 from commandbutton within w_practice_find
integer x = 1646
integer y = 1132
integer width = 265
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Populate"
end type

event clicked;CloseWithReturn(Parent, il_addr_id)
end event

type dw_1 from datawindow within w_practice_find
integer x = 46
integer y = 284
integer width = 2121
integer height = 812
integer taborder = 30
string dataobject = "d_addresses_street"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;integer li_row

li_row = this.GetClickedRow()

if li_Row <= 0 then return 		//Added by Scofield on 2008-01-04

dw_1.SetRow(li_row)
dw_1.SelectRow(0,false)
dw_1.SelectRow(li_row,true)

il_Addr_Id = dw_1.GetItemNumber(li_row,"rec_id")

end event

event doubleclicked;closewithreturn(parent,il_addr_id)
end event

type cb_1 from commandbutton within w_practice_find
integer x = 1623
integer y = 164
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
boolean default = true
end type

event clicked;string ls_search
integer res

ls_search = trim(sle_1.text)

if ls_search = "" then
	MessageBox("value","enter value")
	return
else
	ls_search = "%" + ls_search + "%"
end if

if rb_addr.checked = true then
	dw_1.dataobject = "d_addresses_streets"
else 
	dw_1.dataobject = "d_addresses_phone"
end if

dw_1.SetTransObject(sqlca)
res = dw_1.Retrieve(ls_search)

if res < 1 then MessageBox("No Records","No Match found")

sle_1.SetFocus()

end event

type sle_1 from singlelineedit within w_practice_find
integer x = 247
integer y = 164
integer width = 1349
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

