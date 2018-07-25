$PBExportHeader$w_delete_exp.srw
forward
global type w_delete_exp from window
end type
type cbx_c from checkbox within w_delete_exp
end type
type cbx_a from checkbox within w_delete_exp
end type
type cbx_f from checkbox within w_delete_exp
end type
type cbx_t from checkbox within w_delete_exp
end type
type st_1 from statictext within w_delete_exp
end type
type cb_2 from commandbutton within w_delete_exp
end type
type cb_1 from commandbutton within w_delete_exp
end type
type dw_1 from datawindow within w_delete_exp
end type
end forward

global type w_delete_exp from window
integer x = 1056
integer y = 484
integer width = 1518
integer height = 1064
boolean titlebar = true
string title = "Export Delete"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cbx_c cbx_c
cbx_a cbx_a
cbx_f cbx_f
cbx_t cbx_t
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_delete_exp w_delete_exp

type variables
integer ii_exp
end variables

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_1.insertrow(1)
end event

on w_delete_exp.create
this.cbx_c=create cbx_c
this.cbx_a=create cbx_a
this.cbx_f=create cbx_f
this.cbx_t=create cbx_t
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cbx_c,&
this.cbx_a,&
this.cbx_f,&
this.cbx_t,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_delete_exp.destroy
destroy(this.cbx_c)
destroy(this.cbx_a)
destroy(this.cbx_f)
destroy(this.cbx_t)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cbx_c from checkbox within w_delete_exp
integer x = 389
integer y = 548
integer width = 599
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete Equiv Codes"
end type

type cbx_a from checkbox within w_delete_exp
integer x = 389
integer y = 456
integer width = 617
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete Auto Exports"
end type

type cbx_f from checkbox within w_delete_exp
integer x = 389
integer y = 356
integer width = 622
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete Export Fields"
end type

type cbx_t from checkbox within w_delete_exp
integer x = 389
integer y = 264
integer width = 649
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete Export Header"
end type

type st_1 from statictext within w_delete_exp
integer x = 315
integer y = 52
integer width = 366
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select export"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_delete_exp
integer x = 1074
integer y = 756
integer width = 270
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close (Parent)
end event

type cb_1 from commandbutton within w_delete_exp
integer x = 576
integer y = 756
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;integer ck



if ii_exp < 1 then return

ck = messagebox("Delete","Are you sure you wish to delete the selected records",question!,yesno!,2)

if ck = 2 then 
	return
else
	if cbx_t.checked = true then
		delete from export_header where export_id = :ii_exp;
	end if
	if cbx_f.checked = true then
		delete from export_fields where export_id = :ii_exp;
	end if
	if cbx_a.checked = true then
		delete from export_auto_settings where export_id = :ii_exp;
	end if
	if cbx_c.checked = true then
		delete from export_equiv_code where export_id = :ii_exp;
	end if
end if



messagebox("Delete","Completed")
end event

type dw_1 from datawindow within w_delete_exp
integer x = 302
integer y = 132
integer width = 864
integer height = 108
integer taborder = 10
string dataobject = "d_exp_select"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;ii_exp = integer(data)
end event

