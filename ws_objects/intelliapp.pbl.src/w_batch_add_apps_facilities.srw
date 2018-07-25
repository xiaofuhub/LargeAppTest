$PBExportHeader$w_batch_add_apps_facilities.srw
forward
global type w_batch_add_apps_facilities from w_select_applications
end type
type cb_create from commandbutton within w_batch_add_apps_facilities
end type
type cb_5 from commandbutton within w_batch_add_apps_facilities
end type
type dw_all_facilities from datawindow within w_batch_add_apps_facilities
end type
type st_3 from statictext within w_batch_add_apps_facilities
end type
type st_4 from statictext within w_batch_add_apps_facilities
end type
type dw_facility_add from u_dw within w_batch_add_apps_facilities
end type
type cb_now from commandbutton within w_batch_add_apps_facilities
end type
type st_6 from statictext within w_batch_add_apps_facilities
end type
type rb_facility from radiobutton within w_batch_add_apps_facilities
end type
type rb_apps from radiobutton within w_batch_add_apps_facilities
end type
type rb_print from radiobutton within w_batch_add_apps_facilities
end type
type dw_type from datawindow within w_batch_add_apps_facilities
end type
type st_1 from statictext within w_batch_add_apps_facilities
end type
type sle_note from singlelineedit within w_batch_add_apps_facilities
end type
type st_2 from statictext within w_batch_add_apps_facilities
end type
type cbx_done from checkbox within w_batch_add_apps_facilities
end type
type st_5 from statictext within w_batch_add_apps_facilities
end type
type gb_1 from groupbox within w_batch_add_apps_facilities
end type
type gb_3 from groupbox within w_batch_add_apps_facilities
end type
type cb_prac from commandbutton within w_batch_add_apps_facilities
end type
type cb_batch from commandbutton within w_batch_add_apps_facilities
end type
type cb_view from commandbutton within w_batch_add_apps_facilities
end type
type st_pracs from statictext within w_batch_add_apps_facilities
end type
type cb_3 from commandbutton within w_batch_add_apps_facilities
end type
type dw_locations from datawindow within w_batch_add_apps_facilities
end type
type cbx_items from checkbox within w_batch_add_apps_facilities
end type
type cb_4 from commandbutton within w_batch_add_apps_facilities
end type
type st_group from statictext within w_batch_add_apps_facilities
end type
type st_loc from statictext within w_batch_add_apps_facilities
end type
type st_app from statictext within w_batch_add_apps_facilities
end type
type dw_user from datawindow within w_batch_add_apps_facilities
end type
type st_7 from statictext within w_batch_add_apps_facilities
end type
type pb_notes from picturebutton within w_batch_add_apps_facilities
end type
type cb_filter_fac from commandbutton within w_batch_add_apps_facilities
end type
type cb_filter_loc from commandbutton within w_batch_add_apps_facilities
end type
type cb_filter_app from commandbutton within w_batch_add_apps_facilities
end type
type sle_ffac from singlelineedit within w_batch_add_apps_facilities
end type
type sle_fapp from singlelineedit within w_batch_add_apps_facilities
end type
type sle_floc from singlelineedit within w_batch_add_apps_facilities
end type
type st_8 from statictext within w_batch_add_apps_facilities
end type
type dw_dept from datawindow within w_batch_add_apps_facilities
end type
type ddlb_ir from dropdownlistbox within w_batch_add_apps_facilities
end type
type st_ir from statictext within w_batch_add_apps_facilities
end type
type cbx_add_ids from checkbox within w_batch_add_apps_facilities
end type
type dw_ids from datawindow within w_batch_add_apps_facilities
end type
type gb_prac from groupbox within w_batch_add_apps_facilities
end type
end forward

global type w_batch_add_apps_facilities from w_select_applications
integer x = 283
integer y = 352
integer width = 4475
integer height = 2712
string title = "Batch Process"
cb_create cb_create
cb_5 cb_5
dw_all_facilities dw_all_facilities
st_3 st_3
st_4 st_4
dw_facility_add dw_facility_add
cb_now cb_now
st_6 st_6
rb_facility rb_facility
rb_apps rb_apps
rb_print rb_print
dw_type dw_type
st_1 st_1
sle_note sle_note
st_2 st_2
cbx_done cbx_done
st_5 st_5
gb_1 gb_1
gb_3 gb_3
cb_prac cb_prac
cb_batch cb_batch
cb_view cb_view
st_pracs st_pracs
cb_3 cb_3
dw_locations dw_locations
cbx_items cbx_items
cb_4 cb_4
st_group st_group
st_loc st_loc
st_app st_app
dw_user dw_user
st_7 st_7
pb_notes pb_notes
cb_filter_fac cb_filter_fac
cb_filter_loc cb_filter_loc
cb_filter_app cb_filter_app
sle_ffac sle_ffac
sle_fapp sle_fapp
sle_floc sle_floc
st_8 st_8
dw_dept dw_dept
ddlb_ir ddlb_ir
st_ir st_ir
cbx_add_ids cbx_add_ids
dw_ids dw_ids
gb_prac gb_prac
end type
global w_batch_add_apps_facilities w_batch_add_apps_facilities

type variables
gs_batch_search ist_search
Long il_prac_ids[] 
String is_prac_names[] 
string is_fac_error
string is_set_field // maha 04.09.2012
string is_user  // maha 06.18.2014
String is_fac_state[]  //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
String is_loc_state[]  //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
string  is_app_name[] //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
Long il_ai_rc = 0
Long il_ai_cnt
long il_action_type  // maha 04.09.2012
long il_facil_passed  //maha 03.13.2013
long il_facility_cnt=0
long ii_facility_id[]  
long ii_app_id[]  //maha 05.22.2014
long il_loc_id[]  //maha 04.07.2014
long il_dept
long il_wf_id   //maha 12.06.2016
long il_wf_step_id   //maha 12.09.2016
long il_trackid_4_add  //maha 12.06.2016
long il_plan_type    //maha 09.05.2017
boolean ib_prac_folder = false
boolean ib_ask = true  //maha 05.02.2016
boolean ib_add_next = false //maha 05.02.2016
boolean ib_do_wf = false //maha 12.02.2016
boolean ib_add_ids  = false   //maha 09.05.2017
string is_app_type = 'I'
string is_plan_id   //maha 09.05.2017
pfc_cst_nv_data_entry_functions inv_def  //maha 04.30.2014
n_cst_workflow_triggers    inv_trigger  //maha 12.06.2016
str_action_item	istr_action[]    //maha 12.06.2016


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
n_ds ids_dept
n_ds ids_tracking
n_ds ids_ids  //maha 09.05.2017

end variables

forward prototypes
public function integer of_batch_add ()
public function integer of_add_net_dev_ai (integer ai_app_id, string as_app_type, long al_prac_id, integer ai_facility_id)
public function integer of_add_committees (long al_prac_id, integer ai_facility_id, long al_rec_id)
public function integer of_add_committees_arr (long al_prac_id[], integer ai_facility_id[], long al_rec_id[])
public function integer of_hospital_link_arr (long al_prac_id[], integer ai_facility_id[])
public function integer of_specialty_link_arr (long al_prac_id[], integer ai_facility_id[])
public function integer of_add_net_dev_ai_arr (string as_app_type, long al_prac_id[], integer ai_facility_id)
public function integer of_specialty_link_for_pt (long al_prac_id, integer ai_facility_id)
public function integer of_hospital_link_for_pt (long al_prac_id, integer ai_facility_id)
public function integer of_add_address_link_for_pt (long al_prac_id, integer ai_facility_id)
public function integer of_add_committees_for_pt (long al_prac_id, integer ai_facility_id, long al_rec_id)
public function integer of_hospital_link (long al_prac_id, integer ai_facility_id)
public function integer of_specialty_link (long al_prac_id, integer ai_facility_id)
public function integer of_set_rbs (string as_from)
public function integer of_print_apps ()
public function integer of_add_department (long al_rec, long al_prac, long al_facil)
public function integer of_batch_add_apps (long ai_facility_id[])
public function integer of_get_locations ()
public function integer of_set_trackids (integer ai_row)
public function integer of_trigger_wf ()
public function integer of_add_net_dev_ai_for_pt (long ai_app_id, string as_app_name, string as_app_type, long al_prac_id, long ai_facility_id, long al_rec_id, long al_action_type, long al_action_status, long al_loc)
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

//li_app_rc = dw_1.RowCount( )
li_fc = upperbound(ii_facility_id[] )
il_facility_cnt = li_fc


of_batch_add_apps( ii_facility_id[] )



Return 1


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
				//------------------- APPEON BEGIN -------------------
				//$<Modify> Michael 08.18.2011
				//$<reason> V11.3 Action Item Dates
				//lds_save.setitem(ll_rowsave,"action_date",ldt_action_date)
				if cbx_done.checked then
					lds_save.setitem(ll_rowsave,"action_date",ldt_action_date)	
				end if
				//------------------- APPEON END ---------------------
				lds_save.setitem(ll_rowsave,"action_dept",ll_action_dept)
				lds_save.setitem(ll_rowsave,"action_user",gs_user_id)
				lds_save.setitem(ll_rowsave,"next_action_date",ldt_null)
				lds_save.setitem(ll_rowsave,"notes",ls_action_notes)
				lds_save.setitem(ll_rowsave,"action_status",ll_action_status)
				lds_save.setitem(ll_rowsave,"facility_id",ai_facility_id)
				lds_save.setitem(ll_rowsave,"app_id",ai_app_id)
				lds_save.setitem(ll_rowsave,"app_type",as_app_type)
				lds_save.setitem(ll_rowsave,"active_status",1)
				//------------------- APPEON BEGIN -------------------
				//$<add> Michael 06.23.2011
				//$<reason> V11.3 Action Item Dates
				lds_save.setitem(ll_rowsave,"create_date",datetime(today(),now()))
				lds_save.setitem(ll_rowsave,"create_user",gs_user_id)
				//------------------- APPEON END ---------------------
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

//this function is not called

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
			//------------------- APPEON BEGIN -------------------
			//$<Modify> Michael 08.18.2011
			//$<reason> V11.3 Action Item Dates
			//lds_save.setitem(ll_rowsave,"action_date",ldt_action_date)
			if cbx_done.checked then
				lds_save.setitem(ll_rowsave,"action_date",ldt_action_date)
			end if
			//------------------- APPEON END ---------------------
			lds_save.setitem(ll_rowsave,"action_dept",ll_action_dept)
			lds_save.setitem(ll_rowsave,"action_user",gs_user_id)
			lds_save.setitem(ll_rowsave,"next_action_date",ldt_null)
			lds_save.setitem(ll_rowsave,"notes",ls_action_notes)
			lds_save.setitem(ll_rowsave,"action_status",ll_action_status)
			lds_save.setitem(ll_rowsave,"facility_id",ai_facility_id)
			lds_save.setitem(ll_rowsave,"app_id",li_app_id)
			lds_save.setitem(ll_rowsave,"app_type",as_app_type)
			lds_save.setitem(ll_rowsave,"active_status",1)
			//------------------- APPEON BEGIN -------------------
			//$<add> Michael 06.23.2011
			//$<reason> V11.3 Action Item Dates
			lds_save.setitem(ll_rowsave,"create_date",datetime(today(),now()))
			lds_save.setitem(ll_rowsave,"create_user",gs_user_id)
			//------------------- APPEON END ---------------------
			
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
long facil[]  //maha 05.21.2014

//Start Code Change ----.2014 #V14.2 maha
facil[1] = ai_facility_id
ids_cred_comms.retrieve(facil)

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

public function integer of_set_rbs (string as_from);choose case as_from
	case "P"
		cb_prac.visible = false
		cb_batch.visible = false
		cb_view.visible = false
		//st_pracs.visible = false
		rb_apps.checked = true
		rb_facility.checked = false
		rb_print.checked = false
	case "F"
		cb_prac.visible = false
		cb_batch.visible = false
		cb_view.visible = false
		//st_pracs.visible = false
		rb_apps.checked = false
		rb_facility.checked = true
		rb_print.checked =false	
		//w_batch_add_apps_facilities.height = 1475 //1200  //Start Code Change ----03.29.2016 #V15 maha - removed
	case "B"
		cb_prac.visible = true
		cb_batch.visible = true
		cb_view.visible = true
		//st_pracs.visible = true	
		rb_apps.checked = true
		rb_facility.checked = false
		//rb_apps.checked = false
		//rb_facility.checked = true
		rb_print.checked = false	
end choose

if gs_cust_type = "I" then
	CHOOSE CASE gi_intelliapp_type
			//SINGLE GROUP
		CASE 0
			rb_facility.text = "Payor / Hospitals only"
			rb_apps.text = "Payors and Applications"
			dw_all_facilities.title = "Select Payor / Hospitals"
			is_fac_error = "Payor / Hospitals"
			//MULTI SITE GROUP
		CASE 1
			rb_facility.text = "Groups only"
			rb_apps.text = "Groups and Applications"
			dw_all_facilities.title = "Select Groups"
			is_fac_error = "Groups"
		CASE 2
			rb_facility.text = "Clients only"
			rb_apps.text = "Clients and Applications"
			dw_all_facilities.title = "Select Clients"
			is_fac_error = "Clients"
	END CHOOSE
	
	//Start Code Change ----04.30.2014 #V14.2 maha
	cbx_items.checked = false
	cbx_items.visible = false
	//End Code Change ----04.30.2014
else
	is_fac_error = "Facilities"
end if



return 1
end function

public function integer of_print_apps ();integer f
integer a
integer l //Added by Appeon long.zhang 09.22.2014
Integer li_app_rc
Long li_app_cnt = 0
Long li_pc
long p
long cnt
long pid
Long ll_loc[] //Added by Appeon long.zhang 09.22.2014
Long ll_state //Added by Appeon long.zhang 09.22.2014
string pn
String ls_state //Added by Appeon long.zhang 09.22.2014

dw_1.AcceptText()

//find out the number of pracs selected
li_pc = upperbound( il_prac_ids[] ) 
li_app_rc = dw_1.RowCount( )

//Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
ll_loc[] = il_loc_id[]
if upperbound(ll_loc) = 0 then
	ll_loc[1] = 0
	is_loc_state[1] = ''
end if

for p = 1 to li_pc
	for f = 1 to upperbound(ii_facility_id )
		
		ls_state = is_fac_state[f] //Added by Appeon long.zhang 09.22.2014
		
		for l = 1 to upperbound(ll_loc) //Loop of loc_id added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)	
			
			if not( isnull(is_loc_state[l]) or trim(is_loc_state[l]) = '' ) then ls_state = is_loc_state[l]  //Added by Appeon long.zhang 09.22.2014

			for a = 1 TO li_app_rc
				IF dw_1.GetItemNumber( a, "selected" ) = 1 THEN
					cnt++
					pid = il_prac_ids[p]
					ist_search.li_prac_id[cnt]  = pid
					pn = is_prac_names[p]
					ist_search.ls_name[cnt] = pn
					ist_search.ll_app[cnt] = dw_1.GetItemNumber( a, "app_id" )
					ist_search.ll_facility[cnt] = ii_facility_id[f]
					
					//------------------- APPEON BEGIN -------------------
					//<$>added:long.zhang 09.22.2014
					//<$>reason:V14.2 Testing Bug # 4229 - In Batch add the print now option is not working
					ist_search.ll_loc_id[cnt] = ll_loc[l]
					if  not( isnull(ls_state) or trim(ls_state) = '' ) then
						ll_state = Long(gnv_data.of_getitem("code_lookup","lookup_code", "lookup_name = 'State' and code = '"+ls_state+"'")) 
						ist_search.ll_state[cnt] = ll_state
					else
						ist_search.ll_state[cnt] = 0
					end if
					//------------------- APPEON END -------------------
					
				end if
			next
		next
	next
next

openwithparm(w_intelliapp_print,ist_search)
w_intelliapp_print.lst_search = ist_search
w_intelliapp_print.of_print_now()

//close(w_batch_add_new_app)
//close(this)
return 1
end function

public function integer of_add_department (long al_rec, long al_prac, long al_facil);long ll_dept
long nr
gs_variable_array gst_ids

gst_ids.as_number[1] = al_rec
gst_ids.as_number[2] = al_prac
gst_ids.as_number[3] = al_facil

openwithparm(w_dept_select_batch_add,gst_ids)

ll_dept = message.doubleparm

if ll_dept = -1  then //cancel
	return -1
end if

nr = ids_dept.insertrow(0)

ids_dept.setitem(nr,"rec_id",al_rec)
ids_dept.setitem(nr,"prac_id",al_prac)
ids_dept.setitem(nr,"facility_id", al_facil)
ids_dept.setitem(nr,"seq_no",1)
ids_dept.setitem(nr,"department", ll_dept)
ids_dept.setitem(nr,"primary_dept", 1)
ids_dept.setitem(nr,"active_status", 1)

return 1
end function

public function integer of_batch_add_apps (long ai_facility_id[]);Long ll_count
Long ll_prac_id
Long ll_rec_id
long nr //maha 04.09.2012
long	ll_action_type
long	ll_action_status
Long p
long l //maha 04.07.2014
Long li_pc
Long ll_insertrow
long ll_track_id  //maha 08.04.2011
long ll_loc[]  //maha 04.07.2014
long ll_null  //maha 04.07.2014
long li_app_cnt
long li_tick
long li_app_id[]
long li_app_rc
long i
long rc  //maha 09.05.2017
long a //maha 04.09.2012
long li_parent_facility_id[]
long li_app_audit_facility
long ll_loopcount  //maha
integer res  //maha 08.04.2011
integer li_set85
long li_ver_facility
long	iarray
long 	li_findrow
long ll_batch_id
long li_wf_cnt  //maha 12.02.2016
string ls_note  //maha 08.26.2010
string ls_user //02.01.2012
string ls_filter  //maha  04.09.2012
string ls_fail_mess //maha 10.20.2014
string s //maha 10.27.2014
string ls_app_name[]
boolean lb_fail = false
datastore 	lds_pd_affil_stat
datastore	lds_save_for_pt
pfc_cst_nv_data_entry_functions lpfc_de
datastore	lds_facility

lpfc_de = CREATE pfc_cst_nv_data_entry_functions

li_parent_facility_id[] = ai_facility_id

lds_facility = create datastore
lds_facility.dataobject = 'd_facility_for_pt'
lds_facility.settransobject( sqlca)
lds_facility.retrieve( li_parent_facility_id[])

//Start Code Change ----09.05.2017 #V154 maha - for adding ids records
ids_ids = Create n_ds //moved from below, by Appeon long.zhang 09.08.2017
if cbx_add_ids.checked then
	ib_add_ids = true
	//ids_ids = Create n_ds
	ids_ids.dataobject = "d_net_dev_ids"
	ids_ids.settransobject(sqlca)
	dw_ids.accepttext()
	il_plan_type = dw_ids.getitemnumber(1, "plan_type")
	is_plan_id = dw_ids.getitemstring(1, "plan_assigned_id")
end if
//End Code Change ----09.05.2017 

dw_1.AcceptText( )
//find out the number of pracs selected
li_pc = upperbound( il_prac_ids[] ) 

//how many apps 
li_app_rc = upperbound(ii_app_id)  //Start Code Change ----05.22.2014 #V14.2 maha

//Start Code Change ----05.22.2014 #V14.2 maha - passed array
//FOR i = 1 TO li_app_rc
//	li_app_id[i] = dw_1.GetItemNumber( i, "app_id" )
//END FOR
li_app_id[] = ii_app_id[]
//End Code Change ----05.22.2014

ls_app_name[] = is_app_name[] //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
if upperbound(li_app_id) = 0 then
	li_app_id[1] = 0
end if
//Start Code Change ----10.20.2014 #V14.2 maha - moved from further below 

//how many locations
ll_loc[] = il_loc_id[]

if upperbound(ll_loc) > 0 then //add locations count to loop total for rec_id generation
	ll_loopcount = li_pc * li_app_rc * upperbound(ll_loc)  
else
	//ll_loopcount = li_pc * li_app_rc
	If li_app_rc = 0 Then //add If condition, by Appeon long.zhang 11.18.2016 (Batch add Application not working Case#67767 Bug_id#5419)
		ll_loopcount = li_pc
	Else
		ll_loopcount = li_pc * li_app_rc
	End If
	
	ll_loc[1] = 0  //Start Code Change ----05.19.2014 #V14.2 maha - from null
end if
//---------Begin Added by (Appeon)Harry 10.29.2014 for BugH091801--------
if upperbound (li_parent_facility_id[]  ) > 0 then
	ll_loopcount = ll_loopcount * upperbound (li_parent_facility_id[]  ) + upperbound (li_parent_facility_id[]  )
end if
//---------End Added ------------------------------------------------------

//ll_rec_id = gnv_app.of_Get_Id("RECORD_ID", li_pc * li_app_rc) - 1
ll_rec_id = gnv_app.of_Get_Id("RECORD_ID", ll_loopcount) - 1  //get record ids

//Start Code Change ----07.22.2010 #V10 maha - allowing for user selected action type
//ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
ll_action_type = il_action_type        //dw_type.getitemnumber(1,"lookup_code")
//End Code Change ----07.22.2010 #V10

if cbx_done.checked then //Start Code Change ----08.28.2010 #V10 maha - allow to complete as created
	ll_action_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Complete') + "'"))	
else
	ll_action_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Incomplete') + "'"))
end if

//Modified by (appeon) Harry 10.16.2017
/*
 //Start Code Change ----12.06.2016 #V153 maha - set base value for missing track ids
select max(track_id) into : il_trackid_4_add from pd_appl_tracking; 
if isnull( il_trackid_4_add) then  il_trackid_4_add = 0
 //Start Code Change ----12.06.2016 
*/
if rb_apps.checked then
	il_trackid_4_add =  gnv_app.of_get_id("track_id",  li_pc * upperbound(li_parent_facility_id) * upperbound(ll_loc) * li_app_rc) - 1
end if

//create datastores
lds_save_for_pt = create datastore
lds_save_for_pt.dataobject = 'd_pd_affil_stat_save_for_pt'
lds_save_for_pt.settransobject( sqlca)

lds_pd_affil_stat = create datastore
lds_pd_affil_stat.dataobject = 'd_pd_affil_stat_for_pt'
lds_pd_affil_stat.settransobject( sqlca)

ids_save = Create datastore
//---------Begin Modified by (Appeon)Stephen 07.21.2017 for Critical performance issue with workflow action completion--------
/*ids_save.DataObject = "d_appeon_net_dev_action_items_save"
*/
ids_save.DataObject = "d_audit_net_dev_action_items_save"
//---------End Modfiied ------------------------------------------------------
ids_save.SetTransObject(SQLCA)

ids_d_net_dev_action_items = Create datastore
ids_d_net_dev_action_items.DataObject = "d_net_dev_action_items_for_pt"
ids_d_net_dev_action_items.SetTransObject(SQLCA)


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

//Start Code Change ----08.04.2011 #V11 maha 
ids_dept = CREATE n_ds
ids_dept.DataObject = "d_pd_affil_departments" 
ids_dept.of_SetTransObject( SQLCA )
//Start Code Change ----08.04.2011

//Start Code Change ----04.09.2012 #V12 maha
ids_tracking = CREATE n_ds
ids_tracking.DataObject = "d_appl_tracking_for_batch_add" 
ids_tracking.of_SetTransObject( SQLCA )
//End Code Change ----04.09.2012


gnv_appeondb.of_startqueue( )

lds_pd_affil_stat.retrieve(il_prac_ids, li_parent_facility_id)
ids_d_net_dev_action_items.retrieve( il_prac_ids,li_parent_facility_id[],li_app_id,ll_action_type,ll_action_status)
ids_all_addresses.Retrieve( il_prac_ids )
ids_pd_address_link.retrieve(il_prac_ids,li_parent_facility_id[])
ids_hosp_link.Retrieve( il_prac_ids )
ids_all_hosp.Retrieve( il_prac_ids )
ids_spec_link.Retrieve( il_prac_ids )
ids_all_spec.Retrieve( il_prac_ids )
//ids_cred_comms.Retrieve( li_parent_facility_id)  //Start Code Change ----05.21.2014 #V14.2 maha - retrieval moved to committee creation function
ids_tracking.retrieve( il_prac_ids,li_parent_facility_id[],li_app_id)


gnv_appeondb.of_commitqueue( )

//Start Code Change ----12.07.2016 #V153 maha
if rb_apps.checked then //create app status records
	if gb_workflow and cbx_done.checked  Then
		select count(wf_id) into :li_wf_cnt from wf_workflow where wf_module = '02';
		if li_wf_cnt > 0 then
			select wf_id into :li_wf_cnt from wf_trigger_param_action_status where action_type_id = :ll_action_type;
			if li_wf_cnt > 0 then 
				ib_do_wf = true
				il_wf_id = li_wf_cnt
				select top 1 step_id into :il_wf_step_id from wf_action_types where wf_id = :il_wf_id order by step_order asc;
			else
				ib_do_wf = false
			end if
		end if
	end if
end if
//End Code Change ----12.07.2016


//loop through and add facility and net dev ai for each prac
FOR p = 1 TO li_pc
	il_ai_cnt++
	st_pracs.Text = "Creating action items " + String( il_ai_cnt ) + " of " + String( il_ai_rc )
	//FACILITY
	//add data to appointment status screen
	//ll_rec_id ++  //Move down by Ken.Guo 09.02.2008
	ll_prac_id = il_prac_ids[p]
	for iarray = 1 to upperbound(li_parent_facility_id)
		ls_user =  'PUBLIC'  //Start Code Change ----02.01.2012 #V12 maha
		ll_count = lds_pd_affil_stat.find('prac_id = ' + string(ll_prac_id) + ' and parent_facility_id = ' + string(li_parent_facility_id[iarray]), 1, lds_pd_affil_stat.rowcount( ))
		IF ll_count = 0 THEN
			IF gs_cust_type = "I" THEN
				li_app_audit_facility = 1   
				li_ver_facility = 1
			ELSE
				li_findrow = lds_facility.find( 'facility_id = '+string(li_parent_facility_id[iarray]), 1, lds_facility.rowcount())
				if li_findrow > 0 then
					li_app_audit_facility = lds_facility.object.default_audit_temp[li_findrow]
					li_ver_facility = lds_facility.object.default_verif_facility[li_findrow]
					if lds_facility.object.default_user[li_findrow] = 1 then ls_user = gs_user_id  //Start Code Change ----02.01.2012 #V12 maha
				end if
			END IF

			if isnull(li_app_audit_facility) then li_app_audit_facility = 1
			if isnull(li_ver_facility) then li_ver_facility = 1
			ll_rec_id ++  //Added by Ken.Guo 09.02.2008
			//appointment record
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
			lds_save_for_pt.object.priority_user[ll_insertrow] = ls_user  //'PUBLIC'  //Start Code Change ----02.01.2012 #V12 maha
			lds_save_for_pt.object.affiliation_status[ll_insertrow] = 'M'
			
			of_add_address_link_for_pt( ll_prac_id, li_parent_facility_id[iarray] )
			of_hospital_link_for_pt( ll_prac_id, li_parent_facility_id[iarray] )
			of_specialty_link_for_pt(ll_prac_id, li_parent_facility_id[iarray] )
			of_add_committees_for_pt( ll_prac_id, li_parent_facility_id[iarray], ll_rec_id )
			//Start Code Change ----08.04.2011 #V11 maha - department security - add department
			if of_get_app_setting("set_37","I") = 1 then
				res = of_add_department(ll_rec_id, ll_prac_id,li_parent_facility_id[iarray] )
				if res = -1 then 
					st_pracs.Text = "Canceled"
					return -1
				end if
			end if
			//End Code Change ----08.04.2011
		
			//Start Code Change ----04.30.2014 #V14.2 maha
			//Checklist
			if cbx_items.checked then
				inv_def.of_app_audit_items_add(li_parent_facility_id[iarray], ll_prac_id, ll_rec_id,  li_app_audit_facility , "DE", dw_1 , "I") //note: dw_1 is passed because it is required by the funciotn, but is not used in this iteration
			end if
			//End Code Change ----04.30.2014	
			
		END IF
	
		if rb_apps.checked then //create app status records
			 //Start Code Change ----04.07.2014 #V14.2 maha		
			for l = 1 to upperbound(ll_loc) 
				FOR i = 1 TO li_app_rc
//					IF dw_1.GetItemNumber( i, "selected" ) = 0 THEN  //Start Code Change ----05.22.2014 #V14.2 maha - no longer needed
//						CONTINUE
//					END IF
		
					ll_rec_id ++	
					//create the action item
					//of_add_net_dev_ai_for_pt( li_app_id[i], "I", il_prac_ids[ p ], li_parent_facility_id[iarray] ,ll_rec_id, ll_action_type, ll_action_status, ll_loc[l])
					of_add_net_dev_ai_for_pt( li_app_id[i], is_app_name[i], is_app_type, il_prac_ids[ p ], li_parent_facility_id[iarray] ,ll_rec_id, ll_action_type, ll_action_status, ll_loc[l])  //(Appeon)Stephen 07.21.2017 - add "is_app_name"---Critical performance issue with workflow action completion //Start Code Change ----02.12.2015 #V15 maha - changed to variable
				END FOR
			next
			//End Code Change ----04.07.2014
		end if
		//End Code Change---01.17.2006

	next
END FOR

//Start Code Change ----12.06.2016 #V153 maha - moved track id setting to of_add_net_dev_ai_for_pt 
////Start Code Change ----04.09.2012 #V12 maha - check tracking records track id
//select max(track_id) into :ll_track_id from pd_appl_tracking;
//if isnull(ll_track_id) then ll_track_id = 0
//
////records created in of_add_net_dev_ai_for_pt function
//FOR p = 1 TO ids_tracking.rowcount()
//	if isnull (ids_tracking.getitemnumber(p,"track_id")) then
//		ll_track_id++
//		ids_tracking.setitem(p,"track_id",ll_track_id)
//	end if
//next
//
//FOR p = 1 TO ids_tracking.rowcount()
//	of_set_trackids( p)
//next
////End Code Change ----04.09.2012
//End Code Change ----12.06.2016

//Start Code Change ----09.05.2017 #V154 maha - set recids on ids records
rc =  ids_ids.rowcount()
if ib_add_ids and rc > 0 then
	ll_rec_id = gnv_app.of_Get_Id("RECORD_ID", rc) - 1
	for i = 1 to rc
		ll_rec_id++
		ids_ids.setitem(i, "rec_id", ll_rec_id)
	next
end if
//End Code Change ----09.05.2017

inv_def.of_field_audit( lds_save_for_pt , s)  //Start Code Change ----10.27.2014 #V14.2 maha - create audit record.



//---------Begin Added by (Appeon)Stephen 06.03.2016 for V15.2-Application Tracking full Auditing--------
//inv_def.of_field_audit( ids_save , s) //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
li_set85 = of_get_app_setting("set_85","I")
if li_set85 = 2 then
	select max(batch_id) into :ll_batch_id from sys_audit_appl using sqlca;
	if isnull(ll_batch_id) then ll_batch_id = 0
	ll_batch_id = ll_batch_id +1
	ids_save.accepttext()
	ids_tracking.accepttext()
	inv_def.of_applfield_audit(ids_save, s, true, ll_batch_id)
	inv_def.of_applfield_audit(ids_tracking, s, true, ll_batch_id)
	inv_def.of_field_audit( ids_ids , s)   //Start Code Change ----09.05.2017 #V154 maha
else
	inv_def.of_field_audit( ids_save , s)
end if
//---------End Added ------------------------------------------------------

gnv_appeondb.of_startqueue( )

//Start Code Change ----10.20.2014 #V14.2 maha - added message code
res = lds_save_for_pt.update()
if res < 0 then
	lb_fail = true
	ls_fail_mess = "save for appointments - "
end if
res = ids_save.Update()
if res < 0 then 
	lb_fail = true
	ls_fail_mess+= "save for action items - "
end if
res = ids_address_link.Update()
if res < 0 then 
	lb_fail = true
	ls_fail_mess+= "save for addr_link - "
end if
res = ids_hosp_link.Update()
if res < 0 then 
	lb_fail = true
	ls_fail_mess+= "save for hosp_link - "
end if
res = ids_spec_link.Update()
if res < 0 then 
	lb_fail = true
	ls_fail_mess+= "save for spec_link - "
end if
res = ids_cred_committees.Update( )
if res < 0 then
	lb_fail = true
	ls_fail_mess+= "save for cred committee - "
end if
res = ids_dept.Update( )
if res < 0 then
	lb_fail = true
	ls_fail_mess+= "save for dept - "
end if
res = ids_tracking.Update( )
if res < 0 then 
	lb_fail = true
	ls_fail_mess+= "save for tracking - "
end if

res = ids_ids.update()  //Start Code Change ----09.05.2017 #V154 maha
if res < 0 then
	lb_fail = true
	ls_fail_mess+= "save for IDs - "
end if
	

if lb_fail = true then messagebox("Update failure" ,"Complete update failed: " + ls_fail_mess)
//End Code Change ----10.20.2014

gnv_appeondb.of_commitqueue( ) //Moved from below by Appeon long.zhang 02.06.2017 (WF issues on Application tab bugid#5480)

//Start Code Change ----12.07.2016 #V153 maha
if ib_do_wf then
	of_trigger_wf()
end if
//End Code Change ----12.07.2016

//gnv_appeondb.of_commitqueue( )//Comment by Appeon long.zhang 02.06.2017 (WF issues on Application tab bugid#5480)

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
DESTROY ids_dept
DESTROY ids_tracking
Destroy ids_ids  //Start Code Change ----09.05.2017 #V154 maha

st_pracs.visible = true
st_pracs.Text = "Complete"

DESTROY lpfc_de

Return 1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_get_locations ();//Start Code Change ----04.22.2014 #V14.2 maha
long rc
long r
long ll_ids[]

for r = 1 to dw_all_facilities.rowcount()
	if dw_all_facilities.getitemnumber(r, "selected") = 1 then
		ll_ids[upperbound(ll_ids[]) + 1] = dw_all_facilities.getitemnumber(r, "facility_id")
	end if
next

if dw_locations.dataobject = "d_group_prac_select_batch_prac" then
	//nada
else
	if upperbound(ll_ids) > 0 then
		dw_locations.retrieve(ll_ids)
	end if
end if
		
return 1

end function

public function integer of_set_trackids (integer ai_row);//Start Code Change ----06.29.2016 #V152 maha - added for setting the action record tracking ids
long p
long r
long rc
long ll_prac
long ll_facil
long ll_app
long ll_loc
long ll_track
long f
string ls_filter

p = ai_row

ll_track = ids_tracking.getitemnumber(p,"track_id")
ll_prac = ids_tracking.getitemnumber(p,"prac_id")
ll_app = ids_tracking.getitemnumber(p,"app_id")
ll_facil = ids_tracking.getitemnumber(p,"facility_id")
ll_loc = ids_tracking.getitemnumber(p,"gp_id")

if isnull(ll_loc) then ll_loc = 0

ls_filter = 'prac_id = ' + string(ll_prac) + ' and facility_id = ' + string(ll_facil) + ' and app_id = '+string(ll_app) +  ' and gp_id =' + string(ll_loc)

//look for actions
f = ids_save.setfilter(ls_filter)
if f < 0 then messagebox("filter error in of_set_trackids", ls_filter )
ids_save.filter()

rc = ids_save.rowcount()

for r = 1 to rc
	ids_save.setitem(r, "track_id", ll_track )
next

f = ids_save.setfilter("")
ids_save.filter()

return 1
end function

public function integer of_trigger_wf ();//Start Code Change ----12.06.2016 #V153 maha
long ll_i,ll_count
n_cst_workflow_triggers    lnv_trigger
str_action_item lstr_action

If not gb_workflow Then return 1
lnv_trigger = create n_cst_workflow_triggers
debugbreak()
ll_count = UpperBound(istr_action)
//debugbreak()
For ll_i = 1 to ll_count
	lstr_action = istr_action[ll_i]
	if istr_action[ll_i].status_changed_flag then
		lnv_trigger.of_status_changed( lstr_action)
	end if
Next

//Create Work Flow By Action Item Changed
lnv_trigger.of_workflow_triggers(istr_action)   

destroy lnv_trigger

return 1
end function

public function integer of_add_net_dev_ai_for_pt (long ai_app_id, string as_app_name, string as_app_type, long al_prac_id, long ai_facility_id, long al_rec_id, long al_action_type, long al_action_status, long al_loc);
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.24.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Rewrite the original of_add_net_dev_ai to provide the same functionality.
//$<modification> The modification reduces client-server interactions.
//Modification note -12.06.2016 #V153 maha - modified the setting of the track_id so that it all takes place in this function

boolean lb_add_track = false  //maha 12.06.2016
Long ll_action_type
Long ll_action_status
Long ll_action_dept
long ll_action_par  //maha 07.31.2015
long nr //maha 04.09.2012
long ll_loc  //maha 05.22.2014
long ll_rec_id //stephen 04.11.2016
long ll_action_next
long ll_seq  //maha 12.06.2016
long ll_trackid  //maha 12.06.2016
Integer li_ai_cnt = 0
integer li_days  //maha 07.31.2014
integer res  //maha 05.02.2016
integer li_wf_cnt  //maha 12.02.2016
long ll_count //maha 04.09.2012
String ls_action_notes
string ls_find
DateTime ldt_action_date
date ld_due


ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
ll_action_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Incomplete') + "'"))
ll_action_dept = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Department') + "'" + " and upper(code) = '" + upper('Credentialing') + "'"))
ll_action_par = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('PAR') + "'"))   //Start Code Change ----07.31.2015 #V15 maha
					
//check to see if ai allready exists	for App out to MD
if ll_action_type = al_action_type then   //Start Code Change ----08.26.2010 #V10 maha - only check for app out to MD
	//li_ai_cnt = ids_d_net_dev_action_items.find('prac_id = '+string(al_prac_id)+' and facility_id = '+string(ai_facility_id)+' and app_id = '+string(ai_app_id)+&
	//li_ai_cnt = ids_d_net_dev_action_items.find('prac_id = '+string(al_prac_id)+' and facility_id = '+string(ai_facility_id)+' and app_id = '+string(ai_app_id) + ' and app_id = '+string(al_loc) +&  //Commented by (Appeon)Harry 10.29.2014 - for BugH091801
	li_ai_cnt = ids_d_net_dev_action_items.find('prac_id = '+string(al_prac_id)+' and facility_id = '+string(ai_facility_id)+' and app_id = '+string(ai_app_id) + ' and gp_id = '+string(al_loc) +&
	' and action_type = ' + string(ll_action_type) + ' AND active_status = 1 AND action_status = ' + string(ll_action_status), 1, ids_d_net_dev_action_items.rowcount())
end if

ll_loc = al_loc
if isnull(ll_loc) then ll_loc = 0  //Start Code Change ----05.22.2014 #V14.2 maha - moved

If li_ai_cnt = 0 Then
	
	//Start Code Change ----12.06.2016 #V153 maha
	ls_find = 'prac_id = ' + string(al_prac_id) + ' and facility_id = ' + string(ai_facility_id) + ' and app_id = '+string(ai_app_id) +  ' and gp_id =' + string(ll_loc)
	ll_count = ids_tracking.find( ls_find, 1 , ids_tracking.rowcount() )  //look for tracking record

	if ll_count < 0 then
		messagebox("App Tracking Record","Failure to find in of_add_net_dev_for_pt.  Contact ISG support.")
		return -1
	elseif ll_count > 0 then
		ll_trackid =  ids_tracking.getitemnumber(ll_count,"track_id")
	else
		il_trackid_4_add++
		ll_trackid = il_trackid_4_add
		lb_add_track = true
	end if
	//End Code Change ----12.06.2016
	
	//ls_action_notes = ""
	ls_action_notes = sle_note.text   //Start Code Change ----08.26.2010 #V10 maha - set note value on action
	ldt_action_date = DateTime( Today(), Now() )
	
	Long ll_rowsave
	Date ldt_null
	
	//ACTIONS
	ll_rowsave = ids_save.InsertRow(0)
	setnull(ldt_null)  //(Appeon)Stephen 11.09.2017 - V15.3 Bug # 5876 - Net Dev Action Items is populating Next Action Date as 1/1/1900
	ids_save.SetItem(ll_rowsave,"rec_id",al_rec_id)
	ids_save.SetItem(ll_rowsave,"prac_id",al_prac_id)
	ids_save.SetItem(ll_rowsave,"seq_no",al_rec_id)
	ids_save.SetItem(ll_rowsave,"action_type",al_action_type)
	//------------------- APPEON BEGIN -------------------
	//$<Modify> Michael 08.18.2011
	//$<reason> V11.3 Action Item Dates
	//ids_save.SetItem(ll_rowsave,"action_date",ldt_action_date)
	if cbx_done.checked then
		ids_save.SetItem(ll_rowsave,"action_date",ldt_action_date)
	end if
	//------------------- APPEON END ---------------------
	ids_save.SetItem(ll_rowsave,"action_dept",ll_action_dept)
	//ids_save.SetItem(ll_rowsave,"action_user",gs_user_id)
	ids_save.SetItem(ll_rowsave,"action_user",is_user)  //Start Code Change ----06.18.2014 #V14.2 maha - changed variable
	ids_save.SetItem(ll_rowsave,"next_action_date",ldt_null)
	ids_save.SetItem(ll_rowsave,"notes",ls_action_notes)
	ids_save.SetItem(ll_rowsave,"action_status",al_action_status)
	ids_save.SetItem(ll_rowsave,"facility_id",ai_facility_id)
	ids_save.SetItem(ll_rowsave,"app_id",ai_app_id)
	ids_save.SetItem(ll_rowsave,"app_hdr_application_name",as_app_name) //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
	ids_save.SetItem(ll_rowsave,"app_type",as_app_type)
	ids_save.SetItem(ll_rowsave,"active_status",1)
	ids_save.SetItem(ll_rowsave,"gp_id",ll_loc)  //Start Code Change ----04.07.2014 #V14.2 maha
	ids_save.SetItem(ll_rowsave,"track_id",ll_trackid ) //Start Code Change ----12.09.2016 #V153 maha
	if il_dept > 0 then ids_save.SetItem(ll_rowsave,"action_dept",il_dept)   //Start Code Change ----02.12.2015 #V15 maha		
	
	//------------------- APPEON BEGIN -------------------
	//Start Code Change ----07.31.2014 #V14.2 maha - set due days
	li_days = integer(gnv_data.of_getitem("app_steps","next days","lookup_code = " + string(al_action_type))) //gets the due days 
	if li_days > 0 then
		
		ld_due = relativedate(today(), li_days)
		ids_save.SetItem(ll_rowsave,"due_date",datetime(ld_due, time('00:00:00')))
	end if
	//$<add> Michael 06.23.2011
	//$<reason> V11.3 Action Item Dates
	ids_save.setitem(ll_rowsave,"create_date",datetime(today(),now()))
	ids_save.setitem(ll_rowsave,"create_user",gs_user_id)
	//------------------- APPEON END ---------------------
	

	
	//---------Begin Added by (Appeon)Stephen 04.11.2016 for Bug ID #5097 for Case # 00062811: Application Action Items --------
	if cbx_done.checked then
		ll_action_next = f_next_appl_tracker(al_action_type)
		
		if ll_action_next > 0 then 
			//Start Code Change ----05.02.2016 #V15 maha - added message
			if ib_ask then
				res = messagebox("Application Tracking","Since you are completing the added actions, do you wish to add the next process step?", question!, yesno!,1)
				if res = 1 then ib_add_next = true
				ib_ask = false
			end if
			
			//NEXT Action
			if ib_add_next = true then  
				ll_rowsave = ids_save.InsertRow(0)
				ll_rec_id = gnv_app.of_Get_Id("RECORD_ID", 1)
				ids_save.SetItem(ll_rowsave,"rec_id",ll_rec_id)
				ids_save.SetItem(ll_rowsave,"prac_id",al_prac_id)
				ids_save.SetItem(ll_rowsave,"seq_no",ll_rec_id)
				ids_save.SetItem(ll_rowsave,"action_type", ll_action_next)
				li_days = integer(gnv_data.of_getitem("app_steps","next days","lookup_code = " + string(ll_action_next))) //gets the due days 
				if li_days > 0 then
					ld_due = relativedate(today(), li_days)
					ids_save.SetItem(ll_rowsave,"due_date",datetime(ld_due, time('00:00:00')))
				end if
			
				ids_save.SetItem(ll_rowsave,"track_id",ll_trackid ) //Start Code Change ----12.06.2016 #V153 maha
				ids_save.SetItem(ll_rowsave,"action_dept",ll_action_dept)
				ids_save.SetItem(ll_rowsave,"action_user",is_user) 
				ids_save.SetItem(ll_rowsave,"next_action_date",ldt_null)
				//ids_save.SetItem(ll_rowsave,"notes",ls_action_notes) //Start Code Change ----05.02.2016 #V15 maha - removed
				ids_save.SetItem(ll_rowsave,"action_status",ll_action_status)
				ids_save.SetItem(ll_rowsave,"facility_id",ai_facility_id)
				ids_save.SetItem(ll_rowsave,"app_id",ai_app_id)
				ids_save.SetItem(ll_rowsave,"app_hdr_application_name",as_app_name) //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
				ids_save.SetItem(ll_rowsave,"app_type",as_app_type)
				ids_save.SetItem(ll_rowsave,"active_status",1)
				ids_save.SetItem(ll_rowsave,"gp_id",ll_loc) 
				ids_save.setitem(ll_rowsave,"create_date",datetime(today(),now()))
				ids_save.setitem(ll_rowsave,"create_user",gs_user_id)
			end if
		end if		
		
		//Start Code Change ----12.02.2016 #V153 maha
		if ib_do_wf = true then
			//messagebox("","do wf")
			debugbreak()
			ll_seq = upperbound(istr_action) + 1
			//istr_action[ll_seq].rec_id = ll_rec_id
			istr_action[ll_seq].rec_id = al_rec_id //Added by Appeon long.zhang 02.06.2017 (WF issues on Application tab bugid#5480)
			istr_action[ll_seq].prac_id = al_prac_id
			istr_action[ll_seq].facility_id = ai_facility_id
			istr_action[ll_seq].wf_id =  il_wf_id
			istr_action[ll_seq].wf_step_id = 0   // il_wf_step_id
			istr_action[ll_seq].wf_action_status_id = al_action_status
			istr_action[ll_seq].wf_action_type_id = al_action_type
			istr_action[ll_seq].module = "02"	//IntelliApp
			istr_action[ll_seq].trigger_by = "008"		//Trigger By Action Item Changed
			istr_action[ll_seq].screen_id = -10
			istr_action[ll_seq].gp_id = ll_loc  
			istr_action[ll_seq].app_id = ai_app_id 
			istr_action[ll_seq].app_name = as_app_name  //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
			istr_action[ll_seq].track_id = ll_trackid  
			istr_action[ll_seq].seq_no = ll_rec_id
			istr_action[ll_seq].status_changed_flag = true
//			istr_action[ll_seq].notes = this.GetItemString(i,"notes")
//			//---------Begin Added by (Appeon)Stephen 07.07.2015 for Action Status field displaying numeric values--------
//			ls_wf_complete_flag = this.GetItemString(i,"net_dev_action_items_wf_complete_flag")
//			if isnull(ls_wf_complete_flag) or ls_wf_complete_flag = '' then
//				ls_wf_complete_flag = 'N'
//				This.setitem(i,"net_dev_action_items_wf_complete_flag",ls_wf_complete_flag)
//			end if
//			//---------End Added ------------------------------------------------------
//			if istr_action[ll_seq].wf_id > 0 and ls_wf_complete_flag = "N" THEN				
//				istr_action[ll_seq].wf_step_id = this.GetItemNumber(i,"net_dev_action_items_wf_action_type_id")	
//			end if
//			ll_seq++
		end if
				
		end if
		//End Code Change ----12.02.2016
		

	//---------End Added ------------------------------------------------------
	
End If

//Start Code Change ----12.06.2016 #V153 maha - moved above
////Start Code Change ----04.09.2012 #V12 maha - app tracking creation
////Start Code Change ----04.07.2014 #V14.2 maha
////ls_find = 'prac_id = ' + string(al_prac_id) + ' and facility_id = ' + string(ai_facility_id) + ' and app_id = '+string(ai_app_id)
//ls_find = 'prac_id = ' + string(al_prac_id) + ' and facility_id = ' + string(ai_facility_id) + ' and app_id = '+string(ai_app_id) +  ' and gp_id =' + string(ll_loc)
////End Code Change ----04.07.2014
//
//
//ll_count = ids_tracking.find( ls_find, 1 , ids_tracking.rowcount() )  //look for tracking record
//
//if ll_count < 0 then
//	messagebox("App Tracking Record","Failure to find in of_add_net_dev_for_pt.  Contact ISG support.")
//	return -1
//end if
//Start Code Change ----12.06.2016 

//TRACKING
//Start Code Change ----12.06.2016 #V153 maha
//IF ll_count = 0 THEN //if no matching row then add tracking record
if lb_add_track = true then
//End  Code Change ----12.06.2016
	nr = ids_tracking.insertrow(0)
	//debugbreak()
	ids_tracking.setitem(nr,"prac_id",al_prac_id)
	ids_tracking.setitem(nr,"facility_id", ai_facility_id )
	ids_tracking.setitem(nr,"app_id", ai_app_id )
	ids_tracking.setitem(nr,"app_hdr_application_name", as_app_name ) //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
	ids_tracking.setitem(nr,"active_status",1)
	ids_tracking.setitem(nr,"assigned_user",is_user)         //Start Code Change ----11.23.2015 #V15 maha - changed variable  gs_user_id)
	ids_tracking.setitem(nr,"gp_id",ll_loc)
	ids_tracking.SetItem(nr,"sys_tracker_id", 1)   //Start Code Change ----12.01.2014 #V14.2 maha
	ids_tracking.SetItem(nr,"track_id", ll_trackid)  //Start Code Change ----12.06.2016 #V153 maha
	if cbx_done.checked and is_set_field<>'0' then //add by stephen 05.18.2012 --add  is_set_field<>'0'
		ids_tracking.setitem(nr, is_set_field ,today())
		if ll_action_par = al_action_type then ids_tracking.setitem(ll_count, "par_status" ,1)	 //Start Code Change ----09.14.2015 #V15 maha - corrected variable issue causing par set if complete for any type  //Start Code Change ----07.31.2015 #V15 maha
	end if
	if ib_do_wf = true then//Start Code Change ----12.19.2016 #V153 maha
		istr_action[ll_seq].track_id = ll_trackid   
	end if
else //if an existing tracking record exists and the complete box is checked, set the complete date.
	if cbx_done.checked and is_set_field<>'0' then //add by stephen 05.18.2012 --add  is_set_field<>'0'
		if isnull(ids_tracking.getitemdatetime(ll_count, is_set_field )) then
			ids_tracking.setitem(ll_count, is_set_field ,today())
		end if
		if ll_action_par = al_action_type then ids_tracking.setitem(ll_count, "par_status" ,1)	//Start Code Change ----05.04.2016 #V15 maha - moved inside the complete setting.
	end if
		 //Start Code Change ----07.31.2015 #V15 maha
		//if ll_action_par = ll_action_par then ids_tracking.setitem(ll_count, "par_status" ,1)	
		//if ll_action_par = al_action_type then ids_tracking.setitem(ll_count, "par_status" ,1)  //Start Code Change ----10.08.2015 #V15 maha - corrected variable issue causing par set if complete for any type
end if

//Start Code Change ----09.05.2017 #V154 maha
//IDS
if ib_add_ids then
	nr = ids_ids.insertrow(0)
	
	ids_ids.setitem( nr, "prac_id", al_prac_id)
	ids_ids.setitem( nr, "facility_id",  ai_facility_id)
	ids_ids.setitem( nr, "app_id", ai_app_id)
	ids_ids.setitem( nr, "address_id", ll_loc)
	ids_ids.setitem( nr, "plan_assigned_id", is_plan_id )
	ids_ids.setitem( nr, "plan_type", il_plan_type)
end if
//End Code Change ----09.05.2017

//End Code Change ----04.09.2012

Return 1

//---------------------------- APPEON END ----------------------------
end function

on w_batch_add_apps_facilities.create
int iCurrent
call super::create
this.cb_create=create cb_create
this.cb_5=create cb_5
this.dw_all_facilities=create dw_all_facilities
this.st_3=create st_3
this.st_4=create st_4
this.dw_facility_add=create dw_facility_add
this.cb_now=create cb_now
this.st_6=create st_6
this.rb_facility=create rb_facility
this.rb_apps=create rb_apps
this.rb_print=create rb_print
this.dw_type=create dw_type
this.st_1=create st_1
this.sle_note=create sle_note
this.st_2=create st_2
this.cbx_done=create cbx_done
this.st_5=create st_5
this.gb_1=create gb_1
this.gb_3=create gb_3
this.cb_prac=create cb_prac
this.cb_batch=create cb_batch
this.cb_view=create cb_view
this.st_pracs=create st_pracs
this.cb_3=create cb_3
this.dw_locations=create dw_locations
this.cbx_items=create cbx_items
this.cb_4=create cb_4
this.st_group=create st_group
this.st_loc=create st_loc
this.st_app=create st_app
this.dw_user=create dw_user
this.st_7=create st_7
this.pb_notes=create pb_notes
this.cb_filter_fac=create cb_filter_fac
this.cb_filter_loc=create cb_filter_loc
this.cb_filter_app=create cb_filter_app
this.sle_ffac=create sle_ffac
this.sle_fapp=create sle_fapp
this.sle_floc=create sle_floc
this.st_8=create st_8
this.dw_dept=create dw_dept
this.ddlb_ir=create ddlb_ir
this.st_ir=create st_ir
this.cbx_add_ids=create cbx_add_ids
this.dw_ids=create dw_ids
this.gb_prac=create gb_prac
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_create
this.Control[iCurrent+2]=this.cb_5
this.Control[iCurrent+3]=this.dw_all_facilities
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.dw_facility_add
this.Control[iCurrent+7]=this.cb_now
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.rb_facility
this.Control[iCurrent+10]=this.rb_apps
this.Control[iCurrent+11]=this.rb_print
this.Control[iCurrent+12]=this.dw_type
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.sle_note
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.cbx_done
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.cb_prac
this.Control[iCurrent+21]=this.cb_batch
this.Control[iCurrent+22]=this.cb_view
this.Control[iCurrent+23]=this.st_pracs
this.Control[iCurrent+24]=this.cb_3
this.Control[iCurrent+25]=this.dw_locations
this.Control[iCurrent+26]=this.cbx_items
this.Control[iCurrent+27]=this.cb_4
this.Control[iCurrent+28]=this.st_group
this.Control[iCurrent+29]=this.st_loc
this.Control[iCurrent+30]=this.st_app
this.Control[iCurrent+31]=this.dw_user
this.Control[iCurrent+32]=this.st_7
this.Control[iCurrent+33]=this.pb_notes
this.Control[iCurrent+34]=this.cb_filter_fac
this.Control[iCurrent+35]=this.cb_filter_loc
this.Control[iCurrent+36]=this.cb_filter_app
this.Control[iCurrent+37]=this.sle_ffac
this.Control[iCurrent+38]=this.sle_fapp
this.Control[iCurrent+39]=this.sle_floc
this.Control[iCurrent+40]=this.st_8
this.Control[iCurrent+41]=this.dw_dept
this.Control[iCurrent+42]=this.ddlb_ir
this.Control[iCurrent+43]=this.st_ir
this.Control[iCurrent+44]=this.cbx_add_ids
this.Control[iCurrent+45]=this.dw_ids
this.Control[iCurrent+46]=this.gb_prac
end on

on w_batch_add_apps_facilities.destroy
call super::destroy
destroy(this.cb_create)
destroy(this.cb_5)
destroy(this.dw_all_facilities)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_facility_add)
destroy(this.cb_now)
destroy(this.st_6)
destroy(this.rb_facility)
destroy(this.rb_apps)
destroy(this.rb_print)
destroy(this.dw_type)
destroy(this.st_1)
destroy(this.sle_note)
destroy(this.st_2)
destroy(this.cbx_done)
destroy(this.st_5)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.cb_prac)
destroy(this.cb_batch)
destroy(this.cb_view)
destroy(this.st_pracs)
destroy(this.cb_3)
destroy(this.dw_locations)
destroy(this.cbx_items)
destroy(this.cb_4)
destroy(this.st_group)
destroy(this.st_loc)
destroy(this.st_app)
destroy(this.dw_user)
destroy(this.st_7)
destroy(this.pb_notes)
destroy(this.cb_filter_fac)
destroy(this.cb_filter_loc)
destroy(this.cb_filter_app)
destroy(this.sle_ffac)
destroy(this.sle_fapp)
destroy(this.sle_floc)
destroy(this.st_8)
destroy(this.dw_dept)
destroy(this.ddlb_ir)
destroy(this.st_ir)
destroy(this.cbx_add_ids)
destroy(this.dw_ids)
destroy(this.gb_prac)
end on

event open;call super::open;long li_prac
long ll_action_type
string ls_mess
string ls_from
string ls_prac

//From: P = prac folder - app status ;  F = prac folder - data entry ; B = batch add apps
//debugbreak()
ls_mess = message.stringparm
li_prac = long(MidA(ls_mess,1,PosA(ls_mess,"*",1) - 1))
ls_from = MidA(ls_mess,PosA(ls_mess,"*",1) + 1)


//Start Code Change ----01.06.2015 #V14.2 maha - hide location code change 
if li_prac > 0 then //from the prac folder
	ib_prac_folder = true  //Start Code Change ----05.22.2014 #V14.2 maha
	il_prac_ids[1] = li_prac
	select full_name into :ls_prac from v_full_name where prac_id = :li_prac;
	is_prac_names[1] = ls_prac 
	st_pracs.text = ls_prac
 //Start Code Change ----06.16.2015 #V15 maha	- added
	dw_all_facilities.dataobject = "d_facility_multi_select_prac"
	dw_all_facilities.settransobject(sqlca)
	dw_all_facilities.Retrieve(li_prac, gs_user_id )
else
	dw_all_facilities.SetTransObject( SQLCA )
	dw_all_facilities.Retrieve(gs_user_id )
 //Start Code Change ----06.16.2015	
end if

choose case gi_intelliapp_type
	case 3, 0  //two level no locations
		dw_locations.hide( )
		sle_floc.hide()
		cb_filter_loc.hide( )
		st_loc.hide()
		dw_all_facilities.width = 4389
		st_group.width = 4389
	case else
		if li_prac > 0 then //from the prac folder
			//Start Code Change ----04.07.2014 #V14.2 maha
			dw_locations.dataobject = "d_group_prac_select_batch_prac"
			dw_locations.settransobject(sqlca)
			dw_locations.retrieve(il_prac_ids[1])
			//End Code Change ----04.07.2014
			dw_locations.title = "Select Practice Addresses"
			st_loc.text = "Select Practice Addresses"
		else
			dw_locations.retrieve() //Start Code Change ----04.07.2014 #V14.2 maha - all locations
			
		end if
end choose
//End Code Change ----01.06.2015

of_set_rbs( ls_from )

//Start Code Change ----06.18.2014 #V14.2 maha
is_user = gs_user_id
dw_user.setitem(1,"user_id", is_user)
//End Code Change ----06.18.2014

//Start Code Change ----07.28.2014 #V14.2 maha - added option to get first step 
if of_get_app_setting("set_82" , "I") = 1 then
	ll_action_type = long(gnv_data.of_getitem("app_steps","next step",'0'))
else
	ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
end if

if isnull(ll_action_type) or ll_action_type = 0 then ll_action_type = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
//End Code Change ----07.28.2014

dw_type.retrieve()
dw_type.insertrow(1)
dw_type.setitem(1,"lookup_code",ll_action_type)
//End Code Change ----08.26.2010 

IF gb_sk_ver = True THEN
	cb_batch.visible = false
end if

inv_def = create pfc_cst_nv_data_entry_functions //Start Code Change ----04.30.2014 #V14.2 maha

//Start Code Change ----09.05.2017 #V154 maha
dw_ids.settransobject(sqlca)
dw_ids.insertrow(1)
dw_ids.setitem(1,"plan_assigned_id", "TBD")
//Start Code Change ----09.05.2017 #V154 maha
end event

event closequery;return 0
end event

event close;call super::close;destroy inv_def  //Start Code Change ----04.30.2014 #V14.2 maha
end event

type dw_1 from w_select_applications`dw_1 within w_batch_add_apps_facilities
integer x = 41
integer y = 1660
integer width = 4384
integer height = 916
string title = "Select Applications"
string dataobject = "d_applications_select_treeview"
end type

event dw_1::constructor;call super::constructor;This.of_SetUpdateable( False )
end event

event dw_1::clicked;call super::clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
END IF
end event

event dw_1::buttonclicked;call super::buttonclicked;//Start Code Change ----04.02.2014 #V14.2 maha

long i
integer v
long org
long r

if dwo.name = "b_select" then
	if dwo.text = 'Select All' then
		v = 1
		dwo.text = 'Deselect All'
	else
		v = 0
		dwo.text = 'Select All'
	end if
	
	for i = 1 to this.rowcount()
		this.setitem(i,"selected",v)
	next
	
	if v = 1 then dw_1.ExpandLevel(1)
end if

 //Start Code Change ----02.12.2015 #V15 maha
if dwo.name = "b_org_all" then
	
	r = row
	org = this.getitemnumber(r, "app_facility_facility_id")
//	if dwo.text = 'Select All' then
		v = 1
//		dwo.text = 'Deselect'
//	else
//		v = 0
//		dwo.text = 'Select All'
//	end if
	
	for i = 1 to this.rowcount()
		if this.getitemnumber(i , "app_facility_facility_id") = org then
			this.setitem(i,"selected",v)
		end if
	next
end if
//End Code Change ----02.12.2015
end event

type cb_1 from w_select_applications`cb_1 within w_batch_add_apps_facilities
boolean visible = false
integer x = 2981
integer y = 2700
integer taborder = 100
end type

type cb_2 from w_select_applications`cb_2 within w_batch_add_apps_facilities
integer x = 3963
integer y = 36
integer width = 489
integer taborder = 110
string text = "Close"
end type

event cb_2::clicked;//Modify by Evan 07.09.2009(Corrected BugE061901) --- Not extend ancestory script

close(parent)
end event

type cb_create from commandbutton within w_batch_add_apps_facilities
integer x = 3959
integer y = 192
integer width = 489
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process"
end type

event clicked;Integer li_ans
long i
long ic
long fc
long li_app_rc
long li_null[]
Long li_app_cnt
Long li_pc
long lc  //maha 04.07.2014
long lrc
String ls_null[] //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)

ii_facility_id = li_null
il_facility_cnt = 0
is_fac_state[] = ls_null[]  //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
is_loc_state[] = ls_null[]  //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
dw_1.AcceptText()

//find out the number of pracs selected
li_pc = upperbound( il_prac_ids[] ) 
ic = dw_all_facilities.rowcount()

IF li_pc = 0 THEN
	MessageBox("Practitioner Select Error", "You have not selected any practitioner to add applications to." )
	Return -1
END IF
//debugbreak()
//check for facilities
for i = 1 to ic
	if dw_all_facilities.GetItemNumber( i, "selected" ) = 1 THEN	
		il_facility_cnt++
		ii_facility_id[il_facility_cnt] = dw_all_facilities.GetItemNumber( i, "facility_id" ) 
		is_fac_state[il_facility_cnt] = dw_all_facilities.GetItemString( i, "state" ) //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
	end if
next

fc = upperbound(ii_facility_id[] )
if fc = 0 then
	MessageBox( is_fac_error + " Select Error", "You have not selected any " + is_fac_error + "." )
	Return -1
end if
	
if rb_apps.checked  or rb_print.checked then	
	li_app_rc = dw_1.RowCount( )
	FOR i = 1 TO li_app_rc
		IF dw_1.GetItemNumber( i, "selected" ) = 1 THEN	
			li_app_cnt++
			ii_app_id[li_app_cnt] = dw_1.GetItemNumber( i, "app_id" )   //Start Code Change ----05.22.2014 #V14.2 maha
			is_app_name[li_app_cnt] = dw_1.GetItemString( i, "app_hdr_application_name" ) //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
		END IF
	END FOR

	IF li_app_cnt = 0 THEN 
		MessageBox("Application Select Error", "You must select at least one application." )
		Return 
	END IF
end if

//Start Code Change ----04.07.2014 #V14.2 maha
if rb_apps.checked  or rb_print.checked then	
	lrc = dw_locations.RowCount( )
	FOR i = 1 TO lrc  //Start Code Change ----05.22.2014 #V14.2 maha - changed variable
		IF dw_locations.GetItemNumber( i, "selected" ) = 1 THEN	
			lc++
			if ib_prac_folder then
				il_loc_id[lc] = dw_locations.GetItemNumber( i, "gp_id" )  //Start Code Change ----05.22.2014 #V14.2 maha
			else
				il_loc_id[lc] = dw_locations.GetItemNumber( i, "rec_id" )  //Start Code Change ----05.22.2014 #V14.2 maha
			end if
			
			is_loc_state[lc] = dw_locations.GetItemString( i ,"state") //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
		END IF
	END FOR
end if
//Start Code Change ----04.07.2014

//Start Code Change ----04.09.2012 #V12 maha 
il_action_type = dw_type.getitemnumber(1,"lookup_code")
is_set_field = gnv_data.of_getitem("app_steps","find step field",string(il_action_type)) 
//End Code Change ----04.09.2012

if rb_apps.checked then
	//Start Code Change ----04.07.2014 #V14.2 maha
	if lc = 0 then
		il_ai_rc = li_pc * fc * li_app_cnt
	else //include loc count
		il_ai_rc = li_pc * fc * li_app_cnt * lc
	end if
	
	li_ans = MessageBox( "Create Action Items", "A total of " + String( il_ai_rc ) + " Application Actions will be created for the ~r" + string(fc) + " selected Facilities and the " + string(li_app_cnt) + " selected Applications   ~r~rContinue?", Information!, OKCancel!, 2)
	IF li_ans = 1 THEN
		of_batch_add( )
	end if
elseif rb_print.checked then
	if lc = 0 then
		il_ai_rc = li_pc * fc * li_app_cnt
	else //include loc count
		il_ai_rc = li_pc * fc * li_app_cnt * lc
	end if

	li_ans = MessageBox( "Print Applications", String( il_ai_rc ) + " total Applications will be printed.  Continue?", Information!, YesNo!, 2)
	IF li_ans = 1 THEN
		of_print_apps()
	end if
else //facility only
	of_batch_add( )
END IF
	
	
	
	
//IF dw_facility.GetItemNumber( 1, "facility_id" ) = 0 THEN
//	li_ans = MessageBox( "All Facilities", "Are you sure you want to create a PRINT APPLICATION action item for all facilities?", Question!, YesNo!, 1 )
//	IF li_ans = 2 THEN
//		Return
//	END IF
//	il_ai_rc = li_pc * upperbound(ii_facility_id[] ) * li_app_cnt
//ELSE
//	il_ai_rc = li_pc * li_app_cnt
//END IF


	

end event

type cb_5 from commandbutton within w_batch_add_apps_facilities
boolean visible = false
integer x = 2418
integer y = 2700
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

type dw_all_facilities from datawindow within w_batch_add_apps_facilities
integer x = 41
integer y = 720
integer width = 2181
integer height = 816
boolean bringtotop = true
string title = "Select Facilities/Groups"
string dataobject = "d_facility_multi_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor; //Start Code Change ----06.16.2015 #V15 maha - moved to opened event
//This.SetTransObject( SQLCA )
//This.Retrieve(gs_user_id )
end event

event buttonclicked;//Start Code Change ----04.02.2014 #V14.2 maha

long i
integer v
long org
long r

if dwo.name = "b_select" then
	if dwo.text = 'Select All' then
		v = 1
		dwo.text = 'Deselect All'
	else
		v = 0
		dwo.text = 'Select All'
	end if
	
	for i = 1 to this.rowcount()
		this.setitem(i,"selected",v)
	next
end if
debugbreak()


of_get_locations()
end event

event itemchanged;//messagebox("","items changed")
//Start Code Change ----04.22.2014 #V14.2 maha
//post of_get_locations()
end event

type st_3 from statictext within w_batch_add_apps_facilities
integer x = 101
integer y = 2816
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

type st_4 from statictext within w_batch_add_apps_facilities
integer x = 101
integer y = 2908
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

type dw_facility_add from u_dw within w_batch_add_apps_facilities
boolean visible = false
integer x = 2926
integer y = 2804
integer width = 334
integer height = 148
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pd_affil_status_ia"
boolean vscrollbar = false
end type

type cb_now from commandbutton within w_batch_add_apps_facilities
integer x = 864
integer y = 2900
integer width = 841
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

//integer i
//integer a
//Integer li_app_rc
//Long li_app_cnt = 0
//Long li_pc
//long p
//long cnt
//long pid
//string pn
//
//dw_1.AcceptText()
//
////find out the number of pracs selected
//li_pc = upperbound( il_prac_ids[] ) 
//
//IF li_pc = 0 THEN
//	MessageBox("Practitioner Select Error", "You have not selected any practitioner to add applications to." )
//	Return -1
//END IF
//
//li_app_rc = dw_1.RowCount( )
//FOR i = 1 TO li_app_rc
//	IF dw_1.GetItemNumber( i, "selected" ) = 1 THEN	
//		li_app_cnt++
//	END IF
//END FOR
//
//
//IF li_app_cnt = 0 THEN 
//	MessageBox("Application Select Error", "You must select at least one application." )
//	Return 		
//end if
////debugbreak()
//
//IF dw_facility.GetItemNumber( 1, "facility_id" ) = 0 THEN
//	MessageBox( "All Facilities", "You must select a Facility." )
//	Return
//END IF
//
//for p = 1 to li_pc
//	for a = 1 TO li_app_rc
//		IF dw_1.GetItemNumber( a, "selected" ) = 1 THEN
//			cnt++
//			pid = il_prac_ids[p]
//			ist_search.li_prac_id[cnt]  = pid
//			pn = is_prac_names[p]
//			ist_search.ls_name[cnt] = pn
//			ist_search.ll_app[cnt] = dw_1.GetItemNumber( a, "app_id" )
//			ist_search.ll_facility[cnt] = dw_facility.GetItemNumber( 1, "facility_id" )
//		end if
//	next
//next
//
//openwithparm(w_intelliapp_print,ist_search)
//w_intelliapp_print.lst_search = ist_search
//w_intelliapp_print.of_print_now()
//
//close(w_batch_add_new_app)


end event

type st_6 from statictext within w_batch_add_apps_facilities
integer x = 736
integer y = 2916
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

type rb_facility from radiobutton within w_batch_add_apps_facilities
integer x = 69
integer y = 56
integer width = 544
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Group/Facility only"
boolean checked = true
end type

event clicked;//Start Code Change ----10.01.2014 #V14.2 maha
parent.height = 1725    //1475  //Start Code Change ----01.14.2011 #V11 maha - changed from 1200
dw_all_facilities.width = 4393
st_group.width = 4393

dw_locations.visible = false
st_loc.visible = false
st_app.visible = false

//End Code Change ----10.01.2014

 //---------Begin Added by (Appeon)Stephen 04.24.2015 for V14.2 Bug: 4501 Print NOW in Batch Add shows the Select Practice Locations for 2 level tree--------
sle_floc.visible = false
cb_filter_loc.visible = false
sle_fapp.visible = false
cb_filter_app.visible =false
//---------End Added ------------------------------------------------------


end event

type rb_apps from radiobutton within w_batch_add_apps_facilities
integer x = 658
integer y = 56
integer width = 709
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Groups and Applications"
end type

event clicked;parent.height = 2750

//Start Code Change ----10.01.2014 #V14.2 maha
if not(gi_intelliapp_type =3 or gi_intelliapp_type = 0) then//(Appeon)Stephen 04.24.2015 - V14.2 Bug: 4501 Print NOW in Batch Add shows the Select Practice Locations for 2 level tree
	dw_all_facilities.width = 2181
	st_group.width = 2181
	
	dw_locations.visible =true
	st_loc.visible =true
	//---------Begin Added by (Appeon)Stephen 04.24.2015 for V14.2 Bug: 4501 Print NOW in Batch Add shows the Select Practice Locations for 2 level tree--------
	sle_floc.visible = true
	cb_filter_loc.visible = true	
	//---------End Added ------------------------------------------------------
end if
st_app.visible = true
//Start Code Change ----10.01.2014

//---------Begin Added by (Appeon)Stephen 04.24.2015 for V14.2 Bug: 4501 Print NOW in Batch Add shows the Select Practice Locations for 2 level tree--------
sle_fapp.visible = true
cb_filter_app.visible =true
//---------End Added ------------------------------------------------------

end event

type rb_print from radiobutton within w_batch_add_apps_facilities
integer x = 1376
integer y = 56
integer width = 997
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Print NOW /No Action Items Created"
end type

event clicked;//Start Code Change ----10.01.2014 #V14.2 maha
parent.height = 2750
if not(gi_intelliapp_type =3 or gi_intelliapp_type = 0) then//(Appeon)Stephen 04.24.2015 - V14.2 Bug: 4501 Print NOW in Batch Add shows the Select Practice Locations for 2 level tree
	dw_all_facilities.width = 2181
	st_group.width = 2181
	
	dw_locations.visible =true
	st_loc.visible =true
	//---------Begin Added by (Appeon)Stephen 04.24.2015 for V14.2 Bug: 4501 Print NOW in Batch Add shows the Select Practice Locations for 2 level tree--------
	sle_floc.visible = true
	cb_filter_loc.visible = true
	//---------End Added ------------------------------------------------------
end if
st_app.visible = true
//Start Code Change ----10.01.2014

//---------Begin Added by (Appeon)Stephen 04.24.2015 for V14.2 Bug: 4501 Print NOW in Batch Add shows the Select Practice Locations for 2 level tree--------
sle_fapp.visible = true
cb_filter_app.visible =true
//---------End Added ------------------------------------------------------
end event

type dw_type from datawindow within w_batch_add_apps_facilities
integer x = 82
integer y = 412
integer width = 745
integer height = 80
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_action_type_select"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject( sqlca)
end event

type st_1 from statictext within w_batch_add_apps_facilities
integer x = 91
integer y = 360
integer width = 434
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
string text = "Select Action Type"
boolean focusrectangle = false
end type

type sle_note from singlelineedit within w_batch_add_apps_facilities
integer x = 1065
integer y = 412
integer width = 1518
integer height = 72
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_batch_add_apps_facilities
integer x = 1079
integer y = 360
integer width = 338
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Action Notes:"
boolean focusrectangle = false
end type

type cbx_done from checkbox within w_batch_add_apps_facilities
integer x = 896
integer y = 420
integer width = 110
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
end type

type st_5 from statictext within w_batch_add_apps_facilities
integer x = 827
integer y = 360
integer width = 238
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Complete"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_batch_add_apps_facilities
integer x = 23
integer width = 3895
integer height = 136
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Function:"
end type

type gb_3 from groupbox within w_batch_add_apps_facilities
integer x = 32
integer y = 304
integer width = 4430
integer height = 212
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Action Settings:"
end type

type cb_prac from commandbutton within w_batch_add_apps_facilities
integer x = 2373
integer y = 192
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
string text = "&Select Provider"
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
lstr_search.ls_open_for = "REPORTS0" 

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


st_pracs.Text = String( UpperBound( il_prac_ids[] ) ) + " Providers selected."

IF UpperBound( il_prac_ids ) > 0 THEN
	cb_create.Enabled = True
	cb_now.Enabled = True
END IF

 

end event

type cb_batch from commandbutton within w_batch_add_apps_facilities
integer x = 2903
integer y = 192
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

type cb_view from commandbutton within w_batch_add_apps_facilities
integer x = 3397
integer y = 192
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
string text = "&View Selected"
end type

event clicked;gs_batch_search ls_b



IF UpperBound( il_prac_ids ) > 0 THEN
	ls_b.li_prac_id[] = il_prac_ids[]
	openwithparm(w_selected_prac_list,ls_b)
END IF
end event

type st_pracs from statictext within w_batch_add_apps_facilities
integer x = 96
integer y = 204
integer width = 1682
integer height = 72
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
string text = "No provider selected"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_batch_add_apps_facilities
integer x = 37
integer y = 520
integer width = 626
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select from Template"
end type

event clicked;//Start Code Change ----03.13.2013 #V12 maha - added
gs_pass_ids lst_ids
long ll_apps[] , ll_aid
long ll_loc[], ll_gpid  //maha 04.28.2014
long r, ll_find, rc
long ll_facil
string ls_find

//openwithparm(w_app_template_select, facility array)
open(w_app_template_select)

if message.stringparm = "Cancel" then	return

lst_ids = message.powerobjectparm
ll_apps = lst_ids.l_ids
ll_facil = lst_ids.facility_id
ll_loc = lst_ids.sl_action_type

rc = dw_1.rowcount()
for r = 1 to upperbound(ll_apps)
	ll_aid = ll_apps[r]
	ls_find = "app_id = " + string(ll_aid)
	ll_find = dw_1.find( ls_find,1, rc)
	if ll_find > 0 then
		dw_1.setitem(ll_find, "selected", 1)
	end if
next	

if ll_facil > 0 then
	ls_find = " facility_id = " + string(ll_facil)
	ll_find = dw_all_facilities.find( ls_find,1, dw_all_facilities.rowcount())
	if ll_find > 0 then
		dw_all_facilities.setitem( ll_find, "selected", 1 )
		//of_get_locations( )  //Start Code Change ----04.22.2014 #V14.2 maha
	end if
end if

//Start Code Change ----04.28.2014 #V14.2 maha - locations
rc = dw_locations.rowcount()
debugbreak()
for r = 1 to upperbound(ll_loc)
	ll_gpid = ll_loc[r]
	ls_find = "rec_id = " + string(ll_gpid)
	ll_find = dw_locations.find( ls_find,1, rc)
	if ll_find > 0 then
		dw_locations.setitem(ll_find, "selected", 1)
	end if
	
	dw_1.Expand(ll_find, 1) 
next	
//End Code Change ----04.28.2014

	

	
end event

type dw_locations from datawindow within w_batch_add_apps_facilities
integer x = 2254
integer y = 720
integer width = 2176
integer height = 816
integer taborder = 20
boolean bringtotop = true
string title = "Select Practice Locations"
string dataobject = "d_group_prac_select_batch_1_group"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;//Start Code Change ----04.07.2014 #V14.2 maha
This.SetTransObject( SQLCA )
//This.Retrieve( )
end event

event buttonclicked;//Start Code Change ----04.02.2014 #V14.2 maha

long i
integer v

if dwo.name = "b_select" then
	if dwo.text = 'Select All' then
		v = 1
		dwo.text = 'Deselect All'
	else
		v = 0
		dwo.text = 'Select All'
	end if
	
	for i = 1 to this.rowcount()
		this.setitem(i,"selected",v)
	next
end if
end event

type cbx_items from checkbox within w_batch_add_apps_facilities
integer x = 2926
integer y = 52
integer width = 955
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Create Appropriate Checklist Items"
boolean checked = true
end type

type cb_4 from commandbutton within w_batch_add_apps_facilities
integer x = 667
integer y = 520
integer width = 411
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Selections"
end type

event clicked;//Start Code Change ----05.02.2014 #V14.2 maha

long r

for r = 1 to dw_all_facilities.rowcount()
	dw_all_facilities.setitem(r, "selected", 0)
next

for r = 1 to dw_1.rowcount()
	dw_1.setitem(r, "selected", 0)
next

for r = 1 to dw_locations.rowcount()
	dw_locations.setitem(r, "selected", 0)
next


end event

type st_group from statictext within w_batch_add_apps_facilities
integer x = 41
integer y = 620
integer width = 2181
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Group/Facility"
boolean border = true
boolean focusrectangle = false
end type

type st_loc from statictext within w_batch_add_apps_facilities
integer x = 2258
integer y = 620
integer width = 2171
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Practice Locations"
boolean border = true
boolean focusrectangle = false
end type

type st_app from statictext within w_batch_add_apps_facilities
integer x = 41
integer y = 1560
integer width = 4384
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Applications"
boolean border = true
boolean focusrectangle = false
end type

type dw_user from datawindow within w_batch_add_apps_facilities
integer x = 2693
integer y = 408
integer width = 507
integer height = 76
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "d_user_select_current"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event itemchanged;//Start Code Change ----06.18.2014 #V14.2 maha
is_user = data
end event

type st_7 from statictext within w_batch_add_apps_facilities
integer x = 2706
integer y = 352
integer width = 393
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Assigned User:"
boolean focusrectangle = false
end type

type pb_notes from picturebutton within w_batch_add_apps_facilities
integer x = 2587
integer y = 408
integer width = 105
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "note.bmp"
alignment htextalign = left!
end type

event clicked;//------Begin Modfiied by Appeon long.zhang 09.03.2014 (V14.2 Testing Bug # 4169 During Batch Add Applications Multi-Line Note Modification Doesn't Work)---------------
string ls_notes
ls_notes = sle_note.text
if isnull(ls_notes) then ls_notes = ""

OpenWithParm( w_ai_notes_new, ls_notes)

IF Message.StringParm = "Cancel" THEN
	Return
ELSE
	sle_note.text = Message.StringParm
END IF
//---------End Modfiied by Appeon long.zhang 09.03.2014 ( V14.2 Testing Bug # 4169) ------------------------------------------------------


end event

type cb_filter_fac from commandbutton within w_batch_add_apps_facilities
integer x = 1993
integer y = 628
integer width = 215
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;//Start Code Change ----01.05.2015 #V14.2 maha
string s
string ls_filter

s = upper(sle_ffac.text)

if len(s) > 0 then
	ls_filter =  "Upper(facility_name) like '%" + s + "%'" 
	dw_all_facilities.setfilter(ls_filter)
	dw_all_facilities.filter()
else
	ls_filter =  "" 
	dw_all_facilities.setfilter(ls_filter)
	dw_all_facilities.filter()
end if

dw_all_facilities.sort()
end event

type cb_filter_loc from commandbutton within w_batch_add_apps_facilities
integer x = 4201
integer y = 628
integer width = 215
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;//Start Code Change ----01.05.2015 #V14.2 maha
string s
string ls_filter

s = upper(sle_floc.text)

if len(s) > 0 then
	ls_filter =  "Upper(compute_1) like '%" + s + "%'" 
	dw_locations.setfilter(ls_filter)
	dw_locations.filter()
else
	ls_filter =  "" 
	dw_locations.setfilter(ls_filter)
	dw_locations.filter()
end if

dw_locations.sort()
dw_locations.groupcalc( )
end event

type cb_filter_app from commandbutton within w_batch_add_apps_facilities
integer x = 1993
integer y = 1568
integer width = 215
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;//Start Code Change ----01.05.2015 #V14.2 maha
string s
string ls_filter

s = upper(sle_fapp.text)

if len(s) > 0 then
	ls_filter =  "Upper(app_hdr_application_name) like '%" + s + "%'" 
	dw_1.setfilter(ls_filter)
	dw_1.filter()
else
	ls_filter =  "" 
	dw_1.setfilter(ls_filter)
	dw_1.filter()
end if

dw_1.sort()
end event

type sle_ffac from singlelineedit within w_batch_add_apps_facilities
integer x = 1152
integer y = 632
integer width = 827
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_fapp from singlelineedit within w_batch_add_apps_facilities
integer x = 1152
integer y = 1572
integer width = 827
integer height = 72
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_floc from singlelineedit within w_batch_add_apps_facilities
integer x = 3360
integer y = 632
integer width = 827
integer height = 72
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_batch_add_apps_facilities
integer x = 3250
integer y = 352
integer width = 585
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Department/Category:"
boolean focusrectangle = false
end type

type dw_dept from datawindow within w_batch_add_apps_facilities
integer x = 3232
integer y = 404
integer width = 754
integer height = 84
integer taborder = 160
boolean bringtotop = true
string title = "none"
string dataobject = "d_code_lookup_act_dept"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.retrieve()

this.getchild( "lookup_code", dwchild)
dwchild.insertrow(1)
dwchild.setitem(1,"lookup_code", 0)
this.setitem(1,"lookup_code",0)
end event

event itemchanged; //Start Code Change ----02.12.2015 #V15 maha
 il_dept = long(data)
end event

type ddlb_ir from dropdownlistbox within w_batch_add_apps_facilities
integer x = 4005
integer y = 404
integer width = 411
integer height = 216
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string item[] = {"Initial","Recred"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged; //Start Code Change ----02.12.2015 #V15 maha --ddlb added
choose case index
	case 1
		is_app_type = "I"
	case 2
		is_app_type = "R"
end choose
end event

type st_ir from statictext within w_batch_add_apps_facilities
integer x = 4005
integer y = 344
integer width = 384
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
string text = "Initial/Recred:"
boolean focusrectangle = false
end type

type cbx_add_ids from checkbox within w_batch_add_apps_facilities
integer x = 1234
integer y = 536
integer width = 969
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Add IDs record for each Added Action"
end type

event clicked;//Start Code Change ----09.05.2017 #V154 maha
if this.checked then
	dw_ids.visible = true
else
	dw_ids.visible = false
end if
end event

type dw_ids from datawindow within w_batch_add_apps_facilities
boolean visible = false
integer x = 2263
integer y = 532
integer width = 1760
integer height = 84
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_net_dev_ids_4_batch_add"
boolean border = false
boolean livescroll = true
end type

type gb_prac from groupbox within w_batch_add_apps_facilities
integer x = 32
integer y = 148
integer width = 3886
integer height = 144
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Providers"
end type

