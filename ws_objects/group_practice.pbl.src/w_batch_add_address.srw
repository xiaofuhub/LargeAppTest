$PBExportHeader$w_batch_add_address.srw
forward
global type w_batch_add_address from window
end type
type cb_add_group from commandbutton within w_batch_add_address
end type
type cb_1 from commandbutton within w_batch_add_address
end type
type cbx_dir from checkbox within w_batch_add_address
end type
type cbx_exp from checkbox within w_batch_add_address
end type
type cbx_mail from checkbox within w_batch_add_address
end type
type cbx_bill from checkbox within w_batch_add_address
end type
type cbx_add from checkbox within w_batch_add_address
end type
type cbx_prim from checkbox within w_batch_add_address
end type
type st_process from statictext within w_batch_add_address
end type
type st_count from statictext within w_batch_add_address
end type
type st_tip from statictext within w_batch_add_address
end type
type cb_close from commandbutton within w_batch_add_address
end type
type cb_update from commandbutton within w_batch_add_address
end type
type cb_rm_all from commandbutton within w_batch_add_address
end type
type cb_rmprac from commandbutton within w_batch_add_address
end type
type cb_batchprac from commandbutton within w_batch_add_address
end type
type cb_addprac from commandbutton within w_batch_add_address
end type
type dw_selected_prac from datawindow within w_batch_add_address
end type
type gb_1 from groupbox within w_batch_add_address
end type
type gb_2 from groupbox within w_batch_add_address
end type
end forward

global type w_batch_add_address from window
integer width = 2597
integer height = 2272
boolean titlebar = true
string title = "Batch Add Address to Providers"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_add_group cb_add_group
cb_1 cb_1
cbx_dir cbx_dir
cbx_exp cbx_exp
cbx_mail cbx_mail
cbx_bill cbx_bill
cbx_add cbx_add
cbx_prim cbx_prim
st_process st_process
st_count st_count
st_tip st_tip
cb_close cb_close
cb_update cb_update
cb_rm_all cb_rm_all
cb_rmprac cb_rmprac
cb_batchprac cb_batchprac
cb_addprac cb_addprac
dw_selected_prac dw_selected_prac
gb_1 gb_1
gb_2 gb_2
end type
global w_batch_add_address w_batch_add_address

type variables
long il_gp_id
n_cst_datastore ids_address
n_cst_datastore ids_facilities

string is_praclist//For V10.5 SK Group Practice  Added by  Nova 09.26.2010
string is_addr_type
String is_appmnt_status //long.zhang 04.05.2012







end variables

forward prototypes
public function integer of_add_prac ()
public function integer of_remove_prac (string as_type)
public function integer of_process ()
public function integer of_cachepracdata (long al_currrow, long al_rowcount, long al_cachecounter, long al_gp_id)
public function integer of_process_bk ()
public function integer of_get_from_group (long al_gpid)
end prototypes

public function integer of_add_prac ();//==============================APPEON BEGIN==========================
// Function: w_batch_add_address.of_add_prac()
//--------------------------------------------------------------------
// Description: add prac want to update address
//--------------------------------------------------------------------
// Arguments:None
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Apr 01,2009
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

Integer li_find
Long li_prac_id,li_facility_id
Integer i
Integer ic

gs_batch_search ist_search

SetPointer(HourGlass!)

ist_search = Message.PowerObjectParm
IF Not IsValid(Message.PowerObjectParm) THEN RETURN 0

n_cst_datastore ds_temp
ds_temp = Create n_cst_datastore

ds_temp.DataObject = "d_extended_search_list_multi_ds"
ds_temp.SetTransObject(sqlca)
ic = ds_temp.Retrieve(ist_search.li_prac_id,ist_search.ll_facility)

//------------------APPEON BEGIN----------------
//<$> add long.zhang 04.05.2012
//<$>Reason:filter the active status
if len(is_appmnt_status) > 0 then
	ds_temp.setfilter( 'active_status in ('+is_appmnt_status+')')
	ds_temp.filter( )
end if
ic=ds_temp.rowcount( )
//-------------------APPEON END-------------------

FOR i = 1 To ic
	//li_facility_id = ds_temp.Object.parent_facility_id[i]
	li_prac_id = ds_temp.Object.prac_id[i]
	IF dw_selected_prac.RowCount( ) > 0 then
		li_find = dw_selected_prac.Find( "prac_id = " + String( li_prac_id ), 1, dw_selected_prac.RowCount() )
	END IF
	IF li_find > 0 THEN
		CONTINUE
	END IF
	ds_temp.RowsCopy( i, i, Primary!, dw_selected_prac, dw_selected_prac.RowCount() +1, Primary!)

NEXT
st_count.Text = String(dw_selected_prac.RowCount())
DESTROY ds_temp
SetPointer(Arrow!)
RETURN 1


end function

public function integer of_remove_prac (string as_type);Long li_prac_count
Long i

IF as_type = 'S' THEN
	li_prac_count = dw_selected_prac.RowCount()
	IF li_prac_count > 0 THEN
		FOR i = dw_selected_prac.RowCount() To 1 Step -1
			IF dw_selected_prac.IsSelected(i) THEN   dw_selected_prac.DeleteRow(i)
		NEXT
	END IF
ELSEIF as_type = 'A'  THEN
	dw_selected_prac.reset()
END IF
st_count.text=string(dw_selected_prac.rowcount())
RETURN 1

end function

public function integer of_process ();//Batch add a address to the specified practitioners - Nova 04.20.2009
//Performance tuning - Alfee 05.26.2009

Integer res
integer chk
integer li_b, li_p, li_a, li_m, li_e, li_d, cnt  //maha 01.24.2012
Long  i, j, ll_prac_count, ll_record_id
Long  li_row_cnt, ll_add_row, ll_new_row, ll_seq_no
Long  ll_prac_id, li_facility_id, ll_prac_ids[]
Long 	ll_mailing, ll_billing, ll_home_address, ll_primary_office
Long  ll_additional_office, ll_include_in_directory, ll_exp_letters
String ls_new_value, ls_mailing_address, ls_filter
DateTime ldt_date

ll_prac_count = dw_selected_prac.RowCount()
IF ll_prac_count <= 0 THEN RETURN 0

//Initialize DataStores
n_cst_datastore lds_address 
n_cst_datastore lds_group_practic
n_cst_datastore lds_group_practic_mailling
n_cst_datastore lds_address_link_check
n_cst_datastore lds_facilities
n_cst_datastore lds_address_update
n_cst_datastore lds_address_link_update
n_cst_datastore lds_sys_audit_update 

lds_address = Create n_cst_datastore
lds_group_practic = Create n_cst_datastore
lds_group_practic_mailling = Create n_cst_datastore
lds_address_link_check = Create n_cst_datastore
lds_facilities = Create n_cst_datastore
lds_address_update = Create n_cst_datastore
lds_address_link_update = Create n_cst_datastore
lds_sys_audit_update = Create n_cst_datastore

lds_address.DataObject = "d_update_address"
lds_group_practic.DataObject = "d_update_address_group"
lds_group_practic_mailling.DataObject = "d_update_address_group_mailingaddress"
lds_address_link_check.DataObject = "d_update_address_link_check"
lds_facilities.DataObject = "d_address_link_parent_facility_id_bat"
lds_address_update.DataObject = "d_update_address"
lds_address_link_update.DataObject = "d_addr_link_check_boxes"
lds_sys_audit_update.DataObject = "d_view_audit"

lds_address.SetTransObject(sqlca)
lds_group_practic.SetTransObject(sqlca)
lds_group_practic_mailling.SetTransObject(sqlca)
lds_address_link_check.SetTransObject(sqlca)
lds_facilities.SetTransObject( sqlca )
lds_address_update.SetTransObject(sqlca)
lds_address_link_update.SetTransObject( sqlca)
lds_sys_audit_update.SetTransObject( sqlca)

SetPointer(HourGlass!)
st_process.Text = ""

//Get Source Data 
FOR i = 1 to ll_prac_count
	ll_prac_ids[i] = dw_selected_prac.Object.prac_id[i]
NEXT

gnv_appeondb.of_StartQueue()
lds_address.Retrieve(ll_prac_ids, il_gp_id)
lds_facilities.Retrieve(ll_prac_ids)
chk = lds_group_practic.Retrieve(il_gp_id)
lds_group_practic_mailling.Retrieve(il_gp_id)
lds_address_link_check.Retrieve(ll_prac_ids)
SELECT isnull(max(seq_no),0) INTO :ll_seq_no	From sys_audit;
gnv_appeondb.of_CommitQueue()

//Start Code Change ----07.20.2009 #V92 maha
chk = lds_group_practic.rowcount() //alfee 01.07.2010
if chk < 1 then
	messagebox("of_process","Failed to retrieve Group data for id  " + string(il_gp_id) + " Contact ISG support.")
	return -1 
end if
//End Code Change---07.20.2009

//Start Code Change ----01.24.2012 #V12 maha - set addr type defaults
if cbx_add.checked = true then li_a = 1
if cbx_prim.checked = true then li_p = 1
if cbx_exp.checked then li_e = 1
if cbx_bill.checked then li_b = 1
if cbx_mail.checked then li_m = 1
if cbx_dir.checked then li_d = 1
//End Code Change ----01.24.2012

FOR i = 1 To ll_prac_count
	//st_process.Text = String(i) + '/ ' + String(ll_prac_count)

	//Determine if the address is already existed
	ll_prac_id = dw_selected_prac.Object.prac_id[i]
	res = lds_address.setfilter("prac_id= " + string(ll_prac_id) + " and gp_id="+string(il_gp_id))
	if res < 0 then messagebox( "Address add","Filter failed in of_process" )
	lds_address.filter()
	IF lds_address.rowcount() > 0 THEN CONTINUE
	
	cnt++
	st_process.Text = String(cnt) + '/ ' + String(ll_prac_count)
	//--------Begin Added by Nova 09.25.2010------------------------
	//V10.5 SK Group Practice 
	if i<ll_prac_count then
		 is_praclist=is_praclist+string(ll_prac_id)+','
	else
		is_praclist=is_praclist+string(ll_prac_id)
   end if
	//--------End Added --------------------------------------------
	//Add Address 
	ll_record_id = gnv_app.of_get_id( "RECORD_ID")
	lds_group_practic.RowsCopy( 1, 1, Primary!, lds_address_update, lds_address_update.RowCount() +1, Primary!)
	
	lds_address_update.SetItem( lds_address_update.RowCount(), "rec_id", ll_record_id)
	lds_address_update.SetItem( lds_address_update.RowCount(), "prac_id", ll_prac_id)
	lds_address_update.SetItem( lds_address_update.RowCount(), "active_status", 1)
	lds_address_update.SetItem( lds_address_update.RowCount(), "gp_id", il_gp_id)
			
	//Add Address Link 
	ls_mailing_address = lds_group_practic_mailling.GetItemString(1,"code_lookup_description")
	lds_facilities.setfilter("prac_id="+string(ll_prac_id))
	lds_facilities.filter()
	li_row_cnt=lds_facilities.rowcount( )
	
	FOR j = 1 To li_row_cnt
		//Start Code Change ----01.24.2012 #V12 maha - modifed set functionality using instance variable and testing for existing addr types
		ll_mailing = li_m
		ll_billing = li_b
		ll_primary_office = li_p
		ll_additional_office = li_a
		ll_include_in_directory = li_d
		ll_exp_letters = li_e
		li_facility_id = lds_facilities.GetItemNumber( j, "parent_facility_id" )		
		//Get address type			
		
//		IF Not IsNull(ls_mailing_address) THEN

//		IF Not IsNull(is_addr_type) THEN  //Start Code Change ----10.29.2015 #V15 maha - removed check
			ls_filter = "prac_id="+string(ll_prac_id)+" and facility_id="+string(li_facility_id)
			if li_p = 1 then //check for primary office
				res = lds_address_link_check.SetFilter(ls_filter + " and name='primary office'")
				lds_address_link_check.Filter()
				IF lds_address_link_check.RowCount() > 0 THEN //if primary exists, set as additional
					ll_primary_office = 0
					ll_additional_office = 1
					messagebox("Existing Primary", "Provider Id number:" + string(ll_prac_id) + " has an existing Primary Address will be be linked as Additional. ")   //Start Code Change ----12.03.2015 #V15 maha - added for alleghany
				end if
			end if
			if li_m = 1 then //check for mailing
				res = lds_address_link_check.SetFilter(ls_filter + " and name='mailing'")
				lds_address_link_check.Filter()
				IF lds_address_link_check.RowCount() > 0 THEN ll_mailing = 0
			end if
			if li_e = 1 then //check for exp cred
				res = lds_address_link_check.SetFilter(ls_filter + " and name='exp cred letter'")
				lds_address_link_check.Filter()
				IF lds_address_link_check.RowCount() > 0 THEN ll_exp_letters = 0
			end if		
//			CHOOSE CASE Lower(String(ls_mailing_address))
//				CASE "additional office"
//					ll_additional_office = 1
//				CASE "primary office"
//					lds_address_link_check.SetFilter(ls_filter + " and name='primary office'")
//					lds_address_link_check.Filter()
//					IF lds_address_link_check.RowCount() = 0 THEN ll_primary_office = 1
//				CASE "home"
//					ll_home_address = 1
//				CASE "billing"
//					ll_billing = 1
//				CASE "mailing"
//					lds_address_link_check.SetFilter(ls_filter + " and name='mailing'")
//					lds_address_link_check.Filter()
//					IF lds_address_link_check.RowCount() = 0 THEN ll_mailing = 1
//				CASE "exp cred letter"
//					lds_address_link_check.SetFilter(ls_filter + " and name='exp cred letter'")
//					lds_address_link_check.Filter()
//					IF lds_address_link_check.RowCount() = 0 THEN ll_exp_letters = 1
//			END CHOOSE
	//End Code Change ----01.24.2012
//		END IF
		//Set address link
		ll_add_row = lds_address_link_update.InsertRow( 0)
		lds_address_link_update.SetItem( ll_add_row, "address_id", ll_record_id)
		lds_address_link_update.SetItem( ll_add_row, "prac_id", ll_prac_id)
		lds_address_link_update.SetItem( ll_add_row, "facility_id", li_facility_id)
		lds_address_link_update.SetItem( ll_add_row, "mailing", ll_mailing)
		lds_address_link_update.SetItem( ll_add_row, "billing", ll_billing)
		lds_address_link_update.SetItem( ll_add_row, "include_in_directory", 0)
		lds_address_link_update.SetItem( ll_add_row, "prac_correspondence", 0)
		lds_address_link_update.SetItem( ll_add_row, "exp_letters", ll_exp_letters)
		lds_address_link_update.SetItem( ll_add_row, "home_address", ll_home_address)
		lds_address_link_update.SetItem( ll_add_row, "additional_office", ll_additional_office)
		lds_address_link_update.SetItem( ll_add_row, "primary_office", ll_primary_office)
		lds_address_link_update.SetItem( ll_add_row, "include_in_directory", li_d)
	END FOR 
		
	//Add aduit record
	ldt_date = DateTime( Today(), Now() )
	ls_new_value = lds_group_practic.GetItemString(1, "street")
	ll_seq_no++
	
	ll_new_row = lds_sys_audit_update.InsertRow(0)
	lds_sys_audit_update.SetItem( ll_new_row, "rec_id", ll_record_id)
	lds_sys_audit_update.SetItem( ll_new_row, "field_id", 1000)
	lds_sys_audit_update.SetItem( ll_new_row, "seq_no", ll_seq_no)
	lds_sys_audit_update.SetItem( ll_new_row, "table_id", 20)
	lds_sys_audit_update.SetItem( ll_new_row, "prac_id", ll_prac_id)
	lds_sys_audit_update.SetItem( ll_new_row, "new_value", ls_new_value)
	lds_sys_audit_update.SetItem( ll_new_row, "user_id", gs_user_id)
	lds_sys_audit_update.SetItem( ll_new_row, "date_time_modified", ldt_date)
	lds_sys_audit_update.SetItem( ll_new_row, "audit_type", 'I')
	lds_sys_audit_update.SetItem( ll_new_row, "sys_audit_exported", 1)
	lds_sys_audit_update.SetItem( ll_new_row, "facility_id", 0)
END FOR

//Update to DB
SQLCA.AutoCommit = FALSE
res = gnv_appeondb.of_update(lds_address_update, lds_address_link_update, lds_sys_audit_update)
CHOOSE CASE res
	CASE 1
		MessageBox("Save", "Update Complete")
	CASE 103
		SQLCA.AutoCommit = TRUE
		MessageBox("Save Error", "Unable to Update Sys Audit. Save not made")
	CASE 102
		SQLCA.AutoCommit = TRUE
		MessageBox("Save Error", "Unable to Update Address Link. Save not made")
	CASE 101
		SQLCA.AutoCommit = TRUE
		MessageBox("Save Error", "Unable to Update Address. Save not made")
END CHOOSE
SQLCA.AutoCommit = TRUE

Destroy lds_address
Destroy lds_group_practic
Destroy lds_address_update
Destroy lds_group_practic_mailling
Destroy lds_address_link_update
Destroy lds_address_link_check
Destroy lds_sys_audit_update

SetPointer ( Arrow!)

st_process.Text+= " records added"  //Start Code Change ----01.24.2012 #V12 maha

IF res <> 1 THEN RETURN -1

RETURN 1
		
end function

public function integer of_cachepracdata (long al_currrow, long al_rowcount, long al_cachecounter, long al_gp_id);Long i, j
Long ll_EndRow
Long ll_prac_id_arr[]

// Get  prac_id
ll_EndRow = al_CurrRow + al_CacheCounter - 1
IF ll_EndRow > al_RowCount THEN ll_EndRow = al_RowCount
FOR i = al_CurrRow To ll_EndRow
	j ++
	ll_prac_id_arr[j] = dw_selected_prac.Object.prac_id[i]
NEXT
// Retrieve data
gnv_appeondb.of_StartQueue()
ids_address.Retrieve(ll_prac_id_arr[],al_gp_id)
ids_facilities.Retrieve( ll_prac_id_arr[] )
gnv_appeondb.of_CommitQueue()
RETURN 1

end function

public function integer of_process_bk ();Long i,ll_prac_count,ll_prac_id,j
Long ll_count,ll_record_id
Long li_row_cnt,li_facility_id
String ls_mailing_address
//
Long 	ll_mailing = 0
Long  ll_billing = 0
Long  ll_home_address = 0
Long  ll_primary_office = 0
Long  ll_additional_office = 0
Long  ll_include_in_directory = 0
Long  ll_exp_letters = 0
Long ll_add_row,ll_new_row

Long ll_seq_no
String ls_user_id,ls_new_value
DateTime ldt_date

long ll_CacheCounter
constant long LL_CACHE_RECORDS = 10

//initialization
ll_CacheCounter = LL_CACHE_RECORDS


n_cst_datastore lds_address_update
n_cst_datastore lds_group_practic
n_cst_datastore lds_group_practic_mailling
n_cst_datastore lds_address_link
n_cst_datastore lds_address_link_check
n_cst_datastore lds_sys_audit


ids_address = Create n_cst_datastore
lds_group_practic = Create n_cst_datastore
lds_address_update = Create n_cst_datastore
lds_group_practic_mailling = Create n_cst_datastore
lds_address_link = Create n_cst_datastore
lds_address_link_check = Create n_cst_datastore
lds_sys_audit = Create n_cst_datastore
ids_facilities = Create n_cst_datastore
SetPointer(HourGlass!)
st_process.Text = ""
ll_prac_count = dw_selected_prac.RowCount()
IF ll_prac_count > 0 THEN
	SELECT  isnull(max(seq_no),0)
		INTO :ll_seq_no
		From sys_audit;
	IF IsNull(ll_seq_no) THEN ll_seq_no = 0
	
	ids_address.DataObject = "d_update_address"
	ids_address.SetTransObject(sqlca)
	
	lds_group_practic.DataObject = "d_update_address_group"
	lds_group_practic.SetTransObject(sqlca)
	
	lds_address_update.DataObject = "d_update_address"
	lds_address_update.SetTransObject(sqlca)
	
	lds_group_practic_mailling.DataObject = "d_update_address_group_mailingaddress"
	lds_group_practic_mailling.SetTransObject(sqlca)
	
	ids_facilities.DataObject = "d_address_link_parent_facility_id_bat"
	ids_facilities.SetTransObject( sqlca )
	
	lds_address_link_check.DataObject = "d_update_address_link_check"
	lds_address_link_check.SetTransObject(sqlca)
	
	lds_address_link.DataObject = "d_addr_link_check_boxes"
	lds_address_link.SetTransObject( sqlca)
	
	lds_sys_audit.DataObject = "d_view_audit"
	lds_sys_audit.SetTransObject( sqlca)
	
	gnv_appeondb.of_StartQueue()
	lds_group_practic.Retrieve(il_gp_id)
	lds_group_practic_mailling.Retrieve(il_gp_id)
	gnv_appeondb.of_CommitQueue()

	
	FOR i = 1 To ll_prac_count
		st_process.Text = String(i)+'/'+String(ll_prac_count)
		ll_prac_id = dw_selected_prac.Object.prac_id[i]
		//find from pd_address ??
		
		if ll_CacheCounter = LL_CACHE_RECORDS then
			of_cachepracdata(i, ll_prac_count, ll_CacheCounter, il_gp_id)
			ll_CacheCounter = 1
		else
			ll_CacheCounter ++
		end if
		ids_address.setfilter("prac_id="+string(ll_prac_id)+" and gp_id="+string(il_gp_id))
		ids_address.filter()
		ll_count=ids_address.rowcount()
		IF ll_count > 0 THEN //find
			CONTINUE
		ELSE //not find
			// get record id from ids
			ll_record_id = gnv_app.of_get_id( "RECORD_ID")
			//insert into pd_address from group_practiceWhere group_practice.rec_id = :il_gp_id
			lds_group_practic.RowsCopy( 1, 1, Primary!, lds_address_update, lds_address_update.RowCount() +1, Primary!)
			
			lds_address_update.SetItem( lds_address_update.RowCount(), "rec_id", ll_record_id)
			lds_address_update.SetItem( lds_address_update.RowCount(), "prac_id", ll_prac_id)
			//active_status
			lds_address_update.SetItem( lds_address_update.RowCount(), "active_status", 1)
			//gp_id
			lds_address_update.SetItem( lds_address_update.RowCount(), "gp_id", il_gp_id)
			//
			
			ls_mailing_address = lds_group_practic_mailling.GetItemString(1,"code_lookup_description")
			
			ids_facilities.setfilter("prac_id="+string(ll_prac_id))
			ids_facilities.filter()
			
			li_row_cnt=ids_facilities.rowcount( )
			
			//loop insert pd_address_link 
			FOR j = 1 To li_row_cnt
				li_facility_id = ids_facilities.GetItemNumber( j, "parent_facility_id" )
				IF IsNull(ls_mailing_address) THEN // no mailing_address then insert director
					//do nothing	
				ELSE
					lds_address_link_check.Retrieve(ll_prac_id,li_facility_id)
					//For Initialization var  Added by  Nova 05.21.2009------------------------
					ll_mailing = 0
					ll_billing = 0
					ll_home_address = 0
					ll_primary_office = 0
					ll_additional_office = 0
					ll_include_in_directory = 0
					ll_exp_letters = 0
					//d_update_address_link_check
					CHOOSE CASE Lower(String(ls_mailing_address))
						CASE "additional office"
							ll_additional_office = 1
						CASE "primary office"
							lds_address_link_check.SetFilter("name='primary office'")
							lds_address_link_check.Filter()
							ll_count = lds_address_link_check.GetItemNumber(1,"flag")
							IF ll_count = 0 THEN
								ll_primary_office = 1
							END IF
						CASE "home"
							ll_home_address = 1
						CASE "billing"
							ll_billing = 1
						CASE "mailing"
							lds_address_link_check.SetFilter("name='mailing'")
							lds_address_link_check.Filter()
							ll_count = lds_address_link_check.GetItemNumber(1,"flag")
							IF ll_count = 0 THEN
								ll_mailing = 1
							END IF
						CASE "exp cred letter"
							lds_address_link_check.SetFilter("name='exp cred letter'")
							lds_address_link_check.Filter()
							ll_count = lds_address_link_check.GetItemNumber(1,"flag")
							IF ll_count = 0 THEN
								ll_exp_letters = 1
							END IF
					END CHOOSE
				END IF
				//insert 
				//d_addr_link_check_boxes
				ll_add_row = lds_address_link.InsertRow( 0)
				lds_address_link.SetItem( ll_add_row, "address_id", ll_record_id)
				lds_address_link.SetItem( ll_add_row, "prac_id", ll_prac_id)
				lds_address_link.SetItem( ll_add_row, "facility_id", li_facility_id)
				lds_address_link.SetItem( ll_add_row, "mailing", ll_mailing)
				lds_address_link.SetItem( ll_add_row, "billing", ll_billing)
				lds_address_link.SetItem( ll_add_row, "include_in_directory", 0)
				lds_address_link.SetItem( ll_add_row, "prac_correspondence", 0)
				lds_address_link.SetItem( ll_add_row, "exp_letters", ll_exp_letters)
				lds_address_link.SetItem( ll_add_row, "home_address", ll_home_address)
				lds_address_link.SetItem( ll_add_row, "additional_office", ll_additional_office)
				lds_address_link.SetItem( ll_add_row, "primary_office", ll_primary_office)
			END FOR
		END IF //find from pd_address
		ls_user_id = gnv_app.of_getuserid()
		ldt_date = DateTime( Today(), Now() )
		ls_new_value = lds_group_practic.GetItemString(1, "street")
		ll_seq_no++
		//insert sys_audit  d_view_audit
		ll_new_row = lds_sys_audit.InsertRow(0)
		lds_sys_audit.SetItem( ll_new_row, "rec_id", ll_record_id)
		lds_sys_audit.SetItem( ll_new_row, "field_id", 1000)
		lds_sys_audit.SetItem( ll_new_row, "seq_no", ll_seq_no)
		lds_sys_audit.SetItem( ll_new_row, "table_id", 20)
		lds_sys_audit.SetItem( ll_new_row, "prac_id", ll_prac_id)
		lds_sys_audit.SetItem( ll_new_row, "new_value", ls_new_value)
		lds_sys_audit.SetItem( ll_new_row, "user_id", ls_user_id)
		lds_sys_audit.SetItem( ll_new_row, "date_time_modified", ldt_date)
		lds_sys_audit.SetItem( ll_new_row, "audit_type", 'I')
		lds_sys_audit.SetItem( ll_new_row, "sys_audit_exported", 1)
		lds_sys_audit.SetItem( ll_new_row, "facility_id", 0)
	END FOR
	//start update
	IF lds_address_update.Update( ) = 1 THEN
		IF lds_address_link.Update( ) = 1 THEN
			IF lds_sys_audit.Update( ) = 1 THEN
				COMMIT;
				MessageBox("Save", "Update Complete")
			ELSE
				ROLLBACK;
				MessageBox("Save Error", "Unable to Update Sys Audit. Save not made")
			END IF
		ELSE
			ROLLBACK;
			MessageBox("Save Error", "Unable to Update Address Link. Save not made")
		END IF
	ELSE
		ROLLBACK;
		MessageBox("Save Error", "Unable to Update Address. Save not made")
	END IF
END IF
//destory
Destroy ids_address
Destroy lds_group_practic
Destroy lds_address_update
Destroy lds_group_practic_mailling
Destroy lds_address_link
Destroy lds_address_link_check
Destroy lds_sys_audit


SetPointer(Arrow!)
RETURN 1
		
		
		
		
		
		
		
		
		
		
		

end function

public function integer of_get_from_group (long al_gpid); //Start Code Change ----02.14.2017 #V153 maha - added
long r
long rc

gs_batch_search lst_search
n_ds lds_locs

lds_locs = create n_ds

lds_locs.dataobject = "d_get_addr_linked_to_group"
lds_locs.settransobject(sqlca)
rc = lds_locs.retrieve(al_gpid)

if rc < 1 then 
	messagebox("Get Providers", "There are no Provider Address records connected to this Location's Group")
	return 0
end if

for r = 1 to rc
	lst_search.li_prac_id[r] = lds_locs.GetItemNumber(r,"prac_id")
	lst_search.ll_facility[r] = lds_locs.GetItemNumber(r,"parent_facility_id")
next

message.powerobjectparm = lst_search

destroy lds_locs

of_add_prac( )


return 1
end function

on w_batch_add_address.create
this.cb_add_group=create cb_add_group
this.cb_1=create cb_1
this.cbx_dir=create cbx_dir
this.cbx_exp=create cbx_exp
this.cbx_mail=create cbx_mail
this.cbx_bill=create cbx_bill
this.cbx_add=create cbx_add
this.cbx_prim=create cbx_prim
this.st_process=create st_process
this.st_count=create st_count
this.st_tip=create st_tip
this.cb_close=create cb_close
this.cb_update=create cb_update
this.cb_rm_all=create cb_rm_all
this.cb_rmprac=create cb_rmprac
this.cb_batchprac=create cb_batchprac
this.cb_addprac=create cb_addprac
this.dw_selected_prac=create dw_selected_prac
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_add_group,&
this.cb_1,&
this.cbx_dir,&
this.cbx_exp,&
this.cbx_mail,&
this.cbx_bill,&
this.cbx_add,&
this.cbx_prim,&
this.st_process,&
this.st_count,&
this.st_tip,&
this.cb_close,&
this.cb_update,&
this.cb_rm_all,&
this.cb_rmprac,&
this.cb_batchprac,&
this.cb_addprac,&
this.dw_selected_prac,&
this.gb_1,&
this.gb_2}
end on

on w_batch_add_address.destroy
destroy(this.cb_add_group)
destroy(this.cb_1)
destroy(this.cbx_dir)
destroy(this.cbx_exp)
destroy(this.cbx_mail)
destroy(this.cbx_bill)
destroy(this.cbx_add)
destroy(this.cbx_prim)
destroy(this.st_process)
destroy(this.st_count)
destroy(this.st_tip)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.cb_rm_all)
destroy(this.cb_rmprac)
destroy(this.cb_batchprac)
destroy(this.cb_addprac)
destroy(this.dw_selected_prac)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;

il_gp_id = Message.DoubleParm
st_count.Text = String(dw_selected_prac.RowCount())
dw_selected_prac.Modify("selected.Visible='0'")
dw_selected_prac.Modify("facility_name.Visible='0'")
dw_selected_prac.Modify("ssn.Visible='0'")
dw_selected_prac.Modify("date_of_birth.Visible='0'")
dw_selected_prac.Modify("active_status.Visible='0'")   //Start Code Change ----02.14.2017 #V153 maha
IF Not IsValid(gnv_logservice) THEN gnv_logservice = Create n_logservice

//Start Code Change ----01.23.2012 #V12 maha
  SELECT code_lookup.description  into :is_addr_type
    FROM {oj group_practice LEFT OUTER JOIN code_lookup ON group_practice.mailing_address = code_lookup.lookup_code}  
   WHERE group_practice.rec_id = :il_gp_id ;
		
//set the checkboxes
IF Not IsNull(is_addr_type) THEN
	CHOOSE CASE Lower(String(is_addr_type))
		CASE "additional office"
			cbx_add.checked = true
		CASE "primary office"
			cbx_prim.checked = true
		CASE "billing"
			cbx_bill.checked = true
		CASE "mailing"
			cbx_mail.checked = true
		CASE "exp cred letter"
			cbx_exp.checked = true
	END CHOOSE
END IF
//End Code Change ----01.23.2012

String ls_fulladdress
//IF IsValid(w_group_practice) THEN
//	IF w_group_practice.tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.GetRow() > 0 THEN
//		ls_fulladdress = w_group_practice.tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.GetItemString( w_group_practice.tab_1.tabpage_gp.tab_2.tabpage_browse.dw_browse.GetRow(), "full_address" )
//	ELSE
//		ls_fulladdress = ""
//	END IF
//END IF
//This.Title = This.Title+'('+ls_fulladdress+')' commented by long.zhang 04.05.2012

IF gb_sk_ver = True THEN  //Start Code Change ----11.19.2010 #V10 maha - hide for SK
	cb_batchprac.visible = false
end if



end event

event close;IF  IsValid(gnv_logservice) THEN  DESTROY gnv_logservice 
end event

type cb_add_group from commandbutton within w_batch_add_address
integer x = 681
integer y = 52
integer width = 809
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Providers Connected to Group"
end type

event clicked; //Start Code Change ----02.14.2017 #V153 maha - added
 long ll_gp 
 integer rc
 boolean lb_run = true
 
 n_ds lds_group
 
 lds_group = create n_ds
 
 lds_group.dataobject = "d_dddw_group_select"
 lds_group.settransobject(sqlca)
rc =  lds_group.retrieve( il_gp_id)
 
 if rc < 1 then
	messagebox("Provider Add","There is no Group connected to this location.")
	lb_run = false
elseif rc > 1 then
	openwithparm(w_group_select_for_add, il_gp_id)
	if message.stringparm = "Cancel" then
		lb_run = false
	else
		ll_gp = message.doubleparm
	end if
else
	ll_gp = lds_group.getitemnumber(1,"group_multi_loc_rec_id") 
end if

destroy  lds_group

if lb_run = true then
	of_get_from_group( ll_gp )
end if
end event

type cb_1 from commandbutton within w_batch_add_address
integer x = 2139
integer y = 52
integer width = 96
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;string ls_mes

ls_mes = "Select the Providers to which you desire to add the Address, and set the address links as desired.~n~n"
ls_mes+= "If an address record exists that is linked to this practice location, the address records will not be added for that provider.~n~n"
ls_mes+= "The program will check for existing links with a Primary Office, Mailing, or Exp Cred setting.  If a Primary exists, the address link in the added record will be set as Additional Office.~n"
ls_mes+= "If a link exists for Mailing or Exp Cred, those settings will be unchecked for the added record.~n~n"
ls_mes+= "No changes will be made to pre-existing data."

messagebox("About Batch Add Addresses", ls_mes)
end event

type cbx_dir from checkbox within w_batch_add_address
integer x = 2016
integer y = 328
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Directory"
end type

type cbx_exp from checkbox within w_batch_add_address
integer x = 1623
integer y = 328
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Exp Cred"
end type

type cbx_mail from checkbox within w_batch_add_address
integer x = 1307
integer y = 328
integer width = 279
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Mailing"
end type

type cbx_bill from checkbox within w_batch_add_address
integer x = 1047
integer y = 328
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Billing"
end type

type cbx_add from checkbox within w_batch_add_address
integer x = 517
integer y = 328
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Additional Office"
end type

event clicked;if this.checked then cbx_prim.checked = false
end event

type cbx_prim from checkbox within w_batch_add_address
integer x = 73
integer y = 328
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Primary Office"
end type

event clicked;if this.checked then cbx_add.checked = false
end event

type st_process from statictext within w_batch_add_address
integer x = 1897
integer y = 184
integer width = 640
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
alignment alignment = right!
boolean focusrectangle = false
end type

type st_count from statictext within w_batch_add_address
integer x = 480
integer y = 168
integer width = 183
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
boolean focusrectangle = false
end type

type st_tip from statictext within w_batch_add_address
integer x = 27
integer y = 172
integer width = 1056
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "You have selected                   Providers(s)."
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_batch_add_address
integer x = 2290
integer y = 48
integer width = 279
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//--------Begin Modified by  Nova 09.25.2010------------------------
//V10.5 SK Group Practice 
//close(parent)
closewithreturn(parent,is_praclist)
//--------End Modified --------------------------------------------
end event

type cb_update from commandbutton within w_batch_add_address
integer x = 1257
integer y = 176
integer width = 544
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Address Records"
end type

event clicked;IF dw_selected_prac.RowCount( ) = 0 THEN RETURN
//--------Begin Added by Nova 05.21.2009------------------------
//BugE050602
IF MessageBox("Batch Add","Are you sure you want to add the address for these practitioners?",Question!,YesNo!,1) = 1 THEN
	of_process()
END IF
//--------End Added --------------------------------------------





end event

type cb_rm_all from commandbutton within w_batch_add_address
integer x = 1801
integer y = 52
integer width = 334
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Re&move All "
end type

event clicked;of_remove_prac('A')

end event

type cb_rmprac from commandbutton within w_batch_add_address
integer x = 1490
integer y = 52
integer width = 311
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Remove "
end type

event clicked;of_remove_prac('S')

end event

type cb_batchprac from commandbutton within w_batch_add_address
integer x = 366
integer y = 52
integer width = 315
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Add "
end type

event clicked;
OpenWithParm(w_batch_prac_select_new,"G")

IF Message.StringParm = "Cancel" THEN
	RETURN
ELSE
	of_add_prac( )
END IF

end event

type cb_addprac from commandbutton within w_batch_add_address
integer x = 55
integer y = 52
integer width = 311
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;gs_search lstr_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "ADDRESS"
//
OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	RETURN -1
ELSE
	of_add_prac()
END IF



end event

type dw_selected_prac from datawindow within w_batch_add_address
integer x = 14
integer y = 444
integer width = 2565
integer height = 1740
integer taborder = 10
string title = "Selected Providers"
string dataobject = "d_extended_search_list_multi_ds"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;Boolean result
IF row > 0 THEN
	result = This.IsSelected(row)
	IF result THEN
		This.SelectRow(row, False)
	ELSE
		This.SelectRow(row, True)
	END IF
END IF


end event

type gb_1 from groupbox within w_batch_add_address
integer x = 27
integer width = 2240
integer height = 164
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Providers"
end type

type gb_2 from groupbox within w_batch_add_address
integer x = 46
integer y = 260
integer width = 2309
integer height = 172
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Links Settings"
end type

