$PBExportHeader$n_cst_dataflow.sru
forward
global type n_cst_dataflow from nonvisualobject
end type
end forward

global type n_cst_dataflow from nonvisualobject autoinstantiate
end type

type variables

integer ii_null[]
integer ii_df_ids[]
string is_token  = '%%' 
string is_args[] 
string is_null[]
string is_addtl_crit[] //addtl criterias for from table




end variables

forward prototypes
public function integer of_build_sql (datawindow adw_detail, integer ai_current_row, ref string as_sql_update, ref string as_sql_select)
public function integer of_build_sql (datastore ads_detail, integer ai_current_row, ref string as_sql_update, ref string as_sql_select)
public function integer of_df_update (string as_updatetype)
public function integer of_df_update ()
public function integer of_df_update (integer ai_df_ids[], string as_addtl_crit[])
public function integer of_set_data_flow (datawindow adw_detail, integer ai_table)
public function integer of_run_data_flow ()
public function integer of_init_data ()
public function string of_parse_args (string as_filter, string as_table)
public function long of_create_ds (datastore ads_update, string as_sql_select, string as_table, string as_field)
public function integer of_set_data_flow (n_ds adw_detail, integer ai_table)
end prototypes

public function integer of_build_sql (datawindow adw_detail, integer ai_current_row, ref string as_sql_update, ref string as_sql_select);//Create sql statements (select & update) - alfee 01.07.2010

integer li_rtn
string ls_Syntax, ls_ErrorText
datastore lds_detail

//Dynamic create datawindow
lds_detail = Create DataStore
ls_Syntax = adw_detail.object.datawindow.syntax
lds_detail.Create(ls_Syntax, ls_ErrorText)
adw_detail.ShareData(lds_detail)

//li_rtn = adw_detail.ShareData(lds_detail)

li_rtn = of_build_sql(lds_detail, ai_current_row, as_sql_update, as_sql_select)

destroy lds_detail
return li_rtn
end function

public function integer of_build_sql (datastore ads_detail, integer ai_current_row, ref string as_sql_update, ref string as_sql_select);//Create sql statements (select & update) - alfee 01.07.2010

long   i, ll_from_tableid, ll_to_tableid, ll_from_field, ll_to_field
string ls_update_type, ls_from_table, ls_from_field, ls_operator
string ls_from_value, ls_from_filter, ls_to_table, ls_to_field
string ls_to_value, ls_to_filter, ls_from_fieldtype, ls_to_fieldtype
string ls_addtl_crit

string ls_from_select, ls_from_where
string ls_to_select, ls_to_update, ls_to_where
//datetime ldt_current

as_sql_update = ""
as_sql_select = ""
if ai_current_row < 1 or ai_current_row > ads_detail.rowcount() then return 0

//get setting
ls_update_type = ads_detail.getitemstring(ai_current_row, 'update_type')
ll_from_tableid = ads_detail.getitemnumber(ai_current_row, 'from_table')
ll_from_field = ads_detail.getitemnumber(ai_current_row, 'from_field')
ls_operator = ads_detail.getitemstring(ai_current_row, 'from_operator')
ls_from_value = ads_detail.getitemstring(ai_current_row, 'from_value')
ls_from_filter = ads_detail.getitemstring(ai_current_row, 'from_filter')
ll_to_tableid = ads_detail.getitemnumber(ai_current_row, 'to_table')
ll_to_field = ads_detail.getitemnumber(ai_current_row, 'to_field')
ls_to_value = ads_detail.getitemstring(ai_current_row, 'to_value')
ls_to_filter = ads_detail.getitemstring(ai_current_row, 'to_filter')
if ads_detail.describe("from_addtl_crit.ColType") <> "!" then //for data modification
	ls_addtl_crit = ads_detail.getitemstring(ai_current_row, 'from_addtl_crit')
end if

ls_from_table = gnv_data.of_getitem('sys_tables', 'table_name', 'table_id = ' + string(ll_from_tableid))
ls_to_table = gnv_data.of_getitem('sys_tables', 'table_name', 'table_id = ' + string(ll_to_tableid))
ls_from_field = gnv_data.of_getitem('sys_fields', 'field_name', 'field_id = ' + string(ll_from_field) + ' and table_id = ' + string(ll_from_tableid))
ls_to_field = gnv_data.of_getitem('sys_fields', 'field_name', 'field_id = ' + string(ll_to_field) + ' and table_id = ' + string(ll_to_tableid))
ls_from_fieldtype = gnv_data.of_getitem('sys_fields', 'field_type', 'field_id = ' + string(ll_from_field) + ' and table_id = ' + string(ll_from_tableid))
ls_to_fieldtype = gnv_data.of_getitem('sys_fields', 'field_type', 'field_id = ' + string(ll_to_field) + ' and table_id = ' + string(ll_to_tableid))

//parse args in the to_filter
ls_to_filter = Trim(ls_to_filter)
if LenA(ls_to_filter) > 0 then
	if ls_from_table = ls_to_table then //a single table - alfee 03.03.2010
		ls_to_filter = of_parse_args(ls_to_filter, ls_from_table) 
	else
		ls_to_filter = of_parse_args(ls_to_filter, '') 
	end if
end if
	
//build sql for the from_table
//if upper(ls_update_type) = 'E' then
if upper(ls_update_type) = 'E' or  upper(ls_update_type) = 'P' then	//long.zhang 06.20.2012 V12.2 Privilege Suspension 
	ls_from_where = ls_from_table + '.' + ls_from_field + " < getdate()" 
	//ldt_current = datetime(today(), now())	
	//ls_from_where = ls_from_table + '.' + ls_from_field + " < convert(datetime, '" + string(ldt_current, 'yyyymmdd hh:mm:ss') + "', 120)" 
else
	ls_from_where = ls_from_table + '.' + ls_from_field + ' ' + ls_operator + ' ' //alfee 03.03.2010
	//Start Code Change ----01.25.2011 #V11 maha  - added null trap
	if upper(ls_from_value) = 'NULL' then
		ls_from_value = "NULL"
	else
		choose case upper(ls_from_fieldtype)
			case "I", 'N'
				//
			case "C"
				ls_from_value = "'" + ls_from_value + "'"
			case "D"	
					ls_from_value = " convert(datetime, '" + ls_from_value + "', 120)"
		end choose
	end if
	//End Code Change ----01.25.2011
	ls_from_where += ls_from_value
end if

if LenA(trim(ls_from_filter)) > 0 then
	if LenA(ls_from_where) > 0 then ls_from_where += '~r~n' + Space(11)+ ' and '
	ls_from_where += '( ' + ls_from_filter + ' )'
end if

if LenA(trim(ls_addtl_crit)) > 0 then
	if LenA(ls_from_where) > 0 then ls_from_where += '~r~n' + Space(11)+ ' and '
	ls_from_where += '( ' + ls_addtl_crit + ' )'	
end if

for i = 1 to upperbound(is_args)
	if i > 1 then ls_from_select +=", "
	ls_from_select += is_args[i] 	
next
if LenA(ls_from_select) < 1 then ls_from_select = " * "
if ls_from_table = ls_to_table then //a single table - alfee 03.02.2010
	ls_from_select = "Select * " + '~r~n' + "  From " + ls_from_table 
	ls_from_select += '~r~n' + " Where " + ls_from_where  
else	
	ls_from_select = "Select distinct " + ls_from_select + '~r~n' + Space(10) + " From " + ls_from_table 
	ls_from_select += '~r~n' + Space(9) + " Where " + ls_from_where  
end if	
	
//build upd sql for the to_table
ls_to_update = "Update " + ls_to_table + " Set " + ls_to_field + " = "
choose case upper(ls_to_fieldtype)
	case "I", 'N'
		// 
	case "C"
		ls_to_value = "'" + ls_to_value + "'"
	case "D"			
		ls_to_value = " convert(datetime, '" + ls_to_value + "', 120)"
end choose
ls_to_update += ls_to_value

if LenA(ls_to_filter) > 0 then 
	ls_to_where = ' ( ' + ls_to_filter + ' ) ~r~n   and (' 
else 
	ls_to_where = ' ( '  //alfee 03.02.2010
end if
ls_to_where += ls_to_table + "." + ls_to_field + " <> " + ls_to_value  + " or "
ls_to_where += ls_to_table + "." + ls_to_field + " is null )" 

if ls_from_table = ls_to_table then //a single table - alfee 03.02.2010
	ls_to_update += "~r~n" + Space(3) + " Where " + ls_from_where + "~r~n" + space(7) + " and " + ls_to_where
else
	ls_to_where = " Where " + ls_to_where
	ls_to_update += "~r~n" + "  From ( " + ls_from_select + "~r~n        ) from_table "
	ls_to_update += "~r~n" + ls_to_where 
end if
//debugbreak()
//build sel sql for the to_table
//ls_to_select = "Select " + ls_to_table + "." + ls_to_field 
if ls_from_table = ls_to_table then //a single table - alfee 03.02.2010
	ls_to_select = ls_from_select + "~r~n" + space(5) + " and " + ls_to_where
else
	ls_to_select = "Select " + ls_to_table + ".*" 
	ls_to_select += "~r~n  From ( " + ls_from_select + "~r~n        ) from_table, "  
	ls_to_select += "~r~n        " + ls_to_table + " "
	ls_to_select += "~r~n " + ls_to_where
end if

as_sql_update = ls_to_update
as_sql_select = ls_to_select

return 1
end function

public function integer of_df_update (string as_updatetype);//data flow update based on the specified update type - alfee 01.07.2010

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("data_flow", FALSE)
//------------------------------------------------------------------------
gnv_data.ids_dataflow.SetFilter("update_type = '" + upper(as_updatetype) + "'" )
gnv_data.ids_dataflow.Filter()

return of_df_update()
end function

public function integer of_df_update ();//data flow update - alfee 01.07.2010

integer res
long i, j, ll_rowcount, ll_to_table, ll_to_field, ll_seq_no, ll_rec, ll_pracid
string ls_sql_select, ls_sql_update
string ls_to_tablenm, ls_to_fieldnm, ls_to_type, ls_to_value, ls_old_value
string ls_recid_fieldnm = 'rec_id'
string ls_pracid_fieldnm = 'prac_id'
string ls_describe = ''
datetime ldt_value //maha 01.25.11

datastore lds_update, lds_audit

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("data_flow", FALSE)
//------------------------------------------------------------------------

ll_rowcount = gnv_data.ids_dataflow.rowcount()
if ll_rowcount < 1 then return 0

lds_update = create datastore 
lds_audit = create datastore 
lds_audit.dataobject = 'd_audit_update_batch'
lds_audit.SetTransObject(SQLCA)

select max(seq_no) into :ll_seq_no from sys_audit;
if isnull(ll_seq_no) then ll_seq_no = 0

//update for each df setting record
for i = 1 to ll_rowcount 
	lds_update.Reset()
	lds_audit.Reset()
	
	//build select sql
	of_build_sql(gnv_data.ids_dataflow, i, ls_sql_update, ls_sql_select)	
	if Isnull(ls_sql_select) or LenA(Trim(ls_sql_select)) < 1 then continue
debugbreak()
	ll_to_table   = gnv_data.ids_dataflow.GetItemNumber(i, "to_table")
	ll_to_field   = gnv_data.ids_dataflow.GetItemNumber(i, "to_field")
	ls_to_value   = gnv_data.ids_dataflow.GetItemString(i, "to_value")
	ls_to_tablenm = gnv_data.of_getitem("sys_tables", "table_name", "table_id = " + string(ll_to_table))
	ls_to_fieldnm = gnv_data.of_getitem("sys_fields", "field_name", "field_id = " + string(ll_to_field))
	ls_to_type    = gnv_data.of_getitem("sys_fields", "field_type", "field_id = " + string(ll_to_field))

	//create datastore
	if of_create_ds(lds_update, ls_sql_select, ls_to_tablenm, ls_to_fieldnm) < 1 then continue

	//Prefixed with table name for Web & multi tables' case  - alfee 03.23.2010
	if lds_update.describe(ls_to_tablenm + "_" + ls_to_fieldnm + ".ColType") <> "!" then  
		ls_to_fieldnm = ls_to_tablenm + "_" + ls_to_fieldnm
		ls_recid_fieldnm = ls_to_tablenm + "_" + ls_recid_fieldnm
		ls_pracid_fieldnm = ls_to_tablenm + "_" + ls_pracid_fieldnm
	end if

	//Set data for each record
	for j = 1 to lds_update.rowcount()
		//set data
		choose case upper(ls_to_type)
			
			case 'I' //, 'N' //Modified by Appeon long.zhang 12.15.2014 (rescript for type 'N' )
				ls_old_value = String(lds_update.GetItemNumber(j, ls_to_fieldnm))
				lds_update.SetItem(j, ls_to_fieldnm, Long(ls_to_value))
			case 'N' //added by Appeon long.zhang 12.15.2014 (Q on Data Flow updating the fee field on appointment's tab)
				ls_old_value = String(lds_update.GetItemNumber(j, ls_to_fieldnm))
 				ls_describe = ls_to_fieldnm +'.coltype'	
				ls_describe = lds_update.describe(ls_describe)
				If PosA(ls_describe ,'decimal(') > 0 then
					//get n from decimal(n)
					ls_describe = MidA(ls_describe, PosA(ls_describe ,'(') + 1 ,PosA(ls_describe ,')') - PosA(ls_describe ,'(') -1  )		
					lds_update.SetItem(j, ls_to_fieldnm, Round( Dec(ls_to_value), Long(ls_describe) ))
				Else
					lds_update.SetItem(j, ls_to_fieldnm, Long(ls_to_value))
				End If	 
			case 'C'
				//Start Code Change ----01.25.2011 #V11 maha 
				if upper(ls_to_value ) = "TODAY()" then
					ls_to_value = of_date_to_string(datetime(today(),now()),"mm/dd/yyyy")
				end if
				
				ls_old_value = lds_update.GetItemString(j, ls_to_fieldnm)				
				lds_update.SetItem(j, ls_to_fieldnm, ls_to_value)				
			case 'D'						
				if upper(ls_to_value ) = "TODAY()" then
					ldt_value = datetime(today(),time('00:00:00'))
				else
					ldt_value = datetime(date(ls_to_value),time('00:00:00'))
				end if
					
				ls_old_value = String(lds_update.GetItemDateTime(j, ls_to_fieldnm))
				//lds_update.SetItem(j, ls_to_fieldnm, datetime(date(ls_to_value),time('00:00:00')) )
				lds_update.SetItem(j, ls_to_fieldnm, ldt_value	)			
				//End Code Change ----01.25.2011
			case else //
				continue
		end choose	
		
		//add audit trail
		SetNull(ll_rec)
		SetNull(ll_pracid)
		if lds_update.describe(ls_recid_fieldnm+ ".ColType") <> "!" then ll_rec = lds_update.getitemnumber(j, ls_recid_fieldnm)
		if lds_update.describe(ls_pracid_fieldnm + ".ColType") <> "!" then ll_pracid = lds_update.getitemnumber(j, ls_pracid_fieldnm)		
		//if lds_update.describe("rec_id.ColType") <> "!" then ll_rec = lds_update.getitemnumber(j, "rec_id")
		//if lds_update.describe("prac_id.ColType") <> "!" then	ll_pracid = lds_update.getitemnumber(j, "prac_id")
		
		ll_seq_no ++
		lds_audit.insertrow(j)
		lds_audit.setitem(j, "rec_id", ll_rec)
		lds_audit.setitem(j, "prac_id", ll_pracid)			
		lds_audit.setitem(j, "seq_no", ll_seq_no)
		lds_audit.setitem(j, "table_id", ll_to_table)
		lds_audit.setitem(j, "field_id", ll_to_field)
		lds_audit.setitem(j, "old_value", ls_old_value)
		lds_audit.setitem(j, "new_value", ls_to_value)
		lds_audit.setitem(j, "user_id", gs_user_id)
		lds_audit.setitem(j, "date_time_modified", datetime(today(),now()))
		lds_audit.setitem(j, "audit_type", "DF")			
	next		

	//update data
	SQLCA.AutoCommit = false
	res = gnv_appeondb.of_update(lds_update, lds_audit)
	//messagebox("flow update",res)
	SQLCA.AutoCommit = true
next

destroy lds_update
destroy lds_audit

return 1
end function

public function integer of_df_update (integer ai_df_ids[], string as_addtl_crit[]);//data flow update based on the specified df ids and additional criterias 
//called by data modification - alfee 01.07.2010

integer i
long ll_cnt, ll_found
string ls_crit

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("data_flow", FALSE)
//------------------------------------------------------------------------
ll_cnt = gnv_data.ids_dataflow.rowcount()

for i = 1 to upperbound(ai_df_ids)
	if isnull(ai_df_ids[i]) then continue
	if i <> 1 then ls_crit += ", "
	ls_crit += string(ai_df_ids[i])

	//set additional criteria
	ll_found = gnv_data.ids_dataflow.Find("df_id =" + string(ai_df_ids[i]), 1, ll_cnt)
	if ll_found > 0 then
		gnv_data.ids_dataflow.SetItem(ll_found, 'from_addtl_crit', as_addtl_crit[i])
	end if
next

gnv_data.ids_dataflow.SetFilter("df_id in (" + ls_crit + ")")
gnv_data.ids_dataflow.Filter()

return of_df_update()
end function

public function integer of_set_data_flow (datawindow adw_detail, integer ai_table);//dataflow: set data flow for data modification before update - alfee 12.23.2009
//called in datawindow event of pfc_preupdate()

integer li_df_id 
long ll_fld_id, ll_prac_id, ll_cnt, i, j, k = 0 
string ls_filter, ls_from_table, ls_from_field
string ls_facility, ls_faci_spec, ls_facid_fldnm = 'facility_id'
string ls_prac_where[]  //maha 09.14.2017
string ls_facil_where[]  //maha 09.14.2017
string ls_where //maha 09.14.2017
integer p //maha 09.14.2017
boolean lb_found

ii_df_ids = ii_null 
is_addtl_crit = is_null
if adw_detail.modifiedcount() < 1 then return 0

//filter df records based on the current table
ls_from_table = gnv_data.of_getitem("sys_tables", "table_name", "table_id = " +string(ai_table))	
if ai_table = 43 then ls_facid_fldnm = 'parent_facility_id' //pd_affil_stat

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("data_flow", FALSE)
//------------------------------------------------------------------------

ls_filter = "update_type = 'D' and from_table = " + string(ai_table)
gnv_data.ids_dataflow.SetFilter(ls_filter)
if gnv_data.ids_dataflow.Filter() > 0 then 
	ll_cnt = gnv_data.ids_dataflow.rowcount()
end if
debugbreak()
//Start Code Change ----09.14.2017 #V16 maha - modifed for records for multiple providers
//for i = 1 to ll_cnt
//	//skip invalid df records
//	li_df_id  = gnv_data.ids_dataflow.getitemnumber(i, "df_id")
//	ll_fld_id = gnv_data.ids_dataflow.getitemnumber(i, "from_field")
//	ls_filter = "table_id = " + string(ai_table) +" and field_id = " + string(ll_fld_id)
//	ls_from_field = gnv_data.of_getitem('sys_fields', 'field_name', ls_filter )
//	ls_faci_spec  = gnv_data.of_getitem("sys_tables", "facility_specific", "table_id = " +string(ai_table))	
//
//	if isnull(ls_from_field) or LenA(trim(ls_from_field)) < 1 then continue
//	if adw_detail.describe(ls_from_field + ".ColType") = "!" then continue
//	
//	//keep the qualified df, prac & faci ids
//	lb_found = false
//	ls_facility = ""	
//	ll_prac_id = -1
//	for j = 1 to adw_detail.rowcount()
//		if adw_detail.getitemstatus(j, ls_from_field, primary!) = DataModified! then
//			lb_found = true
//			if ls_faci_spec = '1' then //facility specific
//				if LenA(ls_facility) > 1 then ls_facility += ", "
//				ls_facility += string(adw_detail.getitemnumber(j, ls_facid_fldnm))
//			end if				
//		end if
//	next
//	
//	if lb_found then
//		if adw_detail.describe("prac_id.ColType") <> "!" then
//			ll_prac_id = adw_detail.getitemnumber(1,"prac_id")
//		end if
//		k++
//		ii_df_ids[k] = li_df_id
//		is_addtl_crit[k] = ls_from_table + ".prac_id = " + String(ll_prac_id) 
//		if LenA(ls_facility) > 0 then 
//			is_addtl_crit[k] += " and " + ls_from_table + "." + ls_facid_fldnm + " in ( " + ls_facility + " )"
//		end if			
//	end if
//next

for i = 1 to ll_cnt 	//for each of the dataflows for that table
	//skip invalid df records
	li_df_id  = gnv_data.ids_dataflow.getitemnumber(i, "df_id")
	ll_fld_id = gnv_data.ids_dataflow.getitemnumber(i, "from_field")
	ls_filter = "table_id = " + string(ai_table) +" and field_id = " + string(ll_fld_id)
	ls_from_field = gnv_data.of_getitem('sys_fields', 'field_name', ls_filter )
	ls_faci_spec  = gnv_data.of_getitem("sys_tables", "facility_specific", "table_id = " +string(ai_table))	

	if isnull(ls_from_field) or LenA(trim(ls_from_field)) < 1 then continue
	if adw_detail.describe(ls_from_field + ".ColType") = "!" then continue
	
	//keep the qualified df, prac & faci ids
	lb_found = false
	ls_facility = ""	
	ll_prac_id = -1
	
	for j = 1 to adw_detail.rowcount()
		if adw_detail.getitemstatus(j, ls_from_field, primary!) = DataModified! then
			lb_found = true
			p++
			
			if adw_detail.describe("prac_id.ColType") <> "!" then
				ll_prac_id = adw_detail.getitemnumber(j,"prac_id")
			end if
			
			ls_prac_where[p] =  ls_from_table + ".prac_id = " + String(ll_prac_id) 
			
			if ls_faci_spec = '1' then //facility specific
				ls_facility = string(adw_detail.getitemnumber( j, ls_facid_fldnm))
				ls_facil_where[p] = ls_from_table + "." + ls_facid_fldnm + " = " + ls_facility 
			end if		
		end if
	next
	ls_where = "(  "
	
	for j = 1 to p
		ls_where+= "(( " + ls_prac_where[ j] + ")"
		
		if ls_faci_spec = '1' then 
			ls_where+= " AND ( " + ls_facil_where[p]  + ")"
		end if
		
		ls_where+= " )"
		
		if j < p then ls_where+= " OR "
	next
	
	ls_where+= " )"
 	
	//openwithparm(w_sql_msg, ls_where)
	if lb_found = true then k++
	ii_df_ids[k] = li_df_id
	is_addtl_crit[k]  = ls_where
next
//End Code Change ----09.14.2017

return 1
end function

public function integer of_run_data_flow ();//run data flows for data modification - alfee 01.07.2010
//called in datawindow event of pfc_postupdate()
//debugbreak()
if upperbound(ii_df_ids) > 0 then
	of_df_update(ii_df_ids, is_addtl_crit)
end if

return 1

end function

public function integer of_init_data ();//initialize instance variables - alfee 01.07.2010

ii_df_ids = ii_null
is_addtl_crit = is_null

return 1
end function

public function string of_parse_args (string as_filter, string as_table);//Replace arguments in the filter statement - alfee 01.07.2010

long ll_pos, ll_start, ll_end, ll_len_token, i
string ls_filter, ls_arg, ls_table = "from_table"
string ls_null[]

ll_len_token = LenA(is_token)
ls_filter = as_filter
is_args = ls_null //reset 
if LenA(as_table) > 0 then ls_table = as_table


Do 
	ll_pos = PosA(ls_filter, is_token)	
	if ll_pos > 0 then
		//keep argument
		ll_start = ll_pos + ll_len_token
		ll_end = PosA(ls_filter, ' ', ll_start) - 1
		if ll_end <= 0 then ll_end = LenA(ls_filter)
		if ll_end > ll_start then
			ls_arg = MidA(ls_filter, ll_start, ll_end - ll_start + 1)
			for i = 1 to upperbound(is_args)
				if lower(ls_arg) = lower(is_args[i]) then exit
			next
			if i = upperbound(is_args) + 1 then
				is_args[upperbound(is_args)+ 1] = ls_arg
			end if
		end if
		//replace argument
		ls_filter = ReplaceA(ls_filter, ll_pos, ll_len_token, ls_table + '.')
	end if	
Loop while (ll_pos > 0)

return ls_filter

end function

public function long of_create_ds (datastore ads_update, string as_sql_select, string as_table, string as_field);//Create the update datawindow dynamically - alfee 01.07.2010

long rc
string ERRORS, ls_dwsyntax_str
boolean lb_prefix_table = false

n_cst_dw_update_prop lnv_DwSyntax

ads_update.Reset()
ads_update.DataObject = ''

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(as_sql_select, '', ERRORS)
IF LenA(ERRORS) > 0 THEN	
	messagebox("Data Flow update SQL failed",ERRORS + "~r~r" + as_sql_select)//Start Code Change ----03.02.2010 #V10 maha
	RETURN -1
end if

ads_update.Create( ls_dwsyntax_str, ERRORS)
IF LenA(ERRORS) > 0 THEN RETURN -1

//determine if the field includes a table prefix - alfee 03.23.2010
if ads_update.describe(as_table + "_" + as_field + ".ColType") <> "!" then  
	lb_prefix_table = true
end if

//lnv_DwSyntax.of_ModifyUpdateProperty(ads_update, as_table)
lnv_DwSyntax.of_ModifyUpdateProperty(ads_update, as_table, lb_prefix_table) //alfee 03.23.2010
ads_update.modify("datawindow.table.UpdateWhere=0")

ads_update.settransobject(sqlca)
rc = ads_update.retrieve()

return rc




end function

public function integer of_set_data_flow (n_ds adw_detail, integer ai_table);//dataflow: set data flow for data modification before update - alfee 12.23.2009
//called in datawindow event of pfc_preupdate()
//Start Code Change ----09.14.2017 #V16 maha - data store version of same function

integer li_df_id 
long ll_fld_id, ll_prac_id, ll_cnt, i, j, k = 0 
string ls_filter, ls_from_table, ls_from_field
string ls_facility, ls_faci_spec, ls_facid_fldnm = 'facility_id'
string ls_prac_where[]  //maha 09.14.2017
string ls_facil_where[]  //maha 09.14.2017
string ls_where //maha 09.14.2017
integer p //maha 09.14.2017
boolean lb_found

ii_df_ids = ii_null 
is_addtl_crit = is_null
if adw_detail.modifiedcount() < 1 then return 0

//filter df records based on the current table
ls_from_table = gnv_data.of_getitem("sys_tables", "table_name", "table_id = " +string(ai_table))	
if ai_table = 43 then ls_facid_fldnm = 'parent_facility_id' //pd_affil_stat

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("data_flow", FALSE)
//------------------------------------------------------------------------

ls_filter = "update_type = 'D' and from_table = " + string(ai_table)
gnv_data.ids_dataflow.SetFilter(ls_filter)
if gnv_data.ids_dataflow.Filter() > 0 then 
	ll_cnt = gnv_data.ids_dataflow.rowcount()
end if

for i = 1 to ll_cnt 	//for each of the dataflows for that table
	//skip invalid df records
	li_df_id  = gnv_data.ids_dataflow.getitemnumber(i, "df_id")
	ll_fld_id = gnv_data.ids_dataflow.getitemnumber(i, "from_field")
	ls_filter = "table_id = " + string(ai_table) +" and field_id = " + string(ll_fld_id)
	ls_from_field = gnv_data.of_getitem('sys_fields', 'field_name', ls_filter )
	ls_faci_spec  = gnv_data.of_getitem("sys_tables", "facility_specific", "table_id = " +string(ai_table))	

	if isnull(ls_from_field) or LenA(trim(ls_from_field)) < 1 then continue
	if adw_detail.describe(ls_from_field + ".ColType") = "!" then continue
	
	//keep the qualified df, prac & faci ids
	lb_found = false
	ls_facility = ""	
	ll_prac_id = -1
	
	for j = 1 to adw_detail.rowcount()
		if adw_detail.getitemstatus(j, ls_from_field, primary!) = DataModified! then
			lb_found = true
			p++
			
			if adw_detail.describe("prac_id.ColType") <> "!" then
				ll_prac_id = adw_detail.getitemnumber(j,"prac_id")
			end if
			
			ls_prac_where[p] =  ls_from_table + ".prac_id = " + String(ll_prac_id) 
			
			if ls_faci_spec = '1' then //facility specific
				ls_facility = string(adw_detail.getitemnumber( j, ls_facid_fldnm))
				ls_facil_where[p] = ls_from_table + "." + ls_facid_fldnm + " = " + ls_facility 
			end if		
			
				

		end if
	next
	ls_where = "(  "
	
	for j = 1 to p
		ls_where+= "(( " + ls_prac_where[ j] + ")"
		
		if ls_faci_spec = '1' then 
			ls_where+= " AND ( " + ls_facil_where[p]  + ")"
		end if
		
		ls_where+= " )"
		
		if j < p then ls_where+= " OR "
	next
	
	ls_where+= " )"
 	
	//openwithparm(w_sql_msg, ls_where)
	if lb_found = true then k++
	ii_df_ids[k] = li_df_id
	is_addtl_crit[k]  = ls_where
	

next

return 1
end function

on n_cst_dataflow.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dataflow.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

