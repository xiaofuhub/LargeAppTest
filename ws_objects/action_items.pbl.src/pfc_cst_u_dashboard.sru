$PBExportHeader$pfc_cst_u_dashboard.sru
forward
global type pfc_cst_u_dashboard from userobject
end type
type st_u_audit from statictext within pfc_cst_u_dashboard
end type
type st_u_over from statictext within pfc_cst_u_dashboard
end type
type st_u_print from statictext within pfc_cst_u_dashboard
end type
type st_u_follow from statictext within pfc_cst_u_dashboard
end type
type st_u_part from statictext within pfc_cst_u_dashboard
end type
type st_u_exp from statictext within pfc_cst_u_dashboard
end type
type st_u_today from statictext within pfc_cst_u_dashboard
end type
type st_user from statictext within pfc_cst_u_dashboard
end type
type st_ai_due_today from statictext within pfc_cst_u_dashboard
end type
type st_time from statictext within pfc_cst_u_dashboard
end type
type cb_1 from commandbutton within pfc_cst_u_dashboard
end type
type dw_query from datawindow within pfc_cst_u_dashboard
end type
type cbx_1 from checkbox within pfc_cst_u_dashboard
end type
type st_miss from statictext within pfc_cst_u_dashboard
end type
type ddplb_1 from dropdownpicturelistbox within pfc_cst_u_dashboard
end type
type st_1 from statictext within pfc_cst_u_dashboard
end type
type st_print from statictext within pfc_cst_u_dashboard
end type
type st_ai_prac_follow_up from statictext within pfc_cst_u_dashboard
end type
type st_ai_par from statictext within pfc_cst_u_dashboard
end type
type st_expiring from statictext within pfc_cst_u_dashboard
end type
type st_6 from statictext within pfc_cst_u_dashboard
end type
type st_7 from statictext within pfc_cst_u_dashboard
end type
type st_9 from statictext within pfc_cst_u_dashboard
end type
type st_ai_over_due from statictext within pfc_cst_u_dashboard
end type
type p_1 from picture within pfc_cst_u_dashboard
end type
type uo_1 from uo_clock within pfc_cst_u_dashboard
end type
type gb_1 from groupbox within pfc_cst_u_dashboard
end type
type gb_2 from groupbox within pfc_cst_u_dashboard
end type
end forward

global type pfc_cst_u_dashboard from userobject
integer width = 1906
integer height = 1724
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_u_audit st_u_audit
st_u_over st_u_over
st_u_print st_u_print
st_u_follow st_u_follow
st_u_part st_u_part
st_u_exp st_u_exp
st_u_today st_u_today
st_user st_user
st_ai_due_today st_ai_due_today
st_time st_time
cb_1 cb_1
dw_query dw_query
cbx_1 cbx_1
st_miss st_miss
ddplb_1 ddplb_1
st_1 st_1
st_print st_print
st_ai_prac_follow_up st_ai_prac_follow_up
st_ai_par st_ai_par
st_expiring st_expiring
st_6 st_6
st_7 st_7
st_9 st_9
st_ai_over_due st_ai_over_due
p_1 p_1
uo_1 uo_1
gb_1 gb_1
gb_2 gb_2
end type
global pfc_cst_u_dashboard pfc_cst_u_dashboard

forward prototypes
public function integer of_query ()
public function integer of_run_action (integer ai_action)
end prototypes

public function integer of_query ();dw_query.SetTransObject( SQLCA )
dw_query.Retrieve( )

DataWindowChild dwchild
Integer li_miss_info_cnt,li_miss_info_cnt1
Integer li_rc
Integer li_nr
Integer li_exp_ltr_cnt,li_exp_ltr_cnt1
Long ll_app_out_to_md
Long ll_ver_method_exp_ltr
Long ll_action_status
Long ll_par
Long ll_app_rcvd_prac
Long ll_app_rcvd_payor
//Start Code Change ---- 02.22.2006 #275 maha
string ls_user_filter
string ls_filter

setpointer(hourglass!)


dw_query.InsertRow( 0)

dw_query.GetChild( "quick_filter", dwchild )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01 
//$<modify> 02.23.2006 By: LeiWei
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'Incomplete' code to the Action Status lookup table." )
END IF

select lookup_code into :ll_par from code_lookup where lookup_name = 'Action Type' and code = 'PAR';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "Adding a 'PAR' code to the Action Type lookup table." )
	select lookup_code_id into :ll_par from ids;
	ll_par++
	update dba_ids set lookup_code_id = :ll_par;
	insert into code_lookup (lookup_code,lookup_name,code,description,custom_1) values (:ll_par,'Action Type','PAR','Participating','PAR');
	commit using sqlca;
END IF

select lookup_code into :ll_app_rcvd_prac from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'App Rcvd Prac' code to the Action Type lookup table." )
END IF

select lookup_code into :ll_app_rcvd_payor from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Payor';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'App Rcvd Payor' code to the Action Type lookup table." )
END IF

select lookup_code into :ll_app_out_to_md from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'PAR' code to the Action Type lookup table." )
END IF
*/

ll_action_status = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Incomplete')"))
IF ll_action_status = 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	MessageBox("Lookup missing", "You will need to add a 'Incomplete' code to the Action Status lookup table." )
	*/
	MessageBox("Lookup missing", "You will need to add an 'Incomplete' code to the Action Status lookup table." )
	//---------------------------- APPEON END ----------------------------
END IF

ll_par = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Type') and upper(code) = upper('PAR')"))
IF ll_par = 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	MessageBox("Lookup missing", "Adding a 'PAR' code to the Action Type lookup table." )
	*/
	MessageBox("Lookup missing", "You will need to add a 'PAR' code to the Action Type lookup table." )
	//---------------------------- APPEON END ----------------------------
	select lookup_code_id into :ll_par from ids;
	ll_par++
	
	gnv_appeondb.of_startqueue( )
	
	update ids set lookup_code_id = :ll_par;
	insert into code_lookup (lookup_code,lookup_name,code,description,custom_1) values (:ll_par,'Action Type','PAR','Participating','PAR');
	commit using sqlca;
	
	gnv_appeondb.of_commitqueue( )
END IF

ll_app_rcvd_prac = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Type') and upper(code) = upper('App Rcvd Prac')"))
IF ll_app_rcvd_prac = 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	MessageBox("Lookup missing", "You will need to add a 'App Rcvd Prac' code to the Action Type lookup table." )
	*/
	MessageBox("Lookup missing", "You will need to add an 'App Rcvd Prac' code to the Action Type lookup table." )
	//---------------------------- APPEON END ----------------------------
END IF

ll_app_rcvd_payor = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Type') and upper(code) = upper('App Rcvd Payor')"))
IF ll_app_rcvd_payor = 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	MessageBox("Lookup missing", "You will need to add a 'App Rcvd Payor' code to the Action Type lookup table." )
	*/
	MessageBox("Lookup missing", "You will need to add an 'App Rcvd Payor' code to the Action Type lookup table." )
	//---------------------------- APPEON END ----------------------------
END IF

ll_app_out_to_md = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Type') and upper(code) = upper('App Out To MD')"))
IF ll_app_out_to_md = 0 THEN
	MessageBox("Lookup missing", "You will need to add an 'App Out To MD' code to the Action Type lookup table." ) ////Start Code Change ----05.04.2009 #V92 maha - corrected message; changed from PAR
END IF

//---------------------------- APPEON END ----------------------------


st_user.text = gs_user_id
////Due Today
//li_nr = dwchild.InsertRow( 0 )
//dwchild.SetItem( li_nr, "filter_code", "Items Due TODAY" )
//dwchild.SetItem( li_nr, "filter_description", "Displays a list of Action Item due TODAY." )
//dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND DaysAfter( due_date, today() ) = 0 AND action_status = " + String( ll_action_status )  )

//Start Code Change ----08.10.2010 #V10 maha - made user id non case-sensitive
//ls_user_filter = " and action_user = '" + gs_user_id + "'"
ls_user_filter = " and lower(action_user) = '" + lower( gs_user_id ) + "'" 
//Start Code Change ----08.10.2010

//Due Today
//ls_filter = "active_status = 1 AND DaysAfter( due_date, today() ) = 0 AND action_status = " + String( ll_action_status )
ls_filter = "DaysAfter( due_date, today() ) = 0"
dw_query.SetFilter( ls_filter )
dw_query.Filter( )
li_rc = dw_query.RowCount( )
st_ai_due_today.Text = "There Are " + String( li_rc ) + " Application Action items due Today"
dw_query.SetFilter( ls_filter + ls_user_filter )
dw_query.Filter( )
st_u_today.text = string(dw_query.rowcount())

//You have # Application Status action items over due
//ls_filter =  "active_status = 1 AND DaysAfter( today(), due_date ) < 0 AND action_status = " + String( ll_action_status ) 
ls_filter =  "DaysAfter( today(), due_date ) < 0 "
dw_query.SetFilter(ls_filter)
dw_query.Filter( )
li_rc = dw_query.RowCount( )
st_ai_over_due.Text = "There Are " + String( li_rc ) + " Application Action items Overdue"
dw_query.SetFilter( ls_filter + ls_user_filter )
dw_query.Filter( )
st_u_over.text = string(dw_query.rowcount())

//You have # App Rcvd Prac follow letters to send
//ls_filter =  "active_status = 1 AND action_type = " + String( ll_app_rcvd_prac ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status )  
ls_filter =  "action_type = " + String( ll_app_rcvd_prac ) + " AND DaysAfter( today(), due_date ) <= 0 "
dw_query.SetFilter(ls_filter)
dw_query.Filter( )
li_rc = dw_query.RowCount( )
st_ai_prac_follow_up.Text = "There Are " + String( li_rc ) + " App Rcvd Prac follow up letters to send"
dw_query.SetFilter( ls_filter + ls_user_filter )
dw_query.Filter( )
st_u_follow.text = string(dw_query.rowcount())

//You have # Participation follow letters to send
//ls_filter =  "active_status = 1 AND action_type = " + String( ll_par ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status ) 
ls_filter =  "action_type = " + String( ll_par ) + " AND DaysAfter( today(), due_date ) <= 0 "
dw_query.SetFilter(ls_filter)
dw_query.Filter( )
li_rc = dw_query.RowCount( )
st_ai_par.Text = "There Are " + String( li_rc ) + " Participation follow up letters to send"
dw_query.SetFilter( ls_filter + ls_user_filter )
dw_query.Filter( )
st_u_part.text = string(dw_query.rowcount())

//You have # applications to print
//"active_status = 1 AND action_type = " + String( ll_app_out ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status )  )
//ls_filter =  "active_status = 1 AND action_type = " + String( ll_app_out_to_md ) + "  AND action_status = " + String( ll_action_status ) 
ls_filter =  "action_type = " + String( ll_app_out_to_md ) 
//dw_query.SetFilter( "active_status = 1 AND action_type = " + String( ll_app_out_to_md ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status ) )
dw_query.SetFilter(ls_filter)
dw_query.Filter( )
li_rc = dw_query.RowCount( )
st_print.Text = "There Are " + String( li_rc ) + " Applications to print"
dw_query.SetFilter( ls_filter + ls_user_filter )
dw_query.Filter( )
st_u_print.text = string(dw_query.rowcount())

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02 
//$<modify> 02.23.2006 By: LeiWei
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT code_lookup.lookup_code  
INTO :ll_ver_method_exp_ltr
FROM code_lookup  
WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
      ( code_lookup.code = 'EXP CRED LTR'  ) ; 
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
	RETURN -1
END IF
*/

//expiring credentials
ll_ver_method_exp_ltr = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('verification method') and upper(code) = upper('EXP CRED LTR')"))

//---------------------------- APPEON END ----------------------------

//SELECT distinct Count( rec_id )
//INTO :li_exp_ltr_cnt
//FROM verif_info
//WHERE verif_info.print_flag = 1 AND verif_info.verification_method = :ll_ver_method_exp_ltr and verif_info.response_code IS NULL and active_status = 1; //maha modified 102904

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 02.23.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

//maha modified to better match ai graph
SELECT count( distinct verif_info.doc_id)//Start Code Change ---- 05.03.2006 #428 maha added distinct
 INTO :li_exp_ltr_cnt
    FROM verif_info,
			pd_affil_stat,
			security_user_facilities  
   WHERE 
			( security_user_facilities.facility_id = pd_affil_stat.parent_facility_id ) and
			( security_user_facilities.access_rights = 1 ) AND
			( security_user_facilities.user_id = :gs_user_id) and
        ( verif_info.facility_id = pd_affil_stat.verifying_facility ) and  
			( verif_info.prac_id = pd_affil_stat.prac_id ) and
			( pd_affil_stat.active_status  in (1,4) ) AND
         ( verif_info.active_status = 1 ) AND
			
			( verif_info.response_code is null ) AND
			( verif_info.verification_method = :ll_ver_method_exp_ltr ) AND
			( verif_info.print_flag = 1 ) ;

//st_expiring.Text = "There Are " + String( li_exp_ltr_cnt) + " Expiring Credential letters to send"

///\/maha 022206
SELECT count( verif_info.doc_id)
 INTO :li_exp_ltr_cnt1
    FROM verif_info,
			pd_affil_stat,
			security_user_facilities  
   WHERE 
			( security_user_facilities.facility_id = pd_affil_stat.parent_facility_id ) and
			( security_user_facilities.access_rights = 1 ) AND
			( security_user_facilities.user_id = :gs_user_id) and
        ( verif_info.facility_id = pd_affil_stat.verifying_facility ) and  
			( verif_info.prac_id = pd_affil_stat.prac_id ) and
			( pd_affil_stat.active_status  in (1,4) ) AND
         ( verif_info.active_status = 1 ) AND
			
			( verif_info.response_code is null ) AND
			( verif_info.verification_method = :ll_ver_method_exp_ltr ) AND
			( verif_info.print_flag = 1 and
			verif_info.priority_user = :gs_user_id) ;

//st_u_exp.text = string(li_exp_ltr_cnt1)

//\maha
//You have # Missing Information Items
SELECT DISTINCT Count( pd_app_audit.facility_id )
INTO :li_miss_info_cnt
FROM pd_app_audit,   
     data_view_app_audit,   
     pd_affil_stat,   
     v_full_name,   
     facility  
WHERE ( data_view_app_audit.app_audit_id = pd_app_audit.app_audit_id ) and  
//      ( pd_affil_stat.apptmnt_type = data_view_app_audit.app_type ) and    //Start Code Change ----02.21.2014 #V14 maha - removed   
      ( pd_affil_stat.rec_id = pd_app_audit.appt_stat_id ) and  
      ( pd_app_audit.prac_id = v_full_name.prac_id ) and  
      ( pd_app_audit.facility_id = facility.facility_id ) and  
      ( ( pd_app_audit.date_completed is null ) AND  
      ( pd_affil_stat.active_status in (1,4) ) AND  
      ( pd_affil_stat.apptmnt_start_date is null ));

//st_miss.Text = "There Are " + String( li_miss_info_cnt ) + " Missing Information Items"

SELECT DISTINCT Count( pd_app_audit.facility_id )
INTO :li_miss_info_cnt1
FROM pd_app_audit,   
     data_view_app_audit,   
     pd_affil_stat,   
     v_full_name,   
     facility  
WHERE ( data_view_app_audit.app_audit_id = pd_app_audit.app_audit_id ) and  
//      ( pd_affil_stat.apptmnt_type = data_view_app_audit.app_type ) and    //Start Code Change ----02.21.2014 #V14 maha - removed   
      ( pd_affil_stat.rec_id = pd_app_audit.appt_stat_id ) and  
      ( pd_app_audit.prac_id = v_full_name.prac_id ) and  
      ( pd_app_audit.facility_id = facility.facility_id ) and  
      ( ( pd_app_audit.date_completed is null ) AND  
      ( pd_affil_stat.active_status in (1,4) ) AND  
      ( pd_affil_stat.apptmnt_start_date is null )
		and pd_affil_stat.priority_user = :gs_user_id) ;

//st_u_audit.text = string(li_exp_ltr_cnt2)
//End Code Change---02.22.2006
		
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 02.23.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//$<reason> Add an Appeon Commit Queue Label. 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

st_expiring.Text = "There Are " + String( li_exp_ltr_cnt) + " Expiring Credential letters to send"
st_u_exp.text = string(li_exp_ltr_cnt1)
st_miss.Text = "There Are " + String( li_miss_info_cnt ) + " Incomplete Checklist Items"
st_u_audit.text = string(li_miss_info_cnt1)	//Start Code Change ----01.03.2008 #V8 maha - corrected variable
st_time.Text = "Last refreshed " + String( Now( ), "hh:mm" )

//Application Not Back From Provider
//li_nr = dwchild.InsertRow( 0 )
//dwchild.SetItem( li_nr, "filter_code", "Applications Not Back From Provider" )
//dwchild.SetItem( li_nr, "filter_description", "Displays a list of App Rcvd Prac Action Item that are overdue." )
//dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_app_rcvd_prac ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status )  )
//dwchild.SetItem( li_nr, "filter_index", 2  )
//
////Items Due in the next 7 days
//li_nr = dwchild.InsertRow( 0 )
//dwchild.SetItem( li_nr, "filter_code", "Items Due in the next 7 days" )
//dwchild.SetItem( li_nr, "filter_description", "Displays a list of Action Item that are due in the next 7 days." )
//dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND DaysAfter( today(), due_date ) >= 0 AND DaysAfter( RelativeDate(today(),7), due_date ) <= 7 AND action_status = " + String( ll_action_status )  )
//dwchild.SetItem( li_nr, "filter_index", 4  )
setpointer(arrow!)

Return 1
end function

public function integer of_run_action (integer ai_action);//function created maha 101204
//Start Code Change ---- 03.27.2006 #344 maha redundant call corrected
w_dash.WindowState = Minimized!
IF gs_cust_type = "I" THEN
	IF Not IsValid( w_action_items_ia ) THEN
		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
		w_action_items_ia.ii_dashboard_macro = ai_action
	else
		w_action_items_ia.ii_dashboard_macro = ai_action
		w_action_items_ia.Event pfc_postopen()
	END IF
ELSE
	IF Not IsValid( w_action_items ) THEN
		OpenSheetWithParm( w_action_items, 99, w_mdi, 4, Layered! )
		w_action_items.ii_dashboard_macro = ai_action
	else
		w_action_items.ii_dashboard_macro = ai_action
		w_action_items.Event pfc_postopen( )
	end if
END IF
//End Code Change---03.27.2006
return 1
end function

on pfc_cst_u_dashboard.create
this.st_u_audit=create st_u_audit
this.st_u_over=create st_u_over
this.st_u_print=create st_u_print
this.st_u_follow=create st_u_follow
this.st_u_part=create st_u_part
this.st_u_exp=create st_u_exp
this.st_u_today=create st_u_today
this.st_user=create st_user
this.st_ai_due_today=create st_ai_due_today
this.st_time=create st_time
this.cb_1=create cb_1
this.dw_query=create dw_query
this.cbx_1=create cbx_1
this.st_miss=create st_miss
this.ddplb_1=create ddplb_1
this.st_1=create st_1
this.st_print=create st_print
this.st_ai_prac_follow_up=create st_ai_prac_follow_up
this.st_ai_par=create st_ai_par
this.st_expiring=create st_expiring
this.st_6=create st_6
this.st_7=create st_7
this.st_9=create st_9
this.st_ai_over_due=create st_ai_over_due
this.p_1=create p_1
this.uo_1=create uo_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_u_audit,&
this.st_u_over,&
this.st_u_print,&
this.st_u_follow,&
this.st_u_part,&
this.st_u_exp,&
this.st_u_today,&
this.st_user,&
this.st_ai_due_today,&
this.st_time,&
this.cb_1,&
this.dw_query,&
this.cbx_1,&
this.st_miss,&
this.ddplb_1,&
this.st_1,&
this.st_print,&
this.st_ai_prac_follow_up,&
this.st_ai_par,&
this.st_expiring,&
this.st_6,&
this.st_7,&
this.st_9,&
this.st_ai_over_due,&
this.p_1,&
this.uo_1,&
this.gb_1,&
this.gb_2}
end on

on pfc_cst_u_dashboard.destroy
destroy(this.st_u_audit)
destroy(this.st_u_over)
destroy(this.st_u_print)
destroy(this.st_u_follow)
destroy(this.st_u_part)
destroy(this.st_u_exp)
destroy(this.st_u_today)
destroy(this.st_user)
destroy(this.st_ai_due_today)
destroy(this.st_time)
destroy(this.cb_1)
destroy(this.dw_query)
destroy(this.cbx_1)
destroy(this.st_miss)
destroy(this.ddplb_1)
destroy(this.st_1)
destroy(this.st_print)
destroy(this.st_ai_prac_follow_up)
destroy(this.st_ai_par)
destroy(this.st_expiring)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_9)
destroy(this.st_ai_over_due)
destroy(this.p_1)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event constructor;Openwithparm(w_open_message,"Retrieving Task List Data") //Start Code Change ---07.23.2009 #V92 maha
of_query( )
close(w_open_message)
end event

type st_u_audit from statictext within pfc_cst_u_dashboard
integer x = 1650
integer y = 668
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u_over from statictext within pfc_cst_u_dashboard
integer x = 1650
integer y = 216
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u_print from statictext within pfc_cst_u_dashboard
integer x = 1650
integer y = 308
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u_follow from statictext within pfc_cst_u_dashboard
integer x = 1650
integer y = 396
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u_part from statictext within pfc_cst_u_dashboard
integer x = 1650
integer y = 488
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u_exp from statictext within pfc_cst_u_dashboard
integer x = 1650
integer y = 580
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u_today from statictext within pfc_cst_u_dashboard
integer x = 1650
integer y = 128
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_user from statictext within pfc_cst_u_dashboard
integer x = 1417
integer width = 421
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "user"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_ai_due_today from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 128
integer width = 1477
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "You have # Application Status action items due Today"
boolean focusrectangle = false
end type

event clicked;//w_mdi.SetRedraw( false )
//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 0
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(0)
end event

type st_time from statictext within pfc_cst_u_dashboard
integer x = 389
integer y = 772
integer width = 672
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 8421504
long backcolor = 33551856
string text = "Last Refreshed 10:00am"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within pfc_cst_u_dashboard
integer x = 114
integer y = 768
integer width = 247
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string text = "&Refresh"
end type

event clicked;of_query( )
end event

type dw_query from datawindow within pfc_cst_u_dashboard
boolean visible = false
integer x = 1477
integer y = 696
integer width = 311
integer height = 200
integer taborder = 40
string dataobject = "d_net_dev_actions_tasklist"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within pfc_cst_u_dashboard
boolean visible = false
integer x = 123
integer y = 724
integer width = 914
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
string text = "Automatically retrieve on open"
boolean checked = true
end type

type st_miss from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 668
integer width = 1531
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "You have # Incomplete Checklist Items"
boolean focusrectangle = false
end type

event clicked;//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 10
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(10)
end event

type ddplb_1 from dropdownpicturelistbox within pfc_cst_u_dashboard
boolean visible = false
integer x = 78
integer y = 84
integer width = 1783
integer height = 728
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom039!"}
long picturemaskcolor = 536870912
end type

type st_1 from statictext within pfc_cst_u_dashboard
boolean visible = false
integer x = 73
integer y = 20
integer width = 677
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Go to Practitioner Folder"
boolean focusrectangle = false
end type

type st_print from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 308
integer width = 1486
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "You have # Applications to print"
boolean focusrectangle = false
end type

event clicked;if IsValid(  w_IntelliApp_Print ) THEN  //Start Code Change ----01.03.2008 #V8 maha -- added exceprion if window already open
	w_intelliapp_print.uo_print.ii_open_from_dash = 0
	w_intelliapp_print.uo_print.tab_1.tabpage_pl.dw_print.reset()
	w_intelliapp_print.uo_print.tab_1.tabpage_pl.cb_add.Event Clicked( )
else
	Open( w_IntelliApp_Print )
	w_intelliapp_print.uo_print.ii_open_from_dash = 0
	w_intelliapp_print.uo_print.tab_1.tabpage_pl.cb_add.Event Clicked( )
end if

//IF IsValid( w_dash ) THEN 
//	w_dash.WindowState = Minimized!
//END IF
end event

type st_ai_prac_follow_up from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 396
integer width = 1531
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "You have # App Rcvd Prac follow letters to send"
boolean focusrectangle = false
end type

event clicked;//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 3
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(3)
end event

type st_ai_par from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 488
integer width = 1531
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "You have # Participation follow letters to send"
boolean focusrectangle = false
end type

event clicked;//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 4
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(4)
end event

type st_expiring from statictext within pfc_cst_u_dashboard
integer x = 119
integer y = 580
integer width = 1531
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "You have # Expiring letters to send"
boolean focusrectangle = false
end type

event clicked;//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 5
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(5)
end event

type st_6 from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 1052
integer width = 1157
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 8388736
long backcolor = 33551856
string text = "Application Status Report by Payor"
boolean focusrectangle = false
end type

event clicked;//w_mdi.SetRedraw( false )
//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 7
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(7)
end event

type st_7 from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 960
integer width = 1303
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 8388736
long backcolor = 33551856
string text = "Application Status Report by Practitioner"
boolean focusrectangle = false
end type

event clicked;////w_mdi.SetRedraw( false )
//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 6
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(6)
end event

type st_9 from statictext within pfc_cst_u_dashboard
boolean visible = false
integer x = 123
integer y = 1140
integer width = 1303
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 8388736
long backcolor = 33551856
string text = "Plan Participation Status Report"
boolean focusrectangle = false
end type

event clicked;of_run_action(8)
end event

type st_ai_over_due from statictext within pfc_cst_u_dashboard
integer x = 123
integer y = 216
integer width = 1477
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "You have # Application Status action items over due"
boolean focusrectangle = false
end type

event clicked;//w_mdi.SetRedraw( false )
//IF gs_cust_type = "I" THEN
//	IF Not IsValid( w_action_items_ia ) THEN
//		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
//	END IF
//	w_action_items_ia.ii_dashboard_macro = 1
//	w_action_items_ia.Event pfc_postopen( )	
//ELSE
//	//OpenSheet( w_action_items,  w_mdi, 4)
//END IF
//
//w_dash.WindowState = Minimized!
of_run_action(1)
end event

type p_1 from picture within pfc_cst_u_dashboard
integer x = 544
integer y = 1292
integer width = 1289
integer height = 356
string picturename = "logo.bmp"
boolean focusrectangle = false
end type

type uo_1 from uo_clock within pfc_cst_u_dashboard
integer x = 59
integer y = 1284
integer width = 434
integer height = 376
integer taborder = 20
borderstyle borderstyle = styleraised!
end type

on uo_1.destroy
call uo_clock::destroy
end on

type gb_1 from groupbox within pfc_cst_u_dashboard
integer x = 69
integer y = 32
integer width = 1774
integer height = 824
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
string text = "Action Items"
end type

type gb_2 from groupbox within pfc_cst_u_dashboard
integer x = 73
integer y = 880
integer width = 1774
integer height = 360
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
string text = "Reports"
end type

