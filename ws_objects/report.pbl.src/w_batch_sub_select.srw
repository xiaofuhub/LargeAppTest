$PBExportHeader$w_batch_sub_select.srw
forward
global type w_batch_sub_select from window
end type
type cb_3 from commandbutton within w_batch_sub_select
end type
type dw_pracs from datawindow within w_batch_sub_select
end type
type cb_2 from commandbutton within w_batch_sub_select
end type
type cb_1 from commandbutton within w_batch_sub_select
end type
end forward

global type w_batch_sub_select from window
integer width = 1728
integer height = 2088
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
dw_pracs dw_pracs
cb_2 cb_2
cb_1 cb_1
end type
global w_batch_sub_select w_batch_sub_select

type variables
gs_batch_search ist_search
end variables

on w_batch_sub_select.create
this.cb_3=create cb_3
this.dw_pracs=create dw_pracs
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.dw_pracs,&
this.cb_2,&
this.cb_1}
end on

on w_batch_sub_select.destroy
destroy(this.cb_3)
destroy(this.dw_pracs)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;ist_search = message.powerobjectparm

dw_pracs.settransobject(sqlca)
dw_pracs.retrieve(ist_search.li_prac_id)


end event

type cb_3 from commandbutton within w_batch_sub_select
integer x = 50
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Deselect All"
end type

event clicked;long i
integer v

if this.text = "Deselect All" then
	v = 0
	this.text = "Select All"
else
	v = 1
	this.text = "Deselect All"
end if

for i = 1 to dw_pracs.rowcount()
	dw_pracs.setitem(i,"selected", v)
next
end event

type dw_pracs from datawindow within w_batch_sub_select
integer x = 55
integer y = 164
integer width = 1568
integer height = 1820
integer taborder = 30
string title = "none"
string dataobject = "d_practitioner_list_select"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_batch_sub_select
integer x = 1275
integer y = 36
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

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_1 from commandbutton within w_batch_sub_select
integer x = 663
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;long rc
long r
long ll_null[]
string ls_null[]
gs_batch_search lst_search

//setnull(ll_null)
//setnull(ls_null)
//ist_search.li_prac_id = ll_null
//ist_search.ls_name = ls_null
lst_search.ll_app = ist_search.ll_app
lst_search.ll_facility = ist_search.ll_facility



for r = 1 to dw_pracs.rowcount()
	if dw_pracs.getItemNumber(r,"selected") = 1 then
		rc++
		lst_search.li_prac_id[rc] = dw_pracs.getItemNumber(r,"prac_id")
		lst_search.ls_name[rc] = dw_pracs.GetItemString(r,"full_name")
	end if
next

ist_search = lst_search

closewithreturn(parent,ist_search)


end event

