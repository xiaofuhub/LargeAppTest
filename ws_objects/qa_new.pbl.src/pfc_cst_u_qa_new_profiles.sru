$PBExportHeader$pfc_cst_u_qa_new_profiles.sru
forward
global type pfc_cst_u_qa_new_profiles from userobject
end type
type cb_2 from commandbutton within pfc_cst_u_qa_new_profiles
end type
type cb_save from commandbutton within pfc_cst_u_qa_new_profiles
end type
type cb_del from commandbutton within pfc_cst_u_qa_new_profiles
end type
type cb_add from commandbutton within pfc_cst_u_qa_new_profiles
end type
type cb_clear from commandbutton within pfc_cst_u_qa_new_profiles
end type
type dw_settings from u_dw within pfc_cst_u_qa_new_profiles
end type
type tab_measurments from tab within pfc_cst_u_qa_new_profiles
end type
type tabpage_data from userobject within tab_measurments
end type
type dw_pd_metrics from u_dw within tabpage_data
end type
type tabpage_data from userobject within tab_measurments
dw_pd_metrics dw_pd_metrics
end type
type tabpage_browse from userobject within tab_measurments
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_measurments
dw_browse dw_browse
end type
type tabpage_detail from userobject within tab_measurments
end type
type dw_measuremt_detail from u_dw within tabpage_detail
end type
type dw_measuremt_header from u_dw within tabpage_detail
end type
type tabpage_detail from userobject within tab_measurments
dw_measuremt_detail dw_measuremt_detail
dw_measuremt_header dw_measuremt_header
end type
type tabpage_report from userobject within tab_measurments
end type
type cb_about_comp from commandbutton within tabpage_report
end type
type ddlb_reports from dropdownlistbox within tabpage_report
end type
type dw_report from u_dw within tabpage_report
end type
type cb_3 from commandbutton within tabpage_report
end type
type cb_print from commandbutton within tabpage_report
end type
type st_2 from statictext within tabpage_report
end type
type cb_run from commandbutton within tabpage_report
end type
type tabpage_report from userobject within tab_measurments
cb_about_comp cb_about_comp
ddlb_reports ddlb_reports
dw_report dw_report
cb_3 cb_3
cb_print cb_print
st_2 st_2
cb_run cb_run
end type
type tabpage_action_items from userobject within tab_measurments
end type
type dw_actions from u_dw within tabpage_action_items
end type
type tabpage_action_items from userobject within tab_measurments
dw_actions dw_actions
end type
type tab_measurments from tab within pfc_cst_u_qa_new_profiles
tabpage_data tabpage_data
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_report tabpage_report
tabpage_action_items tabpage_action_items
end type
type cb_filter from commandbutton within pfc_cst_u_qa_new_profiles
end type
end forward

global type pfc_cst_u_qa_new_profiles from userobject
string tag = "Profiles"
integer width = 3927
integer height = 1956
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_2 cb_2
cb_save cb_save
cb_del cb_del
cb_add cb_add
cb_clear cb_clear
dw_settings dw_settings
tab_measurments tab_measurments
cb_filter cb_filter
end type
global pfc_cst_u_qa_new_profiles pfc_cst_u_qa_new_profiles

type variables
boolean ib_new
boolean ib_delete
boolean ib_modify = false  //add by stephen 09.26.2011
long il_facility
long il_facility_filter
long il_prac_id
long il_header_id
string is_compare  //maha 12.20.2011

end variables

forward prototypes
public function integer of_set_prac_id (long al_prac_id)
public function integer of_add_new (integer ai_tab)
public function integer of_add_measurements (long al_profile)
public function integer of_new_header ()
public function integer of_calc_appt_dates ()
private function integer of_import_metric_data ()
public function string of_get_date (string as_type)
public function integer of_retrieve_dropdowns ()
public function integer of_add_metrics ()
public function integer of_delete (integer ai_tab)
public function double of_calc_average (double ad_total, integer ai_cnt)
public function decimal of_calc_prac_values (decimal an_vals[], integer ai_type)
public function integer of_comparison (string as_type, integer ai_mtype[], long al_value, datetime adt_from, datetime adt_to, long al_metrics[], ref decimal al_return[])
end prototypes

public function integer of_set_prac_id (long al_prac_id);
il_prac_id = al_prac_id


return 1
end function

public function integer of_add_new (integer ai_tab);//Start Code Change ----09.27.2010 #V10 maha - new add function - called from the qa window of_new function
choose case ai_tab
	case 1
		of_add_metrics()
	//	tab_measurments.tabpage_data.cb_create_measurement.triggerevent(clicked!)
 			
			
	case 2,3
		debugbreak()
		tab_measurments.tabpage_detail.dw_measuremt_header.reset()
		tab_measurments.tabpage_detail.dw_measuremt_detail.reset()
				
		tab_measurments.tabpage_detail.dw_measuremt_header.insertrow(1)
		tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1, "prac_id", il_prac_id )
		tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1, "facility_id", il_facility)
		tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1, "active_status", 1)
		
		//------------------- APPEON BEGIN -------------------
		//$<add> Stephen 09.26.2011
		//$<reason> add a Profile Refresh Issue 
		tab_measurments.tabpage_report.dw_report.reset() 
		setnull(il_header_id)
		ib_modify = true  
		//------------------- APPEON END -------------------
		if ai_tab = 2 then
			tab_measurments.selecttab( 3)
		end if
		
		//---------Begin Added by (Appeon)Stephen 01.26.2014 for  Bug 3855 : Quality Module issues--------
		tab_measurments.tabpage_detail.dw_measuremt_header.setitemstatus(1,0,primary!, notmodified!)
		tab_measurments.tabpage_detail.dw_measuremt_header.setitemstatus(1,0,primary!, new!)
		//---------End Added ------------------------------------------------------

	case 4
	//reports
	
	case 5
		//action items
		//debugbreak()
		tab_measurments.tabpage_action_items.dw_actions.triggerevent("pfc_addrow")
	



end choose



return 1
end function

public function integer of_add_measurements (long al_profile);//Start Code Change ----09.27.2010 #V10 maha - added; used both for add of profile and to add missing
datastore lds_profile
integer ic
integer i
integer pc
integer li_find
integer li_new
long ll_item_id
long ll_id, ll_qa_metric_id
string ls_metric
datawindow ldw_detail

ldw_detail = tab_measurments.tabpage_detail.dw_measuremt_detail
debugbreak()
select max(pd_qap_id) into :ll_id from pd_qa_profile_data;
if isnull(ll_id) then ll_id = 0

lds_profile = create datastore

lds_profile.dataobject = "d_get_qa_measurement"
lds_profile.settransobject( sqlca)
ic = lds_profile.retrieve(al_profile)

for i = 1 to ic
	ll_item_id = lds_profile.getitemnumber(i,"profile_group_measurement_id")
	ls_metric = lds_profile.getitemstring(i,"qa_metrics_indicator")
	ll_qa_metric_id =  lds_profile.getitemnumber(i,"qa_metric_id") //add by stephen 04.20.2012 - Alpha Test 2991 QA Profiles populating with inaccurate data
	li_find = ldw_detail.find("pd_qa_profile_data_profile_measurement_id =" + string(ll_item_id),1,ldw_detail.rowcount())
	if li_find = 0 then
		li_new = ldw_detail.insertrow(0)
		ll_id++
		//ldw_detail.setitem(li_new,"pd_qa_profile_data_pd_qap_id",ll_id)
		ldw_detail.setitem(li_new,"pd_qa_profile_data_profile_measurement_id",ll_item_id) 
		ldw_detail.setitem(li_new,"qa_measurement_new_qa_measurement_name",ls_metric) 
		ldw_detail.setitem(li_new,"qa_metric_id",ll_qa_metric_id)  //add by stephen 04.20.2012 - Alpha Test 2991 QA Profiles populating with inaccurate data
		//ldw_detail.setitem(li_new,"pd_qa_profile_data_pd_qa_hdr_id","" )
		
		//header value set in pfc_updateprep
	end if	
next




return 1
end function

public function integer of_new_header ();//Start Code Change ----09.29.2010 #V10 maha
datawindow ldw_header 
long ll_max_count

ldw_header =  tab_measurments.tabpage_detail.dw_measuremt_header
if ldw_header.rowcount( ) < 1 then return 1

//this.accepttext( )
if not ib_delete then 
	// set the primary key
	if isnull(ldw_header.object.pd_qa_hdr_id[1]) then
		SELECT max(pd_qa_hdr.pd_qa_hdr_id) INTO :ll_max_count FROM pd_qa_hdr ;
		if isnull(ll_max_count) then ll_max_count = 0
		ll_max_count++
		il_header_id  = ll_max_count
		ldw_header.object.pd_qa_hdr_id[1] = il_header_id
	end if

end if
return 1
end function

public function integer of_calc_appt_dates ();//Start Code Change ----09.30.2010 #V10 maha - added
long ll_rec
datetime ldt_from
datetime ldt_to
datetime ldt_pfrom
datetime ldt_pto

select top 1 rec_id, apptmnt_start_date,apptmnt_end_date, init_prov_period_from,  init_prov_period_from into :ll_rec, :ldt_from, :ldt_to, :ldt_pfrom, :ldt_pto from pd_affil_stat where parent_facility_id = :il_facility and prac_id = :il_prac_id and active_status in (1,4);

if isnull(ll_rec) or ll_rec = 0 then
	messagebox("","There is no Active Appointment record for the selected facility and practitioner.")
	return -1
else
	tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1,"appt_stat_id",ll_rec)
	tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1,"from_date",ldt_from)
	tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1,"to_date",ldt_to)
	tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1,"prov_period_from",ldt_from)
	tab_measurments.tabpage_detail.dw_measuremt_header.setitem(1,"prov_period_to",ldt_to)
end if
end function

private function integer of_import_metric_data ();





return 1
end function

public function string of_get_date (string as_type);string ls_return = "Cancel"
datetime ldt_date

dw_settings.accepttext( )

if as_type = "from" then
	ldt_date = dw_settings.getitemdatetime(1,"from_date")
elseif as_type = "to" then
	ldt_date = dw_settings.getitemdatetime(1,"to_date")
else
	return ls_return
end if

ls_return = string(date(ldt_date))

//messagebox("get date",ls_return)


return ls_return


end function

public function integer of_retrieve_dropdowns ();DATAWINDOWCHILD DW_CHILD

//if tab_measurments.tabpage_action_items.dw_actions.rowcount() < 1 then return 1 //Delete by Evan 02.10.2011

tab_measurments.tabpage_action_items.dw_actions.getchild('ACTION_STATUS', DW_CHILD)
DW_CHILD.SETTRANSOBJECT(SQLCA)
DW_CHILD.Retrieve("Case/Peer Review Action Item Status")

  //action_type
tab_measurments.tabpage_action_items.dw_actions.getchild('action_type', DW_CHILD)
DW_CHILD.SETTRANSOBJECT(SQLCA)
  
DW_CHILD.Retrieve("Case/Peer Review Action Item Type")
  ///action_to

tab_measurments.tabpage_action_items.dw_actions.getchild('action_to', DW_CHILD)
DW_CHILD.SETTRANSOBJECT(SQLCA)
DW_CHILD.Retrieve("Case/Peer Review Action Item To")

return 1

end function

public function integer of_add_metrics ();//Start Code Change ----10.05.2010 #V10 maha - added - called from of_add_new and butonclicked event of dw_pd_metrics
gs_pass_ids lst_array
long ll_ids[]
long i
//long r
long nr
long ll_met
long ll_meas_id
long ll_prac
long ll_facility

integer li_found
string ls_cat[]
string ls_ind[]
string ls_filter
string ls_meas
datetime ldt_from
datetime ldt_to
boolean lb_found = false
datawindow ldw_measurements


ldw_measurements = tab_measurments.tabpage_data.dw_pd_metrics 
	
ldt_from = dw_settings.getitemdatetime(1,"from_date")
ldt_to = dw_settings.getitemdatetime(1,"to_date")
ll_facility = dw_settings.getitemnumber(dw_settings.getrow(),"facility_id")	//added by long.zhang 04.26.2012
open(w_qa_metric_select)
	//debugbreak()
if message.stringparm = "Cancel" then
	return 0
else
	//	ll_prac = 
	select max(rec_id)   into :ll_meas_id from pd_qa_data;
	if isnull(ll_meas_id) then ll_meas_id = 0
	lst_array = message.powerobjectparm
	ll_ids = lst_array.l_ids
	ls_cat = lst_array.s_action_type
	ls_ind = lst_array.s_doc_ids
	//	ld_from = lst_array.dt_from[1]
	//	ld_to = lst_array.dt_to[1]
		
	for i = 1 to upperbound(ll_ids)
		ll_met = ll_ids[i]
		nr = ldw_measurements.insertrow(0)
		ll_meas_id++
		ldw_measurements.setitem(nr,"rec_id",ll_meas_id)
		ldw_measurements.setitem(nr,"metric_id",ll_met)
		ldw_measurements.setitem(nr,"prac_id",il_prac_id)
		//ldw_measurements.setitem(nr,"facility_id",il_facility)
		ldw_measurements.setitem(nr,"facility_id",ll_facility)	//long.zhang 04.26.2012
		ldw_measurements.setitem(nr,"from_date",ldt_from )
		ldw_measurements.setitem(nr,"to_date",ldt_to )
	next
end if
	
i = ldw_measurements.update()
if i < 1 then 	messagebox("Measurements Update failed",sqlca.sqlerrtext)

return 1
end function

public function integer of_delete (integer ai_tab);//Start Code Change ----10.05.2010 #V10 maha - added
datawindow ldw_curr
datawindow ldw_detail
integer res
integer i
long     ll_row, ll_hdr_id

choose case ai_tab
	case 1 //metrics
		ldw_curr = tab_measurments.tabpage_data.dw_pd_metrics 
		if ldw_curr.getrow() > 0 then
			res = messagebox("Delete metric","Are you sure you wish to delete the data metric record?~r~rIf you do you will have to manually re-import the data on any effected profile reports. ",question!,yesno!,2)
			//---------Begin modify by (Appeon)Stephen 01.24.2014 for Bug 3855 : Quality Module issues--------
			//if res = 1 then ldw_curr.deleterow(0)
			if res = 1 then 
				ldw_curr.deleterow(0)
				ldw_curr.update()
			end if
			//---------End Added ------------------------------------------------------
		end if
	case 2,3 //browse,detail
		//---------Begin Added by (Appeon)Stephen 08.20.2015 for Deleting profile detail from the browse tab in QA module Case# 56490 Bug_id# 4670--------
		if ai_tab = 2 then
			ll_row = tab_measurments.tabpage_browse.dw_browse.getrow()
			if ll_row > 0 then
				ll_hdr_id =  tab_measurments.tabpage_browse.dw_browse.object.pd_qa_hdr_id[ll_row]
				tab_measurments.tabpage_detail.dw_measuremt_header.retrieve(ll_hdr_id )
				tab_measurments.tabpage_detail.dw_measuremt_detail.retrieve(ll_hdr_id )
			else
				return 1
			end if	
		end if
		//---------End Added ------------------------------------------------------
		ldw_curr = tab_measurments.tabpage_detail.dw_measuremt_header
		if ldw_curr.getrow() > 0 then
			res = messagebox("Delete Profile","Are you sure you wish to delete the Profile with its connected data? ",question!,yesno!,2)
			if res = 1 then
				ldw_detail =  tab_measurments.tabpage_detail.dw_measuremt_detail
				
				//------------------- APPEON BEGIN -------------------
				//$<modify> Stephen 04.14.2011
				//$<reason> Fix a bug
				/*
				for i = 1 to ldw_detail.rowcount()
					ldw_detail.deleterow(1)
				next
				*/
				for i =  ldw_detail.rowcount() to 1 step -1
					ldw_detail.deleterow(i)
				next
				//------------------- APPEON END ---------------------
				
				ldw_curr.deleterow(0)
				//---------Begin Added by (Appeon)Stephen 01.24.2014 for Bug 3855 : Quality Module issues--------
				ldw_detail.update()
				ldw_curr.update()
				//---------End Added ------------------------------------------------------
			end if
		end if
	case 5 //actions
		ldw_curr = tab_measurments.tabpage_action_items.dw_actions
		if ldw_curr.getrow() > 0 then
			res = messagebox("Delete Action","Are you sure you wish to delete the action item? ",question!,yesno!,2)
			//---------Begin modify by (Appeon)Stephen 01.24.2014 for Bug 3855 : Quality Module issues--------
			//if res = 1 then ldw_curr.deleterow(0)
			if res = 1 then 
				ldw_curr.deleterow(0)
				ldw_curr.update()
			end if
			//---------End Added ------------------------------------------------------
		end if
end choose


return 1
end function

public function double of_calc_average (double ad_total, integer ai_cnt);double ld_return
debugbreak()
ld_return = ad_total / ai_cnt

return ld_return
end function

public function decimal of_calc_prac_values (decimal an_vals[], integer ai_type);//Start Code Change ----12.20.2011 #V12 maha - created - called from of_comparison
integer r
integer rc
decimal ln_total

rc = upperbound(an_vals)

for r = 1 to rc
	ln_total = ln_total + an_vals[r]
next

if ai_type = 2 then
	ln_total = ln_total/rc
end if

return ln_total

end function

public function integer of_comparison (string as_type, integer ai_mtype[], long al_value, datetime adt_from, datetime adt_to, long al_metrics[], ref decimal al_return[]);//Start Code Change ----12.20.2011 #V12 maha
datastore lds_data
long m
long mc
long r
long p
long pp
long ll_prac_cnt
long pc
long ll_total
decimal ll_ave
decimal vals[]
decimal prac_vals[]
decimal nulls[]
decimal ln_value
decimal ln_return
decimal ln_val
integer ub
integer li_type


lds_data = create datastore

Choose case as_type
	case "D"
		lds_data.dataobject = "d_qa_profile_comp_dept"
	case "S"
		lds_data.dataobject = "d_qa_profile_comp_spec"
	case "F"
		lds_data.dataobject = "d_qa_profile_comp_facil"
end choose
		
lds_data.settransobject(sqlca)

ll_total = lds_data.retrieve(al_value,adt_from ,adt_to, al_metrics)

mc = upperbound(al_metrics[])

for m = 1 to mc  //for each metric, filter then compute
	if al_metrics[m] = 17 then debugbreak()
	lds_data.setfilter( "metric_id = " + string(al_metrics[m]))
	lds_data.filter()
	lds_data.sort() //by prac id
	li_type = ai_mtype[m]
	ll_total = lds_data.rowcount()
	
	if ll_total = 0 then
		ln_return = 0
		prac_vals[] = nulls[]
	end if
	
	
	for r = 1 to ll_total //get prac count
		p = lds_data.getitemnumber(r, "prac_id")
		
		if r = 1 then
			ll_prac_cnt = 1	
			vals[1] = dec(lds_data.getitemstring(r, "measurment"))
			pp = p
		elseif p <> pp then //the prac id is different from the prior loop
			ll_prac_cnt++
			//process for previous prac
			ub = upperbound( vals)
			if ub = 0 then ub = 1
			if ub = 1 then
				prac_vals[ll_prac_cnt - 1] = vals[1]
			else
				ln_value = of_calc_prac_values(vals[], li_type)
				prac_vals[ll_prac_cnt - 1] = ln_value
			end if

			vals[] = nulls[] //reset the array
			ln_val = dec(lds_data.getitemstring(r, "measurment"))
			vals[1] = ln_value
			pp = p
		else //if same prac
			vals[upperbound ( vals[]) + 1]= dec(lds_data.getitemstring(r, "measurment"))
		end if
		
		//get the value for the last prac
		if r = ll_total then
			ub = upperbound(vals)
			if ub = 1 then
				prac_vals[ll_prac_cnt] = vals[1]
			else
				ln_value = of_calc_prac_values(vals[], li_type)
				prac_vals[ll_prac_cnt ] = ln_value
			end if
		end if
			
	next //next data record
	
	ln_value = 0  //resetting
	
	if ll_total > 0 then
		for r = 1 to ll_prac_cnt
			ln_value = ln_value + prac_vals[r]
		next
	end if
	 
	 if ll_prac_cnt = 0 then
		ln_return = 0
	else
		ln_return = ln_value / ll_prac_cnt
	end if
	
	al_return[m] = ln_return
		
next //metric type

destroy lds_data

return 1
end function

on pfc_cst_u_qa_new_profiles.create
this.cb_2=create cb_2
this.cb_save=create cb_save
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_clear=create cb_clear
this.dw_settings=create dw_settings
this.tab_measurments=create tab_measurments
this.cb_filter=create cb_filter
this.Control[]={this.cb_2,&
this.cb_save,&
this.cb_del,&
this.cb_add,&
this.cb_clear,&
this.dw_settings,&
this.tab_measurments,&
this.cb_filter}
end on

on pfc_cst_u_qa_new_profiles.destroy
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_clear)
destroy(this.dw_settings)
destroy(this.tab_measurments)
destroy(this.cb_filter)
end on

type cb_2 from commandbutton within pfc_cst_u_qa_new_profiles
integer x = 3429
integer y = 192
integer width = 471
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Meeting Data"
end type

event clicked;open(w_import_cme_data) //(Appeon)Stephen 08.01.2016 - BugS072801
end event

type cb_save from commandbutton within pfc_cst_u_qa_new_profiles
integer x = 2592
integer y = 192
integer width = 270
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;w_qa_peer_profile_screen.triggerevent("pfc_save")
end event

type cb_del from commandbutton within pfc_cst_u_qa_new_profiles
integer x = 3150
integer y = 192
integer width = 270
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer i

i = tab_measurments.selectedtab

of_delete(i)
end event

type cb_add from commandbutton within pfc_cst_u_qa_new_profiles
integer x = 2871
integer y = 192
integer width = 270
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;integer i

i = tab_measurments.selectedtab

of_add_new(i)
end event

type cb_clear from commandbutton within pfc_cst_u_qa_new_profiles
integer x = 2094
integer y = 192
integer width = 206
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;datetime ldt_null


setnull(ldt_null)
dw_settings.setitem(1,"from_date",ldt_null)
dw_settings.setitem(1,"to_date",ldt_null)

cb_filter.triggerevent( clicked!)

end event

type dw_settings from u_dw within pfc_cst_u_qa_new_profiles
boolean visible = false
integer x = 14
integer y = 128
integer width = 2071
integer height = 148
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pd_qa_data_settings"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)

//Start Code Change ---04.25.2012 #V12 maha - moved retrieval code to qa retrieval function
//datawindowchild dwchild
//
//this.GetChild( "facility_id", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve(gs_user_id )

this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

this.of_setupdateable( false)
end event

event itemchanged;call super::itemchanged;long ll_facil

if dwo.name = "facility_id" then
	ll_facil = long(data)
	tab_measurments.tabpage_data.dw_pd_metrics.retrieve(il_prac_id,ll_facil)
end if
end event

event pfc_addrow;//Start Code Change ----08.12.2014 #V14.2 maha - added to focus on the correct dw.
tab_measurments.tabpage_data.dw_pd_metrics.postevent('pfc_addrow')
return 0
end event

type tab_measurments from tab within pfc_cst_u_qa_new_profiles
integer x = 5
integer y = 12
integer width = 3931
integer height = 1944
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_data tabpage_data
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_report tabpage_report
tabpage_action_items tabpage_action_items
end type

on tab_measurments.create
this.tabpage_data=create tabpage_data
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_report=create tabpage_report
this.tabpage_action_items=create tabpage_action_items
this.Control[]={this.tabpage_data,&
this.tabpage_browse,&
this.tabpage_detail,&
this.tabpage_report,&
this.tabpage_action_items}
end on

on tab_measurments.destroy
destroy(this.tabpage_data)
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_report)
destroy(this.tabpage_action_items)
end on

event selectionchanged;
 //Start Code Change ----12.03.2015 #V15 maha - modified for add,save.delete buttons
choose case selectedtab
	case 1
		dw_settings.visible = true
		cb_filter.visible = true
		cb_clear.visible = true
		cb_add.visible = true
		cb_del.visible = true
		cb_save.visible = true
		cb_2.visible = true //(Appeon)Stephen 08.01.2016 - BugS072801
	case 2,3, 5 //Start Code Change ----08.23.2011 #V11 maha - modified so filter objects only appear on the data tab
		dw_settings.visible = false
		cb_filter.visible = false
		cb_clear.visible = false
		cb_add.visible = true
		cb_del.visible = true
		cb_save.visible = true
		cb_2.visible = false  //(Appeon)Stephen 08.01.2016 - BugS072801
	case 4
		dw_settings.visible = false
		cb_filter.visible = false
		cb_clear.visible = false
		cb_add.visible = false
		cb_del.visible = false
		cb_save.visible = false
		cb_2.visible = false  //(Appeon)Stephen 08.01.2016 - BugS072801
end choose

//---------Begin Added by (Appeon)Stephen 01.24.2014 for Bug 3855: Quality Module issues--------
choose case selectedtab
	case 1
		tab_measurments.tabpage_data.dw_pd_metrics.setfocus()
	case 2
		tab_measurments.tabpage_browse.dw_browse.setfocus()
	case 3
		tab_measurments.tabpage_detail.dw_measuremt_header.setfocus()
	case 4
		tab_measurments.tabpage_report.dw_report.setfocus()
	case 5
		tab_measurments.tabpage_action_items.dw_actions.setfocus()
end choose
//---------End Added ------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Evan 02.10.2011
//$<reason> Fixed bug
long ll_Row
long ll_pd_qa_hdr_id

ll_Row = tab_measurments.tabpage_browse.dw_browse.getrow()
if ll_Row > 0 then
	ll_pd_qa_hdr_id = tab_measurments.tabpage_browse.dw_browse.getitemnumber(ll_Row, "pd_qa_hdr_id")
	tab_measurments.tabpage_action_items.dw_actions.retrieve(ll_pd_qa_hdr_id)
else
	tab_measurments.tabpage_action_items.dw_actions.reset()
end if
//------------------- APPEON END ---------------------

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 09.22.2011
//$<reason> Profile Module Refresh Issue - Bug id 2659
if ib_modify = false then // add by stephen 09.26.2011
	if ll_Row > 0 then
	//	il_facility =  tab_measurments.tabpage_browse.dw_browse.object.facility_id[ll_Row]//commented by long.zhang 04.26.2012
		il_header_id =  tab_measurments.tabpage_browse.dw_browse.object.pd_qa_hdr_id[ll_Row]
		tab_measurments.tabpage_detail.dw_measuremt_header.retrieve(il_header_id )
		tab_measurments.tabpage_detail.dw_measuremt_detail.retrieve(il_header_id )
		
		if tab_measurments.tabpage_report.ddlb_reports.text = '' or isnull(tab_measurments.tabpage_report) then
			tab_measurments.tabpage_report.dw_report.reset()
		else
			tab_measurments.tabpage_report.dw_report.retrieve(il_header_id)
		end if
	else
		tab_measurments.tabpage_detail.dw_measuremt_header.reset()
		tab_measurments.tabpage_detail.dw_measuremt_detail.reset()
		tab_measurments.tabpage_report.dw_report.reset()
	end if
end if
//------------------- APPEON END -------------------
end event

event selectionchanging;Long ll_parent //Added by  Nova 02.23.2010
Long ll_prac //Added by  Nova 02.23.2010
Long ll_view_id //Added by  Nova 02.23.2010

IF oldindex < 1 Or newindex < 1 THEN RETURN
	
//iw_parent.SetRedraw( False)
CHOOSE CASE newindex
	CASE 5
		IF w_mdi.MenuName	 <> 'm_pfe_cst_qa' THEN
			w_mdi.ChangeMenu( m_pfe_cst_qa )
			w_mdi.of_menu_security( w_mdi.MenuName )	
		END IF
	CASE ELSE
		IF w_mdi.MenuName	 <> 'm_pfe_cst_mes' THEN
			 w_mdi.ChangeMenu( m_pfe_cst_mes )
			w_mdi.of_menu_security( w_mdi.MenuName )
			//---------------------------- APPEON END ----------------------------
		END IF
END CHOOSE


//iw_parent.SetRedraw( True)
end event

type tabpage_data from userobject within tab_measurments
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3895
integer height = 1816
long backcolor = 16777215
string text = "Collected Data"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "ViewPainter!"
long picturemaskcolor = 536870912
dw_pd_metrics dw_pd_metrics
end type

on tabpage_data.create
this.dw_pd_metrics=create dw_pd_metrics
this.Control[]={this.dw_pd_metrics}
end on

on tabpage_data.destroy
destroy(this.dw_pd_metrics)
end on

type dw_pd_metrics from u_dw within tabpage_data
integer y = 184
integer width = 3890
integer height = 1632
integer taborder = 11
string dataobject = "d_pd_qa_data_add"
end type

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.04.2010 #V10 maha
	gs_pass_ids lst_array
	long ll_ids[]
	long i
	long r
	long nr
	long ll_met
	long ll_meas_id
	long ll_prac
	integer li_found
	string ls_cat[]
	string ls_ind[]
	string ls_filter
	string ls_meas
	datetime ldt_from
	datetime ldt_to
	boolean lb_found = false
	datawindow ldw_measurements


if dwo.name = "b_measure" then
	of_add_metrics( )	

end if


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

if dwo.name = "b_calc" then
	messagebox("","Not Coded")
	//function for getting CME, Meeting and Peer review data.
	nr = 0
	for i = 1 to 3
		choose case i
			case 1	
				ll_met = 11
				
			case 2 
				ll_met = 0
			case 3
				ll_met = 0
		end choose
		ls_filter = "metric_id = " + string(ll_met)
		nr = this.find(ls_filter,1,this.rowcount())
		do until nr = 0
			ls_meas =  this.getitemstring(nr,"measurment" )
			ldt_from = this.getitemdatetime(nr,"from_date" )
			ldt_to = this.getitemdatetime(nr,"to_date" )
			if isnull(ls_meas) or ls_meas = '' then //only if measurment is blank
				choose case i
					case 1
						//of calc_cmes
					case 2
						//of_calc_meetings
					case 3
						//of_calc_peer
						
				end choose
			end if		
			nr = this.find(ls_filter,nr,this.rowcount())
		loop
		
		
	next
		
				

end if

			
			
end event

event constructor;call super::constructor;this.settransobject(sqlca)

this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event pfc_addrow;of_add_metrics( )

return 1
end event

type tabpage_browse from userobject within tab_measurments
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3895
integer height = 1816
long backcolor = 16777215
string text = "Browse"
long tabtextcolor = 33554432
string picturename = "Search!"
long picturemaskcolor = 536870912
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_browse
integer y = 168
integer width = 3895
integer height = 1648
integer taborder = 20
string dataobject = "d_pd_profile_search"
boolean hscrollbar = true
end type

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : contructor dw_1::u_tabpage_measurements_brouse
//==================================================================================================================
//  Purpose   	: Set up needed services for the datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]  not used    
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ib_rmbmenu	= true

THIS.of_SetRowSelect(TRUE)
THIS.inv_rowselect.of_SetStyle(THIS.inv_rowselect.single )




end event

event doubleclicked;call super::doubleclicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]  EVENT  : 
//==================================================================================================================
//  Purpose   	: Triggger a function on the parent window dynamically
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
// make sure all is updated
////////////////////////////////////////////////////////////////////////
iw_parent.dynamic of_accepttext( true)
if iw_parent.function dynamic of_updatespending( ) > 0  then
	if messagebox('Updates Pending', 'Do you want to save changes?',question!,YesNo!) = 1 then
      if iw_parent.dynamic of_save()  < 0 then
			of_MessageBox ( '', 'Update Error', 'Update has failed', Exclamation!, ok!, 1)
			return 
		else
		end if
	else		
	end if
end if

ib_modify = false // add by stephen  add a Profile Refresh Issue 
if this.getrow() > 0 then
//	il_facility =  this.object.facility_id[this.getrow()] //commented by long.zhang 04.26.2012
	il_header_id =  this.object.pd_qa_hdr_id[this.getrow()]
end if

tab_measurments.tabpage_detail.dw_measuremt_header.retrieve(il_header_id )
tab_measurments.tabpage_detail.dw_measuremt_detail.retrieve(il_header_id )

tab_measurments.selecttab(3)




end event

event retrieveend;call super::retrieveend;


// set the header id
//of_set_header_id()
// set the header_id 
//iw_parent.dynamic of_set_hdr_id ( parent.of_get_header_id( ) )
end event

event retrievestart;call super::retrievestart;//pd_qa_hdr_id


end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////  [PUBLIC]   : FUCNCTION rowfocuschanged
////==================================================================================================================
////  Purpose   	: 
////==================================================================================================================
////  Arguments 	: [none] 
////==================================================================================================================
////  Returns   	: [long]     
////==================================================================================================================
////  Notes     	: 	   
////==================================================================================================================
////  Created By	: Michael B. Skinner  Thursday  October 14, 2004
////==================================================================================================================
////  Modification Log
////   Changed By             Change Date                                               Reason
//// ------------------------------------------------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//// set the header id
//of_set_header_id()
//// set the header_id 
//iw_parent.dynamic of_set_hdr_id ( parent.of_get_header_id( ) )
//
//
//


end event

event pfc_deleterow;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]  EVENT  : 
//==================================================================================================================
//  Purpose   	: Triggger a function on the parent window dynamically
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//TRY
	   iw_parent.DYNAMIC OF_DELETE()
//CATCH (RunTimeError rte)
   //   messagebox("Runtime Error",'Function OF_DELETE () does not exist on the parent window!' + '~r~r' +  rte.getmessage()  )
//END TRY

RETURN 1
end event

event pfc_addrow;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]  EVENT  : 
//==================================================================================================================
//  Purpose   	: Triggger a function on the parent window dynamically
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// OVERRIDE

TRY
	   iw_parent.DYNAMIC of_new()
CATCH (RunTimeError rte)
      messagebox("Runtime Error",'Function of_new() does not exist on the parent window!' + '~r~r' +  rte.getmessage()  )
END TRY

return 1
end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////  [PUBLIC]   : EVENT pfc_retrieve
////==================================================================================================================
//  Purpose   	: retrieve the datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//debugbreak()
long ll_row

THIS.SETFOcus( )

//RETURN THIS.RETRIEVE(il_prac_id, il_facility ) --delete by stephen 09.22.2011 --Profile Module Refresh Issue - Bug id 2659
//------------------- APPEON BEGIN -------------------
//$<add> Stephen 09.22.2011
//$<reason> Profile Module Refresh Issue - Bug id 2659
THIS.RETRIEVE(il_prac_id, il_facility )

//----------------------APPEON BEGIN-----------------------------
//$<add> appeon long.zhang 10.10.2011
//$<reason> for after save data or get dates do not change the current row
if not IsNull(il_header_id) and il_header_id > 0 then
	ll_row = this.find( "pd_qa_hdr_id=" + String(il_header_id), 1,this.rowcount())
	if  ll_row> 0 THEN
		this.scrolltorow( ll_row)
		this.selectrow( 0,false)
		this.selectrow( ll_row,true)
	end if	
end if
//------------------APPEON  END-----------------------------------

ll_row = this.getrow()
if ll_Row > 0 then
//	il_facility =  tab_measurments.tabpage_browse.dw_browse.object.facility_id[ll_Row] commented by long.zhang 04.26.2012
	il_header_id =  tab_measurments.tabpage_browse.dw_browse.object.pd_qa_hdr_id[ll_Row]
	tab_measurments.tabpage_detail.dw_measuremt_header.retrieve(il_header_id )
	tab_measurments.tabpage_detail.dw_measuremt_detail.retrieve(il_header_id )
	
	if tab_measurments.tabpage_report.ddlb_reports.text = '' or isnull(tab_measurments.tabpage_report) then
		tab_measurments.tabpage_report.dw_report.reset()
	else
		tab_measurments.tabpage_report.dw_report.retrieve(il_header_id)
	end if
else
	setnull(il_header_id)
	tab_measurments.tabpage_detail.dw_measuremt_header.reset()
	tab_measurments.tabpage_detail.dw_measuremt_detail.reset()
	tab_measurments.tabpage_report.dw_report.reset()
end if
ib_modify = false //add by stephen 09.26.2011
RETURN this.rowcount()
//------------------- APPEON END -------------------

return 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;

// turn off insert, add, delete menu option
//am_DW.m_Table.m_AddRow.Enabled = False
am_DW.m_Table.m_Insert.Enabled = False
am_DW.m_Table.m_Delete.Enabled = False
end event

type tabpage_detail from userobject within tab_measurments
integer x = 18
integer y = 112
integer width = 3895
integer height = 1816
long backcolor = 16777215
string text = "Profile Detail"
long tabtextcolor = 33554432
string picturename = "DataWindow5!"
long picturemaskcolor = 536870912
dw_measuremt_detail dw_measuremt_detail
dw_measuremt_header dw_measuremt_header
end type

on tabpage_detail.create
this.dw_measuremt_detail=create dw_measuremt_detail
this.dw_measuremt_header=create dw_measuremt_header
this.Control[]={this.dw_measuremt_detail,&
this.dw_measuremt_header}
end on

on tabpage_detail.destroy
destroy(this.dw_measuremt_detail)
destroy(this.dw_measuremt_header)
end on

type dw_measuremt_detail from u_dw within tabpage_detail
event type long ue_get_sequence_number ( )
event ue_add_missing ( )
integer y = 812
integer width = 3895
integer height = 1004
integer taborder = 30
string dataobject = "d_pd_qa_detail_existing_new"
boolean hscrollbar = true
end type

event type long ue_get_sequence_number();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_get_sequence_number
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	:    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dec ll_max_count

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-16 By: Liang QingShi
//$<reason> 

//SELECT max("dba"."pd_qa_measurements"."pd_qa_measurements_id")
//INTO :ll_max_count 
//FROM "dba"."pd_qa_measurements" ;

SELECT max(pd_qa_measurements.pd_qa_measurements_id)
INTO :ll_max_count 
FROM pd_qa_measurements ;

//---------------------------- APPEON END ----------------------------
if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1


end event

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : constructor:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.of_SetRowManager(TRUE)
this.of_SetRowSelect(TRUE)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

ll_original_width = this.width




end event

event rbuttondown;call super::rbuttondown;
m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(dw_measuremt_detail )
NewMenu.m_measurements.visible = true



//NewMenu.m_options.m_mailall.visible = false
//NewMenu.m_options.m_printall.visible = false
//NewMenu.m_options.m_printcurrent.text = 'Print'
//NewMenu.m_options.m_mailcurrent.text = 'Mail'
NewMenu.m_measurements.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
end event

event updateend;call super::updateend;ib_modify = true  //add by stephen 09.26.2011 --add a Profile Refresh Issue 
return 1
end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ----09.29.2010 #V10 maha
long ll_id
long ll_i


if parent.dw_measuremt_header.rowcount( ) < 1 then return SUCCESS 
if parent.dw_measuremt_detail.ROWCOUNT() <  1 then return SUCCESS


if not ib_delete then
	select max(pd_qap_id) into :ll_id from pd_qa_profile_data;
	if isnull(ll_id) then ll_id = 0
	
	for ll_i = 1 to this.rowcount( )
		if isnull( this.getitemnumber(ll_i,"pd_qa_profile_data_pd_qap_id")) then
			ll_id++
			this.setitem(ll_i,"pd_qa_profile_data_pd_qap_id",ll_id)
			this.setitem(ll_i,"pd_qa_profile_data_pd_qa_hdr_id",il_header_id )
			
		end if
	next
	accepttext( )

end if

RETURN SUCCESS
end event

event pfc_postupdate;call super::pfc_postupdate;this.retrieve(il_header_id )

return 1
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.01.2010 #V10 maha - added
boolean lb_found = false
string ls_filter
string ls_to
double ll_value
double ll_values
datetime ldt_from
datetime ldt_to
string d1
string d2
long r
long rc
long a
long ac
long ll_profile
long ll_metric
long ll_metrics[]
integer res
integer li_format
datawindow ldw_profile
datawindow ldw_metrics
datastore lds_copy

 ldw_profile =  tab_measurments.tabpage_detail.dw_measuremt_header
 ldw_metrics = tab_measurments.tabpage_data.dw_pd_metrics
//missing item function
if ldw_profile.getrow() < 1 then return //Add by Stephen 04.20.2011  Invalid DataWindow row/column 
if dwo.name = "b_missing" then
	ll_profile =  ldw_profile.getitemnumber(1,"qa_profile_id")
	if isnull(ll_profile) then return  //Add by Stephen 04.20.2011   Invalid DataWindow row/column 
	if ldw_profile.rowcount() > 0 then
		of_add_measurements( ll_profile)
	else
		messagebox("Add missing","You must add the profile header before adding items." )
	end if
	return
end if

if dwo.name = "b_import" then
	//filter for the date range of the profile
//	debugbreak()
	ldt_from = ldw_profile.getitemdatetime(1,"from_date")
	d1 = of_convert_date(date(ldt_from))
	ldt_to = ldw_profile.getitemdatetime(1,"to_date")
	d2 = of_convert_date(date(ldt_to))
	
	
	ls_filter = "date(from_date) >= date('" + d1 + "') and date(to_date) <= date('" + d2 + "') "
	//messagebox("filter",ls_filter)
	res =  ldw_metrics.setfilter(ls_filter)
	res = ldw_metrics.filter()
	rc =  ldw_metrics.rowcount()
	
	if rc = 0  then return
	
	//create a datastore for copying the filtered metric data
	 lds_copy = create datastore
	 lds_copy.dataobject =  ldw_metrics.dataobject
	 lds_copy.settransobject(sqlca)
	 
	 ldw_metrics.rowscopy( 1, rc, primary!, lds_copy, 1,primary!)
	 
	 rc = this.rowcount()
	//scan this list of metrics and filter for data metrics that match
	for r = 1 to this.rowcount( )
		ll_metric = this.getitemnumber(r,"qa_metric_id")
		li_format =  this.getitemnumber(r,"qa_measurement_new_data_format")
		ll_values = 0 //reset
		ls_filter = "metric_id = " + string(ll_metric)
		//filter for specific metric
		lds_copy.setfilter(ls_filter)
		lds_copy.filter()
		ac =  lds_copy.rowcount()
		//if any get and set values
		if ac > 0 then
			for a  = 1 to ac
				ll_value = double(lds_copy.getitemstring(a,"measurment"))
				ll_values  = ll_values + ll_value
			next
			if li_format = 1 then
				ll_values = of_calc_average(ll_values,ac)
			end if
			this.setitem(r,"data_stored_value",ll_values)
		end if
	next
	
	//clear the date filter
	ldw_metrics.setfilter("")
	ldw_metrics.filter()
	
	destroy lds_copy
end if

end event

event pfc_addrow;return 1
end event

type dw_measuremt_header from u_dw within tabpage_detail
event type long ue_get_sequence_number ( )
event type decimal ue_get_sequence_number_master ( )
integer y = 160
integer width = 3895
integer height = 648
integer taborder = 20
string dataobject = "d_pd_qa_header_new"
boolean vscrollbar = false
boolean livescroll = false
end type

event type long ue_get_sequence_number();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_get_sequence_number
//==================================================================================================================
//  Purpose   	:
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_count

SELECT max(pd_qa_measurements_id )
into :ll_count
FROM pd_qa_measurements;

return ll_count + 1






end event

event type decimal ue_get_sequence_number_master();//Start Code Change ----09.29.2010 #V10 maha - modified from original
dec ll_max_count

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-16 By: Liang QingShi
//$<reason> 

//SELECT max("dba"."pd_qa_hdr"."pd_qa_hdr_id")
//INTO :ll_max_count 
//FROM "dba"."pd_qa_hdr" ;

SELECT max(pd_qa_hdr.pd_qa_hdr_id)
INTO :ll_max_count 
FROM pd_qa_hdr ;
//---------------------------- APPEON END ----------------------------

if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1


end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.19.2010 #V10 maha - rewrote
IF rowcount( ) < 1 THEN RETURN  failure
debugbreak()
long ll_rec
datetime ldt_from
datetime ldt_to
datetime ldt_pfrom
datetime ldt_pto
datetime ldt_ps
datetime ldt_pe
dwitemstatus ldws_new //Add by Stephen 04.14.2011

select top 1 rec_id, apptmnt_start_date,apptmnt_end_date, init_prov_period_from,  init_prov_period_from, prior_appt_start, prior_appt_end into :ll_rec, :ldt_from, :ldt_to, :ldt_pfrom, :ldt_pto,:ldt_ps,:ldt_pe from pd_affil_stat where parent_facility_id = :il_facility and prac_id = :il_prac_id and active_status in (1,4);

if isnull(ll_rec) or ll_rec = 0 then
	messagebox("","There is no Active Appointment record for the selected facility and practitioner.")
	return -1
else
	//the only thing important is the rec_id as the dates are not stored.
	this.setitem(1,"appt_stat_id",ll_rec)
	this.setitem(1,"prov_period_from", ldt_pfrom)
	this.setitem(1,"prov_period_to", ldt_pto)
	if isnull(ldt_from) then ldt_from = ldt_ps
	if isnull(ldt_to) then ldt_to = ldt_pe
	this.setitem(1,"apptmnt_start_date", ldt_from)  //Start Code Change ----05.02.2012 #V12 maha - changed set variable from ldt_ps
	this.setitem(1,"apptmnt_end_date", ldt_to)  //Start Code Change ----05.02.2012 #V12 maha - changed set variable from ldt_pe
end if

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.14.2011
//$<reason> 
ldws_new = this.getitemstatus(1, 0, primary!)
if ldws_new = new! or ldws_new = newmodified! then
	return -1
end if
//------------------- APPEON END ---------------------

this.update()
this.retrieve(il_header_id)






end event

event constructor;call super::constructor;

this.settransobject(sqlca)
this.of_setupdateable( true)
this.of_setlinkage( true)
//this.of_settransobject(sqlca)

this.of_SetRowManager(TRUE)
//this.inv_rowmanager.of_SetRestoreRow(TRUE)
//this.of_SetReqColumn(false)
//this.inv_reqcolumn.of_setcolumndisplaynamestyle(2)
this.ib_rmbmenu = true

this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("from_date",this.iuo_calendar.DDLB)
this.iuo_calendar.of_Register("to_date",this.iuo_calendar.DDLB)


//lds_appointment_dates = create n_ds
//lds_appointment_dates.dataobject = 'd_measurements_dates'
//lds_appointment_dates.of_settransobject( sqlca)






end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : itemchanged
//==================================================================================================================
//  Purpose   	:
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// retrieve the profile information based on the profile selected
long ll_i
long li_measuremtent_id
string ls_find_str
string ls_measurement_name
long ll_id
long ll_group_id //alfee 03.06.2009
long ll_profile
integer res

choose case dwo.name
	case 'qa_profile_id'
		ll_profile = long(data)
		
		if  dw_measuremt_detail.rowcount() = 0 then	
			dw_measuremt_detail.setredraw( false )
			of_new_header( )
			of_add_measurements(ll_profile )
			
			dw_measuremt_detail.setredraw( true)
		else
			res = messagebox("Profile change",  "You are changing the selected profile.  There is Existing data connected to the original profile.  do you want ot delete the existing profile data and add the new items?", question!,yesno!,2)
			if res = 1 then 
				//------------------- APPEON BEGIN -------------------
				//$<add> Michael 12.27.2011
				//$<reason> Bug id 2837 QA Issues
				DO WHILE  dw_measuremt_detail.rowcount() > 0 
					dw_measuremt_detail.deleterow(1)
				Loop
				//------------------- APPEON END ---------------------
				dw_measuremt_detail.setredraw( false )
				of_add_measurements(ll_profile )
				dw_measuremt_detail.setredraw( true)
			else
				return 2
			end if
		end if 

		
end choose


return 0
end event

event retrieveend;call super::retrieveend;

n_cst_color lnv_color
Integer li_columns, li_index
String ls_colName

if rowcount < 1 then RETURN 

// do no let the user make changes to historical records
if this.object.active_status[1] <> 1 then
	
	//////////////////////////////////////////////////////////////
	this.Object.DataWindow.ReadOnly = 'YES'
	li_columns = Integer(this.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  this.Modify(ls_colName+".Background.Color=" + + string(lnv_color.buttonface ) )
	next
	
	//////////////////////////////////////////////////////////////
	parent.dw_measuremt_detail.object.DataWindow.readonly = "Yes"
		
	li_columns = Integer(parent.dw_measuremt_detail.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  parent.dw_measuremt_detail.Modify(ls_colName+".Background.Color=" + + string(lnv_color.buttonface ) )
	next
	
	
	
else 
	//////////////////////////////////////////////////////////////
	this.Object.DataWindow.ReadOnly = 'no'
	
	li_columns = Integer(this.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  this.Modify(ls_colName+".Background.Color=" + + string(lnv_color.white ) )
	next

	/////////////////////////////////////////////////////////////
	
	parent.dw_measuremt_detail.object.DataWindow.readonly = "no"
	
	li_columns = Integer(parent.dw_measuremt_detail.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  parent.dw_measuremt_detail.Modify(ls_colName+".Background.Color=" + + string(lnv_color.white) )
	next
	
end if




		
 





//of_get_appointment_dates( 'insert')





end event

event updateend;call super::updateend;
this.ib_rmbmenu = true
ib_modify = true  //add by stephen 09.26.2011 --add a Profile Refresh Issue 

tab_measurments.tabpage_browse.dw_browse.event pfc_retrieve()  //Add by Stephen 04.13.2011 --- Fixed a bug

end event

event pfc_deleterow;////--------------------------- APPEON BEGIN ---------------------------
////$<add> 03.21.2006 By: Liang QingShi
////$<reason> Fix a defect.
//long ll_row
//ll_row = this.getrow()
//if ll_row <= 0 then return -1
//il_pd_qa_hdr_id = this.getitemnumber(ll_row,'pd_qa_hdr_id')
//call super::pfc_deleterow

 iw_parent.DYNAMIC OF_DELETE() //Add by Stephen 04.14.2011
return 1
////---------------------------- APPEON END ----------------------------
//
end event

event pfc_insertrow;call super::pfc_insertrow;

// override

return this.event pfc_addrow( )
end event

event pfc_addrow;
IF THIS.OF_UPdatespending( ) > 0 then
	if Messagebox('Save Changes', 'Do you want to save changes?',question!,yesNo!) = 1 then
	IF iw_parent.DYNAMIC event PFC_save() < 0 THEN RETURN -1
	end if 
end if

ib_new = TRUE

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 09.26.2011
//$<reason> add a Profile Refresh Issue 
ib_modify = true
setnull(il_header_id)
tab_measurments.tabpage_report.dw_report.reset() 
//------------------- APPEON END -------------------

this.ib_rmbmenu = false
this.reset( )
dw_measuremt_detail.reset()  //Add by Stephen 04.13.2011 --- Fixed a bug

ib_delete = false

Super::EVENT pfc_addrow()

this.object.prac_id[1] =  il_prac_id
//---------Begin Added by (Appeon)Stephen 01.24.2014 for  Bug 3855 : Quality Module issues--------
this.object.facility_id[1] =  il_facility  
this.setitemstatus(1,0,primary!, notmodified!)
this.setitemstatus(1,0,primary!, new!)
//---------End Added ------------------------------------------------------

//this.postevent( "buttonclicked")

return 1
end event

event pfc_retrieve;call super::pfc_retrieve;

	

long ll_count

this.retrieve(il_prac_id )



return success
end event

event pfc_validation;call super::pfc_validation;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_validation
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if this.rowcount( ) < 1 THEN RETURN 1


IF ISNULL(THIS.OBJECt.qa_profile_id[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for Profile on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('qa_profile_id')
		RETURN FAILURE
END IF


IF ISNULL(THIS.OBJECt.reason[1]) THEN
		//modify Michael 12.27.2011 Bug id 2837 QA Issues
		//of_Messagebox('Validation Error','Validation Error', 'Required value missing for Reason on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1) 
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for Purpose on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)      
		this.setfocus( )
		setcolumn('reason')
		RETURN FAILURE
END IF

IF ISNULL(THIS.OBJECt.from_date[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for From Date on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('from_date')
		RETURN FAILURE
END IF

IF ISNULL(THIS.OBJECt.to_date[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for To Date on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('to_date')
		RETURN FAILURE
END IF



IF ISNULL(THIS.OBJECt.active_status[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for Active Status on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('active_status')
		RETURN FAILURE
END IF


// make sure the the end date is equal of later then start date
if DaysAfter( date(this.object.from_date[1]), date(this.object.to_date[1]) ) < 0  then
	this.of_messagebox( '', 'Validation Error', 'The to date cannot be less then the From Date', Information! , ok!, 1)
	this.setfocus( )
   //setcolumn('active_status')
	RETURN FAILURE
end if 






return 1
end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : PFC_CHECKREQUIREDERROR
//==================================================================================================================
//  Purpose   	: This event will get the column display name so that it will be properly displayed
//					  in the messagebox
//==================================================================================================================
//  Arguments 	: [long]  	al_row
//					: [string]	as_columnname
//==================================================================================================================
//  Returns   	: [integer]     
//==================================================================================================================
//  Notes     	: 	None    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


this.of_setbase( true)
this.inv_base.of_SetColumnDisplayNameStyle ( 2 )

as_columnname = THIS.INV_base.OF_GETcolumndisplayname( as_columnname )

RETURN 1
end event

type tabpage_report from userobject within tab_measurments
integer x = 18
integer y = 112
integer width = 3895
integer height = 1816
long backcolor = 16777215
string text = "Reports"
long tabtextcolor = 33554432
string picturename = "Cascade!"
long picturemaskcolor = 536870912
cb_about_comp cb_about_comp
ddlb_reports ddlb_reports
dw_report dw_report
cb_3 cb_3
cb_print cb_print
st_2 st_2
cb_run cb_run
end type

on tabpage_report.create
this.cb_about_comp=create cb_about_comp
this.ddlb_reports=create ddlb_reports
this.dw_report=create dw_report
this.cb_3=create cb_3
this.cb_print=create cb_print
this.st_2=create st_2
this.cb_run=create cb_run
this.Control[]={this.cb_about_comp,&
this.ddlb_reports,&
this.dw_report,&
this.cb_3,&
this.cb_print,&
this.st_2,&
this.cb_run}
end on

on tabpage_report.destroy
destroy(this.cb_about_comp)
destroy(this.ddlb_reports)
destroy(this.dw_report)
destroy(this.cb_3)
destroy(this.cb_print)
destroy(this.st_2)
destroy(this.cb_run)
end on

type cb_about_comp from commandbutton within tabpage_report
boolean visible = false
integer x = 1531
integer y = 24
integer width = 521
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About Comparisons"
end type

event clicked;messagebox("About the Comparison reports","Please note that the comparison averages are compiled from the Collected Data only and do not include values manually entered into individual practitioner profiles. ")
end event

type ddlb_reports from dropdownlistbox within tabpage_report
integer x = 384
integer y = 28
integer width = 1083
integer height = 676
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Default","Default without Thresholds","No Department division etc.","No Dept w/o Thresholds","Comparison Department","Comparison Specialty","Comparison Facility"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Start Code Change ----12.20.2011 #V12 maha - added ib_compare variable and cases 5 - 7
choose case index
	case 1
		dw_report.dataobject = "d_rpt_pd_qa_detail_data"
		is_compare = "N"
	case 2
		dw_report.dataobject = "d_rpt_pd_qa_detail_data_no_thresh"
		is_compare = "N"
	case 3
		dw_report.dataobject = "d_rpt_pd_qa_detail_data_no_dept"
		is_compare = "N"
	case 4
		dw_report.dataobject = "d_rpt_pd_qa_detail_data_no_dept_thresh"
		is_compare = "N"
	case 5 // comparison dept
		dw_report.dataobject = "d_rpt_pd_qa_detail_comparison"
		is_compare = "D"
	case 6 //compare spec
		dw_report.dataobject = "d_rpt_pd_qa_detail_comparison"
		is_compare = "S"
	case 7 //compare facility
		dw_report.dataobject = "d_rpt_pd_qa_detail_comparison"
		is_compare = "F"
end choose

if is_compare = "N" then
	cb_about_comp.visible = false	
else
	cb_about_comp.visible = true
end if

dw_report.settransobject(sqlca)
end event

type dw_report from u_dw within tabpage_report
integer y = 156
integer width = 3895
integer height = 1660
integer taborder = 11
string dataobject = "d_rpt_pd_qa_detail_data"
end type

type cb_3 from commandbutton within tabpage_report
integer x = 3305
integer y = 68
integer width = 421
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Output options"
end type

event clicked;m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(dw_report)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90)
end event

type cb_print from commandbutton within tabpage_report
integer x = 2880
integer y = 68
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_report.print()
end event

type st_2 from statictext within tabpage_report
integer x = 9
integer y = 40
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Format"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_run from commandbutton within tabpage_report
integer x = 2505
integer y = 68
integer width = 343
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;//Start Code Change ----12.20.2011 #V12 maha - added comparison functionality
integer r
integer mc
long ll_metric[]
long ll_record
integer li_type[]
integer li_mtype
datetime ld_from
datetime ld_to
decimal ln_val[]
string ls_err

mc = dw_report.retrieve(il_header_id)

if mc = 0 then 
	 //Start Code Change ----09.25.2015 #V15 maha - added trap for missing Appointment connection
	messagebox("Run Report", "The profile is not linked to to the provider's appointment record.  Please click Link Appointment on the Detail tab." )
	return
End if
	

choose case is_compare 
	case "D","S","F"
		for r = 1 to mc
			ll_metric[r] = dw_report.getitemnumber(r,"metric_id")
			li_mtype = dw_report.getitemnumber(r,"data_type")
			if isnull(li_mtype) then li_mtype = 1
			li_type[r] = li_mtype
		next
		ld_from = dw_report.getitemdatetime(1,"pd_qa_hdr_from_date")
		ld_to = dw_report.getitemdatetime(1,"pd_qa_hdr_to_date")
		if is_compare = "D" then
			ll_record = dw_report.getitemnumber(1,"department_id")
			ls_err = "Department Average"
		elseif is_compare = "S" then
			ll_record = dw_report.getitemnumber(1,"specialty_id")
			ls_err = "Specialty Average"
		elseif is_compare = "F" then
			ll_record = dw_report.getitemnumber(1,"parent_facility_id")
			ls_err = "Facility Average"
		end if
		
		if isnull(ll_record) or ll_record = 0 then
			messagebox("Comparison", "There is no " + ls_err + " value to use in the comparison.")
			return
		end if
		
		of_comparison( is_compare, li_type, ll_record, ld_from, ld_to, ll_metric[], ln_val)
		debugbreak()
		for r = 1 to upperbound(ln_val)
			dw_report.setitem(r, "comb_value", ln_val[r])
		next
		
		dw_report.modify("t_comp_type.text = '" + ls_err + "'")
	
end choose

//End Code Change ----12.20.2011
end event

type tabpage_action_items from userobject within tab_measurments
event pfc_cst_letter ( )
boolean visible = false
integer x = 18
integer y = 112
integer width = 3895
integer height = 1816
long backcolor = 16777215
string text = "Action Items"
long tabtextcolor = 33554432
string picturename = "Watcom!"
long picturemaskcolor = 536870912
dw_actions dw_actions
end type

event pfc_cst_letter();str_pass lstr_pass
//lstr_pass.w_parent_window = iw_parent


//if il_prac_id = 0 then
//	OF_Messagebox( '',  iw_parent.title , 'Please select a practitioner before continuing.', information!, ok!, 1)
//	 RETURN 
//end if 

if il_header_id = 0 or isnull(il_header_id) then
	Messagebox( "Action Items" , "Please create a Quality Profile before continuing.", information!, ok!, 1)
	RETURN 
end if

Openwithparm( w_letter_generator,lstr_pass )

if isvalid(w_letter_generator) then
	w_letter_generator.of_quality_profile_letter( il_prac_id, il_header_id, 1 )
end if 


end event

on tabpage_action_items.create
this.dw_actions=create dw_actions
this.Control[]={this.dw_actions}
end on

on tabpage_action_items.destroy
destroy(this.dw_actions)
end on

type dw_actions from u_dw within tabpage_action_items
integer y = 168
integer width = 3895
integer height = 1648
integer taborder = 20
string dataobject = "d_pd_case_review_action_items"
end type

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : contructor dw_1::u_tabpage_measurements_brouse
//==================================================================================================================
//  Purpose   	: Set up needed services for the datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]  not used    
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//ib_rmbmenu	= true

//SETNULL(il_prac_id)
//SETNULL(il_qd_pd_hdr_id)

//this.setrowfocusindicator( p_1)

of_retrieve_dropdowns() //Add by Evan 02.10.2011
end event

event pfc_addrow;call super::pfc_addrow;of_retrieve_dropdowns( )


RETURN 1 
end event

event pfc_retrieve;call super::pfc_retrieve;/****************************************************************************************************************
** [PUBLIC] EVENT   selectionchanged :: UO_TAB_MEASUREMENTS
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] oldindex
**				   [long] newindex
**
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

if isnull(il_header_id) or il_header_id = 0 then return success

if this.rowcount( ) < 1 then
	
	THIS.retrieve(il_header_id)
	//of_retrieve_dropdowns(il_header_id)
	

	else 
		// only retrieve if this a new header id
		if il_header_id <> this.object.pd_qa_hdr_id[1] then 
				THIS.retrieve(il_header_id)
		//   	of_retrieve_dropdowns(il_header_id )
		end if 
		
end if 







return success
end event

event pfc_updateprep;call super::pfc_updateprep;/****************************************************************************************************************
** [PUBLIC] EVENT   PFC_UPDATEPrep( )
**--------------------------------------------------------------------------------------------------------------
** Description	:
**--------------------------------------------------------------------------------------------------------------
** Arguments	:	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Returns		:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author		:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/

LONG LL_ACTION_ID
setnull(LL_ACTION_ID)
long ll_i


IF ISNULL(il_header_id) OR ISNULL(il_prac_id) THEN
	RETURN FAILure
END IF


// RETUERN IF THERE ARE NO ROWS 





//if this.ROWCOUNT() <  1 then return FAILURE

// LOOP THROUGHT THE DATAWINDOW AND SET THE NEEDED IDS
FOR ll_i =1 to this.rowcount( )
	if isnull(this.object.pd_peer_review_action_items_id[ll_i]) and isnull(LL_ACTION_ID) then
		// only get the LL_ACTION_ID -once
//		LL_ACTION_ID  =  OF_get_sequence_number()
		this.object.pd_peer_review_action_items_id[ll_i] =  LL_ACTION_ID
	end if
	
	if isnull(this.object.pd_peer_review_action_items_id[ll_i]) and not isnull(LL_ACTION_ID) THEN
		 // INCREMENT THE ID
	    LL_ACTION_ID =  LL_ACTION_ID + 1
		 this.object.pd_peer_review_action_items_id[ll_i] = LL_ACTION_ID
	END IF
   
	//this.object.pd_qa_hdr_id[ll_i] = il_header_id //Delete by Evan 02.10.2011
	this.object.prac_id[ll_i] = il_prac_id

NEXT


RETURN SUCCESS
end event

event pfc_preupdate;call super::pfc_preupdate;//Add by Evan 02.10.2011

long ll_Row
long ll_pd_qa_hdr_id
long ll_action_items_id

ll_Row = tab_measurments.tabpage_browse.dw_browse.getrow()
if ll_Row < 1 then Return FAILURE
ll_pd_qa_hdr_id = tab_measurments.tabpage_browse.dw_browse.getitemnumber(ll_Row, "pd_qa_hdr_id")

SELECT max(pd_peer_review_action_items_id)
INTO :ll_action_items_id
FROM qa_pd_review_action_items;
if IsNull(ll_action_items_id) then ll_action_items_id = 0

for ll_Row = 1 to this.RowCount()
	if this.GetItemStatus(ll_Row, 0, Primary!) = NewModified! then
		ll_action_items_id ++
		this.SetItem(ll_Row, "pd_peer_review_action_items_id", ll_action_items_id)
		this.SetItem(ll_Row, "pd_qa_hdr_id", ll_pd_qa_hdr_id)		
	end if
next

Return SUCCESS
end event

type cb_filter from commandbutton within pfc_cst_u_qa_new_profiles
boolean visible = false
integer x = 2299
integer y = 192
integer width = 206
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;date ld_from
date ld_to
string ls_filter = ""
integer res

dw_settings.accepttext()
ld_from  = date(dw_settings.getitemdatetime(1,"from_date"))
ld_to  = date(dw_settings.getitemdatetime(1,"to_date"))

if not isnull( ld_from) then
	ls_filter = "from_date >= date('" + string(ld_from) + "')"
end if

if not isnull(ld_from ) and not isnull(ld_to) then
	ls_filter = ls_filter + " and "
end if

if not isnull( ld_to) then
	ls_filter =  ls_filter + "to_date <= date('" + string(ld_to) + "')"
end if

if isnull(ld_from ) and isnull(ld_to) then
	ls_filter = ""
end if
	

res = tab_measurments.tabpage_data.dw_pd_metrics.setfilter(ls_filter)

if res < 1 then
	messagebox("filter failed",ls_filter)
else
	 tab_measurments.tabpage_data.dw_pd_metrics.filter()
end if
end event

