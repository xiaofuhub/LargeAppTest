$PBExportHeader$uo_caqh_import.sru
forward
global type uo_caqh_import from userobject
end type
type cb_lookups from commandbutton within uo_caqh_import
end type
type cb_close from commandbutton within uo_caqh_import
end type
type rb_add from radiobutton within uo_caqh_import
end type
type cb_clear from commandbutton within uo_caqh_import
end type
type cb_next from commandbutton within uo_caqh_import
end type
type rb_add_one from radiobutton within uo_caqh_import
end type
type rb_data from radiobutton within uo_caqh_import
end type
type rb_caqh from radiobutton within uo_caqh_import
end type
type st_c from statictext within uo_caqh_import
end type
type st_d from statictext within uo_caqh_import
end type
type st_b from statictext within uo_caqh_import
end type
type st_a from statictext within uo_caqh_import
end type
type cb_rescan from commandbutton within uo_caqh_import
end type
type rb_rescan from radiobutton within uo_caqh_import
end type
type rb_scant from radiobutton within uo_caqh_import
end type
type rb_any from radiobutton within uo_caqh_import
end type
type rb_all from radiobutton within uo_caqh_import
end type
type st_tcnt from statictext within uo_caqh_import
end type
type st_3 from statictext within uo_caqh_import
end type
type st_tname from statictext within uo_caqh_import
end type
type rb_blank from radiobutton within uo_caqh_import
end type
type rb_addr from radiobutton within uo_caqh_import
end type
type rb_code from radiobutton within uo_caqh_import
end type
type cb_1 from commandbutton within uo_caqh_import
end type
type sle_2 from singlelineedit within uo_caqh_import
end type
type cb_remove from commandbutton within uo_caqh_import
end type
type rb_none from radiobutton within uo_caqh_import
end type
type rb_mult from radiobutton within uo_caqh_import
end type
type rb_one from radiobutton within uo_caqh_import
end type
type dw_list from datawindow within uo_caqh_import
end type
type cb_accept from commandbutton within uo_caqh_import
end type
type rb_manual from radiobutton within uo_caqh_import
end type
type rb_scan from radiobutton within uo_caqh_import
end type
type cb_run from commandbutton within uo_caqh_import
end type
type rb_start from radiobutton within uo_caqh_import
end type
type cbx_entity from checkbox within uo_caqh_import
end type
type cbx_zip from checkbox within uo_caqh_import
end type
type cbx_city from checkbox within uo_caqh_import
end type
type cbx_street from checkbox within uo_caqh_import
end type
type sle_1 from singlelineedit within uo_caqh_import
end type
type dw_existing from u_dw within uo_caqh_import
end type
type st_1 from statictext within uo_caqh_import
end type
type rb_mid from radiobutton within uo_caqh_import
end type
type gb_2 from groupbox within uo_caqh_import
end type
type gb_3 from groupbox within uo_caqh_import
end type
type dw_1 from datawindow within uo_caqh_import
end type
type gb_4 from groupbox within uo_caqh_import
end type
type gb_5 from groupbox within uo_caqh_import
end type
type dw_import from u_dw within uo_caqh_import
end type
type gb_8 from groupbox within uo_caqh_import
end type
type st_message from statictext within uo_caqh_import
end type
type gb_7 from groupbox within uo_caqh_import
end type
type gb_1 from groupbox within uo_caqh_import
end type
end forward

global type uo_caqh_import from userobject
integer width = 4302
integer height = 2236
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_lookups cb_lookups
cb_close cb_close
rb_add rb_add
cb_clear cb_clear
cb_next cb_next
rb_add_one rb_add_one
rb_data rb_data
rb_caqh rb_caqh
st_c st_c
st_d st_d
st_b st_b
st_a st_a
cb_rescan cb_rescan
rb_rescan rb_rescan
rb_scant rb_scant
rb_any rb_any
rb_all rb_all
st_tcnt st_tcnt
st_3 st_3
st_tname st_tname
rb_blank rb_blank
rb_addr rb_addr
rb_code rb_code
cb_1 cb_1
sle_2 sle_2
cb_remove cb_remove
rb_none rb_none
rb_mult rb_mult
rb_one rb_one
dw_list dw_list
cb_accept cb_accept
rb_manual rb_manual
rb_scan rb_scan
cb_run cb_run
rb_start rb_start
cbx_entity cbx_entity
cbx_zip cbx_zip
cbx_city cbx_city
cbx_street cbx_street
sle_1 sle_1
dw_existing dw_existing
st_1 st_1
rb_mid rb_mid
gb_2 gb_2
gb_3 gb_3
dw_1 dw_1
gb_4 gb_4
gb_5 gb_5
dw_import dw_import
gb_8 gb_8
st_message st_message
gb_7 gb_7
gb_1 gb_1
end type
global uo_caqh_import uo_caqh_import

type variables
string is_path
string is_type = "A"
string is_tname
string is_match_from
integer ii_badcnt = 0
integer ii_step = 1
end variables

forward prototypes
public function integer of_set_dw (integer ai_item)
public function string of_set_where_filter (long al_row)
public function string of_abbrev (string as_data)
public function integer of_filter_dws (string as_table)
public function string of_check_mid (string as_string)
public function string of_mid_filter (string as_string, integer ai_mid)
public function integer of_scan_table (string as_type, string as_table)
public function integer of_enable_method (boolean ab_status)
public function integer of_message (integer ai_case)
public function integer of_filter_matches (integer ai_case)
public function integer of_find_match (long al_row, string as_table)
public function integer of_scan_methods (integer ai_case)
public function integer of_accept (long al_imp, long al_exist, boolean ab_new)
public function integer of_import ()
public function integer of_table_checks (string as_table, integer ai_row)
public function integer of_open ()
public function integer of_create_tables ()
public function integer of_find_from_existing (long al_row, string as_table)
public function integer of_run_checks ()
public function integer of_after_accept ()
public function integer of_start_scan ()
public function integer of_add_remaining ()
public function integer of_clear_filter (string as_dw)
public function integer of_field_to_match (string as_arg)
public function integer of_scan_setup (string as_all)
public function integer of_list_click (integer ai_row)
end prototypes

public function integer of_set_dw (integer ai_item);
choose case ai_item
	case 1
		dw_import.dataobject = "d_caqh_import_addr"
		//dw_existing.dataobject = "d_caqh_address_lookups"
		dw_existing.dataobject = "d_address_lookup_caqh"
	case 2
		dw_import.dataobject = "d_caqh_import_codes"
		dw_existing.dataobject = "d_code_lookups_caqh"
	case 3 //questions
		dw_import.dataobject = ""
		dw_existing.dataobject = ""
end choose

dw_import.settransobject(sqlca)
dw_existing.settransobject(sqlca)
//if ai_item = 2 then
//	dw_existing.retrieve()
//end if

return 1
end function

public function string of_set_where_filter (long al_row);string ls_sql
string ls_val
string ls_sign = ""
integer li_mid
integer cnt

if cbx_entity.checked then
	ls_val = dw_import.getitemstring(al_row,"entity_name")
	ls_val = upper(ls_val)
	if LenA(sle_1.text) > 0 then //check for mid
		li_mid = integer(sle_1.text)
		if li_mid > 0  then //if a valid number
			if li_mid < LenA(ls_val) then //if the len of the value is less than mid number
				ls_sign = " like "
				if rb_start.checked then
					ls_val = MidA(ls_val,1,li_mid) + "% "
				else //middle of string
					ls_val = "%" + MidA(ls_val,1,li_mid) + "% "
				end if
			end if
		end if
	end if
	if ls_sign = "" then ls_sign = " = "
	ls_sql = "upper(entity_name)" + ls_sign + ls_val
	cnt ++
	//ls_sql
end if

if cbx_street.checked then
	ls_val = dw_import.getitemstring(al_row,"street")
	ls_sign = " = "
	if cnt > 0 then ls_sql = ls_sql + " and "
	ls_sql = ls_sql + " upper(street)" + ls_sign + ls_val
	cnt++
	//ls_sql
end if

if cbx_city.checked then
	ls_val = dw_import.getitemstring(al_row,"city")
	ls_sign = " = "
	if cnt > 0 then ls_sql = ls_sql + " and "
	ls_sql = ls_sql + "upper(city)" + ls_sign + ls_val
	cnt++
	//ls_sql
end if

if cbx_zip.checked then
	ls_val = dw_import.getitemstring(al_row,"zip")
	ls_val = MidA (ls_val,1,5) + "%"
	ls_sign = " like "
	if cnt > 0 then ls_sql = ls_sql + " and "
	ls_sql = ls_sql + "zip" + ls_sign + ls_val
	cnt++
	//ls_sql
end if

return ls_sql
end function

public function string of_abbrev (string as_data);string ls_val
string ls_abrv
string ls_abb[]
string ls_full[]
integer li_len[]
integer i
integer ic
//integer li_len
integer li_pos

ls_abb[1] = "ST."
ls_abb[2] = "BLVD."
ls_abb[3] = "AVE."
ls_abb[4] = "RD."
ls_abb[5] = "STE "
ls_abb[6] = "PL "
li_len[1] = 3
li_len[2] = 5
li_len[3] = 4
li_len[4] = 3
li_len[5] = 4
li_len[6] = 3
ls_full[1] = "STREET"
ls_full[2] = "BOULEVARD"
ls_full[3] = "AVENUE"
ls_full[4] = "ROAD"
ls_full[5] = "SUITE"
ls_full[6] = "PLACE"

ls_val = upper(as_data)

for i = 1 to UpperBound(ls_abb)
	li_pos = PosA(ls_val,ls_abb[i],1)
	if li_pos > 0 then
		ls_val = MidA(ls_val,1,li_pos -1) + ls_full[i] + MidA(ls_val,li_pos + li_len[i])
	end if
next

return ls_val
end function

public function integer of_filter_dws (string as_table);//called from cb_run: clicked

dw_existing.retrieve(as_table)

//if is_type = "C" then
////	dw_existing.setfilter("lookup_name = '" + as_table + "'")
////	dw_existing.filter()
//	dw_existing.retrieve(as_table)
//elseif is_type = "A" then
//	dw_existing.retrieve(as_table)
//	//messagebox(as_table,dw_existing.rowcount())
//end if


return 1
end function

public function string of_check_mid (string as_string);//this function strips single quotes and returns the shortened value

string ls_val
integer li_mid

ls_val = as_string

ls_val = of_strip_char("'",ls_val,"") //program function in intellicred.pbl

if LenA(as_string) > 0 then //check for mid
	li_mid = integer(sle_1.text)
	if li_mid > 0  then //if a valid number
		ls_val = MidA(ls_val,1,li_mid)
	end if
end if
	
return ls_val
end function

public function string of_mid_filter (string as_string, integer ai_mid);//can be used for string values only. Sets the filter parameter with sign
string ls_val
string ls_pre = "'"
string ls_post = "'"
string ls_sign = " = "
integer li_mid

ls_val = upper(as_string)

if rb_mid.checked then //put sign at beginning of like
	ls_pre = "'%"	
	ls_sign = " like "
	ls_post = "%' "
else
	ls_sign = " = "
end if

if LenA(as_string) > 0 then //check for mid
	if ai_mid = 1 then //for entity name and description fields
		li_mid = integer(sle_1.text)
		if li_mid > 0  then //if a valid number
			ls_val = MidA(ls_val,1,li_mid)
		end if
	end if
end if
	
ls_val = ls_sign + ls_pre + ls_val + ls_post
	
return ls_val
end function

public function integer of_scan_table (string as_type, string as_table);string ls_table
//function used to scan on a given table
long mc
long m
long rc
long ic
long i
long ll_id




ls_table = as_table

//dw_import.setfilter("lookup_name = '" + as_table + "'")
//dw_import.filter()
mc =  dw_import.rowcount()
	//messagebox(ls_table,mc)
	
if mc < 1 then 
	return 0
else
	of_filter_dws(ls_table)
	st_tname.text = ls_table
end if

for m = 1 to mc
	st_tcnt.text = string(m)
	rc = of_find_match(m,as_table)
	if rc = -666 then return -1  //too many errors
	dw_import.setitem(m,"match_cnt",rc)
	ll_id = dw_import.getitemnumber(m,"lookup_code")
	for i = 1 to rc
		dw_existing.setitem(i,"match_id",ll_id)
	next
next

dw_existing.setfilter("lookup_name = '" + as_table + "'")
dw_existing.filter()

	
return 1
end function

public function integer of_enable_method (boolean ab_status);
if ab_status then
	rb_scan.enabled = true
	rb_scant.enabled = true
	rb_manual.enabled = true
	rb_rescan.enabled = true
else
	rb_scan.enabled = false
	rb_scant.enabled = false
	rb_manual.enabled = false
	rb_rescan.enabled = false
end if

return 1
end function

public function integer of_message (integer ai_case);string ls_mess

choose case ai_case
	case 0
		ls_mess = "Step 1:  will scan all import records for matches.  When the Exact Scan is completed, import records will be marked with the number of matches.  Exact matches can be updated at the end of the scan. Click the Start Button when ready."
	case 1
		ls_mess = "Clearing CAQH data.  This may take a few minutes"
	case 2
		ls_mess = "Step 2: will scan all import records for matches based on a substring of lookup record.  The length of characters is set in the match Parameters # of Chars field. "
	case 3
		ls_mess = "Step 3: Import records will be marked with the number of matches.  Select One Match to view records that matched only one lookup record.  Select Any Match to view all matched imports. Double-click on a Lookup or Import record to view matches.  Click on an Import record and a Lookup record and click Accept to to update the Lookup record."
	case 4
		ls_mess = "Step 4: is a manual scan of remaining unmatched Lookup records.  Double-click on a lookup record to view import matches.  Click on a matched import record and click accept to update that record."
	case 5
		ls_mess = "Step 5: You can choose to add remaining import records to you lookup table.  To do so select Add Unmatched and click the Accept button."
	case 6
		ls_mess = "There is no message 6."
	case 7
		ls_mess = "Importing CAQH data.  This may take a few minutes."
		
		
			
end choose

st_message.text = ls_mess

return 1
end function

public function integer of_filter_matches (integer ai_case);rb_all.checked = false
rb_one.checked = false
rb_mult.checked = false
rb_none.checked = false
rb_any.checked = false
rb_blank.checked = false

choose case ai_case
	case 1
		rb_one.checked = true
		rb_one.triggerevent(clicked!)
	case 2
		rb_mult.checked = true
		rb_mult.triggerevent(clicked!)
	case 0
		rb_none.checked = true
		rb_none.triggerevent(clicked!)
	case -2  //any matches
		rb_any.checked = true
		rb_any.triggerevent(clicked!)
	case 3
		rb_blank.checked = true
		rb_blank.triggerevent(clicked!)
	case 10
		rb_all.checked = true
		rb_all.triggerevent(clicked!)
end choose


return 1
end function

public function integer of_find_match (long al_row, string as_table);//called from cb_run
string ls_val = ""
string ls_valnew
string ls_filter
string ls_type
string ls_table
integer r
integer c
integer li_ret = 0
integer li_count = 0
string ls_field[]
integer mat
long li_tcnt


//ls_val = "lookup_name = '" + as_table + "' " don't need this in the lookups
if is_type = "C" then
	ls_valnew = of_check_mid(dw_import.getitemstring(al_row,"description"))
	ls_filter = ls_val + "upper(description)" + of_mid_filter( ls_valnew,1)
	
	r = dw_existing.setfilter(ls_filter)
	if r < 0 then
		messagebox("Filter",ls_filter)
		ii_badcnt++
		if ii_badcnt = 10 then return -666
	end if
	dw_existing.filter()

	li_ret = dw_existing.rowcount( )
	
elseif is_type = "A" then
	//check for  match fields selected
	if cbx_zip.checked then
		li_count++
		ls_field[li_count] = 'zip'
	end if
	if cbx_city.checked then
		li_count++
		ls_field[li_count] = 'city'
	end if
	if cbx_street.checked then
		li_count++
		ls_field[li_count] = 'street1'
	end if
	if cbx_entity.checked then
		li_count++
		ls_field[li_count] = 'entity_name'
	end if
	// go through each row and match field by field
	//li_ret = dw_existing.rowcount( )
//	for r = 1 to li_ret
//		mat = 0

		for c = 1 to li_count
			if c > 1 then 
				ls_val = ls_val + " and " 
			end if
			ls_val = ls_val + "upper(" + ls_field[c] + ")"  
			ls_valnew = dw_import.getitemstring(al_row,ls_field[c]) 
			ls_valnew = of_abbrev(ls_valnew)
			ls_valnew = of_strip_char("'",ls_valnew,"") //program function striping quote
			if ls_field[c] = 'entity_name' then
				ls_valnew = of_mid_filter( ls_valnew,1)
			else
				ls_valnew = of_mid_filter( ls_valnew,0)
			end if
			if isnull(ls_valnew) then return -2
			ls_val = ls_val + ls_valnew 
		next
	//	messagebox("",ls_val)
		mat = dw_existing.setfilter(ls_val)
		if mat < 1 then 
			messagebox("Bad filter",ls_val)
			ii_badcnt++
			if ii_badcnt = 10 then return -666
		end if
		dw_existing.filter()
		mat = dw_existing.rowcount()

	li_ret = mat			
end if

return li_ret

end function

public function integer of_scan_methods (integer ai_case);rb_scan.checked = false
rb_scant.checked = false
rb_rescan.checked = false
rb_manual.checked = false
rb_add_one.checked = false
rb_add.checked = false

choose case ai_case
	case 1
		rb_scant.checked = true
	case 2
		rb_rescan.checked = true
	case 3
		rb_manual.checked = true
	case 4
		rb_add.checked = true

end choose


return 1
end function

public function integer of_accept (long al_imp, long al_exist, boolean ab_new);long ll_caqh
string ls_val
integer i
integer cnt
string ls_field


ll_caqh = dw_import.getitemnumber(al_imp,"caqh_code")
if ab_new then
	dw_existing.setitem(al_exist,"lookup_name",dw_import.getitemstring(al_imp,"lookup_name"))
	if is_type = "C" then
		dw_existing.setitem(al_exist,"code",upper(MidA(dw_import.getitemstring(al_imp,"description"),1, 6)))
	elseif is_type = "A" then
		dw_existing.setitem(al_exist,"code",upper(MidA(dw_import.getitemstring(al_imp,"entity_name"),1, 6)))
	end if
	dw_existing.setitem(al_exist,"ic_c","CAQH")
end if

dw_existing.setitem(al_exist,"caqh_code",ll_caqh)
dw_existing.setitem(al_exist,"match_id",-5)
if rb_data.checked or ab_new then
	if is_type = "C" then //code
		dw_existing.setitem(al_exist,"description",dw_import.getitemstring(al_imp,"description"))
	elseif is_type = "A" then  //address
		for i = 1 to 8  //loop through fields and update
			choose case i
				case 1 
					ls_field = "entity_name"
				case 2 
					ls_field = "street1"
				case 3 
					ls_field = "City"
				case 4 
					ls_field = "State"
				case 5 
					ls_field = "Zip"
				case 6 
					ls_field = "Country"
				case 7 
					ls_field = "phone"
				case 8 
					ls_field = "street_2"
					
			end choose		
			ls_val = dw_import.getitemstring(al_imp,ls_field)
			if not isnull(ls_val) and ls_val <> "" then
				dw_existing.setitem(al_exist,ls_field,ls_val)
			end if
		next
	end if
	
end if

//dw_existing.update()
//dw_existing.setfilter( "match_id = -5")
//dw_existing.filter()
//cnt = dw_existing.rowcount()
//dw_existing.rowsdiscard( 1,cnt, primary!)
//dw_existing.setfilter( "")
//dw_existing.filter()
dw_import.deleterow( al_imp)
dw_import.update()
		
		

return 1
end function

public function integer of_import ();dw_import.reset()
of_scan_setup("A") //imports data
of_enable_method( true)
//cb_run.enabled = true
cb_rescan.enabled = true

return 1
end function

public function integer of_table_checks (string as_table, integer ai_row);integer i
integer ic
integer cnt
string ls_table

//for i = 1 to dw_list.rowcount()

	ls_table = as_table
	if is_type = "C" then
		select count(lookup_code) into :cnt from code_lookup where lookup_name = :ls_table;
		select count(lookup_code) into :ic from code_lookup where lookup_name = :ls_table and caqh_code is null;
	elseif is_type = "A" then	
		select count(lookup_code) into :cnt from address_lookup where lookup_name = :ls_table;
		select count(lookup_code) into :ic from address_lookup where lookup_name = :ls_table and caqh_code is null;
	end if
	dw_list.setitem(ai_row,"num_unmatch",ic)
	dw_list.setitem(ai_row,"num_recs",cnt)
	
//next

return 1
end function

public function integer of_open ();integer i
string ls_file

of_create_tables( ) //create tables if do not exist
dw_list.settransobject(sqlca) //retrieve the list of caqh lookup tables
i = dw_list.retrieve() //if not records, import from file
if i = 0 then
	ls_file = gs_dir_path + "intellicred\caqh_tables_import.txt"
	if not fileexists(ls_file) then 
		messagebox("File not found","The CAQH table import file ( " + ls_file + " ) does not exist. Unable to continue.  Contact IntelliSoft support.")
		return -1
	else
		if dw_list.importfile( ls_file) < 1 then messagebox("Import error","Data not imported")
	end if
end if
////messagebox("",res)
dw_list.setfilter("lu_type = 'C'") 
dw_list.filter() 
of_enable_method( false)
rb_code.triggerevent(clicked!)
of_message(0)

return 1
end function

public function integer of_create_tables ();string ls_sql
string ls_path

ls_sql = "Create table caqh_tables (table_id integer not null,table_name varchar(50), lu_type char(1), cust_string varchar(30),num_recs integer,num_unmatch integer ,primary key (table_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE caqh_codes (	lookup_code decimal(16, 0),	lookup_name char(35),	code char(15),	description char(75),	caqh_code float,	custom_1 char(50),	custom_2 char(50),	custom_3 char(50),	type char(1),	ic_n decimal(16, 0),	ic_c char(50));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE caqh_addrs (	lookup_code decimal(16, 0)not null,	lookup_name char(50),	code char(50),	entity_name char(100),	caqh_code float,	street1 char(100),	city char(35),	state char(2),	zip char(12),	country char(50),	phone char(13),	street2 char(100),	province char(50),	primary key (lookup_code));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

return 1
end function

public function integer of_find_from_existing (long al_row, string as_table);//called from cb_run
string ls_val
string ls_valnew
string ls_filter
string ls_type
string ls_table
integer r
integer c
integer li_ret = 0
integer li_count = 0
string ls_field[]
integer mat
long li_tcnt


//ls_val = "lookup_name = '" + as_table + "' and "
if is_type = "C" then
	ls_valnew = of_check_mid(dw_existing.getitemstring(al_row,"description"))
	ls_filter = ls_val + "upper(description)" + of_mid_filter( ls_valnew,1)
	//messagebox("",ls_filter)
//	return -666
	r = dw_import.setfilter(ls_filter)
	if r < 0 then
		messagebox("Filter",ls_filter)
		ii_badcnt++
		if ii_badcnt = 10 then return -666
	end if
	dw_import.filter()

	li_ret = dw_import.rowcount( )
	
elseif is_type = "A" then
	//check for  match fields selected
	if cbx_zip.checked then
		li_count++
		ls_field[li_count] = 'zip'
	end if
	if cbx_city.checked then
		li_count++
		ls_field[li_count] = 'city'
	end if
	if cbx_street.checked then
		li_count++
		ls_field[li_count] = 'street1'
	end if
	if cbx_entity.checked then
		li_count++
		ls_field[li_count] = 'entity_name'
	end if
	// go through each row and match field by field
	//li_ret = dw_existing.rowcount( )
//	for r = 1 to li_ret
//		mat = 0

		for c = 1 to li_count
			if c > 1 then 
				ls_val = ls_val + " and " 
			end if
			ls_val = ls_val + "upper(" + ls_field[c] + ")"  
			ls_valnew = dw_existing.getitemstring(al_row,ls_field[c]) 
			ls_valnew = of_abbrev(ls_valnew)
			ls_valnew = of_strip_char("'",ls_valnew,"") //program function striping quote
			if ls_field[c] = 'entity_name' then
				ls_valnew = of_mid_filter( ls_valnew,1)
			else
				ls_valnew = of_mid_filter( ls_valnew,0)
			end if
			if isnull(ls_valnew) then return -2
			ls_val = ls_val + ls_valnew 
		next
	//	messagebox("",ls_val)
		mat = dw_import.setfilter(ls_val)
		if mat < 1 then 
			messagebox("Bad filter",ls_val)
			ii_badcnt++
			if ii_badcnt = 10 then return -666
		end if
		dw_import.filter()
		mat = dw_import.rowcount()

	li_ret = mat			
end if

return li_ret

end function

public function integer of_run_checks ();integer i

for i = 1 to dw_list.rowcount()
	of_table_checks(dw_list.getitemstring(i,"table_name"),i)
next

return 1
end function

public function integer of_after_accept ();integer cnt

dw_existing.setfilter( "match_id = -5")
dw_existing.filter()
cnt = dw_existing.rowcount()
dw_existing.rowsdiscard( 1,cnt, primary!)
dw_existing.setfilter( "")
dw_existing.filter()

return 1
end function

public function integer of_start_scan ();string ls_file
string ls_a
string ls_c
string ls_table
integer i
integer ic
integer m
integer mc
integer r
integer rc

ii_badcnt = 0

//filter table list
ic = dw_list.rowcount()
if dw_list.getrow() < 1 then
	messagebox("Scanning","Select lookup table to scan.")
	return 1
end if



ls_table = dw_list.getitemstring(dw_list.getrow(),"table_name")
is_tname = ls_table
//scan for matches
if rb_scant.checked   or rb_rescan.checked then
	if dw_import.rowcount() = 0 then dw_import.retrieve(is_tname)
	of_scan_table("T",ls_table)
elseif rb_manual.checked then //manual for one record
	if is_match_from = "E" then
		if dw_existing.rowcount() < 1 then 
			messagebox("Scanning","There is no data to scan in the existing lookup window")
			return 1
		end if
		ls_table = dw_existing.getitemstring(dw_existing.getrow(),"lookup_name")
		of_find_from_existing(dw_existing.getrow(),ls_table)
	elseif is_match_from = "I" then
		if dw_import.rowcount() < 1 then 
			messagebox("Scanning","There is no data to scan in the CAQH Import window")
			return 1
		end if
		ls_table = dw_import.getitemstring(dw_import.getrow(),"lookup_name")
		of_find_match(dw_import.getrow(),ls_table)
	end if
	//return
end if

return 1
//messagebox("Record Scan","Scan Complete")
//dw_import.setfilter("")
//dw_import.filter()
//ls_c = "lookup_name = '" + ls_table + "'"
//dw_import.setfilter(ls_c)
//dw_import.filter()


end function

public function integer of_add_remaining ();
of_filter_matches(0)

return 1

end function

public function integer of_clear_filter (string as_dw);if as_dw = "E" then
	dw_existing.setfilter("")
	dw_existing.filter()
elseif as_dw = "I" then
	dw_import.setfilter("")
	dw_import.filter()
end if

return 1
end function

public function integer of_field_to_match (string as_arg);
cbx_entity.checked = false
cbx_street.checked = false
cbx_city.checked = false
cbx_zip.checked = false

if is_type = "C" then
	cbx_entity.checked = true
else //addresses
	choose case as_arg
		case "E"
			cbx_entity.checked = true
		case "SZ"
			cbx_street.checked = true
			cbx_zip.checked = true
			
			
	end choose
end if

return 1
	
end function

public function integer of_scan_setup (string as_all);//imports caqh data

string ls_a
string ls_c
string ls_file
long cnt

//debugbreak()

if dw_import.rowcount() > 0 then return 1

ls_a = gs_dir_path + "intellicred\caqh_import_addr.txt"
ls_c = gs_dir_path + "intellicred\caqh_import_code.txt"

if is_type  = "A" then
	ls_file = ls_a
	of_set_dw(1)
	if as_all = "A" then
		select count(lookup_code) into :cnt from caqh_addrs;
	else //T
		select count(lookup_code) into :cnt from caqh_addrs where lookup_name = :is_tname;
	end if
elseif is_type  = "C" then
	ls_file = ls_c
	of_set_dw(2)
	if as_all = "A" then
		select count(lookup_code) into :cnt from caqh_codes;
	else //T
		select count(lookup_code) into :cnt from caqh_codes where lookup_name = :is_tname;
	end if
end if

//cnt = dw_import.retrieve()
if cnt > 0 then return -1

if not fileexists(ls_file) then 
	messagebox("File not found","The CAQH code import file ( " + ls_file + " ) does not exist")
else
	if dw_import.importfile( ls_file) < 1 then 
		messagebox("Import error","Data not imported")
	else
		if as_all = "T" then
			//filter the imported records
		end if
		of_message(7)
		dw_import.update()
	end if
end if
		




dw_import.retrieve(is_tname)


return 1
end function

public function integer of_list_click (integer ai_row);//called from clicked event of dw_list and from caqh delete

is_tname = dw_list.getitemstring(ai_row,"table_name")
dw_import.retrieve(is_tname)
dw_existing.retrieve(is_tname)
cb_next.text = "Start"
of_scan_methods(1)
of_filter_matches(10)

return 1
end function

on uo_caqh_import.create
this.cb_lookups=create cb_lookups
this.cb_close=create cb_close
this.rb_add=create rb_add
this.cb_clear=create cb_clear
this.cb_next=create cb_next
this.rb_add_one=create rb_add_one
this.rb_data=create rb_data
this.rb_caqh=create rb_caqh
this.st_c=create st_c
this.st_d=create st_d
this.st_b=create st_b
this.st_a=create st_a
this.cb_rescan=create cb_rescan
this.rb_rescan=create rb_rescan
this.rb_scant=create rb_scant
this.rb_any=create rb_any
this.rb_all=create rb_all
this.st_tcnt=create st_tcnt
this.st_3=create st_3
this.st_tname=create st_tname
this.rb_blank=create rb_blank
this.rb_addr=create rb_addr
this.rb_code=create rb_code
this.cb_1=create cb_1
this.sle_2=create sle_2
this.cb_remove=create cb_remove
this.rb_none=create rb_none
this.rb_mult=create rb_mult
this.rb_one=create rb_one
this.dw_list=create dw_list
this.cb_accept=create cb_accept
this.rb_manual=create rb_manual
this.rb_scan=create rb_scan
this.cb_run=create cb_run
this.rb_start=create rb_start
this.cbx_entity=create cbx_entity
this.cbx_zip=create cbx_zip
this.cbx_city=create cbx_city
this.cbx_street=create cbx_street
this.sle_1=create sle_1
this.dw_existing=create dw_existing
this.st_1=create st_1
this.rb_mid=create rb_mid
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_1=create dw_1
this.gb_4=create gb_4
this.gb_5=create gb_5
this.dw_import=create dw_import
this.gb_8=create gb_8
this.st_message=create st_message
this.gb_7=create gb_7
this.gb_1=create gb_1
this.Control[]={this.cb_lookups,&
this.cb_close,&
this.rb_add,&
this.cb_clear,&
this.cb_next,&
this.rb_add_one,&
this.rb_data,&
this.rb_caqh,&
this.st_c,&
this.st_d,&
this.st_b,&
this.st_a,&
this.cb_rescan,&
this.rb_rescan,&
this.rb_scant,&
this.rb_any,&
this.rb_all,&
this.st_tcnt,&
this.st_3,&
this.st_tname,&
this.rb_blank,&
this.rb_addr,&
this.rb_code,&
this.cb_1,&
this.sle_2,&
this.cb_remove,&
this.rb_none,&
this.rb_mult,&
this.rb_one,&
this.dw_list,&
this.cb_accept,&
this.rb_manual,&
this.rb_scan,&
this.cb_run,&
this.rb_start,&
this.cbx_entity,&
this.cbx_zip,&
this.cbx_city,&
this.cbx_street,&
this.sle_1,&
this.dw_existing,&
this.st_1,&
this.rb_mid,&
this.gb_2,&
this.gb_3,&
this.dw_1,&
this.gb_4,&
this.gb_5,&
this.dw_import,&
this.gb_8,&
this.st_message,&
this.gb_7,&
this.gb_1}
end on

on uo_caqh_import.destroy
destroy(this.cb_lookups)
destroy(this.cb_close)
destroy(this.rb_add)
destroy(this.cb_clear)
destroy(this.cb_next)
destroy(this.rb_add_one)
destroy(this.rb_data)
destroy(this.rb_caqh)
destroy(this.st_c)
destroy(this.st_d)
destroy(this.st_b)
destroy(this.st_a)
destroy(this.cb_rescan)
destroy(this.rb_rescan)
destroy(this.rb_scant)
destroy(this.rb_any)
destroy(this.rb_all)
destroy(this.st_tcnt)
destroy(this.st_3)
destroy(this.st_tname)
destroy(this.rb_blank)
destroy(this.rb_addr)
destroy(this.rb_code)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.cb_remove)
destroy(this.rb_none)
destroy(this.rb_mult)
destroy(this.rb_one)
destroy(this.dw_list)
destroy(this.cb_accept)
destroy(this.rb_manual)
destroy(this.rb_scan)
destroy(this.cb_run)
destroy(this.rb_start)
destroy(this.cbx_entity)
destroy(this.cbx_zip)
destroy(this.cbx_city)
destroy(this.cbx_street)
destroy(this.sle_1)
destroy(this.dw_existing)
destroy(this.st_1)
destroy(this.rb_mid)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_1)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.dw_import)
destroy(this.gb_8)
destroy(this.st_message)
destroy(this.gb_7)
destroy(this.gb_1)
end on

type cb_lookups from commandbutton within uo_caqh_import
integer x = 1211
integer y = 404
integer width = 379
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Lookups"
end type

event clicked;open(w_lookup_view)

if is_type = "A" then
	w_lookup_view.dw_detail.DataObject = "d_address_lookup"	
ELSEif is_type = "C" then
	w_lookup_view.dw_detail.DataObject = "d_code_lookup"
else
	
end if

w_lookup_view.dw_detail.settransobject(sqlca)
w_lookup_view.dw_detail.retrieve(is_tname)
end event

type cb_close from commandbutton within uo_caqh_import
integer x = 3173
integer y = 16
integer width = 503
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(w_caqh_import_utl)
end event

type rb_add from radiobutton within uo_caqh_import
integer x = 1646
integer y = 376
integer width = 475
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add Unmatched"
end type

event clicked;of_add_remaining()
end event

type cb_clear from commandbutton within uo_caqh_import
integer x = 2656
integer y = 16
integer width = 503
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear CAQH Codes"
end type

event clicked;

integer res
integer li_find
string ls_type
string ls_res
string ls_sql1
string ls_sql2
string ls_sql3
string ls_table
string ls_caqh_table


if rb_code.checked then
	ls_type = "Code"
elseif rb_addr.checked then
	ls_type = "Address"
end if 

//create parm
ls_table = MidA(ls_type,1,1) + "*" + is_tname


res = openwithparm(w_caqh_delete_data,ls_table)
ls_res = message.stringparm

ls_table = is_tname //reset the table name

if ls_res = "C" then //cancel
	return
elseif ls_res = "A" then 
	res = messagebox("Clear Data","Are you sure. All CAQH codes will be deleted from All " + ls_type + " lookup records, and will delete the CAQH import data.  You will have to start the match process over again.  Do you want to continue?",question!,yesno!,2)
else   //"T"
	res = messagebox("Clear Data","Are you sure. All CAQH codes will be deleted from All " + upper(is_tname) + " lookup records, and will delete the CAQH import data.  You will have to start the match process again for that table.  Do you want to continue?",question!,yesno!,2)	
end if

if res = 2 then
	return
end if

of_message(1)

if rb_code.checked then
	ls_type = "code_lookup"
	ls_caqh_table = "caqh_addrs"
elseif rb_addr.checked then
	ls_type = "address_lookup"
	ls_caqh_table = "caqh_codes"
end if

if ls_res = "A" then
	ls_sql1 = "update " + ls_type + " set caqh_code = null;"  //clears caqh field
	ls_sql2 = "delete from " + ls_type + " where ic_c = 'CAQH';"	//deletes records added from the import
	ls_sql3 = "delete from " + ls_caqh_table + ";"				//deletes records from the import table
else //table
	ls_sql1 = "update " + ls_type + " set caqh_code = null where lookup_name = '" + ls_table + "';"
	ls_sql2 = "delete from " + ls_type + " where  lookup_name = '" + ls_table + "' and ic_c = 'CAQH';"
	ls_sql3 = "delete from caqh_addrs where lookup_name = '" + ls_table + "';"
end if
	
//messagebox("ls_sql1",ls_sql1)
//messagebox("ls_sql2",ls_sql2)
//messagebox("ls_sql3",ls_sql3)
//return
	
execute immediate :ls_sql1 using sqlca;
execute immediate :ls_sql2 using sqlca;
execute immediate :ls_sql3 using sqlca;
commit using sqlca;

dw_import.reset()

of_scan_setup(ls_res) //reimport then import data

if rb_code.checked then
	rb_code.triggerevent(clicked!)
elseif rb_addr.checked then
	rb_addr.triggerevent(clicked!)
end if
debugbreak()
if ls_res = "T" then
	is_tname = ls_table
	//find the table in the list dw
	li_find = dw_list.find("table_name = '" + ls_table + "'",1,dw_list.rowcount())
	if li_find > 0 then
		dw_list.scrolltorow(li_find)
		dw_list.selectrow(0,false)
		dw_list.selectrow(li_find,true)
		dw_list.setrow(li_find)
		of_list_click(li_find)
	end if
end if
//reset to step 1
of_scan_methods( 1)
rb_scant.triggerevent(clicked!) 



end event

type cb_next from commandbutton within uo_caqh_import
integer x = 1623
integer y = 16
integer width = 503
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Start"
end type

event clicked;integer r
//debugbreak()
If ii_step = 1 then
	of_start_scan()
	of_scan_methods(2)
	of_filter_matches(1)
	cb_accept.triggerevent(clicked!)
	of_after_accept()
	rb_mid.checked = true
	this.text = "Step 2"
	of_message(2)
	sle_1.text = "5"

elseif ii_step = 2 then
	of_scan_methods(2)
	of_start_scan()
	this.text = "Step 3"
	of_message(3)
	of_scan_methods(3)
	of_filter_matches(1)
elseif ii_step = 3 then	
	of_message(4)
	this.text = "Step 4"
	
elseif ii_step = 4 then	
	of_message(5)
	of_add_remaining()
	this.text = "Step 5"
end if
	
ii_step++	
r = dw_list.getrow()
of_table_checks(dw_list.getitemstring(r,"table_name"),r)
end event

type rb_add_one from radiobutton within uo_caqh_import
integer x = 1646
integer y = 432
integer width = 338
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add Single"
end type

event clicked;of_add_remaining()
end event

type rb_data from radiobutton within uo_caqh_import
integer x = 2761
integer y = 644
integer width = 283
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All Data"
end type

type rb_caqh from radiobutton within uo_caqh_import
integer x = 2757
integer y = 568
integer width = 425
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "CAQH ID Only"
boolean checked = true
end type

type st_c from statictext within uo_caqh_import
integer x = 3890
integer y = 864
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Multiple"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_d from statictext within uo_caqh_import
integer x = 3881
integer y = 16
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "No Match"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_b from statictext within uo_caqh_import
integer x = 3890
integer y = 780
integer width = 279
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "One Match"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;of_message(2)
of_filter_matches(1)
end event

type st_a from statictext within uo_caqh_import
integer x = 3890
integer y = 696
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "st_a"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;of_field_to_match("SZ")
of_message(0)
end event

type cb_rescan from commandbutton within uo_caqh_import
integer x = 3881
integer y = 1596
integer width = 251
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;//rb_rescan.triggerevent(clicked!)
//cb_run.triggerevent(clicked!)

string null_str

SetNull(null_str)

dw_existing.Setfilter(null_str)

dw_existing.filter( )
end event

type rb_rescan from radiobutton within uo_caqh_import
integer x = 1646
integer y = 252
integer width = 494
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "2) Substring Scan"
end type

event clicked;ii_step = 2
cb_next.text = "Step 2"
of_message(2)
of_clear_filter("I")


end event

type rb_scant from radiobutton within uo_caqh_import
integer x = 1646
integer y = 196
integer width = 439
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "1) Exact Scan"
boolean checked = true
end type

event clicked;ii_step = 1
cb_next.text = "Step 1"
sle_1.text = ""
of_message(0)
end event

type rb_any from radiobutton within uo_caqh_import
integer x = 2231
integer y = 344
integer width = 398
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Any match"
end type

event clicked;dw_import.setfilter("match_cnt > 0")
dw_import.filter()
//of_scan_methods(2)
end event

type rb_all from radiobutton within uo_caqh_import
integer x = 2231
integer y = 196
integer width = 370
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All Records"
boolean checked = true
end type

event clicked;dw_import.setfilter("")
dw_import.filter()
end event

type st_tcnt from statictext within uo_caqh_import
integer x = 37
integer y = 1388
integer width = 178
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
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within uo_caqh_import
integer x = 229
integer y = 1388
integer width = 233
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Matching"
boolean focusrectangle = false
end type

type st_tname from statictext within uo_caqh_import
integer x = 475
integer y = 1388
integer width = 407
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Table"
boolean focusrectangle = false
end type

type rb_blank from radiobutton within uo_caqh_import
integer x = 3904
integer y = 492
integer width = 224
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Blank"
end type

event clicked;
dw_import.setfilter("")
dw_import.filter()
//of_scan_methods(2)
end event

type rb_addr from radiobutton within uo_caqh_import
integer x = 1271
integer y = 212
integer width = 297
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Address"
end type

event clicked;integer i
integer ic

cbx_entity.text = "Entity Name"
cbx_street.visible = true
cbx_city.visible = true
cbx_zip.visible = true
of_field_to_match("SZ")
rb_mid.checked = false
dw_list.setfilter("lu_type = 'A'")
dw_list.filter()
is_type = "A"
of_run_checks()
of_import()
st_a.triggerevent(clicked!)

end event

type rb_code from radiobutton within uo_caqh_import
integer x = 1271
integer y = 268
integer width = 242
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Code"
boolean checked = true
end type

event clicked;integer i

cbx_entity.text = "Description"
of_field_to_match("D")
rb_mid.checked = false
dw_list.setfilter("lu_type = 'C'")
dw_list.filter()
dw_list.selectrow(0,false)
dw_list.selectrow(1,true)
is_type = "C"
of_run_checks()
of_import()
st_a.triggerevent(clicked!)



end event

type cb_1 from commandbutton within uo_caqh_import
boolean visible = false
integer x = 1006
integer y = 2120
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "abbrv test"
end type

event clicked;string ls_data
//debugbreak()
ls_data = sle_2.text

ls_data = of_abbrev( ls_data)

messagebox("Test",ls_data)
end event

type sle_2 from singlelineedit within uo_caqh_import
boolean visible = false
integer x = 27
integer y = 2124
integer width = 923
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type cb_remove from commandbutton within uo_caqh_import
integer x = 3415
integer y = 1388
integer width = 251
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_existing.SetSort(null_str)

dw_existing.Sort( )
end event

type rb_none from radiobutton within uo_caqh_import
integer x = 2231
integer y = 420
integer width = 315
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "No Match"
end type

event clicked;dw_import.setfilter("match_cnt = 0")
dw_import.filter()
//of_scan_methods(2)
end event

type rb_mult from radiobutton within uo_caqh_import
integer x = 4000
integer y = 228
integer width = 283
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Multiple"
end type

event clicked;dw_import.setfilter("match_cnt > 1")
dw_import.filter()
//of_scan_methods(3)
end event

type rb_one from radiobutton within uo_caqh_import
integer x = 2231
integer y = 268
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "One Match"
end type

event clicked;
dw_import.setfilter("match_cnt = 1")
dw_import.filter()
//of_scan_methods(3)
end event

type dw_list from datawindow within uo_caqh_import
integer x = 27
integer y = 20
integer width = 1157
integer height = 480
integer taborder = 40
string title = "none"
string dataobject = "d_caqh_tables"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer i

i = this.getclickedrow()
if i < 1 then return //Start Code Change ----03.26.2008 #V8 maha
this.setrow(i)
//is_tname = this.getitemstring(i,"table_name")
//dw_import.retrieve(is_tname)
//dw_existing.retrieve(is_tname)
//cb_next.text = "Start"
//of_scan_methods(1)
//of_filter_matches(0)
of_list_click(i)

if is_type = "A" then
	if dw_import.rowcount() > 0 then
		if LenA(dw_import.getitemstring(1,"street1")) > 0 then
			of_field_to_match("SZ")
		else
			of_field_to_match("E")
		end if
	end if
end if 

ii_step = 1

end event

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

type cb_accept from commandbutton within uo_caqh_import
integer x = 2139
integer y = 16
integer width = 503
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Accept"
end type

event clicked;integer res
long i
long ic
long ec
long ll_id
long r
integer cnt

ic = dw_import.rowcount() 
if ic < 1 then return

if rb_add_one.checked then  //add single
		i = dw_import.getrow()
		ll_id = gnv_app.of_get_id( "LOOKUP")
		r = dw_existing.insertrow(0)
		dw_existing.setitem(r,"lookup_code",ll_id)
		of_accept(i,r,true)

elseif rb_add.checked then //add for all unmatched
		res = messagebox("Accepting matches","Do you wish to accept all unmatched import records as new lookup records?",question!,yesno!,2 )
		if res = 2 then
			return
		else
			dw_import.accepttext()
			rb_data.checked = true
			for i = ic to 1 step -1
				ll_id = gnv_app.of_get_id( "LOOKUP")
				r = dw_existing.insertrow(0)
				dw_existing.setitem(r,"lookup_code",ll_id)
				of_accept(i,r,true)
			next
			rb_data.checked = false
			sqlca.autocommit = false
			res = dw_existing.update()
			if res < 1 then
				ROLLBACK USING SQLCA;
			else
				commit using sqlca;
			end if
		end if
elseif rb_manual.checked then  //update the selected records
	if dw_existing.rowcount() > 0 then
		of_accept(dw_import.getrow(),dw_existing.getrow(),false)
		dw_existing.update()
		of_after_accept()
	end if
	
elseif rb_one.checked  then
	res = messagebox("Accepting matches","Do you wish to accept all import records that have a single match?",question!,yesno!,2 )
	if res = 2 then
		return
	else
		dw_import.accepttext()
		ec = dw_existing.rowcount()
		for i = ic to 1 step -1  //update record for each single match
			ll_id = dw_import.getitemnumber(i,"lookup_code")
			r = dw_existing.find("match_id = " + string(ll_id),1,ec )
			if r > 0 then
				of_accept(i,r,false)
				cnt++
			end if
		next
		dw_existing.update()
		messagebox("",string(cnt) + " records updated.")
		of_filter_matches( 3)
	end if


end if

r = dw_list.getrow()
of_table_checks(is_tname,r)

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2

//integer res
//long i
//long ic
//long ec
//long ll_id
//long r
//integer cnt
//
//ic = dw_import.rowcount() 
//if ic < 1 then return
//
//if rb_one.checked and not rb_manual.checked then
//
//	//for each import record
//	res = messagebox("Accepting matches","Do you wish to accept all import records that have a single match?",question!,yesno!,2 )
//	if res = 2 then
//		return
//	else
//		dw_import.accepttext()
//		ec = dw_existing.rowcount()
//		for i = ic to 1 step -1
//			ll_id = dw_import.getitemnumber(i,"lookup_code")
//			r = dw_existing.find("match_id = " + string(ll_id),1,ec )
//			if r > 0 then
//				of_accept(i,r,false)
//				cnt++
//			end if
//		next
//		dw_existing.update()
//		messagebox("",string(cnt) + " records updated.")
//		of_filter_matches( 3)
//	end if
//elseif rb_manual.checked then
//	if dw_existing.rowcount() > 0 then
//		of_accept(dw_import.getrow(),dw_existing.getrow(),false)
//		dw_existing.update()
//		of_after_accept()
//	end if
//elseif rb_add_one.checked then
//		i = dw_import.getrow()
//		ll_id = gnv_app.of_get_id( "LOOKUP")
//		r = dw_existing.insertrow(0)
//		dw_existing.setitem(r,"lookup_code",ll_id)
//		of_accept(i,r,true)
//
//elseif rb_add.checked then
//		res = messagebox("Accepting matches","Do you wish to accept all unmatched import records as new lookup records?",question!,yesno!,2 )
//		if res = 2 then
//			return
//		else
//			dw_import.accepttext()
//			rb_data.checked = true
//			for i = ic to 1 step -1
//				ll_id = gnv_app.of_get_id( "LOOKUP")
//				r = dw_existing.insertrow(0)
//				dw_existing.setitem(r,"lookup_code",ll_id)
//				of_accept(i,r,true)
//			next
//			rb_data.checked = false
//			sqlca.autocommit = false
//			res = dw_existing.update()
//			if res < 1 then
//				ROLLBACK USING SQLCA;
//			else
//				commit using sqlca;
//			end if
//		end if
//	
//	
//end if
//
//r = dw_list.getrow()
//of_table_checks(is_tname,r)
//
//
end event

type rb_manual from radiobutton within uo_caqh_import
integer x = 1646
integer y = 312
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "3) Manual"
end type

event clicked;//cb_run.enabled = false
ii_step = 3
cb_next.text = "Step 3"
of_clear_filter("E")
of_message(3)
end event

type rb_scan from radiobutton within uo_caqh_import
integer x = 3854
integer y = 592
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Full Scan"
end type

event clicked;//cb_run.enabled = true
end event

type cb_run from commandbutton within uo_caqh_import
integer x = 3877
integer y = 1500
integer width = 251
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scan"
end type

event clicked;of_start_scan()
//string ls_file
//string ls_a
//string ls_c
//string ls_table
//integer i
//integer ic
//integer m
//integer mc
//integer r
//integer rc
//
//ii_badcnt = 0
//
////filter table list
//ic = dw_list.rowcount()
//if dw_list.getrow() < 1 then
//	messagebox("Scanning","Select lookup table to scan.")
//	return 1
//end if
//
//ls_table = dw_list.getitemstring(dw_list.getrow(),"table_name")
//is_tname = ls_table
////scan for matches
//if rb_scant.checked   or rb_rescan.checked then
//	of_scan_table("T",ls_table)
//elseif rb_manual.checked and not rb_manview.checked then //manual for one record
//	if is_match_from = "E" then
//		ls_table = dw_existing.getitemstring(dw_existing.getrow(),"lookup_name")
//		of_find_from_existing(dw_existing.getrow(),ls_table)
//	elseif is_match_from = "I" then
//		ls_table = dw_import.getitemstring(dw_existing.getrow(),"table_name")
//		of_find_match(dw_import.getrow(),ls_table)
//	end if
//	//return
//end if
//
//
////messagebox("Record Scan","Scan Complete")
////dw_import.setfilter("")
////dw_import.filter()
////ls_c = "lookup_name = '" + ls_table + "'"
////dw_import.setfilter(ls_c)
////dw_import.filter()
//
//
end event

type rb_start from radiobutton within uo_caqh_import
integer x = 2816
integer y = 344
integer width = 329
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From Start"
boolean checked = true
end type

type cbx_entity from checkbox within uo_caqh_import
integer x = 3310
integer y = 196
integer width = 357
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Entity name"
boolean checked = true
end type

type cbx_zip from checkbox within uo_caqh_import
integer x = 3310
integer y = 420
integer width = 219
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Zip"
boolean checked = true
end type

type cbx_city from checkbox within uo_caqh_import
integer x = 3310
integer y = 344
integer width = 215
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "City"
end type

type cbx_street from checkbox within uo_caqh_import
integer x = 3310
integer y = 268
integer width = 274
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Street"
boolean checked = true
end type

type sle_1 from singlelineedit within uo_caqh_import
integer x = 2821
integer y = 268
integer width = 242
integer height = 68
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type dw_existing from u_dw within uo_caqh_import
integer y = 776
integer width = 3666
integer height = 604
integer taborder = 10
boolean titlebar = true
string title = "IntelliSoft Lookups"
string dataobject = "d_code_lookups_caqh"
boolean hscrollbar = true
end type

event clicked;call super::clicked;long r

r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event doubleclicked;call super::doubleclicked;if this.rowcount() = 0 then
	this.setfilter("lookup_name = '" + is_tname + "'")
	this.filter()
else	
	is_match_from = "E"
	of_scan_methods(3)
	of_start_scan()
	of_filter_matches(-2 )
end if


end event

event rowfocuschanged;call super::rowfocuschanged;long r

r = currentrow
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

type st_1 from statictext within uo_caqh_import
integer x = 2816
integer y = 196
integer width = 247
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "# of Chars"
boolean focusrectangle = false
end type

type rb_mid from radiobutton within uo_caqh_import
integer x = 2816
integer y = 420
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Middle"
end type

type gb_2 from groupbox within uo_caqh_import
integer x = 2720
integer y = 144
integer width = 535
integer height = 356
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Substring Parameters"
end type

type gb_3 from groupbox within uo_caqh_import
integer x = 1614
integer y = 144
integer width = 549
integer height = 356
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Steps"
end type

type dw_1 from datawindow within uo_caqh_import
integer x = 1431
integer y = 2148
integer width = 119
integer height = 60
integer taborder = 40
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within uo_caqh_import
integer x = 2176
integer y = 144
integer width = 526
integer height = 356
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter matches"
end type

type gb_5 from groupbox within uo_caqh_import
integer x = 1216
integer y = 148
integer width = 375
integer height = 228
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Lookup Type"
end type

type dw_import from u_dw within uo_caqh_import
integer x = 18
integer y = 1460
integer width = 3657
integer height = 620
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "CAQH Import"
string dataobject = "d_caqh_import_codes"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.setrowfocusindicator( hand!)
end event

event clicked;call super::clicked;long r
long ll_id
long ll_find

r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

//if rb_manview.checked then
//	ll_id = this.getitemnumber(r,"lookup_code")
//	ll_find = dw_existing.find("match_id = " + string(ll_id),1,100000)
//	if ll_find > 0 then
//		dw_existing.scrolltorow(ll_find)
//		dw_existing.setrow(ll_find)
//	end if
//end if
	
end event

event doubleclicked;call super::doubleclicked;
is_match_from = "I"
of_scan_methods(3)
of_start_scan()
end event

type gb_8 from groupbox within uo_caqh_import
integer x = 3278
integer y = 144
integer width = 398
integer height = 356
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Match on:"
end type

type st_message from statictext within uo_caqh_import
integer x = 41
integer y = 560
integer width = 2642
integer height = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Select the lookup type to import.  Start with the Code lookups as they are less complicated."
boolean focusrectangle = false
end type

type gb_7 from groupbox within uo_caqh_import
integer x = 14
integer y = 512
integer width = 2697
integer height = 252
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Messages"
end type

type gb_1 from groupbox within uo_caqh_import
integer x = 2725
integer y = 512
integer width = 535
integer height = 248
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Update:"
end type

