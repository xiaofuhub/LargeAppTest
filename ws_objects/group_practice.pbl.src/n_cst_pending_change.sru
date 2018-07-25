$PBExportHeader$n_cst_pending_change.sru
forward
global type n_cst_pending_change from nonvisualobject
end type
end forward

global type n_cst_pending_change from nonvisualobject
end type
global n_cst_pending_change n_cst_pending_change

type variables
datastore ids_group_pending
datastore ids_group_data
datastore ids_field
datastore ids_prac_associal

datastore ids_address_pending
datastore ids_address_data

pfc_n_cst_ai_action_items inv_action_items
pfc_cst_nv_data_entry_functions inv_data_entry


end variables

forward prototypes
public function integer of_run ()
public function integer of_run_group_pending ()
public function integer of_run_address_pending ()
public function integer of_getpendingdata ()
public function integer of_add_group (long al_row)
public function integer of_modify_group (long al_row)
public function integer of_delete_group (long al_row)
public function integer of_save_data ()
public function integer of_set_primarykey ()
public function long of_get_recid ()
private function integer of_updatefunctionfields (long al_row, integer ai_pending_status, integer ai_update_status, string as_error_info, boolean ab_group)
public function integer of_update_associafield (any aa_value, string as_type, string as_field)
public function integer of_update_associadata ()
public function integer of_checkassicialdata (long al_row)
public function integer of_add_address (long al_row)
public function integer of_modify_address (long al_row)
public function integer of_deleteaddress (long al_row)
public function string of_get_ref (string as_field_name, long al_row, ref boolean ab_lookupfield)
public function integer of_address_preupdate ()
public function integer of_add_address_link (long al_address_id, long al_prac_id)
public function long of_get_pending_record ()
public function string of_get_pending_msg ()
end prototypes

public function integer of_run ();//====================================================================
//$<Function>: of_run
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.08.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if of_getpendingdata() = -1 then return 1

of_run_group_pending()

of_run_address_pending()

of_save_data()

return 1
end function

public function integer of_run_group_pending ();//====================================================================
//$<Function>: of_run_group_pending
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_rowcount
Long ll_i
Long ll_rec_id[]
String ls_change_type

ll_rowcount = ids_group_pending.rowcount( )
if ll_rowcount = 0  then return 1

For ll_i = 1 to ll_rowcount
	ls_change_type = ids_group_pending.object.change_type[ll_i]
	choose case ls_change_type
		case 'A'
			of_add_group(ll_i)
		case 'M'
			of_modify_group(ll_i)
		case 'D'
			of_delete_group(ll_i)
	end choose
end for

return 1
end function

public function integer of_run_address_pending ();//====================================================================
//$<Function>: of_run_address_pending
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.13.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_rowcount
Long ll_i
Long ll_prac_id[]
long ll_rec_id[]
String ls_change_type

ll_rowcount = ids_address_pending.rowcount( )
if ll_rowcount = 0  then return 1

ll_prac_id[] = ids_address_pending.object.prac_id[1,ll_rowcount]
ll_rec_id[] = ids_address_pending.object.rec_id[1,ll_rowcount]

gnv_appeondb.of_startqueue( )

	if UpperBound(ll_prac_id[]) > 0 and UpperBound(ll_rec_id[]) > 0 then
		ids_address_data.retrieve(ll_prac_id[],ll_rec_id[])
	end if	
	
	ids_field.retrieve(1,2)
	
gnv_appeondb.of_commitqueue( )

//ids_field.setfilter( 'sys_fields_field_id<>30117 and sys_fields_field_id<>11223361')
ids_field.setfilter( 'sys_fields_field_id<>30117')//recover billing_address_id by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
ids_field.filter( )

For ll_i = 1 to ll_rowcount
	ls_change_type = ids_address_pending.object.change_type[ll_i]
	choose case ls_change_type
		case 'A'
			of_add_address(ll_i)
		case 'M'
			of_modify_address(ll_i)
		case 'D'
			of_deleteaddress(ll_i)
	end choose
end for

return 1
end function

public function integer of_getpendingdata ();//====================================================================
//$<Function>: of_getpendingdata
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_rec_id[]

ids_address_pending.dataobject = 'd_ds_address_pending'
ids_group_pending.dataobject = 'd_ds_group_pending'
ids_group_data.dataobject = 'd_group_data_entry_for_pt'
ids_field.dataobject = 'd_sys_field_properties'
ids_prac_associal.dataobject = 'd_gp_pracs_update'
ids_address_data.dataobject = 'd_pd_address_record'

ids_address_pending.settransobject( sqlca)
ids_group_pending.settransobject( sqlca)
ids_group_data.settransobject( sqlca)
ids_field.settransobject( sqlca)
ids_prac_associal.settransobject( sqlca)
ids_address_data.settransobject( sqlca)

gnv_appeondb.of_startqueue( )
	ids_address_pending.retrieve( )
	ids_group_pending.retrieve( )
	ids_field.retrieve(1,86 )
gnv_appeondb.of_commitqueue( )

ids_group_pending.setfilter("change_type<>'A'")
ids_group_pending.filter( )

if ids_group_pending.rowcount() > 0 then
	 ll_rec_id[] = ids_group_pending.object.rec_id[1,ids_group_pending.rowcount()]
	 if upperbound(ll_rec_id[]) > 0 then
			ids_group_data.retrieve( ll_rec_id[])
	 end if
end if
ids_group_pending.setfilter("")
ids_group_pending.filter( )

if ids_group_pending.rowcount( ) = 0 and ids_address_pending.rowcount( ) = 0 then
	return -1
end if



return 1
end function

public function integer of_add_group (long al_row);//====================================================================
//$<Function>: of_add_group
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_new_row
long ll_rowcount
Integer li_i
String ls_field_name
String ls_field_type
Any la_value

ll_new_row = ids_group_data.insertrow( 0)
ll_rowcount = ids_field.rowcount( )

for li_i = 1 to ll_rowcount
	ls_field_name = ids_field.getitemstring( li_i,'sys_fields_field_name')
	ls_field_type = ids_field.getitemstring( li_i,'sys_fields_field_type')
	
	if ids_group_pending.describe( ls_field_name+'.ColType') = '!' then continue
	
	choose case ls_field_type
		case 'N'
			la_value = ids_group_pending.getitemnumber( al_row,ls_field_name)
		case 'C'
			la_value = ids_group_pending.getitemstring( al_row,ls_field_name)
		case 'D'	
			la_value = ids_group_pending.getitemdatetime( al_row, ls_field_name)
	end choose
	ids_group_data.setitem( ll_new_row,ls_field_name,la_value)
end for
	
of_updatefunctionfields(al_row,0,1,'',true)
	
return 1
end function

public function integer of_modify_group (long al_row);//====================================================================
//$<Function>: of_modify_group
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_i
long ll_row
long ll_rec_id

String ls_field_name
String ls_field_type
String ls_lookup_field

any la_value
any la_oldvalue

ll_rec_id = ids_group_pending.getitemNumber( al_row,'rec_id')
ll_row = ids_group_data.find('rec_id='+String(ll_rec_id),1,ids_group_data.rowcount())

if ll_row <= 0 then
	of_updatefunctionfields(al_row,0,0,'Can not find specific record',true)
	return -1
end if

ids_prac_associal.retrieve( ll_rec_id )	

for ll_i = 1 to ids_field.rowcount( )
	
	ls_field_name = ids_field.getitemstring( ll_i,'sys_fields_field_name')
	ls_field_type = ids_field.getitemstring( ll_i,'sys_fields_field_type')
	ls_lookup_field = ids_field.getitemstring(ll_i,'sys_fields_lookup_field')
	if ids_group_pending.describe( ls_field_name + '.ColType') = '!' then continue
	choose case ls_field_type 
		case 'C'
			la_value = ids_group_pending.getitemstring( al_row,ls_field_name)
			
		case 'N'
			la_value = ids_group_pending.getitemNumber( al_row,ls_field_name)
			
		case 'D'
			la_value = ids_group_pending.getitemDateTime( al_row,ls_field_name)
			
	end choose
	if not isNull(la_value)  then
		if (ls_lookup_field = 'Y' and String(la_value) = '0') or (ls_field_type = 'D' and posA(String(la_value,'mm/dd/yyyy'),'01/01/1900') > 0)  then
			setNull(la_value)
		end if
		ids_group_data.setitem( ll_row,ls_field_name,la_value)
		of_update_associafield(la_value,ls_field_type,ls_field_name)
	end if
end for

of_updatefunctionfields(al_row,0,1,'',true)
of_update_associadata()

return 1
end function

public function integer of_delete_group (long al_row);//====================================================================
//$<Function>: of_delete_group
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.12.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>: delete group location data
//====================================================================
long ll_rec_id
long ll_row

if of_checkassicialdata(al_row) = -1 then return -1

ll_rec_id = ids_group_pending.getitemnumber( al_row,'rec_id')

ll_row = ids_group_data.find( 'rec_id='+String(ll_rec_id),1,ids_group_data.rowcount())

if ll_row <= 0 then
		of_updatefunctionfields(al_row,0,0,"Could not find the specific record.",true)
		return -1
end if

ids_group_data.deleterow( al_row)

of_updatefunctionfields(al_row,0,1,'',true)

return 1
end function

public function integer of_save_data ();//====================================================================
//$<Function>: of_save_data
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Save Data
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================


of_set_primarykey()
of_address_preupdate()

gnv_appeondb.of_startqueue( )
	ids_group_pending.update( )
	ids_address_pending.update()
	ids_group_data.update( )
	ids_address_data.update( )
gnv_appeondb.of_commitqueue( )

return 1
end function

public function integer of_set_primarykey ();//====================================================================
//$<Function>: of_set_primarykey
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_i
long ll_rec_id

ll_rec_id = of_get_recid()
for ll_i = 1 to ids_group_data.rowcount( )
	if not ids_group_data.getitemstatus( ll_i,0,primary!) = NewModified! then continue
	
	if isNull(ids_group_data.object.rec_id[ll_i]) then
			ids_group_data.object.rec_id[ll_i] = ll_rec_id
			ll_rec_id++
	end if
end for

return 1
end function

public function long of_get_recid ();//====================================================================
//$<Function>: of_get_recid
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_rec_id

select max(rec_id) into :ll_rec_id from group_practice;

if isNull(ll_rec_id) then ll_rec_id = 0

ll_rec_id++

return ll_rec_id

end function

private function integer of_updatefunctionfields (long al_row, integer ai_pending_status, integer ai_update_status, string as_error_info, boolean ab_group);//====================================================================
//$<Function>: of_updatefunctionfields
//$<Arguments>:
// 	value    long       al_row
// 	value    integer    ai_pending_status
// 	value    integer    ai_update_status
// 	value    string     as_error_info
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

datastore ld_pending

if ab_group then
	ld_pending = ids_group_pending
else
	ld_pending = ids_address_pending
end if

ld_pending.setitem( al_row,'push_date',datetime(today(),now()))
ld_pending.setitem( al_row,'pending_status',ai_pending_status)
ld_pending.setitem( al_row,'update_status',ai_update_status)

if not isNull(as_error_info) and trim(as_error_info) <> '' then
	ld_pending.setitem( al_row,'error_info',as_error_info)
end if

return 1
end function

public function integer of_update_associafield (any aa_value, string as_type, string as_field);//====================================================================
//$<Function>: of_update_associafield
//$<Arguments>:
// 	value    any       aa_value
// 	value    string    as_type
// 	value    string    as_field
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_i

if ids_prac_associal.rowcount( ) <= 0 then return 1

if ids_prac_associal.describe( as_field+'.Coltype') = '!' then 
	return -1
end if	

For ll_i = 1 to ids_prac_associal.rowcount( )
	ids_prac_associal.setitem( ll_i,as_field,aa_value)
end for

return 1
end function

public function integer of_update_associadata ();//====================================================================
//$<Function>: of_update_associadata
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.12.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_error_text


//lnv_data_entry = create pfc_cst_nv_data_entry_functions

inv_data_entry.of_field_audit( ids_prac_associal,ls_error_text)

ids_prac_associal.update( )

//destroy lnv_data_entry

return 1
end function

public function integer of_checkassicialdata (long al_row);//====================================================================
//$<Function>: of_checkassicialdata
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.12.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_prac_cnt
long ll_gp_id
long ll_loc_cnt

ll_gp_id = ids_group_pending.getitemnumber( al_row,'rec_id')
select count(gp_id) into :ll_prac_cnt from pd_address where gp_id = :ll_gp_id;

if ll_prac_cnt > 0 then
	of_updatefunctionfields(al_row,0,0,"There are " + string(ll_prac_cnt) + " address record(s) linked to this Practice Location.",true)
	return -1
end if

select count(loc_id) into :ll_loc_cnt from ctx_loc where loc_id = :ll_gp_id;
if ll_loc_cnt > 0 then
	of_updatefunctionfields(al_row,0,0,"There are " + string(ll_loc_cnt) + " Contract location record(s) linked to this Practice Location.",true)
	return -1
end if

return 1
end function

public function integer of_add_address (long al_row);//====================================================================
//$<Function>: of_add_address
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.13.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_new_row
long ll_rowcount
long ll_prac_id
Integer li_i
String ls_field_name
String ls_field_type
Any la_value

ll_new_row = ids_address_data.insertrow( 0)
ll_rowcount = ids_field.rowcount( )
ll_prac_id = ids_address_pending.getitemnumber( al_row,'prac_id')

for li_i = 1 to ll_rowcount
	ls_field_name = ids_field.getitemstring( li_i,'sys_fields_field_name')
	ls_field_type = ids_field.getitemstring( li_i,'sys_fields_field_type')
	
	if ids_address_pending.describe( ls_field_name + '.ColType') = '!' then continue
	
	choose case ls_field_type
		case 'N', 'l' //'l' Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
			la_value = ids_address_pending.getitemnumber( al_row,ls_field_name)
		case 'C'
			la_value = ids_address_pending.getitemstring( al_row,ls_field_name)
		case 'D'	
			la_value = ids_address_pending.getitemdatetime( al_row, ls_field_name)
	end choose
	ids_address_data.setitem( ll_new_row,ls_field_name,la_value)
end for

ids_address_data.setitem( ll_new_row,'prac_id',ll_prac_id)	

of_updatefunctionfields(al_row,0,1,'',false)

return 1
end function

public function integer of_modify_address (long al_row);//====================================================================
//$<Function>: of_modify_address
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.13.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_i
long ll_row
long ll_prac_id
long ll_rec_id
String ls_field_name
String ls_field_type
String ls_lookup_field
any la_value
any la_oldvalue

ll_rec_id = ids_address_pending.getitemNumber( al_row,'rec_id')
ll_prac_id = ids_address_pending.getitemnumber( al_row,'prac_id')

ll_row = ids_address_data.find('rec_id='+String(ll_rec_id)+' and prac_id='+String(ll_prac_id),1,ids_address_data.rowcount())

if ll_row <= 0 then
	of_updatefunctionfields(al_row,0,0,'Can not find specific record',false)
	return -1
end if


for ll_i = 1 to ids_field.rowcount( )
	
	ls_field_name = ids_field.getitemstring( ll_i,'sys_fields_field_name')
	
	if ids_address_pending.describe( ls_field_name+'.ColType') = '!' then continue
	
	ls_field_type = ids_field.getitemstring( ll_i,'sys_fields_field_type')
	
	ls_lookup_field = ids_field.getitemstring( ll_i,'sys_fields_lookup_field')
	
	choose case ls_field_type 
		case 'C'
			la_value = ids_address_pending.getitemstring( al_row,ls_field_name)
		case 'N', 'l' //'l' Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
			la_value = ids_address_pending.getitemNumber( al_row,ls_field_name)
		case 'D'
			la_value = ids_address_pending.getitemDateTime( al_row,ls_field_name)
	end choose
	if not isNull(la_value)  then
		if (ls_lookup_field = 'Y' and String(la_value) = '0') or (ls_field_type = 'D' and posA(String(la_value,'mm/dd/yyyy'),'01/01/1900') > 0)  then
			setNull(la_value)
		end if
		ids_address_data.setitem( ll_row,ls_field_name,la_value)
	end if
end for

of_updatefunctionfields(al_row,0,1,'',false)

return 1
end function

public function integer of_deleteaddress (long al_row);//====================================================================
//$<Function>: of_deleteaddress
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.13.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_rec_id
long li_cnt1
long li_cnt
long ll_prac_id
long ll_row

ll_rec_id = ids_address_pending.getitemnumber( al_row,'rec_id')
ll_prac_id = ids_address_pending.getitemnumber( al_row,'prac_id')

ll_row = ids_address_data.find( 'prac_id='+String(ll_prac_id)+' and rec_id='+String(ll_rec_id),1,ids_address_data.rowcount())

if ll_row <= 0 then
	of_updatefunctionfields(al_row,0,0,'Can not find specific record',false)
	return -1
end if


gnv_appeondb.of_startqueue( )
	select count(rec_id) into :li_cnt1 from pd_images where rec_id = :ll_rec_id;
	
 	SELECT Count( rec_id )  
	INTO :li_cnt  
     FROM verif_info  
     WHERE verif_info.rec_id = :ll_rec_id   ;	
gnv_appeondb.of_commitqueue( )

if li_cnt1 > 0 then
	of_updatefunctionfields(al_row,0,0,'There is an image record associated with this data record.  It must be deleted from the image tab before deleting the data record or the tif file will be out of sync with the imade data.',false)
	return -1
end if

if li_cnt > 0 then
	of_updatefunctionfields(al_row,0,0,'There are verification records associated with this record,can not delete',false)
	return -1
end if
inv_data_entry.of_field_audit_delete_last( ids_address_data,ll_row)
ids_address_data.deleterow( ll_row)

gnv_appeondb.of_startqueue( )
	delete from pd_app_audit_temp where de_rec_id = :ll_rec_id;
	delete from pd_app_audit where de_rec_id = :ll_rec_id;
	update net_dev_ids set address_id = null where address_id = :ll_rec_id; 
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 03.16.2015
	//<$>reason:Requesting new V14.2 Web Package
	//update net_dev_ids set address_id = null where address_id = :ll_rec_id;
	update net_dev_ids set address_id = 0 where address_id = :ll_rec_id;
	//------------------- APPEON END -------------------
	
	delete from pd_address_link where address_id = :ll_rec_id;
gnv_appeondb.of_commitqueue( )


return 1
end function

public function string of_get_ref (string as_field_name, long al_row, ref boolean ab_lookupfield);//====================================================================
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

ll_row = ids_field.find( "lower(sys_fields_field_name)='"+ lower(as_field_name) +"'", 1,ids_field.rowcount())
if ll_row <= 0 then return ''

if ids_field.getitemstring( ll_row,'sys_fields_lookup_field') = 'Y' then
	ab_lookupfield = true
	ll_lookup_code = ids_address_data.getitemnumber( al_row,as_field_name)
	
	if ids_field.getitemstring( ll_row,'sys_fields_lookup_type') = 'C' then
			ls_table_name = 'code_lookup'
		else
			ls_table_name = 'address_lookup'
	end if
	
	 choose case lower(ids_field.getitemstring( ll_row,'sys_fields_lookup_field_name'))
		case 'code'
			ls_field_value = gnv_data.of_getitem( ls_table_name,'code','lookup_code='+String(ll_lookup_code))
		case 'description'
			ls_field_value = gnv_data.of_getitem( ls_table_name,'description','lookup_code='+String(ll_lookup_code))
		case 'entity_name','entity_name_original'	
			ls_field_value = gnv_data.of_getitem( ls_table_name,'entity_name','lookup_code='+String(ll_lookup_code))
	 end choose
	 
else
	choose case ids_field.getitemstring( ll_row,'sys_fields_field_type')
		case 'N'
			ls_field_value = String(ids_address_data.getitemnumber( al_row,as_field_name))
		case 'D'
			ls_field_value = String(ids_address_data.getitemdatetime( al_row,as_field_name),'mm/dd/yyyy')
		case else
			ls_field_value = ids_address_data.getitemstring( al_row,as_field_name)
	end choose
end if

if isNull(ls_field_value) then ls_field_value = ''

return ls_field_value
end function

public function integer of_address_preupdate ();//====================================================================
//$<Function>: of_address_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.14.2013 (V14.1Group Location Effective Dates)
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
string ls_imp_value
string ls_imp_field_name
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
long ll_min_rec_id
long ll_max_rec_id
long ll_address_code
long ll_verif_response
long ll_table_id
long i, ll_Row
long ll_FindRow
long ll_RowCount
long ll_ImportDataRow
long ll_CacheCounter
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

ll_FindRow = lds_dataview_screen.find( 'screen_id=2',1,lds_dataview_screen.rowcount())
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

ll_RowCount = ids_address_data.rowcount( )

//if ids_address_data.Describe(ls_ref_1 + ".ColType") = "!" then
//		//of_log(ll_ImportDataRow, "", IL_ERRTYPE_ADDVERIFY, "01-Required Field '" + ls_ref_1 + "' is invalid")
//		Return -1
//end if

For ll_row = 1 to ids_address_data.rowcount( )
	if ids_address_data.getitemstatus( ll_row,0,primary!) = NewModified! then
		ll_newcnt ++
	end if
end for

if ll_newcnt > 0 then
	ll_rec_id_new = gnv_app.of_Get_Id("RECORD_ID" , ll_newcnt) - 1
	If ll_rec_id_new < 0 Then //Added By Ken.Guo 04.24.2008.
//		Messagebox('Error','Failed to get Record_ID value, Please call support.')
//		SetRedraw( True ) 
		Return -1
	End If
end if

for ll_row = 1 to ll_RowCount
		SetNull( ll_address_code )
	ldw_status = ids_address_data.getitemstatus(ll_row,0,Primary!)	
 	if ldw_status <> DataModified! and ldw_status <> NewModified! then
		continue
	elseif ldw_status = NewModified! then
			ls_rec_status = "New"
			ll_rec_id_new++
			ids_address_data.setitem( ll_row,'rec_id', ll_rec_id_new)
			 ll_prac_id = ids_address_data.getitemnumber( ll_row,'prac_id')
			of_add_address_link(ll_rec_id_new,ll_prac_id)			
	else
			ls_rec_status = "Modified"
	end if
	 
	 ll_rec_id = ids_address_data.getitemnumber( ll_row,'rec_id')
	 ll_prac_id = ids_address_data.getitemnumber( ll_row,'prac_id')
	 
	 if ids_address_data.getitemnumber( ll_row,'active_status') < 1 then
		if ls_rec_status = "New" then
					CONTINUE
		else
			update verif_info
			set active_status = 0
			where rec_id = :ll_rec_id and prac_id = :ll_prac_id and active_status = 1;
			continue		
		end if
	 end if
if ls_rec_status = "Modified"  then	 // update verif into record
	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN
			if LenA(ls_exp_field) > 0 then
				if ls_exp_field = "certification_expires" then				
					ldt_exp_date = DateTime(Date(String(ids_address_data.GetItemNumber(ll_Row, ls_exp_field)) + "-12-30"),Now())
				elseif ls_exp_field = "cert_expiration_year" then
					li_month = ids_address_data.GetItemNumber(ll_Row, "cert_expiration_month")
					if IsNull(li_month) then
						ldt_exp_date = DateTime(Date(String(ids_address_data.GetItemNumber(ll_Row, ls_exp_field)) + "-12-30"),Now())
					else
						ldt_exp_date = DateTime(Date(String(ids_address_data.GetItemNumber(ll_Row, ls_exp_field)) + "-" + String(li_month) + "-28"),Now())
					end if
				else
					if ids_address_data.Describe(ls_exp_field + ".ColType") <> "!" then
						ldt_exp_date = ids_address_data.GetItemDateTime(ll_Row, ls_exp_field)	
					else				
						//of_log(ll_ImportDataRow, "", IL_ERRTYPE_ADDVERIFY, "02-Required Field '" + ls_exp_field + "' is invalid")
						Return -1
					end if
				end if
			else
				SetNull(ldt_exp_date)
			end if
	end if		
	
		//get reference  data 	
		boolean lb_lookup = false
		ls_reference = of_get_ref(ls_ref_1,ll_row,lb_lookup)
		if lb_lookup then
			if ls_type1 = 'C' then
				ll_address_code = Long(ids_address_data.getitemstring( ll_row,ls_ref_1))
			elseif 	ls_type1 = 'N' then
				ll_address_code = ids_address_data.getitemnumber( ll_row,ls_ref_1)
			end if
		end if
		ls_reference += '-'
		
		ls_reference += of_get_ref(ls_ref_2,ll_row,lb_lookup)
		
		if ids_address_data.Describe("active_status" + ".ColType") <> "!" then //if active status exists
			li_dstatus = ids_address_data.GetItemnumber(ll_Row, "active_status")
		else
			setnull(li_dstatus)
		end if				
		inv_action_items.of_update_reference( ls_reference, ll_rec_id,ll_address_code,ldt_exp_date,li_screen_id,li_dstatus,ll_ver_method)
		
	else	//do nothing
		
	end if
		
	
	yield()
next

String ls_error_text
inv_data_entry.of_field_audit( ids_address_data,ls_error_text)

return 1
end function

public function integer of_add_address_link (long al_address_id, long al_prac_id);//====================================================================
//$<Function>: of_add_address_link
//$<Arguments>:
// 	value    long    al_address_id
// 	value    long    al_prac_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.14.2013 (V14.1Group Location Effective Dates)
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

public function long of_get_pending_record ();//====================================================================
//$<Function>: of_get_pending_record
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 11.01.2013 (//V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

return (ids_group_pending.rowcount( ) + ids_address_pending.rowcount( ))
end function

public function string of_get_pending_msg ();//====================================================================
//$<Function>: of_get_pending_msg
//$<Arguments>:
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) long.zhang 11.01.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
return ''
end function

on n_cst_pending_change.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_pending_change.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ids_group_pending = create datastore
ids_address_pending = create datastore
ids_group_data = create datastore
ids_field = create datastore
ids_prac_associal = create datastore
ids_address_data = create datastore

inv_action_items = create pfc_n_cst_ai_action_items
inv_data_entry = create pfc_cst_nv_data_entry_functions
end event

event destructor;//====================================================================
//$<Event>: destructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.09.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
destroy ids_group_pending
destroy ids_address_pending
destroy ids_group_data
destroy ids_field
destroy ids_prac_associal
destroy ids_address_data

destroy inv_action_items
destroy inv_data_entry
end event

