$PBExportHeader$w_batch_add_cred_data.srw
forward
global type w_batch_add_cred_data from w_master
end type
type dw_pracfacil from u_dw within w_batch_add_cred_data
end type
type st_4 from statictext within w_batch_add_cred_data
end type
type dw_facility_select from pfc_cst_u_org_facility_selector_vertical within w_batch_add_cred_data
end type
type dw_detail from u_dw within w_batch_add_cred_data
end type
type cb_2 from commandbutton within w_batch_add_cred_data
end type
type st_select from statictext within w_batch_add_cred_data
end type
type cb_batch from commandbutton within w_batch_add_cred_data
end type
type cb_search from commandbutton within w_batch_add_cred_data
end type
type dw_browse from u_dw within w_batch_add_cred_data
end type
type dw_table from datawindow within w_batch_add_cred_data
end type
type cb_run from commandbutton within w_batch_add_cred_data
end type
type st_2 from statictext within w_batch_add_cred_data
end type
type dw_list from datawindow within w_batch_add_cred_data
end type
type cb_1 from commandbutton within w_batch_add_cred_data
end type
type dw_3 from datawindow within w_batch_add_cred_data
end type
type dw_2 from datawindow within w_batch_add_cred_data
end type
type dw_detailxx from u_dw within w_batch_add_cred_data
end type
type st_1 from statictext within w_batch_add_cred_data
end type
type dw_verifww from datawindow within w_batch_add_cred_data
end type
type dw_verif from u_dw within w_batch_add_cred_data
end type
type dw_pracs from datawindow within w_batch_add_cred_data
end type
type dw_select_section from datawindow within w_batch_add_cred_data
end type
end forward

global type w_batch_add_cred_data from w_master
integer width = 3570
integer height = 2548
string title = "Batch Add Data"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean ib_disableclosequery = true
dw_pracfacil dw_pracfacil
st_4 st_4
dw_facility_select dw_facility_select
dw_detail dw_detail
cb_2 cb_2
st_select st_select
cb_batch cb_batch
cb_search cb_search
dw_browse dw_browse
dw_table dw_table
cb_run cb_run
st_2 st_2
dw_list dw_list
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
dw_detailxx dw_detailxx
st_1 st_1
dw_verifww dw_verifww
dw_verif dw_verif
dw_pracs dw_pracs
dw_select_section dw_select_section
end type
global w_batch_add_cred_data w_batch_add_cred_data

type variables
long il_pracid
long il_pracs[]
integer ii_clinid
long ii_facid
integer ii_facs[]
//integer ii_screen
long il_status
long il_reqst
string is_clin_filter
string is_prac_name
integer ii_message

Integer ii_screen_id
Integer ii_column_cnt
Integer ii_address_lnk_cnt
Integer il_last_de_row

Long il_prac_id 
Long il_rec_id
Long il_data_view = 1
Integer ii_org_id = 1
long ii_parent_facility_id 
long ii_org_parent  //maha 07.15.2015 
long il_affil_recid  //maha 07.15.2015 
long ii_verifying_facility_id
Long il_addr_id
long il_hosp_id
long il_gp_id //maha 06.30.2014

Boolean ib_screen_painter = False
Boolean ib_new_prac = False
Boolean ib_setup_dddw = True
Boolean ib_refresh_screen_list = False
Boolean ib_app_audit_complete = False
Boolean ib_win_just_opened = True
Boolean ib_deleting = False
Boolean ib_ezflow = False
Boolean is_rec_status
Boolean ib_addaddress = false 
Boolean ib_add = True  //maha 01.15.2012
Boolean ib_test_save = true //02.27.2014
boolean ib_facil_spec //maha 03.30.2017

String is_first_column_detail_1
String is_first_column_detail_2
String is_sql_syntax
String is_rec_id_col_nm
String is_column_names[]
String is_view_type = "D"
String is_lookup_search_column= "None"
String is_lookup_search_column_table = ""
String is_lookup_search_column_field= "None"  //maha 01.05.2014
String is_designer_type = "S"

//Start Code Change ----12.15.2016 #V153 maha
string is_ref_1
string is_ref_2 
string is_ref_3 
string is_type1
string is_type2 
string is_type3
string is_exp_field 
string is_screen_name 
string is_reference
integer ii_table_id
integer ii_validate 
integer il_data_status
long il_address_code
long il_response_code
double il_ver_method
long il_fee
datetime idt_exp_date
//End Code Change ----12.15.2016

Integer il_last_row = 1

pfc_cst_nv_data_entry_functions inv_data_entry



n_ds ids_ver_orgs_facilities
//n_ds ids_last_verif_seq_no
n_ds ids_dfl_rsp_code
n_ds ids_parent_facilities
n_ds ids_verif_facilities  //maha 011201
n_ds ids_facility_ver_rules  //maha 011201
n_ds ids_verif_info  //maha 011201


end variables

forward prototypes
public function integer of_create_verif (string as_reference)
public function string of_prac_name (long ai_pracid)
public function integer of_validate (integer ai_table, integer ai_row)
public function integer of_verif_values ()
public function integer of_reference ()
public function integer of_get_affils ()
public function integer of_filter_facility ()
end prototypes

public function integer of_create_verif (string as_reference);
Integer li_nr
Integer li_nr2 //maha 010401
Integer li_row_cnt
Integer li_rc
Integer i
Integer r
integer cnt1
integer cnt2
Integer ll_hc_code
Integer li_rsp_rc
Integer li_facility_id
Integer li_priority
integer li_dupe_check //maha 010401
integer li_isprime //maha 010901
integer resp //maha 010901
integer li_parent_id //maha 020901
integer li_date_check //maha 010901
integer li_fac_ids//maha 011001
integer pc//maha 011001
integer pi//maha 011001
integer li_end_year//maha 012301
integer li_end_month//maha 012301
integer li_end_day// maha 031201
integer li_check_back_years
integer li_prime_check//maha 012201
Integer li_facility_id_first = -1
long li_seq_no
Long ll_default_verif_method
long lll
//long ll_address_lookup_code
String ls_identifying_number
string ls_facility_name//maha 011001
String ls_doc_id
String ls_priority_user
string ls_primary_check //maha 010901
string ls_screen_name //maha 010401
string ls_appt_type = "R" //maha 012401
string ls_verif_data //maha 012401
string ls_mes //maha 111308
string ls_add_type = "A"
string ls_prac
string f

datetime ld_verifdate //maha 010901
datetime ld_dr //jad 06/03/02

IF il_address_code = 0 THEN
	SetNull(il_address_code  )
END IF

gnv_appeondb.of_startqueue( )


li_rc = ids_verif_facilities.rowcount() //retrieved in cb_run
//----Begin Added by Alfee 08.12.2009-------
gnv_appeondb.of_commitqueue( )

//cnt1 = ids_dfl_rsp_code.rowcount( )
li_rc = ids_verif_facilities.rowcount( )
//----End Added ----------------------------

//<add> 07/03/2007 by: Andy set sort first
ids_verif_facilities.setsort("verifying_facility A")
ids_verif_facilities.sort()
//	Return -1
//END IF


FOR i = 1 TO li_rc  //li_ver_fac_cnt
	
	li_date_check = 0
	li_facility_id = ids_verif_facilities.GetItemNumber( i, "verifying_facility" )
	ls_facility_name = ids_verif_facilities.GetItemstring( i, "facility_name" )
	ls_verif_data = ids_verif_facilities.GetItemstring( i, "verify_data" )
	
	if ls_verif_data = "N" then continue	
	debugbreak()
	pc = ids_parent_facilities.rowcount()
	//f = 'verifying_facility='+string(li_facility_id)+' and prac_id='+string(il_prac_id)
	pc = ids_parent_facilities.setfilter("verifying_facility=" + string(li_facility_id))
	if pc < 1 then 	messagebox("Filter Error","On parents of verif facility")
	pc = ids_parent_facilities.filter()
	pc = ids_parent_facilities.rowcount()
	
	if pc < 1 then 
		messagebox("Error","No retrieval on parents of verif facility")
		continue
	end if
	
	//checking all parents appttype to see if verif should be created maha 012401
	ls_appt_type = "R"
		
	

	for pi = 1 to pc
		lll =  ids_parent_facilities.GetItemNumber(pi, "rec_id")
		
		if ls_appt_type = "R" and ids_parent_facilities.GetItemstring( pi, "apptmnt_type" )  = "I" then
			ls_appt_type = "I"
		end if
		//checking verifs completed date for all parents	

		ld_verifdate = ids_parent_facilities.GetItemdatetime( pi , "date_verif_completed" )
		if not(isnull(ld_verifdate)) then
			li_date_check = 1		
			exit
		end if
	next
	//if ALL parents are recred and data item is Inital only, don't create.
	if ls_verif_data = "I" and ls_appt_type = "R" then continue

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-04
	//$<modify> 02.13.2006 By: Wangchao
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	
	//Start Code Change ---- 10.16.2007 #V7 maha
	//because this was poorly implemented and never tested, reverting to original code
	if li_date_check = 1 then
		//Start Code Change ----11.03.2008 #V85 maha = added option for yes or no all
		if ii_message < 2 then // 0 =  no or first time; yes = 1;    3 = yes all;      4 = no all
			ls_prac = of_prac_name(il_prac_id)
			ls_mes = "The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + " for practitioner " + ls_prac + " . Do you want to add the verification item?"
			openwithparm(w_verif_compl_message,ls_mes)
			ii_message = message.doubleparm
			//-----------appeon begin-------------
			//<$>Modified:long.zhang 11.06.2012
			//<$>reason:Fixed BugS110101 verification update failed
			//	if ii_message = 0 or ii_message = 4 then continue //no or no all
			if ii_message = 0 then continue
			if ii_message = 4 then return 1
			//-----------appeon end---------------
		end if
		//resp = messagebox("Verifications Completed" ,"The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + " for practitioner " + ls_prac + " . Do you want to add the verification item.",question!,yesno!,2)
		//if resp = 2 then continue
	end if
	//End Code Change---11.13.2008

	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 04.10.2017
	//<$>reason:Don't need filter because ids_verif_facilities will also be used in next loop. For Alpha id 5594 - Batch Add Demographics Error
//	ids_verif_facilities.setfilter('verifying_facility=' + string(li_facility_id))
////	ids_ver_orgs_facilities.setfilter('verifying_facility='+string(li_facility_id)+' and prac_id='+string(il_prac_id)+' and screen_id=15')
//	ids_verif_facilities.filter()
//	r= ids_verif_facilities.rowcount()	
	r = i
	//------------------- APPEON END -------------------
	
	//---------------------------- APPEON END ----------------------------
	
	if r < 1 then continue
	
	IF ids_verif_facilities.GetItemString( r, "verify_data" ) = "N" AND ls_add_type = "A" THEN
		CONTINUE
	END IF
		
	ll_default_verif_method = ids_verif_facilities.GetItemNumbeR( r, "default_verif_means" )		

	li_nr = dw_verif.InsertRow( 0 )
	ls_priority_user = ids_verif_facilities.GetItemString( r, "priority_user" )	
	li_priority = ids_verif_facilities.GetItemNumber( r, "priority" )	
 
	dw_verif.SetItem( li_nr, "prac_id", il_prac_id )
	dw_verif.SetItem( li_nr, "rec_id", il_rec_id )
	//dw_verif.SetItem( li_nr, "facility_id", li_facility_id )
	dw_verif.SetItem( li_nr, "verif_info_facility_id", li_facility_id )
	dw_verif.SetItem( li_nr, "priority_user", ls_priority_user )
	dw_verif.SetItem( li_nr, "priority", li_priority )
	dw_verif.SetItem( li_nr, "number_sent", 0 )
	dw_verif.SetItem( li_nr, "exp_credential_flag", 0)
	dw_verif.SetItem( li_nr, "active_status", 1)
	if dw_detail.Describe("active_status.ColType") <> "!" then
		dw_verif.SetItem( li_nr, "verif_info_data_status", dw_detail.getitemnumber(1,"active_status") ) //Start Code Change ----08.04.2008 #V85 maha - added data_status update
	end if
	//06/03/02
	//added in for IntelliApp only users,  need this entry auto verified so intellicred can gen exp letters when due
	IF Upper( gs_cust_type ) = 'I' THEN
			  dw_verif.SetItem( li_nr, "response_code", 326 )		
			  ld_dr = DateTime( Today(), Now() )
			  dw_verif.SetItem( li_nr, "date_recieved", ld_dr )					  
			  dw_verif.SetItem( li_nr, "user_name", 'System' )					  			  
	END IF	
		
	IF li_rsp_rc = 1 THEN//maha 04.21.09 - this code will not run because the retrieval will never retrieve anything.  should be rewritten to be 
							//consistant with the dataentry code and create app audit items via auto gen
		dw_verif.SetItem( li_nr, "response_code", ids_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
		dw_verif.SetItem( li_nr, "user_name", ls_priority_user )
		dw_verif.SetItem( li_nr, "date_recieved", Today() )
		ll_hc_code = Long(gnv_data.of_getitem('code_lookup','lookup_code','code="Hard Copy"'))
		dw_verif.SetItem( li_nr, "verification_method", ll_hc_code )				
	ELSE
		//added in for IntelliApp only users,  need this entry auto verified so intellicred can gen exp letters when due
		IF Upper( gs_cust_type ) = 'I' THEN
			  dw_verif.SetItem( li_nr, "response_code", 326 )		
			  ld_dr = DateTime( Today(), Now() )
			  dw_verif.SetItem( li_nr, "date_recieved", ld_dr )					  
			  dw_verif.SetItem( li_nr, "user_name", 'System' )					  			  
		END IF
		//set verif method only
		dw_verif.SetItem( li_nr, "verification_method", ll_default_verif_method )		
	END IF



	li_seq_no = 1 

	
	dw_verif.SetItem( li_nr, "seq_no", li_seq_no )		
	dw_verif.SetItem( li_nr, "screen_id", ii_screen_id )
	dw_verif.SetItem( li_nr, "reference_value",MidA(as_reference,1,100)) //maha added mid 022504 as trap for overlong values.as_reference )
	if not isnull( idt_exp_date) then
		dw_verif.SetItem( li_nr, "expiration_date", idt_exp_date )
	end if
	//dw_verif.SetItem( li_nr, "screen_name", "Insurance" )
	
	dw_verif.SetItem( li_nr, "address_lookup_code", il_address_code )
	
	
	if il_fee = 0 then
		setnull( il_fee )
	end if
	if not isnull( il_fee ) then
		dw_verif.SetItem( li_nr, "verif_info_fee", il_fee )
	end if
	
	dw_verif.SetItem(li_nr, 'create_date', datetime(today(),now()))
	dw_verif.SetItem(li_nr, 'create_user', gs_user_id)
	
	ls_doc_id = String( il_rec_id ) + "-" + String( il_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( li_seq_no )
	dw_verif.SetItem( li_nr, "doc_id", ls_doc_id )

END FOR

dw_verif.SetFocus()
dw_verif.ScrollToRow( li_nr )
dw_verif.SetRow( li_nr )


resp = dw_verif.Update()
if resp < 1 then //maha 072204
	messagebox("Update failure" ,"Update failed in of_add_record of pfc_cst_u_verification_info")
else
	commit using sqlca;
end if
//gnv_appeondb.of_commitqueue( ) commented by long.zhang 11.02.2012 no correct return value on web BugS110101 

RETURN 1
end function

public function string of_prac_name (long ai_pracid);string ls_prac_name

//_pracs.retrieve(il_pracs[])
select full_name into :ls_prac_name from v_full_name where prac_id = :ai_pracid;
//is_prac_name = ls_prac_name

return  ls_prac_name
end function

public function integer of_validate (integer ai_table, integer ai_row);//new function maha 080803  called from dw_detail pfc_preupdate
//function redesigned 072304 to allow validation on any credentialing data field - maha
long ll_data
string ls_data
integer i
integer ic
integer chk = 0
integer res
integer fc
integer f
integer v
integer c
integer ck
integer cc
boolean lb_run_syntax = false //maha 05.02.2013
long ll_recid
string ls_des
string ls_fname
string ls_tname
string ls_type
string ls_value
string ls_org_value   //maha 05.02.2013
string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
//Start Code Change ---- 10.02.2006 #635 maha  redesigned as well as corrected bug for more than 1 existing matching record
string ls_mess
string ls_npi //maha6.15.07
string ls_dea //maha 2.25.2014
string ls_date //maha 2.25.2014
date ld_date //maha 2.25.2014

n_ds lds_fields
n_ds lds_count

lds_fields = CREATE n_ds
lds_count = CREATE n_ds

lds_fields.dataobject = "d_validation_fields"
lds_fields.settransobject(sqlca)
fc = lds_fields.retrieve(ai_table)
ll_recid = dw_detail.getitemnumber(ai_row,"rec_id")

if fc = 0 then return 1

for f = 1 to fc
	 lb_run_syntax = false
	ck = 0
	ls_fname = lds_fields.getitemstring(f,"field_name")
	ls_tname = lds_fields.getitemstring(f,"table_name")
	v = lds_fields.getitemnumber(f,"use_validation")
	ls_type = upper(lds_fields.getitemstring(f,"field_type"))
//	if ai_table = 25 then  //basic info/personal data field trap maha 120604  //Start Code Change ----05.25.2011 #V11 maha - redundant to describe below
//		ck = 0
//		cc = integer(dw_detail.Object.DataWindow.column.count)
//		for c = 1 to cc  //if the column exists in the datawindow continue, else drop out of function
//			ls_des = dw_detail.describe("#" + string(c) + ".name" )
//			if ls_des = ls_fname then
//				ck = 1
//				exit
//			end if
//		next
//		if ck = 0 then return 1		
//	end if

//	if dw_detail.Describe( ls_fname + ".ColType") = "!" then return 1 //Start Code Change ---- 08.17.2007 #V7 maha  trap for none existant field on screen
	if dw_detail.Describe( ls_fname + ".ColType") = "!" then continue //Start Code Change ----05.25.2011 #V11 maha - changed to continue
	
	choose case ls_type
		case "N", "I","L"
			ls_value = string(dw_detail.getitemnumber(ai_row,ls_fname))
		case "C"
			ls_value = "'" + dw_detail.getitemstring(ai_row,ls_fname) + "'"
		case "D", "T" //not really going to work for the timestamps

			ls_value = "'" + string(dw_detail.getitemdatetime(ai_row,ls_fname)) + "'"
			if dw_detail.getitemdatetime(ai_row,ls_fname) < datetime(date("1900-01-01"), time('00:00:00')) then
				messagebox("Date validation", "Field " + ls_fname + " has a date less than 1900.  Please check your data" )
				return 1
			end if
			
		case else 
			messagebox("of_validation function error","Data type " + ls_type + " not coded for.  Data not validated.")
			return 1
	end choose
	
	ls_org_value = ls_value  //Start Code Change ----05.02.2013 #V12 maha
debugbreak()	
//Start Code Change ----06.16.2008 #V81 maha
	if v <> 5 then
		if isnull(ls_value) then continue
	end if
//End Code Change---.2008

	choose case v
		case 1 //unique warning
			ls_sql = "select * from " + ls_tname + " where " + ls_fname + " = " + ls_value + ";"
			ls_mess = "Field " + upper(ls_fname) + " is not unique in the database on row " + string(ai_row) + ".  Do you wish to add/update the record with the duplicated value?"
			 lb_run_syntax = true //Start Code Change ----05.02.2013 #V12 maha
		case 2 //unique
			ls_sql = "select * from " + ls_tname + " where " + ls_fname + " = " + ls_value + ";"
			ls_mess = "Field " + upper(ls_fname) + " is not unique in the database on row " + string(ai_row) + ".  You must correct to save the record."
			 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
		case 3 //dupe warning
			ls_sql = "select * from " + ls_tname + " where " + ls_fname + " = " + ls_value + " and prac_id = " + string(il_prac_id) + ";"
			ls_mess = "Field " + upper(ls_fname) + " is duplicated on row " + string(ai_row) + ".  Do you wish to add/update the record with the duplicated value?"
		 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
		case 4 // no dupes 
			ls_sql = "select * from " + ls_tname + " where " + ls_fname + " = " + ls_value + " and prac_id = " + string(il_prac_id) + ";"
			ls_mess = "Field " + upper(ls_fname) + " is duplicated on row " + string(ai_row) + ".  You must correct to save the record."
			 lb_run_syntax = true //Start Code Change ----05.02.2013 #V12 maha				
		case 5, 11 // special 
			debugbreak()
			choose case ls_fname
				case "special coded field"
					//specify the field name as the case and create code specific for that case. Test for table_id in the code.
				case "npi_number"  //Start Code Change ---- 06.15.2007 #V7 maha --will check for valid NPI format as well as unique value in the system.
					ls_npi = dw_detail.getitemstring(ai_row,ls_fname)
					// if len(ls_npi) = 0 then return 1 //Commented by Ken.Guo 2008-07-22
					If ls_npi = '' or isnull(ls_npi) Then Continue //Added by Ken.Guo 2008-07-22  //Start Code Change ----02.25.2014 #V14 maha - changed from return
					res = of_npi_validation(ls_npi ,"DE")  //Start Code Change ----04.23.2008 #V8 maha - this is an application function 
					if res < 0 then
						choose case res
							case -1
								ls_mess = "Invalid.  NPI number must be 10 Characters."
							case -2
								ls_mess = "Invalid.  NPI number can contain Numbers only."
							case -3
								ls_mess = "Invalid.  Not a valid NPI number"
						end choose
						messagebox("NPI Validation",ls_mess)
						return -1
						continue
					else //now set to check to see if it is unique
						ls_sql = "select * from " + ls_tname + " where npi_number = " + ls_value + ";"
						ls_mess = "Field NPI number is not unique in the database on row " + string(ai_row) + ".  You must correct to save the record."
						 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
						v = 2 //reset so the message will run
					end if
				case "ssn"  //Start Code Change ----05.02.2013 #V123 maha --will check for valid SSN format as well as unique value in the system.
					ls_npi = dw_detail.getitemstring(ai_row,ls_fname)
					// if len(ls_npi) = 0 then return 1 //Commented by Ken.Guo 2008-07-22
					If ls_npi = '' or isnull(ls_npi) Then Continue //Added by Ken.Guo 2008-07-22   //Start Code Change ----02.25.2014 #V14 maha - changed from return
					res = of_npi_validation(ls_npi ,"SSN")  //Start Code Change ----04.23.2008 #V8 maha - this is an application function 
					if res < 0 then
						choose case res
							case -1
								ls_mess = "Invalid.  SSN number must be 9 Characters."
							case -2
								ls_mess = "Invalid.  SSN can contain Numbers only."
						end choose
						messagebox("SSN Validation",ls_mess)
						return -1
						continue
					else //now set to check to see if it is unique
						ls_sql = "select * from " + ls_tname + " where ssn = " + ls_value + ";"
						ls_mess = "Field SSN is not unique in the database for  " + string(ai_row) + " " + ls_npi + " .  You must correct to save the record."
						v = 2 //reset so the message will run
					end if
				case "provider_id"  //Start Code Change ----10.26.2011 #V12 maha - added for mass gen - has not been tested as of this date
					if ai_table <> 25 then continue
					if not isnull(dw_detail.getitemstring(ai_row,ls_fname)) then continue
					select max(provider_id)  into :ls_data from pd_basic;
					If isnumber(ls_data) then 
						ll_data = long(ls_data)
						ll_data++
						dw_detail.setitem(ai_row,ls_fname,ll_data)
					end if
				
				case "end_date"
					res = inv_data_entry.of_record_validation( dw_detail)
					if res = -1 then return -1
				case "year_thru"
					res = inv_data_entry.of_record_validation( dw_detail)
					if res = -1 then return -1
				case else
					return 1
			end choose
		case 6 //unique and numeric //Start Code Change ----08.11.2009 #V92 maha - for inova
			ls_sql = "select * from " + ls_tname + " where " + ls_fname + " = " + ls_value + ";"
			ls_mess = "Field " + upper(ls_fname) + " is not unique in the database on record " + string(ai_row) + ".  Data must also be numeric. You must correct to save the record."
			ls_value = of_strip_char(	"'", ls_value,"") //strip the quotes so isnumber test will work
			 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
		case 7 //email validation//Start Code Change ----08.15.2012 #V12 maha
			ls_value = of_email_validation(ls_value)
			if ls_value = "-1" then
				return -1
			else
				dw_detail.setitem(ai_row,ls_fname,ls_value)
				return 1
			end if
		case 8 //TIN number and length 9   //Start Code Change ----05.02.2013 #V12 maha
			ls_value = trim(ls_value)
			ls_value = of_strip_char(	"-", ls_value,"") 
			ls_value = of_strip_char(	"'", ls_value,"") 

			if len(ls_value) <> 9 then
				messagebox("TIN Validation",ls_org_value  + " is Not a valid TIN (record " + string (f) + " ).  Must be 9 characters and all numbers")
				return -1
			end if
			if not isnumber(ls_value) then
				messagebox("TIN Validation", ls_org_value  + " is Not a valid TIN (record " + string (f) + " ).  Must be 9 characters and all numbers")
				return -1
			end if
		case 9 //valid date  //Start Code Change ----02.25.2014 #V14.2 maha - added 
			ls_date = of_strip_char(	"'", ls_value,"")  //remove the quotes added above
			ld_date = date(ls_date)
			if not isdate(ls_date) then
//				messagebox("Date Validation", "Invalid date for " + ls_fname + " for record " + string (f) + ".")
//				return -1
			elseif ld_date > RelativeDate(ld_date, 50) or ld_date < RelativeDate(ld_date, -100) then
				messagebox("Date Validation", "Invalid date for " + ls_fname + " for record " + string (f) + ".  Must be with in the last 100 years or the next 50 years.")
				return -1
			end if
		case 10 //DEA //total of 9: first 2 char the rest number   //Start Code Change ----02.25.2014 #V14.2 maha - added
			if dw_detail.getitemnumber(ai_row, "state") <> 90 then continue
		//	debugbreak()
			ls_dea = of_strip_char(	"'", ls_value,"")  //remove the quotes added above
			res =  inv_data_entry.of_validate_dea(ls_dea, "" )
			if res < 0 then
				choose case res
					case -1, -2 , -3 
						ls_mess = "Invalid DEA number ( " + ls_dea + " ) for record " + string (f) + ".  DEA number must be 9 Characters .  The first 2 characters, the rest numbers."
					case -4 
						ls_mess = "Invalid DEA number  ( " + ls_dea + " ) for record " + string (f) + ".  Second character must match the first letter of the last name of the provider."
					case -5
						ls_mess = "Invalid DEA number ( " + ls_dea + " ) for record " + string (f) + ".  Checksum error.  Please check data entry."
					case -6
						ls_mess = "Invalid DEA number  ( " + ls_dea + " ) for record " + string (f) + ". First character is not valid.  Valid first letters are A,B,F,G,M,P,R"	
				end choose
				messagebox("DEA Validation",ls_mess)
				return -1
				continue
			else //now set to check to see if it is unique
				ls_sql = "select * from " + ls_tname + " where license_number = " + ls_value + ";"
				ls_mess = "Field DEA number is not unique in the database for record " + string(ai_row) + " (" + ls_dea + " ).  You must correct to save the record."
				 lb_run_syntax = true  
				v = 2 //reset so the message will run
			end if
		case else
			return 1
	end choose

	if  lb_run_syntax = true then 
		ls_presentation_str = "style(type=grid)" 
		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
		lds_count.Create( ls_dwsyntax_str, ERRORS)
		lds_count.settransobject(sqlca)
		ck = lds_count.retrieve()
		if ck > 0 then
			if ck = 1 and ll_recid = lds_count.getitemnumber(1,"rec_id") then
				//it is ok
				if v = 6 then  //Start Code Change ----08.11.2009 #V92 maha - for inova
					if not isnumber(ls_value) then
						messagebox("Data Entry Validation Numeric Warning", "Field " + upper(ls_fname) + " must have numeric data only, and have a unique value.  You must correct to save the record.")
						return -1
					end if
				end if
						
			else
				choose case v //warning only
					case 1,3
						res = messagebox("Data Entry Validation Warning", ls_mess,question!,yesno!,2)
						if res = 2 then 
							return -1
						end if
					case 2,4
						res = messagebox("Data Entry Validation Warning", ls_mess) 
						return -1
					case 6  //Start Code Change ----08.11.2009 #V92 maha - for inova
						 res = messagebox("Data Entry Validation Warning", ls_mess) 
						return -1
				end choose
			end if
		else
			if v = 6 then  //Start Code Change ----08.11.2009 #V92 maha - for inova
					if not isnumber(ls_value) then
						messagebox("Data Entry Validation  Numeric Warning", "Field " + upper(ls_fname) + " must have numeric data only, and have a unique value.  You must correct to save the record.")
						return -1
					end if
				end if
		end if
	end if
	
next
//End Code Change---10.02.2006
destroy lds_count			
destroy lds_fields
return 1
end function

public function integer of_verif_values ();//Start Code Change ----12.15.2016 #V153 maha - copied from pfc_preupdate and modified
integer li_year
integer li_month
integer i = 1
integer li_facility_specific
integer li_len
integer li_retval
integer li_found
integer li_status
long ll_verif_response
string ls_val
datetime ldt_null_date
datawindowchild dwchild

setnull(ldt_null_date)

//check for status of record
IF dw_detail.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
	IF dw_detail.GetItemNumber( i, "active_status" ) < 1 THEN 
		return -1
	END IF
END IF	

	
// get month and year end for check back date passed in verification add
IF ii_screen_id  = 7 or ii_screen_id = 10 THEN  // training & hosp affil
	if dw_detail.Describe("year_thru.ColType") <> "!" then
		li_year = dw_detail.getitemnumber(i,"year_thru")
		if dw_detail.Describe("month_thru.ColType") <> "!" then
			li_month = dw_detail.getitemnumber(i,"month_thru")
		end if   
	elseif dw_detail.Describe("end_date.ColType") <> "!" then    
		li_year = year(date(dw_detail.getitemdatetime(i,"end_date")))
		li_month = month(date(dw_detail.getitemdatetime(i,"end_date")))
	end if
end if

li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(ii_table_id) ))
	
IF ii_screen_id = 19 THEN //specialty
	if dw_detail.Describe("board_code.ColType") = "!" then return -1	
	IF IsNull( dw_detail.GetItemNumber( i, "board_code" ) ) THEN 
		return -1
	ELSE
			il_address_code = dw_detail.GetItemNumber( i, "board_code" ) 
	END IF
ELSEIF li_facility_specific = 1 THEN //attest quest or group cov	
	if dw_detail.Describe("facility_id.ColType") <> "!" then  //Start Code Change ---- 01.25.07.2007 #V7 maha
		dw_detail.SetItem( i, "facility_id", ii_parent_facility_id )	
	end if	
END IF
	
IF ii_table_id = 72 THEN  //other verifications
	if dw_detail.Describe("verif_method.ColType") = "!" then 
		//leave as default -1
	else
		il_ver_method = dw_detail.GetItemNumber( i, "verif_method" )
		if isnull( il_ver_method) then il_ver_method = -1
	end if
End if

// strip space from last name
IF ii_screen_id = 1 THEN
	if dw_detail.Describe("last_name.ColType") <> "!" then 
		ls_val = dw_detail.GetItemString( i, "last_name" ) 
		li_len = len(ls_val)
		ls_val = of_strip_char("",ls_val, "@LASTNAME@")
		if len(ls_val) <> li_len then
			dw_detail.setitem(i,"last_name", ls_val)
		end if
	end if
end if		

//exp date
IF Len(is_exp_field) > 0 THEN
	IF is_exp_field = "certification_expires" THEN	
		idt_exp_date = DateTime(Date( String( dw_detail.GetItemNumber( i, is_exp_field ) ) + "-12-30"),Now())				
	ELSEIF is_exp_field = "cert_expiration_year" THEN
		li_month = dw_detail.GetItemNumber( i, "cert_expiration_month" )
		if isnull(li_month) then
			idt_exp_date = DateTime(Date( String( dw_detail.GetItemNumber( i, is_exp_field ) ) + "-12-30"),Now())			
		else
			idt_exp_date = DateTime(Date(String( dw_detail.GetItemNumber( i, is_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
		end if
	ELSE
		if dw_detail.Describe(is_exp_field + ".ColType") <> "!" then
			idt_exp_date = dw_detail.GetItemDateTime( i, is_exp_field )
		else
			//of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Painter for the view you are using.")
			return -1
		end if
	END IF
ELSE
	idt_exp_date = ldt_null_date
END IF
	
//get reference 1 data 		
if dw_detail.Describe(is_ref_1 + ".ColType") = "!"  or is_ref_1 = "" then //trap for invisible field maha 012104 
	messagebox("Problem getting reference 1 value for verification","Required Field " + is_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
	return 1
end if

li_retval = dw_detail.SetColumn( is_ref_1 )
IF li_retval = 1 THEN
	IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
		SetRedraw( True )
//				of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
		Return -1
	END IF
	li_retval = dw_detail.GetChild(is_ref_1, dwchild)
	IF li_retval = -1 THEN
		is_reference =  dw_detail.GetText()				
	ELSE
		dw_detail.SetColumn( is_ref_1 )
		li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
		IF li_found < 1 THEN // Add by Evan 05.04.2010 --- trap for row number
			is_reference = dw_detail.GetText()
		ELSEIF dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "code" THEN
			is_reference = dwchild.GetItemString( li_found, "code" )
			IF ii_screen_id = 4 THEN					
				if dw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							//of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
					return -1
				else
					il_address_code = dw_detail.GetItemNumber( i, "verifying_agency" )
				end if
			ELSEIF ii_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
				//do nothing, got the address code further up
			ELSE
				if is_type1 = "C" then //maha 050802 
					il_address_code = long(dw_detail.GetItemstring( i, is_ref_1 ))//maha 072501
				elseif is_type1 = "N" then //maha 050802
					il_address_code = dw_detail.GetItemNumber( i, is_ref_1 )
				end if
			END IF
		ELSEIF dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "entity_name" or dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
			if dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
				is_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed this to aloways use the entity name originalf the of containg the code as well, 
			else
				is_reference = dwchild.GetItemString( li_found, "entity_name_original" )
			end if
			if is_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
				il_address_code = long(dw_detail.GetItemstring( i, is_ref_1 ))//maha 072501
			elseif is_type1 = "N" then //maha 102501
				il_address_code = dw_detail.GetItemNumber( i, is_ref_1 )
			end if
		ELSEIF dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
			is_reference = dwchild.GetItemString( li_found, "description" )
			//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
			IF ii_screen_id = 4 THEN					
				if dw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
//					of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
					return -1
				else
					il_address_code = dw_detail.GetItemNumber( i, "verifying_agency" )
				end if
			ELSEIF ii_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
				//do nothing, got the address code further up
			ELSE
				if is_type1 = "C" then //maha 050802 
					il_address_code = long(dw_detail.GetItemstring( i, is_ref_1 ))//maha 072501
				elseif is_type1 = "N" then //maha 050802
					il_address_code = dw_detail.GetItemNumber( i, is_ref_1 )
				end if
			END IF
			//End Code Change---10.10.2007
		ELSE
			is_reference = dw_detail.GetText()			
		END IF
	END IF
ELSE
	is_reference = ""
END IF
		
		
If NOT Isnull(is_ref_2) THEN
	//get reference 2 data
	if dw_detail.Describe(is_ref_2 + ".ColType") = "!" or is_ref_2 = "" then //trap for invisible field maha 012104 
		messagebox("Problem getting reference 2 value for verification","Required Field " + is_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
		return 1
	end if
	li_retval = dw_detail.SetColumn( is_ref_2 )
	IF li_retval = 1 THEN
		IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
			SetRedraw( True )
			//of_error_message(is_ref_2,i,"Required", "The data field " + is_ref_2 + " is required.")
			Return -1
		END IF		
		li_retval = dw_detail.GetChild(is_ref_2, dwchild)
		IF li_retval = -1 THEN
			is_reference = is_reference + " - " + dw_detail.GetText()				
		ELSE
			dw_detail.SetColumn( is_ref_2 )
			li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
			if li_found > 0 then //trap added maha 021704
				IF dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "code" THEN
					is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "code" )
				ELSEIF dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "description" THEN
					is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "description" )					
				ELSEIF dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "entity_name" or dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
					if dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
						is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
					else
						is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
					end if
				ELSE
					is_reference = is_reference + " - " + dw_detail.GetText()
				END IF
			else
				is_reference = is_reference + " - " + ""
			end if
		END IF
	ELSE
		is_reference = is_reference + " - " + ""
	END IF
		is_reference = mid(is_reference,1,100) //maha 022704 4.1.1
END IF

if not(isnull(il_address_code)) then
	select fee into :il_fee from address_lookup where lookup_code = :il_address_code;
end if

//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
if dw_detail.Describe("active_status.ColType") <> "!" then
	li_status = dw_detail.getitemnumber(i,"active_status") //Start Code Change ----04.19.2010 V10 maha - changed from li_data_cr
end if
//End Code Change---08.01.2008

IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification

//IF parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_add_record( il_prac_id, ll_rec_id, li_screen_id, is_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status, ll_ver_method) = -1 THEN  //Start Code Change ----08.31.2011 #V11  maha  - added method argument //Start Code Change ----.2008 #V85 maha - added li_status argument


return 1
end function

public function integer of_reference (); //Start Code Change ----01.23.2017 #V153 maha

datetime ldt_null_date
datetime ldt_exp_date_original
integer li_retval
integer li_found
integer li_month
integer i = 1
datawindowchild dwchild

	IF NOT IsNull( is_ref_1 ) AND is_ref_1 <> "" THEN
		dw_detail.ScrollToRow( i )
		dw_detail.SetRow( i )

		//move expiration date to verif info table if there is one
		IF Len(is_exp_field) > 0 THEN
			IF is_exp_field = "certification_expires" THEN	
				idt_exp_date = DateTime(Date( String( dw_detail.GetItemNumber( i, is_exp_field ) ) + "-12-30"),Now())
				ldt_exp_date_original = DateTime(Date( String( dw_detail.GetItemNumber( i, is_exp_field, Primary!, True ) ) + "-12-30"),Now())				
			ELSEIF is_exp_field = "cert_expiration_year" THEN
				li_month = dw_detail.GetItemNumber( i, "cert_expiration_month" )
				if isnull(li_month) then
					idt_exp_date = DateTime(Date( String( dw_detail.GetItemNumber( i, is_exp_field ) ) + "-12-30"),Now())
					ldt_exp_date_original = DateTime(Date( String( dw_detail.GetItemNumber( i, is_exp_field, Primary!, True ) ) + "-12-30"),Now())				
				else
					idt_exp_date = DateTime(Date(String( dw_detail.GetItemNumber( i, is_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
					ldt_exp_date_original = DateTime(Date(String( dw_detail.GetItemNumber( i, is_exp_field, Primary!, True ) ) + "-" + String(li_month) + "-28"),Now())
				end if
			ELSE
				if dw_detail.Describe(is_exp_field + ".ColType") <> "!" then
					idt_exp_date = dw_detail.GetItemDateTime( i, is_exp_field )
					ldt_exp_date_original = dw_detail.GetItemDateTime( i, is_exp_field, Primary!, True )
				else
//					of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Painter for the view you are using.")
					return -1
				end if
			END IF
		ELSE
			idt_exp_date = ldt_null_date
			SetNull( ldt_exp_date_original )
		END IF
	
		//get reference 1 data 		
		if dw_detail.Describe(is_ref_1 + ".ColType") = "!"  or is_ref_1 = "" then //trap for invisible field maha 012104 
			messagebox("Problem getting reference 1 value for verification","Required Field " + is_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
			return 1
		end if
		li_retval = dw_detail.SetColumn( is_ref_1 )
		IF li_retval = 1 THEN
			IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
				SetRedraw( True )
//				of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
				Return -1
			END IF
			li_retval = dw_detail.GetChild(is_ref_1, dwchild)
			IF li_retval = -1 THEN
				is_reference =  dw_detail.GetText()				
			ELSE
				dw_detail.SetColumn( is_ref_1 )
				li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
				IF li_found < 1 THEN // Add by Evan 05.04.2010 --- trap for row number
					is_reference = dw_detail.GetText()
				ELSEIF dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "code" THEN
					is_reference = dwchild.GetItemString( li_found, "code" )
					IF ii_screen_id = 4 THEN					
						if dw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
//							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							return -1
						else
							il_address_code = dw_detail.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF ii_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if is_type1 = "C" then //maha 050802 
							il_address_code = long(dw_detail.GetItemstring( i, is_ref_1 ))//maha 072501
						elseif is_type1 = "N" then //maha 050802
							il_address_code = dw_detail.GetItemNumber( i, is_ref_1 )
						end if
					END IF
				ELSEIF dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "entity_name" or dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
					if dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
						is_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed this to aloways use the entity name originalf the of containg the code as well, 
					else
						is_reference = dwchild.GetItemString( li_found, "entity_name_original" )
					end if
					if is_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
						il_address_code = long(dw_detail.GetItemstring( i, is_ref_1 ))//maha 072501
					elseif is_type1 = "N" then //maha 102501
						il_address_code = dw_detail.GetItemNumber( i, is_ref_1 )
					end if
				ELSEIF dw_detail.Describe( is_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
					is_reference = dwchild.GetItemString( li_found, "description" )
					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
					IF ii_screen_id = 4 THEN					
						if dw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							return -1
						else
							il_address_code = dw_detail.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF ii_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if is_type1 = "C" then //maha 050802 
							il_address_code = long(dw_detail.GetItemstring( i, is_ref_1 ))//maha 072501
						elseif is_type1 = "N" then //maha 050802
							il_address_code = dw_detail.GetItemNumber( i, is_ref_1 )
						end if
					END IF
					//End Code Change---10.10.2007
				ELSE
					is_reference = dw_detail.GetText()			
				END IF
			END IF
		ELSE
			is_reference = ""
		END IF
	end if

	   If NOT Isnull(is_ref_2) THEN
			//get reference 2 data
			if dw_detail.Describe(is_ref_2 + ".ColType") = "!" or is_ref_2 = "" then //trap for invisible field maha 012104 
				messagebox("Problem getting reference 2 value for verification","Required Field " + is_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
				return 1
			end if
			li_retval = dw_detail.SetColumn( is_ref_2 )
			IF li_retval = 1 THEN
				IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
					SetRedraw( True )
//					of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
					Return -1
				END IF		
				li_retval = dw_detail.GetChild(is_ref_2, dwchild)
				IF li_retval = -1 THEN
					is_reference = is_reference + " - " + dw_detail.GetText()				
				ELSE
					dw_detail.SetColumn( is_ref_2 )
					li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
					if li_found > 0 then //trap added maha 021704
						IF dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "code" THEN
							is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "code" )
						ELSEIF dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "description" THEN
							is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "description" )					
						ELSEIF dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "entity_name" or dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
							if dw_detail.Describe( is_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
								is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
							else
								is_reference = is_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
							end if
						ELSE
							is_reference = is_reference + " - " + dw_detail.GetText()
						END IF
					else
						is_reference = is_reference + " - " + ""
					end if
				END IF
			ELSE
				is_reference = is_reference + " - " + ""
			END IF
			
			is_reference = mid(is_reference,1,100) //maha 022704 4.1.1
		END IF
		
		messagebox("is_reference" ,is_reference)
		
		return 1
end function

public function integer of_get_affils ();//of_get_affils()   //Start Code Change ----03.30.2017 #V153 maha

long ll_pracs[]
long r
long rc

for r = 1 to dw_pracs.rowcount()
	ll_pracs[r] = dw_pracs.getitemnumber(r,"prac_id")
next

dw_pracfacil.settransobject(sqlca)
dw_pracfacil.retrieve(ll_pracs)

return 1
end function

public function integer of_filter_facility ();//Start Code Change ----03.30.2017 #V153 maha

long r
long rc
long cnt
long ll_prac
integer f
string ls_find
string ls_filter = "prac_id in ( "
debugbreak()

dw_pracs.setfilter("")
dw_pracs.filter()

if ii_facid < 1 then
	 return 1
end if

rc = dw_pracfacil.rowcount()

for r = 1 to dw_pracs.rowcount()
	ll_prac = dw_pracs.getitemnumber(r, "prac_id")
	ls_find = "parent_facility_id = " + string(ii_facid) + " and prac_id = " + string(ll_prac)
	
	f = dw_pracfacil.find( ls_find, 1, rc)
	if f < 0 then messagebox("find failed", ls_find)
	
	if f > 0 then
		ls_filter+= string(ll_prac) + ","
		cnt++
	end if
next

if cnt < 1 then 
	ls_filter = "prac_id = -123456"
else
	ls_filter = leftA(ls_filter, len(ls_filter) - 1) + ")"
end if

f = dw_pracs.setfilter(ls_filter)

if f < 0 then messagebox("filter failed", ls_filter)
dw_pracs.filter()
	

return 1
end function

event open;call super::open;integer li_facility_id
integer s
integer f
datawindowchild dwchild


dw_table.settransobject(sqlca)
dw_table.retrieve()
dw_table.insertrow(1)

inv_data_entry = create pfc_cst_nv_data_entry_functions

inv_data_entry.of_setup_cache( )

dw_select_section.settransobject(sqlca)
dw_select_section.retrieve(1)


end event

on w_batch_add_cred_data.create
int iCurrent
call super::create
this.dw_pracfacil=create dw_pracfacil
this.st_4=create st_4
this.dw_facility_select=create dw_facility_select
this.dw_detail=create dw_detail
this.cb_2=create cb_2
this.st_select=create st_select
this.cb_batch=create cb_batch
this.cb_search=create cb_search
this.dw_browse=create dw_browse
this.dw_table=create dw_table
this.cb_run=create cb_run
this.st_2=create st_2
this.dw_list=create dw_list
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_detailxx=create dw_detailxx
this.st_1=create st_1
this.dw_verifww=create dw_verifww
this.dw_verif=create dw_verif
this.dw_pracs=create dw_pracs
this.dw_select_section=create dw_select_section
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pracfacil
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.dw_facility_select
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_select
this.Control[iCurrent+7]=this.cb_batch
this.Control[iCurrent+8]=this.cb_search
this.Control[iCurrent+9]=this.dw_browse
this.Control[iCurrent+10]=this.dw_table
this.Control[iCurrent+11]=this.cb_run
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.dw_list
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.dw_3
this.Control[iCurrent+16]=this.dw_2
this.Control[iCurrent+17]=this.dw_detailxx
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.dw_verifww
this.Control[iCurrent+20]=this.dw_verif
this.Control[iCurrent+21]=this.dw_pracs
this.Control[iCurrent+22]=this.dw_select_section
end on

on w_batch_add_cred_data.destroy
call super::destroy
destroy(this.dw_pracfacil)
destroy(this.st_4)
destroy(this.dw_facility_select)
destroy(this.dw_detail)
destroy(this.cb_2)
destroy(this.st_select)
destroy(this.cb_batch)
destroy(this.cb_search)
destroy(this.dw_browse)
destroy(this.dw_table)
destroy(this.cb_run)
destroy(this.st_2)
destroy(this.dw_list)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_detailxx)
destroy(this.st_1)
destroy(this.dw_verifww)
destroy(this.dw_verif)
destroy(this.dw_pracs)
destroy(this.dw_select_section)
end on

event closequery;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2005-11-15 By: Zhang Lingping
//$<reason> The datawindow "dw_batchlist"  does not need save.

return super::event closequery() 
//---------------------------- APPEON END ----------------------------


end event

event pfc_save;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 21 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

// override
if dw_pracs.rowcount( ) > 0 then 
     super::event pfc_save()
end if

return success
end event

event close;call super::close;destroy inv_data_entry
end event

type dw_pracfacil from u_dw within w_batch_add_cred_data
integer x = 3584
integer y = 292
integer width = 814
integer height = 1896
integer taborder = 10
string dataobject = "d_prac_affils_for_pt"
end type

type st_4 from statictext within w_batch_add_cred_data
integer x = 928
integer y = 44
integer width = 370
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
boolean enabled = false
string text = "2) Select Screen"
boolean focusrectangle = false
end type

type dw_facility_select from pfc_cst_u_org_facility_selector_vertical within w_batch_add_cred_data
boolean visible = false
integer x = 2098
integer y = 100
integer width = 946
integer height = 80
integer taborder = 90
string dataobject = "d_org_facility_select_vertical_no_label"
end type

event constructor;
DataWindowChild dwchild

This.SetTransObject( SQLCA )
//This.InsertRow( 0 )
If This.RowCount() < 1 Then This.InsertRow(0) //alfee 11.24.2009

This.GetChild( "facility_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( gs_user_id )
dwchild.InsertRow(1)

This.SetItem( 1, "facility_id", 0 )	


end event

event itemchanged;ii_facid = long(data)

if isnull(ii_facid) then ii_facid = 0

of_filter_facility()


end event

type dw_detail from u_dw within w_batch_add_cred_data
event ue_showlist pbm_custom01
event pfc_cst_preupdate pbm_custom02
event pfc_after_select ( )
event type integer ue_after_itemchanged ( string as_type )
integer x = 896
integer y = 292
integer width = 2638
integer height = 2160
integer taborder = 40
boolean bringtotop = true
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_after_select;This.SetFocus()
This.SetColumn( is_first_column_detail_1 )





end event

event type integer ue_after_itemchanged(string as_type);//maha 8-2005

string s

//s = String(Message.LongParm, "address")
////messagebox("s",s)
//of_lookup_search_dddw(s)

return 1
end event

event buttonclicked;DataWindowChild dwchild
string s
string ls_phone
long v

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.03.2006 By: LeiWei
//$<reason> Fix a defect.
IF ib_screen_painter THEN RETURN
//---------------------------- APPEON END ----------------------------

IF dwo.Name = "linkbutton" THEN
//	IF This.GetItemStatus( row, 0, Primary! ) = New! or This.GetItemStatus( row, 0, Primary! ) = NewModified! THEN
//		MessageBox("Save", "You need to first save the address record before applying address links." )
//		Return
//	ELSE
//		OpenWithParm( w_address_link, String( il_prac_id ) + "-" + String( dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id")) )	
//		//\/maha 080300
//		dw_link_list.retrieve( dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id")) 
//		//\maha
//	END IF
ELSEIF dwo.Name = "findbutton" THEN
	 //Start Code Change ----07.23.2015 #V15 maha - changed to function
//	of_find_address( )
//	integer set1
////	select set_1
////	into :set1
////	from icred_settings;
//	set1 = of_get_app_setting("set_1","I")
//	
//	long ll_addr[ ]
//	Integer li_cr
//	Integer a
//	Integer li_address_cnt
//	gs_pass_ids ids
//	
//	if set1 <> 1 then 
//		
//		IF dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = DataModifIed! THEN
//			IF parent_window.Event pfc_Save() <> 1 THEN
//				Return
//			END IF
//	   END IF		
//		
//		
//		Open(w_practice_to_addr_find_new) 
//			
//		ids = Message.PowerObjectParm
//			
//		IF ids.l_ids[1] = 0 THEN
//			Return
//		END IF
//			
//		ll_addr[] = ids.l_ids[]
//			
//		li_address_cnt = UpperBound( ids.l_ids[] )
//			
//			
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-21
//		//$<modify> 2006-04-10 By: owen chen
//		//$<reason> Performance tuning modification
//		//$<modification> Use datawindow to retrieve data from the database instead 
//		//$<modification> of using SQLs in PT-22.
// 		/*
//		dw_addresses.dataobject = "d_group_data_entry"
//		dw_addresses.SetTransObject( SQLCA )
//		*/
//		dw_addresses.dataobject = "d_group_data_entry_for_pt"
//		dw_addresses.SetTransObject( SQLCA )
//		
//		if upperbound(ll_addr)>0 then
//			dw_addresses.Retrieve( ll_addr )
//		end if
//		
//		ib_addaddress = true
//		//---------------------------- APPEON END ----------------------------
//			
//		FOR a = 1 TO li_address_cnt
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<ID> PT-22
//			//$<modify> 2006-04-10 By: owen chen
//			//$<reason> Performance tuning modification
//			//$<modification> Write script to retrieve data from a cache in PT-21 instead of from the database. 
//			/*
//			dw_addresses.retrieve(  ll_addr[a] )
//			*/
//			dw_addresses.setfilter('rec_id = '+ string ( ll_addr[a] ))
//			dw_addresses.filter( )
//			//---------------------------- APPEON END ----------------------------
//			if gi_temp_switch = 0 then //maha 083004 for adds
//				IF a = 1 AND dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = NewModifIed! OR dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = New! THEN
//					dw_detail.DeleteRow( dw_detail.GetRow( ) )
//				END IF
//				this.triggerevent("pfc_addrow") //maha 090104 replaced insertrow()
//				li_cr = dw_detail.rowcount()
//				//li_cr = dw_detail.InsertRow( 0 )
//				//debugbreak()
//				//inv_data_entry.of_set_defaults( dw_detail, dw_detail.RowCount() )
//			else //maha 083004 to allow updating a record again
//				li_cr = dw_detail.getRow()
//			end if
//
//			if This.Describe("gp_id.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"gp_id", ll_addr[a] )
//			end if
//			if This.Describe("street.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"street",dw_addresses.getitemstring( 1,"street"))
//			end if
//
//			if This.Describe("street_2.ColType") <> "!" then			
//				dw_detail.setitem( li_cr,"street_2",dw_addresses.getitemstring( 1,"street_2"))
//			end if
//			
//			if This.Describe("alias_name.ColType") <> "!" then  //Start Code Change ----04.25.2014 #V14.2 maha
//				dw_detail.setitem( li_cr,"alias_name",dw_addresses.getitemstring( 1,"street"))
//			end if
//			
//			if This.Describe("city.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"city",dw_addresses.getitemstring( 1,"city"))
//			end if
//			if This.Describe("state.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"state",dw_addresses.getitemnumber( 1,"state") )
//			end if
//			if This.Describe("zip.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"zip",dw_addresses.getitemstring( 1,"zip"))
//			end if
//			if This.Describe("county.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"county",dw_addresses.getitemnumber( 1,"county"))
//			end if
//			if This.Describe("country.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"country",dw_addresses.getitemnumber( 1,"country"))
//			end if
//			if This.Describe("phone.ColType") <> "!" then
//				//Start Code Change ----02.02.2009 #V92 maha - added if statement
//					//Start Code Change ----06.10.2008 #V81 maha - strip format characters
//				ls_phone = dw_addresses.getitemstring( 1,"phone") 
//				if this.describe("phone.EditMask.Mask") = "(###)###-####" then
//					ls_phone =  of_strip_char("", ls_phone, "@NUM@")
//				end if
//				
//				dw_detail.setitem( li_cr,"phone",ls_phone)
//					//End Code Change---06.10.2008
//				//End Code Change---02.02.2009
//			end if
//			
//			if This.Describe("ext.ColType") <> "!" then  //Start Code Change ----08.12.2011 #V11 maha -  added extension field
//				dw_detail.setitem( li_cr,"ext",dw_addresses.getitemstring( 1,"ext"))
//			end if
//			
//			if This.Describe("fax.ColType") <> "!" then
//				//Start Code Change ----02.02.2009 #V92 maha - added trap for formatted field
//				ls_phone = dw_addresses.getitemstring( 1,"fax") 
//				if this.describe("fax.EditMask.Mask") = "(###)###-####" then
//					ls_phone =  of_strip_char("", ls_phone, "@NUM@")
//				end if
//				dw_detail.setitem( li_cr,"fax",ls_phone)
//				//dw_detail.setitem( li_cr,"fax",dw_addresses.getitemstring( 1,"fax"))
//				//End Code Change---02.02.2009
//			end if
//			if This.Describe("e_mail_address.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"e_mail_address",dw_addresses.getitemstring( 1,"e_mail_address"))
//			end if
//			if This.Describe("web_address.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"web_address",dw_addresses.getitemstring( 1,"web_address"))
//			end if
//			if This.Describe("contact_person.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"contact_person",dw_addresses.getitemstring( 1,"contact_person"))
//			end if
//			if This.Describe("business_mgr.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"business_mgr",dw_addresses.getitemstring( 1,"business_mgr"))
//			end if
//			if This.Describe("office_mgr.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"office_mgr",dw_addresses.getitemstring( 1,"office_mgr"))
//			end if
//			if This.Describe("tax_id.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tax_id",dw_addresses.getitemstring( 1,"tax_id"))
//			end if
//			if This.Describe("tax_id_other_1.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tax_id_other_1",dw_addresses.getitemstring( 1,"tax_id_other_1"))
//			end if
//			if This.Describe("tax_id_other_2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tax_id_other_2",dw_addresses.getitemstring( 1,"tax_id_other_2"))
//			end if
//			if This.Describe("routine_visit_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"routine_visit_appt",dw_addresses.getitemstring( 1,"routine_visit_appt"))
//			end if
//			if This.Describe("urgent_visit_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"urgent_visit_appt",dw_addresses.getitemstring( 1,"urgent_visit_appt"))
//			end if
//			if This.Describe("emergency_visit_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"emergency_visit_appt",dw_addresses.getitemstring( 1,"emergency_visit_appt"))
//			end if
//	
//			if This.Describe("handicapped_access.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"handicapped_access",dw_addresses.getitemnumber( 1,"handicapped_access"))
//			end if
//				if This.Describe("public_transportation.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"public_transportation",dw_addresses.getitemnumber( 1,"public_transportation"))
//			end if
//			if This.Describe("non_emergency_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"non_emergency_appt",dw_addresses.getitemstring( 1,"non_emergency_appt"))
//			end if
//		
//			if This.Describe("mon_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"mon_from",dw_addresses.getitemstring( 1,"mon_from"))
//			end if
//			if This.Describe("mon_to.ColType") <> "!" then
//			dw_detail.setitem( li_cr,"mon_to",dw_addresses.getitemstring( 1,"mon_to"))
//			end if
//			if This.Describe("tue_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_from",dw_addresses.getitemstring( 1,"tue_from"))
//			end if
//			if This.Describe("tue_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_to",dw_addresses.getitemstring( 1,"tue_to"))
//			end if
//			if This.Describe("wed_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_from",dw_addresses.getitemstring( 1,"wed_from"))
//			end if
//			if This.Describe("wed_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_to",dw_addresses.getitemstring( 1,"wed_to"))
//			end if
//			if This.Describe("thu_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_from",dw_addresses.getitemstring( 1,"thu_from"))
//			end if
//			if This.Describe("thu_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_to",dw_addresses.getitemstring( 1,"thu_to"))
//			end if
//			if This.Describe("fri_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_from",dw_addresses.getitemstring( 1,"fri_from"))
//			end if
//			if This.Describe("fri_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_to",dw_addresses.getitemstring( 1,"fri_to"))
//			end if
//			if This.Describe("sat_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_from",dw_addresses.getitemstring( 1,"sat_from"))
//			end if
//			if This.Describe("sat_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_to",dw_addresses.getitemstring( 1,"sat_to"))
//			end if
//			if This.Describe("sun_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_from",dw_addresses.getitemstring( 1,"sun_from"))
//			end if
//			if This.Describe("sun_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_to",dw_addresses.getitemstring( 1,"sun_to"))
//			end if
//			if This.Describe("mon_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"mon_from2",dw_addresses.getitemstring( 1,"mon_from2"))
//			end if
//			if This.Describe("mon_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"mon_to2",dw_addresses.getitemstring( 1,"mon_to2"))
//			end if
//			if This.Describe("tue_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_from2",dw_addresses.getitemstring( 1,"tue_from2"))
//			end if
//			if This.Describe("tue_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_to2",dw_addresses.getitemstring( 1,"tue_to2"))
//			end if
//			if This.Describe("wed_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_from2",dw_addresses.getitemstring( 1,"wed_from2"))
//			end if
//			if This.Describe("wed_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_to2",dw_addresses.getitemstring( 1,"wed_to2"))
//			end if
//			if This.Describe("thu_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_from2",dw_addresses.getitemstring( 1,"thu_from2"))
//			end if
//			if This.Describe("thu_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_to2",dw_addresses.getitemstring( 1,"thu_to2"))
//			end if
//			if This.Describe("fri_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_from2",dw_addresses.getitemstring( 1,"fri_from2"))
//			end if
//			if This.Describe("fri_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_to2",dw_addresses.getitemstring( 1,"fri_to2"))
//			end if
//			if This.Describe("sat_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_from2",dw_addresses.getitemstring( 1,"sat_from2"))
//			end if
//			if This.Describe("sat_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_to2",dw_addresses.getitemstring( 1,"sat_to2"))
//			end if
//			if This.Describe("sun_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_from2",dw_addresses.getitemstring( 1,"sun_from2"))
//			end if
//			if This.Describe("sun_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_to2",dw_addresses.getitemstring( 1,"sun_to2"))
//			end if
//			if This.Describe("cust_1.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_1",dw_addresses.getitemstring( 1,"cust_1"))
//			end if
//			if This.Describe("cust_2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_2",dw_addresses.getitemstring( 1,"cust_2"))
//			end if
//			if This.Describe("cust_3.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_3",dw_addresses.getitemstring( 1,"cust_3"))
//			end if
//			if This.Describe("cust_4.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_4",dw_addresses.getitemstring( 1,"cust_4"))
//			end if
//			if This.Describe("cust_5.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_5",dw_addresses.getitemstring( 1,"cust_5"))
//			end if
//			if This.Describe("cust_6.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_6",dw_addresses.getitemstring( 1,"cust_6"))
//			end if
//			//-------------------appeon begin---------------------
//			//<$>added : long.zhang 07.09.2012
//			//<$>reason:	v12.2 group locatiion mini-painter
//			if This.Describe("cust_7.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_7",dw_addresses.getitemstring( 1,"cust_7"))
//			end if
//			if This.Describe("cust_8.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_8",dw_addresses.getitemstring( 1,"cust_8"))
//			end if
//			if This.Describe("cust_9.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_9",dw_addresses.getitemstring( 1,"cust_9"))
//			end if
//			if This.Describe("cust_10.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_10",dw_addresses.getitemstring( 1,"cust_10"))
//			end if
//			if This.Describe("cust_d1.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_d1",dw_addresses.getItemDatetime( 1,"cust_d1"))
//			end if
//			if This.Describe("cust_d2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_d2",dw_addresses.getItemDatetime( 1,"cust_d2"))
//			end if
//			//------------------appeon end------------------------
//
//			//Start Code Change ---- 12.21.2006 #V7 maha
//			if This.Describe("suite_apart.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"suite_apart",dw_addresses.getitemstring( 1,"suite_apart"))
//			end if
//			//End Code Change---12.21.2006
//			
//
//			inv_data_entry.of_set_defaults( This, This.RowCount() )//Start Code Change ----07.13.2012 #V12 maha - removed; overwriting needed values //Start Code Change ----09.11.2012 #V12 maha - readded after modification the the default set function.
//			
//		END FOR	
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2005-04-10 By: owen chen
//		//$<reason> Performance tuning modification
//		//$<reason> Reduce the frequency of client-server interactions to improve runtime performance 
// 
// 		ib_addaddress = false
//		
//		dw_link_list.retrieve(il_addr_id)
//		
//		int li_retval
//		li_retval = parent_window.Event Pfc_Save( )
//		IF li_retval < 0 THEN
//			This.PostEvent( "pfc_cst_after_error" )
//		END IF
//		
//		//---------------------------- APPEON END ----------------------------
//		
//		if gi_temp_switch = 0 then //maha 083004 when adding	
//			IF li_address_cnt > 0 THEN
//				dw_browse.scrolltorow(dw_browse.rowcount()) //maha 012704
//				dw_browse.setrow(dw_browse.rowcount())
//				dw_browse.selectrow(0,false)
//				dw_browse.selectrow(dw_browse.rowcount(),true)
//				if li_address_cnt > 1 THEN
//					MessageBox("Reminder", "Go to each Address record and set up the Address Link data." )
//				end if
//			END IF
//						
//			dw_link_list.Retrieve( dw_detail.GetItemNumber( dw_detail.GetRow( ), "rec_id")  )
//		else //when updating
//			gi_temp_switch = 0
//			
//		end if
//
//	else //old find function based on addresses
//		This.GetChild( "street", dwchild )
//		dwchild.SetTransObject( SQLCA )
//		dwchild.Retrieve( "%" + This.GetText() + "%" )
//		//This.SetText( "" )
//	end if
//

//Start Code Change ----02.08.2013 #V12 maha	- no longer supported after 12.2
//ELSEIF dwo.Name = "populatebutton" THEN //used with old find function
//
//	Integer li_row_cnt
//	String ls_rec_id	
//	String ls_grey
//	String ls_presentation_str
//	String ls_dwsyntax_str
//	String ERRORS
//	String ls_syntax
//	
//	ls_syntax = is_sql_syntax
//	
//
//	This.AcceptText()
//	ls_rec_id = This.GetItemString( row, "street" ) 
//	
//	///Start Code Change ----.2010 #V10 maha/--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 06.30.2006 By: Liang QingShi
//	//$<reason> Fix a bug
//	if long(ls_rec_id) <= 0 then return -1
//	//---------------------------- APPEON END ----------------------------
//
//	ls_syntax = ls_syntax + " WHERE pd_address.rec_id = " + ls_rec_id
//	
//	ls_grey = String(rgb(192,192,192))
//	ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  
//
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_syntax, &
//		ls_presentation_str, ERRORS)
//
//	IF Len(ERRORS) > 0 THEN
//		MessageBox("Caution", &
//		"SyntaxFromSQL caused these errors: " + ERRORS)
//		RETURN -1
//	END IF
//
//	dw_addresses.Create( ls_dwsyntax_str, ERRORS)
//
//	IF Len(ERRORS) > 0 THEN
//		MessageBox("Caution", &
//		"Create cause these errors: " + ERRORS)
//		RETURN -1
//	END IF
//	
//	dw_addresses.of_SetTransObject( SQLCA )
//	li_row_cnt = dw_addresses.Retrieve(  )
//	IF li_row_cnt = 0 THEN
//		MessageBox("Error", "Nothing to select.")
//		Return -1
//	END IF
//
//	This.DeleteRow( row )
//	
//	dw_addresses.RowsCopy ( 1, 1, Primary!, This, 1000, Primary! )
//
//	This.ScrollToRow( This.RowCount() )
//	This.SetRow( This.RowCount() )	
//	
//	This.AcceptText()
//
//	This.GetChild( "street", dwchild )
//	dwchild.Reset()
//\/maha 062801  peer lookup select
elseif dwo.Name = "peerbutton" THEN
	//------------------- APPEON BEGIN -------------------
	//$<modify> 03.10.2009 By: Evan
	//$<reason> Peer reference new feature
	/*
	long ll_peer_id
	integer p
	open(w_select_peer)
	ll_peer_id = message.doubleparm
	IF ll_peer_id < 1 THEN  //Start Code Change ----02.28.2008 #V8 maha  - IF ll_peer_id = 0 THEN
		Return
	END IF
	//messagebox("ll_peer_id",ll_peer_id)
	
	dw_addresses.dataobject = "d_peer_lu_select"
	dw_addresses.SetTransObject( SQLCA )
	p = dw_addresses.Retrieve( ll_peer_id )
	
	//Start Code Change ----02.28.2008 #V8 maha  - trap for bad retrieval
	if p < 1 then
		messagebox("Peer Populate","Unable to get the selected peer data.")
		return
	end if
	//End Code Change---02.28.2008
	
	li_cr = dw_detail.GetRow()

	if This.Describe("title.ColType") <> "!" then
		dw_detail.setitem( li_cr,"title", long(dw_addresses.getitemstring( 1,"contact_salutation")))
	end if
	if This.Describe("last_name.ColType") <> "!" then
		dw_detail.setitem( li_cr,"last_name",dw_addresses.getitemstring( 1,"entity_name"))
	end if
	if This.Describe("first_middle_name.ColType") <> "!" then
		dw_detail.setitem( li_cr,"first_middle_name",dw_addresses.getitemstring( 1,"street2"))
	end if
	if This.Describe("name_suffix.ColType") <> "!" then
		dw_detail.setitem( li_cr,"name_suffix",long(dw_addresses.getitemstring( 1,"web_address")))
	end if
	if This.Describe("prof_suffix.ColType") <> "!" then
		dw_detail.setitem( li_cr,"prof_suffix",long(dw_addresses.getitemstring( 1,"contact_name")))
	end if
	if This.Describe("street.ColType") <> "!" then
		dw_detail.setitem( li_cr,"street",dw_addresses.getitemstring( 1,"street1"))
	end if
	if This.Describe("city.ColType") <> "!" then
		dw_detail.setitem( li_cr,"city",dw_addresses.getitemstring( 1,"city"))
	end if
	if This.Describe("state.ColType") <> "!" then
		dw_detail.setitem( li_cr,"state",long(dw_addresses.getitemstring( 1,"state") ))
	end if
	if This.Describe("zip.ColType") <> "!" then
		dw_detail.setitem( li_cr,"zip",dw_addresses.getitemstring( 1,"zip"))
	end if
	if This.Describe("country.ColType") <> "!" then
		dw_detail.setitem( li_cr,"country",long(dw_addresses.getitemstring( 1,"country")))
	end if
	if This.Describe("cust_5.ColType") <> "!" then
		dw_detail.setitem( li_cr,"cust_5",dw_addresses.getitemstring( 1,"phone"))
	end if
	if This.Describe("cust_1.ColType") <> "!" then
		dw_detail.setitem( li_cr,"cust_1",dw_addresses.getitemstring( 1,"custom_3"))
	end if
	if This.Describe("cust_2.ColType") <> "!"  then
		dw_detail.setitem( li_cr,"cust_2",dw_addresses.getitemstring( 1,"custom_4"))
	end if
//	s = This.Describe("cust_3") 
//	messagebox("s",s)
	if This.Describe("cust_3.ColType") <> "!" then
		dw_detail.setitem( li_cr,"cust_3",dw_addresses.getitemstring( 1,"custom_5"))
	end if
	//Start Code Change ---- 04.11.2007 #V7 maha
	if This.Describe("fax.ColType") <> "!" then
		dw_detail.setitem( li_cr,"fax",dw_addresses.getitemstring( 1,"fax"))
	end if
	if This.Describe("e_mail_address.ColType") <> "!" then
		dw_detail.setitem( li_cr,"e_mail_address",dw_addresses.getitemstring( 1,"email_address"))
	end if
	//End Code Change---04.11.2007	
//\maha	
	*/
	OpenWithParm(w_peer_reference_select, this)
	//------------------- APPEON END ---------------------
ELSEIF dwo.Name = "imgbutton" THEN //SK Practitioner Folder - alfee 09.10.2010
	if of_get_app_setting("image_storage_type","I") = 0 then//Start Code Change ----05.11.2011 #V11 maha - trap for images on hard drive
		messagebox("View Images","This functionality is only available if your images are stored in the database.  Please view your images from the Documents tab.~r~rContact ISG support for assistance in migrating your images to the database.")
		return
	end if
	IF il_prac_id > 0 and ii_screen_id > 0 THEN
		//-------------------------------APPEON BEGIN--------------------
		//$<Modified> long.zhang 11.04.2011
		//$<Reason> view image
		//OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id))
		IF IsValid(w_image_preview) then
			w_image_preview.of_get_image(string(il_prac_id) + '||' + string(ii_screen_id),il_rec_id)
		else
//			OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id))
			OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id)+ '||' +string(il_rec_id)) //long.zhang 03.28.2012
		end if
		//----------------------------APPEON END-------------------------
	END IF		
ELSEIF dwo.Name = "gapbutton" THEN  //Start Code Change ----12.02.2010 #V10 maha - Work Gap Calculate
	openwithparm( w_work_gap_add_records, il_prac_id)
	if ii_screen_id = 55 then
		dw_detail.retrieve( il_prac_id )
	end if
	//of_calc_work_gap(il_prac_id)
elseif dwo.name = "pendingbutton" then //Added by Appeon long.zhang 07.31.2013 (V14.1 Group Location Effective Dates)
		openWithParm(w_pending_changes_address,parent)
elseif dwo.name = "id_link" then   //Start Code Change ----11.19.2013 #V14 maha
	openWithParm(w_address_ids_view, this.getitemnumber(row,"rec_id"))
//Start Code Change ----01.05.2015 #V14.2 maha
Elseif dwo.name = "viewentity" then
	//function to view the lookup detail
	if is_lookup_search_column_field = "None" then
		messagebox("Entity Search", "Please select the Entity field first" )
	else
		v = this.getitemnumber(this.getrow(), is_lookup_search_column_field )
		if isnull(v) or v < 0 then 
			//return
		else
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 12.25.2015
			//<$>reason: for BugL122501
			gs_pass_ids lst_ids
			lst_ids.s_ids[2] = string(v)
			lst_ids.s_ids[1] = "V"
			lst_ids.dw = this
			//openwithparm(w_lookup_add, "V#" + string(v))
			openwithparm(w_lookup_add_child, lst_ids)
			//------------------- APPEON END -------------------
	
		end if
	end if
	//End Code Change ----01.05.2015	
END IF


end event

event constructor;This.of_SetRowManager( TRUE )
//This.inv_rowmanager.of_SetRestoreRow( TRUE )
//This.inv_rowmanager.of_SetConfirmOnDelete ( TRUE )
This.of_SetReqColumn(TRUE)
this.of_SetDropDownCalendar( TRUE )



end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-08-12 By: Scofield
//$<Reason> Popup a dialog to input the phone.

String	ls_Name,ls_Mask,ls_Phone,ls_RetParm
long		ll_FieldID

if row > 0 and row <= This.RowCount() then
	ls_Name = dwo.name
	ll_FieldID = long(This.Describe(ls_Name + ".Tag"))
	
	SELECT field_mask INTO :ls_Mask FROM sys_fields WHERE field_id = :ll_FieldID and field_name = :ls_Name ;
	
	//if Trim(ls_Mask) = "(###)###-####" then
	if Trim(ls_Mask) = "INTPHONE" then  //Start Code Change ----02.02.2009 #V92 maha
	
		if gi_user_readonly = 1 then return  //alfee 12.30.2009
		
		If Long(This.Describe(ls_Name + ".TabSequence")) = 0 Then Return //Added by Appeon long.zhang 03.31.2016 (bug id 5075 phone format issue)                       
		
		ls_Phone = This.GetItemString(row,ls_Name)
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,ls_Name,ls_RetParm)
		end if
		This.SetColumn(ls_Name)
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event getfocus;call super::getfocus;//Start Code Change ----01.05.2015 #V14.2 maha
this.triggerevent("itemfocuschanged")
end event

event itemchanged;call super::itemchanged;String ls_type
string ls_value  //maha 11.13.2014
string ls_city, ls_state, ls_county , ls_country //maha 11.13.2014
long ll_code  //maha 11.13.2014
Integer li_screen
Integer li_ans
Integer li_stat
Long ll_rec_id


//IF inv_data_entry.of_itemchanged( This, Data ) = 1 THEN //this function buts a dot on the basic info middle name if only 1 character
//	RETURN 2
//END IF
//
////Start Code Change ----08.01.2008 #V85 maha - modified active status to use function call rewrote to test only on existing records
//IF This.GetColumnName() = "active_status" And This.GetItemStatus( row, 0, primary!) <> newmodified! THEN //Start Code Change ----08.01.2008 #V85 maha - change to run only if not  a new record - changed to <> newmodified 02.02.2008
//	li_stat = Integer(Data)
//	if ii_screen_id <> 2 then //Start Code Change ----02.02.2009 #V92 maha - trap for address screen	
//		IF li_stat = 0 THEN //if inactive display message
//			li_ans = MessageBox( "Active Status", "If you change this active status to INACTIVE, all verification entries for this record will be Permanently changed to inactive.  Continue?", Question!, YesNo!, 1 )
//			IF li_ans = 1 THEN
//				li_ans = MessageBox("Active Status", "Are you sure?", Question!, YesNo!, 1	)
//				IF li_ans = 2 THEN //if no set active
//					This.SetItem(row,This.GetColumn( ),1 )
//					RETURN
//				END IF
//			END IF
//		END IF
//		
//		ll_rec_id = This.GetItemNumber( row, "rec_id" )
//		parent_window.inv_action_items.of_update_verif_status(  ll_rec_id, ii_screen_id , li_stat  )
//	end if
//	//	IF data = "0" THEN
//	//		Integer li_ans
//	//		Long ll_rec_id
//	//		li_ans = MessageBox( "Active Status", "If you change this active status to INACTIVE, all verification entries for this record will be Permanently changed to inactive.  Continue?", StopSign!, YesNo!, 1 )
//	//		IF li_ans = 1 THEN
//	//			li_ans = MessageBox("Active Status", "Are you sure?", StopSign!, YesNo!, 1 )
//	//			IF li_ans = 1 THEN
//	//				ll_rec_id = This.GetItemNumber( row, "rec_id" )
//	//				UPDATE verif_info  
//	//			     SET active_status = 0 
//	//				WHERE rec_id = :ll_rec_id;
//	//				IF SQLCA.SQLCODE = -1 THEN
//	//					MessageBox("Database Error", SQLCA.SQLERRTEXT )
//	//				END IF
//	//			END IF
//	//		END IF
//	//	END IF
//	
//END IF
////End Code Change---08.01.2008
//
//tab_view.tabpage_image.Enabled = True
//
//////@@@@ZIP CODE AUTO FILL @@@@@@@@
// //Start Code Change ----04.07.2015 #V15 maha - zip autofill
//IF This.GetColumnName() = "zip" then
//	this.accepttext( )
//	ls_value = this.getitemstring(1,"zip")
//	of_zip_fill(ls_value, "DE", this)
//end if
//////End Code Change ----04.07.2015
//

//maha 061605 for lookup search

IF Long(Data) = -777 THEN
	ls_type = "C"
	AcceptText( )
	This.PostEvent( "ue_after_itemchanged",0,ls_type)
ELSEIF Long(Data) = -888 THEN
	ls_type = "A"
	AcceptText( )
	This.PostEvent( "ue_after_itemchanged",0,ls_type )
	inv_data_entry.of_refresh_cache( ) //maha 122205
END IF


end event

event itemfocuschanged;call super::itemfocuschanged;

//IF This.Describe(This.GetColumnName() + ".DDDW.DisplayColumn") = "entity_name"  THEN
DataWindowChild dwchild
String ls_column_name
integer res	
	
ls_column_name =This.GetColumnName()
res = This.GetChild( ls_column_name, dwchild )
//Start Code Change ----01.05.2015 #V14.2 maha
if This.Describe("viewentity.text") <> "!" then this.modify( "viewentity.enabled = false")
is_lookup_search_column_field = "None" 
//End Code Change ----01.05.2015

if res > 0 then
	IF dw_select_section.GetRow()>0 Then//Added by  Nova 06.17.2010
		if dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 65 or dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 54 or ls_column_name = "billing_address_id" then //maha app081705 trap for question dddw
			//nothing
		else
			IF dwchild.RowCount() > 2 THEN //maha changed from 1 for lookup search 061605
				//--------------------------- APPEON BEGIN ---------------------------
				//$<add> 04.19.2006 By: LeiWei
				//$<reason> Fix a defect.
				/*
				is_lookup_search_column_table = dwchild.GetItemString( 3, "lookup_name" )//maha changed from 2 for lookup search 061605 //Start Code Change ---- 06.08.2006 #528 maha
				*/
//				IF ls_column_name <> "street" THEN
				IF ls_column_name <> "street" and ls_column_name <> "active_status" THEN  //Start Code Change ----07.23.2008 #V85 maha - added active_status exception
					is_lookup_search_column_table = dwchild.GetItemString( 3, "lookup_name" )//maha changed from 2 for lookup search 061605
				END IF
				
				 //Start Code Change ----01.05.2015 #V14.2 maha
				if this.describe( ls_column_name + ".dddw.name")  = 'd_dddw_address_lookup' then 
					is_lookup_search_column_field = ls_column_name
					this.modify( "viewentity.enabled = true")
				end if
				 //end Code Change ----01.05.2015
				//---------------------------- APPEON END ----------------------------
			END IF
		end if
	END IF	
end if
IF IsValid( m_pfe_cst_data_entry ) THEN
	//m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_lookupsearch,'Enabled', True)
END IF

//ELSE
//	IF IsValid( m_pfe_cst_data_entry ) THEN
//		m_pfe_cst_data_entry.m_edit.m_lookupsearch.enabled = False
//	END IF
//END IF

IF This.GetColumnName() = "billing_address_id" THEN
	//If This.Describe( "billing_address_id.dddw.name") = 'd_dddw_billing_addresses' Then//'IF' Added by Appeon long.zhang 02.02.2015 (address screen error)
		This.GetChild( "billing_address_id", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( il_prac_id )
		
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )	
	//End If
END IF


end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.21.2006 By: Leiwei
//$<reason> Fix a defect.

/* colname = this.getcolumnname() */
colname = dwo.name
//---------------------------- APPEON END ----------------------------

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event resize;call super::resize;//alfee 05.12.2010

//if of_get_ib_screen_painter() then return 0 //BugS081908 - alfee 08.26.2011

//choose case ii_screen_id
//	case 10,2,19 //address, hospital, specialty
//		post of_detail_scrollbar(ii_screen_id) //resize the detail dw
//	case else
//		//
//end choose
end event

event retrieveend;call super::retrieveend;if This.Describe("prac_id.ColType") <> "!" then //maha 051503 for lehigh
	this.Modify("prac_id.background.color = '12632256'")
	//this.Modify( "prac_id.TabSequence = 0" )
	//this.Modify( "prac_id.protect = 1" )
	//this.Modify( "prac_id.x = '2100'" )
	//this.Modify( "prac_id.y = '100'" )
end if

if This.Describe("rec_id.ColType") <> "!" then //maha 051503 
	this.Modify("rec_id.background.color = '12632256'")
	//this.Modify( "rec_id.TabSequence = 0" )
	//this.Modify( "rec_id.protect = 1" )
	//this.Modify( "prac_id.x = '2100'" )
	//this.Modify( "prac_id.y = '100'" )
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06/10/2008 By: Ken.Guo
//$<reason> Move script to function of_set_page_menu()
/*
// mskinner 13 Dec 2005 -- begin
if isvalid(m_pfe_cst_data_entry) then 
if this.rowcount() > 1 then 
 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = true
 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = true
else 
 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = false
 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = false
end if 
end if
// mskinner 13 Dec 2005 -- end
*/
//of_refresh_page_menu() //Added By Ken.Guo 06.10.2008
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanged;call super::rowfocuschanged;//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())

IF currentrow > 0 THEN
//	of_get_record_verif( currentrow )
//	dw_browse.SelectRow( 0, False )
//	dw_browse.SelectRow( currentrow, True )
//	dw_browse.SetRow( currentrow )
//	dw_browse.ScrollToRow( currentrow )
//	if ib_report=false then
//		if this.rowcount() > 0 then
//			il_rec_id = This.GetItemNumber( currentrow, "rec_id" )
//		end if
//	end if
END IF
end event

event rowfocuschanging;call super::rowfocuschanging;//IF is_screen_name = "Address" AND dw_link_list.GetItemStatus( dw_link_list.GetRow(), 0, Primary!)  = DataModified! THEN 
//IF ii_screen_id = 2 AND dw_link_list.GetItemStatus( dw_link_list.GetRow(), 0, Primary!)  = DataModified! THEN 
//	IF of_address_link_check() = -1 THEN
//		Return 1
//	ELSE
//		dw_link_list.Update()
//	END IF
//END IF
end event

event scrollvertical;call super::scrollvertical;Long ll_numrow
String ls_firstrow, ls_lastrow

  //Start Code Change ----05.09.2014 #V14.2 maha - facility specific screens

//choose case ii_screen_id  
//	case 2, 10, 19
//		ls_lastrow = This.Object.Datawindow.LastRowOnPage
//		ll_numrow = dw_browse.GetItemNumber(Long(ls_lastrow),"rec_id")
//		dw_link_list.Retrieve(ll_numrow) 
//	
//end choose

	RETURN 0

end event

event pfc_addrow;call super::pfc_addrow;//Integer li_retval
//integer cnt
//long ll_appt_id
//long ll_batch_add_field  //maha 12.06.2012
//integer r   //maha 12.06.2012
//integer nr   //maha 12.06.2012
//string ls_field   //maha 12.06.2012
//long ll_table  //maha 12.06.2012
//long ll_find  //maha 12.06.2012
//
//tab_view.tabpage_image.Enabled = False
//
////Start Code Change ----07.01.2014 #V14.2 maha
//if tab_view.SelectedTab = 1 then
//	tab_view.SelectTab( 2 )
//end if
////Start Code Change ----07.01.2014
//
//ll_batch_add_field = dw_select_section.getitemnumber(dw_select_section.getrow(), "batch_add_field")  //Start Code Change ----11.28.2012.2012 #V12 maha
//ll_table = dw_select_section.getitemnumber(dw_select_section.getrow(), "table_id")  //Start Code Change ----12.06.2012.2012 #V12 maha
//
//if ii_screen_id = 65 or ii_screen_id = 54 then //maha app081705 questions//Start Code Change ---- 06.08.2006 #529 maha
//	this.deleterow( this.rowcount()) //delete the just added row
//	//Start Code Change ----06.17.2009 #V92 maha - changed to hit db once
////	select count(rec_id) into :cnt from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;
////	if cnt < 1 then
////		messagebox("Appointment record error","There are no non-history records (Active,Inactive,Pending,Purge) for this practitioner and facility.  This should be corrected on the Appointment Status tab before adding Attestation Questions.")
////		return - 1 
////	else
//		select top 1 rec_id into :ll_appt_id from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;  
////	end if	
//
//	If isnull(ll_appt_id) or ll_appt_id = 0 then
//		messagebox("Appointment record error","There are no active records for this practitioner and facility. As questions are directly connected to the Appointment record, unable to add Questions.")
//		return - 1 
//	end if
//	//End Code Change---06.17.2009
//	//Start Code Change ---- 06.08.2006 #529 maha
//	if ii_screen_id = 65 then
//		inv_data_entry.of_add_questions("PRAC",dw_detail,ii_parent_facility_id,gl_prac_id,ll_appt_id)
//	elseif  ii_screen_id = 54  then //practice questions
//		inv_data_entry.of_add_questions("PQ",dw_detail,ii_parent_facility_id,gl_prac_id,ll_appt_id)
//	end if
//	//End Code Change---06.08.2006
////Start Code Change ----12.06.2012 #V12 maha - for 12.3
//elseif  ii_screen_id = 72 then
//	
//	gs_pass_ids lst_ids   //maha 12.06.2012
//	if This.Describe("verif_type.ColType") <> "!" then
//		If This.Describe("verif_type.dddw.displaycolumn") = "entity_name" then
//			open(w_other_verification_select)
//			if message.stringparm = 'Cancel' then
//				return 0
//			else
//				this.deleterow( this.rowcount())  //the row just added
//				lst_ids = message.powerobjectparm
//				if this.getitemstatus( 1,0, primary!) = new! then //if a blank record added for no rows
//					//messagebox("","New")
//					this.deleterow( 1 ) //delete the just added row 
//				end if
//
//				for r = 1 to upperbound(lst_ids.sl_action_type)			
//					nr = this.insertrow(0)
//					this.setitem(nr, "verif_type", lst_ids.sl_action_type[r] )
//					if This.Describe("verif_method.ColType") <> "!" then
//						this.setitem(nr, "verif_method", lst_ids.l_ids[r] )
//					end if
//					inv_data_entry.of_set_defaults( This, This.RowCount() )
//				next
//			end if
//		End if //entity column
//	end if
//elseif ll_batch_add_field > 0 then
//	openwithparm(w_batch_record_add, string(ll_table) + "@" + string(ll_batch_add_field ))
//
//	if message.stringparm = 'Cancel' then
//		return 0
//	else
//		gs_variable_array lst_types   //maha 12.06.2012
//		ls_field = gnv_data.of_getitem("sys_fields", "field_name", "field_id = " + string( ll_batch_add_field ))
//		this.deleterow( this.rowcount()) //delete the just added row
//		lst_types = message.powerobjectparm
//		for r = 1 to upperbound(lst_types.as_number )
//			ll_find = this.find( ls_field + " = " + string(lst_types.as_number[r]), 1, this.rowcount())
//			if ll_find = 0 then
//				nr = this.insertrow(0)
//				if This.Describe(ls_field + ".ColType") <> "!" then
//					this.setitem(nr, ls_field , lst_types.as_number[r] )
//				end if
//				inv_data_entry.of_set_defaults( This, This.RowCount() )
//			end if
//		next			
//	end if
////End Code Change ----12.06.2012
//
//else
//	inv_data_entry.of_set_defaults( This, This.RowCount() )
//	This.SetItemStatus( This.RowCount(), 0, Primary!, NotModified! )
//end if
//
//if  ii_screen_id = 2 then //Start Code Change ----09.30.2014 #V14.2 maha
//	tab_view.tabpage_linked_data.enabled = false
//end if
//
//this.scrolltorow(This.RowCount()) //maha app100305
//This.SetColumn( is_first_column_detail_1 )
//This.SetFocus()
//
//if IsValid(m_pfe_cst_data_entry) then //Added By Evan 01.11.2012
//	//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
//	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'Enabled', False)
//end if
//of_refresh_page_menu() //Added By Ken.Guo 06.10.2008
//
RETURN 0
end event

event pfc_retrieve;call super::pfc_retrieve;

Return This.Retrieve( )
end event

event pfc_nextpage;return this.ScrollNextRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_previouspage;return this.ScrollPriorRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_validation;call super::pfc_validation;Integer li_retval
integer li_table_id

//Start Code Change ----06.18.2008 #V81 maha - removed. now called from of_validate in dw_detail
//if this.rowcount() < 1 then return 1 modify Michael 11.01.2011 Invalid DataWindow row/column 
if this.rowcount() < 1 or dw_select_section.GetRow() < 0 then return 1
li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
//li_retval = of_validate( li_table_id, this.getrow())
//li_retval = inv_data_entry.of_record_validation( This )
IF li_retval = -1 THEN
	Return -1
END IF
//End Code Change---06.16.2008

Return AncestorReturnValue

end event

event pfc_postupdate;
//Start Code Change ----08.06.2009 #V92 maha - readded with security
if w_mdi.of_security_access(40) = 2 or w_mdi.of_security_access(50) = 2 then
	//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True //maha removed 082503
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'enabled', true)
end if
//End Code Change---08.06.2009

This.ScrollToRow( il_last_de_row )
This.SetRow( il_last_de_row )

//setting green checkmark screen icon
integer r

dwItemStatus l_Status
l_Status = this.getitemstatus(1,0,primary!)

r = this.rowcount()
if r > 1 then
	dw_select_section.setitem(dw_select_section.getrow(),"selected",r)
//Start Code Change ----09.22.2010 #V10 maha - modified to make work
elseif l_Status = new! or IsNull(l_Status)  then
	dw_select_section.setitem(dw_select_section.getrow(),"selected",0)
else
	dw_select_section.setitem(dw_select_section.getrow(),"selected",1)
end if
//Start Code Change ----09.22.2010
//---------------------------- APPEON END ----------------------------

//Added for Work Flow trigger. 11.21.2006 Henry
string ls_module
long ll_screen_id[]  //12.13.2006 By Jervis

If of_Get_app_setting("set_9" , "I") = 1 Then
	ls_module = '02'
Else
	ls_module = '01'
End if
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	
//	If parent_window.ib_new_prac Then ii_parent_facility_id = 1
	//12.13.2006 By Jervis
	ll_screen_id[1] = ii_screen_id
	//lnv_workflow.of_data_value_comparision( ii_screen_id, il_prac_id, ii_parent_facility_id, ls_module, 'I')
//	lnv_workflow.of_data_value_comparision( ll_screen_id, il_prac_id, ii_parent_facility_id, ls_module, 'I')
	//12.13.2006 End

	Destroy lnv_workflow
	
	//Refresh Action Item Data
	if ls_module = "02" then
//		parent_window.of_retrieve_net( )
	end if
End If
//End added 11.21.2006

//run data flow if any - dataflow: alfee 12.24.2009
//inv_dataflow.of_run_data_flow()

//
// Add by andy 01/29/2010 V10.1 - Notification Alert
//
String	ls_table_name
n_cst_notification_alert_upd	lnv_na

ls_table_name = This.Object.DataWindow.Table.UpdateTable
lnv_na.of_update_alert_records(ls_table_name, This)

if  ii_screen_id = 2 then //Start Code Change ----09.30.2014 #V14.2 maha
//	tab_view.tabpage_linked_data.enabled = true
end if

// Because I must check column status in the above function,
// I unextend ancestor script and call it at last.
Call Super::pfc_postupdate

Return 1

end event

event pfc_preupdate;call super::pfc_preupdate;DateTime ldt_exp_date
DateTime ldt_null_date
DateTime ldt_exp_date_original
Long ll_rec_id
Long ll_address_code
long ll_appt_stat_recid  //#1 maha 101606
long ll_templ_id[ ]  //#1 maha 101606
long ll_verif_response  //#1 maha 101606  completion response code for verif; if 0 will not be completed.
long li_seq_no
long li_found
Long ll_new_cnt //Added By Ken.Guo 03.31.2008
Long ll_rec_id_changed[]
long ll_ver_method = -1  //maha 08.31.2011
long ll_gp //maha 04.14.2015
long ll_gp_org //maha 04.14.2015
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
integer li_year //maha031601
integer li_month//maha031601
integer li_validate//maha080803
integer li_res //maha 032406
integer li_complete[ ] //#1 maha 101606
integer li_auto_gen[ ] //#1 maha 101606
integer li_app_audit_facil //#1 maha 101606
integer li_appt_stat //#1 maha 101606
integer li_temp_cnt //#1 maha 101606
integer li_status = 1 //maha 080108
integer t  //#1 maha 101606
integer li_set_mess //maha 05.05.2009
integer li_len //maha 02.10.2014
boolean lb_save_mess = false //maha 02.26.2014

string ls_use_as_ver //#1 maha 101606
String ls_screen_name
String ls_val
String ls_rec_status
string ls_app_type //#1 maha 101606
string ls_mess //#1 maha 101706
string ls_type1//maha102501
string ls_type2//maha102501
string ls_type3//maha102501
DataWindowChild dwchild
n_ds lds_aa_template //#1 maha 101606
//
//SetNull( ldt_null_date )
//This.AcceptText()
//
////messagebox("","preupdate")
//
//ib_test_save = true
//
//
//SetRedraw( False )
//
//il_last_de_row = 1
//li_data_cr = 1
//
//is_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
//is_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
//is_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")
//is_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type")
//is_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")
//is_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")
//
//is_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
//ii_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
//is_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")
//ii_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
//
//li_validate  = Long(gnv_data.of_getitem( "sys_fields", "field_id", "table_id = "+String(li_table_id)+" and use_validation > 0"))
//
//
//ll_new_cnt = 1
//
//
//i = 1
//	//debugbreak()			
//	SetNull( ll_address_code )
//	IF This.GetItemStatus( i, 0, Primary!) <> NewModified! AND +&
//		This.GetItemStatus( i, 0, Primary!) <> DataModified! THEN
//		return 1
//	ELSEIF This.GetItemStatus( i, 0, Primary!)  = NewModified! THEN
//		ls_rec_status = "New"
//		This.SetItem( i, "prac_id", il_prac_id)
//		This.SetItem( i, "rec_id",il_rec_id )			
//	ELSE
//		ls_rec_status = "Modified"
//	END IF
//	
//	li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(li_table_id) ))
//		
//	//Start Code Change ----08.31.2011 #V11 maha 
//	IF li_table_id = 72 THEN  //other verifications
//		if This.Describe("verif_method.ColType") = "!" then 
//			//leave as default -1
//		else
//			ll_ver_method = this.GetItemNumber( i, "verif_method" )
//			if isnull( ll_ver_method) then ll_ver_method = -1
//		end if
//	end if
//	//End Code Change ----08.31.2011
//
////@@@@@
//
//		//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
//		if this.Describe("active_status.ColType") <> "!" then
//			li_status = this.getitemnumber(i,"active_status") //Start Code Change ----04.19.2010 V10 maha - changed from li_data_cr
//		end if
//		//End Code Change---08.01.2008
//		//Start Code Change ---- 10.26.2006 #1 maha
//		IF ls_rec_status = "Modified" THEN
// 			//never will be modified
//		ELSE  //new
//			IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification
//			debugbreak()
//		messagebox("pcf_preupdate","Need verification creation function")
////			IF parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_add_record( il_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status, ll_ver_method) = -1 THEN  //Start Code Change ----08.31.2011 #V11  maha  - added method argument //Start Code Change ----.2008 #V85 maha - added li_status argument
////					Return -1
////					messagebox("Error","Error adding verification")
////				end if
//			END IF
////			parent_window.ib_app_audit_retrieved = false //Start Code Change ---- 10.30.2006 #1 maha
//		//End Code Change---10.26.2006
////@@@@@
////	END IF
//	
//
//	long ll_row,ll_seq_no,ll_image_type_id,ll_default_pages,ll_de_queue
//
//
//This.ScrollToRow( li_data_cr )
//This.SetRow( li_data_cr )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 06/03/2008 By: Ken.Guo
////$<reason> Fix issue. After save address data, address link data disappear.
//if li_data_cr > 0 then
//	il_rec_id = This.GetItemNumber( li_data_cr, "rec_id" )
//end if
////---------------------------- APPEON END ----------------------------
//
//
//This.SetRedraw( True )
//
//dw_detail.SetColumn( is_first_column_detail_1 )
//dw_detail.SetFocus()
//
//inv_data_entry.of_field_audit( This )
//
//
//DESTROY ids_parent_facilities
//
//String ls_sql_where, ls_rec_id_str, ls_sql_original
//n_ds lds_verify
//gs_verif_update lstr_verif




RETURN 1

end event

event pfc_preinsertrow;//\/maha 050701 to trap save errors when entering multiple records

Integer li_retval

// mskinner 17 dec 2005 -- begin
// do not allow for the addition os rows in the PERSIONL DATA screen

STRING LS_SCREEN_NAME
LS_SCREEN_NAME = UPPER(dw_select_section.object.screen_name[dw_select_section.getRow()])
if upper(TRIM(LS_SCREEN_NAME)) = 'PERSONAL DATA' THEN 
	RETURN Failure
END IF 

// mskinner 17 dec 2005 -- end


//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-28
//$<comment> 2006-04-10 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Move the script to PT-26. It is integrated into Appeon Queue labels
//$<modification> to reduce client-server interactions.
/*
li_retval = Parent_window.Event pfc_Save()
	//debugbreak()
	IF li_retval < 0 THEN
		This.PostEvent( "pfc_cst_after_error" )
		Return 1
	END IF
*/

//---------------------------- APPEON END ----------------------------

		
//end if
	
return continue_action

//\maha
end event

type cb_2 from commandbutton within w_batch_add_cred_data
boolean visible = false
integer x = 2958
integer y = 192
integer width = 411
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Batch Document"
end type

type st_select from statictext within w_batch_add_cred_data
boolean visible = false
integer x = 2098
integer y = 36
integer width = 379
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
boolean enabled = false
string text = "4) Select Facility"
boolean focusrectangle = false
end type

type cb_batch from commandbutton within w_batch_add_cred_data
integer x = 23
integer y = 196
integer width = 846
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Search"
end type

event clicked;
gs_batch_search lst_search
long i
long ic
long r
long rc
long pracids[]
string names[]
string ls_openstring

//ib_fax_num_email_search = False

if ii_facid > 0 then
	ls_openstring = "R*" + string(ii_facid)
elseif ii_facid = 0 then 
	ls_openstring = "R*ALL" 
else 
	ls_openstring = "R"
end if
	


openwithparm(w_batch_prac_select_new,ls_openstring)


if message.stringparm = "Cancel" then return
//names[] = lst 
lst_search = message.powerobjectparm
pracids[] = lst_search.li_prac_id[]
names[] = lst_search.ls_name[]
 ic = upperbound(pracids[]) 
 
 //---------Begin Added by (Appeon)Harry 05.05.2015 for  Issues running a custom correspondence letter against an IntelliBatch--------
long ll_findrow, ll_rowcount
 if ii_facid > 0 then
	datastore lds_find
	lds_find = create datastore
	lds_find.dataobject = 'd_facility_filter'
	lds_find.settransobject(sqlca)
	ll_rowcount = lds_find.retrieve(ii_facid)
 end if
 //---------End Added ------------------------------------------------------
 
 for i = 1 to ic
	ll_findrow = dw_pracs.find( "prac_id = " + String(  pracids[i] ), 1, ll_rowcount)
	if ll_findrow > 0 then continue

	r = dw_pracs.InsertRow( 0 )
	dw_pracs.SetItem( r, "prac_id", pracids[i])
	dw_pracs.SetItem( r, "full_name", names[i] )
next

if isvalid (lds_find) then destroy lds_find  //(Appeon)Harry 05.05.2015 

dw_pracs.SetFocus( )
dw_pracs.SelectRow( 0 , False )
dw_pracs.ScrollToRow( 1 )
dw_pracs.SetRow ( 1 )
dw_pracs.SelectRow( 1 , True )
//if dw_pracs.rowcount() > 1 then
////	st_batch.visible = true
//end if

of_get_affils()   //Start Code Change ----03.30.2017 #V153 maha
end event

type cb_search from commandbutton within w_batch_add_cred_data
integer x = 23
integer y = 104
integer width = 846
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Provider Search"
end type

event clicked; //Start Code Change ----09.18.2015 #V15 maha - copied from correspondence
Integer li_nr
Integer li_find
integer i
integer ic
Long ll_prac_id
String ls_full_name
gs_search lstr_search
gs_batch_search ist_search

//ib_fax_num_email_search = False

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" + String( ii_facid ) 

//Start Code Change ----12.13.2010 #V10 maha - for sk
if gb_sk_ver then
	lstr_search.ls_open_for = "SKS"
	OpenWithParm( w_extended_search_app , lstr_search )
else
	OpenWithParm( w_extended_search_new , lstr_search )
end if
//Start Code Change ----12.13.2010


IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.13.2006 By: Cao YongWang
//$<reason> Fix a defect.
If not isvalid(ist_search) Then return 
//---------------------------- APPEON END ----------------------------

//maha 091605 allowing for multi selection

// mskinner 20 dec 2005 -- begin 
if not isvalid(message.powerobjectparm) then return 0
// mskinner 20 dec 2005 -- end 

ic = upperbound(ist_search.li_prac_id[])


datastore lds_full_name
long ll_rowcount

lds_full_name = create datastore
lds_full_name.dataobject = 'd_v_full_name'
lds_full_name.settransobject(sqlca)
ll_rowcount = lds_full_name.retrieve()

for i = 1 to ic
	ll_prac_id = ist_search.li_prac_id[i] 

	li_find = dw_pracs.Find( "prac_id = " + String( ll_prac_id ), 1, 1000 )
	
	IF li_find > 0 THEN continue

	
	li_nr = dw_pracs.InsertRow( 0 )
	
	dw_pracs.SetItem( li_nr, "prac_id", ll_prac_id )

	li_find = lds_full_name.Find( "prac_id = " + String( ll_prac_id ), 1, ll_rowcount )
   if li_find > 0 then
		ls_full_name = lds_full_name.getitemstring(li_find,'full_name')
		dw_pracs.SetItem( li_nr, "full_name", ls_full_name )
	end if

next
destroy lds_full_name
//---------------------------- APPEON END ----------------------------

dw_pracs.SetFocus( )
dw_pracs.SelectRow( 0 , False )
dw_pracs.ScrollToRow( li_nr )
dw_pracs.SetRow ( li_nr )
dw_pracs.SelectRow( li_nr , True )

of_get_affils()   //Start Code Change ----03.30.2017 #V153 maha


end event

type dw_browse from u_dw within w_batch_add_cred_data
boolean visible = false
integer x = 777
integer y = 2024
integer width = 283
integer height = 256
integer taborder = 100
string dataobject = "d_insurance_batchadd"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//This.iuo_calendar.of_Register(This.iuo_calendar.DDLB)	
This.of_SetReqColumn(TRUE)

end event

event pfc_preupdate;call super::pfc_preupdate;String ls_screen_name
String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
Long ll_seq_no
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
//Integer il_last_de_row
//Integer il_last_row
Integer p
//Long il_rec_id
//Long il_prac_id
Long li_found
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
Integer li_year //maha031601
Integer li_month//maha031601
Integer li_validate//maha080803
String ls_type1//maha102501
String ls_type2//maha102501
String ls_type3//maha102501


DataWindowChild dwchild

SetNull( ldt_null_date )

dw_detail.AcceptText()

il_last_de_row = dw_detail.GetRow()

li_data_cr = dw_detail.GetRow()
il_last_row = 1 //dw_select_section.getrow()

ls_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
ls_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
ls_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")

ls_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type") //maha102501
ls_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")//maha102501
ls_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")//maha102501

ls_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
//messagebox("ls_exp_field",ls_exp_field)
li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
ls_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")

li_rec_count = dw_detail.RowCount()

If li_rec_count < 1 Then
	Return -1
End If

If li_rec_count < 1 Then
	MessageBox("","Please select a practitioner list")
	Return -1
End If
i = 1
//FOR p = 1 TO li_rec_count

SetNull( ll_address_code )



ls_rec_status = "New"

il_prac_id = dw_pracs.GetItemNumber(i,"prac_id")
ll_rec_id = dw_detail.GetItemNumber( i, "rec_id" )
//debugbreak()	

If ii_screen_id = 4 Or ii_screen_id = 15 Or ii_screen_id = 5 Then
	//IF dw_detail.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
	If dw_detail.GetItemNumber( i, "active_status" ) = 0 Then
		If ls_rec_status = "New" Then
			Return 1
		Else //\/maha 031601
			Update verif_info
				Set active_status = 0
				Where rec_id = :ll_rec_id And active_status = 1;
			Return 1		 //\maha
		End If
	End If
	//END IF
End If


li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )



//debugbreak()
inv_data_entry.of_field_audit( dw_detail )


Return 1


end event

type dw_table from datawindow within w_batch_add_cred_data
integer x = 923
integer y = 104
integer width = 1079
integer height = 84
integer taborder = 60
string dataobject = "d_table_list_batch_add"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
integer r
integer t
string find
string ls_filt
string s
datawindowchild dwchild

ii_screen_id = integer(data)


dw_detail.SetRedraw( False )
s = inv_data_entry.of_create_dynamic_dw(0, 1, ii_screen_id, dw_detail, dw_browse, false, 0, true )
dw_detail.SetRedraw( True )


find = "screen_id = " + data
//debugbreak()
////messagebox("",find)
r = dw_select_section.find(find,1,dw_select_section.rowcount())
//messagebox("r",r)
dw_select_section.setrow(r)

il_last_row = r

is_first_column_detail_1 = dw_detail.Describe("#"+String(1) +'.Name')

//messagebox( "is_first_column_detail_1" , is_first_column_detail_1)
is_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
is_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
is_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")
is_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type")
is_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")
is_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")
is_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
ii_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
is_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")
ii_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
ii_validate  = Long(gnv_data.of_getitem( "sys_fields", "field_id", "table_id = "+String(ii_table_id)+" and use_validation > 0"))

 //Start Code Change ----03.30.2017 #V153 maha
if dw_select_section.getitemnumber( il_last_row, "facility_specific" ) = 1 then
	ib_facil_spec = true
	dw_facility_select.visible = true
	st_select.visible = true
	of_filter_facility()
else
	ib_facil_spec = false
	dw_facility_select.visible = false
	st_select.visible = false
	dw_pracs.setfilter("")
	dw_pracs.filter()
end if
 //End Code Change ----03.30.2017


cb_run.enabled = true





end event

type cb_run from commandbutton within w_batch_add_cred_data
integer x = 1723
integer y = 196
integer width = 667
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
string text = "Add for Each Provider"
end type

event clicked;//Start Code Change ----04.21.2009 #V92 maha - moved create and retrieve of n_ds from of_create_verifs
long recid
long prac
long i
long ic
integer res
integer p
integer v
integer li_vfac
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.17.2006 By: Jack (Inova)
//$<reason> Required Documents Check Box on Data Entry Screen.
long ll_prac_id[]
long ll_rec_id[]
long ll_screen_id
//---------------------------- APPEON END ----------------------------


dw_detail.accepttext()
//check data
ic = dw_pracs.rowcount()

for i = 1 to ic
	ll_prac_id[i] = dw_pracs.getitemnumber(i,"prac_id")
next

if ic < 1 then
	messagebox("No practitioners","Please select a Batch list of practitioners.  If no exists create one IntelliBatch first.")
	return
end if

 //Start Code Change ----03.30.2017 #V153 maha
if ib_facil_spec = true then
	if ii_facid < 1 then
		messagebox("Select Facility","This screen is Facility specific.  Please select the Facility to which to connect this data")
		return
	end if
end if
 //End Code Change ----03.30.2017 

ids_parent_facilities = CREATE n_ds
ids_parent_facilities.DataObject = "d_verifying_parents_of_vers_batchadd"
ids_parent_facilities.of_SetTransObject( SQLCA )

ids_verif_facilities = CREATE n_ds
ids_verif_facilities.DataObject = "d_verifying_orgs_facilities_pracs_w_rules"
ids_verif_facilities.of_SetTransObject( SQLCA )


recid = gnv_app.of_get_id( "RECORD_ID" ,ic) - 1

//set values used in the creation of the verifications
of_verif_values()

	
for i = 1 to  ic
	recid ++
	debugbreak()
	prac = ll_prac_id[i]
	ll_rec_id[i] = recid
	
	il_rec_id = recid
	il_prac_id = prac
	p = ids_parent_facilities.retrieve(il_prac_id )
	li_vfac = ids_verif_facilities.retrieve(il_prac_id, ii_screen_id)
	
	dw_detail.setitem(1,"prac_id",prac)
	dw_detail.setitem(1,"rec_id",il_rec_id)
	if ib_facil_spec = true then dw_detail.setitem(1,"facility_id",ii_facid )   //Start Code Change ----03.30.2017 #V153 maha
	dw_detail.setitemstatus( 1, 0, primary!, newmodified!)
	
	//of_verifications_add( il_rec_id, prac)	
	if li_vfac > 0 then  //Start Code Change ----04.07.2017 #V153 maha - trap for no verifications
		of_create_verif( is_reference)
	end if
	
	inv_data_entry.of_field_audit( dw_detail )
	dw_detail.update()

next

destroy ids_ver_orgs_facilities
destroy ids_parent_facilities 
//destroy ids_last_verif_seq_no
destroy ids_dfl_rsp_code
destroy ids_verif_facilities
//End Code Change---04.21.2009

messagebox("Batch add","Data added for " + string(ic) + " Practitioners")

end event

type st_2 from statictext within w_batch_add_cred_data
integer x = 210
integer y = 40
integer width = 430
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "1) Select Providers"
boolean focusrectangle = false
end type

type dw_list from datawindow within w_batch_add_cred_data
boolean visible = false
integer x = 1029
integer y = 2168
integer width = 361
integer height = 80
integer taborder = 100
string dataobject = "d_batch_items_prac_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_pracid = long(data)

//of_prac_name(il_pracid)
end event

type cb_1 from commandbutton within w_batch_add_cred_data
integer x = 3278
integer y = 88
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;parent.event pfc_close( )
end event

type dw_3 from datawindow within w_batch_add_cred_data
boolean visible = false
integer x = 1426
integer y = 2192
integer width = 242
integer height = 56
integer taborder = 110
string dataobject = "d_distinct_clin_for_prac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_batch_add_cred_data
boolean visible = false
integer x = 2990
integer y = 540
integer width = 265
integer height = 100
integer taborder = 30
string dataobject = "d_prac_priv_list_clin_area"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detailxx from u_dw within w_batch_add_cred_data
integer x = 4603
integer y = 232
integer width = 2674
integer height = 1920
integer taborder = 10
string dataobject = "d_insurance_batchadd"
boolean hscrollbar = true
end type

event pfc_preupdate;call super::pfc_preupdate;String ls_screen_name
String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
Long ll_seq_no
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
//Integer il_last_de_row
//Integer il_last_row
Integer p
//Long il_rec_id
//Long il_prac_id
Long li_found
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
Integer li_year //maha031601
Integer li_month//maha031601
Integer li_validate//maha080803
String ls_type1//maha102501
String ls_type2//maha102501
String ls_type3//maha102501



DataWindowChild dwchild

SetNull( ldt_null_date )

dw_detail.AcceptText()
//
//il_last_de_row = dw_detail.GetRow()
//
//li_data_cr = dw_detail.GetRow()
//il_last_row = 1 //dw_select_section.getrow()
//
//li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
//ls_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")
//
//li_rec_count = dw_detail.RowCount()
//
//If li_rec_count < 1 Then
//	Return -1
//End If
//
//If li_rec_count < 1 Then
//	MessageBox("","Please select a practitioner list")
//	Return -1
//End If
//i = 1
////FOR p = 1 TO li_rec_count
//
//SetNull( ll_address_code )
//
//
//
//ls_rec_status = "New"
//
//
//If ii_screen_id = 4 Or ii_screen_id = 15 Or ii_screen_id = 5 then
//	//IF dw_detail.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
//	If dw_detail.GetItemNumber( i, "active_status" ) = 0 Then
//		If ls_rec_status = "New" Then
//			Return 1
//		Else //\/maha 031601
//			Update verif_info
//				Set active_status = 0
//				Where rec_id = :ll_rec_id And active_status = 1;
//			Return 1		 //\maha
//		End If
//	End If
//	//END IF
//End If
//
//
//li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
//
//
inv_data_entry.of_field_audit( dw_detail )


Return 1


end event

event constructor;call super::constructor;//This.iuo_calendar.of_Register(This.iuo_calendar.DDLB)	
This.of_SetReqColumn(TRUE)

end event

type st_1 from statictext within w_batch_add_cred_data
integer x = 923
integer y = 220
integer width = 311
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
boolean enabled = false
string text = "3) Enter data"
boolean focusrectangle = false
end type

type dw_verifww from datawindow within w_batch_add_cred_data
boolean visible = false
integer x = 2395
integer y = 2060
integer width = 485
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ver_summary_record_view"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_verif from u_dw within w_batch_add_cred_data
boolean visible = false
integer x = 3273
integer y = 1952
integer width = 192
integer height = 128
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ver_summary_record_view"
end type

type dw_pracs from datawindow within w_batch_add_cred_data
integer x = 23
integer y = 296
integer width = 846
integer height = 2160
integer taborder = 130
boolean bringtotop = true
boolean titlebar = true
string title = "Providers"
string dataobject = "d_practitioner_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r  = this.getclickedrow()
if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

il_pracid = this.getitemnumber(r,"prac_id")
//messagebox("il_pracid",il_pracid)
//dw_browse.settransobject(sqlca)
//dw_browse.retrieve(il_prac,ii_facil)
//of_retrieve_data(is_ret_type)
end event

type dw_select_section from datawindow within w_batch_add_cred_data
boolean visible = false
integer x = 622
integer y = 2324
integer width = 567
integer height = 84
integer taborder = 120
string dataobject = "d_data_view_screens_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

