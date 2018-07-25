$PBExportHeader$w_inventory_edit.srw
forward
global type w_inventory_edit from window
end type
type p_1 from picture within w_inventory_edit
end type
type cb_4 from commandbutton within w_inventory_edit
end type
type cb_3 from commandbutton within w_inventory_edit
end type
type cb_2 from commandbutton within w_inventory_edit
end type
type cb_1 from commandbutton within w_inventory_edit
end type
type dw_1 from datawindow within w_inventory_edit
end type
end forward

global type w_inventory_edit from window
integer x = 78
integer y = 368
integer width = 3241
integer height = 1504
boolean titlebar = true
string title = "Inventory Items"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
p_1 p_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_inventory_edit w_inventory_edit

on w_inventory_edit.create
this.p_1=create p_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.p_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_inventory_edit.destroy
destroy(this.p_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type p_1 from picture within w_inventory_edit
boolean visible = false
integer x = 699
integer y = 44
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Custom035!"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_inventory_edit
integer x = 2921
integer y = 32
integer width = 265
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close( Parent)
end event

type cb_3 from commandbutton within w_inventory_edit
integer x = 2656
integer y = 32
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;long i
long id

select max(invt_id) into :id from invt_items;
if isnull(id ) then id = 0

for i = 1 to dw_1.rowcount()
	if isnull(dw_1.getitemstring(i,"description")) then 
		messagebox("Data Entry Error","Description cannot be blank for row " + string(i))
		return -1
	end if
	
	if isnull(dw_1.getitemnumber(i,"invt_id")) then 
		id++
		dw_1.setitem(i,"invt_id",id)
	end if
next

dw_1.update()
end event

type cb_2 from commandbutton within w_inventory_edit
integer x = 2386
integer y = 32
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res

res = messagebox("Delete","Are you sure you wish to delete this row? ",question!,yesno!,1)
if res = 2 then return

dw_1.deleterow(dw_1.getrow())
end event

type cb_1 from commandbutton within w_inventory_edit
integer x = 2112
integer y = 32
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;long nr

nr = dw_1.insertrow(0)
dw_1.scrolltorow(nr)
dw_1.setrow(nr)
dw_1.setfocus()
end event

type dw_1 from datawindow within w_inventory_edit
integer x = 18
integer y = 136
integer width = 3173
integer height = 1248
integer taborder = 40
string dataobject = "d_inventory_de"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.setrowfocusindicator(p_1)
end event

