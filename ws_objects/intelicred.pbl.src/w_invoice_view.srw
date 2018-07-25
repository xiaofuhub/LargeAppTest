$PBExportHeader$w_invoice_view.srw
forward
global type w_invoice_view from w_master
end type
type cb_prior from commandbutton within w_invoice_view
end type
type cb_curr from commandbutton within w_invoice_view
end type
type st_month from statictext within w_invoice_view
end type
type dw_log from datawindow within w_invoice_view
end type
type tab_1 from tab within w_invoice_view
end type
type tabpage_browse from userobject within tab_1
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
dw_browse dw_browse
end type
type tabpage_detail from userobject within tab_1
end type
type cb_output from uo_cb_output within tabpage_detail
end type
type dw_inv_records from u_dw within tabpage_detail
end type
type dw_inv_header from u_dw within tabpage_detail
end type
type cb_print from commandbutton within tabpage_detail
end type
type cb_view from commandbutton within tabpage_detail
end type
type cb_delete from commandbutton within tabpage_detail
end type
type cb_save from commandbutton within tabpage_detail
end type
type cb_inv from commandbutton within tabpage_detail
end type
type cb_charges from commandbutton within tabpage_detail
end type
type dw_sets from datawindow within tabpage_detail
end type
type gb_2 from groupbox within tabpage_detail
end type
type dw_detail from u_dw within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
cb_output cb_output
dw_inv_records dw_inv_records
dw_inv_header dw_inv_header
cb_print cb_print
cb_view cb_view
cb_delete cb_delete
cb_save cb_save
cb_inv cb_inv
cb_charges cb_charges
dw_sets dw_sets
gb_2 gb_2
dw_detail dw_detail
end type
type tab_1 from tab within w_invoice_view
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
type cb_refresh from commandbutton within w_invoice_view
end type
type dw_range from u_dw within w_invoice_view
end type
type dw_facility from datawindow within w_invoice_view
end type
type cb_close from commandbutton within w_invoice_view
end type
type gb_f from groupbox within w_invoice_view
end type
type gb_1 from groupbox within w_invoice_view
end type
type cb_help from commandbutton within w_invoice_view
end type
type dw_charge from datawindow within w_invoice_view
end type
end forward

global type w_invoice_view from w_master
integer x = 14
integer y = 16
integer width = 4224
integer height = 2588
string title = "Print Invoices"
windowtype windowtype = popup!
long backcolor = 33551856
boolean center = true
cb_prior cb_prior
cb_curr cb_curr
st_month st_month
dw_log dw_log
tab_1 tab_1
cb_refresh cb_refresh
dw_range dw_range
dw_facility dw_facility
cb_close cb_close
gb_f gb_f
gb_1 gb_1
cb_help cb_help
dw_charge dw_charge
end type
global w_invoice_view w_invoice_view

type variables
boolean ib_get_inv = true
integer ii_facil
integer ii_usedates = 1
long il_status
long il_prac
long il_req
string is_type
string is_ret_type
n_cst_invoice_functions in_invoice
end variables

forward prototypes
public function integer of_get_charges (long al_facility, date ad_from, date ad_to, boolean ab_ver, boolean ab_rec, boolean ab_apps)
public function integer of_create_invoice ()
public function integer of_create_inv_records (long al_facility, datetime ad_from, datetime ad_to, long al_inv_id)
public function integer of_create_log (string act_type)
public function integer of_view_invoice (boolean ab_view)
public function integer of_set_date_range (string as_month)
public function integer of_security ()
end prototypes

public function integer of_get_charges (long al_facility, date ad_from, date ad_to, boolean ab_ver, boolean ab_rec, boolean ab_apps);//Start Code Change ----08.24.2016 #V153 maha - added for creation of invoice charges
// ii_facil, ld_from,  ld_to, true, false, false)

return 1


//decimal ll_fee
//long v
//long vc = 0
//long r
//long rc = 0
//long a
//long ac = 0
//long nr
//long ll_find
//long ll_id
//long ll_inv
//long ll_cnt
//long ll_recid
//long ll_prac
//long ll_pracs[]
//long ll_act
//long ll_app
//long ll_status
//string ls_ref
//string ls_filter
//string ls_doc_id
//string ls_sql
//string ls_sql_org
//string ls_where
//string ls_crit
//string ls_from_date
//string ls_to_date
//datetime ld_charge
//datetime ldt_from
//datetime ldt_to
//datetime ldt_now
//integer res
//integer rcnt
//integer li_rules
//n_ds lds_ver
//n_ds lds_rec
//n_ds lds_apps
//datawindow lds_charge
//n_ds lds_rules
//
//
//ldt_from = datetime(ad_from, time("00:00:00"))
//ls_from_date = of_date_to_string(ldt_from, "yyyy-mm-dd")
//ls_from_date = ls_from_date + " 00:00:00"
//ldt_to = datetime(ad_to, time("23:59:59"))
//ls_to_date = of_date_to_string(ldt_to, "yyyy-mm-dd")
//ls_to_date = ls_to_date + " 23:59:59"
//ldt_now = datetime(today(), now())
//debugbreak()
//ll_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Complete') + "'"))	
//
////get rules
//lds_rules = create n_ds
//lds_rules.dataobject = "d_facility_bill_browse"
//lds_rules.settransobject(sqlca)
//lds_rules.retrieve(al_facility)
//
//lds_charge = dw_charge
////	lds_charge = create n_ds
////	lds_charge.dataobject = "d_invoice_items"
//lds_charge.settransobject(sqlca)
//
////verification charges
//if ab_ver then
//	lds_ver = create n_ds
//	lds_ver.dataobject = "d_invoice_charge_ver"
//	lds_ver.settransobject(sqlca)
//	vc = lds_ver.retrieve( ldt_from, ldt_to, al_facility)
//	if vc < 1 then messagebox("of_get_charges","Verification record failed.")
//	
//	for v = 1 to vc
//		nr = lds_charge.insertrow(0)
//		ll_prac = lds_ver.getitemnumber(v, "prac_id")
//		ll_recid =  lds_ver.getitemnumber(v, "rec_id")
//		ls_ref =  lds_ver.getitemstring(v, "reference_value")
//		ll_fee = lds_ver.getitemnumber(v, "fee")
//		ls_doc_id = lds_ver.getitemstring(v, "doc_id")
//		ld_charge = lds_ver.getitemdatetime(v, "date_recieved")
//		
//		lds_charge.setitem(nr, "prac_id", ll_prac)
//		lds_charge.setitem(nr, "facility_id", al_facility)
//		lds_charge.setitem(nr, "ref_number", ll_recid)
//		lds_charge.setitem(nr, "billing_item", ls_ref)
//		lds_charge.setitem(nr, "quantity", 1)
//		lds_charge.setitem(nr, "price", ll_fee)
//		lds_charge.setitem(nr, "rec_id", ll_recid)
//		lds_charge.setitem(nr, "doc_id", ls_doc_id)
//		lds_charge.setitem(nr, "charge_date", ld_charge)
//		lds_charge.setitem(nr, "add_date", today())
//		lds_charge.setitem(nr, "add_user", gs_user_id)
//		lds_charge.setitem(nr, "charge_type", "V")
//		
//	next	
//end if
//
////RECURRING
//if ab_rec then
//	ls_filter = "bill_type = 'R' and active_status = 1"
//	res = lds_rules.setfilter(ls_filter)
//	if res < 0 then messagebox("Recurring filter failed", ls_filter)
//	lds_rules.filter()
//	rcnt = lds_rules.rowcount()
//	
//	lds_rec = create n_ds
//	lds_rec.dataobject = "d_invoice_charge_recur"
//	lds_rec.settransobject(sqlca)
//	
//	if rcnt > 0 then
//		for li_rules = 1 to rcnt
//			ls_sql_org = lds_rec.GetSQLSelect()
//			ls_sql = ls_sql_org
//			ls_crit  = lds_rules.getitemstring(li_rules, "provider_criteria")
//			ls_where = " and (pd_affil_stat.parent_facility_id = " + string(al_facility) + ") and "
//			if isnull(ls_crit) or ls_crit = "" then
//				ls_where+= " (pd_affil_stat.active_status in (1,4) )"
//			else
//				ls_where+= ls_where
//			end if
//			
//			ls_sql+= ls_where
//			
//			lds_rec.SetSQLSelect(ls_sql)
//			lds_rec.settransobject(sqlca)
//			rc = lds_rec.retrieve()
//			if rc < 0 then
//				messagebox("Recurring retrieval failed", ls_sql)
//			end if
//			
//			for r = 1 to rc
//				nr = lds_charge.insertrow(0)
//				ll_prac = lds_rec.getitemnumber(r, "prac_id")
//				ll_recid =  lds_rec.getitemnumber(r, "rec_id")
//				ls_ref  = lds_rules.getitemstring(1, "description")
//				ll_fee  = lds_rules.getitemnumber(1, "bill_amount")
//				//for docid get rec id and prac id
//				ls_doc_id = string(ll_recid) + "-" + string(ll_prac)
//				
//				lds_charge.setitem(nr, "prac_id", ll_prac)
//				lds_charge.setitem(nr, "facility_id", al_facility)
//				lds_charge.setitem(nr, "ref_number", ll_recid)
//				lds_charge.setitem(nr, "billing_item", ls_ref)
//				lds_charge.setitem(nr, "quantity", 1)
//				lds_charge.setitem(nr, "price", ll_fee)
//				lds_charge.setitem(nr, "rec_id", ll_recid)
//				lds_charge.setitem(nr, "doc_id", ls_doc_id)
//				lds_charge.setitem(nr, "charge_date", ad_to )
//				lds_charge.setitem(nr, "add_date", today())
//				lds_charge.setitem(nr, "add_user", gs_user_id)
//				lds_charge.setitem(nr, "charge_type", "R")
//			next
//			
//			lds_rec.SetSQLSelect(ls_sql_org)
//			lds_rec.settransobject(sqlca)
//		next
//	end if
//
//end if
//
//debugbreak()
////APPLICATION charges
//if ab_apps then
//	lds_apps = create n_ds
//	lds_apps.dataobject = "d_invoice_charge_apps"
//	lds_apps.settransobject(sqlca)
//
//	ls_filter = "bill_type = 'A' and active_status = 1"
//	res = lds_rules.setfilter(ls_filter)
//	if res < 0 then messagebox("Recurring filter failed", ls_filter)
//	lds_rules.filter()
//	rcnt = lds_rules.rowcount()
//	
//	if rcnt > 0 then
//		for li_rules = 1 to rcnt
//			ls_sql_org = lds_apps.GetSQLSelect()
//			ls_sql = ls_sql_org
//			ls_crit  = lds_rules.getitemstring(li_rules, "provider_criteria")
//			ll_act = lds_rules.getitemnumber(li_rules, "action_type_id")
//			ll_app = lds_rules.getitemnumber(li_rules, "app_id")
//			if isnull(ll_act) then
//				messagebox("Application rules setup error","For an Application type billing rule there is no action type selected.  Skipping charge creation for this step")
//				Continue
//			end if
//					
//			ls_where = " and ( pd_affil_stat.parent_facility_id = " + string(al_facility) + ")"
//			ls_where+= " and  ( net_dev_action_items.action_status =  " + string(ll_status) + " ) and "
//			if isnull(ls_crit) or ls_crit = "" then
//				ls_where+= " ( pd_affil_stat.active_status in (1,4) )"
//			else
//				ls_where+= ls_where
//			end if
//			
//			ls_where+= " and ( net_dev_action_items.action_type = " + string(ll_act) + ") "
//			
//			if ll_app > 0 then
//				ls_where+= " and  (net_dev_action_items.app_id = " + string(ll_app) + ") "
//			end if
//			
//			//set date range			
//       	 	ls_where+= " and  ( net_dev_action_items.action_date >= '" + ls_from_date + "' ) "
//        		ls_where+= " and  ( net_dev_action_items.action_date <= '" +  ls_to_date  + "' ) "			
//			
//			ls_sql+= ls_where
//			
//			lds_apps.SetSQLSelect(ls_sql)
//			lds_apps.settransobject(sqlca)
//			ac = lds_apps.retrieve()
//			if ac < 0 then
//				messagebox("Applications retrieval failed", ls_sql)
//			end if
//			messagebox("Application retrieval", ls_sql)
//			//clipboard(ls_sql)
//			
//			for a = 1 to ac
//				nr = lds_charge.insertrow(0)
//				ll_prac = lds_apps.getitemnumber(a, "prac_id")
//				ll_recid =  lds_apps.getitemnumber(a, "rec_id")
//				ls_ref  = lds_rules.getitemstring(1, "description")
//				ll_fee  = lds_rules.getitemnumber(1, "bill_amount")
//				//for docid get rec id and prac id
//				ls_doc_id =  lds_apps.getitemstring(a, "doc_id")
//				ld_charge = lds_apps.getitemdatetime(a, "action_date")
//				
//				lds_charge.setitem(nr, "prac_id", ll_prac)
//				lds_charge.setitem(nr, "facility_id", al_facility)
//				lds_charge.setitem(nr, "ref_number", ll_recid)
//				lds_charge.setitem(nr, "billing_item", ls_ref)
//				lds_charge.setitem(nr, "quantity", 1)
//				lds_charge.setitem(nr, "price", ll_fee)
//				lds_charge.setitem(nr, "rec_id", ll_recid)
//				lds_charge.setitem(nr, "doc_id", ls_doc_id)
//				lds_charge.setitem(nr, "charge_date", ld_charge)
//				lds_charge.setitem(nr, "add_date", today())
//				lds_charge.setitem(nr, "add_user", gs_user_id)
//				lds_charge.setitem(nr, "charge_type", "A")
//			next
//			
//			lds_apps.SetSQLSelect(ls_sql_org)
//			lds_apps.settransobject(sqlca)
//		next
//	end if
//
//end if
//
////set the item ids	
////,"invt_id"	
//select max(item_id) into :ll_id from pd_inv_rows;
//if isnull(ll_id) then ll_id = 0
//
//for r = 1 to lds_charge.rowcount()
//	ll_id++
//	lds_charge.setitem(r, "item_id", ll_id)
//next
//
//v = lds_charge.update()
////if v < 1 then messagebox("Update failed", lds_charge.DBErrorMessage)
//
////create the pd_invoice records
//
//
//if isvalid(lds_ver) then destroy lds_ver
//if isvalid(lds_rec) then destroy lds_rec
//if isvalid(lds_apps) then destroy lds_apps
//if isvalid(lds_charge) then destroy lds_charge
//if isvalid(lds_rules) then destroy lds_rules
//
//return 1
end function

public function integer of_create_invoice ();//Start Code Change ----08.30.2016 #V153 maha








return 1


end function

public function integer of_create_inv_records (long al_facility, datetime ad_from, datetime ad_to, long al_inv_id);//Start Code Change ----09.07.2016 #V153 maha - added for creation of invoice records

decimal ll_fee
decimal ll_ext
long r
long rc = 0
long nr
datetime ldt_from
datetime ldt_to
datetime ldt_now
integer li_qty
datawindow ldw_inv_records
 ldw_inv_records = tab_1.tabpage_detail.dw_inv_records


ldt_from = ad_from
ldt_to = ad_to
ldt_now = datetime(today(), now())

rc = dw_charge.rowcount() //

for r = 1 to rc
	nr = ldw_inv_records.insertrow(0)
	ldw_inv_records.setitem(nr , "prac_id", dw_charge.getitemnumber(r , "prac_id"))
	ldw_inv_records.setitem(nr , "facility_id", dw_charge.getitemnumber(r , "facility_id") )
	ldw_inv_records.setitem(nr , "doc_id", dw_charge.getitemstring(r , "doc_id"))
	ldw_inv_records.setitem(nr , "charge_type", dw_charge.getitemstring(r , "charge_type"))
	ldw_inv_records.setitem(nr , "charge_date", dw_charge.getitemdatetime(r , "charge_date") )
	ldw_inv_records.setitem(nr , "ref_number", dw_charge.getitemnumber(r , "ref_number"))
	ldw_inv_records.setitem(nr , "pd_inv_id", dw_charge.getitemnumber(r , "item_id") )
	li_qty = dw_charge.getitemnumber(r , "quantity")
	ldw_inv_records.setitem(nr , "qty", li_qty )
	ll_fee = dw_charge.getitemnumber(r , "price")
	ldw_inv_records.setitem(nr , "bill_amount", ll_fee)
	ll_ext = li_qty * ll_fee
	ldw_inv_records.setitem(nr , "ext_amount", ll_ext)
	ldw_inv_records.setitem(nr , "billing_item", dw_charge.getitemstring(r , "billing_item"))
	ldw_inv_records.setitem(nr , "inv_hdr", al_inv_id)
next

ldw_inv_records.update()


return 1
end function

public function integer of_create_log (string act_type);//Start Code Change ----09.07.2016 #V153 maha - created to track adds, deletes, edits
integer nr

nr = dw_log.insertrow(0)
dw_log.setitem(nr,"user_id", gs_user_id)
dw_log.setitem(nr,"log_type", act_type)
dw_log.setitem(nr,"facility_id",  tab_1.tabpage_detail.dw_inv_header.getitemnumber(1, "facility"))
dw_log.setitem(nr,"date_from",  tab_1.tabpage_detail.dw_inv_header.getitemdatetime(1, "from_date"))
dw_log.setitem(nr,"date_from",  tab_1.tabpage_detail.dw_inv_header.getitemdatetime(1, "to_date"))
dw_log.setitem(nr,"inv_date",  tab_1.tabpage_detail.dw_inv_header.getitemdatetime(1, "invoice_date"))
dw_log.setitem(nr,"invoice_num",  tab_1.tabpage_detail.dw_inv_header.getitemstring(1, "invoice_num"))
dw_log.setitem(nr,"invoice_id",  tab_1.tabpage_detail.dw_inv_header.getitemnumber(1, "invoice_pk"))
dw_log.setitem(nr,"rec_count",  tab_1.tabpage_detail.dw_inv_records.rowcount() )

dw_log.update()

return 1
end function

public function integer of_view_invoice (boolean ab_view);
if ab_view then
	tab_1.tabpage_detail.dw_detail.visible = true
	tab_1.tabpage_detail.dw_inv_header.visible = false
	tab_1.tabpage_detail.dw_inv_records.visible = false
	tab_1.tabpage_detail.cb_view.text = "View Data"
	tab_1.tabpage_detail.cb_print.enabled = true
	tab_1.tabpage_detail.cb_output.enabled = false
	//---------Begin Added by (Appeon)Stephen 02.27.2017 for BugS022702--------
	tab_1.tabpage_detail.cb_charges.enabled = false
	tab_1.tabpage_detail.cb_inv.enabled = false
	tab_1.tabpage_detail.cb_save.enabled = false
	tab_1.tabpage_detail.cb_delete.enabled = false
	//---------End Added ------------------------------------------------------
else
	tab_1.tabpage_detail.dw_detail.visible = false
	tab_1.tabpage_detail.dw_inv_header.visible = true
	tab_1.tabpage_detail.dw_inv_records.visible = true
	tab_1.tabpage_detail.cb_view.text = "View Invoice"
	tab_1.tabpage_detail.cb_print.enabled = false
	tab_1.tabpage_detail.cb_output.enabled = true
	//---------Begin Added by (Appeon)Stephen 02.27.2017 for BugS022702--------
	tab_1.tabpage_detail.cb_charges.enabled = true
	tab_1.tabpage_detail.cb_inv.enabled = true
	tab_1.tabpage_detail.cb_save.enabled = true
	tab_1.tabpage_detail.cb_delete.enabled = true
	//---------End Added ------------------------------------------------------
end if



return 1
end function

public function integer of_set_date_range (string as_month);//Set the date range for the prior month
date ld_from
date ld_to
date ld_now
integer ll_month
integer ll_day
integer ll_year

 //Start Code Change ----03.03.2017 #V153 maha - modified date range logic
ld_now = today() 
 
if as_month = "P" then
	ll_month = month(dw_range.getitemdate(1,"from_date"))
	ll_year = year(dw_range.getitemdate(1,"from_date"))
else
	ll_month = month(ld_now)
	ll_year = year(ld_now)
end if

//ll_month = month(ld_now)


if as_month = "P" then  //prior month
	if ll_month = 1 then
		ll_month = 12
		ll_year = ll_year - 1
	else
		ll_month = ll_month - 1
	end if
end if
 //End Code Change ----03.03.2017


ld_from = date( string(ll_month) + "-" + "01-" +  string(ll_year))

choose case ll_month
	case 1, 3, 5, 7, 8, 10, 12 //(Appeon)Stephen 04.05.2017 --modify '4' to '5' --V15.3 Bug # 5583 - Invoices: clicking Curr month changes "To Date" to 01/01/1900
		ll_day = 31
	case 2
		if mod(ll_year, 4) = 0 then
			ll_day = 29
		else
			ll_day = 28
		end if
	case else
		ll_day = 30
end choose

ld_to = date( string(ll_month) + "-" + string(ll_day) + "-" +  string(ll_year))

dw_range.setitem(1, "from_date",  ld_from)
dw_range.setitem(1, "to_date",  ld_to)



return 1



end function

public function integer of_security ();//Start Code Change ----09.29.2016 #V152 maha - added


if w_mdi.of_security_access( 7827 ) = 1 THEN //read only
	tab_1.tabpage_detail.cb_charges.visible = false
	tab_1.tabpage_detail.cb_delete.visible = false
	tab_1.tabpage_detail.cb_inv.visible = false
	tab_1.tabpage_detail.cb_save.visible = false
end if

if w_mdi.of_security_access( 7828 ) = 0 THEN //create charges
	tab_1.tabpage_detail.cb_charges.visible = false
end if

if w_mdi.of_security_access( 7829 ) = 0 THEN //delete
	tab_1.tabpage_detail.cb_delete.visible = false
end if

	
return 1
end function

on w_invoice_view.create
int iCurrent
call super::create
this.cb_prior=create cb_prior
this.cb_curr=create cb_curr
this.st_month=create st_month
this.dw_log=create dw_log
this.tab_1=create tab_1
this.cb_refresh=create cb_refresh
this.dw_range=create dw_range
this.dw_facility=create dw_facility
this.cb_close=create cb_close
this.gb_f=create gb_f
this.gb_1=create gb_1
this.cb_help=create cb_help
this.dw_charge=create dw_charge
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_prior
this.Control[iCurrent+2]=this.cb_curr
this.Control[iCurrent+3]=this.st_month
this.Control[iCurrent+4]=this.dw_log
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.cb_refresh
this.Control[iCurrent+7]=this.dw_range
this.Control[iCurrent+8]=this.dw_facility
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.gb_f
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_help
this.Control[iCurrent+13]=this.dw_charge
end on

on w_invoice_view.destroy
call super::destroy
destroy(this.cb_prior)
destroy(this.cb_curr)
destroy(this.st_month)
destroy(this.dw_log)
destroy(this.tab_1)
destroy(this.cb_refresh)
destroy(this.dw_range)
destroy(this.dw_facility)
destroy(this.cb_close)
destroy(this.gb_f)
destroy(this.gb_1)
destroy(this.cb_help)
destroy(this.dw_charge)
end on

event open;call super::open;long ll_batch_id
long ll_pracs[]
integer ic
integer i
integer li_type
long p
datawindowchild dwchild
integer li_facility_id
gs_batch_search lst_sent


dw_facility.settransobject(sqlca)

dw_facility.getchild("facility_facility_id",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
dwchild.insertrow(1)
dwchild.setitem(1,"facility_facility_id", 0)
dwchild.setitem(1,"facility_facility_name", "All")
//dw_facility.retrieve(gs_user_id)
dw_facility.insertrow(1)
if li_facility_id < 1 or isnull(li_facility_id) then
	SELECT security_users.default_search_facility  
	INTO :li_facility_id  
	FROM security_users  
	WHERE security_users.user_id = :gs_user_id;
end if

IF Not IsNull( li_facility_id ) THEN //set user default facility
	dw_facility.SetItem( 1, "facility_facility_id", li_facility_id )
	tab_1.tabpage_detail.dw_sets.retrieve(li_facility_id)
END IF
ii_facil = li_facility_id

//in_invoice = create n_cst_invoice_functions
of_set_date_range("C" )   //Start Code Change ----03.03.2017 #V153 maha
of_set_date_range("P" )

cb_refresh.triggerevent(clicked!)

of_security()

end event

event closequery;//no message
end event

event resize;call super::resize;//Start Code Change ----08.08.2016 #V152 maha
long ll_h
long ll_w
long ll_dwh

ll_h = this.workspaceheight( )
ll_w = this.workspacewidth( )

tab_1.height = ll_h - 25 - tab_1.y
tab_1.width = ll_w -  10

tab_1.tabpage_browse.dw_browse.height = tab_1.tabpage_browse.height - 10
tab_1.tabpage_browse.dw_browse.width = tab_1.tabpage_browse.width -10

tab_1.tabpage_detail.dw_detail.width = tab_1.tabpage_detail.width -10
tab_1.tabpage_detail.dw_inv_header.width = tab_1.tabpage_detail.width - 10
tab_1.tabpage_detail.dw_inv_records.width = tab_1.tabpage_detail.width -10

tab_1.tabpage_detail.dw_detail.height = tab_1.tabpage_detail.height -10 - tab_1.tabpage_detail.dw_detail.y
ll_dwh = tab_1.tabpage_detail.dw_detail.height

tab_1.tabpage_detail.dw_inv_header.height = ll_dwh / 2 - 10
tab_1.tabpage_detail.dw_inv_records.height = ll_dwh / 2
tab_1.tabpage_detail.dw_inv_records.y = tab_1.tabpage_detail.dw_inv_header.y + tab_1.tabpage_detail.dw_inv_records.height
//dw_browse.width = ll_w - 25 - 10
end event

type cb_prior from commandbutton within w_invoice_view
integer x = 2587
integer y = 88
integer width = 201
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Prior"
end type

event clicked;of_set_date_range("P" )
end event

type cb_curr from commandbutton within w_invoice_view
integer x = 2382
integer y = 88
integer width = 201
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Curr"
end type

event clicked;of_set_date_range("C" )
end event

type st_month from statictext within w_invoice_view
integer x = 2437
integer y = 40
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Month"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_log from datawindow within w_invoice_view
boolean visible = false
integer x = 2994
integer y = 24
integer width = 224
integer height = 52
integer taborder = 30
string title = "none"
string dataobject = "d_invoice_log"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type tab_1 from tab within w_invoice_view
event create ( )
event destroy ( )
integer y = 220
integer width = 4178
integer height = 2244
integer taborder = 20
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
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

event selectionchanged;choose case newindex
	case 1
		gb_1.text = "Search Invoice Date Range"
	case 2
		gb_1.text = "Create Charges/Invoice Date Range"
end choose
end event

type tabpage_browse from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4142
integer height = 2128
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 33551856
long picturemaskcolor = 536870912
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_browse
integer width = 4142
integer height = 2128
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_invoice_browse_list"
boolean hscrollbar = true
end type

event buttonclicked;call super::buttonclicked;integer i

for i = 1 to this.rowcount()
	this.setitem(i,"selected",1)
next
end event

event clicked;call super::clicked;//
//Integer li_row
//
//li_row = This.GetClickedRow( )
//
//IF li_row < 1 THEN
//	Return
//END IF
//
//
//This.ScrollToRow( li_row )
//This.SetRow( li_row )
////this.selectrow(0,false)
////this.selectrow(li_row,true)
//
end event

event constructor;call super::constructor;this.settransobject(sqlca)

this.of_setrowselect( True) //Added by Appeon long.zhang 02.21.2017 (BugL022103)
end event

event doubleclicked;call super::doubleclicked;
long ll_id


if row > 0 then
	ll_id = this.getitemnumber(row, "invoice_pk")
	tab_1.tabpage_detail.dw_inv_header.retrieve(ll_id)
	tab_1.tabpage_detail.dw_inv_records.retrieve(ll_id)
	tab_1.tabpage_detail.dw_detail.reset()
	of_view_invoice(false)
	ib_get_inv = true
	tab_1.selecttab (2)
end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//IF tab_1.tabpage_detail.dw_detail.RowCount() >= currentrow THEN
	//tab_1.tabpage_detail.dw_detail.SetRow( currentrow )
	//tab_1.tabpage_detail.dw_detail.ScrollToRow( currentrow )
//END IF
//this.selectrow(0,false)
//this.selectrow(this.getrow(),true)

//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_deleterow;
integer res

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	this.deleterow(this.getrow())
end if

this.update()

return 0
end event

type tabpage_detail from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4142
integer height = 2128
long backcolor = 33551856
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 33551856
long picturemaskcolor = 536870912
cb_output cb_output
dw_inv_records dw_inv_records
dw_inv_header dw_inv_header
cb_print cb_print
cb_view cb_view
cb_delete cb_delete
cb_save cb_save
cb_inv cb_inv
cb_charges cb_charges
dw_sets dw_sets
gb_2 gb_2
dw_detail dw_detail
end type

on tabpage_detail.create
this.cb_output=create cb_output
this.dw_inv_records=create dw_inv_records
this.dw_inv_header=create dw_inv_header
this.cb_print=create cb_print
this.cb_view=create cb_view
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_inv=create cb_inv
this.cb_charges=create cb_charges
this.dw_sets=create dw_sets
this.gb_2=create gb_2
this.dw_detail=create dw_detail
this.Control[]={this.cb_output,&
this.dw_inv_records,&
this.dw_inv_header,&
this.cb_print,&
this.cb_view,&
this.cb_delete,&
this.cb_save,&
this.cb_inv,&
this.cb_charges,&
this.dw_sets,&
this.gb_2,&
this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.cb_output)
destroy(this.dw_inv_records)
destroy(this.dw_inv_header)
destroy(this.cb_print)
destroy(this.cb_view)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_inv)
destroy(this.cb_charges)
destroy(this.dw_sets)
destroy(this.gb_2)
destroy(this.dw_detail)
end on

type cb_output from uo_cb_output within tabpage_detail
integer x = 3712
integer y = 72
integer width = 416
integer height = 84
integer taborder = 30
end type

event clicked;

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
//NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
gnv_app.of_popmenu(this,NewMenu.m_options)//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
//this calls events in u_dw
//the save as pdf calls ...
end event

event constructor;call super::constructor;idw = dw_inv_records
end event

type dw_inv_records from u_dw within tabpage_detail
integer y = 1168
integer width = 4133
integer height = 952
integer taborder = 11
string dataobject = "d_invoice_record_create"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_settransobject(sqlca)
end event

type dw_inv_header from u_dw within tabpage_detail
integer y = 192
integer width = 4133
integer height = 952
integer taborder = 11
string dataobject = "d_invoice_header"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_settransobject(sqlca)
end event

type cb_print from commandbutton within tabpage_detail
integer x = 3447
integer y = 72
integer width = 256
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;tab_1.tabpage_detail.dw_detail.print()
end event

type cb_view from commandbutton within tabpage_detail
integer x = 3026
integer y = 72
integer width = 411
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Invoice"
end type

event clicked;long ll_id

if dw_inv_header.rowcount() < 1 then return

if this.text = "View Invoice" then
	if ib_get_inv then
		ll_id = dw_inv_header.getitemnumber(1, "invoice_pk")
		dw_detail.retrieve(ll_id)
		ib_get_inv = false
	end if
	
	of_view_invoice(true)
else
	of_view_invoice(false)
end if




end event

type cb_delete from commandbutton within tabpage_detail
integer x = 2606
integer y = 72
integer width = 411
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Invoice"
end type

event clicked;integer res
long ll_id
long r
long rc

res = messagebox("Delete Invoice","Are you sure you want to delete this invoice? (Charge data will not be deleted.)", question! ,yesno! , 2)

if res = 2 then return

ll_id = dw_inv_header.getitemnumber(1, "invoice_pk")
//create log
of_create_log("D")

rc = dw_inv_records.rowcount() 

for r = 1 to rc
	dw_inv_records.deleterow(1)
next

dw_inv_header.deleterow(1)

dw_inv_header.update()
dw_inv_records.update()
dw_detail.reset()

tab_1.tabpage_browse.dw_browse.rowsdiscard( tab_1.tabpage_browse.dw_browse.getrow(),tab_1.tabpage_browse.dw_browse.getrow(),primary!)

end event

type cb_save from commandbutton within tabpage_detail
integer x = 2190
integer y = 72
integer width = 411
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save Invoice"
end type

event clicked;
if dw_inv_header.rowcount() < 1 then return //(Appeon)Stephen 03.17.2017 - BugS031601 
dw_inv_header.update()
dw_inv_records.update()
of_create_log("E")

end event

type cb_inv from commandbutton within tabpage_detail
integer x = 1769
integer y = 72
integer width = 411
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Invoice"
end type

event clicked;date ld_from
date ld_to
datetime ldt_from
datetime ldt_to
datetime ldt_now
long i  //maha 03.03.2017 changed from integer
long rc  //maha 03.03.2017 changed from integer
integer res
long p
long pcnt
long rcnt
long ll_inv_id
decimal ll_total
decimal ll_tax
decimal ll_pct
string ls_types[]
datawindow ldw_inv_header

ldw_inv_header = tab_1.tabpage_detail.dw_inv_header

if  ii_facil < 1 then
	messagebox("Create Invoice Error","You must select a specific facility to create an Invoice.")
	return
end if

//set tax rate
select top 1 tax_rate into :ll_pct from inv_company;
if isnull(ll_pct) then ll_pct = 0

tab_1.tabpage_detail.dw_sets.accepttext()

if tab_1.tabpage_detail.dw_sets.getitemnumber(1,"bill_ver") = 1 then
	ls_types[1] = "V"
end if

if tab_1.tabpage_detail.dw_sets.getitemnumber(1,"bill_recur") = 1 then
	ls_types[upperbound(ls_types) + 1] = "R"
end if
	

if tab_1.tabpage_detail.dw_sets.getitemnumber(1,"bill_apps") = 1 then
	ls_types[upperbound(ls_types) + 1] = "A"
end if

if upperbound(ls_types) = 0 then 
	messagebox("Create Invoice Error","You must select at least one service type to create an Invoice.")
	return
end if	

dw_range.accepttext()

ld_from = dw_range.getitemdate(1,"from_date")
ld_to = dw_range.getitemdate(1,"to_date")

if not isnull(ld_from)  then
	//ldt_from = datetime(ld_from, time("00:00:00"))
else
	ld_from = date("01-01-2000")
end if

if not isnull(ld_to)  then
	//
else
	ld_to = date("12-31-2099")
end if

 //Start Code Change ----03.03.2017 #V153 maha
tab_1.tabpage_detail.dw_inv_header.reset()
tab_1.tabpage_detail.dw_inv_records.reset()
 //End Code Change ----03.03.2017

ldt_from = datetime(ld_from, time("00:00:00"))
ldt_to = datetime(ld_to, time("23:59:59"))
ldt_now = datetime(today(), now())
debugbreak()

dw_charge.settransobject(sqlca)
rc = dw_charge.retrieve(ii_facil, ldt_from, ldt_to, ls_types)

if rc < 1 then
	messagebox("Create Invoice","There are no Provider invoice records for Facility and Date range specified.")
	return
end if
	
ldw_inv_header.insertrow(1)
ldw_inv_header.setitem(1,"from_date", ld_from)
ldw_inv_header.setitem(1,"to_date", ld_to)
ldw_inv_header.setitem(1,"invoice_date", ldt_now)
ldw_inv_header.setitem(1,"invoice_num", "New Invoice")
ldw_inv_header.setitem(1,"facility", ii_facil)

res = ldw_inv_header.update()

if res < 1 then
	ll_inv_id = 0
	messagebox("Create Invoice","Failure to save invoice header.")
	return
end if

ll_inv_id = ldw_inv_header.getitemnumber(1, "invoice_pk")

of_create_inv_records( ii_facil, ldt_from, ldt_to, ll_inv_id)


for i = 1 to tab_1.tabpage_detail.dw_inv_records.rowcount()
	ll_total = ll_total +  tab_1.tabpage_detail.dw_inv_records.getitemnumber(i, "ext_amount")
next

ldw_inv_header.setitem(1,"sub_total", ll_total)

//calctax
//get the tax percentage from the rules
if ll_pct = 0 then
	ll_tax = 0
else
	ll_tax = ll_total * ll_pct / 100
end if

ldw_inv_header.setitem(1,"tax_amt", ll_tax)
ll_total += ll_tax

//set total
ldw_inv_header.setitem(1,"total_billed", ll_total)

ldw_inv_header.update()

of_create_log("I")

//re-retrieve
ldw_inv_header.retrieve( ll_inv_id)

tab_1.tabpage_detail.dw_inv_records.retrieve(ll_inv_id) //Added by Appeon long.zhang 03.16.2017 (Alpha id 5551 - Emailing Invoice as PDF does not include the Full Name, SaaS V15.3 Build 03082017)

dw_detail.reset()






end event

type cb_charges from commandbutton within tabpage_detail
integer x = 1271
integer y = 68
integer width = 411
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Charges"
end type

event clicked;date ld_from
date ld_to
boolean lb_ver = false
boolean lb_rec = false
boolean lb_apps = false

debugbreak()
dw_range.accepttext( )
ld_from = dw_range.getitemdate(1,"from_date")
ld_to = dw_range.getitemdate(1,"to_date")

if ii_facil = 0 then
	messagebox("Get Charges","You must specify a Facility to create charges.")
	return 
end if

if isnull(ld_from) then
	messagebox("Get Charges","You must have a date range")
	return 
end if

if isnull(ld_to) then
	messagebox("Get Charges","You must have a date range")
	return 
end if

if dw_sets.getitemnumber(1, "bill_ver") = 1 then lb_ver = true
if dw_sets.getitemnumber(1, "bill_recur") = 1 then lb_rec = true
if dw_sets.getitemnumber(1, "bill_apps") = 1 then lb_apps = true

in_invoice.of_get_charges( ii_facil, ld_from,  ld_to, lb_ver , lb_rec, lb_apps, 0)
end event

type dw_sets from datawindow within tabpage_detail
integer x = 41
integer y = 80
integer width = 1198
integer height = 72
integer taborder = 20
string title = "none"
string dataobject = "d_facility_billing_set"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type gb_2 from groupbox within tabpage_detail
integer x = 23
integer y = 16
integer width = 1239
integer height = 156
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Service Types"
end type

type dw_detail from u_dw within tabpage_detail
integer y = 192
integer width = 4133
integer height = 1928
integer taborder = 30
string dataobject = "d_invoice_print"
boolean hscrollbar = true
end type

event buttonclicked;call super::buttonclicked;integer i

for i = 1 to this.rowcount()
	this.setitem(i,"selected",1)
next
end event

event clicked;//
//Integer li_row
//
//li_row = This.GetClickedRow( )
//
//IF li_row < 1 THEN
//	Return
//END IF
//
//
//This.ScrollToRow( li_row )
//This.SetRow( li_row )
////this.selectrow(0,false)
////this.selectrow(li_row,true)
//
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;
//long ll_core
//integer li_row
//integer li_end
//
//if this.rowcount() > 0 then
//	tab_1.selecttab (2)
//	
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//IF tab_1.tabpage_detail.dw_detail.RowCount() >= currentrow THEN
	//tab_1.tabpage_detail.dw_detail.SetRow( currentrow )
	//tab_1.tabpage_detail.dw_detail.ScrollToRow( currentrow )
//END IF
//this.selectrow(0,false)
//this.selectrow(this.getrow(),true)

//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_deleterow;
integer res

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	this.deleterow(this.getrow())
end if

this.update()

return 0
end event

type cb_refresh from commandbutton within w_invoice_view
integer x = 2967
integer y = 80
integer width = 434
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh Invoices"
end type

event clicked;string ls_syntax
string ls_org_syntax
string ls_temp
string ls_where
string ls_date
string ls_stype
string ls_val
string ls_from
string ls_to
long rc
 date ld_from
date ld_to
integer r
datawindow ldw_search
u_dw dw_dates

dw_dates = dw_range
ldw_search = tab_1.tabpage_browse.dw_browse
ldw_search.settransobject( sqlca)
ls_org_syntax = ldw_search.getsqlselect( )
ls_syntax = ls_org_syntax

ls_where = " AND "

 //set date range
dw_dates.accepttext()
ld_from  = dw_dates.getitemdate(1,"from_date")
ld_to  = dw_dates.getitemdate(1,"to_date")

if not isnull(ld_from) then
	ls_from = String(ld_from, 'yyyy-mm-dd' ) 
	ls_date = " convert(datetime,  convert( varchar, invoice_date,102) )  >= '" + ls_from + "' and "
//	ls_date = " add_date >= date('" + string(ld_from) + "') and "
end if

if not isnull(ld_to) then
	ls_to = String(ld_to , 'yyyy-mm-dd' ) 
	ls_date+=  " convert(datetime,  convert( varchar, invoice_date,102) )  <= '" + ls_to  + "' and "
end if

ls_where+= ls_date

 //set_facility
 if ii_facil > 0 then
	ls_temp = " facility = " + string( ii_facil)  + " and "
	ls_where+= ls_temp
end if
 
//set final
ls_syntax+= ls_where
ls_syntax = mid(ls_syntax, 1, len(ls_syntax) - 5)

 ldw_search.setsqlselect(ls_syntax )
 
rc =  ldw_search.retrieve()
// messagebox(string(rc),ls_syntax)
 ldw_search.setsqlselect(ls_org_syntax ) 
 
 if rc > 0 then ldw_search.selectrow( 1,true)

if tab_1.selectedtab <> 1 then
	tab_1.selecttab( 1)
end if

end event

type dw_range from u_dw within w_invoice_view
integer x = 919
integer y = 84
integer width = 1467
integer height = 88
integer taborder = 110
string dataobject = "d_date_range_get_blue"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type dw_facility from datawindow within w_invoice_view
integer x = 55
integer y = 80
integer width = 814
integer height = 84
integer taborder = 60
string dataobject = "d_facility_users_batch"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facil = integer(data)
tab_1.tabpage_detail.dw_sets.retrieve(ii_facil)



end event

type cb_close from commandbutton within w_invoice_view
integer x = 3913
integer y = 80
integer width = 247
integer height = 84
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

type gb_f from groupbox within w_invoice_view
integer x = 18
integer y = 8
integer width = 873
integer height = 184
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility"
end type

type gb_1 from groupbox within w_invoice_view
integer x = 914
integer y = 8
integer width = 2039
integer height = 184
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Invoice Date Range"
end type

type cb_help from commandbutton within w_invoice_view
integer x = 2793
integer y = 88
integer width = 123
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;//openwithparm(w_help_window,1)
string s

s = "The Date range is used for several functions:~n  For Invoice searching it searches based on the invoice date.~n~n For Charge creation, it defines the date range of records used for the charges; recurring charges will be set with the To Date value. "

Messagebox("Date Range", s)
end event

type dw_charge from datawindow within w_invoice_view
boolean visible = false
integer x = 3365
integer y = 16
integer width = 160
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_invoice_items_range"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

