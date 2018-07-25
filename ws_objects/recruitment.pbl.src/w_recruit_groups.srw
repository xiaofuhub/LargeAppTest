$PBExportHeader$w_recruit_groups.srw
forward
global type w_recruit_groups from w_popup
end type
type cb_delete_group from commandbutton within w_recruit_groups
end type
type cb_add_group from commandbutton within w_recruit_groups
end type
type dw_member from u_dw within w_recruit_groups
end type
type cb_2 from commandbutton within w_recruit_groups
end type
type sle_search from singlelineedit within w_recruit_groups
end type
type cb_del from commandbutton within w_recruit_groups
end type
type cb_add from commandbutton within w_recruit_groups
end type
type cb_save from commandbutton within w_recruit_groups
end type
type cb_close from commandbutton within w_recruit_groups
end type
type dw_browse from u_dw within w_recruit_groups
end type
type dw_detail from u_dw within w_recruit_groups
end type
end forward

global type w_recruit_groups from w_popup
integer x = 214
integer y = 221
integer width = 4370
integer height = 2544
string title = "Recruitment Hiring Groups/Committees"
long backcolor = 33551856
cb_delete_group cb_delete_group
cb_add_group cb_add_group
dw_member dw_member
cb_2 cb_2
sle_search sle_search
cb_del cb_del
cb_add cb_add
cb_save cb_save
cb_close cb_close
dw_browse dw_browse
dw_detail dw_detail
end type
global w_recruit_groups w_recruit_groups

type variables
boolean ab_new = false
end variables

on w_recruit_groups.create
int iCurrent
call super::create
this.cb_delete_group=create cb_delete_group
this.cb_add_group=create cb_add_group
this.dw_member=create dw_member
this.cb_2=create cb_2
this.sle_search=create sle_search
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete_group
this.Control[iCurrent+2]=this.cb_add_group
this.Control[iCurrent+3]=this.dw_member
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.sle_search
this.Control[iCurrent+6]=this.cb_del
this.Control[iCurrent+7]=this.cb_add
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_browse
this.Control[iCurrent+11]=this.dw_detail
end on

on w_recruit_groups.destroy
call super::destroy
destroy(this.cb_delete_group)
destroy(this.cb_add_group)
destroy(this.dw_member)
destroy(this.cb_2)
destroy(this.sle_search)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.dw_detail)
end on

event open;call super::open;//Start Code Change ----01.08.2015 #V14.2 maha - added for v15
long rid


rid = dw_browse.retrieve()

if rid = 0 then return

dw_browse.selectrow(1,true)

rid = dw_browse.getitemnumber(1, "group_id")


end event

type cb_delete_group from commandbutton within w_recruit_groups
integer x = 4050
integer y = 1240
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer a

if dw_member.rowcount() < 1 then return

a = messagebox("Delete","Are you sure you want to delete the selected Group Member link?", question!,yesno!,2)

if a = 2 then return

dw_member.deleterow(0)

dw_member.update()
end event

type cb_add_group from commandbutton within w_recruit_groups
integer x = 3799
integer y = 1240
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked; //Start Code Change ----08.18.2015 #V15 maha
integer n, r, f
long g
long ll_group
gs_pass_ids ls_pass 

open(w_recruiter_find)

if message.stringparm = "Cancel" then
	return
else
	ll_group = dw_detail.getitemnumber(1,"group_id")
	ls_pass = message.powerobjectparm
	for r = 1 to upperbound(ls_pass.l_ids)
		g = ls_pass.l_ids[r]
		f = dw_member.find( "rec_id = " + string(g), 1, dw_browse.rowcount())
//messagebox("",f)
		if f = 0 then
			n = dw_member.insertrow(0)
			dw_member.setitem(n,"recruiter_groups_rec_id",g)
			dw_member.setitem(n,"recruiter_groups_group_id",ll_group )
			//messagebox("",g)
			dw_member.update()
			dw_member.retrieve(ll_group)
		end if
	next
end if


end event

type dw_member from u_dw within w_recruit_groups
integer x = 3323
integer y = 1332
integer width = 1001
integer height = 1100
integer taborder = 70
boolean titlebar = true
string title = "Recruiters/Members"
string dataobject = "d_recruiters_list_group"
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;if dwo.name = "b_clear" then
	this.setitem(row,"isg_user", "")
end if
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event clicked;call super::clicked; //Start Code Change ----08.18.2015 #V15 maha
long r

r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;call super::rowfocuschanged; //Start Code Change ----08.018.2015 #V15 maha
 this.selectrow(0, false) 
 this.selectrow(currentrow, true)
end event

event retrieveend;call super::retrieveend; //Start Code Change ----08.18.2015 #V15 maha
if rowcount > 0 then
	this.selectrow(0, false) 
 	this.selectrow(1, true)
end if
end event

type cb_2 from commandbutton within w_recruit_groups
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

type sle_search from singlelineedit within w_recruit_groups
integer x = 9
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

type cb_del from commandbutton within w_recruit_groups
integer x = 2409
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
string text = "&Delete"
end type

event clicked;integer a, r

if dw_detail.rowcount() < 1 then return

//check for connected records!!!

a = messagebox("Delete","Are you sure you want to delete the selected Committee?", question!,yesno!,2)

if a = 2 then return

for r = dw_member.rowcount() to 1 step -1
	dw_member.deleterow(1)
next
dw_member.update()

dw_detail.deleterow(1)

ab_new = false

cb_save.triggerevent(clicked!)


end event

type cb_add from commandbutton within w_recruit_groups
integer x = 2053
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
string text = "&Add"
end type

event clicked;dw_detail.insertrow(1)
dw_detail.setfocus()
ab_new = true

dw_member.reset()
cb_add_group.enabled = false
cb_delete_group.enabled = false
end event

type cb_save from commandbutton within w_recruit_groups
integer x = 1696
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
string text = "&Save"
end type

event clicked;long ll_rec
long rid
long f

if dw_detail.rowcount() < 1 then
	dw_detail.update()
	dw_browse.retrieve()
	return
end if

dw_detail.accepttext()
//---------Begin Modified by (Appeon)Stephen 04.11.2016 for BugS032903--------
//if dw_detail.getitemstatus(1,0, primary!) = notmodified! then return
if dw_detail.getitemstatus(1,0, primary!) = notmodified! then 
	cb_add_group.enabled = true
	cb_delete_group.enabled = true
	return
end if
//---------End Modfiied ------------------------------------------------------

ll_rec = dw_detail.getitemnumber(1, "group_id")

if ab_new then
	if isnull(ll_rec) then
		select max(group_id)	 into :rid from recruit_hire_group;
		if isnull(rid) then rid = 0
		ll_rec = rid + 1
		dw_detail.setitem(1, "group_id", ll_rec)
	end if
end if
	
dw_detail.update()

if ab_new then
	dw_browse.retrieve()
	f = dw_browse.find("group_id = " + string(ll_rec), 1, 1000000)
	if f > 0 then
		dw_browse.scrolltorow(f)
		dw_browse.setrow(f)	
	end if
end if

ab_new = false
cb_add_group.enabled = true
cb_delete_group.enabled = true
end event

type cb_close from commandbutton within w_recruit_groups
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

type dw_browse from u_dw within w_recruit_groups
integer y = 148
integer width = 4325
integer height = 1076
integer taborder = 60
boolean titlebar = true
string title = "Hiring Groups/Committees"
string dataobject = "d_recruit_hire_group_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)

end event

event rowfocuschanged;call super::rowfocuschanged;long rid

this.selectrow(0,false)
this.selectrow(currentrow,true)

rid = this.getitemnumber(currentrow, "group_id")
dw_detail.retrieve(rid)
dw_member.retrieve(rid)





end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

type dw_detail from u_dw within w_recruit_groups
integer y = 1232
integer width = 3314
integer height = 1200
integer taborder = 60
boolean titlebar = true
string title = "Detail"
string dataobject = "d_recruit_hire_group_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event buttonclicked;call super::buttonclicked;if dwo.name = "b_clear" then
	this.setitem(row,"isg_user", "")
end if
end event

