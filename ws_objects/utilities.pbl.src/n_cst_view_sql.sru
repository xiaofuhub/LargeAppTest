$PBExportHeader$n_cst_view_sql.sru
$PBExportComments$utilities pbl - to update views
forward
global type n_cst_view_sql from nonvisualobject
end type
end forward

global type n_cst_view_sql from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
end prototypes

type variables


long il_database_version /* the current database version*/
string ls_sql_statments[]
CONSTANT STRING NEW_LINE  = '~r~n'
N_ds lds_db_control

BOOLEAN IB_SHOW_UPDATE_WINDOW /* Display the progress window*/
n_cst_string inv_string 	//03/23/2007 By Jervis
datastore ids_temp			//03/23/2007 By Jervis
end variables

forward prototypes
private function integer of_execute_sql ()
public function integer of_report_sql ()
public subroutine of_appeon_global_search ()
public function integer of_update_view_v6_1 ()
public function integer of_update_view_v6_2 ()
public function string of_get_view_action (string as_view_name)
end prototypes

private function integer of_execute_sql ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 10 February 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_i
string ls_null[]
boolean lb_ref_cache

IF UPPERBOUND(ls_sql_statments) > 0 THEN  lb_ref_cache  = true




IF UPPERBOUND(ls_sql_statments) > 0 THEN 
	   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "commit;"
		
//		IF IB_SHOW_UPDATE_WINDOW = TRUE THEN 
//	       open(w_infodisp)
//	   END IF

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-09-27 By: Rodger Wu
		//$<reason> Fix a defect.
		if Not isvalid( w_infodisp ) then open(w_infodisp)
		//---------------------------- APPEON END ----------------------------

		if isvalid(w_infodisp) then w_infodisp.title = 'Updating Views, Please stand by'
		if isvalid(w_infodisp) then w_infodisp.Center = TRUE
		if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Updating Views, Please stand by'
		if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(ls_sql_statments))
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-02
		//$<add> 03.14.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_startqueue( )
		//---------------------------- APPEON END ----------------------------

		FOR ll_i = 1 TO upperbound(ls_sql_statments)
			if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(ls_sql_statments)) +' Please stand by!'
				 EXECUTE IMMEDIATE :ls_sql_statments[LL_I] using sqlca;
				 IF LenA(sqlca.sqlerrtext) > 0 THEN
					// Added by Davis 11.14.2006
					IF handle(getapplication()) = 0 THEN
//						messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql_statments[LL_I]) + new_line + "Please contact software vendor."   )
					END IF
					// Added by Davis 11.14.2006

					else
				  commit;
					
				END IF
				if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-03
		//$<add> 03.14.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_commitqueue( )
		//---------------------------- APPEON END ----------------------------

		//if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Commiting modifications Please stand by!'
		
      if isvalid(w_infodisp) then close(w_infodisp)
//     if not isnull(il_database_version) then 
//		//  il_database_version = il_database_version + 1 
//		  lds_db_control.SetItem(1,'contract_database_version',il_database_version)
//		  
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<ID> PT-04
//			//$<add> 03.14.2006 By: LeiWei
//			//$<reason> Performance tuning
//			//$<modification> Add Appeon commit label to reduce client-server interactions to improve runtime performance.
//
//			gnv_appeondb.of_autocommit( )
//			//---------------------------- APPEON END ----------------------------
//
//		  lds_db_control.update()
//		  commit;
////		  IF lb_ref_cache THEN 
////			gnv_app.ib_ref_cache = true 
////			gnv_app.of_setcontraccache( )
////		end if 
//		  
//	  end if 
	  
END IF


if il_database_version = 2 then 
	
	long il_active_code
	select lookup_code  
	into :il_active_code
	from code_lookup
	where lookup_name = 'Contract Status' and code = 'active';
	
	UPDATE "ctx_fee_sched_data"  
   SET "status" = :il_active_code where "status" is null;
	
	commit;
	
end if 

ls_sql_statments = ls_null

return 0
end function

public function integer of_report_sql ();
return 1  // no need to run this the report is not done yet

long ll_max_rpt_id
long ll_contract_reports[]
long ll_i
long ll_report_id

n_ds lds_ctx_reports
lds_ctx_reports = CREATE n_ds
lds_ctx_reports.dataobject ='ds_ctx_sys_reports'
lds_ctx_reports.settransobject(sqlca)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 04.01.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
select max(report_id) 
into :ll_max_rpt_id
from sys_reports;

if ll_max_rpt_id = 0 or isnull(ll_max_rpt_id ) then 
	ll_max_rpt_id = 1
else 
	ll_max_rpt_id++
end if

//////////////////////////////////////////////////////////////////////////////////////
// get all of the report ids that are asscociated with Contract
//////////////////////////////////////////////////////////////////////////////////////

lds_ctx_reports.retrieve( )
*/
gnv_appeondb.of_startqueue( )

select max(report_id) 
into :ll_max_rpt_id
from sys_reports;

lds_ctx_reports.retrieve( )

gnv_appeondb.of_commitqueue( )

if ll_max_rpt_id = 0 or isnull(ll_max_rpt_id ) then 
	ll_max_rpt_id = 1
else 
	ll_max_rpt_id++
end if

gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////////////
// delete all of sys_report_wizard rows for the report ids
//////////////////////////////////////////////////////////////////////////////////////
for ll_i = 1 to lds_ctx_reports.rowcount()
	ll_report_id = lds_ctx_reports.getItemnumber(ll_i,'report_id')
	DELETE FROM "sys_report_wizard" WHERE "sys_reports"."report_id" = :ll_report_id ;
	commit;
	DELETE FROM "sys_reports" WHERE "sys_reports"."report_id" = :ll_report_id;
	commit;
next

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 04.01.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////////////
// insert the new stuff
//////////////////////////////////////////////////////////////////////////////////////
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_reports ( report_id,report_name, report_description,  report_dw,graph_dw, criteria_dw, category, r_type) VALUES (" + string(ll_max_rpt_id) + ", 'Contracts by Association ',   'Retrieves Contracts that are associated to a user',   'r_ctx_contracts_by_assn',   '',   '', 'Contract',   'B' )"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 1, 'd_crit_contract_det_contact', 'N', 'Select User', 'Y', 'Y' )"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 2, 'd_crit_contract_status', 'N', 'Select Contract Status', 'Y', 'Y' )"
ll_max_rpt_id++


/** New Contract Report **/
destroy lds_ctx_reports



return 0
end function

public subroutine of_appeon_global_search ();
end subroutine

public function integer of_update_view_v6_1 ();//////////////////////////////////////////////////////////////////////
// $<function>		n_cst_contract_sql.of_update_view_v6_1()
// $<arguments> 	None
// $<returns> 		integer
// $<description>	Update the view's sql
// $<add> 			07.23.2007 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_sql,ls_tag,ls_Title

IF gs_dbtype = "ASA" THEN 
	ls_tag = "; "
	ls_Title = "TOP 50000000"
ELSE
	ls_Title = "top 100 percent"
END IF

ls_sql = of_get_view_action('v_acedemic_appointments') + "~r~n" + &
"as select " + ls_Title + " pd_acedemic_appointments.rec_id,~r~n" + &
"pd_acedemic_appointments.prac_id,~r~n" + &
"school_code=address_lookup.code,~r~n" + &
"school_name=address_lookup.entity_name,~r~n" + &
"pd_acedemic_appointments.month_from,~r~n" + &
"pd_acedemic_appointments.year_from,~r~n" + &
"pd_acedemic_appointments.month_thru,~r~n" + &
"pd_acedemic_appointments.year_thru,~r~n" + &
"achdmc_dept_code=code_lookup_a.code,~r~n" + &
"a_dept_description=code_lookup_a.description,~r~n" + &
"faculty_rank=code_lookup_b.code,faculty_rank_code=code_lookup_b.description ~r~n" + &
"from(((pd_acedemic_appointments left outer join address_lookup on pd_acedemic_appointments.school_code = address_lookup.lookup_code) ~r~n" + &
"left outer join code_lookup as code_lookup_a on pd_acedemic_appointments.department_code = code_lookup_a.lookup_code) ~r~n" + &
"left outer join code_lookup as code_lookup_b on pd_acedemic_appointments.faculty_rank_code = code_lookup_b.lookup_code)~r~n" + &
"order by pd_acedemic_appointments.rec_id,pd_acedemic_appointments.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_action_items') + "~r~n" + &
"as select distinct " + ls_Title + "~r~n" + &
"verif_info.prac_id,~r~n" + &
"verif_info.facility_id,~r~n" + &
"facility.facility_name,~r~n" + &
"data_view_screen.screen_name,~r~n" + &
"verif_info.reference_value,~r~n" + &
"verification_method=code_lookup_b.code,~r~n" + &
"verif_info.first_sent,~r~n" + &
"verif_info.last_sent,~r~n" + &
"verif_info.number_sent,~r~n" + &
"verif_info.date_recieved,~r~n" + &
"verif_info.user_name,~r~n" + &
"response_code=code_lookup_a.code,~r~n" + &
"verif_info.active_status,~r~n" + &
"verif_info.print_flag,~r~n" + &
"verif_info.doc_id,~r~n" + &
"verif_info.notes ~r~n" + &
"from((verif_info left outer join code_lookup as code_lookup_a on verif_info.response_code = code_lookup_a.lookup_code) ~r~n" + &
"left outer join code_lookup as code_lookup_b on verif_info.verification_method = code_lookup_b.lookup_code),facility,data_view_screen ~r~n" + &
"where(verif_info.screen_id = data_view_screen.screen_id) ~r~n" + &
"and(verif_info.facility_id = facility.facility_id) ~r~n" + &
"and((data_view_screen.data_view_id = 1))~r~n" + &
"order by verif_info.prac_id,verif_info.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_address') + "~r~n" + &
"  as select " + ls_Title + " pd_address.rec_id,~r~n" + &
"    pd_address.prac_id,~r~n" + &
"    practitioner=pd_basic.first_name+pd_basic.last_name,~r~n" + &
"    office_in_home=code_lookup_b.code,~r~n" + &
"    prac_type_code=code_lookup_d.code,~r~n" + &
"    prac_type=code_lookup_d.description,~r~n" + &
"    pd_address.street,~r~n" + &
"    pd_address.city,~r~n" + &
"    state_code=code_lookup_e.code,~r~n" + &
"    state_name=code_lookup_e.description,~r~n" + &
"    country_code=code_lookup_f.code,~r~n" + &
"    country_name=code_lookup_f.description,~r~n" + &
"    pd_address.pager_number,~r~n" + &
"    pd_address.phone,~r~n" + &
"    pd_address.ext,~r~n" + &
"    pd_address.fax,~r~n" + &
"    pd_address.zip,~r~n" + &
"    county_code=code_lookup_g.code,~r~n" + &
"    county_name=code_lookup_g.description,~r~n" + &
"    pd_address.contact_person,~r~n" + &
"    pd_address.tax_id,~r~n" + &
"    pd_address.tax_id_other_1,~r~n" + &
"    pd_address.tax_id_other_2,~r~n" + &
"    pd_address.business_mgr,~r~n" + &
"    pd_address.office_mgr,~r~n" + &
"    pd_address.e_mail_address,~r~n" + &
"    pd_address.web_address,~r~n" + &
"    pd_address.mon_from,~r~n" + &
"    pd_address.mon_to,~r~n" + &
"    pd_address.tue_from,~r~n" + &
"    pd_address.tue_to,~r~n" + &
"    pd_address.wed_from,~r~n" + &
"    pd_address.thu_from,~r~n" + &
"    pd_address.thu_to,~r~n" + &
"    pd_address.fri_from,~r~n" + &
"    pd_address.fri_to,~r~n" + &
"    pd_address.sat_from,~r~n" + &
"    pd_address.sat_to,~r~n" + &
"    pd_address.sun_from,~r~n" + &
"    pd_address.sun_to,~r~n" + &
"    pd_address.mon_from2,~r~n" + &
"    pd_address.mon_to2,~r~n" + &
"    pd_address.tue_from2,~r~n" + &
"    pd_address.tue_to2,~r~n" + &
"    pd_address.wed_from2,~r~n" + &
"    pd_address.wed_to2,~r~n" + &
"    pd_address.thu_from2,~r~n" + &
"    pd_address.thu_to2,~r~n" + &
"    pd_address.fri_from2,~r~n" + &
"    pd_address.fri_to2,~r~n" + &
"    pd_address.sat_from2,~r~n" + &
"    pd_address.sat_to2,~r~n" + &
"    pd_address.sun_from2,~r~n" + &
"    pd_address.sun_to2,~r~n" + &
"    pd_address.wed_to,~r~n" + &
"    pd_address.routine_visit_appt,~r~n" + &
"    pd_address.urgent_visit_appt,~r~n" + &
"    pd_address.emergency_visit_appt,~r~n" + &
"    pd_address.non_emergency_appt,~r~n" + &
"    young_child_code=code_lookup_h.code,~r~n" + &
"    child_code=code_lookup_i.code,~r~n" + &
"    adolescent_code=code_lookup_j.code,~r~n" + &
"    adult_code=code_lookup_k.code,~r~n" + &
"    senior_code=code_lookup_l.code,~r~n" + &
"    handicap_acc=code_lookup_m.description,~r~n" + &
"    on_public_trans=code_lookup_n.description,~r~n" + &
"    pd_address.cust_1,~r~n" + &
"    pd_address.cust_2,~r~n" + &
"    pd_address.cust_3,~r~n" + &
"    pd_address.cust_4,~r~n" + &
"    pd_address.cust_5,~r~n" + &
"    pd_address.cust_6,~r~n" + &
"    pd_address.street_2,~r~n" + &
"    pd_address.active_status,~r~n" + &
"    pd_address.accepting_new_patients,~r~n" + &
"    accepting_new_patient=code_lookup_p.description from~r~n" + &
"    pd_address left outer join code_lookup as code_lookup_b on pd_address.office_in_home = code_lookup_b.lookup_code left outer join code_lookup as code_lookup_d on pd_address.practice_type = code_lookup_d.lookup_code left outer join code_lookup as code_lookup_e on pd_address.state = code_lookup_e.lookup_code left outer join code_lookup as code_lookup_f on pd_address.country = code_lookup_f.lookup_code left outer join code_lookup as code_lookup_g on pd_address.county = code_lookup_g.lookup_code left outer join code_lookup as code_lookup_h on pd_address.young_child = code_lookup_h.lookup_code left outer join code_lookup as code_lookup_i on pd_address.child = code_lookup_i.lookup_code left outer join code_lookup as code_lookup_j on pd_address.adolescent = code_lookup_j.lookup_code left outer join code_lookup as code_lookup_k on pd_address.adult = code_lookup_k.lookup_code left outer join code_lookup as code_lookup_l on pd_address.senior_adult = code_lookup_l.lookup_code left outer join code_lookup as code_lookup_m on pd_address.handicapped_access = code_lookup_m.lookup_code left outer join code_lookup as code_lookup_n on pd_address.public_transportation = code_lookup_n.lookup_code left outer join code_lookup as code_lookup_p on pd_address.accepting_new_patients = code_lookup_p.lookup_code,~r~n" + &
"    pd_basic where~r~n" + &
"    (pd_address.prac_id = pd_basic.prac_id)~r~n" + &
"order by pd_address.rec_id,pd_address.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_address_link') + "~r~n" + &
"  as select " + ls_Title + " pd_address_link.address_id,~r~n" + &
"    pd_address_link.prac_id,~r~n" + &
"    pd_address_link.facility_id,~r~n" + &
"    pd_address_link.mailing,~r~n" + &
"    pd_address_link.billing,~r~n" + &
"    pd_address_link.contact_person,~r~n" + &
"    pd_address_link.include_in_directory,~r~n" + &
"    pd_address_link.exp_letters,~r~n" + &
"    pd_address_link.home_address,~r~n" + &
"    pd_address_link.additional_office,~r~n" + &
"    pd_address_link.primary_office from~r~n" + &
"    pd_address_link~r~n" + &
"order by pd_address_link.address_id,pd_address_link.prac_id,pd_address_link.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_address_lookup') + "~r~n" + &
"  as select distinct " + ls_Title + " address_lookup.lookup_code,~r~n" + &
"    address_lookup.lookup_name,~r~n" + &
"    address_lookup.code,~r~n" + &
"    address_lookup.entity_name,~r~n" + &
"    address_lookup.street1,~r~n" + &
"    address_lookup.street2,~r~n" + &
"    address_lookup.city,~r~n" + &
"    address_lookup.state,~r~n" + &
"    address_lookup.zip,~r~n" + &
"    address_lookup.country,~r~n" + &
"    address_lookup.phone,~r~n" + &
"    address_lookup.fax,~r~n" + &
"    address_lookup.email_address,~r~n" + &
"    address_lookup.web_address,~r~n" + &
"    address_lookup.custom_1,~r~n" + &
"    address_lookup.custom_2,~r~n" + &
"    address_lookup.custom_3,~r~n" + &
"    address_lookup.custom_4,~r~n" + &
"    address_lookup.custom_5,~r~n" + &
"    address_lookup.custom_6,~r~n" + &
"    address_lookup.contact_name,~r~n" + &
"    address_lookup.contact_salutation,~r~n" + &
"    address_lookup.fee from~r~n" + &
"    address_lookup~r~n" + &
"order by address_lookup.lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_dept') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + "~r~n" + &
"                      pd_affil_dept.rec_id, pd_affil_dept.prac_id, pd_affil_dept.facility_id, facility.facility_name, code_lookup_a.lookup_code AS dept_id, ~r~n" + &
"                      code_lookup_a.code AS dept_code, code_lookup_a.description AS dept_name, code_lookup_b.code AS section_code, ~r~n" + &
"                      code_lookup_b.description AS section_name, code_lookup_d.code AS division_code, code_lookup_d.description AS division_name, ~r~n" + &
"                      pd_affil_dept.primary_dept, pd_affil_dept.from_date, pd_affil_dept.to_date, pd_affil_dept.active_status, ~r~n" + &
"                      CASE WHEN pd_affil_dept.primary_dept = 1 THEN 'Yes' ELSE 'No' END AS primary_dept_description, ~r~n" + &
"                      CASE WHEN pd_affil_dept.primary_dept = 1 THEN 'Y' ELSE 'N' END AS primary_dept_code~r~n" + &
"FROM         pd_affil_dept INNER JOIN~r~n" + &
"                      facility ON pd_affil_dept.facility_id = facility.facility_id INNER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_affil_dept.department = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_affil_dept.[section] = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_affil_dept.rank = code_lookup_d.lookup_code~r~n" + &
"ORDER BY pd_affil_dept.rec_id, pd_affil_dept.prac_id, pd_affil_dept.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_staff_cat') + "~r~n" + &
"  as select " + ls_Title + " pd_affil_staff_cat.rec_id,~r~n" + &
"    pd_affil_staff_cat.prac_id,~r~n" + &
"    pd_affil_staff_cat.facility_id,~r~n" + &
"    facility.facility_name,~r~n" + &
"    pd_affil_staff_cat.seq_no,~r~n" + &
"    code_lookup.code,~r~n" + &
"    code_lookup.description,~r~n" + &
"    pd_affil_staff_cat.from_date,~r~n" + &
"    pd_affil_staff_cat.to_date,~r~n" + &
"    pd_affil_staff_cat.active_status,~r~n" + &
"    pd_affil_staff_cat.requested from(~r~n" + &
"    pd_affil_staff_cat left outer join code_lookup on pd_affil_staff_cat.staff_category = code_lookup.lookup_code),~r~n" + &
"    facility where~r~n" + &
"    (pd_affil_staff_cat.facility_id = facility.facility_id)~r~n" + &
"order by pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id,pd_affil_staff_cat.facility_id,pd_affil_staff_cat.seq_no~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_staff_cat_active') + "~r~n" + &
"as select " + ls_Title + " pd_affil_staff_cat.rec_id,~r~n" + &
"pd_affil_staff_cat.prac_id,~r~n" + &
"pd_affil_staff_cat.facility_id,~r~n" + &
"facility.facility_name,~r~n" + &
"pd_affil_staff_cat.seq_no,~r~n" + &
"code_lookup.code as staff_cat_code,~r~n" + &
"code_lookup.description as staff_cat,~r~n" + &
"pd_affil_staff_cat.from_date,~r~n" + &
"pd_affil_staff_cat.to_date,~r~n" + &
"pd_affil_staff_cat.active_status,~r~n" + &
"pd_affil_staff_cat.requested ~r~n" + &
"from pd_affil_staff_cat,~r~n" + &
"code_lookup,facility ~r~n" + &
"where(pd_affil_staff_cat.facility_id = facility.facility_id) and(pd_affil_staff_cat.staff_category = code_lookup.lookup_code) ~r~n" + &
"and(pd_affil_staff_cat.requested = 1) and(pd_affil_staff_cat.active_status in(1,4))~r~n" + &
"order by pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id,pd_affil_staff_cat.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_stat') + "~r~n" + &
"  as select " + ls_Title + " pd_affil_stat.rec_id,~r~n" + &
"    pd_affil_stat.prac_id,~r~n" + &
"    pd_affil_stat.parent_facility_id,~r~n" + &
"    pd_affil_stat.verifying_facility as verifying_facility_id,~r~n" + &
"    facility_a.facility_name as parent_facility_name,~r~n" + &
"    facility_b.facility_name as verifying_facility_name,~r~n" + &
"    facility_c.facility_name as app_audit_facility_name,~r~n" + &
"    pd_affil_stat.apptmnt_type,~r~n" + &
"    pd_affil_stat.affiliation_status,~r~n" + &
"    pd_affil_stat.apptmnt_start_date,~r~n" + &
"    pd_affil_stat.apptmnt_end_date,~r~n" + &
"    pd_affil_stat.date_rqst_rcvd,~r~n" + &
"    pd_affil_stat.date_app_sent,~r~n" + &
"    pd_affil_stat.date_app_signed,~r~n" + &
"    pd_affil_stat.date_app_rcvd,~r~n" + &
"    pd_affil_stat.date_rls_form_exp,~r~n" + &
"    pd_affil_stat.date_app_audit_completed,~r~n" + &
"    pd_affil_stat.date_data_entry_completed,~r~n" + &
"    pd_affil_stat.date_verif_completed,~r~n" + &
"    pd_affil_stat.date_comm_review_completed as date_completed,~r~n" + &
"    pd_affil_stat.affil_ended,~r~n" + &
"    code_lookup.code as affil_ended_code,~r~n" + &
"    code_lookup.description as affil_ended_desc,~r~n" + &
"    pd_affil_stat.init_prov_period_from,~r~n" + &
"    pd_affil_stat.init_prov_period_to,pd_affil_stat.staff_category,~r~n" + &
"    pd_affil_stat.active_status,pd_affil_stat.fee,~r~n" + &
"    pd_affil_stat.date_invoiced,pd_affil_stat.date_paid,~r~n" + &
"    pd_affil_stat.priority,pd_affil_stat.priority_user,~r~n" + &
"    pd_affil_stat.custom_1,~r~n" + &
"    pd_affil_stat.custom_2,~r~n" + &
"    pd_affil_stat.custom_3,~r~n" + &
"    pd_affil_stat.custom_4,~r~n" + &
"    pd_affil_stat.custom_5,~r~n" + &
"    pd_affil_stat.prov_status,~r~n" + &
"    pd_affil_stat.prior_appt_start,~r~n" + &
"    pd_affil_stat.prior_appt_end,~r~n" + &
"    pd_affil_stat.appt_note,~r~n" + &
"    pd_affil_stat.inital_appmnt_date from~r~n" + &
"    pd_affil_stat left outer join code_lookup on pd_affil_stat.affil_ended_reason = code_lookup.lookup_code,~r~n" + &
"    facility as facility_a,~r~n" + &
"    facility as facility_b,~r~n" + &
"    facility as facility_c~r~n" + &
"where~r~n" + &
"    (facility_a.facility_id = pd_affil_stat.parent_facility_id) and~r~n" + &
"    (facility_b.facility_id = pd_affil_stat.verifying_facility) and~r~n" + &
"    (facility_c.facility_id = pd_affil_stat.application_audit_facility)~r~n" + &
"order by pd_affil_stat.rec_id,pd_affil_stat.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_app_audit') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + " pd_app_audit.record_id, pd_app_audit.prac_id, pd_app_audit.facility_id, pd_app_audit.seq_no, pd_app_audit.app_audit_id, ~r~n" + &
"                      pd_app_audit.completed, pd_app_audit.date_completed, pd_app_audit.active_status, pd_app_audit.data_status, ~r~n" + &
"                      pd_app_audit.identifying_number, pd_app_audit.appt_stat_id, code_lookup.description AS status~r~n" + &
"FROM         pd_app_audit LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_app_audit.data_status = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_app_audit.record_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_app_audit_attempts') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + " record_id, prac_id, facility_id, seq_no, date_attempted, user_name, method, notes, active_status~r~n" + &
"FROM         pd_app_audit_attempts~r~n" + &
"ORDER BY record_id, prac_id, facility_id, seq_no~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_attest_questions') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_attest_questions.rec_id, pd_attest_questions.prac_id, pd_attest_questions.question_id, cl_quest_type.code AS question_type_code, ~r~n" + &
"                      cl_quest_type.description AS question_type_description, question_lookup.short_quest, question_lookup.full_quest, ~r~n" + &
"                      pd_attest_questions.answer_code AS answer_lookup_code, cl_answer.code AS answer_code, cl_answer.description AS answer_description, ~r~n" + &
"                      pd_attest_questions.active_status, CASE WHEN pd_attest_questions.active_status = 1 THEN 'Yes' ELSE 'No' END AS active_status_description, ~r~n" + &
"                      pd_attest_questions.facility_id, facility.facility_name, pd_attest_questions.explain_yes~r~n" + &
"FROM  pd_attest_questions INNER JOIN question_lookup ON pd_attest_questions.question_id = question_lookup.quest_id ~r~n" + &
"INNER JOIN   facility ON facility.facility_id = pd_attest_questions.facility_id ~r~n" + &
"INNER JOIN code_lookup cl_answer ON cl_answer.lookup_code = pd_attest_questions.answer_code ~r~n" + &
"inner join code_lookup cl_quest_type ON  cl_quest_type.lookup_code = question_lookup.quest_type~r~n" + &
"ORDER BY pd_attest_questions.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_audit_trail') + "~r~n" + &
"  as(select " + ls_Title + " sys_audit.rec_id,~r~n" + &
"    sys_audit.field_id,~r~n" + &
"    sys_audit.seq_no,~r~n" + &
"    sys_audit.table_id,~r~n" + &
"    sys_audit.prac_id,~r~n" + &
"    sys_audit.old_value,~r~n" + &
"    sys_audit.new_value,~r~n" + &
"    sys_audit.user_id,~r~n" + &
"    sys_audit.date_time_modified,~r~n" + &
"    sys_fields.field_name,~r~n" + &
"    sys_fields.field_name_allias,~r~n" + &
"    sys_tables.table_name_allias,~r~n" + &
"    v_full_name.full_name,~r~n" + &
"    sys_audit.exported,~r~n" + &
"    sys_audit.export_date,~r~n" + &
"    sys_audit.facility_id,~r~n" + &
"    sys_audit.audit_type from~r~n" + &
"    sys_audit left outer join sys_fields on sys_audit.field_id = sys_fields.field_id,~r~n" + &
"    sys_tables,~r~n" + &
"    v_full_name ~r~n" + &
"where (sys_audit.prac_id = v_full_name.prac_id) and~r~n" + &
"    (sys_audit.table_id = sys_tables.table_id)~r~n" + &
"order by sys_audit.rec_id,sys_audit.field_id,sys_audit.seq_no)~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_basic') + "~r~n" + &
"  as select " + ls_Title + " pd_basic.rec_id,~r~n" + &
"    pd_basic.prac_id,~r~n" + &
"    pd_basic.first_name,~r~n" + &
"    pd_basic.last_name,~r~n" + &
"    pd_basic.middle_name,~r~n" + &
"    pd_basic.title,~r~n" + &
"    code_lookup_a.code as title_code,~r~n" + &
"    code_lookup_a.description as title_description,~r~n" + &
"    pd_basic.name_suffix,~r~n" + &
"    code_lookup_b.code as name_suffix_code,~r~n" + &
"    code_lookup_b.description as name_suffix_description,~r~n" + &
"    pd_basic.prof_suffix,~r~n" + &
"    code_lookup_c.code as prof_suffix_code,~r~n" + &
"    code_lookup_c.description as prof_suffix_description,~r~n" + &
"    pd_basic.date_of_birth,~r~n" + &
"    pd_basic.ssn,~r~n" + &
"    pd_basic.sex,~r~n" + &
"    code_lookup_d.code as sex_code,~r~n" + &
"    code_lookup_d.description as sex_description,~r~n" + &
"    pd_basic.prac_category,~r~n" + &
"    code_lookup_e.code as prac_category_code,~r~n" + &
"    code_lookup_e.description as prac_category_description,~r~n" + &
"    pd_basic.maiden_other_name,~r~n" + &
"    pd_basic.pob_city,~r~n" + &
"    pd_basic.pob_state,~r~n" + &
"    code_lookup_f.code as state_code,~r~n" + &
"    code_lookup_f.description as state_description,~r~n" + &
"    pd_basic.pob_country,~r~n" + &
"    code_lookup_g.code as pob_country_code,~r~n" + &
"    code_lookup_g.description as pob_country_description,~r~n" + &
"    pd_basic.citizenship,~r~n" + &
"    code_lookup_h.code as citizenship_code,~r~n" + &
"    pd_basic.married,~r~n" + &
"    code_lookup_i.code as married_code,~r~n" + &
"    pd_basic.spouse_name,~r~n" + &
"    pd_basic.phone,~r~n" + &
"    pd_basic.answering_service,~r~n" + &
"    pd_basic.beeper_1,~r~n" + &
"    pd_basic.beeper_2,~r~n" + &
"    pd_basic.personal_pager,~r~n" + &
"    pd_basic.hospital_pager,~r~n" + &
"    pd_basic.car_phone_1,~r~n" + &
"    pd_basic.car_phone_2,~r~n" + &
"    pd_basic.civilian_fed_employee,~r~n" + &
"    code_lookup_j.code as civilian_fed_employee_code,~r~n" + &
"    pd_basic.active_military,~r~n" + &
"    code_lookup_k.code as active_military_code,~r~n" + &
"    pd_basic.reservist,~r~n" + &
"    code_lookup_l.code as reservist_code,~r~n" + &
"    pd_basic.branch,~r~n" + &
"    pd_basic.rank,~r~n" + &
"    pd_basic.service_number,~r~n" + &
"    pd_basic.service_date_from,~r~n" + &
"    pd_basic.service_date_to,~r~n" + &
"    pd_basic.cust_1,~r~n" + &
"    pd_basic.cust_2,~r~n" + &
"    pd_basic.cust_3,~r~n" + &
"    pd_basic.cust_5,~r~n" + &
"    pd_basic.cust_6,~r~n" + &
"    pd_basic.cust_7,~r~n" + &
"    pd_basic.cust_8,~r~n" + &
"    pd_basic.cust_9,~r~n" + &
"    pd_basic.cust_10,~r~n" + &
"    pd_basic.full_name,~r~n" + &
"    pd_basic.npdb_query,~r~n" + &
"    pd_basic.provider_id,~r~n" + &
"    pd_basic.provider_type,~r~n" + &
"    code_lookup_m.code as provider_type_code,~r~n" + &
"    code_lookup_m.description as provider_type_description,~r~n" + &
"    pd_basic.cust_4,~r~n" + &
"    pd_basic.oig_query~r~n" + &
"from~r~n" + &
"    pd_basic LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON pd_basic.title = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_basic.name_suffix = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_basic.prof_suffix = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_basic.sex = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON pd_basic.prac_category = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_f ON pd_basic.pob_state = code_lookup_f.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_g ON pd_basic.pob_country = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_h ON pd_basic.citizenship = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_i ON pd_basic.married = code_lookup_i.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_j ON pd_basic.civilian_fed_employee = code_lookup_j.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_k ON pd_basic.active_military = code_lookup_k.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_l ON pd_basic.reservist = code_lookup_l.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_m ON pd_basic.provider_type = code_lookup_m.lookup_code~r~n" + &
"order by pd_basic.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_basic_info') + "~r~n" + &
"  as select " + ls_Title + " pd_basic.rec_id,~r~n" + &
"    pd_basic.prac_id,~r~n" + &
"    pd_basic.first_name,~r~n" + &
"    pd_basic.middle_name,~r~n" + &
"    pd_basic.last_name,~r~n" + &
"    code_lookup_a.code as title_code,~r~n" + &
"    code_lookup_a.description as title_description,~r~n" + &
"    code_lookup_b.code as name_suffix_code,~r~n" + &
"    code_lookup_b.description as name_suffix_description,~r~n" + &
"    code_lookup_c.code as prof_suffix_code,~r~n" + &
"    code_lookup_c.description as prof_suffix_description,~r~n" + &
"    pd_basic.date_of_birth,~r~n" + &
"    pd_basic.ssn,~r~n" + &
"    code_lookup_d.code as gender_code,~r~n" + &
"    code_lookup_d.description as gender_description,~r~n" + &
"    code_lookup_e.code as prac_category_code,~r~n" + &
"    code_lookup_e.description as prac_category_description,~r~n" + &
"    pd_basic.provider_id,~r~n" + &
"    code_lookup_f.code as provider_type_code,~r~n" + &
"    code_lookup_f.description as provider_type_description,~r~n" + &
"    pd_basic.maiden_other_name,~r~n" + &
"    pd_basic.cust_1,~r~n" + &
"    pd_basic.cust_2,~r~n" + &
"    pd_basic.cust_3,~r~n" + &
"    pd_basic.cust_4,~r~n" + &
"    pd_basic.cust_5,~r~n" + &
"    pd_basic.cust_6,~r~n" + &
"    pd_basic.cust_7,~r~n" + &
"    pd_basic.cust_8,~r~n" + &
"    pd_basic.cust_9,~r~n" + &
"    pd_basic.cust_10~r~n" + &
"from~r~n" + &
"    pd_basic LEFT OUTER JOIN ~r~n" + &
"    code_lookup as code_lookup_a ON pd_basic.title = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_basic.name_suffix = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_basic.prof_suffix = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_basic.sex = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON pd_basic.prac_category = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_f ON pd_basic.provider_type = code_lookup_f.lookup_code~r~n" + &
"order by rec_id,prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_billing_address') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pa.rec_id AS practice_address_id, ba.rec_id AS billing_address_id, ba.prac_id, pd_basic.first_name + ' ' + pd_basic.last_name AS practitioner, ~r~n" + &
"                      code_lookup_b.code AS office_in_home, code_lookup_d.code AS prac_type_code, code_lookup_d.description AS prac_type, ba.street, ba.street_2, ~r~n" + &
"                      ba.city, code_lookup_e.code AS state_code, code_lookup_e.description AS state_name, code_lookup_f.code AS country_code, ~r~n" + &
"                      code_lookup_f.description AS country_name, ba.pager_number, ba.phone, ba.ext, ba.fax, ba.zip, code_lookup_g.code AS county_code, ~r~n" + &
"                      code_lookup_g.description AS county_name, ba.contact_person, ba.tax_id, ba.tax_id_other_1, ba.tax_id_other_2, ba.business_mgr, ba.office_mgr, ~r~n" + &
"                      ba.e_mail_address, ba.web_address, ba.mon_from, ba.mon_to, ba.tue_from, ba.tue_to, ba.wed_from, ba.thu_from, ba.thu_to, ba.fri_from, ba.fri_to, ~r~n" + &
"                      ba.sat_from, ba.sat_to, ba.sun_from, ba.sun_to, ba.mon_from2, ba.mon_to2, ba.tue_from2, ba.tue_to2, ba.wed_from2, ba.wed_to2, ba.thu_from2, ~r~n" + &
"                      ba.thu_to2, ba.fri_from2, ba.fri_to2, ba.sat_from2, ba.sat_to2, ba.sun_from2, ba.sun_to2, ba.wed_to, ba.routine_visit_appt, ba.urgent_visit_appt, ~r~n" + &
"                      ba.emergency_visit_appt, ba.non_emergency_appt, code_lookup_h.code AS young_child_code, code_lookup_i.code AS child_code, ~r~n" + &
"                      code_lookup_j.code AS adolescent_code, code_lookup_k.code AS adult_code, code_lookup_l.code AS senior_code, ~r~n" + &
"                      code_lookup_m.description AS handicap_acc, code_lookup_n.description AS on_public_trans, ba.cust_1, ba.cust_2, ba.cust_3, ba.cust_4, ba.cust_5, ~r~n" + &
"                      ba.cust_6, ba.cust_7, ba.cust_8, ba.cust_9, ba.cust_10, ba.cust_d1, ba.cust_d2, ba.active_status, ba.accepting_new_patients, ~r~n" + &
"                      code_lookup_p.description AS accepting_new_patient, ba.gp_id, code_lookup_q.description AS send_corresp_here, ba.suite_apart~r~n" + &
"FROM         pd_address pa LEFT OUTER JOIN~r~n" + &
"                      pd_basic ON pa.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      pd_address ba ON CASE WHEN pa.billing_address_id = 0 THEN pa.rec_id ELSE pa.billing_address_id END = ba.rec_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON ba.office_in_home = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON ba.practice_type = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_e ON ba.state = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_f ON ba.country = code_lookup_f.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_g ON ba.county = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_h ON ba.young_child = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_i ON ba.child = code_lookup_i.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_j ON ba.adolescent = code_lookup_j.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_k ON ba.adult = code_lookup_k.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_l ON ba.senior_adult = code_lookup_l.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_m ON ba.handicapped_access = code_lookup_m.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_n ON ba.public_transportation = code_lookup_n.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_p ON ba.accepting_new_patients = code_lookup_p.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_q ON ba.send_corresp_here = code_lookup_q.lookup_code~r~n" + &
"WHERE     (pa.billing_address_id <> - 1)~r~n" + &
"ORDER BY pa.rec_id,pa.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_board_specialty') + "~r~n" + &
"as select " + ls_Title + " pd_board_specialty.rec_id,~r~n" + &
"    pd_board_specialty.prac_id,~r~n" + &
"    pd_board_specialty.specialty,~r~n" + &
"    code_lookup_a.code as specialty_code,~r~n" + &
"    code_lookup_a.description as specialty_description,~r~n" + &
"    address_lookup.code as board_code,~r~n" + &
"    address_lookup.entity_name as board_name,~r~n" + &
"    pd_board_specialty.eligible_until,~r~n" + &
"    pd_board_specialty.initial_certification,~r~n" + &
"    pd_board_specialty.last_recertification,~r~n" + &
"    pd_board_specialty.certification_expires,~r~n" + &
"    pd_board_specialty.certification_number,~r~n" + &
"    pd_board_specialty.required_year_completion,~r~n" + &
"    pd_board_specialty.cust_1,~r~n" + &
"    pd_board_specialty.cust_2,~r~n" + &
"    pd_board_specialty.cust_3,~r~n" + &
"    pd_board_specialty.cust_4,~r~n" + &
"    pd_board_specialty.cust_5,~r~n" + &
"    code_lookup_b.description as exam_taken,~r~n" + &
"    code_lookup_c.description as active_process,~r~n" + &
"    code_lookup_d.description as ever_failed,~r~n" + &
"    code_lookup_e.description as specialty_order from~r~n" + &
"    pd_board_specialty left outer join address_lookup on pd_board_specialty.board_code = address_lookup.lookup_code left outer join code_lookup as code_lookup_b on pd_board_specialty.exam_taken = code_lookup_b.lookup_code left outer join code_lookup as code_lookup_c on pd_board_specialty.active_cert_process = code_lookup_c.lookup_code left outer join code_lookup as code_lookup_d on pd_board_specialty.ever_failed_cert = code_lookup_d.lookup_code left outer join code_lookup as code_lookup_e on pd_board_specialty.specialty_order = code_lookup_e.lookup_code,~r~n" + &
"    code_lookup as code_lookup_a where~r~n" + &
"    (pd_board_specialty.specialty = code_lookup_a.lookup_code)~r~n" + &
"order by pd_board_specialty.rec_id,pd_board_specialty.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_claims') + "~r~n" + &
"as select " + ls_Title + " pd_claims.rec_id,pd_claims.prac_id,pd_claims.case_number,pd_claims.claimant,status_code=code_lookup.code,status_descripton=code_lookup.description,pd_claims.nature_of_claim,pd_claims.date_closed,pd_claims.date_of_incident,pd_claims.case_role,pd_claims.other_role,pd_claims.amt_attrib_you,pd_claims.adj_set_dis,pd_claims.amount_paid,pd_claims.date_last_contact,pd_claims.date_initiated,pd_claims.practice_role,pd_claims.practice_other,pd_claims.alleged_malpractice,pd_claims.alleged_harm,pd_claims.patient_illness,pd_claims.other_details,pd_claims.date_claimed_filed,pd_claims.carrier,pd_claims.cust_1,pd_claims.cust_2,pd_claims.cust_3,pd_claims.cust_4,pd_claims.cust_5 from(pd_claims left outer join code_lookup on pd_claims.status_code = code_lookup.lookup_code) order by pd_claims.rec_id,pd_claims.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_clinical_specialties') + "~r~n" + &
"as select " + ls_Title + " pd_clinical_specialties.rec_id,pd_clinical_specialties.prac_id,rank_code=code_lookup.code,rank_description=code_lookup.description,pd_clinical_specialties.specialty_expertise,pd_clinical_specialties.cust_1,pd_clinical_specialties.cust_2,pd_clinical_specialties.cust_3,pd_clinical_specialties.cust_4,pd_clinical_specialties.cust_5 from(pd_clinical_specialties left outer join code_lookup on pd_clinical_specialties.rank = code_lookup.lookup_code) order by pd_clinical_specialties.rec_id,pd_clinical_specialties.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_code_lookup') + "~r~n" + &
"  as select " + ls_Title + " lookup_code,~r~n" + &
"    lookup_name as table_name,~r~n" + &
"    code,~r~n" + &
"    description,~r~n" + &
"    custom_1,~r~n" + &
"    custom_2,~r~n" + &
"    custom_3,~r~n" + &
"    custom_4,~r~n" + &
"    custom_5,~r~n" + &
"    custom_6 from~r~n" + &
"    code_lookup~r~n" + &
"order by lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_code_lookup_1') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     lookup_code, lookup_name AS table_name, code, description, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, caqh_code, ic_n, ~r~n" + &
"                      ic_c~r~n" + &
"FROM         code_lookup~r~n" + &
"ORDER BY lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_code_lookup_2') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     lookup_code, lookup_name AS table_name, code, description, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, caqh_code, ic_n, ~r~n" + &
"                      ic_c~r~n" + &
"FROM         code_lookup~r~n" + &
"ORDER BY lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_committee_lookup') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     committee_id, facility_id, committee_name~r~n" + &
"FROM         committee_lookup~r~n" + &
"ORDER BY committee_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_committee_review') + "~r~n" + &
"as select " + ls_Title + " pd_comm_review.rec_id,pd_comm_review.prac_id,pd_comm_review.facility_id,facility_name=facility.facility_name,committee_name=committee_lookup.committee_name,pd_comm_review.date_sent_for_review,pd_comm_review.date_back_from_review,review_result_code=code_lookup_a.code,review_result_name=code_lookup_a.description,pd_comm_review.active_status from(pd_comm_review left outer join code_lookup as code_lookup_a on pd_comm_review.review_results = code_lookup_a.lookup_code),committee_lookup,facility where(pd_comm_review.facility_id = facility.facility_id) and(pd_comm_review.committee_id = committee_lookup.committee_id) order by pd_comm_review.rec_id,pd_comm_review.facility_id,pd_comm_review.committee_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_continue_education') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_postgrad_train.prac_id, pd_postgrad_train.subject, pd_postgrad_train.date_from, pd_postgrad_train.date_thru, ~r~n" + &
"                      pd_postgrad_train.loc_city, code_lookup_a.code AS loc_state_code, code_lookup_a.description AS loc_state_description, ~r~n" + &
"                      pd_postgrad_train.loc_zip, pd_postgrad_train.loc_country, pd_postgrad_train.hours, code_lookup_b.code AS category_code, ~r~n" + &
"                      code_lookup_b.description AS category_description, pd_postgrad_train.sponsor, pd_postgrad_train.street, pd_postgrad_train.city, ~r~n" + &
"                      code_lookup_c.code AS state_code, code_lookup_c.description AS state_description, pd_postgrad_train.zip, code_lookup_d.code AS country_code,~r~n" + &
"                       code_lookup_d.description AS country_description, pd_postgrad_train.program_director, pd_postgrad_train.cust_1, ~r~n" + &
"                      pd_postgrad_train.cust_2, pd_postgrad_train.cust_3, pd_postgrad_train.cust_4, pd_postgrad_train.cust_5, ~r~n" + &
"                      pd_postgrad_train.cust_6, pd_postgrad_train.cust_7, pd_postgrad_train.cust_8, pd_postgrad_train.cust_9, ~r~n" + &
"                      pd_postgrad_train.cust_10, pd_postgrad_train.cust_d1, pd_postgrad_train.cust_d2~r~n" + &
"FROM         pd_postgrad_train LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_postgrad_train.country = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_postgrad_train.category = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_c ON pd_postgrad_train.state = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_postgrad_train.loc_state = code_lookup_a.lookup_code~r~n" + &
"ORDER BY pd_postgrad_train.rec_id,pd_postgrad_train.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_contract') + "~r~n" + &
"as select " + ls_Title + " pd_contract.rec_id,pd_contract.prac_id,group_plan_code=address_lookup.code,group_plan_description=address_lookup.entity_name,sub_group_code=code_lookup_a.code,sub_group_description=code_lookup_a.description,catagory_code=code_lookup_b.code,catagory_description=code_lookup_b.description,pd_contract.start_date,pd_contract.end_date,reason_code=code_lookup_c.code,reason_description=code_lookup_c.description,pd_contract.mco_provider_id,pd_contract.cust_1,pd_contract.cust_2,pd_contract.cust_3,pd_contract.cust_4,pd_contract.cust_5 from((((pd_contract left outer join address_lookup on pd_contract.group_plan = address_lookup.lookup_code) left outer join code_lookup as code_lookup_a on pd_contract.sub_group_plan = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_contract.category = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on pd_contract.reason = code_lookup_c.lookup_code) order by pd_contract.rec_id,pd_contract.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_cpr_certification') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_cpr_certifiation.rec_id, pd_cpr_certifiation.prac_id, pd_cpr_certifiation.bls_expires, pd_cpr_certifiation.acls_expires, ~r~n" + &
"                      pd_cpr_certifiation.atls_expires, pd_cpr_certifiation.cust_1, pd_cpr_certifiation.cust_2, pd_cpr_certifiation.cust_3, ~r~n" + &
"                      pd_cpr_certifiation.cust_4, pd_cpr_certifiation.cust_5, pd_cpr_certifiation.cust_6, pd_cpr_certifiation.cust_7, ~r~n" + &
"                      pd_cpr_certifiation.cust_8, pd_cpr_certifiation.cust_9, pd_cpr_certifiation.cust_10, pd_cpr_certifiation.cust_d1, ~r~n" + &
"                      pd_cpr_certifiation.cust_d2, pd_cpr_certifiation.cert_type AS cert_type_lookup_code, code_lookup.code AS cert_type_code, ~r~n" + &
"                      code_lookup.description AS cert_type_description, code_lookup_1.description AS certified~r~n" + &
"FROM         pd_cpr_certifiation INNER JOIN~r~n" + &
"                      code_lookup ON pd_cpr_certifiation.cert_type = code_lookup.lookup_code INNER JOIN~r~n" + &
"                      code_lookup code_lookup_1 ON pd_cpr_certifiation.certified = code_lookup_1.lookup_code~r~n" + &
"ORDER BY pd_cpr_certifiation.rec_id, pd_cpr_certifiation.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_info') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, ~r~n" + &
"app_facility.facility_name AS Company_Name, ~r~n" + &
"code_lookup.code AS Contract_Category_code, ~r~n" + &
"code_lookup.description AS Contract_Category_description, ~r~n" + &
"code_lookup_1.code AS Contract_Status_code, ~r~n" + &
"code_lookup_2.code AS contract_type_code, ~r~n" + &
"code_lookup_2.description AS contract_type_Description, ~r~n" + &
"CTX_BASIC_INFO.effective_date, ~r~n" + &
"CTX_BASIC_INFO.expriation_date, ~r~n" + &
"CTX_BASIC_INFO.review_date, ~r~n" + &
"CTX_BASIC_INFO.review_by, ~r~n" + &
"CTX_BASIC_INFO.term_date, ~r~n" + &
"code_lookup_3.code AS term_reason_code, ~r~n" + &
"code_lookup_3.description AS term_Reason_Desciption, ~r~n" + &
"CTX_BASIC_INFO.other_date_1, ~r~n" + &
"CTX_BASIC_INFO.other_date_2, ~r~n" + &
"CTX_BASIC_INFO.notes, ~r~n" + &
"CTX_BASIC_INFO.custom_1, ~r~n" + &
"CTX_BASIC_INFO.custom_2, ~r~n" + &
"CTX_BASIC_INFO.custom_3, ~r~n" + &
"CTX_BASIC_INFO.custom_4, ~r~n" + &
"CTX_BASIC_INFO.custom_5, ~r~n" + &
"CTX_BASIC_INFO.custom_6, ~r~n" + &
"CTX_BASIC_INFO.custom_7, ~r~n" + &
"CTX_BASIC_INFO.custom_8, ~r~n" + &
"CTX_BASIC_INFO.custom_9, ~r~n" + &
"CTX_BASIC_INFO.custom_10, ~r~n" + &
"CTX_BASIC_INFO.last_revis_date, ~r~n" + &
"code_lookup_4.description AS product_type_desc, ~r~n" + &
"code_lookup_4.code AS product_type_code, ~r~n" + &
"code_lookup_5.code AS product_code, ~r~n" + &
"code_lookup_5.description AS product_description, ~r~n" + &
"code_lookup_6.code as dvision_code, ~r~n" + &
"code_lookup_6.description as dvision_description~r~n" + &
"FROM (((((((CTX_BASIC_INFO ~r~n" + &
"LEFT OUTER JOIN code_lookup ON CTX_BASIC_INFO.category = code_lookup.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_BASIC_INFO.status = code_lookup_1.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_BASIC_INFO.contract_type = code_lookup_2.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_BASIC_INFO.term_reason = code_lookup_3.lookup_code) ~r~n" + &
"INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id) ~r~n" + &
"INNER JOIN ctx_products ON CTX_BASIC_INFO.ctx_id = ctx_products.ctx_id) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code~r~n" + &
"left outer join code_lookup as code_lookup_6 on CTX_BASIC_INFO.dvision = code_lookup_6.lookup_code~r~n" + &
"order by CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_info_alarms') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_NOTIFICATION_USERS.user_id, CTX_NOTIFICATION.alm_message, CTX_NOTIFICATION.alm_enabled, CTX_NOTIFICATION.alm_notification_days, CTX_NOTIFICATION.alm_last_notification_sent, CTX_NOTIFICATION.alm_post_notification_days, CTX_NOTIFICATION.alm_total_tries, CTX_NOTIFICATION.alm_action_item_posted, CTX_NOTIFICATION.alm_total_tries_counter, CTX_NOTIFICATION.alm_frequency, CTX_NOTIFICATION.create_action_item FROM ((CTX_BASIC_INFO LEFT OUTER JOIN CTX_NOTIFICATION ON CTX_BASIC_INFO.ctx_id = CTX_NOTIFICATION.ctx_id) INNER JOIN CTX_NOTIFICATION_USERS ON CTX_BASIC_INFO.ctx_id = CTX_NOTIFICATION_USERS.ctx_id) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_NOTIFICATION_USERS.user_id, CTX_NOTIFICATION.alm_message, CTX_NOTIFICATION.alm_enabled, CTX_NOTIFICATION.alm_notification_days, CTX_NOTIFICATION.alm_last_notification_sent, CTX_NOTIFICATION.alm_post_notification_days, CTX_NOTIFICATION.alm_total_tries, CTX_NOTIFICATION.alm_action_item_posted, CTX_NOTIFICATION.alm_total_tries_counter, CTX_NOTIFICATION.alm_frequency, CTX_NOTIFICATION.create_action_item ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_products') + "~r~n" + &
"as SELECT " + ls_Title + " ctx_products.ctx_id,        code_lookup_4.description AS product_type_desc,        code_lookup_4.code AS product_type_code,        code_lookup_5.code AS product_code,        code_lookup_5.description AS product_description FROM (ctx_products LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code)                    LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code ORDER BY ctx_products.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_without_products') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id,        app_facility.facility_name,         code_lookup.code AS Contract_Category_code,        code_lookup.description AS Contract_Category_description,        code_lookup_1.code AS Contract_Status_code,        code_lookup_2.code AS contract_type_code,        code_lookup_2.description AS contract_type_Description,        CTX_BASIC_INFO.effective_date,        CTX_BASIC_INFO.expriation_date,        CTX_BASIC_INFO.review_date,        CTX_BASIC_INFO.review_by,        CTX_BASIC_INFO.term_date,        code_lookup_3.code AS term_reason_code,        code_lookup_3.description AS term_Reason_Desciption,        CTX_BASIC_INFO.other_date_1,        CTX_BASIC_INFO.other_date_2,        CTX_BASIC_INFO.notes,        CTX_BASIC_INFO.custom_1,        CTX_BASIC_INFO.custom_2,        CTX_BASIC_INFO.custom_3,        CTX_BASIC_INFO.custom_4,        CTX_BASIC_INFO.custom_5,        CTX_BASIC_INFO.custom_6,        CTX_BASIC_INFO.custom_7,        CTX_BASIC_INFO.custom_8,        CTX_BASIC_INFO.custom_9,        CTX_BASIC_INFO.custom_10,        CTX_BASIC_INFO.last_revis_date        FROM ((((CTX_BASIC_INFO                         LEFT OUTER JOIN code_lookup ON CTX_BASIC_INFO.category = code_lookup.lookup_code)                         LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_BASIC_INFO.status = code_lookup_1.lookup_code)                         LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_BASIC_INFO.contract_type = code_lookup_2.lookup_code)                         LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_BASIC_INFO.term_reason = code_lookup_3.lookup_code)                         INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_contacts_contacts') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code aS contract_type_code, code_lookup.description AS contract_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, code_lookup_4.description as contact_title, code_lookup_1.code AS contract_department_code, code_lookup_1.description AS contract_department_description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code AS state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code AS Phone_Type_code, code_lookup_3.description AS Phone_type_Description, '(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.notes FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.notes, CTX_CONTRACT_CONTACTS.ic_area HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='c')) ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_contacts_external') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code aS contract_type_code, code_lookup.description AS contract_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, code_lookup_4.description as contact_title, code_lookup_1.code AS contract_department_code, code_lookup_1.description AS contract_department_description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code AS state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code AS Phone_Type_code, code_lookup_3.description AS Phone_type_Description, '(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone , CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.ic_area HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='e')) ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_contacts_internal') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code aS contract_type_code, code_lookup.description AS contract_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, code_lookup_4.description as contact_title, code_lookup_1.code AS contract_department_code, code_lookup_1.description AS contract_department_description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code AS state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code AS Phone_Type_code, code_lookup_3.description AS Phone_type_Description, '(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone , CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.ic_area HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='i')) ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_custom') + "~r~n" + &
"AS SELECT " + ls_Title + " ctx_id, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6,        custom_7, custom_8, custom_9, custom_10, custom_11, custom_12, custom_13,        custom_14, custom_15, custom_16, custom_17, custom_18, custom_19, custom_20,        custom_date1, custom_date2, custom_date3, custom_date4, custom_date5,        custom_date6, custom_date7, custom_date8, custom_date9, custom_date10,        custom_date11, custom_date12, custom_date13, custom_date14, custom_date15,        custom_n1, custom_n2, custom_n3, custom_n4, custom_n5, custom_n6, custom_n7,        custom_n8, custom_n9, custom_n10 FROM CTX_BASIC_INFO ORDER BY ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_fee_schedule') + "~r~n" + &
"as select " + ls_Title + " CTX_FEE_SCHED_HDR.ctx_id, code_lookup.description as carve_out_type, code_lookup_1.description as sched_type, CTX_FEE_SCHED_HDR.custom_1, cTX_FEE_SCHED_HDR.custom_2, CTX_FEE_SCHED_HDR.custom_3, CTX_FEE_SCHED_HDR.custom_4, CTX_FEE_SCHED_HDR.custom_5, CTX_FEE_SCHED_HDR.notes from(CTX_FEE_SCHED_HDR left outer join code_lookup on CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) left outer join code_lookup as code_lookup_1 on CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code order by CTX_FEE_SCHED_HDR.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_fee_schedule_NM') + "~r~n" + &
"as~r~n" + &
"SELECT " + ls_Title + " ~r~n" + &
"	CTX_FEE_SCHED_NM.ctx_id, ~r~n" + &
"	code_lookup.code AS category_code, ~r~n" + &
"	code_lookup.description AS category_description,~r~n" + &
" 	code_lookup_1.code AS system_item_code, ~r~n" + &
"	code_lookup_1.description AS system_item_Description,~r~n" + &
" 	CTX_FEE_SCHED_NM.description, ~r~n" + &
"	code_lookup_2.code AS item_status_code, ~r~n" + &
"	CTX_FEE_SCHED_NM.start_date,~r~n" + &
" 	CTX_FEE_SCHED_NM.end_date, ~r~n" + &
"	CTX_FEE_SCHED_NM.service_name, ~r~n" + &
"	CTX_FEE_SCHED_NM.custom_int1,~r~n" + &
" 	CTX_FEE_SCHED_NM.custom_int2, ~r~n" + &
"	CTX_FEE_SCHED_NM.custom_fee1, ~r~n" + &
"	CTX_FEE_SCHED_NM.custom_fee2,~r~n" + &
" 	CTX_FEE_SCHED_NM.custom_fee3, ~r~n" + &
"	CTX_FEE_SCHED_NM.custom_text1, ~r~n" + &
"	CTX_FEE_SCHED_NM.custom_text2,~r~n" + &
" 	CTX_FEE_SCHED_NM.custom_text3, ~r~n" + &
"	CTX_FEE_SCHED_NM.notes, ~r~n" + &
"	code_lookup_3.code AS billing_Cycle, ~r~n" + &
"	code_lookup_3.description AS billing_cycle_description~r~n" + &
"FROM~r~n" + &
"(((CTX_FEE_SCHED_NM LEFT OUTER JOIN~r~n" + &
"code_lookup ON CTX_FEE_SCHED_NM.category = code_lookup.lookup_code) LEFT OUTER JOIN~r~n" + &
"code_lookup AS code_lookup_1 ON CTX_FEE_SCHED_NM.service_item = code_lookup_1.lookup_code) LEFT OUTER JOIN~r~n" + &
"code_lookup AS code_lookup_2 ON CTX_FEE_SCHED_NM.item_status = code_lookup_2.lookup_code) LEFT OUTER JOIN~r~n" + &
"code_lookup AS code_lookup_3 ON CTX_FEE_SCHED_NM.billing_cycle = code_lookup_3.lookup_code~r~n" + &
"ORDER BY CTX_FEE_SCHED_NM.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_feee_schedule_codes') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_FEE_SCHED_HDR.ctx_id, CTX_FEE_SCHED_DATA.code, code_lookup.description AS carve_out_type_description, code_lookup_1.description AS sched_type_description, code_lookup_2.description AS location_description, code_lookup_2.code AS location_code, code_lookup_3.description AS status, CTX_FEE_SCHED_DATA.fee, CTX_FEE_SCHED_DATA.effective_date, CTX_FEE_SCHED_DATA.expiration_date, CTX_FEE_SCHED_DATA.office_fee, CTX_FEE_SCHED_DATA.facility_fee, CTX_FEE_SCHED_DATA.custom_fee, CTX_FEE_SCHED_DATA.precert, CTX_FEE_SCHED_DATA.preauth, CTX_FEE_SCHED_DATA.base_price, CTX_FEE_SCHED_DATA.phys_fee, CTX_FEE_SCHED_DATA.custom_1, CTX_FEE_SCHED_DATA.custom_2, CTX_FEE_SCHED_DATA.custom_3, CTX_FEE_SCHED_DATA.custom_4, CTX_FEE_SCHED_DATA.custom_5, CTX_FEE_SCHED_DATA.fee_basis, CTX_FEE_SCHED_DATA.inserted_by_user, CTX_FEE_SCHED_DATA.inserted_at_date_time, CTX_FEE_SCHED_DATA.updated_by_user, CTX_FEE_SCHED_DATA.updated_at_date_time FROM (CTX_FEE_SCHED_DATA INNER JOIN ((((CTX_FEE_SCHED_HDR LEFT OUTER JOIN code_lookup ON CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code) INNER JOIN CTX_FEE_SCHED_LOCATIONS ON CTX_FEE_SCHED_HDR.fee_sched_id = CTX_FEE_SCHED_LOCATIONS.fee_sched_id) INNER JOIN code_lookup AS code_lookup_2 ON CTX_FEE_SCHED_LOCATIONS.location = code_lookup_2.lookup_code) ON CTX_FEE_SCHED_DATA.fee_sched_location_id = CTX_FEE_SCHED_LOCATIONS.fee_sched_location_id) INNER JOIN code_lookup AS code_lookup_3 ON CTX_FEE_SCHED_DATA.status = code_lookup_3.lookup_code GROUP BY CTX_FEE_SCHED_HDR.ctx_id, CTX_FEE_SCHED_DATA.code, code_lookup.description, code_lookup_1.description, code_lookup_2.description, code_lookup_2.code, code_lookup_3.description, CTX_FEE_SCHED_DATA.fee, CTX_FEE_SCHED_DATA.effective_date, CTX_FEE_SCHED_DATA.expiration_date, CTX_FEE_SCHED_DATA.office_fee, CTX_FEE_SCHED_DATA.facility_fee, CTX_FEE_SCHED_DATA.custom_fee, CTX_FEE_SCHED_DATA.precert, CTX_FEE_SCHED_DATA.preauth, CTX_FEE_SCHED_DATA.base_price, CTX_FEE_SCHED_DATA.phys_fee, CTX_FEE_SCHED_DATA.custom_1, CTX_FEE_SCHED_DATA.custom_2, CTX_FEE_SCHED_DATA.custom_3, CTX_FEE_SCHED_DATA.custom_4, CTX_FEE_SCHED_DATA.custom_5, CTX_FEE_SCHED_DATA.fee_basis, CTX_FEE_SCHED_DATA.inserted_by_user, CTX_FEE_SCHED_DATA.inserted_at_date_time, CTX_FEE_SCHED_DATA.updated_by_user, CTX_FEE_SCHED_DATA.updated_at_date_time HAVING (((CTX_FEE_SCHED_DATA.fee)<>0)) ORDER BY CTX_FEE_SCHED_HDR.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_feee_schedule_locations') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_FEE_SCHED_HDR.ctx_id, code_lookup.description AS carve_out_type, code_lookup_1.description AS sched_type, code_lookup_2.description AS location_description, code_lookup_2.code AS location_code, CTX_FEE_SCHED_LOCATIONS.rate, CTX_FEE_SCHED_LOCATIONS.fee_bonus, CTX_ITEM.item_name AS fee_basis FROM ((((CTX_FEE_SCHED_HDR LEFT OUTER JOIN code_lookup ON CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code) INNER JOIN CTX_FEE_SCHED_LOCATIONS ON CTX_FEE_SCHED_HDR.fee_sched_id = CTX_FEE_SCHED_LOCATIONS.fee_sched_id) INNER JOIN code_lookup AS code_lookup_2 ON CTX_FEE_SCHED_LOCATIONS.location = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_ITEM ON CTX_FEE_SCHED_LOCATIONS.fee_bonus = CTX_ITEM.item_id ORDER BY CTX_FEE_SCHED_HDR.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_feee_schedule_practitioners') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_FEE_SCHED_HDR.ctx_id, code_lookup.description AS carve_out_type, code_lookup_1.description AS sched_type, pd_basic.last_name, pd_basic.first_name, pd_basic.prac_id FROM (((CTX_FEE_SCHED_HDR LEFT OUTER JOIN code_lookup ON CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code) INNER JOIN CTX_FEE_SCHED_PRACS ON CTX_FEE_SCHED_HDR.fee_sched_id = CTX_FEE_SCHED_PRACS.fee_sched_id) INNER JOIN pd_basic ON CTX_FEE_SCHED_PRACS.practitioner_id = pd_basic.prac_id ORDER BY CTX_FEE_SCHED_HDR.fee_sched_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_groups') + "~r~n" + &
"as select " + ls_Title + " CTX_LOC.ctx_id, app_facility.facility_name, group_multi_loc.gp_name, CTX_LOC.parent_comp_id, group_multi_loc.rec_id, group_multi_loc.street1, group_multi_loc.city, group_multi_loc.state, group_multi_loc.phone, group_multi_loc.zip, group_multi_loc.contact_name from((group_multi_loc join CTX_LOC on group_multi_loc.rec_id = CTX_LOC.parent_comp_id) join CTX_BASIC_INFO on CTX_LOC.ctx_id = CTX_BASIC_INFO.ctx_id) join app_facility on CTX_BASIC_INFO.app_facility = app_facility.facility_id group by CTX_LOC.ctx_id,app_facility.facility_name,group_multi_loc.gp_name,CTX_LOC.parent_comp_id,group_multi_loc.rec_id,group_multi_loc.street1,group_multi_loc.city,group_multi_loc.state,group_multi_loc.phone,group_multi_loc.zip,group_multi_loc.contact_name order by CTX_LOC.ctx_id,CTX_LOC.parent_comp_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_groups_locations') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_LOC.ctx_id, app_facility.facility_name, group_multi_loc.gp_name, CTX_LOC.parent_comp_id AS grp_id, CTX_LOC.loc_id, group_practice.practice_type, group_practice.active_status, group_practice.street AS location_name, group_practice.street_2, group_practice.city, code_lookup_1.code AS state, code_lookup.description AS country, group_practice.pager_number, group_practice.phone, group_practice.ext, group_practice.fax, group_practice.zip, group_practice.contact_person, group_practice.e_mail_address, group_practice.web_address FROM (((((group_multi_loc INNER JOIN CTX_LOC ON group_multi_loc.rec_id = CTX_LOC.parent_comp_id) INNER JOIN CTX_BASIC_INFO ON CTX_LOC.ctx_id = CTX_BASIC_INFO.ctx_id) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id) INNER JOIN group_practice ON CTX_LOC.loc_id = group_practice.rec_id) LEFT OUTER JOIN code_lookup ON group_practice.country = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON group_practice.state = code_lookup_1.lookup_code GROUP BY CTX_LOC.ctx_id, app_facility.facility_name, group_multi_loc.gp_name, CTX_LOC.parent_comp_id, CTX_LOC.loc_id, group_practice.practice_type, group_practice.active_status, group_practice.street, group_practice.street_2, group_practice.city, code_lookup_1.code, code_lookup.description, group_practice.pager_number, group_practice.phone, group_practice.ext, group_practice.fax, group_practice.zip, group_practice.contact_person, group_practice.e_mail_address, group_practice.web_address ORDER BY CTX_LOC.ctx_id,CTX_LOC.parent_comp_id,CTX_LOC.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_image') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     CTX_IMAGES.ctx_id, CTX_IMAGES.file_name, code_lookup.description AS Image_Type, code_lookup_1.description AS media_type, ~r~n" + &
"                      CTX_IMAGES.page_description, CTX_IMAGE.image_version, CTX_IMAGE.inserted_by_user, CTX_IMAGE.updated_by_user, ~r~n" + &
"                      CTX_IMAGE.inserted_at_date_time, CTX_IMAGE.updated_at_date_time~r~n" + &
"FROM         CTX_IMAGE INNER JOIN~r~n" + &
"                      CTX_IMAGES ON CTX_IMAGE.ctx_id = CTX_IMAGES.ctx_id AND CTX_IMAGE.image_id = CTX_IMAGES.image_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON CTX_IMAGES.image_type = code_lookup.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_1 ON CTX_IMAGES.media_type = code_lookup_1.lookup_code~r~n" + &
"ORDER BY CTX_IMAGES.image_id,CTX_IMAGES.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_locations_pracs') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_LOC.ctx_id, CTX_LOC.parent_comp_id AS grp_id, group_practice.street AS locatioin_name, CTX_LOC.loc_id, pd_basic.last_name, pd_basic.first_name, pd_basic.prac_id FROM ((CTX_LOC INNER JOIN CTX_LOCATION_PRACS ON (CTX_LOC.ctx_id = CTX_LOCATION_PRACS.ctx_id) AND (CTX_LOC.parent_comp_id = CTX_LOCATION_PRACS.parent_comp_id) AND (CTX_LOC.loc_id = CTX_LOCATION_PRACS.loc_id)) INNER JOIN pd_basic ON CTX_LOCATION_PRACS.prac_id = pd_basic.prac_id) INNER JOIN group_practice ON CTX_LOCATION_PRACS.loc_id = group_practice.rec_id GROUP BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id, group_practice.street, CTX_LOC.loc_id, pd_basic.last_name, pd_basic.first_name, pd_basic.prac_id HAVING (((CTX_LOC.loc_id)<>0)) ORDER BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id,CTX_LOC.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_locations_speciality') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_LOC.ctx_id, CTX_LOC.parent_comp_id AS grp_id, group_practice.street AS location_name, CTX_LOC.loc_id, code_lookup.description AS specialty_description, code_lookup.code AS speciality_code FROM ((CTX_LOC INNER JOIN CTX_LOCATION_SPECIALTY ON (CTX_LOC.loc_id = CTX_LOCATION_SPECIALTY.loc_id) AND (CTX_LOC.parent_comp_id = CTX_LOCATION_SPECIALTY.parent_comp_id) AND (CTX_LOC.ctx_id = CTX_LOCATION_SPECIALTY.ctx_id)) INNER JOIN code_lookup ON CTX_LOCATION_SPECIALTY.Prac_specialty = code_lookup.lookup_code) INNER JOIN group_practice ON CTX_LOCATION_SPECIALTY.loc_id = group_practice.rec_id GROUP BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id, group_practice.street, CTX_LOC.loc_id, code_lookup.description, code_lookup.code HAVING (((CTX_LOC.loc_id)<>0)) ORDER BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id,CTX_LOC.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_organizations') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_ORGS_CONTACT.ctx_id, CTX_ORGS.org_name, code_lookup.code AS org_type_code, code_lookup.description AS org_type_description, CTX_ORGS.status, CTX_ORGS.street_1, CTX_ORGS.street_2, CTX_ORGS.street_3, CTX_ORGS.city, code_lookup_1.code AS state, CTX_ORGS.zip, CTX_ORGS_CONTACT.notes, CTX_ORGS.drections, CTX_ORGS.record_id, CTX_ORG_CONTACT.contact_name, CTX_ORG_CONTACT.department, code_lookup_2.code AS phone_type_code, CTX_ORG_CONTACT.phone FROM ((((CTX_ORGS LEFT OUTER JOIN code_lookup ON CTX_ORGS.org_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_ORGS.state = code_lookup_1.lookup_code) INNER JOIN CTX_ORGS_CONTACT ON CTX_ORGS.org_id = CTX_ORGS_CONTACT.org_id) LEFT OUTER JOIN CTX_ORG_CONTACT ON CTX_ORGS.org_id = CTX_ORG_CONTACT.org_id) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_ORG_CONTACT.via = code_lookup_2.lookup_code GROUP BY CTX_ORGS_CONTACT.ctx_id, CTX_ORGS.org_name, code_lookup.code, code_lookup.description, CTX_ORGS.status, CTX_ORGS.street_1, CTX_ORGS.street_2, CTX_ORGS.street_3, CTX_ORGS.city, code_lookup_1.code, CTX_ORGS.zip, CTX_ORGS_CONTACT.notes, CTX_ORGS.drections, CTX_ORGS.record_id, CTX_ORG_CONTACT.contact_name, CTX_ORG_CONTACT.department, code_lookup_2.code, CTX_ORG_CONTACT.phone ORDER BY CTX_ORGS_CONTACT.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_requirement') + "~r~n" + &
"AS SELECT " + ls_Title + " CTX_REQ_PROFILE_HDR_1.ctx_id,	~r~n" + &
"CTX_RQMNT_CATEGORY.category_name,	~r~n" + &
"CTX_REQ_PROFILE.rqmnt_name,	~r~n" + &
"CTX_REQ_PROFILE.rqmnt_description,	~r~n" + &
"CTX_REQ_TMPLT_ELEMENT.element_name,	~r~n" + &
"DataValue = (case ctx_req_tmplt_element.value_type when 1 then CTX_ELEMENTS.date_value when 2 then CTX_ELEMENTS.field_value when 3 then CTX_ELEMENTS.char_value when 4 then CTX_ELEMENTS.integer_value when 5 then CTX_ELEMENTS.field_value end),~r~n" + &
"CTX_ELEMENTS.clause ~r~n" + &
"FROM (CTX_RQMNT_CATEGORY ~r~n" + &
"INNER JOIN ((CTX_REQ_PROFILE INNER JOIN CTX_REQ_PROFILE_HDR AS CTX_REQ_PROFILE_HDR_1 ON CTX_REQ_PROFILE.ctx_req_profile_id = CTX_REQ_PROFILE_HDR_1.ctx_req_profile_id) ~r~n" + &
"INNER JOIN CTX_REQ_TMPLT_ELEMENT ON  CTX_REQ_PROFILE.ctx_req_profile_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_profile_id) ~r~n" + &
"ON (CTX_RQMNT_CATEGORY.ctx_req_profile_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_profile_id) AND (CTX_RQMNT_CATEGORY.ctx_rqmnt_category_id = CTX_REQ_TMPLT_ELEMENT.ctx_rqmnt_category_id)) ~r~n" + &
"INNER JOIN CTX_ELEMENTS ON (CTX_ELEMENTS.ctx_req_tmplt_element_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_tmplt_element_id) AND (CTX_REQ_PROFILE_HDR_1.ctx_id = CTX_ELEMENTS.CTX_REQ_PROFILE_HDR_id) ~r~n" + &
"ORDER BY CTX_REQ_PROFILE_HDR_1.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_dea') + "~r~n" + &
"  as select " + ls_Title + " pd_dea_state_csr.rec_id,~r~n" + &
"    pd_dea_state_csr.prac_id,~r~n" + &
"    pd_dea_state_csr.cat_1,~r~n" + &
"    pd_dea_state_csr.cat_2,~r~n" + &
"    pd_dea_state_csr.cat_3,~r~n" + &
"    pd_dea_state_csr.cat_4,~r~n" + &
"    pd_dea_state_csr.cat_5,~r~n" + &
"    pd_dea_state_csr.cat_6,~r~n" + &
"    pd_dea_state_csr.cat_7,~r~n" + &
"    pd_dea_state_csr.cat_8,~r~n" + &
"    pd_dea_state_csr.cat_9,~r~n" + &
"    pd_dea_state_csr.cat_10,~r~n" + &
"    code_lookup.code as state_code,~r~n" + &
"    code_lookup.description as state_desc,~r~n" + &
"    pd_dea_state_csr.prev_exp_date,~r~n" + &
"    pd_dea_state_csr.expiration_date,~r~n" + &
"    pd_dea_state_csr.cust_1,~r~n" + &
"    pd_dea_state_csr.cust_2,~r~n" + &
"    pd_dea_state_csr.cust_3,~r~n" + &
"    pd_dea_state_csr.cust_4,~r~n" + &
"    pd_dea_state_csr.cust_5,~r~n" + &
"    pd_dea_state_csr.license_number,~r~n" + &
"    pd_dea_state_csr.active_status from~r~n" + &
"    pd_dea_state_csr left outer join~r~n" + &
"    code_lookup on~r~n" + &
"    pd_dea_state_csr.state = code_lookup.lookup_code~r~n" + &
"order by pd_dea_state_csr.rec_id,pd_dea_state_csr.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_dea_state_csr') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_dea_state_csr.rec_id, pd_dea_state_csr.prac_id, pd_dea_state_csr.cat_1, pd_dea_state_csr.cat_2, pd_dea_state_csr.cat_3, ~r~n" + &
"                      pd_dea_state_csr.cat_4, pd_dea_state_csr.cat_5, pd_dea_state_csr.cat_6, pd_dea_state_csr.cat_7, pd_dea_state_csr.cat_8, ~r~n" + &
"                      pd_dea_state_csr.cat_9, pd_dea_state_csr.cat_10, code_lookup.code, code_lookup.description, ~r~n" + &
"                      pd_dea_state_csr.prev_exp_date, pd_dea_state_csr.expiration_date, pd_dea_state_csr.cust_1, pd_dea_state_csr.cust_2, ~r~n" + &
"                      pd_dea_state_csr.cust_3, pd_dea_state_csr.cust_4, pd_dea_state_csr.cust_5, pd_dea_state_csr.license_number, ~r~n" + &
"                      pd_dea_state_csr.active_status, pd_dea_state_csr.cust_6, pd_dea_state_csr.cust_7, pd_dea_state_csr.cust_8, ~r~n" + &
"                      pd_dea_state_csr.cust_9, pd_dea_state_csr.cust_10, pd_dea_state_csr.cust_d1, pd_dea_state_csr.cust_d2, ~r~n" + &
"                      pd_dea_state_csr.issue_date, code_lookup.code AS state_code, code_lookup.description AS state_description~r~n" + &
"FROM         pd_dea_state_csr LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_dea_state_csr.state = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_dea_state_csr.rec_id, pd_dea_state_csr.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_dept') + "~r~n" + &
"  as select distinct " + ls_Title + " pd_affil_dept.rec_id,~r~n" + &
"    pd_affil_dept.prac_id,~r~n" + &
"    pd_affil_dept.facility_id,~r~n" + &
"    facility.facility_name as facility_name,~r~n" + &
"    code_lookup_a.code as dept_code,~r~n" + &
"    code_lookup_a.description as dept_name,~r~n" + &
"    code_lookup_b.code as section_code,~r~n" + &
"    code_lookup_b.description as section_name,~r~n" + &
"    code_lookup_d.code as division_code,~r~n" + &
"    code_lookup_d.description as division_name,~r~n" + &
"    pd_affil_dept.primary_dept,~r~n" + &
"    pd_affil_dept.from_date,~r~n" + &
"    pd_affil_dept.to_date,~r~n" + &
"    pd_affil_dept.record_status,~r~n" + &
"    pd_affil_dept.active_status ~r~n" + &
"from pd_affil_dept left outer join code_lookup as code_lookup_b on (pd_affil_dept.section = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on (pd_affil_dept.memberships = code_lookup_c.lookup_code) left outer join code_lookup as code_lookup_d on (pd_affil_dept.rank = code_lookup_d.lookup_code) left outer join facility on (pd_affil_dept.facility_id = facility.facility_id) left outer join code_lookup as code_lookup_a on (pd_affil_dept.department = code_lookup_a.lookup_code)~r~n" + &
"order by pd_affil_dept.rec_id,pd_affil_dept.prac_id,pd_affil_dept.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ecfmg') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     prac_id, date_issued, date_expires, ecfmg_number, cust_1, cust_2, cust_4, cust_3, cust_5, cust_6, cust_7, cust_8, cust_9, cust_10, cust_d1, ~r~n" + &
"                      cust_d2~r~n" + &
"FROM         pd_ecfmg~r~n" + &
"ORDER BY rec_id,prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_education') + "~r~n" + &
"as select " + ls_Title + " pd_education.rec_id,pd_education.prac_id,ed_type_code=code_lookup_a.code,ed_type_description=code_lookup_a.description,degree_code=code_lookup_b.code,degree_description=code_lookup_b.description,pd_education.major,pd_education.month_from,pd_education.year_from,pd_education.month_thru,pd_education.year_thru,school_code=address_lookup.code,school_name=address_lookup.entity_name,pd_education.cust_1,pd_education.cust_2,pd_education.cust_3,pd_education.cust_4,pd_education.cust_5 from(((pd_education left outer join code_lookup as code_lookup_a on pd_education.education_type = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_education.degree = code_lookup_b.lookup_code) left outer join address_lookup on pd_education.school_code = address_lookup.lookup_code) order by pd_education.rec_id,pd_education.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_full_name') + "~r~n" + &
"AS~r~n" + &
"SELECT  " + ls_Title + " title = code_lookup_1.code,~r~n" + &
"title_description = code_lookup_1.description,~r~n" + &
"first_name, middle_name, last_name,~r~n" + &
"prof_suffix = code_lookup_2.code,~r~n" + &
"prof_suffix_descp = code_lookup_2.description,~r~n" + &
"gemder = code_lookup_3.description,~r~n" + &
"SUBSTRING(ISNULL(ssn, ''), 1, 3) ~r~n" + &
"                      + '-' + SUBSTRING(ISNULL(ssn, ''), 4, 2) + '-' + SUBSTRING(ISNULL(ssn, ''), 6, 4) AS ssn, LTRIM(RTRIM(ISNULL(last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(first_name, '') + ' ' + SUBSTRING(ISNULL(middle_name, ''), 1, 1) + CASE WHEN isnull(pd_basic.middle_name, '') ~r~n" + &
"                      = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL(code_lookup_4.code,''))) + CASE WHEN isnull~r~n" + &
"                          (code_lookup_4.code,'') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          (code_lookup_2.code,''))) AS full_name,~r~n" + &
"prac_id,~r~n" + &
"date_of_birth,~r~n" + &
"rec_id,~r~n" + &
"cust_1,~r~n" + &
"cust_2,~r~n" + &
"cust_3,~r~n" + &
"cust_4,~r~n" + &
"cust_5,~r~n" + &
"cust_11,~r~n" + &
"cust_12,~r~n" + &
"cust_13,~r~n" + &
"cust_14,~r~n" + &
"cust_15,~r~n" + &
"cust_d1,~r~n" + &
"cust_d2~r~n" + &
"FROM    pd_basic ~r~n" + &
"                   left outer join code_lookup code_lookup_1 on (pd_basic.title = code_lookup_1.lookup_code)~r~n" + &
"                   left outer join code_lookup code_lookup_2 on (pd_basic.prof_suffix = code_lookup_2.lookup_code)~r~n" + &
"                   left outer join code_lookup code_lookup_3 on (pd_basic.sex = code_lookup_3.lookup_code)~r~n" + &
"                   left outer join code_lookup code_lookup_4 on (pd_basic.name_suffix = code_lookup_4.lookup_code)~r~n" + &
"order by rec_id,prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_fullbasic') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + "~r~n" + &
"                      pd_basic.prac_id, pd_basic.first_name, pd_basic.last_name, pd_basic.middle_name, pd_basic.date_of_birth, pd_basic.ssn, ~r~n" + &
"                      pd_basic.maiden_other_name, pd_basic.pob_city, pd_basic.spouse_name, pd_basic.phone, pd_basic.answering_service, ~r~n" + &
"                      pd_basic.beeper_1, pd_basic.beeper_2, pd_basic.personal_pager, pd_basic.hospital_pager, pd_basic.car_phone_1, ~r~n" + &
"                      pd_basic.car_phone_2, pd_basic.branch, pd_basic.rank, pd_basic.service_number, pd_basic.service_date_from, ~r~n" + &
"                      pd_basic.service_date_to, pd_basic.cust_1, pd_basic.cust_2, pd_basic.cust_3, pd_basic.cust_5, pd_basic.cust_6, ~r~n" + &
"                      pd_basic.cust_7, pd_basic.cust_8, pd_basic.cust_9, pd_basic.cust_10, pd_basic.full_name, pd_basic.provider_id, ~r~n" + &
"                      pd_basic.cust_4, pd_basic.conv_prac_id, code_lookup_a.code AS title_a_code, code_lookup_a.description AS title_a_description, ~r~n" + &
"                      code_lookup_b.code AS name_suffic_b_code, code_lookup_b.description AS name_suffic_b_description, code_lookup_e.code AS prac_cat_e_code, ~r~n" + &
"                      code_lookup_e.description AS prac_Cat_e_description, code_lookup_g.code AS county_g_code, code_lookup_g.description AS county_g_description, ~r~n" + &
"                      code_lookup_c.code AS prof_suffix_c_code, code_lookup_c.description AS prof_suffix_c_description, code_lookup_f.code AS state_f_code, ~r~n" + &
"                      code_lookup_f.description AS state_f_description, code_lookup_i.code AS married_i_code, code_lookup_h.code AS citizens_h_code, ~r~n" + &
"                      code_lookup_d.code AS sex_d_code, code_lookup_d.description AS sex_d_description, code_lookup_k.code AS military_k_code, ~r~n" + &
"                      code_lookup_l.code AS reserve_l_code, code_lookup_j.code AS fed_emp_j_code, code_lookup_m.code AS npdb_m_code, ~r~n" + &
"                      code_lookup_n.code AS prov_type_n_code, code_lookup_n.description AS prov_type_n_description, code_lookup_o.code AS oig_o_code, ~r~n" + &
"                      pd_basic.cust_11, pd_basic.cust_12, pd_basic.cust_13, pd_basic.cust_14, pd_basic.cust_15, pd_basic.cust_d1, ~r~n" + &
"                      pd_basic.cust_d2, pd_basic.npi_number, pd_basic.used_another_name, pd_basic.start_another_name, ~r~n" + &
"                      pd_basic.end_another_name~r~n" + &
"FROM         pd_basic LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_basic.title = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_basic.name_suffix = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_c ON pd_basic.prof_suffix = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_basic.sex = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_e ON pd_basic.prac_category = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_f ON pd_basic.pob_state = code_lookup_f.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_g ON pd_basic.pob_country = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_h ON pd_basic.citizenship = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_i ON pd_basic.married = code_lookup_i.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_j ON pd_basic.civilian_fed_employee = code_lookup_j.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_k ON pd_basic.active_military = code_lookup_k.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_l ON pd_basic.reservist = code_lookup_l.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_m ON pd_basic.npdb_query = code_lookup_m.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_n ON pd_basic.provider_type = code_lookup_n.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_o ON pd_basic.oig_query = code_lookup_o.lookup_code~r~n" + &
"ORDER BY pd_basic.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_covering_partners') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_partner_covering.rec_id, gp_partner_covering.gp_id, gp_partner_covering.prac_id, cl_title.code AS title_code, ~r~n" + &
"                      cl_title.description AS title_description, gp_partner_covering.last_name, gp_partner_covering.first_name, ~r~n" + &
"                      cl_provider_type.code AS provider_type_code, cl_provider_type.description AS provider_type_description, cl_specialty.code AS specialty_code, ~r~n" + &
"                      cl_specialty.description AS specialty_description, cl_covering.code AS covering_code, cl_covering.description AS covering_description, ~r~n" + &
"                      cl_partner.code AS partner_code, cl_partner.description AS partner_description, gp_partner_covering.license_no AS license_number, ~r~n" + &
"                      cl_license_state.code AS license_state_code, cl_license_state.description AS license_state_description, gp_partner_covering.cust_1, ~r~n" + &
"                      gp_partner_covering.cust_2, gp_partner_covering.cust_3, gp_partner_covering.cust_d4, gp_partner_covering.cust_d5, ~r~n" + &
"                      gp_partner_covering.specialty, gp_partner_covering.provider_type, gp_partner_covering.covering, gp_partner_covering.partner, ~r~n" + &
"                      gp_partner_covering.title_code AS Expr1, gp_partner_covering.middle_name~r~n" + &
"FROM    gp_partner_covering left outer join  code_lookup cl_covering on (cl_covering.lookup_code = gp_partner_covering.covering )~r~n" + &
"left outer join  code_lookup cl_title ON cl_title.lookup_code = gp_partner_covering.title_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_license_state ON gp_partner_covering.license_state = cl_license_state.lookup_code~r~n" + &
"LEFT OUTER JOIN code_lookup cl_partner ON gp_partner_covering.partner = cl_partner.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_provider_type ON gp_partner_covering.provider_type = cl_provider_type.lookup_code ~r~n" + &
"left outer join code_lookup cl_specialty ON cl_specialty.lookup_code = gp_partner_covering.specialty~r~n" + &
"ORDER BY gp_partner_covering.rec_id, gp_partner_covering.gp_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_insurance') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_insurance.rec_id, gp_insurance.gp_id, gp_insurance.carrier_code, address_lookup.entity_name AS carrier, ~r~n" + &
"                      gp_insurance.policy_number, gp_insurance.coverage_from, gp_insurance.coverage_to, gp_insurance.previous_expiration_date, ~r~n" + &
"                      gp_insurance.tail_coverage, cl_tail_coverage.code AS tail_coverage_code, cl_tail_coverage.description AS tail_coverage_description, ~r~n" + &
"                      gp_insurance.coverage_limit_from, gp_insurance.coverage_limit_to, gp_insurance.state_funded_pool, ~r~n" + &
"                      cl_state_funded.code AS state_funded_pool_code, cl_state_funded.description AS state_funded_pool_description, gp_insurance.state_coverage, ~r~n" + &
"                      cl_state_coverage.code AS state_coverage_code, cl_state_coverage.description AS state_coverage_description, gp_insurance.exclusions, ~r~n" + &
"                      gp_insurance.cust_1, gp_insurance.cust_2, gp_insurance.cust_3, gp_insurance.cust_d4, gp_insurance.cust_d5, ~r~n" + &
"                      gp_insurance.claims_made_occurrence, gp_insurance.denied_explain, gp_insurance.active_status, gp_insurance.prac_id~r~n" + &
"FROM         gp_insurance LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state_coverage ON gp_insurance.state_coverage = cl_state_coverage.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state_funded ON gp_insurance.state_funded_pool = cl_state_funded.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_tail_coverage ON gp_insurance.tail_coverage = cl_tail_coverage.lookup_code LEFT OUTER JOIN~r~n" + &
"                      address_lookup ON gp_insurance.carrier_code = address_lookup.lookup_code~r~n" + &
"ORDER BY gp_insurance.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_languages') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_language.rec_id, gp_language.gp_id, gp_language.prac_id, cl_language.code AS language_code, ~r~n" + &
"                      cl_language.description AS language_description, cl_speak.code AS speak_code, cl_speak.description AS speak_description, ~r~n" + &
"                      cl_reads.code AS reads_code, cl_reads.description AS reads_description, cl_writes.code AS writes_code, cl_writes.description AS writes_description, ~r~n" + &
"                      cl_sign.code AS sign_code, cl_sign.description AS sign_description, gp_language.cust_1, gp_language.cust_2, gp_language.cust_3, ~r~n" + &
"                      gp_language.cust_d4, gp_language.cust_d5, gp_language.foreign_language AS [language], gp_language.speak, ~r~n" + &
"                      gp_language.reads, gp_language.writes, gp_language.sign~r~n" + &
"FROM code_lookup cl_sign INNER JOIN gp_language ON cl_sign.lookup_code = gp_language.sign~r~n" + &
"INNER JOIN code_lookup cl_speak ON cl_speak.lookup_code = gp_language.speak ~r~n" + &
"INNER JOIN code_lookup cl_language ON gp_language.foreign_language = cl_language.lookup_code ~r~n" + &
"INNER JOIN code_lookup cl_reads ON gp_language.reads = cl_reads.lookup_code ~r~n" + &
"INNER JOIN code_lookup cl_writes ON gp_language.writes = cl_writes.lookup_code ~r~n" + &
"ORDER BY gp_language.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_other_ids') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_other_ids.rec_id, gp_other_ids.gp_id, gp_other_ids.prac_id, code_lookup.code AS id_type_code, ~r~n" + &
"                      code_lookup.description AS id_type_description, gp_other_ids.id_number, gp_other_ids.exp_date, gp_other_ids.cust_1, ~r~n" + &
"                      gp_other_ids.cust_2, gp_other_ids.cust_3, gp_other_ids.cust_d4, gp_other_ids.cust_d5, gp_other_ids.id_type~r~n" + &
"FROM         gp_other_ids INNER JOIN~r~n" + &
"                      code_lookup ON gp_other_ids.id_type = code_lookup.lookup_code~r~n" + &
"ORDER BY gp_other_ids.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_plans') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     rec_id, gp_id, plan_id, active_status, start_date, end_date, prac_id~r~n" + &
"FROM         gp_plans~r~n" + &
"ORDER BY rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_practice_info') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_practice_info.rec_id, gp_practice_info.gp_id, gp_practice_info.prac_id, gp_practice_info.corporate_name, ~r~n" + &
"                      gp_practice_info.start_date, gp_practice_info.check_payable, gp_practice_info.billing_dept, ~r~n" + &
"                      cl_after_hours_coverage.description AS after_hours_coverage, cl_after_hours_type.description AS after_hours_type, ~r~n" + &
"                      gp_practice_info.after_hours_number, cl_pref_contact_method.description AS preferred_contact_method, ~r~n" + &
"                      cl_primary_tax_id.description AS primary_tax_id, cl_gender_limitations.description AS gender_limitations, gp_practice_info.min_age, ~r~n" + &
"                      gp_practice_info.max_age, gp_practice_info.other_limitations, gp_practice_info.other_handi_access, ~r~n" + &
"                      gp_practice_info.other_disability_service, gp_practice_info.other_trans_access, gp_practice_info.cust_1, gp_practice_info.cust_2, ~r~n" + &
"                      gp_practice_info.cust_3, gp_practice_info.cust_4, gp_practice_info.cust_5, gp_practice_info.cust_d1, ~r~n" + &
"                      gp_practice_info.cust_d2~r~n" + &
"FROM    gp_practice_info LEFT OUTER JOIN code_lookup cl_after_hours_coverage ON cl_after_hours_coverage.lookup_code = gp_practice_info.after_hours_coverage~r~n" + &
"LEFT OUTER JOIN code_lookup cl_pref_contact_method  ON cl_pref_contact_method.lookup_code = gp_practice_info.prefered_contact_method ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_gender_limitations ON gp_practice_info.gender_limitations = cl_gender_limitations.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_primary_tax_id ON gp_practice_info.primary_tax_id = cl_primary_tax_id.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_after_hours_type ON gp_practice_info.after_hours_type = cl_after_hours_type.lookup_code ~r~n" + &
"ORDER BY gp_practice_info.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_questions') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_questions.rec_id, gp_questions.gp_id, gp_questions.question_id, cl_question_type.description AS quest_type, ~r~n" + &
"                      question_lookup.short_quest, question_lookup.full_quest, cl_answer.description AS answer, gp_questions.follow_up, ~r~n" + &
"                      gp_questions.followup_2~r~n" + &
"FROM         gp_questions INNER JOIN~r~n" + &
"                      question_lookup ON gp_questions.question_id = question_lookup.quest_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_question_type ON question_lookup.quest_type = cl_question_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_answer ON gp_questions.answer_code = cl_answer.lookup_code~r~n" + &
"ORDER BY gp_questions.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

of_execute_sql()

return 0

end function

public function integer of_update_view_v6_2 ();//////////////////////////////////////////////////////////////////////
// $<function>		n_cst_contract_sql.of_update_view_v6_2()
// $<arguments> 	None
// $<returns> 		integer
// $<description>	Update the view's sql
// $<add> 			07.23.2007 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_sql,ls_tag,ls_Title

IF gs_dbtype = "ASA" THEN 
	ls_tag = "; "
	ls_Title = "TOP 50000000"
ELSE
	ls_Title = "top 100 percent"
END IF

ls_sql = of_get_view_action('v_group_covering') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + " ~r~n" + &
"                      pd_group_providers.facility_id, pd_group_providers.provider_name, code_lookup_b.description AS specialty, ~r~n" + &
"                      code_lookup_b.description AS specialty_code, code_lookup_a.code AS covering, pd_group_providers.covering_days, ~r~n" + &
"                      pd_group_providers.custom_1, pd_group_providers.custom_2, pd_group_providers.custom_3, pd_group_providers.custom_4, ~r~n" + &
"                      pd_group_providers.custom_5, facility.facility_name, pd_group_providers.prac_id, pd_group_providers.rec_id, ~r~n" + &
"                      pd_group_providers.custom_6, pd_group_providers.custom_7, pd_group_providers.custom_8, pd_group_providers.custom_9, ~r~n" + &
"                      pd_group_providers.custom_10, pd_group_providers.custom_d1, pd_group_providers.custom_d2~r~n" + &
"FROM         pd_group_providers INNER JOIN~r~n" + &
"                      facility ON pd_group_providers.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_group_providers.covering = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_group_providers.specialty = code_lookup_b.lookup_code~r~n" + &
"ORDER BY pd_group_providers.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_group_practice') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp.rec_id AS gp_id, cl_address_type.code AS address_type_code, cl_address_type.description AS address_type_description, gp.street, gp.street_2, ~r~n" + &
"                      gp.city, cl_state.code AS state, gp.zip, cl_county.description AS county, cl_country.description AS country, gp.phone, gp.ext, gp.fax, gp.pager_number, ~r~n" + &
"                      gp.web_address, gp.e_mail_address, gp.contact_person, gp.business_mgr, gp.office_mgr, gp.tax_id, gp.tax_id_other_1, gp.tax_id_other_2, ~r~n" + &
"                      cl_accepting_new_patients.description AS accepting_new_patients, gp.cust_1, gp.cust_2, gp.cust_3, gp.cust_4, gp.cust_5, gp.cust_6, gp.active_status, ~r~n" + &
"                      cl_practice_type.description AS practice_type, gp.routine_visit_appt, gp.urgent_visit_appt, gp.emergency_visit_appt, gp.non_emergency_appt, ~r~n" + &
"                      cl_young_child.description AS young_child, cl_child.description AS child, cl_adolescent.description AS adolescent, cl_adult.description AS adult, ~r~n" + &
"                      cl_senior_adult.description AS senior_adult, cl_handicapped_access.description AS handicapped_access, ~r~n" + &
"                      cl_public_transportation.description AS public_transportation, cl_office_in_home.description AS office_in_home, gp.mon_from, gp.mon_to, ~r~n" + &
"                      gp.mon_from2, gp.mon_to2, gp.tue_from, gp.tue_to, gp.tue_from2, gp.tue_to2, gp.wed_from, gp.wed_to2, gp.wed_from2, gp.wed_to, gp.thu_from, ~r~n" + &
"                      gp.thu_to, gp.thu_from2, gp.thu_to2, gp.fri_from, gp.fri_to, gp.fri_from2, gp.fri_to2, gp.sat_from, gp.sat_to, gp.sat_from2, gp.sat_to2, gp.sun_from, ~r~n" + &
"                      gp.sun_from2, gp.sun_to, gp.sun_to2, gp.prac_id, gp.suite_apart, gp.billing_address_id~r~n" + &
"FROM         group_practice gp LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_address_type ON gp.mailing_address = cl_address_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_accepting_new_patients ON gp.accepting_new_patients = cl_accepting_new_patients.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_adult ON gp.adult = cl_adult.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_adolescent ON gp.adolescent = cl_adolescent.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_child ON gp.child = cl_child.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_country ON gp.country = cl_country.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_county ON gp.county = cl_county.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_handicapped_access ON gp.handicapped_access = cl_handicapped_access.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_office_in_home ON gp.office_in_home = cl_office_in_home.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_practice_type ON gp.practice_type = cl_practice_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_public_transportation ON gp.public_transportation = cl_public_transportation.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_senior_adult ON gp.senior_adult = cl_senior_adult.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state ON gp.state = cl_state.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_young_child ON gp.young_child = cl_young_child.lookup_code~r~n" + &
"ORDER BY gp.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_group_practice_parent_org_link') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     group_loc_link.rec_id, group_loc_link.group_id AS parent_org_id, group_multi_loc.gp_name AS parent_org_name, ~r~n" + &
"                      group_loc_link.loc_id AS gp_id, group_practice.street AS gp_loc_name~r~n" + &
"FROM         group_loc_link INNER JOIN~r~n" + &
"                      group_multi_loc ON group_loc_link.group_id = group_multi_loc.rec_id INNER JOIN~r~n" + &
"                      group_practice ON group_loc_link.loc_id = group_practice.rec_id~r~n" + &
"ORDER BY group_loc_link.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_hosp_affil') + "~r~n" + &
"as select " + ls_Title + " pd_hosp_affil.rec_id,pd_hosp_affil.prac_id,hospital_code=address_lookup.code,hospital_name=address_lookup.entity_name,pd_hosp_affil.month_from,pd_hosp_affil.year_from,pd_hosp_affil.month_thru,pd_hosp_affil.year_thru,pd_hosp_affil.primary_hosp,primary_hospital=code_lookup_g.code,staff_cat_code=code_lookup_h.code,staff_cat_description=code_lookup_h.description,admitting_priviliges=code_lookup_i.code,pd_hosp_affil.cust_1,pd_hosp_affil.cust_2,pd_hosp_affil.cust_3,pd_hosp_affil.cust_4,pd_hosp_affil.cust_5 from((((pd_hosp_affil left outer join address_lookup on pd_hosp_affil.hospital_code = address_lookup.lookup_code) left outer join code_lookup as code_lookup_g on pd_hosp_affil.primary_hosp = code_lookup_g.lookup_code) left outer join code_lookup as code_lookup_h on pd_hosp_affil.staff_category = code_lookup_h.lookup_code) left outer join code_lookup as code_lookup_i on pd_hosp_affil.admitting_priv = code_lookup_i.lookup_code) order by pd_hosp_affil.rec_id,pd_hosp_affil.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_hospital_facility_link') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_hosp_facility_link.hosp_affil_id AS rec_id, pd_hosp_facility_link.prac_id, pd_hosp_facility_link.facility_id, ~r~n" + &
"                      pd_hosp_facility_link.primary_hosp, code_lookup.code AS primary_hosp_code, ~r~n" + &
"                      code_lookup.description AS primary_hosp_description~r~n" + &
"FROM         pd_hosp_facility_link INNER JOIN~r~n" + &
"                      code_lookup ON pd_hosp_facility_link.primary_hosp = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_hosp_facility_link.hosp_affil_id,pd_hosp_facility_link.prac_id,pd_hosp_facility_link.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_image_list') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     rec_id, prac_id, screen_id, date_scanned, user_name, date_recieved, active_status, doc_id, notes, num_pages, reference_name, tif_start_page, ~r~n" + &
"                      image_type_id, file_name, modify_date~r~n" + &
"FROM         pd_images~r~n" + &
"ORDER BY rec_id, prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_Insurance') + "~r~n" + &
"  as select " + ls_Title + " pd_insurance.rec_id,~r~n" + &
"    pd_insurance.prac_id,~r~n" + &
"    address_lookup.code as carrier_code,~r~n" + &
"    address_lookup.entity_name as carrier_name,~r~n" + &
"    pd_insurance.policy_number,~r~n" + &
"    pd_insurance.coverage_from,~r~n" + &
"    pd_insurance.coverage_to,~r~n" + &
"    pd_insurance.previous_expiration_date,~r~n" + &
"    code_lookup_b.code as tail_coverage_code,~r~n" + &
"    pd_insurance.coverage_limit_from,~r~n" + &
"    pd_insurance.coverage_limit_to,~r~n" + &
"    code_lookup_d.code as state_funded_code,~r~n" + &
"    code_lookup_c.code as state_coverage,~r~n" + &
"    pd_insurance.exclusions,~r~n" + &
"    pd_insurance.cust_1,~r~n" + &
"    pd_insurance.cust_2,~r~n" + &
"    pd_insurance.cust_3,~r~n" + &
"    pd_insurance.cust_4,~r~n" + &
"    pd_insurance.cust_5,~r~n" + &
"    code_lookup_a.code as claims_made_code,~r~n" + &
"    code_lookup_a.description as claims_made_description,~r~n" + &
"    pd_insurance.denied_explain,~r~n" + &
"    pd_insurance.active_status~r~n" + &
"from~r~n" + &
"    pd_insurance LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON pd_insurance.claims_made_occurrence = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_insurance.tail_coverage = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_insurance.state_coverage = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_insurance.state_funded_pool = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    address_lookup ON pd_insurance.carrier_code = address_lookup.lookup_code~r~n" + &
"order by pd_insurance.rec_id,pd_insurance.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_invoice') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_invoice.rec_id AS invoice_id, pd_invoice.prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(pd_basic.first_name, '') + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) ~r~n" + &
"                      + CASE WHEN isnull(pd_basic.middle_name, '') = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS prac_name, pd_invoice.facility_id, facility.facility_name, ~r~n" + &
"                      pd_invoice.inv_date AS invoice_date, pd_invoice.due_date, pd_invoice.tax_a, pd_invoice.amt_billed, pd_invoice.invc_amt, ~r~n" + &
"                      pd_invoice.amt_paid, CASE pd_invoice.paid WHEN 0 THEN 'Open' ELSE 'Paid' END AS paid, pd_invoice.note, pd_inv_rows.item_id, ~r~n" + &
"                      pd_inv_rows.invt_id AS item_inventory_id, pd_inv_rows.billing_item AS item_billing_item, pd_inv_rows.quantity AS item_quantity, ~r~n" + &
"                      pd_inv_rows.cost AS item_cost, pd_inv_rows.price AS item_price, pd_inv_rows.extended AS item_extended~r~n" + &
"FROM         pd_invoice INNER JOIN~r~n" + &
"                      pd_inv_rows ON pd_invoice.rec_id = pd_inv_rows.rec_id INNER JOIN~r~n" + &
"                      pd_basic ON pd_invoice.prac_id = pd_basic.prac_id INNER JOIN~r~n" + &
"                      facility ON pd_invoice.facility_id = facility.facility_id~r~n" + &
"ORDER BY pd_invoice.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_languages') + "~r~n" + &
"as~r~n" + &
"select " + ls_Title + "~r~n" + &
"	pd_languages.rec_id,~r~n" + &
"	pd_languages.prac_id,~r~n" + &
"	lang_code=code_lookup_a.code,~r~n" + &
"	lang_description=code_lookup_a.description,~r~n" + &
"	speak=code_lookup_b.code,~r~n" + &
"	[read]=code_lookup_c.code,~r~n" + &
"	write=code_lookup_d.code,~r~n" + &
"	[sign]=code_lookup_e.code,~r~n" + &
"	pd_languages.cust_1,~r~n" + &
"	pd_languages.cust_2,~r~n" + &
"	pd_languages.cust_3,~r~n" + &
"	pd_languages.cust_4,~r~n" + &
"	pd_languages.cust_5~r~n" + &
"from~r~n" + &
"	(((((pd_languages left outer join~r~n" + &
"	code_lookup as code_lookup_a on pd_languages.foreign_language = code_lookup_a.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_b on pd_languages.speak = code_lookup_b.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_c on pd_languages.reads = code_lookup_c.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_d on pd_languages.writes = code_lookup_d.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_e on pd_languages.sign = code_lookup_e.lookup_code)~r~n" + &
"order by pd_languages.rec_id,pd_languages.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_license') + "~r~n" + &
"as SELECT " + ls_Title + " pd_license.rec_id,pd_license.prac_id,state_code=code_lookup_a.code,state_description=code_lookup_a.description,lic_type_code=code_lookup_b.code,lic_type_description=code_lookup_b.description,pd_license.license_number,pd_license.expiration_date,pd_license.year_issued,pd_license.previous_expiration_date,verif_agcy_code=address_lookup.code,verif_agcy_name=address_lookup.entity_name,pd_license.restrictions,pd_license.cust_1,pd_license.cust_2,pd_license.cust_3,pd_license.cust_4,pd_license.cust_5,pd_license.active_status from address_lookup,code_lookup as code_lookup_a,code_lookup as code_lookup_b,pd_license where(pd_license.state = code_lookup_a.lookup_code) and(pd_license.license_type_code = code_lookup_b.lookup_code) and(pd_license.verifying_agency = address_lookup.lookup_code) ORDER BY pd_license.rec_id,pd_license.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_mailing_address') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     code_lookup_c.code AS state, pd_address.rec_id, pd_address.prac_id, pd_address.street, pd_address.street_2, pd_address.city, ~r~n" + &
"                      code_lookup_b.code AS practice_type, pd_address.zip, code_lookup_d.code AS country, pd_address.phone, pd_address.fax, ~r~n" + &
"                      pd_address.contact_person, pd_address.e_mail_address, pd_address.web_address, pd_address_link.facility_id, ~r~n" + &
"                      pd_address_link.mailing, pd_address.ext, code_lookup_a.description AS county, code_lookup_d.description AS country_description, ~r~n" + &
"                      code_lookup_c.description AS state_description, code_lookup_b.description AS practice_type_description, pd_address.tax_id, ~r~n" + &
"                      pd_address.tax_id_other_1, pd_address.tax_id_other_2, pd_address.business_mgr, pd_address.office_mgr, pd_address.cust_1, ~r~n" + &
"                      pd_address.cust_2, pd_address.cust_3, pd_address.cust_4, pd_address.cust_5, pd_address.cust_6, pd_address.cust_7, ~r~n" + &
"                      pd_address.cust_8, pd_address.cust_9, pd_address.cust_10, pd_address.cust_d1, pd_address.cust_d2, pd_address.gp_id, ~r~n" + &
"                      pd_address.suite_apart, code_lookup_e.description AS send_corresp_here~r~n" + &
"FROM         pd_address INNER JOIN~r~n" + &
"                      pd_address_link ON pd_address.rec_id = pd_address_link.address_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_address.practice_type = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_c ON pd_address.state = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_address.country = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_address.county = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_e ON pd_address.send_corresp_here = code_lookup_e.lookup_code~r~n" + &
"WHERE     (pd_address_link.mailing = 1)~r~n" + &
"ORDER BY pd_address.rec_id,pd_address.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_meeting_list') + "~r~n" + &
"  as select " + ls_Title + " meetings.meeting_id,~r~n" + &
"    facility_name,~r~n" + &
"    meeting_type_code=code_lookup_a.code,~r~n" + &
"    meetings.start_date,~r~n" + &
"    start_time=code_lookup_c.code,~r~n" + &
"    meetings.end_date,~r~n" + &
"    end_time=code_lookup_d.code,~r~n" + &
"    meetings.subject,~r~n" + &
"    location=code_lookup_b.code,~r~n" + &
"    department=code_lookup_e.description,~r~n" + &
"    section=code_lookup_g.description,~r~n" + &
"    committee_lookup.committee_name,~r~n" + &
"    meetings.comments,~r~n" + &
"    meetings.cme_credits,~r~n" + &
"    cme_category=code_lookup_h.code,~r~n" + &
"    meetings.cme_presenter,~r~n" + &
"    meetings.cme_affiliation~r~n" + &
"from~r~n" + &
"    meetings INNER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON meetings.meeting_type = code_lookup_a.lookup_code INNER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON meetings.location = code_lookup_b.lookup_code INNER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON meetings.start_time = code_lookup_c.lookup_code INNER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON meetings.end_time = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON meetings.department = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_g ON meetings.section = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_h ON meetings.cme_category = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"    committee_lookup ON meetings.committee = committee_lookup.committee_id LEFT OUTER JOIN~r~n" + &
"    facility ON meetings.facility = facility.facility_id~r~n" + &
"order by meetings.meeting_id    ~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_meetings') + "~r~n" + &
"  as select " + ls_Title + " meeting_type=code_lookup_a.code,~r~n" + &
"    meetings.start_date,~r~n" + &
"    meetings.start_time,~r~n" + &
"    meetings.end_date,~r~n" + &
"    meetings.end_time,~r~n" + &
"    meetings.subject,~r~n" + &
"    location=code_lookup_b.code,~r~n" + &
"    meetings.committee,~r~n" + &
"    meetings.comments,~r~n" + &
"    meetings.cme_credits,~r~n" + &
"    meetings.cme_category,~r~n" + &
"    meetings.cme_presenter,~r~n" + &
"    meetings.cme_affiliation,~r~n" + &
"    meetings.facility,~r~n" + &
"    attendence.attendence_status,~r~n" + &
"    meetings.meeting_id,~r~n" + &
"    attendence.prac_id,~r~n" + &
"    meetings.department,~r~n" + &
"    meetings.section,~r~n" + &
"    attendence.active_status from(~r~n" + &
"    meetings left outer join attendence on meetings.meeting_id = attendence.meeting_id),~r~n" + &
"    code_lookup as code_lookup_a,~r~n" + &
"    code_lookup as code_lookup_b where~r~n" + &
"    (meetings.meeting_type = code_lookup_a.lookup_code) and~r~n" + &
"    (meetings.location = code_lookup_b.lookup_code)~r~n" + &
"order by meetings.meeting_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_net_dev_actions') + "~r~n" + &
"as select " + ls_Title + " prac_id,net_dev_action_items.facility_id,facility.facility_name,action_type_code=code_lookup_a.code,action_type_description=code_lookup_a.description,department_code=code_lookup_b.code,department_description=code_lookup_b.description,action_status_code=code_lookup_c.code,action_status_description=code_lookup_c.description,net_dev_action_items.action_date,net_dev_action_items.action_user,net_dev_action_items.next_action_date,net_dev_action_items.notes,net_dev_action_items.action_contact,app_hdr.application_type,app_hdr.application_name from((((net_dev_action_items left outer join code_lookup as code_lookup_a on net_dev_action_items.action_type = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on net_dev_action_items.action_dept = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on net_dev_action_items.action_status = code_lookup_c.lookup_code) left outer join app_hdr on net_dev_action_items.app_id = app_hdr.app_id),facility where(net_dev_action_items.facility_id = facility.facility_id) order by prac_id,net_dev_action_items.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_net_dev_ids') + "~r~n" + &
"as select " + ls_Title + " net_dev_ids.prac_id,net_dev_ids.facility_id,facility.facility_name,plan_type_code=code_lookup.code,plan_type_description=code_lookup.description,net_dev_ids.plan_assigned_id,net_dev_ids.start_date,net_dev_ids.end_date from code_lookup,net_dev_ids,facility where(net_dev_ids.plan_type = code_lookup.lookup_code) and(net_dev_ids.facility_id = facility.facility_id) order by net_dev_ids.prac_id,net_dev_ids.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_net_dev_notes') + "~r~n" + &
"as select " + ls_Title + " net_dev_notes.prac_id,net_dev_notes.notes from net_dev_notes order by net_dev_notes.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_other_affil') + "~r~n" + &
"as select " + ls_Title + " pd_other_affill.rec_id,pd_other_affill.prac_id,institution_code=address_lookup.code,institution_name=address_lookup.entity_name,function_code=code_lookup.code,function_description=code_lookup.description,pd_other_affill.month_from,pd_other_affill.year_from,pd_other_affill.month_thru,pd_other_affill.year_thru,pd_other_affill.cust_1,pd_other_affill.cust_2,pd_other_affill.cust_3,pd_other_affill.cust_4,pd_other_affill.cust_5 from(pd_other_affill left outer join code_lookup on pd_other_affill.function_code = code_lookup.lookup_code),address_lookup where(pd_other_affill.institution_code = address_lookup.lookup_code) order by pd_other_affill.rec_id,pd_other_affill.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_other_data_fs') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + " ~r~n" + &
"                      pd_other_data.facility_id, facility.facility_name, pd_other_data.prac_id, pd_other_data.corp_comply, pd_other_data.bylaws_read, ~r~n" + &
"                      pd_other_data.orientation, pd_other_data.conscience_sedation, pd_other_data.ppd_date, pd_other_data.npdb, ~r~n" + &
"                      pd_other_data.physical, pd_other_data.lij_beeper, pd_other_data.active_status, code_lookup.description AS positive_ppd, ~r~n" + &
"                      pd_other_data.custom_1, pd_other_data.custom_2, pd_other_data.custom_3, pd_other_data.custom_4, ~r~n" + &
"                      pd_other_data.custom_5~r~n" + &
"FROM         pd_other_data INNER JOIN~r~n" + &
"                      facility ON pd_other_data.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_other_data.positive_ppd = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_other_data.facility_id,pd_other_data.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_other_ids') + "~r~n" + &
"as select " + ls_Title + " pd_other_ids.rec_id,pd_other_ids.prac_id,id_type_code=code_lookup.code,id_type_description=code_lookup.description,pd_other_ids.id_number,pd_other_ids.exp_date,pd_other_ids.cust_1,pd_other_ids.cust_2,pd_other_ids.cust_3,pd_other_ids.cust_4,pd_other_ids.cust_5 from(pd_other_ids left outer join code_lookup on pd_other_ids.id_type = code_lookup.lookup_code) order by pd_other_ids.rec_id,pd_other_ids.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//ls_sql = of_get_view_action('v_pdc_dues') + "~r~n" + &
//"  as select " + ls_Title + " pdc_dues.rec_id,~r~n" + &
//"    pdc_dues.prac_id,~r~n" + &
//"    pdc_dues.facility_id,~r~n" + &
//"    code_lookup.description as dues_paid,~r~n" + &
//"    pdc_dues.reason_not_paid,~r~n" + &
//"    pdc_dues.dues_amount,~r~n" + &
//"    pdc_dues.date_dues_paid,~r~n" + &
//"    pdc_dues.medicare_group_code,~r~n" + &
//"    pdc_dues.medical_record_suspension,~r~n" + &
//"    pdc_dues.med_rec_suspend_data,~r~n" + &
//"    pdc_dues.misc,~r~n" + &
//"    pdc_dues.cust_1,~r~n" + &
//"    pdc_dues.cust_2,~r~n" + &
//"    pdc_dues.cust_date_1,~r~n" + &
//"    pdc_dues.cust_date_2 from~r~n" + &
//"    pdc_dues,code_lookup where~r~n" + &
//"    pdc_dues.dues_paid = code_lookup.lookup_code~r~n" + &
//"order by pdc_dues.rec_id~r~n" + ls_tag
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//ls_sql = of_get_view_action('v_pdc_supervisor') + "~r~n" + &
//"  as SELECT " + ls_Title + " pdc_supervisor.prac_id,~r~n" + &
//"    pdc_supervisor.rec_id,~r~n" + &
//"    pdc_supervisor.facility_id,~r~n" + &
//"    primary_super_code=code_lookup_A.code,~r~n" + &
//"    primary_super_descr=code_lookup_A.description,~r~n" + &
//"    super_section_code=code_lookup_B.code,~r~n" + &
//"    super_section_descr=code_lookup_B.description,~r~n" + &
//"    super_dept_code=code_lookup_C.code,~r~n" + &
//"    super_dept_descr=code_lookup_C.description,~r~n" + &
//"    pdc_supervisor.last_name,~r~n" + &
//"    pdc_supervisor.first_name,~r~n" + &
//"    pdc_supervisor.mid_initial,~r~n" + &
//"    prof_suffix_code=code_lookup_D.code,~r~n" + &
//"    prof_suffix_descr=code_lookup_D.description,~r~n" + &
//"    pdc_supervisor.begin_date,~r~n" + &
//"    pdc_supervisor.end_date,~r~n" + &
//"    pdc_supervisor.cust_1,~r~n" + &
//"    pdc_supervisor.cust_2,~r~n" + &
//"    pdc_supervisor.cust_date1~r~n" + &
//"from~r~n" + &
//"    pdc_supervisor LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_A ON pdc_supervisor.primary_super = code_lookup_A.lookup_code LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_B ON pdc_supervisor.super_section = code_lookup_B.lookup_code LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_C ON pdc_supervisor.super_dept = code_lookup_C.lookup_code LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_D ON pdc_supervisor.prof_suffix = code_lookup_D.lookup_code~r~n" + &
//"ORDER BY pdc_supervisor.prac_id~r~n" + ls_tag
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql


ls_sql = of_get_view_action('v_peer_review') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_peer_review.case_number, pd_peer_review.facility_id, facility.facility_name, pd_peer_review.date_of_review, ~r~n" + &
"                      cl_review_status.code AS review_status_code, cl_review_status.description AS review_status_description, pd_peer_review.reviewer, ~r~n" + &
"                      cl_review_reason.code AS review_reason_code, cl_review_reason.description AS review_reason_description, ~r~n" + &
"                      pd_peer_review.date_of_occurrence, pd_peer_review.medical_record_number, pd_peer_review.patient_name, ~r~n" + &
"                      pd_peer_review.admission_date, pd_peer_review.admitting_diagnoses, cl_sex.code AS gender_code, ~r~n" + &
"                      cl_sex.description AS gender_description, pd_peer_review.age, pd_peer_review.notes, pd_peer_review.finding, ~r~n" + &
"                      pd_peer_review.conclusion, pd_peer_review.date_completed, pd_peer_review.time_of_occurrence, pd_peer_review.cust_1, ~r~n" + &
"                      pd_peer_review.cust_2, pd_peer_review.cust_3, pd_peer_review.cust_4, pd_peer_review.cust_5, pd_peer_review.cust_6, ~r~n" + &
"                      pd_peer_review.cust_7, pd_peer_review.cust_8, pd_peer_review.cust_9, pd_peer_review.cust_10~r~n" + &
"FROM         pd_peer_review LEFT OUTER JOIN~r~n" + &
"                      facility ON pd_peer_review.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_review_reason ON pd_peer_review.review_reason = cl_review_reason.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_sex ON pd_peer_review.sex = cl_sex.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_review_status ON pd_peer_review.review_status = cl_review_status.lookup_code~r~n" + &
"ORDER BY pd_peer_review.case_number~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_peer_review_action_items') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_peer_review_action_items.rec_id, pd_peer_review_action_items.case_number, cl_action_type.code AS action_type_code, ~r~n" + &
"                      cl_action_type.description AS action_type_description, pd_peer_review_action_items.action_date, cl_action_to.code AS action_to_code, ~r~n" + &
"                      cl_action_to.description AS action_to_description, pd_peer_review_action_items.action_user, pd_peer_review_action_items.notes, ~r~n" + &
"                      pd_peer_review_action_items.action_to_name, cl_action_status.code AS action_status_code, ~r~n" + &
"                      cl_action_status.description AS action_status_description, pd_peer_review_action_items.date_completed~r~n" + &
"FROM         pd_peer_review_action_items LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_action_status ON pd_peer_review_action_items.action_status = cl_action_status.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_action_type ON pd_peer_review_action_items.action_type = cl_action_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_action_to ON pd_peer_review_action_items.action_to = cl_action_to.lookup_code~r~n" + &
"ORDER BY pd_peer_review_action_items.rec_id, pd_peer_review_action_items.case_number~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_peer_review_pracs') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_peer_review_pracs.case_number, pd_peer_review_pracs.prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(pd_basic.first_name, '') + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) ~r~n" + &
"                      + CASE WHEN isnull(pd_basic.middle_name, '') = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS full_name, code_lookup.code AS severity_code, ~r~n" + &
"                      code_lookup.description AS severity_code_description, pd_peer_review_pracs.notes, pd_peer_review_pracs.active_status~r~n" + &
"FROM         pd_peer_review_pracs INNER JOIN~r~n" + &
"                      pd_basic ON pd_peer_review_pracs.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_peer_review_pracs.severity_grade = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_peer_review_pracs.case_number, pd_peer_review_pracs.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_postgrad_train') + "~r~n" + &
"as select " + ls_Title + " pd_postgrad_train.rec_id,pd_postgrad_train.prac_id,pd_postgrad_train.subject,pd_postgrad_train.date_from,pd_postgrad_train.date_thru,pd_postgrad_train.loc_city,loc_state_code=code_lookup_a.code,loc_state_description=code_lookup_a.description,pd_postgrad_train.loc_zip,loc_country_code=code_lookup_b.code,loc_country_description=code_lookup_b.description,pd_postgrad_train.hours,hours_code=code_lookup_f.code,hours_name=code_lookup_f.description,category_code=code_lookup_c.code,categ_description=code_lookup_c.description,pd_postgrad_train.sponsor,pd_postgrad_train.street,pd_postgrad_train.city,state_code=code_lookup_d.code,state_description=code_lookup_d.description,pd_postgrad_train.zip,country_code=code_lookup_e.code,country_description=code_lookup_e.description,pd_postgrad_train.program_director,pd_postgrad_train.cust_1,pd_postgrad_train.cust_2,pd_postgrad_train.cust_3,pd_postgrad_train.cust_4,pd_postgrad_train.cust_5 from((((((pd_postgrad_train left outer join code_lookup as code_lookup_a on pd_postgrad_train.loc_state = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_postgrad_train.loc_country = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on pd_postgrad_train.category = code_lookup_c.lookup_code) left outer join code_lookup as code_lookup_d on pd_postgrad_train.state = code_lookup_d.lookup_code) left outer join code_lookup as code_lookup_e on pd_postgrad_train.country = code_lookup_e.lookup_code) left outer join code_lookup as code_lookup_f on pd_postgrad_train.hours = code_lookup_f.lookup_code) order by pd_postgrad_train.rec_id,pd_postgrad_train.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_prac_privs') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     facility.facility_name, pd_priv_list.rec_id, pd_priv_list.facility_id, pd_priv_list.prac_id, pd_priv_list.start_date, ~r~n" + &
"                      pd_priv_list.end_date, pd_priv_list.notes, pd_priv_list.active_status, pd_priv_list.ir_code, ~r~n" + &
"                      priv_clinical_area.clinical_area_description, priv_core_procd.core_procd_description, priv_core.priv_core_description, ~r~n" + &
"                      code_lookup.code, priv_core_procd.sort_order, priv_core_procd.procd_name, priv_clinical_area.clinical_area_code, ~r~n" + &
"                      code_lookup.description AS priv_status_description, code_lookup.code AS priv_status_code~r~n" + &
"FROM         facility INNER JOIN~r~n" + &
"                      pd_priv_list ON facility.facility_id = pd_priv_list.facility_id INNER JOIN~r~n" + &
"                      priv_clinical_area ON pd_priv_list.clinical_area_id = priv_clinical_area.clinical_area_id INNER JOIN~r~n" + &
"                      priv_core ON pd_priv_list.priv_core_id = priv_core.priv_core_id INNER JOIN~r~n" + &
"                      priv_core_procd ON pd_priv_list.procd_id = priv_core_procd.procd_id INNER JOIN~r~n" + &
"                      code_lookup ON pd_priv_list.status_code = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_priv_list.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_pracitioner_notes') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_notes.record_id, pd_notes.prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) + ', ' + ISNULL(pd_basic.first_name, '') ~r~n" + &
"                      + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) + CASE WHEN isnull(pd_basic.middle_name, '') ~r~n" + &
"                      = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS full_name, pd_notes.facility_id, ~r~n" + &
"                      CASE pd_notes.facility_id WHEN 0 THEN 'Global' ELSE facility.facility_name END AS facility_name, pd_notes.ent_date, pd_notes.user_id, ~r~n" + &
"                      pd_notes.note~r~n" + &
"FROM         pd_notes INNER JOIN~r~n" + &
"                      pd_basic ON pd_notes.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      facility ON pd_notes.facility_id = facility.facility_id~r~n" + &
"ORDER BY pd_notes.record_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_primary_specialty') + "~r~n" + &
"as~r~n" + &
"select " + ls_Title + "~r~n" + &
"pd_board_specialty.rec_id,pd_board_specialty.prac_id,pd_board_specialty.specialty as specialty_id,code_lookup_a.code as specialty_code,~r~n" + &
"code_lookup_a.description as specialty_name,address_lookup.code as board_code,pd_board_specialty.board_code as board_code_id,~r~n" + &
"address_lookup.entity_name as board_name,pd_board_specialty.eligible_until,pd_board_specialty.initial_certification,~r~n" + &
"pd_board_specialty.last_recertification,pd_board_specialty.certification_expires,pd_board_specialty.certification_number,~r~n" + &
"pd_board_specialty.required_year_completion,pd_board_specialty.cust_1,pd_board_specialty.cust_2,pd_board_specialty.cust_3,~r~n" + &
"pd_board_specialty.cust_4,pd_board_specialty.cust_5,code_lookup_b.description as exam_taken,code_lookup_c.description as active_process,~r~n" + &
"code_lookup_d.description as ever_failed,code_lookup_e.description as specialty_order ~r~n" + &
"from ~r~n" + &
"pd_board_specialty LEFT OUTER JOIN~r~n" + &
"address_lookup ON pd_board_specialty.board_code = address_lookup.lookup_code INNER JOIN~r~n" + &
"code_lookup as code_lookup_a ON pd_board_specialty.specialty = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"code_lookup as code_lookup_b ON pd_board_specialty.exam_taken = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"code_lookup as code_lookup_c ON pd_board_specialty.active_cert_process = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"code_lookup as code_lookup_d ON pd_board_specialty.ever_failed_cert = code_lookup_d.lookup_code INNER JOIN~r~n" + &
"code_lookup as code_lookup_e ON pd_board_specialty.specialty_order = code_lookup_e.lookup_code~r~n" + &
"where~r~n" + &
"(code_lookup_e.code = 'Primary')~r~n" + &
"order by pd_board_specialty.rec_id,pd_board_specialty.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_priv_list') + "~r~n" + &
"  as select " + ls_Title + " priv_clinical_area.clinical_area_code,~r~n" + &
"    priv_clinical_area.clinical_area_id,~r~n" + &
"    priv_clinical_area.clinical_area_description,~r~n" + &
"    priv_core.priv_core_description,~r~n" + &
"    priv_core.priv_core_id,~r~n" + &
"    priv_core_procd.core_procd_description,~r~n" + &
"    priv_core_procd.procd_id,~r~n" + &
"    priv_core_procd.sort_order,~r~n" + &
"    priv_core_procd.procd_name from((~r~n" + &
"    priv_clinical_area left outer join priv_core on priv_clinical_area.clinical_area_id = priv_core.clinical_area_id) left outer join priv_core_procd on priv_core.priv_core_id = priv_core_procd.priv_core_id)~r~n" + &
"order by priv_clinical_area.clinical_area_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_prof_assoc') + "~r~n" + &
"as select " + ls_Title + " pd_prof_assoc.rec_id,pd_prof_assoc.prac_id,pd_prof_assoc.prof_assoc,prof_assoc_code=address_lookup.code,prof_assoc_name=address_lookup.entity_name,pd_prof_assoc.date_assoc,pd_prof_assoc.cust_1,pd_prof_assoc.cust_2,pd_prof_assoc.cust_3,pd_prof_assoc.cust_4,pd_prof_assoc.cust_5 from pd_prof_assoc,address_lookup where(pd_prof_assoc.prof_assoc = address_lookup.lookup_code) order by pd_prof_assoc.rec_id,pd_prof_assoc.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_prof_experience') + "~r~n" + &
"as select " + ls_Title + " pd_prof_experience.rec_id,pd_prof_experience.prac_id,pd_prof_experience.date_from_month,pd_prof_experience.date_to_month,pd_prof_experience.organization,pd_prof_experience.city,state_code=code_lookup_a.code,state_description=code_lookup_a.description,pd_prof_experience.zip,country_code=code_lookup_b.code,country_description=code_lookup_b.description,pd_prof_experience.title_duties,pd_prof_experience.date_from_year,pd_prof_experience.date_to_year,pd_prof_experience.cust_1,pd_prof_experience.cust_2,pd_prof_experience.cust_3,pd_prof_experience.cust_4,pd_prof_experience.cust_5,pd_prof_experience.street_1,pd_prof_experience.street_2 from((pd_prof_experience left outer join code_lookup as code_lookup_a on pd_prof_experience.state = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_prof_experience.country = code_lookup_b.lookup_code) order by pd_prof_experience.rec_id,pd_prof_experience.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_qa_hdr') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     PD_QA_HDR.PD_QA_HDR_ID AS pd_qa_hdr_id, PD_QA_HDR.PRAC_ID AS prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(pd_basic.first_name, '') + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) ~r~n" + &
"                      + CASE WHEN isnull(pd_basic.middle_name, '') = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS practitioner_name, PD_QA_HDR.QA_PROFILE_ID AS qa_profile_id, ~r~n" + &
"                      QA_PROFILE.PROFILE_NAME AS profile_name, QA_PROFILE.SPECIALTY_ID AS profile_specialty_lookup_code, ~r~n" + &
"                      CASE QA_PROFILE.SPECIALTY_ID WHEN 999999 THEN '(All)' ELSE cl_specialty.code END AS profile_specialty_code, ~r~n" + &
"                      CASE QA_PROFILE.SPECIALTY_ID WHEN 999999 THEN '(All Specialties)' ELSE cl_specialty.description END AS profile_specialty_description, ~r~n" + &
"                      PD_QA_HDR.FROM_DATE AS from_date, PD_QA_HDR.TO_DATE AS to_date, PD_QA_HDR.ACTIVE_STATUS AS active_status, ~r~n" + &
"                      CASE PD_QA_HDR.ACTIVE_STATUS WHEN 0 THEN 'History' WHEN 1 THEN 'Active' WHEN 4 THEN 'Pending' ELSE 'Unknown' END AS active_status_description,~r~n" + &
"                       PD_QA_HDR.HDR_COMMENT AS hdr_comment, cl_reason.code AS reason_code, cl_reason.description AS reason_description, ~r~n" + &
"                      QA_PROFILE.FACILITY_ID AS facility_id, facility.facility_name~r~n" + &
"FROM         PD_QA_HDR INNER JOIN~r~n" + &
"                      pd_basic ON PD_QA_HDR.PRAC_ID = pd_basic.prac_id INNER JOIN~r~n" + &
"                      QA_PROFILE ON PD_QA_HDR.QA_PROFILE_ID = QA_PROFILE.QA_PROFILE_ID INNER JOIN~r~n" + &
"                      facility ON QA_PROFILE.FACILITY_ID = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_reason ON PD_QA_HDR.REASON = cl_reason.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_specialty ON QA_PROFILE.SPECIALTY_ID = cl_specialty.lookup_code~r~n" + &
"ORDER BY PD_QA_HDR.PD_QA_HDR_ID~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_qa_measurements') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     PD_QA_MEASUREMENTS.PD_QA_MEASUREMENTS_ID AS pd_qa_measurements_id, ~r~n" + &
"                      PD_QA_MEASUREMENTS.PD_QA_HDR_ID AS pd_qa_hdr_id, QA_MEASUREMENT.QA_PROFILE_GROUP_ID AS qa_profile_group_id, ~r~n" + &
"                      QA_PROFILE_GROUP.QA_PROFILE_GROUP_NAME AS qa_profile_group_name, QA_MEASUREMENT.THRESHOLD AS threshold, ~r~n" + &
"                      QA_MEASUREMENT.INCLUDE_IN_PROFILE AS include_in_profile, ~r~n" + &
"                      CASE QA_MEASUREMENT.INCLUDE_IN_PROFILE WHEN 1 THEN 'Yes' ELSE 'No' END AS include_in_profile_description, ~r~n" + &
"                      QA_MEASUREMENT.DATA_FORMAT AS data_format, QA_MEASUREMENT.QA_MEASUREMENT_NAME AS qa_measurement_name, ~r~n" + &
"                      PD_QA_MEASUREMENTS.MEASUREMENT_VALUE AS measurement_value~r~n" + &
"FROM         PD_QA_MEASUREMENTS INNER JOIN~r~n" + &
"                      QA_MEASUREMENT ON ~r~n" + &
"                      PD_QA_MEASUREMENTS.PROFILE_GROUP_MEASUREMENT_ID = QA_MEASUREMENT.PROFILE_GROUP_MEASUREMENT_ID INNER JOIN~r~n" + &
"                      QA_PROFILE_GROUP ON QA_MEASUREMENT.QA_PROFILE_GROUP_ID = QA_PROFILE_GROUP.QA_PROFILE_GROUP_ID~r~n" + &
"ORDER BY PD_QA_MEASUREMENTS.PD_QA_MEASUREMENTS_ID~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_question_lookup') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     question_lookup.quest_id, question_lookup.quest_type AS quest_type_lookup_code, code_lookup.code AS quest_type_code, ~r~n" + &
"                      code_lookup.description AS quest_type_description, question_lookup.short_quest, question_lookup.full_quest~r~n" + &
"FROM         question_lookup INNER JOIN~r~n" + &
"                      code_lookup ON question_lookup.quest_type = code_lookup.lookup_code~r~n" + &
"ORDER BY question_lookup.quest_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_references') + "~r~n" + &
"as select " + ls_Title + " pd_references.rec_id,pd_references.prac_id,pd_references.last_name,pd_references.first_middle_name,title_code=code_lookup_a.code,title_description=code_lookup_a.description,name_suffix_code=code_lookup_b.code,name_suffix_description=code_lookup_b.description,prof_suf_code=code_lookup_c.code,prof_suf_description=code_lookup_c.description,pd_references.street,pd_references.city,pd_references.state,state_code=code_lookup_d.code,state_description=code_lookup_d.description,pd_references.zip,pd_references.country,country_code=code_lookup_e.code,country_description=code_lookup_e.description,pd_references.cust_1,pd_references.cust_2,pd_references.cust_3,pd_references.cust_4,pd_references.cust_5 from(((((pd_references left outer join code_lookup as code_lookup_a on pd_references.title = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_references.name_suffix = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on pd_references.prof_suffix = code_lookup_c.lookup_code) left outer join code_lookup as code_lookup_d on pd_references.state = code_lookup_d.lookup_code) left outer join code_lookup as code_lookup_e on pd_references.country = code_lookup_e.lookup_code) order by pd_references.rec_id,pd_references.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_sanctions') + "~r~n" + &
"AS~r~n" + &
"select " + ls_Title + " pd_sanctions.rec_id,~r~n" + &
"    pd_sanctions.prac_id,~r~n" + &
"    code_lookup_a.description as status_activity,~r~n" + &
"    code_lookup_b.description as action_sanct_name,~r~n" + &
"    pd_sanctions.taken,~r~n" + &
"    pd_sanctions.date_from,~r~n" + &
"    pd_sanctions.date_thru,~r~n" + &
"    pd_sanctions.reason_1,~r~n" + &
"    pd_sanctions.reason_2,~r~n" + &
"    pd_sanctions.reason_3,~r~n" + &
"    pd_sanctions.cust_1,~r~n" + &
"    pd_sanctions.cust_2,~r~n" + &
"    pd_sanctions.cust_3,~r~n" + &
"    pd_sanctions.cust_4,~r~n" + &
"    pd_sanctions.cust_5,~r~n" + &
"    pd_sanctions.organization_name,~r~n" + &
"    address_lookup.code as org_code,~r~n" + &
"    address_lookup.entity_name as org_name~r~n" + &
"from((~r~n" + &
"    pd_sanctions left outer join~r~n" + &
"	code_lookup as code_lookup_a on pd_sanctions.status_activity_code = code_lookup_a.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_b on pd_sanctions.action_sanction_code = code_lookup_b.lookup_code) INNER JOIN~r~n" + &
"	address_lookup ON pd_sanctions.organization_name = address_lookup.lookup_code INNER JOIN~r~n" + &
"	pd_basic ON pd_sanctions.prac_id = pd_basic.prac_id~r~n" + &
"order by pd_sanctions.rec_id,pd_sanctions.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_santions') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_sanctions.prac_id, pd_sanctions.rec_id, code_lookup_a.code AS status_Activity_code, ~r~n" + &
"                      code_lookup_a.description AS status_activity_description, code_lookup_b.code AS action_Santion_Code, ~r~n" + &
"                      code_lookup_b.description AS action_santion_description, code_lookup_c.code AS santions_code, code_lookup_c.description AS santions_description, ~r~n" + &
"                      address_lookup_a.entity_name AS insurance_company, address_lookup_b.entity_name AS hospital, address_lookup_c.code AS org_name_code, ~r~n" + &
"                      address_lookup_c.entity_name AS org_name_description, pd_sanctions.taken, pd_sanctions.date_from, pd_sanctions.date_thru, ~r~n" + &
"                      pd_sanctions.reason_1, pd_sanctions.reason_2, pd_sanctions.reason_3, pd_sanctions.cust_4, pd_sanctions.cust_5~r~n" + &
"FROM         pd_sanctions INNER JOIN~r~n" + &
"                      pd_basic ON pd_sanctions.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      address_lookup address_lookup_a ON pd_sanctions.cust_2 = address_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      address_lookup address_lookup_b ON pd_sanctions.cust_3 = address_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      address_lookup address_lookup_c ON pd_sanctions.organization_name = address_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_sanctions.status_activity_code = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_sanctions.action_sanction_code = code_lookup_b.lookup_code CROSS JOIN~r~n" + &
"                      code_lookup code_lookup_c LEFT OUTER JOIN~r~n" + &
"                      pd_sanctions pd_sanctions1 ON code_lookup_c.lookup_code = pd_sanctions1.cust_1~r~n" + &
"ORDER BY pd_sanctions.prac_id, pd_sanctions.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_site_survey') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     group_practice.rec_id AS gp_id, group_practice.street, review_hdr.review_description, review_hdr.maximum_score, ~r~n" + &
"                      review_hdr.minimum_passing_score, review_hdr.total_points AS review_total_score, pd_review_hdr.review_date, ~r~n" + &
"                      code_lookup.description AS review_start_time, code_lookup_1.description AS review_end_time, pd_review_hdr.contact_person, ~r~n" + &
"                      pd_review_hdr.notes_1, pd_review_hdr.notes_2, pd_review_hdr.notes_3, pd_review_hdr.total_score AS grp_total_score, ~r~n" + &
"                      code_lookup_2.description AS review_results, pd_review_hdr.active_status, pd_review_hdr.next_review_date, ~r~n" + &
"                      pd_review_hdr.lock_for_edit~r~n" + &
"FROM         pd_review_hdr INNER JOIN~r~n" + &
"                      group_practice ON pd_review_hdr.address_id = group_practice.rec_id INNER JOIN~r~n" + &
"                      review_hdr ON pd_review_hdr.review_id = review_hdr.review_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_review_hdr.review_start_time = code_lookup.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_1 ON pd_review_hdr.review_end_time = code_lookup_1.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_2 ON pd_review_hdr.review_result_code = code_lookup_2.lookup_code~r~n" + &
"ORDER BY group_practice.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_site_survey_results') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_review_hdr.rec_id, pd_review_hdr.address_id AS gp_id, group_practice.street, group_practice.street_2, group_practice.city, ~r~n" + &
"                      cl_state.code AS state, group_practice.zip, group_practice.phone, group_practice.ext, ~r~n" + &
"                      group_practice.contact_person AS location_contact_person, review_hdr.review_description, pd_review_hdr.review_date, ~r~n" + &
"                      cl_start_time.code AS start_time_code, cl_start_time.description AS start_time_description, cl_end_time.code AS end_time_code, ~r~n" + &
"                      cl_end_time.description AS end_time_description, review_question_groups.group_name, review_question_groups.group_order, ~r~n" + &
"                      review_question_groups_1.group_name AS subgroup_name, review_question_groups_1.group_order AS subgroup_order, ~r~n" + &
"                      pd_review_hdr.contact_person AS survey_contact_person, pd_review_hdr.reviewer_id, pd_review_hdr.notes_1 AS survey_notes_1, ~r~n" + &
"                      pd_review_hdr.notes_2 AS survey_notes_2, pd_review_hdr.notes_3 AS survey_notes_3, pd_review_hdr.total_score, ~r~n" + &
"                      pd_review_hdr.review_result_code, pd_review_hdr.active_status, pd_review_hdr.next_review_date, pd_review_hdr.lock_for_edit, ~r~n" + &
"                      CASE WHEN pd_review_hdr.lock_for_edit = 1 THEN 'Yes' ELSE 'No' END AS lock_for_edit_desc, review_question_answer.question_id, ~r~n" + &
"                      review_question.question, review_question.key_quest, ~r~n" + &
"                      CASE WHEN review_question.key_quest = 1 THEN 'Yes' ELSE 'No' END AS key_quest_desc, review_question.key_value AS key_passing_value, ~r~n" + &
"                      review_question.question_order, review_question_answer.answer_id, review_question_answer.question_answer AS answer, ~r~n" + &
"                      review_question_answer.answer_score, review_question_answer.answer_order, pd_review_answers.answer_on_off AS answer_selected, ~r~n" + &
"                      CASE WHEN pd_review_answers.answer_on_off = 1 THEN 'Yes' ELSE 'No' END AS answer_selected_desc, ~r~n" + &
"                      pd_review_answers.notes AS answer_notes~r~n" + &
"FROM group_practice ~r~n" + &
"INNER JOIN pd_review_hdr ON group_practice.rec_id = pd_review_hdr.address_id ~r~n" + &
"INNER JOIN review_hdr ON  review_hdr.review_id = pd_review_hdr.review_id ~r~n" + &
"INNER JOIN pd_review_answers ON pd_review_hdr.rec_id = pd_review_answers.rec_id ~r~n" + &
"INNER JOIN review_question_answer ON pd_review_answers.question_answer_id = review_question_answer.question_answer_id ~r~n" + &
"INNER JOIN review_question ON review_question_answer.question_id = review_question.question_id ~r~n" + &
"INNER JOIN review_question_groups review_question_groups_1 ON review_question_groups_1.review_id = review_question.review_id AND  review_question_groups_1.group_id = review_question.sub_group_id ~r~n" + &
"LEFT OUTER JOIN review_question_groups ON review_question.review_id = review_question_groups.review_id AND review_question.group_id = review_question_groups.group_id ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_state ON group_practice.state = cl_state.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_end_time ON pd_review_hdr.review_end_time = cl_end_time.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_start_time ON pd_review_hdr.review_start_time = cl_start_time.lookup_code~r~n" + &
"ORDER BY pd_review_hdr.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_sp_certs') + "~r~n" + &
"  as select " + ls_Title + " pd_special_certs.rec_id,~r~n" + &
"    pd_special_certs.prac_id,~r~n" + &
"    pd_special_certs.certified_in,~r~n" + &
"    pd_special_certs.initial_cert_month,~r~n" + &
"    pd_special_certs.initial_cert_year,~r~n" + &
"    pd_special_certs.cert_expiration_month,~r~n" + &
"    pd_special_certs.cert_expiration_year,~r~n" + &
"    pd_special_certs.certification_number,~r~n" + &
"    exam_taken_code=code_lookup.code,~r~n" + &
"    pd_special_certs.certified_by,~r~n" + &
"    pd_special_certs.cust_1,~r~n" + &
"    pd_special_certs.cust_2,~r~n" + &
"    pd_special_certs.cust_3,~r~n" + &
"    pd_special_certs.cust_4,~r~n" + &
"    pd_special_certs.cust_5~r~n" + &
"from(~r~n" + &
"    pd_special_certs left outer join code_lookup on pd_special_certs.exam_taken = code_lookup.lookup_code)~r~n" + &
"order by pd_special_certs.rec_id,pd_special_certs.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_special_certs') + "~r~n" + &
"  as select distinct " + ls_Title + " pd_special_certs.rec_id,~r~n" + &
"    pd_special_certs.prac_id,~r~n" + &
"    pd_special_certs.initial_cert_month,~r~n" + &
"    pd_special_certs.initial_cert_year,~r~n" + &
"    pd_special_certs.cert_expiration_month,~r~n" + &
"    pd_special_certs.cert_expiration_year,~r~n" + &
"    pd_special_certs.certification_number,~r~n" + &
"    pd_special_certs.certified_in,~r~n" + &
"    pd_special_certs.cust_1,~r~n" + &
"    pd_special_certs.cust_2,~r~n" + &
"    pd_special_certs.cust_3,~r~n" + &
"    pd_special_certs.cust_4,~r~n" + &
"    pd_special_certs.cust_5,~r~n" + &
"    address_lookup.code as certified_by_code,~r~n" + &
"    address_lookup.entity_name as certified_by_name,~r~n" + &
"    code_lookup_a.code as certified_in_code,~r~n" + &
"    code_lookup_a.description as certified_in_description,~r~n" + &
"    code_lookup_b.description as exam_taken from~r~n" + &
"    pd_special_certs left outer join code_lookup as code_lookup_a on pd_special_certs.certified_in = code_lookup_a.lookup_code left outer join~r~n" + &
"    address_lookup on pd_special_certs.certified_by = address_lookup.lookup_code left outer join~r~n" + &
"    code_lookup as code_lookup_b on pd_special_certs.exam_taken = code_lookup_b.lookup_code~r~n" + &
"order by pd_special_certs.rec_id,pd_special_certs.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_specialty_facility_link') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_spec_facility_link.specialty_id, pd_spec_facility_link.prac_id, pd_spec_facility_link.facility_id, ~r~n" + &
"                      code_lookup.description AS practicing~r~n" + &
"FROM         pd_spec_facility_link INNER JOIN~r~n" + &
"                      code_lookup ON pd_spec_facility_link.practicing = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_spec_facility_link.specialty_id, pd_spec_facility_link.prac_id, pd_spec_facility_link.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_staff_cat') + "~r~n" + &
"as select distinct " + ls_Title + " pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id,facility_name=facility.facility_name,staff_cat_code=code_lookup_a.code,staff_cat_description=code_lookup_a.description,pd_affil_staff_cat.from_date,pd_affil_staff_cat.to_date,pd_affil_staff_cat.active_status from pd_affil_staff_cat,code_lookup as code_lookup_a,facility where(pd_affil_staff_cat.facility_id = facility.facility_id) and(pd_affil_staff_cat.staff_category = code_lookup_a.lookup_code) order by pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_staff_leave') + "~r~n" + &
"as select distinct " + ls_Title + " pd_affil_staff_leave.rec_id,pd_affil_staff_leave.prac_id,facility_name=facility.facility_name,leave_code=code_lookup_a.code,leave_description=code_lookup_a.description,pd_affil_staff_leave.from_date,pd_affil_staff_leave.to_date,pd_affil_staff_leave.active_status from pd_affil_staff_leave,code_lookup as code_lookup_b,code_lookup as code_lookup_a,facility where(pd_affil_staff_leave.facility_id = facility.facility_id) and(pd_affil_staff_leave.leave_of_absence_reason = code_lookup_b.lookup_code) order by pd_affil_staff_leave.rec_id,pd_affil_staff_leave.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_training') + "~r~n" + &
"  as select " + ls_Title + " pd_training.rec_id,~r~n" + &
"    pd_training.prac_id,~r~n" + &
"    training_type=code_lookup_a.description,~r~n" + &
"    pd_training.month_from,~r~n" + &
"    pd_training.year_from,~r~n" + &
"    pd_training.month_thru,~r~n" + &
"    pd_training.year_thru,~r~n" + &
"    pd_training.program_director,~r~n" + &
"    accred_code=code_lookup_e.code,~r~n" + &
"    specialty_name=code_lookup_b.description,~r~n" + &
"    internship_type=code_lookup_c.description,~r~n" + &
"    fellowhsip_type=code_lookup_d.description,~r~n" + &
"    pd_training.chief_res_month_from,~r~n" + &
"    pd_training.chief_res_year_from,~r~n" + &
"    pd_training.chief_res_month_thru,~r~n" + &
"    pd_training.chief_res_year_thru,~r~n" + &
"    institution_name=address_lookup.entity_name,~r~n" + &
"    pd_training.cust_1,~r~n" + &
"    pd_training.cust_2,~r~n" + &
"    pd_training.cust_3,~r~n" + &
"    pd_training.cust_4,~r~n" + &
"    pd_training.cust_5~r~n" + &
"from~r~n" + &
"    pd_training LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON pd_training.train_type = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_training.specialty = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_training.internship_type_code = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_training.fellowship_type_code = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON pd_training.accredited = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    address_lookup ON pd_training.institution_code = address_lookup.lookup_code~r~n" + &
"order by pd_training.rec_id,pd_training.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_verif_info') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + " ~r~n" + &
"                      verif_info.rec_id, verif_info.prac_id, verif_info.facility_id, facility.facility_name, verif_info.seq_no, verif_info.first_sent, ~r~n" + &
"                      verif_info.last_sent, verif_info.number_sent, verif_info.date_recieved, verif_info.user_name, code_lookup_a.code AS response_code, ~r~n" + &
"                      code_lookup_a.description AS response_descrip, code_lookup_b.code AS method_code, code_lookup_b.description AS method_descrip, ~r~n" + &
"                      data_view_screen.screen_name, data_view_screen.screen_id, verif_info.active_status, verif_info.expiration_date, ~r~n" + &
"                      verif_info.reference_value, verif_info.priority_user, verif_info.priority, verif_info.exp_credential_flag, verif_info.doc_id, ~r~n" + &
"                      verif_info.print_flag, verif_info.notes, verif_info.source, ~r~n" + &
"                      CASE verif_info.priority WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium' WHEN 3 THEN 'High' ELSE 'Unknown' END AS priority_description~r~n" + &
"FROM         verif_info INNER JOIN~r~n" + &
"                      data_view_screen ON verif_info.screen_id = data_view_screen.screen_id INNER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON verif_info.verification_method = code_lookup_b.lookup_code INNER JOIN~r~n" + &
"                      facility ON verif_info.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON verif_info.response_code = code_lookup_a.lookup_code~r~n" + &
"WHERE     (data_view_screen.data_view_id = 1)~r~n" + &
"ORDER BY verif_info.rec_id, verif_info.prac_id, verif_info.facility_id,verif_info.seq_no,verif_info.doc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('view_group_practice') + "~r~n" + &
"  as select " + ls_Title + " locat_id=group_practice.rec_id,~r~n" + &
"    group_practice.prac_id,~r~n" + &
"    prac_type_code=code_lookup_d.code,~r~n" + &
"    prac_type=code_lookup_d.description,~r~n" + &
"    group_practice.street,~r~n" + &
"    group_practice.city,~r~n" + &
"    state_code=code_lookup_e.code,~r~n" + &
"    state_name=code_lookup_e.description,~r~n" + &
"    country_code=code_lookup_f.code,~r~n" + &
"    country_name=code_lookup_f.description,~r~n" + &
"    group_practice.pager_number,~r~n" + &
"    group_practice.phone,~r~n" + &
"    group_practice.ext,~r~n" + &
"    group_practice.fax,~r~n" + &
"    group_practice.zip,~r~n" + &
"    county_code=code_lookup_g.code,~r~n" + &
"    county_name=code_lookup_g.description,~r~n" + &
"    group_practice.contact_person,~r~n" + &
"    group_practice.tax_id,~r~n" + &
"    group_practice.tax_id_other_1,~r~n" + &
"    group_practice.tax_id_other_2,~r~n" + &
"    group_practice.business_mgr,~r~n" + &
"    group_practice.office_mgr,~r~n" + &
"    group_practice.e_mail_address,~r~n" + &
"    group_practice.web_address,~r~n" + &
"    group_practice.mon_from,~r~n" + &
"    group_practice.mon_to,~r~n" + &
"    group_practice.tue_from,~r~n" + &
"    group_practice.tue_to,~r~n" + &
"    group_practice.wed_from,~r~n" + &
"    group_practice.thu_from,~r~n" + &
"    group_practice.thu_to,~r~n" + &
"    group_practice.fri_from,~r~n" + &
"    group_practice.fri_to,~r~n" + &
"    group_practice.sat_from,~r~n" + &
"    group_practice.sat_to,~r~n" + &
"    group_practice.sun_from,~r~n" + &
"    group_practice.sun_to,~r~n" + &
"    group_practice.mon_from2,~r~n" + &
"    group_practice.mon_to2,~r~n" + &
"    group_practice.tue_from2,~r~n" + &
"    group_practice.tue_to2,~r~n" + &
"    group_practice.wed_from2,~r~n" + &
"    group_practice.wed_to2,~r~n" + &
"    group_practice.thu_from2,~r~n" + &
"    group_practice.thu_to2,~r~n" + &
"    group_practice.fri_from2,~r~n" + &
"    group_practice.fri_to2,~r~n" + &
"    group_practice.sat_from2,~r~n" + &
"    group_practice.sat_to2,~r~n" + &
"    group_practice.sun_from2,~r~n" + &
"    group_practice.sun_to2,~r~n" + &
"    group_practice.wed_to,~r~n" + &
"    group_practice.routine_visit_appt,~r~n" + &
"    group_practice.urgent_visit_appt,~r~n" + &
"    group_practice.emergency_visit_appt,~r~n" + &
"    group_practice.non_emergency_appt,~r~n" + &
"    young_child_code=code_lookup_h.code,~r~n" + &
"    child_code=code_lookup_i.code,~r~n" + &
"    adolescent_code=code_lookup_j.code,~r~n" + &
"    adult_code=code_lookup_k.code,~r~n" + &
"    senior_code=code_lookup_l.code,~r~n" + &
"    handicap_acc=code_lookup_m.description,~r~n" + &
"    on_public_trans=code_lookup_n.description,~r~n" + &
"    group_practice.cust_1,~r~n" + &
"    group_practice.cust_2,~r~n" + &
"    group_practice.cust_3,~r~n" + &
"    group_practice.cust_4,~r~n" + &
"    group_practice.cust_5,~r~n" + &
"    group_practice.cust_6,~r~n" + &
"    group_practice.street_2,~r~n" + &
"    group_practice.gp_id,~r~n" + &
"    accepting_new_patient=code_lookup_p.description~r~n" + &
"from((((((((((((~r~n" + &
"    group_practice left outer join code_lookup as code_lookup_d on group_practice.practice_type = code_lookup_d.lookup_code) left outer join code_lookup as code_lookup_e on group_practice.state = code_lookup_e.lookup_code) left outer join code_lookup as code_lookup_f on group_practice.country = code_lookup_f.lookup_code) left outer join code_lookup as code_lookup_g on group_practice.county = code_lookup_g.lookup_code) left outer join code_lookup as code_lookup_h on group_practice.young_child = code_lookup_h.lookup_code) left outer join code_lookup as code_lookup_i on group_practice.child = code_lookup_i.lookup_code) left outer join code_lookup as code_lookup_j on group_practice.adolescent = code_lookup_j.lookup_code) left outer join code_lookup as code_lookup_k on group_practice.adult = code_lookup_k.lookup_code) left outer join code_lookup as code_lookup_l on group_practice.senior_adult = code_lookup_l.lookup_code) left outer join code_lookup as code_lookup_m on group_practice.handicapped_access = code_lookup_m.lookup_code) left outer join code_lookup as code_lookup_n on group_practice.public_transportation = code_lookup_n.lookup_code) left outer join code_lookup as code_lookup_p on group_practice.accepting_new_patients = code_lookup_p.lookup_code)~r~n" + &
"order by group_practice.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('view_pd_basic') + "~r~n" + &
"as select " + ls_Title + " pd_basic.rec_id,pd_basic.prac_id,pd_basic.first_name,pd_basic.last_name,pd_basic.middle_name,pd_basic.title,title_code=code_lookup_a.code,title_description=code_lookup_a.description,pd_basic.name_suffix,name_suffix_code=code_lookup_b.code,name_suffix_description=code_lookup_b.description,pd_basic.prof_suffix,prof_suffix_code=code_lookup_c.code,prof_suffix_description=code_lookup_c.description,pd_basic.date_of_birth,pd_basic.ssn,pd_basic.sex,gender_code=code_lookup_d.code,gender_description=code_lookup_d.description,pd_basic.prac_category,prac_category_code=code_lookup_e.code,prac_category_description=code_lookup_e.description,pd_basic.maiden_other_name,pd_basic.pob_city,pd_basic.pob_state,pd_basic.pob_country,pd_basic.citizenship,pd_basic.married,pd_basic.spouse_name,pd_basic.phone,pd_basic.answering_service,pd_basic.beeper_1,pd_basic.beeper_2,pd_basic.personal_pager,pd_basic.hospital_pager,pd_basic.car_phone_1,pd_basic.car_phone_2,pd_basic.civilian_fed_employee,pd_basic.active_military,pd_basic.reservist,pd_basic.branch,pd_basic.rank,pd_basic.service_number,pd_basic.service_date_from,pd_basic.service_date_to,pd_basic.cust_1,pd_basic.cust_2,pd_basic.cust_3,pd_basic.cust_4,pd_basic.cust_5,pd_basic.cust_6,pd_basic.cust_7,pd_basic.cust_8,pd_basic.cust_9,pd_basic.cust_10,pd_basic.full_name,pd_basic.npdb_query,pd_basic.provider_id,pd_basic.provider_type from((pd_basic left outer join code_lookup as code_lookup_b on pd_basic.name_suffix = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_d on pd_basic.sex = code_lookup_d.lookup_code),code_lookup as code_lookup_a,code_lookup as code_lookup_c,code_lookup as code_lookup_e where(pd_basic.title = code_lookup_a.lookup_code) and(pd_basic.prof_suffix = code_lookup_c.lookup_code) and(pd_basic.prac_category = code_lookup_e.lookup_code) order by pd_basic.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-24 By: Scofield
//$<Reason> The user need to add two view
ls_sql = of_get_view_action('v_contract_group_linked_locations') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"        group_practice.rec_id,~r~n" + &
"        group_practice.practice_type, ~r~n" + &
"        group_practice.street,~r~n" + &
"        group_practice.street_2,~r~n" + &
"        group_practice.city,~r~n" + &
"        group_practice.state,~r~n" + &
"        group_practice.zip,~r~n" + &
"        group_practice.tax_id,~r~n" + &
"        ctx_loc.ctx_id,~r~n" + &
"        ctx_loc.parent_comp_id,~r~n" + &
"        ctx_loc.loc_id,~r~n" + &
"        ctx_loc.group_number,~r~n" + &
"        ctx_loc.local,~r~n" + &
"        ctx_loc.end_date,~r~n" + &
"        ctx_loc.term_reason,~r~n" + &
"        ctx_loc.start_date,~r~n" + &
"        ctx_loc.custom_1,~r~n" + &
"        ctx_loc.custom_2,~r~n" + &
"        ctx_loc.custom_3,~r~n" + &
"        ctx_loc.custom_4,~r~n" + &
"        ctx_loc.inserted_by_user,~r~n" + &
"        ctx_loc.inserted_at_date_time,~r~n" + &
"        ctx_loc.updated_by_user,~r~n" + &
"        ctx_loc.updated_at_date_time,~r~n" + &
"        ctx_loc.record_id~r~n" + &
"FROM 	group_practice,~r~n" + &
"        ctx_loc  ~r~n" + &
"WHERE ( ctx_loc.loc_id = group_practice.rec_id )~r~n" + &
"ORDER BY ctx_loc.ctx_id,~r~n" + &
"	 ctx_loc.parent_comp_id,~r~n" + &
"	 ctx_loc.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_action_items') + "~r~n" + &
"as SELECT " + ls_Title + "~r~n" + &
"	ctx_action_items.ctx_action_item_id,~r~n" + &
"	ctx_action_items.ctx_id,~r~n" + &
"	ctx_action_items.action_type,~r~n" + &
"	ctx_action_items.action_date,~r~n" + &
"	ctx_action_items.due_date,~r~n" + &
"	ctx_action_items.action_user,~r~n" + &
"	ctx_action_items.action_status,~r~n" + &
"	ctx_action_items.notes,~r~n" + &
"	ctx_action_items.ALARMED,~r~n" + &
"	ctx_action_items.first_attempt,~r~n" + &
"	ctx_action_items.last_attempt,~r~n" + &
"	ctx_action_items.no_attempts,~r~n" + &
"	ctx_action_items.assigned_to,~r~n" + &
"	ctx_action_items.print_flag,~r~n" + &
"	ctx_action_items.inserted_by_user,~r~n" + &
"	ctx_action_items.inserted_at_date_time,~r~n" + &
"	ctx_action_items.updated_by_user,~r~n" + &
"	ctx_action_items.updated_at_date_time,~r~n" + &
"	ctx_action_items.record_id,~r~n" + &
"	ctx_action_items.Letter_flag,~r~n" + &
"	ctx_action_items.letter_to,~r~n" + &
"	ctx_action_items.letter_from~r~n" + &
"FROM 	ctx_action_items~r~n" + &
"ORDER BY ctx_action_items.ctx_action_item_id,~r~n" + &
"	 ctx_action_items.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//---------------------------- APPEON END ----------------------------

of_execute_sql()

return 0

end function

public function string of_get_view_action (string as_view_name);//////////////////////////////////////////////////////////////////////
// $<function>of_get_view_action()
// $<arguments>
//		value	string	as_view_name		
// $<returns> string
// $<description>Determine whether the specified view already exists or not
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
int  li_count


select count(1) into :li_count from sysobjects where name=:as_view_name;

IF li_count > 0  THEN
	return "ALTER VIEW "+as_view_name+" "
ELSE
	return "CREATE VIEW "+as_view_name+" "
END IF


end function

on n_cst_view_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_view_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 23/03/2007 By: Jervis
//$<reason> 
ids_temp = create datastore

ids_temp.dataobject = "d_update_user_datawindow_objlist"
//---------------------------- APPEON END ----------------------------

end event

event destructor;if isvalid(ids_temp) then destroy ids_temp	//03/23/2007 By Jervis

if isvalid(lds_db_control) then destroy lds_db_control  //07.24.2007 By Jervis
end event

