$PBExportHeader$w_call_log_issue_lookup.srw
forward
global type w_call_log_issue_lookup from w_popup
end type
type cb_save from commandbutton within w_call_log_issue_lookup
end type
type cb_add from commandbutton within w_call_log_issue_lookup
end type
type rb_all from radiobutton within w_call_log_issue_lookup
end type
type rb_5 from radiobutton within w_call_log_issue_lookup
end type
type rb_4 from radiobutton within w_call_log_issue_lookup
end type
type rb_3 from radiobutton within w_call_log_issue_lookup
end type
type rb_2 from radiobutton within w_call_log_issue_lookup
end type
type rb_1 from radiobutton within w_call_log_issue_lookup
end type
type dw_cats from datawindow within w_call_log_issue_lookup
end type
type cb_delete from commandbutton within w_call_log_issue_lookup
end type
type cb_close from commandbutton within w_call_log_issue_lookup
end type
type dw_browse from u_dw within w_call_log_issue_lookup
end type
type gb_1 from groupbox within w_call_log_issue_lookup
end type
end forward

global type w_call_log_issue_lookup from w_popup
integer width = 3817
integer height = 1912
string title = "Contact Category Lookup"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_save cb_save
cb_add cb_add
rb_all rb_all
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_cats dw_cats
cb_delete cb_delete
cb_close cb_close
dw_browse dw_browse
gb_1 gb_1
end type
global w_call_log_issue_lookup w_call_log_issue_lookup

forward prototypes
public function integer of_filter_cat (string as_type)
end prototypes

public function integer of_filter_cat (string as_type);string ls_filter

choose case as_type
	case "A"
		ls_filter = ""
	case "1"
		ls_filter = "category1 = 1"
	case "2"
		ls_filter = "category2 = 1"
	case "3"
		ls_filter = "category3 = 1"
	case "4"
		ls_filter = "category4 = 1"
	case "5"
		ls_filter = "category5 = 1"
end choose

dw_browse.setfilter(ls_filter)
dw_browse.filter()

return 1

end function

on w_call_log_issue_lookup.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_add=create cb_add
this.rb_all=create rb_all
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_cats=create dw_cats
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.rb_all
this.Control[iCurrent+4]=this.rb_5
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.dw_cats
this.Control[iCurrent+10]=this.cb_delete
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.dw_browse
this.Control[iCurrent+13]=this.gb_1
end on

on w_call_log_issue_lookup.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.rb_all)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_cats)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.gb_1)
end on

event open;call super::open;long r

dw_cats.settransobject(sqlca)
dw_cats.retrieve()
dw_browse.settransobject(sqlca)
r = dw_browse.retrieve()

//Start Code Change ----11.18.2013 #V14 maha - modified code
if message.stringparm = "LOG" then 
	cb_add.triggerevent(clicked!)
else
	if r = 0 then
		cb_add.triggerevent(clicked!)
//		dw_browse.insertrow(1)
//		dw_browse.setitem(1, "category1" ,0)
//		dw_browse.setitem(1, "category2" ,0)
//		dw_browse.setitem(1, "category3" ,0)
//		dw_browse.setitem(1, "category4" ,0)
//		dw_browse.setitem(1, "category5" ,0)
	end if	
end if
//End Code Change ----11.18.2013




end event

event closequery;//====================================================================
//$<Event>: closequery
//$<Arguments>:
//$<Return>:  long
//$<Description>: rewrite Fixed BugL111201 
//$<Author>: (Appeon) long.zhang 12.03.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_msg

dw_browse.accepttext( )

if dw_browse.modifiedcount( ) + dw_browse.deletedcount( ) > 0 then
	
	li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
						gnv_app.iapp_object.DisplayName, &
						"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
						
	if li_msg = 1 then
		if cb_save.event clicked() = -1 then return 1
	elseif li_msg = 2 then
		return 0
	else
		return 1
	end if
end if

return 0
end event

type cb_save from commandbutton within w_call_log_issue_lookup
integer x = 2382
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer r
long ll_code
string s

//Start Code Change ----11.18.2013 #V14 maha - modified code adding trap

dw_browse.accepttext() //(Appeon)Stephen 11.25.2013 - BugS111901
for r = 1 to  dw_browse.rowcount()
	s = dw_browse.getitemstring(r,"description")
	if isnull(s) or s = '' then
		messagebox("Incomplete data","the Description must be completed for row " + string(r) )
		return -1
	end if
	ll_code = dw_browse.getitemnumber(r,"lookup_code")
	if isnull(ll_code) then
		ll_code = gnv_app.of_get_id("LOOKUP")
		dw_browse.setitem(r,"lookup_code", ll_code)
	end if
	
next
	
//r = dw_browse.find("isnull(lookup_code)", 1, dw_browse.rowcount())
//if r > 0 then
//	ll_code = gnv_app.of_get_id("LOOKUP")
//	dw_browse.setitem(r,"lookup_code", ll_code)
//end if
//Start Code Change ----11.18.2013


dw_browse.update()

end event

type cb_add from commandbutton within w_call_log_issue_lookup
integer x = 2734
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;long nr

cb_save.triggerevent(clicked!)
nr = dw_browse.insertrow(0)

dw_browse.setrow(nr)
dw_browse.scrolltorow(nr)
dw_browse.setitem(nr, "category1" ,0)
dw_browse.setitem(nr, "category2" ,0)
dw_browse.setitem(nr, "category3" ,0)
dw_browse.setitem(nr, "category4" ,0)
dw_browse.setitem(nr, "category5" ,0)
dw_browse.setcolumn('description')


end event

type rb_all from radiobutton within w_call_log_issue_lookup
integer x = 178
integer y = 156
integer width = 101
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean lefttext = true
end type

event clicked;of_filter_cat("A")
end event

type rb_5 from radiobutton within w_call_log_issue_lookup
integer x = 1870
integer y = 156
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Cat 5"
boolean lefttext = true
end type

event clicked;of_filter_cat("5")
end event

type rb_4 from radiobutton within w_call_log_issue_lookup
integer x = 1527
integer y = 156
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Cat 4"
boolean lefttext = true
end type

event clicked;of_filter_cat("4")
end event

type rb_3 from radiobutton within w_call_log_issue_lookup
integer x = 1157
integer y = 156
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Cat 3"
boolean lefttext = true
end type

event clicked;of_filter_cat("3")
end event

type rb_2 from radiobutton within w_call_log_issue_lookup
integer x = 809
integer y = 156
integer width = 197
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Cat 2"
boolean lefttext = true
end type

event clicked;of_filter_cat("2")
end event

type rb_1 from radiobutton within w_call_log_issue_lookup
integer x = 457
integer y = 156
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Cat 1"
boolean lefttext = true
end type

event clicked;of_filter_cat("1")
end event

type dw_cats from datawindow within w_call_log_issue_lookup
integer x = 73
integer y = 76
integer width = 2185
integer height = 108
integer taborder = 20
string title = "none"
string dataobject = "d_call_log_categories"
boolean border = false
boolean livescroll = true
end type

type cb_delete from commandbutton within w_call_log_issue_lookup
integer x = 3086
integer y = 68
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res

if dw_browse.getrow() < 1 then return  //Start Code Change ----11.18.2013 #V14 maha - trap added

res = messagebox("Delete","Are you sure you wish to delete the selected record?", question!,yesno!,2)

if res = 1 then dw_browse.deleterow(0)

end event

type cb_close from commandbutton within w_call_log_issue_lookup
integer x = 3438
integer y = 68
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

type dw_browse from u_dw within w_call_log_issue_lookup
integer y = 236
integer width = 3803
integer height = 1592
integer taborder = 10
string dataobject = "d_call_log_issue_lookup_detail"
end type

type gb_1 from groupbox within w_call_log_issue_lookup
integer x = 46
integer y = 20
integer width = 2263
integer height = 208
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Category Filter"
end type

