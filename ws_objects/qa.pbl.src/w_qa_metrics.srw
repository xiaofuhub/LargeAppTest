$PBExportHeader$w_qa_metrics.srw
forward
global type w_qa_metrics from w_main
end type
type cb_import from u_cb within w_qa_metrics
end type
type st_1 from statictext within w_qa_metrics
end type
type st_count from statictext within w_qa_metrics
end type
type dw_detail from u_dw within w_qa_metrics
end type
type cb_add from u_cb within w_qa_metrics
end type
type cb_delete from u_cb within w_qa_metrics
end type
type cb_save from u_cb within w_qa_metrics
end type
type cb_close from u_cb within w_qa_metrics
end type
type cb_sort from u_cb within w_qa_metrics
end type
type cb_filter from u_cb within w_qa_metrics
end type
type cb_print from u_cb within w_qa_metrics
end type
type cb_saveas from u_cb within w_qa_metrics
end type
type cb_test from u_cb within w_qa_metrics
end type
type dw_users from datawindow within w_qa_metrics
end type
end forward

global type w_qa_metrics from w_main
integer x = 5
integer y = 312
integer width = 4626
integer height = 2112
string title = "QA Metrics"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_import cb_import
st_1 st_1
st_count st_count
dw_detail dw_detail
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
cb_sort cb_sort
cb_filter cb_filter
cb_print cb_print
cb_saveas cb_saveas
cb_test cb_test
dw_users dw_users
end type
global w_qa_metrics w_qa_metrics

type variables
String is_lookup_name
String is_lookup_type

Boolean ib_new_table = False

Integer ii_delete_cnt
Integer ii_dept_secure_setting = 0


Long il_lookup_code
Long il_department_code[]

// MSKINNER 09 March 2006 -- begin
boolean ib_refresh_cache /*flag set to true if we update a contact table (at the close of the window)*/


// MSKINNER 09 March 2006 -- end 

n_cst_code_lookup_audit inv_audit //Added by Evan on 2008-01-26
end variables

forward prototypes
public function string of_test_delete (string as_type, long as_code)
public function integer of_add_security_dept (integer ai_row)
public function integer wf_refresh_ctx_cache ()
public function integer of_count ()
public subroutine of_addright (long al_category, string as_lookname)
public subroutine wf_refreshcoltitle (string as_lookup_type, string as_lookup_name)
public subroutine wf_setcollabel (string as_labelname)
public subroutine wf_updateuserdefinfo (string as_lookup_type, string as_lookup_name)
public function integer of_addlookupname ()
end prototypes

public function string of_test_delete (string as_type, long as_code);//maha created 021904 called from delete and test records.

long l_code
//long cnt
string ls_text
//SetPointer ( hourglass! )
string s_code

l_code = as_code
s_code = string(l_code)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.08.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
if as_type = "A" then // "d_address_lookup" 
	select count(prac_id) into :cnt from pd_education where school_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_education.school_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_acedemic_appointments where school_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_acedemic_appointments.school_code field.~r"
	end if	
	select count(prac_id) into :cnt from pd_insurance where carrier_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_insurance.carrier_code field.~r"
	end if	
	select count(prac_id) into :cnt from pd_board_specialty where board_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_board_specialty.board_code field.~r"
	end if	
	select count(prac_id) into :cnt from pd_license where verifying_agency = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_license.verifying_agency field.~r"
	end if	
	select count(prac_id) into :cnt from pd_other_affill where institution_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_other_affill.institution_code field.~r"
	end if	
	select count(prac_id) into :cnt from pd_training where institution_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_training.institution_code field.~r"
	end if	
	select count(prac_id) into :cnt from pd_hosp_affil where hospital_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.hospital_code field.~r"
	end if	

	
elseif as_type = "C" then  // "d_code_lookup" 
	
	select count(prac_id) into :cnt from pd_acedemic_appointments where department_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_acedemic_appointments.department_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_acedemic_appointments where faculty_rank_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_acedemic_appointments.faculty_rank_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where accepting_new_patients = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.accepting_new_patients field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where adolescent = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.adolescent field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where adult = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.adult field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where child = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.child field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where country = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.country field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where county = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.county field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where handicapped_access = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.handicapped_access field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where office_in_home = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.office_in_home field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where practice_type = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.practice_type field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where public_transportation = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.public_transportation field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where senior_adult = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.senior_adult field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where state = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.state field.~r"
	end if
	select count(prac_id) into :cnt from pd_address where young_child = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address.young_child field.~r"
	end if
	select count(prac_id) into :cnt from pd_affil_staff_leave where leave_of_absence_reason = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_affil_staff_leave.leave_of_absence_reason field.~r"
	end if
	select count(prac_id) into :cnt from pd_affil_staff_cat where staff_category = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_affil_staff_cat.staff_category field.~r"
	end if
	select count(prac_id) into :cnt from pd_affil_stat where affil_ended_reason = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_affil_stat.affil_ended_reason field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where married = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.married field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where name_suffix = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.name_suffix field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where pob_country = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.pob_country field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where pob_state = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.pob_state field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where prac_category = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.prac_category field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where prof_suffix = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.prof_suffix field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where provider_type = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.provider_type field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where rank = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.rank field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where sex = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.sex(gender) field.~r"
	end if
	select count(prac_id) into :cnt from pd_basic where title = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_basic.title field.~r"
	end if
	select count(prac_id) into :cnt from pd_board_specialty where specialty = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_board_specialty.specialty field.~r"
	end if
	select count(prac_id) into :cnt from pd_board_specialty where specialty_order = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_board_specialty.specialty_order field.~r"
	end if
	select count(prac_id) into :cnt from pd_claims where status_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_claims.status_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_clinical_specialties where specialty_expertise = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_clinical_specialties.specialty_expertise field.~r"
	end if
	select count(prac_id) into :cnt from pd_clinical_specialties where rank = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_clinical_specialties.rank field.~r"
	end if
	select count(prac_id) into :cnt from pd_postgrad_train where category = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_postgrad_train.category field.~r"
	end if
	select count(prac_id) into :cnt from pd_postgrad_train where loc_state = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_postgrad_train.loc_state field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_1 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_1 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_2 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_2 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_3 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_3 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_4 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_4 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_5 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_5 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_6 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_6 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_7 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_7 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_8 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_8 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_9 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_9 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where cat_10 = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.cat_10 field.~r"
	end if
	select count(prac_id) into :cnt from pd_dea_state_csr where state = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_dea_state_csr.state field.~r"
	end if
	select count(prac_id) into :cnt from pd_affil_dept where department = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_affil_dept.department field.~r"
	end if
	select count(prac_id) into :cnt from pd_affil_dept where rank = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_affil_dept.rank(division) field.~r"
	end if
	select count(prac_id) into :cnt from pd_affil_dept where section = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_affil_dept.section field.~r"
	end if
	select count(prac_id) into :cnt from pd_education where education_type = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_education.education_type field.~r"
	end if
	select count(prac_id) into :cnt from pd_education where degree = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_education.degree field.~r"
	end if
	select count(prac_id) into :cnt from pd_group_providers where specialty = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_group_providers.specialty field.~r"
	end if
	select count(prac_id) into :cnt from pd_group_providers where covering = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_group_providers.covering field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where department_a = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.department_a field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where department_b = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.department_b field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where department_c = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.department_c field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where section_a = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.section_a field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where section_b = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.section_b field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where section_c = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.section_c field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where admitting_priv = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.admitting_priv field.~r"
	end if
	select count(prac_id) into :cnt from pd_hosp_affil where staff_category = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_hosp_affil.staff_category field.~r"
	end if
	select count(prac_id) into :cnt from pd_insurance where claims_made_occurrence = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_insurance.claims_made_occurrence field.~r"
	end if	
	select count(prac_id) into :cnt from pd_insurance where state_coverage = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_insurance.state_coverage field.~r"
	end if
	select count(prac_id) into :cnt from pd_insurance where state_funded_pool = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_insurance.state_funded_pool field.~r"
	end if
	select count(prac_id) into :cnt from pd_insurance where tail_coverage = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_insurance.tail_coverage field.~r"
	end if
	select count(prac_id) into :cnt from pd_languages where foreign_language = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_languages.foreign_language field.~r"
	end if
	select count(prac_id) into :cnt from pd_languages where speak = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_languages.speak field.~r"
	end if
	select count(prac_id) into :cnt from pd_languages where sign = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_languages.sign field.~r"
	end if
	select count(prac_id) into :cnt from pd_languages where writes = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_languages.writes field.~r"
	end if
	select count(prac_id) into :cnt from pd_languages where reads = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_languages.reads field.~r"
	end if
	select count(prac_id) into :cnt from pd_license where license_type_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_license.license_type_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_license where state = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_license.state field.~r"
	end if
	select count(prac_id) into :cnt from pd_other_affill where function_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_other_affill.function_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_other_ids where id_type = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_other_ids.id_type field.~r"
	end if
	select count(prac_id) into :cnt from pd_address_2 where work_comp_state = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_address_2.work_comp_state field.~r"
	end if
	select count(prac_id) into :cnt from pd_references where name_suffix = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_references.name_suffix field.~r"
	end if
	select count(prac_id) into :cnt from pd_references where country = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_references.country.~r"
	end if
	select count(prac_id) into :cnt from pd_references where title = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_references.title.~r"
	end if
	select count(prac_id) into :cnt from pd_references where state = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_references.state.~r"
	end if
	select count(prac_id) into :cnt from pd_references where prof_suffix = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_references.prof_suffix field.~r"
	end if
	select count(prac_id) into :cnt from pd_sanctions where action_sanction_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_sanctions.action_sanction_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_sanctions where status_activity_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_sanctions.status_activity_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_special_certs where certified_in = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_special_certs.certified_in field.~r"
	end if
	select count(prac_id) into :cnt from pd_training where fellowship_type_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_training.fellowship_type_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_training where internship_type_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_training.internship_type_code field.~r"
	end if
	select count(prac_id) into :cnt from pd_training where train_type = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_training.train_type field.~r"
	end if
	select count(prac_id) into :cnt from pd_training where specialty = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_training.specialty field.~r"
	end if
	select count(prac_id) into :cnt from pd_priv_list where status_code = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the pd_priv_list.status_code field.~r"
	end if
	
	select count(prac_id) into :cnt from net_dev_action_items where action_type = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the net_dev_action_items.action_type field.~r"
	end if
		select count(prac_id) into :cnt from net_dev_action_items where action_status = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the net_dev_action_items.action_status field.~r"
	end if
		select count(prac_id) into :cnt from net_dev_action_items where action_dept = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the net_dev_action_items.action_dept field.~r"
	end if
		select count(prac_id) into :cnt from net_dev_ids where plan_type = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the net_dev_ids.plan_type field.~r"
	end if
		select count(prac_id) into :cnt from net_dev_ids where tier = :l_code;
	if cnt > 0 then
		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the net_dev_ids.tier field.~r"
	end if
//		select count(prac_id) into :cnt from net_dev_ids where * = :l_code;
//	if cnt > 0 then
//		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the net_dev_ids.* field.~r"
//	end if
	
//	select count(prac_id) into :cnt from * where * = :l_code;
//	if cnt > 0 then
//		ls_text = ls_text + "There are " + string(cnt) + " record(s) in the *.* field.~r"
//	end if
end if
*/

long 	cnt00,cnt01,cnt02,cnt03,cnt04,cnt05,cnt06,cnt07,cnt08,cnt09,&
		cnt10,cnt11,cnt12,cnt13,cnt14,cnt15,cnt16,cnt17,cnt18,cnt19,&
		cnt20,cnt21,cnt22,cnt23,cnt24,cnt25,cnt26,cnt27,cnt28,cnt29,&
		cnt30,cnt31,cnt32,cnt33,cnt34,cnt35,cnt36,cnt37,cnt38,cnt39,&
		cnt40,cnt41,cnt42,cnt43,cnt44,cnt45,cnt46,cnt47,cnt48,cnt49,&
		cnt50,cnt51,cnt52,cnt53,cnt54,cnt55,cnt56,cnt57,cnt58,cnt59,&
		cnt60,cnt61,cnt62,cnt63,cnt64,cnt65,cnt66,cnt67,cnt68,cnt69,&
		cnt70,cnt71,cnt72,cnt73,cnt74,cnt75,cnt76,cnt77,cnt78,cnt79,&
		cnt80,cnt81,cnt82,cnt83,cnt84,cnt85,cnt86,cnt87,cnt88,cnt89,&
		cnt90,cnt91,cnt92,cnt93,cnt94,cnt95,cnt96,cnt97,cnt98,cnt99



if as_type = "A" then // "d_address_lookup" 

	gnv_appeondb.of_startqueue( )
	
	select count(prac_id) into :cnt00 from pd_education where school_code = :l_code;
	select count(prac_id) into :cnt01 from pd_acedemic_appointments where school_code = :l_code;
	select count(prac_id) into :cnt02 from pd_insurance where carrier_code = :l_code;
	select count(prac_id) into :cnt03 from pd_board_specialty where board_code = :l_code;
	select count(prac_id) into :cnt04 from pd_license where verifying_agency = :l_code;
	select count(prac_id) into :cnt05 from pd_other_affill where institution_code = :l_code;
	select count(prac_id) into :cnt06 from pd_training where institution_code = :l_code;
	select count(prac_id) into :cnt07 from pd_hosp_affil where hospital_code = :l_code;

	gnv_appeondb.of_commitqueue( )

	if cnt00 > 0 then
		ls_text = ls_text + "There are " + string(cnt00) + " record(s) in the pd_education.school_code field.~r"
	end if
	if cnt01 > 0 then
		ls_text = ls_text + "There are " + string(cnt01) + " record(s) in the pd_acedemic_appointments.school_code field.~r"
	end if	
	if cnt02 > 0 then
		ls_text = ls_text + "There are " + string(cnt02) + " record(s) in the pd_insurance.carrier_code field.~r"
	end if	
	if cnt03 > 0 then
		ls_text = ls_text + "There are " + string(cnt03) + " record(s) in the pd_board_specialty.board_code field.~r"
	end if	
	if cnt04 > 0 then
		ls_text = ls_text + "There are " + string(cnt04) + " record(s) in the pd_license.verifying_agency field.~r"
	end if	
	if cnt05 > 0 then
		ls_text = ls_text + "There are " + string(cnt05) + " record(s) in the pd_other_affill.institution_code field.~r"
	end if	
	if cnt06 > 0 then
		ls_text = ls_text + "There are " + string(cnt06) + " record(s) in the pd_training.institution_code field.~r"
	end if	
	if cnt07 > 0 then
		ls_text = ls_text + "There are " + string(cnt07) + " record(s) in the pd_hosp_affil.hospital_code field.~r"
	end if	

elseif as_type = "C" then  // "d_code_lookup" 
	
	gnv_appeondb.of_startqueue( )
	
	select count(prac_id) into :cnt00 from pd_acedemic_appointments where department_code = :l_code;
	select count(prac_id) into :cnt01 from pd_acedemic_appointments where faculty_rank_code = :l_code;
	select count(prac_id) into :cnt02 from pd_address where accepting_new_patients = :l_code;
	select count(prac_id) into :cnt03 from pd_address where adolescent = :l_code;
	select count(prac_id) into :cnt04 from pd_address where adult = :l_code;
	select count(prac_id) into :cnt05 from pd_address where child = :l_code;
	select count(prac_id) into :cnt06 from pd_address where country = :l_code;
	select count(prac_id) into :cnt07 from pd_address where county = :l_code;
	select count(prac_id) into :cnt08 from pd_address where handicapped_access = :l_code;
	select count(prac_id) into :cnt09 from pd_address where office_in_home = :l_code;
	select count(prac_id) into :cnt10 from pd_address where practice_type = :l_code;
	select count(prac_id) into :cnt11 from pd_address where public_transportation = :l_code;
	select count(prac_id) into :cnt12 from pd_address where senior_adult = :l_code;
	select count(prac_id) into :cnt13 from pd_address where state = :l_code;
	select count(prac_id) into :cnt14 from pd_address where young_child = :l_code;
	//select count(prac_id) into :cnt15 from pd_affil_staff_leave where leave_of_absence_reason = :l_code;
	select count(prac_id) into :cnt15 from pd_affil_staff_leave where leave_of_absence_reason = :s_code;  //Modified by (Appeon)Harry 05.23.2016
	select count(prac_id) into :cnt16 from pd_affil_staff_cat where staff_category = :l_code;
	select count(prac_id) into :cnt17 from pd_affil_stat where affil_ended_reason = :l_code;
	select count(prac_id) into :cnt18 from pd_basic where married = :l_code;
	select count(prac_id) into :cnt19 from pd_basic where name_suffix = :l_code;
	select count(prac_id) into :cnt20 from pd_basic where pob_country = :l_code;
	select count(prac_id) into :cnt21 from pd_basic where pob_state = :l_code;
	select count(prac_id) into :cnt22 from pd_basic where prac_category = :l_code;
	select count(prac_id) into :cnt23 from pd_basic where prof_suffix = :l_code;
	select count(prac_id) into :cnt24 from pd_basic where provider_type = :l_code;
	select count(prac_id) into :cnt25 from pd_basic where rank = :l_code;
	select count(prac_id) into :cnt26 from pd_basic where sex = :l_code;
	select count(prac_id) into :cnt27 from pd_basic where title = :l_code;
	select count(prac_id) into :cnt28 from pd_board_specialty where specialty = :l_code;
	select count(prac_id) into :cnt29 from pd_board_specialty where specialty_order = :l_code;
	select count(prac_id) into :cnt30 from pd_claims where status_code = :l_code;
	select count(prac_id) into :cnt31 from pd_clinical_specialties where specialty_expertise = :l_code;
	select count(prac_id) into :cnt32 from pd_clinical_specialties where rank = :l_code;
	select count(prac_id) into :cnt33 from pd_postgrad_train where category = :l_code;
	select count(prac_id) into :cnt34 from pd_postgrad_train where loc_state = :l_code;
	select count(prac_id) into :cnt35 from pd_dea_state_csr where cat_1 = :l_code;
	select count(prac_id) into :cnt36 from pd_dea_state_csr where cat_2 = :l_code;
	select count(prac_id) into :cnt37 from pd_dea_state_csr where cat_3 = :l_code;
	select count(prac_id) into :cnt38 from pd_dea_state_csr where cat_4 = :l_code;
	select count(prac_id) into :cnt39 from pd_dea_state_csr where cat_5 = :l_code;
	select count(prac_id) into :cnt40 from pd_dea_state_csr where cat_6 = :l_code;
	select count(prac_id) into :cnt41 from pd_dea_state_csr where cat_7 = :l_code;
	select count(prac_id) into :cnt42 from pd_dea_state_csr where cat_8 = :l_code;
	select count(prac_id) into :cnt43 from pd_dea_state_csr where cat_9 = :l_code;
	select count(prac_id) into :cnt44 from pd_dea_state_csr where cat_10 = :l_code;
	select count(prac_id) into :cnt45 from pd_dea_state_csr where state = :l_code;
	select count(prac_id) into :cnt46 from pd_affil_dept where department = :l_code;
	select count(prac_id) into :cnt47 from pd_affil_dept where rank = :l_code;
	select count(prac_id) into :cnt48 from pd_affil_dept where section = :l_code;
	select count(prac_id) into :cnt49 from pd_education where education_type = :l_code;
	select count(prac_id) into :cnt50 from pd_education where degree = :l_code;
	select count(prac_id) into :cnt51 from pd_group_providers where specialty = :l_code;
	select count(prac_id) into :cnt52 from pd_group_providers where covering = :l_code;
	select count(prac_id) into :cnt53 from pd_hosp_affil where department_a = :l_code;
	select count(prac_id) into :cnt54 from pd_hosp_affil where department_b = :l_code;
	select count(prac_id) into :cnt55 from pd_hosp_affil where department_c = :l_code;
	select count(prac_id) into :cnt56 from pd_hosp_affil where section_a = :l_code;
	select count(prac_id) into :cnt57 from pd_hosp_affil where section_b = :l_code;
	select count(prac_id) into :cnt58 from pd_hosp_affil where section_c = :l_code;
	select count(prac_id) into :cnt59 from pd_hosp_affil where admitting_priv = :l_code;
	select count(prac_id) into :cnt60 from pd_hosp_affil where staff_category = :l_code;
	select count(prac_id) into :cnt61 from pd_insurance where claims_made_occurrence = :l_code;
	select count(prac_id) into :cnt62 from pd_insurance where state_coverage = :l_code;
	select count(prac_id) into :cnt63 from pd_insurance where state_funded_pool = :l_code;
	select count(prac_id) into :cnt64 from pd_insurance where tail_coverage = :l_code;
	select count(prac_id) into :cnt65 from pd_languages where foreign_language = :l_code;
	select count(prac_id) into :cnt66 from pd_languages where speak = :l_code;
	select count(prac_id) into :cnt67 from pd_languages where sign = :l_code;
	select count(prac_id) into :cnt68 from pd_languages where writes = :l_code;
	select count(prac_id) into :cnt69 from pd_languages where reads = :l_code;
	select count(prac_id) into :cnt70 from pd_license where license_type_code = :l_code;
	select count(prac_id) into :cnt71 from pd_license where state = :l_code;
	select count(prac_id) into :cnt72 from pd_other_affill where function_code = :l_code;
	select count(prac_id) into :cnt73 from pd_other_ids where id_type = :l_code;
	select count(prac_id) into :cnt74 from pd_address_2 where work_comp_state = :l_code;
	select count(prac_id) into :cnt75 from pd_references where name_suffix = :l_code;
	select count(prac_id) into :cnt76 from pd_references where country = :l_code;
	select count(prac_id) into :cnt77 from pd_references where title = :l_code;
	select count(prac_id) into :cnt78 from pd_references where state = :l_code;
	select count(prac_id) into :cnt79 from pd_references where prof_suffix = :l_code;
	select count(prac_id) into :cnt80 from pd_sanctions where action_sanction_code = :l_code;
	select count(prac_id) into :cnt81 from pd_sanctions where status_activity_code = :l_code;
	select count(prac_id) into :cnt82 from pd_special_certs where certified_in = :l_code;
	select count(prac_id) into :cnt83 from pd_training where fellowship_type_code = :l_code;
	select count(prac_id) into :cnt84 from pd_training where internship_type_code = :l_code;
	select count(prac_id) into :cnt85 from pd_training where train_type = :l_code;
	select count(prac_id) into :cnt86 from pd_training where specialty = :l_code;
	select count(prac_id) into :cnt87 from pd_priv_list where status_code = :l_code;
	select count(prac_id) into :cnt88 from net_dev_action_items where action_type = :l_code;
	select count(prac_id) into :cnt89 from net_dev_action_items where action_status = :l_code;
	select count(prac_id) into :cnt90 from net_dev_action_items where action_dept = :l_code;
	select count(prac_id) into :cnt91 from net_dev_ids where plan_type = :l_code;
	select count(prac_id) into :cnt92 from net_dev_ids where tier = :l_code;


	gnv_appeondb.of_commitqueue( )

	if cnt00 > 0 then
		ls_text = ls_text + "There are " + string(cnt00) + " record(s) in the pd_acedemic_appointments.department_code field.~r"
	end if
	if cnt01 > 0 then
		ls_text = ls_text + "There are " + string(cnt01) + " record(s) in the pd_acedemic_appointments.faculty_rank_code field.~r"
	end if
	if cnt02 > 0 then
		ls_text = ls_text + "There are " + string(cnt02) + " record(s) in the pd_address.accepting_new_patients field.~r"
	end if
	if cnt03 > 0 then
		ls_text = ls_text + "There are " + string(cnt03) + " record(s) in the pd_address.adolescent field.~r"
	end if
	if cnt04 > 0 then
		ls_text = ls_text + "There are " + string(cnt04) + " record(s) in the pd_address.adult field.~r"
	end if
	if cnt05 > 0 then
		ls_text = ls_text + "There are " + string(cnt05) + " record(s) in the pd_address.child field.~r"
	end if
	if cnt06 > 0 then
		ls_text = ls_text + "There are " + string(cnt06) + " record(s) in the pd_address.country field.~r"
	end if
	if cnt07 > 0 then
		ls_text = ls_text + "There are " + string(cnt07) + " record(s) in the pd_address.county field.~r"
	end if
	if cnt08 > 0 then
		ls_text = ls_text + "There are " + string(cnt08) + " record(s) in the pd_address.handicapped_access field.~r"
	end if
	if cnt09 > 0 then
		ls_text = ls_text + "There are " + string(cnt09) + " record(s) in the pd_address.office_in_home field.~r"
	end if
	if cnt10 > 0 then
		ls_text = ls_text + "There are " + string(cnt10) + " record(s) in the pd_address.practice_type field.~r"
	end if
	if cnt11 > 0 then
		ls_text = ls_text + "There are " + string(cnt11) + " record(s) in the pd_address.public_transportation field.~r"
	end if
	if cnt12 > 0 then
		ls_text = ls_text + "There are " + string(cnt12) + " record(s) in the pd_address.senior_adult field.~r"
	end if
	if cnt13 > 0 then
		ls_text = ls_text + "There are " + string(cnt13) + " record(s) in the pd_address.state field.~r"
	end if
	if cnt14 > 0 then
		ls_text = ls_text + "There are " + string(cnt14) + " record(s) in the pd_address.young_child field.~r"
	end if
	if cnt15 > 0 then
		ls_text = ls_text + "There are " + string(cnt15) + " record(s) in the pd_affil_staff_leave.leave_of_absence_reason field.~r"
	end if
	if cnt16 > 0 then
		ls_text = ls_text + "There are " + string(cnt16) + " record(s) in the pd_affil_staff_cat.staff_category field.~r"
	end if
	if cnt17 > 0 then
		ls_text = ls_text + "There are " + string(cnt17) + " record(s) in the pd_affil_stat.affil_ended_reason field.~r"
	end if
	if cnt18 > 0 then
		ls_text = ls_text + "There are " + string(cnt18) + " record(s) in the pd_basic.married field.~r"
	end if
	if cnt19 > 0 then
		ls_text = ls_text + "There are " + string(cnt19) + " record(s) in the pd_basic.name_suffix field.~r"
	end if
	if cnt20 > 0 then
		ls_text = ls_text + "There are " + string(cnt20) + " record(s) in the pd_basic.pob_country field.~r"
	end if
	if cnt21 > 0 then
		ls_text = ls_text + "There are " + string(cnt21) + " record(s) in the pd_basic.pob_state field.~r"
	end if
	if cnt22 > 0 then
		ls_text = ls_text + "There are " + string(cnt22) + " record(s) in the pd_basic.prac_category field.~r"
	end if
	if cnt23 > 0 then
		ls_text = ls_text + "There are " + string(cnt23) + " record(s) in the pd_basic.prof_suffix field.~r"
	end if
	if cnt24 > 0 then
		ls_text = ls_text + "There are " + string(cnt24) + " record(s) in the pd_basic.provider_type field.~r"
	end if
	if cnt25 > 0 then
		ls_text = ls_text + "There are " + string(cnt25) + " record(s) in the pd_basic.rank field.~r"
	end if
	if cnt26 > 0 then
		ls_text = ls_text + "There are " + string(cnt26) + " record(s) in the pd_basic.sex(gender) field.~r"
	end if
	if cnt27 > 0 then
		ls_text = ls_text + "There are " + string(cnt27) + " record(s) in the pd_basic.title field.~r"
	end if
	if cnt28 > 0 then
		ls_text = ls_text + "There are " + string(cnt28) + " record(s) in the pd_board_specialty.specialty field.~r"
	end if
	if cnt29 > 0 then
		ls_text = ls_text + "There are " + string(cnt29) + " record(s) in the pd_board_specialty.specialty_order field.~r"
	end if
	if cnt30 > 0 then
		ls_text = ls_text + "There are " + string(cnt30) + " record(s) in the pd_claims.status_code field.~r"
	end if
	if cnt31 > 0 then
		ls_text = ls_text + "There are " + string(cnt31) + " record(s) in the pd_clinical_specialties.specialty_expertise field.~r"
	end if
	if cnt32 > 0 then
		ls_text = ls_text + "There are " + string(cnt32) + " record(s) in the pd_clinical_specialties.rank field.~r"
	end if
	if cnt33 > 0 then
		ls_text = ls_text + "There are " + string(cnt33) + " record(s) in the pd_postgrad_train.category field.~r"
	end if
	if cnt34 > 0 then
		ls_text = ls_text + "There are " + string(cnt34) + " record(s) in the pd_postgrad_train.loc_state field.~r"
	end if
	if cnt35 > 0 then
		ls_text = ls_text + "There are " + string(cnt35) + " record(s) in the pd_dea_state_csr.cat_1 field.~r"
	end if
	if cnt36 > 0 then
		ls_text = ls_text + "There are " + string(cnt36) + " record(s) in the pd_dea_state_csr.cat_2 field.~r"
	end if
	if cnt37 > 0 then
		ls_text = ls_text + "There are " + string(cnt37) + " record(s) in the pd_dea_state_csr.cat_3 field.~r"
	end if
	if cnt38 > 0 then
		ls_text = ls_text + "There are " + string(cnt38) + " record(s) in the pd_dea_state_csr.cat_4 field.~r"
	end if
	if cnt39 > 0 then
		ls_text = ls_text + "There are " + string(cnt39) + " record(s) in the pd_dea_state_csr.cat_5 field.~r"
	end if
	if cnt40 > 0 then
		ls_text = ls_text + "There are " + string(cnt40) + " record(s) in the pd_dea_state_csr.cat_6 field.~r"
	end if
	if cnt41 > 0 then
		ls_text = ls_text + "There are " + string(cnt41) + " record(s) in the pd_dea_state_csr.cat_7 field.~r"
	end if
	if cnt42 > 0 then
		ls_text = ls_text + "There are " + string(cnt42) + " record(s) in the pd_dea_state_csr.cat_8 field.~r"
	end if
	if cnt43 > 0 then
		ls_text = ls_text + "There are " + string(cnt43) + " record(s) in the pd_dea_state_csr.cat_9 field.~r"
	end if
	if cnt44 > 0 then
		ls_text = ls_text + "There are " + string(cnt44) + " record(s) in the pd_dea_state_csr.cat_10 field.~r"
	end if
	if cnt45 > 0 then
		ls_text = ls_text + "There are " + string(cnt45) + " record(s) in the pd_dea_state_csr.state field.~r"
	end if
	if cnt46 > 0 then
		ls_text = ls_text + "There are " + string(cnt46) + " record(s) in the pd_affil_dept.department field.~r"
	end if
	if cnt47 > 0 then
		ls_text = ls_text + "There are " + string(cnt47) + " record(s) in the pd_affil_dept.rank(division) field.~r"
	end if
	if cnt48 > 0 then
		ls_text = ls_text + "There are " + string(cnt48) + " record(s) in the pd_affil_dept.section field.~r"
	end if
	if cnt49 > 0 then
		ls_text = ls_text + "There are " + string(cnt49) + " record(s) in the pd_education.education_type field.~r"
	end if
	if cnt50 > 0 then
		ls_text = ls_text + "There are " + string(cnt50) + " record(s) in the pd_education.degree field.~r"
	end if
	if cnt51 > 0 then
		ls_text = ls_text + "There are " + string(cnt51) + " record(s) in the pd_group_providers.specialty field.~r"
	end if
	if cnt52 > 0 then
		ls_text = ls_text + "There are " + string(cnt52) + " record(s) in the pd_group_providers.covering field.~r"
	end if
	if cnt53 > 0 then
		ls_text = ls_text + "There are " + string(cnt53) + " record(s) in the pd_hosp_affil.department_a field.~r"
	end if
	if cnt54 > 0 then
		ls_text = ls_text + "There are " + string(cnt54) + " record(s) in the pd_hosp_affil.department_b field.~r"
	end if
	if cnt55 > 0 then
		ls_text = ls_text + "There are " + string(cnt55) + " record(s) in the pd_hosp_affil.department_c field.~r"
	end if
	if cnt56 > 0 then
		ls_text = ls_text + "There are " + string(cnt56) + " record(s) in the pd_hosp_affil.section_a field.~r"
	end if
	if cnt57 > 0 then
		ls_text = ls_text + "There are " + string(cnt57) + " record(s) in the pd_hosp_affil.section_b field.~r"
	end if
	if cnt58 > 0 then
		ls_text = ls_text + "There are " + string(cnt58) + " record(s) in the pd_hosp_affil.section_c field.~r"
	end if
	if cnt59 > 0 then
		ls_text = ls_text + "There are " + string(cnt59) + " record(s) in the pd_hosp_affil.admitting_priv field.~r"
	end if
	if cnt60 > 0 then
		ls_text = ls_text + "There are " + string(cnt60) + " record(s) in the pd_hosp_affil.staff_category field.~r"
	end if
	if cnt61 > 0 then
		ls_text = ls_text + "There are " + string(cnt61) + " record(s) in the pd_insurance.claims_made_occurrence field.~r"
	end if	
	if cnt62 > 0 then
		ls_text = ls_text + "There are " + string(cnt62) + " record(s) in the pd_insurance.state_coverage field.~r"
	end if
	if cnt63 > 0 then
		ls_text = ls_text + "There are " + string(cnt63) + " record(s) in the pd_insurance.state_funded_pool field.~r"
	end if
	if cnt64 > 0 then
		ls_text = ls_text + "There are " + string(cnt64) + " record(s) in the pd_insurance.tail_coverage field.~r"
	end if
	if cnt65 > 0 then
		ls_text = ls_text + "There are " + string(cnt65) + " record(s) in the pd_languages.foreign_language field.~r"
	end if
	if cnt66 > 0 then
		ls_text = ls_text + "There are " + string(cnt66) + " record(s) in the pd_languages.speak field.~r"
	end if
	if cnt67 > 0 then
		ls_text = ls_text + "There are " + string(cnt67) + " record(s) in the pd_languages.sign field.~r"
	end if
	if cnt68 > 0 then
		ls_text = ls_text + "There are " + string(cnt68) + " record(s) in the pd_languages.writes field.~r"
	end if
	if cnt69 > 0 then
		ls_text = ls_text + "There are " + string(cnt69) + " record(s) in the pd_languages.reads field.~r"
	end if
	if cnt70 > 0 then
		ls_text = ls_text + "There are " + string(cnt70) + " record(s) in the pd_license.license_type_code field.~r"
	end if
	if cnt71 > 0 then
		ls_text = ls_text + "There are " + string(cnt71) + " record(s) in the pd_license.state field.~r"
	end if
	if cnt72 > 0 then
		ls_text = ls_text + "There are " + string(cnt72) + " record(s) in the pd_other_affill.function_code field.~r"
	end if
	if cnt73 > 0 then
		ls_text = ls_text + "There are " + string(cnt73) + " record(s) in the pd_other_ids.id_type field.~r"
	end if
	if cnt74 > 0 then
		ls_text = ls_text + "There are " + string(cnt74) + " record(s) in the pd_address_2.work_comp_state field.~r"
	end if
	if cnt75 > 0 then
		ls_text = ls_text + "There are " + string(cnt75) + " record(s) in the pd_references.name_suffix field.~r"
	end if
	if cnt76 > 0 then
		ls_text = ls_text + "There are " + string(cnt76) + " record(s) in the pd_references.country.~r"
	end if
	if cnt77 > 0 then
		ls_text = ls_text + "There are " + string(cnt77) + " record(s) in the pd_references.title.~r"
	end if
	if cnt78 > 0 then
		ls_text = ls_text + "There are " + string(cnt78) + " record(s) in the pd_references.state.~r"
	end if
	if cnt79 > 0 then
		ls_text = ls_text + "There are " + string(cnt79) + " record(s) in the pd_references.prof_suffix field.~r"
	end if
	if cnt80 > 0 then
		ls_text = ls_text + "There are " + string(cnt80) + " record(s) in the pd_sanctions.action_sanction_code field.~r"
	end if
	if cnt81 > 0 then
		ls_text = ls_text + "There are " + string(cnt81) + " record(s) in the pd_sanctions.status_activity_code field.~r"
	end if
	if cnt82 > 0 then
		ls_text = ls_text + "There are " + string(cnt82) + " record(s) in the pd_special_certs.certified_in field.~r"
	end if
	if cnt83 > 0 then
		ls_text = ls_text + "There are " + string(cnt83) + " record(s) in the pd_training.fellowship_type_code field.~r"
	end if
	if cnt84 > 0 then
		ls_text = ls_text + "There are " + string(cnt84) + " record(s) in the pd_training.internship_type_code field.~r"
	end if
	if cnt85 > 0 then
		ls_text = ls_text + "There are " + string(cnt85) + " record(s) in the pd_training.train_type field.~r"
	end if
	if cnt86 > 0 then
		ls_text = ls_text + "There are " + string(cnt86) + " record(s) in the pd_training.specialty field.~r"
	end if
	if cnt87 > 0 then
		ls_text = ls_text + "There are " + string(cnt87) + " record(s) in the pd_priv_list.status_code field.~r"
	end if
	if cnt88 > 0 then
		ls_text = ls_text + "There are " + string(cnt88) + " record(s) in the net_dev_action_items.action_type field.~r"
	end if
	if cnt89 > 0 then
		ls_text = ls_text + "There are " + string(cnt89) + " record(s) in the net_dev_action_items.action_status field.~r"
	end if
	if cnt90 > 0 then
		ls_text = ls_text + "There are " + string(cnt90) + " record(s) in the net_dev_action_items.action_dept field.~r"
	end if
	if cnt91 > 0 then
		ls_text = ls_text + "There are " + string(cnt91) + " record(s) in the net_dev_ids.plan_type field.~r"
	end if
	if cnt92 > 0 then
		ls_text = ls_text + "There are " + string(cnt92) + " record(s) in the net_dev_ids.tier field.~r"
	end if

end if

//---------------------------- APPEON END ----------------------------

//SetPointer ( arrow! )
If LenA(ls_text) > 1 then
	return(ls_text)
	//messagebox("Referenced records found",ls_text)
else
	return("NONE")
	//messagebox("Referenced record","No Referenced record found")
end if

end function

public function integer of_add_security_dept (integer ai_row);Integer li_user_cnt
Integer li_access
Integer u
Integer d
Integer i
String ls_user_id
Integer li_dept_cnt
Long ll_security_dept_code
Long ll_department

dw_users.SetTransObject( SQLCA )
dw_users.Retrieve( )
li_user_cnt = dw_users.RowCount( )

SELECT Max( user_depart_id )
INTO :ll_security_dept_code
FROM security_user_department;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF			

//grap the code for the new department
ll_department = dw_detail.GetItemNumber( ai_row, "lookup_code" )			
//Loop through all users and department and setup department security
FOR u = 1 TO li_user_cnt
	ls_user_id = dw_users.GetItemString( u, "user_id" )
	ll_security_dept_code ++
	INSERT INTO security_user_department  
	       ( user_depart_id,   
              user_id,   
	         department_id,   
     	      access_rights )  
	VALUES ( :ll_security_dept_code,   
	         :ls_user_id,   
	         :ll_department,   
	         1 )  ;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
		RETURN -1
	END IF			
END FOR

RETURN 1
end function

public function integer wf_refresh_ctx_cache ();/******************************************************************************************************************
**  [PUBLIC]   : wf_refresh_ctx_cache
**==================================================================================================================
**  Purpose   	: Will refresh the cache if we are using contract and a contract table has been updated
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 09 March 006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_contract

if ib_refresh_cache then
	gnv_app.IB_ref_cache = TRUE
	gnv_app.of_setcontraccache( )
end if 

return 0
end function

public function integer of_count ();//Start Code Change ---- 03.29.2006 #354 maha created 

long l

l = dw_detail.rowcount()
st_count.text = string(l)

return 1
end function

public subroutine of_addright (long al_category, string as_lookname);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-11 By: Scofield
//$<Reason> Update ctx_acp_contract_management_right table when add contract category
long		ll_RoleId
long		ll_Cycle,ll_Count

DataStore	lds_Security_Role

lds_Security_Role = Create DataStore
lds_Security_Role.DataObject = "d_dddw_security_roles"
lds_Security_Role.SetTransObject(SQLCA)
lds_Security_Role.Retrieve()

ll_Count = lds_Security_Role.RowCount()

gnv_appeondb.of_startqueue( )

for ll_Cycle = 1 to ll_Count
	ll_RoleId = lds_Security_Role.GetItemNumber(ll_Cycle,'role_id')
	if as_LookName = 'Contract Category' then
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,1,'11');
			  
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,3,'31');
			  
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,4,'41');
	elseif as_LookName = 'Contract Clause Category' then
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,2,'21');
	end if
next

gnv_appeondb.of_commitqueue( )

COMMIT USING SQLCA;

Destroy lds_Security_Role
//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine wf_refreshcoltitle (string as_lookup_type, string as_lookup_name);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-16 By: Scofield
//$<Reason> Modify column title text.

long		ll_Cycle,ll_Count,ll_InvComPos,ll_ColCoorX,ll_CorWidth
String	ls_TitleName,ls_TitleText,ls_ColName

CONSTANT LONG SPACEWIDTH = 9

DataStore	lds_ColTitle

dw_detail.SetRedraw(false)

lds_ColTitle = Create DataStore

lds_ColTitle.DataObject = "d_Lookup_ColTitle"
lds_ColTitle.SetTransObject(SQLCA)
lds_ColTitle.Retrieve(as_lookup_type,as_lookup_name)

ll_Count = lds_ColTitle.RowCount()
for ll_Cycle = 1 to ll_Count
	ls_TitleName = lds_ColTitle.GetItemString(ll_Cycle,'ColTitleName')
	ls_TitleText = lds_ColTitle.GetItemString(ll_Cycle,'ColTitleText')
	
	ll_InvComPos = PosA(ls_TitleText,"'")
	do while ll_InvComPos > 0
		ls_TitleText = ReplaceA(ls_TitleText,ll_InvComPos,1,"~~'")
		ll_InvComPos = PosA(ls_TitleText,"'",ll_InvComPos + 2)
	loop
	dw_detail.Modify(ls_TitleName + ".Text='" + ls_TitleText + "'")
	
	ls_ColName = lds_ColTitle.GetItemString(ll_Cycle,'ColName')
	ll_ColCoorX = lds_ColTitle.GetItemNumber(ll_Cycle,'ColCoorX')
	ll_CorWidth = lds_ColTitle.GetItemNumber(ll_Cycle,'ColWidth')
	
	if Not IsNull(ls_ColName) and Trim(ls_ColName) <> "" then
		dw_detail.Modify(ls_ColName + ".X=" + String(ll_ColCoorX - SPACEWIDTH))
		dw_detail.Modify(ls_ColName + ".Width=" + String(ll_CorWidth))
	end if
next

Destroy lds_ColTitle

dw_detail.SetRedraw(true)

//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine wf_setcollabel (string as_labelname);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-17 By: Scofield
//$<Reason> Set Column Label.

String	ls_OriTitleText,ls_NewTitleText
long		ll_cnt,ll_InvComPos

SELECT coltitletext
  INTO :ls_OriTitleText
  FROM lookup_coltitle
 WHERE lookup_type = :is_lookup_type AND lookup_name = :is_lookup_name AND coltitlename = :as_LabelName;
 
if IsNull(ls_OriTitleText) or ls_OriTitleText = "" then
	ls_OriTitleText = dw_detail.Describe(as_LabelName + ".Text")
end if

OpenWithParm(w_SetColLabelText,ls_OriTitleText)
if Message.DoubleParm = -1 then return

ls_NewTitleText = Message.StringParm

SELECT Count(*)
  INTO :ll_cnt
  FROM lookup_coltitle
 WHERE lookup_type = :is_lookup_type AND lookup_name = :is_lookup_name AND coltitlename = :as_LabelName;
 
if ll_cnt <= 0 then
	INSERT INTO lookup_coltitle(Lookup_Type,Lookup_Name,ColTitleName,ColTitleText)
		  VALUES(:is_lookup_type,:is_lookup_name,:as_LabelName,:ls_NewTitleText);
else
	UPDATE lookup_coltitle
	   SET coltitletext = :ls_NewTitleText
	WHERE lookup_type = :is_lookup_type AND lookup_name = :is_lookup_name AND coltitlename = :as_LabelName;
end if

if SQLCA.SQLCode = 0 then
	COMMIT;
	
	ll_InvComPos = PosA(ls_NewTitleText,"'")
	do while ll_InvComPos > 0
		ls_NewTitleText = ReplaceA(ls_NewTitleText,ll_InvComPos,1,"~~'")
		ll_InvComPos = PosA(ls_NewTitleText,"'",ll_InvComPos + 2)
	loop
	
	dw_detail.Modify(as_LabelName + ".Text='" + ls_NewTitleText + "'")
else
	MessageBox(String(SQLCA.SQLCode),'Failed to modify title text!~r~n~r~n' + SQLCA.SQLErrText,EXCLAMATION!)
	ROLLBACK;
end if

//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine wf_updateuserdefinfo (string as_lookup_type, string as_lookup_name);//------------------------------------------------------------------------------
// Function: wf_UpdateUserDefInfo()
//------------------------------------------------------------------------------
// Description: Save user-defined information into database.
// Arguments:
//		1 -- Lookup Type
//		2 -- Lookup Name
// Return Value: None
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-06-17
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

long		ll_Cycle,ll_ColCnt,ll_ColCoorX,ll_ColWidth,ll_RowCnt,ll_SepPos
String	ls_ColName,ls_Objects,ls_ObjCopy,ls_ObjName,ls_ColTitleName,ls_ColTitleText

Boolean	lb_Found

if IsNull(as_lookup_type) or Trim(as_lookup_type) = "" then Return
if IsNull(as_lookup_name) or Trim(as_lookup_name) = "" then Return

ls_Objects = dw_detail.Describe("DataWindow.Objects") + "~t"
ll_ColCnt = long(dw_detail.Describe("DataWindow.Column.Count"))
for ll_Cycle = 1 to ll_ColCnt
	if dw_detail.Describe("#" + String(ll_Cycle) + ".Visible") = '1' then
		ls_ColName = dw_detail.Describe("#" + String(ll_Cycle) + ".Name")
		ll_ColCoorX = long(dw_detail.Describe("#" + String(ll_Cycle) + ".X"))
		ll_ColWidth = long(dw_detail.Describe("#" + String(ll_Cycle) + ".Width"))
		
		SELECT Count(*) INTO :ll_RowCnt FROM lookup_coltitle WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColName = :ls_ColName ;
		if ll_RowCnt > 0 then
			UPDATE lookup_coltitle
				SET ColCoorX = :ll_ColCoorX,ColWidth = :ll_ColWidth
			 WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColName = :ls_ColName ;
			 
			CONTINUE
		end if
		
		lb_Found = false
		ls_ObjCopy = ls_Objects
		ll_SepPos = PosA(ls_ObjCopy,"~t")
		do while ll_SepPos > 0
			ls_ObjName = LeftA(ls_ObjCopy,ll_SepPos - 1)
			ls_ObjCopy = MidA(ls_ObjCopy,ll_SepPos + 1)
			ll_SepPos = PosA(ls_ObjCopy,"~t")
			
			if long(dw_detail.Describe(ls_ObjName + ".x")) <> long(dw_detail.Describe(ls_ColName + ".x")) then continue
			if long(dw_detail.Describe(ls_ObjName + ".Width")) <> long(dw_detail.Describe(ls_ColName + ".Width")) then continue
			if dw_detail.Describe(ls_ObjName + ".Band") <> "header" then continue
			if dw_detail.Describe(ls_ObjName + ".Type") <> "text" then continue
			
			ls_ColTitleName = dw_detail.Describe(ls_ObjName + ".Name")
			ls_ColTitleText = dw_detail.Describe(ls_ObjName + ".Text")
			lb_Found = true
			Exit
		loop
		
		if Not lb_Found then CONTINUE
		
		SELECT Count(*) INTO :ll_RowCnt FROM lookup_coltitle WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColTitleName = :ls_ColTitleName ;
		
		if ll_RowCnt <= 0 then
			INSERT INTO lookup_coltitle(Lookup_Type,Lookup_Name,ColTitleName,ColTitleText,ColName,ColCoorX,ColWidth)
				  VALUES(:as_lookup_type,:as_lookup_name,:ls_ColTitleName,:ls_ColTitleText,:ls_ColName,:ll_ColCoorX,:ll_ColWidth);
		else
			UPDATE lookup_coltitle
				SET ColName = :ls_ColName,ColCoorX = :ll_ColCoorX,ColWidth = :ll_ColWidth
			 WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColTitleName = :ls_ColTitleName ;
		end if
	end if
next

COMMIT USING SQLCA;

end subroutine

public function integer of_addlookupname ();//////////////////////////////////////////////////////////////////////
// $<function> of_addlookupname
// $<arguments>
// $<returns> integer
// $<description> Corrected BugK050503
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.26.2009
//////////////////////////////////////////////////////////////////////

long ll_Count
string ls_LookupName

if is_lookup_type = "A" then Return -1
if dw_detail.RowCount() <= 0 then Return -1

ls_LookupName = Lower(dw_detail.object.lookup_name[1])
if IsNull(ls_LookupName) or ls_LookupName = "" then Return -1
	
SELECT count(*) INTO :ll_Count FROM sys_lookup WHERE lower(lookup_name) = :ls_LookupName;
if ll_Count > 0 then
else
	INSERT INTO sys_lookup(lookup_name) VALUES(:ls_LookupName);
end if

Return 1
end function

event open;call super::open;//Start Code Change ----12.17.2009 #V10 maha - screen created; copied from lookup painter
long rc

dw_detail.of_SetTransObject(SQLCA)
rc = dw_detail.retrieve()

if rc = 0 then cb_import.visible = true

end event

on w_qa_metrics.create
int iCurrent
call super::create
this.cb_import=create cb_import
this.st_1=create st_1
this.st_count=create st_count
this.dw_detail=create dw_detail
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_print=create cb_print
this.cb_saveas=create cb_saveas
this.cb_test=create cb_test
this.dw_users=create dw_users
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_import
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_count
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_sort
this.Control[iCurrent+10]=this.cb_filter
this.Control[iCurrent+11]=this.cb_print
this.Control[iCurrent+12]=this.cb_saveas
this.Control[iCurrent+13]=this.cb_test
this.Control[iCurrent+14]=this.dw_users
end on

on w_qa_metrics.destroy
call super::destroy
destroy(this.cb_import)
destroy(this.st_1)
destroy(this.st_count)
destroy(this.dw_detail)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_print)
destroy(this.cb_saveas)
destroy(this.cb_test)
destroy(this.dw_users)
end on

type cb_import from u_cb within w_qa_metrics
boolean visible = false
integer x = 1838
integer y = 36
integer height = 84
integer taborder = 80
boolean bringtotop = true
string text = "&Import"
end type

event clicked;//Start Code Change ----10.24.2011 #V12 maha added
string ls_file, named
integer value
integer ac


ls_file = gs_dir_path + "intellicred\qa_metric_data.txt"

if not fileexists(ls_file) then
	messagebox("Cannot find file " + ls_file, "Check for the qa_metric_data.txt file in your IntelliCred directory.  Select file, or if file does not exist, contact ISG support.")
	value = GetFileOpenName("Select File",&
+ ls_file, named, "DOC", &
	+ "text Files (*.txt),*.txt")
end if

if not fileexists(ls_file) then return


if len( ls_file) > 0 then
	ac = dw_detail.importfile( ls_file)
end if




end event

type st_1 from statictext within w_qa_metrics
integer x = 494
integer y = 1916
integer width = 2254
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_count from statictext within w_qa_metrics
boolean visible = false
integer x = 4059
integer y = 1936
integer width = 265
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_detail from u_dw within w_qa_metrics
integer x = 37
integer y = 132
integer width = 4544
integer height = 1872
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_qa_metrics_de"
boolean hscrollbar = true
end type

event constructor;This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.of_SetReqColumn(True)

This.inv_sort.of_SetColumnHeader(True)

end event

event pfc_postupdate;call super::pfc_postupdate;//of_AddLookupName() //Add by Evan 05.26.2009 --- Corrected BugK050503
//
//// mskinner 09 March 2006 -- begin
////--------------------------- APPEON BEGIN ---------------------------
////$<comment> 09.04.2006 By: LeiWei
////$<reason> Fix a defect.
///*
//if pos(string(dw_name.inv_base.of_getItem( 1, 'lookup_name')), 'Contract' ) > 0 then 
//      ib_refresh_cache = true
//end if 
//*/
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-02
////$<add> 04.05.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Have the application refresh the data in ids_code_lookup if the
////$<modification> data in code_lookup table is changed. 
//gnv_appeondb.of_startqueue()
//update code_lookup set modify_date = getdate() where lookup_name = :is_lookup_name; //11.30.2006 Added by henry.
//gnv_data.of_retrieve( "code_lookup" )
//gnv_data.of_retrieve('code_lookup_2') //Added 11.30.2006 henry
//gnv_appeondb.of_commitqueue()
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 09.29.2006 By: LeiWei
////$<reason> Referesh cache for contract.
//
//gnv_app.of_setcontraccache_code_lookup(is_lookup_name)
////18.12.2006 by Allen:Refresh dddw of dw_dashboard if lookup Table changed.
//IF IsValid(w_todolist_painter) THEN
//	w_todolist_painter.dw_dashboard.Event ue_refresh_dddw(True)
//END IF
////---------------------------- APPEON END ----------------------------
//
//RETURN SUCcess
//
//// mskinner 09 March 2006 -- end 
//
return 1
end event

event clicked;call super::clicked;//Start Code Change ---- 10.15.2007 #V7 maha
integer i

i = this.getclickedrow()
this.setrow(i)
//End Code Change---10.15.2007
end event

event rbuttondown;call super::rbuttondown;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-01-16 By: Scofield
//$<Reason> Popup a dialog to modify column label.

String	ls_ColName,ls_Objects,ls_ObjName,ls_Band,ls_Type
long		ll_SepPos,ll_DisDiff,ll_WidthDiff,ll_Rtn
DateTime	ldt_Null

ls_ColName = Lower(dwo.Name)
if dw_detail.Describe(ls_ColName + ".Type") <> "column" then return

if ls_ColName = "datetime_1" or ls_ColName = "datetime_2" then
	SetNull(ldt_Null)
	ll_Rtn = MessageBox("Set Null", "Would you like to set this Date to null?", question!, yesno!, 2)
	if ll_Rtn = 1 then this.SetItem(Row,ls_ColName,ldt_Null)
	return
end if

ls_Objects = dw_detail.Describe("DataWindow.Objects") + "~t"
ll_SepPos = PosA(ls_Objects,"~t")

do while ll_SepPos > 0
	ls_ObjName = LeftA(ls_Objects,ll_SepPos - 1)
	ls_Objects = MidA(ls_Objects,ll_SepPos + 1)
	ll_SepPos = PosA(ls_Objects,"~t")
	
	if long(dw_detail.Describe(ls_ObjName + ".x")) <> long(dw_detail.Describe(ls_ColName + ".x")) then continue
	if long(dw_detail.Describe(ls_ObjName + ".Width")) <> long(dw_detail.Describe(ls_ColName + ".Width")) then continue
	if dw_detail.Describe(ls_ObjName + ".Band") <> "header" then continue
	if dw_detail.Describe(ls_ObjName + ".Type") <> "text" then continue
	
	if ls_ObjName = "code_t" or ls_ObjName = "description_t" or &
   ls_ObjName = "large_description_1_t" or ls_ObjName = "large_description_2_t" then return
	
	wf_SetColLabel(ls_ObjName)
	Exit
loop

//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;long ll_id = 0
long i

for i  = 1 to this.rowcount()
	if this.getitemstatus( i, 0, Primary!) = NEWMODIFIED! then
		if ll_id = 0 then
			select max(qam_id)  into :ll_id from qa_metrics;
			if isnull(ll_id) then ll_id = 0
		end if
		ll_id++
		this.setitem(i,"qam_id",ll_id)
	end if	
next

return 1
end event

event retrieveend;call super::retrieveend;DataWindowChild dwchild

This.GetChild( "department", dwchild )
dwchild.insertrow(1)
dwchild.setitem(1,"description","Global")
dwchild.setitem(1,"lookup_code",0)

dwchild.insertrow(1) //blank
end event

event itemchanged;call super::itemchanged;//------------------- APPEON BEGIN -------------------
//$<add> Michael 03.16.2011
//$<reason>V12.1 CME-peer-meeting data migration to QA 
if lower(dwo.name) = 'ind_type' then
	if data = 'CME' then
		setitem(row,'data_type',1)
	end if
end if
//------------------- APPEON END ---------------------

end event

event pfc_validation;call super::pfc_validation;long i
long ll_count = 0
//------------------- APPEON BEGIN -------------------
//$<add> Michael 03.16.2011
//$<reason>V12.1 CME-peer-meeting data migration to QA 
for i =  1 to this.rowcount()
	if getitemstring(i,"ind_type") = 'CME' then
		ll_count ++
	end if
next

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 10.30.2012
//$<reason>CME in ind type for only one Metric item   BugS102303
for i = 1 to this.filteredcount()
	if this.getitemstring(i,"ind_type",filter!,false) = 'CME' then
		ll_count ++
	end if
next
//------------------- APPEON END ---------------------

if ll_count > 1 then
	messagebox('Validaton Error','You can set CME in ind type for only one Metric item.')
	this.setfilter("")  //add by stephen 10.30.2012
	this.filter()   //add by stephen 10.30.2012
	return -1
end if

//------------------- APPEON END ---------------------

end event

type cb_add from u_cb within w_qa_metrics
integer x = 398
integer y = 36
integer height = 84
integer taborder = 70
boolean bringtotop = true
string text = "&Add"
end type

event clicked;Integer li_row, li_lst_order



li_row = dw_detail.InsertRow(0)
dw_detail.SetRow(li_row)
dw_detail.ScrollToRow(li_row)



dw_detail.Enabled = True

dw_detail.SetFocus()
dw_detail.SetColumn(1)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-13 By: Scofield
//$<Reason> Refresh the counter
of_count()
//---------------------------- APPEON END ----------------------------


end event

type cb_delete from u_cb within w_qa_metrics
integer x = 759
integer y = 36
integer height = 84
integer taborder = 80
boolean bringtotop = true
string text = "&Delete"
end type

event clicked;long l_code
long cnt
Long ll_department_code
string ls_text

if dw_detail.getrow() < 1 then Return //Add by Evan 07.18.2011

if dw_detail.getitemnumber(dw_detail.getrow(),"protect") = 1 then  //Start Code Change ---- 10.15.2007 #V7 maha
	MessageBox("Delete Error", "You can not delete a lookup item that is protected. ")
	Return
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.18.2011 By: Evan
//$<reason> V11.3 QA Import
long ll_qam_id, ll_Count
ll_qam_id = dw_detail.getitemnumber(dw_detail.getrow(), "qam_id")
SELECT count(*) INTO :ll_Count FROM import_lookup_mapping A, import_lu_map_fields B
WHERE (A.ilm_id = B.ilm_id) AND
		(A.map_type = 'Q') AND
		(B.is_lu_code = :ll_qam_id);
if ll_Count > 0 then
	MessageBox("Delete Error", "You can not delete a lookup item that is required by import module.")
	Return
end if
//---------------------------- APPEON END ----------------------------

//-----------------------------appeon begin-----------------------------
//<$>added:long.zhang 11.13.2012
//<$>reason:Data validate BugL110502
select count(*) into :ll_count from qa_measurement_new where qa_metric_id = :ll_qam_id;
if ll_count > 0 then
		messagebox("Delete Error","This lookup has connected data in the Measurements.")
		return
end if
//--------------------------appeon end-----------------------------------

dw_detail.Event pfc_deleterow()
dw_detail.SetFocus()

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-13 By: Scofield
//$<Reason> Refresh the counter
of_count()
//---------------------------- APPEON END ----------------------------

end event

type cb_save from u_cb within w_qa_metrics
integer x = 41
integer y = 36
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "&Save"
end type

event clicked;Integer li_retval


dw_detail.AcceptText()


//inv_audit.of_FieldAudit(dw_detail, is_lookup_type) //Added by Evan on 2008-01-26
li_retval = Parent.Event pfc_save()
//if li_Retval = 1 then inv_audit.of_Save() //Added by Evan on 2008-01-26

dw_detail.SetFocus()



end event

type cb_close from u_cb within w_qa_metrics
integer x = 4224
integer y = 24
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_sort from u_cb within w_qa_metrics
integer x = 2555
integer y = 36
integer height = 84
integer taborder = 100
boolean bringtotop = true
string text = "So&rt"
end type

event clicked;if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

dw_detail.Event pfc_SortDlg()

dw_detail.SetFocus()

end event

type cb_filter from u_cb within w_qa_metrics
integer x = 2199
integer y = 36
integer height = 84
integer taborder = 110
boolean bringtotop = true
string text = "&Filter"
end type

event clicked;if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

//dw_detail.Event pfc_filterdlg()
string null_str

SetNull(null_str)

dw_detail.SetFilter(null_str)

dw_detail.Filter()

dw_detail.SetFocus()

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-13 By: Scofield
//$<Reason> Refresh the counter
of_count()
//---------------------------- APPEON END ----------------------------

end event

type cb_print from u_cb within w_qa_metrics
integer x = 1120
integer y = 36
integer height = 84
integer taborder = 120
boolean bringtotop = true
string text = "&Print"
end type

event clicked;if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12
dw_detail.Print()
end event

type cb_saveas from u_cb within w_qa_metrics
integer x = 1477
integer y = 36
integer height = 84
integer taborder = 130
boolean bringtotop = true
string text = "&Export"
end type

event clicked;IF dw_detail.DataObject = "" THEN RETURN //Added by Scofield on 2008-03-12
gnv_dw.of_SaveAs(dw_detail,"",text!,true)//.SaveAs( "", Text!, True ) Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path)//For restore directory  Added by Nova 04.29.2008


end event

type cb_test from u_cb within w_qa_metrics
boolean visible = false
integer x = 4055
integer y = 1936
integer height = 84
integer taborder = 90
boolean bringtotop = true
boolean enabled = false
string text = "F&ind Records"
end type

event clicked;long l_code
long cnt
string ls_text
SetPointer ( hourglass! )

//if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12
//
//if dw_detail.rowcount() = 0 then return //maha 012505
//
//l_code = dw_detail.getitemnumber(dw_detail.getrow(),"lookup_code")
//
//if dw_detail.DataObject = "d_address_lookup" then
//	ls_text = of_test_delete("A",l_code)
//	if ls_text = "NONE" then ls_text = ""
//
//elseif dw_detail.DataObject = "d_code_lookup" then
//	ls_text = of_test_delete("C",l_code)
//	if ls_text = "NONE" then ls_text = ""
//
//end if
////
//SetPointer ( arrow! )
//If len(ls_text) > 1 then
//	messagebox("Referenced records found for Standard lookups",ls_text)
//else //Start Code Change ----07.09.2008 #V81 maha  - modified message to be more informative
//	messagebox("Referenced record","No Referenced record found for Standard foreign key data fields.  If custom fields are using lookup tables, this function will not find data connected to them.")
//end if
end event

type dw_users from datawindow within w_qa_metrics
boolean visible = false
integer x = 4005
integer y = 1756
integer width = 274
integer height = 108
integer taborder = 40
string dataobject = "d_user_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

