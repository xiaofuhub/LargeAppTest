$PBExportHeader$n_cst_caqh_import.sru
forward
global type n_cst_caqh_import from nonvisualobject
end type
end forward

global type n_cst_caqh_import from nonvisualobject
end type
global n_cst_caqh_import n_cst_caqh_import

type variables
boolean ib_prov_id
boolean ib_title
Boolean ib_schedule = false //scheduler - alfee 02.25.2010
boolean ib_directory_links
boolean ib_default_value  = false //CAQH Screen defaults - alfee 05.07.2014
boolean ib_approval_flag = false //Added by Appeon long.zhang 03.18.2015 (v15.1 CAQH Import Data Approval)
boolean ib_from_audit = false //Added by Appeon long.zhang 04.01.2015 (v15.1 CAQH Import Data Approval)
boolean ib_caqh_vals_added = false  //maha 03.15.2016
integer ii_parent
integer ii_audit
integer ii_verif
integer ii_new_patient //maha 03.06.2010 for accepting new patients 

long il_prov_id
long il_attest_id
long il_lookup_row
long il_prac 
long il_log_id = 0 //Added by Appeon long.zhang 03.27.2015 (v15.1 CAQH Import Data Approval)

string is_ssn
string is_npi
string is_file
string is_parsed_file
string is_attest_date
string is_last_name
string is_first_name
string is_type
string is_affil 
string is_parent
string is_failed

string is_cur_isg_table//Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)

datawindow idw_basic
datawindow idw_license
datawindow idw_oids
datawindow idw_education
datawindow idw_specialty
datawindow idw_language
datawindow idw_address
datawindow idw_hospital
datawindow idw_insurance
datawindow idw_experience
datawindow idw_workgap
datawindow idw_reference
datawindow idw_attest
datawindow idw_claims
datawindow idw_dea
datawindow idw_ecfmg
datawindow idw_code_lookup
datawindow idw_address_lookup
datawindow idw_log
datawindow idw_log_items //Added by Appeon long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
datawindow idw_appointment
datawindow idw_addr_link
datawindow idw_hosp_link
datawindow idw_spec_link
datawindow idw_audit_trail
datawindow idw_verifs
datawindow idw_training
datawindow idw_cpr
datawindow idw_committees
datawindow idw_mapping
datawindow idw_cur_dw

datastore ids_default_values //CAQH Screen defaults - alfee 05.07.2014
datastore ids_address_lookup
datastore ids_caqh_log_items // =w_caqh_audit.ids_caqh_log_items, Added by Appeon long.zhang 03.31.2015 (v15.1 CAQH Import Data Approval)
n_ds ids_refs
n_ds ids_rules
n_ds ids_questions //updatable
n_ds ids_committees

pfc_cst_nv_data_entry_functions inv_data_entry
n_cst_message inv_message //scheduler - alfee 02.06.2010
n_cst_dm_utils inv_utils //Added by Appeon long.zhang 03.19.2015 (v15.1 CAQH Import Data Approval)

//----Begin Modified -------
//CAQH 2 - alfee 12.18.2009
boolean ib_update = FALSE
datawindow idw_app_audit 
n_ds ids_caqh_log
n_ds ids_caqh_refs 
n_ds ids_data_parsed 
n_ds ids_dw_currow 
n_cst_string inv_string

//integer ii_hosp
//integer ii_lic
//integer ii_lang
//integer ii_exp
//integer ii_ins
//integer ii_gap
//integer ii_edu
//integer ii_spec
//integer ii_ids
//integer ii_ref
//integer ii_clm
//integer ii_att
//integer ii_addr
//integer ii_basic
//integer ii_prog_width
//integer ii_increment
//integer ii_appt
//integer ii_cpr
//integer ii_training
//integer ii_dea
//long il_caqh_id
//string is_matchtype = '0'
//-----End Modified -------



end variables

forward prototypes
public function string of_date_fix (string as_data)
public function string of_parse_first (string as_data)
public function integer of_reset_variables ()
public function integer of_set_dws ()
public function integer of_read_parsed_file ()
public function integer of_progress (integer ai_width, string as_mess)
public function string of_get_addr_lu_value (string as_condition, string as_columnname)
public function integer of_match_prac ()
public function integer of_update_data ()
public function string of_code_lookup_exception (string as_table, string as_value)
public function integer of_create_links (string as_type, long al_rec, long al_facil, long al_prac, integer ai_p, integer ai_a, integer ai_m)
public function string of_data_exception (string as_table, string as_caqh_field, string as_value)
public function string of_get_reference (integer ai_screen, integer ai_row, datawindow adw_data)
public function string of_strip_cpr_type (string as_value)
public function integer of_save ()
public function string of_get_question_id (string as_condition, string as_columnname)
public function string of_get_screen_name (integer ai_screen)
public function string of_strip_lookup_value (string as_lookup_type, string as_field_name, string as_value)
public function integer of_add_log ()
public function integer of_set_appt_defaults (integer ai_p, integer ai_a, integer ai_v, string as_type, string as_affil, string as_parent, boolean ab_prov, boolean ab_title)
public function integer of_update_field_values (string as_caqh_tables[])
public function integer of_set_field_value (string as_table, string as_field, string as_value, boolean ab_get_info, ref string as_isg_info)
public function integer of_get_field_value (string as_caqh_table, string as_caqh_field, string as_caqh_value, boolean ab_caqh_table)
public function boolean of_is_multi_record (string as_table)
public function string of_get_caqh_ref (string as_table, integer ai_ref)
public function integer of_set_currow (string as_isg_table, long al_cur_row)
public function long of_get_currow (string as_isg_table)
public function integer of_set_field_value (string as_table, string as_field, string as_value)
public function integer of_set_field_value (string as_table, string as_field, string as_value, integer ai_idx)
private function long of_build_table (string as_table, string as_table_from, integer ai_idx)
public function string of_set_table (string as_table, string as_table_from)
public function integer of_set_item (string as_type, long al_row, string as_field, string as_value)
public function integer of_set_item (datawindow adw, string as_type, long al_row, string as_field, string as_value)
public function integer of_move_training_records ()
public function integer of_refresh_lu_cache ()
public function long of_get_rec_id ()
public function integer of_app_audit_update (long al_de_recid, long al_prac, long al_screen, string as_ref)
public function integer of_update_data_bk ()
private function long of_build_table (string as_table)
public function integer of_add_row_bk (string as_table)
public function integer of_audit_trail_add (datawindow adw)
public function integer of_import_xml (string as_file, integer ai_record)
public function long of_find_existing_record (string as_isg_table, string as_ref_1, string as_ref_2, integer ai_idx_from)
public function long of_get_id_type (string as_isg_field)
public function datetime of_str2dt (string as_value)
public function string of_get_entity_name (long al_lu_code)
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function integer of_set_sched_flag (boolean ab_flag)
public function integer of_reset_lookups ()
public function datetime of_get_exp_date (integer ai_screen, integer ai_row, datawindow adw_data)
public function integer of_verif_creation (long al_rec, long al_prac, long al_facil, string ls_refer, integer ai_screen, datetime adt_exp_date)
public function integer of_verif_update (long al_rec, long al_prac, long al_facil, string as_refer, integer ai_screen, datetime adt_exp_date)
public function integer of_parse_file (string as_file)
public function integer of_parse_new_format (string as_file, string as_write)
public function integer of_language_dupe_check ()
public function integer of_set_dir_links (integer ai_value)
public function integer of_set_default_values (datawindow adw_current, integer ai_table_id, long al_current_row)
public function long of_get_lookup_code (string as_lookup_type, string as_lookup_name, string as_code)
public subroutine of_set_approval_flag (boolean ab_approval)
public function integer of_upload_log_file ()
public function integer of_update_log_only ()
public function integer of_save_log_only ()
public function string of_get_defaults_vars ()
public function long of_set_defaults_vars (string as_defaults)
public function any of_get_currow_value (string as_isg_table, string as_field)
public function integer of_discard_item (long al_row)
public function long of_get_log_id ()
public subroutine of_set_prac_id (long al_prac_id)
public subroutine of_set_ib_update (boolean ab_update)
public function integer of_read_audit_data ()
public subroutine of_set_from_audit (boolean ab_from_audit)
public function integer of_update_audit_items ()
public function integer of_import_audit_data (datastore ads_log_items, integer ai_num)
public function integer of_set_provider_ids ()
public function integer of_check_active_status (integer al_screen, integer al_row)
public subroutine of_set_prov_id (long al_prov_id)
end prototypes

public function string of_date_fix (string as_data);//called from of_parse file
// formats the dates stripping the time

string ls_return

ls_return = as_data


if   PosA(as_data,"-",1) = 5 and   PosA(as_data,'T',1) = 11 then
	ls_return = MidA(as_data,1,10) //+ " " + mid(as_data,12)
end if

return ls_return
end function

public function string of_parse_first (string as_data);string ls_write
string ls_date
integer p1
integer p2
integer p3
string ls_value

//<Provider ProviderID="937" ProviderAttestID="1901307" AttestDate="2005-03-24T15:29:26" ModelVersion="18" xmlns="urn:GeoAccess.PDE.Provider">
//break the data into separate rows
p1 = PosA(as_data,'ProviderID="',1)
p1 = p1+12
p2 =  PosA(as_data,'"',p1 ) 
ls_value = MidA(as_data,p1 , p2 - p1 )
il_prov_id = long(ls_value)
ls_write += "ProviderID*" + ls_value
ls_write += "~r~n"

p1 = PosA(as_data,'ProviderAttestID="',1)
p1 = p1+19
p2 =  PosA(as_data,'"',p1) 
ls_value =  MidA(as_data,p1, p2 - p1 )
il_attest_id = long(ls_value)
ls_write += "ProviderAttestID*" + ls_value
ls_write += "~r~n"

p1 = PosA(as_data,'AttestDate="',1)
p1 = p1+12
p2 =  PosA(as_data,'"',p1) 
ls_date = MidA(as_data,p1 , p2 - p1 )
ls_date = of_date_fix( ls_date)
is_attest_date = ls_date
ls_write += "AttestDate*" + ls_date

//find the existing provider
//ii_basic++  - caqh 2: commented by alfee 12.18.2009

return ls_write
end function

public function integer of_reset_variables ();//variable values
il_prov_id = 0
il_attest_id = 0
is_ssn = ''
is_npi = ''
is_attest_date = ""

//--Begin Modified by (caqh 2)alfee 12.18.2009---
il_prac = -1
il_lookup_row = 0
is_last_name = ""
is_first_name = ""
is_failed = ""
ib_update = FALSE 

////data row counts 
//ii_hosp = 0
//ii_lic = 0
//ii_lang = 0
//ii_exp = 0
//ii_ins = 0
//ii_gap = 0
//ii_edu = 0
//ii_spec = 0
//ii_ids = 0
//ii_ref = 0
//ii_clm = 0
//ii_att = 0
//ii_addr = 0
//ii_appt = 0
//ii_cpr = 0
//ii_training = 0
//--End Modified ----------------------------

il_log_id = 0 //Added by Appeon long.zhang 03.27.2015 (v15.1 CAQH Import Data Approval)

return 1
end function

public function integer of_set_dws ();
idw_basic =  w_caqh_xml_read.dw_basic
idw_license =  w_caqh_xml_read.dw_license
idw_oids =  w_caqh_xml_read.dw_otherids
idw_specialty =  w_caqh_xml_read.dw_specialty
idw_language =  w_caqh_xml_read.dw_language
idw_address =  w_caqh_xml_read.dw_address
idw_hospital =  w_caqh_xml_read.dw_hospital
idw_insurance =  w_caqh_xml_read.dw_insurance
idw_experience =  w_caqh_xml_read.dw_experience
idw_workgap =  w_caqh_xml_read.dw_workgap
idw_reference =  w_caqh_xml_read.dw_reference
idw_attest =  w_caqh_xml_read.dw_attest
idw_claims =  w_caqh_xml_read.dw_claims
idw_education =  w_caqh_xml_read.dw_education
idw_dea =  w_caqh_xml_read.dw_dea
idw_ecfmg =  w_caqh_xml_read.dw_ecfmg
idw_mapping =  w_caqh_xml_read.dw_map_fields
idw_code_lookup = w_caqh_xml_read.dw_code_lu
idw_address_lookup = w_caqh_xml_read.dw_address_lu
idw_log = w_caqh_xml_read.dw_log
idw_log_items = w_caqh_xml_read.dw_log_items
idw_appointment = w_caqh_xml_read.dw_appointment
idw_addr_link= w_caqh_xml_read.dw_addr_link
idw_hosp_link = w_caqh_xml_read.dw_hosp_link
idw_spec_link = w_caqh_xml_read.dw_spec_link
idw_audit_trail = w_caqh_xml_read.dw_audit_trail
idw_verifs = w_caqh_xml_read.dw_verifs
idw_cpr = w_caqh_xml_read.dw_cpr
idw_training = w_caqh_xml_read.dw_training
idw_committees = w_caqh_xml_read.dw_committees
idw_app_audit = w_caqh_xml_read.dw_app_audit //(caqh 2)alfee 12.18.2009
 
idw_basic.settransobject(sqlca)
idw_license.settransobject(sqlca)
idw_oids.settransobject(sqlca)
idw_specialty.settransobject(sqlca)
idw_language.settransobject(sqlca)
idw_address.settransobject(sqlca)
idw_hospital.settransobject(sqlca)
idw_insurance.settransobject(sqlca)
idw_experience.settransobject(sqlca)
idw_workgap.settransobject(sqlca)
idw_reference.settransobject(sqlca)
idw_attest.settransobject(sqlca)
idw_claims.settransobject(sqlca)
idw_education.settransobject(sqlca)
idw_dea.settransobject(sqlca)
idw_ecfmg.settransobject(sqlca)
idw_code_lookup.settransobject(sqlca)
idw_address_lookup.settransobject(sqlca)
idw_log.settransobject(sqlca)
idw_log_items.settransobject(sqlca) //Added by Appeon long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
idw_appointment.settransobject(sqlca)
idw_addr_link.settransobject(sqlca)
idw_hosp_link.settransobject(sqlca)
idw_spec_link.settransobject(sqlca)
idw_audit_trail.settransobject(sqlca)
idw_verifs.settransobject(sqlca)
idw_cpr.settransobject(sqlca)
idw_training.settransobject(sqlca)
idw_committees.settransobject(sqlca)
idw_app_audit.settransobject(sqlca) //(caqh 2)alfee 12.18.2009

idw_basic.reset()
idw_license.reset()
idw_oids.reset()
idw_specialty.reset()
idw_language.reset()
idw_address.reset()
idw_hospital.reset()
idw_insurance.reset()
idw_experience.reset()
idw_workgap.reset()
idw_reference.reset()
idw_attest.reset()
idw_claims.reset()
idw_education.reset()
idw_dea.reset()
idw_ecfmg.reset()
//idw_code_lookup.reset()//Start Code Change ----03.15.2010 #V10 maha moved to of_reset_lookup function
//idw_address_lookup.reset()
idw_log.reset()
idw_log_items.reset() //Added by Appeon long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
idw_appointment.reset()
idw_addr_link.reset()
idw_hosp_link.reset()
idw_spec_link.reset()
idw_audit_trail.reset()
idw_verifs.reset()
idw_cpr.reset()
idw_training.reset()
idw_committees.reset()
idw_app_audit.reset() //(caqh 2)alfee 12.18.2009

//Retrieve for the practitioner found - (caqh 2)alfee 12.18.2009
IF ib_update THEN 
	gnv_appeondb.of_startqueue() 	
	idw_basic.retrieve(il_prac)
	idw_license.retrieve(il_prac)
	idw_oids.retrieve(il_prac)
	idw_specialty.retrieve(il_prac)
	idw_language.retrieve(il_prac)
	idw_address.retrieve(il_prac)
	idw_hospital.retrieve(il_prac)
	idw_insurance.retrieve(il_prac)
	idw_experience.retrieve(il_prac)
	idw_workgap.retrieve(il_prac)
	idw_reference.retrieve(il_prac)
	idw_attest.retrieve(il_prac, ii_parent) //facility related
	idw_claims.retrieve(il_prac)
	idw_education.retrieve(il_prac)
	idw_dea.retrieve(il_prac)
	idw_ecfmg.retrieve(il_prac)
	//idw_code_lookup.retrieve(il_prac)
	//idw_address_lookup.retrieve(il_prac)
	//idw_log.retrieve(string(il_prov_id)) 
	idw_appointment.retrieve(il_prac, ii_parent) //facility related
	//idw_addr_link.retrieve(il_prac)
	//idw_hosp_link.retrieve(il_prac)
	//idw_spec_link.retrieve(il_prac)
	//idw_audit_trail.retrieve(il_prac)
	idw_verifs.retrieve(1, il_prac, ii_parent) //facility related
	idw_cpr.retrieve(il_prac)
	idw_training.retrieve(il_prac)
	//idw_committees.retrieve(il_prac) //don't retrieve
	idw_app_audit.retrieve(il_prac)
	gnv_appeondb.of_commitqueue( )
END IF

return 1
 
 
 
end function

public function integer of_read_parsed_file ();//parse the file 
//Reconstructed for CAQH 2 - alfee 12.18.2009

integer li_read
long i, ptable, pstar, ll_cnt
string ls_read, ls_field, ls_value, ls_table, ls_flag, ls_temp
boolean lb_table_line = false 

//Parse the file
li_read = FileOpen ( is_parsed_file)

for i = 1 to 50000 //this is an arbitrary number to assure all the lines have been read
	if FileRead ( li_read, ls_read) = -100 then exit //end of file
	
	pstar = PosA(ls_read, "*" ,1)
	ptable = PosA(ls_read, "#%#%" ,1)  //table lines are identifed with these characters 

	if ptable > 0 then //if a table line
		ls_table = MidA(ls_read,pstar + 2,PosA(ls_read," ID",1)  - pstar - 2)		
		if not ib_update then 
			//build dw for a new practitioner
			of_build_table(ls_table)
		else
			//Set caqh table flag for an existing practitioner
			lb_table_line = true
		end if
	else //not a table line
		ls_field = MidA(ls_read,1,pstar  - 1)
		ls_value = MidA(ls_read,pstar + 1)	
		//If Upper(ls_table) = 'EDUCATION' and lower(ls_field) = 'hospitaldepartmentname'   then debugbreak()  //maha 02.21.2017 - for testing
		if not ib_update then 
			//set field data for a new practitioner
			of_set_field_value(ls_table, ls_field, ls_value)
		else
			//get field data into DS for an existing practitioner
			if of_get_field_value(ls_table, ls_field, ls_value, lb_table_line) = 1 then
				lb_table_line = false
			end if
		end if
	end if	
next

FileClose(li_read)

//Set tables and fields for an existing practitioner
if ib_update then
	if gi_test_mode = 1 then
		ids_data_parsed.SaveAs(gs_temp_path + "caqh\ids_data_parsed.xls", Excel8!,true)
	end if
	ll_cnt = ids_data_parsed.RowCount()
	for i = 1 to ll_cnt
		ls_table = ids_data_parsed.GetItemString(i, 'caqh_table')
		ls_field = ids_data_parsed.GetItemString(i, 'caqh_field')
		ls_value = ids_data_parsed.GetItemString(i, 'caqh_value')
		ls_flag = ids_data_parsed.GetItemString(i, 'caqh_table_flag')
		if Upper(ls_flag) = 'Y' then		
			//build dw for an existing practitioner
			of_build_table(ls_table, 'CAQH', i)
		end if
		//set field data for an existing practitioner 
		of_set_field_value(ls_table, ls_field, ls_value, i)
	next
end if

//move training records to Training dw //moved from of_update_data() by Appeon long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
of_move_training_records()

return 1

////open the parsed file 
//li_read = FileOpen ( is_parsed_file)
//
//for i = 1 to 50000 //this is an arbitrary number to assure all the lines have been read
//	if FileRead ( li_read, ls_read) = -100 then exit //end of file
//	
//	pstar = pos(ls_read, "*" ,1)
//	ptable = pos(ls_read, "#%#%" ,1)  //table lines are identifed with these characters 
//
//	if ptable > 0 then //if a table line
//		ls_table = mid(ls_read,pstar + 2,pos(ls_read," ID",1)  - pstar - 2)
//		of_build_tables( ls_table)
//		continue
//	else //not a table line set the data field
//		ls_field = mid(ls_read,1,pstar  - 1)
//		ls_value = mid(ls_read,pstar + 1)
//		of_set_field_value( ls_table, ls_field, ls_value )
//		//set values
//	end if	
//next
//	
//FileClose(li_read)
//return 1


end function

public function integer of_progress (integer ai_width, string as_mess);integer w
if isvalid(w_caqh_import_progress) then
	if ai_width = 2000 then
		w = 2000
	else
		w = w_caqh_import_progress.r_progress.width + ai_width
		if w > 1800 then w = 100
	end if
	w_caqh_import_progress.r_progress.width = w
	
	if LenA(as_mess) > 0 then
		w_caqh_import_progress.st_message.text = as_mess
	end if
end if

return 1
end function

public function string of_get_addr_lu_value (string as_condition, string as_columnname);//Start Code Change ----04.24.2009 #V92 maha - copied from of_get_item code

long ll_findrow
string ls_value
string ls_condition

ls_condition = of_strip_char("'", as_condition, "")  //Start Code Change ----06.03.2009 #V92 maha - strip quote
//if ls_condition <> as_condition then
//	messagebox("of_get_addr_lu_value",ls_condition + " -|- " + as_condition)
//end if
ll_findrow = ids_address_lookup.find(as_condition , 1,  ids_address_lookup.rowcount())
If ll_findrow = 0 Then 
	Return ""
elseif ll_findrow < 0 then  //Start Code Change ----06.03.2009 #V92 maha - trap added
	//messagebox("Find failed in of_get_addr_lu_value",ls_condition)
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Find failed in of_get_addr_lu_value",ls_condition,true)
	return ""
end if

Choose Case Lower(as_columnname)
	Case "lookup_name","code","type","custom_1","custom_2","custom_3","custom_4","custom_5","custom_6","ic_c","large_description_1","large_description_2"
			ls_value = ids_address_lookup.getitemstring(ll_findrow,  as_columnname)	
	Case "street1","street2","city","state","entity_name"
			ls_value = ids_address_lookup.getitemstring(ll_findrow,  as_columnname)
	case "lookup_code","caqh_code","zip","ic_n","money_1","money_2","integer_1","integer_2","integer_3","integer_4","integer_5","integer_6","integer_7","integer_8"
			ls_value = String(ids_address_lookup.getitemnumber( ll_findrow, as_columnname))
	case "modify_date","datetime_1","datetime_2"
			ls_value = string(ids_address_lookup.getitemdatetime( ll_findrow, as_columnname))
End Choose

return ls_value
end function

public function integer of_match_prac ();//CAQH 2: Reconstructed by alfee 12.18.2009

Integer li_return, li_res, cnt
Long ll_cnt, i,ll_prac_found
String ls_last, ls_first, ls_attest_date

ib_caqh_vals_added = false  //Start Code Change ----03.15.2016 #V15 maha

//check match with provider id in caqh log
If ib_approval_flag Then //change dataobject, Added by Appeon long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
	ids_caqh_log.dataobject = "d_caqh_log_noprac" 
	ids_caqh_log.settransobject(sqlca)
End If
ll_cnt = ids_caqh_log.retrieve(string(il_prov_id))
IF ll_cnt > 0 THEN 
	//if match found in caqh log and pd_basic table
	ls_attest_date = ids_caqh_log.getitemstring(1, "attest_date")

	//skip if the attest date is not later than that in the log 
	IF IsDate(ls_attest_date) AND IsDate(is_attest_date) THEN //Alfee 03.22.2010
		IF Date(ls_attest_date) >= Date(is_attest_date) THEN RETURN 0
	ELSE
		IF ls_attest_date >= is_attest_date THEN RETURN 0 //yyyy-mm-dd				
	END IF

END IF

//check match with SSN/NPI in pd_basic table
SELECT Count(*) INTO :ll_cnt FROM pd_basic WHERE ssn = :is_ssn OR npi_number = :is_npi;
IF ll_cnt > 1 THEN
	//skip if 2 or more matching providers are found
	//MessageBox("Verify import", "There are " + String(ll_cnt) + " practitioners found in the system with a matching NPI or SSN. ~nThe file '" + is_file + "' is skipped to import.")
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Verify import", "There are " + String(ll_cnt) + " practitioners found in the system with a matching NPI or SSN. ~nThe file '" + is_file + "' is skipped to import.",true)
	li_return = 0
ELSEIF ll_cnt = 1 THEN
	//update if a matching provider is found
	SELECT last_name, first_name, prac_id INTO :ls_last, :ls_first, :il_prac FROM pd_basic WHERE ssn = :is_ssn or npi_number = :is_npi;
	
	IF upper(ls_last) = upper(is_last_name) AND upper(ls_first) = upper(is_first_name) THEN
		//update if ssn/npi and first name and last name match
		ib_update = TRUE
		li_return = 1
	ELSE 
		//if ssn/npi match but no name match ask to continue import
		//li_res = messagebox("Verify import", "Practitioner '" + ls_first + " " + ls_last  + "' was found in the system with a matching NPI or SSN.  ~nThe name in the file '" + is_file + "' is '" + is_first_name + " " + is_last_name + "'.  ~n~nDo you wish to continue to import this file?",Question!,yesno!,2)
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		//inv_message.of_MessageBox("Verify import", "Practitioner '" + ls_first + " " + ls_last  + "' was found in the system with a matching NPI or SSN.  ~nThe name in the file '" + is_file + "' is '" + is_first_name + " " + is_last_name + "'.  ~n~nDo you wish to continue to import this file?",Question!,yesno!,2,true)
		li_res = inv_message.of_MessageBox("Verify import", "Practitioner '" + ls_first + " " + ls_last  + "' was found in the system with a matching NPI or SSN.  ~nThe name in the file '" + is_file + "' is '" + is_first_name + " " + is_last_name + "'.  ~n~nDo you wish to continue to import this file?",Question!,yesno!,2,true) //add li_res back, by Appeon long.zhang 06.09.2015 
		if li_res = 2 then //if no treat as found
			li_return = 0
		else 					//if yes continue import to update
			ib_update = TRUE			
			li_return  = 1
		end if
	END IF
ELSE
	//insert if no matching provider is found
	il_prac = gnv_app.of_get_id( "PRAC_ID" )
	li_return = 1
END IF
	
RETURN li_return


//integer li_write
//integer li_poscount
//integer li_pos_end
//integer ic
//integer li_return
//integer li_res
//integer cnt
//long i
//long ll_prac_found
//string ls_match_field
//string ls_end
//string ls_id[]
//string ls_last
//string ls_first
//datetime ldt_now
//
//debugbreak()
//ls_id[1] = string(il_prov_id )
//i = idw_log.retrieve(ls_id[])
//
//if i > 0 then
////if match found in log file data, skip
////Start Code Change ----08.17.2009 #V92 maha
//	ll_prac_found  = idw_log.getitemnumber(1,"prac_id")
//	select count(prac_id) into :cnt from pd_basic where prac_id = :ll_prac_found;
//	if cnt > 0 then
//		li_return = 0
//	else //prac record may have been deleted
//		of_add_log( )
//		li_return = 1 //Start Code Change ----09.28.2009 #V92 maha - added return value
//	end if
//	//End Code Change---08.17.2009
//	//when update functionality is added this will used to create a new log record
//	//and identify the prac_id
//else //create log record
////Start Code Change ----08.03.2009 #V92 maha	 - added check for ssn and npi existing and moved log create to function
//	//check for existing practitioner by ssn and npi who may not have a caqh log record
//	//debugbreak()
//	select last_name, first_name, prac_id into :ls_last, :ls_first, :ll_prac_found from pd_basic where ssn = :is_ssn or npi_number = :is_npi;
//	if ll_prac_found > 0 then  //if found and first and last name match treat as log found
//		if upper(ls_last) = upper(is_last_name) and upper(ls_first) = upper(is_first_name) then
//			li_return = 0  
//		else //if ssn/npi match but no name match ask to continue import
//			li_res = messagebox("Verify import", "Practitioner " + ls_first + "  " + ls_last  + " was found in the system with a matching NPI or SSN.  ~nThe name in the file is " + is_first_name + " " + is_last_name + ".  ~n~nDo you wish to continue with the import?",Question!,yesno!,2)
//			if li_res = 2 then //if no treat as found
//				li_return = 0
//			else //if yes continue import
//				li_return  = 1
//				of_add_log( )
//			end if
//		end if
//	else
//		li_return  = 1
//		of_add_log( )
//	end if
////End Code Change---08.03.2009	
//end if

//return li_return


end function

public function integer of_update_data ();//caqh 2: Reconstructed by alfee 12.18.2009

long ll_rec, ll_rec_upd
long i
long ic
long t
long e
long ll_fac
long ll_app_stat_id
long ll_ttype
long ll_tentity
long ll_title
integer c
integer res
integer li_find
integer rc
integer nr
integer li_addr_type
string ls_type
string ls_reference
string ls_test
string ls_err_table  //maha 12.02.2015
integer li_linkp
integer li_linka
integer li_linkm
integer li_screen
integer li_table
boolean lb_verify
datetime ldt_exp_date //alfee 10.08.2010
datawindow ldw_audit  //used as argument but not really exists
dwitemstatus l_status 

//Start Code Change ----11.17.2009 #V92 maha
ls_test = idw_basic.getitemstring(1,"last_name")
if isnull(ls_test) or ls_test = "" then
	return -1
end if
//End Code Change---11.17.2009

if ib_title then		
	ll_title =  long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Title' and code = 'Dr.'"))
//	if gi_test_mode = 1 then messagebox("Title - Dr. value",ll_title)
//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	if gi_test_mode = 1 then inv_message.of_MessageBox("Title - Dr. value",string(ll_title),true)
	if ll_title = 0 then setnull(ll_title)
end if

//get the rec id
ll_rec = of_get_rec_id()

////move training records to Training dw //moved to of_read_parsed_file() by Appeon long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
//of_move_training_records()

////Start Code Change ----10.25.2010 #V10 maha //don't need to check it any more, comment by  Appeon long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
//of_language_dupe_check()

//set data for each table 
for t = 1 to 18
	choose case t  
		case 1
			c = idw_basic.rowcount()
			idw_cur_dw = idw_basic
			ls_type = "N"
			li_screen =1	
			li_table = 25
			ll_fac = 0
			ls_err_table = "Basic Information"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 2
			c = idw_appointment.rowcount()
			idw_cur_dw = idw_appointment
			ls_type = "N"
			li_screen = 43
			li_table = 43
			ll_fac = ii_parent
			ls_err_table = "Appointment"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 3
			c = idw_license.rowcount()
			idw_cur_dw = idw_license
			ls_type = "N"
			li_screen =4	
			li_table = 22
			ll_fac = 0	
			ls_err_table = "License"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 4
			c = idw_oids.rowcount()
			idw_cur_dw = idw_oids
			ls_type = "N"
			li_screen = 23	
			li_table = 13
			ll_fac = 0
			ls_err_table = "Other Ids"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 5
			c = idw_education.rowcount()
			idw_cur_dw = idw_education
			ls_type = "N"
			li_screen = 6		
			li_table = 8
			ll_fac = 0
			ls_err_table = "Education"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 6	
			c = idw_specialty.rowcount()
			idw_cur_dw = idw_specialty
			ls_type = "S"
			li_screen =19		
			li_table = 2
			ll_fac = 0		
			ls_err_table = "Specialty"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 7
			c = idw_language.rowcount()
			idw_cur_dw = idw_language
			ls_type = "N"
			li_screen =25
			li_table = 21
			ll_fac = 0
			ls_err_table = "Language"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 8
			c = idw_address.rowcount()
			idw_cur_dw = idw_address
			ls_type = "A"
			li_screen =2			
			li_table = 20
			ll_fac = 0	
			ls_err_table = "Address"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 9
			c = idw_hospital.rowcount()
			idw_cur_dw = idw_hospital
			ls_type = "H"
			li_screen = 10			
			li_table = 9
			ll_fac = 0
			ls_err_table = "Hospital"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 10
			c = idw_insurance.rowcount()
			idw_cur_dw = idw_insurance
			ls_type = "N"
			li_screen =15
			li_table = 10
			ll_fac = 0
			ls_err_table = "Insurance"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 11
			c = idw_experience.rowcount()
			idw_cur_dw = idw_experience
			ls_type = "N"
			li_screen = 12
			li_table = 14
			ll_fac = 0
			ls_err_table = "Professional Experience"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 12
			c = idw_workgap.rowcount()
			idw_cur_dw = idw_workgap
			ls_type = "N"
			li_screen = 55
			li_table = 55
			ll_fac = 0
			ls_err_table = "Work Gap"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 13
			c = idw_reference.rowcount()
			idw_cur_dw = idw_reference
			ls_type = "N"
			li_screen = 13
			li_table = 23
			ll_fac = 0
			ls_err_table = "Reference"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 14
			c = idw_attest.rowcount()
			idw_cur_dw = idw_attest
			ls_type = "N"
			li_screen = 65
			li_table = 65
			ll_fac = ii_parent
			ls_err_table = "Attestations"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 15
			c = idw_claims.rowcount()
			idw_cur_dw = idw_claims
			ls_type = "N"
			li_screen =16		
			li_table = 24
			ll_fac = 0
			ls_err_table = "Claims"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 16
			c = idw_dea.rowcount()
			idw_cur_dw = idw_dea
			ls_type = "N"
			li_screen = 5
			li_table = 6
			ll_fac = 0
			ls_err_table = "DEA"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 17
			c = idw_ecfmg.rowcount()
			idw_cur_dw = idw_ecfmg
			ls_type = "N"
			li_screen = 20
			li_table = 7
			ll_fac = 0			
			ls_err_table = "ECFMG"	 //Start Code Change ----12.02.2015 #V15 maha- added
		case 18 
			c = idw_training.rowcount()
			idw_cur_dw = idw_training
			ls_type = "N"
			li_screen = 7
			li_table = 19
			ll_fac = 0
			ls_err_table = "Training"   //Start Code Change ----12.02.2015 #V15 maha- added
	end choose
	
	//check for verif creation
	ids_rules.setfilter("screen_id = " + string(li_screen))
	ids_rules.filter()
	
	lb_verify = False
	if ids_rules.rowcount() > 0 then
		if ids_rules.getitemstring(1,"verify_data") = "I" or ids_rules.getitemstring(1,"verify_data") = "B" and li_screen <> 1 then	
			lb_verify = true
		end if
	end if
	
	//Filter default values on table_id - (CAQH Screen defaults) alfee 05.07.2014
	IF ib_default_value THEN
		ids_default_values.SetFilter( 'sys_fields_table_id = ' + String(li_table) +  ' And Len(Trim(sys_fields_default_value)) > 0')
		ids_default_values.Filter( )
	END IF
	
	//set data for each new or modified record
	for i = 1 to c 		
		ls_reference = of_get_reference(li_screen, i, idw_cur_dw)
		
		l_status = idw_cur_dw.getitemstatus(i, 0, primary!)
	//Start Code Change ----07.12.2012 #V12 maha - moved to allow update on existing records.
		if t = 1 then
			if ib_title then idw_cur_dw.setitem(i,"title",ll_title)
			if ib_prov_id then idw_cur_dw.setitem(i,"provider_id", string(il_prov_id))
		end if
		//for new record 
		if l_status = newmodified! or (l_status = new! and t = 2) then 
			//set rec and prac ids
			idw_cur_dw.setitem(i,"rec_id",ll_rec)
			idw_cur_dw.setitem(i,"prac_id",il_prac)

			//set other data
			if t = 1 then 
				//set basic 
				//if ib_title then idw_cur_dw.setitem(i,"title",ll_title)
				//if ib_prov_id then idw_cur_dw.setitem(i,"provider_id", string(il_prov_id))
	//End Code Change ----07.12.2012	
			elseif t = 2 then 
				//set appointment 
				ll_app_stat_id = ll_rec 						
				idw_cur_dw.setitem(i,"parent_facility_id",ii_parent  )
				idw_cur_dw.setitem(i,"application_audit_facility",ii_audit )
				idw_cur_dw.setitem(i,"verifying_facility",ii_verif)
				idw_cur_dw.setitem(i,"seq_no",1)
				idw_cur_dw.setitem(i,"affiliation_status",is_affil )
				idw_cur_dw.setitem(i,"apptmnt_type",is_type )
				idw_cur_dw.setitem(i,"active_status",4)
				rc = ids_committees.retrieve(ii_parent)
				//rc = ids_committees.retrieve(ii_parent,il_prac)				
				for e = 1 to rc
					//create committee records
					nr = idw_committees.insertrow(0)
					idw_committees.setitem(nr,"rec_id",ll_app_stat_id)
					idw_committees.setitem(nr,"prac_id",il_prac)
					idw_committees.setitem(nr,"seq_no",nr)
					idw_committees.setitem(nr,"committee_id",ids_committees.getitemnumber(e, "committee_id") )
					idw_committees.setitem(nr,"facility_id",ii_parent)
					idw_committees.setitem(nr,"active_status",4)
				next
			elseif t = 14 then 				
				//attest quest set appointment			
				idw_cur_dw.setitem(i,"appt_stat_id",ll_app_stat_id )
				idw_cur_dw.setitem(i,"active_status", 1)
				idw_cur_dw.setitem(i,"facility_id",ii_parent  )
				
				//ll_app_stat_id maybe 0 when using Acceptance. Added by Appeon long.zhang 04.03.2015 (v15.1 CAQH Import Data Approval)
				If idw_appointment.RowCount() = 0 Then //set active_status to 0 when no appointment record. Added by Appeon long.zhang 08.15.2016 (Bug id 5287 - CAQH Import not brinng Attest Questions Answers in)
					idw_cur_dw.setitem(i,"active_status", 0)
				Else
					If ib_from_audit and ll_app_stat_id = 0 Then
						idw_cur_dw.setitem(i,"appt_stat_id",idw_appointment.getitemnumber(1, 'rec_id') )
					End If
				End If
			elseif t = 8  then 
				//set address
				idw_cur_dw.setitem(i,"active_status", 1)
			end if
			
			//Set default values for current new row - (CAQH Screen defaults) alfee 05.07.2014
			IF ib_default_value THEN
				of_set_default_values (idw_cur_dw, li_table, i )
			END IF
			
			//create links as needed
			choose case ls_type
				case "N" 	//skip
				case "A"
					//Start Code Change ----11.01.2010 #V10 maha - change address link setting
					li_addr_type = idw_cur_dw.getitemnumber(i,"mailing_address")
					debugbreak()
					choose case li_addr_type
						case 1
							li_linkp= 1
							li_linka = 0
							li_linkm = 1	
						case 2
							li_linkp= 0
							li_linka = 1
							li_linkm = 0
						case 3
							li_linkp= 0
							li_linka = 0
							li_linkm = 0		
					end  choose
//					choose case i //set the first to primary
//							
//						case 1
//							li_linkp= 1
//							li_linka = 0
//							li_linkm = 1
//						case else
//							li_linkp= 0
//							li_linka = 1
//							li_linkm = 0
//					end choose	
			//End Code Change ----11.01.2010
					of_create_links ("A",ll_rec,ii_parent , il_prac, li_linkp,li_linka, li_linkm) 
				case "H"
					choose case i //set the first to primary
						case 1
							li_linkp= 581
						case else
							li_linkp= 582
					end choose
					of_create_links ("H",ll_rec,ii_parent , il_prac, li_linkp,0, 0) 
				case "S"
					li_linkp= 581
					of_create_links ("S",ll_rec,ii_parent , il_prac, li_linkp,0, 0) 
			end choose
		
			//create verification
			if lb_verify then 
				//----Begin Modified by alfee 10.08.2010 -----------------
				if of_check_active_status(li_screen, i) = 1 then   //Start Code Change ----08.07.2015 #V15 maha - check active status on record 
					ldt_exp_date = of_get_exp_date(li_screen, i, idw_cur_dw)				
					of_verif_creation(ll_rec, il_prac, ii_verif, ls_reference, li_screen, ldt_exp_date)
				end if
				//of_verif_creation(ll_rec, il_prac, ii_verif, ls_reference, li_screen)
				//----End Modified ---------------------------------------
			end if
			
			ll_rec++	
		//for modified record	
		elseif l_status = datamodified! then
			//get current rec_id
			if idw_cur_dw.describe("rec_id.ColType") = "!" then continue
			ll_rec_upd = idw_cur_dw.getitemnumber(i, 'rec_id')				
			//update verification
			if lb_verify then 
				//----Begin Modified by alfee 10.08.2010 -----------------
				ldt_exp_date = of_get_exp_date(li_screen, i, idw_cur_dw)								
				of_verif_update(ll_rec_upd, il_prac, ii_verif, ls_reference, li_screen, ldt_exp_date)
				//of_verif_update(ll_rec_upd, il_prac, ii_verif, ls_reference, li_screen)				
				//----End Modified ---------------------------------------
			end if
			//update app audit
			of_app_audit_update(ll_rec_upd, il_prac, li_screen, ls_reference)			
		end if			
	next
		
	//create audit trail
	of_audit_trail_add( idw_cur_dw )	
	//of_audit_trail_add( ll_rec, il_prac, li_table, ls_reference, ll_fac)			
next

//add caqh log
If not ib_from_audit Then
	of_add_log()
Else //from w_caqh_audit, Added by Appeon long.zhang 04.01.2015 (v15.1 CAQH Import Data Approval)
	of_update_audit_items()
End If

ids_rules.setfilter("")
ids_rules.filter()

of_progress( 1200, "Saving Data")	

//save the data
res = of_save()
//messagebox("of_update_data Save",res)
if res = 1 then
	commit using sqlca;
	//create app audit (for new records)
	if ll_app_stat_id > 0 then
		inv_data_entry.of_app_audit_items_add( ii_parent, il_prac, ll_app_stat_id, ii_audit, "Reapp", ldw_audit, "I" )
	end if	

	//set last modify date in pd_basic		
	inv_data_entry.of_set_mod_date(il_prac) 
	
	//refresh cache of lookup data - for next import
	of_refresh_lu_cache()
else //-1
	rollback using sqlca;
	//messagebox("of_update_data","Data save failure for " + is_failed )
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	//inv_message.of_MessageBox("of_update_data","Data save failure for " + is_failed,true )
	inv_message.of_MessageBox("of_update_data","Data save failure for " + ls_err_table + " screen",true )  //Start Code Change ----12.02.2015 #V15 maha
end if

//reset the datastore for audit trail
inv_data_entry.ids_sys_audit.reset()

//turn on autocommit either way
sqlca.autocommit = true

return res
end function

public function string of_code_lookup_exception (string as_table, string as_value);//Start Code Change ----06.02.2009 #V92 maha - added for lookup exception
string ls_return

choose case as_table
	case "YES/NO"
		if as_value = "1" then 
			ls_return = "581"
		elseif as_value = "0" then 
			ls_return = "582"
		else
			ls_return = as_value
		end if
	case "QUESTION ANSWERS"
		if as_value = "1" then 
			ls_return = "-102"
		elseif as_value = "0" then 
			ls_return = "-103"
		else
			ls_return = as_value
		end if
		
end choose

return ls_return
end function

public function integer of_create_links (string as_type, long al_rec, long al_facil, long al_prac, integer ai_p, integer ai_a, integer ai_m);integer nr
integer li_home = 0

//Start Code Change ----09.15.2010 #V10 maha - mod for home address


Choose case as_type
	case "A"
		nr = idw_addr_link.insertrow(0)
		if ai_p = 0 and ai_a = 0 then li_home = 1  //Start Code Change ----09.15.2010 #V10 maha - mod for home address
		idw_addr_link.setitem(nr,"address_id",al_rec)
		idw_addr_link.setitem(nr,"facility_id",al_facil)
		idw_addr_link.setitem(nr,"prac_id",al_prac)
		idw_addr_link.setitem(nr,"primary_office",ai_p)
		idw_addr_link.setitem(nr,"additional_office",ai_a)
		idw_addr_link.setitem(nr,"mailing",ai_m)
		idw_addr_link.setitem(nr,"billing",0)
		idw_addr_link.setitem(nr,"home_address",li_home)  //Start Code Change ----09.15.2010 #V10 maha - mod for home address
		idw_addr_link.setitem(nr,"exp_letters",ai_p)
		if li_home = 0 then  //Start Code Change ----09.15.2010 #V10 maha - mod for home address
			//Start Code Change ----12.03.2010 #V10 maha - mod for directory set
			if ib_directory_links then   
				idw_addr_link.setitem(nr,"include_in_directory",1)
			else
				idw_addr_link.setitem(nr,"include_in_directory",0)
			end if
			//End Code Change ----12.03.2010 #V10
		else
			idw_addr_link.setitem(nr,"include_in_directory",0)
		end if
	case "H"
		nr = idw_hosp_link.insertrow(0)
		idw_hosp_link.setitem(nr,"hosp_affil_id",al_rec)
		idw_hosp_link.setitem(nr,"facility_id",al_facil)
		idw_hosp_link.setitem(nr,"prac_id",al_prac)
		idw_hosp_link.setitem(nr,"primary_hosp",ai_p)
	case "S"
		nr = idw_spec_link.insertrow(0)
		idw_spec_link.setitem(nr,"specialty_id",al_rec)
		idw_spec_link.setitem(nr,"facility_id",al_facil)
		idw_spec_link.setitem(nr,"prac_id",al_prac)
		idw_spec_link.setitem(nr,"practicing",ai_p)
end choose

return 1
end function

public function string of_data_exception (string as_table, string as_caqh_field, string as_value);string ls_return

ls_return = as_value
//NOTE: ANY TABLE OF FIELD NAME WILL BE PASSED IN UPPER CASE

choose case as_table
	case "INSURANCE" ////Start Code Change ----08.19.2009 #V92 maha - set to upper case
		choose case as_caqh_field
			case "INSURANCETYPEDESCRIPTION"
				choose case as_value
					case "Current Malpractice"
						ls_return = "1"
					case "Previous Malpractice"
						ls_return = "0"
				end choose
		end choose
end choose

return ls_return
	
end function

public function string of_get_reference (integer ai_screen, integer ai_row, datawindow adw_data);string ls_reference
string ls_r1
string ls_r2
string ls_ref_1
string ls_ref_2
string ls_ref_3
string ls_type1
string ls_type2
string ls_type3
string ls_find
string ls_screen  //03.26.2008  maha 
string ls_value
string ls_cond
string ls_lookup_type
string ls_lu_field
string ls_lu_table
integer li_mess
integer li_retval
integer li_found
integer cnt
integer ccnt
integer li_find
long i
datawindowchild dwchild

cnt = adw_data.rowcount()

//Start Code Change ----07.24.2009 #V92 maha - code rearranged
choose case ai_screen
	case 1  //basic
		ls_ref_1 = "last_name"
		ls_type1 = "C"
		ls_ref_2 = "first_name"
		ls_type2 = "C"
		ls_ref_3 = ""
		ls_type3 = ""
	case 2 //address
		ls_ref_1 = "street"
		ls_type1 = "C"
		ls_ref_2 = "city"
		ls_type2 = "C"
		ls_ref_3 = ""
		ls_type3 = ""
	case 25 //language
		ls_ref_1 = "foreign_language"
		ls_type1 = "N"
		ls_ref_2 = ""
		ls_type2 = ""
		ls_ref_3 = ""
		ls_type3 = ""
	case 43 //appointment
		return is_parent
	case 65 //attewst quest ??
		return "Attest quest added"
	case else
		li_find = ids_refs.find("screen_id = " + string(ai_screen ), 1 ,ids_refs.rowcount() )
		//Start Code Change ----07.20.2009 #V92 maha - added trap
		if li_find < 1 then 
			//messagebox("of_get_reference","No reference field records for screen id =" + string(ai_screen))
			return of_get_screen_name( ai_screen)
		end if
		//End Code Change---07.20.2009
	
end choose


choose case ai_screen
	case 1,2,25,43,65
		// exceptions
	case else
		ls_ref_1 = ids_refs.GetItemString( li_find, "ref_field_1")
		ls_ref_2 = ids_refs.GetItemString( li_find, "ref_field_2")
		ls_ref_3 = ids_refs.GetItemString( li_find, "ref_field_3")
		ls_screen = ids_refs.GetItemString( li_find, "screen_alias") //Start Code Change ----03.26.2008 #V8 maha 
		
		ls_type1 = ids_refs.GetItemString( li_find, "ref_1_type")//maha102501
		ls_type2 = ids_refs.GetItemString( li_find, "ref_2_type")//maha102501
		ls_type3 = ids_refs.GetItemString( li_find, "ref_3_type")//maha102501
end choose
	
//check fo no reference fields
if isnull(ls_ref_1 ) and isnull(ls_ref_2 ) then
	
	return of_get_screen_name( ai_screen)
end if

//GET REFERENCE VALUES

//get reference 1 data
if adw_data.Describe(ls_ref_1 + ".ColType") = "!"  or  ls_ref_1 = ""  or  isnull(ls_ref_1)  then //trap for invisible field maha 012104 
	ls_r1 = ""
	li_mess = 1
else
	adw_data.Setrow(ai_row) 
	
	li_retval = adw_data.SetColumn( ls_ref_1 )
	choose case ls_type1
		case "C","V"
			ls_r1 = adw_data.getitemstring(ai_row,ls_ref_1)
		case "N", "I" 
			ls_r1 = string(adw_data.getitemnumber(ai_row,ls_ref_1))
		case "D"
			ls_r1 = string(date(adw_data.getitemdatetime(ai_row,ls_ref_1)))
	end choose
	
	if isnull(ls_r1) or ls_r1 = "" then  //if no data
		ls_r1 = ""
		li_mess = 1
	else
		ls_lookup_type = "" //reset
		ls_lookup_type = of_get_screen_field_data(ai_screen,ls_ref_1,"lookup_type")
		
		if ls_lookup_type = 'A' then
			ls_cond =  'lookup_code = ' +string(ls_r1 ) 
			ls_value = of_get_addr_lu_value( ls_cond,"entity_name")
		
			if ls_value = "" then
				i = idw_address_lookup.find( ls_cond , 1, idw_address_lookup.rowcount() )
							//messagebox(string (i),ls_cond)
				if i > 0 then ls_value =  idw_address_lookup.getitemstring(i,"entity_name")
			end if

			
			if LenA(ls_value) > 0 then
				ls_r1 = ls_value		
			elseif isnull(ls_value) then
				ls_r1 = ""
			end if
		elseif ls_lookup_type = "C" then
	//		if ls_ref_1 = 'id_type' then debugbreak()
			ls_lu_field = of_get_screen_field_data(ai_screen,ls_ref_1,"lookup_field_name")
			ls_lu_table = of_get_screen_field_data(ai_screen,ls_ref_1,"lookup_code")
			ls_cond =  "lookup_code = " + ls_r1 
			//ls_cond =  "upper(" + ls_lu_field + ") = " + upper(ls_r1 ) + " and upper(lookup_name) = '" + upper(ls_lu_table) + "'"
			ls_value = gnv_data.of_getitem( "code_lookup",ls_lu_field , ls_cond)
			if ls_value = "" then  //special coded exceptions
				choose case upper(ls_lu_table)
					case "YES/NO"
							ls_value = of_code_lookup_exception( upper(ls_lu_table), ls_r1 )
				end choose
			end if
			if ls_value = "" then //if not found check for newly added lookups
				i = idw_code_lookup.find( ls_cond , 1, idw_code_lookup.rowcount() )
				//messagebox(string (i),ls_cond)
				if i > 0 then ls_value =  idw_code_lookup.getitemstring(i,"description")
			end if
			if LenA(ls_value) > 0 then
				ls_r1 = ls_value		
			elseif isnull(ls_value) then
				ls_r1 = ""
			end if
		else
			//ls_r1 = ls_value	
		end if
	end if //data exists
END IF  //field exists

//REFERENCE 2

if adw_data.Describe(ls_ref_2 + ".ColType") = "!"  or  ls_ref_2 = ""  or  isnull(ls_ref_2)  then //check for missing
	ls_r2 = ""
else
	li_retval = adw_data.SetColumn( ls_ref_2 )
	choose case ls_type2
		case "C","V"
			ls_r2 = adw_data.getitemstring(ai_row,ls_ref_2)
		case "N", "I" 
			ls_r2 = string(adw_data.getitemnumber(ai_row,ls_ref_2))
		case "D"
			ls_r2 = string(date(adw_data.getitemdatetime(ai_row,ls_ref_2)))
	end choose
	
	if isnull(ls_r2) or ls_r2 = "" then  //if no data
		ls_r2 = ""
	else
		ls_lookup_type = ""   //reset
		ls_lookup_type = of_get_screen_field_data(ai_screen,ls_ref_2,"lookup_type")
		if ls_lookup_type = 'A' then
			ls_cond =  'lookup_code = ' +string(ls_r2 ) 
			ls_value = of_get_addr_lu_value( ls_cond,"entity_name")
		
			if ls_value = "" then
				i = idw_address_lookup.find( ls_cond , 1, idw_address_lookup.rowcount() )
							//messagebox(string (i),ls_cond)
				if i > 0 then ls_value =  idw_address_lookup.getitemstring(i,"entity_name")
			end if

			if LenA(ls_value) > 0 then
				ls_r2 = ls_value		
			elseif isnull(ls_value) then
				ls_r2 = ""
			end if
		elseif ls_lookup_type = "C" then
			ls_lu_field = of_get_screen_field_data(ai_screen,ls_ref_2,"lookup_field_name")
			ls_lu_table = of_get_screen_field_data(ai_screen,ls_ref_2,"lookup_code")
			ls_cond =  "lookup_code = " + ls_r2
			//ls_cond =  "upper(" + ls_lu_field + ") = " + upper(ls_r2 ) + " and upper(lookup_name) = '" + upper(ls_lu_table) + "'"
			ls_value = gnv_data.of_getitem( "code_lookup",ls_lu_field , ls_cond)
			if ls_value = "" then  //special coded exceptions
				choose case upper(ls_lu_table)
					case "YES/NO"
							ls_value = of_code_lookup_exception( upper(ls_lu_table), ls_r2 )
				end choose
			end if
			if ls_value = "" then
				i = idw_code_lookup.find( ls_cond , 1, idw_code_lookup.rowcount() )
				//messagebox(string (i),ls_cond)
				if i > 0 then ls_value =  idw_code_lookup.getitemstring(i,"description")
			end if
			if LenA(ls_value) > 0 then
				ls_r2 = ls_value		
			elseif isnull(ls_value) then
				ls_r2 = ""
			end if
		end if
	end if
END IF

if LenA( ls_r1) > 0 then 
	ls_reference = ls_r1 
	if LenA(ls_r2) > 0 then ls_reference = ls_r1 + " - " + ls_r2
else
	if LenA(ls_r2) > 0 then
		ls_reference = ls_r2
	else		//if no reference values get the screen name
		//messagebox("Data notice","Unable to get data for data fields "  + upper(ls_ref_1) + " or " + upper(ls_ref_2) + " for this record the reference value will be blank.  To correct this, check your data or contact IntelliCred support")
		ls_reference = of_get_screen_name( ai_screen)
	end if
end if


return ls_reference
end function

public function string of_strip_cpr_type (string as_value);//function to strip the cert type from the whole name - called from of_set_field_value

string ls_ret
integer p1
integer p2

p1 = PosA(as_value,"(",1)
p2 = PosA(as_value,")", 1)

ls_ret = MidA(as_value, p1 + 1, p2 - p1 -1)

return ls_ret
end function

public function integer of_save ();integer i
integer res
long ll_log_id


//turn off autocommit
sqlca.autocommit = false

//update lookup tables - moved up by (caqh 2)alfee 07.29.2009
res = idw_address_lookup.update()
if res < 1 then 
	is_failed = "addr lu"
	return -1
end if
res = idw_code_lookup.update()
if res < 1 then 
	is_failed = "code lu"
	return -1
end if
res = ids_questions.update()
if res < 1 then 
	is_failed = "quest lu"
	return -1
end if

//update basic and appointment
idw_basic.accepttext( )  //Start Code Change ----10.28.2009 #V10 maha
res = idw_basic.update()
if res < 1 then 
	is_failed = "Basic"
	return -1
end if

idw_appointment.accepttext( )  //Start Code Change ----10.28.2009 #V10 maha
res = idw_appointment.update()
if res < 1 then 
	is_failed = "Appointment"
	return -1
end if

//update other tables
//for i = 1 to 21 
for i = 1 to 22 //add ecfmg - (caqh 2)alfee 12.18.2009	
	choose case i
		case 1
			idw_cur_dw = idw_address
		case 2
			idw_cur_dw = idw_addr_link
		case 3
			idw_cur_dw = idw_attest
		case 4
			idw_cur_dw = idw_claims
		case 5
			idw_cur_dw = idw_cpr
		case 6
			idw_cur_dw = idw_dea
		case 7
			idw_cur_dw = idw_education
		case 8
			idw_cur_dw = idw_experience
		case 9
			idw_cur_dw = idw_hospital
		case 10
			idw_cur_dw = idw_hosp_link
		case 11
			idw_cur_dw = idw_insurance
		case 12
			idw_cur_dw = idw_language
		case 13
			idw_cur_dw = idw_license
		case 14
			idw_cur_dw = idw_oids
		case 15
			idw_cur_dw = idw_reference
		case 16
			idw_cur_dw = idw_specialty
		case 17
			idw_cur_dw = idw_spec_link
		case 18
			idw_cur_dw = idw_training
		case 19
			idw_cur_dw = idw_workgap
		case 20
			idw_cur_dw = idw_verifs
		case 21
			idw_cur_dw = idw_audit_trail
		case 22 //add ecfmg - (caqh 2)alfee 12.18.2009
			idw_cur_dw = idw_ecfmg			
	end choose
	
	idw_cur_dw.accepttext( )  //Start Code Change ----10.28.2009 #V10 maha

	//--Begin Modified by (caqh 2)alfee 12.18.2009 ----	
	//res = idw_cur_dw.update()
	if i = 21 then //audit trail
		if gi_test_mode = 1 then idw_cur_dw.SaveAs("c:\test.xls", Excel8!, true)
		res = inv_data_entry.of_field_audit_upd4caqh()
	else
		res = idw_cur_dw.update()
	end if
	//--End Modified ---------------------------
	if res < 1 then 
		is_failed = "dw#" + string(i)
		return -1
	end if
next

res = idw_log.update()
if res < 1 then 
	is_failed = "log"
	return -1
end if

//Added by Appeon long.zhang 04.07.2015 (v15.1 CAQH Import Data Approval)
If ib_from_audit Then
	res = ids_caqh_log_items.update()
	if res < 1 then 
		is_failed = "log items"
		return -1
	end if
	
	//get log_id and set caqh_log.audit_finished by log_id
	ll_log_id = ids_caqh_log_items.getitemnumber(1,'log_id')
	If ids_caqh_log_items.find('status = 0', 1, ids_caqh_log_items.rowcount()) = 0 Then
		Update caqh_log set audit_finished = 1 where log_id = :ll_log_id;
		If sqlca.sqlcode < 0 Then
			is_failed = "audit finished"
			Return -1
		End If
	End If
End If

res = idw_committees.update()
if res < 1 then 
	is_failed = "committees"
	return -1
end if

//--Begin Added by (caqh 2)alfee 12.18.2009 ----
idw_app_audit.accepttext( ) 
res = idw_app_audit.update() 
if res < 1 then 
	is_failed = "app audit"
	return -1
end if
//--End Added --------------------------

return 1
end function

public function string of_get_question_id (string as_condition, string as_columnname);//Start Code Change ----06.23.2009 #V92 maha - added

long ll_findrow
string ls_value
string ls_condition

ls_condition = of_strip_char("'", as_condition, "") // strip quote
//if ls_condition <> as_condition then
//	messagebox("of_get_addr_lu_value",ls_condition + " -|- " + as_condition)
//end if
ll_findrow = ids_questions.find(as_condition , 1,  ids_address_lookup.rowcount())
If ll_findrow = 0 Then 
	Return ""
elseif ll_findrow < 0 then  // trap added
	//messagebox("Find failed in of_get_addr_lu_value",ls_condition)
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Find failed in of_get_addr_lu_value",ls_condition,true)
	return ""
end if

Choose Case Lower(as_columnname)
	Case "quest_id" ,"quest_type"
			ls_value = string(ids_questions.getitemnumber(ll_findrow,  as_columnname)	)
	Case "short_quest", "full_quest"
			ls_value = ids_questions.getitemstring(ll_findrow,  as_columnname)
End Choose

return ls_value
end function

public function string of_get_screen_name (integer ai_screen);string s

select screen_name into :s from data_view_screen where screen_id = :ai_screen and data_view_id = 1;

return s
end function

public function string of_strip_lookup_value (string as_lookup_type, string as_field_name, string as_value);//alfee 07.29.2009

String ls_value

ls_value = Trim(as_value)
CHOOSE CASE Upper(as_lookup_type)
	CASE 'A' //address lookup
		CHOOSE CASE Lower(as_field_name)
			CASE 'lookup_name', 'country'
				ls_value = LeftA(ls_value, 20)
			CASE 'code'
				ls_value = LeftA(ls_value, 15)
			CASE 'entity_name', 'street1', 'street2'
				ls_value = LeftA(ls_value, 100)
			CASE 'city'
				ls_value = LeftA(ls_value, 35)
			CASE 'state'
				ls_value = LeftA(ls_value, 2)
			CASE 'zip'
				ls_value = LeftA(ls_value, 12)
			CASE 'phone', 'fax'
				ls_value = LeftA(ls_value, 25)
			CASE 'web_address'
				ls_value = LeftA(ls_value, 255)
			CASE 'email_address', 'ic_c', 'custom_3','custom_4','custom_5','custom_6','contact_name', 'contact_salutation'
				ls_value = LeftA(ls_value, 50)
			CASE 'web_title'
				ls_value = LeftA(ls_value, 200)
			CASE 'audit_flag'
				ls_value = LeftA(ls_value, 3)						
		END CHOOSE
	CASE 'C' //code lookup
		IF lower(as_field_name) = 'description' THEN ls_value = LeftA(ls_value, 75)
	CASE 'Q' //question lookup
		IF lower(as_field_name) = 'short_quest' THEN ls_value = LeftA(ls_value, 40)
	CASE ELSE
		// do nothing
END CHOOSE

RETURN ls_value
end function

public function integer of_add_log ();//CAQH 2 - reconstructed by alfee 12.18.2009

long ll_cnt
datetime ldt_now
string ls_file, ls_prac_name

idw_log.insertrow(1)
ldt_now = datetime(today(),now())
idw_log.setitem(1,"log_date",ldt_now)
ll_cnt = ids_caqh_log.rowcount()
if ll_cnt > 1 then //update
	idw_log.setitem(1,"first_log", ids_caqh_log.getitemdatetime(ll_cnt,"first_log"))
else
	idw_log.setitem(1,"first_log", ldt_now)
end if
idw_log.setitem(1,"user_id", gs_user_id)
idw_log.setitem(1,"attest_date",is_attest_date)
idw_log.setitem(1,"caqh_id", string(il_prov_id) )
idw_log.setitem(1,"attest_id", string(il_attest_id) )
idw_log.setitem(1,"ssn", is_ssn )
idw_log.setitem(1,"npi", is_npi )
ls_file = is_file
if LenA(ls_file) > 49 then ls_file = RightA(ls_file, 50)
idw_log.setitem(1,"file_name", ls_file )
idw_log.setitem(1,"prac_id",il_prac )

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.19.2015
//<$>reason:v15.1 CAQH Import Data Approval

//Indicate whether this prac id exists when import the xml. N for new, U for update.
If ib_update Then	
	idw_log.setitem(1,"imp_type","U")
Else
	idw_log.setitem(1,"imp_type","N")
End if

//Indicate whether ‘Log to Acceptance’ is checked when import the xml. 1 = acceptance logged; 0 = no logging.
If ib_approval_flag  Then
	idw_log.setitem(1,"accepted","1")
	
	//Record ’Data Defaults’ to caqh_log.defaults
	idw_log.setitem(1,"defaults", of_get_defaults_vars())
	
	//Record Prac_name
	If not isnull( is_last_name ) Then ls_prac_name = is_last_name
	If not isnull( is_first_name ) Then ls_prac_name += ', '+is_first_name
	idw_log.setitem(1,"Prac_name", ls_prac_name) 
	
	//set audit_finished flag
	If idw_log_items.find('status = 0' ,1 ,idw_log_items.rowcount()) > 0 Then
		idw_log.setitem(1,"audit_finished", 0) 
	Else
		idw_log.setitem(1,"audit_finished", 1) 
	End If
Else
	idw_log.setitem(1,"accepted", "0")
End if
//------------------- APPEON END -------------------

return 1

////Start Code Change ----08.03.2009 #V92 maha - moved from of_match Prac
//datetime ldt_now
//string ls_file
//
//idw_log.insertrow(1)
//ldt_now = datetime(today(),now())
//idw_log.setitem(1,"log_date",ldt_now)
//idw_log.setitem(1,"first_log", ldt_now)
//idw_log.setitem(1,"user_id", gs_user_id)
//idw_log.setitem(1,"attest_date",is_attest_date)
//idw_log.setitem(1,"caqh_id", string(il_prov_id) )
//idw_log.setitem(1,"attest_id", string(il_attest_id) )
//idw_log.setitem(1,"ssn", is_ssn )
//idw_log.setitem(1,"npi", is_npi )
//ls_file = is_file
//if len(ls_file) > 49 then //Start Code Change ----09.29.2009 #V92 maha - truncate file length trap
//	ls_file = right(ls_file, 50)
//end if 
//idw_log.setitem(1,"file_name", ls_file )
//il_prac = gnv_app.of_get_id( "PRAC_ID" ) 
//idw_log.setitem(1,"prac_id",il_prac )
//
//return 1
end function

public function integer of_set_appt_defaults (integer ai_p, integer ai_a, integer ai_v, string as_type, string as_affil, string as_parent, boolean ab_prov, boolean ab_title);//called from the caqh window to set defaults
ii_parent = ai_p
ii_audit = ai_a
ii_verif = ai_v
is_type = as_type
is_affil  = as_affil
is_parent = as_parent
ib_prov_id = ab_prov
ib_title = ab_title

return 1
end function

public function integer of_update_field_values (string as_caqh_tables[]);//Update field values for the practitioner found - (caqh 2)alfee 12.18.2009

Long ll_cnt, i, ll_foundrow
String ls_find, ls_isg_table

IF NOT ib_update THEN RETURN 0

ll_cnt = UpperBound(as_caqh_tables)
IF ll_cnt < 1 THEN RETURN 0


FOR i = 1 to ll_cnt

	ls_find = "upper(caqh_table) = upper('" + as_caqh_tables[i] + "')"
	ll_foundrow = idw_mapping.find(ls_find, 1, idw_mapping.rowcount())
	IF NOT ll_foundrow > 0 THEN CONTINUE

//	ls_isg_table = 
//		of_set_table(ls_isg_table)
//	li_rc = idw_cur_dw.rowcount() //get current row
	
	//assign the current datawindow
	
	
	
	//idw_cur_dw = 
	
	//determine multi-record screen
	
	
	
	//if multi-record screen compare with caqh reference values
NEXT


RETURN 1
end function

public function integer of_set_field_value (string as_table, string as_field, string as_value, boolean ab_get_info, ref string as_isg_info);string ls_isg_field
string ls_isg_table
string ls_find
string ls_type
string ls_lookup
string ls_lu_type
string ls_lu_table
string ls_lu_field
string ls_cond
string ls_value
string ls_type_search
string ls_lookup_field = "lookup_code"
string ls_lu_value //(caqh 2)alfee 07.29.2009
string ls_rtn //(caqh 2)alfee 12.18.2009
long ll_foundrow
long ll_value
long ll_new_lookup
integer li_rc
integer nr
integer i
datetime ldt_value
datawindow ldw_lookup

//Start Code Change ----04.19.2010 #V10 maha - exception for gender; may be presented in the file in one of two tables Provider or Other Name
choose case upper(as_field) 
	case 	'GENDERDESCRIPTION','NPI', 'LICENSETYPE'
		ls_find = " upper(caqh_field) = upper('" + as_field + "')"
		
		//Added by Appeon long.zhang 06.08.2015 (Bug id 4552 - CAQH Import files Build date 05/15/2015 SAAS)
		If Upper(as_table) = 'PRACTICE' and upper(as_field) = 'NPI'  Then ls_find = "upper(caqh_table) = upper('" + as_table + "') and upper(caqh_field) = upper('" + as_field + "')"
	case else
		ls_find = "upper(caqh_table) = upper('" + as_table + "') and upper(caqh_field) = upper('" + as_field + "')"
end choose
//End Code Change---04.19.2010


ll_foundrow = idw_mapping.find(ls_find, 1, idw_mapping.rowcount() )
ls_value = as_value

if ll_foundrow < 0 then
	//Messagebox("of_set_field_value","Find Failed")
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
   inv_message.of_MessageBox("of_set_field_value","Find Failed",true)
elseif ll_foundrow = 0 then
	//skip
else
	ls_isg_field = idw_mapping.getitemstring(ll_foundrow,"isg_field" )
	ls_isg_table = idw_mapping.getitemstring(ll_foundrow,"isg_table" )

	if ls_isg_field = 'n/a' then return 1
	if ls_isg_field = '' then return 1
	
	//strip cpr cert type exception - THIS FUNCTION NOT CURRENTLY USED AS THE CPR RECORDS ARE CONNECTED TO THE PRACTICE 
	if ls_isg_field = "cert_type" and ls_isg_table = "pd_cpr_Certifiations" then 
		ls_value = of_strip_cpr_type( as_value )
	end if
	
	//Start Code Change ----04.05.2010 #V10 maha - special coding for Accepting new patients
	if upper(as_table) = "PATIENT" and UPPER(as_field) = "PATIENTFLAG" then //the yes no value appears in the file before the type
		ii_new_patient = integer(as_value)
		return 1
	end if

	ls_type = gnv_data.of_get_sys_field_value(ls_isg_table ,ls_isg_field,"field_type") //lines moved from below
	ls_lookup = gnv_data.of_get_sys_field_value(ls_isg_table ,ls_isg_field,"lookup_field")	
	
	if upper(as_table) = "PATIENT" and UPPER(as_field) = "PATIENTTYPEDESCRIPTION" then
		if as_value = "New Patients" then
			If (ab_get_info = false and as_isg_info <> '') Then //Add If condition and Hard Code, by Appeon long.zhang 05.04.2015 (v15.1 CAQH Import Data Approval)
				//Hard Code, called from of_read_parsed_file.of_set_field_value(ls_table, ls_field, ls_value, i)
				ls_value = ids_data_parsed.GetItemString(Integer(as_isg_info) , 'isg_value')
			Else
				if ii_new_patient = 1 then
					ls_value = "581"
				elseif ii_new_patient = 0 then
					ls_value = "582"
				end if
			End If
			ls_lookup = "N"  //set to bypass the lookup value set for the accepting new patients
		else
			return 1
		end if
	end if
	//End Code Change---04.05.2010
	
	//for the fields of the lookup table
	if ls_isg_table = 'address_lookup' then //set the lookup value if a new record		
		if il_lookup_row = 0 then
			return 1
		else 
			as_value = of_strip_lookup_value('A', ls_isg_field, as_value) 
			ldw_lookup = idw_address_lookup
			ldw_lookup.setitem(il_lookup_row,ls_isg_field, as_value)
			return 1
		end if
	end if
	//ls_type = gnv_data.of_get_sys_field_value(ls_isg_table ,ls_isg_field,"field_type")
	//ls_lookup = gnv_data.of_get_sys_field_value(ls_isg_table ,ls_isg_field,"lookup_field")
	if ls_lookup = "Y" then
		 //Start Code Change ----08.18.2015 #V15 maha - DEA exception
		If as_table = "PROVIDERDEA"   and as_field =  "STATE" then
			ls_value = "90"
		ELSE
		 //End Code Change ----08.18.2015
			ls_lu_type = gnv_data.of_get_sys_field_value(ls_isg_table ,ls_isg_field,"lookup_type")
			ls_lu_table = gnv_data.of_get_sys_field_value(ls_isg_table ,ls_isg_field,"lookup_code")
			choose case ls_lu_type
				case "C"
					ls_lu_type = "code_lookup"
					if LenA(as_value ) > 9 then //9 is an arbitrary number to test if the search should be on code or description
						ls_lu_field = "description"
					else
						ls_lu_field = "code"
					end if
					
					//Start Code Change ----10.18.2016 #V152 maha
					choose case ls_isg_field
						case "foreign_language", "country"
							ls_lu_field = "description"
					end choose
					//Start Code Change ----10.18.2016
					
					as_value = of_strip_lookup_value('C', ls_lu_field, as_value)
									
					//Start Code Change ----04.05.2010 #V10 maha - if the education import record is really for training then look for training type
					if ls_isg_table = "pd_education" then
						choose case MidA(as_value, 1 , 5)
							case "Inter", "Fello","Other" , "Resid"  //Start Code Change ----09.30.2014 #V14.2 maha - added residency
								if ls_isg_field = "education_type" then
									ls_lu_table = "Training Type"
								elseif ls_isg_field = "School" then
									ls_lu_table = "Training"
								end if
						end choose
					end if
					//End Code Change ----04.05.2010
					
					ls_cond =  "upper(" + ls_lu_field + ") = '" + upper(as_value ) + "' and upper(lookup_name) = '" + upper(ls_lu_table) + "'"
					ls_value = string(gnv_data.of_getitem( ls_lu_type,"lookup_code" , ls_cond))
					if ls_value = "" then  //special coded exceptions
						choose case upper(ls_lu_table)
							case "YES/NO"
								ls_value = of_code_lookup_exception( upper(ls_lu_table), as_value )
							case "QUESTION ANSWERS"
								ls_value = of_code_lookup_exception( upper(ls_lu_table), as_value )
						end choose
					end if
					if ls_value = "" then
						i = idw_code_lookup.find( ls_cond , 1, idw_code_lookup.rowcount() )
						if i > 0 then ls_value =  string(idw_code_lookup.getitemnumber(i,"lookup_code"))
					end if
				case "A"
	
					ls_lu_type = "address_lookup"
					ls_lu_field = "entity_name"
					as_value = of_strip_lookup_value('A', ls_lu_field, as_value) 
					ls_cond =  'upper(' + ls_lu_field + ') = "' + upper(as_value ) + '" and upper(lookup_name) = "' + upper(ls_lu_table) + '"'
					ls_value = of_get_addr_lu_value( ls_cond,ls_lookup_field)  //local function
					//check to see if lookup already created
					if ls_value = "" then
						i = idw_address_lookup.find( ls_cond , 1, idw_address_lookup.rowcount() )
						if i > 0 then ls_value =  string(idw_address_lookup.getitemnumber(i,"lookup_code"))
					end if
				case "Q"
					//get the question id
					ls_lu_value = of_strip_lookup_value('Q', 'short_quest', as_value) 
					ls_cond =  "upper(short_quest) = '" + upper(ls_lu_value ) + "'" 			
					ls_value = of_get_question_id( ls_cond, "quest_id")
				case else
					return 1
			end choose
	
			//if not found then create lookup
			if ls_value = "" then //record not found
				ll_new_lookup = gnv_app.of_get_id( "LOOKUP" )
				choose case ls_lu_type
					case "code_lookup"
						ldw_lookup = idw_code_lookup
					case "address_lookup"
						ldw_lookup = idw_address_lookup
					case else
				end choose
				
				if ls_lu_type = 'address_lookup' or ls_lu_type = 'code_lookup' then
					nr = ldw_lookup.insertrow(0)
					if ls_lu_type = 'address_lookup' then il_lookup_row = nr
					ldw_lookup.setitem(nr,"lookup_code",ll_new_lookup)
					ldw_lookup.setitem(nr,"lookup_name",ls_lu_table )
					//set code and description to the same if match field is code
					if ls_lu_type = 'code_lookup' and ls_lu_field = "code" then ldw_lookup.setitem(nr,"description",as_value)
					ldw_lookup.setitem(nr,"code",string(ll_new_lookup))
					ldw_lookup.setitem(nr,ls_lu_field,as_value)
					ls_value = string(ll_new_lookup)
				else //question
					ll_new_lookup = ids_questions.getitemnumber(ids_questions.rowcount(),"quest_id" )
					ll_new_lookup++
					nr = ids_questions.insertrow(0)
					ids_questions.setitem(nr,"short_quest", ls_lu_value) 
					ids_questions.setitem(nr,"full_quest", as_value )
					ids_questions.setitem(nr,"quest_id", ll_new_lookup )
					ids_questions.setitem(nr,"quest_type", -100 )
					ls_value = string(ll_new_lookup)
				end if
			else
				il_lookup_row = 0 //record was found
			end if
		End if //dea state exception
	else //not a lookup
		
		choose case upper(as_table)  //data exceptions not in lookup table
			case "INSURANCE"
				ls_value = of_data_exception( as_table, as_field, as_value) 
			case "DISCLOSURE"
				ls_value = of_data_exception( as_table, as_field, as_value) 
		end choose	
		//Start Code Change ----08.19.2009 #V92 maha - format phone
		choose case as_field
			case "PHONENUMBER", "FAXNUMBER" 	//(123) 456-7890
				ls_value = "(" + MidA(ls_value,1,3) + ") " + MidA(ls_value,4,3) + "-" + MidA(ls_value,7)
		end choose
		//End Code Change---08.19.2009
	end if

	//-------Begin Modified by (caqh 2)alfee 12.18.2009 ----------------------------
	//return ISG data for a 'Get' mode
	if ab_get_info then 
		//if isnull(ls_value) then messagebox("",ls_isg_table + "||" + ls_isg_field)
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		if isnull(ls_value) then inv_message.of_MessageBox("",ls_isg_table + "||" + ls_isg_field,true)
		as_isg_info = ls_isg_table + "||" + ls_isg_field + "||" + ls_value
		return 1
	end if

	//set current dw
	ls_rtn = of_set_table(ls_isg_table, 'ISG')
	If ls_rtn = "" then return -1

	//get current row
	if not ib_update then 
		if idw_cur_dw.rowcount() = 0 then 
			idw_cur_dw.insertrow(0) 
			
			//Keep current row no in a datastore, Added by Appeon long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
			li_rc = idw_cur_dw.rowcount() 
			of_set_currow(ls_isg_table, li_rc)
		End If
		li_rc = idw_cur_dw.rowcount() 	
	else
		li_rc = of_get_currow(ls_isg_table)
		if IsNull(li_rc) or li_rc < 1 then //new isg table
			li_rc = of_build_table(ls_isg_table, 'ISG', Integer(as_isg_info)) //as_isg_info here is the rec idx
		end if
	end if
	if li_rc < 1 then return -1
	
	//Start Code Change ----11.01.2010 #V10 maha - set value to use to set link types
	//for address type setting
     //---------Begin Added by (Appeon)Alfee 04.24.2014 -------------------------------------
	//<$Reason>For Error importing CAQH xml, like the NPI may be included in the Practice. 
	choose case upper(as_field) 	
		case 	'GENDERDESCRIPTION','NPI', 'LICENSETYPE'
			// do nothing. 
		case else
	//---------End Added -------------------------------------------------------------------------
			choose case as_table 
				case "PROVIDERADDRESS"   //home address
					of_set_item("N", li_rc, "mailing_address", "3")
				case "PRACTICE"
					choose case li_rc
						case 1  //primary
							of_set_item("N", li_rc, "mailing_address", "1")
						case else //additional
							of_set_item("N", li_rc, "mailing_address", "2")
					end choose
				case "TAX"

			end choose
	end choose	//Alfee 04.24.2014		
	//Start Code Change ----11.01.2010
	
	//set value of field
	of_set_item(ls_type, li_rc, ls_isg_field, ls_value)
	
	//other ids exceptions - add id type based on the field name
	if ls_isg_field = "id_number" and ls_isg_table = "pd_other_Ids" then
		ll_new_lookup = of_get_id_type(as_field)		
		of_set_item('N', li_rc, "id_type", String(ll_new_lookup)) 
	end if	
	
	//training record
	if ls_isg_field = "education_type" and ls_isg_table = "pd_education" then
		choose case MidA(as_value, 1 , 5)
			case "Inter", "Fello","Other" , "Resid"  //Start Code Change ----09.30.2014 #V14.2 maha - added residency
				idw_cur_dw.setitem(li_rc, "cust_1", "T##" + as_value) 
		end choose
	end if
	
	/*	
	of_set_table(ls_isg_table)		
	li_rc = idw_cur_dw.rowcount() 

	choose case ls_type
		case "C"
			idw_cur_dw.setitem(li_rc, ls_isg_field,ls_value )
		case "D"
			ldt_value = datetime(date(ls_value), time("00:00:00"))
			//messagebox( "",idw_cur_dw.dataobject)
			idw_cur_dw.setitem(li_rc, ls_isg_field,ldt_value )
		case "N","I", "V"
			ll_value = long(ls_value)
			idw_cur_dw.setitem(li_rc, ls_isg_field,ll_value )
	end choose	 
	
	//other ids exceptions needs to add type based on the field name
	if ls_isg_field = "id_number" and ls_isg_table = "pd_other_Ids" then
		choose case upper(as_field)
			case "FEDERALEMPLOYEEID"
				ls_type_search = "Federal Employee ID"
			case "VISANUMBER"
				ls_type_search = "Visa Number"
			case "MEDICAIDNUMBER"
				ls_type_search = "Medicare UPIN"
			case "MEDICARENUMBER"
				ls_type_search = "Medicaid UPIN"
			case "UPIN"
				ls_type_search = "UPIN"
		end choose
		ls_cond =  "upper(description) = '" + upper(ls_type_search ) + "' and lookup_name = 'Other Document Type'"
		ls_value = string(gnv_data.of_getitem( "code_lookup","lookup_code" , ls_cond))
		if ls_value = "" then //record not found
			ll_new_lookup = gnv_app.of_get_id( "LOOKUP" )
			ldw_lookup = idw_code_lookup
			nr = ldw_lookup.insertrow(0)
			ldw_lookup.setitem(nr,"code",upper(ls_type_search))
			ldw_lookup.setitem(nr,"description",ls_type_search)
			ldw_lookup.setitem(nr,"lookup_name",'Other Document Type')
			ldw_lookup.setitem(nr,"lookup_code",ll_new_lookup)
		else 
			ll_new_lookup = long(ls_value)
		end if
		idw_cur_dw.setitem(li_rc, "id_type",ll_new_lookup )		
	end if	
	
	if ls_isg_field = "education_type" and ls_isg_table = "pd_education" then
		choose case mid(as_value, 1 , 5)
			case "Inter", "Fello","Other"
				idw_cur_dw.setitem(li_rc, "cust_1","T" )
			case else
				idw_cur_dw.setitem(li_rc, "cust_1","E" ) 
		end choose
	end if
	*/
	//-------End Modified --------------------------------------------------		
	
end if

//gnv_data.of_get_data_from_cache( ls_isg_table , /*string as_condition*/, /*datastore a_dwchild */)

return 1

end function

public function integer of_get_field_value (string as_caqh_table, string as_caqh_field, string as_caqh_value, boolean ab_caqh_table);//Get related ISG info based on the spcified CAQH info - CAQH 2: alfee 12.18.2009

Long ll_pos1, ll_pos2, ll_row, ll_found
String ls_isg_info, ls_table, ls_field, ls_value, ls_find
Boolean lb_get_mode = true

//Get related ISG data
of_set_field_value(as_caqh_table, as_caqh_field, as_caqh_value, lb_get_mode, ls_isg_info)

IF IsNull(ls_isg_info) OR LenA(ls_isg_info) < 1 THEN RETURN 0

ll_pos1 = PosA(ls_isg_info, '||')
IF ll_pos1 > 0 THEN 
	ls_table = LeftA(ls_isg_info, ll_pos1 - 1)
	ll_pos2 = PosA(ls_isg_info, '||', ll_pos1 + 2)
	IF ll_pos2 > 0 THEN 
		ls_field = MidA(ls_isg_info, ll_pos1 + 2, ll_pos2 - ll_pos1 - 2)
		ls_value = MidA(ls_isg_info, ll_pos2 + 2)
	END IF
END IF

//Add it into datastore
ll_row = ids_data_parsed.InsertRow(0)
ids_data_parsed.SetItem(ll_row, 'caqh_table', as_caqh_table)
ids_data_parsed.SetItem(ll_row, 'caqh_field', as_caqh_field)
ids_data_parsed.SetItem(ll_row, 'caqh_value', as_caqh_value)
ids_data_parsed.SetItem(ll_row, 'isg_table', ls_table)
ids_data_parsed.SetItem(ll_row, 'isg_field', ls_field)
ids_data_parsed.SetItem(ll_row, 'isg_value', ls_value)

//Set CAQH table flag
IF ab_caqh_table THEN 
	ids_data_parsed.SetItem(ll_row, "caqh_table_flag", 'Y')
END IF

//other ids exceptions - add id type based on the field name
IF lower(ls_field) = "id_number" and lower(ls_table) = "pd_other_ids" THEN
	//Get id type based on the field name
	ls_value = String(of_get_id_type(as_caqh_field))
	//Add id type into datastore (as it's a reference field although not a caqh mapping field) 
	ll_row = ids_data_parsed.InsertRow(0)
	ids_data_parsed.SetItem(ll_row, 'caqh_table', as_caqh_table)
	ids_data_parsed.SetItem(ll_row, 'caqh_field', '')
	ids_data_parsed.SetItem(ll_row, 'caqh_value', as_caqh_field)
	ids_data_parsed.SetItem(ll_row, 'isg_table', ls_table)
	ids_data_parsed.SetItem(ll_row, 'isg_field', 'id_type')
	ids_data_parsed.SetItem(ll_row, 'isg_value', ls_value)
END IF

////Set multi-record flag
//IF ids_caqh_refs.rowcount() < 1 THEN ids_caqh_refs.retrieve()
//ls_find = "Lower(table_name) = '" + Lower(ls_table) + "'"
//ll_found = ids_caqh_refs.Find(ls_find, 1, ids_caqh_refs.rowcount())
//IF ll_found > 0 THEN 
//	ids_data_parsed.SetItem(ll_row, "muti_record", 'Y')	
//END IF

RETURN 1




end function

public function boolean of_is_multi_record (string as_table);//Determine if it's a multi-record table(/screen)  - (caqh 2)alfee 12.18.2009

Long ll_found
String ls_find

IF ids_caqh_refs.rowcount() < 1 THEN ids_caqh_refs.retrieve()
//ls_find = "Lower(table_name) = '" + Lower(as_table) + "'"
ls_find = "Lower(table_name) = '" + Lower(as_table) + "' or Lower(table_name) = 'dba." + Lower(as_table) + "'" //alfee 11.04.2010
ll_found = ids_caqh_refs.Find(ls_find, 1, ids_caqh_refs.rowcount())

IF ll_found > 0 THEN RETURN TRUE

RETURN FALSE
end function

public function string of_get_caqh_ref (string as_table, integer ai_ref);//Get the CAQH reference field name for a specified table  - (caqh 2)alfee 12.18.2009

Long ll_found
String ls_find, ls_ref

IF IsNull(as_table) OR LenA(as_table) < 1 THEN RETURN ""
IF ai_ref <> 1 AND ai_ref <> 2 THEN RETURN ""

IF ids_caqh_refs.rowcount() < 1 THEN ids_caqh_refs.retrieve()
//ls_find = "Lower(table_name) = '" + Lower(as_table) + "'"
ls_find = "Lower(table_name) = '" + Lower(as_table) + "' or Lower(table_name) = 'dba." + Lower(as_table) + "'" //alfee 11.04.2010
ll_found = ids_caqh_refs.Find(ls_find, 1, ids_caqh_refs.rowcount())
IF ll_found > 0 THEN 
	ls_ref = ids_caqh_refs.GetItemString(ll_found, 'caqh_ref_' + String(ai_ref))
END IF

RETURN ls_ref
end function

public function integer of_set_currow (string as_isg_table, long al_cur_row);//Set current row for a specified isg table(dw) - caqh 2: alfee 12.18.2009

Long ll_cnt, ll_found ,ll_rec_id
String ls_find, ls_audit_type
DwItemStatus l_status

IF IsNull(as_isg_table) THEN RETURN -1
IF IsNull(al_cur_row) OR al_cur_row < 1 THEN RETURN -1

ll_cnt = ids_dw_currow.RowCount() 
ls_find = "Upper(isg_table) = '" + Upper(as_isg_table) + "'"

ll_found = ids_dw_currow.Find(ls_find, 1, ll_cnt)

IF ll_cnt < 1 OR ll_found < 1 THEN
	ll_found = ids_dw_currow.InsertRow(0)
	IF ll_found > 0 THEN ids_dw_currow.SetItem(ll_found, 'isg_table', as_isg_table)	
END IF	

IF ll_found > 0 THEN ids_dw_currow.SetItem(ll_found, 'cur_row', al_cur_row)	

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.25.2015
//<$>reason:Record Table_id Audit_type and rec_id, v15.1 CAQH Import Data Approval
IF ll_found > 0 and  ib_approval_flag THEN
	
	//Table_id
	ids_dw_currow.SetItem(ll_found, 'table_id', integer(gnv_data.of_getitem('sys_tables','table_id',"upper(table_name)='" + upper(as_isg_table) + "'")))	
	
	//cur_audit_type,Audit_type = ’NW’  means an new record/Audit_type = ’EW’ means an existing record.
	l_status = idw_cur_dw.getitemstatus(al_cur_row, 0, primary!)
	If l_status = new! OR l_status = NewModified!	 Then
		ls_audit_type = 'NW'
	Else
		ls_audit_type = 'EW'
	End If	
	ids_dw_currow.SetItem(ll_found, 'cur_audit_type', ls_audit_type)	
	
	//cur_rec_id
	If ls_audit_type = 'NW' Then//Audit_type = ’NW’  means an new record
		ll_rec_id = al_cur_row
	Else
		If idw_cur_dw.Describe("rec_id.ColType") <> "!" then
			ll_rec_id = idw_cur_dw.GetItemNumber(al_cur_row, 'rec_id')
		Else
			ll_rec_id = 0
		End If
	End If
	ids_dw_currow.SetItem(ll_found, 'cur_rec_id', ll_rec_id)			
End If
//------------------- APPEON END -------------------	
	

RETURN 1
end function

public function long of_get_currow (string as_isg_table);//Get current row for a specified isg table(dw) - caqh 2: alfee 12.18.2009

Long ll_cnt, ll_found, ll_cur_row
String ls_find

ll_cnt = ids_dw_currow.RowCount() 
IF ll_cnt < 1 OR IsNull(as_isg_table) THEN RETURN 0

ls_find = "Upper(isg_table) = '" + Upper(as_isg_table) + "'"
ll_found = ids_dw_currow.Find(ls_find, 1, ll_cnt)
IF ll_found > 0 THEN 
	ll_cur_row = ids_dw_currow.GetItemNumber(ll_found, 'cur_row')
END IF

RETURN ll_cur_row
end function

public function integer of_set_field_value (string as_table, string as_field, string as_value);//Set field value - (caqh 2)alfee 12.18.2009

string ls_temp

return of_set_field_value(as_table, as_field, as_value, false, ls_temp)


end function

public function integer of_set_field_value (string as_table, string as_field, string as_value, integer ai_idx);//Set field value for udpate mode - (caqh 2)alfee 12.18.2009
string ls_idx
boolean lb_get_mode = FALSE

ls_idx = string(ai_idx)
return of_set_field_value(as_table, as_field, as_value, lb_get_mode, ls_idx)


end function

private function long of_build_table (string as_table, string as_table_from, integer ai_idx);//Build dw and return current row - CAQH 2: Reconstructed by (caqh 2)alfee 12.18.2009

integer li_rtn
Long ll_cur_row
string ls_isg_table, ls_ref_1, ls_ref_2, ls_val_1, ls_val_2

//Set current dw and get the ISG table name 
ls_isg_table = of_set_table(as_table, as_table_from)
if ls_isg_table = "" then return -1

//Get current row in the current dw
if Not ib_update or idw_cur_dw.rowcount( ) < 1 then 
	//for new practitioner or no existing record
	//---------Begin Modified by (Appeon)Stephen 01.14.2015 for CAQH missing TIN#--------
	//ll_cur_row = idw_cur_dw.insertrow(0)	
	if idw_cur_dw.rowcount( ) > 0 and lower(as_table) = 'tax' then
		ll_cur_row =	idw_cur_dw.rowcount( )
	else
		ll_cur_row = idw_cur_dw.insertrow(0)	
	end if
	//---------End Modfiied ------------------------------------------------------
elseif not of_is_multi_record(ls_isg_table) then
	//for a single record table
	ll_cur_row = 1
else
	if upper(as_table) = 'TAX' then //Start Code Change ----12.10.2012 #V12 maha - added to keep the same row
		ll_cur_row =	idw_cur_dw.rowcount( )
	else
		//for a multi-record table
		ls_ref_1 = of_get_caqh_ref(ls_isg_table, 1)
		ls_ref_2 = of_get_caqh_ref(ls_isg_table, 2)
		ll_cur_row = of_find_existing_record(ls_isg_table, ls_ref_1, ls_ref_2, ai_idx)
		if IsNull(ll_cur_row) or ll_cur_row < 1 then
			ll_cur_row = idw_cur_dw.insertrow(0)
		end if
	end if
end if	
if upper(as_table) = 'PROVIDER' and idw_appointment.rowcount() < 1 then 
	//initialize appt.
	idw_appointment.insertrow(0) 
end if

//Start Code Change ----03.15.2016 #V15 maha - set provider caqh fields
if upper(as_table) = 'PROVIDER' and ib_caqh_vals_added = false then
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 04.07.2016
	//<$>reason:Support CAQH Audit, for V15 issues with CAQH import 
//	//messagebox("build table", "ProviderID* " + string(il_prov_id) +  "AttestDate*" + is_attest_date)
//	idw_basic.setitem(ll_cur_row, "caqh_id", string(il_prov_id ))
//	idw_basic.setitem(ll_cur_row, "caqh_last_attest", datetime (date(is_attest_date), time(00:00:00)))
//	//idw_basic.setitem(ll_cur_row, "", id_ )
	of_set_currow(ls_isg_table, ll_cur_row)
	of_set_item('C', ll_cur_row, "caqh_id", string(il_prov_id ))
	of_set_item('D', ll_cur_row, "caqh_last_attest", String( date(is_attest_date),'YYYY-MM-DD') )
	//------------------- APPEON END -------------------
	
	ib_caqh_vals_added = true
end if
//End Code Change ----03.15.2016

//Keep current row no in a datastore
of_set_currow(ls_isg_table, ll_cur_row)

of_progress( 100, "Adding " + as_table + " record.")

return ll_cur_row

//if POS(as_table ,"<",1) > 0 then return 1  //skips all the tables sub of practice
//
//choose case upper(as_table)
//	case 'PROVIDER'
//		of_add_row("basic")
//		of_add_row("appt")
//	case 'OTHERNAME'
//		
//	case 'LANGUAGE'
//		ii_lang++
//		of_add_row("language")
//	case 'PROVIDERCDS'
//		
//	case 'PROVIDEROTHERNAME'
//		
//	case 'PROVIDERMEDICARE'
//		ii_ids++
//		of_add_row("oids")
//	case 'PROVIDERMEDICAID'
//		ii_ids++
//		of_add_row("oids")
//	case 'PROVIDERLICENSE'	
//		ii_lic++
//		of_add_row("license")
//	case 'EDUCATION'
//		ii_edu++
//		of_add_row( "education")
//	case "DEGREE"
//	
//	case 'SPECIALTY'
//		ii_spec++
//		of_add_row( "specialty")
//	case 'OTHERINTEREST'
//				
//	case 'PRACTICE'
//		ii_addr++
//		of_add_row( "address")
////	case 'ACCESSIBILITY'
////		//practice	
//	case 'ASSOCIATE' //Start Code Change ----09.28.2009 #V92 maha - added
////			//practice
////	case 'ASSOCIATESPECIALTY'
////			//practice
////	case 'CERTIFICATION'
////			//practice
////	case 'LANGUAGE'
////		//practice
////	case 'LIMITATION'
////			//practice
////	case 'PATIENT'
////			//practice
////	case 'PHONECOVERAGE'
////			//practice
////	case 'SERVICE'
////			//practice
////	case 'TAXID'
////			//practice
////	case 'PROVIDERPRACTICEHOURS'
////		//practice
//	case 'HOSPITAL'
//		ii_hosp++
//		of_add_row( "hospital")
//	case 'INSURANCE'
//		ii_ins++
//		of_add_row( "insurance")
//	case 'WORKHISTORY'
//		ii_exp++
//		of_add_row( "experience")
//	case 'TIMEGAP'
//		ii_gap++
//		of_add_row( "workgap")
//	case 'REFERENCE'
//		ii_ref++
//		of_add_row( "reference")
//	case 'DISCLOSURE'
//		ii_att++
//		of_add_row( "attest")
//	case 'PROVIDEROTHER'
//		ii_att++	
//		of_add_row( "attest")
//	case 'PROVIDERCERTIFICATION'
//		ii_cpr++	
//		of_add_row( "cpr")
//		
//	case 'MEDICALASSOCIATION'
//		//???'
//		
//	case 'MALPRACTICE'
//		
//	case 'CLAIMSTATUS'
//		ii_clm++
//		of_add_row( "claims")
//	case 'PROVIDERADDRESS'
//		ii_addr++
//		of_add_row( "address")
//	case 'PROVIDERDEA'  //Start Code Change ----09.28.2009 #V92 maha - added case
//		ii_dea++
//		of_add_row( "dea")
//		
////	case 'PROVIDERIDENTIFIER'//Start Code Change ----10.04.2009 #V10 maha - TRAP ADDED //Start Code Change ----10.28.2009 #V10 maha - removed
//	
//	case else
////		messagebox("Table not found",as_table) //Start Code Change ----10.28.2009 #V10 maha - removed
//		
//end choose
//		
//
//		
//		
//return 1

end function

public function string of_set_table (string as_table, string as_table_from);//Set current dw by CAQH/ISG table name and return isg table name
//Reconstructed by (caqh 2)alfee 12.18.2009

String ls_isg_table

if Upper(as_table_from) = 'CAQH' then 
	//set current dw by CAQH table name 
	if PosA(as_table ,"<",1) > 0 then return "" //skips all the tables sub of practice
	
	choose case upper(as_table)
		case 'PROVIDER'
			idw_cur_dw = idw_basic
			ls_isg_table = 'PD_BASIC'
		case 'OTHERNAME'
		case 'LANGUAGE'
			idw_cur_dw = idw_language
			ls_isg_table = 'PD_LANGUAGES'			
		//case 'PROVIDERCDS' - moved below by alfee 09.21.2011			
		case 'PROVIDEROTHERNAME'			
		case 'PROVIDERMEDICARE', 'PROVIDERMEDICAID'
			idw_cur_dw = idw_oids
			ls_isg_table = 'PD_OTHER_IDS'			
		case 'PROVIDERLICENSE'	
			idw_cur_dw = idw_license
			ls_isg_table = 'PD_LICENSE'			
		case 'EDUCATION'
			idw_cur_dw = idw_education
			ls_isg_table = 'PD_EDUCATION'			
		case "DEGREE"		
		case 'SPECIALTY'
			idw_cur_dw = idw_specialty
			ls_isg_table = 'PD_BOARD_SPECIALTY'			
		case 'OTHERINTEREST'					
		case 'PRACTICE'
			idw_cur_dw = idw_address
			ls_isg_table = 'PD_ADDRESS'			
	//	case 'ACCESSIBILITY'
	//		//practice	
	//	case 'ASSOCIATE' 
	//			//practice
	//	case 'ASSOCIATESPECIALTY'
	//			//practice
	//	case 'CERTIFICATION'
	//			//practice
	//	case 'LANGUAGE'
	//		//practice
	//	case 'LIMITATION'
	//			//practice
	//	case 'PATIENT'
	//			//practice
	//	case 'PHONECOVERAGE'
	//			//practice
	//	case 'SERVICE'
	//			//practice
		case 'TAX'   //Start Code Change ----04.12.2011 #V11 maha 
				idw_cur_dw = idw_address
				ls_isg_table = 'PD_ADDRESS'
	//		//practice
		case 'HOSPITAL'
			idw_cur_dw = idw_hospital
			ls_isg_table = 'PD_HOSP_AFFIL'			
		case 'INSURANCE'
			idw_cur_dw = idw_insurance
			ls_isg_table = 'PD_INSURANCE'
		case 'WORKHISTORY'
			idw_cur_dw = idw_experience
			ls_isg_table = 'PD_PROF_EXPERIENCE'			
		case 'TIMEGAP'
			idw_cur_dw = idw_workgap
			ls_isg_table = 'PD_WORK_GAP'
		case 'REFERENCE'
			idw_cur_dw = idw_reference
			ls_isg_table = 'PD_REFERENCES'			
		case 'DISCLOSURE', 'PROVIDEROTHER'
			idw_cur_dw = idw_attest
			ls_isg_table = 'PD_ATTEST_QUESTIONS'			
		case 'PROVIDERCERTIFICATION'
			idw_cur_dw = idw_cpr
			ls_isg_table = 'pd_special_certs'			
		case 'MEDICALASSOCIATION'
			//???'			
		case 'MALPRACTICE'			
		case 'CLAIMSTATUS'
			idw_cur_dw = idw_claims
			ls_isg_table = 'PD_CLAIMS'			
		case 'PROVIDERADDRESS'
			idw_cur_dw = idw_address
			ls_isg_table = 'PD_ADDRESS'			
		//case 'PROVIDERDEA'
		case 'PROVIDERDEA', 'PROVIDERCDS'  //Bug 2653 - alfee 09.21.2011
			idw_cur_dw = idw_dea		
			ls_isg_table = 'PD_DEA_STATE_CSR'			
	 	//case 'PROVIDERIDENTIFIER' 		
		case else
			//messagebox("Table not found",as_table) 		
	end choose			
else
	//set current dw by ISG table name
	if left(lower(as_table),4) = 'dba.' then as_table = mid(as_table, 5) //alfee 11.04.2010	
	choose case upper(as_table)
		case 'PD_BASIC'
			idw_cur_dw = idw_basic
		case 'PD_LANGUAGES'
			idw_cur_dw = idw_language
		case 'PD_OTHER_IDS'
			idw_cur_dw = idw_oids
		case 'PD_LICENSE'	
			idw_cur_dw = idw_license
		case 'PD_EDUCATION'
			idw_cur_dw = idw_education
		case 'PD_BOARD_SPECIALTY'
			idw_cur_dw = idw_specialty
		case 'PD_ADDRESS'
			idw_cur_dw = idw_address
		case 'PD_HOSP_AFFIL'
			idw_cur_dw = idw_hospital
		case 'PD_INSURANCE'
			idw_cur_dw = idw_insurance
		case 'PD_PROF_EXPERIENCE'
			idw_cur_dw = idw_experience
		case 'PD_WORK_GAP'
			idw_cur_dw = idw_workgap
		case 'PD_REFERENCES'
			idw_cur_dw = idw_reference
		case 'PD_ATTEST_QUESTIONS'
			idw_cur_dw = idw_attest
		case 'PD_CLAIMS'
			idw_cur_dw = idw_claims
		case 'PD_DEA_STATE_CSR'
			idw_cur_dw = idw_dea
		case 'PD_ECFMG'
			idw_cur_dw = idw_ecfmg
		case 'PD_TRAINING' //Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
			idw_cur_dw = idw_training
		case else
			return ""
	end choose
	ls_isg_table = as_table
end if

is_cur_isg_table = ls_isg_table//Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)

return ls_isg_table	

//choose case upper(as_table)
//	case 'PD_BASIC'
//		idw_cur_dw = idw_basic
//	case 'PD_LANGUAGES'
//		idw_cur_dw = idw_language
//	case 'PD_OTHER_IDS'
//		idw_cur_dw = idw_oids
//	case 'PD_LICENSE'	
//		idw_cur_dw = idw_license
//	case 'PD_EDUCATION'
//		idw_cur_dw = idw_education
//	case 'PD_BOARD_SPECIALTY'
//		idw_cur_dw = idw_specialty
//	case 'PD_ADDRESS'
//		idw_cur_dw = idw_address
//	case 'PD_HOSP_AFFIL'
//		idw_cur_dw = idw_hospital
//	case 'PD_INSURANCE'
//		idw_cur_dw = idw_insurance
//	case 'PD_PROF_EXPERIENCE'
//		idw_cur_dw = idw_experience
//	case 'PD_WORK_GAP'
//		idw_cur_dw = idw_workgap
//	case 'PD_REFERENCES'
//		idw_cur_dw = idw_reference
//	case 'PD_ATTEST_QUESTIONS'
//		idw_cur_dw = idw_attest
//	case 'PD_CLAIMS'
//		idw_cur_dw = idw_claims
//	case 'PD_DEA_STATE_CSR'
//		idw_cur_dw = idw_dea
//	case 'PD_ECFMG'
//		idw_cur_dw = idw_ecfmg
//end choose
//
//if idw_cur_dw.rowcount( ) = 0 then idw_cur_dw.insertrow(1) 
//
//return 1

end function

public function integer of_set_item (string as_type, long al_row, string as_field, string as_value);//set value to the field in the current dw - (caqh 2)alfee 12.18.2009

return of_set_item(idw_cur_dw, as_type, al_row, as_field, as_value)


end function

public function integer of_set_item (datawindow adw, string as_type, long al_row, string as_field, string as_value);//caqh 2: set value to the field - alfee 12.18.2009

string ls_value_ori
string ls_new_value, ls_old_value ='' //Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
string ls_prac_name
string ls_fieldtype  //maha 05.30.2017
datetime ldt_value, ldt_value_ori
long ll_value, ll_value_ori
long ll_row
long ll_table_id
long ll_cur_rec_id
long ll_len  //maha 05.30.2017
string ls_cur_audit_type, ls_find

if IsNull(al_row) or al_row < 1 or al_row > adw.rowcount() then return 0
if IsNull(as_type) or LenA(as_type) < 1 then return 0
if IsNull(as_field) or LenA(as_field) < 1 then return 0

//skip to set a null value 
if IsNull(as_value) then return 0

//Start Code Change ----04.25.2014 #V14.2 maha

//Start Code Change ----05.30.2017 #V154 maha - error trap for overlong strings
ls_fieldtype = adw.Describe( as_field + ".ColType")
//if adw.Describe( as_field + ".ColType") = "!" then return 0
//if adw.Describe( ls_fieldtype) = "!" then return 0
if ls_fieldtype = "!" then return 0  //Start Code Change ----05.07.2017 #V154 maha

if left( ls_fieldtype ,3) = "cha" or left( ls_fieldtype, 3) = "var" then
	 ll_len = long(of_strip_char("", ls_fieldtype,"@NUM@" ))
	 if len(as_value) > ll_len then  
		as_value = midA(as_value, 1, ll_len)
	end if
end if
//End Code Change ----05.30.2017

ls_new_value = as_value //Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)

if not ib_update then
	//for a new practitioner
	choose case as_type
		case "C"
			adw.setitem(al_row, as_field, as_value )
		case "D"
			ldt_value = of_str2dt(as_value)
			adw.setitem(al_row, as_field,ldt_value )
		case "N","I", "V"
			if Not IsNumber(as_value) then return -1 //alfee 05.05.2014
			ll_value = long(as_value)
			adw.setitem(al_row, as_field,ll_value )
	end choose	 
else
	//for an existing practitioner
	choose case as_type
	case "C"
		ls_value_ori = adw.GetItemString(al_row, as_field)
		if IsNull(ls_value_ori) or ls_value_ori <> as_value then 
			adw.setitem(al_row, as_field, as_value )
		end if
		
		ls_old_value = String(ls_value_ori)//Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
	case "D"
		ldt_value = of_str2dt(as_value)
		ldt_value_ori = adw.GetItemDatetime(al_row, as_field)
		if IsNull(ldt_value_ori) or ldt_value_ori <> ldt_value then 		
			adw.setitem(al_row, as_field,ldt_value )	
		end if
		
		ls_new_value = String(ldt_value)//Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
		ls_old_value = String(ldt_value_ori)//Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
	case "N","I", "V"
		if Not IsNumber(as_value) then return -1 //alfee 05.05.2014
		ll_value = long(as_value)
		ll_value_ori = adw.GetItemNumber(al_row, as_field)
		if IsNull(ll_value_ori) or ll_value_ori <> ll_value then 				
			adw.setitem(al_row, as_field,ll_value )
		end if
		ls_new_value = String(ll_value)//Added by Appeon long.zhang 04.15.2015 (v15.1 CAQH Import Data Approval)
		ls_old_value = String(ll_value_ori)//Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
	end choose	 
end if

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.25.2015
//<$>reason:Set idw_log_items, v15.1 CAQH Import Data Approval
If ib_approval_flag and adw = idw_cur_dw Then
	as_field = lower(as_field)
	
	//of_set_currow has been executed before this
	ll_table_id =  long(of_get_currow_value(is_cur_isg_table, 'table_id'))
	ls_cur_audit_type = String(of_get_currow_value(is_cur_isg_table, 'cur_audit_type'))
	ll_cur_rec_id = long(of_get_currow_value(is_cur_isg_table, 'cur_rec_id'))
	ls_find = 'table_id = ' + string(ll_table_id) + ' and audit_type = "' +  ls_cur_audit_type + '" and seq_no = ' + string(ll_cur_rec_id) +&
	' and Field_name = "' + as_field +'"'
	
	ll_row = idw_log_items.find(ls_find, 1 ,idw_log_items.rowcount() )
	If ll_row < 1 Then 
		ll_row = idw_log_items.insertrow(0)
		
		idw_log_items.setitem(ll_row,"table_id", ll_table_id) 
		idw_log_items.setitem(ll_row,"Seq_no", ll_cur_rec_id) 
		idw_log_items.setitem(ll_row,"Audit_type", ls_cur_audit_type) 
		idw_log_items.setitem(ll_row,"Field_name", as_field) 
		idw_log_items.setitem(ll_row,"old_value", ls_old_value) 
		idw_log_items.setitem(ll_row,"new_value", ls_new_value) 
	Else
		ls_old_value =  idw_log_items.getitemstring(ll_row,"old_value")
		idw_log_items.setitem(ll_row,"new_value", ls_new_value) 
	End If
	
	//value_changed flag
	//If ls_cur_audit_type = 'NW'  or (ls_old_value <> ls_new_value) Then
	If ls_cur_audit_type = 'NW'  &
		or (ls_old_value <> ls_new_value or (IsNull(ls_old_value) AND Not IsNull(ls_new_value)) ) Then //Modified by Appeon long.zhang 08.12.2016 (Bug id 5287 - CAQH Import not brinng Attest Questions Answers in)
		idw_log_items.setitem(ll_row,"value_changed", 1) 
		idw_log_items.setitem(ll_row,"status", 0) //to be accepted
	Else
		idw_log_items.setitem(ll_row,"value_changed", 0) 
		idw_log_items.setitem(ll_row,"status", 1) //accepted
	End If	
End if

//------------------- APPEON END -------------------

return 1
end function

public function integer of_move_training_records ();//move training records to Training dw - (caqh 2)alfee 12.18.2009

long e, i, j, ll_find, ll_existing_row
long ll_train_type, ll_tentity, ll_lu_code 
long ll_found_temp //alfee 04.30.2014
long ll_null  //maha 02.23.2017
string ls_cust_1, ls_edu_desc, ls_train_desc, ls_type
string ls_cond, ls_entity_name, ls_entity_name_new, ls_street1,ls_isg_table
string ls_training_lookup  //maha 10.19.2015
string ms
datastore lds_addr_lu

setnull(ll_null)   //Start Code Change ----02.23.2017 #V153 maha
 
if idw_education.rowcount() < 1 then return 0

lds_addr_lu = create datastore
lds_addr_lu.dataobject = 'd_address_lookup_caqh'
lds_addr_lu.SetTransObject(sqlca)

 //Start Code Change ----10.29.2015 #V15 maha
select lookup_code into :ls_training_lookup from sys_fields where field_id = 251;  
if isnull(ls_training_lookup) or len(ls_training_lookup) < 1 then ls_training_lookup = "Training" 
 //End Code Change ----10.29.2015

//move training data
for e = idw_education.rowcount() to 1 step -1
	ls_cust_1 = idw_education.getitemstring(e,"cust_1")
	if IsNull(ls_cust_1) or LeftA(ls_cust_1, 3) <> "T##" then 
		idw_education.SetItem(e, 'major', ll_null)   //Start Code Change ----02.23.2017 #V153 maha - clear the major field which is used for training specialty
		continue
	end if

	//set current dw, Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
	ls_isg_table = 'PD_TRAINING'
	of_set_table(ls_isg_table, 'ISG')

	if ib_update and idw_training.RowCount() > 0 then 
		//existing practitioner with training records
		ls_edu_desc = Upper(MidA(ls_cust_1, 4)) //description of education type
		for i = 1 to idw_training.RowCount() 
			ll_train_type = idw_training.GetItemNumber(i, "train_type") //as a caqh ref field
			ls_train_desc = gnv_data.of_getitem('code_lookup', 'description', "lookup_code = " + string(ll_train_type))
			if ls_edu_desc = Upper(ls_train_desc) then //update record if found
				ls_entity_name = of_get_entity_name(idw_training.GetItemNumber(i, 'institution_code'))
				ls_entity_name_new = of_get_entity_name(idw_education.GetItemNumber(e, 'school_code'))
				
				of_set_currow(ls_isg_table, i) //Keep current row no in a datastore, Added by Appeon long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)

				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 03.25.2015
				//<$>reason:don't need to use idw_training argument, v15.1 CAQH Import Data Approval
				if upper(ls_entity_name) <> upper(ls_entity_name_new) then //compare entity name
					//of_set_item(idw_training,'N', i, 'institution_code', String(idw_education.GetItemNumber(e, 'school_code')))
					of_set_item('N', i, 'institution_code', String(idw_education.GetItemNumber(e, 'school_code')))
				end if		
//				of_set_item(idw_training,'D', i, 'start_date', String(idw_education.GetItemDateTime(e, 'start_date')))
//				of_set_item(idw_training,'D', i, 'end_date', String(idw_education.GetItemDateTime(e, 'end_date')))					
//				of_set_item(idw_training,'N', i, 'internship_code', String(idw_education.GetItemNumber(e, 'degree')))
				of_set_item('D', i, 'start_date', String(idw_education.GetItemDateTime(e, 'start_date')))
				of_set_item('D', i, 'end_date', String(idw_education.GetItemDateTime(e, 'end_date')))					
				of_set_item('N', i, 'internship_type_code', String(idw_education.GetItemNumber(e, 'degree')))
				//------------------- APPEON END -------------------
//				ms = idw_education.GetItemString(e, 'major')
//				messagebox("Major",ms)
//				of_set_item('N', i, 'specialty', ms)  //Start Code Change ----02.23.2017 #V153 maha - set specialty
				exit	//exit loop				
			end if
		next
		
		if i = idw_training.RowCount() + 1 then //add record if not found	
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 03.25.2015
			//<$>reason:use of_set_item for recording the log items, v15.1 CAQH Import Data Approval
			//idw_education.rowscopy(e, e, primary!, idw_training ,1000, primary!)
			i = idw_training.insertrow(0)
			of_set_currow(ls_isg_table, i)
			of_set_item('N', i, 'train_type', String(idw_education.GetItemNumber(e, 'education_type')))	
			of_set_item('N', i, 'institution_code', String(idw_education.GetItemNumber(e, 'school_code')))	
			of_set_item('D', i, 'start_date', String(idw_education.GetItemDateTime(e, 'start_date')))
			of_set_item('D', i, 'end_date', String(idw_education.GetItemDateTime(e, 'end_date')))					
			of_set_item('N', i, 'internship_type_code', String(idw_education.GetItemNumber(e, 'degree')))	
			//------------------- APPEON END -------------------	
		end if		
	else 
		//new practitioner or no training records
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 03.25.2015
		//<$>reason:use of_set_item for recording the log items, v15.1 CAQH Import Data Approval
		//idw_education.rowscopy(e, e, primary!, idw_training ,1000, primary!)
		i = idw_training.insertrow(0)
		of_set_currow(ls_isg_table, i)
		of_set_item('N', i, 'train_type', String(idw_education.GetItemNumber(e, 'education_type')))	
		of_set_item('N', i, 'institution_code', String(idw_education.GetItemNumber(e, 'school_code')))	
		of_set_item('D', i, 'start_date', String(idw_education.GetItemDateTime(e, 'start_date')))
		of_set_item('D', i, 'end_date', String(idw_education.GetItemDateTime(e, 'end_date')))					
		of_set_item('N', i, 'internship_type_code', String(idw_education.GetItemNumber(e, 'degree')))	
		//------------------- APPEON END -------------------				
	end if
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 03.25.2015
	//<$>reason:use of_delete_item for recording the log items, v15.1 CAQH Import Data Approval
	//discard training row in education dw
	//idw_education.rowsdiscard(e, e, primary!)	
	ls_isg_table = 'PD_EDUCATION'
	of_set_table(ls_isg_table, 'ISG')
	of_set_currow(ls_isg_table, e)
	of_discard_item( e )	
	//------------------- APPEON END -------------------		
next
	
	
//move lookup data
for e = 1 to idw_training.rowcount()
	
	//train_type
	if idw_training.getitemstatus(e, "train_type", primary!) = DataModified! then		
		ll_train_type = idw_training.getitemnumber(e,"train_type")
		ll_find = idw_code_lookup.find( "lookup_code = " + string(ll_train_type), 1, idw_code_lookup.rowcount())
		if ll_find > 0 then
			//change lookup name
			idw_code_lookup.setitem(ll_find,"lookup_name","Training Type")
			//determine if it's already existed in the lookup table		
			ls_train_desc = Upper(idw_code_lookup.getitemstring(ll_find, "description"))
			ls_train_desc = inv_string.of_globalreplace(ls_train_desc, "'", "~~'")			
			ls_cond = "Lookup_name = 'Training Type' and Upper(description) = '" + ls_train_desc + "'"
			ll_lu_code = Long(gnv_data.of_getitem('code_lookup', 'lookup_code', ls_cond))
			if ll_lu_code > 0 then
				//skip to add it if duplicate
				//---------Begin Modified by (Appeon)Alfee 04.30.2014 -----------------
				ll_found_temp =  idw_education.find ("education_type = " + String(ll_train_type), 1,  idw_education.rowcount())
				if ll_found_temp < 1 then idw_code_lookup.rowsdiscard(ll_find, ll_find, primary!)		
				//idw_code_lookup.rowsdiscard(ll_find, ll_find, primary!)
				//---------End Modfiied ------------------------------------------------------
				
				//adjust the lookup code in the current dw		
				if ll_train_type <> ll_lu_code then
					//----Begin Modified by alfee 07.21.2010 -----------------------
					for i = 1 to idw_training.rowcount()
						if ll_train_type = idw_training.GetItemNumber(i,"train_type") then
							//------------------- APPEON BEGIN -------------------
							//<$>added:long.zhang 03.26.2015
							//<$>reason:v15.1 CAQH Import Data Approval
						
							//idw_training.Setitem(i, "train_type", ll_lu_code)	
							ls_isg_table = 'PD_TRAINING'
							of_set_table(ls_isg_table, 'ISG')
							of_set_currow(ls_isg_table,i)
							of_set_item('N', i, 'train_type', String(ll_lu_code))	
							//------------------- APPEON END -------------------		
						end if						
					next
					//idw_training.Setitem(e, "train_type", ll_lu_code)							
					//-----End Modified --------------------------------------------	
				end if					
			end if		
		end if
	end if

	//institution_code
	if idw_training.getitemstatus(e, "institution_code", primary!) = DataModified! then
		ll_tentity = idw_training.getitemnumber(e,"institution_code")	
		ll_find = idw_address_lookup.find( "lookup_code = " + string(ll_tentity), 1, idw_address_lookup.rowcount())
		if ll_find > 0 then
			//--------Begin Added (for Bug 4241) by alfee 09.29.2014 -----------------------
			//for the case that the education and traning are at the same institution
			ll_found_temp =  idw_education.find ("school_code = " + String(ll_tentity), 1,  idw_education.rowcount())
			if ll_found_temp > 0 then 
				//duplicate a all_findddress  lookup record for training
				idw_address_lookup.rowscopy(ll_find, ll_find, primary!, idw_address_lookup, idw_address_lookup.rowcount() + 1,  primary!)	
				ll_find =  idw_address_lookup.rowcount()
				ll_lu_code = gnv_app.of_get_id( "LOOKUP" )
				idw_address_lookup.SetItem(ll_find, "lookup_code", ll_lu_code)
				idw_address_lookup.SetItem(ll_find, "code", String(ll_lu_code))
				//adjust lookup code in the training table
				for i = 1 to idw_training.rowcount()
						if ll_tentity = idw_training.GetItemNumber(i,"institution_code") then				
							//------------------- APPEON BEGIN -------------------
							//<$>added:long.zhang 03.26.2015
							//<$>reason:v15.1 CAQH Import Data Approval
						
							//idw_training.SetItem(i, "institution_code", ll_lu_code)	
							ls_isg_table = 'PD_TRAINING'
							of_set_table(ls_isg_table, 'ISG')
							of_set_currow(ls_isg_table,i)
							of_set_item('N', i, 'institution_code', String(ll_lu_code))	
							//------------------- APPEON END -------------------	
						end if						
				next
				ll_tentity = ll_lu_code
			end if
			//--------End Added -------------------------------------------------------------------				
			//change lookup name
			 //Start Code Change ----10.29.2015 #V15 maha - changed coded reference to Training to variable
			//idw_address_lookup.setitem(ll_find,"lookup_name","Training") 
			idw_address_lookup.setitem(ll_find,"lookup_name",ls_training_lookup ) 
	
			//determine if it's already existed in the lookup table
			//if lds_addr_lu.rowcount() < 1 then lds_addr_lu.retrieve("Training")
			if lds_addr_lu.rowcount() < 1 then lds_addr_lu.retrieve(ls_training_lookup)
			ls_entity_name = Upper(idw_address_lookup.getitemstring(ll_find, "entity_name"))
			ls_entity_name = inv_string.of_globalreplace(ls_entity_name, "'", "~~'")				
			//--------Begin Modified by alfee 07.21.2010 -----------------------
			ls_street1 = Upper(Trim(idw_address_lookup.getitemstring(ll_find, "street1")))
			ls_street1 = inv_string.of_globalreplace(ls_street1, "'", "~~'")	
			ls_cond = "lookup_name = '" + ls_training_lookup + "' and Upper(entity_name) = '" + ls_entity_name + "' and Upper(trim(street1)) = '" + ls_street1 + "'"
			//End Code Change ----10.29.2015
			//ls_cond = "lookup_name = 'Training' and Upper(entity_name) = '" + ls_entity_name + "'"			
			//--------End Modified ----------------------------------------------
			ll_existing_row = lds_addr_lu.find(ls_cond, 1, lds_addr_lu.rowcount())
			if ll_existing_row > 0 then
				//skip to add it if duplicate 
				//---------Begin Modified by (Appeon)Alfee 04.30.2014---------------------------
				ll_found_temp =  idw_education.find ("school_code = " + String(ll_tentity), 1,  idw_education.rowcount())
				if ll_found_temp < 1 then idw_address_lookup.rowsdiscard(ll_find, ll_find, primary!)
				//idw_address_lookup.rowsdiscard(ll_find, ll_find, primary!)
				//---------End Modfiied ---------------------------------------------------------------		
				
				//adjust the lookup code in the current dw
				ll_lu_code = lds_addr_lu.GetItemNumber(ll_existing_row, "lookup_code")
				if ll_tentity <> ll_lu_code then
					//----Begin Modified by alfee 07.21.2010 -----------------------
					for i = 1 to idw_training.rowcount()
						if ll_tentity = idw_training.GetItemNumber(i,"institution_code") then
							//------------------- APPEON BEGIN -------------------
							//<$>added:long.zhang 03.26.2015
							//<$>reason:v15.1 CAQH Import Data Approval
						
							//idw_training.Setitem(i, "institution_code", ll_lu_code)	
							ls_isg_table = 'PD_TRAINING'
							of_set_table(ls_isg_table, 'ISG')
							of_set_currow(ls_isg_table,i)
							of_set_item('N', i, 'institution_code', String(ll_lu_code))	
							//------------------- APPEON END -------------------	
						end if						
					next
					//idw_training.Setitem(e, "institution_code", ll_lu_code)						
					//-----End Modified --------------------------------------------
				end if			
			end if		
		end if	
	end if
	
next

destroy lds_addr_lu

return 1
end function

public function integer of_refresh_lu_cache ();//Refresh cache of lookup data after each update - (caqh 2)alfee 12.18.2009

long i, ll_row

gnv_appeondb.of_startqueue( )
gnv_data.of_retrieve("code_lookup")
ids_questions.retrieve(ii_verif )
gnv_appeondb.of_commitqueue( )

for i = 1 to idw_address_lookup.rowcount()
	ll_row = ids_address_lookup.insertrow(0)
	ids_address_lookup.SetItem(ll_row, "lookup_code", idw_address_lookup.GetItemNumber(i, "lookup_code"))
	ids_address_lookup.SetItem(ll_row, "lookup_name", idw_address_lookup.GetItemString(i, "lookup_name"))	
	ids_address_lookup.SetItem(ll_row, "code", idw_address_lookup.GetItemString(i, "code"))
	ids_address_lookup.SetItem(ll_row, "entity_name", idw_address_lookup.GetItemString(i, "entity_name"))
	ids_address_lookup.SetItem(ll_row, "street1", idw_address_lookup.GetItemString(i, "street1"))
	ids_address_lookup.SetItem(ll_row, "street2", idw_address_lookup.GetItemString(i, "street2"))	
	ids_address_lookup.SetItem(ll_row, "city", idw_address_lookup.GetItemString(i, "city"))
	ids_address_lookup.SetItem(ll_row, "state", idw_address_lookup.GetItemString(i, "state"))	
	ids_address_lookup.SetItem(ll_row, "zip", idw_address_lookup.GetItemString(i, "zip"))
	ids_address_lookup.SetItem(ll_row, "phone", idw_address_lookup.GetItemString(i, "phone"))
	ids_address_lookup.SetItem(ll_row, "fax", idw_address_lookup.GetItemString(i, "fax"))
	ids_address_lookup.SetItem(ll_row, "email_address", idw_address_lookup.GetItemString(i, "email_address"))		
	ids_address_lookup.SetItem(ll_row, "contact_name", idw_address_lookup.GetItemString(i, "contact_name"))
	ids_address_lookup.SetItem(ll_row, "caqh_code", idw_address_lookup.GetItemNumber(i, "caqh_code"))		
next

return 1
end function

public function long of_get_rec_id ();//CAQH 2: Get rec id - alfee 12.18.2009

integer t, c, r, lc
long ll_rec
datawindow ldw_1
dwitemstatus l_status


//Get row count (new records only) for each dw
for t = 1 to 17
	choose case t
		case 1
			ldw_1 = idw_basic
		case 2
			ldw_1 = idw_license
		case 3
			ldw_1 = idw_oids
		case 4
			ldw_1 = idw_education
		case 5	
			ldw_1 = idw_specialty
		case 6
			ldw_1 = idw_language
		case 7
			ldw_1 = idw_address
		case 8
			ldw_1 = idw_hospital
		case 9
			ldw_1 = idw_insurance
		case 10
			ldw_1 = idw_experience
		case 11
			ldw_1 = idw_workgap
		case 12
			ldw_1 = idw_reference
		case 13
			ldw_1 = idw_attest
		case 14
			ldw_1 = idw_claims
		case 15
			ldw_1 = idw_dea
		case 16
			ldw_1 = idw_ecfmg
		case 17
			ldw_1 = idw_appointment
	end choose
	
	c = ldw_1.rowcount()
	for r = 1 to c
		l_status = ldw_1.GetItemStatus(r, 0, primary!)
		if l_status = newmodified! or (l_status = new! and t = 17) then 
			lc ++		
		end if
	next
next

ll_rec = gnv_app.of_get_id( "RECORD_ID", lc )

RETURN ll_rec

end function

public function integer of_app_audit_update (long al_de_recid, long al_prac, long al_screen, string as_ref);//Update fax_message in app_audit table - (caqh 2)alfee 12.18.2009

long i, ll_found, ll_cnt
string ls_find, ls_screen_name, ls_fax_msg, ls_new_msg

if IsNull(al_de_recid) or IsNull(al_prac) then return 0
if IsNull(as_ref) or LenA(as_ref) < 1 then return 0

ll_cnt = idw_app_audit.rowcount()
if ll_cnt < 1 then return 0

ls_find = "prac_id = " + string(al_prac) + " and de_rec_id = " + string(al_de_recid)
ll_found = idw_app_audit.Find(ls_find, 1, ll_cnt)
if ll_found > 0 then
	ls_fax_msg = idw_app_audit.GetItemString(ll_found, "fax_message")
	ls_screen_name = of_get_screen_name(al_screen)
	ls_new_msg = MidA(ls_screen_name,1,5) + "-" + as_ref
	if ls_new_msg <> ls_fax_msg then
		idw_app_audit.SetItem(ll_found, "fax_message", ls_new_msg)
	end if		
end if

return 1
end function

public function integer of_update_data_bk ();//CAQH 2: for backup only - alfee 12.18.2009

return 1

//long ll_rec
//long i
//long ic
//long t
//long e
//long ll_fac
//long ll_app_stat_id
//long ll_ttype
//long ll_tentity
//long ll_title
//integer c
//integer res
//integer li_find
//integer rc
//integer nr
//string ls_type
//string ls_reference
//string ls_test
//integer li_linkp
//integer li_linka
//integer li_linkm
//integer li_screen
//integer li_table
//boolean lb_verify
//datawindow ldw_audit  //used as argument but not really exists
//
////Start Code Change ----11.17.2009 #V92 maha
//ls_test = idw_basic.getitemstring(1,"last_name")
//if isnull(ls_test) or ls_test = "" then
//	return -1
//end if
////End Code Change---11.17.2009
//
////get the number of total records and get the rec id
//if ib_title then		//Start Code Change ----08.17.2009 #V92 maha
//	ll_title =  long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Title' and code = 'Dr.'"))
//	if gi_test_mode = 1 then messagebox("Title - Dr. value",ll_title)//Start Code Change ----10.20.2009 #V10 maha
//	if ll_title = 0 then setnull(ll_title)//Start Code Change ----10.20.2009 #V10 maha
//end if
//
//for t = 1 to 17
//	choose case t
//		case 1
//			c = idw_basic.rowcount()
//		case 2
//			c = idw_license.rowcount()
//		case 3
//			c = idw_oids.rowcount()
//		case 4
//			c = idw_education.rowcount()
//		case 5	
//			c = idw_specialty.rowcount()
//		case 6
//			c = idw_language.rowcount()
//		case 7
//			c = idw_address.rowcount()
//		case 8
//			c = idw_hospital.rowcount()
//		case 9
//			c = idw_insurance.rowcount()
//		case 10
//			c = idw_experience.rowcount()
//		case 11
//			c = idw_workgap.rowcount()
//		case 12
//			c = idw_reference.rowcount()
//		case 13
//			c = idw_attest.rowcount()
//		case 14
//			c = idw_claims.rowcount()
//		case 15
//			c = idw_dea.rowcount()
//		case 16
//			c = idw_ecfmg.rowcount()
//		case 17
//			c = idw_appointment.rowcount()
//	end choose
//	ic = ic + c
//next
//
//ll_rec = gnv_app.of_get_id( "RECORD_ID",ic )
//
//if idw_education.rowcount() > 0 then
//	//debugbreak()
//	for e =  idw_education.rowcount() to 1 step -1
//		if idw_education.getitemstring(e,"cust_1") = "T" then  //copy the training records to the training dw
//			 idw_education.rowscopy( e, e, primary!, idw_training ,1000, primary!)
//			 idw_education.rowsdiscard( e,  e, primary!)
//		end if
//	next
//	for e = 1 to idw_training.rowcount()
//		ll_ttype = idw_training.getitemnumber(e,"train_type")
//		ll_tentity = idw_training.getitemnumber(e,"institution_code")	
//		 li_find = idw_code_lookup.find( "lookup_code = " + string(ll_ttype), 1, idw_code_lookup.rowcount())
//		 if li_find > 0 then
//			idw_code_lookup.setitem(li_find,"lookup_name","Training Type")
//		end if
//		 //li_find = idw_address_lookup.find( "lookup_code = " + string(ll_tentity), 1, idw_code_lookup.rowcount())
//		 li_find = idw_address_lookup.find( "lookup_code = " + string(ll_tentity), 1, idw_address_lookup.rowcount()) //alfee 09.24.2009		 
//		 if li_find > 0 then
//			//idw_code_lookup.setitem(li_find,"lookup_name","Training Type")
//			idw_address_lookup.setitem(li_find,"lookup_name","Training") //alfee 08.19.2009
//		end if
//	next
//end if
//
////for each new record set the rec and prac ids
//for t = 1 to 18
//	choose case t  //set the datawindow to update and get row count
//		case 1
//			c = idw_basic.rowcount()
//			idw_cur_dw = idw_basic
//			ls_type = "N"
//			li_screen =1	
//			li_table = 25
//			ll_fac = 0
//			
//		case 2
//			c = idw_appointment.rowcount()
//			idw_cur_dw = idw_appointment
//			ls_type = "N"
//			li_screen = 43
//			li_table = 43
//			ll_fac = ii_parent
//		case 3
//			c = idw_license.rowcount()
//			idw_cur_dw = idw_license
//			ls_type = "N"
//			li_screen =4	
//			li_table = 22
//			ll_fac = 0
//			
//		case 4
//			c = idw_oids.rowcount()
//			idw_cur_dw = idw_oids
//			ls_type = "N"
//			li_screen = 23	
//			li_table = 13
//			ll_fac = 0			
//		case 5
//			c = idw_education.rowcount()
//			idw_cur_dw = idw_education
//			ls_type = "N"
//			li_screen = 6		
//			li_table = 8
//			ll_fac = 0			
//		case 6	
//			c = idw_specialty.rowcount()
//			idw_cur_dw = idw_specialty
//			ls_type = "S"
//			li_screen =19		
//			li_table = 2
//			ll_fac = 0			
//		case 7
//			c = idw_language.rowcount()
//			idw_cur_dw = idw_language
//			ls_type = "N"
//			li_screen =25
//			li_table = 21
//			ll_fac = 0			
//		case 8
//			c = idw_address.rowcount()
//			idw_cur_dw = idw_address
//			ls_type = "A"
//			li_screen =2			
//			li_table = 20
//			ll_fac = 0			
//		case 9
//			c = idw_hospital.rowcount()
//			idw_cur_dw = idw_hospital
//			ls_type = "H"
//			li_screen = 10			
//			li_table = 9
//			ll_fac = 0			
//		case 10
//			c = idw_insurance.rowcount()
//			idw_cur_dw = idw_insurance
//			ls_type = "N"
//			li_screen =15
//			li_table = 10
//			ll_fac = 0
//			
//		case 11
//			c = idw_experience.rowcount()
//			idw_cur_dw = idw_experience
//			ls_type = "N"
//			li_screen = 12
//			li_table = 14
//			ll_fac = 0
//			
//		case 12
//			c = idw_workgap.rowcount()
//			idw_cur_dw = idw_workgap
//			ls_type = "N"
//			li_screen = 55
//			li_table = 55
//			ll_fac = 0
//			
//		case 13
//			c = idw_reference.rowcount()
//			idw_cur_dw = idw_reference
//			ls_type = "N"
//			li_screen = 13
//			li_table = 23
//			ll_fac = 0
//			
//		case 14
//			c = idw_attest.rowcount()
//			idw_cur_dw = idw_attest
//			ls_type = "N"
//			li_screen = 65
//			li_table = 65
//			ll_fac = ii_parent
//			
//		case 15
//			c = idw_claims.rowcount()
//			idw_cur_dw = idw_claims
//			ls_type = "N"
//			li_screen =16		
//			li_table = 24
//			ll_fac = 0
//			
//		case 16
//			c = idw_dea.rowcount()
//			idw_cur_dw = idw_dea
//			ls_type = "N"
//			li_screen = 5
//			li_table = 6
//			ll_fac = 0
//			
//		case 17
//			c = idw_ecfmg.rowcount()
//			idw_cur_dw = idw_ecfmg
//			ls_type = "N"
//			li_screen = 20
//			li_table = 7
//			ll_fac = 0
//			
//		case 18 //training
//			c = idw_training.rowcount()
//			idw_cur_dw = idw_training
//			ls_type = "N"
//			li_screen = 7
//			li_table = 19
//			ll_fac = 0
//	end choose
//	
//	//check for verif creation
//	ids_rules.setfilter("screen_id = " + string(li_screen))
//	ids_rules.filter()
//	//ids_refs.retrieve(1,li_screen) //Start Code Change ----07.20.2009 #V92 maha - moved retrieve to constructor event
//	
//	lb_verify = False
//	if ids_rules.rowcount() > 0 then
//		if ids_rules.getitemstring(1,"verify_data") = "I" or ids_rules.getitemstring(1,"verify_data") = "B" and li_screen <> 1 then	
//			lb_verify = true
//		end if
//	end if
//	
//	//set the rec and prac ids
//	for i = 1 to c 
//		idw_cur_dw.setitem(i,"rec_id",ll_rec)
//		if t = 2 then //appointment
//			ll_app_stat_id = ll_rec
//		end if
//		idw_cur_dw.setitem(i,"prac_id",il_prac)
//		
//		//Start Code Change ----08.17.2009 #V92 maha
//		if t = 1 then //basic
//			if ib_title then idw_cur_dw.setitem(i,"title",ll_title  )
//			if ib_prov_id then idw_cur_dw.setitem(i,"provider_id", string(il_prov_id ))
//		end if
//		//End Code Change---08.17.2009
//		
//		if idw_cur_dw = idw_appointment then // appointment fields
//			idw_cur_dw.setitem(i,"parent_facility_id",ii_parent  )
//			idw_cur_dw.setitem(i,"application_audit_facility",ii_audit )
//			idw_cur_dw.setitem(i,"verifying_facility",ii_verif)
//			idw_cur_dw.setitem(i,"seq_no",1)
//			idw_cur_dw.setitem(i,"affiliation_status",is_affil )
//			idw_cur_dw.setitem(i,"apptmnt_type",is_type )
//			idw_cur_dw.setitem(i,"active_status",4)
//			//create committee records
//			//debugbreak()
//			rc = ids_committees.retrieve(ii_parent,il_prac)
//			if rc > 0 then
//				for e = 1 to rc
//					nr = idw_committees.insertrow(0)
//					idw_committees.setitem(nr,"rec_id",ll_app_stat_id)
//					idw_committees.setitem(nr,"prac_id",il_prac)
//					idw_committees.setitem(nr,"seq_no",nr)
//					idw_committees.setitem(nr,"committee_id",ids_committees.getitemnumber(e, "committee_lookup_committee_id") )
//					idw_committees.setitem(nr,"facility_id",ii_parent)
//					idw_committees.setitem(nr,"active_status",4)
//				next
//			end if
//		end if
//		
//		if t  =  14 then //attest quest set appointment
//			idw_cur_dw.setitem(i,"appt_stat_id",ll_app_stat_id )
//			idw_cur_dw.setitem(i,"active_status", 1)
//			idw_cur_dw.setitem(i,"facility_id",ii_parent  )
//		end if
//		
//		if t = 8  then
//			idw_cur_dw.setitem(i,"active_status", 1)
//		end if
//		//create links as needed
//		choose case ls_type
//			case "N"
//				//skip
//			case "A"
//				choose case i //set the first to primary
//					case 1
//						li_linkp= 1
//						li_linka = 0
//						li_linkm = 1
//					case else
//						li_linkp= 0
//						li_linka = 1
//						li_linkm = 0
//				end choose				
//				of_create_links ("A",ll_rec,ii_parent , il_prac, li_linkp,li_linka, li_linkm) 
//			case "H"
//				choose case i //set the first to primary
//					case 1
//						li_linkp= 581
//					case else
//						li_linkp= 582
//				end choose
//				of_create_links ("H",ll_rec,ii_parent , il_prac, li_linkp,0, 0) 
//			case "S"
//				li_linkp= 581
//				of_create_links ("S",ll_rec,ii_parent , il_prac, li_linkp,0, 0) 
//		end choose
//		
//		//create verification
//		ls_reference = of_get_reference( li_screen, i, idw_cur_dw)
//		if lb_verify = true then
//			of_verif_creation( ll_rec, il_prac, ii_verif , ls_reference, li_screen)	
//		end if
//		//create audit trail
//		of_audit_trail_add( ll_rec, il_prac, li_table, ls_reference, ll_fac)
//			
//		ll_rec++
//	next
//next
//
//ids_rules.setfilter("")
//ids_rules.filter()
//
////create app audit
//
//
//of_progress( 1200, "Saving Data")	
////save the data
////res = 1
//res = of_save()
//
//if res = 1 then
//	commit using sqlca;
//	inv_data_entry.of_app_audit_items_add( ii_parent , il_prac ,  ll_app_stat_id ,ii_audit,"Reapp",ldw_audit	, "I" )
//else //-1
//	rollback using sqlca;
//	messagebox("of_update_data","Data save failure for " + is_failed )
//end if
////turn on autocommit either way
//sqlca.autocommit = true
//
//return res
end function

private function long of_build_table (string as_table);//Build dw and return current row - CAQH 2: alfee 12.18.2009

return of_build_table(as_table, 'CAQH', 0)

end function

public function integer of_add_row_bk (string as_table);//caqh 2: for backup purpose only, commented by alfee 12.18.2009

//choose case as_table
//	case "basic"		
//		if idw_basic.rowcount( ) = 0 then 
//			idw_basic.insertrow(0) 
//		end if
//		//	idw_cur_dw = idw_basic
//	case "license"
//		idw_license.insertrow(0)
//	case "oids"
//		idw_oids.insertrow(0)		
//	case "language"
//		idw_language.insertrow(0)
//	case "specialty"
//		idw_specialty.insertrow(0)
//	case "address"
//		idw_address.insertrow(0)
//	case "hospital"
//		idw_hospital.insertrow(0)
//	case "insurance"
//		idw_insurance.insertrow(0)
//	case "experience"
//		idw_experience.insertrow(0)
//	case "workgap"
//		idw_workgap.insertrow(0)
//	case "reference"
//		idw_reference.insertrow(0)
//	case "attest"
//		idw_attest.insertrow(0)
//	case "claims"
//		idw_claims.insertrow(0)
//	case "education"
//		idw_education.insertrow(0)
//	case "dea"	
//		idw_dea.insertrow(0)
//	case "appt"
//		idw_appointment.insertrow(0)
//	case "cpr" //really special certs
//		idw_cpr.insertrow(0)
//		
//end choose
//of_progress( 100, "Adding " + as_table + " record.")

return 1
end function

public function integer of_audit_trail_add (datawindow adw);//create new audit records - called from of_update_data
//CAQH 2: reconstructed by alfee 12.18.2009

string ls_Syntax
string ls_ErrorText
integer li_Return = 1
DataStore lds_Data

//Dynamic create datawindow
lds_Data = Create DataStore
ls_Syntax = adw.object.datawindow.syntax
lds_Data.Create(ls_Syntax, ls_ErrorText)
adw.ShareData(lds_Data)

//Execute field audit
inv_data_entry.ib_caqh_import = TRUE //set caqh flag
li_Return = inv_data_entry.of_field_audit(lds_Data, ls_ErrorText)
Destroy lds_Data
//if li_Return = -1 then MessageBox("", ls_ErrorText)

Return li_Return

//long ll_insertrow
//
//ll_InsertRow = idw_audit_trail.InsertRow(0)
//idw_audit_trail.SetItem(ll_InsertRow, "rec_id", al_rec_id)
//idw_audit_trail.SetItem(ll_InsertRow, "prac_id", al_prac_id)
//idw_audit_trail.SetItem(ll_InsertRow, "seq_no", 1)
//idw_audit_trail.SetItem(ll_InsertRow, "table_id", ai_table)
//idw_audit_trail.SetItem(ll_InsertRow, "field_id", 1000)
//idw_audit_trail.SetItem(ll_InsertRow, "new_value", as_reference	)
//idw_audit_trail.SetItem(ll_InsertRow, "user_id", gs_user_id )
//idw_audit_trail.SetItem(ll_InsertRow, "audit_type", "X")					
//idw_audit_trail.SetItem(ll_InsertRow, "date_time_modified", DateTime(Today(), Now()))		
//idw_audit_trail.SetItem(ll_InsertRow, "sys_audit_exported", 1)
//if al_facility > 0 then
//	idw_audit_trail.SetItem(ll_InsertRow, "facility_id", al_facility)
//end if

//return 1
end function

public function integer of_import_xml (string as_file, integer ai_record);//Import functionality starts here called from the CAQH import window.
//CAQH 2 - Reconstructed by alfee 12.18.2009

integer res

open(w_caqh_import_progress)
w_caqh_import_progress.st_record.text = "Record " + string(ai_record)

//Start Code Change ----03.15.2016 #V15 maha - cache retrieval
gnv_data.of_retrieveifnecessary("sys_fields", False)
gnv_data.of_retrieveifnecessary("address_lookup", False)
//End Code Change ----03.15.2016

//Initialize variables and data cache
of_progress( 10, "Setting variables and data cache")
of_reset_variables( )

ids_data_parsed.Reset()
ids_dw_currow.Reset()
gnv_appeondb.of_startqueue( )
if ids_rules.rowcount() < 1 then ids_rules.retrieve(ii_verif )
if ids_questions.rowcount() < 1 then ids_questions.retrieve(ii_verif )
if ids_caqh_refs.rowcount() < 1 then ids_caqh_refs.retrieve()
gnv_appeondb.of_commitqueue( )

//read the XML file and rewrite for data parsing
of_progress( 100, "Parsing CAQH XML file.(" + as_file + ")")
of_parse_file(as_file) 
	
//see if has been previously imported, if not continue with import
of_progress( 100, "Matching provider")
if of_match_prac() < 1 then return 0

//initialize DataWindows 
of_progress( 100, "Setting data cache")
of_set_dws() 

//build or find table records, set field values and add lookup data if necessary
of_progress( 100, "Reading CAQH XML file.")	
of_read_parsed_file()
//messagebox("read file","")


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.19.2015
//<$>reason:add only save log logic, v15.1 CAQH Import Data Approval
If not ib_approval_flag Then	
	//set rec and prac ids, create appointment/link/audit/verif records and save data
	of_progress( 100, "Creating verifications and Audit records")	
	res = of_update_data( )
	
	if res = 1 then
		of_progress( 2000, "Provider Import complete.")	
	else  //failed to save
		of_progress( 2000, "Process complete.  Import failed.")
		return res
	end if
Else 
	//only save log when 'Log to Acceptance' is checked
	of_progress( 100, "Saving Log records")	
	res = of_update_log_only( )
	
	if res = 1 then
		of_progress( 2000, "Audit Log Import complete.")	
	else  //failed to save
		of_progress( 2000, "Process complete. Audit Log Import failed.")
		return res
	end if
End If
//------------------- APPEON END -------------------

return 1

/*
integer res
open(w_caqh_import_progress)

w_caqh_import_progress.st_record.text = "Record " + string(ai_record)
of_progress( 10, "Setting variables and data cache.")
of_reset_variables( )

if ids_rules.rowcount() < 1 then
	ids_rules.retrieve(ii_verif )
end if

if ids_questions.rowcount() < 1 then
	ids_questions.retrieve(ii_verif )
end if

of_progress( 100, "Setting variables and data cache.")
of_set_dws() //also retrieves address lookup data
of_progress( 200, "Setting variables and data cache.")
//add the basic info row
//Start Code Change ----11.10.2009 #V10 maha - trap for missing import mapping data
if idw_mapping.rowcount() = 0 then
	res = idw_mapping.retrieve()
	if res < 1 then
		messagebox("CAQH Import","Failed to retrieve mapping data; unable to continue import")
		return -1
		//close(w_caqh_import_progress)
	end if
end if
//End Code Change---11.10.2009

of_add_row("basic")

 //read the XML file and rewrite for data parsing
of_progress( 300, "Parsing CAQH XML file.(" + as_file + ")")
of_parse_file(as_file) 
	
//see if has been previously imported; if not continue with import
if of_match_prac() < 1 then return 0

//of_date_fix
of_progress( 500, "Reading CAQH XML file.")	
of_read_parsed_file()
//build the table records and set the field values
// of_build_tables
		//of_add_row
// of_set_field_value
// create data records, lookups as necessary.


//update 
of_progress( 500, "Creating verifications and Audit records")	
	
res = of_update_data( )
	//set rec and prac ids
	// create appointment records
	//create link records
	//create audit data
	//create verifs
	//save data

if res = 1 then
	of_progress( 2000, "Provider Import complete.")	
else  //failed to save
	of_progress( 2000, "Process complete.  Import failed.")
	return res
end if

//messagebox("XML import","Import Complete")

return 1
*/
end function

public function long of_find_existing_record (string as_isg_table, string as_ref_1, string as_ref_2, integer ai_idx_from);//Find existing record for a multi-record table(screen) - caqh 2: alfee 12.18.2009

Long i, ll_cnt, ll_found
String ls_caqh_table, ls_isg_table, ls_isg_field, ls_isg_value, ls_caqh_table_flag
String ls_value1, ls_value2, ls_find, ls_type

IF	IsNull(as_isg_table) OR LenA(as_isg_table) < 1 THEN RETURN -1
IF IsNull(as_ref_1) OR LenA(as_ref_1) < 1 OR ai_idx_from < 1 THEN RETURN -1

//get caqh reference field values in the parsed file
ll_cnt = ids_data_parsed.RowCount()
FOR i = ai_idx_from to ll_cnt
	IF i <> ai_idx_from THEN
		ls_caqh_table_flag = ids_data_parsed.GetItemString(i, 'caqh_table_flag')
		IF ls_caqh_table_flag = 'Y' THEN EXIT //end loop if next caqh table flag
	END IF
	
	ls_caqh_table = ids_data_parsed.GetItemString(i, 'caqh_table')
	ls_isg_table = ids_data_parsed.GetItemString(i, 'isg_table')
	ls_isg_field = ids_data_parsed.GetItemString(i, 'isg_field')
	ls_isg_value = ids_data_parsed.GetItemString(i, 'isg_value')
	IF upper(ls_isg_table) = upper(as_isg_table) AND upper(ls_isg_field) = upper(as_ref_1) THEN
		ls_value1 = ls_isg_value
		IF IsNull(as_ref_2) OR LenA(as_ref_2) < 1 OR LenA(ls_value2) > 0 THEN EXIT
	END IF
	IF LenA(as_ref_2) > 0 AND upper(ls_isg_field) = upper(as_ref_2) AND &
		upper(ls_isg_table) = upper(as_isg_table) THEN
		ls_value2 = ls_isg_value	
		IF LenA(ls_value1) > 0 THEN EXIT
	END IF			
NEXT

//find existing record in the current dw via caqh reference values
//----------Begin Modified by alfee 11.04.2010 ---------------------
//<$Reason>Support the case that the first key's value is empty
IF (IsNull(ls_value1) OR Len(ls_value1) < 1) AND (IsNull(ls_value2) OR Len(ls_value2) < 1) THEN RETURN 0

ls_type = gnv_data.of_get_sys_field_value(as_isg_table, as_ref_1, "field_type")
IF Len(ls_value1) > 0 THEN
	choose case ls_type
		case "C"
			ls_value1 = inv_string.of_globalreplace(ls_value1, "'", "~~'")	
			ls_find = as_ref_1 + " = '" + ls_value1 + "'"
		case "D"		
			ls_find = as_ref_1 + " = datetime('" + ls_value1 + "')"
		case "N","I", "V"
			ls_find = as_ref_1 + " = " + ls_value1 
	end choose
ELSE //null or emtpy
	choose case ls_type
		case "C"
			ls_find = "(" + as_ref_1 + " = '' or IsNull(" + as_ref_1 + "))"
		case "D", "N", "I", "V"
			ls_find = "IsNull(" + as_ref_1 + ")"
	end choose
END IF

IF Len(as_ref_2) > 0 THEN //if have reference field 2
	ls_type = gnv_data.of_get_sys_field_value(as_isg_table, as_ref_2, "field_type")
	IF Len(ls_value2) > 0 THEN 
		choose case ls_type
			case "C"
				ls_value2 = inv_string.of_globalreplace(ls_value2, "'", "~~'")	
				ls_find += " and " + as_ref_2 + " = '" + ls_value2 + "'"
			case "D"		
				ls_find += " and " + as_ref_2 + " = datetime('" + ls_value2 + "')"
			case "N","I", "V"
				ls_find += " and " + as_ref_2 + " = " + ls_value2 
		end choose	
	ELSE //null or empty
		choose case ls_type
			case "C"
				ls_find += " and " + "(" + as_ref_2 + " = '' or IsNull(" + as_ref_2 + "))"
			case "D", "N", "I", "V"
				ls_find += " and " + "IsNull(" + as_ref_2 + ")"
		end choose
	END IF
END IF

IF Left(ls_find, 5) = " and " THEN ls_find = Mid(ls_find, 6) 
ll_found = idw_cur_dw.Find(ls_find, 1, idw_cur_dw.rowcount())

RETURN ll_found

//IF IsNull(ls_value1) OR LenA(ls_value1) < 1 THEN RETURN 0
//
//ls_type = gnv_data.of_get_sys_field_value(as_isg_table, as_ref_1, "field_type")
//choose case ls_type
//	case "C"
//		ls_value1 = inv_string.of_globalreplace(ls_value1, "'", "~~'")	
//		ls_find = as_ref_1 + " = '" + ls_value1 + "'"
//	case "D"		
//		ls_find = as_ref_1 + " = datetime('" + ls_value1 + "')"
//	case "N","I", "V"
//		ls_find = as_ref_1 + " = " + ls_value1 
//end choose	
//
//IF LenA(ls_value2) > 0 THEN 
//	ls_type = gnv_data.of_get_sys_field_value(as_isg_table, as_ref_2, "field_type")	
//	choose case ls_type
//		case "C"
//			ls_value2 = inv_string.of_globalreplace(ls_value2, "'", "~~'")	
//			ls_find += " and " + as_ref_2 + " = '" + ls_value2 + "'"
//		case "D"		
//			ls_find += " and " + as_ref_2 + " = datetime('" + ls_value2 + "')"
//		case "N","I", "V"
//			ls_find += " and " + as_ref_2 + " = " + ls_value2 
//	end choose		
//END IF
//
//ll_found = idw_cur_dw.Find(ls_find, 1, idw_cur_dw.rowcount())
//
//RETURN ll_found
//----------End Modified ----------------------------------------
end function

public function long of_get_id_type (string as_isg_field);
//Other ids exceptions, get id type based on the field name - CAQH 2: alfee 12.18.2009

long ll_id_type, ll_found, nr
string ls_type_search, ls_cond, ls_value

choose case upper(as_isg_field)
	case "FEDERALEMPLOYEEID"
		ls_type_search = "Federal Employee ID"
	case "VISANUMBER"
		ls_type_search = "Visa Number"
	case "MEDICAIDNUMBER"
		//ls_type_search = "Medicare UPIN"
	//	ls_type_search = "Medicaid UPIN"	//alfee 10.25.2010
		ls_type_search = "Medicaid"	//maha 03.05.2014
	case "MEDICARENUMBER"
		//ls_type_search = "Medicaid UPIN"
	//	ls_type_search = "Medicare UPIN" //alfee 10.25.2010
		ls_type_search = "Medicare"	//maha 03.05.2014
	case "UPIN"
		ls_type_search = "UPIN"
end choose

ls_cond =  "upper(description) = '" + upper(ls_type_search ) + "' and lookup_name = 'Other Document Type'"
ls_value = string(gnv_data.of_getitem( "code_lookup","lookup_code" , ls_cond))
if ls_value = "" then //not found
	ll_found = idw_code_lookup.Find(ls_cond, 1, idw_code_lookup.RowCount())
	if IsNull(ll_found) or ll_found < 1 then 
		//Add it in code lookup table if not added yet
		ll_id_type = gnv_app.of_get_id( "LOOKUP" )
		nr = idw_code_lookup.insertrow(0)
		idw_code_lookup.setitem(nr,"code",upper(ls_type_search))
		idw_code_lookup.setitem(nr,"description",ls_type_search)
		idw_code_lookup.setitem(nr,"lookup_name",'Other Document Type')
		idw_code_lookup.setitem(nr,"lookup_code",ll_id_type)
	else
		ll_id_type = idw_code_lookup.GetItemNumber(ll_found, "lookup_code")
	end if
else 
	ll_id_type = long(ls_value)
end if

return ll_id_type
end function

public function datetime of_str2dt (string as_value);//convert a string to the datetime format - caqh 2: alfee 12.18.2009

long ll_pos
string ls_value, ls_date, ls_time
datetime ldt_rtn

SetNull(ldt_rtn)
if IsNull(as_value) or LenA(Trim(as_value)) < 1 then return ldt_rtn

ls_value = Trim(as_value)
ll_pos = PosA(ls_value, ' ')

if ll_pos > 0 then //datetime
	ls_date = LeftA(ls_value, ll_pos - 1)
	ls_time = MidA(ls_value, ll_pos + 1) 
	if IsDate(ls_date) and IsTime(ls_time) then
		ldt_rtn = datetime(date(ls_date), time(ls_time))
	end if
else //date
	if IsDate(ls_value) then
		ldt_rtn = datetime(date(ls_value), time("00:00:00"))
	end if
end if

return ldt_rtn


end function

public function string of_get_entity_name (long al_lu_code);//get entity name in address lookup - caqh 2: alfee 12.18.2009

long ll_find
string ls_entity_name
					
//find in new address lookup data
ll_find = idw_address_lookup.Find("lookup_code = "+ String(al_lu_code), 1, idw_address_lookup.rowcount())
if ll_find > 0 then 
	ls_entity_name = idw_address_lookup.GetItemString(ll_find,'entity_name')
	return trim(ls_entity_name)
end if

//find in existing address lookup data
ll_find = ids_address_lookup.Find("lookup_code = "+ String(al_lu_code), 1, ids_address_lookup.rowcount())
if ll_find > 0 then 
	ls_entity_name = ids_address_lookup.GetItemString(ll_find,'entity_name')
	return trim(ls_entity_name)
end if

return ''
end function

public function string of_get_sched_msg ();//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function integer of_set_sched_flag (boolean ab_flag);//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function integer of_reset_lookups ();//Start Code Change ----3.17.2010 #V10 maha - reset the created lookups and reretrieve the code lookups
//called from of_set_appt_defaults()
//does once at the beginning of the import

idw_code_lookup.reset()
idw_address_lookup.reset()

gnv_appeondb.of_startqueue( )
gnv_data.of_retrieve("code_lookup")
ids_address_lookup.retrieve()
gnv_appeondb.of_commitqueue( )

return 1
end function

public function datetime of_get_exp_date (integer ai_screen, integer ai_row, datawindow adw_data);//Get expiration date for verif info if it's existed - alfee 10.08.2010

Integer li_month
Long ll_found
String ls_exp_field
DateTime ldt_null_date, ldt_exp_date

SetNull(ldt_null_date)

ll_found	= ids_refs.Find("screen_id = " + String(ai_screen), 1, ids_refs.rowcount())
IF IsNull(ll_found) OR ll_found < 1 THEN RETURN ldt_null_date	
	
ls_exp_field = ids_refs.GetItemString( ll_found, "exp_field")
IF IsNull(ls_exp_field) OR Len(ls_exp_field) < 1 THEN RETURN ldt_null_date

IF IsNull(ai_row) OR ai_row < 1 OR adw_data.rowcount() < ai_row THEN RETURN ldt_null_date
IF adw_data.Describe(ls_exp_field + ".ColType") = "!" THEN RETURN ldt_null_date 

//move expiration date to verif info table if there is one	
IF ls_exp_field = "certification_expires" THEN	
	ldt_exp_date = DateTime(Date(String(adw_data.GetItemNumber(ai_row, ls_exp_field)) + "-12-30"), Now())
ELSEIF ls_exp_field = "cert_expiration_year" THEN
	IF adw_data.Describe("cert_expiration_month.ColType") <> "!" THEN 
		li_month = adw_data.GetItemNumber(ai_row, "cert_expiration_month")
		if isnull(li_month) then
			ldt_exp_date = DateTime(Date(String(adw_data.GetItemNumber(ai_row, ls_exp_field)) + "-12-30"), Now())
		else
			ldt_exp_date = DateTime(Date(String(adw_data.GetItemNumber(ai_row, ls_exp_field)) + "-" + String(li_month) + "-28"), Now())
		end if
	ELSE
		ldt_exp_date = DateTime(Date(String(adw_data.GetItemNumber(ai_row, ls_exp_field)) + "-12-30"), Now())
	END IF
ELSE
	ldt_exp_date = adw_data.GetItemDateTime( ai_row, ls_exp_field )
END IF

RETURN ldt_exp_date
end function

public function integer of_verif_creation (long al_rec, long al_prac, long al_facil, string ls_refer, integer ai_screen, datetime adt_exp_date);//create new verification records - called from of_update_data
//add the argument of 'adt_exp_date' - alfee 10.08.2010

long li_nr
long ll_method
long ll_hc_code
string ls_screen
string ls_user
string ls_doc_id
integer li_priority
datetime ld_dr

li_nr = idw_verifs.insertrow(0)

ls_user = ids_rules.GetItemString( 1, "priority_user" )	
li_priority = ids_rules.GetItemNumber( 1, "priority" )	
ls_screen =  ids_rules.getitemstring(1,"data_view_screen_screen_alias")
ll_method = ids_rules.getitemnumber(1,"default_verif_means")
idw_verifs.SetItem( li_nr, "prac_id", al_prac )
idw_verifs.SetItem( li_nr, "rec_id", al_rec )
idw_verifs.SetItem( li_nr, "verif_info_facility_id", ii_verif )
idw_verifs.SetItem( li_nr, "priority_user", ls_user )
idw_verifs.SetItem( li_nr, "priority", li_priority )
idw_verifs.SetItem( li_nr, "number_sent", 0 )
idw_verifs.SetItem( li_nr, "exp_credential_flag", 0)
idw_verifs.SetItem( li_nr, "print_flag", 1) //Start Code Change ----04.13.2010 #V10 maha
idw_verifs.SetItem( li_nr, "verification_method", ll_method )	
//idw_verifs.SetItem( li_nr, "verif_info_data_status", ai_data_status )  //Start Code Change ----08.01.2008 #V85 maha - set data_status
idw_verifs.SetItem( li_nr, "seq_no", 1 )
idw_verifs.SetItem( li_nr, "screen_id", ai_screen )
idw_verifs.SetItem( li_nr, "reference_value",MidA(ls_refer,1,100)) 
idw_verifs.SetItem( li_nr, "expiration_date", adt_exp_date ) //restored by alfee 10.08.2010
idw_verifs.SetItem( li_nr, "screen_name", ls_screen )
//idw_verifs.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
ls_doc_id = String( al_rec) + "-" + String( al_prac ) + "-" + String( al_facil ) +  "-" + String( 1 )
idw_verifs.SetItem( li_nr, "doc_id", ls_doc_id )

//Start Code Change ----07.14.2015 #V15 maha - set created values
idw_verifs.SetItem(li_nr, 'create_date', datetime(today(),now()))
idw_verifs.SetItem(li_nr, 'create_user', gs_user_id + "-N")
//End Code Change ----07.14.2015

//complete as needed
if gs_cust_type = "I" then //Start Code Change ----01.208.2010 #V10 maha _ change from IntelliApp
	ll_hc_code = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Hard Copy') + "'"))
	idw_verifs.SetItem( li_nr, "response_code", ll_hc_code)	
	ld_dr = DateTime( Today(), Now() )
	idw_verifs.SetItem( li_nr, "date_recieved", ld_dr )					  
	idw_verifs.SetItem( li_nr, "user_name", gs_user_id )
end if


//	li_row_cnt = lds_last_verif_seq_no.Retrieve( al_rec_id, al_prac_id, li_facility_id )
//		lds_last_verif_seq_no.SetFilter("facility_id = "+string(li_facility_id) )
//		lds_last_verif_seq_no.Filter( )
//		li_row_cnt = lds_last_verif_seq_no.Rowcount( )
//		IF li_row_cnt < 1 THEN
//			ll_seq_no = 1 
//		ELSE
//			ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
//		END IF
//		if isnull(ll_seq_no) then 	ll_seq_no = 1	//maha 091900
//		li_facility_id_first = li_facility_id







return 1
end function

public function integer of_verif_update (long al_rec, long al_prac, long al_facil, string as_refer, integer ai_screen, datetime adt_exp_date);//Update the reference value of verification record - caqh2: alfee 12.18.2009
//Add the argument of 'adt_exp_date' to update the expiration date - alfee 10.08.2010

//Note: Generally, as the reference fields are same with caqh reference fields, any update 
//to reference fields will only add a new verif rec. Currently, the "verif_info_data_status" 
//field is not included in of_verif_creation().

long ll_cnt, ll_found
string ls_find, ls_refer, ls_refer_ori
datetime ldt_exp_date, ldt_exp_date_ori //alfee 10.08.2010

ll_cnt = idw_verifs.rowcount()
if ll_cnt < 1 then return 0

//if IsNull(as_refer) or Len(as_refer) < 1 then return 0 //moved below - alfee 10.08.2010

ls_find = "rec_id = " + String(al_rec) + " and screen_id = " + String(ai_screen)
ll_found = idw_verifs.Find(ls_find, 1, ll_cnt)
if ll_found > 0 then 	
//------Begin Added by alfee 10.08.2010 -----------
	//update expiration date
	ldt_exp_date_ori = idw_verifs.GetItemDateTime(ll_found, "expiration_date")
	if IsNull(ldt_exp_date_ori) or adt_exp_date <> ldt_exp_date_ori then
		idw_verifs.SetItem(ll_found, 'expiration_date', adt_exp_date)
	end if

	//update reference
	if IsNull(as_refer) or Len(as_refer) < 1 then return 0 //ignore if a Null referece value
//------End Added ---------------------------------	
	ls_refer = Mid(as_refer,1,100) 
	ls_refer_ori = idw_verifs.GetItemString(ll_found, 'reference_value') 
	if IsNull(ls_refer_ori) or ls_refer <> ls_refer_ori then
		idw_verifs.SetItem(ll_found, 'reference_value', ls_refer)
	end if	
	
	//Start Code Change ----07.14.2015 #V15 maha - set created values
	idw_verifs.SetItem(ll_found, 'mod_date', datetime(today(),now()))
	idw_verifs.SetItem(ll_found, 'mod_user', gs_user_id + "-N")
	//End Code Change ----07.14.2015
end if

return 1
end function

public function integer of_parse_file (string as_file);//parse the file

long i
long ic
long pa
long pb
long pc
long pd
long ll_len //maha 120611
boolean ib_skip

integer res
integer li_read
integer li_write
integer li_new_format

string ls_read
string ls_name
string ls_value
string ls_write
string ls_table
string ls_write_path
string ls_parse_file

SetNull(is_last_name) //caqh 2: alfee 12.18.2009	
SetNull(is_first_name) //caqh 2: alfee 12.18.2009

//Create the caqh directory if not exists
is_file = as_file

li_read = FileOpen (is_file)

ls_write_path = gs_temp_path + "caqh"
if DirectoryExists ( ls_write_path ) = false then
	res = CreateDirectory ( ls_write_path )
	if res = -1 then
		//messagebox("CAQH Import","Unable to create file directory:" + ls_write_path )
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox("CAQH Import","Unable to create file directory:" + ls_write_path,true)
		return -1
	end if
end if

is_parsed_file = ls_write_path +  "\caqhxml.txt"


li_write = FileOpen (is_parsed_file, LineMode!, Write!, LockWrite!, Replace!)

//read the first line
FileRead ( li_read, ls_read)
ll_len = len(ls_read)

//Start Code Change ----10.21.2010 #V10 maha - moved from inside of loop and added trap for new format
if pos(ls_read,"<Provider") = 0 or pos(ls_read,"ProviderID=") = 0 then
//messagebox("Parse of file failed", "Unable to read or file is not in expected format.")
//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Parse of file failed", "Unable to read file, or file is not in expected format.",true)
	FileClose(li_read)
	FileClose(li_write)
	return -1
elseif ll_len > 1000 then //Start Code Change ----12.6.2010 #V10 maha - modified trap to look at length if greater than 100 most likely in the single line format
//	inv_message.of_MessageBox("Parse file", "This CAQH file is in a new format that cannot be read.  ISG is working now to integrate this new format into the Import functionality",true)
	FileClose(li_read)  //close the file as it has to be reopened in textmode once parsed

	ls_parse_file = 	ls_write_path +  "\caqhparse.txt"
	of_parse_new_format(is_file,ls_parse_file) //parse the file into line format then parse that file
	//read from the newly parsed file
	li_read = FileOpen (ls_parse_file)
end if
ls_write = of_parse_first(ls_read)
//messagebox("",ls_write)
ic = FileWrite ( li_write, ls_write)
ls_write = "#%#%#%*<PROVIDER ID=*"
ic = FileWrite ( li_write, ls_write)
//end read first line


for i = 1 to 50000
	if FileRead ( li_read, ls_read) = -100 then exit //end of file
	//Start Code Change ----10.21.2010 #V10 maha - moved outside of loop to trap for new format
//parsing for the first row of the file	
//	if i = 1 then 
		//if pos(ls_read,"<Provider ProviderID=") = 0 then
//		if pos(ls_read,"<Provider") = 0 or pos(ls_read,"ProviderID=") = 0 then
//			//messagebox("Parse of file failed", "Unable to read or file is not in expected format.")
//			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
//			inv_message.of_MessageBox("Parse of file failed", "Unable to read file, or file is not in expected format.",true)
//			FileClose(li_read)
//			FileClose(li_write)
//			return -1
//		elseif pos(ls_read,"<Provider ProviderID=") = 0 then
//			inv_message.of_MessageBox("Parse of file failed", "This CAQH file is in a new format that cannot be read.  ISG is working now to integrate this new format into the Import functionality",true)
//			FileClose(li_read)
//			FileClose(li_write)
//			//return -1
//			of_parse_new_format(is_file)
//		end if
//		ls_write = of_parse_first(ls_read)
//		//messagebox("",ls_write)
//		ic = FileWrite ( li_write, ls_write)
//		ls_write = "#%#%#%*<PROVIDER ID=*"
//		ic = FileWrite ( li_write, ls_write)
//		continue
//	end if  //first row

	if PosA(upper(ls_read), "WWW.W3.ORG" ,1) > 0 then continue //identifier in new format  
	//Start Code Change ----10.21.2010
	
	
	
	pa = PosA(ls_read, "<" ,1)
	pb = PosA(ls_read, ">" ,1)
	pc = PosA(ls_read, "</" ,1)
	
	ib_skip = false
	if pc = 0 then //if there is no close tag
		if PosA(ls_read,"ID=",1) = 0 then //if there is no id value skip
			continue
		else
			//ls_table = mid(ls_read,3,pos(ls_read," ID",1)  - 3)
			//messagebox("",ls_table)
			//of_build_tables( ls_table)
			ls_name = "#%#%#%" + "*" + MidA(ls_read,pa,LenA(ls_read) - 2)   //Start Code Change ----03.06.2010 #V10 maha - changed second argument from 2 to pa
				ls_value = ""
			ib_skip = true
		end if
	elseif pc < 6 then  //skip the close tag
		//skip the line
		continue
	else
		ls_name = MidA(ls_read, pa + 1, pb - 1 - pa )
		ls_value = MidA(ls_read, pb + 1, pc - 1 - pb )
	end if
	
//	if ib_skip then 
//		ls_write = "~r~n"
//		ic = FileWrite ( li_write, ls_write)
//	end if

 //Start Code Change ----06.08.2015 #V15 maha - moved setting od provider values to separate function
//	if ls_name = "SSN" then is_ssn = ls_value
//	if ls_name = "NID" then is_npi = ls_value
//	
//	//------------------- APPEON BEGIN -------------------
//	//<$>added:long.zhang 06.08.2015
//	//<$>reason:for Bug id 4552 - CAQH Import files Build date 05/15/2015 SAAS
//	if (ls_name = "NPI" and is_npi = '')  then is_npi = ls_value
//	//if ls_name = "NPI" then is_npi = ls_value  //Start Code Change ----10.12.2009 #V10 maha
//	//------------------- APPEON END -------------------
//	
//	//-------Begin Modified by (caqh 2)alfee 12.18.2009 -------------
//	if upper(ls_name) = "LASTNAME" and isnull(is_last_name) then is_last_name = ls_value 
//	if upper(ls_name) = "FIRSTNAME" and isnull(is_first_name) then is_first_name = ls_value 
//	//if ls_name = "LASTNAME" then is_last_name =  ls_value
//	//if ls_name = "FIRSTNAME" then is_first_name =  ls_value	
//	//--------End Modified ------------------------------------------
 //End Code Change ----06.08.2015
	
	if PosA(ls_value,"00:00:00",1) > 0 or PosA(ls_value,"01:00:00",1) > 0 then //Hard Code for "01:00:00" too, modified by Appeon long.zhang 04.08.2016 (V15 issues with CAQH import )
		ls_value = of_date_fix( ls_value)
	end if
	
	ls_write = upper(ls_name) + "*" + ls_value
	
	ic = FileWrite ( li_write, ls_write)
next

FileClose(li_read)
FileClose(li_write)

if of_set_provider_ids( ) < 1 then return -2   //Start Code Change ----06.08.2015 #V15 maha

return 1


end function

public function integer of_parse_new_format (string as_file, string as_write);//Start Code Change ----10.20.2010 #V10 maha - added for prasing new format of CAQH file
integer li_write
integer li_read
integer li_loops
integer i
long pstart
long pstart2
long pend
long pend2 = 1
long pid
long ptest
long r
long res
long ll_len
string ls_write_file
string ls_read_file
string ls_read
string ls_seg
string ls_test

//new parsed file
//ls_write_file = gs_dir_path + "intellicred\caqh"
//ls_write_file+=  "\caqhparse.txt"

ls_write_file = as_write


ls_read_file = as_file
ll_len = FileLength ( ls_read_file )
li_loops = ll_len/32765
li_loops+= 1
//messagebox("Size",ll_len)
li_read = FileOpen (ls_read_file,lineMode!, Read!, LockRead!, Replace!)
li_write = FileOpen (ls_write_file,lineMode!, Write!, LockWrite!, Replace!)




for i = 1 to li_loops

	pend2 = 1 //reset the end
	res = FileRead ( li_read, ls_read)
	ls_read  = ls_seg + ls_read //add the stub from the previous loop
//	ls_test = mid(ls_read,1,15)
//	messagebox("",ls_test)
	for r = 1 to 50000
		pstart = pos(ls_read, "<" ,pend2)
		pid = pos(ls_read, "ID=" ,pend)	
		pstart2 =  pos(ls_read, ">" ,pstart)
		ptest = pos(ls_read, "<" ,pstart + 1) //test to see if subsection exists
		pend = pos(ls_read, "</" ,pstart2)
		pend2 = pos(ls_read, ">" ,pend)
		
		if mid(ls_read,pstart,2) = "</" then //for sub end stubs
			pend2 = pstart2
		elseif pid > 0 and pid < pstart2 then  //for sub sections
			pend2 = pstart2	
		elseif ptest <> pend then //for sub section starts
			pend2 = pstart2	
		end if
		
	
		
		if pstart = 0 then exit
		
		If pstart >0 and pend2 = 0 Then //deal with the end of 32765 , Added by Appeon long.zhang 04.07.2015 (v15.1 CAQH Import Data Approval)
			ls_seg = mid(ls_read,pstart)
		Else
			ls_seg = mid(ls_read,pstart,pend2 - pstart + 1) + "~r~n"
			res = FileWriteEx ( li_write, ls_seg)
			if res < 1 then 
				messagebox("","Write Failed")
				return -1
			end if
		End If
	next
next

FileClose(li_read)
FileClose(li_write)

return 1
end function

public function integer of_language_dupe_check ();//Start Code Change ----10.25.2010 #V10 maha - added to check for duplicate languages
//don't need to check it any more, comment by  Appeon long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)

//integer r
//integer rc
//integer d
//integer dc
//long ll_langr
//long ll_langd
//
//rc = idw_language.rowcount()
//dc = rc
//
//for r = 1 to rc
//	ll_langr =  idw_language.getitemnumber(r,"foreign_language")
//	for d =  idw_language.rowcount() to r + 1 step -1 
//		ll_langd =  idw_language.getitemnumber(d,"foreign_language")
//		if ll_langd = ll_langr then
//			 idw_language.deleterow(d)	
//			 rc = rc - 1
//		end if
//	next
//next

return 1






end function

public function integer of_set_dir_links (integer ai_value);choose case ai_value
	case 1
		ib_directory_links = true
	case 0
		ib_directory_links = false
end choose

return 1
end function

public function integer of_set_default_values (datawindow adw_current, integer ai_table_id, long al_current_row);//====================================================================
//$<Function>: of_set_default_values()
//$<Arguments>:
// 	value    datawindow    adw_current
// 	value    integer       ai_table_id
// 	value    long          al_current_row
//$<Return>:  integer
//$<Description>: Set default values for the current table and row
//$<Author>: (Appeon) Alfee 05.07.2014 (CAQH Screen defaults - alfee 05.07.2014)
//------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_cnt, i, ll_lookup_code, ll_value
String ls_field_name, ls_field_type
String ls_default_value, ls_value 
String ls_lookup_field, ls_lookup_type, ls_lookup_name
DateTime ldt_value, ldt_default_value

ll_cnt = ids_default_values.RowCount ()
IF ll_cnt < 1 THEN RETURN 0
IF al_current_row  < 1 OR adw_current.RowCount () < al_current_row THEN RETURN -1

FOR i = 1 to ll_cnt
	ls_field_name = ids_default_values.GetItemString (i, "sys_fields_field_name")
	IF adw_current.Describe (ls_field_name + ".ColType") = "!" THEN CONTINUE
	
	ls_field_type = ids_default_values.GetItemString (i, "sys_fields_field_type")
	ls_default_value = ids_default_values.GetItemString (i, "sys_fields_default_value")
	ls_lookup_field = Trim(ids_default_values.GetItemString (i, "sys_fields_lookup_field"))
	ls_lookup_type = Trim(ids_default_values.GetItemString (i, "sys_fields_lookup_type"))
	ls_lookup_name = Trim(ids_default_values.GetItemString (i, "sys_fields_lookup_code"))
	
	CHOOSE CASE Upper(ls_field_type)
		CASE "C"
			ls_value = adw_current.GetItemString (al_current_row, ls_field_name)
			IF Len(Trim(ls_value)) > 0 THEN CONTINUE
			
			IF Upper (ls_lookup_field) = "Y"  THEN
				ll_lookup_code = of_get_lookup_code (ls_lookup_type, ls_lookup_name, ls_default_value)	
				IF Not IsNull(ll_lookup_code) THEN adw_current.SetItem (al_current_row, ls_field_name, String(ll_lookup_code))
			ELSE
				adw_current.SetItem (al_current_row, ls_field_name, ls_default_value)
			END IF
		CASE "D"
			ldt_value = adw_current.GetItemDateTime (al_current_row, ls_field_name)
			IF NOT IsNull (ldt_value) THEN CONTINUE

			ldt_default_value = of_str2dt (ls_default_value)
			IF IsNull (ldt_default_value) THEN CONTINUE

			adw_current.SetItem(al_current_row, ls_field_name,  ldt_default_value)			
		CASE "N","I", "V"
			ll_value = adw_current.GetItemNumber (al_current_row, ls_field_name)
			IF NOT IsNull (ll_value) THEN CONTINUE
			
			IF Upper (ls_lookup_field) = "Y"  THEN
				ll_lookup_code = of_get_lookup_code (ls_lookup_type, ls_lookup_name, ls_default_value)
				IF Not IsNull(ll_lookup_code) THEN adw_current.SetItem (al_current_row, ls_field_name, ll_lookup_code)
			ELSE
				IF NOT IsNumber(ls_default_value) THEN CONTINUE
				adw_current.SetItem (al_current_row, ls_field_name, Long(ls_default_value))
			END IF
	END CHOOSE	
NEXT

RETURN 1
end function

public function long of_get_lookup_code (string as_lookup_type, string as_lookup_name, string as_code);
//====================================================================
//$<Function>: of_get_lookup_code()
//$<Arguments>:
// 	value    string    as_lookup_type
// 	value    string    as_lookup_name
// 	value    string    as_code
//$<Return>:  Long
//$<Description>: Get the lookup_code from the specified lookup table
//$<Author>: (Appeon) Alfee 05.07.2014 (CAQH Screen defaults)
//--------------------------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_lookup_code
String ls_condition, ls_value

SetNull (ll_lookup_code)

IF IsNull(as_lookup_type) OR Len(Trim(as_lookup_type)) < 1 THEN RETURN ll_lookup_code
IF IsNull(as_lookup_name) OR Len(Trim(as_lookup_name)) < 1 THEN RETURN ll_lookup_code
IF IsNull(as_code) OR Len(Trim(as_code)) < 1 THEN RETURN ll_lookup_code

ls_condition = 'Upper(lookup_name) = "' + Upper(Trim(as_lookup_name)) + '"'  + ' And Upper(code) = "' + Upper(Trim(as_code)) + '"' 
CHOOSE CASE Upper(as_lookup_type)
	CASE 'C'
		ls_value = gnv_data.of_getitem ("code_lookup", "lookup_code", ls_condition)
		IF ls_value  <> "" THEN ll_lookup_code = Long(ls_value)
	CASE 'A'
		ls_value = of_get_addr_lu_value (ls_condition, "lookup_code")
		IF ls_value  <> "" THEN ll_lookup_code = Long(ls_value)				
	CASE 'Q'
		// The default value is not supported to define in screen painter	
END CHOOSE		

RETURN ll_lookup_code
end function

public subroutine of_set_approval_flag (boolean ab_approval);//====================================================================
//$<Function>: of_set_approval_flag
//$<Arguments>:
// 	value    boolean    ab_approval 
//$<Return>:  (None)
//$<Description>: called from the caqh window to set ib_approval_flag, true:Checkbox 'Log to Acceptance' is checked
//$<Author>: (Appeon) long.zhang 03.18.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_approval_flag = ab_approval
end subroutine

public function integer of_upload_log_file ();//====================================================================
//$<Function>: of_upload_log_file
//$<Arguments>:
//$<Return>:  integer
//$<Description>: upload caqh file to caqh_log
//$<Author>: (Appeon) long.zhang 03.19.2015 (for v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Blob tot_b
String ls_caqh_id

// Set a wait cursor
SetPointer(HourGlass!)

If not fileexists(is_file) then return -1

// Open processs window
openwithparm( w_appeon_gifofwait, "Uploading CAQH file to Database..." )

if inv_utils.of_ReadBlob(is_file, tot_b) = -1 then Return -1

UPDATEBLOB  caqh_log
	 SET import_file = :tot_b
 WHERE log_id = :il_log_id;
If sqlca.sqlcode < 0 Then
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Return -1
End If

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

Return 1
end function

public function integer of_update_log_only ();//====================================================================
//$<Function>: of_update_log_only
//$<Arguments>:
//$<Return>:  integer
//$<Description>:only update log when 'Log to Acceptance' is checked, used in function of_import_xml.
//$<Author>: (Appeon) long.zhang 03.19.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_test
integer res

ls_test = idw_basic.getitemstring(1,"last_name")
if isnull(ls_test) or ls_test = "" then
	return -1
end if

//add caqh log
of_add_log()

of_progress( 1200, "Saving Log")	

//save the data
res = of_save_log_only()

if res = 1 then
	commit using sqlca;
else //-1
	rollback using sqlca;
	inv_message.of_MessageBox("of_update_log_only","Data save failure for " + is_failed,true )
end if

//turn on autocommit either way
sqlca.autocommit = true

return res
end function

public function integer of_save_log_only ();//====================================================================
//$<Function>: of_save_log_only
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Only save log, don't save provider data, used in function of_update_log_only.
//$<Author>: (Appeon) long.zhang 03.19.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer i
integer res
String ls_caqh_id
Datetime ldt_now

If not ib_approval_flag Then Return -1 
	
//turn off autocommit
sqlca.autocommit = false

//update lookup tables
res = idw_address_lookup.update()
if res < 1 then 
	is_failed = "addr lu"
	return -1
end if
res = idw_code_lookup.update()
if res < 1 then 
	is_failed = "code lu"
	return -1
end if
res = ids_questions.update()
if res < 1 then 
	is_failed = "quest lu"
	return -1
end if

res = idw_log.update()
if res < 1 then 
	is_failed = "log"
	return -1
end if

ldt_now = idw_log.getitemdatetime(1,"log_date")
ls_caqh_id = string(il_prov_id)

SELECT  log_id into :il_log_id
FROM CAQH_LOG
WHERE caqh_id = :ls_caqh_id
and attest_date = :is_attest_date
and log_date = :ldt_now;
If sqlca.sqlcode < 0 Then
	If res < 1 Then 
		is_failed = "query log id"
		return -1
	End if
Else
	For i = idw_log_items.rowcount() to 1 step -1
		idw_log_items.setitem(i,'log_id', il_log_id)
	Next
	
	res = idw_log_items.update()
	if res < 1 then 
		is_failed = "log items"
		return -1
	end if
End If

//upload log file
res = of_upload_log_file()
if res < 1 then 
	is_failed = "upload log file"
	return -1
end if

return 1
end function

public function string of_get_defaults_vars ();//====================================================================
//$<Function>: of_get_defaults_vars
//$<Arguments>:
//$<Return>:  string (format:name1= value1&name2=value2…)
//$<Description>:Record ’Data Defaults’ to caqh_log.defaults, used by n_cst_caqh_import.of_add_log() 
//format:name1= value1&name2=value2…

//$<Author>: (Appeon) long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_return =''

//1.parent_facility_id, ii_parent is not null.
ls_return += 'parent_facility_id'+' = ' + string(ii_parent)

//2.parent_facility_nm  
If IsNull(is_parent) Then is_parent = ''
ls_return += '&' + 'parent_facility_nm'+' = ' + is_parent
 
//3.application_audit_facility, ii_audit is not null.
ls_return += '&' + 'application_audit_facility'+' = ' + string(ii_audit)

//4.verifying_facility, ii_verif is not null.
ls_return += '&' + 'verifying_facility'+' = ' + string(ii_verif)

//5.apptmnt_type, 
If IsNull(is_type) Then is_type = ''
ls_return += '&' + 'apptmnt_type'+' = ' + is_type

//6.affiliation_status, 
If IsNull(is_affil) Then is_affil = ''
ls_return += '&' + 'affiliation_status'+' = ' + is_affil

//7.Set_Title_default_to_Dr., 
ls_return += '&' + 'Set_Title_default_to_Dr'+' = ' + String(ib_title)

//8.Set_Provider_Id_from_file, 
ls_return += '&' + 'Set_Provider_Id_from_file'+' = ' + String(ib_prov_id)

//9.Set_Address_Directory_Linked.
ls_return += '&' + 'Set_Address_Directory_Linked'+' = ' + String(ib_directory_links)


Return ls_return
end function

public function long of_set_defaults_vars (string as_defaults);//====================================================================
//$<Function>: of_set_defaults_vars
//$<Arguments>:as_defaults
//$<Return>:  0 success/-1 failure
//$<Description>: Read caqh_log.defaults and parse it to variables.
//$<Author>: (Appeon) long.zhang 03.24.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_array[]
n_cst_string_appeon lnv_string

If LenA(as_defaults) < 1 Then Return -1

//as_defaults is in specified order.
lnv_string.of_ParseToArray (as_defaults, '&', ls_array )
 
//1.parent_facility_id,
ii_parent = Integer(MidA(ls_array[1], pos(ls_array[1], ' = ') + 3))

//2.parent_facility_nm  
is_parent = MidA(ls_array[2], pos(ls_array[2], ' = ') + 3)
 
//3.application_audit_facility,  
ii_audit =  Integer(MidA(ls_array[3], pos(ls_array[3], ' = ') + 3))

//4.verifying_facility, 
ii_verif =  Integer(MidA(ls_array[4], pos(ls_array[4], ' = ') + 3))

//5.apptmnt_type, 
is_type =  MidA(ls_array[5], pos(ls_array[5], ' = ') + 3)

//6.affiliation_status, 
is_affil =  MidA(ls_array[6], pos(ls_array[6], ' = ') + 3)

//7.Set_Title_default_to_Dr., 
ib_title =  (MidA(ls_array[7], pos(ls_array[7], ' = ') + 3) = 'true' )

//8.Set_Provider_Id_from_file, 
ib_prov_id =  (MidA(ls_array[8], pos(ls_array[8], ' = ') + 3) = 'true' )

//9.Set_Address_Directory_Linked.
ib_directory_links =  ((MidA(ls_array[9], pos(ls_array[9], ' = ') + 3)) = 'true' )

Return 0
end function

public function any of_get_currow_value (string as_isg_table, string as_field);//====================================================================
//$<Function>: of_get_currow_value
//$<Arguments>:
// 	value    string    as_isg_table
// 	value    string    as_field
//$<Return>:  any
//$<Description>: get value from ids_dw_currow.
//$<Author>: (Appeon) long.zhang 03.25.2015 (v15.1 CAQH Import Data Approval)
//====================================================================

Long ll_cnt, ll_found
Any la_value
String ls_find

ll_cnt = ids_dw_currow.RowCount() 
IF ll_cnt < 1 OR IsNull(as_isg_table) THEN RETURN 0

ls_find = "Upper(isg_table) = '" + Upper(as_isg_table) + "'"
ll_found = ids_dw_currow.Find(ls_find, 1, ll_cnt)
IF ll_found > 0 THEN 
	Choose case lower(as_field)
		case 'cur_rec_id', 'table_id'
			la_value = ids_dw_currow.GetItemNumber(ll_found, as_field)
		case 'cur_audit_type'
			la_value = ids_dw_currow.GetItemString(ll_found, as_field)
	End Choose
END IF

RETURN la_value
end function

public function integer of_discard_item (long al_row);//====================================================================
//$<Function>: of_discard_item
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: delete idw_cur_dw's item , also delete the old log from idw_log_items.
//$<Author>: (Appeon) long.zhang 03.26.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_table_id, ls_cur_rec_id, ls_cur_audit_type, ls_find
long ll_row, i

datawindow ldw_adw
ldw_adw = idw_cur_dw

if IsNull(al_row) or al_row < 1 or al_row > ldw_adw.rowcount() then return -1

ldw_adw.rowsdiscard(al_row, al_row, primary!)	

//delete the old log from idw_log_items
If ib_approval_flag and ldw_adw = idw_cur_dw Then
	ls_table_id = String(of_get_currow_value(is_cur_isg_table, 'table_id'))
	ls_cur_audit_type = String(of_get_currow_value(is_cur_isg_table, 'cur_audit_type'))
	ls_cur_rec_id = String(of_get_currow_value(is_cur_isg_table, 'cur_rec_id'))
	ls_find = 'table_id = ' + ls_table_id + ' and audit_type = "' +  ls_cur_audit_type + '" and seq_no = ' + ls_cur_rec_id
	
	i = idw_log_items.rowcount()
	ll_row = idw_log_items.find(ls_find, 1 ,i )
	Do While (ll_row > 0 )
		idw_log_items.deleterow( ll_row )
		i --
		IF i < 1 THEN EXIT
		ll_row = idw_log_items.find(ls_find, 1 ,i )
	Loop
End if

return 1
end function

public function long of_get_log_id ();//====================================================================
//$<Function>: of_get_log_id
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.27.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

return il_log_id
end function

public subroutine of_set_prac_id (long al_prac_id);//====================================================================
//$<Function>: of_set_prac_id
//$<Arguments>:
// 	value    long    al_prac_id
//$<Return>:  integer
//$<Description>: Set il_prac
//$<Author>: (Appeon) long.zhang 04.01.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
il_prac = al_prac_id

end subroutine

public subroutine of_set_ib_update (boolean ab_update);//====================================================================
//$<Function>: of_set_ib_update
//$<Arguments>:
// 	value    boolean    ab_update
//$<Return>:  (None)
//$<Description>: set ib_update
//$<Author>: (Appeon) long.zhang 04.01.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ib_update = ab_update

end subroutine

public function integer of_read_audit_data ();//====================================================================
//$<Function>: of_read_audit_data
//$<Arguments>:
//$<Return>:  integer
//$<Description>: parse the audit data and set value to datawindows
//$<Author>: (Appeon) long.zhang 04.01.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long i , ll_cnt , ll_table_id_tmp, ll_seq_no, ll_rowno
long ll_table_id = 0, ll_seq_no_tmp =0, ll_find
string ls_sort, ls_audit_type_tmp,ls_audit_type ='',ls_isg_table,ls_isg_field,ls_type,ls_value
string ls_find

//sort ids_caqh_log_items
ls_sort = 'table_id asc, audit_type desc, seq_no asc, field_name asc'
ids_caqh_log_items.setsort(ls_sort)
ids_caqh_log_items.sort()

//set value to datawindows
For i = 1 to ids_caqh_log_items.rowcount() 
	//status = -2 is a temporary flag setted in w_caqh_audit.cb_accept
	If ids_caqh_log_items.getitemnumber(i, 'status') <> -2 Then continue
	 
	//change table
	ll_table_id_tmp = ids_caqh_log_items.getitemnumber(i, 'table_id')
	If ll_table_id_tmp <> ll_table_id Then //new table
		ll_table_id = ll_table_id_tmp

		ls_audit_type = ''
		ll_seq_no = 0
		//set current table
		ls_isg_table =  gnv_data.of_getitem('sys_tables','table_name',"table_id=" + string(ll_table_id) )
		of_set_table(ls_isg_table, 'ISG') //idw_cur_dw
		
		//initialize appt.
		If ls_isg_table= 'pd_basic' and idw_appointment.rowcount() < 1 then 
			idw_appointment.insertrow(0)
		End If
	End If
	
	//change record
	ls_audit_type_tmp = ids_caqh_log_items.getitemstring(i, 'audit_type')
	ll_seq_no_tmp = ids_caqh_log_items.getitemnumber(i, 'seq_no')
	If ls_audit_type_tmp <> ls_audit_type or ll_seq_no_tmp <>  ll_seq_no Then //new record
		ls_audit_type = ls_audit_type_tmp
		ll_seq_no = ll_seq_no_tmp
		
		//set current row
		If ls_audit_type = 'EW' Then
			ll_rowno = idw_cur_dw.find('rec_id = ' + string(ll_seq_no) , 1, idw_cur_dw.rowcount())
			If ll_rowno < 1 Then
				 inv_message.of_MessageBox("of_read_audit_data","Find Failed",true)
				return -1
			End If
		Else //'NW',new record
			ll_rowno = idw_cur_dw.insertrow(0)
		End If
	End If
	
	//currow and table_name, for new records.
	If ls_audit_type = 'NW' Then
		ids_caqh_log_items.setitem( i,'currow', ll_rowno)
		ids_caqh_log_items.setitem( i,'table_name', ls_isg_table)
	End If
	
	//item
	ls_isg_field =  ids_caqh_log_items.getitemstring(i, 'field_name')
	If ls_isg_field = 'mailing_address' Then //special column
		ls_type ='N'
	Else
		ls_type = gnv_data.of_get_sys_field_value(ls_isg_table ,ls_isg_field,"field_type") //lines moved from below
	End If
	ls_value =  ids_caqh_log_items.getitemstring(i, 'new_value')
	
	of_set_item(ls_type, ll_rowno , ls_isg_field, ls_value )		
Next


//set currow and table_name for some records (status <> -2 and audit_type = 'NW').  
//They are not accepted now ,but their audit_type and seq_no may need to refresh after getting the rec_id.
For i = 1 to ids_caqh_log_items.rowcount() 
	If not( ids_caqh_log_items.getitemnumber(i, 'status') <> -2 and  ids_caqh_log_items.getitemstring(i, 'audit_type') = 'NW' ) Then continue
	
	//find the same record
	ll_table_id = ids_caqh_log_items.getitemnumber(i, 'table_id')
	ll_seq_no = ids_caqh_log_items.getitemnumber(i, 'seq_no')
	ls_find = 'table_id = ' + string(ll_table_id) + ' and audit_type = "NW" and seq_no = ' + string(ll_seq_no) +" and status = -2 "
	ll_find = ids_caqh_log_items.find( ls_find, 1 , ids_caqh_log_items.rowcount())
	If ll_find> 0 Then
			//currow and table_name
			ids_caqh_log_items.setitem( i,'currow', ids_caqh_log_items.getitemnumber( ll_find,'currow'))
			ids_caqh_log_items.setitem( i,'table_name',  ids_caqh_log_items.getitemstring( ll_find,'table_name'))
	End If
Next

return 1

end function

public subroutine of_set_from_audit (boolean ab_from_audit);//====================================================================
//$<Function>: of_set_from_audit
//$<Arguments>:
// 	value    boolean    ab_from_audit 
//$<Return>:  (None)
//$<Description>: called from the w_caqh_audit.cb_accept
//$<Author>: (Appeon) long.zhang 03.18.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_from_audit = ab_from_audit
end subroutine

public function integer of_update_audit_items ();//====================================================================
//$<Function>: of_update_audit_items
//$<Arguments>:
//$<Return>:  integer
//$<Description>: refresh and update ids_caqh_log_items
//$<Author>: (Appeon) long.zhang 04.01.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if not ib_from_audit then return -1

long i , ll_cnt , ll_table_id_tmp, ll_rowno
long ll_table_id = 0, ll_rowno_tmp =0,ll_rec_id
string ls_sort, ls_audit_type_tmp,ls_audit_type ='',ls_isg_table
string ls_find
datetime ldt_CurrentTime

//ids_caqh_log_items is still sorted.

//get rec_ids from datawindows for new records.
For i = 1 to ids_caqh_log_items.rowcount() 
	//table_name was set when called of_read_audit_data. If table_name is not empty, then audit_type must be 'NW'.
	If  trim(ids_caqh_log_items.getitemstring(i, 'table_name')) = ''  Then continue
	 
	//change table
	ll_table_id_tmp = ids_caqh_log_items.getitemnumber(i, 'table_id')
	If ll_table_id_tmp <> ll_table_id Then //new table
		ll_table_id = ll_table_id_tmp
		
		ll_rowno = 0
		//set current table
		ls_isg_table =  ids_caqh_log_items.getitemstring(i, 'table_name')
		of_set_table(ls_isg_table, 'ISG') //idw_cur_dw
	End If
	
	//change record
	ll_rowno_tmp = ids_caqh_log_items.getitemnumber(i, 'currow')
	If ll_rowno_tmp <>  ll_rowno Then //new record
		ll_rowno = ll_rowno_tmp
		ll_rec_id = idw_cur_dw.getitemnumber(ll_rowno,'rec_id')
	End If
	
	//currow and table_name
	ids_caqh_log_items.setitem( i,'seq_no', ll_rec_id)
	ids_caqh_log_items.setitem( i,'audit_type', 'EW')
Next

//update audit_by,audit_date,status
ldt_CurrentTime = datetime(today(),now())

For i = 1 to ids_caqh_log_items.rowcount() 
	//table_name was set when called of_read_audit_data. If table_name is not empty, then audit_type must be 'NW'.
	If ids_caqh_log_items.getitemnumber(i, 'status') = -2  Then 
		ids_caqh_log_items.setitem( i,'status', 1) //accepted
		ids_caqh_log_items.setitem( i, "audit_by", gs_user_id)
		ids_caqh_log_items.setitem( i, "audit_date", ldt_CurrentTime)
	End If
Next

return 1
end function

public function integer of_import_audit_data (datastore ads_log_items, integer ai_num);//====================================================================
//$<Function>: of_import_audit_data
//$<Arguments>:
// 	value    datastore    ads_log_items
// 	value    integer      ai_num
//$<Return>:  integer
//$<Description>:only used by w_caqh_audit.cb_accept
//$<Author>: (Appeon) long.zhang 04.01.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer res

ids_caqh_log_items = ads_log_items

if ids_caqh_log_items.rowcount() = 0 Then return 0
il_log_id = ids_caqh_log_items.getitemnumber(1,'log_id')

open(w_caqh_import_progress)
w_caqh_import_progress.st_record.text = "Record " + string(ai_num) + ", Log Id " + string(il_log_id)

//1.Initialize variables and data cache
of_progress( 10, "Setting variables and data cache")

ids_dw_currow.Reset()
gnv_appeondb.of_startqueue( )
if ids_rules.rowcount() < 1 then ids_rules.retrieve(ii_verif )
if ids_questions.rowcount() < 1 then ids_questions.retrieve(ii_verif )
//if ids_caqh_refs.rowcount() < 1 then ids_caqh_refs.retrieve()
gnv_appeondb.of_commitqueue( )

//2.initialize DataWindows 
of_progress( 100, "Setting data cache")
of_set_dws( )
of_reset_lookups()

////build or find table records, set field values 
of_progress( 100, "Reading CAQH audit data.")	
of_read_audit_data()

//set rec and prac ids, create appointment/link/audit/verif records and save data
of_progress( 100, "Creating verifications and Audit records")	
res = of_update_data( )

if res = 1 then
	of_progress( 2000, "Provider Import complete.")	
else  //failed to save
	of_progress( 2000, "Process complete.  Import failed.")
	return res
end if

return 1
end function

public function integer of_set_provider_ids (); //Start Code Change ----06.08.2015 #V15 maha - added to set the provider values ourside the of_parse_file function
 //program should only read the first 'table' (provider).  Once it has read a second table drops out of the function

integer li_read
long i, ptable, pstar, ll_cnt
string ls_read, ls_field, ls_value, ls_table, ls_flag, ls_temp, ls_name
boolean lb_table_line = false 

//Parse the file
li_read = FileOpen ( is_parsed_file)
//debugbreak()
for i = 1 to 1000 
	if ll_cnt > 1 then exit  //once past the first table, drop out of the function
	if FileRead ( li_read, ls_read) = -100 then exit //end of file
	
	pstar = PosA(ls_read, "*" ,1)
	ptable = PosA(ls_read, "#%#%" ,1)  //table lines are identifed with these characters 

	if ptable > 0 then //if a table line
		ll_cnt++
		ls_table = MidA(ls_read,pstar + 2,PosA(ls_read," ID",1)  - pstar - 2)		

	else //data line
		ls_field = MidA(ls_read,1,pstar  - 1)
		ls_value = MidA(ls_read,pstar + 1)	
		if ls_field = "SSN" then is_ssn = ls_value
		if ls_field = "NID" then is_npi = ls_value
		if (ls_field = "NPI" and is_npi = '')  then is_npi = ls_value
		if upper(ls_field) = "LASTNAME" and isnull(is_last_name) then is_last_name = ls_value 
		if upper(ls_field) = "FIRSTNAME" and isnull(is_first_name) then is_first_name = ls_value 
	end if	
next

if len(is_ssn) < 1 and len(is_npi) < 1 then
	messagebox("Import Error","Neither NPI nor SSN is populated from the Import File.  There may be an issue with the file.  Please contact ISG support")
	return -2
end if

FileClose(li_read)

return 1
end function

public function integer of_check_active_status (integer al_screen, integer al_row); //Start Code Change ----08.07.2015 #V15 maha - check active status per record for verifications
 //if there is an active status field and it is not active value return 0 so it won't create the verification
 integer li_stat = 1
 
 if idw_cur_dw.describe("active_status.ColType") <> "!" then
	li_stat = idw_cur_dw.getitemnumber(al_row, "active_status")
	choose case li_stat
		case 0
			li_stat = 0
		case else  //includes if the value is null
			li_stat = 1
	end choose
end if
	
return li_stat
 
 
end function

public subroutine of_set_prov_id (long al_prov_id);//====================================================================
//$<Function>: of_set_prov_id
//$<Arguments>:
// 	value    long    al_prov_id
//$<Return>:  integer
//$<Description>: Set il_prov_id
//$<Author>: Appeon long.zhang 11.17.2016 (Bug id 5414 - Provider ID being set to '0' from CAQH XML import)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
il_prov_id = al_prov_id

end subroutine

on n_cst_caqh_import.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_caqh_import.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if isvalid(w_caqh_import_progress) then close(w_caqh_import_progress)

destroy ids_address_lookup 
destroy ids_refs
destroy ids_rules
destroy inv_data_entry
destroy  ids_questions
destroy  ids_committees

//caqh 2: alfee 12.18.2009
destroy ids_caqh_refs  
destroy ids_data_parsed
destroy ids_dw_currow 
destroy ids_caqh_log
destroy ids_default_values //CAQH Screen defaults - alfee 05.07.2014

end event

event constructor;IF of_get_app_setting("set_81","I") > 0 THEN ib_default_value = TRUE //CAQH Screen defaults - alfee 05.07.2014

ids_address_lookup = create datastore
ids_address_lookup.DataObject = "d_caqh_ds_lu_address"
ids_address_lookup.settransobject(sqlca)
ids_address_lookup.retrieve()

gnv_appeondb.of_startqueue() //CAQH Screen defaults - alfee 05.07.2014
ids_refs = CREATE n_ds
ids_refs.dataobject = "d_caqh_screen_reference_fields"
ids_refs.settransobject(sqlca)
ids_refs.retrieve(1)  //Start Code Change ----07.20.2009 #V92 maha - changed dw object and added retrieve here

//---------Begin Added by (Appeon)Alfee 05.07.2014 for CAQH Screen defaults ---------
ids_default_values = CREATE datastore
ids_default_values.dataobject = "d_sys_field_properties_4prf"
ids_default_values.settransobject( sqlca)
IF ib_default_value THEN ids_default_values.Retrieve(1)
gnv_appeondb.of_commitqueue()

IF ib_default_value THEN
	ids_default_values.SetFilter( 'Len(Trim(sys_fields_default_value)) > 0')
	ids_default_values.Filter( )
END IF
//---------End Added ----------------------------------------------------------------------------

ids_rules = CREATE n_ds
ids_rules.dataobject = "d_caqh_verification_rules"
ids_rules.settransobject(sqlca)

ids_questions = CREATE n_ds
ids_questions.dataobject = "d_caqh_questions"
ids_questions.settransobject(sqlca)

ids_committees = CREATE n_ds
//ids_committees.dataobject = "d_caqh_committees"
ids_committees.dataobject = "d_caqh_committee_lu" //CAQH 2: alfee 12.18.2009
ids_committees.settransobject(sqlca)

//----Begin Added by (caqh 2)alfee 12.18.2009-----
ids_caqh_log = CREATE n_ds
ids_caqh_log.dataobject = "d_caqh_log_prac"
ids_caqh_log.settransobject(sqlca)

ids_caqh_refs = CREATE n_ds
ids_caqh_refs.dataobject = "d_caqh_ref_fields"
ids_caqh_refs.settransobject(sqlca)

ids_data_parsed = CREATE n_ds
ids_data_parsed.dataobject = "d_caqh_data_parsed"
ids_data_parsed.settransobject(sqlca)

ids_dw_currow = CREATE n_ds
ids_dw_currow.dataobject = "d_caqh_isg_currow"
ids_dw_currow.settransobject(sqlca)
//----End Added --------------------------

inv_data_entry = create pfc_cst_nv_data_entry_functions


end event

