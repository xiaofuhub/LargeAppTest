$PBExportHeader$n_cst_update_contact.sru
forward
global type n_cst_update_contact from nonvisualobject
end type
end forward

global type n_cst_update_contact from nonvisualobject
end type
global n_cst_update_contact n_cst_update_contact

forward prototypes
public function long of_equal (string as_string1, string as_string2)
public function long of_update_contact ()
end prototypes

public function long of_equal (string as_string1, string as_string2);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_equal()
// $<arguments>
//		value	string	as_string1		
//		value	string	as_string2		
// $<returns> long
// $<description> come from n_cst_contract_sql.of_equal()
//////////////////////////////////////////////////////////////////////

string ls_string1,ls_string2
ls_string1 = trim(as_string1)
ls_string2 = trim(as_string2)
If RightA(ls_string1,1) = '.' Then ls_string1 = LeftA(ls_string1,LenA(ls_string1) - 1)
If RightA(ls_string2,1) = '.' Then ls_string2 = LeftA(ls_string2,LenA(ls_string2) - 1)
If upper(ls_string1) = upper(ls_string2) Then
	Return 1
Else
	Return 0
End If

Return 1

end function

public function long of_update_contact ();//////////////////////////////////////////////////////////////////////
// $<function>    of_update_contact()
// $<arguments>   (None)
// $<returns>     long
// $<description> come from n_cst_contract_sql.of_appeon4_changes()
//////////////////////////////////////////////////////////////////////

string 	ls_LogContent
long 		li_num,ll_i,ll_j,ll_contacts_rowcount,ll_contacts_numbers_rowcount,ll_EqualCount,li_MaxComid,ll_NeedProCount
long 		ll_contact_id,ll_facility_id,ll_company_id,ll_Phone,ll_Email,ll_find,ll_row,ll_FileNo,ll_OurCompanyID
string 	ls_contact_type2,ls_street_1,ls_street_2,ls_street_3,ls_city,ls_code,ls_zip,ls_ContactType,ls_find
string 	ls_company_contact_type2,ls_facility_name,ls_company_street_1,ls_company_street_2,ls_company_street_3,ls_company_city,ls_company_state,ls_company_zip
string 	ls_Phone,ls_Email,ls_Error
n_cst_datastore lds_contact
n_cst_datastore lds_company
n_cst_datastore lds_contacts_numbers
Constant String ls_DefName = 'NONE'
//Add by Jack 30.09.2007
Select count(*) into :ll_NeedProCount from ctx_contacts where facility_id is null;
If ll_NeedProCount <= 0 Then Return 0
select max(facility_id) into :li_MaxComid from app_facility;
if IsNull(li_MaxComid) then li_MaxComid = 0
//End add

lds_contact = Create n_cst_datastore
lds_company = Create n_cst_datastore
lds_contacts_numbers = Create n_cst_datastore
lds_contact.dataobject = 'd_contacts_update'
lds_company.dataobject = 'd_company_update'
lds_contacts_numbers.dataobject = 'd_ctx_contacts_numbers_search'
lds_contact.settransobject(sqlca)
lds_company.settransobject(sqlca)
lds_contacts_numbers.settransobject(sqlca)
lds_contact.retrieve()
lds_company.retrieve()
lds_contacts_numbers.retrieve()

ls_LogContent = ""

ll_contacts_rowcount = lds_contact.rowcount()
if ll_contacts_rowcount <= 0 then return 0

ll_contacts_numbers_rowcount = lds_contacts_numbers.rowcount()

li_num = ll_contacts_rowcount
if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'Update Contact and Company'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Update Contact and Company, Please stand by!'
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_num)

For ll_i = 1 To ll_contacts_rowcount
	if isvalid(w_infodisp) then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Modification ' + string(ll_i) + ' of ' + string(li_num) +' Please stand by!'
	end if
	ll_contact_id = lds_contact.getitemnumber(ll_i,'contact_id')
	ls_contact_type2 = lds_contact.getitemstring(ll_i,'contact_type2')
	ls_street_1 = Trim(lds_contact.getitemstring(ll_i,'street_1'))
	ls_street_2 = lds_contact.getitemstring(ll_i,'street_2')
	ls_street_3 = lds_contact.getitemstring(ll_i,'street_3')
	ls_city = lds_contact.getitemstring(ll_i,'city')
	ls_code = lds_contact.getitemstring(ll_i,'code')
	ls_zip = lds_contact.getitemstring(ll_i,'zip')
	
	if IsNull(ls_contact_type2) then ls_contact_type2 = ''
	if IsNull(ls_street_1) then ls_street_1 = ''
	if IsNull(ls_street_2) then ls_street_2 = ''
	if IsNull(ls_street_3) then ls_street_3 = ''
	if IsNull(ls_city) then ls_city = ''
	if IsNull(ls_code) then ls_code = ''
	if IsNull(ls_zip) then ls_zip = ''
	ll_EqualCount = 0
	ll_j = 1
	For ll_j = 1 To lds_company.rowcount()
		ll_facility_id = lds_company.getitemnumber(ll_j,'facility_id')
		ls_company_contact_type2 = lds_company.getitemstring(ll_j,'contact_type2')
		ls_facility_name = Trim(lds_company.getitemstring(ll_j,'facility_name'))
		ls_company_street_1 = Trim(lds_company.getitemstring(ll_j,'street'))
		ls_company_street_2 = lds_company.getitemstring(ll_j,'street_2')
		ls_company_street_3 = lds_company.getitemstring(ll_j,'street_3')
		ls_company_city = lds_company.getitemstring(ll_j,'city')
		ls_company_state = lds_company.getitemstring(ll_j,'state')
		ls_company_zip = lds_company.getitemstring(ll_j,'zip')

		if IsNull(ls_company_contact_type2) then ls_company_contact_type2 = ''
		if IsNull(ls_facility_name) then ls_facility_name = ''
		if IsNull(ls_company_street_1) then ls_company_street_1 = ''
		if IsNull(ls_company_street_2) then ls_company_street_2 = ''
		if IsNull(ls_company_street_3) then ls_company_street_3 = ''
		if IsNull(ls_company_city) then ls_company_city = ''
		if IsNull(ls_company_state) then ls_company_state = ''
		if IsNull(ls_company_zip) then ls_company_zip = ''
		
		if ((of_equal(ls_street_1,ls_company_street_1) = 1) or (ls_facility_name = ls_DefName and ls_street_1 = '')) and of_equal(ls_city,ls_company_city) = 1 then	
			ll_EqualCount++
			if ll_EqualCount = 1 then
				ll_company_id = ll_facility_id
				ls_ContactType = ls_company_contact_type2
			end if
		end if
	Next
	
	If ll_EqualCount = 0 Then
		ls_find = "contact_id = " + string(ll_contact_id) + " and not isnull(phone)"
		ll_find = lds_contacts_numbers.find(ls_find,1,ll_contacts_numbers_rowcount)
		ls_Phone = ''
		If ll_find > 0 Then
			ls_Phone = lds_contacts_numbers.getitemstring(ll_find,'phone')
		End If
		
		ls_find = "contact_id = " + string(ll_contact_id) + " and not isnull(contact_email)"
		ll_find = lds_contacts_numbers.find(ls_find,1,ll_contacts_numbers_rowcount)
		ls_Email = ''
		If ll_find > 0 Then
			ls_Email = lds_contacts_numbers.getitemstring(ll_find,'contact_email')
		End If
		
		li_MaxComid ++
		ls_code = LeftA(ls_code,2)
		ll_row = lds_company.insertrow(0)

		lds_company.setitem(ll_row,'facility_id',li_MaxComid)
		lds_company.setitem(ll_row,'contact_type2',ls_contact_type2)
		if ls_street_1 = '' then
			lds_company.setitem(ll_row,'facility_name',ls_DefName)
		else
			lds_company.setitem(ll_row,'facility_name',ls_street_1)
		end if
		lds_company.setitem(ll_row,'street',ls_street_1)
		lds_company.setitem(ll_row,'street_2',ls_street_2)
		lds_company.setitem(ll_row,'street_3',ls_street_3)
		lds_company.setitem(ll_row,'city',ls_city)
		lds_company.setitem(ll_row,'state',ls_code)
		lds_company.setitem(ll_row,'zip',ls_zip)
		lds_company.setitem(ll_row,'phone',ls_Phone)
		lds_company.setitem(ll_row,'email_address',ls_Email)
		
		lds_contact.setitem(ll_i,'facility_id',li_MaxComid)
	Else
		lds_contact.setitem(ll_i,'facility_id',ll_company_id)
		If IsNull(ls_ContactType) Or ls_ContactType = '' Then
			ls_find = "facility_id = " + string(ll_company_id)
			ll_find = lds_company.find(ls_find,1,lds_company.rowcount())
			If ll_find > 0 Then
				lds_company.setitem(ll_find,'contact_type2',ls_contact_type2)			
			End If
		ElseIf ls_ContactType <> ls_contact_type2 Then
			ls_LogContent += '['+string(today())+' '+string(now())+'] '+'The record that contact_id = '+string(ll_contact_id)+' in the ctx_contacts table map to the facility_id = ' + String(ll_company_id) + ' record in the app_facility table and have different contact_type2.~r~n'
		End If
		If ll_EqualCount > 1 Then
			ls_LogContent += '['+string(today())+' '+string(now())+'] '+'More than one record in the app_facility table map to the contact_id = ' + String(ll_contact_id) + ' record in the ctx_contacts table.~r~n'
		end if
	End if
Next

lds_company.update()
lds_contact.update()

if ls_LogContent <> "" then
	//--------Begin Modified by Alfee 01.30.2008-----------------------------
	ls_Error = "n_cst_update_contact.of_update_contact() Information: " + ls_LogContent	
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE
	END IF	
	/*
	//modify 09/18/2007 by: Andy	
	ls_Error = '~r~n' + "==================================================="
	ls_Error+= "~r~nWarning:n_cst_update_contact.of_update_contact()~r~nInformation: " + ls_LogContent	
	filewrite(gl_logfilehandle,ls_Error)
	//gb_Flag = true 	
	*/
	//--------End Modified ---------------------------------------------------
end if

Destroy lds_company
Destroy lds_contact
Destroy lds_contacts_numbers

//If isvalid(w_infodisp) Then Close(w_infodisp)

Return 0
end function

on n_cst_update_contact.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_contact.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

