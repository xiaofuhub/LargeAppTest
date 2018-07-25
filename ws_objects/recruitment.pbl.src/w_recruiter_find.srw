$PBExportHeader$w_recruiter_find.srw
forward
global type w_recruiter_find from w_popup
end type
type cb_new from commandbutton within w_recruiter_find
end type
type cb_2 from commandbutton within w_recruiter_find
end type
type sle_search from singlelineedit within w_recruiter_find
end type
type cb_1 from commandbutton within w_recruiter_find
end type
type cb_close from commandbutton within w_recruiter_find
end type
type dw_browse from u_dw within w_recruiter_find
end type
end forward

global type w_recruiter_find from w_popup
integer width = 1563
integer height = 1880
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_new cb_new
cb_2 cb_2
sle_search sle_search
cb_1 cb_1
cb_close cb_close
dw_browse dw_browse
end type
global w_recruiter_find w_recruiter_find

type variables
boolean ab_new = false
boolean ib_single = false
end variables

on w_recruiter_find.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_2=create cb_2
this.sle_search=create sle_search
this.cb_1=create cb_1
this.cb_close=create cb_close
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.sle_search
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_browse
end on

on w_recruiter_find.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_2)
destroy(this.sle_search)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.dw_browse)
end on

event open;call super::open;//Start Code Change ----01.08.2015 #V14.2 maha - added for v15
long rid

//Start Code Change ----04.01.2016 #V15 maha
if message.stringparm = "S" then
	dw_browse.dataobject = "d_recruiters_list"
	dw_browse.settransobject(sqlca)
	ib_single = true
end if
//End Code Change ----04.01.2016

rid = dw_browse.retrieve()

if rid = 0 then return

dw_browse.selectrow(1,true)

end event

type cb_new from commandbutton within w_recruiter_find
integer x = 1166
integer y = 32
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add New"
end type

event clicked;long rid, f


open(w_recruiter_add_new)

if message.stringparm = "Cancel" then return

rid = message.doubleparm

dw_browse.retrieve()
f = dw_browse.find("rec_id = " + string(rid), 1, dw_browse.rowcount())

if f > 0 then
	dw_browse.setitem(f,"selected", 1)
end if



end event

type cb_2 from commandbutton within w_recruiter_find
integer x = 773
integer y = 32
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

//li_found = 	dw_browse.find( "upper(rec_name) like '%" + ls_search + "%'", dw_browse.getrow() + 1,	dw_browse.rowcount())
li_found = 	dw_browse.find( "upper(compute_1) like '%" + ls_search + "%'", dw_browse.getrow() + 1,	dw_browse.rowcount()) //Modified by Appeon long.zhang 12.14.2015 (BugL121106)

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

type sle_search from singlelineedit within w_recruiter_find
integer x = 73
integer y = 36
integer width = 690
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

type cb_1 from commandbutton within w_recruiter_find
integer x = 389
integer y = 1656
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;long r, c
long ll_rec
string s
gs_pass_ids ls_pass

//Start Code Change ----04.01.2016 #V15 maha
if ib_single = true then
	r = dw_browse.getrow()
	if r > 0 then
		ll_rec = dw_browse.getitemnumber(r,"rec_id")   //Start Code Change ----02.13.2017 #V153 maha
		s = dw_browse.getitemstring(r, "compute_1")
		ls_pass.l_ids[1] = ll_rec
		ls_pass.s_doc_ids[1] = s
	end if
	closewithreturn(parent,ls_pass)
	
else //multiple
	r = dw_browse.find( "selected = 1", 1, dw_browse.rowcount())
	
	 //Start Code Change ----08.18.2015 #V15 maha - modified for multi-select
	if r < 1 then
		closewithreturn(parent,"Cancel")
	else
		for r = 1 to dw_browse.rowcount()
			if dw_browse.getitemnumber(r,"selected") = 1 then
				c++
				ll_rec = dw_browse.getitemnumber(r,"rec_id")
				s = dw_browse.getitemstring(r, "compute_1")
				ls_pass.l_ids[c] = ll_rec
				ls_pass.s_doc_ids[c] = s
			end if
		next
		closewithreturn(parent,ls_pass)
	end if
end if
end event

type cb_close from commandbutton within w_recruiter_find
integer x = 809
integer y = 1656
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type dw_browse from u_dw within w_recruiter_find
integer y = 144
integer width = 1550
integer height = 1500
integer taborder = 60
boolean titlebar = true
string title = "Recruiters/members"
string dataobject = "d_recruiters_list_select"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.of_setupdateable( false)

end event

event rowfocuschanged;call super::rowfocuschanged;long rid

this.selectrow(0,false)
this.selectrow(currentrow,true)



end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

