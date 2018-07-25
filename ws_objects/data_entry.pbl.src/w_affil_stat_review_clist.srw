$PBExportHeader$w_affil_stat_review_clist.srw
forward
global type w_affil_stat_review_clist from w_popup
end type
type cb_print from commandbutton within w_affil_stat_review_clist
end type
type st_1 from statictext within w_affil_stat_review_clist
end type
type dw_reviewer from datawindow within w_affil_stat_review_clist
end type
type p_1 from picture within w_affil_stat_review_clist
end type
type cb_close from commandbutton within w_affil_stat_review_clist
end type
type cb_delete from commandbutton within w_affil_stat_review_clist
end type
type cb_add from commandbutton within w_affil_stat_review_clist
end type
type cb_save from commandbutton within w_affil_stat_review_clist
end type
type dw_1 from u_dw within w_affil_stat_review_clist
end type
end forward

global type w_affil_stat_review_clist from w_popup
integer width = 4352
integer height = 2020
string title = "Appointment Review Audit"
long backcolor = 33551856
cb_print cb_print
st_1 st_1
dw_reviewer dw_reviewer
p_1 p_1
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
cb_save cb_save
dw_1 dw_1
end type
global w_affil_stat_review_clist w_affil_stat_review_clist

type variables
long il_prac
long il_affil_id
long il_facil
string is_reviewer
end variables

forward prototypes
public function integer of_set_vars (long al_appt_stat, long al_prac, long al_facil)
end prototypes

public function integer of_set_vars (long al_appt_stat, long al_prac, long al_facil);il_prac = al_prac
il_facil = al_facil
il_affil_id = al_appt_stat

dw_1.retrieve(il_affil_id)

return 1
end function

on w_affil_stat_review_clist.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.st_1=create st_1
this.dw_reviewer=create dw_reviewer
this.p_1=create p_1
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_save=create cb_save
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_reviewer
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_add
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.dw_1
end on

on w_affil_stat_review_clist.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.st_1)
destroy(this.dw_reviewer)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;call super::open;long r


dw_1.settransobject(sqlca)
dw_reviewer.setitem(1,"user_id", gs_user_id)
is_reviewer = gs_user_id
end event

event closequery;return 0
end event

event resize;call super::resize;long ll_h
long ll_w

ll_h = this.workspaceheight( )
ll_w = this.workspacewidth( )

dw_1.width = ll_w - 20
dw_1.height = ll_h - dw_1.y - 28
end event

type cb_print from commandbutton within w_affil_stat_review_clist
integer x = 3557
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
string text = "View Report"
end type

event clicked;//Start Code Change ----09.07.2017 #V154 maha
openwithparm(w_affil_stat_review_print, il_affil_id )
end event

type st_1 from statictext within w_affil_stat_review_clist
integer x = 1362
integer y = 56
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Reset Reviewer:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_reviewer from datawindow within w_affil_stat_review_clist
integer x = 1751
integer y = 48
integer width = 462
integer height = 80
integer taborder = 10
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event itemchanged;integer res
integer r

is_reviewer = data

res = messagebox("Reviewer","Do you want to reset the Reviewer for items already set?", question!,yesno!,1)

if res = 1 then
	for r = 1 to dw_1.rowcount()
		dw_1.setitem(r,"reviewed_by",is_reviewer)
	next
end if
end event

type p_1 from picture within w_affil_stat_review_clist
boolean visible = false
integer x = 133
integer y = 56
integer width = 78
integer height = 72
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_affil_stat_review_clist
integer x = 3931
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
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_delete from commandbutton within w_affil_stat_review_clist
integer x = 3182
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
string text = "&Delete"
end type

event clicked;integer res

res = messagebox("Delete Item","Do you want to delete the selected item?", question!,yesno!,2)

if res = 2 then return

dw_1.deleterow(0)
dw_1.update()
end event

type cb_add from commandbutton within w_affil_stat_review_clist
integer x = 2807
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
string text = "&Add"
end type

event clicked;long ll_temp
long ll_id
long ll_pk
long ll_pos
long ll_rec
integer tc
integer t
integer nr
integer cnt
string ls_desc
n_ds lds_temp
u_dw ldw_detail

openwithparm(w_select_checklist,"review")

if message.stringparm = "Cancel" then
	//messagebox("","Cancel") //Comment by Appeon long.zhang 12.14.2015 (BugL120701)
	return
else
	ll_temp = message.doubleparm
	if ll_temp > 0 then
		ldw_detail = dw_1
			//get list of template items
		lds_temp = CREATE n_ds
		lds_temp.dataobject = "d_app_audit_rqrd_data_add"  
		lds_temp.settransobject(sqlca)
		tc = lds_temp.retrieve(ll_temp)
		if tc < 1 then return
		
		ll_rec = gnv_app.of_get_id("RECORD_ID",tc) - 1
		//add records to action dw
		for t = 1 to tc
			ll_id = lds_temp.getitemnumber(t,"app_audit_id")
			ls_desc = lds_temp.getitemstring(t,"description")
			ll_rec++
			
			nr = ldw_detail.insertrow(0)
			
			ldw_detail.setitem(nr,"record_id",ll_rec)
			ldw_detail.setitem(nr,"checklist_item_id",ll_id)
			ldw_detail.setitem(nr,"data_view_app_audit_description",ls_desc)
			ldw_detail.setitem(nr,"prac_id",il_prac)
			ldw_detail.setitem(nr,"appt_stat_id",il_affil_id)
			ldw_detail.setitem(nr,"facility_id",il_facil)
			ldw_detail.setitem(nr,"reviewed_by",is_reviewer)

			cnt++
			
		next
		
		destroy lds_temp
	end if
end if

end event

type cb_save from commandbutton within w_affil_stat_review_clist
integer x = 2432
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;dw_1.update()
end event

type dw_1 from u_dw within w_affil_stat_review_clist
integer x = 14
integer y = 148
integer width = 4288
integer height = 1760
integer taborder = 10
string dataobject = "d_affil_stat_review_clist"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(true)
this.settransobject(sqlca)

end event

event buttonclicked;call super::buttonclicked;string sl_notes

choose case dwo.name	
	case "b_notes"
		this.SetColumn("notes")
		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
		//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
		//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
		string ls_notes
		ls_notes = This.GetItemString( row, "notes" )
		if isnull(ls_notes) then ls_notes = ""
		OpenWithParm( w_ai_notes_new, ls_notes)
		//---------End Modfiied ------------------------------------------------------
		
		//OpenWithParm(w_ai_notes, this.GetItemString(Row, "notes"))		
		if Message.StringParm <> "Cancel" then
			this.SetItem(Row, "notes", Message.StringParm)
		end if
		
	case "b_1"  //complete button
		//This.SetItem( row, "data_status", 662 )
		This.SetItem( row, "date_reviewed", DateTime( Today(), Now() ) )
end choose
end event

event itemchanged;call super::itemchanged;

if dwo.name = "data_status" then
	if isnull(this.getitemdatetime(row,"date_reviewed")) then
		this.setitem(row,"date_reviewed",datetime(today(),now()))
	end if
end if
end event

