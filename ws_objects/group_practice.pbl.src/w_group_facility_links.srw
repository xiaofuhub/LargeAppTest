$PBExportHeader$w_group_facility_links.srw
forward
global type w_group_facility_links from window
end type
type cb_help from commandbutton within w_group_facility_links
end type
type p_1 from picture within w_group_facility_links
end type
type cb_1 from commandbutton within w_group_facility_links
end type
type cb_del from commandbutton within w_group_facility_links
end type
type cb_add from commandbutton within w_group_facility_links
end type
type cb_close from commandbutton within w_group_facility_links
end type
type dw_1 from datawindow within w_group_facility_links
end type
type cb_save from commandbutton within w_group_facility_links
end type
end forward

global type w_group_facility_links from window
integer width = 2894
integer height = 1860
boolean titlebar = true
string title = "Group/Facility Links"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_help cb_help
p_1 p_1
cb_1 cb_1
cb_del cb_del
cb_add cb_add
cb_close cb_close
dw_1 dw_1
cb_save cb_save
end type
global w_group_facility_links w_group_facility_links

type variables
string is_type
long il_id
boolean ib_view_add
end variables

event open; //Start Code Change ----05.18.2015 #V15 maha
gs_pass_ids lst_ids

lst_ids = message.powerobjectparm

il_id = lst_ids.facility_id
is_type = lst_ids.ls_from_window

dw_1.settransobject(sqlca)
dw_1.retrieve()

if is_type = "G" then
	dw_1.setfilter("group_id = " + string(il_id))
	dw_1.filter()
elseif is_type = "F" then	
	dw_1.setfilter("facility_id = " + string(il_id))
	dw_1.filter()
else
	//no filter
end if

if is_type = "G" then
	if dw_1.rowcount() = 0 then
		dw_1.insertrow(1)
		dw_1.setitem(1,"group_id", il_id)
		//dw_1.modify("group_id.protect = true")
	end if
	dw_1.modify("group_id.protect = true") //(Appeon) Added by Harry 09.29.2016
	ib_view_add = true
elseif is_type = "F" then	
	if dw_1.rowcount() = 0 then
		dw_1.insertrow(1)
		dw_1.setitem(1,"facility_id", il_id)
		//dw_1.modify("facility_id.protect = true")
	end if
	dw_1.modify("facility_id.protect = true") //(Appeon) Added by Harry 09.29.2016
	ib_view_add = true
else
	ib_view_add = false
end if

end event

on w_group_facility_links.create
this.cb_help=create cb_help
this.p_1=create p_1
this.cb_1=create cb_1
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_1=create dw_1
this.cb_save=create cb_save
this.Control[]={this.cb_help,&
this.p_1,&
this.cb_1,&
this.cb_del,&
this.cb_add,&
this.cb_close,&
this.dw_1,&
this.cb_save}
end on

on w_group_facility_links.destroy
destroy(this.cb_help)
destroy(this.p_1)
destroy(this.cb_1)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.cb_save)
end on

type cb_help from commandbutton within w_group_facility_links
integer x = 2386
integer y = 36
integer width = 114
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;messagebox("About", "These links allow a direct connection between Group and Facility records for reporting purposes.  This is not the same as an Entity link.")



		


end event

type p_1 from picture within w_group_facility_links
boolean visible = false
integer x = 1262
integer y = 60
integer width = 82
integer height = 60
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_group_facility_links
integer x = 1573
integer y = 36
integer width = 608
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View ALL Links"
end type

event clicked;long r
long g
long ll_id

//messagebox("",is_type)
if this.text = "View ALL Links" then
	dw_1.setfilter("")
	dw_1.filter()
	this.text = "View Connected Links"
	dw_1.modify("group_id.protect = true")
	dw_1.modify("facility_id.protect = true")
	ib_view_add = false
	cb_add.enabled = false
	cb_save.enabled = false
	cb_del.enabled = false
else
	if is_type = "G" then
		dw_1.setfilter("group_id = " + string(il_id))
		dw_1.modify("facility_id.protect = false")
	elseif is_type = "F" then
		dw_1.setfilter("facility_id = " + string(il_id))
		dw_1.modify("group_id.protect = false")
	end if

	dw_1.filter()
	this.text = "View ALL Links"
	ib_view_add = true
	cb_add.enabled = true
	cb_save.enabled = true
	cb_del.enabled = true
end if





end event

type cb_del from commandbutton within w_group_facility_links
integer x = 786
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
string text = "Delete"
end type

event clicked;long r
long g
long ll_id


r = messagebox("Delete?", "Are you sure you want to Delete the selected link?", question!, yesno!,2)
if r = 2 then return

dw_1.deleterow(0)

dw_1.update()
		


end event

type cb_add from commandbutton within w_group_facility_links
integer x = 416
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
string text = "Add"
end type

event clicked;long r
long g
long ll_id
long nr


nr = dw_1.insertrow(0)
dw_1.scrolltorow(nr)
dw_1.setrow(nr)

if is_type = "G" then
	dw_1.setitem(nr,"group_id", il_id)
elseif is_type = "F" then
	dw_1.setitem(nr,"facility_id", il_id)
else
	//nothing
end if

		


end event

type cb_close from commandbutton within w_group_facility_links
integer x = 2514
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
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_group_facility_links
integer x = 37
integer y = 156
integer width = 2811
integer height = 1600
integer taborder = 10
string title = "none"
string dataobject = "d_group_facility_link"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long r

r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;//this.selectrow(0,false)
//this.selectrow(currentrow,false)
end event

event constructor;this.setrowfocusindicator( p_1)
end event

type cb_save from commandbutton within w_group_facility_links
integer x = 46
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
string text = "Save"
end type

event clicked;long r
long g
long ll_id


//trap for duplicates
for r = 1 to dw_1.rowcount()
	if is_type = "G" then
		ll_id = dw_1.getitemnumber(r,"facility_id")
		//(Appeon) Added by Harry 09.29.2016 
		if isnull(ll_id) or ll_id = 0 then
			MessageBox("IntelliSoft","Please choose a facility first.")
			return
		end if
		for g = r + 1 to dw_1.rowcount()
			if ll_id = dw_1.getitemnumber(g,"facility_id") then
				messagebox("","Duplicate Facility connected to this Group")
				return
			end if
		next
		
	elseif is_type = "F" then
		ll_id = dw_1.getitemnumber(r,"group_id")
		//(Appeon) Added by Harry 09.29.2016 
		if isnull(ll_id) or ll_id = 0 then
			MessageBox("IntelliSoft","Please choose a group first.")
			return
		end if
		for g = r + 1 to dw_1.rowcount()
			if ll_id = dw_1.getitemnumber(g,"group_id") then
				messagebox("","Duplicate Group connected to this Facility")
				return
			end if
		next
	else
		return
	end if
next

dw_1.update()
		


end event

