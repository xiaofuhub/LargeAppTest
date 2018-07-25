$PBExportHeader$n_cst_recruitmnet.sru
forward
global type n_cst_recruitmnet from nonvisualobject
end type
end forward

global type n_cst_recruitmnet from nonvisualobject
end type
global n_cst_recruitmnet n_cst_recruitmnet

type variables

w_recruitment_data_tabs iw_recruit  //maha 06.02.2015 changed from w_recruitment_data

n_ds ids_screen[6]  //maha 06.02.2015 changed from 3
	
n_ds ids_fields_all

datawindow idw_detail
datawindow idw_document //(Appeon)Stephen 11.04.2015 - V15.1-Additional TDL type of Recruitment Task
datastore ids_image_type

long il_prac_id

end variables

forward prototypes
public function integer of_run ()
public function integer of_convert_basicdata ()
public function integer of_covert_addressdata ()
public function integer of_covert_specialtydata ()
public function integer of_covert_appointment ()
public function integer of_prepare_convert ()
public function integer of_post_convert ()
public function integer of_add_address_link (long al_address_id, long al_prac_id)
public function string of_get_ref (string as_field_name, long al_row, ref boolean ab_lookupfield, n_ds an_data)
public function integer of_add_verif_info (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method)
public function integer of_add_spec_link (long ai_rec_id)
public function integer of_set_screenvalue (integer ai_screen_id, ref string as_fields[])
public function integer of_set_speciavalue (ref string as_fields[])
public function integer of_dyncreate_dw (ref n_ds ads_table, string as_table_name, string as_fields[])
public function integer of_prepare_update (n_ds ads_screen_data, integer ai_screen_id)
public function integer of_app_audit (long al_appt_stat_id)
public function string of_convert_string (string as_string)
public function integer of_setparentwindow (w_recruitment_data_tabs aw_recruit)
public function integer of_convert_otherdata ()
public function integer of_convert_image (integer ai_screen, long al_prac_id, long al_rec_id)
public function integer of_covert_doc2tif (string as_doc_file, blob ab_doc, ref string as_tif_file, ref blob ab_tif)
end prototypes

public function integer of_run ();//====================================================================
//$<Function>: of_run
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer res


of_prepare_convert()

idw_detail = iw_recruit.tab_1.tabpage_data.dw_detail_data
//---------Begin Added by (Appeon)Stephen 11.04.2015 for V15.1-Additional TDL type of Recruitment Task--------
idw_document = iw_recruit.tab_1.tabpage_documents.dw_docs  
ids_image_type = create datastore
ids_image_type.dataobject = "d_dddw_image_types_recruit"
ids_image_type.settransobject(sqlca)
ids_image_type.retrieve()
//---------End Added ------------------------------------------------------

if of_convert_basicdata() = -1 then return -1

 //Start Code Change ----12.08.2015 #V15 maha - added for cancel option
res = of_covert_appointment() 
if res  = -1 then
	MessageBox('convert practitioner','Can not convert the appointment data')
	return -1
elseif res = -2 then  //cancel
	return -1
end if	
 //End Code Change ----12.08.2015
 
if of_covert_addressdata() = -1 then return -1
	
if of_covert_specialtydata() = -1 then return -1

if of_convert_otherdata( ) = -1 then return -1
	
of_post_convert()

return 1
end function

public function integer of_convert_basicdata ();//====================================================================
//$<Function>: of_convert_basicdata
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Convert recruic data to pd_basic
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================

 //Start Code Change ----06.03.2015 #V15 maha - added  gender, ethnicity 


String ls_fields[] = {'first_name','last_name','middle_name','title','name_suffix','prof_suffix' &
						,'date_of_birth','ssn','npi_number','sex','ethnic_category'}
						
if of_dyncreate_dw(ids_screen[1],'pd_basic',ls_fields[]) = -1 then return -1
						
il_prac_id = gnv_app.of_get_id( 'prac_id')
//il_prac_id = 1979

of_set_screenvalue(1,ls_fields[])

ids_screen[1].update()

return 1
end function

public function integer of_covert_addressdata ();//====================================================================
//$<Function>: of_convert_addressdata
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>: Convert recruic data to pd_basic
//====================================================================


String ls_fields[] = {'street','street_2','city','state','zip','country','phone' &
						,'ext','fax','e_mail_address'}
						
if of_dyncreate_dw(ids_screen[2],'pd_address',ls_fields[]) = -1 then return -1

of_set_screenvalue(2,ls_fields[])

return 1

end function

public function integer of_covert_specialtydata ();//====================================================================
//$<Function>: of_covert_specialtydata
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_fields[] = {'specialty','board_certified','board_code','initial_cert_date'}


if of_dyncreate_dw(ids_screen[3],'pd_board_specialty',ls_fields[]) = -1 then return -1

of_set_screenvalue(19,ls_fields[])

return 1
end function

public function integer of_covert_appointment ();//====================================================================
//$<Function>: of_covert_appointment
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.10.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//-------------appeon begin----------------------
//<$>added:long.zhang 11.19.2013
//<$>reason:V14.1 Recruitment Functionality for IntelliApp user
long ll_rec_id
IF gs_cust_type = 'I' THEN
			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
			INSERT INTO pd_affil_stat  
         	( rec_id,   
	           prac_id,   
				  seq_no,
   	        affiliation_status,   
      	     parent_facility_id,   
         	  apptmnt_type,   
	           verifying_facility,   
   	        application_audit_facility,
				  active_status)  
			VALUES ( :ll_rec_id,   
         	  :il_prac_id,   
				  1,
 	           'M',   
   	        1,   
      	     'I',   
         	  1,   
	           1,
				  1)  ;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL Error", SQLCA.SQLERRTEXT )
				Return -1
			END IF
			of_app_audit( ll_rec_id )
			return 1
end if		

//-------------appeon End------------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 11.06.2013
//<$>reason:V14.1 Recruitment Functionality Fix BugA110508 
//gl_prac_id = il_prac_id
//gl_facility_id = 0
//gs_param = 'NEWPRAC'
//open(w_add_appointment)
openWithParm(w_add_appointment,il_prac_id)
//-------------appeon End------------------------

if Message.stringparm = 'Ok' then
	return 1
elseif  Message.stringparm = 'Cancel' then   //Start Code Change ----12.08.2015 #V15 maha - added cancel option
	return -2
else
	return -1
end if

return 1
end function

public function integer of_prepare_convert ();//====================================================================
//$<Function>: of_cache_data
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================




ids_fields_all.retrieve(1)

return 1
end function

public function integer of_post_convert ();//====================================================================
//$<Function>: of_post_convert
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_count
Integer i,li_ret
long ll_old_prac_id

li_count = UpperBound(ids_screen)
ll_old_prac_id = iw_recruit.idw_detail.getItemNumber( 1,'prac_id')

iw_recruit.idw_detail.setitem( 1,'status_change_date',datetime(today(),now()))//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
iw_recruit.idw_detail.setitem( 1,'recruit_status',3)
iw_recruit.idw_detail.setitem( 1,'prac_id',il_prac_id)

gnv_appeondb.of_startqueue( )
	
	For i = 2 to li_count
		li_ret = ids_screen[i].update()
	end for
	
	iw_recruit.idw_detail.update( )	
	update recruit_image set prac_id = :il_prac_id where prac_id = :ll_old_prac_id;
gnv_appeondb.of_commitqueue( )




return 1
end function

public function integer of_add_address_link (long al_address_id, long al_prac_id);//====================================================================
//$<Function>: of_add_address_link
//$<Arguments>:
// 	value    long    al_address_id
// 	value    long    al_prac_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_row_cnt
Integer i
Integer li_nr

long ll_prac_id

n_ds lds_address_link
n_ds lds_parent_facilities

lds_address_link = create n_ds
lds_parent_facilities = create n_ds

lds_address_link.dataobject = 'd_addr_link_check_boxes'
lds_parent_facilities.dataobject = 'd_address_link_parent_facility_id'

lds_address_link.SetTransObject( SQLCA )
lds_parent_facilities.settransobject( sqlca)


li_row_cnt = lds_parent_facilities.retrieve(al_prac_id)

FOR i = 1 TO li_row_cnt
	li_nr = lds_address_link.InsertRow( 0 )
	lds_address_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_address_link.SetItem( li_nr, "address_id", al_address_id )
	lds_address_link.SetItem( li_nr, "facility_id", lds_parent_facilities.GetItemNumber( i, "parent_facility_id" ) )
	lds_address_link.SetItem( li_nr, "mailing", 0 )
	lds_address_link.SetItem( li_nr, "billing", 0 )
	lds_address_link.SetItem( li_nr, "home_address", 0 )
	lds_address_link.SetItem( li_nr, "primary_office", 0 ) 
	lds_address_link.SetItem( li_nr, "additional_office", 0 )
	lds_address_link.SetItem( li_nr, "include_in_directory", 0 )
	lds_address_link.SetItem( li_nr, "exp_letters", 0 )
END FOR

lds_address_link.Update()

destroy lds_address_link
destroy lds_parent_facilities

Return 1
end function

public function string of_get_ref (string as_field_name, long al_row, ref boolean ab_lookupfield, n_ds an_data);//====================================================================
//$<Function>: of_get_ref
//$<Arguments>:
// 	value        string     as_field_name
// 	value        long       al_row
// 	reference    boolean    ab_lookupfield
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.13.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_field_value
string ls_table_name
long ll_row
long ll_lookup_code

ll_row = ids_fields_all.find( "lower(db_field_name)='"+ lower(as_field_name) +"'", 1,ids_fields_all.rowcount())
if ll_row <= 0 then return ''

if ids_fields_all.getitemstring( ll_row,'lookup_field') = 'Y' then
	ab_lookupfield = true
	ll_lookup_code = an_data.getitemnumber( al_row,as_field_name)
	
	if ids_fields_all.getitemstring( ll_row,'lookup_type') = 'C' then
			ls_table_name = 'code_lookup'
		else
			ls_table_name = 'address_lookup'
	end if
	
	 choose case lower(ids_fields_all.getitemstring( ll_row,'lookup_field_name'))
		case 'code'
			ls_field_value = gnv_data.of_getitem( ls_table_name,'code','lookup_code='+String(ll_lookup_code))
		case 'description'
			ls_field_value = gnv_data.of_getitem( ls_table_name,'description','lookup_code='+String(ll_lookup_code))
		case 'entity_name','entity_name_original'	
			ls_field_value = gnv_data.of_getitem( ls_table_name,'entity_name','lookup_code='+String(ll_lookup_code))
	 end choose
	 
else
	choose case ids_fields_all.getitemstring( ll_row,'field_type')
		case 'N'
			ls_field_value = String(an_data.getitemnumber( al_row,as_field_name))
		case 'D'
			ls_field_value = String(an_data.getitemdatetime( al_row,as_field_name),'mm/dd/yyyy')
		case else
			ls_field_value = an_data.getitemstring( al_row,as_field_name)
	end choose
end if

if isNull(ls_field_value) then ls_field_value = ''

return ls_field_value
end function

public function integer of_add_verif_info (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method);//////////////////////////////////////////////////////////////////////
// $<function> of_add_verif_info
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.29.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Integer li_nr
Integer li_nr2 
Integer li_row_cnt
Integer li_rc
Integer i
Integer r
Integer ll_hc_code
Integer li_rsp_rc
Integer li_facility_id
Integer li_priority
Integer li_ver_priority
integer li_dupe_check 
integer resp 
integer li_parent_id 
integer li_date_check 
integer li_fac_ids
integer pc
integer pi
integer li_end_year
integer li_end_month
integer li_end_day
integer li_check_back_years
integer li_prime_check
integer li_isprime 
integer li_complete 
Long ll_seq_no
Long ll_default_verif_method
long ll_comp_method 
String ls_identifying_number
string ls_facility_name
String ls_doc_id
String ls_priority_user
String ls_ver_priority_user
string ls_primary_check 
string ls_screen_name 
string ls_appt_type = "R" 
string ls_verif_data 
datetime ld_verifdate 
datetime ld_dr 
date ld_hosp_check_date
date ld_data_check_date
n_ds lds_ver_orgs_facilities
n_ds lds_last_verif_seq_no
n_ds lds_dfl_rsp_code
n_ds lds_parent_facilities
n_ds lds_verif_facilities
Long ll_i
Long li_facility_id_arr[],al_prac_id_arr[],al_rec_id_arr[]
datastore lds_facility
n_ds lds_detail

IF al_address_lookup_code = 0 THEN
	SetNull( al_address_lookup_code )
END IF

ls_identifying_number = MidA( as_reference, PosA( as_reference, "-") + 2, 100 )

if al_screen_id = 1 then
	return 1
end if

lds_verif_facilities = CREATE n_ds
lds_verif_facilities.DataObject = "d_verifying_orgs_facilities_of_pract"
lds_verif_facilities.of_SetTransObject( SQLCA )

li_rc = lds_verif_facilities.Retrieve( al_prac_id,al_screen_id )
lds_verif_facilities.setsort("verifying_facility A")
lds_verif_facilities.sort()

IF li_rc = 0 THEN			
	MessageBox("Error in function of_add_verif_info", "No active affiliation status records found.  Be sure there is an active appointment status record for this practitioner." ) 
	destroy lds_verif_facilities
	Return -1
END IF

i = lds_verif_facilities.Find("upper(verify_data) <> 'N' OR Isnull(verify_data)" ,1 ,li_rc)
If	Isnull(i) Or i <= 0 Then 
	destroy lds_verif_facilities
	Return 1
end if
lds_detail = CREATE n_ds
lds_detail.DataObject = 'd_ver_summary_record_view'
lds_detail.of_SetTransObject( SQLCA )

lds_dfl_rsp_code = CREATE n_ds
lds_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
lds_dfl_rsp_code.of_SetTransObject( SQLCA )

lds_ver_orgs_facilities = CREATE n_ds
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_forpt"
lds_ver_orgs_facilities.of_SetTransObject( SQLCA )

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_verifying_parents_of_vers_forpt"
lds_parent_facilities.of_SetTransObject( SQLCA )

lds_last_verif_seq_no = CREATE n_ds
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt_pract"
lds_last_verif_seq_no.of_SetTransObject( SQLCA )

FOR i = 1 TO li_rc//li_ver_fac_cnt
	li_facility_id = lds_verif_facilities.GetItemNumber( i, "verifying_facility" )
	li_facility_id_arr[i] = li_facility_id
END FOR

al_prac_id_arr[1] = al_prac_id
al_rec_id_arr[1] = al_rec_id

gnv_appeondb.of_startqueue( )

lds_dfl_rsp_code.Retrieve( al_prac_id, al_screen_id, ls_identifying_number )
lds_parent_facilities.retrieve(li_facility_id_arr[],al_prac_id_arr[])
lds_last_verif_seq_no.Retrieve( al_rec_id, al_prac_id, al_screen_id )
lds_ver_orgs_facilities.Retrieve( li_facility_id_arr[], al_prac_id, al_screen_id )

if as_add_type <> "A" then 
	if al_screen_id = 10 then 
		Select year_thru,month_thru
		into :li_end_year,:li_end_month
		from pd_hosp_affil
		where rec_id = :al_rec_id;
	end if
	if al_screen_id = 7 or al_screen_id = 6 then 
		Select year_thru,month_thru
		into :li_end_year,:li_end_month
		from pd_training
		where rec_id = :al_rec_id;
	end if
end if

If al_screen_id = 10 Then
	Datastore lds_facility_ver_rules
	lds_facility_ver_rules = create datastore
	lds_facility_ver_rules.dataobject = "d_facility_ver_rules_forpt"
	lds_facility_ver_rules.Settransobject( SQLCA )
	lds_facility_ver_rules.Retrieve( li_facility_id_arr[] )
End If

lds_facility = create datastore
lds_facility.dataobject = "d_facility_forpt"
lds_facility.Settransobject( SQLCA )
lds_facility.Retrieve( li_facility_id_arr[] )

gnv_appeondb.of_commitqueue( )

li_rsp_rc = lds_dfl_rsp_code.Rowcount( )

If al_screen_id = 10 then
	Long li_parent_id_arr[]
	pc = lds_parent_facilities.Rowcount( )
	for pi = 1 to pc
		li_parent_id =  lds_parent_facilities.GetItemnumber( pi, "parent_facility_id" )
		li_parent_id_arr[pi] = li_parent_id
	next
	
	Datastore lds_pd_hosp_facility_link
	lds_pd_hosp_facility_link = create datastore
	lds_pd_hosp_facility_link.dataobject = "d_pd_hosp_facility_link_forpt"
	lds_pd_hosp_facility_link.Settransobject( SQLCA )
	lds_pd_hosp_facility_link.Retrieve( al_rec_id , li_parent_id_arr[] )
End If

Integer li_facility_id_first = -1

FOR i = 1 TO li_rc//li_ver_fac_cnt
	li_date_check = 0
	li_facility_id = lds_verif_facilities.GetItemNumber( i, "verifying_facility" )
	ls_facility_name = lds_verif_facilities.GetItemstring( i, "facility_name" )
	ls_verif_data = lds_verif_facilities.GetItemstring( i, "verify_data" )
	li_complete = lds_verif_facilities.GetItemNumber( i, "compl_at_create" )
	ll_comp_method = lds_verif_facilities.GetItemNumber( i, "compl_default" )
	if isnull(ll_comp_method) then ll_comp_method = 0
	if li_complete = 1 and ll_comp_method > 0 then
		al_complete_response = ll_comp_method
	end if
	if ls_verif_data = "N" then continue
	if isnull(ls_verif_data) then continue

	lds_parent_facilities.SetFilter("verifying_facility = "+string(li_facility_id) )	
	lds_parent_facilities.Filter( )
	pc = lds_parent_facilities.Rowcount( )

	if pc < 1 then messagebox("Error","No retrieval on parents of verif facility")
		ls_appt_type = "R"
	for pi = 1 to pc
		if ls_appt_type = "R" and lds_parent_facilities.GetItemstring( pi, "apptmnt_type" )  = "I" then
			ls_appt_type = "I"
		end if

		ld_verifdate = lds_parent_facilities.GetItemdatetime( pi, "date_verif_completed" )
		if not(isnull(ld_verifdate)) then
			li_date_check = 1
		end if
	next

	if ls_verif_data = "I" and ls_appt_type = "R" then continue
	
	if li_date_check = 1 then
		resp = messagebox("Verifications Completed" ,"The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + ". Do you want to add the verification item.",question!,yesno!,2)
		if resp = 2 then continue
	end if
	
	lds_ver_orgs_facilities.SetFilter("verifying_facility = " + String(li_facility_id) ) 
	lds_ver_orgs_facilities.Filter()
	r = lds_ver_orgs_facilities.Rowcount( )

	if r < 1 then continue
	IF lds_ver_orgs_facilities.GetItemString( r, "verify_data" ) = "N" AND as_add_type = "A" THEN
		CONTINUE
	END IF
	if al_screen_id = 10 or al_screen_id = 7 or al_screen_id = 6 then 
		li_check_back_years = lds_ver_orgs_facilities.GetItemNumber(r,"check_back_years")
		if lds_ver_orgs_facilities.GetItemstring(r,"apptmnt_type") = "R" and li_check_back_years  > 0 then
			if as_add_type = "A" then
				li_end_year = as_end_year
				li_end_month = as_end_month
			end if
			if not(isnull(li_end_year)) or li_end_year = 0  then
				if not(isnull(lds_ver_orgs_facilities.GetItemdatetime(r,"check_date"))) then
					if isnull(li_end_month) or li_end_month  = 0 then li_end_month = 12 
					choose case li_end_month
						case 2
							li_end_day = 28
						case 4,6,9,11
							li_end_day = 30
						case else
							li_end_day = 31
					end choose
					ld_hosp_check_date = date(li_end_year,li_end_month, li_end_day)
					ld_data_check_date = date(lds_ver_orgs_facilities.GetItemdatetime(r,"check_date"))
					if relativedate(ld_hosp_check_date,li_check_back_years * 365) < ld_data_check_date then continue	
				end if
			end if
		end if
	end if
	if al_screen_id = 10 then
		ls_primary_check = ""
		ll_i = lds_facility_ver_rules.Find( "facility_id = " + String(li_facility_id) ,1 , lds_facility_ver_rules.Rowcount())
		If ll_i > 0 Then ls_primary_check = lds_facility_ver_rules.GetItemString(ll_i,"exp_reminder_doc")
		
		if ls_primary_check = "Y" then
			li_isprime = 0
			for pi = 1 to pc  
				li_parent_id =  lds_parent_facilities.GetItemnumber( pi, "parent_facility_id" )
				li_prime_check = 0
				ll_i = lds_pd_hosp_facility_link.Find("facility_id = " + String(li_parent_id), 1 , lds_pd_hosp_facility_link.Rowcount() )
				If ll_i > 0 Then li_prime_check = lds_pd_hosp_facility_link.Getitemnumber(ll_i , "primary_hosp")
				
				if li_prime_check = 581 then li_isprime = 1
			next
			if li_isprime = 0 then continue
		end if
	end if

	if al_method = -1 then
		ll_default_verif_method = lds_ver_orgs_facilities.GetItemNumbeR( r, "default_verif_means" )	
	else
		ll_default_verif_method = al_method
	end if

	li_nr = lds_detail.InsertRow( 0 )
	ls_priority_user = lds_ver_orgs_facilities.GetItemString( r, "priority_user" )	

	if isnull(ls_priority_user ) or LenA(ls_priority_user ) < 1 then ls_priority_user = "PUBLIC" 
	li_priority = lds_ver_orgs_facilities.GetItemNumber( r, "priority" )
	li_ver_priority = lds_ver_orgs_facilities.GetItemNumber( r, "facility_ver_rules_priority" )
	ls_ver_priority_user = lds_ver_orgs_facilities.GetItemString( r, "facility_ver_rules_priority_user")
	if isnull(ls_ver_priority_user ) or LenA(ls_ver_priority_user ) < 1 then
	else
		ls_priority_user = ls_ver_priority_user
	end if
	
	if isnull(li_ver_priority) or li_ver_priority  < 1 then
	else
		li_priority = li_ver_priority
	end if
	
	lds_detail.SetItem( li_nr, "prac_id", al_prac_id )
	lds_detail.SetItem( li_nr, "rec_id", al_rec_id )
	lds_detail.SetItem( li_nr, "verif_info_facility_id", li_facility_id )
	lds_detail.SetItem( li_nr, "priority_user", ls_priority_user )
	lds_detail.SetItem( li_nr, "priority", li_priority )
	lds_detail.SetItem( li_nr, "number_sent", 0 )
	lds_detail.SetItem( li_nr, "exp_credential_flag", 0)
	lds_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )	
	lds_detail.SetItem( li_nr, "verif_info_data_status", ai_data_status )
	
	IF al_complete_response > 0 THEN 
		  lds_detail.SetItem( li_nr, "response_code", al_complete_response )		
		  ld_dr = DateTime( Today(), Now() )
		  lds_detail.SetItem( li_nr, "date_recieved", ld_dr )					  
		  lds_detail.SetItem( li_nr, "user_name", gs_user_id )
		  if ai_data_status = 2 then lds_detail.SetItem( li_nr, "exp_credential_flag", 2) 
	END IF	

	if li_facility_id_first = li_facility_id then 
		ll_seq_no++
	else
		lds_last_verif_seq_no.SetFilter("facility_id = "+string(li_facility_id) )
		lds_last_verif_seq_no.Filter( )
		li_row_cnt = lds_last_verif_seq_no.Rowcount( )
	
		IF li_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		if isnull(ll_seq_no) then 	ll_seq_no = 1	
		li_facility_id_first = li_facility_id
	end if 
	lds_detail.SetItem( li_nr, "seq_no", ll_seq_no )
		
	lds_detail.SetItem( li_nr, "screen_id", al_screen_id )
	lds_detail.SetItem( li_nr, "reference_value",MidA(as_reference,1,100)) 
	lds_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
	lds_detail.SetItem( li_nr, "screen_name", as_screen_name )
	lds_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
	ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
	lds_detail.SetItem( li_nr, "doc_id", ls_doc_id )
	
	lds_detail.SetItem(li_nr, 'create_date', datetime(today(),now()))
	lds_detail.SetItem(li_nr, 'create_user', gs_user_id)

	li_dupe_check = 0
	ll_i = lds_facility.Find( "facility_id = " + String(li_facility_id) ,1 , lds_facility.Rowcount())
	If ll_i > 0 Then li_dupe_check = lds_facility.GetItemNumber(ll_i,"dupeset")
	if li_dupe_check = 1 then
		if al_screen_id = 7 or al_screen_id = 10 then
			ls_appt_type = lds_ver_orgs_facilities.GetItemString( 1, "apptmnt_type" )
			if ls_appt_type = "I" then
				li_nr2 = lds_detail.InsertRow( 0 )
				lds_detail.SetItem( li_nr2, "prac_id", al_prac_id )
				lds_detail.SetItem( li_nr2, "rec_id", al_rec_id )
				lds_detail.SetItem( li_nr2, "verif_info_facility_id", li_facility_id )
				lds_detail.SetItem( li_nr2, "priority_user", ls_priority_user )
				lds_detail.SetItem( li_nr2, "priority", li_priority )
				lds_detail.SetItem( li_nr2, "number_sent", 0 )
				lds_detail.SetItem( li_nr2, "exp_credential_flag", 0)
				IF li_rsp_rc = 1 THEN
					lds_detail.SetItem( li_nr2, "response_code", lds_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
					lds_detail.SetItem( li_nr2, "user_name", ls_priority_user )
					lds_detail.SetItem( li_nr2, "date_recieved", Today() )
					lds_detail.SetItem( li_nr2, "verification_method", ll_hc_code )				
				ELSE
					lds_detail.SetItem( li_nr2, "verification_method", ll_default_verif_method )		
				END IF
	
				ll_seq_no++	
				lds_detail.SetItem( li_nr2, "seq_no", ll_seq_no )
				lds_detail.SetItem( li_nr2, "screen_id", al_screen_id )
				lds_detail.SetItem( li_nr2, "reference_value", as_reference )
				lds_detail.SetItem( li_nr2, "expiration_date", adt_exp_date )
				ls_screen_name = as_screen_name + "_CC" 
				lds_detail.SetItem( li_nr2, "screen_name", ls_screen_name )
				lds_detail.SetItem( li_nr2, "verification_id", 2 )
				lds_detail.SetItem( li_nr2, "address_lookup_code", al_address_lookup_code )
				ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
				lds_detail.SetItem( li_nr2, "doc_id", ls_doc_id )
			end if
		end if
	end if	
END FOR

DESTROY lds_ver_orgs_facilities
DESTROY lds_parent_facilities
DESTROY lds_verif_facilities
DESTROY lds_last_verif_seq_no
DESTROY lds_dfl_rsp_code

if IsValid(lds_pd_hosp_facility_link) then Destroy lds_pd_hosp_facility_link

If lds_detail.ModifiedCount( ) > 0 Then
	resp = lds_detail.Update()
	if resp < 1 then  
		messagebox("Update failure in of_add_verif_info (Recruitment)", "Verification not created.")
	end if
End If
Destroy lds_detail 

RETURN 1


end function

public function integer of_add_spec_link (long ai_rec_id);//====================================================================
//$<Function>: of_add_spec_link
//$<Arguments>:
// 	value    long    ai_rec_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
n_ds lds_spec_link
n_ds lds_parent_facilities
Integer li_row_cnt
Integer i
Integer li_nr

lds_spec_link = CREATE n_ds
lds_spec_link.DataObject = "d_sf_link"
lds_spec_link.of_SetTransObject( SQLCA )


lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
li_row_cnt = lds_parent_facilities.Retrieve( il_prac_id )

FOR i = 1 TO li_row_cnt
	li_nr = lds_spec_link.InsertRow( 0 )	
	lds_spec_link.SetItem( li_nr, "prac_id", il_prac_id )
	lds_spec_link.SetItem( li_nr, "specialty_id", ai_rec_id )
	lds_spec_link.SetItem( li_nr, "practicing", 581)	 //Start Code Change ----02.04.2010 #V10 maha changed to yes from no
	lds_spec_link.SetItem( li_nr, "facility_id", lds_parent_facilities.GetItemNumber( i, "parent_facility_id" ) )
END FOR

IF li_row_cnt > 0 THEN
	gnv_appeondb.of_autocommit( )
	lds_spec_link.Update()
	commit using sqlca;
END IF

DESTROY lds_spec_link
DESTROY lds_parent_facilities

Return 1
end function

public function integer of_set_screenvalue (integer ai_screen_id, ref string as_fields[]);//====================================================================
//$<Function>: of_set_screenvalue
//$<Arguments>:
// 	value        integer    ai_screen_id
// 	reference    string     as_fields[] = the fields where data will be added
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
Integer li_fields_count
long ll_row,ll_newrow
long ll_rec_id
long ll_value  //maha 06.03.02015

String ls_field_type
String ls_fields[]
String ls_field_name
String ls_name_street
String ls_middle_name
n_ds lds_data
	
ls_fields[] =as_fields[]

li_fields_count = UpperBound(ls_fields[])						

ids_fields_all.setfilter('data_view_fields_screen_id='+String(ai_screen_id))						
ids_fields_all.filter( )

choose case ai_screen_id
	case 1
		lds_data = ids_screen[1]
	case 2
		lds_data =ids_screen[2]
		//-------------appeon begin----------------------
		//<$>added:long.zhang 02.28.2014
		//<$>reason:Bug #3957 - Accepted recruit's street address is being put in the Name/Address instead of Street
		ls_name_street = of_convert_string(ids_screen[1].getitemstring( 1,'first_name'))
		ls_name_street += ' '
		
		ls_middle_name =  of_convert_string(ids_screen[1].getitemstring( 1,'middle_name'))
		
		if ls_middle_name <> '' then
			ls_name_street += ls_middle_name
			ls_name_street += ' '
		end if
		
		ls_name_street += of_convert_string(ids_screen[1].getitemstring( 1,'last_name'))
		//-------------appeon End------------------------
	case 19
		return of_set_speciavalue(as_fields[])
	case 4
		lds_data = ids_screen[4]
	case 5
		lds_data = ids_screen[5]
	case 25
		lds_data = ids_screen[6]
end choose


if ai_screen_id = 25 then  //languages
	for i = 1 to 3
		ls_field_name = "language" + string(i)
		ll_value = idw_detail.getItemNumber(1,ls_field_name)
		if not isnull(ll_value) then
			ll_newrow = lds_data.insertrow(0)
			lds_data.setitem(ll_newrow, "foreign_language",ll_value)
			//---------Begin Modified by (Appeon)Stephen 04.22.2016 for V15 recruitment issues with Build 3/28/16--------
			//lds_data.setItem(1,'prac_id',il_prac_id)
			lds_data.setItem(ll_newrow,'prac_id',il_prac_id)
			//---------End Modfiied ------------------------------------------------------
		end if
	next
	
else  //other screens
	ll_newrow = lds_data.insertrow(0)
	
	For i = 1 to li_fields_count
	
		ll_row = ids_fields_all.find( "lower(db_field_name)='"+ lower(ls_fields[i]) +"'",1,ids_fields_all.rowcount())		
		
		if ll_row > 0 then
			
			ls_field_type = ids_fields_all.getitemstring( ll_row,'field_type')
			ls_field_name = ls_fields[i]
			
			 //Start Code Change ----06.03.2015 #V15 maha - field exceptions
			// if ai_screen_id = 1 and lower(ls_field_name) = 'npi_number' then ls_field_name = 'npi'
			choose case ai_screen_id
				case 1
					choose case lower(ls_field_name) 
						case 'npi_number' 
							ls_field_name = 'npi'	
						case 'sex' 
							ls_field_name = 'gender'		
						case 'ethnic_category' 
							ls_field_name = 'ethnicity'
					end choose
				case 4 //license
					choose case lower(ls_field_name) 
						case 'license_number' 
							ls_field_name = 'primary_license_number'	
						case 'state' 
							ls_field_name = 'license_state'		
						case 'issue_date' 
							ls_field_name = 'license_effective'
					end choose
				case 5 //dea
					 if lower(ls_field_name) = 'license_number' then ls_field_name = 'dea_number'			
			end choose
			
			choose case ls_field_type
				case 'N'
//					messagebox(ls_fields[i], ls_field_name)
					lds_data.setitem(ll_newrow,ls_fields[i], idw_detail.getItemNumber(1,ls_field_name))
				case 'C'
					if ai_screen_id = 2 and lower(ls_field_name) = 'street' then//added by long.zhang appeon  02.28.2014 Testing Bug #3957
						lds_data.setitem(ll_newrow,'street_2',idw_detail.getItemString(1,ls_field_name))
					elseif ai_screen_id = 2 and lower(ls_field_name) = 'street_2' then //added by long.zhang 02.28.2014 Testing Bug #3957
						Continue
					else
//						messagebox(ls_fields[i], ls_field_name)
						lds_data.setitem(ll_newrow,ls_fields[i], idw_detail.getItemString(1,ls_field_name))
					end if
				case 'D'
						lds_data.setitem(ll_newrow,ls_fields[i],idw_detail.getItemDatetime(1,ls_field_name))
			end choose
		end if
	
	end for
	
	lds_data.setItem(1,'prac_id',il_prac_id)		
	//if ai_screen_id = 2 then lds_data.setItem(1,'active_status',1)
	if ai_screen_id = 2 then
		lds_data.setItem(1,'active_status',1)
		if len(ls_name_street) > 150 then ls_name_street = left(ls_name_street,150)	//long.zhang  02.28.2014 Testing Bug #3957
		lds_data.setItem(1,'street',ls_name_street)	//long.zhang  02.28.2014 Testing Bug #3957
	 //Start Code Change ----06.03.2015 #V15 maha
	elseif ai_screen_id = 4 then  //license
		lds_data.setItem(1,'active_status',1)
	elseif ai_screen_id = 5  then  //dea
		lds_data.setItem(1,'active_status',1)
		lds_data.setItem(1,'state',90)
	 //End Code Change ----06.03.2015	
	end if	
end if //screen 25	

if of_prepare_update(lds_data,ai_screen_id) = -1 then return -1
return 1
end function

public function integer of_set_speciavalue (ref string as_fields[]);//====================================================================
//$<Function>: of_set_speciavalue
//$<Arguments>:
// 	reference    string    as_fields[]
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
Integer j
Integer li_fieldcount
Integer li_newrow
long ll_row

String ls_fields[]
String ls_field_type
String ls_fieldname

li_fieldcount = UpperBound(as_fields[])
	
ls_fields[] = as_fields[]

For i = 1 to 3
	li_newrow = ids_screen[3].InsertRow(0)
	For j = 1 to li_fieldcount
		
		if ids_screen[3].describe( ls_fields[j]+'.ColType') = '!' then continue
			
		ll_row = ids_fields_all.find( "lower(db_field_name)='"+ lower(ls_fields[j]) +"'",1,ids_fields_all.rowcount())		
		
		ls_fieldname = ls_fields[j] + String(i)
		
			if ll_row > 0 then
				ls_field_type = ids_fields_all.getitemstring( ll_row,'field_type')
				choose case ls_field_type
					case 'N'
						if not isNull(idw_detail.getItemNumber(1,ls_fieldname)) then
							ids_screen[3].setitem(li_newrow,ls_fields[j],idw_detail.getItemNumber(1,ls_fieldname))
						end if	
					case 'C'
						if not isNull(idw_detail.getItemString(1,ls_fieldname)) then
							 ids_screen[3].setitem(li_newrow,ls_fields[j],idw_detail.getItemString(1,ls_fieldname))
						end if	 
					case 'D'
						if not isNull(idw_detail.getItemDatetime(1,ls_fieldname)) then
							 ids_screen[3].setitem(li_newrow,ls_fields[j],idw_detail.getItemDatetime(1,ls_fieldname))
						end if	 
				end choose
			end if
	end for
end for

for i =  ids_screen[3].rowcount() to 1 step -1
		if  ids_screen[3].getItemStatus(i,0,primary!) <> NewModified! then
			ids_screen[3].rowsdiscard(i,i,primary!)
			continue
		else
			ids_screen[3].setitem(i,'prac_id',il_prac_id)
		end if
end for

of_prepare_update(ids_screen[3],19)	

return 1
end function

public function integer of_dyncreate_dw (ref n_ds ads_table, string as_table_name, string as_fields[]);//====================================================================
//$<Function>: of_dyncreate_auditdw
//$<Arguments>:
// 	reference    n_ds      ads_table
// 	value        string    as_table_name
// 	value        string    as_fields[]
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer i
Integer li_fieldcount

string ls_fields, ls_sqlselect
string ls_Syntax, ls_Error
n_cst_dw_update_prop lnv_DwSyntax
li_fieldcount = UpperBound(as_fields)

ls_sqlselect = 'select rec_id,prac_id, '

For i = 1 to li_fieldcount
	
	ls_sqlselect += as_fields [i]
	
	if i < li_fieldcount then ls_sqlselect += ','
	
end for

//Start Code Change ----06.03.2015 #V15 maha - chaged to case; added license and dea
choose case  lower(as_table_name) 
	case 'pd_address' 
		ls_sqlselect += ',active_status'
	case 'pd_license' 
		ls_sqlselect += ',active_status'
	case 'pd_dea_state_csr' 
		ls_sqlselect += ',active_status, state'
end choose
 //End Code Change ----06.03.2015

ls_sqlselect += ' From ' + as_table_name


ls_Syntax = SQLCA.SyntaxFromSQL(ls_sqlselect, "Style(Type=Grid)", ls_Error)
IF LenA(ls_Error) > 0 THEN
	MessageBox("of_dyncreate_dw","Failed to dynamically create "+ as_table_name +" datawindow." + ls_Error)
		RETURN -1
END IF
ads_table.Create(ls_Syntax, ls_Error)

IF LenA(ls_Error) > 0 THEN
	RETURN -1
END IF

if lnv_DwSyntax.of_ModifyUpdateProperty(ads_table, as_table_name, false) = -1 then 
	MessageBox("of_dyncreate_dw","Failed to modify datawindow update properties.")
	Return -1
end if
ads_table.settransobject(sqlca)

return 1
end function

public function integer of_prepare_update (n_ds ads_screen_data, integer ai_screen_id);//====================================================================
//$<Function>: of_prepare_update
//$<Arguments>:
// 	value    n_ds       ads_screen_data
// 	value    integer    ai_screen_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_type1
string ls_type2
string ls_type3
string ls_ref_1
string ls_ref_2
string ls_ref_3
string ls_exp_field
string ls_Reference
string ls_screen_name
string ls_table_name
string ls_data_status //maha 08.04.08
string ls_rec_status
integer li_year
integer li_month
Integer li_screen_id
integer li_dstatus  //maha 08.04.08
long ll_prac_id
long ll_rec_id
long ll_address_code
long ll_verif_response
long ll_table_id
long i, ll_Row
long ll_FindRow
long ll_RowCount
long ll_newcnt
long ll_rec_id_new
long ll_ver_method = -1
DateTime ldt_exp_date
Integer li_table_id
DwItemStatus ldw_status
constant long LL_CACHE_RECORDS = 100


datastore lds_dataview_screen

lds_dataview_screen = create datastore
lds_dataview_screen.dataobject = 'd_data_view_screens_list'
lds_dataview_screen.settransobject(  sqlca)
lds_dataview_screen.retrieve( 1 )

ll_FindRow = lds_dataview_screen.find( 'screen_id='+String(ai_screen_id),1,lds_dataview_screen.rowcount())
ls_ref_1 = lds_dataview_screen.GetItemString( ll_FindRow, "ref_field_1")
ls_ref_2 = lds_dataview_screen.GetItemString( ll_FindRow, "ref_field_2")
ls_ref_3 = lds_dataview_screen.GetItemString( ll_FindRow, "ref_field_3")
ls_type1 = lds_dataview_screen.GetItemString( ll_FindRow, "ref_1_type")//maha102501
ls_type2 = lds_dataview_screen.GetItemString( ll_FindRow, "ref_2_type")//maha102501
ls_type3 = lds_dataview_screen.GetItemString( ll_FindRow, "ref_3_type")//maha102501

ls_exp_field = lds_dataview_screen.GetItemString( ll_FindRow, "exp_field")
li_screen_id = lds_dataview_screen.GetItemNumber( ll_FindRow, "screen_id")
ls_screen_name = lds_dataview_screen.GetItemString( ll_FindRow, "screen_name")
li_table_id = lds_dataview_screen.GetItemNumber(ll_FindRow , "table_id" )

destroy lds_dataview_screen


if Upper(gs_cust_type) = 'I' then
	ll_verif_response = 326
end if

ll_RowCount = ads_screen_data.rowcount( )


For ll_row = 1 to ads_screen_data.rowcount( )
	if ads_screen_data.getitemstatus( ll_row,0,primary!) = NewModified! then
		ll_newcnt ++
	end if
end for

if ll_newcnt > 0 then
	ll_rec_id_new = gnv_app.of_Get_Id("RECORD_ID" , ll_newcnt) - 1
	If ll_rec_id_new < 0 Then //Added By Ken.Guo 04.24.2008.
		Return -1
	End If
end if

for ll_row = 1 to ll_RowCount
	SetNull( ll_address_code )
	ldw_status = ads_screen_data.getitemstatus(ll_row,0,Primary!)	
 	if ldw_status <> NewModified! then
			continue
	else		
			ll_rec_id_new++
			ads_screen_data.setitem( ll_row,'rec_id', ll_rec_id_new)
			 ll_prac_id = ads_screen_data.getitemnumber( ll_row,'prac_id')
			 if isnull(ll_prac_id) then continue //(Appeon)Stephen 04.22.2016 - V15 recruitment issues with Build 3/28/16
			 if ai_screen_id =2 then
				of_add_address_link(ll_rec_id_new,ll_prac_id)			
			elseif ai_screen_id = 19 then	//add professional board link
				of_add_spec_link(ll_rec_id_new)	
			end if
	end if
	 
	 ll_rec_id = ads_screen_data.getitemnumber( ll_row,'rec_id')
	 ll_prac_id = ads_screen_data.getitemnumber( ll_row,'prac_id')
	 
	

	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN
			if LenA(ls_exp_field) > 0 then
				if ls_exp_field = "certification_expires" then				
					ldt_exp_date = DateTime(Date(String(ads_screen_data.GetItemNumber(ll_Row, ls_exp_field)) + "-12-30"),Now())
				elseif ls_exp_field = "cert_expiration_year" then
					li_month = ads_screen_data.GetItemNumber(ll_Row, "cert_expiration_month")
					if IsNull(li_month) then
						ldt_exp_date = DateTime(Date(String(ads_screen_data.GetItemNumber(ll_Row, ls_exp_field)) + "-12-30"),Now())
					else
						ldt_exp_date = DateTime(Date(String(ads_screen_data.GetItemNumber(ll_Row, ls_exp_field)) + "-" + String(li_month) + "-28"),Now())
					end if
				else
					if ads_screen_data.Describe(ls_exp_field + ".ColType") <> "!" then
						ldt_exp_date = ads_screen_data.GetItemDateTime(ll_Row, ls_exp_field)	
					else				
						//of_log(ll_ImportDataRow, "", IL_ERRTYPE_ADDVERIFY, "02-Required Field '" + ls_exp_field + "' is invalid")
					//	Return -1
					setNull(ldt_exp_date)
					end if
				end if
			else
				SetNull(ldt_exp_date)
			end if
	end if		
	
		//get reference  data 	
		boolean lb_lookup = false
		
		if not isNull(ls_ref_1) and ads_screen_data.Describe(ls_ref_1 + ".ColType") <> "!" then
			ls_reference = of_get_ref(ls_ref_1,ll_row,lb_lookup,ads_screen_data)
		end if	
		
		if lb_lookup then
			if ls_type1 = 'C' then
				ll_address_code = Long(ads_screen_data.getitemstring( ll_row,ls_ref_1))
			elseif 	ls_type1 = 'N' then
				ll_address_code = ads_screen_data.getitemnumber( ll_row,ls_ref_1)
			end if
		end if
		ls_reference += '-'
		
		if not isNull(ls_ref_1) and ads_screen_data.Describe(ls_ref_2 + ".ColType") <> "!" then
			ls_reference += of_get_ref(ls_ref_2,ll_row,lb_lookup,ads_screen_data)
		end if		
		
		if ads_screen_data.Describe("active_status" + ".ColType") <> "!" then //if active status exists
			li_dstatus = ads_screen_data.GetItemnumber(ll_Row, "active_status")
		else
			setnull(li_dstatus)
		end if				
		
		if ai_screen_id > 1 then  //Start Code Change ----06.09.2015 #V15 maha - skip for screen 1
			if of_add_verif_info(ll_prac_id,ll_rec_id,ai_screen_id,ls_reference,ldt_exp_date,ls_screen_name,ll_address_code, &
				'A',li_month,li_year,ll_verif_response,li_dstatus,ll_ver_method)	 = -1 then
					return -1
			end if
		end if
		
		of_convert_image(ai_screen_id, ll_prac_id,ll_rec_id) //(Appeon)Stephen 11.04.2015 - V15.1-Additional TDL type of Recruitment Task
next
 
String ls_error_text

pfc_cst_nv_data_entry_functions lnv_data_entry

lnv_data_entry = create pfc_cst_nv_data_entry_functions

lnv_data_entry.of_field_audit( ads_screen_data,ls_error_text)

destroy lnv_data_entry

return 1
end function

public function integer of_app_audit (long al_appt_stat_id);//====================================================================
//$<Function>: of_app_audit
//$<Arguments>:
// 	value    long    al_appt_stat_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 11.19.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//this function used for adding checklist data for App customers
n_ds ldw_app_audit_facility
n_ds lds_last_app_audit_seq_no
n_ds ldw_rqrd_data
n_ds ldw_audit
Integer li_row_cnt
Integer i
Long ll_seq_no
Long ll_seq_row_cnt
Long ll_record_id
Long ll_app_audit_id
Integer li_facility_row_cnt
String ls_version

//check to see if security is installed, if it is not then give access to new view

//al_appt_stat_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "rec_id" )

ldw_audit = CREATE n_ds
ldw_audit.DataObject = "d_pd_app_audit_rqrd_data"
ldw_audit.of_SetTransObject( SQLCA )

ldw_rqrd_data = CREATE n_ds
//ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data"
ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data_ia"  //Start Code Change ----01.04.2012 #V12 maha - changed data object
ldw_rqrd_data.of_SetTransObject( SQLCA )

li_row_cnt = ldw_rqrd_data.Retrieve( 1, "I" )
//<add> 07/25/2007 by: Andy
ldw_rqrd_data.setsort( "app_audit_id A" )
ldw_rqrd_data.sort()

Long ll_app_audit_id_old = -1
//end of add

lds_last_app_audit_seq_no = CREATE n_ds
lds_last_app_audit_seq_no.DataObject = "d_last_app_audit_seq_no"
lds_last_app_audit_seq_no.of_SetTransObject( SQLCA )

FOR i = 1 TO li_row_cnt
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.InsertRow( 0 )
	*/
	integer li_auto_generate,li_row	

	li_auto_generate = ldw_rqrd_data.getitemnumber(i,'auto_generate')
	if li_auto_generate = 1 then
		continue
	end if
	li_row = ldw_audit.InsertRow( 0 )
	//---------------------------- APPEON END ----------------------------
	ll_record_id = gnv_app.of_get_id("RECORD_ID")
	ll_app_audit_id = ldw_rqrd_data.GetItemNumber( i, "app_audit_id" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.18.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.SetItem( i, "rec_id", ll_record_id )
	ldw_audit.SetItem( i, "appt_stat_id", al_appt_stat_id )
	ldw_audit.SetItem( i, "prac_id", il_prac_id )
	ldw_audit.SetItem( i, "facility_id", 1 )
	ldw_audit.SetItem( i, "app_audit_id", ll_app_audit_id )
	*/
	ldw_audit.SetItem( li_row, "rec_id", ll_record_id )
	ldw_audit.SetItem( li_row, "appt_stat_id", al_appt_stat_id )
	ldw_audit.SetItem( li_row, "prac_id", il_prac_id )
	ldw_audit.SetItem( li_row, "facility_id", 1 )
	ldw_audit.SetItem( li_row, "app_audit_id", ll_app_audit_id )
	
	//---------------------------- APPEON END ----------------------------
	
	//<add> 07/25/2007 by: Andy
	if ll_app_audit_id_old = ll_app_audit_id then
		ll_seq_no ++
	else
	//end of add
		//find out the last seq no used
		ll_seq_row_cnt = lds_last_app_audit_seq_no.Retrieve( ll_app_audit_id, il_prac_id, 1 )	
		IF ll_seq_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		//<add> 07/25/2007 by: Andy
		ll_app_audit_id_old = ll_app_audit_id
	end if
	//end of add
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.SetItem( i, "seq_no", ll_seq_no	) 		
	ldw_audit.SetItem( i, "active_status", 1 )
	ldw_audit.SetItem( i, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	ldw_audit.SetItem( i, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 	
	*/
	ldw_audit.SetItem( li_row, "seq_no", ll_seq_no	) 		
	ldw_audit.SetItem( li_row, "active_status", 1 )
	ldw_audit.SetItem( li_row, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	ldw_audit.SetItem( li_row, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 		

	ldw_audit.SetItem( li_row, "app_type", ldw_rqrd_data.GetItemString( i, "app_type" )	)		
	//---------------------------- APPEON END ----------------------------
END FOR

IF ldw_audit.Update() = -1 THEN
	messagebox("", sqlca.sqlerrtext)
	MessageBox( "Update Error" , "Error updating application audit data.")
	Return -1
END IF

DESTROY ldw_audit
DESTROY ldw_rqrd_data
DESTROY ldw_app_audit_facility
DESTROY lds_last_app_audit_seq_no


RETURN 0

end function

public function string of_convert_string (string as_string);//====================================================================
//$<Function>: of_convert_string
//$<Arguments>:
// 	value    string    as_string
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) long.zhang 02.28.2014 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_return

if isNull(as_string) then
	ls_return = ''
else
	ls_return = trim(as_string)
end if

return ls_return

end function

public function integer of_setparentwindow (w_recruitment_data_tabs aw_recruit);//====================================================================
//$<Function>: of_setparentwindow
//$<Arguments>:
// 	value    w_recruitment_data    aw_recruit
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if not isValid(aw_recruit) then return -1

iw_recruit = aw_recruit

return 1
end function

public function integer of_convert_otherdata (); //Start Code Change ----06.03.2015 #V15 maha - added for conversion of additional data fields added for V15
//alter table recruit_prac add primary_license_number varchar(30) null;
//alter table recruit_prac add license_state numeric(10,0) null;
//alter table recruit_prac add license_effective datetime null;
//alter table recruit_prac add dea_number varchar(30) null;
//alter table recruit_prac add language1 numeric(10,0) null;
//alter table recruit_prac add language2 numeric(10,0) null;
//alter table recruit_prac add language3 numeric(10,0) null;

String ls_fields[]
//license
 ls_fields[] = {'license_number','state','issue_date'} //also active_status

if of_dyncreate_dw(ids_screen[4],'pd_license',ls_fields[]) = -1 then return -1
of_set_screenvalue(4,ls_fields[])

//DEA
ls_fields[] = {'license_number'}   //also state and active_status

if of_dyncreate_dw(ids_screen[5],'pd_dea_state_csr',ls_fields[]) = -1 then return -1
of_set_screenvalue(5,ls_fields[])

//languages
ls_fields[] = {'foreign_language'}

if of_dyncreate_dw(ids_screen[6],'pd_languages',ls_fields[]) = -1 then return -1
of_set_screenvalue(25,ls_fields[])

return 1
end function

public function integer of_convert_image (integer ai_screen, long al_prac_id, long al_rec_id);//====================================================================
//$<Function>: of_convert_image
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.04.2015 (V15.1-Additional TDL type of Recruitment Task)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_image_type
integer li_cnt, li_doc_row
integer READ_ONE_LENGTH = 8000
integer li_ret
long     ll_doc_rec
long     ll_blob_len
long     ll_Count, ll_Cycle, ll_Start
string   ls_image_type_desc
string   ls_filename
string   ls_return
string   ls_ext, ls_doc_name, ls_tif_name
datetime ldt_date
blob     lb_doc_file
blob     lb_Temp
blob     lb_tif_file
str_import_cur lstr_message

ids_image_type.setfilter("link_to_screen = "+string(ai_screen))
ids_image_type.filter()

for li_cnt = 1 to ids_image_type.rowcount()
	li_image_type = ids_image_type.getitemnumber(li_cnt, "image_type_id")
	ls_image_type_desc = ids_image_type.getitemstring(li_cnt, "image_type_description")	
	
	idw_document.setfilter("image_type = " + string(li_image_type))
	idw_document.filter()
	
	ll_doc_rec = 0
	if idw_document.rowcount() > 1 then
		lstr_message.s_name = ls_image_type_desc
		lstr_message.dw_rep = idw_document
		openwithparm(w_recru_doc_select, lstr_message)
		ls_return = message.stringparm
		if isnull(ls_return) or ls_return ="" or ls_return = '0' then return -1
		ll_doc_rec = long(left(ls_return, pos(ls_return, "$$") - 1))
		ls_filename = mid(ls_return, pos(ls_return, "$$") + 2)
	elseif  idw_document.rowcount() = 1 then
		ll_doc_rec = idw_document.getitemnumber(1, "rec_id")
		ls_filename =  idw_document.getitemstring(1, "file_name")	
	end if
	if ll_doc_rec > 0 then
		ldt_date = datetime(today(),now())
		gnv_appeondb.of_startqueue( )
		//Modified by (APPEON) Harry 12.07.2017 (V161 Storage of Documents as PDFs) add image_ext
		insert into pd_images(prac_id, seq_no, rec_id, screen_id, active_status, image_type_id, facility_id, user_name, date_recieved, tif_start_page, file_name,image_ext)
		values(:al_prac_id, 1, :al_rec_id, :ai_screen, 1, :li_image_type, 1, :gs_user_id, :ldt_date, 1, :ls_filename, 'TIF' );
 		
		SELECT Datalength(image_field), file_name into :ll_blob_len, :ls_doc_name from recruit_image where rec_id = :ll_doc_rec;
		
		if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_blob_len > READ_ONE_LENGTH then
			ll_Count = Ceiling(ll_blob_len/READ_ONE_LENGTH)
			
			for ll_Cycle = 1 To ll_Count
				ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
				SELECTBLOB SubString(image_field,:ll_Start,:READ_ONE_LENGTH)
						INTO :lb_Temp
						FROM recruit_image where rec_id = :ll_doc_rec;
				
				lb_doc_file += lb_Temp
			next
		else
			selectblob image_field into :lb_doc_file from recruit_image where rec_id = :ll_doc_rec;
		end if
		gnv_appeondb.of_commitqueue( )	
		
		//---------Begin Added by (Appeon)Stephen 02.13.2017 for Bug # 5494 - Minor issues with Recruitment: Previewing uploaded documents and Word documents--------
		ls_ext = MidA(ls_doc_name, LastPos(ls_doc_name, ".") + 1)
		IF upper(ls_ext) <> 'TIF' THEN
			li_ret = of_covert_doc2tif(ls_doc_name, lb_doc_file, ls_tif_name, lb_tif_file)
			if li_ret = 1 then
				lb_doc_file = lb_tif_file
			else
				return -1
			end if
		END IF
		//---------End Added ------------------------------------------------------
		updateblob pd_images set image_data = :lb_doc_file where prac_id = :al_prac_id and rec_id = :al_rec_id and seq_no = 1 and screen_id = :ai_screen;		
	end if
next

return 1
end function

public function integer of_covert_doc2tif (string as_doc_file, blob ab_doc, ref string as_tif_file, ref blob ab_tif);//====================================================================
//$<Function>: of_covert_doc2tif
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 02.13.2017 (Bug # 5494 - Minor issues with Recruitment: Previewing uploaded documents and Word documents)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_filenum
integer li_counter, li_loops
long     ll_new_pos, ll_bytes_written
long     ll_filelen
string	  ls_doc[], ls_tif[]
blob     blob_temp
blob     blob_tif
pfc_cst_nv_image_functions lnv_image_func

as_doc_file = gs_temp_path + as_doc_file

FileDelete( as_doc_file )

li_filenum =  FileOpen( as_doc_file, StreamMode!, Write!, LockWrite!, Replace!)
ll_new_pos = 1

ll_filelen = LenA( ab_doc )

IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( ab_doc, ll_new_pos, 32765 )
   	 	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
		 IF ll_bytes_written = -1 THEN
			Return -1
		 END IF	
		 ll_new_pos = ll_new_pos + ll_bytes_written 
	NEXT 
	FileClose( li_filenum )
ELSE
	MessageBox( "File Open Error", "Could not open the '" + as_doc_file + "' for StreamMode!" ) 
	Return -	1
END IF

ls_doc[1] = as_doc_file
open(w_letter_combine)
w_letter_combine.hide()
w_letter_combine.of_get_wordbuild()
if w_letter_combine.of_convert_tif(ls_doc[], ls_tif[]) = -1 then
	close(w_letter_combine)
	return -1
end if
as_tif_file = ls_tif[1]
lnv_image_func = create pfc_cst_nv_image_functions
ab_tif = lnv_image_func.of_read_image_file( as_tif_file )

close(w_letter_combine)
destroy lnv_image_func;
return 1
end function

on n_cst_recruitmnet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_recruitmnet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i

For i = 1 to UpperBound(ids_screen[])
		ids_screen[i] = create n_ds
		ids_screen[i].dataobject = ''
end for

ids_fields_all = create n_ds
ids_fields_all.dataobject = 'd_screen_fields_appeon'
ids_fields_all.settransobject( sqlca)
end event

event destructor;//====================================================================
//$<Event>: destructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i

For i = 1 to UpperBound(ids_screen[])
		destroy ids_screen[i]
end for

destroy ids_fields_all
end event

