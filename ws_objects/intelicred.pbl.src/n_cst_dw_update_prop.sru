$PBExportHeader$n_cst_dw_update_prop.sru
$PBExportComments$[untilities] Used to determine if the access rights are valid for the paths for this user.
forward
global type n_cst_dw_update_prop from nonvisualobject
end type
end forward

global type n_cst_dw_update_prop from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_gettablekey (string as_table_name, ref string as_key[])
public function integer of_modifyupdateproperty (datastore ads_data, string as_table_name)
public function integer of_modifyupdateproperty (datawindow ads_data, string as_table_name)
public function integer of_modifyupdateproperty (datastore ads_data, string as_table_name, boolean ab_pref_table)
end prototypes

public function integer of_gettablekey (string as_table_name, ref string as_key[]);//////////////////////////////////////////////////////////////////////
// $<function> of_gettablekey
// $<arguments>
//			string		as_table_name
//			string		as_key[]
// $<returns> integer
// $<description> Get primary key fields
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.02.2009
//////////////////////////////////////////////////////////////////////

string ls_key
string ls_table_name
string ls_v1,ls_v2,ls_v3,ls_v4,ls_v5,ls_v6
integer li_v5

ls_table_name = Lower(as_table_name)

if gs_DBType = "ASA" then
	DECLARE cur_keys CURSOR FOR
		SELECT column_name = syscolumn.column_name
		FROM  syscolumn, systable
		WHERE syscolumn.table_id = systable.table_id AND
				systable.table_name = :ls_table_name AND
				syscolumn.pkey = 'Y';
	OPEN cur_keys;
	do while true
		FETCH cur_keys INTO :ls_key;
		if SQLCA.SQLCode = 0 then
			as_key[UpperBound(as_key[]) + 1] = ls_key
		else
			exit
		end if
	loop
	CLOSE cur_keys;
else
	//DECLARE lp_pkeys PROCEDURE FOR sp_pkeys(:ls_table_name);
	
	//---------Begin Modified by (Appeon)Stephen 01.23.2014 for Testing Bug 3852 Import fails to run with error "Failed to modify datawindow update properties."--------
	//DECLARE lp_pkeys PROCEDURE FOR sp_appeon_pkeys(:ls_table_name); //for a apb 60 bug - alfee 03.23.2010
	DECLARE lp_pkeys PROCEDURE FOR sp_appeon_pkeys :ls_table_name;
	//---------End Modfiied ------------------------------------------------------
	EXECUTE lp_pkeys;
	do while true
		FETCH lp_pkeys INTO :ls_v1, :ls_v2, :ls_v3, :ls_key, :li_v5, :ls_v6;
		if SQLCA.SQLCode = 0 then
			as_key[UpperBound(as_key[]) + 1] = ls_key
		else
			exit
		end if
	loop
	CLOSE lp_pkeys;
end if

Return UpperBound(as_key[])
end function

public function integer of_modifyupdateproperty (datastore ads_data, string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_modifyupdateproperty
// $<arguments>
//			datastore	ads_data
//			string		as_table_name
// $<returns> integer
// $<description> Modify datawindow update properties
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.02.2009
//////////////////////////////////////////////////////////////////////

string ls_key[]
string ls_Error
integer i, li_Count

//if AppeonGetClientType() = "WEB" then Return 1 - commented by Eugene 12.03.2013 for BugT112801.

// Checks updatetable property and get primary keys
ls_Error = ads_data.Describe("datawindow.table.updatetable")
if ls_Error = "?" or IsNull(ls_Error) or ls_Error = "" then
	if of_GetTableKey(as_table_name, ls_key[]) <= 0 then Return -1
else
	Return 1
end if

// Modify datawindow's update property
ads_data.Modify("datawindow.table.updatetable= '" + as_table_name + "'")

// Modify column's update property
li_Count = Integer(ads_data.Describe("datawindow.column.count"))
for i = 1 to li_Count
	ads_data.Modify("#" + String(i) + ".update = yes")
next

// Modify key field property
li_Count = UpperBound(ls_key[])
for i = 1 to li_Count
	ads_data.Modify(ls_key[i] + ".key = yes")
next

Return 1
end function

public function integer of_modifyupdateproperty (datawindow ads_data, string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_modifyupdateproperty
// $<arguments>
//			datastore	ads_data
//			string		as_table_name
// $<returns> integer
// $<description> Modify datawindow update properties
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.02.2009
//////////////////////////////////////////////////////////////////////

string ls_key[]
string ls_Error
integer i, li_Count

//if AppeonGetClientType() = "WEB" then Return 1 //Delete by Evan 05.17.2011

// Checks updatetable property and get primary keys
ls_Error = ads_data.Describe("datawindow.table.updatetable")
if ls_Error = "?" or IsNull(ls_Error) or ls_Error = "" then
	if of_GetTableKey(as_table_name, ls_key[]) <= 0 then Return -1
else
	Return 1
end if

// Modify datawindow's update property
ads_data.Modify("datawindow.table.updatetable= '" + as_table_name + "'")

// Modify column's update property
li_Count = Integer(ads_data.Describe("datawindow.column.count"))
for i = 1 to li_Count
	ads_data.Modify("#" + String(i) + ".update = yes")
next

// Modify key field property
li_Count = UpperBound(ls_key[])
for i = 1 to li_Count
	ads_data.Modify(ls_key[i] + ".key = yes")
next

Return 1
end function

public function integer of_modifyupdateproperty (datastore ads_data, string as_table_name, boolean ab_pref_table);//////////////////////////////////////////////////////////////////////
// $<function> of_modifyupdateproperty
// $<arguments>
//			datastore	ads_data
//			string		as_table_name
//			boolean     ab_pref_table - prefix of table name
// $<returns> integer
// $<description> Modify datawindow update properties for multi tables
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 03.23.2010
//////////////////////////////////////////////////////////////////////

string ls_key[]
string ls_Error, ls_ColName
integer i, li_Count

//if AppeonGetClientType() = "WEB" then Return 1

// Checks updatetable property and get primary keys
ls_Error = ads_data.Describe("datawindow.table.updatetable")
if ls_Error = "?" or IsNull(ls_Error) or ls_Error = "" then
	if of_GetTableKey(as_table_name, ls_key[]) <= 0 then Return -1
else
	Return 1
end if

// Modify datawindow's update property
ads_data.Modify("datawindow.table.updatetable= '" + as_table_name + "'")

// Modify column's update property
li_Count = Integer(ads_data.Describe("datawindow.column.count"))
for i = 1 to li_Count
	if ab_pref_table then //prefixed with table name
		ls_ColName = ads_data.Describe("#" + String(i) + ".name")
		if LeftA(Lower(ls_ColName), LenA(as_table_name) + 1) <> Lower(as_table_name) + "_" then continue
	end if	
	ads_data.Modify("#" + String(i) + ".update = yes")
next

// Modify key field property
li_Count = UpperBound(ls_key[])
for i = 1 to li_Count
	if ab_pref_table then ls_key[i] = as_table_name + "_" + ls_key[i] //prefixed with table name
	ads_data.Modify(ls_key[i] + ".key = yes")
next

Return 1
end function

on n_cst_dw_update_prop.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dw_update_prop.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

