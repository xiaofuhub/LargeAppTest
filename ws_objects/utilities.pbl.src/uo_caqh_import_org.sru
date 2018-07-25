$PBExportHeader$uo_caqh_import_org.sru
forward
global type uo_caqh_import_org from userobject
end type
type rb_manview from radiobutton within uo_caqh_import_org
end type
type rb_data from radiobutton within uo_caqh_import_org
end type
type rb_caqh from radiobutton within uo_caqh_import_org
end type
type st_c from statictext within uo_caqh_import_org
end type
type st_d from statictext within uo_caqh_import_org
end type
type st_b from statictext within uo_caqh_import_org
end type
type st_a from statictext within uo_caqh_import_org
end type
type cb_rescan from commandbutton within uo_caqh_import_org
end type
type st_message from statictext within uo_caqh_import_org
end type
type cb_import from commandbutton within uo_caqh_import_org
end type
type rb_rescan from radiobutton within uo_caqh_import_org
end type
type rb_scant from radiobutton within uo_caqh_import_org
end type
type rb_er from radiobutton within uo_caqh_import_org
end type
type rb_all from radiobutton within uo_caqh_import_org
end type
type st_tcnt from statictext within uo_caqh_import_org
end type
type st_3 from statictext within uo_caqh_import_org
end type
type st_tname from statictext within uo_caqh_import_org
end type
type rb_blank from radiobutton within uo_caqh_import_org
end type
type rb_addr from radiobutton within uo_caqh_import_org
end type
type rb_code from radiobutton within uo_caqh_import_org
end type
type cb_1 from commandbutton within uo_caqh_import_org
end type
type sle_2 from singlelineedit within uo_caqh_import_org
end type
type cb_remove from commandbutton within uo_caqh_import_org
end type
type rb_none from radiobutton within uo_caqh_import_org
end type
type rb_mult from radiobutton within uo_caqh_import_org
end type
type rb_one from radiobutton within uo_caqh_import_org
end type
type dw_list from datawindow within uo_caqh_import_org
end type
type cb_accept from commandbutton within uo_caqh_import_org
end type
type rb_manual from radiobutton within uo_caqh_import_org
end type
type rb_scan from radiobutton within uo_caqh_import_org
end type
type cb_run from commandbutton within uo_caqh_import_org
end type
type rb_start from radiobutton within uo_caqh_import_org
end type
type cbx_entity from checkbox within uo_caqh_import_org
end type
type cbx_zip from checkbox within uo_caqh_import_org
end type
type cbx_city from checkbox within uo_caqh_import_org
end type
type cbx_street from checkbox within uo_caqh_import_org
end type
type sle_1 from singlelineedit within uo_caqh_import_org
end type
type dw_existing from u_dw within uo_caqh_import_org
end type
type st_1 from statictext within uo_caqh_import_org
end type
type rb_mid from radiobutton within uo_caqh_import_org
end type
type gb_2 from groupbox within uo_caqh_import_org
end type
type gb_3 from groupbox within uo_caqh_import_org
end type
type dw_1 from datawindow within uo_caqh_import_org
end type
type gb_4 from groupbox within uo_caqh_import_org
end type
type gb_5 from groupbox within uo_caqh_import_org
end type
type dw_import from u_dw within uo_caqh_import_org
end type
type gb_6 from groupbox within uo_caqh_import_org
end type
type gb_1 from groupbox within uo_caqh_import_org
end type
type gb_7 from groupbox within uo_caqh_import_org
end type
type gb_8 from groupbox within uo_caqh_import_org
end type
end forward

global type uo_caqh_import_org from userobject
integer width = 3543
integer height = 2236
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
rb_manview rb_manview
rb_data rb_data
rb_caqh rb_caqh
st_c st_c
st_d st_d
st_b st_b
st_a st_a
cb_rescan cb_rescan
st_message st_message
cb_import cb_import
rb_rescan rb_rescan
rb_scant rb_scant
rb_er rb_er
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
gb_6 gb_6
gb_1 gb_1
gb_7 gb_7
gb_8 gb_8
end type
global uo_caqh_import_org uo_caqh_import_org

type variables
string is_path
string is_type = "A"
integer ii_badcnt = 0
end variables

forward prototypes
public function integer of_set_dw (integer ai_item)
public function string of_set_where_filter (long al_row)
public function string of_abbrev (string as_data)
public function integer of_filter_dws (string as_table)
public function string of_check_mid (string as_string)
public function string of_mid_filter (string as_string, integer ai_mid)
public function integer of_scan_table (string as_type, string as_table)
public function integer of_scan_setup ()
public function integer of_enable_method (boolean ab_status)
public function integer of_message (integer ai_case)
public function integer of_filter_matches (integer ai_case)
public function integer of_find_match (long al_row, string as_table)
public function integer of_scan_methods (integer ai_case)
public function integer of_accept (long al_imp, long al_exist, boolean ab_new)
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
if ai_item = 2 then
	dw_existing.retrieve()
end if

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



if is_type = "C" then
	dw_existing.setfilter("lookup_name = '" + as_table + "'")
	dw_existing.filter()
elseif is_type = "A" then
	dw_existing.retrieve(as_table)
	//messagebox(as_table,dw_existing.rowcount())
end if


return 1
end function

public function string of_check_mid (string as_string);string ls_val
integer li_mid

ls_val = as_string

ls_val = of_strip_char("'",ls_val," ") //program function in intellicred.pbl

if LenA(as_string) > 0 then //check for mid
	li_mid = integer(sle_1.text)
	if li_mid > 0  then //if a valid number
		ls_val = MidA(ls_val,1,li_mid)
	end if
end if
	
return ls_val
end function

public function string of_mid_filter (string as_string, integer ai_mid);//can be used for string values only
string ls_val
string ls_pre = "'"
string ls_post = "'"
string ls_sign = " = "
integer li_mid

ls_val = as_string

if LenA(as_string) > 0 then //check for mid
	if ai_mid = 1 then //for entity name and description fields
		li_mid = integer(sle_1.text)
		if li_mid > 0  then //if a valid number
			if li_mid <= LenA(ls_val) then //if the len of the value is less than mid number
				ls_sign = " like "
				ls_post = "%' "
				if rb_mid.checked then //put sign at beginning of like
					ls_pre = "'%"		
				end if
			else
				ls_sign = " = "
			end if
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




//ls_table = dw_list.getitemstring(i,"lookup_name")
dw_import.setfilter("lookup_name = '" + as_table + "'")
dw_import.filter()
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

	
return 1
end function

public function integer of_scan_setup ();string ls_a
string ls_c
string ls_file


if rb_scan.checked then
	ls_a = gs_dir_path + "intellicred\caqh_import_addr.txt"
	ls_c = gs_dir_path + "intellicred\caqh_import_code.txt"
	
	if is_type  = "A" then
		ls_file = ls_a
		of_set_dw(1)
	elseif is_type  = "C" then
		ls_file = ls_c
		of_set_dw(2)
	end if
	
	if not fileexists(ls_file) then 
		messagebox("File not found","The CAQH code import file ( " + ls_file + " ) does not exist")
	else
		if dw_import.importfile( ls_file) < 1 then messagebox("Import error","Data not imported")
	end if
end if

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
		ls_mess = "Select the Lookup Data Type to import.  Start with the Code lookups as they are less complicated."
	case 1
		ls_mess = "Full Scan will scan all import records for matches.  Click the Scan Button when ready."
	case 2
		ls_mess = "When the initial Scan is completed, import records will be marked with the number of matches.~rSelect the One matched button to view records that matched only one lookup record.~rClick Accept to update those records."
	case 3
		ls_mess = ""
	case 4
		ls_mess = ""
	case 5
		ls_mess = ""
	case 6
		ls_mess = ""
	case 7
		ls_mess = ""
		
		
			
end choose

st_message.text = ls_mess

return 1
end function

public function integer of_filter_matches (integer ai_case);rb_all.checked = false
rb_one.checked = false
rb_mult.checked = false
rb_none.checked = false
rb_er.checked = false
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
	case -2
		rb_er.checked = true
		rb_er.triggerevent(clicked!)
	case 3
		rb_blank.checked = true
		rb_blank.triggerevent(clicked!)
end choose


return 1
end function

public function integer of_find_match (long al_row, string as_table);//called from cb_run
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


ls_val = "lookup_name = '" + as_table + "' "
if is_type = "C" then
	ls_valnew = of_check_mid(dw_import.getitemstring(al_row,"description"))
	ls_filter = ls_val + "and description" + of_mid_filter( ls_valnew,1)
//	messagebox("",ls_filter)
//	return -666
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
			//if c > 1 then 
			ls_val = ls_val + " and " 
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


//takes forever code
//	for r = 1 to li_ret
//		mat = 0
//		for c = 1 to li_count
//			
//			//get the import record value and compare to each lookup record
//			ls_valnew = dw_import.getitemstring(al_row,ls_field[c])
//			ls_val = dw_existing.getitemstring(r,ls_field[c])
//			if ls_field[li_count] = 'entity_name' then
//				ls_valnew = of_mid_filter( ls_valnew)
//				ls_val = of_mid_filter( ls_val)
//			end if
//			if ls_valnew = ls_val then mat = 1
//			if mat = 0 then 
//				exit
//			else
//				if c = li_count then li_tcnt++ //if all matches add to count total
//			end if
//		next
//	next
	
end function

public function integer of_scan_methods (integer ai_case);rb_scan.checked = false
rb_scant.checked = false
rb_rescan.checked = false
rb_manual.checked = false
rb_manview.checked = false
//rb_blank.checked = false

choose case ai_case
	case 1
		rb_scan.checked = true
	case 2
		rb_rescan.checked = true
	case 3
		rb_manual.checked = true

end choose


return 1
end function

public function integer of_accept (long al_imp, long al_exist, boolean ab_new);long ll_caqh
string ls_val
integer i
string ls_field


ll_caqh = dw_import.getitemnumber(al_imp,"caqh_code")
if ab_new then
	dw_existing.setitem(al_exist,"lookup_name",dw_import.getitemstring(al_imp,"lookup_name"))
	if is_type = "C" then
		dw_existing.setitem(al_exist,"code",upper(MidA(dw_import.getitemstring(al_imp,"description"),1, 6)))
	elseif is_type = "A" then
		dw_existing.setitem(al_exist,"code",upper(MidA(dw_import.getitemstring(al_imp,"entity_name"),1, 6)))
	end if
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

dw_import.rowsdiscard( al_imp, al_imp, primary!)
	
		
		

return 1
end function

on uo_caqh_import_org.create
this.rb_manview=create rb_manview
this.rb_data=create rb_data
this.rb_caqh=create rb_caqh
this.st_c=create st_c
this.st_d=create st_d
this.st_b=create st_b
this.st_a=create st_a
this.cb_rescan=create cb_rescan
this.st_message=create st_message
this.cb_import=create cb_import
this.rb_rescan=create rb_rescan
this.rb_scant=create rb_scant
this.rb_er=create rb_er
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
this.gb_6=create gb_6
this.gb_1=create gb_1
this.gb_7=create gb_7
this.gb_8=create gb_8
this.Control[]={this.rb_manview,&
this.rb_data,&
this.rb_caqh,&
this.st_c,&
this.st_d,&
this.st_b,&
this.st_a,&
this.cb_rescan,&
this.st_message,&
this.cb_import,&
this.rb_rescan,&
this.rb_scant,&
this.rb_er,&
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
this.gb_6,&
this.gb_1,&
this.gb_7,&
this.gb_8}
end on

on uo_caqh_import_org.destroy
destroy(this.rb_manview)
destroy(this.rb_data)
destroy(this.rb_caqh)
destroy(this.st_c)
destroy(this.st_d)
destroy(this.st_b)
destroy(this.st_a)
destroy(this.cb_rescan)
destroy(this.st_message)
destroy(this.cb_import)
destroy(this.rb_rescan)
destroy(this.rb_scant)
destroy(this.rb_er)
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
destroy(this.gb_6)
destroy(this.gb_1)
destroy(this.gb_7)
destroy(this.gb_8)
end on

type rb_manview from radiobutton within uo_caqh_import_org
integer x = 1280
integer y = 600
integer width = 325
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "View Only"
end type

type rb_data from radiobutton within uo_caqh_import_org
integer x = 2633
integer y = 568
integer width = 283
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "All Data"
end type

type rb_caqh from radiobutton within uo_caqh_import_org
integer x = 2162
integer y = 568
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "CAQH ID Only"
boolean checked = true
end type

type st_c from statictext within uo_caqh_import_org
integer x = 937
integer y = 504
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Multiple"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_d from statictext within uo_caqh_import_org
integer x = 937
integer y = 576
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Match"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_b from statictext within uo_caqh_import_org
integer x = 937
integer y = 432
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "One Match"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;of_message(2)
of_filter_matches(1)
end event

type st_a from statictext within uo_caqh_import_org
integer x = 937
integer y = 360
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Full scan"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;if rb_addr.checked then
	cbx_entity.checked = false
else
	cbx_entity.checked = true //description
end if
cbx_street.checked = true
cbx_city.checked = false
cbx_zip.checked = true
of_message(1)
end event

type cb_rescan from commandbutton within uo_caqh_import_org
integer x = 2144
integer y = 1384
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

type st_message from statictext within uo_caqh_import_org
integer x = 914
integer y = 56
integer width = 2021
integer height = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Select the lookup type to import.  Start with the Code lookups as they are less complicated."
boolean focusrectangle = false
end type

type cb_import from commandbutton within uo_caqh_import_org
integer x = 59
integer y = 672
integer width = 251
integer height = 72
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import "
end type

event clicked;of_scan_setup()
of_enable_method( true)
cb_run.enabled = true
cb_rescan.enabled = true
end event

type rb_rescan from radiobutton within uo_caqh_import_org
integer x = 1280
integer y = 412
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rescan"
end type

type rb_scant from radiobutton within uo_caqh_import_org
integer x = 1280
integer y = 476
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scan Table"
end type

type rb_er from radiobutton within uo_caqh_import_org
integer x = 3054
integer y = 448
integer width = 398
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Error (rescan)"
end type

event clicked;dw_import.setfilter("match_cnt < 0")
dw_import.filter()
of_scan_methods(2)
end event

type rb_all from radiobutton within uo_caqh_import_org
integer x = 3054
integer y = 84
integer width = 370
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "All Records"
boolean checked = true
end type

event clicked;dw_import.setfilter("")
dw_import.filter()
end event

type st_tcnt from statictext within uo_caqh_import_org
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
long backcolor = 67108864
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within uo_caqh_import_org
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
long backcolor = 67108864
string text = "Matching"
boolean focusrectangle = false
end type

type st_tname from statictext within uo_caqh_import_org
integer x = 475
integer y = 1392
integer width = 407
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Table"
boolean focusrectangle = false
end type

type rb_blank from radiobutton within uo_caqh_import_org
integer x = 3054
integer y = 552
integer width = 224
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Blank"
end type

event clicked;dw_import.setfilter("isnull(match_cnt)")
dw_import.filter()
of_scan_methods(2)
end event

type rb_addr from radiobutton within uo_caqh_import_org
integer x = 114
integer y = 568
integer width = 242
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Addr"
end type

event clicked;cbx_entity.text = "Entity Name"
cbx_street.visible = true
cbx_city.visible = true
cbx_zip.visible = true
dw_list.setfilter("type = 'A'")
dw_list.filter()
is_type = "A"
cb_import.triggerevent(clicked!)
st_a.triggerevent(clicked!)

end event

type rb_code from radiobutton within uo_caqh_import_org
integer x = 453
integer y = 568
integer width = 242
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Code"
end type

event clicked;cbx_entity.text = "Description"
cbx_street.visible = false
cbx_city.visible = false
cbx_zip.visible = false
dw_list.setfilter("type = 'C'")
dw_list.filter()
is_type = "C"
cb_import.triggerevent(clicked!)
st_a.triggerevent(clicked!)



end event

type cb_1 from commandbutton within uo_caqh_import_org
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
debugbreak()
ls_data = sle_2.text

ls_data = of_abbrev( ls_data)

messagebox("Test",ls_data)
end event

type sle_2 from singlelineedit within uo_caqh_import_org
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

type cb_remove from commandbutton within uo_caqh_import_org
integer x = 1833
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

type rb_none from radiobutton within uo_caqh_import_org
integer x = 3054
integer y = 360
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Match"
end type

event clicked;dw_import.setfilter("match_cnt = 0")
dw_import.filter()
of_scan_methods(2)
end event

type rb_mult from radiobutton within uo_caqh_import_org
integer x = 3054
integer y = 264
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Multiple"
end type

event clicked;dw_import.setfilter("match_cnt > 1")
dw_import.filter()
of_scan_methods(3)
end event

type rb_one from radiobutton within uo_caqh_import_org
integer x = 3054
integer y = 172
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "One Match"
end type

event clicked;
dw_import.setfilter("match_cnt = 1")
dw_import.filter()
of_scan_methods(3)
end event

type dw_list from datawindow within uo_caqh_import_org
integer x = 27
integer y = 28
integer width = 814
integer height = 460
integer taborder = 40
string title = "none"
string dataobject = "d_dddw_lookup_select_caqh"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer i

i = this.getclickedrow()
this.setrow(1)
this.selectrow(0,false)
this.selectrow(i,true)
end event

type cb_accept from commandbutton within uo_caqh_import_org
integer x = 2130
integer y = 676
integer width = 251
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Accept"
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

if rb_one.checked then
	debugbreak()
	//for each import record
	res = messagebox("Accepting matches","Do you wish to accept all import records that have a single match?",question!,yesno!,2 )
	if res = 2 then
		return
	else
		dw_import.accepttext()
		ec = dw_existing.rowcount()
		for i = ic to 1 step -1
			ll_id = dw_import.getitemnumber(i,"lookup_code")
			r = dw_existing.find("match_id = " + string(ll_id),1,ec )
			if r > 0 then
				of_accept(i,r,false)
				cnt++
			end if
		next
		dw_existing.update()
		messagebox("",string(cnt) + " records updated.")
	end if
elseif rb_manual.checked then
	if dw_existing.rowcount() > 0 then
		of_accept(dw_import.getrow(),dw_existing.getrow(),false)
		dw_existing.update()
	end if
elseif rb_none.checked then
	res = messagebox("Accepting matches","Do you wish to accept all unmatched import records as new lookup records?",question!,yesno!,2 )
	if res = 2 then
		return
	else
		dw_import.accepttext()
		for i = ic to 1 step -1
			ll_id = gnv_app.of_get_id( "record_id")
			r = dw_existing.insertrow(0)
			dw_existing.setitem(r,"lookup_code",ll_id)
			of_accept(i,r,true)
		next
		dw_existing.update()
	end if
	
end if
end event

type rb_manual from radiobutton within uo_caqh_import_org
integer x = 1280
integer y = 536
integer width = 274
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manual"
end type

event clicked;cb_run.enabled = false
end event

type rb_scan from radiobutton within uo_caqh_import_org
integer x = 1280
integer y = 348
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Full Scan"
boolean checked = true
end type

event clicked;cb_run.enabled = true
end event

type cb_run from commandbutton within uo_caqh_import_org
integer x = 937
integer y = 672
integer width = 251
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Scan"
end type

event clicked;string ls_file
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

//scan for matches
if rb_scan.checked or rb_rescan.checked then
	for i = 1 to ic
		ls_table = dw_list.getitemstring(i,"lookup_name")
		 if of_scan_table("S",ls_table) = -1 then
			return
		end if
	next
elseif rb_scant.checked then //scan table
	ls_table = dw_list.getitemstring(dw_list.getrow(),"lookup_name")
	of_scan_table("T",ls_table)
elseif rb_manual.checked and not rb_manview.checked then //manual for one record
	ls_table = dw_import.getitemstring(dw_import.getrow(),"lookup_name")
	of_find_match(dw_import.getrow(),ls_table)
	return
end if


messagebox("Record Scan","Scan Complete")
dw_import.setfilter("")
dw_import.filter()
dw_existing.setfilter("")
dw_existing.filter()


end event

type rb_start from radiobutton within uo_caqh_import_org
integer x = 2432
integer y = 408
integer width = 229
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start"
boolean checked = true
end type

type cbx_entity from checkbox within uo_caqh_import_org
integer x = 1710
integer y = 348
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Entity name"
boolean checked = true
end type

type cbx_zip from checkbox within uo_caqh_import_org
integer x = 1710
integer y = 568
integer width = 219
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zip"
boolean checked = true
end type

type cbx_city from checkbox within uo_caqh_import_org
integer x = 1710
integer y = 496
integer width = 215
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "City"
end type

type cbx_street from checkbox within uo_caqh_import_org
integer x = 1710
integer y = 416
integer width = 274
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Street"
boolean checked = true
end type

type sle_1 from singlelineedit within uo_caqh_import_org
integer x = 2153
integer y = 408
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
borderstyle borderstyle = stylelowered!
end type

type dw_existing from u_dw within uo_caqh_import_org
integer x = 32
integer y = 1456
integer width = 3465
integer height = 524
integer taborder = 10
string dataobject = "d_address_lookup_caqh"
boolean hscrollbar = true
end type

event clicked;call super::clicked;long r

r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event doubleclicked;call super::doubleclicked;cb_accept.triggerevent(clicked!)
end event

type st_1 from statictext within uo_caqh_import_org
integer x = 2139
integer y = 352
integer width = 247
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "# of Chars"
boolean focusrectangle = false
end type

type rb_mid from radiobutton within uo_caqh_import_org
integer x = 2697
integer y = 404
integer width = 224
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mid"
end type

type gb_2 from groupbox within uo_caqh_import_org
integer x = 2103
integer y = 300
integer width = 864
integer height = 200
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Entity/Description Match Parameters"
end type

type gb_3 from groupbox within uo_caqh_import_org
integer x = 1253
integer y = 300
integer width = 398
integer height = 364
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scan Method"
end type

type dw_1 from datawindow within uo_caqh_import_org
integer x = 27
integer y = 1552
integer width = 3159
integer height = 356
integer taborder = 40
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within uo_caqh_import_org
integer x = 3003
integer y = 4
integer width = 475
integer height = 660
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filter matches"
end type

type gb_5 from groupbox within uo_caqh_import_org
integer x = 32
integer y = 508
integer width = 818
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lookup Data Type"
end type

type dw_import from u_dw within uo_caqh_import_org
integer x = 27
integer y = 760
integer width = 3474
integer height = 620
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_caqh_import_addr"
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

if rb_manview.checked then
	ll_id = this.getitemnumber(r,"lookup_code")
	ll_find = dw_existing.find("match_id = " + string(ll_id),1,100000)
	if ll_find > 0 then
		dw_existing.scrolltorow(ll_find)
		dw_existing.setrow(ll_find)
	end if
end if
	
end event

event doubleclicked;call super::doubleclicked;debugbreak()
cb_run.triggerevent(clicked!)
end event

type gb_6 from groupbox within uo_caqh_import_org
integer x = 887
integer y = 300
integer width = 338
integer height = 364
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Steps"
end type

type gb_1 from groupbox within uo_caqh_import_org
integer x = 2103
integer y = 496
integer width = 864
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Update:"
end type

type gb_7 from groupbox within uo_caqh_import_org
integer x = 891
integer y = 4
integer width = 2075
integer height = 292
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Messages"
end type

type gb_8 from groupbox within uo_caqh_import_org
integer x = 1678
integer y = 300
integer width = 398
integer height = 364
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Match on:"
end type

