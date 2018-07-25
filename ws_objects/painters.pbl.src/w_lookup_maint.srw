$PBExportHeader$w_lookup_maint.srw
forward
global type w_lookup_maint from w_main
end type
type cb_4 from u_cb within w_lookup_maint
end type
type sle_find from singlelineedit within w_lookup_maint
end type
type cb_3 from commandbutton within w_lookup_maint
end type
type pb_1 from picturebutton within w_lookup_maint
end type
type rb_detail from radiobutton within w_lookup_maint
end type
type rb_list from radiobutton within w_lookup_maint
end type
type st_2 from statictext within w_lookup_maint
end type
type cb_2 from u_cb within w_lookup_maint
end type
type dw_name from u_dw within w_lookup_maint
end type
type cb_new_lookup from u_cb within w_lookup_maint
end type
type cb_add from u_cb within w_lookup_maint
end type
type cb_delete from u_cb within w_lookup_maint
end type
type cb_save from u_cb within w_lookup_maint
end type
type cb_close from u_cb within w_lookup_maint
end type
type cb_sort from u_cb within w_lookup_maint
end type
type cb_filter from u_cb within w_lookup_maint
end type
type cb_print from u_cb within w_lookup_maint
end type
type cb_saveas from u_cb within w_lookup_maint
end type
type cb_test from u_cb within w_lookup_maint
end type
type dw_users from datawindow within w_lookup_maint
end type
type cb_1 from u_cb within w_lookup_maint
end type
type cb_letterstorage from u_cb within w_lookup_maint
end type
type dw_record from u_dw within w_lookup_maint
end type
type dw_detail from u_dw within w_lookup_maint
end type
type gb_1 from groupbox within w_lookup_maint
end type
type cb_max from commandbutton within w_lookup_maint
end type
end forward

global type w_lookup_maint from w_main
integer x = 5
integer y = 312
integer width = 3877
integer height = 2268
string title = "Lookup Tables"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
event ue_change_lookupname ( string as_lookupname )
cb_4 cb_4
sle_find sle_find
cb_3 cb_3
pb_1 pb_1
rb_detail rb_detail
rb_list rb_list
st_2 st_2
cb_2 cb_2
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
cb_1 cb_1
cb_letterstorage cb_letterstorage
dw_record dw_record
dw_detail dw_detail
gb_1 gb_1
cb_max cb_max
end type
global w_lookup_maint w_lookup_maint

type variables
String is_lookup_name
String is_lookup_type

Boolean ib_new_table = False

Integer ii_delete_cnt
Integer ii_dept_secure_setting = 0

long il_orgh    //maha 08.22.2017
long il_orgw  //maha 08.22.2017

Long il_lookup_code
Long il_department_code[]

// MSKINNER 09 March 2006 -- begin
boolean ib_refresh_cache /*flag set to true if we update a contact table (at the close of the window)*/


// MSKINNER 09 March 2006 -- end 

n_cst_code_lookup_audit inv_audit //Added by Evan on 2008-01-26

string is_parm  //jervis 10/14/2010   //(Appeon)Eugene 06.18.2013 - V141 ISG-CLX

Boolean ib_delete = False  //(Appeon)Eugene 06.18.2013 - V141 ISG-CLX

Boolean ib_save = False  //(Appeon)Harry 04.08.2014
string   is_code_list //(Appeon)Stephen 02.09.2015
end variables

forward prototypes
public function string of_test_delete (string as_type, long as_code)
public function integer of_security ()
public function integer of_add_security_dept (integer ai_row)
public function integer wf_refresh_ctx_cache ()
public function integer of_count ()
public subroutine of_addright (long al_category, string as_lookname)
public subroutine wf_refreshcoltitle (string as_lookup_type, string as_lookup_name)
public subroutine wf_setcollabel (string as_labelname)
public subroutine wf_updateuserdefinfo (string as_lookup_type, string as_lookup_name)
public function integer of_addlookupname ()
public function integer of_facility_field (string as_table)
public function long of_deletelookuptable ()
public function integer of_duplicate ()
end prototypes

event ue_change_lookupname(string as_lookupname);// (Appeon)Eugene 06.18.2013 - V141 ISG-CLX
//Modified By Ken.Guo 2010-12-30. Use Event to do it.
//Add by jervis 11.26.2009
if as_lookupname <> '' and not isnull(as_lookupname) then
	dw_name.SetItem( 1,"lookup_name",as_lookupname)
	dw_name.Event ItemChanged(1,dw_name.object.lookup_name,as_lookupname)
end if
end event

public function string of_test_delete (string as_type, long as_code);//maha created 021904 called from delete and test records.

long l_code
//long cnt
string ls_text
//SetPointer ( hourglass! )
string s_code

l_code = as_code
s_code = string(l_code)

long 	cnt00,cnt01,cnt02,cnt03,cnt04,cnt05,cnt06,cnt07,cnt08,cnt09,&
		cnt10,cnt11,cnt12,cnt13,cnt14,cnt15,cnt16,cnt17,cnt18,cnt19,&
		cnt20,cnt21,cnt22,cnt23,cnt24,cnt25,cnt26,cnt27,cnt28,cnt29,&
		cnt30,cnt31,cnt32,cnt33,cnt34,cnt35,cnt36,cnt37,cnt38,cnt39,&
		cnt40,cnt41,cnt42,cnt43,cnt44,cnt45,cnt46,cnt47,cnt48,cnt49,&
		cnt50,cnt51,cnt52,cnt53,cnt54,cnt55,cnt56,cnt57,cnt58,cnt59,&
		cnt60,cnt61,cnt62,cnt63,cnt64,cnt65,cnt66,cnt67,cnt68,cnt69,&
		cnt70,cnt71,cnt72,cnt73,cnt74,cnt75,cnt76,cnt77,cnt78,cnt79,&
		cnt80,cnt81,cnt82,cnt83,cnt84,cnt85,cnt86,cnt87,cnt88,cnt89,&
		cnt90,cnt91,cnt92,cnt93,cnt94,cnt95,cnt96,cnt97,cnt98,cnt99,&
		cnt100,cnt101,cnt102,cnt103

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
	select count(prac_id) into :cnt15 from pd_affil_staff_leave where leave_of_absence_reason = :s_code; //Modified by (Appeon)Harry 05.23.2016
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
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Evan 04.21.2011
	//$<reason> Fxied a bug.
	select count(*) into :cnt100 from priv_procd_lookup where clinical_area_id = :l_code;
	select count(*) into :cnt101 from priv_procd_lookup where section_id = :l_code;
	select count(*) into :cnt102 from priv_clinical_area where clin_lookup = :l_code;
	select count(*) into :cnt103 from priv_core where sect_lookup = :l_code;
	//------------------- APPEON END ---------------------
	
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
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Evan 04.21.2011
	//$<reason> Fxied a bug.
	if cnt100 > 0 then
		ls_text = ls_text + "There are " + string(cnt100) + " record(s) in the priv_procd_lookup.clinical_area_id field.~r"
	end if
	if cnt101 > 0 then
		ls_text = ls_text + "There are " + string(cnt101) + " record(s) in the priv_procd_lookup.section_id field.~r"
	end if
	if cnt102 > 0 then
		ls_text = ls_text + "There are " + string(cnt102) + " record(s) in the priv_clinical_area.clin_lookup field.~r"
	end if
	if cnt103 > 0 then
		ls_text = ls_text + "There are " + string(cnt103) + " record(s) in the priv_core.sect_lookup field.~r"
	end if
	//------------------- APPEON END ---------------------	
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

i = w_mdi.of_security_access(560)

if i = 1  then
	cb_new_lookup.Enabled = False
	cb_add.Enabled = False
	cb_saveas.Enabled = False
	cb_delete.Enabled = False
	cb_filter.Enabled = False
	cb_sort.Enabled = False
	cb_print.Enabled = False
	cb_save.Enabled = False
	cb_test.Enabled = False
	ret = 0
else
	cb_new_lookup.Enabled = true
	cb_add.Enabled = True
	cb_saveas.Enabled = True
	cb_delete.Enabled = True
	cb_filter.Enabled = True
	cb_sort.Enabled = True
	cb_print.Enabled = True
	cb_save.Enabled = True
	cb_test.Enabled = True
	ret = 1
end if
	
//Start Code Change ----12.06.2007 #V8 maha
//added because the function is not coded for contracts
if gb_contract_version = true then
	cb_test.visible = false
end if
//End Code Change---12.06.2007



return ret
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

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
//Refresh lookup cachedata - temp process,jervis 02.08.2010 
gnv_appeondb.of_startqueue( ) //Added By Ken.Guo 2010-11-24.
	gnv_data.of_retrieve( "code_lookup" )
	gnv_data.of_retrieve( "code_lookup_2" )
gnv_appeondb.of_commitqueue( )

gnv_app.of_setcontraccache_code_lookup( 'Clause Approval Status', true)

//Refresh lookup data when opened by  screen painter -- jervis 10.14.2010
if is_parm <> "" and not isnull(is_parm) then
	gnv_app.of_setcontraccache_code_lookup( is_parm)
end if
//---------End Modfiied ------------------------------------------------------

return 0
end function

public function integer of_count ();//Start Code Change ---- 03.29.2006 #354 maha created 
//Start Code Change ----08.22.2017 #V154 maha - removed code
//long l
//
//l = dw_detail.rowcount()
//st_count.text = string(l)

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
	dw_record.Modify(ls_TitleName + ".Text='" + ls_TitleText + "'")   //Start Code Change ----05.15.2015 #V15 maha - duplicate in the record dw
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

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
gnv_appeondb.of_startqueue( )//modify by gavin 2012-01-16
SELECT coltitletext
  INTO :ls_OriTitleText
  FROM lookup_coltitle
 WHERE lookup_type = :is_lookup_type AND lookup_name = :is_lookup_name AND coltitlename = :as_LabelName;
 
SELECT Count(*)
  INTO :ll_cnt
  FROM lookup_coltitle
 WHERE lookup_type = :is_lookup_type AND lookup_name = :is_lookup_name AND coltitlename = :as_LabelName;
gnv_appeondb.of_commitqueue( )

if IsNull(ls_OriTitleText) or ls_OriTitleText = "" then
	ls_OriTitleText = dw_detail.Describe(as_LabelName + ".Text")
end if

OpenWithParm(w_SetColLabelText,ls_OriTitleText)
if Message.DoubleParm = -1 then return

ls_NewTitleText = Message.StringParm

//SELECT Count(*)
//  INTO :ll_cnt
//  FROM lookup_coltitle
// WHERE lookup_type = :is_lookup_type AND lookup_name = :is_lookup_name AND coltitlename = :as_LabelName;
//---------End Modfiied ------------------------------------------------------

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

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
n_ds		lds_lookup_coltitle //add by gavin2012-01-13
Long		ll_K, ll_Row
//add by gavin2012-01-13
lds_lookup_coltitle = create n_ds
lds_lookup_coltitle.dataobject = "ds_code_lookup_coltitle"
lds_lookup_coltitle.SetTransObject( SQLCA )
lds_lookup_coltitle.Retrieve( as_lookup_type, as_lookup_name )
//---------End Modfiied ------------------------------------------------------

ls_Objects = dw_detail.Describe("DataWindow.Objects") + "~t"
ll_ColCnt = long(dw_detail.Describe("DataWindow.Column.Count"))
for ll_Cycle = 1 to ll_ColCnt
	if dw_detail.Describe("#" + String(ll_Cycle) + ".Visible") = '1' then
		ls_ColName = dw_detail.Describe("#" + String(ll_Cycle) + ".Name")
		ll_ColCoorX = long(dw_detail.Describe("#" + String(ll_Cycle) + ".X"))
		ll_ColWidth = long(dw_detail.Describe("#" + String(ll_Cycle) + ".Width"))
		
		//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
		// modify by gavin 2012-01-13
		//SELECT Count(*) INTO :ll_RowCnt FROM lookup_coltitle WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColName = :ls_ColName ;
		//if ll_RowCnt > 0 then
		//	UPDATE lookup_coltitle
		//		SET ColCoorX = :ll_ColCoorX,ColWidth = :ll_ColWidth
		//	 WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColName = :ls_ColName ;
		//	 
		//	CONTINUE
		//end if
		lds_lookup_coltitle.SetFilter( "ColName = '" + ls_ColName + "'" )
		lds_lookup_coltitle.Filter( )
		If lds_lookup_coltitle.RowCount( ) > 0 Then
			For ll_K = 1 To lds_lookup_coltitle.RowCount( ) 
				lds_lookup_coltitle.SetItem( ll_k, 'ColCoorX', ll_ColCoorX )
				lds_lookup_coltitle.SetItem( ll_k, 'ColWidth', ll_ColWidth )
			Next
			Continue
		End If
		//---------End Modfiied ------------------------------------------------------
		
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
		
		//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
		//add by gavin 2012-01-13
		//SELECT Count(*) INTO :ll_RowCnt FROM lookup_coltitle WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColTitleName = :ls_ColTitleName ;
		
		//if ll_RowCnt <= 0 then
		//	INSERT INTO lookup_coltitle(Lookup_Type,Lookup_Name,ColTitleName,ColTitleText,ColName,ColCoorX,ColWidth)
		//		  VALUES(:as_lookup_type,:as_lookup_name,:ls_ColTitleName,:ls_ColTitleText,:ls_ColName,:ll_ColCoorX,:ll_ColWidth);
		//else
		//	UPDATE lookup_coltitle
		//		SET ColName = :ls_ColName,ColCoorX = :ll_ColCoorX,ColWidth = :ll_ColWidth
		//	 WHERE lookup_coltitle.lookup_type = :as_lookup_type AND lookup_coltitle.lookup_name = :as_lookup_name AND lookup_coltitle.ColTitleName = :ls_ColTitleName ;
		//end if
		
		lds_lookup_coltitle.SetFilter( "ColTitleName = '" + ls_ColTitleName + "'" )
		lds_lookup_coltitle.Filter( )
		If lds_lookup_coltitle.RowCount( ) <= 0 Then
			ll_Row = lds_lookup_coltitle.InsertRow( 0 )
			lds_lookup_coltitle.SetItem( ll_Row, 'Lookup_Type', 	as_lookup_type )
			lds_lookup_coltitle.SetItem( ll_Row, 'Lookup_Name', 	as_lookup_name )
			lds_lookup_coltitle.SetItem( ll_Row, 'ColTitleName', 	ls_ColTitleName )
			lds_lookup_coltitle.SetItem( ll_Row, 'ColTitleText', 	ls_ColTitleText )
			lds_lookup_coltitle.SetItem( ll_Row, 'ColName',		 	ls_ColName )
			lds_lookup_coltitle.SetItem( ll_Row, 'ColCoorX', 		ll_ColCoorX )			
			lds_lookup_coltitle.SetItem( ll_Row, 'ColWidth',			ll_ColWidth )	
		Else
			For ll_K = 1 To lds_lookup_coltitle.RowCount( ) 
				lds_lookup_coltitle.SetItem( ll_k, 'ColCoorX', ll_ColCoorX )
				lds_lookup_coltitle.SetItem( ll_k, 'ColWidth', ll_ColWidth )
				lds_lookup_coltitle.SetItem( ll_k, 'ColName', ls_ColName )
			Next
		End If
		//---------End Modfiied ------------------------------------------------------
	end if
next

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
/******************************///add by gavin 2012-01-13
lds_lookup_coltitle.SetFilter( "" )
lds_lookup_coltitle.Filter( )
If lds_lookup_coltitle.Update() <> 1 Then
	Messagebox('Error','Failed to save data.' )
	If isvalid(lds_lookup_coltitle) Then Destroy lds_lookup_coltitle
	Return	
End If
/******************************/
//---------End Modfiied ------------------------------------------------------

COMMIT USING SQLCA;

If isvalid(lds_lookup_coltitle) Then Destroy lds_lookup_coltitle  //(Appeon)Eugene 06.18.2013 - V141 ISG-CLX

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
if Pos(dw_detail.dataobject, '_contract') > 0 then Return -1 //skip for contract moudle - alfee 08.30.2010
//if dw_detail.dataobject = 'd_code_lookup_contract' then Return -1 //skip for contract moudle - alfee 05.14.2010

ls_LookupName = Lower(dw_detail.object.lookup_name[1])
if IsNull(ls_LookupName) or ls_LookupName = "" then Return -1
	
SELECT count(*) INTO :ll_Count FROM sys_lookup WHERE lower(lookup_name) = :ls_LookupName;
if ll_Count > 0 then
else
	INSERT INTO sys_lookup(lookup_name) VALUES(:ls_LookupName);
end if

Return 1
end function

public function integer of_facility_field (string as_table);//Start Code Change ----03/17.2011 #V11 maha - new to hide or show facility id field
datawindowchild dwchild

if gs_cust_type = "I" then return 1

Choose case is_lookup_name
	case "Department", 'Division', "Section", "Staff Category"
		dw_detail.modify("facility_id.visible = True")
		dw_record.modify("facility_id.visible = True")
		dw_record.modify("facility_id_t.visible = True")  
		dw_record.modify("b_help.visible = True")  //Start Code Change ----04.26.2012 #V12 maha
		dw_record.getchild( "facility_id", dwchild)
		dwchild.settransobject(sqlca)
		dwchild.retrieve()
		dwchild.insertrow(1)
		dwchild.setitem(1,"facility_id",0)
		dwchild.setitem(1,"facility_name","All")
	case else
		dw_detail.modify("facility_id.visible = false")
		dw_record.modify("facility_id.visible = false")
		dw_record.modify("facility_id_t.visible = false")
		dw_record.modify("b_help.visible = True")  //Start Code Change ----04.26.2012 #V12 maha
		
		
		
end choose

return 1
end function

public function long of_deletelookuptable ();// (Appeon)Eugene 06.18.2013 - V141 ISG-CLX
//====================================================================
// Function: of_DeleteLookupTable()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-10-15
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_CurRow,ll_RowCnts
String	ls_LookupName

DataWindowChild ldwc_Child

DELETE code_lookup
  FROM code_lookup
 WHERE (code_lookup.lookup_name = :is_lookup_name);

if SQLCA.SQLCode <> 0 then
	MessageBox("Delete Error",SQLCA.SQLErrText)
	ROLLBACK;
	
	ll_CurRow = dw_name.GetRow()
	dw_name.SetItem(ll_CurRow,"lookup_name",is_lookup_name)
	dw_name.Event itemchanged(ll_CurRow,dw_name.Object.lookup_name,is_lookup_name)
	
	Return -1
end if

//add by gavin 	2012-01-13
DELETE lookup_coltitle  FROM lookup_coltitle
 WHERE (lookup_coltitle.lookup_name = :is_lookup_name and lookup_coltitle.lookup_type = :is_lookup_type );
if SQLCA.SQLCode <> 0 then
	MessageBox("Delete Error",SQLCA.SQLErrText)
	ROLLBACK;
	
	ll_CurRow = dw_name.GetRow()
	dw_name.SetItem(ll_CurRow,"lookup_name",is_lookup_name)
	dw_name.Event itemchanged(ll_CurRow,dw_name.Object.lookup_name,is_lookup_name)
	
	Return -1
end if
COMMIT;
ib_delete = true // add by gavin 2012-01-13

dw_detail.ResetUpdate()

dw_name.GetChild("lookup_name",ldwc_Child)
ldwc_Child.SetTransObject(SQLCA)
ldwc_Child.Retrieve()

ll_RowCnts = ldwc_Child.RowCount()
if ll_RowCnts > 0 then
	ls_LookupName = ldwc_Child.GetItemString(ll_RowCnts,"lookup_name")
	
	ll_CurRow = dw_name.GetRow()
	dw_name.SetItem(ll_CurRow,"lookup_name",ls_LookupName)
	dw_name.Event itemchanged(ll_CurRow,dw_name.Object.lookup_name,ls_LookupName)
else
	dw_detail.DataObject = ""
end if


Return 1

end function

public function integer of_duplicate ();//---------Begin Added by (Appeon)Harry 11.25.2013 for V141 for BugH103001 of History Issues --------
Long i
Long j
String ls_code
String ls_code_temp
DwItemStatus ldws_Status
integer res

if is_lookup_type = 'A' then return 1  //Start Code Change ----03.18.2014 #V14.2 maha

for i = 1 to dw_detail.RowCount()
	ldws_Status = dw_detail.GetItemStatus(i, "code", Primary!)
	if ldws_Status = newmodified! or ldws_Status = DataModified! then
		ls_code = dw_detail.GetItemString(i, "code")
		for j = 1 to dw_detail.RowCount()
			if i = j then continue
			ls_code_temp = dw_detail.GetItemString(j, "code")
			if ls_code_temp = ls_code then 
				//---------Begin Modified by (Appeon)Harry 04.08.2014 for Bug 3993 created for Case# 00047152: Bug report -------
				/*
				messagebox('Code','Code name duplicate. Please create a new one')
				dw_detail.setrow(i)
				dw_detail.setcolumn("code")
				dw_detail.setfocus( )
				return -1
				*/
				res = messagebox("Duplicate Record","A " + ls_code + " lookup record with this code is already in the database. Do you wish to continue?",question!,yesno!,2)
				if res = 2 then
					dw_detail.setrow(i)
					dw_detail.setcolumn("code")
					dw_detail.setfocus( )
					return -1
				else
					exit
				end if			
				//---------End Modfiied ------------------------------------------------------
			end if
		next
	end if
next 

return 1
//end 
end function

event open;call super::open;//string ls_parm
datawindowchild ldwc_con
is_parm = Message.Stringparm  //(Appeon)Eugene 06.18.2013 - V141 ISG-CLX

//---------Begin Added by (Appeon)Stephen 03.15.2016 for Requested change in contract module drop-down States. case#62257 Bug_id#5043--------
if pos(is_parm, "$Contract$") > 0 then
	is_parm = left(is_parm, pos(is_parm, "$Contract$") - 1)
	dw_name.modify("lookup_name.dddw.name='d_dddw_lookup_select_contract'")
	dw_name.modify("lookup_name.dddw.displaycolumn='lookup_name'")
	dw_name.modify("lookup_name.dddw.datacolumn='lookup_name'")
	dw_name.getchild("lookup_name", ldwc_con)	
	ldwc_con.settransobject(sqlca)
	ldwc_con.retrieve()
else
	if len(is_parm) > 0 then
		
	end if
end if
//---------End Added ------------------------------------------------------

dw_detail.of_SetTransObject(SQLCA)
dw_detail.InsertRow(0)
dw_detail.Enabled = False

dw_name.of_SetTransObject(SQLCA)
dw_name.InsertRow(0)

dw_name.SetFocus()

of_security()

//Start Code Change ----08.22.2017 #V154 maha
il_orgw = this.width
il_orgh = this.height
//End Code Change ----08.22.2017

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
Event ue_change_lookupname(is_parm) //Add by jervis 11.26.2009
//---------End Modfiied ------------------------------------------------------


end event

on w_lookup_maint.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.sle_find=create sle_find
this.cb_3=create cb_3
this.pb_1=create pb_1
this.rb_detail=create rb_detail
this.rb_list=create rb_list
this.st_2=create st_2
this.cb_2=create cb_2
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
this.cb_1=create cb_1
this.cb_letterstorage=create cb_letterstorage
this.dw_record=create dw_record
this.dw_detail=create dw_detail
this.gb_1=create gb_1
this.cb_max=create cb_max
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.sle_find
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.rb_detail
this.Control[iCurrent+6]=this.rb_list
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.dw_name
this.Control[iCurrent+10]=this.cb_new_lookup
this.Control[iCurrent+11]=this.cb_add
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.cb_save
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.cb_sort
this.Control[iCurrent+16]=this.cb_filter
this.Control[iCurrent+17]=this.cb_print
this.Control[iCurrent+18]=this.cb_saveas
this.Control[iCurrent+19]=this.cb_test
this.Control[iCurrent+20]=this.dw_users
this.Control[iCurrent+21]=this.cb_1
this.Control[iCurrent+22]=this.cb_letterstorage
this.Control[iCurrent+23]=this.dw_record
this.Control[iCurrent+24]=this.dw_detail
this.Control[iCurrent+25]=this.gb_1
this.Control[iCurrent+26]=this.cb_max
end on

on w_lookup_maint.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.sle_find)
destroy(this.cb_3)
destroy(this.pb_1)
destroy(this.rb_detail)
destroy(this.rb_list)
destroy(this.st_2)
destroy(this.cb_2)
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
destroy(this.cb_1)
destroy(this.cb_letterstorage)
destroy(this.dw_record)
destroy(this.dw_detail)
destroy(this.gb_1)
destroy(this.cb_max)
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
long ll_foundrow

if LenA(message.stringparm) > 0 then
   DataWindowChild lookup_name_child
   ll_foundrow = dw_name.GetChild('lookup_name', lookup_name_child)
	ll_foundrow = lookup_name_child.Find( "lookup_name = '" + message.stringparm + "'", 1, lookup_name_child.rowcount())

	if ll_foundrow > 0 then
		WordCap ( message.stringparm )
	  	dw_detail.DataObject = "d_code_lookup"
      dw_detail.of_SetTransObject(SQLCA)
		is_lookup_name = message.stringparm 
		dw_detail.event pfc_retrieve( )
		dw_name.settext(message.stringparm)
	end if
end if 
end event

event close;call super::close;
WF_refresh_ctx_cache( )

wf_UpdateUserDefInfo(is_lookup_type,is_lookup_name)		//Added by Scofield on 2008-06-17

end event

event pfc_save;//Added by (Appeon)Harry 11.25.2013 for V141 for BugH103001 of History Issues --------
if not ib_save then //(Appeon)Harry 04.08.2014 - for Bug 3993
	if of_duplicate() <> 1 then return -10  
end if
return Super::Event pfc_save()

end event

event resize;call super::resize;//Start Code Change ----08.22.2017 #V154 maha
long ll_h
long ll_w
long ll_rec_height


ll_h = this.workspaceheight( )
ll_w = this.workspacewidth( )

dw_detail.width = ll_w - 24

if rb_list.checked then 
	dw_detail.height = ll_h - dw_detail.y - 16
else
	ll_rec_height = dw_record.height
	
	dw_record.y = ll_h - ll_rec_height - 16
	dw_record.width = dw_detail.width

	dw_detail.width = dw_record.width
	dw_detail.height = dw_record.y - dw_detail.y - 16
//dw_detail y is fixed
//set height base on space left 
end if





return 1
end event

type cb_4 from u_cb within w_lookup_maint
integer x = 2034
integer y = 224
integer height = 84
integer taborder = 110
boolean bringtotop = true
string text = "&Find"
end type

event clicked;//Start Code Change ----03.04.2016 #V15 maha
string s
string ls_find
long r


if dw_detail.dataobject = "d_address_lookup" then
	s = upper(sle_find.text)
	ls_find =  "upper(entity_name) like '" + s + "%'"
else
	s = upper(sle_find.text)
	ls_find =  "upper(description) like '" + s + "%'"
end if


r = dw_detail.find(ls_find, dw_detail.getrow() + 1, dw_detail.rowcount())

if r < 0 then 	
	messagebox("Search Failed", "Contact ISG support~r~r" + ls_find )
elseif r > 0 then
	dw_detail.scrolltorow(r)
	dw_detail.selectrow(0,false)
	dw_detail.selectrow(r, true)
	dw_detail.setrow(r)
end if
end event

type sle_find from singlelineedit within w_lookup_maint
integer x = 955
integer y = 228
integer width = 1065
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_lookup_maint
boolean visible = false
integer x = 3954
integer y = 28
integer width = 699
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find in CRC data"
end type

type pb_1 from picturebutton within w_lookup_maint
boolean visible = false
integer x = 878
integer y = 136
integer width = 110
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Custom062!"
alignment htextalign = left!
end type

type rb_detail from radiobutton within w_lookup_maint
integer x = 425
integer y = 224
integer width = 421
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "List and Detail"
boolean checked = true
end type

event clicked;//Start Code Change ----01.27.2011 #V11 maha 
//Start Code Change ----08.23.2017 #V154 maha
//dw_detail.height = 950
dw_record.visible = true
parent.triggerevent("resize")
//End Code Change ----08.23.2017
end event

type rb_list from radiobutton within w_lookup_maint
integer x = 101
integer y = 224
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "List only"
end type

event clicked;//Start Code Change ----01.27.2011 #V11 maha 
//Start Code Change ----08.23.2017 #V154 maha
//dw_detail.height = 1744
dw_record.visible = false
parent.triggerevent("resize")
//End Code Change ----08.23.2017
end event

type st_2 from statictext within w_lookup_maint
integer x = 59
integer y = 12
integer width = 526
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Lookup Table"
boolean focusrectangle = false
end type

type cb_2 from u_cb within w_lookup_maint
integer x = 3470
integer y = 216
integer height = 88
integer taborder = 160
boolean bringtotop = true
string text = "C&olumn Label"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-02-14 By: Scofield
//$<Reason> Popup a dialog to modify column label.

String	ls_ColName,ls_Objects,ls_ObjName
long		ll_SepPos

if dw_detail.DataObject = "" then return

ls_ColName = dw_detail.GetColumnName()
if IsNull(ls_ColName) or Trim(ls_ColName) = "" then return

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
	
	//Start Code Change ----10.23.2009 #V10 maha - added message
	if ls_ObjName = "code_t" or ls_ObjName = "description_t" or    ls_ObjName = "large_description_1_t" or ls_ObjName = "large_description_2_t" then
		messagebox("Column Labels","The Column Label cannot be changed for the " + ls_ObjName + " field." )
		return
	end if
	//End Code Change---10.23.2009
	
	wf_SetColLabel(ls_ObjName)
	Exit
loop

//---------------------------- APPEON END ----------------------------

end event

type dw_name from u_dw within w_lookup_maint
integer x = 50
integer y = 72
integer width = 1399
integer height = 76
integer taborder = 10
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

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.26.2009
//$<reason> Corrected BugA101304
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.18.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product

//filter out all Address type lookups and all the lookup that do not have an X next to it in the lookup table
IF gb_contract_version THEN
	This.DataObject = "d_lookup_select_for_contract"
END IF
//---------------------------- APPEON END ----------------------------
*/
if of_get_app_setting("set_9", "I") <> 4 and of_get_app_setting("set_cont", "I") <> 0  then
	// IntelliCred/App and Contract module
elseif of_get_app_setting("set_9", "I") <> 4 then
	// IntelliCred/App module (Do not show contract lookup tables)
	this.DataObject = "d_lookup_select_for_credapp"
elseif of_get_app_setting("set_cont", "I") <> 0 then
	// Contract module
	this.DataObject = "d_lookup_select_for_contract"
end if
//------------------- APPEON END ---------------------
end event

event itemchanged;call super::itemchanged;
of_security()

String ls_lookup_type
string s
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.26.2007 By: Frank.Gui
//$<reason> If modified data cannot be saved, restore to the original lookup name

//IF Parent.Event pfc_save() < 0 THEN
//	Return
//END IF
//
string ls_orgValue
dw_detail.Accepttext( ) //(Appeon)Eugene 06.18.2013 - V141 ISG-CLX
ls_orgValue = this.getitemstring(row,"lookup_name")
IF Parent.Event pfc_save() < 0 THEN
	this.post setitem(row,"lookup_name",ls_orgValue)
	Return
END IF
//---------------------------- APPEON END ----------------------------

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
//wf_UpdateUserDefInfo(is_lookup_type,is_lookup_name)
If Not ib_delete Then wf_UpdateUserDefInfo(is_lookup_type,is_lookup_name)		//Added by Scofield on 2008-06-17 
ib_delete = false //add and modify by gavin 2012-01-13
//---------End Modfiied ------------------------------------------------------

Integer i, li_rc, currentrow, li_found

//---------Begin Added by (Appeon)Harry 11.08.2013 for V141 ISG-CLX--------
DataWindow dw_list[]
dw_list[1] = dw_detail
dw_list[2] = dw_record
//---------End Added ------------------------------------------------------

dw_detail.SetRedraw(False)

cb_LetterStorage.Enabled = false									//Added by Scofield on 2008-11-17

is_lookup_name = This.GetText()

datawindowchild dwchild
This.GetChild("lookup_name", dwchild)

li_found = dwchild.Find("lookup_name = '" + is_lookup_name + "'", 1, 1000)

IF li_found > 0 THEN
	ls_lookup_type = Upper(dwchild.GetItemString(li_found, "type"))	
	IF ls_lookup_type = "A" THEN
		is_lookup_type = "A"
		dw_detail.DataObject = "d_address_lookup"
		dw_record.dataobject = "d_address_lookup_detail"  //Start Code Change ----01.27.2011 #V11 maha 
	ELSE
		is_lookup_type = "C"
		dw_record.DataObject = "d_code_lookup_detail"  //Start Code Change ----01.27.2011 #V11 maha 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.06.2006 By: Liang QingShi
		//$<reason> Contract module modification
		//$<reason> Fix a defect.
		/*
		dw_detail.DataObject = "d_code_lookup"
		*/

		if Lower(is_lookup_name) = 'contract category' then
			dw_detail.DataObject = "d_code_lookup_contract"
			dw_record.DataObject = "d_code_lookup_contract_form"  //(Appeon)Harry 11.08.2013 - V141 ISG-CLX  BugH102201
			//Start 05/08/2007 By Jervis
			/*
			dw_detail.GetChild( "ic_n", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( gs_user_id,'C' )
			*/
			//End
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 11.15.2006 By: Jervis
			//$<reason> modify for work flow 
			if gb_workflow then
				//---------Begin Modified by (Appeon)Harry 11.08.2013 for V141 ISG-CLX  BugH102201--------
//				dw_detail.Modify("custom_5.visible = '1'")
//				dw_detail.GetChild( "custom_5", dwchild )
//				dwchild.SetTransObject( SQLCA )
//				dwchild.SetFilter("wf_triggered_by = '002'")				//Added By Scofield on 2008-03-12
//				dwchild.Retrieve( "03" )	//03-IntelliContract Contract Tracking
//				dwchild.InsertRow(1)
//				dwchild.SetItem(1,"wf_name","")								//Modified By Scofield on 2008-03-12
				for i = 1 to UpperBound (dw_list[])
					dw_list[i].Modify("custom_5.visible = '1'")
					dw_list[i].GetChild( "custom_5", dwchild )
					dwchild.SetTransObject( SQLCA )
					dwchild.SetFilter("wf_triggered_by = '002'")				//Added By Scofield on 2008-03-12
					dwchild.Retrieve( "03" )	//03-IntelliContract Contract Tracking
					dwchild.InsertRow(1)
					dwchild.SetItem(1,"wf_name","")	
				next
				//---------End Modfiied ------------------------------------------------------
			else
				dw_detail.Modify("custom_5.visible = '0'")
				dw_record.Modify("custom_5.visible = '0' cust_5_t.visible = '0'") //(Appeon)Harry 11.08.2013 - V141 ISG-CLX  BugH102201
			end if
			//---------------------------- APPEON END ----------------------------


		//	<add> 09.27.2006 By: Lei Wei
		elseif Lower(is_lookup_name) = 'contract action type' then
			dw_detail.DataObject = "d_code_lookup_for_contract_action_type"
			dw_record.DataObject = "d_code_lookup_contract_action_type_form"  //(Appeon)Harry 11.08.2013 - V141 ISG-CLX  BugH102201
			
			Integer li_word_storage_type

			li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
			IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
			IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
				//---------Begin Modified by (Appeon)Harry 11.08.2013 for V141 ISG-CLX  BugH102201--------
				// Store on Hard Disk
				//dw_detail.GetChild( "custom_6", dwchild )
				//dwchild.Insertrow(0)
				for i = 1 to UpperBound (dw_list[])
					dw_list[i].GetChild( "custom_6", dwchild )
					dwchild.Insertrow(0)
				next
				//---------End Modfiied ------------------------------------------------------
			ELSE
				//---------Begin Modified by (Appeon)Harry 11.08.2013 for V141 ISG-CLX  BugH102201--------
				// Store in Database
				//dw_detail.GetChild( "custom_6", dwchild )
				//dwchild.SetTransObject( SQLCA )
				//dwchild.Retrieve( )
				for i = 1 to UpperBound (dw_list[])
					dw_list[i].GetChild( "custom_6", dwchild )
					dwchild.SetTransObject( SQLCA )
					dwchild.Retrieve( )
				next
				//---------End Modfiied ------------------------------------------------------
			END IF
			
			cb_LetterStorage.Enabled = true									//Added by Scofield on 2008-11-17

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.23.2007 By: Jack (Document Manager)
		//$<reason> 
		elseif Lower(is_lookup_name) = 'contract document status' then
			dw_detail.DataObject = "d_code_lookup_for_contract_document_stat"	
			dw_record.DataObject = "d_code_lookup_for_contract_doc_stat_form"  //(Appeon)Harry 11.08.2013 - V141 ISG-CLX  BugH102201
		//---------------------------- APPEON END ----------------------------
		//-----------Begin Added by Alfee 09.27.2007-------------------------
		//elseif Lower(is_lookup_name) = 'contract status' then  //Commented by (Appeon)Eugene 06.18.2013 - V141 ISG-CLX
		elseif Lower(is_lookup_name) = 'contract status' or Lower(is_lookup_name) = 'contract custom status1' or Lower(is_lookup_name) = 'contract custom status2'  then //add custom status - jervis 04.26.2011
			dw_detail.DataObject = "d_code_lookup_for_contract_status"	
			dw_record.DataObject = "d_code_lookup_for_contract_status_form"  //(Appeon)Harry 11.11.2013 - V141 ISG-CLX  BugH102201
		//-----------End Added -----------------------------------------------	
		
		//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
		elseif Lower(is_lookup_name) = 'clause approval status' then
			dw_detail.DataObject = "d_code_lookup_for_clause_status"
			dw_record.DataObject = "d_code_lookup_for_clause_status_form"  //(Appeon)Harry 11.11.2013 - V141 ISG-CLX  BugH102201
		//---------End Modfiied ------------------------------------------------------
		else
			dw_detail.DataObject = "d_code_lookup"
			of_facility_field(is_lookup_name )
		end if

		//---------------------------- APPEON END ----------------------------

	END IF

	dw_detail.of_SetTransObject(SQLCA)
	dw_record.of_SetTransObject(SQLCA)
	
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

	gnv_appeondb.of_startqueue( )
	
	dw_detail.GetChild( "state", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "state" )
	
	//Start Code Change ----06.21.2011 #V11 maha 
	dw_record.GetChild( "state", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "state" )
	
	dw_record.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )
	//Start Code Change ----06.21.2011
	
	dw_detail.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )		 

	gnv_appeondb.of_commitqueue( )
	
	//---------------------------- APPEON END ----------------------------

END IF

IF is_lookup_name = "Action Type" THEN
	dw_detail.Modify( "cust_6_t.text = 'Include In Graph' ")
	dw_detail.Modify( "cust_2_t.text = 'Default Due Date Days'")
	dw_detail.Modify( "cust_3_t.text = 'Follow Up Days'")		
	dw_detail.Modify( "cust_1_t.text = 'Display Value'")	
	//Start Code Change ----11.05.2012 #V12 maha
	dw_record.Modify( "cust_6_t.text = 'Include In Graph' ")
	dw_record.Modify( "cust_2_t.text = 'Default Due Date Days'")
	dw_record.Modify( "cust_3_t.text = 'Follow Up Days'")		
	dw_record.Modify( "cust_1_t.text = 'Display Value'")	
	//Start Code Change ----11.05.2012 
END IF

IF is_lookup_name = "Privilege Status" THEN   //Start Code Change ----11.15.2010 #V10 maha
	dw_detail.Modify( "cust_1_t.text = 'Enter G if a Granted Selection'")	
	dw_detail.Modify( "cust_1.width = '1000'")
	dw_record.Modify( "cust_1_t.text = 'Granted = G'")	 //Start Code Change ----11.05.2012 #V12 maha
END IF

//Start Code Change ----11.05.2012 #V12 maha
IF is_lookup_name = "Practitioner Category" THEN
	dw_detail.Modify( "cust_6_t.text = 'Allied Health = AH' ")
	dw_record.Modify( "cust_6_t.text = 'Allied Health = AH' ")
end if
	//Start Code Change ----11.05.2012 
	
//Start Code Change ----03.29.2013 #V12 maha
IF is_lookup_name = "License Types" THEN
	dw_detail.Modify( "cust_1_t.text = 'NPDB License code' ")
	dw_record.Modify( "cust_1_t.text = 'NPDB License code' ")
end if
	//Start Code Change ----03.29.2013

IF Upper( is_lookup_name ) = "DEPARTMENT" THEN
//	SELECT set_37
//	INTO :ii_dept_secure_setting
//	FROM icred_settings;
	ii_dept_secure_setting = gi_dept_security
END IF
//Start Code Change ---- 03.29.2006 #354 maha


//Start Code Change ----08.09.2017 #V154 maha
//added to updates
//"UPDATE lookup_coltitle	SET ColTitleText = 'SMS Carrier' ~r~n" + &
//"WHERE lookup_coltitle.lookup_type = 'C' ~r~n" + &
//"AND lookup_coltitle.lookup_name = 'Mobile Carrier' ~r~n" + &
//"AND lookup_coltitle.ColTitleName = 'cust_1_t' ~r~n" + &
//"AND ColTitleText = 'Custom 1' "
//Start Code Change ----08.09.2017


wf_RefreshColTitle(ls_lookup_type,is_lookup_name)		//Added by scofield on 2008-01-16

of_count()

if rb_detail.checked then dw_record.visible = true

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-15 By: Scofield
//$<Reason> Unregister Calendar and register Calendar.

dw_detail.of_SetDropDownCalendar(false)
dw_detail.of_SetDropDownCalendar(true)
//---------------------------- APPEON END ----------------------------

dw_detail.sharedata( dw_record )  //Start Code Change ----04.01.2011 #V11 maha


end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve()
end event

event pfc_update;call super::pfc_update;
Return 0
end event

type cb_new_lookup from u_cb within w_lookup_maint
integer x = 1467
integer y = 68
integer width = 489
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&New Lookup Table"
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

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 02.08.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/* 
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
*/

gnv_appeondb.of_startqueue( )

dw_detail.Retrieve(is_lookup_name)

IF Upper(is_lookup_type) = "A" THEN
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM address_lookup  ;
ELSE
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM code_lookup  ;
END IF

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------


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
//---------Begin Added by (Appeon)Toney 11.21.2013 for V141 ISG-CLX--------
//$Reason:Fix history BugT081601,Refresh the data of dddw.
DataWindowChild dwchild
IF Upper(is_lookup_type) = "A" THEN	
	gnv_appeondb.of_startqueue( )
	
	dw_detail.GetChild( "state", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "state" )	

	dw_record.GetChild( "state", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "state" )
	
	dw_record.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )
	
	dw_detail.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )		 

	gnv_appeondb.of_commitqueue( )
END IF	
//---------End Added ------------------------------------------------------------------

end event

type cb_add from u_cb within w_lookup_maint
integer x = 2391
integer y = 36
integer height = 84
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string text = "&Add"
end type

event clicked;Integer li_row, li_lst_order

if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12
//---------Begin Added by (Appeon)Harry 11.25.2013 for V141 for BugH103001 of History Issues --------
if dw_detail.filteredcount( ) > 0 then
	dw_detail.setfilter("")
	dw_detail.filter( )
end if
//---------end--------
li_row = dw_detail.InsertRow(0)
dw_detail.SetRow(li_row)
dw_detail.ScrollToRow(li_row)
dw_detail.SetItem(li_row, "lookup_name", is_lookup_name)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.26.2007 By: Jack
//$<reason> Fix a defect.
If is_lookup_type = "C" Then
	dw_detail.SetItem(li_row, "type", 'C')
End If	
//---------------------------- APPEON END ----------------------------

il_lookup_code = gnv_app.of_get_id("LOOKUP")

dw_detail.SetItem(li_row, "lookup_code", il_lookup_code)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification
if dw_detail.DataObject = "d_code_lookup_contract" then
	dw_detail.SetItem(li_row, "ic_n", 1001)
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.23.2007 By: Jack (Document Manager)
//$<reason> 
if dw_detail.DataObject = "d_code_lookup_for_contract_document_stat" then
	dw_detail.SetItem(li_row, "custom_1", '0')
end if

//---------------------------- APPEON END ----------------------------

dw_detail.Enabled = True

dw_detail.SetFocus()
dw_detail.SetColumn(1)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-13 By: Scofield
//$<Reason> Refresh the counter
of_count()
//---------------------------- APPEON END ----------------------------


end event

type cb_delete from u_cb within w_lookup_maint
integer x = 2747
integer y = 36
integer height = 84
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
string text = "&Delete"
end type

event clicked;long l_code,ll_Rtn
long cnt
Long ll_department_code
string ls_text

if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

//---------Begin Modified by (Appeon)Harry 08.30.2013 --------
//Reason:to deal with BugT081601
////---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
////IF dw_detail.RowCount() = 1 THEN
////	MessageBox("Delete Error", "You can not delete all of the rows from a lookup.  At least one row must be left in a lookup table.")
////	Return
////END IF
//ll_Rtn = MessageBox("Warning","If this code is being used somewhere, deleting it could cause data display errors.Are you sure you want to delete this code?",Question!,YesNo!)
//if ll_Rtn <> 1 then Return
////---------End Modfiied ------------------------------------------------------
IF dw_detail.RowCount() = 1 THEN
	MessageBox("Delete Error", "You can not delete all of the rows from a lookup.  At least one row must be left in a lookup table to preserve the Lookup Table.")
	Return
END IF
//---------End Modfiied ------------------------------------------------------


if dw_detail.DataObject = "d_address_lookup" then  //Start Code Change ---- 12.06.2007 #V8 maha
	//skip
else
	if dw_detail.getitemstring(dw_detail.getrow(),"type") = "S" then  //Start Code Change ---- 10.15.2007 #V7 maha
			MessageBox("Delete Error", "Grayed lookups are system protected and cannot be deleted. ")
		Return
	END IF
end if

//IF department security is set to ON then track records being deleted so you can delete after save
IF ii_dept_secure_setting = 1 THEN
	ii_delete_cnt++
	il_department_code[ ii_delete_cnt ] = dw_detail.GetItemNumber( dw_detail.GetRow( ), "lookup_code" )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.13.2007 By: Jack (Contract)
//$<reason> fix a defect.
long ll_rowcount,ll_lookup_code,i
string ls_code
dw_detail.accepttext()
ll_lookup_code = dw_detail.GetItemNumber( dw_detail.GetRow( ), "lookup_code" )
ls_code = dw_detail.getitemstring(dw_detail.getrow(),'code')
If Lower(is_lookup_name) = 'contract category' Or lower(is_lookup_name) = 'contract clause category' Then
	datastore lds_contract
	datastore lds_folder
	datastore lds_template
	datastore lds_document
	datastore lds_contract_management_right
	
	lds_contract = Create datastore
	lds_folder = Create datastore
	lds_template = Create datastore
	lds_document = Create datastore
	lds_contract_management_right = Create datastore
	
	lds_contract.dataobject = 'd_lookup_contract'
	lds_contract.settransobject(sqlca)
	lds_folder.dataobject = 'd_lookup_folder'
	lds_folder.settransobject(sqlca)
	lds_template.dataobject = 'd_lookup_template'
	lds_template.settransobject(sqlca)
	lds_document.dataobject = 'd_lookup_document'
	lds_document.settransobject(sqlca)
	lds_contract_management_right.dataobject = 'd_lookup_contract_management_right'
	lds_contract_management_right.settransobject(sqlca)
	
	gnv_appeondb.of_startqueue( )
	lds_contract.retrieve(ll_lookup_code)	
	lds_folder.retrieve(ll_lookup_code)	
	lds_template.retrieve(ll_lookup_code)	
	lds_document.retrieve(ll_lookup_code)	
	lds_contract_management_right.retrieve(ll_lookup_code)	
	gnv_appeondb.of_commitqueue( )
	
	ll_rowcount = lds_contract.rowcount()
	
	If ll_rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Contract Folder->Detail->Category field. Please modify that field first.")
		Return 
	End If
	ll_rowcount = lds_folder.rowcount()
	If ll_rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Clause Painter module. Please modify the Category in the Folder table.")
		Return 
	End If
	
	ll_rowcount = lds_template.rowcount()
	If ll_rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Template Painter module. Please modify the Category in the Template table.")
		Return 
	End If
	ll_rowcount = lds_document.rowcount()
	If ll_rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Document Painter or Document Manager module. Please modify the Category in the Document table.")
		Return 
	End If
	ll_rowcount = lds_contract_management_right.rowcount()
	If ll_rowcount > 0 Then
		For i = ll_rowcount to 1 Step -1
			lds_contract_management_right.deleterow(i)
		Next		
		lds_contract_management_right.update()
	End If
	destroy lds_contract
	destroy lds_folder
	destroy lds_template
	destroy lds_document
	destroy lds_contract_management_right
End If
//---------------------------- APPEON END ----------------------------


//------------------- APPEON BEGIN -------------------
//$<add> Michael 04.27.2011
//$<reason>Deleting Lookup entries from Priv Clinical Area and Priv Section
long cnt0,cnt1,cnt2,cnt3
If Lower(is_lookup_name) = 'priv clinical area' Or lower(is_lookup_name) = 'priv section' Then
	gnv_appeondb.of_startqueue( )
	select count(*) into :cnt0 from priv_procd_lookup where clinical_area_id = :ll_lookup_code;
	select count(*) into :cnt1 from priv_procd_lookup where section_id = :ll_lookup_code;
	select count(*) into :cnt2 from priv_clinical_area where clin_lookup = :ll_lookup_code;
	select count(*) into :cnt3 from priv_core where sect_lookup = :ll_lookup_code;
	gnv_appeondb.of_commitqueue( )
	
	if cnt0 > 0 then
		messagebox("Lookup Data for code - " + ls_code,"This lookup code is required by the Privilege procedure module.")
		Return
	end if
	if cnt1 > 0 then
		messagebox("Lookup Data for code - " + ls_code,"This lookup code is required by the Privilege procedure module.")
		Return
	end if
	if cnt2 > 0 then
		messagebox("Lookup Data for code - " + ls_code,"This lookup code is required by the Privilege templates module.")
		Return
	end if
	if cnt3 > 0 then
		messagebox("Lookup Data for code - " + ls_code,"This lookup code is required by the Privilege templates module.")
		Return
	end if	
end if

//------------------- APPEON END ---------------------



//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.23.2007 By: Evan
//$<reason> New feature of import module.
long ll_Count
SELECT count(*) INTO :ll_Count FROM import_lookup_mapping A, import_lu_map_fields B
WHERE (A.ilm_id = B.ilm_id) AND
		(A.map_type = 'A' or A.map_type = 'C') AND
		(is_lu_code = :ll_lookup_code);
if ll_Count > 0 then
	MessageBox("Lookup Data for code - " + ls_Code, "This lookup code is required by import module in the lookup mapping templates.  There are " + string(ll_count) + " mappings with this lookup value.  Please verify thtat they are no longer needed in the look templates and remove befroe deleting from this screen")
	Return
end if
//---------------------------- APPEON END ----------------------------


//Start Code Change ----02.03.2015 #V14.2 maha
if dw_detail.DataObject = "d_address_lookup" then
	ls_text = of_test_delete("A",ll_lookup_code)
	if ls_text = "NONE" then ls_text = ""

elseif dw_detail.DataObject = "d_code_lookup" then
	ls_text = of_test_delete("C",ll_lookup_code)
	if ls_text = "NONE" then ls_text = ""
end if

if len(ls_text ) > 1 then
	ls_text+= "~rThis record cannot be deleted until connected records are changed or deleted."
	messagebox("Delete", ls_text)
	return
else
	//
end if
//End Code Change ----02.03.2015 

//---------Begin Modified by (Appeon)Harry 08.30.2013 --------
//Reason:to deal with BugT081601
////---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
////dw_detail.Event pfc_deleterow()
////dw_detail.SetFocus()
//IF dw_detail.RowCount() = 1 THEN
//	of_DeleteLookupTable()
//else
//	dw_detail.Event pfc_deleterow()
//	dw_detail.SetFocus()
//end if
////---------End Modfiied ------------------------------------------------------
dw_detail.Event pfc_deleterow()
dw_detail.SetFocus()
//---------End Modfiied ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-13 By: Scofield
//$<Reason> Refresh the counter
of_count()
//---------------------------- APPEON END ----------------------------

end event

type cb_save from u_cb within w_lookup_maint
integer x = 2034
integer y = 36
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "&Save"
end type

event clicked;Integer li_retval
Integer i
Integer ll_department_code

if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-11 By: Scofield
//$<Reason> Verify if there is new row
long		ll_Cycle,ll_Count,ll_AddCnt
long		ll_lookcode[]
Boolean	lb_SaveSucess

dwitemstatus	ldws_Status

dw_detail.AcceptText()
if of_duplicate() <> 1 then return   //Added by (Appeon)Harry 11.25.2013 for V141 for BugH103001 of History Issues --------
lb_SaveSucess = true
if (is_lookup_name = 'Contract Category') or (is_lookup_name = 'Contract Clause Category') then
	ll_Count = dw_detail.RowCount()
	for ll_Cycle = 1 to ll_Count
		ldws_Status = dw_detail.GetItemStatus(ll_Cycle,0,Primary!)
		if ldws_Status = newmodified! then
			ll_AddCnt++
			ll_lookcode[ll_AddCnt] = dw_detail.GetItemNumber(ll_Cycle,'lookup_code')
		end if
	next
end if
//---------------------------- APPEON END ----------------------------

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
Long ll_View_ID_Arr[]
//Added By Ken.Guo 03/21/2012.  Get View ID List which is modified.
If is_lookup_name = 'Contract Category' Then
	ll_Count = dw_detail.RowCount()
	For ll_Cycle = 1 To ll_Count
		If dw_detail.GetItemStatus(ll_Cycle,'ic_n',Primary!) = DataModified! Then
			ll_View_ID_Arr[UpperBound(ll_View_ID_Arr[]) + 1] = dw_detail.GetItemNumber(ll_Cycle,'ic_n')
		End If
	Next
End If
//---------End Modfiied ------------------------------------------------------

inv_audit.of_FieldAudit(dw_detail, is_lookup_type) //Added by Evan on 2008-01-26
ib_save = True //(Appeon)Harry 04.08.2014 - for Bug 3993
li_retval = Parent.Event pfc_save()
ib_save = false //(Appeon)Harry 04.08.2014 - for Bug 3993
//---------Begin Added by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
//if li_Retval = 1 then inv_audit.of_Save() //Added by Evan on 2008-01-26
n_cst_update_screen  lnv_update_screen //Added By Ken.Guo 03/21/2012. 
if li_Retval = 1 then 
	//Added By Ken.Guo 2010-11-24. Need refresh the cache now.
	if gb_contract_module then
		ib_refresh_cache = True 
		WF_refresh_ctx_cache( )
	end if
	
	inv_audit.of_Save() //Added by Evan on 2008-01-26
	
	//Added By Ken.Guo 03/21/2012. Refresh Fee Calc Data 
	SetPointer(HourGlass!)
	lnv_update_screen = Create n_cst_update_screen
	gnv_string.of_delete_duplicate(ll_View_ID_Arr[] )
	For ll_Cycle = 1 To UpperBound(ll_View_ID_Arr)
		lnv_update_screen.of_update_fee_calc(ll_View_ID_Arr[ll_Cycle])
	Next
	If Isvalid(lnv_update_screen) Then Destroy lnv_update_screen
	
End If
//---------End Added ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.30.2007 By: Jack 
//$<reason> Fix a defect.
If li_retval <> 1 Then
	dw_detail.Event pfc_Retrieve()
	lb_SaveSucess = false					//Added by Scofield on 2007-09-11
End If
//---------------------------- APPEON END ----------------------------

IF ib_new_table THEN
	dw_name.Reset()
	dw_name.of_SetTransObject(SQLCA)

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 08.28.2006 By: LeiWei
	//$<reason> Fix a defect.
	datawindowchild ldwc_child
	dw_name.GetChild("lookup_name",ldwc_child)
	ldwc_child.SettransObject(SQLCA)
	ldwc_child.Retrieve()
	//---------------------------- APPEON END ----------------------------

	dw_name.Retrieve()
   dw_name.InsertRow(0)
	dw_name.SetText(is_lookup_name)
	ib_new_table = False	
END IF

dw_detail.SetFocus()

IF ii_delete_cnt > 0 THEN

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<add> 04.03.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------

	
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
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-06
	//$<add> 04.03.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
	
	of_count()
	
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-11 By: Scofield
//$<Reason> Update ctx_acp_contract_management_right table
if ((is_lookup_name = 'Contract Category') or (is_lookup_name = 'Contract Clause Category')) and lb_SaveSucess and ll_AddCnt > 0 then
	for ll_Cycle = 1 to ll_AddCnt
		of_AddRight(ll_lookcode[ll_Cycle],is_lookup_name)
	next
	MessageBox(gnv_app.iapp_object.DisplayName,'By default, all users will have full rights to the new Category you have added.~r~nIf you want to restrict rights for this category then you must go to the System->Role Painter to change the Full Access rights setting.')
end if
//---------------------------- APPEON END ----------------------------

//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
//Modify by Scofield on 2009-10-12
if IsValid(w_contract_field_properties) then
	w_contract_field_properties.of_Refresh_Lookup_dddw()
end if
//---------End Modfiied ------------------------------------------------------



end event

type cb_close from u_cb within w_lookup_maint
integer x = 3470
integer y = 36
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_sort from u_cb within w_lookup_maint
integer x = 2034
integer y = 124
integer height = 84
integer taborder = 100
boolean bringtotop = true
boolean enabled = false
string text = "So&rt"
end type

event clicked;if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

dw_detail.Event pfc_SortDlg()

dw_detail.SetFocus()

end event

type cb_filter from u_cb within w_lookup_maint
integer x = 2391
integer y = 124
integer height = 84
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
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

type cb_print from u_cb within w_lookup_maint
integer x = 2747
integer y = 124
integer height = 84
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string text = "&Print"
end type

event clicked;if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12
dw_detail.Print()
end event

type cb_saveas from u_cb within w_lookup_maint
integer x = 3104
integer y = 124
integer height = 84
integer taborder = 130
boolean bringtotop = true
boolean enabled = false
string text = "&Export"
end type

event clicked;IF dw_detail.DataObject = "" THEN RETURN //Added by Scofield on 2008-03-12
gnv_dw.of_SaveAs(dw_detail,"",text!,true)//.SaveAs( "", Text!, True ) Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path)//For restore directory  Added by Nova 04.29.2008


end event

type cb_test from u_cb within w_lookup_maint
integer x = 3104
integer y = 36
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

if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

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
else //Start Code Change ----07.09.2008 #V81 maha  - modified message to be more informative
	messagebox("Referenced record","No Referenced record found for Standard foreign key data fields.  If custom fields are using lookup tables, this function will not find data connected to them.")
end if
end event

type dw_users from datawindow within w_lookup_maint
boolean visible = false
integer x = 1454
integer y = 16
integer width = 91
integer height = 108
integer taborder = 40
string dataobject = "d_user_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from u_cb within w_lookup_maint
integer x = 3470
integer y = 124
integer height = 84
integer taborder = 150
fontcharset fontcharset = ansi!
string text = "&Help"
end type

event clicked;call super::clicked;MessageBox("IntelliSoft Lookup Info",'To input more information for Large Description 1 or Large Description 2 column, please double click on it.~r~n~r~nTo modify the column label, please right click the column (any position except header) or click the Column Properties button. Label of Code, Description, large Description 1, and large Description 2 cannot be modified.~rThe width and order of the columns can be changed by dragging the column label.')

end event

type cb_letterstorage from u_cb within w_lookup_maint
integer x = 3104
integer y = 220
integer height = 84
integer taborder = 140
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "&Letter Storage"
end type

event clicked;call super::clicked;//====================================================================
// Function: Clicked.cb_LetterStorage()
//--------------------------------------------------------------------
// Description: Open Letter Storage Area Painter
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-17
//====================================================================

String	ls_DocName
long		ll_Row

ll_Row = dw_Detail.GetRow()
if ll_Row <= 0 or ll_Row > dw_Detail.RowCount() then Return

ls_DocName = dw_Detail.GetItemString(ll_Row,"custom_6")
OpenWithParm(w_area_painter,ls_DocName)

dw_Detail.SetFocus()

end event

type dw_record from u_dw within w_lookup_maint
boolean visible = false
integer x = 18
integer y = 1412
integer width = 3822
integer height = 764
integer taborder = 40
string dataobject = "d_address_lookup_detail"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.of_setupdateable(false)  //Add by Stephen 04.12.2011 --- Fixed a bug.
end event

event doubleclicked;call super::doubleclicked;//Start Code Change ----01.12.2012 #V12 maha - copied from dw_detail
String	ls_Text,ls_ObjName
String	ls_Phone,ls_fax,ls_RetParm

if This.AcceptText() <> 1 then return

ls_ObjName = dwo.Name

if ls_ObjName = 'large_description_1' or ls_ObjName = 'large_description_2' then
	ls_Text = This.GetItemString(Row,ls_ObjName)
	OpenWithParm(w_cp_desc,ls_Text)
	if Message.Doubleparm = -1 then return
	This.SetItem(Row,ls_ObjName,Message.StringParm)
	This.AcceptText()
end if


if row > 0 and row <= This.RowCount() then
	if ls_ObjName = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif ls_ObjName = 'fax' then
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

end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----04.26.2012 #V12 maha - added help message
long ll_lu
string ls_entity

if dwo.name = "b_help" then
	messagebox("Facility field","The Facility field is only available for the Department, Division and Section tables.  When set to a specific facility the record will only show in the corresponding drop down list on the Provider Appointment tab Detail 2 Department records, if the Appointment is connected to that Facility.~rAny lookups left blank or set to all will show fall the time.")
elseif dwo.name = "b_cert_set" then
	ll_lu = this.getitemnumber(row, "lookup_code")
	ls_entity = this.getitemstring(row, "entity_name")
	
	gs_pass_ids lst_ids
	lst_ids.l_app_id = ll_lu
	lst_ids.ls_ref_value = ls_entity
	
	openwithparm( w_lookup_maint_cert_data, lst_ids )
end if



end event

event itemchanged;call super::itemchanged; //Start Code Change ----04.07.2015 #V15 maha - zip autofill
if row < 1 then return //(Appeon)Stephen 09.18.2016 - Zip Code autofill does not trigger when editing an Address Lookup entry using the data grid
if dwo.name = "zip" then
	string val
	this.accepttext( )
	//---------Begin Modified by (Appeon)Stephen 09.18.2016 for Zip Code autofill does not trigger when editing an Address Lookup entry using the data grid--------
	//val = this.getitemstring(1,"zip")
	val = this.getitemstring(row,"zip")
	//---------End Modfiied ------------------------------------------------------
	of_zip_fill(val, "ADDLU", this)
end if
end event

type dw_detail from u_dw within w_lookup_maint
integer x = 18
integer y = 344
integer width = 3822
integer height = 1060
integer taborder = 30
string dataobject = "d_address_lookup"
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;Long ll_ret //trap address lookup table retrieve error Added by  Nova 04.09.2010
ll_ret = This.Retrieve(is_lookup_name)
//trap address lookup table retrieve error Added by  Nova 04.09.2010
IF ll_ret = -1 THEN MessageBox("Retrieve Error", is_lookup_name+ "  retrieve failed. ")
RETURN ll_ret
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
long   ll_lookup_code

li_rc = This.RowCount()

if li_rc < 1 then return - 1

if of_security() = 0 then //maha 040204  view only security sets modified to no so that if the user modifies records
	FOR i = 1 TO li_rc
		This.setItemStatus( i, 0, Primary!,NotModified! ) 
	next
	Return Success
end if


is_code_list = '' //(Appeon)Stephen 09.02.2015 - V14.2 Bug # 4698 - Modifying a lookup list entry updates the modify date for each entry in that lookup list
FOR i = 1 TO li_rc
	//---------Begin Modified by (Appeon)Stephen 09.02.2015 for V14.2 Bug # 4698 - Modifying a lookup list entry updates the modify date for each entry in that lookup list--------
	/*
	IF ( This.GetItemStatus( i, 0, Primary! ) = DataModified! OR This.GetItemStatus( i, 0, Primary! ) = NewModified! ) AND is_lookup_type = "A" THEN
		lb_updated = True
	END IF
	*/
	IF ( This.GetItemStatus( i, 0, Primary! ) = DataModified! OR This.GetItemStatus( i, 0, Primary! ) = NewModified! ) THEN
		if is_lookup_type = "A" then
			lb_updated = True
		else
			ll_lookup_code = this.getitemnumber(i,"lookup_code")
			is_code_list = is_code_list + string(ll_lookup_code) +","
		end if
	END IF
	//---------End Modfiied ------------------------------------------------------
	
	IF ii_dept_secure_setting = 1 AND this.getitemstring(1,"lookup_name") = "Department" Then //Evan 08.28.2009 --- Add judged lookup name
		//if a department is added and the department security is turned on then add to security department table.
		IF This.GetItemStatus( i, 0, Primary! ) = NewModified!  THEN	
			of_add_security_dept( i )
		END IF
	END IF	
END FOR

//Start Code Change ---- 03.14.2006 #319 maha
if this.getitemstring(1,"lookup_name") = "Affiliation Status" then
	for i = 1 to li_rc
		if this.getitemstatus(i,0,primary!)=notmodified! then continue   //(Appeon)Stephen 11.29.2017 - Bug ID #5894 for Case #00074180 - Affiliation Status Lookup
		if (LenA (this.getitemstring(i,"code")) > 1 and lower(this.getitemstring(i,"code"))<>'unknown') then
			messagebox("Lookup Data","In the Affilation Status table CODE values must be one character in length and cannot be duplicated. ")
			return - 1
		end if
	next
	for i = 1 to li_rc - 1
		ls_code = this.getitemstring(i ,"code")
		if this.find("code ='" + ls_code + "'", i + 1, li_rc) > 0 then
			messagebox("Lookup Data for code - " + ls_code,"In the Affilation Status table CODE values must be one character in length and cannot be duplicated. ")
			return - 1
		end if
	next
end if

//End Code Change---03.14.2006

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.19.2006 By: Davis
//$<reason> Fix a defect.

IF Lower(is_lookup_name) = 'contract action type' THEN
	FOR i = 1 TO This.Rowcount( )
		IF NOT f_validstr(This.GetitemString(i, "custom_1")) THEN
			This.Setitem(i, "custom_1", This.GetitemString(i, "code"))
		END IF
	END FOR
END IF

//---------------------------- APPEON END ----------------------------




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

event pfc_postupdate;call super::pfc_postupdate;//----Begin Commented by alfee 09.25.2010 ---------
//<$Reason>The function is incomplete and insignificant
//of_AddLookupName() //Add by Evan 05.26.2009 --- Corrected BugK050503
//----End Commented -------------------------------

// mskinner 09 March 2006 -- begin
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.04.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if pos(string(dw_name.inv_base.of_getItem( 1, 'lookup_name')), 'Contract' ) > 0 then 
      ib_refresh_cache = true
end if 
*/
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 04.05.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Have the application refresh the data in ids_code_lookup if the
//$<modification> data in code_lookup table is changed. 
string ls_sql
gnv_appeondb.of_startqueue()
//---------Begin Modified by (Appeon)Stephen 09.02.2015 for V14.2 Bug # 4698 - Modifying a lookup list entry updates the modify date for each entry in that lookup list--------
//update code_lookup set modify_date = getdate() where lookup_name = :is_lookup_name; //11.30.2006 Added by henry.
is_code_list = trim(is_code_list)
if right(is_code_list,1) = ',' then
	is_code_list = left(is_code_list, len(is_code_list) - 1)
end if
If isnull(is_code_list) or is_code_list = '' then is_code_list = '0'  //--------- Modified by (Appeon)Harry 05.23.2016
ls_sql = "update code_lookup set modify_date = getdate() " +"where lookup_name ='" +is_lookup_name +"' and lookup_code in ("+is_code_list +")"
EXECUTE Immediate :ls_sql Using Sqlca;
//---------End Modfiied ------------------------------------------------------

gnv_data.of_retrieve( "code_lookup" )
gnv_data.of_retrieve('code_lookup_2') //Added 11.30.2006 henry

//---------------------------2.26.2016 RP added-----------------------------------
gnv_data.of_retrieveIfNecessary("address_lookup", FALSE)
//-------------------------------------------------------------------------------------

//-----Begin Added by alfee 09.09.2011 -----------------
if dw_detail.DataObject = "d_address_lookup" then 
	if gnv_data.ids_address_lookup.RowCount() > 0 THEN 
		gnv_data.of_retrieve('address_lookup')
	end if
end if
//-----End Added -------------------------------------------
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: LeiWei
//$<reason> Referesh cache for contract.

gnv_app.of_setcontraccache_code_lookup(is_lookup_name)
//18.12.2006 by Allen:Refresh dddw of dw_dashboard if lookup Table changed.
IF IsValid(w_todolist_painter) THEN
	w_todolist_painter.dw_dashboard.Event ue_refresh_dddw(True)
END IF
//---------------------------- APPEON END ----------------------------

RETURN SUCcess

// mskinner 09 March 2006 -- end 


end event

event dropdown;call super::dropdown;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: LeiWei
//$<reason> Browse word document for Contract Action Type.

String ls_column
string docpath, docname
Long ll_row
integer li_rtn
Integer li_word_storage_type

ls_column = This.Getcolumnname()

IF Lower(is_lookup_name) = 'contract action type' THEN
	ll_row = This.Getrow()
	IF ls_column = 'custom_6' THEN
		li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
		IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
		IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
			// Store on Hard Disk
			li_rtn = GetFileOpenName("Select File", docpath, docname, "DOC", "Doc Files (*.DOC),*.DOC")
			ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
			IF li_rtn = 1 THEN
				This.Setitem( ll_row, "custom_6", docname)
			END IF
			RETURN 1
		END IF
	END IF
END IF

if ls_Column = "datetime_1" or ls_Column = "datetime_2" then return 1		//Added by scofield on 2008-03-03

//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.19.2006 By: Davis
////$<reason> Fix a defect.
//
//IF Lower(is_lookup_name) = 'contract action type' THEN
//	IF lower(dwo.name) = 'code' THEN
//		IF LenA(data) > 0 THEN
//			IF NOT f_validstr(This.GetitemString(row, "custom_1")) THEN
//				This.Setitem(row, "custom_1", data)
//			END IF
//		END IF
//	END IF
//END IF
//
////---------------------------- APPEON END ----------------------------

//Modify By Jervis 09.11.2009
IF lower(dwo.name) = 'code' THEN
	IF LEN(data) > 0 THEN
		IF Lower(is_lookup_name) = 'contract action type' THEN
			IF NOT f_validstr(This.GetitemString(row, "custom_1")) THEN
				This.Setitem(row, "custom_1", data)
			END IF
		END IF
		IF Pos('~t' + THIS.Describe("DataWindow.Objects"), '~t' + 'description'+ '~t') > 0 THEN  //(Appeon)Eugene 07.08.2013 - V141 ISG-CLX
			IF NOT f_validstr(This.GetitemString(row, "description")) THEN
				This.Setitem(row, "description", data)
				this.selectedtext( )
			END IF
		END IF 
	END IF
END IF
//---------End Modfiied ------------------------------------------------------

 //Start Code Change ----09.16.2016 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(1,"zip")
	of_zip_fill(val, "ADDLU", this)
end if
end event

event doubleclicked;call super::doubleclicked;String	ls_Text,ls_ObjName

if This.AcceptText() <> 1 then return

ls_ObjName = dwo.Name
if ls_ObjName = 'large_description_1' or ls_ObjName = 'large_description_2' then
	ls_Text = This.GetItemString(Row,ls_ObjName)
	OpenWithParm(w_cp_desc,ls_Text)
	if Message.Doubleparm = -1 then return
	This.SetItem(Row,ls_ObjName,Message.StringParm)
	This.AcceptText()
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-08-01 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm

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

event rowfocuschanged;call super::rowfocuschanged;//Start Code Change ----01.27.2011 #V11 maha 
long ll_id 

//Start Code Change ----04.01.2011 #V11 maha 
//ll_id = this.getitemnumber(currentrow, 'Lookup_code' )
//dw_record.retrieve(ll_id)

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 04.12.2011
//$<reason> Fixed a datawindow bug
/*
dw_record.scrolltorow(currentrow)
dw_record.setrow(currentrow)
*/
dw_record.setrow(currentrow)
dw_record.scrolltorow(currentrow)
//------------------- APPEON END ---------------------

//End Code Change ----04.01.2011
end event

type gb_1 from groupbox within w_lookup_maint
integer x = 59
integer y = 172
integer width = 805
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "View"
end type

type cb_max from commandbutton within w_lookup_maint
integer x = 2747
integer y = 220
integer width = 352
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "EXPAND"
end type

event clicked;//Start Code Change ----07.23.2017 #V154 maha
long ll_h
long ll_w

if this.text = "EXPAND" then
	ll_h = w_mdi.height
	ll_w = w_mdi.width
	parent.height = ll_h - 120
	parent.y = 1
	parent.x = 1
	parent.width = ll_w - 120
	this.text = "NORMAL"
else
	parent.height = il_orgh
	parent.width = il_orgw
	this.text = "EXPAND"
end if


end event

