$PBExportHeader$w_lookup_maint_cleanup.srw
forward
global type w_lookup_maint_cleanup from w_main
end type
type cb_2 from commandbutton within w_lookup_maint_cleanup
end type
type st_6 from statictext within w_lookup_maint_cleanup
end type
type st_5 from statictext within w_lookup_maint_cleanup
end type
type st_4 from statictext within w_lookup_maint_cleanup
end type
type cb_migrate from u_cb within w_lookup_maint_cleanup
end type
type st_3 from statictext within w_lookup_maint_cleanup
end type
type sle_filter from singlelineedit within w_lookup_maint_cleanup
end type
type pb_1 from picturebutton within w_lookup_maint_cleanup
end type
type st_2 from statictext within w_lookup_maint_cleanup
end type
type st_1 from statictext within w_lookup_maint_cleanup
end type
type st_count from statictext within w_lookup_maint_cleanup
end type
type dw_name from u_dw within w_lookup_maint_cleanup
end type
type cb_delete from u_cb within w_lookup_maint_cleanup
end type
type cb_save from u_cb within w_lookup_maint_cleanup
end type
type cb_close from u_cb within w_lookup_maint_cleanup
end type
type cb_sort from u_cb within w_lookup_maint_cleanup
end type
type cb_filter from u_cb within w_lookup_maint_cleanup
end type
type cb_test from u_cb within w_lookup_maint_cleanup
end type
type dw_users from datawindow within w_lookup_maint_cleanup
end type
type cb_1 from u_cb within w_lookup_maint_cleanup
end type
type dw_record from u_dw within w_lookup_maint_cleanup
end type
type dw_search from u_dw within w_lookup_maint_cleanup
end type
end forward

global type w_lookup_maint_cleanup from w_main
integer x = 5
integer y = 312
integer width = 3835
integer height = 2244
string title = "Lookup Table Cleanup"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
cb_2 cb_2
st_6 st_6
st_5 st_5
st_4 st_4
cb_migrate cb_migrate
st_3 st_3
sle_filter sle_filter
pb_1 pb_1
st_2 st_2
st_1 st_1
st_count st_count
dw_name dw_name
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
cb_sort cb_sort
cb_filter cb_filter
cb_test cb_test
dw_users dw_users
cb_1 cb_1
dw_record dw_record
dw_search dw_search
end type
global w_lookup_maint_cleanup w_lookup_maint_cleanup

type variables
String is_lookup_name
String is_lookup_type
string is_entity_name

Boolean ib_new_table = False

Integer ii_delete_cnt
Integer ii_dept_secure_setting = 0


Long il_lookup_code
Long il_department_code[]


boolean ib_refresh_cache 


n_ds ids_fields 
n_ds ids_data_screen[]
n_ds ids_audit
n_ds ids_verif

n_cst_code_lookup_audit inv_audit //Added by Evan on 2008-01-26
end variables

forward prototypes
public function integer wf_refresh_ctx_cache ()
public subroutine wf_refreshcoltitle (string as_lookup_type, string as_lookup_name)
public function integer of_facility_field (string as_table)
public function string of_test_delete (string as_type, long as_code, string as_name)
public function integer of_migrate_data ()
public function integer of_find_records ()
public function integer of_destroy_ds1 ()
public function string of_set_reference (string as_ref, integer as_pos)
public function integer of_find_records_ctx (string as_lookup_table)
end prototypes

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

public subroutine wf_refreshcoltitle (string as_lookup_type, string as_lookup_name);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-16 By: Scofield
//$<Reason> Modify column title text.

long		ll_Cycle,ll_Count,ll_InvComPos,ll_ColCoorX,ll_CorWidth
String	ls_TitleName,ls_TitleText,ls_ColName

CONSTANT LONG SPACEWIDTH = 9

DataStore	lds_ColTitle

dw_search.SetRedraw(false)

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
	dw_search.Modify(ls_TitleName + ".Text='" + ls_TitleText + "'")
	
	ls_ColName = lds_ColTitle.GetItemString(ll_Cycle,'ColName')
	ll_ColCoorX = lds_ColTitle.GetItemNumber(ll_Cycle,'ColCoorX')
	ll_CorWidth = lds_ColTitle.GetItemNumber(ll_Cycle,'ColWidth')
	
	if Not IsNull(ls_ColName) and Trim(ls_ColName) <> "" then
		dw_search.Modify(ls_ColName + ".X=" + String(ll_ColCoorX - SPACEWIDTH))
		dw_search.Modify(ls_ColName + ".Width=" + String(ll_CorWidth))
	end if
next

Destroy lds_ColTitle

dw_search.SetRedraw(true)

//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_facility_field (string as_table);//Start Code Change ----03/17.2011 #V11 maha - new to hide or show facility id field
datawindowchild dwchild

if gs_cust_type = "I" then return 1

Choose case is_lookup_name
	case "Department", 'Division', "Section", "Staff Category"
		dw_search.modify("facility_id.visible = True")
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
		dw_search.modify("facility_id.visible = false")
		dw_record.modify("facility_id.visible = false")
		dw_record.modify("facility_id_t.visible = false")
		dw_record.modify("b_help.visible = True")  //Start Code Change ----04.26.2012 #V12 maha
		
		
		
end choose

return 1
end function

public function string of_test_delete (string as_type, long as_code, string as_name);//maha created 021904 called from delete and test records.

long l_code
//long cnt
string ls_text
//SetPointer ( hourglass! )
string s_code

l_code = as_code
s_code = String(l_code)

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
		ls_text = ls_text + "There are " + string(cnt00) + " record(s) in the pd_education.school_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt01 > 0 then
		ls_text = ls_text + "There are " + string(cnt01) + " record(s) in the pd_acedemic_appointments.school_code field for lookup - " + upper(as_name) + ".~r"
	end if	
	if cnt02 > 0 then
		ls_text = ls_text + "There are " + string(cnt02) + " record(s) in the pd_insurance.carrier_code field for lookup - " + upper(as_name) + ".~r"
	end if	
	if cnt03 > 0 then
		ls_text = ls_text + "There are " + string(cnt03) + " record(s) in the pd_board_specialty.board_code field for lookup - " + upper(as_name) + ".~r"
	end if	
	if cnt04 > 0 then
		ls_text = ls_text + "There are " + string(cnt04) + " record(s) in the pd_license.verifying_agency field for lookup - " + upper(as_name)  + ".~r"
	end if	
	if cnt05 > 0 then
		ls_text = ls_text + "There are " + string(cnt05) + " record(s) in the pd_other_affill.institution_code field for lookup - " + upper(as_name) + ".~r"
	end if	
	if cnt06 > 0 then
		ls_text = ls_text + "There are " + string(cnt06) + " record(s) in the pd_training.institution_code field for lookup - " + upper(as_name)  + ".~r"
	end if	
	if cnt07 > 0 then
		ls_text = ls_text + "There are " + string(cnt07) + " record(s) in the pd_hosp_affil.hospital_code field for lookup - " + upper(as_name) + ".~r"
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
	select count(prac_id) into :cnt15 from pd_affil_staff_leave where leave_of_absence_reason = :s_code;   //Modified by (Appeon)Harry 05.23.2016
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
		ls_text = ls_text + "There are " + string(cnt00) + " record(s) in the pd_acedemic_appointments.department_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt01 > 0 then
		ls_text = ls_text + "There are " + string(cnt01) + " record(s) in the pd_acedemic_appointments.faculty_rank_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt02 > 0 then
		ls_text = ls_text + "There are " + string(cnt02) + " record(s) in the pd_address.accepting_new_patients field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt03 > 0 then
		ls_text = ls_text + "There are " + string(cnt03) + " record(s) in the pd_address.adolescent field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt04 > 0 then
		ls_text = ls_text + "There are " + string(cnt04) + " record(s) in the pd_address.adult field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt05 > 0 then
		ls_text = ls_text + "There are " + string(cnt05) + " record(s) in the pd_address.child field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt06 > 0 then
		ls_text = ls_text + "There are " + string(cnt06) + " record(s) in the pd_address.country field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt07 > 0 then
		ls_text = ls_text + "There are " + string(cnt07) + " record(s) in the pd_address.county field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt08 > 0 then
		ls_text = ls_text + "There are " + string(cnt08) + " record(s) in the pd_address.handicapped_access field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt09 > 0 then
		ls_text = ls_text + "There are " + string(cnt09) + " record(s) in the pd_address.office_in_home field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt10 > 0 then
		ls_text = ls_text + "There are " + string(cnt10) + " record(s) in the pd_address.practice_type field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt11 > 0 then
		ls_text = ls_text + "There are " + string(cnt11) + " record(s) in the pd_address.public_transportation field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt12 > 0 then
		ls_text = ls_text + "There are " + string(cnt12) + " record(s) in the pd_address.senior_adult field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt13 > 0 then
		ls_text = ls_text + "There are " + string(cnt13) + " record(s) in the pd_address.state field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt14 > 0 then
		ls_text = ls_text + "There are " + string(cnt14) + " record(s) in the pd_address.young_child field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt15 > 0 then
		ls_text = ls_text + "There are " + string(cnt15) + " record(s) in the pd_affil_staff_leave.leave_of_absence_reason field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt16 > 0 then
		ls_text = ls_text + "There are " + string(cnt16) + " record(s) in the pd_affil_staff_cat.staff_category field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt17 > 0 then
		ls_text = ls_text + "There are " + string(cnt17) + " record(s) in the pd_affil_stat.affil_ended_reason field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt18 > 0 then
		ls_text = ls_text + "There are " + string(cnt18) + " record(s) in the pd_basic.married field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt19 > 0 then
		ls_text = ls_text + "There are " + string(cnt19) + " record(s) in the pd_basic.name_suffix field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt20 > 0 then
		ls_text = ls_text + "There are " + string(cnt20) + " record(s) in the pd_basic.pob_country field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt21 > 0 then
		ls_text = ls_text + "There are " + string(cnt21) + " record(s) in the pd_basic.pob_state field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt22 > 0 then
		ls_text = ls_text + "There are " + string(cnt22) + " record(s) in the pd_basic.prac_category field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt23 > 0 then
		ls_text = ls_text + "There are " + string(cnt23) + " record(s) in the pd_basic.prof_suffix field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt24 > 0 then
		ls_text = ls_text + "There are " + string(cnt24) + " record(s) in the pd_basic.provider_type field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt25 > 0 then
		ls_text = ls_text + "There are " + string(cnt25) + " record(s) in the pd_basic.rank field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt26 > 0 then
		ls_text = ls_text + "There are " + string(cnt26) + " record(s) in the pd_basic.sex(gender) field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt27 > 0 then
		ls_text = ls_text + "There are " + string(cnt27) + " record(s) in the pd_basic.title field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt28 > 0 then
		ls_text = ls_text + "There are " + string(cnt28) + " record(s) in the pd_board_specialty.specialty field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt29 > 0 then
		ls_text = ls_text + "There are " + string(cnt29) + " record(s) in the pd_board_specialty.specialty_order field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt30 > 0 then
		ls_text = ls_text + "There are " + string(cnt30) + " record(s) in the pd_claims.status_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt31 > 0 then
		ls_text = ls_text + "There are " + string(cnt31) + " record(s) in the pd_clinical_specialties.specialty_expertise field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt32 > 0 then
		ls_text = ls_text + "There are " + string(cnt32) + " record(s) in the pd_clinical_specialties.rank field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt33 > 0 then
		ls_text = ls_text + "There are " + string(cnt33) + " record(s) in the pd_postgrad_train.category field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt34 > 0 then
		ls_text = ls_text + "There are " + string(cnt34) + " record(s) in the pd_postgrad_train.loc_state field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt35 > 0 then
		ls_text = ls_text + "There are " + string(cnt35) + " record(s) in the pd_dea_state_csr.cat_1 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt36 > 0 then
		ls_text = ls_text + "There are " + string(cnt36) + " record(s) in the pd_dea_state_csr.cat_2 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt37 > 0 then
		ls_text = ls_text + "There are " + string(cnt37) + " record(s) in the pd_dea_state_csr.cat_3 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt38 > 0 then
		ls_text = ls_text + "There are " + string(cnt38) + " record(s) in the pd_dea_state_csr.cat_4 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt39 > 0 then
		ls_text = ls_text + "There are " + string(cnt39) + " record(s) in the pd_dea_state_csr.cat_5 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt40 > 0 then
		ls_text = ls_text + "There are " + string(cnt40) + " record(s) in the pd_dea_state_csr.cat_6 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt41 > 0 then
		ls_text = ls_text + "There are " + string(cnt41) + " record(s) in the pd_dea_state_csr.cat_7 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt42 > 0 then
		ls_text = ls_text + "There are " + string(cnt42) + " record(s) in the pd_dea_state_csr.cat_8 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt43 > 0 then
		ls_text = ls_text + "There are " + string(cnt43) + " record(s) in the pd_dea_state_csr.cat_9 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt44 > 0 then
		ls_text = ls_text + "There are " + string(cnt44) + " record(s) in the pd_dea_state_csr.cat_10 field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt45 > 0 then
		ls_text = ls_text + "There are " + string(cnt45) + " record(s) in the pd_dea_state_csr.state field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt46 > 0 then
		ls_text = ls_text + "There are " + string(cnt46) + " record(s) in the pd_affil_dept.department field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt47 > 0 then
		ls_text = ls_text + "There are " + string(cnt47) + " record(s) in the pd_affil_dept.rank(division) field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt48 > 0 then
		ls_text = ls_text + "There are " + string(cnt48) + " record(s) in the pd_affil_dept.section field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt49 > 0 then
		ls_text = ls_text + "There are " + string(cnt49) + " record(s) in the pd_education.education_type field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt50 > 0 then
		ls_text = ls_text + "There are " + string(cnt50) + " record(s) in the pd_education.degree field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt51 > 0 then
		ls_text = ls_text + "There are " + string(cnt51) + " record(s) in the pd_group_providers.specialty field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt52 > 0 then
		ls_text = ls_text + "There are " + string(cnt52) + " record(s) in the pd_group_providers.covering field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt53 > 0 then
		ls_text = ls_text + "There are " + string(cnt53) + " record(s) in the pd_hosp_affil.department_a field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt54 > 0 then
		ls_text = ls_text + "There are " + string(cnt54) + " record(s) in the pd_hosp_affil.department_b field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt55 > 0 then
		ls_text = ls_text + "There are " + string(cnt55) + " record(s) in the pd_hosp_affil.department_c field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt56 > 0 then
		ls_text = ls_text + "There are " + string(cnt56) + " record(s) in the pd_hosp_affil.section_a field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt57 > 0 then
		ls_text = ls_text + "There are " + string(cnt57) + " record(s) in the pd_hosp_affil.section_b field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt58 > 0 then
		ls_text = ls_text + "There are " + string(cnt58) + " record(s) in the pd_hosp_affil.section_c field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt59 > 0 then
		ls_text = ls_text + "There are " + string(cnt59) + " record(s) in the pd_hosp_affil.admitting_priv field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt60 > 0 then
		ls_text = ls_text + "There are " + string(cnt60) + " record(s) in the pd_hosp_affil.staff_category field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt61 > 0 then
		ls_text = ls_text + "There are " + string(cnt61) + " record(s) in the pd_insurance.claims_made_occurrence field for lookup - " + upper(as_name) + ".~r"
	end if	
	if cnt62 > 0 then
		ls_text = ls_text + "There are " + string(cnt62) + " record(s) in the pd_insurance.state_coverage field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt63 > 0 then
		ls_text = ls_text + "There are " + string(cnt63) + " record(s) in the pd_insurance.state_funded_pool field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt64 > 0 then
		ls_text = ls_text + "There are " + string(cnt64) + " record(s) in the pd_insurance.tail_coverage field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt65 > 0 then
		ls_text = ls_text + "There are " + string(cnt65) + " record(s) in the pd_languages.foreign_language field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt66 > 0 then
		ls_text = ls_text + "There are " + string(cnt66) + " record(s) in the pd_languages.speak field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt67 > 0 then
		ls_text = ls_text + "There are " + string(cnt67) + " record(s) in the pd_languages.sign field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt68 > 0 then
		ls_text = ls_text + "There are " + string(cnt68) + " record(s) in the pd_languages.writes field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt69 > 0 then
		ls_text = ls_text + "There are " + string(cnt69) + " record(s) in the pd_languages.reads field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt70 > 0 then
		ls_text = ls_text + "There are " + string(cnt70) + " record(s) in the pd_license.license_type_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt71 > 0 then
		ls_text = ls_text + "There are " + string(cnt71) + " record(s) in the pd_license.state field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt72 > 0 then
		ls_text = ls_text + "There are " + string(cnt72) + " record(s) in the pd_other_affill.function_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt73 > 0 then
		ls_text = ls_text + "There are " + string(cnt73) + " record(s) in the pd_other_ids.id_type field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt74 > 0 then
		ls_text = ls_text + "There are " + string(cnt74) + " record(s) in the pd_address_2.work_comp_state field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt75 > 0 then
		ls_text = ls_text + "There are " + string(cnt75) + " record(s) in the pd_references.name_suffix field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt76 > 0 then
		ls_text = ls_text + "There are " + string(cnt76) + " record(s) in the pd_references.country for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt77 > 0 then
		ls_text = ls_text + "There are " + string(cnt77) + " record(s) in the pd_references.title for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt78 > 0 then
		ls_text = ls_text + "There are " + string(cnt78) + " record(s) in the pd_references.state for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt79 > 0 then
		ls_text = ls_text + "There are " + string(cnt79) + " record(s) in the pd_references.prof_suffix field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt80 > 0 then
		ls_text = ls_text + "There are " + string(cnt80) + " record(s) in the pd_sanctions.action_sanction_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt81 > 0 then
		ls_text = ls_text + "There are " + string(cnt81) + " record(s) in the pd_sanctions.status_activity_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt82 > 0 then
		ls_text = ls_text + "There are " + string(cnt82) + " record(s) in the pd_special_certs.certified_in field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt83 > 0 then
		ls_text = ls_text + "There are " + string(cnt83) + " record(s) in the pd_training.fellowship_type_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt84 > 0 then
		ls_text = ls_text + "There are " + string(cnt84) + " record(s) in the pd_training.internship_type_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt85 > 0 then
		ls_text = ls_text + "There are " + string(cnt85) + " record(s) in the pd_training.train_type field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt86 > 0 then
		ls_text = ls_text + "There are " + string(cnt86) + " record(s) in the pd_training.specialty field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt87 > 0 then
		ls_text = ls_text + "There are " + string(cnt87) + " record(s) in the pd_priv_list.status_code field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt88 > 0 then
		ls_text = ls_text + "There are " + string(cnt88) + " record(s) in the net_dev_action_items.action_type field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt89 > 0 then
		ls_text = ls_text + "There are " + string(cnt89) + " record(s) in the net_dev_action_items.action_status field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt90 > 0 then
		ls_text = ls_text + "There are " + string(cnt90) + " record(s) in the net_dev_action_items.action_dept field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt91 > 0 then
		ls_text = ls_text + "There are " + string(cnt91) + " record(s) in the net_dev_ids.plan_type field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt92 > 0 then
		ls_text = ls_text + "There are " + string(cnt92) + " record(s) in the net_dev_ids.tier field for lookup - " + upper(as_name) + ".~r"
	end if
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Evan 04.21.2011
	//$<reason> Fxied a bug.
	if cnt100 > 0 then
		ls_text = ls_text + "There are " + string(cnt100) + " record(s) in the priv_procd_lookup.clinical_area_id field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt101 > 0 then
		ls_text = ls_text + "There are " + string(cnt101) + " record(s) in the priv_procd_lookup.section_id field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt102 > 0 then
		ls_text = ls_text + "There are " + string(cnt102) + " record(s) in the priv_clinical_area.clin_lookup field for lookup - " + upper(as_name) + ".~r"
	end if
	if cnt103 > 0 then
		ls_text = ls_text + "There are " + string(cnt103) + " record(s) in the priv_core.sect_lookup field for lookup - " + upper(as_name) + ".~r"
	end if
	//------------------- APPEON END ---------------------	
end if


//SetPointer ( arrow! )
If LenA(ls_text) > 1 then
	return(ls_text)
	messagebox("Referenced records found",ls_text)
else
	return("NONE")
	//messagebox("Referenced record","No Referenced record found")
end if

end function

public function integer of_migrate_data ();long rcnt
integer t
integer res
integer li_ref_pos[]
long r
long rec
long prac
long v
long vc
long a
long ll_rec
long ll_prac
long ll_recids[]
long ll_pracids[]
long ll_table
long ll_field
long ll_seq_no
long ll_find
string ls_type
string ls_org
string ls_new
string ls_ref
datetime ldt_now
String ls_Error //Added by Appeon long.zhang 09.23.2014

ldt_now = datetime(today(),now())

//get connected records
if of_find_records( ) = -1 then return 0

//if il_lookup_code < 1 then
if dw_search.getrow( ) < 1 or IsNull(dw_search.getItemNumber(dw_search.getrow( ),"lookup_code")) then	//long.zhang 10.15.2012
	messagebox("Lookup Cleanup","No To record has been selected")
	return -1
end if

ids_audit = create n_ds
ids_audit.dataobject = "d_address_lookup_cleanup_audit"
ids_audit.settransobject(sqlca)

ids_verif = create n_ds
ids_verif.dataobject = "d_address_lookup_cleanup_verifs"
ids_verif.settransobject(sqlca)



//retrieve the seq no
SELECT Max( sys_audit.seq_no )  INTO :ll_seq_no		FROM sys_audit;

IF IsNull(ll_seq_no) THEN ll_seq_no = 0
ll_seq_no++

ls_new  = is_entity_name   //new value for audit


//update fields with new value
for t = 1 to upperbound(ids_data_screen)
	rcnt = ids_data_screen[t].rowcount()	
	ls_type = ids_fields.getitemstring(t, "field_type")
	ll_table = ids_fields.getitemnumber(t, "table_id")
	ll_field = ids_fields.getitemnumber(t, "field_id")
	//determine if field being updated is part of the verif reference
	if ids_fields.getitemnumber(t, "reference_field_1") = ll_field then
		li_ref_pos[t] = 1
	elseif ids_fields.getitemnumber(t, "reference_field_2") = ll_field then
		li_ref_pos[t] = 2
	else
		li_ref_pos[t] = 0
	end if
	
	rcnt = ids_data_screen[t].rowcount()
	
	if rcnt < 1 then continue  //Start Code Change ----09.20.2012 #V12 maha
	
	for r = 1 to rcnt
		ll_recids[r] =  ids_data_screen[t].getitemnumber(r, 1)
		ll_pracids[r] =  ids_data_screen[t].getitemnumber(r, 2)
	next
	
	//retrieve related verifications
	vc = ids_verif.retrieve( ll_recids[],ll_pracids[])
debugbreak()
	for r = 1 to rcnt
		choose case ls_type //get original value for audit
			case "C","V"
				ls_org = ids_data_screen[t].getitemstring(r, 3)
			case else
				ls_org = string( ids_data_screen[t].getitemnumber(r, 3))
		end choose
		ll_find = dw_record.find( "lookup_code = " + ls_org ,1, 1000000)
		
		if dw_record.dataobject = "d_address_lookup_cl_select" then  //Start Code Change ----09.20.2012 #V12 maha
			ls_org = dw_record.getitemstring(ll_find,"entity_name")
		else
			ls_org = dw_record.getitemstring(ll_find,"description")
		end if
		
		ll_rec =  ids_data_screen[t].getitemnumber(r, 1)
		ll_prac =  ids_data_screen[t].getitemnumber(r, 2)
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 09.23.2014
		//<$>reason:Columns of 'lookup_code' sometimes have the type of char. v14.2 Bug 4232 created for Case# 00050001: Fwd: Push back on Webview
		
		//set values
		//ids_data_screen[t].setitem(r, 3, il_lookup_code )  //update the record
		if LeftA(ids_data_screen[t].object.#3.ColType,4) = 'char' then
			ids_data_screen[t].setitem(r, 3, string(il_lookup_code) )
		else
			ids_data_screen[t].setitem(r, 3, il_lookup_code )  //update the record
		end if
		//------------------- APPEON END -------------------
		
//update verifications reference value and address lookup code.		
		for v = 1 to ids_verif.rowcount()
			rec =  ids_verif.getitemnumber( v , "rec_id") 
			prac =  ids_verif.getitemnumber( v , "prac_id")
			if ll_rec = ids_verif.getitemnumber( v , "rec_id") and ll_prac = ids_verif.getitemnumber( v , "prac_id") then
				if is_lookup_type = "A" then ids_verif.setitem(v , "address_lookup_code", il_lookup_code ) //set the lookup code if an address lookup
				ls_ref = ids_verif.getitemstring(v, "reference_value")
				if li_ref_pos[t] > 0 then  //reset reference id needed
					ls_ref = of_set_reference(ls_ref, li_ref_pos[t])
					 ids_verif.setitem( v , "reference_value", ls_ref)
				end if
			end if
		next
//write audit records		
		a = ids_audit.insertrow(0)
		ids_audit.setitem(a,"rec_id", ll_rec )
		ids_audit.setitem(a,"prac_id", ll_prac )
		ll_seq_no++
		ids_audit.setitem(a,"seq_no", ll_seq_no )
		ids_audit.setitem(a,"old_value", ls_org )
		ids_audit.setitem(a,"new_value", ls_new )
		ids_audit.setitem(a,"date_time_modified", ldt_now)
		ids_audit.setitem(a,"table_id", ll_table)
		ids_audit.setitem(a,"field_id", ll_field)
		ids_audit.setitem(a,"exported", 1 )
		ids_audit.setitem(a,"user_id",  gs_user_id )
		ids_audit.setitem(a,"audit_type", "BLU" )
	next
	
next

//update data tables
for t = 1 to upperbound(ids_data_screen)
	res = ids_data_screen[t].update()
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 09.23.2014
	//<$>reason:if there is no data in ids_data_screen to update,it doesn't need to show message.  Bug 4232 created for Case# 00050001: Fwd: Push back on Webview 
	
	//if res < 0 then messagebox("Data screen " + string(t) + " update failed",t) //Start Code Change ----09.20.2012 #V12 maha
	if res < 0 and ids_data_screen[t].rowcount()>0 then messagebox("Migration failed", "Data screen " + string(t) + " update failed")  //Start Code Change ----10.07.2014 #V14.2 maha - modifed message
	
	//------------------- APPEON END -------------------

next

//update audit and verifications
res = ids_audit.update()
if res < 0 then messagebox("Audit update failed",t)
res = ids_verif.update()
if res < 0 then messagebox("Verification update failed",t)


of_destroy_ds1( )

messagebox("Lookups migration","Data migration complete.")

return 1
end function

public function integer of_find_records ();
long ll_lcnt = 0
long fc
long f
long r
long rcnt
long rtotal
long ll_lu_codes[]  //maha 10.08.2012
integer li_table_cnt
integer res
string ls_tname
string ls_fname
string ls_type
string ls_sql
string ls_vals = ""
string ls_presentation_str, ERRORS,ls_dwsyntax_str
string ls_key[],ls_empty[]//Added by Appeon long.zhang 02.14.2015
string ls_others//Added by Appeon long.zhang 02.14.2015
n_cst_dw_update_prop ln_dw_update	//added by long.zhang 09.19.2012
n_ds lds_data_screen_null[]


for r = 1 to dw_record.rowcount()
	if dw_record.getitemnumber(r,"selected") = 1 then
		if il_lookup_code = dw_record.getitemnumber(r,"lookup_code") then continue  //Start Code Change ----09.21.2012 #V12 maha - trap if same record is selected as the migrate to
		ll_lcnt++
		ll_lu_codes[ll_lcnt]  = dw_record.getitemnumber(r,"lookup_code") //Start Code Change ----10.08.2012 #V12 maha 
		if ll_lcnt > 1 then ls_vals+= ", "

		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 09.23.2014
		//<$>reason:Columns of 'lookup_code' sometimes have the type of char. (Bug 4232 created for Case# 00050001: Fwd: Push back on Webview)

		//ls_vals = ls_vals + string(dw_record.getitemnumber(r,"lookup_code"))
		ls_vals = ls_vals + "'"+ string(dw_record.getitemnumber(r,"lookup_code")) + "'"
		
		//------------------- APPEON END -------------------
	end if 
next

if ll_lcnt < 1 then 
	Messagebox("Find Data Records", " There are no lookup records selected for checking.")
	return -1
end if

//---------Begin Modified by (Appeon)Stephen 06.12.2017 for Bug id 5683 - Lookup Cleanup Utility Not Working for Some Lookup Types SaaS 05272017, Client Server V15.311 Build date 06082017--------
/*
choose case is_lookup_name 
	Case "Action Type", "Action Status"
		//Start Code Change ----10.08.2012 #V12 maha 
		for r = 1 to upperbound(ll_lu_codes[])
			of_test_delete( "C", ll_lu_codes[r], is_lookup_name)
		next
		return 1
end choose
*/
//this gets the data fields connected to the selected lookup tables
ids_fields = create n_ds
if is_lookup_name = "Action Type" or is_lookup_name = "Action Status" then	
	ids_fields.dataobject = "d_sys_table_fields_active_connect"
else
	ids_fields.dataobject = "d_sys_table_fields_lookup_connect"
end if
//---------End Modfiied ------------------------------------------------------

ids_fields.settransobject(sqlca)
fc = ids_fields.retrieve(is_lookup_type, is_lookup_name)

if fc < 1 then 
	messagebox("Find Connected Records","There are no data fields connected to the selected lookup Table.")
	of_destroy_ds1()
	return -1
end if


ids_data_screen[] = lds_data_screen_null[]	//added by long.zhang 10.19.2012	need initial array BugL092001 
//from list of tables fields, create data stores to get connected records
for f = 1 to fc
	ls_tname = ids_fields.getitemstring( f ,"table_name")
	ls_fname = ids_fields.getitemstring( f ,"field_name")
	ls_type = ids_fields.getitemstring( f ,"field_type")
	
	//------------------- APPEON BEGIN -------------------
	//<$>Modified:long.zhang 02.14.2015
	//<$>reason:Add key columns ,by Appeon long.zhang 02.14.2015 (issue:Lookup Cleanup utility)
	ls_others = ''
	ls_key[] =ls_empty[]
	If ln_dw_update.of_GetTableKey(ls_tname, ls_key[]) > 0 Then
		For r = 1 to upperbound(ls_key[])
			If ls_key[r] <> 'rec_id' and ls_key[r] <> 'prac_id' Then ls_others += ", "+ls_key[r]
		Next
	End If
	
	//ls_sql = "Select rec_id, prac_id, " +  ls_fname + " from " + ls_tname +  " where " +  ls_fname +  " in ( " + ls_vals + ") ;"
	ls_sql = "Select rec_id, prac_id, " +  ls_fname + ls_others + " from " + ls_tname +  " where " +  ls_fname +  " in ( " + ls_vals + ") ;"
	//------------------- APPEON END -------------------	
	
	ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=255 )" + "Text(Background.Color=0)"  
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN -1
	END IF
	
	ids_data_screen[ f ] = create n_ds
	ids_data_screen[ f ].create(ls_dwsyntax_str, ERRORS)


	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", "Create cause these errors: " + ERRORS)
		RETURN -1
	END IF
	
	//ln_dw_update.of_modifyupdateproperty( ids_data_screen[ f ],ls_tname)//Alpha id 3272 - long.zhang 09.19.2012
	ln_dw_update.of_modifyupdateproperty( ids_data_screen[ f ], ls_tname, false) //long.zhang 10.22.2012 
	
	ids_data_screen[ f ].settransobject(sqlca)
	//--------appeon begin------------
	//<$>commented by long.zhang 10.19.2012
	//<$>reason:improve  retrieve speed on web BugL092001 
	//	r = ids_data_screen[ f ].retrieve()
	//	rtotal = rtotal + r
	//--------appeon end-------------
next

//-----------appeon begin----------
//<$>added: long.zhang 10.19.2012
//<$>reason:improve  retrieve speed on web BugL092001 
gnv_appeondb.of_startqueue( )
	for f = 1 to upperbound(ids_data_screen[])
		ids_data_screen[f].retrieve()
	end for
gnv_appeondb.of_commitqueue( )

for f = 1 to upperbound(ids_data_screen[])
	rtotal += ids_data_screen[f].rowcount()
end for
//-----------appeon end--------------

messagebox("Found records",string(rtotal) + " records found in " + string( fc ) + " data fields.")


return 1
end function

public function integer of_destroy_ds1 ();integer r

if isvalid(ids_fields ) then destroy ids_fields 

for r = 1 to upperbound(ids_data_screen)
	if isvalid (ids_data_screen[r]) then destroy ids_data_screen[r]
next

if isvalid(ids_audit ) then destroy ids_audit
if isvalid(ids_verif ) then destroy ids_verif

return 1
end function

public function string of_set_reference (string as_ref, integer as_pos);//created to update the reference value

integer p1 = 1
integer p2
string ls_ret

do until p1 = 0
	p1 = pos(as_ref, "-" , p1 + 1 )
	if p1 > 0 then p2 = p1
	
loop

if as_pos = 1 then
	ls_ret = is_entity_name + " " + mid(as_ref, p2)
else // 2
	ls_ret = mid(as_ref, 1, p2) + " " +  is_entity_name
end if

ls_ret = left(ls_ret,100)

return ls_ret


	
end function

public function integer of_find_records_ctx (string as_lookup_table);//Start Code Change ----07.26.2017 #V154 maha - added for contacts cleanup

long ll_lcnt = 0
long fc
long f
long r
long rcnt
long rtotal
long ll_lu_codes[]  //maha 10.08.2012
integer li_table_cnt
integer p1
integer p2
integer res
string ls_tname
string ls_fname
string ls_lu_name
string ls_view

string ls_type
string ls_sql
string ls_vals = ""
string ls_presentation_str, ERRORS,ls_dwsyntax_str
string ls_key[],ls_empty[]//Added by Appeon long.zhang 02.14.2015
string ls_others//Added by Appeon long.zhang 02.14.2015
n_cst_dw_update_prop ln_dw_update	//added by long.zhang 09.19.2012
n_ds lds_data_screen_null[]

datastore lds_fields

lds_fields = create datastore

lds_fields.dataobject = "d_code_lookup_ctx_lookup_fields"
lds_fields.settransobject(sqlca)

fc = lds_fields.retrieve()

for r = 1 to fc
	ls_lu_name = lds_fields.getitemstring(r, "field_data")
	p1 =  pos(upper(ls_lu_name), "TAG=")
	p2 = pos(ls_lu_name, '"', p1+7)
	ls_lu_name = mid(ls_lu_name, p1 + 5 , p2 - p1 - 5)
	
	if ls_lu_name <> is_lookup_name then continue
	
	ls_tname = lds_fields.getitemstring(r, "table_data")
	p1 =  pos(upper(ls_tname), "CTX_")
	if p1 = 0 then continue
	p2 = pos(ls_tname, '.', p1+5)
	ls_tname = mid(ls_tname, p1 , p2 - p1 )
//messagebox("table" + string(p1), ls_tname)	
//	if ls_tname= "release 11." then continue
	

	ls_fname = lds_fields.getitemstring(r, "field_data")
	p1 =  pos(upper(ls_fname),  "(NAME=")
	p2 = pos(ls_fname, " vis", p1+7)
	ls_fname = mid(ls_fname, p1 + 6 , p2 - p1 - 6)
	
	ls_view = lds_fields.getitemstring(r, "screen_name")
	
	ls_sql = "Lookup: " + ls_lu_name + "~r"
	ls_sql+= "Table: " + ls_tname + "~r"
	ls_sql+= "Field: " + ls_fname + "~r"
	
	messagebox("Found", ls_sql)
	
//	if r < 6 then
//		messagebox("field", ls_fname)
//		messagebox("view",ls_lu_name)
//		messagebox("table", ls_tname)
//	end if
	
next

destroy lds_fields

//for r = 1 to dw_record.rowcount()
//	if dw_record.getitemnumber(r,"selected") = 1 then
//		if il_lookup_code = dw_record.getitemnumber(r,"lookup_code") then continue  //Start Code Change ----09.21.2012 #V12 maha - trap if same record is selected as the migrate to
//		ll_lcnt++
//		ll_lu_codes[ll_lcnt]  = dw_record.getitemnumber(r,"lookup_code") //Start Code Change ----10.08.2012 #V12 maha 
//		if ll_lcnt > 1 then ls_vals+= ", "
//
//		//------------------- APPEON BEGIN -------------------
//		//<$>added:long.zhang 09.23.2014
//		//<$>reason:Columns of 'lookup_code' sometimes have the type of char. (Bug 4232 created for Case# 00050001: Fwd: Push back on Webview)
//
//		//ls_vals = ls_vals + string(dw_record.getitemnumber(r,"lookup_code"))
//		ls_vals = ls_vals + "'"+ string(dw_record.getitemnumber(r,"lookup_code")) + "'"
//		
//		//------------------- APPEON END -------------------
//	end if 
//next
//
//if ll_lcnt < 1 then 
//	Messagebox("Find Data Records", " There are no lookup records selected for checking.")
//	return -1
//end if
//
////---------Begin Modified by (Appeon)Stephen 06.12.2017 for Bug id 5683 - Lookup Cleanup Utility Not Working for Some Lookup Types SaaS 05272017, Client Server V15.311 Build date 06082017--------
///*
//choose case is_lookup_name 
//	Case "Action Type", "Action Status"
//		//Start Code Change ----10.08.2012 #V12 maha 
//		for r = 1 to upperbound(ll_lu_codes[])
//			of_test_delete( "C", ll_lu_codes[r], is_lookup_name)
//		next
//		return 1
//end choose
//*/
////this gets the data fields connected to the selected lookup tables
//ids_fields = create n_ds
//if is_lookup_name = "Action Type" or is_lookup_name = "Action Status" then	
//	ids_fields.dataobject = "d_sys_table_fields_active_connect"
//else
//	ids_fields.dataobject = "d_sys_table_fields_lookup_connect"
//end if
////---------End Modfiied ------------------------------------------------------
//
//ids_fields.settransobject(sqlca)
//fc = ids_fields.retrieve(is_lookup_type, is_lookup_name)
//
//if fc < 1 then 
//	messagebox("Find Connected Records","There are no data fields connected to the selected lookup Table.")
//	of_destroy_ds1()
//	return -1
//end if
//
//
//ids_data_screen[] = lds_data_screen_null[]	//added by long.zhang 10.19.2012	need initial array BugL092001 
////from list of tables fields, create data stores to get connected records
//for f = 1 to fc
//	ls_tname = ids_fields.getitemstring( f ,"table_name")
//	ls_fname = ids_fields.getitemstring( f ,"field_name")
//	ls_type = ids_fields.getitemstring( f ,"field_type")
//	
//	//------------------- APPEON BEGIN -------------------
//	//<$>Modified:long.zhang 02.14.2015
//	//<$>reason:Add key columns ,by Appeon long.zhang 02.14.2015 (issue:Lookup Cleanup utility)
//	ls_others = ''
//	ls_key[] =ls_empty[]
//	If ln_dw_update.of_GetTableKey(ls_tname, ls_key[]) > 0 Then
//		For r = 1 to upperbound(ls_key[])
//			If ls_key[r] <> 'rec_id' and ls_key[r] <> 'prac_id' Then ls_others += ", "+ls_key[r]
//		Next
//	End If
//	
//	//ls_sql = "Select rec_id, prac_id, " +  ls_fname + " from " + ls_tname +  " where " +  ls_fname +  " in ( " + ls_vals + ") ;"
//	ls_sql = "Select rec_id, prac_id, " +  ls_fname + ls_others + " from " + ls_tname +  " where " +  ls_fname +  " in ( " + ls_vals + ") ;"
//	//------------------- APPEON END -------------------	
//	
//	ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=255 )" + "Text(Background.Color=0)"  
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
//
//	IF LenA(ERRORS) > 0 THEN
//		MessageBox("Caution", &
//		"SyntaxFromSQL caused these errors: " + ERRORS)
//		RETURN -1
//	END IF
//	
//	ids_data_screen[ f ] = create n_ds
//	ids_data_screen[ f ].create(ls_dwsyntax_str, ERRORS)
//
//
//	IF LenA(ERRORS) > 0 THEN
//		MessageBox("Caution", "Create cause these errors: " + ERRORS)
//		RETURN -1
//	END IF
//	
//	//ln_dw_update.of_modifyupdateproperty( ids_data_screen[ f ],ls_tname)//Alpha id 3272 - long.zhang 09.19.2012
//	ln_dw_update.of_modifyupdateproperty( ids_data_screen[ f ], ls_tname, false) //long.zhang 10.22.2012 
//	
//	ids_data_screen[ f ].settransobject(sqlca)
//	//--------appeon begin------------
//	//<$>commented by long.zhang 10.19.2012
//	//<$>reason:improve  retrieve speed on web BugL092001 
//	//	r = ids_data_screen[ f ].retrieve()
//	//	rtotal = rtotal + r
//	//--------appeon end-------------
//next
//
////-----------appeon begin----------
////<$>added: long.zhang 10.19.2012
////<$>reason:improve  retrieve speed on web BugL092001 
//gnv_appeondb.of_startqueue( )
//	for f = 1 to upperbound(ids_data_screen[])
//		ids_data_screen[f].retrieve()
//	end for
//gnv_appeondb.of_commitqueue( )
//
//for f = 1 to upperbound(ids_data_screen[])
//	rtotal += ids_data_screen[f].rowcount()
//end for
////-----------appeon end--------------
//
//messagebox("Found records",string(rtotal) + " records found in " + string( fc ) + " data fields.")
//

return 1
end function

event open;call super::open;////Start Code Change ----07.10.2012 #V12 maha - this window created for V12.2 release

dw_name.of_SetTransObject(SQLCA)
dw_name.InsertRow(0)

dw_name.SetFocus()


end event

on w_lookup_maint_cleanup.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.cb_migrate=create cb_migrate
this.st_3=create st_3
this.sle_filter=create sle_filter
this.pb_1=create pb_1
this.st_2=create st_2
this.st_1=create st_1
this.st_count=create st_count
this.dw_name=create dw_name
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_test=create cb_test
this.dw_users=create dw_users
this.cb_1=create cb_1
this.dw_record=create dw_record
this.dw_search=create dw_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.cb_migrate
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_filter
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_count
this.Control[iCurrent+12]=this.dw_name
this.Control[iCurrent+13]=this.cb_delete
this.Control[iCurrent+14]=this.cb_save
this.Control[iCurrent+15]=this.cb_close
this.Control[iCurrent+16]=this.cb_sort
this.Control[iCurrent+17]=this.cb_filter
this.Control[iCurrent+18]=this.cb_test
this.Control[iCurrent+19]=this.dw_users
this.Control[iCurrent+20]=this.cb_1
this.Control[iCurrent+21]=this.dw_record
this.Control[iCurrent+22]=this.dw_search
end on

on w_lookup_maint_cleanup.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.cb_migrate)
destroy(this.st_3)
destroy(this.sle_filter)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_count)
destroy(this.dw_name)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_test)
destroy(this.dw_users)
destroy(this.cb_1)
destroy(this.dw_record)
destroy(this.dw_search)
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
//if LenA(message.stringparm) > 0 then
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

event closequery;return 0
end event

type cb_2 from commandbutton within w_lookup_maint_cleanup
integer x = 3374
integer y = 180
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "test"
end type

event clicked;of_find_records_ctx( "")
end event

type st_6 from statictext within w_lookup_maint_cleanup
integer x = 55
integer y = 524
integer width = 78
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "4 - "
boolean focusrectangle = false
end type

type st_5 from statictext within w_lookup_maint_cleanup
integer x = 50
integer y = 440
integer width = 1353
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "3 -Select the Lookup Records you wish to migrate FROM."
boolean focusrectangle = false
end type

type st_4 from statictext within w_lookup_maint_cleanup
integer x = 46
integer y = 264
integer width = 736
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "2 - Select Record to migrate TO"
boolean focusrectangle = false
end type

type cb_migrate from u_cb within w_lookup_maint_cleanup
integer x = 133
integer y = 512
integer width = 357
integer height = 84
integer taborder = 60
fontcharset fontcharset = ansi!
string text = "Migrate Data"
end type

event clicked;call super::clicked;of_migrate_data( )
end event

type st_3 from statictext within w_lookup_maint_cleanup
integer x = 55
integer y = 176
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Enter Filter Value"
boolean focusrectangle = false
end type

type sle_filter from singlelineedit within w_lookup_maint_cleanup
integer x = 485
integer y = 156
integer width = 1024
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_lookup_maint_cleanup
boolean visible = false
integer x = 2112
integer y = 12
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

type st_2 from statictext within w_lookup_maint_cleanup
integer x = 46
integer y = 16
integer width = 558
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "1 - Select Lookup Table"
boolean focusrectangle = false
end type

type st_1 from statictext within w_lookup_maint_cleanup
integer x = 599
integer y = 2156
integer width = 2254
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_count from statictext within w_lookup_maint_cleanup
boolean visible = false
integer x = 3936
integer y = 2084
integer width = 169
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
boolean focusrectangle = false
end type

type dw_name from u_dw within w_lookup_maint_cleanup
integer x = 37
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

event itemchanged;call super::itemchanged;String ls_lookup_type
Integer i, li_rc, currentrow, li_found
datawindowchild dwchild

is_lookup_name = This.GetText()

This.GetChild("lookup_name", dwchild)

li_found = dwchild.Find("lookup_name = '" + is_lookup_name + "'", 1, 1000)

IF li_found > 0 THEN
	ls_lookup_type = Upper(dwchild.GetItemString(li_found, "type"))	
	IF ls_lookup_type = "A" THEN
		is_lookup_type = "A"
		dw_search.DataObject = "d_address_lookup_cl_search"
		dw_record.dataobject = "d_address_lookup_cl_select"  
	ELSE
		is_lookup_type = "C"
		dw_search.DataObject = "d_code_lookup_cl_search"
		dw_record.DataObject = "d_code_lookup_cl_select"
	END IF

	dw_search.of_SetTransObject(SQLCA)
	dw_record.of_SetTransObject(SQLCA)
	
	//IF Upper(is_lookup_type) = "A" THEN
		dw_search.getchild("lookup_code", dwchild)
		dwchild.settransobject(sqlca)
		dwchild.retrieve(is_lookup_name)
		dw_search.insertrow(1)
		dw_record.Retrieve(is_lookup_name)
//	else
//		dw_search.getchild("lookup_code", dwchild)
//		dwchild.settransobject(sqlca)
//		dwchild.retrieve(is_lookup_name)
//		dw_search.insertrow(1)
//		dw_record.Retrieve(is_lookup_name)
//		dw_record.Retrieve(is_lookup_name)
//	end if


	dw_search.ScrollToRow(1)
	dw_search.SetRow(1)
END IF

dw_search.SetFocus()


//IF Upper(is_lookup_type) = "A" THEN
//	 SELECT Max( lookup_code )  
//    INTO :il_lookup_code  
//    FROM address_lookup  ;
//ELSE
//	 SELECT Max( lookup_code )  
//    INTO :il_lookup_code  
//    FROM code_lookup  ;
//END IF
//IF IsNull( il_lookup_code ) THEN
//	il_lookup_code = 0
//END IF

//IF ls_lookup_type = "A" THEN
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-03
//	//$<modify> 02.16.2006 By: owen chen
//	//$<reason> Performance tuning
//	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//	/*
//	dw_search.GetChild( "state", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( "state" )
//
//	dw_search.GetChild( "country", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( "country" )	
//	*/
//	gnv_appeondb.of_startqueue( )
//	
//	dw_search.GetChild( "state", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( "state" )
//	
//	//Start Code Change ----06.21.2011 #V11 maha 
//	dw_record.GetChild( "state", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( "state" )
//	
//	dw_record.GetChild( "country", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( "country" )
//	//Start Code Change ----06.21.2011
//	
//	dw_search.GetChild( "country", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( "country" )		 
//
//	gnv_appeondb.of_commitqueue( )
//	
//	//---------------------------- APPEON END ----------------------------
//
//END IF

IF is_lookup_name = "Action Type" THEN
	dw_search.Modify( "cust_6_t.text = 'Include In Graph' ")
	dw_search.Modify( "cust_2_t.text = 'Default Due Date Days'")
	dw_search.Modify( "cust_3_t.text = 'Follow Up Days'")		
	dw_search.Modify( "cust_1_t.text = 'Display Value'")	
END IF

IF is_lookup_name = "Privilege Status" THEN   //Start Code Change ----11.15.2010 #V10 maha
	dw_search.Modify( "cust_1_t.text = 'Enter G if a Granted Selection'")	
	dw_search.Modify( "cust_1.width = '1000'")
END IF

IF Upper( is_lookup_name ) = "DEPARTMENT" THEN
//	SELECT set_37
//	INTO :ii_dept_secure_setting
//	FROM icred_settings;
	ii_dept_secure_setting = gi_dept_security
END IF
//Start Code Change ---- 03.29.2006 #354 maha

//wf_RefreshColTitle(ls_lookup_type,is_lookup_name)		//Added by scofield on 2008-01-16





//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-15 By: Scofield
//$<Reason> Unregister Calendar and register Calendar.

dw_search.of_SetDropDownCalendar(false)
dw_search.of_SetDropDownCalendar(true)
//---------------------------- APPEON END ----------------------------

dw_search.sharedata( dw_record )  //Start Code Change ----04.01.2011 #V11 maha


end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve()
end event

event pfc_update;call super::pfc_update;
Return 0
end event

type cb_delete from u_cb within w_lookup_maint_cleanup
boolean visible = false
integer x = 3433
integer y = 512
integer height = 84
integer taborder = 80
boolean bringtotop = true
string text = "&Delete"
end type

event clicked;long l_code
long cnt
Long ll_department_code
string ls_text
long r, rc
long ll_rowcount,ll_lookup_code,i
string ls_code


if dw_record.DataObject = "" then return			//Added by Scofield on 2008-03-12

IF dw_record.RowCount() = 1 THEN
	MessageBox("Delete Error", "You can not delete all of the rows from a lookup.  At least one row must be left in a lookup table.")
	Return
END IF

r = MessageBox("Delete Lookups", "Are you sure you wish to delete the selected lookups?",question!, yesno!, 2)

if r = 2 then return //10.23.2012 #V12 maha - added

for r = dw_record.rowcount() to 1 step -1
	
	if dw_record.getitemnumber(r,"selected") = 1 then
		if dw_record.DataObject = "d_code_lookup_cl_select" then 
			if dw_record.getitemstring(dw_search.getrow(),"type") = "S" then  
					MessageBox("Delete Error", "Grayed lookups are system protected and cannot be deleted. ")
				Continue //10.23.2012 #V12 maha - changed from return
			END IF
		end if

		//IF department security is set to ON then track records being deleted so you can delete after save
		if lower(is_lookup_name) = 'department' then //Start Code Change ----10.08.2012 #V12 maha - added this if
			IF ii_dept_secure_setting = 1 THEN
				ii_delete_cnt++
				il_department_code[ ii_delete_cnt ] = dw_search.GetItemNumber( dw_search.GetRow( ), "lookup_code" )
			END IF
		end if


		dw_record.accepttext()
		ll_lookup_code = dw_search.GetItemNumber( dw_search.GetRow( ), "lookup_code" )
		ls_code = dw_search.getitemstring(dw_search.getrow(),'code')
		
		//contracts specific
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
		End If //contracts specific


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
				messagebox("Lookup Data for code - " + ls_code,"This lookup has connected data in the Privilege Procedures.")
				Return
			end if
			if cnt1 > 0 then
				messagebox("Lookup Data for code - " + ls_code,"This lookup has connected data in the Privilege Procedures.")
				Return
			end if
			if cnt2 > 0 then
				messagebox("Lookup Data for code - " + ls_code,"This lookup has connected data in the Privilege Templates.")
				Return
			end if
			if cnt3 > 0 then
				messagebox("Lookup Data for code - " + ls_code,"This lookup has connected data in the Privilege Templates.")
				Return
			end if	
		end if //privileges

		// import module.
		long ll_Count
		SELECT count(*) INTO :ll_Count FROM import_lookup_mapping A, import_lu_map_fields B
		WHERE (A.ilm_id = B.ilm_id) AND
				(A.map_type = 'A' or A.map_type = 'C') AND
				(is_lu_code = :ll_lookup_code);
		if ll_Count > 0 then
			MessageBox("Lookup Data for code - " + ls_Code, "This lookup code is required by Import module.")
			Return
		end if //import module
		
		//Final test
		if of_test_delete(is_lookup_type , ll_lookup_code ,is_lookup_name ) <> 'None' then
			continue
		else
			dw_record.deleterow(r) //delete record
		end if
		
		dw_record.update() //save data
	end if //record selected
	
	
	
next


end event

type cb_save from u_cb within w_lookup_maint_cleanup
integer x = 2725
integer y = 40
integer height = 84
integer taborder = 60
boolean bringtotop = true
string text = "&Save"
end type

event clicked;dw_record.update()
end event

type cb_close from u_cb within w_lookup_maint_cleanup
integer x = 3447
integer y = 40
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_sort from u_cb within w_lookup_maint_cleanup
integer x = 1888
integer y = 152
integer height = 88
integer taborder = 100
boolean bringtotop = true
string text = "So&rt"
end type

event clicked;if dw_search.DataObject = "" then return			//Added by Scofield on 2008-03-12

dw_search.Event pfc_SortDlg()

dw_search.SetFocus()

end event

type cb_filter from u_cb within w_lookup_maint_cleanup
integer x = 1527
integer y = 152
integer height = 88
integer taborder = 110
boolean bringtotop = true
string text = "&Filter"
end type

event clicked;string ls_f
datawindowchild dwchild


ls_f = upper(sle_filter.text)
if len( ls_f ) =0 then 
	ls_f = ""
else
	if is_lookup_type = "A" then
		ls_f = "upper(entity_name) like '%" + ls_f + "%'"
	else
		ls_f = "upper(description) like '%" + ls_f + "%'"
	end if
end if

dw_search.getchild("lookup_code", dwchild)
dwchild.SetFilter(ls_f)
dw_record.SetFilter(ls_f)
dwchild.Filter()
dw_record.Filter()




end event

type cb_test from u_cb within w_lookup_maint_cleanup
integer x = 2807
integer y = 512
integer width = 613
integer height = 84
integer taborder = 90
boolean bringtotop = true
string text = "F&ind Connected Records"
end type

event clicked;long l_code
long cnt1 = 0
long cnt2
long r 
string ls_text
string ls_name

of_find_records( )
of_destroy_ds1()
return
//@@@@@@@@@@@@@@@@2

//SetPointer ( hourglass! )
//
//if dw_record.DataObject = "" then return			//Added by Scofield on 2008-03-12
//
//if dw_record.rowcount() = 0 then return //maha 012505
//
//for r = 1 to dw_record.rowcount()
//	if dw_record.getitemnumber(r,"selected") = 1 then
//		cnt1++
//		l_code = dw_record.getitemnumber( r ,"lookup_code")
//		if is_lookup_type = "A" then
//			ls_name = dw_record.getitemstring( r ,"entity_name") + " - " + dw_record.getitemstring( r ,"entity_name")
//		else
//			ls_name = dw_record.getitemstring( r ,"description")
//		end if
//		
//		ls_text = of_test_delete( is_lookup_type,l_code, ls_name)
//		if ls_text = "NONE" then ls_text = ""
//		If LenA(ls_text) > 1 then
//			messagebox("Referenced records found for Standard lookups",ls_text)
//			cnt2++
//		end if
//	end if
//next
//
//SetPointer ( Arrow! )
//if cnt1 = cnt2 then
//	//no additional message
//elseIf Cnt2 = 0 then
//	messagebox("Referenced record","No Referenced records found for Standard foreign key data fields.  If custom fields are using lookup tables, this function will not find data connected to them.")
//else
//	messagebox("Referenced record","No Referenced records found for other lookup selected lookups.")
//end if
end event

type dw_users from datawindow within w_lookup_maint_cleanup
boolean visible = false
integer x = 2007
integer y = 24
integer width = 91
integer height = 108
integer taborder = 40
string dataobject = "d_user_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from u_cb within w_lookup_maint_cleanup
integer x = 3086
integer y = 40
integer height = 84
integer taborder = 150
fontcharset fontcharset = ansi!
string text = "&Help"
end type

event clicked;call super::clicked;
string s

s = "This utility is designed to facilitate the cleanup of lookup records, particularly post-conversion.~r "

s += "Note that this is designed specifically for Credentialing (Demographics) Data and will not be effective on lookups connected to setup Screens.~r~r"

s += "Use as follows:~r~r"

s += "1 - Select the desired lookup table for migration.  This will retrieve the lookup records for that table.~r"

s += "If Desired, filter by entering part of the Entity Name and click Filter.  Both the dropdown list and the record list will be filtered~r~r"

s += "2- Select from the dropdown the record which you wish to migrate the data TO.  The selected record will be highlighted in the record list.~r~r"

s += "3 - Select the checkbox for each of the lookup records which you wish to migrate FROM~r~r"

s += "4 - Click the Migrate Data button to start the process.  The program will search for data fields that use the selected lookup table.~r~r"

s += "For each field found, the utility will get the data from those tables matching the selected FROM lookup records.  Each found data record will be updated with the TO lookup value.~r~r"

s += "Audit records will be created for each record updated.  The update type will be BLU.~r~r"

s += "Verifications connected to each record will have the Reference value updated.~r~r"


MessageBox("Lookup Migration Utility",s)

end event

type dw_record from u_dw within w_lookup_maint_cleanup
integer y = 608
integer width = 3817
integer height = 1544
integer taborder = 40
string dataobject = "d_address_lookup_cl_select"
boolean hscrollbar = true
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

if dwo.name = "b_help" then
	messagebox("Facility field","The Facility field is only available for the Department, Division and Section tables.  When set to a specific facility the record will only show in the corresponding drop down list on the Provider Appointment tab Detail 2 Department records, if the Appointment is connected to that Facility.~rAny lookups left blank or set to all will show fall the time.")
end if
end event

type dw_search from u_dw within w_lookup_maint_cleanup
integer x = 37
integer y = 324
integer width = 3749
integer height = 84
integer taborder = 30
string dataobject = "d_address_lookup_cl_search"
boolean vscrollbar = false
boolean border = false
end type

event itemchanged;call super::itemchanged;long ll_lookup
long ll_find

ll_lookup = long(data)

ll_find = dw_record.find( "lookup_code = " + data,1, dw_record.rowcount())

il_lookup_code = ll_lookup


if ll_find > 0 then
	dw_record.selectrow(0,false)
	dw_record.selectrow(ll_find, true )
	dw_record.scrolltorow(ll_find)
	if is_lookup_type = "A" then
		is_entity_name = dw_record.getitemstring(ll_find, "entity_name")
	else
		is_entity_name = dw_record.getitemstring(ll_find, "description")
	end if
end if

end event

