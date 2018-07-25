$PBExportHeader$w_recruit_group_select.srw
forward
global type w_recruit_group_select from w_popup
end type
type cb_2 from commandbutton within w_recruit_group_select
end type
type sle_search from singlelineedit within w_recruit_group_select
end type
type cb_can from commandbutton within w_recruit_group_select
end type
type cb_select from commandbutton within w_recruit_group_select
end type
type cb_close from commandbutton within w_recruit_group_select
end type
type dw_browse from u_dw within w_recruit_group_select
end type
end forward

global type w_recruit_group_select from w_popup
integer width = 2455
integer height = 1324
string title = "Recruitment Hiring Groups/Committees"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_2 cb_2
sle_search sle_search
cb_can cb_can
cb_select cb_select
cb_close cb_close
dw_browse dw_browse
end type
global w_recruit_group_select w_recruit_group_select

type variables
boolean ab_new = false
end variables

on w_recruit_group_select.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.sle_search=create sle_search
this.cb_can=create cb_can
this.cb_select=create cb_select
this.cb_close=create cb_close
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.sle_search
this.Control[iCurrent+3]=this.cb_can
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_browse
end on

on w_recruit_group_select.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.sle_search)
destroy(this.cb_can)
destroy(this.cb_select)
destroy(this.cb_close)
destroy(this.dw_browse)
end on

event open;call super::open;//Start Code Change ----01.08.2015 #V14.2 maha - added for v15
long rid


rid = dw_browse.retrieve()

if rid = 0 then return

dw_browse.selectrow(1,true)

rid = dw_browse.getitemnumber(1, "group_id")


end event

type cb_2 from commandbutton within w_recruit_group_select
integer x = 896
integer y = 36
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
end type

event clicked;string ls_search
integer li_found

ls_search = upper(sle_search.text)

li_found = 	dw_browse.find( "upper(rec_name) like '%" + ls_search + "%'", dw_browse.getrow() + 1,	dw_browse.rowcount())

if li_found < 0 then
	messagebox("Find failure","Incorrect syntax, contract ISG support")
elseif li_found > 0 then
	dw_browse.scrolltorow(li_found)
	dw_browse.selectrow(0,false)
	dw_browse.selectrow(li_found,true)
	dw_browse.setrow(li_found)
else // 0
	//st_notfound.visible = true
end if
end event

type sle_search from singlelineedit within w_recruit_group_select
integer x = 14
integer y = 40
integer width = 823
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_can from commandbutton within w_recruit_group_select
integer x = 2016
integer y = 36
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_select from commandbutton within w_recruit_group_select
integer x = 1422
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;long ll_rec
long rid
long f

if dw_browse.getrow() < 1 then return

ll_rec = dw_browse.getitemnumber(dw_browse.getrow(), "group_id")
closewithreturn(parent,ll_rec)

end event

type cb_close from commandbutton within w_recruit_group_select
integer x = 3918
integer y = 40
integer width = 343
integer height = 92
integer taborder = 10
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

type dw_browse from u_dw within w_recruit_group_select
integer y = 156
integer width = 2446
integer height = 1088
integer taborder = 60
boolean titlebar = true
string title = "Hiring Groups/Committees"
string dataobject = "d_recruit_hire_group_browse"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)

end event

event rowfocuschanged;call super::rowfocuschanged;long rid

this.selectrow(0,false)
this.selectrow(currentrow,true)

rid = this.getitemnumber(currentrow, "group_id")






end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

event doubleclicked;call super::doubleclicked;cb_select.triggerevent(clicked!)
end event

