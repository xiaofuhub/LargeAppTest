$PBExportHeader$w_call_log_search.srw
forward
global type w_call_log_search from w_main
end type
type dw_settings from datawindow within w_call_log_search
end type
type cb_close from commandbutton within w_call_log_search
end type
type tab_1 from tab within w_call_log_search
end type
type tabpage_search from userobject within tab_1
end type
type cb_reset from commandbutton within tabpage_search
end type
type rb_ent from radiobutton within tabpage_search
end type
type rb_for from radiobutton within tabpage_search
end type
type rb_comp from radiobutton within tabpage_search
end type
type dw_user from datawindow within tabpage_search
end type
type cb_search from commandbutton within tabpage_search
end type
type dw_date_range from u_dw within tabpage_search
end type
type dw_search from u_dw within tabpage_search
end type
type tabpage_search from userobject within tab_1
cb_reset cb_reset
rb_ent rb_ent
rb_for rb_for
rb_comp rb_comp
dw_user dw_user
cb_search cb_search
dw_date_range dw_date_range
dw_search dw_search
end type
type tabpage_results from userobject within tab_1
end type
type cb_select from commandbutton within tabpage_results
end type
type cb_open from commandbutton within tabpage_results
end type
type cb_parent from commandbutton within tabpage_results
end type
type dw_results from datawindow within tabpage_results
end type
type tabpage_results from userobject within tab_1
cb_select cb_select
cb_open cb_open
cb_parent cb_parent
dw_results dw_results
end type
type tab_1 from tab within w_call_log_search
tabpage_search tabpage_search
tabpage_results tabpage_results
end type
end forward

global type w_call_log_search from w_main
integer width = 3607
integer height = 1924
string title = "Find Existing Log Record"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
dw_settings dw_settings
cb_close cb_close
tab_1 tab_1
end type
global w_call_log_search w_call_log_search

type variables
datawindow idw_search
datawindow idw_results

string is_assigned
string as_from





end variables

forward prototypes
public function integer of_search_entity (string as_type)
public function string of_set_where ()
public function string of_get_dates ()
end prototypes

public function integer of_search_entity (string as_type);long ll_id
string ls_name
string ls_val

openwithparm(w_quick_search, as_type)
ls_val = message.stringparm
if ls_val = "0@Cancel" then return 0
	
ll_id = long(mid(ls_val, 1, pos(ls_val,"@",1) - 1))
ls_name = mid(ls_val, pos(ls_val,"@",1) + 1 )

choose case as_type
	case "PRAC"
		idw_search.setitem(1,"prac_id", ll_id)
		idw_search.modify( "st_provider.text = '" + ls_name + "'")
	case 	"FACIL"
		idw_search.setitem(1,"facility_id", ll_id)
		idw_search.modify( "st_facility.text = '" + ls_name + "'")
	case "GROUP"
		idw_search.setitem(1,"group_id", ll_id)
		idw_search.modify( "st_group.text = '" + ls_name + "'")
	case "LOC"
		idw_search.setitem(1,"location_id", ll_id)
		idw_search.modify( "st_location.text = '" + ls_name + "'")
	case "PAYOR"
		idw_search.setitem(1,"payor_id", ll_id)
		idw_search.modify( "st_payor.text = '" + ls_name + "'")
end choose

return 1
end function

public function string of_set_where ();
integer li_icat
integer li_status

long ll_prac
long ll_facil
long ll_group
long ll_loc
long ll_payor
long ll_itype
long ll_call

string ls_contact_type
string ls_req_from
string ls_assigned
string ls_inout
string ls_where = " AND "
string ls_dates
string ls_name
string ls_email
string ls_phone

tab_1.tabpage_search.dw_search.accepttext()


//direction
ls_inout =  idw_search.getitemstring(1,"in_out")
if ls_inout <> "A" then
	ls_where+= " in_out = '" + string(ls_inout) + "' and "
end if

// CONTACT  INFO
ls_name =  upper(idw_search.getitemstring(1,"contact_name"))
if not isnull(ls_name) and len(ls_name) > 0 then
	ls_where+= "upper(pd_notes.contact_name)  like '%" + string(ls_name) + "%' and "
end if

ls_phone =  idw_search.getitemstring(1,"phone")
if not isnull(ls_phone) and len(ls_phone) > 0 then
	ls_where+= "pd_notes.phone  like '%" + string(ls_phone) + "%' and "
end if

ls_email =  upper(idw_search.getitemstring(1,"email_address"))
if not isnull(ls_email) and len(ls_email) > 0 then
	ls_where+= "upper(pd_notes.email_address)  like '%" + string(ls_email) + "%' and "
end if


//ENTITIES
//provider
ll_prac =  idw_search.getitemnumber(1,"prac_id")
if not isnull(ll_prac) then
	ls_where+= " pd_notes.prac_id = " + string(ll_prac) + " and "
end if
//facility
ll_facil =  idw_search.getitemnumber(1,"facility_id")
if not isnull(ll_facil) then
	ls_where+= " pd_notes.facility_id = " + string(ll_facil) + " and "
end if
//group
ll_group =  idw_search.getitemnumber(1,"group_id")
if not isnull(ll_group) then
	ls_where+= " group_id = " + string(ll_group) + " and "
end if
//location
ll_loc =  idw_search.getitemnumber(1,"location_id")
if not isnull(ll_loc) then
	ls_where+= " location_id = " + string(ll_loc) + " and "
end if
//payor
ll_payor =  idw_search.getitemnumber(1,"payor_id")
if not isnull(ll_payor) then
	ls_where+= " payor_id = " + string(ll_payor) + " and "
end if


//ISSUE
li_icat =  idw_search.getitemnumber(1,"issue_category")
if not isnull(ll_payor) then
	ls_where+= " issue_category = " + string(li_icat) + " and "
end if

ll_itype =  idw_search.getitemnumber(1,"issue_type")
if not isnull(ll_itype ) then
	ls_where+= " issue_type = " + string(ll_itype) + " and "
end if

//Call id  //Start Code Change ----10.09.2013 #V14 maha - added
ll_call =  idw_search.getitemnumber(1,"record_id")
if not isnull(ll_call ) then
	ls_where+= " record_id = " + string(ll_call) + " and "
end if


//STATUS
li_status =  idw_search.getitemnumber(1,"log_status")
if not isnull(li_status ) then
	ls_where+= " log_status = " + string(li_status) + " and "
end if

//ASSIGNED
if is_assigned <> "" then
	ls_where+= " assigned_user = '" + is_assigned + "' and "
end if

//Requested
ls_req_from = idw_search.getitemstring(1,"req_from")
if not isnull(ls_req_from )  and len( ls_req_from) > 0 then
	ls_where+= " req_from = '" + ls_req_from + "' and "
end if

//contact type
ls_contact_type = idw_search.getitemstring(1,"contact_type")
if not isnull(ls_contact_type )  and len(ls_contact_type) > 0 then
	ls_where+= " contact_type = '" + ls_contact_type + "' and "
end if

//date range
ls_dates = of_get_dates()
if len(ls_dates) > 1 then
	ls_where= ls_where +  ls_dates + " and "
end if


if ls_where = " AND " then
	messagebox("Search","There are no search parameters selected")	
	return "0"
else
	ls_where = mid(ls_where, 1, len(ls_where) - 4)	
end if
//messagebox("ls_where",ls_where)

return ls_where

end function

public function string of_get_dates ();date ld_from
date ld_to
datetime ldt_from
datetime ldt_to
string ls_datefield
string ls_filter

tab_1.tabpage_search.dw_date_range.accepttext()
ld_from  = tab_1.tabpage_search.dw_date_range.getitemdate(1,"from_date")
ld_to  = tab_1.tabpage_search.dw_date_range.getitemdate(1,"to_date")

if isnull(ld_from ) and isnull(ld_to) then
	return ""
end if

if tab_1.tabpage_search.rb_ent.checked then
	ls_datefield = "ent_date"
elseif tab_1.tabpage_search.rb_comp.checked then
	ls_datefield = "compl_date"
elseif tab_1.tabpage_search.rb_for.checked then
	ls_datefield = "follow_up_date"
end if
 
if not isnull( ld_from) then
	ls_filter = " "  + ls_datefield + " >= '" + string(ld_from, "yyyy/mm/dd") + " 00:00:00'"
end if

if not isnull(ld_from ) and not isnull(ld_to) then
	ls_filter = ls_filter + " and "
end if

if not isnull( ld_to) then
	ls_filter =  ls_filter + " "  + ls_datefield + " <= '" + string(ld_to, "yyyy/mm/dd") + " 23:59:59'"
end if

//messagebox("",ls_filter)

return ls_filter
end function

on w_call_log_search.create
int iCurrent
call super::create
this.dw_settings=create dw_settings
this.cb_close=create cb_close
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_settings
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.tab_1
end on

on w_call_log_search.destroy
call super::destroy
destroy(this.dw_settings)
destroy(this.cb_close)
destroy(this.tab_1)
end on

event open;call super::open;//gs_pass_ids
//facility_id
//prac_id
//ls_ref_val
//l_app_id

idw_search = tab_1.tabpage_search.dw_search
idw_results  = tab_1.tabpage_results.dw_results

idw_search.settransobject(sqlca)
idw_search.insertrow(1)
idw_search.setitem( 1,"in_out", -1)

//tab_1.tabpage_search.dw_date.settransobject(sqlca)
//tab_1.tabpage_search.dw_dates.insertrow(1)

dw_settings.settransobject(sqlca)
dw_settings.retrieve()
idw_search.setitem(1, "issue_cat_1", dw_settings.getitemstring(1,"issue_cat_1"))
idw_search.setitem(1, "issue_cat_2", dw_settings.getitemstring(1,"issue_cat_2"))
idw_search.setitem(1, "issue_cat_3", dw_settings.getitemstring(1,"issue_cat_3"))
idw_search.setitem(1, "issue_cat_4", dw_settings.getitemstring(1,"issue_cat_4"))
idw_search.setitem(1, "issue_cat_5", dw_settings.getitemstring(1,"issue_cat_5"))

//Added by Appeon long.zhang 02.24.2016
tab_1.tabpage_search.rb_ent.backcolor = 16777215
tab_1.tabpage_search.rb_comp.backcolor = 16777215
tab_1.tabpage_search.rb_for.backcolor = 16777215
end event

event closequery;return 0
end event

type dw_settings from datawindow within w_call_log_search
boolean visible = false
integer x = 3575
integer y = 416
integer width = 187
integer height = 84
integer taborder = 21
string title = "none"
string dataobject = "d_call_log_settings"
boolean border = false
boolean livescroll = true
end type

type cb_close from commandbutton within w_call_log_search
integer x = 3205
integer y = 8
integer width = 343
integer height = 92
integer taborder = 50
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

type tab_1 from tab within w_call_log_search
integer x = 27
integer y = 16
integer width = 3543
integer height = 1808
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_search tabpage_search
tabpage_results tabpage_results
end type

on tab_1.create
this.tabpage_search=create tabpage_search
this.tabpage_results=create tabpage_results
this.Control[]={this.tabpage_search,&
this.tabpage_results}
end on

on tab_1.destroy
destroy(this.tabpage_search)
destroy(this.tabpage_results)
end on

type tabpage_search from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3506
integer height = 1692
long backcolor = 16777215
string text = "Search Parameters"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_reset cb_reset
rb_ent rb_ent
rb_for rb_for
rb_comp rb_comp
dw_user dw_user
cb_search cb_search
dw_date_range dw_date_range
dw_search dw_search
end type

on tabpage_search.create
this.cb_reset=create cb_reset
this.rb_ent=create rb_ent
this.rb_for=create rb_for
this.rb_comp=create rb_comp
this.dw_user=create dw_user
this.cb_search=create cb_search
this.dw_date_range=create dw_date_range
this.dw_search=create dw_search
this.Control[]={this.cb_reset,&
this.rb_ent,&
this.rb_for,&
this.rb_comp,&
this.dw_user,&
this.cb_search,&
this.dw_date_range,&
this.dw_search}
end on

on tabpage_search.destroy
destroy(this.cb_reset)
destroy(this.rb_ent)
destroy(this.rb_for)
destroy(this.rb_comp)
destroy(this.dw_user)
destroy(this.cb_search)
destroy(this.dw_date_range)
destroy(this.dw_search)
end on

type cb_reset from commandbutton within tabpage_search
integer x = 1883
integer y = 32
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;string ls_null
long ll_null
date ld_null

setnull(ls_null)
setnull(ll_null)
setnull(ld_null)

is_assigned = ""

idw_search.setitem(1,"contact_name",ls_null)
idw_search.setitem(1,"phone",ls_null)
idw_search.setitem(1,"email_address",ls_null)
idw_search.setitem(1,"in_out","A")
idw_search.setitem(1,"contact_type",ls_null)
idw_search.setitem(1,"type_of_contact",ls_null)
idw_search.setitem(1,"prac_id",ll_null)
idw_search.setitem(1,"group_id",ll_null)
idw_search.setitem(1,"facility_id",ll_null)
idw_search.setitem(1,"location_id",ll_null)
idw_search.setitem(1,"payor_id",ll_null)
idw_search.modify( "st_provider.text = ''")
idw_search.modify( "st_facility.text = ''")
idw_search.modify( "st_location.text = ''")
idw_search.modify( "st_group.text = ''")
idw_search.modify( "st_payor.text = ''")
idw_search.setitem(1,"log_status",ll_null)
idw_search.setitem(1,"request_from",ls_null)
idw_search.setitem(1,"req_from",ls_null)
idw_search.setitem(1,"issue_category",ll_null)
idw_search.setitem(1,"issue_type",ll_null)
idw_search.setitem(1,"record_id",ll_null)  //Start Code Change ----11.18.2013 #V14 maha
tab_1.tabpage_search.dw_date_range.reset()
tab_1.tabpage_search.dw_date_range.insertrow(1)
tab_1.tabpage_search.dw_user.retrieve()
tab_1.tabpage_search.dw_user.insertrow(1)




end event

type rb_ent from radiobutton within tabpage_search
integer x = 1925
integer y = 436
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "Entered"
boolean checked = true
end type

type rb_for from radiobutton within tabpage_search
integer x = 2880
integer y = 436
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "Forwarded"
end type

type rb_comp from radiobutton within tabpage_search
integer x = 2423
integer y = 436
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "Completed"
end type

type dw_user from datawindow within tabpage_search
integer x = 2697
integer y = 1352
integer width = 512
integer height = 80
integer taborder = 50
string title = "none"
string dataobject = "d_user_select_current"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

event itemchanged;is_assigned = data
end event

type cb_search from commandbutton within tabpage_search
integer x = 1499
integer y = 32
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
end type

event clicked;
string ls_sql
string ls_sql_org
string ls_where
integer r

 idw_results.SetTransObject( SQLCA )
ls_sql_org =  idw_results.GetSQLSelect()
ls_sql = ls_sql_org

ls_where = of_set_where( )
debugbreak()
if ls_where = "0" then return

ls_sql = ls_sql + ls_where
r = idw_results.SetSQlSelect( ls_sql )
idw_results.SetTransObject( SQLCA )
idw_results.Retrieve( )
 
idw_results.SetSQlSelect( ls_sql_org ) 
tab_1.selecttab( 2)


end event

type dw_date_range from u_dw within tabpage_search
integer x = 1769
integer y = 528
integer width = 1527
integer height = 100
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_date_range_get"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.insertrow(1)
this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
this.of_setupdateable( false)
end event

type dw_search from u_dw within tabpage_search
integer y = 128
integer width = 3493
integer height = 1556
integer taborder = 11
string dataobject = "d_call_log_detail_search"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicking;call super::buttonclicking;long ll_id
string ls_name
string ls_val


//entity search
if dwo.name = "b_s_prac" then
	of_search_entity( "PRAC")
elseif dwo.name = "b_s_facil" then
	of_search_entity( "FACIL")
elseif dwo.name = "b_s_group" then
	of_search_entity( "GROUP")
elseif dwo.name = "b_s_loc" then
	of_search_entity( "LOC")
elseif dwo.name = "b_s_payor" then
	of_search_entity( "PAYOR")
end if
end event

event itemchanged;call super::itemchanged;datawindowchild dwchild
string ls_filter
integer li_days
datetime ld_date

if dwo.name = "type_of_contact" then
	this.setitem(1,"contact_type", data)
elseif dwo.name = "request_from" then
	this.setitem(1,"req_from", data)
elseif dwo.name = "issue_category" then
	this.getchild("issue_type", dwchild)	
	choose case data
		case "1"
			ls_filter = "category1 = 1" 	
		case"2"
			ls_filter = "category2 = 1" 	
		case "3"
			ls_filter = "category3 = 1" 	
		case "4"
			ls_filter = "category4 = 1" 	
		case "5"
			ls_filter = "category5 = 1" 
	end choose
	
	dwchild.setfilter( ls_filter)
	dwchild.filter()
	parent.setfocus() //(Appeon)Stephen 11.22.2013 - BugS102501
end if
end event

event constructor;call super::constructor;this.of_setupdateable( false)
end event

type tabpage_results from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3506
integer height = 1692
long backcolor = 16777215
string text = "Results"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_select cb_select
cb_open cb_open
cb_parent cb_parent
dw_results dw_results
end type

on tabpage_results.create
this.cb_select=create cb_select
this.cb_open=create cb_open
this.cb_parent=create cb_parent
this.dw_results=create dw_results
this.Control[]={this.cb_select,&
this.cb_open,&
this.cb_parent,&
this.dw_results}
end on

on tabpage_results.destroy
destroy(this.cb_select)
destroy(this.cb_open)
destroy(this.cb_parent)
destroy(this.dw_results)
end on

type cb_select from commandbutton within tabpage_results
integer x = 1865
integer y = 36
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;long ll_id

if idw_results.getrow() < 1 then
	closewithreturn(w_call_log_search, -1)
else
	ll_id = idw_results.getitemnumber(idw_results.getrow(), "record_id")
	closewithreturn(w_call_log_search, ll_id)
end if


end event

type cb_open from commandbutton within tabpage_results
integer x = 1257
integer y = 36
integer width = 590
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Open in New Window"
end type

event clicked;w_call_log lw_log
long ll_id

if idw_results.getrow() < 1 then   //Start Code Change ---11.18.2013 #V14 maha trap added
	messagebox("Open","There is no result record selected")
	return 
end if

ll_id = idw_results.getitemnumber(idw_results.getrow(), "record_id")

opensheetwithparm  (lw_log, ll_id, "w_call_log", w_mdi,4, original!)

close(w_call_log_search)

end event

type cb_parent from commandbutton within tabpage_results
boolean visible = false
integer x = 818
integer y = 36
integer width = 421
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Select As Parent"
end type

type dw_results from datawindow within tabpage_results
integer y = 132
integer width = 3511
integer height = 1568
integer taborder = 80
string title = "none"
string dataobject = "d_call_log_search_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

