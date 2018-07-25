$PBExportHeader$w_group_practice_old.srw
forward
global type w_group_practice_old from w_popup
end type
type cb_about from commandbutton within w_group_practice_old
end type
type cb_close from commandbutton within w_group_practice_old
end type
type tab_1 from tab within w_group_practice_old
end type
type tabpage_gp from userobject within tab_1
end type
type cb_add_gp from commandbutton within tabpage_gp
end type
type dw_pop from datawindow within tabpage_gp
end type
type cb_find_gp from commandbutton within tabpage_gp
end type
type cb_save from commandbutton within tabpage_gp
end type
type cbx_update from checkbox within tabpage_gp
end type
type tab_2 from tab within tabpage_gp
end type
type tabpage_browse from userobject within tab_2
end type
type dw_browse from u_dw within tabpage_browse
end type
type dw_search from u_dw within tabpage_browse
end type
type gb_search from groupbox within tabpage_browse
end type
type cb_search from commandbutton within tabpage_browse
end type
type cb_clear from commandbutton within tabpage_browse
end type
type tabpage_browse from userobject within tab_2
dw_browse dw_browse
dw_search dw_search
gb_search gb_search
cb_search cb_search
cb_clear cb_clear
end type
type tabpage_detail from userobject within tab_2
end type
type dw_detail from u_dw within tabpage_detail
end type
type tabpage_detail from userobject within tab_2
dw_detail dw_detail
end type
type tabpage_ass_prac from userobject within tab_2
end type
type dw_prac from u_dw within tabpage_ass_prac
end type
type cb_link_prac from commandbutton within tabpage_ass_prac
end type
type tabpage_ass_prac from userobject within tab_2
dw_prac dw_prac
cb_link_prac cb_link_prac
end type
type tabpage_survey from userobject within tab_2
end type
type uo_survey from pfc_cst_u_site_survey_collect_data within tabpage_survey
end type
type tabpage_survey from userobject within tab_2
uo_survey uo_survey
end type
type tab_2 from tab within tabpage_gp
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_ass_prac tabpage_ass_prac
tabpage_survey tabpage_survey
end type
type tabpage_gp from userobject within tab_1
cb_add_gp cb_add_gp
dw_pop dw_pop
cb_find_gp cb_find_gp
cb_save cb_save
cbx_update cbx_update
tab_2 tab_2
end type
type tabpage_group_master from userobject within tab_1
end type
type cb_addmgp from commandbutton within tabpage_group_master
end type
type cb_linksave from commandbutton within tabpage_group_master
end type
type cb_addloc from commandbutton within tabpage_group_master
end type
type dw_mg_browse from datawindow within tabpage_group_master
end type
type dw_mg_detail from datawindow within tabpage_group_master
end type
type dw_loc_links from datawindow within tabpage_group_master
end type
type cb_3 from commandbutton within tabpage_group_master
end type
type sle_2 from singlelineedit within tabpage_group_master
end type
type cb_1 from commandbutton within tabpage_group_master
end type
type cb_2 from commandbutton within tabpage_group_master
end type
type tabpage_group_master from userobject within tab_1
cb_addmgp cb_addmgp
cb_linksave cb_linksave
cb_addloc cb_addloc
dw_mg_browse dw_mg_browse
dw_mg_detail dw_mg_detail
dw_loc_links dw_loc_links
cb_3 cb_3
sle_2 sle_2
cb_1 cb_1
cb_2 cb_2
end type
type tab_1 from tab within w_group_practice_old
tabpage_gp tabpage_gp
tabpage_group_master tabpage_group_master
end type
end forward

global type w_group_practice_old from w_popup
integer x = 9
integer y = 36
integer width = 3630
integer height = 2336
string title = "Practice Locations"
boolean maxbox = false
boolean resizable = false
cb_about cb_about
cb_close cb_close
tab_1 tab_1
end type
global w_group_practice_old w_group_practice_old

type variables
n_ds ids_datastore

String is_open_for
String is_original_sql

Integer il_facility_id
integer il_group_id
integer ii_mgp_id

String is_sql
end variables

on w_group_practice_old.create
int iCurrent
call super::create
this.cb_about=create cb_about
this.cb_close=create cb_close
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_about
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.tab_1
end on

on w_group_practice_old.destroy
call super::destroy
destroy(this.cb_about)
destroy(this.cb_close)
destroy(this.tab_1)
end on

event open;call super::open;is_sql = tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.GetSqlSelect()
//tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.retrieve()
//tab_1.tabpage_group_master.dw_mg_browse.retrieve()
end event

type cb_about from commandbutton within w_group_practice_old
integer x = 2885
integer y = 28
integer width = 297
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&About G. P."
end type

event clicked;messagebox("Using the Group Practice Module","The Group practice module allows users to connect practitioners addresses to a practice.  These links can then be used for group practice reporting and Site surveys." +& 
"  ")
end event

type cb_close from commandbutton within w_group_practice_old
integer x = 3205
integer y = 28
integer width = 297
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_group_practice_old
event create ( )
event destroy ( )
integer x = 18
integer y = 44
integer width = 3547
integer height = 2180
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean raggedright = true
alignment alignment = right!
integer selectedtab = 1
tabpage_gp tabpage_gp
tabpage_group_master tabpage_group_master
end type

on tab_1.create
this.tabpage_gp=create tabpage_gp
this.tabpage_group_master=create tabpage_group_master
this.Control[]={this.tabpage_gp,&
this.tabpage_group_master}
end on

on tab_1.destroy
destroy(this.tabpage_gp)
destroy(this.tabpage_group_master)
end on

type tabpage_gp from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3511
integer height = 2052
long backcolor = 79741120
string text = "Practice Locations"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Library5!"
long picturemaskcolor = 553648127
cb_add_gp cb_add_gp
dw_pop dw_pop
cb_find_gp cb_find_gp
cb_save cb_save
cbx_update cbx_update
tab_2 tab_2
end type

on tabpage_gp.create
this.cb_add_gp=create cb_add_gp
this.dw_pop=create dw_pop
this.cb_find_gp=create cb_find_gp
this.cb_save=create cb_save
this.cbx_update=create cbx_update
this.tab_2=create tab_2
this.Control[]={this.cb_add_gp,&
this.dw_pop,&
this.cb_find_gp,&
this.cb_save,&
this.cbx_update,&
this.tab_2}
end on

on tabpage_gp.destroy
destroy(this.cb_add_gp)
destroy(this.dw_pop)
destroy(this.cb_find_gp)
destroy(this.cb_save)
destroy(this.cbx_update)
destroy(this.tab_2)
end on

type cb_add_gp from commandbutton within tabpage_gp
integer x = 2848
integer y = 20
integer width = 297
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Add"
end type

event clicked;integer li_newrow


tab_2.selecttab(2)
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.reset()
li_newrow = tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.insertrow(0)

tab_1.tabpage_gp.cbx_update.visible = false










end event

type dw_pop from datawindow within tabpage_gp
boolean visible = false
integer x = 1129
integer y = 36
integer width = 133
integer height = 68
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_group_prac_pop"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_find_gp from commandbutton within tabpage_gp
boolean visible = false
integer x = 1618
integer y = 28
integer width = 247
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Find"
end type

event clicked;long ll_addr
long ll_group
integer res

if tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.rowcount() < 1 then return


open(w_practice_find)

ll_addr = message.doubleparm

if isnull(ll_addr) then return
if ll_addr = 0 then return

dw_pop.settransobject(sqlca)
dw_pop.retrieve(ll_addr)

ll_group = tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.getitemnumber(1,"rec_id")

if not(isnull(ll_group)) then 
	res = messagebox("Repopulating existing Group Practice Information","This Group Practice already has an address.~n~r If you continue, you will have to update all practitioners connected to this group.~n~r Do you want to continue repopulating the address information?",question!,Yesno!,2)
end if

if res = 2 then return
//	return
//else
//	dw_pop.rowscopy(1, 1,primary!,tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail, 1000000, primary! )
//end if


tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"street",dw_pop.getitemstring(1,"street"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"street_2",dw_pop.getitemstring(1,"street_2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"city",dw_pop.getitemstring(1,"city"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"state",dw_pop.getitemnumber(1,"state"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"zip",dw_pop.getitemstring(1,"zip"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"county",dw_pop.getitemnumber(1,"county"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"country",dw_pop.getitemnumber(1,"country"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"phone",dw_pop.getitemstring(1,"phone"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"fax",dw_pop.getitemstring(1,"fax"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"e_mail_address",dw_pop.getitemstring(1,"e_mail_address"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"web_address",dw_pop.getitemstring(1,"web_address"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"contact_person",dw_pop.getitemstring(1,"contact_person"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"business_mgr",dw_pop.getitemstring(1,"business_mgr"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"office_mgr",dw_pop.getitemstring(1,"office_mgr"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"tax_id",dw_pop.getitemstring(1,"tax_id"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"routine_visit_appt",dw_pop.getitemstring(1,"routine_visit_appt"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"urgent_visit_appt",dw_pop.getitemstring(1,"urgent_visit_appt"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"emergency_visit_appt",dw_pop.getitemstring(1,"emergency_visit_appt"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"handicapped_access",dw_pop.getitemnumber(1,"handicapped_access"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"public_transportation",dw_pop.getitemnumber(1,"public_transportation"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"non_emergency_appt",dw_pop.getitemstring(1,"non_emergency_appt"))

tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_from",dw_pop.getitemstring(1,"mon_from"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_to",dw_pop.getitemstring(1,"mon_to"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_from",dw_pop.getitemstring(1,"tue_from"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_to",dw_pop.getitemstring(1,"tue_to"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_from",dw_pop.getitemstring(1,"wed_from"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_to",dw_pop.getitemstring(1,"wed_to"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_from",dw_pop.getitemstring(1,"thu_from"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_to",dw_pop.getitemstring(1,"thu_to"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_from",dw_pop.getitemstring(1,"fri_from"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_to",dw_pop.getitemstring(1,"fri_to"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_from",dw_pop.getitemstring(1,"sat_from"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_to",dw_pop.getitemstring(1,"sat_to"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_from",dw_pop.getitemstring(1,"sun_from"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_to",dw_pop.getitemstring(1,"sun_to"))

tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_from2",dw_pop.getitemstring(1,"mon_from2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_to2",dw_pop.getitemstring(1,"mon_to2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_from2",dw_pop.getitemstring(1,"tue_from2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_to2",dw_pop.getitemstring(1,"tue_to2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_from2",dw_pop.getitemstring(1,"wed_from2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_to2",dw_pop.getitemstring(1,"wed_to2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_from2",dw_pop.getitemstring(1,"thu_from2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_to2",dw_pop.getitemstring(1,"thu_to2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_from2",dw_pop.getitemstring(1,"fri_from2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_to2",dw_pop.getitemstring(1,"fri_to2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_from2",dw_pop.getitemstring(1,"sat_from2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_to2",dw_pop.getitemstring(1,"sat_to2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_from2",dw_pop.getitemstring(1,"sun_from2"))
tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_to2",dw_pop.getitemstring(1,"sun_to2"))












end event

type cb_save from commandbutton within tabpage_gp
integer x = 3168
integer y = 20
integer width = 297
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;integer li_gp_id


select max(rec_id) 
into :li_gp_id
from group_practice;

if li_gp_id < 1 or isnull(li_gp_id) then li_gp_id = 0

li_gp_id++
if tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.getitemstatus(1,0,primary!) = newmodified! then
	tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.setitem(1,"rec_id",li_gp_id)
//	tab_1.tabpage_gp.cbx_update.visible = true
//	tab_1.tabpage_gp.cbx_update.checked = false
end if

tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.update()

commit using sqlca;

il_group_id = li_gp_id
tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.retrieve()

if tab_1.tabpage_gp.cbx_update.checked = true then
end if


end event

type cbx_update from checkbox within tabpage_gp
boolean visible = false
integer x = 2153
integer y = 28
integer width = 786
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Update associated practioners"
boolean checked = true
end type

type tab_2 from tab within tabpage_gp
event create ( )
event destroy ( )
integer x = 23
integer y = 120
integer width = 3433
integer height = 1848
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
tabposition tabposition = tabsonbottom!
alignment alignment = right!
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_ass_prac tabpage_ass_prac
tabpage_survey tabpage_survey
end type

on tab_2.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_ass_prac=create tabpage_ass_prac
this.tabpage_survey=create tabpage_survey
this.Control[]={this.tabpage_browse,&
this.tabpage_detail,&
this.tabpage_ass_prac,&
this.tabpage_survey}
end on

on tab_2.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_ass_prac)
destroy(this.tabpage_survey)
end on

event selectionchanging;integer gp_id
integer r

gp_id = il_group_id


r = tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.retrieve(gp_id)
//messagebox('rc',r)
//tab_1.tabpage_prac.dw_prac.retrieve(gp_id)
//tab_1.tabpage_site.dw_site.retrieve(gp_id)


end event

event selectionchanged;debugbreak()
if newindex = 1 then
	//cb_find_gp.visible = false

	tab_1.tabpage_gp.tab_2.tabpage_browse.gb_search.visible = true
	tab_1.tabpage_gp.tab_2.tabpage_browse.cb_search.visible = true
	tab_1.tabpage_gp.tab_2.tabpage_browse.cb_clear.visible = true	
	tab_1.tabpage_gp.tab_2.tabpage_browse.dw_search.visible = true
elseif newindex = 2 then
	//cb_find_gp.visible = true
	tab_1.tabpage_gp.tab_2.tabpage_browse.cb_search.visible = false
	tab_1.tabpage_gp.tab_2.tabpage_browse.gb_search.visible = false
	tab_1.tabpage_gp.tab_2.tabpage_browse.cb_clear.visible = false
	tab_1.tabpage_gp.tab_2.tabpage_browse.dw_search.Visible = False	
elseif newindex = 3 then
	tab_1.tabpage_gp.tab_2.tabpage_ass_prac.dw_prac.retrieve(il_group_id)
elseif newindex = 4 then
	Integer li_ans
	Integer li_cnt
	//Long ll_address_id
	String ls_full_address

	//ll_address_id = dw_address_search.GetItemNumber( dw_address_search.GetRow(), "rec_id" )
	//ls_full_address = dw_address_search.GetItemString( dw_address_search.GetRow(), "full_address" )

	SELECT Count( rec_id )  
	INTO :li_cnt  
	FROM pd_review_hdr  
	WHERE pd_review_hdr.address_id = :il_group_id   ;

	IF li_cnt = 0 THEN
		li_ans = MessageBox("Not Found", "There was no survey found for the selected address.  ~n~r Would you like to create a survey for this address?", Question!, YesNo!, 1 )
		IF li_ans = 2 THEN
			Return
		END IF
		//tab_1.tabpage_survey.Enabled = True	
		//tab_1.SelectTab( 2 )
		tab_1.tabpage_gp.tab_2.tabpage_survey.uo_survey.of_new_record( il_group_id )
		//tab_1.tabpage_survey.uo_survey.of_new_record( ll_address_id )
	ELSE
		//tab_1.SelectTab( 2 )
		//tab_1.tabpage_survey.Enabled = True	
		tab_1.tabpage_gp.tab_2.tabpage_survey.uo_survey.of_retrieve_browse( il_group_id )		
	END IF

	//w_site_surveys.Title = "Site Survey    ( " + ls_full_address + " )"
end if
end event

type tabpage_browse from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 3397
integer height = 1720
long backcolor = 79741120
string text = "Location Search/Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Search!"
long picturemaskcolor = 553648127
dw_browse dw_browse
dw_search dw_search
gb_search gb_search
cb_search cb_search
cb_clear cb_clear
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.dw_search=create dw_search
this.gb_search=create gb_search
this.cb_search=create cb_search
this.cb_clear=create cb_clear
this.Control[]={this.dw_browse,&
this.dw_search,&
this.gb_search,&
this.cb_search,&
this.cb_clear}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
destroy(this.dw_search)
destroy(this.gb_search)
destroy(this.cb_search)
destroy(this.cb_clear)
end on

type dw_browse from u_dw within tabpage_browse
integer x = 27
integer y = 472
integer width = 3355
integer height = 1212
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_group_prac_search"
boolean hscrollbar = true
end type

event clicked;call super::clicked;integer li_row

li_row = this.getclickedrow()


tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.setrow(li_row)
tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.scrolltorow(li_row)
tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.selectrow(0,false)
tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.selectrow(li_row,true)

il_group_id = tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.getitemnumber(li_row,"rec_id")
//messagebox("il_group_id",il_group_id)





end event

event constructor;call super::constructor;this.settransobject(sqlca)

DataWindowChild dwchild


This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
dwchild.InsertRow( 1 )
end event

event doubleclicked;call super::doubleclicked;tab_1.tabpage_gp.tab_2.selecttab(2)
end event

event retrieveend;call super::retrieveend;
IF rowcount > 0 THEN
	tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.selectrow(1,True)
	il_group_id = tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.getitemnumber(1,"rec_id")
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;//integer gp_id
//
//gp_id = il_group_id
//messagebox("gp_id",gp_id)
//tab_1.tabpage_gp.tab_2.tabpage_detail.dw_detail.retrieve(gp_id)
//tab_1.tabpage_prac.dw_prac.retrieve(gp_id)
//tab_1.tabpage_site.dw_site.retrieve(gp_id)



end event

type dw_search from u_dw within tabpage_browse
integer x = 73
integer y = 68
integer width = 2075
integer height = 348
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_group_search"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.InsertRow( 0 )
This.InsertRow( 0 )
This.InsertRow( 0 )
This.SetItem( 1, "search_type", "street" )
end event

type gb_search from groupbox within tabpage_browse
integer x = 32
integer y = 4
integer width = 2482
integer height = 424
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Search Criteria"
end type

type cb_search from commandbutton within tabpage_browse
integer x = 2153
integer y = 260
integer width = 311
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Search"
end type

event clicked;Integer i
Integer li_rc
String ls_where

ls_where = " and " 

li_rc = dw_search.RowCount() 

dw_search.AcceptText()

FOR i = 1 TO li_rc
	IF IsNull( dw_search.GetItemString( i, "search_type" ) )  THEN
		CONTINUE
	END IF
	ls_where = ls_where + dw_search.GetItemString( i, "search_type" ) +&
	" like '" + dw_search.GetItemString( i, "criteria" ) +"%' AND "
END FOR

ls_where = MidA( ls_where, 1, LenA( ls_where ) - 5 )
dw_browse.SetSqlSelect( is_sql + " " + ls_where )
dw_browse.SetTransObject( SQLCA )
dw_browse.Retrieve()














//string ls_filter = ""
//integer li_rtnval
//
//if isnull(sle_1.text) then return
//
//ls_filter = upper(sle_1.text)
//
//if ls_filter = "" then 
//	ls_filter = ""
//else
//	ls_filter = "upper(street) like '%" + ls_filter + "%'"
//
//end if
//	
//
//
////messagebox("filter",ls_filter)
////li_rtnval = 
//tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.setfilter(ls_filter)  
////if li_rtnval = 1 then
//tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.filter()
end event

type cb_clear from commandbutton within tabpage_browse
integer x = 2153
integer y = 120
integer width = 311
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Clear"
end type

event clicked;dw_search.Reset()
dw_search.InsertRow( 0 )
dw_search.InsertRow( 0 )
dw_search.InsertRow( 0 )
dw_search.SetItem( 1, "search_type", "street" )
end event

type tabpage_detail from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 3397
integer height = 1720
long backcolor = 79741120
string text = "Location Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Cursor!"
long picturemaskcolor = 553648127
dw_detail dw_detail
end type

on tabpage_detail.create
this.dw_detail=create dw_detail
this.Control[]={this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.dw_detail)
end on

type dw_detail from u_dw within tabpage_detail
integer x = 18
integer y = 20
integer width = 3355
integer height = 1656
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_group_data_entry"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)

DataWindowChild dwchild


This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
dwchild.InsertRow( 1 )
end event

type tabpage_ass_prac from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 3397
integer height = 1720
long backcolor = 79741120
string text = "Associated Practitioners"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Picture!"
long picturemaskcolor = 553648127
dw_prac dw_prac
cb_link_prac cb_link_prac
end type

on tabpage_ass_prac.create
this.dw_prac=create dw_prac
this.cb_link_prac=create cb_link_prac
this.Control[]={this.dw_prac,&
this.cb_link_prac}
end on

on tabpage_ass_prac.destroy
destroy(this.dw_prac)
destroy(this.cb_link_prac)
end on

type dw_prac from u_dw within tabpage_ass_prac
integer x = 27
integer y = 128
integer width = 3337
integer height = 1552
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_group_practitioners"
end type

event constructor;call super::constructor;this.settransobject(sqlca)

DataWindowChild dwchild


This.GetChild( "specialty", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("practitioner specialties")
dwchild.InsertRow( 1 )



This.GetChild( "specialty_order", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("specialty order")
dwchild.InsertRow( 1 )

This.GetChild( "accepting_new_patients", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
dwchild.InsertRow( 1 )



end event

type cb_link_prac from commandbutton within tabpage_ass_prac
integer x = 32
integer y = 16
integer width = 622
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Establish Practitioner Links"
end type

event clicked;if il_group_id < 1 then
	messagebox("No practice selected.","Please go to the browse screen and select a practice. ")
	return
end if

openwithparm(w_gp_prac_link,il_group_id)

dw_prac.retrieve(il_group_id)
end event

type tabpage_survey from userobject within tab_2
integer x = 18
integer y = 16
integer width = 3397
integer height = 1720
long backcolor = 79741120
string text = "Site Survey"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DosEdit!"
long picturemaskcolor = 553648127
uo_survey uo_survey
end type

on tabpage_survey.create
this.uo_survey=create uo_survey
this.Control[]={this.uo_survey}
end on

on tabpage_survey.destroy
destroy(this.uo_survey)
end on

type uo_survey from pfc_cst_u_site_survey_collect_data within tabpage_survey
integer x = 18
integer y = 20
integer width = 3515
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_survey.destroy
call pfc_cst_u_site_survey_collect_data::destroy
end on

type tabpage_group_master from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3511
integer height = 2052
long backcolor = 79741120
string text = "Multi-location Groups"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "CreateLibrary5!"
long picturemaskcolor = 553648127
cb_addmgp cb_addmgp
cb_linksave cb_linksave
cb_addloc cb_addloc
dw_mg_browse dw_mg_browse
dw_mg_detail dw_mg_detail
dw_loc_links dw_loc_links
cb_3 cb_3
sle_2 sle_2
cb_1 cb_1
cb_2 cb_2
end type

on tabpage_group_master.create
this.cb_addmgp=create cb_addmgp
this.cb_linksave=create cb_linksave
this.cb_addloc=create cb_addloc
this.dw_mg_browse=create dw_mg_browse
this.dw_mg_detail=create dw_mg_detail
this.dw_loc_links=create dw_loc_links
this.cb_3=create cb_3
this.sle_2=create sle_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.Control[]={this.cb_addmgp,&
this.cb_linksave,&
this.cb_addloc,&
this.dw_mg_browse,&
this.dw_mg_detail,&
this.dw_loc_links,&
this.cb_3,&
this.sle_2,&
this.cb_1,&
this.cb_2}
end on

on tabpage_group_master.destroy
destroy(this.cb_addmgp)
destroy(this.cb_linksave)
destroy(this.cb_addloc)
destroy(this.dw_mg_browse)
destroy(this.dw_mg_detail)
destroy(this.dw_loc_links)
destroy(this.cb_3)
destroy(this.sle_2)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type cb_addmgp from commandbutton within tabpage_group_master
integer x = 1330
integer y = 16
integer width = 279
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Group"
end type

event clicked;tab_1.tabpage_group_master.dw_mg_detail.insertrow(0)
end event

type cb_linksave from commandbutton within tabpage_group_master
integer x = 1618
integer y = 16
integer width = 247
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

event clicked;integer li_mgroup_id


if tab_1.tabpage_group_master.dw_mg_detail.getitemstatus(1,0,primary!) = newmodified! then
	select max(rec_id)
	into :li_mgroup_id
	from group_multi_loc;
	
	if li_mgroup_id < 1 OR IsNull( li_mgroup_id) then li_mgroup_id = 0
	
	li_mgroup_id++
	tab_1.tabpage_group_master.dw_mg_detail.setitem(1,"rec_id",li_mgroup_id)
end if

tab_1.tabpage_group_master.dw_mg_detail.update()

commit using sqlca;
end event

type cb_addloc from commandbutton within tabpage_group_master
integer x = 2345
integer y = 16
integer width = 439
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Location Link"
end type

event clicked;integer li_linkrow
integer li_link_id
integer li_loc_id
integer li_mgp_id


cb_linksave.triggerevent(clicked!)


open(w_practice_to_addr_find)

li_loc_id = message.doubleparm
if li_loc_id < 1 then return

li_mgp_id = ii_mgp_id
 
 li_linkrow = tab_1.tabpage_group_master.dw_loc_links.insertrow(0)
 
tab_1.tabpage_group_master.dw_loc_links.setrow(li_linkrow) 
tab_1.tabpage_group_master.dw_loc_links.scrolltorow(li_linkrow)
tab_1.tabpage_group_master.dw_loc_links.selectrow(0,false)
tab_1.tabpage_group_master.dw_loc_links.selectrow(li_linkrow,true)
 

	select max(rec_id)
	into :li_link_id
	from group_loc_link;
	
if li_link_id < 1 OR IsNull( li_link_id ) then li_link_id = 0
	
li_link_id++
tab_1.tabpage_group_master.dw_loc_links.setitem(1,"group_loc_link_rec_id",li_link_id)
tab_1.tabpage_group_master.dw_loc_links.setitem(1,"group_loc_link_loc_id",li_loc_id) 
tab_1.tabpage_group_master.dw_loc_links.setitem(1,"group_loc_link_group_id",li_mgp_id)

tab_1.tabpage_group_master.dw_loc_links.update()
commit using sqlca;


end event

type dw_mg_browse from datawindow within tabpage_group_master
integer x = 46
integer y = 112
integer width = 3337
integer height = 612
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_multi_group_browse"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_row

li_row = this.getclickedrow()

tab_1.tabpage_group_master.dw_mg_detail.setrow(li_row)
tab_1.tabpage_group_master.dw_mg_detail.scrolltorow(li_row)

IF li_row < 1 then return
ii_mgp_id = this.getitemnumber( li_row, "rec_id") 
This.SelectRow( 0, False )
This.SelectRow( li_row, True )
end event

event constructor;this.settransobject(sqlca)

end event

event retrieveend;
IF rowcount > 0 THEN
	ii_mgp_id = this.getitemnumber( 1, "rec_id")
	tab_1.tabpage_group_master.dw_mg_detail.retrieve(ii_mgp_id)
	tab_1.tabpage_group_master.dw_loc_links.retrieve(ii_mgp_id)
	This.SelectRow( 0, False )
	This.SelectRow( 1, True )
END IF

end event

event rowfocuschanged;

tab_1.tabpage_group_master.dw_mg_detail.retrieve(ii_mgp_id)
tab_1.tabpage_group_master.dw_loc_links.retrieve(ii_mgp_id)
end event

type dw_mg_detail from datawindow within tabpage_group_master
integer x = 41
integer y = 744
integer width = 3333
integer height = 576
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_multi_group_detail"
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

end event

type dw_loc_links from datawindow within tabpage_group_master
integer x = 41
integer y = 1340
integer width = 3333
integer height = 628
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_group_linked_locations"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

DataWindowChild dwchild


This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
dwchild.InsertRow( 1 )


This.GetChild( "practice_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("practice type")
dwchild.InsertRow( 1 )

end event

type cb_3 from commandbutton within tabpage_group_master
integer x = 709
integer y = 16
integer width = 485
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Filter Group Name"
end type

event clicked;string ls_filter = ""
integer li_rtnval

if isnull(sle_2.text) then return

ls_filter = upper(sle_2.text)

if ls_filter = "" then 
	ls_filter = ""
else
	ls_filter = "upper(street) like '%" + ls_filter + "%'"

end if
	
tab_1.tabpage_group_master.dw_mg_browse.setfilter(ls_filter)  

tab_1.tabpage_group_master.dw_mg_browse.filter()
end event

type sle_2 from singlelineedit within tabpage_group_master
integer x = 50
integer y = 24
integer width = 576
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within tabpage_group_master
integer x = 1874
integer y = 16
integer width = 334
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Group"
end type

event clicked;integer res
integer r

res = messagebox("Delete","Are you sure you want to delete the selected Group and all its links?(will not effect practice locations)",question!,yesno!,2)

if res = 1 then
	for r = 1 to tab_1.tabpage_group_master.dw_loc_links.rowcount()
		tab_1.tabpage_group_master.dw_loc_links.deleterow(r)
	next
	tab_1.tabpage_group_master.dw_mg_browse.deleterow(0)
end if
end event

type cb_2 from commandbutton within tabpage_group_master
integer x = 2807
integer y = 16
integer width = 494
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Location Link"
end type

event clicked;integer res

res = messagebox("Delete","Are you sure you want to delete the selected link?",question!,yesno!,2)

if res = 1 then
	tab_1.tabpage_group_master.dw_loc_links.deleterow(0)
end if
end event

