$PBExportHeader$w_privilege_report_mockup.srw
forward
global type w_privilege_report_mockup from w_main
end type
type cb_help from commandbutton within w_privilege_report_mockup
end type
type dw_print from u_dw within w_privilege_report_mockup
end type
type dw_search from datawindow within w_privilege_report_mockup
end type
type cb_go from commandbutton within w_privilege_report_mockup
end type
type sle_search from singlelineedit within w_privilege_report_mockup
end type
type cbx_exact from checkbox within w_privilege_report_mockup
end type
type rb_procd from radiobutton within w_privilege_report_mockup
end type
type p_1 from picture within w_privilege_report_mockup
end type
type cb_close from commandbutton within w_privilege_report_mockup
end type
type dw_facility from datawindow within w_privilege_report_mockup
end type
type cb_printreport from commandbutton within w_privilege_report_mockup
end type
type dw_stat from datawindow within w_privilege_report_mockup
end type
type gb_1 from groupbox within w_privilege_report_mockup
end type
type cb_run_report from commandbutton within w_privilege_report_mockup
end type
type gb_2 from groupbox within w_privilege_report_mockup
end type
type gb_3 from groupbox within w_privilege_report_mockup
end type
type rb_prac from radiobutton within w_privilege_report_mockup
end type
type p_prac from picture within w_privilege_report_mockup
end type
end forward

global type w_privilege_report_mockup from w_main
integer x = 9
integer y = 4
integer width = 4279
integer height = 3112
string title = "Privilege Report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 16777215
cb_help cb_help
dw_print dw_print
dw_search dw_search
cb_go cb_go
sle_search sle_search
cbx_exact cbx_exact
rb_procd rb_procd
p_1 p_1
cb_close cb_close
dw_facility dw_facility
cb_printreport cb_printreport
dw_stat dw_stat
gb_1 gb_1
cb_run_report cb_run_report
gb_2 gb_2
gb_3 gb_3
rb_prac rb_prac
p_prac p_prac
end type
global w_privilege_report_mockup w_privilege_report_mockup

type variables
integer il_clicked_column
integer il_width
integer il_height
integer il_x
integer il_y

long il_facility
long il_clin_area_preview
long il_priv_id
long il_prac //maha 11.15.2010

string is_nophoto
end variables

forward prototypes
public function integer of_hide_objects (string as_from)
public function integer of_get_the_photo (long al_prac)
end prototypes

public function integer of_hide_objects (string as_from);if as_from = "prac" then
	cbx_exact.visible = false
	cb_help.visible = false
else
	cbx_exact.visible = true
	cb_help.visible = true
end if

return 1

end function

public function integer of_get_the_photo (long al_prac);//Start Code Change ----06.17.2010 #V10 maha //search screen photo
string ls_picname

if al_prac > 0 then
	ls_picname = of_photo_download(al_prac)
	
	if 	ls_picname = "None" then
		p_prac.PictureName = is_nophoto
	else
		if FileExists(ls_PicName) then
			p_prac.PictureName = ls_picname
		//	tab_1.tabpage_search.p_prac_photo.PictureName = ls_picname
		else
			p_prac.PictureName =  is_nophoto
		end if
	end if

else
	p_prac.PictureName = is_nophoto
end if
	
return 1
//End Code Change ----06.17.2010
end function

on w_privilege_report_mockup.create
int iCurrent
call super::create
this.cb_help=create cb_help
this.dw_print=create dw_print
this.dw_search=create dw_search
this.cb_go=create cb_go
this.sle_search=create sle_search
this.cbx_exact=create cbx_exact
this.rb_procd=create rb_procd
this.p_1=create p_1
this.cb_close=create cb_close
this.dw_facility=create dw_facility
this.cb_printreport=create cb_printreport
this.dw_stat=create dw_stat
this.gb_1=create gb_1
this.cb_run_report=create cb_run_report
this.gb_2=create gb_2
this.gb_3=create gb_3
this.rb_prac=create rb_prac
this.p_prac=create p_prac
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_help
this.Control[iCurrent+2]=this.dw_print
this.Control[iCurrent+3]=this.dw_search
this.Control[iCurrent+4]=this.cb_go
this.Control[iCurrent+5]=this.sle_search
this.Control[iCurrent+6]=this.cbx_exact
this.Control[iCurrent+7]=this.rb_procd
this.Control[iCurrent+8]=this.p_1
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_facility
this.Control[iCurrent+11]=this.cb_printreport
this.Control[iCurrent+12]=this.dw_stat
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.cb_run_report
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.rb_prac
this.Control[iCurrent+18]=this.p_prac
end on

on w_privilege_report_mockup.destroy
call super::destroy
destroy(this.cb_help)
destroy(this.dw_print)
destroy(this.dw_search)
destroy(this.cb_go)
destroy(this.sle_search)
destroy(this.cbx_exact)
destroy(this.rb_procd)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.dw_facility)
destroy(this.cb_printreport)
destroy(this.dw_stat)
destroy(this.gb_1)
destroy(this.cb_run_report)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.rb_prac)
destroy(this.p_prac)
end on

event closequery;//nothing
end event

event open;call super::open; DataWindowChild dwchild
 
 //set blank picture name
 is_nophoto = gs_dir_path +  "intelliCred\nophoto.bmp"
 
select default_search_facility into :il_facility from security_users where user_id = :gs_user_id;

if il_facility > 0 then
	dw_facility.setitem(1,"facility_id",il_facility)
end if


end event

type cb_help from commandbutton within w_privilege_report_mockup
integer x = 3090
integer width = 82
integer height = 76
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;Messagebox("Exact phrase","If you are searching on more than one word, Exact phrase will search for a literal match.~rExample: Pain Management~r   Exact phrase will search for an exact match ( '...Management of pain...' would NOT appear in results).~rUnchecked the search will find records with all words.( '...Management of pain...' WOULD appear in results)")
end event

type dw_print from u_dw within w_privilege_report_mockup
integer x = 23
integer y = 928
integer width = 3479
integer height = 2080
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_priv_search_pracs_priv"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;integer r

r =  this.getclickedrow()

if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

il_prac = this.getitemnumber(r,"prac_id")

of_get_the_photo(il_prac)

end event

event doubleclicked;call super::doubleclicked;long ll_rec

//if rb_prac.checked then
	ll_rec = this.getitemnumber(row,"rec_id")
	openwithparm(w_priv_prac_detail,ll_rec)
//end if
end event

type dw_search from datawindow within w_privilege_report_mockup
integer x = 23
integer y = 212
integer width = 4210
integer height = 688
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_priv_procd_search"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long r

r = this.getclickedrow()

if rb_procd.checked then

	if r > 0 then //maha app100305
		il_priv_id = this.getitemnumber(r,"procd_id")
	else
		il_priv_id = 0
	end if
	
	p_prac.picturename = "none"
	cb_run_report.triggerevent(clicked!)
	
else
	il_prac =  this.getitemnumber(r,"prac_id")
	cb_run_report.triggerevent(clicked!)
	of_get_the_photo(il_prac)
end if
end event

type cb_go from commandbutton within w_privilege_report_mockup
integer x = 3200
integer y = 80
integer width = 183
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go"
end type

event clicked;string ls_search
string ls_words[]
integer i
integer r
integer wi = 0
string ls_sql
string ls_keyword
string ls_where
integer p1
integer p2
integer p3
string ls_sql_org
string iword
integer rows
integer wc
long bugid
datawindow ldw_search

ldw_search = dw_search

if il_facility = 0 then
	messagebox("Search","Facility must be selected before searching")
	return
end if

//get search value
ls_search = upper(sle_search.text)

if len(ls_search) = 0 then
	messagebox("Search","Search Value has not been entered")
	return
end if

if rb_procd.checked then
	ldw_search.dataobject = "d_priv_procd_search"
elseif  rb_prac.checked then
	ldw_search.dataobject = "d_priv_prac_search" 
else
	return 1
end if
debugbreak()
ldw_search.SetTransObject( SQLCA )

ls_sql = ldw_search.Object.DataWindow.Table.Select
ls_sql_org = ls_sql
//messagebox("",ls_sql)
ls_sql = of_strip_char("~~", ls_sql,"" )

if rb_procd.checked then
	ls_keyword =  " and facility_id = " + string(il_facility) + " and "
	
	if len(ls_search) < 1 then //no value
		ls_keyword = "" 
		//messagebox("ls_keyword","Nothing")
	
	elseif cbx_exact.checked = true then //exact
		ls_keyword+=	" upper(core_procd_description) like '%" + ls_search + "%'"	
		
	else //all and any
		if Pos(ls_search, " " ,1) < 1 then //if only 1 word treat like exact
			ls_keyword+=	" upper(core_procd_description) like '%" + ls_search + "%'"	
			
		else
			p1 = Pos(ls_search, " "  )
			if isnull(p1) then //error
				ls_keyword = ""
				//messagebox("ls_keyword null",ls_keyword)
		//	elseif p1 = 0 then //one word
		//		ls_words[1] = mid(ls_search,1,len(ls_search))
		//		messagebox("only one word",ls_words[1])
			else
				
				ls_keyword = ls_keyword + " ("
				wi = 1
				ls_words[wi] = mid(ls_search,1,p1 - 1)
				do while p1 >0 //for each word put into array
					p2 = p1
					p1 = Pos(ls_search, " " ,p2 + 1)
					wi++
					if p1 = 0 then
						ls_words[wi] = mid(ls_search,p2 + 1,len(ls_search))
					else
						ls_words[wi] = mid(ls_search,p2 + 1,p1 - p2 - 1)
					end if
				loop
			end if
			
			wc = upperbound(ls_words)
			for i = 1 to wc
				iword = ls_words[i]
				//messagebox("ls_words[i]",iword)
				
				ls_keyword = ls_keyword + " upper(core_procd_description) like '%" + ls_words[i] + "%'"
	//			if rb_all.checked = true then //all
				ls_keyword = ls_keyword + " and"
	//			elseif rb_any.checked = true then //any
	//				ls_keyword = ls_keyword + " or "
	//			end if
			next
			ls_keyword = mid(ls_keyword,1,len(ls_keyword) - 4)
			ls_keyword = ls_keyword + " )"
		end if
	
		
	end if 
	
//	ls_where =  ls_keyword 
//		//messagebox("ls_where",ls_where)
//	
//	ls_sql = ls_sql + ls_where + ";"
	
	
else //search by prac
	
	ls_keyword =  " and facility_id = " + string(il_facility) + " and "
	
	ls_keyword+=  " upper(v_full_name.last_name) like '%" + ls_search + "%'"	
	
	
	//ldw_search.retrieve(ls_search,il_facility)
end if

ls_where =  ls_keyword 
//messagebox("ls_where",ls_where)
	
ls_sql = ls_sql + ls_where + ";"

ldw_search.SetSQLSelect ( ls_sql )
	
//messagebox( "w_sql_msg", ls_sql )
ldw_search.SetTransObject( SQLCA )
	
rows = ldw_search.Retrieve()
	
if rows < 1 then
	messagebox("No records found","There are no records that meet the specified search criteria")
end if
	
ldw_search.SetSQLSelect ( ls_sql_org )
ldw_search.settransobject(sqlca)






end event

type sle_search from singlelineedit within w_privilege_report_mockup
integer x = 2149
integer y = 72
integer width = 1010
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_exact from checkbox within w_privilege_report_mockup
integer x = 2651
integer y = 8
integer width = 453
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Exact phrase"
end type

type rb_procd from radiobutton within w_privilege_report_mockup
integer x = 1056
integer y = 64
integer width = 443
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
string text = "Procedure"
boolean checked = true
end type

event clicked;of_hide_objects("procd")
dw_print.dataobject = "d_rpt_pracs_granted_for_priv"
dw_print.settransobject(sqlca)
end event

type p_1 from picture within w_privilege_report_mockup
boolean visible = false
integer x = 3451
integer y = 100
integer width = 96
integer height = 64
string picturename = "Custom035!"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_privilege_report_mockup
integer x = 3881
integer y = 84
integer width = 297
integer height = 84
integer taborder = 40
boolean bringtotop = true
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

type dw_facility from datawindow within w_privilege_report_mockup
integer x = 14
integer y = 60
integer width = 955
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_priv_facility_id"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long i
DataWindowChild dwchild

il_facility = integer(data)
//messagebox("facility", il_facility)
//tab_1.tabpage_comp.dw_clin.settransobject(sqlca)
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-03
////$<add> 02.10.2006 By: Liang QingShi
////$<reason> Performance tuning
////$<modification> Add the following script to make sure that RowFocusChanged will 
////$<modification> always be triggered.
//tab_1.tabpage_comp.dw_clin.reset()
//tab_1.tabpage_comp.dw_core.reset()
//tab_1.tabpage_comp.dw_procd.reset()
////---------------------------- APPEON END ----------------------------
//
// i = tab_1.tabpage_comp.dw_clin.retrieve(il_facility)
// tab_1.tabpage_comp.dw_tv.retrieve(il_facility)
////tab_1.tabpage_comp.cb_add_clin.enabled = true
////tab_1.tabpage_comp.cb_delete_clin.enabled = true
////tab_1.tabpage_comp.cb_copy_proc.enabled = true
////
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-04
////$<comment> 02.10.2006 By: Liang QingShi
////$<reason> Performance tuning
////$<modification> Comment out the following script dw_clin.Retrieve has already triggered
////$<modification> the RowFocusChanged event.
///*
//tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)
//*/
////---------------------------- APPEON END ----------------------------
////retrieve clin area select drop downs
//if i > 0 then //if added maha 020403 to avoid retrieval request when no clin areas exist for facility
//
//	tab_1.tabpage_report.dw_clin_select_preview.settransobject(sqlca)
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-05
//	//$<add> 02.08.2006 By: Liang QingShi
//	//$<reason> Performance tuning
//	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
// 
//	gnv_appeondb.of_startqueue( )
//	//---------------------------- APPEON END ----------------------------
//	tab_1.tabpage_report.dw_clin_select_preview.retrieve()
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-06
//	//$<comment> 02.08.2006 By: Liang QingShi
//	//$<reason> Performance tuning
//	//$<modification> Move the following script to PT-07, since InsertRow should be
//	//$<modification> executed after the Appeon labels.
//	/*
//	tab_1.tabpage_report.dw_clin_select_preview.insertrow(1)
//	*/
//	//---------------------------- APPEON END ----------------------------
//
//	tab_1.tabpage_report.dw_clin_select_preview.GetChild( "clinical_area_description", dwchild )
//	dwchild.settransobject(sqlca)
//	dwchild.retrieve(il_facility)
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-07
//	//$<add> 02.08.2006 By: Liang QingShi
//	//$<reason> Performance tuning
//	//$<modification> 1)Copy the script from PT-06.
//	//$<modification> 2)Add an Appeon Commit Queue Label to reduce client-server interactions. 
//	gnv_appeondb.of_commitqueue( )
//
//	tab_1.tabpage_report.dw_clin_select_preview.insertrow(1)
//
//	//---------------------------- APPEON END ----------------------------
//
//else
//	
//	tab_1.tabpage_report.dw_clin_select_preview.reset()
//end if
//
//
//

//\/maha  The following code protects against the retrieval message box when there are no rows.
integer rc1
rc1 = dwchild.rowcount()
//messagebox("rowcount", rc1)
if rc1 = 0 then
	dwchild.insertrow(1)
end if
//\maha


end event

event constructor;dw_facility.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-07-06 By: Liu Hongxin
//$<reason> Clause Overlap with dwchild.retrieve()
/*
dw_facility.retrieve()
*/
//---------------------------- APPEON END ----------------------------
dw_facility.InsertRow( 1 )

DataWindowChild dwchild

This.GetChild( "facility_name", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
end event

type cb_printreport from commandbutton within w_privilege_report_mockup
boolean visible = false
integer x = 3625
integer y = 84
integer width = 247
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_print.print()
end event

type dw_stat from datawindow within w_privilege_report_mockup
boolean visible = false
integer x = 3511
integer y = 88
integer width = 78
integer height = 44
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_priv_status_select"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;integer i
integer ic

this.settransobject(sqlca)
ic = this.retrieve()

for i = 1 to ic
	if upper(this.getitemstring(i,"custom_1")) = "G" then
		this.setitem(i,"selected",1)
	end if
next
end event

type gb_1 from groupbox within w_privilege_report_mockup
integer width = 997
integer height = 168
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Select Facility"
end type

type cb_run_report from commandbutton within w_privilege_report_mockup
boolean visible = false
integer x = 3387
integer y = 80
integer width = 82
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;integer i
integer cnt
long ll_stats[]

if rb_procd.checked then

	if il_priv_id < 1 then return
	
	for i = 1 to dw_stat.rowcount()
		if dw_stat.getitemnumber(i,"selected") = 1 then
			cnt++
			ll_stats[i] = dw_stat.getitemnumber(i,"lookup_code")
		end if
	next
	
	if cnt = 0 then
		messagebox("Granted Status?","There are no Status types defined as Granted in the Lookup painter for the Privilege Status lookup.  Enter a G in the Custom 1 field to define Granted types")
		return
	end if
	
	dw_print.settransobject(sqlca)
	dw_print.retrieve(il_priv_id,ll_stats, il_facility )
	
	if cnt = 0 then
		dw_print.insertrow(1)
		dw_print.setitem(1,"v_full_name_full_name", "No Practitoners found.")
		dw_print.setitem(1,"procd_id",il_priv_id )
	end if
else //prac
	dw_print.settransobject(sqlca)
	dw_print.retrieve(il_prac, il_facility )
end if



end event

type gb_2 from groupbox within w_privilege_report_mockup
integer x = 1006
integer width = 1106
integer height = 168
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Search by Procedure or Practitioner"
end type

type gb_3 from groupbox within w_privilege_report_mockup
integer x = 2130
integer width = 1051
integer height = 172
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Search Value"
end type

type rb_prac from radiobutton within w_privilege_report_mockup
integer x = 1490
integer y = 64
integer width = 567
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
string text = "Practitioner "
end type

event clicked;of_hide_objects("prac")
dw_print.dataobject = "d_priv_prac_search_w_desc"
dw_print.settransobject(sqlca)
end event

type p_prac from picture within w_privilege_report_mockup
integer x = 3525
integer y = 932
integer width = 709
integer height = 820
boolean bringtotop = true
string picturename = "nophoto.bmp"
boolean border = true
boolean focusrectangle = false
end type

