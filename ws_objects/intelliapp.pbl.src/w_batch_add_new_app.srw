$PBExportHeader$w_batch_add_new_app.srw
forward
global type w_batch_add_new_app from w_select_applications
end type
type dw_facility from pfc_cst_u_org_facility_selector_horiz within w_batch_add_new_app
end type
type cb_prac from commandbutton within w_batch_add_new_app
end type
type cb_create from commandbutton within w_batch_add_new_app
end type
type st_1 from statictext within w_batch_add_new_app
end type
type cb_5 from commandbutton within w_batch_add_new_app
end type
type st_pracs from statictext within w_batch_add_new_app
end type
type dw_all_facilities from datawindow within w_batch_add_new_app
end type
type st_2 from statictext within w_batch_add_new_app
end type
type cb_batch from commandbutton within w_batch_add_new_app
end type
type st_3 from statictext within w_batch_add_new_app
end type
type st_4 from statictext within w_batch_add_new_app
end type
type cb_3 from commandbutton within w_batch_add_new_app
end type
type dw_facility_add from u_dw within w_batch_add_new_app
end type
type cbx_skip from checkbox within w_batch_add_new_app
end type
type st_5 from statictext within w_batch_add_new_app
end type
type cb_all from commandbutton within w_batch_add_new_app
end type
type cb_now from commandbutton within w_batch_add_new_app
end type
type st_6 from statictext within w_batch_add_new_app
end type
end forward

global type w_batch_add_new_app from w_select_applications
integer x = 283
integer y = 352
integer width = 2976
integer height = 1768
string title = ""
long backcolor = 80269524
dw_facility dw_facility
cb_prac cb_prac
cb_create cb_create
st_1 st_1
cb_5 cb_5
st_pracs st_pracs
dw_all_facilities dw_all_facilities
st_2 st_2
cb_batch cb_batch
st_3 st_3
st_4 st_4
cb_3 cb_3
dw_facility_add dw_facility_add
cbx_skip cbx_skip
st_5 st_5
cb_all cb_all
cb_now cb_now
st_6 st_6
end type
global w_batch_add_new_app w_batch_add_new_app

type variables
gs_batch_search ist_search
Long il_prac_ids[] 
String is_prac_names[] 
Long il_ai_rc = 0
Long il_ai_cnt

Integer li_facility_cnt=0
integer il_facility_id


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Define datastores for caching data.

datastore	ids_save
datastore	ids_d_net_dev_action_items

n_ds			ids_all_addresses
n_ds			ids_address_link
datastore	ids_pd_address_link

n_ds			ids_hosp_link
n_ds			ids_all_hosp

n_ds			ids_spec_link
n_ds			ids_all_spec

n_ds			ids_cred_comms
n_ds			ids_cred_committees
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_batch_add ()
public function integer of_add_net_dev_ai (integer ai_app_id, string as_app_type, long al_prac_id, integer ai_facility_id)
public function integer of_add_committees (long al_prac_id, integer ai_facility_id, long al_rec_id)
public function integer of_add_committees_arr (long al_prac_id[], integer ai_facility_id[], long al_rec_id[])
public function integer of_hospital_link_arr (long al_prac_id[], integer ai_facility_id[])
public function integer of_specialty_link_arr (long al_prac_id[], integer ai_facility_id[])
public function integer of_add_net_dev_ai_arr (string as_app_type, long al_prac_id[], integer ai_facility_id)
public function integer of_batch_add_apps (integer ai_facility_id[])
public function integer of_specialty_link_for_pt (long al_prac_id, integer ai_facility_id)
public function integer of_hospital_link_for_pt (long al_prac_id, integer ai_facility_id)
public function integer of_add_address_link_for_pt (long al_prac_id, integer ai_facility_id)
public function integer of_add_committees_for_pt (long al_prac_id, integer ai_facility_id, long al_rec_id)
public function integer of_hospital_link (long al_prac_id, integer ai_facility_id)
public function integer of_specialty_link (long al_prac_id, integer ai_facility_id)
public function integer of_add_net_dev_ai_for_pt (integer ai_app_id, string as_app_type, long al_prac_id, integer ai_facility_id, long al_rec_id, long al_action_type, long al_action_status)
end prototypes

public function integer of_batch_add ();Long ll_count
Long ll_prac_id
Long ll_rec_id
Integer li_fc
Integer f
Integer li_app_cnt
Integer li_tick
Integer li_app_id
Integer li_app_rc
Integer i
Integer li_parent_facility_id[]
Integer li_app_audit_facility
Integer li_ver_facility
Long p
Long li_pc

//debugbreak()
//this function will not add dept,staff data when run from intellicred
il_ai_cnt = 0

li_app_rc = dw_1.RowCount( )

//get parent facility id
li_parent_facility_id[1] = dw_facility.GetItemNumber( 1, "facility_id" )

//if all facilities is selected then loop through
IF li_parent_facility_id[1] = 0 THEN
	li_fc = dw_all_facilities.RowCount()
	li_facility_cnt = li_fc
	FOR f = 1 TO li_fc
		li_parent_facility_id[f] = dw_all_facilities.GetItemNumber( f, "facility_id" ) 
	END FOR
	of_batch_add_apps( li_parent_facility_id )
ELSE	
	li_facility_cnt = 1
	of_batch_add_apps( li_parent_facility_id )
END IF

Return 1

////get default facility values
//SELECT facility.default_audit_temp,   
//       facility.default_verif_facility  
//INTO :li_app_audit_facility,   
//     :li_ver_facility  
//FROM facility  
//WHERE facility.facility_id = :li_parent_facility_id   ;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
//	Return -1
//END IF
//
//dw_1.AcceptText( )
//
////how many apps 
//li_app_rc = dw_1.RowCount( )
//
//
//FOR i = 1 TO li_app_rc
//	IF dw_1.GetItemNumber( i, "selected" ) = 1 THEN	
//		li_app_cnt++
//	END IF
//END FOR
//IF li_app_cnt = 0 THEN
//	MessageBox("Application Select Error", "You must select at least one application." )
//	Return 1
//END IF
//
//
////find out the number of pracs selected
//li_pc = upperbound( il_prac_ids[] ) 
//
//IF li_pc = 0 THEN
//	MessageBox("Practitioner Select Error", "You have not selected any practitioner to add applications to." )
//	Return -1
//END IF
//
////li_tick = 2000/li_pc
//
////loop through and add facility and net dev ai for each prac
//FOR p = 1 TO li_pc
//
//	st_pracs.Text = "Creating action items for " + String( p ) + " of " + String( li_pc )
//
//	//add data to appointment status screen
//	ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
//
//	ll_prac_id = il_prac_ids[ p ]
//
//	SELECT Count( prac_id )  
//   INTO :ll_count  
//   FROM pd_affil_stat  
//   WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
//         ( pd_affil_stat.parent_facility_id = :li_parent_facility_id ) AND  
//         ( pd_affil_stat.active_status = 1 )   ;
//
//	IF ll_count = 0 THEN
//
//		INSERT INTO pd_affil_stat  
//   	   ( rec_id,   
//      	  prac_id,   
//	        parent_facility_id,   
//   	     seq_no,   
//      	  apptmnt_type,   
//	        active_status,   
//   	     verifying_facility,   
//      	  application_audit_facility,   
//	        priority,   
//   	     priority_user,   
//	        affiliation_status )  
//		VALUES (:ll_rec_id,   
//	        :ll_prac_id,   
//   	     :li_parent_facility_id,   
//      	  1,   
//	        'I',   
//   	     1,   
//      	  :li_ver_facility,   
//	        :li_app_audit_facility,   
//   	     1,   
//	        'Master',   
//   	     'M' )  ;	
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("SQL Error", SQLCA.SQLERRTEXT )
//			Return -1
//		END IF
//
//	END IF
//
//	FOR i = 1 TO li_app_rc
//		IF dw_1.GetItemNumber( i, "selected" ) = 0 THEN
//			CONTINUE
//		END IF
//
//		//grap app id
//		li_app_id = dw_1.GetItemNumber( i, "app_id" )
//		
//		//create the action item
//		of_add_net_dev_ai( li_app_id, "I", il_prac_ids[ p ], li_parent_facility_id )
//	END FOR
//END FOR
//
//st_pracs.Text = "Complete"
//
//Return 1
//
//
////code modified maha 011003 to allow the net dev action items to be created for facilities that would be duplicated.
//// net dev create function call moved to here from preupdate event
//
////n_ds lds_multi_app
////Integer li_rc
////Integer li_nr
////Integer i
////Integer li_prime
////Integer li_multi_app_id
////Integer li_parent_facility_id
////Integer li_app_audit_facility_id
////Integer li_verif_facility_id
////String ls_apptmnt_type
////gs_multi_app lstr_multi_app
////
////
////Open( w_get_multi_app_template )
////IF Message.StringParm = "Cancel" THEN
////	Return -1
////END IF
////
////lstr_multi_app = Message.PowerObjectParm
////
////li_multi_app_id = lstr_multi_app.i_multi_app_id
////
////lds_multi_app = CREATE n_ds
////lds_multi_app.DataObject = "d_multi_app_list"
////lds_multi_app.of_SetTransObject( SQLCA )
////li_rc = lds_multi_app.Retrieve( li_multi_app_id )
////
////FOR i = 1 TO li_rc
////	
////	//get data from multi app template painter
////	li_parent_facility_id = lds_multi_app.GetItemNumber( i, "parent_facility_id" )
////	ls_apptmnt_type = lds_multi_app.GetItemString( i, "apptmnt_type" )
////	ii_app_id = lds_multi_app.GetItemNumber( i, "app_id" )
////	
////	IF dw_orgs_facilities.Find( "parent_facility_id = " + String( li_parent_Facility_id ), 1, 1000 ) > 0 THEN
////		//don't make appt record if facility record exists
////	else
////		li_app_audit_facility_id = lds_multi_app.GetItemNumber( i, "application_audit_facility" )
////		li_verif_facility_id = lds_multi_app.GetItemNumber( i, "verifying_facility" )
////		 	
////		
////		
////		//add appointment status record
////		of_new_record( il_prac_id )
////		li_nr = tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow( )
////		//tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "parent_facility_id", li_parent_facility_id  )	
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "parent_facility_id" )
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetText( String(li_parent_facility_id)  )
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "application_audit_facility" )
////		//tab_view.tabpage_detail_1.dw_apptmnt_status.TriggerEvent( ItemChanged! )
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "application_audit_facility", li_app_audit_facility_id )
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "verifying_facility", li_verif_facility_id )
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "apptmnt_type", ls_apptmnt_type)	
////		if ii_app_id < 1 or isnull(ii_app_id) then //maha 101901
////			tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "affiliation_status", "M")
////		else
////			tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "affiliation_status", "I")
////		end if
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "active_status", 1 )	
////		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "priority_user", "Public" )	
////		
////		IF Not IsNull(  lstr_multi_app.l_department ) THEN
////			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "department", lstr_multi_app.l_department )
////			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "section", lstr_multi_app.l_section )
////			li_prime = lstr_multi_app.i_primary//maha 182802
////			if isnull(li_prime) then li_prime = 0//maha 182802
////			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "primary_dept", li_prime )// maha 182802
////		END IF
////	
////		IF Not IsNull(  lstr_multi_app.l_staff_category ) THEN
////			tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "staff_category", lstr_multi_app.l_staff_category )
////			tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "from_date", lstr_multi_app.dt_from_date )
////			tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "to_date", lstr_multi_app.dt_to_date )	
////		END IF
////		
////		iw_win.Event pfc_Save()
////	end if
////	//creation of network dev items moved here from preupdate of the appoint stat dw  //maha 011003
////	of_add_net_dev_ai(ls_apptmnt_type,ii_app_id)
////END FOR
////
////
////Return 0
end function

public function integer of_add_net_dev_ai (integer ai_app_id, string as_app_type, long al_prac_id, integer ai_facility_id);Long ll_rec_id
Long ll_action_type			
Long ll_action_status
Long ll_action_dept
Integer li_ai_cnt
String ls_action_notes
DateTime ldt_action_date


			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
			
			//\/maha 101901
			select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
			IF SQLCA.SQLCODE = 100 THEN
				MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'App Out To MD' to the Action Type lookup table." )
				Return -1
			END IF
			//ll_action_type = -3
			select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
			IF SQLCA.SQLCODE = 100 THEN
				MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'Incomplete' to the Action Status lookup table." )
				Return -1
			END IF			
			//ll_action_status = -110
			select lookup_code into :ll_action_dept from code_lookup where lookup_name = 'Action Department' and code = 'Credentialing';
			IF SQLCA.SQLCODE = 100 THEN
				MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'Credentailing' to the Action Department lookup table." )
				Return -1
			END IF			

			//check to see if ai allready exists		
			SELECT Count( prac_id )  
		   INTO :li_ai_cnt  
		   FROM net_dev_action_items  
		   WHERE ( net_dev_action_items.prac_id = :al_prac_id ) AND  
      		   ( net_dev_action_items.facility_id = :ai_facility_id ) AND  
					( net_dev_action_items.app_id = :ai_app_id ) AND
		         ( net_dev_action_items.action_type = :ll_action_type ) AND  
      		   ( net_dev_action_items.active_status = 1 ) AND  
		         ( net_dev_action_items.action_status = :ll_action_status )   ;
		
			IF li_ai_cnt = 0 THEN
				ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")	
				ls_action_notes = ""
				ldt_action_date = DateTime( Today(), Now() )
				
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 2005-11-25 By: Zhang Lingping
				//$<reason> The text column can not inserted value in ODBC.
				//$<reason> change the insert sql syntax to datastore save.

				//				INSERT INTO net_dev_action_items  
				//    			    ( rec_id,   
				//	     		   	prac_id,   
				//					   seq_no,
				//   	  	     	   action_type,   
				//				      action_date,   
				//	   	 			action_dept,   
				//     	   	  	   action_user,   
				//		     		   next_action_date,   
				//				      notes,   
				//			     	   action_status,   
				//					   facility_id,
				//					   app_id,
				//					   app_type,
				//					   active_status)  
				//				VALUES ( :ll_rec_id,   
				//	      			   :al_prac_id,  
				//					      :ll_rec_id,			
				//	   	 	     	   :ll_action_type,   
				//	     		    	   :ldt_action_date,   
				//					      :ll_action_dept,   
				//		     		      :gs_user_id,   
				//					      null,   
				//			     	      :ls_action_notes,   
				//				         :ll_action_status,   
				//		     		      :ai_facility_id,
				//					      :ai_app_id,
				//					      :as_app_type,
				//						   1)
				//				USING SQLCA;
				//				IF SQLCA.SQLCODE = -1 THEN
				//					MessageBox("Database Error", SQLCA.SQLERRTEXT )
				//					Return -1
				//				END IF						
				
				datastore lds_save
				long ll_rowsave
				date ldt_null
				
				setnull(ldt_null)
				
				lds_save = create datastore 
				lds_save.dataobject = "d_appeon_net_dev_action_items_save"
				lds_save.settransobject(sqlca)
				
				ll_rowsave = lds_save.insertrow(0)
				lds_save.setitem(ll_rowsave,"rec_id",ll_rec_id)
				lds_save.setitem(ll_rowsave,"prac_id",al_prac_id)
				lds_save.setitem(ll_rowsave,"seq_no",ll_rec_id)
				lds_save.setitem(ll_rowsave,"action_type",ll_action_type)
				lds_save.setitem(ll_rowsave,"action_date",ldt_action_date)
				lds_save.setitem(ll_rowsave,"action_dept",ll_action_dept)
				lds_save.setitem(ll_rowsave,"action_user",gs_user_id)
				lds_save.setitem(ll_rowsave,"next_action_date",ldt_null)
				lds_save.setitem(ll_rowsave,"notes",ls_action_notes)
				lds_save.setitem(ll_rowsave,"action_status",ll_action_status)
				lds_save.setitem(ll_rowsave,"facility_id",ai_facility_id)
				lds_save.setitem(ll_rowsave,"app_id",ai_app_id)
				lds_save.setitem(ll_rowsave,"app_type",as_app_type)
				lds_save.setitem(ll_rowsave,"active_status",1)
				
				IF lds_save.update() = -1 THEN
					MessageBox("Database Error", SQLCA.SQLERRTEXT )
					//--------------------------- APPEON BEGIN ---------------------------
					//$<Add> 08.23.2007 By: Evan
					//$<Reason> Need to destroy object.
					if IsValid(lds_save) then Destroy lds_save
					//---------------------------- APPEON END ----------------------------					
					Return -1
				END IF	
				//---------------------------- APPEON END ----------------------------

				
	
				COMMIT USING SQLCA;
		END IF	
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 08.23.2007 By: Evan
		//$<Reason> Need to destroy object.
		if IsValid(lds_save) then Destroy lds_save
		//---------------------------- APPEON END ----------------------------
		
		Return 1
end function

public function integer of_add_committees (long al_prac_id, integer ai_facility_id, long al_rec_id);//maha 011706 no longer used called from data entry functions

//n_ds lds_cred_comms
//n_ds lds_cred_committees
//
//
//Integer li_num_comms
//Integer c
//Integer li_nr
//
//lds_cred_committees = CREATE n_ds
//lds_cred_committees.DataObject = "d_pd_comm_review" 
//lds_cred_committees.of_SetTransObject( SQLCA )
//
//lds_cred_comms = CREATE n_ds
//lds_cred_comms.DataObject = "d_dddw_credentialing_committees" 
//lds_cred_comms.of_SetTransObject( SQLCA )
//li_num_comms = lds_cred_comms.Retrieve( ai_facility_id )
//	
//FOR c = 1 TO li_num_comms
//	li_nr = lds_cred_committees.InsertRow( 0 )
//	lds_cred_committees.SetItem( li_nr, "facility_id", ai_facility_id )
//	lds_cred_committees.SetItem( li_nr, "committee_id", lds_cred_comms.GetItemNumber( c, "committee_id" ) )
//	lds_cred_committees.SetItem( li_nr, "active_status", 1 )
//	lds_cred_committees.SetItem( li_nr, "rec_id", al_rec_id )
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 2005-11-25 By: Zhang Lingping
//	//$<reason> The column "prac_id" can not be set to null.
//	lds_cred_committees.SetItem( li_nr, "prac_id", al_prac_id )
//	//---------------------------- APPEON END ----------------------------
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 2005-11-16 By: Liang QingShi
//	//$<reason> The column "seq_no" is not null.
//
//	lds_cred_committees.SetItem( li_nr, "seq_no", 1 )
//	//---------------------------- APPEON END ----------------------------
//END FOR
//	
//lds_cred_committees.Update( )
//
//DESTROY lds_cred_comms;
//DESTROY lds_cred_committees;


Return 1
end function

public function integer of_add_committees_arr (long al_prac_id[], integer ai_facility_id[], long al_rec_id[]);//////////////////////////////////////////////////////////////////////
// $<function>w_batch_add_new_appof_add_committees_arr()
// $<arguments> value	long al_prac_id[]
// $<arguments> value	integer	ai_facility_id[]
// $<arguments> value	long al_rec_id[]
// $<returns> integer
// $<description>Accept arrays as arguments
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.16.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////

n_ds lds_cred_comms
n_ds lds_cred_committees
Integer li_num_comms
Integer c,i
Integer li_nr

gnv_appeondb.of_startqueue( )

lds_cred_committees = CREATE n_ds
lds_cred_committees.DataObject = "d_pd_comm_review" 
lds_cred_committees.of_SetTransObject( SQLCA )

lds_cred_comms = CREATE n_ds
lds_cred_comms.DataObject = "d_dddw_credentialing_committees_all" 
lds_cred_comms.of_SetTransObject( SQLCA )
lds_cred_comms.Retrieve( )

gnv_appeondb.of_commitqueue( )

FOR i = 1 TO upperbound(al_rec_id)
	lds_cred_comms.setfilter('facility_id='+string(ai_facility_id[i]))
	lds_cred_comms.filter()
	li_num_comms = lds_cred_comms.Rowcount()
	FOR c = 1 TO li_num_comms
		li_nr = lds_cred_committees.InsertRow( 0 )
		lds_cred_committees.SetItem( li_nr, "facility_id", ai_facility_id[i] )
		lds_cred_committees.SetItem( li_nr, "committee_id", lds_cred_comms.GetItemNumber( c, "committee_id" ) )
		lds_cred_committees.SetItem( li_nr, "active_status", 1 )
		lds_cred_committees.SetItem( li_nr, "rec_id", al_rec_id[i] )
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2005-11-25 By: Zhang Lingping
		//$<reason> The column "prac_id" can not be set to null.
		lds_cred_committees.SetItem( li_nr, "prac_id", al_prac_id[i] )
		//---------------------------- APPEON END ----------------------------
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2005-11-16 By: Liang QingShi
		//$<reason> The column "seq_no" is not null.
	
		lds_cred_committees.SetItem( li_nr, "seq_no", 1 )
		//---------------------------- APPEON END ----------------------------
	END FOR
	
END FOR
	
lds_cred_committees.Update( )

DESTROY lds_cred_comms;
DESTROY lds_cred_committees;


Return 1
end function

public function integer of_hospital_link_arr (long al_prac_id[], integer ai_facility_id[]);//////////////////////////////////////////////////////////////////////
// $<function>w_batch_add_new_appof_hospital_link_arr()
// $<arguments> value	long al_prac_id[]
// $<arguments> value	integer	ai_facility_id[]
// $<returns> integer
// $<description>Accept arrays as arguments
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.16.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////

Integer li_hosp_cnt
Integer i,c
Integer li_nr
Integer li_found
long ll_rec //maha 121702
Long ll_hosp_id
n_ds lds_hosp_link
n_ds lds_all_hosp

gnv_appeondb.of_startqueue( )

lds_hosp_link = CREATE n_ds
lds_hosp_link.DataObject = "d_hf_link_all"
lds_hosp_link.of_SetTransObject( SQLCA )
lds_hosp_link.Retrieve( )

lds_all_hosp = CREATE n_ds
lds_all_hosp.DataObject = "d_hosp_affil_prac_all"
lds_all_hosp.of_SetTransObject( SQLCA )
lds_all_hosp.Retrieve( )

gnv_appeondb.of_commitqueue( )

FOR c = 1 TO upperbound(al_prac_id)
	lds_all_hosp.setfilter("prac_id="+string(al_prac_id[c]))
	lds_all_hosp.filter()
	li_hosp_cnt = lds_all_hosp.Rowcount()
	//for each hospital put an entry in the hospital link table for the new facility being added
	FOR i = 1 TO li_hosp_cnt
		ll_rec = lds_all_hosp.GetItemNumber( i, "rec_id" )
		li_found = lds_hosp_link.Find( "facility_id = " + String( ai_facility_id[c] ) + " and hosp_affil_id = " + string(ll_rec) + " and prac_id = " + string(al_prac_id[c]), 1, 1000 )
		IF li_found > 0 THEN
			CONTINUE
		END IF
		li_nr = lds_hosp_link.InsertRow( 0 )	
		lds_hosp_link.SetItem( li_nr, "prac_id", al_prac_id )
		lds_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
		lds_hosp_link.SetItem( li_nr, "facility_id", ai_facility_id )
	END FOR
END FOR

IF lds_hosp_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating Hospital link table." )
	DESTROY lds_hosp_link
	DESTROY lds_all_hosp
	RETURN -1
END IF


DESTROY lds_hosp_link
DESTROY lds_all_hosp

RETURN 1


end function

public function integer of_specialty_link_arr (long al_prac_id[], integer ai_facility_id[]);//////////////////////////////////////////////////////////////////////
// $<function>w_batch_add_new_appof_specialty_link_arr()
// $<arguments> value	long al_prac_id[]
// $<arguments> value	integer	ai_facility_id[]
// $<returns> integer
// $<description>Accept arrays as arguments
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.16.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////

Integer li_spec_cnt
Integer i,c
Integer li_nr
Integer li_found
Long ll_spec_id
long ll_rec
n_ds lds_spec_link
n_ds lds_all_spec

gnv_appeondb.of_startqueue( )

lds_spec_link = CREATE n_ds
lds_spec_link.DataObject = "d_sf_link_all"
lds_spec_link.of_SetTransObject( SQLCA )
lds_spec_link.Retrieve()

lds_all_spec = CREATE n_ds
lds_all_spec.DataObject = "d_spec_of_prac_all"
lds_all_spec.of_SetTransObject( SQLCA )
lds_all_spec.Retrieve()

gnv_appeondb.of_commitqueue( )

FOR c = 1 TO upperbound(al_prac_id)
	lds_all_spec.setfilter('prac_id='+string(al_prac_id[c]))
	lds_all_spec.filter()
	li_spec_cnt = lds_all_spec.Rowcount()
	//for each specialty put an entry in the specialty link table for the new facility being added
	FOR i = 1 TO li_spec_cnt
		ll_rec = lds_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
		li_found = lds_spec_link.Find( "facility_id = " + String( ai_facility_id[c] ) + " and specialty_id = " + string(ll_rec) + " and prac_id = " + String( al_prac_id[c] ), 1, 1000 )
		IF li_found > 0 THEN
			CONTINUE
		END IF	
		li_nr = lds_spec_link.InsertRow( 0 )	
		lds_spec_link.SetItem( li_nr, "prac_id", ai_facility_id )
		lds_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
		lds_spec_link.SetItem( li_nr, "facility_id", ai_facility_id )
		lds_spec_link.SetItem( li_nr, "practicing", 582 )
	next
END FOR

IF lds_spec_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating specialty link table." )
	DESTROY lds_spec_link
	DESTROY lds_all_spec
	RETURN -1
END IF


DESTROY lds_spec_link
DESTROY lds_all_spec

RETURN 1


end function

public function integer of_add_net_dev_ai_arr (string as_app_type, long al_prac_id[], integer ai_facility_id);//////////////////////////////////////////////////////////////////////
// $<function>w_batch_add_new_appof_add_net_dev_ai_arr()
// $<arguments> value	string	as_app_type
// $<arguments> value	long al_prac_id[]
// $<arguments> value	integer	ai_facility_id
// $<returns> integer
// $<description>Accept arrays as arguments
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.17.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////

Long ll_rec_id
Long ll_action_type			
Long ll_action_status
Long ll_action_dept
Integer li_ai_cnt,li_app_rc,li_app_id
String ls_action_notes
DateTime ldt_action_date
long c,i

ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")		
			
ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
ll_action_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Incomplete') + "'"))
ll_action_dept = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Department') + "'" + " and upper(code) = '" + upper('Credentialing') + "'"))
						
//check to see if ai allready exists
datastore lds_save
long ll_rowsave
date ldt_null				
				
lds_save = create datastore 
lds_save.dataobject = "d_appeon_net_dev_action_items_save"
lds_save.settransobject(sqlca)
lds_save.retrieve()

dw_1.accepttext()
li_app_rc = dw_1.rowcount()
ll_rec_id = gnv_app.of_Get_Id("RECORD_ID",upperbound(al_prac_id)*li_app_rc) - 1

for i = 1 to upperbound(al_prac_id)
	FOR c = 1 TO li_app_rc
		IF dw_1.GetItemNumber( c, "selected" ) = 0 THEN
			CONTINUE
		END IF
		
		//grap app id
		li_app_id = dw_1.GetItemNumber( c, "app_id" )
		
		li_ai_cnt = lds_save.find('prac_id = '+string(al_prac_id[i])+' and facility_id = '+string(ai_facility_id)+' and app_id = '+string(li_app_id)+' and action_type = '+string(ll_action_type)+' and active_status = 1'+' and action_status = '+string(ll_action_status),1,lds_save.rowcount())
		
		IF li_ai_cnt = 0 THEN
			ll_rec_id ++	
			ls_action_notes = ""
			ldt_action_date = DateTime( Today(), Now() )							
			
			setnull(ldt_null)
				
			ll_rowsave = lds_save.insertrow(0)
			lds_save.setitem(ll_rowsave,"rec_id",ll_rec_id)
			lds_save.setitem(ll_rowsave,"prac_id",al_prac_id[i])
			lds_save.setitem(ll_rowsave,"seq_no",ll_rec_id)
			lds_save.setitem(ll_rowsave,"action_type",ll_action_type)
			lds_save.setitem(ll_rowsave,"action_date",ldt_action_date)
			lds_save.setitem(ll_rowsave,"action_dept",ll_action_dept)
			lds_save.setitem(ll_rowsave,"action_user",gs_user_id)
			lds_save.setitem(ll_rowsave,"next_action_date",ldt_null)
			lds_save.setitem(ll_rowsave,"notes",ls_action_notes)
			lds_save.setitem(ll_rowsave,"action_status",ll_action_status)
			lds_save.setitem(ll_rowsave,"facility_id",ai_facility_id)
			lds_save.setitem(ll_rowsave,"app_id",li_app_id)
			lds_save.setitem(ll_rowsave,"app_type",as_app_type)
			lds_save.setitem(ll_rowsave,"active_status",1)			
			
		END IF	
	next
next

IF lds_save.update() = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 08.23.2007 By: Evan
	//$<Reason> Need to destroy object.
	if IsValid(lds_save) then Destroy lds_save
	//---------------------------- APPEON END ----------------------------	
	Return -1
END IF					

COMMIT USING SQLCA;

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_save) then Destroy lds_save
//---------------------------- APPEON END ----------------------------

Return 1
end function

public function integer of_batch_add_apps (integer ai_facility_id[]);//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
Long ll_count
Long ll_prac_id
Long ll_rec_id
Integer li_app_cnt
Integer li_tick
Integer li_app_id
Integer li_app_rc
Integer i
Integer li_parent_facility_id
Integer li_app_audit_facility
Integer li_ver_facility
Long p
Long li_pc
pfc_cst_nv_data_entry_functions lpfc_de
lpfc_de = CREATE pfc_cst_nv_data_entry_functions

li_parent_facility_id = ai_facility_id

IF gs_cust_type = "I" THEN
	li_app_audit_facility = 1   
   li_ver_facility = 1
ELSE
	//get default facility values
	SELECT facility.default_audit_temp,   
   	    facility.default_verif_facility  
	INTO :li_app_audit_facility,   
   	  :li_ver_facility  
	FROM facility  
	WHERE facility.facility_id = :li_parent_facility_id   ;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error", SQLCA.SQLERRTEXT )
		Return -1
	END IF
END IF

if isnull(li_app_audit_facility) then li_app_audit_facility = 1
if isnull(li_ver_facility) then li_ver_facility = 1

dw_1.AcceptText( )

//how many apps 
li_app_rc = dw_1.RowCount( )

//find out the number of pracs selected
li_pc = upperbound( il_prac_ids[] ) 


//loop through and add facility and net dev ai for each prac
FOR p = 1 TO li_pc


	il_ai_cnt++
	st_pracs.Text = "Creating action items " + String( il_ai_cnt ) + " of " + String( il_ai_rc )

	//add data to appointment status screen
	ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")

	ll_prac_id = il_prac_ids[ p ]

	SELECT Count( prac_id )  
   INTO :ll_count  
   FROM pd_affil_stat  
   WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
         ( pd_affil_stat.parent_facility_id = :li_parent_facility_id ) AND  
         ( pd_affil_stat.active_status in( 1,4 ) )   ;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error", SQLCA.SQLERRTEXT )
		Return -1
	END IF
	IF ll_count = 0 THEN
			//Start Code Change ---- 01.17.2006 #200 maha
			//maha 011706 replaced insert code with datawindow to allow audit function call
			dw_facility_add.reset()
			dw_facility_add.insertrow(1)
			dw_facility_add.setitem(1,"rec_id",ll_rec_id)
			dw_facility_add.setitem(1,"prac_id",ll_prac_id)
			dw_facility_add.setitem(1,"seq_no",1)
			dw_facility_add.setitem(1,"affiliation_status","M")
			dw_facility_add.setitem(1,"parent_facility_id",li_parent_facility_id)
			dw_facility_add.setitem(1,"apptmnt_type","I")
			dw_facility_add.setitem(1,"verifying_facility",li_ver_facility)
			dw_facility_add.setitem(1,"application_audit_facility",li_ver_facility)
			dw_facility_add.setitem(1,"active_status",1)
			dw_facility_add.setitem(1,"priority_user","PUBLIC")
			dw_facility_add.setitem(1,"priority",1)
			if dw_facility_add.update() = -1 then
				messagebox("Batch Add","Failed to add Facility")
				return -1
			end if
//			INSERT INTO pd_affil_stat  
//				( rec_id,   
//				  prac_id,   
//				  parent_facility_id,   
//				  seq_no,   
//				  apptmnt_type,   
//				  active_status,   
//				  verifying_facility,   
//				  application_audit_facility,   
//				  priority,   
//				  priority_user,   
//				  affiliation_status )  
//			VALUES (:ll_rec_id,   
//				  :ll_prac_id,   
//				  :li_parent_facility_id,   
//				  1,   
//				  'I',   
//				  1,   
//				  :li_ver_facility,   
//				  :li_app_audit_facility,   
//				  1,   
//				  'Master',   
//				  'M' )  ;	
//			IF SQLCA.SQLCODE = -1 THEN
//				MessageBox("SQL Error", SQLCA.SQLERRTEXT )
//				Return -1
//			END IF
			

			lpfc_de.of_add_address_link( ll_prac_id, li_parent_facility_id )
			lpfc_de.of_field_audit(dw_facility_add) //maha 011706
			lpfc_de.of_add_hosp_link( li_parent_facility_id , ll_prac_id)
			lpfc_de.of_add_spec_link( li_parent_facility_id , ll_prac_id )
//			of_hospital_link( ll_prac_id, li_parent_facility_id )
//			of_specialty_link(ll_prac_id, li_parent_facility_id )
			
			lpfc_de.of_add_committees( ll_prac_id, li_parent_facility_id, ll_rec_id )
			
	END IF

	FOR i = 1 TO li_app_rc
		IF dw_1.GetItemNumber( i, "selected" ) = 0 THEN
			CONTINUE
		END IF
			
		//grap app id
		li_app_id = dw_1.GetItemNumber( i, "app_id" )
			
		//create the action item
		of_add_net_dev_ai( li_app_id, "I", il_prac_ids[ p ], li_parent_facility_id )
	END FOR
END FOR

st_pracs.Text = "Complete"

Return 1
*/
Long ll_count
Long ll_prac_id
Long ll_rec_id
Integer li_app_cnt
Integer li_tick
Integer li_app_id[]
Integer li_app_rc
Integer i
Integer li_parent_facility_id[]
Integer li_app_audit_facility
Integer li_ver_facility
Long p
Long li_pc
Long ll_insertrow
int	iarray
int 	li_findrow

pfc_cst_nv_data_entry_functions lpfc_de
lpfc_de = CREATE pfc_cst_nv_data_entry_functions

datastore	lds_facility
li_parent_facility_id = ai_facility_id

lds_facility = create datastore
lds_facility.dataobject = 'd_facility_for_pt'
lds_facility.settransobject( sqlca)
lds_facility.retrieve( li_parent_facility_id)

dw_1.AcceptText( )
//how many apps 
li_app_rc = dw_1.RowCount( )

//find out the number of pracs selected
li_pc = upperbound( il_prac_ids[] ) 
//ll_rec_id = gnv_app.of_Get_Id("RECORD_ID", li_pc * li_app_rc) - 1 //Commented by (Appeon)Harry 10.30.2015 - for Bug id 4811
ll_rec_id = gnv_app.of_Get_Id("RECORD_ID", li_pc * (li_app_rc + upperbound(li_parent_facility_id))) - 1


datastore 	lds_pd_affil_stat
datastore	lds_save_for_pt

lds_save_for_pt = create datastore
lds_save_for_pt.dataobject = 'd_pd_affil_stat_save_for_pt'
lds_save_for_pt.settransobject( sqlca)
lds_pd_affil_stat = create datastore
lds_pd_affil_stat.dataobject = 'd_pd_affil_stat_for_pt'
lds_pd_affil_stat.settransobject( sqlca)
ids_save = Create datastore
ids_save.DataObject = "d_appeon_net_dev_action_items_save"
ids_save.SetTransObject(SQLCA)


ids_d_net_dev_action_items = Create datastore
ids_d_net_dev_action_items.DataObject = "d_net_dev_action_items_for_pt"
ids_d_net_dev_action_items.SetTransObject(SQLCA)
long	ll_action_type
long	ll_action_status
ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
ll_action_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Incomplete') + "'"))
FOR i = 1 TO li_app_rc
	li_app_id[i] = dw_1.GetItemNumber( i, "app_id" )
END FOR
if upperbound(li_app_id) = 0 then
	li_app_id[1] = 0
end if

ids_all_addresses = CREATE n_ds
ids_all_addresses.DataObject = "d_address_link_all_addresses_for_pt"
ids_all_addresses.of_SetTransObject( SQLCA )
ids_pd_address_link = create datastore
ids_pd_address_link.dataobject = 'd_pd_address_link_for_pt'
ids_pd_address_link.settransobject( sqlca)
ids_address_link = CREATE n_ds
ids_address_link.DataObject = "d_address_link"
ids_address_link.of_SetTransObject( SQLCA )


ids_hosp_link = CREATE n_ds
ids_hosp_link.DataObject = "d_hf_link_for_pt"
ids_hosp_link.of_SetTransObject( SQLCA )
ids_all_hosp = CREATE n_ds
ids_all_hosp.DataObject = "d_hosp_affil_prac_for_pt"
ids_all_hosp.of_SetTransObject( SQLCA )


ids_spec_link = CREATE n_ds
ids_spec_link.DataObject = "d_sf_link_for_pt"
ids_spec_link.of_SetTransObject( SQLCA )
ids_all_spec = CREATE n_ds
ids_all_spec.DataObject = "d_spec_of_prac_for_pt"
ids_all_spec.of_SetTransObject( SQLCA )


ids_cred_committees = CREATE n_ds
ids_cred_committees.DataObject = "d_pd_comm_review" 
ids_cred_committees.of_SetTransObject( SQLCA )
ids_cred_comms = CREATE n_ds
ids_cred_comms.DataObject = "d_dddw_credentialing_committees_for_pt" 
ids_cred_comms.of_SetTransObject( SQLCA )


gnv_appeondb.of_startqueue( )

lds_pd_affil_stat.retrieve(il_prac_ids, li_parent_facility_id)
ids_d_net_dev_action_items.retrieve( il_prac_ids,li_parent_facility_id,li_app_id,ll_action_type,ll_action_status)
ids_all_addresses.Retrieve( il_prac_ids )
ids_pd_address_link.retrieve(il_prac_ids,li_parent_facility_id)
ids_hosp_link.Retrieve( il_prac_ids )
ids_all_hosp.Retrieve( il_prac_ids )
ids_spec_link.Retrieve( il_prac_ids )
ids_all_spec.Retrieve( il_prac_ids )
ids_cred_comms.Retrieve( li_parent_facility_id)

gnv_appeondb.of_commitqueue( )


//loop through and add facility and net dev ai for each prac
FOR p = 1 TO li_pc
	il_ai_cnt++
	st_pracs.Text = "Creating action items " + String( il_ai_cnt ) + " of " + String( il_ai_rc )

	//add data to appointment status screen
	//ll_rec_id ++
	ll_prac_id = il_prac_ids[p]
	for iarray = 1 to upperbound(li_parent_facility_id)
		ll_count = lds_pd_affil_stat.find('prac_id = ' + string(ll_prac_id) + ' and parent_facility_id = ' + string(li_parent_facility_id[iarray]), 1, lds_pd_affil_stat.rowcount( ))
		IF ll_count = 0 THEN
			IF gs_cust_type = "I" THEN
				li_app_audit_facility = 1   
				li_ver_facility = 1
			ELSE
					li_findrow = lds_facility.find( 'facility_id = '+string(li_parent_facility_id[iarray]), 1, lds_facility.rowcount())
				if li_findrow > 0 then
					li_app_audit_facility = lds_facility.object.default_audit_temp[li_findrow]
					li_ver_facility = lds_facility.object.default_audit_temp[li_findrow]
				end if
			END IF

			if isnull(li_app_audit_facility) then li_app_audit_facility = 1
			if isnull(li_ver_facility) then li_ver_facility = 1
			
			ll_rec_id ++ //Added By Ken.Guo 09.02.2008	
			ll_insertrow = lds_save_for_pt.insertrow(0)
			lds_save_for_pt.object.rec_id[ll_insertrow] = ll_rec_id
			lds_save_for_pt.object.prac_id[ll_insertrow] = ll_prac_id
			lds_save_for_pt.object.parent_facility_id[ll_insertrow] = li_parent_facility_id[iarray]
			lds_save_for_pt.object.seq_no[ll_insertrow] = 1
			lds_save_for_pt.object.apptmnt_type[ll_insertrow] = 'I'
			lds_save_for_pt.object.active_status[ll_insertrow] = 1
			lds_save_for_pt.object.verifying_facility[ll_insertrow] = li_ver_facility
			lds_save_for_pt.object.application_audit_facility[ll_insertrow] = li_app_audit_facility
			lds_save_for_pt.object.priority[ll_insertrow] = 1
			lds_save_for_pt.object.priority_user[ll_insertrow] = 'Master'
			lds_save_for_pt.object.affiliation_status[ll_insertrow] = 'M'
			
			of_add_address_link_for_pt( ll_prac_id, li_parent_facility_id[iarray] )
			of_hospital_link_for_pt( ll_prac_id, li_parent_facility_id[iarray] )
			of_specialty_link_for_pt(ll_prac_id, li_parent_facility_id[iarray] )
			of_add_committees_for_pt( ll_prac_id, li_parent_facility_id[iarray], ll_rec_id )
		END IF
	
		if not cbx_skip.checked then //allow skipping of apps
		FOR i = 1 TO li_app_rc
			IF dw_1.GetItemNumber( i, "selected" ) = 0 THEN
				CONTINUE
			END IF

			ll_rec_id ++	
			//create the action item
			of_add_net_dev_ai_for_pt( li_app_id[i], "I", il_prac_ids[ p ], li_parent_facility_id[iarray] ,ll_rec_id, ll_action_type, ll_action_status)
		END FOR
		end if
		//End Code Change---01.17.2006

	next
END FOR

gnv_appeondb.of_startqueue( )

lds_save_for_pt.update()
ids_save.Update()
ids_address_link.Update()
ids_hosp_link.Update()
ids_spec_link.Update()
ids_cred_committees.Update( )

gnv_appeondb.of_commitqueue( )

destroy lds_pd_affil_stat
destroy ids_save
destroy ids_d_net_dev_action_items
destroy lds_save_for_pt
destroy ids_all_addresses
DESTROY ids_address_link
DESTROY ids_all_addresses
destroy ids_pd_address_link
DESTROY ids_hosp_link
DESTROY ids_all_hosp
DESTROY ids_spec_link
DESTROY ids_all_spec
DESTROY ids_cred_comms;
DESTROY ids_cred_committees;

st_pracs.Text = "Complete"

DESTROY lpfc_de

Return 1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_specialty_link_for_pt (long al_prac_id, integer ai_facility_id);
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Rewrite the original of_specialty_link to provide the same functionality.
//$<modification> The modification reduces client-server interactions.

Integer li_spec_cnt
Integer i
Integer li_nr
Integer li_found
Long ll_spec_id
long ll_rec

ids_all_spec.setfilter( 'prac_id = '+string(al_prac_id))
ids_all_spec.filter( )
li_spec_cnt = ids_all_spec.rowcount( )

//for each specialty put an entry in the specialty link table for the new facility being added
FOR i = 1 TO li_spec_cnt
	ll_rec = ids_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
	li_found = ids_spec_link.Find( "facility_id = " + String( ai_facility_id ) + " and specialty_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF	
	li_nr = ids_spec_link.InsertRow( 0 )	
	ids_spec_link.SetItem( li_nr, "prac_id", al_prac_id )
	ids_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
	ids_spec_link.SetItem( li_nr, "facility_id", ai_facility_id )
	ids_spec_link.SetItem( li_nr, "practicing", 582 )
next

RETURN 1

//---------------------------- APPEON END ----------------------------
end function

public function integer of_hospital_link_for_pt (long al_prac_id, integer ai_facility_id);//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Rewrite the original of_hospital_link to provide the same functionality.
//$<modification> The modification reduces client-server interactions.

Integer li_hosp_cnt
Integer i
Integer li_nr
Integer li_found
long ll_rec //maha 121702
Long ll_hosp_id

li_hosp_cnt = ids_all_hosp.setfilter('prac_id = '+string(al_prac_id))
ids_all_hosp.filter( )
li_hosp_cnt = ids_all_hosp.rowcount( )

//for each hospital put an entry in the hospital link table for the new facility being added
FOR i = 1 TO li_hosp_cnt
	ll_rec = ids_all_hosp.GetItemNumber( i, "rec_id" )
	li_found = ids_hosp_link.Find( "facility_id = " + String( ai_facility_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF
	li_nr = ids_hosp_link.InsertRow( 0 )	
	ids_hosp_link.SetItem( li_nr, "prac_id", al_prac_id )
	ids_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
	ids_hosp_link.SetItem( li_nr, "facility_id", ai_facility_id )
END FOR

RETURN 1

//---------------------------- APPEON END ----------------------------
end function

public function integer of_add_address_link_for_pt (long al_prac_id, integer ai_facility_id);//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Rewrite the original of_add_address to provide the same functionality.
//$<modification> The modification reduces client-server interactions.
//called from net dev of_add_multi

Integer li_address_cnt
Integer i
Integer li_nr
Long ll_address_id
long ll_addr_id //maha 02-26-01
integer cnt

ids_all_addresses.setfilter('prac_id = ' + string(al_prac_id))
ids_all_addresses.filter( )
li_address_cnt = ids_all_addresses.rowcount( )

//for each address put an entry in the address link table for the new facility being added
FOR i = 1 TO li_address_cnt
	ll_addr_id = ids_all_addresses.GetItemNumber( i, "rec_id" )	
	cnt = ids_pd_address_link.find('prac_id = '+string(al_prac_id)+' and facility_id = '+string(ai_facility_id)+' and address_id = '+string(ll_addr_id), 1, ids_pd_address_link.rowcount())
	if cnt > 0 then continue
	li_nr = ids_address_link.InsertRow( 0 )	
	ids_address_link.SetItem( li_nr, "prac_id", al_prac_id )
	ids_address_link.SetItem( li_nr, "address_id", ll_addr_id )
	ids_address_link.SetItem( li_nr, "facility_id", ai_facility_id )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 12/18/2007 By: Ken.Guo
	//$<reason> Fix Issue from Robert about biling & mailing's default value must be '0' in pd_address_link
	//		      after batch add applications.
	/*
	ids_address_link.SetItem( li_nr, "billing", ai_facility_id )//maha app100305
	ids_address_link.SetItem( li_nr, "mailing", ai_facility_id )//maha app100305
	*/
	ids_address_link.SetItem( li_nr, "billing", 0 )
	ids_address_link.SetItem( li_nr, "mailing", 0 )
	//---------------------------- APPEON END ----------------------------
END FOR

RETURN 1

//---------------------------- APPEON END ----------------------------
end function

public function integer of_add_committees_for_pt (long al_prac_id, integer ai_facility_id, long al_rec_id);//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Rewrite the original of_add_committees to provide the same functionality.
//$<modification> The modification reduces client-server interactions.
Integer li_num_comms
Integer c
Integer li_nr

li_num_comms = ids_cred_comms.rowcount( )
	
FOR c = 1 TO li_num_comms
	li_nr = ids_cred_committees.InsertRow( 0 )
	ids_cred_committees.SetItem( li_nr, "facility_id", ai_facility_id )
	ids_cred_committees.SetItem( li_nr, "committee_id", ids_cred_comms.GetItemNumber( c, "committee_id" ) )
	ids_cred_committees.SetItem( li_nr, "active_status", 1 )
	ids_cred_committees.SetItem( li_nr, "rec_id", al_rec_id )

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2005-11-25 By: Zhang Lingping
	//$<reason> The column "prac_id" can not be set to null.
	ids_cred_committees.SetItem( li_nr, "prac_id", al_prac_id )
	//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2005-11-16 By: Liang QingShi
	//$<reason> The column "seq_no" is not null.

	ids_cred_committees.SetItem( li_nr, "seq_no", 1 )
	//---------------------------- APPEON END ----------------------------
END FOR

Return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_hospital_link (long al_prac_id, integer ai_facility_id);//maha 011706 no longer used called from data entry functions

//Integer li_hosp_cnt
//Integer i
//Integer li_nr
//Integer li_found
//long ll_rec //maha 121702
//Long ll_hosp_id
//n_ds lds_hosp_link
//n_ds lds_all_hosp
//
//lds_hosp_link = CREATE n_ds
//lds_hosp_link.DataObject = "d_hf_link"
//lds_hosp_link.of_SetTransObject( SQLCA )
//lds_hosp_link.Retrieve( al_prac_id )
//
//lds_all_hosp = CREATE n_ds
//lds_all_hosp.DataObject = "d_hosp_affil_prac"
//lds_all_hosp.of_SetTransObject( SQLCA )
//li_hosp_cnt = lds_all_hosp.Retrieve( al_prac_id )
//
////for each hospital put an entry in the hospital link table for the new facility being added
//FOR i = 1 TO li_hosp_cnt
//	ll_rec = lds_all_hosp.GetItemNumber( i, "rec_id" )
//	li_found = lds_hosp_link.Find( "facility_id = " + String( ai_facility_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
//	IF li_found > 0 THEN
//		CONTINUE
//	END IF
//	li_nr = lds_hosp_link.InsertRow( 0 )	
//	lds_hosp_link.SetItem( li_nr, "prac_id", al_prac_id )
//	lds_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
//	lds_hosp_link.SetItem( li_nr, "facility_id", ai_facility_id )
//END FOR
//
//IF lds_hosp_link.Update() <> 1 THEN
//	MessageBox( "Update Error", "Error updating Hospital link table." )
//	DESTROY lds_hosp_link
//	DESTROY lds_all_hosp
//	RETURN -1
//END IF
//
//
//DESTROY lds_hosp_link
//DESTROY lds_all_hosp

RETURN 1


end function

public function integer of_specialty_link (long al_prac_id, integer ai_facility_id);//maha 011706 no longer used called from data entry functions

//Integer li_spec_cnt
//Integer i
//Integer li_nr
//Integer li_found
//Long ll_spec_id
//long ll_rec
//n_ds lds_spec_link
//n_ds lds_all_spec
//
//lds_spec_link = CREATE n_ds
//lds_spec_link.DataObject = "d_sf_link"
//lds_spec_link.of_SetTransObject( SQLCA )
//lds_spec_link.Retrieve( al_prac_id )
//
//lds_all_spec = CREATE n_ds
//lds_all_spec.DataObject = "d_spec_of_prac"
//lds_all_spec.of_SetTransObject( SQLCA )
//li_spec_cnt = lds_all_spec.Retrieve( al_prac_id )
//
////for each specialty put an entry in the specialty link table for the new facility being added
//FOR i = 1 TO li_spec_cnt
//	ll_rec = lds_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
//	li_found = lds_spec_link.Find( "facility_id = " + String( ai_facility_id ) + " and specialty_id = " + string(ll_rec), 1, 1000 )
//	IF li_found > 0 THEN
//		CONTINUE
//	END IF	
//	li_nr = lds_spec_link.InsertRow( 0 )	
//	lds_spec_link.SetItem( li_nr, "prac_id", ai_facility_id )
//	lds_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
//	lds_spec_link.SetItem( li_nr, "facility_id", ai_facility_id )
//	lds_spec_link.SetItem( li_nr, "practicing", 582 )
//next
//
//IF lds_spec_link.Update() <> 1 THEN
//	MessageBox( "Update Error", "Error updating specialty link table." )
//	DESTROY lds_spec_link
//	DESTROY lds_all_spec
//	RETURN -1
//END IF
//
//
//DESTROY lds_spec_link
//DESTROY lds_all_spec

RETURN 1


end function

public function integer of_add_net_dev_ai_for_pt (integer ai_app_id, string as_app_type, long al_prac_id, integer ai_facility_id, long al_rec_id, long al_action_type, long al_action_status);
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Rewrite the original of_add_net_dev_ai to provide the same functionality.
//$<modification> The modification reduces client-server interactions.
Long ll_action_type
Long ll_action_status
Long ll_action_dept
Integer li_ai_cnt
String ls_action_notes
DateTime ldt_action_date

ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
ll_action_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Incomplete') + "'"))
ll_action_dept = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Department') + "'" + " and upper(code) = '" + upper('Credentialing') + "'"))
					
//check to see if ai allready exists	
li_ai_cnt = ids_d_net_dev_action_items.find('prac_id = '+string(al_prac_id)+' and facility_id = '+string(ai_facility_id)+' and app_id = '+string(ai_app_id)+&
' and action_type = ' + string(ll_action_type) + ' AND active_status = 1 AND action_status = ' + string(ll_action_status), 1, ids_d_net_dev_action_items.rowcount())
If li_ai_cnt = 0 Then
	
	ls_action_notes = ""
	ldt_action_date = DateTime( Today(), Now() )
	
	Long ll_rowsave
	Date ldt_null
	SetNull(ldt_null)
	ll_rowsave = ids_save.InsertRow(0)
	ids_save.SetItem(ll_rowsave,"rec_id",al_rec_id)
	ids_save.SetItem(ll_rowsave,"prac_id",al_prac_id)
	ids_save.SetItem(ll_rowsave,"seq_no",al_rec_id)
	ids_save.SetItem(ll_rowsave,"action_type",al_action_type)
	ids_save.SetItem(ll_rowsave,"action_date",ldt_action_date)
	ids_save.SetItem(ll_rowsave,"action_dept",ll_action_dept)
	ids_save.SetItem(ll_rowsave,"action_user",gs_user_id)
	ids_save.SetItem(ll_rowsave,"next_action_date",ldt_null)
	ids_save.SetItem(ll_rowsave,"notes",ls_action_notes)
	ids_save.SetItem(ll_rowsave,"action_status",al_action_status)
	ids_save.SetItem(ll_rowsave,"facility_id",ai_facility_id)
	ids_save.SetItem(ll_rowsave,"app_id",ai_app_id)
	ids_save.SetItem(ll_rowsave,"app_type",as_app_type)
	ids_save.SetItem(ll_rowsave,"active_status",1)
End If

Return 1

//---------------------------- APPEON END ----------------------------
end function

on w_batch_add_new_app.create
int iCurrent
call super::create
this.dw_facility=create dw_facility
this.cb_prac=create cb_prac
this.cb_create=create cb_create
this.st_1=create st_1
this.cb_5=create cb_5
this.st_pracs=create st_pracs
this.dw_all_facilities=create dw_all_facilities
this.st_2=create st_2
this.cb_batch=create cb_batch
this.st_3=create st_3
this.st_4=create st_4
this.cb_3=create cb_3
this.dw_facility_add=create dw_facility_add
this.cbx_skip=create cbx_skip
this.st_5=create st_5
this.cb_all=create cb_all
this.cb_now=create cb_now
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_facility
this.Control[iCurrent+2]=this.cb_prac
this.Control[iCurrent+3]=this.cb_create
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.st_pracs
this.Control[iCurrent+7]=this.dw_all_facilities
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_batch
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.dw_facility_add
this.Control[iCurrent+14]=this.cbx_skip
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.cb_all
this.Control[iCurrent+17]=this.cb_now
this.Control[iCurrent+18]=this.st_6
end on

on w_batch_add_new_app.destroy
call super::destroy
destroy(this.dw_facility)
destroy(this.cb_prac)
destroy(this.cb_create)
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.st_pracs)
destroy(this.dw_all_facilities)
destroy(this.st_2)
destroy(this.cb_batch)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_3)
destroy(this.dw_facility_add)
destroy(this.cbx_skip)
destroy(this.st_5)
destroy(this.cb_all)
destroy(this.cb_now)
destroy(this.st_6)
end on

type dw_1 from w_select_applications`dw_1 within w_batch_add_new_app
integer x = 96
integer y = 280
integer width = 2798
integer height = 1080
end type

event dw_1::constructor;call super::constructor;This.of_SetUpdateable( False )
end event

event dw_1::clicked;call super::clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
END IF
end event

type cb_1 from w_select_applications`cb_1 within w_batch_add_new_app
boolean visible = false
integer x = 2702
integer y = 192
integer taborder = 100
end type

type cb_2 from w_select_applications`cb_2 within w_batch_add_new_app
integer x = 2418
integer y = 96
integer width = 475
integer taborder = 110
string text = "Close"
end type

type dw_facility from pfc_cst_u_org_facility_selector_horiz within w_batch_add_new_app
integer x = 87
integer y = 20
integer width = 1225
integer height = 172
integer taborder = 20
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;cb_prac.Enabled = True
cb_batch.Enabled = True
end event

type cb_prac from commandbutton within w_batch_add_new_app
integer x = 91
integer y = 1388
integer width = 526
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Select Practitioner"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
long r
long rc
long i
long ic
gs_search lstr_search
gs_batch_search lst_batch

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" + String( il_facility_id ) 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_prac_ids )
////ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(lst_batch.li_prac_id[])
//maha app101305
for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i] //maha 091605
	for r = 1 to rc
		if il_prac_ids[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_prac_ids[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next


st_pracs.Text = String( UpperBound( il_prac_ids[] ) ) + " Practitioners selected."

IF UpperBound( il_prac_ids ) > 0 THEN
	cb_create.Enabled = True
	cb_now.Enabled = True
END IF

 

end event

type cb_create from commandbutton within w_batch_add_new_app
integer x = 87
integer y = 1484
integer width = 530
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Create Data Records"
end type

event clicked;Integer li_ans
Integer i
Integer li_app_rc
Long li_app_cnt
Long li_pc

dw_1.AcceptText()

//find out the number of pracs selected
li_pc = upperbound( il_prac_ids[] ) 

IF li_pc = 0 THEN
	MessageBox("Practitioner Select Error", "You have not selected any practitioner to add applications to." )
	Return -1
END IF

li_app_rc = dw_1.RowCount( )
FOR i = 1 TO li_app_rc
	IF dw_1.GetItemNumber( i, "selected" ) = 1 THEN	
		li_app_cnt++
	END IF
END FOR
IF li_app_cnt = 0 THEN 
	if not cbx_skip.checked then
		MessageBox("Application Select Error", "You must select at least one application." )
		Return 
	end if		
else
	if cbx_skip.checked then //maha 011806
		li_ans =	MessageBox("???", "You have selected Applications, but have checked Create Facility Records Only.  If you continue, the facility records will be created, but the Action Items will not.~rIf you wish to add the applications, Click No on this message, uncheck the Create Facility Records Only checkbox, and click Create Data Records again.~r~r Continue?" ,Question!,yesno!,2 )
		IF li_ans = 2 THEN	Return 
	end if
end if
//debugbreak()


IF dw_facility.GetItemNumber( 1, "facility_id" ) = 0 THEN
	li_ans = MessageBox( "All Facilities", "Are you sure you want to create a PRINT APPLICATION action item for all facilities?", Question!, YesNo!, 1 )
	IF li_ans = 2 THEN
		Return
	END IF
	il_ai_rc = li_pc * dw_all_facilities.RowCount( ) * li_app_cnt
ELSE
	il_ai_rc = li_pc * li_app_cnt
END IF

if not cbx_skip.checked then //maha 011806
	li_ans = MessageBox( "Create Action Items", String( il_ai_rc ) + " Application action items will be created.  Continue?", Information!, YesNo!, 2)
	IF li_ans = 1 THEN
		of_batch_add( )
	end if
else
	of_batch_add( )
END IF
end event

type st_1 from statictext within w_batch_add_new_app
integer x = 101
integer y = 212
integer width = 745
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
string text = "Select Application(s)"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_batch_add_new_app
integer x = 1915
integer y = 96
integer width = 475
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&About"
boolean cancel = true
end type

type st_pracs from statictext within w_batch_add_new_app
integer x = 1627
integer y = 1408
integer width = 891
integer height = 76
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
string text = "No practitioner selected"
boolean focusrectangle = false
end type

type dw_all_facilities from datawindow within w_batch_add_new_app
boolean visible = false
integer x = 1454
integer y = 68
integer width = 498
integer height = 152
boolean bringtotop = true
string dataobject = "d_dddw_facility"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject( SQLCA )
This.Retrieve()
end event

type st_2 from statictext within w_batch_add_new_app
integer x = 9
integer y = 32
integer width = 55
integer height = 76
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
string text = "1)"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_batch from commandbutton within w_batch_add_new_app
integer x = 622
integer y = 1388
integer width = 489
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Batch Select"
end type

event clicked;openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return

ist_search = message.powerobjectparm
il_prac_ids[] = ist_search.li_prac_id[]
is_prac_names[] = ist_search.ls_name[]

st_pracs.Text = String( UpperBound( il_prac_ids[] ) ) + " Practitioners selected."

IF UpperBound( il_prac_ids ) > 0 THEN
	cb_create.Enabled = True
	cb_now.Enabled = True
END IF

 

end event

type st_3 from statictext within w_batch_add_new_app
integer x = 9
integer y = 1396
integer width = 55
integer height = 76
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
string text = "3)"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_batch_add_new_app
integer x = 9
integer y = 1488
integer width = 55
integer height = 76
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
string text = "4)"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_batch_add_new_app
integer x = 1115
integer y = 1388
integer width = 489
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Practitioners"
end type

event clicked;gs_batch_search ls_b



IF UpperBound( il_prac_ids ) > 0 THEN
	ls_b.li_prac_id[] = il_prac_ids[]
	openwithparm(w_selected_prac_list,ls_b)
END IF
end event

type dw_facility_add from u_dw within w_batch_add_new_app
boolean visible = false
integer x = 2537
integer y = 1380
integer width = 334
integer height = 148
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pd_affil_status_ia"
boolean vscrollbar = false
end type

type cbx_skip from checkbox within w_batch_add_new_app
integer x = 1051
integer y = 208
integer width = 1225
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Create Facility records only; Skip action items."
end type

type st_5 from statictext within w_batch_add_new_app
integer x = 9
integer y = 212
integer width = 55
integer height = 76
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
string text = "2)"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_all from commandbutton within w_batch_add_new_app
integer x = 608
integer y = 208
integer width = 343
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;long i
integer v


if this.text = 'Select All' then
	v = 1
	this.text = 'Deselect All'
else
	v = 0
	this.text = 'Select All'
end if

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,"selected",v)
next
end event

type cb_now from commandbutton within w_batch_add_new_app
integer x = 773
integer y = 1484
integer width = 901
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Print NOW /No Action Items Created"
end type

event clicked;//Start Code Change ---- 04.07.2006 #395 maha new button

integer i
integer a
Integer li_app_rc
Long li_app_cnt = 0
Long li_pc
long p
long cnt
long pid
string pn

dw_1.AcceptText()

//find out the number of pracs selected
li_pc = upperbound( il_prac_ids[] ) 

IF li_pc = 0 THEN
	MessageBox("Practitioner Select Error", "You have not selected any practitioner to add applications to." )
	Return -1
END IF

li_app_rc = dw_1.RowCount( )
FOR i = 1 TO li_app_rc
	IF dw_1.GetItemNumber( i, "selected" ) = 1 THEN	
		li_app_cnt++
	END IF
END FOR


IF li_app_cnt = 0 THEN 
	MessageBox("Application Select Error", "You must select at least one application." )
	Return 		
end if
//debugbreak()

IF dw_facility.GetItemNumber( 1, "facility_id" ) = 0 THEN
	MessageBox( "All Facilities", "You must select a Facility." )
	Return
END IF

for p = 1 to li_pc
	for a = 1 TO li_app_rc
		IF dw_1.GetItemNumber( a, "selected" ) = 1 THEN
			cnt++
			pid = il_prac_ids[p]
			ist_search.li_prac_id[cnt]  = pid
			pn = is_prac_names[p]
			ist_search.ls_name[cnt] = pn
			ist_search.ll_app[cnt] = dw_1.GetItemNumber( a, "app_id" )
			ist_search.ll_facility[cnt] = dw_facility.GetItemNumber( 1, "facility_id" )
		end if
	next
next

openwithparm(w_intelliapp_print,ist_search)
w_intelliapp_print.lst_search = ist_search
w_intelliapp_print.of_print_now()

close(w_batch_add_new_app)


end event

type st_6 from statictext within w_batch_add_new_app
integer x = 645
integer y = 1500
integer width = 101
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "OR"
boolean focusrectangle = false
end type

