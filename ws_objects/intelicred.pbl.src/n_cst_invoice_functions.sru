$PBExportHeader$n_cst_invoice_functions.sru
forward
global type n_cst_invoice_functions from nonvisualobject
end type
end forward

global type n_cst_invoice_functions from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_delete_recent (string as_filename, boolean ab_fullpath)
public function integer of_get_charges (long al_facility, date ad_from, date ad_to, boolean ab_ver, boolean ab_rec, boolean ab_apps, long al_prac)
end prototypes

public function integer of_delete_recent (string as_filename, boolean ab_fullpath);//////////////////////////////////////////////////////////////////////
// Function: of_delete_recent()
// Arguments:
// 	value    string    as_filename
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-05-24
//--------------------------------------------------------------------
// Description: Delete the Windows Recent Document.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Integer li_ret,i
string ls_recent_path

oleobject lole_shell,lole_folder
lole_shell = Create oleobject
//lole_folder = Create oleobject

li_ret = lole_shell.connecttonewobject( "Wscript.Shell")

lole_folder = lole_shell.SpecialFolders
ls_recent_path = String(lole_folder.item(13)) //Recent

If isvalid(lole_shell) Then Destroy lole_shell
If isvalid(lole_folder) Then Destroy lole_folder

If ab_fullpath Then
	as_filename = Mid(as_filename,lastpos(as_filename,'\') + 1 ,Len(as_filename))
End If

If FileExists(ls_recent_path + '\' + as_filename + '.lnk') Then
	If FileDelete(ls_recent_path + '\' + as_filename + '.lnk') Then
		Return 1
	Else
		Return -1
	End If
Else
	Return -2 //Not Exists
End If

Return 1
end function

public function integer of_get_charges (long al_facility, date ad_from, date ad_to, boolean ab_ver, boolean ab_rec, boolean ab_apps, long al_prac);//Start Code Change ----08.24.2016 #V153 maha - added for creation of invoice charges
// ii_facil, ld_from,  ld_to, true, false, false)
decimal ll_fee
long v
long vc = 0
long r
long rc = 0
long a
long ac = 0
long nr
long ll_find
long ll_id
long ll_inv
long ll_cnt
long ll_recid
long ll_prac
long ll_pracs[]
long ll_act
long ll_app
long ll_status
string ls_ref
string ls_filter
string ls_doc_id
string ls_sql
string ls_sql_org
string ls_where
string ls_crit
string ls_from_date
string ls_to_date
datetime ld_charge
datetime ldt_from
datetime ldt_to
datetime ldt_now
integer res
integer rcnt
integer li_rules
n_ds lds_ver
n_ds lds_rec
n_ds lds_apps
n_ds lds_charge
n_ds lds_rules


ldt_from = datetime(ad_from, time("00:00:00"))
ls_from_date = of_date_to_string(ldt_from, "yyyy-mm-dd")
ls_from_date = ls_from_date + " 00:00:00"
ldt_to = datetime(ad_to, time("23:59:59"))
ls_to_date = of_date_to_string(ldt_to, "yyyy-mm-dd")
ls_to_date = ls_to_date + " 23:59:59"
ldt_now = datetime(today(), now())
debugbreak()
ll_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Complete') + "'"))	



//lds_charge = dw_charge
lds_charge = create n_ds
lds_charge.dataobject = "d_invoice_items_create"
lds_charge.settransobject(sqlca)


//delete existing
rc = lds_charge.retrieve(al_facility, date(ldt_from), date(ldt_to))
if rc > 0 then
	r = messagebox("Create Charges", "There are " + string(rc) + " existing charge records for the selected facilty and date range.  Do you wish to delete the records and create new ones based on the current data?", question!, yesno!,1)
	if r = 2 then 
		destroy lds_charge
		return 0
	else
		for v = rc to 1 step -1
			lds_charge.deleterow(1)
		next
		lds_charge.update()
	end if
end if

//get rules
lds_rules = create n_ds
lds_rules.dataobject = "d_facility_bill_browse"
lds_rules.settransobject(sqlca)
lds_rules.retrieve(al_facility)

//VERIFICATION charges
if ab_ver then
	lds_ver = create n_ds
	lds_ver.dataobject = "d_invoice_charge_ver"
	lds_ver.settransobject(sqlca)
	vc = lds_ver.retrieve( ldt_from, ldt_to, al_facility)
	if vc < 0 then 
		messagebox("of_get_charges","Verification record failed.")
	end if
	
	for v = 1 to vc
		nr = lds_charge.insertrow(0)
		ll_prac = lds_ver.getitemnumber(v, "prac_id")
		ll_recid =  lds_ver.getitemnumber(v, "rec_id")
		ls_ref =  lds_ver.getitemstring(v, "reference_value")
		ll_fee = lds_ver.getitemnumber(v, "fee")
		ls_doc_id = lds_ver.getitemstring(v, "doc_id")
		ld_charge = lds_ver.getitemdatetime(v, "date_recieved")
		
		lds_charge.setitem(nr, "prac_id", ll_prac)
		lds_charge.setitem(nr, "facility_id", al_facility)
		lds_charge.setitem(nr, "ref_number", ll_recid)
		lds_charge.setitem(nr, "billing_item", ls_ref)
		lds_charge.setitem(nr, "quantity", 1)
		lds_charge.setitem(nr, "price", ll_fee)
		lds_charge.setitem(nr, "rec_id", ll_recid)
		lds_charge.setitem(nr, "doc_id", ls_doc_id)
		lds_charge.setitem(nr, "charge_date", ld_charge)
		lds_charge.setitem(nr, "add_date", today())
		lds_charge.setitem(nr, "add_user", gs_user_id)
		lds_charge.setitem(nr, "charge_type", "V")
		
	next	
end if

//RECURRING
if ab_rec then
	ls_filter = "bill_type = 'R' and active_status = 1"
	res = lds_rules.setfilter(ls_filter)
	if res < 0 then 
		messagebox("Recurring filter failed", ls_filter)
		//---------Begin Added by (Appeon)Stephen 02.24.2017 for BugS022001--------
		if isvalid(lds_rules) then destroy lds_rules
		if isvalid(lds_charge) then destroy lds_charge
		if isvalid(lds_ver) then destroy lds_ver
		return -1 
		//---------End Added ------------------------------------------------------
	end if
	lds_rules.filter()
	rcnt = lds_rules.rowcount()
	
	lds_rec = create n_ds
	lds_rec.dataobject = "d_invoice_charge_recur"
	lds_rec.settransobject(sqlca)
	
	if rcnt > 0 then
		for li_rules = 1 to rcnt
			ls_sql_org = lds_rec.GetSQLSelect()
			ls_sql = ls_sql_org
			ls_crit  = lds_rules.getitemstring(li_rules, "provider_criteria")
			ls_where = " and (pd_affil_stat.parent_facility_id = " + string(al_facility) + ") and "
			if al_prac > 0 then ls_where = " and (pd_affil_stat.prac_id = " + string(al_prac) + ") and "  //single provider
			if isnull(ls_crit) or ls_crit = "" then
				ls_where+= " (pd_affil_stat.active_status in (1,4) )"
			else
				ls_where+= ls_where
			end if
			
			 //Start Code Change ----03.15.2017 #V153 maha
//			ls_sql+= ls_crit
			ls_sql+= ls_where
			 //End Code Change ----03.15.2017
			
			
			lds_rec.SetSQLSelect(ls_sql)
			lds_rec.settransobject(sqlca)
			rc = lds_rec.retrieve()
			if rc < 0 then
				messagebox("Recurring retrieval failed", ls_sql)
				//---------Begin Added by (Appeon)Stephen 02.24.2017 for BugS022001--------
				if isvalid(lds_rules) then destroy lds_rules
				if isvalid(lds_charge) then destroy lds_charge
				if isvalid(lds_ver) then destroy lds_ver
				if isvalid(lds_rec) then destroy lds_rec
				return -1 
				//---------End Added ------------------------------------------------------
			end if
			
			for r = 1 to rc
				nr = lds_charge.insertrow(0)
				ll_prac = lds_rec.getitemnumber(r, "prac_id")
				ll_recid =  lds_rec.getitemnumber(r, "rec_id")
				ls_ref  = lds_rules.getitemstring(li_rules, "description")   //Start Code Change ----03.03.2017 #V153 maha - corrected row number
				ll_fee  = lds_rules.getitemnumber(li_rules, "bill_amount")   //Start Code Change ----03.03.2017 #V153 maha - corrected row number
				//for docid get rec id and prac id
				ls_doc_id = string(ll_recid) + "-" + string(ll_prac)
				
				lds_charge.setitem(nr, "prac_id", ll_prac)
				lds_charge.setitem(nr, "facility_id", al_facility)
				lds_charge.setitem(nr, "ref_number", ll_recid)
				lds_charge.setitem(nr, "billing_item", ls_ref)
				lds_charge.setitem(nr, "quantity", 1)
				lds_charge.setitem(nr, "price", ll_fee)
				lds_charge.setitem(nr, "rec_id", ll_recid)
				lds_charge.setitem(nr, "doc_id", ls_doc_id)
				lds_charge.setitem(nr, "charge_date", ad_to )
				lds_charge.setitem(nr, "add_date", today())
				lds_charge.setitem(nr, "add_user", gs_user_id)
				lds_charge.setitem(nr, "charge_type", "R")
			next
			
			lds_rec.SetSQLSelect(ls_sql_org)
			lds_rec.settransobject(sqlca)
		next
	end if

end if


//APPLICATION charges
if ab_apps then
	lds_apps = create n_ds
	lds_apps.dataobject = "d_invoice_charge_apps"
	lds_apps.settransobject(sqlca)

	ls_filter = "bill_type = 'A' and active_status = 1"
	res = lds_rules.setfilter(ls_filter)
	if res < 0 then 
		messagebox("Recurring filter failed", ls_filter)
		//---------Begin Added by (Appeon)Stephen 02.24.2017 for BugS022001--------
		if isvalid(lds_rules) then destroy lds_rules
		if isvalid(lds_charge) then destroy lds_charge
		if isvalid(lds_ver) then destroy lds_ver
		if isvalid(lds_rec) then destroy lds_rec
		if isvalid(lds_apps) then destroy lds_apps
		return -1 
		//---------End Added ------------------------------------------------------
	end if
	lds_rules.filter()
	rcnt = lds_rules.rowcount()
	
	if rcnt > 0 then
		for li_rules = 1 to rcnt
			ls_sql_org = lds_apps.GetSQLSelect()
			ls_sql = ls_sql_org
			ls_crit  = lds_rules.getitemstring(li_rules, "provider_criteria")
			ll_act = lds_rules.getitemnumber(li_rules, "action_type_id")
			ll_app = lds_rules.getitemnumber(li_rules, "app_id")
			if isnull(ll_act) then
				messagebox("Application rules setup error","For an Application type billing rule there is no action type selected.  Skipping charge creation for this step")
				Continue
			end if
					
			ls_where = " and ( pd_affil_stat.parent_facility_id = " + string(al_facility) + ")"
			if al_prac > 0 then ls_where = " and (pd_affil_stat.prac_id = " + string(al_prac) + ") and "  //single provider
			ls_where+= " and  ( net_dev_action_items.action_status =  " + string(ll_status) + " ) and "
			if isnull(ls_crit) or ls_crit = "" then
				ls_where+= " ( pd_affil_stat.active_status in (1,4) )"
			else
				ls_where+= ls_where
			end if
			
			ls_where+= " and ( net_dev_action_items.action_type = " + string(ll_act) + ") "
			
			if ll_app > 0 then
				ls_where+= " and  (net_dev_action_items.app_id = " + string(ll_app) + ") "
			end if
			
			//set date range			
       	 	ls_where+= " and  ( net_dev_action_items.action_date >= '" + ls_from_date + "' ) "
        		ls_where+= " and  ( net_dev_action_items.action_date <= '" +  ls_to_date  + "' ) "			
			
			ls_sql+= ls_where
			
			lds_apps.SetSQLSelect(ls_sql)
			lds_apps.settransobject(sqlca)
			ac = lds_apps.retrieve()
			if ac < 0 then
				messagebox("Applications retrieval failed", ls_sql)
				clipboard(ls_sql)
				//---------Begin Added by (Appeon)Stephen 02.24.2017 for BugS022001--------
				if isvalid(lds_rules) then destroy lds_rules
				if isvalid(lds_charge) then destroy lds_charge
				if isvalid(lds_ver) then destroy lds_ver
				if isvalid(lds_rec) then destroy lds_rec
				if isvalid(lds_apps) then destroy lds_apps
				return -1 
				//---------End Added ------------------------------------------------------
			end if
			//messagebox("Application retrieval", ls_sql)
			//clipboard(ls_sql)
			
			for a = 1 to ac
				nr = lds_charge.insertrow(0)
				ll_prac = lds_apps.getitemnumber(a, "prac_id")
				ll_recid =  lds_apps.getitemnumber(a, "rec_id")
				ls_ref  = lds_rules.getitemstring(li_rules, "description")   //Start Code Change ----03.03.2017 #V153 maha - corrected row number
				ll_fee  = lds_rules.getitemnumber(li_rules, "bill_amount")   //Start Code Change ----03.03.2017 #V153 maha - corrected row number
				//for docid get rec id and prac id
				ls_doc_id =  lds_apps.getitemstring(a, "doc_id")
				ld_charge = lds_apps.getitemdatetime(a, "action_date")
				
				lds_charge.setitem(nr, "prac_id", ll_prac)
				lds_charge.setitem(nr, "facility_id", al_facility)
				lds_charge.setitem(nr, "ref_number", ll_recid)
				lds_charge.setitem(nr, "billing_item", ls_ref)
				lds_charge.setitem(nr, "quantity", 1)
				lds_charge.setitem(nr, "price", ll_fee)
				lds_charge.setitem(nr, "rec_id", ll_recid)
				lds_charge.setitem(nr, "doc_id", ls_doc_id)
				lds_charge.setitem(nr, "charge_date", ld_charge)
				lds_charge.setitem(nr, "add_date", today())
				lds_charge.setitem(nr, "add_user", gs_user_id)
				lds_charge.setitem(nr, "charge_type", "A")
			next
			
			lds_apps.SetSQLSelect(ls_sql_org)
			lds_apps.settransobject(sqlca)
		next
	end if

end if


//set the item ids	
//,"invt_id"	
if lds_charge.rowcount() > 0 then //(Appeon)Stephen 02.25.2017 - BugS022001
	select max(item_id) into :ll_id from pd_inv_rows;
	if isnull(ll_id) then ll_id = 0
	
	vc = lds_charge.rowcount()
	for r = 1 to vc
		ll_id++
		lds_charge.setitem(r, "item_id", ll_id)
	next

	v = lds_charge.update()
end if

if v < 1 then 
	messagebox("Invoice Charges" , "Charge creation failed")
else
	messagebox("Invoice Charges" , string(vc) + " charge records created.")
end if



if isvalid(lds_ver) then destroy lds_ver
if isvalid(lds_rec) then destroy lds_rec
if isvalid(lds_apps) then destroy lds_apps
if isvalid(lds_charge) then destroy lds_charge
if isvalid(lds_rules) then destroy lds_rules

return 1
end function

on n_cst_invoice_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_invoice_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

