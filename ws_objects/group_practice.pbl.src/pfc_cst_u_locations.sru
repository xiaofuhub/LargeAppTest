$PBExportHeader$pfc_cst_u_locations.sru
forward
global type pfc_cst_u_locations from userobject
end type
type dw_imp_surv from datawindow within pfc_cst_u_locations
end type
type tab_2 from tab within pfc_cst_u_locations
end type
type tabpage_browse from userobject within tab_2
end type
type cb_search from picturebutton within tabpage_browse
end type
type cb_1 from commandbutton within tabpage_browse
end type
type cb_sort from commandbutton within tabpage_browse
end type
type rb_l_p from radiobutton within tabpage_browse
end type
type rb_loc from radiobutton within tabpage_browse
end type
type cbx_anp from checkbox within tabpage_browse
end type
type dw_search from u_dw within tabpage_browse
end type
type dw_browse from u_dw within tabpage_browse
end type
type gb_search from groupbox within tabpage_browse
end type
type cb_clear from commandbutton within tabpage_browse
end type
type st_none from statictext within tabpage_browse
end type
type cbx_valid from checkbox within tabpage_browse
end type
type tabpage_browse from userobject within tab_2
cb_search cb_search
cb_1 cb_1
cb_sort cb_sort
rb_l_p rb_l_p
rb_loc rb_loc
cbx_anp cbx_anp
dw_search dw_search
dw_browse dw_browse
gb_search gb_search
cb_clear cb_clear
st_none st_none
cbx_valid cbx_valid
end type
type tabpage_detail from userobject within tab_2
end type
type st_1 from statictext within tabpage_detail
end type
type dw_detail from u_dw within tabpage_detail
end type
type tabpage_detail from userobject within tab_2
st_1 st_1
dw_detail dw_detail
end type
type tabpage_data from userobject within tab_2
end type
type uo_data from pfc_cst_u_group_data within tabpage_data
end type
type tabpage_data from userobject within tab_2
uo_data uo_data
end type
type tabpage_docs from userobject within tab_2
end type
type dw_docs from u_dw within tabpage_docs
end type
type tabpage_docs from userobject within tab_2
dw_docs dw_docs
end type
type tabpage_ass_prac from userobject within tab_2
end type
type cb_unlink from commandbutton within tabpage_ass_prac
end type
type st_3 from statictext within tabpage_ass_prac
end type
type cb_link_prac from commandbutton within tabpage_ass_prac
end type
type dw_prac from u_dw within tabpage_ass_prac
end type
type tabpage_ass_prac from userobject within tab_2
cb_unlink cb_unlink
st_3 st_3
cb_link_prac cb_link_prac
dw_prac dw_prac
end type
type tabpage_survey from userobject within tab_2
end type
type uo_survey from pfc_cst_u_site_survey_collect_data within tabpage_survey
end type
type cb_print from commandbutton within tabpage_survey
end type
type cb_import from commandbutton within tabpage_survey
end type
type cb_export from commandbutton within tabpage_survey
end type
type tabpage_survey from userobject within tab_2
uo_survey uo_survey
cb_print cb_print
cb_import cb_import
cb_export cb_export
end type
type tab_2 from tab within pfc_cst_u_locations
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_data tabpage_data
tabpage_docs tabpage_docs
tabpage_ass_prac tabpage_ass_prac
tabpage_survey tabpage_survey
end type
end forward

global type pfc_cst_u_locations from userobject
integer width = 4480
integer height = 2420
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_imp_surv dw_imp_surv
tab_2 tab_2
end type
global pfc_cst_u_locations pfc_cst_u_locations

type variables
n_ds ids_datastore

String is_open_for
String is_original_sql

Integer il_facility_id
long il_group_id
long ii_mgp_id

String is_sql

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define variables to be used in subsequent script.
Boolean ib_tabpage_data_created = False
Boolean ib_tabpage_detail_created = False
Boolean ib_tabpage_ass_prac_created = False
Boolean ib_tabpage_survey_created = False
Boolean ib_delete = False
//---------------------------- APPEON END ----------------------------

long	il_CurPractice,il_CurGroup			//Added by Scofield on 2008-01-04
n_cst_string inv_string //alfee 01.28.2010
end variables

forward prototypes
public function integer of_location_search ()
public function integer of_search_location ()
public function integer of_set_buttons (integer ai_idx)
public function integer of_change_row ()
public function string of_validate_crit (string ls_field, string ls_value)
public function integer of_add_document ()
public function integer of_delete_document (integer ai_row)
public function integer of_copy_location ()
end prototypes

public function integer of_location_search ();//Start Code Change ----08.09.2010 #V10 maha - added for modification of the search functionality
//Note this is not used.  The filters must always be strings and cannot search on the lookup_code values from the lookup tables.
//This is to keep a consistant appearance when using multiple filters



//integer i
//integer li_rc
//integer c
//integer res
//string stype
//string scrit
//string ls_where = ""
//string ls_criteria[]
//string ls_type[]
//boolean lb_loc_only = true
//debugbreak()
//IF tab_2.tabpage_browse.rb_l_p.checked = true then lb_loc_only = false//practitoners and locations	
//
//li_rc =  tab_2.tabpage_browse.dw_search.rowcount()
//
//FOR i = 1 TO li_rc
//	stype =  tab_2.tabpage_browse.dw_search.GetItemString( i, "search_type" )
//	
//	 if lb_loc_only = true then
//		if stype = "Specialty" or stype = "Language" or stype = "Provider_type" then
//			Messagebox("Search Error","You cannot use " + stype + " as a search criteria for a Locations Only search.")
//			return 0
//		end if
//	end if
//	
//	scrit =  tab_2.tabpage_browse.dw_search.GetItemString( i, "criteria" )
//	IF IsNull( stype ) or isnull(scrit) THEN
//		CONTINUE
//	else 
//		c++
//		ls_type[c ] = stype
//		ls_criteria[c ] = scrit
//	end if
//	
//NEXT
//
//SetRedraw(FALSE)
//if tab_2.tabpage_browse.dw_search.rowcount() = 0 then  tab_2.tabpage_browse.dw_search.retrieve()
//
//For i = 1 to c
//	choose case ls_type[i ]
//		case "gp_state", "Country", "gp_county"
//			ls_where = ls_where +  ls_type[i] + " = " + ls_criteria[i] + " AND "	
//		//case "County"
//		//	ls_where = ls_where +  ls_type[i] + " = '" + ls_criteria[i] + "' AND "	
//		case else
//		//	ls_where = ls_where + "Upper(" + ls_type[i] + ") like '" + Upper( ls_criteria[i]) + "%' AND "	
//			ls_where = ls_where + "pos(Upper(" + ls_type[i] + "), '" + Upper( ls_criteria[i]) + "' ,1) > 0 AND "	
//	end choose
//next
//
//ls_where = mid(  ls_where, 1, Len( ls_where ) - 5 )
//Messagebox("Setfilter", ls_where )
//IF  lb_loc_only = false and tab_2.tabpage_browse.cbx_anp.checked THEN
//	IF trim(ls_where) = "" THEN
//		ls_where = "  accept_new_patient  = 581"
//	ELSE
//		ls_where = ls_where + " AND  accept_new_patient  = 581"
//	END IF
//END IF
//
//
//
////tab_2.tabpage_browse.dw_browse.setfilter("")
////tab_2.tabpage_browse.dw_browse.filter()
//res =  tab_2.tabpage_browse.dw_browse.setfilter(ls_where)
//if res < 0 then 
//	SetRedraw(TRUE)
//	Messagebox("Setfilter","Error in w_group_practice cb_search::clicked:~r " + ls_where )
//	return 0
//end if
//
// tab_2.tabpage_browse.dw_browse.filter()
//
//SetRedraw(TRUE) 


return 1
end function

public function integer of_search_location ();//Start Code Change ----08.09.2010 #V10 maha - added for modification of the search functionality

integer i
integer li_rc
integer c
integer res
string stype
string scrit
string ls_where = ""
string ls_criteria[]
string ls_type[]
string ls_ret  //maha 01.16.2014
boolean lb_loc_only = true

tab_2.tabpage_browse.st_none.visible = false  //Start Code Change ----01.16.2014 #V14 maha
IF tab_2.tabpage_browse.rb_l_p.checked = true then lb_loc_only = false//practitioners and locations	

li_rc =  tab_2.tabpage_browse.dw_search.rowcount()

FOR i = 1 TO li_rc
	stype =  tab_2.tabpage_browse.dw_search.GetItemString( i, "search_type" )
	
	 if lb_loc_only = true then
		if stype = "Specialty" or stype = "Language" or stype = "Provider_type" then
			Messagebox("Search Error","You cannot use " + stype + " as a search criteria for a Locations Only search.")
			return 0
		end if
	end if
	
	scrit =  tab_2.tabpage_browse.dw_search.GetItemString( i, "criteria" )
	
	if tab_2.tabpage_browse.cbx_valid.checked then
		ls_ret = of_validate_crit(stype, scrit)
		choose case ls_ret
			case "OK"
				//continue
			case "NUM"
				messagebox("Search Validation", "The criteria for " + stype + " must be a numeric value.")
				return -1
			case "NPI"
				messagebox("Search Validation", "The criteria for " + stype + " must be a 10 digits.")
				return -1
			case "TAX"
				messagebox("Search Validation", "The criteria for " + stype + " must be a 9 digits.")
				return -1
		end choose
	end if
	
	//Start Code Change ----11.18.2013 #V14 maha
	if stype = "active_status" then
		choose case scrit
			case "Inactive"
				scrit = '0'
			case else
				scrit = '1'
		end choose
	end if
	//End Code Change ----11.18.2013 
	
	IF IsNull( stype ) or isnull(scrit) THEN
		CONTINUE
	else 
		c++
		ls_type[c ] = stype
		ls_criteria[c ] = scrit
	end if
	
NEXT
debugbreak()

SetRedraw(FALSE)

if tab_2.tabpage_browse.dw_browse.rowcount() = 0 then 
	tab_2.tabpage_browse.dw_browse.retrieve()
	tab_2.tabpage_browse.dw_browse.setfilter("")
	tab_2.tabpage_browse.dw_browse.filter()
end if

if c = 0 then 
	SetRedraw(TRUE)
	return 1
end if
//messagebox("","returieve")
For i = 1 to c
	choose case ls_type[i ]
		case "State", "Country", "County"
			ls_where = ls_where + "pos(Upper(" + ls_type[i] + "), '" + Upper( ls_criteria[i]) + "' ,1) > 0 AND "	
		case "rec_id"  //Start Code Change ----12.05.2012 #V12 maha
			ls_where = ls_where + " " + ls_type[i] + " = " +  ls_criteria[i] + "  AND "	
		case "active_status"  //Start Code Change ----11.18.2013 #V14 maha
			ls_where = ls_where +  ls_type[i] + " = " + ls_criteria[i] + " AND "	
		case else
		//	ls_where = ls_where + "Upper(" + ls_type[i] + ") like '" + Upper( ls_criteria[i]) + "%' AND "	
			ls_where = ls_where + "pos(Upper(" + ls_type[i] + "), '" + Upper( ls_criteria[i]) + "' ,1) > 0 AND "	
	end choose
next

ls_where = mid(  ls_where, 1, Len( ls_where ) - 5 )
//Messagebox("Setfilter", ls_where )
IF  lb_loc_only = false and tab_2.tabpage_browse.cbx_anp.checked THEN
	IF trim(ls_where) = "" THEN
		ls_where = "  accept_new_patient  = 581"
	ELSE
		ls_where = ls_where + " AND  accept_new_patient  = 581"
	END IF
END IF



//tab_2.tabpage_browse.dw_browse.setfilter("")
//tab_2.tabpage_browse.dw_browse.filter()
res =  tab_2.tabpage_browse.dw_browse.setfilter(ls_where)
if res < 0 then 
	SetRedraw(TRUE)
	Messagebox("Setfilter","Error in w_group_practice cb_search::clicked:~r " + ls_where )
	return 0

end if

 tab_2.tabpage_browse.dw_browse.filter()
 
	//Start Code Change ----01.16.2014 #V14 maha
if tab_2.tabpage_browse.dw_browse.rowcount() = 0 then
	//messagebox('none',"")
	tab_2.tabpage_browse.st_none.visible = true
end if
	//End Code Change ----01.16.2014

SetRedraw(TRUE) 


return 1
end function

public function integer of_set_buttons (integer ai_idx);//Set buttons' status based on the tab page (moved out of the selectionchanged event) - alfee 11.10.2010

tab_2.tabpage_survey.cb_export.visible = false
tab_2.tabpage_survey.cb_import.visible = false
tab_2.tabpage_survey.cb_print.visible = false
w_group_practice.cb_next.visible = false
w_group_practice.cb_prior.visible = false
w_group_practice.cb_addfor.visible=false
w_group_practice.cb_close.visible = true
w_group_practice.cb_viewdoc.visible = false
w_group_practice.cb_copy.visible = false //Start Code Change ----07.24.2017 #V154 maha

if ai_idx = 1 then //search
	w_group_practice.cb_add_gp.visible = True 
	w_group_practice.cb_find_gp.visible = false
 	w_group_practice.cb_addfor.visible=true
	tab_2.tabpage_browse.gb_search.visible = true
	tab_2.tabpage_browse.cb_search.visible = true
	tab_2.tabpage_browse.cb_clear.visible = true	
	tab_2.tabpage_browse.dw_search.visible = true
	tab_2.tabpage_browse.cbx_anp.visible = true
	w_group_practice.cb_delete.visible = true
	tab_2.tabpage_browse.rb_l_p.bringtotop = true
	tab_2.tabpage_browse.rb_loc.bringtotop = true
	IF gb_contract_version THEN tab_2.tabpage_browse.cbx_anp.visible = FALSE
elseif ai_idx = 2 then //detail
	w_group_practice.cb_addfor.visible=true
	//w_group_practice.cb_find_gp.visible = true  //Start Code Change ----01.07.2011 #V11 maha  - controlled by Add button
	tab_2.tabpage_browse.cb_search.visible = false
	tab_2.tabpage_browse.gb_search.visible = false
	tab_2.tabpage_browse.cb_clear.visible = false
	tab_2.tabpage_browse.dw_search.Visible = False	
	tab_2.tabpage_browse.cbx_anp.visible = false
	w_group_practice.cb_delete.visible = true
	w_group_practice.cb_add_gp.visible = True
	w_group_practice.cb_copy.visible = true //Start Code Change ----07.24.2017 #V154 maha
elseif ai_idx = 3 then //data
	w_group_practice.cb_delete.visible = true
	w_group_practice.cb_next.visible = true
	w_group_practice.cb_prior.visible = true
	w_group_practice.cb_add_gp.visible = True
elseif ai_idx = 4 then //docs  //Start Code Change ----10.04.2016 #V152 maha - added for docs
	w_group_practice.cb_delete.visible = true
	w_group_practice.cb_add_gp.visible = True
	w_group_practice.cb_viewdoc.visible = True
elseif ai_idx = 5 then //practitioners  //Start Code Change ----10.04.2016 #V152 maha - changed from 4
	w_group_practice.cb_delete.visible = false
	w_group_practice.cb_add_gp.visible = false
elseif ai_idx = 6 then //site survey  //Start Code Change ----10.04.2016 #V152 maha - changed from 5
	w_group_practice.cb_delete.visible = true
	w_group_practice.cb_add_gp.visible = True
	tab_2.tabpage_survey.cb_export.visible = true
	tab_2.tabpage_survey.cb_import.visible = true
	tab_2.tabpage_survey.cb_print.visible = true
end if

return 1

end function

public function integer of_change_row (); //Start Code Change ----04.21.2011 #V11 maha - added to call from search function 
integer ll_gp_id
long ll_row
datawindow ldw_loc

ldw_loc = tab_2.tabpage_browse.dw_browse

ll_row = ldw_loc.getrow()
//messagebox("",ll_row)

IF ll_row > 0 THEN
	//il_group_id = this.getitemnumber(currentrow, "rec_id" )//Start Code Change ----08.09.2010 #V10 maha = moved to clicked event
	il_group_id = ldw_loc.getitemnumber(ll_row, "rec_id" )//alfee 11.13.2010
	ll_gp_id = il_group_id
	

	ldw_loc.scrolltorow(ll_row)
	ldw_loc.selectrow(0,false)
	ldw_loc.selectrow(ll_row,true)


	gnv_appeondb.of_startqueue( )
	//tab_2.tabpage_detail.dw_detail.retrieve(ll_gp_id)
	If ib_tabpage_data_created Then tab_2.tabpage_data.uo_data.il_gpid = il_group_id //set variable in dat user object
	If ib_tabpage_detail_created Then tab_2.tabpage_detail.dw_detail.retrieve(ll_gp_id)
	If ib_tabpage_ass_prac_created Then tab_2.tabpage_ass_prac.dw_prac.retrieve(ll_gp_id)
	If ib_tabpage_survey_created Then tab_2.tabpage_survey.uo_survey.of_reset()//maha 061603
	gnv_appeondb.of_commitqueue( )

	IF w_group_practice.tab_1.selectedtab = 2  THEN //add if statement - alfee 11.11.2010
		IF gb_contract_version THEN
			w_group_practice.Title = "Locations (" + ldw_loc.GetItemString( ll_row, "full_address" ) + ")"//maha moved here from d-click 082404
		ELSE
			w_group_practice.Title = "Practice Locations (" + ldw_loc.GetItemString( ll_row, "full_address" ) + ")"//maha moved here from d-click 082404
		END IF
	END IF
	
	il_CurPractice = ll_row	

else
	 il_group_id = 0
	//tab_2.tabpage_detail.dw_detail.retrieve(ll_gp_id)
	tab_2.tabpage_data.uo_data.il_gpid = 0 //set variable in dat user object
	tab_2.tabpage_detail.dw_detail.reset()
	tab_2.tabpage_ass_prac.dw_prac.reset()
	tab_2.tabpage_survey.uo_survey.of_reset()//maha 061603
	w_group_practice.Title = "Practice Locations ()"
END IF

return 1
end function

public function string of_validate_crit (string ls_field, string ls_value);

choose case ls_field
	case "NPI"  //this does not exist
		if not isnumber(ls_value) then return "NUM"
		if len(ls_value) <> 10 then return "NPI"
	case "tax_id"
		if not isnumber(ls_value) then return  "NUM"
		if len(ls_value) <> 9 then return "TAX"
	case "Zip"
		if not isnumber(ls_value) then return  "NUM"
end choose

return 'OK'
end function

public function integer of_add_document ();//Start Code Change ----10.04.2016 #V153 maha - added
long ll_recid
long ll_docid
integer ll_screen
integer nr
string ls_name
string ls_ext
string ls_fullname
string ls_ref
integer i, li_cnt, li_rtn, li_filenum
integer p
integer li_pos
gs_pass_ids lst_ids
u_dw dw_docs

openwithparm(w_group_image_select_screen, il_group_id )

if message.stringparm = "Cancel" then return 1

//gets the screen and record
lst_ids = message.powerobjectparm
ll_screen = lst_ids.l_app_id
ll_recid = lst_ids.prac_id
ls_ref = lst_ids.s_stringval
//Messagebox(string(ll_screen), string(ll_recid))

dw_docs = tab_2.tabpage_docs.dw_docs

nr = dw_docs.insertrow(0)
dw_docs.setitem(nr, "table_id", ll_screen)
dw_docs.setitem(nr, "gp_id", il_group_id)
dw_docs.setitem(nr, "rec_id", ll_recid)

//get file
li_rtn = GetFileOpenName("Select File", &
	+ ls_fullname, ls_name, "TIF", &
	+ "TIFF Files (*.tif),*.tif," &
	+ "Bitmap Files (*.bmp),*.bmp," &
	+ "JPG Files (*.jpg),*.jpg," &
	+ "PDF Files (*.pdf),*.pdf," &
	+ "Word Documents(*.doc),*.doc," &
	+ "Word Documents(*.docx),*.docx," &
	+ "Excel Files (*.xls),*.xls," &
	+ "Excel Files (*.xlsx),*.xlsx" 	)
	
IF li_rtn < 1 THEN 
	dw_docs.deleterow( nr)
	return 1
end if

//filetype
p = 1
Do until p = 0
	p = pos(ls_name,"." , p + 1)
	if p > 0 then li_pos = p
loop

ls_ext = Upper(mid(ls_name, li_pos + 1)) 
ls_name = mid(ls_name, 1, li_pos - 1)

dw_docs.setitem(nr, "doc_type", ls_ext)
dw_docs.setitem(nr, "doc_name", ls_name)
if len(ls_ref) > 0 then
	ls_ref = leftA(ls_ref, 250)
	dw_docs.setitem(nr, "reference_value", ls_ref )
else
	dw_docs.setitem(nr, "reference_value", ls_fullname )
end if


//get id
dw_docs.update()
ll_docid = dw_docs.getitemnumber(nr, "document_id")

IF of_upload_doc_data("LOC", ls_fullname,"",ll_docid) = -1 THEN //alfee 07.14.2009
	Messagebox( "Upload Document", "Failed to upload the document!")
	dw_docs.deleterow(nr)
	RETURN -1
ELSE
	Messagebox( "Upload Document", "The document has been successfuly uploaded!")
	dw_docs.scrolltorow(nr)
	dw_docs.setrow(nr)
END IF






return 1


end function

public function integer of_delete_document (integer ai_row);//Start Code Change ----10.06.2016 #V153 maha - added
integer res
if ai_row < 1 then return 1

res = MessageBox("Confirm Delete","Are you sure you want to delete this Document?",question!,yesno!,2)
if res = 2 then return 1

tab_2.tabpage_docs.dw_docs.deleterow(ai_row)
tab_2.tabpage_docs.dw_docs.update()

return 1
end function

public function integer of_copy_location ();
//Start Code Change ----07.24.2017 #V154 maha
long ll_gp_id

w_group_practice.cb_save.TriggerEvent(Clicked!)
tab_2.tabpage_detail.dw_detail.rowscopy( 1, 1, primary!,  tab_2.tabpage_detail.dw_detail, 0, primary!)

select max(rec_id )
into :ll_gp_id
from group_practice;
	
ll_gp_id++
	
tab_2.tabpage_detail.dw_detail.setitem(1,"rec_id",ll_gp_id)
w_group_practice.Event pfc_Save()
w_group_practice.iuo_loc.il_group_id = ll_gp_id 



return 1
end function

on pfc_cst_u_locations.create
this.dw_imp_surv=create dw_imp_surv
this.tab_2=create tab_2
this.Control[]={this.dw_imp_surv,&
this.tab_2}
end on

on pfc_cst_u_locations.destroy
destroy(this.dw_imp_surv)
destroy(this.tab_2)
end on

type dw_imp_surv from datawindow within pfc_cst_u_locations
boolean visible = false
integer x = 3310
integer y = 8
integer width = 165
integer height = 52
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pd_survey_import"
boolean resizable = true
boolean livescroll = true
end type

type tab_2 from tab within pfc_cst_u_locations
event create ( )
event destroy ( )
integer x = 5
integer y = 12
integer width = 4448
integer height = 2396
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean fixedwidth = true
boolean raggedright = true
boolean createondemand = true
alignment alignment = center!
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_data tabpage_data
tabpage_docs tabpage_docs
tabpage_ass_prac tabpage_ass_prac
tabpage_survey tabpage_survey
end type

on tab_2.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_data=create tabpage_data
this.tabpage_docs=create tabpage_docs
this.tabpage_ass_prac=create tabpage_ass_prac
this.tabpage_survey=create tabpage_survey
this.Control[]={this.tabpage_browse,&
this.tabpage_detail,&
this.tabpage_data,&
this.tabpage_docs,&
this.tabpage_ass_prac,&
this.tabpage_survey}
end on

on tab_2.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_data)
destroy(this.tabpage_docs)
destroy(this.tabpage_ass_prac)
destroy(this.tabpage_survey)
end on

event selectionchanging;integer gp_id
integer r

gp_id = il_group_id
tab_2.tabpage_detail.dw_detail.accepttext()//(Appeon)Stephen 12.05.2013 - Bug 3764 Updates made to fields on Location Detail do not change on Location Search until Close Group and reopen

w_group_practice.cb_save.triggerevent(clicked!)	  //Start Code Change ----04.21.2008 #V8 maha
//Start Code Change ----.2010 #V10 maha

//if tab_2.tabpage_detail.dw_detail.rowcount() = 0 and gp_id > 0 then 
//	r = tab_2.tabpage_detail.dw_detail.retrieve(gp_id)
////messagebox('rc',r)
////	tab_2.tabpage_prac.dw_prac.retrieve(gp_id)
////	tab_2.tabpage_site.dw_site.retrieve(gp_id)
//end if


end event

event selectionchanged;long ll_Row
long ll_rec_id, ll_brow_recid

//------Begin Added by alfee 01.28.2010 ------------
//moved out of "if newindex = 1 " and modified
if OldIndex = 2 then
	ll_Row = tabpage_detail.dw_detail.GetRow()
	if ll_Row > 0 then
		ll_rec_id = tabpage_detail.dw_detail.object.rec_id[ll_Row]
	end if
	if ll_rec_id > 0 then
		ll_Row = tabpage_browse.dw_browse.GetRow()
		if ll_Row > 0 then ll_brow_recid = tabpage_browse.dw_browse.GetItemNumber(ll_row, "rec_id")
		if ll_brow_recid <> ll_rec_id then		
			ll_Row = tabpage_browse.dw_browse.Find("rec_id = " + String(ll_rec_id), 1, tabpage_browse.dw_browse.RowCount())
			if ll_Row <= 0 then
				tabpage_browse.rb_loc.Checked = true
				tabpage_browse.rb_loc.Event Clicked()
				tabpage_browse.cb_clear.Event Clicked()
				tabpage_browse.cb_search.Event Clicked()
				ll_Row = tabpage_browse.dw_browse.Find("rec_id = " + String(ll_rec_id), 1, tabpage_browse.dw_browse.RowCount())
			end if
			if ll_Row > 0 then
				tabpage_browse.dw_browse.ScrollToRow(ll_Row)
				tabpage_browse.dw_browse.SelectRow(0, false)
				tabpage_browse.dw_browse.SelectRow(ll_Row, true)
			end if
		end if
	end if
end if
//-------End Added --------------------------------

//----Begin Modified by alfee 11.10.2010 -------------------------------------------
//<$Reason>Move related code to the new function of_set_buttons()
of_set_buttons(newindex) //Set the buttons's status 

if newindex = 1 then
	//
elseif newindex = 2 then //detail
	if il_group_id > 0 then tab_2.tabpage_detail.dw_detail.retrieve(il_group_id) 
elseif newindex = 3 then //data
	tab_2.tabpage_data.uo_data.dw_select_section.retrieve()
//Start Code Change ----10.03.2016 #V152 maha - inserted new tab
elseif newindex = 4 then //documents	
	tab_2.tabpage_docs.dw_docs.retrieve(il_group_id)
	//Start Code Change ----12.13.2016 #V153 maha
	if w_group_practice.ii_doc_level = 1 then
		w_group_practice.cb_add_gp.enabled = false
		w_group_practice.cb_delete.enabled = false
	end if
	//End Code Change ----12.13.2016 
elseif newindex = 5 then //practitioners
	tab_2.tabpage_ass_prac.dw_prac.retrieve(il_group_id)
elseif newindex = 6 then //site survey
//End Code Change ----10.03.2016
	Integer li_ans, li_cnt
	String ls_full_address
	
	tab_2.tabpage_survey.uo_survey.il_gp_id = il_group_id	
	SELECT Count( rec_id ) INTO :li_cnt  	FROM pd_review_hdr  WHERE pd_review_hdr.address_id = :il_group_id ;
	
	IF li_cnt = 0 THEN
		li_ans = MessageBox("Not Found", "There was no survey found for the selected address.  ~n~r Would you like to create a survey for this address?", Question!, YesNo!, 1 )
		IF li_ans = 2 THEN 	Return
		tab_2.tabpage_survey.uo_survey.of_new_record( il_group_id )
	ELSE
		tab_2.tabpage_survey.uo_survey.of_retrieve_browse( il_group_id )		
	END IF	
	
end if

w_group_practice.of_set_security()  //Start Code Change ----01.07.2011 #V11 maha - moverd from inside case statement

//debugbreak()
//tab_2.tabpage_survey.cb_export.visible = false
//tab_2.tabpage_survey.cb_import.visible = false
//tab_2.tabpage_survey.cb_print.visible = false
//w_group_practice.cb_next.visible = false
//w_group_practice.cb_prior.visible = false
//w_group_practice.cb_addfor.visible=false//For batch add address Added by Nova 03.26.2009
//if newindex = 1 then
//	w_group_practice.cb_find_gp.visible = false
// 	w_group_practice.cb_addfor.visible=true//For batch add address Added by Nova 03.26.2009
//	tab_2.tabpage_browse.gb_search.visible = true
//	tab_2.tabpage_browse.cb_search.visible = true
//	tab_2.tabpage_browse.cb_clear.visible = true	
//	tab_2.tabpage_browse.dw_search.visible = true
//	tab_2.tabpage_browse.cbx_anp.visible = true
//	w_group_practice.cb_delete.visible = true
//	tab_2.tabpage_browse.rb_l_p.bringtotop = true
//	tab_2.tabpage_browse.rb_loc.bringtotop = true
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 09.13.2006 By: LeiWei
//	//$<reason> Making the Contract Module a Standalone Product
//	IF gb_contract_version THEN
//		tab_2.tabpage_browse.cbx_anp.visible = FALSE
//	END IF
//	//---------------------------- APPEON END ----------------------------
//
//elseif newindex = 2 then //detail
//	w_group_practice.cb_addfor.visible=true//For batch add address Added by Nova 03.26.2009
//	w_group_practice.cb_find_gp.visible = true
//	tab_2.tabpage_browse.cb_search.visible = false
//	tab_2.tabpage_browse.gb_search.visible = false
//	tab_2.tabpage_browse.cb_clear.visible = false
//	tab_2.tabpage_browse.dw_search.Visible = False	
//	tab_2.tabpage_browse.cbx_anp.visible = false
//	w_group_practice.cb_delete.visible = true
//	w_group_practice.cb_add_gp.visible = True
//	//messagebox("","qu")
//	//Start Code Change ----09.08.2010 #V10 maha
//	if il_group_id > 0 then 
//		tab_2.tabpage_detail.dw_detail.retrieve(il_group_id)
//	end if
//	//End Code Change ----09.08.2010
//elseif newindex = 3 then //data
//	tab_2.tabpage_data.uo_data.dw_select_section.retrieve()
//	w_group_practice.cb_delete.visible = true
//	w_group_practice.cb_next.visible = true
//	w_group_practice.cb_prior.visible = true
//	w_group_practice.cb_add_gp.visible = True
//	w_group_practice.cb_add_gp.visible = True
//
//elseif newindex = 4 then //practitioners
//	tab_2.tabpage_ass_prac.dw_prac.retrieve(il_group_id)
//	w_group_practice.cb_delete.visible = false
//	w_group_practice.cb_add_gp.visible = false
//elseif newindex = 5 then //site survey
//	tab_2.tabpage_survey.uo_survey.il_gp_id = il_group_id
//	w_group_practice.cb_delete.visible = true
//	w_group_practice.cb_add_gp.visible = True
//	tab_2.tabpage_survey.cb_export.visible = true
//	tab_2.tabpage_survey.cb_import.visible = true
//	tab_2.tabpage_survey.cb_print.visible = true
//
//	Integer li_ans
//	Integer li_cnt
//	//Long ll_address_id
//	String ls_full_address
//
//	//ll_address_id = dw_address_search.GetItemNumber( dw_address_search.GetRow(), "rec_id" )
//	//ls_full_address = dw_address_search.GetItemString( dw_address_search.GetRow(), "full_address" )
//
//	SELECT Count( rec_id )  
//	INTO :li_cnt  
//	FROM pd_review_hdr  
//	WHERE pd_review_hdr.address_id = :il_group_id   ;
//
//	IF li_cnt = 0 THEN
//		li_ans = MessageBox("Not Found", "There was no survey found for the selected address.  ~n~r Would you like to create a survey for this address?", Question!, YesNo!, 1 )
//		IF li_ans = 2 THEN
//			Return
//		END IF
//		tab_2.tabpage_survey.uo_survey.of_new_record( il_group_id )
//	ELSE
//		tab_2.tabpage_survey.uo_survey.of_retrieve_browse( il_group_id )		
//	END IF
//	
//	w_group_practice.of_set_security() //Start Code Change ----01.04.2010 #V10 maha
//	//w_site_surveys.Title = "Site Survey    ( " + ls_full_address + " )"
//END IF
//-----End Modified -----------------------------------------------------------


end event

type tabpage_browse from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4411
integer height = 2280
long backcolor = 16777215
string text = "Location Search"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
cb_search cb_search
cb_1 cb_1
cb_sort cb_sort
rb_l_p rb_l_p
rb_loc rb_loc
cbx_anp cbx_anp
dw_search dw_search
dw_browse dw_browse
gb_search gb_search
cb_clear cb_clear
st_none st_none
cbx_valid cbx_valid
end type

on tabpage_browse.create
this.cb_search=create cb_search
this.cb_1=create cb_1
this.cb_sort=create cb_sort
this.rb_l_p=create rb_l_p
this.rb_loc=create rb_loc
this.cbx_anp=create cbx_anp
this.dw_search=create dw_search
this.dw_browse=create dw_browse
this.gb_search=create gb_search
this.cb_clear=create cb_clear
this.st_none=create st_none
this.cbx_valid=create cbx_valid
this.Control[]={this.cb_search,&
this.cb_1,&
this.cb_sort,&
this.rb_l_p,&
this.rb_loc,&
this.cbx_anp,&
this.dw_search,&
this.dw_browse,&
this.gb_search,&
this.cb_clear,&
this.st_none,&
this.cbx_valid}
end on

on tabpage_browse.destroy
destroy(this.cb_search)
destroy(this.cb_1)
destroy(this.cb_sort)
destroy(this.rb_l_p)
destroy(this.rb_loc)
destroy(this.cbx_anp)
destroy(this.dw_search)
destroy(this.dw_browse)
destroy(this.gb_search)
destroy(this.cb_clear)
destroy(this.st_none)
destroy(this.cbx_valid)
end on

type cb_search from picturebutton within tabpage_browse
integer x = 2203
integer y = 280
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
boolean default = true
boolean originalsize = true
long backcolor = 30602721
end type

event clicked;Integer i
Integer li_rc
String ls_where
string stype
string ls_criteria

ls_where = " and " 
li_rc = dw_search.RowCount() 
dw_search.AcceptText()

SetPointer(HourGlass!) //alfee 12.12.2008

//Start Code Change ----08010.2010 #V10 maha - reworked filter code into function

of_search_location()
of_change_row()   //Start Code Change ----04.21.2011 #V11 maha

return
end event

type cb_1 from commandbutton within tabpage_browse
integer x = 3611
integer y = 440
integer width = 750
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View All Pending Changes"
end type

event clicked;open(w_pending_changes_group_all)
end event

type cb_sort from commandbutton within tabpage_browse
integer x = 2208
integer y = 412
integer width = 347
integer height = 92
integer taborder = 40
boolean bringtotop = true
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

dw_browse.SetFocus()
end event

type rb_l_p from radiobutton within tabpage_browse
integer x = 485
integer y = 72
integer width = 736
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Locations and Practitioners"
end type

event clicked;dw_browse.reset()
dw_browse.dataobject = "d_group_prac_search_all"
dw_browse.of_settransobject(sqlca)
is_sql = dw_browse.GetSqlSelect()

//cbx_amc.visible = true //Start Code Change ----07.28.2008 #V85 maha - removed; no functionality connected
cbx_anp.visible = true

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
//IF gb_contract_version THEN//Start Code Change ----04.21.2008 #V8 maha - removed ; not needed - done in open event
//	tab_1.tabpage_gp.tab_2.tabpage_browse.cbx_anp.visible = FALSE
//	tab_1.tabpage_gp.tab_2.tabpage_browse.cbx_amc.visible = FALSE
//END IF
//---------------------------- APPEON END ----------------------------

end event

type rb_loc from radiobutton within tabpage_browse
integer x = 50
integer y = 72
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Locations only"
boolean checked = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Fix a defect.
IF This.checked and gb_contract_version THEN RETURN		//Modified by Scofield on 2008-03-14: Add gb_contract_version condition
//---------------------------- APPEON END ----------------------------

dw_browse.dataobject = "d_group_prac_search"//"d_group_prac_search1"
dw_browse.of_settransobject(sqlca)
is_sql = dw_browse.GetSqlSelect()
//dw_browse.retrieve()

//cbx_amc.visible = false  //Start Code Change ----07.28.2008 #V85 maha - removed, no functionality attached
cbx_anp.visible = false

end event

type cbx_anp from checkbox within tabpage_browse
integer x = 1426
integer y = 72
integer width = 654
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Accepting New Patients   "
end type

type dw_search from u_dw within tabpage_browse
integer x = 50
integer y = 156
integer width = 2112
integer height = 348
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_group_search"
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.InsertRow( 0 )
This.InsertRow( 0 )
//This.InsertRow( 0 )
//This.InsertRow( 0 )				//Added by Scofield on 2008-03-17

//This.SetItem( 1, "search_type", "street" )

end event

event itemchanged;call super::itemchanged;//$<Commnet> 2008-04-16 By: Scofield  /original code Moved  to dropdown event.
//Start Code Change ----11.18.2013 #V14 maha - new code for active status
DataWindowChild dwchild

IF This.GetColumnName() = "search_type" THEN
	Choose case upper(data) 
		case "ACTIVE_STATUS"
			This.GetChild( "criteria", dwchild )
			this.Modify("criteria.dddw.name = 'd_code_lookup_active_address'")
			this.Modify("criteria..dddw.datacolumn = 'lookup_code'")			
			this.Modify("criteria..dddw.displaycolumn = 'description'")
			dwchild.SetTransObject( SQLCA )
		CASE "COUNTY", "STATE", "LANGUAGE" ,  "SPECIALTY",  "PROVIDER_TYPE" 	
			This.GetChild( "criteria", dwchild )
			this.Modify("criteria.dddw.name = 'd_dddw_code_lookup'")
			this.Modify("criteria..dddw.datacolumn = 'lookup_code'")			
			this.Modify("criteria..dddw.displaycolumn = 'description'")
			dwchild.SetTransObject( SQLCA )
		CASE ELSE
			dwchild.reset()
	END CHOOSE
END IF
//End Code Change ----11.18.2013

//Start Code Change ----01.16.2014 #V14 maha
this.setcolumn( "criteria")

end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() < 1 then return //maha 092903
//IF This.GetColumnName() = "search_type" THEN
	DataWindowChild dwchild
	This.GetChild( "criteria", dwchild )
	dwchild.SetTransObject( SQLCA )
	CHOOSE CASE Upper( This.GetItemString( currentrow, "search_type" ))
		CASE "COUNTY"
			dwchild.Retrieve("county")	
		CASE "STATE"
			dwchild.Retrieve("State")			
		CASE "LANGUAGE"
			dwchild.Retrieve("Foreign Languages")					
		CASE "SPECIALTY"
			dwchild.Retrieve("PRACTITIONER SPECIALTIES")			
		CASE "PROVIDER_TYPE"
			dwchild.Retrieve("Provider Types")						
	END CHOOSE
//END IF




end event

event dropdown;call super::dropdown;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-16 By: Scofield
//$<Reason> Refresh the drop down datawindow value

String	ls_Type
long		ll_Row

DataWindowChild ldwc_Child

if This.GetColumnName() = "criteria" then
	This.GetChild("criteria",ldwc_Child)
	ldwc_Child.SetTransObject(SQLCA)
	
	ll_Row = This.GetRow()
	ls_Type = This.GetItemString(ll_Row,'search_type')
	Choose Case Upper(ls_Type)
		Case "COUNTY"
			ldwc_Child.Retrieve("county")
		Case "STATE"
			ldwc_Child.Retrieve("State")
		Case "LANGUAGE"
			ldwc_Child.Retrieve("Foreign Languages")
		Case "SPECIALTY"
			ldwc_Child.Retrieve("PRACTITIONER SPECIALTIES")
		Case "PROVIDER_TYPE"
			ldwc_Child.Retrieve("Provider Types")
		Case "COUNTRY"
			ldwc_Child.Retrieve("Country")	
		Case "ACTIVE_STATUS"  //Start Code Change ----11.18.2013 maha V14
			ldwc_Child.Retrieve()
		Case else
			ldwc_Child.Reset()
	End Choose
End if
//---------------------------- APPEON END ----------------------------

end event

type dw_browse from u_dw within tabpage_browse
integer y = 568
integer width = 4402
integer height = 1708
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_group_prac_search"
boolean hscrollbar = true
end type

event clicked;call super::clicked;integer li_Row

li_Row = this.getclickedrow()

IF li_Row > 0 THEN
	tab_2.tabpage_browse.dw_browse.setrow(li_Row)
	//Start Code Change ----04.21.2011 #V11 maha - moved to RFC
//	tab_2.tabpage_browse.dw_browse.scrolltorow(li_Row)
//	tab_2.tabpage_browse.dw_browse.selectrow(0,false)
//	tab_2.tabpage_browse.dw_browse.selectrow(li_Row,true)
	//End Code Change ----04.21.2011 
//	il_group_id = this.getitemnumber(li_row, "rec_id" )  //Start Code Change ----08.09.2010 #V10 maha - moved from rfc event
	//if li_Row = il_CurPractice then This.Trigger Event RowFocusChanged(li_Row)	//Added by Scofield on 2008-01-04
END IF

end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1) Copy the following script from the Open event of w_group_practice due
//$<modification> to the usage of CreateOnDemand. Refer to PT-02 for more information.
//$<modification> 2) Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

this.of_settransobject(sqlca) //alfee 10.23.2009
is_sql = tab_2.tabpage_browse.dw_browse.GetSqlSelect()

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

//this.of_settransobject(sqlca) - moved above by alfee 10.23.2009
This.of_SetUpdateAble( true )

DataWindowChild dwchild


This.GetChild( "state", dwchild )  //maha 08.09.2010 - removed
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
//dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
////dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )  //maha 08.09.2010 - removed
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
////dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
this.retrieve()

gnv_appeondb.of_commitqueue( )

//This.GetChild( "state", dwchild )
//dwchild.InsertRow( 1 )
//
//This.GetChild( "county", dwchild )
//dwchild.InsertRow( 1 )
//
//This.GetChild( "country", dwchild )
//dwchild.InsertRow( 1 )
//
//This.GetChild( "mailing_address", dwchild )
//dwchild.InsertRow( 1 )
//---------------------------- APPEON END ----------------------------

This.of_SetFilter(True)
this.settransobject(sqlca)
This.inv_Filter.of_SetStyle(inv_Filter.simple   )
This.inv_Filter.of_SetColumnDisplayNameStyle( 2 )
this.inv_filter.of_setrequestor( this)

//Start Code Change ----01.20.2014 #V14 maha
This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.of_SetReqColumn(True)
This.inv_sort.of_SetColumnHeader(True)
//End Code Change ----01.20.2014

//Start Code Change ----07.17.2017 #V154 maha - added for font increase
this.Modify("DataWindow.Zoom=" + string(gi_zoom))  
end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	tab_2.selecttab(2)
end if

end event

event retrieveend;call super::retrieveend;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.05.2006 By: LiuHongXin
//$<reason> Fix a defect.
/*
IF rowcount > 0 THEN
*/
long r

IF RowCount > 0 THEN
	this.selectrow(1,True)
	//il_group_id = this.getitemnumber(1,"rec_id")2010-11-04
//	messagebox("Browsed retrirev", il_group_id)
//	 tab_2.tabpage_detail.dw_detail.settransobject(sqlca)
//	r =  tab_2.tabpage_detail.dw_detail.retrieve(il_group_id) //Start Code Change ----07.07.2010 #V10 maha
//	messagebox("detail retrieve", r)
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;integer ll_gp_id

of_change_row()
return 0
//messagebox("gp_id",gp_id)
IF currentrow > 0 THEN
	//il_group_id = this.getitemnumber(currentrow, "rec_id" )//Start Code Change ----08.09.2010 #V10 maha = moved to clicked event
	il_group_id = this.getitemnumber(currentrow, "rec_id" )//alfee 11.13.2010
	ll_gp_id = il_group_id
	
//	--------------------------- APPEON BEGIN ---------------------------
//	$<ID> PT-07
//	$<modify> 02.09.2006 By: LeiWei
//	$<reason> Performance tuning
//	$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	/*
	tab_1.tabpage_gp.tab_2.tabpage_data.uo_data.il_gpid = il_group_id //set variable in dat user object
	tab_2.tabpage_detail.dw_detail.retrieve(il_group_id)
	tab_2.tabpage_ass_prac.dw_prac.retrieve(il_group_id)
	tab_2.tabpage_survey.uo_survey.of_reset()//maha 061603
	*/
	gnv_appeondb.of_startqueue( )
	//tab_2.tabpage_detail.dw_detail.retrieve(ll_gp_id)
	If ib_tabpage_data_created Then tab_2.tabpage_data.uo_data.il_gpid = il_group_id //set variable in dat user object
	If ib_tabpage_detail_created Then tab_2.tabpage_detail.dw_detail.retrieve(ll_gp_id)
	If ib_tabpage_ass_prac_created Then tab_2.tabpage_ass_prac.dw_prac.retrieve(ll_gp_id)
	If ib_tabpage_survey_created Then tab_2.tabpage_survey.uo_survey.of_reset()//maha 061603
	if tab_2.tabpage_docs.visible = true then
		tab_2.tabpage_docs.dw_docs.retrieve(ll_gp_id)  //Start Code Change ----10.05.2016 #V153 maha -for documents
		//tab_2.tabpage_docs.dw_docs.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Start Code Change ----07.17.2017 #V154 maha - added for font increase
	end if

	gnv_appeondb.of_commitqueue( )
//	---------------------------- APPEON END ----------------------------


//	--------------------------- APPEON BEGIN ---------------------------
//	$<modify> 09.13.2006 By: LeiWei
//	$<reason> Making the Contract Module a Standalone Product

	IF w_group_practice.tab_1.selectedtab = 2  THEN //add if statement - alfee 11.11.2010
		IF gb_contract_version THEN
			w_group_practice.Title = "Locations (" + This.GetItemString( currentrow, "full_address" ) + ")"//maha moved here from d-click 082404
		ELSE
			w_group_practice.Title = "Practice Locations (" + This.GetItemString( currentrow, "full_address" ) + ")"//maha moved here from d-click 082404
		END IF
	END IF
//	---------------------------- APPEON END ----------------------------
	il_CurPractice = CurrentRow		//Added by Scofield on 2008-01-04
END IF
end event

type gb_search from groupbox within tabpage_browse
integer x = 5
integer y = 16
integer width = 2181
integer height = 508
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Search Criteria"
end type

type cb_clear from commandbutton within tabpage_browse
integer x = 2199
integer y = 148
integer width = 347
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;//Start Code Change ----08.09.2010 #V10 maha

tab_2.tabpage_browse.st_none.visible = false  //Start Code Change ----01.16.2014 #V14 maha

dw_search.Reset()
dw_search.InsertRow( 0 )
dw_search.InsertRow( 0 )

dw_browse.setfilter("")
dw_browse.filter()

dw_browse.SetSqlSelect( is_sql)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-17 By: Scofield
//$<Reason> Reset update table to allow deletes.

dw_browse.SetTransObject( SQLCA )
dw_browse.Modify("DataWindow.Table.updatetable='group_practice'")
//---------------------------- APPEON END ----------------------------

dw_browse.retrieve()
of_change_row()  //Start Code Change ----04.21.2011 #V11 maha


//dw_search.Reset()
//dw_search.InsertRow( 0 )
//dw_search.InsertRow( 0 )
//dw_search.InsertRow( 0 )
//dw_search.InsertRow( 0 )
//
//dw_browse.SetSqlSelect( is_sql)
//
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2008-03-17 By: Scofield
////$<Reason> Reset update table to allow deletes.
//
//dw_browse.SetTransObject( SQLCA )
//dw_browse.Modify("DataWindow.Table.updatetable='group_practice'")
////---------------------------- APPEON END ----------------------------
//
//dw_browse.retrieve()

end event

type st_none from statictext within tabpage_browse
boolean visible = false
integer x = 2624
integer y = 428
integer width = 681
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "No results Found"
boolean focusrectangle = false
end type

type cbx_valid from checkbox within tabpage_browse
integer x = 2203
integer y = 80
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
string text = "Validate Numeric Values"
end type

type tabpage_detail from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4411
integer height = 2280
long backcolor = 16777215
string text = "Location Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
st_1 st_1
dw_detail dw_detail
end type

on tabpage_detail.create
this.st_1=create st_1
this.dw_detail=create dw_detail
this.Control[]={this.st_1,&
this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.st_1)
destroy(this.dw_detail)
end on

type st_1 from statictext within tabpage_detail
boolean visible = false
integer x = 3991
integer y = 2180
integer width = 82
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean focusrectangle = false
end type

event clicked;openwithparm(w_pending_changes_group, il_group_id )
end event

type dw_detail from u_dw within tabpage_detail
integer y = 8
integer width = 4402
integer height = 2272
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_group_data_entry"
boolean hscrollbar = true
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone or fax

String	ls_Phone,ls_fax,ls_RetParm

This.AcceptText() //(Appeon)Harry 06.06.2013 - V141 ISG-CLX
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if
if dwo.name = 'b_addpending' then//Added by Appeon long.zhang 07.15.2013 (V14.1 Group Location Effective Dates)
	openWithParm(w_pending_changes_group,'A' + String(il_group_id))
	tab_2.selectedtab = 2
elseif dwo.name = 'b_viewpending' then
	openWithParm(w_pending_changes_group,'V' + String(il_group_id))
		tab_2.selectedtab = 2
elseif dwo.name = "b_bill" then
	open(w_group_billing_addr_select)
	if message.stringparm = "Cancel" then
		return
	else
		this.setitem(row, "billing_address_flag", message.doubleparm)
	end if


end if
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;This.settransobject(sqlca)
this.of_setdropdowncalendar(true)	//added by long.zhang v12.2 group location mini- painter
DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
//dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
//dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
//dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

This.GetChild( "state", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.InsertRow( 1 )

ib_tabpage_detail_created = True
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
IF gb_contract_version THEN
	Modify(" gb_3.Visible=0 routine_visit_appt_t.Visible=0 routine_visit_appt.Visible=0 urgent_visit_appt_t.Visible=0 urgent_visit_appt.Visible=0 emergency_visit_appt_t.Visible=0 emergency_visit_appt.Visible=0 non_emergency_appt_t.Visible=0 non_emergency_appt.Visible=0 ")
//	Modify(" practice_type_t.text='Location Name' ")
	Modify(" street_t.text='Location Name' ")	//long.zhang 07.10.2012 v12.2 group location mini-painter
END IF
//---------------------------- APPEON END ----------------------------


//-----------------------------APPEON BEGIN--------------------------
//$<add> long.zhang 06.29.2012
//<reason>: v12.2 Group Location mini-painter need to modify the labels and visibility of these fields
f_modify_group_detail_property(this)
//-----------------------------APPEON END----------------------------

//Start Code Change ----07.17.2017 #V154 maha - added for font increase
this.Modify("DataWindow.Zoom=" + string(gi_zoom))  

end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-29 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm

This.AcceptText() //(Appeon)Harry 06.06.2013 - V141 ISG-CLX
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if

//---------------------------- APPEON END ----------------------------

end event

event losefocus;call super::losefocus;this.accepttext()




end event

event rbuttondown;call super::rbuttondown;//added by long.zhang 07.05.2012 v12.2 group location mini-painter

integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)
col = this.getclickedcolumn()
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" THEN
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event itemchanged;call super::itemchanged; //Start Code Change ----04.07.2015 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(this.getrow(),"zip")
	of_zip_fill(val, "LOC", this)
end if

end event

event pfc_postupdate;call super::pfc_postupdate;//Start Code Change ----11.28.2016 #V153 maha - added for entity update
integer ll_cnt
select count(entity_id) into :ll_cnt from entity_lookup where loc_id = :il_group_id;

if ll_cnt > 0 then
	w_group_practice.inv_ent.of_update_entity_links(this,"L",il_group_id)
end if

return 1
end event

type tabpage_data from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4411
integer height = 2280
long backcolor = 16777215
string text = "Additional Data"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
uo_data uo_data
end type

on tabpage_data.create
this.uo_data=create uo_data
this.Control[]={this.uo_data}
end on

on tabpage_data.destroy
destroy(this.uo_data)
end on

type uo_data from pfc_cst_u_group_data within tabpage_data
event destroy ( )
integer x = 5
integer width = 4393
integer height = 2260
integer taborder = 10
end type

on uo_data.destroy
call pfc_cst_u_group_data::destroy
end on

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Copy the following script from the Rowfocuschanged event of dw_browse due
//$<modification> to the usage of CreateOnDemand. Refer to PT-02 for more information.

If NOT ib_tabpage_data_created Then This.il_gpid = il_group_id
ib_tabpage_data_created = TRUE
//---------------------------- APPEON END ----------------------------

end event

type tabpage_docs from userobject within tab_2
integer x = 18
integer y = 100
integer width = 4411
integer height = 2280
long backcolor = 16777215
string text = "Documents"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_docs dw_docs
end type

on tabpage_docs.create
this.dw_docs=create dw_docs
this.Control[]={this.dw_docs}
end on

on tabpage_docs.destroy
destroy(this.dw_docs)
end on

type dw_docs from u_dw within tabpage_docs
integer y = 16
integer width = 4407
integer height = 2264
integer taborder = 11
string dataobject = "d_group_docs_browse"
boolean hscrollbar = true
end type

event clicked;call super::clicked;this.setrow(row)
end event

event retrieveend;call super::retrieveend;//Start Code Change ----07.17.2017 #V154 maha - added for font increase
this.Modify("DataWindow.Zoom=" + string(gi_zoom))  

end event

type tabpage_ass_prac from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4411
integer height = 2280
long backcolor = 16777215
string text = "Associated Providers"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_unlink cb_unlink
st_3 st_3
cb_link_prac cb_link_prac
dw_prac dw_prac
end type

on tabpage_ass_prac.create
this.cb_unlink=create cb_unlink
this.st_3=create st_3
this.cb_link_prac=create cb_link_prac
this.dw_prac=create dw_prac
this.Control[]={this.cb_unlink,&
this.st_3,&
this.cb_link_prac,&
this.dw_prac}
end on

on tabpage_ass_prac.destroy
destroy(this.cb_unlink)
destroy(this.st_3)
destroy(this.cb_link_prac)
destroy(this.dw_prac)
end on

type cb_unlink from commandbutton within tabpage_ass_prac
integer x = 741
integer y = 56
integer width = 704
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Unlink Selected Provider"
end type

event clicked;Integer res
Long nullnum
SetNull(nullnum)
Long ll_prac_id //Nova 09.27.2010
IF dw_prac.RowCount() < 1 THEN RETURN //Added by  Nova 10.12.2010
res = MessageBox("Delete Link?","Are you sure you want to remove the link for the selected pratitioner?",question!,yesno!,2)

IF res = 1 THEN
	dw_prac.SetItem(dw_prac.GetRow(),"pd_address_gp_id",nullnum)
	ll_prac_id = dw_prac.GetItemNumber(dw_prac.GetRow(),"pd_address_prac_id")
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-14
	//$<add> 02.09.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	
	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------
	
	dw_prac.Update()
	COMMIT Using sqlca;
	dw_prac.Retrieve(il_group_id)
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-15
	//$<add> 02.09.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
	//--------Begin added by  Nova 09.27.2010------------------------
	//	V10.5 SK Group Practice 
	IF IsValid(w_group_practice) THEN
		w_group_practice.of_delete_dw_tv(il_group_id,ll_prac_id)
	END IF
	//--------End added --------------------------------------------
END IF

















end event

type st_3 from statictext within tabpage_ass_prac
integer x = 3369
integer y = 1612
integer width = 64
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
alignment alignment = right!
boolean focusrectangle = false
end type

event clicked;open(w_addr_gp_conversion)
end event

type cb_link_prac from commandbutton within tabpage_ass_prac
integer x = 37
integer y = 56
integer width = 695
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Establish Provider Links"
end type

event clicked;if il_group_id < 1 then
	messagebox("No practice selected.","Please go to the browse tab and select a practice location. ")
	return
end if

openwithparm(w_gp_prac_link,il_group_id)


tab_2.tabpage_ass_prac.dw_prac.retrieve(il_group_id)
end event

type dw_prac from u_dw within tabpage_ass_prac
integer x = 32
integer y = 196
integer width = 4370
integer height = 2088
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_group_practitioners"
end type

event clicked;call super::clicked;integer r

r = this.getclickedrow()
if r>0 then //Added by  Nova 10.12.2010
	this.setrow(r)
	this.selectrow(0,false)
	this.selectrow(r,true)
end if	



end event

event constructor;call super::constructor;this.settransobject(sqlca)

DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "specialty", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("practitioner specialties")
//dwchild.InsertRow( 1 )

This.GetChild( "specialty_order", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("specialty order")
//dwchild.InsertRow( 1 )

This.GetChild( "accepting_new_patients", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

This.GetChild( "specialty", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "specialty_order", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "accepting_new_patients", dwchild )
dwchild.InsertRow( 1 )

//$<reason> Because the tab_1.tabpage_gp.tab_2 control is set the createondemand property.
//$<reason> The scripts moved from tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse::rowfocuschanged event.
If Not ib_tabpage_ass_prac_created Then This.retrieve(il_group_id)
ib_tabpage_ass_prac_created = True
//---------------------------- APPEON END ----------------------------

end event

event retrieveend;call super::retrieveend;//Start Code Change ----07.17.2017 #V154 maha - added for font increase
this.Modify("DataWindow.Zoom=" + string(gi_zoom))  
end event

type tabpage_survey from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4411
integer height = 2280
long backcolor = 16777215
string text = "Site Survey"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
uo_survey uo_survey
cb_print cb_print
cb_import cb_import
cb_export cb_export
end type

on tabpage_survey.create
this.uo_survey=create uo_survey
this.cb_print=create cb_print
this.cb_import=create cb_import
this.cb_export=create cb_export
this.Control[]={this.uo_survey,&
this.cb_print,&
this.cb_import,&
this.cb_export}
end on

on tabpage_survey.destroy
destroy(this.uo_survey)
destroy(this.cb_print)
destroy(this.cb_import)
destroy(this.cb_export)
end on

type uo_survey from pfc_cst_u_site_survey_collect_data within tabpage_survey
event destroy ( )
integer y = 16
integer width = 4402
integer height = 2268
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_survey.destroy
call pfc_cst_u_site_survey_collect_data::destroy
end on

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Copy the following script from the Rowfocuschanged event of dw_browse due
//$<modification> to the usage of CreateOnDemand. Refer to PT-02 for more information.

If NOT ib_tabpage_survey_created Then This.of_reset()
ib_tabpage_survey_created = TRUE
//---------------------------- APPEON END ----------------------------

end event

type cb_print from commandbutton within tabpage_survey
integer x = 2363
integer y = 12
integer width = 347
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print"
end type

event clicked;tab_2.tabpage_survey.uo_survey.tab_review.tabpage_questions.dw_questions.print()
end event

type cb_import from commandbutton within tabpage_survey
integer x = 1984
integer y = 12
integer width = 347
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Import Survey"
end type

event clicked;string ls_docid
string ls_surv
integer res
long ll_recid
long ll_export
long ll_sid
long ll_pd_rev
long s_cnt
integer cnt
long r
long f
integer i
long li_id

r = tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getrow()

if r < 1 then //trap
	messagebox("No Survey","No survey to import.")
	return
end if

ll_pd_rev = tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getitemnumber(1,"rec_id")

select export_id into :ll_export from pd_review_export where pd_review_id = :ll_pd_rev;

if ll_export < 1 or isnull(ll_export) then  //check to see if was exported
	messagebox("Export not Found","This survey was not previously exported.  Unable to import")
	return
else
	select doc_id into :ls_docid from pd_review_export where pd_review_id = :ll_pd_rev;
	if isnull(ls_docid) or ls_docid = "" then
		messagebox("Import Error","Unable to get the document id for this record.  Unable to import.")
		return
	end if
end if

//ls_docid = tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getitemstring(1,"doc_id")
ls_surv = gs_temp_path + "intellisite\imports\" + ls_docid + "_surveyback.txt"

//messagebox("ls_surv",ls_surv)

if not fileexists(ls_surv) then 
	messagebox("No Survey File","Cannot find Survey file " + ls_surv)
	return
end if
//
dw_imp_surv.settransobject(sqlca)
dw_imp_surv.reset()

s_cnt = dw_imp_surv.importfile(ls_surv)
if s_cnt < 1 then
	messagebox("Import error","Unable to import survey data")
	return
end if

for i = 1 to s_cnt //set the imported data so that it can be updated
	dw_imp_surv.SetItemStatus ( i, 0, primary!,datamodified! )
	dw_imp_surv.SetItemStatus ( i, "answer_on_off", primary!,datamodified! )
	dw_imp_surv.SetItemStatus ( i, "score", primary!,datamodified! )
	dw_imp_surv.SetItemStatus ( i, "notes", primary!,datamodified! )
	
next

res = dw_imp_surv.update()

//messagebox("",res)

if res < 1 then
	messagebox("Import Error","Unable to update Survey data.")
else
	tab_2.tabpage_survey.uo_survey.of_retrieve_detail(ll_pd_rev)
	messagebox("Survey Import","Import Complete")
end if



end event

type cb_export from commandbutton within tabpage_survey
integer x = 1605
integer y = 12
integer width = 347
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Export Survey"
end type

event clicked;//function added maha 061004 for intellisite

long ll_pd_rev
long ll_gpid
long ll_export
long ll_review
integer r
integer c
integer res

r = tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getrow()

if r < 1 then //trap
	messagebox("No Survey","No survey to export.")
	return
end if

ll_gpid = il_group_id
ll_pd_rev = tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getitemnumber(r,"rec_id")
ll_review = tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getitemnumber(r,"review_id")

select export_id into :ll_export from pd_review_export where pd_review_id = :ll_pd_rev;

if ll_export > 0 then  //check to see if was exported
	res = messagebox("Survey Found","This survey was previously exported.  Do you want to export again?", question!,yesno!,2)
	if res = 2 then return
else
	select max(export_id) into :ll_export from pd_review_export;
	if isnull(ll_export) then ll_export =  0 
	ll_export++
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-17
	//$<add> 02.09.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------

	insert into pd_review_export (export_id,review_id, pd_review_id,gp_id) values (:ll_export, :ll_review, :ll_pd_rev, :ll_gpid);
	commit using sqlca;

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-18
	//$<add> 02.09.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
end if


openwithparm(w_survey_export,ll_export)
end event

