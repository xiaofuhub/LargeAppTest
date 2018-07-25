$PBExportHeader$w_lookup_view.srw
forward
global type w_lookup_view from w_main
end type
type st_count from statictext within w_lookup_view
end type
type gb_1 from groupbox within w_lookup_view
end type
type dw_name from u_dw within w_lookup_view
end type
type cb_new_lookup from u_cb within w_lookup_view
end type
type cb_add from u_cb within w_lookup_view
end type
type cb_delete from u_cb within w_lookup_view
end type
type cb_save from u_cb within w_lookup_view
end type
type cb_close from u_cb within w_lookup_view
end type
type cb_sort from u_cb within w_lookup_view
end type
type cb_filter from u_cb within w_lookup_view
end type
type cb_print from u_cb within w_lookup_view
end type
type cb_saveas from u_cb within w_lookup_view
end type
type cb_test from u_cb within w_lookup_view
end type
type dw_users from datawindow within w_lookup_view
end type
type dw_detail from u_dw within w_lookup_view
end type
end forward

global type w_lookup_view from w_main
integer x = 5
integer y = 312
integer width = 3657
integer height = 2072
string title = "View Lookups"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
st_count st_count
gb_1 gb_1
dw_name dw_name
cb_new_lookup cb_new_lookup
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
dw_detail dw_detail
end type
global w_lookup_view w_lookup_view

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


end variables

forward prototypes
public function string of_test_delete (string as_type, long as_code)
public function integer of_security ()
public function integer of_add_security_dept (integer ai_row)
public function integer wf_refresh_ctx_cache ()
public function integer of_count ()
end prototypes

public function string of_test_delete (string as_type, long as_code);//maha created 021904 called from delete and test records.

long l_code
long cnt
string ls_text
//SetPointer ( hourglass! )
string s_code

l_code = as_code
s_code = String(l_code)

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
	//select count(prac_id) into :cnt from pd_affil_staff_leave where leave_of_absence_reason = :l_code;
	select count(prac_id) into :cnt from pd_affil_staff_leave where leave_of_absence_reason = :s_code;  //Modified by (Appeon)Harry 05.23.2016
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

//SetPointer ( arrow! )
If LenA(ls_text) > 1 then
	return(ls_text)
	//messagebox("Referenced records found",ls_text)
else
	return("NONE")
	//messagebox("Referenced record","No Referenced record found")
end if

end function

public function integer of_security ();//added 04-02-04 maha

integer i
integer ret

//i = w_mdi.of_security_access(560)

//if i = 1  then
//	cb_new_lookup.Enabled = False
//	cb_add.Enabled = False
//	cb_saveas.Enabled = False
//	cb_delete.Enabled = False
//	cb_filter.Enabled = False
//	cb_sort.Enabled = False
//	cb_print.Enabled = False
//	cb_save.Enabled = False
//	cb_test.Enabled = False
//	ret = 0
//else
//	cb_new_lookup.Enabled = true
//	cb_add.Enabled = True
//	cb_saveas.Enabled = True
//	cb_delete.Enabled = True
//	cb_filter.Enabled = True
//	cb_sort.Enabled = True
//	cb_print.Enabled = True
//	cb_save.Enabled = True
//	cb_test.Enabled = True
//	ret = 1
//end if
	





return ret
end function

public function integer of_add_security_dept (integer ai_row);//Integer li_user_cnt
//Integer li_access
//Integer u
//Integer d
//Integer i
//String ls_user_id
//Integer li_dept_cnt
//Long ll_security_dept_code
//Long ll_department
//
//dw_users.SetTransObject( SQLCA )
//dw_users.Retrieve( )
//li_user_cnt = dw_users.RowCount( )
//
//SELECT Max( user_depart_id )
//INTO :ll_security_dept_code
//FROM security_user_department;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
//	RETURN -1
//END IF			
//
////grap the code for the new department
//ll_department = dw_detail.GetItemNumber( ai_row, "lookup_code" )			
////Loop through all users and department and setup department security
//FOR u = 1 TO li_user_cnt
//	ls_user_id = dw_users.GetItemString( u, "user_id" )
//	ll_security_dept_code ++
//	INSERT INTO security_user_department  
//	       ( user_depart_id,   
//              user_id,   
//	         department_id,   
//     	      access_rights )  
//	VALUES ( :ll_security_dept_code,   
//	         :ls_user_id,   
//	         :ll_department,   
//	         1 )  ;
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
//		RETURN -1
//	END IF			
//END FOR
//
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

event open;call super::open;dw_detail.of_SetTransObject(SQLCA)
dw_detail.InsertRow(0)
//dw_detail.Enabled = False

dw_name.of_SetTransObject(SQLCA)
dw_name.InsertRow(0)

dw_name.SetFocus()

of_security()
end event

on w_lookup_view.create
int iCurrent
call super::create
this.st_count=create st_count
this.gb_1=create gb_1
this.dw_name=create dw_name
this.cb_new_lookup=create cb_new_lookup
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
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_count
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_name
this.Control[iCurrent+4]=this.cb_new_lookup
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
this.Control[iCurrent+15]=this.dw_detail
end on

on w_lookup_view.destroy
call super::destroy
destroy(this.st_count)
destroy(this.gb_1)
destroy(this.dw_name)
destroy(this.cb_new_lookup)
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
destroy(this.dw_detail)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: Added code that will allow the user to event double click on a column with a dddw and add the code
** 				  easiley
*==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//long ll_foundrow
//
//if len(message.stringparm) > 0 then
//   DataWindowChild lookup_name_child
//   ll_foundrow = dw_name.GetChild('lookup_name', lookup_name_child)
//	ll_foundrow = lookup_name_child.Find( "lookup_name = '" + message.stringparm + "'", 1, lookup_name_child.rowcount())
//
//	if ll_foundrow > 0 then
//		WordCap ( message.stringparm )
//	  	dw_detail.DataObject = "d_code_lookup"
//      dw_detail.of_SetTransObject(SQLCA)
//		is_lookup_name = message.stringparm 
//		dw_detail.event pfc_retrieve( )
//		dw_name.settext(message.stringparm)
//	end if
//end if 
end event

event close;call super::close;
//WF_refresh_ctx_cache( )
end event

type st_count from statictext within w_lookup_view
integer x = 69
integer y = 1912
integer width = 754
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_lookup_view
boolean visible = false
integer x = 37
integer y = 220
integer width = 1979
integer height = 180
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Lookup Table"
end type

type dw_name from u_dw within w_lookup_view
boolean visible = false
integer x = 64
integer y = 284
integer width = 1417
integer height = 96
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_lookup_select"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;This.of_SetUpdateable(False)

// mskinner 09 march 2006 -- begin
of_SetBase(TRUE)
// mskinner 09 march 2006 -- end 
end event

event itemchanged;call super::itemchanged;of_security()

String ls_lookup_type


IF Parent.Event pfc_save() < 0 THEN
	Return
END IF

Integer i, li_rc, currentrow, li_found

dw_detail.SetRedraw(False)
debugbreak()
is_lookup_name = This.GetText()

datawindowchild dwchild
This.GetChild("lookup_name", dwchild)

li_found = dwchild.Find("lookup_name = '" + is_lookup_name + "'", 1, 1000)

IF li_found > 0 THEN
	ls_lookup_type = Upper(dwchild.GetItemString(li_found, "type"))	
	IF ls_lookup_type = "A" THEN
		is_lookup_type = "A"
		dw_detail.DataObject = "d_address_lookup"
	ELSE
		is_lookup_type = "C"
		dw_detail.DataObject = "d_code_lookup"
	END IF

	dw_detail.of_SetTransObject(SQLCA)

	dw_detail.Event pfc_Retrieve()

	dw_detail.ScrollToRow(1)
	dw_detail.SetRow(1)
END IF

dw_detail.SetFocus()

dw_detail.SetRedraw(True)

dw_detail.Enabled = True

IF Upper(is_lookup_type) = "A" THEN
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM address_lookup  ;
ELSE
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM code_lookup  ;
END IF
IF IsNull( il_lookup_code ) THEN
	il_lookup_code = 0
END IF

IF ls_lookup_type = "A" THEN
	dw_detail.GetChild( "state", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "state" )

	dw_detail.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )	
END IF

IF is_lookup_name = "Action Type" THEN
	dw_detail.Modify( "cust_6_t.text = 'Include In Graph' ")
	dw_detail.Modify( "cust_2_t.text = 'Default Due Date Days'")
	dw_detail.Modify( "cust_3_t.text = 'Follow Up Days'")		
	dw_detail.Modify( "cust_1_t.text = 'Display Value'")	
END IF


IF Upper( is_lookup_name ) = "DEPARTMENT" THEN
//	SELECT set_37
//	INTO :ii_dept_secure_setting
//	FROM icred_settings;
	ii_dept_secure_setting = gi_dept_security
END IF
//Start Code Change ---- 03.29.2006 #354 maha
of_count()


end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve()
end event

event pfc_update;call super::pfc_update;
Return 0
end event

type cb_new_lookup from u_cb within w_lookup_view
boolean visible = false
integer x = 1490
integer y = 280
integer width = 489
integer height = 84
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "N&ew Lookup Table"
end type

event clicked;IF Parent.Event pfc_save() < 0 THEN
	Return
END IF

Open(w_get_lookup_name)

if Message.StringParm = "Cancel" then return

is_lookup_name = MidA(Message.StringParm,1, PosA(Message.StringParm, "-")-1)
is_lookup_type = MidA(Message.StringParm, PosA(Message.StringParm, "-") +1, 2)


IF Upper(is_lookup_type) = "A" THEN
	dw_detail.DataObject = "d_address_lookup"
ELSE
	dw_detail.DataObject = "d_code_lookup"
END IF

ib_new_table = True

dw_detail.of_SetTransObject(SQLCA)

dw_detail.Event pfc_Retrieve()

IF Upper(is_lookup_type) = "A" THEN
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM address_lookup  ;
ELSE
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM code_lookup  ;
END IF
IF IsNull( il_lookup_code ) THEN
	il_lookup_code = 0
END IF

cb_add.Event Clicked()

dw_name.SetText(is_lookup_name)

dw_detail.SetFocus()

cb_add.Enabled = True
cb_saveas.Enabled = True
cb_delete.Enabled = True
cb_filter.Enabled = True
cb_print.Enabled = True
cb_sort.Enabled = True
cb_save.Enabled = True

of_count()

end event

type cb_add from u_cb within w_lookup_view
integer x = 2505
integer y = 508
integer height = 84
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Add"
end type

event clicked;Integer li_row, li_lst_order

li_row = dw_detail.InsertRow(0)
dw_detail.SetRow(li_row)
dw_detail.ScrollToRow(li_row)
dw_detail.SetItem(li_row, "lookup_name", is_lookup_name)

il_lookup_code = gnv_app.of_get_id("LOOKUP")

dw_detail.SetItem(li_row, "lookup_code", il_lookup_code)

dw_detail.Enabled = True

dw_detail.SetFocus()
dw_detail.SetColumn(1)
	
end event

type cb_delete from u_cb within w_lookup_view
integer x = 2496
integer y = 628
integer height = 84
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Delete"
end type

event clicked;long l_code
long cnt
Long ll_department_code
string ls_text
  
IF dw_detail.RowCount() = 1 THEN
	MessageBox("Delete Error", "You can not delete all of the rows from a lookup.  At least one row must be left in a lookup table.")
	Return
END IF

//IF department security is set to ON then track records being deleted so you can delete after save
IF ii_dept_secure_setting = 1 THEN
	ii_delete_cnt++
	il_department_code[ ii_delete_cnt ] = dw_detail.GetItemNumber( dw_detail.GetRow( ), "lookup_code" )
END IF

dw_detail.Event pfc_deleterow()
dw_detail.SetFocus()

end event

type cb_save from u_cb within w_lookup_view
integer x = 2482
integer y = 388
integer height = 84
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Save"
end type

event clicked;Integer li_retval
Integer i
Integer ll_department_code

li_retval = Parent.Event pfc_save()


IF ib_new_table THEN
	dw_name.Reset()
	dw_name.of_SetTransObject(SQLCA)
	dw_name.Retrieve()
   dw_name.InsertRow(0)
	dw_name.SetText(is_lookup_name)
	ib_new_table = False	
END IF

dw_detail.SetFocus()

IF ii_delete_cnt > 0 THEN
	FOR i = 1 TO ii_delete_cnt

		ll_department_code = il_department_code[ i ]
		
		DELETE
		FROM security_user_department
		WHERE department_id = :ll_department_code;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
			RETURN -1
		END IF
		
	END FOR
END IF

of_count()


end event

type cb_close from u_cb within w_lookup_view
integer x = 3241
integer y = 20
integer height = 84
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_sort from u_cb within w_lookup_view
integer x = 2866
integer y = 20
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "So&rt"
end type

event clicked;dw_detail.Event pfc_SortDlg()

dw_detail.SetFocus()
end event

type cb_filter from u_cb within w_lookup_view
integer x = 2491
integer y = 20
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;//dw_detail.Event pfc_filterdlg()
string null_str

SetNull(null_str)

dw_detail.SetFilter(null_str)

dw_detail.Filter()

dw_detail.SetFocus()
end event

type cb_print from u_cb within w_lookup_view
integer x = 2487
integer y = 1100
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Print"
end type

event clicked;dw_detail.Print()
end event

type cb_saveas from u_cb within w_lookup_view
integer x = 2555
integer y = 1204
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_detail,"",text!,true)//.SaveAs( "", Text!, True ) Modify by Evan 05.11.2010
end event

type cb_test from u_cb within w_lookup_view
integer x = 2551
integer y = 708
integer height = 84
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "Find &Records"
end type

event clicked;long l_code
long cnt
string ls_text
SetPointer ( hourglass! )

if dw_detail.rowcount() = 0 then return //maha 012505

l_code = dw_detail.getitemnumber(dw_detail.getrow(),"lookup_code")

if dw_detail.DataObject = "d_address_lookup" then
	ls_text = of_test_delete("A",l_code)
	if ls_text = "NONE" then ls_text = ""

elseif dw_detail.DataObject = "d_code_lookup" then
	ls_text = of_test_delete("C",l_code)
	if ls_text = "NONE" then ls_text = ""

end if
//
SetPointer ( arrow! )
If LenA(ls_text) > 1 then
	messagebox("Referenced records found for Standard lookups",ls_text)
else
//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	messagebox("Referenced record","No Referenced record found for Standard lookups")
	*/
	messagebox("Referenced record","No Referenced record was found for Standard lookups")
	//---------------------------- APPEON END ----------------------------
end if
end event

type dw_users from datawindow within w_lookup_view
boolean visible = false
integer x = 2181
integer y = 256
integer width = 274
integer height = 108
integer taborder = 10
string dataobject = "d_user_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detail from u_dw within w_lookup_view
integer x = 27
integer y = 132
integer width = 3575
integer height = 1760
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve(is_lookup_name)
end event

event constructor;This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.of_SetReqColumn(True)

This.inv_sort.of_SetColumnHeader(True)

end event

event pfc_preupdate;call super::pfc_preupdate;Boolean lb_updated = False
Integer i
Integer li_Rc
DateTime ldt_dt
string ls_code //maha 031406

li_rc = This.RowCount()

if li_rc < 1 then return - 1

if of_security() = 0 then //maha 040204  view only security sets modified to no so that if the user modifies records
	FOR i = 1 TO li_rc
		This.setItemStatus( i, 0, Primary!,NotModified! ) 
	next
	Return Success
end if


FOR i = 1 TO li_rc
	IF ( This.GetItemStatus( i, 0, Primary! ) = DataModified! OR This.GetItemStatus( i, 0, Primary! ) = NewModified! ) AND is_lookup_type = "A" THEN
		lb_updated = True
	END IF

	IF ii_dept_secure_setting = 1 Then
		//if a department is added and the department security is turned on then add to security department table.
		IF This.GetItemStatus( i, 0, Primary! ) = NewModified!  THEN	
			of_add_security_dept( i )
		END IF
	END IF	
END FOR

//Start Code Change ---- 03.14.2006 #319 maha
if this.getitemstring(1,"lookup_name") = "Affiliation Status" then
	for i = 1 to li_rc
		if LenA (this.getitemstring(i,"code")) > 1 then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2007.08.31 By: Jack
			//$<reason> Fix a defect.
			/*
			messagebox("Lookup Data","In the Affilation Status table CODE values must be one character in length and cannot be duplicated. ")
			*/
 			messagebox("Lookup Data","In the Affiliation Status table CODE values must be one character in length and cannot be duplicated. ")
			//---------------------------- APPEON END ----------------------------
			return - 1
		end if
	next
	for i = 1 to li_rc - 1
		ls_code = this.getitemstring(i ,"code")
		if this.find("code ='" + ls_code + "'", i + 1, li_rc) > 0 then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2007.08.31 By: Jack
			//$<reason> Fix a defect.
			/*
			messagebox("Lookup Data for code - " + ls_code,"In the Affilation Status table CODE values must be one character in length and cannot be duplicated. ")
			*/
 			messagebox("Lookup Data for code - " + ls_code,"In the Affiliation Status table CODE values must be one character in length and cannot be duplicated. ")
			//---------------------------- APPEON END ----------------------------
			return - 1
		end if
	next
end if

//End Code Change---03.14.2006


IF lb_updated = True THEN
	ldt_dt = DateTime( Today(), Now() )
	UPDATE ids SET lookup_cache = :ldt_dt;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	END IF
	COMMIT USING SQLCA;
END IF

Return Success
end event

event pfc_postupdate;call super::pfc_postupdate;

// mskinner 09 March 2006 -- begin
if PosA(string(dw_name.inv_base.of_getItem( 1, 'lookup_name')), 'Contract' ) > 0 then 
      ib_refresh_cache = true
end if 

RETURN SUCcess

// mskinner 09 March 2006 -- end 


end event

event retrieveend;call super::retrieveend;st_count.text = string(this.rowcount())
end event

