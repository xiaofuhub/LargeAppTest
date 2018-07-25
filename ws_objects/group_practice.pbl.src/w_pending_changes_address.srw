$PBExportHeader$w_pending_changes_address.srw
forward
global type w_pending_changes_address from w_response
end type
type rb_2 from radiobutton within w_pending_changes_address
end type
type rb_1 from radiobutton within w_pending_changes_address
end type
type dw_date_range from u_dw within w_pending_changes_address
end type
type cb_reset from commandbutton within w_pending_changes_address
end type
type cb_filter from commandbutton within w_pending_changes_address
end type
type dw_type from u_dw within w_pending_changes_address
end type
type cbx_all from checkbox within w_pending_changes_address
end type
type tab_1 from tab within w_pending_changes_address
end type
type tabpage_1 from userobject within tab_1
end type
type dw_browse from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_browse dw_browse
end type
type tabpage_2 from userobject within tab_1
end type
type dw_1 from u_dw within tabpage_2
end type
type dw_detail from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_1 dw_1
dw_detail dw_detail
end type
type tab_1 from tab within w_pending_changes_address
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_delete from commandbutton within w_pending_changes_address
end type
type cb_save from commandbutton within w_pending_changes_address
end type
type cb_add from commandbutton within w_pending_changes_address
end type
type cb_close from commandbutton within w_pending_changes_address
end type
type dw_addresses from u_dw within w_pending_changes_address
end type
type gb_status from groupbox within w_pending_changes_address
end type
type gb_date from groupbox within w_pending_changes_address
end type
type gb_type from groupbox within w_pending_changes_address
end type
type gb_filter from groupbox within w_pending_changes_address
end type
end forward

global type w_pending_changes_address from w_response
integer width = 3291
integer height = 2496
string title = "Pending Record Changes"
long backcolor = 33551856
boolean ib_savestatus = true
rb_2 rb_2
rb_1 rb_1
dw_date_range dw_date_range
cb_reset cb_reset
cb_filter cb_filter
dw_type dw_type
cbx_all cbx_all
tab_1 tab_1
cb_delete cb_delete
cb_save cb_save
cb_add cb_add
cb_close cb_close
dw_addresses dw_addresses
gb_status gb_status
gb_date gb_date
gb_type gb_type
gb_filter gb_filter
end type
global w_pending_changes_address w_pending_changes_address

type variables
Integer ii_status = 1
Long il_loc_id
Long il_data_view_id
Long il_cur_pendingid

String is_type
String is_lookup_search_column= "None"
String is_lookup_search_column_table = ""
String is_org_sql //alfee 11.09.2013

Boolean ib_add_pending = false
Boolean ib_all_pracs = False //alfee 11.09.2013

n_ds in_fields_prop

pfc_cst_u_data_entry iu_data_entry
pfc_cst_nv_data_entry_functions inv_data_entry
end variables

forward prototypes
public function integer of_create_dynamic_dw ()
public function integer of_filter_status ()
public function integer of_modify_functionfield ()
public function integer of_retrieve_record ()
public function long of_get_pendingid ()
public function integer of_modify_status (integer ai_status)
public function boolean of_check_require ()
public function boolean of_compare_value (string as_oldvalue, string as_newvalue)
public function integer of_lookup_search_dddw (string as_type)
public function integer of_check_save ()
public function integer of_set_browseenabled (boolean ab_enabled)
public function integer of_save_modify_bk ()
public function integer of_set_modifyvalue (long al_row, ref boolean ab_discard)
public function integer of_find_address ()
public function integer of_set_fieldenabled (boolean ab_enabled)
public function integer of_fill_address (long al_rec_id)
public function integer of_create_fields_data ()
public function integer of_clear_data (long al_row)
public function integer of_filter_data ()
public function integer of_retrieve_detail (long al_pending_id)
public function integer of_set_changetype (long al_row)
public function integer of_modify_updatestatus (integer ai_status)
end prototypes

public function integer of_create_dynamic_dw ();//====================================================================
//$<Function>: of_create_dynamic_dw
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.26.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_dwsyntax_str 
String s_presentation_str
String ls_background
String ls_grey
Long ll_cur_row


ll_cur_row = iu_data_entry.dw_select_section.getrow( )
il_data_view_id = iu_data_entry.dw_select_section.getitemnumber( ll_cur_row, 'data_view_id')

//inv_data_entry.of_create_dynamic_dw_pending( iu_data_entry.il_prac_id, il_data_view_id,iu_data_entry.ii_screen_id,tab_1.tabpage_2.dw_detail, tab_1.tabpage_1.dw_browse, iu_data_entry.ib_screen_painter, iu_data_entry.ii_parent_facility_id, false,iu_data_entry.il_rec_id)
inv_data_entry.of_create_dynamic_dw_pending( iu_data_entry.il_prac_id, il_data_view_id,iu_data_entry.ii_screen_id,tab_1.tabpage_2.dw_detail, tab_1.tabpage_2.dw_detail, iu_data_entry.ib_screen_painter, iu_data_entry.ii_parent_facility_id, false) //alfee 11.09.2013

of_modify_functionField()

tab_1.tabpage_2.dw_detail.SetTransObject (SQLCA)
is_org_sql = tab_1.tabpage_2.dw_detail.GetSqlSelect () //alfee 11.09.2013

//of_filter_status() - commented by alfee 11.09.2013

return 1
end function

public function integer of_filter_status ();//====================================================================
//$<Function>: of_filter_status
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.14.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================




string ls_filter
long ll_row
long ll_rowcount


ls_filter = 'pending_status='+String(ii_status)

tab_1.tabpage_1.dw_browse.setfilter( ls_filter)
tab_1.tabpage_1.dw_browse.filter( )

if tab_1.tabpage_1.dw_browse.rowcount( ) = 0 then
		tab_1.tabpage_2.dw_1.reset( )
	else 
		if tab_1.tabpage_2.dw_1.rowcount( ) = 0 then
			tab_1.tabpage_2.dw_1.insertrow( 1)
			if tab_1.selectedtab = 2 then
				of_set_changetype(tab_1.tabpage_1.dw_browse.getrow())
			end if
		end if
end if

return 1
end function

public function integer of_modify_functionfield ();//====================================================================
//$<Function>: of_modify_functionfield
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.05.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
u_dw lu_detail
u_dw lu_browse

Integer i
String ls_fields[] = {'effective_date','change_type','create_date','create_user','pending_status','update_status','error_info','push_date','pending_id'}

lu_detail=tab_1.tabpage_2.dw_detail
lu_browse = tab_1.tabpage_1.dw_browse

for i = 1 to upperbound(ls_fields)
	lu_detail.Modify(ls_fields[i] + ".visible=0")
	lu_detail.Modify(ls_fields[i] + "_t.visible=0")
	lu_detail.Modify(ls_fields[i] + ".update=yes")
	
	lu_browse.Modify(ls_fields[i] + '.Edit.DisplayOnly=Yes')
	lu_browse.Modify(ls_fields[i] + "_t.alignment='0'")
	lu_browse.Modify(ls_fields[i] + ".alignment='0'")
end for

lu_browse.Modify("create_date.Format='mm/dd/yyyy'")
lu_browse.Modify("effective_date.Format='mm/dd/yyyy'")
lu_browse.Modify("push_date.Format='mm/dd/yyyy'")

lu_browse.Modify("change_type.Edit.CodeTable=Yes")
lu_browse.Modify("change_type.Values='Modify~tM/Add~tA/Delete~tD/'")

lu_browse.Modify("update_status.Edit.CodeTable=Yes")
lu_browse.Modify("update_status.Values='Success~t1/Failure~t0/'")

lu_browse.Modify("pending_status.Edit.CodeTable=Yes")
lu_browse.Modify("pending_status.Values='Pending~t1/Applied~t0/'")

lu_detail.Modify("pending_id.Key=Yes")
lu_detail.Modify("datawindow.table.updatetable= 'pd_address_change_pending'")
lu_browse.modify("datawindow.table.updatetable= 'pd_address_change_pending'" )

return 1
end function

public function integer of_retrieve_record ();//====================================================================
//$<Function>: of_retrieve_record
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.14.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_count
long ll_cur_row
long ll_new_row
Integer i
String ls_field_name
String ls_field_visible
String ls_field_type
any la_value
u_dw lu_original
u_dw lu_detail

if not isvalid(in_fields_prop) then
	of_create_fields_data()
end if

ll_count = in_fields_prop.rowcount( )
lu_original = iu_data_entry.dw_detail
lu_detail = tab_1.tabpage_2.dw_detail
ll_cur_row = lu_original.getrow( )

if lu_detail.rowcount( ) <= 0 then
	ll_new_row = lu_detail.insertrow( 0)
else
	if lu_detail.getitemstatus( lu_detail.getrow(),0,primary!) <> NewModified! then
		ll_new_row = lu_detail.insertrow( 0)
	else
		ll_new_row = lu_detail.getrow( )
	end if
end if	

for i = 1 to ll_count
	ls_field_name = in_fields_prop.getitemstring( i,'sys_fields_field_name')	
	ls_field_visible = in_fields_prop.getitemstring( i,'data_view_fields_visible')
	ls_field_type = in_fields_prop.getitemstring( i,'sys_fields_field_type')
	
	if ls_field_visible = 'Y' then
		
		if lu_detail.describe( ls_field_name+'.ColType') = '!' then continue
		
		choose case ls_field_type
			case 'N', 'l' //'l' Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
				la_value = lu_original.getitemnumber(ll_cur_row ,ls_field_name,primary!,true)
			case 'C'
				la_value = lu_original.getitemstring(ll_cur_row ,ls_field_name,primary!,true)
			case 'D'
				la_value = lu_original.getitemdatetime(ll_cur_row ,ls_field_name,primary!,true)
		end choose
	
		lu_detail.setitem( ll_new_row,ls_field_name,la_value)
	
	end if
end for

lu_detail.setitem( ll_new_row, 'pending_status',1)
lu_detail.scrolltorow( ll_new_row)

return 1
end function

public function long of_get_pendingid ();//====================================================================
//$<Function>: of_get_pendingid
//$<Arguments>:
//$<Return>:  long
//$<Description>: get primary key value
//$<Author>: (Appeon) long.zhang 07.23.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_pending_id

select max(pending_id) into :ll_pending_id from pd_address_change_pending;

if isNull(ll_pending_id) then ll_pending_id =0

ll_pending_id++
il_cur_pendingid = ll_pending_id
return ll_pending_id
end function

public function integer of_modify_status (integer ai_status);//====================================================================
//$<Function>: of_modify_status
//$<Arguments>:
// 	value    integer    ai_status
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.05.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_null
datetime ldt_null

if ai_status = 0 then
	tab_1.tabpage_2.dw_1.modify( 'change_type.protect=1')
	tab_1.tabpage_2.dw_1.modify( 'change_type.background.color=14803425')
else
	tab_1.tabpage_2.dw_1.modify( 'change_type.protect=0')
	tab_1.tabpage_2.dw_1.modify( 'change_type.background.color=8257535')
	setNull(ls_null)
	setNull(ldt_null)
	if tab_1.tabpage_2.dw_1.rowcount () > 0 then //add if statement - alfee 11.09.2013
		tab_1.tabpage_2.dw_1.setitem( 1,'change_type',ls_null)
		tab_1.tabpage_2.dw_1.setitem( 1,'effective_date',ldt_null)
	end if
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
//$<Modify History>: tab_1.tabpage_2.dw_detail
//====================================================================
Integer i
long j
string ls_text
string ls_col_type
string ls_fields[]
boolean lb_require
u_dw lu_detail

lu_detail = tab_1.tabpage_2.dw_detail
if lu_detail.accepttext( ) = -1 then return false
if lu_detail.getrow() < 1 then return true
ls_fields= {'change_type','effective_date'}


for j = 1 to lu_detail.rowcount( )
	
	if lu_detail.getitemstatus( j,0,primary!) <> NewModified! then continue
	
	For i = 1 to UpperBound(ls_fields[])
		lb_require = false
		ls_col_type = lu_detail.describe(ls_fields[i] + '.Coltype' )
		
		if lower(left(ls_col_type,5)) = "char(" then
				if isNull(lu_detail.getItemString(j,ls_fields[i]))  then lb_require = true
		elseif lower(left(ls_col_type,5)) = "datet" then		
			if isNull(lu_detail.getItemdatetime(j,ls_fields[i]))  then lb_require = true
		else
				if isNull(lu_detail.getItemNumber(j,ls_fields[i]))  then lb_require = true
		end if
		
		if lb_require then
			ls_text = lu_detail.describe(ls_fields[i] + '_t.Text' )
			MessageBox("Require value","Require value missing for "+ls_text+" on record "+ String(j) +" ,Please enter a value")
			lu_detail.scrolltorow( j)
			 tab_1.tabpage_2.dw_1.setcolumn(ls_fields[i])
			return false
		end if
	end for
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

public function integer of_lookup_search_dddw (string as_type);///******************************************************************************************************************
//**  [PUBLIC]   : of_lookup_search_dddw( /*string as_type */)
//**==================================================================================================================
//**  Purpose   	: Set the vales from the search window or back to the original value
//**==================================================================================================================
//**  Arguments 	: [string] as_type 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: ??
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//**  MSkinner 						 19 December 2005                           I was getin a GPF on line 24 of the original code
//**  mskinner 						 23 March    2006                           Modoified code so that -777 or -888 will not be saved
//********************************************************************************************************************/

//Start Code Change ----07.25.2013 #V14 maha - moved to other function
 inv_data_entry.of_lookup_search_dddw(as_type, tab_1.tabpage_2.dw_detail, is_lookup_search_column_table )
return 0

//DataWindowChild dwchild
//any l_any
//long li_row_cnt
//long ll_val
//long ll_find
//String ls_column_nm
//String ls_retval
//String ls_search_type
//String ls_value
//any ll_null
//setnull(ll_null)
//
//n_cst_dwsrv lnv_dwsrv
//lnv_dwsrv = create n_cst_dwsrv
//lnv_dwsrv.of_setrequestor( dw_detail)
//
//ls_column_nm = dw_detail.GetColumnName()
//
//ls_retval = dw_detail.Describe( ls_column_nm + ".DDDW.DisplayColumn" )
//
//dw_detail.getchild( ls_column_nm, dwchild)
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 04.14.2006 By: Liang QingShi
////$<reason> Fix a defect.
//
//If appeongetclienttype() <> 'PB' Then
//   dw_detail.triggerevent('itemfocuschanged')
//end if
////---------------------------- APPEON END ----------------------------
//OpenWithParm( w_lookup_search_dddw,as_type + "@" + is_lookup_search_column_table )
//
//IF Message.StringParm = "Cancel" THEN
//	
//	ls_value = lnv_dwsrv.of_getitem( dw_detail.GetRow(), ls_column_nm , primary!,true)
//	if string(ls_value) = "-777" OR string(ls_value) = "-888" or not f_validstr(ls_value) then
//		setnull(ls_value)
//	end if
//
//	lnv_dwsrv.of_setitem( dw_detail.GetRow(), ls_column_nm, ls_value)
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<Add> 08.23.2007 By: Evan
//	//$<Reason> Need to destroy object.
//	if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv
//	//---------------------------- APPEON END ----------------------------	
//	RETURN -1
//else
//	l_any = Message.DoubleParm
//	
//	lnv_dwsrv.of_setitem( dw_detail.GetRow(), ls_column_nm, string(l_any))
//	
//	dw_detail.accepttext()
//	inv_data_entry.of_dwchild_retrieve(is_lookup_search_column_table,as_type,dw_detail,"RET",l_any,ls_column_nm)
//end if
//
//IF IsValid( m_pfe_cst_data_entry ) THEN
//	m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
//END IF
//
////--------------------------- APPEON BEGIN ---------------------------
////$<Add> 08.23.2007 By: Evan
////$<Reason> Need to destroy object.
//if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv
////---------------------------- APPEON END ----------------------------
//
//Return 0
end function

public function integer of_check_save ();
long ll_row

ll_row = tab_1.tabpage_2.dw_detail.getrow( )

if ll_row = 0 then return 1

if tab_1.tabpage_2.dw_detail.getitemstatus( ll_row,0,primary!) = NewModified! then
	return -1
end if



return 1
end function

public function integer of_set_browseenabled (boolean ab_enabled);//====================================================================
//$<Function>: of_set_browseenabled
//$<Arguments>:
// 	value    boolean    ab_enabled
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.15.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if ab_enabled then
//	tab_1.selecttab( 2)	
	tab_1.tabpage_1.enabled = false
	rb_2.enabled = false
	rb_1.enabled = false
else
	tab_1.tabpage_1.enabled = true
	rb_2.enabled = true
	rb_1.enabled = true
end if

return 1
end function

public function integer of_save_modify_bk ();//====================================================================
//$<Function>: of_save_pending
//$<Arguments>:
//$<Return>:  integer 
//														
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.23.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_change_type
string ls_field_name
string ls_field_visible
string ls_field_type
string ls_old_value
string ls_new_value
any la_value

long ll_new_row
long ll_pending_id
long ll_cur_row
long ll_row
long ll_fields_count
Integer i
datetime ldt_effective_date

u_dw lu_detail
u_dw lu_detail_original
datastore ld_address

ls_change_type = tab_1.tabpage_2.dw_1.getitemstring( 1,'change_type')
ldt_effective_date = tab_1.tabpage_2.dw_1.getitemdatetime( 1,'effective_date')
lu_detail = tab_1.tabpage_2.dw_detail
lu_detail_original = iu_data_entry.dw_detail




ld_address = create datastore
ld_address.dataobject = 'd_pd_address_pending'
ld_address.settransobject( sqlca)
ll_new_row = ld_address.insertrow( 0)

ll_cur_row = lu_detail.getrow( )
ll_row = lu_detail_original.getrow( )
ll_fields_count = in_fields_prop.rowcount( )

if lu_detail.accepttext( ) = -1 then return -1

for i = 1 to ll_fields_count
	ls_field_name = in_fields_prop.getitemstring( i,'sys_fields_field_name')	
	if lower(ls_field_name) = 'billing_address_id' then continue
	if ls_field_name = 'practice_type' then debugbreak()
	ls_field_visible = in_fields_prop.getitemstring( i,'data_view_fields_visible')
	ls_field_type = in_fields_prop.getitemstring( i,'sys_fields_field_type')

	if ls_field_visible = 'Y' then
		choose case ls_field_type
			case 'N'
				ls_old_value = String(lu_detail_original.getitemnumber(ll_row ,ls_field_name,primary!,true))
				ls_new_value = String(lu_detail.getitemnumber(ll_cur_row ,ls_field_name))
			case 'C'
				ls_old_value = lu_detail_original.getitemstring(ll_row ,ls_field_name,primary!,true)
				ls_new_value = lu_detail.getitemstring(ll_cur_row ,ls_field_name)
			case 'D'
				ls_old_value = String(lu_detail_original.getitemdatetime(ll_row ,ls_field_name,primary!,true))
				ls_new_value = String(lu_detail.getitemdatetime(ll_cur_row ,ls_field_name))
		end choose
		
		if not of_compare_value(ls_old_value,ls_new_value) then
			if ls_field_type  = "D" then
				ld_address.setitem( ll_new_row,ls_field_name,lu_detail.getitemdatetime(ll_cur_row ,ls_field_name))
			elseif 	ls_field_type  = "C" then
				ld_address.setitem( ll_new_row,ls_field_name,ls_new_value)
			elseif ls_field_type = 'N' then
				ld_address.setitem( ll_new_row,ls_field_name,lu_detail.getitemnumber(ll_cur_row ,ls_field_name))
			end if
		end if
				
	end if
end for

if ld_address.getitemstatus( 1,0,Primary!) = NewModified! then
	
		ll_pending_id = of_get_pendingid()
		ld_address.setitem(ll_new_row,"create_date",datetime(today(),now()))
		ld_address.setitem(ll_new_row,"create_user",gs_user_id)
		ld_address.setitem(ll_new_row,"pending_id",ll_pending_id)
		ld_address.setitem(ll_new_row,"rec_id",iu_data_entry.il_rec_id)
		ld_address.setitem(ll_new_row,"effective_date",ldt_effective_date)
		ld_address.setitem(ll_new_row,"change_type",ls_change_type)
		ld_address.setitem(ll_new_row,"pending_status",1)
		ld_address.setitem(ll_new_row,"prac_id",iu_data_entry.il_prac_id)
		if ld_address.update( ) = -1 then
			MessageBox('Save Pending','Unable to save Data')
			rollback;
			destroy ld_address
			return -1
		else
			lu_detail.retrieve( )
			commit;
		end if
	else
			MessageBox('Save Pending','No changes was made in detail data')
			destroy ld_address
			return -1
end if

destroy ld_address
return 1
end function

public function integer of_set_modifyvalue (long al_row, ref boolean ab_discard);//====================================================================
//$<Function>: of_save_pending
//$<Arguments>:
//$<Return>:  integer 
//														
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.23.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_change_type
string ls_field_name
string ls_field_visible
string ls_field_type
string ls_old_value
string ls_new_value
string ls_null
string ls_lookup_field

any la_value
long ll_pending_id
long ll_row
long ll_fields_count
long ll_null

Integer i
datetime ldt_effective_date
boolean lb_modified = false

datetime ld_null
datetime ldt_date

u_dw lu_detail
u_dw lu_detail_original

setNull(ls_null)
setNull(ld_null)
setNull(ll_null)

lu_detail = tab_1.tabpage_2.dw_detail
lu_detail_original = iu_data_entry.dw_detail

ll_row = lu_detail_original.getrow( )
ll_fields_count = in_fields_prop.rowcount( )
ab_discard = false
for i = 1 to ll_fields_count
	
	ls_field_name = in_fields_prop.getitemstring( i,'sys_fields_field_name')	
	if lu_detail.describe( ls_field_name + '.ColType') = '!' then continue
	ls_field_visible = in_fields_prop.getitemstring( i,'data_view_fields_visible')
	ls_field_type = in_fields_prop.getitemstring( i,'sys_fields_field_type')
	ls_lookup_field = in_fields_prop.getitemstring( i,'sys_fields_lookup_field')
	
	if ls_field_visible = 'Y' then
		choose case ls_field_type
			case 'N', 'l' //'l' Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
				ls_old_value = String(lu_detail_original.getitemnumber(ll_row ,ls_field_name,primary!,true))
				ls_new_value = String(lu_detail.getitemnumber(al_row ,ls_field_name))
			case 'C'
				ls_old_value = lu_detail_original.getitemstring(ll_row ,ls_field_name,primary!,true)
				ls_new_value = lu_detail.getitemstring(al_row ,ls_field_name)
			case 'D'
				ls_old_value = String(lu_detail_original.getitemdatetime(ll_row ,ls_field_name,primary!,true))
				ls_new_value = String(lu_detail.getitemdatetime(al_row ,ls_field_name))
		end choose
		
		if not of_compare_value(ls_old_value,ls_new_value) then
			lb_modified = true
			if ls_field_type  = "D" then
				if isNull(ls_new_value) then lu_detail.setitem( al_row,ls_field_name,ldt_date)			
			elseif 	ls_field_type  = "C" then

			elseif ls_field_type = 'N' or ls_field_type = 'l'  then // 'l'  Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
				if ls_lookup_field = 'Y' and isNull(ls_new_value) then
					lu_detail.setitem( al_row,ls_field_name,0)			
				end if
			end if
		else
			if ls_field_type  = "D" then
				lu_detail.setitem( al_row,ls_field_name,ld_null)
			elseif 	ls_field_type  = "C" then
				lu_detail.setitem( al_row,ls_field_name,ls_null)
			elseif ls_field_type = 'N' or ls_field_type = 'l' then // 'l'  Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
				lu_detail.setitem( al_row,ls_field_name,ll_null)
			end if


		end if
				
	end if
end for

if not lb_modified then//No field data was changed
//	lu_detail.setitemstatus( al_row,0,primary!,Notmodified!)
//	lu_detail.rowsdiscard( al_row,al_row,primary!)
//	ab_discard = true
end if

return 1
end function

public function integer of_find_address ();
long ll_addr[ ]
Integer li_cr
Integer a
Integer li_address_cnt

gs_pass_ids ids
u_dw lu_dw_detail
datastore lds_gp_address

lu_dw_detail = tab_1.tabpage_2.dw_detail

if lu_dw_detail.rowcount( ) = 0 then cb_add.event clicked()

if lu_dw_detail.getrow() <= 0 then return -1

Open(w_practice_to_addr_find_new) 
	
ids = Message.PowerObjectParm
			
IF ids.l_ids[1] = 0 THEN
	Return -1
END IF
	
ll_addr[] = ids.l_ids[]
		
li_address_cnt = UpperBound( ids.l_ids[] )

if li_address_cnt = 0 then return 1

lds_gp_address = create datastore
lds_gp_address.dataobject = ''
lds_gp_address.settransobject( sqlca)

gnv_appeondb.of_startqueue( )
	lds_gp_address.retrieve(1,86 )
	dw_addresses.retrieve(ll_addr[] )
gnv_appeondb.of_commitqueue( )

			
			






return 1
end function

public function integer of_set_fieldenabled (boolean ab_enabled);//====================================================================
//$<Function>: of_set_fieldenabled
//$<Arguments>:
// 	value    boolean    ab_enabled
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_columncount

Integer i
Integer li_protect = 1
Integer li_visible

string ls_bgcolor = '14803425'
String ls_colname
u_dw lu_detail

lu_detail = tab_1.tabpage_2.dw_detail

if ab_enabled then
	li_protect = 0
//	ls_bgcolor = '16777215'
end if

ll_columnCount = long(lu_detail.describe( 'Datawindow.Column.Count'))

lu_detail.setredraw( false)
For i = 1 to ll_columnCount
	ls_colname = lu_detail.Describe("#" +STRING(i) + ".Name")
	if lu_detail.Describe(ls_colname + '.ColType') <> '!' then
		li_visible = Integer(lu_detail.Describe(ls_colname + ".visible"))
		if li_visible = 1 or li_visible = -1 then	//under web if visible are not assigned the value is -1
		//	lu_detail.modify( ls_colname + ".Background.Color='" + ls_bgcolor + "'")
			lu_detail.modify(  ls_colname +".protect='"+String(li_protect)+"'")
		else
			
		end if
	end if
end For

lu_detail.setredraw( true)

if not ab_enabled then
//	tab_1.tabpage_2.dw_1.modify( "effective_date.protect='1'")
	//tab_1.tabpage_2.dw_1.modify( "b_find.visible='0'")
	tab_1.tabpage_2.dw_1.enabled = false
else
	//tab_1.tabpage_2.dw_1.modify( "effective_date.protect='0'")
	//tab_1.tabpage_2.dw_1.modify( "b_find.visible='1'")
		tab_1.tabpage_2.dw_1.enabled = true
end if

cb_save.enabled = ab_enabled
cb_add.enabled = ab_enabled

return 1
end function

public function integer of_fill_address (long al_rec_id);//====================================================================
//$<Function>: of_fill_address
//$<Arguments>:
// 	value    long    al_rec_id
//$<Return>:  integer
//$<Description>: Called From dw_1.buttonclicked() event
//$<Author>: (Appeon) long.zhang 10.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>: //rec_id ??? - alfee 11.09.2013
//====================================================================

if tab_1.tabpage_2.dw_detail.getrow( ) < 1 or al_rec_id = 0 then return -1

long ll_address_id[] 
long ll_count
long ll_cur_row
Integer i
String ls_field_name,ls_field_visible,ls_field_type
Any la_value

n_ds ln_address
u_dw lu_detail

ll_address_id[1] = al_rec_id
ln_address = create n_ds
ln_address.dataobject = 'd_group_data_entry_for_pt'
ln_address.settransobject(sqlca)
ln_address.retrieve(ll_address_id[])

if ln_address.rowcount( ) = 0 then
	destroy ln_address
	return -1
end if

if not isvalid(in_fields_prop) then
	of_create_fields_data()
end if

ll_count = in_fields_prop.rowcount( )

lu_detail = tab_1.tabpage_2.dw_detail
ll_cur_row = lu_detail.getrow( )



for i = 1 to ll_count
	ls_field_name = in_fields_prop.getitemstring( i,'sys_fields_field_name')	
	ls_field_visible = in_fields_prop.getitemstring( i,'data_view_fields_visible')
	ls_field_type = in_fields_prop.getitemstring( i,'sys_fields_field_type')
	
	if ls_field_visible = 'Y' then
		
		if lu_detail.describe( ls_field_name+'.ColType') = '!' or ln_address.describe( ls_field_name+'.ColType') = '!' then
			continue
		end if	
		
		choose case upper(ls_field_type)
			case 'N'
				la_value = ln_address.getitemnumber( 1,ls_field_name)
			case 'C'
				la_value = ln_address.getitemstring(1 ,ls_field_name)
			case 'D'
				la_value = ln_address.getitemdatetime(1 ,ls_field_name)
		end choose
	
		lu_detail.setitem( ll_cur_row,ls_field_name,la_value)
	
	end if
end for

destroy ln_address


return 1
end function

public function integer of_create_fields_data ();	
	if isvalid(in_fields_prop) then return 1
	
	in_fields_prop = create n_ds
	in_fields_prop.dataobject = "d_sys_field_properties"
	in_fields_prop.settransobject( sqlca)
	in_fields_prop.retrieve(il_data_view_id,2)
	//in_fields_prop.setfilter( 'sys_fields_field_id<>30117 and sys_fields_field_id<>11223361')
	in_fields_prop.setfilter( 'sys_fields_field_id<>30117 ') //recover billing_address_id by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
	in_fields_prop.filter( )
		
	return 1
end function

public function integer of_clear_data (long al_row);//====================================================================
//$<Function>: of_clear_data
//$<Arguments>: long al_row
//$<Return>:  integer
//$<Description>: Fixed BugA110105
//$<Author>: (Appeon) long.zhang 08.14.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if al_row <= 0 then return -1

long ll_count
Integer i
String ls_field_name
String ls_field_visible
String ls_field_type

String ls_null
DateTime ldt_null
long ll_null

u_dw lu_detail

if not isvalid(in_fields_prop) then
	of_create_fields_data()
end if

ll_count = in_fields_prop.rowcount( )
lu_detail = tab_1.tabpage_2.dw_detail

setNull(ls_null)
setNUll(ldt_null)
setNull(ll_null)

for i = 1 to ll_count
	
	ls_field_name = in_fields_prop.getitemstring( i,'sys_fields_field_name')	
	ls_field_visible = in_fields_prop.getitemstring( i,'data_view_fields_visible')
	ls_field_type = in_fields_prop.getitemstring( i,'sys_fields_field_type')
	
	if ls_field_visible = 'Y' then
		
		if lu_detail.describe( ls_field_name+'.ColType') = '!' then continue
		
		choose case ls_field_type
			case 'N', 'l' //'l' Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
				lu_detail.setitem( al_row,ls_field_name,ll_null)
			case 'C'
				lu_detail.setitem( al_row,ls_field_name,ls_null)
			case 'D'
				lu_detail.setitem( al_row,ls_field_name,ldt_null)
		end choose
		
	end if
end for

//Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
inv_data_entry.of_set_defaults( lu_detail, 0 )

return 1
end function

public function integer of_filter_data ();//====================================================================
//$<Function>: of_filter_data()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Filter data in the DataWindow
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_filter, ls_type, ls_date_filter
String ls_from_date, ls_to_date
Date ld_from_date, ld_to_date

//Pending Status
IF rb_1.checked THEN
	ls_filter = 'pending_status=1'
ELSE
	ls_filter = 'pending_status=0'
END IF

//Change Type
dw_type.AcceptText ()
ls_type = dw_type.GetItemString (1, "change_type")
IF Len(ls_type) > 0 THEN 
	ls_filter += " And Upper(change_type) = '" + Upper(ls_type) + "'"
END IF

//Effective Date
dw_date_range.AcceptText ()
ld_from_date = dw_date_range.GetItemDate( 1, "from" )
ld_to_date = dw_date_range.GetItemDate( 1, "to" )
ls_from_date = String(ld_from_date,"yyyy-mm-dd") 
ls_to_date = String(ld_to_date,"yyyy-mm-dd")
If isnull(ld_from_date) and not isnull(ld_to_date) Then
	ls_date_filter = " (Date(effective_date) <= Date('" + ls_to_date + "') )"
ElseIf Isnull(ld_to_date) and not isnull(ld_from_date) Then
	ls_date_filter = " (Date(effective_date) >= Date('" + ls_from_date + "') )"
ElseIf isnull(ld_from_date) and isnull(ld_to_date) Then
	ls_date_filter = ''
Else 
	ls_date_filter = " ( Date(effective_date) >= Date('" + ls_from_date + "') AND Date(effective_date) <= Date('" + ls_to_date + "') )"
End If

IF Len(ls_date_filter) > 0 THEN
	ls_filter += ' And ' +ls_date_filter 
END IF

//Filter data 
tab_1.tabpage_1.dw_browse.SetFilter( ls_filter)
tab_1.tabpage_1.dw_browse.Filter( )

IF tab_1.tabpage_1.dw_browse.rowcount () > 0 THEN
	tab_1.tabpage_1.dw_browse.ScrolltoRow (1)
	tab_1.tabpage_1.dw_browse.SelectRow (0, False)
	tab_1.tabpage_1.dw_browse.SelectRow (1, True)
END IF

//Change to the browse tab after filtering data - will cause dead loop
//IF tab_1.SelectedTab = 2 THEN
//	tab_1.SelectTab (1)
//END IF

//-------------appeon begin----------------------
//<$>added:long.zhang 11.11.2013
//<$>reason:Fixed BugS092701
if rb_1.checked then
	of_modify_updatestatus(0)
else
	of_modify_updatestatus(1)
end if
//-------------appeon End------------------------

RETURN 1

end function

public function integer of_retrieve_detail (long al_pending_id);//====================================================================
//$<Function>: of_retrieve_detail()
//$<Arguments>:
// 	value    long    al_pending_id
//$<Return>:  integer
//$<Description>: Retrieve current pending record in the detail
//$<Author>: (Appeon) Alfee 11.09.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_where, ls_sql
Integer li_rtn

IF IsNull(al_pending_id) OR al_pending_id = 0 THEN 
	tab_1.tabpage_2.dw_detail.Reset ()
	RETURN 0
END IF

ls_where = " Where pending_id = " + String (al_pending_id)
ls_sql = is_org_sql + ls_where

li_rtn = tab_1.tabpage_2.dw_detail.SetSQLSelect (ls_sql)
IF li_rtn < 0 THEN 
	MessageBox ("Error", "Failed to retrieve the datail as the SetSQLSelect error. The SQL statement is :  ~r~n" + ls_sql )
END IF

li_rtn = tab_1.tabpage_2.dw_detail.SetTransObject (SQLCA)
IF li_rtn < 0 THEN 
	MessageBox ("Error", "Failed to retrieve the datail as the SetTransObject error. The SQL statement is :  ~r~n" + ls_sql )
END IF

if tab_1.tabpage_2.dw_detail.Retrieve () < 0 THEN RETURN -1
	
RETURN 1
end function

public function integer of_set_changetype (long al_row);//====================================================================
//$<Function>: of_set_changetype
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.26.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================

String ls_change_type
datetime ld_effective_date
long ll_pending_id

if al_row <= 0 then 
	tab_1.tabpage_2.dw_1.reset () //alfee 11.09.2013
	return -1
end if

ll_pending_id = tab_1.tabpage_1.dw_browse.getitemnumber( al_row,'pending_id')
ls_change_type = tab_1.tabpage_1.dw_browse.getitemstring( al_row,'change_type')	
ld_effective_date = tab_1.tabpage_1.dw_browse.getitemdatetime( al_row,'effective_date')

if tab_1.tabpage_2.dw_1.rowcount () < 1 THEN tab_1.tabpage_2.dw_1.insertrow(0) //alfee 11.09.2013
tab_1.tabpage_2.dw_1.setitem( 1,'change_type',ls_change_type)
tab_1.tabpage_2.dw_1.setitem( 1,'effective_date',ld_effective_date)

if isNull(ll_pending_id) then
	of_modify_status(1)
else
	of_modify_status(0)
end if
	
return 1
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


tab_1.tabpage_1.dw_browse.modify( 'update_status.visible='+String(ai_status))
tab_1.tabpage_1.dw_browse.modify( 'update_status_t.visible='+String(ai_status))
tab_1.tabpage_1.dw_browse.modify( 'error_info.visible='+String(ai_status))
tab_1.tabpage_1.dw_browse.modify( 'error_info_t.visible='+String(ai_status))

return 1
end function

on w_pending_changes_address.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_date_range=create dw_date_range
this.cb_reset=create cb_reset
this.cb_filter=create cb_filter
this.dw_type=create dw_type
this.cbx_all=create cbx_all
this.tab_1=create tab_1
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_addresses=create dw_addresses
this.gb_status=create gb_status
this.gb_date=create gb_date
this.gb_type=create gb_type
this.gb_filter=create gb_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.dw_date_range
this.Control[iCurrent+4]=this.cb_reset
this.Control[iCurrent+5]=this.cb_filter
this.Control[iCurrent+6]=this.dw_type
this.Control[iCurrent+7]=this.cbx_all
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.cb_delete
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.cb_add
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.dw_addresses
this.Control[iCurrent+14]=this.gb_status
this.Control[iCurrent+15]=this.gb_date
this.Control[iCurrent+16]=this.gb_type
this.Control[iCurrent+17]=this.gb_filter
end on

on w_pending_changes_address.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_date_range)
destroy(this.cb_reset)
destroy(this.cb_filter)
destroy(this.dw_type)
destroy(this.cbx_all)
destroy(this.tab_1)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_addresses)
destroy(this.gb_status)
destroy(this.gb_date)
destroy(this.gb_type)
destroy(this.gb_filter)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.15.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>: Reconstructed by alfee 11.09.2013
//====================================================================
long ll_find_row
long ll_rec_id
long ll_row

if isvalid(Message.PowerObjectParm) then
	iu_data_entry = Message.PowerObjectParm
	inv_data_entry = iu_data_entry.inv_data_entry
else
	close(this)
	return
end if

tab_1.tabpage_2.dw_detail.of_SetDropDownCalendar(true)
tab_1.tabpage_2.dw_1.of_SetDropDownCalendar(true)
dw_date_range.of_SetDropDownCalendar( true )
dw_date_range.iuo_calendar.of_Register( dw_date_range.iuo_calendar.DDLB )		

//Create the datail datawindow
of_create_dynamic_dw()

//Set filter in browse
of_filter_data()

//Retrieve data in browse 
tab_1.tabpage_1.dw_browse.retrieve (iu_data_entry.il_prac_id)

//Go to the record connected to the current address
if tab_1.tabpage_1.dw_browse.rowcount( ) > 0 then
	ll_rec_id = iu_data_entry.il_rec_id
	if not isNull(ll_rec_id) then
		ll_row = tab_1.tabpage_1.dw_browse.find('rec_id='+String(ll_rec_id),1,tab_1.tabpage_1.dw_browse.rowcount())
		if ll_row < 1 then ll_row = 1
		tab_1.tabpage_1.dw_browse.scrolltorow( ll_row)
		tab_1.tabpage_1.dw_browse.selectrow( 0,false)
		tab_1.tabpage_1.dw_browse.selectrow( ll_row,true)
	end if
end if

//tab_1.selecttab( 2)

end event

event close;call super::close;if isvalid(in_fields_prop) then destroy in_fields_prop




end event

event pfc_save;//====================================================================
//$<Event>: pfc_save
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.15.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>: Reconstructed by alfee 11.09.2013
//====================================================================
Integer li_rtn, li_selected_tab
Long ll_row, ll_found
Long ll_pending_id

if tab_1.tabpage_2.dw_1.accepttext( ) = -1 then return -1
if not of_check_require() then return -1

li_selected_tab = tab_1.selectedtab

li_rtn = super::event pfc_save()

if li_rtn = 1 THEN
	SetRedraw (False)
	of_modify_status(0)
	
	//Refresh data in browse 
	of_filter_data()	//Set filter
	if ib_all_pracs then
		tab_1.tabpage_1.dw_browse.retrieve ()
	else
		tab_1.tabpage_1.dw_browse.retrieve (iu_data_entry.il_prac_id)
	end if

	//Go to the current record 
	if tab_1.tabpage_1.dw_browse.rowcount( ) > 0 then
		ll_found = 1
		ll_row = tab_1.tabpage_2.dw_detail.getrow ()
		if ll_row > 0 then
			ll_pending_id = tab_1.tabpage_2.dw_detail.getitemnumber (ll_row, "pending_id")
			if not isNull(ll_pending_id) then
				ll_found = tab_1.tabpage_1.dw_browse.find('pending_id='+String(ll_pending_id),1,tab_1.tabpage_1.dw_browse.rowcount())
				if ll_found < 1 then ll_found = 1
			end if
		end if		
		tab_1.tabpage_1.dw_browse.scrolltorow( ll_found)
		tab_1.tabpage_1.dw_browse.selectrow( 0,false)
		tab_1.tabpage_1.dw_browse.selectrow( ll_found,true)
	end if	
	
	//Switch to the original tab 
	if tab_1.selectedtab <> li_selected_tab then
		tab_1.selecttab (li_selected_tab)	
	end if
	SetRedraw (True)
end if	

return li_rtn





end event

type rb_2 from radiobutton within w_pending_changes_address
integer x = 343
integer y = 128
integer width = 279
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

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.26.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if tab_1.tabpage_2.dw_detail.modifiedcount( ) > 0 then
		MessageBox('Filter status','Please save data first')
		rb_1.checked = true
		return -1
end if

if ii_status = 0 then return

ii_status = 0
of_set_fieldenabled(false)

//of_filter_status()
cb_filter.event clicked () //alfee 11.09.2013



end event

type rb_1 from radiobutton within w_pending_changes_address
integer x = 46
integer y = 124
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
string text = "Pending"
boolean checked = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.26.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if ii_status = 1 then return

ii_status = 1
of_set_fieldenabled(true)

//of_filter_status()
cb_filter.event clicked () //alfee 11.09.2013



end event

type dw_date_range from u_dw within w_pending_changes_address
integer x = 1051
integer y = 124
integer width = 773
integer height = 76
integer taborder = 50
string dataobject = "d_group_date_range"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.object.datawindow.color = gl_bg_color 

this.of_SetTransObject( SQLCA )
this.InsertRow( 0 )
this.of_SetUpdateAble( False )
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()


ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if


end event

type cb_reset from commandbutton within w_pending_changes_address
integer x = 1824
integer y = 124
integer width = 174
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
//SetNull( is_date_filter )
//SetNull( is_status_filter )
//cb_1.event clicked()
end event

type cb_filter from commandbutton within w_pending_changes_address
integer x = 2016
integer y = 124
integer width = 123
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_rtn

li_rtn = of_filter_data ()

RETURN li_rtn

end event

type dw_type from u_dw within w_pending_changes_address
integer x = 663
integer y = 124
integer width = 338
integer height = 76
integer taborder = 40
string dataobject = "d_group_change_type"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.object.datawindow.color = gl_bg_color 

this.InsertRow (0)
end event

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged()
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

cb_filter.event clicked ()
end event

type cbx_all from checkbox within w_pending_changes_address
integer x = 41
integer y = 2332
integer width = 1207
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Show Pending Changes for All Providers"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.10.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF cbx_all.checked <> ib_all_pracs THEN
	ib_all_pracs = cbx_all.checked
	
	tab_1.tabpage_1.dw_browse.SetReDraw(FALSE)
	IF ib_all_pracs THEN
		tab_1.tabpage_1.dw_browse.dataobject = "d_pd_address_pending_browse_all"
		tab_1.tabpage_1.dw_browse.SetTransObject(SQLCA)
		tab_1.tabpage_1.dw_browse.Retrieve ()
	ELSE
		tab_1.tabpage_1.dw_browse.dataobject = "d_pd_address_pending_browse"
		tab_1.tabpage_1.dw_browse.SetTransObject(SQLCA)
		tab_1.tabpage_1.dw_browse.Retrieve (iu_data_entry.il_prac_id)
	END IF

	of_filter_data ()
	tab_1.tabpage_1.dw_browse.SetReDraw(TRUE)	
END IF
end event

type tab_1 from tab within w_pending_changes_address
event create ( )
event destroy ( )
integer x = 5
integer y = 252
integer width = 3264
integer height = 2060
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.05.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>Reconstructed by alfee 11.09.2013
//====================================================================
integer li_rtn
long ll_row_brow, ll_row
long ll_pending_id_brow, ll_pending_id

if newindex = 2 then
	ll_row_brow = this.tabpage_1.dw_browse.getrow( )
	if ll_row_brow > 0 then
		ll_pending_id_brow = this.tabpage_1.dw_browse.getitemnumber(ll_row_brow, "pending_id")	
	end if
	
	ll_row = this.tabpage_2.dw_detail.getrow()
	if ll_row > 0 then
		ll_pending_id = this.tabpage_2.dw_detail.getitemnumber (ll_row, "pending_id")
	end if
	
	if  ll_pending_id_brow = 0 or ll_pending_id_brow <> ll_pending_id then
		li_rtn = of_retrieve_detail (ll_pending_id_brow)
		of_set_changetype(ll_row_brow)
	end if
end if
end event

event selectionchanging;//====================================================================
//$<Event>: selectionchanging()
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.10.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_rtn

if oldindex = 2 and newindex = 1 then
	li_rtn = cb_save.event clicked()
	if li_rtn < 0 then return 1 //prevent
end if

return 0 //continue 
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3227
integer height = 1944
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_browse dw_browse
end type

on tabpage_1.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_1.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_1
event pfc_after_select ( )
integer x = 18
integer y = 12
integer width = 3195
integer height = 1920
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pd_address_pending_browse"
boolean hscrollbar = true
end type

event doubleclicked;
//IF tab_1.tabpage_2.dw_detail.RowCount() > 0 THEN
IF Row > 0 THEN	//alfee 11.09.2013
	tab_1.SelectTab( 2 )
END IF



end event

event rowfocuschanged;call super::rowfocuschanged;//Commented by alfee 11.09.2013

//IF tab_1.tabpage_2.dw_detail.GetRow() <> currentrow THEN
//	tab_1.tabpage_2.dw_detail.ScrollToRow( currentrow )
//	tab_1.tabpage_2.dw_detail.SetRow( currentrow )
//END IF
//
//This.SelectRow( 0, False )
//This.SelectRow( currentrow, True )
//
//of_set_changetype(currentrow)

end event

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

This.of_settransobject(sqlca)

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.of_SetUpdateable( True )
This.inv_sort.of_SetColumnHeader(True)

This.of_setrowselect( True)
This.inv_rowselect.of_SetStyle(This.inv_rowselect.single )

end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3227
integer height = 1944
long backcolor = 32891346
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_1 dw_1
dw_detail dw_detail
end type

on tabpage_2.create
this.dw_1=create dw_1
this.dw_detail=create dw_detail
this.Control[]={this.dw_1,&
this.dw_detail}
end on

on tabpage_2.destroy
destroy(this.dw_1)
destroy(this.dw_detail)
end on

type dw_1 from u_dw within tabpage_2
integer x = 23
integer y = 16
integer width = 3200
integer height = 176
integer taborder = 60
string dataobject = "d_pd_pending_fields"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.15.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row
//if this.accepttext( ) = -1 then return
ll_row = tab_1.tabpage_2.dw_detail.getrow( )

if dwo.name = 'change_type' then
	
	if ll_row > 0 then
		tab_1.tabpage_2.dw_detail.setitem( ll_row,'change_type',data)
	end if
	
	//-------------appeon begin----------------------
	//<$>added:long.zhang 11.05.2013
	//<$>reason:Fix BugA110105
		if data = 'A' then
				if MessageBox('Change Type','Would you like to clear all data on this record?',Question!,YesNo!,1) = 1 then
					of_clear_data(ll_row)
				end if
		end if
	//-------------appeon End------------------------
	
elseif dwo.name = 'effective_date' then
	if ll_row > 0 then
		tab_1.tabpage_2.dw_detail.setitem( ll_row,'effective_date',datetime(date(data),time("00:00:00")))
	end if
end if
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_rec_id
if dwo.name = 'b_find' then
	open(w_practice_to_addr_find)
	ll_rec_id = Message.DoubleParm	
	of_fill_address(ll_rec_id)
end if

end event

type dw_detail from u_dw within tabpage_2
event ue_showlist pbm_custom01
event pfc_cst_preupdate pbm_custom02
event pfc_after_select ( )
event type integer ue_after_itemchanged ( string as_type )
event type integer ue_after_itemchange ( string as_type )
integer x = 23
integer y = 192
integer width = 3195
integer height = 1740
integer taborder = 40
boolean bringtotop = true
boolean livescroll = false
end type

event type integer ue_after_itemchange(string as_type);//maha 8-2005

string s

s = String(Message.LongParm, "address")
//messagebox("s",s)
of_lookup_search_dddw(s)

return 1
end event

event constructor;This.of_SetRowManager( TRUE )
//This.inv_rowmanager.of_SetRestoreRow( TRUE )
//This.inv_rowmanager.of_SetConfirmOnDelete ( TRUE )
This.of_SetReqColumn(TRUE)




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

event itemfocuschanged;call super::itemfocuschanged;//IF This.Describe(This.GetColumnName() + ".DDDW.DisplayColumn") = "entity_name"  THEN
DataWindowChild dwchild
String ls_column_name
integer res	
	
	ls_column_name =This.GetColumnName()
	res = This.GetChild( ls_column_name, dwchild )
	if res > 0 then
//		IF dw_select_section.GetRow()>0 Then//Added by  Nova 06.17.2010
//			if dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 65 or dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 54 or ls_column_name = "billing_address_id" then //maha app081705 trap for question dddw
				//nothing
		//	else
				IF dwchild.RowCount() > 2 and  not(ls_column_name = "billing_address_id")  THEN //maha changed from 1 for lookup search 061605 //billing_address_id exception, Added by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing) 
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
					//---------------------------- APPEON END ----------------------------
				END IF
			//end if
		END IF	
//	end if
	IF IsValid( m_pfe_cst_data_entry ) THEN
		m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
	END IF
//ELSE
//	IF IsValid( m_pfe_cst_data_entry ) THEN
//		m_pfe_cst_data_entry.m_edit.m_lookupsearch.enabled = False
//	END IF
//END IF

//IF This.GetColumnName() = "billing_address_id" THEN
//	This.GetChild( "billing_address_id", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( il_prac_id )
//	
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "N/A" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )
//	dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "Same" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )
//	dwchild.SetItem( 1, "pd_address_rec_id", 0 )
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )	
//END IF
//
//
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

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.15.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
long ll_pending_id
long ll_rec_id
datetime ld_effective_date
String ls_change_type
boolean lb_discard

setNull(ll_pending_id)

for i = 1 to this.rowcount( )
	if this.getitemstatus( i,0,primary!) = NewModified! then
		
		ls_change_type = tab_1.tabpage_2.dw_detail.getitemString( i,'change_type')
		ld_effective_date = tab_1.tabpage_2.dw_detail.getitemdatetime( i,'effective_date')
		
		if ls_change_type = 'M' then
			of_set_modifyvalue(i,lb_discard)
			if lb_discard then
				i -= 1 
				continue
			end if
		end if
		
		if isNull(ll_pending_id) then ll_pending_id = of_get_pendingid()
		
		this.setitem( i,'pending_id',ll_pending_id)
		this.setitem( i,'create_date',datetime(today(),now()))
		this.setitem( i,'create_user',gs_user_id)
		
		if ls_change_type = 'A' then
			setNull(ll_rec_id)
			this.setitem( i,'rec_id',ll_rec_id)
		else
			this.setitem( i,'rec_id',iu_data_entry.il_rec_id)
		end if
		this.setitem( i,'effective_date',ld_effective_date)
		this.setitem( i,'change_type',ls_change_type)
		this.setitem( i,'pending_status',1)
		this.setitem( i,'prac_id',iu_data_entry.il_prac_id)
		ll_pending_id++
	end if
end for


return 1
end event

type cb_delete from commandbutton within w_pending_changes_address
integer x = 2715
integer y = 124
integer width = 279
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;////====================================================================
////$<Event>: clicked
////$<Arguments>:
////$<Return>:  long
////$<Description>: 
////$<Author>: (Appeon) long.zhang 07.25.2013 (V14.1Group Location Effective Dates)
////--------------------------------------------------------------------
////$<Modify History>: Reconstructed by alfee 11.09.2013
////====================================================================
Long ll_row
dwItemStatus l_status

if tab_1.selectedtab = 2 then
	ll_row = tab_1.tabpage_2.dw_detail.getrow ()
	if ll_row < 1 then return
	l_status = tab_1.tabpage_2.dw_detail.getitemstatus(ll_row, 0, primary!)
	if l_status = New! or l_status = NewModified! then
		tab_1.tabpage_2.dw_detail.deleterow(ll_row)
		tab_1.tabpage_2.dw_1.reset()
		return
	end if

	if MessageBox('Delete','Are you sure you want to delete this record?',Question!,YesNo! ,2) = 2 then return
	tab_1.tabpage_2.dw_detail.event pfc_deleterow()
	tab_1.tabpage_2.dw_1.reset()
else 
	if tab_1.tabpage_1.dw_browse.getrow () < 1 then return
	if MessageBox('Delete','Are you sure you want to delete this record?',Question!,YesNo! ,2) = 2 then return
	tab_1.tabpage_1.dw_browse.event pfc_deleterow()	
end if	

cb_save.event clicked ()

//tab_1.tabpage_2.dw_detail.event pfc_deleterow()
//if tab_1.tabpage_2.dw_detail.rowcount( ) = 0 then
//	tab_1.tabpage_2.dw_1.reset( )
//end if
end event

type cb_save from commandbutton within w_pending_changes_address
integer x = 2167
integer y = 124
integer width = 279
integer height = 92
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
//$<Modify History>: Reconstructed by alfee 11.09.2013
//====================================================================

RETURN Parent.event pfc_save ()

//Integer li_rtn, li_selected_tab
//Long ll_row, ll_found
//Long ll_pending_id
//
//li_selected_tab = tab_1.selectedtab
//
//li_rtn = parent.event pfc_save( ) 
//if li_rtn = 1 THEN
//	SetRedraw (False)
//	of_modify_status(0)
//	
//	//Set filter in browse
//	of_filter_data()
//
//	//Refresh data in browse 
//	if ib_all_pracs then
//		tab_1.tabpage_1.dw_browse.retrieve ()
//	else
//		tab_1.tabpage_1.dw_browse.retrieve (iu_data_entry.il_prac_id)
//	end if
//
//	//Go to the current record 
//	if tab_1.tabpage_1.dw_browse.rowcount( ) > 0 then
//		ll_found = 1
//		ll_row = tab_1.tabpage_2.dw_detail.getrow ()
//		if ll_row > 0 then
//			ll_pending_id = tab_1.tabpage_2.dw_detail.getitemnumber (ll_row, "pending_id")
//			if not isNull(ll_pending_id) then
//				ll_found = tab_1.tabpage_1.dw_browse.find('pending_id='+String(ll_pending_id),1,tab_1.tabpage_1.dw_browse.rowcount())
//				if ll_found < 1 then ll_found = 1
//			end if
//		end if		
//		tab_1.tabpage_1.dw_browse.scrolltorow( ll_found)
//		tab_1.tabpage_1.dw_browse.selectrow( 0,false)
//		tab_1.tabpage_1.dw_browse.selectrow( ll_found,true)
//	end if	
//	
//	//Switch to the original tab 
//	if tab_1.selectedtab <> li_selected_tab then
//		tab_1.selecttab (li_selected_tab)	
//	end if
//	SetRedraw (True)
//end if	
//
//return li_rtn



end event

type cb_add from commandbutton within w_pending_changes_address
integer x = 2441
integer y = 124
integer width = 279
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.05.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>: Reconstructed by alfee 11.09.2013
//====================================================================
if cb_save.event clicked() < 0 then return -1

setReDraw(false)
if tab_1.selectedtab = 1 then tab_1.selecttab (2)

tab_1.tabpage_2.dw_1.Reset ()
tab_1.tabpage_2.dw_detail.Reset ()

tab_1.tabpage_2.dw_1.insertrow(0)

of_retrieve_record()

of_modify_status(1)
setReDraw(true)

return 1
end event

type cb_close from commandbutton within w_pending_changes_address
integer x = 2990
integer y = 124
integer width = 279
integer height = 92
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

type dw_addresses from u_dw within w_pending_changes_address
boolean visible = false
integer x = 2226
integer y = 592
integer width = 279
integer height = 100
integer taborder = 30
string dataobject = "d_group_data_entry"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-08-01 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm

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
//---------------------------- APPEON END ----------------------------

end event

type gb_status from groupbox within w_pending_changes_address
integer x = 18
integer y = 64
integer width = 613
integer height = 148
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Pending Status"
end type

type gb_date from groupbox within w_pending_changes_address
integer x = 1033
integer y = 64
integer width = 978
integer height = 148
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Effective Date Range"
end type

type gb_type from groupbox within w_pending_changes_address
integer x = 635
integer y = 64
integer width = 389
integer height = 148
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Type"
end type

type gb_filter from groupbox within w_pending_changes_address
integer x = 5
integer y = 4
integer width = 2149
integer height = 232
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
end type

