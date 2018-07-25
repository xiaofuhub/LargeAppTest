$PBExportHeader$w_pending_changes_group.srw
forward
global type w_pending_changes_group from w_response
end type
type rb_1 from radiobutton within w_pending_changes_group
end type
type cb_1 from commandbutton within w_pending_changes_group
end type
type cb_save from commandbutton within w_pending_changes_group
end type
type cb_add from commandbutton within w_pending_changes_group
end type
type cb_close from commandbutton within w_pending_changes_group
end type
type dw_detail from u_dw within w_pending_changes_group
end type
type dw_browse from u_dw within w_pending_changes_group
end type
type gb_1 from groupbox within w_pending_changes_group
end type
type rb_2 from radiobutton within w_pending_changes_group
end type
end forward

global type w_pending_changes_group from w_response
integer width = 3954
integer height = 2576
string title = "Pending Record Changes"
long backcolor = 33551856
boolean ib_savestatus = true
rb_1 rb_1
cb_1 cb_1
cb_save cb_save
cb_add cb_add
cb_close cb_close
dw_detail dw_detail
dw_browse dw_browse
gb_1 gb_1
rb_2 rb_2
end type
global w_pending_changes_group w_pending_changes_group

type variables
Long il_loc_id
Long il_cur_pendingid
String is_type
Boolean ib_saved  //alfee 11.11.2013

n_ds in_loc
n_ds ids_fields_prop
end variables

forward prototypes
public function integer of_retrieve_loc (long al_loc_id)
public function integer of_save_pending ()
public function integer of_filter_status ()
public function boolean of_check_require ()
public function boolean of_compare_value (string as_oldvalue, string as_newvalue)
public function long of_get_pendingid (string as_table)
public function integer of_update_linkrecords (long al_gp_id, long al_row)
public function integer of_save_modifypendingbk ()
public function integer of_create_linkrecords (u_dw au_data, long al_pending_id, integer al_row)
public function integer of_set_modifyvalue (long al_row, long al_pendingid)
public function integer of_set_fieldenabled (boolean ab_enabled)
public function integer of_setbuttonenabled (boolean ab_enabled)
public function integer of_get_other_pendingids (ref long al_pending_ids[])
public function integer of_modify_updatestatus (integer ai_status)
end prototypes

public function integer of_retrieve_loc (long al_loc_id);//====================================================================
//$<Function>: of_retrieve_loc
//$<Arguments>:
// 	value    long    al_loc_id
//$<Return>:  integer
//$<Description>: get location data from 
//$<Author>: (Appeon) long.zhang 07.15.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i

long ll_row
long LL_COLUMN_COUNT

String ls_col_type
String ls_col_name


if not isvalid(in_loc) then
	in_loc = create n_ds
	in_loc.dataobject = "d_group_data_entry"
	in_loc.settransobject( sqlca)
	in_loc.retrieve( al_loc_id)
	if in_loc.rowcount( ) = 0 then
		return -1
	end if
end if

ll_row = dw_detail.insertrow( 0)
LL_COLUMN_COUNT =ids_fields_prop.rowcount( )

for i = 1 to LL_COLUMN_COUNT
	
	ls_col_name =  ids_fields_prop.getitemstring( i,'sys_fields_field_name')
	
	ls_col_type = 	ids_fields_prop.getitemstring( i,'sys_fields_field_type')
	
		choose case ls_col_type
			case "C"	
				dw_detail.setitem( ll_row,ls_col_name,in_loc.getItemString(1,ls_col_name))
			case "D"
				dw_detail.setitem( ll_row,ls_col_name,in_loc.getItemDateTime(1,ls_col_name))
			case else
				dw_detail.setitem( ll_row,ls_col_name,in_loc.getItemNumber(1,ls_col_name))	
		end choose

end for

//dw_detail.setitem( ll_row,'gp_id',al_loc_id) - commented by alfee 11.09.2013
dw_detail.setitem( ll_row,'effective_date',datetime(today(),now()))
//ib_add_pending = true
return 1

end function

public function integer of_save_pending ();//====================================================================
//$<Function>: of_save_pending
//$<Arguments>:
//$<Return>:  integer -1 do not need process ;
//							0 continue process
//							1 has been saved
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.23.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Dwitemstatus ldw_status
string ls_change_type
long ll_row
long ll_pending_id

ll_row = dw_detail.getrow()
ls_change_type = dw_detail.getitemstring( ll_row,'change_type')

choose case ls_change_type
	case "A"
		if not of_check_require() then return -1
		return 0
	case "D"		
		if not of_check_require() then return -1
		return 0
	case "M"
		if not of_check_require() then return -1
//		if of_save_modifypending() = -1 then return -1
	case else
		MessageBox("Require value","Require value missing for Change Type .Please select one")
		return -1
end choose

return 1
end function

public function integer of_filter_status ();//====================================================================
//$<Function>: of_filter_status
//$<Arguments>:
// 	value    integer    ai_status
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.23.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_condition
long ll_row

if rb_1.checked then
	ls_condition = 'pending_status=1'
else
	ls_condition = 'pending_status=0'
end if
ll_row = dw_browse.getrow( )

dw_browse.setfilter( ls_condition)
dw_browse.filter( )

if appeongetClientType() = "PB" then
	if ll_row = dw_browse.getrow( ) then
		dw_browse.event rowfocuschanged(dw_browse.getrow())
	end if
else// can not trigger rowfocuschanged event under web after setfilter
	dw_browse.event rowfocuschanged(dw_browse.getrow())
end if

if rb_1.checked then //added by long.zhang 11.11.2013 BugS092701 
	of_modify_updateStatus(0)
else
	of_modify_updateStatus(1)
end if

return 1

end function

public function boolean of_check_require ();//====================================================================
//$<Function>: of_check_require
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: Check require fields if change type is add
//$<Author>: (Appeon) long.zhang 07.24.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
string ls_text
string ls_col_type
string ls_fields[]
boolean lb_require

if dw_detail.accepttext( ) = -1 then return false

if dw_detail.getitemstring( dw_detail.getrow(),'change_type') = 'D' then
	ls_fields={'effective_date'}		
else
	ls_fields= {'street','street_2','city','active_status','state','zip','change_type','effective_date'}
end if

For i = 1 to UpperBound(ls_fields[])
	lb_require = false
	ls_col_type = dw_detail.describe(ls_fields[i] + '.Coltype' )
	
	if lower(left(ls_col_type,5)) = "char(" then
			if isNull(dw_detail.getItemString(dw_detail.getrow(),ls_fields[i]))  then lb_require = true
	elseif lower(left(ls_col_type,5)) = "datet" then		
		if isNull(dw_detail.getItemdatetime(dw_detail.getrow(),ls_fields[i]))  then lb_require = true
	else
			if isNull(dw_detail.getItemNumber(dw_detail.getrow(),ls_fields[i]))  then lb_require = true
	end if
	
	if lb_require then
		ls_text = dw_detail.describe(ls_fields[i] + '_t.Text' )
		MessageBox("Require value","Require value missing for "+ls_text+".Please enter a value")
		return false
	end if
end for

return true
end function

public function boolean of_compare_value (string as_oldvalue, string as_newvalue);//====================================================================
//$<Function>: of_compare_value
//$<Arguments>:
// 	value    string    as_oldvalue
// 	value    string    as_newvalue
//$<Return>:  boolean
//$<Description>: compare the old value and new value in dw_detail fields
//$<Author>: (Appeon) long.zhang 07.24.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if isNull(as_oldvalue) and isNull(as_newvalue) then
	return true
elseif not isNull(as_oldvalue) and not isNull(as_newvalue) then
	if as_oldvalue = as_newvalue then
		return true
	else
		return false
	end if
else
	return false
end if

return true
end function

public function long of_get_pendingid (string as_table);//====================================================================
//$<Function>: of_get_pendingid
//$<Arguments>:
//$<Return>:  long
//$<Description>: get primary key value
//$<Author>: (Appeon) long.zhang 07.23.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_pending_id
if as_table = "g" then
	select max(pending_id) into :ll_pending_id from group_change_pending;
else
	select max(pending_id) into :ll_pending_id from pd_address_change_pending;
end if

if isNull(ll_pending_id) then ll_pending_id =0

ll_pending_id++
//if as_table = 'g' then il_cur_pendingid = ll_pending_id
return ll_pending_id
end function

public function integer of_update_linkrecords (long al_gp_id, long al_row);//====================================================================
//$<Function>: of_update_linkrecords
//$<Arguments>:
// 	value    long    al_gp_id
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: update link records in pd_address_group_pending
//$<Author>: (Appeon) long.zhang 07.25.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_i
long ll_j
long LL_COLUMN_COUNT
String ls_col_name
String ls_col_type
Any la_value
datetime ldt_effective_date

n_ds ln_link_records

ln_link_records = create n_ds
ln_link_records.dataobject = "d_pd_address_pending"
ln_link_records.settransobject( sqlca)

if ln_link_records.retrieve( al_gp_id) <=0 then
	destroy ln_link_records
	return 1
end if

LL_COLUMN_COUNT = ids_fields_prop.rowcount( )

for ll_i = 1 to LL_COLUMN_COUNT
	
	ls_col_name =  ids_fields_prop.getitemstring( ll_i,'sys_fields_field_name')
			
	if dw_detail.getitemstatus( al_row, ls_col_name, primary!)	<> DataModified! then
		continue
	end if
	
	ls_col_type = ids_fields_prop.getitemstring( ll_i,'sys_fields_field_type')
	
	choose case ls_col_type
			case 'C'
				la_value = dw_detail.getitemstring( al_row, ls_col_name	)				
			case 'D'	
				la_value = dw_detail.getitemdatetime( al_row, ls_col_name	)				
			case else
				la_value = dw_detail.getitemnumber( al_row, ls_col_name	)				
		end choose
		
	for ll_j = 1 to ln_link_records.rowcount( )
			ln_link_records.setitem( ll_j,ls_col_name,la_value)
	end for
	
end for

if dw_detail.getitemstatus( al_row, 'effective_date', primary!)	= DataModified! then
	
	ldt_effective_date = dw_detail.getitemdatetime( al_row, 'effective_date')
	for ll_j = 1 to ln_link_records.rowcount( )
			ln_link_records.setitem( ll_j,'effective_date',ldt_effective_date)
	end for
	
end if

if ln_link_records.update() = -1 then
	MessageBox('Update Link','Unable to update link records')
	destroy ln_link_records
	return -1
end if

destroy ln_link_records
return 1
end function

public function integer of_save_modifypendingbk ();//====================================================================
//$<Function>: of_save_modifypending
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.24.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
long ll_row
long LL_COLUMN_COUNT
long ll_pending_id

string ls_col_name
string ls_col_type
string ls_old_value
string ls_new_value
string ls_lookup_field
datastore lds_pending
datetime ldt_date

ll_row = dw_detail.getrow()

lds_pending = create datastore
lds_pending.dataobject = "d_group_pending_browse"
lds_pending.settransobject( sqlca)
lds_pending.insertrow( 1)

LL_COLUMN_COUNT = ids_fields_prop.rowcount( )

for i = 1 to LL_COLUMN_COUNT
	
	ls_col_name = ids_fields_prop.getitemstring( i,'sys_fields_field_name')
	ls_col_type = ids_fields_prop.getitemstring( i,'sys_fields_field_type')
	ls_lookup_field = ids_fields_prop.getitemstring( i,'sys_fields_lookup_field')
	
	choose case ls_col_type
			case "C"	
				ls_old_value = in_loc.getItemString(1,ls_col_name)
				ls_new_value = dw_detail.getItemString(ll_row,ls_col_name)
			case "D"
				ls_old_value = string(in_loc.getItemDateTime(1,ls_col_name))
				ls_new_value = string(dw_detail.getItemDateTime(ll_row,ls_col_name))
			case else
				ls_old_value = string(in_loc.getItemNumber(1,ls_col_name))
				ls_new_value = string(dw_detail.getItemNumber(ll_row,ls_col_name))
		end choose
		
	if not of_compare_value(ls_old_value,ls_new_value) then
		if ls_col_type  = "D" then
				if isNull(ls_new_value) then
						lds_pending.setitem( 1,ls_col_name,ldt_date)	
				else
					lds_pending.setitem( 1,ls_col_name,dw_detail.getItemDateTime(ll_row,ls_col_name))
				end if	
			elseif 	ls_col_type  = "C" then
				lds_pending.setitem( 1,ls_col_name,ls_new_value)
			else
				if not isNull(ls_new_value) then
					lds_pending.setitem( 1,ls_col_name,dw_detail.getItemnumber(ll_row,ls_col_name))
				else
					lds_pending.setitem( 1,ls_col_name,0)
				end if
		end if
	
	end if
end for	

if lds_pending.getitemstatus( 1,0,Primary!) = NewModified! then
		ll_pending_id = of_get_pendingid('g')
		lds_pending.setitem(1,"create_date",datetime(today(),now()))
		lds_pending.setitem(1,"create_user",gs_user_id)
		lds_pending.setitem(1,"pending_id",ll_pending_id)
		lds_pending.setitem(1,"rec_id",il_loc_id)
		lds_pending.setitem(1,"effective_date",dw_detail.getItemDateTime(ll_row,"effective_date"))
		lds_pending.setitem(1,"change_type",dw_detail.getItemstring(ll_row,"change_type"))
		lds_pending.setitem(1,"gp_id",il_loc_id)
		if lds_pending.update( ) = -1 then
			MessageBox('Save Pending','Unable to save Data')
			rollback;
			destroy lds_pending
			return -1
		else
			commit;
		end if
//		of_create_linkrecords(lds_pending,ll_pending_id)
else
	MessageBox('Save Pending','No changes was made in detail data')
	destroy lds_pending
	return -1
end if

destroy lds_pending
return 1
end function

public function integer of_create_linkrecords (u_dw au_data, long al_pending_id, integer al_row);//====================================================================
//$<Function>: of_create_linkpending
//$<Arguments>:
// 	value    datastore    ad_data
// 	value    long         al_pending_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.24.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_i
long ll_prac_id
long ll_gp_id
long ll_pending_id
long ll_rec_id
string ls_find
datastore lds_link
datastore lds_link_pending

lds_link = create datastore
lds_link_pending = create datastore

lds_link.dataobject = "d_gp_pracs_update"
lds_link_pending.dataobject = "d_pd_address_pending"

lds_link.settransobject( sqlca)
lds_link_pending.settransobject( sqlca)

lds_link.retrieve(il_loc_id )

if lds_link.rowcount( ) = 0 then
	destroy lds_link
	destroy lds_link_pending
	return 1
end if

ll_pending_id = of_get_pendingid('p')

for ll_i = 1 to lds_link.rowcount( )
	ll_prac_id = lds_link.getitemnumber( ll_i,'prac_id')
	ll_rec_id = lds_link.getitemnumber( ll_i,'rec_id')
	if au_data.rowscopy(al_row,al_row,primary!,lds_link_pending,1,primary!) = -1 then
		MessageBox('rowscopy','Unable to create link pending records')
		destroy lds_link
		destroy lds_link_pending
		return -1
	end if
	lds_link_pending.setitem( 1, "prac_id",ll_prac_id)
	lds_link_pending.setitem( 1, "gp_id",al_pending_id)
	lds_link_pending.setitem( 1, "pending_id",ll_pending_id)
	lds_link_pending.setitem( 1, "rec_id",ll_rec_id)
	lds_link_pending.setitem( 1, "create_date",datetime(today(),now()))
	lds_link_pending.setitem( 1, "create_user",gs_user_id)
	ll_pending_id++
end for

if  lds_link_pending.update( ) = -1 then
	MessageBox('Create Failed','Unable to create link pending records, update failed')
	destroy lds_link
	destroy lds_link_pending
	return -1
end if

destroy lds_link
destroy lds_link_pending
return 1

end function

public function integer of_set_modifyvalue (long al_row, long al_pendingid);//====================================================================
//$<Function>: of_save_modifypending
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.24.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
long LL_COLUMN_COUNT
long ll_null

string ls_col_name
string ls_col_type
string ls_old_value
string ls_new_value
string ls_lookup_field
string ls_null

datetime ldt_date
datetime ldt_null

setNull(ll_null)
setNull(ls_null)
setNull(ldt_null)

LL_COLUMN_COUNT = ids_fields_prop.rowcount( )
dw_detail.setredraw( false)
for i = 1 to LL_COLUMN_COUNT
	
	ls_col_name = ids_fields_prop.getitemstring( i,'sys_fields_field_name')
	ls_col_type = ids_fields_prop.getitemstring( i,'sys_fields_field_type')
	ls_lookup_field = ids_fields_prop.getitemstring( i,'sys_fields_lookup_field')
	
	choose case ls_col_type
			case "C"	
				ls_old_value = in_loc.getItemString(1,ls_col_name)
				ls_new_value = dw_detail.getItemString(al_row,ls_col_name)
			case "D"
				ls_old_value = string(in_loc.getItemDateTime(1,ls_col_name))
				ls_new_value = string(dw_detail.getItemDateTime(al_row,ls_col_name))
			case else
				ls_old_value = string(in_loc.getItemNumber(1,ls_col_name))
				ls_new_value = string(dw_detail.getItemNumber(al_row,ls_col_name))
		end choose
		
	if not of_compare_value(ls_old_value,ls_new_value) then
		if ls_col_type  = "D" then
			if isNull(ls_new_value) then	dw_detail.setitem( al_row,ls_col_name,ldt_date)	
		elseif 	ls_col_type  = "C" then
			
		else
			if ls_lookup_field = 'Y' and isNull(ls_new_value) then
				dw_detail.setitem( al_row,ls_col_name,0)
			end if	
		end if
	else
			choose case ls_col_type 
				case 'D'
					dw_detail.setItem(al_row,ls_col_name,ldt_null)
				case 'C'
					dw_detail.setItem(al_row,ls_col_name,ls_null)
				case 'N'	
					dw_detail.setItem(al_row,ls_col_name,ll_null)
			end choose
	end if
end for	

	of_create_linkrecords(dw_detail,al_pendingid,al_row)
	dw_detail.setredraw( true)
return 1
end function

public function integer of_set_fieldenabled (boolean ab_enabled);
long ll_columncount

Integer i
Integer li_protect = 1

string ls_bgcolor = '14803425'
String ls_colname

if ab_enabled then
	li_protect = 0
	ls_bgcolor = '16777215'
end if

ll_columnCount = long(dw_detail.describe( 'Datawindow.Column.Count'))

dw_detail.setredraw( false)
For i = 1 to ll_columnCount
	ls_colname = dw_detail.Describe("#" +STRING(i) + ".Name")
	if dw_detail.Describe(ls_colname + '.ColType') <> '!' then
		
		if dw_detail.Describe(ls_colname + ".Edit.Style") <> '?' then
			dw_detail.modify( ls_colname + ".Background.Color='" + ls_bgcolor + "'")
			dw_detail.modify(  ls_colname +".protect="+String(li_protect))
		end if
	end if
end For
dw_detail.setredraw( true)

return 1
end function

public function integer of_setbuttonenabled (boolean ab_enabled);//====================================================================
//$<Function>: of_setbuttonenabled
//$<Arguments>:
// 	value    boolean    ab_enabled
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
cb_add.enabled = ab_enabled
cb_save.enabled = ab_enabled
//cb_1.enabled = ab_enabled
dw_detail.enabled = ab_enabled



return 1
end function

public function integer of_get_other_pendingids (ref long al_pending_ids[]);//====================================================================
//$<Function>: of_get_other_pendingids()
//$<Arguments>:
// 	value    long    al_pending_ids[]
//$<Return>:  integer
//$<Description>: Get new added pending ids with 'A' type
//$<Author>: (Appeon) Alfee 11.09.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_cnt, ll_row, i
Long ll_rec_id, ll_pending_id, ll_null_array []
String ls_change_type

al_pending_ids = ll_null_array 

//Find in Browse
ll_cnt = dw_browse.RowCount ()
FOR i = 1 TO ll_cnt
	ls_change_type = dw_browse.GetItemString(i, 'change_type')
	ll_rec_id = dw_browse.GetItemNumber(i, 'rec_id')
	ll_pending_id = dw_browse.GetItemNumber(i, 'pending_id')	

	IF Upper(ls_change_type) = 'A' AND IsNull (ll_rec_id) THEN
		al_pending_ids [UpperBound (al_pending_ids) + 1] = ll_pending_id 
	END IF	
NEXT

//Find in Detail
ll_row = dw_detail.GetRow ()
IF ll_row < 1 THEN RETURN 1

ll_rec_id = dw_detail.GetItemNumber(ll_row, 'rec_id')
ll_pending_id = dw_detail.GetItemNumber (ll_row, 'pending_id')
IF ll_pending_id > 0 AND IsNull (ll_rec_id) THEN
	IF ll_cnt > 0 THEN
		IF dw_browse.Find ('pending_id = ' + String(ll_pending_id), 1, ll_cnt) > 0 THEN RETURN 1		
	END IF
	al_pending_ids [UpperBound (al_pending_ids) + 1] = ll_pending_id 	
END IF

RETURN 1
end function

public function integer of_modify_updatestatus (integer ai_status);
//====================================================================
//$<Function>: of_modify_updateStatus
//$<Arguments>:
// 	value    integer    ai_status
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 11.11.2013 (V14.1 Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
dw_browse.modify( 'update_status.visible='+String(ai_status))
dw_browse.modify( 'update_status_t.visible='+String(ai_status))
dw_browse.modify( 'error_info.visible='+String(ai_status))
dw_browse.modify( 'error_info_t.visible='+String(ai_status))

return 1
end function

on w_pending_changes_group.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.cb_1=create cb_1
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.gb_1=create gb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.dw_browse
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.rb_2
end on

on w_pending_changes_group.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.gb_1)
destroy(this.rb_2)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.15.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_find_row

is_type = left(message.StringParm,1)
il_loc_id = long(MidA(message.StringParm,2))

ids_fields_prop = create datastore
ids_fields_prop.dataobject = 'd_sys_field_properties'
ids_fields_prop.settransobject( sqlca)
ids_fields_prop.retrieve(1,86)

if is_type = 'A' then	//add pending records
		//-------------appeon begin----------------------
		//<$>Modified:long.zhang 11.04.2013
		//<$>reason:Fix BugA110103 
		dw_browse.event pfc_retrieve()
		//of_retrieve_loc(il_loc_id)
		cb_add.postevent(clicked!)
		//-------------appeon End------------------------
else	//view pending records
	dw_browse.event pfc_retrieve()
//	of_filter_status()
	ll_find_row = dw_browse.find( "rec_id="+string(il_loc_id),1,dw_browse.rowcount())
	if ll_find_row > 0 then dw_browse.scrolltorow( ll_find_row)
end if	
end event

event close;call super::close;//====================================================================
//$<Event>: close
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.16.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if isvalid(in_loc) then destroy in_loc
if isvalid(ids_fields_prop) then destroy ids_fields_prop
end event

event pfc_save;//====================================================================
//$<Event>: pfc_save
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.25.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_rtn
long ll_row
ll_row = dw_detail.getrow( )
if ll_row = 0 then return -1

ib_saved = True //BugL111101 - alfee 11.11.2013

if dw_detail.getItemStatus(ll_row,0,Primary!)= NewModified! then//add pending records
	li_rtn = of_save_pending()
	if li_rtn = -1 then return -1
end if	

return super:: event pfc_save()
end event

type rb_1 from radiobutton within w_pending_changes_group
integer x = 480
integer y = 44
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Pending"
boolean checked = true
end type

event clicked;of_filter_status()
of_setbuttonenabled(true)



end event

type cb_1 from commandbutton within w_pending_changes_group
integer x = 2766
integer y = 16
integer width = 343
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.25.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_pending_id
long ll_count
long ll_row

ll_row = dw_browse.getrow( )
if ll_row = 0 then return

if MessageBox('Delete','Are you sure you want to delete this record?',Question!,YesNo! ,2) = 2 then return

setNull(ll_pending_id)

if dw_browse.getitemstring(dw_browse.getrow( ), 'change_type') = 'M' then
	ll_pending_id = dw_browse.getitemnumber(  dw_browse.getrow( ), 'pending_id')
	
	select count(*) into :ll_count from pd_address_change_pending where gp_id = :ll_pending_id;
	
	if ll_count > 0 then
		if MessageBox('Delete','There are '+String(ll_count)+' address pending record(s) connect to this record' + &
		'.~r~n delete this record will also delete them. Are you sure you really want to delete this record?',Question!,YesNo!,2) = 2 then
			return
		end if	
	end if
end if

dw_browse.deleterow( 0)

gnv_appeondb.of_startqueue( )

	if not isNull(ll_pending_id) then
		Delete from pd_address_change_pending where gp_id = :ll_pending_id;
	end if

	dw_browse.update( )

gnv_appeondb.of_commitqueue( )

if ll_row = dw_browse.getrow( ) then
	dw_browse.event rowfocuschanged(ll_row)
end if
end event

type cb_save from commandbutton within w_pending_changes_group
integer x = 2053
integer y = 16
integer width = 343
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.23.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row
long ll_old_pendingid,ll_new_pendingid

ll_row = dw_detail.getrow( )

if parent.event pfc_save( )	= 1 then
	
	ll_old_pendingid = il_cur_pendingid
	ll_new_pendingid = dw_detail.getitemnumber( ll_row,'pending_id')
	
	//Commented the if statement - alfee 11.09.2013
	//if ll_old_pendingid <> ll_new_pendingid then	//new added
		
		dw_browse.event pfc_retrieve()
		
		ll_row = dw_browse.find( 'pending_status=1 and pending_id='+String(ll_new_pendingid),1,dw_browse.rowcount() )
		
		if ll_row > 0 then
			dw_browse.event rowfocuschanged(ll_row)
		end if
		
	//end if

end if


end event

type cb_add from commandbutton within w_pending_changes_group
integer x = 2405
integer y = 16
integer width = 343
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;
dw_detail.reset( )
of_retrieve_loc(il_loc_id)
end event

type cb_close from commandbutton within w_pending_changes_group
integer x = 3557
integer y = 16
integer width = 343
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_detail from u_dw within w_pending_changes_group
integer x = 32
integer y = 472
integer width = 3890
integer height = 1964
integer taborder = 10
string dataobject = "d_group_pending_detail"
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.17.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.settransobject(sqlca)
this.post of_setdropdowncalendar(true)	//added by long.zhang v12.2 group location mini- painter
DataWindowChild dwchild



gnv_appeondb.of_startqueue( )


This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")


This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")


This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")


This.GetChild( "public_transportation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")


This.GetChild( "handicapped_access", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")


This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")

gnv_appeondb.of_commitqueue( )

This.GetChild( "state", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.InsertRow( 1 )

f_modify_group_detail_property(this)
end event

event rbuttondown;call super::rbuttondown;//====================================================================
//$<Event>: rbuttondown
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.17.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)
col = this.getclickedcolumn()
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" and lower(colname) <> 'effective_date' THEN
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.25.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long i
long ll_pending_id
long ll_null
string ls_changetype

setNull(ll_pending_id)
setNull(ll_null)

for i = 1 to this.rowcount( )
	
	if this.getitemstatus( i, 0,Primary!) = NewModified!  then
		
		ls_changetype = this.getitemstring( i,"change_type")
		
		if isNull(this.getItemNumber(i,"pending_id")) then
			if isNull(ll_pending_id) then ll_pending_id= of_get_pendingid('g')
			this.setitem( i,"pending_id",ll_pending_id)
		end if
		
		this.setitem( i,'rec_id',il_loc_id)
		
		if ls_changetype = "A" then
			this.setitem( i,"rec_id",ll_null)
		elseif ls_changetype = 'M' then	
			of_set_Modifyvalue(i,ll_pending_id)			
		end if	
		
		dw_detail.setitem(i,"create_date",datetime(today(),now()))
		dw_detail.setitem(i,"create_user",gs_user_id)
		ll_pending_id++
		
	elseif 	this.getitemstatus( i, 0,Primary!) = DataModified! and this.getitemstring( i,"change_type") = "M" then
		of_update_linkrecords(this.getitemnumber(i,'pending_id'),i)
		
		//-------------appeon begin----------------------
		//<$>Modified:long.zhang 11.04.2013
		//<$>reason:Fix BugA110103 
		if this.getitemstatus( i,'effective_date',primary!) = DataModified! then
			dw_browse.setitem( dw_browse.getrow(),'effective_date',this.getItemDateTime(i,'effective_date'))
			dw_browse.setitemstatus( dw_browse.getrow(),'effective_date',Primary!,NotModified!)
		end if
		//-------------appeon end----------------------
	end if

end for

return 1
end event

event buttonclicked;call super::buttonclicked;String	ls_Phone,ls_fax,ls_RetParm

This.AcceptText() 
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if
end event

event itemchanged;call super::itemchanged;Datetime ldt_date
if dwo.name = 'change_type' then
	if data = 'A' then
		if MessageBox('Change Type','Would you like to clear all data on this record?',Question!,YesNo!,1) = 1 then
			ldt_date = this.getitemdatetime( row,'effective_date')
			dw_detail.reset( )
			dw_detail.insertrow( 0)
			dw_detail.setitem( 1, 'effective_date',ldt_date)
			dw_detail.setitem( 1, 'change_type','A')
			//dw_detail.setitem( 1,'gp_id',il_loc_id) - Commented by alfee 11.09.2013
		end if
	end if
end if
end event

type dw_browse from u_dw within w_pending_changes_group
integer x = 41
integer y = 128
integer width = 3854
integer height = 316
integer taborder = 10
string dataobject = "d_group_pending_browse"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event pfc_retrieve;call super::pfc_retrieve;//Reconstructed by Alfee 11.09.2013

Long ll_rtn, ll_null, ll_pending_ids [] 

//Get new added pending records with 'A' type
of_get_other_pendingids(ll_pending_ids) 

IF UpperBound(ll_pending_ids) = 0 THEN 
	SetNull (ll_null)
	ll_pending_ids [1] = ll_null
END IF

ll_rtn = This.Retrieve(il_loc_id, ll_pending_ids) 

RETURN ll_rtn

//return this.retrieve( il_loc_id)

end event

event retrieveend;call super::retrieveend;//====================================================================
//$<Event>: retrieveend
//$<Arguments>:
// 	value    long    rowcount
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.25.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

of_filter_status()

end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.16.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//long ll_pending_id

if currentrow>0 then

	il_cur_pendingid = this.getitemnumber( currentrow, 'pending_id')
	dw_detail.retrieve( il_cur_pendingid)
	this.scrolltorow( currentrow)
	this.selectrow( 0,false)
	this.selectrow( currentrow,true)
else
	dw_detail.reset( )
end if

end event

type gb_1 from groupbox within w_pending_changes_group
integer x = 46
integer y = 4
integer width = 1193
integer height = 116
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Pending Status:"
end type

type rb_2 from radiobutton within w_pending_changes_group
integer x = 869
integer y = 44
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Applied"
end type

event clicked;of_filter_status()
of_setbuttonenabled(false)

end event

