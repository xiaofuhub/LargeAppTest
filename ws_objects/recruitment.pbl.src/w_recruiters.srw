$PBExportHeader$w_recruiters.srw
forward
global type w_recruiters from w_popup
end type
type cb_add_group from commandbutton within w_recruiters
end type
type cb_delete_group from commandbutton within w_recruiters
end type
type dw_link from u_dw within w_recruiters
end type
type cb_2 from commandbutton within w_recruiters
end type
type sle_search from singlelineedit within w_recruiters
end type
type cb_1 from commandbutton within w_recruiters
end type
type cb_del from commandbutton within w_recruiters
end type
type cb_add from commandbutton within w_recruiters
end type
type cb_save from commandbutton within w_recruiters
end type
type cb_close from commandbutton within w_recruiters
end type
type dw_browse from u_dw within w_recruiters
end type
type dw_detail from u_dw within w_recruiters
end type
end forward

global type w_recruiters from w_popup
integer width = 3209
integer height = 1744
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
cb_add_group cb_add_group
cb_delete_group cb_delete_group
dw_link dw_link
cb_2 cb_2
sle_search sle_search
cb_1 cb_1
cb_del cb_del
cb_add cb_add
cb_save cb_save
cb_close cb_close
dw_browse dw_browse
dw_detail dw_detail
end type
global w_recruiters w_recruiters

type variables
boolean ab_new = false
end variables

forward prototypes
public subroutine of_add ()
end prototypes

public subroutine of_add ();//====================================================================
//$<Function>: of_add
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 12.14.2015 (BugL121103 )
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

dw_detail.reset()
dw_detail.insertrow(1)
ab_new = true
cb_add_group.enabled = false
cb_delete_group.enabled = false
dw_detail.setfocus()
dw_link.reset()   //Start Code Change ----08.18.2015 #V15 maha
end subroutine

on w_recruiters.create
int iCurrent
call super::create
this.cb_add_group=create cb_add_group
this.cb_delete_group=create cb_delete_group
this.dw_link=create dw_link
this.cb_2=create cb_2
this.sle_search=create sle_search
this.cb_1=create cb_1
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add_group
this.Control[iCurrent+2]=this.cb_delete_group
this.Control[iCurrent+3]=this.dw_link
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.sle_search
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_del
this.Control[iCurrent+8]=this.cb_add
this.Control[iCurrent+9]=this.cb_save
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.dw_browse
this.Control[iCurrent+12]=this.dw_detail
end on

on w_recruiters.destroy
call super::destroy
destroy(this.cb_add_group)
destroy(this.cb_delete_group)
destroy(this.dw_link)
destroy(this.cb_2)
destroy(this.sle_search)
destroy(this.cb_1)
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

rid = dw_browse.getitemnumber(1, "rec_id")
dw_detail.retrieve(rid)
end event

type cb_add_group from commandbutton within w_recruiters
integer x = 2683
integer y = 1040
integer width = 247
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;integer n
long g, f

open(w_recruit_group_select)

if message.stringparm = "Cancel" then
	return
else
	g = message.doubleparm
	if g > 0 then
		//---------Begin Added by (Appeon)Stephen 03.10.2016 for BugS030802--------
		f = dw_link.find("group_id = " + string(g), 1, dw_link.rowcount())
		if f > 0 then return
		//---------End Added ------------------------------------------------------

		n = dw_link.insertrow(0)
		dw_link.setitem(n,"group_id",g)
		dw_link.setitem(n,"rec_id",dw_detail.getitemnumber(1,"rec_id") )
		dw_link.update()
	end if
end if
end event

type cb_delete_group from commandbutton within w_recruiters
integer x = 2944
integer y = 1040
integer width = 247
integer height = 92
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

if dw_link.rowcount() < 1 then return

//check for connected records!!!

a = messagebox("Delete","Are you sure you want to delete the selected Recruiter Group  link?", question!,yesno!,2)

if a = 2 then return

dw_link.deleterow(0)

cb_save.triggerevent(clicked!)
end event

type dw_link from u_dw within w_recruiters
integer x = 1280
integer y = 1140
integer width = 1915
integer height = 516
integer taborder = 70
boolean titlebar = true
string title = "Hiring Groups/Committees"
string dataobject = "recruiter_group_link"
end type

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

event constructor;call super::constructor;this.settransobject(sqlca)

end event

type cb_2 from commandbutton within w_recruiters
integer x = 896
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

//li_found = 	dw_browse.find( "upper(last_name) like '%" + ls_search + "%'", dw_browse.getrow() + 1,	dw_browse.rowcount())
li_found = 	dw_browse.find( "upper(compute_1) like '%" + ls_search + "%'", dw_browse.getrow() + 1,	dw_browse.rowcount()) //Modified by Appeon long.zhang 12.14.2015

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

type sle_search from singlelineedit within w_recruiters
integer x = 9
integer y = 36
integer width = 882
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

type cb_1 from commandbutton within w_recruiters
integer x = 2377
integer y = 36
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select ISG User"
end type

event clicked;gs_pass_ids lst_ids

open(w_user_select)
lst_ids = message.powerobjectparm

if lst_ids.s_ids[1] = "Cancel" then
	return
else
	dw_detail.setitem(1,"isg_user", lst_ids.s_ids[1])
//	if isnull(dw_detail.getitemstring(1,"rec_name")) then dw_detail.setitem(1,"rec_name", lst_ids.s_ids[2])
	if isnull(dw_detail.getitemstring(1,"email_address")) then dw_detail.setitem(1,"email_address", lst_ids.s_ids[3])
	dw_detail.setitem(1,"internal_external", "I")
end if
end event

type cb_del from commandbutton within w_recruiters
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
string text = "&Delete"
end type

event clicked;integer a
integer gc
integer g

if dw_detail.rowcount() < 1 then return

//check for connected records!!!

a = messagebox("Delete","Are you sure you want to delete the selected Recruiter?", question!,yesno!,2)

if a = 2 then return

gc = dw_link.rowcount()
for g = 1 to gc
	dw_link.deleterow(1)
next

dw_detail.deleterow(1)

cb_save.triggerevent(clicked!)
end event

type cb_add from commandbutton within w_recruiters
integer x = 1659
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

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Save it before insertrow.
//$<Author>: (Appeon) long.zhang 12.14.2015 (BugL121103 )
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i

dw_detail.Accepttext( )

If dw_detail.ModifiedCount() > 0 Then
	i = cb_save.event clicked() 
	If i >= 0 Then Post of_add()
	Return
End If
	
of_add()

//Moved to of_add() by Appeon long.zhang 12.14.2015 ()
//dw_detail.insertrow(1)
//ab_new = true
//cb_add_group.enabled = false
//cb_delete_group.enabled = false
//dw_detail.setfocus()
//dw_link.reset()   //Start Code Change ----08.18.2015 #V15 maha
end event

type cb_save from commandbutton within w_recruiters
integer x = 1303
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

event clicked;//Reconstruct by Appeon long.zhang 12.14.2015 (BugL121103)
Return Parent.Event pfc_Save()

//long ll_rec
//long rid
//long f
//
//if dw_detail.rowcount() < 1 then
//	dw_detail.update()
//	dw_browse.retrieve()
//	return
//end if
//
//if dw_detail.getitemstatus(1,0, primary!) = notmodified! then return
//
//ll_rec = dw_detail.getitemnumber(1, "rec_id")
//
//if ab_new then
//	if isnull(ll_rec) then
//		select max(rec_id)	 into :rid from recruit_recruiters;
//		If IsNull(rid) Then rid = 0//Added by Appeon long.zhang 12.14.2015 (BugL121101)
//		ll_rec = rid + 1
//		dw_detail.setitem(1, "rec_id", ll_rec)
//	end if
//end if
//	
//dw_detail.update()
//dw_link.update()
//
//if ab_new then
//	dw_browse.retrieve()
//	f = dw_browse.find("rec_id = " + string(ll_rec), 1, 1000000)
//	if f > 0 then
//		dw_browse.scrolltorow(f)
//		dw_browse.setrow(f)	
//	end if
//end if
//
//
//ab_new = false
//cb_add_group.enabled = true
//cb_delete_group.enabled = true
end event

type cb_close from commandbutton within w_recruiters
integer x = 2811
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
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_browse from u_dw within w_recruiters
integer y = 136
integer width = 1271
integer height = 1520
integer taborder = 60
boolean titlebar = true
string title = "Recruiters"
string dataobject = "d_recruiters_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)
This.of_SetUpdateable(False)//Added by Appeon long.zhang 12.14.2015 (BugL121103 )

end event

event rowfocuschanged;call super::rowfocuschanged;long rid

this.selectrow(0,false)
this.selectrow(currentrow,true)

rid = this.getitemnumber(currentrow, "rec_id")
dw_link.retrieve(rid)
dw_detail.retrieve(rid)




end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

type dw_detail from u_dw within w_recruiters
integer x = 1275
integer y = 140
integer width = 1920
integer height = 888
integer taborder = 60
boolean titlebar = true
string title = "Detail"
string dataobject = "d_recruiters_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
of_SetReqColumn(TRUE)
end event

event buttonclicked;call super::buttonclicked;if dwo.name = "b_clear" then
	this.setitem(row,"isg_user", "")
end if
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 12.14.2015 (BugL121103)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_rec
long rid
long f

if dw_detail.rowcount() < 1 then
	return SUCCESS
end if

if dw_detail.getitemstatus(1,0, primary!) = notmodified! then return SUCCESS

ll_rec = dw_detail.getitemnumber(1, "rec_id")

if ab_new then
	if isnull(ll_rec) then
		select max(rec_id)	 into :rid from recruit_recruiters;
		If IsNull(rid) Then rid = 0//Added by Appeon long.zhang 12.14.2015 (BugL121101)
		ll_rec = rid + 1
		dw_detail.setitem(1, "rec_id", ll_rec)
	end if
end if
end event

event pfc_postupdate;call super::pfc_postupdate;//====================================================================
//$<Event>: pfc_postupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 12.14.2015 (BugL121103)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long f, ll_rec

if dw_detail.rowcount() < 1 then
	dw_browse.retrieve()
	return 0
end if

if ab_new then
	ll_rec = dw_detail.getitemnumber(1, "rec_id")
	dw_browse.retrieve()
	dw_browse.find("rec_id = " + string(ll_rec), 1, 1000000)
	if f > 0 then
		dw_browse.scrolltorow(f)
		dw_browse.setrow(f)	
	end if
end if


ab_new = false
cb_add_group.enabled = true
cb_delete_group.enabled = true
end event

