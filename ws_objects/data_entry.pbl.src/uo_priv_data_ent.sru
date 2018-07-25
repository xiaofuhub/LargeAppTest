$PBExportHeader$uo_priv_data_ent.sru
forward
global type uo_priv_data_ent from userobject
end type
type cb_wv_movckup from commandbutton within uo_priv_data_ent
end type
type gb_ss from groupbox within uo_priv_data_ent
end type
type gb_rs from groupbox within uo_priv_data_ent
end type
type gb_ca from groupbox within uo_priv_data_ent
end type
type gb_filter from groupbox within uo_priv_data_ent
end type
type p_1 from picture within uo_priv_data_ent
end type
type dw_select from u_dw within uo_priv_data_ent
end type
type st_recs from statictext within uo_priv_data_ent
end type
type tab_1 from tab within uo_priv_data_ent
end type
type tabpage_browse from userobject within tab_1
end type
type dw_browse from u_dw within tabpage_browse
end type
type gb_3 from groupbox within tabpage_browse
end type
type r_2 from rectangle within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
dw_browse dw_browse
gb_3 gb_3
r_2 r_2
end type
type tabpage_detail from userobject within tab_1
end type
type dw_detail from u_dw within tabpage_detail
end type
type r_3 from rectangle within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
dw_detail dw_detail
r_3 r_3
end type
type tabpage_exp_priv from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_exp_priv
end type
type dw_expired from u_dw within tabpage_exp_priv
end type
type cb_renew from commandbutton within tabpage_exp_priv
end type
type tabpage_exp_priv from userobject within tab_1
cb_1 cb_1
dw_expired dw_expired
cb_renew cb_renew
end type
type tab_1 from tab within uo_priv_data_ent
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_exp_priv tabpage_exp_priv
end type
type rb_curr from radiobutton within uo_priv_data_ent
end type
type rb_hist from radiobutton within uo_priv_data_ent
end type
type rb_both from radiobutton within uo_priv_data_ent
end type
type dw_status_sel from datawindow within uo_priv_data_ent
end type
type dw_clin_sel from datawindow within uo_priv_data_ent
end type
end forward

global type uo_priv_data_ent from userobject
integer width = 3726
integer height = 2084
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_priv_batch ( )
cb_wv_movckup cb_wv_movckup
gb_ss gb_ss
gb_rs gb_rs
gb_ca gb_ca
gb_filter gb_filter
p_1 p_1
dw_select dw_select
st_recs st_recs
tab_1 tab_1
rb_curr rb_curr
rb_hist rb_hist
rb_both rb_both
dw_status_sel dw_status_sel
dw_clin_sel dw_clin_sel
end type
global uo_priv_data_ent uo_priv_data_ent

type variables
long il_prac
long il_facil
long il_clin
long il_core
integer ii_rights

string is_clinfilter = ""
string is_currfilter = ""
string is_statusfilter = ""
string is_browsefilter
end variables

forward prototypes
public function integer of_browse_filter ()
public function integer of_print ()
public function integer of_get_facility_data ()
public function integer of_retrieve_priv (long ai_pracid)
public function integer of_priv_batch (string as_type, long al_prac, integer ai_facil)
public function integer of_bg_color (long al_rgb)
public function integer of_priv_security ()
public function integer of_selectproctor ()
public function integer of_post_resize ()
public function integer of_reset ()
public function integer of_get_form ()
public function integer of_get_word_form (long al_prac, long al_facil, long al_area)
public subroutine of_zoom ()
end prototypes

event pfc_cst_priv_batch();of_priv_batch("U",il_prac,il_facil)

end event

public function integer of_browse_filter ();string ls_filter = ""
integer li_rtnval

ls_filter = is_clinfilter

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.20.2006 By: LeiWei
//$<reason> Fix a defect
//if ls_filter = "" then 
//	ls_filter = is_currfilter
//elseif ls_filter <> "" then 	
//	ls_filter = ls_filter + " and " + is_currfilter
//end if
if isnull(ls_filter) then ls_filter = ""
if isnull(is_currfilter) then is_currfilter = ""
if isnull(is_statusfilter) then is_statusfilter = ""

if ls_filter = "" then 
	ls_filter = is_currfilter
elseif ls_filter <> "" then 	
	if is_currfilter <> "" then
		ls_filter = ls_filter + " and " + is_currfilter
	end if
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11.21.2005 By: Cao YongWang
//$<reason> Fix a defect
//if is_statusfilter <> "" then
//	ls_filter = ls_filter + " and " + is_statusfilter
//end if
if is_statusfilter <> "" then
	If ls_filter <> "" Then
		ls_filter = ls_filter + " and " + is_statusfilter
	Else
		ls_filter = is_statusfilter
	End If
end if
//---------------------------- APPEON END ----------------------------

//messagebox("filter",ls_filter)
//li_rtnval = 
tab_1.tabpage_browse.dw_browse.setfilter(ls_filter)  
tab_1.tabpage_detail.dw_detail.setfilter(ls_filter)
//if li_rtnval = 1 then
	tab_1.tabpage_browse.dw_browse.filter()
	tab_1.tabpage_detail.dw_detail.filter()
//end if
//tab_1.tabpage_browse.dw_browse.sort()
st_recs.Text = "Record " + String( 1 ) + " of " + String( tab_1.tabpage_browse.dw_browse.RowCount() )

return 0
tab_1.selecttab (1)
tab_1.tabpage_detail.dw_detail.reset()

end function

public function integer of_print ();openwithparm(w_renew_priv_form,il_prac)
//openwithparm(w_renew_priv_form,il_facil)

return 0
end function

public function integer of_get_facility_data ();Integer li_found

li_found = dw_select.Find("parent_facility_id = " + String( gi_parent_facility ), 1, 1000 )

IF li_found > 0 THEN
	dw_select.ScrollToRow( li_found )
	dw_select.SetRow( li_found )
//	dw_select.SelectRow( 0, False )
//	dw_select.SelectRow( li_found, True )	
END IF

Return 0
end function

public function integer of_retrieve_priv (long ai_pracid);//debugbreak()
integer	li_row
	dw_select.settransobject(sqlca)
	dw_select.reset()	
	il_prac = ai_pracid
	dw_select.retrieve(ai_pracid,gs_user_id)
	post of_priv_security()  //Start Code Change ----10.18.2010 #V10 maha

Return 0
end function

public function integer of_priv_batch (string as_type, long al_prac, integer ai_facil);long prac[]

long app[]
integer facil[]
gs_batch_search lst_sent

prac[1] = al_prac
if as_type = "U" then
	app[1] = 2
elseif as_type = "R" then
	app[1] = 1
end if
facil[1] = ai_facil
lst_sent.li_prac_id[] = prac[]
lst_sent.ll_app[] = app[]
lst_sent.ll_facility[] = facil[]

openwithparm(w_batch_privilege_update,lst_sent)

return 1
end function

public function integer of_bg_color (long al_rgb);//Start Code Change ----06.08.2010 #V10 maha
this.backcolor = al_rgb
tab_1.backcolor = al_rgb
tab_1.tabpage_browse.backcolor = al_rgb
tab_1.tabpage_detail.backcolor = al_rgb
tab_1.tabpage_exp_priv.backcolor = al_rgb
gb_ca.backcolor = al_rgb
gb_filter.backcolor = al_rgb
gb_rs.backcolor = al_rgb
gb_ss.backcolor = al_rgb
st_recs.backcolor = al_rgb
rb_curr.backcolor = al_rgb
rb_hist.backcolor = al_rgb
rb_both.backcolor = al_rgb

return 1
end function

public function integer of_priv_security ();////Start Code Change ----09.24.2010 #V10 maha - added for readonly security.  Called from of_retrieve_priv (unable to get to work from the mdi folder security call)
string ls_mes


//Start Code Change ----09.12.2012 #V12 maha - no edit functionality
if  w_mdi.of_security_access( 7360 ) = 0 then //add but no edit
	tab_1.tabpage_detail.dw_detail.Modify( "notes.protect = '1'" )
end if
//End Code Change ----09.12.2012

if ii_rights = 2 then return 1 //full access

tab_1.tabpage_detail.dw_detail.enabled = true
tab_1.tabpage_exp_priv.dw_expired.enabled = true

ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "status_code.protect=1" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "start_date.protect=1" )
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "end_date.protect=1" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "ir_code.protect=1" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "active_status.protect=1" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "notes.protect=1" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "priv_core_procd_core_procd_description.protect=1" ) 
//Start Code Change ----10.10.2012 #V12 maha
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "num_performed.protect=1" )
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "proctor_name.protect=1" )
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "supervision_level.protect=1" )
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "pd_priv_list_has_opt_out.protect=1" )
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "b_proctor.enabled=false" )
//End Code Change ----10.10.2012


//ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "status_code.Background.Color='" + string(gl_dw_color) + "'" ) 
//set to transparent
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "status_code.Background.Color='553648127'" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "start_date.Background.Color='553648127'" )
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "end_date.Background.Color='553648127'" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "ir_code.Background.Color='553648127'") 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "active_status.Background.Color='553648127'" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "notes.Background.Color='553648127'" ) 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "priv_core_procd_core_procd_description.Background.Color='553648127'" ) 
//Start Code Change ----10.10.2012 #V12 maha
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "num_performed.Background.Color='553648127'") 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "proctor_name.Background.Color='553648127'") 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "supervision_level.Background.Color='553648127'") 
ls_mes = tab_1.tabpage_detail.dw_detail.Modify( "pd_priv_list_has_opt_out.Background.Color='553648127'")
//End Code Change ----10.10.2012
//gl_dw_color

return 1



end function

public function integer of_selectproctor ();//////////////////////////////////////////////////////////////////////
// $<function> of_SelectProctor
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 03.04.2011
//////////////////////////////////////////////////////////////////////

long ll_prac_id
string ls_full_name
gs_search lstr_search
gs_batch_search lstr_search_ret
datawindow ldw_data

ldw_data = tab_1.tabpage_detail.dw_detail
if ldw_data.GetRow() < 1 then Return -1

// Search practitioner
lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "PRIVILEGE"
OpenWithParm(w_extended_search_new , lstr_search)
lstr_search_ret = Message.PowerObjectParm
if IsNull(lstr_search_ret) then Return -1
if not IsValid(lstr_search_ret) then Return -1
if UpperBound(lstr_search_ret.li_prac_id) < 1 then Return -1

ll_prac_id = lstr_search_ret.li_prac_id[1]
select full_name into :ls_full_name from v_full_name where prac_id = :ll_prac_id;

// Set items from selection
ldw_data.SetItem(ldw_data.GetRow(), "proctor_id", ll_prac_id)
ldw_data.SetItem(ldw_data.GetRow(), "proctor_name", ls_full_name)
//------------------- APPEON BEGIN ------------------------
//$<add> Evan 04.12.2011
//$<reason> Make the proctor_name column cannot be modified
ldw_data.AcceptText()
ldw_data.SetColumn("supervision_level")
ldw_data.SetFocus()
//------------------- APPEON END --------------------------

Return 1
end function

public function integer of_post_resize ();//Start Code Change ----08.09.2012 #V12 maha

// X pos
 tab_1.y = 8
gb_filter.x = tab_1.x + 32
gb_ca.x = tab_1.x + 55
dw_clin_sel.x = gb_ca.x + 37
gb_rs.x = tab_1.x + 1143
rb_curr.x = tab_1.x + 1184
//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.07.2016
//<$>reason:v151 Font changed, BugL030701
//rb_hist.x = tab_1.x + 1458
//rb_curr.x = tab_1.x + 1184
rb_hist.x = tab_1.x + 1453
rb_both.x = tab_1.x + 1709
//------------------- APPEON END -------------------

gb_ss.x = tab_1.x + 1957
dw_status_sel.x = tab_1.x + 1998

// Y pos
gb_filter.y = tab_1.y + 116
gb_ca.y = tab_1.y + 172
dw_clin_sel.y = tab_1.y + 232
gb_rs.y = tab_1.y + 172
rb_curr.y = tab_1.y + 232
rb_hist.y = tab_1.y + 232
rb_both.y = tab_1.y + 232
gb_ss.y = tab_1.y + 172
dw_status_sel.y = tab_1.y + 232

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.06.2016
//<$>reason:BugL010601
tab_1.tabpage_detail.dw_detail.y = gb_filter.height + 16
tab_1.tabpage_detail.dw_detail.height = tab_1.height -  gb_filter.height - 164
//Start Code Change ----01.28.2016 #V15 maha
tab_1.tabpage_detail.dw_detail.width = tab_1.width - 48  
tab_1.tabpage_browse.dw_browse.width = tab_1.tabpage_detail.dw_detail.width 
tab_1.tabpage_exp_priv.dw_expired.width = tab_1.tabpage_detail.dw_detail.width
//End Code Change ----01.28.2016 
tab_1.tabpage_browse.dw_browse.y = tab_1.tabpage_detail.dw_detail.y
tab_1.tabpage_browse.dw_browse.height = tab_1.tabpage_detail.dw_detail.height
tab_1.tabpage_exp_priv.dw_expired.y = tab_1.tabpage_detail.dw_detail.y
//------------------- APPEON END -------------------

return 1
end function

public function integer of_reset (); //Start Code Change ----07.10.2015 #V15 maha - added called from of_reset_prac in w_prac_data_1
 tab_1.tabpage_browse.dw_browse.reset()
 
 return 1

end function

public function integer of_get_form (); //Start Code Change ----01.05.2017 #V153 maha - added
integer li_format
//integer r
//integer rc
integer ll_row
integer li_templ
integer li_cnt
//integer g
long ll_procd_id
long ll_prac
long ll_facil
long ll_area
datawindowchild ldwc_form
string ls_prac_name
string ls_stat
//n_ds lds_prac
//n_ds lds_form
u_dw dw_detail
gs_pass_ids lst_ids

debugbreak()
dw_detail = tab_1.tabpage_detail.dw_detail

//set variables
ll_prac = il_prac
ll_row = dw_detail.getrow()

if dw_detail.rowcount() > 0 then
	ll_row = dw_detail.getrow()
	ll_facil = dw_detail.getitemnumber(ll_row, "facility_id")
	ll_area = dw_detail.getitemnumber(ll_row, "clinical_area_id")
else
	ll_facil = dw_select.getitemnumber(dw_select.getrow(), "parent_facility_id")
	
	//get the priv template
	select priv_template into :li_templ from facility where facility_id = :ll_facil;
	if isnull( li_templ) or li_templ = 0 then
		messagebox("Privilege Form","There is no Privilege template selected for this Facility in the Facility Setup.")
		return 1
	else
		//allow user to select the CA
		openwithparm(w_select_clincopy, li_templ)
		ll_area = message.doubleparm
		if ll_area = 0 then return 1
	end if
end if	

//check to see if there is a word document available
select count(clinical_area_id) into :li_cnt from priv_ca_form where clinical_area_id = :ll_area and lower(form_type) in ('doc','docx');

if li_cnt > 0 then
	of_get_word_form(ll_prac, ll_facil, ll_area)
else
	//if no document then produce the form
	lst_ids.prac_id = ll_prac
	lst_ids.facility_id = ll_facil
	lst_ids.l_app_id = ll_area
	openwithparm(w_priv_form_view_prac, lst_ids )
end if

return 1
	
////get the format from priv setup
//SELECT alt_form  INTO :li_format   FROM facility,   priv_template  WHERE ( facility.priv_template = priv_template.template_id ) and facility.facility_id = :ll_facil;
//if isnull(li_format) then li_format = 0
//
////set the dwo
//lds_form = create n_ds	
//lds_prac  = create n_ds	
//	
//choose case li_format
//	case 1
//		lds_form.dataobject = "d_form_clin_priv_request_master_f2"
//	case 3
//		lds_form.dataobject = "d_form_clin_priv_request_master_f3"
//	case 4
//		lds_form.dataobject = "d_form_clin_priv_request_master_f4"
//	case -1
//		lds_form.dataobject = "d_form_clin_priv_request_master_f1_alt"	
//	case 5
//		lds_form.dataobject = "d_form_clin_priv_request_master_f5"	
//	case else
//		lds_form.dataobject = "d_form_clin_priv_request_master_f1"
//end choose
//
//lds_form.settransobject(sqlca)
////get form data
//lds_form.retrieve( ll_facil,  ll_area )
//
////modify forms
//lds_form.GetChild( "dw_2", ldwc_form )
//ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' )  //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
//lds_form.GetChild( "dw_3", ldwc_form )
//ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"')   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
//lds_form.GetChild( "dw_4", ldwc_form )
//ldwc_form.Modify('prac_name.text = "' + ls_prac_name + '"')   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
////		if of_get_app_setting("set_46","I") = 1 then
////			ldwc_form.Modify( "title1.text = 'Section Chief' " )
////			ldwc_form.Modify( "title2.text = 'Department Chair'" )
////			ldwc_form.Modify( "title3.text = 'Credentials Committee Chair'" )
////			ldwc_form.Modify( "title4.text = 'Secretary, Medical Executive Committee'" )
////			ldwc_form.Modify( "title5.text = 'Secretary, Inova Health Care Services Board'" )
////		end if
//lds_form.object.prac_footer.text = ls_prac_name  //Start Code Change ----07.27.2016 #V152 maha
//
//choose case li_format
//	case 1,3,4
//		//if lds_form.dataobject = 'd_form_clin_priv_request_master_f4' or  lds_form.dataobject = 'd_form_clin_priv_request_master_f3' or lds_form.dataobject = 'd_form_clin_priv_request_master_f2' then
//		lds_form.GetChild( "lds_form", ldwc_form )  //Start Code Change ----04.22.2016 #V15 maha
//		ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 		
//		lds_form.GetChild( "dw_3", ldwc_form )
//	case 5
//		//elseif  lds_form.dataobject = 'd_form_clin_priv_request_master_f5'  then 
//		lds_form.GetChild( "lds_form", ldwc_form )  
//		ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 
//	case else
//		//elseif lds_form.dataobject = 'd_form_clin_priv_request_master_inova' or lds_form.dataobject =  "d_form_clin_priv_request_master_f1" or  lds_form.dataobject =  "d_form_clin_priv_request_master_f1_alt" then
//		lds_form.GetChild( "dw_4", ldwc_form )
//
//end choose 
//
////set provider statuses		
//rc = ldwc_form.Rowcount()
//ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' )   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
//
//lds_prac.dataobject = "d_prac_priv_list_clin_area"
//lds_prac.settransobject(sqlca) //practitoner privs
//pc = lds_prac.retrieve(ll_prac,ll_facil)
//////Start Code Change ----12.16.2011 #V12 maha - removed at request of	Northwest Surgical Hospital (Tina) not sure of the logic to add originally
////		//Start Code Change ----11.04.2010 #V10 maha
////	if cbx_eff.checked then
////		fnd_r = lds_prac.find("status_code in (24478,24479)", 1, lds_prac.rowcount())
////		if fnd_r > 0 then
////			ldt_start = lds_prac.getitemdatetime(fnd_r,"start_date")
////			ldt_end = lds_prac.getitemdatetime(fnd_r,"end_date")
////			//ldwc_form.Modify( "start_date.visible =true'" ) //modify Michael 07.23.2012 Bug#3124:The Effective Dates are not populating
////			ldwc_form.Modify( "start_date.visible =true" )
////			ldwc_form.Modify( "start_date.text = '" + string(date(ldt_start)) + "'" )
////			//ldwc_form.Modify( "end_date.visible =true'" ) //modify Michael 07.23.2012 Bug#3124:The Effective Dates are not populating
////			ldwc_form.Modify( "end_date.visible =true" )
////			ldwc_form.Modify( "end_date.text = '" + string(date(ldt_end)) + "'" )
////		end if
////	else //add Michael 07.23.2012 Bug#3124:The Effective Dates are not populating
////		ldwc_form.Modify( "start_date.visible =false" )
////		ldwc_form.Modify( "end_date.visible =false" )
////	end if
////	//Start Code Change ----11.04.2010
//////End Code Change ----12.16.2011		
//
//choose case li_format
//	case 1,3,4
//		lds_form.GetChild( "dw_3", ldwc_form )
//	case else
//		lds_form.GetChild( "dw_1", ldwc_form )
//end choose
//
//	//---------Begin Added by (Appeon)Stephen 04.30.2015 for V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form--------
////	if lds_form.dataobject = 'd_form_clin_priv_request_master_inova' or lds_form.dataobject =  "d_form_clin_priv_request_master_f1" or  lds_form.dataobject =  "d_form_clin_priv_request_master_f1_alt" &
////		or lds_form.dataobject = 'd_form_clin_priv_request_master_f5' then//Format 5, Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
////		lds_form.GetChild( "lds_form", ldwc_form )		
////	elseif lds_form.dataobject = 'd_form_clin_priv_request_master_f4' or  lds_form.dataobject = 'd_form_clin_priv_request_master_f3' or lds_form.dataobject = 'd_form_clin_priv_request_master_f2' then
////		lds_form.GetChild( "dw_3", ldwc_form )	
////	else
////		lds_form.GetChild( "lds_form", ldwc_form )	
////	end if
//
//
//rc = ldwc_form.Rowcount()
//	//---------End Added ------------------------------------------------------
//	
//for r = 1 to rc
//	ll_procd_id = ldwc_form.getitemnumber(r,"procd_id")
//	g = 0
//	g = lds_prac.find("procd_id = " + string(ll_procd_id) ,1,pc)
//
//	if g > 0 then
//		ls_stat = lds_prac.getitemstring(g,"code")
//		ldwc_form.setitem(r,"facility_zip",ls_stat) 
//	elseif g < 0 then
//		messagebox("Find error in of_get_form function","Contact IntelliSoft Support")
//		return -1
//	else
//		ldwc_form.setitem(r,"facility_zip","") 
//	end if
//next
//
//open(w_priv_form_view_prac)
//w_priv_form_view_prac.dw_1.dataobject = lds_form.dataobject
//w_priv_form_view_prac.dw_1.settransobject(sqlca)
//lds_form.sharedata(w_priv_form_view_prac.dw_1)
//
////destroy lds_form
////destroy lds_prac



end function

public function integer of_get_word_form (long al_prac, long al_facil, long al_area); //Start Code Change ----01.10.2017 #V153 maha - added
 
blob lblb_Data
string ls_form_type
string ls_DocPath
string ls_DocName
string ls_path
string ls_datasource  //maha 01.10.2017
long ll_Row
long ll_clinical_area_id
long ll_len
n_cst_dm_utils lnv_file
str_add_doc lstr_add_doc

//get file type
SELECT form_type INTO :ls_form_type FROM priv_ca_form WHERE clinical_area_id = :al_area;

ll_clinical_area_id = al_area

// Download file from database
ls_DocName = "priv_document" + string(al_area) + "." + ls_form_type
ls_path = of_letter_paths("L")
ls_DocPath = ls_path + ls_DocName

lblb_Data = of_Download_File("PRIVFORM", "", ll_clinical_area_id)
ll_len = lenA(lblb_Data)

if lnv_file.of_SaveBlob(ls_DocPath, lblb_Data) <> 1 then
	MessageBox("View Privilege Form", "Failed to write file: " + ls_DocPath, StopSign!)
	Return -1
end if

//create datasource
ls_datasource = of_priv_data_source_800(al_area, al_facil, al_prac)
//messagebox("",ls_datasource)
if ls_datasource = "FAILED" then return -1

// Open document
if not FileExists(ls_datasource) then
	messagebox("Privilege Document","There is no datasource for this document.")
	return -1
end if

lstr_add_doc.doc_from_name = ls_DocPath
lstr_add_doc.Filename = ls_datasource
//openwithparm(w_priv_document_preview, lstr_add_doc)

//nv_app.gnvlo_msword.of_open_word_document( ls_DocPath,ls_datasource,"Privileges")
//messagebox(ls_DocPath,ls_datasource)
of_open_letter(ls_DocPath,ls_datasource,"Privileges")

 
 return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha - added for font increase
tab_1.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_detail.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
dw_select.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_exp_priv.dw_expired.Modify("DataWindow.Zoom=" + string(gi_zoom))  
end subroutine

on uo_priv_data_ent.create
this.cb_wv_movckup=create cb_wv_movckup
this.gb_ss=create gb_ss
this.gb_rs=create gb_rs
this.gb_ca=create gb_ca
this.gb_filter=create gb_filter
this.p_1=create p_1
this.dw_select=create dw_select
this.st_recs=create st_recs
this.tab_1=create tab_1
this.rb_curr=create rb_curr
this.rb_hist=create rb_hist
this.rb_both=create rb_both
this.dw_status_sel=create dw_status_sel
this.dw_clin_sel=create dw_clin_sel
this.Control[]={this.cb_wv_movckup,&
this.gb_ss,&
this.gb_rs,&
this.gb_ca,&
this.gb_filter,&
this.p_1,&
this.dw_select,&
this.st_recs,&
this.tab_1,&
this.rb_curr,&
this.rb_hist,&
this.rb_both,&
this.dw_status_sel,&
this.dw_clin_sel}
end on

on uo_priv_data_ent.destroy
destroy(this.cb_wv_movckup)
destroy(this.gb_ss)
destroy(this.gb_rs)
destroy(this.gb_ca)
destroy(this.gb_filter)
destroy(this.p_1)
destroy(this.dw_select)
destroy(this.st_recs)
destroy(this.tab_1)
destroy(this.rb_curr)
destroy(this.rb_hist)
destroy(this.rb_both)
destroy(this.dw_status_sel)
destroy(this.dw_clin_sel)
end on

event constructor;of_zoom()  //Start Code Change ----07.13.2017 #V154 maha
end event

type cb_wv_movckup from commandbutton within uo_priv_data_ent
boolean visible = false
integer x = 2222
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "WV Mockup"
end type

event clicked;gs_pass_ids lst_ids

if tab_1.tabpage_browse.dw_browse.rowcount() = 0 then return

lst_ids.i_ids[1] = il_prac
lst_ids.i_ids[2] = il_facil
lst_ids.i_ids[3] = tab_1.tabpage_browse.dw_browse.getitemnumber(1,"clinical_area_id")

openwithparm(w_pracview_priv_mockup, lst_ids)
end event

type gb_ss from groupbox within uo_priv_data_ent
integer x = 2885
integer y = 172
integer width = 722
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Select Status"
end type

type gb_rs from groupbox within uo_priv_data_ent
integer x = 2071
integer y = 172
integer width = 795
integer height = 168
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Record Status"
end type

type gb_ca from groupbox within uo_priv_data_ent
integer x = 983
integer y = 172
integer width = 1065
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Select Clinical Area"
end type

type gb_filter from groupbox within uo_priv_data_ent
integer x = 946
integer y = 116
integer width = 2693
integer height = 256
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Filter"
end type

type p_1 from picture within uo_priv_data_ent
boolean visible = false
integer x = 1906
integer y = 4
integer width = 78
integer height = 72
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type dw_select from u_dw within uo_priv_data_ent
integer x = 9
integer width = 905
integer height = 2060
integer taborder = 40
string title = "Select Facility"
string dataobject = "d_pd_affil_status_orgs_priv"
boolean hscrollbar = true
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	tab_1.tabpage_detail.dw_detail.SetFocus( )
	Return -1
END IF

//This.SelectRow( 0, False )
//This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )


long ll_core



end event

event rowfocuschanged;call super::rowfocuschanged;//debugbreak()
//traceopen("c:\tracefile",clock!)
//TraceEnableActivity(ActESQL!)
//Tracebegin("startttttt")
//messagebox("","RFC")
Integer li_row
integer r
integer r2
Integer li_template_id

li_row = dw_select.getrow()
if li_row < 1 then return
gi_facil_change = dw_select.getitemnumber(li_row,"parent_facility_id")
il_facil = gi_facil_change
tab_1.tabpage_browse.dw_browse.settransobject(sqlca)
//tab_1.tabpage_detail.dw_detail.settransobject(sqlca)
//tab_1.tabpage_detail.dw_detail.retrieve(gl_prac_id,gi_facil_change)
//r = tab_1.tabpage_browse.dw_browse.retrieve(gl_prac_id,gi_facil_change)
	r = 	tab_1.tabpage_detail.dw_detail.settransobject(sqlca)
		tab_1.tabpage_detail.dw_detail.retrieve(il_prac,gi_facil_change)//added 12-12-00 maha
		tab_1.tabpage_detail.dw_detail.ShareData( tab_1.tabpage_browse.dw_browse )
		tab_1.tabpage_detail.dw_detail.setrow(1)
		tab_1.tabpage_detail.dw_detail.scrolltorow(1)
if r > 0 then
	tab_1.tabpage_browse.dw_browse.setrow(1)
//	tab_1.tabpage_browse.dw_browse.selectrow(0,false)
//	tab_1.tabpage_browse.dw_browse.selectrow(1,true)	
end if
tab_1.tabpage_browse.dw_browse.setfocus() //moved from if above 022703
tab_1.tabpage_exp_priv.dw_expired.settransobject(sqlca)
//r2 = tab_1.tabpage_exp_priv.dw_expired.Retrieve(gl_prac_id,gi_facil_change)
if r2 > 0 then
	tab_1.tabpage_exp_priv.enabled = true
else 
	tab_1.tabpage_exp_priv.enabled = false
end if
//set dw clin dropdown
//debugbreak()
dw_clin_sel.settransobject(sqlca)
DataWindowChild dwchild

//dw_clin_sel.retrieve()


//--------Begin Modified by  Nova 04.12.2010------------------------
//dw_clin_sel.GetChild( "clinical_area_description", dwchild )
dw_clin_sel.GetChild( "clinical_area_id", dwchild )
//--------End Modified --------------------------------------------

dwchild.settransobject(sqlca)

//Begin --Modified by Appeon long.zhang 09.04.2014 (V14.2 Testing Bug # 4178 The Select Clinical Area drop down is only showing ALL)

//dwchild.retrieve(gi_facil_change)
select priv_template into :li_template_id from facility where facility_id = :gi_facil_change; //Add by Evan 03.07.2011
dwchild.retrieve(li_template_id)
//end --Modified by Appeon long.zhang 09.04.2014

dwchild.insertrow(1)
dwchild.setitem(1,"clinical_area_description","All")
dwchild.setitem(1,"clinical_area_id","0")
dw_clin_sel.insertrow(1)
//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.05.2011
//$<reason> Fixed a bug.
//of_browse_filter()
string ls_null
setnull(ls_null)
dw_clin_sel.Event ItemChanged(1, dw_clin_sel.object.clinical_area_id, ls_null)
//------------------- APPEON END ---------------------

if this.rowcount() > 0 then
//cb_add.enabled = true
end if
//Traceend()

end event

event retrieveend;call super::retrieveend;of_get_facility_data()
end event

event pfc_predeleterow;call super::pfc_predeleterow;Return PREVENT_ACTION //Add by Evan 07.10.2009(Corrected BugN062904) --- The facility here shouldn't be deleted
end event

type st_recs from statictext within uo_priv_data_ent
integer x = 2976
integer y = 20
integer width = 485
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
string text = "Record 1 of 1"
boolean focusrectangle = false
end type

type tab_1 from tab within uo_priv_data_ent
integer x = 923
integer width = 2793
integer height = 2060
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_exp_priv tabpage_exp_priv
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_exp_priv=create tabpage_exp_priv
this.Control[]={this.tabpage_browse,&
this.tabpage_detail,&
this.tabpage_exp_priv}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_exp_priv)
end on

event selectionchanged;//long ll_area
//integer ll_core
//integer li_end
//integer li_row
//
//if newindex = 2 then
//	if tab_1.tabpage_browse.dw_browse.rowcount() = 0 then return
//		//ll_area = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),"pd_priv_list_clinical_area_id")//removed 12-12-00 maha
//		//messagebox("ll_core", ll_core)
//	li_row = tab_1.tabpage_browse.dw_browse.getrow()
//	//ll_core = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),"priv_core_procd_procd_name")
//	//li_end = tab_1.tabpage_detail.dw_detail.rowcount() + 1
//	//li_row = tab_1.tabpage_detail.dw_detail.find( "priv_core_id = " + string(ll_core), 1, li_end )
//
//	tab_1.tabpage_detail.dw_detail.ScrollToRow( li_row )
//	tab_1.tabpage_detail.dw_detail.SetRow( li_row )
//	tab_1.tabpage_detail.dw_detail.setfocus()
//	tab_1.tabpage_detail.dw_detail.setcolumn("status_code")
//	st_recs.Text = "Record " + string(li_row) + " of " + String(tab_1.tabpage_detail.dw_detail.RowCount())
//end if
//
//if newindex = 1 then 
//st_recs.Text = "Record " + String(tab_1.tabpage_browse.dw_browse.getrow()) + " of " + String(tab_1.tabpage_browse.dw_browse.RowCount())
//end if

//if newindex = 3 then
//	rb_both.visible = false
//	rb_curr.visible = false
//	rb_hist.visible = false
//	gb_ca.visible = false
//	gb_ss.visible = false
//	gb_filter.visible = false //maha 08.09.2012
//	dw_clin_sel.visible = false
//	dw_status_sel.visible = false
//	tab_1.tabpage_exp_priv.cb_renew.visible = true
//	st_recs.Text = "Record " + String(tab_1.tabpage_exp_priv.dw_expired.getrow()) + " of " + String(tab_1.tabpage_exp_priv.dw_expired.RowCount())
//else
//	gb_filter.visible = true
//	gb_ca.visible = true
//	gb_ss.visible = true
//	rb_both.visible = true
//	rb_curr.visible = true
//	rb_hist.visible = true
//	dw_clin_sel.visible = true
//	dw_status_sel.visible = true
//	tab_1.tabpage_exp_priv.cb_renew.visible = false
//end if 
end event

type tabpage_browse from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2757
integer height = 1944
boolean border = true
long backcolor = 32891346
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 553648127
dw_browse dw_browse
gb_3 gb_3
r_2 r_2
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.gb_3=create gb_3
this.r_2=create r_2
this.Control[]={this.dw_browse,&
this.gb_3,&
this.r_2}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
destroy(this.gb_3)
destroy(this.r_2)
end on

type dw_browse from u_dw within tabpage_browse
integer x = 14
integer y = 272
integer width = 2729
integer height = 1656
integer taborder = 11
string dataobject = "d_priv_brow_clin_area"
boolean hscrollbar = true
boolean border = false
boolean livescroll = false
end type

event clicked;call super::clicked;
Integer li_row

li_row = This.GetClickedRow( )

IF li_row < 1 THEN
	Return
END IF

//Start Code Change ----04.05.2017 #V153 maha - modified
tab_1.tabpage_detail.dw_detail.setrow(li_row)
tab_1.tabpage_detail.dw_detail.scrolltorow(li_row)

This.ScrollToRow( li_row )
This.SetRow( li_row )

st_recs.Text = "Record " + string(li_row) + " of " + String(this.RowCount())   
//Start Code Change ----04.05.2017 
//this.selectrow(0,false)
//this.selectrow(li_row,true)

end event

event doubleclicked;call super::doubleclicked;
long ll_core
integer li_row
integer li_end

if this.rowcount() > 0 then
	tab_1.selecttab (2)
	
end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//IF tab_1.tabpage_detail.dw_detail.RowCount() >= currentrow THEN
	//tab_1.tabpage_detail.dw_detail.SetRow( currentrow )
	//tab_1.tabpage_detail.dw_detail.ScrollToRow( currentrow )
//END IF
//this.selectrow(0,false)
//this.selectrow(this.getrow(),true)

st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_addrow;call super::pfc_addrow;
tab_1.tabpage_detail.dw_detail.setfocus()

return 1
end event

event pfc_deleterow;
integer res

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	this.deleterow(this.getrow())
end if

this.update()

return 0
end event

type gb_3 from groupbox within tabpage_browse
boolean visible = false
integer x = 1792
integer y = 1676
integer width = 2629
integer height = 260
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 79741120
string text = "Filter"
end type

type r_2 from rectangle within tabpage_browse
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 79741120
integer x = 1888
integer y = 2312
integer width = 2606
integer height = 224
end type

type tabpage_detail from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2757
integer height = 1944
boolean border = true
long backcolor = 32891346
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 553648127
dw_detail dw_detail
r_3 r_3
end type

on tabpage_detail.create
this.dw_detail=create dw_detail
this.r_3=create r_3
this.Control[]={this.dw_detail,&
this.r_3}
end on

on tabpage_detail.destroy
destroy(this.dw_detail)
destroy(this.r_3)
end on

type dw_detail from u_dw within tabpage_detail
integer x = 9
integer y = 280
integer width = 2729
integer height = 1648
integer taborder = 11
string dataobject = "d_priv_list_d_entry"
boolean border = false
end type

event clicked;call super::clicked;
Integer li_row

li_row = This.GetClickedRow( )

IF li_row < 1 THEN
	Return
END IF

//Start Code Change ----04.05.2017 #V153 maha - modified
This.ScrollToRow( li_row )
This.SetRow( li_row )

tab_1.tabpage_browse.dw_browse.setrow(li_row)
tab_1.tabpage_browse.dw_browse.scrolltorow(li_row)

st_recs.Text = "Record " + string(li_row) + " of " + String(this.RowCount())   
//Start Code Change ----04.05.2017 

//Start Code Change ----02.08.2016 #V15 maha - moved from buttonclicked
choose case dwo.name
	case "b_proctor"
		of_SelectProctor()	
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
end choose
//End Code Change ----02.08.2016 


end event

event constructor;call super::constructor;This.SetRowFocusIndicator( p_1)
this.settransobject(sqlca) //Start Code Change ----10.14.2010 #V10 maha

this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

 //Start Code Change ----10.27.2015 #V15 maha
if w_mdi.of_security_access( 7799 ) = 0 then
	this.modify( "pd_priv_list_priv_text.protect = 0")
	this.modify( "pd_priv_list_priv_text.Edit.DisplayOnly=False")
end if
 //End Code Change ----10.27.2015
  
//---------Begin Added by (Appeon)Stephen 11.16.2016 for Bug 5412: Supervision Level on the Practitioner Privileges screen cannot be cleared--------
DataWindowChild ldwc_1
this.GetChild("supervision_level", ldwc_1)
ldwc_1.SetTransObject(SQLCA)
ldwc_1.Retrieve('Privilege Supervision Level')
ldwc_1.insertrow(1)
//---------End Added ------------------------------------------------------
end event

event pfc_addrow;call super::pfc_addrow;integer li_rows
integer li_newrow
integer li_ir_stat
integer r
integer li_rowcount
integer checkrow
integer res

long ll_recno
long ll_procd
long ll_core
long ll_clin
long ll_luid  //maha 03.09.2012
long ll_appt_id //maha 01.07.2013
long ll_code

string ls_clin
string ls_core
string ls_procd

g_str_clin_info lstr_priv

date ld_start
date ld_end
date nulldate

tab_1.selecttab (2)

//Start Code Change ----02.28.2008 #V8 maha - modified to allow granted selects in add screen (lehigh)
//openwithparm(w_clin_area_select,"P*" + string(il_facil))
openwithparm(w_clin_area_select,"P*" + string(il_facil) + "@" + string(il_prac) )
//End Code Change---02.28.2008

setnull(nulldate)
lstr_priv = message.powerobjectparm
//debugbreak()
if isnull(lstr_priv) then return 0

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.23.2006 By: Liang QingShi
//$<reason> Fix a defect.
if upperbound(lstr_priv.priv_ids[]) <= 0 then 
	of_browse_filter()
	return 0
end if
//---------------------------- APPEON END ----------------------------

li_rowcount = lstr_priv.row_count
//messagebox("li_rowcount",li_rowcount)
ll_clin = lstr_priv.clin_id
ll_code = lstr_priv.stat
li_ir_stat = lstr_priv.appnt
//messagebox("start",string(lstr_priv.dstart))
//messagebox("end",string(lstr_priv.dend))
if string(lstr_priv.dstart) = "1/1/1900" then
	//messagebox("1/1/1900","1/1/1900")
	ld_start = nulldate
else
	//messagebox("1/1/1900","else")
	ld_start = lstr_priv.dstart
end if
if string(lstr_priv.dend) = "1/1/1900" then
	ld_end  = nulldate
else
	ld_end = lstr_priv.dend
end if


tab_1.tabpage_detail.dw_detail.settransobject(sqlca)
tab_1.tabpage_detail.dw_detail.reset()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.17.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> 1)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//$<modification> 2)Use a datastore to retrieve data from the database instead of using SQLs in the loops in PT-03.

n_ds lds_prac
long ll_find

lds_prac = create n_ds
lds_prac.dataobject = "d_priv_core_procd_all"
lds_prac.of_settransobject(SQLCA)

gnv_appeondb.of_startqueue()
lds_prac.retrieve(lstr_priv.priv_ids[])	
//---------------------------- APPEON END ----------------------------

	
SELECT Max( pd_priv_list.rec_id )
	INTO :ll_recno  
	FROM pd_priv_list;
//--------------------------- APPEON BEGIN ---------------------------
//Start Code Change ----01.07.2013 #V12 maha
Select top 1 rec_id into :ll_appt_id from pd_affil_stat where prac_id = :il_prac and parent_facility_id  = :gi_facil_change and active_status in (1,4) order by rec_id desc;
//$<ID> PT-02
//$<modify> 02.17.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

if isnull(ll_recno) then ll_recno = 0

for r = 1 to li_rowcount
	checkrow = 0
	ll_procd = lstr_priv.priv_ids[r]

	//create new row
	tab_1.tabpage_detail.dw_detail.insertrow (r)	
		
 
	
	ll_recno++

	ll_find = lds_prac.find("priv_core_procd_procd_id="+string(ll_procd),1,lds_prac.rowcount())
	If ll_find > 0 then ll_core = lds_prac.getitemnumber(ll_find , 'priv_core_procd_priv_core_id')
	//---------------------------- APPEON END ----------------------------

	//messagebox("ll_core ",ll_core )
	tab_1.tabpage_detail.dw_detail.setitem(r,"rec_id",ll_recno)
	tab_1.tabpage_detail.dw_detail.setitem(r,"facility_id",gi_facil_change)
	tab_1.tabpage_detail.dw_detail.setitem(r,"prac_id",il_prac) //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable
//	il_clin = dw_store.getitemnumber(li_newrow,"priv_core_clinical_area_id")
	tab_1.tabpage_detail.dw_detail.setitem(r,"clinical_area_id",ll_clin)
	tab_1.tabpage_detail.dw_detail.setitem(r,"priv_core_id",ll_core)
	tab_1.tabpage_detail.dw_detail.setitem(r,"procd_id",ll_procd)
	tab_1.tabpage_detail.dw_detail.setitem(r,"active_status",1)
	tab_1.tabpage_detail.dw_detail.Setitem(r,"ir_code",li_ir_stat)
	if string(lstr_priv.dstart) <> "1/1/1900" then
		tab_1.tabpage_detail.dw_detail.Setitem(r,"start_date",ld_start)
	end if
	if string(lstr_priv.dend) <> "1/1/1900" then
		tab_1.tabpage_detail.dw_detail.Setitem(r,"end_date",ld_end)
	end if

	If ll_find > 0 then 
		ls_core = lds_prac.GetItemString(ll_find , 'priv_core_priv_core_description')
		ls_procd = lds_prac.GetItemString(ll_find , 'priv_core_procd_core_procd_description')
		ll_luid =  lds_prac.GetItemnumber(ll_find , 'procd_lookup_id')  //Start Code Change ----03.09.2012 #V12 maha
	End If
	//---------------------------- APPEON END ----------------------------

	//ls_procd = dw_store.getitemstring(li_newrow,"core_procd_description")
	tab_1.tabpage_detail.dw_detail.setitem(r,"pd_priv_list_priv_text",ls_procd)

	tab_1.tabpage_detail.dw_detail.setitem(r,"status_code",ll_code)
	tab_1.tabpage_detail.dw_detail.setitem(r,"enter_date",datetime(today(),now()))
	//ls_core = dw_store.getitemstring(li_newrow,"priv_core_priv_core_description")
	tab_1.tabpage_detail.dw_detail.setitem(r,"priv_core_priv_core_description",ls_core)
	tab_1.tabpage_detail.dw_detail.setitem(r,"procd_lookup_id",ll_luid) //Start Code Change ----03.09.2012 #V12 maha
	
	
NEXT
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 02.17.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

of_add_audit_priv_prac(  "PracAdd",  this,0) //Start Code Change ----12.09.2009 #V92 maha - for audit


res = this.update()

commit using sqlca;

//messagebox("","")
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-07-05 By: Liu Hongxin
//$<reason> Fix Bug: Overlap with the next clause.
/*
this.retrieve(gl_prac_id,gi_facil_change)
*/
//---------------------------- APPEON END ----------------------------

tab_1.tabpage_browse.dw_browse.retrieve(il_prac,gi_facil_change) //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 02.17.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

st_recs.Text = "Record " + string(1) + " of " + String(this.RowCount())


return 1
end event

event pfc_deleterow;integer res
integer r
long ll_recid

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	r = this.getrow()
	of_add_audit_priv_prac( "PracDel", this, r) //Start Code Change ----12.10.2009 #V10 maha - auditing
	//Start Code Change ----07.24.2014 #V14.2 maha - addr linked data
	ll_recid = this.getitemnumber(r,"rec_id")
	delete from pd_addr_priv_link where priv_recid = :ll_recid;
	//End Code Change ----07.24.2014
	this.deleterow(r)
end if
this.update()

st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
return 0


end event

event rowfocuschanged;call super::rowfocuschanged;st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_postupdate;call super::pfc_postupdate;tab_1.tabpage_browse.dw_browse.retrieve(il_prac,gi_facil_change) //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable
return 1
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

//Start Code Change ----06.08.2011 #V11 maha - ability to clear proctor
if dwo.name  = 'b_proctor' then
	ret = messagebox("Clear?","Would you like to clear the proctor?",question!,yesno!,2 )
	if ret = 1 then
		setnull(colname)
		setnull(col)
		this.setitem(row,"proctor_id",col)
		this.setitem(row,"proctor_name",colname)
	end if
//Start Code Change ----06.08.2011	
else
	col = this.getclickedcolumn()
	colname = this.getcolumnname() 
	
	if this.Describe( colname + ".ColType") = "datetime" THEN
		//messagebox("dt","dt")
		ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
		if ret = 1 then
			this.setitem(row,col,dtn)
		end if
	END IF

END IF
end event

event retrieveend;call super::retrieveend;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04/11/2008 By: Ken.Guo
//$<reason> For Workaround APB Bug26914. Refresh ShareData DW's ComputerColumn UI. 
If This.Rowcount() > 0 Then
	This.Object.priv_clinical_area_clinical_area_descrip[1] = This.Object.priv_clinical_area_clinical_area_descrip[1]
	this.SetItemStatus(1, "priv_clinical_area_clinical_area_descrip", Primary!, NotModified!) //Add by Evan 03.08.2011
End If
//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ----12.10.2009 #V10 maha - auditing
of_add_audit_priv_prac( "Prac", this,0)

return 1
end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttonclicked
// $<arguments>
//		long	row
//		long	actionreturncode
//		dwobject	dwo
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 03.04.2011
//////////////////////////////////////////////////////////////////////
//Start Code Change ----02.08.2016 #V15 maha - moved to clicked event
//choose case dwo.name
//	case "b_proctor"
//		of_SelectProctor()	
//	case "b_notes"
//		this.SetColumn("notes")
//		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
//
//		//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
//		//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
//		string ls_notes
//		ls_notes = This.GetItemString( row, "notes" )
//		if isnull(ls_notes) then ls_notes = ""
//		OpenWithParm( w_ai_notes_new, ls_notes)
//		//---------End Modfiied ------------------------------------------------------
//		//OpenWithParm(w_ai_notes, this.GetItemString(Row, "notes"))		
//		if Message.StringParm <> "Cancel" then
//			this.SetItem(Row, "notes", Message.StringParm)
//		end if
//end choose
//End Code Change ----02.08.2016 
end event

event doubleclicked;call super::doubleclicked;long ll_id
integer r

if row < 1 then return//Added by Appeon long.zhang 01.08.2016 (BugL010803)

ll_id = this.getitemnumber(row,"rec_id")

openwithparm(w_priv_prac_detail,string(ll_id) + "*Data")

 //Start Code Change ----10.27.2015 #V15 maha - changed detail window to response, allow update, re-retrieve data
if message.stringparm = "MOD" then
	this.retrieve(il_prac,il_facil)
	r = this.find( "rec_id = " + string(ll_id), 1,this.rowcount())
	if r > 0 then
		this.scrolltorow(r)
		this.setrow(r)
	end if
end if
 //End Code Change ----10.27.2015 



end event

type r_3 from rectangle within tabpage_detail
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 79741120
integer x = 22848
integer width = 2286
integer height = 228
end type

type tabpage_exp_priv from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 2757
integer height = 1944
boolean enabled = false
boolean border = true
long backcolor = 16777215
string text = "Expiring"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_1 cb_1
dw_expired dw_expired
cb_renew cb_renew
end type

on tabpage_exp_priv.create
this.cb_1=create cb_1
this.dw_expired=create dw_expired
this.cb_renew=create cb_renew
this.Control[]={this.cb_1,&
this.dw_expired,&
this.cb_renew}
end on

on tabpage_exp_priv.destroy
destroy(this.cb_1)
destroy(this.dw_expired)
destroy(this.cb_renew)
end on

type cb_1 from commandbutton within tabpage_exp_priv
boolean visible = false
integer x = 1755
integer y = 24
integer width = 480
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Request Sheet"
end type

event clicked;open(w_renew_priv_form)
end event

type dw_expired from u_dw within tabpage_exp_priv
integer x = 5
integer y = 276
integer width = 2697
integer height = 1212
integer taborder = 11
string dataobject = "d_priv_list_expired"
boolean border = false
end type

event clicked;call super::clicked;
Integer li_row

li_row = This.GetClickedRow( )

IF li_row < 1 THEN
	Return
END IF


This.ScrollToRow( li_row )
This.SetRow( li_row )

end event

event constructor;call super::constructor;This.SetRowFocusIndicator( p_1 )
end event

event rowfocuschanged;call super::rowfocuschanged;
st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

type cb_renew from commandbutton within tabpage_exp_priv
boolean visible = false
integer x = 2254
integer y = 24
integer width = 421
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Renew Privileges"
end type

event clicked;//integer i
//integer rcount
//integer n
//integer checkrow
//integer li_rows
//integer li_newrow
//long ll_recno
//long ll_procd
//long ll_core
//integer li_ir_stat
//string ls_procd
//long ll_clin
//string ls_core
//integer r
//long prac[]
//long app[]
//integer facil[]
//gs_batch_search lst_sent
//
//prac[1] = il_prac
//app[1] = 1
//facil[1] = il_facil
//lst_sent.li_prac_id[] = prac[]
//lst_sent.ll_app[] = app[]
//lst_sent.ll_facility[] = facil[]
//
//openwithparm(w_batch_privilege_update,lst_sent)
of_priv_batch("R",il_prac,il_facil)
//
//lstr_priv = message.powerobjectparm
//
//if isnull(lstr_priv) then return
//
//li_rowcount = lstr_priv.row_count
//if li_rowcount < 1 then return
////messagebox("li_rowcount",li_rowcount)
//ll_clin = lstr_priv.clin_id
//li_ir_stat = lstr_priv.appnt
////messagebox("li_ir_stat",li_ir_stat)
//
//tab_1.tabpage_detail.dw_detail.settransobject(sqlca)
//tab_1.tabpage_detail.dw_detail.reset()
//
//for r = 1 to li_rowcount
//	checkrow = 0
//	ll_procd = lstr_priv.priv_ids[r]
////update status if record already exists
//	select pd_priv_list.rec_id
//	into :checkrow
//	from pd_priv_list
//	where pd_priv_list.procd_id = :ll_procd and pd_priv_list.prac_id = :gl_prac_id and pd_priv_list.facility_id = :gi_facil_change and pd_priv_list.active_status = 1;
////checkrow = tab_1.tabpage_detail.dw_detail.find("procd_id = " + string(ll_procd),1,tab_1.tabpage_detail.dw_detail.rowcount())
//if checkrow > 0 then
//	update pd_priv_list
//	set active_status = 0
//	where pd_priv_list.rec_id = :checkrow;
//end if
//
//	//create new row
//	tab_1.tabpage_detail.dw_detail.insertrow (r)	
//		
//	SELECT Max( pd_priv_list.rec_id )
//	INTO :ll_recno  
//	FROM pd_priv_list;
//	if isnull(ll_recno) then ll_recno = 0 
//	//messagebox("ll_recno",ll_recno)
//	ll_recno = ll_recno + r
//	//messagebox("ll_recno",ll_recno)
//	SELECT priv_core_procd.priv_core_id 
//	INTO :ll_core  
//	FROM priv_core_procd
//	where priv_core_procd.procd_id = :ll_procd;
//	//messagebox("ll_core ",ll_core )
//	tab_1.tabpage_detail.dw_detail.setitem(r,"rec_id",ll_recno)
//	tab_1.tabpage_detail.dw_detail.setitem(r,"facility_id",gi_facil_change)
//	tab_1.tabpage_detail.dw_detail.setitem(r,"prac_id",gl_prac_id)
////	il_clin = dw_store.getitemnumber(li_newrow,"priv_core_clinical_area_id")
//	tab_1.tabpage_detail.dw_detail.setitem(r,"clinical_area_id",ll_clin)
//	tab_1.tabpage_detail.dw_detail.setitem(r,"priv_core_id",ll_core)
//	tab_1.tabpage_detail.dw_detail.setitem(r,"procd_id",ll_procd)
//	tab_1.tabpage_detail.dw_detail.setitem(r,"active_status",1)
//	tab_1.tabpage_detail.dw_detail.Setitem(r,"ir_code",2)
//	//tab_1.tabpage_detail.dw_detail.Settext("Inital")
//
//	SELECT priv_core.priv_core_description 
//	INTO :ls_core  
//	FROM priv_core,priv_core_procd
//	WHERE priv_core.priv_core_id = priv_core_procd.priv_core_id AND priv_core_procd.procd_id = :ll_procd;
//	//messagebox("ls_core ", ls_core )
//
//	select code_lookup.lookup_code
//	into :ll_code
//	from code_lookup
//	where code_lookup.lookup_name = 'Privilege Status' and code = 'REQST';
//	tab_1.tabpage_detail.dw_detail.setitem(r,"status_code",ll_code)
//	//ls_core = dw_store.getitemstring(li_newrow,"priv_core_priv_core_description")
//	tab_1.tabpage_detail.dw_detail.setitem(r,"priv_core_priv_core_description",ls_core)
//	
//NEXT
//tab_1.tabpage_detail.dw_detail.update()
//commit using sqlca;
//
//tab_1.tabpage_browse.dw_browse.retrieve(gl_prac_id,gi_facil_change)
//tab_1.tabpage_detail.dw_detail.retrieve(gl_prac_id,gi_facil_change)
//
//
//if tab_1.tabpage_exp_priv.dw_expired.retrieve(gl_prac_id,gi_facil_change) > 0 then
//	tab_1.selecttab (3)
//else
//	tab_1.tabpage_exp_priv.enabled = false 
//end if
//
end event

type rb_curr from radiobutton within uo_priv_data_ent
integer x = 2094
integer y = 232
integer width = 261
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
string text = "Current"
boolean checked = true
end type

event clicked;integer li_row
long ll_status

ll_status = 1

is_currfilter = "active_status = " + string(ll_status)
if ll_status = 0 then is_currfilter = ""


of_browse_filter()

//messagebox("filter",is_browsefilter)

end event

event constructor;integer li_row
long ll_status

ll_status = 1

is_currfilter = "active_status = " + string(ll_status)

//messagebox("is_currfilter",is_currfilter)
of_browse_filter()

end event

type rb_hist from radiobutton within uo_priv_data_ent
integer x = 2363
integer y = 232
integer width = 261
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
string text = "History"
end type

event clicked;integer li_row
long ll_status

ll_status = 0

is_currfilter = "active_status = " + string(ll_status)


of_browse_filter()

//messagebox("is_currfilter",is_currfilter)
end event

type rb_both from radiobutton within uo_priv_data_ent
integer x = 2619
integer y = 232
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Both"
end type

event clicked;integer li_row
long ll_status



//is_currfilter = "(active_status = 1 or active_status = 0)"
is_currfilter = ""

of_browse_filter()

//messagebox("is_currfilter",is_currfilter)
end event

type dw_status_sel from datawindow within uo_priv_data_ent
integer x = 2912
integer y = 232
integer width = 663
integer height = 72
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_dddw_priv_status"
boolean border = false
boolean livescroll = true
end type

event constructor;dw_status_sel.settransobject(sqlca)
DataWindowChild dwchild

//dw_status_sel.retrieve()


dw_status_sel.InsertRow( 1 )
This.GetChild( "status_code", dwchild )
dwchild.settransobject(sqlca)

//dwchild.retrieve()


dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "All" )
dwchild.SetItem( 1, "lookup_code", "0" )




end event

event itemchanged;integer li_row
long ll_status

ll_status = long(data) //Start Code Change ---- 06.08.2007 #V7 maha corrected from integer

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.20.2006 By: LeiWei
//$<reason> Appeon deals with NULL value differently from that in PowerBuidler.
//$<modification> Set ll_status to 0 if it is null. 
If Isnull(ll_status) Then ll_status = 0
//---------------------------- APPEON END ----------------------------

is_statusfilter = "status_code = " + string(ll_status)
if ll_status = 0 then is_statusfilter = ""

of_browse_filter()

//messagebox("filter",is_browsefilter)

end event

type dw_clin_sel from datawindow within uo_priv_data_ent
integer x = 1015
integer y = 232
integer width = 987
integer height = 76
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dddw_clin_area"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer li_row

il_clin = integer(data)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 01.20.2006 By: LeiWei
//$<reason> Appeon deals with NULL value differently from that in PowerBuidler.
//$<modification> Set ll_status to 0 if it is null. 
If Isnull(il_clin) Then il_clin = 0
//---------------------------- APPEON END ----------------------------

is_clinfilter = "priv_core_clinical_area_id = " + string(il_clin)
if il_clin = 0 then is_clinfilter = "" 
if isnull(il_clin) then is_clinfilter = ""
of_browse_filter()
//messagebox("filter",is_browsefilter)

end event

event constructor;this.modify("clinical_area_description.visible='0'")
end event

