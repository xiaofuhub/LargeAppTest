$PBExportHeader$w_selected_prac_list.srw
forward
global type w_selected_prac_list from window
end type
type cb_close from commandbutton within w_selected_prac_list
end type
type cb_del from commandbutton within w_selected_prac_list
end type
type dw_list from datawindow within w_selected_prac_list
end type
type dw_copy from datawindow within w_selected_prac_list
end type
end forward

global type w_selected_prac_list from window
integer x = 914
integer y = 80
integer width = 1376
integer height = 1728
boolean titlebar = true
string title = "Edit Practitioner Batch"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_close cb_close
cb_del cb_del
dw_list dw_list
dw_copy dw_copy
end type
global w_selected_prac_list w_selected_prac_list

type variables
long il_batch_id
end variables

event open;long ll_prac_ids[]
string bname
string ls_title
gs_batch_search ist_search

ist_search = message.powerobjectparm
ll_prac_ids[] = ist_search.li_prac_id[]

//---------Begin Added by (Appeon)Stephen 2013-10-15 for BugL100802--------
ls_title = ist_search.ls_title
if left(ls_title, 2) = 'T^' then
	ls_title = mid(ls_title, 3)
	this.title = ls_title
end if
//---------End Added ------------------------------------------------------

//b = message.powerobjectparm

dw_list.settransobject(sqlca)
dw_list.retrieve(ll_prac_ids[])

//dw_name.settransobject(sqlca)
//dw_name.retrieve(b)

//il_batch_id = b
end event

on w_selected_prac_list.create
this.cb_close=create cb_close
this.cb_del=create cb_del
this.dw_list=create dw_list
this.dw_copy=create dw_copy
this.Control[]={this.cb_close,&
this.cb_del,&
this.dw_list,&
this.dw_copy}
end on

on w_selected_prac_list.destroy
destroy(this.cb_close)
destroy(this.cb_del)
destroy(this.dw_list)
destroy(this.dw_copy)
end on

type cb_close from commandbutton within w_selected_prac_list
integer x = 462
integer y = 1520
integer width = 265
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;closewithreturn(parent,il_batch_id)
end event

type cb_del from commandbutton within w_selected_prac_list
integer x = 242
integer y = 1756
integer width = 265
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Remove"
end type

event clicked;integer r
integer res

//res = messagebox("Delete","Are you sure you wish to delete the selected practitioner?",question!,yesno!,2)

//if res = 1 then
	dw_list.deleterow(dw_list.getrow())
	//dw_list.update()
	//commit using sqlca;
//end if

dw_list.selectrow(dw_list.getrow(),true)

for r = 1 to dw_list.rowcount()
	dw_list.setitem(r,"item_id",r)
next

dw_list.update()
end event

type dw_list from datawindow within w_selected_prac_list
integer y = 8
integer width = 1362
integer height = 1460
integer taborder = 10
string dataobject = "d_selected_prac_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
end event

event rowfocuschanged;


this.selectrow(0,false)
this.selectrow(this.getrow(),true)
end event

type dw_copy from datawindow within w_selected_prac_list
boolean visible = false
integer x = 1143
integer y = 1496
integer width = 494
integer height = 360
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_batch_items_list_w_name"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

