$PBExportHeader$w_app_page_steps.srw
forward
global type w_app_page_steps from window
end type
type st_2 from statictext within w_app_page_steps
end type
type st_1 from statictext within w_app_page_steps
end type
type cb_close from commandbutton within w_app_page_steps
end type
type cb_add from commandbutton within w_app_page_steps
end type
type cb_2 from commandbutton within w_app_page_steps
end type
type cb_save from commandbutton within w_app_page_steps
end type
type dw_1 from datawindow within w_app_page_steps
end type
end forward

global type w_app_page_steps from window
integer width = 1865
integer height = 2272
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
cb_close cb_close
cb_add cb_add
cb_2 cb_2
cb_save cb_save
dw_1 dw_1
end type
global w_app_page_steps w_app_page_steps

type variables
long il_app_id
integer ii_page
boolean ib_add = false
end variables

on w_app_page_steps.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_add=create cb_add
this.cb_2=create cb_2
this.cb_save=create cb_save
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_close,&
this.cb_add,&
this.cb_2,&
this.cb_save,&
this.dw_1}
end on

on w_app_page_steps.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_add)
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;//Start Code Change ----10.17.2013 #V14 maha - Created

gs_pass_ids lst_ids

lst_ids = message.powerobjectparm

il_app_id = lst_ids.l_app_id
ii_page = lst_ids.committee_id

dw_1.settransobject(sqlca)
dw_1.retrieve(il_app_id, ii_page)
end event

type st_2 from statictext within w_app_page_steps
integer x = 27
integer y = 132
integer width = 1783
integer height = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "For example, on a page maybe the first thing you have to do is select a radio button or dropdown that will dynamically modify the way that page works. You can make a step note to that effect for populating the webpage."
boolean focusrectangle = false
end type

type st_1 from statictext within w_app_page_steps
integer x = 27
integer y = 8
integer width = 1783
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "The step records allow the user to make page specific notes about a website page."
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_app_page_steps
integer x = 1445
integer y = 376
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_add from commandbutton within w_app_page_steps
integer x = 402
integer y = 376
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;integer nr

nr = dw_1.insertrow(0)
dw_1.scrolltorow(nr)

dw_1.setitem(nr,"app_id", il_app_id)
dw_1.setitem(nr,"page", ii_page)

ib_add = true
end event

type cb_2 from commandbutton within w_app_page_steps
integer x = 745
integer y = 376
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;dw_1.deleterow(0)
end event

type cb_save from commandbutton within w_app_page_steps
integer x = 55
integer y = 376
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer r
long ll_apspk

if ib_add = true then
	select max(aps_id) into :ll_apspk from app_page_steps;	
	if isnull(ll_apspk) then ll_apspk = 0
end if

dw_1.sort()

for r = 1 to dw_1.rowcount()
	dw_1.setitem(r,"sort_order", r)
	if isnull(dw_1.getitemnumber(r,"aps_id")) then
		ll_apspk++
		dw_1.setitem(r,"aps_id", ll_apspk)
	end if
next


dw_1.update()
end event

type dw_1 from datawindow within w_app_page_steps
integer x = 41
integer y = 488
integer width = 1760
integer height = 1772
integer taborder = 10
string title = "none"
string dataobject = "d_app_page_steps"
boolean vscrollbar = true
boolean livescroll = true
end type

