$PBExportHeader$pfc_cst_u_multi_app_select.sru
forward
global type pfc_cst_u_multi_app_select from pfc_cst_u_multi_app_painter_new
end type
type cb_ok from commandbutton within pfc_cst_u_multi_app_select
end type
type cb_cancel from commandbutton within pfc_cst_u_multi_app_select
end type
type cb_1 from commandbutton within pfc_cst_u_multi_app_select
end type
type gb_3 from groupbox within pfc_cst_u_multi_app_select
end type
type dw_action_type from u_dw within pfc_cst_u_multi_app_select
end type
type cb_2 from commandbutton within pfc_cst_u_multi_app_select
end type
type cbx_addr from checkbox within pfc_cst_u_multi_app_select
end type
type cbx_complete from checkbox within pfc_cst_u_multi_app_select
end type
type cb_dept from commandbutton within pfc_cst_u_multi_app_select
end type
type dw_facility_add from u_dw within pfc_cst_u_multi_app_select
end type
type dw_staff_cat from u_dw within pfc_cst_u_multi_app_select
end type
type dw_departments from u_dw within pfc_cst_u_multi_app_select
end type
type dw_cat_add from u_dw within pfc_cst_u_multi_app_select
end type
type dw_dept_add from u_dw within pfc_cst_u_multi_app_select
end type
type dw_user from u_dw within pfc_cst_u_multi_app_select
end type
type dw_tracking from datawindow within pfc_cst_u_multi_app_select
end type
type st_1 from statictext within pfc_cst_u_multi_app_select
end type
type dw_dept_cat from u_dw within pfc_cst_u_multi_app_select
end type
type gb_2 from groupbox within pfc_cst_u_multi_app_select
end type
end forward

global type pfc_cst_u_multi_app_select from pfc_cst_u_multi_app_painter_new
integer width = 4471
integer height = 2488
boolean border = false
long backcolor = 33551856
cb_ok cb_ok
cb_cancel cb_cancel
cb_1 cb_1
gb_3 gb_3
dw_action_type dw_action_type
cb_2 cb_2
cbx_addr cbx_addr
cbx_complete cbx_complete
cb_dept cb_dept
dw_facility_add dw_facility_add
dw_staff_cat dw_staff_cat
dw_departments dw_departments
dw_cat_add dw_cat_add
dw_dept_add dw_dept_add
dw_user dw_user
dw_tracking dw_tracking
st_1 st_1
dw_dept_cat dw_dept_cat
gb_2 gb_2
end type
global pfc_cst_u_multi_app_select pfc_cst_u_multi_app_select

type variables
w_multi_app_select iw_win2

long il_action
long il_prac_id
string is_user //maha 06.18.2014
boolean ib_dept = false //maha 07.03.2014
long il_dept = 0  //maha 04.22.2016

datastore ids_net_dev_action_items //Added by Appeon long.zhang 12.26.2014

pfc_cst_nv_data_entry_functions inv_data_entry  //Added by Appeon long.zhang 12.26.2014
end variables

forward prototypes
public function integer of_multi_add ()
public function integer of_add_dept_cat (long al_facility, long al_recid, integer ai_status)
public function integer of_appl_action_create (long ai_facility_id, long ai_app_id, string as_app_name, string as_action_type, long ai_rec_id, long al_loc, string as_apt_type, boolean ab_complete)
end prototypes

public function integer of_multi_add ();//Start Code Change ----07.02.2014 #V14.2 maha - code copied from provider folder

Long z
Long li_rc
Long li_fac_cnt = 0
Long f
Long li_user 
Long li_facility_id
Long li_facility_cnt
Long li_address_cnt
Long li_cnt
Long i
Long li_facility_ids[]
Long li_ver_facility
Long li_app_audit_facility 
Long ll_rec_id
long ll_pracids[]
long li_action_type			
Long ll_action_status
Long ll_action_dept
long	ll_recid_app 
Long ll_loc_id
long ll_template 
long ll_app_ids[]
long ll_locations[]
long ll_find , ll_id_count
long li_app_id
integer c //maha 07.15.2014
String ls_app_type
string ls_app_name //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
String ls_action_notes
string ls_assn_user
string ls_appt_stat = 'M'  //maha 08.07.2014
DateTime ldt_action_date
Boolean lb_facility_created
boolean lb_create_address = false
boolean lb_complete  //maha 07.02.2014
gs_pass_ids lstr_ids
datastore lds_facility
datastore lds_facility_add
datastore lds_cred_comms
datastore lds_cred_committees
n_ds lds_facility_cnt
//pfc_cst_nv_data_entry_functions inv_data_entry //Define it as an Instance Variable already, comment by Appeon long.zhang 06.01.2015
gs_pass_ids istr_ids

//inv_data_entry = create pfc_cst_nv_data_entry_functions  //comment by Appeon long.zhang 06.01.2015

dw_app_data.AcceptText()

li_rc = dw_app_data.RowCount()

FOR i = 1 TO li_rc
	IF dw_app_data.GetItemNumber( i, "selected" ) = 1 THEN
		li_cnt++
		li_facility_ids[li_cnt] = dw_app_data.GetItemNumber( i, "parent_facility_id" )
		ll_locations[li_cnt] = dw_app_data.GetItemNumber( i, "gp_id" )
	END IF
END FOR

li_cnt = UpperBound( li_facility_ids )

li_action_type = il_action

if cbx_addr.checked then
	lb_create_address = true
end if

if cbx_complete.checked then
	lb_complete = true
end if

dw_facility_add.reset()  
li_facility_cnt = -9

//Add Appeon start queue label
gnv_appeondb.of_startqueue()

//get provider facilities
lds_facility_cnt = create n_ds
lds_facility_cnt.dataobject= "d_pd_affil_stat_parent_facility_id_cnt"
lds_facility_cnt.settransobject(SQLCA)
li_facility_cnt = lds_facility_cnt.retrieve(il_prac_id , li_facility_ids[])

//facility data
lds_facility = create datastore
lds_facility.dataobject = 'd_facility_id_list'
lds_facility.settransobject(SQLCA)
lds_facility.retrieve(li_facility_ids[])

//committees for facilities
lds_cred_comms = create datastore
lds_cred_comms.dataobject = 'd_dddw_credentialing_committees_all_pt'
lds_cred_comms.settransobject(sqlca)
lds_cred_comms.retrieve(li_facility_ids[])

lds_cred_committees = create datastore
lds_cred_committees.dataobject = 'd_pd_comm_review'
lds_cred_committees.settransobject(sqlca)



gnv_appeondb.of_commitqueue()

//get count of facilities provider does not have
//@@@@@@@@@@@@ problem with the following funciton
ll_id_count = inv_data_entry.of_get_id_count(lds_facility_cnt , li_facility_ids[])
If ll_id_count > 0 Then ll_rec_id = gnv_app.of_Get_Id("RECORD_ID" , ll_id_count) - 1

//recids for apps
ll_recid_app = gnv_app.of_Get_Id("RECORD_ID" , li_cnt ) - 1

//gnv_appeondb.of_startqueue() //Comment by Appeon long.zhang 06.01.2015 (V14.2 Bug 4545 -Tracker Retrieval error message when using MultiApp)


dw_facility_add.settransobject(sqlca)
//li_cnt = lds_template.rowcount()

FOR i = 1 TO li_rc
	IF dw_app_data.GetItemNumber( i, "selected" ) = 1 THEN
		li_facility_id = dw_app_data.GetItemNumber( i, "parent_facility_id" )
		li_app_id = dw_app_data.GetItemNumber( i, "app_id" )
		ls_app_name = dw_app_data.describe("evaluate('lookupdisplay(app_id)',"+string( i)+")") //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
		ll_loc_id =dw_app_data.GetItemNumber( i, "gp_id" )
		z = 0
		
		//for create addresses get unique locations
		if lb_create_address then
			if ll_loc_id > 0 then
				for f = 1 to upperbound(ll_locations[])
					if ll_loc_id = ll_locations[f] then
						z = 1
						exit
					end if
				next
				if z = 0 then ll_locations[upperbound(ll_locations) + 1] = ll_loc_id
			end if
			ll_pracids[1] = il_prac_id
		end if
	
		//set facility key fields
		IF gs_cust_type = "I" THEN
			li_app_audit_facility = 1   
			li_ver_facility = 1
			ls_app_type = "I"
		ELSE   //Start Code Change ----05.19.2014 #V14.2 maha - check record first then facility defaults
			li_app_audit_facility = dw_app_data.getitemnumber(i, "application_audit_facility")
			li_ver_facility = dw_app_data.getitemnumber(i, "verifying_facility")
			ls_app_type = dw_app_data.getitemstring(i, "apptmnt_type")
				
			ll_find = lds_facility.find( "facility_id="+string(li_facility_id), 1,lds_facility.RowCount())
			
			if isnull(li_app_audit_facility ) then 
				If ll_find > 0 Then
					li_app_audit_facility = lds_facility.getitemnumber(ll_find,'default_audit_temp')
				else
					li_app_audit_facility = 1
				end if
			end if
			
			if isnull(li_ver_facility ) then 
				If ll_find > 0 Then
					li_ver_facility = lds_facility.getitemnumber(ll_find,'default_audit_temp')
				else
					li_ver_facility = 1
				end if
			end if
			
			//Start Code Change ----08.07.2014 #V14.2 maha - added
			If ll_find > 0 Then
				ls_appt_stat = lds_facility.getitemstring(ll_find,'default_affil_status')
				if isnull(ls_appt_stat) or len(ls_appt_stat) < 1 then ls_appt_stat = 'M'
			End if
			//Start Code Change ----08.07.2014 
			
			if isnull(ls_app_type ) then ls_app_type = "I"
			
		END IF //key fields
	
	
	//check if the provider has the facility
		ll_find = lds_facility_cnt.find( "parent_facility_id="+string(li_facility_id), 1,lds_facility_cnt.RowCount())
		If ll_find > 0 Then
			li_facility_cnt = ll_find   
		else
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 11.06.2014
			//<$>reason:V14.2 testing - Bug # 4282 / Multi App Template inserts four items for every one
			//li_facility_cnt = 0
			ll_find = dw_facility_add.find( "parent_facility_id="+string(li_facility_id), 1,dw_facility_add.RowCount())
			If ll_find > 0 then
				li_facility_cnt = ll_find
			Else
				li_facility_cnt = 0
			End If
			//------------------- APPEON END -------------------		
		end if

	//create facility if required	
		if li_facility_cnt = 0 then
			ll_rec_id++
			dw_facility_add.insertrow(1)
			dw_facility_add.setitem(1,"rec_id",ll_rec_id)
			dw_facility_add.setitem(1,"prac_id",il_prac_id)
			dw_facility_add.setitem(1,"seq_no",1)
			dw_facility_add.setitem(1,"affiliation_status", ls_appt_stat)  //Start Code Change ----08.07.2014 #V14.2 maha - dw_facility_add.setitem(1,"affiliation_status","M")		
			dw_facility_add.setitem(1,"parent_facility_id",li_facility_id) 
			dw_facility_add.setitem(1,"apptmnt_type", ls_app_type)
			dw_facility_add.setitem(1,"verifying_facility",li_ver_facility)
			dw_facility_add.setitem(1,"application_audit_facility",li_app_audit_facility)
			dw_facility_add.setitem(1,"active_status",1)
			dw_facility_add.setitem(1,"priority",1)
			dw_facility_add.setitem(1,"priority_user",is_user)
	
			if gs_cust_type <> "I" then  //cred customers only
				//Committee records
				lds_cred_comms.setfilter("facility_id=" + string(li_facility_id))
				lds_cred_comms.filter( )
					// trap if more than 1 facility records are added
				
				for c = 1 to lds_cred_comms.rowcount()
					f = lds_cred_committees.insertrow(0)
					lds_cred_committees.setitem( f ,"facility_id", li_facility_id )
					lds_cred_committees.setitem( f ,"committee_id", lds_cred_comms.getitemnumber(c,'committee_id') )
					lds_cred_committees.setitem( f ,"prac_id",il_prac_id )
					lds_cred_committees.setitem( f ,"rec_id", ll_rec_id )
					lds_cred_committees.setitem( f ,"seq_no", c )
					lds_cred_committees.setitem( f ,"active_status", 1 )
				next
				
				if ib_dept  then
					of_add_dept_cat(li_facility_id, ll_rec_id, 1)
				end if
			end if //cred only
		
					
			//checklist creation
			IF inv_data_entry.of_create_checklist(  li_app_audit_facility, "I", ll_rec_id, li_facility_id, il_prac_id)  = -1 THEN
				Return -1
			END IF
		END IF //facility creation
		

	
	//Application Actions
		ll_recid_app++
		if of_appl_action_create( li_facility_id,  li_app_id ,ls_app_name,  string(li_action_type) ,ll_recid_app, ll_loc_id, ls_app_type, lb_complete) = -1 THEN  //(Appeon)Stephen 07.21.2017 - add"ls_app_name" Critical performance issue with workflow action completion//Start Code Change ----05.05.2014 #V14.2 maha - added loc id  //Start Code Change ----04.16.2008 #V8 maha - corrected for variable
			Return -1
		END IF
	End If //selected

END FOR

gnv_appeondb.of_startqueue() //Added by Appeon long.zhang 06.01.2015 (V14.2 Bug 4545 -Tracker Retrieval error message when using MultiApp)

//messagebox("cnt",dw_facility_add.rowcount())
dw_facility_add.update() 
lds_cred_committees.update()
if ib_dept  then
	dw_dept_add.update()
	dw_cat_add.update()
end if
gnv_appeondb.of_commitqueue()

//Create new address records from locations
if lb_create_address then
	for f = 1 to upperbound(ll_locations[])
		ll_loc_id = ll_locations[f]
		if ll_loc_id > 0 then  //Start Code Change ----06.13.2016 #V152 maha - trap added
			of_create_address_from_location(ll_pracids[], ll_loc_id, "") //program function
		end if
	next
end if


destroy lds_facility_cnt
destroy lds_cred_committees
destroy lds_cred_comms
destroy lds_facility

MessageBox( "Data Links", "Make sure you update your Address, Hospital and Specialty links for the new Payer/Hospitals you have added.", Information! )

inv_data_entry.of_add_data_links(il_prac_id, "Multi")

//destroy inv_data_entry //comment by Appeon long.zhang 06.01.2015

Return 1

end function

public function integer of_add_dept_cat (long al_facility, long al_recid, integer ai_status);//Start Code Change ----07.14.2014 #V14.2 maha - added function
integer r
integer rc
integer nr
integer s = 0


//staff category
rc = dw_staff_cat.rowcount()

for r = 1 to rc
	IF Not IsNull( dw_staff_cat.getitemnumber(r,"staff_category"))   THEN
		dw_staff_cat.rowscopy( r, r, primary!, dw_cat_add,100, primary!)
		s++
		nr = dw_cat_add.rowcount()
		dw_cat_add.setitem(nr,"facility_id", al_facility)
		dw_cat_add.setitem(nr,"prac_id", il_prac_id )
		dw_cat_add.setitem(nr,"rec_id", al_recid)
		dw_cat_add.setitem(nr,"seq_no", s)
		dw_cat_add.setitem(nr,"active_status", ai_status)
	END IF	
next


//department
rc = dw_departments.rowcount()
s = 0
for r = 1 to rc
	IF Not IsNull( dw_departments.getitemnumber(r,"department") ) then
		dw_departments.rowscopy( r, r, primary!, dw_dept_add,100, primary!)
		s++
		nr = dw_dept_add.rowcount()
		dw_dept_add.setitem(nr,"facility_id", al_facility)
		dw_dept_add.setitem(nr,"prac_id", il_prac_id )
		dw_dept_add.setitem(nr,"rec_id", al_recid)
		dw_dept_add.setitem(nr,"seq_no", nr)
		dw_dept_add.setitem(nr,"active_status", ai_status)
	End if
next

return 1

end function

public function integer of_appl_action_create (long ai_facility_id, long ai_app_id, string as_app_name, string as_action_type, long ai_rec_id, long al_loc, string as_apt_type, boolean ab_complete);//Start Code Change ----05.06.2014 #V14.2 maha - created from appl tracking tab code for action creation

Long ll_action_type
Long ll_action_status
Long ll_action_dept
Long ll_rec_id
long ll_track
String ls_action_notes
String ls_app_type
DateTime ldt_action_date
Date ld_due_date
datetime ldt_createdate 
integer li_cnt

ldt_createdate = datetime(today(),now())

ld_due_date = Today()
ls_app_type = as_apt_type 
if isnull(al_loc) then al_loc = 0 //Start Code Change ----05.08.2014 #V14.2 maha
	
//set value for action type
if isnumber(as_action_type) then
	ll_action_type = long(as_action_type)
else
	ll_action_type=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = '"+upper(as_action_type)+"'"))
end if

if ab_complete then
	ll_action_status=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION STATUS' and upper(code) = '"+upper('Complete')+"'"))	
else
	ll_action_status=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION STATUS' and upper(code) = '"+upper('Incomplete')+"'"))
end if


ll_rec_id = ai_rec_id
SetNull( ldt_action_date )

//Start Code Change ----12.04.2014 #V14.2 maha

dw_tracking.settransobject(sqlca)
li_cnt = dw_tracking.retrieve(il_prac_id, ai_facility_id, ai_app_id, al_loc  )

if li_cnt < 0 then messagebox("Tracker Retrieval failed",sqlca.SQLErrText	)
if li_cnt = 0 then
	//Modified by (appeon) Harry 10.16.2017
	/*
	select max(track_id) into :ll_track from pd_appl_tracking;
	if isnull(ll_track) then ll_track = 0
	ll_track++
	*/
	ll_track = gnv_app.of_get_id("track_id")
	
	dw_tracking.insertrow(1)
	dw_tracking.setitem(1, "track_id", ll_track )
	dw_tracking.setitem(1, "prac_id", il_prac_id)
	dw_tracking.setitem(1, "app_id", ai_app_id)
	dw_tracking.setitem(1, "app_hdr_application_name", as_app_name) //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
	dw_tracking.setitem(1, "facility_id", ai_facility_id)
	dw_tracking.setitem(1, "step_1", il_action)
	dw_tracking.setitem(1, "active_status", 1)
	dw_tracking.setitem(1, "assigned_user", is_user)
	dw_tracking.setitem(1, "sys_tracker_id", 1)
	dw_tracking.setitem(1, "gp_id", al_loc)
	inv_data_entry.of_field_audit(dw_tracking) //(Appeon)Stephen 06.03.2016 - V15.2-Application Tracking full Auditing
	dw_tracking.update()
end if
//End Code Change ----12.04.2014

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.26.2014
//<$>reason:Bug 4379 created for Case# 00051492: Audit Trail Issue
string ls_err
long ll_new_row,rtn

/*
INSERT INTO net_dev_action_items  
   		    ( rec_id,   
	    	      prac_id,   
				   seq_no,
     	     	   action_type,   
			      action_date,   
//	    			action_dept,   
     	     	   action_user,   
		     	   next_action_date,   
			      notes,   
		     	   action_status,   
				   facility_id,
				   app_id,
				   app_type,
				   active_status,
					gp_id, 
					create_date,
					create_user, 
					due_date)  
	VALUES ( :ll_rec_id,   
     	      :il_prac_id,  
				:ll_rec_id,					
	    	   :ll_action_type,   
	     	   null,   
//				:ll_action_dept,   
	     		:is_user,   //maha 12.01.2014 - changed from global user
				null,   
		     	'',   
			   :ll_action_status,   
	     		:ai_facility_id,
				:ai_app_id,
				:ls_app_type,
				1,
				:al_loc,
				:ldt_createdate,
				:gs_user_id,
				:ld_due_date)
 	USING SQLCA;

	IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Database Error", SQLCA.SQLERRTEXT )
			Return -1
	END IF
*/	
	
ids_net_dev_action_items.reset()
ll_new_row = ids_net_dev_action_items.InsertRow(0)
ids_net_dev_action_items.SetItem( ll_new_row, "rec_id", ll_rec_id)
ids_net_dev_action_items.SetItem( ll_new_row, "prac_id", il_prac_id)
ids_net_dev_action_items.SetItem( ll_new_row, "seq_no", ll_rec_id)
ids_net_dev_action_items.SetItem( ll_new_row, "action_type", ll_action_type)
ids_net_dev_action_items.SetItem( ll_new_row, "action_user", is_user)
ids_net_dev_action_items.SetItem( ll_new_row, "notes", '')
ids_net_dev_action_items.SetItem( ll_new_row, "action_status", ll_action_status)
ids_net_dev_action_items.SetItem( ll_new_row, "facility_id", ai_facility_id)
ids_net_dev_action_items.SetItem( ll_new_row, "app_id", ai_app_id)
ids_net_dev_action_items.setitem(ll_new_row, "app_hdr_application_name", as_app_name) //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
ids_net_dev_action_items.SetItem( ll_new_row, "app_type", ls_app_type)
ids_net_dev_action_items.SetItem( ll_new_row, "active_status", 1)
ids_net_dev_action_items.SetItem( ll_new_row, "gp_id", al_loc)
ids_net_dev_action_items.SetItem( ll_new_row, "create_date", ldt_createdate)
ids_net_dev_action_items.SetItem( ll_new_row, "create_user", gs_user_id)
ids_net_dev_action_items.SetItem( ll_new_row, "due_date", ld_due_date)	
//Start Code Change ----04.22.2016 #V15 maha
if il_dept > 1 then ids_net_dev_action_items.SetItem( ll_new_row, "action_dept", il_dept ) 
if ab_complete then ids_net_dev_action_items.SetItem( ll_new_row, "action_date",  ldt_createdate)
//End Code Change ----04.22.2016

inv_data_entry.of_field_audit( ids_net_dev_action_items,ls_err )

rtn = ids_net_dev_action_items.update()
IF rtn <> 1 THEN
		MessageBox("Database Error", SQLCA.SQLERRTEXT )
		Return -1
END IF	
//------------------- APPEON END -------------------
			
RETURN 0

end function

on pfc_cst_u_multi_app_select.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.gb_3=create gb_3
this.dw_action_type=create dw_action_type
this.cb_2=create cb_2
this.cbx_addr=create cbx_addr
this.cbx_complete=create cbx_complete
this.cb_dept=create cb_dept
this.dw_facility_add=create dw_facility_add
this.dw_staff_cat=create dw_staff_cat
this.dw_departments=create dw_departments
this.dw_cat_add=create dw_cat_add
this.dw_dept_add=create dw_dept_add
this.dw_user=create dw_user
this.dw_tracking=create dw_tracking
this.st_1=create st_1
this.dw_dept_cat=create dw_dept_cat
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.dw_action_type
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cbx_addr
this.Control[iCurrent+8]=this.cbx_complete
this.Control[iCurrent+9]=this.cb_dept
this.Control[iCurrent+10]=this.dw_facility_add
this.Control[iCurrent+11]=this.dw_staff_cat
this.Control[iCurrent+12]=this.dw_departments
this.Control[iCurrent+13]=this.dw_cat_add
this.Control[iCurrent+14]=this.dw_dept_add
this.Control[iCurrent+15]=this.dw_user
this.Control[iCurrent+16]=this.dw_tracking
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.dw_dept_cat
this.Control[iCurrent+19]=this.gb_2
end on

on pfc_cst_u_multi_app_select.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.dw_action_type)
destroy(this.cb_2)
destroy(this.cbx_addr)
destroy(this.cbx_complete)
destroy(this.cb_dept)
destroy(this.dw_facility_add)
destroy(this.dw_staff_cat)
destroy(this.dw_departments)
destroy(this.dw_cat_add)
destroy(this.dw_dept_add)
destroy(this.dw_user)
destroy(this.dw_tracking)
destroy(this.st_1)
destroy(this.dw_dept_cat)
destroy(this.gb_2)
end on

event constructor;call super::constructor;//Start Code Change ----08.07.2014 #V14.2 maha removed setting specific changes and added labels settings
string ls_fac
string ls_pay
string s

//CHOOSE CASE gi_intelliapp_type
//		//SINGLE GROUP
//	CASE 0
//		dw_app_data.Modify( "parent_facility_t.text = 'Payor/Hospital'" )		
//		//MULTI SITE GROUP
//	CASE 1
//		gb_3.Text = "Select Group and Payor/Hospital to Associate With Practitioner"
//		//dw_app_data.DataObject = "d_multi_app_list_new_billing"
//		dw_app_data.DataObject = "d_multi_app_list_new"
//		dw_app_data.SetTransObject( SQLCA )	
//		dw_app_data.Modify( "parent_facility_t.text = 'Group'" )		
//		//BILLING COMPANY
//	CASE 2
//		gb_3.Text = "Select Client and Payor/Hospital to Associate With Practitioner"		
//		//dw_app_data.DataObject = "d_multi_app_list_new_billing"
//		dw_app_data.DataObject = "d_multi_app_list_new"
//		dw_app_data.SetTransObject( SQLCA )		
//		dw_app_data.Modify( "parent_facility_t.text = 'Client'" )		
//END CHOOSE

//Start Code Change ----07.11.2016 #V152 maha - removed
//  SELECT app_stat_facility_label, app_stat_app_label into :ls_fac, :ls_pay   FROM "icred_settings" ;
//  
//  if isnull(ls_fac) or len(ls_fac) < 1 then ls_fac = 'Facility'
//  if isnull(ls_pay) or len(ls_pay) < 1 then ls_pay = 'Payor'
//  
//  s = "Select " + ls_fac + " and " + ls_pay + " to Associate With Practitioner"
//  
//  dw_app_data.Modify( "parent_facility_t.text = '" + ls_fac + "'" )	
//  gb_3.Text = s
  //Start Code Change ----08.07.2014
  //End Code Change ----07.11.2016

dw_user.SetTransObject( SQLCA )	
dw_user.retrieve()
is_user = gs_user_id
dw_user.setitem(1,"user_id", is_user)

inv_data_entry = CREATE pfc_cst_nv_data_entry_functions 

ids_net_dev_action_items = Create n_cst_datastore
//---------Begin Modified by (Appeon)Stephen 07.21.2017 for Critical performance issue with workflow action completion-------
//ids_net_dev_action_items.DataObject = "d_appeon_net_dev_action_items_save"
ids_net_dev_action_items.DataObject = "d_audit_net_dev_action_items_save"
//---------End Modfiied ------------------------------------------------------
ids_net_dev_action_items.SetTransObject( sqlca)
end event

event destructor;call super::destructor;Destroy inv_data_entry //Added by Appeon long.zhang 12.26.2014 
Destroy ids_net_dev_action_items//Added by Appeon long.zhang 12.26.2014



end event

type cb_delete from pfc_cst_u_multi_app_painter_new`cb_delete within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3858
integer y = 208
integer taborder = 130
end type

type cb_add from pfc_cst_u_multi_app_painter_new`cb_add within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3744
integer y = 208
integer taborder = 120
end type

type cb_close from pfc_cst_u_multi_app_painter_new`cb_close within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3840
integer y = 200
integer taborder = 110
end type

type cb_save from pfc_cst_u_multi_app_painter_new`cb_save within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3808
integer y = 188
integer taborder = 50
end type

type dw_app_data from pfc_cst_u_multi_app_painter_new`dw_app_data within pfc_cst_u_multi_app_select
integer x = 41
integer y = 388
integer width = 4393
integer height = 1432
integer taborder = 40
string dataobject = "d_multi_app_list_new"
end type

event dw_app_data::constructor;call super::constructor;This.of_SetUpdateAble( False )


if gs_cust_type = "I" then//Start Code Change ----11.20.2014 #V14.2 maha
	this.modify("apptmnt_type.visible=false")
end if

//Start Code Change ----01.06.2015 #V14.2 maha - hide location
choose case gi_intelliapp_type
	case 3, 0 
		this.modify("gp_id.visible=false")
end choose
//End Code Change ----01.06.2015 

end event

event dw_app_data::buttonclicked;call super::buttonclicked;Integer li_parent_facility
Integer i
Integer li_rc

li_parent_facility = This.GetItemNumber( row, "parent_facility_id" )

li_rc = This.RowCount( )


FOR i = 1 TO li_rc
	IF This.GetItemNumber( i, "parent_facility_id" ) = li_parent_facility THEN
		This.SetItem( i, "selected", 1 )
	END IF
END FOR


end event

type cb_new from pfc_cst_u_multi_app_painter_new`cb_new within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 4082
integer y = 192
integer width = 105
integer taborder = 140
end type

type cb_3 from pfc_cst_u_multi_app_painter_new`cb_3 within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 4133
integer y = 188
integer width = 82
integer taborder = 150
end type

type dw_select from pfc_cst_u_multi_app_painter_new`dw_select within pfc_cst_u_multi_app_select
integer y = 76
integer width = 1289
end type

event dw_select::constructor;call super::constructor;DataWindowChild dwchild

This.GetChild( "multi_app_id", dwchild )
IF dwchild.RowCount() = 0 THEN
	MessageBox("Multi App", "You have not setup your Multi App Templates yet.  Go to System->Setup>System Setup->Multi App Templates and setup before adding Payers." )
END IF

cb_ok.enabled = false
//This.SetItem( 1, "multi_app_id", 1 )

//dw_app_data.Retrieve( 1,gs_user_id )
//of_enable_disable_objects( 1 )
//ii_multi_app_id = 1
end event

event dw_select::itemchanged;//Start Code Change ----05.05.2014 #V14.2 maha
dw_app_data.Retrieve( long( data ),gs_user_id )
//of_enable_disable_objects( 1 )
ii_multi_app_id = long( data )
cb_ok.enabled = true
end event

type gb_1 from pfc_cst_u_multi_app_painter_new`gb_1 within pfc_cst_u_multi_app_select
integer x = 46
integer y = 4
integer width = 3470
integer height = 200
integer taborder = 30
long backcolor = 33551856
string text = "Select Multi App Template                                                    Action Type                                       Assigned User"
borderstyle borderstyle = stylebox!
end type

type cb_ok from commandbutton within pfc_cst_u_multi_app_select
integer x = 3689
integer y = 68
integer width = 325
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Long ll_lookup_code
Integer ll_set_to
Integer r
Integer li_rc
Integer i
Integer li_cnt = 0

of_multi_add()

close(w_multi_app_select)

//gs_pass_ids istr_ids
//
//dw_app_data.AcceptText()
//
//li_rc = dw_app_data.RowCount()
//
//FOR i = 1 TO li_rc
//	IF dw_app_data.GetItemNumber( i, "selected" ) = 1 THEN
//		li_cnt++
//		istr_ids.i_facility_ids[ li_cnt ] = dw_app_data.GetItemNumber( i, "parent_facility_id" )
//		istr_ids.s_ids[ li_cnt ] = String( dw_app_data.GetItemNumber( i, "app_id" ) )
//		istr_ids.l_loc_ids[li_cnt] =  dw_app_data.GetItemNumber( i, "gp_id" )  //Start Code Change ----05.05.2014 #V14.2 maha
//		istr_ids.l_ids[li_cnt] =  dw_app_data.GetItemNumber( i, "mai_id" )  //Start Code Change ----07.02.2014 #V14.2 maha
//	END IF
//END FOR
//
////template id
//istr_ids.ll_verification_id = ii_multi_app_id  //Start Code Change ----05.05.2014 #V14.2 maha
//
////Start Code Change ----05.06.2014 #V14.2 maha - setting for address creation
//if cbx_addr.checked then
//	istr_ids.ls_image_available = true
//else
//	istr_ids.ls_image_available = false
//end if
//
////user assigned
//istr_ids.s_stringval = is_user  //Start Code Change ----06.18.2014 #V14.2 maha - user setting
//
////li_rc = dw_action_type.RowCount( )
//
////complete setting
//if cbx_complete.checked then
//	istr_ids.i_ids[1] = 1
//end if
//
////dw_action_type.AcceptText( )
//
////li_cnt = 0
//
////Start Code Change ----05.05.2014 #V14.2 maha - change to single variable
//istr_ids.s_action_type[ 1 ] = string(il_action)
////FOR r = 1 to li_rc
////	IF dw_action_type.GetItemString( r, "selected" ) = "1" THEN
////		li_cnt++		
////		istr_ids.s_action_type[ li_cnt ] = dw_action_type.GetItemString( r, "code" )		
////	END IF
////END FOR
////End Code Change ----05.05.2014
//
//
//CloseWithReturn ( iw_win2, istr_ids )
end event

type cb_cancel from commandbutton within pfc_cst_u_multi_app_select
integer x = 4032
integer y = 68
integer width = 325
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn ( iw_win2, "Cancel" )
end event

type cb_1 from commandbutton within pfc_cst_u_multi_app_select
integer x = 69
integer y = 212
integer width = 325
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Deselect All"
end type

event clicked;Integer li_rc
Integer i
Integer li_cnt
integer v

gs_pass_ids istr_ids

dw_app_data.AcceptText()

li_rc = dw_app_data.RowCount()

IF This.Text = "Select All" THEN
	This.Text = "Deselect All"
	v = 1
ELSE
	This.Text = "Select All"
	v = 0
END IF

FOR i = 1 TO li_rc
		dw_app_data.SetItem( i, "selected", v )
END FOR


end event

type gb_3 from groupbox within pfc_cst_u_multi_app_select
integer x = 18
integer y = 1860
integer width = 4434
integer height = 596
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Add desired Department/Staff Category records"
end type

type dw_action_type from u_dw within pfc_cst_u_multi_app_select
integer x = 1367
integer y = 76
integer width = 750
integer height = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_action_type_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;Integer li_found
long ll_action_type

This.of_SetTraNsObject( SQLCA )
This.of_SetUpdateAble( False )
This.Retrieve( )

this.insertrow(1)

//Start Code Change ----10.28.2014 #V14.2 maha - added option to get first step 
if of_get_app_setting("set_82" , "I") = 1 then
	ll_action_type = long(gnv_data.of_getitem("app_steps","next step",'0'))
else
	ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
end if

//Start Code Change ----05.054.2014 #V14.2 maha - set default
//ll_action_type=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = '"+upper('App Out To MD')+"'"))
//End Code Change ----10.28.2014

this. setitem(1,"lookup_code", ll_action_type)
il_action = ll_action_type

//li_found = This.Find( "code = 'App Out To MD'", 1, 1000 )
//
//IF li_found > 0 THEN
//	This.DeleteRow( li_found )
//END IF
//End Code Change ----05.054.2014

end event

event itemchanged;call super::itemchanged;//Start Code Change ----05.05.2014 #V14.2 maha
il_action = long(data)
//IF This.GetItemString( row, "code" ) = 'App Out To MD' THEN
//	MessageBox("Invalid Entry", "App Out To MD must be selected." )
//	This.SetItem( row, "selected", 1 )
//	Return 0
//END IF
//End Code Change ----05.05.2014
end event

type cb_2 from commandbutton within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3753
integer y = 216
integer width = 398
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save As Default"
boolean cancel = true
end type

event clicked;dw_action_type.Update()

//Long ll_lookup_code
//Integer ll_set_to
//Integer li_rc
//Integer r
//
//li_rc = dw_action_type.RowCount( )
//
//dw_action_type.AcceptText( )
//
//FOR r = 1 to li_rc
//	IF dw_action_type.GetItemNumber( r, "selected" ) = 1 THEN
//		ll_set_to = 1
//	ELSE
//		ll_set_to = 0
//	END IF
//	
//	ll_lookup_code = dw_action_type.GetItemNumber( r, "lookup_code" )
//	UPDATE code_lookup
//	SET custom_4 = :ll_set_to
//	WHERE lookup_code = :ll_lookup_code
//	USING SQLCA;
//
//END FOR
end event

type cbx_addr from checkbox within pfc_cst_u_multi_app_select
integer x = 2496
integer y = 236
integer width = 864
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add missing Location Addresses"
boolean checked = true
end type

type cbx_complete from checkbox within pfc_cst_u_multi_app_select
integer x = 1861
integer y = 236
integer width = 594
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Complete Actions"
end type

type cb_dept from commandbutton within pfc_cst_u_multi_app_select
integer x = 741
integer y = 212
integer width = 827
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set Department/ Staff Category"
end type

event clicked;iw_win2.height = parent.height + 50 // 2600
ib_dept = true

datawindowchild dwchild
Long nulllong

String ls_version

SetNull( nulllong )
dw_staff_cat.of_SetRowManager( TRUE )
dw_staff_cat.of_SetReqColumn(TRUE)
dw_staff_cat.of_SetDropDownCalendar( TRUE )
dw_staff_cat.iuo_calendar.of_Register(dw_staff_cat.iuo_calendar.DDLB)
dw_staff_cat.of_SetTransObject(SQLCA)

dw_staff_cat.GetChild( "staff_category", dwchild )
dwchild.SetTransObject( SQLCA )

gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('staff category') + "'", dwchild)

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

dw_staff_cat.insertrow(1)



//setup depart dw

dw_departments.of_SetRowManager( TRUE )
dw_departments.of_SetReqColumn(TRUE)
dw_departments.of_SetTransObject(SQLCA)
dw_departments.of_SetDropDownCalendar( TRUE )
dw_departments.iuo_calendar.of_Register(dw_departments.iuo_calendar.DDLB)
dw_departments.of_SetTransObject(SQLCA)

dw_departments.GetChild( "department", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('department') + "'", dwchild)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

dw_departments.GetChild( "section", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('section') + "'", dwchild)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

dw_departments.GetChild( "rank", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('division') + "'", dwchild)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

dw_departments.insertrow(1)

end event

type dw_facility_add from u_dw within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 41
integer y = 1584
integer width = 160
integer height = 116
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_pd_affil_status"
end type

type dw_staff_cat from u_dw within pfc_cst_u_multi_app_select
integer x = 37
integer y = 1924
integer width = 4389
integer height = 172
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pd_affil_staff_cat"
boolean border = false
end type

event clicked;call super::clicked; this.getclickedrow( )//Start Code Change ----12.17.2009 #V10 maha
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

type dw_departments from u_dw within pfc_cst_u_multi_app_select
integer x = 37
integer y = 2108
integer width = 4389
integer height = 320
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pd_affil_departments"
boolean border = false
end type

event clicked;call super::clicked; this.getclickedrow( )//Start Code Change ----12.17.2009 #V10 maha
end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "department" THEN
	if isnull(This.getItemnumber( row, "primary_dept")) then//\/maha 080102
		if this.rowcount() = 1 then
			This.SetItem( row, "primary_dept",1)
		else
			This.SetItem( row, "primary_dept",0)
		end if
	end if	
END IF

IF This.GetColumnName() = "record_status" THEN //this is not active_status
	this.accepttext()
	if This.getItemnumber( row, "record_status")  = 1 then //\/maha 121602
		This.SetItem( row, "primary_dept",1)
	else
		This.SetItem( row, "primary_dept",0)
	end if
END IF
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

type dw_cat_add from u_dw within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3621
integer y = 1960
integer width = 617
integer height = 172
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_pd_affil_staff_cat"
boolean border = false
end type

type dw_dept_add from u_dw within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3625
integer y = 2168
integer width = 622
integer height = 320
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_pd_affil_departments"
boolean border = false
end type

type dw_user from u_dw within pfc_cst_u_multi_app_select
integer x = 2162
integer y = 76
integer width = 507
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_user_select_current"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//Start Code Change ----06.18.2014 #V14.2 maha
is_user = data
end event

event constructor;call super::constructor;this.of_setupdateable( false)
end event

type dw_tracking from datawindow within pfc_cst_u_multi_app_select
boolean visible = false
integer x = 3511
integer y = 192
integer width = 96
integer height = 120
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_appl_tracking_for_multi_app"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type st_1 from statictext within pfc_cst_u_multi_app_select
integer x = 2706
integer y = 8
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 33551856
string text = "Dept/Category"
boolean focusrectangle = false
end type

type dw_dept_cat from u_dw within pfc_cst_u_multi_app_select
integer x = 2706
integer y = 76
integer width = 750
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_action_dept_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;Integer li_found
long ll_action_type

This.of_SetTraNsObject( SQLCA )
This.of_SetUpdateAble( False )
This.Retrieve( )

this.insertrow(1)



end event

event itemchanged;call super::itemchanged;//Start Code Change ----05.05.2014 #V14.2 maha
il_dept = long(data)
//IF This.GetItemString( row, "code" ) = 'App Out To MD' THEN
//	MessageBox("Invalid Entry", "App Out To MD must be selected." )
//	This.SetItem( row, "selected", 1 )
//	Return 0
//END IF
//End Code Change ----05.05.2014
end event

type gb_2 from groupbox within pfc_cst_u_multi_app_select
integer x = 23
integer y = 324
integer width = 4434
integer height = 1520
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Group/Facility, Payor, Location To Associate With Provider"
end type

