$PBExportHeader$nv_entity_functions.sru
forward
global type nv_entity_functions from nonvisualobject
end type
end forward

global type nv_entity_functions from nonvisualobject
end type
global nv_entity_functions nv_entity_functions

type variables
long il_state_code
string is_name
string is_street1
string is_street2
string is_city
string is_state
string is_zip
string is_contact
string is_contact_title
string is_fax
string is_phone
string is_web_address
string is_email_address
string is_taxid

n_ds lds_entity
n_ds lds_facility
n_ds lds_group
n_ds lds_location
n_ds lds_lookup
n_ds lds_org
n_ds lds_prac
end variables

forward prototypes
public function integer of_update_entity_links (datawindow adw_from, string as_from, long al_id)
public function integer of_set_entity ()
public function integer of_set_facility ()
public function integer of_add_user_facility (long al_facil, integer ai_setting)
public function integer of_delete_facility (long al_facil)
public function integer of_set_group ()
public function integer of_set_location ()
public function integer of_set_address ()
public function integer of_set_values (datawindow adw_from, string as_from, integer ai_row)
end prototypes

public function integer of_update_entity_links (datawindow adw_from, string as_from, long al_id);//Start Code Change ----07.16.2010 #V10 maha - created for entity functionality
datetime ldt_now

integer i
integer c
integer w
integer res
integer li_row = 1  //maha 11.28.2016
long ll_ids[]

string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_sql =  "select * from entity_lookup where "


ls_presentation_str = "style(type=grid)"

if as_from = "G" then
	ls_sql+= "group_id = " + string(al_id) + ";"
elseif as_from = "F" then
	ls_sql+= "facility_id = " + string(al_id) + ";"
elseif as_from = "L" then
	ls_sql+= "loc_id = " + string(al_id) + ";"
elseif as_from = "AL" then
	ls_sql+= "lookup_id = " + string(al_id) + ";"
elseif as_from = "O" then
	ls_sql+= "org_id = " + string(al_id) + ";"
elseif as_from = "P" then
	ls_sql+= "prac_id = " + string(al_id) + ";"
elseif as_from = "A" then
	ls_sql+= "addr_id = " + string(al_id) + ";"	
elseif as_from = "E" then
	ls_sql+= "entity_id = " + string(al_id) + ";"	
end if	


ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
IF Len(ERRORS) > 0 THEN
	MessageBox("Caution on export field " + ls_sql, &
	"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
//	MessageBox("ls_select_table",ls_select_table)
	RETURN -1
END IF
lds_entity = CREATE n_ds
w = lds_entity.Create( ls_dwsyntax_str, ERRORS)
if w < 1 then
	messagebox("Error on create in of_update_entity_links",errors)
end if
lds_entity.settransobject(sqlca)
w = lds_entity.retrieve()
if w < 1 then
	messagebox("of_update_entity_links","Failure to retrieve entity data: " + ls_sql )
	return -1
end if
	
for i = 1 to 7  //get the list of connections
	choose case i
		case 1 //facility
			ll_ids[i] =  lds_entity.getitemnumber(1,"facility_id")
		case 2  //group
			ll_ids[i] =  lds_entity.getitemnumber(1,"group_id")
		case 3 //location
			ll_ids[i] =  lds_entity.getitemnumber(1,"loc_id")
		case 4 //address lookup
			ll_ids[i] =  lds_entity.getitemnumber(1,"lookup_id")
		case 5  //organization (Appl)
			ll_ids[i] =  lds_entity.getitemnumber(1,"org_id")
		case 6 //provider
			ll_ids[i] =  lds_entity.getitemnumber(1,"prac_id")
			ll_ids[8] =  lds_entity.getitemnumber(1,"addr_id")
		case 7  //entity
			ll_ids[i] =  lds_entity.getitemnumber(1,"entity_id")
	end choose	
next

debugbreak()
//Start Code Change ----11.28.2016 #V153 maha
if as_from = "A" then
	li_row = adw_from.find("rec_id = " + string(lds_entity.getitemnumber(1,"addr_id")), 1, adw_from.rowcount())
	if li_row < 1 then
		messagebox("of_update_entity_links", "Failure of Address record find")
	end if
end if
//End Code Change ----11.28.2016	

//set the update values
of_set_values(  adw_from, as_from, li_row )

//update the entity	record
if as_from <> "E" then
	lds_entity = CREATE n_ds
	lds_entity.dataobject = "d_entity_lookup_detail"
	lds_entity.settransobject(sqlca)
	lds_entity.retrieve(ll_ids[7])
	of_set_entity( )

	lds_entity.update()
end if


//update the facility
if ll_ids[1] > 0 and not isnull(ll_ids[1]) and as_from <> "F" then
	lds_facility = CREATE n_ds
	lds_facility.dataobject = "d_facility_setup"
	lds_facility.settransobject(sqlca)
	lds_facility.retrieve(ll_ids[1])
	of_set_facility()
	
	lds_facility.update()
end if

//functionality for updating the group
if ll_ids[2] > 0 and not isnull(ll_ids[2]) and as_from <> "G" then
	lds_group = CREATE n_ds
	lds_group.dataobject = "d_multi_group_detail"
	lds_group.settransobject(sqlca)
	lds_group.retrieve(ll_ids[2])
	of_set_group()
	
	lds_group.update()
end if

//functionality for updating the location
if ll_ids[3] > 0 and not isnull(ll_ids[3]) and as_from <> "L" then
	lds_location = CREATE n_ds
	lds_location.dataobject = "d_group_data_entry"
	lds_location.settransobject(sqlca)
	lds_location.retrieve(ll_ids[3])
	of_set_location()
	
	lds_location.update()
end if

////functionality for updating the lookup
//if ll_ids[4] > 0 and not isnull(ll_ids[4]) and as_from <> "AL" then
//	lds_lookup = CREATE n_ds
//	lds_lookup.dataobject = "d_"
//	lds_lookup.settransobject(sqlca)
//	lds_lookup.retrieve(ll_ids[4])
//	//of_set_lookup()
//	
//	lds_lookup.update()
//end if
//
////functionality for updating the organization
//if ll_ids[5] > 0 and not isnull(ll_ids[5]) and as_from <> "O" then
//	lds_org = CREATE n_ds
//	lds_org.dataobject = "d_"
//	lds_org.settransobject(sqlca)
//	lds_org.retrieve(ll_ids[5])
//	//of_set_organization()
//	
//	lds_org.update()
//end if
debugbreak()
//functionality for updating the prac
if ll_ids[6] > 0 and not isnull(ll_ids[6]) and as_from <> "A" then
	lds_prac = CREATE n_ds
	lds_prac.dataobject = "d_address_entity_update"
	lds_prac.settransobject(sqlca)
	lds_prac.retrieve(ll_ids[6], ll_ids[8])
	of_set_address()
//	lds_prac.sharedata(w_temp_addr_update.dw_1)
	lds_prac.update()
	update pd_basic set last_name = :is_name where prac_id = :ll_ids[6];
	//need to audit this data
end if

if isvalid( lds_entity) then destroy  lds_entity
if isvalid( lds_facility) then destroy  lds_facility
if isvalid( lds_group) then destroy  lds_group
if isvalid( lds_location) then destroy  lds_location
if isvalid( lds_lookup) then destroy  lds_lookup
if isvalid( lds_org) then destroy  lds_org
if isvalid( lds_prac) then destroy  lds_prac

return 1
end function

public function integer of_set_entity ();//Start Code Change ----11.22.2016 #V153 maha - added skips
datetime ldt_now

if is_name <> "@skip" then lds_entity.setitem(1,"entity_name",is_name )
if is_street1 <> "@skip" then lds_entity.setitem(1,"street1",is_street1 )
if is_street2 <> "@skip" then lds_entity.setitem(1,"street2",is_street2 )
if is_city <> "@skip" then lds_entity.setitem(1,"city",is_city)
if is_state <> "@skip" then lds_entity.setitem(1,"state",is_state)
//lds_entity.setitem(1,"state",adw_from.getitemstring(1,"state"))
if is_zip <> "@skip" then lds_entity.setitem(1,"zip",is_zip)
if is_street2 <> "@skip" then lds_entity.setitem(1,"suite_apart",is_street2)
if is_contact <> "@skip" then lds_entity.setitem(1,"contact_name",is_contact)
if is_phone <> "@skip" then lds_entity.setitem(1,"phone",is_phone)  //Start Code Change ----05.23.2013 #V14 maha corrected from contact title
if is_fax <> "@skip" then lds_entity.setitem(1,"fax",is_fax)
if is_email_address <> "@skip" then lds_entity.setitem(1,"email_address",is_email_address)
if is_web_address <> "@skip" then lds_entity.setitem(1,"web_address",is_web_address)
if is_taxid <> "@skip" then lds_entity.setitem(1,"tax_id",is_taxid) //Start Code Change ----04.21.2014 #V14.2 maha

ldt_now = datetime(today(),now())
lds_entity.setitem(1,"mod_date", ldt_now)
lds_entity.setitem(1,"mod_user", gs_user_id )

return 1
end function

public function integer of_set_facility ();//Start Code Change ----11.22.2016 #V153 maha - added skips
if is_name <> "@skip" then lds_facility.setitem(1,"facility_name",is_name)
if is_street1 <> "@skip" then lds_facility.setitem(1,"street",is_street1)
if is_street2 <> "@skip" then lds_facility.setitem(1,"street_2",is_street2)
if is_city <> "@skip" then lds_facility.setitem(1,"city",is_city)
if is_state <> "@skip" then lds_facility.setitem(1,"state",is_state)
if is_zip <> "@skip" then lds_facility.setitem(1,"zip",is_zip)
if is_email_address <> "@skip" then lds_facility.setitem(1,"email_address",is_email_address)
if is_web_address <> "@skip" then lds_facility.setitem(1,"web_address",is_web_address)
if is_phone <> "@skip" then lds_facility.setitem(1,"phone",is_phone)
if is_fax <> "@skip" then lds_facility.setitem(1,"fax",is_fax)
if is_contact <> "@skip" then lds_facility.setitem(1,"contact",is_contact)
if is_contact_title <> "@skip" then lds_facility.setitem(1,"credentialing_contact_title",is_contact_title)
	
if is_name <> "@skip" then lds_facility.setitem(1,"return_facility_name",is_name)
if is_street1 <> "@skip" then lds_facility.setitem(1,"return_street",is_street1)
if is_street2 <> "@skip" then lds_facility.setitem(1,"return_street_2",is_street2)
if is_city <> "@skip" then lds_facility.setitem(1,"return_city",is_city)
if is_state <> "@skip" then lds_facility.setitem(1,"return_state",is_state)
if is_zip <> "@skip" then lds_facility.setitem(1,"return_zip",is_zip)

return 1
end function

public function integer of_add_user_facility (long al_facil, integer ai_setting);//Start Code Change ----07.26.2010 #V10 maha - added to add security records for new facility
datastore ldw_users
datastore ldw_sec
long ll_id
integer r
integer rc
integer nr
integer li_set

//Start Code Change ----03.29.2011 #V11 maha - set security dependant on version
if gb_sk_ver then
	li_set = 1
else
	li_set = 0
end if
//Start Code Change ----03.29.2011

if  gb_sk_ver then //Smart
	ldw_users = create datastore
	ldw_users.dataobject = "d_list_of_users"
	ldw_users.settransobject(sqlca)
	ldw_sec = create datastore
	ldw_sec.dataobject = "d_security_user_facility_forpt"
	ldw_sec.settransobject(sqlca)
	
	rc = ldw_users.retrieve()
	
	ll_id = gnv_app.of_get_id( "user_facility_id" ,rc)	- 1
	
	for r = 1 to rc
		ll_id++
		nr = ldw_sec.insertrow(0)
		ldw_sec.setitem(nr,"user_id",ldw_users.getitemstring(r,"user_id"))
		ldw_sec.setitem(nr,"access_rights",li_set)  //Start Code Change ----03.29.2011 #V11 maha 
		ldw_sec.setitem(nr,"facility_id",al_facil)
		ldw_sec.setitem(nr,"user_facility_id",ll_id)
	next
	
	ldw_sec.update()
	
	destroy ldw_users
	destroy ldw_sec
	
else //Cred and App
	openwithparm(w_set_user_facility_security,al_facil)
end if

return 1
end function

public function integer of_delete_facility (long al_facil);//Start Code Change ----07.26.2010 #V10 maha - delete facility when deleting group in SK
		
Delete from facility_ver_rules where facility_id = :al_facil;
//Delete from security_users_facility where facility_id = :al_facil;
Delete from security_user_facilities where facility_id = :al_facil; //alfee 11.19.2010
Delete from committee_lookup where facility_id = :al_facil;
Delete from facility_ver_rules where facility_id = :al_facil;
Delete from entity_lookup where facility_id = :al_facil;
Delete from facility where facility_id = :al_facil;

commit using sqlca;

return 1
end function

public function integer of_set_group ();//Start Code Change ----11.22.2016 #V153 maha - added skips
//Start Code Change ----04.21.2014 #V14.2 maha - added function
if is_name <> "@skip" then lds_group.setitem(1,"gp_name", is_name)
if is_street1 <> "@skip" then lds_group.setitem(1,"street1",is_street1 ) 
if is_street2 <> "@skip" then lds_group.setitem(1,"street2",is_street2)
if is_city <> "@skip" then lds_group.setitem(1,"city",is_city )
if is_state <> "@skip" then lds_group.setitem(1,"state",is_state )
//lds_group.setitem(1,"",il_state_code)
if is_zip <> "@skip" then lds_group.setitem(1,"zip",is_zip )
if is_contact <> "@skip" then lds_group.setitem(1,"contact_name",is_contact)
if is_contact_title <> "@skip" then lds_group.setitem(1,"contact_title",is_contact_title )
if is_fax <> "@skip" then lds_group.setitem(1,"fax",is_fax )
if is_email_address <> "@skip" then lds_group.setitem(1,"email_address",is_email_address)
if is_web_address <> "@skip" then lds_group.setitem(1,"web_address",is_web_address)
if is_phone <> "@skip" then lds_group.setitem(1,"phone",is_phone )
if is_taxid <> "@skip" then 	lds_group.setitem(1,"info1",is_taxid)


return 1
end function

public function integer of_set_location ();//Start Code Change ----11.22.2016 #V153 maha - added

if is_name <> "@skip" then lds_location.setitem(1,"street", is_name)
if is_street1 <> "@skip" then lds_location.setitem(1,"street_2",is_street1 ) 
if is_street2 <> "@skip" then lds_location.setitem(1,"suite_apart",is_street2)
if is_city <> "@skip" then lds_location.setitem(1,"city",is_city )
//if is_state <> "@skip" then lds_location.setitem(1,"state",is_state )
if il_state_code > 0 then lds_location.setitem(1,"state", il_state_code)
if is_zip <> "@skip" then lds_location.setitem(1,"zip", is_zip )
if is_contact <> "@skip" then lds_location.setitem(1,"contact_person", is_contact)
//if is_contact_title <> "@skip" then lds_location.setitem(1,"contact_title",is_contact_title )
if is_fax <> "@skip" then lds_location.setitem(1,"fax",is_fax )
if is_email_address <> "@skip" then lds_location.setitem(1,"e_mail_address",is_email_address)
if is_web_address <> "@skip" then lds_location.setitem(1,"web_address",is_web_address)
if is_phone <> "@skip" then lds_location.setitem(1,"phone",is_phone )
if is_taxid <> "@skip" then 	lds_location.setitem(1,"tax_id",is_taxid)

return 1
end function

public function integer of_set_address ();//Start Code Change ----11.22.2016 #V153 maha - added
debugbreak()
if is_name <> "@skip" then 
	lds_prac.setitem(1,"street", is_name)
end if
if is_street1 <> "@skip" then lds_prac.setitem(1,"street_2",is_street1 ) 
if is_street2 <> "@skip" then lds_prac.setitem(1,"suite_apart",is_street2)
if is_city <> "@skip" then lds_prac.setitem(1,"city",is_city )
//if is_state <> "@skip" then lds_prac.setitem(1,"state",is_state )
if il_state_code > 0 then lds_prac.setitem(1,"state", il_state_code)
if is_zip <> "@skip" then lds_prac.setitem(1,"zip", is_zip )
if is_contact <> "@skip" then lds_prac.setitem(1,"contact_person", is_contact)
//if is_contact_title <> "@skip" then lds_prac.setitem(1,"contact_title",is_contact_title )
if is_fax <> "@skip" then lds_prac.setitem(1,"fax",is_fax )
if is_email_address <> "@skip" then lds_prac.setitem(1,"e_mail_address",is_email_address)
if is_web_address <> "@skip" then lds_prac.setitem(1,"web_address",is_web_address)
if is_phone <> "@skip" then lds_prac.setitem(1,"phone",is_phone )
if is_taxid <> "@skip" then 	lds_prac.setitem(1,"tax_id",is_taxid)

return 1
end function

public function integer of_set_values (datawindow adw_from, string as_from, integer ai_row);choose case as_from
		case "G"
			is_name =  adw_from.getitemstring(ai_row,"gp_name")
			is_street1 = adw_from.getitemstring(ai_row,"street1")
			is_street2 = adw_from.getitemstring(ai_row,"street2")
			is_city = adw_from.getitemstring(ai_row,"city")
			is_state = adw_from.getitemstring(ai_row,"state")
			il_state_code = long(gnv_data.of_getitem( "code_lookup", "lookup_code","code = '" + is_state + "'" ))
			is_zip = adw_from.getitemstring(ai_row,"zip")
			is_contact = adw_from.getitemstring(ai_row, "contact_name")
			is_contact_title = adw_from.getitemstring(ai_row,"contact_title")
			is_fax = adw_from.getitemstring(ai_row,"fax")
			is_email_address = adw_from.getitemstring(ai_row,"email_address")
			is_web_address = adw_from.getitemstring(ai_row,"web_address")
			is_phone = adw_from.getitemstring(ai_row,"phone")
			is_taxid = adw_from.getitemstring(ai_row,"info1")
		case "F"  //Start Code Change ----04.21.2014 #V14.2 maha
			is_name =  adw_from.getitemstring(ai_row,"facility_name")
			is_street1 = adw_from.getitemstring(ai_row,"street")
			is_street2 = adw_from.getitemstring(ai_row,"street_2")
			is_city = adw_from.getitemstring(ai_row,"city")
			is_state = adw_from.getitemstring(ai_row,"state")
			il_state_code = long(gnv_data.of_getitem( "code_lookup", "lookup_code","code = '" + is_state + "'" ))
			is_zip = adw_from.getitemstring(ai_row,"zip")
			is_contact = adw_from.getitemstring(ai_row, "contact")
			is_contact_title = '@skip'
			is_fax = adw_from.getitemstring(ai_row,"fax")
			is_email_address = adw_from.getitemstring(ai_row,"email_address")
			is_web_address = adw_from.getitemstring(ai_row,"web_address")
			is_phone = adw_from.getitemstring(ai_row,"phone")
			is_taxid ="@skip"
			 //End Code Change ----04.21.2014
	//Start Code Change ----11.22.2016 #V153 maha	
		case "L"
			is_name =  adw_from.getitemstring(ai_row,"street")
			is_street1 = adw_from.getitemstring(ai_row,"street_2")
			is_street2 = adw_from.getitemstring(ai_row,"suite_apart")
			is_city = adw_from.getitemstring(ai_row,"city")
			il_state_code = adw_from.getitemnumber(ai_row,"state")	
			is_state = (gnv_data.of_getitem( "code_lookup", "code","lookup_code = " + string(il_state_code )))
			is_zip = adw_from.getitemstring(ai_row,"zip")
			is_contact = adw_from.getitemstring(ai_row, "contact_person")
			is_contact_title = "@skip"
			is_fax = adw_from.getitemstring(ai_row,"fax")
			is_email_address = adw_from.getitemstring(ai_row,"e_mail_address")
			is_web_address = adw_from.getitemstring(ai_row,"web_address")
			is_phone = adw_from.getitemstring(ai_row,"phone")
			is_taxid = adw_from.getitemstring(ai_row,"tax_id")
		case "A"
			is_name =  adw_from.getitemstring(ai_row,"street")
			is_street1 = adw_from.getitemstring(ai_row,"street_2")
			is_street2 = adw_from.getitemstring(ai_row,"suite_apart")
			is_city = adw_from.getitemstring(ai_row,"city")
			il_state_code = adw_from.getitemnumber(ai_row,"state")	
			is_state = (gnv_data.of_getitem( "code_lookup", "code","lookup_code = " + string(il_state_code )))
			is_zip = adw_from.getitemstring(ai_row,"zip")
			is_contact = adw_from.getitemstring(ai_row, "contact_person")
			is_contact_title = "@skip"
			is_fax = adw_from.getitemstring(ai_row,"fax")
			is_email_address = adw_from.getitemstring(ai_row,"e_mail_address")
			is_web_address = adw_from.getitemstring(ai_row,"web_address")
			is_phone = adw_from.getitemstring(ai_row,"phone")
			is_taxid = adw_from.getitemstring(ai_row,"tax_id")	
		case "P"
			is_name =  adw_from.getitemstring(ai_row,"last_name")
			is_street1 =  "@skip"
			is_street2 =  "@skip"
			is_city =  "@skip"
			il_state_code =  0	
			is_state =  "@skip"
			is_zip =  "@skip"
			is_contact =  "@skip"
			is_contact_title = "@skip"
			is_fax = "@skip"
			is_email_address = "@skip"
			is_web_address = "@skip"
			is_phone = "@skip"
			is_taxid = "@skip"
	//End Code Change ----11.22.2016		
end choose

return 1
end function

on nv_entity_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_entity_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

