$PBExportHeader$w_web_crawler_painter.srw
forward
global type w_web_crawler_painter from w_response
end type
type cb_3 from commandbutton within w_web_crawler_painter
end type
type cb_2 from commandbutton within w_web_crawler_painter
end type
type cb_save from commandbutton within w_web_crawler_painter
end type
type tab_main from tab within w_web_crawler_painter
end type
type tabpage_browse from userobject within tab_main
end type
type cb_sort from commandbutton within tabpage_browse
end type
type cb_6 from commandbutton within tabpage_browse
end type
type cb_4 from commandbutton within tabpage_browse
end type
type cb_select_crawler from commandbutton within tabpage_browse
end type
type cb_delete_crawler from commandbutton within tabpage_browse
end type
type cb_crawler from commandbutton within tabpage_browse
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_main
cb_sort cb_sort
cb_6 cb_6
cb_4 cb_4
cb_select_crawler cb_select_crawler
cb_delete_crawler cb_delete_crawler
cb_crawler cb_crawler
dw_browse dw_browse
end type
type tabpage_detail from userobject within tab_main
end type
type tab_detail from tab within tabpage_detail
end type
type tabpage_header from userobject within tab_detail
end type
type cb_cc_info from commandbutton within tabpage_header
end type
type cb_test_url from commandbutton within tabpage_header
end type
type dw_header from u_dw within tabpage_header
end type
type tabpage_header from userobject within tab_detail
cb_cc_info cb_cc_info
cb_test_url cb_test_url
dw_header dw_header
end type
type tabpage_data_link from userobject within tab_detail
end type
type cb_sa from commandbutton within tabpage_data_link
end type
type dw_multi_entity_wc_data from u_dw within tabpage_data_link
end type
type dw_psv_entities from u_dw within tabpage_data_link
end type
type dw_data_linking from u_dw within tabpage_data_link
end type
type tabpage_data_link from userobject within tab_detail
cb_sa cb_sa
dw_multi_entity_wc_data dw_multi_entity_wc_data
dw_psv_entities dw_psv_entities
dw_data_linking dw_data_linking
end type
type tabpage_steps from userobject within tab_detail
end type
type st_1 from statictext within tabpage_steps
end type
type cb_copy from commandbutton within tabpage_steps
end type
type cb_5 from commandbutton within tabpage_steps
end type
type cb_1 from commandbutton within tabpage_steps
end type
type cb_add_step from commandbutton within tabpage_steps
end type
type cb_delete_step from commandbutton within tabpage_steps
end type
type dw_steps_browse from u_dw within tabpage_steps
end type
type dw_extract_data from u_dw within tabpage_steps
end type
type cb_syn_add from commandbutton within tabpage_steps
end type
type cb_syn_delete from commandbutton within tabpage_steps
end type
type dw_steps_detail from u_dw within tabpage_steps
end type
type tabpage_steps from userobject within tab_detail
st_1 st_1
cb_copy cb_copy
cb_5 cb_5
cb_1 cb_1
cb_add_step cb_add_step
cb_delete_step cb_delete_step
dw_steps_browse dw_steps_browse
dw_extract_data dw_extract_data
cb_syn_add cb_syn_add
cb_syn_delete cb_syn_delete
dw_steps_detail dw_steps_detail
end type
type tab_detail from tab within tabpage_detail
tabpage_header tabpage_header
tabpage_data_link tabpage_data_link
tabpage_steps tabpage_steps
end type
type tabpage_detail from userobject within tab_main
tab_detail tab_detail
end type
type tab_main from tab within w_web_crawler_painter
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
end forward

global type w_web_crawler_painter from w_response
integer x = 214
integer y = 221
integer width = 3520
integer height = 2240
string title = "Web Crawler Painter"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string pointer = "Arrow!"
boolean ib_closestatus = true
cb_3 cb_3
cb_2 cb_2
cb_save cb_save
tab_main tab_main
end type
global w_web_crawler_painter w_web_crawler_painter

type variables
Integer ii_wc_id
Integer ii_step_order
Boolean ib_new = False
Boolean ib_new_step = False
Boolean ib_retr_steps = False
end variables

on w_web_crawler_painter.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_save=create cb_save
this.tab_main=create tab_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.tab_main
end on

on w_web_crawler_painter.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.tab_main)
end on

event open;call super::open;tab_main.tabpage_browse.dw_browse.SetTransObject( SQLCA )
tab_main.tabpage_browse.dw_browse.Retrieve( )

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 06.29.2012
//$<reason>  V12.2 WebCrawler extract data
datawindowchild ldwc_1
integer li_find

tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.getchild("step_action",ldwc_1)
if gi_prod_setting <> 0 then
	li_find = ldwc_1.find("action_type = 'Extract for Data update'", 1, ldwc_1.rowcount())
	if li_find > 0 then ldwc_1.deleterow(li_find)
end if
//------------------- APPEON END -------------------

end event

type cb_3 from commandbutton within w_web_crawler_painter
boolean visible = false
integer x = 3058
integer y = 148
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

type cb_2 from commandbutton within w_web_crawler_painter
integer x = 3154
integer y = 12
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_save from commandbutton within w_web_crawler_painter
integer x = 2702
integer y = 148
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;Integer li_found
Integer i
Integer li_rc
Integer li_nr
Integer li_step_order
integer li_testnew
integer li_testorg
integer res
Long ll_lookup_code
Boolean lb_steps_no_rows = False
datetime ldt_now
u_dw dw_steps_detail  //maha 03.21.2016

dw_steps_detail = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail  //Start Code Change ----03.21.2016 #V15 maha

ldt_now = datetime( today(),now())

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.setitem(1,"last_updated",ldt_now)

//if no wc_id delete row
IF dw_steps_detail.RowCount( ) > 0 THEN
	IF IsNull( dw_steps_detail.GetItemNumber( 1, "wc_id" ) )  THEN
		dw_steps_detail.DeleteRow( 1 )
		lb_steps_no_rows = True
	END IF
END IF

if ib_new_step = true then ib_retr_steps = true

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.Update()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.12.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.Update( )

tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.Update( )

//update the wc_multi_entity_link table (delete existing records and recreate based on setting.)
DELETE
FROM wc_multi_entity_link
WHERE wc_id = :ii_wc_id;

tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.AcceptText( )
li_rc = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.RowCount()
FOR i = 1 TO li_rc
	IF  tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.GetItemNumber( i, "selected" ) = 1 THEN
		 li_nr = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.InsertRow( 0 )
 		 tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.SetItem( li_nr, "wc_id", ii_wc_id )
		 ll_lookup_code = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.GetItemNumber( i, "lookup_code" )
		 tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.SetItem( li_nr, "wc_lookup_code" , ll_lookup_code)
	END IF
END FOR
 tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.Update( )
 
dw_steps_detail.AcceptText( )

if tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.rowcount() > 0 then  //Start Code Change ---- 02.05.2007 #V7 maha trap
	IF ib_retr_steps = True THEN  //Start Code Change ---- 02.05.2007 #V7 maha
		for i = 1 to tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.rowcount()
			if tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.getitemnumber(i,"step_order") = li_step_order then
				MessageBox( "Duplicate Step", "Change Step Order " + string(li_step_order) + ". It is already in use." )
				return
			end if
		next
	else
		li_step_order = dw_steps_detail.GetItemNumber( 1, "step_order" )
	end if
end if
//	li_step_order = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.GetItemNumber( 1, "step_order" )	
//	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SetFilter( "step_order = " + String( li_step_order ) )
//	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Filter( )
//	IF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.RowCount( ) > 0 THEN
//		MessageBox( "Duplicate Step", "Change Step Order. It is already in use." )
//		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SetFilter( "" )
//		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Filter( )
//		Return	
//	END IF
//	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SetFilter( "" )
//	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Filter( )
//END IF

res = dw_steps_detail.Update( )
//Start Code Change ---- 02.05.2007 #V7 maha
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 04.12.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

if ib_retr_steps then
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_Browse.Retrieve( ii_wc_id )
	li_found = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Find( "step_order = " + String( li_step_order ) , 1, 10000)
	IF li_found > 0 THEN
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SetRow( li_found )
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow( 0 , False )
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow( li_found, True )
	ELSE
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SetRow( 1 )
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow( 0 , False )
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow( 1, True )	
	END IF
end if

//reretrieve the WC list.
if ib_new then
	tab_main.tabpage_browse.dw_browse.retrieve()
end if
//End Code Change---02.05.2007

ib_New = False
ib_new_step = False
ib_retr_steps = false

IF lb_steps_no_rows THEN
	dw_steps_detail.InsertRow( 0 )
END IF
end event

type tab_main from tab within w_web_crawler_painter
integer x = 27
integer y = 8
integer width = 3474
integer height = 2144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_main.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_main.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

type tabpage_browse from userobject within tab_main
integer x = 18
integer y = 112
integer width = 3438
integer height = 2016
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Justify!"
long picturemaskcolor = 536870912
cb_sort cb_sort
cb_6 cb_6
cb_4 cb_4
cb_select_crawler cb_select_crawler
cb_delete_crawler cb_delete_crawler
cb_crawler cb_crawler
dw_browse dw_browse
end type

on tabpage_browse.create
this.cb_sort=create cb_sort
this.cb_6=create cb_6
this.cb_4=create cb_4
this.cb_select_crawler=create cb_select_crawler
this.cb_delete_crawler=create cb_delete_crawler
this.cb_crawler=create cb_crawler
this.dw_browse=create dw_browse
this.Control[]={this.cb_sort,&
this.cb_6,&
this.cb_4,&
this.cb_select_crawler,&
this.cb_delete_crawler,&
this.cb_crawler,&
this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.cb_sort)
destroy(this.cb_6)
destroy(this.cb_4)
destroy(this.cb_select_crawler)
destroy(this.cb_delete_crawler)
destroy(this.cb_crawler)
destroy(this.dw_browse)
end on

type cb_sort from commandbutton within tabpage_browse
integer x = 1486
integer y = 40
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)
dw_browse.SetSort(null_str)
dw_browse.Sort( )
end event

type cb_6 from commandbutton within tabpage_browse
integer x = 773
integer y = 40
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;dw_browse.retrieve()
end event

type cb_4 from commandbutton within tabpage_browse
integer x = 1842
integer y = 40
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Verifications"
end type

event clicked;
debugbreak()
//Open(w_create_db)

Integer li_facility_id[]
Long ll_prac_id[]

li_facility_id[1] = 1
ll_prac_id[1] = 1

li_facility_id[2] = 1
ll_prac_id[2] = 2

li_facility_id[3] = 1
ll_prac_id[3] = 3

li_facility_id[4] = 1
ll_prac_id[4] = 4


str_web_crawler lstr_web_crawler
lstr_web_crawler.sl_prac_ids[] = ll_prac_id[ ] 
lstr_web_crawler.si_facility_ids[] = li_facility_id[ ]
OpenWithParm(w_web_crawler_verifications, lstr_web_crawler )
end event

type cb_select_crawler from commandbutton within tabpage_browse
integer x = 1125
integer y = 40
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;dw_browse.TriggerEvent( doubleclicked! )
end event

type cb_delete_crawler from commandbutton within tabpage_browse
integer x = 411
integer y = 36
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//Start Code Change ----08.08.2014 #V14.2 maha - added message and row discard
integer r
integer ans

ans = messagebox("Delete","Are you sure you wish to delete the selected WebCrawler",question!,yesno!,2)

if ans = 2 then return

//delete from  where wc_id = :ii_wc_id;
delete from wc_web_data_comparison  where wc_id = :ii_wc_id;
delete from wc_steps_extracted_data_comparison where wc_id = :ii_wc_id;
delete from wc_multi_entity_link where wc_id = :ii_wc_id;
delete from wc_steps where wc_id = :ii_wc_id;
delete from wc_hdr where wc_id = :ii_wc_id;
r = tab_main.tabpage_browse.dw_browse.getrow()
tab_main.tabpage_browse.dw_browse.rowsdiscard( r, r, primary!)
//End Code Change ----08.08.2014

commit using sqlca;


end event

type cb_crawler from commandbutton within tabpage_browse
integer x = 55
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
string text = "Add"
end type

event clicked;Integer li_nr
Integer li_next_id

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.25.2006 By: LeiWei
//$<reason> Fix a defect.
tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.Reset( )
//---------------------------- APPEON END ----------------------------

tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.reset()
tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.reset()
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.InsertRow( 0 )

li_nr = tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.InsertRow( 0 )
tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.SetItem( 1, "wc_id", ii_wc_id )

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.SetRow( li_nr )

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.ShareData( tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking )

li_nr = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.InsertRow( 0 )
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.SetRow(li_nr)

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.SetFocus( )

tab_main.SelectTab(2)

tab_main.tabpage_detail.tab_detail.SelectTab(1)

SELECT Max( wc_id )
INTO: li_next_id
FROM wc_hdr;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

IF li_next_id < 1 THEN
	li_next_id = 1 
ELSE
	li_next_id ++
END IF

ii_wc_id = li_next_id

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.SetItem( 1, "wc_id", ii_wc_id )

ib_new = True
end event

type dw_browse from u_dw within tabpage_browse
integer x = 37
integer y = 168
integer width = 3360
integer height = 1812
integer taborder = 10
string dataobject = "d_wc_browse"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;Integer li_nr
Integer li_screen_id
Integer li_rc
Integer i
Integer li_row
Long ll_lookup_code
DataWindowChild dwchild
DataWindowChild dwchild2
String ls_lookup_name
String ls_fld_name
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.23.2006 By: LiuHongXin
//$<reason> Fix a defect.
/*
IF row < 1 THEN
	Return
END IF
*/
IF GetRow() < 1 THEN
	Return
ELSEIF IsNull(row) THEN
	row = GetRow()	
END IF
//---------------------------- APPEON END ----------------------------

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.Reset( )
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.Reset( )

ii_wc_id = This.GetItemNumber( row, "wc_id" )
ib_new = False

tab_main.SelectTab(2)

tab_main.tabpage_detail.tab_detail.SelectTab(1)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 04.12.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.Retrieve( ii_wc_id )
tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.SetFocus( )

tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.Retrieve( ii_wc_id )
IF tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.RowCount( ) = 0 THEN 
	li_nr = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.InsertRow( 0 )
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.SetRow(li_nr)
END IF

tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Retrieve( ii_wc_id )
IF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.RowCount( ) = 0 THEN
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.InsertRow( 0 )
END IF
IF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.RowCount( ) > 0  THEN
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow(  1, True )
	ii_step_order = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.GetItemNumber( 1, "step_order" )
END IF

li_screen_id = tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.GetItemNumber( 1, "wc_screen_id_link" )

tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.GetChild( "wc_screen_field_link", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( li_screen_id )

li_rc = dwchild.RowCount( )
FOR i = 1 TO li_rc
	ls_fld_name = dwchild.GetItemString( i, "field_label" )
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.GetChild( "data_object", dwchild2 )
	li_nr = dwchild2.InsertRow( 1000 )
	dwchild2.SetItem( li_nr, "data_object", ls_fld_name )
END FOR

IF li_screen_id > 0 THEN
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.Retrieve( li_screen_id )
END IF

ls_lookup_name = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.GetItemString( 1, "wc_comparison_lookup_table" )
IF Len( ls_lookup_name ) > 0 THEN
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.Retrieve( ls_lookup_name )
END IF

tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.Retrieve( ii_wc_id )
*/

gnv_appeondb.of_startqueue( )

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.Retrieve( ii_wc_id )
tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.Retrieve( ii_wc_id )

gnv_appeondb.of_commitqueue( )

tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Retrieve( ii_wc_id )

tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.SetFocus( )

IF tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.RowCount( ) = 0 THEN 
	li_nr = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.InsertRow( 0 )
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.SetRow(li_nr)
END IF

IF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.RowCount( ) = 0 THEN
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.InsertRow( 0 )
END IF
IF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.RowCount( ) > 0  THEN
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow(  1, True )
	ii_step_order = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.GetItemNumber( 1, "step_order" )
END IF

li_screen_id = tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.GetItemNumber( 1, "wc_screen_id_link" )

tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.GetChild( "wc_screen_field_link", dwchild )
dwchild.SetTransObject( SQLCA )


gnv_appeondb.of_startqueue( )

dwchild.Retrieve( li_screen_id )
IF li_screen_id > 0 THEN
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.Retrieve( li_screen_id )
END IF

ls_lookup_name = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.GetItemString( 1, "wc_comparison_lookup_table" )
IF LenA( ls_lookup_name ) > 0 THEN
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.Retrieve( ls_lookup_name )
END IF
tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.Retrieve( ii_wc_id )

gnv_appeondb.of_commitqueue( )

li_rc = dwchild.RowCount( )

FOR i = 1 TO li_rc
	ls_fld_name = dwchild.GetItemString( i, "field_label" )
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.GetChild( "data_object", dwchild2 )
	li_nr = dwchild2.InsertRow( 1000 )
	dwchild2.SetItem( li_nr, "data_object", ls_fld_name )
END FOR

//---------------------------- APPEON END ----------------------------

li_rc = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.RowCount( )
FOR i = 1 TO li_rc
	ll_lookup_code = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_multi_entity_wc_data.GetItemNumber(  i, "wc_lookup_code" )
	li_row =	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.Find( "lookup_code = " + String( ll_lookup_code ), 1, 10000 )
     tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities.SetItem( li_row, "selected", 1 )
END FOR






end event

event clicked;call super::clicked;integer i

i = this.getclickedrow( )
IF i > 0 THEN
//	This.SelectRow(  0 , False )
//	This.SelectRow( i, True )
	this.setrow(i)
//	ii_wc_id = this.getitemnumber(i,"wc_id")
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;	
	
	This.SelectRow(  0 , False )
	This.SelectRow( currentrow, True )
	this.setrow(currentrow)
	ii_wc_id = this.getitemnumber(currentrow,"wc_id")
end event

type tabpage_detail from userobject within tab_main
integer x = 18
integer y = 112
integer width = 3438
integer height = 2016
long backcolor = 33551856
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Form!"
long picturemaskcolor = 536870912
tab_detail tab_detail
end type

on tabpage_detail.create
this.tab_detail=create tab_detail
this.Control[]={this.tab_detail}
end on

on tabpage_detail.destroy
destroy(this.tab_detail)
end on

type tab_detail from tab within tabpage_detail
integer x = 64
integer y = 132
integer width = 3040
integer height = 1840
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 2
tabpage_header tabpage_header
tabpage_data_link tabpage_data_link
tabpage_steps tabpage_steps
end type

on tab_detail.create
this.tabpage_header=create tabpage_header
this.tabpage_data_link=create tabpage_data_link
this.tabpage_steps=create tabpage_steps
this.Control[]={this.tabpage_header,&
this.tabpage_data_link,&
this.tabpage_steps}
end on

on tab_detail.destroy
destroy(this.tabpage_header)
destroy(this.tabpage_data_link)
destroy(this.tabpage_steps)
end on

event selectionchanged;long ll_row, ll_screen_id
datawindowchild ldwc_field

choose case This.SelectedTab
	case 1 //basic info
		
	case 2 
		
	case 3 //web crawler
		//tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities
		
		//------------------- APPEON BEGIN -------------------
		//$<add> Stephen 06.29.2012
		//$<reason>  V12.2 WebCrawler extract data
		if gi_prod_setting=0 then
			ll_row = tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.getrow()
			if ll_row < 1 then return
			ll_screen_id = tab_main.tabpage_detail.tab_detail.tabpage_header.dw_header.getitemnumber(ll_row, "wc_screen_id_link")
			if isnull(ll_screen_id) then return
			tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.getchild("field_id",ldwc_field)
			ldwc_field.settransobject(sqlca)
			ldwc_field.retrieve(1, ll_screen_id)
		end if
		//------------------- APPEON END -------------------
end choose

end event

type tabpage_header from userobject within tab_detail
integer x = 18
integer y = 112
integer width = 3003
integer height = 1712
long backcolor = 33551856
string text = "Basic Information"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Information!"
long picturemaskcolor = 536870912
cb_cc_info cb_cc_info
cb_test_url cb_test_url
dw_header dw_header
end type

on tabpage_header.create
this.cb_cc_info=create cb_cc_info
this.cb_test_url=create cb_test_url
this.dw_header=create dw_header
this.Control[]={this.cb_cc_info,&
this.cb_test_url,&
this.dw_header}
end on

on tabpage_header.destroy
destroy(this.cb_cc_info)
destroy(this.cb_test_url)
destroy(this.dw_header)
end on

type cb_cc_info from commandbutton within tabpage_header
integer x = 1193
integer y = 1488
integer width = 311
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "CC Info"
end type

type cb_test_url from commandbutton within tabpage_header
integer x = 1545
integer y = 1488
integer width = 311
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test URL"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 04.25.2006 By: LeiWei
//$<reason>  GetContextService is currently unsupported. 
//$<modification> Replace GetContextService with ShellExecuteA to provide the
//$<modification> same functionality.
/*
Inet linet_base
GetContextService("Internet", linet_base)

linet_base.HyperlinkToURL( dw_header.GetItemString( 1, "wc_web_address" ))
*/

String ls_url,ls_null
setnull(ls_null)
ls_url = dw_header.GetItemString( 1, "wc_web_address" )
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser

//---------------------------- APPEON END ----------------------------

end event

type dw_header from u_dw within tabpage_header
integer x = 37
integer y = 48
integer width = 2930
integer height = 1376
integer taborder = 10
string dataobject = "d_wc_header"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;of_setUpdateAble( True )
This.SetTransObject( SQLCA )


end event

event itemchanged;call super::itemchanged;
Integer li_screen_id
DataWindowChild dwchild
DataWindowChild dwchild2
Integer li_null
Integer li_nr
Integer li_rc
Integer i
String ls_fld_name

IF This.GetColumnName() = "wc_screen_id_link" THEN
	
	li_screen_id = Integer( Data )
	IF li_screen_id > 0 THEN
		tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.SetItem( 1, "wc_screen_field_link", li_null )
		tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.GetChild( "wc_screen_field_link", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( li_screen_id )
	END IF
	
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.GetChild( "wc_screen_id_link", dwchild )
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.GetChild( "data_object", dwchild2 )
	
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.SetItem( 1, "content_or_value", "" )
	
	dwchild2.Reset()
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "First Name" )	
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Middle Name" )	
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Last Name" )	
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Social Security Number" )	
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Data of Birth" )
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Professional Suffix" )	
	li_nr = dwchild2.InsertRow(  0 )	
	dwchild2.SetItem( li_nr, "data_object", "Verification Response" )	
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Account Number" )
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "User Name" )
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Password" )
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Verif Reference 1" )
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Verif Reference 2" )
	li_nr = dwchild2.InsertRow(  0 )
	dwchild2.SetItem( li_nr, "data_object", "Verif Reference 3" )
	
	
//	li_rc = dwchild.RowCount( )
//	FOR i = 1 TO li_rc
//		ls_fld_name = dwchild.GetItemString( i, "field_label" )
//		li_nr = dwchild2.InsertRow( 1000 )
//		dwchild2.SetItem( li_nr, "data_object", ls_fld_name )	
//	END FOR
		
END IF
end event

type tabpage_data_link from userobject within tab_detail
integer x = 18
integer y = 112
integer width = 3003
integer height = 1712
long backcolor = 33551856
string text = "Data Linking"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Join!"
long picturemaskcolor = 536870912
cb_sa cb_sa
dw_multi_entity_wc_data dw_multi_entity_wc_data
dw_psv_entities dw_psv_entities
dw_data_linking dw_data_linking
end type

on tabpage_data_link.create
this.cb_sa=create cb_sa
this.dw_multi_entity_wc_data=create dw_multi_entity_wc_data
this.dw_psv_entities=create dw_psv_entities
this.dw_data_linking=create dw_data_linking
this.Control[]={this.cb_sa,&
this.dw_multi_entity_wc_data,&
this.dw_psv_entities,&
this.dw_data_linking}
end on

on tabpage_data_link.destroy
destroy(this.cb_sa)
destroy(this.dw_multi_entity_wc_data)
destroy(this.dw_psv_entities)
destroy(this.dw_data_linking)
end on

type cb_sa from commandbutton within tabpage_data_link
integer x = 123
integer y = 1544
integer width = 279
integer height = 68
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;//Start Code Change ---- 02.05.2007 #V7 maha new
long ic
long i
integer val
string ls_title
datawindow dw_ent

dw_ent = tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_psv_entities
ic = dw_ent.rowcount( )

if this.text = "Select All" then
	ls_title = "Deselect All"
	val = 1
else
	ls_title = "Select All"
	val = 0
end if


for i = 1 to ic
	dw_ent.setitem(i,"selected",val)
next

this.text = ls_title
end event

type dw_multi_entity_wc_data from u_dw within tabpage_data_link
boolean visible = false
integer x = 2107
integer y = 912
integer width = 667
integer height = 288
integer taborder = 30
string dataobject = "d_wc_lookup_data_multi_select_wc_data"
boolean border = false
end type

type dw_psv_entities from u_dw within tabpage_data_link
integer x = 128
integer y = 792
integer width = 2793
integer height = 728
integer taborder = 20
string dataobject = "d_wc_lookup_data_multi_select"
boolean border = false
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
end event

event pfc_preupdate;call super::pfc_preupdate;IF ib_new THEN
	This.SetItem( This.GetRow(), "wc_id", ii_wc_id )
	Return 1
END IF

Return 1
end event

type dw_data_linking from u_dw within tabpage_data_link
integer x = 32
integer y = 36
integer width = 2935
integer height = 1604
integer taborder = 10
string dataobject = "d_wc_data_link"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateable( True )
This.SetTransObject( SQLCA )


end event

event itemchanged;call super::itemchanged;Integer li_ans
Integer li_rc
Integer i
Integer li_nr
String ls_lookup_name
DataWindowChild dwchild
DataWindowChild dwchild2
String ls_fld_name

	
IF This.GetColumnName() = "wc_data_link_type"  THEN
	IF data = "0"  THEN
		li_ans = MessageBox( "Remove Data",  "Your PSV entity links below will be lost.  Continue? ", Question!, YesNo!, 1 )
		IF li_ans = 1 THEN
			This.SetItem( row, "wc_comparison_lookup_table", "" )
			li_rc = dw_multi_entity_wc_data.RowCount( )
			FOR i = 1 TO li_rc
				dw_multi_entity_wc_data.DeleteRow( 0 )
			END FOR
			dw_psv_entities.Reset()
		ELSE
			Return 1
		END IF
	ELSEIF data = "1" THEN
		This.SetItem( 1, "fixed_value", "" )
	END IF
ELSEIF This.GetColumnName( ) = "wc_comparison_lookup_table" THEN
	IF dw_multi_entity_wc_data.RowCount( ) > 0 THEN
		li_ans = MessageBox( "Switch Entity Lookup",  "Your PSV entity links below will be lost.  Continue? ", Question!, YesNo!, 1 )
		IF li_ans = 1 THEN
			li_rc = dw_multi_entity_wc_data.RowCount( )
			FOR i = 1 TO li_rc
				dw_multi_entity_wc_data.DeleteRow( 0 )
			END FOR
			dw_psv_entities.Reset()			
			ls_lookup_name = data
		     dw_psv_entities.Retrieve( ls_lookup_name )
		ELSE
			Return 1
		END IF
	ELSE
		ls_lookup_name = data
		dw_psv_entities.Retrieve( ls_lookup_name )
	END IF		
END IF
end event

type tabpage_steps from userobject within tab_detail
integer x = 18
integer y = 112
integer width = 3003
integer height = 1712
long backcolor = 33551856
string text = "Web Crawler Steps"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "SetDefaultClass!"
long picturemaskcolor = 536870912
st_1 st_1
cb_copy cb_copy
cb_5 cb_5
cb_1 cb_1
cb_add_step cb_add_step
cb_delete_step cb_delete_step
dw_steps_browse dw_steps_browse
dw_extract_data dw_extract_data
cb_syn_add cb_syn_add
cb_syn_delete cb_syn_delete
dw_steps_detail dw_steps_detail
end type

on tabpage_steps.create
this.st_1=create st_1
this.cb_copy=create cb_copy
this.cb_5=create cb_5
this.cb_1=create cb_1
this.cb_add_step=create cb_add_step
this.cb_delete_step=create cb_delete_step
this.dw_steps_browse=create dw_steps_browse
this.dw_extract_data=create dw_extract_data
this.cb_syn_add=create cb_syn_add
this.cb_syn_delete=create cb_syn_delete
this.dw_steps_detail=create dw_steps_detail
this.Control[]={this.st_1,&
this.cb_copy,&
this.cb_5,&
this.cb_1,&
this.cb_add_step,&
this.cb_delete_step,&
this.dw_steps_browse,&
this.dw_extract_data,&
this.cb_syn_add,&
this.cb_syn_delete,&
this.dw_steps_detail}
end on

on tabpage_steps.destroy
destroy(this.st_1)
destroy(this.cb_copy)
destroy(this.cb_5)
destroy(this.cb_1)
destroy(this.cb_add_step)
destroy(this.cb_delete_step)
destroy(this.dw_steps_browse)
destroy(this.dw_extract_data)
destroy(this.cb_syn_add)
destroy(this.cb_syn_delete)
destroy(this.dw_steps_detail)
end on

type st_1 from statictext within tabpage_steps
integer x = 1646
integer y = 56
integer width = 539
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Note: Wildcard is an *"
boolean focusrectangle = false
end type

type cb_copy from commandbutton within tabpage_steps
integer x = 1138
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
string text = "Copy Steps"
end type

event clicked;openwithparm(w_wc_copy_steps,ii_wc_id)
tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.retrieve(ii_wc_id )
end event

type cb_5 from commandbutton within tabpage_steps
integer x = 2487
integer y = 812
integer width = 265
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Data Links"
end type

event clicked;debugbreak()
str_web_crawler lst_web_crawler

lst_web_crawler.si_wc_id = ii_wc_id
lst_web_crawler.si_step_order = ii_step_order

IF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.GetItemString( 1, "content_or_value" ) = "Professional Suffix" THEN
	lst_web_crawler.ss_lookup_name = "Professional Suffix"
ELSEIF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.GetItemString( 1, "content_or_value" ) = "Verification Response" THEN
	lst_web_crawler.ss_lookup_name = "Verification Response"
ELSE
	lst_web_crawler.ss_lookup_name = ""
END IF

OpenWithParm( w_web_data_mapping, lst_web_crawler)

IF Integer( Message.StringParm ) > 0 THEN
	dw_steps_detail.SetItem( 1, "web_data_comparison_yes_no", 1 )
ELSE
	dw_steps_detail.SetItem( 1, "web_data_comparison_yes_no", 0 )
END IF
end event

type cb_1 from commandbutton within tabpage_steps
integer x = 768
integer y = 28
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test Macro"
end type

event clicked;
nvo_web_crawler_engine lnvo_web_crawler

//web_crawler id, doc_id, facility_id, prac_id
lnvo_web_crawler.of_crawl_new( ii_wc_id,   1, "x-x-x-x", True, 1, 1 )


end event

type cb_add_step from commandbutton within tabpage_steps
integer x = 32
integer y = 28
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Integer li_nr
Integer li_next_step
Integer li_step_order
Integer li_found

cb_save.TriggerEvent( Clicked! )

dw_steps_detail.AcceptText()

//IF dw_steps_browse.RowCount( ) > 0 THEN 
//	li_step_order = dw_steps_detail.GetItemNumber( 1, "step_order" )
//	dw_steps_browse.SetFilter( "step_order = " + String( li_step_order ) )
//	dw_steps_browse.Filter( )
//	IF dw_steps_browse.RowCount( ) > 0 AND ib_new_step THEN
//		MessageBox( "Duplicate Step", "Change Step Order. It is already in use." )
//		dw_steps_browse.SetFilter( "" )
//		dw_steps_browse.Filter( )
//		Return	
//	END IF
//
//	dw_steps_browse.SetFilter( "" )
//	dw_steps_browse.Filter( )
//
//	dw_steps_detail.Update( )
//	dw_steps_browse.Retrieve( ii_wc_id )
//END IF

dw_steps_detail.Reset( )
li_nr = dw_steps_detail.InsertRow(0)
dw_steps_detail.SetItem( li_nr, "wc_id", ii_wc_id )

dw_steps_browse.Sort( )
IF dw_steps_browse.RowCount( ) > 0 THEN
	li_next_step = dw_steps_browse.GetItemNumber( dw_steps_browse.RowCount( ), "step_order" )
ELSE
	li_next_step = 0
END IF

li_next_step = li_next_step + 10
ii_step_order = li_next_step
dw_steps_detail.SetItem( li_nr, "step_order", li_next_step )
dw_steps_detail.SetFocus( )
dw_steps_browse.SelectRow( 0, False )
ib_new_step = True
end event

type cb_delete_step from commandbutton within tabpage_steps
integer x = 398
integer y = 28
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;Integer i
Integer li_rc
Integer li_ans
Integer li_step_order
Integer li_found

li_ans = MessageBox( "Delete", "Are you sure you want to delete this Step?", Question!, YesNo!, 1 )

IF li_ans = 1 THEN
	li_step_order = dw_steps_detail.GetItemNumber( 1, "step_order" )
	dw_steps_detail.DeleteRow( 0 )
	li_found = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Find( "step_order = " + String( li_step_order ) , 1, 10000)
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.DeleteRow( li_found )
	IF tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.RowCount( ) > 0 THEN
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow( 0 , False )
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SetRow( 1 )		
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.SelectRow( 1, True )
	END IF
		
	li_rc = tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.RowCount( )
	FOR i = 1 to li_rc
		tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.DeleteRow( 0 )
	END FOR

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-04
	//$<modify> 04.12.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	/*
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.Update( )
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Update( )
	*/
	gnv_appeondb.of_startqueue( )
	
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.Update( )
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_browse.Update( )
	
	gnv_appeondb.of_commitqueue( )
	
	//---------------------------- APPEON END ----------------------------
END IF


end event

type dw_steps_browse from u_dw within tabpage_steps
integer x = 32
integer y = 144
integer width = 1079
integer height = 1516
integer taborder = 30
string dataobject = "d_wc_steps_browse"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
end event

event pfc_preupdate;call super::pfc_preupdate;IF ib_new THEN
	This.SetItem( This.GetRow(), "wc_id", ii_wc_id )
	Return 1
END IF
Return 1
end event

event rowfocuschanged;call super::rowfocuschanged;DataWindowChild dwchild
DataWindowChild dwchild2
Integer li_nr
Integer li_rc
Integer i
String ls_fld_name

ib_new_step = False

IF currentrow > 0 THEN 
	ii_step_order = This.GetItemNumber( currentrow, "step_order" )
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.Reset()
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<modify> 04.12.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	/*
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.Retrieve(  ii_wc_id, ii_step_order)
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.Retrieve(  ii_wc_id, ii_step_order)
	*/
	gnv_appeondb.of_startqueue( )
	
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.Retrieve(  ii_wc_id, ii_step_order)
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_extract_data.Retrieve(  ii_wc_id, ii_step_order)
	
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
	
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.SetFocus( )
	
	tab_main.tabpage_detail.tab_detail.tabpage_data_link.dw_data_linking.GetChild( "wc_screen_field_link", dwchild )
	tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.GetChild( "content_or_value", dwchild2 )
	
	//tab_main.tabpage_detail.tab_detail.tabpage_steps.dw_steps_detail.SetItem( 1, "data_object", "" )
	//Start Code Change ---- 02.22.2007 #V7 maha - removed to use original dw child
//	dwchild2.Reset()
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "First Name" )	
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Middle Name" )	
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Last Name" )	
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Social Security Number" )	
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Data of Birth" )
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Professional Suffix" )
//	li_nr = dwchild2.InsertRow(  0 )	
//	dwchild2.SetItem( li_nr, "data_object", "Verification Response" )
//	li_nr = dwchild2.InsertRow(  0 )		
//	dwchild2.SetItem( li_nr, "data_object", "Account Number" )
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "User Name" )
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Password" )
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Verif Reference 1" )
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Verif Reference 2" )
//	li_nr = dwchild2.InsertRow(  0 )
//	dwchild2.SetItem( li_nr, "data_object", "Verif Reference 3" )
	
//	li_rc = dwchild.RowCount( )
//	FOR i = 1 TO li_rc
//		ls_fld_name = dwchild.GetItemString( i, "field_label" )
//		li_nr = dwchild2.InsertRow( 1000 )
//		dwchild2.SetItem( li_nr, "data_object", ls_fld_name )	
//	END FOR
			
	
END IF
end event

event clicked;call super::clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
END IF
end event

type dw_extract_data from u_dw within tabpage_steps
boolean visible = false
integer x = 2711
integer y = 1492
integer width = 215
integer height = 168
integer taborder = 30
string dataobject = "d_wc_extracted_data_verif_rsp_code_comp"
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
end event

event pfc_preupdate;call super::pfc_preupdate;IF ib_new THEN
	This.SetItem( This.GetRow(), "wc_id", ii_wc_id )
	Return 1
END IF
Return 1
end event

type cb_syn_add from commandbutton within tabpage_steps
boolean visible = false
integer x = 2743
integer y = 1536
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Integer li_nr

li_nr = dw_extract_data.InsertRow( 0 )

dw_extract_data.SetItem( li_nr, "wc_id", ii_wc_id )
dw_extract_data.SetItem( li_nr, "step_order", ii_step_order )

dw_extract_data.SetFocus( )


end event

type cb_syn_delete from commandbutton within tabpage_steps
boolean visible = false
integer x = 2738
integer y = 1544
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type dw_steps_detail from u_dw within tabpage_steps
integer x = 1138
integer y = 140
integer width = 1833
integer height = 1524
integer taborder = 20
string dataobject = "d_wc_steps_detail"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
end event

event pfc_preupdate;call super::pfc_preupdate;IF ib_new THEN
	This.SetItem( This.GetRow(), "wc_id", ii_wc_id )
	Return 1
END IF
end event

event itemchanged;call super::itemchanged;//Extracted Data and Verification Response Code Synonym Table

//Start Code Change ---- 02.07.2007 #V7 maha  chaned to case from if added description code
choose case This.GetColumnName()
	case "step_action"
		IF data = "Extract Single Piece Of Data" THEN
			dw_extract_data.Visible = True
			cb_syn_add.Visible = True
			cb_syn_delete.Visible = True
		ELSE
			dw_extract_data.Visible = False
			cb_syn_add.Visible = False
			cb_syn_delete.Visible = False		
		END IF
	case "description", "step_order"
		ib_retr_steps = true
	case "field_id"
		//this.setitem(row, "object_name",data) //add by stephen 06.29.2012 -V12.2 WebCrawler extract data
		this.setitem(row, "content_or_value",data) //alfee 09.12.2012
END choose
//End Code Change---02.07.2007

end event

