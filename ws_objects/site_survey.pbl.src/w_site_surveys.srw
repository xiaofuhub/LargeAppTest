$PBExportHeader$w_site_surveys.srw
forward
global type w_site_surveys from w_response
end type
type tab_1 from tab within w_site_surveys
end type
type tabpage_search from userobject within tab_1
end type
type st_1 from statictext within tabpage_search
end type
type st_3 from statictext within tabpage_search
end type
type st_4 from statictext within tabpage_search
end type
type sle_name from singlelineedit within tabpage_search
end type
type sle_city from singlelineedit within tabpage_search
end type
type sle_state from singlelineedit within tabpage_search
end type
type cb_find from commandbutton within tabpage_search
end type
type dw_address_search from u_dw within tabpage_search
end type
type cb_select from commandbutton within tabpage_search
end type
type tabpage_search from userobject within tab_1
st_1 st_1
st_3 st_3
st_4 st_4
sle_name sle_name
sle_city sle_city
sle_state sle_state
cb_find cb_find
dw_address_search dw_address_search
cb_select cb_select
end type
type tabpage_survey from userobject within tab_1
end type
type uo_survey from pfc_cst_u_site_survey_collect_data within tabpage_survey
end type
type tabpage_survey from userobject within tab_1
uo_survey uo_survey
end type
type tab_1 from tab within w_site_surveys
tabpage_search tabpage_search
tabpage_survey tabpage_survey
end type
end forward

global type w_site_surveys from w_response
integer x = 5
integer y = 288
integer width = 3643
integer height = 2116
string title = "Site Surveys"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 33551856
event pfc_cst_print_survey ( )
tab_1 tab_1
end type
global w_site_surveys w_site_surveys

event pfc_cst_print_survey;tab_1.tabpage_survey.uo_survey.Event pfc_cst_print_survey()
end event

on w_site_surveys.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_site_surveys.destroy
call super::destroy
destroy(this.tab_1)
end on

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-15 By: Allen
//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
/*
IF tab_1.SelectedTab = 1 THEN
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
ELSE
	w_mdi.ChangeMenu(m_pfe_cst_site_survey)
	w_mdi.SetToolbarPos ( 2, 1, 200, False )	
END IF
*/
IF tab_1.SelectedTab = 1 THEN
	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
ELSE
	If w_mdi.menuname <> 'm_pfe_cst_site_survey' Then w_mdi.ChangeMenu( m_pfe_cst_site_survey )
END IF
w_mdi.SetToolbarPos ( 2, 1, 200, False )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------
end event

event close;call super::close;w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
end event

type tab_1 from tab within w_site_surveys
integer y = 8
integer width = 3506
integer height = 1948
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_search tabpage_search
tabpage_survey tabpage_survey
end type

on tab_1.create
this.tabpage_search=create tabpage_search
this.tabpage_survey=create tabpage_survey
this.Control[]={this.tabpage_search,&
this.tabpage_survey}
end on

on tab_1.destroy
destroy(this.tabpage_search)
destroy(this.tabpage_survey)
end on

event selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-15 By: Allen
//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
/*
IF newindex = 2 THEN
	w_mdi.ChangeMenu(m_pfe_cst_site_survey)
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
ELSE
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.SetToolbarPos ( 2, 1, 200, False )	
END IF
*/
IF newindex = 2 THEN
	w_mdi.ChangeMenu(m_pfe_cst_site_survey)
	If w_mdi.menuname <> 'm_pfe_cst_site_survey' Then w_mdi.ChangeMenu( m_pfe_cst_site_survey )
ELSE
	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
END IF
w_mdi.SetToolbarPos ( 2, 1, 200, False )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------
end event

type tabpage_search from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3470
integer height = 1820
long backcolor = 33551856
string text = "Search"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Search!"
long picturemaskcolor = 553648127
st_1 st_1
st_3 st_3
st_4 st_4
sle_name sle_name
sle_city sle_city
sle_state sle_state
cb_find cb_find
dw_address_search dw_address_search
cb_select cb_select
end type

on tabpage_search.create
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.sle_name=create sle_name
this.sle_city=create sle_city
this.sle_state=create sle_state
this.cb_find=create cb_find
this.dw_address_search=create dw_address_search
this.cb_select=create cb_select
this.Control[]={this.st_1,&
this.st_3,&
this.st_4,&
this.sle_name,&
this.sle_city,&
this.sle_state,&
this.cb_find,&
this.dw_address_search,&
this.cb_select}
end on

on tabpage_search.destroy
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.sle_name)
destroy(this.sle_city)
destroy(this.sle_state)
destroy(this.cb_find)
destroy(this.dw_address_search)
destroy(this.cb_select)
end on

type st_1 from statictext within tabpage_search
integer x = 23
integer y = 56
integer width = 567
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Practice Location Name"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_search
integer x = 1266
integer y = 56
integer width = 187
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "City"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_search
integer x = 1957
integer y = 60
integer width = 187
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "State"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within tabpage_search
integer x = 32
integer y = 124
integer width = 1179
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_city from singlelineedit within tabpage_search
integer x = 1262
integer y = 124
integer width = 645
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_state from singlelineedit within tabpage_search
integer x = 1952
integer y = 120
integer width = 261
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_find from commandbutton within tabpage_search
integer x = 2249
integer y = 112
integer width = 201
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
end type

event clicked;integer rows

IF LenA(sle_name.Text + sle_city.Text + sle_state.Text ) = 0 THEN
	MessageBox("Search","At least one of the search fields need to be partially filled.")
	Return
END IF

dw_address_search.settransobject(sqlca)
rows = dw_address_search.Retrieve( sle_name.Text + "%", sle_city.Text + "%", sle_state.Text + "%" )

if rows < 1 then
	Messagebox("No match for search criteria","Your search returned no results.~rRedefine search parameters or check practice locations in Group Practices to be sure your address is set up.")
end if
end event

type dw_address_search from u_dw within tabpage_search
integer x = 27
integer y = 244
integer width = 3387
integer height = 1492
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_group_pract_search_site"
borderstyle borderstyle = stylebox!
end type

event constructor;dw_address_search.of_SetTransObject( SQLCA )
end event

event clicked;call super::clicked;

IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.ScrollToRow( row )
	This.SetRow( row )
END IF
end event

event retrieveend;call super::retrieveend;
IF rowcount > 0 THEN
	This.SelectRow( 1, True )
	This.ScrollToRow( 1 )
	This.SetRow( 1 )
	cb_select.Enabled = True
ELSE
	cb_select.Enabled = False
END IF
end event

event doubleclicked;cb_select.TriggerEvent( Clicked! )
end event

type cb_select from commandbutton within tabpage_search
integer x = 2478
integer y = 112
integer width = 233
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Select"
end type

event clicked;Integer li_ans
Integer li_cnt
Long ll_address_id
String ls_full_address

ll_address_id = dw_address_search.GetItemNumber( dw_address_search.GetRow(), "rec_id" )
ls_full_address = dw_address_search.GetItemString( dw_address_search.GetRow(), "full_address" )

SELECT Count( rec_id )  
INTO :li_cnt  
FROM pd_review_hdr  
WHERE pd_review_hdr.address_id = :ll_address_id   ;

IF li_cnt = 0 THEN
	li_ans = MessageBox("Not Found", "There was no survey found for the selected address.  ~n~r Would you like to create a survey for this address?", Question!, YesNo!, 1 )
	IF li_ans = 2 THEN
		Return
	END IF
	tab_1.tabpage_survey.Enabled = True	
	tab_1.SelectTab( 2 )
	tab_1.tabpage_survey.uo_survey.of_new_record( ll_address_id )
ELSE
	tab_1.SelectTab( 2 )
	tab_1.tabpage_survey.Enabled = True	
	tab_1.tabpage_survey.uo_survey.of_retrieve_browse( ll_address_id )		
END IF

w_site_surveys.Title = "Site Survey    ( " + ls_full_address + " )"

end event

type tabpage_survey from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3470
integer height = 1820
boolean enabled = false
long backcolor = 33551856
string text = "Survey"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Library5!"
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
integer x = 32
integer y = 40
integer width = 3515
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_survey.destroy
call pfc_cst_u_site_survey_collect_data::destroy
end on

